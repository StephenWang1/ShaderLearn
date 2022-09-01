local UISendFlowerRandomPanel = {}

--region 局部变量
UISendFlowerRandomPanel.flowerInfo = nil
UISendFlowerRandomPanel.flowerTabelInfo = nil
--endregion

--region 初始化

function UISendFlowerRandomPanel:Show(data)
    if data then
        UISendFlowerRandomPanel.flowerInfo = data.bagInfo
        UISendFlowerRandomPanel.flowerTabelInfo = data.tabelInfo
        UISendFlowerRandomPanel.InitUI()
    end
end

function UISendFlowerRandomPanel:Init()
    self:InitComponents()
    UISendFlowerRandomPanel.BindUIEvents()
    --UISendFlowerRandomPanel.BindNetMessage()
end

--- 初始化组件
function UISendFlowerRandomPanel:InitComponents()
    ---@type Top_UISprite  icon
    UISendFlowerRandomPanel.icon = self:GetCurComp("WidgetRoot/view/UIItem/icon", "Top_UISprite")
    ---@type UnityEngine.GameObject 关闭按钮
    UISendFlowerRandomPanel.close = self:GetCurComp("WidgetRoot/events/close", "GameObject")
    ---@type UnityEngine.GameObject 赠送按钮
    UISendFlowerRandomPanel.CenterBtn = self:GetCurComp("WidgetRoot/events/CenterBtn", "GameObject")
    ---@type Top_UILabel 文本 赠送
    UISendFlowerRandomPanel.dec = self:GetCurComp("WidgetRoot/view/dec", "Top_UILabel")
end

function UISendFlowerRandomPanel.BindUIEvents()
    --点击icon事件
    CS.UIEventListener.Get(UISendFlowerRandomPanel.icon.gameObject).onClick = UISendFlowerRandomPanel.OnClickicon
    --点击关闭事件
    CS.UIEventListener.Get(UISendFlowerRandomPanel.close).onClick = UISendFlowerRandomPanel.OnClickclose
    --点击赠送事件
    CS.UIEventListener.Get(UISendFlowerRandomPanel.CenterBtn).onClick = UISendFlowerRandomPanel.OnClickCenterBtn
end

function UISendFlowerRandomPanel.BindNetMessage()
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.UISendFlowerRandomPanel, MessageCallback)
end
--endregion

--region 函数监听

--点击icon函数
---@param go UnityEngine.GameObject
function UISendFlowerRandomPanel.OnClickicon(go)
end

--点击关闭函数
---@param go UnityEngine.GameObject
function UISendFlowerRandomPanel.OnClickclose(go)
    uimanager:ClosePanel('UISendFlowerRandomPanel')
end

--点击赠送函数
---@param go UnityEngine.GameObject
function UISendFlowerRandomPanel.OnClickCenterBtn(go)
    if UISendFlowerRandomPanel.flowerInfo ~= nil then
        networkRequest.FatePeople(UISendFlowerRandomPanel.flowerInfo.lid, 1)
        uimanager:ClosePanel('UISendFlowerRandomPanel')
    end
end

--endregion

--region 网络消息处理

--endregion

--region UI

function UISendFlowerRandomPanel.InitUI()
    if UISendFlowerRandomPanel.flowerTabelInfo == nil then
        return
    end
    UISendFlowerRandomPanel.icon.spriteName = UISendFlowerRandomPanel.flowerTabelInfo.icon
    local array = CS.Cfg_GlobalTableManager.Instance.redomSendFlowerTextArray
    if array and array.Length > 1 then
        UISendFlowerRandomPanel.dec.text = UISendFlowerRandomPanel.flowerTabelInfo.subType == luaEnumMaterialType.Rose and array[0] or array[1]
    end
end

--endregion

--region otherFunction

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.UISendFlowerRandomPanel, MessageCallback)
end

--endregion

return UISendFlowerRandomPanel