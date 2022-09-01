--[[本文件为工具自动生成,禁止手动修改]]
--auction.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---商品列表响应
---msgID: 111002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetAuctionItemsMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111002 auctionV2.AuctionItemList 商品列表响应")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.AuctionItemList", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.AdjustAuctionItemList ~= nil then
        protoAdjust.auction_adj.AdjustAuctionItemList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111002
    protobufMgr.mMsgDeserializedTblCache = res
end

---自己已上架商品列表响应
---msgID: 111004
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetAuctionShelfMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111004 auctionV2.AuctionItemShelfList 自己已上架商品列表响应")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.AuctionItemShelfList", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.AdjustAuctionItemShelfList ~= nil then
        protoAdjust.auction_adj.AdjustAuctionItemShelfList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111004
    protobufMgr.mMsgDeserializedTblCache = res
end

---上架响应
---msgID: 111006
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAddToShelfMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111006 auctionV2.AddToShelfResponse 上架响应")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.AddToShelfResponse", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.AdjustAddToShelfResponse ~= nil then
        protoAdjust.auction_adj.AdjustAddToShelfResponse(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111006
    protobufMgr.mMsgDeserializedTblCache = res
end

---重新上架响应
---msgID: 111008
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResReAddToShelfMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111008 auctionV2.AuctionItemInfo 重新上架响应")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.AuctionItemInfo", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.AdjustAuctionItemInfo ~= nil then
        protoAdjust.auction_adj.AdjustAuctionItemInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111008
    protobufMgr.mMsgDeserializedTblCache = res
end

---下架响应
---msgID: 111010
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRemoveFromShelfMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111010 auctionV2.ItemMsg 下架响应")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.ItemMsg", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.AdjustItemMsg ~= nil then
        protoAdjust.auction_adj.AdjustItemMsg(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111010
    protobufMgr.mMsgDeserializedTblCache = res
end

---购买响应
---msgID: 111012
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBuyAuctionItemMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111012 auctionV2.ItemMsg 购买响应")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.ItemMsg", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.AdjustItemMsg ~= nil then
        protoAdjust.auction_adj.AdjustItemMsg(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111012
    protobufMgr.mMsgDeserializedTblCache = res
end

---搜索响应
---msgID: 111015
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAuctionSearchMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111015 auctionV2.SearchAuctionItemResponse 搜索响应")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.SearchAuctionItemResponse", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.AdjustSearchAuctionItemResponse ~= nil then
        protoAdjust.auction_adj.AdjustSearchAuctionItemResponse(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111015
    protobufMgr.mMsgDeserializedTblCache = res
end

---购买失败响应
---msgID: 111016
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBuyLoseMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111016 auctionV2.lose 购买失败响应")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.lose", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.Adjustlose ~= nil then
        protoAdjust.auction_adj.Adjustlose(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111016
    protobufMgr.mMsgDeserializedTblCache = res
end

---上架失败响应
---msgID: 111017
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAddToShelfLoseMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111017 auctionV2.lose 上架失败响应")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.lose", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.Adjustlose ~= nil then
        protoAdjust.auction_adj.Adjustlose(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111017
    protobufMgr.mMsgDeserializedTblCache = res
end

---拍卖品的价格区间响应
---msgID: 111019
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMarketPriceSectionMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111019 auctionV2.MarketPriceSection 拍卖品的价格区间响应")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.MarketPriceSection", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.AdjustMarketPriceSection ~= nil then
        protoAdjust.auction_adj.AdjustMarketPriceSection(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111019
    protobufMgr.mMsgDeserializedTblCache = res
end

---拍卖响应
---msgID: 111021
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAuctionLotMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111021 auctionV2.AuctionItemInfo 拍卖响应")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.AuctionItemInfo", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.AdjustAuctionItemInfo ~= nil then
        protoAdjust.auction_adj.AdjustAuctionItemInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111021
    protobufMgr.mMsgDeserializedTblCache = res
end

---发布求购响应
---msgID: 111024
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResReleaseBuyProductsMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111024 auctionV2.AuctionItemInfo 发布求购响应")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.AuctionItemInfo", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.AdjustAuctionItemInfo ~= nil then
        protoAdjust.auction_adj.AdjustAuctionItemInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111024
    protobufMgr.mMsgDeserializedTblCache = res
end

---提交求购的物品响应
---msgID: 111026
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSubmitBuyProductsItemMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111026 auctionV2.SubmitBuyProductsItemResponse 提交求购的物品响应")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.SubmitBuyProductsItemResponse", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.AdjustSubmitBuyProductsItemResponse ~= nil then
        protoAdjust.auction_adj.AdjustSubmitBuyProductsItemResponse(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111026
    protobufMgr.mMsgDeserializedTblCache = res
end

---推送响应
---msgID: 111027
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPushMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111027 auctionV2.pushResponse 推送响应")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.pushResponse", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.AdjustpushResponse ~= nil then
        protoAdjust.auction_adj.AdjustpushResponse(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111027
    protobufMgr.mMsgDeserializedTblCache = res
end

---猜你喜欢响应
---msgID: 111030
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGuessYouLikeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111030 auctionV2.GuessYouLikeResponse 猜你喜欢响应")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.GuessYouLikeResponse", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.AdjustGuessYouLikeResponse ~= nil then
        protoAdjust.auction_adj.AdjustGuessYouLikeResponse(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111030
    protobufMgr.mMsgDeserializedTblCache = res
end

---交易记录响应
---msgID: 111034
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTradeRecordInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111034 auctionV2.TeadeRecordRes 交易记录响应")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.TeadeRecordRes", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.AdjustTeadeRecordRes ~= nil then
        protoAdjust.auction_adj.AdjustTeadeRecordRes(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111034
    protobufMgr.mMsgDeserializedTblCache = res
end

---领取交易记录响应
---msgID: 111036
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResReceiveTradeRecordMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111036 auctionV2.TradeRecordId 领取交易记录响应")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.TradeRecordId", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.AdjustTradeRecordId ~= nil then
        protoAdjust.auction_adj.AdjustTradeRecordId(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111036
    protobufMgr.mMsgDeserializedTblCache = res
end

---交易记录红点提示
---msgID: 111037
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTradeRecordRedPointMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111037 auctionV2.TradeRecordRedPoint 交易记录红点提示")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.TradeRecordRedPoint", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.AdjustTradeRecordRedPoint ~= nil then
        protoAdjust.auction_adj.AdjustTradeRecordRedPoint(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111037
    protobufMgr.mMsgDeserializedTblCache = res
end

---行会熔炼物品变动
---msgID: 111038
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnionSmeltGoodsChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111038 auctionV2.UnionSmeltGoodsChange 行会熔炼物品变动")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.UnionSmeltGoodsChange", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.AdjustUnionSmeltGoodsChange ~= nil then
        protoAdjust.auction_adj.AdjustUnionSmeltGoodsChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111038
    protobufMgr.mMsgDeserializedTblCache = res
end

---新增购买推送
---msgID: 111041
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAuctionPushMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111041 auctionV2.AuctionPush 新增购买推送")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.AuctionPush", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.AdjustAuctionPush ~= nil then
        protoAdjust.auction_adj.AdjustAuctionPush(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111041
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回快捷购买道具
---msgID: 111044
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResQuickAuctionItemMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111044 auctionV2.ResQuickAuctionItem 返回快捷购买道具")
        return nil
    end
    local res = protobufMgr.Deserialize("auctionV2.ResQuickAuctionItem", buffer)
    if protoAdjust.auction_adj ~= nil and protoAdjust.auction_adj.AdjustResQuickAuctionItem ~= nil then
        protoAdjust.auction_adj.AdjustResQuickAuctionItem(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111044
    protobufMgr.mMsgDeserializedTblCache = res
end

