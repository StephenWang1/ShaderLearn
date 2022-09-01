--[[本文件为工具自动生成,禁止手动修改]]
local unionV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData unionV2.ReqGetUnionJournal lua中的数据结构
---@return unionV2.ReqGetUnionJournal C#中的数据结构
function unionV2.ReqGetUnionJournal(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqGetUnionJournal()
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    return data
end

---@param decodedData unionV2.ResGetUnionJournal lua中的数据结构
---@return unionV2.ResGetUnionJournal C#中的数据结构
function unionV2.ResGetUnionJournal(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResGetUnionJournal()
    if decodedData.unionJournalInfo ~= nil and decodedData.unionJournalInfoSpecified ~= false then
        for i = 1, #decodedData.unionJournalInfo do
            data.unionJournalInfo:Add(unionV2.UnionJournal(decodedData.unionJournalInfo[i]))
        end
    end
    return data
end

---@param decodedData unionV2.UnionJournal lua中的数据结构
---@return unionV2.UnionJournal C#中的数据结构
function unionV2.UnionJournal(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionJournal()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.operationTime ~= nil and decodedData.operationTimeSpecified ~= false then
        data.operationTime = decodedData.operationTime
    end
    if decodedData.operation ~= nil and decodedData.operationSpecified ~= false then
        data.operation = decodedData.operation
    end
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData unionV2.ReqGetUnionAttribute lua中的数据结构
---@return unionV2.ReqGetUnionAttribute C#中的数据结构
function unionV2.ReqGetUnionAttribute(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqGetUnionAttribute()
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    return data
end

---@param decodedData unionV2.ResGetUnionAttribute lua中的数据结构
---@return unionV2.ResGetUnionAttribute C#中的数据结构
function unionV2.ResGetUnionAttribute(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResGetUnionAttribute()
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.thisAttribute ~= nil and decodedData.thisAttributeSpecified ~= false then
        data.thisAttribute = decodedData.thisAttribute
    end
    if decodedData.perfectPopulation ~= nil and decodedData.perfectPopulationSpecified ~= false then
        data.perfectPopulation = decodedData.perfectPopulation
    end
    if decodedData.thisNum ~= nil and decodedData.thisNumSpecified ~= false then
        data.thisNum = decodedData.thisNum
    end
    if decodedData.attackWarrior ~= nil and decodedData.attackWarriorSpecified ~= false then
        data.attackWarrior = decodedData.attackWarrior
    end
    if decodedData.attackMagic ~= nil and decodedData.attackMagicSpecified ~= false then
        data.attackMagic = decodedData.attackMagic
    end
    if decodedData.attackMonk ~= nil and decodedData.attackMonkSpecified ~= false then
        data.attackMonk = decodedData.attackMonk
    end
    if decodedData.phyDefense ~= nil and decodedData.phyDefenseSpecified ~= false then
        data.phyDefense = decodedData.phyDefense
    end
    if decodedData.magDefense ~= nil and decodedData.magDefenseSpecified ~= false then
        data.magDefense = decodedData.magDefense
    end
    if decodedData.blood ~= nil and decodedData.bloodSpecified ~= false then
        data.blood = decodedData.blood
    end
    if decodedData.unionBossRankNo ~= nil and decodedData.unionBossRankNoSpecified ~= false then
        data.unionBossRankNo = decodedData.unionBossRankNo
    end
    return data
end

---@param decodedData unionV2.ReqGetAllUnionIcon lua中的数据结构
---@return unionV2.ReqGetAllUnionIcon C#中的数据结构
function unionV2.ReqGetAllUnionIcon(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqGetAllUnionIcon()
    if decodedData.isReturnRare ~= nil and decodedData.isReturnRareSpecified ~= false then
        data.isReturnRare = decodedData.isReturnRare
    end
    return data
end

---@param decodedData unionV2.ResGetAllUnionIcon lua中的数据结构
---@return unionV2.ResGetAllUnionIcon C#中的数据结构
function unionV2.ResGetAllUnionIcon(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResGetAllUnionIcon()
    if decodedData.unionIconInfo ~= nil and decodedData.unionIconInfoSpecified ~= false then
        for i = 1, #decodedData.unionIconInfo do
            data.unionIconInfo:Add(unionV2.UnionIconInfo(decodedData.unionIconInfo[i]))
        end
    end
    return data
end

---@param decodedData unionV2.UnionIconInfo lua中的数据结构
---@return unionV2.UnionIconInfo C#中的数据结构
function unionV2.UnionIconInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionIconInfo()
    if decodedData.unionIconId ~= nil and decodedData.unionIconIdSpecified ~= false then
        data.unionIconId = decodedData.unionIconId
    end
    if decodedData.isHave ~= nil and decodedData.isHaveSpecified ~= false then
        data.isHave = decodedData.isHave
    end
    if decodedData.isXiyou ~= nil and decodedData.isXiyouSpecified ~= false then
        data.isXiyou = decodedData.isXiyou
    end
    return data
end

---@param decodedData unionV2.ReqSendAllUnionInfo lua中的数据结构
---@return unionV2.ReqSendAllUnionInfo C#中的数据结构
function unionV2.ReqSendAllUnionInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqSendAllUnionInfo()
    return data
end

---@param decodedData unionV2.ResSendAllUnionInfo lua中的数据结构
---@return unionV2.ResSendAllUnionInfo C#中的数据结构
function unionV2.ResSendAllUnionInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResSendAllUnionInfo()
    if decodedData.unionInfo ~= nil and decodedData.unionInfoSpecified ~= false then
        for i = 1, #decodedData.unionInfo do
            data.unionInfo:Add(unionV2.UnionInfo(decodedData.unionInfo[i]))
        end
    end
    if decodedData.exitUnionTime ~= nil and decodedData.exitUnionTimeSpecified ~= false then
        data.exitUnionTime = decodedData.exitUnionTime
    end
    if decodedData.dissolutionTime ~= nil and decodedData.dissolutionTimeSpecified ~= false then
        data.dissolutionTime = decodedData.dissolutionTime
    end
    if decodedData.canCreatUnion ~= nil and decodedData.canCreatUnionSpecified ~= false then
        data.canCreatUnion = decodedData.canCreatUnion
    end
    return data
end

---@param decodedData unionV2.UnionInfo lua中的数据结构
---@return unionV2.UnionInfo C#中的数据结构
function unionV2.UnionInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionInfo()
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.leaderName ~= nil and decodedData.leaderNameSpecified ~= false then
        data.leaderName = decodedData.leaderName
    end
    if decodedData.announcement ~= nil and decodedData.announcementSpecified ~= false then
        data.announcement = decodedData.announcement
    end
    if decodedData.unionNum ~= nil and decodedData.unionNumSpecified ~= false then
        data.unionNum = decodedData.unionNum
    end
    if decodedData.applyState ~= nil and decodedData.applyStateSpecified ~= false then
        data.applyState = decodedData.applyState
    end
    if decodedData.createTime ~= nil and decodedData.createTimeSpecified ~= false then
        data.createTime = decodedData.createTime
    end
    if decodedData.nbValue ~= nil and decodedData.nbValueSpecified ~= false then
        data.nbValue = decodedData.nbValue
    end
    if decodedData.unionGold ~= nil and decodedData.unionGoldSpecified ~= false then
        data.unionGold = decodedData.unionGold
    end
    if decodedData.autoEnter ~= nil and decodedData.autoEnterSpecified ~= false then
        data.autoEnter = decodedData.autoEnter
    end
    if decodedData.isImpeachment ~= nil and decodedData.isImpeachmentSpecified ~= false then
        data.isImpeachment = decodedData.isImpeachment
    end
    if decodedData.impeachmentTime ~= nil and decodedData.impeachmentTimeSpecified ~= false then
        data.impeachmentTime = decodedData.impeachmentTime
    end
    if decodedData.leaderOnline ~= nil and decodedData.leaderOnlineSpecified ~= false then
        data.leaderOnline = decodedData.leaderOnline
    end
    if decodedData.unionIcon ~= nil and decodedData.unionIconSpecified ~= false then
        data.unionIcon = decodedData.unionIcon
    end
    if decodedData.leaderId ~= nil and decodedData.leaderIdSpecified ~= false then
        data.leaderId = decodedData.leaderId
    end
    if decodedData.modifyCount ~= nil and decodedData.modifyCountSpecified ~= false then
        data.modifyCount = decodedData.modifyCount
    end
    if decodedData.canUseUnionCallBackPosition ~= nil and decodedData.canUseUnionCallBackPositionSpecified ~= false then
        data.canUseUnionCallBackPosition = decodedData.canUseUnionCallBackPosition
    end
    if decodedData.sabacScore ~= nil and decodedData.sabacScoreSpecified ~= false then
        data.sabacScore = decodedData.sabacScore
    end
    if decodedData.crown ~= nil and decodedData.crownSpecified ~= false then
        data.crown = decodedData.crown
    end
    if decodedData.isPayImeach ~= nil and decodedData.isPayImeachSpecified ~= false then
        data.isPayImeach = decodedData.isPayImeach
    end
    if decodedData.lastCombineTime ~= nil and decodedData.lastCombineTimeSpecified ~= false then
        data.lastCombineTime = decodedData.lastCombineTime
    end
    if decodedData.rank ~= nil and decodedData.rankSpecified ~= false then
        data.rank = decodedData.rank
    end
    if decodedData.seizeCityId ~= nil and decodedData.seizeCityIdSpecified ~= false then
        data.seizeCityId = decodedData.seizeCityId
    end
    if decodedData.unionTodayTax ~= nil and decodedData.unionTodayTaxSpecified ~= false then
        data.unionTodayTax = decodedData.unionTodayTax
    end
    if decodedData.isPushUnion ~= nil and decodedData.isPushUnionSpecified ~= false then
        data.isPushUnion = decodedData.isPushUnion
    end
    if decodedData.unionAcvite ~= nil and decodedData.unionAcviteSpecified ~= false then
        data.unionAcvite = decodedData.unionAcvite
    end
    if decodedData.unionActiveYesterday ~= nil and decodedData.unionActiveYesterdaySpecified ~= false then
        data.unionActiveYesterday = decodedData.unionActiveYesterday
    end
    if decodedData.unionActiveRankYesterday ~= nil and decodedData.unionActiveRankYesterdaySpecified ~= false then
        data.unionActiveRankYesterday = decodedData.unionActiveRankYesterday
    end
    if decodedData.lastCallBackTime ~= nil and decodedData.lastCallBackTimeSpecified ~= false then
        data.lastCallBackTime = decodedData.lastCallBackTime
    end
    if decodedData.isAutoCreated ~= nil and decodedData.isAutoCreatedSpecified ~= false then
        data.isAutoCreated = decodedData.isAutoCreated
    end
    if decodedData.unionBossRankNo ~= nil and decodedData.unionBossRankNoSpecified ~= false then
        data.unionBossRankNo = decodedData.unionBossRankNo
    end
    return data
end

---@param decodedData unionV2.UnionChatAnnounce lua中的数据结构
---@return unionV2.UnionChatAnnounce C#中的数据结构
function unionV2.UnionChatAnnounce(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionChatAnnounce()
    if decodedData.announce ~= nil and decodedData.announceSpecified ~= false then
        data.announce = decodeTable.chat.ResAnnounce(decodedData.announce)
    end
    if decodedData.chat ~= nil and decodedData.chatSpecified ~= false then
        data.chat = decodeTable.chat.ResChat(decodedData.chat)
    end
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    return data
end

---@param decodedData unionV2.ResUnionChatAnnounce lua中的数据结构
---@return unionV2.ResUnionChatAnnounce C#中的数据结构
function unionV2.ResUnionChatAnnounce(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResUnionChatAnnounce()
    if decodedData.announces ~= nil and decodedData.announcesSpecified ~= false then
        for i = 1, #decodedData.announces do
            data.announces:Add(unionV2.UnionChatAnnounce(decodedData.announces[i]))
        end
    end
    return data
end

---@param decodedData unionV2.ReqJoinOrWithdrawUnion lua中的数据结构
---@return unionV2.ReqJoinOrWithdrawUnion C#中的数据结构
function unionV2.ReqJoinOrWithdrawUnion(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqJoinOrWithdrawUnion()
    data.unionId = decodedData.unionId
    data.joinOrWithdraw = decodedData.joinOrWithdraw
    return data
end

---@param decodedData unionV2.ResApplyForUnionStateChange lua中的数据结构
---@return unionV2.ResApplyForUnionStateChange C#中的数据结构
function unionV2.ResApplyForUnionStateChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResApplyForUnionStateChange()
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    return data
end

---@param decodedData unionV2.UnionRedPackInfo lua中的数据结构
---@return unionV2.UnionRedPackInfo C#中的数据结构
function unionV2.UnionRedPackInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionRedPackInfo()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.senderCareer ~= nil and decodedData.senderCareerSpecified ~= false then
        data.senderCareer = decodedData.senderCareer
    end
    if decodedData.sendSex ~= nil and decodedData.sendSexSpecified ~= false then
        data.sendSex = decodedData.sendSex
    end
    if decodedData.redPackId ~= nil and decodedData.redPackIdSpecified ~= false then
        data.redPackId = decodedData.redPackId
    end
    if decodedData.money ~= nil and decodedData.moneySpecified ~= false then
        data.money = decodedData.money
    end
    if decodedData.isGet ~= nil and decodedData.isGetSpecified ~= false then
        data.isGet = decodedData.isGet
    end
    if decodedData.isNull ~= nil and decodedData.isNullSpecified ~= false then
        data.isNull = decodedData.isNull
    end
    if decodedData.content ~= nil and decodedData.contentSpecified ~= false then
        data.content = decodedData.content
    end
    if decodedData.sendTime ~= nil and decodedData.sendTimeSpecified ~= false then
        data.sendTime = decodedData.sendTime
    end
    return data
end

---@param decodedData unionV2.UnionRedPackRecordInfo lua中的数据结构
---@return unionV2.UnionRedPackRecordInfo C#中的数据结构
function unionV2.UnionRedPackRecordInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionRedPackRecordInfo()
    if decodedData.sender ~= nil and decodedData.senderSpecified ~= false then
        data.sender = decodedData.sender
    end
    if decodedData.robber ~= nil and decodedData.robberSpecified ~= false then
        data.robber = decodedData.robber
    end
    if decodedData.robberCareer ~= nil and decodedData.robberCareerSpecified ~= false then
        data.robberCareer = decodedData.robberCareer
    end
    if decodedData.robberSex ~= nil and decodedData.robberSexSpecified ~= false then
        data.robberSex = decodedData.robberSex
    end
    if decodedData.senderCareer ~= nil and decodedData.senderCareerSpecified ~= false then
        data.senderCareer = decodedData.senderCareer
    end
    if decodedData.sendSex ~= nil and decodedData.sendSexSpecified ~= false then
        data.sendSex = decodedData.sendSex
    end
    if decodedData.robTime ~= nil and decodedData.robTimeSpecified ~= false then
        data.robTime = decodedData.robTime
    end
    if decodedData.money ~= nil and decodedData.moneySpecified ~= false then
        data.money = decodedData.money
    end
    if decodedData.isBest ~= nil and decodedData.isBestSpecified ~= false then
        data.isBest = decodedData.isBest
    end
    return data
end

---@param decodedData unionV2.UnionSettingInfo lua中的数据结构
---@return unionV2.UnionSettingInfo C#中的数据结构
function unionV2.UnionSettingInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionSettingInfo()
    if decodedData.settingType ~= nil and decodedData.settingTypeSpecified ~= false then
        data.settingType = decodedData.settingType
    end
    if decodedData.settingValue ~= nil and decodedData.settingValueSpecified ~= false then
        data.settingValue = decodedData.settingValue
    end
    if decodedData.extraParam ~= nil and decodedData.extraParamSpecified ~= false then
        data.extraParam = decodedData.extraParam
    end
    return data
end

---@param decodedData unionV2.UnionEventInfo lua中的数据结构
---@return unionV2.UnionEventInfo C#中的数据结构
function unionV2.UnionEventInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionEventInfo()
    if decodedData.recordTime ~= nil and decodedData.recordTimeSpecified ~= false then
        data.recordTime = decodedData.recordTime
    end
    if decodedData.announceId ~= nil and decodedData.announceIdSpecified ~= false then
        data.announceId = decodedData.announceId
    end
    if decodedData.operate ~= nil and decodedData.operateSpecified ~= false then
        data.operate = decodedData.operate
    end
    if decodedData.target ~= nil and decodedData.targetSpecified ~= false then
        data.target = decodedData.target
    end
    if decodedData.oldLevel ~= nil and decodedData.oldLevelSpecified ~= false then
        data.oldLevel = decodedData.oldLevel
    end
    if decodedData.newLevel ~= nil and decodedData.newLevelSpecified ~= false then
        data.newLevel = decodedData.newLevel
    end
    if decodedData.redPackCount ~= nil and decodedData.redPackCountSpecified ~= false then
        data.redPackCount = decodedData.redPackCount
    end
    if decodedData.oldPosition ~= nil and decodedData.oldPositionSpecified ~= false then
        data.oldPosition = decodedData.oldPosition
    end
    if decodedData.newPosition ~= nil and decodedData.newPositionSpecified ~= false then
        data.newPosition = decodedData.newPosition
    end
    return data
end

---@param decodedData unionV2.UnionMemberInfo lua中的数据结构
---@return unionV2.UnionMemberInfo C#中的数据结构
function unionV2.UnionMemberInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionMemberInfo()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.memberName ~= nil and decodedData.memberNameSpecified ~= false then
        data.memberName = decodedData.memberName
    end
    if decodedData.position ~= nil and decodedData.positionSpecified ~= false then
        data.position = decodedData.position
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.memberLevel ~= nil and decodedData.memberLevelSpecified ~= false then
        data.memberLevel = decodedData.memberLevel
    end
    if decodedData.offlineTime ~= nil and decodedData.offlineTimeSpecified ~= false then
        data.offlineTime = decodedData.offlineTime
    end
    if decodedData.fightPower ~= nil and decodedData.fightPowerSpecified ~= false then
        data.fightPower = decodedData.fightPower
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.cloth ~= nil and decodedData.clothSpecified ~= false then
        data.cloth = decodedData.cloth
    end
    if decodedData.weapon ~= nil and decodedData.weaponSpecified ~= false then
        data.weapon = decodedData.weapon
    end
    if decodedData.wing ~= nil and decodedData.wingSpecified ~= false then
        data.wing = decodedData.wing
    end
    if decodedData.fashionTitle ~= nil and decodedData.fashionTitleSpecified ~= false then
        data.fashionTitle = decodedData.fashionTitle
    end
    if decodedData.fashionCloth ~= nil and decodedData.fashionClothSpecified ~= false then
        data.fashionCloth = decodedData.fashionCloth
    end
    if decodedData.fashionWing ~= nil and decodedData.fashionWingSpecified ~= false then
        data.fashionWing = decodedData.fashionWing
    end
    if decodedData.fashionWeapon ~= nil and decodedData.fashionWeaponSpecified ~= false then
        data.fashionWeapon = decodedData.fashionWeapon
    end
    if decodedData.vipLevel ~= nil and decodedData.vipLevelSpecified ~= false then
        data.vipLevel = decodedData.vipLevel
    end
    if decodedData.activeMonthCard ~= nil and decodedData.activeMonthCardSpecified ~= false then
        data.activeMonthCard = decodedData.activeMonthCard
    end
    if decodedData.treasure ~= nil and decodedData.treasureSpecified ~= false then
        data.treasure = decodedData.treasure
    end
    if decodedData.szSuitId ~= nil and decodedData.szSuitIdSpecified ~= false then
        data.szSuitId = decodedData.szSuitId
    end
    if decodedData.online ~= nil and decodedData.onlineSpecified ~= false then
        data.online = decodedData.online
    end
    if decodedData.joinTime ~= nil and decodedData.joinTimeSpecified ~= false then
        data.joinTime = decodedData.joinTime
    end
    if decodedData.activeToday ~= nil and decodedData.activeTodaySpecified ~= false then
        data.activeToday = decodedData.activeToday
    end
    if decodedData.activeYesterday ~= nil and decodedData.activeYesterdaySpecified ~= false then
        data.activeYesterday = decodedData.activeYesterday
    end
    if decodedData.active3Days ~= nil and decodedData.active3DaysSpecified ~= false then
        data.active3Days = decodedData.active3Days
    end
    if decodedData.active7Days ~= nil and decodedData.active7DaysSpecified ~= false then
        data.active7Days = decodedData.active7Days
    end
    if decodedData.canSendVoice ~= nil and decodedData.canSendVoiceSpecified ~= false then
        data.canSendVoice = decodedData.canSendVoice
    end
    if decodedData.voiceOpen ~= nil and decodedData.voiceOpenSpecified ~= false then
        data.voiceOpen = decodedData.voiceOpen
    end
    if decodedData.speakerOpen ~= nil and decodedData.speakerOpenSpecified ~= false then
        data.speakerOpen = decodedData.speakerOpen
    end
    if decodedData.vipMemberLevel ~= nil and decodedData.vipMemberLevelSpecified ~= false then
        data.vipMemberLevel = decodedData.vipMemberLevel
    end
    return data
end

---@param decodedData unionV2.ApplyListInfo lua中的数据结构
---@return unionV2.ApplyListInfo C#中的数据结构
function unionV2.ApplyListInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ApplyListInfo()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.memberName ~= nil and decodedData.memberNameSpecified ~= false then
        data.memberName = decodedData.memberName
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.memberLevel ~= nil and decodedData.memberLevelSpecified ~= false then
        data.memberLevel = decodedData.memberLevel
    end
    if decodedData.fightValue ~= nil and decodedData.fightValueSpecified ~= false then
        data.fightValue = decodedData.fightValue
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.vipLevel ~= nil and decodedData.vipLevelSpecified ~= false then
        data.vipLevel = decodedData.vipLevel
    end
    if decodedData.monthCard ~= nil and decodedData.monthCardSpecified ~= false then
        data.monthCard = decodedData.monthCard
    end
    if decodedData.theTime ~= nil and decodedData.theTimeSpecified ~= false then
        data.theTime = decodedData.theTime
    end
    if decodedData.hasRefuse ~= nil and decodedData.hasRefuseSpecified ~= false then
        data.hasRefuse = decodedData.hasRefuse
    end
    return data
end

---@param decodedData unionV2.UnionBossInfo lua中的数据结构
---@return unionV2.UnionBossInfo C#中的数据结构
function unionV2.UnionBossInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionBossInfo()
    if decodedData.instanceUniqueId ~= nil and decodedData.instanceUniqueIdSpecified ~= false then
        data.instanceUniqueId = decodedData.instanceUniqueId
    end
    if decodedData.instanceId ~= nil and decodedData.instanceIdSpecified ~= false then
        data.instanceId = decodedData.instanceId
    end
    if decodedData.monsterHp ~= nil and decodedData.monsterHpSpecified ~= false then
        data.monsterHp = decodedData.monsterHp
    end
    if decodedData.ownerId ~= nil and decodedData.ownerIdSpecified ~= false then
        data.ownerId = decodedData.ownerId
    end
    if decodedData.ownerName ~= nil and decodedData.ownerNameSpecified ~= false then
        data.ownerName = decodedData.ownerName
    end
    return data
end

---@param decodedData unionV2.UnionChallengeRank lua中的数据结构
---@return unionV2.UnionChallengeRank C#中的数据结构
function unionV2.UnionChallengeRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionChallengeRank()
    if decodedData.roleName ~= nil and decodedData.roleNameSpecified ~= false then
        data.roleName = decodedData.roleName
    end
    if decodedData.fightValue ~= nil and decodedData.fightValueSpecified ~= false then
        data.fightValue = decodedData.fightValue
    end
    if decodedData.floor ~= nil and decodedData.floorSpecified ~= false then
        data.floor = decodedData.floor
    end
    return data
end

---@param decodedData unionV2.UnionTotemInfo lua中的数据结构
---@return unionV2.UnionTotemInfo C#中的数据结构
function unionV2.UnionTotemInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionTotemInfo()
    if decodedData.group ~= nil and decodedData.groupSpecified ~= false then
        data.group = decodedData.group
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

---@param decodedData unionV2.LingBaoInfo lua中的数据结构
---@return unionV2.LingBaoInfo C#中的数据结构
function unionV2.LingBaoInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.LingBaoInfo()
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.nowExp ~= nil and decodedData.nowExpSpecified ~= false then
        data.nowExp = decodedData.nowExp
    end
    if decodedData.totalExp ~= nil and decodedData.totalExpSpecified ~= false then
        data.totalExp = decodedData.totalExp
    end
    if decodedData.refineLv ~= nil and decodedData.refineLvSpecified ~= false then
        data.refineLv = decodedData.refineLv
    end
    if decodedData.power ~= nil and decodedData.powerSpecified ~= false then
        data.power = decodedData.power
    end
    return data
end

---@param decodedData unionV2.JiPinInfo lua中的数据结构
---@return unionV2.JiPinInfo C#中的数据结构
function unionV2.JiPinInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.JiPinInfo()
    if decodedData.power ~= nil and decodedData.powerSpecified ~= false then
        data.power = decodedData.power
    end
    if decodedData.attributeType ~= nil and decodedData.attributeTypeSpecified ~= false then
        for i = 1, #decodedData.attributeType do
            data.attributeType:Add(decodedData.attributeType[i])
        end
    end
    if decodedData.attributeValue ~= nil and decodedData.attributeValueSpecified ~= false then
        for i = 1, #decodedData.attributeValue do
            data.attributeValue:Add(decodedData.attributeValue[i])
        end
    end
    return data
end

---@param decodedData unionV2.FromInfo lua中的数据结构
---@return unionV2.FromInfo C#中的数据结构
function unionV2.FromInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.FromInfo()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.params ~= nil and decodedData.paramsSpecified ~= false then
        for i = 1, #decodedData.params do
            data.params:Add(decodedData.params[i])
        end
    end
    return data
end

---@param decodedData unionV2.BestAttInfo lua中的数据结构
---@return unionV2.BestAttInfo C#中的数据结构
function unionV2.BestAttInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.BestAttInfo()
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

---@param decodedData unionV2.ItemAttribute lua中的数据结构
---@return unionV2.ItemAttribute C#中的数据结构
function unionV2.ItemAttribute(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ItemAttribute()
    data.type = decodedData.type
    data.num = decodedData.num
    return data
end

---@param decodedData unionV2.CoinInfo lua中的数据结构
---@return unionV2.CoinInfo C#中的数据结构
function unionV2.CoinInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.CoinInfo()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData unionV2.UnionWarehouseUpdateRecordInfo lua中的数据结构
---@return unionV2.UnionWarehouseUpdateRecordInfo C#中的数据结构
function unionV2.UnionWarehouseUpdateRecordInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionWarehouseUpdateRecordInfo()
    if decodedData.roleName ~= nil and decodedData.roleNameSpecified ~= false then
        data.roleName = decodedData.roleName
    end
    if decodedData.operationTime ~= nil and decodedData.operationTimeSpecified ~= false then
        data.operationTime = decodedData.operationTime
    end
    if decodedData.operationType ~= nil and decodedData.operationTypeSpecified ~= false then
        data.operationType = decodedData.operationType
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

---@param decodedData unionV2.ReqApplyForEnterUnion lua中的数据结构
---@return unionV2.ReqApplyForEnterUnion C#中的数据结构
function unionV2.ReqApplyForEnterUnion(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqApplyForEnterUnion()
    data.unionId = decodedData.unionId
    return data
end

---@param decodedData unionV2.ReqCreateUnion lua中的数据结构
---@return unionV2.ReqCreateUnion C#中的数据结构
function unionV2.ReqCreateUnion(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqCreateUnion()
    data.name = decodedData.name
    data.unionIcon = decodedData.unionIcon
    return data
end

---@param decodedData unionV2.ResSendCreateUnionSuccess lua中的数据结构
---@return unionV2.ResSendCreateUnionSuccess C#中的数据结构
function unionV2.ResSendCreateUnionSuccess(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResSendCreateUnionSuccess()
    data.name = decodedData.name
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    return data
end

---@param decodedData unionV2.ElectionInfo lua中的数据结构
---@return unionV2.ElectionInfo C#中的数据结构
function unionV2.ElectionInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ElectionInfo()
    data.member = unionV2.UnionMemberInfo(decodedData.member)
    data.votes = decodedData.votes
    return data
end

---@param decodedData unionV2.ResSendPlayerUnionInfo lua中的数据结构
---@return unionV2.ResSendPlayerUnionInfo C#中的数据结构
function unionV2.ResSendPlayerUnionInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResSendPlayerUnionInfo()
    if decodedData.unionInfo ~= nil and decodedData.unionInfoSpecified ~= false then
        data.unionInfo = unionV2.UnionInfo(decodedData.unionInfo)
    end
    if decodedData.unionScore ~= nil and decodedData.unionScoreSpecified ~= false then
        data.unionScore = decodedData.unionScore
    end
    if decodedData.positionInfo ~= nil and decodedData.positionInfoSpecified ~= false then
        data.positionInfo = CS.unionV2.PositionInfo.__CastFrom(decodedData.positionInfo)
    end
    if decodedData.memberInfo ~= nil and decodedData.memberInfoSpecified ~= false then
        for i = 1, #decodedData.memberInfo do
            data.memberInfo:Add(unionV2.UnionMemberInfo(decodedData.memberInfo[i]))
        end
    end
    if decodedData.unionSetting ~= nil and decodedData.unionSettingSpecified ~= false then
        for i = 1, #decodedData.unionSetting do
            data.unionSetting:Add(unionV2.UnionSettingInfo(decodedData.unionSetting[i]))
        end
    end
    if decodedData.unionEventBean ~= nil and decodedData.unionEventBeanSpecified ~= false then
        for i = 1, #decodedData.unionEventBean do
            data.unionEventBean:Add(unionV2.UnionEventInfo(decodedData.unionEventBean[i]))
        end
    end
    if decodedData.myPositionInfo ~= nil and decodedData.myPositionInfoSpecified ~= false then
        data.myPositionInfo = decodedData.myPositionInfo
    end
    if decodedData.leaderId ~= nil and decodedData.leaderIdSpecified ~= false then
        data.leaderId = decodedData.leaderId
    end
    if decodedData.isInElection ~= nil and decodedData.isInElectionSpecified ~= false then
        data.isInElection = decodedData.isInElection
    end
    if decodedData.electionEndTime ~= nil and decodedData.electionEndTimeSpecified ~= false then
        data.electionEndTime = decodedData.electionEndTime
    end
    if decodedData.election ~= nil and decodedData.electionSpecified ~= false then
        for i = 1, #decodedData.election do
            data.election:Add(unionV2.ElectionInfo(decodedData.election[i]))
        end
    end
    if decodedData.myYesterdayTax ~= nil and decodedData.myYesterdayTaxSpecified ~= false then
        data.myYesterdayTax = decodedData.myYesterdayTax
    end
    if decodedData.totalActiveToday ~= nil and decodedData.totalActiveTodaySpecified ~= false then
        data.totalActiveToday = decodedData.totalActiveToday
    end
    if decodedData.totalActiveYesterday ~= nil and decodedData.totalActiveYesterdaySpecified ~= false then
        data.totalActiveYesterday = decodedData.totalActiveYesterday
    end
    if decodedData.myTaxSalaryGet ~= nil and decodedData.myTaxSalaryGetSpecified ~= false then
        data.myTaxSalaryGet = decodedData.myTaxSalaryGet
    end
    if decodedData.activeGetCountToday ~= nil and decodedData.activeGetCountTodaySpecified ~= false then
        for i = 1, #decodedData.activeGetCountToday do
            data.activeGetCountToday:Add(decodedData.activeGetCountToday[i])
        end
    end
    if decodedData.realTimeTax ~= nil and decodedData.realTimeTaxSpecified ~= false then
        data.realTimeTax = decodedData.realTimeTax
    end
    if decodedData.todayKickOutCount ~= nil and decodedData.todayKickOutCountSpecified ~= false then
        data.todayKickOutCount = decodedData.todayKickOutCount
    end
    if decodedData.activeRewardGet ~= nil and decodedData.activeRewardGetSpecified ~= false then
        data.activeRewardGet = decodedData.activeRewardGet
    end
    return data
end

---@param decodedData unionV2.ActiveRewardGet lua中的数据结构
---@return unionV2.ActiveRewardGet C#中的数据结构
function unionV2.ActiveRewardGet(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ActiveRewardGet()
    if decodedData.activeId ~= nil and decodedData.activeIdSpecified ~= false then
        data.activeId = decodedData.activeId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.maxCount ~= nil and decodedData.maxCountSpecified ~= false then
        data.maxCount = decodedData.maxCount
    end
    return data
end

---@param decodedData unionV2.ReqElectionVote lua中的数据结构
---@return unionV2.ReqElectionVote C#中的数据结构
function unionV2.ReqElectionVote(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqElectionVote()
    data.roleId = decodedData.roleId
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData unionV2.ReqChangeAnnouncement lua中的数据结构
---@return unionV2.ReqChangeAnnouncement C#中的数据结构
function unionV2.ReqChangeAnnouncement(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqChangeAnnouncement()
    if decodedData.announcement ~= nil and decodedData.announcementSpecified ~= false then
        data.announcement = decodedData.announcement
    end
    return data
end

---@param decodedData unionV2.ReqKickOutMember lua中的数据结构
---@return unionV2.ReqKickOutMember C#中的数据结构
function unionV2.ReqKickOutMember(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqKickOutMember()
    if decodedData.memberId ~= nil and decodedData.memberIdSpecified ~= false then
        data.memberId = decodedData.memberId
    end
    return data
end

---@param decodedData unionV2.ReqChangePosition lua中的数据结构
---@return unionV2.ReqChangePosition C#中的数据结构
function unionV2.ReqChangePosition(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqChangePosition()
    if decodedData.memberId ~= nil and decodedData.memberIdSpecified ~= false then
        data.memberId = decodedData.memberId
    end
    if decodedData.position ~= nil and decodedData.positionSpecified ~= false then
        data.position = decodedData.position
    end
    return data
end

---@param decodedData unionV2.ResSendApplyListInfo lua中的数据结构
---@return unionV2.ResSendApplyListInfo C#中的数据结构
function unionV2.ResSendApplyListInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResSendApplyListInfo()
    if decodedData.applyInfo ~= nil and decodedData.applyInfoSpecified ~= false then
        for i = 1, #decodedData.applyInfo do
            data.applyInfo:Add(unionV2.ApplyListInfo(decodedData.applyInfo[i]))
        end
    end
    data.automaticPassing = decodedData.automaticPassing
    return data
end

---@param decodedData unionV2.ResSendChangeAnnounce lua中的数据结构
---@return unionV2.ResSendChangeAnnounce C#中的数据结构
function unionV2.ResSendChangeAnnounce(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResSendChangeAnnounce()
    if decodedData.announce ~= nil and decodedData.announceSpecified ~= false then
        data.announce = decodedData.announce
    end
    return data
end

---@param decodedData unionV2.ResSendChangePosition lua中的数据结构
---@return unionV2.ResSendChangePosition C#中的数据结构
function unionV2.ResSendChangePosition(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResSendChangePosition()
    if decodedData.changePosition ~= nil and decodedData.changePositionSpecified ~= false then
        data.changePosition = unionV2.UnionMemberInfo(decodedData.changePosition)
    end
    if decodedData.leaderChange ~= nil and decodedData.leaderChangeSpecified ~= false then
        data.leaderChange = unionV2.UnionMemberInfo(decodedData.leaderChange)
    end
    if decodedData.position ~= nil and decodedData.positionSpecified ~= false then
        data.position = CS.unionV2.PositionInfo.__CastFrom(decodedData.position)
    end
    return data
end

---@param decodedData unionV2.ReqCheckApplyList lua中的数据结构
---@return unionV2.ReqCheckApplyList C#中的数据结构
function unionV2.ReqCheckApplyList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqCheckApplyList()
    data.roleId = decodedData.roleId
    data.applyRoleId = decodedData.applyRoleId
    if decodedData.checkState ~= nil and decodedData.checkStateSpecified ~= false then
        data.checkState = decodedData.checkState
    end
    return data
end

---@param decodedData unionV2.ResSendUnionActiveInfo lua中的数据结构
---@return unionV2.ResSendUnionActiveInfo C#中的数据结构
function unionV2.ResSendUnionActiveInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResSendUnionActiveInfo()
    if decodedData.activePoint ~= nil and decodedData.activePointSpecified ~= false then
        data.activePoint = decodedData.activePoint
    end
    if decodedData.activeId ~= nil and decodedData.activeIdSpecified ~= false then
        for i = 1, #decodedData.activeId do
            data.activeId:Add(decodedData.activeId[i])
        end
    end
    return data
end

---@param decodedData unionV2.ReqGetUnionActiveReward lua中的数据结构
---@return unionV2.ReqGetUnionActiveReward C#中的数据结构
function unionV2.ReqGetUnionActiveReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqGetUnionActiveReward()
    if decodedData.activeId ~= nil and decodedData.activeIdSpecified ~= false then
        data.activeId = decodedData.activeId
    end
    return data
end

---@param decodedData unionV2.ReqUnionSetUp lua中的数据结构
---@return unionV2.ReqUnionSetUp C#中的数据结构
function unionV2.ReqUnionSetUp(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqUnionSetUp()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.setValue ~= nil and decodedData.setValueSpecified ~= false then
        data.setValue = decodedData.setValue
    end
    if decodedData.extraParam ~= nil and decodedData.extraParamSpecified ~= false then
        data.extraParam = decodedData.extraParam
    end
    return data
end

---@param decodedData unionV2.ResSendUnionSetUp lua中的数据结构
---@return unionV2.ResSendUnionSetUp C#中的数据结构
function unionV2.ResSendUnionSetUp(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResSendUnionSetUp()
    if decodedData.settingState ~= nil and decodedData.settingStateSpecified ~= false then
        data.settingState = unionV2.UnionSettingInfo(decodedData.settingState)
    end
    return data
end

---@param decodedData unionV2.ResHasRewardInfo lua中的数据结构
---@return unionV2.ResHasRewardInfo C#中的数据结构
function unionV2.ResHasRewardInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResHasRewardInfo()
    if decodedData.reward ~= nil and decodedData.rewardSpecified ~= false then
        data.reward = decodedData.reward
    end
    return data
end

---@param decodedData unionV2.ResHasApplyInfo lua中的数据结构
---@return unionV2.ResHasApplyInfo C#中的数据结构
function unionV2.ResHasApplyInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResHasApplyInfo()
    if decodedData.apply ~= nil and decodedData.applySpecified ~= false then
        data.apply = decodedData.apply
    end
    return data
end

---@param decodedData unionV2.ResSendUnionBossInfo lua中的数据结构
---@return unionV2.ResSendUnionBossInfo C#中的数据结构
function unionV2.ResSendUnionBossInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResSendUnionBossInfo()
    if decodedData.bossInfo ~= nil and decodedData.bossInfoSpecified ~= false then
        for i = 1, #decodedData.bossInfo do
            data.bossInfo:Add(unionV2.UnionBossInfo(decodedData.bossInfo[i]))
        end
    end
    if decodedData.callNum ~= nil and decodedData.callNumSpecified ~= false then
        data.callNum = decodedData.callNum
    end
    if decodedData.aidNum ~= nil and decodedData.aidNumSpecified ~= false then
        data.aidNum = decodedData.aidNum
    end
    return data
end

---@param decodedData unionV2.ResSendUnionPersonChallengetInfo lua中的数据结构
---@return unionV2.ResSendUnionPersonChallengetInfo C#中的数据结构
function unionV2.ResSendUnionPersonChallengetInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResSendUnionPersonChallengetInfo()
    if decodedData.currentMonsterWeaken ~= nil and decodedData.currentMonsterWeakenSpecified ~= false then
        data.currentMonsterWeaken = decodedData.currentMonsterWeaken
    end
    if decodedData.currentFloor ~= nil and decodedData.currentFloorSpecified ~= false then
        data.currentFloor = decodedData.currentFloor
    end
    if decodedData.instanceId ~= nil and decodedData.instanceIdSpecified ~= false then
        data.instanceId = decodedData.instanceId
    end
    if decodedData.firstSuccess ~= nil and decodedData.firstSuccessSpecified ~= false then
        data.firstSuccess = decodedData.firstSuccess
    end
    if decodedData.lifeMaxInstanceId ~= nil and decodedData.lifeMaxInstanceIdSpecified ~= false then
        data.lifeMaxInstanceId = decodedData.lifeMaxInstanceId
    end
    if decodedData.firstRewardInstanceId ~= nil and decodedData.firstRewardInstanceIdSpecified ~= false then
        data.firstRewardInstanceId = decodedData.firstRewardInstanceId
    end
    if decodedData.resetCount ~= nil and decodedData.resetCountSpecified ~= false then
        data.resetCount = decodedData.resetCount
    end
    if decodedData.challengeBarrier ~= nil and decodedData.challengeBarrierSpecified ~= false then
        data.challengeBarrier = decodedData.challengeBarrier
    end
    return data
end

---@param decodedData unionV2.ResUnionChallengeNextInstance lua中的数据结构
---@return unionV2.ResUnionChallengeNextInstance C#中的数据结构
function unionV2.ResUnionChallengeNextInstance(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResUnionChallengeNextInstance()
    if decodedData.nextInstanceId ~= nil and decodedData.nextInstanceIdSpecified ~= false then
        data.nextInstanceId = decodedData.nextInstanceId
    end
    return data
end

---@param decodedData unionV2.ResSendUnionChallengetRank lua中的数据结构
---@return unionV2.ResSendUnionChallengetRank C#中的数据结构
function unionV2.ResSendUnionChallengetRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResSendUnionChallengetRank()
    if decodedData.rankInfo ~= nil and decodedData.rankInfoSpecified ~= false then
        for i = 1, #decodedData.rankInfo do
            data.rankInfo:Add(unionV2.UnionChallengeRank(decodedData.rankInfo[i]))
        end
    end
    if decodedData.myRank ~= nil and decodedData.myRankSpecified ~= false then
        data.myRank = decodedData.myRank
    end
    return data
end

---@param decodedData unionV2.ResUnionInstanceOwner lua中的数据结构
---@return unionV2.ResUnionInstanceOwner C#中的数据结构
function unionV2.ResUnionInstanceOwner(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResUnionInstanceOwner()
    if decodedData.ownerId ~= nil and decodedData.ownerIdSpecified ~= false then
        data.ownerId = decodedData.ownerId
    end
    return data
end

---@param decodedData unionV2.ReqSendUnionRedPack lua中的数据结构
---@return unionV2.ReqSendUnionRedPack C#中的数据结构
function unionV2.ReqSendUnionRedPack(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqSendUnionRedPack()
    if decodedData.money ~= nil and decodedData.moneySpecified ~= false then
        data.money = decodedData.money
    end
    if decodedData.content ~= nil and decodedData.contentSpecified ~= false then
        data.content = decodedData.content
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData unionV2.ReqRobRedPack lua中的数据结构
---@return unionV2.ReqRobRedPack C#中的数据结构
function unionV2.ReqRobRedPack(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqRobRedPack()
    if decodedData.redPackId ~= nil and decodedData.redPackIdSpecified ~= false then
        data.redPackId = decodedData.redPackId
    end
    return data
end

---@param decodedData unionV2.ResRobRedPack lua中的数据结构
---@return unionV2.ResRobRedPack C#中的数据结构
function unionV2.ResRobRedPack(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResRobRedPack()
    if decodedData.sender ~= nil and decodedData.senderSpecified ~= false then
        data.sender = decodedData.sender
    end
    if decodedData.senderCareer ~= nil and decodedData.senderCareerSpecified ~= false then
        data.senderCareer = decodedData.senderCareer
    end
    if decodedData.sendSex ~= nil and decodedData.sendSexSpecified ~= false then
        data.sendSex = decodedData.sendSex
    end
    if decodedData.money ~= nil and decodedData.moneySpecified ~= false then
        data.money = decodedData.money
    end
    if decodedData.getCount ~= nil and decodedData.getCountSpecified ~= false then
        data.getCount = decodedData.getCount
    end
    if decodedData.maxCount ~= nil and decodedData.maxCountSpecified ~= false then
        data.maxCount = decodedData.maxCount
    end
    if decodedData.getMoney ~= nil and decodedData.getMoneySpecified ~= false then
        data.getMoney = decodedData.getMoney
    end
    if decodedData.maxMoney ~= nil and decodedData.maxMoneySpecified ~= false then
        data.maxMoney = decodedData.maxMoney
    end
    if decodedData.content ~= nil and decodedData.contentSpecified ~= false then
        data.content = decodedData.content
    end
    if decodedData.yuanbao ~= nil and decodedData.yuanbaoSpecified ~= false then
        data.yuanbao = unionV2.UnionRedPackRecordInfo(decodedData.yuanbao)
    end
    return data
end

---@param decodedData unionV2.ResOpenRedPackPanel lua中的数据结构
---@return unionV2.ResOpenRedPackPanel C#中的数据结构
function unionV2.ResOpenRedPackPanel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResOpenRedPackPanel()
    if decodedData.todayCount ~= nil and decodedData.todayCountSpecified ~= false then
        data.todayCount = decodedData.todayCount
    end
    if decodedData.todayMoney ~= nil and decodedData.todayMoneySpecified ~= false then
        data.todayMoney = decodedData.todayMoney
    end
    if decodedData.redPackList ~= nil and decodedData.redPackListSpecified ~= false then
        for i = 1, #decodedData.redPackList do
            data.redPackList:Add(unionV2.UnionRedPackInfo(decodedData.redPackList[i]))
        end
    end
    if decodedData.redPackRecordList ~= nil and decodedData.redPackRecordListSpecified ~= false then
        for i = 1, #decodedData.redPackRecordList do
            data.redPackRecordList:Add(unionV2.UnionRedPackRecordInfo(decodedData.redPackRecordList[i]))
        end
    end
    return data
end

---@param decodedData unionV2.ReqRedPackDetail lua中的数据结构
---@return unionV2.ReqRedPackDetail C#中的数据结构
function unionV2.ReqRedPackDetail(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqRedPackDetail()
    if decodedData.redPackId ~= nil and decodedData.redPackIdSpecified ~= false then
        data.redPackId = decodedData.redPackId
    end
    return data
end

---@param decodedData unionV2.ResCanGetCrossReward lua中的数据结构
---@return unionV2.ResCanGetCrossReward C#中的数据结构
function unionV2.ResCanGetCrossReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResCanGetCrossReward()
    if decodedData.floorId ~= nil and decodedData.floorIdSpecified ~= false then
        data.floorId = decodedData.floorId
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData unionV2.ReqCallUnionBoss lua中的数据结构
---@return unionV2.ReqCallUnionBoss C#中的数据结构
function unionV2.ReqCallUnionBoss(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqCallUnionBoss()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

---@param decodedData unionV2.ReqEnterUnionBoss lua中的数据结构
---@return unionV2.ReqEnterUnionBoss C#中的数据结构
function unionV2.ReqEnterUnionBoss(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqEnterUnionBoss()
    if decodedData.line ~= nil and decodedData.lineSpecified ~= false then
        data.line = decodedData.line
    end
    return data
end

---@param decodedData unionV2.ResUnionRedPackInfo lua中的数据结构
---@return unionV2.ResUnionRedPackInfo C#中的数据结构
function unionV2.ResUnionRedPackInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResUnionRedPackInfo()
    if decodedData.redPackInfo ~= nil and decodedData.redPackInfoSpecified ~= false then
        data.redPackInfo = unionV2.UnionRedPackInfo(decodedData.redPackInfo)
    end
    return data
end

---@param decodedData unionV2.ReqImpeachLeader lua中的数据结构
---@return unionV2.ReqImpeachLeader C#中的数据结构
function unionV2.ReqImpeachLeader(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqImpeachLeader()
    data.leaderId = decodedData.leaderId
    return data
end

---@param decodedData unionV2.ReqChangeUnionName lua中的数据结构
---@return unionV2.ReqChangeUnionName C#中的数据结构
function unionV2.ReqChangeUnionName(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqChangeUnionName()
    if decodedData.newUnionName ~= nil and decodedData.newUnionNameSpecified ~= false then
        data.newUnionName = decodedData.newUnionName
    end
    return data
end

---@param decodedData unionV2.ResSendUnionAnnounceResult lua中的数据结构
---@return unionV2.ResSendUnionAnnounceResult C#中的数据结构
function unionV2.ResSendUnionAnnounceResult(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResSendUnionAnnounceResult()
    if decodedData.callName ~= nil and decodedData.callNameSpecified ~= false then
        data.callName = decodedData.callName
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.line ~= nil and decodedData.lineSpecified ~= false then
        data.line = decodedData.line
    end
    return data
end

---@param decodedData unionV2.ResTotemInfo lua中的数据结构
---@return unionV2.ResTotemInfo C#中的数据结构
function unionV2.ResTotemInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResTotemInfo()
    if decodedData.roleTotemList ~= nil and decodedData.roleTotemListSpecified ~= false then
        for i = 1, #decodedData.roleTotemList do
            data.roleTotemList:Add(unionV2.UnionTotemInfo(decodedData.roleTotemList[i]))
        end
    end
    return data
end

---@param decodedData unionV2.ReqLevelUpUnionTotem lua中的数据结构
---@return unionV2.ReqLevelUpUnionTotem C#中的数据结构
function unionV2.ReqLevelUpUnionTotem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqLevelUpUnionTotem()
    if decodedData.group ~= nil and decodedData.groupSpecified ~= false then
        data.group = decodedData.group
    end
    return data
end

---@param decodedData unionV2.ResLevelUpUnionTotem lua中的数据结构
---@return unionV2.ResLevelUpUnionTotem C#中的数据结构
function unionV2.ResLevelUpUnionTotem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResLevelUpUnionTotem()
    if decodedData.totem ~= nil and decodedData.totemSpecified ~= false then
        data.totem = unionV2.UnionTotemInfo(decodedData.totem)
    end
    return data
end

---@param decodedData unionV2.ReqInviteForEnterUnion lua中的数据结构
---@return unionV2.ReqInviteForEnterUnion C#中的数据结构
function unionV2.ReqInviteForEnterUnion(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqInviteForEnterUnion()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    return data
end

---@param decodedData unionV2.ResInviteForEnterUnion lua中的数据结构
---@return unionV2.ResInviteForEnterUnion C#中的数据结构
function unionV2.ResInviteForEnterUnion(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResInviteForEnterUnion()
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.inviterName ~= nil and decodedData.inviterNameSpecified ~= false then
        data.inviterName = decodedData.inviterName
    end
    return data
end

---@param decodedData unionV2.ReqAgreeUnionInvite lua中的数据结构
---@return unionV2.ReqAgreeUnionInvite C#中的数据结构
function unionV2.ReqAgreeUnionInvite(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqAgreeUnionInvite()
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    return data
end

---@param decodedData unionV2.ResUnionWarehouseInfo lua中的数据结构
---@return unionV2.ResUnionWarehouseInfo C#中的数据结构
function unionV2.ResUnionWarehouseInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResUnionWarehouseInfo()
    if decodedData.maxEquipGridCount ~= nil and decodedData.maxEquipGridCountSpecified ~= false then
        data.maxEquipGridCount = decodedData.maxEquipGridCount
    end
    if decodedData.itemAllInfo ~= nil and decodedData.itemAllInfoSpecified ~= false then
        for i = 1, #decodedData.itemAllInfo do
            data.itemAllInfo:Add(unionV2.OneItemAllInfo(decodedData.itemAllInfo[i]))
        end
    end
    if decodedData.equipLimit ~= nil and decodedData.equipLimitSpecified ~= false then
        data.equipLimit = decodedData.equipLimit
    end
    if decodedData.unionScore ~= nil and decodedData.unionScoreSpecified ~= false then
        data.unionScore = decodedData.unionScore
    end
    return data
end

---@param decodedData unionV2.OneItemAllInfo lua中的数据结构
---@return unionV2.OneItemAllInfo C#中的数据结构
function unionV2.OneItemAllInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.OneItemAllInfo()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.itemCount ~= nil and decodedData.itemCountSpecified ~= false then
        data.itemCount = decodedData.itemCount
    end
    if decodedData.needMoney ~= nil and decodedData.needMoneySpecified ~= false then
        data.needMoney = decodedData.needMoney
    end
    return data
end

---@param decodedData unionV2.ReqGetBagItemInfo lua中的数据结构
---@return unionV2.ReqGetBagItemInfo C#中的数据结构
function unionV2.ReqGetBagItemInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqGetBagItemInfo()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

---@param decodedData unionV2.ResGetBagItemInfo lua中的数据结构
---@return unionV2.ResGetBagItemInfo C#中的数据结构
function unionV2.ResGetBagItemInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResGetBagItemInfo()
    if decodedData.itemList ~= nil and decodedData.itemListSpecified ~= false then
        for i = 1, #decodedData.itemList do
            data.itemList:Add(decodeTable.bag.BagItemInfo(decodedData.itemList[i]))
        end
    end
    return data
end

---@param decodedData unionV2.ReqDonateEquip lua中的数据结构
---@return unionV2.ReqDonateEquip C#中的数据结构
function unionV2.ReqDonateEquip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqDonateEquip()
    if decodedData.EquipmentId ~= nil and decodedData.EquipmentIdSpecified ~= false then
        data.EquipmentId = decodedData.EquipmentId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData unionV2.ReqConversionEquip lua中的数据结构
---@return unionV2.ReqConversionEquip C#中的数据结构
function unionV2.ReqConversionEquip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqConversionEquip()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.EquipLid ~= nil and decodedData.EquipLidSpecified ~= false then
        for i = 1, #decodedData.EquipLid do
            data.EquipLid:Add(decodedData.EquipLid[i])
        end
    end
    return data
end

---@param decodedData unionV2.ReqDestoryEquip lua中的数据结构
---@return unionV2.ReqDestoryEquip C#中的数据结构
function unionV2.ReqDestoryEquip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqDestoryEquip()
    if decodedData.EquipLid ~= nil and decodedData.EquipLidSpecified ~= false then
        data.EquipLid = decodedData.EquipLid
    end
    return data
end

---@param decodedData unionV2.ResIntegral lua中的数据结构
---@return unionV2.ResIntegral C#中的数据结构
function unionV2.ResIntegral(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResIntegral()
    if decodedData.integralInfo ~= nil and decodedData.integralInfoSpecified ~= false then
        for i = 1, #decodedData.integralInfo do
            data.integralInfo:Add(unionV2.UnionWarehouseUpdateRecordInfo(decodedData.integralInfo[i]))
        end
    end
    return data
end

---@param decodedData unionV2.ReqGetPlayerUnionInfo lua中的数据结构
---@return unionV2.ReqGetPlayerUnionInfo C#中的数据结构
function unionV2.ReqGetPlayerUnionInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqGetPlayerUnionInfo()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        for i = 1, #decodedData.roleId do
            data.roleId:Add(decodedData.roleId[i])
        end
    end
    return data
end

---@param decodedData unionV2.ReqGetApplyListInfo lua中的数据结构
---@return unionV2.ReqGetApplyListInfo C#中的数据结构
function unionV2.ReqGetApplyListInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqGetApplyListInfo()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        for i = 1, #decodedData.roleId do
            data.roleId:Add(decodedData.roleId[i])
        end
    end
    return data
end

---@param decodedData unionV2.ResDonateMoney lua中的数据结构
---@return unionV2.ResDonateMoney C#中的数据结构
function unionV2.ResDonateMoney(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResDonateMoney()
    data.contributionHistory = decodedData.contributionHistory
    return data
end

---@param decodedData unionV2.ReqDonateMoney lua中的数据结构
---@return unionV2.ReqDonateMoney C#中的数据结构
function unionV2.ReqDonateMoney(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqDonateMoney()
    data.money = decodedData.money
    return data
end

---@param decodedData unionV2.ResUnionUpGrade lua中的数据结构
---@return unionV2.ResUnionUpGrade C#中的数据结构
function unionV2.ResUnionUpGrade(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResUnionUpGrade()
    data.leve = decodedData.leve
    data.unionGold = decodedData.unionGold
    return data
end

---@param decodedData unionV2.ReqQuitOrDissolveUnion lua中的数据结构
---@return unionV2.ReqQuitOrDissolveUnion C#中的数据结构
function unionV2.ReqQuitOrDissolveUnion(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqQuitOrDissolveUnion()
    data.roleId = decodedData.roleId
    if decodedData.quitType ~= nil and decodedData.quitTypeSpecified ~= false then
        data.quitType = decodedData.quitType
    end
    return data
end

---@param decodedData unionV2.ResSendQuitUnionSuccess lua中的数据结构
---@return unionV2.ResSendQuitUnionSuccess C#中的数据结构
function unionV2.ResSendQuitUnionSuccess(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResSendQuitUnionSuccess()
    data.roleId = decodedData.roleId
    data.unionId = decodedData.unionId
    data.unionName = decodedData.unionName
    data.contributionHistory = decodedData.contributionHistory
    data.quitUnionTime = decodedData.quitUnionTime
    return data
end

---@param decodedData unionV2.ResDissolveUnion lua中的数据结构
---@return unionV2.ResDissolveUnion C#中的数据结构
function unionV2.ResDissolveUnion(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResDissolveUnion()
    data.roleId = decodedData.roleId
    data.unionId = decodedData.unionId
    data.unionName = decodedData.unionName
    data.contributionHistory = decodedData.contributionHistory
    data.quitUnionTime = decodedData.quitUnionTime
    return data
end

---@param decodedData unionV2.ReqGetAssistantOnlineUnionInfo lua中的数据结构
---@return unionV2.ReqGetAssistantOnlineUnionInfo C#中的数据结构
function unionV2.ReqGetAssistantOnlineUnionInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqGetAssistantOnlineUnionInfo()
    data.roleId = decodedData.roleId
    return data
end

---@param decodedData unionV2.ReqUnionMemberInfo lua中的数据结构
---@return unionV2.ReqUnionMemberInfo C#中的数据结构
function unionV2.ReqUnionMemberInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqUnionMemberInfo()
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    return data
end

---@param decodedData unionV2.ResUnionMemberInfo lua中的数据结构
---@return unionV2.ResUnionMemberInfo C#中的数据结构
function unionV2.ResUnionMemberInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResUnionMemberInfo()
    if decodedData.memberInfo ~= nil and decodedData.memberInfoSpecified ~= false then
        for i = 1, #decodedData.memberInfo do
            data.memberInfo:Add(unionV2.UnionMemberInfo(decodedData.memberInfo[i]))
        end
    end
    return data
end

---@param decodedData unionV2.ReqIgnoreAllRole lua中的数据结构
---@return unionV2.ReqIgnoreAllRole C#中的数据结构
function unionV2.ReqIgnoreAllRole(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqIgnoreAllRole()
    data.unionId = decodedData.unionId
    return data
end

---@param decodedData unionV2.ReqAgreeAllRoleJoinUnion lua中的数据结构
---@return unionV2.ReqAgreeAllRoleJoinUnion C#中的数据结构
function unionV2.ReqAgreeAllRoleJoinUnion(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqAgreeAllRoleJoinUnion()
    data.unionId = decodedData.unionId
    return data
end

---@param decodedData unionV2.blackApplyInfo lua中的数据结构
---@return unionV2.blackApplyInfo C#中的数据结构
function unionV2.blackApplyInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.blackApplyInfo()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.roleName ~= nil and decodedData.roleNameSpecified ~= false then
        data.roleName = decodedData.roleName
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    return data
end

---@param decodedData unionV2.ReqGetBlackApplyRole lua中的数据结构
---@return unionV2.ReqGetBlackApplyRole C#中的数据结构
function unionV2.ReqGetBlackApplyRole(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqGetBlackApplyRole()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    return data
end

---@param decodedData unionV2.ResGetBlackApplyRole lua中的数据结构
---@return unionV2.ResGetBlackApplyRole C#中的数据结构
function unionV2.ResGetBlackApplyRole(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResGetBlackApplyRole()
    if decodedData.blackApplyRole ~= nil and decodedData.blackApplyRoleSpecified ~= false then
        for i = 1, #decodedData.blackApplyRole do
            data.blackApplyRole:Add(unionV2.blackApplyInfo(decodedData.blackApplyRole[i]))
        end
    end
    return data
end

---@param decodedData unionV2.ReqRemoveBlackApplyRole lua中的数据结构
---@return unionV2.ReqRemoveBlackApplyRole C#中的数据结构
function unionV2.ReqRemoveBlackApplyRole(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqRemoveBlackApplyRole()
    data.removeRoleId = decodedData.removeRoleId
    return data
end

---@param decodedData unionV2.ReqGetOnlineMember lua中的数据结构
---@return unionV2.ReqGetOnlineMember C#中的数据结构
function unionV2.ReqGetOnlineMember(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqGetOnlineMember()
    data.roleId = decodedData.roleId
    return data
end

---@param decodedData unionV2.ReqKickOutGuild lua中的数据结构
---@return unionV2.ReqKickOutGuild C#中的数据结构
function unionV2.ReqKickOutGuild(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqKickOutGuild()
    data.kickRoleId = decodedData.kickRoleId
    return data
end

---@param decodedData unionV2.ResKickOutGuild lua中的数据结构
---@return unionV2.ResKickOutGuild C#中的数据结构
function unionV2.ResKickOutGuild(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResKickOutGuild()
    data.unionId = decodedData.unionId
    data.unionName = decodedData.unionName
    return data
end

---@param decodedData unionV2.ReqImpeachmentInfo lua中的数据结构
---@return unionV2.ReqImpeachmentInfo C#中的数据结构
function unionV2.ReqImpeachmentInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqImpeachmentInfo()
    data.isAgree = decodedData.isAgree
    return data
end

---@param decodedData unionV2.ReqImpeachmentVote lua中的数据结构
---@return unionV2.ReqImpeachmentVote C#中的数据结构
function unionV2.ReqImpeachmentVote(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqImpeachmentVote()
    data.isAgree = decodedData.isAgree
    return data
end

---@param decodedData unionV2.ResImpeachmentVote lua中的数据结构
---@return unionV2.ResImpeachmentVote C#中的数据结构
function unionV2.ResImpeachmentVote(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResImpeachmentVote()
    data.agreeSum = decodedData.agreeSum
    data.disagreeSum = decodedData.disagreeSum
    data.myVote = decodedData.myVote
    return data
end

---@param decodedData unionV2.ReqGetUnionItems lua中的数据结构
---@return unionV2.ReqGetUnionItems C#中的数据结构
function unionV2.ReqGetUnionItems(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqGetUnionItems()
    data.unionId = decodedData.unionId
    return data
end

---@param decodedData unionV2.ReqAutomaticPassing lua中的数据结构
---@return unionV2.ReqAutomaticPassing C#中的数据结构
function unionV2.ReqAutomaticPassing(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqAutomaticPassing()
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    data.automaticPassing = decodedData.automaticPassing
    return data
end

---@param decodedData unionV2.ResTheUnionChange lua中的数据结构
---@return unionV2.ResTheUnionChange C#中的数据结构
function unionV2.ResTheUnionChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResTheUnionChange()
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    return data
end

---@param decodedData unionV2.ResUnionNameChange lua中的数据结构
---@return unionV2.ResUnionNameChange C#中的数据结构
function unionV2.ResUnionNameChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResUnionNameChange()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.unionIconId ~= nil and decodedData.unionIconIdSpecified ~= false then
        data.unionIconId = decodedData.unionIconId
    end
    if decodedData.unionPos ~= nil and decodedData.unionPosSpecified ~= false then
        data.unionPos = decodedData.unionPos
    end
    if decodedData.unionRank ~= nil and decodedData.unionRankSpecified ~= false then
        data.unionRank = decodedData.unionRank
    end
    return data
end

---@param decodedData unionV2.ReqAssignmentMonster lua中的数据结构
---@return unionV2.ReqAssignmentMonster C#中的数据结构
function unionV2.ReqAssignmentMonster(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqAssignmentMonster()
    if decodedData.newMonsterId ~= nil and decodedData.newMonsterIdSpecified ~= false then
        data.newMonsterId = decodedData.newMonsterId
    end
    if decodedData.position ~= nil and decodedData.positionSpecified ~= false then
        data.position = decodedData.position
    end
    return data
end

---@param decodedData unionV2.GetAssignment lua中的数据结构
---@return unionV2.GetAssignment C#中的数据结构
function unionV2.GetAssignment(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.GetAssignment()
    if decodedData.oldMonsterId ~= nil and decodedData.oldMonsterIdSpecified ~= false then
        data.oldMonsterId = decodedData.oldMonsterId
    end
    if decodedData.position ~= nil and decodedData.positionSpecified ~= false then
        data.position = decodedData.position
    end
    if decodedData.oldMonsterName ~= nil and decodedData.oldMonsterNameSpecified ~= false then
        data.oldMonsterName = decodedData.oldMonsterName
    end
    return data
end

---@param decodedData unionV2.YesGetUnionMonster lua中的数据结构
---@return unionV2.YesGetUnionMonster C#中的数据结构
function unionV2.YesGetUnionMonster(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.YesGetUnionMonster()
    if decodedData.oldMonsterId ~= nil and decodedData.oldMonsterIdSpecified ~= false then
        data.oldMonsterId = decodedData.oldMonsterId
    end
    if decodedData.position ~= nil and decodedData.positionSpecified ~= false then
        data.position = decodedData.position
    end
    if decodedData.newMonsterId ~= nil and decodedData.newMonsterIdSpecified ~= false then
        data.newMonsterId = decodedData.newMonsterId
    end
    if decodedData.isAgree ~= nil and decodedData.isAgreeSpecified ~= false then
        data.isAgree = decodedData.isAgree
    end
    return data
end

---@param decodedData unionV2.HandlingSuccess lua中的数据结构
---@return unionV2.HandlingSuccess C#中的数据结构
function unionV2.HandlingSuccess(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.HandlingSuccess()
    if decodedData.isAgree ~= nil and decodedData.isAgreeSpecified ~= false then
        data.isAgree = decodedData.isAgree
    end
    return data
end

---@param decodedData unionV2.ReqUnionUpgrade lua中的数据结构
---@return unionV2.ReqUnionUpgrade C#中的数据结构
function unionV2.ReqUnionUpgrade(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqUnionUpgrade()
    if decodedData.toLevel ~= nil and decodedData.toLevelSpecified ~= false then
        data.toLevel = decodedData.toLevel
    end
    return data
end

---@param decodedData unionV2.ReqUnionBadgeReplace lua中的数据结构
---@return unionV2.ReqUnionBadgeReplace C#中的数据结构
function unionV2.ReqUnionBadgeReplace(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqUnionBadgeReplace()
    if decodedData.unionIcon ~= nil and decodedData.unionIconSpecified ~= false then
        data.unionIcon = decodedData.unionIcon
    end
    return data
end

---@param decodedData unionV2.ReqUpdateUnionUpgradeRedPoint lua中的数据结构
---@return unionV2.ReqUpdateUnionUpgradeRedPoint C#中的数据结构
function unionV2.ReqUpdateUnionUpgradeRedPoint(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqUpdateUnionUpgradeRedPoint()
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    return data
end

---@param decodedData unionV2.ReqUpdateUnionCallBackUsePosition lua中的数据结构
---@return unionV2.ReqUpdateUnionCallBackUsePosition C#中的数据结构
function unionV2.ReqUpdateUnionCallBackUsePosition(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqUpdateUnionCallBackUsePosition()
    if decodedData.position ~= nil and decodedData.positionSpecified ~= false then
        data.position = decodedData.position
    end
    return data
end

---@param decodedData unionV2.ReqCombineUnion lua中的数据结构
---@return unionV2.ReqCombineUnion C#中的数据结构
function unionV2.ReqCombineUnion(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqCombineUnion()
    data.unionId = decodedData.unionId
    return data
end

---@param decodedData unionV2.ResApplyCombineUnion lua中的数据结构
---@return unionV2.ResApplyCombineUnion C#中的数据结构
function unionV2.ResApplyCombineUnion(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResApplyCombineUnion()
    data.unionId = decodedData.unionId
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.leaderId ~= nil and decodedData.leaderIdSpecified ~= false then
        data.leaderId = decodedData.leaderId
    end
    if decodedData.leaderName ~= nil and decodedData.leaderNameSpecified ~= false then
        data.leaderName = decodedData.leaderName
    end
    return data
end

---@param decodedData unionV2.ReqConfirmCombineUnion lua中的数据结构
---@return unionV2.ReqConfirmCombineUnion C#中的数据结构
function unionV2.ReqConfirmCombineUnion(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqConfirmCombineUnion()
    data.unionId = decodedData.unionId
    data.agree = decodedData.agree
    return data
end

---@param decodedData unionV2.ResSpoilsHouse lua中的数据结构
---@return unionV2.ResSpoilsHouse C#中的数据结构
function unionV2.ResSpoilsHouse(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResSpoilsHouse()
    if decodedData.spoils ~= nil and decodedData.spoilsSpecified ~= false then
        for i = 1, #decodedData.spoils do
            data.spoils:Add(decodeTable.bag.BagItemInfo(decodedData.spoils[i]))
        end
    end
    return data
end

---@param decodedData unionV2.ResSpoilsHouseUpdate lua中的数据结构
---@return unionV2.ResSpoilsHouseUpdate C#中的数据结构
function unionV2.ResSpoilsHouseUpdate(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResSpoilsHouseUpdate()
    if decodedData.newList ~= nil and decodedData.newListSpecified ~= false then
        for i = 1, #decodedData.newList do
            data.newList:Add(decodeTable.bag.BagItemInfo(decodedData.newList[i]))
        end
    end
    if decodedData.removeList ~= nil and decodedData.removeListSpecified ~= false then
        for i = 1, #decodedData.removeList do
            data.removeList:Add(decodedData.removeList[i])
        end
    end
    if decodedData.operate ~= nil and decodedData.operateSpecified ~= false then
        data.operate = decodedData.operate
    end
    return data
end

---@param decodedData unionV2.ReqGiveSpoils lua中的数据结构
---@return unionV2.ReqGiveSpoils C#中的数据结构
function unionV2.ReqGiveSpoils(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqGiveSpoils()
    if decodedData.SpoilsId ~= nil and decodedData.SpoilsIdSpecified ~= false then
        data.SpoilsId = decodedData.SpoilsId
    end
    if decodedData.num ~= nil and decodedData.numSpecified ~= false then
        data.num = decodedData.num
    end
    if decodedData.memberList ~= nil and decodedData.memberListSpecified ~= false then
        for i = 1, #decodedData.memberList do
            data.memberList:Add(decodedData.memberList[i])
        end
    end
    return data
end

---@param decodedData unionV2.ResCanGetSpoilsMembers lua中的数据结构
---@return unionV2.ResCanGetSpoilsMembers C#中的数据结构
function unionV2.ResCanGetSpoilsMembers(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResCanGetSpoilsMembers()
    if decodedData.members ~= nil and decodedData.membersSpecified ~= false then
        for i = 1, #decodedData.members do
            data.members:Add(unionV2.SpoilsMemberInfo(decodedData.members[i]))
        end
    end
    return data
end

---@param decodedData unionV2.SpoilsMemberInfo lua中的数据结构
---@return unionV2.SpoilsMemberInfo C#中的数据结构
function unionV2.SpoilsMemberInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.SpoilsMemberInfo()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
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
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.remain ~= nil and decodedData.remainSpecified ~= false then
        data.remain = decodedData.remain
    end
    return data
end

---@param decodedData unionV2.updateTodayCityTax lua中的数据结构
---@return unionV2.updateTodayCityTax C#中的数据结构
function unionV2.updateTodayCityTax(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.updateTodayCityTax()
    if decodedData.unionTodayTax ~= nil and decodedData.unionTodayTaxSpecified ~= false then
        data.unionTodayTax = decodedData.unionTodayTax
    end
    return data
end

---@param decodedData unionV2.UnionVoiceStatus lua中的数据结构
---@return unionV2.UnionVoiceStatus C#中的数据结构
function unionV2.UnionVoiceStatus(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionVoiceStatus()
    if decodedData.canSendVoiceMembers ~= nil and decodedData.canSendVoiceMembersSpecified ~= false then
        for i = 1, #decodedData.canSendVoiceMembers do
            data.canSendVoiceMembers:Add(decodedData.canSendVoiceMembers[i])
        end
    end
    if decodedData.voiceOpenMembers ~= nil and decodedData.voiceOpenMembersSpecified ~= false then
        for i = 1, #decodedData.voiceOpenMembers do
            data.voiceOpenMembers:Add(decodedData.voiceOpenMembers[i])
        end
    end
    return data
end

---@param decodedData unionV2.ReqToggleSendVoice lua中的数据结构
---@return unionV2.ReqToggleSendVoice C#中的数据结构
function unionV2.ReqToggleSendVoice(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqToggleSendVoice()
    data.roleId = decodedData.roleId
    data.canSend = decodedData.canSend
    return data
end

---@param decodedData unionV2.ReqToggleVoiceOpen lua中的数据结构
---@return unionV2.ReqToggleVoiceOpen C#中的数据结构
function unionV2.ReqToggleVoiceOpen(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqToggleVoiceOpen()
    data.open = decodedData.open
    return data
end

---@param decodedData unionV2.ResMagicCircleStart lua中的数据结构
---@return unionV2.ResMagicCircleStart C#中的数据结构
function unionV2.ResMagicCircleStart(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResMagicCircleStart()
    data.mid = decodedData.mid
    return data
end

---@param decodedData unionV2.ResMagicCircleInfo lua中的数据结构
---@return unionV2.ResMagicCircleInfo C#中的数据结构
function unionV2.ResMagicCircleInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResMagicCircleInfo()
    if decodedData.mid ~= nil and decodedData.midSpecified ~= false then
        data.mid = decodedData.mid
    end
    if decodedData.curCount ~= nil and decodedData.curCountSpecified ~= false then
        data.curCount = decodedData.curCount
    end
    if decodedData.maxCount ~= nil and decodedData.maxCountSpecified ~= false then
        data.maxCount = decodedData.maxCount
    end
    return data
end

---@param decodedData unionV2.ReqUnionRedBagInfo lua中的数据结构
---@return unionV2.ReqUnionRedBagInfo C#中的数据结构
function unionV2.ReqUnionRedBagInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqUnionRedBagInfo()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData unionV2.ResUnionRedBagInfo lua中的数据结构
---@return unionV2.ResUnionRedBagInfo C#中的数据结构
function unionV2.ResUnionRedBagInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResUnionRedBagInfo()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(unionV2.RedBagRoleInfo(decodedData.info[i]))
        end
    end
    if decodedData.subMoney ~= nil and decodedData.subMoneySpecified ~= false then
        data.subMoney = decodedData.subMoney
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.roleName ~= nil and decodedData.roleNameSpecified ~= false then
        data.roleName = decodedData.roleName
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.moneyId ~= nil and decodedData.moneyIdSpecified ~= false then
        data.moneyId = decodedData.moneyId
    end
    --C#的unionV2.ResUnionRedBagInfo类中没有找到type字段,不填充数据
    return data
end

---@param decodedData unionV2.RedBagRoleInfo lua中的数据结构
---@return unionV2.RedBagRoleInfo C#中的数据结构
function unionV2.RedBagRoleInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.RedBagRoleInfo()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.money ~= nil and decodedData.moneySpecified ~= false then
        data.money = decodedData.money
    end
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    return data
end

---@param decodedData unionV2.ReqSendRedBag lua中的数据结构
---@return unionV2.ReqSendRedBag C#中的数据结构
function unionV2.ReqSendRedBag(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqSendRedBag()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.money ~= nil and decodedData.moneySpecified ~= false then
        data.money = decodedData.money
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    --C#的unionV2.ReqSendRedBag类中没有找到type字段,不填充数据
    return data
end

---@param decodedData unionV2.ReqRecieveUnionRedBag lua中的数据结构
---@return unionV2.ReqRecieveUnionRedBag C#中的数据结构
function unionV2.ReqRecieveUnionRedBag(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqRecieveUnionRedBag()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData unionV2.ResUnionSpeakerStatus lua中的数据结构
---@return unionV2.ResUnionSpeakerStatus C#中的数据结构
function unionV2.ResUnionSpeakerStatus(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResUnionSpeakerStatus()
    if decodedData.speakerCloseMembers ~= nil and decodedData.speakerCloseMembersSpecified ~= false then
        for i = 1, #decodedData.speakerCloseMembers do
            data.speakerCloseMembers:Add(decodedData.speakerCloseMembers[i])
        end
    end
    return data
end

---@param decodedData unionV2.ResUnionCallBackInfo lua中的数据结构
---@return unionV2.ResUnionCallBackInfo C#中的数据结构
function unionV2.ResUnionCallBackInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResUnionCallBackInfo()
    if decodedData.cdTime ~= nil and decodedData.cdTimeSpecified ~= false then
        data.cdTime = decodedData.cdTime
    end
    if decodedData.durationTime ~= nil and decodedData.durationTimeSpecified ~= false then
        data.durationTime = decodedData.durationTime
    end
    return data
end

---@param decodedData unionV2.ResUnionMagicBossRank lua中的数据结构
---@return unionV2.ResUnionMagicBossRank C#中的数据结构
function unionV2.ResUnionMagicBossRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResUnionMagicBossRank()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(unionV2.UnionMagicBossRankInfo(decodedData.info[i]))
        end
    end
    return data
end

---@param decodedData unionV2.UnionMagicBossRankInfo lua中的数据结构
---@return unionV2.UnionMagicBossRankInfo C#中的数据结构
function unionV2.UnionMagicBossRankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionMagicBossRankInfo()
    if decodedData.rank ~= nil and decodedData.rankSpecified ~= false then
        data.rank = decodedData.rank
    end
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.score ~= nil and decodedData.scoreSpecified ~= false then
        data.score = decodedData.score
    end
    return data
end

---@param decodedData unionV2.ResUpdateAgencyChairman lua中的数据结构
---@return unionV2.ResUpdateAgencyChairman C#中的数据结构
function unionV2.ResUpdateAgencyChairman(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResUpdateAgencyChairman()
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.chairmanId ~= nil and decodedData.chairmanIdSpecified ~= false then
        data.chairmanId = decodedData.chairmanId
    end
    if decodedData.chairmanName ~= nil and decodedData.chairmanNameSpecified ~= false then
        data.chairmanName = decodedData.chairmanName
    end
    return data
end

---@param decodedData unionV2.ResToViewUnionRevenge lua中的数据结构
---@return unionV2.ResToViewUnionRevenge C#中的数据结构
function unionV2.ResToViewUnionRevenge(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResToViewUnionRevenge()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(unionV2.UnionRevenge(decodedData.info[i]))
        end
    end
    return data
end

---@param decodedData unionV2.UnionRevenge lua中的数据结构
---@return unionV2.UnionRevenge C#中的数据结构
function unionV2.UnionRevenge(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionRevenge()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.createTime ~= nil and decodedData.createTimeSpecified ~= false then
        data.createTime = decodedData.createTime
    end
    if decodedData.killedRoleId ~= nil and decodedData.killedRoleIdSpecified ~= false then
        data.killedRoleId = decodedData.killedRoleId
    end
    if decodedData.revengeRoleId ~= nil and decodedData.revengeRoleIdSpecified ~= false then
        data.revengeRoleId = decodedData.revengeRoleId
    end
    if decodedData.completeRoleId ~= nil and decodedData.completeRoleIdSpecified ~= false then
        data.completeRoleId = decodedData.completeRoleId
    end
    if decodedData.revengeType ~= nil and decodedData.revengeTypeSpecified ~= false then
        data.revengeType = decodedData.revengeType
    end
    if decodedData.canReward ~= nil and decodedData.canRewardSpecified ~= false then
        data.canReward = decodedData.canReward
    end
    if decodedData.revengeRoleName ~= nil and decodedData.revengeRoleNameSpecified ~= false then
        data.revengeRoleName = decodedData.revengeRoleName
    end
    if decodedData.revengeRoleUnionId ~= nil and decodedData.revengeRoleUnionIdSpecified ~= false then
        data.revengeRoleUnionId = decodedData.revengeRoleUnionId
    end
    if decodedData.revengeRoleUnionName ~= nil and decodedData.revengeRoleUnionNameSpecified ~= false then
        data.revengeRoleUnionName = decodedData.revengeRoleUnionName
    end
    if decodedData.revengeRoleCareer ~= nil and decodedData.revengeRoleCareerSpecified ~= false then
        data.revengeRoleCareer = decodedData.revengeRoleCareer
    end
    if decodedData.revengeRoleLevel ~= nil and decodedData.revengeRoleLevelSpecified ~= false then
        data.revengeRoleLevel = decodedData.revengeRoleLevel
    end
    if decodedData.revengeRoleSex ~= nil and decodedData.revengeRoleSexSpecified ~= false then
        data.revengeRoleSex = decodedData.revengeRoleSex
    end
    if decodedData.killedRoleName ~= nil and decodedData.killedRoleNameSpecified ~= false then
        data.killedRoleName = decodedData.killedRoleName
    end
    return data
end

---@param decodedData unionV2.ReqRewardUnionRevenge lua中的数据结构
---@return unionV2.ReqRewardUnionRevenge C#中的数据结构
function unionV2.ReqRewardUnionRevenge(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqRewardUnionRevenge()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData unionV2.ResRewardUnionRevenge lua中的数据结构
---@return unionV2.ResRewardUnionRevenge C#中的数据结构
function unionV2.ResRewardUnionRevenge(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResRewardUnionRevenge()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.canReward ~= nil and decodedData.canRewardSpecified ~= false then
        data.canReward = decodedData.canReward
    end
    return data
end

---@param decodedData unionV2.ResAddUnionRevenge lua中的数据结构
---@return unionV2.ResAddUnionRevenge C#中的数据结构
function unionV2.ResAddUnionRevenge(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResAddUnionRevenge()
    if decodedData.unionRevenge ~= nil and decodedData.unionRevengeSpecified ~= false then
        data.unionRevenge = unionV2.UnionRevenge(decodedData.unionRevenge)
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData unionV2.ReqGetRevengePoint lua中的数据结构
---@return unionV2.ReqGetRevengePoint C#中的数据结构
function unionV2.ReqGetRevengePoint(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqGetRevengePoint()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData unionV2.ResGetRevengePoint lua中的数据结构
---@return unionV2.ResGetRevengePoint C#中的数据结构
function unionV2.ResGetRevengePoint(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ResGetRevengePoint()
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    if decodedData.targetName ~= nil and decodedData.targetNameSpecified ~= false then
        data.targetName = decodedData.targetName
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
    if decodedData.line ~= nil and decodedData.lineSpecified ~= false then
        data.line = decodedData.line
    end
    return data
end

---@param decodedData unionV2.ReqWillJoinUniteUnionInfo lua中的数据结构
---@return unionV2.ReqWillJoinUniteUnionInfo C#中的数据结构
function unionV2.ReqWillJoinUniteUnionInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.ReqWillJoinUniteUnionInfo()
    if decodedData.uniteUnionType ~= nil and decodedData.uniteUnionTypeSpecified ~= false then
        data.uniteUnionType = decodedData.uniteUnionType
    end
    return data
end

---@param decodedData unionV2.WillJoinUniteUnionInfo lua中的数据结构
---@return unionV2.WillJoinUniteUnionInfo C#中的数据结构
function unionV2.WillJoinUniteUnionInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.WillJoinUniteUnionInfo()
    if decodedData.uniteUnionType ~= nil and decodedData.uniteUnionTypeSpecified ~= false then
        data.uniteUnionType = decodedData.uniteUnionType
    end
    if decodedData.uniteUnionCount ~= nil and decodedData.uniteUnionCountSpecified ~= false then
        data.uniteUnionCount = decodedData.uniteUnionCount
    end
    return data
end

---@param decodedData unionV2.AllWillJoinUniteUnion lua中的数据结构
---@return unionV2.AllWillJoinUniteUnion C#中的数据结构
function unionV2.AllWillJoinUniteUnion(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.AllWillJoinUniteUnion()
    if decodedData.allJoin ~= nil and decodedData.allJoinSpecified ~= false then
        for i = 1, #decodedData.allJoin do
            data.allJoin:Add(unionV2.WillJoinUniteUnionInfo(decodedData.allJoin[i]))
        end
    end
    return data
end

---@param decodedData unionV2.OtherUnionVoteInfo lua中的数据结构
---@return unionV2.OtherUnionVoteInfo C#中的数据结构
function unionV2.OtherUnionVoteInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.OtherUnionVoteInfo()
    if decodedData.hostId ~= nil and decodedData.hostIdSpecified ~= false then
        data.hostId = decodedData.hostId
    end
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.activeCount ~= nil and decodedData.activeCountSpecified ~= false then
        data.activeCount = decodedData.activeCount
    end
    if decodedData.num ~= nil and decodedData.numSpecified ~= false then
        data.num = decodedData.num
    end
    if decodedData.WillJoinUniteUnionInfo ~= nil and decodedData.WillJoinUniteUnionInfoSpecified ~= false then
        for i = 1, #decodedData.WillJoinUniteUnionInfo do
            data.WillJoinUniteUnionInfo:Add(unionV2.WillJoinUniteUnionInfo(decodedData.WillJoinUniteUnionInfo[i]))
        end
    end
    return data
end

---@param decodedData unionV2.OtherServerUnionVoteAllInfo lua中的数据结构
---@return unionV2.OtherServerUnionVoteAllInfo C#中的数据结构
function unionV2.OtherServerUnionVoteAllInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.OtherServerUnionVoteAllInfo()
    if decodedData.otherUnionVoteInfo ~= nil and decodedData.otherUnionVoteInfoSpecified ~= false then
        for i = 1, #decodedData.otherUnionVoteInfo do
            data.otherUnionVoteInfo:Add(unionV2.OtherUnionVoteInfo(decodedData.otherUnionVoteInfo[i]))
        end
    end
    return data
end

---@param decodedData unionV2.OtherAllUniteUnionVoteInfo lua中的数据结构
---@return unionV2.OtherAllUniteUnionVoteInfo C#中的数据结构
function unionV2.OtherAllUniteUnionVoteInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.OtherAllUniteUnionVoteInfo()
    if decodedData.otherServerUnionVoteAllInfo ~= nil and decodedData.otherServerUnionVoteAllInfoSpecified ~= false then
        for i = 1, #decodedData.otherServerUnionVoteAllInfo do
            data.otherServerUnionVoteAllInfo:Add(unionV2.OtherServerUnionVoteAllInfo(decodedData.otherServerUnionVoteAllInfo[i]))
        end
    end
    return data
end

---@param decodedData unionV2.UnionBossPlayerRankInfo lua中的数据结构
---@return unionV2.UnionBossPlayerRankInfo C#中的数据结构
function unionV2.UnionBossPlayerRankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionBossPlayerRankInfo()
    if decodedData.playerRanks ~= nil and decodedData.playerRanksSpecified ~= false then
        for i = 1, #decodedData.playerRanks do
            data.playerRanks:Add(unionV2.UnionBossPlayerRankStrcut(decodedData.playerRanks[i]))
        end
    end
    if decodedData.selfRank ~= nil and decodedData.selfRankSpecified ~= false then
        data.selfRank = unionV2.UnionBossPlayerRankStrcut(decodedData.selfRank)
    end
    return data
end

---@param decodedData unionV2.UnionBossPlayerRankStrcut lua中的数据结构
---@return unionV2.UnionBossPlayerRankStrcut C#中的数据结构
function unionV2.UnionBossPlayerRankStrcut(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionBossPlayerRankStrcut()
    data.rankNo = decodedData.rankNo
    data.score = decodedData.score
    data.playerName = decodedData.playerName
    return data
end

---@param decodedData unionV2.UnionBossUnionRankInfo lua中的数据结构
---@return unionV2.UnionBossUnionRankInfo C#中的数据结构
function unionV2.UnionBossUnionRankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionBossUnionRankInfo()
    if decodedData.unionRanks ~= nil and decodedData.unionRanksSpecified ~= false then
        for i = 1, #decodedData.unionRanks do
            data.unionRanks:Add(unionV2.UnionBossUnionRankStrcut(decodedData.unionRanks[i]))
        end
    end
    if decodedData.selfUnioRank ~= nil and decodedData.selfUnioRankSpecified ~= false then
        data.selfUnioRank = unionV2.UnionBossUnionRankStrcut(decodedData.selfUnioRank)
    end
    return data
end

---@param decodedData unionV2.UnionBossUnionRankStrcut lua中的数据结构
---@return unionV2.UnionBossUnionRankStrcut C#中的数据结构
function unionV2.UnionBossUnionRankStrcut(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionBossUnionRankStrcut()
    data.rankNo = decodedData.rankNo
    data.score = decodedData.score
    data.unionName = decodedData.unionName
    return data
end

---@param decodedData unionV2.UnionBossAddBuff lua中的数据结构
---@return unionV2.UnionBossAddBuff C#中的数据结构
function unionV2.UnionBossAddBuff(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionBossAddBuff()
    data.type = decodedData.type
    return data
end

---@param decodedData unionV2.UnionBossBuffInfo lua中的数据结构
---@return unionV2.UnionBossBuffInfo C#中的数据结构
function unionV2.UnionBossBuffInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.unionV2.UnionBossBuffInfo()
    data.remainUnionNum = decodedData.remainUnionNum
    data.remainPersonalNum = decodedData.remainPersonalNum
    data.unionNum = decodedData.unionNum
    data.personalNum = decodedData.personalNum
    return data
end

return unionV2