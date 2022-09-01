local UIZhuFuYouPanel = {}

--region 局部变量

--endregion

---@return UISprite 背景
function UIZhuFuYouPanel:GetBgSprite_UISprite()
    if self.mBgSprite == nil then
        self.mBgSprite = self:GetCurComp("WidgetRoot/window/background/bg", "UISprite")
    end
    return self.mBgSprite
end

--region 初始化

function UIZhuFuYouPanel:Init()
    self:InitComponents()
    self:AddCollider()
    UIZhuFuYouPanel.BindUIEvents()
    UIZhuFuYouPanel.BindNetMessage()
    UIZhuFuYouPanel.InitOther()
end

---@param tabel data
---{
---@field data.equipInfo
---@field data.bagItemInfo
---@field data.equipIndex
---}
function UIZhuFuYouPanel:Show(data)
    if data then
        UIZhuFuYouPanel.targetInfo = data.equipInfo
        UIZhuFuYouPanel.targetIndex = data.equipIndex
        UIZhuFuYouPanel.needLid = data.bagItemInfo.lid
        UIZhuFuYouPanel.needItemInfo = data.bagItemInfo.ItemTABLE
        UIZhuFuYouPanel.RefreshUI()
    end
end

--- 初始化组件
function UIZhuFuYouPanel:InitComponents()
    ---@type Top_UILabel  title
    UIZhuFuYouPanel.title = self:GetCurComp("WidgetRoot/view/title", "Top_UILabel")
    ---@type Top_UISprite  icon
    UIZhuFuYouPanel.targetIcon = self:GetCurComp("WidgetRoot/view/Icon", "Top_UISprite")
    ---@type Top_UILabel  装备幸运值
    UIZhuFuYouPanel.lucky = self:GetCurComp("WidgetRoot/view/blessing", "Top_UILabel")
    ---@type Top_UILabel  当前祝福油 n/1
    UIZhuFuYouPanel.num = self:GetCurComp("WidgetRoot/view/singleprice/num", "Top_UILabel")
    ---@type Top_UILabel  祝福油名称 诅咒油
    UIZhuFuYouPanel.needItemName = self:GetCurComp("WidgetRoot/view/singleprice/needItem", "Top_UILabel")
    ---@type Top_UISprite  祝福油icon 诅咒油
    UIZhuFuYouPanel.needIcon = self:GetCurComp("WidgetRoot/view/singleprice/needItem/icon", "Top_UISprite")
    ---@type UnityEngine.GameObject  关闭按钮
    UIZhuFuYouPanel.btn_close = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    ---@type UnityEngine.GameObject  使用按钮
    UIZhuFuYouPanel.btn = self:GetCurComp("WidgetRoot/events/btn", "GameObject")
    ---@type UnityEngine.GameObject  成功特效
    UIZhuFuYouPanel.successEffect = self:GetCurComp("WidgetRoot/window/background/bg/success", "GameObject")
    ---@type UnityEngine.GameObject  失败特效
    UIZhuFuYouPanel.loseEffect = self:GetCurComp("WidgetRoot/window/background/bg/lose", "GameObject")
end

function UIZhuFuYouPanel.BindUIEvents()
    --点击关闭事件
    CS.UIEventListener.Get(UIZhuFuYouPanel.btn_close).onClick = UIZhuFuYouPanel.OnClickbtn_close
    --点击使用事件
    CS.UIEventListener.Get(UIZhuFuYouPanel.btn).onClick = UIZhuFuYouPanel.OnClickbtn
    --点击物品icon事件
    CS.UIEventListener.Get(UIZhuFuYouPanel.targetIcon.gameObject).onClick = UIZhuFuYouPanel.OnClickIcon
end

function UIZhuFuYouPanel.BindNetMessage()
    UIZhuFuYouPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCommonMessage, UIZhuFuYouPanel.OnResCommonMessage)
end

function UIZhuFuYouPanel.InitOther()
    UIZhuFuYouPanel.targetInfo = nil
    UIZhuFuYouPanel.needItemInfo = nil
    UIZhuFuYouPanel.targetIndex = 0
    UIZhuFuYouPanel.needLid = 0
end

--endregion

--region 函数监听
--点击按钮函数
---@param go UnityEngine.GameObject
function UIZhuFuYouPanel.OnClickbtn(go)
    if UIZhuFuYouPanel.curCount == 0 then
        Utility.ShowPopoTips(go, nil, 242)
        return
    end
    networkRequest.ReqUseItem(1, UIZhuFuYouPanel.needLid, 0)
end

--点击关闭函数
---@param go UnityEngine.GameObject
function UIZhuFuYouPanel.OnClickbtn_close(go)
    uimanager:ClosePanel('UIZhuFuYouPanel')
end

--点击icon函数
---@param go UnityEngine.GameObject
function UIZhuFuYouPanel.OnClickIcon(go)
    if UIZhuFuYouPanel.targetInfo == nil then
        return
    end
    uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = UIZhuFuYouPanel.targetInfo, showRight = false })
end

--endregion


--region 网络消息处理

function UIZhuFuYouPanel.OnResCommonMessage(msgId, serverData)
    if serverData then
        if serverData.data == nil then
            return
        end
        if serverData.type == luaEnumRspServerCommonType.UseLuckOilCallBack or serverData.type == luaEnumRspServerCommonType.UseCurseWaterCallBack then
            UIZhuFuYouPanel.RefershTargetItemData()
            UIZhuFuYouPanel.RefreshUI()
            if serverData.data ~= 4 then
                UIZhuFuYouPanel.PlayerEffect(serverData.data == 1)
            else
                if UIZhuFuYouPanel.btn then
                    Utility.ShowPopoTips(UIZhuFuYouPanel.btn, nil, serverData.type == luaEnumRspServerCommonType.UseLuckOilCallBack and 243 or 245)
                end
            end
        end
    end
end

--endregion

--region UI

function UIZhuFuYouPanel.RefreshUI()
    UIZhuFuYouPanel.RefreshNeedItemView()
    UIZhuFuYouPanel.RefreshTargetItemView()
end

function UIZhuFuYouPanel.RefreshNeedItemView()
    if UIZhuFuYouPanel.needItemInfo == nil then
        return
    end
    UIZhuFuYouPanel.needIcon.spriteName = UIZhuFuYouPanel.needItemInfo.icon
    UIZhuFuYouPanel.needItemName.text = UIZhuFuYouPanel.needItemInfo.name
    UIZhuFuYouPanel.curCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(UIZhuFuYouPanel.needItemInfo.id)
    local color = luaEnumColorType.White
    if UIZhuFuYouPanel.curCount > 1 then
        color = luaEnumColorType.Green
    end
    UIZhuFuYouPanel.num.text = color .. tostring(UIZhuFuYouPanel.curCount) .. '[-]/1'
end

function UIZhuFuYouPanel.RefreshTargetItemView()
    if UIZhuFuYouPanel.targetInfo == nil or UIZhuFuYouPanel.targetInfo.ItemTABLE == nil or UIZhuFuYouPanel.needItemInfo == nil then
        return
    end
    if UIZhuFuYouPanel.needItemInfo.subType == 9 then
        UIZhuFuYouPanel.title.text = '提升' .. UIZhuFuYouPanel.targetInfo.ItemFullName .. '幸运'
        UIZhuFuYouPanel.lucky.text = luaEnumColorType.Green .. '幸运值' .. UIZhuFuYouPanel.targetInfo.luck .. '[-]'
    else
        UIZhuFuYouPanel.title.text = '提升' .. UIZhuFuYouPanel.targetInfo.ItemFullName .. '诅咒'
        UIZhuFuYouPanel.lucky.text = luaEnumColorType.Red .. '诅咒值' .. UIZhuFuYouPanel.targetInfo.curse .. '[-]'
    end
    UIZhuFuYouPanel.targetIcon.spriteName = UIZhuFuYouPanel.targetInfo.ItemTABLE.icon

    --设置背景
    local icon = ternary(UIZhuFuYouPanel.needItemInfo.subType == 9, "zhufuyou", "zuzhouyou")
    if not CS.StaticUtility.IsNull(UIZhuFuYouPanel:GetBgSprite_UISprite()) then
        UIZhuFuYouPanel:GetBgSprite_UISprite().spriteName = icon
    end
end

--endregion

--region otherFunction

function UIZhuFuYouPanel.RefershTargetItemData()
    UIZhuFuYouPanel.targetInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipIndex(UIZhuFuYouPanel.targetIndex)

    UIZhuFuYouPanel.needLid = CS.CSScene.MainPlayerInfo.BagInfo:GetMeetOilLid(UIZhuFuYouPanel.needLid, UIZhuFuYouPanel.needItemInfo)
end

function UIZhuFuYouPanel.PlayerEffect(isSuccess)
    if isSuccess then
        UIZhuFuYouPanel.successEffect:SetActive(false)
        UIZhuFuYouPanel.successEffect:SetActive(true)
    else
        UIZhuFuYouPanel.loseEffect:SetActive(false)
        UIZhuFuYouPanel.loseEffect:SetActive(true)
    end
end

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResCommonMessage, UIZhuFuYouPanel.OnResCommonMessage)
end

--endregion

return UIZhuFuYouPanel