---@class LuaShieldAndHatEquipmentListData:luaobject 法宝列表信息类
local LuaShieldAndHatEquipmentListData = {}

--region 数据
---@type table<LuaShieldAndHatEquipDataItem> 盾牌斗笠数据列表
LuaShieldAndHatEquipmentListData.ShieldAndHatEquipDataItemList = nil
---@type table<LuaEnumSuitType,TABLE.cfg_suit> 套装表
LuaShieldAndHatEquipmentListData.SuitTblList = nil
---身上的装备列表
LuaShieldAndHatEquipmentListData.suitPartItemInfoList = nil
--endregion

--region 刷新
--region 盾牌斗笠刷新
---刷新盾牌斗笠装备
---@param isAdd boolean 是否为添加条件
---@param index number 装备下标
---@param bagItemInfo bagV2.BagItemInfo lua 类
function LuaShieldAndHatEquipmentListData:RefreshShieldAndHatEquip(index, bagItemInfo)
    local ShieldAndHatItemClass = self:GetShieldAndHatItemClassByEquipIndex(index)
    if ShieldAndHatItemClass == nil then
        return
    end
    ShieldAndHatItemClass:RefreshShieldAndHatEquip(index, bagItemInfo)
    self:InitSuitTbl()
end

---初始化套装表
---@param itemId number
function LuaShieldAndHatEquipmentListData:InitSuitTbl(itemId)
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
function LuaShieldAndHatEquipmentListData:GetBodySuitMinLevel(suitTbl)
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
                local ShieldAndHatClass = self:GetShieldAndHatClassByTypeAndSubtype(itemType, subType)
                if ShieldAndHatClass == nil then
                    return
                end
                local curMinLevel = ShieldAndHatClass:GetShieldAndHatLevel()
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
function LuaShieldAndHatEquipmentListData:GetSuitMinLevel(itemId)
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
                    local ShieldAndHatClass = self:GetShieldAndHatClassByTypeAndSubtype(itemType, subType)
                    if ShieldAndHatClass == nil then
                        return
                    end
                    curMinLevel = ShieldAndHatClass:GetShieldAndHatLevel()
                end
                if type(minLevel) ~= 'number' or curMinLevel < minLevel then
                    minLevel = curMinLevel
                end
            end
        end
    end
    return minLevel
end

---查询身上是否有指定类型的盾牌斗笠
---@param type number
---@param subType number
---@return boolean
function LuaShieldAndHatEquipmentListData:CheckBodyHaveSameTypeAndSubtypeShieldAndHat(type, subType)
    for i = 1, #self.suitPartItemInfoList do
        if (self.suitPartItemInfoList[i]:GetType() == type and self.suitPartItemInfoList[i]:GetSubType() == subType) then
            return true
        end
    end
    return false
end

---通过itemId获取可以集齐的套装表
---@param itemId number
---@return TABLE.cfg_suit
function LuaShieldAndHatEquipmentListData:GetSuiTbl_CanCompleteSuit(itemId)
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
    local ShieldAndHatLevel = Utility:GetShieldAndHatLevel(itemId)
    if type(ShieldAndHatLevel) ~= 'number' then
        return
    end
    return clientTableManager.cfg_suitManager:GetSuitTblBySuitTypeAndLevel(suitType, ShieldAndHatLevel)
end

---通过itemId获取可以集齐的套装组件信息
---@param itemId number
---@return table<SuitPartsConfigParams>
function LuaShieldAndHatEquipmentListData:GetSuiParts_CanCompleteSuit(itemId)
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
    local ShieldAndHatLevel = Utility:GetShieldAndHatLevel(itemId)
    if type(ShieldAndHatLevel) ~= 'number' then
        return false
    end
    return clientTableManager.cfg_suitManager:GetSuitPartsConfigBySuitTypeAndLevel(suitType, ShieldAndHatLevel)
end

---检测添加的道具是否可以集齐一套套装
---@param itemId number
---@return boolean
function LuaShieldAndHatEquipmentListData:CheckItemCanCompleteSuit(itemId)
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
            local haveConfigParts = (configParams.itemType == itemTbl:GetType() and configParams.itemSubType == itemTbl:GetSubType())
                    or self:CheckBodyHaveSameTypeAndSubtypeShieldAndHat(configParams.itemType, configParams.itemSubType)
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
function LuaShieldAndHatEquipmentListData:GetSuitPartsName(itemId)
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
        local ShieldAndHatPartName = ""
        if configParams ~= nil then
            local ShieldAndHatColor = luaEnumColorType.Gray
            local itemName = ""
            ---配置的默认盾牌斗笠
            local normalId = configParams.normalItemId
            local normalItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(normalId)
            local normalShieldAndHatLv = Utility:GetShieldAndHatLevel(normalId)
            ---@type LuaShieldAndHatEquipDataItem 身上的盾牌斗笠
            local ShieldAndHatEquipClass = self:GetShieldAndHatClassByTypeAndSubtype(configParams.itemType, configParams.itemSubType)
            if configParams.itemType == itemTbl:GetType() and configParams.itemSubType == itemTbl:GetSubType() then
                local curShieldAndHatLevel = Utility:GetShieldAndHatLevel(itemId)
                if type(curShieldAndHatLevel) == 'number' then
                    ShieldAndHatColor = luaEnumColorType.Green3
                    itemName = CS.Utility_Lua.RemoveStringColor(itemTbl:GetName())
                end
            else
                if ShieldAndHatEquipClass ~= nil then
                    local curShieldAndHatLevel = ShieldAndHatEquipClass:GetShieldAndHatLevel()
                    if type(curShieldAndHatLevel) == 'number' and type(normalShieldAndHatLv) == 'number' and normalShieldAndHatLv > curShieldAndHatLevel then
                        ShieldAndHatColor = luaEnumColorType.Gray
                        itemName = CS.Utility_Lua.RemoveStringColor(normalItemTbl:GetName())
                    else
                        ShieldAndHatColor = luaEnumColorType.Green3
                        local ShieldAndHatItemInfo = ShieldAndHatEquipClass.ShieldAndHatItemInfo
                        if ShieldAndHatItemInfo then
                            itemName = CS.Utility_Lua.RemoveStringColor(ShieldAndHatItemInfo:GetName())
                        end
                    end
                else
                    if normalItemTbl then
                        itemName = CS.Utility_Lua.RemoveStringColor(normalItemTbl:GetName())
                    end
                end
            end
            ShieldAndHatPartName = ShieldAndHatColor .. itemName
        end
        if k == suitPartsConfigTableCount then
            des = des .. ShieldAndHatPartName
        else
            des = des .. ShieldAndHatPartName .. "  "
        end
    end
    return des
end

---获取物品信息面板的套装描述内容
---@param itemId number
---@return string,string 标题名，内容
function LuaShieldAndHatEquipmentListData:GetShieldAndHatSuitDesToItemInfoPanel(itemId)
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

---通过装备位获取盾牌斗笠物品类
---@param equipIndex number
---@return LuaShieldAndHatEquipDataItem
function LuaShieldAndHatEquipmentListData:GetShieldAndHatItemClassByEquipIndex(EquipIndex)
    if type(EquipIndex) ~= 'number' then
        return
    end
    if type(self.ShieldAndHatEquipDataItemList) == 'table' then
        for k, v in pairs(self.ShieldAndHatEquipDataItemList) do
            ---@type LuaShieldAndHatEquipDataItem
            local ShieldAndHatEquipClass = v
            if ShieldAndHatEquipClass.EquipIndex == EquipIndex then
                return ShieldAndHatEquipClass
            end
        end
    else
        self.ShieldAndHatEquipDataItemList = {}
    end
    local ShieldAndHatEquipClass = luaclass.LuaShieldAndHatEquipDataItem:New()
    table.insert(self.ShieldAndHatEquipDataItemList, ShieldAndHatEquipClass)
    return ShieldAndHatEquipClass
end

---通过Type和Subtype获取盾牌斗笠类
---@return boolean
function LuaShieldAndHatEquipmentListData:GetShieldAndHatClassByTypeAndSubtype(itemType, itemSubType)
    if type(itemType) ~= 'number' or type(itemSubType) ~= 'number' then
        return
    end
    if type(self.ShieldAndHatEquipDataItemList) == 'table' then
        for k, v in pairs(self.ShieldAndHatEquipDataItemList) do
            ---@type LuaShieldAndHatEquipDataItem
            local ShieldAndHatEquipClass = v
            if ShieldAndHatEquipClass ~= nil then
                local ShieldAndHatItemInfo = ShieldAndHatEquipClass:GetShieldAndHatItemInfo()
                if ShieldAndHatItemInfo ~= nil and ShieldAndHatItemInfo:GetType() == itemType and ShieldAndHatItemInfo:GetSubType() == itemSubType then
                    return ShieldAndHatEquipClass
                end
            end
        end
    else
        self.ShieldAndHatEquipDataItemList = {}
    end
    return nil
end

---获取第一个套装信息
---@return TABLE.cfg_suit
function LuaShieldAndHatEquipmentListData:GetFirstSuitTbl()
    if type(self.SuitTblList) ~= 'table' or Utility.GetLuaTableCount(self.SuitTblList) <= 0 then
        return
    end
    return self.SuitTblList[1]
end
--endregion

return LuaShieldAndHatEquipmentListData