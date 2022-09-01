--[[本文件为工具自动生成,禁止手动修改]]
local groupV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable groupV2.GroupInfo
---@type groupV2.GroupInfo
groupV2_adj.metatable_GroupInfo = {
    _ClassName = "groupV2.GroupInfo",
}
groupV2_adj.metatable_GroupInfo.__index = groupV2_adj.metatable_GroupInfo
--endregion

---@param tbl groupV2.GroupInfo 待调整的table数据
function groupV2_adj.AdjustGroupInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_GroupInfo)
    if tbl.leader == nil then
        tbl.leaderSpecified = false
        tbl.leader = nil
    else
        if tbl.leaderSpecified == nil then 
            tbl.leaderSpecified = true
            if groupV2_adj.AdjustPlayerInfo ~= nil then
                groupV2_adj.AdjustPlayerInfo(tbl.leader)
            end
        end
    end
    if tbl.status == nil then
        tbl.statusSpecified = false
        tbl.status = 0
    else
        tbl.statusSpecified = true
    end
    if tbl.manifesto == nil then
        tbl.manifestoSpecified = false
        tbl.manifesto = ""
    else
        tbl.manifestoSpecified = true
    end
    if tbl.captainAllowMode == nil then
        tbl.captainAllowModeSpecified = false
        tbl.captainAllowMode = 0
    else
        tbl.captainAllowModeSpecified = true
    end
end

--region metatable groupV2.PlayerInfo
---@type groupV2.PlayerInfo
groupV2_adj.metatable_PlayerInfo = {
    _ClassName = "groupV2.PlayerInfo",
}
groupV2_adj.metatable_PlayerInfo.__index = groupV2_adj.metatable_PlayerInfo
--endregion

---@param tbl groupV2.PlayerInfo 待调整的table数据
function groupV2_adj.AdjustPlayerInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_PlayerInfo)
    if tbl.roleName == nil then
        tbl.roleNameSpecified = false
        tbl.roleName = ""
    else
        tbl.roleNameSpecified = true
    end
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
    if tbl.isCaptain == nil then
        tbl.isCaptainSpecified = false
        tbl.isCaptain = false
    else
        tbl.isCaptainSpecified = true
    end
end

--region metatable groupV2.ResTeamAllMemHpInfo
---@type groupV2.ResTeamAllMemHpInfo
groupV2_adj.metatable_ResTeamAllMemHpInfo = {
    _ClassName = "groupV2.ResTeamAllMemHpInfo",
}
groupV2_adj.metatable_ResTeamAllMemHpInfo.__index = groupV2_adj.metatable_ResTeamAllMemHpInfo
--endregion

---@param tbl groupV2.ResTeamAllMemHpInfo 待调整的table数据
function groupV2_adj.AdjustResTeamAllMemHpInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_ResTeamAllMemHpInfo)
    if tbl.teamId == nil then
        tbl.teamIdSpecified = false
        tbl.teamId = 0
    else
        tbl.teamIdSpecified = true
    end
    if tbl.playerHps == nil then
        tbl.playerHps = {}
    else
        if groupV2_adj.AdjustTeamPlayerHpInfo ~= nil then
            for i = 1, #tbl.playerHps do
                groupV2_adj.AdjustTeamPlayerHpInfo(tbl.playerHps[i])
            end
        end
    end
end

--region metatable groupV2.TeamPlayerHpInfo
---@type groupV2.TeamPlayerHpInfo
groupV2_adj.metatable_TeamPlayerHpInfo = {
    _ClassName = "groupV2.TeamPlayerHpInfo",
}
groupV2_adj.metatable_TeamPlayerHpInfo.__index = groupV2_adj.metatable_TeamPlayerHpInfo
--endregion

---@param tbl groupV2.TeamPlayerHpInfo 待调整的table数据
function groupV2_adj.AdjustTeamPlayerHpInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_TeamPlayerHpInfo)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.teamId == nil then
        tbl.teamIdSpecified = false
        tbl.teamId = 0
    else
        tbl.teamIdSpecified = true
    end
    if tbl.hp == nil then
        tbl.hpSpecified = false
        tbl.hp = 0
    else
        tbl.hpSpecified = true
    end
    if tbl.maxHp == nil then
        tbl.maxHpSpecified = false
        tbl.maxHp = 0
    else
        tbl.maxHpSpecified = true
    end
end

--region metatable groupV2.InvitationPlayerInfo
---@type groupV2.InvitationPlayerInfo
groupV2_adj.metatable_InvitationPlayerInfo = {
    _ClassName = "groupV2.InvitationPlayerInfo",
}
groupV2_adj.metatable_InvitationPlayerInfo.__index = groupV2_adj.metatable_InvitationPlayerInfo
--endregion

---@param tbl groupV2.InvitationPlayerInfo 待调整的table数据
function groupV2_adj.AdjustInvitationPlayerInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_InvitationPlayerInfo)
    if tbl.groupId == nil then
        tbl.groupIdSpecified = false
        tbl.groupId = 0
    else
        tbl.groupIdSpecified = true
    end
    if tbl.playerName == nil then
        tbl.playerNameSpecified = false
        tbl.playerName = ""
    else
        tbl.playerNameSpecified = true
    end
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
    if tbl.acceptEndTime == nil then
        tbl.acceptEndTimeSpecified = false
        tbl.acceptEndTime = 0
    else
        tbl.acceptEndTimeSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
end

--region metatable groupV2.BasicPlayerInfo
---@type groupV2.BasicPlayerInfo
groupV2_adj.metatable_BasicPlayerInfo = {
    _ClassName = "groupV2.BasicPlayerInfo",
}
groupV2_adj.metatable_BasicPlayerInfo.__index = groupV2_adj.metatable_BasicPlayerInfo
--endregion

---@param tbl groupV2.BasicPlayerInfo 待调整的table数据
function groupV2_adj.AdjustBasicPlayerInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_BasicPlayerInfo)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.playerName == nil then
        tbl.playerNameSpecified = false
        tbl.playerName = ""
    else
        tbl.playerNameSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
    if tbl.groupId == nil then
        tbl.groupIdSpecified = false
        tbl.groupId = 0
    else
        tbl.groupIdSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
end

--region metatable groupV2.ReqChangeTarget
---@type groupV2.ReqChangeTarget
groupV2_adj.metatable_ReqChangeTarget = {
    _ClassName = "groupV2.ReqChangeTarget",
}
groupV2_adj.metatable_ReqChangeTarget.__index = groupV2_adj.metatable_ReqChangeTarget
--endregion

---@param tbl groupV2.ReqChangeTarget 待调整的table数据
function groupV2_adj.AdjustReqChangeTarget(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_ReqChangeTarget)
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
end

--region metatable groupV2.ReqChangeCaptain
---@type groupV2.ReqChangeCaptain
groupV2_adj.metatable_ReqChangeCaptain = {
    _ClassName = "groupV2.ReqChangeCaptain",
}
groupV2_adj.metatable_ReqChangeCaptain.__index = groupV2_adj.metatable_ReqChangeCaptain
--endregion

---@param tbl groupV2.ReqChangeCaptain 待调整的table数据
function groupV2_adj.AdjustReqChangeCaptain(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_ReqChangeCaptain)
    if tbl.captainId == nil then
        tbl.captainIdSpecified = false
        tbl.captainId = 0
    else
        tbl.captainIdSpecified = true
    end
end

--region metatable groupV2.ReqKickMember
---@type groupV2.ReqKickMember
groupV2_adj.metatable_ReqKickMember = {
    _ClassName = "groupV2.ReqKickMember",
}
groupV2_adj.metatable_ReqKickMember.__index = groupV2_adj.metatable_ReqKickMember
--endregion

---@param tbl groupV2.ReqKickMember 待调整的table数据
function groupV2_adj.AdjustReqKickMember(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_ReqKickMember)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
end

--region metatable groupV2.ReqExitGroup
---@type groupV2.ReqExitGroup
groupV2_adj.metatable_ReqExitGroup = {
    _ClassName = "groupV2.ReqExitGroup",
}
groupV2_adj.metatable_ReqExitGroup.__index = groupV2_adj.metatable_ReqExitGroup
--endregion

---@param tbl groupV2.ReqExitGroup 待调整的table数据
function groupV2_adj.AdjustReqExitGroup(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_ReqExitGroup)
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
end

--region metatable groupV2.AcceptTeam
---@type groupV2.AcceptTeam
groupV2_adj.metatable_AcceptTeam = {
    _ClassName = "groupV2.AcceptTeam",
}
groupV2_adj.metatable_AcceptTeam.__index = groupV2_adj.metatable_AcceptTeam
--endregion

---@param tbl groupV2.AcceptTeam 待调整的table数据
function groupV2_adj.AdjustAcceptTeam(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_AcceptTeam)
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
end

--region metatable groupV2.ResGroupDetailedInfo
---@type groupV2.ResGroupDetailedInfo
groupV2_adj.metatable_ResGroupDetailedInfo = {
    _ClassName = "groupV2.ResGroupDetailedInfo",
}
groupV2_adj.metatable_ResGroupDetailedInfo.__index = groupV2_adj.metatable_ResGroupDetailedInfo
--endregion

---@param tbl groupV2.ResGroupDetailedInfo 待调整的table数据
function groupV2_adj.AdjustResGroupDetailedInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_ResGroupDetailedInfo)
    if tbl.players == nil then
        tbl.players = {}
    else
        if groupV2_adj.AdjustPlayerInfo ~= nil then
            for i = 1, #tbl.players do
                groupV2_adj.AdjustPlayerInfo(tbl.players[i])
            end
        end
    end
    if tbl.groupInfo == nil then
        tbl.groupInfoSpecified = false
        tbl.groupInfo = nil
    else
        if tbl.groupInfoSpecified == nil then 
            tbl.groupInfoSpecified = true
            if groupV2_adj.AdjustGroupInfo ~= nil then
                groupV2_adj.AdjustGroupInfo(tbl.groupInfo)
            end
        end
    end
end

--region metatable groupV2.ReqJoinGroup
---@type groupV2.ReqJoinGroup
groupV2_adj.metatable_ReqJoinGroup = {
    _ClassName = "groupV2.ReqJoinGroup",
}
groupV2_adj.metatable_ReqJoinGroup.__index = groupV2_adj.metatable_ReqJoinGroup
--endregion

---@param tbl groupV2.ReqJoinGroup 待调整的table数据
function groupV2_adj.AdjustReqJoinGroup(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_ReqJoinGroup)
    if tbl.groupId == nil then
        tbl.groupIdSpecified = false
        tbl.groupId = 0
    else
        tbl.groupIdSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable groupV2.ApplyList
---@type groupV2.ApplyList
groupV2_adj.metatable_ApplyList = {
    _ClassName = "groupV2.ApplyList",
}
groupV2_adj.metatable_ApplyList.__index = groupV2_adj.metatable_ApplyList
--endregion

---@param tbl groupV2.ApplyList 待调整的table数据
function groupV2_adj.AdjustApplyList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_ApplyList)
    if tbl.players == nil then
        tbl.players = {}
    else
        if groupV2_adj.AdjustPlayerInfo ~= nil then
            for i = 1, #tbl.players do
                groupV2_adj.AdjustPlayerInfo(tbl.players[i])
            end
        end
    end
    if tbl.twoAgree == nil then
        tbl.twoAgree = {}
    else
        if groupV2_adj.AdjustCaptainTwoAgree ~= nil then
            for i = 1, #tbl.twoAgree do
                groupV2_adj.AdjustCaptainTwoAgree(tbl.twoAgree[i])
            end
        end
    end
end

--region metatable groupV2.CaptainTwoAgree
---@type groupV2.CaptainTwoAgree
groupV2_adj.metatable_CaptainTwoAgree = {
    _ClassName = "groupV2.CaptainTwoAgree",
}
groupV2_adj.metatable_CaptainTwoAgree.__index = groupV2_adj.metatable_CaptainTwoAgree
--endregion

---@param tbl groupV2.CaptainTwoAgree 待调整的table数据
function groupV2_adj.AdjustCaptainTwoAgree(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_CaptainTwoAgree)
    if tbl.memberId == nil then
        tbl.memberIdSpecified = false
        tbl.memberId = 0
    else
        tbl.memberIdSpecified = true
    end
    if tbl.nameMember == nil then
        tbl.nameMemberSpecified = false
        tbl.nameMember = ""
    else
        tbl.nameMemberSpecified = true
    end
    if tbl.careerMember == nil then
        tbl.careerMemberSpecified = false
        tbl.careerMember = 0
    else
        tbl.careerMemberSpecified = true
    end
    if tbl.sexMember == nil then
        tbl.sexMemberSpecified = false
        tbl.sexMember = 0
    else
        tbl.sexMemberSpecified = true
    end
    if tbl.levelMember == nil then
        tbl.levelMemberSpecified = false
        tbl.levelMember = 0
    else
        tbl.levelMemberSpecified = true
    end
    if tbl.unionNameMember == nil then
        tbl.unionNameMemberSpecified = false
        tbl.unionNameMember = ""
    else
        tbl.unionNameMemberSpecified = true
    end
    if tbl.willMemberId == nil then
        tbl.willMemberIdSpecified = false
        tbl.willMemberId = 0
    else
        tbl.willMemberIdSpecified = true
    end
    if tbl.nameWillMember == nil then
        tbl.nameWillMemberSpecified = false
        tbl.nameWillMember = ""
    else
        tbl.nameWillMemberSpecified = true
    end
    if tbl.willCareerMember == nil then
        tbl.willCareerMemberSpecified = false
        tbl.willCareerMember = 0
    else
        tbl.willCareerMemberSpecified = true
    end
    if tbl.willSexMember == nil then
        tbl.willSexMemberSpecified = false
        tbl.willSexMember = 0
    else
        tbl.willSexMemberSpecified = true
    end
    if tbl.WillLevelMember == nil then
        tbl.WillLevelMemberSpecified = false
        tbl.WillLevelMember = 0
    else
        tbl.WillLevelMemberSpecified = true
    end
    if tbl.WillUnionNameMember == nil then
        tbl.WillUnionNameMemberSpecified = false
        tbl.WillUnionNameMember = ""
    else
        tbl.WillUnionNameMemberSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
end

--region metatable groupV2.NearbyGroup
---@type groupV2.NearbyGroup
groupV2_adj.metatable_NearbyGroup = {
    _ClassName = "groupV2.NearbyGroup",
}
groupV2_adj.metatable_NearbyGroup.__index = groupV2_adj.metatable_NearbyGroup
--endregion

---@param tbl groupV2.NearbyGroup 待调整的table数据
function groupV2_adj.AdjustNearbyGroup(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_NearbyGroup)
    if tbl.groups == nil then
        tbl.groups = {}
    else
        if groupV2_adj.AdjustGroupInfo ~= nil then
            for i = 1, #tbl.groups do
                groupV2_adj.AdjustGroupInfo(tbl.groups[i])
            end
        end
    end
end

--region metatable groupV2.ReqInvitationPlayer
---@type groupV2.ReqInvitationPlayer
groupV2_adj.metatable_ReqInvitationPlayer = {
    _ClassName = "groupV2.ReqInvitationPlayer",
}
groupV2_adj.metatable_ReqInvitationPlayer.__index = groupV2_adj.metatable_ReqInvitationPlayer
--endregion

---@param tbl groupV2.ReqInvitationPlayer 待调整的table数据
function groupV2_adj.AdjustReqInvitationPlayer(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_ReqInvitationPlayer)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
end

--region metatable groupV2.ReqAcceptInvitation
---@type groupV2.ReqAcceptInvitation
groupV2_adj.metatable_ReqAcceptInvitation = {
    _ClassName = "groupV2.ReqAcceptInvitation",
}
groupV2_adj.metatable_ReqAcceptInvitation.__index = groupV2_adj.metatable_ReqAcceptInvitation
--endregion

---@param tbl groupV2.ReqAcceptInvitation 待调整的table数据
function groupV2_adj.AdjustReqAcceptInvitation(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_ReqAcceptInvitation)
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.groupId == nil then
        tbl.groupIdSpecified = false
        tbl.groupId = 0
    else
        tbl.groupIdSpecified = true
    end
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
end

--region metatable groupV2.ReqCaptainAcceptInvitation
---@type groupV2.ReqCaptainAcceptInvitation
groupV2_adj.metatable_ReqCaptainAcceptInvitation = {
    _ClassName = "groupV2.ReqCaptainAcceptInvitation",
}
groupV2_adj.metatable_ReqCaptainAcceptInvitation.__index = groupV2_adj.metatable_ReqCaptainAcceptInvitation
--endregion

---@param tbl groupV2.ReqCaptainAcceptInvitation 待调整的table数据
function groupV2_adj.AdjustReqCaptainAcceptInvitation(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_ReqCaptainAcceptInvitation)
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.willMemberId == nil then
        tbl.willMemberIdSpecified = false
        tbl.willMemberId = 0
    else
        tbl.willMemberIdSpecified = true
    end
    if tbl.memberId == nil then
        tbl.memberIdSpecified = false
        tbl.memberId = 0
    else
        tbl.memberIdSpecified = true
    end
end

--region metatable groupV2.ResInvitationList
---@type groupV2.ResInvitationList
groupV2_adj.metatable_ResInvitationList = {
    _ClassName = "groupV2.ResInvitationList",
}
groupV2_adj.metatable_ResInvitationList.__index = groupV2_adj.metatable_ResInvitationList
--endregion

---@param tbl groupV2.ResInvitationList 待调整的table数据
function groupV2_adj.AdjustResInvitationList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_ResInvitationList)
    if tbl.players == nil then
        tbl.players = {}
    else
        if groupV2_adj.AdjustInvitationPlayerInfo ~= nil then
            for i = 1, #tbl.players do
                groupV2_adj.AdjustInvitationPlayerInfo(tbl.players[i])
            end
        end
    end
end

--region metatable groupV2.ResGroupInvitationNearbyList
---@type groupV2.ResGroupInvitationNearbyList
groupV2_adj.metatable_ResGroupInvitationNearbyList = {
    _ClassName = "groupV2.ResGroupInvitationNearbyList",
}
groupV2_adj.metatable_ResGroupInvitationNearbyList.__index = groupV2_adj.metatable_ResGroupInvitationNearbyList
--endregion

---@param tbl groupV2.ResGroupInvitationNearbyList 待调整的table数据
function groupV2_adj.AdjustResGroupInvitationNearbyList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_ResGroupInvitationNearbyList)
    if tbl.players == nil then
        tbl.players = {}
    else
        if groupV2_adj.AdjustBasicPlayerInfo ~= nil then
            for i = 1, #tbl.players do
                groupV2_adj.AdjustBasicPlayerInfo(tbl.players[i])
            end
        end
    end
end

--region metatable groupV2.ResGroupInvitationFriendList
---@type groupV2.ResGroupInvitationFriendList
groupV2_adj.metatable_ResGroupInvitationFriendList = {
    _ClassName = "groupV2.ResGroupInvitationFriendList",
}
groupV2_adj.metatable_ResGroupInvitationFriendList.__index = groupV2_adj.metatable_ResGroupInvitationFriendList
--endregion

---@param tbl groupV2.ResGroupInvitationFriendList 待调整的table数据
function groupV2_adj.AdjustResGroupInvitationFriendList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_ResGroupInvitationFriendList)
    if tbl.players == nil then
        tbl.players = {}
    else
        if groupV2_adj.AdjustBasicPlayerInfo ~= nil then
            for i = 1, #tbl.players do
                groupV2_adj.AdjustBasicPlayerInfo(tbl.players[i])
            end
        end
    end
end

--region metatable groupV2.ResGroupInvitationUnionList
---@type groupV2.ResGroupInvitationUnionList
groupV2_adj.metatable_ResGroupInvitationUnionList = {
    _ClassName = "groupV2.ResGroupInvitationUnionList",
}
groupV2_adj.metatable_ResGroupInvitationUnionList.__index = groupV2_adj.metatable_ResGroupInvitationUnionList
--endregion

---@param tbl groupV2.ResGroupInvitationUnionList 待调整的table数据
function groupV2_adj.AdjustResGroupInvitationUnionList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_ResGroupInvitationUnionList)
    if tbl.players == nil then
        tbl.players = {}
    else
        if groupV2_adj.AdjustBasicPlayerInfo ~= nil then
            for i = 1, #tbl.players do
                groupV2_adj.AdjustBasicPlayerInfo(tbl.players[i])
            end
        end
    end
end

--region metatable groupV2.ReqClearList
---@type groupV2.ReqClearList
groupV2_adj.metatable_ReqClearList = {
    _ClassName = "groupV2.ReqClearList",
}
groupV2_adj.metatable_ReqClearList.__index = groupV2_adj.metatable_ReqClearList
--endregion

---@param tbl groupV2.ReqClearList 待调整的table数据
function groupV2_adj.AdjustReqClearList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_ReqClearList)
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable groupV2.MsgPrompt
---@type groupV2.MsgPrompt
groupV2_adj.metatable_MsgPrompt = {
    _ClassName = "groupV2.MsgPrompt",
}
groupV2_adj.metatable_MsgPrompt.__index = groupV2_adj.metatable_MsgPrompt
--endregion

---@param tbl groupV2.MsgPrompt 待调整的table数据
function groupV2_adj.AdjustMsgPrompt(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_MsgPrompt)
    if tbl.willMember == nil then
        tbl.willMemberSpecified = false
        tbl.willMember = ""
    else
        tbl.willMemberSpecified = true
    end
    if tbl.member == nil then
        tbl.memberSpecified = false
        tbl.member = ""
    else
        tbl.memberSpecified = true
    end
    if tbl.willMemberId == nil then
        tbl.willMemberIdSpecified = false
        tbl.willMemberId = 0
    else
        tbl.willMemberIdSpecified = true
    end
    if tbl.memberId == nil then
        tbl.memberIdSpecified = false
        tbl.memberId = 0
    else
        tbl.memberIdSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
end

--region metatable groupV2.SetTeamModeRequest
---@type groupV2.SetTeamModeRequest
groupV2_adj.metatable_SetTeamModeRequest = {
    _ClassName = "groupV2.SetTeamModeRequest",
}
groupV2_adj.metatable_SetTeamModeRequest.__index = groupV2_adj.metatable_SetTeamModeRequest
--endregion

---@param tbl groupV2.SetTeamModeRequest 待调整的table数据
function groupV2_adj.AdjustSetTeamModeRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_SetTeamModeRequest)
end

--region metatable groupV2.Shielding
---@type groupV2.Shielding
groupV2_adj.metatable_Shielding = {
    _ClassName = "groupV2.Shielding",
}
groupV2_adj.metatable_Shielding.__index = groupV2_adj.metatable_Shielding
--endregion

---@param tbl groupV2.Shielding 待调整的table数据
function groupV2_adj.AdjustShielding(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_Shielding)
end

--region metatable groupV2.TeamCallBack
---@type groupV2.TeamCallBack
groupV2_adj.metatable_TeamCallBack = {
    _ClassName = "groupV2.TeamCallBack",
}
groupV2_adj.metatable_TeamCallBack.__index = groupV2_adj.metatable_TeamCallBack
--endregion

---@param tbl groupV2.TeamCallBack 待调整的table数据
function groupV2_adj.AdjustTeamCallBack(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_TeamCallBack)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.line == nil then
        tbl.lineSpecified = false
        tbl.line = 0
    else
        tbl.lineSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
    if tbl.startTime == nil then
        tbl.startTimeSpecified = false
        tbl.startTime = 0
    else
        tbl.startTimeSpecified = true
    end
    if tbl.monsterId == nil then
        tbl.monsterIdSpecified = false
        tbl.monsterId = 0
    else
        tbl.monsterIdSpecified = true
    end
    if tbl.paramStrs == nil then
        tbl.paramStrs = {}
    end
    if tbl.isinfire == nil then
        tbl.isinfireSpecified = false
        tbl.isinfire = 0
    else
        tbl.isinfireSpecified = true
    end
    if tbl.firetype == nil then
        tbl.firetypeSpecified = false
        tbl.firetype = 0
    else
        tbl.firetypeSpecified = true
    end
end

--region metatable groupV2.ResCallBack
---@type groupV2.ResCallBack
groupV2_adj.metatable_ResCallBack = {
    _ClassName = "groupV2.ResCallBack",
}
groupV2_adj.metatable_ResCallBack.__index = groupV2_adj.metatable_ResCallBack
--endregion

---@param tbl groupV2.ResCallBack 待调整的table数据
function groupV2_adj.AdjustResCallBack(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_ResCallBack)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.isSuccess == nil then
        tbl.isSuccessSpecified = false
        tbl.isSuccess = false
    else
        tbl.isSuccessSpecified = true
    end
end

--region metatable groupV2.CheckCallBack
---@type groupV2.CheckCallBack
groupV2_adj.metatable_CheckCallBack = {
    _ClassName = "groupV2.CheckCallBack",
}
groupV2_adj.metatable_CheckCallBack.__index = groupV2_adj.metatable_CheckCallBack
--endregion

---@param tbl groupV2.CheckCallBack 待调整的table数据
function groupV2_adj.AdjustCheckCallBack(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_CheckCallBack)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable groupV2.ReqHasPlayerSomeInfo
---@type groupV2.ReqHasPlayerSomeInfo
groupV2_adj.metatable_ReqHasPlayerSomeInfo = {
    _ClassName = "groupV2.ReqHasPlayerSomeInfo",
}
groupV2_adj.metatable_ReqHasPlayerSomeInfo.__index = groupV2_adj.metatable_ReqHasPlayerSomeInfo
--endregion

---@param tbl groupV2.ReqHasPlayerSomeInfo 待调整的table数据
function groupV2_adj.AdjustReqHasPlayerSomeInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_ReqHasPlayerSomeInfo)
end

--region metatable groupV2.ResHasPlayerSomeInfo
---@type groupV2.ResHasPlayerSomeInfo
groupV2_adj.metatable_ResHasPlayerSomeInfo = {
    _ClassName = "groupV2.ResHasPlayerSomeInfo",
}
groupV2_adj.metatable_ResHasPlayerSomeInfo.__index = groupV2_adj.metatable_ResHasPlayerSomeInfo
--endregion

---@param tbl groupV2.ResHasPlayerSomeInfo 待调整的table数据
function groupV2_adj.AdjustResHasPlayerSomeInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, groupV2_adj.metatable_ResHasPlayerSomeInfo)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.isOnline == nil then
        tbl.isOnlineSpecified = false
        tbl.isOnline = false
    else
        tbl.isOnlineSpecified = true
    end
    if tbl.teamId == nil then
        tbl.teamIdSpecified = false
        tbl.teamId = 0
    else
        tbl.teamIdSpecified = true
    end
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.unionPosition == nil then
        tbl.unionPositionSpecified = false
        tbl.unionPosition = 0
    else
        tbl.unionPositionSpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.hostId == nil then
        tbl.hostIdSpecified = false
        tbl.hostId = 0
    else
        tbl.hostIdSpecified = true
    end
end

return groupV2_adj