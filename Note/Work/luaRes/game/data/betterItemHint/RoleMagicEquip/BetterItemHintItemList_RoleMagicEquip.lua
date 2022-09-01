---@class BetterItemHintItemList_RoleMagicEquip:BetterItemHintItemList_Base 人物法宝装备推送列表
local BetterItemHintItemList_RoleMagicEquip = {}

setmetatable(BetterItemHintItemList_RoleMagicEquip,luaclass.BetterItemHintItemList_Base)

--region 必须重写
---获取物品类型
---@protected
---@return LuaEnumMainHint_BetterBagItemType
function BetterItemHintItemList_RoleMagicEquip:GetItemType()
    return LuaEnumMainHint_BetterBagItemType.RoleMagicEquip
end

---是否是推荐物品(会在触发刷新的时候调用，用于筛选更好物品列表)必须重写
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@param hintReason LuaEnumBetterItemHintReason
---@return boolean
function BetterItemHintItemList_RoleMagicEquip:IsHintItem(bagItemInfo,hintReason)
    return gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():CheckMagicEquipBetterThanBody(bagItemInfo)
end

---获取新建推送物品类(会在触发刷新的时候调用，用于筛选更好物品列表)必须重写
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@return BetterItemHintItem_Base
function BetterItemHintItemList_RoleMagicEquip:NewHintItemClass(bagItemInfo)
    local betterBloodEquipClass = luaclass.BetterItemHintItem_RoleMagicEquip:New()
    betterBloodEquipClass:RefreshData(bagItemInfo)
    return betterBloodEquipClass
end

---是否是需要刷新的物品
---@protected
---@param bagItemInfo bagV2.BagItemInfo 物品信息类
---@return boolean 是否是需要刷新的对应的物品
function BetterItemHintItemList_RoleMagicEquip:NeedRefreshItem(bagItemInfo)
    if bagItemInfo ~= nil then
        return clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(bagItemInfo.itemId) == LuaEnumUseItemParam.CanUse and clientTableManager.cfg_itemsManager:IsMagicEquip(bagItemInfo.itemId)
    end
end

---是否需要刷新对象列表
---@protected
---@param hintReason LuaEnumBetterItemHintReason
---@return boolean
function BetterItemHintItemList_RoleMagicEquip:IsNeedRefreshBetterListByReason(hintReason)
    return hintReason == LuaEnumBetterItemHintReason.GameStart
end
--endregion

return BetterItemHintItemList_RoleMagicEquip