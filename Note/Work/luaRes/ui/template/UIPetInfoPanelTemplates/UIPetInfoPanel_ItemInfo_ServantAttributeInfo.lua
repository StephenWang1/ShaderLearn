local UIPetInfoPanel_ItemInfo_ServantAttributeInfo = {}
setmetatable(UIPetInfoPanel_ItemInfo_ServantAttributeInfo,luaComponentTemplates.UIItemInfoPanel_ServentAttributeInfo)

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIPetInfoPanel_ItemInfo_ServantAttributeInfo:RefreshWithInfo(commonData)
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    self:ClearAttributeData()
    self:RefreshAttributes(bagItemInfo, itemInfo)
    self:ShowAttribute(itemInfo)
end

---@param bagItemInfo bagV2.BagItemInfo 背包信息
---@param itemInfo TABLE.CFG_ITEMS 物品信息
function UIPetInfoPanel_ItemInfo_ServantAttributeInfo:RefreshAttributes(bagItemInfo, itemInfo)
    if self:GetAttributeBackGround_GameObject() and CS.StaticUtility.IsNull(self:GetAttributeBackGround_GameObject()) == false then
        self:GetAttributeBackGround_GameObject():SetActive(false)
    end
    ---传入的灵兽信息
    if itemInfo then
        ___, self.serventInfoTable = CS.Cfg_ServantTableManager.Instance:TryGetValue(itemInfo.useParam.list[0])
    end

    if itemInfo and self.serventInfoTable ~= nil then
        ---攻击
        local baseAttack = self.serventInfoTable.attackQualifications
        local isHigherAttack = false
        local attackColor = Utility.GetGRCode(false)
        local attackAttributeValue = self.serventInfoTable.attackQualifications
        if baseAttack > 0 then
            self:AddAttribute(attackColor .. "攻         击" .. "[-]" .. '', attackColor .. attackAttributeValue, isHigherAttack)
        end

        ---物防
        local basePhyDefence = self.serventInfoTable.phyDefenceQualifications
        local isHigherphyDefence = false
        local defenceColor = Utility.GetGRCode(false)
        local defenceAttributeValue = self.serventInfoTable.phyDefenceQualifications
        if basePhyDefence > 0 then
            self:AddAttribute(defenceColor .. "防         御" .. "[-]" .. '', defenceColor .. defenceAttributeValue, isHigherphyDefence)
        end

        ---魔防
        local baseMagicDefence = self.serventInfoTable.magicDefenceQualifications
        local isHighermagicDefence = false
        local magicDefenceColor = Utility.GetGRCode(false)
        local magicDefenceAttributeValue = self.serventInfoTable.magicDefenceQualifications
        if baseMagicDefence > 0 then
            self:AddAttribute(magicDefenceColor .. "魔         防" .. "[-]" .. '', magicDefenceColor .. magicDefenceAttributeValue, isHighermagicDefence)
        end

        ---生命
        local baseHp = self.serventInfoTable.hpQualifications
        local isHigherHP = false
        local hpColor = Utility.GetGRCode(false)
        local hpAttributeValue = self.serventInfoTable.hpQualifications
        if baseHp > 0 then
            self:AddAttribute(hpColor .. "生         命" .. "[-]" .. '', hpColor .. hpAttributeValue, isHigherHP)
        end

        ---神圣攻击
        local baseHolyAttack = self.serventInfoTable.holyAttackQualifications
        local isHigherholyAttack = false
        local holyAttackColor = Utility.GetGRCode(false)
        local holyAttackAttributeValue = self.serventInfoTable.holyAttackQualifications
        if baseHolyAttack > 0 then
            self:AddAttribute(holyAttackColor .. Utility.GetAttributeName(LuaEnumAttributeType.HolyAttackMax) .. "[-]" .. '', holyAttackColor .. holyAttackAttributeValue, isHigherholyAttack)
        end

        ---神圣防御
        local baseHolyDefence = self.serventInfoTable.holyDefenceQualifications
        local isHigherholyDefence = false
        local holyDefenceColor = Utility.GetGRCode(false)
        local holyDefenceAttributeValue = self.serventInfoTable.holyDefenceQualifications
        if baseHolyDefence > 0 then
            self:AddAttribute(holyDefenceColor .. Utility.GetAttributeName(LuaEnumAttributeType.HolyDefenceMax) .. "[-]" .. '', holyDefenceColor .. holyDefenceAttributeValue, isHigherholyDefence)
        end

        ---使用等级
        --if ((itemInfo.useLv and itemInfo.useLv > 0) or (itemInfo.reinLv and itemInfo.reinLv > 0)) then
        --    local useLevelColor = Utility.NewGetBBCode((CS.CSScene.MainPlayerInfo.Level >= itemInfo.useLv) and (CS.CSScene.MainPlayerInfo.ReinLevel >= itemInfo.reinLv))
        --    local useLevel = ternary(itemInfo.reinLv > 0, tostring(itemInfo.reinLv), tostring(itemInfo.useLv))
        --    local attributeName = ternary(itemInfo.reinLv > 0, "需要转生 ", "需要等级 ")
        --    self:AddAttribute(useLevelColor .. attributeName .. "", useLevelColor .. useLevel .. "", false)
        --end

        ---设置属性图(六芒星)
        --local attributeMaxValue = CS.Cfg_GlobalTableManager.Instance:GetAttributeMaxValue(self.serventInfoTable.type)
        --if attributeMaxValue.Length > 0 then
        --    local attributeTable ={}
        --    attributeTable[0] = rotaMaxMagicDefence
        --    attributeTable[1] = rotaMaxHolyAttack
        --    attributeTable[2] = rotaMaxDefence
        --    attributeTable[3] = rotaMaxHp
        --    attributeTable[4] = rotaMaxHolyDefence
        --    attributeTable[5] = rotaMaxPhyAttack
        --    self:SetAttributeGraph(attributeTable,attributeMaxValue)
        --end

        ---设置属性图（条形）
        local attributeMaxValue = CS.Cfg_GlobalTableManager.Instance:GetAttributeMaxValue(self.serventInfoTable.type)
        if attributeMaxValue.Length > 0 then
            local attributeTable = {}
            attributeTable[0] = attackAttributeValue
            attributeTable[1] = defenceAttributeValue
            attributeTable[2] = magicDefenceAttributeValue
            attributeTable[3] = hpAttributeValue
            attributeTable[4] = holyAttackAttributeValue
            attributeTable[5] = holyDefenceAttributeValue
            self:UIItemInfoPanel_ServentAttributeInfo_Bar(attributeTable, attributeMaxValue)
        end
    end
end

return UIPetInfoPanel_ItemInfo_ServantAttributeInfo