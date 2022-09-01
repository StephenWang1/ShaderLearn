--[[本文件为工具自动生成,禁止手动修改]]
--finger.xml

--region ID:112001 请求最近划拳对象
---请求最近划拳对象
---msgID: 112001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLatelyFingerPlayers()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLatelyFingerPlayersMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLatelyFingerPlayersMessage](LuaEnumNetDef.ReqLatelyFingerPlayersMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqLatelyFingerPlayersMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:112003 邀请玩家划拳
---邀请玩家划拳
---msgID: 112003
---@param playerId number 选填参数 被挑战者
---@param playerName string 选填参数 name
---@return boolean 网络请求是否成功发送
function networkRequest.ReqInviteFinger(playerId, playerName)
    local reqTable = {}
    if playerId ~= nil then
        reqTable.playerId = playerId
    end
    if playerName ~= nil then
        reqTable.playerName = playerName
    end
    local reqMsgData = protobufMgr.Serialize("fingerV2.ReqInviteFinger" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqInviteFingerMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqInviteFingerMessage](LuaEnumNetDef.ReqInviteFingerMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqInviteFingerMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqInviteFingerMessage", 112003, "ReqInviteFinger", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:112005 被挑战者请求回应邀请
---被挑战者请求回应邀请
---msgID: 112005
---@param dealerId number 选填参数
---@param isPlay number 选填参数 0拒绝 1接收
---@return boolean 网络请求是否成功发送
function networkRequest.ReqEchoInvite(dealerId, isPlay)
    local reqTable = {}
    if dealerId ~= nil then
        reqTable.dealerId = dealerId
    end
    if isPlay ~= nil then
        reqTable.isPlay = isPlay
    end
    local reqMsgData = protobufMgr.Serialize("fingerV2.ReqEchoInvite" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqEchoInviteMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqEchoInviteMessage](LuaEnumNetDef.ReqEchoInviteMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqEchoInviteMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqEchoInviteMessage", 112005, "ReqEchoInvite", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:112007 请求使用筹码
---请求使用筹码
---msgID: 112007
---@param chipNum number 选填参数 筹码数量
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUseChip(chipNum)
    local reqTable = {}
    if chipNum ~= nil then
        reqTable.chipNum = chipNum
    end
    local reqMsgData = protobufMgr.Serialize("fingerV2.ReqUseChip" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUseChipMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUseChipMessage](LuaEnumNetDef.ReqUseChipMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUseChipMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUseChipMessage", 112007, "ReqUseChip", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:112009 请求出拳
---请求出拳
---msgID: 112009
---@param type number 选填参数 1石头 2剪刀 3布
---@return boolean 网络请求是否成功发送
function networkRequest.ReqChoseFinger(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("fingerV2.ReqChoseFinger" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqChoseFingerMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqChoseFingerMessage](LuaEnumNetDef.ReqChoseFingerMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqChoseFingerMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqChoseFingerMessage", 112009, "ReqChoseFinger", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:112011 请求猜拳结果
---请求猜拳结果
---msgID: 112011
---@return boolean 网络请求是否成功发送
function networkRequest.ReqFingerResult()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqFingerResultMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqFingerResultMessage](LuaEnumNetDef.ReqFingerResultMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqFingerResultMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:112013 请求终止猜拳
---请求终止猜拳
---msgID: 112013
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTerminateFinger()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTerminateFingerMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTerminateFingerMessage](LuaEnumNetDef.ReqTerminateFingerMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqTerminateFingerMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:112015 请求邀请剩余时间
---请求邀请剩余时间
---msgID: 112015
---@param dealer number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqEchoInviteTime(dealer)
    local reqTable = {}
    if dealer ~= nil then
        reqTable.dealer = dealer
    end
    local reqMsgData = protobufMgr.Serialize("fingerV2.ReqEchoInviteTime" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqEchoInviteTimeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqEchoInviteTimeMessage](LuaEnumNetDef.ReqEchoInviteTimeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqEchoInviteTimeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqEchoInviteTimeMessage", 112015, "ReqEchoInviteTime", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

