---@class cfg_official_emperor_tokenManager:TableManager
local cfg_official_emperor_tokenManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_official_emperor_token
function cfg_official_emperor_tokenManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_official_emperor_token> 遍历方法
function cfg_official_emperor_tokenManager:ForPair(action)
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
function cfg_official_emperor_tokenManager:PostProcess()
    if self.ItemIdToTokenId == nil then
        self.ItemIdToTokenId = {}
    end
    ---@param i number
    ---@param v TABLE.cfg_official_emperor_token
    self:ForPair(function(i, v)
        self.ItemIdToTokenId[v:GetLinkItemId()] = i
    end)
end

---@return number itemId对应的虎符id
function cfg_official_emperor_tokenManager:GetTokenIdByItemId(itemId)
    if self.ItemIdToTokenId then
        return self.ItemIdToTokenId[itemId]
    end
    return 0
end

return cfg_official_emperor_tokenManager