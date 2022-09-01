--[[本文件为工具自动生成,禁止手动修改]]
local auctionV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData auctionV2.AuctionItemInfo lua中的数据结构
---@return auctionV2.AuctionItemInfo C#中的数据结构
function auctionV2.AuctionItemInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.AuctionItemInfo()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.itemType ~= nil and decodedData.itemTypeSpecified ~= false then
        data.itemType = decodedData.itemType
    end
    if decodedData.item ~= nil and decodedData.itemSpecified ~= false then
        data.item = decodeTable.bag.BagItemInfo(decodedData.item)
    end
    if decodedData.price ~= nil and decodedData.priceSpecified ~= false then
        data.price = decodeTable.bag.CoinInfo(decodedData.price)
    end
    if decodedData.addTime ~= nil and decodedData.addTimeSpecified ~= false then
        data.addTime = decodedData.addTime
    end
    if decodedData.serverId ~= nil and decodedData.serverIdSpecified ~= false then
        data.serverId = decodedData.serverId
    end
    if decodedData.overdueTime ~= nil and decodedData.overdueTimeSpecified ~= false then
        data.overdueTime = decodedData.overdueTime
    end
    if decodedData.itemCount ~= nil and decodedData.itemCountSpecified ~= false then
        data.itemCount = decodedData.itemCount
    end
    if decodedData.auctionItemLotInfo ~= nil and decodedData.auctionItemLotInfoSpecified ~= false then
        data.auctionItemLotInfo = auctionV2.AuctionItemLotInfo(decodedData.auctionItemLotInfo)
    end
    if decodedData.auctionItemBuyProductsInfo ~= nil and decodedData.auctionItemBuyProductsInfoSpecified ~= false then
        data.auctionItemBuyProductsInfo = auctionV2.AuctionItemBuyProductsInfo(decodedData.auctionItemBuyProductsInfo)
    end
    if decodedData.delayTime ~= nil and decodedData.delayTimeSpecified ~= false then
        data.delayTime = decodedData.delayTime
    end
    if decodedData.bidState ~= nil and decodedData.bidStateSpecified ~= false then
        data.bidState = decodedData.bidState
    end
    return data
end

---@param decodedData auctionV2.AuctionItemLotInfo lua中的数据结构
---@return auctionV2.AuctionItemLotInfo C#中的数据结构
function auctionV2.AuctionItemLotInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.AuctionItemLotInfo()
    if decodedData.bidderRid ~= nil and decodedData.bidderRidSpecified ~= false then
        data.bidderRid = decodedData.bidderRid
    end
    if decodedData.bidPrice ~= nil and decodedData.bidPriceSpecified ~= false then
        data.bidPrice = decodedData.bidPrice
    end
    if decodedData.isPublicity ~= nil and decodedData.isPublicitySpecified ~= false then
        data.isPublicity = decodedData.isPublicity
    end
    if decodedData.publicityTime ~= nil and decodedData.publicityTimeSpecified ~= false then
        data.publicityTime = decodedData.publicityTime
    end
    if decodedData.fixedPrice ~= nil and decodedData.fixedPriceSpecified ~= false then
        data.fixedPrice = decodedData.fixedPrice
    end
    return data
end

---@param decodedData auctionV2.AuctionItemBuyProductsInfo lua中的数据结构
---@return auctionV2.AuctionItemBuyProductsInfo C#中的数据结构
function auctionV2.AuctionItemBuyProductsInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.AuctionItemBuyProductsInfo()
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.minLevel ~= nil and decodedData.minLevelSpecified ~= false then
        data.minLevel = decodedData.minLevel
    end
    if decodedData.maxLevel ~= nil and decodedData.maxLevelSpecified ~= false then
        data.maxLevel = decodedData.maxLevel
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.carreer ~= nil and decodedData.carreerSpecified ~= false then
        data.carreer = decodedData.carreer
    end
    if decodedData.screenCondition ~= nil and decodedData.screenConditionSpecified ~= false then
        for i = 1, #decodedData.screenCondition do
            data.screenCondition:Add(decodedData.screenCondition[i])
        end
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.propertyTendency ~= nil and decodedData.propertyTendencySpecified ~= false then
        data.propertyTendency = decodedData.propertyTendency
    end
    return data
end

---@param decodedData auctionV2.AuctionItemList lua中的数据结构
---@return auctionV2.AuctionItemList C#中的数据结构
function auctionV2.AuctionItemList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.AuctionItemList()
    if decodedData.items ~= nil and decodedData.itemsSpecified ~= false then
        for i = 1, #decodedData.items do
            data.items:Add(auctionV2.AuctionItemInfo(decodedData.items[i]))
        end
    end
    if decodedData.page ~= nil and decodedData.pageSpecified ~= false then
        data.page = decodedData.page
    end
    if decodedData.toatlPageCount ~= nil and decodedData.toatlPageCountSpecified ~= false then
        data.toatlPageCount = decodedData.toatlPageCount
    end
    if decodedData.isUnionSmelt ~= nil and decodedData.isUnionSmeltSpecified ~= false then
        data.isUnionSmelt = decodedData.isUnionSmelt
    end
    return data
end

---@param decodedData auctionV2.AuctionItemShelfList lua中的数据结构
---@return auctionV2.AuctionItemShelfList C#中的数据结构
function auctionV2.AuctionItemShelfList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.AuctionItemShelfList()
    if decodedData.itemType ~= nil and decodedData.itemTypeSpecified ~= false then
        data.itemType = decodedData.itemType
    end
    if decodedData.items ~= nil and decodedData.itemsSpecified ~= false then
        for i = 1, #decodedData.items do
            data.items:Add(auctionV2.AuctionItemInfo(decodedData.items[i]))
        end
    end
    return data
end

---@param decodedData auctionV2.GetAuctionItemsRequest lua中的数据结构
---@return auctionV2.GetAuctionItemsRequest C#中的数据结构
function auctionV2.GetAuctionItemsRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.GetAuctionItemsRequest()
    if decodedData.page ~= nil and decodedData.pageSpecified ~= false then
        data.page = decodedData.page
    end
    if decodedData.minLevel ~= nil and decodedData.minLevelSpecified ~= false then
        data.minLevel = decodedData.minLevel
    end
    if decodedData.maxLevel ~= nil and decodedData.maxLevelSpecified ~= false then
        data.maxLevel = decodedData.maxLevel
    end
    if decodedData.currency ~= nil and decodedData.currencySpecified ~= false then
        data.currency = decodedData.currency
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.toatlPageCount ~= nil and decodedData.toatlPageCountSpecified ~= false then
        data.toatlPageCount = decodedData.toatlPageCount
    end
    if decodedData.screenCondition ~= nil and decodedData.screenConditionSpecified ~= false then
        for i = 1, #decodedData.screenCondition do
            data.screenCondition:Add(decodedData.screenCondition[i])
        end
    end
    if decodedData.itemType ~= nil and decodedData.itemTypeSpecified ~= false then
        data.itemType = decodedData.itemType
    end
    if decodedData.sortBy ~= nil and decodedData.sortBySpecified ~= false then
        data.sortBy = decodedData.sortBy
    end
    if decodedData.sort ~= nil and decodedData.sortSpecified ~= false then
        data.sort = decodedData.sort
    end
    if decodedData.propertyTendency ~= nil and decodedData.propertyTendencySpecified ~= false then
        data.propertyTendency = decodedData.propertyTendency
    end
    if decodedData.selectType ~= nil and decodedData.selectTypeSpecified ~= false then
        data.selectType = decodedData.selectType
    end
    return data
end

---@param decodedData auctionV2.AddToShelfRequest lua中的数据结构
---@return auctionV2.AddToShelfRequest C#中的数据结构
function auctionV2.AddToShelfRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.AddToShelfRequest()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.price ~= nil and decodedData.priceSpecified ~= false then
        data.price = decodeTable.bag.CoinInfo(decodedData.price)
    end
    if decodedData.itemType ~= nil and decodedData.itemTypeSpecified ~= false then
        data.itemType = decodedData.itemType
    end
    if decodedData.isPublicity ~= nil and decodedData.isPublicitySpecified ~= false then
        data.isPublicity = decodedData.isPublicity
    end
    if decodedData.fixedPrice ~= nil and decodedData.fixedPriceSpecified ~= false then
        data.fixedPrice = decodedData.fixedPrice
    end
    return data
end

---@param decodedData auctionV2.AddToShelfResponse lua中的数据结构
---@return auctionV2.AddToShelfResponse C#中的数据结构
function auctionV2.AddToShelfResponse(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.AddToShelfResponse()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.item ~= nil and decodedData.itemSpecified ~= false then
        data.item = auctionV2.AuctionItemInfo(decodedData.item)
    end
    return data
end

---@param decodedData auctionV2.ReAddToShelfRequest lua中的数据结构
---@return auctionV2.ReAddToShelfRequest C#中的数据结构
function auctionV2.ReAddToShelfRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.ReAddToShelfRequest()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.price ~= nil and decodedData.priceSpecified ~= false then
        data.price = decodeTable.bag.CoinInfo(decodedData.price)
    end
    if decodedData.isPublicity ~= nil and decodedData.isPublicitySpecified ~= false then
        data.isPublicity = decodedData.isPublicity
    end
    if decodedData.itemType ~= nil and decodedData.itemTypeSpecified ~= false then
        data.itemType = decodedData.itemType
    end
    if decodedData.fixedPrice ~= nil and decodedData.fixedPriceSpecified ~= false then
        data.fixedPrice = decodedData.fixedPrice
    end
    return data
end

---@param decodedData auctionV2.PutOffRequest lua中的数据结构
---@return auctionV2.PutOffRequest C#中的数据结构
function auctionV2.PutOffRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.PutOffRequest()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.itemType ~= nil and decodedData.itemTypeSpecified ~= false then
        data.itemType = decodedData.itemType
    end
    return data
end

---@param decodedData auctionV2.ItemIdMsg lua中的数据结构
---@return auctionV2.ItemIdMsg C#中的数据结构
function auctionV2.ItemIdMsg(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.ItemIdMsg()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    return data
end

---@param decodedData auctionV2.ItemMsg lua中的数据结构
---@return auctionV2.ItemMsg C#中的数据结构
function auctionV2.ItemMsg(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.ItemMsg()
    if decodedData.itemType ~= nil and decodedData.itemTypeSpecified ~= false then
        data.itemType = decodedData.itemType
    end
    if decodedData.item ~= nil and decodedData.itemSpecified ~= false then
        data.item = decodeTable.bag.BagItemInfo(decodedData.item)
    end
    return data
end

---@param decodedData auctionV2.GetOneSelfItemList lua中的数据结构
---@return auctionV2.GetOneSelfItemList C#中的数据结构
function auctionV2.GetOneSelfItemList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.GetOneSelfItemList()
    if decodedData.itemType ~= nil and decodedData.itemTypeSpecified ~= false then
        data.itemType = decodedData.itemType
    end
    return data
end

---@param decodedData auctionV2.SearchAuctionItem lua中的数据结构
---@return auctionV2.SearchAuctionItem C#中的数据结构
function auctionV2.SearchAuctionItem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.SearchAuctionItem()
    if decodedData.matchesString ~= nil and decodedData.matchesStringSpecified ~= false then
        data.matchesString = decodedData.matchesString
    end
    if decodedData.condition ~= nil and decodedData.conditionSpecified ~= false then
        data.condition = auctionV2.GetAuctionItemsRequest(decodedData.condition)
    end
    return data
end

---@param decodedData auctionV2.SearchAuctionItemResponse lua中的数据结构
---@return auctionV2.SearchAuctionItemResponse C#中的数据结构
function auctionV2.SearchAuctionItemResponse(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.SearchAuctionItemResponse()
    if decodedData.list ~= nil and decodedData.listSpecified ~= false then
        data.list = auctionV2.AuctionItemList(decodedData.list)
    end
    if decodedData.totalCount ~= nil and decodedData.totalCountSpecified ~= false then
        data.totalCount = decodedData.totalCount
    end
    return data
end

---@param decodedData auctionV2.lose lua中的数据结构
---@return auctionV2.lose C#中的数据结构
function auctionV2.lose(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.lose()
    return data
end

---@param decodedData auctionV2.AuctionFailReason lua中的数据结构
---@return auctionV2.AuctionFailReason C#中的数据结构
function auctionV2.AuctionFailReason(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.AuctionFailReason()
    if decodedData.failReason ~= nil and decodedData.failReasonSpecified ~= false then
        data.failReason = decodedData.failReason
    end
    return data
end

---@param decodedData auctionV2.MarketPriceSectionRequest lua中的数据结构
---@return auctionV2.MarketPriceSectionRequest C#中的数据结构
function auctionV2.MarketPriceSectionRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.MarketPriceSectionRequest()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.MarketPriceSectionType ~= nil and decodedData.MarketPriceSectionTypeSpecified ~= false then
        data.MarketPriceSectionType = decodedData.MarketPriceSectionType
    end
    if decodedData.itemType ~= nil and decodedData.itemTypeSpecified ~= false then
        data.itemType = decodedData.itemType
    end
    if decodedData.priceItemId ~= nil and decodedData.priceItemIdSpecified ~= false then
        data.priceItemId = decodedData.priceItemId
    end
    return data
end

---@param decodedData auctionV2.MarketPriceSection lua中的数据结构
---@return auctionV2.MarketPriceSection C#中的数据结构
function auctionV2.MarketPriceSection(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.MarketPriceSection()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.marketPriceSection ~= nil and decodedData.marketPriceSectionSpecified ~= false then
        data.marketPriceSection = auctionV2.BaseMarketPriceSection(decodedData.marketPriceSection)
    end
    if decodedData.otherMarketPriceSection ~= nil and decodedData.otherMarketPriceSectionSpecified ~= false then
        data.otherMarketPriceSection = auctionV2.BaseMarketPriceSection(decodedData.otherMarketPriceSection)
    end
    if decodedData.MarketPriceSectionType ~= nil and decodedData.MarketPriceSectionTypeSpecified ~= false then
        data.MarketPriceSectionType = decodedData.MarketPriceSectionType
    end
    if decodedData.condition ~= nil and decodedData.conditionSpecified ~= false then
        data.condition = auctionV2.BuyProductsCondition(decodedData.condition)
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    return data
end

---@param decodedData auctionV2.BaseMarketPriceSection lua中的数据结构
---@return auctionV2.BaseMarketPriceSection C#中的数据结构
function auctionV2.BaseMarketPriceSection(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.BaseMarketPriceSection()
    if decodedData.priceItemId ~= nil and decodedData.priceItemIdSpecified ~= false then
        data.priceItemId = decodedData.priceItemId
    end
    if decodedData.lowPrice ~= nil and decodedData.lowPriceSpecified ~= false then
        data.lowPrice = decodedData.lowPrice
    end
    if decodedData.topPrice ~= nil and decodedData.topPriceSpecified ~= false then
        data.topPrice = decodedData.topPrice
    end
    if decodedData.itemType ~= nil and decodedData.itemTypeSpecified ~= false then
        data.itemType = decodedData.itemType
    end
    if decodedData.defaultPrice ~= nil and decodedData.defaultPriceSpecified ~= false then
        data.defaultPrice = decodedData.defaultPrice
    end
    if decodedData.ratio ~= nil and decodedData.ratioSpecified ~= false then
        data.ratio = decodedData.ratio
    end
    return data
end

---@param decodedData auctionV2.BuyAuction lua中的数据结构
---@return auctionV2.BuyAuction C#中的数据结构
function auctionV2.BuyAuction(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.BuyAuction()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.buyType ~= nil and decodedData.buyTypeSpecified ~= false then
        data.buyType = decodedData.buyType
    end
    return data
end

---@param decodedData auctionV2.BuyProductsCondition lua中的数据结构
---@return auctionV2.BuyProductsCondition C#中的数据结构
function auctionV2.BuyProductsCondition(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.BuyProductsCondition()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.minLevel ~= nil and decodedData.minLevelSpecified ~= false then
        data.minLevel = decodedData.minLevel
    end
    if decodedData.maxLevel ~= nil and decodedData.maxLevelSpecified ~= false then
        data.maxLevel = decodedData.maxLevel
    end
    if decodedData.currency ~= nil and decodedData.currencySpecified ~= false then
        data.currency = decodedData.currency
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.screenCondition ~= nil and decodedData.screenConditionSpecified ~= false then
        for i = 1, #decodedData.screenCondition do
            data.screenCondition:Add(decodedData.screenCondition[i])
        end
    end
    if decodedData.propertyTendency ~= nil and decodedData.propertyTendencySpecified ~= false then
        data.propertyTendency = decodedData.propertyTendency
    end
    return data
end

---@param decodedData auctionV2.BuyProductsMarketPriceSectionRequest lua中的数据结构
---@return auctionV2.BuyProductsMarketPriceSectionRequest C#中的数据结构
function auctionV2.BuyProductsMarketPriceSectionRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.BuyProductsMarketPriceSectionRequest()
    if decodedData.condition ~= nil and decodedData.conditionSpecified ~= false then
        data.condition = auctionV2.BuyProductsCondition(decodedData.condition)
    end
    if decodedData.MarketPriceSectionType ~= nil and decodedData.MarketPriceSectionTypeSpecified ~= false then
        data.MarketPriceSectionType = decodedData.MarketPriceSectionType
    end
    if decodedData.itemType ~= nil and decodedData.itemTypeSpecified ~= false then
        data.itemType = decodedData.itemType
    end
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    return data
end

---@param decodedData auctionV2.ReleaseBuyProductsRequest lua中的数据结构
---@return auctionV2.ReleaseBuyProductsRequest C#中的数据结构
function auctionV2.ReleaseBuyProductsRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.ReleaseBuyProductsRequest()
    if decodedData.price ~= nil and decodedData.priceSpecified ~= false then
        data.price = decodeTable.bag.CoinInfo(decodedData.price)
    end
    if decodedData.condition ~= nil and decodedData.conditionSpecified ~= false then
        data.condition = auctionV2.BuyProductsCondition(decodedData.condition)
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    return data
end

---@param decodedData auctionV2.SubmitBuyProductsItemRequest lua中的数据结构
---@return auctionV2.SubmitBuyProductsItemRequest C#中的数据结构
function auctionV2.SubmitBuyProductsItemRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.SubmitBuyProductsItemRequest()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.priceId ~= nil and decodedData.priceIdSpecified ~= false then
        data.priceId = decodedData.priceId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData auctionV2.SubmitBuyProductsItemResponse lua中的数据结构
---@return auctionV2.SubmitBuyProductsItemResponse C#中的数据结构
function auctionV2.SubmitBuyProductsItemResponse(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.SubmitBuyProductsItemResponse()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.item ~= nil and decodedData.itemSpecified ~= false then
        data.item = auctionV2.AuctionItemInfo(decodedData.item)
    end
    if decodedData.leftCount ~= nil and decodedData.leftCountSpecified ~= false then
        data.leftCount = decodedData.leftCount
    end
    return data
end

---@param decodedData auctionV2.auctionRequest lua中的数据结构
---@return auctionV2.auctionRequest C#中的数据结构
function auctionV2.auctionRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.auctionRequest()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.AuctionType ~= nil and decodedData.AuctionTypeSpecified ~= false then
        data.AuctionType = decodedData.AuctionType
    end
    return data
end

---@param decodedData auctionV2.pushResponse lua中的数据结构
---@return auctionV2.pushResponse C#中的数据结构
function auctionV2.pushResponse(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.pushResponse()
    if decodedData.PushType ~= nil and decodedData.PushTypeSpecified ~= false then
        data.PushType = decodedData.PushType
    end
    if decodedData.item ~= nil and decodedData.itemSpecified ~= false then
        data.item = decodeTable.bag.BagItemInfo(decodedData.item)
    end
    if decodedData.priceItemId ~= nil and decodedData.priceItemIdSpecified ~= false then
        data.priceItemId = decodedData.priceItemId
    end
    if decodedData.price ~= nil and decodedData.priceSpecified ~= false then
        data.price = decodedData.price
    end
    return data
end

---@param decodedData auctionV2.GuessYouLikeRequest lua中的数据结构
---@return auctionV2.GuessYouLikeRequest C#中的数据结构
function auctionV2.GuessYouLikeRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.GuessYouLikeRequest()
    if decodedData.itemType ~= nil and decodedData.itemTypeSpecified ~= false then
        data.itemType = decodedData.itemType
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
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData auctionV2.GuessYouLikeResponse lua中的数据结构
---@return auctionV2.GuessYouLikeResponse C#中的数据结构
function auctionV2.GuessYouLikeResponse(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.GuessYouLikeResponse()
    if decodedData.itemType ~= nil and decodedData.itemTypeSpecified ~= false then
        data.itemType = decodedData.itemType
    end
    if decodedData.items ~= nil and decodedData.itemsSpecified ~= false then
        for i = 1, #decodedData.items do
            data.items:Add(auctionV2.AuctionItemInfo(decodedData.items[i]))
        end
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
    return data
end

---@param decodedData auctionV2.OpenTradeBeforeResponse lua中的数据结构
---@return auctionV2.OpenTradeBeforeResponse C#中的数据结构
function auctionV2.OpenTradeBeforeResponse(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.OpenTradeBeforeResponse()
    if decodedData.bagItemState ~= nil and decodedData.bagItemStateSpecified ~= false then
        for i = 1, #decodedData.bagItemState do
            data.bagItemState:Add(auctionV2.BagItemState(decodedData.bagItemState[i]))
        end
    end
    return data
end

---@param decodedData auctionV2.BagItemState lua中的数据结构
---@return auctionV2.BagItemState C#中的数据结构
function auctionV2.BagItemState(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.BagItemState()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.saleMoney ~= nil and decodedData.saleMoneySpecified ~= false then
        data.saleMoney = decodedData.saleMoney
    end
    if decodedData.saleDiamond ~= nil and decodedData.saleDiamondSpecified ~= false then
        data.saleDiamond = decodedData.saleDiamond
    end
    if decodedData.auctionDiamond ~= nil and decodedData.auctionDiamondSpecified ~= false then
        data.auctionDiamond = decodedData.auctionDiamond
    end
    return data
end

---@param decodedData auctionV2.TransactionRecord lua中的数据结构
---@return auctionV2.TransactionRecord C#中的数据结构
function auctionV2.TransactionRecord(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.TransactionRecord()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.goods ~= nil and decodedData.goodsSpecified ~= false then
        data.goods = decodeTable.bag.BagItemInfo(decodedData.goods)
    end
    if decodedData.tradeType ~= nil and decodedData.tradeTypeSpecified ~= false then
        data.tradeType = decodedData.tradeType
    end
    if decodedData.tradeTime ~= nil and decodedData.tradeTimeSpecified ~= false then
        data.tradeTime = decodedData.tradeTime
    end
    if decodedData.moneyId ~= nil and decodedData.moneyIdSpecified ~= false then
        data.moneyId = decodedData.moneyId
    end
    if decodedData.moneyCount ~= nil and decodedData.moneyCountSpecified ~= false then
        data.moneyCount = decodedData.moneyCount
    end
    if decodedData.substractMoney ~= nil and decodedData.substractMoneySpecified ~= false then
        data.substractMoney = decodedData.substractMoney
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData auctionV2.TeadeRecordReq lua中的数据结构
---@return auctionV2.TeadeRecordReq C#中的数据结构
function auctionV2.TeadeRecordReq(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.TeadeRecordReq()
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

---@param decodedData auctionV2.TeadeRecordRes lua中的数据结构
---@return auctionV2.TeadeRecordRes C#中的数据结构
function auctionV2.TeadeRecordRes(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.TeadeRecordRes()
    if decodedData.records ~= nil and decodedData.recordsSpecified ~= false then
        data.records = auctionV2.tradeRecordList(decodedData.records)
    end
    if decodedData.toatlPageCount ~= nil and decodedData.toatlPageCountSpecified ~= false then
        data.toatlPageCount = decodedData.toatlPageCount
    end
    if decodedData.page ~= nil and decodedData.pageSpecified ~= false then
        data.page = decodedData.page
    end
    if decodedData.firstCanReceive ~= nil and decodedData.firstCanReceiveSpecified ~= false then
        data.firstCanReceive = decodedData.firstCanReceive
    end
    if decodedData.totalCount ~= nil and decodedData.totalCountSpecified ~= false then
        data.totalCount = decodedData.totalCount
    end
    return data
end

---@param decodedData auctionV2.tradeRecordList lua中的数据结构
---@return auctionV2.tradeRecordList C#中的数据结构
function auctionV2.tradeRecordList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.tradeRecordList()
    if decodedData.record ~= nil and decodedData.recordSpecified ~= false then
        for i = 1, #decodedData.record do
            data.record:Add(auctionV2.TransactionRecord(decodedData.record[i]))
        end
    end
    return data
end

---@param decodedData auctionV2.TradeRecordId lua中的数据结构
---@return auctionV2.TradeRecordId C#中的数据结构
function auctionV2.TradeRecordId(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.TradeRecordId()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData auctionV2.TradeRecordRedPoint lua中的数据结构
---@return auctionV2.TradeRecordRedPoint C#中的数据结构
function auctionV2.TradeRecordRedPoint(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.TradeRecordRedPoint()
    if decodedData.redPoint ~= nil and decodedData.redPointSpecified ~= false then
        data.redPoint = decodedData.redPoint
    end
    return data
end

---@param decodedData auctionV2.UnionSmeltGoodsChange lua中的数据结构
---@return auctionV2.UnionSmeltGoodsChange C#中的数据结构
function auctionV2.UnionSmeltGoodsChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.UnionSmeltGoodsChange()
    if decodedData.items ~= nil and decodedData.itemsSpecified ~= false then
        for i = 1, #decodedData.items do
            data.items:Add(auctionV2.AuctionItemInfo(decodedData.items[i]))
        end
    end
    if decodedData.changeType ~= nil and decodedData.changeTypeSpecified ~= false then
        data.changeType = decodedData.changeType
    end
    return data
end

---@param decodedData auctionV2.BuyUnionSmeltItem lua中的数据结构
---@return auctionV2.BuyUnionSmeltItem C#中的数据结构
function auctionV2.BuyUnionSmeltItem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.BuyUnionSmeltItem()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData auctionV2.AuctionPush lua中的数据结构
---@return auctionV2.AuctionPush C#中的数据结构
function auctionV2.AuctionPush(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.AuctionPush()
    if decodedData.item ~= nil and decodedData.itemSpecified ~= false then
        data.item = decodeTable.bag.BagItemInfo(decodedData.item)
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.pushType ~= nil and decodedData.pushTypeSpecified ~= false then
        data.pushType = decodedData.pushType
    end
    if decodedData.sign ~= nil and decodedData.signSpecified ~= false then
        data.sign = decodedData.sign
    end
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    return data
end

---@param decodedData auctionV2.CurLoginNoPush lua中的数据结构
---@return auctionV2.CurLoginNoPush C#中的数据结构
function auctionV2.CurLoginNoPush(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.CurLoginNoPush()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData auctionV2.ReqQuickAuctionItem lua中的数据结构
---@return auctionV2.ReqQuickAuctionItem C#中的数据结构
function auctionV2.ReqQuickAuctionItem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.ReqQuickAuctionItem()
    if decodedData.itemIds ~= nil and decodedData.itemIdsSpecified ~= false then
        for i = 1, #decodedData.itemIds do
            data.itemIds:Add(decodedData.itemIds[i])
        end
    end
    return data
end

---@param decodedData auctionV2.ResQuickAuctionItem lua中的数据结构
---@return auctionV2.ResQuickAuctionItem C#中的数据结构
function auctionV2.ResQuickAuctionItem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.auctionV2.ResQuickAuctionItem()
    if decodedData.items ~= nil and decodedData.itemsSpecified ~= false then
        for i = 1, #decodedData.items do
            data.items:Add(auctionV2.AuctionItemInfo(decodedData.items[i]))
        end
    end
    return data
end

return auctionV2