---@class UIActivityShabakeInformationPanel:UIActivityInformationPanel 沙巴克详细排行
local UIActivityShabakeInformationPanel = {}
setmetatable(UIActivityShabakeInformationPanel, luaPanelModules.UIActivityInformationPanel)

function UIActivityShabakeInformationPanel:Show(customData)
    self:RunBaseFunction('Show', customData)
end

function UIActivityShabakeInformationPanel:Clear()
    self:RunBaseFunction('Clear')
end

function UIActivityShabakeInformationPanel:OnClickCloseCallBack()
    uimanager:ClosePanel("UIActivityShabakeInformationPanel")
end

function ondestroy()
    UIActivityShabakeInformationPanel:Clear()
end
return UIActivityShabakeInformationPanel