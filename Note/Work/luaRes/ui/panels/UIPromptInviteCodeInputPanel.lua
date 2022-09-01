--- DateTime: 2021/04/25 10:18
--- Description 

---@class UIPromptInviteCodeInputPanel:UIPromptInviteCodePanelBase
local UIPromptInviteCodeInputPanel = {}

setmetatable(UIPromptInviteCodeInputPanel, luaPanelModules.UIPromptInviteCodePanelBase)

--region parameters
--endregion

--region Init
--endregion

--region public methods
---输入邀请码
function UIPromptInviteCodeInputPanel:ShowInvitationCode()
    luaclass.UIRefresh:RefreshLabel(self.lb_inputLabel, '')
end
--endregion

--region private methods
--endregion

--region bind event
--endregion

--region destroy
--endregion

return UIPromptInviteCodeInputPanel