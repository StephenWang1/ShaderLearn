---@class cfg_skills_conditionManager:TableManager
local cfg_skills_conditionManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_skills_condition
function cfg_skills_conditionManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_skills_condition> 遍历方法
function cfg_skills_conditionManager:ForPair(action)
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
function cfg_skills_conditionManager:PostProcess()
end

---得到技能条件Table
---@return TABLE.cfg_skills_condition
function cfg_skills_conditionManager:GetSkillsCondition(SkillId, level)
    local csdata = CS.Cfg_SkillsConditionManager.Instance:GetSkillsCondition(SkillId, level);
    if csdata == nil then
        return nil
    end
    return self:TryGetValue(csdata.id)
end

return cfg_skills_conditionManager