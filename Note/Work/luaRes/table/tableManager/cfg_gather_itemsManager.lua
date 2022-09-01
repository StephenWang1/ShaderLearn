---@class cfg_gather_itemsManager:TableManager
local cfg_gather_itemsManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_gather_items
function cfg_gather_itemsManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_gather_items> 遍历方法
function cfg_gather_itemsManager:ForPair(action)
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
function cfg_gather_itemsManager:PostProcess()
end

return cfg_gather_itemsManager