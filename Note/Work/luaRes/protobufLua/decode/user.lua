--[[本文件为工具自动生成,禁止手动修改]]
local userV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData userV2.ReqLogin lua中的数据结构
---@return userV2.ReqLogin C#中的数据结构
function userV2.ReqLogin(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.userV2.ReqLogin()
    data.loginName = decodedData.loginName
    if decodedData.sid ~= nil and decodedData.sidSpecified ~= false then
        data.sid = decodedData.sid
    end
    if decodedData.platformId ~= nil and decodedData.platformIdSpecified ~= false then
        data.platformId = decodedData.platformId
    end
    if decodedData.client ~= nil and decodedData.clientSpecified ~= false then
        data.client = decodedData.client
    end
    if decodedData.IDNumber ~= nil and decodedData.IDNumberSpecified ~= false then
        data.IDNumber = decodedData.IDNumber
    end
    if decodedData.version ~= nil and decodedData.versionSpecified ~= false then
        data.version = decodedData.version
    end
    if decodedData.qudao ~= nil and decodedData.qudaoSpecified ~= false then
        data.qudao = decodedData.qudao
    end
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    if decodedData.sign ~= nil and decodedData.signSpecified ~= false then
        data.sign = decodedData.sign
    end
    if decodedData.reconnect ~= nil and decodedData.reconnectSpecified ~= false then
        data.reconnect = decodedData.reconnect
    end
    return data
end

---@param decodedData userV2.ResAfterLoginInfo lua中的数据结构
---@return userV2.ResAfterLoginInfo C#中的数据结构
function userV2.ResAfterLoginInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.userV2.ResAfterLoginInfo()
    if decodedData.openServerTime ~= nil and decodedData.openServerTimeSpecified ~= false then
        data.openServerTime = decodedData.openServerTime
    end
    if decodedData.combineServerTime ~= nil and decodedData.combineServerTimeSpecified ~= false then
        data.combineServerTime = decodedData.combineServerTime
    end
    if decodedData.serverCurTime ~= nil and decodedData.serverCurTimeSpecified ~= false then
        data.serverCurTime = decodedData.serverCurTime
    end
    --C#的userV2.ResAfterLoginInfo类中没有找到shareOpen字段,不填充数据
    return data
end

---@param decodedData userV2.ResLogin lua中的数据结构
---@return userV2.ResLogin C#中的数据结构
function userV2.ResLogin(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.userV2.ResLogin()
    if decodedData.roleList ~= nil and decodedData.roleListSpecified ~= false then
        for i = 1, #decodedData.roleList do
            data.roleList:Add(decodeTable.role.RoleToOtherInfo(decodedData.roleList[i]))
        end
    end
    if decodedData.userId ~= nil and decodedData.userIdSpecified ~= false then
        data.userId = decodedData.userId
    end
    return data
end

---@param decodedData userV2.ResCreateRole lua中的数据结构
---@return userV2.ResCreateRole C#中的数据结构
function userV2.ResCreateRole(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.userV2.ResCreateRole()
    if decodedData.uid ~= nil and decodedData.uidSpecified ~= false then
        data.uid = decodedData.uid
    end
    if decodedData.randomRoleName ~= nil and decodedData.randomRoleNameSpecified ~= false then
        data.randomRoleName = decodedData.randomRoleName
    end
    --C#的userV2.ResCreateRole类中没有找到flag字段,不填充数据
    return data
end

---@param decodedData userV2.ReqCreateRole lua中的数据结构
---@return userV2.ReqCreateRole C#中的数据结构
function userV2.ReqCreateRole(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.userV2.ReqCreateRole()
    if decodedData.roleName ~= nil and decodedData.roleNameSpecified ~= false then
        data.roleName = decodedData.roleName
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    --C#的userV2.ReqCreateRole类中没有找到inviteCode字段,不填充数据
    return data
end

--[[userV2.ReqInviteCodeVerify 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[userV2.ResInviteCodeVerify 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData userV2.ReqRandomName lua中的数据结构
---@return userV2.ReqRandomName C#中的数据结构
function userV2.ReqRandomName(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.userV2.ReqRandomName()
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    return data
end

---@param decodedData userV2.ResRandomName lua中的数据结构
---@return userV2.ResRandomName C#中的数据结构
function userV2.ResRandomName(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.userV2.ResRandomName()
    if decodedData.roleName ~= nil and decodedData.roleNameSpecified ~= false then
        data.roleName = decodedData.roleName
    end
    return data
end

---@param decodedData userV2.ResRoleName lua中的数据结构
---@return userV2.ResRoleName C#中的数据结构
function userV2.ResRoleName(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.userV2.ResRoleName()
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    return data
end

---@param decodedData userV2.ResEnterGame lua中的数据结构
---@return userV2.ResEnterGame C#中的数据结构
function userV2.ResEnterGame(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.userV2.ResEnterGame()
    if decodedData.uid ~= nil and decodedData.uidSpecified ~= false then
        data.uid = decodedData.uid
    end
    if decodedData.uidStr ~= nil and decodedData.uidStrSpecified ~= false then
        data.uidStr = decodedData.uidStr
    end
    if decodedData.serverTime ~= nil and decodedData.serverTimeSpecified ~= false then
        data.serverTime = decodedData.serverTime
    end
    return data
end

---@param decodedData userV2.ReqHeart lua中的数据结构
---@return userV2.ReqHeart C#中的数据结构
function userV2.ReqHeart(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.userV2.ReqHeart()
    if decodedData.clientTime ~= nil and decodedData.clientTimeSpecified ~= false then
        data.clientTime = decodedData.clientTime
    end
    return data
end

---@param decodedData userV2.ResHeart lua中的数据结构
---@return userV2.ResHeart C#中的数据结构
function userV2.ResHeart(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.userV2.ResHeart()
    if decodedData.nowTime ~= nil and decodedData.nowTimeSpecified ~= false then
        data.nowTime = decodedData.nowTime
    end
    if decodedData.clientTime ~= nil and decodedData.clientTimeSpecified ~= false then
        data.clientTime = decodedData.clientTime
    end
    return data
end

---@param decodedData userV2.ReqRoleId lua中的数据结构
---@return userV2.ReqRoleId C#中的数据结构
function userV2.ReqRoleId(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.userV2.ReqRoleId()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    return data
end

---@param decodedData userV2.ResUserIdInfo lua中的数据结构
---@return userV2.ResUserIdInfo C#中的数据结构
function userV2.ResUserIdInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.userV2.ResUserIdInfo()
    if decodedData.userId ~= nil and decodedData.userIdSpecified ~= false then
        data.userId = decodedData.userId
    end
    return data
end

---@param decodedData userV2.ResVersionError lua中的数据结构
---@return userV2.ResVersionError C#中的数据结构
function userV2.ResVersionError(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.userV2.ResVersionError()
    if decodedData.version ~= nil and decodedData.versionSpecified ~= false then
        data.version = decodedData.version
    end
    return data
end

---@param decodedData userV2.DisconnectResponse lua中的数据结构
---@return userV2.DisconnectResponse C#中的数据结构
function userV2.DisconnectResponse(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.userV2.DisconnectResponse()
    if decodedData.reason ~= nil and decodedData.reasonSpecified ~= false then
        data.reason = decodedData.reason
    end
    return data
end

---@param decodedData userV2.ResDeleteRole lua中的数据结构
---@return userV2.ResDeleteRole C#中的数据结构
function userV2.ResDeleteRole(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.userV2.ResDeleteRole()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    return data
end

---@param decodedData userV2.ReqDeleteRole lua中的数据结构
---@return userV2.ReqDeleteRole C#中的数据结构
function userV2.ReqDeleteRole(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.userV2.ReqDeleteRole()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    return data
end

---@param decodedData userV2.ReqReconnect lua中的数据结构
---@return userV2.ReqReconnect C#中的数据结构
function userV2.ReqReconnect(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.userV2.ReqReconnect()
    if decodedData.loginName ~= nil and decodedData.loginNameSpecified ~= false then
        data.loginName = decodedData.loginName
    end
    if decodedData.sid ~= nil and decodedData.sidSpecified ~= false then
        data.sid = decodedData.sid
    end
    if decodedData.platformId ~= nil and decodedData.platformIdSpecified ~= false then
        data.platformId = decodedData.platformId
    end
    if decodedData.client ~= nil and decodedData.clientSpecified ~= false then
        data.client = decodedData.client
    end
    if decodedData.version ~= nil and decodedData.versionSpecified ~= false then
        data.version = decodedData.version
    end
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    if decodedData.sign ~= nil and decodedData.signSpecified ~= false then
        data.sign = decodedData.sign
    end
    return data
end

---@param decodedData userV2.ResRobotGM lua中的数据结构
---@return userV2.ResRobotGM C#中的数据结构
function userV2.ResRobotGM(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.userV2.ResRobotGM()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.line ~= nil and decodedData.lineSpecified ~= false then
        data.line = decodedData.line
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.isUseSkill ~= nil and decodedData.isUseSkillSpecified ~= false then
        data.isUseSkill = decodedData.isUseSkill
    end
    if decodedData.isClear ~= nil and decodedData.isClearSpecified ~= false then
        data.isClear = decodedData.isClear
    end
    if decodedData.addCount ~= nil and decodedData.addCountSpecified ~= false then
        data.addCount = decodedData.addCount
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.range ~= nil and decodedData.rangeSpecified ~= false then
        data.range = decodedData.range
    end
    if decodedData.model ~= nil and decodedData.modelSpecified ~= false then
        data.model = decodedData.model
    end
    return data
end

--[[userV2.ForceRoleReload 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return userV2