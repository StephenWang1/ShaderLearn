---灵兽信息界面
---@class 灵兽信息界面:UI基类cc
local UIPetInfoPanel = {}

setmetatable(UIPetInfoPanel, luaPanelModules.UIItemInfoPanel)

function ondestroy()
    UIPetInfoPanel:OnDestroy()
end

return UIPetInfoPanel