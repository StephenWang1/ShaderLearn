---@class cfg_system_previewManager:TableManager
local cfg_system_previewManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_system_preview
function cfg_system_previewManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_system_preview> 遍历方法
function cfg_system_previewManager:ForPair(action)
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
function cfg_system_previewManager:PostProcess()
end

return cfg_system_previewManager