--[[本文件为工具自动生成,禁止手动修改]]
local playV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable playV2.BossStateInfo
---@type playV2.BossStateInfo
playV2_adj.metatable_BossStateInfo = {
    _ClassName = "playV2.BossStateInfo",
}
playV2_adj.metatable_BossStateInfo.__index = playV2_adj.metatable_BossStateInfo
--endregion

---@param tbl playV2.BossStateInfo 待调整的table数据
function playV2_adj.AdjustBossStateInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_BossStateInfo)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.enterCount == nil then
        tbl.enterCountSpecified = false
        tbl.enterCount = 0
    else
        tbl.enterCountSpecified = true
    end
    if tbl.totalCount == nil then
        tbl.totalCountSpecified = false
        tbl.totalCount = 0
    else
        tbl.totalCountSpecified = true
    end
    if tbl.nextAddTime == nil then
        tbl.nextAddTimeSpecified = false
        tbl.nextAddTime = 0
    else
        tbl.nextAddTimeSpecified = true
    end
    if tbl.hp == nil then
        tbl.hpSpecified = false
        tbl.hp = 0
    else
        tbl.hpSpecified = true
    end
    if tbl.num == nil then
        tbl.numSpecified = false
        tbl.num = 0
    else
        tbl.numSpecified = true
    end
    if tbl.ownerName == nil then
        tbl.ownerNameSpecified = false
        tbl.ownerName = ""
    else
        tbl.ownerNameSpecified = true
    end
    if tbl.selectState == nil then
        tbl.selectStateSpecified = false
        tbl.selectState = 0
    else
        tbl.selectStateSpecified = true
    end
    if tbl.reliveTime == nil then
        tbl.reliveTimeSpecified = false
        tbl.reliveTime = 0
    else
        tbl.reliveTimeSpecified = true
    end
    if tbl.forgeryId == nil then
        tbl.forgeryIdSpecified = false
        tbl.forgeryId = 0
    else
        tbl.forgeryIdSpecified = true
    end
    if tbl.ownerDropCount == nil then
        tbl.ownerDropCountSpecified = false
        tbl.ownerDropCount = 0
    else
        tbl.ownerDropCountSpecified = true
    end
    if tbl.ownerDropNextAddTime == nil then
        tbl.ownerDropNextAddTimeSpecified = false
        tbl.ownerDropNextAddTime = 0
    else
        tbl.ownerDropNextAddTimeSpecified = true
    end
    if tbl.helperDropCount == nil then
        tbl.helperDropCountSpecified = false
        tbl.helperDropCount = 0
    else
        tbl.helperDropCountSpecified = true
    end
    if tbl.helperDropNextAddTime == nil then
        tbl.helperDropNextAddTimeSpecified = false
        tbl.helperDropNextAddTime = 0
    else
        tbl.helperDropNextAddTimeSpecified = true
    end
    if tbl.leftOwnerDropBuyCount == nil then
        tbl.leftOwnerDropBuyCountSpecified = false
        tbl.leftOwnerDropBuyCount = 0
    else
        tbl.leftOwnerDropBuyCountSpecified = true
    end
    if tbl.leftEnterBuyCount == nil then
        tbl.leftEnterBuyCountSpecified = false
        tbl.leftEnterBuyCount = 0
    else
        tbl.leftEnterBuyCountSpecified = true
    end
end

--region metatable playV2.BestAttInfo
---@type playV2.BestAttInfo
playV2_adj.metatable_BestAttInfo = {
    _ClassName = "playV2.BestAttInfo",
}
playV2_adj.metatable_BestAttInfo.__index = playV2_adj.metatable_BestAttInfo
--endregion

---@param tbl playV2.BestAttInfo 待调整的table数据
function playV2_adj.AdjustBestAttInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_BestAttInfo)
    if tbl.attId == nil then
        tbl.attIdSpecified = false
        tbl.attId = 0
    else
        tbl.attIdSpecified = true
    end
    if tbl.attType == nil then
        tbl.attTypeSpecified = false
        tbl.attType = 0
    else
        tbl.attTypeSpecified = true
    end
    if tbl.attValue == nil then
        tbl.attValueSpecified = false
        tbl.attValue = 0
    else
        tbl.attValueSpecified = true
    end
    if tbl.param == nil then
        tbl.paramSpecified = false
        tbl.param = 0
    else
        tbl.paramSpecified = true
    end
    if tbl.power == nil then
        tbl.powerSpecified = false
        tbl.power = 0
    else
        tbl.powerSpecified = true
    end
end

--region metatable playV2.ItemInfo
---@type playV2.ItemInfo
playV2_adj.metatable_ItemInfo = {
    _ClassName = "playV2.ItemInfo",
}
playV2_adj.metatable_ItemInfo.__index = playV2_adj.metatable_ItemInfo
--endregion

---@param tbl playV2.ItemInfo 待调整的table数据
function playV2_adj.AdjustItemInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ItemInfo)
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
    if tbl.bestAttInfo == nil then
        tbl.bestAttInfoSpecified = false
        tbl.bestAttInfo = nil
    else
        if tbl.bestAttInfoSpecified == nil then 
            tbl.bestAttInfoSpecified = true
            if playV2_adj.AdjustBestAttInfo ~= nil then
                playV2_adj.AdjustBestAttInfo(tbl.bestAttInfo)
            end
        end
    end
end

--region metatable playV2.ItmeUseInfo
---@type playV2.ItmeUseInfo
playV2_adj.metatable_ItmeUseInfo = {
    _ClassName = "playV2.ItmeUseInfo",
}
playV2_adj.metatable_ItmeUseInfo.__index = playV2_adj.metatable_ItmeUseInfo
--endregion

---@param tbl playV2.ItmeUseInfo 待调整的table数据
function playV2_adj.AdjustItmeUseInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ItmeUseInfo)
    if tbl.globalId == nil then
        tbl.globalIdSpecified = false
        tbl.globalId = 0
    else
        tbl.globalIdSpecified = true
    end
    if tbl.useNum == nil then
        tbl.useNumSpecified = false
        tbl.useNum = 0
    else
        tbl.useNumSpecified = true
    end
end

--region metatable playV2.RemindInfo
---@type playV2.RemindInfo
playV2_adj.metatable_RemindInfo = {
    _ClassName = "playV2.RemindInfo",
}
playV2_adj.metatable_RemindInfo.__index = playV2_adj.metatable_RemindInfo
--endregion

---@param tbl playV2.RemindInfo 待调整的table数据
function playV2_adj.AdjustRemindInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_RemindInfo)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable playV2.ResWorldBossDie
---@type playV2.ResWorldBossDie
playV2_adj.metatable_ResWorldBossDie = {
    _ClassName = "playV2.ResWorldBossDie",
}
playV2_adj.metatable_ResWorldBossDie.__index = playV2_adj.metatable_ResWorldBossDie
--endregion

---@param tbl playV2.ResWorldBossDie 待调整的table数据
function playV2_adj.AdjustResWorldBossDie(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ResWorldBossDie)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.itemInfo == nil then
        tbl.itemInfo = {}
    else
        if playV2_adj.AdjustItemInfo ~= nil then
            for i = 1, #tbl.itemInfo do
                playV2_adj.AdjustItemInfo(tbl.itemInfo[i])
            end
        end
    end
    if tbl.dropType == nil then
        tbl.dropTypeSpecified = false
        tbl.dropType = ""
    else
        tbl.dropTypeSpecified = true
    end
end

--region metatable playV2.ReqRewardWorldBoss
---@type playV2.ReqRewardWorldBoss
playV2_adj.metatable_ReqRewardWorldBoss = {
    _ClassName = "playV2.ReqRewardWorldBoss",
}
playV2_adj.metatable_ReqRewardWorldBoss.__index = playV2_adj.metatable_ReqRewardWorldBoss
--endregion

---@param tbl playV2.ReqRewardWorldBoss 待调整的table数据
function playV2_adj.AdjustReqRewardWorldBoss(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ReqRewardWorldBoss)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
end

--region metatable playV2.ReqEnterPlayMap
---@type playV2.ReqEnterPlayMap
playV2_adj.metatable_ReqEnterPlayMap = {
    _ClassName = "playV2.ReqEnterPlayMap",
}
playV2_adj.metatable_ReqEnterPlayMap.__index = playV2_adj.metatable_ReqEnterPlayMap
--endregion

---@param tbl playV2.ReqEnterPlayMap 待调整的table数据
function playV2_adj.AdjustReqEnterPlayMap(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ReqEnterPlayMap)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
end

--region metatable playV2.ResHudunTrigger
---@type playV2.ResHudunTrigger
playV2_adj.metatable_ResHudunTrigger = {
    _ClassName = "playV2.ResHudunTrigger",
}
playV2_adj.metatable_ResHudunTrigger.__index = playV2_adj.metatable_ResHudunTrigger
--endregion

---@param tbl playV2.ResHudunTrigger 待调整的table数据
function playV2_adj.AdjustResHudunTrigger(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ResHudunTrigger)
    if tbl.triggerCount == nil then
        tbl.triggerCountSpecified = false
        tbl.triggerCount = 0
    else
        tbl.triggerCountSpecified = true
    end
end

--region metatable playV2.ResHudunChange
---@type playV2.ResHudunChange
playV2_adj.metatable_ResHudunChange = {
    _ClassName = "playV2.ResHudunChange",
}
playV2_adj.metatable_ResHudunChange.__index = playV2_adj.metatable_ResHudunChange
--endregion

---@param tbl playV2.ResHudunChange 待调整的table数据
function playV2_adj.AdjustResHudunChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ResHudunChange)
    if tbl.maxCount == nil then
        tbl.maxCountSpecified = false
        tbl.maxCount = 0
    else
        tbl.maxCountSpecified = true
    end
    if tbl.dunCount == nil then
        tbl.dunCountSpecified = false
        tbl.dunCount = 0
    else
        tbl.dunCountSpecified = true
    end
end

--region metatable playV2.ResRollPoint
---@type playV2.ResRollPoint
playV2_adj.metatable_ResRollPoint = {
    _ClassName = "playV2.ResRollPoint",
}
playV2_adj.metatable_ResRollPoint.__index = playV2_adj.metatable_ResRollPoint
--endregion

---@param tbl playV2.ResRollPoint 待调整的table数据
function playV2_adj.AdjustResRollPoint(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ResRollPoint)
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable playV2.ResMaxRollPoint
---@type playV2.ResMaxRollPoint
playV2_adj.metatable_ResMaxRollPoint = {
    _ClassName = "playV2.ResMaxRollPoint",
}
playV2_adj.metatable_ResMaxRollPoint.__index = playV2_adj.metatable_ResMaxRollPoint
--endregion

---@param tbl playV2.ResMaxRollPoint 待调整的table数据
function playV2_adj.AdjustResMaxRollPoint(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ResMaxRollPoint)
    if tbl.maxCount == nil then
        tbl.maxCountSpecified = false
        tbl.maxCount = 0
    else
        tbl.maxCountSpecified = true
    end
    if tbl.roleName == nil then
        tbl.roleNameSpecified = false
        tbl.roleName = ""
    else
        tbl.roleNameSpecified = true
    end
end

--region metatable playV2.ReqFetchWorldBossState
---@type playV2.ReqFetchWorldBossState
playV2_adj.metatable_ReqFetchWorldBossState = {
    _ClassName = "playV2.ReqFetchWorldBossState",
}
playV2_adj.metatable_ReqFetchWorldBossState.__index = playV2_adj.metatable_ReqFetchWorldBossState
--endregion

---@param tbl playV2.ReqFetchWorldBossState 待调整的table数据
function playV2_adj.AdjustReqFetchWorldBossState(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ReqFetchWorldBossState)
    if tbl.mapType == nil then
        tbl.mapTypeSpecified = false
        tbl.mapType = 0
    else
        tbl.mapTypeSpecified = true
    end
end

--region metatable playV2.ResFetchWorldBossState
---@type playV2.ResFetchWorldBossState
playV2_adj.metatable_ResFetchWorldBossState = {
    _ClassName = "playV2.ResFetchWorldBossState",
}
playV2_adj.metatable_ResFetchWorldBossState.__index = playV2_adj.metatable_ResFetchWorldBossState
--endregion

---@param tbl playV2.ResFetchWorldBossState 待调整的table数据
function playV2_adj.AdjustResFetchWorldBossState(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ResFetchWorldBossState)
    if tbl.mapType == nil then
        tbl.mapTypeSpecified = false
        tbl.mapType = 0
    else
        tbl.mapTypeSpecified = true
    end
    if tbl.stateList == nil then
        tbl.stateList = {}
    else
        if playV2_adj.AdjustBossStateInfo ~= nil then
            for i = 1, #tbl.stateList do
                playV2_adj.AdjustBossStateInfo(tbl.stateList[i])
            end
        end
    end
end

--region metatable playV2.ReqUseFightItem
---@type playV2.ReqUseFightItem
playV2_adj.metatable_ReqUseFightItem = {
    _ClassName = "playV2.ReqUseFightItem",
}
playV2_adj.metatable_ReqUseFightItem.__index = playV2_adj.metatable_ReqUseFightItem
--endregion

---@param tbl playV2.ReqUseFightItem 待调整的table数据
function playV2_adj.AdjustReqUseFightItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ReqUseFightItem)
    if tbl.globalId == nil then
        tbl.globalIdSpecified = false
        tbl.globalId = 0
    else
        tbl.globalIdSpecified = true
    end
end

--region metatable playV2.ResFightItemBuyCount
---@type playV2.ResFightItemBuyCount
playV2_adj.metatable_ResFightItemBuyCount = {
    _ClassName = "playV2.ResFightItemBuyCount",
}
playV2_adj.metatable_ResFightItemBuyCount.__index = playV2_adj.metatable_ResFightItemBuyCount
--endregion

---@param tbl playV2.ResFightItemBuyCount 待调整的table数据
function playV2_adj.AdjustResFightItemBuyCount(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ResFightItemBuyCount)
    if tbl.useInfos == nil then
        tbl.useInfos = {}
    else
        if playV2_adj.AdjustItmeUseInfo ~= nil then
            for i = 1, #tbl.useInfos do
                playV2_adj.AdjustItmeUseInfo(tbl.useInfos[i])
            end
        end
    end
end

--region metatable playV2.ReqSetBossRemind
---@type playV2.ReqSetBossRemind
playV2_adj.metatable_ReqSetBossRemind = {
    _ClassName = "playV2.ReqSetBossRemind",
}
playV2_adj.metatable_ReqSetBossRemind.__index = playV2_adj.metatable_ReqSetBossRemind
--endregion

---@param tbl playV2.ReqSetBossRemind 待调整的table数据
function playV2_adj.AdjustReqSetBossRemind(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ReqSetBossRemind)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable playV2.ResSetBossRemind
---@type playV2.ResSetBossRemind
playV2_adj.metatable_ResSetBossRemind = {
    _ClassName = "playV2.ResSetBossRemind",
}
playV2_adj.metatable_ResSetBossRemind.__index = playV2_adj.metatable_ResSetBossRemind
--endregion

---@param tbl playV2.ResSetBossRemind 待调整的table数据
function playV2_adj.AdjustResSetBossRemind(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ResSetBossRemind)
    if tbl.remindList == nil then
        tbl.remindList = {}
    else
        if playV2_adj.AdjustRemindInfo ~= nil then
            for i = 1, #tbl.remindList do
                playV2_adj.AdjustRemindInfo(tbl.remindList[i])
            end
        end
    end
end

--region metatable playV2.ResBossRemindToRole
---@type playV2.ResBossRemindToRole
playV2_adj.metatable_ResBossRemindToRole = {
    _ClassName = "playV2.ResBossRemindToRole",
}
playV2_adj.metatable_ResBossRemindToRole.__index = playV2_adj.metatable_ResBossRemindToRole
--endregion

---@param tbl playV2.ResBossRemindToRole 待调整的table数据
function playV2_adj.AdjustResBossRemindToRole(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ResBossRemindToRole)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
end

--region metatable playV2.ResPlayerKillInfo
---@type playV2.ResPlayerKillInfo
playV2_adj.metatable_ResPlayerKillInfo = {
    _ClassName = "playV2.ResPlayerKillInfo",
}
playV2_adj.metatable_ResPlayerKillInfo.__index = playV2_adj.metatable_ResPlayerKillInfo
--endregion

---@param tbl playV2.ResPlayerKillInfo 待调整的table数据
function playV2_adj.AdjustResPlayerKillInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ResPlayerKillInfo)
    if tbl.playerId == nil then
        tbl.playerIdSpecified = false
        tbl.playerId = 0
    else
        tbl.playerIdSpecified = true
    end
    if tbl.playerName == nil then
        tbl.playerNameSpecified = false
        tbl.playerName = ""
    else
        tbl.playerNameSpecified = true
    end
    if tbl.killerId == nil then
        tbl.killerIdSpecified = false
        tbl.killerId = 0
    else
        tbl.killerIdSpecified = true
    end
    if tbl.killName == nil then
        tbl.killNameSpecified = false
        tbl.killName = ""
    else
        tbl.killNameSpecified = true
    end
end

--region metatable playV2.ResMapBossDeath
---@type playV2.ResMapBossDeath
playV2_adj.metatable_ResMapBossDeath = {
    _ClassName = "playV2.ResMapBossDeath",
}
playV2_adj.metatable_ResMapBossDeath.__index = playV2_adj.metatable_ResMapBossDeath
--endregion

---@param tbl playV2.ResMapBossDeath 待调整的table数据
function playV2_adj.AdjustResMapBossDeath(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ResMapBossDeath)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
end

--region metatable playV2.ReqBuyCount
---@type playV2.ReqBuyCount
playV2_adj.metatable_ReqBuyCount = {
    _ClassName = "playV2.ReqBuyCount",
}
playV2_adj.metatable_ReqBuyCount.__index = playV2_adj.metatable_ReqBuyCount
--endregion

---@param tbl playV2.ReqBuyCount 待调整的table数据
function playV2_adj.AdjustReqBuyCount(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ReqBuyCount)
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
end

--region metatable playV2.ResBossCount
---@type playV2.ResBossCount
playV2_adj.metatable_ResBossCount = {
    _ClassName = "playV2.ResBossCount",
}
playV2_adj.metatable_ResBossCount.__index = playV2_adj.metatable_ResBossCount
--endregion

---@param tbl playV2.ResBossCount 待调整的table数据
function playV2_adj.AdjustResBossCount(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ResBossCount)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.group == nil then
        tbl.groupSpecified = false
        tbl.group = 0
    else
        tbl.groupSpecified = true
    end
    if tbl.enterCount == nil then
        tbl.enterCountSpecified = false
        tbl.enterCount = 0
    else
        tbl.enterCountSpecified = true
    end
    if tbl.totalCount == nil then
        tbl.totalCountSpecified = false
        tbl.totalCount = 0
    else
        tbl.totalCountSpecified = true
    end
    if tbl.nextAddTime == nil then
        tbl.nextAddTimeSpecified = false
        tbl.nextAddTime = 0
    else
        tbl.nextAddTimeSpecified = true
    end
    if tbl.ownerDropCount == nil then
        tbl.ownerDropCountSpecified = false
        tbl.ownerDropCount = 0
    else
        tbl.ownerDropCountSpecified = true
    end
    if tbl.ownerDropNextAddTime == nil then
        tbl.ownerDropNextAddTimeSpecified = false
        tbl.ownerDropNextAddTime = 0
    else
        tbl.ownerDropNextAddTimeSpecified = true
    end
    if tbl.helperDropCount == nil then
        tbl.helperDropCountSpecified = false
        tbl.helperDropCount = 0
    else
        tbl.helperDropCountSpecified = true
    end
    if tbl.helperDropNextAddTime == nil then
        tbl.helperDropNextAddTimeSpecified = false
        tbl.helperDropNextAddTime = 0
    else
        tbl.helperDropNextAddTimeSpecified = true
    end
    if tbl.leftOwnerDropBuyCount == nil then
        tbl.leftOwnerDropBuyCountSpecified = false
        tbl.leftOwnerDropBuyCount = 0
    else
        tbl.leftOwnerDropBuyCountSpecified = true
    end
    if tbl.leftEnterBuyCount == nil then
        tbl.leftEnterBuyCountSpecified = false
        tbl.leftEnterBuyCount = 0
    else
        tbl.leftEnterBuyCountSpecified = true
    end
end

--region metatable playV2.CommonInfo
---@type playV2.CommonInfo
playV2_adj.metatable_CommonInfo = {
    _ClassName = "playV2.CommonInfo",
}
playV2_adj.metatable_CommonInfo.__index = playV2_adj.metatable_CommonInfo
--endregion

---@param tbl playV2.CommonInfo 待调整的table数据
function playV2_adj.AdjustCommonInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_CommonInfo)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.data == nil then
        tbl.dataSpecified = false
        tbl.data = 0
    else
        tbl.dataSpecified = true
    end
    if tbl.str == nil then
        tbl.strSpecified = false
        tbl.str = ""
    else
        tbl.strSpecified = true
    end
    if tbl.data64 == nil then
        tbl.data64Specified = false
        tbl.data64 = 0
    else
        tbl.data64Specified = true
    end
end

--region metatable playV2.ResCorpseDissolution
---@type playV2.ResCorpseDissolution
playV2_adj.metatable_ResCorpseDissolution = {
    _ClassName = "playV2.ResCorpseDissolution",
}
playV2_adj.metatable_ResCorpseDissolution.__index = playV2_adj.metatable_ResCorpseDissolution
--endregion

---@param tbl playV2.ResCorpseDissolution 待调整的table数据
function playV2_adj.AdjustResCorpseDissolution(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_ResCorpseDissolution)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
end

--region metatable playV2.NeedHasAttackModePanel
---@type playV2.NeedHasAttackModePanel
playV2_adj.metatable_NeedHasAttackModePanel = {
    _ClassName = "playV2.NeedHasAttackModePanel",
}
playV2_adj.metatable_NeedHasAttackModePanel.__index = playV2_adj.metatable_NeedHasAttackModePanel
--endregion

---@param tbl playV2.NeedHasAttackModePanel 待调整的table数据
function playV2_adj.AdjustNeedHasAttackModePanel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_NeedHasAttackModePanel)
    if tbl.current == nil then
        tbl.currentSpecified = false
        tbl.current = 0
    else
        tbl.currentSpecified = true
    end
    if tbl.need == nil then
        tbl.needSpecified = false
        tbl.need = 0
    else
        tbl.needSpecified = true
    end
    if tbl.activityType == nil then
        tbl.activityTypeSpecified = false
        tbl.activityType = 0
    else
        tbl.activityTypeSpecified = true
    end
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
end

--region metatable playV2.TodayNoReminder
---@type playV2.TodayNoReminder
playV2_adj.metatable_TodayNoReminder = {
    _ClassName = "playV2.TodayNoReminder",
}
playV2_adj.metatable_TodayNoReminder.__index = playV2_adj.metatable_TodayNoReminder
--endregion

---@param tbl playV2.TodayNoReminder 待调整的table数据
function playV2_adj.AdjustTodayNoReminder(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, playV2_adj.metatable_TodayNoReminder)
    if tbl.activityType == nil then
        tbl.activityTypeSpecified = false
        tbl.activityType = 0
    else
        tbl.activityTypeSpecified = true
    end
end

return playV2_adj