---仓库页控制器
---@class UIWareHousePanel_PageController:TemplateBase
local UIWareHousePanel_PageController = {}

---获取格子容器
---@return UIGridContainer
function UIWareHousePanel_PageController:GetGridContainers()
    if self.mGridContainer == nil then
        self.mGridContainer = self:Get("UIGridItem", "UIGridContainer")
    end
    return self.mGridContainer
end

---@param wareHousePanel UIPlayerWarehousePanel
function UIWareHousePanel_PageController:Init(wareHousePanel)
    self.mWareHousePanel = wareHousePanel
    self.mFetchPrefabMethod = function(compName)
        return self.mWareHousePanel.FetchComponentPrefab(compName)
    end
end

---刷新仓库页
---@param storageItemList userdata 仓库物品列表
---@param pageIndex number 页索引
---@param gridCountPerPage number 每页格子数量
---@param maxGridCount number 最大格子数量
function UIWareHousePanel_PageController:RefreshPage(storageItemList, pageIndex, gridCountPerPage, maxGridCount)
    self:GetGridContainers().MaxCount = gridCountPerPage
    local gridGOList = self:GetGridContainers().controlList
    if gridGOList then
        local storageItemCount
        if storageItemList ~= nil then
            storageItemCount = storageItemList.Count
        else
            storageItemCount = 0
        end
        local dic = {}
        if storageItemList then
            for i = 1, storageItemList.Count do
                ---@type bagV2.BagItemInfo
                local bagItem = storageItemList[i - 1]
                if bagItem then
                    dic[bagItem.bagIndex] = bagItem
                end
            end
        end
        for i = 0, gridGOList.Count - 1 do
            local gridGO = gridGOList[i]
            local grid = self:GetGrid(gridGO)
            if grid then
                local index = gridCountPerPage * pageIndex + i
                if index < maxGridCount then
                    ---@type bagV2.BagItemInfo
                    local bagItemTemp = dic[index]
                    if bagItemTemp == nil then
                        grid:RefreshWithInfo(nil, nil, false)
                    else
                        local bagItemInfo = bagItemTemp
                        local itemTbl
                        if bagItemInfo then
                            itemTbl = bagItemInfo.ItemTABLE
                        end
                        grid:RefreshWithInfo(bagItemInfo, itemTbl, false)
                    end
                else
                    grid:RefreshWithInfo(nil, nil, true)
                end
            end
        end
    end
end

---获取格子控制器
---@param gridGO UnityEngine.GameObject
---@return UIWarehousePanel_Grid
function UIWareHousePanel_PageController:GetGrid(gridGO)
    if CS.StaticUtility.IsNull(gridGO) then
        return nil
    end
    if self.mGrids == nil then
        self.mGrids = {}
    end
    local grid = self.mGrids[gridGO]
    if grid == nil then
        grid = templatemanager.GetNewTemplate(gridGO, luaComponentTemplates.UIWareHousePanel_Grid, self.mWareHousePanel, self.mWareHousePanel.GetInteraction(), self.mFetchPrefabMethod)
        self.mGrids[gridGO] = grid
    end
    return grid
end

return UIWareHousePanel_PageController