---@class cfg_boss_skill_describeManager:TableManager
local cfg_boss_skill_describeManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_boss_skill_describe
function cfg_boss_skill_describeManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_boss_skill_describe> 遍历方法
function cfg_boss_skill_describeManager:ForPair(action)
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
function cfg_boss_skill_describeManager:PostProcess()
end

---获取技能描述信息表列表
---@param skillDesIdList table<number>
---@return table<TABLE.cfg_boss_skill_describe>
function cfg_boss_skill_describeManager:GetSkillDesInfoList(skillDesIdList)
    local skillDesInfoTblList = {}
    if type(skillDesIdList) ~= 'table' then
        return skillDesInfoTblList
    end
    for k,v in pairs(skillDesIdList) do
        if type(v) == 'number' then
            local tbl = self:TryGetValue(v)
            if tbl ~= nil then
                table.insert(skillDesInfoTblList,tbl)
            end
        end
    end
    return skillDesInfoTblList
end

return cfg_boss_skill_describeManager