--[[本文件为工具自动生成,禁止手动修改]]
--trade.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回交易请求
---msgID: 104002
---@param msgID LuaEnumNetDef 消息ID
---@return tradeV2.ResTrade C#数据结构
function networkRespond.OnResTradeMessageReceived(msgID)
    ---@type tradeV2.ResTrade
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 104002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 104002 tradeV2.ResTrade 返回交易请求")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.trade ~= nil and  protobufMgr.DecodeTable.trade.ResTrade ~= nil then
        csData = protobufMgr.DecodeTable.trade.ResTrade(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回交易状态变化
---msgID: 104007
---@param msgID LuaEnumNetDef 消息ID
---@return tradeV2.ResTradeStateChange C#数据结构
function networkRespond.OnResTradeStateChangeMessageReceived(msgID)
    ---@type tradeV2.ResTradeStateChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 104007 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 104007 tradeV2.ResTradeStateChange 返回交易状态变化")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.trade ~= nil and  protobufMgr.DecodeTable.trade.ResTradeStateChange ~= nil then
        csData = protobufMgr.DecodeTable.trade.ResTradeStateChange(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---交易开始
---msgID: 104008
---@param msgID LuaEnumNetDef 消息ID
---@return tradeV2.TradeInfo C#数据结构
function networkRespond.OnResTradeStartMessageReceived(msgID)
    ---@type tradeV2.TradeInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 104008 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 104008 tradeV2.TradeInfo 交易开始")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.trade ~= nil and  protobufMgr.DecodeTable.trade.TradeInfo ~= nil then
        csData = protobufMgr.DecodeTable.trade.TradeInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---交易变化
---msgID: 104009
---@param msgID LuaEnumNetDef 消息ID
---@return tradeV2.TradeInfo C#数据结构
function networkRespond.OnResTradeUpdateMessageReceived(msgID)
    ---@type tradeV2.TradeInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 104009 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 104009 tradeV2.TradeInfo 交易变化")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.trade ~= nil and  protobufMgr.DecodeTable.trade.TradeInfo ~= nil then
        csData = protobufMgr.DecodeTable.trade.TradeInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

