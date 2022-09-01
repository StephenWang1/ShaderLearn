--[[本文件为工具自动生成,禁止手动修改]]
local duplicateV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData duplicateV2.ItemInfo lua中的数据结构
---@return duplicateV2.ItemInfo C#中的数据结构
function duplicateV2.ItemInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ItemInfo()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData duplicateV2.MonsterHpInfo lua中的数据结构
---@return duplicateV2.MonsterHpInfo C#中的数据结构
function duplicateV2.MonsterHpInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.MonsterHpInfo()
    if decodedData.monsterId ~= nil and decodedData.monsterIdSpecified ~= false then
        data.monsterId = decodedData.monsterId
    end
    if decodedData.monsterHp ~= nil and decodedData.monsterHpSpecified ~= false then
        data.monsterHp = decodedData.monsterHp
    end
    if decodedData.monsterCfgId ~= nil and decodedData.monsterCfgIdSpecified ~= false then
        data.monsterCfgId = decodedData.monsterCfgId
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    return data
end

---@param decodedData duplicateV2.PlayerHpInfo lua中的数据结构
---@return duplicateV2.PlayerHpInfo C#中的数据结构
function duplicateV2.PlayerHpInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.PlayerHpInfo()
    if decodedData.playerId ~= nil and decodedData.playerIdSpecified ~= false then
        data.playerId = decodedData.playerId
    end
    if decodedData.percent ~= nil and decodedData.percentSpecified ~= false then
        data.percent = decodedData.percent
    end
    if decodedData.percentIp ~= nil and decodedData.percentIpSpecified ~= false then
        data.percentIp = decodedData.percentIp
    end
    return data
end

---@param decodedData duplicateV2.PerformerEquipInfo lua中的数据结构
---@return duplicateV2.PerformerEquipInfo C#中的数据结构
function duplicateV2.PerformerEquipInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.PerformerEquipInfo()
    if decodedData.equipIndex ~= nil and decodedData.equipIndexSpecified ~= false then
        data.equipIndex = decodedData.equipIndex
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

---@param decodedData duplicateV2.PerformerBufferInfo lua中的数据结构
---@return duplicateV2.PerformerBufferInfo C#中的数据结构
function duplicateV2.PerformerBufferInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.PerformerBufferInfo()
    if decodedData.bid ~= nil and decodedData.bidSpecified ~= false then
        data.bid = decodedData.bid
    end
    if decodedData.cfgId ~= nil and decodedData.cfgIdSpecified ~= false then
        data.cfgId = decodedData.cfgId
    end
    return data
end

---@param decodedData duplicateV2.PerformerFashionInfo lua中的数据结构
---@return duplicateV2.PerformerFashionInfo C#中的数据结构
function duplicateV2.PerformerFashionInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.PerformerFashionInfo()
    if decodedData.fashionType ~= nil and decodedData.fashionTypeSpecified ~= false then
        data.fashionType = decodedData.fashionType
    end
    if decodedData.fashionId ~= nil and decodedData.fashionIdSpecified ~= false then
        data.fashionId = decodedData.fashionId
    end
    return data
end

---@param decodedData duplicateV2.RoundMonster lua中的数据结构
---@return duplicateV2.RoundMonster C#中的数据结构
function duplicateV2.RoundMonster(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.RoundMonster()
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
    if decodedData.master ~= nil and decodedData.masterSpecified ~= false then
        data.master = decodedData.master
    end
    if decodedData.performerEquipInfo ~= nil and decodedData.performerEquipInfoSpecified ~= false then
        for i = 1, #decodedData.performerEquipInfo do
            data.performerEquipInfo:Add(duplicateV2.PerformerEquipInfo(decodedData.performerEquipInfo[i]))
        end
    end
    if decodedData.performerBufferInfo ~= nil and decodedData.performerBufferInfoSpecified ~= false then
        for i = 1, #decodedData.performerBufferInfo do
            data.performerBufferInfo:Add(duplicateV2.PerformerBufferInfo(decodedData.performerBufferInfo[i]))
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
    if decodedData.fashionList ~= nil and decodedData.fashionListSpecified ~= false then
        for i = 1, #decodedData.fashionList do
            data.fashionList:Add(duplicateV2.PerformerFashionInfo(decodedData.fashionList[i]))
        end
    end
    if decodedData.junxian ~= nil and decodedData.junxianSpecified ~= false then
        data.junxian = decodedData.junxian
    end
    if decodedData.group ~= nil and decodedData.groupSpecified ~= false then
        data.group = decodedData.group
    end
    return data
end

---@param decodedData duplicateV2.HurtRankInfo lua中的数据结构
---@return duplicateV2.HurtRankInfo C#中的数据结构
function duplicateV2.HurtRankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.HurtRankInfo()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.rank ~= nil and decodedData.rankSpecified ~= false then
        data.rank = decodedData.rank
    end
    if decodedData.hurt ~= nil and decodedData.hurtSpecified ~= false then
        data.hurt = decodedData.hurt
    end
    return data
end

---@param decodedData duplicateV2.ChallengeCountInfo lua中的数据结构
---@return duplicateV2.ChallengeCountInfo C#中的数据结构
function duplicateV2.ChallengeCountInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ChallengeCountInfo()
    if decodedData.leftChallengeCount ~= nil and decodedData.leftChallengeCountSpecified ~= false then
        data.leftChallengeCount = decodedData.leftChallengeCount
    end
    if decodedData.groupId ~= nil and decodedData.groupIdSpecified ~= false then
        data.groupId = decodedData.groupId
    end
    if decodedData.duplicateId ~= nil and decodedData.duplicateIdSpecified ~= false then
        for i = 1, #decodedData.duplicateId do
            data.duplicateId:Add(decodedData.duplicateId[i])
        end
    end
    return data
end

---@param decodedData duplicateV2.CollectRewardBoxInfo lua中的数据结构
---@return duplicateV2.CollectRewardBoxInfo C#中的数据结构
function duplicateV2.CollectRewardBoxInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.CollectRewardBoxInfo()
    if decodedData.boxId ~= nil and decodedData.boxIdSpecified ~= false then
        data.boxId = decodedData.boxId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData duplicateV2.ResDuplicateBasicInfo lua中的数据结构
---@return duplicateV2.ResDuplicateBasicInfo C#中的数据结构
function duplicateV2.ResDuplicateBasicInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResDuplicateBasicInfo()
    if decodedData.cfgId ~= nil and decodedData.cfgIdSpecified ~= false then
        data.cfgId = decodedData.cfgId
    end
    if decodedData.line ~= nil and decodedData.lineSpecified ~= false then
        data.line = decodedData.line
    end
    if decodedData.createTime ~= nil and decodedData.createTimeSpecified ~= false then
        data.createTime = decodedData.createTime
    end
    return data
end

---@param decodedData duplicateV2.ReqEnterDuplicate lua中的数据结构
---@return duplicateV2.ReqEnterDuplicate C#中的数据结构
function duplicateV2.ReqEnterDuplicate(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqEnterDuplicate()
    if decodedData.duplicateId ~= nil and decodedData.duplicateIdSpecified ~= false then
        data.duplicateId = decodedData.duplicateId
    end
    if decodedData.costType ~= nil and decodedData.costTypeSpecified ~= false then
        data.costType = decodedData.costType
    end
    return data
end

---@param decodedData duplicateV2.ResDuplicateEnd lua中的数据结构
---@return duplicateV2.ResDuplicateEnd C#中的数据结构
function duplicateV2.ResDuplicateEnd(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResDuplicateEnd()
    if decodedData.sucess ~= nil and decodedData.sucessSpecified ~= false then
        data.sucess = decodedData.sucess
    end
    if decodedData.waitingTime ~= nil and decodedData.waitingTimeSpecified ~= false then
        data.waitingTime = decodedData.waitingTime
    end
    if decodedData.showAwardList ~= nil and decodedData.showAwardListSpecified ~= false then
        for i = 1, #decodedData.showAwardList do
            data.showAwardList:Add(decodeTable.common.IntIntStruct(decodedData.showAwardList[i]))
        end
    end
    return data
end

---@param decodedData duplicateV2.ResPerformTotalHp lua中的数据结构
---@return duplicateV2.ResPerformTotalHp C#中的数据结构
function duplicateV2.ResPerformTotalHp(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResPerformTotalHp()
    if decodedData.monsterList ~= nil and decodedData.monsterListSpecified ~= false then
        for i = 1, #decodedData.monsterList do
            data.monsterList:Add(duplicateV2.MonsterHpInfo(decodedData.monsterList[i]))
        end
    end
    if decodedData.playerList ~= nil and decodedData.playerListSpecified ~= false then
        for i = 1, #decodedData.playerList do
            data.playerList:Add(duplicateV2.PlayerHpInfo(decodedData.playerList[i]))
        end
    end
    return data
end

---@param decodedData duplicateV2.ResUpdateTianTiMonsterInfo lua中的数据结构
---@return duplicateV2.ResUpdateTianTiMonsterInfo C#中的数据结构
function duplicateV2.ResUpdateTianTiMonsterInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResUpdateTianTiMonsterInfo()
    if decodedData.monsters ~= nil and decodedData.monstersSpecified ~= false then
        for i = 1, #decodedData.monsters do
            data.monsters:Add(duplicateV2.RoundMonster(decodedData.monsters[i]))
        end
    end
    return data
end

---@param decodedData duplicateV2.ReqDuplicatePanelInfo lua中的数据结构
---@return duplicateV2.ReqDuplicatePanelInfo C#中的数据结构
function duplicateV2.ReqDuplicatePanelInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqDuplicatePanelInfo()
    if decodedData.duplicateType ~= nil and decodedData.duplicateTypeSpecified ~= false then
        data.duplicateType = decodedData.duplicateType
    end
    return data
end

---@param decodedData duplicateV2.ResDuplicatePanelInfo lua中的数据结构
---@return duplicateV2.ResDuplicatePanelInfo C#中的数据结构
function duplicateV2.ResDuplicatePanelInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResDuplicatePanelInfo()
    if decodedData.duplicateId ~= nil and decodedData.duplicateIdSpecified ~= false then
        data.duplicateId = decodedData.duplicateId
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData duplicateV2.ResSendHurtRankInfo lua中的数据结构
---@return duplicateV2.ResSendHurtRankInfo C#中的数据结构
function duplicateV2.ResSendHurtRankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResSendHurtRankInfo()
    if decodedData.ranks ~= nil and decodedData.ranksSpecified ~= false then
        for i = 1, #decodedData.ranks do
            data.ranks:Add(duplicateV2.HurtRankInfo(decodedData.ranks[i]))
        end
    end
    if decodedData.selfRank ~= nil and decodedData.selfRankSpecified ~= false then
        data.selfRank = duplicateV2.HurtRankInfo(decodedData.selfRank)
    end
    return data
end

---@param decodedData duplicateV2.ResDuplicateLeftChallengeCount lua中的数据结构
---@return duplicateV2.ResDuplicateLeftChallengeCount C#中的数据结构
function duplicateV2.ResDuplicateLeftChallengeCount(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResDuplicateLeftChallengeCount()
    if decodedData.countInfoList ~= nil and decodedData.countInfoListSpecified ~= false then
        for i = 1, #decodedData.countInfoList do
            data.countInfoList:Add(duplicateV2.ChallengeCountInfo(decodedData.countInfoList[i]))
        end
    end
    return data
end

---@param decodedData duplicateV2.ResDuplicateReward lua中的数据结构
---@return duplicateV2.ResDuplicateReward C#中的数据结构
function duplicateV2.ResDuplicateReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResDuplicateReward()
    if decodedData.sucess ~= nil and decodedData.sucessSpecified ~= false then
        data.sucess = decodedData.sucess
    end
    if decodedData.itemInfo ~= nil and decodedData.itemInfoSpecified ~= false then
        for i = 1, #decodedData.itemInfo do
            data.itemInfo:Add(duplicateV2.ItemInfo(decodedData.itemInfo[i]))
        end
    end
    return data
end

---@param decodedData duplicateV2.ResTreasureMapCollectInitInfo lua中的数据结构
---@return duplicateV2.ResTreasureMapCollectInitInfo C#中的数据结构
function duplicateV2.ResTreasureMapCollectInitInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResTreasureMapCollectInitInfo()
    if decodedData.allRewards ~= nil and decodedData.allRewardsSpecified ~= false then
        for i = 1, #decodedData.allRewards do
            data.allRewards:Add(duplicateV2.CollectRewardBoxInfo(decodedData.allRewards[i]))
        end
    end
    if decodedData.alreadyCollected ~= nil and decodedData.alreadyCollectedSpecified ~= false then
        for i = 1, #decodedData.alreadyCollected do
            data.alreadyCollected:Add(decodedData.alreadyCollected[i])
        end
    end
    if decodedData.overTime ~= nil and decodedData.overTimeSpecified ~= false then
        data.overTime = decodedData.overTime
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

---@param decodedData duplicateV2.ResTreasureMapCollectChangeInfo lua中的数据结构
---@return duplicateV2.ResTreasureMapCollectChangeInfo C#中的数据结构
function duplicateV2.ResTreasureMapCollectChangeInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResTreasureMapCollectChangeInfo()
    if decodedData.collectedIndex ~= nil and decodedData.collectedIndexSpecified ~= false then
        data.collectedIndex = decodedData.collectedIndex
    end
    return data
end

---@param decodedData duplicateV2.ReqLeaveDuplicate lua中的数据结构
---@return duplicateV2.ReqLeaveDuplicate C#中的数据结构
function duplicateV2.ReqLeaveDuplicate(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqLeaveDuplicate()
    data.option = decodedData.option
    return data
end

---@param decodedData duplicateV2.ReqDuplicateReward lua中的数据结构
---@return duplicateV2.ReqDuplicateReward C#中的数据结构
function duplicateV2.ReqDuplicateReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqDuplicateReward()
    data.multi = decodedData.multi
    return data
end

---@param decodedData duplicateV2.SabacInfo lua中的数据结构
---@return duplicateV2.SabacInfo C#中的数据结构
function duplicateV2.SabacInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.SabacInfo()
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.flagDieTime ~= nil and decodedData.flagDieTimeSpecified ~= false then
        data.flagDieTime = decodedData.flagDieTime
    end
    if decodedData.yuanbao ~= nil and decodedData.yuanbaoSpecified ~= false then
        data.yuanbao = decodedData.yuanbao
    end
    if decodedData.isOpen ~= nil and decodedData.isOpenSpecified ~= false then
        data.isOpen = decodedData.isOpen
    end
    if decodedData.tacticsCoolDownTime ~= nil and decodedData.tacticsCoolDownTimeSpecified ~= false then
        data.tacticsCoolDownTime = decodedData.tacticsCoolDownTime
    end
    if decodedData.activeTacticsPoints ~= nil and decodedData.activeTacticsPointsSpecified ~= false then
        for i = 1, #decodedData.activeTacticsPoints do
            data.activeTacticsPoints:Add(decodedData.activeTacticsPoints[i])
        end
    end
    if decodedData.tacticsActiveTime ~= nil and decodedData.tacticsActiveTimeSpecified ~= false then
        data.tacticsActiveTime = decodedData.tacticsActiveTime
    end
    if decodedData.uniteId ~= nil and decodedData.uniteIdSpecified ~= false then
        data.uniteId = decodedData.uniteId
    end
    if decodedData.uniteType ~= nil and decodedData.uniteTypeSpecified ~= false then
        data.uniteType = decodedData.uniteType
    end
    return data
end

---@param decodedData duplicateV2.SabacScoreInfo lua中的数据结构
---@return duplicateV2.SabacScoreInfo C#中的数据结构
function duplicateV2.SabacScoreInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.SabacScoreInfo()
    if decodedData.killScore ~= nil and decodedData.killScoreSpecified ~= false then
        data.killScore = decodedData.killScore
    end
    if decodedData.guardScore ~= nil and decodedData.guardScoreSpecified ~= false then
        data.guardScore = decodedData.guardScore
    end
    if decodedData.loseScore ~= nil and decodedData.loseScoreSpecified ~= false then
        data.loseScore = decodedData.loseScore
    end
    if decodedData.Score ~= nil and decodedData.ScoreSpecified ~= false then
        data.Score = decodedData.Score
    end
    if decodedData.rewards ~= nil and decodedData.rewardsSpecified ~= false then
        for i = 1, #decodedData.rewards do
            data.rewards:Add(duplicateV2.SabacReward(decodedData.rewards[i]))
        end
    end
    return data
end

---@param decodedData duplicateV2.SabacPanelInfo lua中的数据结构
---@return duplicateV2.SabacPanelInfo C#中的数据结构
function duplicateV2.SabacPanelInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.SabacPanelInfo()
    if decodedData.mayor ~= nil and decodedData.mayorSpecified ~= false then
        data.mayor = decodeTable.role.ResPlayerBasicInfo(decodedData.mayor)
    end
    if decodedData.union ~= nil and decodedData.unionSpecified ~= false then
        data.union = decodeTable.union.UnionInfo(decodedData.union)
    end
    if decodedData.cityName ~= nil and decodedData.cityNameSpecified ~= false then
        data.cityName = decodedData.cityName
    end
    if decodedData.occupyTime ~= nil and decodedData.occupyTimeSpecified ~= false then
        data.occupyTime = decodedData.occupyTime
    end
    if decodedData.officers ~= nil and decodedData.officersSpecified ~= false then
        for i = 1, #decodedData.officers do
            data.officers:Add(decodeTable.role.ResPlayerBasicInfo(decodedData.officers[i]))
        end
    end
    if decodedData.mayorDayGift ~= nil and decodedData.mayorDayGiftSpecified ~= false then
        data.mayorDayGift = decodedData.mayorDayGift
    end
    return data
end

---@param decodedData duplicateV2.TyrantDuplicateScore lua中的数据结构
---@return duplicateV2.TyrantDuplicateScore C#中的数据结构
function duplicateV2.TyrantDuplicateScore(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.TyrantDuplicateScore()
    if decodedData.thisPlayerInfo ~= nil and decodedData.thisPlayerInfoSpecified ~= false then
        for i = 1, #decodedData.thisPlayerInfo do
            data.thisPlayerInfo:Add(duplicateV2.ThisPlayerInfo(decodedData.thisPlayerInfo[i]))
        end
    end
    return data
end

---@param decodedData duplicateV2.ThisPlayerInfo lua中的数据结构
---@return duplicateV2.ThisPlayerInfo C#中的数据结构
function duplicateV2.ThisPlayerInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ThisPlayerInfo()
    if decodedData.playerId ~= nil and decodedData.playerIdSpecified ~= false then
        data.playerId = decodedData.playerId
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.yuanBaoNum ~= nil and decodedData.yuanBaoNumSpecified ~= false then
        data.yuanBaoNum = decodedData.yuanBaoNum
    end
    if decodedData.bindGoldNum ~= nil and decodedData.bindGoldNumSpecified ~= false then
        data.bindGoldNum = decodedData.bindGoldNum
    end
    if decodedData.bindYuanBaoNum ~= nil and decodedData.bindYuanBaoNumSpecified ~= false then
        data.bindYuanBaoNum = decodedData.bindYuanBaoNum
    end
    if decodedData.score ~= nil and decodedData.scoreSpecified ~= false then
        data.score = decodedData.score
    end
    if decodedData.no ~= nil and decodedData.noSpecified ~= false then
        data.no = decodedData.no
    end
    return data
end

---@param decodedData duplicateV2.ReqAutoFinshDuplicate lua中的数据结构
---@return duplicateV2.ReqAutoFinshDuplicate C#中的数据结构
function duplicateV2.ReqAutoFinshDuplicate(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqAutoFinshDuplicate()
    data.cfgId = decodedData.cfgId
    data.multi = decodedData.multi
    return data
end

---@param decodedData duplicateV2.ResAutoFinshDuplicate lua中的数据结构
---@return duplicateV2.ResAutoFinshDuplicate C#中的数据结构
function duplicateV2.ResAutoFinshDuplicate(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResAutoFinshDuplicate()
    if decodedData.cfgId ~= nil and decodedData.cfgIdSpecified ~= false then
        data.cfgId = decodedData.cfgId
    end
    return data
end

---@param decodedData duplicateV2.ReqInspireBuff lua中的数据结构
---@return duplicateV2.ReqInspireBuff C#中的数据结构
function duplicateV2.ReqInspireBuff(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqInspireBuff()
    if decodedData.inspireType ~= nil and decodedData.inspireTypeSpecified ~= false then
        data.inspireType = decodedData.inspireType
    end
    if decodedData.playerId ~= nil and decodedData.playerIdSpecified ~= false then
        data.playerId = decodedData.playerId
    end
    return data
end

---@param decodedData duplicateV2.ResInspireBuff lua中的数据结构
---@return duplicateV2.ResInspireBuff C#中的数据结构
function duplicateV2.ResInspireBuff(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResInspireBuff()
    if decodedData.thisPercentage ~= nil and decodedData.thisPercentageSpecified ~= false then
        data.thisPercentage = decodedData.thisPercentage
    end
    return data
end

---@param decodedData duplicateV2.ResTyrantDeath lua中的数据结构
---@return duplicateV2.ResTyrantDeath C#中的数据结构
function duplicateV2.ResTyrantDeath(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResTyrantDeath()
    if decodedData.playerId ~= nil and decodedData.playerIdSpecified ~= false then
        data.playerId = decodedData.playerId
    end
    return data
end

---@param decodedData duplicateV2.ResDuplicateItem lua中的数据结构
---@return duplicateV2.ResDuplicateItem C#中的数据结构
function duplicateV2.ResDuplicateItem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResDuplicateItem()
    if decodedData.playerId ~= nil and decodedData.playerIdSpecified ~= false then
        data.playerId = decodedData.playerId
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.param ~= nil and decodedData.paramSpecified ~= false then
        data.param = decodedData.param
    end
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.specialParam ~= nil and decodedData.specialParamSpecified ~= false then
        data.specialParam = decodedData.specialParam
    end
    return data
end

---@param decodedData duplicateV2.ResDuplicateInfo lua中的数据结构
---@return duplicateV2.ResDuplicateInfo C#中的数据结构
function duplicateV2.ResDuplicateInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResDuplicateInfo()
    if decodedData.playerId ~= nil and decodedData.playerIdSpecified ~= false then
        data.playerId = decodedData.playerId
    end
    if decodedData.duplicateId ~= nil and decodedData.duplicateIdSpecified ~= false then
        data.duplicateId = decodedData.duplicateId
    end
    if decodedData.maxFloorId ~= nil and decodedData.maxFloorIdSpecified ~= false then
        data.maxFloorId = decodedData.maxFloorId
    end
    return data
end

---@param decodedData duplicateV2.CavesPlayerInfo lua中的数据结构
---@return duplicateV2.CavesPlayerInfo C#中的数据结构
function duplicateV2.CavesPlayerInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.CavesPlayerInfo()
    if decodedData.duplicateItem ~= nil and decodedData.duplicateItemSpecified ~= false then
        data.duplicateItem = duplicateV2.ResDuplicateItem(decodedData.duplicateItem)
    end
    if decodedData.no ~= nil and decodedData.noSpecified ~= false then
        data.no = decodedData.no
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    return data
end

---@param decodedData duplicateV2.CavesDuplicateRankInfo lua中的数据结构
---@return duplicateV2.CavesDuplicateRankInfo C#中的数据结构
function duplicateV2.CavesDuplicateRankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.CavesDuplicateRankInfo()
    if decodedData.duplicateRank ~= nil and decodedData.duplicateRankSpecified ~= false then
        for i = 1, #decodedData.duplicateRank do
            data.duplicateRank:Add(duplicateV2.CavesPlayerInfo(decodedData.duplicateRank[i]))
        end
    end
    return data
end

---@param decodedData duplicateV2.CavesDuplicateInitTime lua中的数据结构
---@return duplicateV2.CavesDuplicateInitTime C#中的数据结构
function duplicateV2.CavesDuplicateInitTime(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.CavesDuplicateInitTime()
    if decodedData.initTime ~= nil and decodedData.initTimeSpecified ~= false then
        data.initTime = decodedData.initTime
    end
    return data
end

---@param decodedData duplicateV2.ReqMausoleumDuplicate lua中的数据结构
---@return duplicateV2.ReqMausoleumDuplicate C#中的数据结构
function duplicateV2.ReqMausoleumDuplicate(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqMausoleumDuplicate()
    if decodedData.playerId ~= nil and decodedData.playerIdSpecified ~= false then
        data.playerId = decodedData.playerId
    end
    return data
end

---@param decodedData duplicateV2.ResGodPower lua中的数据结构
---@return duplicateV2.ResGodPower C#中的数据结构
function duplicateV2.ResGodPower(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResGodPower()
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.startTime ~= nil and decodedData.startTimeSpecified ~= false then
        data.startTime = decodedData.startTime
    end
    if decodedData.entryTimeEnd ~= nil and decodedData.entryTimeEndSpecified ~= false then
        data.entryTimeEnd = decodedData.entryTimeEnd
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    if decodedData.thisMapId ~= nil and decodedData.thisMapIdSpecified ~= false then
        data.thisMapId = decodedData.thisMapId
    end
    if decodedData.bossSurvival ~= nil and decodedData.bossSurvivalSpecified ~= false then
        data.bossSurvival = decodedData.bossSurvival
    end
    return data
end

---@param decodedData duplicateV2.ResEntryTokenItem lua中的数据结构
---@return duplicateV2.ResEntryTokenItem C#中的数据结构
function duplicateV2.ResEntryTokenItem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResEntryTokenItem()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData duplicateV2.ResWolfDreamTime lua中的数据结构
---@return duplicateV2.ResWolfDreamTime C#中的数据结构
function duplicateV2.ResWolfDreamTime(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResWolfDreamTime()
    if decodedData.useTime ~= nil and decodedData.useTimeSpecified ~= false then
        data.useTime = decodedData.useTime
    end
    if decodedData.remainTime ~= nil and decodedData.remainTimeSpecified ~= false then
        data.remainTime = decodedData.remainTime
    end
    return data
end

---@param decodedData duplicateV2.ResSanctuarySpaceInfo lua中的数据结构
---@return duplicateV2.ResSanctuarySpaceInfo C#中的数据结构
function duplicateV2.ResSanctuarySpaceInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResSanctuarySpaceInfo()
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData duplicateV2.ReqButSanctuaryCount lua中的数据结构
---@return duplicateV2.ReqButSanctuaryCount C#中的数据结构
function duplicateV2.ReqButSanctuaryCount(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqButSanctuaryCount()
    if decodedData.buyCount ~= nil and decodedData.buyCountSpecified ~= false then
        data.buyCount = decodedData.buyCount
    end
    return data
end

---@param decodedData duplicateV2.ResDuplicateBossInfo lua中的数据结构
---@return duplicateV2.ResDuplicateBossInfo C#中的数据结构
function duplicateV2.ResDuplicateBossInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResDuplicateBossInfo()
    if decodedData.bossSurvival ~= nil and decodedData.bossSurvivalSpecified ~= false then
        data.bossSurvival = decodedData.bossSurvival
    end
    return data
end

---@param decodedData duplicateV2.ResPrisonRemainTime lua中的数据结构
---@return duplicateV2.ResPrisonRemainTime C#中的数据结构
function duplicateV2.ResPrisonRemainTime(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResPrisonRemainTime()
    if decodedData.player ~= nil and decodedData.playerSpecified ~= false then
        data.player = decodedData.player
    end
    if decodedData.remainTime ~= nil and decodedData.remainTimeSpecified ~= false then
        data.remainTime = decodedData.remainTime
    end
    if decodedData.isPrisoner ~= nil and decodedData.isPrisonerSpecified ~= false then
        data.isPrisoner = decodedData.isPrisoner
    end
    return data
end

---@param decodedData duplicateV2.SabacRankInfo lua中的数据结构
---@return duplicateV2.SabacRankInfo C#中的数据结构
function duplicateV2.SabacRankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.SabacRankInfo()
    data.roleId = decodedData.roleId
    data.name = decodedData.name
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.score ~= nil and decodedData.scoreSpecified ~= false then
        data.score = decodedData.score
    end
    if decodedData.killCount ~= nil and decodedData.killCountSpecified ~= false then
        data.killCount = decodedData.killCount
    end
    if decodedData.dieCount ~= nil and decodedData.dieCountSpecified ~= false then
        data.dieCount = decodedData.dieCount
    end
    if decodedData.loseItems ~= nil and decodedData.loseItemsSpecified ~= false then
        for i = 1, #decodedData.loseItems do
            data.loseItems:Add(decodedData.loseItems[i])
        end
    end
    if decodedData.rank ~= nil and decodedData.rankSpecified ~= false then
        data.rank = decodedData.rank
    end
    if decodedData.damage ~= nil and decodedData.damageSpecified ~= false then
        data.damage = decodedData.damage
    end
    if decodedData.hurt ~= nil and decodedData.hurtSpecified ~= false then
        data.hurt = decodedData.hurt
    end
    if decodedData.cure ~= nil and decodedData.cureSpecified ~= false then
        data.cure = decodedData.cure
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.likeSet ~= nil and decodedData.likeSetSpecified ~= false then
        for i = 1, #decodedData.likeSet do
            data.likeSet:Add(decodedData.likeSet[i])
        end
    end
    if decodedData.hostId ~= nil and decodedData.hostIdSpecified ~= false then
        data.hostId = decodedData.hostId
    end
    if decodedData.uniteId ~= nil and decodedData.uniteIdSpecified ~= false then
        data.uniteId = decodedData.uniteId
    end
    if decodedData.uniteType ~= nil and decodedData.uniteTypeSpecified ~= false then
        data.uniteType = decodedData.uniteType
    end
    if decodedData.newScore ~= nil and decodedData.newScoreSpecified ~= false then
        data.newScore = decodedData.newScore
    end
    return data
end

---@param decodedData duplicateV2.ReqGetSabacRankInfo lua中的数据结构
---@return duplicateV2.ReqGetSabacRankInfo C#中的数据结构
function duplicateV2.ReqGetSabacRankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqGetSabacRankInfo()
    data.type = decodedData.type
    data.page = decodedData.page
    data.countPerPage = decodedData.countPerPage
    return data
end

---@param decodedData duplicateV2.ResSabacRankInfo lua中的数据结构
---@return duplicateV2.ResSabacRankInfo C#中的数据结构
function duplicateV2.ResSabacRankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResSabacRankInfo()
    data.type = decodedData.type
    data.totalCount = decodedData.totalCount
    data.page = decodedData.page
    if decodedData.rankInfo ~= nil and decodedData.rankInfoSpecified ~= false then
        for i = 1, #decodedData.rankInfo do
            data.rankInfo:Add(duplicateV2.SabacRankInfo(decodedData.rankInfo[i]))
        end
    end
    if decodedData.myRankInfo ~= nil and decodedData.myRankInfoSpecified ~= false then
        data.myRankInfo = duplicateV2.SabacRankInfo(decodedData.myRankInfo)
    end
    if decodedData.hostId ~= nil and decodedData.hostIdSpecified ~= false then
        data.hostId = decodedData.hostId
    end
    return data
end

---@param decodedData duplicateV2.ReqSabacRecord lua中的数据结构
---@return duplicateV2.ReqSabacRecord C#中的数据结构
function duplicateV2.ReqSabacRecord(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqSabacRecord()
    data.index = decodedData.index
    return data
end

---@param decodedData duplicateV2.ResSabacRecord lua中的数据结构
---@return duplicateV2.ResSabacRecord C#中的数据结构
function duplicateV2.ResSabacRecord(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResSabacRecord()
    data.index = decodedData.index
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.rankInfo ~= nil and decodedData.rankInfoSpecified ~= false then
        for i = 1, #decodedData.rankInfo do
            data.rankInfo:Add(duplicateV2.SabacRankInfo(decodedData.rankInfo[i]))
        end
    end
    if decodedData.myRankInfo ~= nil and decodedData.myRankInfoSpecified ~= false then
        data.myRankInfo = duplicateV2.SabacRankInfo(decodedData.myRankInfo)
    end
    if decodedData.hostId ~= nil and decodedData.hostIdSpecified ~= false then
        data.hostId = decodedData.hostId
    end
    if decodedData.uniteId ~= nil and decodedData.uniteIdSpecified ~= false then
        data.uniteId = decodedData.uniteId
    end
    if decodedData.uniteType ~= nil and decodedData.uniteTypeSpecified ~= false then
        data.uniteType = decodedData.uniteType
    end
    return data
end

---@param decodedData duplicateV2.ResGoddessBlessingInfo lua中的数据结构
---@return duplicateV2.ResGoddessBlessingInfo C#中的数据结构
function duplicateV2.ResGoddessBlessingInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResGoddessBlessingInfo()
    if decodedData.openTime ~= nil and decodedData.openTimeSpecified ~= false then
        data.openTime = decodedData.openTime
    end
    if decodedData.totalTime ~= nil and decodedData.totalTimeSpecified ~= false then
        data.totalTime = decodedData.totalTime
    end
    return data
end

---@param decodedData duplicateV2.ResDreamlandInfo lua中的数据结构
---@return duplicateV2.ResDreamlandInfo C#中的数据结构
function duplicateV2.ResDreamlandInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResDreamlandInfo()
    if decodedData.bossCount ~= nil and decodedData.bossCountSpecified ~= false then
        data.bossCount = decodedData.bossCount
    end
    if decodedData.exitIsOpen ~= nil and decodedData.exitIsOpenSpecified ~= false then
        data.exitIsOpen = decodedData.exitIsOpen
    end
    if decodedData.isMessenger ~= nil and decodedData.isMessengerSpecified ~= false then
        data.isMessenger = decodedData.isMessenger
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    return data
end

---@param decodedData duplicateV2.ResCanDelivery lua中的数据结构
---@return duplicateV2.ResCanDelivery C#中的数据结构
function duplicateV2.ResCanDelivery(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResCanDelivery()
    if decodedData.layer ~= nil and decodedData.layerSpecified ~= false then
        data.layer = decodedData.layer
    end
    return data
end

---@param decodedData duplicateV2.ReqDeliveryDuplicate lua中的数据结构
---@return duplicateV2.ReqDeliveryDuplicate C#中的数据结构
function duplicateV2.ReqDeliveryDuplicate(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqDeliveryDuplicate()
    if decodedData.duplicateId ~= nil and decodedData.duplicateIdSpecified ~= false then
        data.duplicateId = decodedData.duplicateId
    end
    return data
end

---@param decodedData duplicateV2.ReqDuboBet lua中的数据结构
---@return duplicateV2.ReqDuboBet C#中的数据结构
function duplicateV2.ReqDuboBet(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqDuboBet()
    if decodedData.targetPlayerId ~= nil and decodedData.targetPlayerIdSpecified ~= false then
        data.targetPlayerId = decodedData.targetPlayerId
    end
    if decodedData.finalWar ~= nil and decodedData.finalWarSpecified ~= false then
        data.finalWar = decodedData.finalWar
    end
    if decodedData.zhu ~= nil and decodedData.zhuSpecified ~= false then
        data.zhu = decodedData.zhu
    end
    return data
end

---@param decodedData duplicateV2.ResBetPlayerInfo lua中的数据结构
---@return duplicateV2.ResBetPlayerInfo C#中的数据结构
function duplicateV2.ResBetPlayerInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResBetPlayerInfo()
    if decodedData.someSelectPlayers ~= nil and decodedData.someSelectPlayersSpecified ~= false then
        for i = 1, #decodedData.someSelectPlayers do
            data.someSelectPlayers:Add(duplicateV2.BetPlayerInfo(decodedData.someSelectPlayers[i]))
        end
    end
    if decodedData.finalPlayers ~= nil and decodedData.finalPlayersSpecified ~= false then
        for i = 1, #decodedData.finalPlayers do
            data.finalPlayers:Add(duplicateV2.BetPlayerInfo(decodedData.finalPlayers[i]))
        end
    end
    return data
end

---@param decodedData duplicateV2.BetPlayerInfo lua中的数据结构
---@return duplicateV2.BetPlayerInfo C#中的数据结构
function duplicateV2.BetPlayerInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.BetPlayerInfo()
    if decodedData.playerId ~= nil and decodedData.playerIdSpecified ~= false then
        data.playerId = decodedData.playerId
    end
    if decodedData.killNum ~= nil and decodedData.killNumSpecified ~= false then
        data.killNum = decodedData.killNum
    end
    if decodedData.onlineTime ~= nil and decodedData.onlineTimeSpecified ~= false then
        data.onlineTime = decodedData.onlineTime
    end
    if decodedData.odds ~= nil and decodedData.oddsSpecified ~= false then
        data.odds = decodedData.odds
    end
    if decodedData.no ~= nil and decodedData.noSpecified ~= false then
        data.no = decodedData.no
    end
    if decodedData.zhuNum ~= nil and decodedData.zhuNumSpecified ~= false then
        data.zhuNum = decodedData.zhuNum
    end
    if decodedData.playerName ~= nil and decodedData.playerNameSpecified ~= false then
        data.playerName = decodedData.playerName
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    return data
end

---@param decodedData duplicateV2.ResBudoRank lua中的数据结构
---@return duplicateV2.ResBudoRank C#中的数据结构
function duplicateV2.ResBudoRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResBudoRank()
    if decodedData.rankPlayer ~= nil and decodedData.rankPlayerSpecified ~= false then
        for i = 1, #decodedData.rankPlayer do
            data.rankPlayer:Add(duplicateV2.BudoRankPlayerInfo(decodedData.rankPlayer[i]))
        end
    end
    return data
end

---@param decodedData duplicateV2.BudoRankPlayerInfo lua中的数据结构
---@return duplicateV2.BudoRankPlayerInfo C#中的数据结构
function duplicateV2.BudoRankPlayerInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.BudoRankPlayerInfo()
    if decodedData.playerId ~= nil and decodedData.playerIdSpecified ~= false then
        data.playerId = decodedData.playerId
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.killNum ~= nil and decodedData.killNumSpecified ~= false then
        data.killNum = decodedData.killNum
    end
    if decodedData.no ~= nil and decodedData.noSpecified ~= false then
        data.no = decodedData.no
    end
    if decodedData.awardItems ~= nil and decodedData.awardItemsSpecified ~= false then
        for i = 1, #decodedData.awardItems do
            data.awardItems:Add(duplicateV2.BudoAwardItem(decodedData.awardItems[i]))
        end
    end
    if decodedData.likes ~= nil and decodedData.likesSpecified ~= false then
        data.likes = duplicateV2.LikeList(decodedData.likes)
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.selectBetRate ~= nil and decodedData.selectBetRateSpecified ~= false then
        data.selectBetRate = decodedData.selectBetRate
    end
    if decodedData.selectBetAmount ~= nil and decodedData.selectBetAmountSpecified ~= false then
        data.selectBetAmount = decodedData.selectBetAmount
    end
    if decodedData.finalBetRate ~= nil and decodedData.finalBetRateSpecified ~= false then
        data.finalBetRate = decodedData.finalBetRate
    end
    if decodedData.finalBetAmount ~= nil and decodedData.finalBetAmountSpecified ~= false then
        data.finalBetAmount = decodedData.finalBetAmount
    end
    if decodedData.hostId ~= nil and decodedData.hostIdSpecified ~= false then
        data.hostId = decodedData.hostId
    end
    if decodedData.serverType ~= nil and decodedData.serverTypeSpecified ~= false then
        data.serverType = decodedData.serverType
    end
    return data
end

---@param decodedData duplicateV2.BudoAwardItem lua中的数据结构
---@return duplicateV2.BudoAwardItem C#中的数据结构
function duplicateV2.BudoAwardItem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.BudoAwardItem()
    if decodedData.ItemConfigId ~= nil and decodedData.ItemConfigIdSpecified ~= false then
        data.ItemConfigId = decodedData.ItemConfigId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData duplicateV2.BudoDuplicatePhaseInfo lua中的数据结构
---@return duplicateV2.BudoDuplicatePhaseInfo C#中的数据结构
function duplicateV2.BudoDuplicatePhaseInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.BudoDuplicatePhaseInfo()
    if decodedData.phase ~= nil and decodedData.phaseSpecified ~= false then
        data.phase = decodedData.phase
    end
    if decodedData.overTimeS ~= nil and decodedData.overTimeSSpecified ~= false then
        data.overTimeS = decodedData.overTimeS
    end
    if decodedData.playerInfos ~= nil and decodedData.playerInfosSpecified ~= false then
        for i = 1, #decodedData.playerInfos do
            data.playerInfos:Add(duplicateV2.BudoPlayerInfo(decodedData.playerInfos[i]))
        end
    end
    if decodedData.beginTimeMS ~= nil and decodedData.beginTimeMSSpecified ~= false then
        data.beginTimeMS = decodedData.beginTimeMS
    end
    return data
end

---@param decodedData duplicateV2.BudoPlayerInfo lua中的数据结构
---@return duplicateV2.BudoPlayerInfo C#中的数据结构
function duplicateV2.BudoPlayerInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.BudoPlayerInfo()
    if decodedData.playerId ~= nil and decodedData.playerIdSpecified ~= false then
        data.playerId = decodedData.playerId
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.no ~= nil and decodedData.noSpecified ~= false then
        data.no = decodedData.no
    end
    if decodedData.war ~= nil and decodedData.warSpecified ~= false then
        data.war = decodedData.war
    end
    if decodedData.killNum ~= nil and decodedData.killNumSpecified ~= false then
        data.killNum = decodedData.killNum
    end
    return data
end

---@param decodedData duplicateV2.BudoDuplicateUpdateInfo lua中的数据结构
---@return duplicateV2.BudoDuplicateUpdateInfo C#中的数据结构
function duplicateV2.BudoDuplicateUpdateInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.BudoDuplicateUpdateInfo()
    if decodedData.selfKillNum ~= nil and decodedData.selfKillNumSpecified ~= false then
        data.selfKillNum = decodedData.selfKillNum
    end
    if decodedData.war ~= nil and decodedData.warSpecified ~= false then
        data.war = decodedData.war
    end
    if decodedData.playerCount ~= nil and decodedData.playerCountSpecified ~= false then
        data.playerCount = decodedData.playerCount
    end
    if decodedData.no ~= nil and decodedData.noSpecified ~= false then
        data.no = decodedData.no
    end
    return data
end

---@param decodedData duplicateV2.SabacTacticsInfo lua中的数据结构
---@return duplicateV2.SabacTacticsInfo C#中的数据结构
function duplicateV2.SabacTacticsInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.SabacTacticsInfo()
    data.roleId = decodedData.roleId
    if decodedData.roleName ~= nil and decodedData.roleNameSpecified ~= false then
        data.roleName = decodedData.roleName
    end
    data.unionId = decodedData.unionId
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.active ~= nil and decodedData.activeSpecified ~= false then
        data.active = decodedData.active
    end
    data.uniteId = decodedData.uniteId
    if decodedData.uniteType ~= nil and decodedData.uniteTypeSpecified ~= false then
        data.uniteType = decodedData.uniteType
    end
    return data
end

---@param decodedData duplicateV2.ResSabacTactics lua中的数据结构
---@return duplicateV2.ResSabacTactics C#中的数据结构
function duplicateV2.ResSabacTactics(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResSabacTactics()
    if decodedData.tactics ~= nil and decodedData.tacticsSpecified ~= false then
        for i = 1, #decodedData.tactics do
            data.tactics:Add(duplicateV2.SabacTacticsInfo(decodedData.tactics[i]))
        end
    end
    if decodedData.tacticsEndTime ~= nil and decodedData.tacticsEndTimeSpecified ~= false then
        data.tacticsEndTime = decodedData.tacticsEndTime
    end
    return data
end

---@param decodedData duplicateV2.ResSabacTacticsActived lua中的数据结构
---@return duplicateV2.ResSabacTacticsActived C#中的数据结构
function duplicateV2.ResSabacTacticsActived(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResSabacTacticsActived()
    if decodedData.activeTime ~= nil and decodedData.activeTimeSpecified ~= false then
        data.activeTime = decodedData.activeTime
    end
    return data
end

---@param decodedData duplicateV2.SabacTacticsEffect lua中的数据结构
---@return duplicateV2.SabacTacticsEffect C#中的数据结构
function duplicateV2.SabacTacticsEffect(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.SabacTacticsEffect()
    data.id = decodedData.id
    if decodedData.damage ~= nil and decodedData.damageSpecified ~= false then
        data.damage = decodedData.damage
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    return data
end

---@param decodedData duplicateV2.ResSabacTacticsEffect lua中的数据结构
---@return duplicateV2.ResSabacTacticsEffect C#中的数据结构
function duplicateV2.ResSabacTacticsEffect(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResSabacTacticsEffect()
    data.hurt = duplicateV2.SabacTacticsEffect(decodedData.hurt)
    if decodedData.combinedServantsHurt ~= nil and decodedData.combinedServantsHurtSpecified ~= false then
        for i = 1, #decodedData.combinedServantsHurt do
            data.combinedServantsHurt:Add(duplicateV2.SabacTacticsEffect(decodedData.combinedServantsHurt[i]))
        end
    end
    return data
end

---@param decodedData duplicateV2.ResCrowdFundingPanel lua中的数据结构
---@return duplicateV2.ResCrowdFundingPanel C#中的数据结构
function duplicateV2.ResCrowdFundingPanel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResCrowdFundingPanel()
    if decodedData.ids ~= nil and decodedData.idsSpecified ~= false then
        for i = 1, #decodedData.ids do
            data.ids:Add(decodedData.ids[i])
        end
    end
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        data.info = duplicateV2.CrowdFundingInfo(decodedData.info)
    end
    return data
end

---@param decodedData duplicateV2.CrowdFundingInfo lua中的数据结构
---@return duplicateV2.CrowdFundingInfo C#中的数据结构
function duplicateV2.CrowdFundingInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.CrowdFundingInfo()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.startTime ~= nil and decodedData.startTimeSpecified ~= false then
        data.startTime = decodedData.startTime
    end
    if decodedData.fundingEndTime ~= nil and decodedData.fundingEndTimeSpecified ~= false then
        data.fundingEndTime = decodedData.fundingEndTime
    end
    if decodedData.nowMoney ~= nil and decodedData.nowMoneySpecified ~= false then
        data.nowMoney = decodedData.nowMoney
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData duplicateV2.ReqOpenCrowdFunding lua中的数据结构
---@return duplicateV2.ReqOpenCrowdFunding C#中的数据结构
function duplicateV2.ReqOpenCrowdFunding(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqOpenCrowdFunding()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.startMins ~= nil and decodedData.startMinsSpecified ~= false then
        data.startMins = decodedData.startMins
    end
    if decodedData.money ~= nil and decodedData.moneySpecified ~= false then
        data.money = decodedData.money
    end
    if decodedData.unionMoney ~= nil and decodedData.unionMoneySpecified ~= false then
        data.unionMoney = decodedData.unionMoney
    end
    return data
end

---@param decodedData duplicateV2.ReqDonateFunding lua中的数据结构
---@return duplicateV2.ReqDonateFunding C#中的数据结构
function duplicateV2.ReqDonateFunding(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqDonateFunding()
    if decodedData.money ~= nil and decodedData.moneySpecified ~= false then
        data.money = decodedData.money
    end
    if decodedData.unionMoney ~= nil and decodedData.unionMoneySpecified ~= false then
        data.unionMoney = decodedData.unionMoney
    end
    return data
end

---@param decodedData duplicateV2.ResCrowdFundingChange lua中的数据结构
---@return duplicateV2.ResCrowdFundingChange C#中的数据结构
function duplicateV2.ResCrowdFundingChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResCrowdFundingChange()
    if decodedData.nowMoney ~= nil and decodedData.nowMoneySpecified ~= false then
        data.nowMoney = decodedData.nowMoney
    end
    return data
end

---@param decodedData duplicateV2.SabacPlayerInfo lua中的数据结构
---@return duplicateV2.SabacPlayerInfo C#中的数据结构
function duplicateV2.SabacPlayerInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.SabacPlayerInfo()
    data.roleId = decodedData.roleId
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.unionPos ~= nil and decodedData.unionPosSpecified ~= false then
        data.unionPos = decodedData.unionPos
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    return data
end

---@param decodedData duplicateV2.ResBrokerPanel lua中的数据结构
---@return duplicateV2.ResBrokerPanel C#中的数据结构
function duplicateV2.ResBrokerPanel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResBrokerPanel()
    data.unionId = decodedData.unionId
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.players ~= nil and decodedData.playersSpecified ~= false then
        for i = 1, #decodedData.players do
            data.players:Add(duplicateV2.SabacPlayerInfo(decodedData.players[i]))
        end
    end
    return data
end

---@param decodedData duplicateV2.ReqBrokerQuery lua中的数据结构
---@return duplicateV2.ReqBrokerQuery C#中的数据结构
function duplicateV2.ReqBrokerQuery(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqBrokerQuery()
    data.roleId = decodedData.roleId
    return data
end

---@param decodedData duplicateV2.PlayerActivityData lua中的数据结构
---@return duplicateV2.PlayerActivityData C#中的数据结构
function duplicateV2.PlayerActivityData(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.PlayerActivityData()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.roleName ~= nil and decodedData.roleNameSpecified ~= false then
        data.roleName = decodedData.roleName
    end
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.kill ~= nil and decodedData.killSpecified ~= false then
        data.kill = decodedData.kill
    end
    if decodedData.bossHurt ~= nil and decodedData.bossHurtSpecified ~= false then
        data.bossHurt = decodedData.bossHurt
    end
    if decodedData.bossKill ~= nil and decodedData.bossKillSpecified ~= false then
        data.bossKill = decodedData.bossKill
    end
    if decodedData.score ~= nil and decodedData.scoreSpecified ~= false then
        data.score = decodedData.score
    end
    if decodedData.getTitle ~= nil and decodedData.getTitleSpecified ~= false then
        data.getTitle = decodedData.getTitle
    end
    if decodedData.likes ~= nil and decodedData.likesSpecified ~= false then
        data.likes = duplicateV2.LikeList(decodedData.likes)
    end
    if decodedData.hostId ~= nil and decodedData.hostIdSpecified ~= false then
        data.hostId = decodedData.hostId
    end
    return data
end

---@param decodedData duplicateV2.ResPlayerActivityDataRank lua中的数据结构
---@return duplicateV2.ResPlayerActivityDataRank C#中的数据结构
function duplicateV2.ResPlayerActivityDataRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResPlayerActivityDataRank()
    if decodedData.playerData ~= nil and decodedData.playerDataSpecified ~= false then
        for i = 1, #decodedData.playerData do
            data.playerData:Add(duplicateV2.PlayerActivityData(decodedData.playerData[i]))
        end
    end
    if decodedData.otherPlayerData ~= nil and decodedData.otherPlayerDataSpecified ~= false then
        for i = 1, #decodedData.otherPlayerData do
            data.otherPlayerData:Add(duplicateV2.PlayerActivityData(decodedData.otherPlayerData[i]))
        end
    end
    if decodedData.allBossHurt ~= nil and decodedData.allBossHurtSpecified ~= false then
        data.allBossHurt = decodedData.allBossHurt
    end
    if decodedData.allBossKill ~= nil and decodedData.allBossKillSpecified ~= false then
        data.allBossKill = decodedData.allBossKill
    end
    if decodedData.allKill ~= nil and decodedData.allKillSpecified ~= false then
        data.allKill = decodedData.allKill
    end
    return data
end

---@param decodedData duplicateV2.ActivityEndRank lua中的数据结构
---@return duplicateV2.ActivityEndRank C#中的数据结构
function duplicateV2.ActivityEndRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ActivityEndRank()
    if decodedData.playerData ~= nil and decodedData.playerDataSpecified ~= false then
        for i = 1, #decodedData.playerData do
            data.playerData:Add(duplicateV2.PlayerActivityData(decodedData.playerData[i]))
        end
    end
    if decodedData.otherPlayerData ~= nil and decodedData.otherPlayerDataSpecified ~= false then
        for i = 1, #decodedData.otherPlayerData do
            data.otherPlayerData:Add(duplicateV2.PlayerActivityData(decodedData.otherPlayerData[i]))
        end
    end
    if decodedData.allBossHurt ~= nil and decodedData.allBossHurtSpecified ~= false then
        data.allBossHurt = decodedData.allBossHurt
    end
    if decodedData.allBossKill ~= nil and decodedData.allBossKillSpecified ~= false then
        data.allBossKill = decodedData.allBossKill
    end
    if decodedData.allKill ~= nil and decodedData.allKillSpecified ~= false then
        data.allKill = decodedData.allKill
    end
    return data
end

---@param decodedData duplicateV2.GetGoddessBlessingRank lua中的数据结构
---@return duplicateV2.GetGoddessBlessingRank C#中的数据结构
function duplicateV2.GetGoddessBlessingRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.GetGoddessBlessingRank()
    if decodedData.rankType ~= nil and decodedData.rankTypeSpecified ~= false then
        data.rankType = decodedData.rankType
    end
    return data
end

---@param decodedData duplicateV2.GoddessBlessingRankInfo lua中的数据结构
---@return duplicateV2.GoddessBlessingRankInfo C#中的数据结构
function duplicateV2.GoddessBlessingRankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.GoddessBlessingRankInfo()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.players ~= nil and decodedData.playersSpecified ~= false then
        for i = 1, #decodedData.players do
            data.players:Add(duplicateV2.GoddessBlessingPlayerInfo(decodedData.players[i]))
        end
    end
    if decodedData.rankType ~= nil and decodedData.rankTypeSpecified ~= false then
        data.rankType = decodedData.rankType
    end
    return data
end

---@param decodedData duplicateV2.GoddessBlessingPlayerInfo lua中的数据结构
---@return duplicateV2.GoddessBlessingPlayerInfo C#中的数据结构
function duplicateV2.GoddessBlessingPlayerInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.GoddessBlessingPlayerInfo()
    data.roleId = decodedData.roleId
    if decodedData.roleName ~= nil and decodedData.roleNameSpecified ~= false then
        data.roleName = decodedData.roleName
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.convertedEarning ~= nil and decodedData.convertedEarningSpecified ~= false then
        data.convertedEarning = decodedData.convertedEarning
    end
    if decodedData.killNumber ~= nil and decodedData.killNumberSpecified ~= false then
        data.killNumber = decodedData.killNumber
    end
    if decodedData.likes ~= nil and decodedData.likesSpecified ~= false then
        data.likes = duplicateV2.LikeList(decodedData.likes)
    end
    if decodedData.score ~= nil and decodedData.scoreSpecified ~= false then
        data.score = decodedData.score
    end
    if decodedData.hostId ~= nil and decodedData.hostIdSpecified ~= false then
        data.hostId = decodedData.hostId
    end
    if decodedData.awardItems ~= nil and decodedData.awardItemsSpecified ~= false then
        for i = 1, #decodedData.awardItems do
            data.awardItems:Add(duplicateV2.BudoAwardItem(decodedData.awardItems[i]))
        end
    end
    return data
end

---@param decodedData duplicateV2.ReqGBPreviousPeriodTime lua中的数据结构
---@return duplicateV2.ReqGBPreviousPeriodTime C#中的数据结构
function duplicateV2.ReqGBPreviousPeriodTime(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqGBPreviousPeriodTime()
    data.activityType = decodedData.activityType
    return data
end

---@param decodedData duplicateV2.ResGBPreviousPeriodTime lua中的数据结构
---@return duplicateV2.ResGBPreviousPeriodTime C#中的数据结构
function duplicateV2.ResGBPreviousPeriodTime(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResGBPreviousPeriodTime()
    if decodedData.times ~= nil and decodedData.timesSpecified ~= false then
        for i = 1, #decodedData.times do
            data.times:Add(decodedData.times[i])
        end
    end
    if decodedData.activityType ~= nil and decodedData.activityTypeSpecified ~= false then
        data.activityType = decodedData.activityType
    end
    return data
end

---@param decodedData duplicateV2.ReqGBPreviousPeriodInfo lua中的数据结构
---@return duplicateV2.ReqGBPreviousPeriodInfo C#中的数据结构
function duplicateV2.ReqGBPreviousPeriodInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqGBPreviousPeriodInfo()
    if decodedData.times ~= nil and decodedData.timesSpecified ~= false then
        data.times = decodedData.times
    end
    return data
end

---@param decodedData duplicateV2.LikeRequest lua中的数据结构
---@return duplicateV2.LikeRequest C#中的数据结构
function duplicateV2.LikeRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.LikeRequest()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    if decodedData.periodParam ~= nil and decodedData.periodParamSpecified ~= false then
        data.periodParam = decodedData.periodParam
    end
    return data
end

---@param decodedData duplicateV2.LikeResponseCommon lua中的数据结构
---@return duplicateV2.LikeResponseCommon C#中的数据结构
function duplicateV2.LikeResponseCommon(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.LikeResponseCommon()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.trigger ~= nil and decodedData.triggerSpecified ~= false then
        data.trigger = decodedData.trigger
    end
    if decodedData.periodParam ~= nil and decodedData.periodParamSpecified ~= false then
        data.periodParam = decodedData.periodParam
    end
    return data
end

---@param decodedData duplicateV2.LikeList lua中的数据结构
---@return duplicateV2.LikeList C#中的数据结构
function duplicateV2.LikeList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.LikeList()
    if decodedData.likes ~= nil and decodedData.likesSpecified ~= false then
        for i = 1, #decodedData.likes do
            data.likes:Add(decodedData.likes[i])
        end
    end
    return data
end

---@param decodedData duplicateV2.ReqLookBudoMeet lua中的数据结构
---@return duplicateV2.ReqLookBudoMeet C#中的数据结构
function duplicateV2.ReqLookBudoMeet(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqLookBudoMeet()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.history ~= nil and decodedData.historySpecified ~= false then
        data.history = decodedData.history
    end
    return data
end

---@param decodedData duplicateV2.ResTodayUseFirework lua中的数据结构
---@return duplicateV2.ResTodayUseFirework C#中的数据结构
function duplicateV2.ResTodayUseFirework(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResTodayUseFirework()
    if decodedData.isUse ~= nil and decodedData.isUseSpecified ~= false then
        data.isUse = decodedData.isUse
    end
    return data
end

---@param decodedData duplicateV2.ReqGetPreviousReview lua中的数据结构
---@return duplicateV2.ReqGetPreviousReview C#中的数据结构
function duplicateV2.ReqGetPreviousReview(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqGetPreviousReview()
    if decodedData.activeType ~= nil and decodedData.activeTypeSpecified ~= false then
        data.activeType = decodedData.activeType
    end
    return data
end

---@param decodedData duplicateV2.ResGetPreviousReview lua中的数据结构
---@return duplicateV2.ResGetPreviousReview C#中的数据结构
function duplicateV2.ResGetPreviousReview(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResGetPreviousReview()
    if decodedData.activeTime ~= nil and decodedData.activeTimeSpecified ~= false then
        for i = 1, #decodedData.activeTime do
            data.activeTime:Add(decodedData.activeTime[i])
        end
    end
    return data
end

---@param decodedData duplicateV2.ReqGetSpecificPreviousReview lua中的数据结构
---@return duplicateV2.ReqGetSpecificPreviousReview C#中的数据结构
function duplicateV2.ReqGetSpecificPreviousReview(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqGetSpecificPreviousReview()
    if decodedData.activeType ~= nil and decodedData.activeTypeSpecified ~= false then
        data.activeType = decodedData.activeType
    end
    if decodedData.activeTime ~= nil and decodedData.activeTimeSpecified ~= false then
        data.activeTime = decodedData.activeTime
    end
    return data
end

---@param decodedData duplicateV2.ResDreamlandRankInfo lua中的数据结构
---@return duplicateV2.ResDreamlandRankInfo C#中的数据结构
function duplicateV2.ResDreamlandRankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResDreamlandRankInfo()
    if decodedData.myUnionRank ~= nil and decodedData.myUnionRankSpecified ~= false then
        for i = 1, #decodedData.myUnionRank do
            data.myUnionRank:Add(duplicateV2.PlayerActivityData(decodedData.myUnionRank[i]))
        end
    end
    if decodedData.otherUnionRank ~= nil and decodedData.otherUnionRankSpecified ~= false then
        for i = 1, #decodedData.otherUnionRank do
            data.otherUnionRank:Add(duplicateV2.PlayerActivityData(decodedData.otherUnionRank[i]))
        end
    end
    if decodedData.allBossHurt ~= nil and decodedData.allBossHurtSpecified ~= false then
        data.allBossHurt = decodedData.allBossHurt
    end
    if decodedData.allBossKill ~= nil and decodedData.allBossKillSpecified ~= false then
        data.allBossKill = decodedData.allBossKill
    end
    if decodedData.allKill ~= nil and decodedData.allKillSpecified ~= false then
        data.allKill = decodedData.allKill
    end
    return data
end

---@param decodedData duplicateV2.ReqSeePreviousData lua中的数据结构
---@return duplicateV2.ReqSeePreviousData C#中的数据结构
function duplicateV2.ReqSeePreviousData(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqSeePreviousData()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData duplicateV2.ReqClosePreviousData lua中的数据结构
---@return duplicateV2.ReqClosePreviousData C#中的数据结构
function duplicateV2.ReqClosePreviousData(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqClosePreviousData()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData duplicateV2.ResBudoMeetAround lua中的数据结构
---@return duplicateV2.ResBudoMeetAround C#中的数据结构
function duplicateV2.ResBudoMeetAround(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResBudoMeetAround()
    if decodedData.phase ~= nil and decodedData.phaseSpecified ~= false then
        data.phase = decodedData.phase
    end
    if decodedData.warPoint ~= nil and decodedData.warPointSpecified ~= false then
        for i = 1, #decodedData.warPoint do
            data.warPoint:Add(duplicateV2.Point(decodedData.warPoint[i]))
        end
    end
    if decodedData.wallPoint ~= nil and decodedData.wallPointSpecified ~= false then
        for i = 1, #decodedData.wallPoint do
            data.wallPoint:Add(duplicateV2.Point(decodedData.wallPoint[i]))
        end
    end
    return data
end

---@param decodedData duplicateV2.Point lua中的数据结构
---@return duplicateV2.Point C#中的数据结构
function duplicateV2.Point(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.Point()
    if decodedData.pointX ~= nil and decodedData.pointXSpecified ~= false then
        data.pointX = decodedData.pointX
    end
    if decodedData.pointY ~= nil and decodedData.pointYSpecified ~= false then
        data.pointY = decodedData.pointY
    end
    return data
end

---@param decodedData duplicateV2.ResDevilSquareEndTime lua中的数据结构
---@return duplicateV2.ResDevilSquareEndTime C#中的数据结构
function duplicateV2.ResDevilSquareEndTime(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResDevilSquareEndTime()
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    --C#的duplicateV2.ResDevilSquareEndTime类中没有找到duplicateType字段,不填充数据
    return data
end

--[[duplicateV2.ReqDevilSquareEndTime 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData duplicateV2.ResDevilSquareHasTime lua中的数据结构
---@return duplicateV2.ResDevilSquareHasTime C#中的数据结构
function duplicateV2.ResDevilSquareHasTime(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResDevilSquareHasTime()
    if decodedData.hasTime ~= nil and decodedData.hasTimeSpecified ~= false then
        data.hasTime = decodedData.hasTime
    end
    --C#的duplicateV2.ResDevilSquareHasTime类中没有找到duplicateType字段,不填充数据
    return data
end

---@param decodedData duplicateV2.ResUseDevilScrollPrompt lua中的数据结构
---@return duplicateV2.ResUseDevilScrollPrompt C#中的数据结构
function duplicateV2.ResUseDevilScrollPrompt(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResUseDevilScrollPrompt()
    if decodedData.deliverId ~= nil and decodedData.deliverIdSpecified ~= false then
        data.deliverId = decodedData.deliverId
    end
    return data
end

---@param decodedData duplicateV2.ReqReliveHuntMonster lua中的数据结构
---@return duplicateV2.ReqReliveHuntMonster C#中的数据结构
function duplicateV2.ReqReliveHuntMonster(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ReqReliveHuntMonster()
    if decodedData.NpcId ~= nil and decodedData.NpcIdSpecified ~= false then
        data.NpcId = decodedData.NpcId
    end
    return data
end

---@param decodedData duplicateV2.BudoBetBeiInfo lua中的数据结构
---@return duplicateV2.BudoBetBeiInfo C#中的数据结构
function duplicateV2.BudoBetBeiInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.BudoBetBeiInfo()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(duplicateV2.PlayerBetBeiInfo(decodedData.info[i]))
        end
    end
    return data
end

---@param decodedData duplicateV2.PlayerBetBeiInfo lua中的数据结构
---@return duplicateV2.PlayerBetBeiInfo C#中的数据结构
function duplicateV2.PlayerBetBeiInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.PlayerBetBeiInfo()
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    if decodedData.someSelectBetInt ~= nil and decodedData.someSelectBetIntSpecified ~= false then
        data.someSelectBetInt = decodedData.someSelectBetInt
    end
    if decodedData.finalBetInt ~= nil and decodedData.finalBetIntSpecified ~= false then
        data.finalBetInt = decodedData.finalBetInt
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData duplicateV2.BudoBetSuccess lua中的数据结构
---@return duplicateV2.BudoBetSuccess C#中的数据结构
function duplicateV2.BudoBetSuccess(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.BudoBetSuccess()
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    if decodedData.canZhu ~= nil and decodedData.canZhuSpecified ~= false then
        data.canZhu = decodedData.canZhu
    end
    if decodedData.targetZhu ~= nil and decodedData.targetZhuSpecified ~= false then
        data.targetZhu = decodedData.targetZhu
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.betInt ~= nil and decodedData.betIntSpecified ~= false then
        data.betInt = decodedData.betInt
    end
    return data
end

---@param decodedData duplicateV2.ResWolfDreamXpSkillChangeTime lua中的数据结构
---@return duplicateV2.ResWolfDreamXpSkillChangeTime C#中的数据结构
function duplicateV2.ResWolfDreamXpSkillChangeTime(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.ResWolfDreamXpSkillChangeTime()
    if decodedData.skillId ~= nil and decodedData.skillIdSpecified ~= false then
        data.skillId = decodedData.skillId
    end
    return data
end

---@param decodedData duplicateV2.UndergroundDuplicateInfo lua中的数据结构
---@return duplicateV2.UndergroundDuplicateInfo C#中的数据结构
function duplicateV2.UndergroundDuplicateInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.UndergroundDuplicateInfo()
    if decodedData.monsterLiveLeft ~= nil and decodedData.monsterLiveLeftSpecified ~= false then
        data.monsterLiveLeft = decodedData.monsterLiveLeft
    end
    return data
end

---@param decodedData duplicateV2.UndergroundMyUnionRank lua中的数据结构
---@return duplicateV2.UndergroundMyUnionRank C#中的数据结构
function duplicateV2.UndergroundMyUnionRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.UndergroundMyUnionRank()
    if decodedData.myUnionRank ~= nil and decodedData.myUnionRankSpecified ~= false then
        data.myUnionRank = decodedData.myUnionRank
    end
    return data
end

---@param decodedData duplicateV2.PushBubble lua中的数据结构
---@return duplicateV2.PushBubble C#中的数据结构
function duplicateV2.PushBubble(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.PushBubble()
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.monsterId ~= nil and decodedData.monsterIdSpecified ~= false then
        data.monsterId = decodedData.monsterId
    end
    return data
end

---@param decodedData duplicateV2.RaiderInfo lua中的数据结构
---@return duplicateV2.RaiderInfo C#中的数据结构
function duplicateV2.RaiderInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.RaiderInfo()
    if decodedData.wave ~= nil and decodedData.waveSpecified ~= false then
        data.wave = decodedData.wave
    end
    if decodedData.nextWaveTime ~= nil and decodedData.nextWaveTimeSpecified ~= false then
        data.nextWaveTime = decodedData.nextWaveTime
    end
    if decodedData.curMonsterNum ~= nil and decodedData.curMonsterNumSpecified ~= false then
        data.curMonsterNum = decodedData.curMonsterNum
    end
    if decodedData.raiderSpecialItemInfos ~= nil and decodedData.raiderSpecialItemInfosSpecified ~= false then
        for i = 1, #decodedData.raiderSpecialItemInfos do
            data.raiderSpecialItemInfos:Add(duplicateV2.RaiderSpecialItemInfo(decodedData.raiderSpecialItemInfos[i]))
        end
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    return data
end

---@param decodedData duplicateV2.RaiderSpecialItemInfo lua中的数据结构
---@return duplicateV2.RaiderSpecialItemInfo C#中的数据结构
function duplicateV2.RaiderSpecialItemInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.RaiderSpecialItemInfo()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    return data
end

---@param decodedData duplicateV2.SabacReward lua中的数据结构
---@return duplicateV2.SabacReward C#中的数据结构
function duplicateV2.SabacReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.duplicateV2.SabacReward()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

--[[duplicateV2.ResTowerInstanceEndGetReward 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[duplicateV2.TowerReward 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return duplicateV2