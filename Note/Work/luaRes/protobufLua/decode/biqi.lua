--[[本文件为工具自动生成,禁止手动修改]]
local biqiV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData biqiV2.MonsterInfo lua中的数据结构
---@return biqiV2.MonsterInfo C#中的数据结构
function biqiV2.MonsterInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.biqiV2.MonsterInfo()
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
    return data
end

---@param decodedData biqiV2.EnemyInfo lua中的数据结构
---@return biqiV2.EnemyInfo C#中的数据结构
function biqiV2.EnemyInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.biqiV2.EnemyInfo()
    if decodedData.num ~= nil and decodedData.numSpecified ~= false then
        data.num = decodedData.num
    end
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
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    return data
end

---@param decodedData biqiV2.ScoreRankInfo lua中的数据结构
---@return biqiV2.ScoreRankInfo C#中的数据结构
function biqiV2.ScoreRankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.biqiV2.ScoreRankInfo()
    if decodedData.rank ~= nil and decodedData.rankSpecified ~= false then
        data.rank = decodedData.rank
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.score ~= nil and decodedData.scoreSpecified ~= false then
        data.score = decodedData.score
    end
    if decodedData.self ~= nil and decodedData.selfSpecified ~= false then
        data.self = decodedData.self
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(biqiV2.ItemInfo(decodedData.info[i]))
        end
    end
    if decodedData.lv ~= nil and decodedData.lvSpecified ~= false then
        data.lv = decodedData.lv
    end
    return data
end

---@param decodedData biqiV2.ItemInfo lua中的数据结构
---@return biqiV2.ItemInfo C#中的数据结构
function biqiV2.ItemInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.biqiV2.ItemInfo()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

--[[biqiV2.ResChangCampTip 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData biqiV2.ResBiQiMonster lua中的数据结构
---@return biqiV2.ResBiQiMonster C#中的数据结构
function biqiV2.ResBiQiMonster(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.biqiV2.ResBiQiMonster()
    if decodedData.monsterList ~= nil and decodedData.monsterListSpecified ~= false then
        for i = 1, #decodedData.monsterList do
            data.monsterList:Add(biqiV2.MonsterInfo(decodedData.monsterList[i]))
        end
    end
    return data
end

---@param decodedData biqiV2.ResBiQiEnemy lua中的数据结构
---@return biqiV2.ResBiQiEnemy C#中的数据结构
function biqiV2.ResBiQiEnemy(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.biqiV2.ResBiQiEnemy()
    if decodedData.enemyList ~= nil and decodedData.enemyListSpecified ~= false then
        for i = 1, #decodedData.enemyList do
            data.enemyList:Add(biqiV2.EnemyInfo(decodedData.enemyList[i]))
        end
    end
    return data
end

---@param decodedData biqiV2.ResScoreRank lua中的数据结构
---@return biqiV2.ResScoreRank C#中的数据结构
function biqiV2.ResScoreRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.biqiV2.ResScoreRank()
    if decodedData.scoreList ~= nil and decodedData.scoreListSpecified ~= false then
        for i = 1, #decodedData.scoreList do
            data.scoreList:Add(biqiV2.ScoreRankInfo(decodedData.scoreList[i]))
        end
    end
    return data
end

--[[biqiV2.ResNixiBuffInfo 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[biqiV2.ResScoreReward 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData biqiV2.ResRoleScore lua中的数据结构
---@return biqiV2.ResRoleScore C#中的数据结构
function biqiV2.ResRoleScore(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.biqiV2.ResRoleScore()
    if decodedData.rank ~= nil and decodedData.rankSpecified ~= false then
        data.rank = decodedData.rank
    end
    if decodedData.score ~= nil and decodedData.scoreSpecified ~= false then
        data.score = decodedData.score
    end
    return data
end

---@param decodedData biqiV2.ResPlayerViewGroup lua中的数据结构
---@return biqiV2.ResPlayerViewGroup C#中的数据结构
function biqiV2.ResPlayerViewGroup(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.biqiV2.ResPlayerViewGroup()
    if decodedData.groupOne ~= nil and decodedData.groupOneSpecified ~= false then
        for i = 1, #decodedData.groupOne do
            data.groupOne:Add(decodedData.groupOne[i])
        end
    end
    if decodedData.groupTwo ~= nil and decodedData.groupTwoSpecified ~= false then
        for i = 1, #decodedData.groupTwo do
            data.groupTwo:Add(decodedData.groupTwo[i])
        end
    end
    return data
end

return biqiV2