---@class cfg_sbk_donate_rewardManager:TableManager
local cfg_sbk_donate_rewardManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_sbk_donate_reward
function cfg_sbk_donate_rewardManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_sbk_donate_reward> 遍历方法
function cfg_sbk_donate_rewardManager:ForPair(action)
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
function cfg_sbk_donate_rewardManager:PostProcess()
end

return cfg_sbk_donate_rewardManager