--[[本文件为工具自动生成,禁止手动修改]]
local mapV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData mapV2.PerformerEquipBean lua中的数据结构
---@return mapV2.PerformerEquipBean C#中的数据结构
function mapV2.PerformerEquipBean(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.PerformerEquipBean()
    if decodedData.equipIndex ~= nil and decodedData.equipIndexSpecified ~= false then
        data.equipIndex = decodedData.equipIndex
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

---@param decodedData mapV2.PerformerFashionBean lua中的数据结构
---@return mapV2.PerformerFashionBean C#中的数据结构
function mapV2.PerformerFashionBean(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.PerformerFashionBean()
    if decodedData.fashionType ~= nil and decodedData.fashionTypeSpecified ~= false then
        data.fashionType = decodedData.fashionType
    end
    if decodedData.fashionId ~= nil and decodedData.fashionIdSpecified ~= false then
        data.fashionId = decodedData.fashionId
    end
    return data
end

---@param decodedData mapV2.RoundItemInfo lua中的数据结构
---@return mapV2.RoundItemInfo C#中的数据结构
function mapV2.RoundItemInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.RoundItemInfo()
    data.id = decodedData.id
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.ownerId ~= nil and decodedData.ownerIdSpecified ~= false then
        data.ownerId = decodedData.ownerId
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.dropTime ~= nil and decodedData.dropTimeSpecified ~= false then
        data.dropTime = decodedData.dropTime
    end
    if decodedData.ownerTeamId ~= nil and decodedData.ownerTeamIdSpecified ~= false then
        data.ownerTeamId = decodedData.ownerTeamId
    end
    if decodedData.dropFrom ~= nil and decodedData.dropFromSpecified ~= false then
        data.dropFrom = decodedData.dropFrom
    end
    if decodedData.totalTime ~= nil and decodedData.totalTimeSpecified ~= false then
        data.totalTime = decodedData.totalTime
    end
    if decodedData.skyPreciousLimitTime ~= nil and decodedData.skyPreciousLimitTimeSpecified ~= false then
        data.skyPreciousLimitTime = decodedData.skyPreciousLimitTime
    end
    return data
end

---@param decodedData mapV2.NoticeBean lua中的数据结构
---@return mapV2.NoticeBean C#中的数据结构
function mapV2.NoticeBean(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.NoticeBean()
    if decodedData.updateType ~= nil and decodedData.updateTypeSpecified ~= false then
        data.updateType = decodedData.updateType
    end
    if decodedData.updateValue ~= nil and decodedData.updateValueSpecified ~= false then
        data.updateValue = decodedData.updateValue
    end
    return data
end

---@param decodedData mapV2.RoundEventInfo lua中的数据结构
---@return mapV2.RoundEventInfo C#中的数据结构
function mapV2.RoundEventInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.RoundEventInfo()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.eventId ~= nil and decodedData.eventIdSpecified ~= false then
        data.eventId = decodedData.eventId
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.initTime ~= nil and decodedData.initTimeSpecified ~= false then
        data.initTime = decodedData.initTime
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    if decodedData.ownerId ~= nil and decodedData.ownerIdSpecified ~= false then
        data.ownerId = decodedData.ownerId
    end
    return data
end

---@param decodedData mapV2.RoundBufferInfo lua中的数据结构
---@return mapV2.RoundBufferInfo C#中的数据结构
function mapV2.RoundBufferInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.RoundBufferInfo()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.bufferId ~= nil and decodedData.bufferIdSpecified ~= false then
        data.bufferId = decodedData.bufferId
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.isCenterPoint ~= nil and decodedData.isCenterPointSpecified ~= false then
        data.isCenterPoint = decodedData.isCenterPoint
    end
    return data
end

---@param decodedData mapV2.RoundPlayerInfo lua中的数据结构
---@return mapV2.RoundPlayerInfo C#中的数据结构
function mapV2.RoundPlayerInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.RoundPlayerInfo()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.dir ~= nil and decodedData.dirSpecified ~= false then
        data.dir = decodedData.dir
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.maxHp ~= nil and decodedData.maxHpSpecified ~= false then
        data.maxHp = decodedData.maxHp
    end
    if decodedData.inner ~= nil and decodedData.innerSpecified ~= false then
        data.inner = decodedData.inner
    end
    if decodedData.innerMax ~= nil and decodedData.innerMaxSpecified ~= false then
        data.innerMax = decodedData.innerMax
    end
    if decodedData.teamId ~= nil and decodedData.teamIdSpecified ~= false then
        data.teamId = decodedData.teamId
    end
    if decodedData.master ~= nil and decodedData.masterSpecified ~= false then
        data.master = decodedData.master
    end
    if decodedData.equipBean ~= nil and decodedData.equipBeanSpecified ~= false then
        for i = 1, #decodedData.equipBean do
            data.equipBean:Add(mapV2.PerformerEquipBean(decodedData.equipBean[i]))
        end
    end
    if decodedData.buffers ~= nil and decodedData.buffersSpecified ~= false then
        for i = 1, #decodedData.buffers do
            data.buffers:Add(decodeTable.fight.BufferInfo(decodedData.buffers[i]))
        end
    end
    if decodedData.wing ~= nil and decodedData.wingSpecified ~= false then
        data.wing = decodedData.wing
    end
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.titleId ~= nil and decodedData.titleIdSpecified ~= false then
        data.titleId = decodedData.titleId
    end
    if decodedData.nbValue ~= nil and decodedData.nbValueSpecified ~= false then
        data.nbValue = decodedData.nbValue
    end
    if decodedData.power ~= nil and decodedData.powerSpecified ~= false then
        data.power = decodedData.power
    end
    if decodedData.mp ~= nil and decodedData.mpSpecified ~= false then
        data.mp = decodedData.mp
    end
    if decodedData.maxMp ~= nil and decodedData.maxMpSpecified ~= false then
        data.maxMp = decodedData.maxMp
    end
    if decodedData.nbValueMax ~= nil and decodedData.nbValueMaxSpecified ~= false then
        data.nbValueMax = decodedData.nbValueMax
    end
    if decodedData.boxTime ~= nil and decodedData.boxTimeSpecified ~= false then
        data.boxTime = decodedData.boxTime
    end
    if decodedData.tokenCount ~= nil and decodedData.tokenCountSpecified ~= false then
        data.tokenCount = decodedData.tokenCount
    end
    if decodedData.tokenCountId ~= nil and decodedData.tokenCountIdSpecified ~= false then
        data.tokenCountId = decodedData.tokenCountId
    end
    if decodedData.cavesPlayerInfo ~= nil and decodedData.cavesPlayerInfoSpecified ~= false then
        data.cavesPlayerInfo = decodeTable.duplicate.CavesPlayerInfo(decodedData.cavesPlayerInfo)
    end
    if decodedData.thisJunXianId ~= nil and decodedData.thisJunXianIdSpecified ~= false then
        data.thisJunXianId = decodedData.thisJunXianId
    end
    if decodedData.wearInfo ~= nil and decodedData.wearInfoSpecified ~= false then
        for i = 1, #decodedData.wearInfo do
            data.wearInfo:Add(decodeTable.appearance.wearPosition(decodedData.wearInfo[i]))
        end
    end
    if decodedData.servants ~= nil and decodedData.servantsSpecified ~= false then
        for i = 1, #decodedData.servants do
            data.servants:Add(mapV2.ResServantInfo(decodedData.servants[i]))
        end
    end
    if decodedData.elementSuitId ~= nil and decodedData.elementSuitIdSpecified ~= false then
        data.elementSuitId = decodedData.elementSuitId
    end
    if decodedData.appellation ~= nil and decodedData.appellationSpecified ~= false then
        data.appellation = decodeTable.appearance.TitleInfo(decodedData.appellation)
    end
    if decodedData.spyInfo ~= nil and decodedData.spyInfoSpecified ~= false then
        data.spyInfo = mapV2.RoundPlayerInfo(decodedData.spyInfo)
    end
    if decodedData.intensifySuitLevel ~= nil and decodedData.intensifySuitLevelSpecified ~= false then
        data.intensifySuitLevel = decodedData.intensifySuitLevel
    end
    if decodedData.unionIcon ~= nil and decodedData.unionIconSpecified ~= false then
        data.unionIcon = decodedData.unionIcon
    end
    if decodedData.isSworn ~= nil and decodedData.isSwornSpecified ~= false then
        data.isSworn = decodedData.isSworn
    end
    if decodedData.statSwornTime ~= nil and decodedData.statSwornTimeSpecified ~= false then
        data.statSwornTime = decodedData.statSwornTime
    end
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.fightModel ~= nil and decodedData.fightModelSpecified ~= false then
        data.fightModel = decodedData.fightModel
    end
    if decodedData.enterMapTime ~= nil and decodedData.enterMapTimeSpecified ~= false then
        data.enterMapTime = decodedData.enterMapTime
    end
    if decodedData.unionRank ~= nil and decodedData.unionRankSpecified ~= false then
        data.unionRank = decodedData.unionRank
    end
    if decodedData.remoteHostId ~= nil and decodedData.remoteHostIdSpecified ~= false then
        data.remoteHostId = decodedData.remoteHostId
    end
    if decodedData.uniteUnionType ~= nil and decodedData.uniteUnionTypeSpecified ~= false then
        data.uniteUnionType = decodedData.uniteUnionType
    end
    if decodedData.uniteUnionRank ~= nil and decodedData.uniteUnionRankSpecified ~= false then
        data.uniteUnionRank = decodedData.uniteUnionRank
    end
    if decodedData.sealMarkId ~= nil and decodedData.sealMarkIdSpecified ~= false then
        data.sealMarkId = decodedData.sealMarkId
    end
    if decodedData.digTreasureState ~= nil and decodedData.digTreasureStateSpecified ~= false then
        data.digTreasureState = decodedData.digTreasureState
    end
    return data
end

---@param decodedData mapV2.RoundMonsterInfo lua中的数据结构
---@return mapV2.RoundMonsterInfo C#中的数据结构
function mapV2.RoundMonsterInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.RoundMonsterInfo()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.mid ~= nil and decodedData.midSpecified ~= false then
        data.mid = decodedData.mid
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.dir ~= nil and decodedData.dirSpecified ~= false then
        data.dir = decodedData.dir
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.maxHp ~= nil and decodedData.maxHpSpecified ~= false then
        data.maxHp = decodedData.maxHp
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.buffers ~= nil and decodedData.buffersSpecified ~= false then
        for i = 1, #decodedData.buffers do
            data.buffers:Add(decodeTable.fight.BufferInfo(decodedData.buffers[i]))
        end
    end
    if decodedData.endAnimation ~= nil and decodedData.endAnimationSpecified ~= false then
        data.endAnimation = decodedData.endAnimation
    end
    if decodedData.deathTime ~= nil and decodedData.deathTimeSpecified ~= false then
        data.deathTime = decodedData.deathTime
    end
    if decodedData.killId ~= nil and decodedData.killIdSpecified ~= false then
        data.killId = decodedData.killId
    end
    if decodedData.ownerId ~= nil and decodedData.ownerIdSpecified ~= false then
        data.ownerId = decodedData.ownerId
    end
    if decodedData.existenceTime ~= nil and decodedData.existenceTimeSpecified ~= false then
        data.existenceTime = decodedData.existenceTime
    end
    if decodedData.ownerName ~= nil and decodedData.ownerNameSpecified ~= false then
        data.ownerName = decodedData.ownerName
    end
    if decodedData.activeTime ~= nil and decodedData.activeTimeSpecified ~= false then
        data.activeTime = decodedData.activeTime
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.moveInterval ~= nil and decodedData.moveIntervalSpecified ~= false then
        data.moveInterval = decodedData.moveInterval
    end
    if decodedData.collectionPoint ~= nil and decodedData.collectionPointSpecified ~= false then
        data.collectionPoint = decodedData.collectionPoint
    end
    if decodedData.exitActiveWarningTime ~= nil and decodedData.exitActiveWarningTimeSpecified ~= false then
        data.exitActiveWarningTime = decodedData.exitActiveWarningTime
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.param ~= nil and decodedData.paramSpecified ~= false then
        data.param = decodedData.param
    end
    if decodedData.bowLordStartTime ~= nil and decodedData.bowLordStartTimeSpecified ~= false then
        data.bowLordStartTime = decodedData.bowLordStartTime
    end
    if decodedData.lockedBy ~= nil and decodedData.lockedBySpecified ~= false then
        data.lockedBy = decodedData.lockedBy
    end
    if decodedData.masterId ~= nil and decodedData.masterIdSpecified ~= false then
        data.masterId = decodedData.masterId
    end
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.ownerTeamId ~= nil and decodedData.ownerTeamIdSpecified ~= false then
        data.ownerTeamId = decodedData.ownerTeamId
    end
    if decodedData.masterName ~= nil and decodedData.masterNameSpecified ~= false then
        data.masterName = decodedData.masterName
    end
    if decodedData.wakeUpCount ~= nil and decodedData.wakeUpCountSpecified ~= false then
        data.wakeUpCount = decodedData.wakeUpCount
    end
    if decodedData.huntStatus ~= nil and decodedData.huntStatusSpecified ~= false then
        data.huntStatus = decodedData.huntStatus
    end
    if decodedData.hostId ~= nil and decodedData.hostIdSpecified ~= false then
        data.hostId = decodedData.hostId
    end
    if decodedData.masterUniteUnionType ~= nil and decodedData.masterUniteUnionTypeSpecified ~= false then
        data.masterUniteUnionType = decodedData.masterUniteUnionType
    end
    return data
end

---@param decodedData mapV2.RoundNpcInfo lua中的数据结构
---@return mapV2.RoundNpcInfo C#中的数据结构
function mapV2.RoundNpcInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.RoundNpcInfo()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.nid ~= nil and decodedData.nidSpecified ~= false then
        data.nid = decodedData.nid
    end
    if decodedData.mapNpcId ~= nil and decodedData.mapNpcIdSpecified ~= false then
        data.mapNpcId = decodedData.mapNpcId
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.dir ~= nil and decodedData.dirSpecified ~= false then
        data.dir = decodedData.dir
    end
    if decodedData.removeTime ~= nil and decodedData.removeTimeSpecified ~= false then
        data.removeTime = decodedData.removeTime
    end
    if decodedData.tombstoneMasterId ~= nil and decodedData.tombstoneMasterIdSpecified ~= false then
        data.tombstoneMasterId = decodedData.tombstoneMasterId
    end
    if decodedData.monsterConfigId ~= nil and decodedData.monsterConfigIdSpecified ~= false then
        data.monsterConfigId = decodedData.monsterConfigId
    end
    if decodedData.tombstoneType ~= nil and decodedData.tombstoneTypeSpecified ~= false then
        data.tombstoneType = decodedData.tombstoneType
    end
    return data
end

---@param decodedData mapV2.RoundPetInfo lua中的数据结构
---@return mapV2.RoundPetInfo C#中的数据结构
function mapV2.RoundPetInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.RoundPetInfo()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.masterId ~= nil and decodedData.masterIdSpecified ~= false then
        data.masterId = decodedData.masterId
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.mid ~= nil and decodedData.midSpecified ~= false then
        data.mid = decodedData.mid
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.dir ~= nil and decodedData.dirSpecified ~= false then
        data.dir = decodedData.dir
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.maxHp ~= nil and decodedData.maxHpSpecified ~= false then
        data.maxHp = decodedData.maxHp
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.buffers ~= nil and decodedData.buffersSpecified ~= false then
        for i = 1, #decodedData.buffers do
            data.buffers:Add(decodeTable.fight.BufferInfo(decodedData.buffers[i]))
        end
    end
    if decodedData.teamId ~= nil and decodedData.teamIdSpecified ~= false then
        data.teamId = decodedData.teamId
    end
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.enterViewType ~= nil and decodedData.enterViewTypeSpecified ~= false then
        data.enterViewType = decodedData.enterViewType
    end
    if decodedData.activeTime ~= nil and decodedData.activeTimeSpecified ~= false then
        data.activeTime = decodedData.activeTime
    end
    if decodedData.switchState ~= nil and decodedData.switchStateSpecified ~= false then
        data.switchState = decodedData.switchState
    end
    return data
end

---@param decodedData mapV2.RoundHeroInfo lua中的数据结构
---@return mapV2.RoundHeroInfo C#中的数据结构
function mapV2.RoundHeroInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.RoundHeroInfo()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.masterId ~= nil and decodedData.masterIdSpecified ~= false then
        data.masterId = decodedData.masterId
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.mid ~= nil and decodedData.midSpecified ~= false then
        data.mid = decodedData.mid
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.dir ~= nil and decodedData.dirSpecified ~= false then
        data.dir = decodedData.dir
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.maxHp ~= nil and decodedData.maxHpSpecified ~= false then
        data.maxHp = decodedData.maxHp
    end
    if decodedData.inner ~= nil and decodedData.innerSpecified ~= false then
        data.inner = decodedData.inner
    end
    if decodedData.innerMax ~= nil and decodedData.innerMaxSpecified ~= false then
        data.innerMax = decodedData.innerMax
    end
    if decodedData.maBiRate ~= nil and decodedData.maBiRateSpecified ~= false then
        data.maBiRate = decodedData.maBiRate
    end
    return data
end

---@param decodedData mapV2.RoundServantInfo lua中的数据结构
---@return mapV2.RoundServantInfo C#中的数据结构
function mapV2.RoundServantInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.RoundServantInfo()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.masterId ~= nil and decodedData.masterIdSpecified ~= false then
        data.masterId = decodedData.masterId
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.mid ~= nil and decodedData.midSpecified ~= false then
        data.mid = decodedData.mid
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.dir ~= nil and decodedData.dirSpecified ~= false then
        data.dir = decodedData.dir
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.maxHp ~= nil and decodedData.maxHpSpecified ~= false then
        data.maxHp = decodedData.maxHp
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.weight ~= nil and decodedData.weightSpecified ~= false then
        data.weight = decodedData.weight
    end
    if decodedData.enterViewType ~= nil and decodedData.enterViewTypeSpecified ~= false then
        data.enterViewType = decodedData.enterViewType
    end
    if decodedData.buffers ~= nil and decodedData.buffersSpecified ~= false then
        for i = 1, #decodedData.buffers do
            data.buffers:Add(decodeTable.fight.BufferInfo(decodedData.buffers[i]))
        end
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.teamId ~= nil and decodedData.teamIdSpecified ~= false then
        data.teamId = decodedData.teamId
    end
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.activeTime ~= nil and decodedData.activeTimeSpecified ~= false then
        data.activeTime = decodedData.activeTime
    end
    if decodedData.masterName ~= nil and decodedData.masterNameSpecified ~= false then
        data.masterName = decodedData.masterName
    end
    if decodedData.equippedSoul ~= nil and decodedData.equippedSoulSpecified ~= false then
        data.equippedSoul = decodedData.equippedSoul
    end
    return data
end

---@param decodedData mapV2.RoundServantCultivateInfo lua中的数据结构
---@return mapV2.RoundServantCultivateInfo C#中的数据结构
function mapV2.RoundServantCultivateInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.RoundServantCultivateInfo()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.masterId ~= nil and decodedData.masterIdSpecified ~= false then
        data.masterId = decodedData.masterId
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.mid ~= nil and decodedData.midSpecified ~= false then
        data.mid = decodedData.mid
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.dir ~= nil and decodedData.dirSpecified ~= false then
        data.dir = decodedData.dir
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.maxHp ~= nil and decodedData.maxHpSpecified ~= false then
        data.maxHp = decodedData.maxHp
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.weight ~= nil and decodedData.weightSpecified ~= false then
        data.weight = decodedData.weight
    end
    if decodedData.enterViewType ~= nil and decodedData.enterViewTypeSpecified ~= false then
        data.enterViewType = decodedData.enterViewType
    end
    if decodedData.buffers ~= nil and decodedData.buffersSpecified ~= false then
        for i = 1, #decodedData.buffers do
            data.buffers:Add(decodeTable.fight.BufferInfo(decodedData.buffers[i]))
        end
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.teamId ~= nil and decodedData.teamIdSpecified ~= false then
        data.teamId = decodedData.teamId
    end
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.activeTime ~= nil and decodedData.activeTimeSpecified ~= false then
        data.activeTime = decodedData.activeTime
    end
    if decodedData.masterName ~= nil and decodedData.masterNameSpecified ~= false then
        data.masterName = decodedData.masterName
    end
    if decodedData.equippedSoul ~= nil and decodedData.equippedSoulSpecified ~= false then
        data.equippedSoul = decodedData.equippedSoul
    end
    if decodedData.cultivateRate ~= nil and decodedData.cultivateRateSpecified ~= false then
        data.cultivateRate = decodedData.cultivateRate
    end
    return data
end

---@param decodedData mapV2.RoundCollectPoint lua中的数据结构
---@return mapV2.RoundCollectPoint C#中的数据结构
function mapV2.RoundCollectPoint(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.RoundCollectPoint()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.configId ~= nil and decodedData.configIdSpecified ~= false then
        data.configId = decodedData.configId
    end
    if decodedData.range ~= nil and decodedData.rangeSpecified ~= false then
        data.range = decodedData.range
    end
    if decodedData.crystalStatus ~= nil and decodedData.crystalStatusSpecified ~= false then
        data.crystalStatus = decodedData.crystalStatus
    end
    if decodedData.crystalTombTime ~= nil and decodedData.crystalTombTimeSpecified ~= false then
        data.crystalTombTime = decodedData.crystalTombTime
    end
    return data
end

---@param decodedData mapV2.RoundBoothInfo lua中的数据结构
---@return mapV2.RoundBoothInfo C#中的数据结构
function mapV2.RoundBoothInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.RoundBoothInfo()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.dir ~= nil and decodedData.dirSpecified ~= false then
        data.dir = decodedData.dir
    end
    if decodedData.boothTypeId ~= nil and decodedData.boothTypeIdSpecified ~= false then
        data.boothTypeId = decodedData.boothTypeId
    end
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.overdueTime ~= nil and decodedData.overdueTimeSpecified ~= false then
        data.overdueTime = decodedData.overdueTime
    end
    if decodedData.boothName ~= nil and decodedData.boothNameSpecified ~= false then
        data.boothName = decodedData.boothName
    end
    if decodedData.serverGropId ~= nil and decodedData.serverGropIdSpecified ~= false then
        data.serverGropId = decodedData.serverGropId
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData mapV2.RoundBonfireInfo lua中的数据结构
---@return mapV2.RoundBonfireInfo C#中的数据结构
function mapV2.RoundBonfireInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.RoundBonfireInfo()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.entTime ~= nil and decodedData.entTimeSpecified ~= false then
        data.entTime = decodedData.entTime
    end
    return data
end

---@param decodedData mapV2.MapBoss lua中的数据结构
---@return mapV2.MapBoss C#中的数据结构
function mapV2.MapBoss(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.MapBoss()
    if decodedData.bossId ~= nil and decodedData.bossIdSpecified ~= false then
        data.bossId = decodedData.bossId
    end
    if decodedData.mid ~= nil and decodedData.midSpecified ~= false then
        data.mid = decodedData.mid
    end
    if decodedData.bossHp ~= nil and decodedData.bossHpSpecified ~= false then
        data.bossHp = decodedData.bossHp
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    return data
end

---@param decodedData mapV2.MonsterTomb lua中的数据结构
---@return mapV2.MonsterTomb C#中的数据结构
function mapV2.MonsterTomb(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.MonsterTomb()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.mid ~= nil and decodedData.midSpecified ~= false then
        data.mid = decodedData.mid
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.nextReliveTime ~= nil and decodedData.nextReliveTimeSpecified ~= false then
        data.nextReliveTime = decodedData.nextReliveTime
    end
    return data
end

---@param decodedData mapV2.ResUpdateView lua中的数据结构
---@return mapV2.ResUpdateView C#中的数据结构
function mapV2.ResUpdateView(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResUpdateView()
    if decodedData.addPlayers ~= nil and decodedData.addPlayersSpecified ~= false then
        for i = 1, #decodedData.addPlayers do
            data.addPlayers:Add(mapV2.RoundPlayerInfo(decodedData.addPlayers[i]))
        end
    end
    if decodedData.addMonsters ~= nil and decodedData.addMonstersSpecified ~= false then
        for i = 1, #decodedData.addMonsters do
            data.addMonsters:Add(mapV2.RoundMonsterInfo(decodedData.addMonsters[i]))
        end
    end
    if decodedData.addNpcs ~= nil and decodedData.addNpcsSpecified ~= false then
        for i = 1, #decodedData.addNpcs do
            data.addNpcs:Add(mapV2.RoundNpcInfo(decodedData.addNpcs[i]))
        end
    end
    if decodedData.addBuffers ~= nil and decodedData.addBuffersSpecified ~= false then
        for i = 1, #decodedData.addBuffers do
            data.addBuffers:Add(mapV2.RoundBufferInfo(decodedData.addBuffers[i]))
        end
    end
    if decodedData.addPets ~= nil and decodedData.addPetsSpecified ~= false then
        for i = 1, #decodedData.addPets do
            data.addPets:Add(mapV2.RoundPetInfo(decodedData.addPets[i]))
        end
    end
    if decodedData.addHeros ~= nil and decodedData.addHerosSpecified ~= false then
        for i = 1, #decodedData.addHeros do
            data.addHeros:Add(mapV2.RoundHeroInfo(decodedData.addHeros[i]))
        end
    end
    if decodedData.addEvents ~= nil and decodedData.addEventsSpecified ~= false then
        for i = 1, #decodedData.addEvents do
            data.addEvents:Add(mapV2.RoundEventInfo(decodedData.addEvents[i]))
        end
    end
    if decodedData.addItems ~= nil and decodedData.addItemsSpecified ~= false then
        for i = 1, #decodedData.addItems do
            data.addItems:Add(mapV2.RoundItemInfo(decodedData.addItems[i]))
        end
    end
    if decodedData.exitIdList ~= nil and decodedData.exitIdListSpecified ~= false then
        for i = 1, #decodedData.exitIdList do
            data.exitIdList:Add(decodedData.exitIdList[i])
        end
    end
    if decodedData.addServants ~= nil and decodedData.addServantsSpecified ~= false then
        for i = 1, #decodedData.addServants do
            data.addServants:Add(mapV2.RoundServantInfo(decodedData.addServants[i]))
        end
    end
    if decodedData.collectPoint ~= nil and decodedData.collectPointSpecified ~= false then
        for i = 1, #decodedData.collectPoint do
            data.collectPoint:Add(mapV2.RoundCollectPoint(decodedData.collectPoint[i]))
        end
    end
    if decodedData.addBooths ~= nil and decodedData.addBoothsSpecified ~= false then
        for i = 1, #decodedData.addBooths do
            data.addBooths:Add(mapV2.RoundBoothInfo(decodedData.addBooths[i]))
        end
    end
    if decodedData.addServantCultivates ~= nil and decodedData.addServantCultivatesSpecified ~= false then
        for i = 1, #decodedData.addServantCultivates do
            data.addServantCultivates:Add(mapV2.RoundServantCultivateInfo(decodedData.addServantCultivates[i]))
        end
    end
    if decodedData.addBonfires ~= nil and decodedData.addBonfiresSpecified ~= false then
        for i = 1, #decodedData.addBonfires do
            data.addBonfires:Add(mapV2.RoundBonfireInfo(decodedData.addBonfires[i]))
        end
    end
    return data
end

---@param decodedData mapV2.ResPlayerEnterView lua中的数据结构
---@return mapV2.ResPlayerEnterView C#中的数据结构
function mapV2.ResPlayerEnterView(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResPlayerEnterView()
    data.player = mapV2.RoundPlayerInfo(decodedData.player)
    return data
end

---@param decodedData mapV2.ResCollectEnterView lua中的数据结构
---@return mapV2.ResCollectEnterView C#中的数据结构
function mapV2.ResCollectEnterView(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResCollectEnterView()
    data.collect = mapV2.RoundCollectPoint(decodedData.collect)
    return data
end

---@param decodedData mapV2.ResBufferEnterView lua中的数据结构
---@return mapV2.ResBufferEnterView C#中的数据结构
function mapV2.ResBufferEnterView(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResBufferEnterView()
    data.buffer = mapV2.RoundBufferInfo(decodedData.buffer)
    return data
end

---@param decodedData mapV2.ResMonsterEnterView lua中的数据结构
---@return mapV2.ResMonsterEnterView C#中的数据结构
function mapV2.ResMonsterEnterView(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResMonsterEnterView()
    data.monster = mapV2.RoundMonsterInfo(decodedData.monster)
    return data
end

---@param decodedData mapV2.ResNpcEnterView lua中的数据结构
---@return mapV2.ResNpcEnterView C#中的数据结构
function mapV2.ResNpcEnterView(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResNpcEnterView()
    data.npc = mapV2.RoundNpcInfo(decodedData.npc)
    return data
end

---@param decodedData mapV2.ResPetEnterView lua中的数据结构
---@return mapV2.ResPetEnterView C#中的数据结构
function mapV2.ResPetEnterView(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResPetEnterView()
    data.pet = mapV2.RoundPetInfo(decodedData.pet)
    return data
end

---@param decodedData mapV2.ResHeroEnterView lua中的数据结构
---@return mapV2.ResHeroEnterView C#中的数据结构
function mapV2.ResHeroEnterView(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResHeroEnterView()
    data.hero = mapV2.RoundHeroInfo(decodedData.hero)
    return data
end

---@param decodedData mapV2.ResServantEnterView lua中的数据结构
---@return mapV2.ResServantEnterView C#中的数据结构
function mapV2.ResServantEnterView(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResServantEnterView()
    data.servant = mapV2.RoundServantInfo(decodedData.servant)
    return data
end

---@param decodedData mapV2.ResServantCultivateEnterView lua中的数据结构
---@return mapV2.ResServantCultivateEnterView C#中的数据结构
function mapV2.ResServantCultivateEnterView(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResServantCultivateEnterView()
    data.servantCultivate = mapV2.RoundServantCultivateInfo(decodedData.servantCultivate)
    return data
end

---@param decodedData mapV2.ResBoothEnterView lua中的数据结构
---@return mapV2.ResBoothEnterView C#中的数据结构
function mapV2.ResBoothEnterView(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResBoothEnterView()
    data.booth = mapV2.RoundBoothInfo(decodedData.booth)
    return data
end

---@param decodedData mapV2.ResBonfireEnterView lua中的数据结构
---@return mapV2.ResBonfireEnterView C#中的数据结构
function mapV2.ResBonfireEnterView(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResBonfireEnterView()
    data.bonfireInfo = mapV2.RoundBonfireInfo(decodedData.bonfireInfo)
    return data
end

---@param decodedData mapV2.ResMapObjectExitView lua中的数据结构
---@return mapV2.ResMapObjectExitView C#中的数据结构
function mapV2.ResMapObjectExitView(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResMapObjectExitView()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    return data
end

---@param decodedData mapV2.ResPlayerEnterMap lua中的数据结构
---@return mapV2.ResPlayerEnterMap C#中的数据结构
function mapV2.ResPlayerEnterMap(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResPlayerEnterMap()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.dir ~= nil and decodedData.dirSpecified ~= false then
        data.dir = decodedData.dir
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.mp ~= nil and decodedData.mpSpecified ~= false then
        data.mp = decodedData.mp
    end
    if decodedData.remoteHostId ~= nil and decodedData.remoteHostIdSpecified ~= false then
        data.remoteHostId = decodedData.remoteHostId
    end
    if decodedData.uniteUnionType ~= nil and decodedData.uniteUnionTypeSpecified ~= false then
        data.uniteUnionType = decodedData.uniteUnionType
    end
    return data
end

---@param decodedData mapV2.ResPlayerChangeMap lua中的数据结构
---@return mapV2.ResPlayerChangeMap C#中的数据结构
function mapV2.ResPlayerChangeMap(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResPlayerChangeMap()
    if decodedData.mid ~= nil and decodedData.midSpecified ~= false then
        data.mid = decodedData.mid
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
    if decodedData.reason ~= nil and decodedData.reasonSpecified ~= false then
        data.reason = decodedData.reason
    end
    if decodedData.reasonParam ~= nil and decodedData.reasonParamSpecified ~= false then
        data.reasonParam = decodedData.reasonParam
    end
    return data
end

---@param decodedData mapV2.ResChangePos lua中的数据结构
---@return mapV2.ResChangePos C#中的数据结构
function mapV2.ResChangePos(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResChangePos()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.reason ~= nil and decodedData.reasonSpecified ~= false then
        data.reason = decodedData.reason
    end
    if decodedData.reasonParam ~= nil and decodedData.reasonParamSpecified ~= false then
        data.reasonParam = decodedData.reasonParam
    end
    return data
end

---@param decodedData mapV2.ResObjectMove lua中的数据结构
---@return mapV2.ResObjectMove C#中的数据结构
function mapV2.ResObjectMove(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResObjectMove()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    return data
end

---@param decodedData mapV2.ResEventEnterView lua中的数据结构
---@return mapV2.ResEventEnterView C#中的数据结构
function mapV2.ResEventEnterView(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResEventEnterView()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        data.info = mapV2.RoundEventInfo(decodedData.info)
    end
    return data
end

---@param decodedData mapV2.ResRelive lua中的数据结构
---@return mapV2.ResRelive C#中的数据结构
function mapV2.ResRelive(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResRelive()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.mp ~= nil and decodedData.mpSpecified ~= false then
        data.mp = decodedData.mp
    end
    if decodedData.inner ~= nil and decodedData.innerSpecified ~= false then
        data.inner = decodedData.inner
    end
    if decodedData.reliveType ~= nil and decodedData.reliveTypeSpecified ~= false then
        data.reliveType = decodedData.reliveType
    end
    if decodedData.powerRankPercent ~= nil and decodedData.powerRankPercentSpecified ~= false then
        data.powerRankPercent = decodedData.powerRankPercent
    end
    return data
end

---@param decodedData mapV2.ResItemEnterView lua中的数据结构
---@return mapV2.ResItemEnterView C#中的数据结构
function mapV2.ResItemEnterView(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResItemEnterView()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        data.info = mapV2.RoundItemInfo(decodedData.info)
    end
    return data
end

---@param decodedData mapV2.ResUpdateEquip lua中的数据结构
---@return mapV2.ResUpdateEquip C#中的数据结构
function mapV2.ResUpdateEquip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResUpdateEquip()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.equip ~= nil and decodedData.equipSpecified ~= false then
        data.equip = mapV2.PerformerEquipBean(decodedData.equip)
    end
    return data
end

---@param decodedData mapV2.TryEnterMapRequest lua中的数据结构
---@return mapV2.TryEnterMapRequest C#中的数据结构
function mapV2.TryEnterMapRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.TryEnterMapRequest()
    data.mid = decodedData.mid
    data.line = decodedData.line
    return data
end

---@param decodedData mapV2.ResTryEnterMap lua中的数据结构
---@return mapV2.ResTryEnterMap C#中的数据结构
function mapV2.ResTryEnterMap(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResTryEnterMap()
    data.mid = decodedData.mid
    data.line = decodedData.line
    if decodedData.reconnect ~= nil and decodedData.reconnectSpecified ~= false then
        data.reconnect = decodedData.reconnect
    end
    return data
end

---@param decodedData mapV2.ResChangePlayer lua中的数据结构
---@return mapV2.ResChangePlayer C#中的数据结构
function mapV2.ResChangePlayer(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResChangePlayer()
    data.playerId = decodedData.playerId
    return data
end

---@param decodedData mapV2.ResReplacePlayer lua中的数据结构
---@return mapV2.ResReplacePlayer C#中的数据结构
function mapV2.ResReplacePlayer(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResReplacePlayer()
    data.oldId = decodedData.oldId
    data.newId = decodedData.newId
    return data
end

---@param decodedData mapV2.ResBossOwner lua中的数据结构
---@return mapV2.ResBossOwner C#中的数据结构
function mapV2.ResBossOwner(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResBossOwner()
    if decodedData.bossId ~= nil and decodedData.bossIdSpecified ~= false then
        data.bossId = decodedData.bossId
    end
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    return data
end

---@param decodedData mapV2.ResIntensifySuitChange lua中的数据结构
---@return mapV2.ResIntensifySuitChange C#中的数据结构
function mapV2.ResIntensifySuitChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResIntensifySuitChange()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    return data
end

---@param decodedData mapV2.ResPlayerWingChange lua中的数据结构
---@return mapV2.ResPlayerWingChange C#中的数据结构
function mapV2.ResPlayerWingChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResPlayerWingChange()
    data.lid = decodedData.lid
    data.wing = decodedData.wing
    return data
end

---@param decodedData mapV2.ResPlayerUnionChange lua中的数据结构
---@return mapV2.ResPlayerUnionChange C#中的数据结构
function mapV2.ResPlayerUnionChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResPlayerUnionChange()
    data.lid = decodedData.lid
    data.unionId = decodedData.unionId
    data.unionName = decodedData.unionName
    return data
end

---@param decodedData mapV2.PlayerReliveRequest lua中的数据结构
---@return mapV2.PlayerReliveRequest C#中的数据结构
function mapV2.PlayerReliveRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.PlayerReliveRequest()
    data.reliveType = decodedData.reliveType
    return data
end

---@param decodedData mapV2.ResPlayerReliveInfo lua中的数据结构
---@return mapV2.ResPlayerReliveInfo C#中的数据结构
function mapV2.ResPlayerReliveInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResPlayerReliveInfo()
    data.dieCount = decodedData.dieCount
    data.autoReliveTime = decodedData.autoReliveTime
    return data
end

---@param decodedData mapV2.ResPlayerFashionChange lua中的数据结构
---@return mapV2.ResPlayerFashionChange C#中的数据结构
function mapV2.ResPlayerFashionChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResPlayerFashionChange()
    data.lid = decodedData.lid
    data.fashionType = decodedData.fashionType
    data.int32 = decodedData.int32
    return data
end

---@param decodedData mapV2.ResPlayerJunxianChange lua中的数据结构
---@return mapV2.ResPlayerJunxianChange C#中的数据结构
function mapV2.ResPlayerJunxianChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResPlayerJunxianChange()
    data.lid = decodedData.lid
    data.junxianLevel = decodedData.junxianLevel
    return data
end

---@param decodedData mapV2.SwitchFightModelRequest lua中的数据结构
---@return mapV2.SwitchFightModelRequest C#中的数据结构
function mapV2.SwitchFightModelRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.SwitchFightModelRequest()
    data.fightModel = decodedData.fightModel
    return data
end

---@param decodedData mapV2.ResSwitchFightModel lua中的数据结构
---@return mapV2.ResSwitchFightModel C#中的数据结构
function mapV2.ResSwitchFightModel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResSwitchFightModel()
    data.fightModel = decodedData.fightModel
    data.changedManId = decodedData.changedManId
    return data
end

---@param decodedData mapV2.PickUpMapItemRequest lua中的数据结构
---@return mapV2.PickUpMapItemRequest C#中的数据结构
function mapV2.PickUpMapItemRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.PickUpMapItemRequest()
    data.objId = decodedData.objId
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    return data
end

---@param decodedData mapV2.PickUpMapItemsRequest lua中的数据结构
---@return mapV2.PickUpMapItemsRequest C#中的数据结构
function mapV2.PickUpMapItemsRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.PickUpMapItemsRequest()
    if decodedData.objId ~= nil and decodedData.objIdSpecified ~= false then
        for i = 1, #decodedData.objId do
            data.objId:Add(decodedData.objId[i])
        end
    end
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    return data
end

---@param decodedData mapV2.ResNoticeViewTypeInfo lua中的数据结构
---@return mapV2.ResNoticeViewTypeInfo C#中的数据结构
function mapV2.ResNoticeViewTypeInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResNoticeViewTypeInfo()
    data.lid = decodedData.lid
    if decodedData.updateList ~= nil and decodedData.updateListSpecified ~= false then
        for i = 1, #decodedData.updateList do
            data.updateList:Add(mapV2.NoticeBean(decodedData.updateList[i]))
        end
    end
    return data
end

---@param decodedData mapV2.ResAllPerformerTotalHp lua中的数据结构
---@return mapV2.ResAllPerformerTotalHp C#中的数据结构
function mapV2.ResAllPerformerTotalHp(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResAllPerformerTotalHp()
    if decodedData.mapBossList ~= nil and decodedData.mapBossListSpecified ~= false then
        for i = 1, #decodedData.mapBossList do
            data.mapBossList:Add(mapV2.MapBoss(decodedData.mapBossList[i]))
        end
    end
    if decodedData.playerId ~= nil and decodedData.playerIdSpecified ~= false then
        for i = 1, #decodedData.playerId do
            data.playerId:Add(decodedData.playerId[i])
        end
    end
    if decodedData.percent ~= nil and decodedData.percentSpecified ~= false then
        for i = 1, #decodedData.percent do
            data.percent:Add(decodedData.percent[i])
        end
    end
    if decodedData.percentIp ~= nil and decodedData.percentIpSpecified ~= false then
        for i = 1, #decodedData.percentIp do
            data.percentIp:Add(decodedData.percentIp[i])
        end
    end
    return data
end

---@param decodedData mapV2.ResPressureValue lua中的数据结构
---@return mapV2.ResPressureValue C#中的数据结构
function mapV2.ResPressureValue(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResPressureValue()
    data.pressure = decodedData.pressure
    return data
end

---@param decodedData mapV2.BossOwnerRequest lua中的数据结构
---@return mapV2.BossOwnerRequest C#中的数据结构
function mapV2.BossOwnerRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.BossOwnerRequest()
    data.bossId = decodedData.bossId
    return data
end

---@param decodedData mapV2.BossReliveTime lua中的数据结构
---@return mapV2.BossReliveTime C#中的数据结构
function mapV2.BossReliveTime(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.BossReliveTime()
    data.bossId = decodedData.bossId
    data.reliveTime = decodedData.reliveTime
    return data
end

---@param decodedData mapV2.ResPlayerSzSuitChange lua中的数据结构
---@return mapV2.ResPlayerSzSuitChange C#中的数据结构
function mapV2.ResPlayerSzSuitChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResPlayerSzSuitChange()
    data.lid = decodedData.lid
    data.suit = decodedData.suit
    return data
end

---@param decodedData mapV2.ResPlayerLegendChange lua中的数据结构
---@return mapV2.ResPlayerLegendChange C#中的数据结构
function mapV2.ResPlayerLegendChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResPlayerLegendChange()
    data.lid = decodedData.lid
    data.type = decodedData.type
    data.legendLevel = decodedData.legendLevel
    return data
end

---@param decodedData mapV2.ResTombInfo lua中的数据结构
---@return mapV2.ResTombInfo C#中的数据结构
function mapV2.ResTombInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResTombInfo()
    if decodedData.tombInfos ~= nil and decodedData.tombInfosSpecified ~= false then
        for i = 1, #decodedData.tombInfos do
            data.tombInfos:Add(mapV2.MonsterTomb(decodedData.tombInfos[i]))
        end
    end
    return data
end

---@param decodedData mapV2.GatherOperatorRequest lua中的数据结构
---@return mapV2.GatherOperatorRequest C#中的数据结构
function mapV2.GatherOperatorRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.GatherOperatorRequest()
    data.type = decodedData.type
    data.lid = decodedData.lid
    if decodedData.consumeType ~= nil and decodedData.consumeTypeSpecified ~= false then
        data.consumeType = decodedData.consumeType
    end
    if decodedData.isAutomatic ~= nil and decodedData.isAutomaticSpecified ~= false then
        data.isAutomatic = decodedData.isAutomatic
    end
    return data
end

---@param decodedData mapV2.ResGatherState lua中的数据结构
---@return mapV2.ResGatherState C#中的数据结构
function mapV2.ResGatherState(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResGatherState()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.isMonster ~= nil and decodedData.isMonsterSpecified ~= false then
        data.isMonster = decodedData.isMonster
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.deadTime ~= nil and decodedData.deadTimeSpecified ~= false then
        data.deadTime = decodedData.deadTime
    end
    if decodedData.ownerId ~= nil and decodedData.ownerIdSpecified ~= false then
        data.ownerId = decodedData.ownerId
    end
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    return data
end

---@param decodedData mapV2.ReqClickEvent lua中的数据结构
---@return mapV2.ReqClickEvent C#中的数据结构
function mapV2.ReqClickEvent(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ReqClickEvent()
    data.groundEventId = decodedData.groundEventId
    return data
end

---@param decodedData mapV2.ResObjectDeadTime lua中的数据结构
---@return mapV2.ResObjectDeadTime C#中的数据结构
function mapV2.ResObjectDeadTime(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResObjectDeadTime()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.killid ~= nil and decodedData.killidSpecified ~= false then
        data.killid = decodedData.killid
    end
    if decodedData.killName ~= nil and decodedData.killNameSpecified ~= false then
        data.killName = decodedData.killName
    end
    if decodedData.deadTime ~= nil and decodedData.deadTimeSpecified ~= false then
        data.deadTime = decodedData.deadTime
    end
    if decodedData.canCollection ~= nil and decodedData.canCollectionSpecified ~= false then
        data.canCollection = decodedData.canCollection
    end
    return data
end

---@param decodedData mapV2.WarningSkillInfo lua中的数据结构
---@return mapV2.WarningSkillInfo C#中的数据结构
function mapV2.WarningSkillInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.WarningSkillInfo()
    data.id = decodedData.id
    data.skillId = decodedData.skillId
    data.castTime = decodedData.castTime
    return data
end

---@param decodedData mapV2.ReqAnimalNPCInfo lua中的数据结构
---@return mapV2.ReqAnimalNPCInfo C#中的数据结构
function mapV2.ReqAnimalNPCInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ReqAnimalNPCInfo()
    if decodedData.npcId ~= nil and decodedData.npcIdSpecified ~= false then
        data.npcId = decodedData.npcId
    end
    return data
end

---@param decodedData mapV2.ResAnimalNPCInfo lua中的数据结构
---@return mapV2.ResAnimalNPCInfo C#中的数据结构
function mapV2.ResAnimalNPCInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResAnimalNPCInfo()
    if decodedData.monsterId ~= nil and decodedData.monsterIdSpecified ~= false then
        data.monsterId = decodedData.monsterId
    end
    if decodedData.duration ~= nil and decodedData.durationSpecified ~= false then
        data.duration = decodedData.duration
    end
    if decodedData.num ~= nil and decodedData.numSpecified ~= false then
        data.num = decodedData.num
    end
    return data
end

---@param decodedData mapV2.EnterNumRefresh lua中的数据结构
---@return mapV2.EnterNumRefresh C#中的数据结构
function mapV2.EnterNumRefresh(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.EnterNumRefresh()
    if decodedData.npcId ~= nil and decodedData.npcIdSpecified ~= false then
        data.npcId = decodedData.npcId
    end
    if decodedData.num ~= nil and decodedData.numSpecified ~= false then
        data.num = decodedData.num
    end
    return data
end

---@param decodedData mapV2.ReqSkyAngerGodInfo lua中的数据结构
---@return mapV2.ReqSkyAngerGodInfo C#中的数据结构
function mapV2.ReqSkyAngerGodInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ReqSkyAngerGodInfo()
    if decodedData.npcId ~= nil and decodedData.npcIdSpecified ~= false then
        data.npcId = decodedData.npcId
    end
    return data
end

---@param decodedData mapV2.ResSkyAngerGodInfo lua中的数据结构
---@return mapV2.ResSkyAngerGodInfo C#中的数据结构
function mapV2.ResSkyAngerGodInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResSkyAngerGodInfo()
    if decodedData.monsterId ~= nil and decodedData.monsterIdSpecified ~= false then
        data.monsterId = decodedData.monsterId
    end
    if decodedData.existenceTime ~= nil and decodedData.existenceTimeSpecified ~= false then
        data.existenceTime = decodedData.existenceTime
    end
    return data
end

---@param decodedData mapV2.ResServantInfo lua中的数据结构
---@return mapV2.ResServantInfo C#中的数据结构
function mapV2.ResServantInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResServantInfo()
    if decodedData.servantId ~= nil and decodedData.servantIdSpecified ~= false then
        data.servantId = decodedData.servantId
    end
    if decodedData.ownerId ~= nil and decodedData.ownerIdSpecified ~= false then
        data.ownerId = decodedData.ownerId
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.combineHp ~= nil and decodedData.combineHpSpecified ~= false then
        data.combineHp = decodedData.combineHp
    end
    if decodedData.combineMaxHp ~= nil and decodedData.combineMaxHpSpecified ~= false then
        data.combineMaxHp = decodedData.combineMaxHp
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData mapV2.ResTheTokenNotEnough lua中的数据结构
---@return mapV2.ResTheTokenNotEnough C#中的数据结构
function mapV2.ResTheTokenNotEnough(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResTheTokenNotEnough()
    if decodedData.conditionId ~= nil and decodedData.conditionIdSpecified ~= false then
        for i = 1, #decodedData.conditionId do
            data.conditionId:Add(mapV2.CheckToken(decodedData.conditionId[i]))
        end
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    return data
end

---@param decodedData mapV2.CheckToken lua中的数据结构
---@return mapV2.CheckToken C#中的数据结构
function mapV2.CheckToken(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.CheckToken()
    if decodedData.conditionId ~= nil and decodedData.conditionIdSpecified ~= false then
        data.conditionId = decodedData.conditionId
    end
    if decodedData.isEnough ~= nil and decodedData.isEnoughSpecified ~= false then
        data.isEnough = decodedData.isEnough
    end
    return data
end

---@param decodedData mapV2.ResItemsDrop lua中的数据结构
---@return mapV2.ResItemsDrop C#中的数据结构
function mapV2.ResItemsDrop(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResItemsDrop()
    data.dropFrom = decodedData.dropFrom
    if decodedData.items ~= nil and decodedData.itemsSpecified ~= false then
        for i = 1, #decodedData.items do
            data.items:Add(mapV2.RoundItemInfo(decodedData.items[i]))
        end
    end
    return data
end

---@param decodedData mapV2.ResStartMining lua中的数据结构
---@return mapV2.ResStartMining C#中的数据结构
function mapV2.ResStartMining(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResStartMining()
    if decodedData.todayCount ~= nil and decodedData.todayCountSpecified ~= false then
        data.todayCount = decodedData.todayCount
    end
    if decodedData.dayTime ~= nil and decodedData.dayTimeSpecified ~= false then
        data.dayTime = decodedData.dayTime
    end
    if decodedData.physical ~= nil and decodedData.physicalSpecified ~= false then
        data.physical = decodedData.physical
    end
    return data
end

---@param decodedData mapV2.ResChangeSpirit lua中的数据结构
---@return mapV2.ResChangeSpirit C#中的数据结构
function mapV2.ResChangeSpirit(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResChangeSpirit()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.physical ~= nil and decodedData.physicalSpecified ~= false then
        data.physical = decodedData.physical
    end
    return data
end

---@param decodedData mapV2.ReqDoctorRecover lua中的数据结构
---@return mapV2.ReqDoctorRecover C#中的数据结构
function mapV2.ReqDoctorRecover(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ReqDoctorRecover()
    if decodedData.moneyId ~= nil and decodedData.moneyIdSpecified ~= false then
        data.moneyId = decodedData.moneyId
    end
    return data
end

---@param decodedData mapV2.ResDoctorRecover lua中的数据结构
---@return mapV2.ResDoctorRecover C#中的数据结构
function mapV2.ResDoctorRecover(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResDoctorRecover()
    if decodedData.moneyId ~= nil and decodedData.moneyIdSpecified ~= false then
        data.moneyId = decodedData.moneyId
    end
    if decodedData.isHealth ~= nil and decodedData.isHealthSpecified ~= false then
        data.isHealth = decodedData.isHealth
    end
    if decodedData.cd ~= nil and decodedData.cdSpecified ~= false then
        data.cd = decodedData.cd
    end
    return data
end

---@param decodedData mapV2.ResPlayerBattleState lua中的数据结构
---@return mapV2.ResPlayerBattleState C#中的数据结构
function mapV2.ResPlayerBattleState(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResPlayerBattleState()
    if decodedData.enterBattle ~= nil and decodedData.enterBattleSpecified ~= false then
        data.enterBattle = decodedData.enterBattle
    end
    return data
end

---@param decodedData mapV2.ResUpdateUnionCartInfo lua中的数据结构
---@return mapV2.ResUpdateUnionCartInfo C#中的数据结构
function mapV2.ResUpdateUnionCartInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResUpdateUnionCartInfo()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.moveInterval ~= nil and decodedData.moveIntervalSpecified ~= false then
        data.moveInterval = decodedData.moveInterval
    end
    return data
end

---@param decodedData mapV2.DropProtect lua中的数据结构
---@return mapV2.DropProtect C#中的数据结构
function mapV2.DropProtect(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.DropProtect()
    if decodedData.itemConfigId ~= nil and decodedData.itemConfigIdSpecified ~= false then
        data.itemConfigId = decodedData.itemConfigId
    end
    if decodedData.pickUpTime ~= nil and decodedData.pickUpTimeSpecified ~= false then
        data.pickUpTime = decodedData.pickUpTime
    end
    if decodedData.ownerId ~= nil and decodedData.ownerIdSpecified ~= false then
        data.ownerId = decodedData.ownerId
    end
    if decodedData.ownerName ~= nil and decodedData.ownerNameSpecified ~= false then
        data.ownerName = decodedData.ownerName
    end
    if decodedData.ownerUnionId ~= nil and decodedData.ownerUnionIdSpecified ~= false then
        data.ownerUnionId = decodedData.ownerUnionId
    end
    if decodedData.pickUpId ~= nil and decodedData.pickUpIdSpecified ~= false then
        data.pickUpId = decodedData.pickUpId
    end
    if decodedData.pickUpName ~= nil and decodedData.pickUpNameSpecified ~= false then
        data.pickUpName = decodedData.pickUpName
    end
    if decodedData.pickUpUnionId ~= nil and decodedData.pickUpUnionIdSpecified ~= false then
        data.pickUpUnionId = decodedData.pickUpUnionId
    end
    if decodedData.moneyType ~= nil and decodedData.moneyTypeSpecified ~= false then
        data.moneyType = decodedData.moneyType
    end
    if decodedData.dropMoneyPrice ~= nil and decodedData.dropMoneyPriceSpecified ~= false then
        data.dropMoneyPrice = decodedData.dropMoneyPrice
    end
    if decodedData.pickUpPrice ~= nil and decodedData.pickUpPriceSpecified ~= false then
        data.pickUpPrice = decodedData.pickUpPrice
    end
    if decodedData.ownerBuy ~= nil and decodedData.ownerBuySpecified ~= false then
        data.ownerBuy = decodedData.ownerBuy
    end
    if decodedData.pickUpAward ~= nil and decodedData.pickUpAwardSpecified ~= false then
        data.pickUpAward = decodedData.pickUpAward
    end
    if decodedData.bagItemInfo ~= nil and decodedData.bagItemInfoSpecified ~= false then
        data.bagItemInfo = decodeTable.bag.BagItemInfo(decodedData.bagItemInfo)
    end
    if decodedData.alreadyReturn ~= nil and decodedData.alreadyReturnSpecified ~= false then
        data.alreadyReturn = decodedData.alreadyReturn
    end
    if decodedData.status ~= nil and decodedData.statusSpecified ~= false then
        data.status = decodedData.status
    end
    return data
end

---@param decodedData mapV2.reqDropProtect lua中的数据结构
---@return mapV2.reqDropProtect C#中的数据结构
function mapV2.reqDropProtect(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.reqDropProtect()
    if decodedData.dropProtect ~= nil and decodedData.dropProtectSpecified ~= false then
        for i = 1, #decodedData.dropProtect do
            data.dropProtect:Add(mapV2.DropProtect(decodedData.dropProtect[i]))
        end
    end
    if decodedData.itemTimeOutS ~= nil and decodedData.itemTimeOutSSpecified ~= false then
        data.itemTimeOutS = decodedData.itemTimeOutS
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData mapV2.reqDropBuy lua中的数据结构
---@return mapV2.reqDropBuy C#中的数据结构
function mapV2.reqDropBuy(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.reqDropBuy()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

---@param decodedData mapV2.reqPickUpBuy lua中的数据结构
---@return mapV2.reqPickUpBuy C#中的数据结构
function mapV2.reqPickUpBuy(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.reqPickUpBuy()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

---@param decodedData mapV2.reqDropReturn lua中的数据结构
---@return mapV2.reqDropReturn C#中的数据结构
function mapV2.reqDropReturn(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.reqDropReturn()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

---@param decodedData mapV2.reqDropReturnAward lua中的数据结构
---@return mapV2.reqDropReturnAward C#中的数据结构
function mapV2.reqDropReturnAward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.reqDropReturnAward()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

---@param decodedData mapV2.dropProtectNotice lua中的数据结构
---@return mapV2.dropProtectNotice C#中的数据结构
function mapV2.dropProtectNotice(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.dropProtectNotice()
    if decodedData.dropNotice ~= nil and decodedData.dropNoticeSpecified ~= false then
        data.dropNotice = decodedData.dropNotice
    end
    if decodedData.pickUpNotice ~= nil and decodedData.pickUpNoticeSpecified ~= false then
        data.pickUpNotice = decodedData.pickUpNotice
    end
    return data
end

---@param decodedData mapV2.MainCityBranch lua中的数据结构
---@return mapV2.MainCityBranch C#中的数据结构
function mapV2.MainCityBranch(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.MainCityBranch()
    if decodedData.isBranch ~= nil and decodedData.isBranchSpecified ~= false then
        data.isBranch = decodedData.isBranch
    end
    return data
end

---@param decodedData mapV2.ResGuardBowLord lua中的数据结构
---@return mapV2.ResGuardBowLord C#中的数据结构
function mapV2.ResGuardBowLord(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResGuardBowLord()
    data.lid = decodedData.lid
    data.state = decodedData.state
    return data
end

---@param decodedData mapV2.ResMinerCollection lua中的数据结构
---@return mapV2.ResMinerCollection C#中的数据结构
function mapV2.ResMinerCollection(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResMinerCollection()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    return data
end

---@param decodedData mapV2.ResStopMinerCollection lua中的数据结构
---@return mapV2.ResStopMinerCollection C#中的数据结构
function mapV2.ResStopMinerCollection(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResStopMinerCollection()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    return data
end

---@param decodedData mapV2.MinerActivityType lua中的数据结构
---@return mapV2.MinerActivityType C#中的数据结构
function mapV2.MinerActivityType(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.MinerActivityType()
    if decodedData.activityType ~= nil and decodedData.activityTypeSpecified ~= false then
        data.activityType = decodedData.activityType
    end
    if decodedData.minerId ~= nil and decodedData.minerIdSpecified ~= false then
        data.minerId = decodedData.minerId
    end
    if decodedData.killUnionName ~= nil and decodedData.killUnionNameSpecified ~= false then
        data.killUnionName = decodedData.killUnionName
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.point ~= nil and decodedData.pointSpecified ~= false then
        data.point = decodedData.point
    end
    return data
end

---@param decodedData mapV2.MonsterActiveWarning lua中的数据结构
---@return mapV2.MonsterActiveWarning C#中的数据结构
function mapV2.MonsterActiveWarning(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.MonsterActiveWarning()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    return data
end

---@param decodedData mapV2.ReqNpcReceivePrize lua中的数据结构
---@return mapV2.ReqNpcReceivePrize C#中的数据结构
function mapV2.ReqNpcReceivePrize(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ReqNpcReceivePrize()
    if decodedData.npcLid ~= nil and decodedData.npcLidSpecified ~= false then
        data.npcLid = decodedData.npcLid
    end
    return data
end

---@param decodedData mapV2.ReqReceiveRankingForNpc lua中的数据结构
---@return mapV2.ReqReceiveRankingForNpc C#中的数据结构
function mapV2.ReqReceiveRankingForNpc(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ReqReceiveRankingForNpc()
    if decodedData.npcLid ~= nil and decodedData.npcLidSpecified ~= false then
        data.npcLid = decodedData.npcLid
    end
    return data
end

---@param decodedData mapV2.ResReceiveRankingForNpc lua中的数据结构
---@return mapV2.ResReceiveRankingForNpc C#中的数据结构
function mapV2.ResReceiveRankingForNpc(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResReceiveRankingForNpc()
    if decodedData.peopleInfo ~= nil and decodedData.peopleInfoSpecified ~= false then
        for i = 1, #decodedData.peopleInfo do
            data.peopleInfo:Add(mapV2.HasReceivePeopleInfo(decodedData.peopleInfo[i]))
        end
    end
    if decodedData.receiveCount ~= nil and decodedData.receiveCountSpecified ~= false then
        data.receiveCount = decodedData.receiveCount
    end
    return data
end

---@param decodedData mapV2.HasReceivePeopleInfo lua中的数据结构
---@return mapV2.HasReceivePeopleInfo C#中的数据结构
function mapV2.HasReceivePeopleInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.HasReceivePeopleInfo()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    return data
end

---@param decodedData mapV2.TransmitEffect lua中的数据结构
---@return mapV2.TransmitEffect C#中的数据结构
function mapV2.TransmitEffect(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.TransmitEffect()
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    if decodedData.reason ~= nil and decodedData.reasonSpecified ~= false then
        data.reason = decodedData.reason
    end
    return data
end

---@param decodedData mapV2.ResPetDie lua中的数据结构
---@return mapV2.ResPetDie C#中的数据结构
function mapV2.ResPetDie(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResPetDie()
    data.skillId = decodedData.skillId
    return data
end

---@param decodedData mapV2.MultiItemEffect lua中的数据结构
---@return mapV2.MultiItemEffect C#中的数据结构
function mapV2.MultiItemEffect(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.MultiItemEffect()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
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
    if decodedData.effectId ~= nil and decodedData.effectIdSpecified ~= false then
        data.effectId = decodedData.effectId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData mapV2.ReqLocationDelivery lua中的数据结构
---@return mapV2.ReqLocationDelivery C#中的数据结构
function mapV2.ReqLocationDelivery(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ReqLocationDelivery()
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

---@param decodedData mapV2.ResLocationDelivery lua中的数据结构
---@return mapV2.ResLocationDelivery C#中的数据结构
function mapV2.ResLocationDelivery(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResLocationDelivery()
    if decodedData.deliverySuccess ~= nil and decodedData.deliverySuccessSpecified ~= false then
        data.deliverySuccess = decodedData.deliverySuccess
    end
    return data
end

---@param decodedData mapV2.MonsterIdInfo lua中的数据结构
---@return mapV2.MonsterIdInfo C#中的数据结构
function mapV2.MonsterIdInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.MonsterIdInfo()
    data.monsterId = decodedData.monsterId
    return data
end

---@param decodedData mapV2.HasSkeleton lua中的数据结构
---@return mapV2.HasSkeleton C#中的数据结构
function mapV2.HasSkeleton(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.HasSkeleton()
    if decodedData.monsterId ~= nil and decodedData.monsterIdSpecified ~= false then
        data.monsterId = decodedData.monsterId
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    return data
end

---@param decodedData mapV2.ResFishingPointChange lua中的数据结构
---@return mapV2.ResFishingPointChange C#中的数据结构
function mapV2.ResFishingPointChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResFishingPointChange()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData mapV2.ResPlayerDropInfo lua中的数据结构
---@return mapV2.ResPlayerDropInfo C#中的数据结构
function mapV2.ResPlayerDropInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResPlayerDropInfo()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.dieTime ~= nil and decodedData.dieTimeSpecified ~= false then
        data.dieTime = decodedData.dieTime
    end
    if decodedData.itemList ~= nil and decodedData.itemListSpecified ~= false then
        for i = 1, #decodedData.itemList do
            data.itemList:Add(decodeTable.bag.BagItemInfo(decodedData.itemList[i]))
        end
    end
    return data
end

---@param decodedData mapV2.TreeMonsterRefreshCall lua中的数据结构
---@return mapV2.TreeMonsterRefreshCall C#中的数据结构
function mapV2.TreeMonsterRefreshCall(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.TreeMonsterRefreshCall()
    if decodedData.monsterId ~= nil and decodedData.monsterIdSpecified ~= false then
        data.monsterId = decodedData.monsterId
    end
    if decodedData.monsterName ~= nil and decodedData.monsterNameSpecified ~= false then
        data.monsterName = decodedData.monsterName
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.line ~= nil and decodedData.lineSpecified ~= false then
        data.line = decodedData.line
    end
    if decodedData.pointX ~= nil and decodedData.pointXSpecified ~= false then
        data.pointX = decodedData.pointX
    end
    if decodedData.pointY ~= nil and decodedData.pointYSpecified ~= false then
        data.pointY = decodedData.pointY
    end
    if decodedData.startTime ~= nil and decodedData.startTimeSpecified ~= false then
        data.startTime = decodedData.startTime
    end
    return data
end

---@param decodedData mapV2.DeliverTreeMonsterInfo lua中的数据结构
---@return mapV2.DeliverTreeMonsterInfo C#中的数据结构
function mapV2.DeliverTreeMonsterInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.DeliverTreeMonsterInfo()
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.line ~= nil and decodedData.lineSpecified ~= false then
        data.line = decodedData.line
    end
    if decodedData.pointX ~= nil and decodedData.pointXSpecified ~= false then
        data.pointX = decodedData.pointX
    end
    if decodedData.pointY ~= nil and decodedData.pointYSpecified ~= false then
        data.pointY = decodedData.pointY
    end
    if decodedData.StartTime ~= nil and decodedData.StartTimeSpecified ~= false then
        data.StartTime = decodedData.StartTime
    end
    return data
end

---@param decodedData mapV2.DeliverTreeMonsterResult lua中的数据结构
---@return mapV2.DeliverTreeMonsterResult C#中的数据结构
function mapV2.DeliverTreeMonsterResult(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.DeliverTreeMonsterResult()
    if decodedData.isSuccess ~= nil and decodedData.isSuccessSpecified ~= false then
        data.isSuccess = decodedData.isSuccess
    end
    return data
end

---@param decodedData mapV2.ReqDemonBossInfo lua中的数据结构
---@return mapV2.ReqDemonBossInfo C#中的数据结构
function mapV2.ReqDemonBossInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ReqDemonBossInfo()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData mapV2.ResDemonBossInfo lua中的数据结构
---@return mapV2.ResDemonBossInfo C#中的数据结构
function mapV2.ResDemonBossInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResDemonBossInfo()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    return data
end

---@param decodedData mapV2.ResDemonBossHasCount lua中的数据结构
---@return mapV2.ResDemonBossHasCount C#中的数据结构
function mapV2.ResDemonBossHasCount(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResDemonBossHasCount()
    if decodedData.demonInfo ~= nil and decodedData.demonInfoSpecified ~= false then
        for i = 1, #decodedData.demonInfo do
            data.demonInfo:Add(mapV2.DemonInfo(decodedData.demonInfo[i]))
        end
    end
    if decodedData.helpCount ~= nil and decodedData.helpCountSpecified ~= false then
        data.helpCount = decodedData.helpCount
    end
    if decodedData.allCount ~= nil and decodedData.allCountSpecified ~= false then
        data.allCount = decodedData.allCount
    end
    if decodedData.nextHasAllCountTime ~= nil and decodedData.nextHasAllCountTimeSpecified ~= false then
        data.nextHasAllCountTime = decodedData.nextHasAllCountTime
    end
    return data
end

---@param decodedData mapV2.DemonInfo lua中的数据结构
---@return mapV2.DemonInfo C#中的数据结构
function mapV2.DemonInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.DemonInfo()
    if decodedData.killCount ~= nil and decodedData.killCountSpecified ~= false then
        data.killCount = decodedData.killCount
    end
    if decodedData.killType ~= nil and decodedData.killTypeSpecified ~= false then
        data.killType = decodedData.killType
    end
    if decodedData.nextHasTime ~= nil and decodedData.nextHasTimeSpecified ~= false then
        data.nextHasTime = decodedData.nextHasTime
    end
    return data
end

---@param decodedData mapV2.ResDemonBossUpdateHasCount lua中的数据结构
---@return mapV2.ResDemonBossUpdateHasCount C#中的数据结构
function mapV2.ResDemonBossUpdateHasCount(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResDemonBossUpdateHasCount()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.killType ~= nil and decodedData.killTypeSpecified ~= false then
        data.killType = decodedData.killType
    end
    return data
end

---@param decodedData mapV2.ReqDemonBossHelp lua中的数据结构
---@return mapV2.ReqDemonBossHelp C#中的数据结构
function mapV2.ReqDemonBossHelp(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ReqDemonBossHelp()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData mapV2.ResDemonBossHelpFailure lua中的数据结构
---@return mapV2.ResDemonBossHelpFailure C#中的数据结构
function mapV2.ResDemonBossHelpFailure(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResDemonBossHelpFailure()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.cdEndTime ~= nil and decodedData.cdEndTimeSpecified ~= false then
        data.cdEndTime = decodedData.cdEndTime
    end
    return data
end

---@param decodedData mapV2.ResDemonBossHelpToPeople lua中的数据结构
---@return mapV2.ResDemonBossHelpToPeople C#中的数据结构
function mapV2.ResDemonBossHelpToPeople(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResDemonBossHelpToPeople()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
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
    if decodedData.monsterConfigId ~= nil and decodedData.monsterConfigIdSpecified ~= false then
        data.monsterConfigId = decodedData.monsterConfigId
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    if decodedData.groupId ~= nil and decodedData.groupIdSpecified ~= false then
        data.groupId = decodedData.groupId
    end
    return data
end

---@param decodedData mapV2.ReqAcceptDemonBossHelp lua中的数据结构
---@return mapV2.ReqAcceptDemonBossHelp C#中的数据结构
function mapV2.ReqAcceptDemonBossHelp(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ReqAcceptDemonBossHelp()
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
    return data
end

---@param decodedData mapV2.DemonDieCanReward lua中的数据结构
---@return mapV2.DemonDieCanReward C#中的数据结构
function mapV2.DemonDieCanReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.DemonDieCanReward()
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
    if decodedData.monsterId ~= nil and decodedData.monsterIdSpecified ~= false then
        data.monsterId = decodedData.monsterId
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    if decodedData.ownerUnionId ~= nil and decodedData.ownerUnionIdSpecified ~= false then
        data.ownerUnionId = decodedData.ownerUnionId
    end
    if decodedData.monsterConfigId ~= nil and decodedData.monsterConfigIdSpecified ~= false then
        data.monsterConfigId = decodedData.monsterConfigId
    end
    if decodedData.ownerId ~= nil and decodedData.ownerIdSpecified ~= false then
        data.ownerId = decodedData.ownerId
    end
    return data
end

---@param decodedData mapV2.ReqDemonDieCanReward lua中的数据结构
---@return mapV2.ReqDemonDieCanReward C#中的数据结构
function mapV2.ReqDemonDieCanReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ReqDemonDieCanReward()
    if decodedData.ownerId ~= nil and decodedData.ownerIdSpecified ~= false then
        data.ownerId = decodedData.ownerId
    end
    if decodedData.ownerUnionId ~= nil and decodedData.ownerUnionIdSpecified ~= false then
        data.ownerUnionId = decodedData.ownerUnionId
    end
    if decodedData.monsterConfigId ~= nil and decodedData.monsterConfigIdSpecified ~= false then
        data.monsterConfigId = decodedData.monsterConfigId
    end
    if decodedData.monsterLid ~= nil and decodedData.monsterLidSpecified ~= false then
        data.monsterLid = decodedData.monsterLid
    end
    return data
end

---@param decodedData mapV2.DemonBossEndTime lua中的数据结构
---@return mapV2.DemonBossEndTime C#中的数据结构
function mapV2.DemonBossEndTime(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.DemonBossEndTime()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    return data
end

---@param decodedData mapV2.ResGodBossInfo lua中的数据结构
---@return mapV2.ResGodBossInfo C#中的数据结构
function mapV2.ResGodBossInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResGodBossInfo()
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    if decodedData.enterMapId ~= nil and decodedData.enterMapIdSpecified ~= false then
        data.enterMapId = decodedData.enterMapId
    end
    if decodedData.boss ~= nil and decodedData.bossSpecified ~= false then
        for i = 1, #decodedData.boss do
            data.boss:Add(mapV2.GodBoss(decodedData.boss[i]))
        end
    end
    return data
end

---@param decodedData mapV2.GodBoss lua中的数据结构
---@return mapV2.GodBoss C#中的数据结构
function mapV2.GodBoss(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.GodBoss()
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.monsterId ~= nil and decodedData.monsterIdSpecified ~= false then
        data.monsterId = decodedData.monsterId
    end
    if decodedData.monsterLid ~= nil and decodedData.monsterLidSpecified ~= false then
        data.monsterLid = decodedData.monsterLid
    end
    return data
end

---@param decodedData mapV2.ResSealTowerAddDamage lua中的数据结构
---@return mapV2.ResSealTowerAddDamage C#中的数据结构
function mapV2.ResSealTowerAddDamage(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResSealTowerAddDamage()
    if decodedData.openType ~= nil and decodedData.openTypeSpecified ~= false then
        data.openType = decodedData.openType
    end
    if decodedData.addDamgePercent ~= nil and decodedData.addDamgePercentSpecified ~= false then
        data.addDamgePercent = decodedData.addDamgePercent
    end
    return data
end

---@param decodedData mapV2.BonfireAddExp lua中的数据结构
---@return mapV2.BonfireAddExp C#中的数据结构
function mapV2.BonfireAddExp(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.BonfireAddExp()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.exp ~= nil and decodedData.expSpecified ~= false then
        data.exp = decodedData.exp
    end
    return data
end

---@param decodedData mapV2.ReqBonfireInfo lua中的数据结构
---@return mapV2.ReqBonfireInfo C#中的数据结构
function mapV2.ReqBonfireInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ReqBonfireInfo()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    return data
end

---@param decodedData mapV2.ResBonfireInfo lua中的数据结构
---@return mapV2.ResBonfireInfo C#中的数据结构
function mapV2.ResBonfireInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResBonfireInfo()
    if decodedData.basicExp ~= nil and decodedData.basicExpSpecified ~= false then
        data.basicExp = decodedData.basicExp
    end
    if decodedData.unionCount ~= nil and decodedData.unionCountSpecified ~= false then
        data.unionCount = decodedData.unionCount
    end
    if decodedData.maotaiRate ~= nil and decodedData.maotaiRateSpecified ~= false then
        data.maotaiRate = decodedData.maotaiRate
    end
    if decodedData.expCarnivalRate ~= nil and decodedData.expCarnivalRateSpecified ~= false then
        data.expCarnivalRate = decodedData.expCarnivalRate
    end
    return data
end

---@param decodedData mapV2.PlayerEnterBonfireState lua中的数据结构
---@return mapV2.PlayerEnterBonfireState C#中的数据结构
function mapV2.PlayerEnterBonfireState(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.PlayerEnterBonfireState()
    if decodedData.bonfireId ~= nil and decodedData.bonfireIdSpecified ~= false then
        data.bonfireId = decodedData.bonfireId
    end
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData mapV2.ResUseItemDeliverToMap lua中的数据结构
---@return mapV2.ResUseItemDeliverToMap C#中的数据结构
function mapV2.ResUseItemDeliverToMap(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResUseItemDeliverToMap()
    if decodedData.deliverId ~= nil and decodedData.deliverIdSpecified ~= false then
        data.deliverId = decodedData.deliverId
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    return data
end

---@param decodedData mapV2.AutoPickObjIds lua中的数据结构
---@return mapV2.AutoPickObjIds C#中的数据结构
function mapV2.AutoPickObjIds(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.AutoPickObjIds()
    if decodedData.objId ~= nil and decodedData.objIdSpecified ~= false then
        for i = 1, #decodedData.objId do
            data.objId:Add(decodedData.objId[i])
        end
    end
    return data
end

---@param decodedData mapV2.ResPlayerZhenfaChange lua中的数据结构
---@return mapV2.ResPlayerZhenfaChange C#中的数据结构
function mapV2.ResPlayerZhenfaChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResPlayerZhenfaChange()
    data.lid = decodedData.lid
    data.zhenfa = decodedData.zhenfa
    return data
end

---@param decodedData mapV2.ResPickUpTypeToClient lua中的数据结构
---@return mapV2.ResPickUpTypeToClient C#中的数据结构
function mapV2.ResPickUpTypeToClient(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResPickUpTypeToClient()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    return data
end

---@param decodedData mapV2.ResActivityMapInfo lua中的数据结构
---@return mapV2.ResActivityMapInfo C#中的数据结构
function mapV2.ResActivityMapInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ResActivityMapInfo()
    if decodedData.monsterNumber ~= nil and decodedData.monsterNumberSpecified ~= false then
        data.monsterNumber = decodedData.monsterNumber
    end
    return data
end

---@param decodedData mapV2.ReqItemRadioTransfer lua中的数据结构
---@return mapV2.ReqItemRadioTransfer C#中的数据结构
function mapV2.ReqItemRadioTransfer(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.mapV2.ReqItemRadioTransfer()
    if decodedData.boothCoordinateId ~= nil and decodedData.boothCoordinateIdSpecified ~= false then
        data.boothCoordinateId = decodedData.boothCoordinateId
    end
    if decodedData.boothId ~= nil and decodedData.boothIdSpecified ~= false then
        data.boothId = decodedData.boothId
    end
    return data
end

return mapV2