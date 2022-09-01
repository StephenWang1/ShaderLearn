--[[本文件为工具自动生成,禁止手动修改]]
local npcstoreV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData npcstoreV2.NpcStoreItem lua中的数据结构
---@return npcstoreV2.NpcStoreItem C#中的数据结构
function npcstoreV2.NpcStoreItem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.npcstoreV2.NpcStoreItem()
    if decodedData.item ~= nil and decodedData.itemSpecified ~= false then
        data.item = decodeTable.bag.BagItemInfo(decodedData.item)
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.priceItemId ~= nil and decodedData.priceItemIdSpecified ~= false then
        data.priceItemId = decodedData.priceItemId
    end
    if decodedData.priceCount ~= nil and decodedData.priceCountSpecified ~= false then
        data.priceCount = decodedData.priceCount
    end
    if decodedData.npcShopId ~= nil and decodedData.npcShopIdSpecified ~= false then
        data.npcShopId = decodedData.npcShopId
    end
    return data
end

---@param decodedData npcstoreV2.NpcStoreGrid lua中的数据结构
---@return npcstoreV2.NpcStoreGrid C#中的数据结构
function npcstoreV2.NpcStoreGrid(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.npcstoreV2.NpcStoreGrid()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.npcStoreItem ~= nil and decodedData.npcStoreItemSpecified ~= false then
        data.npcStoreItem = npcstoreV2.NpcStoreItem(decodedData.npcStoreItem)
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData npcstoreV2.NpcStoreGridList lua中的数据结构
---@return npcstoreV2.NpcStoreGridList C#中的数据结构
function npcstoreV2.NpcStoreGridList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.npcstoreV2.NpcStoreGridList()
    if decodedData.npcStoreGrids ~= nil and decodedData.npcStoreGridsSpecified ~= false then
        for i = 1, #decodedData.npcStoreGrids do
            data.npcStoreGrids:Add(npcstoreV2.NpcStoreGrid(decodedData.npcStoreGrids[i]))
        end
    end
    return data
end

---@param decodedData npcstoreV2.ReqGetNpcStoreInfo lua中的数据结构
---@return npcstoreV2.ReqGetNpcStoreInfo C#中的数据结构
function npcstoreV2.ReqGetNpcStoreInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.npcstoreV2.ReqGetNpcStoreInfo()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.page ~= nil and decodedData.pageSpecified ~= false then
        data.page = decodedData.page
    end
    if decodedData.countPerPage ~= nil and decodedData.countPerPageSpecified ~= false then
        data.countPerPage = decodedData.countPerPage
    end
    if decodedData.pageNumber ~= nil and decodedData.pageNumberSpecified ~= false then
        data.pageNumber = decodedData.pageNumber
    end
    return data
end

---@param decodedData npcstoreV2.ResNpcStoreInfo lua中的数据结构
---@return npcstoreV2.ResNpcStoreInfo C#中的数据结构
function npcstoreV2.ResNpcStoreInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.npcstoreV2.ResNpcStoreInfo()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.totalPage ~= nil and decodedData.totalPageSpecified ~= false then
        data.totalPage = decodedData.totalPage
    end
    if decodedData.page ~= nil and decodedData.pageSpecified ~= false then
        data.page = decodedData.page
    end
    if decodedData.countPerPage ~= nil and decodedData.countPerPageSpecified ~= false then
        data.countPerPage = decodedData.countPerPage
    end
    if decodedData.pageNumber ~= nil and decodedData.pageNumberSpecified ~= false then
        data.pageNumber = decodedData.pageNumber
    end
    if decodedData.npcStoreGridList ~= nil and decodedData.npcStoreGridListSpecified ~= false then
        data.npcStoreGridList = npcstoreV2.NpcStoreGridList(decodedData.npcStoreGridList)
    end
    return data
end

---@param decodedData npcstoreV2.ReqSellList lua中的数据结构
---@return npcstoreV2.ReqSellList C#中的数据结构
function npcstoreV2.ReqSellList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.npcstoreV2.ReqSellList()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData npcstoreV2.ReqPutOnNpcStoreItem lua中的数据结构
---@return npcstoreV2.ReqPutOnNpcStoreItem C#中的数据结构
function npcstoreV2.ReqPutOnNpcStoreItem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.npcstoreV2.ReqPutOnNpcStoreItem()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

--[[npcstoreV2.ResPutOnNpcStoreItem 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData npcstoreV2.ReqBuyNpcStore lua中的数据结构
---@return npcstoreV2.ReqBuyNpcStore C#中的数据结构
function npcstoreV2.ReqBuyNpcStore(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.npcstoreV2.ReqBuyNpcStore()
    if decodedData.npcStoreGridId ~= nil and decodedData.npcStoreGridIdSpecified ~= false then
        data.npcStoreGridId = decodedData.npcStoreGridId
    end
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

--[[npcstoreV2.ResBuyNpcStore 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return npcstoreV2