---@type Utility
local Utility = Utility

---灵兽装备对比
---@param leftBagItemInfo bagV2.BagItemInfo
---@param rightBagItemInfo bagV2.BagItemInfo
---@return number 1(left > right) 0(left == right) -1(left < right) -2(出错)
function Utility.CompareServantEquip(leftBagItemInfo,rightBagItemInfo)
    if leftBagItemInfo == nil or rightBagItemInfo == nil or clientTableManager.cfg_itemsManager:IsSameItem(leftBagItemInfo.itemId,rightBagItemInfo.itemId) == false then
        return -2
    end
    local leftItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(leftBagItemInfo.itemId)
    if leftItemInfo == nil then
        return -2
    end
    if CS.CSServantInfoV2.IsServantEquip(leftBagItemInfo) then
        local compareId = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetBetterBodyEquip(leftBagItemInfo,rightBagItemInfo)
        return compareId
    end
    if CS.CSServantInfoV2.IsServantRoleEquip(leftItemInfo:GetSubType()) then
        return Utility.ComparePlayerNormalEquip(leftBagItemInfo,rightBagItemInfo)
    end
    return -2
end

---是否是灵兽法宝
---@param itemId number
---@return boolean
function Utility.IsServantMagicEquip(itemId)
    if itemId == nil then
        return false
    end
    local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemInfo == nil then
        return false
    end
    return itemInfo:GetSubType() == LuaEnumEquipSubType.Equip_HS_HanMang_MagicWeapon or itemInfo:GetSubType() == LuaEnumEquipSubType.Equip_HS_LuoXing_MagicWeapon or itemInfo:GetSubType() == LuaEnumEquipSubType.Equip_HS_TianCheng_MagicWeapon
end