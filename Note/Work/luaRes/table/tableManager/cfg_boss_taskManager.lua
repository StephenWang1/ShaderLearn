---@class cfg_boss_taskManager:TableManager
local cfg_boss_taskManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_boss_task
function cfg_boss_taskManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_boss_task> 遍历方法
function cfg_boss_taskManager:ForPair(action)
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
function cfg_boss_taskManager:PostProcess()
end

---宗室任务是否可以扫荡
---@param bossTaskId number bossTask表id
---@return boolean
function cfg_boss_taskManager:TaskCanClear(bossTaskId)
    local bossTaskTbl = self:TryGetValue(bossTaskId)
    if bossTaskTbl == nil or bossTaskTbl:GetCompletion() <= 0 then
        return false
    end
    return bossTaskTbl:GetCompletion() == 1
end

---宗师任务扫荡消耗
---@param bossTaskId number bossTask表id
---@return Cost
function cfg_boss_taskManager:GetTaskClearCost(bossTaskId)
    local bossTaskTbl = self:TryGetValue(bossTaskId)
    if bossTaskTbl == nil or bossTaskTbl:GetCompletionItem() == nil or bossTaskTbl:GetCompletionItem().list == nil or Utility.GetTableCount(bossTaskTbl:GetCompletionItem().list) < 2 then
        return
    end
    ---@type Cost
    local bossClearCost = {}
    bossClearCost.itemId = bossTaskTbl:GetCompletionItem().list[1]
    bossClearCost.costNum = bossTaskTbl:GetCompletionItem().list[2]
    return bossClearCost
end

return cfg_boss_taskManager