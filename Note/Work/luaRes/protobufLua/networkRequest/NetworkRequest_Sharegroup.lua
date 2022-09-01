--[[本文件为工具自动生成,禁止手动修改]]
--sharegroup.xml

--region ID:1001001 请求组队面板信息
---请求组队面板信息
---msgID: 1001001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareGroupDetailedInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareGroupDetailedInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareGroupDetailedInfoMessage](LuaEnumNetDef.ReqShareGroupDetailedInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqShareGroupDetailedInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:1001002 请求改变队伍目标
---请求改变队伍目标
---msgID: 1001002
---@param targetId number 选填参数 目标id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareChangeTarget(targetId)
    local reqTable = {}
    if targetId ~= nil then
        reqTable.targetId = targetId
    end
    local reqMsgData = protobufMgr.Serialize("shareGroupV2.ReqChangeTarget" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareChangeTargetMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareChangeTargetMessage](LuaEnumNetDef.ReqShareChangeTargetMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareChangeTargetMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareChangeTargetMessage", 1001002, "ReqChangeTarget", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1001003 请求转移队伍队长
---请求转移队伍队长
---msgID: 1001003
---@param captainId number 选填参数 新的队长rid
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareChangeCaptain(captainId)
    local reqTable = {}
    if captainId ~= nil then
        reqTable.captainId = captainId
    end
    local reqMsgData = protobufMgr.Serialize("shareGroupV2.ReqChangeCaptain" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareChangeCaptainMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareChangeCaptainMessage](LuaEnumNetDef.ReqShareChangeCaptainMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareChangeCaptainMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareChangeCaptainMessage", 1001003, "ReqChangeCaptain", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1001004 请求创建队伍
---请求创建队伍
---msgID: 1001004
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareCreatGroup()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareCreatGroupMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareCreatGroupMessage](LuaEnumNetDef.ReqShareCreatGroupMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqShareCreatGroupMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:1001005 请求队伍踢出玩家
---请求队伍踢出玩家
---msgID: 1001005
---@param rid number 选填参数 被踢出玩家id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareKickMember(rid)
    local reqTable = {}
    if rid ~= nil then
        reqTable.rid = rid
    end
    local reqMsgData = protobufMgr.Serialize("shareGroupV2.ReqKickMember" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareKickMemberMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareKickMemberMessage](LuaEnumNetDef.ReqShareKickMemberMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareKickMemberMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareKickMemberMessage", 1001005, "ReqKickMember", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1001006 玩家请求离开队伍
---玩家请求离开队伍
---msgID: 1001006
---@param targetId number 选填参数 退出队伍的玩家id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareExitGroup(targetId)
    local reqTable = {}
    if targetId ~= nil then
        reqTable.targetId = targetId
    end
    local reqMsgData = protobufMgr.Serialize("shareGroupV2.ReqExitGroup" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareExitGroupMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareExitGroupMessage](LuaEnumNetDef.ReqShareExitGroupMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareExitGroupMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareExitGroupMessage", 1001006, "ReqExitGroup", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1001007 接受组队申请
---接受组队申请
---msgID: 1001007
---@param state number 选填参数 接受或拒绝组队申请，1为接受，2为拒绝
---@param rid number 选填参数 接受申请玩家id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareAcceptApply(state, rid)
    local reqTable = {}
    if state ~= nil then
        reqTable.state = state
    end
    if rid ~= nil then
        reqTable.rid = rid
    end
    local reqMsgData = protobufMgr.Serialize("shareGroupV2.AcceptTeam" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareAcceptApplyMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareAcceptApplyMessage](LuaEnumNetDef.ReqShareAcceptApplyMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareAcceptApplyMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareAcceptApplyMessage", 1001007, "AcceptTeam", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1001009 请求打开组队请求界面
---请求打开组队请求界面
---msgID: 1001009
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareApplyList()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareApplyListMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareApplyListMessage](LuaEnumNetDef.ReqShareApplyListMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqShareApplyListMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:1001010 请求加入队伍
---请求加入队伍
---msgID: 1001010
---@param groupId number 选填参数 队伍id
---@param type number 选填参数 1：自动组队 2：手动 3：拒绝
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareJoinGroup(groupId, type)
    local reqTable = {}
    if groupId ~= nil then
        reqTable.groupId = groupId
    end
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("shareGroupV2.ReqJoinGroup" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareJoinGroupMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareJoinGroupMessage](LuaEnumNetDef.ReqShareJoinGroupMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareJoinGroupMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareJoinGroupMessage", 1001010, "ReqJoinGroup", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1001012 玩家请求附近可以申请队伍列表
---玩家请求附近可以申请队伍列表
---msgID: 1001012
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareNearbyGroup()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareNearbyGroupMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareNearbyGroupMessage](LuaEnumNetDef.ReqShareNearbyGroupMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqShareNearbyGroupMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:1001014 请求邀请玩家
---请求邀请玩家
---msgID: 1001014
---@param rid number 选填参数 被邀请玩家id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareInvitationPlayer(rid)
    local reqTable = {}
    if rid ~= nil then
        reqTable.rid = rid
    end
    local reqMsgData = protobufMgr.Serialize("shareGroupV2.ReqInvitationPlayer" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareInvitationPlayerMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareInvitationPlayerMessage](LuaEnumNetDef.ReqShareInvitationPlayerMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareInvitationPlayerMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareInvitationPlayerMessage", 1001014, "ReqInvitationPlayer", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1001015 玩家接受邀请
---玩家接受邀请
---msgID: 1001015
---@param state number 选填参数 接受或拒绝组队邀请，1为接受，2为拒绝
---@param groupId number 选填参数 接受队伍id
---@param targetId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareAcceptInvitation(state, groupId, targetId)
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
    local reqMsgData = protobufMgr.Serialize("shareGroupV2.ReqAcceptInvitation" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareAcceptInvitationMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareAcceptInvitationMessage](LuaEnumNetDef.ReqShareAcceptInvitationMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareAcceptInvitationMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareAcceptInvitationMessage", 1001015, "ReqAcceptInvitation", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1001017 队伍请求邀请附近的人列表
---队伍请求邀请附近的人列表
---msgID: 1001017
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareNearPlayer()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareNearPlayerMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareNearPlayerMessage](LuaEnumNetDef.ReqShareNearPlayerMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqShareNearPlayerMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:1001019 队伍请求邀请好友列表
---队伍请求邀请好友列表
---msgID: 1001019
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareGroupInvitationFriendList()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareGroupInvitationFriendListMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareGroupInvitationFriendListMessage](LuaEnumNetDef.ReqShareGroupInvitationFriendListMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqShareGroupInvitationFriendListMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:1001021 队伍请求邀请行会列表
---队伍请求邀请行会列表
---msgID: 1001021
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareGroupInvitationUnionList()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareGroupInvitationUnionListMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareGroupInvitationUnionListMessage](LuaEnumNetDef.ReqShareGroupInvitationUnionListMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqShareGroupInvitationUnionListMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:1001023 请求清空列表
---请求清空列表
---msgID: 1001023
---@param state number 选填参数 清空列表，1清空组队申请列表，2清空组队邀请列表
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareClearList(state)
    local reqTable = {}
    if state ~= nil then
        reqTable.state = state
    end
    local reqMsgData = protobufMgr.Serialize("shareGroupV2.ReqClearList" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareClearListMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareClearListMessage](LuaEnumNetDef.ReqShareClearListMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareClearListMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareClearListMessage", 1001023, "ReqClearList", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1001026 玩家邀请列表请求
---玩家邀请列表请求
---msgID: 1001026
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareInvitationList()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareInvitationListMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareInvitationListMessage](LuaEnumNetDef.ReqShareInvitationListMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqShareInvitationListMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:1001027 解散队伍
---解散队伍
---msgID: 1001027
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareDissolveGroup()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareDissolveGroupMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareDissolveGroupMessage](LuaEnumNetDef.ReqShareDissolveGroupMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqShareDissolveGroupMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:1001028 设置组队模式请求
---设置组队模式请求
---msgID: 1001028
---@param teamMode number 必填参数 1自动 2手动 3拒绝
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareSetTeamMode(teamMode)
    local reqTable = {}
    reqTable.teamMode = teamMode
    local reqMsgData = protobufMgr.Serialize("shareGroupV2.SetTeamModeRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareSetTeamModeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareSetTeamModeMessage](LuaEnumNetDef.ReqShareSetTeamModeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareSetTeamModeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareSetTeamModeMessage", 1001028, "SetTeamModeRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1001029 屏蔽
---屏蔽
---msgID: 1001029
---@param targetId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareShielding(targetId)
    local reqTable = {}
    reqTable.targetId = targetId
    local reqMsgData = protobufMgr.Serialize("shareGroupV2.Shielding" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareShieldingMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareShieldingMessage](LuaEnumNetDef.ReqShareShieldingMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareShieldingMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareShieldingMessage", 1001029, "Shielding", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1001031 召唤令确认
---召唤令确认
---msgID: 1001031
---@param isAgreed boolean 必填参数
---@param sendRoleId number 必填参数
---@param type number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareCheckCallBack(isAgreed, sendRoleId, type)
    local reqTable = {}
    reqTable.isAgreed = isAgreed
    reqTable.sendRoleId = sendRoleId
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("shareGroupV2.CheckCallBack" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareCheckCallBackMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareCheckCallBackMessage](LuaEnumNetDef.ReqShareCheckCallBackMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareCheckCallBackMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareCheckCallBackMessage", 1001031, "CheckCallBack", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1001032 请求玩家是否在线及其部分消息
---请求玩家是否在线及其部分消息
---msgID: 1001032
---@param roleId number 必填参数 要查询的ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareHasPlayerSomeInfo(roleId)
    local reqTable = {}
    reqTable.roleId = roleId
    local reqMsgData = protobufMgr.Serialize("shareGroupV2.ReqHasPlayerSomeInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareHasPlayerSomeInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareHasPlayerSomeInfoMessage](LuaEnumNetDef.ReqShareHasPlayerSomeInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareHasPlayerSomeInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareHasPlayerSomeInfoMessage", 1001032, "ReqHasPlayerSomeInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1001034 队长二次批复邀请
---队长二次批复邀请
---msgID: 1001034
---@param state number 选填参数 接受或拒绝组队邀请，1为接受，2为拒绝
---@param willMemberId number 选填参数 邀请的成员
---@param memberId number 选填参数 谁第一次邀请的
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareCaptainAcceptInvit(state, willMemberId, memberId)
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
    local reqMsgData = protobufMgr.Serialize("shareGroupV2.ReqCaptainAcceptInvitation" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareCaptainAcceptInvitMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareCaptainAcceptInvitMessage](LuaEnumNetDef.ReqShareCaptainAcceptInvitMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareCaptainAcceptInvitMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareCaptainAcceptInvitMessage", 1001034, "ReqCaptainAcceptInvitation", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

