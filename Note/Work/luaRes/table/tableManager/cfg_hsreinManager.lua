---@class cfg_hsreinManager:TableManager
local cfg_hsreinManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_hsrein
function cfg_hsreinManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_hsrein> 遍历方法
function cfg_hsreinManager:ForPair(action)
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
function cfg_hsreinManager:PostProcess()
end

return cfg_hsreinManager