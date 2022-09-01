---@class LuaSingleServantEquipInfo 单个灵兽数据
local LuaSingleServantEquipInfo = {}

---@type table<number,bagV2.BagItemInfo> 单个灵兽装备字典，装备位对应的装备字典
LuaSingleServantEquipInfo.mEquipIndexToEquipDic = nil

---@type table<number,bagV2.BagItemInfo> 单个灵兽装备字典，装备唯一id对应的装备字典
LuaSingleServantEquipInfo.mLidToEquipDic = nil

---@type table<number, bagV2.BagItemInfo> 本灵兽身上所有装备列表
LuaSingleServantEquipInfo.mAllEquipList = nil

---@type luaEnumServantType 灵兽类型
LuaSingleServantEquipInfo.mServantType = nil

---存储单个灵兽装备列表
---@param equipList table<number, bagV2.BagItemInfo> 装备
function LuaSingleServantEquipInfo:SaveSingleEquipData(servantType, equipList)
    self.mServantType = servantType
    self.mEquipIndexToEquipDic = {}
    self.mLidToEquipDic = {}
    self.mAllEquipList = equipList
    for i = 1, #equipList do
        ---@type bagV2.BagItemInfo
        local equip = equipList[i]
        self:AddSingleEquip(equip)
    end
end

---刷新单个装备
---@param  equip bagV2.BagItemInfo
function LuaSingleServantEquipInfo:AddSingleEquip(equip)
    if equip == nil then
        return
    end

    if self.mEquipIndexToEquipDic == nil then
        self.mEquipIndexToEquipDic = {}
    end
    if self.mLidToEquipDic == nil then
        self.mLidToEquipDic = {}
    end
    self.mEquipIndexToEquipDic[equip.index] = equip
    self.mLidToEquipDic[equip.lid] = equip
end

---根据装备Lid移除单个装备
---@return boolean 是否移除成功
function LuaSingleServantEquipInfo:RemoveSingleEquipByLid(lid)
    local equip = self:GetSingleEquipByLid(lid)
    if equip then
        self.mEquipIndexToEquipDic[equip.index] = nil
        self.mLidToEquipDic[equip.lid] = nil
        return true
    end
    return false
end

---@param index number 装备位
---@param equip bagV2.BagItemInfo 更新的装备
function LuaSingleServantEquipInfo:RefreshSingleEquipByEquipIndex(index, newEquip)
    local equip = self:GetSingleEquipByEquipIndex(index)
    if equip then
        self.mLidToEquipDic[equip.lid] = nil
    end
    self.mEquipIndexToEquipDic[newEquip.index] = newEquip
    self.mLidToEquipDic[newEquip.lid] = newEquip
end


--region 获取数据
---@return bagV2.BagItemInfo 根据装备位获得装备
function LuaSingleServantEquipInfo:GetSingleEquipByEquipIndex(index)
    if self.mEquipIndexToEquipDic == nil then
        return
    end
    return self.mEquipIndexToEquipDic[index]
end

---@return bagV2.BagItemInfo 根据装备Lid获得装备
function LuaSingleServantEquipInfo:GetSingleEquipByLid(lid)
    if self.mLidToEquipDic == nil then
        self.mLidToEquipDic = {}
    end
    return self.mLidToEquipDic[lid]
end

---返回装备的装备位
---@alias index number 装备位
---@return table<number,index>
function LuaSingleServantEquipInfo:GetAllEquipIndex()
    if self.mServantAllEquipIndex == nil and self.mServantType then
        local equipIndexList = {}
        local servantType = self.mServantType
        local neckIndex = servantType * 1000 + 200 + 1
        local leftRingIndex = servantType * 1000 + 200 + 2
        local rightRingIndex = servantType * 1000 + 200 + 2 + 10
        local leftCuffIndex = servantType * 1000 + 200 + 3
        local rightCuffIndex = servantType * 1000 + 200 + 3 + 10
        local bultIndex = servantType * 1000 + 200 + 4
        local shoesIndex = servantType * 1000 + 200 + 5
        local magicWeaponIndex = servantType * 1000 + 6;
        table.insert(equipIndexList, neckIndex)
        table.insert(equipIndexList, leftRingIndex)
        table.insert(equipIndexList, rightRingIndex)
        table.insert(equipIndexList, leftCuffIndex)
        table.insert(equipIndexList, rightCuffIndex)
        table.insert(equipIndexList, bultIndex)
        table.insert(equipIndexList, shoesIndex)
        table.insert(equipIndexList, magicWeaponIndex)
        self.mServantAllEquipIndex = equipIndexList
    end
    return self.mServantAllEquipIndex
end

---通过物品子类型获取装备列表
---@param subType LuaEnumEquipSubType
---@return table<bagV2.BagItemInfo>
function LuaSingleServantEquipInfo:GetEquipTableBySubtype(subType)
    local bagItemInfoTable = {}
    if type(self.mAllEquipList) == 'table' then
        for k,v in pairs(self.mAllEquipList) do
            ---@type bagV2.BagItemInfo
            local bagItemInfo = v
            local itemInfo = Utility.GetItemTblByBagItemInfo(bagItemInfo)
            if itemInfo ~= nil and itemInfo:GetSubType() == subType then
                table.insert(bagItemInfoTable,bagItemInfo)
            end
        end
    end
    return bagItemInfoTable
end

---获取同subType灵兽身上的最弱的装备
---@param subType LuaEnumEquipSubType
---@return bagV2.BagItemInfo
function LuaSingleServantEquipInfo:GetServantLowEquipBySubType(subType)
    local bagItemInfoTable = self:GetEquipTableBySubtype(subType)
    if type(bagItemInfoTable) ~= 'table' or Utility.GetLuaTableCount(bagItemInfoTable) <= 0 then
        return
    end
    ---@type bagV2.BagItemInfo
    local lowEquip = nil
    for k,v in pairs(bagItemInfoTable)do
        if lowEquip == nil or Utility.CompareServantEquip(lowEquip,v) == 1 then
            lowEquip = v
        end
    end
    return lowEquip
end

---获取灵兽装备位
---@param equipIndexType LuaEnumServantEquipIndexType
---@return LuaEnumServantEquipIndex
function LuaSingleServantEquipInfo:GetServantEquipIndex(equipIndexType)
    if equipIndexType == nil then
        return -1
    end
    local extraAddValue = 200
    if equipIndexType == LuaEnumServantEquipIndexType.MagicEquip then
        extraAddValue = 0
    end
    return self.mServantType * 1000 + extraAddValue +  equipIndexType
end

---通过装备位类型获取装备
---@param equipIndexType LuaEnumServantEquipIndexType
---@return bagV2.BagItemInfo
function LuaSingleServantEquipInfo:GetEquipByEquipIndexType(equipIndexType)
    local equipIndex = self:GetServantEquipIndex(equipIndexType)
    if equipIndex < 0 then
        return
    end
    return self:GetSingleEquipByEquipIndex(equipIndex)
end
--endregion

return LuaSingleServantEquipInfo