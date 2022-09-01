---@class UIRenamePanel:UIBase 改名面板
local UIRenamePanel = {}

--region params
UIRenamePanel.type = 1
UIRenamePanel.itemInfo = nil
--endregion

--region 组件
---关闭按钮
function UIRenamePanel.GetCloseButton_GameObject()
    if UIRenamePanel.mCloseButton == nil then
        UIRenamePanel.mCloseButton = UIRenamePanel:GetCurComp("WidgetRoot/events/close", "GameObject")
    end
    return UIRenamePanel.mCloseButton
end
---确定改名按钮
function UIRenamePanel.GetConfirmButton_GameObject()
    if UIRenamePanel.mConfirmButton == nil then
        UIRenamePanel.mConfirmButton = UIRenamePanel:GetCurComp("WidgetRoot/events/RightBtn", "GameObject")
    end
    return UIRenamePanel.mConfirmButton
end

---取消按钮
function UIRenamePanel.GetLeftBtn_GameObject()
    if UIRenamePanel.mLeftBtn_GameObject == nil then
        UIRenamePanel.mLeftBtn_GameObject = UIRenamePanel:GetCurComp("WidgetRoot/events/LeftBtn", "GameObject")
    end
    return UIRenamePanel.mLeftBtn_GameObject
end

---改名内容
function UIRenamePanel.GetRenameInput_UIInput()
    if UIRenamePanel.mRenameInput == nil then
        UIRenamePanel.mRenameInput = UIRenamePanel:GetCurComp("WidgetRoot/view/rename", "UIInput")
    end
    return UIRenamePanel.mRenameInput
end

---标题名字
function UIRenamePanel.GetContent_UILabel()
    if UIRenamePanel.mContent_UILabel == nil then
        UIRenamePanel.mContent_UILabel = UIRenamePanel:GetCurComp("WidgetRoot/window/Content", "UILabel")
    end
    return UIRenamePanel.mContent_UILabel
end
--endregion

--region 初始化
function UIRenamePanel:Init()
    self:BindMessages()
    self:BindEvents()
end

function UIRenamePanel:Show(itemInfo)
    if itemInfo ~= nil then
        UIRenamePanel.itemInfo = itemInfo
        if itemInfo.id == 6000006 then
            UIRenamePanel.type = luaEnumRenameType.Role
            self.GetContent_UILabel().text = "输入新的角色名称"
        elseif itemInfo.id == 6000007 then
            UIRenamePanel.type = luaEnumRenameType.Union
            self.GetContent_UILabel().text = "输入新的行会名称"
        end
    end
end

function UIRenamePanel:BindEvents()
    CS.UIEventListener.Get(UIRenamePanel.GetCloseButton_GameObject()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(UIRenamePanel.GetConfirmButton_GameObject()).onClick = UIRenamePanel.ConfirmRename
    CS.UIEventListener.Get(UIRenamePanel.GetLeftBtn_GameObject()).onClick = UIRenamePanel.CloseRenamePanel
end

function UIRenamePanel:BindMessages()
    UIRenamePanel.OnResEditNameMessageReceived = function(msgId, tblData, csData)
        self:OnOnResEditNameMessageReceivedFunc(tblData)
    end

    --  commonNetMsgDeal.BindCallback(LuaEnumNetDef.ResRandomNameMessage, UIRenamePanel.OnResRandomNameMessageReceived)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResEditNameMessage, UIRenamePanel.OnResEditNameMessageReceived)
    self:GetClientEventHandler():AddEvent(CS.CEvent.UnionNameChange, function()
        self:ClosePanel()
    end)
end
--endregion

--region 服务器事件
---@param tblData roleV2.ResEditName
function UIRenamePanel:OnOnResEditNameMessageReceivedFunc(tblData)
    if tblData.isSuccess == 1 then
        self:ClosePanel()
    else
        Utility.ShowPopoTips(UIRenamePanel.GetConfirmButton_GameObject(), tblData.reason, 208)
    end
end

--endregion

--region UI事件
---关闭界面
function UIRenamePanel.CloseRenamePanel()
    uimanager:ClosePanel("UIRenamePanel")
end
---确定改名
function UIRenamePanel.ConfirmRename(go)
    local name = UIRenamePanel.GetRenameInput_UIInput().text
    if UIRenamePanel.type == luaEnumRenameType.Role then
        if name == nil or name == "" then
            local str = "请输入角色名"
            Utility.ShowPopoTips(go, str, 208)
            return
        end
        if name == CS.CSScene.MainPlayerInfo.Name then
            local str = "请输入与当前角色名不同的名字"
            Utility.ShowPopoTips(go, str, 208)
            return
        end
        networkRequest.ReqEditName(name, 1)
    elseif UIRenamePanel.type == luaEnumRenameType.Union then
        if CS.StaticUtility.IsNullOrEmpty(name) then
            local str = "请输入行会名"
            Utility.ShowPopoTips(go, str, 208)
        end
        networkRequest.ReqChangeUnionName(tostring(name))
    end
end

---请求随机名按钮点击事件
function UIRenamePanel.OnRequestRandomNameButtonClicked()
    networkRequest.ReqRandomName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex))
end
--endregion

--region 网络事件
---随机名响应事件
function UIRenamePanel.OnResRandomNameMessageReceived(msgID, data, csData)
    UIRenamePanel.NameInput_UIInput().value = data.roleName
end

function ondestroy()
    -- commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ReqRandomNameMessage, UIRenamePanel.OnResRandomNameMessageReceived)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResEditNameMessage, UIRenamePanel.OnResEditNameMessageReceived)
end

return UIRenamePanel