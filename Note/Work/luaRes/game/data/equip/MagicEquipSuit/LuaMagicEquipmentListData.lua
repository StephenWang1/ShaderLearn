---@class LuaMagicEquipmentListData 法宝套装信息类
local LuaMagicEquipmentListData = {}

--region 数据
---@type boolean 是否以初始化
LuaMagicEquipmentListData.IsInit = false
---@type table<number,LuaMagicEquipDataItem> 法宝套装列表(装备位==>装备信息表)
LuaMagicEquipmentListData.MagicEquipSuitTable = nil
---@type LuaEnumMagicEquipSuitType 法宝套装类型
LuaMagicEquipmentListData.MagicEquipSuitType = LuaEnumMagicEquipSuitType.Null
---@type table 法宝配置参数
LuaMagicEquipmentListData.MagicEquipConfigData = nil
--endregion

--region 刷新
---刷新装备列表
---@param tblData equipV2.MagicWeaponInfo 服务器所有法宝数据
function LuaMagicEquipmentListData:RefreshEquipList(tblData)
    if tblData == nil or tblData.suitType == nil or tblData.magicWeapon == nil and type(tblData) == 'table' then
        self.MagicEquipSuitTable = {}
        self.IsInit = false
        return
    end
    if self.MagicEquipSuitTable == nil then
        self.MagicEquipSuitTable = {}
    end
    self.MagicEquipSuitType = tblData.suitType
    for k,v in pairs(tblData.magicWeapon) do
        self:RefreshSingleEquip(v)
    end
end

---通过套装类型刷新基础数据
---@param suitType LuaEnumMagicEquipSuitType 法宝套装类型
function LuaMagicEquipmentListData:AnalysisSuitType(suitType)
    if suitType ~= nil then
        self.MagicEquipSuitType = suitType
        self.IsInit = true
        self.MagicEquipConfigData = LuaGlobalTableDeal:GetMagicEquipConfigParamsBySuitType(self.MagicEquipSuitType)
    end
end

---刷新单个装备
---@param tblData equipV2.MagicWeapon 服务器套装法宝数据
function LuaMagicEquipmentListData:RefreshSingleEquip(tblData)
    if tblData == nil then
        return
    end
    ---@type LuaEnumMagicEquipChangeActionType 数据变化行为类型
    local actionType = self:AnalysisActionType(tblData)
    if actionType == LuaEnumMagicEquipChangeActionType.Null then
        return
    end
    ---@type number 实际的装备位
    local equipIndex = tblData.index
    if equipIndex == nil or type(equipIndex) ~= 'number' then
        return
    end
    ---@type LuaMagicEquipDataItem 法宝装备数据类
    local magicEquipDataItemInfo = self:GetMagicEquipItemInfo(equipIndex)
    magicEquipDataItemInfo:RefreshMagicEquipItem(tblData.itemInfo,equipIndex)
    luaEventManager.DoCallback(LuaCEvent.RefreshMagicEquip,{equipIndex = equipIndex})
end
--endregion

--region 查询
---是否包含指定的法宝
---@param bagItemInfo bagV2.BagItemInfo
function LuaMagicEquipmentListData:IsContainItem(bagItemInfo)
    if bagItemInfo ~= nil and self.MagicEquipSuitTable ~= nil and type(self.MagicEquipSuitTable) == 'table' then
        for k,v in pairs(self.MagicEquipSuitTable) do
            if v ~= nil and v.BagItemInfo ~= nil and bagItemInfo.lid == v.BagItemInfo.lid then
                return true
            end
        end
    end
    return false
end

---是否有可以装备的更好的装备
---@return boolean
function LuaMagicEquipmentListData:HaveBestEquip()
    if self.MagicEquipSuitTable ~= nil and type(self.MagicEquipSuitTable) == 'table' then
        for k,v in pairs(self.MagicEquipSuitTable) do
            if v ~= nil and v:GetBestItemByBag() ~= nil then
                return true
            end
        end
    end
    return false
end

---是否有可以装备的法宝
---@return boolean
function LuaMagicEquipmentListData:HaveCanEquip()
    if self.MagicEquipSuitTable ~= nil and type(self.MagicEquipSuitTable) == 'table' then
        for k,v in pairs(self.MagicEquipSuitTable) do
            if v ~= nil and v.BagItemInfo == nil and v:GetBestItemByBag() ~= nil then
                return true
            end
        end
    end
    return false
end

---是否集齐套装
---@return boolean 是否集齐套装
function LuaMagicEquipmentListData:IsCompleteSuit()
    return self:GetEquipCount() >= self:GetSuitMaxCount()
end
--endregion

--region 获取
---解析数据变动的行为类型
---@param tblData equipV2.MagicWeapon 服务器套装法宝数据
---@return LuaEnumMagicEquipChangeActionType 数据变化行为类型
function LuaMagicEquipmentListData:AnalysisActionType(tblData)
    if tblData == nil then
        return LuaEnumMagicEquipChangeActionType.Null
    end
    if tblData.action == nil or tblData.action == LuaEnumMagicEquipChangeActionType.Null then
        return LuaEnumMagicEquipChangeActionType.Add
    end
    return tblData.action
end

---获取法宝装备物品信息类
---@param equipIndex number 实际装备位
---@return LuaMagicEquipDataItem 法宝装备数据类
function LuaMagicEquipmentListData:GetMagicEquipItemInfo(equipIndex)
    if self.MagicEquipSuitTable == nil or type(self.MagicEquipSuitTable) ~= 'table' then
        self.MagicEquipSuitTable = {}
    end
    local magicEquipDataItemInfo = self.MagicEquipSuitTable[equipIndex]
    if magicEquipDataItemInfo == nil then
        magicEquipDataItemInfo = luaclass.LuaMagicEquipDataItem:New()
        magicEquipDataItemInfo:AnalysisEquipIndex(equipIndex)
        self.MagicEquipSuitTable[equipIndex] = magicEquipDataItemInfo
    end
    return magicEquipDataItemInfo
end

---@return table<bagV2.BagItemInfo>
function LuaMagicEquipmentListData:GetAllEquips()
    if self.MagicEquipSuitTable == nil then
        return nil
    end
    local list = {}
    for i, v in pairs(self.MagicEquipSuitTable) do
        ---@type LuaMagicEquipDataItem
        local magicEquipDataItem = v

        if(magicEquipDataItem.BagItemInfo ~=nil) then
            table.insert(list, magicEquipDataItem.BagItemInfo)
        end
    end
    return list
end

---获取法宝策划配置参数
---@return table 单个套装法宝配置参数
function LuaMagicEquipmentListData:GetMagicEquipConfigParams()
    if self.MagicEquipConfigData == nil then
        self.MagicEquipConfigData = LuaGlobalTableDeal:GetMagicEquipConfigParamsBySuitType(self.MagicEquipSuitType)
    end
    return self.MagicEquipConfigData
end

---获取套装最大件数
---@return number 套装最大数量
function LuaMagicEquipmentListData:GetSuitMaxCount()
    if self.MagicEquipConfigData ~= nil then
        return self.MagicEquipConfigData.suitCount
    end
end

---获取穿的套装的数量
---@return number 当前身上的装备数量
function LuaMagicEquipmentListData:GetEquipCount()
    if self.MagicEquipSuitTable ~= nil then
        local count = 0
        for k,v in pairs(self.MagicEquipSuitTable) do
            if v ~= nil and v.BagItemInfo ~= nil then
                count = count + 1
            end
        end
        return count
    end
    return 0
end

---通过套装等级获取当前身上同类型且同等级的数量
---@param suitType LuaEnumMagicEquipSuitType 法宝套装类型
---@return number 装备数量
function LuaMagicEquipmentListData:GetSuitCountBySuitLevel(suitType,level)
    if suitType == nil or level == nil or self.MagicEquipSuitTable == nil or type(self.MagicEquipSuitTable) ~= 'table' then
        return 0
    end
    local count = 0
    for k,v in pairs(self.MagicEquipSuitTable) do
        if v ~= nil and v.BagItemInfo ~= nil and v.suitType == suitType and level <= v:GetItemLevel() then
            count = count + 1
        end
    end
    return count
end

---获取身上最低的品阶的法宝装备信息类
---@return LuaMagicEquipDataItem 法宝装备信息类
function LuaMagicEquipmentListData:GetBodyLowItemData()
    if self.IsInit == false or self.MagicEquipSuitTable == nil or type(self.MagicEquipSuitTable) ~= 'table' then
        return
    end
    ---@type LuaMagicEquipDataItem
    local lowEquipItemData = nil
    for k,v in pairs(self.MagicEquipSuitTable) do
        if v ~= nil and v.BagItemInfo ~= nil and (lowEquipItemData == nil or v:GetEquipLevel() < lowEquipItemData:GetEquipLevel()) then
            lowEquipItemData = v
        end
    end
    ---如果当前身上没有任何装备，则取第一个装备信息
    if lowEquipItemData == nil then
        local equipIndex = clientTableManager.cfg_magicweaponManager:GetEquipIndexBySuitType(self.MagicEquipSuitType,1)
        lowEquipItemData = self:GetMagicEquipItemInfo(equipIndex)
    end
    return lowEquipItemData
end

---获取身上最低的品阶
---@return number 最低的品阶
function LuaMagicEquipmentListData:GetBodyLowLevel()
    if self.IsInit == false or self:GetEquipCount() <= 0 or self:IsCompleteSuit() == false then
        return 0
    end
    local level = 99
    for k,v in pairs(self.MagicEquipSuitTable) do
        if v ~= nil and v:GetEquipLevel() < level then
            level = v:GetEquipLevel()
        end
    end
    return level
end


---获取物品信息面板额外属性描述
---@param career LuaEnumCareer
---@return string 描述内容
function LuaMagicEquipmentListData:GetItemInfoExtraAttributeDes(career)
    local isCompleteSuit = self:IsCompleteSuit()
    local lowEquipItemData = self:GetBodyLowItemData()
    if lowEquipItemData == nil or lowEquipItemData.magicEquipSuitTableInfo == nil then
        return ""
    end
    local attributeDes = ""
    if isCompleteSuit == false then
        local baseSuitId = LuaGlobalTableDeal:GetBaseSuitId(self.MagicEquipSuitType)
        if baseSuitId ~= nil then
            local baseSuitInfo = clientTableManager.cfg_magicweaponManager:TryGetValue(baseSuitId)
            if baseSuitInfo == nil then
                return
            end
            local skillDes = luaEnumColorType.Gray .. string.format(clientTableManager.cfg_magicweaponManager:GetCurSkillDes(baseSuitInfo:GetId()),self:GetSuitCountBySuitLevel(lowEquipItemData.suitType,1))
            local curAttributeDes = clientTableManager.cfg_magicweaponManager:GetAttributeDes(baseSuitInfo:GetId(),career)
            if CS.StaticUtility.IsNullOrEmpty(curAttributeDes) == false then
                skillDes = skillDes .. '\n' .. luaEnumColorType.Gray .. curAttributeDes
            end
            attributeDes = skillDes
        end
    else
        --当前阶段套装属性
        local nowSuitSkillEffectDes = luaEnumColorType.Green3 .. string.format(clientTableManager.cfg_magicweaponManager:GetCurSkillDes(lowEquipItemData.magicEquipSuitTableInfo:GetId()),self:GetSuitCountBySuitLevel(lowEquipItemData.suitType,lowEquipItemData:GetItemLevel()))
        local nowSuitAttributeDes = clientTableManager.cfg_magicweaponManager:GetAttributeDes(lowEquipItemData.magicEquipSuitTableInfo:GetId(),career)
        if CS.StaticUtility.IsNullOrEmpty(nowSuitAttributeDes) == false then
            nowSuitSkillEffectDes = nowSuitSkillEffectDes .. '\n' .. luaEnumColorType.Green3 .. nowSuitAttributeDes
        end
        --下一阶段套装属性
        local nextSuitDes = ""
        if lowEquipItemData.magicEquipSuitTableInfo:GetNextId() ~= nil and lowEquipItemData.magicEquipSuitTableInfo:GetNextId() > 0 then
            local nextSuitAttributeTableInfo = clientTableManager.cfg_magicweaponManager:TryGetValue(lowEquipItemData.magicEquipSuitTableInfo:GetNextId())
            if nextSuitAttributeTableInfo ~= nil then
                nextSuitDes = luaEnumColorType.Gray .. string.format(clientTableManager.cfg_magicweaponManager:GetCurSkillDes(nextSuitAttributeTableInfo:GetId()),self:GetSuitCountBySuitLevel(nextSuitAttributeTableInfo:GetType(),nextSuitAttributeTableInfo:GetLevel()))
                local nextSuitAttributeDes = clientTableManager.cfg_magicweaponManager:GetAttributeDes(nextSuitAttributeTableInfo:GetId(),career)
                if CS.StaticUtility.IsNullOrEmpty(nextSuitAttributeDes) == false then
                    nextSuitDes = nextSuitDes .. '\n' .. luaEnumColorType.Gray .. nextSuitAttributeDes
                end
            end
        end
        --拼接下一阶段套装属性
        if CS.StaticUtility.IsNullOrEmpty(nextSuitDes) == false then
            nowSuitSkillEffectDes = nowSuitSkillEffectDes .. '\n' .. nextSuitDes
        end
        attributeDes = nowSuitSkillEffectDes
    end
    return attributeDes
end
--endregion
return LuaMagicEquipmentListData