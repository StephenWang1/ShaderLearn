---高级回收页控制
---@class UIHighRecyclePageCtrl:UIBagPageCtrl
local UIHighRecyclePageCtrl = {}

setmetatable(UIHighRecyclePageCtrl, luaComponentTemplates.UIBagPageCtrl)

---获取格子物品对应的控制器
---@private
---@return UIHighRecycleGrid
function UIHighRecyclePageCtrl:GetGridController(gridGO)
    if self.mGridCtrls == nil then
        self.mGridCtrls = {}
    end
    local temp = self.mGridCtrls[gridGO]
    if temp == nil then
        temp = templatemanager.GetNewTemplate(gridGO, luaComponentTemplates.UIHighRecycleGrid, self:GetBagPanel(), self:GetBagPanel():GetBagInteraction(), self.mGetGridPrefabFunction)
        self.mGridCtrls[gridGO] = temp
    end
    return temp
end

function UIHighRecyclePageCtrl:RefreshGridWithBagItemInfo(gridGO, bagItemInfo, itemInfo, isLocked)
    --[[
    if gridGO then
        local template = self:GetGridController(gridGO)
        if template then
            template:RefreshWithInfo(bagItemInfo, itemInfo, isLocked)
            if bagItemInfo then
                self:GetPageBagItems()[bagItemInfo.lid] = template
            end
        end
    end
    --]]
    if gridGO then
        if bagItemInfo and bagItemInfo.IsServerData then
            local template = self:GetGridController(gridGO)
            if template then
                template:RefreshServerItem(bagItemInfo, isLocked)
            end
        else
            self:RunBaseFunction("RefreshGridWithBagItemInfo", gridGO, bagItemInfo, itemInfo, isLocked)
        end
    end
end

return UIHighRecyclePageCtrl