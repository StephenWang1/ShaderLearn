---@class UIItemInfoPanel_Info_ExtraAttribute 物品信息界面信息
local UIItemInfoPanel_Info_ExtraAttribute = {}

setmetatable(UIItemInfoPanel_Info_ExtraAttribute, luaComponentTemplates.UIItemInfoPanel_Info_Basic)

--region 参数
---没有icon的文本左偏移量
UIItemInfoPanel_Info_ExtraAttribute.NoIconInterval = -22
---默认下一个文本偏移量
UIItemInfoPanel_Info_ExtraAttribute.NextAttributeInterval = 10
--当前选择的item
UIItemInfoPanel_Info_ExtraAttribute.ItemInfo = nil
--endregion

--region 组件
---标题文本
---@return UILabel
function UIItemInfoPanel_Info_ExtraAttribute:GetExtreAttributeGroup_UIGridContainer()
    if self.mTitleLabel_UILabel == nil then
        self.mTitleLabel_UILabel = self:Get("extreattributegroup", "UIGridContainer")
    end
    return self.mTitleLabel_UILabel
end
--endregion

--region 刷新
---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_ExtraAttribute:RefreshWithInfo(commonData)
    self:ClearAttributeData()
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    self.extraEquipIdTable = commonData.extraEquipIdTable
    self.itemInfoSource = commonData.itemInfoSource
    self.roleId = commonData.roleId
    self.otherPlayerInfo = CS.CSScene.MainPlayerInfo.OtherPlayerInfo
    self.equipIndex = 0
    self.career = commonData.career
    self.isMainPlayerEquip = false
    self.isMainPartTemplate = commonData.isMainPartTemplate
    if bagItemInfo ~= nil then
        self.equipIndex = bagItemInfo.index
        self.isMainPlayerEquip = CS.CSScene.MainPlayerInfo.EquipInfo:IsEquip(bagItemInfo.lid)
    end
    if itemInfo ~= nil then
        ---@type TABLE.cfg_items
        self.luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id)
    end
    if itemInfo ~= nil then
        self:RefreshAttributes(bagItemInfo, itemInfo)
    end
    if self.career ~= nil and type(self.career) ~= 'number' then
        self.career = Utility.EnumToInt(self.career)
    end
    self:ShowAttribute(bagItemInfo, itemInfo)
end

---@class UIItemInfoExtraAttribute
---@field titleName string
---@field iconName string
---@field attrValue string 为了对齐,将一个文本拆成2段,这个左边那段
---@field attrDesc string 为了对齐,将一个属性拆成2个文本去显示

function UIItemInfoPanel_Info_ExtraAttribute:ShowAttribute(bagItemInfo, itemInfo)
    if self.count > 0 then
        self:GetExtreAttributeGroup_UIGridContainer().gameObject:SetActive(true)
    end
    if self:GetExtreAttributeGroup_UIGridContainer() ~= nil then
        self:GetExtreAttributeGroup_UIGridContainer().MaxCount = self.count
        for i = 0, self:GetExtreAttributeGroup_UIGridContainer().controlList.Count - 1 do
            local go = self:GetExtreAttributeGroup_UIGridContainer().controlList[i]
            local title = self:GetCurComp(go.transform, "title", "UILabel")
            local icon = self:GetCurComp(go.transform, "icon", "UISprite")
            local AttrValue = self:GetCurComp(go.transform, "AttrValue", "UILabel")
            local AttrDesc = self:GetCurComp(go.transform, "AttrDesc", "UILabel")
            local attribute = self.extraAttributeTable[i + 1]
            local nextAttribute = i + 2 <= self.count and self.extraAttributeTable[i + 2] or nil
            if attribute ~= nil then
                self:RefreshContent(title, icon, AttrValue, AttrDesc, attribute)
                self:ResetAttrValuePos(AttrValue, AttrDesc, attribute)
                self:SetNextContentPos(self:GetExtreAttributeGroup_UIGridContainer().controlList, i, nextAttribute)
            else
                go:SetActive(false)
            end
        end
    end
    if self.count == 0 then
        self.go:SetActive(false)
    end
end

---刷新面板内容
---@param extraAttribute UIItemInfoExtraAttribute
function UIItemInfoPanel_Info_ExtraAttribute:RefreshContent(titleLabel, iconSprite, attrValue, attrDesc, extraAttribute)
    if titleLabel == nil or iconSprite == nil or attrValue == nil or extraAttribute == nil then
        return
    end
    titleLabel.text = extraAttribute.titleName
    iconSprite.spriteName = extraAttribute.iconName
    attrValue.text = extraAttribute.attrValue
    if CS.StaticUtility.IsNull(attrDesc) == false then
        if (extraAttribute.attrDesc == nil) then
            attrDesc.text = ""
        else
            attrDesc.text = extraAttribute.attrDesc
        end
    end
end

---重置描述文本位置
function UIItemInfoPanel_Info_ExtraAttribute:ResetAttrValuePos(attrValue, attrDesc, attribute)
    if self.noIconLocalPos == nil then
        self.noIconLocalPos = attrValue.transform.localPosition + CS.UnityEngine.Vector3.right * self.NoIconInterval, CS.UnityEngine.Vector3.zero
    end
    if self.IconLocalPos == nil then
        self.IconLocalPos = attrValue.transform.localPosition
    end
    attrValue.transform.localPosition = ternary(attribute.iconName == "", self.noIconLocalPos, self.IconLocalPos)
    if CS.StaticUtility.IsNull(attrDesc) == false then
        attrDesc.transform.localPosition = ternary(attribute.iconName == "", self.noIconLocalPos, self.IconLocalPos)
    end
end

---重置下一个文本的位置
function UIItemInfoPanel_Info_ExtraAttribute:SetNextContentPos(gameObjectList, index, nextAttribute)
    if index + 1 >= gameObjectList.Count then
        return
    end
    local nowGo = gameObjectList[index]
    local nextGo = gameObjectList[index + 1]
    local title = self:GetCurComp(nowGo.transform, "title", "UILabel")
    local attrValue = self:GetCurComp(nowGo.transform, "AttrValue", "UILabel")
    local titleHeight = title.height
    if (nextAttribute ~= nil and Utility.IsNilOrEmptyString(nextAttribute.titleName)) then
        titleHeight = 0
    end
    nextGo.transform.localPosition = CS.UnityEngine.Vector3.down * (math.abs(nowGo.transform.localPosition.y) + titleHeight + attrValue.height + self.NextAttributeInterval)
end
--endregion

--region 显示数据添加
---@param bagItemInfo bagV2.BagItemInfo 背包信息
---@param itemInfo TABLE.CFG_ITEMS 物品信息
function UIItemInfoPanel_Info_ExtraAttribute:RefreshAttributes(bagItemInfo, itemInfo)
    UIItemInfoPanel_Info_ExtraAttribute.ItemInfo = itemInfo

    --region 额外属性(buff属性)
    self:RefreshBuffAttribute(bagItemInfo, itemInfo)
    --endregion

    --region 切割属性
    if bagItemInfo ~= nil then
        local Lua_jianDingTABLE = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
        if Lua_jianDingTABLE:GetJianDing() == 1 then
            local attrType, attrValue = bagItemInfo.appraisalQuality, bagItemInfo.appraisalAttr
            local attrName = "[73ddf7]切割属性"
            local attrList = self:GetJianDingAttr(attrType)
            if (attrList ~= nil and attrList.color ~= nil and attrList.des ~= nil) then
                self:AddAttribute(attrName, "", "[" .. attrList.color .. "][" .. attrList.des .. "]刀刀切割   " .. tostring(attrValue) .. "[-]")
            end
        end
    end
    --endregion

    --region 专精
    if bagItemInfo and itemInfo then
        -----@type LuaMainPlayerBagMgr
        --local mainPlayerBagMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
        --local isMainPlayerBag = mainPlayerBagMgr:GetBagItemData(bagItemInfo.lid) ~= nil
        ---目前只有主角自己穿戴的专精数据
        if (self.isMainPlayerEquip) then
            ---@type LuaEquipProficientMgr
            local equipProficientMgr = gameMgr:GetPlayerDataMgr():GetEquipProficientMgr()
            ---@type TABLE.cfg_equip_proficient
            local equip_proficient = equipProficientMgr:GetProficientDataByBagItemInfo(bagItemInfo)
            ---能拿到自己的装备信息
            if (equip_proficient ~= nil) then
                local name = equip_proficient:GetName() .. " Lv" .. tostring(equip_proficient:GetLevel())
                local desc = CS.Utility_Lua.ReplaceSpecialCharToColor(equip_proficient:GetTips(), "[ffe36f]");
                self:AddAttribute(name, "", desc)
            end
        end
    end
    --endregion
    --region 元素属性
    if bagItemInfo and itemInfo then
        local elementInfo = nil
        local CSElementInfo = CS.CSScene.MainPlayerInfo.ElementInfo
        if self.itemInfoSource == luaEnumItemInfoSource.UIOTHERROLEPANEL and self.isMainPlayerEquip == false then
            elementInfo = self.otherPlayerInfo:GetOtherPlayerElementInfo(self.equipIndex)
        else
            elementInfo = CSElementInfo:GetElement(self.equipIndex)
        end
        if elementInfo ~= nil then
            local elementTableInfo = CS.Cfg_ElementTableManager.Instance:getElementStone(elementInfo.id)
            local elementName = CSElementInfo:GetElementAttackName(elementTableInfo)
            local elementAttack = CSElementInfo:GetElementAttackAttributeContent(elementTableInfo)
            --local titleName = "[73ddf7]" .. CS.Cfg_GlobalTableManager.Instance:GetExtraAttributeLvName(CS.Utility_Lua.GetNoColorItemName(elementInfo.id), elementTableInfo.quality)
            local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(elementInfo.id)
            local titleName = "[73ddf7]" .. luaItemInfo:GetName()
            local iconName = elementTableInfo.icon
            local attrValue = Utility.GetElementColor() .. elementName .. "   " .. tostring(elementAttack)
            self:AddAttribute(titleName, iconName, attrValue)
        end
    end
    --endregion

    --region 印记属性
    if bagItemInfo and itemInfo then
        local signetInfo = nil
        if self.itemInfoSource == luaEnumItemInfoSource.UIOTHERROLEPANEL and self.isMainPlayerEquip == false then
            signetInfo = self.otherPlayerInfo:GetOtherPlayerSignetInfo(self.equipIndex)
        else
            signetInfo = CS.CSScene.MainPlayerInfo.SignetV2:FindIndexSignetInfo(self.equipIndex)
        end
        if signetInfo ~= nil then
            local isfind, tabel_Item = CS.Cfg_ItemsTableManager.Instance:TryGetValue(signetInfo.id)
            if isfind then
                local signetLevel = CS.CSScene.MainPlayerInfo.SignetV2:GetSignetLevel(tabel_Item)
                --local titleName = "[73ddf7]" .. CS.Cfg_GlobalTableManager.Instance:GetExtraAttributeLvName(CS.Utility_Lua.GetNoColorItemName(tabel_Item.id), signetLevel)
                local titleName = "[73ddf7]" .. CS.Utility_Lua.GetNoColorItemName(tabel_Item.id)
                local iconName = tabel_Item.icon
                local attrValue = CS.Cfg_SignetTableManager.Instance:GetDescription(tabel_Item.id, signetInfo.fuDong)
                self:AddAttribute(titleName, iconName, attrValue)
            end
        end
    end
    --endregion


    --region 宝物
    if itemInfo ~= nil then
        local titleName = "[73ddf7]宝物属性"
        local iconName = ""
        local attrValue = ""
        local treasureSubType = 0
        if CS.CSScene.MainPlayerInfo.EquipInfo:IsGemExtraItem(itemInfo) then
            treasureSubType = CS.Cfg_GlobalTableManager.Instance:GetGemSubTypeByGemExtraSubType(itemInfo.subType)
            if self.itemInfoSource == luaEnumItemInfoSource.UIROLEPANEL then
                self.extraEquipIdTable = Utility.ListChangeTable(CS.CSScene.MainPlayerInfo.BagInfo:GetGemExtraItemList(treasureSubType))
            elseif self.itemInfoSource == luaEnumItemInfoSource.UIOTHERROLEPANEL then
                self.extraEquipIdTable = Utility.ListChangeTable(CS.CSScene.MainPlayerInfo.OtherPlayerInfo:GetGemExtraItemList(treasureSubType))
            end
        end
        if self.extraEquipIdTable ~= nil then
            for k, v in pairs(self.extraEquipIdTable) do
                local extraItemId = v
                local extraItemInfoIsFind, extraItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(extraItemId)
                if extraItemInfoIsFind then
                    local name = string.sub(extraItemInfo.name, 1, #extraItemInfo.name - 3)
                    titleName = "[73ddf7]" .. CS.Cfg_GlobalTableManager.Instance:GetExtraAttributeLvName(name, CS.CSScene.MainPlayerInfo.BagInfo:GetExtraItemLevel(extraItemInfo))
                    --    --local attrValue = ""
                    --    if self.isMainPlayerEquip == false and self.itemInfoSource == luaEnumItemInfoSource.UIOTHERROLEPANEL then
                    --        attrValue = --[[attrValue..]]CS.CSScene.MainPlayerInfo.BagInfo:GetOtherPlayerGemExtraItemAttributeText(extraItemId, self.career)
                    --    else
                    --        attrValue = --[[attrValue..]]CS.CSScene.MainPlayerInfo.BagInfo:GetGemExtraItemAttributeText(extraItemId, self.career)
                    --    end
                    --
                    --    --region 暴击倍数
                    --    local isFind, info = CS.Cfg_ItemsTableManager.Instance:TryGetValue(extraItemId)
                    --    if isFind and info.compoundParam ~= nil and info.compoundParam.list ~= nil and info.compoundParam.list.Count > 0 then
                    --        if info.subType == LuaEnumEquiptype.LightComponent then
                    --            ---暴击伤害 重置 为暴击率 显示
                    --            attrValue = "暴击率   " .. Utility.RemoveEndZero(info.critical / 100) .. '%'
                    --
                    --            local furnaceCritMultiplier = info.compoundParam.list[0] / 10000
                    --            local furnaceCritMultiplierstr = LuaGlobalTableDeal:GetLightComponentDes()
                    --            furnaceCritMultiplier = Utility.GetPreciseDecimal(furnaceCritMultiplier, 2)
                    --            furnaceCritMultiplier = Utility.RemoveEndZero(furnaceCritMultiplier)
                    --            furnaceCritMultiplier = furnaceCritMultiplier + 1
                    --            furnaceCritMultiplierstr = string .format(furnaceCritMultiplierstr, tostring(furnaceCritMultiplier))
                    --            attrValue = attrValue .. '\n' .. furnaceCritMultiplierstr
                    --        elseif info.subType == LuaEnumEquiptype.Jingongzhiyuan then
                    --            local furnaceCritMultiplier = info.compoundParam.list[0] / 10000
                    --            local furnaceCritMultiplierstr = LuaGlobalTableDeal:GetJingongzhiyuanDes()
                    --            furnaceCritMultiplier = Utility.GetPreciseDecimal(furnaceCritMultiplier, 2)
                    --            furnaceCritMultiplier = Utility.RemoveEndZero(furnaceCritMultiplier)
                    --            furnaceCritMultiplier = furnaceCritMultiplier + 1
                    --            furnaceCritMultiplierstr = string .format(furnaceCritMultiplierstr, tostring(furnaceCritMultiplier))
                    --            attrValue = attrValue .. '\n' .. furnaceCritMultiplierstr
                    --        elseif info.subType == LuaEnumEquiptype.Gem then
                    --            local furnaceCritMultiplier = info.compoundParam.list[0] / 10000
                    --            local furnaceCritMultiplierstr = LuaGlobalTableDeal:GetGemDes()
                    --            furnaceCritMultiplier = Utility.GetPreciseDecimal(furnaceCritMultiplier, 2)
                    --            furnaceCritMultiplier = Utility.RemoveEndZero(furnaceCritMultiplier)
                    --            furnaceCritMultiplier = furnaceCritMultiplier + 1
                    --            furnaceCritMultiplierstr = string .format(furnaceCritMultiplierstr, tostring(furnaceCritMultiplier))
                    --            attrValue = attrValue .. 'aaa \n' .. furnaceCritMultiplierstr
                    --        end
                    --    else
                    --        if info ~= nil and info.subType == LuaEnumEquiptype.LightComponent then
                    --            attrValue = "暴击率   " .. Utility.RemoveEndZero(info.showCritical / 100) .. '%'
                    --            attrValue = attrValue .. '\n' .. "暴击伤害   " .. tostring(info.criticalDamage)
                    --            if (info.seckill ~= nil) then
                    --                attrValue = attrValue .. '\n' .. "秒杀血量   " .. tostring(Utility.RemoveEndZero(info.seckill.list[0] / 100) .. '%')
                    --                attrValue = attrValue .. '\n' .. "秒杀概率   " .. tostring(Utility.RemoveEndZero(info.seckill.list[1] / 100) .. '%')
                    --            end
                    --        elseif info.subType == LuaEnumEquiptype.Gem then
                    --            if (info.suckBloodFake ~= nil) then
                    --                attrValue = attrValue .. '\n' .. "吸血概率   " .. tostring(Utility.RemoveEndZero(info.suckBloodFake.list[0] / 100) .. '%')
                    --                attrValue = attrValue .. '\n' .. "吸血比例   " .. tostring(Utility.RemoveEndZero(info.suckBloodFake.list[1] / 100) .. '%')
                    --            end
                    --        end
                    --    end


                    ----region 特殊效果
                    --if bagItemInfo and itemInfo then
                    ----local attrValue = ""
                    --    local buffTblList = clientTableManager.cfg_itemsManager:GetBufferTblListByItemId(extraItemId)
                    --    local globalData = CS.Cfg_GlobalTableManager.Instance:GetSpecialEffectItemId(22912)
                    --    for i = 0, globalData.Count - 1 do
                    --        if type(buffTblList) == 'table' and Utility.GetLuaTableCount(buffTblList) > 0 and extraItemInfoIsFind and extraItemInfo.subType == globalData[i] then
                    --            for k,v in pairs(buffTblList) do
                    --                ---@type TABLE.cfg_buff
                    --                local buffTbl = v
                    --                attrValue = attrValue.."\n[00ff00]"..buffTbl:GetName().."   "..buffTbl:GetTxt().."[-]"
                    --            end
                    --        end
                    --    end
                    --end
                    ----endregion
                    --region 攻击
                    local attackName = "攻击";
                    local attackValue = "0-0";
                    if CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior then
                        attackName = Utility.GetCareerAttackName(LuaEnumCareer.Warrior);
                        attackValue = extraItemInfo.phyAttackMin .. "-" .. extraItemInfo.phyAttackMax;
                    elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master then
                        attackName = Utility.GetCareerAttackName(LuaEnumCareer.Master);
                        attackValue = extraItemInfo.magicAttackMin .. "-" .. extraItemInfo.magicAttackMax;
                    elseif CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist then
                        attackName = Utility.GetCareerAttackName(LuaEnumCareer.Taoist);
                        attackValue = extraItemInfo.taoAttackMin .. "-" .. extraItemInfo.taoAttackMax;
                    end
                    local holyAttackName = Utility.GetAttributeName(LuaEnumAttributeType.HolyAttackMax);
                    local holyAttack = extraItemInfo.holyAttackMin .. "-" .. extraItemInfo.holyAttackMax;
                    ---暴击倍数
                    local criticalHurtAddName = '暴击倍数'
                    local criticalHurtAdd = 1
                    if extraItemInfo.criticalHurtAdd ~= nil then
                        criticalHurtAdd = extraItemInfo.criticalHurtAdd / 10000
                        criticalHurtAdd = Utility.GetPreciseDecimal(criticalHurtAdd, 2)
                        criticalHurtAdd = Utility.RemoveEndZero(criticalHurtAdd)
                        criticalHurtAdd = criticalHurtAdd + 1
                    end

                    ---展示暴击率
                    local showCritical = 0
                    showCritical = extraItemInfo.showCritical / 100
                    showCritical = Utility.GetPreciseDecimal(showCritical, 2)
                    showCritical = Utility.RemoveEndZero(showCritical)

                    ---暴击伤害
                    local criticalDamage = extraItemInfo.criticalDamage

                    ---灵兽合体继承攻击
                    local servantInheritAttackName = Utility.GetAttributeName(LuaEnumAttributeType.ServantInheritAttack);
                    local servantInheritAttack = 0
                    if extraItemInfo.attackPercentage ~= nil then
                        servantInheritAttack = extraItemInfo.attackPercentage / 10
                        servantInheritAttack = Utility.RemoveEndZero(servantInheritAttack)
                    end
                    ---灵兽合体继承防御
                    local servantInheritDefenseName = Utility.GetAttributeName(LuaEnumAttributeType.ServantInheritDefense);
                    local servantInheritDefense = 0
                    if extraItemInfo.defensePercentage ~= nil then
                        servantInheritDefense = extraItemInfo.defensePercentage / 10
                        servantInheritDefense = Utility.RemoveEndZero(servantInheritDefense)
                    end
                    --endregion

                    --region 防御
                    local phyDefName = Utility.GetAttributeName(LuaEnumAttributeType.PhyDefenceMax);
                    local magicDefName = Utility.GetAttributeName(LuaEnumAttributeType.MagicDefenceMax);
                    local hpName = Utility.GetAttributeName(LuaEnumAttributeType.MaxHp);
                    local hp = CS.Cfg_ItemsTableManager.Instance:GetMainPlayerCareerAttributeValue(extraItemInfo.id, CS.CareerAttributeType.HP);
                    local minPhyDef = CS.Cfg_ItemsTableManager.Instance:GetMainPlayerCareerAttributeValue(extraItemInfo.id, CS.CareerAttributeType.PHYDEFENCEMIN);
                    local maxPhyDef = CS.Cfg_ItemsTableManager.Instance:GetMainPlayerCareerAttributeValue(extraItemInfo.id, CS.CareerAttributeType.PHYDEFENCEMAX);
                    local minMagicDef = CS.Cfg_ItemsTableManager.Instance:GetMainPlayerCareerAttributeValue(extraItemInfo.id, CS.CareerAttributeType.MAGICDEFENCEMIN);
                    local maxMagicDef = CS.Cfg_ItemsTableManager.Instance:GetMainPlayerCareerAttributeValue(extraItemInfo.id, CS.CareerAttributeType.MAGICDEFENCEMAX);
                    local servantPhyDefName = Utility.GetAttributeName(LuaEnumAttributeType.ServantPhyDefMax);
                    local servantMagicDefName = Utility.GetAttributeName(LuaEnumAttributeType.ServantMagicDefMax);
                    local servantHpName = Utility.GetAttributeName(LuaEnumAttributeType.ServantHP);
                    local servantHp = extraItemInfo.hsmaxHp;
                    local minServantPhyDef = extraItemInfo.hsphyDefenceMin;
                    local maxServantPhyDef = extraItemInfo.hsphyDefenceMax;
                    local minServantMagicDef = extraItemInfo.hsmagicDefenceMin;
                    local maxServantMagicDef = extraItemInfo.hsmagicDefenceMax;
                    --endregion

                    if extraItemInfo.subType == LuaEnumEquiptype.LightComponent then
                        ---攻击
                        if (not Utility.CheckAttributeIsEmpty(attackValue)) then
                            attrValue = attackName .. "   " .. attackValue;
                        end
                        ---暴击倍数
                        if (not Utility.CheckAttributeIsEmpty(criticalHurtAdd) and criticalHurtAdd > 1) then
                            if CS.StaticUtility.IsNullOrEmpty(attrValue) == false then
                                attrValue = attrValue .. "\n"
                            end
                            attrValue = attrValue .. criticalHurtAddName .. "   " .. criticalHurtAdd;
                        end
                        ---暴击率
                        if (not Utility.CheckAttributeIsEmpty(showCritical)) then
                            if CS.StaticUtility.IsNullOrEmpty(attrValue) == false then
                                attrValue = attrValue .. "\n"
                            end
                            attrValue = attrValue .. '暴击率' .. "   " .. showCritical .. '%';
                        end
                    elseif extraItemInfo.subType == LuaEnumEquiptype.Gem then
                        ---攻击
                        if (not Utility.CheckAttributeIsEmpty(attackValue)) then
                            attrValue = attackName .. "   " .. attackValue;
                        end
                        ---切割
                        if (not Utility.CheckAttributeIsEmpty(holyAttack)) then
                            if CS.StaticUtility.IsNullOrEmpty(attrValue) == false then
                                attrValue = attrValue .. "\n"
                            end
                            attrValue = attrValue .. holyAttackName .. "   " .. holyAttack;
                        end
                    elseif extraItemInfo.subType == LuaEnumEquiptype.ShengMingJingPo then
                        ---攻击
                        if (not Utility.CheckAttributeIsEmpty(attackValue)) then
                            attrValue = attackName .. "   " .. attackValue;
                        end
                        ---生命
                        if (not Utility.CheckAttributeIsEmpty(hp)) then
                            if CS.StaticUtility.IsNullOrEmpty(attrValue) == false then
                                attrValue = attrValue .. "\n"
                            end
                            attrValue = attrValue .. hpName .. "   " .. hp;
                        end
                        ---暴击伤害
                        if (not Utility.CheckAttributeIsEmpty(criticalDamage)) then
                            if CS.StaticUtility.IsNullOrEmpty(attrValue) == false then
                                attrValue = attrValue .. "\n"
                            end
                            attrValue = attrValue .. '暴击伤害' .. "   " .. criticalDamage;
                        end
                    elseif extraItemInfo.subType == LuaEnumEquiptype.Jingongzhiyuan then
                        ---攻击
                        if (not Utility.CheckAttributeIsEmpty(attackValue)) then
                            attrValue = attackName .. "   " .. attackValue;
                        end
                        ---生命
                        if (not Utility.CheckAttributeIsEmpty(hp)) then
                            if CS.StaticUtility.IsNullOrEmpty(attrValue) == false then
                                attrValue = attrValue .. "\n"
                            end
                            attrValue = attrValue .. hpName .. "   " .. hp;
                        end
                        ---灵兽生命
                        if (not Utility.CheckAttributeIsEmpty(servantHp)) then
                            if CS.StaticUtility.IsNullOrEmpty(attrValue) == false then
                                attrValue = attrValue .. "\n"
                            end
                            attrValue = attrValue .. servantHpName .. "   " .. servantHp;
                        end
                        ---灵兽合体继承攻击
                        if (not Utility.CheckAttributeIsEmpty(servantInheritAttack)) then
                            if CS.StaticUtility.IsNullOrEmpty(attrValue) == false then
                                attrValue = attrValue .. "\n"
                            end
                            attrValue = attrValue .. servantInheritAttackName .. "   " .. servantInheritAttack .. '%';
                        end
                    elseif extraItemInfo.subType == LuaEnumEquiptype.Shouhuzhiyuan then
                        ---攻击
                        if (not Utility.CheckAttributeIsEmpty(attackValue)) then
                            attrValue = attackName .. "   " .. attackValue;
                        end
                        ---物防
                        if (not Utility.CheckAttributeIsEmpty(minPhyDef) and not Utility.CheckAttributeIsEmpty(maxPhyDef)) then
                            if CS.StaticUtility.IsNullOrEmpty(attrValue) == false then
                                attrValue = attrValue .. "\n"
                            end
                            attrValue = attrValue .. phyDefName .. "   " .. minPhyDef .. "-" .. maxPhyDef;
                        end
                        ---魔防
                        if (not Utility.CheckAttributeIsEmpty(minMagicDef) and not Utility.CheckAttributeIsEmpty(maxMagicDef)) then
                            if CS.StaticUtility.IsNullOrEmpty(attrValue) == false then
                                attrValue = attrValue .. "\n"
                            end
                            attrValue = attrValue .. magicDefName .. "   " .. minMagicDef .. "-" .. maxMagicDef;
                        end
                        ---灵兽物防
                        if (not Utility.CheckAttributeIsEmpty(minServantPhyDef) and not Utility.CheckAttributeIsEmpty(maxServantPhyDef)) then
                            if CS.StaticUtility.IsNullOrEmpty(attrValue) == false then
                                attrValue = attrValue .. "\n"
                            end
                            attrValue = attrValue .. servantPhyDefName .. "   " .. minServantPhyDef .. "-" .. maxServantPhyDef;
                        end
                        ---灵兽魔防
                        if (not Utility.CheckAttributeIsEmpty(minServantMagicDef) and not Utility.CheckAttributeIsEmpty(maxServantMagicDef)) then
                            if CS.StaticUtility.IsNullOrEmpty(attrValue) == false then
                                attrValue = attrValue .. "\n"
                            end
                            attrValue = attrValue .. servantMagicDefName .. "   " .. minServantMagicDef .. "-" .. maxServantMagicDef;
                        end
                        ---灵兽合体继承防御
                        if (not Utility.CheckAttributeIsEmpty(servantInheritDefense)) then
                            if CS.StaticUtility.IsNullOrEmpty(attrValue) == false then
                                attrValue = attrValue .. "\n"
                            end
                            attrValue = attrValue .. servantInheritDefenseName .. "   " .. servantInheritDefense .. '%';
                        end
                    end
                    local buffDes = clientTableManager.cfg_itemsManager:GetBuffDes(extraItemId)
                    if CS.StaticUtility.IsNullOrEmpty(buffDes) == false then
                        attrValue = attrValue .. "\n" .. "[00FF00]" .. buffDes
                    end
                    self:AddAttribute(titleName, iconName, attrValue)
                end
            end
        end
    end
    --endregion

    --region 宝物套装
    if itemInfo ~= nil and Utility:IsGem(itemInfo.id) then
        local IsOtherPlayerItem = self.itemInfoSource == luaEnumItemInfoSource.UIOTHERROLEPANEL and self.isMainPlayerEquip == false
        local gemItemListClass = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetGemSuitListByGemSuitType(LuaEnumGemEquipSuitType.Normal)
        if IsOtherPlayerItem then
            gemItemListClass = gameMgr:GetOtherPlayerDataMgr():GetGemSuitListByGemSuitType(LuaEnumGemEquipSuitType.Normal)
        end
        if gemItemListClass ~= nil then
            local canCompleteSuit = gemItemListClass:CheckItemCanCompleteSuit(itemInfo.id)
            local showSuitTbl = gemItemListClass:GetSuiTbl_CanCompleteSuit(itemInfo.id)
            if canCompleteSuit == true and showSuitTbl ~= nil then
                ---如果当前可以集齐套装：1.如果当前可以集齐的套装的等级 <= 配置的套装等级 = 显示不激活的配置套装  2.否则显示激活的当前套装
                local suitLv = gemItemListClass:GetSuitMinLevel(itemInfo.id)
                if suitLv >= showSuitTbl:GetSuitLv() then
                    showSuitTbl = clientTableManager.cfg_suitManager:GetSuitTblBySuitTypeAndLevel(showSuitTbl:GetSuitId(), suitLv)
                else
                    canCompleteSuit = false
                end
            end
            --组件
            local suitName = clientTableManager.cfg_suitManager:GetSuitNameByItemId(itemInfo.id)
            local suitPartsName = gemItemListClass:GetSuitPartsName(itemInfo.id)
            if CS.StaticUtility.IsNullOrEmpty(suitName) == false and CS.StaticUtility.IsNullOrEmpty(suitPartsName) == false then
                self:AddAttribute("[73ddf7]" .. suitName, "", suitPartsName)
            end
            --套装属性
            if showSuitTbl ~= nil then
                local titleSuffixDes = ternary(canCompleteSuit == false, luaEnumColorType.Gray .. "(未激活)", "")
                local buffTitleName = clientTableManager.cfg_suitManager:GetSuitBuffTitleName(showSuitTbl:GetId()) .. titleSuffixDes

                local suitBuffDesColor = ternary(canCompleteSuit == false, luaEnumColorType.Gray, luaEnumColorType.Green3)
                local suitBuffDes = clientTableManager.cfg_suitManager:GetBuffDes(showSuitTbl:GetId())
                if CS.StaticUtility.IsNullOrEmpty(buffTitleName) == false and CS.StaticUtility.IsNullOrEmpty(suitBuffDes) == false then
                    self:AddAttribute("[73ddf7]" .. buffTitleName, "", suitBuffDesColor .. suitBuffDes)
                end
            end
        end
    end
    --endregion

    --region 法宝
    if itemInfo ~= nil then
        if (CS.CSServantInfoV2.IsServantMagicWeapon(itemInfo)) then
            local titleName = "[73ddf7]法宝效果"
            local iconName = ""
            local attrValue = itemInfo.extraSkillTips == nil and "每个法宝都有其独特之处, 还需自行挖掘哟" or itemInfo.extraSkillTips;
            --local needLevelDes = ternary(itemInfo.reinLv > 0, "需要灵兽转生   " .. itemInfo.reinLv, "需要灵兽等级   " .. itemInfo.useLv)
            local needLevelColor = ternary(CS.CSScene.MainPlayerInfo.ServantInfoV2:IsCommissionEquipByItemInfo(itemInfo), luaEnumColorType.White, luaEnumColorType.Red1)
            attrValue = attrValue .. '\n' .. needLevelColor
            -- .. needLevelDes
            if CS.StaticUtility.IsNullOrEmpty(attrValue) == false then
                self:AddAttribute(titleName, iconName, attrValue)
            end
        end
    end
    --endregion

    --region 斗笠盾牌套装
    if itemInfo ~= nil and clientTableManager.cfg_itemsManager:IsShieldorHatEquip(itemInfo.id) then
        local otherMainPlayer = self.itemInfoSource == luaEnumItemInfoSource.UIOTHERROLEPANEL and self.isMainPartTemplate
        ---@type LuaShieldAndHatManager
        local ShieldAndHatManager = nil
        ---@type LuaShieldAndHatEquipmentListData
        local gemItemListClass = nil
        if otherMainPlayer then
            ShieldAndHatManager = gameMgr:GetOtherPlayerDataMgr():GetShieldAndHatManager()
            gemItemListClass = gameMgr:GetOtherPlayerDataMgr():GetShieldAndHatSuitListByShieldAndHatSuitType(LuaEnumShieldAndHatEquipSuitType.Normal)
        else
            ShieldAndHatManager = gameMgr:GetPlayerDataMgr():GetShieldAndHatManager()
            gemItemListClass = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetShieldAndHatSuitListByShieldAndHatSuitType(LuaEnumShieldAndHatEquipSuitType.Normal)
        end
        local suitPartItemInfoList = ShieldAndHatManager:GetEquipList(itemInfo.id)
        gemItemListClass.suitPartItemInfoList = suitPartItemInfoList
        if gemItemListClass ~= nil then
            local canCompleteSuit = gemItemListClass:CheckItemCanCompleteSuit(itemInfo.id)
            local showSuitTbl = gemItemListClass:GetSuiTbl_CanCompleteSuit(itemInfo.id)
            if canCompleteSuit == true and showSuitTbl ~= nil then
                ---如果当前可以集齐套装：1.如果当前可以集齐的套装的等级 <= 配置的套装等级 = 显示不激活的配置套装  2.否则显示激活的当前套装
                local suitLv = gemItemListClass:GetSuitMinLevel(itemInfo.id)

                if suitLv >= showSuitTbl:GetSuitLv() then
                    showSuitTbl = clientTableManager.cfg_suitManager:GetSuitTblBySuitTypeAndLevel(showSuitTbl:GetSuitId(), suitLv)
                else
                    canCompleteSuit = false
                end
            end

            --组件
            local suitName = clientTableManager.cfg_suitManager:GetSuitNameByItemId(itemInfo.id)
            local suitPartsName = gemItemListClass:GetSuitPartsName(itemInfo.id)
            if CS.StaticUtility.IsNullOrEmpty(suitName) == false and CS.StaticUtility.IsNullOrEmpty(suitPartsName) == false then
                self:AddAttribute("[73ddf7]" .. suitName, "", suitPartsName)
            end
            --套装属性
            if showSuitTbl ~= nil then
                local titleSuffixDes = ternary(canCompleteSuit == false, luaEnumColorType.Gray .. "(未激活)", "")
                local buffTitleName = clientTableManager.cfg_suitManager:GetSuitBuffTitleName(showSuitTbl:GetId()) .. titleSuffixDes

                local suitBuffDesColor = ternary(canCompleteSuit == false, luaEnumColorType.Gray, luaEnumColorType.Green3)
                local suitBuffDes = clientTableManager.cfg_suitManager:GetBuffDes(showSuitTbl:GetId())
                if CS.StaticUtility.IsNullOrEmpty(buffTitleName) == false and CS.StaticUtility.IsNullOrEmpty(suitBuffDes) == false then
                    self:AddAttribute("[73ddf7]" .. buffTitleName, "", suitBuffDesColor .. suitBuffDes)
                end
            end
        end
    end
    --endregion

    --region 灵兽
    if bagItemInfo ~= nil and itemInfo ~= nil then
        if itemInfo.type == luaEnumItemType.Assist and itemInfo.subType == 8 then
            local titleName = "[73ddf7]灵兽属性"
            local iconName = ""
            local attrValue = CS.Utility_Lua.GetServantTypeInfo(itemInfo.id, bagItemInfo.luck)
            if CS.StaticUtility.IsNullOrEmpty(attrValue) == false then
                self:AddAttribute(titleName, iconName, attrValue)
            end
        end
    end
    --endregion

    --[[
    --region 血继套装
    if itemInfo and bagItemInfo and uimanager:GetPanel("UIServantPanel") == nil then
        ---灵兽界面未打开时才显示血继的属性
        local bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(itemInfo.id)
        if bloodsuitTbl then
            ---如果为血继装备,则显示血继的特殊属性
            local titleName = "[73ddf7]血继属性  Lv." .. bagItemInfo.bloodLevel
            local attributestr = ""
            local isAttriExist = false
            local mainPlayerCareer = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
            for i = 1, #uiStaticParameter.mBloodSuitUseData do
                local attributeTypeTemp = uiStaticParameter.mBloodSuitUseData[i]
                ---职业是否匹配
                local isCareerMatch = true
                if attributeTypeTemp == LuaEnumAttributeType.PhyAttackMax and mainPlayerCareer ~= LuaEnumCareer.Warrior then
                    isCareerMatch = false
                elseif attributeTypeTemp == LuaEnumAttributeType.MagicAttackMax and mainPlayerCareer ~= LuaEnumCareer.Master then
                    isCareerMatch = false
                elseif attributeTypeTemp == LuaEnumAttributeType.TaoAttackMax and mainPlayerCareer ~= LuaEnumCareer.Taoist then
                    isCareerMatch = false
                end
                if isCareerMatch then
                    local attrName, minValue, maxValue = Utility.GetBloodSuitEquipAttribute(itemInfo.id, bagItemInfo.bloodLevel, attributeTypeTemp)
                    if attrName then
                        ---attrName为nil表示未找到该属性
                        if ((minValue ~= nil and minValue ~= 0) or (maxValue ~= nil and maxValue ~= 0)) then
                            if isAttriExist == false then
                                isAttriExist = true
                            else
                                attributestr = attributestr .. "\r\n"
                            end
                            ---只考虑min和max有任意一个生效的情况
                            if minValue ~= nil and maxValue ~= nil then
                                attributestr = attributestr .. attrName .. "    " .. tostring(minValue) .. "-" .. tostring(maxValue)
                            else
                                attributestr = attributestr .. attrName .. "    " .. (minValue == nil and tostring(maxValue) or tostring(minValue))
                            end
                        end
                    end
                end
            end
            local bloodsuit_levelTbl = clientTableManager.cfg_bloodsuit_levelManager:TryGetValue(bagItemInfo.bloodLevel + 1)
            if isAttriExist then
                attributestr = attributestr .. "\r\n"
            end
            if bloodsuit_levelTbl then
                ---填入下一级的等级需求
                attributestr = attributestr .. "血继值   " .. bagItemInfo.exp .. "/" .. bloodsuit_levelTbl:GetCost()
            else
                ---未在套装等级表中找到下一等级的数值,则认为已满级
                attributestr = attributestr .. "血继值   " .. "已满级"
            end
            self:AddAttribute(titleName, '', attributestr)
        end
    end
    --endregion

    --region 血继共鸣
    if itemInfo and bagItemInfo and false then
        ---灵兽界面未打开时才显示血继的属性
        local bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(itemInfo.id)
        if bloodsuitTbl then
            ---@type LuaPlayerBloodSuitResonanceMgr
            local resonanceMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitResonanceMgr()
            if resonanceMgr ~= nil then
                local dic = resonanceMgr:GetSingleBloodSuitResonanceByItemID(itemInfo.id)
                if dic ~= nil then
                    for i, v in pairs(dic) do
                        ---@type LuaPlayerBloodSuitResonanceGroup
                        local tempGroup = v
                        local titleName = "[73ddf7]血继共鸣  " .. v:GetGroupName()
                        local openColor = "[00ff00]"
                        local closeColor = "[878787]"
                        local des = v:GetGroupDes(openColor, closeColor) .. v:GetGroupResultDes(openColor, closeColor)
                        self:AddAttribute(titleName, '', des)
                    end
                end
            end

        end
    end
    --endregion
    --]]

    --region 镶嵌属性
    self:ShowInlayAttribute(bagItemInfo, itemInfo)
    --endregion

    --region 被镶嵌装备(神器，仙装，魂装)
    self:SetInlayEquipExtraAttribute(bagItemInfo, itemInfo, LuaEnumSoulEquipType.ShenQi)
    self:SetInlayEquipExtraAttribute(bagItemInfo, itemInfo, LuaEnumSoulEquipType.XianZhuang)
    self:SetInlayEquipExtraAttribute(bagItemInfo, itemInfo, LuaEnumSoulEquipType.HunZhuang)
    --endregion

    --region 魂装
    if itemInfo and itemInfo.type == luaEnumItemType.Equip and self.luaItemInfo then
        local otherMainPlayer = self.itemInfoSource == luaEnumItemInfoSource.UIOTHERROLEPANEL and self.isMainPartTemplate
        ---这件装备是否使用
        local isUsed = false;
        ---对应的物品背包信息
        local luaBagItemInfo = nil;
        ---装备位对应的魂装数据
        local setSoulEquip = nil;
        ---魂装是否激活
        local isActiveSoulEquip = false;
        ---@type LuaSoulEquipDataClass
        local luaSoulEquipData = nil
        if (otherMainPlayer) then
            luaSoulEquipData = gameMgr:GetOtherPlayerDataMgr():GetLuaSoulEquipData();
        else
            luaSoulEquipData = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetLuaSoulEquipData();
        end
        if (bagItemInfo ~= nil) then
            --luaBagItemInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetBagItemData(bagItemInfo.lid);
            setSoulEquip = luaSoulEquipData:GetSoulEquipToEquipIndex(bagItemInfo.index);
            isActiveSoulEquip = luaSoulEquipData:GetSoulEquipActiveState(bagItemInfo.index);
            isActiveSoulEquip = isActiveSoulEquip == nil and false or isActiveSoulEquip;
            isUsed = bagItemInfo.index > 0;
        end
        ---@type bagV2.BagItemInfo
        local targetSoulEquip = nil;
        local tbl = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id);
        if (tbl ~= nil) then
            local isSoulEquip = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():IsSoulEquip(tbl);
            if (isSoulEquip or isUsed) then
                if (luaSoulEquipData ~= nil) then
                    local iconName = ""
                    local titleName = "[73ddf7]魂装属性" .. (isActiveSoulEquip and "" or luaEnumColorType.Gray .. "(未激活)[-]");
                    local soulDes = "";
                    if (isUsed or bagItemInfo ~= nil) then
                        if (isSoulEquip) then
                            titleName = "[73ddf7]魂装属性" .. luaEnumColorType.Gray .. "(镶嵌后生效)";
                            if (isUsed) then
                                if (otherMainPlayer) then
                                    targetSoulEquip = gameMgr:GetOtherPlayerDataMgr():GetOtherPlayerEquipInfoByLid(bagItemInfo.lid);
                                else
                                    targetSoulEquip = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipInfo(bagItemInfo.lid);
                                end
                            else
                                targetSoulEquip = bagItemInfo;
                            end
                        elseif (setSoulEquip ~= nil) then
                            targetSoulEquip = setSoulEquip;
                            tbl = clientTableManager.cfg_itemsManager:TryGetValue(targetSoulEquip.itemId);
                            iconName = tbl:GetIcon();
                        end

                        ---@type TABLE.cfg_signet
                        if (targetSoulEquip ~= nil) then
                            local height, lower = CS.Utility_Lua.DecodeHD(targetSoulEquip.soulEffect, 32, 0x0ffffffff);
                            if (lower ~= 0) then
                                local signetTable = clientTableManager.cfg_signetManager:TryGetValue(lower)
                                if (signetTable ~= nil) then
                                    if (signetTable:GetParameter() ~= nil and signetTable:GetParameter().list.Count > 0) then
                                        local desColor = isActiveSoulEquip and luaEnumColorType.Purple or luaEnumColorType.Gray;
                                        soulDes = desColor .. string.CSFormat(signetTable:GetDescription(), signetTable:GetParameter().list[0]);
                                    end
                                end
                            end
                        end
                    else
                        titleName = "[73ddf7]魂装属性" .. luaEnumColorType.Gray .. "(镶嵌后生效)";
                        ---如果没有对应实例则显示默认说明
                        soulDes = luaEnumColorType.Gray .. gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetDefaultSoulEquipDes() .. "[-]";
                    end

                    if (targetSoulEquip ~= nil) then
                        ---@type TABLE.cfg_suit
                        local suitTbl = nil;
                        if (setSoulEquip ~= nil) then
                            suitTbl = gameMgr:GetPlayerDataMgr():GetLuaSuitMgr():GetBodySoulEquipSuitTable(tbl:GetSuitBelong(), luaSoulEquipData);
                        else
                            suitTbl = gameMgr:GetPlayerDataMgr():GetLuaSuitMgr():GetSuitTbl(tbl:GetSuitBelong(), tbl:GetGroup());
                        end

                        local suitDes = "";
                        if (suitTbl ~= nil) then
                            local isActiveSoulSuit = luaSoulEquipData:IsSuitActive(suitTbl:GetId());
                            local color1 = isActiveSoulSuit and luaEnumColorType.Green or luaEnumColorType.Gray;
                            local color2 = (isSoulEquip and luaEnumColorType.Gray or color1)
                            local param = 0;
                            if (suitTbl:GetAttributeParam() ~= nil and #suitTbl:GetAttributeParam().list > 0) then
                                param = math.floor(suitTbl:GetAttributeParam().list[1] / 100);
                            end
                            local bodySuitList = gameMgr:GetPlayerDataMgr():GetLuaSuitMgr():GetBodySoulSuitEquip(tbl:GetSuitBelong(), luaSoulEquipData);
                            local suitNum = setSoulEquip == nil and 0 or #bodySuitList;
                            suitDes = color2 .. (soulDes == "" and "" or "\n") .. suitTbl:GetName() .. "(" .. suitNum .. "/" .. suitTbl:GetNeedNum() .. "):" .. string.CSFormat(suitTbl:GetDes(), param);
                        end
                        local attrValue = soulDes .. suitDes;
                        if CS.StaticUtility.IsNullOrEmpty(attrValue) == false then
                            self:AddAttribute(titleName, iconName, attrValue)
                        end
                    end
                end
            end
        end
    end
    --endregion

    --region 神力套装
    self:RefreshDivineSuit(itemInfo, bagItemInfo)
    --endregion

    --region 套装属性
    self:SetSuitEquipAttribute(bagItemInfo, itemInfo)
    --endregion

    --region 重铸属性
    self:AddRecastAttribute(bagItemInfo, itemInfo)
    --endregion
end

--region 额外属性（buff属性）
function UIItemInfoPanel_Info_ExtraAttribute:RefreshBuffAttribute(bagItemInfo, itemInfo)
    if itemInfo ~= nil then
        local des = clientTableManager.cfg_itemsManager:GetBuffDes(itemInfo.id)
        if CS.StaticUtility.IsNullOrEmpty(des) == false then
            local des = string.gsub(des, '\\n', '\n')
            self:AddAttribute("[73ddf7]特殊效果", "", luaEnumColorType.Green3 .. des)
        end
    end
end
--endregion

--region 神力套装
function UIItemInfoPanel_Info_ExtraAttribute:RefreshDivineSuit(itemInfo, bagItemInfo)
    local isDivineSuitEquip = clientTableManager.cfg_itemsManager:IsDivineSuitEquip(itemInfo.id)
    if isDivineSuitEquip == true then
        local divineData = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id)
        if divineData then
            local suitData = clientTableManager.cfg_divinesuitManager:TryGetValue(divineData:GetDivineId())
            if suitData then
                local suitPartParamsList = clientTableManager.cfg_divinesuitManager:GetDivineSuitParts(suitData:GetId())
                local otherMainPlayer = self.itemInfoSource == luaEnumItemInfoSource.UIOTHERROLEPANEL and self.isMainPartTemplate
                local dataManager = otherMainPlayer and gameMgr:GetOtherPlayerDataMgr() or gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr()
                --region 套装部件
                if type(suitPartParamsList) == 'table' and #suitPartParamsList > 0 then
                    local titleName = "[73ddf7]" .. suitData:GetSuitName()
                    local iconName = ""
                    local attrValue = ""
                    for i = 1, #suitPartParamsList do
                        ---@type divineSuitPartParams
                        local partParams = suitPartParamsList[i]
                        local type = partParams.suitPartType
                        local name = partParams.partName
                        local full = false
                        ---身上装备显示对比属性，背包装备显示自己类型
                        if bagItemInfo and bagItemInfo.index ~= 0 then
                            local equipData = dataManager:GetEquipmentItem(suitData:GetType(), type, nil, suitData:GetSubType())
                            full = equipData and equipData.BagItemInfo ~= nil
                        else
                            full = divineData:GetSubType() == type
                        end
                        local color = full and luaEnumColorType.Green or luaEnumColorType.Gray
                        attrValue = color .. attrValue .. name .. "[-]"
                        if i == math.ceil(#suitPartParamsList / 2) then
                            attrValue = attrValue .. "\n"
                        else
                            attrValue = attrValue .. "   "
                        end
                    end
                    if CS.StaticUtility.IsNullOrEmpty(attrValue) == false then
                        self:AddAttribute(titleName, iconName, attrValue)
                    end
                end
                --endregion

                --region 套装属性
                local titleName = "[73ddf7]套装属性"
                local iconName = ""
                local attrValue = " "
                local attrDesc = "              "

                local allAttribute
                if bagItemInfo and bagItemInfo.index ~= 0 then
                    local equipmentListData = dataManager:GetEquipmentList(suitData:GetType(), suitData:GetSubType())
                    allAttribute = equipmentListData:GetAdditionDataList(suitData:GetSubType())
                    if (allAttribute ~= nil and #allAttribute > 0 and allAttribute[1] ~= nil) then
                        local activeDes = allAttribute[1].IsActivate and '已激活' or '未激活'
                        local activeColor = allAttribute[1].IsActivate and luaEnumColorType.Green3 or luaEnumColorType.Gray
                        titleName = Utility.CombineStringQuickly(titleName, 'LV.', allAttribute[1].ActivateAttributeLevel, activeColor, '(', activeDes, ')')
                    end
                else
                    allAttribute = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetStaticDivineSuitData(suitData:GetType(), divineData:GetDivineId(), suitData:GetSubType())
                    titleName = Utility.CombineStringQuickly(titleName, 'LV.', suitData:GetLevel(), luaEnumColorType.Gray, '(未激活)')
                end
                if allAttribute then
                    for i = 1, #allAttribute do
                        ---@type LuaEquipSuitAdditionItem
                        local attribute = allAttribute[i]
                        if attribute then
                            local color = attribute.IsActivate and luaEnumColorType.Green3 or luaEnumColorType.Gray
                            local des = string.gsub(attribute.DivineSuitAttribute:GetDes(), '\\n', '\n')
                            if des == nil or des == "" then
                                des = attribute.DivineSuitAttribute:GetSkilldes()
                            end
                            local leftNum = 0
                            if attribute ~= nil and attribute.ActivateData ~= nil then
                                leftNum = attribute.ActivateData[1]
                            end
                            local rightNum = attribute.ActivateLimitCount
                            local currentCount = leftNum > rightNum and rightNum or leftNum
                            if bagItemInfo == nil or bagItemInfo.index == 0 then
                                currentCount = 1
                            end
                            local num = currentCount .. "/" .. attribute.ActivateLimitCount .. ""

                            if (i ~= 1) then
                                attrValue = attrValue .. "\n "
                                attrDesc = attrDesc .. "\n              "
                            end
                            attrValue = attrValue .. color .. num .. "[-]";
                            attrDesc = attrDesc .. color .. des .. "[-]";

                            local isHH = string.find(des, "\n")
                            if (isHH ~= nil) then
                                attrValue = attrValue .. "\n"
                            end
                        end
                    end
                end
                if CS.StaticUtility.IsNullOrEmpty(attrValue) == false then
                    self:AddAttribute(titleName, iconName, attrValue, attrDesc)
                end
                --endregion
            end
        end
    end
end
--endregion

--region 套装属性
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_Info_ExtraAttribute:SetSuitEquipAttribute(bagItemInfo, itemInfo)
    ---@type boolean 是否是主角的物品
    local otherMainPlayer = self.itemInfoSource == luaEnumItemInfoSource.UIOTHERROLEPANEL and self.isMainPartTemplate
    ---@type LuaEnumSuitType 套装类型
    local suitType = nil
    ---@type table<TABLE.cfg_items> 装备信息列表
    local suitPartItemInfoList = nil

    --region 阵法套装
    if itemInfo ~= nil and clientTableManager.cfg_itemsManager:IsZhenFaEquip(itemInfo.id) then
        suitType = clientTableManager.cfg_suitManager:GetSuitTypeByItemId(itemInfo.id)
        ---@type LuaZhenFaManager
        local ZhenFaManager = nil
        if otherMainPlayer then
            ZhenFaManager = gameMgr:GetOtherPlayerDataMgr():GetZhenFaManager()
        else
            ZhenFaManager = gameMgr:GetPlayerDataMgr():GetZhenFaManager()
        end
        suitPartItemInfoList = gameMgr:GetPlayerDataMgr():GetZhenFaManager():GetZhenFaEquipManager():GetZhenFaEquipItemInfoList(itemInfo.id)
    end
    --endregion

    ---显示套装数据
    if suitType == nil or suitPartItemInfoList == nil then
        return
    end
    local title, des = clientTableManager.cfg_suitManager:GetCompleteSuitItemExtraAttributeDes(suitType, suitPartItemInfoList)
    if CS.StaticUtility.IsNullOrEmpty(title) or CS.StaticUtility.IsNullOrEmpty(des) then
        return
    end
    self:AddAttribute(title, "", des)
end
--endregion

--region 镶嵌装备
---设置镶嵌装备额外属性
---@param itemInfo TABLE.CFG_ITEMS
---@param bagItemInfo bagV2.BagItemInfo
---@param luaEnumSoulEquipType LuaEnumSoulEquipType
function UIItemInfoPanel_Info_ExtraAttribute:SetInlayEquipExtraAttribute(bagItemInfo, itemInfo, luaEnumSoulEquipType)
    if bagItemInfo ~= nil and itemInfo and itemInfo.type == luaEnumItemType.Equip then
        local tbl = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id)
        if tbl == nil then
            return
        end
        local equipIndex = bagItemInfo.index
        if type(equipIndex) ~= 'number' or equipIndex <= 0 then
            return
        end
        local otherMainPlayer = self.itemInfoSource == luaEnumItemInfoSource.UIOTHERROLEPANEL and self.isMainPartTemplate
        ---@type LuaSoulEquipMgr
        local inlaySoulEquipMgr = nil
        if otherMainPlayer then
            inlaySoulEquipMgr = gameMgr:GetOtherPlayerDataMgr():GetLuaSoulEquipData()
        else
            inlaySoulEquipMgr = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr()
        end
        local inlayItemClass = inlaySoulEquipMgr:GetSoulEquipClassToEquipIndex(luaEnumSoulEquipType, equipIndex)
        if inlayItemClass == nil then
            return
        end
        ---@type table<number,LuaSoulEquipHoleInfo>
        local allSoulEquipInfo = inlayItemClass:GetSoulEquip_All()
        if (allSoulEquipInfo == nil) then
            return
        end
        local firstAttribute = true
        for i, v in pairs(allSoulEquipInfo) do
            local inlayItemInfo = v.cfg_items
            if inlayItemInfo ~= nil and type(inlayItemInfo:GetExtraMonEffectInlay()) == 'number' and inlayItemInfo:GetExtraMonEffectInlay() > 0 then
                local inlayEffectTbl = clientTableManager.cfg_inlay_effectManager:TryGetValue(inlayItemInfo:GetExtraMonEffectInlay())
                if inlayEffectTbl ~= nil then
                    local titleName = inlayEffectTbl:GetTitle()
                    local attributeColor = luaEnumColorType.Green3
                    if v.active == false then
                        titleName = inlayEffectTbl:GetTitle3()
                        attributeColor = luaEnumColorType.Gray
                    end
                    local iconName = inlayItemInfo:GetIcon()
                    local attrValue = attributeColor .. clientTableManager.cfg_extra_mon_effectManager:GetAllAttributeShow(inlayEffectTbl:GetExtraMonEffect(), self.career)
                    if CS.StaticUtility.IsNullOrEmpty(titleName) == false and CS.StaticUtility.IsNullOrEmpty(iconName) == false and CS.StaticUtility.IsNullOrEmpty(attrValue) == false then
                        self:AddAttribute(firstAttribute and titleName or '', iconName, attrValue)
                        firstAttribute = false
                    end
                end
            end
        end
    end
end
--endregion

--region 镶嵌属性
---显示镶嵌属性
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_Info_ExtraAttribute:ShowInlayAttribute(bagItemInfo, itemInfo)
    if itemInfo == nil then
        return
    end
    local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id)
    if luaItemInfo == nil or type(luaItemInfo:GetExtraMonEffectInlay()) ~= 'number' or luaItemInfo:GetExtraMonEffectInlay() <= 0 then
        return
    end
    ---装备位上有同类型的镶嵌装备，则不显示当前装备的镶嵌属性
    if bagItemInfo ~= nil and type(bagItemInfo.index) == 'number' and bagItemInfo.index > 0 then
        local otherMainPlayer = self.itemInfoSource == luaEnumItemInfoSource.UIOTHERROLEPANEL and self.isMainPartTemplate
        ---@type LuaSoulEquipMgr
        local inlaySoulEquipMgr = nil
        if otherMainPlayer then
            inlaySoulEquipMgr = gameMgr:GetOtherPlayerDataMgr():GetLuaSoulEquipData()
        else
            inlaySoulEquipMgr = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr()
        end
        local sameTypeInlayEquipClass = inlaySoulEquipMgr:GetCurTypeInlayEquip(bagItemInfo.index, luaItemInfo:GetSuitBelong())
        if sameTypeInlayEquipClass ~= nil then
            return
        end
    end
    local InlayEffectTbl = clientTableManager.cfg_inlay_effectManager:TryGetValue(luaItemInfo:GetExtraMonEffectInlay())
    if InlayEffectTbl == nil then
        return
    end
    if type(InlayEffectTbl:GetExtraMonEffect()) == 'number' and InlayEffectTbl:GetExtraMonEffect() > 0 then
        local extraMonEffectTbl = clientTableManager.cfg_extra_mon_effectManager:TryGetValue(InlayEffectTbl:GetExtraMonEffect())
        if extraMonEffectTbl ~= nil then
            local titleName = InlayEffectTbl:GetTitle2()
            local iconName = ""
            local attrValue = luaEnumColorType.Gray .. clientTableManager.cfg_extra_mon_effectManager:GetAllAttributeShow(InlayEffectTbl:GetExtraMonEffect(), self.career)
            self:AddAttribute(titleName, iconName, attrValue)
        end
    end
    local buffDes = clientTableManager.cfg_inlay_effectManager:GetBuffesTipsDes(luaItemInfo:GetExtraMonEffectInlay())
    if (not Utility.IsNilOrEmptyString(buffDes)) then
        self:AddAttribute(InlayEffectTbl:GetTitle2(), '', luaEnumColorType.Gray .. buffDes)
    end
end
--endregion

--region 重铸属性
---添加重铸属性
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_Info_ExtraAttribute:AddRecastAttribute(bagItemInfo, itemInfo)
    ---@type boolean 是否是主角的物品
    local otherMainPlayer = self.itemInfoSource == luaEnumItemInfoSource.UIOTHERROLEPANEL and self.isMainPartTemplate
    if bagItemInfo == nil or (otherMainPlayer == false and bagItemInfo ~= nil and gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipInfo(bagItemInfo.lid) == nil) then
        return
    end
    local recastMgr = gameMgr:GetPlayerDataMgr():GetRecastMgr()
    if otherMainPlayer == true then
        recastMgr = gameMgr:GetOtherPlayerDataMgr():GetRecastMgr()
    end
    local equipIndexRecastInfo = recastMgr:GetRecastList():GetRecastInfo(itemInfo.subType, self.career)
    local attributeDes, effectDes = equipIndexRecastInfo.AttributeDes
    if equipIndexRecastInfo.recastTbl ~= nil then
        effectDes = clientTableManager.cfg_recastManager:GetItemInfoPanelDes(equipIndexRecastInfo.recastTbl:GetId())
    end
    if CS.StaticUtility.IsNullOrEmpty(attributeDes) == false then
        local attributeDes = string.gsub(attributeDes, '\\n', '\n')
        self:AddAttribute(luaEnumColorType.Blue3 .. "重铸属性", "", attributeDes)
    end
    if CS.StaticUtility.IsNullOrEmpty(effectDes) == false then
        local effectDes = string.gsub(effectDes, '\\n', '\n')
        self:AddAttribute(luaEnumColorType.Blue3 .. "重铸效果", "", luaEnumColorType.Green1 .. effectDes)
    end
end
--endregion
--endregion

function UIItemInfoPanel_Info_ExtraAttribute:AddAttribute(titleName, iconName, attrValue, attrDesc)
    self.count = self.count + 1
    ---@type UIItemInfoExtraAttribute
    local attribute = { titleName = titleName, iconName = iconName, attrValue = attrValue, attrDesc = attrDesc }
    table.insert(self.extraAttributeTable, attribute)
end

function UIItemInfoPanel_Info_ExtraAttribute:ClearAttributeData()
    self.count = 0
    ---@type table<UIItemInfoExtraAttribute>
    self.extraAttributeTable = {}
end
--endregion

--region鉴定属性读取
function UIItemInfoPanel_Info_ExtraAttribute:GetJianDingAttr(type)
    local getTable = LuaGlobalTableDeal.GetGlobalTabl(23005)
    local getColor = LuaGlobalTableDeal.GetGlobalTabl(23006)
    local tableIndex = {}
    local attrInfo = string.Split(getTable.value, "&")
    for i = 1, #attrInfo do
        local attrIndex = string.Split(attrInfo[i], "#")
        if tonumber(attrIndex[1]) == type then
            tableIndex.des = attrIndex[2]
        end
    end
    local colorInfo = string.Split(getColor.value, "&")
    for i = 1, #colorInfo do
        local colorIndex = string.Split(colorInfo[i], "#")
        if tonumber(colorIndex[1]) == type then
            tableIndex.color = colorIndex[2]
            return tableIndex
        end
    end
end
--endregion

return UIItemInfoPanel_Info_ExtraAttribute