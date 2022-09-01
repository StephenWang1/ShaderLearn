---@class cfg_official_positionManager:TableManager
local cfg_official_positionManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_official_position
function cfg_official_positionManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_official_position> 遍历方法
function cfg_official_positionManager:ForPair(action)
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
function cfg_official_positionManager:PostProcess()
end

return cfg_official_positionManager