---@class BetterItemHintItemList_SoulEquip:BetterItemHintItemList_Base
local BetterItemHintItemList_SoulEquip = {};

setmetatable(BetterItemHintItemList_SoulEquip,luaclass.BetterItemHintItemList_Base)

--region 必须重写
---获取物品类型
---@protected
---@return LuaEnumMainHint_BetterBagItemType
function BetterItemHintItemList_SoulEquip:GetItemType()
    return LuaEnumMainHint_BetterBagItemType.SoulEquip
end

---是否是推荐物品(会在触发刷新的时候调用，用于筛选更好物品列表)必须重写
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@param hintReason LuaEnumBetterItemHintReason
---@return boolean
function BetterItemHintItemList_SoulEquip:IsHintItem(bagItemInfo,hintReason)
    ---更好物品列表中缓存的更好装备
    local cacheSameTypeBagItemInfo = self:GetSameTypeItem(bagItemInfo)
    local isBetterBagItemInfo = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():IsBetterSoulEquipData(bagItemInfo.itemId)
    if isBetterBagItemInfo == true and cacheSameTypeBagItemInfo ~= nil and cacheSameTypeBagItemInfo.BagItemInfo ~= nil then
        local compareInlayEquip = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():CompareInlayEquip(bagItemInfo.itemId,cacheSameTypeBagItemInfo.BagItemInfo.itemId)
        if compareInlayEquip == 1 then
            self:BetterListRemoveCurItem(cacheSameTypeBagItemInfo)
            return true
        else
            return false
        end
    end
    return isBetterBagItemInfo
end

---获取新建推送物品类(会在触发刷新的时候调用，用于筛选更好物品列表)必须重写
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@return BetterItemHintItem_Base
function BetterItemHintItemList_SoulEquip:NewHintItemClass(bagItemInfo)
    local betterSoulEquipClass = luaclass.BetterItemHintItem_SoulEquip:New()
    betterSoulEquipClass:RefreshData(bagItemInfo)
    return betterSoulEquipClass;
end

---是否是需要刷新的物品
---@protected
---@param bagItemInfo bagV2.BagItemInfo 物品信息类
---@return boolean 是否是需要刷新的对应的物品
function BetterItemHintItemList_SoulEquip:NeedRefreshItem(bagItemInfo)
    if bagItemInfo ~= nil then
        local tbl = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId);
        if(tbl ~= nil) then
            return gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():IsInlayEquip(tbl);
        end
    end
    return false;
end

---是否需要刷新对象列表
---@protected
---@param hintReason LuaEnumBetterItemHintReason
---@return boolean
function BetterItemHintItemList_SoulEquip:IsNeedRefreshBetterListByReason(hintReason)
    return hintReason == LuaEnumBetterItemHintReason.GameStart
end

---获取列表中第一个物品类
---@return BetterItemHintItem_Base 物品类
function BetterItemHintItemList_SoulEquip:GetFirstItemClass()
    return self:GetPushItem()
end
--endregion

--region 获取
---获取同类型装备
---@param bagItemInfo bagV2.BagItemInfo
---@return BetterItemHintItem_SoulEquip 同类型的物品
function BetterItemHintItemList_SoulEquip:GetSameTypeItem(bagItemInfo)
    if type(self.BetterItemList) ~= 'table' or bagItemInfo == nil then
        return
    end
    local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    if itemInfo == nil then
        return
    end
    for k,v in pairs(self.BetterItemList) do
        ---@type BetterItemHintItem_SoulEquip
        local curItemClass = v
        if curItemClass ~= nil and curItemClass.ItemInfo ~= nil and curItemClass.ItemInfo:GetSuitBelong() == itemInfo:GetSuitBelong() then
            return curItemClass
        end
    end
end

---获取推送的物品
---@return bagV2.BagItemInfo
function BetterItemHintItemList_SoulEquip:GetPushItem()
    if type(self.BetterItemList) ~= 'table' then
        return
    end
    ---@type BetterItemHintItem_SoulEquip
    local pushItem = nil
    for k,v in pairs(self.BetterItemList) do
        ---@type BetterItemHintItem_SoulEquip
        local curItemClass = v
        if curItemClass ~= nil and curItemClass.BagItemInfo ~= nil and curItemClass.ItemInfo ~= nil then
            if curItemClass.ItemInfo ~= nil and (pushItem == nil or (pushItem.ItemInfo ~= nil and curItemClass.ItemInfo:GetSuitBelong() > pushItem.ItemInfo:GetSuitBelong())) then
                pushItem = curItemClass
            end
        end
    end
    return pushItem
end
--endregion

--region 支持重写
---更好物品列表中是否有同样类型的道具
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean,BetterItemHintItem_Base 缓存中是否包含，同类型物品
function BetterItemHintItemList_SoulEquip:BetterItemListHaveSameTypeItem(bagItemInfo)
    return false
end
--endregion

return BetterItemHintItemList_SoulEquip;