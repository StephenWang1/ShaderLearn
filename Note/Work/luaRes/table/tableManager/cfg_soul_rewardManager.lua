---@class cfg_soul_rewardManager:TableManager
local cfg_soul_rewardManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_soul_reward
function cfg_soul_rewardManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_soul_reward> 遍历方法
function cfg_soul_rewardManager:ForPair(action)
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
function cfg_soul_rewardManager:PostProcess()
end

return cfg_soul_rewardManager