--[[本文件为工具自动生成,禁止手动修改]]
--ghostship.xml

--region ID:132001 请求协助
---请求协助
---msgID: 132001
---@param monsterId number 必填参数 目标id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAssist(monsterId)
    local reqTable = {}
    reqTable.monsterId = monsterId
    local reqMsgData = protobufMgr.Serialize("ghostshipV2.ReqAssist" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAssistMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAssistMessage](LuaEnumNetDef.ReqAssistMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAssistMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAssistMessage", 132001, "ReqAssist", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

