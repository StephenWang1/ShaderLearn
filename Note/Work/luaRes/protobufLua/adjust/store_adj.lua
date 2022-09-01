--[[本文件为工具自动生成,禁止手动修改]]
local storeV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable storeV2.StoreInfo
---@type storeV2.StoreInfo
storeV2_adj.metatable_StoreInfo = {
    _ClassName = "storeV2.StoreInfo",
}
storeV2_adj.metatable_StoreInfo.__index = storeV2_adj.metatable_StoreInfo
--endregion

---@param tbl storeV2.StoreInfo 待调整的table数据
function storeV2_adj.AdjustStoreInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_StoreInfo)
    if tbl.storeId == nil then
        tbl.storeIdSpecified = false
        tbl.storeId = 0
    else
        tbl.storeIdSpecified = true
    end
    if tbl.dayBuyNum == nil then
        tbl.dayBuyNumSpecified = false
        tbl.dayBuyNum = 0
    else
        tbl.dayBuyNumSpecified = true
    end
    if tbl.lifeBuyNum == nil then
        tbl.lifeBuyNumSpecified = false
        tbl.lifeBuyNum = 0
    else
        tbl.lifeBuyNumSpecified = true
    end
    if tbl.refreshBuyNum == nil then
        tbl.refreshBuyNumSpecified = false
        tbl.refreshBuyNum = 0
    else
        tbl.refreshBuyNumSpecified = true
    end
    if tbl.serverDayBuyNum == nil then
        tbl.serverDayBuyNumSpecified = false
        tbl.serverDayBuyNum = 0
    else
        tbl.serverDayBuyNumSpecified = true
    end
    if tbl.serverLifeBuyNum == nil then
        tbl.serverLifeBuyNumSpecified = false
        tbl.serverLifeBuyNum = 0
    else
        tbl.serverLifeBuyNumSpecified = true
    end
    if tbl.serverRefreshBuyNum == nil then
        tbl.serverRefreshBuyNumSpecified = false
        tbl.serverRefreshBuyNum = 0
    else
        tbl.serverRefreshBuyNumSpecified = true
    end
    if tbl.buyState == nil then
        tbl.buyStateSpecified = false
        tbl.buyState = 0
    else
        tbl.buyStateSpecified = true
    end
    if tbl.isDiscount == nil then
        tbl.isDiscountSpecified = false
        tbl.isDiscount = 0
    else
        tbl.isDiscountSpecified = true
    end
    if tbl.price == nil then
        tbl.priceSpecified = false
        tbl.price = 0
    else
        tbl.priceSpecified = true
    end
    if tbl.pointPrice == nil then
        tbl.pointPriceSpecified = false
        tbl.pointPrice = 0
    else
        tbl.pointPriceSpecified = true
    end
    if tbl.limitNum == nil then
        tbl.limitNumSpecified = false
        tbl.limitNum = 0
    else
        tbl.limitNumSpecified = true
    end
    if tbl.bagItemInfo == nil then
        tbl.bagItemInfoSpecified = false
        tbl.bagItemInfo = nil
    else
        if tbl.bagItemInfoSpecified == nil then 
            tbl.bagItemInfoSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.bagItemInfo)
            end
        end
    end
end

--region metatable storeV2.ReqOpenStoreById
---@type storeV2.ReqOpenStoreById
storeV2_adj.metatable_ReqOpenStoreById = {
    _ClassName = "storeV2.ReqOpenStoreById",
}
storeV2_adj.metatable_ReqOpenStoreById.__index = storeV2_adj.metatable_ReqOpenStoreById
--endregion

---@param tbl storeV2.ReqOpenStoreById 待调整的table数据
function storeV2_adj.AdjustReqOpenStoreById(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_ReqOpenStoreById)
    if tbl.storeClassId == nil then
        tbl.storeClassIdSpecified = false
        tbl.storeClassId = 0
    else
        tbl.storeClassIdSpecified = true
    end
end

--region metatable storeV2.ResOpenStoreById
---@type storeV2.ResOpenStoreById
storeV2_adj.metatable_ResOpenStoreById = {
    _ClassName = "storeV2.ResOpenStoreById",
}
storeV2_adj.metatable_ResOpenStoreById.__index = storeV2_adj.metatable_ResOpenStoreById
--endregion

---@param tbl storeV2.ResOpenStoreById 待调整的table数据
function storeV2_adj.AdjustResOpenStoreById(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_ResOpenStoreById)
    if tbl.storeClassId == nil then
        tbl.storeClassIdSpecified = false
        tbl.storeClassId = 0
    else
        tbl.storeClassIdSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.nextFreshTime == nil then
        tbl.nextFreshTimeSpecified = false
        tbl.nextFreshTime = 0
    else
        tbl.nextFreshTimeSpecified = true
    end
    if tbl.storeInfo == nil then
        tbl.storeInfo = {}
    else
        if storeV2_adj.AdjustStoreInfo ~= nil then
            for i = 1, #tbl.storeInfo do
                storeV2_adj.AdjustStoreInfo(tbl.storeInfo[i])
            end
        end
    end
    if tbl.cost == nil then
        tbl.costSpecified = false
        tbl.cost = nil
    else
        if tbl.costSpecified == nil then 
            tbl.costSpecified = true
            if storeV2_adj.AdjustCost ~= nil then
                storeV2_adj.AdjustCost(tbl.cost)
            end
        end
    end
end

--region metatable storeV2.Cost
---@type storeV2.Cost
storeV2_adj.metatable_Cost = {
    _ClassName = "storeV2.Cost",
}
storeV2_adj.metatable_Cost.__index = storeV2_adj.metatable_Cost
--endregion

---@param tbl storeV2.Cost 待调整的table数据
function storeV2_adj.AdjustCost(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_Cost)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.num == nil then
        tbl.numSpecified = false
        tbl.num = 0
    else
        tbl.numSpecified = true
    end
end

--region metatable storeV2.ResSendStoreInfoChange
---@type storeV2.ResSendStoreInfoChange
storeV2_adj.metatable_ResSendStoreInfoChange = {
    _ClassName = "storeV2.ResSendStoreInfoChange",
}
storeV2_adj.metatable_ResSendStoreInfoChange.__index = storeV2_adj.metatable_ResSendStoreInfoChange
--endregion

---@param tbl storeV2.ResSendStoreInfoChange 待调整的table数据
function storeV2_adj.AdjustResSendStoreInfoChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_ResSendStoreInfoChange)
    if tbl.storeInfo == nil then
        tbl.storeInfoSpecified = false
        tbl.storeInfo = nil
    else
        if tbl.storeInfoSpecified == nil then 
            tbl.storeInfoSpecified = true
            if storeV2_adj.AdjustStoreInfo ~= nil then
                storeV2_adj.AdjustStoreInfo(tbl.storeInfo)
            end
        end
    end
end

--region metatable storeV2.ReqBuyItem
---@type storeV2.ReqBuyItem
storeV2_adj.metatable_ReqBuyItem = {
    _ClassName = "storeV2.ReqBuyItem",
}
storeV2_adj.metatable_ReqBuyItem.__index = storeV2_adj.metatable_ReqBuyItem
--endregion

---@param tbl storeV2.ReqBuyItem 待调整的table数据
function storeV2_adj.AdjustReqBuyItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_ReqBuyItem)
    if tbl.storeId == nil then
        tbl.storeIdSpecified = false
        tbl.storeId = 0
    else
        tbl.storeIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.isUse == nil then
        tbl.isUseSpecified = false
        tbl.isUse = 0
    else
        tbl.isUseSpecified = true
    end
    if tbl.replaceMoney == nil then
        tbl.replaceMoneySpecified = false
        tbl.replaceMoney = 0
    else
        tbl.replaceMoneySpecified = true
    end
end

--region metatable storeV2.ResBuyItem
---@type storeV2.ResBuyItem
storeV2_adj.metatable_ResBuyItem = {
    _ClassName = "storeV2.ResBuyItem",
}
storeV2_adj.metatable_ResBuyItem.__index = storeV2_adj.metatable_ResBuyItem
--endregion

---@param tbl storeV2.ResBuyItem 待调整的table数据
function storeV2_adj.AdjustResBuyItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_ResBuyItem)
    if tbl.sellId == nil then
        tbl.sellIdSpecified = false
        tbl.sellId = 0
    else
        tbl.sellIdSpecified = true
    end
    if tbl.storeId == nil then
        tbl.storeIdSpecified = false
        tbl.storeId = 0
    else
        tbl.storeIdSpecified = true
    end
end

--region metatable storeV2.ReqMaxBuyCount
---@type storeV2.ReqMaxBuyCount
storeV2_adj.metatable_ReqMaxBuyCount = {
    _ClassName = "storeV2.ReqMaxBuyCount",
}
storeV2_adj.metatable_ReqMaxBuyCount.__index = storeV2_adj.metatable_ReqMaxBuyCount
--endregion

---@param tbl storeV2.ReqMaxBuyCount 待调整的table数据
function storeV2_adj.AdjustReqMaxBuyCount(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_ReqMaxBuyCount)
    if tbl.storeId == nil then
        tbl.storeIdSpecified = false
        tbl.storeId = 0
    else
        tbl.storeIdSpecified = true
    end
end

--region metatable storeV2.ResMaxBuyCount
---@type storeV2.ResMaxBuyCount
storeV2_adj.metatable_ResMaxBuyCount = {
    _ClassName = "storeV2.ResMaxBuyCount",
}
storeV2_adj.metatable_ResMaxBuyCount.__index = storeV2_adj.metatable_ResMaxBuyCount
--endregion

---@param tbl storeV2.ResMaxBuyCount 待调整的table数据
function storeV2_adj.AdjustResMaxBuyCount(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_ResMaxBuyCount)
    if tbl.storeId == nil then
        tbl.storeIdSpecified = false
        tbl.storeId = 0
    else
        tbl.storeIdSpecified = true
    end
    if tbl.maxCount == nil then
        tbl.maxCountSpecified = false
        tbl.maxCount = 0
    else
        tbl.maxCountSpecified = true
    end
    if tbl.dayCount == nil then
        tbl.dayCountSpecified = false
        tbl.dayCount = 0
    else
        tbl.dayCountSpecified = true
    end
end

--region metatable storeV2.ReqManualFresh
---@type storeV2.ReqManualFresh
storeV2_adj.metatable_ReqManualFresh = {
    _ClassName = "storeV2.ReqManualFresh",
}
storeV2_adj.metatable_ReqManualFresh.__index = storeV2_adj.metatable_ReqManualFresh
--endregion

---@param tbl storeV2.ReqManualFresh 待调整的table数据
function storeV2_adj.AdjustReqManualFresh(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_ReqManualFresh)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.storeClassId == nil then
        tbl.storeClassIdSpecified = false
        tbl.storeClassId = 0
    else
        tbl.storeClassIdSpecified = true
    end
end

--region metatable storeV2.ReqStoreInfo
---@type storeV2.ReqStoreInfo
storeV2_adj.metatable_ReqStoreInfo = {
    _ClassName = "storeV2.ReqStoreInfo",
}
storeV2_adj.metatable_ReqStoreInfo.__index = storeV2_adj.metatable_ReqStoreInfo
--endregion

---@param tbl storeV2.ReqStoreInfo 待调整的table数据
function storeV2_adj.AdjustReqStoreInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_ReqStoreInfo)
    if tbl.storeId == nil then
        tbl.storeIdSpecified = false
        tbl.storeId = 0
    else
        tbl.storeIdSpecified = true
    end
end

--region metatable storeV2.ResStoreInfo
---@type storeV2.ResStoreInfo
storeV2_adj.metatable_ResStoreInfo = {
    _ClassName = "storeV2.ResStoreInfo",
}
storeV2_adj.metatable_ResStoreInfo.__index = storeV2_adj.metatable_ResStoreInfo
--endregion

---@param tbl storeV2.ResStoreInfo 待调整的table数据
function storeV2_adj.AdjustResStoreInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_ResStoreInfo)
    if tbl.storeClassId == nil then
        tbl.storeClassIdSpecified = false
        tbl.storeClassId = 0
    else
        tbl.storeClassIdSpecified = true
    end
    if tbl.storeInfo == nil then
        tbl.storeInfoSpecified = false
        tbl.storeInfo = nil
    else
        if tbl.storeInfoSpecified == nil then 
            tbl.storeInfoSpecified = true
            if storeV2_adj.AdjustStoreInfo ~= nil then
                storeV2_adj.AdjustStoreInfo(tbl.storeInfo)
            end
        end
    end
end

--region metatable storeV2.ReqSynthesis
---@type storeV2.ReqSynthesis
storeV2_adj.metatable_ReqSynthesis = {
    _ClassName = "storeV2.ReqSynthesis",
}
storeV2_adj.metatable_ReqSynthesis.__index = storeV2_adj.metatable_ReqSynthesis
--endregion

---@param tbl storeV2.ReqSynthesis 待调整的table数据
function storeV2_adj.AdjustReqSynthesis(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_ReqSynthesis)
    if tbl.configId == nil then
        tbl.configIdSpecified = false
        tbl.configId = 0
    else
        tbl.configIdSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.mustItemIds == nil then
        tbl.mustItemIds = {}
    end
    if tbl.itemIds == nil then
        tbl.itemIds = {}
    end
    if tbl.resourceId == nil then
        tbl.resourceId = {}
    end
end

--region metatable storeV2.ResSynthesis
---@type storeV2.ResSynthesis
storeV2_adj.metatable_ResSynthesis = {
    _ClassName = "storeV2.ResSynthesis",
}
storeV2_adj.metatable_ResSynthesis.__index = storeV2_adj.metatable_ResSynthesis
--endregion

---@param tbl storeV2.ResSynthesis 待调整的table数据
function storeV2_adj.AdjustResSynthesis(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_ResSynthesis)
    if tbl.item == nil then
        tbl.itemSpecified = false
        tbl.item = nil
    else
        if tbl.itemSpecified == nil then 
            tbl.itemSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.item)
            end
        end
    end
    if tbl.combineCount == nil then
        tbl.combineCountSpecified = false
        tbl.combineCount = 0
    else
        tbl.combineCountSpecified = true
    end
end

--region metatable storeV2.ResycleItem
---@type storeV2.ResycleItem
storeV2_adj.metatable_ResycleItem = {
    _ClassName = "storeV2.ResycleItem",
}
storeV2_adj.metatable_ResycleItem.__index = storeV2_adj.metatable_ResycleItem
--endregion

---@param tbl storeV2.ResycleItem 待调整的table数据
function storeV2_adj.AdjustResycleItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_ResycleItem)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.configId == nil then
        tbl.configIdSpecified = false
        tbl.configId = 0
    else
        tbl.configIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
    if tbl.money == nil then
        tbl.moneySpecified = false
        tbl.money = 0
    else
        tbl.moneySpecified = true
    end
end

--region metatable storeV2.ResMostResyclePanel
---@type storeV2.ResMostResyclePanel
storeV2_adj.metatable_ResMostResyclePanel = {
    _ClassName = "storeV2.ResMostResyclePanel",
}
storeV2_adj.metatable_ResMostResyclePanel.__index = storeV2_adj.metatable_ResMostResyclePanel
--endregion

---@param tbl storeV2.ResMostResyclePanel 待调整的table数据
function storeV2_adj.AdjustResMostResyclePanel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_ResMostResyclePanel)
    if tbl.item == nil then
        tbl.item = {}
    else
        if storeV2_adj.AdjustResycleItem ~= nil then
            for i = 1, #tbl.item do
                storeV2_adj.AdjustResycleItem(tbl.item[i])
            end
        end
    end
end

--region metatable storeV2.ReqMostResycle
---@type storeV2.ReqMostResycle
storeV2_adj.metatable_ReqMostResycle = {
    _ClassName = "storeV2.ReqMostResycle",
}
storeV2_adj.metatable_ReqMostResycle.__index = storeV2_adj.metatable_ReqMostResycle
--endregion

---@param tbl storeV2.ReqMostResycle 待调整的table数据
function storeV2_adj.AdjustReqMostResycle(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_ReqMostResycle)
    if tbl.id == nil then
        tbl.id = {}
    end
end

--region metatable storeV2.ReqMostRedeem
---@type storeV2.ReqMostRedeem
storeV2_adj.metatable_ReqMostRedeem = {
    _ClassName = "storeV2.ReqMostRedeem",
}
storeV2_adj.metatable_ReqMostRedeem.__index = storeV2_adj.metatable_ReqMostRedeem
--endregion

---@param tbl storeV2.ReqMostRedeem 待调整的table数据
function storeV2_adj.AdjustReqMostRedeem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_ReqMostRedeem)
end

--region metatable storeV2.CombineRecord
---@type storeV2.CombineRecord
storeV2_adj.metatable_CombineRecord = {
    _ClassName = "storeV2.CombineRecord",
}
storeV2_adj.metatable_CombineRecord.__index = storeV2_adj.metatable_CombineRecord
--endregion

---@param tbl storeV2.CombineRecord 待调整的table数据
function storeV2_adj.AdjustCombineRecord(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_CombineRecord)
    if tbl.combineId == nil then
        tbl.combineId = {}
    end
    if tbl.combineCount == nil then
        tbl.combineCount = {}
    else
        if storeV2_adj.AdjustCombineCount ~= nil then
            for i = 1, #tbl.combineCount do
                storeV2_adj.AdjustCombineCount(tbl.combineCount[i])
            end
        end
    end
end

--region metatable storeV2.CombineCount
---@type storeV2.CombineCount
storeV2_adj.metatable_CombineCount = {
    _ClassName = "storeV2.CombineCount",
}
storeV2_adj.metatable_CombineCount.__index = storeV2_adj.metatable_CombineCount
--endregion

---@param tbl storeV2.CombineCount 待调整的table数据
function storeV2_adj.AdjustCombineCount(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_CombineCount)
    if tbl.combineId == nil then
        tbl.combineIdSpecified = false
        tbl.combineId = 0
    else
        tbl.combineIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable storeV2.ReqCuiLian
---@type storeV2.ReqCuiLian
storeV2_adj.metatable_ReqCuiLian = {
    _ClassName = "storeV2.ReqCuiLian",
}
storeV2_adj.metatable_ReqCuiLian.__index = storeV2_adj.metatable_ReqCuiLian
--endregion

---@param tbl storeV2.ReqCuiLian 待调整的table数据
function storeV2_adj.AdjustReqCuiLian(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_ReqCuiLian)
    if tbl.configId == nil then
        tbl.configIdSpecified = false
        tbl.configId = 0
    else
        tbl.configIdSpecified = true
    end
    if tbl.itemUniqueId == nil then
        tbl.itemUniqueIdSpecified = false
        tbl.itemUniqueId = 0
    else
        tbl.itemUniqueIdSpecified = true
    end
end

--region metatable storeV2.ResCuiLian
---@type storeV2.ResCuiLian
storeV2_adj.metatable_ResCuiLian = {
    _ClassName = "storeV2.ResCuiLian",
}
storeV2_adj.metatable_ResCuiLian.__index = storeV2_adj.metatable_ResCuiLian
--endregion

---@param tbl storeV2.ResCuiLian 待调整的table数据
function storeV2_adj.AdjustResCuiLian(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, storeV2_adj.metatable_ResCuiLian)
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

return storeV2_adj