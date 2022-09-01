--[[本文件为工具自动生成,禁止手动修改]]
--chat.xml

--region ID:6001 请求GM命令
---请求GM命令
---msgID: 6001
---@param command string 选填参数 gm命令
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGM(command)
    local reqTable = {}
    if command ~= nil then
        reqTable.command = command
    end
    local reqMsgData = protobufMgr.Serialize("chatV2.ReqGM" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGMMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGMMessage](LuaEnumNetDef.ReqGMMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGMMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGMMessage", 6001, "ReqGM", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:6003 请求聊天
---请求聊天
---msgID: 6003
---@param channel number 选填参数 频道 1世界 2私聊
---@param message string 选填参数
---@param privateRoleId number 选填参数 私聊目标玩家id
---@param sound boolean 选填参数 是否语音
---@param sendToName string 选填参数 私聊目标玩家的名字
---@param quickChatId number 选填参数 快速语句Id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqChat(channel, message, privateRoleId, sound, sendToName, quickChatId)
    local reqTable = {}
    if channel ~= nil then
        reqTable.channel = channel
    end
    if message ~= nil then
        reqTable.message = message
    end
    if privateRoleId ~= nil then
        reqTable.privateRoleId = privateRoleId
    end
    if sound ~= nil then
        reqTable.sound = sound
    end
    if sendToName ~= nil then
        reqTable.sendToName = sendToName
    end
    if quickChatId ~= nil then
        reqTable.quickChatId = quickChatId
    end
    local reqMsgData = protobufMgr.Serialize("chatV2.ReqChat" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqChatMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqChatMessage](LuaEnumNetDef.ReqChatMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqChatMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqChatMessage", 6003, "ReqChat", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:6006 查看他人信息
---查看他人信息
---msgID: 6006
---@param targetUid number 选填参数 查看的对象
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLookOther(targetUid)
    local reqTable = {}
    if targetUid ~= nil then
        reqTable.targetUid = targetUid
    end
    local reqMsgData = protobufMgr.Serialize("chatV2.ReqLookOther" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLookOtherMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLookOtherMessage](LuaEnumNetDef.ReqLookOtherMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqLookOtherMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqLookOtherMessage", 6006, "ReqLookOther", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:6009 拉取最近几条聊天历史
---拉取最近几条聊天历史
---msgID: 6009
---@param type number 选填参数 聊天类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPullChatHistory(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("chatV2.ReqPullChatHistory" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPullChatHistoryMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPullChatHistoryMessage](LuaEnumNetDef.ReqPullChatHistoryMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPullChatHistoryMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPullChatHistoryMessage", 6009, "ReqPullChatHistory", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:6011 发送特殊广播信息
---发送特殊广播信息
---msgID: 6011
---@param announceId number 选填参数 公告id
---@param channelType number 选填参数 频道类别 1世界 2行会 4普通 5组队 100私聊
---@param targetId number 选填参数 目标对象，私聊的时候需要发
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSendSpecialAnnounce(announceId, channelType, targetId)
    local reqTable = {}
    if announceId ~= nil then
        reqTable.announceId = announceId
    end
    if channelType ~= nil then
        reqTable.channelType = channelType
    end
    if targetId ~= nil then
        reqTable.targetId = targetId
    end
    local reqMsgData = protobufMgr.Serialize("chatV2.ReqSendSpecialAnnounce" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSendSpecialAnnounceMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSendSpecialAnnounceMessage](LuaEnumNetDef.ReqSendSpecialAnnounceMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSendSpecialAnnounceMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSendSpecialAnnounceMessage", 6011, "ReqSendSpecialAnnounce", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:6012 请求聊天按钮回复
---请求聊天按钮回复
---msgID: 6012
---@param id number 选填参数 聊天记录唯一id
---@param senderId number 选填参数 发送者id
---@param toRid number 选填参数 收到的id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBtnsReply(id, senderId, toRid)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    if senderId ~= nil then
        reqTable.senderId = senderId
    end
    if toRid ~= nil then
        reqTable.toRid = toRid
    end
    local reqMsgData = protobufMgr.Serialize("chatV2.ReqBtnsReply" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBtnsReplyMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBtnsReplyMessage](LuaEnumNetDef.ReqBtnsReplyMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqBtnsReplyMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqBtnsReplyMessage", 6012, "ReqBtnsReply", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:6013 请求塔罗神庙公告历史记录
---请求塔罗神庙公告历史记录
---msgID: 6013
---@return boolean 网络请求是否成功发送
function networkRequest.ReqHuntAnnounce()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqHuntAnnounceMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqHuntAnnounceMessage](LuaEnumNetDef.ReqHuntAnnounceMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqHuntAnnounceMessage, nil, true)
    end
    return canSendMsg
end
--endregion

