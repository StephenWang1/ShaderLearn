---仓库交互控制
---@class UIWareHousePanel_Interaction:UIBagTypeContainerInteraction
local UIWareHousePanel_Interaction = {}

setmetatable(UIWareHousePanel_Interaction, luaComponentTemplates.UIBagType_Interaction)

function UIWareHousePanel_Interaction:IsEmptyGridInteractionAvailable()
    return true
end

function UIWareHousePanel_Interaction:IsSingleClickedAvailable(grid, bagItemInfo, itemTbl)
    return true
end

function UIWareHousePanel_Interaction:IsDoubleClickedAvailable(grid, bagItemInfo, itemTbl)
    return true
end

function UIWareHousePanel_Interaction:IsDragAvailable(grid, bagItemInfo, itemTbl)
    return true
end

function UIWareHousePanel_Interaction:DoSingleClick(grid, bagItemInfo, itemTbl)
    if grid then
        if grid:IsLocked() == false then
            if bagItemInfo and itemTbl then
                uiStaticParameter.UIItemInfoManager:CreatePanel({
                    bagItemInfo = bagItemInfo,
                    rightUpButtonsModule = luaComponentTemplates.UIWarehousePanel_TakeOutServantEquipRightUpOperate,
                    showRight = true,
                    showBind = true,
                    showAction = true })
            end
        else
            --local freeNum = self:GetRelyPanel().mFreeStoragePageCount
            --local perPageGrid = self:GetRelyPanel().mGridCountPerPage
            --local allCount = self:GetRelyPanel().GetMaxGridCount()
            --local unLockNum = allCount - perPageGrid * freeNum
            --uimanager:CreatePanel("UIWarehouseUnlockPanel", nil, unLockNum)
        end
    end
end

function UIWareHousePanel_Interaction:DoDoubleClick(grid, bagItemInfo, itemTbl)
    if grid and grid:IsLocked() == false and bagItemInfo and itemTbl then
        networkRequest.ReqStorageOutItem(bagItemInfo.lid)
    end
end

function UIWareHousePanel_Interaction:DoEndDrag(grid, bagItemInfo, itemTbl, pos, isDestroyed)
    if grid and grid:IsLocked() == false and bagItemInfo and itemTbl and pos and isDestroyed == false then
        local bagPanel = uimanager:GetPanel("UIBagPanel")
        if bagPanel and bagPanel.IsHiden == false and CS.StaticUtility.IsNull(bagPanel.go) == false and CS.Utility_Lua.IsPointInUIRange(pos, bagPanel.go) then
            networkRequest.ReqStorageOutItem(bagItemInfo.lid)
        end
    end
end

return UIWareHousePanel_Interaction