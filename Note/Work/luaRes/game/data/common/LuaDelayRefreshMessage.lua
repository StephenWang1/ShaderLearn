--- DateTime: 2021/04/12 15:19
--- Description 规定时间内收到多条变动原因相同的消息时，只执行最开始的一次

---@class LuaDelayRefreshMessage:luaobject 延迟时间刷新消息
local LuaDelayRefreshMessage = {}

---@class DelayRefreshMessageItem 延迟时间刷新消息Item
---@field hashID number 唯一值，确保同一个消息的变动原因只会刷新一遍
---@field listUpdateItem ListUpdateItem 延迟对象
---@field itemList table<bagV2.BagItemInfo> 变动列表
---@field itemId number 道具表的ItemId


--region parameters
---@type DelayRefreshMessageItem[]
LuaDelayRefreshMessage.delayRefresh = {}
--endregion

--region public methods
---创建延迟元素
function LuaDelayRefreshMessage:Creat(delayFrame, CallBack, isLoop, ...)
    local tbl = { ... }
    local itemList = #tbl > 0 and tbl[1] or nil
    local itemId = #tbl > 1 and tbl[2] or nil
    ---相同的变动原因直接return
    if self:CheckReasonForChangeIsConsistent(itemList, itemId) then
        return
    end
    ---@type DelayRefreshMessageItem
    local listUpdateItem = {}
    listUpdateItem.itemList = itemList
    listUpdateItem.itemId = itemId
    listUpdateItem.hashID = os.time()
    listUpdateItem.listUpdateItem = CS.CSListUpdateMgr.Add(delayFrame, listUpdateItem.hashID, function(Item)
        local index = self:GetIndexOfDelayedMessageList(Item)
        if (index > 0) then
            CS.CSListUpdateMgr.Instance:Remove(self:GetDelayItem(index))
            self:Remove(index)
            if (CallBack ~= nil) then
                CallBack(itemList, itemId, #tbl > 2 and tbl[3] or false)
            end
        end
    end, isLoop)
    self:Add(listUpdateItem)
end

---获取延迟元素数量
function LuaDelayRefreshMessage:GetDelayCount()
    if (self.delayRefresh ~= nil) then
        return #self.delayRefresh
    end
    return 0
end
--endregion

--region private methods
---添加延迟元素
function LuaDelayRefreshMessage:Add(item)
    table.insert(self.delayRefresh, item)
end

---删除对应位置的延迟元素
function LuaDelayRefreshMessage:Remove(pos)
    if (self.delayRefresh ~= nil and pos <= #self.delayRefresh) then
        table.remove(self.delayRefresh, pos)
    end
end

---根据位置获取延迟元素
function LuaDelayRefreshMessage:GetDelayItem(pos)
    if (self.delayRefresh ~= nil and pos <= #self.delayRefresh) then
        return self.delayRefresh[pos]
    end
    return nil
end

---检查与已有的物品变动信息是否一致
---@param itemList table<bagV2.BagItemInfo> lua table类型消息数据
---@return boolean 变动原因是否一致
function LuaDelayRefreshMessage:CheckReasonForChangeIsConsistent(itemList, itemId)
    if (self.delayRefresh == nil or #self.delayRefresh < 1) then
        return false
    end
    for i = 1, #self.delayRefresh do
        ---@type DelayRefreshMessageItem
        local delayRefreshMessage = self.delayRefresh[i]
        if (delayRefreshMessage ~= nil) then
            ---都不是由于物品变动，只需要刷新一次
            if (delayRefreshMessage.itemList == nil and itemList == nil and delayRefreshMessage.itemId == itemId) then
                return true
            elseif (delayRefreshMessage.itemList ~= nil and itemList ~= nil and #delayRefreshMessage.itemList == #itemList) then
                ---都是物品变动，但是物品一样，只需要刷新一次
                if (delayRefreshMessage.itemId ~= itemId) then
                    return false
                end
                for j = 1, #itemList do
                    if (delayRefreshMessage.itemList[j].ItemTABLE ~= itemList[j].ItemTABLE) then
                        return false
                    end
                end
                return true
            end
        end
    end
    return false
end

---根据Hash值获取延迟更新消息的下标
---@param item object Hash唯一值
---@return number 消息下标
function LuaDelayRefreshMessage:GetIndexOfDelayedMessageList(item)
    if (self.delayRefresh == nil or #self.delayRefresh < 1 or item == nil) then
        return 0
    end
    for i = 1, #self.delayRefresh do
        ---@type DelayRefreshMessageItem
        local delayRefreshMessage = self.delayRefresh[i]
        if (delayRefreshMessage ~= nil and delayRefreshMessage.hashID == item) then
            return i
        end
    end
    return 0
end
--endregion

--region destroy
function LuaDelayRefreshMessage:OnDestroy()
    if type(self.delayRefresh) == 'table' then
        for k,v in pairs(self.delayRefresh)do
            self:Remove(k)
        end
    end
end
--endregion

return LuaDelayRefreshMessage