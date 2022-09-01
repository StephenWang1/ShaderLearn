---@class cfg_titleManager:TableManager
local cfg_titleManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_title
function cfg_titleManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_title> 遍历方法
function cfg_titleManager:ForPair(action)
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
function cfg_titleManager:PostProcess()
end

return cfg_titleManager