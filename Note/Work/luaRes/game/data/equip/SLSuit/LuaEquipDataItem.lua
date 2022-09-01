---玩家的装备数据基类(暂时没用)
---@class LuaEquipDataItem
local LuaEquipDataItem = {}

---装备位下标
LuaEquipDataItem.EquipIndex = 0

---道具数据
---@type bagV2.BagItemInfo
LuaEquipDataItem.BagItemInfo = nil

---装备所对应的道具表数据
---@type TABLE.CFG_ITEMS
LuaEquipDataItem.ItemTbl = nil

---装备所对应的道具表数据(lua里面的表数据)
---@type TABLE.cfg_items
LuaEquipDataItem.ItemTbl_lua = nil

---对应装备的套装数据
---@type TABLE.cfg_divinesuit
LuaEquipDataItem.DivineSuitTbl_lua = nil

---设置背包数据 会去读取并保存道具表数据 套装表数据
---@type bagV2.BagItemInfo
function LuaEquipDataItem:SetEquipData(info)
    if(info == nil) then
        self.BagItemInfo = nil
        self.ItemTbl = nil
        self.ItemTbl_lua = nil
        self.DivineSuitTbl_lua = nil
        return;
    end
    self.BagItemInfo = info;
    self.ItemTbl = info.ItemTABLE;
    self.ItemTbl_lua = Utility.GetItemTblByBagItemInfo(info);

    if(self.ItemTbl_lua == nil or self.ItemTbl_lua:GetDivineId() == nil or self.ItemTbl_lua:GetDivineId() == 0) then
        self.DivineSuitTbl_lua = nil
    else
        self.DivineSuitTbl_lua = clientTableManager.cfg_divinesuitManager:TryGetValue(self.ItemTbl_lua:GetDivineId())
    end
end

---得到套装的数据
---@return TABLE.cfg_divinesuit
function LuaEquipDataItem:GetSuitData()
    return self.DivineSuitTbl_lua;
end

---@public
---得到套装类型
---@return LuaEquipmentListType 套装类型/nil
function LuaEquipDataItem:GeTSuitType()
    if self.DivineSuitTbl_lua ~= nil then
        return self.DivineSuitTbl_lua.type
    end
end

return LuaEquipDataItem