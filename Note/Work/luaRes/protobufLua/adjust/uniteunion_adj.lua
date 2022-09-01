--[[本文件为工具自动生成,禁止手动修改]]
local uniteunionV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable uniteunionV2.UniteUnionMember
---@type uniteunionV2.UniteUnionMember
uniteunionV2_adj.metatable_UniteUnionMember = {
    _ClassName = "uniteunionV2.UniteUnionMember",
}
uniteunionV2_adj.metatable_UniteUnionMember.__index = uniteunionV2_adj.metatable_UniteUnionMember
--endregion

---@param tbl uniteunionV2.UniteUnionMember 待调整的table数据
function uniteunionV2_adj.AdjustUniteUnionMember(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, uniteunionV2_adj.metatable_UniteUnionMember)
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
    if tbl.hostId == nil then
        tbl.hostIdSpecified = false
        tbl.hostId = 0
    else
        tbl.hostIdSpecified = true
    end
    if tbl.unionLeaderPosition == nil then
        tbl.unionLeaderPositionSpecified = false
        tbl.unionLeaderPosition = 0
    else
        tbl.unionLeaderPositionSpecified = true
    end
    if tbl.unionLeader == nil then
        tbl.unionLeaderSpecified = false
        tbl.unionLeader = nil
    else
        if tbl.unionLeaderSpecified == nil then 
            tbl.unionLeaderSpecified = true
            if uniteunionV2_adj.AdjustRoleMemberInfo ~= nil then
                uniteunionV2_adj.AdjustRoleMemberInfo(tbl.unionLeader)
            end
        end
    end
    if tbl.leaderSecond == nil then
        tbl.leaderSecond = {}
    else
        if uniteunionV2_adj.AdjustRoleMemberInfo ~= nil then
            for i = 1, #tbl.leaderSecond do
                uniteunionV2_adj.AdjustRoleMemberInfo(tbl.leaderSecond[i])
            end
        end
    end
    if tbl.unionActive == nil then
        tbl.unionActiveSpecified = false
        tbl.unionActive = 0
    else
        tbl.unionActiveSpecified = true
    end
end

--region metatable uniteunionV2.RoleMemberInfo
---@type uniteunionV2.RoleMemberInfo
uniteunionV2_adj.metatable_RoleMemberInfo = {
    _ClassName = "uniteunionV2.RoleMemberInfo",
}
uniteunionV2_adj.metatable_RoleMemberInfo.__index = uniteunionV2_adj.metatable_RoleMemberInfo
--endregion

---@param tbl uniteunionV2.RoleMemberInfo 待调整的table数据
function uniteunionV2_adj.AdjustRoleMemberInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, uniteunionV2_adj.metatable_RoleMemberInfo)
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.unitePosition == nil then
        tbl.unitePositionSpecified = false
        tbl.unitePosition = 0
    else
        tbl.unitePositionSpecified = true
    end
end

--region metatable uniteunionV2.UniteUnionInfo
---@type uniteunionV2.UniteUnionInfo
uniteunionV2_adj.metatable_UniteUnionInfo = {
    _ClassName = "uniteunionV2.UniteUnionInfo",
}
uniteunionV2_adj.metatable_UniteUnionInfo.__index = uniteunionV2_adj.metatable_UniteUnionInfo
--endregion

---@param tbl uniteunionV2.UniteUnionInfo 待调整的table数据
function uniteunionV2_adj.AdjustUniteUnionInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, uniteunionV2_adj.metatable_UniteUnionInfo)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.members == nil then
        tbl.members = {}
    else
        if uniteunionV2_adj.AdjustUniteUnionMember ~= nil then
            for i = 1, #tbl.members do
                uniteunionV2_adj.AdjustUniteUnionMember(tbl.members[i])
            end
        end
    end
    if tbl.leaderOfUniteUnionId == nil then
        tbl.leaderOfUniteUnionIdSpecified = false
        tbl.leaderOfUniteUnionId = 0
    else
        tbl.leaderOfUniteUnionIdSpecified = true
    end
    if tbl.selfUnionExitTimeS == nil then
        tbl.selfUnionExitTimeSSpecified = false
        tbl.selfUnionExitTimeS = 0
    else
        tbl.selfUnionExitTimeSSpecified = true
    end
    if tbl.canJoin == nil then
        tbl.canJoinSpecified = false
        tbl.canJoin = 0
    else
        tbl.canJoinSpecified = true
    end
    if tbl.rank == nil then
        tbl.rankSpecified = false
        tbl.rank = 0
    else
        tbl.rankSpecified = true
    end
end

--region metatable uniteunionV2.AllUniteUnion
---@type uniteunionV2.AllUniteUnion
uniteunionV2_adj.metatable_AllUniteUnion = {
    _ClassName = "uniteunionV2.AllUniteUnion",
}
uniteunionV2_adj.metatable_AllUniteUnion.__index = uniteunionV2_adj.metatable_AllUniteUnion
--endregion

---@param tbl uniteunionV2.AllUniteUnion 待调整的table数据
function uniteunionV2_adj.AdjustAllUniteUnion(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, uniteunionV2_adj.metatable_AllUniteUnion)
    if tbl.allUniteUnion == nil then
        tbl.allUniteUnion = {}
    else
        if uniteunionV2_adj.AdjustUniteUnionInfo ~= nil then
            for i = 1, #tbl.allUniteUnion do
                uniteunionV2_adj.AdjustUniteUnionInfo(tbl.allUniteUnion[i])
            end
        end
    end
end

--region metatable uniteunionV2.UniteUnionType
---@type uniteunionV2.UniteUnionType
uniteunionV2_adj.metatable_UniteUnionType = {
    _ClassName = "uniteunionV2.UniteUnionType",
}
uniteunionV2_adj.metatable_UniteUnionType.__index = uniteunionV2_adj.metatable_UniteUnionType
--endregion

---@param tbl uniteunionV2.UniteUnionType 待调整的table数据
function uniteunionV2_adj.AdjustUniteUnionType(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, uniteunionV2_adj.metatable_UniteUnionType)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable uniteunionV2.ResUniteUnionSealTowerRank
---@type uniteunionV2.ResUniteUnionSealTowerRank
uniteunionV2_adj.metatable_ResUniteUnionSealTowerRank = {
    _ClassName = "uniteunionV2.ResUniteUnionSealTowerRank",
}
uniteunionV2_adj.metatable_ResUniteUnionSealTowerRank.__index = uniteunionV2_adj.metatable_ResUniteUnionSealTowerRank
--endregion

---@param tbl uniteunionV2.ResUniteUnionSealTowerRank 待调整的table数据
function uniteunionV2_adj.AdjustResUniteUnionSealTowerRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, uniteunionV2_adj.metatable_ResUniteUnionSealTowerRank)
    if tbl.lastTime == nil then
        tbl.lastTimeSpecified = false
        tbl.lastTime = 0
    else
        tbl.lastTimeSpecified = true
    end
    if tbl.isOpen == nil then
        tbl.isOpenSpecified = false
        tbl.isOpen = 0
    else
        tbl.isOpenSpecified = true
    end
    if tbl.hasCount == nil then
        tbl.hasCountSpecified = false
        tbl.hasCount = 0
    else
        tbl.hasCountSpecified = true
    end
    if tbl.tower == nil then
        tbl.tower = {}
    else
        if uniteunionV2_adj.AdjustSealTower ~= nil then
            for i = 1, #tbl.tower do
                uniteunionV2_adj.AdjustSealTower(tbl.tower[i])
            end
        end
    end
    if tbl.myTowerValue == nil then
        tbl.myTowerValueSpecified = false
        tbl.myTowerValue = 0
    else
        tbl.myTowerValueSpecified = true
    end
    if tbl.myUniteUnionType == nil then
        tbl.myUniteUnionTypeSpecified = false
        tbl.myUniteUnionType = 0
    else
        tbl.myUniteUnionTypeSpecified = true
    end
end

--region metatable uniteunionV2.SealTower
---@type uniteunionV2.SealTower
uniteunionV2_adj.metatable_SealTower = {
    _ClassName = "uniteunionV2.SealTower",
}
uniteunionV2_adj.metatable_SealTower.__index = uniteunionV2_adj.metatable_SealTower
--endregion

---@param tbl uniteunionV2.SealTower 待调整的table数据
function uniteunionV2_adj.AdjustSealTower(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, uniteunionV2_adj.metatable_SealTower)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.rank == nil then
        tbl.rankSpecified = false
        tbl.rank = 0
    else
        tbl.rankSpecified = true
    end
    if tbl.sealTowerValue == nil then
        tbl.sealTowerValueSpecified = false
        tbl.sealTowerValue = 0
    else
        tbl.sealTowerValueSpecified = true
    end
end

--region metatable uniteunionV2.ReqUniteUnionSealTowerRank
---@type uniteunionV2.ReqUniteUnionSealTowerRank
uniteunionV2_adj.metatable_ReqUniteUnionSealTowerRank = {
    _ClassName = "uniteunionV2.ReqUniteUnionSealTowerRank",
}
uniteunionV2_adj.metatable_ReqUniteUnionSealTowerRank.__index = uniteunionV2_adj.metatable_ReqUniteUnionSealTowerRank
--endregion

---@param tbl uniteunionV2.ReqUniteUnionSealTowerRank 待调整的table数据
function uniteunionV2_adj.AdjustReqUniteUnionSealTowerRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, uniteunionV2_adj.metatable_ReqUniteUnionSealTowerRank)
    if tbl.uniteUnionType == nil then
        tbl.uniteUnionTypeSpecified = false
        tbl.uniteUnionType = 0
    else
        tbl.uniteUnionTypeSpecified = true
    end
end

--region metatable uniteunionV2.ReqSealTowerDonation
---@type uniteunionV2.ReqSealTowerDonation
uniteunionV2_adj.metatable_ReqSealTowerDonation = {
    _ClassName = "uniteunionV2.ReqSealTowerDonation",
}
uniteunionV2_adj.metatable_ReqSealTowerDonation.__index = uniteunionV2_adj.metatable_ReqSealTowerDonation
--endregion

---@param tbl uniteunionV2.ReqSealTowerDonation 待调整的table数据
function uniteunionV2_adj.AdjustReqSealTowerDonation(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, uniteunionV2_adj.metatable_ReqSealTowerDonation)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable uniteunionV2.ResSealTowerDonation
---@type uniteunionV2.ResSealTowerDonation
uniteunionV2_adj.metatable_ResSealTowerDonation = {
    _ClassName = "uniteunionV2.ResSealTowerDonation",
}
uniteunionV2_adj.metatable_ResSealTowerDonation.__index = uniteunionV2_adj.metatable_ResSealTowerDonation
--endregion

---@param tbl uniteunionV2.ResSealTowerDonation 待调整的table数据
function uniteunionV2_adj.AdjustResSealTowerDonation(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, uniteunionV2_adj.metatable_ResSealTowerDonation)
    if tbl.isSuccess == nil then
        tbl.isSuccessSpecified = false
        tbl.isSuccess = 0
    else
        tbl.isSuccessSpecified = true
    end
    if tbl.addSealTowerValue == nil then
        tbl.addSealTowerValueSpecified = false
        tbl.addSealTowerValue = 0
    else
        tbl.addSealTowerValueSpecified = true
    end
end

--region metatable uniteunionV2.ResGetSealTowerMonsterPoint
---@type uniteunionV2.ResGetSealTowerMonsterPoint
uniteunionV2_adj.metatable_ResGetSealTowerMonsterPoint = {
    _ClassName = "uniteunionV2.ResGetSealTowerMonsterPoint",
}
uniteunionV2_adj.metatable_ResGetSealTowerMonsterPoint.__index = uniteunionV2_adj.metatable_ResGetSealTowerMonsterPoint
--endregion

---@param tbl uniteunionV2.ResGetSealTowerMonsterPoint 待调整的table数据
function uniteunionV2_adj.AdjustResGetSealTowerMonsterPoint(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, uniteunionV2_adj.metatable_ResGetSealTowerMonsterPoint)
    if tbl.monsterLid == nil then
        tbl.monsterLidSpecified = false
        tbl.monsterLid = 0
    else
        tbl.monsterLidSpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
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
end

--region metatable uniteunionV2.ResRoleUniteType
---@type uniteunionV2.ResRoleUniteType
uniteunionV2_adj.metatable_ResRoleUniteType = {
    _ClassName = "uniteunionV2.ResRoleUniteType",
}
uniteunionV2_adj.metatable_ResRoleUniteType.__index = uniteunionV2_adj.metatable_ResRoleUniteType
--endregion

---@param tbl uniteunionV2.ResRoleUniteType 待调整的table数据
function uniteunionV2_adj.AdjustResRoleUniteType(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, uniteunionV2_adj.metatable_ResRoleUniteType)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.uniteType == nil then
        tbl.uniteTypeSpecified = false
        tbl.uniteType = 0
    else
        tbl.uniteTypeSpecified = true
    end
end

return uniteunionV2_adj