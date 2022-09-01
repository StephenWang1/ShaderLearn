--[[本文件为工具自动生成,禁止手动修改]]
--junxian.xml

--region ID:59006 获取军衔当前等级
---获取军衔当前等级
---msgID: 59006
---@return boolean 网络请求是否成功发送
function networkRequest.ReqJunXianLevel()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqJunXianLevelMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqJunXianLevelMessage](LuaEnumNetDef.ReqJunXianLevelMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqJunXianLevelMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:59008 军衔升级请求
---军衔升级请求
---msgID: 59008
---@param thisJunXianId number 选填参数 当前军衔ID
---@param nextJunXianId number 选填参数 下级军衔ID
---@param thisNbValue number 选填参数 现在战斗力
---@return boolean 网络请求是否成功发送
function networkRequest.ReqJunXianUp(thisJunXianId, nextJunXianId, thisNbValue)
    local reqTable = {}
    if thisJunXianId ~= nil then
        reqTable.thisJunXianId = thisJunXianId
    end
    if nextJunXianId ~= nil then
        reqTable.nextJunXianId = nextJunXianId
    end
    if thisNbValue ~= nil then
        reqTable.thisNbValue = thisNbValue
    end
    local reqMsgData = protobufMgr.Serialize("junxianV2.ReqJunXianUp" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqJunXianUpMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqJunXianUpMessage](LuaEnumNetDef.ReqJunXianUpMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqJunXianUpMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqJunXianUpMessage", 59008, "ReqJunXianUp", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

