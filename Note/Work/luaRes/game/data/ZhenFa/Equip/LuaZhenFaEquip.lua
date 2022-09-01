---@class LuaZhenFaEquip:luaobject 阵法装备信息类
local LuaZhenFaEquip = {}

--region 数据
---@type bagV2.BagItemInfo 背包物品信息
LuaZhenFaEquip.bagItemInfo = nil
---@type TABLE.cfg_items 装备信息类
LuaZhenFaEquip.itemInfo = nil
---@type LuaEnumPlayerEquipIndex 装备位
LuaZhenFaEquip.equipIndex = nil
---@type boolean 解锁状态
LuaZhenFaEquip.unLockState = nil
--endregion

--region 数据刷新
---@param equipInfo equipV2.EquipsChange 装备信息
function LuaZhenFaEquip:RefreshZhenFaEquip(equipInfo)
    if type(equipInfo) ~= 'table' then
        return
    end
    self.bagItemInfo = equipInfo.changeEquip
    if self.bagItemInfo == nil then
        self.itemInfo = nil
    else
        self.itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(self.bagItemInfo.itemId)
    end
end

---设置装备位解锁状态
---@param state boolean
function LuaZhenFaEquip:SetUnLockState(state)
    if state ~= self.unLockState then
        self.unLockState = state
        ---事件可以放这里
    end
end

---清理装备数据
function LuaZhenFaEquip:ClearZhenFaEquip()
    self.bagItemInfo = nil
    self.itemInfo = nil
end
--endregion

return LuaZhenFaEquip