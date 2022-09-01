---称号信息模板
---@class UIAppearancePanelTitleInfoTemplate:TemplateBase
local UIAppearancePanelTitleInfoTemplate = {}

---称号名
---@return Top_UIScrollView
function UIAppearancePanelTitleInfoTemplate:GetRootScrollView()
    if self.mRootScrollView == nil then
        self.mRootScrollView = self:Get("ScrollView", "Top_UIScrollView")
    end
    return self.mRootScrollView
end

---称号
---@return UILabel
function UIAppearancePanelTitleInfoTemplate:GetAppearanceTitleNameLabel()
    if self.mAppearanceSuitNameLabel == nil then
        self.mAppearanceSuitNameLabel = self:Get("ScrollView/TitleName", "UILabel")
    end
    return self.mAppearanceSuitNameLabel
end

---称号来源
---@return UILabel
function UIAppearancePanelTitleInfoTemplate:GetTitleSourceLabel()
    if self.mTitleSourceLabel == nil then
        self.mTitleSourceLabel = self:Get("ScrollView/TitleSource", "UILabel")
    end
    return self.mTitleSourceLabel
end

---剩余时间
---@return UICountdownLabel
function UIAppearancePanelTitleInfoTemplate:GetCostTimeLabel()
    if self.mCostTimeLabel == nil then
        self.mCostTimeLabel = self:Get("ScrollView/CostTime", "UICountdownLabel")
    end
    return self.mCostTimeLabel
end

---属性列表
---@return Top_UIGridContainer
function UIAppearancePanelTitleInfoTemplate:GetAttributeGrid()
    if self.mAttributeGrid == nil then
        self.mAttributeGrid = self:Get("ScrollView/Gird", "Top_UIGridContainer")
    end
    return self.mAttributeGrid
end

---刷新称号信息
---@param info titleV2.TitleInfo
---@param type 外观类型
function UIAppearancePanelTitleInfoTemplate:Refresh(info, type)
    self:RefreshWithTitleInfo(info)
end

--region Init

function UIAppearancePanelTitleInfoTemplate:Init()
    ---@type TABLE.cfg_title
    self.titleTbl = nil
    self.career = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
end

--endregion

--region view

---使用称号信息刷新
---@private
---@param info titleV2.TitleInfo
---@private
function UIAppearancePanelTitleInfoTemplate:RefreshWithTitleInfo(info)
    if info == nil or CS.CSScene.Sington == nil or CS.CSScene.Sington.MainPlayer == nil or CS.CSScene.Sington.MainPlayer.BaseInfo == nil or CS.CSScene.Sington.MainPlayer.BaseInfo.TitleInfoV2 == nil then
        if self.go and CS.StaticUtility.IsNull(self.go) == false then
            self.go:SetActive(false)
        end
    else
        ---@type TABLE.cfg_title
        self.titleTbl = clientTableManager.cfg_titleManager:TryGetValue(info.titleId)
        if self.titleTbl == nil then
            if self.go and CS.StaticUtility.IsNull(self.go) == false then
                self.go:SetActive(false)
            end
        else
            if self.go and CS.StaticUtility.IsNull(self.go) == false then
                self.go:SetActive(true)
                self:RefreshTitleInfoView(info)
                self:RefreshAttributeView()
            end
        end
    end
end

---刷新称号说明视图
function UIAppearancePanelTitleInfoTemplate:RefreshTitleInfoView(info)
    local titleTbl = self.titleTbl
    self:GetAppearanceTitleNameLabel().text = CS.Utility_Lua.GetItemColorByQuality(titleTbl:GetQuality()) .. titleTbl:GetTitleName() .. "[-]"
    local timeRemark = titleTbl:GetTimeRemark()
    self:GetTitleSourceLabel().text = "[878787][称号来源]" .. titleTbl:GetDes() .. "[-]"
    if (not (timeRemark == nil or timeRemark == "")) then
        self:GetCostTimeLabel().gameObject:SetActive(true)
        self:GetCostTimeLabel():StopCountDown()
        self:GetCostTimeLabel()._Label.text = "[878787]" .. timeRemark .. "[-]"
    elseif titleTbl:GetLastTime() == nil or titleTbl:GetLastTime() == 0 then
        self:GetCostTimeLabel().gameObject:SetActive(false)
    else
        self:GetCostTimeLabel().gameObject:SetActive(true)
        local endTimeStamp = info.getTime + titleTbl:GetLastTime() * 60 * 1000
        self:GetCostTimeLabel():StartCountDown(nil, 2, endTimeStamp, "[878787]剩余时间[-]  [ff0000]", "[-]", nil, nil)
    end
end

---刷新称号属性视图
function UIAppearancePanelTitleInfoTemplate:RefreshAttributeView()
    local showTbl = self:GetShowAttributeTbl()
    self:GetAttributeGrid().MaxCount = #showTbl
    for i = 1, #showTbl do
        local go = self:GetAttributeGrid().controlList[i - 1]
        ---@type titleAttribute
        local data = showTbl[i]
        if go and data then
            local label = CS.Utility_Lua.GetComponent(go.transform:Find("Str"), "Top_UILabel")
            local showStr = data.str .. ' ' .. tostring(data.curMinValue)
            if data.curMaxValue then
                showStr = showStr .. '-' .. tostring(data.curMaxValue)
            end
            if label and not CS.StaticUtility.IsNull(label.gameObject) then
                label.text = showStr
            end
        end
    end
    self:GetRootScrollView():SetSoftnessValue(true, 3)
end

--endregion

--region otherFunc

---@return table<number,titleAttribute>
function UIAppearancePanelTitleInfoTemplate:GetShowAttributeTbl()
    local tbl = {}
    if self.titleTbl then
        for i = 1, 7 do
            local attributeInfo = self:GetAttributeInfo(i)
            if attributeInfo then
                table.insert(tbl, attributeInfo)
            end
        end
    end
    return tbl
end

---获得属性展示文本
---@return titleAttribute|nil
function UIAppearancePanelTitleInfoTemplate:GetAttributeInfo(index)
    local mStr, mCurMinValue, mCurMaxValue

    if index == 1 then
        mStr = Utility.GetCareerAttackName(self.career)
        mCurMinValue = self:GetAttackValueByCareer()
        mCurMaxValue = self:GetAttackValueByCareer(true)
    elseif index == 2 then
        mStr = "物防"
        mCurMinValue = self.titleTbl:GetDef()
        mCurMaxValue = self.titleTbl:GetDef()
    elseif index == 3 then
        mStr = "魔防"
        mCurMinValue = self.titleTbl:GetMdef()
        mCurMaxValue = self.titleTbl:GetMdef()
    elseif index == 4 then
        mStr = "生命"
        mCurMinValue = self.titleTbl:GetHp()
    elseif index == 5 then
        local bossDamage = self.titleTbl:GetBossDamageAdd()
        if bossDamage > 0 then
            mStr = "对BOSS伤害增加属性"
            mCurMinValue = (bossDamage * 0.01) .. "%"
            --mCurMaxValue = ""
        end
    elseif index == 6 then
        local dropRate = self.titleTbl:GetDropRate()
        if dropRate > 0 then
            mStr = "增加掉宝概率"
            mCurMinValue = (dropRate * 0.001) .. "%"
            --mCurMaxValue = ""
        end
    else
        return nil
    end

    if (mCurMinValue == nil or mCurMinValue == 0) and (mCurMaxValue == 0 or mCurMaxValue == nil) then
        return nil
    end

    ---@class titleAttribute
    local titleAttribute = {
        str = mStr,
        curMinValue = mCurMinValue,
        curMaxValue = mCurMaxValue,
        --nextMinValue = mNextMinValue,
        --nextMaxValue = mNextMaxValue,
        --isUp = mIsUp
    }
    return titleAttribute
end

---获取当前职业攻击的数值
---@param ismax boolean|nil 是否返回最大值
---@return number
function UIAppearancePanelTitleInfoTemplate:GetAttackValueByCareer(ismax)
    if self.titleTbl ~= nil then
        if self.career == LuaEnumCareer.Warrior then
            return ismax and self.titleTbl:GetPhyAttackMax() or self.titleTbl:GetPhyAttackMin()
        elseif self.career == LuaEnumCareer.Master then
            return ismax and self.titleTbl:GetMagicAttackMax() or self.titleTbl:GetMagicAttackMin()
        elseif self.career == LuaEnumCareer.Taoist then
            return ismax and self.titleTbl:GetTaoAttackMax() or self.titleTbl:GetTaoAttackMin()
        end
    end
    return 0
end

--endregion

return UIAppearancePanelTitleInfoTemplate