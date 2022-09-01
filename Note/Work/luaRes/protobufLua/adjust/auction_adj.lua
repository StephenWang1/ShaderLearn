--[[本文件为工具自动生成,禁止手动修改]]
local auctionV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable auctionV2.AuctionItemInfo
---@type auctionV2.AuctionItemInfo
auctionV2_adj.metatable_AuctionItemInfo = {
    _ClassName = "auctionV2.AuctionItemInfo",
}
auctionV2_adj.metatable_AuctionItemInfo.__index = auctionV2_adj.metatable_AuctionItemInfo
--endregion

---@param tbl auctionV2.AuctionItemInfo 待调整的table数据
function auctionV2_adj.AdjustAuctionItemInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_AuctionItemInfo)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.itemType == nil then
        tbl.itemTypeSpecified = false
        tbl.itemType = 0
    else
        tbl.itemTypeSpecified = true
    end
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
    if tbl.price == nil then
        tbl.priceSpecified = false
        tbl.price = nil
    else
        if tbl.priceSpecified == nil then 
            tbl.priceSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustCoinInfo ~= nil then
                adjustTable.bag_adj.AdjustCoinInfo(tbl.price)
            end
        end
    end
    if tbl.addTime == nil then
        tbl.addTimeSpecified = false
        tbl.addTime = 0
    else
        tbl.addTimeSpecified = true
    end
    if tbl.serverId == nil then
        tbl.serverIdSpecified = false
        tbl.serverId = 0
    else
        tbl.serverIdSpecified = true
    end
    if tbl.overdueTime == nil then
        tbl.overdueTimeSpecified = false
        tbl.overdueTime = 0
    else
        tbl.overdueTimeSpecified = true
    end
    if tbl.itemCount == nil then
        tbl.itemCountSpecified = false
        tbl.itemCount = 0
    else
        tbl.itemCountSpecified = true
    end
    if tbl.auctionItemLotInfo == nil then
        tbl.auctionItemLotInfoSpecified = false
        tbl.auctionItemLotInfo = nil
    else
        if tbl.auctionItemLotInfoSpecified == nil then 
            tbl.auctionItemLotInfoSpecified = true
            if auctionV2_adj.AdjustAuctionItemLotInfo ~= nil then
                auctionV2_adj.AdjustAuctionItemLotInfo(tbl.auctionItemLotInfo)
            end
        end
    end
    if tbl.auctionItemBuyProductsInfo == nil then
        tbl.auctionItemBuyProductsInfoSpecified = false
        tbl.auctionItemBuyProductsInfo = nil
    else
        if tbl.auctionItemBuyProductsInfoSpecified == nil then 
            tbl.auctionItemBuyProductsInfoSpecified = true
            if auctionV2_adj.AdjustAuctionItemBuyProductsInfo ~= nil then
                auctionV2_adj.AdjustAuctionItemBuyProductsInfo(tbl.auctionItemBuyProductsInfo)
            end
        end
    end
    if tbl.delayTime == nil then
        tbl.delayTimeSpecified = false
        tbl.delayTime = 0
    else
        tbl.delayTimeSpecified = true
    end
    if tbl.bidState == nil then
        tbl.bidStateSpecified = false
        tbl.bidState = 0
    else
        tbl.bidStateSpecified = true
    end
end

--region metatable auctionV2.AuctionItemLotInfo
---@type auctionV2.AuctionItemLotInfo
auctionV2_adj.metatable_AuctionItemLotInfo = {
    _ClassName = "auctionV2.AuctionItemLotInfo",
}
auctionV2_adj.metatable_AuctionItemLotInfo.__index = auctionV2_adj.metatable_AuctionItemLotInfo
--endregion

---@param tbl auctionV2.AuctionItemLotInfo 待调整的table数据
function auctionV2_adj.AdjustAuctionItemLotInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_AuctionItemLotInfo)
    if tbl.bidderRid == nil then
        tbl.bidderRidSpecified = false
        tbl.bidderRid = 0
    else
        tbl.bidderRidSpecified = true
    end
    if tbl.bidPrice == nil then
        tbl.bidPriceSpecified = false
        tbl.bidPrice = 0
    else
        tbl.bidPriceSpecified = true
    end
    if tbl.isPublicity == nil then
        tbl.isPublicitySpecified = false
        tbl.isPublicity = false
    else
        tbl.isPublicitySpecified = true
    end
    if tbl.publicityTime == nil then
        tbl.publicityTimeSpecified = false
        tbl.publicityTime = 0
    else
        tbl.publicityTimeSpecified = true
    end
    if tbl.fixedPrice == nil then
        tbl.fixedPriceSpecified = false
        tbl.fixedPrice = 0
    else
        tbl.fixedPriceSpecified = true
    end
end

--region metatable auctionV2.AuctionItemBuyProductsInfo
---@type auctionV2.AuctionItemBuyProductsInfo
auctionV2_adj.metatable_AuctionItemBuyProductsInfo = {
    _ClassName = "auctionV2.AuctionItemBuyProductsInfo",
}
auctionV2_adj.metatable_AuctionItemBuyProductsInfo.__index = auctionV2_adj.metatable_AuctionItemBuyProductsInfo
--endregion

---@param tbl auctionV2.AuctionItemBuyProductsInfo 待调整的table数据
function auctionV2_adj.AdjustAuctionItemBuyProductsInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_AuctionItemBuyProductsInfo)
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.minLevel == nil then
        tbl.minLevelSpecified = false
        tbl.minLevel = 0
    else
        tbl.minLevelSpecified = true
    end
    if tbl.maxLevel == nil then
        tbl.maxLevelSpecified = false
        tbl.maxLevel = 0
    else
        tbl.maxLevelSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.carreer == nil then
        tbl.carreerSpecified = false
        tbl.carreer = 0
    else
        tbl.carreerSpecified = true
    end
    if tbl.screenCondition == nil then
        tbl.screenCondition = {}
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.propertyTendency == nil then
        tbl.propertyTendencySpecified = false
        tbl.propertyTendency = 0
    else
        tbl.propertyTendencySpecified = true
    end
end

--region metatable auctionV2.AuctionItemList
---@type auctionV2.AuctionItemList
auctionV2_adj.metatable_AuctionItemList = {
    _ClassName = "auctionV2.AuctionItemList",
}
auctionV2_adj.metatable_AuctionItemList.__index = auctionV2_adj.metatable_AuctionItemList
--endregion

---@param tbl auctionV2.AuctionItemList 待调整的table数据
function auctionV2_adj.AdjustAuctionItemList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_AuctionItemList)
    if tbl.items == nil then
        tbl.items = {}
    else
        if auctionV2_adj.AdjustAuctionItemInfo ~= nil then
            for i = 1, #tbl.items do
                auctionV2_adj.AdjustAuctionItemInfo(tbl.items[i])
            end
        end
    end
    if tbl.page == nil then
        tbl.pageSpecified = false
        tbl.page = 0
    else
        tbl.pageSpecified = true
    end
    if tbl.toatlPageCount == nil then
        tbl.toatlPageCountSpecified = false
        tbl.toatlPageCount = 0
    else
        tbl.toatlPageCountSpecified = true
    end
    if tbl.isUnionSmelt == nil then
        tbl.isUnionSmeltSpecified = false
        tbl.isUnionSmelt = false
    else
        tbl.isUnionSmeltSpecified = true
    end
end

--region metatable auctionV2.AuctionItemShelfList
---@type auctionV2.AuctionItemShelfList
auctionV2_adj.metatable_AuctionItemShelfList = {
    _ClassName = "auctionV2.AuctionItemShelfList",
}
auctionV2_adj.metatable_AuctionItemShelfList.__index = auctionV2_adj.metatable_AuctionItemShelfList
--endregion

---@param tbl auctionV2.AuctionItemShelfList 待调整的table数据
function auctionV2_adj.AdjustAuctionItemShelfList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_AuctionItemShelfList)
    if tbl.itemType == nil then
        tbl.itemTypeSpecified = false
        tbl.itemType = 0
    else
        tbl.itemTypeSpecified = true
    end
    if tbl.items == nil then
        tbl.items = {}
    else
        if auctionV2_adj.AdjustAuctionItemInfo ~= nil then
            for i = 1, #tbl.items do
                auctionV2_adj.AdjustAuctionItemInfo(tbl.items[i])
            end
        end
    end
end

--region metatable auctionV2.GetAuctionItemsRequest
---@type auctionV2.GetAuctionItemsRequest
auctionV2_adj.metatable_GetAuctionItemsRequest = {
    _ClassName = "auctionV2.GetAuctionItemsRequest",
}
auctionV2_adj.metatable_GetAuctionItemsRequest.__index = auctionV2_adj.metatable_GetAuctionItemsRequest
--endregion

---@param tbl auctionV2.GetAuctionItemsRequest 待调整的table数据
function auctionV2_adj.AdjustGetAuctionItemsRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_GetAuctionItemsRequest)
    if tbl.page == nil then
        tbl.pageSpecified = false
        tbl.page = 0
    else
        tbl.pageSpecified = true
    end
    if tbl.minLevel == nil then
        tbl.minLevelSpecified = false
        tbl.minLevel = 0
    else
        tbl.minLevelSpecified = true
    end
    if tbl.maxLevel == nil then
        tbl.maxLevelSpecified = false
        tbl.maxLevel = 0
    else
        tbl.maxLevelSpecified = true
    end
    if tbl.currency == nil then
        tbl.currencySpecified = false
        tbl.currency = 0
    else
        tbl.currencySpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.toatlPageCount == nil then
        tbl.toatlPageCountSpecified = false
        tbl.toatlPageCount = 0
    else
        tbl.toatlPageCountSpecified = true
    end
    if tbl.screenCondition == nil then
        tbl.screenCondition = {}
    end
    if tbl.itemType == nil then
        tbl.itemTypeSpecified = false
        tbl.itemType = 0
    else
        tbl.itemTypeSpecified = true
    end
    if tbl.sortBy == nil then
        tbl.sortBySpecified = false
        tbl.sortBy = 0
    else
        tbl.sortBySpecified = true
    end
    if tbl.sort == nil then
        tbl.sortSpecified = false
        tbl.sort = false
    else
        tbl.sortSpecified = true
    end
    if tbl.propertyTendency == nil then
        tbl.propertyTendencySpecified = false
        tbl.propertyTendency = 0
    else
        tbl.propertyTendencySpecified = true
    end
    if tbl.selectType == nil then
        tbl.selectTypeSpecified = false
        tbl.selectType = 0
    else
        tbl.selectTypeSpecified = true
    end
end

--region metatable auctionV2.AddToShelfRequest
---@type auctionV2.AddToShelfRequest
auctionV2_adj.metatable_AddToShelfRequest = {
    _ClassName = "auctionV2.AddToShelfRequest",
}
auctionV2_adj.metatable_AddToShelfRequest.__index = auctionV2_adj.metatable_AddToShelfRequest
--endregion

---@param tbl auctionV2.AddToShelfRequest 待调整的table数据
function auctionV2_adj.AdjustAddToShelfRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_AddToShelfRequest)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.price == nil then
        tbl.priceSpecified = false
        tbl.price = nil
    else
        if tbl.priceSpecified == nil then 
            tbl.priceSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustCoinInfo ~= nil then
                adjustTable.bag_adj.AdjustCoinInfo(tbl.price)
            end
        end
    end
    if tbl.itemType == nil then
        tbl.itemTypeSpecified = false
        tbl.itemType = 0
    else
        tbl.itemTypeSpecified = true
    end
    if tbl.isPublicity == nil then
        tbl.isPublicitySpecified = false
        tbl.isPublicity = false
    else
        tbl.isPublicitySpecified = true
    end
    if tbl.fixedPrice == nil then
        tbl.fixedPriceSpecified = false
        tbl.fixedPrice = 0
    else
        tbl.fixedPriceSpecified = true
    end
end

--region metatable auctionV2.AddToShelfResponse
---@type auctionV2.AddToShelfResponse
auctionV2_adj.metatable_AddToShelfResponse = {
    _ClassName = "auctionV2.AddToShelfResponse",
}
auctionV2_adj.metatable_AddToShelfResponse.__index = auctionV2_adj.metatable_AddToShelfResponse
--endregion

---@param tbl auctionV2.AddToShelfResponse 待调整的table数据
function auctionV2_adj.AdjustAddToShelfResponse(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_AddToShelfResponse)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.item == nil then
        tbl.itemSpecified = false
        tbl.item = nil
    else
        if tbl.itemSpecified == nil then 
            tbl.itemSpecified = true
            if auctionV2_adj.AdjustAuctionItemInfo ~= nil then
                auctionV2_adj.AdjustAuctionItemInfo(tbl.item)
            end
        end
    end
end

--region metatable auctionV2.ReAddToShelfRequest
---@type auctionV2.ReAddToShelfRequest
auctionV2_adj.metatable_ReAddToShelfRequest = {
    _ClassName = "auctionV2.ReAddToShelfRequest",
}
auctionV2_adj.metatable_ReAddToShelfRequest.__index = auctionV2_adj.metatable_ReAddToShelfRequest
--endregion

---@param tbl auctionV2.ReAddToShelfRequest 待调整的table数据
function auctionV2_adj.AdjustReAddToShelfRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_ReAddToShelfRequest)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.price == nil then
        tbl.priceSpecified = false
        tbl.price = nil
    else
        if tbl.priceSpecified == nil then 
            tbl.priceSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustCoinInfo ~= nil then
                adjustTable.bag_adj.AdjustCoinInfo(tbl.price)
            end
        end
    end
    if tbl.isPublicity == nil then
        tbl.isPublicitySpecified = false
        tbl.isPublicity = false
    else
        tbl.isPublicitySpecified = true
    end
    if tbl.itemType == nil then
        tbl.itemTypeSpecified = false
        tbl.itemType = 0
    else
        tbl.itemTypeSpecified = true
    end
    if tbl.fixedPrice == nil then
        tbl.fixedPriceSpecified = false
        tbl.fixedPrice = 0
    else
        tbl.fixedPriceSpecified = true
    end
end

--region metatable auctionV2.PutOffRequest
---@type auctionV2.PutOffRequest
auctionV2_adj.metatable_PutOffRequest = {
    _ClassName = "auctionV2.PutOffRequest",
}
auctionV2_adj.metatable_PutOffRequest.__index = auctionV2_adj.metatable_PutOffRequest
--endregion

---@param tbl auctionV2.PutOffRequest 待调整的table数据
function auctionV2_adj.AdjustPutOffRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_PutOffRequest)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.itemType == nil then
        tbl.itemTypeSpecified = false
        tbl.itemType = 0
    else
        tbl.itemTypeSpecified = true
    end
end

--region metatable auctionV2.ItemIdMsg
---@type auctionV2.ItemIdMsg
auctionV2_adj.metatable_ItemIdMsg = {
    _ClassName = "auctionV2.ItemIdMsg",
}
auctionV2_adj.metatable_ItemIdMsg.__index = auctionV2_adj.metatable_ItemIdMsg
--endregion

---@param tbl auctionV2.ItemIdMsg 待调整的table数据
function auctionV2_adj.AdjustItemIdMsg(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_ItemIdMsg)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
end

--region metatable auctionV2.ItemMsg
---@type auctionV2.ItemMsg
auctionV2_adj.metatable_ItemMsg = {
    _ClassName = "auctionV2.ItemMsg",
}
auctionV2_adj.metatable_ItemMsg.__index = auctionV2_adj.metatable_ItemMsg
--endregion

---@param tbl auctionV2.ItemMsg 待调整的table数据
function auctionV2_adj.AdjustItemMsg(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_ItemMsg)
    if tbl.itemType == nil then
        tbl.itemTypeSpecified = false
        tbl.itemType = 0
    else
        tbl.itemTypeSpecified = true
    end
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
end

--region metatable auctionV2.GetOneSelfItemList
---@type auctionV2.GetOneSelfItemList
auctionV2_adj.metatable_GetOneSelfItemList = {
    _ClassName = "auctionV2.GetOneSelfItemList",
}
auctionV2_adj.metatable_GetOneSelfItemList.__index = auctionV2_adj.metatable_GetOneSelfItemList
--endregion

---@param tbl auctionV2.GetOneSelfItemList 待调整的table数据
function auctionV2_adj.AdjustGetOneSelfItemList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_GetOneSelfItemList)
    if tbl.itemType == nil then
        tbl.itemTypeSpecified = false
        tbl.itemType = 0
    else
        tbl.itemTypeSpecified = true
    end
end

--region metatable auctionV2.SearchAuctionItem
---@type auctionV2.SearchAuctionItem
auctionV2_adj.metatable_SearchAuctionItem = {
    _ClassName = "auctionV2.SearchAuctionItem",
}
auctionV2_adj.metatable_SearchAuctionItem.__index = auctionV2_adj.metatable_SearchAuctionItem
--endregion

---@param tbl auctionV2.SearchAuctionItem 待调整的table数据
function auctionV2_adj.AdjustSearchAuctionItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_SearchAuctionItem)
    if tbl.matchesString == nil then
        tbl.matchesStringSpecified = false
        tbl.matchesString = ""
    else
        tbl.matchesStringSpecified = true
    end
    if tbl.condition == nil then
        tbl.conditionSpecified = false
        tbl.condition = nil
    else
        if tbl.conditionSpecified == nil then 
            tbl.conditionSpecified = true
            if auctionV2_adj.AdjustGetAuctionItemsRequest ~= nil then
                auctionV2_adj.AdjustGetAuctionItemsRequest(tbl.condition)
            end
        end
    end
end

--region metatable auctionV2.SearchAuctionItemResponse
---@type auctionV2.SearchAuctionItemResponse
auctionV2_adj.metatable_SearchAuctionItemResponse = {
    _ClassName = "auctionV2.SearchAuctionItemResponse",
}
auctionV2_adj.metatable_SearchAuctionItemResponse.__index = auctionV2_adj.metatable_SearchAuctionItemResponse
--endregion

---@param tbl auctionV2.SearchAuctionItemResponse 待调整的table数据
function auctionV2_adj.AdjustSearchAuctionItemResponse(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_SearchAuctionItemResponse)
    if tbl.list == nil then
        tbl.listSpecified = false
        tbl.list = nil
    else
        if tbl.listSpecified == nil then 
            tbl.listSpecified = true
            if auctionV2_adj.AdjustAuctionItemList ~= nil then
                auctionV2_adj.AdjustAuctionItemList(tbl.list)
            end
        end
    end
    if tbl.totalCount == nil then
        tbl.totalCountSpecified = false
        tbl.totalCount = 0
    else
        tbl.totalCountSpecified = true
    end
end

--region metatable auctionV2.lose
---@type auctionV2.lose
auctionV2_adj.metatable_lose = {
    _ClassName = "auctionV2.lose",
}
auctionV2_adj.metatable_lose.__index = auctionV2_adj.metatable_lose
--endregion

---@param tbl auctionV2.lose 待调整的table数据
function auctionV2_adj.Adjustlose(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_lose)
end

--region metatable auctionV2.AuctionFailReason
---@type auctionV2.AuctionFailReason
auctionV2_adj.metatable_AuctionFailReason = {
    _ClassName = "auctionV2.AuctionFailReason",
}
auctionV2_adj.metatable_AuctionFailReason.__index = auctionV2_adj.metatable_AuctionFailReason
--endregion

---@param tbl auctionV2.AuctionFailReason 待调整的table数据
function auctionV2_adj.AdjustAuctionFailReason(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_AuctionFailReason)
    if tbl.failReason == nil then
        tbl.failReasonSpecified = false
        tbl.failReason = 0
    else
        tbl.failReasonSpecified = true
    end
end

--region metatable auctionV2.MarketPriceSectionRequest
---@type auctionV2.MarketPriceSectionRequest
auctionV2_adj.metatable_MarketPriceSectionRequest = {
    _ClassName = "auctionV2.MarketPriceSectionRequest",
}
auctionV2_adj.metatable_MarketPriceSectionRequest.__index = auctionV2_adj.metatable_MarketPriceSectionRequest
--endregion

---@param tbl auctionV2.MarketPriceSectionRequest 待调整的table数据
function auctionV2_adj.AdjustMarketPriceSectionRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_MarketPriceSectionRequest)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.MarketPriceSectionType == nil then
        tbl.MarketPriceSectionTypeSpecified = false
        tbl.MarketPriceSectionType = 0
    else
        tbl.MarketPriceSectionTypeSpecified = true
    end
    if tbl.itemType == nil then
        tbl.itemTypeSpecified = false
        tbl.itemType = 0
    else
        tbl.itemTypeSpecified = true
    end
    if tbl.priceItemId == nil then
        tbl.priceItemIdSpecified = false
        tbl.priceItemId = 0
    else
        tbl.priceItemIdSpecified = true
    end
end

--region metatable auctionV2.MarketPriceSection
---@type auctionV2.MarketPriceSection
auctionV2_adj.metatable_MarketPriceSection = {
    _ClassName = "auctionV2.MarketPriceSection",
}
auctionV2_adj.metatable_MarketPriceSection.__index = auctionV2_adj.metatable_MarketPriceSection
--endregion

---@param tbl auctionV2.MarketPriceSection 待调整的table数据
function auctionV2_adj.AdjustMarketPriceSection(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_MarketPriceSection)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.marketPriceSection == nil then
        tbl.marketPriceSectionSpecified = false
        tbl.marketPriceSection = nil
    else
        if tbl.marketPriceSectionSpecified == nil then 
            tbl.marketPriceSectionSpecified = true
            if auctionV2_adj.AdjustBaseMarketPriceSection ~= nil then
                auctionV2_adj.AdjustBaseMarketPriceSection(tbl.marketPriceSection)
            end
        end
    end
    if tbl.otherMarketPriceSection == nil then
        tbl.otherMarketPriceSectionSpecified = false
        tbl.otherMarketPriceSection = nil
    else
        if tbl.otherMarketPriceSectionSpecified == nil then 
            tbl.otherMarketPriceSectionSpecified = true
            if auctionV2_adj.AdjustBaseMarketPriceSection ~= nil then
                auctionV2_adj.AdjustBaseMarketPriceSection(tbl.otherMarketPriceSection)
            end
        end
    end
    if tbl.MarketPriceSectionType == nil then
        tbl.MarketPriceSectionTypeSpecified = false
        tbl.MarketPriceSectionType = 0
    else
        tbl.MarketPriceSectionTypeSpecified = true
    end
    if tbl.condition == nil then
        tbl.conditionSpecified = false
        tbl.condition = nil
    else
        if tbl.conditionSpecified == nil then 
            tbl.conditionSpecified = true
            if auctionV2_adj.AdjustBuyProductsCondition ~= nil then
                auctionV2_adj.AdjustBuyProductsCondition(tbl.condition)
            end
        end
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
end

--region metatable auctionV2.BaseMarketPriceSection
---@type auctionV2.BaseMarketPriceSection
auctionV2_adj.metatable_BaseMarketPriceSection = {
    _ClassName = "auctionV2.BaseMarketPriceSection",
}
auctionV2_adj.metatable_BaseMarketPriceSection.__index = auctionV2_adj.metatable_BaseMarketPriceSection
--endregion

---@param tbl auctionV2.BaseMarketPriceSection 待调整的table数据
function auctionV2_adj.AdjustBaseMarketPriceSection(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_BaseMarketPriceSection)
    if tbl.priceItemId == nil then
        tbl.priceItemIdSpecified = false
        tbl.priceItemId = 0
    else
        tbl.priceItemIdSpecified = true
    end
    if tbl.lowPrice == nil then
        tbl.lowPriceSpecified = false
        tbl.lowPrice = 0
    else
        tbl.lowPriceSpecified = true
    end
    if tbl.topPrice == nil then
        tbl.topPriceSpecified = false
        tbl.topPrice = 0
    else
        tbl.topPriceSpecified = true
    end
    if tbl.itemType == nil then
        tbl.itemTypeSpecified = false
        tbl.itemType = 0
    else
        tbl.itemTypeSpecified = true
    end
    if tbl.defaultPrice == nil then
        tbl.defaultPriceSpecified = false
        tbl.defaultPrice = 0
    else
        tbl.defaultPriceSpecified = true
    end
    if tbl.ratio == nil then
        tbl.ratioSpecified = false
        tbl.ratio = 0
    else
        tbl.ratioSpecified = true
    end
end

--region metatable auctionV2.BuyAuction
---@type auctionV2.BuyAuction
auctionV2_adj.metatable_BuyAuction = {
    _ClassName = "auctionV2.BuyAuction",
}
auctionV2_adj.metatable_BuyAuction.__index = auctionV2_adj.metatable_BuyAuction
--endregion

---@param tbl auctionV2.BuyAuction 待调整的table数据
function auctionV2_adj.AdjustBuyAuction(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_BuyAuction)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.buyType == nil then
        tbl.buyTypeSpecified = false
        tbl.buyType = 0
    else
        tbl.buyTypeSpecified = true
    end
end

--region metatable auctionV2.BuyProductsCondition
---@type auctionV2.BuyProductsCondition
auctionV2_adj.metatable_BuyProductsCondition = {
    _ClassName = "auctionV2.BuyProductsCondition",
}
auctionV2_adj.metatable_BuyProductsCondition.__index = auctionV2_adj.metatable_BuyProductsCondition
--endregion

---@param tbl auctionV2.BuyProductsCondition 待调整的table数据
function auctionV2_adj.AdjustBuyProductsCondition(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_BuyProductsCondition)
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
    if tbl.minLevel == nil then
        tbl.minLevelSpecified = false
        tbl.minLevel = 0
    else
        tbl.minLevelSpecified = true
    end
    if tbl.maxLevel == nil then
        tbl.maxLevelSpecified = false
        tbl.maxLevel = 0
    else
        tbl.maxLevelSpecified = true
    end
    if tbl.currency == nil then
        tbl.currencySpecified = false
        tbl.currency = 0
    else
        tbl.currencySpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.screenCondition == nil then
        tbl.screenCondition = {}
    end
    if tbl.propertyTendency == nil then
        tbl.propertyTendencySpecified = false
        tbl.propertyTendency = 0
    else
        tbl.propertyTendencySpecified = true
    end
end

--region metatable auctionV2.BuyProductsMarketPriceSectionRequest
---@type auctionV2.BuyProductsMarketPriceSectionRequest
auctionV2_adj.metatable_BuyProductsMarketPriceSectionRequest = {
    _ClassName = "auctionV2.BuyProductsMarketPriceSectionRequest",
}
auctionV2_adj.metatable_BuyProductsMarketPriceSectionRequest.__index = auctionV2_adj.metatable_BuyProductsMarketPriceSectionRequest
--endregion

---@param tbl auctionV2.BuyProductsMarketPriceSectionRequest 待调整的table数据
function auctionV2_adj.AdjustBuyProductsMarketPriceSectionRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_BuyProductsMarketPriceSectionRequest)
    if tbl.condition == nil then
        tbl.conditionSpecified = false
        tbl.condition = nil
    else
        if tbl.conditionSpecified == nil then 
            tbl.conditionSpecified = true
            if auctionV2_adj.AdjustBuyProductsCondition ~= nil then
                auctionV2_adj.AdjustBuyProductsCondition(tbl.condition)
            end
        end
    end
    if tbl.MarketPriceSectionType == nil then
        tbl.MarketPriceSectionTypeSpecified = false
        tbl.MarketPriceSectionType = 0
    else
        tbl.MarketPriceSectionTypeSpecified = true
    end
    if tbl.itemType == nil then
        tbl.itemTypeSpecified = false
        tbl.itemType = 0
    else
        tbl.itemTypeSpecified = true
    end
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
end

--region metatable auctionV2.ReleaseBuyProductsRequest
---@type auctionV2.ReleaseBuyProductsRequest
auctionV2_adj.metatable_ReleaseBuyProductsRequest = {
    _ClassName = "auctionV2.ReleaseBuyProductsRequest",
}
auctionV2_adj.metatable_ReleaseBuyProductsRequest.__index = auctionV2_adj.metatable_ReleaseBuyProductsRequest
--endregion

---@param tbl auctionV2.ReleaseBuyProductsRequest 待调整的table数据
function auctionV2_adj.AdjustReleaseBuyProductsRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_ReleaseBuyProductsRequest)
    if tbl.price == nil then
        tbl.priceSpecified = false
        tbl.price = nil
    else
        if tbl.priceSpecified == nil then 
            tbl.priceSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustCoinInfo ~= nil then
                adjustTable.bag_adj.AdjustCoinInfo(tbl.price)
            end
        end
    end
    if tbl.condition == nil then
        tbl.conditionSpecified = false
        tbl.condition = nil
    else
        if tbl.conditionSpecified == nil then 
            tbl.conditionSpecified = true
            if auctionV2_adj.AdjustBuyProductsCondition ~= nil then
                auctionV2_adj.AdjustBuyProductsCondition(tbl.condition)
            end
        end
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
end

--region metatable auctionV2.SubmitBuyProductsItemRequest
---@type auctionV2.SubmitBuyProductsItemRequest
auctionV2_adj.metatable_SubmitBuyProductsItemRequest = {
    _ClassName = "auctionV2.SubmitBuyProductsItemRequest",
}
auctionV2_adj.metatable_SubmitBuyProductsItemRequest.__index = auctionV2_adj.metatable_SubmitBuyProductsItemRequest
--endregion

---@param tbl auctionV2.SubmitBuyProductsItemRequest 待调整的table数据
function auctionV2_adj.AdjustSubmitBuyProductsItemRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_SubmitBuyProductsItemRequest)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.priceId == nil then
        tbl.priceIdSpecified = false
        tbl.priceId = 0
    else
        tbl.priceIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable auctionV2.SubmitBuyProductsItemResponse
---@type auctionV2.SubmitBuyProductsItemResponse
auctionV2_adj.metatable_SubmitBuyProductsItemResponse = {
    _ClassName = "auctionV2.SubmitBuyProductsItemResponse",
}
auctionV2_adj.metatable_SubmitBuyProductsItemResponse.__index = auctionV2_adj.metatable_SubmitBuyProductsItemResponse
--endregion

---@param tbl auctionV2.SubmitBuyProductsItemResponse 待调整的table数据
function auctionV2_adj.AdjustSubmitBuyProductsItemResponse(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_SubmitBuyProductsItemResponse)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.item == nil then
        tbl.itemSpecified = false
        tbl.item = nil
    else
        if tbl.itemSpecified == nil then 
            tbl.itemSpecified = true
            if auctionV2_adj.AdjustAuctionItemInfo ~= nil then
                auctionV2_adj.AdjustAuctionItemInfo(tbl.item)
            end
        end
    end
    if tbl.leftCount == nil then
        tbl.leftCountSpecified = false
        tbl.leftCount = 0
    else
        tbl.leftCountSpecified = true
    end
end

--region metatable auctionV2.auctionRequest
---@type auctionV2.auctionRequest
auctionV2_adj.metatable_auctionRequest = {
    _ClassName = "auctionV2.auctionRequest",
}
auctionV2_adj.metatable_auctionRequest.__index = auctionV2_adj.metatable_auctionRequest
--endregion

---@param tbl auctionV2.auctionRequest 待调整的table数据
function auctionV2_adj.AdjustauctionRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_auctionRequest)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.AuctionType == nil then
        tbl.AuctionTypeSpecified = false
        tbl.AuctionType = 0
    else
        tbl.AuctionTypeSpecified = true
    end
end

--region metatable auctionV2.pushResponse
---@type auctionV2.pushResponse
auctionV2_adj.metatable_pushResponse = {
    _ClassName = "auctionV2.pushResponse",
}
auctionV2_adj.metatable_pushResponse.__index = auctionV2_adj.metatable_pushResponse
--endregion

---@param tbl auctionV2.pushResponse 待调整的table数据
function auctionV2_adj.AdjustpushResponse(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_pushResponse)
    if tbl.PushType == nil then
        tbl.PushTypeSpecified = false
        tbl.PushType = 0
    else
        tbl.PushTypeSpecified = true
    end
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
    if tbl.priceItemId == nil then
        tbl.priceItemIdSpecified = false
        tbl.priceItemId = 0
    else
        tbl.priceItemIdSpecified = true
    end
    if tbl.price == nil then
        tbl.priceSpecified = false
        tbl.price = 0
    else
        tbl.priceSpecified = true
    end
end

--region metatable auctionV2.GuessYouLikeRequest
---@type auctionV2.GuessYouLikeRequest
auctionV2_adj.metatable_GuessYouLikeRequest = {
    _ClassName = "auctionV2.GuessYouLikeRequest",
}
auctionV2_adj.metatable_GuessYouLikeRequest.__index = auctionV2_adj.metatable_GuessYouLikeRequest
--endregion

---@param tbl auctionV2.GuessYouLikeRequest 待调整的table数据
function auctionV2_adj.AdjustGuessYouLikeRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_GuessYouLikeRequest)
    if tbl.itemType == nil then
        tbl.itemTypeSpecified = false
        tbl.itemType = 0
    else
        tbl.itemTypeSpecified = true
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
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable auctionV2.GuessYouLikeResponse
---@type auctionV2.GuessYouLikeResponse
auctionV2_adj.metatable_GuessYouLikeResponse = {
    _ClassName = "auctionV2.GuessYouLikeResponse",
}
auctionV2_adj.metatable_GuessYouLikeResponse.__index = auctionV2_adj.metatable_GuessYouLikeResponse
--endregion

---@param tbl auctionV2.GuessYouLikeResponse 待调整的table数据
function auctionV2_adj.AdjustGuessYouLikeResponse(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_GuessYouLikeResponse)
    if tbl.itemType == nil then
        tbl.itemTypeSpecified = false
        tbl.itemType = 0
    else
        tbl.itemTypeSpecified = true
    end
    if tbl.items == nil then
        tbl.items = {}
    else
        if auctionV2_adj.AdjustAuctionItemInfo ~= nil then
            for i = 1, #tbl.items do
                auctionV2_adj.AdjustAuctionItemInfo(tbl.items[i])
            end
        end
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
end

--region metatable auctionV2.OpenTradeBeforeResponse
---@type auctionV2.OpenTradeBeforeResponse
auctionV2_adj.metatable_OpenTradeBeforeResponse = {
    _ClassName = "auctionV2.OpenTradeBeforeResponse",
}
auctionV2_adj.metatable_OpenTradeBeforeResponse.__index = auctionV2_adj.metatable_OpenTradeBeforeResponse
--endregion

---@param tbl auctionV2.OpenTradeBeforeResponse 待调整的table数据
function auctionV2_adj.AdjustOpenTradeBeforeResponse(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_OpenTradeBeforeResponse)
    if tbl.bagItemState == nil then
        tbl.bagItemState = {}
    else
        if auctionV2_adj.AdjustBagItemState ~= nil then
            for i = 1, #tbl.bagItemState do
                auctionV2_adj.AdjustBagItemState(tbl.bagItemState[i])
            end
        end
    end
end

--region metatable auctionV2.BagItemState
---@type auctionV2.BagItemState
auctionV2_adj.metatable_BagItemState = {
    _ClassName = "auctionV2.BagItemState",
}
auctionV2_adj.metatable_BagItemState.__index = auctionV2_adj.metatable_BagItemState
--endregion

---@param tbl auctionV2.BagItemState 待调整的table数据
function auctionV2_adj.AdjustBagItemState(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_BagItemState)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.saleMoney == nil then
        tbl.saleMoneySpecified = false
        tbl.saleMoney = 0
    else
        tbl.saleMoneySpecified = true
    end
    if tbl.saleDiamond == nil then
        tbl.saleDiamondSpecified = false
        tbl.saleDiamond = 0
    else
        tbl.saleDiamondSpecified = true
    end
    if tbl.auctionDiamond == nil then
        tbl.auctionDiamondSpecified = false
        tbl.auctionDiamond = 0
    else
        tbl.auctionDiamondSpecified = true
    end
end

--region metatable auctionV2.TransactionRecord
---@type auctionV2.TransactionRecord
auctionV2_adj.metatable_TransactionRecord = {
    _ClassName = "auctionV2.TransactionRecord",
}
auctionV2_adj.metatable_TransactionRecord.__index = auctionV2_adj.metatable_TransactionRecord
--endregion

---@param tbl auctionV2.TransactionRecord 待调整的table数据
function auctionV2_adj.AdjustTransactionRecord(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_TransactionRecord)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.goods == nil then
        tbl.goodsSpecified = false
        tbl.goods = nil
    else
        if tbl.goodsSpecified == nil then 
            tbl.goodsSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.goods)
            end
        end
    end
    if tbl.tradeType == nil then
        tbl.tradeTypeSpecified = false
        tbl.tradeType = 0
    else
        tbl.tradeTypeSpecified = true
    end
    if tbl.tradeTime == nil then
        tbl.tradeTimeSpecified = false
        tbl.tradeTime = 0
    else
        tbl.tradeTimeSpecified = true
    end
    if tbl.moneyId == nil then
        tbl.moneyIdSpecified = false
        tbl.moneyId = 0
    else
        tbl.moneyIdSpecified = true
    end
    if tbl.moneyCount == nil then
        tbl.moneyCountSpecified = false
        tbl.moneyCount = 0
    else
        tbl.moneyCountSpecified = true
    end
    if tbl.substractMoney == nil then
        tbl.substractMoneySpecified = false
        tbl.substractMoney = 0
    else
        tbl.substractMoneySpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable auctionV2.TeadeRecordReq
---@type auctionV2.TeadeRecordReq
auctionV2_adj.metatable_TeadeRecordReq = {
    _ClassName = "auctionV2.TeadeRecordReq",
}
auctionV2_adj.metatable_TeadeRecordReq.__index = auctionV2_adj.metatable_TeadeRecordReq
--endregion

---@param tbl auctionV2.TeadeRecordReq 待调整的table数据
function auctionV2_adj.AdjustTeadeRecordReq(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_TeadeRecordReq)
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

--region metatable auctionV2.TeadeRecordRes
---@type auctionV2.TeadeRecordRes
auctionV2_adj.metatable_TeadeRecordRes = {
    _ClassName = "auctionV2.TeadeRecordRes",
}
auctionV2_adj.metatable_TeadeRecordRes.__index = auctionV2_adj.metatable_TeadeRecordRes
--endregion

---@param tbl auctionV2.TeadeRecordRes 待调整的table数据
function auctionV2_adj.AdjustTeadeRecordRes(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_TeadeRecordRes)
    if tbl.records == nil then
        tbl.recordsSpecified = false
        tbl.records = nil
    else
        if tbl.recordsSpecified == nil then 
            tbl.recordsSpecified = true
            if auctionV2_adj.AdjusttradeRecordList ~= nil then
                auctionV2_adj.AdjusttradeRecordList(tbl.records)
            end
        end
    end
    if tbl.toatlPageCount == nil then
        tbl.toatlPageCountSpecified = false
        tbl.toatlPageCount = 0
    else
        tbl.toatlPageCountSpecified = true
    end
    if tbl.page == nil then
        tbl.pageSpecified = false
        tbl.page = 0
    else
        tbl.pageSpecified = true
    end
    if tbl.firstCanReceive == nil then
        tbl.firstCanReceiveSpecified = false
        tbl.firstCanReceive = 0
    else
        tbl.firstCanReceiveSpecified = true
    end
    if tbl.totalCount == nil then
        tbl.totalCountSpecified = false
        tbl.totalCount = 0
    else
        tbl.totalCountSpecified = true
    end
end

--region metatable auctionV2.tradeRecordList
---@type auctionV2.tradeRecordList
auctionV2_adj.metatable_tradeRecordList = {
    _ClassName = "auctionV2.tradeRecordList",
}
auctionV2_adj.metatable_tradeRecordList.__index = auctionV2_adj.metatable_tradeRecordList
--endregion

---@param tbl auctionV2.tradeRecordList 待调整的table数据
function auctionV2_adj.AdjusttradeRecordList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_tradeRecordList)
    if tbl.record == nil then
        tbl.record = {}
    else
        if auctionV2_adj.AdjustTransactionRecord ~= nil then
            for i = 1, #tbl.record do
                auctionV2_adj.AdjustTransactionRecord(tbl.record[i])
            end
        end
    end
end

--region metatable auctionV2.TradeRecordId
---@type auctionV2.TradeRecordId
auctionV2_adj.metatable_TradeRecordId = {
    _ClassName = "auctionV2.TradeRecordId",
}
auctionV2_adj.metatable_TradeRecordId.__index = auctionV2_adj.metatable_TradeRecordId
--endregion

---@param tbl auctionV2.TradeRecordId 待调整的table数据
function auctionV2_adj.AdjustTradeRecordId(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_TradeRecordId)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable auctionV2.TradeRecordRedPoint
---@type auctionV2.TradeRecordRedPoint
auctionV2_adj.metatable_TradeRecordRedPoint = {
    _ClassName = "auctionV2.TradeRecordRedPoint",
}
auctionV2_adj.metatable_TradeRecordRedPoint.__index = auctionV2_adj.metatable_TradeRecordRedPoint
--endregion

---@param tbl auctionV2.TradeRecordRedPoint 待调整的table数据
function auctionV2_adj.AdjustTradeRecordRedPoint(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_TradeRecordRedPoint)
    if tbl.redPoint == nil then
        tbl.redPointSpecified = false
        tbl.redPoint = 0
    else
        tbl.redPointSpecified = true
    end
end

--region metatable auctionV2.UnionSmeltGoodsChange
---@type auctionV2.UnionSmeltGoodsChange
auctionV2_adj.metatable_UnionSmeltGoodsChange = {
    _ClassName = "auctionV2.UnionSmeltGoodsChange",
}
auctionV2_adj.metatable_UnionSmeltGoodsChange.__index = auctionV2_adj.metatable_UnionSmeltGoodsChange
--endregion

---@param tbl auctionV2.UnionSmeltGoodsChange 待调整的table数据
function auctionV2_adj.AdjustUnionSmeltGoodsChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_UnionSmeltGoodsChange)
    if tbl.items == nil then
        tbl.items = {}
    else
        if auctionV2_adj.AdjustAuctionItemInfo ~= nil then
            for i = 1, #tbl.items do
                auctionV2_adj.AdjustAuctionItemInfo(tbl.items[i])
            end
        end
    end
    if tbl.changeType == nil then
        tbl.changeTypeSpecified = false
        tbl.changeType = 0
    else
        tbl.changeTypeSpecified = true
    end
end

--region metatable auctionV2.BuyUnionSmeltItem
---@type auctionV2.BuyUnionSmeltItem
auctionV2_adj.metatable_BuyUnionSmeltItem = {
    _ClassName = "auctionV2.BuyUnionSmeltItem",
}
auctionV2_adj.metatable_BuyUnionSmeltItem.__index = auctionV2_adj.metatable_BuyUnionSmeltItem
--endregion

---@param tbl auctionV2.BuyUnionSmeltItem 待调整的table数据
function auctionV2_adj.AdjustBuyUnionSmeltItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_BuyUnionSmeltItem)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable auctionV2.AuctionPush
---@type auctionV2.AuctionPush
auctionV2_adj.metatable_AuctionPush = {
    _ClassName = "auctionV2.AuctionPush",
}
auctionV2_adj.metatable_AuctionPush.__index = auctionV2_adj.metatable_AuctionPush
--endregion

---@param tbl auctionV2.AuctionPush 待调整的table数据
function auctionV2_adj.AdjustAuctionPush(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_AuctionPush)
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
    if tbl.pushType == nil then
        tbl.pushTypeSpecified = false
        tbl.pushType = 0
    else
        tbl.pushTypeSpecified = true
    end
    if tbl.sign == nil then
        tbl.signSpecified = false
        tbl.sign = 0
    else
        tbl.signSpecified = true
    end
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
end

--region metatable auctionV2.CurLoginNoPush
---@type auctionV2.CurLoginNoPush
auctionV2_adj.metatable_CurLoginNoPush = {
    _ClassName = "auctionV2.CurLoginNoPush",
}
auctionV2_adj.metatable_CurLoginNoPush.__index = auctionV2_adj.metatable_CurLoginNoPush
--endregion

---@param tbl auctionV2.CurLoginNoPush 待调整的table数据
function auctionV2_adj.AdjustCurLoginNoPush(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_CurLoginNoPush)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable auctionV2.ReqQuickAuctionItem
---@type auctionV2.ReqQuickAuctionItem
auctionV2_adj.metatable_ReqQuickAuctionItem = {
    _ClassName = "auctionV2.ReqQuickAuctionItem",
}
auctionV2_adj.metatable_ReqQuickAuctionItem.__index = auctionV2_adj.metatable_ReqQuickAuctionItem
--endregion

---@param tbl auctionV2.ReqQuickAuctionItem 待调整的table数据
function auctionV2_adj.AdjustReqQuickAuctionItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_ReqQuickAuctionItem)
    if tbl.itemIds == nil then
        tbl.itemIds = {}
    end
end

--region metatable auctionV2.ResQuickAuctionItem
---@type auctionV2.ResQuickAuctionItem
auctionV2_adj.metatable_ResQuickAuctionItem = {
    _ClassName = "auctionV2.ResQuickAuctionItem",
}
auctionV2_adj.metatable_ResQuickAuctionItem.__index = auctionV2_adj.metatable_ResQuickAuctionItem
--endregion

---@param tbl auctionV2.ResQuickAuctionItem 待调整的table数据
function auctionV2_adj.AdjustResQuickAuctionItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, auctionV2_adj.metatable_ResQuickAuctionItem)
    if tbl.items == nil then
        tbl.items = {}
    else
        if auctionV2_adj.AdjustAuctionItemInfo ~= nil then
            for i = 1, #tbl.items do
                auctionV2_adj.AdjustAuctionItemInfo(tbl.items[i])
            end
        end
    end
end

return auctionV2_adj