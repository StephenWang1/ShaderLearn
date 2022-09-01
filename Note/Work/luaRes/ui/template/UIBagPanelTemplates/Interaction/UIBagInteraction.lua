---背包交互中间层
---@class UIBagInteraction:UIBagTypeContainerInteraction
local UIBagInteraction = {}

setmetatable(UIBagInteraction, luaComponentTemplates.UIBagType_Interaction)

---获取背包界面
---@return UIBagPanel
function UIBagInteraction:GetBagPanel()
    return self:GetRelyPanel()
end

function UIBagInteraction:IsSingleClickedAvailable(grid, bagItemInfo, itemTbl)
    return true
end

function UIBagInteraction:IsDoubleClickedAvailable(grid, bagItemInfo, itemTbl)
    return self:GetBagPanel():GetBagMainController():IsItemDoubleClickedAvailable()
end

function UIBagInteraction:IsLongPressAvailable(grid, bagItemInfo, itemTbl)
    return true
end

function UIBagInteraction:IsDragAvailable(grid, bagItemInfo, itemTbl)
    if self:GetBagPanel() ~= nil and self:GetBagPanel():GetBagMainController() ~= nil then
        if self:GetBagPanel():GetBagMainController():IsItemDragAvailable() then
            return self:GetBagPanel():GetBagMainController():IsGridCanBeDragged(grid, bagItemInfo, itemTbl)
        end
    end
    return false
end

function UIBagInteraction:DoSingleClick(grid, bagItemInfo, itemTbl)
    if self:GetBagPanel() ~= nil and self:GetBagPanel():GetBagMainController() ~= nil then
        self:GetBagPanel():GetBagMainController():OnGridClicked(grid, bagItemInfo, itemTbl)
    end
end

function UIBagInteraction:DoDoubleClick(grid, bagItemInfo, itemTbl)
    if self:GetBagPanel() ~= nil and self:GetBagPanel():GetBagMainController() ~= nil then
        self:GetBagPanel():GetBagMainController():OnGridDoubleClicked(grid, bagItemInfo, itemTbl)
    end
end

function UIBagInteraction:DoLongPress(grid, bagItemInfo, itemTbl)
    if self:GetBagPanel() ~= nil and self:GetBagPanel():GetBagMainController() ~= nil then
        self:GetBagPanel():GetBagMainController():OnGridLongPressed(grid, bagItemInfo, itemTbl)
    end
end

function UIBagInteraction:DoStartDrag(grid, bagItemInfo, itemTbl, pos)
    if self:GetBagPanel() ~= nil and self:GetBagPanel():GetBagMainController() ~= nil then
        self:GetBagPanel():GetBagMainController():OnGridStartBeingDragged(grid, bagItemInfo, itemTbl, pos)
    end
end

function UIBagInteraction:DoBeingDragged(grid, bagItemInfo, itemTbl, pos)
    if self:GetBagPanel() ~= nil and self:GetBagPanel():GetBagMainController() ~= nil then
        self:GetBagPanel():GetBagMainController():OnGridBeingDragged(grid, bagItemInfo, itemTbl, pos)
    end
end

function UIBagInteraction:DoEndDrag(grid, bagItemInfo, itemTbl, pos, isDestroyed)
    if self:GetBagPanel() ~= nil and self:GetBagPanel():GetBagMainController() ~= nil then
        self:GetBagPanel():GetBagMainController():OnGridEndBeingDragged(grid, bagItemInfo, itemTbl, pos, isDestroyed)
    end
end

return UIBagInteraction