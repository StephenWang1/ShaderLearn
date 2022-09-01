--[[本文件为工具自动生成,禁止手动修改]]
--appearance.xml

--region ID:121001 请求启用的时装列表
---请求启用的时装列表
---msgID: 121001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetWearFashion()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetWearFashionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetWearFashionMessage](LuaEnumNetDef.ReqGetWearFashionMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetWearFashionMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:121003 请求拥有的时装列表
---请求拥有的时装列表
---msgID: 121003
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetHasFashion()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetHasFashionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetHasFashionMessage](LuaEnumNetDef.ReqGetHasFashionMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetHasFashionMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:121005 请求起用这件时装
---请求起用这件时装
---msgID: 121005
---@param itemId number 选填参数 itemId
---@param close number 选填参数 1是启用  2是关闭
---@return boolean 网络请求是否成功发送
function networkRequest.ReqEnableFashion(itemId, close)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    if close ~= nil then
        reqTable.close = close
    end
    local reqMsgData = protobufMgr.Serialize("appearanceV2.ReqEnableFashion" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqEnableFashionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqEnableFashionMessage](LuaEnumNetDef.ReqEnableFashionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqEnableFashionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqEnableFashionMessage", 121005, "ReqEnableFashion", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:121007 请求起用关闭称谓
---请求起用关闭称谓
---msgID: 121007
---@param titleId number 选填参数 titleId
---@param close number 选填参数 1是启用  2是关闭
---@return boolean 网络请求是否成功发送
function networkRequest.ReqEnableTitle(titleId, close)
    local reqTable = {}
    if titleId ~= nil then
        reqTable.titleId = titleId
    end
    if close ~= nil then
        reqTable.close = close
    end
    local reqMsgData = protobufMgr.Serialize("appearanceV2.ReqEnableTitle" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqEnableTitleMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqEnableTitleMessage](LuaEnumNetDef.ReqEnableTitleMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqEnableTitleMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqEnableTitleMessage", 121007, "ReqEnableTitle", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:121008 请求修改称谓
---请求修改称谓
---msgID: 121008
---@param titleId number 选填参数 titleId
---@param modifyTitle string 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqModifyTitle(titleId, modifyTitle)
    local reqTable = {}
    if titleId ~= nil then
        reqTable.titleId = titleId
    end
    if modifyTitle ~= nil then
        reqTable.modifyTitle = modifyTitle
    end
    local reqMsgData = protobufMgr.Serialize("appearanceV2.ReqModifyTitle" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqModifyTitleMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqModifyTitleMessage](LuaEnumNetDef.ReqModifyTitleMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqModifyTitleMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqModifyTitleMessage", 121008, "ReqModifyTitle", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

