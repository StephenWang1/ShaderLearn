---@class LuaShieldAndHatEquipDataItem:luaobject 盾牌斗笠装备信息类
local LuaShieldAndHatEquipDataItem = {}

--region 数据
---@type any 盾牌斗笠镶嵌物服务器元数据
LuaShieldAndHatEquipDataItem.ServerData = nil
---@type bagV2.BagItemInfo 盾牌斗笠背包物品数据
LuaShieldAndHatEquipDataItem.ShieldAndHatBagItemInfo = nil
---@type TABLE.cfg_items 盾牌斗笠物品信息
LuaShieldAndHatEquipDataItem.ShieldAndHatItemInfo = nil
---@type number 装备位
LuaShieldAndHatEquipDataItem.EquipIndex = nil
--endregion

--region 刷新
--region 盾牌斗笠刷新
---刷新盾牌斗笠装备
---@param isAdd boolean 是否为添加条件
---@param index number 装备下标
---@param bagItemInfo bagV2.BagItemInfo lua 类
function LuaShieldAndHatEquipDataItem:RefreshShieldAndHatEquip(index, bagItemInfo)
    self.ShieldAndHatBagItemInfo = bagItemInfo
    self.ShieldAndHatItemInfo = nil
    if self.ShieldAndHatBagItemInfo ~= nil then
        self.ShieldAndHatItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(self.ShieldAndHatBagItemInfo.itemId)
    end
    if type(self.EquipIndex) ~= 'number' then
        self.EquipIndex = index
    end
end
--endregion

--endregion

--region 获取
---获取盾牌斗笠物品
---@return bagV2.BagItemInfo
function LuaShieldAndHatEquipDataItem:GetShieldAndHatBagItemInfo()
    return self.ShieldAndHatBagItemInfo
end

---获取盾牌斗笠物品item表数据
---@return TABLE.cfg_items
function LuaShieldAndHatEquipDataItem:GetShieldAndHatItemInfo()
    return self.ShieldAndHatItemInfo
end

---获取盾牌斗笠物品的等级
---@return number 等级
function LuaShieldAndHatEquipDataItem:GetShieldAndHatLevel()
    local gemItemTbl = self:GetShieldAndHatItemInfo()
    if gemItemTbl == nil then
        return
    end
    return gemItemTbl:GetItemLevel()
end

--endregion

return LuaShieldAndHatEquipDataItem