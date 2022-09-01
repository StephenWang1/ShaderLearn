---@class BetterItemHintItemList_Appearance:BetterItemHintItemList_Base 人物时装推送
local BetterItemHintItemList_Appearance = {}

setmetatable(BetterItemHintItemList_Appearance,luaclass.BetterItemHintItemList_Base)

--region 必须重写
---获取物品类型
---@protected
---@return LuaEnumMainHint_BetterBagItemType
function BetterItemHintItemList_Appearance:GetItemType()
    return LuaEnumMainHint_BetterBagItemType.Appearance
end

---是否是推荐物品(会在触发刷新的时候调用，用于筛选更好物品列表)必须重写
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@param hintReason LuaEnumBetterItemHintReason
---@return boolean
function BetterItemHintItemList_Appearance:IsHintItem(bagItemInfo,hintReason)
    if CS.CSScene.Sington.MainPlayer == nil then
        return false
    end
    local CSBagItemInfo = bagItemInfo
    if type(bagItemInfo) == 'table' then
        CSBagItemInfo = protobufMgr.DecodeTable.bag.BagItemInfo(bagItemInfo)
    end
    if CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData:IsFashionEnabled(CSBagItemInfo) then
        return false
    end
    return self:NeedRefreshItem(bagItemInfo)
end

---获取新建推送物品类(会在触发刷新的时候调用，用于筛选更好物品列表)必须重写
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@return BetterItemHintItem_Base
function BetterItemHintItemList_Appearance:NewHintItemClass(bagItemInfo)
    local betterBloodEquipClass = luaclass.BetterItemHintItem_Appearance:New()
    betterBloodEquipClass:RefreshData(bagItemInfo)
    return betterBloodEquipClass
end

---是否是需要刷新的物品
---@protected
---@param bagItemInfo bagV2.BagItemInfo 物品信息类
---@return boolean 是否是需要刷新的对应的物品
function BetterItemHintItemList_Appearance:NeedRefreshItem(bagItemInfo)
    if bagItemInfo ~= nil then
        return clientTableManager.cfg_itemsManager:IsAppearance(bagItemInfo.itemId) and clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(bagItemInfo.itemId) == LuaEnumUseItemParam.CanUse
    end
end

---是否需要刷新对象列表
---@protected
---@param hintReason LuaEnumBetterItemHintReason
---@return boolean
function BetterItemHintItemList_Appearance:IsNeedRefreshBetterListByReason(hintReason)
    return hintReason == LuaEnumBetterItemHintReason.GameStart
end
--endregion

return BetterItemHintItemList_Appearance