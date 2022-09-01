---@class BetterItemHintItemList_BloodEquip:BetterItemHintItemList_Base 血继推送物品列表
local BetterItemHintItemList_BloodEquip = {}

setmetatable(BetterItemHintItemList_BloodEquip,luaclass.BetterItemHintItemList_Base)

--region 必须重写
---获取物品类型
---@protected
---@return LuaEnumMainHint_BetterBagItemType
function BetterItemHintItemList_BloodEquip:GetItemType()
    return LuaEnumMainHint_BetterBagItemType.BetterBloodEquip
end

---是否是推荐物品(会在触发刷新的时候调用，用于筛选更好物品列表)必须重写
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@param hintReason LuaEnumBetterItemHintReason
---@return boolean
function BetterItemHintItemList_BloodEquip:IsHintItem(bagItemInfo,hintReason)
    return gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr():IsBetterBloodSuitEquipData(bagItemInfo.itemId)
end

---获取新建推送物品类(会在触发刷新的时候调用，用于筛选更好物品列表)必须重写
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@return BetterItemHintItem_Base
function BetterItemHintItemList_BloodEquip:NewHintItemClass(bagItemInfo)
    local betterBloodEquipClass = luaclass.BetterItemHintItem_BloodEquip:New()
    betterBloodEquipClass:RefreshData(bagItemInfo)
    return betterBloodEquipClass
end

---是否是需要刷新的物品
---@protected
---@param bagItemInfo bagV2.BagItemInfo 物品信息类
---@return boolean 是否是需要刷新的对应的物品
function BetterItemHintItemList_BloodEquip:NeedRefreshItem(bagItemInfo)
    if bagItemInfo ~= nil then
        return clientTableManager.cfg_itemsManager:IsBloodSuitEquip(bagItemInfo.itemId)
    end
end

---是否需要刷新对象列表
---@protected
---@param hintReason LuaEnumBetterItemHintReason
---@return boolean
function BetterItemHintItemList_BloodEquip:IsNeedRefreshBetterListByReason(hintReason)
    return hintReason == LuaEnumBetterItemHintReason.GameStart
end
--endregion

--region 支持重写
---更好物品列表中是否有同样类型的道具
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean,BetterItemHintItem_Base 缓存中是否包含，同类型物品
function BetterItemHintItemList_BloodEquip:BetterItemListHaveSameTypeItem(bagItemInfo)
    return false
end
--endregion
return BetterItemHintItemList_BloodEquip