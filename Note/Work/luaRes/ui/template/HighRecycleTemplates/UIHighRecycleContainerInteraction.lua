---@class UIHighRecycleContainerInteraction:UIBagTypeContainerInteraction
local UIHighRecycleContainerInteraction = {}

setmetatable(UIHighRecycleContainerInteraction, luaComponentTemplates.UIBagType_Interaction)

function UIHighRecycleContainerInteraction:IsSingleClickedAvailable(grid, bagItemInfo, itemTbl)
    return true
end

function UIHighRecycleContainerInteraction:IsDoubleClickedAvailable(grid, bagItemInfo, itemTbl)
    return false
end

function UIHighRecycleContainerInteraction:IsDragAvailable(grid, bagItemInfo, itemTbl)
    return false
end

function UIHighRecycleContainerInteraction:DoSingleClick(grid, bagItemInfo, itemTbl)
    if self:GetRelyPanel() ~= nil then
        self:GetRelyPanel():OnGridClicked(grid, bagItemInfo, itemTbl)
    end
end

function UIHighRecycleContainerInteraction:DoDoubleClick(grid, bagItemInfo, itemTbl)
    if self:GetRelyPanel() ~= nil then
        self:GetRelyPanel():OnGridDoubleClicked(grid, bagItemInfo, itemTbl)
    end
end

return UIHighRecycleContainerInteraction