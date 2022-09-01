local UIActivationCodePanel = {}
function UIActivationCodePanel:Init()
    self:InitComponent()
    self:BindEvents()
    self:InitParams()
    self:ShowInvitationCode()
end

function UIActivationCodePanel:InitComponent()
    self.CloseBtn = self:GetCurComp("WidgetRoot/events/Btn_Close", "GameObject")
    self.GetBtn = self:GetCurComp("WidgetRoot/events/btn_get", "GameObject")
    self.Input_UIInput = self:GetCurComp("WidgetRoot/view/Chat Input", "UIInput")
    self.go_InvitationCode = self:GetCurComp("WidgetRoot/events/btn_invitecode", "GameObject")
end

function UIActivationCodePanel:BindEvents()
    CS.UIEventListener.Get(self.CloseBtn).onClick = function()
        uimanager:ClosePanel(self)
    end
    CS.UIEventListener.Get(self.GetBtn).onClick = function(go)
        local text = self.Input_UIInput.label.text
        if CS.StaticUtility.IsNullOrEmpty(text) == true or self.defaultText == nil or self.defaultText == text then
            Utility.ShowPopoTips(go.transform, "输入内容为空", 290)
            return
        end
        networkRequest.ReqUseCDKey(text)
    end
    CS.UIEventListener.Get(self.go_InvitationCode).onClick = function()
        self:OnInvitationCode()
    end
end

function UIActivationCodePanel:InitParams()
    if self.Input_UIInput ~= nil then
        self.defaultText = self.Input_UIInput.label.text
    end
end

--region private
---设置邀请码的显隐状态
function UIActivationCodePanel:ShowInvitationCode()
    local active = false
    if (self.InvitationCodeConditions == nil) then
        local cfg_global = LuaGlobalTableDeal.GetGlobalTabl(23045)
        if (cfg_global ~= nil) then
            self.InvitationCodeConditions = string.Split(cfg_global.value, '#')
        end
    end
    if (self.InvitationCodeConditions ~= nil and #self.InvitationCodeConditions > 0) then
        active = #self.InvitationCodeConditions > 1
        for i = 1, #self.InvitationCodeConditions - 1 do
            local result = Utility.IsMainPlayerMatchCondition(tonumber(self.InvitationCodeConditions[i]))
            if (result.success == false) then
                active = false
                break
            end
        end
    end
    luaclass.UIRefresh:RefreshActive(self.go_InvitationCode, active)
end
--endregion

--region BindEvents
---邀请码点击事件
function UIActivationCodePanel:OnInvitationCode()
    ---@param panel UIPromptInviteCodePanel
    uimanager:CreatePanel("UIPromptInviteCodePanel", nil)
end
--endregion


return UIActivationCodePanel