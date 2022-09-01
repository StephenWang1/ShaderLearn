---@class cfg_union_boss_rankManager:TableManager
local cfg_union_boss_rankManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_union_boss_rank
function cfg_union_boss_rankManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_union_boss_rank> 遍历方法
function cfg_union_boss_rankManager:ForPair(action)
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
function cfg_union_boss_rankManager:PostProcess()
end

--region 奖励排行列表
---@type table<LuaEnumRewardRankType,TABLE.cfg_union_boss_rank>
cfg_union_boss_rankManager.RewardRankList = nil

---获取奖励排行列表
---@param rankRewardType LuaEnumRewardRankType
function cfg_union_boss_rankManager:GetRewardRankList(rankRewardType)
    if type(self.RewardRankList) ~= 'table' then
        self:InitRewardRankList()
        self:SortAllRewardRank()
    end
    if type(self.RewardRankList) == 'table' then
        return self.RewardRankList[rankRewardType]
    end
end

---初始化奖励列表
function cfg_union_boss_rankManager:InitRewardRankList()
    self:ForPair(function(key, value)
        ---@type TABLE.cfg_union_boss_rank
        local union_boss_rank = value
        if self.RewardRankList == nil then
            self.RewardRankList = {}
        end
        if self.RewardRankList[union_boss_rank:GetType()] == nil then
            self.RewardRankList[union_boss_rank:GetType()] = {}
        end
        table.insert(self.RewardRankList[union_boss_rank:GetType()],union_boss_rank)
    end)
end

---排序所有的奖励列表
function cfg_union_boss_rankManager:SortAllRewardRank()
    if type(self.RewardRankList) == 'table' then
        for k,v in pairs(self.RewardRankList) do
            ---@type table<TABLE.cfg_union_boss_rank>
            local rankList = v
            table.sort(rankList,function(tbl1,tbl2)
                ---@type TABLE.cfg_union_boss_rank
                local curTbl1 = tbl1
                ---@type TABLE.cfg_union_boss_rank
                local curTbl2 = tbl2
                return curTbl1:GetRank() < curTbl2:GetRank()
            end)
        end
    end
end
--endregion


return cfg_union_boss_rankManager