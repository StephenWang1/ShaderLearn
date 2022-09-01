---@class LuaGemEquipDataItem:luaobject 宝物装备信息类
local LuaGemEquipDataItem = {}

--region 数据
---@type any 宝物镶嵌物服务器元数据
LuaGemEquipDataItem.ServerData = nil
---@type bagV2.BagItemInfo 宝物背包物品数据
LuaGemEquipDataItem.GemBagItemInfo = nil
---@type TABLE.cfg_items 宝物物品信息
LuaGemEquipDataItem.GemItemInfo = nil
---@type table<TABLE.cfg_items> 宝物镶嵌物的道具id
LuaGemEquipDataItem.GemAdditionItemTblTable = nil
---@type number 装备位
LuaGemEquipDataItem.EquipIndex = nil
--endregion

--region 刷新
--region 宝物刷新
---刷新宝物装备
---@param isAdd boolean 是否为添加条件
---@param index number 装备下标
---@param bagItemInfo bagV2.BagItemInfo lua 类
function LuaGemEquipDataItem:RefreshGemEquip(index, bagItemInfo)
    self.GemBagItemInfo = bagItemInfo
    self.GemItemInfo = nil
    if self.GemBagItemInfo ~= nil then
        self.GemItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(self.GemBagItemInfo.itemId)
    end
    if type(self.EquipIndex) ~= 'number' then
        self.EquipIndex = index
    end
end
--endregion

--region 镶嵌物刷新
---刷新单个宝物镶嵌物
---@param extraEquip bagV2.ExtraEquip 宝物镶嵌物品数据
function LuaGemEquipDataItem:RefreshSingleGemByExtraEquip(extraEquip)
    self.ServerData = extraEquip
    self:RefreshByItemId(extraEquip.itemId)
end

---刷新单个宝物镶嵌物
---@param lampUpgradeRes bagV2.LampUpgradeRes
function LuaGemEquipDataItem:RefreshSingleGemByLampUpgradeRes(lampUpgradeRes)
    self.ServerData = lampUpgradeRes
    self:RefreshByItemId(lampUpgradeRes.id)
end

---刷新单个宝物镶嵌物
---@param resUpgradeSoulJade bagV2.ResUpgradeSoulJade
function LuaGemEquipDataItem:RefreshSingleGemByResUpgradeSoulJade(resUpgradeSoulJade)
    self.ServerData = resUpgradeSoulJade
    self:RefreshByItemId(resUpgradeSoulJade.newId)
end

---@private 通过itemId刷新宝物镶嵌物
---@param itemId number
function LuaGemEquipDataItem:RefreshByItemId(itemId)
    if itemId == nil then
        return
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil then
        return
    end
    local isGemAddition = Utility:IsGemAddition(itemId)
    if isGemAddition == false then
        return
    end
    if self.GemAdditionItemTblTable == nil then
        self.GemAdditionItemTblTable = {}
    end
    local CacheItemTbl = self:GetSameTypeGemAddition(itemId)
    if CacheItemTbl ~= nil then
        Utility.RemoveTableValue(self.GemAdditionItemTblTable,CacheItemTbl)
    end
    table.insert(self.GemAdditionItemTblTable,itemTbl)
    if type(self.EquipIndex) ~= 'number' then
        self.EquipIndex = Utility:GetGemInlayItemEquipIndex(itemId)
    end
end
--endregion
--endregion

--region 获取
---获取宝物物品
---@return bagV2.BagItemInfo
function LuaGemEquipDataItem:GetGemBagItemInfo()
    return self.GemBagItemInfo
end

---获取宝物物品item表数据
---@return TABLE.cfg_items
function LuaGemEquipDataItem:GetGemItemInfo()
    return self.GemItemInfo
end

---获取宝物物品的等级
---@return number 等级
function LuaGemEquipDataItem:GetGemLevel()
    local gemItemTbl = self:GetGemItemInfo()
    if gemItemTbl == nil then
        return
    end
    return gemItemTbl:GetItemLevel()
end

---获取镶嵌的宝物物品
---@return table<TABLE.cfg_items>
function LuaGemEquipDataItem:GetInlayGemItem()
    return self.GemAdditionItemTblTable
end

---获取同类型的宝物镶嵌物
---@param itemId number
---@return TABLE.cfg_items
function LuaGemEquipDataItem:GetSameTypeGemAddition(itemId)
    if itemId == nil then
        return
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil then
        return
    end
    if type(self.GemAdditionItemTblTable) ~= 'table' then
        return
    end
    for k,v in pairs(self.GemAdditionItemTblTable) do
        ---@type TABLE.cfg_items
        local curItemTbl = v
        if itemTbl:GetType() == curItemTbl:GetType() and itemTbl:GetSubType() == curItemTbl:GetSubType() then
            return curItemTbl
        end
    end
end
--endregion

return LuaGemEquipDataItem