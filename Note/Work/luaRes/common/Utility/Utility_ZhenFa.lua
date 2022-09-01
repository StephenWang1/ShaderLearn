---@type Utility
local Utility = Utility

---对比阵法装备
---@param leftBagItemInfo bagV2.BagItemInfo
---@param rightBagItemInfo bagV2.BagItemInfo
---@return number 1(left > right) 0(left == right) -1(left < right) -2(出错)
function Utility.CompareZhenFaEquip(leftBagItemInfo, rightBagItemInfo)
    return Utility.ComparePlayerNormalEquip(leftBagItemInfo,rightBagItemInfo)
end

---是否是比身上好的阵法装备
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function Utility.ZhenFaEquipIsBetterThenBody(bagItemInfo)
    if bagItemInfo == nil or bagItemInfo.itemId == nil then
        return false
    end
    local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    if itemInfo == nil then
        return false
    end
    local bodySameTypeEquip = gameMgr:GetPlayerDataMgr():GetZhenFaManager():GetZhenFaEquipManager():GetSameTypeZhenFaEquip(itemInfo:GetId())
    if bodySameTypeEquip ~= nil then
        return Utility.CompareZhenFaEquip(bagItemInfo,bodySameTypeEquip) > 0
    end
    return true
end

---法阵装备是否可以装备
---@param itemId number
---@return LuaEnumUseItemParam
function Utility.FaZhenEquipCanEquiped(itemId)
    local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemInfo == nil then
        return false
    end
    local equipedIndex = itemInfo:GetSubType()
    local equipIndexIsUnLock = gameMgr:GetPlayerDataMgr():GetZhenFaManager():GetZhenFaEquipManager():EquipIndexIsUnlock(equipedIndex)
    if equipIndexIsUnLock == false then
        return LuaEnumUseItemParam.FaZhenEquipIndexIsLock
    end
    local conditionResult = Utility.FaZhenUseParamCondition(itemId)
    if conditionResult.success == false then
        return LuaEnumUseItemParam.FaZhenConfigDiscontent
    end
    local playerCanUseEquip = clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(itemInfo:GetId())
    return playerCanUseEquip
end

---法阵装备使用条件是否满足
---@param itemId number
---@return LuaMatchConditionResult
function Utility.FaZhenUseParamCondition(itemId)
    local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    ---@type LuaMatchConditionResult
    local conditionResult = { success = false,txt == "数据异常"}
    if itemInfo == nil then
        conditionResult.txt = itemId .. "未找到对应的道具id信息"
        return conditionResult
    end
    if itemInfo:GetUseParam() ~= nil and itemInfo:GetUseParam().list ~= nil then
        local conditionList = itemInfo:GetUseParam().list
        if conditionList ~= 'table' then
            conditionList = Utility.ListChangeTable(conditionList)
        end
        conditionResult = Utility.IsMainPlayerMatchConditionList_AND(conditionList)
    end
    return conditionResult
end
