---物品信息界面(炼化)
---@class 炼化物品信息展示界面:物品信息界面
local UIItemRefineInfoPanel = {}

setmetatable(UIItemRefineInfoPanel, luaPanelModules.UIItemInfoPanel)

function ondestroy()
    UIItemRefineInfoPanel:OnDestroy()
end

return UIItemRefineInfoPanel