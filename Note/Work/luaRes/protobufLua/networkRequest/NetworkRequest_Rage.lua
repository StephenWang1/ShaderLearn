--[[本文件为工具自动生成,禁止手动修改]]
--rage.xml

--region ID:130001 狂暴之力弹窗今天不再提示
---狂暴之力弹窗今天不再提示
---msgID: 130001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqChangeRage()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqChangeRageMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqChangeRageMessage](LuaEnumNetDef.ReqChangeRageMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqChangeRageMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:130003 狂暴之力状态请求
---狂暴之力状态请求
---msgID: 130003
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRageState()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRageStateMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRageStateMessage](LuaEnumNetDef.ReqRageStateMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqRageStateMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:130004 狂暴之力激活或取消请求
---狂暴之力激活或取消请求
---msgID: 130004
---@param type number 选填参数 type 1:激活 2:取消
---@return boolean 网络请求是否成功发送
function networkRequest.ReqActivateOrCancelRage(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("rageV2.ActivateOrCancelRage" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqActivateOrCancelRageMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqActivateOrCancelRageMessage](LuaEnumNetDef.ReqActivateOrCancelRageMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqActivateOrCancelRageMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqActivateOrCancelRageMessage", 130004, "ActivateOrCancelRage", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

