
---@class UIDuoBaoQiBingPanel:UIActivityManEnterPanel
local UIDuoBaoQiBingPanel = {}

setmetatable(UIDuoBaoQiBingPanel, luaPanelModules.UIActivityManEnterPanel)

function UIDuoBaoQiBingPanel:Show()
    self:RunBaseFunction("Show")
end

function UIDuoBaoQiBingPanel:GetActivityId()
    return 575
end

function UIDuoBaoQiBingPanel:GetHelpId()
    return 223;
end

function UIDuoBaoQiBingPanel:OnCloseSelf()
    uimanager:ClosePanel("UIDuoBaoQiBingPanel");
end

function UIDuoBaoQiBingPanel:OnClickBtnEnter()
    self:RunBaseFunction("OnClickBtnEnter")
end

function ondestroy()
    UIDuoBaoQiBingPanel:OnDestroy();
end

return UIDuoBaoQiBingPanel
