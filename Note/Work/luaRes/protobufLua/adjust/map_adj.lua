--[[本文件为工具自动生成,禁止手动修改]]
local mapV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable mapV2.PerformerEquipBean
---@type mapV2.PerformerEquipBean
mapV2_adj.metatable_PerformerEquipBean = {
    _ClassName = "mapV2.PerformerEquipBean",
}
mapV2_adj.metatable_PerformerEquipBean.__index = mapV2_adj.metatable_PerformerEquipBean
--endregion

---@param tbl mapV2.PerformerEquipBean 待调整的table数据
function mapV2_adj.AdjustPerformerEquipBean(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_PerformerEquipBean)
    if tbl.equipIndex == nil then
        tbl.equipIndexSpecified = false
        tbl.equipIndex = 0
    else
        tbl.equipIndexSpecified = true
    end
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
end

--region metatable mapV2.PerformerFashionBean
---@type mapV2.PerformerFashionBean
mapV2_adj.metatable_PerformerFashionBean = {
    _ClassName = "mapV2.PerformerFashionBean",
}
mapV2_adj.metatable_PerformerFashionBean.__index = mapV2_adj.metatable_PerformerFashionBean
--endregion

---@param tbl mapV2.PerformerFashionBean 待调整的table数据
function mapV2_adj.AdjustPerformerFashionBean(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_PerformerFashionBean)
    if tbl.fashionType == nil then
        tbl.fashionTypeSpecified = false
        tbl.fashionType = 0
    else
        tbl.fashionTypeSpecified = true
    end
    if tbl.fashionId == nil then
        tbl.fashionIdSpecified = false
        tbl.fashionId = 0
    else
        tbl.fashionIdSpecified = true
    end
end

--region metatable mapV2.RoundItemInfo
---@type mapV2.RoundItemInfo
mapV2_adj.metatable_RoundItemInfo = {
    _ClassName = "mapV2.RoundItemInfo",
}
mapV2_adj.metatable_RoundItemInfo.__index = mapV2_adj.metatable_RoundItemInfo
--endregion

---@param tbl mapV2.RoundItemInfo 待调整的table数据
function mapV2_adj.AdjustRoundItemInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_RoundItemInfo)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.ownerId == nil then
        tbl.ownerIdSpecified = false
        tbl.ownerId = 0
    else
        tbl.ownerIdSpecified = true
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
    if tbl.dropTime == nil then
        tbl.dropTimeSpecified = false
        tbl.dropTime = 0
    else
        tbl.dropTimeSpecified = true
    end
    if tbl.ownerTeamId == nil then
        tbl.ownerTeamIdSpecified = false
        tbl.ownerTeamId = 0
    else
        tbl.ownerTeamIdSpecified = true
    end
    if tbl.dropFrom == nil then
        tbl.dropFromSpecified = false
        tbl.dropFrom = 0
    else
        tbl.dropFromSpecified = true
    end
    if tbl.totalTime == nil then
        tbl.totalTimeSpecified = false
        tbl.totalTime = 0
    else
        tbl.totalTimeSpecified = true
    end
    if tbl.skyPreciousLimitTime == nil then
        tbl.skyPreciousLimitTimeSpecified = false
        tbl.skyPreciousLimitTime = 0
    else
        tbl.skyPreciousLimitTimeSpecified = true
    end
end

--region metatable mapV2.NoticeBean
---@type mapV2.NoticeBean
mapV2_adj.metatable_NoticeBean = {
    _ClassName = "mapV2.NoticeBean",
}
mapV2_adj.metatable_NoticeBean.__index = mapV2_adj.metatable_NoticeBean
--endregion

---@param tbl mapV2.NoticeBean 待调整的table数据
function mapV2_adj.AdjustNoticeBean(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_NoticeBean)
    if tbl.updateType == nil then
        tbl.updateTypeSpecified = false
        tbl.updateType = 0
    else
        tbl.updateTypeSpecified = true
    end
    if tbl.updateValue == nil then
        tbl.updateValueSpecified = false
        tbl.updateValue = 0
    else
        tbl.updateValueSpecified = true
    end
end

--region metatable mapV2.RoundEventInfo
---@type mapV2.RoundEventInfo
mapV2_adj.metatable_RoundEventInfo = {
    _ClassName = "mapV2.RoundEventInfo",
}
mapV2_adj.metatable_RoundEventInfo.__index = mapV2_adj.metatable_RoundEventInfo
--endregion

---@param tbl mapV2.RoundEventInfo 待调整的table数据
function mapV2_adj.AdjustRoundEventInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_RoundEventInfo)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.eventId == nil then
        tbl.eventIdSpecified = false
        tbl.eventId = 0
    else
        tbl.eventIdSpecified = true
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
    if tbl.initTime == nil then
        tbl.initTimeSpecified = false
        tbl.initTime = 0
    else
        tbl.initTimeSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
    if tbl.ownerId == nil then
        tbl.ownerIdSpecified = false
        tbl.ownerId = 0
    else
        tbl.ownerIdSpecified = true
    end
end

--region metatable mapV2.RoundBufferInfo
---@type mapV2.RoundBufferInfo
mapV2_adj.metatable_RoundBufferInfo = {
    _ClassName = "mapV2.RoundBufferInfo",
}
mapV2_adj.metatable_RoundBufferInfo.__index = mapV2_adj.metatable_RoundBufferInfo
--endregion

---@param tbl mapV2.RoundBufferInfo 待调整的table数据
function mapV2_adj.AdjustRoundBufferInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_RoundBufferInfo)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.bufferId == nil then
        tbl.bufferIdSpecified = false
        tbl.bufferId = 0
    else
        tbl.bufferIdSpecified = true
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
    if tbl.isCenterPoint == nil then
        tbl.isCenterPointSpecified = false
        tbl.isCenterPoint = false
    else
        tbl.isCenterPointSpecified = true
    end
end

--region metatable mapV2.RoundPlayerInfo
---@type mapV2.RoundPlayerInfo
mapV2_adj.metatable_RoundPlayerInfo = {
    _ClassName = "mapV2.RoundPlayerInfo",
}
mapV2_adj.metatable_RoundPlayerInfo.__index = mapV2_adj.metatable_RoundPlayerInfo
--endregion

---@param tbl mapV2.RoundPlayerInfo 待调整的table数据
function mapV2_adj.AdjustRoundPlayerInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_RoundPlayerInfo)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
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
    if tbl.dir == nil then
        tbl.dirSpecified = false
        tbl.dir = 0
    else
        tbl.dirSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
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
    if tbl.inner == nil then
        tbl.innerSpecified = false
        tbl.inner = 0
    else
        tbl.innerSpecified = true
    end
    if tbl.innerMax == nil then
        tbl.innerMaxSpecified = false
        tbl.innerMax = 0
    else
        tbl.innerMaxSpecified = true
    end
    if tbl.teamId == nil then
        tbl.teamIdSpecified = false
        tbl.teamId = 0
    else
        tbl.teamIdSpecified = true
    end
    if tbl.master == nil then
        tbl.masterSpecified = false
        tbl.master = 0
    else
        tbl.masterSpecified = true
    end
    if tbl.equipBean == nil then
        tbl.equipBean = {}
    else
        if mapV2_adj.AdjustPerformerEquipBean ~= nil then
            for i = 1, #tbl.equipBean do
                mapV2_adj.AdjustPerformerEquipBean(tbl.equipBean[i])
            end
        end
    end
    if tbl.buffers == nil then
        tbl.buffers = {}
    else
        if adjustTable.fight_adj ~= nil and adjustTable.fight_adj.AdjustBufferInfo ~= nil then
            for i = 1, #tbl.buffers do
                adjustTable.fight_adj.AdjustBufferInfo(tbl.buffers[i])
            end
        end
    end
    if tbl.wing == nil then
        tbl.wingSpecified = false
        tbl.wing = 0
    else
        tbl.wingSpecified = true
    end
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
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
    if tbl.titleId == nil then
        tbl.titleIdSpecified = false
        tbl.titleId = 0
    else
        tbl.titleIdSpecified = true
    end
    if tbl.nbValue == nil then
        tbl.nbValueSpecified = false
        tbl.nbValue = 0
    else
        tbl.nbValueSpecified = true
    end
    if tbl.power == nil then
        tbl.powerSpecified = false
        tbl.power = 0
    else
        tbl.powerSpecified = true
    end
    if tbl.mp == nil then
        tbl.mpSpecified = false
        tbl.mp = 0
    else
        tbl.mpSpecified = true
    end
    if tbl.maxMp == nil then
        tbl.maxMpSpecified = false
        tbl.maxMp = 0
    else
        tbl.maxMpSpecified = true
    end
    if tbl.nbValueMax == nil then
        tbl.nbValueMaxSpecified = false
        tbl.nbValueMax = 0
    else
        tbl.nbValueMaxSpecified = true
    end
    if tbl.boxTime == nil then
        tbl.boxTimeSpecified = false
        tbl.boxTime = 0
    else
        tbl.boxTimeSpecified = true
    end
    if tbl.tokenCount == nil then
        tbl.tokenCountSpecified = false
        tbl.tokenCount = 0
    else
        tbl.tokenCountSpecified = true
    end
    if tbl.tokenCountId == nil then
        tbl.tokenCountIdSpecified = false
        tbl.tokenCountId = 0
    else
        tbl.tokenCountIdSpecified = true
    end
    if tbl.cavesPlayerInfo == nil then
        tbl.cavesPlayerInfoSpecified = false
        tbl.cavesPlayerInfo = nil
    else
        if tbl.cavesPlayerInfoSpecified == nil then 
            tbl.cavesPlayerInfoSpecified = true
            if adjustTable.duplicate_adj ~= nil and adjustTable.duplicate_adj.AdjustCavesPlayerInfo ~= nil then
                adjustTable.duplicate_adj.AdjustCavesPlayerInfo(tbl.cavesPlayerInfo)
            end
        end
    end
    if tbl.thisJunXianId == nil then
        tbl.thisJunXianIdSpecified = false
        tbl.thisJunXianId = 0
    else
        tbl.thisJunXianIdSpecified = true
    end
    if tbl.wearInfo == nil then
        tbl.wearInfo = {}
    else
        if adjustTable.appearance_adj ~= nil and adjustTable.appearance_adj.AdjustwearPosition ~= nil then
            for i = 1, #tbl.wearInfo do
                adjustTable.appearance_adj.AdjustwearPosition(tbl.wearInfo[i])
            end
        end
    end
    if tbl.servants == nil then
        tbl.servants = {}
    else
        if mapV2_adj.AdjustResServantInfo ~= nil then
            for i = 1, #tbl.servants do
                mapV2_adj.AdjustResServantInfo(tbl.servants[i])
            end
        end
    end
    if tbl.elementSuitId == nil then
        tbl.elementSuitIdSpecified = false
        tbl.elementSuitId = 0
    else
        tbl.elementSuitIdSpecified = true
    end
    if tbl.appellation == nil then
        tbl.appellationSpecified = false
        tbl.appellation = nil
    else
        if tbl.appellationSpecified == nil then 
            tbl.appellationSpecified = true
            if adjustTable.appearance_adj ~= nil and adjustTable.appearance_adj.AdjustTitleInfo ~= nil then
                adjustTable.appearance_adj.AdjustTitleInfo(tbl.appellation)
            end
        end
    end
    if tbl.spyInfo == nil then
        tbl.spyInfoSpecified = false
        tbl.spyInfo = nil
    else
        if tbl.spyInfoSpecified == nil then 
            tbl.spyInfoSpecified = true
            if mapV2_adj.AdjustRoundPlayerInfo ~= nil then
                mapV2_adj.AdjustRoundPlayerInfo(tbl.spyInfo)
            end
        end
    end
    if tbl.intensifySuitLevel == nil then
        tbl.intensifySuitLevelSpecified = false
        tbl.intensifySuitLevel = 0
    else
        tbl.intensifySuitLevelSpecified = true
    end
    if tbl.unionIcon == nil then
        tbl.unionIconSpecified = false
        tbl.unionIcon = 0
    else
        tbl.unionIconSpecified = true
    end
    if tbl.isSworn == nil then
        tbl.isSwornSpecified = false
        tbl.isSworn = 0
    else
        tbl.isSwornSpecified = true
    end
    if tbl.statSwornTime == nil then
        tbl.statSwornTimeSpecified = false
        tbl.statSwornTime = 0
    else
        tbl.statSwornTimeSpecified = true
    end
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.fightModel == nil then
        tbl.fightModelSpecified = false
        tbl.fightModel = 0
    else
        tbl.fightModelSpecified = true
    end
    if tbl.enterMapTime == nil then
        tbl.enterMapTimeSpecified = false
        tbl.enterMapTime = 0
    else
        tbl.enterMapTimeSpecified = true
    end
    if tbl.unionRank == nil then
        tbl.unionRankSpecified = false
        tbl.unionRank = 0
    else
        tbl.unionRankSpecified = true
    end
    if tbl.remoteHostId == nil then
        tbl.remoteHostIdSpecified = false
        tbl.remoteHostId = 0
    else
        tbl.remoteHostIdSpecified = true
    end
    if tbl.uniteUnionType == nil then
        tbl.uniteUnionTypeSpecified = false
        tbl.uniteUnionType = 0
    else
        tbl.uniteUnionTypeSpecified = true
    end
    if tbl.uniteUnionRank == nil then
        tbl.uniteUnionRankSpecified = false
        tbl.uniteUnionRank = 0
    else
        tbl.uniteUnionRankSpecified = true
    end
    if tbl.sealMarkId == nil then
        tbl.sealMarkIdSpecified = false
        tbl.sealMarkId = 0
    else
        tbl.sealMarkIdSpecified = true
    end
    if tbl.digTreasureState == nil then
        tbl.digTreasureStateSpecified = false
        tbl.digTreasureState = 0
    else
        tbl.digTreasureStateSpecified = true
    end
end

--region metatable mapV2.RoundMonsterInfo
---@type mapV2.RoundMonsterInfo
mapV2_adj.metatable_RoundMonsterInfo = {
    _ClassName = "mapV2.RoundMonsterInfo",
}
mapV2_adj.metatable_RoundMonsterInfo.__index = mapV2_adj.metatable_RoundMonsterInfo
--endregion

---@param tbl mapV2.RoundMonsterInfo 待调整的table数据
function mapV2_adj.AdjustRoundMonsterInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_RoundMonsterInfo)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.mid == nil then
        tbl.midSpecified = false
        tbl.mid = 0
    else
        tbl.midSpecified = true
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
    if tbl.dir == nil then
        tbl.dirSpecified = false
        tbl.dir = 0
    else
        tbl.dirSpecified = true
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
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.buffers == nil then
        tbl.buffers = {}
    else
        if adjustTable.fight_adj ~= nil and adjustTable.fight_adj.AdjustBufferInfo ~= nil then
            for i = 1, #tbl.buffers do
                adjustTable.fight_adj.AdjustBufferInfo(tbl.buffers[i])
            end
        end
    end
    if tbl.endAnimation == nil then
        tbl.endAnimationSpecified = false
        tbl.endAnimation = 0
    else
        tbl.endAnimationSpecified = true
    end
    if tbl.deathTime == nil then
        tbl.deathTimeSpecified = false
        tbl.deathTime = 0
    else
        tbl.deathTimeSpecified = true
    end
    if tbl.killId == nil then
        tbl.killIdSpecified = false
        tbl.killId = 0
    else
        tbl.killIdSpecified = true
    end
    if tbl.ownerId == nil then
        tbl.ownerIdSpecified = false
        tbl.ownerId = 0
    else
        tbl.ownerIdSpecified = true
    end
    if tbl.existenceTime == nil then
        tbl.existenceTimeSpecified = false
        tbl.existenceTime = 0
    else
        tbl.existenceTimeSpecified = true
    end
    if tbl.ownerName == nil then
        tbl.ownerNameSpecified = false
        tbl.ownerName = ""
    else
        tbl.ownerNameSpecified = true
    end
    if tbl.activeTime == nil then
        tbl.activeTimeSpecified = false
        tbl.activeTime = 0
    else
        tbl.activeTimeSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.moveInterval == nil then
        tbl.moveIntervalSpecified = false
        tbl.moveInterval = 0
    else
        tbl.moveIntervalSpecified = true
    end
    if tbl.collectionPoint == nil then
        tbl.collectionPointSpecified = false
        tbl.collectionPoint = ""
    else
        tbl.collectionPointSpecified = true
    end
    if tbl.exitActiveWarningTime == nil then
        tbl.exitActiveWarningTimeSpecified = false
        tbl.exitActiveWarningTime = 0
    else
        tbl.exitActiveWarningTimeSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.param == nil then
        tbl.paramSpecified = false
        tbl.param = 0
    else
        tbl.paramSpecified = true
    end
    if tbl.bowLordStartTime == nil then
        tbl.bowLordStartTimeSpecified = false
        tbl.bowLordStartTime = 0
    else
        tbl.bowLordStartTimeSpecified = true
    end
    if tbl.lockedBy == nil then
        tbl.lockedBySpecified = false
        tbl.lockedBy = 0
    else
        tbl.lockedBySpecified = true
    end
    if tbl.masterId == nil then
        tbl.masterIdSpecified = false
        tbl.masterId = 0
    else
        tbl.masterIdSpecified = true
    end
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
    if tbl.ownerTeamId == nil then
        tbl.ownerTeamIdSpecified = false
        tbl.ownerTeamId = 0
    else
        tbl.ownerTeamIdSpecified = true
    end
    if tbl.masterName == nil then
        tbl.masterNameSpecified = false
        tbl.masterName = ""
    else
        tbl.masterNameSpecified = true
    end
    if tbl.wakeUpCount == nil then
        tbl.wakeUpCountSpecified = false
        tbl.wakeUpCount = 0
    else
        tbl.wakeUpCountSpecified = true
    end
    if tbl.huntStatus == nil then
        tbl.huntStatusSpecified = false
        tbl.huntStatus = 0
    else
        tbl.huntStatusSpecified = true
    end
    if tbl.hostId == nil then
        tbl.hostIdSpecified = false
        tbl.hostId = 0
    else
        tbl.hostIdSpecified = true
    end
    if tbl.masterUniteUnionType == nil then
        tbl.masterUniteUnionTypeSpecified = false
        tbl.masterUniteUnionType = 0
    else
        tbl.masterUniteUnionTypeSpecified = true
    end
end

--region metatable mapV2.RoundNpcInfo
---@type mapV2.RoundNpcInfo
mapV2_adj.metatable_RoundNpcInfo = {
    _ClassName = "mapV2.RoundNpcInfo",
}
mapV2_adj.metatable_RoundNpcInfo.__index = mapV2_adj.metatable_RoundNpcInfo
--endregion

---@param tbl mapV2.RoundNpcInfo 待调整的table数据
function mapV2_adj.AdjustRoundNpcInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_RoundNpcInfo)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.nid == nil then
        tbl.nidSpecified = false
        tbl.nid = 0
    else
        tbl.nidSpecified = true
    end
    if tbl.mapNpcId == nil then
        tbl.mapNpcIdSpecified = false
        tbl.mapNpcId = 0
    else
        tbl.mapNpcIdSpecified = true
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
    if tbl.dir == nil then
        tbl.dirSpecified = false
        tbl.dir = 0
    else
        tbl.dirSpecified = true
    end
    if tbl.removeTime == nil then
        tbl.removeTimeSpecified = false
        tbl.removeTime = 0
    else
        tbl.removeTimeSpecified = true
    end
    if tbl.tombstoneMasterId == nil then
        tbl.tombstoneMasterIdSpecified = false
        tbl.tombstoneMasterId = 0
    else
        tbl.tombstoneMasterIdSpecified = true
    end
    if tbl.monsterConfigId == nil then
        tbl.monsterConfigIdSpecified = false
        tbl.monsterConfigId = 0
    else
        tbl.monsterConfigIdSpecified = true
    end
    if tbl.tombstoneType == nil then
        tbl.tombstoneTypeSpecified = false
        tbl.tombstoneType = 0
    else
        tbl.tombstoneTypeSpecified = true
    end
end

--region metatable mapV2.RoundPetInfo
---@type mapV2.RoundPetInfo
mapV2_adj.metatable_RoundPetInfo = {
    _ClassName = "mapV2.RoundPetInfo",
}
mapV2_adj.metatable_RoundPetInfo.__index = mapV2_adj.metatable_RoundPetInfo
--endregion

---@param tbl mapV2.RoundPetInfo 待调整的table数据
function mapV2_adj.AdjustRoundPetInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_RoundPetInfo)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.masterId == nil then
        tbl.masterIdSpecified = false
        tbl.masterId = 0
    else
        tbl.masterIdSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.mid == nil then
        tbl.midSpecified = false
        tbl.mid = 0
    else
        tbl.midSpecified = true
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
    if tbl.dir == nil then
        tbl.dirSpecified = false
        tbl.dir = 0
    else
        tbl.dirSpecified = true
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
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.buffers == nil then
        tbl.buffers = {}
    else
        if adjustTable.fight_adj ~= nil and adjustTable.fight_adj.AdjustBufferInfo ~= nil then
            for i = 1, #tbl.buffers do
                adjustTable.fight_adj.AdjustBufferInfo(tbl.buffers[i])
            end
        end
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
    if tbl.enterViewType == nil then
        tbl.enterViewTypeSpecified = false
        tbl.enterViewType = 0
    else
        tbl.enterViewTypeSpecified = true
    end
    if tbl.activeTime == nil then
        tbl.activeTimeSpecified = false
        tbl.activeTime = 0
    else
        tbl.activeTimeSpecified = true
    end
    if tbl.switchState == nil then
        tbl.switchStateSpecified = false
        tbl.switchState = 0
    else
        tbl.switchStateSpecified = true
    end
end

--region metatable mapV2.RoundHeroInfo
---@type mapV2.RoundHeroInfo
mapV2_adj.metatable_RoundHeroInfo = {
    _ClassName = "mapV2.RoundHeroInfo",
}
mapV2_adj.metatable_RoundHeroInfo.__index = mapV2_adj.metatable_RoundHeroInfo
--endregion

---@param tbl mapV2.RoundHeroInfo 待调整的table数据
function mapV2_adj.AdjustRoundHeroInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_RoundHeroInfo)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.masterId == nil then
        tbl.masterIdSpecified = false
        tbl.masterId = 0
    else
        tbl.masterIdSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
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
    if tbl.mid == nil then
        tbl.midSpecified = false
        tbl.mid = 0
    else
        tbl.midSpecified = true
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
    if tbl.dir == nil then
        tbl.dirSpecified = false
        tbl.dir = 0
    else
        tbl.dirSpecified = true
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
    if tbl.inner == nil then
        tbl.innerSpecified = false
        tbl.inner = 0
    else
        tbl.innerSpecified = true
    end
    if tbl.innerMax == nil then
        tbl.innerMaxSpecified = false
        tbl.innerMax = 0
    else
        tbl.innerMaxSpecified = true
    end
    if tbl.maBiRate == nil then
        tbl.maBiRateSpecified = false
        tbl.maBiRate = 0
    else
        tbl.maBiRateSpecified = true
    end
end

--region metatable mapV2.RoundServantInfo
---@type mapV2.RoundServantInfo
mapV2_adj.metatable_RoundServantInfo = {
    _ClassName = "mapV2.RoundServantInfo",
}
mapV2_adj.metatable_RoundServantInfo.__index = mapV2_adj.metatable_RoundServantInfo
--endregion

---@param tbl mapV2.RoundServantInfo 待调整的table数据
function mapV2_adj.AdjustRoundServantInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_RoundServantInfo)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.masterId == nil then
        tbl.masterIdSpecified = false
        tbl.masterId = 0
    else
        tbl.masterIdSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
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
    if tbl.mid == nil then
        tbl.midSpecified = false
        tbl.mid = 0
    else
        tbl.midSpecified = true
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
    if tbl.dir == nil then
        tbl.dirSpecified = false
        tbl.dir = 0
    else
        tbl.dirSpecified = true
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
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.weight == nil then
        tbl.weightSpecified = false
        tbl.weight = 0
    else
        tbl.weightSpecified = true
    end
    if tbl.enterViewType == nil then
        tbl.enterViewTypeSpecified = false
        tbl.enterViewType = 0
    else
        tbl.enterViewTypeSpecified = true
    end
    if tbl.buffers == nil then
        tbl.buffers = {}
    else
        if adjustTable.fight_adj ~= nil and adjustTable.fight_adj.AdjustBufferInfo ~= nil then
            for i = 1, #tbl.buffers do
                adjustTable.fight_adj.AdjustBufferInfo(tbl.buffers[i])
            end
        end
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
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
    if tbl.activeTime == nil then
        tbl.activeTimeSpecified = false
        tbl.activeTime = 0
    else
        tbl.activeTimeSpecified = true
    end
    if tbl.masterName == nil then
        tbl.masterNameSpecified = false
        tbl.masterName = ""
    else
        tbl.masterNameSpecified = true
    end
    if tbl.equippedSoul == nil then
        tbl.equippedSoulSpecified = false
        tbl.equippedSoul = 0
    else
        tbl.equippedSoulSpecified = true
    end
end

--region metatable mapV2.RoundServantCultivateInfo
---@type mapV2.RoundServantCultivateInfo
mapV2_adj.metatable_RoundServantCultivateInfo = {
    _ClassName = "mapV2.RoundServantCultivateInfo",
}
mapV2_adj.metatable_RoundServantCultivateInfo.__index = mapV2_adj.metatable_RoundServantCultivateInfo
--endregion

---@param tbl mapV2.RoundServantCultivateInfo 待调整的table数据
function mapV2_adj.AdjustRoundServantCultivateInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_RoundServantCultivateInfo)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.masterId == nil then
        tbl.masterIdSpecified = false
        tbl.masterId = 0
    else
        tbl.masterIdSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
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
    if tbl.mid == nil then
        tbl.midSpecified = false
        tbl.mid = 0
    else
        tbl.midSpecified = true
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
    if tbl.dir == nil then
        tbl.dirSpecified = false
        tbl.dir = 0
    else
        tbl.dirSpecified = true
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
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.weight == nil then
        tbl.weightSpecified = false
        tbl.weight = 0
    else
        tbl.weightSpecified = true
    end
    if tbl.enterViewType == nil then
        tbl.enterViewTypeSpecified = false
        tbl.enterViewType = 0
    else
        tbl.enterViewTypeSpecified = true
    end
    if tbl.buffers == nil then
        tbl.buffers = {}
    else
        if adjustTable.fight_adj ~= nil and adjustTable.fight_adj.AdjustBufferInfo ~= nil then
            for i = 1, #tbl.buffers do
                adjustTable.fight_adj.AdjustBufferInfo(tbl.buffers[i])
            end
        end
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
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
    if tbl.activeTime == nil then
        tbl.activeTimeSpecified = false
        tbl.activeTime = 0
    else
        tbl.activeTimeSpecified = true
    end
    if tbl.masterName == nil then
        tbl.masterNameSpecified = false
        tbl.masterName = ""
    else
        tbl.masterNameSpecified = true
    end
    if tbl.equippedSoul == nil then
        tbl.equippedSoulSpecified = false
        tbl.equippedSoul = 0
    else
        tbl.equippedSoulSpecified = true
    end
    if tbl.cultivateRate == nil then
        tbl.cultivateRateSpecified = false
        tbl.cultivateRate = 0
    else
        tbl.cultivateRateSpecified = true
    end
end

--region metatable mapV2.RoundCollectPoint
---@type mapV2.RoundCollectPoint
mapV2_adj.metatable_RoundCollectPoint = {
    _ClassName = "mapV2.RoundCollectPoint",
}
mapV2_adj.metatable_RoundCollectPoint.__index = mapV2_adj.metatable_RoundCollectPoint
--endregion

---@param tbl mapV2.RoundCollectPoint 待调整的table数据
function mapV2_adj.AdjustRoundCollectPoint(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_RoundCollectPoint)
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
    if tbl.configId == nil then
        tbl.configIdSpecified = false
        tbl.configId = 0
    else
        tbl.configIdSpecified = true
    end
    if tbl.range == nil then
        tbl.rangeSpecified = false
        tbl.range = 0
    else
        tbl.rangeSpecified = true
    end
    if tbl.crystalStatus == nil then
        tbl.crystalStatusSpecified = false
        tbl.crystalStatus = 0
    else
        tbl.crystalStatusSpecified = true
    end
    if tbl.crystalTombTime == nil then
        tbl.crystalTombTimeSpecified = false
        tbl.crystalTombTime = 0
    else
        tbl.crystalTombTimeSpecified = true
    end
end

--region metatable mapV2.RoundBoothInfo
---@type mapV2.RoundBoothInfo
mapV2_adj.metatable_RoundBoothInfo = {
    _ClassName = "mapV2.RoundBoothInfo",
}
mapV2_adj.metatable_RoundBoothInfo.__index = mapV2_adj.metatable_RoundBoothInfo
--endregion

---@param tbl mapV2.RoundBoothInfo 待调整的table数据
function mapV2_adj.AdjustRoundBoothInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_RoundBoothInfo)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
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
    if tbl.dir == nil then
        tbl.dirSpecified = false
        tbl.dir = 0
    else
        tbl.dirSpecified = true
    end
    if tbl.boothTypeId == nil then
        tbl.boothTypeIdSpecified = false
        tbl.boothTypeId = 0
    else
        tbl.boothTypeIdSpecified = true
    end
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
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
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.overdueTime == nil then
        tbl.overdueTimeSpecified = false
        tbl.overdueTime = 0
    else
        tbl.overdueTimeSpecified = true
    end
    if tbl.boothName == nil then
        tbl.boothNameSpecified = false
        tbl.boothName = ""
    else
        tbl.boothNameSpecified = true
    end
    if tbl.serverGropId == nil then
        tbl.serverGropIdSpecified = false
        tbl.serverGropId = 0
    else
        tbl.serverGropIdSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable mapV2.RoundBonfireInfo
---@type mapV2.RoundBonfireInfo
mapV2_adj.metatable_RoundBonfireInfo = {
    _ClassName = "mapV2.RoundBonfireInfo",
}
mapV2_adj.metatable_RoundBonfireInfo.__index = mapV2_adj.metatable_RoundBonfireInfo
--endregion

---@param tbl mapV2.RoundBonfireInfo 待调整的table数据
function mapV2_adj.AdjustRoundBonfireInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_RoundBonfireInfo)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
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
    if tbl.entTime == nil then
        tbl.entTimeSpecified = false
        tbl.entTime = 0
    else
        tbl.entTimeSpecified = true
    end
end

--region metatable mapV2.MapBoss
---@type mapV2.MapBoss
mapV2_adj.metatable_MapBoss = {
    _ClassName = "mapV2.MapBoss",
}
mapV2_adj.metatable_MapBoss.__index = mapV2_adj.metatable_MapBoss
--endregion

---@param tbl mapV2.MapBoss 待调整的table数据
function mapV2_adj.AdjustMapBoss(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_MapBoss)
    if tbl.bossId == nil then
        tbl.bossIdSpecified = false
        tbl.bossId = 0
    else
        tbl.bossIdSpecified = true
    end
    if tbl.mid == nil then
        tbl.midSpecified = false
        tbl.mid = 0
    else
        tbl.midSpecified = true
    end
    if tbl.bossHp == nil then
        tbl.bossHpSpecified = false
        tbl.bossHp = 0
    else
        tbl.bossHpSpecified = true
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

--region metatable mapV2.MonsterTomb
---@type mapV2.MonsterTomb
mapV2_adj.metatable_MonsterTomb = {
    _ClassName = "mapV2.MonsterTomb",
}
mapV2_adj.metatable_MonsterTomb.__index = mapV2_adj.metatable_MonsterTomb
--endregion

---@param tbl mapV2.MonsterTomb 待调整的table数据
function mapV2_adj.AdjustMonsterTomb(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_MonsterTomb)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.mid == nil then
        tbl.midSpecified = false
        tbl.mid = 0
    else
        tbl.midSpecified = true
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
    if tbl.nextReliveTime == nil then
        tbl.nextReliveTimeSpecified = false
        tbl.nextReliveTime = 0
    else
        tbl.nextReliveTimeSpecified = true
    end
end

--region metatable mapV2.ResUpdateView
---@type mapV2.ResUpdateView
mapV2_adj.metatable_ResUpdateView = {
    _ClassName = "mapV2.ResUpdateView",
}
mapV2_adj.metatable_ResUpdateView.__index = mapV2_adj.metatable_ResUpdateView
--endregion

---@param tbl mapV2.ResUpdateView 待调整的table数据
function mapV2_adj.AdjustResUpdateView(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResUpdateView)
    if tbl.addPlayers == nil then
        tbl.addPlayers = {}
    else
        if mapV2_adj.AdjustRoundPlayerInfo ~= nil then
            for i = 1, #tbl.addPlayers do
                mapV2_adj.AdjustRoundPlayerInfo(tbl.addPlayers[i])
            end
        end
    end
    if tbl.addMonsters == nil then
        tbl.addMonsters = {}
    else
        if mapV2_adj.AdjustRoundMonsterInfo ~= nil then
            for i = 1, #tbl.addMonsters do
                mapV2_adj.AdjustRoundMonsterInfo(tbl.addMonsters[i])
            end
        end
    end
    if tbl.addNpcs == nil then
        tbl.addNpcs = {}
    else
        if mapV2_adj.AdjustRoundNpcInfo ~= nil then
            for i = 1, #tbl.addNpcs do
                mapV2_adj.AdjustRoundNpcInfo(tbl.addNpcs[i])
            end
        end
    end
    if tbl.addBuffers == nil then
        tbl.addBuffers = {}
    else
        if mapV2_adj.AdjustRoundBufferInfo ~= nil then
            for i = 1, #tbl.addBuffers do
                mapV2_adj.AdjustRoundBufferInfo(tbl.addBuffers[i])
            end
        end
    end
    if tbl.addPets == nil then
        tbl.addPets = {}
    else
        if mapV2_adj.AdjustRoundPetInfo ~= nil then
            for i = 1, #tbl.addPets do
                mapV2_adj.AdjustRoundPetInfo(tbl.addPets[i])
            end
        end
    end
    if tbl.addHeros == nil then
        tbl.addHeros = {}
    else
        if mapV2_adj.AdjustRoundHeroInfo ~= nil then
            for i = 1, #tbl.addHeros do
                mapV2_adj.AdjustRoundHeroInfo(tbl.addHeros[i])
            end
        end
    end
    if tbl.addEvents == nil then
        tbl.addEvents = {}
    else
        if mapV2_adj.AdjustRoundEventInfo ~= nil then
            for i = 1, #tbl.addEvents do
                mapV2_adj.AdjustRoundEventInfo(tbl.addEvents[i])
            end
        end
    end
    if tbl.addItems == nil then
        tbl.addItems = {}
    else
        if mapV2_adj.AdjustRoundItemInfo ~= nil then
            for i = 1, #tbl.addItems do
                mapV2_adj.AdjustRoundItemInfo(tbl.addItems[i])
            end
        end
    end
    if tbl.exitIdList == nil then
        tbl.exitIdList = {}
    end
    if tbl.addServants == nil then
        tbl.addServants = {}
    else
        if mapV2_adj.AdjustRoundServantInfo ~= nil then
            for i = 1, #tbl.addServants do
                mapV2_adj.AdjustRoundServantInfo(tbl.addServants[i])
            end
        end
    end
    if tbl.collectPoint == nil then
        tbl.collectPoint = {}
    else
        if mapV2_adj.AdjustRoundCollectPoint ~= nil then
            for i = 1, #tbl.collectPoint do
                mapV2_adj.AdjustRoundCollectPoint(tbl.collectPoint[i])
            end
        end
    end
    if tbl.addBooths == nil then
        tbl.addBooths = {}
    else
        if mapV2_adj.AdjustRoundBoothInfo ~= nil then
            for i = 1, #tbl.addBooths do
                mapV2_adj.AdjustRoundBoothInfo(tbl.addBooths[i])
            end
        end
    end
    if tbl.addServantCultivates == nil then
        tbl.addServantCultivates = {}
    else
        if mapV2_adj.AdjustRoundServantCultivateInfo ~= nil then
            for i = 1, #tbl.addServantCultivates do
                mapV2_adj.AdjustRoundServantCultivateInfo(tbl.addServantCultivates[i])
            end
        end
    end
    if tbl.addBonfires == nil then
        tbl.addBonfires = {}
    else
        if mapV2_adj.AdjustRoundBonfireInfo ~= nil then
            for i = 1, #tbl.addBonfires do
                mapV2_adj.AdjustRoundBonfireInfo(tbl.addBonfires[i])
            end
        end
    end
end

--region metatable mapV2.ResPlayerEnterView
---@type mapV2.ResPlayerEnterView
mapV2_adj.metatable_ResPlayerEnterView = {
    _ClassName = "mapV2.ResPlayerEnterView",
}
mapV2_adj.metatable_ResPlayerEnterView.__index = mapV2_adj.metatable_ResPlayerEnterView
--endregion

---@param tbl mapV2.ResPlayerEnterView 待调整的table数据
function mapV2_adj.AdjustResPlayerEnterView(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResPlayerEnterView)
end

--region metatable mapV2.ResCollectEnterView
---@type mapV2.ResCollectEnterView
mapV2_adj.metatable_ResCollectEnterView = {
    _ClassName = "mapV2.ResCollectEnterView",
}
mapV2_adj.metatable_ResCollectEnterView.__index = mapV2_adj.metatable_ResCollectEnterView
--endregion

---@param tbl mapV2.ResCollectEnterView 待调整的table数据
function mapV2_adj.AdjustResCollectEnterView(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResCollectEnterView)
end

--region metatable mapV2.ResBufferEnterView
---@type mapV2.ResBufferEnterView
mapV2_adj.metatable_ResBufferEnterView = {
    _ClassName = "mapV2.ResBufferEnterView",
}
mapV2_adj.metatable_ResBufferEnterView.__index = mapV2_adj.metatable_ResBufferEnterView
--endregion

---@param tbl mapV2.ResBufferEnterView 待调整的table数据
function mapV2_adj.AdjustResBufferEnterView(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResBufferEnterView)
end

--region metatable mapV2.ResMonsterEnterView
---@type mapV2.ResMonsterEnterView
mapV2_adj.metatable_ResMonsterEnterView = {
    _ClassName = "mapV2.ResMonsterEnterView",
}
mapV2_adj.metatable_ResMonsterEnterView.__index = mapV2_adj.metatable_ResMonsterEnterView
--endregion

---@param tbl mapV2.ResMonsterEnterView 待调整的table数据
function mapV2_adj.AdjustResMonsterEnterView(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResMonsterEnterView)
end

--region metatable mapV2.ResNpcEnterView
---@type mapV2.ResNpcEnterView
mapV2_adj.metatable_ResNpcEnterView = {
    _ClassName = "mapV2.ResNpcEnterView",
}
mapV2_adj.metatable_ResNpcEnterView.__index = mapV2_adj.metatable_ResNpcEnterView
--endregion

---@param tbl mapV2.ResNpcEnterView 待调整的table数据
function mapV2_adj.AdjustResNpcEnterView(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResNpcEnterView)
end

--region metatable mapV2.ResPetEnterView
---@type mapV2.ResPetEnterView
mapV2_adj.metatable_ResPetEnterView = {
    _ClassName = "mapV2.ResPetEnterView",
}
mapV2_adj.metatable_ResPetEnterView.__index = mapV2_adj.metatable_ResPetEnterView
--endregion

---@param tbl mapV2.ResPetEnterView 待调整的table数据
function mapV2_adj.AdjustResPetEnterView(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResPetEnterView)
end

--region metatable mapV2.ResHeroEnterView
---@type mapV2.ResHeroEnterView
mapV2_adj.metatable_ResHeroEnterView = {
    _ClassName = "mapV2.ResHeroEnterView",
}
mapV2_adj.metatable_ResHeroEnterView.__index = mapV2_adj.metatable_ResHeroEnterView
--endregion

---@param tbl mapV2.ResHeroEnterView 待调整的table数据
function mapV2_adj.AdjustResHeroEnterView(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResHeroEnterView)
end

--region metatable mapV2.ResServantEnterView
---@type mapV2.ResServantEnterView
mapV2_adj.metatable_ResServantEnterView = {
    _ClassName = "mapV2.ResServantEnterView",
}
mapV2_adj.metatable_ResServantEnterView.__index = mapV2_adj.metatable_ResServantEnterView
--endregion

---@param tbl mapV2.ResServantEnterView 待调整的table数据
function mapV2_adj.AdjustResServantEnterView(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResServantEnterView)
end

--region metatable mapV2.ResServantCultivateEnterView
---@type mapV2.ResServantCultivateEnterView
mapV2_adj.metatable_ResServantCultivateEnterView = {
    _ClassName = "mapV2.ResServantCultivateEnterView",
}
mapV2_adj.metatable_ResServantCultivateEnterView.__index = mapV2_adj.metatable_ResServantCultivateEnterView
--endregion

---@param tbl mapV2.ResServantCultivateEnterView 待调整的table数据
function mapV2_adj.AdjustResServantCultivateEnterView(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResServantCultivateEnterView)
end

--region metatable mapV2.ResBoothEnterView
---@type mapV2.ResBoothEnterView
mapV2_adj.metatable_ResBoothEnterView = {
    _ClassName = "mapV2.ResBoothEnterView",
}
mapV2_adj.metatable_ResBoothEnterView.__index = mapV2_adj.metatable_ResBoothEnterView
--endregion

---@param tbl mapV2.ResBoothEnterView 待调整的table数据
function mapV2_adj.AdjustResBoothEnterView(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResBoothEnterView)
end

--region metatable mapV2.ResBonfireEnterView
---@type mapV2.ResBonfireEnterView
mapV2_adj.metatable_ResBonfireEnterView = {
    _ClassName = "mapV2.ResBonfireEnterView",
}
mapV2_adj.metatable_ResBonfireEnterView.__index = mapV2_adj.metatable_ResBonfireEnterView
--endregion

---@param tbl mapV2.ResBonfireEnterView 待调整的table数据
function mapV2_adj.AdjustResBonfireEnterView(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResBonfireEnterView)
end

--region metatable mapV2.ResMapObjectExitView
---@type mapV2.ResMapObjectExitView
mapV2_adj.metatable_ResMapObjectExitView = {
    _ClassName = "mapV2.ResMapObjectExitView",
}
mapV2_adj.metatable_ResMapObjectExitView.__index = mapV2_adj.metatable_ResMapObjectExitView
--endregion

---@param tbl mapV2.ResMapObjectExitView 待调整的table数据
function mapV2_adj.AdjustResMapObjectExitView(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResMapObjectExitView)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
end

--region metatable mapV2.ResPlayerEnterMap
---@type mapV2.ResPlayerEnterMap
mapV2_adj.metatable_ResPlayerEnterMap = {
    _ClassName = "mapV2.ResPlayerEnterMap",
}
mapV2_adj.metatable_ResPlayerEnterMap.__index = mapV2_adj.metatable_ResPlayerEnterMap
--endregion

---@param tbl mapV2.ResPlayerEnterMap 待调整的table数据
function mapV2_adj.AdjustResPlayerEnterMap(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResPlayerEnterMap)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
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
    if tbl.dir == nil then
        tbl.dirSpecified = false
        tbl.dir = 0
    else
        tbl.dirSpecified = true
    end
    if tbl.hp == nil then
        tbl.hpSpecified = false
        tbl.hp = 0
    else
        tbl.hpSpecified = true
    end
    if tbl.mp == nil then
        tbl.mpSpecified = false
        tbl.mp = 0
    else
        tbl.mpSpecified = true
    end
    if tbl.remoteHostId == nil then
        tbl.remoteHostIdSpecified = false
        tbl.remoteHostId = 0
    else
        tbl.remoteHostIdSpecified = true
    end
    if tbl.uniteUnionType == nil then
        tbl.uniteUnionTypeSpecified = false
        tbl.uniteUnionType = 0
    else
        tbl.uniteUnionTypeSpecified = true
    end
end

--region metatable mapV2.ResPlayerChangeMap
---@type mapV2.ResPlayerChangeMap
mapV2_adj.metatable_ResPlayerChangeMap = {
    _ClassName = "mapV2.ResPlayerChangeMap",
}
mapV2_adj.metatable_ResPlayerChangeMap.__index = mapV2_adj.metatable_ResPlayerChangeMap
--endregion

---@param tbl mapV2.ResPlayerChangeMap 待调整的table数据
function mapV2_adj.AdjustResPlayerChangeMap(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResPlayerChangeMap)
    if tbl.mid == nil then
        tbl.midSpecified = false
        tbl.mid = 0
    else
        tbl.midSpecified = true
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
    if tbl.reason == nil then
        tbl.reasonSpecified = false
        tbl.reason = 0
    else
        tbl.reasonSpecified = true
    end
    if tbl.reasonParam == nil then
        tbl.reasonParamSpecified = false
        tbl.reasonParam = 0
    else
        tbl.reasonParamSpecified = true
    end
end

--region metatable mapV2.ResChangePos
---@type mapV2.ResChangePos
mapV2_adj.metatable_ResChangePos = {
    _ClassName = "mapV2.ResChangePos",
}
mapV2_adj.metatable_ResChangePos.__index = mapV2_adj.metatable_ResChangePos
--endregion

---@param tbl mapV2.ResChangePos 待调整的table数据
function mapV2_adj.AdjustResChangePos(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResChangePos)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
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
    if tbl.reason == nil then
        tbl.reasonSpecified = false
        tbl.reason = 0
    else
        tbl.reasonSpecified = true
    end
    if tbl.reasonParam == nil then
        tbl.reasonParamSpecified = false
        tbl.reasonParam = 0
    else
        tbl.reasonParamSpecified = true
    end
end

--region metatable mapV2.ResObjectMove
---@type mapV2.ResObjectMove
mapV2_adj.metatable_ResObjectMove = {
    _ClassName = "mapV2.ResObjectMove",
}
mapV2_adj.metatable_ResObjectMove.__index = mapV2_adj.metatable_ResObjectMove
--endregion

---@param tbl mapV2.ResObjectMove 待调整的table数据
function mapV2_adj.AdjustResObjectMove(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResObjectMove)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
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

--region metatable mapV2.ResEventEnterView
---@type mapV2.ResEventEnterView
mapV2_adj.metatable_ResEventEnterView = {
    _ClassName = "mapV2.ResEventEnterView",
}
mapV2_adj.metatable_ResEventEnterView.__index = mapV2_adj.metatable_ResEventEnterView
--endregion

---@param tbl mapV2.ResEventEnterView 待调整的table数据
function mapV2_adj.AdjustResEventEnterView(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResEventEnterView)
    if tbl.info == nil then
        tbl.infoSpecified = false
        tbl.info = nil
    else
        if tbl.infoSpecified == nil then 
            tbl.infoSpecified = true
            if mapV2_adj.AdjustRoundEventInfo ~= nil then
                mapV2_adj.AdjustRoundEventInfo(tbl.info)
            end
        end
    end
end

--region metatable mapV2.ResRelive
---@type mapV2.ResRelive
mapV2_adj.metatable_ResRelive = {
    _ClassName = "mapV2.ResRelive",
}
mapV2_adj.metatable_ResRelive.__index = mapV2_adj.metatable_ResRelive
--endregion

---@param tbl mapV2.ResRelive 待调整的table数据
function mapV2_adj.AdjustResRelive(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResRelive)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.hp == nil then
        tbl.hpSpecified = false
        tbl.hp = 0
    else
        tbl.hpSpecified = true
    end
    if tbl.mp == nil then
        tbl.mpSpecified = false
        tbl.mp = 0
    else
        tbl.mpSpecified = true
    end
    if tbl.inner == nil then
        tbl.innerSpecified = false
        tbl.inner = 0
    else
        tbl.innerSpecified = true
    end
    if tbl.reliveType == nil then
        tbl.reliveTypeSpecified = false
        tbl.reliveType = 0
    else
        tbl.reliveTypeSpecified = true
    end
    if tbl.powerRankPercent == nil then
        tbl.powerRankPercentSpecified = false
        tbl.powerRankPercent = 0
    else
        tbl.powerRankPercentSpecified = true
    end
end

--region metatable mapV2.ResItemEnterView
---@type mapV2.ResItemEnterView
mapV2_adj.metatable_ResItemEnterView = {
    _ClassName = "mapV2.ResItemEnterView",
}
mapV2_adj.metatable_ResItemEnterView.__index = mapV2_adj.metatable_ResItemEnterView
--endregion

---@param tbl mapV2.ResItemEnterView 待调整的table数据
function mapV2_adj.AdjustResItemEnterView(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResItemEnterView)
    if tbl.info == nil then
        tbl.infoSpecified = false
        tbl.info = nil
    else
        if tbl.infoSpecified == nil then 
            tbl.infoSpecified = true
            if mapV2_adj.AdjustRoundItemInfo ~= nil then
                mapV2_adj.AdjustRoundItemInfo(tbl.info)
            end
        end
    end
end

--region metatable mapV2.ResUpdateEquip
---@type mapV2.ResUpdateEquip
mapV2_adj.metatable_ResUpdateEquip = {
    _ClassName = "mapV2.ResUpdateEquip",
}
mapV2_adj.metatable_ResUpdateEquip.__index = mapV2_adj.metatable_ResUpdateEquip
--endregion

---@param tbl mapV2.ResUpdateEquip 待调整的table数据
function mapV2_adj.AdjustResUpdateEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResUpdateEquip)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.equip == nil then
        tbl.equipSpecified = false
        tbl.equip = nil
    else
        if tbl.equipSpecified == nil then 
            tbl.equipSpecified = true
            if mapV2_adj.AdjustPerformerEquipBean ~= nil then
                mapV2_adj.AdjustPerformerEquipBean(tbl.equip)
            end
        end
    end
end

--region metatable mapV2.TryEnterMapRequest
---@type mapV2.TryEnterMapRequest
mapV2_adj.metatable_TryEnterMapRequest = {
    _ClassName = "mapV2.TryEnterMapRequest",
}
mapV2_adj.metatable_TryEnterMapRequest.__index = mapV2_adj.metatable_TryEnterMapRequest
--endregion

---@param tbl mapV2.TryEnterMapRequest 待调整的table数据
function mapV2_adj.AdjustTryEnterMapRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_TryEnterMapRequest)
end

--region metatable mapV2.ResTryEnterMap
---@type mapV2.ResTryEnterMap
mapV2_adj.metatable_ResTryEnterMap = {
    _ClassName = "mapV2.ResTryEnterMap",
}
mapV2_adj.metatable_ResTryEnterMap.__index = mapV2_adj.metatable_ResTryEnterMap
--endregion

---@param tbl mapV2.ResTryEnterMap 待调整的table数据
function mapV2_adj.AdjustResTryEnterMap(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResTryEnterMap)
    if tbl.reconnect == nil then
        tbl.reconnectSpecified = false
        tbl.reconnect = false
    else
        tbl.reconnectSpecified = true
    end
end

--region metatable mapV2.ResChangePlayer
---@type mapV2.ResChangePlayer
mapV2_adj.metatable_ResChangePlayer = {
    _ClassName = "mapV2.ResChangePlayer",
}
mapV2_adj.metatable_ResChangePlayer.__index = mapV2_adj.metatable_ResChangePlayer
--endregion

---@param tbl mapV2.ResChangePlayer 待调整的table数据
function mapV2_adj.AdjustResChangePlayer(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResChangePlayer)
end

--region metatable mapV2.ResReplacePlayer
---@type mapV2.ResReplacePlayer
mapV2_adj.metatable_ResReplacePlayer = {
    _ClassName = "mapV2.ResReplacePlayer",
}
mapV2_adj.metatable_ResReplacePlayer.__index = mapV2_adj.metatable_ResReplacePlayer
--endregion

---@param tbl mapV2.ResReplacePlayer 待调整的table数据
function mapV2_adj.AdjustResReplacePlayer(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResReplacePlayer)
end

--region metatable mapV2.ResBossOwner
---@type mapV2.ResBossOwner
mapV2_adj.metatable_ResBossOwner = {
    _ClassName = "mapV2.ResBossOwner",
}
mapV2_adj.metatable_ResBossOwner.__index = mapV2_adj.metatable_ResBossOwner
--endregion

---@param tbl mapV2.ResBossOwner 待调整的table数据
function mapV2_adj.AdjustResBossOwner(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResBossOwner)
    if tbl.bossId == nil then
        tbl.bossIdSpecified = false
        tbl.bossId = 0
    else
        tbl.bossIdSpecified = true
    end
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
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

--region metatable mapV2.ResIntensifySuitChange
---@type mapV2.ResIntensifySuitChange
mapV2_adj.metatable_ResIntensifySuitChange = {
    _ClassName = "mapV2.ResIntensifySuitChange",
}
mapV2_adj.metatable_ResIntensifySuitChange.__index = mapV2_adj.metatable_ResIntensifySuitChange
--endregion

---@param tbl mapV2.ResIntensifySuitChange 待调整的table数据
function mapV2_adj.AdjustResIntensifySuitChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResIntensifySuitChange)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
end

--region metatable mapV2.ResPlayerWingChange
---@type mapV2.ResPlayerWingChange
mapV2_adj.metatable_ResPlayerWingChange = {
    _ClassName = "mapV2.ResPlayerWingChange",
}
mapV2_adj.metatable_ResPlayerWingChange.__index = mapV2_adj.metatable_ResPlayerWingChange
--endregion

---@param tbl mapV2.ResPlayerWingChange 待调整的table数据
function mapV2_adj.AdjustResPlayerWingChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResPlayerWingChange)
end

--region metatable mapV2.ResPlayerUnionChange
---@type mapV2.ResPlayerUnionChange
mapV2_adj.metatable_ResPlayerUnionChange = {
    _ClassName = "mapV2.ResPlayerUnionChange",
}
mapV2_adj.metatable_ResPlayerUnionChange.__index = mapV2_adj.metatable_ResPlayerUnionChange
--endregion

---@param tbl mapV2.ResPlayerUnionChange 待调整的table数据
function mapV2_adj.AdjustResPlayerUnionChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResPlayerUnionChange)
end

--region metatable mapV2.PlayerReliveRequest
---@type mapV2.PlayerReliveRequest
mapV2_adj.metatable_PlayerReliveRequest = {
    _ClassName = "mapV2.PlayerReliveRequest",
}
mapV2_adj.metatable_PlayerReliveRequest.__index = mapV2_adj.metatable_PlayerReliveRequest
--endregion

---@param tbl mapV2.PlayerReliveRequest 待调整的table数据
function mapV2_adj.AdjustPlayerReliveRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_PlayerReliveRequest)
end

--region metatable mapV2.ResPlayerReliveInfo
---@type mapV2.ResPlayerReliveInfo
mapV2_adj.metatable_ResPlayerReliveInfo = {
    _ClassName = "mapV2.ResPlayerReliveInfo",
}
mapV2_adj.metatable_ResPlayerReliveInfo.__index = mapV2_adj.metatable_ResPlayerReliveInfo
--endregion

---@param tbl mapV2.ResPlayerReliveInfo 待调整的table数据
function mapV2_adj.AdjustResPlayerReliveInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResPlayerReliveInfo)
end

--region metatable mapV2.ResPlayerFashionChange
---@type mapV2.ResPlayerFashionChange
mapV2_adj.metatable_ResPlayerFashionChange = {
    _ClassName = "mapV2.ResPlayerFashionChange",
}
mapV2_adj.metatable_ResPlayerFashionChange.__index = mapV2_adj.metatable_ResPlayerFashionChange
--endregion

---@param tbl mapV2.ResPlayerFashionChange 待调整的table数据
function mapV2_adj.AdjustResPlayerFashionChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResPlayerFashionChange)
end

--region metatable mapV2.ResPlayerJunxianChange
---@type mapV2.ResPlayerJunxianChange
mapV2_adj.metatable_ResPlayerJunxianChange = {
    _ClassName = "mapV2.ResPlayerJunxianChange",
}
mapV2_adj.metatable_ResPlayerJunxianChange.__index = mapV2_adj.metatable_ResPlayerJunxianChange
--endregion

---@param tbl mapV2.ResPlayerJunxianChange 待调整的table数据
function mapV2_adj.AdjustResPlayerJunxianChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResPlayerJunxianChange)
end

--region metatable mapV2.SwitchFightModelRequest
---@type mapV2.SwitchFightModelRequest
mapV2_adj.metatable_SwitchFightModelRequest = {
    _ClassName = "mapV2.SwitchFightModelRequest",
}
mapV2_adj.metatable_SwitchFightModelRequest.__index = mapV2_adj.metatable_SwitchFightModelRequest
--endregion

---@param tbl mapV2.SwitchFightModelRequest 待调整的table数据
function mapV2_adj.AdjustSwitchFightModelRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_SwitchFightModelRequest)
end

--region metatable mapV2.ResSwitchFightModel
---@type mapV2.ResSwitchFightModel
mapV2_adj.metatable_ResSwitchFightModel = {
    _ClassName = "mapV2.ResSwitchFightModel",
}
mapV2_adj.metatable_ResSwitchFightModel.__index = mapV2_adj.metatable_ResSwitchFightModel
--endregion

---@param tbl mapV2.ResSwitchFightModel 待调整的table数据
function mapV2_adj.AdjustResSwitchFightModel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResSwitchFightModel)
end

--region metatable mapV2.PickUpMapItemRequest
---@type mapV2.PickUpMapItemRequest
mapV2_adj.metatable_PickUpMapItemRequest = {
    _ClassName = "mapV2.PickUpMapItemRequest",
}
mapV2_adj.metatable_PickUpMapItemRequest.__index = mapV2_adj.metatable_PickUpMapItemRequest
--endregion

---@param tbl mapV2.PickUpMapItemRequest 待调整的table数据
function mapV2_adj.AdjustPickUpMapItemRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_PickUpMapItemRequest)
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
end

--region metatable mapV2.PickUpMapItemsRequest
---@type mapV2.PickUpMapItemsRequest
mapV2_adj.metatable_PickUpMapItemsRequest = {
    _ClassName = "mapV2.PickUpMapItemsRequest",
}
mapV2_adj.metatable_PickUpMapItemsRequest.__index = mapV2_adj.metatable_PickUpMapItemsRequest
--endregion

---@param tbl mapV2.PickUpMapItemsRequest 待调整的table数据
function mapV2_adj.AdjustPickUpMapItemsRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_PickUpMapItemsRequest)
    if tbl.objId == nil then
        tbl.objId = {}
    end
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
end

--region metatable mapV2.ResNoticeViewTypeInfo
---@type mapV2.ResNoticeViewTypeInfo
mapV2_adj.metatable_ResNoticeViewTypeInfo = {
    _ClassName = "mapV2.ResNoticeViewTypeInfo",
}
mapV2_adj.metatable_ResNoticeViewTypeInfo.__index = mapV2_adj.metatable_ResNoticeViewTypeInfo
--endregion

---@param tbl mapV2.ResNoticeViewTypeInfo 待调整的table数据
function mapV2_adj.AdjustResNoticeViewTypeInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResNoticeViewTypeInfo)
    if tbl.updateList == nil then
        tbl.updateList = {}
    else
        if mapV2_adj.AdjustNoticeBean ~= nil then
            for i = 1, #tbl.updateList do
                mapV2_adj.AdjustNoticeBean(tbl.updateList[i])
            end
        end
    end
end

--region metatable mapV2.ResAllPerformerTotalHp
---@type mapV2.ResAllPerformerTotalHp
mapV2_adj.metatable_ResAllPerformerTotalHp = {
    _ClassName = "mapV2.ResAllPerformerTotalHp",
}
mapV2_adj.metatable_ResAllPerformerTotalHp.__index = mapV2_adj.metatable_ResAllPerformerTotalHp
--endregion

---@param tbl mapV2.ResAllPerformerTotalHp 待调整的table数据
function mapV2_adj.AdjustResAllPerformerTotalHp(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResAllPerformerTotalHp)
    if tbl.mapBossList == nil then
        tbl.mapBossList = {}
    else
        if mapV2_adj.AdjustMapBoss ~= nil then
            for i = 1, #tbl.mapBossList do
                mapV2_adj.AdjustMapBoss(tbl.mapBossList[i])
            end
        end
    end
    if tbl.playerId == nil then
        tbl.playerId = {}
    end
    if tbl.percent == nil then
        tbl.percent = {}
    end
    if tbl.percentIp == nil then
        tbl.percentIp = {}
    end
end

--region metatable mapV2.ResPressureValue
---@type mapV2.ResPressureValue
mapV2_adj.metatable_ResPressureValue = {
    _ClassName = "mapV2.ResPressureValue",
}
mapV2_adj.metatable_ResPressureValue.__index = mapV2_adj.metatable_ResPressureValue
--endregion

---@param tbl mapV2.ResPressureValue 待调整的table数据
function mapV2_adj.AdjustResPressureValue(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResPressureValue)
end

--region metatable mapV2.BossOwnerRequest
---@type mapV2.BossOwnerRequest
mapV2_adj.metatable_BossOwnerRequest = {
    _ClassName = "mapV2.BossOwnerRequest",
}
mapV2_adj.metatable_BossOwnerRequest.__index = mapV2_adj.metatable_BossOwnerRequest
--endregion

---@param tbl mapV2.BossOwnerRequest 待调整的table数据
function mapV2_adj.AdjustBossOwnerRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_BossOwnerRequest)
end

--region metatable mapV2.BossReliveTime
---@type mapV2.BossReliveTime
mapV2_adj.metatable_BossReliveTime = {
    _ClassName = "mapV2.BossReliveTime",
}
mapV2_adj.metatable_BossReliveTime.__index = mapV2_adj.metatable_BossReliveTime
--endregion

---@param tbl mapV2.BossReliveTime 待调整的table数据
function mapV2_adj.AdjustBossReliveTime(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_BossReliveTime)
end

--region metatable mapV2.ResPlayerSzSuitChange
---@type mapV2.ResPlayerSzSuitChange
mapV2_adj.metatable_ResPlayerSzSuitChange = {
    _ClassName = "mapV2.ResPlayerSzSuitChange",
}
mapV2_adj.metatable_ResPlayerSzSuitChange.__index = mapV2_adj.metatable_ResPlayerSzSuitChange
--endregion

---@param tbl mapV2.ResPlayerSzSuitChange 待调整的table数据
function mapV2_adj.AdjustResPlayerSzSuitChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResPlayerSzSuitChange)
end

--region metatable mapV2.ResPlayerLegendChange
---@type mapV2.ResPlayerLegendChange
mapV2_adj.metatable_ResPlayerLegendChange = {
    _ClassName = "mapV2.ResPlayerLegendChange",
}
mapV2_adj.metatable_ResPlayerLegendChange.__index = mapV2_adj.metatable_ResPlayerLegendChange
--endregion

---@param tbl mapV2.ResPlayerLegendChange 待调整的table数据
function mapV2_adj.AdjustResPlayerLegendChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResPlayerLegendChange)
end

--region metatable mapV2.ResTombInfo
---@type mapV2.ResTombInfo
mapV2_adj.metatable_ResTombInfo = {
    _ClassName = "mapV2.ResTombInfo",
}
mapV2_adj.metatable_ResTombInfo.__index = mapV2_adj.metatable_ResTombInfo
--endregion

---@param tbl mapV2.ResTombInfo 待调整的table数据
function mapV2_adj.AdjustResTombInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResTombInfo)
    if tbl.tombInfos == nil then
        tbl.tombInfos = {}
    else
        if mapV2_adj.AdjustMonsterTomb ~= nil then
            for i = 1, #tbl.tombInfos do
                mapV2_adj.AdjustMonsterTomb(tbl.tombInfos[i])
            end
        end
    end
end

--region metatable mapV2.GatherOperatorRequest
---@type mapV2.GatherOperatorRequest
mapV2_adj.metatable_GatherOperatorRequest = {
    _ClassName = "mapV2.GatherOperatorRequest",
}
mapV2_adj.metatable_GatherOperatorRequest.__index = mapV2_adj.metatable_GatherOperatorRequest
--endregion

---@param tbl mapV2.GatherOperatorRequest 待调整的table数据
function mapV2_adj.AdjustGatherOperatorRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_GatherOperatorRequest)
    if tbl.consumeType == nil then
        tbl.consumeTypeSpecified = false
        tbl.consumeType = 0
    else
        tbl.consumeTypeSpecified = true
    end
    if tbl.isAutomatic == nil then
        tbl.isAutomaticSpecified = false
        tbl.isAutomatic = 0
    else
        tbl.isAutomaticSpecified = true
    end
end

--region metatable mapV2.ResGatherState
---@type mapV2.ResGatherState
mapV2_adj.metatable_ResGatherState = {
    _ClassName = "mapV2.ResGatherState",
}
mapV2_adj.metatable_ResGatherState.__index = mapV2_adj.metatable_ResGatherState
--endregion

---@param tbl mapV2.ResGatherState 待调整的table数据
function mapV2_adj.AdjustResGatherState(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResGatherState)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
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
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.isMonster == nil then
        tbl.isMonsterSpecified = false
        tbl.isMonster = false
    else
        tbl.isMonsterSpecified = true
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
    if tbl.deadTime == nil then
        tbl.deadTimeSpecified = false
        tbl.deadTime = 0
    else
        tbl.deadTimeSpecified = true
    end
    if tbl.ownerId == nil then
        tbl.ownerIdSpecified = false
        tbl.ownerId = 0
    else
        tbl.ownerIdSpecified = true
    end
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
end

--region metatable mapV2.ReqClickEvent
---@type mapV2.ReqClickEvent
mapV2_adj.metatable_ReqClickEvent = {
    _ClassName = "mapV2.ReqClickEvent",
}
mapV2_adj.metatable_ReqClickEvent.__index = mapV2_adj.metatable_ReqClickEvent
--endregion

---@param tbl mapV2.ReqClickEvent 待调整的table数据
function mapV2_adj.AdjustReqClickEvent(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ReqClickEvent)
end

--region metatable mapV2.ResObjectDeadTime
---@type mapV2.ResObjectDeadTime
mapV2_adj.metatable_ResObjectDeadTime = {
    _ClassName = "mapV2.ResObjectDeadTime",
}
mapV2_adj.metatable_ResObjectDeadTime.__index = mapV2_adj.metatable_ResObjectDeadTime
--endregion

---@param tbl mapV2.ResObjectDeadTime 待调整的table数据
function mapV2_adj.AdjustResObjectDeadTime(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResObjectDeadTime)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.killid == nil then
        tbl.killidSpecified = false
        tbl.killid = 0
    else
        tbl.killidSpecified = true
    end
    if tbl.killName == nil then
        tbl.killNameSpecified = false
        tbl.killName = ""
    else
        tbl.killNameSpecified = true
    end
    if tbl.deadTime == nil then
        tbl.deadTimeSpecified = false
        tbl.deadTime = 0
    else
        tbl.deadTimeSpecified = true
    end
    if tbl.canCollection == nil then
        tbl.canCollectionSpecified = false
        tbl.canCollection = 0
    else
        tbl.canCollectionSpecified = true
    end
end

--region metatable mapV2.WarningSkillInfo
---@type mapV2.WarningSkillInfo
mapV2_adj.metatable_WarningSkillInfo = {
    _ClassName = "mapV2.WarningSkillInfo",
}
mapV2_adj.metatable_WarningSkillInfo.__index = mapV2_adj.metatable_WarningSkillInfo
--endregion

---@param tbl mapV2.WarningSkillInfo 待调整的table数据
function mapV2_adj.AdjustWarningSkillInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_WarningSkillInfo)
end

--region metatable mapV2.ReqAnimalNPCInfo
---@type mapV2.ReqAnimalNPCInfo
mapV2_adj.metatable_ReqAnimalNPCInfo = {
    _ClassName = "mapV2.ReqAnimalNPCInfo",
}
mapV2_adj.metatable_ReqAnimalNPCInfo.__index = mapV2_adj.metatable_ReqAnimalNPCInfo
--endregion

---@param tbl mapV2.ReqAnimalNPCInfo 待调整的table数据
function mapV2_adj.AdjustReqAnimalNPCInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ReqAnimalNPCInfo)
    if tbl.npcId == nil then
        tbl.npcIdSpecified = false
        tbl.npcId = 0
    else
        tbl.npcIdSpecified = true
    end
end

--region metatable mapV2.ResAnimalNPCInfo
---@type mapV2.ResAnimalNPCInfo
mapV2_adj.metatable_ResAnimalNPCInfo = {
    _ClassName = "mapV2.ResAnimalNPCInfo",
}
mapV2_adj.metatable_ResAnimalNPCInfo.__index = mapV2_adj.metatable_ResAnimalNPCInfo
--endregion

---@param tbl mapV2.ResAnimalNPCInfo 待调整的table数据
function mapV2_adj.AdjustResAnimalNPCInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResAnimalNPCInfo)
    if tbl.monsterId == nil then
        tbl.monsterIdSpecified = false
        tbl.monsterId = 0
    else
        tbl.monsterIdSpecified = true
    end
    if tbl.duration == nil then
        tbl.durationSpecified = false
        tbl.duration = 0
    else
        tbl.durationSpecified = true
    end
    if tbl.num == nil then
        tbl.numSpecified = false
        tbl.num = 0
    else
        tbl.numSpecified = true
    end
end

--region metatable mapV2.EnterNumRefresh
---@type mapV2.EnterNumRefresh
mapV2_adj.metatable_EnterNumRefresh = {
    _ClassName = "mapV2.EnterNumRefresh",
}
mapV2_adj.metatable_EnterNumRefresh.__index = mapV2_adj.metatable_EnterNumRefresh
--endregion

---@param tbl mapV2.EnterNumRefresh 待调整的table数据
function mapV2_adj.AdjustEnterNumRefresh(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_EnterNumRefresh)
    if tbl.npcId == nil then
        tbl.npcIdSpecified = false
        tbl.npcId = 0
    else
        tbl.npcIdSpecified = true
    end
    if tbl.num == nil then
        tbl.numSpecified = false
        tbl.num = 0
    else
        tbl.numSpecified = true
    end
end

--region metatable mapV2.ReqSkyAngerGodInfo
---@type mapV2.ReqSkyAngerGodInfo
mapV2_adj.metatable_ReqSkyAngerGodInfo = {
    _ClassName = "mapV2.ReqSkyAngerGodInfo",
}
mapV2_adj.metatable_ReqSkyAngerGodInfo.__index = mapV2_adj.metatable_ReqSkyAngerGodInfo
--endregion

---@param tbl mapV2.ReqSkyAngerGodInfo 待调整的table数据
function mapV2_adj.AdjustReqSkyAngerGodInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ReqSkyAngerGodInfo)
    if tbl.npcId == nil then
        tbl.npcIdSpecified = false
        tbl.npcId = 0
    else
        tbl.npcIdSpecified = true
    end
end

--region metatable mapV2.ResSkyAngerGodInfo
---@type mapV2.ResSkyAngerGodInfo
mapV2_adj.metatable_ResSkyAngerGodInfo = {
    _ClassName = "mapV2.ResSkyAngerGodInfo",
}
mapV2_adj.metatable_ResSkyAngerGodInfo.__index = mapV2_adj.metatable_ResSkyAngerGodInfo
--endregion

---@param tbl mapV2.ResSkyAngerGodInfo 待调整的table数据
function mapV2_adj.AdjustResSkyAngerGodInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResSkyAngerGodInfo)
    if tbl.monsterId == nil then
        tbl.monsterIdSpecified = false
        tbl.monsterId = 0
    else
        tbl.monsterIdSpecified = true
    end
    if tbl.existenceTime == nil then
        tbl.existenceTimeSpecified = false
        tbl.existenceTime = 0
    else
        tbl.existenceTimeSpecified = true
    end
end

--region metatable mapV2.ResServantInfo
---@type mapV2.ResServantInfo
mapV2_adj.metatable_ResServantInfo = {
    _ClassName = "mapV2.ResServantInfo",
}
mapV2_adj.metatable_ResServantInfo.__index = mapV2_adj.metatable_ResServantInfo
--endregion

---@param tbl mapV2.ResServantInfo 待调整的table数据
function mapV2_adj.AdjustResServantInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResServantInfo)
    if tbl.servantId == nil then
        tbl.servantIdSpecified = false
        tbl.servantId = 0
    else
        tbl.servantIdSpecified = true
    end
    if tbl.ownerId == nil then
        tbl.ownerIdSpecified = false
        tbl.ownerId = 0
    else
        tbl.ownerIdSpecified = true
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
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.combineHp == nil then
        tbl.combineHpSpecified = false
        tbl.combineHp = 0
    else
        tbl.combineHpSpecified = true
    end
    if tbl.combineMaxHp == nil then
        tbl.combineMaxHpSpecified = false
        tbl.combineMaxHp = 0
    else
        tbl.combineMaxHpSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable mapV2.ResTheTokenNotEnough
---@type mapV2.ResTheTokenNotEnough
mapV2_adj.metatable_ResTheTokenNotEnough = {
    _ClassName = "mapV2.ResTheTokenNotEnough",
}
mapV2_adj.metatable_ResTheTokenNotEnough.__index = mapV2_adj.metatable_ResTheTokenNotEnough
--endregion

---@param tbl mapV2.ResTheTokenNotEnough 待调整的table数据
function mapV2_adj.AdjustResTheTokenNotEnough(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResTheTokenNotEnough)
    if tbl.conditionId == nil then
        tbl.conditionId = {}
    else
        if mapV2_adj.AdjustCheckToken ~= nil then
            for i = 1, #tbl.conditionId do
                mapV2_adj.AdjustCheckToken(tbl.conditionId[i])
            end
        end
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
end

--region metatable mapV2.CheckToken
---@type mapV2.CheckToken
mapV2_adj.metatable_CheckToken = {
    _ClassName = "mapV2.CheckToken",
}
mapV2_adj.metatable_CheckToken.__index = mapV2_adj.metatable_CheckToken
--endregion

---@param tbl mapV2.CheckToken 待调整的table数据
function mapV2_adj.AdjustCheckToken(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_CheckToken)
    if tbl.conditionId == nil then
        tbl.conditionIdSpecified = false
        tbl.conditionId = 0
    else
        tbl.conditionIdSpecified = true
    end
    if tbl.isEnough == nil then
        tbl.isEnoughSpecified = false
        tbl.isEnough = 0
    else
        tbl.isEnoughSpecified = true
    end
end

--region metatable mapV2.ResItemsDrop
---@type mapV2.ResItemsDrop
mapV2_adj.metatable_ResItemsDrop = {
    _ClassName = "mapV2.ResItemsDrop",
}
mapV2_adj.metatable_ResItemsDrop.__index = mapV2_adj.metatable_ResItemsDrop
--endregion

---@param tbl mapV2.ResItemsDrop 待调整的table数据
function mapV2_adj.AdjustResItemsDrop(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResItemsDrop)
    if tbl.items == nil then
        tbl.items = {}
    else
        if mapV2_adj.AdjustRoundItemInfo ~= nil then
            for i = 1, #tbl.items do
                mapV2_adj.AdjustRoundItemInfo(tbl.items[i])
            end
        end
    end
end

--region metatable mapV2.ResStartMining
---@type mapV2.ResStartMining
mapV2_adj.metatable_ResStartMining = {
    _ClassName = "mapV2.ResStartMining",
}
mapV2_adj.metatable_ResStartMining.__index = mapV2_adj.metatable_ResStartMining
--endregion

---@param tbl mapV2.ResStartMining 待调整的table数据
function mapV2_adj.AdjustResStartMining(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResStartMining)
    if tbl.todayCount == nil then
        tbl.todayCountSpecified = false
        tbl.todayCount = 0
    else
        tbl.todayCountSpecified = true
    end
    if tbl.dayTime == nil then
        tbl.dayTimeSpecified = false
        tbl.dayTime = 0
    else
        tbl.dayTimeSpecified = true
    end
    if tbl.physical == nil then
        tbl.physicalSpecified = false
        tbl.physical = 0
    else
        tbl.physicalSpecified = true
    end
end

--region metatable mapV2.ResChangeSpirit
---@type mapV2.ResChangeSpirit
mapV2_adj.metatable_ResChangeSpirit = {
    _ClassName = "mapV2.ResChangeSpirit",
}
mapV2_adj.metatable_ResChangeSpirit.__index = mapV2_adj.metatable_ResChangeSpirit
--endregion

---@param tbl mapV2.ResChangeSpirit 待调整的table数据
function mapV2_adj.AdjustResChangeSpirit(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResChangeSpirit)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.physical == nil then
        tbl.physicalSpecified = false
        tbl.physical = 0
    else
        tbl.physicalSpecified = true
    end
end

--region metatable mapV2.ReqDoctorRecover
---@type mapV2.ReqDoctorRecover
mapV2_adj.metatable_ReqDoctorRecover = {
    _ClassName = "mapV2.ReqDoctorRecover",
}
mapV2_adj.metatable_ReqDoctorRecover.__index = mapV2_adj.metatable_ReqDoctorRecover
--endregion

---@param tbl mapV2.ReqDoctorRecover 待调整的table数据
function mapV2_adj.AdjustReqDoctorRecover(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ReqDoctorRecover)
    if tbl.moneyId == nil then
        tbl.moneyIdSpecified = false
        tbl.moneyId = 0
    else
        tbl.moneyIdSpecified = true
    end
end

--region metatable mapV2.ResDoctorRecover
---@type mapV2.ResDoctorRecover
mapV2_adj.metatable_ResDoctorRecover = {
    _ClassName = "mapV2.ResDoctorRecover",
}
mapV2_adj.metatable_ResDoctorRecover.__index = mapV2_adj.metatable_ResDoctorRecover
--endregion

---@param tbl mapV2.ResDoctorRecover 待调整的table数据
function mapV2_adj.AdjustResDoctorRecover(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResDoctorRecover)
    if tbl.moneyId == nil then
        tbl.moneyIdSpecified = false
        tbl.moneyId = 0
    else
        tbl.moneyIdSpecified = true
    end
    if tbl.isHealth == nil then
        tbl.isHealthSpecified = false
        tbl.isHealth = 0
    else
        tbl.isHealthSpecified = true
    end
    if tbl.cd == nil then
        tbl.cdSpecified = false
        tbl.cd = 0
    else
        tbl.cdSpecified = true
    end
end

--region metatable mapV2.ResPlayerBattleState
---@type mapV2.ResPlayerBattleState
mapV2_adj.metatable_ResPlayerBattleState = {
    _ClassName = "mapV2.ResPlayerBattleState",
}
mapV2_adj.metatable_ResPlayerBattleState.__index = mapV2_adj.metatable_ResPlayerBattleState
--endregion

---@param tbl mapV2.ResPlayerBattleState 待调整的table数据
function mapV2_adj.AdjustResPlayerBattleState(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResPlayerBattleState)
    if tbl.enterBattle == nil then
        tbl.enterBattleSpecified = false
        tbl.enterBattle = false
    else
        tbl.enterBattleSpecified = true
    end
end

--region metatable mapV2.ResUpdateUnionCartInfo
---@type mapV2.ResUpdateUnionCartInfo
mapV2_adj.metatable_ResUpdateUnionCartInfo = {
    _ClassName = "mapV2.ResUpdateUnionCartInfo",
}
mapV2_adj.metatable_ResUpdateUnionCartInfo.__index = mapV2_adj.metatable_ResUpdateUnionCartInfo
--endregion

---@param tbl mapV2.ResUpdateUnionCartInfo 待调整的table数据
function mapV2_adj.AdjustResUpdateUnionCartInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResUpdateUnionCartInfo)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
    if tbl.moveInterval == nil then
        tbl.moveIntervalSpecified = false
        tbl.moveInterval = 0
    else
        tbl.moveIntervalSpecified = true
    end
end

--region metatable mapV2.DropProtect
---@type mapV2.DropProtect
mapV2_adj.metatable_DropProtect = {
    _ClassName = "mapV2.DropProtect",
}
mapV2_adj.metatable_DropProtect.__index = mapV2_adj.metatable_DropProtect
--endregion

---@param tbl mapV2.DropProtect 待调整的table数据
function mapV2_adj.AdjustDropProtect(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_DropProtect)
    if tbl.itemConfigId == nil then
        tbl.itemConfigIdSpecified = false
        tbl.itemConfigId = 0
    else
        tbl.itemConfigIdSpecified = true
    end
    if tbl.pickUpTime == nil then
        tbl.pickUpTimeSpecified = false
        tbl.pickUpTime = 0
    else
        tbl.pickUpTimeSpecified = true
    end
    if tbl.ownerId == nil then
        tbl.ownerIdSpecified = false
        tbl.ownerId = 0
    else
        tbl.ownerIdSpecified = true
    end
    if tbl.ownerName == nil then
        tbl.ownerNameSpecified = false
        tbl.ownerName = ""
    else
        tbl.ownerNameSpecified = true
    end
    if tbl.ownerUnionId == nil then
        tbl.ownerUnionIdSpecified = false
        tbl.ownerUnionId = 0
    else
        tbl.ownerUnionIdSpecified = true
    end
    if tbl.pickUpId == nil then
        tbl.pickUpIdSpecified = false
        tbl.pickUpId = 0
    else
        tbl.pickUpIdSpecified = true
    end
    if tbl.pickUpName == nil then
        tbl.pickUpNameSpecified = false
        tbl.pickUpName = ""
    else
        tbl.pickUpNameSpecified = true
    end
    if tbl.pickUpUnionId == nil then
        tbl.pickUpUnionIdSpecified = false
        tbl.pickUpUnionId = 0
    else
        tbl.pickUpUnionIdSpecified = true
    end
    if tbl.moneyType == nil then
        tbl.moneyTypeSpecified = false
        tbl.moneyType = 0
    else
        tbl.moneyTypeSpecified = true
    end
    if tbl.dropMoneyPrice == nil then
        tbl.dropMoneyPriceSpecified = false
        tbl.dropMoneyPrice = 0
    else
        tbl.dropMoneyPriceSpecified = true
    end
    if tbl.pickUpPrice == nil then
        tbl.pickUpPriceSpecified = false
        tbl.pickUpPrice = 0
    else
        tbl.pickUpPriceSpecified = true
    end
    if tbl.ownerBuy == nil then
        tbl.ownerBuySpecified = false
        tbl.ownerBuy = false
    else
        tbl.ownerBuySpecified = true
    end
    if tbl.pickUpAward == nil then
        tbl.pickUpAwardSpecified = false
        tbl.pickUpAward = false
    else
        tbl.pickUpAwardSpecified = true
    end
    if tbl.bagItemInfo == nil then
        tbl.bagItemInfoSpecified = false
        tbl.bagItemInfo = nil
    else
        if tbl.bagItemInfoSpecified == nil then 
            tbl.bagItemInfoSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.bagItemInfo)
            end
        end
    end
    if tbl.alreadyReturn == nil then
        tbl.alreadyReturnSpecified = false
        tbl.alreadyReturn = false
    else
        tbl.alreadyReturnSpecified = true
    end
    if tbl.status == nil then
        tbl.statusSpecified = false
        tbl.status = 0
    else
        tbl.statusSpecified = true
    end
end

--region metatable mapV2.reqDropProtect
---@type mapV2.reqDropProtect
mapV2_adj.metatable_reqDropProtect = {
    _ClassName = "mapV2.reqDropProtect",
}
mapV2_adj.metatable_reqDropProtect.__index = mapV2_adj.metatable_reqDropProtect
--endregion

---@param tbl mapV2.reqDropProtect 待调整的table数据
function mapV2_adj.AdjustreqDropProtect(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_reqDropProtect)
    if tbl.dropProtect == nil then
        tbl.dropProtect = {}
    else
        if mapV2_adj.AdjustDropProtect ~= nil then
            for i = 1, #tbl.dropProtect do
                mapV2_adj.AdjustDropProtect(tbl.dropProtect[i])
            end
        end
    end
    if tbl.itemTimeOutS == nil then
        tbl.itemTimeOutSSpecified = false
        tbl.itemTimeOutS = 0
    else
        tbl.itemTimeOutSSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable mapV2.reqDropBuy
---@type mapV2.reqDropBuy
mapV2_adj.metatable_reqDropBuy = {
    _ClassName = "mapV2.reqDropBuy",
}
mapV2_adj.metatable_reqDropBuy.__index = mapV2_adj.metatable_reqDropBuy
--endregion

---@param tbl mapV2.reqDropBuy 待调整的table数据
function mapV2_adj.AdjustreqDropBuy(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_reqDropBuy)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
end

--region metatable mapV2.reqPickUpBuy
---@type mapV2.reqPickUpBuy
mapV2_adj.metatable_reqPickUpBuy = {
    _ClassName = "mapV2.reqPickUpBuy",
}
mapV2_adj.metatable_reqPickUpBuy.__index = mapV2_adj.metatable_reqPickUpBuy
--endregion

---@param tbl mapV2.reqPickUpBuy 待调整的table数据
function mapV2_adj.AdjustreqPickUpBuy(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_reqPickUpBuy)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
end

--region metatable mapV2.reqDropReturn
---@type mapV2.reqDropReturn
mapV2_adj.metatable_reqDropReturn = {
    _ClassName = "mapV2.reqDropReturn",
}
mapV2_adj.metatable_reqDropReturn.__index = mapV2_adj.metatable_reqDropReturn
--endregion

---@param tbl mapV2.reqDropReturn 待调整的table数据
function mapV2_adj.AdjustreqDropReturn(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_reqDropReturn)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
end

--region metatable mapV2.reqDropReturnAward
---@type mapV2.reqDropReturnAward
mapV2_adj.metatable_reqDropReturnAward = {
    _ClassName = "mapV2.reqDropReturnAward",
}
mapV2_adj.metatable_reqDropReturnAward.__index = mapV2_adj.metatable_reqDropReturnAward
--endregion

---@param tbl mapV2.reqDropReturnAward 待调整的table数据
function mapV2_adj.AdjustreqDropReturnAward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_reqDropReturnAward)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
end

--region metatable mapV2.dropProtectNotice
---@type mapV2.dropProtectNotice
mapV2_adj.metatable_dropProtectNotice = {
    _ClassName = "mapV2.dropProtectNotice",
}
mapV2_adj.metatable_dropProtectNotice.__index = mapV2_adj.metatable_dropProtectNotice
--endregion

---@param tbl mapV2.dropProtectNotice 待调整的table数据
function mapV2_adj.AdjustdropProtectNotice(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_dropProtectNotice)
    if tbl.dropNotice == nil then
        tbl.dropNoticeSpecified = false
        tbl.dropNotice = false
    else
        tbl.dropNoticeSpecified = true
    end
    if tbl.pickUpNotice == nil then
        tbl.pickUpNoticeSpecified = false
        tbl.pickUpNotice = false
    else
        tbl.pickUpNoticeSpecified = true
    end
end

--region metatable mapV2.MainCityBranch
---@type mapV2.MainCityBranch
mapV2_adj.metatable_MainCityBranch = {
    _ClassName = "mapV2.MainCityBranch",
}
mapV2_adj.metatable_MainCityBranch.__index = mapV2_adj.metatable_MainCityBranch
--endregion

---@param tbl mapV2.MainCityBranch 待调整的table数据
function mapV2_adj.AdjustMainCityBranch(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_MainCityBranch)
    if tbl.isBranch == nil then
        tbl.isBranchSpecified = false
        tbl.isBranch = 0
    else
        tbl.isBranchSpecified = true
    end
end

--region metatable mapV2.ResGuardBowLord
---@type mapV2.ResGuardBowLord
mapV2_adj.metatable_ResGuardBowLord = {
    _ClassName = "mapV2.ResGuardBowLord",
}
mapV2_adj.metatable_ResGuardBowLord.__index = mapV2_adj.metatable_ResGuardBowLord
--endregion

---@param tbl mapV2.ResGuardBowLord 待调整的table数据
function mapV2_adj.AdjustResGuardBowLord(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResGuardBowLord)
end

--region metatable mapV2.ResMinerCollection
---@type mapV2.ResMinerCollection
mapV2_adj.metatable_ResMinerCollection = {
    _ClassName = "mapV2.ResMinerCollection",
}
mapV2_adj.metatable_ResMinerCollection.__index = mapV2_adj.metatable_ResMinerCollection
--endregion

---@param tbl mapV2.ResMinerCollection 待调整的table数据
function mapV2_adj.AdjustResMinerCollection(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResMinerCollection)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
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

--region metatable mapV2.ResStopMinerCollection
---@type mapV2.ResStopMinerCollection
mapV2_adj.metatable_ResStopMinerCollection = {
    _ClassName = "mapV2.ResStopMinerCollection",
}
mapV2_adj.metatable_ResStopMinerCollection.__index = mapV2_adj.metatable_ResStopMinerCollection
--endregion

---@param tbl mapV2.ResStopMinerCollection 待调整的table数据
function mapV2_adj.AdjustResStopMinerCollection(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResStopMinerCollection)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
end

--region metatable mapV2.MinerActivityType
---@type mapV2.MinerActivityType
mapV2_adj.metatable_MinerActivityType = {
    _ClassName = "mapV2.MinerActivityType",
}
mapV2_adj.metatable_MinerActivityType.__index = mapV2_adj.metatable_MinerActivityType
--endregion

---@param tbl mapV2.MinerActivityType 待调整的table数据
function mapV2_adj.AdjustMinerActivityType(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_MinerActivityType)
    if tbl.activityType == nil then
        tbl.activityTypeSpecified = false
        tbl.activityType = 0
    else
        tbl.activityTypeSpecified = true
    end
    if tbl.minerId == nil then
        tbl.minerIdSpecified = false
        tbl.minerId = 0
    else
        tbl.minerIdSpecified = true
    end
    if tbl.killUnionName == nil then
        tbl.killUnionNameSpecified = false
        tbl.killUnionName = ""
    else
        tbl.killUnionNameSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.point == nil then
        tbl.pointSpecified = false
        tbl.point = ""
    else
        tbl.pointSpecified = true
    end
end

--region metatable mapV2.MonsterActiveWarning
---@type mapV2.MonsterActiveWarning
mapV2_adj.metatable_MonsterActiveWarning = {
    _ClassName = "mapV2.MonsterActiveWarning",
}
mapV2_adj.metatable_MonsterActiveWarning.__index = mapV2_adj.metatable_MonsterActiveWarning
--endregion

---@param tbl mapV2.MonsterActiveWarning 待调整的table数据
function mapV2_adj.AdjustMonsterActiveWarning(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_MonsterActiveWarning)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
end

--region metatable mapV2.ReqNpcReceivePrize
---@type mapV2.ReqNpcReceivePrize
mapV2_adj.metatable_ReqNpcReceivePrize = {
    _ClassName = "mapV2.ReqNpcReceivePrize",
}
mapV2_adj.metatable_ReqNpcReceivePrize.__index = mapV2_adj.metatable_ReqNpcReceivePrize
--endregion

---@param tbl mapV2.ReqNpcReceivePrize 待调整的table数据
function mapV2_adj.AdjustReqNpcReceivePrize(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ReqNpcReceivePrize)
    if tbl.npcLid == nil then
        tbl.npcLidSpecified = false
        tbl.npcLid = 0
    else
        tbl.npcLidSpecified = true
    end
end

--region metatable mapV2.ReqReceiveRankingForNpc
---@type mapV2.ReqReceiveRankingForNpc
mapV2_adj.metatable_ReqReceiveRankingForNpc = {
    _ClassName = "mapV2.ReqReceiveRankingForNpc",
}
mapV2_adj.metatable_ReqReceiveRankingForNpc.__index = mapV2_adj.metatable_ReqReceiveRankingForNpc
--endregion

---@param tbl mapV2.ReqReceiveRankingForNpc 待调整的table数据
function mapV2_adj.AdjustReqReceiveRankingForNpc(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ReqReceiveRankingForNpc)
    if tbl.npcLid == nil then
        tbl.npcLidSpecified = false
        tbl.npcLid = 0
    else
        tbl.npcLidSpecified = true
    end
end

--region metatable mapV2.ResReceiveRankingForNpc
---@type mapV2.ResReceiveRankingForNpc
mapV2_adj.metatable_ResReceiveRankingForNpc = {
    _ClassName = "mapV2.ResReceiveRankingForNpc",
}
mapV2_adj.metatable_ResReceiveRankingForNpc.__index = mapV2_adj.metatable_ResReceiveRankingForNpc
--endregion

---@param tbl mapV2.ResReceiveRankingForNpc 待调整的table数据
function mapV2_adj.AdjustResReceiveRankingForNpc(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResReceiveRankingForNpc)
    if tbl.peopleInfo == nil then
        tbl.peopleInfo = {}
    else
        if mapV2_adj.AdjustHasReceivePeopleInfo ~= nil then
            for i = 1, #tbl.peopleInfo do
                mapV2_adj.AdjustHasReceivePeopleInfo(tbl.peopleInfo[i])
            end
        end
    end
    if tbl.receiveCount == nil then
        tbl.receiveCountSpecified = false
        tbl.receiveCount = 0
    else
        tbl.receiveCountSpecified = true
    end
end

--region metatable mapV2.HasReceivePeopleInfo
---@type mapV2.HasReceivePeopleInfo
mapV2_adj.metatable_HasReceivePeopleInfo = {
    _ClassName = "mapV2.HasReceivePeopleInfo",
}
mapV2_adj.metatable_HasReceivePeopleInfo.__index = mapV2_adj.metatable_HasReceivePeopleInfo
--endregion

---@param tbl mapV2.HasReceivePeopleInfo 待调整的table数据
function mapV2_adj.AdjustHasReceivePeopleInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_HasReceivePeopleInfo)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
end

--region metatable mapV2.TransmitEffect
---@type mapV2.TransmitEffect
mapV2_adj.metatable_TransmitEffect = {
    _ClassName = "mapV2.TransmitEffect",
}
mapV2_adj.metatable_TransmitEffect.__index = mapV2_adj.metatable_TransmitEffect
--endregion

---@param tbl mapV2.TransmitEffect 待调整的table数据
function mapV2_adj.AdjustTransmitEffect(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_TransmitEffect)
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
    if tbl.reason == nil then
        tbl.reasonSpecified = false
        tbl.reason = 0
    else
        tbl.reasonSpecified = true
    end
end

--region metatable mapV2.ResPetDie
---@type mapV2.ResPetDie
mapV2_adj.metatable_ResPetDie = {
    _ClassName = "mapV2.ResPetDie",
}
mapV2_adj.metatable_ResPetDie.__index = mapV2_adj.metatable_ResPetDie
--endregion

---@param tbl mapV2.ResPetDie 待调整的table数据
function mapV2_adj.AdjustResPetDie(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResPetDie)
end

--region metatable mapV2.MultiItemEffect
---@type mapV2.MultiItemEffect
mapV2_adj.metatable_MultiItemEffect = {
    _ClassName = "mapV2.MultiItemEffect",
}
mapV2_adj.metatable_MultiItemEffect.__index = mapV2_adj.metatable_MultiItemEffect
--endregion

---@param tbl mapV2.MultiItemEffect 待调整的table数据
function mapV2_adj.AdjustMultiItemEffect(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_MultiItemEffect)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
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
    if tbl.effectId == nil then
        tbl.effectIdSpecified = false
        tbl.effectId = 0
    else
        tbl.effectIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable mapV2.ReqLocationDelivery
---@type mapV2.ReqLocationDelivery
mapV2_adj.metatable_ReqLocationDelivery = {
    _ClassName = "mapV2.ReqLocationDelivery",
}
mapV2_adj.metatable_ReqLocationDelivery.__index = mapV2_adj.metatable_ReqLocationDelivery
--endregion

---@param tbl mapV2.ReqLocationDelivery 待调整的table数据
function mapV2_adj.AdjustReqLocationDelivery(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ReqLocationDelivery)
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

--region metatable mapV2.ResLocationDelivery
---@type mapV2.ResLocationDelivery
mapV2_adj.metatable_ResLocationDelivery = {
    _ClassName = "mapV2.ResLocationDelivery",
}
mapV2_adj.metatable_ResLocationDelivery.__index = mapV2_adj.metatable_ResLocationDelivery
--endregion

---@param tbl mapV2.ResLocationDelivery 待调整的table数据
function mapV2_adj.AdjustResLocationDelivery(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResLocationDelivery)
    if tbl.deliverySuccess == nil then
        tbl.deliverySuccessSpecified = false
        tbl.deliverySuccess = 0
    else
        tbl.deliverySuccessSpecified = true
    end
end

--region metatable mapV2.MonsterIdInfo
---@type mapV2.MonsterIdInfo
mapV2_adj.metatable_MonsterIdInfo = {
    _ClassName = "mapV2.MonsterIdInfo",
}
mapV2_adj.metatable_MonsterIdInfo.__index = mapV2_adj.metatable_MonsterIdInfo
--endregion

---@param tbl mapV2.MonsterIdInfo 待调整的table数据
function mapV2_adj.AdjustMonsterIdInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_MonsterIdInfo)
end

--region metatable mapV2.HasSkeleton
---@type mapV2.HasSkeleton
mapV2_adj.metatable_HasSkeleton = {
    _ClassName = "mapV2.HasSkeleton",
}
mapV2_adj.metatable_HasSkeleton.__index = mapV2_adj.metatable_HasSkeleton
--endregion

---@param tbl mapV2.HasSkeleton 待调整的table数据
function mapV2_adj.AdjustHasSkeleton(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_HasSkeleton)
    if tbl.monsterId == nil then
        tbl.monsterIdSpecified = false
        tbl.monsterId = 0
    else
        tbl.monsterIdSpecified = true
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

--region metatable mapV2.ResFishingPointChange
---@type mapV2.ResFishingPointChange
mapV2_adj.metatable_ResFishingPointChange = {
    _ClassName = "mapV2.ResFishingPointChange",
}
mapV2_adj.metatable_ResFishingPointChange.__index = mapV2_adj.metatable_ResFishingPointChange
--endregion

---@param tbl mapV2.ResFishingPointChange 待调整的table数据
function mapV2_adj.AdjustResFishingPointChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResFishingPointChange)
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
end

--region metatable mapV2.ResPlayerDropInfo
---@type mapV2.ResPlayerDropInfo
mapV2_adj.metatable_ResPlayerDropInfo = {
    _ClassName = "mapV2.ResPlayerDropInfo",
}
mapV2_adj.metatable_ResPlayerDropInfo.__index = mapV2_adj.metatable_ResPlayerDropInfo
--endregion

---@param tbl mapV2.ResPlayerDropInfo 待调整的table数据
function mapV2_adj.AdjustResPlayerDropInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResPlayerDropInfo)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.dieTime == nil then
        tbl.dieTimeSpecified = false
        tbl.dieTime = 0
    else
        tbl.dieTimeSpecified = true
    end
    if tbl.itemList == nil then
        tbl.itemList = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.itemList do
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.itemList[i])
            end
        end
    end
end

--region metatable mapV2.TreeMonsterRefreshCall
---@type mapV2.TreeMonsterRefreshCall
mapV2_adj.metatable_TreeMonsterRefreshCall = {
    _ClassName = "mapV2.TreeMonsterRefreshCall",
}
mapV2_adj.metatable_TreeMonsterRefreshCall.__index = mapV2_adj.metatable_TreeMonsterRefreshCall
--endregion

---@param tbl mapV2.TreeMonsterRefreshCall 待调整的table数据
function mapV2_adj.AdjustTreeMonsterRefreshCall(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_TreeMonsterRefreshCall)
    if tbl.monsterId == nil then
        tbl.monsterIdSpecified = false
        tbl.monsterId = 0
    else
        tbl.monsterIdSpecified = true
    end
    if tbl.monsterName == nil then
        tbl.monsterNameSpecified = false
        tbl.monsterName = ""
    else
        tbl.monsterNameSpecified = true
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
    if tbl.pointX == nil then
        tbl.pointXSpecified = false
        tbl.pointX = 0
    else
        tbl.pointXSpecified = true
    end
    if tbl.pointY == nil then
        tbl.pointYSpecified = false
        tbl.pointY = 0
    else
        tbl.pointYSpecified = true
    end
    if tbl.startTime == nil then
        tbl.startTimeSpecified = false
        tbl.startTime = 0
    else
        tbl.startTimeSpecified = true
    end
end

--region metatable mapV2.DeliverTreeMonsterInfo
---@type mapV2.DeliverTreeMonsterInfo
mapV2_adj.metatable_DeliverTreeMonsterInfo = {
    _ClassName = "mapV2.DeliverTreeMonsterInfo",
}
mapV2_adj.metatable_DeliverTreeMonsterInfo.__index = mapV2_adj.metatable_DeliverTreeMonsterInfo
--endregion

---@param tbl mapV2.DeliverTreeMonsterInfo 待调整的table数据
function mapV2_adj.AdjustDeliverTreeMonsterInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_DeliverTreeMonsterInfo)
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
    if tbl.pointX == nil then
        tbl.pointXSpecified = false
        tbl.pointX = 0
    else
        tbl.pointXSpecified = true
    end
    if tbl.pointY == nil then
        tbl.pointYSpecified = false
        tbl.pointY = 0
    else
        tbl.pointYSpecified = true
    end
    if tbl.StartTime == nil then
        tbl.StartTimeSpecified = false
        tbl.StartTime = 0
    else
        tbl.StartTimeSpecified = true
    end
end

--region metatable mapV2.DeliverTreeMonsterResult
---@type mapV2.DeliverTreeMonsterResult
mapV2_adj.metatable_DeliverTreeMonsterResult = {
    _ClassName = "mapV2.DeliverTreeMonsterResult",
}
mapV2_adj.metatable_DeliverTreeMonsterResult.__index = mapV2_adj.metatable_DeliverTreeMonsterResult
--endregion

---@param tbl mapV2.DeliverTreeMonsterResult 待调整的table数据
function mapV2_adj.AdjustDeliverTreeMonsterResult(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_DeliverTreeMonsterResult)
    if tbl.isSuccess == nil then
        tbl.isSuccessSpecified = false
        tbl.isSuccess = false
    else
        tbl.isSuccessSpecified = true
    end
end

--region metatable mapV2.ReqDemonBossInfo
---@type mapV2.ReqDemonBossInfo
mapV2_adj.metatable_ReqDemonBossInfo = {
    _ClassName = "mapV2.ReqDemonBossInfo",
}
mapV2_adj.metatable_ReqDemonBossInfo.__index = mapV2_adj.metatable_ReqDemonBossInfo
--endregion

---@param tbl mapV2.ReqDemonBossInfo 待调整的table数据
function mapV2_adj.AdjustReqDemonBossInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ReqDemonBossInfo)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable mapV2.ResDemonBossInfo
---@type mapV2.ResDemonBossInfo
mapV2_adj.metatable_ResDemonBossInfo = {
    _ClassName = "mapV2.ResDemonBossInfo",
}
mapV2_adj.metatable_ResDemonBossInfo.__index = mapV2_adj.metatable_ResDemonBossInfo
--endregion

---@param tbl mapV2.ResDemonBossInfo 待调整的table数据
function mapV2_adj.AdjustResDemonBossInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResDemonBossInfo)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
end

--region metatable mapV2.ResDemonBossHasCount
---@type mapV2.ResDemonBossHasCount
mapV2_adj.metatable_ResDemonBossHasCount = {
    _ClassName = "mapV2.ResDemonBossHasCount",
}
mapV2_adj.metatable_ResDemonBossHasCount.__index = mapV2_adj.metatable_ResDemonBossHasCount
--endregion

---@param tbl mapV2.ResDemonBossHasCount 待调整的table数据
function mapV2_adj.AdjustResDemonBossHasCount(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResDemonBossHasCount)
    if tbl.demonInfo == nil then
        tbl.demonInfo = {}
    else
        if mapV2_adj.AdjustDemonInfo ~= nil then
            for i = 1, #tbl.demonInfo do
                mapV2_adj.AdjustDemonInfo(tbl.demonInfo[i])
            end
        end
    end
    if tbl.helpCount == nil then
        tbl.helpCountSpecified = false
        tbl.helpCount = 0
    else
        tbl.helpCountSpecified = true
    end
    if tbl.allCount == nil then
        tbl.allCountSpecified = false
        tbl.allCount = 0
    else
        tbl.allCountSpecified = true
    end
    if tbl.nextHasAllCountTime == nil then
        tbl.nextHasAllCountTimeSpecified = false
        tbl.nextHasAllCountTime = 0
    else
        tbl.nextHasAllCountTimeSpecified = true
    end
end

--region metatable mapV2.DemonInfo
---@type mapV2.DemonInfo
mapV2_adj.metatable_DemonInfo = {
    _ClassName = "mapV2.DemonInfo",
}
mapV2_adj.metatable_DemonInfo.__index = mapV2_adj.metatable_DemonInfo
--endregion

---@param tbl mapV2.DemonInfo 待调整的table数据
function mapV2_adj.AdjustDemonInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_DemonInfo)
    if tbl.killCount == nil then
        tbl.killCountSpecified = false
        tbl.killCount = 0
    else
        tbl.killCountSpecified = true
    end
    if tbl.killType == nil then
        tbl.killTypeSpecified = false
        tbl.killType = 0
    else
        tbl.killTypeSpecified = true
    end
    if tbl.nextHasTime == nil then
        tbl.nextHasTimeSpecified = false
        tbl.nextHasTime = 0
    else
        tbl.nextHasTimeSpecified = true
    end
end

--region metatable mapV2.ResDemonBossUpdateHasCount
---@type mapV2.ResDemonBossUpdateHasCount
mapV2_adj.metatable_ResDemonBossUpdateHasCount = {
    _ClassName = "mapV2.ResDemonBossUpdateHasCount",
}
mapV2_adj.metatable_ResDemonBossUpdateHasCount.__index = mapV2_adj.metatable_ResDemonBossUpdateHasCount
--endregion

---@param tbl mapV2.ResDemonBossUpdateHasCount 待调整的table数据
function mapV2_adj.AdjustResDemonBossUpdateHasCount(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResDemonBossUpdateHasCount)
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
    if tbl.killType == nil then
        tbl.killTypeSpecified = false
        tbl.killType = 0
    else
        tbl.killTypeSpecified = true
    end
end

--region metatable mapV2.ReqDemonBossHelp
---@type mapV2.ReqDemonBossHelp
mapV2_adj.metatable_ReqDemonBossHelp = {
    _ClassName = "mapV2.ReqDemonBossHelp",
}
mapV2_adj.metatable_ReqDemonBossHelp.__index = mapV2_adj.metatable_ReqDemonBossHelp
--endregion

---@param tbl mapV2.ReqDemonBossHelp 待调整的table数据
function mapV2_adj.AdjustReqDemonBossHelp(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ReqDemonBossHelp)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable mapV2.ResDemonBossHelpFailure
---@type mapV2.ResDemonBossHelpFailure
mapV2_adj.metatable_ResDemonBossHelpFailure = {
    _ClassName = "mapV2.ResDemonBossHelpFailure",
}
mapV2_adj.metatable_ResDemonBossHelpFailure.__index = mapV2_adj.metatable_ResDemonBossHelpFailure
--endregion

---@param tbl mapV2.ResDemonBossHelpFailure 待调整的table数据
function mapV2_adj.AdjustResDemonBossHelpFailure(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResDemonBossHelpFailure)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.cdEndTime == nil then
        tbl.cdEndTimeSpecified = false
        tbl.cdEndTime = 0
    else
        tbl.cdEndTimeSpecified = true
    end
end

--region metatable mapV2.ResDemonBossHelpToPeople
---@type mapV2.ResDemonBossHelpToPeople
mapV2_adj.metatable_ResDemonBossHelpToPeople = {
    _ClassName = "mapV2.ResDemonBossHelpToPeople",
}
mapV2_adj.metatable_ResDemonBossHelpToPeople.__index = mapV2_adj.metatable_ResDemonBossHelpToPeople
--endregion

---@param tbl mapV2.ResDemonBossHelpToPeople 待调整的table数据
function mapV2_adj.AdjustResDemonBossHelpToPeople(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResDemonBossHelpToPeople)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
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
    if tbl.monsterConfigId == nil then
        tbl.monsterConfigIdSpecified = false
        tbl.monsterConfigId = 0
    else
        tbl.monsterConfigIdSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
    if tbl.groupId == nil then
        tbl.groupIdSpecified = false
        tbl.groupId = 0
    else
        tbl.groupIdSpecified = true
    end
end

--region metatable mapV2.ReqAcceptDemonBossHelp
---@type mapV2.ReqAcceptDemonBossHelp
mapV2_adj.metatable_ReqAcceptDemonBossHelp = {
    _ClassName = "mapV2.ReqAcceptDemonBossHelp",
}
mapV2_adj.metatable_ReqAcceptDemonBossHelp.__index = mapV2_adj.metatable_ReqAcceptDemonBossHelp
--endregion

---@param tbl mapV2.ReqAcceptDemonBossHelp 待调整的table数据
function mapV2_adj.AdjustReqAcceptDemonBossHelp(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ReqAcceptDemonBossHelp)
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
end

--region metatable mapV2.DemonDieCanReward
---@type mapV2.DemonDieCanReward
mapV2_adj.metatable_DemonDieCanReward = {
    _ClassName = "mapV2.DemonDieCanReward",
}
mapV2_adj.metatable_DemonDieCanReward.__index = mapV2_adj.metatable_DemonDieCanReward
--endregion

---@param tbl mapV2.DemonDieCanReward 待调整的table数据
function mapV2_adj.AdjustDemonDieCanReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_DemonDieCanReward)
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
    if tbl.monsterId == nil then
        tbl.monsterIdSpecified = false
        tbl.monsterId = 0
    else
        tbl.monsterIdSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
    if tbl.ownerUnionId == nil then
        tbl.ownerUnionIdSpecified = false
        tbl.ownerUnionId = 0
    else
        tbl.ownerUnionIdSpecified = true
    end
    if tbl.monsterConfigId == nil then
        tbl.monsterConfigIdSpecified = false
        tbl.monsterConfigId = 0
    else
        tbl.monsterConfigIdSpecified = true
    end
    if tbl.ownerId == nil then
        tbl.ownerIdSpecified = false
        tbl.ownerId = 0
    else
        tbl.ownerIdSpecified = true
    end
end

--region metatable mapV2.ReqDemonDieCanReward
---@type mapV2.ReqDemonDieCanReward
mapV2_adj.metatable_ReqDemonDieCanReward = {
    _ClassName = "mapV2.ReqDemonDieCanReward",
}
mapV2_adj.metatable_ReqDemonDieCanReward.__index = mapV2_adj.metatable_ReqDemonDieCanReward
--endregion

---@param tbl mapV2.ReqDemonDieCanReward 待调整的table数据
function mapV2_adj.AdjustReqDemonDieCanReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ReqDemonDieCanReward)
    if tbl.ownerId == nil then
        tbl.ownerIdSpecified = false
        tbl.ownerId = 0
    else
        tbl.ownerIdSpecified = true
    end
    if tbl.ownerUnionId == nil then
        tbl.ownerUnionIdSpecified = false
        tbl.ownerUnionId = 0
    else
        tbl.ownerUnionIdSpecified = true
    end
    if tbl.monsterConfigId == nil then
        tbl.monsterConfigIdSpecified = false
        tbl.monsterConfigId = 0
    else
        tbl.monsterConfigIdSpecified = true
    end
    if tbl.monsterLid == nil then
        tbl.monsterLidSpecified = false
        tbl.monsterLid = 0
    else
        tbl.monsterLidSpecified = true
    end
end

--region metatable mapV2.DemonBossEndTime
---@type mapV2.DemonBossEndTime
mapV2_adj.metatable_DemonBossEndTime = {
    _ClassName = "mapV2.DemonBossEndTime",
}
mapV2_adj.metatable_DemonBossEndTime.__index = mapV2_adj.metatable_DemonBossEndTime
--endregion

---@param tbl mapV2.DemonBossEndTime 待调整的table数据
function mapV2_adj.AdjustDemonBossEndTime(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_DemonBossEndTime)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
end

--region metatable mapV2.ResGodBossInfo
---@type mapV2.ResGodBossInfo
mapV2_adj.metatable_ResGodBossInfo = {
    _ClassName = "mapV2.ResGodBossInfo",
}
mapV2_adj.metatable_ResGodBossInfo.__index = mapV2_adj.metatable_ResGodBossInfo
--endregion

---@param tbl mapV2.ResGodBossInfo 待调整的table数据
function mapV2_adj.AdjustResGodBossInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResGodBossInfo)
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
    if tbl.enterMapId == nil then
        tbl.enterMapIdSpecified = false
        tbl.enterMapId = 0
    else
        tbl.enterMapIdSpecified = true
    end
    if tbl.boss == nil then
        tbl.boss = {}
    else
        if mapV2_adj.AdjustGodBoss ~= nil then
            for i = 1, #tbl.boss do
                mapV2_adj.AdjustGodBoss(tbl.boss[i])
            end
        end
    end
end

--region metatable mapV2.GodBoss
---@type mapV2.GodBoss
mapV2_adj.metatable_GodBoss = {
    _ClassName = "mapV2.GodBoss",
}
mapV2_adj.metatable_GodBoss.__index = mapV2_adj.metatable_GodBoss
--endregion

---@param tbl mapV2.GodBoss 待调整的table数据
function mapV2_adj.AdjustGodBoss(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_GodBoss)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.monsterId == nil then
        tbl.monsterIdSpecified = false
        tbl.monsterId = 0
    else
        tbl.monsterIdSpecified = true
    end
    if tbl.monsterLid == nil then
        tbl.monsterLidSpecified = false
        tbl.monsterLid = 0
    else
        tbl.monsterLidSpecified = true
    end
end

--region metatable mapV2.ResSealTowerAddDamage
---@type mapV2.ResSealTowerAddDamage
mapV2_adj.metatable_ResSealTowerAddDamage = {
    _ClassName = "mapV2.ResSealTowerAddDamage",
}
mapV2_adj.metatable_ResSealTowerAddDamage.__index = mapV2_adj.metatable_ResSealTowerAddDamage
--endregion

---@param tbl mapV2.ResSealTowerAddDamage 待调整的table数据
function mapV2_adj.AdjustResSealTowerAddDamage(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResSealTowerAddDamage)
    if tbl.openType == nil then
        tbl.openTypeSpecified = false
        tbl.openType = 0
    else
        tbl.openTypeSpecified = true
    end
    if tbl.addDamgePercent == nil then
        tbl.addDamgePercentSpecified = false
        tbl.addDamgePercent = 0
    else
        tbl.addDamgePercentSpecified = true
    end
end

--region metatable mapV2.BonfireAddExp
---@type mapV2.BonfireAddExp
mapV2_adj.metatable_BonfireAddExp = {
    _ClassName = "mapV2.BonfireAddExp",
}
mapV2_adj.metatable_BonfireAddExp.__index = mapV2_adj.metatable_BonfireAddExp
--endregion

---@param tbl mapV2.BonfireAddExp 待调整的table数据
function mapV2_adj.AdjustBonfireAddExp(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_BonfireAddExp)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.exp == nil then
        tbl.expSpecified = false
        tbl.exp = 0
    else
        tbl.expSpecified = true
    end
end

--region metatable mapV2.ReqBonfireInfo
---@type mapV2.ReqBonfireInfo
mapV2_adj.metatable_ReqBonfireInfo = {
    _ClassName = "mapV2.ReqBonfireInfo",
}
mapV2_adj.metatable_ReqBonfireInfo.__index = mapV2_adj.metatable_ReqBonfireInfo
--endregion

---@param tbl mapV2.ReqBonfireInfo 待调整的table数据
function mapV2_adj.AdjustReqBonfireInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ReqBonfireInfo)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
end

--region metatable mapV2.ResBonfireInfo
---@type mapV2.ResBonfireInfo
mapV2_adj.metatable_ResBonfireInfo = {
    _ClassName = "mapV2.ResBonfireInfo",
}
mapV2_adj.metatable_ResBonfireInfo.__index = mapV2_adj.metatable_ResBonfireInfo
--endregion

---@param tbl mapV2.ResBonfireInfo 待调整的table数据
function mapV2_adj.AdjustResBonfireInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResBonfireInfo)
    if tbl.basicExp == nil then
        tbl.basicExpSpecified = false
        tbl.basicExp = 0
    else
        tbl.basicExpSpecified = true
    end
    if tbl.unionCount == nil then
        tbl.unionCountSpecified = false
        tbl.unionCount = 0
    else
        tbl.unionCountSpecified = true
    end
    if tbl.maotaiRate == nil then
        tbl.maotaiRateSpecified = false
        tbl.maotaiRate = 0
    else
        tbl.maotaiRateSpecified = true
    end
    if tbl.expCarnivalRate == nil then
        tbl.expCarnivalRateSpecified = false
        tbl.expCarnivalRate = 0
    else
        tbl.expCarnivalRateSpecified = true
    end
end

--region metatable mapV2.PlayerEnterBonfireState
---@type mapV2.PlayerEnterBonfireState
mapV2_adj.metatable_PlayerEnterBonfireState = {
    _ClassName = "mapV2.PlayerEnterBonfireState",
}
mapV2_adj.metatable_PlayerEnterBonfireState.__index = mapV2_adj.metatable_PlayerEnterBonfireState
--endregion

---@param tbl mapV2.PlayerEnterBonfireState 待调整的table数据
function mapV2_adj.AdjustPlayerEnterBonfireState(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_PlayerEnterBonfireState)
    if tbl.bonfireId == nil then
        tbl.bonfireIdSpecified = false
        tbl.bonfireId = 0
    else
        tbl.bonfireIdSpecified = true
    end
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable mapV2.ResUseItemDeliverToMap
---@type mapV2.ResUseItemDeliverToMap
mapV2_adj.metatable_ResUseItemDeliverToMap = {
    _ClassName = "mapV2.ResUseItemDeliverToMap",
}
mapV2_adj.metatable_ResUseItemDeliverToMap.__index = mapV2_adj.metatable_ResUseItemDeliverToMap
--endregion

---@param tbl mapV2.ResUseItemDeliverToMap 待调整的table数据
function mapV2_adj.AdjustResUseItemDeliverToMap(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResUseItemDeliverToMap)
    if tbl.deliverId == nil then
        tbl.deliverIdSpecified = false
        tbl.deliverId = 0
    else
        tbl.deliverIdSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
end

--region metatable mapV2.AutoPickObjIds
---@type mapV2.AutoPickObjIds
mapV2_adj.metatable_AutoPickObjIds = {
    _ClassName = "mapV2.AutoPickObjIds",
}
mapV2_adj.metatable_AutoPickObjIds.__index = mapV2_adj.metatable_AutoPickObjIds
--endregion

---@param tbl mapV2.AutoPickObjIds 待调整的table数据
function mapV2_adj.AdjustAutoPickObjIds(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_AutoPickObjIds)
    if tbl.objId == nil then
        tbl.objId = {}
    end
end

--region metatable mapV2.ResPlayerZhenfaChange
---@type mapV2.ResPlayerZhenfaChange
mapV2_adj.metatable_ResPlayerZhenfaChange = {
    _ClassName = "mapV2.ResPlayerZhenfaChange",
}
mapV2_adj.metatable_ResPlayerZhenfaChange.__index = mapV2_adj.metatable_ResPlayerZhenfaChange
--endregion

---@param tbl mapV2.ResPlayerZhenfaChange 待调整的table数据
function mapV2_adj.AdjustResPlayerZhenfaChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResPlayerZhenfaChange)
end

--region metatable mapV2.ResPickUpTypeToClient
---@type mapV2.ResPickUpTypeToClient
mapV2_adj.metatable_ResPickUpTypeToClient = {
    _ClassName = "mapV2.ResPickUpTypeToClient",
}
mapV2_adj.metatable_ResPickUpTypeToClient.__index = mapV2_adj.metatable_ResPickUpTypeToClient
--endregion

---@param tbl mapV2.ResPickUpTypeToClient 待调整的table数据
function mapV2_adj.AdjustResPickUpTypeToClient(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResPickUpTypeToClient)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
end

--region metatable mapV2.ResActivityMapInfo
---@type mapV2.ResActivityMapInfo
mapV2_adj.metatable_ResActivityMapInfo = {
    _ClassName = "mapV2.ResActivityMapInfo",
}
mapV2_adj.metatable_ResActivityMapInfo.__index = mapV2_adj.metatable_ResActivityMapInfo
--endregion

---@param tbl mapV2.ResActivityMapInfo 待调整的table数据
function mapV2_adj.AdjustResActivityMapInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ResActivityMapInfo)
    if tbl.monsterNumber == nil then
        tbl.monsterNumberSpecified = false
        tbl.monsterNumber = 0
    else
        tbl.monsterNumberSpecified = true
    end
end

--region metatable mapV2.ReqItemRadioTransfer
---@type mapV2.ReqItemRadioTransfer
mapV2_adj.metatable_ReqItemRadioTransfer = {
    _ClassName = "mapV2.ReqItemRadioTransfer",
}
mapV2_adj.metatable_ReqItemRadioTransfer.__index = mapV2_adj.metatable_ReqItemRadioTransfer
--endregion

---@param tbl mapV2.ReqItemRadioTransfer 待调整的table数据
function mapV2_adj.AdjustReqItemRadioTransfer(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, mapV2_adj.metatable_ReqItemRadioTransfer)
    if tbl.boothCoordinateId == nil then
        tbl.boothCoordinateIdSpecified = false
        tbl.boothCoordinateId = 0
    else
        tbl.boothCoordinateIdSpecified = true
    end
    if tbl.boothId == nil then
        tbl.boothIdSpecified = false
        tbl.boothId = 0
    else
        tbl.boothIdSpecified = true
    end
end

return mapV2_adj