--[[本文件为工具自动生成,禁止手动修改]]
local playV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData playV2.BossStateInfo lua中的数据结构
---@return playV2.BossStateInfo C#中的数据结构
function playV2.BossStateInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.BossStateInfo()
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.enterCount ~= nil and decodedData.enterCountSpecified ~= false then
        data.enterCount = decodedData.enterCount
    end
    if decodedData.totalCount ~= nil and decodedData.totalCountSpecified ~= false then
        data.totalCount = decodedData.totalCount
    end
    if decodedData.nextAddTime ~= nil and decodedData.nextAddTimeSpecified ~= false then
        data.nextAddTime = decodedData.nextAddTime
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.num ~= nil and decodedData.numSpecified ~= false then
        data.num = decodedData.num
    end
    if decodedData.ownerName ~= nil and decodedData.ownerNameSpecified ~= false then
        data.ownerName = decodedData.ownerName
    end
    if decodedData.selectState ~= nil and decodedData.selectStateSpecified ~= false then
        data.selectState = decodedData.selectState
    end
    if decodedData.reliveTime ~= nil and decodedData.reliveTimeSpecified ~= false then
        data.reliveTime = decodedData.reliveTime
    end
    if decodedData.forgeryId ~= nil and decodedData.forgeryIdSpecified ~= false then
        data.forgeryId = decodedData.forgeryId
    end
    if decodedData.ownerDropCount ~= nil and decodedData.ownerDropCountSpecified ~= false then
        data.ownerDropCount = decodedData.ownerDropCount
    end
    if decodedData.ownerDropNextAddTime ~= nil and decodedData.ownerDropNextAddTimeSpecified ~= false then
        data.ownerDropNextAddTime = decodedData.ownerDropNextAddTime
    end
    if decodedData.helperDropCount ~= nil and decodedData.helperDropCountSpecified ~= false then
        data.helperDropCount = decodedData.helperDropCount
    end
    if decodedData.helperDropNextAddTime ~= nil and decodedData.helperDropNextAddTimeSpecified ~= false then
        data.helperDropNextAddTime = decodedData.helperDropNextAddTime
    end
    if decodedData.leftOwnerDropBuyCount ~= nil and decodedData.leftOwnerDropBuyCountSpecified ~= false then
        data.leftOwnerDropBuyCount = decodedData.leftOwnerDropBuyCount
    end
    if decodedData.leftEnterBuyCount ~= nil and decodedData.leftEnterBuyCountSpecified ~= false then
        data.leftEnterBuyCount = decodedData.leftEnterBuyCount
    end
    return data
end

---@param decodedData playV2.BestAttInfo lua中的数据结构
---@return playV2.BestAttInfo C#中的数据结构
function playV2.BestAttInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.BestAttInfo()
    if decodedData.attId ~= nil and decodedData.attIdSpecified ~= false then
        data.attId = decodedData.attId
    end
    if decodedData.attType ~= nil and decodedData.attTypeSpecified ~= false then
        data.attType = decodedData.attType
    end
    if decodedData.attValue ~= nil and decodedData.attValueSpecified ~= false then
        data.attValue = decodedData.attValue
    end
    if decodedData.param ~= nil and decodedData.paramSpecified ~= false then
        data.param = decodedData.param
    end
    if decodedData.power ~= nil and decodedData.powerSpecified ~= false then
        data.power = decodedData.power
    end
    return data
end

---@param decodedData playV2.ItemInfo lua中的数据结构
---@return playV2.ItemInfo C#中的数据结构
function playV2.ItemInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ItemInfo()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.bestAttInfo ~= nil and decodedData.bestAttInfoSpecified ~= false then
        data.bestAttInfo = playV2.BestAttInfo(decodedData.bestAttInfo)
    end
    return data
end

---@param decodedData playV2.ItmeUseInfo lua中的数据结构
---@return playV2.ItmeUseInfo C#中的数据结构
function playV2.ItmeUseInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ItmeUseInfo()
    if decodedData.globalId ~= nil and decodedData.globalIdSpecified ~= false then
        data.globalId = decodedData.globalId
    end
    if decodedData.useNum ~= nil and decodedData.useNumSpecified ~= false then
        data.useNum = decodedData.useNum
    end
    return data
end

---@param decodedData playV2.RemindInfo lua中的数据结构
---@return playV2.RemindInfo C#中的数据结构
function playV2.RemindInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.RemindInfo()
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData playV2.ResWorldBossDie lua中的数据结构
---@return playV2.ResWorldBossDie C#中的数据结构
function playV2.ResWorldBossDie(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ResWorldBossDie()
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.itemInfo ~= nil and decodedData.itemInfoSpecified ~= false then
        for i = 1, #decodedData.itemInfo do
            data.itemInfo:Add(playV2.ItemInfo(decodedData.itemInfo[i]))
        end
    end
    if decodedData.dropType ~= nil and decodedData.dropTypeSpecified ~= false then
        data.dropType = decodedData.dropType
    end
    return data
end

---@param decodedData playV2.ReqRewardWorldBoss lua中的数据结构
---@return playV2.ReqRewardWorldBoss C#中的数据结构
function playV2.ReqRewardWorldBoss(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ReqRewardWorldBoss()
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    return data
end

---@param decodedData playV2.ReqEnterPlayMap lua中的数据结构
---@return playV2.ReqEnterPlayMap C#中的数据结构
function playV2.ReqEnterPlayMap(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ReqEnterPlayMap()
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    return data
end

---@param decodedData playV2.ResHudunTrigger lua中的数据结构
---@return playV2.ResHudunTrigger C#中的数据结构
function playV2.ResHudunTrigger(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ResHudunTrigger()
    if decodedData.triggerCount ~= nil and decodedData.triggerCountSpecified ~= false then
        data.triggerCount = decodedData.triggerCount
    end
    return data
end

---@param decodedData playV2.ResHudunChange lua中的数据结构
---@return playV2.ResHudunChange C#中的数据结构
function playV2.ResHudunChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ResHudunChange()
    if decodedData.maxCount ~= nil and decodedData.maxCountSpecified ~= false then
        data.maxCount = decodedData.maxCount
    end
    if decodedData.dunCount ~= nil and decodedData.dunCountSpecified ~= false then
        data.dunCount = decodedData.dunCount
    end
    return data
end

---@param decodedData playV2.ResRollPoint lua中的数据结构
---@return playV2.ResRollPoint C#中的数据结构
function playV2.ResRollPoint(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ResRollPoint()
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData playV2.ResMaxRollPoint lua中的数据结构
---@return playV2.ResMaxRollPoint C#中的数据结构
function playV2.ResMaxRollPoint(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ResMaxRollPoint()
    if decodedData.maxCount ~= nil and decodedData.maxCountSpecified ~= false then
        data.maxCount = decodedData.maxCount
    end
    if decodedData.roleName ~= nil and decodedData.roleNameSpecified ~= false then
        data.roleName = decodedData.roleName
    end
    return data
end

---@param decodedData playV2.ReqFetchWorldBossState lua中的数据结构
---@return playV2.ReqFetchWorldBossState C#中的数据结构
function playV2.ReqFetchWorldBossState(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ReqFetchWorldBossState()
    if decodedData.mapType ~= nil and decodedData.mapTypeSpecified ~= false then
        data.mapType = decodedData.mapType
    end
    return data
end

---@param decodedData playV2.ResFetchWorldBossState lua中的数据结构
---@return playV2.ResFetchWorldBossState C#中的数据结构
function playV2.ResFetchWorldBossState(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ResFetchWorldBossState()
    if decodedData.mapType ~= nil and decodedData.mapTypeSpecified ~= false then
        data.mapType = decodedData.mapType
    end
    if decodedData.stateList ~= nil and decodedData.stateListSpecified ~= false then
        for i = 1, #decodedData.stateList do
            data.stateList:Add(playV2.BossStateInfo(decodedData.stateList[i]))
        end
    end
    return data
end

---@param decodedData playV2.ReqUseFightItem lua中的数据结构
---@return playV2.ReqUseFightItem C#中的数据结构
function playV2.ReqUseFightItem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ReqUseFightItem()
    if decodedData.globalId ~= nil and decodedData.globalIdSpecified ~= false then
        data.globalId = decodedData.globalId
    end
    return data
end

---@param decodedData playV2.ResFightItemBuyCount lua中的数据结构
---@return playV2.ResFightItemBuyCount C#中的数据结构
function playV2.ResFightItemBuyCount(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ResFightItemBuyCount()
    if decodedData.useInfos ~= nil and decodedData.useInfosSpecified ~= false then
        for i = 1, #decodedData.useInfos do
            data.useInfos:Add(playV2.ItmeUseInfo(decodedData.useInfos[i]))
        end
    end
    return data
end

---@param decodedData playV2.ReqSetBossRemind lua中的数据结构
---@return playV2.ReqSetBossRemind C#中的数据结构
function playV2.ReqSetBossRemind(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ReqSetBossRemind()
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData playV2.ResSetBossRemind lua中的数据结构
---@return playV2.ResSetBossRemind C#中的数据结构
function playV2.ResSetBossRemind(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ResSetBossRemind()
    if decodedData.remindList ~= nil and decodedData.remindListSpecified ~= false then
        for i = 1, #decodedData.remindList do
            data.remindList:Add(playV2.RemindInfo(decodedData.remindList[i]))
        end
    end
    return data
end

---@param decodedData playV2.ResBossRemindToRole lua中的数据结构
---@return playV2.ResBossRemindToRole C#中的数据结构
function playV2.ResBossRemindToRole(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ResBossRemindToRole()
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    return data
end

---@param decodedData playV2.ResPlayerKillInfo lua中的数据结构
---@return playV2.ResPlayerKillInfo C#中的数据结构
function playV2.ResPlayerKillInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ResPlayerKillInfo()
    if decodedData.playerId ~= nil and decodedData.playerIdSpecified ~= false then
        data.playerId = decodedData.playerId
    end
    if decodedData.playerName ~= nil and decodedData.playerNameSpecified ~= false then
        data.playerName = decodedData.playerName
    end
    if decodedData.killerId ~= nil and decodedData.killerIdSpecified ~= false then
        data.killerId = decodedData.killerId
    end
    if decodedData.killName ~= nil and decodedData.killNameSpecified ~= false then
        data.killName = decodedData.killName
    end
    return data
end

---@param decodedData playV2.ResMapBossDeath lua中的数据结构
---@return playV2.ResMapBossDeath C#中的数据结构
function playV2.ResMapBossDeath(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ResMapBossDeath()
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    return data
end

---@param decodedData playV2.ReqBuyCount lua中的数据结构
---@return playV2.ReqBuyCount C#中的数据结构
function playV2.ReqBuyCount(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ReqBuyCount()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    return data
end

---@param decodedData playV2.ResBossCount lua中的数据结构
---@return playV2.ResBossCount C#中的数据结构
function playV2.ResBossCount(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ResBossCount()
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.group ~= nil and decodedData.groupSpecified ~= false then
        data.group = decodedData.group
    end
    if decodedData.enterCount ~= nil and decodedData.enterCountSpecified ~= false then
        data.enterCount = decodedData.enterCount
    end
    if decodedData.totalCount ~= nil and decodedData.totalCountSpecified ~= false then
        data.totalCount = decodedData.totalCount
    end
    if decodedData.nextAddTime ~= nil and decodedData.nextAddTimeSpecified ~= false then
        data.nextAddTime = decodedData.nextAddTime
    end
    if decodedData.ownerDropCount ~= nil and decodedData.ownerDropCountSpecified ~= false then
        data.ownerDropCount = decodedData.ownerDropCount
    end
    if decodedData.ownerDropNextAddTime ~= nil and decodedData.ownerDropNextAddTimeSpecified ~= false then
        data.ownerDropNextAddTime = decodedData.ownerDropNextAddTime
    end
    if decodedData.helperDropCount ~= nil and decodedData.helperDropCountSpecified ~= false then
        data.helperDropCount = decodedData.helperDropCount
    end
    if decodedData.helperDropNextAddTime ~= nil and decodedData.helperDropNextAddTimeSpecified ~= false then
        data.helperDropNextAddTime = decodedData.helperDropNextAddTime
    end
    if decodedData.leftOwnerDropBuyCount ~= nil and decodedData.leftOwnerDropBuyCountSpecified ~= false then
        data.leftOwnerDropBuyCount = decodedData.leftOwnerDropBuyCount
    end
    if decodedData.leftEnterBuyCount ~= nil and decodedData.leftEnterBuyCountSpecified ~= false then
        data.leftEnterBuyCount = decodedData.leftEnterBuyCount
    end
    return data
end

---@param decodedData playV2.CommonInfo lua中的数据结构
---@return playV2.CommonInfo C#中的数据结构
function playV2.CommonInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.CommonInfo()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.data ~= nil and decodedData.dataSpecified ~= false then
        data.data = decodedData.data
    end
    if decodedData.str ~= nil and decodedData.strSpecified ~= false then
        data.str = decodedData.str
    end
    if decodedData.data64 ~= nil and decodedData.data64Specified ~= false then
        data.data64 = decodedData.data64
    end
    return data
end

---@param decodedData playV2.ResCorpseDissolution lua中的数据结构
---@return playV2.ResCorpseDissolution C#中的数据结构
function playV2.ResCorpseDissolution(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.ResCorpseDissolution()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    return data
end

--[[playV2.NeedHasAttackModePanel 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData playV2.TodayNoReminder lua中的数据结构
---@return playV2.TodayNoReminder C#中的数据结构
function playV2.TodayNoReminder(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.playV2.TodayNoReminder()
    if decodedData.activityType ~= nil and decodedData.activityTypeSpecified ~= false then
        data.activityType = decodedData.activityType
    end
    return data
end

return playV2