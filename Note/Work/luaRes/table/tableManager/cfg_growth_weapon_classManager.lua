---@class cfg_growth_weapon_classManager:TableManager
local cfg_growth_weapon_classManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_growth_weapon_class
function cfg_growth_weapon_classManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_growth_weapon_class> 遍历方法
function cfg_growth_weapon_classManager:ForPair(action)
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
function cfg_growth_weapon_classManager:PostProcess()
end

return cfg_growth_weapon_classManager