--[[本文件为工具自动生成,禁止手动修改]]
--trade.xml

--region ID:104001 请求进行交易
---请求进行交易
---msgID: 104001
---@param uid number 选填参数 玩家ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTrade(uid)
    local reqTable = {}
    if uid ~= nil then
        reqTable.uid = uid
    end
    local reqMsgData = protobufMgr.Serialize("tradeV2.ReqTrade" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTradeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTradeMessage](LuaEnumNetDef.ReqTradeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqTradeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqTradeMessage", 104001, "ReqTrade", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:104003 同意交易
---同意交易
---msgID: 104003
---@param uid number 选填参数 玩家ID
---@param agree number 选填参数 0.拒绝1.同意
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAgreeTrade(uid, agree)
    local reqTable = {}
    if uid ~= nil then
        reqTable.uid = uid
    end
    if agree ~= nil then
        reqTable.agree = agree
    end
    local reqMsgData = protobufMgr.Serialize("tradeV2.ReqAgreeTrade" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAgreeTradeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAgreeTradeMessage](LuaEnumNetDef.ReqAgreeTradeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAgreeTradeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAgreeTradeMessage", 104003, "ReqAgreeTrade", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:104006 设置交易进度
---设置交易进度
---msgID: 104006
---@param operation number 选填参数 锁定，1锁定，2取消锁定，3确认交易，4取消交易
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSetTradeProgress(operation)
    local reqTable = {}
    if operation ~= nil then
        reqTable.operation = operation
    end
    local reqMsgData = protobufMgr.Serialize("tradeV2.ReqSetTradeProgress" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSetTradeProgressMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSetTradeProgressMessage](LuaEnumNetDef.ReqSetTradeProgressMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSetTradeProgressMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSetTradeProgressMessage", 104006, "ReqSetTradeProgress", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:104010 添加物品请求
---添加物品请求
---msgID: 104010
---@param itemId number 必填参数
---@param count number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAddItemToTrade(itemId, count)
    local reqTable = {}
    reqTable.itemId = itemId
    reqTable.count = count
    local reqMsgData = protobufMgr.Serialize("tradeV2.AddItemToTradeRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAddItemToTradeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAddItemToTradeMessage](LuaEnumNetDef.ReqAddItemToTradeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAddItemToTradeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAddItemToTradeMessage", 104010, "AddItemToTradeRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:104011 去除物品请求
---去除物品请求
---msgID: 104011
---@param lid number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRemoveItemFromTrade(lid)
    local reqTable = {}
    reqTable.lid = lid
    local reqMsgData = protobufMgr.Serialize("tradeV2.RemoveItemFromTradeRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRemoveItemFromTradeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRemoveItemFromTradeMessage](LuaEnumNetDef.ReqRemoveItemFromTradeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRemoveItemFromTradeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRemoveItemFromTradeMessage", 104011, "RemoveItemFromTradeRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:104012 设置交易金额
---设置交易金额
---msgID: 104012
---@param gold number 必填参数
---@param yuanbao number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSetTradeMoney(gold, yuanbao)
    local reqTable = {}
    reqTable.gold = gold
    reqTable.yuanbao = yuanbao
    local reqMsgData = protobufMgr.Serialize("tradeV2.SetTradeMoneyRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSetTradeMoneyMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSetTradeMoneyMessage](LuaEnumNetDef.ReqSetTradeMoneyMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSetTradeMoneyMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSetTradeMoneyMessage", 104012, "SetTradeMoneyRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

