---@class UIMainHint_BigJuLingZhuRecommendBug:UIBasicHint
local UIMainHint_BigJuLingZhuRecommendBug = {}

setmetatable(UIMainHint_BigJuLingZhuRecommendBug, luaComponentTemplates.UIBasicHint)

---关闭按钮
---@return UnityEngine.GameObject
function UIMainHint_BigJuLingZhuRecommendBug:GetCloseButton_GameObject()
    if self.mCloseButton_GO == nil then
        self.mCloseButton_GO = self:Get("tipPanel/btn_close", "GameObject")
    end
    return self.mCloseButton_GO
end

---提示内容文本
---@return UILabel
function UIMainHint_BigJuLingZhuRecommendBug:GetTipContent_UILabel()
    if self.mTipContent_UILabel == nil then
        self.mTipContent_UILabel = self:Get("tipPanel/content", "UILabel")
    end
    return self.mTipContent_UILabel
end

---注册所有组件,包括Collider组件和TweenComponents组件,使用RegisterSingleCollider和RegisterSingleTweenComponent方法
---@protected
function UIMainHint_BigJuLingZhuRecommendBug:RegisterAllComponents()
    self:RegisterSingleCollider("tipPanel/content")
    self:RegisterSingleCollider("tipPanel/btn_close")
    self:RegisterSingleTweenComponent("tipPanel")
end

function UIMainHint_BigJuLingZhuRecommendBug:RefreshData(juLingZhuID)
    self.mJuLingZhuTbl = CS.Cfg_ItemsTableManager.Instance:GetItems(juLingZhuID)
    if self.mJuLingZhuTbl == nil then
        if isOpenLog then
            luaDebug.LogError("Items表中未找到id: " .. tostring(juLingZhuID))
        end
        self:Close(false)
        return
    end
    ---@type TABLE.CFG_PROMPTFRAME
    local tbl
    ___, tbl = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(322)
    if tbl then
        self:GetTipContent_UILabel().text = tbl.content
    else
        self:GetTipContent_UILabel().text = "有可购买的" .. tostring(self.mJuLingZhuTbl.name)
    end
end

function UIMainHint_BigJuLingZhuRecommendBug:BindUIEvents()
    CS.UIEventListener.Get(self:GetCloseButton_GameObject()).onClick = function()
        self:Close(true)
    end
    CS.UIEventListener.Get(self:GetTipContent_UILabel().gameObject).onClick = function()
        if self.mJuLingZhuTbl == nil then
            return
        end
        self:Close(true)
        ---暂时只有一个大聚灵珠,后续有增加的话再加判断
        uimanager:CreatePanel("UIShopPanel", nil, {
            type = LuaEnumStoreType.YuanBao,
            chooseStore = { 3001001 }
        })
    end
end

function UIMainHint_BigJuLingZhuRecommendBug:SetIsOn(isOn)
    self:RunBaseFunction("SetIsOn", isOn)
    uiStaticParameter.mIsBigJuLingZhuTipExist = isOn
    --print("uiStaticParameter.mIsBigJuLingZhuTipExist = isOn", isOn)
end

return UIMainHint_BigJuLingZhuRecommendBug