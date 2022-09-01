---@class cfg_special_activityManager:TableManager
local cfg_special_activityManager = {}

cfg_special_activityManager.GroupData = nil

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_special_activity
function cfg_special_activityManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_special_activity> 遍历方法
function cfg_special_activityManager:ForPair(action)
    if action == nil then
        return
    end
    if self.dic then
        for i, v in pairs(self.dic) do
            action(i, v)
        end
    end
end

---@class CurrentActivityBookMarkType
---@field mBookMarkName string 页签名字
---@field mOrder number 页签排序
---@field mAllId table<number,number> 页签对应的所有活动id
---@field mClientType number 页签id对应current表里的clientType
---@field mOpenPanel string 页签需要打开的界面

---表格解析完毕后调用此方法
function cfg_special_activityManager:PostProcess()
    --[[    if self.GroupData == nil then
            self.GroupData = {}
            self:ForPair(function(k, v)
                ---@type TABLE.cfg_special_activity
                local groupData = v
                local group = groupData:GetDescription()
                if group then
                    local groupSaveData = self.GroupData[group]
                    if groupData == nil then
                        groupData = {}
                        self.GroupData[group] = groupData
                    end

                    local bookMarkType = v.clientType
                    ---@type CurrentActivityBookMarkType
                    local bookMarkData = groupData[bookMarkType]
                    if bookMarkData == nil then
                        bookMarkData = {}
                        bookMarkData.mBookMarkName = v.name
                        bookMarkData.mOrder = v.order
                    bookMarkData.mAllId = {}
                        bookMarkData.mClientType = v.clientType
                        bookMarkData.mOpenPanel = v.panel
                    groupData[bookMarkType] = bookMarkData
                    end
                    table.insert(bookMarkData.mAllId, k)
                end
            end)
        end]]
end

---@return table<number,CurrentActivityBookMarkType> 每一个组对应的数据，里面是页签的table
function cfg_special_activityManager:GetGroupData(group)
    if group and self.GroupData then
        return self.GroupData[group]
    end
end

---获取奖励信息，支持宝箱和单个配置物品
---@return table<number,bagV2.CoinInfo>
function cfg_special_activityManager:GetReward(id)
    local rewardTbl = {}
    ---@type TABLE.cfg_special_activity
    local info = self:TryGetValue(id)
    if info and info:GetAward() ~= nil and info:GetAward().list ~= nil and #info:GetAward().list > 0 then
        local awardList = info:GetAward().list
        local csRwardList = nil
        local itemId = 0
        local num = 0
        local itemTbl = nil
        ---奇为item偶数量
        for i = 1, #awardList do
            if i % 2 ~= 0 then
                itemId = awardList[i]
                itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
                num = i + 1 >= #awardList and awardList[i + 1] or 0
                if itemTbl and num ~= 0 then
                    if itemTbl:GetType() == luaEnumItemType.TreasureBox then
                        ---获取宝箱内物品列表
                        ---@type <number,bagV2.CoinInfo>
                        csRwardList = CS.Cfg_BoxTableManager.Instance:GetBoxRewardList(itemId)
                        if csRwardList ~= nil and csRwardList.Count > 0 then
                            for j = 0, csRwardList.Count - 1 do
                                table.insert(rewardTbl,
                                        {
                                            itemId = csRwardList[j].itemId,
                                            count = csRwardList[j].count
                                        })
                            end
                        end
                    else
                        table.insert(rewardTbl, {
                            itemId = itemId,
                            count = num
                        })
                    end

                end
            end
        end
    end
    return rewardTbl
end

return cfg_special_activityManager