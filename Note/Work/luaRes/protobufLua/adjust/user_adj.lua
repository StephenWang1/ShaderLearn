--[[本文件为工具自动生成,禁止手动修改]]
local userV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable userV2.ReqLogin
---@type userV2.ReqLogin
userV2_adj.metatable_ReqLogin = {
    _ClassName = "userV2.ReqLogin",
}
userV2_adj.metatable_ReqLogin.__index = userV2_adj.metatable_ReqLogin
--endregion

---@param tbl userV2.ReqLogin 待调整的table数据
function userV2_adj.AdjustReqLogin(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ReqLogin)
    if tbl.sid == nil then
        tbl.sidSpecified = false
        tbl.sid = 0
    else
        tbl.sidSpecified = true
    end
    if tbl.platformId == nil then
        tbl.platformIdSpecified = false
        tbl.platformId = 0
    else
        tbl.platformIdSpecified = true
    end
    if tbl.client == nil then
        tbl.clientSpecified = false
        tbl.client = 0
    else
        tbl.clientSpecified = true
    end
    if tbl.IDNumber == nil then
        tbl.IDNumberSpecified = false
        tbl.IDNumber = ""
    else
        tbl.IDNumberSpecified = true
    end
    if tbl.version == nil then
        tbl.versionSpecified = false
        tbl.version = 0
    else
        tbl.versionSpecified = true
    end
    if tbl.qudao == nil then
        tbl.qudaoSpecified = false
        tbl.qudao = 0
    else
        tbl.qudaoSpecified = true
    end
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
    if tbl.sign == nil then
        tbl.signSpecified = false
        tbl.sign = ""
    else
        tbl.signSpecified = true
    end
    if tbl.reconnect == nil then
        tbl.reconnectSpecified = false
        tbl.reconnect = 0
    else
        tbl.reconnectSpecified = true
    end
end

--region metatable userV2.ResAfterLoginInfo
---@type userV2.ResAfterLoginInfo
userV2_adj.metatable_ResAfterLoginInfo = {
    _ClassName = "userV2.ResAfterLoginInfo",
}
userV2_adj.metatable_ResAfterLoginInfo.__index = userV2_adj.metatable_ResAfterLoginInfo
--endregion

---@param tbl userV2.ResAfterLoginInfo 待调整的table数据
function userV2_adj.AdjustResAfterLoginInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ResAfterLoginInfo)
    if tbl.openServerTime == nil then
        tbl.openServerTimeSpecified = false
        tbl.openServerTime = 0
    else
        tbl.openServerTimeSpecified = true
    end
    if tbl.combineServerTime == nil then
        tbl.combineServerTimeSpecified = false
        tbl.combineServerTime = 0
    else
        tbl.combineServerTimeSpecified = true
    end
    if tbl.serverCurTime == nil then
        tbl.serverCurTimeSpecified = false
        tbl.serverCurTime = 0
    else
        tbl.serverCurTimeSpecified = true
    end
    if tbl.shareOpen == nil then
        tbl.shareOpenSpecified = false
        tbl.shareOpen = 0
    else
        tbl.shareOpenSpecified = true
    end
end

--region metatable userV2.ResLogin
---@type userV2.ResLogin
userV2_adj.metatable_ResLogin = {
    _ClassName = "userV2.ResLogin",
}
userV2_adj.metatable_ResLogin.__index = userV2_adj.metatable_ResLogin
--endregion

---@param tbl userV2.ResLogin 待调整的table数据
function userV2_adj.AdjustResLogin(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ResLogin)
    if tbl.roleList == nil then
        tbl.roleList = {}
    else
        if adjustTable.role_adj ~= nil and adjustTable.role_adj.AdjustRoleToOtherInfo ~= nil then
            for i = 1, #tbl.roleList do
                adjustTable.role_adj.AdjustRoleToOtherInfo(tbl.roleList[i])
            end
        end
    end
    if tbl.userId == nil then
        tbl.userIdSpecified = false
        tbl.userId = 0
    else
        tbl.userIdSpecified = true
    end
end

--region metatable userV2.ResCreateRole
---@type userV2.ResCreateRole
userV2_adj.metatable_ResCreateRole = {
    _ClassName = "userV2.ResCreateRole",
}
userV2_adj.metatable_ResCreateRole.__index = userV2_adj.metatable_ResCreateRole
--endregion

---@param tbl userV2.ResCreateRole 待调整的table数据
function userV2_adj.AdjustResCreateRole(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ResCreateRole)
    if tbl.uid == nil then
        tbl.uidSpecified = false
        tbl.uid = 0
    else
        tbl.uidSpecified = true
    end
    if tbl.randomRoleName == nil then
        tbl.randomRoleNameSpecified = false
        tbl.randomRoleName = ""
    else
        tbl.randomRoleNameSpecified = true
    end
    if tbl.flag == nil then
        tbl.flagSpecified = false
        tbl.flag = 0
    else
        tbl.flagSpecified = true
    end
end

--region metatable userV2.ReqCreateRole
---@type userV2.ReqCreateRole
userV2_adj.metatable_ReqCreateRole = {
    _ClassName = "userV2.ReqCreateRole",
}
userV2_adj.metatable_ReqCreateRole.__index = userV2_adj.metatable_ReqCreateRole
--endregion

---@param tbl userV2.ReqCreateRole 待调整的table数据
function userV2_adj.AdjustReqCreateRole(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ReqCreateRole)
    if tbl.roleName == nil then
        tbl.roleNameSpecified = false
        tbl.roleName = ""
    else
        tbl.roleNameSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.inviteCode == nil then
        tbl.inviteCodeSpecified = false
        tbl.inviteCode = ""
    else
        tbl.inviteCodeSpecified = true
    end
end

--region metatable userV2.ReqInviteCodeVerify
---@type userV2.ReqInviteCodeVerify
userV2_adj.metatable_ReqInviteCodeVerify = {
    _ClassName = "userV2.ReqInviteCodeVerify",
}
userV2_adj.metatable_ReqInviteCodeVerify.__index = userV2_adj.metatable_ReqInviteCodeVerify
--endregion

---@param tbl userV2.ReqInviteCodeVerify 待调整的table数据
function userV2_adj.AdjustReqInviteCodeVerify(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ReqInviteCodeVerify)
    if tbl.inviteCode == nil then
        tbl.inviteCodeSpecified = false
        tbl.inviteCode = ""
    else
        tbl.inviteCodeSpecified = true
    end
end

--region metatable userV2.ResInviteCodeVerify
---@type userV2.ResInviteCodeVerify
userV2_adj.metatable_ResInviteCodeVerify = {
    _ClassName = "userV2.ResInviteCodeVerify",
}
userV2_adj.metatable_ResInviteCodeVerify.__index = userV2_adj.metatable_ResInviteCodeVerify
--endregion

---@param tbl userV2.ResInviteCodeVerify 待调整的table数据
function userV2_adj.AdjustResInviteCodeVerify(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ResInviteCodeVerify)
    if tbl.result == nil then
        tbl.resultSpecified = false
        tbl.result = 0
    else
        tbl.resultSpecified = true
    end
end

--region metatable userV2.ReqRandomName
---@type userV2.ReqRandomName
userV2_adj.metatable_ReqRandomName = {
    _ClassName = "userV2.ReqRandomName",
}
userV2_adj.metatable_ReqRandomName.__index = userV2_adj.metatable_ReqRandomName
--endregion

---@param tbl userV2.ReqRandomName 待调整的table数据
function userV2_adj.AdjustReqRandomName(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ReqRandomName)
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
end

--region metatable userV2.ResRandomName
---@type userV2.ResRandomName
userV2_adj.metatable_ResRandomName = {
    _ClassName = "userV2.ResRandomName",
}
userV2_adj.metatable_ResRandomName.__index = userV2_adj.metatable_ResRandomName
--endregion

---@param tbl userV2.ResRandomName 待调整的table数据
function userV2_adj.AdjustResRandomName(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ResRandomName)
    if tbl.roleName == nil then
        tbl.roleNameSpecified = false
        tbl.roleName = ""
    else
        tbl.roleNameSpecified = true
    end
end

--region metatable userV2.ResRoleName
---@type userV2.ResRoleName
userV2_adj.metatable_ResRoleName = {
    _ClassName = "userV2.ResRoleName",
}
userV2_adj.metatable_ResRoleName.__index = userV2_adj.metatable_ResRoleName
--endregion

---@param tbl userV2.ResRoleName 待调整的table数据
function userV2_adj.AdjustResRoleName(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ResRoleName)
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
end

--region metatable userV2.ResEnterGame
---@type userV2.ResEnterGame
userV2_adj.metatable_ResEnterGame = {
    _ClassName = "userV2.ResEnterGame",
}
userV2_adj.metatable_ResEnterGame.__index = userV2_adj.metatable_ResEnterGame
--endregion

---@param tbl userV2.ResEnterGame 待调整的table数据
function userV2_adj.AdjustResEnterGame(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ResEnterGame)
    if tbl.uid == nil then
        tbl.uidSpecified = false
        tbl.uid = 0
    else
        tbl.uidSpecified = true
    end
    if tbl.uidStr == nil then
        tbl.uidStrSpecified = false
        tbl.uidStr = ""
    else
        tbl.uidStrSpecified = true
    end
    if tbl.serverTime == nil then
        tbl.serverTimeSpecified = false
        tbl.serverTime = 0
    else
        tbl.serverTimeSpecified = true
    end
end

--region metatable userV2.ReqHeart
---@type userV2.ReqHeart
userV2_adj.metatable_ReqHeart = {
    _ClassName = "userV2.ReqHeart",
}
userV2_adj.metatable_ReqHeart.__index = userV2_adj.metatable_ReqHeart
--endregion

---@param tbl userV2.ReqHeart 待调整的table数据
function userV2_adj.AdjustReqHeart(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ReqHeart)
    if tbl.clientTime == nil then
        tbl.clientTimeSpecified = false
        tbl.clientTime = 0
    else
        tbl.clientTimeSpecified = true
    end
end

--region metatable userV2.ResHeart
---@type userV2.ResHeart
userV2_adj.metatable_ResHeart = {
    _ClassName = "userV2.ResHeart",
}
userV2_adj.metatable_ResHeart.__index = userV2_adj.metatable_ResHeart
--endregion

---@param tbl userV2.ResHeart 待调整的table数据
function userV2_adj.AdjustResHeart(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ResHeart)
    if tbl.nowTime == nil then
        tbl.nowTimeSpecified = false
        tbl.nowTime = 0
    else
        tbl.nowTimeSpecified = true
    end
    if tbl.clientTime == nil then
        tbl.clientTimeSpecified = false
        tbl.clientTime = 0
    else
        tbl.clientTimeSpecified = true
    end
end

--region metatable userV2.ReqRoleId
---@type userV2.ReqRoleId
userV2_adj.metatable_ReqRoleId = {
    _ClassName = "userV2.ReqRoleId",
}
userV2_adj.metatable_ReqRoleId.__index = userV2_adj.metatable_ReqRoleId
--endregion

---@param tbl userV2.ReqRoleId 待调整的table数据
function userV2_adj.AdjustReqRoleId(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ReqRoleId)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
end

--region metatable userV2.ResUserIdInfo
---@type userV2.ResUserIdInfo
userV2_adj.metatable_ResUserIdInfo = {
    _ClassName = "userV2.ResUserIdInfo",
}
userV2_adj.metatable_ResUserIdInfo.__index = userV2_adj.metatable_ResUserIdInfo
--endregion

---@param tbl userV2.ResUserIdInfo 待调整的table数据
function userV2_adj.AdjustResUserIdInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ResUserIdInfo)
    if tbl.userId == nil then
        tbl.userIdSpecified = false
        tbl.userId = 0
    else
        tbl.userIdSpecified = true
    end
end

--region metatable userV2.ResVersionError
---@type userV2.ResVersionError
userV2_adj.metatable_ResVersionError = {
    _ClassName = "userV2.ResVersionError",
}
userV2_adj.metatable_ResVersionError.__index = userV2_adj.metatable_ResVersionError
--endregion

---@param tbl userV2.ResVersionError 待调整的table数据
function userV2_adj.AdjustResVersionError(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ResVersionError)
    if tbl.version == nil then
        tbl.versionSpecified = false
        tbl.version = 0
    else
        tbl.versionSpecified = true
    end
end

--region metatable userV2.DisconnectResponse
---@type userV2.DisconnectResponse
userV2_adj.metatable_DisconnectResponse = {
    _ClassName = "userV2.DisconnectResponse",
}
userV2_adj.metatable_DisconnectResponse.__index = userV2_adj.metatable_DisconnectResponse
--endregion

---@param tbl userV2.DisconnectResponse 待调整的table数据
function userV2_adj.AdjustDisconnectResponse(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_DisconnectResponse)
    if tbl.reason == nil then
        tbl.reasonSpecified = false
        tbl.reason = 0
    else
        tbl.reasonSpecified = true
    end
end

--region metatable userV2.ResDeleteRole
---@type userV2.ResDeleteRole
userV2_adj.metatable_ResDeleteRole = {
    _ClassName = "userV2.ResDeleteRole",
}
userV2_adj.metatable_ResDeleteRole.__index = userV2_adj.metatable_ResDeleteRole
--endregion

---@param tbl userV2.ResDeleteRole 待调整的table数据
function userV2_adj.AdjustResDeleteRole(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ResDeleteRole)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
end

--region metatable userV2.ReqDeleteRole
---@type userV2.ReqDeleteRole
userV2_adj.metatable_ReqDeleteRole = {
    _ClassName = "userV2.ReqDeleteRole",
}
userV2_adj.metatable_ReqDeleteRole.__index = userV2_adj.metatable_ReqDeleteRole
--endregion

---@param tbl userV2.ReqDeleteRole 待调整的table数据
function userV2_adj.AdjustReqDeleteRole(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ReqDeleteRole)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
end

--region metatable userV2.ReqReconnect
---@type userV2.ReqReconnect
userV2_adj.metatable_ReqReconnect = {
    _ClassName = "userV2.ReqReconnect",
}
userV2_adj.metatable_ReqReconnect.__index = userV2_adj.metatable_ReqReconnect
--endregion

---@param tbl userV2.ReqReconnect 待调整的table数据
function userV2_adj.AdjustReqReconnect(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ReqReconnect)
    if tbl.loginName == nil then
        tbl.loginNameSpecified = false
        tbl.loginName = ""
    else
        tbl.loginNameSpecified = true
    end
    if tbl.sid == nil then
        tbl.sidSpecified = false
        tbl.sid = 0
    else
        tbl.sidSpecified = true
    end
    if tbl.platformId == nil then
        tbl.platformIdSpecified = false
        tbl.platformId = 0
    else
        tbl.platformIdSpecified = true
    end
    if tbl.client == nil then
        tbl.clientSpecified = false
        tbl.client = 0
    else
        tbl.clientSpecified = true
    end
    if tbl.version == nil then
        tbl.versionSpecified = false
        tbl.version = 0
    else
        tbl.versionSpecified = true
    end
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
    if tbl.sign == nil then
        tbl.signSpecified = false
        tbl.sign = ""
    else
        tbl.signSpecified = true
    end
end

--region metatable userV2.ResRobotGM
---@type userV2.ResRobotGM
userV2_adj.metatable_ResRobotGM = {
    _ClassName = "userV2.ResRobotGM",
}
userV2_adj.metatable_ResRobotGM.__index = userV2_adj.metatable_ResRobotGM
--endregion

---@param tbl userV2.ResRobotGM 待调整的table数据
function userV2_adj.AdjustResRobotGM(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ResRobotGM)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
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
    if tbl.x == nil then
        tbl.xSpecified = false
        tbl.x = 0
    else
        tbl.xSpecified = true
    end
    if tbl.y == nil then
        tbl.ySpecified = false
        tbl.y = 0
    else
        tbl.ySpecified = true
    end
    if tbl.isUseSkill == nil then
        tbl.isUseSkillSpecified = false
        tbl.isUseSkill = false
    else
        tbl.isUseSkillSpecified = true
    end
    if tbl.isClear == nil then
        tbl.isClearSpecified = false
        tbl.isClear = false
    else
        tbl.isClearSpecified = true
    end
    if tbl.addCount == nil then
        tbl.addCountSpecified = false
        tbl.addCount = 0
    else
        tbl.addCountSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.range == nil then
        tbl.rangeSpecified = false
        tbl.range = 0
    else
        tbl.rangeSpecified = true
    end
    if tbl.model == nil then
        tbl.modelSpecified = false
        tbl.model = 0
    else
        tbl.modelSpecified = true
    end
end

--region metatable userV2.ForceRoleReload
---@type userV2.ForceRoleReload
userV2_adj.metatable_ForceRoleReload = {
    _ClassName = "userV2.ForceRoleReload",
}
userV2_adj.metatable_ForceRoleReload.__index = userV2_adj.metatable_ForceRoleReload
--endregion

---@param tbl userV2.ForceRoleReload 待调整的table数据
function userV2_adj.AdjustForceRoleReload(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, userV2_adj.metatable_ForceRoleReload)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

return userV2_adj