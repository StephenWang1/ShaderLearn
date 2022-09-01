--[[本文件为工具自动生成,禁止手动修改]]
--element.xml

--region ID:110001 请求元素套装信息
---请求元素套装信息
---msgID: 110001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqElementSuitInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqElementSuitInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqElementSuitInfoMessage](LuaEnumNetDef.ReqElementSuitInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqElementSuitInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:110003 请求镶嵌元素
---请求镶嵌元素
---msgID: 110003
---@param index number 选填参数 镶嵌的位置
---@param elementId number 选填参数 要镶嵌的元素唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPutUpElement(index, elementId)
    local reqTable = {}
    if index ~= nil then
        reqTable.index = index
    end
    if elementId ~= nil then
        reqTable.elementId = elementId
    end
    local reqMsgData = protobufMgr.Serialize("elementV2.ReqPutUpElement" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPutUpElementMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPutUpElementMessage](LuaEnumNetDef.ReqPutUpElementMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPutUpElementMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPutUpElementMessage", 110003, "ReqPutUpElement", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:110004 请求取下元素
---请求取下元素
---msgID: 110004
---@param index number 选填参数 镶嵌的位置
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTakeOffElement(index)
    local reqTable = {}
    if index ~= nil then
        reqTable.index = index
    end
    local reqMsgData = protobufMgr.Serialize("elementV2.ReqTakeOffElement" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTakeOffElementMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTakeOffElementMessage](LuaEnumNetDef.ReqTakeOffElementMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqTakeOffElementMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqTakeOffElementMessage", 110004, "ReqTakeOffElement", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

