--[[本文件为工具自动生成,禁止手动修改]]
local groupV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData groupV2.GroupInfo lua中的数据结构
---@return groupV2.GroupInfo C#中的数据结构
function groupV2.GroupInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.GroupInfo()
    data.id = decodedData.id
    if decodedData.leader ~= nil and decodedData.leaderSpecified ~= false then
        data.leader = groupV2.PlayerInfo(decodedData.leader)
    end
    data.size = decodedData.size
    if decodedData.status ~= nil and decodedData.statusSpecified ~= false then
        data.status = decodedData.status
    end
    if decodedData.manifesto ~= nil and decodedData.manifestoSpecified ~= false then
        data.manifesto = decodedData.manifesto
    end
    if decodedData.captainAllowMode ~= nil and decodedData.captainAllowModeSpecified ~= false then
        data.captainAllowMode = decodedData.captainAllowMode
    end
    return data
end

---@param decodedData groupV2.PlayerInfo lua中的数据结构
---@return groupV2.PlayerInfo C#中的数据结构
function groupV2.PlayerInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.PlayerInfo()
    if decodedData.roleName ~= nil and decodedData.roleNameSpecified ~= false then
        data.roleName = decodedData.roleName
    end
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.isCaptain ~= nil and decodedData.isCaptainSpecified ~= false then
        data.isCaptain = decodedData.isCaptain
    end
    return data
end

---@param decodedData groupV2.ResTeamAllMemHpInfo lua中的数据结构
---@return groupV2.ResTeamAllMemHpInfo C#中的数据结构
function groupV2.ResTeamAllMemHpInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.ResTeamAllMemHpInfo()
    if decodedData.teamId ~= nil and decodedData.teamIdSpecified ~= false then
        data.teamId = decodedData.teamId
    end
    if decodedData.playerHps ~= nil and decodedData.playerHpsSpecified ~= false then
        for i = 1, #decodedData.playerHps do
            data.playerHps:Add(groupV2.TeamPlayerHpInfo(decodedData.playerHps[i]))
        end
    end
    return data
end

---@param decodedData groupV2.TeamPlayerHpInfo lua中的数据结构
---@return groupV2.TeamPlayerHpInfo C#中的数据结构
function groupV2.TeamPlayerHpInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.TeamPlayerHpInfo()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.teamId ~= nil and decodedData.teamIdSpecified ~= false then
        data.teamId = decodedData.teamId
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.maxHp ~= nil and decodedData.maxHpSpecified ~= false then
        data.maxHp = decodedData.maxHp
    end
    return data
end

---@param decodedData groupV2.InvitationPlayerInfo lua中的数据结构
---@return groupV2.InvitationPlayerInfo C#中的数据结构
function groupV2.InvitationPlayerInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.InvitationPlayerInfo()
    if decodedData.groupId ~= nil and decodedData.groupIdSpecified ~= false then
        data.groupId = decodedData.groupId
    end
    if decodedData.playerName ~= nil and decodedData.playerNameSpecified ~= false then
        data.playerName = decodedData.playerName
    end
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    if decodedData.acceptEndTime ~= nil and decodedData.acceptEndTimeSpecified ~= false then
        data.acceptEndTime = decodedData.acceptEndTime
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    return data
end

---@param decodedData groupV2.BasicPlayerInfo lua中的数据结构
---@return groupV2.BasicPlayerInfo C#中的数据结构
function groupV2.BasicPlayerInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.BasicPlayerInfo()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.playerName ~= nil and decodedData.playerNameSpecified ~= false then
        data.playerName = decodedData.playerName
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.groupId ~= nil and decodedData.groupIdSpecified ~= false then
        data.groupId = decodedData.groupId
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    return data
end

---@param decodedData groupV2.ReqChangeTarget lua中的数据结构
---@return groupV2.ReqChangeTarget C#中的数据结构
function groupV2.ReqChangeTarget(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.ReqChangeTarget()
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    return data
end

---@param decodedData groupV2.ReqChangeCaptain lua中的数据结构
---@return groupV2.ReqChangeCaptain C#中的数据结构
function groupV2.ReqChangeCaptain(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.ReqChangeCaptain()
    if decodedData.captainId ~= nil and decodedData.captainIdSpecified ~= false then
        data.captainId = decodedData.captainId
    end
    return data
end

---@param decodedData groupV2.ReqKickMember lua中的数据结构
---@return groupV2.ReqKickMember C#中的数据结构
function groupV2.ReqKickMember(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.ReqKickMember()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    return data
end

---@param decodedData groupV2.ReqExitGroup lua中的数据结构
---@return groupV2.ReqExitGroup C#中的数据结构
function groupV2.ReqExitGroup(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.ReqExitGroup()
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    return data
end

---@param decodedData groupV2.AcceptTeam lua中的数据结构
---@return groupV2.AcceptTeam C#中的数据结构
function groupV2.AcceptTeam(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.AcceptTeam()
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    return data
end

---@param decodedData groupV2.ResGroupDetailedInfo lua中的数据结构
---@return groupV2.ResGroupDetailedInfo C#中的数据结构
function groupV2.ResGroupDetailedInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.ResGroupDetailedInfo()
    if decodedData.players ~= nil and decodedData.playersSpecified ~= false then
        for i = 1, #decodedData.players do
            data.players:Add(groupV2.PlayerInfo(decodedData.players[i]))
        end
    end
    if decodedData.groupInfo ~= nil and decodedData.groupInfoSpecified ~= false then
        data.groupInfo = groupV2.GroupInfo(decodedData.groupInfo)
    end
    return data
end

---@param decodedData groupV2.ReqJoinGroup lua中的数据结构
---@return groupV2.ReqJoinGroup C#中的数据结构
function groupV2.ReqJoinGroup(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.ReqJoinGroup()
    if decodedData.groupId ~= nil and decodedData.groupIdSpecified ~= false then
        data.groupId = decodedData.groupId
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData groupV2.ApplyList lua中的数据结构
---@return groupV2.ApplyList C#中的数据结构
function groupV2.ApplyList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.ApplyList()
    if decodedData.players ~= nil and decodedData.playersSpecified ~= false then
        for i = 1, #decodedData.players do
            data.players:Add(groupV2.PlayerInfo(decodedData.players[i]))
        end
    end
    if decodedData.twoAgree ~= nil and decodedData.twoAgreeSpecified ~= false then
        for i = 1, #decodedData.twoAgree do
            data.twoAgree:Add(groupV2.CaptainTwoAgree(decodedData.twoAgree[i]))
        end
    end
    return data
end

---@param decodedData groupV2.CaptainTwoAgree lua中的数据结构
---@return groupV2.CaptainTwoAgree C#中的数据结构
function groupV2.CaptainTwoAgree(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.CaptainTwoAgree()
    if decodedData.memberId ~= nil and decodedData.memberIdSpecified ~= false then
        data.memberId = decodedData.memberId
    end
    if decodedData.nameMember ~= nil and decodedData.nameMemberSpecified ~= false then
        data.nameMember = decodedData.nameMember
    end
    if decodedData.careerMember ~= nil and decodedData.careerMemberSpecified ~= false then
        data.careerMember = decodedData.careerMember
    end
    if decodedData.sexMember ~= nil and decodedData.sexMemberSpecified ~= false then
        data.sexMember = decodedData.sexMember
    end
    if decodedData.levelMember ~= nil and decodedData.levelMemberSpecified ~= false then
        data.levelMember = decodedData.levelMember
    end
    if decodedData.unionNameMember ~= nil and decodedData.unionNameMemberSpecified ~= false then
        data.unionNameMember = decodedData.unionNameMember
    end
    if decodedData.willMemberId ~= nil and decodedData.willMemberIdSpecified ~= false then
        data.willMemberId = decodedData.willMemberId
    end
    if decodedData.nameWillMember ~= nil and decodedData.nameWillMemberSpecified ~= false then
        data.nameWillMember = decodedData.nameWillMember
    end
    if decodedData.willCareerMember ~= nil and decodedData.willCareerMemberSpecified ~= false then
        data.willCareerMember = decodedData.willCareerMember
    end
    if decodedData.willSexMember ~= nil and decodedData.willSexMemberSpecified ~= false then
        data.willSexMember = decodedData.willSexMember
    end
    if decodedData.WillLevelMember ~= nil and decodedData.WillLevelMemberSpecified ~= false then
        data.WillLevelMember = decodedData.WillLevelMember
    end
    if decodedData.WillUnionNameMember ~= nil and decodedData.WillUnionNameMemberSpecified ~= false then
        data.WillUnionNameMember = decodedData.WillUnionNameMember
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    return data
end

---@param decodedData groupV2.NearbyGroup lua中的数据结构
---@return groupV2.NearbyGroup C#中的数据结构
function groupV2.NearbyGroup(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.NearbyGroup()
    if decodedData.groups ~= nil and decodedData.groupsSpecified ~= false then
        for i = 1, #decodedData.groups do
            data.groups:Add(groupV2.GroupInfo(decodedData.groups[i]))
        end
    end
    return data
end

---@param decodedData groupV2.ReqInvitationPlayer lua中的数据结构
---@return groupV2.ReqInvitationPlayer C#中的数据结构
function groupV2.ReqInvitationPlayer(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.ReqInvitationPlayer()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    return data
end

---@param decodedData groupV2.ReqAcceptInvitation lua中的数据结构
---@return groupV2.ReqAcceptInvitation C#中的数据结构
function groupV2.ReqAcceptInvitation(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.ReqAcceptInvitation()
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.groupId ~= nil and decodedData.groupIdSpecified ~= false then
        data.groupId = decodedData.groupId
    end
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    return data
end

---@param decodedData groupV2.ReqCaptainAcceptInvitation lua中的数据结构
---@return groupV2.ReqCaptainAcceptInvitation C#中的数据结构
function groupV2.ReqCaptainAcceptInvitation(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.ReqCaptainAcceptInvitation()
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.willMemberId ~= nil and decodedData.willMemberIdSpecified ~= false then
        data.willMemberId = decodedData.willMemberId
    end
    if decodedData.memberId ~= nil and decodedData.memberIdSpecified ~= false then
        data.memberId = decodedData.memberId
    end
    return data
end

---@param decodedData groupV2.ResInvitationList lua中的数据结构
---@return groupV2.ResInvitationList C#中的数据结构
function groupV2.ResInvitationList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.ResInvitationList()
    if decodedData.players ~= nil and decodedData.playersSpecified ~= false then
        for i = 1, #decodedData.players do
            data.players:Add(groupV2.InvitationPlayerInfo(decodedData.players[i]))
        end
    end
    return data
end

---@param decodedData groupV2.ResGroupInvitationNearbyList lua中的数据结构
---@return groupV2.ResGroupInvitationNearbyList C#中的数据结构
function groupV2.ResGroupInvitationNearbyList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.ResGroupInvitationNearbyList()
    if decodedData.players ~= nil and decodedData.playersSpecified ~= false then
        for i = 1, #decodedData.players do
            data.players:Add(groupV2.BasicPlayerInfo(decodedData.players[i]))
        end
    end
    return data
end

--[[groupV2.ResGroupInvitationFriendList 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData groupV2.ResGroupInvitationUnionList lua中的数据结构
---@return groupV2.ResGroupInvitationUnionList C#中的数据结构
function groupV2.ResGroupInvitationUnionList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.ResGroupInvitationUnionList()
    if decodedData.players ~= nil and decodedData.playersSpecified ~= false then
        for i = 1, #decodedData.players do
            data.players:Add(groupV2.BasicPlayerInfo(decodedData.players[i]))
        end
    end
    return data
end

---@param decodedData groupV2.ReqClearList lua中的数据结构
---@return groupV2.ReqClearList C#中的数据结构
function groupV2.ReqClearList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.ReqClearList()
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData groupV2.MsgPrompt lua中的数据结构
---@return groupV2.MsgPrompt C#中的数据结构
function groupV2.MsgPrompt(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.MsgPrompt()
    data.type = decodedData.type
    if decodedData.willMember ~= nil and decodedData.willMemberSpecified ~= false then
        data.willMember = decodedData.willMember
    end
    if decodedData.member ~= nil and decodedData.memberSpecified ~= false then
        data.member = decodedData.member
    end
    if decodedData.willMemberId ~= nil and decodedData.willMemberIdSpecified ~= false then
        data.willMemberId = decodedData.willMemberId
    end
    if decodedData.memberId ~= nil and decodedData.memberIdSpecified ~= false then
        data.memberId = decodedData.memberId
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    return data
end

---@param decodedData groupV2.SetTeamModeRequest lua中的数据结构
---@return groupV2.SetTeamModeRequest C#中的数据结构
function groupV2.SetTeamModeRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.SetTeamModeRequest()
    data.teamMode = decodedData.teamMode
    return data
end

---@param decodedData groupV2.Shielding lua中的数据结构
---@return groupV2.Shielding C#中的数据结构
function groupV2.Shielding(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.Shielding()
    data.targetId = decodedData.targetId
    return data
end

---@param decodedData groupV2.TeamCallBack lua中的数据结构
---@return groupV2.TeamCallBack C#中的数据结构
function groupV2.TeamCallBack(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.TeamCallBack()
    data.roleId = decodedData.roleId
    data.name = decodedData.name
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.line ~= nil and decodedData.lineSpecified ~= false then
        data.line = decodedData.line
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    if decodedData.startTime ~= nil and decodedData.startTimeSpecified ~= false then
        data.startTime = decodedData.startTime
    end
    if decodedData.monsterId ~= nil and decodedData.monsterIdSpecified ~= false then
        data.monsterId = decodedData.monsterId
    end
    if decodedData.paramStrs ~= nil and decodedData.paramStrsSpecified ~= false then
        for i = 1, #decodedData.paramStrs do
            data.paramStrs:Add(decodedData.paramStrs[i])
        end
    end
    --C#的groupV2.TeamCallBack类中没有找到isinfire字段,不填充数据
    --C#的groupV2.TeamCallBack类中没有找到firetype字段,不填充数据
    return data
end

--[[groupV2.ResCallBack 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData groupV2.CheckCallBack lua中的数据结构
---@return groupV2.CheckCallBack C#中的数据结构
function groupV2.CheckCallBack(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.groupV2.CheckCallBack()
    data.isAgreed = decodedData.isAgreed
    data.sendRoleId = decodedData.sendRoleId
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

--[[groupV2.ReqHasPlayerSomeInfo 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[groupV2.ResHasPlayerSomeInfo 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return groupV2