---@class cfg_way_getManager:TableManager
local cfg_way_getManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_way_get
function cfg_way_getManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_way_get> 遍历方法
function cfg_way_getManager:ForPair(action)
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
function cfg_way_getManager:PostProcess()
end

return cfg_way_getManager