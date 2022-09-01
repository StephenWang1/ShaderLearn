--[[本文件为工具自动生成,禁止手动修改]]
--trade.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回交易请求
---msgID: 104002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTradeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 104002 tradeV2.ResTrade 返回交易请求")
        return nil
    end
    local res = protobufMgr.Deserialize("tradeV2.ResTrade", buffer)
    if protoAdjust.trade_adj ~= nil and protoAdjust.trade_adj.AdjustResTrade ~= nil then
        protoAdjust.trade_adj.AdjustResTrade(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 104002
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回交易状态变化
---msgID: 104007
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTradeStateChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 104007 tradeV2.ResTradeStateChange 返回交易状态变化")
        return nil
    end
    local res = protobufMgr.Deserialize("tradeV2.ResTradeStateChange", buffer)
    if protoAdjust.trade_adj ~= nil and protoAdjust.trade_adj.AdjustResTradeStateChange ~= nil then
        protoAdjust.trade_adj.AdjustResTradeStateChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 104007
    protobufMgr.mMsgDeserializedTblCache = res
end

---交易开始
---msgID: 104008
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTradeStartMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 104008 tradeV2.TradeInfo 交易开始")
        return nil
    end
    local res = protobufMgr.Deserialize("tradeV2.TradeInfo", buffer)
    if protoAdjust.trade_adj ~= nil and protoAdjust.trade_adj.AdjustTradeInfo ~= nil then
        protoAdjust.trade_adj.AdjustTradeInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 104008
    protobufMgr.mMsgDeserializedTblCache = res
end

---交易变化
---msgID: 104009
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTradeUpdateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 104009 tradeV2.TradeInfo 交易变化")
        return nil
    end
    local res = protobufMgr.Deserialize("tradeV2.TradeInfo", buffer)
    if protoAdjust.trade_adj ~= nil and protoAdjust.trade_adj.AdjustTradeInfo ~= nil then
        protoAdjust.trade_adj.AdjustTradeInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 104009
    protobufMgr.mMsgDeserializedTblCache = res
end

