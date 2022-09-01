--[[本文件为工具自动生成,禁止手动修改]]
--auction.xml

--region ID:111001 获取商品列表请求
---获取商品列表请求
---msgID: 111001
---@param page number 选填参数
---@param minLevel number 选填参数 最低转生*1000 + 等级
---@param maxLevel number 选填参数 最高转生*1000 + 等级
---@param currency number 选填参数 筛选货币 货币itemId
---@param sex number 选填参数 性别 （不选填-1）
---@param career number 选填参数 职业 （不选填-1）
---@param toatlPageCount number 选填参数 总页数
---@param screenCondition System.Collections.Generic.List1T<number> 列表参数 筛选条件
---@param itemType number 选填参数 物品类型（当前搜索的物品的类型，比如说拍卖品，具体上面有枚举）
---@param sortBy number 选填参数 根据什么排序 具体上面有枚举
---@param sort boolean 选填参数 排序 true 升序 false 降序
---@param propertyTendency number 选填参数 职业偏向（不选填-1）
---@param selectType number 选填参数 搜索类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetAuctionItems(page, minLevel, maxLevel, currency, sex, career, toatlPageCount, screenCondition, itemType, sortBy, sort, propertyTendency, selectType)
    local reqData = CS.auctionV2.GetAuctionItemsRequest()
    if page ~= nil then
        reqData.page = page
    end
    if minLevel ~= nil then
        reqData.minLevel = minLevel
    end
    if maxLevel ~= nil then
        reqData.maxLevel = maxLevel
    end
    if currency ~= nil then
        reqData.currency = currency
    end
    if sex ~= nil then
        reqData.sex = sex
    end
    if career ~= nil then
        reqData.career = career
    end
    if toatlPageCount ~= nil then
        reqData.toatlPageCount = toatlPageCount
    end
    if screenCondition ~= nil then
        reqData.screenCondition:AddRange(screenCondition)
    end
    if itemType ~= nil then
        reqData.itemType = itemType
    end
    if sortBy ~= nil then
        reqData.sortBy = sortBy
    end
    if sort ~= nil then
        reqData.sort = sort
    end
    if propertyTendency ~= nil then
        reqData.propertyTendency = propertyTendency
    end
    if selectType ~= nil then
        reqData.selectType = selectType
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetAuctionItemsMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetAuctionItemsMessage](LuaEnumNetDef.ReqGetAuctionItemsMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetAuctionItemsMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:111003 获取自己的上架商品列表请求
---获取自己的上架商品列表请求
---msgID: 111003
---@param itemType number 选填参数 物品类型（当前搜索的物品的类型，比如说拍卖品，具体上面有枚举）
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetAuctionShelf(itemType)
    local reqTable = {}
    if itemType ~= nil then
        reqTable.itemType = itemType
    end
    local reqMsgData = protobufMgr.Serialize("auctionV2.GetOneSelfItemList" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetAuctionShelfMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetAuctionShelfMessage](LuaEnumNetDef.ReqGetAuctionShelfMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetAuctionShelfMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetAuctionShelfMessage", 111003, "GetOneSelfItemList", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:111005 上架请求
---上架请求
---msgID: 111005
---@param lid number 选填参数 物品id（唯一id）
---@param count number 选填参数 物品数量
---@param price auctionV2.bagV2.CoinInfo 选填参数 价格 包括货币的itemid和数量
---@param itemType number 选填参数 物品类型（当前搜索的物品的类型，比如说拍卖品，具体上面有枚举）
---@param isPublicity boolean 选填参数 是否公示(true 公示 false 不公示,目前只有拍卖品有)
---@param fixedPrice number 选填参数 拍卖商品的一口价
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAddToShelf(lid, count, price, itemType, isPublicity, fixedPrice)
    local reqTable = {}
    if lid ~= nil then
        reqTable.lid = lid
    end
    if count ~= nil then
        reqTable.count = count
    end
    if price ~= nil then
        reqTable.price = price
    end
    if itemType ~= nil then
        reqTable.itemType = itemType
    end
    if isPublicity ~= nil then
        reqTable.isPublicity = isPublicity
    end
    if fixedPrice ~= nil then
        reqTable.fixedPrice = fixedPrice
    end
    local reqMsgData = protobufMgr.Serialize("auctionV2.AddToShelfRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAddToShelfMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAddToShelfMessage](LuaEnumNetDef.ReqAddToShelfMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAddToShelfMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAddToShelfMessage", 111005, "AddToShelfRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:111007 重新上架请求
---重新上架请求
---msgID: 111007
---@param id number 选填参数 物品id（唯一id）
---@param price auctionV2.bagV2.CoinInfo 选填参数 价格 包括货币的itemid和数量
---@param isPublicity boolean 选填参数 是否公示(true 公示 false 不公示,目前只有拍卖品有)
---@param itemType number 选填参数 物品类型（当前搜索的物品的类型，比如说拍卖品，具体上面有枚举）
---@param fixedPrice number 选填参数 拍卖商品的一口价
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReAddToShelf(id, price, isPublicity, itemType, fixedPrice)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    if price ~= nil then
        reqTable.price = price
    end
    if isPublicity ~= nil then
        reqTable.isPublicity = isPublicity
    end
    if itemType ~= nil then
        reqTable.itemType = itemType
    end
    if fixedPrice ~= nil then
        reqTable.fixedPrice = fixedPrice
    end
    local reqMsgData = protobufMgr.Serialize("auctionV2.ReAddToShelfRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReAddToShelfMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReAddToShelfMessage](LuaEnumNetDef.ReqReAddToShelfMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqReAddToShelfMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqReAddToShelfMessage", 111007, "ReAddToShelfRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:111009 下架请求
---下架请求
---msgID: 111009
---@param lid number 选填参数 物品id（唯一id）
---@param itemType number 选填参数 物品类型（当前搜索的物品的类型，比如说拍卖品，具体上面有枚举）
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRemoveFromShelf(lid, itemType)
    local reqTable = {}
    if lid ~= nil then
        reqTable.lid = lid
    end
    if itemType ~= nil then
        reqTable.itemType = itemType
    end
    local reqMsgData = protobufMgr.Serialize("auctionV2.PutOffRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRemoveFromShelfMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRemoveFromShelfMessage](LuaEnumNetDef.ReqRemoveFromShelfMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRemoveFromShelfMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRemoveFromShelfMessage", 111009, "PutOffRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:111011 购买请求
---购买请求
---msgID: 111011
---@param lid number 选填参数 物品id（唯一id）
---@param count number 选填参数 物品数量
---@param buyType number 选填参数 BuyType
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBuyAuctionAuction(lid, count, buyType)
    local reqTable = {}
    if lid ~= nil then
        reqTable.lid = lid
    end
    if count ~= nil then
        reqTable.count = count
    end
    if buyType ~= nil then
        reqTable.buyType = buyType
    end
    local reqMsgData = protobufMgr.Serialize("auctionV2.BuyAuction" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBuyAuctionAuctionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBuyAuctionAuctionMessage](LuaEnumNetDef.ReqBuyAuctionAuctionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqBuyAuctionAuctionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqBuyAuctionAuctionMessage", 111011, "BuyAuction", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:111013 吆喝请求
---吆喝请求
---msgID: 111013
---@param lid number 选填参数 物品id（唯一id）
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAuctionChat(lid)
    local reqTable = {}
    if lid ~= nil then
        reqTable.lid = lid
    end
    local reqMsgData = protobufMgr.Serialize("auctionV2.ItemIdMsg" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAuctionChatMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAuctionChatMessage](LuaEnumNetDef.ReqAuctionChatMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAuctionChatMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAuctionChatMessage", 111013, "ItemIdMsg", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:111014 搜索请求
---搜索请求
---msgID: 111014
---@param matchesString string 选填参数 匹配字符串
---@param condition auctionV2.auctionV2.GetAuctionItemsRequest 选填参数 搜索条件
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAuctionSearch(matchesString, condition)
    local reqData = CS.auctionV2.SearchAuctionItem()
    if matchesString ~= nil then
        reqData.matchesString = matchesString
    end
    if condition ~= nil then
        reqData.condition = condition
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAuctionSearchMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAuctionSearchMessage](LuaEnumNetDef.ReqAuctionSearchMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqAuctionSearchMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:111018 请求拍卖品的价格区间
---请求拍卖品的价格区间
---msgID: 111018
---@param lid number 选填参数 物品id（唯一id）
---@param MarketPriceSectionType number 选填参数 请求价格区间类型（具体上面有枚举）
---@param itemType number 选填参数 物品类型（当前搜索的物品的类型，比如说拍卖品，具体上面有枚举）
---@param priceItemId number 选填参数 价格ItemID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqMarketPriceSection(lid, MarketPriceSectionType, itemType, priceItemId)
    local reqTable = {}
    if lid ~= nil then
        reqTable.lid = lid
    end
    if MarketPriceSectionType ~= nil then
        reqTable.MarketPriceSectionType = MarketPriceSectionType
    end
    if itemType ~= nil then
        reqTable.itemType = itemType
    end
    if priceItemId ~= nil then
        reqTable.priceItemId = priceItemId
    end
    local reqMsgData = protobufMgr.Serialize("auctionV2.MarketPriceSectionRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqMarketPriceSectionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqMarketPriceSectionMessage](LuaEnumNetDef.ReqMarketPriceSectionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqMarketPriceSectionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqMarketPriceSectionMessage", 111018, "MarketPriceSectionRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:111020 拍卖请求
---拍卖请求
---msgID: 111020
---@param lid number 选填参数 物品id（唯一id）
---@param AuctionType number 选填参数 拍卖类型(具体上面有枚举)
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAuctionLot(lid, AuctionType)
    local reqTable = {}
    if lid ~= nil then
        reqTable.lid = lid
    end
    if AuctionType ~= nil then
        reqTable.AuctionType = AuctionType
    end
    local reqMsgData = protobufMgr.Serialize("auctionV2.auctionRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAuctionLotMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAuctionLotMessage](LuaEnumNetDef.ReqAuctionLotMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAuctionLotMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAuctionLotMessage", 111020, "auctionRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:111022 请求求购的价格区间
---请求求购的价格区间
---msgID: 111022
---@param condition auctionV2.auctionV2.BuyProductsCondition 选填参数 求购的条件
---@param MarketPriceSectionType number 选填参数 请求价格区间类型（具体上面有枚举）
---@param itemType number 选填参数 物品类型（当前搜索的物品的类型，比如说拍卖品，具体上面有枚举）
---@param lid number 选填参数 唯一id
---@param name string 选填参数 求购的名字
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBuyProductsMarketPriceSection(condition, MarketPriceSectionType, itemType, lid, name)
    local reqData = CS.auctionV2.BuyProductsMarketPriceSectionRequest()
    if condition ~= nil then
        reqData.condition = condition
    end
    if MarketPriceSectionType ~= nil then
        reqData.MarketPriceSectionType = MarketPriceSectionType
    end
    if itemType ~= nil then
        reqData.itemType = itemType
    end
    if lid ~= nil then
        reqData.lid = lid
    end
    if name ~= nil then
        reqData.name = name
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBuyProductsMarketPriceSectionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBuyProductsMarketPriceSectionMessage](LuaEnumNetDef.ReqBuyProductsMarketPriceSectionMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqBuyProductsMarketPriceSectionMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:111023 发布求购请求
---发布求购请求
---msgID: 111023
---@param price auctionV2.bagV2.CoinInfo 选填参数 求购价格
---@param condition auctionV2.auctionV2.BuyProductsCondition 选填参数 求购的条件
---@param name string 选填参数 求购的名字
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReleaseBuyProducts(price, condition, name)
    local reqData = CS.auctionV2.ReleaseBuyProductsRequest()
    if price ~= nil then
        reqData.price = price
    end
    if condition ~= nil then
        reqData.condition = condition
    end
    if name ~= nil then
        reqData.name = name
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReleaseBuyProductsMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReleaseBuyProductsMessage](LuaEnumNetDef.ReqReleaseBuyProductsMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqReleaseBuyProductsMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:111025 提交求购的物品
---提交求购的物品
---msgID: 111025
---@param lid number 选填参数 求购品在拍卖行中的id
---@param priceId number 选填参数 提交的物品id
---@param count number 选填参数 提交的数量
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSubmitBuyProductsItem(lid, priceId, count)
    local reqTable = {}
    if lid ~= nil then
        reqTable.lid = lid
    end
    if priceId ~= nil then
        reqTable.priceId = priceId
    end
    if count ~= nil then
        reqTable.count = count
    end
    local reqMsgData = protobufMgr.Serialize("auctionV2.SubmitBuyProductsItemRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSubmitBuyProductsItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSubmitBuyProductsItemMessage](LuaEnumNetDef.ReqSubmitBuyProductsItemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSubmitBuyProductsItemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSubmitBuyProductsItemMessage", 111025, "SubmitBuyProductsItemRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:111029 猜你喜欢请求
---猜你喜欢请求
---msgID: 111029
---@param itemType number 选填参数 物品类型（当前搜索的物品的类型，比如说拍卖品，具体上面有枚举）
---@param page number 选填参数 页码（从多少页，就是玩家现在在哪一页）
---@param countPerPage number 选填参数 每页条数
---@param pageNumber number 选填参数 页数（总共要多少页）
---@param type number 选填参数 猜你喜欢类型 1随机 2旧的
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGuessYouLike(itemType, page, countPerPage, pageNumber, type)
    local reqTable = {}
    if itemType ~= nil then
        reqTable.itemType = itemType
    end
    if page ~= nil then
        reqTable.page = page
    end
    if countPerPage ~= nil then
        reqTable.countPerPage = countPerPage
    end
    if pageNumber ~= nil then
        reqTable.pageNumber = pageNumber
    end
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("auctionV2.GuessYouLikeRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGuessYouLikeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGuessYouLikeMessage](LuaEnumNetDef.ReqGuessYouLikeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGuessYouLikeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGuessYouLikeMessage", 111029, "GuessYouLikeRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:111031 打开交易行之前的请求
---打开交易行之前的请求
---msgID: 111031
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOpenTradeBefore()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOpenTradeBeforeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOpenTradeBeforeMessage](LuaEnumNetDef.ReqOpenTradeBeforeMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqOpenTradeBeforeMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:111033 请求交易记录
---请求交易记录
---msgID: 111033
---@param type number 选填参数 类型
---@param page number 选填参数 页码（从多少页）
---@param countPerPage number 选填参数 每页条数
---@param pageNumber number 选填参数 页数（总共要多少页）
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTradeRecordInfo(type, page, countPerPage, pageNumber)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if page ~= nil then
        reqTable.page = page
    end
    if countPerPage ~= nil then
        reqTable.countPerPage = countPerPage
    end
    if pageNumber ~= nil then
        reqTable.pageNumber = pageNumber
    end
    local reqMsgData = protobufMgr.Serialize("auctionV2.TeadeRecordReq" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTradeRecordInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTradeRecordInfoMessage](LuaEnumNetDef.ReqTradeRecordInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqTradeRecordInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqTradeRecordInfoMessage", 111033, "TeadeRecordReq", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:111035 领取交易记录请求
---领取交易记录请求
---msgID: 111035
---@param id number 选填参数 记录的唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReceiveTradeRecord(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("auctionV2.TradeRecordId" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReceiveTradeRecordMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReceiveTradeRecordMessage](LuaEnumNetDef.ReqReceiveTradeRecordMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqReceiveTradeRecordMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqReceiveTradeRecordMessage", 111035, "TradeRecordId", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:111039 请求行会熔炼商品
---请求行会熔炼商品
---msgID: 111039
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetUnionSmeltItem()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetUnionSmeltItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetUnionSmeltItemMessage](LuaEnumNetDef.ReqGetUnionSmeltItemMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetUnionSmeltItemMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:111040 兑换行会熔炼商品
---兑换行会熔炼商品
---msgID: 111040
---@param lid number 选填参数 物品id（唯一id）
---@param count number 选填参数 物品数量
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBuyUnionSmeltItem(lid, count)
    local reqTable = {}
    if lid ~= nil then
        reqTable.lid = lid
    end
    if count ~= nil then
        reqTable.count = count
    end
    local reqMsgData = protobufMgr.Serialize("auctionV2.BuyUnionSmeltItem" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBuyUnionSmeltItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBuyUnionSmeltItemMessage](LuaEnumNetDef.ReqBuyUnionSmeltItemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqBuyUnionSmeltItemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqBuyUnionSmeltItemMessage", 111040, "BuyUnionSmeltItem", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:111042 请求本次登录不再推送
---请求本次登录不再推送
---msgID: 111042
---@param type number 选填参数 关闭的推送类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCurLoginNoPush(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("auctionV2.CurLoginNoPush" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCurLoginNoPushMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCurLoginNoPushMessage](LuaEnumNetDef.ReqCurLoginNoPushMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqCurLoginNoPushMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqCurLoginNoPushMessage", 111042, "CurLoginNoPush", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:111043 请求快捷购买道具
---请求快捷购买道具
---msgID: 111043
---@param itemIds table<number> 列表参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqQuickAuctionItem(itemIds)
    local reqTable = {}
    if itemIds ~= nil then
        reqTable.itemIds = itemIds
    else
        reqTable.itemIds = {}
    end
    local reqMsgData = protobufMgr.Serialize("auctionV2.ReqQuickAuctionItem" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqQuickAuctionItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqQuickAuctionItemMessage](LuaEnumNetDef.ReqQuickAuctionItemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqQuickAuctionItemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqQuickAuctionItemMessage", 111043, "ReqQuickAuctionItem", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

