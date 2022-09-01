---@class cfg_growth_weapon_levelManager:TableManager
local cfg_growth_weapon_levelManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_growth_weapon_level
function cfg_growth_weapon_levelManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_growth_weapon_level> 遍历方法
function cfg_growth_weapon_levelManager:ForPair(action)
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
function cfg_growth_weapon_levelManager:PostProcess()
end

---通过type返回table
------@param type number type字段
-----@return TABLE.cfg_growth_weapon_level
function cfg_growth_weapon_levelManager:GetLevelTableByType(type)
    if self.dic == nil then
        return nil
    end
    local data = {}
    for k, v in pairs(self.dic) do
        if v:GetType() == type then
            table.insert(data, v)
        end
    end
    table.sort(data, function(a, b)
        return a:GetId() < b:GetId()
    end)
    return data
end

return cfg_growth_weapon_levelManager