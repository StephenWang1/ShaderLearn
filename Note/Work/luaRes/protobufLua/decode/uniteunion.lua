--[[本文件为工具自动生成,禁止手动修改]]
local uniteunionV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData uniteunionV2.UniteUnionMember lua中的数据结构
---@return uniteunionV2.UniteUnionMember C#中的数据结构
function uniteunionV2.UniteUnionMember(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.uniteunionV2.UniteUnionMember()
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.hostId ~= nil and decodedData.hostIdSpecified ~= false then
        data.hostId = decodedData.hostId
    end
    if decodedData.unionLeaderPosition ~= nil and decodedData.unionLeaderPositionSpecified ~= false then
        data.unionLeaderPosition = decodedData.unionLeaderPosition
    end
    if decodedData.unionLeader ~= nil and decodedData.unionLeaderSpecified ~= false then
        data.unionLeader = uniteunionV2.RoleMemberInfo(decodedData.unionLeader)
    end
    if decodedData.leaderSecond ~= nil and decodedData.leaderSecondSpecified ~= false then
        for i = 1, #decodedData.leaderSecond do
            data.leaderSecond:Add(uniteunionV2.RoleMemberInfo(decodedData.leaderSecond[i]))
        end
    end
    if decodedData.unionActive ~= nil and decodedData.unionActiveSpecified ~= false then
        data.unionActive = decodedData.unionActive
    end
    return data
end

---@param decodedData uniteunionV2.RoleMemberInfo lua中的数据结构
---@return uniteunionV2.RoleMemberInfo C#中的数据结构
function uniteunionV2.RoleMemberInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.uniteunionV2.RoleMemberInfo()
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.unitePosition ~= nil and decodedData.unitePositionSpecified ~= false then
        data.unitePosition = decodedData.unitePosition
    end
    return data
end

---@param decodedData uniteunionV2.UniteUnionInfo lua中的数据结构
---@return uniteunionV2.UniteUnionInfo C#中的数据结构
function uniteunionV2.UniteUnionInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.uniteunionV2.UniteUnionInfo()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.members ~= nil and decodedData.membersSpecified ~= false then
        for i = 1, #decodedData.members do
            data.members:Add(uniteunionV2.UniteUnionMember(decodedData.members[i]))
        end
    end
    if decodedData.leaderOfUniteUnionId ~= nil and decodedData.leaderOfUniteUnionIdSpecified ~= false then
        data.leaderOfUniteUnionId = decodedData.leaderOfUniteUnionId
    end
    if decodedData.selfUnionExitTimeS ~= nil and decodedData.selfUnionExitTimeSSpecified ~= false then
        data.selfUnionExitTimeS = decodedData.selfUnionExitTimeS
    end
    if decodedData.canJoin ~= nil and decodedData.canJoinSpecified ~= false then
        data.canJoin = decodedData.canJoin
    end
    if decodedData.rank ~= nil and decodedData.rankSpecified ~= false then
        data.rank = decodedData.rank
    end
    return data
end

---@param decodedData uniteunionV2.AllUniteUnion lua中的数据结构
---@return uniteunionV2.AllUniteUnion C#中的数据结构
function uniteunionV2.AllUniteUnion(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.uniteunionV2.AllUniteUnion()
    if decodedData.allUniteUnion ~= nil and decodedData.allUniteUnionSpecified ~= false then
        for i = 1, #decodedData.allUniteUnion do
            data.allUniteUnion:Add(uniteunionV2.UniteUnionInfo(decodedData.allUniteUnion[i]))
        end
    end
    return data
end

---@param decodedData uniteunionV2.UniteUnionType lua中的数据结构
---@return uniteunionV2.UniteUnionType C#中的数据结构
function uniteunionV2.UniteUnionType(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.uniteunionV2.UniteUnionType()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData uniteunionV2.ResUniteUnionSealTowerRank lua中的数据结构
---@return uniteunionV2.ResUniteUnionSealTowerRank C#中的数据结构
function uniteunionV2.ResUniteUnionSealTowerRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.uniteunionV2.ResUniteUnionSealTowerRank()
    if decodedData.lastTime ~= nil and decodedData.lastTimeSpecified ~= false then
        data.lastTime = decodedData.lastTime
    end
    if decodedData.isOpen ~= nil and decodedData.isOpenSpecified ~= false then
        data.isOpen = decodedData.isOpen
    end
    if decodedData.hasCount ~= nil and decodedData.hasCountSpecified ~= false then
        data.hasCount = decodedData.hasCount
    end
    if decodedData.tower ~= nil and decodedData.towerSpecified ~= false then
        for i = 1, #decodedData.tower do
            data.tower:Add(uniteunionV2.SealTower(decodedData.tower[i]))
        end
    end
    if decodedData.myTowerValue ~= nil and decodedData.myTowerValueSpecified ~= false then
        data.myTowerValue = decodedData.myTowerValue
    end
    if decodedData.myUniteUnionType ~= nil and decodedData.myUniteUnionTypeSpecified ~= false then
        data.myUniteUnionType = decodedData.myUniteUnionType
    end
    return data
end

---@param decodedData uniteunionV2.SealTower lua中的数据结构
---@return uniteunionV2.SealTower C#中的数据结构
function uniteunionV2.SealTower(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.uniteunionV2.SealTower()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.rank ~= nil and decodedData.rankSpecified ~= false then
        data.rank = decodedData.rank
    end
    if decodedData.sealTowerValue ~= nil and decodedData.sealTowerValueSpecified ~= false then
        data.sealTowerValue = decodedData.sealTowerValue
    end
    return data
end

---@param decodedData uniteunionV2.ReqUniteUnionSealTowerRank lua中的数据结构
---@return uniteunionV2.ReqUniteUnionSealTowerRank C#中的数据结构
function uniteunionV2.ReqUniteUnionSealTowerRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.uniteunionV2.ReqUniteUnionSealTowerRank()
    if decodedData.uniteUnionType ~= nil and decodedData.uniteUnionTypeSpecified ~= false then
        data.uniteUnionType = decodedData.uniteUnionType
    end
    return data
end

---@param decodedData uniteunionV2.ReqSealTowerDonation lua中的数据结构
---@return uniteunionV2.ReqSealTowerDonation C#中的数据结构
function uniteunionV2.ReqSealTowerDonation(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.uniteunionV2.ReqSealTowerDonation()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData uniteunionV2.ResSealTowerDonation lua中的数据结构
---@return uniteunionV2.ResSealTowerDonation C#中的数据结构
function uniteunionV2.ResSealTowerDonation(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.uniteunionV2.ResSealTowerDonation()
    if decodedData.isSuccess ~= nil and decodedData.isSuccessSpecified ~= false then
        data.isSuccess = decodedData.isSuccess
    end
    if decodedData.addSealTowerValue ~= nil and decodedData.addSealTowerValueSpecified ~= false then
        data.addSealTowerValue = decodedData.addSealTowerValue
    end
    return data
end

---@param decodedData uniteunionV2.ResGetSealTowerMonsterPoint lua中的数据结构
---@return uniteunionV2.ResGetSealTowerMonsterPoint C#中的数据结构
function uniteunionV2.ResGetSealTowerMonsterPoint(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.uniteunionV2.ResGetSealTowerMonsterPoint()
    if decodedData.monsterLid ~= nil and decodedData.monsterLidSpecified ~= false then
        data.monsterLid = decodedData.monsterLid
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    return data
end

--[[uniteunionV2.ResRoleUniteType 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return uniteunionV2