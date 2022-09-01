---@type Utility
local Utility = Utility

--region 查询
---是否是勋章
---@param itemId number 物品id
---@return boolean
function Utility.IsMedal(itemId)
    local tbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if tbl == nil then
        return false
    end
    return tbl:GetSubType() == LuaEnumEquipSubType.Equip_xunzhang or tbl:GetSubType() == LuaEnumEquipSubType.Equip_doublexunzhang
end

---是否是双倍勋章
---@param itemId number 物品id
---@return boolean
function Utility.IsDoubleMedal(itemId)
    local tbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if tbl == nil then
        return false
    end
    return tbl:GetSubType() == LuaEnumEquipSubType.Equip_doublexunzhang
end

---是否是普通勋章
function Utility.IsNormalMedal(itemId)
    local tbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if tbl == nil then
        return false
    end
    return tbl:GetSubType() == LuaEnumEquipSubType.Equip_xunzhang
end
--endregion

--region 对比
---勋章装备对比
---@param leftBagItemInfo bagV2.BagItemInfo
---@param rightBagItemInfo bagV2.BagItemInfo
---@return number 1(left > right) 0(left == right) -1(left < right) -2(出错)
function Utility.CompareMedal(leftBagItemInfo,rightBagItemInfo)
    if leftBagItemInfo == nil or rightBagItemInfo == nil or Utility.IsMedal(leftBagItemInfo.itemId) == false or Utility.IsMedal(rightBagItemInfo.itemId) == false then
        local isSameTypeItem = clientTableManager.cfg_itemsManager:IsSameItem(leftBagItemInfo.itemId,rightBagItemInfo.itemId)
        local IsNomalMedal = Utility.IsNormalMedal(leftBagItemInfo.itemId)
        if isSameTypeItem then
            if IsNomalMedal then
                return Utility.CompareNormalMedal(leftBagItemInfo,rightBagItemInfo)
            else
                return Utility.CompareDoubleMedal(leftBagItemInfo,rightBagItemInfo)
            end
        else
            if IsNomalMedal then
                return 1
            else
                return -1
            end
        end
    end
    return -2
end

---普通勋章装备对比
---@param leftBagItemInfo bagV2.BagItemInfo
---@param rightBagItemInfo bagV2.BagItemInfo
---@return number 1(left > right) 0(left == right) -1(left < right) -2(出错)
function Utility.CompareNormalMedal(leftBagItemInfo,rightBagItemInfo)
    if leftBagItemInfo == nil or rightBagItemInfo == nil or Utility.IsNormalMedal(leftBagItemInfo.itemId) == false or Utility.IsNormalMedal(rightBagItemInfo.itemId) == false then
        return -2
    end
    ---勋章提升数据
    local leftMedalAddValue = Utility.GetItemUpAttributeValue(leftBagItemInfo)
    local rightMedalAddValue = Utility.GetItemUpAttributeValue(rightBagItemInfo)
    local compareId = Utility.NumberCompare(leftMedalAddValue,rightMedalAddValue)
    if compareId ~= 0 then
        return compareId
    end
    ---合成对象
    local leftInlayBagItemInfo,rightInlayBagItemInfo = Utility.GetTableFirstValue(leftBagItemInfo.inlayInfoList),Utility.GetTableFirstValue(rightBagItemInfo.inlayInfoList)
    if leftInlayBagItemInfo ~= nil and rightInlayBagItemInfo then
        local leftInlayItemInfo = Utility.GetItemTblByBagItemInfo(leftInlayBagItemInfo)
        local rightInlayItemInfo = Utility.GetItemTblByBagItemInfo(rightInlayBagItemInfo)
        compareId = Utility.NumberCompare(leftInlayItemInfo:GetMonsterDieAddExpBei(),rightInlayItemInfo:GetMonsterDieAddExpBei())
        return compareId
    else
        if leftInlayBagItemInfo ~= nil then
            return 1
        elseif rightInlayBagItemInfo ~= nil then
            return -1
        else
            return 0
        end
    end
    return -2
end

---双倍勋章装备对比
---@param leftBagItemInfo bagV2.BagItemInfo
---@param rightBagItemInfo bagV2.BagItemInfo
---@return number 1(left > right) 0(left == right) -1(left < right) -2(出错)
function Utility.CompareDoubleMedal(leftBagItemInfo,rightBagItemInfo)
    if leftBagItemInfo == nil or rightBagItemInfo == nil or Utility.IsDoubleMedal(leftBagItemInfo.itemId) == false or Utility.IsDoubleMedal(rightBagItemInfo.itemId) == false then
        return -2
    end
    local leftItemInfo = Utility.GetItemTblByBagItemInfo(leftBagItemInfo)
    local rightItemInfo = Utility.GetItemTblByBagItemInfo(rightBagItemInfo)
    local compareId = Utility.NumberCompare(leftItemInfo:GetMonsterDieAddExpBei(),rightItemInfo:GetMonsterDieAddExpBei())
    return compareId
end
--endregion