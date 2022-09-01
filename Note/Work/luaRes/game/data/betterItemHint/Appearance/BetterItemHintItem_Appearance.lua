---@class BetterItemHintItem_Appearance:BetterItemHintItem_Base
local BetterItemHintItem_Appearance = {}

setmetatable(BetterItemHintItem_Appearance, luaclass.BetterItemHintItem_Base)

--region 数据
---@type TABLE.cfg_appearance 时装表
BetterItemHintItem_Appearance.AppearanceTbl = nil
--endregion

--region 刷新
---数据刷新
---@param bagItemInfo bagV2.BagItemInfo
function BetterItemHintItem_Appearance:RefreshData(bagItemInfo)
    self:RunBaseFunction("RefreshData",bagItemInfo)
    self.AppearanceTbl = clientTableManager.cfg_appearanceManager:GetAppearanceTblByItemId(bagItemInfo.itemId)
end

--region 支持重写
---是否是同类型物品
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function BetterItemHintItem_Appearance:IsSameTypeItem(bagItemInfo)
    if self.ItemInfo == nil or bagItemInfo == nil then
        return false
    end
    local inputItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    if inputItemInfo == nil then
        return false
    end
    local inputItemAppearanceTbl = clientTableManager.cfg_appearanceManager:GetAppearanceTblByItemId(inputItemInfo:GetId())
    if self.AppearanceTbl == nil or inputItemAppearanceTbl == nil then
        return false
    end
    return self.AppearanceTbl:GetType() == inputItemAppearanceTbl:GetType()
end

---输入物品是否比缓存的好
---@param bagItemInfo bagV2.BagItemInfo
---@param newItem bagV2.BagItemInfo
function BetterItemHintItem_Appearance:InputItemBetterSelf(bagItemInfo,newItem)
    if newItem ~= nil then
        return bagItemInfo.lid == newItem.lid
    end
    return true
end
--endregion

return BetterItemHintItem_Appearance