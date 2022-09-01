--[[本文件为工具自动生成,禁止手动修改]]
--title.xml

--region ID:33001 请求称号列表信息
---请求称号列表信息
---msgID: 33001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTitleList()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTitleListMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTitleListMessage](LuaEnumNetDef.ReqTitleListMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqTitleListMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:33005 请求佩戴称号
---请求佩戴称号
---msgID: 33005
---@param titleId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPutOnTitle(titleId)
    local reqTable = {}
    reqTable.titleId = titleId
    local reqMsgData = protobufMgr.Serialize("titleV2.ReqPutOnTitle" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPutOnTitleMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPutOnTitleMessage](LuaEnumNetDef.ReqPutOnTitleMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPutOnTitleMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPutOnTitleMessage", 33005, "ReqPutOnTitle", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:33007 请求脱下称号
---请求脱下称号
---msgID: 33007
---@param titleId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPutOffTitle(titleId)
    local reqTable = {}
    reqTable.titleId = titleId
    local reqMsgData = protobufMgr.Serialize("titleV2.ReqPutOffTitle" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPutOffTitleMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPutOffTitleMessage](LuaEnumNetDef.ReqPutOffTitleMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPutOffTitleMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPutOffTitleMessage", 33007, "ReqPutOffTitle", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

