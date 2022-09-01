---@class cfg_special_activity_goalsManager:TableManager
local cfg_special_activity_goalsManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_special_activity_goals
function cfg_special_activity_goalsManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_special_activity_goals> 遍历方法
function cfg_special_activity_goalsManager:ForPair(action)
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
function cfg_special_activity_goalsManager:PostProcess()
end

return cfg_special_activity_goalsManager