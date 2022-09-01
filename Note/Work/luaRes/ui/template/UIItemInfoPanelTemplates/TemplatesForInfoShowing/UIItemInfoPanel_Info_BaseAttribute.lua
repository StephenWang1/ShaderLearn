---@type 物品信息界面信息
---@class UIItemInfoPanel_Info_BaseAttribute:TemplateBase
local UIItemInfoPanel_Info_BaseAttribute = {}

setmetatable(UIItemInfoPanel_Info_BaseAttribute, luaComponentTemplates.UIItemInfoPanel_Info_Basic)

--region 自定义变量
---浮动颜色
UIItemInfoPanel_Info_BaseAttribute.rateColor = "[39ce1b]"
---属性名字颜色
UIItemInfoPanel_Info_BaseAttribute.attributeNameColor = ""
---属性表
UIItemInfoPanel_Info_BaseAttribute.attributeTable = {}
--endregion

--region 组件
---标题文本
---@return UILabel
function UIItemInfoPanel_Info_BaseAttribute:GetTitleLabel_UILabel()
    if self.mTitleLabel_UILabel == nil then
        self.mTitleLabel_UILabel = self:Get("title", "UILabel")
    end
    return self.mTitleLabel_UILabel
end

---属性名文本
---@return UILabel
function UIItemInfoPanel_Info_BaseAttribute:GetAttributeNameLabel_UILabel()
    if self.mAttributeNameLabel_UILabel == nil then
        self.mAttributeNameLabel_UILabel = self:Get("AttrName", "UILabel")
    end
    return self.mAttributeNameLabel_UILabel
end

---属性值文本
---@return UILabel
function UIItemInfoPanel_Info_BaseAttribute:GetAttributeValueLabel_UILabel()
    if self.mAttributeValueLabel_UILabel == nil then
        self.mAttributeValueLabel_UILabel = self:Get("AttrValue", "UILabel")
    end
    return self.mAttributeValueLabel_UILabel
end

---属性箭头集合
---@return UIGridContainer
function UIItemInfoPanel_Info_BaseAttribute:GetAttributeArrow_UIGridContainer()
    if self.mAttributeArrow_UIGridContainer == nil then
        self.mAttributeArrow_UIGridContainer = self:Get("AttrArrow", "UIGridContainer")
    end
    return self.mAttributeArrow_UIGridContainer
end

---强化属性集合
---@return UIGridContainer
function UIItemInfoPanel_Info_BaseAttribute:GetAttrIntensify_UIGridContainer()
    if self.mAttrIntensify_UIGridContainer == nil then
        self.mAttrIntensify_UIGridContainer = self:Get("AttrIntensify", "UIGridContainer")
    end
    return self.mAttrIntensify_UIGridContainer
end

---强化属性集合
---@return UIAnchor
function UIItemInfoPanel_Info_BaseAttribute:GetAttrIntensify_UIAnchor()
    if self.mAttrIntensify_UIAnchor == nil then
        self.mAttrIntensify_UIAnchor = self:Get("AttrIntensify", "UIAnchor")
    end
    return self.mAttrIntensify_UIAnchor
end

---基础属性集合
---@return UIGridContainer
function UIItemInfoPanel_Info_BaseAttribute:GetBaseAttr_UIGridContainer()
    if self.mBaseAttr_UIGridContainer == nil then
        self.mBaseAttr_UIGridContainer = self:Get("Attr", "UIGridContainer")
    end
    return self.mBaseAttr_UIGridContainer
end

---箭头宽度
---@return number
function UIItemInfoPanel_Info_BaseAttribute:GetArrowWidth()
    if self.arrowWidth == nil and self:GetAttributeArrow_UIGridContainer() ~= nil then
        local arrow_GameObject = self:GetAttributeArrow_UIGridContainer().controlTemplate
        if arrow_GameObject ~= nil then
            local arrow_Sprite = self:GetCurComp(arrow_GameObject, "", "UISprite")
            if arrow_Sprite ~= nil then
                self.arrowWidth = arrow_Sprite.width
            end
        end
    end
    return self.arrowWidth
end
--endregion

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_BaseAttribute:RefreshWithInfo(commonData)
    self.bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    self.compareBagItemInfo = ternary(commonData.isMainPartTemplate == true, commonData.compareBagItemInfo, nil)
    self.compareItemInfo = ternary(commonData.isMainPartTemplate == true, commonData.compareItemInfo, nil)
    local career = commonData.career
    local extraEquipList = commonData.extraEquipList
    self.itemInfoSource = commonData.itemInfoSource
    self.isMainPartTemplate = commonData.isMainPartTemplate
    self:GetBetterAttributeType()
    self.isRefineBetterBagItemInfo = self:IsRefineBetterBagItemInfo()

    self:ClearAttributeData()
    self.mExtraEquipList = extraEquipList;
    if self.bagItemInfo ~= nil then
        self:RefreshAttributes(self.bagItemInfo, itemInfo, self.compareBagItemInfo, self.compareItemInfo, career)
    else
        if itemInfo.type == luaEnumItemType.Equip or itemInfo.type == luaEnumItemType.HunJi or itemInfo.type == luaEnumItemType.Appearance then
            self:RefreshAttributes(self.bagItemInfo, itemInfo, self.compareBagItemInfo, self.compareItemInfo, career)
        else
            self:RefreshNoBagItemInfoAttributes(itemInfo)
        end
    end
    self:ShowAttribute(itemInfo)
end

---@param bagItemInfo bagV2.BagItemInfo 背包信息
---@param itemInfo TABLE.CFG_ITEMS 物品信息
function UIItemInfoPanel_Info_BaseAttribute:RefreshAttributes(bagItemInfo, itemInfo, compareBagItemInfo, compareItemInfo, career)
    self.bagItemInfo = bagItemInfo
    self.itemInfo = itemInfo
    self.career = career
    if type(self.career) ~= "number" then
        self.career = Utility.EnumToInt(self.career)
    end
    local mainCareer = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    local isEquiped = false
    if bagItemInfo then
        isEquiped = CS.CSScene.MainPlayerInfo.EquipInfo:IsEquip(bagItemInfo.lid)
    end
    if bagItemInfo and clientTableManager.cfg_itemsManager:IsDivineSuitEquip(bagItemInfo.itemId) then
        isEquiped = bagItemInfo.index ~= 0 and not self.isMainPartTemplate
    end

    if itemInfo then
        local mainplayerinfo = CS.CSScene.MainPlayerInfo
        local mainPlayerCareerNum = Utility.EnumToInt(mainplayerinfo.Career)
        ---@type bagV2.BagItemInfo
        local equipmentInPlayer = nil
        if isEquiped == false and compareBagItemInfo ~= nil then
            equipmentInPlayer = compareBagItemInfo
        end
        ---@type TABLE.CFG_ITEMS
        local equipmentItemInPlayer = nil
        if equipmentInPlayer then
            equipmentItemInPlayer = compareItemInfo
        end
        local isAbleToCompare = (itemInfo.career == mainPlayerCareerNum or itemInfo.career == LuaEnumCareer.Common) and (isEquiped == false) and equipmentItemInPlayer
        --浮动属性
        local rateAttribute = ""

        --region 强化属性
        self:GetAttrIntensify_UIGridContainer().MaxCount = 5
        for i = 0, self:GetAttrIntensify_UIGridContainer().controlList.Count - 1 do
            self:GetAttrIntensify_UIGridContainer().controlList[i].gameObject:SetActive(false)
        end
        --endregion

        --region 物理防御属性
        if itemInfo.type == luaEnumItemType.HunJi then
            if itemInfo.phyDefenceMin >= 0 and itemInfo.phyDefenceMax > 0 then
                self:AddAttribute("防         御", tostring(itemInfo.phyDefenceMin) .. "-" .. tostring(itemInfo.phyDefenceMax))
            end
        else
            local maxPhyDefence = CS.Cfg_ItemsTableManager.Instance:GetCareerAttributeValue(itemInfo.id, mainPlayerCareerNum, CS.CareerAttributeType.PHYDEFENCEMAX)
            local minPhyDefence = CS.Cfg_ItemsTableManager.Instance:GetCareerAttributeValue(itemInfo.id, mainPlayerCareerNum, CS.CareerAttributeType.PHYDEFENCEMIN)
            if mainCareer ~= nil and maxPhyDefence >= 0 and minPhyDefence >= 0 then
                rateAttribute = ""
                local isHigherPhysicsDefence = isAbleToCompare
                local rotaMinPhyDefence = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.PhyDefenceMin)
                local rotaMaxPhyDefence = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.PhyDefenceMax)
                if self.itemInfoSource == luaEnumItemInfoSource.UIREFINERESULT then
                    isHigherPhysicsDefence = self.betterAttributeType == CS.BetterAttributeReason.TotalDefence and self.isRefineBetterBagItemInfo == true
                elseif equipmentItemInPlayer then
                    local equipmenItemMaxPhyDefence = CS.Cfg_ItemsTableManager.Instance:GetCareerAttributeValue(equipmentItemInPlayer.id, mainPlayerCareerNum, CS.CareerAttributeType.PHYDEFENCEMAX)
                    local equipmenItemMinPhyDefence = CS.Cfg_ItemsTableManager.Instance:GetCareerAttributeValue(equipmentItemInPlayer.id, mainPlayerCareerNum, CS.CareerAttributeType.PHYDEFENCEMIN)
                    isHigherPhysicsDefence = self:CompareAttribute(maxPhyDefence, minPhyDefence, rotaMaxPhyDefence, equipmenItemMaxPhyDefence, equipmenItemMinPhyDefence, self:FindRateAttributeValue(equipmentItemInPlayer, LuaEnumAttributeType.PhyDefenceMax))
                end
                if rotaMinPhyDefence > 0 or rotaMaxPhyDefence > 0 then
                    rateAttribute = "(+" .. tostring(rotaMaxPhyDefence) .. ")[-]"
                    self:AddAttribute("[39ce1b]防御[-]", "[39ce1b]" .. tostring(minPhyDefence + rotaMinPhyDefence) .. ' - ' .. tostring(maxPhyDefence + rotaMaxPhyDefence) .. rateAttribute .. '', isHigherPhysicsDefence)
                else
                    if minPhyDefence > 0 or maxPhyDefence > 0 then
                        self:AddAttribute(self.attributeNameColor .. "防御[-]", tostring(minPhyDefence) .. ' - ' .. tostring(maxPhyDefence) .. rateAttribute .. '', isHigherPhysicsDefence)
                    end
                end
            end
        end
        --endregion

        --region 法术防御属性
        if itemInfo.type == luaEnumItemType.HunJi then
            if itemInfo.magicDefenceMin >= 0 and itemInfo.magicDefenceMax > 0 then
                self:AddAttribute("魔         防", tostring(itemInfo.magicDefenceMin) .. "-" .. tostring(itemInfo.magicDefenceMax))
            end
        else
            local minMagicDefence = CS.Cfg_ItemsTableManager.Instance:GetCareerAttributeValue(itemInfo.id, mainPlayerCareerNum, CS.CareerAttributeType.MAGICDEFENCEMIN)
            local maxMagicDefence = CS.Cfg_ItemsTableManager.Instance:GetCareerAttributeValue(itemInfo.id, mainPlayerCareerNum, CS.CareerAttributeType.MAGICDEFENCEMAX)
            if mainCareer ~= nil and minMagicDefence >= 0 and maxMagicDefence >= 0 then
                rateAttribute = ""
                local isHigherMagicDefence = isAbleToCompare
                local rotaMinMagicDefence = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.MagicDefenceMin)
                local rotaMaxMagicDefence = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.MagicDefenceMax)
                if self.itemInfoSource == luaEnumItemInfoSource.UIREFINERESULT then
                    isHigherMagicDefence = self.betterAttributeType == CS.BetterAttributeReason.TotalDefence and self.isRefineBetterBagItemInfo == true
                elseif equipmentItemInPlayer then
                    local equipmentItemMinMagicDefence = CS.Cfg_ItemsTableManager.Instance:GetCareerAttributeValue(equipmentItemInPlayer.id, mainPlayerCareerNum, CS.CareerAttributeType.MAGICDEFENCEMIN)
                    local equipmentItemMaxMagicDefence = CS.Cfg_ItemsTableManager.Instance:GetCareerAttributeValue(equipmentItemInPlayer.id, mainPlayerCareerNum, CS.CareerAttributeType.MAGICDEFENCEMAX)
                    isHigherMagicDefence = self:CompareAttribute(maxMagicDefence, minMagicDefence, rotaMaxMagicDefence, equipmentItemMaxMagicDefence, equipmentItemMinMagicDefence, self:FindRateAttributeValue(equipmentItemInPlayer, LuaEnumAttributeType.MagicDefenceMax))
                end
                if rotaMinMagicDefence > 0 or rotaMaxMagicDefence > 0 then
                    rateAttribute = "(+" .. tostring(rotaMaxMagicDefence) .. ")[-]"
                    self:AddAttribute("[39ce1b]魔防[-]", "[39ce1b]" .. tostring(minMagicDefence + rotaMinMagicDefence) .. ' - ' .. tostring(maxMagicDefence + rotaMaxMagicDefence) .. rateAttribute .. '', isHigherMagicDefence)
                else
                    if minMagicDefence > 0 or maxMagicDefence > 0 then
                        self:AddAttribute(self.attributeNameColor .. "魔防[-]", tostring(minMagicDefence) .. ' - ' .. tostring(maxMagicDefence) .. rateAttribute .. '', isHigherMagicDefence)
                    end
                end
            end
        end
        --endregion

        --region 物理攻击属性
        if itemInfo.type == luaEnumItemType.HunJi then
            if itemInfo.phyAttackMin >= 0 and itemInfo.phyAttackMax > 0 then
                self:AddAttribute("攻         击", tostring(itemInfo.phyAttackMin) .. "-" .. tostring(itemInfo.phyAttackMax))
            end
        else
            local minPhyAttack = itemInfo.phyAttackMin
            local maxPhyAttack = itemInfo.phyAttackMax
            local rotaMinPhyAttack = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.PhyAttackMin)
            local rotaMaxPhyAttack = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.PhyAttackMax)
            local isHigherPhyAttack = isAbleToCompare
            if mainPlayerCareerNum == LuaEnumCareer.Warrior then
                if self.itemInfoSource == luaEnumItemInfoSource.UIREFINERESULT then
                    isHigherPhyAttack = self.betterAttributeType == CS.BetterAttributeReason.CareerAttack and self.isRefineBetterBagItemInfo == true
                elseif equipmentItemInPlayer and isHigherPhyAttack then
                    isHigherPhyAttack = self:CompareAttribute(maxPhyAttack, minPhyAttack, rotaMaxPhyAttack, equipmentItemInPlayer.phyAttackMax, equipmentItemInPlayer.phyAttackMin, self:FindRateAttributeValue(equipmentInPlayer, LuaEnumAttributeType.PhyAttackMax))
                end
            else
                isHigherPhyAttack = false
            end
            if rotaMinPhyAttack > 0 or rotaMaxPhyAttack > 0 then
                self:SetIntensify(bagItemInfo, LuaEnumCareer.Warrior)
                self:AddAttribute("[39ce1b]攻击[-]",
                        "[39ce1b]" .. tostring(minPhyAttack + rotaMinPhyAttack) .. ' - ' .. tostring(maxPhyAttack + rotaMaxPhyAttack) .. "(+" .. tostring(rotaMaxPhyAttack) .. ")[-]" .. '', isHigherPhyAttack)
            else
                if minPhyAttack > 0 or maxPhyAttack > 0 then
                    --如果值为0-0则不显示
                    self:SetIntensify(bagItemInfo, LuaEnumCareer.Warrior)
                    self:AddAttribute(self.attributeNameColor .. "攻击[-]", tostring(minPhyAttack) .. ' - ' .. tostring(maxPhyAttack) .. '', isHigherPhyAttack)
                end
            end
        end
        --endregion

        --region 魔法攻击属性
        local minMagicAttack = itemInfo.magicAttackMin
        local maxMagicAttack = itemInfo.magicAttackMax
        local rotaMinMagicAttack = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.MagicAttackMin)
        local rotaMaxMagicAttack = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.MagicAttackMax)
        local isHigherMagicAttack = isAbleToCompare
        if mainPlayerCareerNum == LuaEnumCareer.Master then
            if self.itemInfoSource == luaEnumItemInfoSource.UIREFINERESULT then
                isHigherMagicAttack = self.betterAttributeType == CS.BetterAttributeReason.CareerAttack and self.isRefineBetterBagItemInfo == true
            elseif equipmentItemInPlayer and isHigherMagicAttack then
                isHigherMagicAttack = self:CompareAttribute(maxMagicAttack, minMagicAttack, rotaMaxMagicAttack, equipmentItemInPlayer.magicAttackMax, equipmentItemInPlayer.magicAttackMin, self:FindRateAttributeValue(equipmentInPlayer, LuaEnumAttributeType.MagicAttackMax))
            end
        else
            isHigherMagicAttack = false
        end
        if rotaMinMagicAttack > 0 or rotaMaxMagicAttack > 0 then
            self:SetIntensify(bagItemInfo, LuaEnumCareer.Master)
            self:AddAttribute("[39ce1b]" .. Utility.GetAttributeName(LuaEnumAttributeType.MagicAttackMax) .. "[-]",
                    "[39ce1b]" .. tostring(minMagicAttack + rotaMinMagicAttack) .. ' - ' .. tostring(maxMagicAttack + rotaMaxMagicAttack) .. "(+" .. tostring(rotaMaxMagicAttack) .. ")[-]" .. '', isHigherMagicAttack)
        else
            if minMagicAttack > 0 or maxMagicAttack > 0 then
                self:SetIntensify(bagItemInfo, LuaEnumCareer.Master)
                self:AddAttribute(self.attributeNameColor .. Utility.GetAttributeName(LuaEnumAttributeType.MagicAttackMax) .. "[-]", tostring(minMagicAttack) .. ' - ' .. tostring(maxMagicAttack) .. '', isHigherMagicAttack)
            end
        end
        --endregion

        --region 道术攻击属性
        local minTaoAttack = itemInfo.taoAttackMin
        local maxTaoAttack = itemInfo.taoAttackMax
        local rotaMinTaoAttack = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.TaoAttackMin)
        local rotaMaxTaoAttack = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.TaoAttackMax)
        local isHigherTaoAttack = isAbleToCompare
        if mainPlayerCareerNum == LuaEnumCareer.Taoist then
            if self.itemInfoSource == luaEnumItemInfoSource.UIREFINERESULT then
                isHigherTaoAttack = self.betterAttributeType == CS.BetterAttributeReason.CareerAttack and self.isRefineBetterBagItemInfo == true
            elseif equipmentItemInPlayer and isHigherTaoAttack then
                isHigherTaoAttack = self:CompareAttribute(maxTaoAttack, minTaoAttack, rotaMaxTaoAttack, equipmentItemInPlayer.taoAttackMax, equipmentItemInPlayer.taoAttackMin, self:FindRateAttributeValue(equipmentInPlayer, LuaEnumAttributeType.TaoAttackMax))
            end
        else
            isHigherTaoAttack = false
        end
        if rotaMinTaoAttack > 0 or rotaMaxTaoAttack > 0 then
            self:SetIntensify(bagItemInfo, LuaEnumCareer.Taoist)
            self:AddAttribute("[39ce1b]道术[-]",
                    "[39ce1b]" .. tostring(minTaoAttack + rotaMinTaoAttack) .. ' - ' .. tostring(maxTaoAttack + rotaMaxTaoAttack) .. "(+" .. tostring(rotaMaxTaoAttack) .. ")[-]" .. '', isHigherTaoAttack)
        else
            if minTaoAttack > 0 or maxTaoAttack > 0 then
                self:SetIntensify(bagItemInfo, LuaEnumCareer.Taoist)
                self:AddAttribute(self.attributeNameColor .. "道术[-]", tostring(minTaoAttack) .. ' - ' .. tostring(maxTaoAttack) .. '', isHigherTaoAttack)
            end
        end
        --endregion

        --region 魂继血量
        if itemInfo.type == luaEnumItemType.HunJi then
            if itemInfo.maxHp ~= nil and itemInfo.maxHp.list.Count > 0 and itemInfo.maxHp.list[0].list.Count > 1 then
                self:AddAttribute("血         量", tostring(itemInfo.maxHp.list[0].list[1]))
            end
        end
        --endregion

        --region 精准属性
        if itemInfo.accurate >= 0 then
            rateAttribute = ""
            local isHigherAccurate = isAbleToCompare
            local rotaAccurate = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.Accurate)
            if equipmentItemInPlayer then
                isHigherAccurate = isHigherAccurate and (itemInfo.accurate > equipmentItemInPlayer.accurate)
            end
            if rotaAccurate > 0 then
                rateAttribute = "(+" .. tostring(rotaAccurate) .. ")[-]"
                self:AddAttribute("[39ce1b]准确[-]", "[39ce1b]+" .. tostring(itemInfo.accurate) .. rateAttribute .. '', isHigherAccurate)
            else
                if itemInfo.accurate > 0 then
                    self:AddAttribute(self.attributeNameColor .. "准确[-]", "+" .. tostring(itemInfo.accurate) .. rateAttribute .. '', isHigherAccurate)
                end
            end

        end
        --endregion

        --region 闪避属性
        if itemInfo.dodge >= 0 then
            rateAttribute = ""
            local isHigherDodge = isAbleToCompare
            local rotaDodge = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.Dodge)
            if equipmentItemInPlayer then
                isHigherDodge = isHigherDodge and (itemInfo.dodge > equipmentItemInPlayer.dodge)
            end
            if rotaDodge > 0 then
                rateAttribute = "(+" .. tostring(rotaDodge) .. ")[-]"
                self:AddAttribute("[39ce1b]敏捷[-]", "[39ce1b]+" .. tostring(itemInfo.dodge) .. rateAttribute .. '', isHigherDodge)
            else
                if itemInfo.dodge > 0 then
                    self:AddAttribute(self.attributeNameColor .. "敏捷[-]", "+" .. tostring(itemInfo.dodge) .. rateAttribute .. '', isHigherDodge)
                end
            end

        end
        --endregion

        --region HP恢复
        if itemInfo.hpRecover >= 0 then
            rateAttribute = ""
            local isHigherHPRecover = isAbleToCompare
            local rotHpRecover = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.HpRecover)
            if equipmentItemInPlayer then
                isHigherHPRecover = isHigherHPRecover and (itemInfo.hpRecover > equipmentItemInPlayer.hpRecover)
            end
            if rotHpRecover > 0 then
                rateAttribute = "(+" .. tostring(rotHpRecover) .. ")[-]"
                self:AddAttribute("[39ce1b]生命恢复[-]", "[39ce1b]" .. tostring(itemInfo.hpRecover) .. rateAttribute .. '', isHigherHPRecover)
            else
                if itemInfo.hpRecover > 0 then
                    self:AddAttribute(self.attributeNameColor .. "生命恢复[-]", tostring(itemInfo.hpRecover) .. rateAttribute .. '', isHigherHPRecover)
                end
            end

        end
        --endregion

        --region 攻击速度
        if itemInfo.attackSpeed >= 0 then
            rateAttribute = ""
            local isHigherAttackSpeed = isAbleToCompare
            local rotaAttackSpeed = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.AttackSpeed)
            if equipmentItemInPlayer then
                isHigherAttackSpeed = isHigherAttackSpeed and (itemInfo.attackSpeed > equipmentItemInPlayer.attackSpeed)
            end
            if rotaAttackSpeed > 0 then
                rateAttribute = "(+" .. tostring(rotaAttackSpeed) .. ")[-]"
                self:AddAttribute("[39ce1b]攻速[-]", "[39ce1b]" .. tostring(itemInfo.attackSpeed) .. rateAttribute .. '', isHigherAttackSpeed)
            else
                if itemInfo.attackSpeed > 0 then
                    self:AddAttribute(self.attributeNameColor .. "攻速[-]", tostring(itemInfo.attackSpeed) .. rateAttribute .. '', isHigherAttackSpeed)
                end
            end

        end
        --endregion

        --region 魔法恢复
        if itemInfo.mpRecover >= 0 then
            rateAttribute = ""
            local isHigherMPRecover = isAbleToCompare
            local rotaMpRecover = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.MpRecover)
            if equipmentItemInPlayer then
                isHigherMPRecover = isHigherMPRecover and (itemInfo.mpRecover > equipmentItemInPlayer.mpRecover)
            end
            if rotaMpRecover > 0 then
                rateAttribute = "(+" .. tostring(rotaMpRecover) .. ")[-]"
                self:AddAttribute("[39ce1b]魔法恢复[-]", "[39ce1b]" .. tostring(itemInfo.mpRecover) .. rateAttribute .. '', isHigherMPRecover)
            else
                if itemInfo.mpRecover > 0 then
                    self:AddAttribute(self.attributeNameColor .. "魔法恢复[-]", tostring(itemInfo.mpRecover) .. rateAttribute .. '', isHigherMPRecover)
                end
            end

        end
        --endregion

        --region 幸运
        if bagItemInfo ~= nil and bagItemInfo.luck ~= nil
                and not (itemInfo.type == luaEnumItemType.Assist and itemInfo.subType == 4)
                and not (itemInfo.type == luaEnumItemType.Assist and itemInfo.subType == 32)
        then
            if bagItemInfo.luck >= 0 then
                rateAttribute = ""
                local isHigherLuck = isAbleToCompare
                local rotaLuck = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.Luck)
                local color = luaEnumColorType.Green
                if equipmentItemInPlayer then
                    isHigherLuck = isHigherLuck and (bagItemInfo.luck > equipmentInPlayer.luck)
                end
                if rotaLuck > 0 then
                    rateAttribute = "(+" .. tostring(rotaLuck) .. ")[-]"
                    self:AddAttribute(color .. "[39ce1b]幸运[-]", color .. "+" .. tostring(bagItemInfo.luck) .. rateAttribute .. '', isHigherLuck)
                else
                    if bagItemInfo.luck > 0 then
                        self:AddAttribute(color .. "幸运[-]", color .. "+" .. tostring(bagItemInfo.luck) .. rateAttribute .. '', isHigherLuck)
                    end
                end
            end
        end
        --endregion

        --region 诅咒
        if bagItemInfo ~= nil and bagItemInfo.curse ~= nil then
            if bagItemInfo.curse >= 0 then
                rateAttribute = ""
                local isHigherCurse = isAbleToCompare
                local rotaCurse = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.curse)
                local color = luaEnumColorType.Red
                if equipmentItemInPlayer then
                    isHigherCurse = isHigherCurse and (bagItemInfo.curse > equipmentInPlayer.curse)
                end
                if rotaCurse > 0 then
                    rateAttribute = "(+" .. tostring(rotaCurse) .. ")[-]"
                    self:AddAttribute(color .. "诅咒[-]", color .. "+" .. tostring(bagItemInfo.curse) .. rateAttribute .. '', isHigherCurse)
                else
                    if bagItemInfo.curse > 0 then
                        self:AddAttribute(color .. "诅咒[-]", color .. "+" .. tostring(bagItemInfo.curse) .. rateAttribute .. '', isHigherCurse)
                    end
                end

            end
        end
        --endregion

        --region 暴击伤害
        if itemInfo.criticalDamage >= 0 then
            rateAttribute = ""
            local isHighercriticalDamage = isAbleToCompare
            local HighercriticalDamagecolor = self:GetAttributeShowColor(LuaEnumAttributeType.CriticalDamage)
            local rotaCriticalDamage = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.CriticalDamage)
            if equipmentItemInPlayer then
                isHighercriticalDamage = isHighercriticalDamage and (itemInfo.criticalDamage > equipmentItemInPlayer.criticalDamage)
            end
            if rotaCriticalDamage > 0 then
                rateAttribute = HighercriticalDamagecolor .. "(+" .. tostring(rotaCriticalDamage) .. ")[-]"
                self:AddAttribute(HighercriticalDamagecolor .. "暴击伤害[-]", HighercriticalDamagecolor .. tostring(itemInfo.criticalDamage) .. rateAttribute .. '', isHighercriticalDamage)
                if (itemInfo.seckill ~= nil) then
                    self:AddAttribute("秒杀血量[-]", tostring(Utility.RemoveEndZero(itemInfo.seckill.list[0] / 100) .. '%') .. '', false)
                    self:AddAttribute("秒杀概率[-]", tostring(Utility.RemoveEndZero(itemInfo.seckill.list[1] / 100) .. '%') .. '', false)
                end
            else
                if itemInfo.criticalDamage > 0 then
                    self:AddAttribute(HighercriticalDamagecolor .. "暴击伤害[-]", tostring(itemInfo.criticalDamage) .. rateAttribute .. '', isHighercriticalDamage)
                    if (itemInfo.seckill ~= nil) then
                        self:AddAttribute("秒杀血量[-]", tostring(Utility.RemoveEndZero(itemInfo.seckill.list[0] / 100) .. '%') .. '', false)
                        self:AddAttribute("秒杀概率[-]", tostring(Utility.RemoveEndZero(itemInfo.seckill.list[1] / 100) .. '%') .. '', false)
                    end
                end
            end
        end
        --endregion

        --region 内力
        if itemInfo.innerPowerMax >= 0 then
            rateAttribute = ""
            local isHigherinnerPowerMax = isAbleToCompare
            local innerPowercolor = self:GetAttributeShowColor(LuaEnumAttributeType.InnerPowerMax)
            local rotaInnerPowerMax = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.InnerPowerMax)
            if equipmentItemInPlayer then
                isHigherinnerPowerMax = isHigherinnerPowerMax and (itemInfo.innerPowerMax > equipmentItemInPlayer.innerPowerMax)
            end
            if rotaInnerPowerMax > 0 then
                rateAttribute = innerPowercolor .. "(+" .. tostring(rotaInnerPowerMax) .. ")[-]"
                self:AddAttribute(innerPowercolor .. "内力[-]", innerPowercolor .. tostring(itemInfo.innerPowerMax) .. rateAttribute .. '', isHigherinnerPowerMax)
            else
                if itemInfo.innerPowerMax > 0 then
                    self:AddAttribute(innerPowercolor .. "内力[-]", tostring(itemInfo.innerPowerMax) .. rateAttribute .. '', isHigherinnerPowerMax)
                end
            end
        end
        --endregion

        --region 血量
        if itemInfo.type ~= luaEnumItemType.HunJi then
            ---规避掉魂继
            local itemMaxHP = CS.Cfg_ItemsTableManager.Instance:GetCareerAttributeValue(itemInfo.id, mainPlayerCareerNum, CS.CareerAttributeType.HP)
            if itemMaxHP >= 0 then
                rateAttribute = ""
                local isHighermaxHp = isAbleToCompare
                if equipmentItemInPlayer then
                    local equipedItemHP = CS.Cfg_ItemsTableManager.Instance:GetCareerAttributeValue(equipmentItemInPlayer.id, mainPlayerCareerNum, CS.CareerAttributeType.HP)
                    isHighermaxHp = isHighermaxHp and (itemMaxHP > equipedItemHP)
                end
                local rotaMaxHp = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.MaxHp)
                if rotaMaxHp > 0 then
                    rateAttribute = "(+" .. tostring(rotaMaxHp) .. ")[-]"
                    self:AddAttribute("[39ce1b]" .. Utility.GetAttributeName(LuaEnumAttributeType.MaxHp) .. "[-]", "[39ce1b]" .. tostring(itemMaxHP) .. rateAttribute .. '', isHighermaxHp)
                else
                    if itemMaxHP > 0 then
                        self:AddAttribute(self.attributeNameColor .. Utility.GetAttributeName(LuaEnumAttributeType.MaxHp) .. "[-]", tostring(itemMaxHP) .. rateAttribute .. '', isHighermaxHp)
                    end
                end
            end
        end
        --endregion

        --region 魔法值
        if itemInfo.maxMp >= 0 then
            local isHighermaxMp = isAbleToCompare
            if equipmentItemInPlayer then
                isHighermaxMp = isHighermaxMp and (itemInfo.maxMp > equipmentItemInPlayer.maxMp)
            end
            rateAttribute = ""
            local rotaMaxMp = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.MaxMp)
            if rotaMaxMp > 0 then
                rateAttribute = "[39ce1b](+" .. tostring(rotaMaxMp) .. ")[-]"
                self:AddAttribute("[39ce1b]魔法值[-]", "[39ce1b]" .. tostring(itemInfo.maxMp) .. rateAttribute .. '', isHighermaxMp)
            else
                if itemInfo.maxMp > 0 then
                    self:AddAttribute(self.attributeNameColor .. "魔法值[-]", tostring(itemInfo.maxMp) .. rateAttribute .. '', isHighermaxMp)
                end
            end

        end
        --endregion

        --region 暴击率
        if itemInfo.showCritical >= 0 then
            local isHighercritical = isAbleToCompare
            if equipmentItemInPlayer then
                isHighercritical = isHighercritical and (itemInfo.showCritical > equipmentItemInPlayer.showCritical)
            end
            rateAttribute = ""
            local rotaCritical = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.Critical)
            if rotaCritical > 0 then
                rateAttribute = "(+" .. tostring(rotaCritical) .. ")[-]"
                self:AddAttribute("[39ce1b]暴击率[-]", "[39ce1b]" .. string.format("%g%s", itemInfo.showCritical * 0.01, rateAttribute) .. ' %', isHighercritical)
            else
                if itemInfo.critical > 0 then
                    self:AddAttribute(self.attributeNameColor .. "暴击率[-]", string.format("%g%s", itemInfo.showCritical * 0.01, rateAttribute) .. ' %', isHighercritical)
                end
            end

        end
        --endregion

        --region 神圣攻击
        if itemInfo.holyAttackMax >= 0 then
            local isHigherholyAttack = isAbleToCompare
            if equipmentItemInPlayer and itemInfo.type ~= luaEnumItemType.HunJi and equipmentItemInPlayer.HolyAttackMax then
                isHigherholyAttack = isHigherholyAttack and (itemInfo.holyAttackMax > equipmentItemInPlayer.HolyAttackMax) --holyAttackMax
            elseif itemInfo.type == luaEnumItemType.HunJi then
                isHigherholyAttack = false
            end
            ---@type AttributeDesParams
            local attributeDesParams = {}
            attributeDesParams.bagItemInfo = bagItemInfo
            attributeDesParams.itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id)
            attributeDesParams.minAttributeType = LuaEnumAttributeType.HolyAttackMin
            attributeDesParams.maxAttributeType = LuaEnumAttributeType.HolyAttackMax
            local attributeName,attributeValue = Utility.GetAttributeDes(attributeDesParams)
            if CS.StaticUtility.IsNullOrEmpty(attributeName) == false and CS.StaticUtility.IsNullOrEmpty(attributeValue) == false then
                self:AddAttribute(attributeName, attributeValue, isHigherholyAttack)
            end
        end
        --endregion

        --region 神圣防御（神抗）
        if itemInfo.type == luaEnumItemType.HunJi and itemInfo.holyDefenceMin >= 0 and itemInfo.holyDefenceMax > 0 then
            self:AddAttribute("神圣防御", itemInfo.holyDefenceMin .. "-" .. itemInfo.holyDefenceMax)
        end
        if itemInfo ~= nil and itemInfo.holyDefenceMax > 0 then
            local isHigherholyDefence = isAbleToCompare
            if bagItemInfo and equipmentItemInPlayer then
                isHigherholyDefence = isHigherholyDefence and (itemInfo.holyDefenceMax > equipmentItemInPlayer.holyDefenceMax) --holyAttackMax
            end
            rateAttribute = ""
            local rotaHolyDefenceMax = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.HolyDefenceMax)
            if rotaHolyDefenceMax > 0 then
                rateAttribute = "(+" .. tostring(rotaHolyDefenceMax) .. ")[-]"
                self:AddAttribute("[39ce1b]神圣防[-]", "[39ce1b]" .. tostring(itemInfo.holyDefenceMin) .. '-' .. tostring(itemInfo.holyDefenceMax) .. rateAttribute .. '', isHigherholyDefence)
            else
                if itemInfo.holyDefenceMax > 0 then
                    self:AddAttribute(self.attributeNameColor .. "神圣防[-]", tostring(itemInfo.holyDefenceMin) .. '-' .. tostring(itemInfo.holyDefenceMax) .. rateAttribute .. '', isHigherholyDefence)
                end
            end
        end
        --endregion

        --region 穿透
        if itemInfo.penetrationAttributes >= 0 then
            local isHigherpenetrationAttributes = isAbleToCompare
            if equipmentItemInPlayer then
                isHigherpenetrationAttributes = isHigherpenetrationAttributes and (itemInfo.penetrationAttributes > equipmentItemInPlayer.penetrationAttributes)
            end
            rateAttribute = ""
            local rotaPenetrationAttributes = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.PenetrationAttributes)
            if rotaPenetrationAttributes > 0 then
                rateAttribute = "(+" .. tostring(rotaPenetrationAttributes) .. ")[-]"
                self:AddAttribute("[39ce1b]穿透[-]", "[39ce1b]" .. tostring(itemInfo.penetrationAttributes) .. rateAttribute .. '', isHigherpenetrationAttributes)
            else
                if itemInfo.penetrationAttributes > 0 then
                    self:AddAttribute(self.attributeNameColor .. "穿透[-]", tostring(itemInfo.penetrationAttributes) .. rateAttribute .. '', isHigherpenetrationAttributes)
                end
            end
        end
        --endregion

        --region 抗暴
        if itemInfo.resistanceCrit >= 0 then
            local isHigherresistanceCrit = isAbleToCompare
            if equipmentItemInPlayer then
                isHigherresistanceCrit = isHigherresistanceCrit and (itemInfo.resistanceCrit > equipmentItemInPlayer.resistanceCrit)
            end
            rateAttribute = ""
            local rotaResistanceCrit = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.ResistanceCrit)
            if rotaResistanceCrit > 0 then
                rateAttribute = "(+" .. tostring(rotaResistanceCrit) .. ")[-]"
                self:AddAttribute("[39ce1b]抗暴[-]", "[39ce1b]" .. tostring(itemInfo.resistanceCrit) .. rateAttribute .. '', isHigherresistanceCrit)
            else
                if itemInfo.resistanceCrit > 0 then
                    self:AddAttribute(self.attributeNameColor .. "抗暴[-]", tostring(itemInfo.resistanceCrit) .. rateAttribute .. '', isHigherresistanceCrit)
                end
            end
        end
        --endregion

        --region PK伤害加成
        if itemInfo.pkAtt >= 0 then
            local isHigherpkAtt = isAbleToCompare
            if equipmentItemInPlayer then
                isHigherpkAtt = isHigherpkAtt and (itemInfo.pkAtt > equipmentItemInPlayer.pkAtt)
            end
            rateAttribute = ""
            local rotaPkAtt = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.PkAtt)
            if rotaPkAtt > 0 then
                rateAttribute = "(+" .. tostring(rotaPkAtt) .. "%)[-]"
                self:AddAttribute("[39ce1b]PK加伤[-]", "[39ce1b]" .. (itemInfo.pkAtt / 10000) * 100 .. "%" .. rateAttribute .. '', isHigherpkAtt)
            else
                if itemInfo.pkAtt > 0 then
                    self:AddAttribute(self.attributeNameColor .. "PK加伤[-]", (itemInfo.pkAtt / 10000) * 100 .. "%" .. rateAttribute .. '', isHigherpkAtt)
                end
            end
        end
        --endregion

        --region PK伤害消减
        if itemInfo.pkDef >= 0 then
            local isHigherpkDef = isAbleToCompare
            if equipmentItemInPlayer then
                isHigherpkDef = isHigherpkDef and (itemInfo.pkDef > equipmentItemInPlayer.pkDef)
            end
            rateAttribute = ""
            local rotaPkDef = self:FindRateAttributeValue(bagItemInfo, LuaEnumAttributeType.PkDef)
            if rotaPkDef > 0 then
                rateAttribute = "[39ce1b](+" .. tostring(rotaPkDef) .. "%)[-]"
                self:AddAttribute("[39ce1b]PK减伤[-]", "[39ce1b]" .. (itemInfo.pkDef / 10000) * 100 .. "%" .. rateAttribute .. '', isHigherpkDef)
            else
                if itemInfo.pkDef > 0 then
                    self:AddAttribute(self.attributeNameColor .. "PK减伤[-]", (itemInfo.pkDef / 10000) * 100 .. "%" .. rateAttribute .. '', isHigherpkDef)
                end
            end
        end
        --endregion

        --region 威慑伤害
        if itemInfo.delAtk > 0 then
            local isHigherdelAtk = isAbleToCompare
            if equipmentItemInPlayer then
                isHigherdelAtk = isHigherdelAtk and (itemInfo.delAtk > equipmentItemInPlayer.delAtk)
            end
            self:AddAttribute(self.attributeNameColor .. "威慑伤害[-]", itemInfo.delAtk .. "%", isHigherdelAtk)
        end
        --endregion

        --region 抗性
        if itemInfo.resistance >= 0 then
            local isHigherresistance = isAbleToCompare
            if equipmentItemInPlayer then
                isHigherresistance = isHigherresistance and (itemInfo.resistance > equipmentItemInPlayer.resistance)
            end
            rateAttribute = ""
            if itemInfo.resistance > 0 then
                self:AddAttribute(self.attributeNameColor .. "抗性[-]", tostring(itemInfo.resistance) .. "%" .. rateAttribute .. '', isHigherresistance)
            end
        end
        --endregion

        --region 合体生命继承
        if itemInfo.hpPercentage and itemInfo.hpPercentage > 0 then
            local isHigherresistance = isAbleToCompare
            if equipmentItemInPlayer then
                isHigherresistance = isHigherresistance and (itemInfo.hpPercentage > equipmentItemInPlayer.hpPercentage)
            end
            if itemInfo.hpPercentage then
                self:AddAttribute(luaEnumColorType.Green3 .. "【继承】 灵兽合体生命继承[-]", luaEnumColorType.Green3 .. tostring(itemInfo.hpPercentage / 10) .. "%[-]" .. '', isHigherresistance)
            end
        end
        --endregion

        --region 灵兽合体攻击继承
        if (itemInfo.attackPercentage and itemInfo.attackPercentage > 0) then
            local isHigherresistance = isAbleToCompare
            if equipmentItemInPlayer then
                isHigherresistance = isHigherresistance and (itemInfo.attackPercentage > equipmentItemInPlayer.attackPercentage)
            end
            self:AddAttribute(luaEnumColorType.Green3 .. "【继承】 灵兽合体攻击继承[-]", luaEnumColorType.Green3 .. tostring(itemInfo.attackPercentage / 10) .. "%[-]", isHigherresistance);
        end
        --endregion

        --region 灵兽合体切割伤害继承
        if (itemInfo.cutDamage and itemInfo.cutDamage > 0) then
            local isHigherresistance = isAbleToCompare
            if equipmentItemInPlayer then
                isHigherresistance = isHigherresistance and (itemInfo.cutDamage > equipmentItemInPlayer.cutDamage)
            end
            self:AddAttribute(luaEnumColorType.Green3 .. "【继承】 灵兽合体切割伤害继承[-]", luaEnumColorType.Green3 .. tostring(itemInfo.cutDamage / 100) .. "%[-]", isHigherresistance);
        end
        --endregion

        --region 灵兽合体防御继承
        if (itemInfo.defensePercentage and itemInfo.defensePercentage > 0) then
            local isHigherresistance = isAbleToCompare
            if equipmentItemInPlayer then
                isHigherresistance = isHigherresistance and (itemInfo.defensePercentage > equipmentItemInPlayer.defensePercentage)
            end
            self:AddAttribute(luaEnumColorType.Green3 .. "【继承】 灵兽合体防御继承[-]", luaEnumColorType.Green3 .. tostring(itemInfo.defensePercentage / 10) .. "%[-]", isHigherresistance);
        end
        --endregion

        --region 灵兽合体神圣防御继承
        if (itemInfo.sacredDefense and itemInfo.sacredDefense > 0) then
            local isHigherresistance = isAbleToCompare
            if equipmentItemInPlayer then
                isHigherresistance = isHigherresistance and (itemInfo.sacredDefense > equipmentItemInPlayer.sacredDefense)
            end
            self:AddAttribute(luaEnumColorType.Green3 .. "【继承】 灵兽合体神圣防御继承[-]", luaEnumColorType.Green3 .. tostring(itemInfo.sacredDefense / 100) .. "%[-]", isHigherresistance);
        end
        --endregion

        --region 元宝宝箱
        if bagItemInfo ~= nil then
            if itemInfo.type == luaEnumItemType.Assist and itemInfo.subType == 32 and uimanager:GetPanel("UIBagPanel") ~= nil then
                local storateExp = bagItemInfo.luck
                local maxExp = bagItemInfo.maxStar
                local color = Utility.GetBBCode(storateExp >= maxExp)
                self:AddAttribute(Utility.CombineStringQuickly("杀怪进度", ""), Utility.CombineStringQuickly(color, storateExp, "[-]/", maxExp, ""), false)
            end
        end

        --if bagItemInfo ~= nil then
        --    if itemInfo.type == luaEnumItemType.Assist and itemInfo.subType == 32 then
        --        local ustItemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetGatheringInfo(itemInfo.id)
        --        if ustItemCount ~= nil and ustItemCount.totalCount ~= 0 then
        --            local useCount = ustItemCount.useCount
        --            local totalCount = ustItemCount.totalCount
        --            self:AddAttribute("使用次数" .. "", useCount .. "/" .. totalCount .. "", false)
        --        end
        --    end
        --end
        --endregion

        --region 聚灵珠
        --if bagItemInfo ~= nil then
        --    if itemInfo.type == luaEnumItemType.Assist and itemInfo.subType == 4 then
        --        local storateExp = bagItemInfo.luck
        --        local maxExp = bagItemInfo.maxStar
        --        local color = Utility.NewGetBBCode(storateExp >= maxExp)
        --        self:AddAttribute("储存经验" .. "", color .. storateExp .. "[-]/" .. maxExp .. "", false)
        --    end
        --end

        if bagItemInfo ~= nil then
            if itemInfo.type == luaEnumItemType.Assist and itemInfo.subType == 4 then
                local ustItemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetGatheringInfo(itemInfo.id)
                if ustItemCount ~= nil and ustItemCount.totalCount ~= 0 then
                    local useCount = ustItemCount.useCount
                    local totalCount = ustItemCount.totalCount
                    self:AddAttribute("使用次数" .. "", useCount .. "/" .. totalCount .. "", false)
                end
            end
        end
        --endregion

        --region （附件装备）
        --if (self.mExtraEquipList ~= nil) then
        --    for k, v in pairs(self.mExtraEquipList) do
        --        local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(v);
        --        if (isFind) then
        --            self:AddExtraEquipAttribute(v, itemTable.subType);
        --        end
        --    end
        --end
        --endregion

        --region 需要声望
        if itemInfo.type == luaEnumItemType.Equip and itemInfo.subType == LuaEnumEquiptype.Medal and itemInfo.useParam ~= nil and itemInfo.useParam.list ~= nil and itemInfo.useParam.list.Count >= 2 then
            local itemId = itemInfo.useParam.list[0]
            local needNum = itemInfo.useParam.list[1]
            local playerShengWang = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(LuaEnumCoinType.ShengWang);
            playerShengWang = ternary(playerShengWang == nil, 0, playerShengWang)
            local needBlink = playerShengWang >= needNum
            local color = Utility.NewGetBBCode(needBlink)
            local attributeName = "需要声望"
            self:AddAttribute(color .. attributeName .. "", color .. needNum .. "", false, not needBlink)
        end
        --endregion

        --region 使用次数
        if itemInfo.reuseType ~= nil and itemInfo.reuseType.list ~= nil and itemInfo.reuseType.list.Count >= 2 and itemInfo.reuseType.list[0] == LuaEnumItemUseNumType.ShowUIItemInfoPanel and itemInfo.reuseAmount ~= nil and itemInfo.reuseAmount > 0 and bagItemInfo ~= nil and bagItemInfo.leftUseNum ~= nil and bagItemInfo.leftUseNum > 0 then
            local totalUseNum = itemInfo.reuseAmount
            local useNumColor = Utility.NewGetBBCode(bagItemInfo.leftUseNum > 0)
            local contant = "可使用" .. useNumColor .. bagItemInfo.leftUseNum .. "[-]/" .. totalUseNum .. "次"
            self:AddAttribute(contant .. "", "", false)
        end
        --endregion

        --region 幻兽
        if bagItemInfo ~= nil then
            if bagItemInfo.servantInfo ~= nil then
                self:AddAttribute("[e8a657]等级[-]", tostring(bagItemInfo.servantInfo.level) .. '', false)
                self:AddAttribute("[e8a657]转生等级[-]", tostring(bagItemInfo.servantInfo.rein) .. '', false)
            end
        end
        --endregion

        --region 宝物
        if itemInfo.type == luaEnumItemType.Equip then
            ---赤焰灯
            if itemInfo.subType == LuaEnumEquiptype.Light then
                if itemInfo.useParam ~= nil then
                    local needMaterialLevel = itemInfo.useParam.list[itemInfo.useParam.list.Count - 1]
                    local color = self:GetMaterialUseColor(needMaterialLevel, CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_DengXin)
                    if needMaterialLevel > 0 then
                        -- self:AddAttribute("[73ddf7]佩戴条件[-]", "" .. '', false)
                        self:AddAttribute(color .. "需要灯芯等级[-]", color .. tostring(needMaterialLevel) .. '', false)
                    end
                end
            end
            ---魂玉
            if itemInfo.subType == LuaEnumEquiptype.SoulJade then
                if itemInfo.useParam ~= nil then
                    local needMaterialLevel = itemInfo.useParam.list[itemInfo.useParam.list.Count - 1]
                    local color = self:GetMaterialUseColor(needMaterialLevel, CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_ShengMingJingPo)
                    if needMaterialLevel > 0 then
                        -- self:AddAttribute("[73ddf7]佩戴条件[-]", "" .. '', false)
                        self:AddAttribute(color .. "需要玉魂等级[-]", color .. tostring(needMaterialLevel) .. '', false)
                    end
                end
            end
            ---宝石手套
            if itemInfo.subType == LuaEnumEquiptype.Baoshishoutao then
                if itemInfo.useParam ~= nil then
                    local needMaterialLevel = itemInfo.useParam.list[itemInfo.useParam.list.Count - 1]
                    local color = self:GetMaterialUseColor(needMaterialLevel, CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_BaoShi)
                    if needMaterialLevel > 0 then
                        -- self:AddAttribute("[73ddf7]佩戴条件[-]", "" .. '', false)
                        self:AddAttribute(color .. "需要元石等级[-]", color .. tostring(needMaterialLevel) .. '', false)
                    end
                end
            end
            ---元灵秘宝
            if itemInfo.subType == LuaEnumEquiptype.TheSecretTreasureOfYuanling then
                if itemInfo.hsHpRecover and itemInfo.hsHpRecover.list and itemInfo.hsHpRecover.list.Count >= 1 then
                    local isHigherresistance = isAbleToCompare
                    if equipmentItemInPlayer and equipmentItemInPlayer.hsHpRecover and equipmentItemInPlayer.hsHpRecover.list and equipmentItemInPlayer.hsHpRecover.list.Count >= 1 then
                        isHigherresistance = isHigherresistance and (itemInfo.hsHpRecover.list[0] > equipmentItemInPlayer.hsHpRecover.list[0])
                    end
                    self:AddAttribute("灵兽出战回血速度[-]", itemInfo.hsHpRecover.list[0], isHigherresistance)
                end
                if itemInfo.useParam ~= nil then
                    local needMaterialLevel = itemInfo.useParam.list[itemInfo.useParam.list.Count - 1]
                    local jingongColor = self:GetMaterialUseColor(needMaterialLevel, CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_JingGongZhiYuan)
                    local shouhuColor = self:GetMaterialUseColor(needMaterialLevel, CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_ShouHuZhiYuan)
                    if needMaterialLevel > 0 then
                        -- self:AddAttribute("[73ddf7]佩戴条件[-]", "" .. '', false)
                        self:AddAttribute(jingongColor .. "需要进攻之源等级[-]", jingongColor .. tostring(needMaterialLevel) .. '', false)
                        self:AddAttribute(shouhuColor .. "需要守护之源等级[-]", shouhuColor .. tostring(needMaterialLevel) .. '', false)
                    end
                end
            end
            ---灯芯
            if itemInfo.subType == LuaEnumEquiptype.LightComponent then
                if itemInfo.compoundParam ~= nil and itemInfo.compoundParam.list ~= nil and itemInfo.compoundParam.list.Count > 0 then
                    local furnaceCritMultiplier = itemInfo.compoundParam.list[0] / 10000
                    local furnaceCritMultiplierstr = LuaGlobalTableDeal:GetLightComponentDes()
                    furnaceCritMultiplier = Utility.GetPreciseDecimal(furnaceCritMultiplier, 2)
                    furnaceCritMultiplier = Utility.RemoveEndZero(furnaceCritMultiplier)
                    furnaceCritMultiplier = furnaceCritMultiplier + 1
                    furnaceCritMultiplierstr = string .format(furnaceCritMultiplierstr, tostring(furnaceCritMultiplier))
                    self:AddAttribute(furnaceCritMultiplierstr, '' .. '', false)
                end
            end
            ---宝石
            if itemInfo.subType == LuaEnumEquiptype.Gem then
                if itemInfo.compoundParam ~= nil and itemInfo.compoundParam.list ~= nil and itemInfo.compoundParam.list.Count > 0 then
                    local furnaceCritMultiplier = itemInfo.compoundParam.list[0] / 10000
                    local furnaceCritMultiplierstr = LuaGlobalTableDeal:GetGemDes()
                    furnaceCritMultiplier = Utility.GetPreciseDecimal(furnaceCritMultiplier, 2)
                    furnaceCritMultiplier = Utility.RemoveEndZero(furnaceCritMultiplier)
                    furnaceCritMultiplier = furnaceCritMultiplier + 1
                    furnaceCritMultiplierstr = string .format(furnaceCritMultiplierstr, tostring(furnaceCritMultiplier))
                    self:AddAttribute(furnaceCritMultiplierstr, '' .. '', false)
                end
            end
            ---进攻之源
            if itemInfo.subType == LuaEnumEquiptype.Jingongzhiyuan then
                if itemInfo.compoundParam ~= nil and itemInfo.compoundParam.list ~= nil and itemInfo.compoundParam.list.Count > 0 then
                    local furnaceCritMultiplier = itemInfo.compoundParam.list[0] / 10000
                    local furnaceCritMultiplierstr = LuaGlobalTableDeal:GetJingongzhiyuanDes()
                    furnaceCritMultiplier = Utility.GetPreciseDecimal(furnaceCritMultiplier, 2)
                    furnaceCritMultiplier = Utility.RemoveEndZero(furnaceCritMultiplier)
                    furnaceCritMultiplier = furnaceCritMultiplier + 1
                    furnaceCritMultiplierstr = string .format(furnaceCritMultiplierstr, tostring(furnaceCritMultiplier))
                    self:AddAttribute(furnaceCritMultiplierstr, '' .. '', false)
                end
            end
        end
        --endregion

        --region神力装备
        if clientTableManager.cfg_itemsManager:IsDivineSuitEquip(itemInfo.id) then
            local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id)
            if luaItemInfo and luaItemInfo:GetSubType() ~= LuaEquipmentItemType.POS_SL_FABAO then
                local divineInfo = clientTableManager.cfg_divinesuitManager:TryGetValue(luaItemInfo:GetDivineId())
                if divineInfo then
                    local playerHasEquip = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentItem(divineInfo:GetType(), LuaEquipmentItemType.POS_SL_FABAO)
                    local canUse = false
                    if playerHasEquip and playerHasEquip.DivineSuitTbl_lua then
                        canUse = playerHasEquip.DivineSuitTbl_lua:GetLevel() >= divineInfo:GetLevel()
                    end
                    local useColor = canUse and luaEnumColorType.White or luaEnumColorType.Red1
                    local des = divineInfo:GetDressDes()
                    if des and des ~= "" then
                        self:AddAttribute(useColor .. divineInfo:GetDressDes(), "", false)
                    end
                end
            end
        end
        --endregion

        --region 外观装备
        if itemInfo.type == luaEnumItemType.Appearance then
            self:AddAppearanceAttribute(itemInfo.id)
        end
        --endregion

        --region 虎符
        if clientTableManager.cfg_itemsManager:IsHuFuEquip(itemInfo.id) then
            --self:AddHurtBossToHuFuAttribute(itemInfo, isAbleToCompare, equipmentItemInPlayer)
            self:AddHuFuAttribute(itemInfo, isAbleToCompare, equipmentItemInPlayer)
            self:AddConditionAttribute(itemInfo)
        end
        --endregion

        --region 官印
        if clientTableManager.cfg_itemsManager:IsOfficialSealEquip(itemInfo.id) then
            self:AddConditionAttribute(itemInfo)
        end
        --endregion

        --region 额外显示的属性（Extra_Mon_Effect）
        self:ShowExtraMonsterEffectAttribute(itemInfo)
        --endregion

        --region 使用等级
        if self:mNeedShowLevelLimit(itemInfo) then
            local mainPlayerLv = gameMgr:GetLuaMainPlayer():GetLevel()
            local mainPlayerReinLv = gameMgr:GetLuaMainPlayer():GetReinLv()
            if itemInfo.useLv == 0 and itemInfo.reinLv == 0 and CS.Cfg_GlobalTableManager.Instance:ShowNoLevel(itemInfo) then
                self:AddAttribute("无等级")
            else
                if ((itemInfo.useLv and itemInfo.useLv > 0) or (itemInfo.reinLv and itemInfo.reinLv > 0)) then
                    local canUseItem = clientTableManager.cfg_itemsManager:CanUseItem(itemInfo.id, mainPlayerLv, mainPlayerReinLv) == LuaEnumUseItemParam.CanUse
                    --region 物品是否可以使用
                    if uimanager:GetPanel("UIServantPanel") ~= nil then
                        canUseItem = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsCanEquip(itemInfo, uiStaticParameter.SelectedServantType)
                    else
                        local chooseIndex = uiStaticParameter.UIItemInfoManager.ChooseIndex
                        if chooseIndex ~= nil then
                            if chooseIndex == LuaEnumItemInfoPanelPageType.Role then
                                canUseItem = clientTableManager.cfg_itemsManager:CanUseItem(itemInfo.id, mainPlayerLv, mainPlayerReinLv) == LuaEnumUseItemParam.CanUse
                            elseif chooseIndex == LuaEnumItemInfoPanelPageType.Servant_HM or chooseIndex == LuaEnumItemInfoPanelPageType.Servant_LX or chooseIndex == LuaEnumItemInfoPanelPageType.Servant_TC then
                                canUseItem = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsCanEquip(itemInfo, chooseIndex)
                            end
                        end
                    end
                    --endregion

                    local conditionType = itemInfo.useCondition
                    local needBlink = canUseItem == false
                    local useLevelColor = Utility.NewGetBBCode(canUseItem)
                    local useLevel = ""
                    local attributeName = ""
                    if conditionType == LuaEnumUseConditionType.And then
                        useLevel = ternary(itemInfo.reinLv > 0, tostring(itemInfo.reinLv), tostring(itemInfo.useLv))
                        attributeName = ternary(itemInfo.reinLv > 0, "需要转生等级", "需要等级")
                    elseif conditionType == LuaEnumUseConditionType.Or then
                        attributeName = string.format("需要等级 %s 或 转生 %s", itemInfo.useLv, itemInfo.reinLv)
                    end
                    if not needBlink then
                        useLevelColor = ""
                    end
                    self:AddAttribute(useLevelColor .. attributeName .. "", useLevelColor .. useLevel .. "", false, needBlink)
                end
            end
        end
        --endregion

        --region 增加buff显示效果(策划要求只显示buff的描述内容)
        --if (itemInfo ~= nil) then
        --    self:RefreshBuffAttribute(itemInfo)
        --end
        --endregion

        --region 魂装镶嵌条件显示
        local luaItemTable = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id);
        if (luaItemTable ~= nil and gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():IsInlayEquip(luaItemTable)) then
            local equipIndex = Utility.GetEquipIndexByItemInfo(itemInfo);
            ---@type bagV2.BagItemInfo
            local equipInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipInfoByEquipIndex(equipIndex);
            local needLevel, needReinLevel = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetSoulEquipSetNeedLevel(itemInfo.id);
            local color = luaEnumColorType.Red1;
            if (equipInfo ~= nil) then
                ---@type TABLE.cfg_items
                local equipItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(equipInfo.itemId);
                if (equipItemTbl ~= nil) then
                    if (needReinLevel <= equipItemTbl:GetReinLv()) then
                        color = luaEnumColorType.White;
                    end
                end
            end
            if (needReinLevel > 0) then
                self:AddAttribute(color .. "可镶嵌到" .. needReinLevel .. "转装备上[-]", "", "")
            end
        end
        --endregion

        --region 暗器
        local anqiInfo = clientTableManager.cfg_hidden_weaponManager:TryGetValue(itemInfo.id)
        if anqiInfo ~= nil then
            self:AnQiAddAttribute(anqiInfo, itemInfo)
        end
        --endregion

        --region 马牌
        local mapaiInfo = clientTableManager.cfg_horse_cardManager:TryGetValue(itemInfo.id)
        if mapaiInfo ~= nil then
            self:MaPaiAddAttribute(mapaiInfo, itemInfo)
        end
        --endregion

        --region 暴击倍数
        if (itemInfo.criticalHurtAdd and itemInfo.criticalHurtAdd > 0) then
            local isHigherCriticalHurtAdd = isAbleToCompare
            if equipmentItemInPlayer then
                isHigherCriticalHurtAdd = isHigherCriticalHurtAdd and (itemInfo.criticalHurtAdd > equipmentItemInPlayer.criticalHurtAdd)
            end
            local criticalHurtAdd = 1
            criticalHurtAdd = itemInfo.criticalHurtAdd / 10000
            criticalHurtAdd = Utility.GetPreciseDecimal(criticalHurtAdd, 2)
            criticalHurtAdd = Utility.RemoveEndZero(criticalHurtAdd)
            criticalHurtAdd = criticalHurtAdd + 1

            self:AddAttribute(luaEnumColorType.Green3 .. "暴击倍数[-]", luaEnumColorType.Green3 .. tostring(criticalHurtAdd) .. "[-]", isHigherCriticalHurtAdd);
        end
        --endregion

        --region 掉宝率
        if (itemInfo.addDropTreasure and itemInfo.addDropTreasure > 0) then
            local addDropTreasure = 0
            addDropTreasure = Utility.RemoveEndZero(itemInfo.addDropTreasure / 1000)
            self:AddAttribute(self.attributeNameColor .. Utility.GetAttributeName(LuaEnumAttributeType.AddDropTreasure), addDropTreasure .. "%")
        end
    end

    --称号额外属性显示
    if itemInfo ~= nil then
        if itemInfo.type == 2 and itemInfo.subType == 25 or itemInfo.type == 8 and itemInfo.subType == 26 then
            --对boss伤害
            local attackBoss = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id)
            if attackBoss == nil then
                return
            end
            local bossDamage = attackBoss:GetBossDamage()--此处要改成获取对boss造成额外伤害的数据
            if bossDamage > 0 then
                self:AddAttribute(self.attributeNameColor .. "对BOSS额外伤害[-]", bossDamage * 0.01 .. "%")
            end
            ---掉宝率
            local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id)
            if luaItemInfo == nil then
                return
            end
            local rate = luaItemInfo:GetAddDropTreasure()
            if rate > 0 then
                self:AddAttribute(self.attributeNameColor .. "掉宝概率[-]", math.ceil(rate * 0.001) .. "%")
            end
        end
    end
end

--region 外观属性
---添加外观属性(外观属性不走item，而是外观表
---@param itemId number 道具id
function UIItemInfoPanel_Info_BaseAttribute:AddAppearanceAttribute(itemId)
    local luaItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if luaItemTbl == nil then
        return
    end

    local appearanceId = luaItemTbl:GetAppearanceId()
    if appearanceId == 0 then
        return
    end
    if luaItemTbl:GetGetLimitType() and luaItemTbl:GetGetLimitType() == 1 then
        local originItemId = appearanceId
        luaItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(originItemId)
        appearanceId = luaItemTbl:GetAppearanceId()
        if appearanceId == 0 then
            return
        end
    end

    --[[    local params = luaItemTbl:GetUseParam()

        if params == nil or params.list == nil or params.list.Count <= 0 then
            return
        end
        if luaItemTbl:GetGetLimitType() and luaItemTbl:GetGetLimitType() == 1 then
            local originItemId = params.list[0]
            luaItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(originItemId)
            params = luaItemTbl:GetUseParam()
            if params == nil or params.list == nil or params.list.Count <= 0 then
                return
            end
        end]]

    local luaAppearanceTbl = clientTableManager.cfg_appearanceManager:TryGetValue(appearanceId)
    if luaAppearanceTbl == nil then
        return
    end
    local mainPlayerCareer = CS.CSScene.MainPlayerInfo.Career
    local name
    local attrMin
    local attrMax
    --region 攻击
    if mainPlayerCareer == CS.ECareer.Warrior then
        --region 攻击
        attrMin = luaAppearanceTbl:GetPhyAttMin()
        attrMax = luaAppearanceTbl:GetPhyAttMax()
        name = self.attributeNameColor .. "攻击[-]"
        self:AddAppearanceSingleAttribute(attrMin, attrMax, name)
        --endregion
    elseif mainPlayerCareer == CS.ECareer.Master then
        --region 魔法
        attrMin = luaAppearanceTbl:GetMagicAttMin()
        attrMax = luaAppearanceTbl:GetMagicAttMax()
        name = self.attributeNameColor .. Utility.GetAttributeName(LuaEnumAttributeType.MagicAttackMax) .. "[-]"
        self:AddAppearanceSingleAttribute(attrMin, attrMax, name)
        --endregion
    elseif mainPlayerCareer == CS.ECareer.Taoist then
        --region 道术
        attrMin = luaAppearanceTbl:GetMonkAttMin()
        attrMax = luaAppearanceTbl:GetMonkAttMax()
        name = self.attributeNameColor .. "道术[-]"
        self:AddAppearanceSingleAttribute(attrMin, attrMax, name)
        --endregion
    end
    --endregion

    --region 防御
    attrMin = luaAppearanceTbl:GetPhyDenMin()
    attrMax = luaAppearanceTbl:GetPhyDenMax()
    name = self.attributeNameColor .. "防御[-]"
    self:AddAppearanceSingleAttribute(attrMin, attrMax, name)
    --endregion

    --region  魔防
    attrMin = luaAppearanceTbl:GetMagicDenMin()
    attrMax = luaAppearanceTbl:GetMagicDenMax()
    name = self.attributeNameColor .. "魔防[-]"
    self:AddAppearanceSingleAttribute(attrMin, attrMax, name)
    --endregion

    --region 血量
    attrMax = luaAppearanceTbl:GetBlood()
    name = self.attributeNameColor .. Utility.GetAttributeName(LuaEnumAttributeType.MaxHp) .. "[-]"
    self:AddAppearanceSingleAttribute(0, attrMax, name)
    --endregion

    --region 对boss伤害
    attrMax = Utility.RemoveEndZero(luaAppearanceTbl:GetMonsterHurtAdd() / 100)
    name = self.attributeNameColor .. Utility.GetAttributeName(LuaEnumAttributeType.MonsterHuntAdd) .. "[-]"
    self:AddAppearanceSingleAttribute(0, attrMax, name, LuaEnumAttributeValueShowType.Percent)
    --endregion

    --region 掉落率
    attrMax = Utility.RemoveEndZero(luaAppearanceTbl:GetAddDropTreasure() / 1000)
    name = self.attributeNameColor .. Utility.GetAttributeName(LuaEnumAttributeType.AddDropTreasure) .. "[-]"
    self:AddAppearanceSingleAttribute(0, attrMax, name, LuaEnumAttributeValueShowType.Percent)
    --endregion
end

---添加单条外观属性
---@param attrMin number
---@param attrMax number
---@param name string
---@param attributeValueShowType LuaEnumAttributeValueShowType
function UIItemInfoPanel_Info_BaseAttribute:AddAppearanceSingleAttribute(attrMin, attrMax, name, attributeValueShowType)
    local str
    local extraSymbol = ""
    if attributeValueShowType ~= nil and attributeValueShowType == LuaEnumAttributeValueShowType.Percent then
        extraSymbol = "%"
    elseif attributeValueShowType ~= nil and attributeValueShowType == LuaEnumAttributeValueShowType.AllGrades then
        extraSymbol = "‱"
    end
    if attrMin ~= 0 and attrMax ~= 0 then
        str = Utility.CombineStringQuickly(attrMin .. extraSymbol, "-", attrMax .. extraSymbol)
    elseif attrMin ~= 0 then
        str = attrMin .. extraSymbol
    elseif attrMax ~= 0 then
        str = attrMax .. extraSymbol
    end
    if str then
        self:AddAttribute(name, str)
    end
end

--endregion

--region buff显示效果
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_Info_BaseAttribute:RefreshBuffAttribute(itemInfo)
    if itemInfo == nil then
        return
    end
    local des = clientTableManager.cfg_itemsManager:GetBuffDes(itemInfo.id)
    if CS.StaticUtility.IsNullOrEmpty(des) == false then
        local des = string.gsub(des, '\\n', '\n')
        self:AddAttribute("[00FF00]" .. des, nil, nil, nil, 280)
    end
end
--endregion

--region 虎符（称号   获取对Boss造成额外伤害的数据
function UIItemInfoPanel_Info_BaseAttribute:AddHurtBossToHuFuAttribute(itemInfo, isAbleToCompare, equipmentItemInPlayer)
    -- body
    --===============================获取对Boss造成额外伤害数据==========================================
    local attackBoss = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id)
    if attackBoss == nil then
        return
    end
    local bossDamage = attackBoss:GetBossDamage()--此处要改成获取对boss造成额外伤害的数据
    if bossDamage > 0 then
        local isHigherDropRate = isAbleToCompare
        if equipmentItemInPlayer then
            local luaPlayerEquipedInfo = clientTableManager.cfg_itemsManager:TryGetValue(equipmentItemInPlayer.id)
            if luaPlayerEquipedInfo then
                isHigherDropRate = isHigherDropRate and (bossDamage > luaPlayerEquipedInfo:GetBossDamage())
            end
        end
        self:AddAttribute(self.attributeNameColor .. "对BOSS额外伤害[-]", bossDamage * 0.01 .. "%", isHigherDropRate)
    end
end
--region 虎符（称号
function UIItemInfoPanel_Info_BaseAttribute:AddHuFuAttribute(itemInfo, isAbleToCompare, equipmentItemInPlayer)
    --===============================获取掉宝概率数据==========================================
    local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id)
    if luaItemInfo == nil then
        return
    end
    local rate = luaItemInfo:GetAddDropTreasure()
    if rate > 0 then
        local isHigherDropRate = isAbleToCompare
        if equipmentItemInPlayer then
            local luaPlayerEquipedInfo = clientTableManager.cfg_itemsManager:TryGetValue(equipmentItemInPlayer.id)
            if luaPlayerEquipedInfo then
                isHigherDropRate = isHigherDropRate and (rate > luaPlayerEquipedInfo:GetAddDropTreasure())
            end
        end
        self:AddAttribute(self.attributeNameColor .. "掉宝概率[-]", math.ceil(rate * 0.001) .. "%", isHigherDropRate)
    end
end
--endregion

--region 额外显示的属性（Extra_Mon_Effect）
---刷新额外显示属性，依托服务器配置的属性
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_Info_BaseAttribute:ShowExtraMonsterEffectAttribute(itemInfo)
    if itemInfo == nil then
        return
    end
    local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id)
    if luaItemInfo == nil or type(luaItemInfo:GetExtraMonEffect()) ~= 'number' then
        return
    end
    self:RefreshSingleExtraMonsterEffectAttributeList(luaItemInfo:GetExtraMonEffect())
end

---刷新单个额外效果属性列表
---@param extraMonEffectId number cfg_extra_mon_effect表id
function UIItemInfoPanel_Info_BaseAttribute:RefreshSingleExtraMonsterEffectAttributeList(extraMonEffectId)
    if type(extraMonEffectId) ~= 'number' then
        return
    end
    local extraMonEffectTbl = clientTableManager.cfg_extra_mon_effectManager:TryGetValue(extraMonEffectId)
    if extraMonEffectTbl == nil then
        return
    end
    local extraMonEffectTableManager = clientTableManager.cfg_extra_mon_effectManager
    for k, v in pairs(LuaEnumExtraAttributeType) do
        local extraAttributeType = v
        local addStr = extraMonEffectTableManager:GetExtraAttributeValueStr(extraMonEffectId, extraAttributeType, self.career)
        local name = extraMonEffectTableManager:GetExtraAttributeName(extraMonEffectId, extraAttributeType)
        if CS.StaticUtility.IsNullOrEmpty(name) == false and CS.StaticUtility.IsNullOrEmpty(addStr) == false then
            self:AddAttribute(name, addStr, false)
        end
    end
end
--endregion

--region Condition 类似虎符和官印没有等级的道具根据condition字段显示条件
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_Info_BaseAttribute:AddConditionAttribute(itemInfo)
    local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id)
    if luaItemInfo == nil then
        return
    end
    local conditions = luaItemInfo:GetConditions()
    if conditions and conditions.list and #conditions.list > 0 then
        local str = ""
        for i = 1, #conditions.list do
            local id = conditions.list[i]
            local conditionInfo = clientTableManager.cfg_conditionsManager:TryGetValue(id)
            if conditionInfo then
                ---@type LuaMatchConditionResult
                local result = Utility.IsMainPlayerMatchCondition(id)
                local useLevelColor = Utility.NewGetBBCode(result.success)
                str = Utility.CombineStringQuickly(str, useLevelColor .. conditionInfo:GetShow(), " ")
            end
        end

        self:AddAttribute(self.attributeNameColor .. str)
    end
end
--endregion

---@param itemInfo TABLE.CFG_ITEMS 物品信息
function UIItemInfoPanel_Info_BaseAttribute:RefreshNoBagItemInfoAttributes(itemInfo)
    if itemInfo then
        local mainplayerinfo = CS.CSScene.MainPlayerInfo
        local mainPlayerCareerNum = Utility.EnumToInt(mainplayerinfo.Career)

        --region 使用等级
        if itemInfo.useLv == 0 and itemInfo.reinLv == 0 and CS.Cfg_GlobalTableManager.Instance:ShowNoLevel(itemInfo) then
            self:AddAttribute("无等级")
        else
            if ((itemInfo.useLv and itemInfo.useLv > 0) or (itemInfo.reinLv and itemInfo.reinLv > 0)) and itemInfo.type == luaEnumItemType.Equip then
                local needBlink = (CS.CSScene.MainPlayerInfo.Level >= itemInfo.useLv) and (CS.CSScene.MainPlayerInfo.ReinLevel >= itemInfo.reinLv)
                local useLevelColor = Utility.NewGetBBCode(needBlink)
                local useLevel = ternary(itemInfo.reinLv > 0, tostring(itemInfo.reinLv), tostring(itemInfo.useLv))
                local attributeName = ternary(itemInfo.reinLv > 0, "需要转生等级", "需要等级")
                if not needBlink then
                    useLevelColor = ""
                end
                self:AddAttribute(useLevelColor .. attributeName .. "", useLevelColor .. useLevel .. "", false, not needBlink)
            end
        end
        --endregion
    end
end

---暗器信息添加
---@param anqi TABLE.cfg_hidden_weapon 物品信息
function UIItemInfoPanel_Info_BaseAttribute:AnQiAddAttribute(anqi, itemInfo)
    if anqi ~= nil then
        local titleName1 = "击落马概率增加"
        local des1 = tostring(math.ceil(anqi:GetFallHorse() / 100)) .. "%"
        self:AddAttribute(titleName1, des1)
        local titleName2 = "穿透伤害"
        local des2 = anqi:GetRealAtk()
        self:AddAttribute(titleName2, des2)
        local luaItemTable = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id);
        if luaItemTable ~= nil and luaItemTable:GetConditions() ~= nil then
            local list = luaItemTable:GetConditions().list
            if list ~= nil and #list >= 1 then
                ---@type LuaMatchConditionResult
                local data = Utility.IsMainPlayerMatchCondition(list[1])
                if data ~= nil then
                    local color = ""
                    if data.success == false then
                        color = "[ff0000]"
                    end
                    local des = color .. data.txt
                    self:AddAttribute(des, "")
                end
            end
        end

    end
end

---马牌信息添加
---@param mapai TABLE.cfg_horse_card 物品信息
function UIItemInfoPanel_Info_BaseAttribute:MaPaiAddAttribute(mapai, itemInfo)
    if mapai ~= nil then
        if mapai:GetAtkPer() ~= nil then
            local titleName1 = "骑战增伤"
            print(mapai:GetAtkPer())
            local des1 = tostring(math.ceil(mapai:GetAtkPer() / 100)) .. "%"
            self:AddAttribute(titleName1, des1)
        end
        local luaItemTable = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id);
        if luaItemTable ~= nil and luaItemTable:GetConditions() ~= nil then
            local list = luaItemTable:GetConditions().list
            if list ~= nil and #list >= 1 then
                ---@type LuaMatchConditionResult
                local data = Utility.IsMainPlayerMatchCondition(list[1])
                if data ~= nil then
                    local color = ""
                    if data.success == false then
                        color = "[ff0000]"
                    end
                    local des = color .. data.txt
                    self:AddAttribute(des, "")
                end
            end
        end
    end
end

function UIItemInfoPanel_Info_BaseAttribute:ClearAttributeData()
    self.count = 0
    self.attrNameStr = ""
    self.attrValueStr = ""
    self.showArrowSign = 0
    self.attributeTable = {}
end

---设置属性
function UIItemInfoPanel_Info_BaseAttribute:SetAttribute(attributeName, minValue, maxValue, rateValue, isHigherPhyAttack)
    local mattributeName = nil
    local mattributeValue = nil
    if isHigherPhyAttack then
        mattributeName = UIItemInfoPanel_Info_BaseAttribute.rateColor .. attributeName .. "[-]"
        if #rateValue > 1 then
            mattributeValue = UIItemInfoPanel_Info_BaseAttribute.rateColor .. tostring(minValue + rateValue[1]) .. tostring(maxValue + rateValue[2]) .. "(+" .. rateValue[2] .. ")[-]"
        else
            mattributeValue = UIItemInfoPanel_Info_BaseAttribute.rateColor .. tostring(minValue + rateValue[1]) .. "(+" .. rateValue[1] .. ")[-]"
        end
    else
        mattributeName = UIItemInfoPanel_Info_BaseAttribute.rateColor .. attributeName .. "[-]"
        if maxValue ~= nil then
            mattributeValue = minValue .. maxValue
        else
            mattributeValue = minValue
        end
    end
    UIItemInfoPanel_Info_BaseAttribute:AddAttribute(mattributeName, mattributeValue, isHigherPhyAttack)
end

---属性比较(目前只针对攻击和防御，其他需求后续增加)
---@param equipAttributeMax number 对比物品的item表属性最大值
---@param equipAttributeMin number 对比物品的item表属性最小值
---@param equipRotaAttributeMax number 对比物品的BagItemInfo浮动属性最大值
---@param playerEquipAttributeMax number 被对比物品item表属性最大值
---@param playerEquipAttributeMin number 被对比物品item表属性最小值
---@param playerEquipRotaValueMax number 被对比物品BagItemInfo浮动属性最大值
---@return boolean 对比结果
function UIItemInfoPanel_Info_BaseAttribute:CompareAttribute(equipAttributeMax, equipAttributeMin, equipRotaAttributeMax, playerEquipAttributeMax, playerEquipAttributeMin, playerEquipRotaValueMax)
    if equipRotaAttributeMax ~= nil and playerEquipRotaValueMax ~= nil and equipAttributeMax ~= nil and playerEquipAttributeMax ~= nil then
        local attributeMax = equipAttributeMax + equipRotaAttributeMax
        local playerAttributeMax = playerEquipAttributeMax + playerEquipRotaValueMax
        if attributeMax > playerAttributeMax then
            return true
        elseif attributeMax < playerAttributeMax then
            return false
        else
            return equipAttributeMin > playerEquipAttributeMin
        end
    else

    end
    return false
end

---@param bagItemInfo bagV2.BagItemInfo
function UIItemInfoPanel_Info_BaseAttribute:SetIntensify(bagItemInfo, showCareer)
    if bagItemInfo ~= nil and bagItemInfo.intensify ~= nil and bagItemInfo.intensify > 0 and bagItemInfo.ItemTABLE ~= nil then
        local showIntensifyAttribute = true
        --if CS.CSScene.MainPlayerInfo.EquipInfo:CheckHaveCareerAttackAttribute(bagItemInfo.ItemTABLE, self.career) == true then
        --    showIntensifyAttribute = self.career == showCareer
        --else
        --    showIntensifyAttribute = false
        --end
        --showIntensifyAttribute = self.career == showCareer
        if showIntensifyAttribute == true then
            local attrIntensify_GameObject = self:GetAttrIntensify_UIGridContainer().controlList[self.count]
            attrIntensify_GameObject:SetActive(true)
            local content = CS.Utility_Lua.GetComponent(attrIntensify_GameObject.transform:Find("num"), "UILabel")
            local starIcon = CS.Utility_Lua.GetComponent(attrIntensify_GameObject.transform:Find("star"), "UISprite")
            local star, icon = Utility.GetIntensifyShow(bagItemInfo.intensify)
            local attr = 0
            local info = CS.Cfg_IntensifyTableManager.Instance:GetItems(bagItemInfo.intensify)
            if info then
                attr = tostring(info.attAdd)
            end
            local intensify = star .. "（" .. "0-" .. attr .. "）"
            starIcon.spriteName = icon
            starIcon.gameObject:SetActive(bagItemInfo.intensify > 0)
            content.text = intensify
        end
    end
end

---@class LuaItemInfoSingleAttribute
---@field attributeName string 属性名字
---@field attributeValue string 属性值
---@field isShowArrow boolean 是否显示箭头
---@field needBlink boolean 是否闪烁
---@field sizeWidth int 尺寸宽度

function UIItemInfoPanel_Info_BaseAttribute:AddAttribute(attributeName, attributeValue, isShowArrow, needBlink, sizeWidth)
    self.count = self.count + 1
    local singleAttribute = {}
    singleAttribute.attributeName = attributeName
    singleAttribute.attributeValue = attributeValue
    singleAttribute.isShowArrow = isShowArrow == true
    singleAttribute.needBlink = needBlink
    singleAttribute.sizeWidth = sizeWidth
    if isShowArrow == true then
        self.isShowArrow = true
    end
    table.insert(self.attributeTable, singleAttribute)
    --self.attrNameStr = self.attrNameStr .. attributeName
    --self.attrValueStr = self.attrValueStr .. attributeValue
    --self.showArrowSign = (self.showArrowSign | ternary(isShowArrow, 1, 0)) << 1
end

function UIItemInfoPanel_Info_BaseAttribute:ShowAttribute(itemInfo)
    if itemInfo.type == luaEnumItemType.Equip or itemInfo.type == luaEnumItemType.Appearance then
        self:GetTitleLabel_UILabel().gameObject:SetActive(true)
        self:GetTitleLabel_UILabel().text = ternary(self.count == 0, "", "[73ddf7]基础属性")
    elseif itemInfo.type == luaEnumItemType.HunJi then
        self:GetTitleLabel_UILabel().gameObject:SetActive(true)
        self:GetTitleLabel_UILabel().text = ternary(self.count == 0, "", "[73ddf7]魂继属性")
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
        luaclass.UIRefresh:RefreshActive(attrName, CS.StaticUtility.IsNullOrEmpty(attribute.attributeName) == false)
        attrName.text = attribute.attributeName
        luaclass.UIRefresh:RefreshActive(attrValue, CS.StaticUtility.IsNullOrEmpty(attribute.attributeValue) == false)
        attrValue.text = attribute.attributeValue

        if (attribute.sizeWidth ~= nil) then
            attrName.overflowMethod = CS.UILabel.Overflow.ResizeHeight
            attrName.width = attribute.sizeWidth
        else
            attrName.overflowMethod = CS.UILabel.Overflow.ResizeFreely
        end

        if attribute.needBlink ~= nil then
            if self.compareBagItemInfo == nil or attribute.needBlink == false then
                attrName.color = CS.UnityEngine.Color.white
            else
                --self:AddBlinkList(attrName.transform)
                --self:AddBlinkList(attrValue.transform)
                attrName.color = CS.UnityEngine.Color.red
            end
        end
        arrow:SetActive(attribute.isShowArrow)
    end
    if #self.attributeTable == 0 then
        self.go:SetActive(false)
    end
    local pixelOffsetVec_Y = self:GetAttrIntensify_UIAnchor().pixelOffset.y
    if self.isShowArrow == true then
        self:GetAttrIntensify_UIAnchor().pixelOffset = CS.UnityEngine.Vector2(self:GetAttrIntensify_UIAnchor().pixelOffset.x + self:GetArrowWidth(), pixelOffsetVec_Y)
    else
        self:GetAttrIntensify_UIAnchor().pixelOffset = CS.UnityEngine.Vector2(self:GetAttrIntensify_UIAnchor().pixelOffset.x, pixelOffsetVec_Y)
    end
end

---根据属性类型找到属性浮动表的值
function UIItemInfoPanel_Info_BaseAttribute:FindRateAttributeValue(bagItemInfo, type)
    if bagItemInfo and bagItemInfo.rateAttribute then
        local length = bagItemInfo.rateAttribute.Count - 1
        for k = 0, length do
            local v = bagItemInfo.rateAttribute[k]
            if v ~= nil and v.type == type then
                return v.num
            end
        end
    end
    return 0
end

---添加特殊装备属性
function UIItemInfoPanel_Info_BaseAttribute:AddExtraEquipAttribute(extraEquipId, type)
    if (self.itemInfo == nil) then
        return ;
    end
    --self:ClearAttributeData();

    --self:RefreshNoBagItemInfoAttributes(self.itemInfo)ReqChat

    if self.itemInfo.subType == LuaEnumEquiptype.Light then
        ---赤炎灯
        local otherEquipId_0 = extraEquipId
        local isFind, otherEquip_0 = CS.Cfg_ItemsTableManager.Instance:TryGetValue(otherEquipId_0);
        if (isFind and otherEquipId_0 ~= 0) then
            self:AddAttribute("暴击伤害[-]", tostring(otherEquip_0.criticalDamage) .. '', false)
            if (otherEquip_0.seckill ~= nil) then
                self:AddAttribute("秒杀血量[-]", tostring(Utility.RemoveEndZero(otherEquip_0.seckill.list[0] / 100) .. '%') .. '', false)
                self:AddAttribute("秒杀概率[-]", tostring(Utility.RemoveEndZero(otherEquip_0.seckill.list[1] / 100) .. '%') .. '', false)
            end
        end
    elseif self.itemInfo.subType == LuaEnumEquiptype.SoulJade then
        ---魂玉
        local otherEquipId_0 = extraEquipId
        local isFind, otherEquip_0 = CS.Cfg_ItemsTableManager.Instance:TryGetValue(otherEquipId_0);
        if (isFind and otherEquipId_0 ~= 0) then
            local hp = 0;
            local length = otherEquip_0.maxHp.list.Count - 1
            for k = 0, length do
                local v = otherEquip_0.maxHp.list[k]
                if v ~= nil and v.list[0] == Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career) then
                    hp = v.list[1];
                    break ;
                end
            end
            self:AddAttribute(Utility.GetAttributeName(LuaEnumAttributeType.MaxHp) .. "[-]", tostring(hp) .. '', false)
        end
    elseif self.itemInfo.subType == LuaEnumEquiptype.TheSecretTreasureOfYuanling then
        ---灵兽秘宝
        if (type == LuaEnumEquiptype.Jingongzhiyuan) then
            local isFind_0, otherEquip_0 = CS.Cfg_ItemsTableManager.Instance:TryGetValue(extraEquipId);
            if (isFind_0 and otherEquip_0 ~= 0) then
                self:AddAttribute(luaEnumColorType.Green3 .. "【继承】 灵兽合体攻击继承", luaEnumColorType.Green3 .. tostring(otherEquip_0.attackPercentage / 10) .. '%[-]', false)
                self:AddAttribute(luaEnumColorType.Green3 .. "【继承】 灵兽合体切割伤害继承", luaEnumColorType.Green3 .. tostring(otherEquip_0.cutDamage / 100) .. '%[-]', false)
            end
        end
        if (type == LuaEnumEquiptype.Shouhuzhiyuan) then
            local isFind_1, otherEquip_1 = CS.Cfg_ItemsTableManager.Instance:TryGetValue(extraEquipId);
            if (isFind_1 and otherEquip_1 ~= 0) then
                self:AddAttribute(luaEnumColorType.Green3 .. "【继承】 灵兽合体防御继承", luaEnumColorType.Green3 .. tostring(otherEquip_1.defensePercentage / 10) .. '%[-]', false)
                self:AddAttribute(luaEnumColorType.Green3 .. "【继承】 灵兽合体神圣防御继承", luaEnumColorType.Green3 .. tostring(otherEquip_1.sacredDefense / 100) .. '%[-]', false)
            end
        end
    elseif self.itemInfo.subType == LuaEnumEquiptype.Baoshishoutao then
        ---宝石
        local otherEquipId_0 = extraEquipId
        local isFind, otherEquip_0 = CS.Cfg_ItemsTableManager.Instance:TryGetValue(otherEquipId_0);
        if (isFind and otherEquipId_0 ~= 0) then
            local attributeName = "";
            local attributeValue = "";
            if CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior then
                attributeName = "物攻";
                attributeValue = otherEquip_0.phyAttackMin .. "-" .. otherEquip_0.phyAttackMax;
            elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master then
                attributeName = "魔攻";
                attributeValue = otherEquip_0.magicAttackMin .. "-" .. otherEquip_0.magicAttackMax;
            elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist then
                attributeName = "道攻";
                attributeValue = otherEquip_0.taoAttackMin .. "-" .. otherEquip_0.taoAttackMax;
            end
            self:AddAttribute(attributeName .. "", attributeValue .. '', false)
            if (otherEquip_0.suckBloodFake ~= nil) then
                self:AddAttribute("吸血概率", Utility.RemoveEndZero(otherEquip_0.suckBloodFake.list[0] / 100) .. '%' .. '', false)
                self:AddAttribute("吸血比例", Utility.RemoveEndZero(otherEquip_0.suckBloodFake.list[1] / 100) .. '%' .. '', false)
            end
        end
    end
    --endregion
    self:ShowAttribute(self.itemInfo);
end

function UIItemInfoPanel_Info_BaseAttribute:GetAttributeShowColor(attributeId)
    ---读表数据
    if self.baseAttributeColor == nil then
        local baseAttributeColorIsFind, baseAttributeColor = CS.Cfg_GlobalTableManager.Instance:TryGetValue(20352)
        if baseAttributeColorIsFind then
            self.baseAttributeColor = {}
            local allAttributeColor = string.Split(baseAttributeColor.value, '&')
            for k, v in pairs(allAttributeColor) do
                local singleAttributeColor = string.Split(v, '#')
                if singleAttributeColor ~= nil then
                    self.baseAttributeColor[singleAttributeColor[1]] = singleAttributeColor[2]
                end
            end
        end
    end
    if self.baseAttributeColor ~= nil and attributeId ~= nil and self.baseAttributeColor[attributeId] ~= nil then
        return self.baseAttributeColor[attributeId]
    end
    return ""
end

---获取材料使用条件颜色
---@param 需要等级
---@param 材料的ItemId
function UIItemInfoPanel_Info_BaseAttribute:GetMaterialUseColor(needLevel, materialItemId)
    local materialLevel = 0
    local color = ""
    if materialItemId ~= 0 then
        local isFind, materialItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(materialItemId)
        if isFind then
            materialLevel = materialItemInfo.useParam.list[0]
            color = Utility.NewGetBBCode(materialLevel >= needLevel)
            return color
        end
    else
        return '[ff0000]'
    end
end

function UIItemInfoPanel_Info_BaseAttribute:GetBetterAttributeType()
    if self.itemInfoSource == luaEnumItemInfoSource.UIREFINERESULT then
        self.betterAttributeType = CS.BetterAttributeReason.Null
        local uiRefineResultPanel = uimanager:GetPanel("UIRefineResultPanel")
        if uiRefineResultPanel ~= nil then
            self.betterAttributeType = uiRefineResultPanel:GetArrowAttributeType()
        end
    end
end

function UIItemInfoPanel_Info_BaseAttribute:IsRefineBetterBagItemInfo()
    if self.itemInfoSource == luaEnumItemInfoSource.UIREFINERESULT then
        local uiRefineResultPanel = uimanager:GetPanel("UIRefineResultPanel")
        if uiRefineResultPanel ~= nil then
            return uiRefineResultPanel:IsBetterBagItemInfo(self.bagItemInfo)
        end
    end
    return false
end

---@return boolean 是否显示等级
function UIItemInfoPanel_Info_BaseAttribute:mNeedShowLevelLimit(itemInfo)
    --神力装备部分不显示
    if clientTableManager.cfg_itemsManager:IsDivineSuitEquip(itemInfo.id) then
        local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id)
        if luaItemInfo and luaItemInfo:GetSubType() ~= LuaEquipmentItemType.POS_SL_FABAO then
            local divineInfo = clientTableManager.cfg_divinesuitManager:TryGetValue(luaItemInfo:GetDivineId())
            if divineInfo then
                local des = divineInfo:GetDressDes()
                if des and des ~= "" then
                    return false
                end
            end
        end
    end

    --官印和虎符另外显示
    if clientTableManager.cfg_itemsManager:IsOfficialSealEquip(itemInfo.id) or clientTableManager.cfg_itemsManager:IsHuFuEquip(itemInfo.id) then
        return
    end

    if itemInfo.type == luaEnumItemType.Equip then
        return true
    end
    return false
end

return UIItemInfoPanel_Info_BaseAttribute