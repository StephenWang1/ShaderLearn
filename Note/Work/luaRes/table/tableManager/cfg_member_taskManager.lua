---@class cfg_member_taskManager:TableManager
local cfg_member_taskManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_member_task
function cfg_member_taskManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_member_task> 遍历方法
function cfg_member_taskManager:ForPair(action)
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
function cfg_member_taskManager:PostProcess()
end

return cfg_member_taskManager