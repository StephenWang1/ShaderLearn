--[[本文件为工具自动生成,禁止手动修改]]
--group.xml

--region ID:101001 请求组队面板信息
---请求组队面板信息
---msgID: 101001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGroupDetailedInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGroupDetailedInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGroupDetailedInfoMessage](LuaEnumNetDef.ReqGroupDetailedInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGroupDetailedInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:101002 请求改变队伍目标
---请求改变队伍目标
---msgID: 101002
---@param targetId number 选填参数 目标id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqChangeTarget(targetId)
    local reqTable = {}
    if targetId ~= nil then
        reqTable.targetId = targetId
    end
    local reqMsgData = protobufMgr.Serialize("groupV2.ReqChangeTarget" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqChangeTargetMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqChangeTargetMessage](LuaEnumNetDef.ReqChangeTargetMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqChangeTargetMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqChangeTargetMessage", 101002, "ReqChangeTarget", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:101003 请求转移队伍队长
---请求转移队伍队长
---msgID: 101003
---@param captainId number 选填参数 新的队长rid
---@return boolean 网络请求是否成功发送
function networkRequest.ReqChangeCaptain(captainId)
    local reqTable = {}
    if captainId ~= nil then
        reqTable.captainId = captainId
    end
    local reqMsgData = protobufMgr.Serialize("groupV2.ReqChangeCaptain" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqChangeCaptainMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqChangeCaptainMessage](LuaEnumNetDef.ReqChangeCaptainMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqChangeCaptainMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqChangeCaptainMessage", 101003, "ReqChangeCaptain", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:101004 请求创建队伍
---请求创建队伍
---msgID: 101004
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCreatGroup()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCreatGroupMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCreatGroupMessage](LuaEnumNetDef.ReqCreatGroupMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqCreatGroupMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:101005 请求队伍踢出玩家
---请求队伍踢出玩家
---msgID: 101005
---@param rid number 选填参数 被踢出玩家id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqKickMember(rid)
    local reqTable = {}
    if rid ~= nil then
        reqTable.rid = rid
    end
    local reqMsgData = protobufMgr.Serialize("groupV2.ReqKickMember" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqKickMemberMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqKickMemberMessage](LuaEnumNetDef.ReqKickMemberMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqKickMemberMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqKickMemberMessage", 101005, "ReqKickMember", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:101006 玩家请求离开队伍
---玩家请求离开队伍
---msgID: 101006
---@param targetId number 选填参数 退出队伍的玩家id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqExitGroup(targetId)
    local reqTable = {}
    if targetId ~= nil then
        reqTable.targetId = targetId
    end
    local reqMsgData = protobufMgr.Serialize("groupV2.ReqExitGroup" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqExitGroupMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqExitGroupMessage](LuaEnumNetDef.ReqExitGroupMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqExitGroupMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqExitGroupMessage", 101006, "ReqExitGroup", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:101007 接受组队申请
---接受组队申请
---msgID: 101007
---@param state number 选填参数 接受或拒绝组队申请，1为接受，2为拒绝
---@param rid number 选填参数 接受申请玩家id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAcceptTeamApplication(state, rid)
    local reqTable = {}
    if state ~= nil then
        reqTable.state = state
    end
    if rid ~= nil then
        reqTable.rid = rid
    end
    local reqMsgData = protobufMgr.Serialize("groupV2.AcceptTeam" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAcceptTeamApplicationMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAcceptTeamApplicationMessage](LuaEnumNetDef.ReqAcceptTeamApplicationMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAcceptTeamApplicationMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAcceptTeamApplicationMessage", 101007, "AcceptTeam", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:101009 请求打开组队请求界面
---请求打开组队请求界面
---msgID: 101009
---@return boolean 网络请求是否成功发送
function networkRequest.ReqApplyList()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqApplyListMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqApplyListMessage](LuaEnumNetDef.ReqApplyListMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqApplyListMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:101010 请求加入队伍
---请求加入队伍
---msgID: 101010
---@param groupId number 选填参数 队伍id
---@param type number 选填参数 1：自动组队 2：手动 3：拒绝
---@return boolean 网络请求是否成功发送
function networkRequest.ReqJoinGroup(groupId, type)
    local reqTable = {}
    if groupId ~= nil then
        reqTable.groupId = groupId
    end
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("groupV2.ReqJoinGroup" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqJoinGroupMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqJoinGroupMessage](LuaEnumNetDef.ReqJoinGroupMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqJoinGroupMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqJoinGroupMessage", 101010, "ReqJoinGroup", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:101012 玩家请求附近可以申请队伍列表
---玩家请求附近可以申请队伍列表
---msgID: 101012
---@return boolean 网络请求是否成功发送
function networkRequest.ReqNearbyGroup()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqNearbyGroupMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqNearbyGroupMessage](LuaEnumNetDef.ReqNearbyGroupMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqNearbyGroupMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:101014 请求邀请玩家
---请求邀请玩家
---msgID: 101014
---@param rid number 选填参数 被邀请玩家id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqInvitationPlayer(rid)
    local reqTable = {}
    if rid ~= nil then
        reqTable.rid = rid
    end
    local reqMsgData = protobufMgr.Serialize("groupV2.ReqInvitationPlayer" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqInvitationPlayerMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqInvitationPlayerMessage](LuaEnumNetDef.ReqInvitationPlayerMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqInvitationPlayerMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqInvitationPlayerMessage", 101014, "ReqInvitationPlayer", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:101015 玩家接受邀请
---玩家接受邀请
---msgID: 101015
---@param state number 选填参数 接受或拒绝组队邀请，1为接受，2为拒绝
---@param groupId number 选填参数 接受队伍id
---@param targetId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAcceptInvitation(state, groupId, targetId)
    local reqTable = {}
    if state ~= nil then
        reqTable.state = state
    end
    if groupId ~= nil then
        reqTable.groupId = groupId
    end
    if targetId ~= nil then
        reqTable.targetId = targetId
    end
    local reqMsgData = protobufMgr.Serialize("groupV2.ReqAcceptInvitation" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAcceptInvitationMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAcceptInvitationMessage](LuaEnumNetDef.ReqAcceptInvitationMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAcceptInvitationMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAcceptInvitationMessage", 101015, "ReqAcceptInvitation", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:101017 队伍请求邀请附近的人列表
---队伍请求邀请附近的人列表
---msgID: 101017
---@return boolean 网络请求是否成功发送
function networkRequest.ReqNearPlayer()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqNearPlayerMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqNearPlayerMessage](LuaEnumNetDef.ReqNearPlayerMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqNearPlayerMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:101019 队伍请求邀请好友列表
---队伍请求邀请好友列表
---msgID: 101019
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGroupInvitationFriendList()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGroupInvitationFriendListMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGroupInvitationFriendListMessage](LuaEnumNetDef.ReqGroupInvitationFriendListMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGroupInvitationFriendListMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:101021 队伍请求邀请行会列表
---队伍请求邀请行会列表
---msgID: 101021
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGroupInvitationUnionList()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGroupInvitationUnionListMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGroupInvitationUnionListMessage](LuaEnumNetDef.ReqGroupInvitationUnionListMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGroupInvitationUnionListMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:101023 请求清空列表
---请求清空列表
---msgID: 101023
---@param state number 选填参数 清空列表，1清空组队申请列表，2清空组队邀请列表
---@return boolean 网络请求是否成功发送
function networkRequest.ReqClearList(state)
    local reqTable = {}
    if state ~= nil then
        reqTable.state = state
    end
    local reqMsgData = protobufMgr.Serialize("groupV2.ReqClearList" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqClearListMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqClearListMessage](LuaEnumNetDef.ReqClearListMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqClearListMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqClearListMessage", 101023, "ReqClearList", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:101026 玩家邀请列表请求
---玩家邀请列表请求
---msgID: 101026
---@return boolean 网络请求是否成功发送
function networkRequest.ReqInvitationList()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqInvitationListMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqInvitationListMessage](LuaEnumNetDef.ReqInvitationListMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqInvitationListMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:101027 解散队伍
---解散队伍
---msgID: 101027
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDissolveGroup()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDissolveGroupMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDissolveGroupMessage](LuaEnumNetDef.ReqDissolveGroupMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqDissolveGroupMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:101028 设置组队模式请求
---设置组队模式请求
---msgID: 101028
---@param teamMode number 必填参数 1自动 2手动 3拒绝
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSetTeamMode(teamMode)
    local reqTable = {}
    reqTable.teamMode = teamMode
    local reqMsgData = protobufMgr.Serialize("groupV2.SetTeamModeRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSetTeamModeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSetTeamModeMessage](LuaEnumNetDef.ReqSetTeamModeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSetTeamModeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSetTeamModeMessage", 101028, "SetTeamModeRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:101029 屏蔽
---屏蔽
---msgID: 101029
---@param targetId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShielding(targetId)
    local reqTable = {}
    reqTable.targetId = targetId
    local reqMsgData = protobufMgr.Serialize("groupV2.Shielding" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShieldingMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShieldingMessage](LuaEnumNetDef.ReqShieldingMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShieldingMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShieldingMessage", 101029, "Shielding", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:101031 召唤令确认
---召唤令确认
---msgID: 101031
---@param isAgreed boolean 必填参数
---@param sendRoleId number 必填参数
---@param type number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCheckCallBack(isAgreed, sendRoleId, type)
    local reqTable = {}
    reqTable.isAgreed = isAgreed
    reqTable.sendRoleId = sendRoleId
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("groupV2.CheckCallBack" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCheckCallBackMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCheckCallBackMessage](LuaEnumNetDef.ReqCheckCallBackMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqCheckCallBackMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqCheckCallBackMessage", 101031, "CheckCallBack", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:101032 请求玩家是否在线及其部分消息
---请求玩家是否在线及其部分消息
---msgID: 101032
---@param roleId number 必填参数 要查询的ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqHasPlayerSomeInfo(roleId)
    local reqTable = {}
    reqTable.roleId = roleId
    local reqMsgData = protobufMgr.Serialize("groupV2.ReqHasPlayerSomeInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqHasPlayerSomeInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqHasPlayerSomeInfoMessage](LuaEnumNetDef.ReqHasPlayerSomeInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqHasPlayerSomeInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqHasPlayerSomeInfoMessage", 101032, "ReqHasPlayerSomeInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:101034 队长二次批复邀请
---队长二次批复邀请
---msgID: 101034
---@param state number 选填参数 接受或拒绝组队邀请，1为接受，2为拒绝
---@param willMemberId number 选填参数 邀请的成员
---@param memberId number 选填参数 谁第一次邀请的
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCaptainAcceptInvit(state, willMemberId, memberId)
    local reqTable = {}
    if state ~= nil then
        reqTable.state = state
    end
    if willMemberId ~= nil then
        reqTable.willMemberId = willMemberId
    end
    if memberId ~= nil then
        reqTable.memberId = memberId
    end
    local reqMsgData = protobufMgr.Serialize("groupV2.ReqCaptainAcceptInvitation" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCaptainAcceptInvitMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCaptainAcceptInvitMessage](LuaEnumNetDef.ReqCaptainAcceptInvitMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqCaptainAcceptInvitMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqCaptainAcceptInvitMessage", 101034, "ReqCaptainAcceptInvitation", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

