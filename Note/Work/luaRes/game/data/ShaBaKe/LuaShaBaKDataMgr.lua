---@class LuaShaBaKDataMgr
local LuaShaBaKDataMgr = {};

---@type duplicateV2.SabacInfo
LuaShaBaKDataMgr.mShaBaKData = nil;

---@type duplicateV2.SabacScoreInfo
LuaShaBaKDataMgr.mShaBaKScoreData = nil;

---@type duplicateV2.ResSabacRankInfo (C#数据结构)沙巴克个人积分排行
LuaShaBaKDataMgr.mShaBaKPersonalRankData = nil;

---@type sabacV2.ResSabacDonateRankInfo
LuaShaBaKDataMgr.mShaBaKContributeRankData = nil;

---@type TABLE.cfg_sbk_reward_point
LuaShaBaKDataMgr.mMaxPersonalRewardTbl = nil;

---@type table<number, TABLE.cfg_sbk_reward_point>
LuaShaBaKDataMgr.mRewardPointList = nil;

---@type table<number, TABLE.cfg_sbk_rank_reward>
LuaShaBaKDataMgr.mScoreRewardList = nil;

function LuaShaBaKDataMgr:Init()
    self.mRewardPointList = {};
    self.mScoreRewardList = {};
    ---@param tbl TABLE.cfg_sbk_reward_point
    clientTableManager.cfg_sbk_reward_pointManager:ForPair(function(key, tbl)
        table.insert(self.mRewardPointList, tbl);
        self.mMaxPersonalRewardTbl = tbl;
    end)

    table.sort(self.mRewardPointList, function(a,b)
        return a:GetPoint() <= b:GetPoint();
    end)

    ---@param tbl TABLE.cfg_sbk_rank_reward
    clientTableManager.cfg_sbk_rank_rewardManager:ForPair(function(key, tbl)
        table.insert(self.mScoreRewardList, tbl);
    end)

    table.sort(self.mScoreRewardList, function(a,b)
        local aRanks = a:GetRank();
        local bRanks = b:GetRank();
        if(#aRanks.list >= 1 and #bRanks.list >= 1) then
            local aMin = aRanks.list[1];
            local bMin = bRanks.list[1];
            return aMin <= bMin;
        end
        return false;
    end)
end

---@public 更新沙巴克数据
---@param shaBakData duplicateV2.SabacInfo
function LuaShaBaKDataMgr:UpdateShaBaKData(shaBakData)
    self.mShaBaKData = shaBakData;
end

---@public 更新沙巴克积分数据
---@param shaBaKScoreData duplicateV2.SabacScoreInfo
function LuaShaBaKDataMgr:UpdateShaBaKScoreData(shaBaKScoreData)
    self.mShaBaKScoreData = shaBaKScoreData;
end

---@public 更新沙巴克个人积分排行数据
---@param shaBaKRanKPersonalRankData duplicateV2.ResSabacRankInfo
function LuaShaBaKDataMgr:UpdateShaBaKPersonalRankData(shaBaKRanKPersonalRankData)
    self.mShaBaKPersonalRankData = shaBaKRanKPersonalRankData;
end

---@public 更新沙巴克捐献排行榜数据
---@param shaBaKContributeRankData sabacV2.ResSabacDonateRankInfo
function LuaShaBaKDataMgr:UpdateShaBaKContributeRankData(shaBaKContributeRankData)
    self.mShaBaKContributeRankData = shaBaKContributeRankData
end

---@public 获取沙巴克积分
---@return number
function LuaShaBaKDataMgr:GetShaBaKScore()
    if(self.mShaBaKScoreData ~= nil and self.mShaBaKScoreData.Score ~= nil) then
        return self.mShaBaKScoreData.Score;
    end
    return 0;
end

---@public 获取最大个人奖励表
---@return TABLE.cfg_sbk_reward_point
function LuaShaBaKDataMgr:GetMaxPersonalRewardTbl()
    return self.mMaxPersonalRewardTbl;
end

---@public 获取沙巴克当前显示的
---@return TABLE.cfg_sbk_reward_point
function LuaShaBaKDataMgr:GetCurrentShowRewardTbl()
    ---@param v  TABLE.cfg_sbk_reward_point
    local defaultTbl;
    for k,v in pairs(self.mRewardPointList) do
        if(self:GetShaBaKScore() <= v:GetPoint()) then
            return v;
        end
        defaultTbl = v;
    end
    return defaultTbl;
end

---@public 获取沙巴克个人奖励
---@param tbl TABLE.cfg_sbk_reward_point
---@return table<number, table<number,number>>
function LuaShaBaKDataMgr:GetPersonalRewardItems(tbl)
    local rewards = {};
    if(tbl ~= nil) then
        local rewardStr = tbl:GetReward();
        local idAndNumStr = string.Split(rewardStr, "&");
        if(idAndNumStr ~= nil) then
            for k,v in pairs(idAndNumStr)do
                local str = string.Split(v, "#");
                if(str ~= nil and #str >= 2) then
                    local id = tonumber(str[1]);
                    local num = tonumber(str[2]);
                    table.insert(rewards,{id, num});
                end
            end
        end
    end

    return rewards;
end

---@public 获取沙巴克积分排行奖励
---@param tbl TABLE.cfg_sbk_rank_reward
---@return table<number, table<number,number>>
function LuaShaBaKDataMgr:GetScoreRewardItems(tbl)
    local rewards = {};
    local rewardStr = tbl:GetReward();
    local idAndNumStr = string.Split(rewardStr, "&");
    if(idAndNumStr ~= nil) then
        for k,v in pairs(idAndNumStr)do
            local str = string.Split(v, "#");
            if(str ~= nil and #str >= 2) then
                local id = tonumber(str[1]);
                local num = tonumber(str[2]);
                table.insert(rewards,{id, num});
            end
        end
    end
    return rewards;
end

---@public 获得沙巴克个人积分排行
---@return List<duplicateV2.SabacRankInfo> c# List
function LuaShaBaKDataMgr:GetShaBaRankData()
    if(self.mShaBaKPersonalRankData ~= nil) then
        return self.mShaBaKPersonalRankData.rankInfo;
    end
    return nil;
end

---@public 获得沙巴克个人积分排行
---@return duplicateV2.SabacRankInfo c# 数据结构
function LuaShaBaKDataMgr:GetShaBaKMyRankData()
    if(self.mShaBaKPersonalRankData ~= nil) then
        return self.mShaBaKPersonalRankData.myRankInfo;
    end
    return nil;
end

---@public 获得所有排行奖励
---@return table<number, TABLE.cfg_sbk_rank_reward>
function LuaShaBaKDataMgr:GetScoreRankRewards()
    return self.mScoreRewardList;
end

---@public 获得个人积分排行奖励
---@return table<number, TABLE.cfg_sbk_reward_point>
function LuaShaBaKDataMgr:GetPersonalRewards()
    return self.mRewardPointList
end

---@public 获得沙巴克胜利奖励
---@param calendarItem CalendarItem
---@return table<number, table<number,number>>
function LuaShaBaKDataMgr:GetShaBaKWinRewards(calendarItem)
    local rewards = {};
    ---沙巴克胜利发送的称号
    local titleId = 2250011;
    table.insert(rewards,{titleId, 1});
    local isFirstShaBaK = false;
    if(calendarItem ~= nil) then
        isFirstShaBaK = gameMgr:GetLuaActivityMgr():IsFirstSabacActivity(calendarItem);
    end
    local globalId = 22096
    if(isFirstShaBaK) then
        globalId = 22193;
    end

    local globalTbl = LuaGlobalTableDeal.GetGlobalTabl(globalId);
    if(globalTbl ~= nil) then
        local idAndNums = string.Split(globalTbl.value, "&");
        if(idAndNums ~= nil and #idAndNums > 0) then
            for k,v in pairs(idAndNums) do
                local idAndNum = string.Split(v, "#");
                if(idAndNum ~= nil and #idAndNum > 1) then
                    local itemId = tonumber(idAndNum[1]);
                    local num = tonumber(idAndNum[2]);
                    table.insert(rewards, {itemId, num});
                end
            end
        end
    end
    return rewards;
end

---@private 胜利方捐沙比例
---@type number
LuaShaBaKDataMgr.mWinnerContributeRatio = 0;

---@private 总捐沙奖励比例
---@type number
LuaShaBaKDataMgr.mAllContributeRatio = 0;

---@private 捐沙获得奖励所需捐赠的最小钻石数量
---@type number
LuaShaBaKDataMgr.mMinRewardNeedCoinValue = 0;

---@public 胜利方捐沙比例
---@return number
function LuaShaBaKDataMgr:GetWinnerContributeRatio()
    if(self.mWinnerContributeRatio == 0) then
        local globalId = 22906;
        local globalTable = LuaGlobalTableDeal.GetGlobalTabl(globalId);
        if(globalTable ~= nil) then
            self.mWinnerContributeRatio = tonumber(globalTable.value) / 10000;
        end
    end

    if(self.mWinnerContributeRatio == 0) then
        self.mWinnerContributeRatio = 0.6;
    end
    return self.mWinnerContributeRatio;
end

---@public 捐沙获得奖励所需捐赠的最小钻石数量
---@return number
function LuaShaBaKDataMgr:GetMinRewardNeedCoinValue()
    if(self.mMinRewardNeedCoinValue == 0) then
        local globalId = 22907;
        local globalTable = LuaGlobalTableDeal.GetGlobalTabl(globalId);
        if(globalTable ~= nil) then
            self.mMinRewardNeedCoinValue = tonumber(globalTable.value);
        end
    end

    if(self.mMinRewardNeedCoinValue == 0) then
        self.mMinRewardNeedCoinValue = 1000;
    end
    return self.mMinRewardNeedCoinValue;
end

---@public 失败方捐沙比例
---@return number
function LuaShaBaKDataMgr:GetLoserContributeRatio()
    return 1 - self:GetWinnerContributeRatio();
end

---@private 总捐沙奖励比例
---@return number;
function LuaShaBaKDataMgr:GetAllContributeRatio()
    if(self.mAllContributeRatio == 0) then
        local globalId = 22905;
        local globalTable = LuaGlobalTableDeal.GetGlobalTabl(globalId);
        if(globalTable ~= nil) then
            self.mAllContributeRatio = tonumber(globalTable.value) / 10000;
        end
    end

    if(self.mAllContributeRatio == 0) then
        self.mAllContributeRatio = 0.7;
    end
    return self.mAllContributeRatio;
end

---@public 获得累计捐沙奖励值
---@return number
function LuaShaBaKDataMgr:GetAllContributeValue()
    if(self.mShaBaKContributeRankData ~= nil) then
        return math.floor(self.mShaBaKContributeRankData.totalDonate * self:GetAllContributeRatio());
    end
    return 0;
end

---@public 获得胜利方捐沙值
---@return number
function LuaShaBaKDataMgr:GetWinnerContributeValue()
    return math.floor(self:GetAllContributeValue() * self:GetWinnerContributeRatio());
end

---@public 获得失败方捐沙值
---@return number
function LuaShaBaKDataMgr:GetLoserContributeValue()
    return math.floor(self:GetAllContributeValue() * self:GetLoserContributeRatio());
end

---@public 获得捐沙前5名
---@return table<number, sabacV2.SabacDonateRankPlayer>
function LuaShaBaKDataMgr:GetContributeRank()
    if(self.mShaBaKContributeRankData ~= nil) then
        return self.mShaBaKContributeRankData.rankList
    end
    return nil;
end

---@public 获得主角的捐沙排名
---@return sabacV2.SabacDonateRankPlayer
function LuaShaBaKDataMgr:GetMainPlayerContributeRank()
    if(self.mShaBaKContributeRankData ~= nil) then
        return self.mShaBaKContributeRankData.self
    end
    return nil;
end

return LuaShaBaKDataMgr;