--- DateTime: 2021/04/25 10:18
--- Description 

---@class UIPromptInviteCodePanel:UIPromptInviteCodePanelBase
local UIPromptInviteCodePanel = {}

setmetatable(UIPromptInviteCodePanel, luaPanelModules.UIPromptInviteCodePanelBase)

--region parameters
--endregion

--region Init
--endregion

--region public methods
---复制邀请码
function UIPromptInviteCodePanel:ShowInvitationCode()
    luaclass.UIRefresh:RefreshLabel(self.lb_inputLabel, uiStaticParameter.invitationCode)
end
--endregion

--region private methods
--endregion

--region bind event
--endregion

--region destroy
function ondestroy()
end
--endregion

return UIPromptInviteCodePanel