---@class cfg_bairimen_activityManager:TableManager
local cfg_bairimen_activityManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_bairimen_activity
function cfg_bairimen_activityManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_bairimen_activity> 遍历方法
function cfg_bairimen_activityManager:ForPair(action)
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
function cfg_bairimen_activityManager:PostProcess()
end

---通过monsterID获取表数据
---@param monsterID number
---@param activeSubType 活动类型
function cfg_bairimen_activityManager:GetMonsterIDbyTable(monsterID, activeSubType)
    if self.dic then
        for i, v in pairs(self.dic) do
            ---@type TABLE.cfg_bairimen_activity
            local temp = v
            if temp:GetMonsterId() == monsterID and temp:GetSubtype() == activeSubType then
                return temp
            end
        end
    end
    return nil

end

---判断当前活动怪物是否满足条件
function cfg_bairimen_activityManager:IsMeetConditionById(btnActId)
    local brmActTbl = self:TryGetValue(btnActId)
    if brmActTbl == nil then
        return false
    end
    if brmActTbl:GetActivityCondition() ~= nil then
        for i = 1, #brmActTbl:GetActivityCondition().list do
            local conditionID = brmActTbl:GetActivityCondition().list[i]
            if CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionID) == false then
                return false
            end
        end
    end
    return true
end

---判断当前活动怪物是否满足条件
function cfg_bairimen_activityManager:IsMeetConditionByTbl(brmActTbl)
    if brmActTbl == nil then
        return false
    end
    if brmActTbl:GetActivityCondition() ~= nil then
        for i = 1, #brmActTbl:GetActivityCondition().list do
            local conditionID = brmActTbl:GetActivityCondition().list[i]
            if CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionID) == false then
                return false
            end
        end
    end
    return true
end


return cfg_bairimen_activityManager