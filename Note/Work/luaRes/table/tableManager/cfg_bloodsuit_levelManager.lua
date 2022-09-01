---@class cfg_bloodsuit_levelManager:TableManager
local cfg_bloodsuit_levelManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_bloodsuit_level
function cfg_bloodsuit_levelManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_bloodsuit_level> 遍历方法
function cfg_bloodsuit_levelManager:ForPair(action)
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
function cfg_bloodsuit_levelManager:PostProcess()
end

return cfg_bloodsuit_levelManager