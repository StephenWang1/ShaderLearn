---@class LuaMainPlayerRecycleEarningMgr:luaobject 回收收益管理类
local LuaMainPlayerRecycleEarningMgr = {}

---获取回收收益列表
---@return table<ItemRecycleEarning>
function LuaMainPlayerRecycleEarningMgr:GetRecycleEarningList()
    ---@type table<ItemRecycleEarning>
    local recycleEarning = {}
    local CSRecycleItemList = CS.CSScene.MainPlayerInfo.BagInfo.RecycleItemList
    if CSRecycleItemList == nil or CSRecycleItemList.Count <= 0 then
        return recycleEarning
    end
    ---@type table<bagV2.BagItemInfo>
    local LuaRecycleItemList = Utility.ListChangeTable(CSRecycleItemList)
    for k, v in pairs(LuaRecycleItemList) do
        ---@type bagV2.BagItemInfo
        local bagItemInfo = v
        local itemRecycleEarning = luaclass.ItemRecycleEarning:New()
        if itemRecycleEarning:AnalysisRecycleEarningByBagItemInfo(bagItemInfo) then
            table.insert(recycleEarning,itemRecycleEarning)
        end
    end
    return recycleEarning
end

---获取背包回收需要显示的回收收益列表
---@return table<number,RecycleEarning>
function LuaMainPlayerRecycleEarningMgr:GetBagRecycleEarningList()
    local itemRecycleEarningTable = self:GetRecycleEarningList()
    if type(itemRecycleEarningTable) ~= 'table' or Utility.GetLuaTableCount(itemRecycleEarningTable) <= 0 then
        return
    end
    ---@type table<number,ItemRecycleEarning>
    local curItemRecycleEarningTable = {}
    for k,v in pairs(itemRecycleEarningTable) do
        ---@type ItemRecycleEarning
        local itemRecycleEarning = v
        if type(itemRecycleEarning.RecycleBaseEarningList) == 'table' and Utility.GetLuaTableCount(itemRecycleEarning.RecycleBaseEarningList) > 0 then
            for a,b in pairs(itemRecycleEarning.RecycleBaseEarningList) do
                ---@type RecycleEarning 当前刷新的回收收益
                local recycleEarning = b
                ---@type RecycleEarning 缓存的回收收益
                local cacheRecycleEarning = curItemRecycleEarningTable[recycleEarning.itemId]
                if cacheRecycleEarning == nil then
                    curItemRecycleEarningTable[recycleEarning.itemId] = recycleEarning
                else
                    cacheRecycleEarning.baseNumber = cacheRecycleEarning.baseNumber + recycleEarning.baseNumber
                    cacheRecycleEarning.curNumber = cacheRecycleEarning.curNumber + recycleEarning.curNumber
                    cacheRecycleEarning.EarningMultiples = cacheRecycleEarning.EarningMultiples + recycleEarning.EarningMultiples
                    cacheRecycleEarning.curTotalNumber =  cacheRecycleEarning.curTotalNumber + recycleEarning.curTotalNumber
                end
            end
        end
    end
    return curItemRecycleEarningTable
end

return LuaMainPlayerRecycleEarningMgr