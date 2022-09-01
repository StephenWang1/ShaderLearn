local UISendDiamondPanel = {}

--region 局部变量
UISendDiamondPanel.mCount = tonumber(CS.Cfg_GlobalTableManager.CfgInstance.SendDiamondMinCount)
--endregion

--region 组件
function UISendDiamondPanel.GetFlowerDescription_UILabel()
    if UISendDiamondPanel.mFlowerDesLabel == nil then
        UISendDiamondPanel.mFlowerDesLabel = UISendDiamondPanel:GetCurComp("WidgetRoot/view/dec", "UILabel")
    end
    return UISendDiamondPanel.mFlowerDesLabel
end

---玩家名字
function UISendDiamondPanel.GetPlayerName_UILabel()
    if UISendDiamondPanel.mPlayerNameLabel == nil then
        UISendDiamondPanel.mPlayerNameLabel = UISendDiamondPanel:GetCurComp("WidgetRoot/view/sendname", "UILabel")
    end
    return UISendDiamondPanel.mPlayerNameLabel
end

---赠送按钮
function UISendDiamondPanel.GetSendButton_GameObject()
    if UISendDiamondPanel.mSendButton == nil then
        UISendDiamondPanel.mSendButton = UISendDiamondPanel:GetCurComp("WidgetRoot/events/CenterBtn", "GameObject")
    end
    return UISendDiamondPanel.mSendButton
end

---关闭按钮
function UISendDiamondPanel.GetCloseButton_GameObject()
    if UISendDiamondPanel.mCloseButton == nil then
        UISendDiamondPanel.mCloseButton = UISendDiamondPanel:GetCurComp("WidgetRoot/events/close", "GameObject")
    end
    return UISendDiamondPanel.mCloseButton
end

function UISendDiamondPanel.GetNumButton_ChatInput()
    if UISendDiamondPanel.mNumButton_ChatInput == nil then
        UISendDiamondPanel.mNumButton_ChatInput = UISendDiamondPanel:GetCurComp("WidgetRoot/events/Chat Input", "Top_UIInput")
    end
    return UISendDiamondPanel.mNumButton_ChatInput
end

function UISendDiamondPanel.GetSendCount_UILabel()
    if (UISendDiamondPanel.mSendCount == nil) then
        UISendDiamondPanel.mSendCount = UISendDiamondPanel:GetCurComp("WidgetRoot/events/Chat Input/Label", "UILabel")
    end
    return UISendDiamondPanel.mSendCount
end
--endregion

--region 初始化
function UISendDiamondPanel:Init()
    UISendDiamondPanel:BindMessage()
    UISendDiamondPanel:BindUIEvents()
end

function UISendDiamondPanel:BindMessage()

end

function UISendDiamondPanel:BindUIEvents()
    CS.UIEventListener.Get(UISendDiamondPanel.GetCloseButton_GameObject()).onClick = UISendDiamondPanel.OnCloseButtonClicked
    CS.UIEventListener.Get(UISendDiamondPanel.GetSendButton_GameObject()).onClick = UISendDiamondPanel.OnSendButtonClicked

    self:GetNumButton_ChatInput().submitOnUnselect = true
    CS.EventDelegate.Add(self:GetNumButton_ChatInput().onSubmit, function(go)
        self:SuitableSendCount()
    end)
end

function UISendDiamondPanel:Show(name)
    self:GetPlayerName_UILabel().text = name
end
--endregion

--region 点击事件
function UISendDiamondPanel.OnCloseButtonClicked()
    uimanager:ClosePanel("UISendDiamondPanel")
end

function UISendDiamondPanel.OnSendButtonClicked()
    networkRequest.ReqGiveJewel(UISendDiamondPanel.mCount)
    uimanager:ClosePanel("UISendDiamondPanel")
end
--endregion

--region 刷新界面
function UISendDiamondPanel:SuitableSendCount()
    UISendDiamondPanel.mCount = tonumber(self.GetSendCount_UILabel().text)
    if (UISendDiamondPanel.mCount == nil) then
        self.GetSendCount_UILabel().text = CS.Cfg_GlobalTableManager.CfgInstance.SendDiamondMinCount
        UISendDiamondPanel.mCount = tonumber(CS.Cfg_GlobalTableManager.CfgInstance.SendDiamondMinCount)
        return
    end
    if (UISendDiamondPanel.mCount < CS.Cfg_GlobalTableManager.CfgInstance.SendDiamondMinCount) then
        self.GetSendCount_UILabel().text = CS.Cfg_GlobalTableManager.CfgInstance.SendDiamondMinCount
    elseif (UISendDiamondPanel.mCount > CS.Cfg_GlobalTableManager.CfgInstance.SendDiamondMaxCount) then
        self.GetSendCount_UILabel().text = CS.Cfg_GlobalTableManager.CfgInstance.SendDiamondMaxCount
    end
    UISendDiamondPanel.mCount = tonumber(self.GetSendCount_UILabel().text)
end
--endregion

function ondestroy()

end

return UISendDiamondPanel