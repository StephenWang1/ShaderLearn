---@class UIAppearancePanelInfoTemplate:TemplateBase
local UIAppearancePanelInfoTemplate = {}

--region 组件
---外观套装UILabel
function UIAppearancePanelInfoTemplate:GetAppearanceSuitNameLabel()
    if self.mAppearanceSuitNameLabel == nil then
        self.mAppearanceSuitNameLabel = self:Get("ScrollView/SuitName", "UILabel")
    end
    return self.mAppearanceSuitNameLabel
end

---属性标题
---@return UILabel
function UIAppearancePanelInfoTemplate:GetAttriTitleLabel()
    if self.mAttriTitleLabel == nil then
        self.mAttriTitleLabel = self:Get("ScrollView/Title", "UILabel")
    end
    return self.mAttriTitleLabel
end

---外观名UILabel
---@return UILabel
function UIAppearancePanelInfoTemplate:GetAppearanceNameLabel()
    if self.mAppearanceNameLabel == nil then
        self.mAppearanceNameLabel = self:Get("ScrollView/AppearanceName", "UILabel")
    end
    return self.mAppearanceNameLabel
end

---属性格子
---@return UIGridContainer
function UIAppearancePanelInfoTemplate:GetAppearanceAttrGridsContainer()
    if self.mAppearanceAttrGridsContainer == nil then
        self.mAppearanceAttrGridsContainer = self:Get("ScrollView/Gird", "UIGridContainer")
    end
    return self.mAppearanceAttrGridsContainer
end

---穿戴条件标题
---@return UnityEngine.GameObject
function UIAppearancePanelInfoTemplate:GetUseConditionTitle()
    if self.mUseConditionTitle == nil then
        self.mUseConditionTitle = self:Get("ScrollView/Title2", "GameObject")
    end
    return self.mUseConditionTitle
end

---穿戴条件文字
---@return UILabel
function UIAppearancePanelInfoTemplate:GetUseConditionLabel()
    if self.mUseConditionLabel == nil then
        self.mUseConditionLabel = self:Get("ScrollView/CostInfo", "UILabel")
    end
    return self.mUseConditionLabel
end

---穿戴时效标题
---@return UILabel
function UIAppearancePanelInfoTemplate:GetCostTimeTitleLabel()
    if self.mCostTimeTitleLabel == nil then
        self.mCostTimeTitleLabel = self:Get("ScrollView/Title3", "UILabel")
    end
    return self.mCostTimeTitleLabel
end

---穿戴时效文字
---@return UICountdownLabel
function UIAppearancePanelInfoTemplate:GetCostTimeLabel()
    if self.mCostTimeLabel == nil then
        self.mCostTimeLabel = self:Get("ScrollView/CostTime", "UICountdownLabel")
    end
    return self.mCostTimeLabel
end
--endregion

---@param info bagV2.BagItemInfo|titleV2.TitleInfo
---@param type 外观类型
function UIAppearancePanelInfoTemplate:Refresh(info, type)
    if type == LuaEnumAppearanceType.Title then
        self:RefreshWithTitleInfo(info)
    elseif type ~= nil then
        self:RefreshWithBagItemInfo(info)
    else
        if self.go and CS.StaticUtility.IsNull(self.go) == false then
            self.go:SetActive(false)
        end
    end
end

---使用称号信息刷新
---@param info titleV2.TitleInfo
---@private
function UIAppearancePanelInfoTemplate:RefreshWithTitleInfo(info)
    if info == nil or CS.CSScene.Sington == nil or CS.CSScene.Sington.MainPlayer == nil or CS.CSScene.Sington.MainPlayer.BaseInfo == nil or CS.CSScene.Sington.MainPlayer.BaseInfo.TitleInfoV2 == nil then
        if self.go and CS.StaticUtility.IsNull(self.go) == false then
            self.go:SetActive(false)
        end
    else
        ---@type TABLE.CFG_TITLE
        local titleTbl
        ___, titleTbl = CS.Cfg_TitleTableManager.Instance:TryGetValue(info.titleId)
        if titleTbl == nil then
            if self.go and CS.StaticUtility.IsNull(self.go) == false then
                self.go:SetActive(false)
            end
        else
            if self.go and CS.StaticUtility.IsNull(self.go) == false then
                self.go:SetActive(true)
            end
            self:GetAppearanceNameLabel().text = CS.Utility_Lua.GetItemColorByQuality(titleTbl.quality) .. titleTbl.titleName .. "[-]"
            self:GetAppearanceSuitNameLabel().gameObject:SetActive(false)
            self:ClearAttrs()
            --if titleTbl.phyAttackMin ~= 0 and titleTbl.phyAttackMax ~= 0 then
            --    self:AddAttr("攻击 " .. titleTbl.phyAttackMin .. "-" .. titleTbl.phyAttackMax)
            --elseif titleTbl.phyAttackMin ~= 0 then
            --    self:AddAttr("攻击 " .. titleTbl.phyAttackMin)
            --elseif titleTbl.phyAttackMax ~= 0 then
            --    self:AddAttr("攻击 " .. titleTbl.phyAttackMax)
            --end
            --if titleTbl.magicAttackMin ~= 0 and titleTbl.magicAttackMax ~= 0 then
            --    self:AddAttr(Utility.GetAttributeName(LuaEnumAttributeType.MagicAttackMax) .. " " .. titleTbl.magicAttackMin .. "-" .. titleTbl.magicAttackMax)
            --elseif titleTbl.magicAttackMax ~= 0 then
            --    self:AddAttr(Utility.GetAttributeName(LuaEnumAttributeType.MagicAttackMax) .. " " .. titleTbl.magicAttackMax)
            --elseif titleTbl.magicAttackMin ~= 0 then
            --    self:AddAttr(Utility.GetAttributeName(LuaEnumAttributeType.MagicAttackMax) .. " " .. titleTbl.magicAttackMin)
            --end
            --if titleTbl.taoAttackMin ~= 0 and titleTbl.taoAttackMax ~= 0 then
            --    self:AddAttr("道术 " .. titleTbl.taoAttackMin .. "-" .. titleTbl.taoAttackMax)
            --elseif titleTbl.taoAttackMin ~= 0 then
            --    self:AddAttr("道术 " .. " " .. titleTbl.taoAttackMin)
            --elseif titleTbl.taoAttackMax ~= 0 then
            --    self:AddAttr("道术 " .. " " .. titleTbl.taoAttackMax)
            --end
            --if titleTbl.def ~= 0 then
            --    self:AddAttr("防御 " .. titleTbl.def)
            --end
            --if titleTbl.mdef ~= 0 then
            --    self:AddAttr("魔防 " .. titleTbl.mdef)
            --end
            --if titleTbl.hp ~= 0 then
            --    self:AddAttr(Utility.GetAttributeName(LuaEnumAttributeType.MaxHp) .. " " .. titleTbl.hp)
            --end
            --if titleTbl.pkAtt ~= 0 then
            --    self:AddAttr(Utility.GetAttributeName(LuaEnumAttributeType.PkAtt) .. " " .. titleTbl.pkAtt)
            --end
            --if titleTbl.pkDef ~= 0 then
            --    self:AddAttr(Utility.GetAttributeName(LuaEnumAttributeType.PkDef) .. " " .. titleTbl.pkDef)
            --end
            self:FlushAttrs()
            self:GetUseConditionLabel().gameObject:SetActive(true)
            self:GetUseConditionTitle():SetActive(true)
            self:GetUseConditionLabel().text = titleTbl.des
            local timeRemark = titleTbl.timeRemark
            if (not (timeRemark == nil or timeRemark == "")) then
                self:GetCostTimeTitleLabel().gameObject:SetActive(true)
                self:GetCostTimeTitleLabel().text = "时效"
                self:GetCostTimeLabel().gameObject:SetActive(true)
                self:GetCostTimeLabel():StopCountDown()
                self:GetCostTimeLabel()._Label.text = timeRemark
            elseif titleTbl.lastTime == 0 then
                self:GetCostTimeTitleLabel().gameObject:SetActive(false)
                self:GetCostTimeLabel().gameObject:SetActive(false)
            else
                self:GetCostTimeTitleLabel().gameObject:SetActive(true)
                self:GetCostTimeTitleLabel().text = "时效"
                self:GetCostTimeLabel().gameObject:SetActive(true)
                local endTimeStamp = info.getTime + titleTbl.lastTime * 60 * 1000
                self:GetCostTimeLabel():StartCountDown(nil, 2, endTimeStamp, "剩余时间  [ffff00]", "[-]", nil, nil)
            end
        end
    end
end

---使用背包物品数据刷新
---@param info bagV2.BagItemInfo
---@private
function UIAppearancePanelInfoTemplate:RefreshWithBagItemInfo(info)
    if info == nil or CS.CSScene.Sington == nil or CS.CSScene.Sington.MainPlayer == nil or CS.CSScene.Sington.MainPlayer.BaseInfo == nil
            or CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData == nil then
        if self.go and CS.StaticUtility.IsNull(self.go) == false then
            self.go:SetActive(false)
        end
    else
        local appearanceTbl = CS.AppearanceData.GetAppearanceTable(info)
        local LuaAppearanceTbl = clientTableManager.cfg_appearanceManager:TryGetValue(appearanceTbl.id)
        local itemTbl = CS.Cfg_ItemsTableManager.Instance:GetItems(info.itemId)
        if self.go and CS.StaticUtility.IsNull(self.go) == false and appearanceTbl and itemTbl then
            self.go:SetActive(true)
        else
            self.go:SetActive(false)
        end
        self:GetAppearanceNameLabel().text = CS.Utility_Lua.GetItemColorByQuality(appearanceTbl.quality) .. appearanceTbl.name .. "[-]"
        self:GetAppearanceSuitNameLabel().gameObject:SetActive(false)
        self:ClearAttrs()
        local mainPlayerCareer = CS.CSScene.MainPlayerInfo.Career
        if mainPlayerCareer == CS.ECareer.Warrior then
            if appearanceTbl.phyAttMin ~= 0 and appearanceTbl.phyAttMax ~= 0 then
                self:AddAttr("攻击 " .. appearanceTbl.phyAttMin .. "-" .. appearanceTbl.phyAttMax)
            elseif appearanceTbl.phyAttMin ~= 0 then
                self:AddAttr("攻击 " .. appearanceTbl.phyAttMin)
            elseif appearanceTbl.phyAttMax ~= 0 then
                self:AddAttr("攻击 " .. appearanceTbl.phyAttMax)
            end
        elseif mainPlayerCareer == CS.ECareer.Master then
            if appearanceTbl.magicAttMax ~= 0 and appearanceTbl.magicAttMin ~= 0 then
                self:AddAttr(Utility.GetAttributeName(LuaEnumAttributeType.MagicAttackMax) .. " " .. appearanceTbl.magicAttMin .. "-" .. appearanceTbl.magicAttMax)
            elseif appearanceTbl.magicAttMin ~= 0 then
                self:AddAttr(Utility.GetAttributeName(LuaEnumAttributeType.MagicAttackMax) .. " " .. appearanceTbl.magicAttMin)
            elseif appearanceTbl.magicAttMax ~= 0 then
                self:AddAttr(Utility.GetAttributeName(LuaEnumAttributeType.MagicAttackMax) .. " " .. appearanceTbl.magicAttMax)
            end
        elseif mainPlayerCareer == CS.ECareer.Taoist then
            if appearanceTbl.monkAttMin ~= 0 and appearanceTbl.monkAttMax ~= 0 then
                self:AddAttr("道术 " .. appearanceTbl.monkAttMin .. "-" .. appearanceTbl.monkAttMax)
            elseif appearanceTbl.monkAttMin ~= 0 then
                self:AddAttr("道术 " .. appearanceTbl.monkAttMin)
            elseif appearanceTbl.monkAttMax ~= 0 then
                self:AddAttr("道术 " .. appearanceTbl.monkAttMax)
            end
        end
        if appearanceTbl.phyDenMin ~= 0 and appearanceTbl.phyDenMax ~= 0 then
            self:AddAttr("防御 " .. appearanceTbl.phyDenMin .. "-" .. appearanceTbl.phyDenMax)
        elseif appearanceTbl.phyDenMin ~= 0 then
            self:AddAttr("防御 " .. appearanceTbl.phyDenMin)
        elseif appearanceTbl.phyDenMax ~= 0 then
            self:AddAttr("防御 " .. appearanceTbl.phyDenMax)
        end
        if appearanceTbl.magicDenMin ~= 0 and appearanceTbl.magicDenMax ~= 0 then
            self:AddAttr("魔防 " .. appearanceTbl.magicDenMin .. "-" .. appearanceTbl.magicDenMax)
        elseif appearanceTbl.magicDenMin ~= 0 then
            self:AddAttr("魔防 " .. appearanceTbl.magicDenMin)
        elseif appearanceTbl.magicDenMax ~= 0 then
            self:AddAttr("魔防 " .. appearanceTbl.magicDenMax)
        end
        if appearanceTbl.blood ~= 0 then
            self:AddAttr(Utility.GetAttributeName(LuaEnumAttributeType.MaxHp) .. " " .. appearanceTbl.blood)
        end
        if LuaAppearanceTbl ~= nil and LuaAppearanceTbl:GetMonsterHurtAdd() > 0 then
            local attributeName = Utility.GetAttributeName(LuaEnumAttributeType.MonsterHuntAdd)
            local attributeValue = tostring(Utility.RemoveEndZero(LuaAppearanceTbl:GetMonsterHurtAdd() / 100)) .. "%"
            self:AddAttr(attributeName .. " " .. attributeValue)
        end
        if LuaAppearanceTbl ~= nil and LuaAppearanceTbl:GetAddDropTreasure() > 0 then
            local attributeName = Utility.GetAttributeName(LuaEnumAttributeType.AddDropTreasure)
            local attributeValue = tostring(Utility.RemoveEndZero(LuaAppearanceTbl:GetAddDropTreasure() / 1000)) .. "%"
            self:AddAttr(attributeName .. " " .. attributeValue)
        end
        
        ---此文本为tips描述，添加时请注意，一定是在最后位置
        if LuaAppearanceTbl ~= nil and LuaAppearanceTbl:GetTxt() ~= nil then
            local str = string.gsub(LuaAppearanceTbl:GetTxt(), '\\n', '\n')
            self:AddAttr(str)
        end
        self:FlushAttrs()
        self:GetAttriTitleLabel().gameObject:SetActive(false)
        if appearanceTbl.condition and appearanceTbl.condition ~= 0 then
            self:GetUseConditionLabel().gameObject:SetActive(true)
            self:GetUseConditionTitle():SetActive(true)
            local conditionTbl
            ___, conditionTbl = CS.Cfg_ConditionManager.Instance:TryGetValue(appearanceTbl.condition)
            if conditionTbl then
                self:GetUseConditionLabel().text = conditionTbl.show
            else
                self:GetUseConditionLabel().text = ""
            end
        else
            self:GetUseConditionLabel().gameObject:SetActive(false)
            self:GetUseConditionTitle():SetActive(false)
        end

        local hasTime = info.limitedTime and info.limitedTime > 0

        self:GetCostTimeLabel().gameObject:SetActive(hasTime)
        self:GetCostTimeTitleLabel().gameObject:SetActive(false)

        if hasTime then
            local endTimeStamp = info.limitedTime
            local color = luaEnumColorType.Red
            self:GetCostTimeLabel():StartCountDown(nil, 2, endTimeStamp, color .. "剩余时间  ", "[-]", nil, nil)
        end
        self:BagItemInfoSuitGridPos(hasTime)
    end
end

---背包信息适配属性位置
function UIAppearancePanelInfoTemplate:BagItemInfoSuitGridPos(hasTime)
    local pos = self:GetAppearanceAttrGridsContainer().gameObject.transform.localPosition
    local posY = hasTime and 37 or 61
    pos.y = posY
    self:GetAppearanceAttrGridsContainer().gameObject.transform.localPosition = pos
    local timePos = self:GetCostTimeLabel().gameObject.transform.localPosition
    timePos.y = 61
    self:GetCostTimeLabel().gameObject.transform.localPosition = timePos
end

function UIAppearancePanelInfoTemplate:ClearAttrs()
    self.mAttrs = {}
end

function UIAppearancePanelInfoTemplate:AddAttr(attributeStr)
    if self.mAttrs == nil then
        self.mAttrs = {}
    end
    table.insert(self.mAttrs, attributeStr)
end

function UIAppearancePanelInfoTemplate:FlushAttrs()
    local count = #self.mAttrs
    self:GetAppearanceAttrGridsContainer().MaxCount = count
    if count > 0 then
        for i = 1, count do
            local goTemp = self:GetAppearanceAttrGridsContainer().controlList[i - 1]
            if goTemp then
                local label = self:GetCurComp(goTemp, "Str", "UILabel")
                label.text = self.mAttrs[i]
            end
        end
        self:GetAttriTitleLabel().gameObject:SetActive(true)
    else
        self:GetAttriTitleLabel().gameObject:SetActive(false)
    end
end

return UIAppearancePanelInfoTemplate