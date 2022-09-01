---@class UIItemInfoPanel_Info_ServantBodyBaseAttribute:UIItemInfoPanel_Info_BaseAttribute
local UIItemInfoPanel_Info_ServantBodyBaseAttribute = {}

setmetatable(UIItemInfoPanel_Info_ServantBodyBaseAttribute, luaComponentTemplates.UIItemInfoPanel_Info_BaseAttribute)

--region 固定数据
---更好装备颜色
UIItemInfoPanel_Info_ServantBodyBaseAttribute.mAddColor = "[39ce1b]"
---被对比装备信息
UIItemInfoPanel_Info_ServantBodyBaseAttribute.mCompareEquipInfo = nil


--浮动属性
UIItemInfoPanel_Info_ServantBodyBaseAttribute.rateAttribute = ""
--显示内容
UIItemInfoPanel_Info_ServantBodyBaseAttribute.attributeName = ""
UIItemInfoPanel_Info_ServantBodyBaseAttribute.attributeValue = ""
UIItemInfoPanel_Info_ServantBodyBaseAttribute.showColor = ""
UIItemInfoPanel_Info_ServantBodyBaseAttribute.lowInfo = ""
UIItemInfoPanel_Info_ServantBodyBaseAttribute.highInfo = ""
UIItemInfoPanel_Info_ServantBodyBaseAttribute.addInfo = ""
--更好的装备
UIItemInfoPanel_Info_ServantBodyBaseAttribute.isBetterEquip = false
--endregion

---重置数据
function UIItemInfoPanel_Info_ServantBodyBaseAttribute:ResetInfo()
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
function UIItemInfoPanel_Info_ServantBodyBaseAttribute:RefreshAttributes(bagItemInfo, itemInfo, compareEquip, curCompareItemInfo)
    if itemInfo == nil or itemInfo.useParam == nil then
        return
    end
    local res, servantInfo = CS.Cfg_ServantTableManager.Instance.dic:TryGetValue(tonumber(itemInfo.useParam.list[0]))
    if res then
        local isNeedCompare = false
        ---判断是否需要比较index为0表示没有装备可以比较
        self.mCompareEquipInfo = compareEquip
        if self.mCompareEquipInfo == nil then
            isNeedCompare = false
        else
            isNeedCompare = true
        end

        local bodyServantInfo = nil
        if uimanager:GetPanel("UIServantPanel") ~= nil then
            bodyServantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServentIndexByDic(uiStaticParameter.SelectedServantType)
        else
            if compareEquip ~= nil then
                bodyServantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantInfoByEquipLid(compareEquip.lid)
            else
                bodyServantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantInfoByBodyEquip(bagItemInfo)
            end
        end

        local compareItemInfo = ternary(bagItemInfo == nil, servantInfo, bagItemInfo)

        --region 物理攻击属性
        self:ResetInfo()
        local mPhyAttack = servantInfo.attackQualifications
        local rateMaxPhyAttack = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.PhyAttackMax)
        --比较更好装备
        if isNeedCompare then
            self.isBetterEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsBetterBodyEquip(compareItemInfo, self.mCompareEquipInfo, LuaEnumAttributeType.PhyAttackMax)
        end
        --显示内容
        self.highInfo = ternary(rateMaxPhyAttack > 0, string.format("%g", rateMaxPhyAttack / 10), string.format("%g", mPhyAttack / 10))
        if rateMaxPhyAttack - mPhyAttack > 0 then
            self.showColor = self.mAddColor
            self.addInfo = "(+" .. (rateMaxPhyAttack - mPhyAttack) / 10 .. ")[-]"
        end
        self.attributeName = self.showColor .. Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)) .. "[-]"
        self.attributeValue = self.showColor .. self.highInfo .. self.addInfo .. ''
        if (CS.StaticUtility.IsNullOrEmpty(self.addInfo) == false and mPhyAttack >= 0) or mPhyAttack > 0 then
            self:AddAttribute(self.attributeName, self.attributeValue, self.isBetterEquip)
        end
        --endregion

        --region 生命
        self:ResetInfo()
        local mMaxHP = servantInfo.hpQualifications
        local rotaMaxHp = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.MaxHp)
        --比较更好装备
        if isNeedCompare then
            self.isBetterEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsBetterBodyEquip(compareItemInfo, self.mCompareEquipInfo, LuaEnumAttributeType.MaxHp)
        end
        self.lowInfo = ternary(rotaMaxHp > 0, string.format("%g", rotaMaxHp / 10), string.format("%g", mMaxHP / 10))
        if rotaMaxHp - mMaxHP > 0 then
            self.showColor = self.mAddColor
            self.addInfo = "(+" .. (rotaMaxHp - mMaxHP) / 10 .. ")[-]"
        end
        self.attributeName = self.showColor .. Utility.GetAttributeName(LuaEnumAttributeType.MaxHp) .. "[-]"
        self.attributeValue = self.showColor .. self.lowInfo .. self.addInfo .. ''
        if (CS.StaticUtility.IsNullOrEmpty(self.addInfo) == false and mMaxHP >= 0) or mMaxHP > 0 then
            self:AddAttribute(self.attributeName, self.attributeValue, self.isBetterEquip)
        end
        --endregion

        --region 物理防御属性

        self:ResetInfo()
        local mPhyDefence = servantInfo.phyDefenceQualifications
        local rotaMaxPhyDefence = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.PhyDefenceMax)
        --比较更好装备
        if isNeedCompare then
            self.isBetterEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsBetterBodyEquip(compareItemInfo, self.mCompareEquipInfo, LuaEnumAttributeType.PhyDefenceMax)
        end
        self.highInfo = ternary(rotaMaxPhyDefence > 0, string.format("%g", rotaMaxPhyDefence / 10), string.format("%g", mPhyDefence / 10))
        if rotaMaxPhyDefence - mPhyDefence > 0 then
            self.addInfo = "(+" .. (rotaMaxPhyDefence - mPhyDefence) / 10 .. ")[-]"
            self.showColor = self.mAddColor
        end
        self.attributeName = self.showColor .. "防御[-]"
        self.attributeValue = self.showColor .. self.highInfo .. self.addInfo .. ''
        if (CS.StaticUtility.IsNullOrEmpty(self.addInfo) == false and mPhyDefence >= 0) or mPhyDefence > 0 then
            self:AddAttribute(self.attributeName, self.attributeValue, self.isBetterEquip)
        end
        --endregion

        --region 法术防御属性
        self:ResetInfo()
        local mMagicDefence = servantInfo.magicDefenceQualifications
        local rotaMaxMagicDefence = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.MagicDefenceMax)
        if rotaMaxMagicDefence ~= nil then
            --比较更好装备
            if isNeedCompare then
                self.isBetterEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsBetterBodyEquip(compareItemInfo, self.mCompareEquipInfo, LuaEnumAttributeType.MagicDefenceMax)
            end
            self.highInfo = ternary(rotaMaxMagicDefence > 0, string.format("%g", rotaMaxMagicDefence / 10), string.format("%g", mMagicDefence / 10))
            if rotaMaxMagicDefence - mMagicDefence > 0 then
                self.showColor = self.mAddColor
                self.addInfo = "(+" .. (rotaMaxMagicDefence - mMagicDefence) / 10 .. ")[-]"
            end
            self.attributeName = self.showColor .. "魔防[-]"
            self.attributeValue = self.showColor .. self.highInfo .. self.addInfo .. ''
            if (CS.StaticUtility.IsNullOrEmpty(self.addInfo) == false and mMagicDefence >= 0) or mMagicDefence > 0 then
                self:AddAttribute(self.attributeName, self.attributeValue, self.isBetterEquip)
            end
        end
        --endregion

        --region 神圣攻击
        self:ResetInfo()
        local mHolyAttack = servantInfo.holyAttackQualifications
        local rotaHolyAttack = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.HolyAttackMax)
        --比较更好装备
        if isNeedCompare then
            self.isBetterEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsBetterBodyEquip(compareItemInfo, self.mCompareEquipInfo, LuaEnumAttributeType.HolyAttackMax)
        end
        self.lowInfo = ternary(rotaHolyAttack > 0, string.format("%g", rotaHolyAttack / 10), string.format("%g", mHolyAttack / 10))
        if rotaHolyAttack - mHolyAttack > 0 then
            self.showColor = self.mAddColor
            self.addInfo = "(+" .. tostring(rotaHolyAttack - mHolyAttack) / 10 .. ")[-]"
        end
        self.attributeName = self.showColor .. Utility.GetAttributeName(LuaEnumAttributeType.HolyAttackMax) .. "[-]"
        self.attributeValue = self.showColor .. self.lowInfo .. self.addInfo .. ''
        if (CS.StaticUtility.IsNullOrEmpty(self.addInfo) == false and mHolyAttack >= 0) or mHolyAttack > 0 then
            self:AddAttribute(self.attributeName, self.attributeValue, self.isBetterEquip)
        end
        --endregion

        --region 神圣防御
        self:ResetInfo()
        local mHolyDefence = servantInfo.holyDefenceQualifications
        local rotaHolyDefence = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.HolyDefenceMax)
        --比较更好装备
        if isNeedCompare then
            self.isBetterEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsBetterBodyEquip(compareItemInfo, self.mCompareEquipInfo, LuaEnumAttributeType.HolyDefenceMax)
        end
        self.lowInfo = ternary(rotaHolyDefence > 0, string.format("%g", rotaHolyDefence / 10), string.format("%g", mHolyDefence / 10))
        if rotaHolyDefence - mHolyDefence > 0 then
            self.showColor = self.mAddColor
            self.addInfo = "(+" .. (rotaHolyDefence - mHolyDefence) / 10 .. ")[-]"
        end
        self.attributeName = self.showColor .. Utility.GetAttributeName(LuaEnumAttributeType.HolyDefenceMax) .. "[-]"
        self.attributeValue = self.showColor .. self.lowInfo .. self.addInfo .. ''
        if (CS.StaticUtility.IsNullOrEmpty(self.addInfo) == false and mHolyDefence >= 0) or mHolyDefence > 0 then
            self:AddAttribute(self.attributeName, self.attributeValue, self.isBetterEquip)
        end
        --endregion

        --region 使用等级
        if ((itemInfo.useLv and itemInfo.useLv > 0) or (itemInfo.reinLv and itemInfo.reinLv > 0)) and itemInfo.type == luaEnumItemType.Equip then
            local useLevelColor = nil
            if bodyServantInfo == nil then
                local colorState = false
                if bagItemInfo ~= nil and bagItemInfo.index ~= 0 then
                    colorState = true
                end
                useLevelColor = Utility.NewGetBBCode(colorState)
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
end

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_ServantBodyBaseAttribute:RefreshWithInfo(commonData)
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    local compareEquip = commonData.compareBagItemInfo
    local compareItemInfo = commonData.compareItemInfo
    self:ClearAttributeData()
    if itemInfo ~= nil then
        self:RefreshAttributes(bagItemInfo, itemInfo, compareEquip, compareItemInfo)
    end
    self:ShowAttribute(itemInfo)
end

function UIItemInfoPanel_Info_ServantBodyBaseAttribute:ShowAttribute(itemInfo)
    if itemInfo.type == luaEnumItemType.Equip then
        self:GetTitleLabel_UILabel().gameObject:SetActive(true)
        self:GetTitleLabel_UILabel().text = ternary(self.count == 0, "", "[73ddf7]加成资质")
    else
        self:GetTitleLabel_UILabel().gameObject:SetActive(false)
    end
    self:GetBaseAttr_UIGridContainer().MaxCount = #self.attributeTable
    self:GetAttributeArrow_UIGridContainer().MaxCount = #self.attributeTable
    for i = 0, #self.attributeTable - 1 do
        local attribute = self.attributeTable[i + 1]
        local attr = self:GetBaseAttr_UIGridContainer().controlList[i]
        local attrName = self:GetCurComp(attr, "AttrName", "UILabel")
        local attrValue = self:GetCurComp(attr, "AttrValue/AttrValue", "UILabel")
        local arrow = self:GetAttributeArrow_UIGridContainer().controlList[i]
        attrName.text = attribute.attributeName
        attrValue.text = attribute.attributeValue
        arrow:SetActive(attribute.isShowArrow)
    end
end

return UIItemInfoPanel_Info_ServantBodyBaseAttribute