---@class LuaRankData 排行榜信息
local LuaRankData = {}

function LuaRankData:GetRankRefreshTime()
    if self.rankRefreshTime == nil then
        self.rankRefreshTime = 0
    end
    return self.rankRefreshTime
end

---获取当前排行信息
---@return <number,rankV2.RoleRankDataInfo>
function LuaRankData:GetCurRankTbl()
    if self.rankTbl == nil then
        self.rankTbl = {}
    end
    return self.rankTbl
end

---获取主角排行
function LuaRankData:GetMainPlayerRank()
    if self.mainPlayerRank == nil then
        self.mainPlayerRank = 0
    end
    return self.mainPlayerRanks
end


---刷新排行接口
---@param rankInfo rankV2.ResLookRank
function LuaRankData:RefreshRankData(rankInfo)
    self:ResetRankData()
    self.rankTbl = rankInfo.roleRankDataInfos
    self.mainPlayerRank = rankInfo.ranking
    self.rankRefreshTime = rankInfo.refreshTime
end

---重置数据
function LuaRankData:ResetRankData()
    self.rankTbl = {}
    self.mainPlayerRank = 0
    self.rankRefreshTime = 0
end

return LuaRankData
