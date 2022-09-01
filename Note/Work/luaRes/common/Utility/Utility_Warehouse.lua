---@type Utility
local Utility = Utility

---获取仓库当前的格子数量
---@return number
function Utility.GetWarehouseMaxGridCount()
    return CS.CSScene.MainPlayerInfo.Storage.MaxStorageGrid
end

---免费的仓库页数
---@return number,number,number 免费仓库页数，付费仓库页数，每一页的仓库格子数量
function Utility.GetWarehouseGridConfigInfo()
    return CS.Cfg_GlobalTableManager.Instance:GetStorageGridInfo()
end

---获取未解锁的格子下标
---@return number
function Utility.GetUnlockGridIndex()
    local freeWarehousePageNum,costWarehousePageNum,pageGridNum = Utility.GetWarehouseGridConfigInfo()
    if freeWarehousePageNum == nil or costWarehousePageNum == nil or pageGridNum == nil then
        return
    end
    local allGridNum = Utility.GetWarehouseMaxGridCount()
    if type(allGridNum) ~= 'number' then
        return
    end
    return allGridNum - freeWarehousePageNum * pageGridNum + 1
end

---主角是否可以增加仓库空间
---@return boolean
function Utility.MainPlayerCanAddWarehouseSpace()
    local costParams = LuaGlobalTableDeal:GetWarehouseAddSpaceConfigParams()
    if type(costParams) ~= 'table' or costParams.costNum == nil or costParams.costItemId == nil then
        return false
    end
    local bagCostItemNum = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(costParams.costItemId)
    if type(bagCostItemNum) ~= 'number' or bagCostItemNum < costParams.costNum then
        return false
    end
    return true
end
