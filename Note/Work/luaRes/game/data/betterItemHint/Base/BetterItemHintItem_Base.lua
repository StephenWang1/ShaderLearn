---@class BetterItemHintItem_Base:luaobject 更好物品提示物品信息基类
local BetterItemHintItem_Base = {}

--region 数据
---@type bagV2.BagItemInfo
BetterItemHintItem_Base.BagItemInfo = nil
---@type TABLE.CFG_ITEMS
BetterItemHintItem_Base.ItemInfo = nil
--endregion

--region 刷新
---数据刷新
---@param bagItemInfo bagV2.BagItemInfo 刷新的物品
function BetterItemHintItem_Base:RefreshData(bagItemInfo)
    self.BagItemInfo = bagItemInfo
    self.ItemInfo = Utility.GetItemTblByBagItemInfo(bagItemInfo)
end
--endregion

--region 支持重写
---是否是同类型物品
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function BetterItemHintItem_Base:IsSameTypeItem(bagItemInfo)
    if self.ItemInfo == nil or bagItemInfo == nil then
        return false
    end
    local inputItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    if inputItemInfo == nil then
        return false
    end
    return self.ItemInfo:GetType() == inputItemInfo:GetType() and self.ItemInfo:GetSubType() and inputItemInfo:GetSubType()
end

---输入物品是否比缓存的好
---@param bagItemInfo bagV2.BagItemInfo
---@param newItem bagV2.BagItemInfo 新获得的物品
function BetterItemHintItem_Base:InputItemBetterSelf(bagItemInfo,newItem)
    return false
end
--endregion

return BetterItemHintItem_Base