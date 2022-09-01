---@class cfg_bossManager:TableManager
local cfg_bossManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_boss
function cfg_bossManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_boss> 遍历方法
function cfg_bossManager:ForPair(action)
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
function cfg_bossManager:PostProcess()
end

---boss地图是否可进
---@param bossId number
function cfg_bossManager:BossMapCanMeet(bossId)
    local bossInfoTable = self:TryGetValue(bossId)
    if bossInfoTable ~= nil then
        local level = bossInfoTable:GetLevel()
        if level ~= nil then
            return CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(bossInfoTable:GetLevel().list)
        end
    end
    return false
end

---获取进入限制条件参数
---@param bossId number
---@return table<number,BossOperationParame>
function cfg_bossManager:GetEventParams(bossId)
    local bossTable = self:TryGetValue(bossId)
    if bossTable == nil then
        return nil
    end
    local eventParameters = bossTable:GetEventParameters()
    if eventParameters == nil or eventParameters == "" then
        return nil
    end
    local temp1 = _fSplit(eventParameters, "&")
    local EventParameDic = {}
    local temp2 = _fSplit(tostring(temp1[1]), "#")
    local Meet = {
        OperationType = tonumber(temp2[1]),
        OperationParame = tostring(temp2[2]),
    }
    EventParameDic[1] = Meet
    if #temp1 == 1 then
        return EventParameDic
    end

    local temp3 = _fSplit(tostring(temp1[2]), "#")
    local NotMeet = {
        OperationType = tonumber(temp3[1]),
        OperationParame = tostring(temp3[2]),
    }
    EventParameDic[2] = NotMeet
    return EventParameDic
end

---boss是否可以扫荡
---@param bossId number boss表id
---@return boolean
function cfg_bossManager:BossCanClear(bossId)
    local bossTbl = self:TryGetValue(bossId)
    if bossTbl == nil or bossTbl:GetCompletion() <= 0 then
        return false
    end
    return bossTbl:GetCompletion() == 1
end

---@class Cost boss扫荡消耗
---@field itemId number 消耗道具id
---@field costNum number 消耗数量

---boss扫荡消耗
---@param bossId number boss表id
---@return Cost
function cfg_bossManager:GetBossClearCost(bossId)
    local bossTbl = self:TryGetValue(bossId)
    if bossTbl == nil or bossTbl:GetCompletionItem() == nil or bossTbl:GetCompletionItem().list == nil or Utility.GetTableCount(bossTbl:GetCompletionItem().list) < 2 then
        return
    end
    ---@type Cost
    local bossClearCost = {}
    bossClearCost.itemId = bossTbl:GetCompletionItem().list[1]
    bossClearCost.costNum = bossTbl:GetCompletionItem().list[2]
    return bossClearCost
end

return cfg_bossManager