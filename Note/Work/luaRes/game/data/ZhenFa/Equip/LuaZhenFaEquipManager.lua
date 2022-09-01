---@class LuaZhenFaEquipManager:luaobject 阵法装备管理类
local LuaZhenFaEquipManager = {}

--region 数据
---@type LuaZhenFaInfo 当前阵法数据
LuaZhenFaEquipManager.ZhenFaInfo = nil
---@type table<LuaEnumPlayerEquipIndex,LuaZhenFaEquip> 阵法装备列表
LuaZhenFaEquipManager.ZhenFaEquipList = nil
--endregion

--region 数据刷新
---刷新装备列表
---@param equipList table<equipV2.EquipsChange> 装备列表
function LuaZhenFaEquipManager:RefreshZhenFaEquipList(equipList)
    if type(equipList) ~= 'table' or Utility.GetLuaTableCount(equipList) <= 0 then
        self:ClearEquipList()
        return
    end
    for k,v in pairs(equipList) do
        self:RefreshZhenFaEquip(v)
    end
end

---通过背包物品列表刷新装备列表
---@param bagItemInfoList table<bagV2.BagItemInfo> 背包物品列表
function LuaZhenFaEquipManager:RefreshZhenFaEquipListByBagItemInfoList(bagItemInfoList)
    if type(bagItemInfoList) ~= 'table' or Utility.GetLuaTableCount(bagItemInfoList) <= 0 then
        self:ClearEquipList()
        return
    end
    for k,v in pairs(bagItemInfoList) do
        self:RefreshZhenFaEquipByBagItemInfo(v)
    end
end

---刷新装备信息
---@param equipInfo equipV2.EquipsChange 装备信息
function LuaZhenFaEquipManager:RefreshZhenFaEquip(equipInfo)
    if type(equipInfo) ~= 'table' or type(equipInfo.equipIndex) ~= 'number' or self:IsZhenFaEquipIndex(equipInfo.equipIndex) == false then
        return
    end
    local zhenFaEquipInfo = self:GetZhenFaEquipInfoByEquipIndex(equipInfo.equipIndex)
    zhenFaEquipInfo:RefreshZhenFaEquip(equipInfo)
end

---通过背包物品信息刷新阵法装备
---@param bagItemInfo bagV2.BagItemInfo
function LuaZhenFaEquipManager:RefreshZhenFaEquipByBagItemInfo(bagItemInfo)
    if bagItemInfo == nil or bagItemInfo.itemId == nil then
        return
    end
    local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    if itemInfo == nil or self:IsZhenFaEquipIndex(itemInfo:GetSubType()) == false then
        return
    end
    local equipIndex = itemInfo:GetSubType()
    local zhenFaEquipInfo = self:GetZhenFaEquipInfoByEquipIndex(equipIndex)
    zhenFaEquipInfo:RefreshZhenFaEquip({changeEquip = bagItemInfo})
end

---清理装备数据
function LuaZhenFaEquipManager:ClearEquipList()
    if type(self.ZhenFaEquipList) ~= 'table' then
        return
    end
    for k,v in pairs(self.ZhenFaEquipList) do
        ---@type LuaZhenFaEquip
        local zhenFaEquipInfo = v
        zhenFaEquipInfo:ClearZhenFaEquip()
    end
end

---阵法数据更新
function LuaZhenFaEquipManager:ZhenFaInfoChange()
    self.ZhenFaInfo = gameMgr:GetPlayerDataMgr():GetZhenFaManager():GetZhenFaInfo()
    ---刷新装备位解锁状态
    self:ResetZhenFaEquipListUnlockState()
    local unLockZhenFaEquipIndexList = self.ZhenFaInfo:GetUnLockedEquipIndex()
    if type(unLockZhenFaEquipIndexList) == 'table' then
        for k,v in pairs(unLockZhenFaEquipIndexList) do
            local zhenFaEquipInfo = self:GetZhenFaEquipInfoByEquipIndex(v)
            if zhenFaEquipInfo ~= nil then
                zhenFaEquipInfo:SetUnLockState(true)
            end
        end
    end
end

---重置阵法装备解锁状态
function LuaZhenFaEquipManager:ResetZhenFaEquipListUnlockState()
    if type(self.ZhenFaEquipList) ~= 'table' then
        return
    end
    for k,v in pairs(self.ZhenFaEquipList) do
        ---@type LuaZhenFaEquip
        local equipInfo = v
        equipInfo:SetUnLockState(false)
    end
end
--endregion

--region 查询
---是否是阵法装备位
---@param equipIndex LuaEnumPlayerEquipIndex
---@return boolean
function LuaZhenFaEquipManager:IsZhenFaEquipIndex(equipIndex)
    return LuaGlobalTableDeal:IsConfigZhenFaEquipIndex(equipIndex)
end

---是否比身上的法阵装备好
---@param itemId number
---@return boolean
function LuaZhenFaEquipManager:IsBetterThanBodyEquip(itemId)

end

---装备位是否解锁
---@param equipIndex LuaEnumPlayerEquipIndex
---@return boolean
function LuaZhenFaEquipManager:EquipIndexIsUnlock(equipIndex)
    if type(self.ZhenFaEquipList) ~= 'table' then
        return false
    end
    for k,v in pairs(self.ZhenFaEquipList) do
        ---@type LuaZhenFaEquip
        local equipInfo = v
        if equipInfo.equipIndex == equipIndex then
            return equipInfo.unLockState
        end
    end
    return false
end
--endregion

--region 获取
---获取阵法信息类
---@param equipIndex LuaEnumPlayerEquipIndex
---@return LuaZhenFaEquip
function LuaZhenFaEquipManager:GetZhenFaEquipInfoByEquipIndex(equipIndex)
    if type(equipIndex) ~= 'number' then
        return
    end
    if type(self.ZhenFaEquipList) ~= 'table' then
        self.ZhenFaEquipList = {}
    end
    local zhenFaEquipInfo = self.ZhenFaEquipList[equipIndex]
    if zhenFaEquipInfo == nil then
        zhenFaEquipInfo = luaclass.LuaZhenFaEquip:New()
        zhenFaEquipInfo.equipIndex = equipIndex
        zhenFaEquipInfo.unLockState = false
        self.ZhenFaEquipList[equipIndex] = zhenFaEquipInfo
    end
    return zhenFaEquipInfo
end

---获取阵法装备信息列表
---@param itemInfo TABLE.cfg_items
---@return table<TABLE.cfg_items>
function LuaZhenFaEquipManager:GetZhenFaEquipItemInfoList(itemId)
    local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    local itemInfoList = {}
    if itemInfo ~= nil then
        table.insert(itemInfoList,itemInfo)
    end
    if type(self.ZhenFaEquipList) ~= 'table' or Utility.GetLuaTableCount(self.ZhenFaEquipList) <= 0 then
        return itemInfoList
    end
    for k,v in pairs(self.ZhenFaEquipList) do
        ---@type LuaZhenFaEquip
        local zhenFaEquipInfo = v
        if zhenFaEquipInfo.itemInfo ~= nil and (itemInfo == nil or itemInfo:GetType() ~= zhenFaEquipInfo.itemInfo:GetType() or itemInfo:GetSubType() ~= zhenFaEquipInfo.itemInfo:GetSubType()) then
            table.insert(itemInfoList,zhenFaEquipInfo.itemInfo)
        end
    end
    return itemInfoList
end

---获取同类型的阵法装备
---@param itemId number
---@return bagV2.BagItemInfo
function LuaZhenFaEquipManager:GetSameTypeZhenFaEquip(itemId)
    local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemInfo == nil or type(self.ZhenFaEquipList) ~= 'table' or Utility.GetLuaTableCount(self.ZhenFaEquipList) <= 0 then
        return
    end
    for k,v in pairs(self.ZhenFaEquipList) do
        ---@type LuaZhenFaEquip
        local zhenFaEquipInfo = v
        if zhenFaEquipInfo.itemInfo ~= nil and zhenFaEquipInfo.itemInfo:GetType() == itemInfo:GetType() and zhenFaEquipInfo.itemInfo:GetSubType() == itemInfo:GetSubType() then
            return zhenFaEquipInfo.bagItemInfo
        end
    end
end
--endregion

return LuaZhenFaEquipManager