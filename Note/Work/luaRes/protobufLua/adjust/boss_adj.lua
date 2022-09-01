--[[本文件为工具自动生成,禁止手动修改]]
local bossV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable bossV2.PersonalBossInfo
---@type bossV2.PersonalBossInfo
bossV2_adj.metatable_PersonalBossInfo = {
    _ClassName = "bossV2.PersonalBossInfo",
}
bossV2_adj.metatable_PersonalBossInfo.__index = bossV2_adj.metatable_PersonalBossInfo
--endregion

---@param tbl bossV2.PersonalBossInfo 待调整的table数据
function bossV2_adj.AdjustPersonalBossInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_PersonalBossInfo)
    if tbl.instanceId == nil then
        tbl.instanceIdSpecified = false
        tbl.instanceId = 0
    else
        tbl.instanceIdSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.surplusNum == nil then
        tbl.surplusNumSpecified = false
        tbl.surplusNum = 0
    else
        tbl.surplusNumSpecified = true
    end
    if tbl.freshTime == nil then
        tbl.freshTimeSpecified = false
        tbl.freshTime = 0
    else
        tbl.freshTimeSpecified = true
    end
end

--region metatable bossV2.InstanceInfo
---@type bossV2.InstanceInfo
bossV2_adj.metatable_InstanceInfo = {
    _ClassName = "bossV2.InstanceInfo",
}
bossV2_adj.metatable_InstanceInfo.__index = bossV2_adj.metatable_InstanceInfo
--endregion

---@param tbl bossV2.InstanceInfo 待调整的table数据
function bossV2_adj.AdjustInstanceInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_InstanceInfo)
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
    if tbl.surplusNum == nil then
        tbl.surplusNumSpecified = false
        tbl.surplusNum = 0
    else
        tbl.surplusNumSpecified = true
    end
    if tbl.freshTime == nil then
        tbl.freshTimeSpecified = false
        tbl.freshTime = 0
    else
        tbl.freshTimeSpecified = true
    end
end

--region metatable bossV2.BossKillerInfo
---@type bossV2.BossKillerInfo
bossV2_adj.metatable_BossKillerInfo = {
    _ClassName = "bossV2.BossKillerInfo",
}
bossV2_adj.metatable_BossKillerInfo.__index = bossV2_adj.metatable_BossKillerInfo
--endregion

---@param tbl bossV2.BossKillerInfo 待调整的table数据
function bossV2_adj.AdjustBossKillerInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_BossKillerInfo)
    if tbl.killTime == nil then
        tbl.killTimeSpecified = false
        tbl.killTime = 0
    else
        tbl.killTimeSpecified = true
    end
    if tbl.killerName == nil then
        tbl.killerNameSpecified = false
        tbl.killerName = ""
    else
        tbl.killerNameSpecified = true
    end
    if tbl.killerPower == nil then
        tbl.killerPowerSpecified = false
        tbl.killerPower = 0
    else
        tbl.killerPowerSpecified = true
    end
end

--region metatable bossV2.ReqInstancePanelInfo
---@type bossV2.ReqInstancePanelInfo
bossV2_adj.metatable_ReqInstancePanelInfo = {
    _ClassName = "bossV2.ReqInstancePanelInfo",
}
bossV2_adj.metatable_ReqInstancePanelInfo.__index = bossV2_adj.metatable_ReqInstancePanelInfo
--endregion

---@param tbl bossV2.ReqInstancePanelInfo 待调整的table数据
function bossV2_adj.AdjustReqInstancePanelInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_ReqInstancePanelInfo)
    if tbl.insType == nil then
        tbl.insTypeSpecified = false
        tbl.insType = 0
    else
        tbl.insTypeSpecified = true
    end
end

--region metatable bossV2.ResPersonalBossInfo
---@type bossV2.ResPersonalBossInfo
bossV2_adj.metatable_ResPersonalBossInfo = {
    _ClassName = "bossV2.ResPersonalBossInfo",
}
bossV2_adj.metatable_ResPersonalBossInfo.__index = bossV2_adj.metatable_ResPersonalBossInfo
--endregion

---@param tbl bossV2.ResPersonalBossInfo 待调整的table数据
function bossV2_adj.AdjustResPersonalBossInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_ResPersonalBossInfo)
    if tbl.bossInfo == nil then
        tbl.bossInfo = {}
    else
        if bossV2_adj.AdjustPersonalBossInfo ~= nil then
            for i = 1, #tbl.bossInfo do
                bossV2_adj.AdjustPersonalBossInfo(tbl.bossInfo[i])
            end
        end
    end
end

--region metatable bossV2.ReqSwapPersonalBoss
---@type bossV2.ReqSwapPersonalBoss
bossV2_adj.metatable_ReqSwapPersonalBoss = {
    _ClassName = "bossV2.ReqSwapPersonalBoss",
}
bossV2_adj.metatable_ReqSwapPersonalBoss.__index = bossV2_adj.metatable_ReqSwapPersonalBoss
--endregion

---@param tbl bossV2.ReqSwapPersonalBoss 待调整的table数据
function bossV2_adj.AdjustReqSwapPersonalBoss(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_ReqSwapPersonalBoss)
    if tbl.instanceId == nil then
        tbl.instanceIdSpecified = false
        tbl.instanceId = 0
    else
        tbl.instanceIdSpecified = true
    end
end

--region metatable bossV2.ResBossActivityOpen
---@type bossV2.ResBossActivityOpen
bossV2_adj.metatable_ResBossActivityOpen = {
    _ClassName = "bossV2.ResBossActivityOpen",
}
bossV2_adj.metatable_ResBossActivityOpen.__index = bossV2_adj.metatable_ResBossActivityOpen
--endregion

---@param tbl bossV2.ResBossActivityOpen 待调整的table数据
function bossV2_adj.AdjustResBossActivityOpen(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_ResBossActivityOpen)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.instanceId == nil then
        tbl.instanceIdSpecified = false
        tbl.instanceId = 0
    else
        tbl.instanceIdSpecified = true
    end
    if tbl.params == nil then
        tbl.paramsSpecified = false
        tbl.params = 0
    else
        tbl.paramsSpecified = true
    end
end

--region metatable bossV2.ReqFieldBossInfo
---@type bossV2.ReqFieldBossInfo
bossV2_adj.metatable_ReqFieldBossInfo = {
    _ClassName = "bossV2.ReqFieldBossInfo",
}
bossV2_adj.metatable_ReqFieldBossInfo.__index = bossV2_adj.metatable_ReqFieldBossInfo
--endregion

---@param tbl bossV2.ReqFieldBossInfo 待调整的table数据
function bossV2_adj.AdjustReqFieldBossInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_ReqFieldBossInfo)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.subType == nil then
        tbl.subTypeSpecified = false
        tbl.subType = 0
    else
        tbl.subTypeSpecified = true
    end
end

--region metatable bossV2.FieldBossInfo
---@type bossV2.FieldBossInfo
bossV2_adj.metatable_FieldBossInfo = {
    _ClassName = "bossV2.FieldBossInfo",
}
bossV2_adj.metatable_FieldBossInfo.__index = bossV2_adj.metatable_FieldBossInfo
--endregion

---@param tbl bossV2.FieldBossInfo 待调整的table数据
function bossV2_adj.AdjustFieldBossInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_FieldBossInfo)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.configId == nil then
        tbl.configIdSpecified = false
        tbl.configId = 0
    else
        tbl.configIdSpecified = true
    end
    if tbl.freshTime == nil then
        tbl.freshTimeSpecified = false
        tbl.freshTime = 0
    else
        tbl.freshTimeSpecified = true
    end
    if tbl.killCount == nil then
        tbl.killCountSpecified = false
        tbl.killCount = 0
    else
        tbl.killCountSpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.bossId == nil then
        tbl.bossIdSpecified = false
        tbl.bossId = 0
    else
        tbl.bossIdSpecified = true
    end
    if tbl.peopleCount == nil then
        tbl.peopleCountSpecified = false
        tbl.peopleCount = 0
    else
        tbl.peopleCountSpecified = true
    end
    if tbl.totalCount == nil then
        tbl.totalCountSpecified = false
        tbl.totalCount = 0
    else
        tbl.totalCountSpecified = true
    end
    if tbl.sign == nil then
        tbl.signSpecified = false
        tbl.sign = 0
    else
        tbl.signSpecified = true
    end
end

--region metatable bossV2.ResFieldBossInfo
---@type bossV2.ResFieldBossInfo
bossV2_adj.metatable_ResFieldBossInfo = {
    _ClassName = "bossV2.ResFieldBossInfo",
}
bossV2_adj.metatable_ResFieldBossInfo.__index = bossV2_adj.metatable_ResFieldBossInfo
--endregion

---@param tbl bossV2.ResFieldBossInfo 待调整的table数据
function bossV2_adj.AdjustResFieldBossInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_ResFieldBossInfo)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.boss == nil then
        tbl.boss = {}
    else
        if bossV2_adj.AdjustFieldBossInfo ~= nil then
            for i = 1, #tbl.boss do
                bossV2_adj.AdjustFieldBossInfo(tbl.boss[i])
            end
        end
    end
    if tbl.subType == nil then
        tbl.subTypeSpecified = false
        tbl.subType = 0
    else
        tbl.subTypeSpecified = true
    end
end

--region metatable bossV2.ResBossRefresh
---@type bossV2.ResBossRefresh
bossV2_adj.metatable_ResBossRefresh = {
    _ClassName = "bossV2.ResBossRefresh",
}
bossV2_adj.metatable_ResBossRefresh.__index = bossV2_adj.metatable_ResBossRefresh
--endregion

---@param tbl bossV2.ResBossRefresh 待调整的table数据
function bossV2_adj.AdjustResBossRefresh(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_ResBossRefresh)
    if tbl.bossType == nil then
        tbl.bossTypeSpecified = false
        tbl.bossType = 0
    else
        tbl.bossTypeSpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
end

--region metatable bossV2.ResBossDie
---@type bossV2.ResBossDie
bossV2_adj.metatable_ResBossDie = {
    _ClassName = "bossV2.ResBossDie",
}
bossV2_adj.metatable_ResBossDie.__index = bossV2_adj.metatable_ResBossDie
--endregion

---@param tbl bossV2.ResBossDie 待调整的table数据
function bossV2_adj.AdjustResBossDie(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_ResBossDie)
    if tbl.bossType == nil then
        tbl.bossTypeSpecified = false
        tbl.bossType = 0
    else
        tbl.bossTypeSpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable bossV2.MinMapBossInfo
---@type bossV2.MinMapBossInfo
bossV2_adj.metatable_MinMapBossInfo = {
    _ClassName = "bossV2.MinMapBossInfo",
}
bossV2_adj.metatable_MinMapBossInfo.__index = bossV2_adj.metatable_MinMapBossInfo
--endregion

---@param tbl bossV2.MinMapBossInfo 待调整的table数据
function bossV2_adj.AdjustMinMapBossInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_MinMapBossInfo)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.configId == nil then
        tbl.configIdSpecified = false
        tbl.configId = 0
    else
        tbl.configIdSpecified = true
    end
    if tbl.freshTime == nil then
        tbl.freshTimeSpecified = false
        tbl.freshTime = 0
    else
        tbl.freshTimeSpecified = true
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

--region metatable bossV2.ResMinMapInfo
---@type bossV2.ResMinMapInfo
bossV2_adj.metatable_ResMinMapInfo = {
    _ClassName = "bossV2.ResMinMapInfo",
}
bossV2_adj.metatable_ResMinMapInfo.__index = bossV2_adj.metatable_ResMinMapInfo
--endregion

---@param tbl bossV2.ResMinMapInfo 待调整的table数据
function bossV2_adj.AdjustResMinMapInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_ResMinMapInfo)
    if tbl.updateType == nil then
        tbl.updateTypeSpecified = false
        tbl.updateType = 0
    else
        tbl.updateTypeSpecified = true
    end
    if tbl.boss == nil then
        tbl.boss = {}
    else
        if bossV2_adj.AdjustMinMapBossInfo ~= nil then
            for i = 1, #tbl.boss do
                bossV2_adj.AdjustMinMapBossInfo(tbl.boss[i])
            end
        end
    end
    if tbl.addEvents == nil then
        tbl.addEvents = {}
    else
        if adjustTable.map_adj ~= nil and adjustTable.map_adj.AdjustRoundEventInfo ~= nil then
            for i = 1, #tbl.addEvents do
                adjustTable.map_adj.AdjustRoundEventInfo(tbl.addEvents[i])
            end
        end
    end
end

--region metatable bossV2.ReqGetBossInfo
---@type bossV2.ReqGetBossInfo
bossV2_adj.metatable_ReqGetBossInfo = {
    _ClassName = "bossV2.ReqGetBossInfo",
}
bossV2_adj.metatable_ReqGetBossInfo.__index = bossV2_adj.metatable_ReqGetBossInfo
--endregion

---@param tbl bossV2.ReqGetBossInfo 待调整的table数据
function bossV2_adj.AdjustReqGetBossInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_ReqGetBossInfo)
    if tbl.id == nil then
        tbl.id = {}
    end
end

--region metatable bossV2.GetBossInfo
---@type bossV2.GetBossInfo
bossV2_adj.metatable_GetBossInfo = {
    _ClassName = "bossV2.GetBossInfo",
}
bossV2_adj.metatable_GetBossInfo.__index = bossV2_adj.metatable_GetBossInfo
--endregion

---@param tbl bossV2.GetBossInfo 待调整的table数据
function bossV2_adj.AdjustGetBossInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_GetBossInfo)
    if tbl.mid == nil then
        tbl.midSpecified = false
        tbl.mid = 0
    else
        tbl.midSpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.isAlive == nil then
        tbl.isAliveSpecified = false
        tbl.isAlive = false
    else
        tbl.isAliveSpecified = true
    end
end

--region metatable bossV2.ResGetBossInfo
---@type bossV2.ResGetBossInfo
bossV2_adj.metatable_ResGetBossInfo = {
    _ClassName = "bossV2.ResGetBossInfo",
}
bossV2_adj.metatable_ResGetBossInfo.__index = bossV2_adj.metatable_ResGetBossInfo
--endregion

---@param tbl bossV2.ResGetBossInfo 待调整的table数据
function bossV2_adj.AdjustResGetBossInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_ResGetBossInfo)
    if tbl.bosses == nil then
        tbl.bosses = {}
    else
        if bossV2_adj.AdjustGetBossInfo ~= nil then
            for i = 1, #tbl.bosses do
                bossV2_adj.AdjustGetBossInfo(tbl.bosses[i])
            end
        end
    end
end

--region metatable bossV2.ReqAncientBossDamageRank
---@type bossV2.ReqAncientBossDamageRank
bossV2_adj.metatable_ReqAncientBossDamageRank = {
    _ClassName = "bossV2.ReqAncientBossDamageRank",
}
bossV2_adj.metatable_ReqAncientBossDamageRank.__index = bossV2_adj.metatable_ReqAncientBossDamageRank
--endregion

---@param tbl bossV2.ReqAncientBossDamageRank 待调整的table数据
function bossV2_adj.AdjustReqAncientBossDamageRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_ReqAncientBossDamageRank)
end

--region metatable bossV2.AncientBossDamageRank
---@type bossV2.AncientBossDamageRank
bossV2_adj.metatable_AncientBossDamageRank = {
    _ClassName = "bossV2.AncientBossDamageRank",
}
bossV2_adj.metatable_AncientBossDamageRank.__index = bossV2_adj.metatable_AncientBossDamageRank
--endregion

---@param tbl bossV2.AncientBossDamageRank 待调整的table数据
function bossV2_adj.AdjustAncientBossDamageRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_AncientBossDamageRank)
    if tbl.roleName == nil then
        tbl.roleNameSpecified = false
        tbl.roleName = ""
    else
        tbl.roleNameSpecified = true
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
    if tbl.rein == nil then
        tbl.reinSpecified = false
        tbl.rein = 0
    else
        tbl.reinSpecified = true
    end
    if tbl.hurt == nil then
        tbl.hurtSpecified = false
        tbl.hurt = 0
    else
        tbl.hurtSpecified = true
    end
    if tbl.rank == nil then
        tbl.rankSpecified = false
        tbl.rank = 0
    else
        tbl.rankSpecified = true
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
    if tbl.unionRank == nil then
        tbl.unionRankSpecified = false
        tbl.unionRank = 0
    else
        tbl.unionRankSpecified = true
    end
end

--region metatable bossV2.ResAncientBossDamageRank
---@type bossV2.ResAncientBossDamageRank
bossV2_adj.metatable_ResAncientBossDamageRank = {
    _ClassName = "bossV2.ResAncientBossDamageRank",
}
bossV2_adj.metatable_ResAncientBossDamageRank.__index = bossV2_adj.metatable_ResAncientBossDamageRank
--endregion

---@param tbl bossV2.ResAncientBossDamageRank 待调整的table数据
function bossV2_adj.AdjustResAncientBossDamageRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_ResAncientBossDamageRank)
    if tbl.damageRank == nil then
        tbl.damageRank = {}
    else
        if bossV2_adj.AdjustAncientBossDamageRank ~= nil then
            for i = 1, #tbl.damageRank do
                bossV2_adj.AdjustAncientBossDamageRank(tbl.damageRank[i])
            end
        end
    end
end

--region metatable bossV2.ResHasAncientBossAlive
---@type bossV2.ResHasAncientBossAlive
bossV2_adj.metatable_ResHasAncientBossAlive = {
    _ClassName = "bossV2.ResHasAncientBossAlive",
}
bossV2_adj.metatable_ResHasAncientBossAlive.__index = bossV2_adj.metatable_ResHasAncientBossAlive
--endregion

---@param tbl bossV2.ResHasAncientBossAlive 待调整的table数据
function bossV2_adj.AdjustResHasAncientBossAlive(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_ResHasAncientBossAlive)
end

--region metatable bossV2.RefreshDemonBossInfo
---@type bossV2.RefreshDemonBossInfo
bossV2_adj.metatable_RefreshDemonBossInfo = {
    _ClassName = "bossV2.RefreshDemonBossInfo",
}
bossV2_adj.metatable_RefreshDemonBossInfo.__index = bossV2_adj.metatable_RefreshDemonBossInfo
--endregion

---@param tbl bossV2.RefreshDemonBossInfo 待调整的table数据
function bossV2_adj.AdjustRefreshDemonBossInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_RefreshDemonBossInfo)
    if tbl.bossInfo == nil then
        tbl.bossInfoSpecified = false
        tbl.bossInfo = nil
    else
        if tbl.bossInfoSpecified == nil then 
            tbl.bossInfoSpecified = true
            if bossV2_adj.AdjustFieldBossInfo ~= nil then
                bossV2_adj.AdjustFieldBossInfo(tbl.bossInfo)
            end
        end
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable bossV2.ResOmenComeBossInfo
---@type bossV2.ResOmenComeBossInfo
bossV2_adj.metatable_ResOmenComeBossInfo = {
    _ClassName = "bossV2.ResOmenComeBossInfo",
}
bossV2_adj.metatable_ResOmenComeBossInfo.__index = bossV2_adj.metatable_ResOmenComeBossInfo
--endregion

---@param tbl bossV2.ResOmenComeBossInfo 待调整的table数据
function bossV2_adj.AdjustResOmenComeBossInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_ResOmenComeBossInfo)
    if tbl.boss == nil then
        tbl.boss = {}
    else
        if bossV2_adj.AdjustOmenComeBoss ~= nil then
            for i = 1, #tbl.boss do
                bossV2_adj.AdjustOmenComeBoss(tbl.boss[i])
            end
        end
    end
end

--region metatable bossV2.OmenComeBoss
---@type bossV2.OmenComeBoss
bossV2_adj.metatable_OmenComeBoss = {
    _ClassName = "bossV2.OmenComeBoss",
}
bossV2_adj.metatable_OmenComeBoss.__index = bossV2_adj.metatable_OmenComeBoss
--endregion

---@param tbl bossV2.OmenComeBoss 待调整的table数据
function bossV2_adj.AdjustOmenComeBoss(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_OmenComeBoss)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.hasCount == nil then
        tbl.hasCountSpecified = false
        tbl.hasCount = 0
    else
        tbl.hasCountSpecified = true
    end
    if tbl.deliver == nil then
        tbl.deliverSpecified = false
        tbl.deliver = 0
    else
        tbl.deliverSpecified = true
    end
end

--region metatable bossV2.ReqUseMonsterCleanUpCoupons
---@type bossV2.ReqUseMonsterCleanUpCoupons
bossV2_adj.metatable_ReqUseMonsterCleanUpCoupons = {
    _ClassName = "bossV2.ReqUseMonsterCleanUpCoupons",
}
bossV2_adj.metatable_ReqUseMonsterCleanUpCoupons.__index = bossV2_adj.metatable_ReqUseMonsterCleanUpCoupons
--endregion

---@param tbl bossV2.ReqUseMonsterCleanUpCoupons 待调整的table数据
function bossV2_adj.AdjustReqUseMonsterCleanUpCoupons(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bossV2_adj.metatable_ReqUseMonsterCleanUpCoupons)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.theId == nil then
        tbl.theIdSpecified = false
        tbl.theId = 0
    else
        tbl.theIdSpecified = true
    end
    if tbl.monsterId == nil then
        tbl.monsterIdSpecified = false
        tbl.monsterId = 0
    else
        tbl.monsterIdSpecified = true
    end
end

return bossV2_adj