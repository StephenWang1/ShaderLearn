--[[本文件为工具自动生成,禁止手动修改]]
--imprint.xml

--region ID:120001 请求印记信息
---请求印记信息
---msgID: 120001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqImprintInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqImprintInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqImprintInfoMessage](LuaEnumNetDef.ReqImprintInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqImprintInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:120003 请求镶嵌
---请求镶嵌
---msgID: 120003
---@param index number 选填参数 位置
---@param imprintId number 选填参数 物品ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPutOnImprint(index, imprintId)
    local reqTable = {}
    if index ~= nil then
        reqTable.index = index
    end
    if imprintId ~= nil then
        reqTable.imprintId = imprintId
    end
    local reqMsgData = protobufMgr.Serialize("imprintV2.ReqPutOnImprint" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPutOnImprintMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPutOnImprintMessage](LuaEnumNetDef.ReqPutOnImprintMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPutOnImprintMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPutOnImprintMessage", 120003, "ReqPutOnImprint", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:120004 请求取下
---请求取下
---msgID: 120004
---@param index number 选填参数 位置
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTakeOffImprint(index)
    local reqTable = {}
    if index ~= nil then
        reqTable.index = index
    end
    local reqMsgData = protobufMgr.Serialize("imprintV2.ReqTakeOffImprint" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTakeOffImprintMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTakeOffImprintMessage](LuaEnumNetDef.ReqTakeOffImprintMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqTakeOffImprintMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqTakeOffImprintMessage", 120004, "ReqTakeOffImprint", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

