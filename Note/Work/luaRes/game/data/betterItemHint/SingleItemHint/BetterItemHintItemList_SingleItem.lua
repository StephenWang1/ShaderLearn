---@class BetterItemHintItemList_SingleItem:BetterItemHintItemList_Base 单个物品推送表
local BetterItemHintItemList_SingleItem = {}

setmetatable(BetterItemHintItemList_SingleItem,luaclass.BetterItemHintItemList_Base)

--region 数据
---推送单个物品配置表
---@type table<number,table>
BetterItemHintItemList_SingleItem.PushItemConfigTable = nil
--endregion

--region 初始化
function BetterItemHintItemList_SingleItem:Init()
    self:RunBaseFunction("Init")
    self:InitPushItemConfigTable()
end

---初始化推送单个物品配置表
function BetterItemHintItemList_SingleItem:InitPushItemConfigTable()
    if self.PushItemConfigTable == nil then
        local singleItemHintConfigTable = LuaGlobalTableDeal:GetSingleItemHintConfigTable()
        if singleItemHintConfigTable ~= nil and type(singleItemHintConfigTable) == 'table' and Utility.GetLuaTableCount(singleItemHintConfigTable) > 0 then
            self.PushItemConfigTable = {}
            for k,v in pairs(singleItemHintConfigTable) do
                if v ~= nil and type(v) == 'table' and v.itemId ~= nil then
                    self.PushItemConfigTable[v.itemId] = v
                end
            end
        end
    end
end
--endregion

--region 必须重写
---获取物品类型
---@protected
---@return LuaEnumMainHint_BetterBagItemType
function BetterItemHintItemList_SingleItem:GetItemType()
    return LuaEnumMainHint_BetterBagItemType.SingleItemHint
end

---是否是推荐物品(会在触发刷新的时候调用，用于筛选更好物品列表)必须重写
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@param hintReason LuaEnumBetterItemHintReason
---@return boolean
function BetterItemHintItemList_SingleItem:IsHintItem(bagItemInfo,hintReason)
    return self:GetItemConfigTable(bagItemInfo.itemId) ~= nil and CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(self:GetItemConfigTable(bagItemInfo.itemId).pushConditionIdTable) == true
end

---获取新建推送物品类(会在触发刷新的时候调用，用于筛选更好物品列表)必须重写
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@return BetterItemHintItem_Base
function BetterItemHintItemList_SingleItem:NewHintItemClass(bagItemInfo)
    local betterSingleItemClass = luaclass.BetterItemHintItem_SingleItem:New()
    betterSingleItemClass:RefreshData(bagItemInfo,self:GetItemConfigTable(bagItemInfo.itemId))
    return betterSingleItemClass
end

---是否是需要刷新的物品
---@protected
---@param bagItemInfo bagV2.BagItemInfo 物品信息类
---@return boolean 是否是需要刷新的对应的物品
function BetterItemHintItemList_SingleItem:NeedRefreshItem(bagItemInfo)
    if bagItemInfo ~= nil and self.PushItemConfigTable ~= nil then
        return self.PushItemConfigTable[bagItemInfo.itemId] ~= nil
    end
    return false
end

---是否需要刷新对象列表
---@protected
---@param hintReason LuaEnumBetterItemHintReason
---@return boolean
function BetterItemHintItemList_SingleItem:IsNeedRefreshBetterListByReason(hintReason)
    return true
end
--endregion

--region 查询
---通过触发推送原因判断是否有可以推送的物品
---@param reason LuaEnumBetterItemHintReason 触发原因
---@return boolean 是否有可以推送的物品
function BetterItemHintItemList_SingleItem:HaveCanPushItemByReason(reason)
    if self.BetterItemList ~= nil and type(self.BetterItemList) == 'table' and Utility.GetLuaTableCount(self.BetterItemList) > 0 then
        for k,v in pairs(self.BetterItemList) do
            ---@type BetterItemHintItem_SingleItem
            local singleBetterItemClass = v
            if singleBetterItemClass ~= nil and singleBetterItemClass:CheckItemCanPushByReason(reason) == true then
                return true
            end
        end
    end
    return false
end
--endregion

--region 获取
---获取物品配置数据
---@param itemId number 物品id
---@return table 策划配置数据
function BetterItemHintItemList_SingleItem:GetItemConfigTable(itemId)
    if self.PushItemConfigTable == nil then
        return
    end
    return self.PushItemConfigTable[itemId]
end

---获取列表中第一个物品类
---@return BetterItemHintItem_Base 物品类
function BetterItemHintItemList_SingleItem:GetFirstItemClass()
end

---通过来源获取物品类
---@param hintReason LuaEnumBetterItemHintReason
---@return BetterItemHintItem_Base 物品类
function BetterItemHintItemList_SingleItem:GetItemClassByReason(hintReason)
    if hintReason == nil or self.BetterItemList == nil or Utility.GetLuaTableCount(self.BetterItemList) <= 0 then
        return
    end
    for k,v in pairs(self.BetterItemList) do
        ---@type BetterItemHintItem_SingleItem
        local itemClass = v
        if itemClass ~= nil and itemClass:CheckItemCanPushByReason(hintReason) then
            return itemClass
        end
    end
end
--endregion

--region 支持重写
---更好物品列表中是否有同样类型的道具
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean,BetterItemHintItem_Base 缓存中是否包含，同类型物品
function BetterItemHintItemList_SingleItem:BetterItemListHaveSameTypeItem(bagItemInfo)
    return false
end
--endregion

return BetterItemHintItemList_SingleItem