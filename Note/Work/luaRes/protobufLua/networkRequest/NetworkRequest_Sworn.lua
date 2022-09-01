--[[本文件为工具自动生成,禁止手动修改]]
--sworn.xml

--region ID:113001 请求结义
---请求结义
---msgID: 113001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqHasSworn()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqHasSwornMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqHasSwornMessage](LuaEnumNetDef.ReqHasSwornMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqHasSwornMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:113006 请求同意或不同意结义消息
---请求同意或不同意结义消息
---msgID: 113006
---@param agree number 选填参数 1同意 2不同意
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAgreeSworn(agree)
    local reqTable = {}
    if agree ~= nil then
        reqTable.agree = agree
    end
    local reqMsgData = protobufMgr.Serialize("swornV2.ReqAgreeSworn" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAgreeSwornMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAgreeSwornMessage](LuaEnumNetDef.ReqAgreeSwornMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAgreeSwornMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAgreeSwornMessage", 113006, "ReqAgreeSworn", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:113008 请求中断结义
---请求中断结义
---msgID: 113008
---@return boolean 网络请求是否成功发送
function networkRequest.ReqInterruptSworn()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqInterruptSwornMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqInterruptSwornMessage](LuaEnumNetDef.ReqInterruptSwornMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqInterruptSwornMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:113011 请求解散兄弟关系
---请求解散兄弟关系
---msgID: 113011
---@param brotherId number 选填参数 要解散的兄弟Id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDissolutionBrother(brotherId)
    local reqTable = {}
    if brotherId ~= nil then
        reqTable.brotherId = brotherId
    end
    local reqMsgData = protobufMgr.Serialize("swornV2.ReqDissolutionBrother" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDissolutionBrotherMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDissolutionBrotherMessage](LuaEnumNetDef.ReqDissolutionBrotherMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDissolutionBrotherMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDissolutionBrotherMessage", 113011, "ReqDissolutionBrother", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:113012 请求撤回解散兄弟关系
---请求撤回解散兄弟关系
---msgID: 113012
---@param brotherId number 选填参数 要撤回的兄弟Id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRegretsDissolution(brotherId)
    local reqTable = {}
    if brotherId ~= nil then
        reqTable.brotherId = brotherId
    end
    local reqMsgData = protobufMgr.Serialize("swornV2.ReqRegretsDissolution" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRegretsDissolutionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRegretsDissolutionMessage](LuaEnumNetDef.ReqRegretsDissolutionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRegretsDissolutionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRegretsDissolutionMessage", 113012, "ReqRegretsDissolution", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:113013 请求结义成功
---请求结义成功
---msgID: 113013
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSwornSuccess()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSwornSuccessMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSwornSuccessMessage](LuaEnumNetDef.ReqSwornSuccessMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqSwornSuccessMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:113014 请求解散时兄弟关系信息
---请求解散时兄弟关系信息
---msgID: 113014
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBrotherInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBrotherInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBrotherInfoMessage](LuaEnumNetDef.ReqBrotherInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqBrotherInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:113018 请求断义列表
---请求断义列表
---msgID: 113018
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBreakOffRelations()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBreakOffRelationsMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBreakOffRelationsMessage](LuaEnumNetDef.ReqBreakOffRelationsMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqBreakOffRelationsMessage, nil, true)
    end
    return canSendMsg
end
--endregion

