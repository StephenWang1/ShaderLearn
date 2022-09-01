---@class LuaGemEquipmentListData:luaobject 法宝列表信息类
local LuaGemEquipmentListData = {}

--region 数据
---@type table<LuaGemEquipDataItem> 宝物数据列表
LuaGemEquipmentListData.GemEquipDataItemList = nil
---@type table<LuaEnumSuitType,TABLE.cfg_suit> 套装表
LuaGemEquipmentListData.SuitTblList = nil
--endregion

--region 刷新
--region 宝物刷新
---刷新宝物装备
---@param isAdd boolean 是否为添加条件
---@param index number 装备下标
---@param bagItemInfo bagV2.BagItemInfo lua 类
function LuaGemEquipmentListData:RefreshGemEquip(index, bagItemInfo)
    local gemItemClass = self:GetGemItemClassByEquipIndex(index)
    if gemItemClass == nil then
        return
    end
    gemItemClass:RefreshGemEquip(index, bagItemInfo)
    self:InitSuitTbl()
end
--endregion

--region 宝物镶嵌物刷新
---刷新单个宝物镶嵌物
---@param extraEquip bagV2.ExtraEquip 宝物数据
function LuaGemEquipmentListData:RefreshSingleGemByExtraEquip(extraEquip)
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(extraEquip.itemId)
    if itemTbl == nil then
        return
    end
    local gemEquipClass = self:GetGemAdditionItemClassByItemId(itemTbl:GetId())
    if gemEquipClass ~= nil then
        gemEquipClass:RefreshSingleGemByExtraEquip(extraEquip)
    end
    self:InitSuitTbl()
end

---刷新单个宝物镶嵌物
---@param lampUpgradeRes bagV2.LampUpgradeRes
function LuaGemEquipmentListData:RefreshSingleGemByLampUpgradeRes(lampUpgradeRes)
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(lampUpgradeRes.id)
    if itemTbl == nil then
        return
    end
    local gemEquipClass = self:GetGemAdditionItemClassByItemId(itemTbl:GetId())
    if gemEquipClass ~= nil then
        gemEquipClass:RefreshSingleGemByLampUpgradeRes(lampUpgradeRes)
    end
    self:InitSuitTbl()
end

---刷新单个宝物镶嵌物
---@param resUpgradeSoulJade bagV2.ResUpgradeSoulJade
function LuaGemEquipmentListData:RefreshSingleGemByResUpgradeSoulJade(resUpgradeSoulJade)
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(resUpgradeSoulJade.newId)
    if itemTbl == nil then
        return
    end
    local gemEquipClass = self:GetGemAdditionItemClassByItemId(itemTbl:GetId())
    if gemEquipClass ~= nil then
        gemEquipClass:RefreshSingleGemByResUpgradeSoulJade(resUpgradeSoulJade)
    end
    self:InitSuitTbl()
end

---初始化套装表
---@param itemId number
function LuaGemEquipmentListData:InitSuitTbl(itemId)
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil then
        return
    end
    local suitType = itemTbl:GetSuitBelong()
    local minSuitTbl = clientTbaleManager.cfg_suitManager:GetMinSuitTblBySuitType(suitType)
    local minLevel = self:GetBodySuitMinLevel(minSuitTbl)
    local suitTbl = clientTableManager.cfg_suitManager:GetSuitTblBySuitTypeAndLevel(suitType, minLevel)
    if self.SuitTblList == nil then
        self.SuitTblList = {}
    end
    if suitTbl ~= nil then
        self.SuitTblList[suitTbl:GetSuitId()] = suitTbl
    end
end
--endregion
--endregion

--region 套装
---获取身上套装最低等级
---@param suitTbl TABLE.cfg_suit
---@return number
function LuaGemEquipmentListData:GetBodySuitMinLevel(suitTbl)
    if suitTbl == nil then
        return
    end
    local minLevel
    local allSuitSubType = suitTbl:GetBelongSuit()
    if allSuitSubType ~= nil and allSuitSubType.list ~= nil and Utility.GetLuaTableCount(allSuitSubType.list) > 0 then
        for k, v in pairs(allSuitSubType.list) do
            local itemTypeAndSubTypeTable = v.list
            if type(itemTypeAndSubTypeTable) == 'table' and #itemTypeAndSubTypeTable > 1 then
                local itemType = itemTypeAndSubTypeTable[1]
                local subType = itemTypeAndSubTypeTable[2]
                local gemClass = self:GetGemClassByTypeAndSubtype(itemType, subType)
                if gemClass == nil then
                    return
                end
                local curMinLevel = gemClass:GetGemLevel()
                if type(minLevel) ~= 'number' or curMinLevel < minLevel then
                    minLevel = curMinLevel
                end
            end
        end
    end
    return minLevel
end

---获取套装最低等级
---@param itemId number
---@return number
function LuaGemEquipmentListData:GetSuitMinLevel(itemId)
    if type(itemId) ~= 'number' then
        return
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil then
        return
    end
    local suitTbl = self:GetSuiTbl_CanCompleteSuit(itemId)
    if suitTbl == nil then
        return
    end
    local minLevel
    local allSuitSubType = suitTbl:GetBelongSuit()
    if allSuitSubType ~= nil and allSuitSubType.list ~= nil and Utility.GetLuaTableCount(allSuitSubType.list) > 0 then
        for k, v in pairs(allSuitSubType.list) do
            local itemTypeAndSubTypeTable = v.list
            if type(itemTypeAndSubTypeTable) == 'table' and #itemTypeAndSubTypeTable > 1 then
                local itemType = itemTypeAndSubTypeTable[1]
                local subType = itemTypeAndSubTypeTable[2]
                local curMinLevel = 10000
                if itemType == itemTbl:GetType() and subType == itemTbl:GetSubType() then
                    curMinLevel = itemTbl:GetItemLevel()
                else
                    local gemClass = self:GetGemClassByTypeAndSubtype(itemType, subType)
                    if gemClass == nil then
                        return
                    end
                    curMinLevel = gemClass:GetGemLevel()
                end
                if type(minLevel) ~= 'number' or curMinLevel < minLevel then
                    minLevel = curMinLevel
                end
            end
        end
    end
    return minLevel
end

---查询身上是否有指定类型的宝物
---@param type number
---@param subType number
---@return boolean
function LuaGemEquipmentListData:CheckBodyHaveSameTypeAndSubtypeGem(type, subType)
    local gemItemClass = self:GetGemClassByTypeAndSubtype(type, subType)
    return gemItemClass ~= nil and gemItemClass:GetGemItemInfo() ~= nil
end

---通过itemId获取可以集齐的套装表
---@param itemId number
---@return TABLE.cfg_suit
function LuaGemEquipmentListData:GetSuiTbl_CanCompleteSuit(itemId)
    if type(itemId) ~= 'number' then
        return
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil then
        return
    end
    local suitType = itemTbl:GetSuitBelong()
    if suitType == nil then
        return
    end
    local gemLevel = Utility:GetGemLevel(itemId)
    if type(gemLevel) ~= 'number' then
        return
    end
    return clientTableManager.cfg_suitManager:GetSuitTblBySuitTypeAndLevel(suitType,gemLevel)
end

---通过itemId获取可以集齐的套装组件信息
---@param itemId number
---@return table<SuitPartsConfigParams>
function LuaGemEquipmentListData:GetSuiParts_CanCompleteSuit(itemId)
    if type(itemId) ~= 'number' then
        return false
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil then
        return false
    end
    local suitType = itemTbl:GetSuitBelong()
    if suitType == nil then
        return false
    end
    local gemLevel = Utility:GetGemLevel(itemId)
    if type(gemLevel) ~= 'number' then
        return
    end
    return clientTableManager.cfg_suitManager:GetSuitPartsConfigBySuitTypeAndLevel(suitType,gemLevel)
end

---检测添加的道具是否可以集齐一套套装
---@param itemId number
---@return boolean
function LuaGemEquipmentListData:CheckItemCanCompleteSuit(itemId)
    if type(itemId) ~= 'number' then
        return false
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil then
        return false
    end
    local suitPartsConfigTable = self:GetSuiParts_CanCompleteSuit(itemId)
    if type(suitPartsConfigTable) ~= 'table' or Utility.GetLuaTableCount(suitPartsConfigTable) <= 0 then
        return false
    end
    for k, v in pairs(suitPartsConfigTable) do
        ---@type SuitPartsConfigParams
        local configParams = v
        if configParams ~= nil then
            ---@type boolean 是否有配置的套装组件
            local haveConfigParts = (configParams.itemType == itemTbl:GetType() and configParams.itemSubType == itemTbl:GetSubType()) or self:CheckBodyHaveSameTypeAndSubtypeGem(configParams.itemType, configParams.itemSubType)
            if haveConfigParts == false then
                return false
            end
        end
    end
    return true
end

---获取套装组件名
---@param itemId number
---@return string
function LuaGemEquipmentListData:GetSuitPartsName(itemId)
    if type(itemId) ~= 'number' then
        return
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil then
        return
    end
    local suitTbl = clientTableManager.cfg_suitManager:GetSuitTblByItemId(itemId)
    if suitTbl == nil then
        return
    end
    local suitPartsConfigTable = self:GetSuiParts_CanCompleteSuit(itemId)
    if type(suitPartsConfigTable) ~= 'table' or Utility.GetLuaTableCount(suitPartsConfigTable) <= 0 then
        return
    end
    local suitPartsConfigTableCount = Utility.GetLuaTableCount(suitPartsConfigTable)
    local des = ""
    for k, v in pairs(suitPartsConfigTable) do
        ---@type SuitPartsConfigParams
        local configParams = v
        local gemPartName = ""
        if configParams ~= nil then
            local gemColor = luaEnumColorType.Gray
            local itemName = ""
            ---配置的默认宝物
            local normalId = configParams.normalItemId
            local normalItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(normalId)
            local normalGemLv = Utility:GetGemLevel(normalId)
            ---@type LuaGemEquipDataItem 身上的宝物
            local gemEquipClass = self:GetGemClassByTypeAndSubtype(configParams.itemType, configParams.itemSubType)
            if configParams.itemType == itemTbl:GetType() and configParams.itemSubType == itemTbl:GetSubType() then
                local curGemLevel = Utility:GetGemLevel(itemId)
                if type(curGemLevel) == 'number' then
                    gemColor = luaEnumColorType.Green3
                    itemName = CS.Utility_Lua.RemoveStringColor(itemTbl:GetName())
                end
            else
                if gemEquipClass ~= nil then
                    local curGemLevel = gemEquipClass:GetGemLevel()
                    if type(curGemLevel) == 'number' and type(normalGemLv) == 'number' and normalGemLv > curGemLevel then
                        gemColor = luaEnumColorType.Gray
                        itemName = CS.Utility_Lua.RemoveStringColor(normalItemTbl:GetName())
                    else
                        gemColor = luaEnumColorType.Green3
                        local gemItemInfo = gemEquipClass.GemItemInfo
                        if gemItemInfo then
                            itemName = CS.Utility_Lua.RemoveStringColor(gemItemInfo:GetName())
                        end
                    end
                else
                    if normalItemTbl then
                        itemName = CS.Utility_Lua.RemoveStringColor(normalItemTbl:GetName())
                    end
                end
            end
            gemPartName = gemColor .. itemName
        end
        if k == suitPartsConfigTableCount then
            des = des .. gemPartName
        else
            des = des .. gemPartName .. "  "
        end
    end
    return des
end

---获取物品信息面板的套装描述内容
---@param itemId number
---@return string,string 标题名，内容
function LuaGemEquipmentListData:GetGemSuitDesToItemInfoPanel(itemId)
    local suitName = clientTableManager.cfg_suitManager:GetSuitNameByItemId(itemId)
    local suitPartsDes = self:GetSuitPartsName(itemId)
    local suitBuffDes = clientTableManager.cfg_suitManager:GetSuitBuffDesByItemId(itemId)
    local canCompleteSuit = self:CheckItemCanCompleteSuit(itemId)
    local buffDesColor = ternary(canCompleteSuit == true, luaEnumColorType.Green3, luaEnumColorType.Gray)
    if CS.StaticUtility.IsNullOrEmpty(suitName) or CS.StaticUtility.IsNullOrEmpty(suitPartsDes) or CS.StaticUtility.IsNullOrEmpty(suitBuffDes) then
        return
    end
    return suitName, suitPartsDes .. "\n" .. buffDesColor .. suitBuffDes
end
--endregion

--region 获取
---获取指定子类型的宝物道具类
---@param itemId number
---@return LuaGemEquipDataItem
function LuaGemEquipmentListData:GetGemAdditionItemClassByItemId(itemId)
    local EquipIndex = Utility:GetGemInlayItemEquipIndex(itemId)
    return self:GetGemItemClassByEquipIndex(EquipIndex)
end

---通过装备位获取宝物物品类
---@param equipIndex number
---@return LuaGemEquipDataItem
function LuaGemEquipmentListData:GetGemItemClassByEquipIndex(EquipIndex)
    if type(EquipIndex) ~= 'number' then
        return
    end
    if type(self.GemEquipDataItemList) == 'table' then
        for k, v in pairs(self.GemEquipDataItemList) do
            ---@type LuaGemEquipDataItem
            local gemEquipClass = v
            if gemEquipClass.EquipIndex == EquipIndex then
                return gemEquipClass
            end
        end
    else
        self.GemEquipDataItemList = {}
    end
    local gemEquipClass = luaclass.LuaGemEquipDataItem:New()
    table.insert(self.GemEquipDataItemList, gemEquipClass)
    return gemEquipClass
end

---通过Type和Subtype获取宝物类
---@return LuaGemEquipDataItem
function LuaGemEquipmentListData:GetGemClassByTypeAndSubtype(itemType, itemSubType)
    if type(itemType) ~= 'number' or type(itemSubType) ~= 'number' then
        return
    end
    if type(self.GemEquipDataItemList) == 'table' then
        for k, v in pairs(self.GemEquipDataItemList) do
            ---@type LuaGemEquipDataItem
            local gemEquipClass = v
            if gemEquipClass ~= nil then
                local gemItemInfo = gemEquipClass:GetGemItemInfo()
                if gemItemInfo ~= nil and gemItemInfo:GetType() == itemType and gemItemInfo:GetSubType() == itemSubType then
                    return gemEquipClass
                end
            end
        end
    else
        self.GemEquipDataItemList = {}
    end
end

---获取第一个套装信息
---@return TABLE.cfg_suit
function LuaGemEquipmentListData:GetFirstSuitTbl()
    if type(self.SuitTblList) ~= 'table' or Utility.GetLuaTableCount(self.SuitTblList) <= 0 then
        return
    end
    return self.SuitTblList[1]
end
--endregion

return LuaGemEquipmentListData