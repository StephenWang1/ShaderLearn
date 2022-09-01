---@class BloodSuitItemInfoComp_ExtraAttribute:UIItemInfoPanel_Info_ExtraAttribute
local BloodSuitItemInfoComp_ExtraAttribute = {}

setmetatable(BloodSuitItemInfoComp_ExtraAttribute, luaComponentTemplates.UIItemInfoPanel_Info_ExtraAttribute)

---@param commonData UIItemTipInfoCommonData
function BloodSuitItemInfoComp_ExtraAttribute:RefreshWithInfo(commonData)
    ---@type bagV2.BagItemInfo
    local bagItemInfo = commonData.bagItemInfo
    ---@type TABLE.CFG_ITEMS
    local itemInfo = commonData.itemInfo
    ---@type LuaPlayerBloodSuitEquipMgr
    local ownerBloodSuitEquipMgr
    ---@type 职业类型
    local career
    if commonData.commonData then
        ownerBloodSuitEquipMgr = commonData.commonData.ownerBloodSuitEquipMgr
        career = commonData.commonData.career
    end
    if ownerBloodSuitEquipMgr == nil then
        ownerBloodSuitEquipMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr()
    end
    if career == nil then
        career = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    end

    self:ClearAttributeData()

    --[[
    if itemInfo and bagItemInfo then
        self:RefreshBloodSuitNormalAttributes(bagItemInfo, itemInfo, ownerBloodSuitEquipMgr, career)
        local bagItemIndex = bagItemInfo.index
        if bagItemIndex ~= 0 then
            local suitType = math.floor(bagItemIndex / 100) % 10
            if suitType ~= 0 then
                ---如果该装备穿在身上则显示对应的套装的技能属性
                self:RefreshBloodSuitSkillAttributes(bagItemInfo, itemInfo, suitType, ownerBloodSuitEquipMgr, career)
            end
        end
        self:RefreshBloodSuitResonance(bagItemInfo, itemInfo)
    end
    --]]

    self:ShowAttribute(bagItemInfo, itemInfo)
end

---刷新血继套装普通属性
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
---@param ownerBloodSuitEquipMgr LuaPlayerBloodSuitEquipMgr
---@param career 职业类型
function BloodSuitItemInfoComp_ExtraAttribute:RefreshBloodSuitNormalAttributes(bagItemInfo, itemInfo, ownerBloodSuitEquipMgr, career)
    local bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(itemInfo.id)
    if bloodsuitTbl then
        ---如果为血继装备,则显示血继的特殊属性
        local titleName = "[73ddf7]血继属性  Lv." .. bagItemInfo.bloodLevel
        local attributestr = ""
        local isAttriExist = false
        for i = 1, #uiStaticParameter.mBloodSuitUseData do
            local attributeTypeTemp = uiStaticParameter.mBloodSuitUseData[i]
            ---职业是否匹配
            local isCareerMatch = true
            if attributeTypeTemp == LuaEnumAttributeType.PhyAttackMax and career ~= LuaEnumCareer.Warrior then
                isCareerMatch = false
            elseif attributeTypeTemp == LuaEnumAttributeType.MagicAttackMax and career ~= LuaEnumCareer.Master then
                isCareerMatch = false
            elseif attributeTypeTemp == LuaEnumAttributeType.TaoAttackMax and career ~= LuaEnumCareer.Taoist then
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

---刷新血继共鸣
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
function BloodSuitItemInfoComp_ExtraAttribute:RefreshBloodSuitResonance(bagItemInfo, itemInfo)
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
end

---刷新血继套装技能属性
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
---@param suitType LuaEquipBloodSuitType 套装类型
---@param ownerBloodSuitEquipMgr LuaPlayerBloodSuitEquipMgr
---@param career 职业类型
function BloodSuitItemInfoComp_ExtraAttribute:RefreshBloodSuitSkillAttributes(bagItemInfo, itemInfo, suitType, ownerBloodSuitEquipMgr, career)
    local titleName = uiStaticParameter.mBloodSuitTypeName[suitType]
    if titleName == nil then
        return
    end
    local bloodsuitCombinationTbl = clientTableManager.cfg_bloodsuit_combinationManager:TryGetValue(suitType)
    if bloodsuitCombinationTbl then
        titleName = "[73ddf7]" .. titleName .. "套装: " .. bloodsuitCombinationTbl:GetGroupName()
    end
    ---@type LuaPlayerEquipBloodSuitListData
    local singleData = ownerBloodSuitEquipMgr:GetSingleBloodSuitListData(suitType)
    ---当前套装等级
    local minBloodSuitLevel, maxBloodSuitLevel = self:GetMinAndMaxBloodSuitLevel()
    local currentSuitLevel = minBloodSuitLevel
    for i = minBloodSuitLevel, maxBloodSuitLevel do
        if singleData:GetSuitActivateCount(i) >= 12 then
            currentSuitLevel = i
        else
            break
        end
    end
    local attributeValue, currentActiviteCount = self:GetSkillDescriptionsForBloodSuitSkill(suitType, singleData, currentSuitLevel)
    if attributeValue ~= nil and currentActiviteCount ~= nil and currentActiviteCount >= 12 then
        local nextLevelDescription = self:GetSkillDescriptionsForBloodSuitSkill(suitType, singleData, currentSuitLevel + 1)
        if nextLevelDescription ~= nil and nextLevelDescription ~= "" then
            attributeValue = attributeValue .. "\r\n" .. nextLevelDescription
        end
    end
    self:AddAttribute(titleName, '', attributeValue)
end

---获取血继套装的最小等级和最大等级
---@return number,number
function BloodSuitItemInfoComp_ExtraAttribute:GetMinAndMaxBloodSuitLevel()
    if self.mMinBloodSuitLevel ~= nil and self.mMaxBloodSuitLevel ~= nil then
        return self.mMinBloodSuitLevel, self.mMaxBloodSuitLevel
    end
    self.mMinBloodSuitLevel = 99999
    self.mMaxBloodSuitLevel = -1
    clientTableManager.cfg_bloodsuit_levelManager:ForPair(function(id, tbl)
        local levelTemp = tbl:GetLevel()
        self.mMinBloodSuitLevel = (self.mMinBloodSuitLevel > levelTemp) and levelTemp or self.mMinBloodSuitLevel
        self.mMaxBloodSuitLevel = (self.mMaxBloodSuitLevel < levelTemp) and levelTemp or self.mMaxBloodSuitLevel
    end)
    return self.mMinBloodSuitLevel, self.mMaxBloodSuitLevel
end

---获取血继套装技能的描述
---@param suitType LuaEquipBloodSuitType
---@param singleData LuaPlayerEquipBloodSuitListData
---@param level number
---@return string|nil,number
function BloodSuitItemInfoComp_ExtraAttribute:GetSkillDescriptionsForBloodSuitSkill(suitType, singleData, level)
    ---获取套装中最大等级和最小等级
    local minLevel, maxLevel = self:GetMinAndMaxBloodSuitLevel()
    local currentSkillSuitLevel = level + 1
    if level < minLevel or level > maxLevel then
        return
    end
    ---当前套装激活数量
    local currentActiviteCount = singleData:GetSuitActivateCount(level)
    local currentSkillSuitConditionTbl = clientTableManager.cfg_bloodsuit_combinationManager:TryGetValue(suitType)
    local groupSkills = currentSkillSuitConditionTbl:GetGroupSkill()
    if groupSkills == nil or groupSkills.list == nil or #groupSkills.list == 0 then
        return
    end
    local strs = ""
    local count = 1
    ---遍历该套装所有技能,记录所有技能在当前等级的参数
    for i = 1, #groupSkills.list do
        local skillID = groupSkills.list[i]
        ---@type TABLE.CFG_SKILLS_CONDITION
        local skillData = CS.Cfg_SkillsConditionManager.Instance:GetSkillsCondition(skillID, currentSkillSuitLevel)
        if skillData then
            local colorStr = (currentActiviteCount >= 12) and luaEnumColorType.Green or luaEnumColorType.Gray
            local str = colorStr .. "Lv" .. currentSkillSuitLevel .. " (" .. currentActiviteCount .. "/12) " .. skillData.show
            if count ~= 1 then
                strs = strs .. "\r\n" .. str
            else
                strs = strs .. str
            end
            count = count + 1
        end
    end
    return strs, currentActiviteCount
end

return BloodSuitItemInfoComp_ExtraAttribute