--[[本文件为工具自动生成,禁止手动修改]]
--auction.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---商品列表响应
---msgID: 111002
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.AuctionItemList C#数据结构
function networkRespond.OnResGetAuctionItemsMessageReceived(msgID)
    ---@type auctionV2.AuctionItemList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111002 auctionV2.AuctionItemList 商品列表响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.auction ~= nil and  protobufMgr.DecodeTable.auction.AuctionItemList ~= nil then
        csData = protobufMgr.DecodeTable.auction.AuctionItemList(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---自己已上架商品列表响应
---msgID: 111004
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.AuctionItemShelfList C#数据结构
function networkRespond.OnResGetAuctionShelfMessageReceived(msgID)
    ---@type auctionV2.AuctionItemShelfList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111004 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111004 auctionV2.AuctionItemShelfList 自己已上架商品列表响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.auction ~= nil and  protobufMgr.DecodeTable.auction.AuctionItemShelfList ~= nil then
        csData = protobufMgr.DecodeTable.auction.AuctionItemShelfList(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---上架响应
---msgID: 111006
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.AddToShelfResponse C#数据结构
function networkRespond.OnResAddToShelfMessageReceived(msgID)
    ---@type auctionV2.AddToShelfResponse
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111006 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111006 auctionV2.AddToShelfResponse 上架响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.auction ~= nil and  protobufMgr.DecodeTable.auction.AddToShelfResponse ~= nil then
        csData = protobufMgr.DecodeTable.auction.AddToShelfResponse(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---重新上架响应
---msgID: 111008
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.AuctionItemInfo C#数据结构
function networkRespond.OnResReAddToShelfMessageReceived(msgID)
    ---@type auctionV2.AuctionItemInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111008 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111008 auctionV2.AuctionItemInfo 重新上架响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.auction ~= nil and  protobufMgr.DecodeTable.auction.AuctionItemInfo ~= nil then
        csData = protobufMgr.DecodeTable.auction.AuctionItemInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---下架响应
---msgID: 111010
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.ItemMsg C#数据结构
function networkRespond.OnResRemoveFromShelfMessageReceived(msgID)
    ---@type auctionV2.ItemMsg
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111010 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111010 auctionV2.ItemMsg 下架响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.auction ~= nil and  protobufMgr.DecodeTable.auction.ItemMsg ~= nil then
        csData = protobufMgr.DecodeTable.auction.ItemMsg(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---购买响应
---msgID: 111012
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.ItemMsg C#数据结构
function networkRespond.OnResBuyAuctionItemMessageReceived(msgID)
    ---@type auctionV2.ItemMsg
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111012 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111012 auctionV2.ItemMsg 购买响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.auction ~= nil and  protobufMgr.DecodeTable.auction.ItemMsg ~= nil then
        csData = protobufMgr.DecodeTable.auction.ItemMsg(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---搜索响应
---msgID: 111015
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.SearchAuctionItemResponse C#数据结构
function networkRespond.OnResAuctionSearchMessageReceived(msgID)
    ---@type auctionV2.SearchAuctionItemResponse
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111015 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111015 auctionV2.SearchAuctionItemResponse 搜索响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.auction ~= nil and  protobufMgr.DecodeTable.auction.SearchAuctionItemResponse ~= nil then
        csData = protobufMgr.DecodeTable.auction.SearchAuctionItemResponse(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---购买失败响应
---msgID: 111016
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.lose C#数据结构
function networkRespond.OnResBuyLoseMessageReceived(msgID)
    ---@type auctionV2.lose
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111016 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111016 auctionV2.lose 购买失败响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResBuyLoseMessage", 111016, "lose", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---上架失败响应
---msgID: 111017
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.lose C#数据结构
function networkRespond.OnResAddToShelfLoseMessageReceived(msgID)
    ---@type auctionV2.lose
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111017 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111017 auctionV2.lose 上架失败响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResAddToShelfLoseMessage", 111017, "lose", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---拍卖品的价格区间响应
---msgID: 111019
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.MarketPriceSection C#数据结构
function networkRespond.OnResMarketPriceSectionMessageReceived(msgID)
    ---@type auctionV2.MarketPriceSection
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111019 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111019 auctionV2.MarketPriceSection 拍卖品的价格区间响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.auction ~= nil and  protobufMgr.DecodeTable.auction.MarketPriceSection ~= nil then
        csData = protobufMgr.DecodeTable.auction.MarketPriceSection(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---拍卖响应
---msgID: 111021
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.AuctionItemInfo C#数据结构
function networkRespond.OnResAuctionLotMessageReceived(msgID)
    ---@type auctionV2.AuctionItemInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111021 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111021 auctionV2.AuctionItemInfo 拍卖响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResAuctionLotMessage", 111021, "AuctionItemInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---发布求购响应
---msgID: 111024
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.AuctionItemInfo C#数据结构
function networkRespond.OnResReleaseBuyProductsMessageReceived(msgID)
    ---@type auctionV2.AuctionItemInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111024 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111024 auctionV2.AuctionItemInfo 发布求购响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResReleaseBuyProductsMessage", 111024, "AuctionItemInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---提交求购的物品响应
---msgID: 111026
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.SubmitBuyProductsItemResponse C#数据结构
function networkRespond.OnResSubmitBuyProductsItemMessageReceived(msgID)
    ---@type auctionV2.SubmitBuyProductsItemResponse
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111026 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111026 auctionV2.SubmitBuyProductsItemResponse 提交求购的物品响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSubmitBuyProductsItemMessage", 111026, "SubmitBuyProductsItemResponse", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---推送响应
---msgID: 111027
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.pushResponse C#数据结构
function networkRespond.OnResPushMessageReceived(msgID)
    ---@type auctionV2.pushResponse
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111027 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111027 auctionV2.pushResponse 推送响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.auction ~= nil and  protobufMgr.DecodeTable.auction.pushResponse ~= nil then
        csData = protobufMgr.DecodeTable.auction.pushResponse(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---猜你喜欢响应
---msgID: 111030
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.GuessYouLikeResponse C#数据结构
function networkRespond.OnResGuessYouLikeMessageReceived(msgID)
    ---@type auctionV2.GuessYouLikeResponse
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111030 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111030 auctionV2.GuessYouLikeResponse 猜你喜欢响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.auction ~= nil and  protobufMgr.DecodeTable.auction.GuessYouLikeResponse ~= nil then
        csData = protobufMgr.DecodeTable.auction.GuessYouLikeResponse(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---交易记录响应
---msgID: 111034
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.TeadeRecordRes C#数据结构
function networkRespond.OnResTradeRecordInfoMessageReceived(msgID)
    ---@type auctionV2.TeadeRecordRes
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111034 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111034 auctionV2.TeadeRecordRes 交易记录响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.auction ~= nil and  protobufMgr.DecodeTable.auction.TeadeRecordRes ~= nil then
        csData = protobufMgr.DecodeTable.auction.TeadeRecordRes(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---领取交易记录响应
---msgID: 111036
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.TradeRecordId C#数据结构
function networkRespond.OnResReceiveTradeRecordMessageReceived(msgID)
    ---@type auctionV2.TradeRecordId
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111036 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111036 auctionV2.TradeRecordId 领取交易记录响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.auction ~= nil and  protobufMgr.DecodeTable.auction.TradeRecordId ~= nil then
        csData = protobufMgr.DecodeTable.auction.TradeRecordId(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---交易记录红点提示
---msgID: 111037
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.TradeRecordRedPoint C#数据结构
function networkRespond.OnResTradeRecordRedPointMessageReceived(msgID)
    ---@type auctionV2.TradeRecordRedPoint
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111037 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111037 auctionV2.TradeRecordRedPoint 交易记录红点提示")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.auction ~= nil and  protobufMgr.DecodeTable.auction.TradeRecordRedPoint ~= nil then
        csData = protobufMgr.DecodeTable.auction.TradeRecordRedPoint(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---行会熔炼物品变动
---msgID: 111038
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.UnionSmeltGoodsChange C#数据结构
function networkRespond.OnResUnionSmeltGoodsChangeMessageReceived(msgID)
    ---@type auctionV2.UnionSmeltGoodsChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111038 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111038 auctionV2.UnionSmeltGoodsChange 行会熔炼物品变动")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResUnionSmeltGoodsChangeMessage", 111038, "UnionSmeltGoodsChange", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---新增购买推送
---msgID: 111041
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.AuctionPush C#数据结构
function networkRespond.OnResAuctionPushMessageReceived(msgID)
    ---@type auctionV2.AuctionPush
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111041 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111041 auctionV2.AuctionPush 新增购买推送")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.auction ~= nil and  protobufMgr.DecodeTable.auction.AuctionPush ~= nil then
        csData = protobufMgr.DecodeTable.auction.AuctionPush(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回快捷购买道具
---msgID: 111044
---@param msgID LuaEnumNetDef 消息ID
---@return auctionV2.ResQuickAuctionItem C#数据结构
function networkRespond.OnResQuickAuctionItemMessageReceived(msgID)
    ---@type auctionV2.ResQuickAuctionItem
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111044 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111044 auctionV2.ResQuickAuctionItem 返回快捷购买道具")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResQuickAuctionItemMessage", 111044, "ResQuickAuctionItem", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

