---@class BetterItemHintItemList_PlayerNormalEquip:BetterItemHintItemList_Base 主角正常装备推送列表
local BetterItemHintItemList_PlayerNormalEquip = {}

setmetatable(BetterItemHintItemList_PlayerNormalEquip,luaclass.BetterItemHintItemList_Base)

--region 必须重写
---获取物品类型
---@protected
---@return LuaEnumMainHint_BetterBagItemType
function BetterItemHintItemList_PlayerNormalEquip:GetItemType()
    return LuaEnumMainHint_BetterBagItemType.BetterEquip
end

---是否是推荐物品(会在触发刷新的时候调用，用于筛选更好物品列表)必须重写
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@param hintReason LuaEnumBetterItemHintReason
---@return boolean
function BetterItemHintItemList_PlayerNormalEquip:IsHintItem(bagItemInfo,hintReason)
    return false
end

---获取新建推送物品类(会在触发刷新的时候调用，用于筛选更好物品列表)必须重写
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@return BetterItemHintItem_Base
function BetterItemHintItemList_PlayerNormalEquip:NewHintItemClass(bagItemInfo)

end

---是否是需要刷新的物品
---@protected
---@param bagItemInfo bagV2.BagItemInfo 物品信息类
---@return boolean 是否是需要刷新的对应的物品
function BetterItemHintItemList_PlayerNormalEquip:NeedRefreshItem(bagItemInfo)
    if bagItemInfo ~= nil then
        return gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():IsPlayerEquip(bagItemInfo.ItemTABLE)
    end
    return false
end

---是否需要刷新对象列表
---@protected
---@param hintReason LuaEnumBetterItemHintReason
---@return boolean
function BetterItemHintItemList_PlayerNormalEquip:IsNeedRefreshBetterListByReason(hintReason)
    return hintReason == LuaEnumBetterItemHintReason.GameStart or hintReason == LuaEnumBetterItemHintReason.LevelUp or
            hintReason == LuaEnumBetterItemHintReason.ReinLevelUp
end
--endregion
return BetterItemHintItemList_PlayerNormalEquip