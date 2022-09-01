--[[本文件为工具自动生成,禁止手动修改]]
--move.xml

--region ID:68001 请求慢走
---请求慢走
---msgID: 68001
---@param x number 选填参数
---@param y number 选填参数
---@param action number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqMove(x, y, action)
    local reqTable = {}
    if x ~= nil then
        reqTable.x = x
    end
    if y ~= nil then
        reqTable.y = y
    end
    if action ~= nil then
        reqTable.action = action
    end
    local reqMsgData = protobufMgr.Serialize("moveV2.ReqMove" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqMoveMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqMoveMessage](LuaEnumNetDef.ReqMoveMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqMoveMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqMoveMessage", 68001, "ReqMove", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:68007 请求改变朝向
---请求改变朝向
---msgID: 68007
---@param dir byte[] 选填参数 朝向
---@return boolean 网络请求是否成功发送
function networkRequest.ReqChangeDir(dir)
    local reqTable = {}
    if dir ~= nil then
        reqTable.dir = dir
    end
    local reqMsgData = protobufMgr.Serialize("moveV2.ReqChangeDir" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqChangeDirMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqChangeDirMessage](LuaEnumNetDef.ReqChangeDirMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqChangeDirMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqChangeDirMessage", 68007, "ReqChangeDir", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:68009 前面玩家慢走快走
---前面玩家慢走快走
---msgID: 68009
---@param x number 选填参数
---@param y number 选填参数
---@param startTime number 选填参数
---@param action number 选填参数
---@param currentX number 选填参数 不需要
---@param currentY number 选填参数 不需要
---@param changePosFirst boolean 选填参数 改变位置后第一次移动
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPlayerMove(x, y, startTime, action, currentX, currentY, changePosFirst)
    local reqTable = {}
    if x ~= nil then
        reqTable.x = x
    end
    if y ~= nil then
        reqTable.y = y
    end
    if startTime ~= nil then
        reqTable.startTime = startTime
    end
    if action ~= nil then
        reqTable.action = action
    end
    if currentX ~= nil then
        reqTable.currentX = currentX
    end
    if currentY ~= nil then
        reqTable.currentY = currentY
    end
    if changePosFirst ~= nil then
        reqTable.changePosFirst = changePosFirst
    end
    local reqMsgData = protobufMgr.Serialize("moveV2.ReqPlayerMoveRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPlayerMoveMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPlayerMoveMessage](LuaEnumNetDef.ReqPlayerMoveMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPlayerMoveMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPlayerMoveMessage", 68009, "ReqPlayerMoveRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

