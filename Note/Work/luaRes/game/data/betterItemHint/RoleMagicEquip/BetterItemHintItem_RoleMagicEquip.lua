---@class BetterItemHintItem_RoleMagicEquip:BetterItemHintItem_Base
local BetterItemHintItem_RoleMagicEquip = {}

setmetatable(BetterItemHintItem_RoleMagicEquip, luaclass.BetterItemHintItem_Base)

--region 数据
---@type LuaEnumMagicEquipSuitType 法宝装备类型
BetterItemHintItem_RoleMagicEquip.MagicEquipType = nil
---@type number 法宝装备位
BetterItemHintItem_RoleMagicEquip.MagicEquipEquipIndex = nil
--endregion

--region 刷新
---数据刷新
---@param bagItemInfo bagV2.BagItemInfo
function BetterItemHintItem_RoleMagicEquip:RefreshData(bagItemInfo)
    self:RunBaseFunction("RefreshData",bagItemInfo)
    self.MagicEquipType = clientTableManager.cfg_itemsManager:GetMagicEquipSuitType(bagItemInfo.itemId)
    self.MagicEquipEquipIndex = clientTableManager.cfg_itemsManager:GetMagicEquipEquipIndex(bagItemInfo.itemId)
end
--endregion

--region 支持重写
---是否是同类型物品
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function BetterItemHintItem_RoleMagicEquip:IsSameTypeItem(bagItemInfo)
    if self.ItemInfo == nil or bagItemInfo == nil then
        return false
    end
    local inputItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    if inputItemInfo == nil then
        return false
    end
    local inputItem_MagicEquipType = clientTableManager.cfg_itemsManager:GetMagicEquipSuitType(inputItemInfo:GetId())
    local inputItem_MagicEquipIndex = clientTableManager.cfg_itemsManager:GetMagicEquipEquipIndex(inputItemInfo:GetId())
    return self.MagicEquipType == inputItem_MagicEquipType and self.MagicEquipEquipIndex == inputItem_MagicEquipIndex
end

---输入物品是否比缓存的好
---@param bagItemInfo bagV2.BagItemInfo
---@param newItem bagV2.BagItemInfo 新获得的物品
function BetterItemHintItem_RoleMagicEquip:InputItemBetterSelf(bagItemInfo,newItem)
    if bagItemInfo == nil then
        return false
    end
    local inputItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    if inputItemTbl == nil then
        return false
    end
    return clientTableManager.cfg_itemsManager:CompareMagicEquip(inputItemTbl,self.ItemInfo) == 1
end
--endregion

return BetterItemHintItem_RoleMagicEquip