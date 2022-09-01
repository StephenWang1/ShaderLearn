---@class UISuitAttributeBloodSuitPanel:UIBase 血继的属性面板
local UISuitAttributeBloodSuitPanel = {}

local IsNull = CS.StaticUtility.IsNull

---@return CSMainPlayerInfo
function UISuitAttributeBloodSuitPanel:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

--region 数据获取
---@return LuaPlayerBloodSuitEquipMgr
function UISuitAttributeBloodSuitPanel:GetDataManager()
    if self.mMainData == nil then
        if self.playerType == 1 then
            self.mMainData = gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr()
        elseif self.playerType == 2 then
            self.mMainData = luaclass.LuaPlayerBloodSuitEquipMgr:New()
            local RoleToOtherInfo = gameMgr:GetOtherPlayerDataMgr().RoleToOtherInfo
            for i, item in pairs(RoleToOtherInfo.equipList) do
                self.mMainData:RefreShBloodSuitDic(item, item.index)
            end
        end
    end
    return self.mMainData
end
--endregion

--region 组件
---@return UILoopScrollViewPlus
function UISuitAttributeBloodSuitPanel:GetShowLoop()
    if self.mLoopGo == nil then
        self.mLoopGo = self:GetCurComp("WidgetRoot/view/Scroll View/scrollContent", "UILoopScrollViewPlus")
    end
    return self.mLoopGo
end

---@return UIPanel
function UISuitAttributeBloodSuitPanel:GetAttributeScrollView_UIPanel()
    if self.mScrollViewUIPanel == nil then
        self.mScrollViewUIPanel = self:GetCurComp("WidgetRoot/view/Scroll View", "UIPanel")
    end
    return self.mScrollViewUIPanel
end

---@return UISprite
function UISuitAttributeBloodSuitPanel:GetBg_UISprite()
    if self.mBgSp == nil then
        self.mBgSp = self:GetCurComp("WidgetRoot/window/background", "UISprite")
    end
    return self.mBgSp
end
--endregion

--region 初始化
function UISuitAttributeBloodSuitPanel:Init()
    self:BindEvents()
end
---@param chooseType LuaEquipBloodSuitType 选中套装类型
---@param playerType number 玩家类型 1 /主角 2/其他玩家
function UISuitAttributeBloodSuitPanel:Show(chooseType, playerType)
    self.mChooseType = chooseType
    self.playerType = playerType
    self:RefreshShowData()
end

function UISuitAttributeBloodSuitPanel:BindEvents()
    CS.UIEventListener.Get(self.go).onClick = function()
        self:ClosePanel()
    end
end

--endregion

--region 刷新面板

---@class BloodSuitLevelData
---@field type number 标题1/内容2
---@field info string 文本
---@field sort number 排序用

function UISuitAttributeBloodSuitPanel:RefreshShowData()
    ---@type BloodSuitLevelData
    local showTable = {}
    self:AddTotalSuitData(showTable)
    self:AddSingleSuitData(showTable)
    self:AddLevelSuitData(showTable)
    self:GetShowLoop():Init(function(go, line)
        if line < #showTable then
            local data = showTable[line + 1]
            if data then
                self:RefreshSingleLine(go, data)
            end
            return true
        else
            return false
        end
    end, nil)
    self:SuitPanel(#showTable)
end

---@param data BloodSuitLevelData
function UISuitAttributeBloodSuitPanel:RefreshSingleLine(go, data)
    ---@type UILabel
    local title = CS.Utility_Lua.Get(go.transform, "title", "UILabel")
    ---@type UILabel
    local attr = CS.Utility_Lua.Get(go.transform, "AttrName", "UILabel")
    if IsNull(title) or IsNull(attr) then
        return
    end
    local isTitle = data.type == 1
    local isInfo = data.type == 2
    --[[    title.gameObject:SetActive(isTitle)
        attr.gameObject:SetActive(isInfo)]]
    local titleColor = "[73ddf7]"
    title.text = isTitle and titleColor .. data.info or ""
    attr.text = isInfo and data.info or ""

end

---添加总属性
function UISuitAttributeBloodSuitPanel:AddTotalSuitData(allTbl)
    ---@type table<LuaEnumAttributeType,BloodSuitAttributeData>
    local allAttributeData = self:GetDataManager():GetAllEquipAttribute()
    local attributeData = {}
    self:SortAttribute(allAttributeData, attributeData)
    if #attributeData > 0 then
        ---@type  BloodSuitLevelData
        local data = {}
        data.type = 1
        data.info = "血继总属性"
        table.insert(allTbl, data)
        for i = 1, #attributeData do
            table.insert(allTbl, attributeData[i])
        end
    end
end

---添加X级属性（妖级/XXX）
function UISuitAttributeBloodSuitPanel:AddSingleSuitData(allTbl)
    ---@type LuaPlayerEquipBloodSuitListData
    local singleData = self:GetDataManager():GetSingleBloodSuitListData(self.mChooseType)
    if singleData then
        ---@type table<LuaEnumAttributeType,BloodSuitAttributeData>
        local attribute = singleData:GetBloodSuitAttribute()
        local attributeData = {}
        self:SortAttribute(attribute, attributeData)
        if #attributeData > 0 then
            ---@type  BloodSuitLevelData
            local data = {}
            data.type = 1
            data.info = uiStaticParameter.mBloodSuitTypeName[self.mChooseType] .. "属性"
            table.insert(allTbl, data)
            for i = 1, #attributeData do
                table.insert(allTbl, attributeData[i])
            end
        end
    end
end

---对属性排序后添加
function UISuitAttributeBloodSuitPanel:SortAttribute(attribute, allTbl)
    local addTable = {}
    for k, v in pairs(attribute) do
        self:AddSingleAttribute(addTable, k, v)
    end
    table.sort(addTable, function(l, r)
        if l == nil or r == nil or l.sort == nil or r.sort == nil then
            return false
        end
        return l.sort < r.sort
    end)
    for i = 1, #addTable do
        table.insert(allTbl, addTable[i])
    end
end

---@param k LuaEnumAttributeType
---@param v BloodSuitAttributeData
---@param table table<number BloodSuitLevelData>
function UISuitAttributeBloodSuitPanel:AddSingleAttribute(allTbl, k, v)
    local needAdd = true

    local min = v.min
    local max = v.max

    local showInfo = ""
    local hasLeft = v.min ~= nil
    local hasRight = v.max ~= nil
    if hasLeft and hasRight then
        if min == 0 and max == 0 then
            needAdd = false
        end
        showInfo = min .. "-" .. max
    elseif hasLeft and not hasRight then
        if min == 0 then
            needAdd = false
        end
        showInfo = min
    elseif not hasLeft and hasRight then
        if max == 0 then
            needAdd = false
        end
        showInfo = max
    end
    ---@type  BloodSuitLevelData
    local data = {}
    data.type = 2
    data.info = uiStaticParameter.mAttributeData[k] .. "   " .. showInfo
    data.sort = v.sort
    if needAdd and self:NeedAddType(v.attributeType) then
        table.insert(allTbl, data)
    end
end

---@param attributeType LuaEnumAttributeType
---@return boolean 根据职业判断是否显示此条
function UISuitAttributeBloodSuitPanel:NeedAddType(attributeType)
    local carrer = self:GetMainPlayerInfo().Career
    if attributeType == LuaEnumAttributeType.PhyAttackMax then
        return carrer == CS.ECareer.Warrior
    elseif attributeType == LuaEnumAttributeType.MagicAttackMax then
        return carrer == CS.ECareer.Master
    elseif attributeType == LuaEnumAttributeType.TaoAttackMax then
        return carrer == CS.ECareer.Taoist
    end
    return true
end

---添加套装属性
function UISuitAttributeBloodSuitPanel:AddLevelSuitData(allTbl)
    ---@type  BloodSuitLevelData
    local data = {}
    data.type = 1
    local titleInfo = ""
    table.insert(allTbl, data)
    local singleData = self:GetDataManager():GetSingleBloodSuitListData(self.mChooseType)
    if singleData then
        local data = self:CacheSuitConditionData(self.mChooseType)
        if data then
            titleInfo = data:GetGroupName()
        end
    end
    data.info = uiStaticParameter.mBloodSuitTypeName[self.mChooseType] .. "套装: " .. titleInfo

    local currentLevel = self:GetCurrentLevel()
    self:AddSingleLevelSuitData(allTbl, currentLevel)
    self:AddSingleLevelSuitData(allTbl, currentLevel + 1)
end

---@return number 返回当前最大套装属性
function UISuitAttributeBloodSuitPanel:GetCurrentLevel()
    local levelMin = 0
    local levelMax = #clientTableManager.cfg_bloodsuit_levelManager.dic + 1
    local maxLevel = 0
    for i = levelMin, levelMax do
        local suitNum = self:GetLevelNum(i)
        if suitNum >= 12 then
            maxLevel = i
        end
    end
    return maxLevel
end

---添加单行套装属性
function UISuitAttributeBloodSuitPanel:AddSingleLevelSuitData(allTbl, level)
    local data = self:CacheSuitConditionData(self.mChooseType)
    if data then
        local skillIdData = data:GetGroupSkill()
        if skillIdData and skillIdData.list then
            for i = 1, #skillIdData.list do
                local skillId = skillIdData.list[i]
                ---@type TABLE.CFG_SKILLS_CONDITION
                local skillData = CS.Cfg_SkillsConditionManager.Instance:GetSkillsCondition(skillId, level)
                if skillData then

                    local suitNum = self:GetLevelNum(level)
                    if suitNum then
                        local color = suitNum >= 12 and luaEnumColorType.Green or luaEnumColorType.Gray
                        local strs = color .. "Lv" .. level .. " (" .. suitNum .. "/12) " .. skillData.show
                        local str = string.Split(strs, '\n')
                        for i = 1, #str do
                            ---@type  BloodSuitLevelData
                            local data = {}
                            data.type = 2
                            data.info = str[i]
                            table.insert(allTbl, data)
                        end
                    end
                end
            end
        end
    end
end

---@return number 获取等级对应的套装数目
function UISuitAttributeBloodSuitPanel:GetLevelNum(level)
    local singleData = self:GetDataManager():GetSingleBloodSuitListData(self.mChooseType)
    if singleData then
        return singleData:GetSuitActivateCount(level - 1)
    end
    return 0
end

--endregion

--region 界面适配
function UISuitAttributeBloodSuitPanel:SuitPanel(num)
    if num == nil then
        return
    end
    local height = 0
    local length = self:GetShowLoop().CellLeghth
    if length then
        height = height + length
    end
    local des = self:GetShowLoop().gapDis
    if des then
        height = height + des
    end
    local gap = 40
    local totalHeight = num * height + gap
    local sizeHeight = self:GetAttributeScrollView_UIPanel():GetViewSize().y
    local pos = self:GetAttributeScrollView_UIPanel().gameObject.transform.localPosition
    local PosY = -(sizeHeight - totalHeight + gap) / 2
    pos.y = totalHeight < sizeHeight and PosY or 0
    self:GetAttributeScrollView_UIPanel().gameObject.transform.localPosition = pos
    self:GetBg_UISprite().height = totalHeight < sizeHeight and totalHeight or sizeHeight + gap
end
--endregion


--region 数据缓存
---@return TABLE.cfg_bloodsuit_combination
function UISuitAttributeBloodSuitPanel:CacheSuitConditionData(level)
    if self.mLevelToConditionData == nil then
        self.mLevelToConditionData = {}
    end
    local data = self.mLevelToConditionData[level]
    if data == nil then
        data = clientTableManager.cfg_bloodsuit_combinationManager:TryGetValue(level)
        self.mLevelToConditionData[level] = data
    end
    return data
end

--endregion

return UISuitAttributeBloodSuitPanel