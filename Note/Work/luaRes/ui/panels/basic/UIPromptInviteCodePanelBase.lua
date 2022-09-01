--- DateTime: 2021/04/23 16:39
--- Description 

---@class UIPromptInviteCodePanelBase:UIBase
local UIPromptInviteCodePanelBase = {}

--region parameters

--endregion

--region Init
function UIPromptInviteCodePanelBase:Init()
    self:InitComponent()
    self:InitEvent()
end

function UIPromptInviteCodePanelBase:InitComponent()
    ---
    ---@type UIInput
    self.box_InputCode = self:GetCurComp("WidgetRoot/view/Code", "BoxCollider")
    ---
    ---@type UILabel
    self.lb_inputLabel = self:GetCurComp("WidgetRoot/view/Code/Label", "UILabel")
    ---
    ---@type UILabel
    self.lb_condition = self:GetCurComp("WidgetRoot/view/condition", "UILabel")
    ---
    ---@type UnityEngine.GameObject
    self.go_LeftBtn = self:GetCurComp("WidgetRoot/events/LeftBtn", "GameObject")
    ---
    ---@type UnityEngine.GameObject
    self.go_RightBtn = self:GetCurComp("WidgetRoot/events/RightBtn", "GameObject")
    ---
    ---@type UnityEngine.GameObject
    self.go_CenterBtn = self:GetCurComp("WidgetRoot/events/CenterBtn", "GameObject")
    ---
    ---@type UnityEngine.GameObject
    self.go_close = self:GetCurComp("WidgetRoot/events/close", "GameObject")
    ---
    ---@type UnityEngine.GameObject
    self.go_helpBtn = self:GetCurComp("WidgetRoot/events/helpBtn", "GameObject")
end
--endregion

--region public methods
function UIPromptInviteCodePanelBase:Show()
    self:ShowInvitationCode()
end

function UIPromptInviteCodePanelBase:ShowInvitationCode()
end
--endregion

--region private methods
--endregion

--region bind event
function UIPromptInviteCodePanelBase:InitEvent()
    luaclass.UIRefresh:BindClickCallBack(self.go_LeftBtn, function()
        Utility.OnClickBtn_BackLogin()
        uimanager:ClosePanel(self)
    end)

    luaclass.UIRefresh:BindClickCallBack(self.go_RightBtn, function()
        self:OnRightBtn()
    end)

    luaclass.UIRefresh:BindClickCallBack(self.go_CenterBtn, function()
        CS.UnityEngine.GUIUtility.systemCopyBuffer = uiStaticParameter.invitationCode;
        uimanager:ClosePanel(self)
    end)

    luaclass.UIRefresh:BindClickCallBack(self.go_close, function()
        uimanager:ClosePanel(self)
    end)

    luaclass.UIRefresh:BindClickCallBack(self.go_helpBtn, function()
        local data = {}
        data.id = 250
        Utility.ShowHelpPanel(data)
    end)
end

function UIPromptInviteCodePanelBase:OnRightBtn()
    if (self.lb_inputLabel) then
        local str = self.lb_inputLabel.text
        if (Utility.IsNilOrEmptyString(str)) then
            CS.Utility.ShowRedTips('邀请码不能为空')
            return
        end
        uiStaticParameter.inputInvitationCode = self.lb_inputLabel.text
        networkRequest.ReqInviteCodeVerify(self.lb_inputLabel.text)
    end
end
--endregion

--region destroy
--endregion

return UIPromptInviteCodePanelBase