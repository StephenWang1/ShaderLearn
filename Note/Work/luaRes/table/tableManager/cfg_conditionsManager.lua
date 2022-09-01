---@class cfg_conditionsManager:TableManager
local cfg_conditionsManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_conditions
function cfg_conditionsManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_conditions> 遍历方法
function cfg_conditionsManager:ForPair(action)
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
function cfg_conditionsManager:PostProcess()
end

return cfg_conditionsManager