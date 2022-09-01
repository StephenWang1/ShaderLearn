---@class cfg_bloodsuit_resonanceManager:TableManager
local cfg_bloodsuit_resonanceManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_bloodsuit_resonance
function cfg_bloodsuit_resonanceManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_bloodsuit_resonance> 遍历方法
function cfg_bloodsuit_resonanceManager:ForPair(action)
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
function cfg_bloodsuit_resonanceManager:PostProcess()
end

---@return table<number,table<number,TABLE.cfg_bloodsuit_resonance>>
function cfg_bloodsuit_resonanceManager:GetBloodGroupDic()
    if self.mBloodGroupDic == nil then
        self.mBloodGroupDic = self:InitBloodGroupDicInfo()
    end
    return self.mBloodGroupDic
end

---初始化血继组初始信息
---@return table<number,table<number,TABLE.cfg_bloodsuit_resonance>>
function cfg_bloodsuit_resonanceManager:InitBloodGroupDicInfo()
    if self.dic == nil then
        return nil
    end
    local BloodGroupDic = {}
    for i, v in pairs(self.dic) do
        ---@type TABLE.cfg_bloodsuit_resonance
        local temp = v
        local group = BloodGroupDic[temp:GetGroup()]
        if group == nil then
            BloodGroupDic[temp:GetGroup()] = {}
        end
        table.insert(BloodGroupDic[temp:GetGroup()], temp)
    end
    return BloodGroupDic

end

return cfg_bloodsuit_resonanceManager