---@class cfg_wayget_fastauctionManager:TableManager
local cfg_wayget_fastauctionManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_wayget_fastauction
function cfg_wayget_fastauctionManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_wayget_fastauction> 遍历方法
function cfg_wayget_fastauctionManager:ForPair(action)
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
function cfg_wayget_fastauctionManager:PostProcess()
end

return cfg_wayget_fastauctionManager