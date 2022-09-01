--[[本文件为工具自动生成,禁止手动修改]]
local npcstoreV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable npcstoreV2.NpcStoreItem
---@type npcstoreV2.NpcStoreItem
npcstoreV2_adj.metatable_NpcStoreItem = {
    _ClassName = "npcstoreV2.NpcStoreItem",
}
npcstoreV2_adj.metatable_NpcStoreItem.__index = npcstoreV2_adj.metatable_NpcStoreItem
--endregion

---@param tbl npcstoreV2.NpcStoreItem 待调整的table数据
function npcstoreV2_adj.AdjustNpcStoreItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, npcstoreV2_adj.metatable_NpcStoreItem)
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
    if tbl.priceItemId == nil then
        tbl.priceItemIdSpecified = false
        tbl.priceItemId = 0
    else
        tbl.priceItemIdSpecified = true
    end
    if tbl.priceCount == nil then
        tbl.priceCountSpecified = false
        tbl.priceCount = 0
    else
        tbl.priceCountSpecified = true
    end
    if tbl.npcShopId == nil then
        tbl.npcShopIdSpecified = false
        tbl.npcShopId = 0
    else
        tbl.npcShopIdSpecified = true
    end
end

--region metatable npcstoreV2.NpcStoreGrid
---@type npcstoreV2.NpcStoreGrid
npcstoreV2_adj.metatable_NpcStoreGrid = {
    _ClassName = "npcstoreV2.NpcStoreGrid",
}
npcstoreV2_adj.metatable_NpcStoreGrid.__index = npcstoreV2_adj.metatable_NpcStoreGrid
--endregion

---@param tbl npcstoreV2.NpcStoreGrid 待调整的table数据
function npcstoreV2_adj.AdjustNpcStoreGrid(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, npcstoreV2_adj.metatable_NpcStoreGrid)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.npcStoreItem == nil then
        tbl.npcStoreItemSpecified = false
        tbl.npcStoreItem = nil
    else
        if tbl.npcStoreItemSpecified == nil then 
            tbl.npcStoreItemSpecified = true
            if npcstoreV2_adj.AdjustNpcStoreItem ~= nil then
                npcstoreV2_adj.AdjustNpcStoreItem(tbl.npcStoreItem)
            end
        end
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
end

--region metatable npcstoreV2.NpcStoreGridList
---@type npcstoreV2.NpcStoreGridList
npcstoreV2_adj.metatable_NpcStoreGridList = {
    _ClassName = "npcstoreV2.NpcStoreGridList",
}
npcstoreV2_adj.metatable_NpcStoreGridList.__index = npcstoreV2_adj.metatable_NpcStoreGridList
--endregion

---@param tbl npcstoreV2.NpcStoreGridList 待调整的table数据
function npcstoreV2_adj.AdjustNpcStoreGridList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, npcstoreV2_adj.metatable_NpcStoreGridList)
    if tbl.npcStoreGrids == nil then
        tbl.npcStoreGrids = {}
    else
        if npcstoreV2_adj.AdjustNpcStoreGrid ~= nil then
            for i = 1, #tbl.npcStoreGrids do
                npcstoreV2_adj.AdjustNpcStoreGrid(tbl.npcStoreGrids[i])
            end
        end
    end
end

--region metatable npcstoreV2.ReqGetNpcStoreInfo
---@type npcstoreV2.ReqGetNpcStoreInfo
npcstoreV2_adj.metatable_ReqGetNpcStoreInfo = {
    _ClassName = "npcstoreV2.ReqGetNpcStoreInfo",
}
npcstoreV2_adj.metatable_ReqGetNpcStoreInfo.__index = npcstoreV2_adj.metatable_ReqGetNpcStoreInfo
--endregion

---@param tbl npcstoreV2.ReqGetNpcStoreInfo 待调整的table数据
function npcstoreV2_adj.AdjustReqGetNpcStoreInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, npcstoreV2_adj.metatable_ReqGetNpcStoreInfo)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.page == nil then
        tbl.pageSpecified = false
        tbl.page = 0
    else
        tbl.pageSpecified = true
    end
    if tbl.countPerPage == nil then
        tbl.countPerPageSpecified = false
        tbl.countPerPage = 0
    else
        tbl.countPerPageSpecified = true
    end
    if tbl.pageNumber == nil then
        tbl.pageNumberSpecified = false
        tbl.pageNumber = 0
    else
        tbl.pageNumberSpecified = true
    end
end

--region metatable npcstoreV2.ResNpcStoreInfo
---@type npcstoreV2.ResNpcStoreInfo
npcstoreV2_adj.metatable_ResNpcStoreInfo = {
    _ClassName = "npcstoreV2.ResNpcStoreInfo",
}
npcstoreV2_adj.metatable_ResNpcStoreInfo.__index = npcstoreV2_adj.metatable_ResNpcStoreInfo
--endregion

---@param tbl npcstoreV2.ResNpcStoreInfo 待调整的table数据
function npcstoreV2_adj.AdjustResNpcStoreInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, npcstoreV2_adj.metatable_ResNpcStoreInfo)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.totalPage == nil then
        tbl.totalPageSpecified = false
        tbl.totalPage = 0
    else
        tbl.totalPageSpecified = true
    end
    if tbl.page == nil then
        tbl.pageSpecified = false
        tbl.page = 0
    else
        tbl.pageSpecified = true
    end
    if tbl.countPerPage == nil then
        tbl.countPerPageSpecified = false
        tbl.countPerPage = 0
    else
        tbl.countPerPageSpecified = true
    end
    if tbl.pageNumber == nil then
        tbl.pageNumberSpecified = false
        tbl.pageNumber = 0
    else
        tbl.pageNumberSpecified = true
    end
    if tbl.npcStoreGridList == nil then
        tbl.npcStoreGridListSpecified = false
        tbl.npcStoreGridList = nil
    else
        if tbl.npcStoreGridListSpecified == nil then 
            tbl.npcStoreGridListSpecified = true
            if npcstoreV2_adj.AdjustNpcStoreGridList ~= nil then
                npcstoreV2_adj.AdjustNpcStoreGridList(tbl.npcStoreGridList)
            end
        end
    end
end

--region metatable npcstoreV2.ReqSellList
---@type npcstoreV2.ReqSellList
npcstoreV2_adj.metatable_ReqSellList = {
    _ClassName = "npcstoreV2.ReqSellList",
}
npcstoreV2_adj.metatable_ReqSellList.__index = npcstoreV2_adj.metatable_ReqSellList
--endregion

---@param tbl npcstoreV2.ReqSellList 待调整的table数据
function npcstoreV2_adj.AdjustReqSellList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, npcstoreV2_adj.metatable_ReqSellList)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable npcstoreV2.ReqPutOnNpcStoreItem
---@type npcstoreV2.ReqPutOnNpcStoreItem
npcstoreV2_adj.metatable_ReqPutOnNpcStoreItem = {
    _ClassName = "npcstoreV2.ReqPutOnNpcStoreItem",
}
npcstoreV2_adj.metatable_ReqPutOnNpcStoreItem.__index = npcstoreV2_adj.metatable_ReqPutOnNpcStoreItem
--endregion

---@param tbl npcstoreV2.ReqPutOnNpcStoreItem 待调整的table数据
function npcstoreV2_adj.AdjustReqPutOnNpcStoreItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, npcstoreV2_adj.metatable_ReqPutOnNpcStoreItem)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable npcstoreV2.ResPutOnNpcStoreItem
---@type npcstoreV2.ResPutOnNpcStoreItem
npcstoreV2_adj.metatable_ResPutOnNpcStoreItem = {
    _ClassName = "npcstoreV2.ResPutOnNpcStoreItem",
}
npcstoreV2_adj.metatable_ResPutOnNpcStoreItem.__index = npcstoreV2_adj.metatable_ResPutOnNpcStoreItem
--endregion

---@param tbl npcstoreV2.ResPutOnNpcStoreItem 待调整的table数据
function npcstoreV2_adj.AdjustResPutOnNpcStoreItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, npcstoreV2_adj.metatable_ResPutOnNpcStoreItem)
    if tbl.success == nil then
        tbl.successSpecified = false
        tbl.success = 0
    else
        tbl.successSpecified = true
    end
end

--region metatable npcstoreV2.ReqBuyNpcStore
---@type npcstoreV2.ReqBuyNpcStore
npcstoreV2_adj.metatable_ReqBuyNpcStore = {
    _ClassName = "npcstoreV2.ReqBuyNpcStore",
}
npcstoreV2_adj.metatable_ReqBuyNpcStore.__index = npcstoreV2_adj.metatable_ReqBuyNpcStore
--endregion

---@param tbl npcstoreV2.ReqBuyNpcStore 待调整的table数据
function npcstoreV2_adj.AdjustReqBuyNpcStore(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, npcstoreV2_adj.metatable_ReqBuyNpcStore)
    if tbl.npcStoreGridId == nil then
        tbl.npcStoreGridIdSpecified = false
        tbl.npcStoreGridId = 0
    else
        tbl.npcStoreGridIdSpecified = true
    end
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
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
end

--region metatable npcstoreV2.ResBuyNpcStore
---@type npcstoreV2.ResBuyNpcStore
npcstoreV2_adj.metatable_ResBuyNpcStore = {
    _ClassName = "npcstoreV2.ResBuyNpcStore",
}
npcstoreV2_adj.metatable_ResBuyNpcStore.__index = npcstoreV2_adj.metatable_ResBuyNpcStore
--endregion

---@param tbl npcstoreV2.ResBuyNpcStore 待调整的table数据
function npcstoreV2_adj.AdjustResBuyNpcStore(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, npcstoreV2_adj.metatable_ResBuyNpcStore)
    if tbl.success == nil then
        tbl.successSpecified = false
        tbl.success = 0
    else
        tbl.successSpecified = true
    end
end

return npcstoreV2_adj