---@class cfg_leagueManager:TableManager
local cfg_leagueManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_league
function cfg_leagueManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_league> 遍历方法
function cfg_leagueManager:ForPair(action)
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
function cfg_leagueManager:PostProcess()
end

cfg_leagueManager.mSortedLeagueList = nil

---获取排序之后的联盟列表
function cfg_leagueManager:GetSortedLeagueList()
    if cfg_leagueManager.mSortedLeagueList == nil then
        cfg_leagueManager.mSortedLeagueList = {}
        self:ForPair(function(key, value)
            table.insert(cfg_leagueManager.mSortedLeagueList, value)
        end)
        table.sort(cfg_leagueManager.mSortedLeagueList, function(a, b)
            return self:SortLeagueList(a, b)
        end)
    end
    return cfg_leagueManager.mSortedLeagueList
end

---联盟排序
---param l TABLE.cfg_league
---param r TABLE.cfg_league
function cfg_leagueManager:SortLeagueList(l, r)
    if l == nil or r == nil then
        return false
    end

    local lOrder = l:GetOrder() == nil and 0 or l:GetOrder()
    local rOrder = r:GetOrder() == nil and 0 or r:GetOrder()
    return tonumber(lOrder) < tonumber(rOrder)
end

return cfg_leagueManager