--- DateTime: 2021/05/08 14:08
--- Description 投保ITEM

---@class LuaInsureItem:luaobject
local LuaInsureItem = {}

--region parameters
---@private
---@type TABLE.cfg_items
LuaInsureItem.tbl_Item = nil
---@private
---@type TABLE.cfg_items
LuaInsureItem.cs_tbl_Item = nil
---@private
---@type bagV2.BagItemInfo 装备数据
LuaInsureItem.bagItemInfo = nil
---@private
---@type boolean 是不是被保护
LuaInsureItem.isToProtect = false
---@private
---@type Cost 投保花费
LuaInsureItem.protectTheAmount = nil
---@private
---@type Cost 弃保花费
LuaInsureItem.waiverProtectTheAmount = nil
---@private
---@type number 位置
LuaInsureItem.index = nil

--endregion

--region public methods
---@param bagItemInfo bagV2.BagItemInfo
function LuaInsureItem:Init(bagItemInfo, isToProtect, index)
    if (bagItemInfo == nil) then
        return
    end
    self.bagItemInfo = bagItemInfo
    self.isToProtect = isToProtect
    self.index = index

    self.tbl_Item = Utility.GetItemTblByBagItemInfo(bagItemInfo)
    ___, self.cs_tbl_Item = CS.Cfg_ItemsTableManager.Instance:TryGetValue(bagItemInfo.itemId);

    if (self.tbl_Item ~= nil and self.tbl_Item:GetInsure() ~= nil and self.tbl_Item:GetInsure().list ~= nil) then
        if (Utility.GetTableCount(self.tbl_Item:GetInsure().list) > 1) then
            LuaInsureItem.protectTheAmount = {}
            LuaInsureItem.protectTheAmount.itemId = self:GetShowCostID()
            LuaInsureItem.protectTheAmount.costNum = self.tbl_Item:GetInsure().list[1]
            LuaInsureItem.waiverProtectTheAmount = {}
            LuaInsureItem.waiverProtectTheAmount.itemId = self:GetShowCostID()
            LuaInsureItem.waiverProtectTheAmount.costNum = self.tbl_Item:GetInsure().list[2]
        end
    end
end

function LuaInsureItem:GetTblItem()
    return self.tbl_Item
end

function LuaInsureItem:GetCSTblItem()
    return self.cs_tbl_Item
end

function LuaInsureItem:GetBagItemInfo()
    return self.bagItemInfo
end

function LuaInsureItem:GetProtectState()
    return self.isToProtect
end

function LuaInsureItem:GetProtectTheAmount()
    return self.protectTheAmount
end

function LuaInsureItem:GetwaiverProtectTheAmount()
    return self.waiverProtectTheAmount
end

function LuaInsureItem:GetIndex()
    return self.index
end
--endregion

--region private methods
---@private
function LuaInsureItem:GetShowCostID()
    if (self.showCostItemID == nil) then
        local isFind, globalTable = CS.Cfg_GlobalTableManager.Instance:TryGetValue(23113);
        if (isFind) then
            self.showCostItemID = tonumber(globalTable.value)
        end
    end
    return self.showCostItemID
end

--endregion

return LuaInsureItem