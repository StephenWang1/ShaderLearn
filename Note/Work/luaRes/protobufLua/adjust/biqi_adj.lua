--[[本文件为工具自动生成,禁止手动修改]]
local biqiV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable biqiV2.MonsterInfo
---@type biqiV2.MonsterInfo
biqiV2_adj.metatable_MonsterInfo = {
    _ClassName = "biqiV2.MonsterInfo",
}
biqiV2_adj.metatable_MonsterInfo.__index = biqiV2_adj.metatable_MonsterInfo
--endregion

---@param tbl biqiV2.MonsterInfo 待调整的table数据
function biqiV2_adj.AdjustMonsterInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, biqiV2_adj.metatable_MonsterInfo)
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
end

--region metatable biqiV2.EnemyInfo
---@type biqiV2.EnemyInfo
biqiV2_adj.metatable_EnemyInfo = {
    _ClassName = "biqiV2.EnemyInfo",
}
biqiV2_adj.metatable_EnemyInfo.__index = biqiV2_adj.metatable_EnemyInfo
--endregion

---@param tbl biqiV2.EnemyInfo 待调整的table数据
function biqiV2_adj.AdjustEnemyInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, biqiV2_adj.metatable_EnemyInfo)
    if tbl.num == nil then
        tbl.numSpecified = false
        tbl.num = 0
    else
        tbl.numSpecified = true
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

--region metatable biqiV2.ScoreRankInfo
---@type biqiV2.ScoreRankInfo
biqiV2_adj.metatable_ScoreRankInfo = {
    _ClassName = "biqiV2.ScoreRankInfo",
}
biqiV2_adj.metatable_ScoreRankInfo.__index = biqiV2_adj.metatable_ScoreRankInfo
--endregion

---@param tbl biqiV2.ScoreRankInfo 待调整的table数据
function biqiV2_adj.AdjustScoreRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, biqiV2_adj.metatable_ScoreRankInfo)
    if tbl.rank == nil then
        tbl.rankSpecified = false
        tbl.rank = 0
    else
        tbl.rankSpecified = true
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
    if tbl.self == nil then
        tbl.selfSpecified = false
        tbl.self = 0
    else
        tbl.selfSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.info == nil then
        tbl.info = {}
    else
        if biqiV2_adj.AdjustItemInfo ~= nil then
            for i = 1, #tbl.info do
                biqiV2_adj.AdjustItemInfo(tbl.info[i])
            end
        end
    end
    if tbl.lv == nil then
        tbl.lvSpecified = false
        tbl.lv = 0
    else
        tbl.lvSpecified = true
    end
end

--region metatable biqiV2.ItemInfo
---@type biqiV2.ItemInfo
biqiV2_adj.metatable_ItemInfo = {
    _ClassName = "biqiV2.ItemInfo",
}
biqiV2_adj.metatable_ItemInfo.__index = biqiV2_adj.metatable_ItemInfo
--endregion

---@param tbl biqiV2.ItemInfo 待调整的table数据
function biqiV2_adj.AdjustItemInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, biqiV2_adj.metatable_ItemInfo)
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

--region metatable biqiV2.ResChangCampTip
---@type biqiV2.ResChangCampTip
biqiV2_adj.metatable_ResChangCampTip = {
    _ClassName = "biqiV2.ResChangCampTip",
}
biqiV2_adj.metatable_ResChangCampTip.__index = biqiV2_adj.metatable_ResChangCampTip
--endregion

---@param tbl biqiV2.ResChangCampTip 待调整的table数据
function biqiV2_adj.AdjustResChangCampTip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, biqiV2_adj.metatable_ResChangCampTip)
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
end

--region metatable biqiV2.ResBiQiMonster
---@type biqiV2.ResBiQiMonster
biqiV2_adj.metatable_ResBiQiMonster = {
    _ClassName = "biqiV2.ResBiQiMonster",
}
biqiV2_adj.metatable_ResBiQiMonster.__index = biqiV2_adj.metatable_ResBiQiMonster
--endregion

---@param tbl biqiV2.ResBiQiMonster 待调整的table数据
function biqiV2_adj.AdjustResBiQiMonster(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, biqiV2_adj.metatable_ResBiQiMonster)
    if tbl.monsterList == nil then
        tbl.monsterList = {}
    else
        if biqiV2_adj.AdjustMonsterInfo ~= nil then
            for i = 1, #tbl.monsterList do
                biqiV2_adj.AdjustMonsterInfo(tbl.monsterList[i])
            end
        end
    end
end

--region metatable biqiV2.ResBiQiEnemy
---@type biqiV2.ResBiQiEnemy
biqiV2_adj.metatable_ResBiQiEnemy = {
    _ClassName = "biqiV2.ResBiQiEnemy",
}
biqiV2_adj.metatable_ResBiQiEnemy.__index = biqiV2_adj.metatable_ResBiQiEnemy
--endregion

---@param tbl biqiV2.ResBiQiEnemy 待调整的table数据
function biqiV2_adj.AdjustResBiQiEnemy(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, biqiV2_adj.metatable_ResBiQiEnemy)
    if tbl.enemyList == nil then
        tbl.enemyList = {}
    else
        if biqiV2_adj.AdjustEnemyInfo ~= nil then
            for i = 1, #tbl.enemyList do
                biqiV2_adj.AdjustEnemyInfo(tbl.enemyList[i])
            end
        end
    end
end

--region metatable biqiV2.ResScoreRank
---@type biqiV2.ResScoreRank
biqiV2_adj.metatable_ResScoreRank = {
    _ClassName = "biqiV2.ResScoreRank",
}
biqiV2_adj.metatable_ResScoreRank.__index = biqiV2_adj.metatable_ResScoreRank
--endregion

---@param tbl biqiV2.ResScoreRank 待调整的table数据
function biqiV2_adj.AdjustResScoreRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, biqiV2_adj.metatable_ResScoreRank)
    if tbl.scoreList == nil then
        tbl.scoreList = {}
    else
        if biqiV2_adj.AdjustScoreRankInfo ~= nil then
            for i = 1, #tbl.scoreList do
                biqiV2_adj.AdjustScoreRankInfo(tbl.scoreList[i])
            end
        end
    end
end

--region metatable biqiV2.ResNixiBuffInfo
---@type biqiV2.ResNixiBuffInfo
biqiV2_adj.metatable_ResNixiBuffInfo = {
    _ClassName = "biqiV2.ResNixiBuffInfo",
}
biqiV2_adj.metatable_ResNixiBuffInfo.__index = biqiV2_adj.metatable_ResNixiBuffInfo
--endregion

---@param tbl biqiV2.ResNixiBuffInfo 待调整的table数据
function biqiV2_adj.AdjustResNixiBuffInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, biqiV2_adj.metatable_ResNixiBuffInfo)
    if tbl.effect == nil then
        tbl.effectSpecified = false
        tbl.effect = 0
    else
        tbl.effectSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable biqiV2.ResScoreReward
---@type biqiV2.ResScoreReward
biqiV2_adj.metatable_ResScoreReward = {
    _ClassName = "biqiV2.ResScoreReward",
}
biqiV2_adj.metatable_ResScoreReward.__index = biqiV2_adj.metatable_ResScoreReward
--endregion

---@param tbl biqiV2.ResScoreReward 待调整的table数据
function biqiV2_adj.AdjustResScoreReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, biqiV2_adj.metatable_ResScoreReward)
    if tbl.rewardedList == nil then
        tbl.rewardedList = {}
    end
    if tbl.rewardId == nil then
        tbl.rewardIdSpecified = false
        tbl.rewardId = 0
    else
        tbl.rewardIdSpecified = true
    end
end

--region metatable biqiV2.ResRoleScore
---@type biqiV2.ResRoleScore
biqiV2_adj.metatable_ResRoleScore = {
    _ClassName = "biqiV2.ResRoleScore",
}
biqiV2_adj.metatable_ResRoleScore.__index = biqiV2_adj.metatable_ResRoleScore
--endregion

---@param tbl biqiV2.ResRoleScore 待调整的table数据
function biqiV2_adj.AdjustResRoleScore(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, biqiV2_adj.metatable_ResRoleScore)
    if tbl.rank == nil then
        tbl.rankSpecified = false
        tbl.rank = 0
    else
        tbl.rankSpecified = true
    end
    if tbl.score == nil then
        tbl.scoreSpecified = false
        tbl.score = 0
    else
        tbl.scoreSpecified = true
    end
end

--region metatable biqiV2.ResPlayerViewGroup
---@type biqiV2.ResPlayerViewGroup
biqiV2_adj.metatable_ResPlayerViewGroup = {
    _ClassName = "biqiV2.ResPlayerViewGroup",
}
biqiV2_adj.metatable_ResPlayerViewGroup.__index = biqiV2_adj.metatable_ResPlayerViewGroup
--endregion

---@param tbl biqiV2.ResPlayerViewGroup 待调整的table数据
function biqiV2_adj.AdjustResPlayerViewGroup(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, biqiV2_adj.metatable_ResPlayerViewGroup)
    if tbl.groupOne == nil then
        tbl.groupOne = {}
    end
    if tbl.groupTwo == nil then
        tbl.groupTwo = {}
    end
end

return biqiV2_adj