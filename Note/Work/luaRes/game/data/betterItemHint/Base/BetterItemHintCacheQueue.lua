---@class BetterItemHintCacheQueue:luaobject 推送缓存队列
local BetterItemHintCacheQueue = {}

--region 数据
---@type table<LuaEnumMainHint_BetterBagItemType,number> 提示缓存表
BetterItemHintCacheQueue.HintCacheQueueTable = nil
--endregion

--region 数据处理
---添加提示到缓存队列
---@param betterItemType LuaEnumMainHint_BetterBagItemType
---@param itemId number
function BetterItemHintCacheQueue:AddHintCacheQueue(betterItemType,itemId)
    self:TryInitHintCacheQueueTable()
    self.HintCacheQueueTable[betterItemType] = itemId
end

---移除指定的缓存
---@param betterItemType LuaEnumMainHint_BetterBagItemType
function BetterItemHintCacheQueue:RemoveHintCacheQueue(betterItemType)
    self:TryInitHintCacheQueueTable()
    self.HintCacheQueueTable[betterItemType] = nil
end

---尝试初始化提示缓存队列
function BetterItemHintCacheQueue:TryInitHintCacheQueueTable()
    if self.HintCacheQueueTable == nil then
        self.HintCacheQueueTable = {}
    end
end
--endregion

--region 获取
---获取优先级最高的提示类型
---@return LuaEnumMainHint_BetterBagItemType,number
function BetterItemHintCacheQueue:GetHighOrderHint()
    if self.HintCacheQueueTable == nil then
        return
    end
    local hintType,itemId
    for k,v in pairs(self.HintCacheQueueTable) do
        if hintType == nil or k > hintType then
            hintType = k
            itemId = v
        end
    end
    self:RemoveHintCacheQueue(hintType)
    return hintType,itemId
end
--endregion

--region 查询
---检查主角是否拥有指定道具
---@param itemId number 道具id
---@return boolean 身上是否有
function BetterItemHintCacheQueue:CheckMainPlayerHaveItem(itemId)
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    local servantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2
    if mainPlayerInfo == nil then
        return false
    end
    local count = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemListByItemId(itemId)
    if count > 0 then
        return true
    end
    ---灵兽合成特殊处理（张一博）
end
--endregion

return BetterItemHintCacheQueue