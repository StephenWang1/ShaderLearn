---@class cfg_reincarnationManager:TableManager
local cfg_reincarnationManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_reincarnation
function cfg_reincarnationManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_reincarnation> 遍历方法
function cfg_reincarnationManager:ForPair(action)
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
function cfg_reincarnationManager:PostProcess()
end

return cfg_reincarnationManager