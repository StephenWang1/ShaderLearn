---背包可回收提示
---@class UIMainHint_RecycleBagItemTips:UIBasicHint
local UIMainHint_RecycleBagItemTips = {}

setmetatable(UIMainHint_RecycleBagItemTips, luaComponentTemplates.UIBasicHint)

---关闭按钮
---@return UnityEngine.GameObject
function UIMainHint_RecycleBagItemTips:GetCloseButton_GameObject()
    if self.mCloseButton_GO == nil then
        self.mCloseButton_GO = self:Get("tipPanel/btn_close", "GameObject")
    end
    return self.mCloseButton_GO
end

---提示内容文本
---@return UILabel
function UIMainHint_RecycleBagItemTips:GetTipContent_UILabel()
    if self.mTipContent_UILabel == nil then
        self.mTipContent_UILabel = self:Get("tipPanel/content", "UILabel")
    end
    return self.mTipContent_UILabel
end

---注册所有组件,包括Collider组件和TweenComponents组件,使用RegisterSingleCollider和RegisterSingleTweenComponent方法
---@protected
function UIMainHint_RecycleBagItemTips:RegisterAllComponents()
    self:RegisterSingleCollider("tipPanel/content")
    self:RegisterSingleCollider("tipPanel/btn_close")
    self:RegisterSingleTweenComponent("tipPanel")
end

function UIMainHint_RecycleBagItemTips:Init(msgClientEventHandlerManager, panel)
    self:RunBaseFunction("Init", msgClientEventHandlerManager, panel)
    ---VIP回收等级限制
    ---@type number
    self.mVIPRecycleLevelLimit = CS.Cfg_GlobalTableManager.Instance:GetVIPRecycleLevelLimit()
end

---绑定UI事件
---@protected
function UIMainHint_RecycleBagItemTips:BindUIEvents()
    CS.UIEventListener.Get(self:GetCloseButton_GameObject()).onClick = function()
        self:Close(true)
    end
    CS.UIEventListener.Get(self:GetTipContent_UILabel().gameObject).onClick = function()
        self:OnContentTipsClicked()
    end
end

---刷新数据
function UIMainHint_RecycleBagItemTips:RefreshData(content)
    self.content = content
    self:GetTipContent_UILabel().text = content
end

---获取显示的内容
function UIMainHint_RecycleBagItemTips:GetContent()
    return self.content
end

---提示内容点击事件
function UIMainHint_RecycleBagItemTips:OnContentTipsClicked()
    local vipLevel = CS.CSScene.MainPlayerInfo.VipLevel
    local vipLimit = self.mVIPRecycleLevelLimit
    if vipLevel < vipLimit then
        self:OpenBagRecyclePanelWithVIPTip(vipLimit)
    else
        self:OpenBagRecyclePanelWithoutVIPTip()
    end
    self:Close(true)
    uiStaticParameter.RecycleBubbleOnClick = true
end

---VIP等级低于回收VIP等级时,弹出提示框
---@param vipLimit number 回收vip限制等级
function UIMainHint_RecycleBagItemTips:OpenBagRecyclePanelWithVIPTip(vipLimit)
    if vipLimit == nil then
        vipLimit = 0
    end
    local data = {
        Title = "提   示",
        Content = "点击传送立即前往回收NPC处，开通VIP" .. tostring(vipLimit) .. "，随时随地回收装备！",
        LeftDescription = "传送",
        RightDescription = "开通VIP" .. tostring(vipLimit),
        IsToggleVisable = false,
        CancelCallBack = function()
            --传送到回收Npc位置，并打开背包
            if networkRequest.ReqDeliverByConfig(1002, false) then
                uimanager:CreatePanel("UIBagPanel", function(panel)
                    if (panel ~= nil) then
                        panel.PlayRecycleEffect();
                    end
                end, { type = LuaEnumBagType.Recycle })
            end
        end,
        CallBack = function()
            --打开充值窗口
            --uimanager:CreatePanel("UIMonthCardPanel", nil, LuaEnumMonthCardChildPanelType.UIRechargePanel)
        end
    }
    uimanager:CreatePanel("UIPromptPanel", nil, data)
end

---VIP等级高于回收VIP等级时,直接打开背包的回收界面
function UIMainHint_RecycleBagItemTips:OpenBagRecyclePanelWithoutVIPTip()
    Utility.OpenRecyclePanel()
end

---重新显示
---@public
---@return boolean 表示是否允许重新显示,若返回false,则直接
function UIMainHint_RecycleBagItemTips:OnReshown()
    local mRecycleHintEquipCount = CS.Cfg_GlobalTableManager.Instance:GetRecycleHintEquipCount()
    if CS.CSScene.MainPlayerInfo then
        local recycleAvailableEquipCount = CS.CSScene.MainPlayerInfo.BagInfo:GetRecycleAvailableEquipCount()
        if recycleAvailableEquipCount < mRecycleHintEquipCount then
            return false
        end
    end
    return self:GetIsOn()
end

return UIMainHint_RecycleBagItemTips