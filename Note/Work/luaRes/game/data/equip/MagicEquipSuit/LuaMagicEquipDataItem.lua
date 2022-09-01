---@class LuaMagicEquipDataItem 法宝装备数据类
local LuaMagicEquipDataItem = {}
--region 数据
---@type bagV2.BagItemInfo 背包物品数据
LuaMagicEquipDataItem.BagItemInfo = nil
---@type TABLE.CFG_ITEMS 物品表信息数据
LuaMagicEquipDataItem.ItemInfo = nil
---@type number 装备位
LuaMagicEquipDataItem.EquipIndex = nil
---@type TABLE.cfg_magicweapon 法宝套装表
LuaMagicEquipDataItem.magicEquipSuitTableInfo = nil
---@type LuaEnumMagicEquipSuitType 法宝套装类型
LuaMagicEquipDataItem.suitType = nil
---@type table 策划套装表数据
LuaMagicEquipDataItem.suitConfigTableInfo = nil
--endregion

--region 刷新
---刷新法宝装备数据类
---@param tblData bagV2.BagItemInfo 背包物品数据
---@param equipIndex number 装备位
function LuaMagicEquipDataItem:RefreshMagicEquipItem(tblData,equipIndex)
    if tblData == nil then
        self:ClearParams()
        self:AnalysisEquipIndex(equipIndex)
        return
    end
    self.BagItemInfo = tblData
    self.ItemInfo = self.BagItemInfo.ItemTABLE
    if self.ItemInfo == nil then
        self.ItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(self.BagItemInfo.itemId)
    end
    if self.ItemInfo == nil then
        return
    end
    self.EquipIndex = clientTableManager.cfg_itemsManager:GetMagicEquipEquipIndex(self.ItemInfo.id)
    self.magicEquipSuitTableInfo = clientTableManager.cfg_itemsManager:GetMagicEquipSuitInfo(self.ItemInfo.id)
    if self.magicEquipSuitTableInfo ~= nil then
        self.suitType = self.magicEquipSuitTableInfo:GetType()
    end
    if self.suitType ~= nil then
        self.suitConfigTableInfo = LuaGlobalTableDeal:GetMagicEquipConfigParamsBySuitType(self.suitType)
    end
end

---解析装备位
---@param equipIndex number 装备位
function LuaMagicEquipDataItem:AnalysisEquipIndex(equipIndex)
    if equipIndex ~= nil then
        local suitType = clientTableManager.cfg_magicweaponManager:AnalysisTypeByEquipIndex(equipIndex)
        self.EquipIndex = equipIndex
        if suitType ~= nil then
            self.suitConfigTableInfo = LuaGlobalTableDeal:GetMagicEquipConfigParamsBySuitType(suitType)
            self.suitType = suitType
            if self.ItemInfo ~= nil then
                self.magicEquipSuitTableInfo = clientTableManager.cfg_itemsManager:GetMagicEquipSuitInfo(self.ItemInfo.id)
            else
                self.magicEquipSuitTableInfo = clientTableManager.cfg_magicweaponManager:GetDefaultLowSuitInfo(suitType)
            end
        end
    end
end

---数据清理
function LuaMagicEquipDataItem:ClearParams()
    self.BagItemInfo = nil
    self.ItemInfo = nil
    self.EquipIndex = nil
    self.magicEquipSuitTableInfo = nil
    self.suitType = nil
    self.suitConfigTableInfo = nil
end
--endregion

--region 获取
---获取装备品阶
---@return number 品阶等级
function LuaMagicEquipDataItem:GetEquipLevel()
    if self.magicEquipSuitTableInfo ~= nil then
        return self.magicEquipSuitTableInfo:GetLevel()
    end
    return 1
end
--endregion

--region 查询
---装备位是否有装备
---@return boolean
function LuaMagicEquipDataItem:EquipIndexHaveItem()
    return self.BagItemInfo ~= nil
end
--endregion

--region 获取
---通过背包数据获取可使用的最好的装备
function LuaMagicEquipDataItem:GetBestItemByBag()
    return luaclass.BagBetterMagicEquip:GetBagBetterMagicEquip(self.EquipIndex)
end

---获取物品底图图片名字
---@return string 底图图片名
function LuaMagicEquipDataItem:GetItemBaseSprite()
    if self.suitConfigTableInfo ~= nil and self.suitConfigTableInfo.backGroundSpriteNameTable ~= nil and type(self.suitConfigTableInfo.backGroundSpriteNameTable) == 'table' then
        local baseEquipIndex = clientTableManager.cfg_magicweaponManager:GetBaseEquipIndexByEquipIndex(self.EquipIndex)
        return self.suitConfigTableInfo.backGroundSpriteNameTable[baseEquipIndex]
    end
end

---获取装备品阶
---@return number 品阶
function LuaMagicEquipDataItem:GetItemLevel()
    if self.BagItemInfo ~= nil and self.magicEquipSuitTableInfo ~= nil then
        return self.magicEquipSuitTableInfo:GetLevel()
    end
    return 0
end
--endregion

return LuaMagicEquipDataItem