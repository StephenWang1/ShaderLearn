---@class UIItemInfoPanel_Info_ServantEquipBaseAttribute:UIItemInfoPanel_Info_BaseAttribute
local UIItemInfoPanel_Info_ServantEquipBaseAttribute = {}

setmetatable(UIItemInfoPanel_Info_ServantEquipBaseAttribute, luaComponentTemplates.UIItemInfoPanel_Info_BaseAttribute)

--region 固定数据
---更好装备颜色
UIItemInfoPanel_Info_ServantEquipBaseAttribute.mAddColor = "[39ce1b]"
---被对比装备信息
UIItemInfoPanel_Info_ServantEquipBaseAttribute.mCompareEquipInfo = nil


--浮动属性
UIItemInfoPanel_Info_ServantEquipBaseAttribute.rateAttribute = ""
--显示内容
UIItemInfoPanel_Info_ServantEquipBaseAttribute.attributeName = ""
UIItemInfoPanel_Info_ServantEquipBaseAttribute.attributeValue = ""
UIItemInfoPanel_Info_ServantEquipBaseAttribute.showColor = ""
UIItemInfoPanel_Info_ServantEquipBaseAttribute.lowInfo = ""
UIItemInfoPanel_Info_ServantEquipBaseAttribute.highInfo = ""
UIItemInfoPanel_Info_ServantEquipBaseAttribute.addInfo = ""
--更好的装备
UIItemInfoPanel_Info_ServantEquipBaseAttribute.isBetterEquip = false
--endregion

---重置数据
function UIItemInfoPanel_Info_ServantEquipBaseAttribute:ResetInfo()
    --浮动属性
    self.rateAttribute = ""
    --显示内容
    self.attributeName = ""
    self.attributeValue = ""
    self.showColor = ""
    self.lowInfo = ""
    self.highInfo = ""
    self.addInfo = ""
    --更好的装备
    self.isBetterEquip = false
end

---@param bagItemInfo bagV2.BagItemInfo 背包信息
---@param bagItemInfo bagV2.BagItemInfo 与其对比物品信息
---@param itemInfo TABLE.CFG_ITEMS 物品信息
function UIItemInfoPanel_Info_ServantEquipBaseAttribute:RefreshAttributes(bagItemInfo, compareEquip, itemInfo,compareItemInfo)
    if itemInfo == nil then
        return
    end
    local isNeedCompare = false
    ---判断是否需要比较index为0表示没有装备可以比较
    self.mCompareEquipInfo = compareEquip
    if self.mCompareEquipInfo == nil then
        isNeedCompare = false
    else
        isNeedCompare = true
    end

    local bodyServantInfo = nil
    if CS.CSServantInfoV2.IsServantEquip(itemInfo.subType) then
        local servantIndex = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetEquipServantType(itemInfo)
        bodyServantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServentIndexByDic(servantIndex)
    end

    local compareItemInfo = ternary(bagItemInfo == nil,itemInfo,bagItemInfo)

    --region 物理攻击属性
    if itemInfo.phyAttackMin and itemInfo.phyAttackMax then
        self:ResetInfo()
        local minPhyAttack = itemInfo.phyAttackMin
        local maxPhyAttack = itemInfo.phyAttackMax
        local rateMinPhyAttack = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.PhyAttackMin)
        local rateMaxPhyAttack = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.PhyAttackMax)
        --比较更好装备
        if isNeedCompare then

            self.isBetterEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsBetterEquip(compareItemInfo, self.mCompareEquipInfo, LuaEnumAttributeType.PhyAttackMax)
        end
        --显示内容
        if rateMinPhyAttack > 0 or rateMaxPhyAttack > 0 then
            self.showColor = self.mAddColor
            self.lowInfo = tostring(minPhyAttack + rateMinPhyAttack)
            self.highInfo = tostring(maxPhyAttack + rateMaxPhyAttack)
            self.addInfo = "(+" .. tostring(rateMaxPhyAttack) .. ")[-]"
        else
            if minPhyAttack > 0 or maxPhyAttack > 0 then
                self.lowInfo = tostring(minPhyAttack)
                self.highInfo = tostring(maxPhyAttack)
            end
        end
        if CS.StaticUtility.IsNullOrEmpty(self.lowInfo) == false or CS.StaticUtility.IsNullOrEmpty(self.highInfo) == false then
            self.attributeName = self.showColor .. Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)).."[-]"
            self.attributeValue = self.showColor .. self.lowInfo .. '-' .. self.highInfo .. self.addInfo .. ''
            self:AddAttribute(self.attributeName, self.attributeValue, self.isBetterEquip)
        end
    end
    --endregion

    --region 生命
    if itemInfo.maxHp then
        self:ResetInfo()
        local itemMaxHP = itemInfo.maxHp.list[0].list[0]
        local rotaMaxHp = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.MaxHp)
        --比较更好装备
        if isNeedCompare then
            self.isBetterEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsBetterEquip(compareItemInfo, self.mCompareEquipInfo, LuaEnumAttributeType.MaxHp)
        end
        if rotaMaxHp > 0 then
            self.showColor = self.mAddColor
            self.lowInfo = tostring(itemMaxHP + rotaMaxHp)
            self.addInfo = "(+" .. tostring(rotaMaxHp) .. ")[-]"
        else
            if itemMaxHP > 0 then
                self.lowInfo = tostring(itemMaxHP)
            end
        end
        if CS.StaticUtility.IsNullOrEmpty(self.lowInfo) == false or CS.StaticUtility.IsNullOrEmpty(self.addInfo) == false then
            self.attributeName = self.showColor ..Utility.GetAttributeName(LuaEnumAttributeType.MaxHp) .."[-]"
            self.attributeValue = self.showColor .. self.lowInfo .. self.addInfo .. ''
            self:AddAttribute(self.attributeName, self.attributeValue, self.isBetterEquip)
        end
    end
    --endregion

    --region 物理防御属性
    if itemInfo.phyDefenceMin > 0 or itemInfo.phyDefenceMax > 0 then
        self:ResetInfo()
        local minPhyDefence = itemInfo.phyDefenceMin
        local maxPhyDefence = itemInfo.phyDefenceMax
        local rotaMinPhyDefence = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.PhyDefenceMin)
        local rotaMaxPhyDefence = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.PhyDefenceMax)
        --比较更好装备
        if isNeedCompare then
            self.isBetterEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsBetterEquip(compareItemInfo, self.mCompareEquipInfo, LuaEnumAttributeType.PhyDefenceMax)
        end
        if rotaMinPhyDefence > 0 or rotaMaxPhyDefence > 0 then
            self.showColor = self.mAddColor
            self.lowInfo = tostring(minPhyDefence + rotaMinPhyDefence)
            self.highInfo = tostring(maxPhyDefence + rotaMaxPhyDefence)
            self.addInfo = "(+" .. tostring(rotaMaxPhyDefence) .. ")[-]"
        else
            if minPhyDefence > 0 or maxPhyDefence > 0 then
                self.lowInfo = tostring(minPhyDefence)
                self.highInfo = tostring(maxPhyDefence)
            end
        end
        if CS.StaticUtility.IsNullOrEmpty(self.lowInfo) == false or CS.StaticUtility.IsNullOrEmpty(self.highInfo) == false then
            self.attributeName = self.showColor .. "防御[-]"
            self.attributeValue = self.showColor .. self.lowInfo .. '-' .. self.highInfo .. self.addInfo .. ''
            self:AddAttribute(self.attributeName, self.attributeValue, self.isBetterEquip)
        end
    end
    --endregion

    --region 法术防御属性
    if (itemInfo.magicDefenceMin > 0) or (itemInfo.magicDefenceMax > 0) then
        self:ResetInfo()
        local minMagicDefence = itemInfo.magicDefenceMin
        local maxMagicDefence = itemInfo.magicDefenceMax
        local rotaMinMagicDefence = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.MagicDefenceMin)
        local rotaMaxMagicDefence = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.MagicDefenceMax)
        --比较更好装备
        if isNeedCompare then
            self.isBetterEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsBetterEquip(compareItemInfo, self.mCompareEquipInfo, LuaEnumAttributeType.MagicDefenceMax)
        end
        if rotaMinMagicDefence > 0 or rotaMaxMagicDefence > 0 then
            self.showColor = self.mAddColor
            self.lowInfo = tostring(minMagicDefence + rotaMinMagicDefence)
            self.highInfo = tostring(maxMagicDefence + rotaMaxMagicDefence)
            self.addInfo = "(+" .. tostring(rotaMaxMagicDefence) .. ")[-]"
        else
            if minMagicDefence > 0 or maxMagicDefence > 0 then
                self.lowInfo = tostring(minMagicDefence)
                self.highInfo = tostring(maxMagicDefence)
            end
        end
        if CS.StaticUtility.IsNullOrEmpty(self.lowInfo) == false or CS.StaticUtility.IsNullOrEmpty(self.highInfo) == false then
            self.attributeName = self.showColor .. "魔防[-]"
            self.attributeValue = self.showColor .. self.lowInfo .. '-' .. self.highInfo .. self.addInfo .. ''
            self:AddAttribute(self.attributeName, self.attributeValue, self.isBetterEquip)
        end
    end
    --endregion

    --region 神圣攻击
    if (itemInfo.holyAttackMax and itemInfo.holyAttackMax > 0) or (itemInfo.holyAttackMin and itemInfo.holyAttackMin > 0) then
        self:ResetInfo()
        local rotaHolyAttack = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.HolyAttackMax)
        --比较更好装备
        if isNeedCompare then
            local isBetterHolyAttackMin = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsBetterEquip(compareItemInfo, self.mCompareEquipInfo, LuaEnumAttributeType.HolyAttackMin)
            local isBetterHolyAttackMax = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsBetterEquip(compareItemInfo, self.mCompareEquipInfo, LuaEnumAttributeType.HolyAttackMax)
            self.isBetterEquip = isBetterHolyAttackMin or isBetterHolyAttackMax
        end
        if rotaHolyAttack > 0 then
            self.showColor = self.mAddColor
            self.lowInfo = tostring(itemInfo.holyAttackMin)
            self.highInfo = tostring(itemInfo.holyAttackMax + rotaHolyAttack)
            self.addInfo = "(+" .. tostring(rotaHolyAttack) .. ")[-]"
        else
            self.lowInfo = tostring(itemInfo.holyAttackMin)
            self.highInfo = tostring(itemInfo.holyAttackMax)
        end
        if CS.StaticUtility.IsNullOrEmpty(self.lowInfo) == false or CS.StaticUtility.IsNullOrEmpty(self.highInfo) == false then
            self.attributeName = self.showColor .. Utility.GetAttributeName(LuaEnumAttributeType.HolyAttackMax) .. "[-]"
            self.attributeValue = self.showColor .. self.lowInfo .. "-" .. self.highInfo .. self.addInfo .. ''
            self:AddAttribute(self.attributeName, self.attributeValue, self.isBetterEquip)
        end
    end
    --endregion

    --region 神圣防御
    if (itemInfo.holyDefenceMin and itemInfo.holyDefenceMin > 0) or (itemInfo.holyDefenceMax and itemInfo.holyDefenceMax > 0) then
        self:ResetInfo()
        local rotaHolyDefence = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.HolyDefenceMax)
        --比较更好装备
        if isNeedCompare then
            local isBetterHolyDefenceMin = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsBetterEquip(compareItemInfo, self.mCompareEquipInfo, LuaEnumAttributeType.HolyDefenceMin)
            local isBetterHolyAttackMax = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsBetterEquip(compareItemInfo, self.mCompareEquipInfo, LuaEnumAttributeType.HolyDefenceMax)
            self.isBetterEquip = isBetterHolyDefenceMin or isBetterHolyAttackMax
        end
        if rotaHolyDefence > 0 then
            self.showColor = self.mAddColor
            self.lowInfo = itemInfo.holyDefenceMin
            self.highInfo = itemInfo.holyDefenceMax + rotaHolyDefence
            self.addInfo = "(+" .. rotaHolyDefence .. ")[-]"
        else
            self.lowInfo = itemInfo.holyDefenceMin
            self.highInfo = itemInfo.holyDefenceMax
        end
        if CS.StaticUtility.IsNullOrEmpty(self.lowInfo) == false or CS.StaticUtility.IsNullOrEmpty(self.highInfo) == false then
            self.attributeName = self.showColor .. Utility.GetAttributeName(LuaEnumAttributeType.HolyDefenceMax) .. "[-]"
            self.attributeValue = self.showColor .. self.lowInfo .. "-" .. self.highInfo .. self.addInfo .. ''
            self:AddAttribute(self.attributeName, self.attributeValue, self.isBetterEquip)
        end
    end
    --endregion

    --region 使用等级
    if ((itemInfo.useLv and itemInfo.useLv > 0) or (itemInfo.reinLv and itemInfo.reinLv > 0)) and itemInfo.type == luaEnumItemType.Equip then
        local useLevelColor = nil
        if bodyServantInfo == nil then
            useLevelColor = Utility.NewGetBBCode(false)
        else
            useLevelColor = Utility.NewGetBBCode(clientTableManager.cfg_itemsManager:CanUseItem(itemInfo.id, bodyServantInfo.level, bodyServantInfo.rein) == LuaEnumUseItemParam.CanUse)
            --useLevelColor = Utility.NewGetBBCode((bodyServantInfo.level >= itemInfo.useLv) and (bodyServantInfo.rein >= itemInfo.reinLv))
        end
        local useLevel = ternary(itemInfo.reinLv > 0, tostring(itemInfo.reinLv), tostring(itemInfo.useLv))
        --local attributeName = ternary(itemInfo.reinLv > 0, "需要灵兽转生", "需要灵兽等级")
        --self:AddAttribute(useLevelColor .. attributeName .. "", useLevelColor .. useLevel .. "", false)
        self:AddAttribute(useLevelColor .. "", useLevelColor .. useLevel .. "", false)
    end
    --endregion
end

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_ServantEquipBaseAttribute:RefreshWithInfo(commonData)
    local bagItemInfo = commonData.bagItemInfo
    local compareEquip = commonData.compareEquip
    local itemInfo = commonData.itemInfo
    self:ClearAttributeData()
    if itemInfo ~= nil then
        self:RefreshAttributes(bagItemInfo, compareEquip, itemInfo)
    end
    self:ShowAttribute(itemInfo)
end

return UIItemInfoPanel_Info_ServantEquipBaseAttribute