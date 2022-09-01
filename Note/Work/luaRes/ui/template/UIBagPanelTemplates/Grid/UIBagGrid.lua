---背包格子基类
---@class UIBagGrid:UIBagTypeGrid
local UIBagGrid = {}

setmetatable(UIBagGrid, luaComponentTemplates.UIBagType_Grid)

function UIBagGrid:IsTiledBG()
    return true
end

function UIBagGrid:RefreshSingleGrid(bagItemInfo, itemTbl)
    ---@type UIBagPanel
    local bagPanel = self:GetRelyPanel()
    if bagPanel and bagPanel:GetBagMainController() then
        bagPanel:GetBagMainController():RefreshSingleGrid(self, bagItemInfo, itemTbl)
    else
        self:RunBaseFunction("RefreshSingleGrid", bagItemInfo, itemTbl)
    end
end

return UIBagGrid