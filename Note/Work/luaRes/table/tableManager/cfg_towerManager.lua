---@class cfg_towerManager:TableManager
local cfg_towerManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_tower
function cfg_towerManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_tower> 遍历方法
function cfg_towerManager:ForPair(action)
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
function cfg_towerManager:PostProcess()
end

---得到更好的奖品列表
---@return table<number,cfg_towerManager_RewardData>
function cfg_towerManager:GetBestRewardList()
    ---@type table<number,cfg_towerManager_RewardData>
    self.mBestRewardList = {}
    for i, v in pairs(self.dic) do
        ---@type TABLE.cfg_tower
        local temp = v
        if temp ~= nil and temp:GetBestReward() ~= nil then
            for i, v in pairs(temp:GetBestReward().list) do
                local mcareer = v.list[1]
                local mitemID = v.list[2]
                local mitemCount = v.list[3]
                local mlayer = temp:GetStorey()
                local mItemTabel = clientTableManager.cfg_itemsManager:TryGetValue(tonumber(mitemID))
                ---@class cfg_towerManager_RewardData
                local RewardData = {
                    ---道具ID
                    itemID = mitemID,
                    ---道具数量
                    itemCount = mitemCount,
                    ---所在层数
                    layer = mlayer,
                    ---@type TABLE.cfg_items 道具Table
                    ItemTabel = mItemTabel,
                }
                if Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career) == tonumber(mcareer) or tonumber(mcareer) == 0 then
                    table.insert(self.mBestRewardList, RewardData)
                end

            end
        end
    end
    return self.mBestRewardList
end

return cfg_towerManager