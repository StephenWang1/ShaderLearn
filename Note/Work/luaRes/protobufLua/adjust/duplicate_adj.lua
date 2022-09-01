--[[本文件为工具自动生成,禁止手动修改]]
local duplicateV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable duplicateV2.ItemInfo
---@type duplicateV2.ItemInfo
duplicateV2_adj.metatable_ItemInfo = {
    _ClassName = "duplicateV2.ItemInfo",
}
duplicateV2_adj.metatable_ItemInfo.__index = duplicateV2_adj.metatable_ItemInfo
--endregion

---@param tbl duplicateV2.ItemInfo 待调整的table数据
function duplicateV2_adj.AdjustItemInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ItemInfo)
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

--region metatable duplicateV2.MonsterHpInfo
---@type duplicateV2.MonsterHpInfo
duplicateV2_adj.metatable_MonsterHpInfo = {
    _ClassName = "duplicateV2.MonsterHpInfo",
}
duplicateV2_adj.metatable_MonsterHpInfo.__index = duplicateV2_adj.metatable_MonsterHpInfo
--endregion

---@param tbl duplicateV2.MonsterHpInfo 待调整的table数据
function duplicateV2_adj.AdjustMonsterHpInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_MonsterHpInfo)
    if tbl.monsterId == nil then
        tbl.monsterIdSpecified = false
        tbl.monsterId = 0
    else
        tbl.monsterIdSpecified = true
    end
    if tbl.monsterHp == nil then
        tbl.monsterHpSpecified = false
        tbl.monsterHp = 0
    else
        tbl.monsterHpSpecified = true
    end
    if tbl.monsterCfgId == nil then
        tbl.monsterCfgIdSpecified = false
        tbl.monsterCfgId = 0
    else
        tbl.monsterCfgIdSpecified = true
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

--region metatable duplicateV2.PlayerHpInfo
---@type duplicateV2.PlayerHpInfo
duplicateV2_adj.metatable_PlayerHpInfo = {
    _ClassName = "duplicateV2.PlayerHpInfo",
}
duplicateV2_adj.metatable_PlayerHpInfo.__index = duplicateV2_adj.metatable_PlayerHpInfo
--endregion

---@param tbl duplicateV2.PlayerHpInfo 待调整的table数据
function duplicateV2_adj.AdjustPlayerHpInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_PlayerHpInfo)
    if tbl.playerId == nil then
        tbl.playerIdSpecified = false
        tbl.playerId = 0
    else
        tbl.playerIdSpecified = true
    end
    if tbl.percent == nil then
        tbl.percentSpecified = false
        tbl.percent = 0
    else
        tbl.percentSpecified = true
    end
    if tbl.percentIp == nil then
        tbl.percentIpSpecified = false
        tbl.percentIp = 0
    else
        tbl.percentIpSpecified = true
    end
end

--region metatable duplicateV2.PerformerEquipInfo
---@type duplicateV2.PerformerEquipInfo
duplicateV2_adj.metatable_PerformerEquipInfo = {
    _ClassName = "duplicateV2.PerformerEquipInfo",
}
duplicateV2_adj.metatable_PerformerEquipInfo.__index = duplicateV2_adj.metatable_PerformerEquipInfo
--endregion

---@param tbl duplicateV2.PerformerEquipInfo 待调整的table数据
function duplicateV2_adj.AdjustPerformerEquipInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_PerformerEquipInfo)
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

--region metatable duplicateV2.PerformerBufferInfo
---@type duplicateV2.PerformerBufferInfo
duplicateV2_adj.metatable_PerformerBufferInfo = {
    _ClassName = "duplicateV2.PerformerBufferInfo",
}
duplicateV2_adj.metatable_PerformerBufferInfo.__index = duplicateV2_adj.metatable_PerformerBufferInfo
--endregion

---@param tbl duplicateV2.PerformerBufferInfo 待调整的table数据
function duplicateV2_adj.AdjustPerformerBufferInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_PerformerBufferInfo)
    if tbl.bid == nil then
        tbl.bidSpecified = false
        tbl.bid = 0
    else
        tbl.bidSpecified = true
    end
    if tbl.cfgId == nil then
        tbl.cfgIdSpecified = false
        tbl.cfgId = 0
    else
        tbl.cfgIdSpecified = true
    end
end

--region metatable duplicateV2.PerformerFashionInfo
---@type duplicateV2.PerformerFashionInfo
duplicateV2_adj.metatable_PerformerFashionInfo = {
    _ClassName = "duplicateV2.PerformerFashionInfo",
}
duplicateV2_adj.metatable_PerformerFashionInfo.__index = duplicateV2_adj.metatable_PerformerFashionInfo
--endregion

---@param tbl duplicateV2.PerformerFashionInfo 待调整的table数据
function duplicateV2_adj.AdjustPerformerFashionInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_PerformerFashionInfo)
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

--region metatable duplicateV2.RoundMonster
---@type duplicateV2.RoundMonster
duplicateV2_adj.metatable_RoundMonster = {
    _ClassName = "duplicateV2.RoundMonster",
}
duplicateV2_adj.metatable_RoundMonster.__index = duplicateV2_adj.metatable_RoundMonster
--endregion

---@param tbl duplicateV2.RoundMonster 待调整的table数据
function duplicateV2_adj.AdjustRoundMonster(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_RoundMonster)
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
    if tbl.master == nil then
        tbl.masterSpecified = false
        tbl.master = 0
    else
        tbl.masterSpecified = true
    end
    if tbl.performerEquipInfo == nil then
        tbl.performerEquipInfo = {}
    else
        if duplicateV2_adj.AdjustPerformerEquipInfo ~= nil then
            for i = 1, #tbl.performerEquipInfo do
                duplicateV2_adj.AdjustPerformerEquipInfo(tbl.performerEquipInfo[i])
            end
        end
    end
    if tbl.performerBufferInfo == nil then
        tbl.performerBufferInfo = {}
    else
        if duplicateV2_adj.AdjustPerformerBufferInfo ~= nil then
            for i = 1, #tbl.performerBufferInfo do
                duplicateV2_adj.AdjustPerformerBufferInfo(tbl.performerBufferInfo[i])
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
    if tbl.fashionList == nil then
        tbl.fashionList = {}
    else
        if duplicateV2_adj.AdjustPerformerFashionInfo ~= nil then
            for i = 1, #tbl.fashionList do
                duplicateV2_adj.AdjustPerformerFashionInfo(tbl.fashionList[i])
            end
        end
    end
    if tbl.junxian == nil then
        tbl.junxianSpecified = false
        tbl.junxian = 0
    else
        tbl.junxianSpecified = true
    end
    if tbl.group == nil then
        tbl.groupSpecified = false
        tbl.group = 0
    else
        tbl.groupSpecified = true
    end
end

--region metatable duplicateV2.HurtRankInfo
---@type duplicateV2.HurtRankInfo
duplicateV2_adj.metatable_HurtRankInfo = {
    _ClassName = "duplicateV2.HurtRankInfo",
}
duplicateV2_adj.metatable_HurtRankInfo.__index = duplicateV2_adj.metatable_HurtRankInfo
--endregion

---@param tbl duplicateV2.HurtRankInfo 待调整的table数据
function duplicateV2_adj.AdjustHurtRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_HurtRankInfo)
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
    if tbl.rank == nil then
        tbl.rankSpecified = false
        tbl.rank = 0
    else
        tbl.rankSpecified = true
    end
    if tbl.hurt == nil then
        tbl.hurtSpecified = false
        tbl.hurt = 0
    else
        tbl.hurtSpecified = true
    end
end

--region metatable duplicateV2.ChallengeCountInfo
---@type duplicateV2.ChallengeCountInfo
duplicateV2_adj.metatable_ChallengeCountInfo = {
    _ClassName = "duplicateV2.ChallengeCountInfo",
}
duplicateV2_adj.metatable_ChallengeCountInfo.__index = duplicateV2_adj.metatable_ChallengeCountInfo
--endregion

---@param tbl duplicateV2.ChallengeCountInfo 待调整的table数据
function duplicateV2_adj.AdjustChallengeCountInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ChallengeCountInfo)
    if tbl.leftChallengeCount == nil then
        tbl.leftChallengeCountSpecified = false
        tbl.leftChallengeCount = 0
    else
        tbl.leftChallengeCountSpecified = true
    end
    if tbl.groupId == nil then
        tbl.groupIdSpecified = false
        tbl.groupId = 0
    else
        tbl.groupIdSpecified = true
    end
    if tbl.duplicateId == nil then
        tbl.duplicateId = {}
    end
end

--region metatable duplicateV2.CollectRewardBoxInfo
---@type duplicateV2.CollectRewardBoxInfo
duplicateV2_adj.metatable_CollectRewardBoxInfo = {
    _ClassName = "duplicateV2.CollectRewardBoxInfo",
}
duplicateV2_adj.metatable_CollectRewardBoxInfo.__index = duplicateV2_adj.metatable_CollectRewardBoxInfo
--endregion

---@param tbl duplicateV2.CollectRewardBoxInfo 待调整的table数据
function duplicateV2_adj.AdjustCollectRewardBoxInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_CollectRewardBoxInfo)
    if tbl.boxId == nil then
        tbl.boxIdSpecified = false
        tbl.boxId = 0
    else
        tbl.boxIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable duplicateV2.ResDuplicateBasicInfo
---@type duplicateV2.ResDuplicateBasicInfo
duplicateV2_adj.metatable_ResDuplicateBasicInfo = {
    _ClassName = "duplicateV2.ResDuplicateBasicInfo",
}
duplicateV2_adj.metatable_ResDuplicateBasicInfo.__index = duplicateV2_adj.metatable_ResDuplicateBasicInfo
--endregion

---@param tbl duplicateV2.ResDuplicateBasicInfo 待调整的table数据
function duplicateV2_adj.AdjustResDuplicateBasicInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResDuplicateBasicInfo)
    if tbl.cfgId == nil then
        tbl.cfgIdSpecified = false
        tbl.cfgId = 0
    else
        tbl.cfgIdSpecified = true
    end
    if tbl.line == nil then
        tbl.lineSpecified = false
        tbl.line = 0
    else
        tbl.lineSpecified = true
    end
    if tbl.createTime == nil then
        tbl.createTimeSpecified = false
        tbl.createTime = 0
    else
        tbl.createTimeSpecified = true
    end
end

--region metatable duplicateV2.ReqEnterDuplicate
---@type duplicateV2.ReqEnterDuplicate
duplicateV2_adj.metatable_ReqEnterDuplicate = {
    _ClassName = "duplicateV2.ReqEnterDuplicate",
}
duplicateV2_adj.metatable_ReqEnterDuplicate.__index = duplicateV2_adj.metatable_ReqEnterDuplicate
--endregion

---@param tbl duplicateV2.ReqEnterDuplicate 待调整的table数据
function duplicateV2_adj.AdjustReqEnterDuplicate(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqEnterDuplicate)
    if tbl.duplicateId == nil then
        tbl.duplicateIdSpecified = false
        tbl.duplicateId = 0
    else
        tbl.duplicateIdSpecified = true
    end
    if tbl.costType == nil then
        tbl.costTypeSpecified = false
        tbl.costType = 0
    else
        tbl.costTypeSpecified = true
    end
end

--region metatable duplicateV2.ResDuplicateEnd
---@type duplicateV2.ResDuplicateEnd
duplicateV2_adj.metatable_ResDuplicateEnd = {
    _ClassName = "duplicateV2.ResDuplicateEnd",
}
duplicateV2_adj.metatable_ResDuplicateEnd.__index = duplicateV2_adj.metatable_ResDuplicateEnd
--endregion

---@param tbl duplicateV2.ResDuplicateEnd 待调整的table数据
function duplicateV2_adj.AdjustResDuplicateEnd(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResDuplicateEnd)
    if tbl.sucess == nil then
        tbl.sucessSpecified = false
        tbl.sucess = false
    else
        tbl.sucessSpecified = true
    end
    if tbl.waitingTime == nil then
        tbl.waitingTimeSpecified = false
        tbl.waitingTime = 0
    else
        tbl.waitingTimeSpecified = true
    end
    if tbl.showAwardList == nil then
        tbl.showAwardList = {}
    else
        if adjustTable.common_adj ~= nil and adjustTable.common_adj.AdjustIntIntStruct ~= nil then
            for i = 1, #tbl.showAwardList do
                adjustTable.common_adj.AdjustIntIntStruct(tbl.showAwardList[i])
            end
        end
    end
end

--region metatable duplicateV2.ResPerformTotalHp
---@type duplicateV2.ResPerformTotalHp
duplicateV2_adj.metatable_ResPerformTotalHp = {
    _ClassName = "duplicateV2.ResPerformTotalHp",
}
duplicateV2_adj.metatable_ResPerformTotalHp.__index = duplicateV2_adj.metatable_ResPerformTotalHp
--endregion

---@param tbl duplicateV2.ResPerformTotalHp 待调整的table数据
function duplicateV2_adj.AdjustResPerformTotalHp(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResPerformTotalHp)
    if tbl.monsterList == nil then
        tbl.monsterList = {}
    else
        if duplicateV2_adj.AdjustMonsterHpInfo ~= nil then
            for i = 1, #tbl.monsterList do
                duplicateV2_adj.AdjustMonsterHpInfo(tbl.monsterList[i])
            end
        end
    end
    if tbl.playerList == nil then
        tbl.playerList = {}
    else
        if duplicateV2_adj.AdjustPlayerHpInfo ~= nil then
            for i = 1, #tbl.playerList do
                duplicateV2_adj.AdjustPlayerHpInfo(tbl.playerList[i])
            end
        end
    end
end

--region metatable duplicateV2.ResUpdateTianTiMonsterInfo
---@type duplicateV2.ResUpdateTianTiMonsterInfo
duplicateV2_adj.metatable_ResUpdateTianTiMonsterInfo = {
    _ClassName = "duplicateV2.ResUpdateTianTiMonsterInfo",
}
duplicateV2_adj.metatable_ResUpdateTianTiMonsterInfo.__index = duplicateV2_adj.metatable_ResUpdateTianTiMonsterInfo
--endregion

---@param tbl duplicateV2.ResUpdateTianTiMonsterInfo 待调整的table数据
function duplicateV2_adj.AdjustResUpdateTianTiMonsterInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResUpdateTianTiMonsterInfo)
    if tbl.monsters == nil then
        tbl.monsters = {}
    else
        if duplicateV2_adj.AdjustRoundMonster ~= nil then
            for i = 1, #tbl.monsters do
                duplicateV2_adj.AdjustRoundMonster(tbl.monsters[i])
            end
        end
    end
end

--region metatable duplicateV2.ReqDuplicatePanelInfo
---@type duplicateV2.ReqDuplicatePanelInfo
duplicateV2_adj.metatable_ReqDuplicatePanelInfo = {
    _ClassName = "duplicateV2.ReqDuplicatePanelInfo",
}
duplicateV2_adj.metatable_ReqDuplicatePanelInfo.__index = duplicateV2_adj.metatable_ReqDuplicatePanelInfo
--endregion

---@param tbl duplicateV2.ReqDuplicatePanelInfo 待调整的table数据
function duplicateV2_adj.AdjustReqDuplicatePanelInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqDuplicatePanelInfo)
    if tbl.duplicateType == nil then
        tbl.duplicateTypeSpecified = false
        tbl.duplicateType = 0
    else
        tbl.duplicateTypeSpecified = true
    end
end

--region metatable duplicateV2.ResDuplicatePanelInfo
---@type duplicateV2.ResDuplicatePanelInfo
duplicateV2_adj.metatable_ResDuplicatePanelInfo = {
    _ClassName = "duplicateV2.ResDuplicatePanelInfo",
}
duplicateV2_adj.metatable_ResDuplicatePanelInfo.__index = duplicateV2_adj.metatable_ResDuplicatePanelInfo
--endregion

---@param tbl duplicateV2.ResDuplicatePanelInfo 待调整的table数据
function duplicateV2_adj.AdjustResDuplicatePanelInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResDuplicatePanelInfo)
    if tbl.duplicateId == nil then
        tbl.duplicateIdSpecified = false
        tbl.duplicateId = 0
    else
        tbl.duplicateIdSpecified = true
    end
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
    if tbl.hp == nil then
        tbl.hpSpecified = false
        tbl.hp = 0
    else
        tbl.hpSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable duplicateV2.ResSendHurtRankInfo
---@type duplicateV2.ResSendHurtRankInfo
duplicateV2_adj.metatable_ResSendHurtRankInfo = {
    _ClassName = "duplicateV2.ResSendHurtRankInfo",
}
duplicateV2_adj.metatable_ResSendHurtRankInfo.__index = duplicateV2_adj.metatable_ResSendHurtRankInfo
--endregion

---@param tbl duplicateV2.ResSendHurtRankInfo 待调整的table数据
function duplicateV2_adj.AdjustResSendHurtRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResSendHurtRankInfo)
    if tbl.ranks == nil then
        tbl.ranks = {}
    else
        if duplicateV2_adj.AdjustHurtRankInfo ~= nil then
            for i = 1, #tbl.ranks do
                duplicateV2_adj.AdjustHurtRankInfo(tbl.ranks[i])
            end
        end
    end
    if tbl.selfRank == nil then
        tbl.selfRankSpecified = false
        tbl.selfRank = nil
    else
        if tbl.selfRankSpecified == nil then 
            tbl.selfRankSpecified = true
            if duplicateV2_adj.AdjustHurtRankInfo ~= nil then
                duplicateV2_adj.AdjustHurtRankInfo(tbl.selfRank)
            end
        end
    end
end

--region metatable duplicateV2.ResDuplicateLeftChallengeCount
---@type duplicateV2.ResDuplicateLeftChallengeCount
duplicateV2_adj.metatable_ResDuplicateLeftChallengeCount = {
    _ClassName = "duplicateV2.ResDuplicateLeftChallengeCount",
}
duplicateV2_adj.metatable_ResDuplicateLeftChallengeCount.__index = duplicateV2_adj.metatable_ResDuplicateLeftChallengeCount
--endregion

---@param tbl duplicateV2.ResDuplicateLeftChallengeCount 待调整的table数据
function duplicateV2_adj.AdjustResDuplicateLeftChallengeCount(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResDuplicateLeftChallengeCount)
    if tbl.countInfoList == nil then
        tbl.countInfoList = {}
    else
        if duplicateV2_adj.AdjustChallengeCountInfo ~= nil then
            for i = 1, #tbl.countInfoList do
                duplicateV2_adj.AdjustChallengeCountInfo(tbl.countInfoList[i])
            end
        end
    end
end

--region metatable duplicateV2.ResDuplicateReward
---@type duplicateV2.ResDuplicateReward
duplicateV2_adj.metatable_ResDuplicateReward = {
    _ClassName = "duplicateV2.ResDuplicateReward",
}
duplicateV2_adj.metatable_ResDuplicateReward.__index = duplicateV2_adj.metatable_ResDuplicateReward
--endregion

---@param tbl duplicateV2.ResDuplicateReward 待调整的table数据
function duplicateV2_adj.AdjustResDuplicateReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResDuplicateReward)
    if tbl.sucess == nil then
        tbl.sucessSpecified = false
        tbl.sucess = false
    else
        tbl.sucessSpecified = true
    end
    if tbl.itemInfo == nil then
        tbl.itemInfo = {}
    else
        if duplicateV2_adj.AdjustItemInfo ~= nil then
            for i = 1, #tbl.itemInfo do
                duplicateV2_adj.AdjustItemInfo(tbl.itemInfo[i])
            end
        end
    end
end

--region metatable duplicateV2.ResTreasureMapCollectInitInfo
---@type duplicateV2.ResTreasureMapCollectInitInfo
duplicateV2_adj.metatable_ResTreasureMapCollectInitInfo = {
    _ClassName = "duplicateV2.ResTreasureMapCollectInitInfo",
}
duplicateV2_adj.metatable_ResTreasureMapCollectInitInfo.__index = duplicateV2_adj.metatable_ResTreasureMapCollectInitInfo
--endregion

---@param tbl duplicateV2.ResTreasureMapCollectInitInfo 待调整的table数据
function duplicateV2_adj.AdjustResTreasureMapCollectInitInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResTreasureMapCollectInitInfo)
    if tbl.allRewards == nil then
        tbl.allRewards = {}
    else
        if duplicateV2_adj.AdjustCollectRewardBoxInfo ~= nil then
            for i = 1, #tbl.allRewards do
                duplicateV2_adj.AdjustCollectRewardBoxInfo(tbl.allRewards[i])
            end
        end
    end
    if tbl.alreadyCollected == nil then
        tbl.alreadyCollected = {}
    end
    if tbl.overTime == nil then
        tbl.overTimeSpecified = false
        tbl.overTime = 0
    else
        tbl.overTimeSpecified = true
    end
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
end

--region metatable duplicateV2.ResTreasureMapCollectChangeInfo
---@type duplicateV2.ResTreasureMapCollectChangeInfo
duplicateV2_adj.metatable_ResTreasureMapCollectChangeInfo = {
    _ClassName = "duplicateV2.ResTreasureMapCollectChangeInfo",
}
duplicateV2_adj.metatable_ResTreasureMapCollectChangeInfo.__index = duplicateV2_adj.metatable_ResTreasureMapCollectChangeInfo
--endregion

---@param tbl duplicateV2.ResTreasureMapCollectChangeInfo 待调整的table数据
function duplicateV2_adj.AdjustResTreasureMapCollectChangeInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResTreasureMapCollectChangeInfo)
    if tbl.collectedIndex == nil then
        tbl.collectedIndexSpecified = false
        tbl.collectedIndex = 0
    else
        tbl.collectedIndexSpecified = true
    end
end

--region metatable duplicateV2.ReqLeaveDuplicate
---@type duplicateV2.ReqLeaveDuplicate
duplicateV2_adj.metatable_ReqLeaveDuplicate = {
    _ClassName = "duplicateV2.ReqLeaveDuplicate",
}
duplicateV2_adj.metatable_ReqLeaveDuplicate.__index = duplicateV2_adj.metatable_ReqLeaveDuplicate
--endregion

---@param tbl duplicateV2.ReqLeaveDuplicate 待调整的table数据
function duplicateV2_adj.AdjustReqLeaveDuplicate(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqLeaveDuplicate)
end

--region metatable duplicateV2.ReqDuplicateReward
---@type duplicateV2.ReqDuplicateReward
duplicateV2_adj.metatable_ReqDuplicateReward = {
    _ClassName = "duplicateV2.ReqDuplicateReward",
}
duplicateV2_adj.metatable_ReqDuplicateReward.__index = duplicateV2_adj.metatable_ReqDuplicateReward
--endregion

---@param tbl duplicateV2.ReqDuplicateReward 待调整的table数据
function duplicateV2_adj.AdjustReqDuplicateReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqDuplicateReward)
end

--region metatable duplicateV2.SabacInfo
---@type duplicateV2.SabacInfo
duplicateV2_adj.metatable_SabacInfo = {
    _ClassName = "duplicateV2.SabacInfo",
}
duplicateV2_adj.metatable_SabacInfo.__index = duplicateV2_adj.metatable_SabacInfo
--endregion

---@param tbl duplicateV2.SabacInfo 待调整的table数据
function duplicateV2_adj.AdjustSabacInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_SabacInfo)
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
    if tbl.flagDieTime == nil then
        tbl.flagDieTimeSpecified = false
        tbl.flagDieTime = 0
    else
        tbl.flagDieTimeSpecified = true
    end
    if tbl.yuanbao == nil then
        tbl.yuanbaoSpecified = false
        tbl.yuanbao = 0
    else
        tbl.yuanbaoSpecified = true
    end
    if tbl.isOpen == nil then
        tbl.isOpenSpecified = false
        tbl.isOpen = false
    else
        tbl.isOpenSpecified = true
    end
    if tbl.tacticsCoolDownTime == nil then
        tbl.tacticsCoolDownTimeSpecified = false
        tbl.tacticsCoolDownTime = 0
    else
        tbl.tacticsCoolDownTimeSpecified = true
    end
    if tbl.activeTacticsPoints == nil then
        tbl.activeTacticsPoints = {}
    end
    if tbl.tacticsActiveTime == nil then
        tbl.tacticsActiveTimeSpecified = false
        tbl.tacticsActiveTime = 0
    else
        tbl.tacticsActiveTimeSpecified = true
    end
    if tbl.uniteId == nil then
        tbl.uniteIdSpecified = false
        tbl.uniteId = 0
    else
        tbl.uniteIdSpecified = true
    end
    if tbl.uniteType == nil then
        tbl.uniteTypeSpecified = false
        tbl.uniteType = 0
    else
        tbl.uniteTypeSpecified = true
    end
end

--region metatable duplicateV2.SabacScoreInfo
---@type duplicateV2.SabacScoreInfo
duplicateV2_adj.metatable_SabacScoreInfo = {
    _ClassName = "duplicateV2.SabacScoreInfo",
}
duplicateV2_adj.metatable_SabacScoreInfo.__index = duplicateV2_adj.metatable_SabacScoreInfo
--endregion

---@param tbl duplicateV2.SabacScoreInfo 待调整的table数据
function duplicateV2_adj.AdjustSabacScoreInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_SabacScoreInfo)
    if tbl.killScore == nil then
        tbl.killScoreSpecified = false
        tbl.killScore = 0
    else
        tbl.killScoreSpecified = true
    end
    if tbl.guardScore == nil then
        tbl.guardScoreSpecified = false
        tbl.guardScore = 0
    else
        tbl.guardScoreSpecified = true
    end
    if tbl.loseScore == nil then
        tbl.loseScoreSpecified = false
        tbl.loseScore = 0
    else
        tbl.loseScoreSpecified = true
    end
    if tbl.Score == nil then
        tbl.ScoreSpecified = false
        tbl.Score = 0
    else
        tbl.ScoreSpecified = true
    end
    if tbl.rewards == nil then
        tbl.rewards = {}
    else
        if duplicateV2_adj.AdjustSabacReward ~= nil then
            for i = 1, #tbl.rewards do
                duplicateV2_adj.AdjustSabacReward(tbl.rewards[i])
            end
        end
    end
end

--region metatable duplicateV2.SabacPanelInfo
---@type duplicateV2.SabacPanelInfo
duplicateV2_adj.metatable_SabacPanelInfo = {
    _ClassName = "duplicateV2.SabacPanelInfo",
}
duplicateV2_adj.metatable_SabacPanelInfo.__index = duplicateV2_adj.metatable_SabacPanelInfo
--endregion

---@param tbl duplicateV2.SabacPanelInfo 待调整的table数据
function duplicateV2_adj.AdjustSabacPanelInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_SabacPanelInfo)
    if tbl.mayor == nil then
        tbl.mayorSpecified = false
        tbl.mayor = nil
    else
        if tbl.mayorSpecified == nil then 
            tbl.mayorSpecified = true
            if adjustTable.role_adj ~= nil and adjustTable.role_adj.AdjustResPlayerBasicInfo ~= nil then
                adjustTable.role_adj.AdjustResPlayerBasicInfo(tbl.mayor)
            end
        end
    end
    if tbl.union == nil then
        tbl.unionSpecified = false
        tbl.union = nil
    else
        if tbl.unionSpecified == nil then 
            tbl.unionSpecified = true
            if adjustTable.union_adj ~= nil and adjustTable.union_adj.AdjustUnionInfo ~= nil then
                adjustTable.union_adj.AdjustUnionInfo(tbl.union)
            end
        end
    end
    if tbl.cityName == nil then
        tbl.cityNameSpecified = false
        tbl.cityName = ""
    else
        tbl.cityNameSpecified = true
    end
    if tbl.occupyTime == nil then
        tbl.occupyTimeSpecified = false
        tbl.occupyTime = 0
    else
        tbl.occupyTimeSpecified = true
    end
    if tbl.officers == nil then
        tbl.officers = {}
    else
        if adjustTable.role_adj ~= nil and adjustTable.role_adj.AdjustResPlayerBasicInfo ~= nil then
            for i = 1, #tbl.officers do
                adjustTable.role_adj.AdjustResPlayerBasicInfo(tbl.officers[i])
            end
        end
    end
    if tbl.mayorDayGift == nil then
        tbl.mayorDayGiftSpecified = false
        tbl.mayorDayGift = false
    else
        tbl.mayorDayGiftSpecified = true
    end
end

--region metatable duplicateV2.TyrantDuplicateScore
---@type duplicateV2.TyrantDuplicateScore
duplicateV2_adj.metatable_TyrantDuplicateScore = {
    _ClassName = "duplicateV2.TyrantDuplicateScore",
}
duplicateV2_adj.metatable_TyrantDuplicateScore.__index = duplicateV2_adj.metatable_TyrantDuplicateScore
--endregion

---@param tbl duplicateV2.TyrantDuplicateScore 待调整的table数据
function duplicateV2_adj.AdjustTyrantDuplicateScore(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_TyrantDuplicateScore)
    if tbl.thisPlayerInfo == nil then
        tbl.thisPlayerInfo = {}
    else
        if duplicateV2_adj.AdjustThisPlayerInfo ~= nil then
            for i = 1, #tbl.thisPlayerInfo do
                duplicateV2_adj.AdjustThisPlayerInfo(tbl.thisPlayerInfo[i])
            end
        end
    end
end

--region metatable duplicateV2.ThisPlayerInfo
---@type duplicateV2.ThisPlayerInfo
duplicateV2_adj.metatable_ThisPlayerInfo = {
    _ClassName = "duplicateV2.ThisPlayerInfo",
}
duplicateV2_adj.metatable_ThisPlayerInfo.__index = duplicateV2_adj.metatable_ThisPlayerInfo
--endregion

---@param tbl duplicateV2.ThisPlayerInfo 待调整的table数据
function duplicateV2_adj.AdjustThisPlayerInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ThisPlayerInfo)
    if tbl.playerId == nil then
        tbl.playerIdSpecified = false
        tbl.playerId = 0
    else
        tbl.playerIdSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.yuanBaoNum == nil then
        tbl.yuanBaoNumSpecified = false
        tbl.yuanBaoNum = 0
    else
        tbl.yuanBaoNumSpecified = true
    end
    if tbl.bindGoldNum == nil then
        tbl.bindGoldNumSpecified = false
        tbl.bindGoldNum = 0
    else
        tbl.bindGoldNumSpecified = true
    end
    if tbl.bindYuanBaoNum == nil then
        tbl.bindYuanBaoNumSpecified = false
        tbl.bindYuanBaoNum = 0
    else
        tbl.bindYuanBaoNumSpecified = true
    end
    if tbl.score == nil then
        tbl.scoreSpecified = false
        tbl.score = 0
    else
        tbl.scoreSpecified = true
    end
    if tbl.no == nil then
        tbl.noSpecified = false
        tbl.no = 0
    else
        tbl.noSpecified = true
    end
end

--region metatable duplicateV2.ReqAutoFinshDuplicate
---@type duplicateV2.ReqAutoFinshDuplicate
duplicateV2_adj.metatable_ReqAutoFinshDuplicate = {
    _ClassName = "duplicateV2.ReqAutoFinshDuplicate",
}
duplicateV2_adj.metatable_ReqAutoFinshDuplicate.__index = duplicateV2_adj.metatable_ReqAutoFinshDuplicate
--endregion

---@param tbl duplicateV2.ReqAutoFinshDuplicate 待调整的table数据
function duplicateV2_adj.AdjustReqAutoFinshDuplicate(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqAutoFinshDuplicate)
end

--region metatable duplicateV2.ResAutoFinshDuplicate
---@type duplicateV2.ResAutoFinshDuplicate
duplicateV2_adj.metatable_ResAutoFinshDuplicate = {
    _ClassName = "duplicateV2.ResAutoFinshDuplicate",
}
duplicateV2_adj.metatable_ResAutoFinshDuplicate.__index = duplicateV2_adj.metatable_ResAutoFinshDuplicate
--endregion

---@param tbl duplicateV2.ResAutoFinshDuplicate 待调整的table数据
function duplicateV2_adj.AdjustResAutoFinshDuplicate(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResAutoFinshDuplicate)
    if tbl.cfgId == nil then
        tbl.cfgIdSpecified = false
        tbl.cfgId = 0
    else
        tbl.cfgIdSpecified = true
    end
end

--region metatable duplicateV2.ReqInspireBuff
---@type duplicateV2.ReqInspireBuff
duplicateV2_adj.metatable_ReqInspireBuff = {
    _ClassName = "duplicateV2.ReqInspireBuff",
}
duplicateV2_adj.metatable_ReqInspireBuff.__index = duplicateV2_adj.metatable_ReqInspireBuff
--endregion

---@param tbl duplicateV2.ReqInspireBuff 待调整的table数据
function duplicateV2_adj.AdjustReqInspireBuff(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqInspireBuff)
    if tbl.inspireType == nil then
        tbl.inspireTypeSpecified = false
        tbl.inspireType = 0
    else
        tbl.inspireTypeSpecified = true
    end
    if tbl.playerId == nil then
        tbl.playerIdSpecified = false
        tbl.playerId = 0
    else
        tbl.playerIdSpecified = true
    end
end

--region metatable duplicateV2.ResInspireBuff
---@type duplicateV2.ResInspireBuff
duplicateV2_adj.metatable_ResInspireBuff = {
    _ClassName = "duplicateV2.ResInspireBuff",
}
duplicateV2_adj.metatable_ResInspireBuff.__index = duplicateV2_adj.metatable_ResInspireBuff
--endregion

---@param tbl duplicateV2.ResInspireBuff 待调整的table数据
function duplicateV2_adj.AdjustResInspireBuff(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResInspireBuff)
    if tbl.thisPercentage == nil then
        tbl.thisPercentageSpecified = false
        tbl.thisPercentage = 0
    else
        tbl.thisPercentageSpecified = true
    end
end

--region metatable duplicateV2.ResTyrantDeath
---@type duplicateV2.ResTyrantDeath
duplicateV2_adj.metatable_ResTyrantDeath = {
    _ClassName = "duplicateV2.ResTyrantDeath",
}
duplicateV2_adj.metatable_ResTyrantDeath.__index = duplicateV2_adj.metatable_ResTyrantDeath
--endregion

---@param tbl duplicateV2.ResTyrantDeath 待调整的table数据
function duplicateV2_adj.AdjustResTyrantDeath(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResTyrantDeath)
    if tbl.playerId == nil then
        tbl.playerIdSpecified = false
        tbl.playerId = 0
    else
        tbl.playerIdSpecified = true
    end
end

--region metatable duplicateV2.ResDuplicateItem
---@type duplicateV2.ResDuplicateItem
duplicateV2_adj.metatable_ResDuplicateItem = {
    _ClassName = "duplicateV2.ResDuplicateItem",
}
duplicateV2_adj.metatable_ResDuplicateItem.__index = duplicateV2_adj.metatable_ResDuplicateItem
--endregion

---@param tbl duplicateV2.ResDuplicateItem 待调整的table数据
function duplicateV2_adj.AdjustResDuplicateItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResDuplicateItem)
    if tbl.playerId == nil then
        tbl.playerIdSpecified = false
        tbl.playerId = 0
    else
        tbl.playerIdSpecified = true
    end
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
    if tbl.param == nil then
        tbl.paramSpecified = false
        tbl.param = 0
    else
        tbl.paramSpecified = true
    end
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.specialParam == nil then
        tbl.specialParamSpecified = false
        tbl.specialParam = 0
    else
        tbl.specialParamSpecified = true
    end
end

--region metatable duplicateV2.ResDuplicateInfo
---@type duplicateV2.ResDuplicateInfo
duplicateV2_adj.metatable_ResDuplicateInfo = {
    _ClassName = "duplicateV2.ResDuplicateInfo",
}
duplicateV2_adj.metatable_ResDuplicateInfo.__index = duplicateV2_adj.metatable_ResDuplicateInfo
--endregion

---@param tbl duplicateV2.ResDuplicateInfo 待调整的table数据
function duplicateV2_adj.AdjustResDuplicateInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResDuplicateInfo)
    if tbl.playerId == nil then
        tbl.playerIdSpecified = false
        tbl.playerId = 0
    else
        tbl.playerIdSpecified = true
    end
    if tbl.duplicateId == nil then
        tbl.duplicateIdSpecified = false
        tbl.duplicateId = 0
    else
        tbl.duplicateIdSpecified = true
    end
    if tbl.maxFloorId == nil then
        tbl.maxFloorIdSpecified = false
        tbl.maxFloorId = 0
    else
        tbl.maxFloorIdSpecified = true
    end
end

--region metatable duplicateV2.CavesPlayerInfo
---@type duplicateV2.CavesPlayerInfo
duplicateV2_adj.metatable_CavesPlayerInfo = {
    _ClassName = "duplicateV2.CavesPlayerInfo",
}
duplicateV2_adj.metatable_CavesPlayerInfo.__index = duplicateV2_adj.metatable_CavesPlayerInfo
--endregion

---@param tbl duplicateV2.CavesPlayerInfo 待调整的table数据
function duplicateV2_adj.AdjustCavesPlayerInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_CavesPlayerInfo)
    if tbl.duplicateItem == nil then
        tbl.duplicateItemSpecified = false
        tbl.duplicateItem = nil
    else
        if tbl.duplicateItemSpecified == nil then 
            tbl.duplicateItemSpecified = true
            if duplicateV2_adj.AdjustResDuplicateItem ~= nil then
                duplicateV2_adj.AdjustResDuplicateItem(tbl.duplicateItem)
            end
        end
    end
    if tbl.no == nil then
        tbl.noSpecified = false
        tbl.no = 0
    else
        tbl.noSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
end

--region metatable duplicateV2.CavesDuplicateRankInfo
---@type duplicateV2.CavesDuplicateRankInfo
duplicateV2_adj.metatable_CavesDuplicateRankInfo = {
    _ClassName = "duplicateV2.CavesDuplicateRankInfo",
}
duplicateV2_adj.metatable_CavesDuplicateRankInfo.__index = duplicateV2_adj.metatable_CavesDuplicateRankInfo
--endregion

---@param tbl duplicateV2.CavesDuplicateRankInfo 待调整的table数据
function duplicateV2_adj.AdjustCavesDuplicateRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_CavesDuplicateRankInfo)
    if tbl.duplicateRank == nil then
        tbl.duplicateRank = {}
    else
        if duplicateV2_adj.AdjustCavesPlayerInfo ~= nil then
            for i = 1, #tbl.duplicateRank do
                duplicateV2_adj.AdjustCavesPlayerInfo(tbl.duplicateRank[i])
            end
        end
    end
end

--region metatable duplicateV2.CavesDuplicateInitTime
---@type duplicateV2.CavesDuplicateInitTime
duplicateV2_adj.metatable_CavesDuplicateInitTime = {
    _ClassName = "duplicateV2.CavesDuplicateInitTime",
}
duplicateV2_adj.metatable_CavesDuplicateInitTime.__index = duplicateV2_adj.metatable_CavesDuplicateInitTime
--endregion

---@param tbl duplicateV2.CavesDuplicateInitTime 待调整的table数据
function duplicateV2_adj.AdjustCavesDuplicateInitTime(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_CavesDuplicateInitTime)
    if tbl.initTime == nil then
        tbl.initTimeSpecified = false
        tbl.initTime = 0
    else
        tbl.initTimeSpecified = true
    end
end

--region metatable duplicateV2.ReqMausoleumDuplicate
---@type duplicateV2.ReqMausoleumDuplicate
duplicateV2_adj.metatable_ReqMausoleumDuplicate = {
    _ClassName = "duplicateV2.ReqMausoleumDuplicate",
}
duplicateV2_adj.metatable_ReqMausoleumDuplicate.__index = duplicateV2_adj.metatable_ReqMausoleumDuplicate
--endregion

---@param tbl duplicateV2.ReqMausoleumDuplicate 待调整的table数据
function duplicateV2_adj.AdjustReqMausoleumDuplicate(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqMausoleumDuplicate)
    if tbl.playerId == nil then
        tbl.playerIdSpecified = false
        tbl.playerId = 0
    else
        tbl.playerIdSpecified = true
    end
end

--region metatable duplicateV2.ResGodPower
---@type duplicateV2.ResGodPower
duplicateV2_adj.metatable_ResGodPower = {
    _ClassName = "duplicateV2.ResGodPower",
}
duplicateV2_adj.metatable_ResGodPower.__index = duplicateV2_adj.metatable_ResGodPower
--endregion

---@param tbl duplicateV2.ResGodPower 待调整的table数据
function duplicateV2_adj.AdjustResGodPower(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResGodPower)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.startTime == nil then
        tbl.startTimeSpecified = false
        tbl.startTime = 0
    else
        tbl.startTimeSpecified = true
    end
    if tbl.entryTimeEnd == nil then
        tbl.entryTimeEndSpecified = false
        tbl.entryTimeEnd = 0
    else
        tbl.entryTimeEndSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
    if tbl.thisMapId == nil then
        tbl.thisMapIdSpecified = false
        tbl.thisMapId = 0
    else
        tbl.thisMapIdSpecified = true
    end
    if tbl.bossSurvival == nil then
        tbl.bossSurvivalSpecified = false
        tbl.bossSurvival = false
    else
        tbl.bossSurvivalSpecified = true
    end
end

--region metatable duplicateV2.ResEntryTokenItem
---@type duplicateV2.ResEntryTokenItem
duplicateV2_adj.metatable_ResEntryTokenItem = {
    _ClassName = "duplicateV2.ResEntryTokenItem",
}
duplicateV2_adj.metatable_ResEntryTokenItem.__index = duplicateV2_adj.metatable_ResEntryTokenItem
--endregion

---@param tbl duplicateV2.ResEntryTokenItem 待调整的table数据
function duplicateV2_adj.AdjustResEntryTokenItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResEntryTokenItem)
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

--region metatable duplicateV2.ResWolfDreamTime
---@type duplicateV2.ResWolfDreamTime
duplicateV2_adj.metatable_ResWolfDreamTime = {
    _ClassName = "duplicateV2.ResWolfDreamTime",
}
duplicateV2_adj.metatable_ResWolfDreamTime.__index = duplicateV2_adj.metatable_ResWolfDreamTime
--endregion

---@param tbl duplicateV2.ResWolfDreamTime 待调整的table数据
function duplicateV2_adj.AdjustResWolfDreamTime(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResWolfDreamTime)
    if tbl.useTime == nil then
        tbl.useTimeSpecified = false
        tbl.useTime = 0
    else
        tbl.useTimeSpecified = true
    end
    if tbl.remainTime == nil then
        tbl.remainTimeSpecified = false
        tbl.remainTime = 0
    else
        tbl.remainTimeSpecified = true
    end
end

--region metatable duplicateV2.ResSanctuarySpaceInfo
---@type duplicateV2.ResSanctuarySpaceInfo
duplicateV2_adj.metatable_ResSanctuarySpaceInfo = {
    _ClassName = "duplicateV2.ResSanctuarySpaceInfo",
}
duplicateV2_adj.metatable_ResSanctuarySpaceInfo.__index = duplicateV2_adj.metatable_ResSanctuarySpaceInfo
--endregion

---@param tbl duplicateV2.ResSanctuarySpaceInfo 待调整的table数据
function duplicateV2_adj.AdjustResSanctuarySpaceInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResSanctuarySpaceInfo)
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable duplicateV2.ReqButSanctuaryCount
---@type duplicateV2.ReqButSanctuaryCount
duplicateV2_adj.metatable_ReqButSanctuaryCount = {
    _ClassName = "duplicateV2.ReqButSanctuaryCount",
}
duplicateV2_adj.metatable_ReqButSanctuaryCount.__index = duplicateV2_adj.metatable_ReqButSanctuaryCount
--endregion

---@param tbl duplicateV2.ReqButSanctuaryCount 待调整的table数据
function duplicateV2_adj.AdjustReqButSanctuaryCount(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqButSanctuaryCount)
    if tbl.buyCount == nil then
        tbl.buyCountSpecified = false
        tbl.buyCount = 0
    else
        tbl.buyCountSpecified = true
    end
end

--region metatable duplicateV2.ResDuplicateBossInfo
---@type duplicateV2.ResDuplicateBossInfo
duplicateV2_adj.metatable_ResDuplicateBossInfo = {
    _ClassName = "duplicateV2.ResDuplicateBossInfo",
}
duplicateV2_adj.metatable_ResDuplicateBossInfo.__index = duplicateV2_adj.metatable_ResDuplicateBossInfo
--endregion

---@param tbl duplicateV2.ResDuplicateBossInfo 待调整的table数据
function duplicateV2_adj.AdjustResDuplicateBossInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResDuplicateBossInfo)
    if tbl.bossSurvival == nil then
        tbl.bossSurvivalSpecified = false
        tbl.bossSurvival = false
    else
        tbl.bossSurvivalSpecified = true
    end
end

--region metatable duplicateV2.ResPrisonRemainTime
---@type duplicateV2.ResPrisonRemainTime
duplicateV2_adj.metatable_ResPrisonRemainTime = {
    _ClassName = "duplicateV2.ResPrisonRemainTime",
}
duplicateV2_adj.metatable_ResPrisonRemainTime.__index = duplicateV2_adj.metatable_ResPrisonRemainTime
--endregion

---@param tbl duplicateV2.ResPrisonRemainTime 待调整的table数据
function duplicateV2_adj.AdjustResPrisonRemainTime(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResPrisonRemainTime)
    if tbl.player == nil then
        tbl.playerSpecified = false
        tbl.player = 0
    else
        tbl.playerSpecified = true
    end
    if tbl.remainTime == nil then
        tbl.remainTimeSpecified = false
        tbl.remainTime = 0
    else
        tbl.remainTimeSpecified = true
    end
    if tbl.isPrisoner == nil then
        tbl.isPrisonerSpecified = false
        tbl.isPrisoner = false
    else
        tbl.isPrisonerSpecified = true
    end
end

--region metatable duplicateV2.SabacRankInfo
---@type duplicateV2.SabacRankInfo
duplicateV2_adj.metatable_SabacRankInfo = {
    _ClassName = "duplicateV2.SabacRankInfo",
}
duplicateV2_adj.metatable_SabacRankInfo.__index = duplicateV2_adj.metatable_SabacRankInfo
--endregion

---@param tbl duplicateV2.SabacRankInfo 待调整的table数据
function duplicateV2_adj.AdjustSabacRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_SabacRankInfo)
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
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.score == nil then
        tbl.scoreSpecified = false
        tbl.score = 0
    else
        tbl.scoreSpecified = true
    end
    if tbl.killCount == nil then
        tbl.killCountSpecified = false
        tbl.killCount = 0
    else
        tbl.killCountSpecified = true
    end
    if tbl.dieCount == nil then
        tbl.dieCountSpecified = false
        tbl.dieCount = 0
    else
        tbl.dieCountSpecified = true
    end
    if tbl.loseItems == nil then
        tbl.loseItems = {}
    end
    if tbl.rank == nil then
        tbl.rankSpecified = false
        tbl.rank = 0
    else
        tbl.rankSpecified = true
    end
    if tbl.damage == nil then
        tbl.damageSpecified = false
        tbl.damage = 0
    else
        tbl.damageSpecified = true
    end
    if tbl.hurt == nil then
        tbl.hurtSpecified = false
        tbl.hurt = 0
    else
        tbl.hurtSpecified = true
    end
    if tbl.cure == nil then
        tbl.cureSpecified = false
        tbl.cure = 0
    else
        tbl.cureSpecified = true
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
    if tbl.likeSet == nil then
        tbl.likeSet = {}
    end
    if tbl.hostId == nil then
        tbl.hostIdSpecified = false
        tbl.hostId = 0
    else
        tbl.hostIdSpecified = true
    end
    if tbl.uniteId == nil then
        tbl.uniteIdSpecified = false
        tbl.uniteId = 0
    else
        tbl.uniteIdSpecified = true
    end
    if tbl.uniteType == nil then
        tbl.uniteTypeSpecified = false
        tbl.uniteType = 0
    else
        tbl.uniteTypeSpecified = true
    end
    if tbl.newScore == nil then
        tbl.newScoreSpecified = false
        tbl.newScore = 0
    else
        tbl.newScoreSpecified = true
    end
end

--region metatable duplicateV2.ReqGetSabacRankInfo
---@type duplicateV2.ReqGetSabacRankInfo
duplicateV2_adj.metatable_ReqGetSabacRankInfo = {
    _ClassName = "duplicateV2.ReqGetSabacRankInfo",
}
duplicateV2_adj.metatable_ReqGetSabacRankInfo.__index = duplicateV2_adj.metatable_ReqGetSabacRankInfo
--endregion

---@param tbl duplicateV2.ReqGetSabacRankInfo 待调整的table数据
function duplicateV2_adj.AdjustReqGetSabacRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqGetSabacRankInfo)
end

--region metatable duplicateV2.ResSabacRankInfo
---@type duplicateV2.ResSabacRankInfo
duplicateV2_adj.metatable_ResSabacRankInfo = {
    _ClassName = "duplicateV2.ResSabacRankInfo",
}
duplicateV2_adj.metatable_ResSabacRankInfo.__index = duplicateV2_adj.metatable_ResSabacRankInfo
--endregion

---@param tbl duplicateV2.ResSabacRankInfo 待调整的table数据
function duplicateV2_adj.AdjustResSabacRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResSabacRankInfo)
    if tbl.rankInfo == nil then
        tbl.rankInfo = {}
    else
        if duplicateV2_adj.AdjustSabacRankInfo ~= nil then
            for i = 1, #tbl.rankInfo do
                duplicateV2_adj.AdjustSabacRankInfo(tbl.rankInfo[i])
            end
        end
    end
    if tbl.myRankInfo == nil then
        tbl.myRankInfoSpecified = false
        tbl.myRankInfo = nil
    else
        if tbl.myRankInfoSpecified == nil then 
            tbl.myRankInfoSpecified = true
            if duplicateV2_adj.AdjustSabacRankInfo ~= nil then
                duplicateV2_adj.AdjustSabacRankInfo(tbl.myRankInfo)
            end
        end
    end
    if tbl.hostId == nil then
        tbl.hostIdSpecified = false
        tbl.hostId = 0
    else
        tbl.hostIdSpecified = true
    end
end

--region metatable duplicateV2.ReqSabacRecord
---@type duplicateV2.ReqSabacRecord
duplicateV2_adj.metatable_ReqSabacRecord = {
    _ClassName = "duplicateV2.ReqSabacRecord",
}
duplicateV2_adj.metatable_ReqSabacRecord.__index = duplicateV2_adj.metatable_ReqSabacRecord
--endregion

---@param tbl duplicateV2.ReqSabacRecord 待调整的table数据
function duplicateV2_adj.AdjustReqSabacRecord(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqSabacRecord)
end

--region metatable duplicateV2.ResSabacRecord
---@type duplicateV2.ResSabacRecord
duplicateV2_adj.metatable_ResSabacRecord = {
    _ClassName = "duplicateV2.ResSabacRecord",
}
duplicateV2_adj.metatable_ResSabacRecord.__index = duplicateV2_adj.metatable_ResSabacRecord
--endregion

---@param tbl duplicateV2.ResSabacRecord 待调整的table数据
function duplicateV2_adj.AdjustResSabacRecord(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResSabacRecord)
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
    if tbl.rankInfo == nil then
        tbl.rankInfo = {}
    else
        if duplicateV2_adj.AdjustSabacRankInfo ~= nil then
            for i = 1, #tbl.rankInfo do
                duplicateV2_adj.AdjustSabacRankInfo(tbl.rankInfo[i])
            end
        end
    end
    if tbl.myRankInfo == nil then
        tbl.myRankInfoSpecified = false
        tbl.myRankInfo = nil
    else
        if tbl.myRankInfoSpecified == nil then 
            tbl.myRankInfoSpecified = true
            if duplicateV2_adj.AdjustSabacRankInfo ~= nil then
                duplicateV2_adj.AdjustSabacRankInfo(tbl.myRankInfo)
            end
        end
    end
    if tbl.hostId == nil then
        tbl.hostIdSpecified = false
        tbl.hostId = 0
    else
        tbl.hostIdSpecified = true
    end
    if tbl.uniteId == nil then
        tbl.uniteIdSpecified = false
        tbl.uniteId = 0
    else
        tbl.uniteIdSpecified = true
    end
    if tbl.uniteType == nil then
        tbl.uniteTypeSpecified = false
        tbl.uniteType = 0
    else
        tbl.uniteTypeSpecified = true
    end
end

--region metatable duplicateV2.ResGoddessBlessingInfo
---@type duplicateV2.ResGoddessBlessingInfo
duplicateV2_adj.metatable_ResGoddessBlessingInfo = {
    _ClassName = "duplicateV2.ResGoddessBlessingInfo",
}
duplicateV2_adj.metatable_ResGoddessBlessingInfo.__index = duplicateV2_adj.metatable_ResGoddessBlessingInfo
--endregion

---@param tbl duplicateV2.ResGoddessBlessingInfo 待调整的table数据
function duplicateV2_adj.AdjustResGoddessBlessingInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResGoddessBlessingInfo)
    if tbl.openTime == nil then
        tbl.openTimeSpecified = false
        tbl.openTime = 0
    else
        tbl.openTimeSpecified = true
    end
    if tbl.totalTime == nil then
        tbl.totalTimeSpecified = false
        tbl.totalTime = 0
    else
        tbl.totalTimeSpecified = true
    end
end

--region metatable duplicateV2.ResDreamlandInfo
---@type duplicateV2.ResDreamlandInfo
duplicateV2_adj.metatable_ResDreamlandInfo = {
    _ClassName = "duplicateV2.ResDreamlandInfo",
}
duplicateV2_adj.metatable_ResDreamlandInfo.__index = duplicateV2_adj.metatable_ResDreamlandInfo
--endregion

---@param tbl duplicateV2.ResDreamlandInfo 待调整的table数据
function duplicateV2_adj.AdjustResDreamlandInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResDreamlandInfo)
    if tbl.bossCount == nil then
        tbl.bossCountSpecified = false
        tbl.bossCount = 0
    else
        tbl.bossCountSpecified = true
    end
    if tbl.exitIsOpen == nil then
        tbl.exitIsOpenSpecified = false
        tbl.exitIsOpen = 0
    else
        tbl.exitIsOpenSpecified = true
    end
    if tbl.isMessenger == nil then
        tbl.isMessengerSpecified = false
        tbl.isMessenger = 0
    else
        tbl.isMessengerSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
end

--region metatable duplicateV2.ResCanDelivery
---@type duplicateV2.ResCanDelivery
duplicateV2_adj.metatable_ResCanDelivery = {
    _ClassName = "duplicateV2.ResCanDelivery",
}
duplicateV2_adj.metatable_ResCanDelivery.__index = duplicateV2_adj.metatable_ResCanDelivery
--endregion

---@param tbl duplicateV2.ResCanDelivery 待调整的table数据
function duplicateV2_adj.AdjustResCanDelivery(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResCanDelivery)
    if tbl.layer == nil then
        tbl.layerSpecified = false
        tbl.layer = 0
    else
        tbl.layerSpecified = true
    end
end

--region metatable duplicateV2.ReqDeliveryDuplicate
---@type duplicateV2.ReqDeliveryDuplicate
duplicateV2_adj.metatable_ReqDeliveryDuplicate = {
    _ClassName = "duplicateV2.ReqDeliveryDuplicate",
}
duplicateV2_adj.metatable_ReqDeliveryDuplicate.__index = duplicateV2_adj.metatable_ReqDeliveryDuplicate
--endregion

---@param tbl duplicateV2.ReqDeliveryDuplicate 待调整的table数据
function duplicateV2_adj.AdjustReqDeliveryDuplicate(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqDeliveryDuplicate)
    if tbl.duplicateId == nil then
        tbl.duplicateIdSpecified = false
        tbl.duplicateId = 0
    else
        tbl.duplicateIdSpecified = true
    end
end

--region metatable duplicateV2.ReqDuboBet
---@type duplicateV2.ReqDuboBet
duplicateV2_adj.metatable_ReqDuboBet = {
    _ClassName = "duplicateV2.ReqDuboBet",
}
duplicateV2_adj.metatable_ReqDuboBet.__index = duplicateV2_adj.metatable_ReqDuboBet
--endregion

---@param tbl duplicateV2.ReqDuboBet 待调整的table数据
function duplicateV2_adj.AdjustReqDuboBet(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqDuboBet)
    if tbl.targetPlayerId == nil then
        tbl.targetPlayerIdSpecified = false
        tbl.targetPlayerId = 0
    else
        tbl.targetPlayerIdSpecified = true
    end
    if tbl.finalWar == nil then
        tbl.finalWarSpecified = false
        tbl.finalWar = false
    else
        tbl.finalWarSpecified = true
    end
    if tbl.zhu == nil then
        tbl.zhuSpecified = false
        tbl.zhu = 0
    else
        tbl.zhuSpecified = true
    end
end

--region metatable duplicateV2.ResBetPlayerInfo
---@type duplicateV2.ResBetPlayerInfo
duplicateV2_adj.metatable_ResBetPlayerInfo = {
    _ClassName = "duplicateV2.ResBetPlayerInfo",
}
duplicateV2_adj.metatable_ResBetPlayerInfo.__index = duplicateV2_adj.metatable_ResBetPlayerInfo
--endregion

---@param tbl duplicateV2.ResBetPlayerInfo 待调整的table数据
function duplicateV2_adj.AdjustResBetPlayerInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResBetPlayerInfo)
    if tbl.someSelectPlayers == nil then
        tbl.someSelectPlayers = {}
    else
        if duplicateV2_adj.AdjustBetPlayerInfo ~= nil then
            for i = 1, #tbl.someSelectPlayers do
                duplicateV2_adj.AdjustBetPlayerInfo(tbl.someSelectPlayers[i])
            end
        end
    end
    if tbl.finalPlayers == nil then
        tbl.finalPlayers = {}
    else
        if duplicateV2_adj.AdjustBetPlayerInfo ~= nil then
            for i = 1, #tbl.finalPlayers do
                duplicateV2_adj.AdjustBetPlayerInfo(tbl.finalPlayers[i])
            end
        end
    end
end

--region metatable duplicateV2.BetPlayerInfo
---@type duplicateV2.BetPlayerInfo
duplicateV2_adj.metatable_BetPlayerInfo = {
    _ClassName = "duplicateV2.BetPlayerInfo",
}
duplicateV2_adj.metatable_BetPlayerInfo.__index = duplicateV2_adj.metatable_BetPlayerInfo
--endregion

---@param tbl duplicateV2.BetPlayerInfo 待调整的table数据
function duplicateV2_adj.AdjustBetPlayerInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_BetPlayerInfo)
    if tbl.playerId == nil then
        tbl.playerIdSpecified = false
        tbl.playerId = 0
    else
        tbl.playerIdSpecified = true
    end
    if tbl.killNum == nil then
        tbl.killNumSpecified = false
        tbl.killNum = 0
    else
        tbl.killNumSpecified = true
    end
    if tbl.onlineTime == nil then
        tbl.onlineTimeSpecified = false
        tbl.onlineTime = 0
    else
        tbl.onlineTimeSpecified = true
    end
    if tbl.odds == nil then
        tbl.oddsSpecified = false
        tbl.odds = 0
    else
        tbl.oddsSpecified = true
    end
    if tbl.no == nil then
        tbl.noSpecified = false
        tbl.no = 0
    else
        tbl.noSpecified = true
    end
    if tbl.zhuNum == nil then
        tbl.zhuNumSpecified = false
        tbl.zhuNum = 0
    else
        tbl.zhuNumSpecified = true
    end
    if tbl.playerName == nil then
        tbl.playerNameSpecified = false
        tbl.playerName = ""
    else
        tbl.playerNameSpecified = true
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
end

--region metatable duplicateV2.ResBudoRank
---@type duplicateV2.ResBudoRank
duplicateV2_adj.metatable_ResBudoRank = {
    _ClassName = "duplicateV2.ResBudoRank",
}
duplicateV2_adj.metatable_ResBudoRank.__index = duplicateV2_adj.metatable_ResBudoRank
--endregion

---@param tbl duplicateV2.ResBudoRank 待调整的table数据
function duplicateV2_adj.AdjustResBudoRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResBudoRank)
    if tbl.rankPlayer == nil then
        tbl.rankPlayer = {}
    else
        if duplicateV2_adj.AdjustBudoRankPlayerInfo ~= nil then
            for i = 1, #tbl.rankPlayer do
                duplicateV2_adj.AdjustBudoRankPlayerInfo(tbl.rankPlayer[i])
            end
        end
    end
end

--region metatable duplicateV2.BudoRankPlayerInfo
---@type duplicateV2.BudoRankPlayerInfo
duplicateV2_adj.metatable_BudoRankPlayerInfo = {
    _ClassName = "duplicateV2.BudoRankPlayerInfo",
}
duplicateV2_adj.metatable_BudoRankPlayerInfo.__index = duplicateV2_adj.metatable_BudoRankPlayerInfo
--endregion

---@param tbl duplicateV2.BudoRankPlayerInfo 待调整的table数据
function duplicateV2_adj.AdjustBudoRankPlayerInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_BudoRankPlayerInfo)
    if tbl.playerId == nil then
        tbl.playerIdSpecified = false
        tbl.playerId = 0
    else
        tbl.playerIdSpecified = true
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
    if tbl.killNum == nil then
        tbl.killNumSpecified = false
        tbl.killNum = 0
    else
        tbl.killNumSpecified = true
    end
    if tbl.no == nil then
        tbl.noSpecified = false
        tbl.no = 0
    else
        tbl.noSpecified = true
    end
    if tbl.awardItems == nil then
        tbl.awardItems = {}
    else
        if duplicateV2_adj.AdjustBudoAwardItem ~= nil then
            for i = 1, #tbl.awardItems do
                duplicateV2_adj.AdjustBudoAwardItem(tbl.awardItems[i])
            end
        end
    end
    if tbl.likes == nil then
        tbl.likesSpecified = false
        tbl.likes = nil
    else
        if tbl.likesSpecified == nil then 
            tbl.likesSpecified = true
            if duplicateV2_adj.AdjustLikeList ~= nil then
                duplicateV2_adj.AdjustLikeList(tbl.likes)
            end
        end
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
    if tbl.selectBetRate == nil then
        tbl.selectBetRateSpecified = false
        tbl.selectBetRate = 0
    else
        tbl.selectBetRateSpecified = true
    end
    if tbl.selectBetAmount == nil then
        tbl.selectBetAmountSpecified = false
        tbl.selectBetAmount = 0
    else
        tbl.selectBetAmountSpecified = true
    end
    if tbl.finalBetRate == nil then
        tbl.finalBetRateSpecified = false
        tbl.finalBetRate = 0
    else
        tbl.finalBetRateSpecified = true
    end
    if tbl.finalBetAmount == nil then
        tbl.finalBetAmountSpecified = false
        tbl.finalBetAmount = 0
    else
        tbl.finalBetAmountSpecified = true
    end
    if tbl.hostId == nil then
        tbl.hostIdSpecified = false
        tbl.hostId = 0
    else
        tbl.hostIdSpecified = true
    end
    if tbl.serverType == nil then
        tbl.serverTypeSpecified = false
        tbl.serverType = 0
    else
        tbl.serverTypeSpecified = true
    end
end

--region metatable duplicateV2.BudoAwardItem
---@type duplicateV2.BudoAwardItem
duplicateV2_adj.metatable_BudoAwardItem = {
    _ClassName = "duplicateV2.BudoAwardItem",
}
duplicateV2_adj.metatable_BudoAwardItem.__index = duplicateV2_adj.metatable_BudoAwardItem
--endregion

---@param tbl duplicateV2.BudoAwardItem 待调整的table数据
function duplicateV2_adj.AdjustBudoAwardItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_BudoAwardItem)
    if tbl.ItemConfigId == nil then
        tbl.ItemConfigIdSpecified = false
        tbl.ItemConfigId = 0
    else
        tbl.ItemConfigIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable duplicateV2.BudoDuplicatePhaseInfo
---@type duplicateV2.BudoDuplicatePhaseInfo
duplicateV2_adj.metatable_BudoDuplicatePhaseInfo = {
    _ClassName = "duplicateV2.BudoDuplicatePhaseInfo",
}
duplicateV2_adj.metatable_BudoDuplicatePhaseInfo.__index = duplicateV2_adj.metatable_BudoDuplicatePhaseInfo
--endregion

---@param tbl duplicateV2.BudoDuplicatePhaseInfo 待调整的table数据
function duplicateV2_adj.AdjustBudoDuplicatePhaseInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_BudoDuplicatePhaseInfo)
    if tbl.phase == nil then
        tbl.phaseSpecified = false
        tbl.phase = 0
    else
        tbl.phaseSpecified = true
    end
    if tbl.overTimeS == nil then
        tbl.overTimeSSpecified = false
        tbl.overTimeS = 0
    else
        tbl.overTimeSSpecified = true
    end
    if tbl.playerInfos == nil then
        tbl.playerInfos = {}
    else
        if duplicateV2_adj.AdjustBudoPlayerInfo ~= nil then
            for i = 1, #tbl.playerInfos do
                duplicateV2_adj.AdjustBudoPlayerInfo(tbl.playerInfos[i])
            end
        end
    end
    if tbl.beginTimeMS == nil then
        tbl.beginTimeMSSpecified = false
        tbl.beginTimeMS = 0
    else
        tbl.beginTimeMSSpecified = true
    end
end

--region metatable duplicateV2.BudoPlayerInfo
---@type duplicateV2.BudoPlayerInfo
duplicateV2_adj.metatable_BudoPlayerInfo = {
    _ClassName = "duplicateV2.BudoPlayerInfo",
}
duplicateV2_adj.metatable_BudoPlayerInfo.__index = duplicateV2_adj.metatable_BudoPlayerInfo
--endregion

---@param tbl duplicateV2.BudoPlayerInfo 待调整的table数据
function duplicateV2_adj.AdjustBudoPlayerInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_BudoPlayerInfo)
    if tbl.playerId == nil then
        tbl.playerIdSpecified = false
        tbl.playerId = 0
    else
        tbl.playerIdSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.no == nil then
        tbl.noSpecified = false
        tbl.no = 0
    else
        tbl.noSpecified = true
    end
    if tbl.war == nil then
        tbl.warSpecified = false
        tbl.war = false
    else
        tbl.warSpecified = true
    end
    if tbl.killNum == nil then
        tbl.killNumSpecified = false
        tbl.killNum = 0
    else
        tbl.killNumSpecified = true
    end
end

--region metatable duplicateV2.BudoDuplicateUpdateInfo
---@type duplicateV2.BudoDuplicateUpdateInfo
duplicateV2_adj.metatable_BudoDuplicateUpdateInfo = {
    _ClassName = "duplicateV2.BudoDuplicateUpdateInfo",
}
duplicateV2_adj.metatable_BudoDuplicateUpdateInfo.__index = duplicateV2_adj.metatable_BudoDuplicateUpdateInfo
--endregion

---@param tbl duplicateV2.BudoDuplicateUpdateInfo 待调整的table数据
function duplicateV2_adj.AdjustBudoDuplicateUpdateInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_BudoDuplicateUpdateInfo)
    if tbl.selfKillNum == nil then
        tbl.selfKillNumSpecified = false
        tbl.selfKillNum = 0
    else
        tbl.selfKillNumSpecified = true
    end
    if tbl.war == nil then
        tbl.warSpecified = false
        tbl.war = false
    else
        tbl.warSpecified = true
    end
    if tbl.playerCount == nil then
        tbl.playerCountSpecified = false
        tbl.playerCount = 0
    else
        tbl.playerCountSpecified = true
    end
    if tbl.no == nil then
        tbl.noSpecified = false
        tbl.no = 0
    else
        tbl.noSpecified = true
    end
end

--region metatable duplicateV2.SabacTacticsInfo
---@type duplicateV2.SabacTacticsInfo
duplicateV2_adj.metatable_SabacTacticsInfo = {
    _ClassName = "duplicateV2.SabacTacticsInfo",
}
duplicateV2_adj.metatable_SabacTacticsInfo.__index = duplicateV2_adj.metatable_SabacTacticsInfo
--endregion

---@param tbl duplicateV2.SabacTacticsInfo 待调整的table数据
function duplicateV2_adj.AdjustSabacTacticsInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_SabacTacticsInfo)
    if tbl.roleName == nil then
        tbl.roleNameSpecified = false
        tbl.roleName = ""
    else
        tbl.roleNameSpecified = true
    end
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
    if tbl.active == nil then
        tbl.activeSpecified = false
        tbl.active = false
    else
        tbl.activeSpecified = true
    end
    if tbl.uniteType == nil then
        tbl.uniteTypeSpecified = false
        tbl.uniteType = 0
    else
        tbl.uniteTypeSpecified = true
    end
end

--region metatable duplicateV2.ResSabacTactics
---@type duplicateV2.ResSabacTactics
duplicateV2_adj.metatable_ResSabacTactics = {
    _ClassName = "duplicateV2.ResSabacTactics",
}
duplicateV2_adj.metatable_ResSabacTactics.__index = duplicateV2_adj.metatable_ResSabacTactics
--endregion

---@param tbl duplicateV2.ResSabacTactics 待调整的table数据
function duplicateV2_adj.AdjustResSabacTactics(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResSabacTactics)
    if tbl.tactics == nil then
        tbl.tactics = {}
    else
        if duplicateV2_adj.AdjustSabacTacticsInfo ~= nil then
            for i = 1, #tbl.tactics do
                duplicateV2_adj.AdjustSabacTacticsInfo(tbl.tactics[i])
            end
        end
    end
    if tbl.tacticsEndTime == nil then
        tbl.tacticsEndTimeSpecified = false
        tbl.tacticsEndTime = 0
    else
        tbl.tacticsEndTimeSpecified = true
    end
end

--region metatable duplicateV2.ResSabacTacticsActived
---@type duplicateV2.ResSabacTacticsActived
duplicateV2_adj.metatable_ResSabacTacticsActived = {
    _ClassName = "duplicateV2.ResSabacTacticsActived",
}
duplicateV2_adj.metatable_ResSabacTacticsActived.__index = duplicateV2_adj.metatable_ResSabacTacticsActived
--endregion

---@param tbl duplicateV2.ResSabacTacticsActived 待调整的table数据
function duplicateV2_adj.AdjustResSabacTacticsActived(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResSabacTacticsActived)
    if tbl.activeTime == nil then
        tbl.activeTimeSpecified = false
        tbl.activeTime = 0
    else
        tbl.activeTimeSpecified = true
    end
end

--region metatable duplicateV2.SabacTacticsEffect
---@type duplicateV2.SabacTacticsEffect
duplicateV2_adj.metatable_SabacTacticsEffect = {
    _ClassName = "duplicateV2.SabacTacticsEffect",
}
duplicateV2_adj.metatable_SabacTacticsEffect.__index = duplicateV2_adj.metatable_SabacTacticsEffect
--endregion

---@param tbl duplicateV2.SabacTacticsEffect 待调整的table数据
function duplicateV2_adj.AdjustSabacTacticsEffect(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_SabacTacticsEffect)
    if tbl.damage == nil then
        tbl.damageSpecified = false
        tbl.damage = 0
    else
        tbl.damageSpecified = true
    end
    if tbl.hp == nil then
        tbl.hpSpecified = false
        tbl.hp = 0
    else
        tbl.hpSpecified = true
    end
end

--region metatable duplicateV2.ResSabacTacticsEffect
---@type duplicateV2.ResSabacTacticsEffect
duplicateV2_adj.metatable_ResSabacTacticsEffect = {
    _ClassName = "duplicateV2.ResSabacTacticsEffect",
}
duplicateV2_adj.metatable_ResSabacTacticsEffect.__index = duplicateV2_adj.metatable_ResSabacTacticsEffect
--endregion

---@param tbl duplicateV2.ResSabacTacticsEffect 待调整的table数据
function duplicateV2_adj.AdjustResSabacTacticsEffect(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResSabacTacticsEffect)
    if tbl.combinedServantsHurt == nil then
        tbl.combinedServantsHurt = {}
    else
        if duplicateV2_adj.AdjustSabacTacticsEffect ~= nil then
            for i = 1, #tbl.combinedServantsHurt do
                duplicateV2_adj.AdjustSabacTacticsEffect(tbl.combinedServantsHurt[i])
            end
        end
    end
end

--region metatable duplicateV2.ResCrowdFundingPanel
---@type duplicateV2.ResCrowdFundingPanel
duplicateV2_adj.metatable_ResCrowdFundingPanel = {
    _ClassName = "duplicateV2.ResCrowdFundingPanel",
}
duplicateV2_adj.metatable_ResCrowdFundingPanel.__index = duplicateV2_adj.metatable_ResCrowdFundingPanel
--endregion

---@param tbl duplicateV2.ResCrowdFundingPanel 待调整的table数据
function duplicateV2_adj.AdjustResCrowdFundingPanel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResCrowdFundingPanel)
    if tbl.ids == nil then
        tbl.ids = {}
    end
    if tbl.info == nil then
        tbl.infoSpecified = false
        tbl.info = nil
    else
        if tbl.infoSpecified == nil then 
            tbl.infoSpecified = true
            if duplicateV2_adj.AdjustCrowdFundingInfo ~= nil then
                duplicateV2_adj.AdjustCrowdFundingInfo(tbl.info)
            end
        end
    end
end

--region metatable duplicateV2.CrowdFundingInfo
---@type duplicateV2.CrowdFundingInfo
duplicateV2_adj.metatable_CrowdFundingInfo = {
    _ClassName = "duplicateV2.CrowdFundingInfo",
}
duplicateV2_adj.metatable_CrowdFundingInfo.__index = duplicateV2_adj.metatable_CrowdFundingInfo
--endregion

---@param tbl duplicateV2.CrowdFundingInfo 待调整的table数据
function duplicateV2_adj.AdjustCrowdFundingInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_CrowdFundingInfo)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.startTime == nil then
        tbl.startTimeSpecified = false
        tbl.startTime = 0
    else
        tbl.startTimeSpecified = true
    end
    if tbl.fundingEndTime == nil then
        tbl.fundingEndTimeSpecified = false
        tbl.fundingEndTime = 0
    else
        tbl.fundingEndTimeSpecified = true
    end
    if tbl.nowMoney == nil then
        tbl.nowMoneySpecified = false
        tbl.nowMoney = 0
    else
        tbl.nowMoneySpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable duplicateV2.ReqOpenCrowdFunding
---@type duplicateV2.ReqOpenCrowdFunding
duplicateV2_adj.metatable_ReqOpenCrowdFunding = {
    _ClassName = "duplicateV2.ReqOpenCrowdFunding",
}
duplicateV2_adj.metatable_ReqOpenCrowdFunding.__index = duplicateV2_adj.metatable_ReqOpenCrowdFunding
--endregion

---@param tbl duplicateV2.ReqOpenCrowdFunding 待调整的table数据
function duplicateV2_adj.AdjustReqOpenCrowdFunding(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqOpenCrowdFunding)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.startMins == nil then
        tbl.startMinsSpecified = false
        tbl.startMins = 0
    else
        tbl.startMinsSpecified = true
    end
    if tbl.money == nil then
        tbl.moneySpecified = false
        tbl.money = 0
    else
        tbl.moneySpecified = true
    end
    if tbl.unionMoney == nil then
        tbl.unionMoneySpecified = false
        tbl.unionMoney = 0
    else
        tbl.unionMoneySpecified = true
    end
end

--region metatable duplicateV2.ReqDonateFunding
---@type duplicateV2.ReqDonateFunding
duplicateV2_adj.metatable_ReqDonateFunding = {
    _ClassName = "duplicateV2.ReqDonateFunding",
}
duplicateV2_adj.metatable_ReqDonateFunding.__index = duplicateV2_adj.metatable_ReqDonateFunding
--endregion

---@param tbl duplicateV2.ReqDonateFunding 待调整的table数据
function duplicateV2_adj.AdjustReqDonateFunding(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqDonateFunding)
    if tbl.money == nil then
        tbl.moneySpecified = false
        tbl.money = 0
    else
        tbl.moneySpecified = true
    end
    if tbl.unionMoney == nil then
        tbl.unionMoneySpecified = false
        tbl.unionMoney = 0
    else
        tbl.unionMoneySpecified = true
    end
end

--region metatable duplicateV2.ResCrowdFundingChange
---@type duplicateV2.ResCrowdFundingChange
duplicateV2_adj.metatable_ResCrowdFundingChange = {
    _ClassName = "duplicateV2.ResCrowdFundingChange",
}
duplicateV2_adj.metatable_ResCrowdFundingChange.__index = duplicateV2_adj.metatable_ResCrowdFundingChange
--endregion

---@param tbl duplicateV2.ResCrowdFundingChange 待调整的table数据
function duplicateV2_adj.AdjustResCrowdFundingChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResCrowdFundingChange)
    if tbl.nowMoney == nil then
        tbl.nowMoneySpecified = false
        tbl.nowMoney = 0
    else
        tbl.nowMoneySpecified = true
    end
end

--region metatable duplicateV2.SabacPlayerInfo
---@type duplicateV2.SabacPlayerInfo
duplicateV2_adj.metatable_SabacPlayerInfo = {
    _ClassName = "duplicateV2.SabacPlayerInfo",
}
duplicateV2_adj.metatable_SabacPlayerInfo.__index = duplicateV2_adj.metatable_SabacPlayerInfo
--endregion

---@param tbl duplicateV2.SabacPlayerInfo 待调整的table数据
function duplicateV2_adj.AdjustSabacPlayerInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_SabacPlayerInfo)
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.unionPos == nil then
        tbl.unionPosSpecified = false
        tbl.unionPos = 0
    else
        tbl.unionPosSpecified = true
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
end

--region metatable duplicateV2.ResBrokerPanel
---@type duplicateV2.ResBrokerPanel
duplicateV2_adj.metatable_ResBrokerPanel = {
    _ClassName = "duplicateV2.ResBrokerPanel",
}
duplicateV2_adj.metatable_ResBrokerPanel.__index = duplicateV2_adj.metatable_ResBrokerPanel
--endregion

---@param tbl duplicateV2.ResBrokerPanel 待调整的table数据
function duplicateV2_adj.AdjustResBrokerPanel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResBrokerPanel)
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
    if tbl.players == nil then
        tbl.players = {}
    else
        if duplicateV2_adj.AdjustSabacPlayerInfo ~= nil then
            for i = 1, #tbl.players do
                duplicateV2_adj.AdjustSabacPlayerInfo(tbl.players[i])
            end
        end
    end
end

--region metatable duplicateV2.ReqBrokerQuery
---@type duplicateV2.ReqBrokerQuery
duplicateV2_adj.metatable_ReqBrokerQuery = {
    _ClassName = "duplicateV2.ReqBrokerQuery",
}
duplicateV2_adj.metatable_ReqBrokerQuery.__index = duplicateV2_adj.metatable_ReqBrokerQuery
--endregion

---@param tbl duplicateV2.ReqBrokerQuery 待调整的table数据
function duplicateV2_adj.AdjustReqBrokerQuery(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqBrokerQuery)
end

--region metatable duplicateV2.PlayerActivityData
---@type duplicateV2.PlayerActivityData
duplicateV2_adj.metatable_PlayerActivityData = {
    _ClassName = "duplicateV2.PlayerActivityData",
}
duplicateV2_adj.metatable_PlayerActivityData.__index = duplicateV2_adj.metatable_PlayerActivityData
--endregion

---@param tbl duplicateV2.PlayerActivityData 待调整的table数据
function duplicateV2_adj.AdjustPlayerActivityData(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_PlayerActivityData)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
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
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.roleName == nil then
        tbl.roleNameSpecified = false
        tbl.roleName = ""
    else
        tbl.roleNameSpecified = true
    end
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
    if tbl.kill == nil then
        tbl.killSpecified = false
        tbl.kill = 0
    else
        tbl.killSpecified = true
    end
    if tbl.bossHurt == nil then
        tbl.bossHurtSpecified = false
        tbl.bossHurt = 0
    else
        tbl.bossHurtSpecified = true
    end
    if tbl.bossKill == nil then
        tbl.bossKillSpecified = false
        tbl.bossKill = 0
    else
        tbl.bossKillSpecified = true
    end
    if tbl.score == nil then
        tbl.scoreSpecified = false
        tbl.score = 0
    else
        tbl.scoreSpecified = true
    end
    if tbl.getTitle == nil then
        tbl.getTitleSpecified = false
        tbl.getTitle = 0
    else
        tbl.getTitleSpecified = true
    end
    if tbl.likes == nil then
        tbl.likesSpecified = false
        tbl.likes = nil
    else
        if tbl.likesSpecified == nil then 
            tbl.likesSpecified = true
            if duplicateV2_adj.AdjustLikeList ~= nil then
                duplicateV2_adj.AdjustLikeList(tbl.likes)
            end
        end
    end
    if tbl.hostId == nil then
        tbl.hostIdSpecified = false
        tbl.hostId = 0
    else
        tbl.hostIdSpecified = true
    end
end

--region metatable duplicateV2.ResPlayerActivityDataRank
---@type duplicateV2.ResPlayerActivityDataRank
duplicateV2_adj.metatable_ResPlayerActivityDataRank = {
    _ClassName = "duplicateV2.ResPlayerActivityDataRank",
}
duplicateV2_adj.metatable_ResPlayerActivityDataRank.__index = duplicateV2_adj.metatable_ResPlayerActivityDataRank
--endregion

---@param tbl duplicateV2.ResPlayerActivityDataRank 待调整的table数据
function duplicateV2_adj.AdjustResPlayerActivityDataRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResPlayerActivityDataRank)
    if tbl.playerData == nil then
        tbl.playerData = {}
    else
        if duplicateV2_adj.AdjustPlayerActivityData ~= nil then
            for i = 1, #tbl.playerData do
                duplicateV2_adj.AdjustPlayerActivityData(tbl.playerData[i])
            end
        end
    end
    if tbl.otherPlayerData == nil then
        tbl.otherPlayerData = {}
    else
        if duplicateV2_adj.AdjustPlayerActivityData ~= nil then
            for i = 1, #tbl.otherPlayerData do
                duplicateV2_adj.AdjustPlayerActivityData(tbl.otherPlayerData[i])
            end
        end
    end
    if tbl.allBossHurt == nil then
        tbl.allBossHurtSpecified = false
        tbl.allBossHurt = 0
    else
        tbl.allBossHurtSpecified = true
    end
    if tbl.allBossKill == nil then
        tbl.allBossKillSpecified = false
        tbl.allBossKill = 0
    else
        tbl.allBossKillSpecified = true
    end
    if tbl.allKill == nil then
        tbl.allKillSpecified = false
        tbl.allKill = 0
    else
        tbl.allKillSpecified = true
    end
end

--region metatable duplicateV2.ActivityEndRank
---@type duplicateV2.ActivityEndRank
duplicateV2_adj.metatable_ActivityEndRank = {
    _ClassName = "duplicateV2.ActivityEndRank",
}
duplicateV2_adj.metatable_ActivityEndRank.__index = duplicateV2_adj.metatable_ActivityEndRank
--endregion

---@param tbl duplicateV2.ActivityEndRank 待调整的table数据
function duplicateV2_adj.AdjustActivityEndRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ActivityEndRank)
    if tbl.playerData == nil then
        tbl.playerData = {}
    else
        if duplicateV2_adj.AdjustPlayerActivityData ~= nil then
            for i = 1, #tbl.playerData do
                duplicateV2_adj.AdjustPlayerActivityData(tbl.playerData[i])
            end
        end
    end
    if tbl.otherPlayerData == nil then
        tbl.otherPlayerData = {}
    else
        if duplicateV2_adj.AdjustPlayerActivityData ~= nil then
            for i = 1, #tbl.otherPlayerData do
                duplicateV2_adj.AdjustPlayerActivityData(tbl.otherPlayerData[i])
            end
        end
    end
    if tbl.allBossHurt == nil then
        tbl.allBossHurtSpecified = false
        tbl.allBossHurt = 0
    else
        tbl.allBossHurtSpecified = true
    end
    if tbl.allBossKill == nil then
        tbl.allBossKillSpecified = false
        tbl.allBossKill = 0
    else
        tbl.allBossKillSpecified = true
    end
    if tbl.allKill == nil then
        tbl.allKillSpecified = false
        tbl.allKill = 0
    else
        tbl.allKillSpecified = true
    end
end

--region metatable duplicateV2.GetGoddessBlessingRank
---@type duplicateV2.GetGoddessBlessingRank
duplicateV2_adj.metatable_GetGoddessBlessingRank = {
    _ClassName = "duplicateV2.GetGoddessBlessingRank",
}
duplicateV2_adj.metatable_GetGoddessBlessingRank.__index = duplicateV2_adj.metatable_GetGoddessBlessingRank
--endregion

---@param tbl duplicateV2.GetGoddessBlessingRank 待调整的table数据
function duplicateV2_adj.AdjustGetGoddessBlessingRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_GetGoddessBlessingRank)
    if tbl.rankType == nil then
        tbl.rankTypeSpecified = false
        tbl.rankType = 0
    else
        tbl.rankTypeSpecified = true
    end
end

--region metatable duplicateV2.GoddessBlessingRankInfo
---@type duplicateV2.GoddessBlessingRankInfo
duplicateV2_adj.metatable_GoddessBlessingRankInfo = {
    _ClassName = "duplicateV2.GoddessBlessingRankInfo",
}
duplicateV2_adj.metatable_GoddessBlessingRankInfo.__index = duplicateV2_adj.metatable_GoddessBlessingRankInfo
--endregion

---@param tbl duplicateV2.GoddessBlessingRankInfo 待调整的table数据
function duplicateV2_adj.AdjustGoddessBlessingRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_GoddessBlessingRankInfo)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.players == nil then
        tbl.players = {}
    else
        if duplicateV2_adj.AdjustGoddessBlessingPlayerInfo ~= nil then
            for i = 1, #tbl.players do
                duplicateV2_adj.AdjustGoddessBlessingPlayerInfo(tbl.players[i])
            end
        end
    end
    if tbl.rankType == nil then
        tbl.rankTypeSpecified = false
        tbl.rankType = 0
    else
        tbl.rankTypeSpecified = true
    end
end

--region metatable duplicateV2.GoddessBlessingPlayerInfo
---@type duplicateV2.GoddessBlessingPlayerInfo
duplicateV2_adj.metatable_GoddessBlessingPlayerInfo = {
    _ClassName = "duplicateV2.GoddessBlessingPlayerInfo",
}
duplicateV2_adj.metatable_GoddessBlessingPlayerInfo.__index = duplicateV2_adj.metatable_GoddessBlessingPlayerInfo
--endregion

---@param tbl duplicateV2.GoddessBlessingPlayerInfo 待调整的table数据
function duplicateV2_adj.AdjustGoddessBlessingPlayerInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_GoddessBlessingPlayerInfo)
    if tbl.roleName == nil then
        tbl.roleNameSpecified = false
        tbl.roleName = ""
    else
        tbl.roleNameSpecified = true
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
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.convertedEarning == nil then
        tbl.convertedEarningSpecified = false
        tbl.convertedEarning = 0
    else
        tbl.convertedEarningSpecified = true
    end
    if tbl.killNumber == nil then
        tbl.killNumberSpecified = false
        tbl.killNumber = 0
    else
        tbl.killNumberSpecified = true
    end
    if tbl.likes == nil then
        tbl.likesSpecified = false
        tbl.likes = nil
    else
        if tbl.likesSpecified == nil then 
            tbl.likesSpecified = true
            if duplicateV2_adj.AdjustLikeList ~= nil then
                duplicateV2_adj.AdjustLikeList(tbl.likes)
            end
        end
    end
    if tbl.score == nil then
        tbl.scoreSpecified = false
        tbl.score = 0
    else
        tbl.scoreSpecified = true
    end
    if tbl.hostId == nil then
        tbl.hostIdSpecified = false
        tbl.hostId = 0
    else
        tbl.hostIdSpecified = true
    end
    if tbl.awardItems == nil then
        tbl.awardItems = {}
    else
        if duplicateV2_adj.AdjustBudoAwardItem ~= nil then
            for i = 1, #tbl.awardItems do
                duplicateV2_adj.AdjustBudoAwardItem(tbl.awardItems[i])
            end
        end
    end
end

--region metatable duplicateV2.ReqGBPreviousPeriodTime
---@type duplicateV2.ReqGBPreviousPeriodTime
duplicateV2_adj.metatable_ReqGBPreviousPeriodTime = {
    _ClassName = "duplicateV2.ReqGBPreviousPeriodTime",
}
duplicateV2_adj.metatable_ReqGBPreviousPeriodTime.__index = duplicateV2_adj.metatable_ReqGBPreviousPeriodTime
--endregion

---@param tbl duplicateV2.ReqGBPreviousPeriodTime 待调整的table数据
function duplicateV2_adj.AdjustReqGBPreviousPeriodTime(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqGBPreviousPeriodTime)
end

--region metatable duplicateV2.ResGBPreviousPeriodTime
---@type duplicateV2.ResGBPreviousPeriodTime
duplicateV2_adj.metatable_ResGBPreviousPeriodTime = {
    _ClassName = "duplicateV2.ResGBPreviousPeriodTime",
}
duplicateV2_adj.metatable_ResGBPreviousPeriodTime.__index = duplicateV2_adj.metatable_ResGBPreviousPeriodTime
--endregion

---@param tbl duplicateV2.ResGBPreviousPeriodTime 待调整的table数据
function duplicateV2_adj.AdjustResGBPreviousPeriodTime(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResGBPreviousPeriodTime)
    if tbl.times == nil then
        tbl.times = {}
    end
    if tbl.activityType == nil then
        tbl.activityTypeSpecified = false
        tbl.activityType = 0
    else
        tbl.activityTypeSpecified = true
    end
end

--region metatable duplicateV2.ReqGBPreviousPeriodInfo
---@type duplicateV2.ReqGBPreviousPeriodInfo
duplicateV2_adj.metatable_ReqGBPreviousPeriodInfo = {
    _ClassName = "duplicateV2.ReqGBPreviousPeriodInfo",
}
duplicateV2_adj.metatable_ReqGBPreviousPeriodInfo.__index = duplicateV2_adj.metatable_ReqGBPreviousPeriodInfo
--endregion

---@param tbl duplicateV2.ReqGBPreviousPeriodInfo 待调整的table数据
function duplicateV2_adj.AdjustReqGBPreviousPeriodInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqGBPreviousPeriodInfo)
    if tbl.times == nil then
        tbl.timesSpecified = false
        tbl.times = 0
    else
        tbl.timesSpecified = true
    end
end

--region metatable duplicateV2.LikeRequest
---@type duplicateV2.LikeRequest
duplicateV2_adj.metatable_LikeRequest = {
    _ClassName = "duplicateV2.LikeRequest",
}
duplicateV2_adj.metatable_LikeRequest.__index = duplicateV2_adj.metatable_LikeRequest
--endregion

---@param tbl duplicateV2.LikeRequest 待调整的table数据
function duplicateV2_adj.AdjustLikeRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_LikeRequest)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
    if tbl.periodParam == nil then
        tbl.periodParamSpecified = false
        tbl.periodParam = 0
    else
        tbl.periodParamSpecified = true
    end
end

--region metatable duplicateV2.LikeResponseCommon
---@type duplicateV2.LikeResponseCommon
duplicateV2_adj.metatable_LikeResponseCommon = {
    _ClassName = "duplicateV2.LikeResponseCommon",
}
duplicateV2_adj.metatable_LikeResponseCommon.__index = duplicateV2_adj.metatable_LikeResponseCommon
--endregion

---@param tbl duplicateV2.LikeResponseCommon 待调整的table数据
function duplicateV2_adj.AdjustLikeResponseCommon(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_LikeResponseCommon)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.trigger == nil then
        tbl.triggerSpecified = false
        tbl.trigger = 0
    else
        tbl.triggerSpecified = true
    end
    if tbl.periodParam == nil then
        tbl.periodParamSpecified = false
        tbl.periodParam = 0
    else
        tbl.periodParamSpecified = true
    end
end

--region metatable duplicateV2.LikeList
---@type duplicateV2.LikeList
duplicateV2_adj.metatable_LikeList = {
    _ClassName = "duplicateV2.LikeList",
}
duplicateV2_adj.metatable_LikeList.__index = duplicateV2_adj.metatable_LikeList
--endregion

---@param tbl duplicateV2.LikeList 待调整的table数据
function duplicateV2_adj.AdjustLikeList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_LikeList)
    if tbl.likes == nil then
        tbl.likes = {}
    end
end

--region metatable duplicateV2.ReqLookBudoMeet
---@type duplicateV2.ReqLookBudoMeet
duplicateV2_adj.metatable_ReqLookBudoMeet = {
    _ClassName = "duplicateV2.ReqLookBudoMeet",
}
duplicateV2_adj.metatable_ReqLookBudoMeet.__index = duplicateV2_adj.metatable_ReqLookBudoMeet
--endregion

---@param tbl duplicateV2.ReqLookBudoMeet 待调整的table数据
function duplicateV2_adj.AdjustReqLookBudoMeet(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqLookBudoMeet)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.history == nil then
        tbl.historySpecified = false
        tbl.history = 0
    else
        tbl.historySpecified = true
    end
end

--region metatable duplicateV2.ResTodayUseFirework
---@type duplicateV2.ResTodayUseFirework
duplicateV2_adj.metatable_ResTodayUseFirework = {
    _ClassName = "duplicateV2.ResTodayUseFirework",
}
duplicateV2_adj.metatable_ResTodayUseFirework.__index = duplicateV2_adj.metatable_ResTodayUseFirework
--endregion

---@param tbl duplicateV2.ResTodayUseFirework 待调整的table数据
function duplicateV2_adj.AdjustResTodayUseFirework(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResTodayUseFirework)
    if tbl.isUse == nil then
        tbl.isUseSpecified = false
        tbl.isUse = 0
    else
        tbl.isUseSpecified = true
    end
end

--region metatable duplicateV2.ReqGetPreviousReview
---@type duplicateV2.ReqGetPreviousReview
duplicateV2_adj.metatable_ReqGetPreviousReview = {
    _ClassName = "duplicateV2.ReqGetPreviousReview",
}
duplicateV2_adj.metatable_ReqGetPreviousReview.__index = duplicateV2_adj.metatable_ReqGetPreviousReview
--endregion

---@param tbl duplicateV2.ReqGetPreviousReview 待调整的table数据
function duplicateV2_adj.AdjustReqGetPreviousReview(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqGetPreviousReview)
    if tbl.activeType == nil then
        tbl.activeTypeSpecified = false
        tbl.activeType = 0
    else
        tbl.activeTypeSpecified = true
    end
end

--region metatable duplicateV2.ResGetPreviousReview
---@type duplicateV2.ResGetPreviousReview
duplicateV2_adj.metatable_ResGetPreviousReview = {
    _ClassName = "duplicateV2.ResGetPreviousReview",
}
duplicateV2_adj.metatable_ResGetPreviousReview.__index = duplicateV2_adj.metatable_ResGetPreviousReview
--endregion

---@param tbl duplicateV2.ResGetPreviousReview 待调整的table数据
function duplicateV2_adj.AdjustResGetPreviousReview(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResGetPreviousReview)
    if tbl.activeTime == nil then
        tbl.activeTime = {}
    end
end

--region metatable duplicateV2.ReqGetSpecificPreviousReview
---@type duplicateV2.ReqGetSpecificPreviousReview
duplicateV2_adj.metatable_ReqGetSpecificPreviousReview = {
    _ClassName = "duplicateV2.ReqGetSpecificPreviousReview",
}
duplicateV2_adj.metatable_ReqGetSpecificPreviousReview.__index = duplicateV2_adj.metatable_ReqGetSpecificPreviousReview
--endregion

---@param tbl duplicateV2.ReqGetSpecificPreviousReview 待调整的table数据
function duplicateV2_adj.AdjustReqGetSpecificPreviousReview(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqGetSpecificPreviousReview)
    if tbl.activeType == nil then
        tbl.activeTypeSpecified = false
        tbl.activeType = 0
    else
        tbl.activeTypeSpecified = true
    end
    if tbl.activeTime == nil then
        tbl.activeTimeSpecified = false
        tbl.activeTime = 0
    else
        tbl.activeTimeSpecified = true
    end
end

--region metatable duplicateV2.ResDreamlandRankInfo
---@type duplicateV2.ResDreamlandRankInfo
duplicateV2_adj.metatable_ResDreamlandRankInfo = {
    _ClassName = "duplicateV2.ResDreamlandRankInfo",
}
duplicateV2_adj.metatable_ResDreamlandRankInfo.__index = duplicateV2_adj.metatable_ResDreamlandRankInfo
--endregion

---@param tbl duplicateV2.ResDreamlandRankInfo 待调整的table数据
function duplicateV2_adj.AdjustResDreamlandRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResDreamlandRankInfo)
    if tbl.myUnionRank == nil then
        tbl.myUnionRank = {}
    else
        if duplicateV2_adj.AdjustPlayerActivityData ~= nil then
            for i = 1, #tbl.myUnionRank do
                duplicateV2_adj.AdjustPlayerActivityData(tbl.myUnionRank[i])
            end
        end
    end
    if tbl.otherUnionRank == nil then
        tbl.otherUnionRank = {}
    else
        if duplicateV2_adj.AdjustPlayerActivityData ~= nil then
            for i = 1, #tbl.otherUnionRank do
                duplicateV2_adj.AdjustPlayerActivityData(tbl.otherUnionRank[i])
            end
        end
    end
    if tbl.allBossHurt == nil then
        tbl.allBossHurtSpecified = false
        tbl.allBossHurt = 0
    else
        tbl.allBossHurtSpecified = true
    end
    if tbl.allBossKill == nil then
        tbl.allBossKillSpecified = false
        tbl.allBossKill = 0
    else
        tbl.allBossKillSpecified = true
    end
    if tbl.allKill == nil then
        tbl.allKillSpecified = false
        tbl.allKill = 0
    else
        tbl.allKillSpecified = true
    end
end

--region metatable duplicateV2.ReqSeePreviousData
---@type duplicateV2.ReqSeePreviousData
duplicateV2_adj.metatable_ReqSeePreviousData = {
    _ClassName = "duplicateV2.ReqSeePreviousData",
}
duplicateV2_adj.metatable_ReqSeePreviousData.__index = duplicateV2_adj.metatable_ReqSeePreviousData
--endregion

---@param tbl duplicateV2.ReqSeePreviousData 待调整的table数据
function duplicateV2_adj.AdjustReqSeePreviousData(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqSeePreviousData)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable duplicateV2.ReqClosePreviousData
---@type duplicateV2.ReqClosePreviousData
duplicateV2_adj.metatable_ReqClosePreviousData = {
    _ClassName = "duplicateV2.ReqClosePreviousData",
}
duplicateV2_adj.metatable_ReqClosePreviousData.__index = duplicateV2_adj.metatable_ReqClosePreviousData
--endregion

---@param tbl duplicateV2.ReqClosePreviousData 待调整的table数据
function duplicateV2_adj.AdjustReqClosePreviousData(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqClosePreviousData)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable duplicateV2.ResBudoMeetAround
---@type duplicateV2.ResBudoMeetAround
duplicateV2_adj.metatable_ResBudoMeetAround = {
    _ClassName = "duplicateV2.ResBudoMeetAround",
}
duplicateV2_adj.metatable_ResBudoMeetAround.__index = duplicateV2_adj.metatable_ResBudoMeetAround
--endregion

---@param tbl duplicateV2.ResBudoMeetAround 待调整的table数据
function duplicateV2_adj.AdjustResBudoMeetAround(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResBudoMeetAround)
    if tbl.phase == nil then
        tbl.phaseSpecified = false
        tbl.phase = 0
    else
        tbl.phaseSpecified = true
    end
    if tbl.warPoint == nil then
        tbl.warPoint = {}
    else
        if duplicateV2_adj.AdjustPoint ~= nil then
            for i = 1, #tbl.warPoint do
                duplicateV2_adj.AdjustPoint(tbl.warPoint[i])
            end
        end
    end
    if tbl.wallPoint == nil then
        tbl.wallPoint = {}
    else
        if duplicateV2_adj.AdjustPoint ~= nil then
            for i = 1, #tbl.wallPoint do
                duplicateV2_adj.AdjustPoint(tbl.wallPoint[i])
            end
        end
    end
end

--region metatable duplicateV2.Point
---@type duplicateV2.Point
duplicateV2_adj.metatable_Point = {
    _ClassName = "duplicateV2.Point",
}
duplicateV2_adj.metatable_Point.__index = duplicateV2_adj.metatable_Point
--endregion

---@param tbl duplicateV2.Point 待调整的table数据
function duplicateV2_adj.AdjustPoint(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_Point)
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
end

--region metatable duplicateV2.ResDevilSquareEndTime
---@type duplicateV2.ResDevilSquareEndTime
duplicateV2_adj.metatable_ResDevilSquareEndTime = {
    _ClassName = "duplicateV2.ResDevilSquareEndTime",
}
duplicateV2_adj.metatable_ResDevilSquareEndTime.__index = duplicateV2_adj.metatable_ResDevilSquareEndTime
--endregion

---@param tbl duplicateV2.ResDevilSquareEndTime 待调整的table数据
function duplicateV2_adj.AdjustResDevilSquareEndTime(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResDevilSquareEndTime)
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
    if tbl.duplicateType == nil then
        tbl.duplicateTypeSpecified = false
        tbl.duplicateType = 0
    else
        tbl.duplicateTypeSpecified = true
    end
end

--region metatable duplicateV2.ReqDevilSquareEndTime
---@type duplicateV2.ReqDevilSquareEndTime
duplicateV2_adj.metatable_ReqDevilSquareEndTime = {
    _ClassName = "duplicateV2.ReqDevilSquareEndTime",
}
duplicateV2_adj.metatable_ReqDevilSquareEndTime.__index = duplicateV2_adj.metatable_ReqDevilSquareEndTime
--endregion

---@param tbl duplicateV2.ReqDevilSquareEndTime 待调整的table数据
function duplicateV2_adj.AdjustReqDevilSquareEndTime(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqDevilSquareEndTime)
    if tbl.duplicateType == nil then
        tbl.duplicateTypeSpecified = false
        tbl.duplicateType = 0
    else
        tbl.duplicateTypeSpecified = true
    end
end

--region metatable duplicateV2.ResDevilSquareHasTime
---@type duplicateV2.ResDevilSquareHasTime
duplicateV2_adj.metatable_ResDevilSquareHasTime = {
    _ClassName = "duplicateV2.ResDevilSquareHasTime",
}
duplicateV2_adj.metatable_ResDevilSquareHasTime.__index = duplicateV2_adj.metatable_ResDevilSquareHasTime
--endregion

---@param tbl duplicateV2.ResDevilSquareHasTime 待调整的table数据
function duplicateV2_adj.AdjustResDevilSquareHasTime(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResDevilSquareHasTime)
    if tbl.hasTime == nil then
        tbl.hasTimeSpecified = false
        tbl.hasTime = 0
    else
        tbl.hasTimeSpecified = true
    end
    if tbl.duplicateType == nil then
        tbl.duplicateTypeSpecified = false
        tbl.duplicateType = 0
    else
        tbl.duplicateTypeSpecified = true
    end
end

--region metatable duplicateV2.ResUseDevilScrollPrompt
---@type duplicateV2.ResUseDevilScrollPrompt
duplicateV2_adj.metatable_ResUseDevilScrollPrompt = {
    _ClassName = "duplicateV2.ResUseDevilScrollPrompt",
}
duplicateV2_adj.metatable_ResUseDevilScrollPrompt.__index = duplicateV2_adj.metatable_ResUseDevilScrollPrompt
--endregion

---@param tbl duplicateV2.ResUseDevilScrollPrompt 待调整的table数据
function duplicateV2_adj.AdjustResUseDevilScrollPrompt(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResUseDevilScrollPrompt)
    if tbl.deliverId == nil then
        tbl.deliverIdSpecified = false
        tbl.deliverId = 0
    else
        tbl.deliverIdSpecified = true
    end
end

--region metatable duplicateV2.ReqReliveHuntMonster
---@type duplicateV2.ReqReliveHuntMonster
duplicateV2_adj.metatable_ReqReliveHuntMonster = {
    _ClassName = "duplicateV2.ReqReliveHuntMonster",
}
duplicateV2_adj.metatable_ReqReliveHuntMonster.__index = duplicateV2_adj.metatable_ReqReliveHuntMonster
--endregion

---@param tbl duplicateV2.ReqReliveHuntMonster 待调整的table数据
function duplicateV2_adj.AdjustReqReliveHuntMonster(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ReqReliveHuntMonster)
    if tbl.NpcId == nil then
        tbl.NpcIdSpecified = false
        tbl.NpcId = 0
    else
        tbl.NpcIdSpecified = true
    end
end

--region metatable duplicateV2.BudoBetBeiInfo
---@type duplicateV2.BudoBetBeiInfo
duplicateV2_adj.metatable_BudoBetBeiInfo = {
    _ClassName = "duplicateV2.BudoBetBeiInfo",
}
duplicateV2_adj.metatable_BudoBetBeiInfo.__index = duplicateV2_adj.metatable_BudoBetBeiInfo
--endregion

---@param tbl duplicateV2.BudoBetBeiInfo 待调整的table数据
function duplicateV2_adj.AdjustBudoBetBeiInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_BudoBetBeiInfo)
    if tbl.info == nil then
        tbl.info = {}
    else
        if duplicateV2_adj.AdjustPlayerBetBeiInfo ~= nil then
            for i = 1, #tbl.info do
                duplicateV2_adj.AdjustPlayerBetBeiInfo(tbl.info[i])
            end
        end
    end
end

--region metatable duplicateV2.PlayerBetBeiInfo
---@type duplicateV2.PlayerBetBeiInfo
duplicateV2_adj.metatable_PlayerBetBeiInfo = {
    _ClassName = "duplicateV2.PlayerBetBeiInfo",
}
duplicateV2_adj.metatable_PlayerBetBeiInfo.__index = duplicateV2_adj.metatable_PlayerBetBeiInfo
--endregion

---@param tbl duplicateV2.PlayerBetBeiInfo 待调整的table数据
function duplicateV2_adj.AdjustPlayerBetBeiInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_PlayerBetBeiInfo)
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
    if tbl.someSelectBetInt == nil then
        tbl.someSelectBetIntSpecified = false
        tbl.someSelectBetInt = 0
    else
        tbl.someSelectBetIntSpecified = true
    end
    if tbl.finalBetInt == nil then
        tbl.finalBetIntSpecified = false
        tbl.finalBetInt = 0
    else
        tbl.finalBetIntSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable duplicateV2.BudoBetSuccess
---@type duplicateV2.BudoBetSuccess
duplicateV2_adj.metatable_BudoBetSuccess = {
    _ClassName = "duplicateV2.BudoBetSuccess",
}
duplicateV2_adj.metatable_BudoBetSuccess.__index = duplicateV2_adj.metatable_BudoBetSuccess
--endregion

---@param tbl duplicateV2.BudoBetSuccess 待调整的table数据
function duplicateV2_adj.AdjustBudoBetSuccess(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_BudoBetSuccess)
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
    if tbl.canZhu == nil then
        tbl.canZhuSpecified = false
        tbl.canZhu = 0
    else
        tbl.canZhuSpecified = true
    end
    if tbl.targetZhu == nil then
        tbl.targetZhuSpecified = false
        tbl.targetZhu = 0
    else
        tbl.targetZhuSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.betInt == nil then
        tbl.betIntSpecified = false
        tbl.betInt = 0
    else
        tbl.betIntSpecified = true
    end
end

--region metatable duplicateV2.ResWolfDreamXpSkillChangeTime
---@type duplicateV2.ResWolfDreamXpSkillChangeTime
duplicateV2_adj.metatable_ResWolfDreamXpSkillChangeTime = {
    _ClassName = "duplicateV2.ResWolfDreamXpSkillChangeTime",
}
duplicateV2_adj.metatable_ResWolfDreamXpSkillChangeTime.__index = duplicateV2_adj.metatable_ResWolfDreamXpSkillChangeTime
--endregion

---@param tbl duplicateV2.ResWolfDreamXpSkillChangeTime 待调整的table数据
function duplicateV2_adj.AdjustResWolfDreamXpSkillChangeTime(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResWolfDreamXpSkillChangeTime)
    if tbl.skillId == nil then
        tbl.skillIdSpecified = false
        tbl.skillId = 0
    else
        tbl.skillIdSpecified = true
    end
end

--region metatable duplicateV2.UndergroundDuplicateInfo
---@type duplicateV2.UndergroundDuplicateInfo
duplicateV2_adj.metatable_UndergroundDuplicateInfo = {
    _ClassName = "duplicateV2.UndergroundDuplicateInfo",
}
duplicateV2_adj.metatable_UndergroundDuplicateInfo.__index = duplicateV2_adj.metatable_UndergroundDuplicateInfo
--endregion

---@param tbl duplicateV2.UndergroundDuplicateInfo 待调整的table数据
function duplicateV2_adj.AdjustUndergroundDuplicateInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_UndergroundDuplicateInfo)
    if tbl.monsterLiveLeft == nil then
        tbl.monsterLiveLeftSpecified = false
        tbl.monsterLiveLeft = 0
    else
        tbl.monsterLiveLeftSpecified = true
    end
end

--region metatable duplicateV2.UndergroundMyUnionRank
---@type duplicateV2.UndergroundMyUnionRank
duplicateV2_adj.metatable_UndergroundMyUnionRank = {
    _ClassName = "duplicateV2.UndergroundMyUnionRank",
}
duplicateV2_adj.metatable_UndergroundMyUnionRank.__index = duplicateV2_adj.metatable_UndergroundMyUnionRank
--endregion

---@param tbl duplicateV2.UndergroundMyUnionRank 待调整的table数据
function duplicateV2_adj.AdjustUndergroundMyUnionRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_UndergroundMyUnionRank)
    if tbl.myUnionRank == nil then
        tbl.myUnionRankSpecified = false
        tbl.myUnionRank = 0
    else
        tbl.myUnionRankSpecified = true
    end
end

--region metatable duplicateV2.PushBubble
---@type duplicateV2.PushBubble
duplicateV2_adj.metatable_PushBubble = {
    _ClassName = "duplicateV2.PushBubble",
}
duplicateV2_adj.metatable_PushBubble.__index = duplicateV2_adj.metatable_PushBubble
--endregion

---@param tbl duplicateV2.PushBubble 待调整的table数据
function duplicateV2_adj.AdjustPushBubble(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_PushBubble)
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
end

--region metatable duplicateV2.RaiderInfo
---@type duplicateV2.RaiderInfo
duplicateV2_adj.metatable_RaiderInfo = {
    _ClassName = "duplicateV2.RaiderInfo",
}
duplicateV2_adj.metatable_RaiderInfo.__index = duplicateV2_adj.metatable_RaiderInfo
--endregion

---@param tbl duplicateV2.RaiderInfo 待调整的table数据
function duplicateV2_adj.AdjustRaiderInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_RaiderInfo)
    if tbl.wave == nil then
        tbl.waveSpecified = false
        tbl.wave = 0
    else
        tbl.waveSpecified = true
    end
    if tbl.nextWaveTime == nil then
        tbl.nextWaveTimeSpecified = false
        tbl.nextWaveTime = 0
    else
        tbl.nextWaveTimeSpecified = true
    end
    if tbl.curMonsterNum == nil then
        tbl.curMonsterNumSpecified = false
        tbl.curMonsterNum = 0
    else
        tbl.curMonsterNumSpecified = true
    end
    if tbl.raiderSpecialItemInfos == nil then
        tbl.raiderSpecialItemInfos = {}
    else
        if duplicateV2_adj.AdjustRaiderSpecialItemInfo ~= nil then
            for i = 1, #tbl.raiderSpecialItemInfos do
                duplicateV2_adj.AdjustRaiderSpecialItemInfo(tbl.raiderSpecialItemInfos[i])
            end
        end
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
end

--region metatable duplicateV2.RaiderSpecialItemInfo
---@type duplicateV2.RaiderSpecialItemInfo
duplicateV2_adj.metatable_RaiderSpecialItemInfo = {
    _ClassName = "duplicateV2.RaiderSpecialItemInfo",
}
duplicateV2_adj.metatable_RaiderSpecialItemInfo.__index = duplicateV2_adj.metatable_RaiderSpecialItemInfo
--endregion

---@param tbl duplicateV2.RaiderSpecialItemInfo 待调整的table数据
function duplicateV2_adj.AdjustRaiderSpecialItemInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_RaiderSpecialItemInfo)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
end

--region metatable duplicateV2.SabacReward
---@type duplicateV2.SabacReward
duplicateV2_adj.metatable_SabacReward = {
    _ClassName = "duplicateV2.SabacReward",
}
duplicateV2_adj.metatable_SabacReward.__index = duplicateV2_adj.metatable_SabacReward
--endregion

---@param tbl duplicateV2.SabacReward 待调整的table数据
function duplicateV2_adj.AdjustSabacReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_SabacReward)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable duplicateV2.ResTowerInstanceEndGetReward
---@type duplicateV2.ResTowerInstanceEndGetReward
duplicateV2_adj.metatable_ResTowerInstanceEndGetReward = {
    _ClassName = "duplicateV2.ResTowerInstanceEndGetReward",
}
duplicateV2_adj.metatable_ResTowerInstanceEndGetReward.__index = duplicateV2_adj.metatable_ResTowerInstanceEndGetReward
--endregion

---@param tbl duplicateV2.ResTowerInstanceEndGetReward 待调整的table数据
function duplicateV2_adj.AdjustResTowerInstanceEndGetReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_ResTowerInstanceEndGetReward)
    if tbl.rewards == nil then
        tbl.rewards = {}
    else
        if duplicateV2_adj.AdjustTowerReward ~= nil then
            for i = 1, #tbl.rewards do
                duplicateV2_adj.AdjustTowerReward(tbl.rewards[i])
            end
        end
    end
end

--region metatable duplicateV2.TowerReward
---@type duplicateV2.TowerReward
duplicateV2_adj.metatable_TowerReward = {
    _ClassName = "duplicateV2.TowerReward",
}
duplicateV2_adj.metatable_TowerReward.__index = duplicateV2_adj.metatable_TowerReward
--endregion

---@param tbl duplicateV2.TowerReward 待调整的table数据
function duplicateV2_adj.AdjustTowerReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, duplicateV2_adj.metatable_TowerReward)
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

return duplicateV2_adj