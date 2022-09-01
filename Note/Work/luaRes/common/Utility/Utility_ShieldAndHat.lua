---@type Utility
local Utility = Utility

--region 查询
---是否是宝物装备位
---@param equipIndex number
---@return boolean
function Utility:IsShieldAndHatEquipIndex(equipIndex)
    if type(equipIndex) ~= 'number' then
        return false
    end
    return equipIndex == LuaEnumEquipSubType.Equip_Hat or
            equipIndex == LuaEnumEquipSubType.Equip_Shield
end

---是否是盾牌斗笠
---@param itemId number 物品id
---@return boolean 是否是盾牌斗笠
function Utility:IsShieldAndHat(itemId)
    if itemId == nil then
        return false
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl ~= nil then
        return itemTbl:GetSubType() == LuaEnumEquipSubType.Equip_Shield or itemTbl:GetSubType() == LuaEnumEquipSubType.Equip_Hat
    end
    return false
end


--endregion

--region 获取
---获取盾牌斗笠等级
---@param itemId number
---@return number
function Utility:GetShieldAndHatLevel(itemId)
    if type(itemId) ~= 'number' then
        return
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil then
        return
    end
    return itemTbl:GetItemLevel()
end

--endregion