---@class cfg_ancient_bossManager:TableManager
local cfg_ancient_bossManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_ancient_boss
function cfg_ancient_bossManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_ancient_boss> 遍历方法
function cfg_ancient_bossManager:ForPair(action)
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
function cfg_ancient_bossManager:PostProcess()
end

return cfg_ancient_bossManager