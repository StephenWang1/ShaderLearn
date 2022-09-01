---@class cfg_ladder_rank_rewardManager:TableManager
local cfg_ladder_rank_rewardManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_ladder_rank_reward
function cfg_ladder_rank_rewardManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_ladder_rank_reward> 遍历方法
function cfg_ladder_rank_rewardManager:ForPair(action)
    if action == nil then
        return
    end
    if self.dic then
        for i, v in pairs(self.dic) do
            action(i, v)
        end
    end
end

---表格解析完毕后调用此方法
function cfg_ladder_rank_rewardManager:PostProcess()

end

function cfg_ladder_rank_rewardManager:LoadRankRewardDic()
    if self.mrankReardDic == nil then
        self.mrankReardDic = {}
    end
    local activityID, rank
    if self.dic then
        for i, v in pairs(self.dic) do
            activityID = self.dic[i]:GetActivityId()
            rank = self.dic[i]:GetRank()
            if activityID and rank then
                if self.mrankReardDic[activityID] == nil then
                    self.mrankReardDic[activityID] = {}
                end
                self.mrankReardDic[activityID][rank] = self.dic[i]:GetItem()
            end
        end
    end
end

function cfg_ladder_rank_rewardManager:GetRankReward(activityId,rank)
    if  self.mrankReardDic == nil then
        self:LoadRankRewardDic()
    end
    if self.mrankReardDic == nil or  self.mrankReardDic[activityId] == nil then
        return nil
    end
    return self.mrankReardDic[activityId][rank]
end

return cfg_ladder_rank_rewardManager