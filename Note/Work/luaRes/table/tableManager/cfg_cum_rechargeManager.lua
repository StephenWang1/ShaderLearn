---@class cfg_cum_rechargeManager:TableManager
local cfg_cum_rechargeManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_cum_recharge
function cfg_cum_rechargeManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_cum_recharge> 遍历方法
function cfg_cum_rechargeManager:ForPair(action)
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
function cfg_cum_rechargeManager:PostProcess()
end

---获取奖励信息，支持宝箱和单个配置物品
---@return table<number,bagV2.CoinInfo>
function cfg_cum_rechargeManager:GetReward(id)
    local rewardTbl = {}
    ---@type TABLE.cfg_cum_recharge
    local info = self:TryGetValue(id)
    if info then

        if info:GetBoxId() and info:GetBoxId().list and #info:GetBoxId().list > 0 then

            local boxId
            local boxRewardList

            for i = 1, #info:GetBoxId().list do
                ---奇为item数量
                if i % 2 ~= 0 then
                    boxId = info:GetBoxId().list[i]
                    boxRewardList = CS.Cfg_BoxTableManager.Instance:GetBoxRewardList(boxId)
                    if boxRewardList ~= nil and boxRewardList.Count > 0 then
                        for j = 0, boxRewardList.Count - 1 do
                            table.insert(rewardTbl,
                                    {
                                        itemId = boxRewardList[j].itemId,
                                        count = boxRewardList[j].count
                                    })
                        end
                    end
                end
            end
        end

        if info:GetReward() ~= nil and info:GetReward().list ~= nil and #info:GetReward().list > 0 then
            local awardList = info:GetReward().list
            local itemId = 0
            local num = 0
            for i = 1, #awardList do
                if #awardList[i].list > 1 then
                    itemId = awardList[i].list[1]
                    num = awardList[i].list[2]
                    table.insert(rewardTbl, {
                        itemId = itemId,
                        count = num
                    })
                end
            end
        end

    end
    return rewardTbl
end

return cfg_cum_rechargeManager