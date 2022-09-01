---@class cfg_collectionManager:TableManager
local cfg_collectionManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_collection
function cfg_collectionManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_collection> 遍历方法
function cfg_collectionManager:ForPair(action)
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
function cfg_collectionManager:PostProcess()
end

---获取藏品类型对应的字符串
---@param collectionType number
---@return string
function cfg_collectionManager:GetCollectionTypeStr(collectionType)
    if collectionType == 1 then
        return "青铜器"
    elseif collectionType == 2 then
        return "陶器"
    elseif collectionType == 3 then
        return "瓷器"
    elseif collectionType == 4 then
        return "玉器"
    elseif collectionType == 5 then
        return "金银器"
    elseif collectionType == 6 then
        return "法器"
    end
end

return cfg_collectionManager