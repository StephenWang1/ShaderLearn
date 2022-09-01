--[[本文件为工具自动生成,禁止手动修改]]
local unionV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable unionV2.ReqGetUnionJournal
---@type unionV2.ReqGetUnionJournal
unionV2_adj.metatable_ReqGetUnionJournal = {
    _ClassName = "unionV2.ReqGetUnionJournal",
}
unionV2_adj.metatable_ReqGetUnionJournal.__index = unionV2_adj.metatable_ReqGetUnionJournal
--endregion

---@param tbl unionV2.ReqGetUnionJournal 待调整的table数据
function unionV2_adj.AdjustReqGetUnionJournal(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqGetUnionJournal)
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
end

--region metatable unionV2.ResGetUnionJournal
---@type unionV2.ResGetUnionJournal
unionV2_adj.metatable_ResGetUnionJournal = {
    _ClassName = "unionV2.ResGetUnionJournal",
}
unionV2_adj.metatable_ResGetUnionJournal.__index = unionV2_adj.metatable_ResGetUnionJournal
--endregion

---@param tbl unionV2.ResGetUnionJournal 待调整的table数据
function unionV2_adj.AdjustResGetUnionJournal(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResGetUnionJournal)
    if tbl.unionJournalInfo == nil then
        tbl.unionJournalInfo = {}
    else
        if unionV2_adj.AdjustUnionJournal ~= nil then
            for i = 1, #tbl.unionJournalInfo do
                unionV2_adj.AdjustUnionJournal(tbl.unionJournalInfo[i])
            end
        end
    end
end

--region metatable unionV2.UnionJournal
---@type unionV2.UnionJournal
unionV2_adj.metatable_UnionJournal = {
    _ClassName = "unionV2.UnionJournal",
}
unionV2_adj.metatable_UnionJournal.__index = unionV2_adj.metatable_UnionJournal
--endregion

---@param tbl unionV2.UnionJournal 待调整的table数据
function unionV2_adj.AdjustUnionJournal(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionJournal)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.operationTime == nil then
        tbl.operationTimeSpecified = false
        tbl.operationTime = 0
    else
        tbl.operationTimeSpecified = true
    end
    if tbl.operation == nil then
        tbl.operationSpecified = false
        tbl.operation = ""
    else
        tbl.operationSpecified = true
    end
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable unionV2.ReqGetUnionAttribute
---@type unionV2.ReqGetUnionAttribute
unionV2_adj.metatable_ReqGetUnionAttribute = {
    _ClassName = "unionV2.ReqGetUnionAttribute",
}
unionV2_adj.metatable_ReqGetUnionAttribute.__index = unionV2_adj.metatable_ReqGetUnionAttribute
--endregion

---@param tbl unionV2.ReqGetUnionAttribute 待调整的table数据
function unionV2_adj.AdjustReqGetUnionAttribute(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqGetUnionAttribute)
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
end

--region metatable unionV2.ResGetUnionAttribute
---@type unionV2.ResGetUnionAttribute
unionV2_adj.metatable_ResGetUnionAttribute = {
    _ClassName = "unionV2.ResGetUnionAttribute",
}
unionV2_adj.metatable_ResGetUnionAttribute.__index = unionV2_adj.metatable_ResGetUnionAttribute
--endregion

---@param tbl unionV2.ResGetUnionAttribute 待调整的table数据
function unionV2_adj.AdjustResGetUnionAttribute(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResGetUnionAttribute)
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
    if tbl.thisAttribute == nil then
        tbl.thisAttributeSpecified = false
        tbl.thisAttribute = 0
    else
        tbl.thisAttributeSpecified = true
    end
    if tbl.perfectPopulation == nil then
        tbl.perfectPopulationSpecified = false
        tbl.perfectPopulation = 0
    else
        tbl.perfectPopulationSpecified = true
    end
    if tbl.thisNum == nil then
        tbl.thisNumSpecified = false
        tbl.thisNum = 0
    else
        tbl.thisNumSpecified = true
    end
    if tbl.attackWarrior == nil then
        tbl.attackWarriorSpecified = false
        tbl.attackWarrior = 0
    else
        tbl.attackWarriorSpecified = true
    end
    if tbl.attackMagic == nil then
        tbl.attackMagicSpecified = false
        tbl.attackMagic = 0
    else
        tbl.attackMagicSpecified = true
    end
    if tbl.attackMonk == nil then
        tbl.attackMonkSpecified = false
        tbl.attackMonk = 0
    else
        tbl.attackMonkSpecified = true
    end
    if tbl.phyDefense == nil then
        tbl.phyDefenseSpecified = false
        tbl.phyDefense = 0
    else
        tbl.phyDefenseSpecified = true
    end
    if tbl.magDefense == nil then
        tbl.magDefenseSpecified = false
        tbl.magDefense = 0
    else
        tbl.magDefenseSpecified = true
    end
    if tbl.blood == nil then
        tbl.bloodSpecified = false
        tbl.blood = 0
    else
        tbl.bloodSpecified = true
    end
    if tbl.unionBossRankNo == nil then
        tbl.unionBossRankNoSpecified = false
        tbl.unionBossRankNo = 0
    else
        tbl.unionBossRankNoSpecified = true
    end
end

--region metatable unionV2.ReqGetAllUnionIcon
---@type unionV2.ReqGetAllUnionIcon
unionV2_adj.metatable_ReqGetAllUnionIcon = {
    _ClassName = "unionV2.ReqGetAllUnionIcon",
}
unionV2_adj.metatable_ReqGetAllUnionIcon.__index = unionV2_adj.metatable_ReqGetAllUnionIcon
--endregion

---@param tbl unionV2.ReqGetAllUnionIcon 待调整的table数据
function unionV2_adj.AdjustReqGetAllUnionIcon(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqGetAllUnionIcon)
    if tbl.isReturnRare == nil then
        tbl.isReturnRareSpecified = false
        tbl.isReturnRare = false
    else
        tbl.isReturnRareSpecified = true
    end
end

--region metatable unionV2.ResGetAllUnionIcon
---@type unionV2.ResGetAllUnionIcon
unionV2_adj.metatable_ResGetAllUnionIcon = {
    _ClassName = "unionV2.ResGetAllUnionIcon",
}
unionV2_adj.metatable_ResGetAllUnionIcon.__index = unionV2_adj.metatable_ResGetAllUnionIcon
--endregion

---@param tbl unionV2.ResGetAllUnionIcon 待调整的table数据
function unionV2_adj.AdjustResGetAllUnionIcon(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResGetAllUnionIcon)
    if tbl.unionIconInfo == nil then
        tbl.unionIconInfo = {}
    else
        if unionV2_adj.AdjustUnionIconInfo ~= nil then
            for i = 1, #tbl.unionIconInfo do
                unionV2_adj.AdjustUnionIconInfo(tbl.unionIconInfo[i])
            end
        end
    end
end

--region metatable unionV2.UnionIconInfo
---@type unionV2.UnionIconInfo
unionV2_adj.metatable_UnionIconInfo = {
    _ClassName = "unionV2.UnionIconInfo",
}
unionV2_adj.metatable_UnionIconInfo.__index = unionV2_adj.metatable_UnionIconInfo
--endregion

---@param tbl unionV2.UnionIconInfo 待调整的table数据
function unionV2_adj.AdjustUnionIconInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionIconInfo)
    if tbl.unionIconId == nil then
        tbl.unionIconIdSpecified = false
        tbl.unionIconId = 0
    else
        tbl.unionIconIdSpecified = true
    end
    if tbl.isHave == nil then
        tbl.isHaveSpecified = false
        tbl.isHave = false
    else
        tbl.isHaveSpecified = true
    end
    if tbl.isXiyou == nil then
        tbl.isXiyouSpecified = false
        tbl.isXiyou = false
    else
        tbl.isXiyouSpecified = true
    end
end

--region metatable unionV2.ReqSendAllUnionInfo
---@type unionV2.ReqSendAllUnionInfo
unionV2_adj.metatable_ReqSendAllUnionInfo = {
    _ClassName = "unionV2.ReqSendAllUnionInfo",
}
unionV2_adj.metatable_ReqSendAllUnionInfo.__index = unionV2_adj.metatable_ReqSendAllUnionInfo
--endregion

---@param tbl unionV2.ReqSendAllUnionInfo 待调整的table数据
function unionV2_adj.AdjustReqSendAllUnionInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqSendAllUnionInfo)
end

--region metatable unionV2.ResSendAllUnionInfo
---@type unionV2.ResSendAllUnionInfo
unionV2_adj.metatable_ResSendAllUnionInfo = {
    _ClassName = "unionV2.ResSendAllUnionInfo",
}
unionV2_adj.metatable_ResSendAllUnionInfo.__index = unionV2_adj.metatable_ResSendAllUnionInfo
--endregion

---@param tbl unionV2.ResSendAllUnionInfo 待调整的table数据
function unionV2_adj.AdjustResSendAllUnionInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResSendAllUnionInfo)
    if tbl.unionInfo == nil then
        tbl.unionInfo = {}
    else
        if unionV2_adj.AdjustUnionInfo ~= nil then
            for i = 1, #tbl.unionInfo do
                unionV2_adj.AdjustUnionInfo(tbl.unionInfo[i])
            end
        end
    end
    if tbl.exitUnionTime == nil then
        tbl.exitUnionTimeSpecified = false
        tbl.exitUnionTime = 0
    else
        tbl.exitUnionTimeSpecified = true
    end
    if tbl.dissolutionTime == nil then
        tbl.dissolutionTimeSpecified = false
        tbl.dissolutionTime = 0
    else
        tbl.dissolutionTimeSpecified = true
    end
    if tbl.canCreatUnion == nil then
        tbl.canCreatUnionSpecified = false
        tbl.canCreatUnion = false
    else
        tbl.canCreatUnionSpecified = true
    end
end

--region metatable unionV2.UnionInfo
---@type unionV2.UnionInfo
unionV2_adj.metatable_UnionInfo = {
    _ClassName = "unionV2.UnionInfo",
}
unionV2_adj.metatable_UnionInfo.__index = unionV2_adj.metatable_UnionInfo
--endregion

---@param tbl unionV2.UnionInfo 待调整的table数据
function unionV2_adj.AdjustUnionInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionInfo)
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
    if tbl.leaderName == nil then
        tbl.leaderNameSpecified = false
        tbl.leaderName = ""
    else
        tbl.leaderNameSpecified = true
    end
    if tbl.announcement == nil then
        tbl.announcementSpecified = false
        tbl.announcement = ""
    else
        tbl.announcementSpecified = true
    end
    if tbl.unionNum == nil then
        tbl.unionNumSpecified = false
        tbl.unionNum = 0
    else
        tbl.unionNumSpecified = true
    end
    if tbl.applyState == nil then
        tbl.applyStateSpecified = false
        tbl.applyState = 0
    else
        tbl.applyStateSpecified = true
    end
    if tbl.createTime == nil then
        tbl.createTimeSpecified = false
        tbl.createTime = 0
    else
        tbl.createTimeSpecified = true
    end
    if tbl.nbValue == nil then
        tbl.nbValueSpecified = false
        tbl.nbValue = 0
    else
        tbl.nbValueSpecified = true
    end
    if tbl.unionGold == nil then
        tbl.unionGoldSpecified = false
        tbl.unionGold = 0
    else
        tbl.unionGoldSpecified = true
    end
    if tbl.autoEnter == nil then
        tbl.autoEnterSpecified = false
        tbl.autoEnter = 0
    else
        tbl.autoEnterSpecified = true
    end
    if tbl.isImpeachment == nil then
        tbl.isImpeachmentSpecified = false
        tbl.isImpeachment = false
    else
        tbl.isImpeachmentSpecified = true
    end
    if tbl.impeachmentTime == nil then
        tbl.impeachmentTimeSpecified = false
        tbl.impeachmentTime = 0
    else
        tbl.impeachmentTimeSpecified = true
    end
    if tbl.leaderOnline == nil then
        tbl.leaderOnlineSpecified = false
        tbl.leaderOnline = false
    else
        tbl.leaderOnlineSpecified = true
    end
    if tbl.unionIcon == nil then
        tbl.unionIconSpecified = false
        tbl.unionIcon = 0
    else
        tbl.unionIconSpecified = true
    end
    if tbl.leaderId == nil then
        tbl.leaderIdSpecified = false
        tbl.leaderId = 0
    else
        tbl.leaderIdSpecified = true
    end
    if tbl.modifyCount == nil then
        tbl.modifyCountSpecified = false
        tbl.modifyCount = 0
    else
        tbl.modifyCountSpecified = true
    end
    if tbl.canUseUnionCallBackPosition == nil then
        tbl.canUseUnionCallBackPositionSpecified = false
        tbl.canUseUnionCallBackPosition = 0
    else
        tbl.canUseUnionCallBackPositionSpecified = true
    end
    if tbl.sabacScore == nil then
        tbl.sabacScoreSpecified = false
        tbl.sabacScore = 0
    else
        tbl.sabacScoreSpecified = true
    end
    if tbl.crown == nil then
        tbl.crownSpecified = false
        tbl.crown = false
    else
        tbl.crownSpecified = true
    end
    if tbl.isPayImeach == nil then
        tbl.isPayImeachSpecified = false
        tbl.isPayImeach = false
    else
        tbl.isPayImeachSpecified = true
    end
    if tbl.lastCombineTime == nil then
        tbl.lastCombineTimeSpecified = false
        tbl.lastCombineTime = 0
    else
        tbl.lastCombineTimeSpecified = true
    end
    if tbl.rank == nil then
        tbl.rankSpecified = false
        tbl.rank = 0
    else
        tbl.rankSpecified = true
    end
    if tbl.seizeCityId == nil then
        tbl.seizeCityIdSpecified = false
        tbl.seizeCityId = 0
    else
        tbl.seizeCityIdSpecified = true
    end
    if tbl.unionTodayTax == nil then
        tbl.unionTodayTaxSpecified = false
        tbl.unionTodayTax = 0
    else
        tbl.unionTodayTaxSpecified = true
    end
    if tbl.isPushUnion == nil then
        tbl.isPushUnionSpecified = false
        tbl.isPushUnion = false
    else
        tbl.isPushUnionSpecified = true
    end
    if tbl.unionAcvite == nil then
        tbl.unionAcviteSpecified = false
        tbl.unionAcvite = 0
    else
        tbl.unionAcviteSpecified = true
    end
    if tbl.unionActiveYesterday == nil then
        tbl.unionActiveYesterdaySpecified = false
        tbl.unionActiveYesterday = 0
    else
        tbl.unionActiveYesterdaySpecified = true
    end
    if tbl.unionActiveRankYesterday == nil then
        tbl.unionActiveRankYesterdaySpecified = false
        tbl.unionActiveRankYesterday = 0
    else
        tbl.unionActiveRankYesterdaySpecified = true
    end
    if tbl.lastCallBackTime == nil then
        tbl.lastCallBackTimeSpecified = false
        tbl.lastCallBackTime = 0
    else
        tbl.lastCallBackTimeSpecified = true
    end
    if tbl.isAutoCreated == nil then
        tbl.isAutoCreatedSpecified = false
        tbl.isAutoCreated = false
    else
        tbl.isAutoCreatedSpecified = true
    end
    if tbl.unionBossRankNo == nil then
        tbl.unionBossRankNoSpecified = false
        tbl.unionBossRankNo = 0
    else
        tbl.unionBossRankNoSpecified = true
    end
end

--region metatable unionV2.UnionChatAnnounce
---@type unionV2.UnionChatAnnounce
unionV2_adj.metatable_UnionChatAnnounce = {
    _ClassName = "unionV2.UnionChatAnnounce",
}
unionV2_adj.metatable_UnionChatAnnounce.__index = unionV2_adj.metatable_UnionChatAnnounce
--endregion

---@param tbl unionV2.UnionChatAnnounce 待调整的table数据
function unionV2_adj.AdjustUnionChatAnnounce(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionChatAnnounce)
    if tbl.announce == nil then
        tbl.announceSpecified = false
        tbl.announce = nil
    else
        if tbl.announceSpecified == nil then 
            tbl.announceSpecified = true
            if adjustTable.chat_adj ~= nil and adjustTable.chat_adj.AdjustResAnnounce ~= nil then
                adjustTable.chat_adj.AdjustResAnnounce(tbl.announce)
            end
        end
    end
    if tbl.chat == nil then
        tbl.chatSpecified = false
        tbl.chat = nil
    else
        if tbl.chatSpecified == nil then 
            tbl.chatSpecified = true
            if adjustTable.chat_adj ~= nil and adjustTable.chat_adj.AdjustResChat ~= nil then
                adjustTable.chat_adj.AdjustResChat(tbl.chat)
            end
        end
    end
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
end

--region metatable unionV2.ResUnionChatAnnounce
---@type unionV2.ResUnionChatAnnounce
unionV2_adj.metatable_ResUnionChatAnnounce = {
    _ClassName = "unionV2.ResUnionChatAnnounce",
}
unionV2_adj.metatable_ResUnionChatAnnounce.__index = unionV2_adj.metatable_ResUnionChatAnnounce
--endregion

---@param tbl unionV2.ResUnionChatAnnounce 待调整的table数据
function unionV2_adj.AdjustResUnionChatAnnounce(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResUnionChatAnnounce)
    if tbl.announces == nil then
        tbl.announces = {}
    else
        if unionV2_adj.AdjustUnionChatAnnounce ~= nil then
            for i = 1, #tbl.announces do
                unionV2_adj.AdjustUnionChatAnnounce(tbl.announces[i])
            end
        end
    end
end

--region metatable unionV2.ReqJoinOrWithdrawUnion
---@type unionV2.ReqJoinOrWithdrawUnion
unionV2_adj.metatable_ReqJoinOrWithdrawUnion = {
    _ClassName = "unionV2.ReqJoinOrWithdrawUnion",
}
unionV2_adj.metatable_ReqJoinOrWithdrawUnion.__index = unionV2_adj.metatable_ReqJoinOrWithdrawUnion
--endregion

---@param tbl unionV2.ReqJoinOrWithdrawUnion 待调整的table数据
function unionV2_adj.AdjustReqJoinOrWithdrawUnion(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqJoinOrWithdrawUnion)
end

--region metatable unionV2.ResApplyForUnionStateChange
---@type unionV2.ResApplyForUnionStateChange
unionV2_adj.metatable_ResApplyForUnionStateChange = {
    _ClassName = "unionV2.ResApplyForUnionStateChange",
}
unionV2_adj.metatable_ResApplyForUnionStateChange.__index = unionV2_adj.metatable_ResApplyForUnionStateChange
--endregion

---@param tbl unionV2.ResApplyForUnionStateChange 待调整的table数据
function unionV2_adj.AdjustResApplyForUnionStateChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResApplyForUnionStateChange)
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
end

--region metatable unionV2.UnionRedPackInfo
---@type unionV2.UnionRedPackInfo
unionV2_adj.metatable_UnionRedPackInfo = {
    _ClassName = "unionV2.UnionRedPackInfo",
}
unionV2_adj.metatable_UnionRedPackInfo.__index = unionV2_adj.metatable_UnionRedPackInfo
--endregion

---@param tbl unionV2.UnionRedPackInfo 待调整的table数据
function unionV2_adj.AdjustUnionRedPackInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionRedPackInfo)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.senderCareer == nil then
        tbl.senderCareerSpecified = false
        tbl.senderCareer = 0
    else
        tbl.senderCareerSpecified = true
    end
    if tbl.sendSex == nil then
        tbl.sendSexSpecified = false
        tbl.sendSex = 0
    else
        tbl.sendSexSpecified = true
    end
    if tbl.redPackId == nil then
        tbl.redPackIdSpecified = false
        tbl.redPackId = 0
    else
        tbl.redPackIdSpecified = true
    end
    if tbl.money == nil then
        tbl.moneySpecified = false
        tbl.money = 0
    else
        tbl.moneySpecified = true
    end
    if tbl.isGet == nil then
        tbl.isGetSpecified = false
        tbl.isGet = false
    else
        tbl.isGetSpecified = true
    end
    if tbl.isNull == nil then
        tbl.isNullSpecified = false
        tbl.isNull = false
    else
        tbl.isNullSpecified = true
    end
    if tbl.content == nil then
        tbl.contentSpecified = false
        tbl.content = ""
    else
        tbl.contentSpecified = true
    end
    if tbl.sendTime == nil then
        tbl.sendTimeSpecified = false
        tbl.sendTime = 0
    else
        tbl.sendTimeSpecified = true
    end
end

--region metatable unionV2.UnionRedPackRecordInfo
---@type unionV2.UnionRedPackRecordInfo
unionV2_adj.metatable_UnionRedPackRecordInfo = {
    _ClassName = "unionV2.UnionRedPackRecordInfo",
}
unionV2_adj.metatable_UnionRedPackRecordInfo.__index = unionV2_adj.metatable_UnionRedPackRecordInfo
--endregion

---@param tbl unionV2.UnionRedPackRecordInfo 待调整的table数据
function unionV2_adj.AdjustUnionRedPackRecordInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionRedPackRecordInfo)
    if tbl.sender == nil then
        tbl.senderSpecified = false
        tbl.sender = ""
    else
        tbl.senderSpecified = true
    end
    if tbl.robber == nil then
        tbl.robberSpecified = false
        tbl.robber = ""
    else
        tbl.robberSpecified = true
    end
    if tbl.robberCareer == nil then
        tbl.robberCareerSpecified = false
        tbl.robberCareer = 0
    else
        tbl.robberCareerSpecified = true
    end
    if tbl.robberSex == nil then
        tbl.robberSexSpecified = false
        tbl.robberSex = 0
    else
        tbl.robberSexSpecified = true
    end
    if tbl.senderCareer == nil then
        tbl.senderCareerSpecified = false
        tbl.senderCareer = 0
    else
        tbl.senderCareerSpecified = true
    end
    if tbl.sendSex == nil then
        tbl.sendSexSpecified = false
        tbl.sendSex = 0
    else
        tbl.sendSexSpecified = true
    end
    if tbl.robTime == nil then
        tbl.robTimeSpecified = false
        tbl.robTime = 0
    else
        tbl.robTimeSpecified = true
    end
    if tbl.money == nil then
        tbl.moneySpecified = false
        tbl.money = 0
    else
        tbl.moneySpecified = true
    end
    if tbl.isBest == nil then
        tbl.isBestSpecified = false
        tbl.isBest = false
    else
        tbl.isBestSpecified = true
    end
end

--region metatable unionV2.UnionSettingInfo
---@type unionV2.UnionSettingInfo
unionV2_adj.metatable_UnionSettingInfo = {
    _ClassName = "unionV2.UnionSettingInfo",
}
unionV2_adj.metatable_UnionSettingInfo.__index = unionV2_adj.metatable_UnionSettingInfo
--endregion

---@param tbl unionV2.UnionSettingInfo 待调整的table数据
function unionV2_adj.AdjustUnionSettingInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionSettingInfo)
    if tbl.settingType == nil then
        tbl.settingTypeSpecified = false
        tbl.settingType = 0
    else
        tbl.settingTypeSpecified = true
    end
    if tbl.settingValue == nil then
        tbl.settingValueSpecified = false
        tbl.settingValue = 0
    else
        tbl.settingValueSpecified = true
    end
    if tbl.extraParam == nil then
        tbl.extraParamSpecified = false
        tbl.extraParam = 0
    else
        tbl.extraParamSpecified = true
    end
end

--region metatable unionV2.UnionEventInfo
---@type unionV2.UnionEventInfo
unionV2_adj.metatable_UnionEventInfo = {
    _ClassName = "unionV2.UnionEventInfo",
}
unionV2_adj.metatable_UnionEventInfo.__index = unionV2_adj.metatable_UnionEventInfo
--endregion

---@param tbl unionV2.UnionEventInfo 待调整的table数据
function unionV2_adj.AdjustUnionEventInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionEventInfo)
    if tbl.recordTime == nil then
        tbl.recordTimeSpecified = false
        tbl.recordTime = 0
    else
        tbl.recordTimeSpecified = true
    end
    if tbl.announceId == nil then
        tbl.announceIdSpecified = false
        tbl.announceId = 0
    else
        tbl.announceIdSpecified = true
    end
    if tbl.operate == nil then
        tbl.operateSpecified = false
        tbl.operate = ""
    else
        tbl.operateSpecified = true
    end
    if tbl.target == nil then
        tbl.targetSpecified = false
        tbl.target = ""
    else
        tbl.targetSpecified = true
    end
    if tbl.oldLevel == nil then
        tbl.oldLevelSpecified = false
        tbl.oldLevel = 0
    else
        tbl.oldLevelSpecified = true
    end
    if tbl.newLevel == nil then
        tbl.newLevelSpecified = false
        tbl.newLevel = 0
    else
        tbl.newLevelSpecified = true
    end
    if tbl.redPackCount == nil then
        tbl.redPackCountSpecified = false
        tbl.redPackCount = 0
    else
        tbl.redPackCountSpecified = true
    end
    if tbl.oldPosition == nil then
        tbl.oldPositionSpecified = false
        tbl.oldPosition = ""
    else
        tbl.oldPositionSpecified = true
    end
    if tbl.newPosition == nil then
        tbl.newPositionSpecified = false
        tbl.newPosition = ""
    else
        tbl.newPositionSpecified = true
    end
end

--region metatable unionV2.UnionMemberInfo
---@type unionV2.UnionMemberInfo
unionV2_adj.metatable_UnionMemberInfo = {
    _ClassName = "unionV2.UnionMemberInfo",
}
unionV2_adj.metatable_UnionMemberInfo.__index = unionV2_adj.metatable_UnionMemberInfo
--endregion

---@param tbl unionV2.UnionMemberInfo 待调整的table数据
function unionV2_adj.AdjustUnionMemberInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionMemberInfo)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.memberName == nil then
        tbl.memberNameSpecified = false
        tbl.memberName = ""
    else
        tbl.memberNameSpecified = true
    end
    if tbl.position == nil then
        tbl.positionSpecified = false
        tbl.position = 0
    else
        tbl.positionSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.memberLevel == nil then
        tbl.memberLevelSpecified = false
        tbl.memberLevel = 0
    else
        tbl.memberLevelSpecified = true
    end
    if tbl.offlineTime == nil then
        tbl.offlineTimeSpecified = false
        tbl.offlineTime = 0
    else
        tbl.offlineTimeSpecified = true
    end
    if tbl.fightPower == nil then
        tbl.fightPowerSpecified = false
        tbl.fightPower = 0
    else
        tbl.fightPowerSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.cloth == nil then
        tbl.clothSpecified = false
        tbl.cloth = 0
    else
        tbl.clothSpecified = true
    end
    if tbl.weapon == nil then
        tbl.weaponSpecified = false
        tbl.weapon = 0
    else
        tbl.weaponSpecified = true
    end
    if tbl.wing == nil then
        tbl.wingSpecified = false
        tbl.wing = 0
    else
        tbl.wingSpecified = true
    end
    if tbl.fashionTitle == nil then
        tbl.fashionTitleSpecified = false
        tbl.fashionTitle = 0
    else
        tbl.fashionTitleSpecified = true
    end
    if tbl.fashionCloth == nil then
        tbl.fashionClothSpecified = false
        tbl.fashionCloth = 0
    else
        tbl.fashionClothSpecified = true
    end
    if tbl.fashionWing == nil then
        tbl.fashionWingSpecified = false
        tbl.fashionWing = 0
    else
        tbl.fashionWingSpecified = true
    end
    if tbl.fashionWeapon == nil then
        tbl.fashionWeaponSpecified = false
        tbl.fashionWeapon = 0
    else
        tbl.fashionWeaponSpecified = true
    end
    if tbl.vipLevel == nil then
        tbl.vipLevelSpecified = false
        tbl.vipLevel = 0
    else
        tbl.vipLevelSpecified = true
    end
    if tbl.activeMonthCard == nil then
        tbl.activeMonthCardSpecified = false
        tbl.activeMonthCard = 0
    else
        tbl.activeMonthCardSpecified = true
    end
    if tbl.treasure == nil then
        tbl.treasureSpecified = false
        tbl.treasure = 0
    else
        tbl.treasureSpecified = true
    end
    if tbl.szSuitId == nil then
        tbl.szSuitIdSpecified = false
        tbl.szSuitId = 0
    else
        tbl.szSuitIdSpecified = true
    end
    if tbl.online == nil then
        tbl.onlineSpecified = false
        tbl.online = false
    else
        tbl.onlineSpecified = true
    end
    if tbl.joinTime == nil then
        tbl.joinTimeSpecified = false
        tbl.joinTime = 0
    else
        tbl.joinTimeSpecified = true
    end
    if tbl.activeToday == nil then
        tbl.activeTodaySpecified = false
        tbl.activeToday = 0
    else
        tbl.activeTodaySpecified = true
    end
    if tbl.activeYesterday == nil then
        tbl.activeYesterdaySpecified = false
        tbl.activeYesterday = 0
    else
        tbl.activeYesterdaySpecified = true
    end
    if tbl.active3Days == nil then
        tbl.active3DaysSpecified = false
        tbl.active3Days = 0
    else
        tbl.active3DaysSpecified = true
    end
    if tbl.active7Days == nil then
        tbl.active7DaysSpecified = false
        tbl.active7Days = 0
    else
        tbl.active7DaysSpecified = true
    end
    if tbl.canSendVoice == nil then
        tbl.canSendVoiceSpecified = false
        tbl.canSendVoice = false
    else
        tbl.canSendVoiceSpecified = true
    end
    if tbl.voiceOpen == nil then
        tbl.voiceOpenSpecified = false
        tbl.voiceOpen = false
    else
        tbl.voiceOpenSpecified = true
    end
    if tbl.speakerOpen == nil then
        tbl.speakerOpenSpecified = false
        tbl.speakerOpen = false
    else
        tbl.speakerOpenSpecified = true
    end
    if tbl.vipMemberLevel == nil then
        tbl.vipMemberLevelSpecified = false
        tbl.vipMemberLevel = 0
    else
        tbl.vipMemberLevelSpecified = true
    end
end

--region metatable unionV2.ApplyListInfo
---@type unionV2.ApplyListInfo
unionV2_adj.metatable_ApplyListInfo = {
    _ClassName = "unionV2.ApplyListInfo",
}
unionV2_adj.metatable_ApplyListInfo.__index = unionV2_adj.metatable_ApplyListInfo
--endregion

---@param tbl unionV2.ApplyListInfo 待调整的table数据
function unionV2_adj.AdjustApplyListInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ApplyListInfo)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.memberName == nil then
        tbl.memberNameSpecified = false
        tbl.memberName = ""
    else
        tbl.memberNameSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.memberLevel == nil then
        tbl.memberLevelSpecified = false
        tbl.memberLevel = 0
    else
        tbl.memberLevelSpecified = true
    end
    if tbl.fightValue == nil then
        tbl.fightValueSpecified = false
        tbl.fightValue = 0
    else
        tbl.fightValueSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.vipLevel == nil then
        tbl.vipLevelSpecified = false
        tbl.vipLevel = 0
    else
        tbl.vipLevelSpecified = true
    end
    if tbl.monthCard == nil then
        tbl.monthCardSpecified = false
        tbl.monthCard = 0
    else
        tbl.monthCardSpecified = true
    end
    if tbl.theTime == nil then
        tbl.theTimeSpecified = false
        tbl.theTime = 0
    else
        tbl.theTimeSpecified = true
    end
    if tbl.hasRefuse == nil then
        tbl.hasRefuseSpecified = false
        tbl.hasRefuse = false
    else
        tbl.hasRefuseSpecified = true
    end
end

--region metatable unionV2.UnionBossInfo
---@type unionV2.UnionBossInfo
unionV2_adj.metatable_UnionBossInfo = {
    _ClassName = "unionV2.UnionBossInfo",
}
unionV2_adj.metatable_UnionBossInfo.__index = unionV2_adj.metatable_UnionBossInfo
--endregion

---@param tbl unionV2.UnionBossInfo 待调整的table数据
function unionV2_adj.AdjustUnionBossInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionBossInfo)
    if tbl.instanceUniqueId == nil then
        tbl.instanceUniqueIdSpecified = false
        tbl.instanceUniqueId = 0
    else
        tbl.instanceUniqueIdSpecified = true
    end
    if tbl.instanceId == nil then
        tbl.instanceIdSpecified = false
        tbl.instanceId = 0
    else
        tbl.instanceIdSpecified = true
    end
    if tbl.monsterHp == nil then
        tbl.monsterHpSpecified = false
        tbl.monsterHp = 0
    else
        tbl.monsterHpSpecified = true
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
end

--region metatable unionV2.UnionChallengeRank
---@type unionV2.UnionChallengeRank
unionV2_adj.metatable_UnionChallengeRank = {
    _ClassName = "unionV2.UnionChallengeRank",
}
unionV2_adj.metatable_UnionChallengeRank.__index = unionV2_adj.metatable_UnionChallengeRank
--endregion

---@param tbl unionV2.UnionChallengeRank 待调整的table数据
function unionV2_adj.AdjustUnionChallengeRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionChallengeRank)
    if tbl.roleName == nil then
        tbl.roleNameSpecified = false
        tbl.roleName = ""
    else
        tbl.roleNameSpecified = true
    end
    if tbl.fightValue == nil then
        tbl.fightValueSpecified = false
        tbl.fightValue = 0
    else
        tbl.fightValueSpecified = true
    end
    if tbl.floor == nil then
        tbl.floorSpecified = false
        tbl.floor = 0
    else
        tbl.floorSpecified = true
    end
end

--region metatable unionV2.UnionTotemInfo
---@type unionV2.UnionTotemInfo
unionV2_adj.metatable_UnionTotemInfo = {
    _ClassName = "unionV2.UnionTotemInfo",
}
unionV2_adj.metatable_UnionTotemInfo.__index = unionV2_adj.metatable_UnionTotemInfo
--endregion

---@param tbl unionV2.UnionTotemInfo 待调整的table数据
function unionV2_adj.AdjustUnionTotemInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionTotemInfo)
    if tbl.group == nil then
        tbl.groupSpecified = false
        tbl.group = 0
    else
        tbl.groupSpecified = true
    end
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
end

--region metatable unionV2.LingBaoInfo
---@type unionV2.LingBaoInfo
unionV2_adj.metatable_LingBaoInfo = {
    _ClassName = "unionV2.LingBaoInfo",
}
unionV2_adj.metatable_LingBaoInfo.__index = unionV2_adj.metatable_LingBaoInfo
--endregion

---@param tbl unionV2.LingBaoInfo 待调整的table数据
function unionV2_adj.AdjustLingBaoInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_LingBaoInfo)
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.nowExp == nil then
        tbl.nowExpSpecified = false
        tbl.nowExp = ""
    else
        tbl.nowExpSpecified = true
    end
    if tbl.totalExp == nil then
        tbl.totalExpSpecified = false
        tbl.totalExp = 0
    else
        tbl.totalExpSpecified = true
    end
    if tbl.refineLv == nil then
        tbl.refineLvSpecified = false
        tbl.refineLv = 0
    else
        tbl.refineLvSpecified = true
    end
    if tbl.power == nil then
        tbl.powerSpecified = false
        tbl.power = 0
    else
        tbl.powerSpecified = true
    end
end

--region metatable unionV2.JiPinInfo
---@type unionV2.JiPinInfo
unionV2_adj.metatable_JiPinInfo = {
    _ClassName = "unionV2.JiPinInfo",
}
unionV2_adj.metatable_JiPinInfo.__index = unionV2_adj.metatable_JiPinInfo
--endregion

---@param tbl unionV2.JiPinInfo 待调整的table数据
function unionV2_adj.AdjustJiPinInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_JiPinInfo)
    if tbl.power == nil then
        tbl.powerSpecified = false
        tbl.power = 0
    else
        tbl.powerSpecified = true
    end
    if tbl.attributeType == nil then
        tbl.attributeType = {}
    end
    if tbl.attributeValue == nil then
        tbl.attributeValue = {}
    end
end

--region metatable unionV2.FromInfo
---@type unionV2.FromInfo
unionV2_adj.metatable_FromInfo = {
    _ClassName = "unionV2.FromInfo",
}
unionV2_adj.metatable_FromInfo.__index = unionV2_adj.metatable_FromInfo
--endregion

---@param tbl unionV2.FromInfo 待调整的table数据
function unionV2_adj.AdjustFromInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_FromInfo)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.params == nil then
        tbl.params = {}
    end
end

--region metatable unionV2.BestAttInfo
---@type unionV2.BestAttInfo
unionV2_adj.metatable_BestAttInfo = {
    _ClassName = "unionV2.BestAttInfo",
}
unionV2_adj.metatable_BestAttInfo.__index = unionV2_adj.metatable_BestAttInfo
--endregion

---@param tbl unionV2.BestAttInfo 待调整的table数据
function unionV2_adj.AdjustBestAttInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_BestAttInfo)
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

--region metatable unionV2.ItemAttribute
---@type unionV2.ItemAttribute
unionV2_adj.metatable_ItemAttribute = {
    _ClassName = "unionV2.ItemAttribute",
}
unionV2_adj.metatable_ItemAttribute.__index = unionV2_adj.metatable_ItemAttribute
--endregion

---@param tbl unionV2.ItemAttribute 待调整的table数据
function unionV2_adj.AdjustItemAttribute(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ItemAttribute)
end

--region metatable unionV2.CoinInfo
---@type unionV2.CoinInfo
unionV2_adj.metatable_CoinInfo = {
    _ClassName = "unionV2.CoinInfo",
}
unionV2_adj.metatable_CoinInfo.__index = unionV2_adj.metatable_CoinInfo
--endregion

---@param tbl unionV2.CoinInfo 待调整的table数据
function unionV2_adj.AdjustCoinInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_CoinInfo)
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
end

--region metatable unionV2.UnionWarehouseUpdateRecordInfo
---@type unionV2.UnionWarehouseUpdateRecordInfo
unionV2_adj.metatable_UnionWarehouseUpdateRecordInfo = {
    _ClassName = "unionV2.UnionWarehouseUpdateRecordInfo",
}
unionV2_adj.metatable_UnionWarehouseUpdateRecordInfo.__index = unionV2_adj.metatable_UnionWarehouseUpdateRecordInfo
--endregion

---@param tbl unionV2.UnionWarehouseUpdateRecordInfo 待调整的table数据
function unionV2_adj.AdjustUnionWarehouseUpdateRecordInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionWarehouseUpdateRecordInfo)
    if tbl.roleName == nil then
        tbl.roleNameSpecified = false
        tbl.roleName = ""
    else
        tbl.roleNameSpecified = true
    end
    if tbl.operationTime == nil then
        tbl.operationTimeSpecified = false
        tbl.operationTime = 0
    else
        tbl.operationTimeSpecified = true
    end
    if tbl.operationType == nil then
        tbl.operationTypeSpecified = false
        tbl.operationType = 0
    else
        tbl.operationTypeSpecified = true
    end
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
end

--region metatable unionV2.ReqApplyForEnterUnion
---@type unionV2.ReqApplyForEnterUnion
unionV2_adj.metatable_ReqApplyForEnterUnion = {
    _ClassName = "unionV2.ReqApplyForEnterUnion",
}
unionV2_adj.metatable_ReqApplyForEnterUnion.__index = unionV2_adj.metatable_ReqApplyForEnterUnion
--endregion

---@param tbl unionV2.ReqApplyForEnterUnion 待调整的table数据
function unionV2_adj.AdjustReqApplyForEnterUnion(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqApplyForEnterUnion)
end

--region metatable unionV2.ReqCreateUnion
---@type unionV2.ReqCreateUnion
unionV2_adj.metatable_ReqCreateUnion = {
    _ClassName = "unionV2.ReqCreateUnion",
}
unionV2_adj.metatable_ReqCreateUnion.__index = unionV2_adj.metatable_ReqCreateUnion
--endregion

---@param tbl unionV2.ReqCreateUnion 待调整的table数据
function unionV2_adj.AdjustReqCreateUnion(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqCreateUnion)
end

--region metatable unionV2.ResSendCreateUnionSuccess
---@type unionV2.ResSendCreateUnionSuccess
unionV2_adj.metatable_ResSendCreateUnionSuccess = {
    _ClassName = "unionV2.ResSendCreateUnionSuccess",
}
unionV2_adj.metatable_ResSendCreateUnionSuccess.__index = unionV2_adj.metatable_ResSendCreateUnionSuccess
--endregion

---@param tbl unionV2.ResSendCreateUnionSuccess 待调整的table数据
function unionV2_adj.AdjustResSendCreateUnionSuccess(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResSendCreateUnionSuccess)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
end

--region metatable unionV2.ElectionInfo
---@type unionV2.ElectionInfo
unionV2_adj.metatable_ElectionInfo = {
    _ClassName = "unionV2.ElectionInfo",
}
unionV2_adj.metatable_ElectionInfo.__index = unionV2_adj.metatable_ElectionInfo
--endregion

---@param tbl unionV2.ElectionInfo 待调整的table数据
function unionV2_adj.AdjustElectionInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ElectionInfo)
end

--region metatable unionV2.ResSendPlayerUnionInfo
---@type unionV2.ResSendPlayerUnionInfo
unionV2_adj.metatable_ResSendPlayerUnionInfo = {
    _ClassName = "unionV2.ResSendPlayerUnionInfo",
}
unionV2_adj.metatable_ResSendPlayerUnionInfo.__index = unionV2_adj.metatable_ResSendPlayerUnionInfo
--endregion

---@param tbl unionV2.ResSendPlayerUnionInfo 待调整的table数据
function unionV2_adj.AdjustResSendPlayerUnionInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResSendPlayerUnionInfo)
    if tbl.unionInfo == nil then
        tbl.unionInfoSpecified = false
        tbl.unionInfo = nil
    else
        if tbl.unionInfoSpecified == nil then 
            tbl.unionInfoSpecified = true
            if unionV2_adj.AdjustUnionInfo ~= nil then
                unionV2_adj.AdjustUnionInfo(tbl.unionInfo)
            end
        end
    end
    if tbl.unionScore == nil then
        tbl.unionScoreSpecified = false
        tbl.unionScore = 0
    else
        tbl.unionScoreSpecified = true
    end
    if tbl.positionInfo == nil then
        tbl.positionInfoSpecified = false
        tbl.positionInfo = ""
    else
        tbl.positionInfoSpecified = true
    end
    if tbl.memberInfo == nil then
        tbl.memberInfo = {}
    else
        if unionV2_adj.AdjustUnionMemberInfo ~= nil then
            for i = 1, #tbl.memberInfo do
                unionV2_adj.AdjustUnionMemberInfo(tbl.memberInfo[i])
            end
        end
    end
    if tbl.unionSetting == nil then
        tbl.unionSetting = {}
    else
        if unionV2_adj.AdjustUnionSettingInfo ~= nil then
            for i = 1, #tbl.unionSetting do
                unionV2_adj.AdjustUnionSettingInfo(tbl.unionSetting[i])
            end
        end
    end
    if tbl.unionEventBean == nil then
        tbl.unionEventBean = {}
    else
        if unionV2_adj.AdjustUnionEventInfo ~= nil then
            for i = 1, #tbl.unionEventBean do
                unionV2_adj.AdjustUnionEventInfo(tbl.unionEventBean[i])
            end
        end
    end
    if tbl.myPositionInfo == nil then
        tbl.myPositionInfoSpecified = false
        tbl.myPositionInfo = 0
    else
        tbl.myPositionInfoSpecified = true
    end
    if tbl.leaderId == nil then
        tbl.leaderIdSpecified = false
        tbl.leaderId = 0
    else
        tbl.leaderIdSpecified = true
    end
    if tbl.isInElection == nil then
        tbl.isInElectionSpecified = false
        tbl.isInElection = false
    else
        tbl.isInElectionSpecified = true
    end
    if tbl.electionEndTime == nil then
        tbl.electionEndTimeSpecified = false
        tbl.electionEndTime = 0
    else
        tbl.electionEndTimeSpecified = true
    end
    if tbl.election == nil then
        tbl.election = {}
    else
        if unionV2_adj.AdjustElectionInfo ~= nil then
            for i = 1, #tbl.election do
                unionV2_adj.AdjustElectionInfo(tbl.election[i])
            end
        end
    end
    if tbl.myYesterdayTax == nil then
        tbl.myYesterdayTaxSpecified = false
        tbl.myYesterdayTax = 0
    else
        tbl.myYesterdayTaxSpecified = true
    end
    if tbl.totalActiveToday == nil then
        tbl.totalActiveTodaySpecified = false
        tbl.totalActiveToday = 0
    else
        tbl.totalActiveTodaySpecified = true
    end
    if tbl.totalActiveYesterday == nil then
        tbl.totalActiveYesterdaySpecified = false
        tbl.totalActiveYesterday = 0
    else
        tbl.totalActiveYesterdaySpecified = true
    end
    if tbl.myTaxSalaryGet == nil then
        tbl.myTaxSalaryGetSpecified = false
        tbl.myTaxSalaryGet = false
    else
        tbl.myTaxSalaryGetSpecified = true
    end
    if tbl.activeGetCountToday == nil then
        tbl.activeGetCountToday = {}
    end
    if tbl.realTimeTax == nil then
        tbl.realTimeTaxSpecified = false
        tbl.realTimeTax = 0
    else
        tbl.realTimeTaxSpecified = true
    end
    if tbl.todayKickOutCount == nil then
        tbl.todayKickOutCountSpecified = false
        tbl.todayKickOutCount = 0
    else
        tbl.todayKickOutCountSpecified = true
    end
    if tbl.activeRewardGet == nil then
        tbl.activeRewardGetSpecified = false
        tbl.activeRewardGet = 0
    else
        tbl.activeRewardGetSpecified = true
    end
end

--region metatable unionV2.ActiveRewardGet
---@type unionV2.ActiveRewardGet
unionV2_adj.metatable_ActiveRewardGet = {
    _ClassName = "unionV2.ActiveRewardGet",
}
unionV2_adj.metatable_ActiveRewardGet.__index = unionV2_adj.metatable_ActiveRewardGet
--endregion

---@param tbl unionV2.ActiveRewardGet 待调整的table数据
function unionV2_adj.AdjustActiveRewardGet(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ActiveRewardGet)
    if tbl.activeId == nil then
        tbl.activeIdSpecified = false
        tbl.activeId = 0
    else
        tbl.activeIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.maxCount == nil then
        tbl.maxCountSpecified = false
        tbl.maxCount = 0
    else
        tbl.maxCountSpecified = true
    end
end

--region metatable unionV2.ReqElectionVote
---@type unionV2.ReqElectionVote
unionV2_adj.metatable_ReqElectionVote = {
    _ClassName = "unionV2.ReqElectionVote",
}
unionV2_adj.metatable_ReqElectionVote.__index = unionV2_adj.metatable_ReqElectionVote
--endregion

---@param tbl unionV2.ReqElectionVote 待调整的table数据
function unionV2_adj.AdjustReqElectionVote(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqElectionVote)
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 1
    else
        tbl.countSpecified = true
    end
end

--region metatable unionV2.ReqChangeAnnouncement
---@type unionV2.ReqChangeAnnouncement
unionV2_adj.metatable_ReqChangeAnnouncement = {
    _ClassName = "unionV2.ReqChangeAnnouncement",
}
unionV2_adj.metatable_ReqChangeAnnouncement.__index = unionV2_adj.metatable_ReqChangeAnnouncement
--endregion

---@param tbl unionV2.ReqChangeAnnouncement 待调整的table数据
function unionV2_adj.AdjustReqChangeAnnouncement(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqChangeAnnouncement)
    if tbl.announcement == nil then
        tbl.announcementSpecified = false
        tbl.announcement = ""
    else
        tbl.announcementSpecified = true
    end
end

--region metatable unionV2.ReqKickOutMember
---@type unionV2.ReqKickOutMember
unionV2_adj.metatable_ReqKickOutMember = {
    _ClassName = "unionV2.ReqKickOutMember",
}
unionV2_adj.metatable_ReqKickOutMember.__index = unionV2_adj.metatable_ReqKickOutMember
--endregion

---@param tbl unionV2.ReqKickOutMember 待调整的table数据
function unionV2_adj.AdjustReqKickOutMember(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqKickOutMember)
    if tbl.memberId == nil then
        tbl.memberIdSpecified = false
        tbl.memberId = 0
    else
        tbl.memberIdSpecified = true
    end
end

--region metatable unionV2.ReqChangePosition
---@type unionV2.ReqChangePosition
unionV2_adj.metatable_ReqChangePosition = {
    _ClassName = "unionV2.ReqChangePosition",
}
unionV2_adj.metatable_ReqChangePosition.__index = unionV2_adj.metatable_ReqChangePosition
--endregion

---@param tbl unionV2.ReqChangePosition 待调整的table数据
function unionV2_adj.AdjustReqChangePosition(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqChangePosition)
    if tbl.memberId == nil then
        tbl.memberIdSpecified = false
        tbl.memberId = 0
    else
        tbl.memberIdSpecified = true
    end
    if tbl.position == nil then
        tbl.positionSpecified = false
        tbl.position = 0
    else
        tbl.positionSpecified = true
    end
end

--region metatable unionV2.ResSendApplyListInfo
---@type unionV2.ResSendApplyListInfo
unionV2_adj.metatable_ResSendApplyListInfo = {
    _ClassName = "unionV2.ResSendApplyListInfo",
}
unionV2_adj.metatable_ResSendApplyListInfo.__index = unionV2_adj.metatable_ResSendApplyListInfo
--endregion

---@param tbl unionV2.ResSendApplyListInfo 待调整的table数据
function unionV2_adj.AdjustResSendApplyListInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResSendApplyListInfo)
    if tbl.applyInfo == nil then
        tbl.applyInfo = {}
    else
        if unionV2_adj.AdjustApplyListInfo ~= nil then
            for i = 1, #tbl.applyInfo do
                unionV2_adj.AdjustApplyListInfo(tbl.applyInfo[i])
            end
        end
    end
end

--region metatable unionV2.ResSendChangeAnnounce
---@type unionV2.ResSendChangeAnnounce
unionV2_adj.metatable_ResSendChangeAnnounce = {
    _ClassName = "unionV2.ResSendChangeAnnounce",
}
unionV2_adj.metatable_ResSendChangeAnnounce.__index = unionV2_adj.metatable_ResSendChangeAnnounce
--endregion

---@param tbl unionV2.ResSendChangeAnnounce 待调整的table数据
function unionV2_adj.AdjustResSendChangeAnnounce(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResSendChangeAnnounce)
    if tbl.announce == nil then
        tbl.announceSpecified = false
        tbl.announce = ""
    else
        tbl.announceSpecified = true
    end
end

--region metatable unionV2.ResSendChangePosition
---@type unionV2.ResSendChangePosition
unionV2_adj.metatable_ResSendChangePosition = {
    _ClassName = "unionV2.ResSendChangePosition",
}
unionV2_adj.metatable_ResSendChangePosition.__index = unionV2_adj.metatable_ResSendChangePosition
--endregion

---@param tbl unionV2.ResSendChangePosition 待调整的table数据
function unionV2_adj.AdjustResSendChangePosition(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResSendChangePosition)
    if tbl.changePosition == nil then
        tbl.changePositionSpecified = false
        tbl.changePosition = nil
    else
        if tbl.changePositionSpecified == nil then 
            tbl.changePositionSpecified = true
            if unionV2_adj.AdjustUnionMemberInfo ~= nil then
                unionV2_adj.AdjustUnionMemberInfo(tbl.changePosition)
            end
        end
    end
    if tbl.leaderChange == nil then
        tbl.leaderChangeSpecified = false
        tbl.leaderChange = nil
    else
        if tbl.leaderChangeSpecified == nil then 
            tbl.leaderChangeSpecified = true
            if unionV2_adj.AdjustUnionMemberInfo ~= nil then
                unionV2_adj.AdjustUnionMemberInfo(tbl.leaderChange)
            end
        end
    end
    if tbl.position == nil then
        tbl.positionSpecified = false
        tbl.position = ""
    else
        tbl.positionSpecified = true
    end
end

--region metatable unionV2.ReqCheckApplyList
---@type unionV2.ReqCheckApplyList
unionV2_adj.metatable_ReqCheckApplyList = {
    _ClassName = "unionV2.ReqCheckApplyList",
}
unionV2_adj.metatable_ReqCheckApplyList.__index = unionV2_adj.metatable_ReqCheckApplyList
--endregion

---@param tbl unionV2.ReqCheckApplyList 待调整的table数据
function unionV2_adj.AdjustReqCheckApplyList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqCheckApplyList)
    if tbl.checkState == nil then
        tbl.checkStateSpecified = false
        tbl.checkState = 0
    else
        tbl.checkStateSpecified = true
    end
end

--region metatable unionV2.ResSendUnionActiveInfo
---@type unionV2.ResSendUnionActiveInfo
unionV2_adj.metatable_ResSendUnionActiveInfo = {
    _ClassName = "unionV2.ResSendUnionActiveInfo",
}
unionV2_adj.metatable_ResSendUnionActiveInfo.__index = unionV2_adj.metatable_ResSendUnionActiveInfo
--endregion

---@param tbl unionV2.ResSendUnionActiveInfo 待调整的table数据
function unionV2_adj.AdjustResSendUnionActiveInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResSendUnionActiveInfo)
    if tbl.activePoint == nil then
        tbl.activePointSpecified = false
        tbl.activePoint = 0
    else
        tbl.activePointSpecified = true
    end
    if tbl.activeId == nil then
        tbl.activeId = {}
    end
end

--region metatable unionV2.ReqGetUnionActiveReward
---@type unionV2.ReqGetUnionActiveReward
unionV2_adj.metatable_ReqGetUnionActiveReward = {
    _ClassName = "unionV2.ReqGetUnionActiveReward",
}
unionV2_adj.metatable_ReqGetUnionActiveReward.__index = unionV2_adj.metatable_ReqGetUnionActiveReward
--endregion

---@param tbl unionV2.ReqGetUnionActiveReward 待调整的table数据
function unionV2_adj.AdjustReqGetUnionActiveReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqGetUnionActiveReward)
    if tbl.activeId == nil then
        tbl.activeIdSpecified = false
        tbl.activeId = 0
    else
        tbl.activeIdSpecified = true
    end
end

--region metatable unionV2.ReqUnionSetUp
---@type unionV2.ReqUnionSetUp
unionV2_adj.metatable_ReqUnionSetUp = {
    _ClassName = "unionV2.ReqUnionSetUp",
}
unionV2_adj.metatable_ReqUnionSetUp.__index = unionV2_adj.metatable_ReqUnionSetUp
--endregion

---@param tbl unionV2.ReqUnionSetUp 待调整的table数据
function unionV2_adj.AdjustReqUnionSetUp(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqUnionSetUp)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.setValue == nil then
        tbl.setValueSpecified = false
        tbl.setValue = 0
    else
        tbl.setValueSpecified = true
    end
    if tbl.extraParam == nil then
        tbl.extraParamSpecified = false
        tbl.extraParam = 0
    else
        tbl.extraParamSpecified = true
    end
end

--region metatable unionV2.ResSendUnionSetUp
---@type unionV2.ResSendUnionSetUp
unionV2_adj.metatable_ResSendUnionSetUp = {
    _ClassName = "unionV2.ResSendUnionSetUp",
}
unionV2_adj.metatable_ResSendUnionSetUp.__index = unionV2_adj.metatable_ResSendUnionSetUp
--endregion

---@param tbl unionV2.ResSendUnionSetUp 待调整的table数据
function unionV2_adj.AdjustResSendUnionSetUp(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResSendUnionSetUp)
    if tbl.settingState == nil then
        tbl.settingStateSpecified = false
        tbl.settingState = nil
    else
        if tbl.settingStateSpecified == nil then 
            tbl.settingStateSpecified = true
            if unionV2_adj.AdjustUnionSettingInfo ~= nil then
                unionV2_adj.AdjustUnionSettingInfo(tbl.settingState)
            end
        end
    end
end

--region metatable unionV2.ResHasRewardInfo
---@type unionV2.ResHasRewardInfo
unionV2_adj.metatable_ResHasRewardInfo = {
    _ClassName = "unionV2.ResHasRewardInfo",
}
unionV2_adj.metatable_ResHasRewardInfo.__index = unionV2_adj.metatable_ResHasRewardInfo
--endregion

---@param tbl unionV2.ResHasRewardInfo 待调整的table数据
function unionV2_adj.AdjustResHasRewardInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResHasRewardInfo)
    if tbl.reward == nil then
        tbl.rewardSpecified = false
        tbl.reward = 0
    else
        tbl.rewardSpecified = true
    end
end

--region metatable unionV2.ResHasApplyInfo
---@type unionV2.ResHasApplyInfo
unionV2_adj.metatable_ResHasApplyInfo = {
    _ClassName = "unionV2.ResHasApplyInfo",
}
unionV2_adj.metatable_ResHasApplyInfo.__index = unionV2_adj.metatable_ResHasApplyInfo
--endregion

---@param tbl unionV2.ResHasApplyInfo 待调整的table数据
function unionV2_adj.AdjustResHasApplyInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResHasApplyInfo)
    if tbl.apply == nil then
        tbl.applySpecified = false
        tbl.apply = 0
    else
        tbl.applySpecified = true
    end
end

--region metatable unionV2.ResSendUnionBossInfo
---@type unionV2.ResSendUnionBossInfo
unionV2_adj.metatable_ResSendUnionBossInfo = {
    _ClassName = "unionV2.ResSendUnionBossInfo",
}
unionV2_adj.metatable_ResSendUnionBossInfo.__index = unionV2_adj.metatable_ResSendUnionBossInfo
--endregion

---@param tbl unionV2.ResSendUnionBossInfo 待调整的table数据
function unionV2_adj.AdjustResSendUnionBossInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResSendUnionBossInfo)
    if tbl.bossInfo == nil then
        tbl.bossInfo = {}
    else
        if unionV2_adj.AdjustUnionBossInfo ~= nil then
            for i = 1, #tbl.bossInfo do
                unionV2_adj.AdjustUnionBossInfo(tbl.bossInfo[i])
            end
        end
    end
    if tbl.callNum == nil then
        tbl.callNumSpecified = false
        tbl.callNum = 0
    else
        tbl.callNumSpecified = true
    end
    if tbl.aidNum == nil then
        tbl.aidNumSpecified = false
        tbl.aidNum = 0
    else
        tbl.aidNumSpecified = true
    end
end

--region metatable unionV2.ResSendUnionPersonChallengetInfo
---@type unionV2.ResSendUnionPersonChallengetInfo
unionV2_adj.metatable_ResSendUnionPersonChallengetInfo = {
    _ClassName = "unionV2.ResSendUnionPersonChallengetInfo",
}
unionV2_adj.metatable_ResSendUnionPersonChallengetInfo.__index = unionV2_adj.metatable_ResSendUnionPersonChallengetInfo
--endregion

---@param tbl unionV2.ResSendUnionPersonChallengetInfo 待调整的table数据
function unionV2_adj.AdjustResSendUnionPersonChallengetInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResSendUnionPersonChallengetInfo)
    if tbl.currentMonsterWeaken == nil then
        tbl.currentMonsterWeakenSpecified = false
        tbl.currentMonsterWeaken = 0
    else
        tbl.currentMonsterWeakenSpecified = true
    end
    if tbl.currentFloor == nil then
        tbl.currentFloorSpecified = false
        tbl.currentFloor = 0
    else
        tbl.currentFloorSpecified = true
    end
    if tbl.instanceId == nil then
        tbl.instanceIdSpecified = false
        tbl.instanceId = 0
    else
        tbl.instanceIdSpecified = true
    end
    if tbl.firstSuccess == nil then
        tbl.firstSuccessSpecified = false
        tbl.firstSuccess = ""
    else
        tbl.firstSuccessSpecified = true
    end
    if tbl.lifeMaxInstanceId == nil then
        tbl.lifeMaxInstanceIdSpecified = false
        tbl.lifeMaxInstanceId = 0
    else
        tbl.lifeMaxInstanceIdSpecified = true
    end
    if tbl.firstRewardInstanceId == nil then
        tbl.firstRewardInstanceIdSpecified = false
        tbl.firstRewardInstanceId = 0
    else
        tbl.firstRewardInstanceIdSpecified = true
    end
    if tbl.resetCount == nil then
        tbl.resetCountSpecified = false
        tbl.resetCount = 0
    else
        tbl.resetCountSpecified = true
    end
    if tbl.challengeBarrier == nil then
        tbl.challengeBarrierSpecified = false
        tbl.challengeBarrier = 0
    else
        tbl.challengeBarrierSpecified = true
    end
end

--region metatable unionV2.ResUnionChallengeNextInstance
---@type unionV2.ResUnionChallengeNextInstance
unionV2_adj.metatable_ResUnionChallengeNextInstance = {
    _ClassName = "unionV2.ResUnionChallengeNextInstance",
}
unionV2_adj.metatable_ResUnionChallengeNextInstance.__index = unionV2_adj.metatable_ResUnionChallengeNextInstance
--endregion

---@param tbl unionV2.ResUnionChallengeNextInstance 待调整的table数据
function unionV2_adj.AdjustResUnionChallengeNextInstance(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResUnionChallengeNextInstance)
    if tbl.nextInstanceId == nil then
        tbl.nextInstanceIdSpecified = false
        tbl.nextInstanceId = 0
    else
        tbl.nextInstanceIdSpecified = true
    end
end

--region metatable unionV2.ResSendUnionChallengetRank
---@type unionV2.ResSendUnionChallengetRank
unionV2_adj.metatable_ResSendUnionChallengetRank = {
    _ClassName = "unionV2.ResSendUnionChallengetRank",
}
unionV2_adj.metatable_ResSendUnionChallengetRank.__index = unionV2_adj.metatable_ResSendUnionChallengetRank
--endregion

---@param tbl unionV2.ResSendUnionChallengetRank 待调整的table数据
function unionV2_adj.AdjustResSendUnionChallengetRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResSendUnionChallengetRank)
    if tbl.rankInfo == nil then
        tbl.rankInfo = {}
    else
        if unionV2_adj.AdjustUnionChallengeRank ~= nil then
            for i = 1, #tbl.rankInfo do
                unionV2_adj.AdjustUnionChallengeRank(tbl.rankInfo[i])
            end
        end
    end
    if tbl.myRank == nil then
        tbl.myRankSpecified = false
        tbl.myRank = 0
    else
        tbl.myRankSpecified = true
    end
end

--region metatable unionV2.ResUnionInstanceOwner
---@type unionV2.ResUnionInstanceOwner
unionV2_adj.metatable_ResUnionInstanceOwner = {
    _ClassName = "unionV2.ResUnionInstanceOwner",
}
unionV2_adj.metatable_ResUnionInstanceOwner.__index = unionV2_adj.metatable_ResUnionInstanceOwner
--endregion

---@param tbl unionV2.ResUnionInstanceOwner 待调整的table数据
function unionV2_adj.AdjustResUnionInstanceOwner(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResUnionInstanceOwner)
    if tbl.ownerId == nil then
        tbl.ownerIdSpecified = false
        tbl.ownerId = 0
    else
        tbl.ownerIdSpecified = true
    end
end

--region metatable unionV2.ReqSendUnionRedPack
---@type unionV2.ReqSendUnionRedPack
unionV2_adj.metatable_ReqSendUnionRedPack = {
    _ClassName = "unionV2.ReqSendUnionRedPack",
}
unionV2_adj.metatable_ReqSendUnionRedPack.__index = unionV2_adj.metatable_ReqSendUnionRedPack
--endregion

---@param tbl unionV2.ReqSendUnionRedPack 待调整的table数据
function unionV2_adj.AdjustReqSendUnionRedPack(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqSendUnionRedPack)
    if tbl.money == nil then
        tbl.moneySpecified = false
        tbl.money = 0
    else
        tbl.moneySpecified = true
    end
    if tbl.content == nil then
        tbl.contentSpecified = false
        tbl.content = ""
    else
        tbl.contentSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable unionV2.ReqRobRedPack
---@type unionV2.ReqRobRedPack
unionV2_adj.metatable_ReqRobRedPack = {
    _ClassName = "unionV2.ReqRobRedPack",
}
unionV2_adj.metatable_ReqRobRedPack.__index = unionV2_adj.metatable_ReqRobRedPack
--endregion

---@param tbl unionV2.ReqRobRedPack 待调整的table数据
function unionV2_adj.AdjustReqRobRedPack(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqRobRedPack)
    if tbl.redPackId == nil then
        tbl.redPackIdSpecified = false
        tbl.redPackId = 0
    else
        tbl.redPackIdSpecified = true
    end
end

--region metatable unionV2.ResRobRedPack
---@type unionV2.ResRobRedPack
unionV2_adj.metatable_ResRobRedPack = {
    _ClassName = "unionV2.ResRobRedPack",
}
unionV2_adj.metatable_ResRobRedPack.__index = unionV2_adj.metatable_ResRobRedPack
--endregion

---@param tbl unionV2.ResRobRedPack 待调整的table数据
function unionV2_adj.AdjustResRobRedPack(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResRobRedPack)
    if tbl.sender == nil then
        tbl.senderSpecified = false
        tbl.sender = ""
    else
        tbl.senderSpecified = true
    end
    if tbl.senderCareer == nil then
        tbl.senderCareerSpecified = false
        tbl.senderCareer = 0
    else
        tbl.senderCareerSpecified = true
    end
    if tbl.sendSex == nil then
        tbl.sendSexSpecified = false
        tbl.sendSex = 0
    else
        tbl.sendSexSpecified = true
    end
    if tbl.money == nil then
        tbl.moneySpecified = false
        tbl.money = 0
    else
        tbl.moneySpecified = true
    end
    if tbl.getCount == nil then
        tbl.getCountSpecified = false
        tbl.getCount = 0
    else
        tbl.getCountSpecified = true
    end
    if tbl.maxCount == nil then
        tbl.maxCountSpecified = false
        tbl.maxCount = 0
    else
        tbl.maxCountSpecified = true
    end
    if tbl.getMoney == nil then
        tbl.getMoneySpecified = false
        tbl.getMoney = 0
    else
        tbl.getMoneySpecified = true
    end
    if tbl.maxMoney == nil then
        tbl.maxMoneySpecified = false
        tbl.maxMoney = 0
    else
        tbl.maxMoneySpecified = true
    end
    if tbl.content == nil then
        tbl.contentSpecified = false
        tbl.content = ""
    else
        tbl.contentSpecified = true
    end
    if tbl.yuanbao == nil then
        tbl.yuanbaoSpecified = false
        tbl.yuanbao = nil
    else
        if tbl.yuanbaoSpecified == nil then 
            tbl.yuanbaoSpecified = true
            if unionV2_adj.AdjustUnionRedPackRecordInfo ~= nil then
                unionV2_adj.AdjustUnionRedPackRecordInfo(tbl.yuanbao)
            end
        end
    end
end

--region metatable unionV2.ResOpenRedPackPanel
---@type unionV2.ResOpenRedPackPanel
unionV2_adj.metatable_ResOpenRedPackPanel = {
    _ClassName = "unionV2.ResOpenRedPackPanel",
}
unionV2_adj.metatable_ResOpenRedPackPanel.__index = unionV2_adj.metatable_ResOpenRedPackPanel
--endregion

---@param tbl unionV2.ResOpenRedPackPanel 待调整的table数据
function unionV2_adj.AdjustResOpenRedPackPanel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResOpenRedPackPanel)
    if tbl.todayCount == nil then
        tbl.todayCountSpecified = false
        tbl.todayCount = 0
    else
        tbl.todayCountSpecified = true
    end
    if tbl.todayMoney == nil then
        tbl.todayMoneySpecified = false
        tbl.todayMoney = 0
    else
        tbl.todayMoneySpecified = true
    end
    if tbl.redPackList == nil then
        tbl.redPackList = {}
    else
        if unionV2_adj.AdjustUnionRedPackInfo ~= nil then
            for i = 1, #tbl.redPackList do
                unionV2_adj.AdjustUnionRedPackInfo(tbl.redPackList[i])
            end
        end
    end
    if tbl.redPackRecordList == nil then
        tbl.redPackRecordList = {}
    else
        if unionV2_adj.AdjustUnionRedPackRecordInfo ~= nil then
            for i = 1, #tbl.redPackRecordList do
                unionV2_adj.AdjustUnionRedPackRecordInfo(tbl.redPackRecordList[i])
            end
        end
    end
end

--region metatable unionV2.ReqRedPackDetail
---@type unionV2.ReqRedPackDetail
unionV2_adj.metatable_ReqRedPackDetail = {
    _ClassName = "unionV2.ReqRedPackDetail",
}
unionV2_adj.metatable_ReqRedPackDetail.__index = unionV2_adj.metatable_ReqRedPackDetail
--endregion

---@param tbl unionV2.ReqRedPackDetail 待调整的table数据
function unionV2_adj.AdjustReqRedPackDetail(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqRedPackDetail)
    if tbl.redPackId == nil then
        tbl.redPackIdSpecified = false
        tbl.redPackId = 0
    else
        tbl.redPackIdSpecified = true
    end
end

--region metatable unionV2.ResCanGetCrossReward
---@type unionV2.ResCanGetCrossReward
unionV2_adj.metatable_ResCanGetCrossReward = {
    _ClassName = "unionV2.ResCanGetCrossReward",
}
unionV2_adj.metatable_ResCanGetCrossReward.__index = unionV2_adj.metatable_ResCanGetCrossReward
--endregion

---@param tbl unionV2.ResCanGetCrossReward 待调整的table数据
function unionV2_adj.AdjustResCanGetCrossReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResCanGetCrossReward)
    if tbl.floorId == nil then
        tbl.floorIdSpecified = false
        tbl.floorId = 0
    else
        tbl.floorIdSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable unionV2.ReqCallUnionBoss
---@type unionV2.ReqCallUnionBoss
unionV2_adj.metatable_ReqCallUnionBoss = {
    _ClassName = "unionV2.ReqCallUnionBoss",
}
unionV2_adj.metatable_ReqCallUnionBoss.__index = unionV2_adj.metatable_ReqCallUnionBoss
--endregion

---@param tbl unionV2.ReqCallUnionBoss 待调整的table数据
function unionV2_adj.AdjustReqCallUnionBoss(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqCallUnionBoss)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
end

--region metatable unionV2.ReqEnterUnionBoss
---@type unionV2.ReqEnterUnionBoss
unionV2_adj.metatable_ReqEnterUnionBoss = {
    _ClassName = "unionV2.ReqEnterUnionBoss",
}
unionV2_adj.metatable_ReqEnterUnionBoss.__index = unionV2_adj.metatable_ReqEnterUnionBoss
--endregion

---@param tbl unionV2.ReqEnterUnionBoss 待调整的table数据
function unionV2_adj.AdjustReqEnterUnionBoss(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqEnterUnionBoss)
    if tbl.line == nil then
        tbl.lineSpecified = false
        tbl.line = 0
    else
        tbl.lineSpecified = true
    end
end

--region metatable unionV2.ResUnionRedPackInfo
---@type unionV2.ResUnionRedPackInfo
unionV2_adj.metatable_ResUnionRedPackInfo = {
    _ClassName = "unionV2.ResUnionRedPackInfo",
}
unionV2_adj.metatable_ResUnionRedPackInfo.__index = unionV2_adj.metatable_ResUnionRedPackInfo
--endregion

---@param tbl unionV2.ResUnionRedPackInfo 待调整的table数据
function unionV2_adj.AdjustResUnionRedPackInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResUnionRedPackInfo)
    if tbl.redPackInfo == nil then
        tbl.redPackInfoSpecified = false
        tbl.redPackInfo = nil
    else
        if tbl.redPackInfoSpecified == nil then 
            tbl.redPackInfoSpecified = true
            if unionV2_adj.AdjustUnionRedPackInfo ~= nil then
                unionV2_adj.AdjustUnionRedPackInfo(tbl.redPackInfo)
            end
        end
    end
end

--region metatable unionV2.ReqImpeachLeader
---@type unionV2.ReqImpeachLeader
unionV2_adj.metatable_ReqImpeachLeader = {
    _ClassName = "unionV2.ReqImpeachLeader",
}
unionV2_adj.metatable_ReqImpeachLeader.__index = unionV2_adj.metatable_ReqImpeachLeader
--endregion

---@param tbl unionV2.ReqImpeachLeader 待调整的table数据
function unionV2_adj.AdjustReqImpeachLeader(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqImpeachLeader)
end

--region metatable unionV2.ReqChangeUnionName
---@type unionV2.ReqChangeUnionName
unionV2_adj.metatable_ReqChangeUnionName = {
    _ClassName = "unionV2.ReqChangeUnionName",
}
unionV2_adj.metatable_ReqChangeUnionName.__index = unionV2_adj.metatable_ReqChangeUnionName
--endregion

---@param tbl unionV2.ReqChangeUnionName 待调整的table数据
function unionV2_adj.AdjustReqChangeUnionName(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqChangeUnionName)
    if tbl.newUnionName == nil then
        tbl.newUnionNameSpecified = false
        tbl.newUnionName = ""
    else
        tbl.newUnionNameSpecified = true
    end
end

--region metatable unionV2.ResSendUnionAnnounceResult
---@type unionV2.ResSendUnionAnnounceResult
unionV2_adj.metatable_ResSendUnionAnnounceResult = {
    _ClassName = "unionV2.ResSendUnionAnnounceResult",
}
unionV2_adj.metatable_ResSendUnionAnnounceResult.__index = unionV2_adj.metatable_ResSendUnionAnnounceResult
--endregion

---@param tbl unionV2.ResSendUnionAnnounceResult 待调整的table数据
function unionV2_adj.AdjustResSendUnionAnnounceResult(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResSendUnionAnnounceResult)
    if tbl.callName == nil then
        tbl.callNameSpecified = false
        tbl.callName = ""
    else
        tbl.callNameSpecified = true
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
end

--region metatable unionV2.ResTotemInfo
---@type unionV2.ResTotemInfo
unionV2_adj.metatable_ResTotemInfo = {
    _ClassName = "unionV2.ResTotemInfo",
}
unionV2_adj.metatable_ResTotemInfo.__index = unionV2_adj.metatable_ResTotemInfo
--endregion

---@param tbl unionV2.ResTotemInfo 待调整的table数据
function unionV2_adj.AdjustResTotemInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResTotemInfo)
    if tbl.roleTotemList == nil then
        tbl.roleTotemList = {}
    else
        if unionV2_adj.AdjustUnionTotemInfo ~= nil then
            for i = 1, #tbl.roleTotemList do
                unionV2_adj.AdjustUnionTotemInfo(tbl.roleTotemList[i])
            end
        end
    end
end

--region metatable unionV2.ReqLevelUpUnionTotem
---@type unionV2.ReqLevelUpUnionTotem
unionV2_adj.metatable_ReqLevelUpUnionTotem = {
    _ClassName = "unionV2.ReqLevelUpUnionTotem",
}
unionV2_adj.metatable_ReqLevelUpUnionTotem.__index = unionV2_adj.metatable_ReqLevelUpUnionTotem
--endregion

---@param tbl unionV2.ReqLevelUpUnionTotem 待调整的table数据
function unionV2_adj.AdjustReqLevelUpUnionTotem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqLevelUpUnionTotem)
    if tbl.group == nil then
        tbl.groupSpecified = false
        tbl.group = 0
    else
        tbl.groupSpecified = true
    end
end

--region metatable unionV2.ResLevelUpUnionTotem
---@type unionV2.ResLevelUpUnionTotem
unionV2_adj.metatable_ResLevelUpUnionTotem = {
    _ClassName = "unionV2.ResLevelUpUnionTotem",
}
unionV2_adj.metatable_ResLevelUpUnionTotem.__index = unionV2_adj.metatable_ResLevelUpUnionTotem
--endregion

---@param tbl unionV2.ResLevelUpUnionTotem 待调整的table数据
function unionV2_adj.AdjustResLevelUpUnionTotem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResLevelUpUnionTotem)
    if tbl.totem == nil then
        tbl.totemSpecified = false
        tbl.totem = nil
    else
        if tbl.totemSpecified == nil then 
            tbl.totemSpecified = true
            if unionV2_adj.AdjustUnionTotemInfo ~= nil then
                unionV2_adj.AdjustUnionTotemInfo(tbl.totem)
            end
        end
    end
end

--region metatable unionV2.ReqInviteForEnterUnion
---@type unionV2.ReqInviteForEnterUnion
unionV2_adj.metatable_ReqInviteForEnterUnion = {
    _ClassName = "unionV2.ReqInviteForEnterUnion",
}
unionV2_adj.metatable_ReqInviteForEnterUnion.__index = unionV2_adj.metatable_ReqInviteForEnterUnion
--endregion

---@param tbl unionV2.ReqInviteForEnterUnion 待调整的table数据
function unionV2_adj.AdjustReqInviteForEnterUnion(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqInviteForEnterUnion)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
end

--region metatable unionV2.ResInviteForEnterUnion
---@type unionV2.ResInviteForEnterUnion
unionV2_adj.metatable_ResInviteForEnterUnion = {
    _ClassName = "unionV2.ResInviteForEnterUnion",
}
unionV2_adj.metatable_ResInviteForEnterUnion.__index = unionV2_adj.metatable_ResInviteForEnterUnion
--endregion

---@param tbl unionV2.ResInviteForEnterUnion 待调整的table数据
function unionV2_adj.AdjustResInviteForEnterUnion(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResInviteForEnterUnion)
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
    if tbl.inviterName == nil then
        tbl.inviterNameSpecified = false
        tbl.inviterName = ""
    else
        tbl.inviterNameSpecified = true
    end
end

--region metatable unionV2.ReqAgreeUnionInvite
---@type unionV2.ReqAgreeUnionInvite
unionV2_adj.metatable_ReqAgreeUnionInvite = {
    _ClassName = "unionV2.ReqAgreeUnionInvite",
}
unionV2_adj.metatable_ReqAgreeUnionInvite.__index = unionV2_adj.metatable_ReqAgreeUnionInvite
--endregion

---@param tbl unionV2.ReqAgreeUnionInvite 待调整的table数据
function unionV2_adj.AdjustReqAgreeUnionInvite(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqAgreeUnionInvite)
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
end

--region metatable unionV2.ResUnionWarehouseInfo
---@type unionV2.ResUnionWarehouseInfo
unionV2_adj.metatable_ResUnionWarehouseInfo = {
    _ClassName = "unionV2.ResUnionWarehouseInfo",
}
unionV2_adj.metatable_ResUnionWarehouseInfo.__index = unionV2_adj.metatable_ResUnionWarehouseInfo
--endregion

---@param tbl unionV2.ResUnionWarehouseInfo 待调整的table数据
function unionV2_adj.AdjustResUnionWarehouseInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResUnionWarehouseInfo)
    if tbl.maxEquipGridCount == nil then
        tbl.maxEquipGridCountSpecified = false
        tbl.maxEquipGridCount = 0
    else
        tbl.maxEquipGridCountSpecified = true
    end
    if tbl.itemAllInfo == nil then
        tbl.itemAllInfo = {}
    else
        if unionV2_adj.AdjustOneItemAllInfo ~= nil then
            for i = 1, #tbl.itemAllInfo do
                unionV2_adj.AdjustOneItemAllInfo(tbl.itemAllInfo[i])
            end
        end
    end
    if tbl.equipLimit == nil then
        tbl.equipLimitSpecified = false
        tbl.equipLimit = 0
    else
        tbl.equipLimitSpecified = true
    end
    if tbl.unionScore == nil then
        tbl.unionScoreSpecified = false
        tbl.unionScore = 0
    else
        tbl.unionScoreSpecified = true
    end
end

--region metatable unionV2.OneItemAllInfo
---@type unionV2.OneItemAllInfo
unionV2_adj.metatable_OneItemAllInfo = {
    _ClassName = "unionV2.OneItemAllInfo",
}
unionV2_adj.metatable_OneItemAllInfo.__index = unionV2_adj.metatable_OneItemAllInfo
--endregion

---@param tbl unionV2.OneItemAllInfo 待调整的table数据
function unionV2_adj.AdjustOneItemAllInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_OneItemAllInfo)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.itemCount == nil then
        tbl.itemCountSpecified = false
        tbl.itemCount = 0
    else
        tbl.itemCountSpecified = true
    end
    if tbl.needMoney == nil then
        tbl.needMoneySpecified = false
        tbl.needMoney = 0
    else
        tbl.needMoneySpecified = true
    end
end

--region metatable unionV2.ReqGetBagItemInfo
---@type unionV2.ReqGetBagItemInfo
unionV2_adj.metatable_ReqGetBagItemInfo = {
    _ClassName = "unionV2.ReqGetBagItemInfo",
}
unionV2_adj.metatable_ReqGetBagItemInfo.__index = unionV2_adj.metatable_ReqGetBagItemInfo
--endregion

---@param tbl unionV2.ReqGetBagItemInfo 待调整的table数据
function unionV2_adj.AdjustReqGetBagItemInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqGetBagItemInfo)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
end

--region metatable unionV2.ResGetBagItemInfo
---@type unionV2.ResGetBagItemInfo
unionV2_adj.metatable_ResGetBagItemInfo = {
    _ClassName = "unionV2.ResGetBagItemInfo",
}
unionV2_adj.metatable_ResGetBagItemInfo.__index = unionV2_adj.metatable_ResGetBagItemInfo
--endregion

---@param tbl unionV2.ResGetBagItemInfo 待调整的table数据
function unionV2_adj.AdjustResGetBagItemInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResGetBagItemInfo)
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

--region metatable unionV2.ReqDonateEquip
---@type unionV2.ReqDonateEquip
unionV2_adj.metatable_ReqDonateEquip = {
    _ClassName = "unionV2.ReqDonateEquip",
}
unionV2_adj.metatable_ReqDonateEquip.__index = unionV2_adj.metatable_ReqDonateEquip
--endregion

---@param tbl unionV2.ReqDonateEquip 待调整的table数据
function unionV2_adj.AdjustReqDonateEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqDonateEquip)
    if tbl.EquipmentId == nil then
        tbl.EquipmentIdSpecified = false
        tbl.EquipmentId = 0
    else
        tbl.EquipmentIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 1
    else
        tbl.countSpecified = true
    end
end

--region metatable unionV2.ReqConversionEquip
---@type unionV2.ReqConversionEquip
unionV2_adj.metatable_ReqConversionEquip = {
    _ClassName = "unionV2.ReqConversionEquip",
}
unionV2_adj.metatable_ReqConversionEquip.__index = unionV2_adj.metatable_ReqConversionEquip
--endregion

---@param tbl unionV2.ReqConversionEquip 待调整的table数据
function unionV2_adj.AdjustReqConversionEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqConversionEquip)
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
    if tbl.EquipLid == nil then
        tbl.EquipLid = {}
    end
end

--region metatable unionV2.ReqDestoryEquip
---@type unionV2.ReqDestoryEquip
unionV2_adj.metatable_ReqDestoryEquip = {
    _ClassName = "unionV2.ReqDestoryEquip",
}
unionV2_adj.metatable_ReqDestoryEquip.__index = unionV2_adj.metatable_ReqDestoryEquip
--endregion

---@param tbl unionV2.ReqDestoryEquip 待调整的table数据
function unionV2_adj.AdjustReqDestoryEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqDestoryEquip)
    if tbl.EquipLid == nil then
        tbl.EquipLidSpecified = false
        tbl.EquipLid = 0
    else
        tbl.EquipLidSpecified = true
    end
end

--region metatable unionV2.ResIntegral
---@type unionV2.ResIntegral
unionV2_adj.metatable_ResIntegral = {
    _ClassName = "unionV2.ResIntegral",
}
unionV2_adj.metatable_ResIntegral.__index = unionV2_adj.metatable_ResIntegral
--endregion

---@param tbl unionV2.ResIntegral 待调整的table数据
function unionV2_adj.AdjustResIntegral(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResIntegral)
    if tbl.integralInfo == nil then
        tbl.integralInfo = {}
    else
        if unionV2_adj.AdjustUnionWarehouseUpdateRecordInfo ~= nil then
            for i = 1, #tbl.integralInfo do
                unionV2_adj.AdjustUnionWarehouseUpdateRecordInfo(tbl.integralInfo[i])
            end
        end
    end
end

--region metatable unionV2.ReqGetPlayerUnionInfo
---@type unionV2.ReqGetPlayerUnionInfo
unionV2_adj.metatable_ReqGetPlayerUnionInfo = {
    _ClassName = "unionV2.ReqGetPlayerUnionInfo",
}
unionV2_adj.metatable_ReqGetPlayerUnionInfo.__index = unionV2_adj.metatable_ReqGetPlayerUnionInfo
--endregion

---@param tbl unionV2.ReqGetPlayerUnionInfo 待调整的table数据
function unionV2_adj.AdjustReqGetPlayerUnionInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqGetPlayerUnionInfo)
    if tbl.roleId == nil then
        tbl.roleId = {}
    end
end

--region metatable unionV2.ReqGetApplyListInfo
---@type unionV2.ReqGetApplyListInfo
unionV2_adj.metatable_ReqGetApplyListInfo = {
    _ClassName = "unionV2.ReqGetApplyListInfo",
}
unionV2_adj.metatable_ReqGetApplyListInfo.__index = unionV2_adj.metatable_ReqGetApplyListInfo
--endregion

---@param tbl unionV2.ReqGetApplyListInfo 待调整的table数据
function unionV2_adj.AdjustReqGetApplyListInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqGetApplyListInfo)
    if tbl.roleId == nil then
        tbl.roleId = {}
    end
end

--region metatable unionV2.ResDonateMoney
---@type unionV2.ResDonateMoney
unionV2_adj.metatable_ResDonateMoney = {
    _ClassName = "unionV2.ResDonateMoney",
}
unionV2_adj.metatable_ResDonateMoney.__index = unionV2_adj.metatable_ResDonateMoney
--endregion

---@param tbl unionV2.ResDonateMoney 待调整的table数据
function unionV2_adj.AdjustResDonateMoney(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResDonateMoney)
end

--region metatable unionV2.ReqDonateMoney
---@type unionV2.ReqDonateMoney
unionV2_adj.metatable_ReqDonateMoney = {
    _ClassName = "unionV2.ReqDonateMoney",
}
unionV2_adj.metatable_ReqDonateMoney.__index = unionV2_adj.metatable_ReqDonateMoney
--endregion

---@param tbl unionV2.ReqDonateMoney 待调整的table数据
function unionV2_adj.AdjustReqDonateMoney(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqDonateMoney)
end

--region metatable unionV2.ResUnionUpGrade
---@type unionV2.ResUnionUpGrade
unionV2_adj.metatable_ResUnionUpGrade = {
    _ClassName = "unionV2.ResUnionUpGrade",
}
unionV2_adj.metatable_ResUnionUpGrade.__index = unionV2_adj.metatable_ResUnionUpGrade
--endregion

---@param tbl unionV2.ResUnionUpGrade 待调整的table数据
function unionV2_adj.AdjustResUnionUpGrade(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResUnionUpGrade)
end

--region metatable unionV2.ReqQuitOrDissolveUnion
---@type unionV2.ReqQuitOrDissolveUnion
unionV2_adj.metatable_ReqQuitOrDissolveUnion = {
    _ClassName = "unionV2.ReqQuitOrDissolveUnion",
}
unionV2_adj.metatable_ReqQuitOrDissolveUnion.__index = unionV2_adj.metatable_ReqQuitOrDissolveUnion
--endregion

---@param tbl unionV2.ReqQuitOrDissolveUnion 待调整的table数据
function unionV2_adj.AdjustReqQuitOrDissolveUnion(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqQuitOrDissolveUnion)
    if tbl.quitType == nil then
        tbl.quitTypeSpecified = false
        tbl.quitType = 0
    else
        tbl.quitTypeSpecified = true
    end
end

--region metatable unionV2.ResSendQuitUnionSuccess
---@type unionV2.ResSendQuitUnionSuccess
unionV2_adj.metatable_ResSendQuitUnionSuccess = {
    _ClassName = "unionV2.ResSendQuitUnionSuccess",
}
unionV2_adj.metatable_ResSendQuitUnionSuccess.__index = unionV2_adj.metatable_ResSendQuitUnionSuccess
--endregion

---@param tbl unionV2.ResSendQuitUnionSuccess 待调整的table数据
function unionV2_adj.AdjustResSendQuitUnionSuccess(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResSendQuitUnionSuccess)
end

--region metatable unionV2.ResDissolveUnion
---@type unionV2.ResDissolveUnion
unionV2_adj.metatable_ResDissolveUnion = {
    _ClassName = "unionV2.ResDissolveUnion",
}
unionV2_adj.metatable_ResDissolveUnion.__index = unionV2_adj.metatable_ResDissolveUnion
--endregion

---@param tbl unionV2.ResDissolveUnion 待调整的table数据
function unionV2_adj.AdjustResDissolveUnion(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResDissolveUnion)
end

--region metatable unionV2.ReqGetAssistantOnlineUnionInfo
---@type unionV2.ReqGetAssistantOnlineUnionInfo
unionV2_adj.metatable_ReqGetAssistantOnlineUnionInfo = {
    _ClassName = "unionV2.ReqGetAssistantOnlineUnionInfo",
}
unionV2_adj.metatable_ReqGetAssistantOnlineUnionInfo.__index = unionV2_adj.metatable_ReqGetAssistantOnlineUnionInfo
--endregion

---@param tbl unionV2.ReqGetAssistantOnlineUnionInfo 待调整的table数据
function unionV2_adj.AdjustReqGetAssistantOnlineUnionInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqGetAssistantOnlineUnionInfo)
end

--region metatable unionV2.ReqUnionMemberInfo
---@type unionV2.ReqUnionMemberInfo
unionV2_adj.metatable_ReqUnionMemberInfo = {
    _ClassName = "unionV2.ReqUnionMemberInfo",
}
unionV2_adj.metatable_ReqUnionMemberInfo.__index = unionV2_adj.metatable_ReqUnionMemberInfo
--endregion

---@param tbl unionV2.ReqUnionMemberInfo 待调整的table数据
function unionV2_adj.AdjustReqUnionMemberInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqUnionMemberInfo)
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
end

--region metatable unionV2.ResUnionMemberInfo
---@type unionV2.ResUnionMemberInfo
unionV2_adj.metatable_ResUnionMemberInfo = {
    _ClassName = "unionV2.ResUnionMemberInfo",
}
unionV2_adj.metatable_ResUnionMemberInfo.__index = unionV2_adj.metatable_ResUnionMemberInfo
--endregion

---@param tbl unionV2.ResUnionMemberInfo 待调整的table数据
function unionV2_adj.AdjustResUnionMemberInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResUnionMemberInfo)
    if tbl.memberInfo == nil then
        tbl.memberInfo = {}
    else
        if unionV2_adj.AdjustUnionMemberInfo ~= nil then
            for i = 1, #tbl.memberInfo do
                unionV2_adj.AdjustUnionMemberInfo(tbl.memberInfo[i])
            end
        end
    end
end

--region metatable unionV2.ReqIgnoreAllRole
---@type unionV2.ReqIgnoreAllRole
unionV2_adj.metatable_ReqIgnoreAllRole = {
    _ClassName = "unionV2.ReqIgnoreAllRole",
}
unionV2_adj.metatable_ReqIgnoreAllRole.__index = unionV2_adj.metatable_ReqIgnoreAllRole
--endregion

---@param tbl unionV2.ReqIgnoreAllRole 待调整的table数据
function unionV2_adj.AdjustReqIgnoreAllRole(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqIgnoreAllRole)
end

--region metatable unionV2.ReqAgreeAllRoleJoinUnion
---@type unionV2.ReqAgreeAllRoleJoinUnion
unionV2_adj.metatable_ReqAgreeAllRoleJoinUnion = {
    _ClassName = "unionV2.ReqAgreeAllRoleJoinUnion",
}
unionV2_adj.metatable_ReqAgreeAllRoleJoinUnion.__index = unionV2_adj.metatable_ReqAgreeAllRoleJoinUnion
--endregion

---@param tbl unionV2.ReqAgreeAllRoleJoinUnion 待调整的table数据
function unionV2_adj.AdjustReqAgreeAllRoleJoinUnion(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqAgreeAllRoleJoinUnion)
end

--region metatable unionV2.blackApplyInfo
---@type unionV2.blackApplyInfo
unionV2_adj.metatable_blackApplyInfo = {
    _ClassName = "unionV2.blackApplyInfo",
}
unionV2_adj.metatable_blackApplyInfo.__index = unionV2_adj.metatable_blackApplyInfo
--endregion

---@param tbl unionV2.blackApplyInfo 待调整的table数据
function unionV2_adj.AdjustblackApplyInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_blackApplyInfo)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
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
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
end

--region metatable unionV2.ReqGetBlackApplyRole
---@type unionV2.ReqGetBlackApplyRole
unionV2_adj.metatable_ReqGetBlackApplyRole = {
    _ClassName = "unionV2.ReqGetBlackApplyRole",
}
unionV2_adj.metatable_ReqGetBlackApplyRole.__index = unionV2_adj.metatable_ReqGetBlackApplyRole
--endregion

---@param tbl unionV2.ReqGetBlackApplyRole 待调整的table数据
function unionV2_adj.AdjustReqGetBlackApplyRole(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqGetBlackApplyRole)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
end

--region metatable unionV2.ResGetBlackApplyRole
---@type unionV2.ResGetBlackApplyRole
unionV2_adj.metatable_ResGetBlackApplyRole = {
    _ClassName = "unionV2.ResGetBlackApplyRole",
}
unionV2_adj.metatable_ResGetBlackApplyRole.__index = unionV2_adj.metatable_ResGetBlackApplyRole
--endregion

---@param tbl unionV2.ResGetBlackApplyRole 待调整的table数据
function unionV2_adj.AdjustResGetBlackApplyRole(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResGetBlackApplyRole)
    if tbl.blackApplyRole == nil then
        tbl.blackApplyRole = {}
    else
        if unionV2_adj.AdjustblackApplyInfo ~= nil then
            for i = 1, #tbl.blackApplyRole do
                unionV2_adj.AdjustblackApplyInfo(tbl.blackApplyRole[i])
            end
        end
    end
end

--region metatable unionV2.ReqRemoveBlackApplyRole
---@type unionV2.ReqRemoveBlackApplyRole
unionV2_adj.metatable_ReqRemoveBlackApplyRole = {
    _ClassName = "unionV2.ReqRemoveBlackApplyRole",
}
unionV2_adj.metatable_ReqRemoveBlackApplyRole.__index = unionV2_adj.metatable_ReqRemoveBlackApplyRole
--endregion

---@param tbl unionV2.ReqRemoveBlackApplyRole 待调整的table数据
function unionV2_adj.AdjustReqRemoveBlackApplyRole(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqRemoveBlackApplyRole)
end

--region metatable unionV2.ReqGetOnlineMember
---@type unionV2.ReqGetOnlineMember
unionV2_adj.metatable_ReqGetOnlineMember = {
    _ClassName = "unionV2.ReqGetOnlineMember",
}
unionV2_adj.metatable_ReqGetOnlineMember.__index = unionV2_adj.metatable_ReqGetOnlineMember
--endregion

---@param tbl unionV2.ReqGetOnlineMember 待调整的table数据
function unionV2_adj.AdjustReqGetOnlineMember(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqGetOnlineMember)
end

--region metatable unionV2.ReqKickOutGuild
---@type unionV2.ReqKickOutGuild
unionV2_adj.metatable_ReqKickOutGuild = {
    _ClassName = "unionV2.ReqKickOutGuild",
}
unionV2_adj.metatable_ReqKickOutGuild.__index = unionV2_adj.metatable_ReqKickOutGuild
--endregion

---@param tbl unionV2.ReqKickOutGuild 待调整的table数据
function unionV2_adj.AdjustReqKickOutGuild(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqKickOutGuild)
end

--region metatable unionV2.ResKickOutGuild
---@type unionV2.ResKickOutGuild
unionV2_adj.metatable_ResKickOutGuild = {
    _ClassName = "unionV2.ResKickOutGuild",
}
unionV2_adj.metatable_ResKickOutGuild.__index = unionV2_adj.metatable_ResKickOutGuild
--endregion

---@param tbl unionV2.ResKickOutGuild 待调整的table数据
function unionV2_adj.AdjustResKickOutGuild(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResKickOutGuild)
end

--region metatable unionV2.ReqImpeachmentInfo
---@type unionV2.ReqImpeachmentInfo
unionV2_adj.metatable_ReqImpeachmentInfo = {
    _ClassName = "unionV2.ReqImpeachmentInfo",
}
unionV2_adj.metatable_ReqImpeachmentInfo.__index = unionV2_adj.metatable_ReqImpeachmentInfo
--endregion

---@param tbl unionV2.ReqImpeachmentInfo 待调整的table数据
function unionV2_adj.AdjustReqImpeachmentInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqImpeachmentInfo)
end

--region metatable unionV2.ReqImpeachmentVote
---@type unionV2.ReqImpeachmentVote
unionV2_adj.metatable_ReqImpeachmentVote = {
    _ClassName = "unionV2.ReqImpeachmentVote",
}
unionV2_adj.metatable_ReqImpeachmentVote.__index = unionV2_adj.metatable_ReqImpeachmentVote
--endregion

---@param tbl unionV2.ReqImpeachmentVote 待调整的table数据
function unionV2_adj.AdjustReqImpeachmentVote(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqImpeachmentVote)
end

--region metatable unionV2.ResImpeachmentVote
---@type unionV2.ResImpeachmentVote
unionV2_adj.metatable_ResImpeachmentVote = {
    _ClassName = "unionV2.ResImpeachmentVote",
}
unionV2_adj.metatable_ResImpeachmentVote.__index = unionV2_adj.metatable_ResImpeachmentVote
--endregion

---@param tbl unionV2.ResImpeachmentVote 待调整的table数据
function unionV2_adj.AdjustResImpeachmentVote(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResImpeachmentVote)
end

--region metatable unionV2.ReqGetUnionItems
---@type unionV2.ReqGetUnionItems
unionV2_adj.metatable_ReqGetUnionItems = {
    _ClassName = "unionV2.ReqGetUnionItems",
}
unionV2_adj.metatable_ReqGetUnionItems.__index = unionV2_adj.metatable_ReqGetUnionItems
--endregion

---@param tbl unionV2.ReqGetUnionItems 待调整的table数据
function unionV2_adj.AdjustReqGetUnionItems(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqGetUnionItems)
end

--region metatable unionV2.ReqAutomaticPassing
---@type unionV2.ReqAutomaticPassing
unionV2_adj.metatable_ReqAutomaticPassing = {
    _ClassName = "unionV2.ReqAutomaticPassing",
}
unionV2_adj.metatable_ReqAutomaticPassing.__index = unionV2_adj.metatable_ReqAutomaticPassing
--endregion

---@param tbl unionV2.ReqAutomaticPassing 待调整的table数据
function unionV2_adj.AdjustReqAutomaticPassing(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqAutomaticPassing)
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
end

--region metatable unionV2.ResTheUnionChange
---@type unionV2.ResTheUnionChange
unionV2_adj.metatable_ResTheUnionChange = {
    _ClassName = "unionV2.ResTheUnionChange",
}
unionV2_adj.metatable_ResTheUnionChange.__index = unionV2_adj.metatable_ResTheUnionChange
--endregion

---@param tbl unionV2.ResTheUnionChange 待调整的table数据
function unionV2_adj.AdjustResTheUnionChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResTheUnionChange)
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
end

--region metatable unionV2.ResUnionNameChange
---@type unionV2.ResUnionNameChange
unionV2_adj.metatable_ResUnionNameChange = {
    _ClassName = "unionV2.ResUnionNameChange",
}
unionV2_adj.metatable_ResUnionNameChange.__index = unionV2_adj.metatable_ResUnionNameChange
--endregion

---@param tbl unionV2.ResUnionNameChange 待调整的table数据
function unionV2_adj.AdjustResUnionNameChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResUnionNameChange)
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
    if tbl.unionIconId == nil then
        tbl.unionIconIdSpecified = false
        tbl.unionIconId = 0
    else
        tbl.unionIconIdSpecified = true
    end
    if tbl.unionPos == nil then
        tbl.unionPosSpecified = false
        tbl.unionPos = 0
    else
        tbl.unionPosSpecified = true
    end
    if tbl.unionRank == nil then
        tbl.unionRankSpecified = false
        tbl.unionRank = 0
    else
        tbl.unionRankSpecified = true
    end
end

--region metatable unionV2.ReqAssignmentMonster
---@type unionV2.ReqAssignmentMonster
unionV2_adj.metatable_ReqAssignmentMonster = {
    _ClassName = "unionV2.ReqAssignmentMonster",
}
unionV2_adj.metatable_ReqAssignmentMonster.__index = unionV2_adj.metatable_ReqAssignmentMonster
--endregion

---@param tbl unionV2.ReqAssignmentMonster 待调整的table数据
function unionV2_adj.AdjustReqAssignmentMonster(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqAssignmentMonster)
    if tbl.newMonsterId == nil then
        tbl.newMonsterIdSpecified = false
        tbl.newMonsterId = 0
    else
        tbl.newMonsterIdSpecified = true
    end
    if tbl.position == nil then
        tbl.positionSpecified = false
        tbl.position = 0
    else
        tbl.positionSpecified = true
    end
end

--region metatable unionV2.GetAssignment
---@type unionV2.GetAssignment
unionV2_adj.metatable_GetAssignment = {
    _ClassName = "unionV2.GetAssignment",
}
unionV2_adj.metatable_GetAssignment.__index = unionV2_adj.metatable_GetAssignment
--endregion

---@param tbl unionV2.GetAssignment 待调整的table数据
function unionV2_adj.AdjustGetAssignment(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_GetAssignment)
    if tbl.oldMonsterId == nil then
        tbl.oldMonsterIdSpecified = false
        tbl.oldMonsterId = 0
    else
        tbl.oldMonsterIdSpecified = true
    end
    if tbl.position == nil then
        tbl.positionSpecified = false
        tbl.position = 0
    else
        tbl.positionSpecified = true
    end
    if tbl.oldMonsterName == nil then
        tbl.oldMonsterNameSpecified = false
        tbl.oldMonsterName = ""
    else
        tbl.oldMonsterNameSpecified = true
    end
end

--region metatable unionV2.YesGetUnionMonster
---@type unionV2.YesGetUnionMonster
unionV2_adj.metatable_YesGetUnionMonster = {
    _ClassName = "unionV2.YesGetUnionMonster",
}
unionV2_adj.metatable_YesGetUnionMonster.__index = unionV2_adj.metatable_YesGetUnionMonster
--endregion

---@param tbl unionV2.YesGetUnionMonster 待调整的table数据
function unionV2_adj.AdjustYesGetUnionMonster(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_YesGetUnionMonster)
    if tbl.oldMonsterId == nil then
        tbl.oldMonsterIdSpecified = false
        tbl.oldMonsterId = 0
    else
        tbl.oldMonsterIdSpecified = true
    end
    if tbl.position == nil then
        tbl.positionSpecified = false
        tbl.position = 0
    else
        tbl.positionSpecified = true
    end
    if tbl.newMonsterId == nil then
        tbl.newMonsterIdSpecified = false
        tbl.newMonsterId = 0
    else
        tbl.newMonsterIdSpecified = true
    end
    if tbl.isAgree == nil then
        tbl.isAgreeSpecified = false
        tbl.isAgree = 0
    else
        tbl.isAgreeSpecified = true
    end
end

--region metatable unionV2.HandlingSuccess
---@type unionV2.HandlingSuccess
unionV2_adj.metatable_HandlingSuccess = {
    _ClassName = "unionV2.HandlingSuccess",
}
unionV2_adj.metatable_HandlingSuccess.__index = unionV2_adj.metatable_HandlingSuccess
--endregion

---@param tbl unionV2.HandlingSuccess 待调整的table数据
function unionV2_adj.AdjustHandlingSuccess(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_HandlingSuccess)
    if tbl.isAgree == nil then
        tbl.isAgreeSpecified = false
        tbl.isAgree = 0
    else
        tbl.isAgreeSpecified = true
    end
end

--region metatable unionV2.ReqUnionUpgrade
---@type unionV2.ReqUnionUpgrade
unionV2_adj.metatable_ReqUnionUpgrade = {
    _ClassName = "unionV2.ReqUnionUpgrade",
}
unionV2_adj.metatable_ReqUnionUpgrade.__index = unionV2_adj.metatable_ReqUnionUpgrade
--endregion

---@param tbl unionV2.ReqUnionUpgrade 待调整的table数据
function unionV2_adj.AdjustReqUnionUpgrade(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqUnionUpgrade)
    if tbl.toLevel == nil then
        tbl.toLevelSpecified = false
        tbl.toLevel = 0
    else
        tbl.toLevelSpecified = true
    end
end

--region metatable unionV2.ReqUnionBadgeReplace
---@type unionV2.ReqUnionBadgeReplace
unionV2_adj.metatable_ReqUnionBadgeReplace = {
    _ClassName = "unionV2.ReqUnionBadgeReplace",
}
unionV2_adj.metatable_ReqUnionBadgeReplace.__index = unionV2_adj.metatable_ReqUnionBadgeReplace
--endregion

---@param tbl unionV2.ReqUnionBadgeReplace 待调整的table数据
function unionV2_adj.AdjustReqUnionBadgeReplace(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqUnionBadgeReplace)
    if tbl.unionIcon == nil then
        tbl.unionIconSpecified = false
        tbl.unionIcon = 0
    else
        tbl.unionIconSpecified = true
    end
end

--region metatable unionV2.ReqUpdateUnionUpgradeRedPoint
---@type unionV2.ReqUpdateUnionUpgradeRedPoint
unionV2_adj.metatable_ReqUpdateUnionUpgradeRedPoint = {
    _ClassName = "unionV2.ReqUpdateUnionUpgradeRedPoint",
}
unionV2_adj.metatable_ReqUpdateUnionUpgradeRedPoint.__index = unionV2_adj.metatable_ReqUpdateUnionUpgradeRedPoint
--endregion

---@param tbl unionV2.ReqUpdateUnionUpgradeRedPoint 待调整的table数据
function unionV2_adj.AdjustReqUpdateUnionUpgradeRedPoint(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqUpdateUnionUpgradeRedPoint)
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
end

--region metatable unionV2.ReqUpdateUnionCallBackUsePosition
---@type unionV2.ReqUpdateUnionCallBackUsePosition
unionV2_adj.metatable_ReqUpdateUnionCallBackUsePosition = {
    _ClassName = "unionV2.ReqUpdateUnionCallBackUsePosition",
}
unionV2_adj.metatable_ReqUpdateUnionCallBackUsePosition.__index = unionV2_adj.metatable_ReqUpdateUnionCallBackUsePosition
--endregion

---@param tbl unionV2.ReqUpdateUnionCallBackUsePosition 待调整的table数据
function unionV2_adj.AdjustReqUpdateUnionCallBackUsePosition(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqUpdateUnionCallBackUsePosition)
    if tbl.position == nil then
        tbl.positionSpecified = false
        tbl.position = 0
    else
        tbl.positionSpecified = true
    end
end

--region metatable unionV2.ReqCombineUnion
---@type unionV2.ReqCombineUnion
unionV2_adj.metatable_ReqCombineUnion = {
    _ClassName = "unionV2.ReqCombineUnion",
}
unionV2_adj.metatable_ReqCombineUnion.__index = unionV2_adj.metatable_ReqCombineUnion
--endregion

---@param tbl unionV2.ReqCombineUnion 待调整的table数据
function unionV2_adj.AdjustReqCombineUnion(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqCombineUnion)
end

--region metatable unionV2.ResApplyCombineUnion
---@type unionV2.ResApplyCombineUnion
unionV2_adj.metatable_ResApplyCombineUnion = {
    _ClassName = "unionV2.ResApplyCombineUnion",
}
unionV2_adj.metatable_ResApplyCombineUnion.__index = unionV2_adj.metatable_ResApplyCombineUnion
--endregion

---@param tbl unionV2.ResApplyCombineUnion 待调整的table数据
function unionV2_adj.AdjustResApplyCombineUnion(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResApplyCombineUnion)
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
    if tbl.leaderId == nil then
        tbl.leaderIdSpecified = false
        tbl.leaderId = 0
    else
        tbl.leaderIdSpecified = true
    end
    if tbl.leaderName == nil then
        tbl.leaderNameSpecified = false
        tbl.leaderName = ""
    else
        tbl.leaderNameSpecified = true
    end
end

--region metatable unionV2.ReqConfirmCombineUnion
---@type unionV2.ReqConfirmCombineUnion
unionV2_adj.metatable_ReqConfirmCombineUnion = {
    _ClassName = "unionV2.ReqConfirmCombineUnion",
}
unionV2_adj.metatable_ReqConfirmCombineUnion.__index = unionV2_adj.metatable_ReqConfirmCombineUnion
--endregion

---@param tbl unionV2.ReqConfirmCombineUnion 待调整的table数据
function unionV2_adj.AdjustReqConfirmCombineUnion(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqConfirmCombineUnion)
end

--region metatable unionV2.ResSpoilsHouse
---@type unionV2.ResSpoilsHouse
unionV2_adj.metatable_ResSpoilsHouse = {
    _ClassName = "unionV2.ResSpoilsHouse",
}
unionV2_adj.metatable_ResSpoilsHouse.__index = unionV2_adj.metatable_ResSpoilsHouse
--endregion

---@param tbl unionV2.ResSpoilsHouse 待调整的table数据
function unionV2_adj.AdjustResSpoilsHouse(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResSpoilsHouse)
    if tbl.spoils == nil then
        tbl.spoils = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.spoils do
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.spoils[i])
            end
        end
    end
end

--region metatable unionV2.ResSpoilsHouseUpdate
---@type unionV2.ResSpoilsHouseUpdate
unionV2_adj.metatable_ResSpoilsHouseUpdate = {
    _ClassName = "unionV2.ResSpoilsHouseUpdate",
}
unionV2_adj.metatable_ResSpoilsHouseUpdate.__index = unionV2_adj.metatable_ResSpoilsHouseUpdate
--endregion

---@param tbl unionV2.ResSpoilsHouseUpdate 待调整的table数据
function unionV2_adj.AdjustResSpoilsHouseUpdate(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResSpoilsHouseUpdate)
    if tbl.newList == nil then
        tbl.newList = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.newList do
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.newList[i])
            end
        end
    end
    if tbl.removeList == nil then
        tbl.removeList = {}
    end
    if tbl.operate == nil then
        tbl.operateSpecified = false
        tbl.operate = 0
    else
        tbl.operateSpecified = true
    end
end

--region metatable unionV2.ReqGiveSpoils
---@type unionV2.ReqGiveSpoils
unionV2_adj.metatable_ReqGiveSpoils = {
    _ClassName = "unionV2.ReqGiveSpoils",
}
unionV2_adj.metatable_ReqGiveSpoils.__index = unionV2_adj.metatable_ReqGiveSpoils
--endregion

---@param tbl unionV2.ReqGiveSpoils 待调整的table数据
function unionV2_adj.AdjustReqGiveSpoils(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqGiveSpoils)
    if tbl.SpoilsId == nil then
        tbl.SpoilsIdSpecified = false
        tbl.SpoilsId = 0
    else
        tbl.SpoilsIdSpecified = true
    end
    if tbl.num == nil then
        tbl.numSpecified = false
        tbl.num = 0
    else
        tbl.numSpecified = true
    end
    if tbl.memberList == nil then
        tbl.memberList = {}
    end
end

--region metatable unionV2.ResCanGetSpoilsMembers
---@type unionV2.ResCanGetSpoilsMembers
unionV2_adj.metatable_ResCanGetSpoilsMembers = {
    _ClassName = "unionV2.ResCanGetSpoilsMembers",
}
unionV2_adj.metatable_ResCanGetSpoilsMembers.__index = unionV2_adj.metatable_ResCanGetSpoilsMembers
--endregion

---@param tbl unionV2.ResCanGetSpoilsMembers 待调整的table数据
function unionV2_adj.AdjustResCanGetSpoilsMembers(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResCanGetSpoilsMembers)
    if tbl.members == nil then
        tbl.members = {}
    else
        if unionV2_adj.AdjustSpoilsMemberInfo ~= nil then
            for i = 1, #tbl.members do
                unionV2_adj.AdjustSpoilsMemberInfo(tbl.members[i])
            end
        end
    end
end

--region metatable unionV2.SpoilsMemberInfo
---@type unionV2.SpoilsMemberInfo
unionV2_adj.metatable_SpoilsMemberInfo = {
    _ClassName = "unionV2.SpoilsMemberInfo",
}
unionV2_adj.metatable_SpoilsMemberInfo.__index = unionV2_adj.metatable_SpoilsMemberInfo
--endregion

---@param tbl unionV2.SpoilsMemberInfo 待调整的table数据
function unionV2_adj.AdjustSpoilsMemberInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_SpoilsMemberInfo)
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
    if tbl.remain == nil then
        tbl.remainSpecified = false
        tbl.remain = 0
    else
        tbl.remainSpecified = true
    end
end

--region metatable unionV2.updateTodayCityTax
---@type unionV2.updateTodayCityTax
unionV2_adj.metatable_updateTodayCityTax = {
    _ClassName = "unionV2.updateTodayCityTax",
}
unionV2_adj.metatable_updateTodayCityTax.__index = unionV2_adj.metatable_updateTodayCityTax
--endregion

---@param tbl unionV2.updateTodayCityTax 待调整的table数据
function unionV2_adj.AdjustupdateTodayCityTax(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_updateTodayCityTax)
    if tbl.unionTodayTax == nil then
        tbl.unionTodayTaxSpecified = false
        tbl.unionTodayTax = 0
    else
        tbl.unionTodayTaxSpecified = true
    end
end

--region metatable unionV2.UnionVoiceStatus
---@type unionV2.UnionVoiceStatus
unionV2_adj.metatable_UnionVoiceStatus = {
    _ClassName = "unionV2.UnionVoiceStatus",
}
unionV2_adj.metatable_UnionVoiceStatus.__index = unionV2_adj.metatable_UnionVoiceStatus
--endregion

---@param tbl unionV2.UnionVoiceStatus 待调整的table数据
function unionV2_adj.AdjustUnionVoiceStatus(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionVoiceStatus)
    if tbl.canSendVoiceMembers == nil then
        tbl.canSendVoiceMembers = {}
    end
    if tbl.voiceOpenMembers == nil then
        tbl.voiceOpenMembers = {}
    end
end

--region metatable unionV2.ReqToggleSendVoice
---@type unionV2.ReqToggleSendVoice
unionV2_adj.metatable_ReqToggleSendVoice = {
    _ClassName = "unionV2.ReqToggleSendVoice",
}
unionV2_adj.metatable_ReqToggleSendVoice.__index = unionV2_adj.metatable_ReqToggleSendVoice
--endregion

---@param tbl unionV2.ReqToggleSendVoice 待调整的table数据
function unionV2_adj.AdjustReqToggleSendVoice(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqToggleSendVoice)
end

--region metatable unionV2.ReqToggleVoiceOpen
---@type unionV2.ReqToggleVoiceOpen
unionV2_adj.metatable_ReqToggleVoiceOpen = {
    _ClassName = "unionV2.ReqToggleVoiceOpen",
}
unionV2_adj.metatable_ReqToggleVoiceOpen.__index = unionV2_adj.metatable_ReqToggleVoiceOpen
--endregion

---@param tbl unionV2.ReqToggleVoiceOpen 待调整的table数据
function unionV2_adj.AdjustReqToggleVoiceOpen(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqToggleVoiceOpen)
end

--region metatable unionV2.ResMagicCircleStart
---@type unionV2.ResMagicCircleStart
unionV2_adj.metatable_ResMagicCircleStart = {
    _ClassName = "unionV2.ResMagicCircleStart",
}
unionV2_adj.metatable_ResMagicCircleStart.__index = unionV2_adj.metatable_ResMagicCircleStart
--endregion

---@param tbl unionV2.ResMagicCircleStart 待调整的table数据
function unionV2_adj.AdjustResMagicCircleStart(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResMagicCircleStart)
end

--region metatable unionV2.ResMagicCircleInfo
---@type unionV2.ResMagicCircleInfo
unionV2_adj.metatable_ResMagicCircleInfo = {
    _ClassName = "unionV2.ResMagicCircleInfo",
}
unionV2_adj.metatable_ResMagicCircleInfo.__index = unionV2_adj.metatable_ResMagicCircleInfo
--endregion

---@param tbl unionV2.ResMagicCircleInfo 待调整的table数据
function unionV2_adj.AdjustResMagicCircleInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResMagicCircleInfo)
    if tbl.mid == nil then
        tbl.midSpecified = false
        tbl.mid = 0
    else
        tbl.midSpecified = true
    end
    if tbl.curCount == nil then
        tbl.curCountSpecified = false
        tbl.curCount = 0
    else
        tbl.curCountSpecified = true
    end
    if tbl.maxCount == nil then
        tbl.maxCountSpecified = false
        tbl.maxCount = 0
    else
        tbl.maxCountSpecified = true
    end
end

--region metatable unionV2.ReqUnionRedBagInfo
---@type unionV2.ReqUnionRedBagInfo
unionV2_adj.metatable_ReqUnionRedBagInfo = {
    _ClassName = "unionV2.ReqUnionRedBagInfo",
}
unionV2_adj.metatable_ReqUnionRedBagInfo.__index = unionV2_adj.metatable_ReqUnionRedBagInfo
--endregion

---@param tbl unionV2.ReqUnionRedBagInfo 待调整的table数据
function unionV2_adj.AdjustReqUnionRedBagInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqUnionRedBagInfo)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable unionV2.ResUnionRedBagInfo
---@type unionV2.ResUnionRedBagInfo
unionV2_adj.metatable_ResUnionRedBagInfo = {
    _ClassName = "unionV2.ResUnionRedBagInfo",
}
unionV2_adj.metatable_ResUnionRedBagInfo.__index = unionV2_adj.metatable_ResUnionRedBagInfo
--endregion

---@param tbl unionV2.ResUnionRedBagInfo 待调整的table数据
function unionV2_adj.AdjustResUnionRedBagInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResUnionRedBagInfo)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.info == nil then
        tbl.info = {}
    else
        if unionV2_adj.AdjustRedBagRoleInfo ~= nil then
            for i = 1, #tbl.info do
                unionV2_adj.AdjustRedBagRoleInfo(tbl.info[i])
            end
        end
    end
    if tbl.subMoney == nil then
        tbl.subMoneySpecified = false
        tbl.subMoney = 0
    else
        tbl.subMoneySpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
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
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.moneyId == nil then
        tbl.moneyIdSpecified = false
        tbl.moneyId = 0
    else
        tbl.moneyIdSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable unionV2.RedBagRoleInfo
---@type unionV2.RedBagRoleInfo
unionV2_adj.metatable_RedBagRoleInfo = {
    _ClassName = "unionV2.RedBagRoleInfo",
}
unionV2_adj.metatable_RedBagRoleInfo.__index = unionV2_adj.metatable_RedBagRoleInfo
--endregion

---@param tbl unionV2.RedBagRoleInfo 待调整的table数据
function unionV2_adj.AdjustRedBagRoleInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_RedBagRoleInfo)
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
    if tbl.money == nil then
        tbl.moneySpecified = false
        tbl.money = 0
    else
        tbl.moneySpecified = true
    end
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
end

--region metatable unionV2.ReqSendRedBag
---@type unionV2.ReqSendRedBag
unionV2_adj.metatable_ReqSendRedBag = {
    _ClassName = "unionV2.ReqSendRedBag",
}
unionV2_adj.metatable_ReqSendRedBag.__index = unionV2_adj.metatable_ReqSendRedBag
--endregion

---@param tbl unionV2.ReqSendRedBag 待调整的table数据
function unionV2_adj.AdjustReqSendRedBag(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqSendRedBag)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.money == nil then
        tbl.moneySpecified = false
        tbl.money = 0
    else
        tbl.moneySpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable unionV2.ReqRecieveUnionRedBag
---@type unionV2.ReqRecieveUnionRedBag
unionV2_adj.metatable_ReqRecieveUnionRedBag = {
    _ClassName = "unionV2.ReqRecieveUnionRedBag",
}
unionV2_adj.metatable_ReqRecieveUnionRedBag.__index = unionV2_adj.metatable_ReqRecieveUnionRedBag
--endregion

---@param tbl unionV2.ReqRecieveUnionRedBag 待调整的table数据
function unionV2_adj.AdjustReqRecieveUnionRedBag(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqRecieveUnionRedBag)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable unionV2.ResUnionSpeakerStatus
---@type unionV2.ResUnionSpeakerStatus
unionV2_adj.metatable_ResUnionSpeakerStatus = {
    _ClassName = "unionV2.ResUnionSpeakerStatus",
}
unionV2_adj.metatable_ResUnionSpeakerStatus.__index = unionV2_adj.metatable_ResUnionSpeakerStatus
--endregion

---@param tbl unionV2.ResUnionSpeakerStatus 待调整的table数据
function unionV2_adj.AdjustResUnionSpeakerStatus(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResUnionSpeakerStatus)
    if tbl.speakerCloseMembers == nil then
        tbl.speakerCloseMembers = {}
    end
end

--region metatable unionV2.ResUnionCallBackInfo
---@type unionV2.ResUnionCallBackInfo
unionV2_adj.metatable_ResUnionCallBackInfo = {
    _ClassName = "unionV2.ResUnionCallBackInfo",
}
unionV2_adj.metatable_ResUnionCallBackInfo.__index = unionV2_adj.metatable_ResUnionCallBackInfo
--endregion

---@param tbl unionV2.ResUnionCallBackInfo 待调整的table数据
function unionV2_adj.AdjustResUnionCallBackInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResUnionCallBackInfo)
    if tbl.cdTime == nil then
        tbl.cdTimeSpecified = false
        tbl.cdTime = 0
    else
        tbl.cdTimeSpecified = true
    end
    if tbl.durationTime == nil then
        tbl.durationTimeSpecified = false
        tbl.durationTime = 0
    else
        tbl.durationTimeSpecified = true
    end
end

--region metatable unionV2.ResUnionMagicBossRank
---@type unionV2.ResUnionMagicBossRank
unionV2_adj.metatable_ResUnionMagicBossRank = {
    _ClassName = "unionV2.ResUnionMagicBossRank",
}
unionV2_adj.metatable_ResUnionMagicBossRank.__index = unionV2_adj.metatable_ResUnionMagicBossRank
--endregion

---@param tbl unionV2.ResUnionMagicBossRank 待调整的table数据
function unionV2_adj.AdjustResUnionMagicBossRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResUnionMagicBossRank)
    if tbl.info == nil then
        tbl.info = {}
    else
        if unionV2_adj.AdjustUnionMagicBossRankInfo ~= nil then
            for i = 1, #tbl.info do
                unionV2_adj.AdjustUnionMagicBossRankInfo(tbl.info[i])
            end
        end
    end
end

--region metatable unionV2.UnionMagicBossRankInfo
---@type unionV2.UnionMagicBossRankInfo
unionV2_adj.metatable_UnionMagicBossRankInfo = {
    _ClassName = "unionV2.UnionMagicBossRankInfo",
}
unionV2_adj.metatable_UnionMagicBossRankInfo.__index = unionV2_adj.metatable_UnionMagicBossRankInfo
--endregion

---@param tbl unionV2.UnionMagicBossRankInfo 待调整的table数据
function unionV2_adj.AdjustUnionMagicBossRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionMagicBossRankInfo)
    if tbl.rank == nil then
        tbl.rankSpecified = false
        tbl.rank = 0
    else
        tbl.rankSpecified = true
    end
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
    if tbl.score == nil then
        tbl.scoreSpecified = false
        tbl.score = 0
    else
        tbl.scoreSpecified = true
    end
end

--region metatable unionV2.ResUpdateAgencyChairman
---@type unionV2.ResUpdateAgencyChairman
unionV2_adj.metatable_ResUpdateAgencyChairman = {
    _ClassName = "unionV2.ResUpdateAgencyChairman",
}
unionV2_adj.metatable_ResUpdateAgencyChairman.__index = unionV2_adj.metatable_ResUpdateAgencyChairman
--endregion

---@param tbl unionV2.ResUpdateAgencyChairman 待调整的table数据
function unionV2_adj.AdjustResUpdateAgencyChairman(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResUpdateAgencyChairman)
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
    if tbl.chairmanId == nil then
        tbl.chairmanIdSpecified = false
        tbl.chairmanId = 0
    else
        tbl.chairmanIdSpecified = true
    end
    if tbl.chairmanName == nil then
        tbl.chairmanNameSpecified = false
        tbl.chairmanName = ""
    else
        tbl.chairmanNameSpecified = true
    end
end

--region metatable unionV2.ResToViewUnionRevenge
---@type unionV2.ResToViewUnionRevenge
unionV2_adj.metatable_ResToViewUnionRevenge = {
    _ClassName = "unionV2.ResToViewUnionRevenge",
}
unionV2_adj.metatable_ResToViewUnionRevenge.__index = unionV2_adj.metatable_ResToViewUnionRevenge
--endregion

---@param tbl unionV2.ResToViewUnionRevenge 待调整的table数据
function unionV2_adj.AdjustResToViewUnionRevenge(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResToViewUnionRevenge)
    if tbl.info == nil then
        tbl.info = {}
    else
        if unionV2_adj.AdjustUnionRevenge ~= nil then
            for i = 1, #tbl.info do
                unionV2_adj.AdjustUnionRevenge(tbl.info[i])
            end
        end
    end
end

--region metatable unionV2.UnionRevenge
---@type unionV2.UnionRevenge
unionV2_adj.metatable_UnionRevenge = {
    _ClassName = "unionV2.UnionRevenge",
}
unionV2_adj.metatable_UnionRevenge.__index = unionV2_adj.metatable_UnionRevenge
--endregion

---@param tbl unionV2.UnionRevenge 待调整的table数据
function unionV2_adj.AdjustUnionRevenge(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionRevenge)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.createTime == nil then
        tbl.createTimeSpecified = false
        tbl.createTime = 0
    else
        tbl.createTimeSpecified = true
    end
    if tbl.killedRoleId == nil then
        tbl.killedRoleIdSpecified = false
        tbl.killedRoleId = 0
    else
        tbl.killedRoleIdSpecified = true
    end
    if tbl.revengeRoleId == nil then
        tbl.revengeRoleIdSpecified = false
        tbl.revengeRoleId = 0
    else
        tbl.revengeRoleIdSpecified = true
    end
    if tbl.completeRoleId == nil then
        tbl.completeRoleIdSpecified = false
        tbl.completeRoleId = 0
    else
        tbl.completeRoleIdSpecified = true
    end
    if tbl.revengeType == nil then
        tbl.revengeTypeSpecified = false
        tbl.revengeType = 0
    else
        tbl.revengeTypeSpecified = true
    end
    if tbl.canReward == nil then
        tbl.canRewardSpecified = false
        tbl.canReward = 0
    else
        tbl.canRewardSpecified = true
    end
    if tbl.revengeRoleName == nil then
        tbl.revengeRoleNameSpecified = false
        tbl.revengeRoleName = ""
    else
        tbl.revengeRoleNameSpecified = true
    end
    if tbl.revengeRoleUnionId == nil then
        tbl.revengeRoleUnionIdSpecified = false
        tbl.revengeRoleUnionId = 0
    else
        tbl.revengeRoleUnionIdSpecified = true
    end
    if tbl.revengeRoleUnionName == nil then
        tbl.revengeRoleUnionNameSpecified = false
        tbl.revengeRoleUnionName = ""
    else
        tbl.revengeRoleUnionNameSpecified = true
    end
    if tbl.revengeRoleCareer == nil then
        tbl.revengeRoleCareerSpecified = false
        tbl.revengeRoleCareer = 0
    else
        tbl.revengeRoleCareerSpecified = true
    end
    if tbl.revengeRoleLevel == nil then
        tbl.revengeRoleLevelSpecified = false
        tbl.revengeRoleLevel = 0
    else
        tbl.revengeRoleLevelSpecified = true
    end
    if tbl.revengeRoleSex == nil then
        tbl.revengeRoleSexSpecified = false
        tbl.revengeRoleSex = 0
    else
        tbl.revengeRoleSexSpecified = true
    end
    if tbl.killedRoleName == nil then
        tbl.killedRoleNameSpecified = false
        tbl.killedRoleName = ""
    else
        tbl.killedRoleNameSpecified = true
    end
end

--region metatable unionV2.ReqRewardUnionRevenge
---@type unionV2.ReqRewardUnionRevenge
unionV2_adj.metatable_ReqRewardUnionRevenge = {
    _ClassName = "unionV2.ReqRewardUnionRevenge",
}
unionV2_adj.metatable_ReqRewardUnionRevenge.__index = unionV2_adj.metatable_ReqRewardUnionRevenge
--endregion

---@param tbl unionV2.ReqRewardUnionRevenge 待调整的table数据
function unionV2_adj.AdjustReqRewardUnionRevenge(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqRewardUnionRevenge)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable unionV2.ResRewardUnionRevenge
---@type unionV2.ResRewardUnionRevenge
unionV2_adj.metatable_ResRewardUnionRevenge = {
    _ClassName = "unionV2.ResRewardUnionRevenge",
}
unionV2_adj.metatable_ResRewardUnionRevenge.__index = unionV2_adj.metatable_ResRewardUnionRevenge
--endregion

---@param tbl unionV2.ResRewardUnionRevenge 待调整的table数据
function unionV2_adj.AdjustResRewardUnionRevenge(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResRewardUnionRevenge)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.canReward == nil then
        tbl.canRewardSpecified = false
        tbl.canReward = 0
    else
        tbl.canRewardSpecified = true
    end
end

--region metatable unionV2.ResAddUnionRevenge
---@type unionV2.ResAddUnionRevenge
unionV2_adj.metatable_ResAddUnionRevenge = {
    _ClassName = "unionV2.ResAddUnionRevenge",
}
unionV2_adj.metatable_ResAddUnionRevenge.__index = unionV2_adj.metatable_ResAddUnionRevenge
--endregion

---@param tbl unionV2.ResAddUnionRevenge 待调整的table数据
function unionV2_adj.AdjustResAddUnionRevenge(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResAddUnionRevenge)
    if tbl.unionRevenge == nil then
        tbl.unionRevengeSpecified = false
        tbl.unionRevenge = nil
    else
        if tbl.unionRevengeSpecified == nil then 
            tbl.unionRevengeSpecified = true
            if unionV2_adj.AdjustUnionRevenge ~= nil then
                unionV2_adj.AdjustUnionRevenge(tbl.unionRevenge)
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

--region metatable unionV2.ReqGetRevengePoint
---@type unionV2.ReqGetRevengePoint
unionV2_adj.metatable_ReqGetRevengePoint = {
    _ClassName = "unionV2.ReqGetRevengePoint",
}
unionV2_adj.metatable_ReqGetRevengePoint.__index = unionV2_adj.metatable_ReqGetRevengePoint
--endregion

---@param tbl unionV2.ReqGetRevengePoint 待调整的table数据
function unionV2_adj.AdjustReqGetRevengePoint(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqGetRevengePoint)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable unionV2.ResGetRevengePoint
---@type unionV2.ResGetRevengePoint
unionV2_adj.metatable_ResGetRevengePoint = {
    _ClassName = "unionV2.ResGetRevengePoint",
}
unionV2_adj.metatable_ResGetRevengePoint.__index = unionV2_adj.metatable_ResGetRevengePoint
--endregion

---@param tbl unionV2.ResGetRevengePoint 待调整的table数据
function unionV2_adj.AdjustResGetRevengePoint(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ResGetRevengePoint)
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
    if tbl.targetName == nil then
        tbl.targetNameSpecified = false
        tbl.targetName = ""
    else
        tbl.targetNameSpecified = true
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
    if tbl.line == nil then
        tbl.lineSpecified = false
        tbl.line = 0
    else
        tbl.lineSpecified = true
    end
end

--region metatable unionV2.ReqWillJoinUniteUnionInfo
---@type unionV2.ReqWillJoinUniteUnionInfo
unionV2_adj.metatable_ReqWillJoinUniteUnionInfo = {
    _ClassName = "unionV2.ReqWillJoinUniteUnionInfo",
}
unionV2_adj.metatable_ReqWillJoinUniteUnionInfo.__index = unionV2_adj.metatable_ReqWillJoinUniteUnionInfo
--endregion

---@param tbl unionV2.ReqWillJoinUniteUnionInfo 待调整的table数据
function unionV2_adj.AdjustReqWillJoinUniteUnionInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_ReqWillJoinUniteUnionInfo)
    if tbl.uniteUnionType == nil then
        tbl.uniteUnionTypeSpecified = false
        tbl.uniteUnionType = 0
    else
        tbl.uniteUnionTypeSpecified = true
    end
end

--region metatable unionV2.WillJoinUniteUnionInfo
---@type unionV2.WillJoinUniteUnionInfo
unionV2_adj.metatable_WillJoinUniteUnionInfo = {
    _ClassName = "unionV2.WillJoinUniteUnionInfo",
}
unionV2_adj.metatable_WillJoinUniteUnionInfo.__index = unionV2_adj.metatable_WillJoinUniteUnionInfo
--endregion

---@param tbl unionV2.WillJoinUniteUnionInfo 待调整的table数据
function unionV2_adj.AdjustWillJoinUniteUnionInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_WillJoinUniteUnionInfo)
    if tbl.uniteUnionType == nil then
        tbl.uniteUnionTypeSpecified = false
        tbl.uniteUnionType = 0
    else
        tbl.uniteUnionTypeSpecified = true
    end
    if tbl.uniteUnionCount == nil then
        tbl.uniteUnionCountSpecified = false
        tbl.uniteUnionCount = 0
    else
        tbl.uniteUnionCountSpecified = true
    end
end

--region metatable unionV2.AllWillJoinUniteUnion
---@type unionV2.AllWillJoinUniteUnion
unionV2_adj.metatable_AllWillJoinUniteUnion = {
    _ClassName = "unionV2.AllWillJoinUniteUnion",
}
unionV2_adj.metatable_AllWillJoinUniteUnion.__index = unionV2_adj.metatable_AllWillJoinUniteUnion
--endregion

---@param tbl unionV2.AllWillJoinUniteUnion 待调整的table数据
function unionV2_adj.AdjustAllWillJoinUniteUnion(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_AllWillJoinUniteUnion)
    if tbl.allJoin == nil then
        tbl.allJoin = {}
    else
        if unionV2_adj.AdjustWillJoinUniteUnionInfo ~= nil then
            for i = 1, #tbl.allJoin do
                unionV2_adj.AdjustWillJoinUniteUnionInfo(tbl.allJoin[i])
            end
        end
    end
end

--region metatable unionV2.OtherUnionVoteInfo
---@type unionV2.OtherUnionVoteInfo
unionV2_adj.metatable_OtherUnionVoteInfo = {
    _ClassName = "unionV2.OtherUnionVoteInfo",
}
unionV2_adj.metatable_OtherUnionVoteInfo.__index = unionV2_adj.metatable_OtherUnionVoteInfo
--endregion

---@param tbl unionV2.OtherUnionVoteInfo 待调整的table数据
function unionV2_adj.AdjustOtherUnionVoteInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_OtherUnionVoteInfo)
    if tbl.hostId == nil then
        tbl.hostIdSpecified = false
        tbl.hostId = 0
    else
        tbl.hostIdSpecified = true
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
    if tbl.activeCount == nil then
        tbl.activeCountSpecified = false
        tbl.activeCount = 0
    else
        tbl.activeCountSpecified = true
    end
    if tbl.num == nil then
        tbl.numSpecified = false
        tbl.num = 0
    else
        tbl.numSpecified = true
    end
    if tbl.WillJoinUniteUnionInfo == nil then
        tbl.WillJoinUniteUnionInfo = {}
    else
        if unionV2_adj.AdjustWillJoinUniteUnionInfo ~= nil then
            for i = 1, #tbl.WillJoinUniteUnionInfo do
                unionV2_adj.AdjustWillJoinUniteUnionInfo(tbl.WillJoinUniteUnionInfo[i])
            end
        end
    end
end

--region metatable unionV2.OtherServerUnionVoteAllInfo
---@type unionV2.OtherServerUnionVoteAllInfo
unionV2_adj.metatable_OtherServerUnionVoteAllInfo = {
    _ClassName = "unionV2.OtherServerUnionVoteAllInfo",
}
unionV2_adj.metatable_OtherServerUnionVoteAllInfo.__index = unionV2_adj.metatable_OtherServerUnionVoteAllInfo
--endregion

---@param tbl unionV2.OtherServerUnionVoteAllInfo 待调整的table数据
function unionV2_adj.AdjustOtherServerUnionVoteAllInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_OtherServerUnionVoteAllInfo)
    if tbl.otherUnionVoteInfo == nil then
        tbl.otherUnionVoteInfo = {}
    else
        if unionV2_adj.AdjustOtherUnionVoteInfo ~= nil then
            for i = 1, #tbl.otherUnionVoteInfo do
                unionV2_adj.AdjustOtherUnionVoteInfo(tbl.otherUnionVoteInfo[i])
            end
        end
    end
end

--region metatable unionV2.OtherAllUniteUnionVoteInfo
---@type unionV2.OtherAllUniteUnionVoteInfo
unionV2_adj.metatable_OtherAllUniteUnionVoteInfo = {
    _ClassName = "unionV2.OtherAllUniteUnionVoteInfo",
}
unionV2_adj.metatable_OtherAllUniteUnionVoteInfo.__index = unionV2_adj.metatable_OtherAllUniteUnionVoteInfo
--endregion

---@param tbl unionV2.OtherAllUniteUnionVoteInfo 待调整的table数据
function unionV2_adj.AdjustOtherAllUniteUnionVoteInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_OtherAllUniteUnionVoteInfo)
    if tbl.otherServerUnionVoteAllInfo == nil then
        tbl.otherServerUnionVoteAllInfo = {}
    else
        if unionV2_adj.AdjustOtherServerUnionVoteAllInfo ~= nil then
            for i = 1, #tbl.otherServerUnionVoteAllInfo do
                unionV2_adj.AdjustOtherServerUnionVoteAllInfo(tbl.otherServerUnionVoteAllInfo[i])
            end
        end
    end
end

--region metatable unionV2.UnionBossPlayerRankInfo
---@type unionV2.UnionBossPlayerRankInfo
unionV2_adj.metatable_UnionBossPlayerRankInfo = {
    _ClassName = "unionV2.UnionBossPlayerRankInfo",
}
unionV2_adj.metatable_UnionBossPlayerRankInfo.__index = unionV2_adj.metatable_UnionBossPlayerRankInfo
--endregion

---@param tbl unionV2.UnionBossPlayerRankInfo 待调整的table数据
function unionV2_adj.AdjustUnionBossPlayerRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionBossPlayerRankInfo)
    if tbl.playerRanks == nil then
        tbl.playerRanks = {}
    else
        if unionV2_adj.AdjustUnionBossPlayerRankStrcut ~= nil then
            for i = 1, #tbl.playerRanks do
                unionV2_adj.AdjustUnionBossPlayerRankStrcut(tbl.playerRanks[i])
            end
        end
    end
    if tbl.selfRank == nil then
        tbl.selfRankSpecified = false
        tbl.selfRank = nil
    else
        if tbl.selfRankSpecified == nil then 
            tbl.selfRankSpecified = true
            if unionV2_adj.AdjustUnionBossPlayerRankStrcut ~= nil then
                unionV2_adj.AdjustUnionBossPlayerRankStrcut(tbl.selfRank)
            end
        end
    end
end

--region metatable unionV2.UnionBossPlayerRankStrcut
---@type unionV2.UnionBossPlayerRankStrcut
unionV2_adj.metatable_UnionBossPlayerRankStrcut = {
    _ClassName = "unionV2.UnionBossPlayerRankStrcut",
}
unionV2_adj.metatable_UnionBossPlayerRankStrcut.__index = unionV2_adj.metatable_UnionBossPlayerRankStrcut
--endregion

---@param tbl unionV2.UnionBossPlayerRankStrcut 待调整的table数据
function unionV2_adj.AdjustUnionBossPlayerRankStrcut(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionBossPlayerRankStrcut)
end

--region metatable unionV2.UnionBossUnionRankInfo
---@type unionV2.UnionBossUnionRankInfo
unionV2_adj.metatable_UnionBossUnionRankInfo = {
    _ClassName = "unionV2.UnionBossUnionRankInfo",
}
unionV2_adj.metatable_UnionBossUnionRankInfo.__index = unionV2_adj.metatable_UnionBossUnionRankInfo
--endregion

---@param tbl unionV2.UnionBossUnionRankInfo 待调整的table数据
function unionV2_adj.AdjustUnionBossUnionRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionBossUnionRankInfo)
    if tbl.unionRanks == nil then
        tbl.unionRanks = {}
    else
        if unionV2_adj.AdjustUnionBossUnionRankStrcut ~= nil then
            for i = 1, #tbl.unionRanks do
                unionV2_adj.AdjustUnionBossUnionRankStrcut(tbl.unionRanks[i])
            end
        end
    end
    if tbl.selfUnioRank == nil then
        tbl.selfUnioRankSpecified = false
        tbl.selfUnioRank = nil
    else
        if tbl.selfUnioRankSpecified == nil then 
            tbl.selfUnioRankSpecified = true
            if unionV2_adj.AdjustUnionBossUnionRankStrcut ~= nil then
                unionV2_adj.AdjustUnionBossUnionRankStrcut(tbl.selfUnioRank)
            end
        end
    end
end

--region metatable unionV2.UnionBossUnionRankStrcut
---@type unionV2.UnionBossUnionRankStrcut
unionV2_adj.metatable_UnionBossUnionRankStrcut = {
    _ClassName = "unionV2.UnionBossUnionRankStrcut",
}
unionV2_adj.metatable_UnionBossUnionRankStrcut.__index = unionV2_adj.metatable_UnionBossUnionRankStrcut
--endregion

---@param tbl unionV2.UnionBossUnionRankStrcut 待调整的table数据
function unionV2_adj.AdjustUnionBossUnionRankStrcut(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionBossUnionRankStrcut)
end

--region metatable unionV2.UnionBossAddBuff
---@type unionV2.UnionBossAddBuff
unionV2_adj.metatable_UnionBossAddBuff = {
    _ClassName = "unionV2.UnionBossAddBuff",
}
unionV2_adj.metatable_UnionBossAddBuff.__index = unionV2_adj.metatable_UnionBossAddBuff
--endregion

---@param tbl unionV2.UnionBossAddBuff 待调整的table数据
function unionV2_adj.AdjustUnionBossAddBuff(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionBossAddBuff)
end

--region metatable unionV2.UnionBossBuffInfo
---@type unionV2.UnionBossBuffInfo
unionV2_adj.metatable_UnionBossBuffInfo = {
    _ClassName = "unionV2.UnionBossBuffInfo",
}
unionV2_adj.metatable_UnionBossBuffInfo.__index = unionV2_adj.metatable_UnionBossBuffInfo
--endregion

---@param tbl unionV2.UnionBossBuffInfo 待调整的table数据
function unionV2_adj.AdjustUnionBossBuffInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, unionV2_adj.metatable_UnionBossBuffInfo)
end

return unionV2_adj