--[[本文件为工具自动生成,禁止手动修改]]
local bossV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData bossV2.PersonalBossInfo lua中的数据结构
---@return bossV2.PersonalBossInfo C#中的数据结构
function bossV2.PersonalBossInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.PersonalBossInfo()
    if decodedData.instanceId ~= nil and decodedData.instanceIdSpecified ~= false then
        data.instanceId = decodedData.instanceId
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.surplusNum ~= nil and decodedData.surplusNumSpecified ~= false then
        data.surplusNum = decodedData.surplusNum
    end
    if decodedData.freshTime ~= nil and decodedData.freshTimeSpecified ~= false then
        data.freshTime = decodedData.freshTime
    end
    return data
end

---@param decodedData bossV2.InstanceInfo lua中的数据结构
---@return bossV2.InstanceInfo C#中的数据结构
function bossV2.InstanceInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.InstanceInfo()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.surplusNum ~= nil and decodedData.surplusNumSpecified ~= false then
        data.surplusNum = decodedData.surplusNum
    end
    if decodedData.freshTime ~= nil and decodedData.freshTimeSpecified ~= false then
        data.freshTime = decodedData.freshTime
    end
    return data
end

---@param decodedData bossV2.BossKillerInfo lua中的数据结构
---@return bossV2.BossKillerInfo C#中的数据结构
function bossV2.BossKillerInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.BossKillerInfo()
    if decodedData.killTime ~= nil and decodedData.killTimeSpecified ~= false then
        data.killTime = decodedData.killTime
    end
    if decodedData.killerName ~= nil and decodedData.killerNameSpecified ~= false then
        data.killerName = decodedData.killerName
    end
    if decodedData.killerPower ~= nil and decodedData.killerPowerSpecified ~= false then
        data.killerPower = decodedData.killerPower
    end
    return data
end

---@param decodedData bossV2.ReqInstancePanelInfo lua中的数据结构
---@return bossV2.ReqInstancePanelInfo C#中的数据结构
function bossV2.ReqInstancePanelInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.ReqInstancePanelInfo()
    if decodedData.insType ~= nil and decodedData.insTypeSpecified ~= false then
        data.insType = decodedData.insType
    end
    return data
end

---@param decodedData bossV2.ResPersonalBossInfo lua中的数据结构
---@return bossV2.ResPersonalBossInfo C#中的数据结构
function bossV2.ResPersonalBossInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.ResPersonalBossInfo()
    if decodedData.bossInfo ~= nil and decodedData.bossInfoSpecified ~= false then
        for i = 1, #decodedData.bossInfo do
            data.bossInfo:Add(bossV2.PersonalBossInfo(decodedData.bossInfo[i]))
        end
    end
    return data
end

---@param decodedData bossV2.ReqSwapPersonalBoss lua中的数据结构
---@return bossV2.ReqSwapPersonalBoss C#中的数据结构
function bossV2.ReqSwapPersonalBoss(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.ReqSwapPersonalBoss()
    if decodedData.instanceId ~= nil and decodedData.instanceIdSpecified ~= false then
        data.instanceId = decodedData.instanceId
    end
    return data
end

---@param decodedData bossV2.ResBossActivityOpen lua中的数据结构
---@return bossV2.ResBossActivityOpen C#中的数据结构
function bossV2.ResBossActivityOpen(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.ResBossActivityOpen()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.instanceId ~= nil and decodedData.instanceIdSpecified ~= false then
        data.instanceId = decodedData.instanceId
    end
    if decodedData.params ~= nil and decodedData.paramsSpecified ~= false then
        data.params = decodedData.params
    end
    return data
end

---@param decodedData bossV2.ReqFieldBossInfo lua中的数据结构
---@return bossV2.ReqFieldBossInfo C#中的数据结构
function bossV2.ReqFieldBossInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.ReqFieldBossInfo()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.subType ~= nil and decodedData.subTypeSpecified ~= false then
        data.subType = decodedData.subType
    end
    return data
end

---@param decodedData bossV2.FieldBossInfo lua中的数据结构
---@return bossV2.FieldBossInfo C#中的数据结构
function bossV2.FieldBossInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.FieldBossInfo()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.configId ~= nil and decodedData.configIdSpecified ~= false then
        data.configId = decodedData.configId
    end
    if decodedData.freshTime ~= nil and decodedData.freshTimeSpecified ~= false then
        data.freshTime = decodedData.freshTime
    end
    if decodedData.killCount ~= nil and decodedData.killCountSpecified ~= false then
        data.killCount = decodedData.killCount
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.bossId ~= nil and decodedData.bossIdSpecified ~= false then
        data.bossId = decodedData.bossId
    end
    if decodedData.peopleCount ~= nil and decodedData.peopleCountSpecified ~= false then
        data.peopleCount = decodedData.peopleCount
    end
    if decodedData.totalCount ~= nil and decodedData.totalCountSpecified ~= false then
        data.totalCount = decodedData.totalCount
    end
    if decodedData.sign ~= nil and decodedData.signSpecified ~= false then
        data.sign = decodedData.sign
    end
    return data
end

---@param decodedData bossV2.ResFieldBossInfo lua中的数据结构
---@return bossV2.ResFieldBossInfo C#中的数据结构
function bossV2.ResFieldBossInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.ResFieldBossInfo()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.boss ~= nil and decodedData.bossSpecified ~= false then
        for i = 1, #decodedData.boss do
            data.boss:Add(bossV2.FieldBossInfo(decodedData.boss[i]))
        end
    end
    if decodedData.subType ~= nil and decodedData.subTypeSpecified ~= false then
        data.subType = decodedData.subType
    end
    return data
end

---@param decodedData bossV2.ResBossRefresh lua中的数据结构
---@return bossV2.ResBossRefresh C#中的数据结构
function bossV2.ResBossRefresh(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.ResBossRefresh()
    data.bossId = decodedData.bossId
    if decodedData.bossType ~= nil and decodedData.bossTypeSpecified ~= false then
        data.bossType = decodedData.bossType
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    return data
end

---@param decodedData bossV2.ResBossDie lua中的数据结构
---@return bossV2.ResBossDie C#中的数据结构
function bossV2.ResBossDie(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.ResBossDie()
    data.bossId = decodedData.bossId
    if decodedData.bossType ~= nil and decodedData.bossTypeSpecified ~= false then
        data.bossType = decodedData.bossType
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData bossV2.MinMapBossInfo lua中的数据结构
---@return bossV2.MinMapBossInfo C#中的数据结构
function bossV2.MinMapBossInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.MinMapBossInfo()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.configId ~= nil and decodedData.configIdSpecified ~= false then
        data.configId = decodedData.configId
    end
    if decodedData.freshTime ~= nil and decodedData.freshTimeSpecified ~= false then
        data.freshTime = decodedData.freshTime
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    return data
end

---@param decodedData bossV2.ResMinMapInfo lua中的数据结构
---@return bossV2.ResMinMapInfo C#中的数据结构
function bossV2.ResMinMapInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.ResMinMapInfo()
    if decodedData.updateType ~= nil and decodedData.updateTypeSpecified ~= false then
        data.updateType = decodedData.updateType
    end
    if decodedData.boss ~= nil and decodedData.bossSpecified ~= false then
        for i = 1, #decodedData.boss do
            data.boss:Add(bossV2.MinMapBossInfo(decodedData.boss[i]))
        end
    end
    if decodedData.addEvents ~= nil and decodedData.addEventsSpecified ~= false then
        for i = 1, #decodedData.addEvents do
            data.addEvents:Add(decodeTable.map.RoundEventInfo(decodedData.addEvents[i]))
        end
    end
    return data
end

---@param decodedData bossV2.ReqGetBossInfo lua中的数据结构
---@return bossV2.ReqGetBossInfo C#中的数据结构
function bossV2.ReqGetBossInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.ReqGetBossInfo()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        for i = 1, #decodedData.id do
            data.id:Add(decodedData.id[i])
        end
    end
    return data
end

---@param decodedData bossV2.GetBossInfo lua中的数据结构
---@return bossV2.GetBossInfo C#中的数据结构
function bossV2.GetBossInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.GetBossInfo()
    data.id = decodedData.id
    if decodedData.mid ~= nil and decodedData.midSpecified ~= false then
        data.mid = decodedData.mid
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.isAlive ~= nil and decodedData.isAliveSpecified ~= false then
        data.isAlive = decodedData.isAlive
    end
    return data
end

---@param decodedData bossV2.ResGetBossInfo lua中的数据结构
---@return bossV2.ResGetBossInfo C#中的数据结构
function bossV2.ResGetBossInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.ResGetBossInfo()
    if decodedData.bosses ~= nil and decodedData.bossesSpecified ~= false then
        for i = 1, #decodedData.bosses do
            data.bosses:Add(bossV2.GetBossInfo(decodedData.bosses[i]))
        end
    end
    return data
end

---@param decodedData bossV2.ReqAncientBossDamageRank lua中的数据结构
---@return bossV2.ReqAncientBossDamageRank C#中的数据结构
function bossV2.ReqAncientBossDamageRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.ReqAncientBossDamageRank()
    data.bossId = decodedData.bossId
    return data
end

---@param decodedData bossV2.AncientBossDamageRank lua中的数据结构
---@return bossV2.AncientBossDamageRank C#中的数据结构
function bossV2.AncientBossDamageRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.AncientBossDamageRank()
    data.roleId = decodedData.roleId
    if decodedData.roleName ~= nil and decodedData.roleNameSpecified ~= false then
        data.roleName = decodedData.roleName
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
    if decodedData.rein ~= nil and decodedData.reinSpecified ~= false then
        data.rein = decodedData.rein
    end
    if decodedData.hurt ~= nil and decodedData.hurtSpecified ~= false then
        data.hurt = decodedData.hurt
    end
    if decodedData.rank ~= nil and decodedData.rankSpecified ~= false then
        data.rank = decodedData.rank
    end
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.unionRank ~= nil and decodedData.unionRankSpecified ~= false then
        data.unionRank = decodedData.unionRank
    end
    return data
end

---@param decodedData bossV2.ResAncientBossDamageRank lua中的数据结构
---@return bossV2.ResAncientBossDamageRank C#中的数据结构
function bossV2.ResAncientBossDamageRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.ResAncientBossDamageRank()
    data.bossId = decodedData.bossId
    if decodedData.damageRank ~= nil and decodedData.damageRankSpecified ~= false then
        for i = 1, #decodedData.damageRank do
            data.damageRank:Add(bossV2.AncientBossDamageRank(decodedData.damageRank[i]))
        end
    end
    return data
end

---@param decodedData bossV2.ResHasAncientBossAlive lua中的数据结构
---@return bossV2.ResHasAncientBossAlive C#中的数据结构
function bossV2.ResHasAncientBossAlive(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.ResHasAncientBossAlive()
    data.hasAlive = decodedData.hasAlive
    return data
end

---@param decodedData bossV2.RefreshDemonBossInfo lua中的数据结构
---@return bossV2.RefreshDemonBossInfo C#中的数据结构
function bossV2.RefreshDemonBossInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.RefreshDemonBossInfo()
    if decodedData.bossInfo ~= nil and decodedData.bossInfoSpecified ~= false then
        data.bossInfo = bossV2.FieldBossInfo(decodedData.bossInfo)
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData bossV2.ResOmenComeBossInfo lua中的数据结构
---@return bossV2.ResOmenComeBossInfo C#中的数据结构
function bossV2.ResOmenComeBossInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.ResOmenComeBossInfo()
    if decodedData.boss ~= nil and decodedData.bossSpecified ~= false then
        for i = 1, #decodedData.boss do
            data.boss:Add(bossV2.OmenComeBoss(decodedData.boss[i]))
        end
    end
    return data
end

---@param decodedData bossV2.OmenComeBoss lua中的数据结构
---@return bossV2.OmenComeBoss C#中的数据结构
function bossV2.OmenComeBoss(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bossV2.OmenComeBoss()
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.hasCount ~= nil and decodedData.hasCountSpecified ~= false then
        data.hasCount = decodedData.hasCount
    end
    if decodedData.deliver ~= nil and decodedData.deliverSpecified ~= false then
        data.deliver = decodedData.deliver
    end
    return data
end

--[[bossV2.ReqUseMonsterCleanUpCoupons 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return bossV2