---@class cfg_appearanceManager:TableManager
local cfg_appearanceManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_appearance
function cfg_appearanceManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_appearance> 遍历方法
function cfg_appearanceManager:ForPair(action)
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
function cfg_appearanceManager:PostProcess()
end

---通过ItemId获取时装外观表
---@param itemId number 道具id
---@return TABLE.cfg_appearance
function cfg_appearanceManager:GetAppearanceTblByItemId(itemId)
    if type(itemId) ~= 'number' then
        return
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil or itemTbl:GetAppearanceId() <= 0 then
        return
    end
    local appearanceTbl = self:TryGetValue(itemTbl:GetAppearanceId())
    return appearanceTbl
end

return cfg_appearanceManager