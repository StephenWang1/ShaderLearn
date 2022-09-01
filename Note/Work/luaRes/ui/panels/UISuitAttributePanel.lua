---@class UISuitAttributePanel:UIBase 套装属性
local UISuitAttributePanel = {}

--region 局部变量定义
---装备Index
UISuitAttributePanel.mSuitPos = {
    Utility.EnumToInt(CS.EEquipIndex.POS_WEAPON),
    Utility.EnumToInt(CS.EEquipIndex.POS_HEAD),
    Utility.EnumToInt(CS.EEquipIndex.POS_CLOTHES),
    Utility.EnumToInt(CS.EEquipIndex.POS_NECKLACE),
    Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_HAND),
    Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_HAND),
    Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_RING),
    Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_RING),
    Utility.EnumToInt(CS.EEquipIndex.POS_BELT),
    Utility.EnumToInt(CS.EEquipIndex.POS_SHOES),
    Utility.EnumToInt(CS.EEquipIndex.POS_LAMP),
    Utility.EnumToInt(CS.EEquipIndex.POS_SOULJADE),
    Utility.EnumToInt(CS.EEquipIndex.POS_GEMGLOVE),
    Utility.EnumToInt(CS.EEquipIndex.POS_RAWANIMA),
    Utility.EnumToInt(CS.EEquipIndex.POS_MEDAL),
}

---装备图标
UISuitAttributePanel.IconName = {
    [Utility.EnumToInt(CS.EEquipIndex.POS_WEAPON)] = "1",
    [Utility.EnumToInt(CS.EEquipIndex.POS_HEAD)] = "2",
    [Utility.EnumToInt(CS.EEquipIndex.POS_CLOTHES)] = "3",
    [Utility.EnumToInt(CS.EEquipIndex.POS_NECKLACE)] = "4",
    [Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_HAND)] = "5",
    [Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_HAND)] = "5",
    [Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_RING)] = "6",
    [Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_RING)] = "6",
    [Utility.EnumToInt(CS.EEquipIndex.POS_BELT)] = "7",
    [Utility.EnumToInt(CS.EEquipIndex.POS_SHOES)] = "8",
    [Utility.EnumToInt(CS.EEquipIndex.POS_LAMP)] = "13",
    [Utility.EnumToInt(CS.EEquipIndex.POS_SOULJADE)] = "15",
    [Utility.EnumToInt(CS.EEquipIndex.POS_GEMGLOVE)] = "21",
    [Utility.EnumToInt(CS.EEquipIndex.POS_RAWANIMA)] = "18",
    [Utility.EnumToInt(CS.EEquipIndex.POS_MEDAL)] = "22",
}

---缓存图标
UISuitAttributePanel.mShowLabel = {}

---当前显示图标数目
UISuitAttributePanel.mSuitNum = nil

---当前等级
UISuitAttributePanel.mCurrentSuitLevel = 0

---两行背景高度
UISuitAttributePanel.mLine2 = 383

---两行描述高度
UISuitAttributePanel.mDesHeight = 148

---增加一行的高度
UISuitAttributePanel.mLineHeight = 80

--endregion

--region组件
---获取Icon显示
function UISuitAttributePanel.GetIconShow_UIGridContainer()
    if UISuitAttributePanel.mIconRoot == nil then
        UISuitAttributePanel.mIconRoot = UISuitAttributePanel:GetCurComp("WidgetRoot/icon", "UIGridContainer")
    end
    return UISuitAttributePanel.mIconRoot
end

---背景图片
function UISuitAttributePanel.GetBgSprite_UISprite()
    if UISuitAttributePanel.mBGSprite == nil then
        UISuitAttributePanel.mBGSprite = UISuitAttributePanel:GetCurComp("WidgetRoot/bg", "UISprite")
    end
    return UISuitAttributePanel.mBGSprite
end

---背景字
function UISuitAttributePanel:GetBgDes_GameObject()
    if self.mBGDes == nil then
        self.mBGDes = self:GetCurComp("WidgetRoot/dec", "GameObject")
    end
    return self.mBGDes
end

---@return UIGridContainer 属性
function UISuitAttributePanel:GetCurrentSuit_UIGridContainer()
    if self.mCurrentSuitContainer == nil then
        self.mCurrentSuitContainer = self:GetCurComp("WidgetRoot/Current/attribute", "UIGridContainer")
    end
    return self.mCurrentSuitContainer
end

---@return UIGridContainer 属性名字
function UISuitAttributePanel:GetCurrentSuitAttributeName_UIGridContainer()
    if self.mCurrentSuitAttributeName == nil then
        self.mCurrentSuitAttributeName = self:GetCurComp("WidgetRoot/Current/attributeName", "UIGridContainer")
    end
    return self.mCurrentSuitAttributeName
end

---@return UIGridContainer
function UISuitAttributePanel:GetNextSuit_UIGridContainer()
    if self.mNextSuitContainer == nil then
        self.mNextSuitContainer = self:GetCurComp("WidgetRoot/Next/attribute", "UIGridContainer")
    end
    return self.mNextSuitContainer
end

---@return UIGridContainer 属性名字
function UISuitAttributePanel:GetNextSuitAttributeName_UIGridContainer()
    if self.mNextSuitAttributeName == nil then
        self.mNextSuitAttributeName = self:GetCurComp("WidgetRoot/Next/attributeName", "UIGridContainer")
    end
    return self.mNextSuitAttributeName
end

---@return UnityEngine.GameObject 满级
function UISuitAttributePanel:GetLevelFull_GO()
    if self.mLevelFullGo == nil then
        self.mLevelFullGo = self:GetCurComp("WidgetRoot/Next/Finish", "GameObject")
    end
    return self.mLevelFullGo
end
--endregion

---@return CSMainPlayerInfo 玩家信息
function UISuitAttributePanel:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---属性名字
UISuitAttributePanel.mAttributeName = {
    [1] = "攻击",
    [2] = "生命",
    [3] = "物防",
    [4] = "魔防",
}

--region 初始化
function UISuitAttributePanel:Init()
    local career = Utility.EnumToInt(self:GetMainPlayerInfo().Career)
    local careerName = Utility.GetCareerAttackName(career)
    self.mAttributeName[1] = careerName
    self:AddCollider()
end

---@param  customData.ShowNum XLua.Cast.Int32 显示开启数目
function UISuitAttributePanel:Show(suitLevel, ShowNum)
    if ShowNum ~= self.mSuitNum and ShowNum ~= nil then
        self.mSuitNum = ShowNum
        self:ShowIcon(ShowNum)
    end
    if suitLevel then
        self.mCurrentSuitLevel = suitLevel
    end
    self:RefreshShowLabel()
    self:RefreshSuitShow(suitLevel)
end

--region UI事件

---显示图标
function UISuitAttributePanel:ShowIcon(num)
    self:SetPanel(num)
    self.mShowLabel = {}
    UISuitAttributePanel.GetIconShow_UIGridContainer().MaxCount = num
    for i = 1, num do
        local gp = UISuitAttributePanel.GetIconShow_UIGridContainer().controlList[i - 1].gameObject
        local sprite = CS.Utility_Lua.GetComponent(gp, "UISprite")
        local equipIndex = UISuitAttributePanel.mSuitPos[i]
        if sprite and CS.StaticUtility.IsNull(sprite) == false then
            sprite.spriteName = UISuitAttributePanel.IconName[equipIndex]
        end
        local label = CS.Utility_Lua.GetComponent(gp.transform:Find("lv"), "UILabel")
        if label and CS.StaticUtility.IsNull(label) == false then
            label.text = "[878787]+0"
        end
        self.mShowLabel[equipIndex] = label
    end
end

---刷新强化显示
function UISuitAttributePanel:RefreshShowLabel()
    local EquipDic = CS.CSScene.MainPlayerInfo.EquipInfo.Equips
    for k, v in pairs(EquipDic) do
        local label = self.mShowLabel[k]
        if label and CS.StaticUtility.IsNull(label) == false then
            local color = ternary(v.intensify < UISuitAttributePanel.mCurrentSuitLevel, "[878787]", "")
            label.text = color .. "+" .. v.intensify
        end
    end
end

---设置界面位置大小
function UISuitAttributePanel:SetPanel(num)
    local bgHeight = UISuitAttributePanel.mLine2
    local desHeight = UISuitAttributePanel.mDesHeight
    if num == #UISuitAttributePanel.mSuitPos then
        bgHeight = bgHeight + UISuitAttributePanel.mLineHeight
        desHeight = desHeight + UISuitAttributePanel.mLineHeight
    end
    if UISuitAttributePanel.GetBgSprite_UISprite() and CS.StaticUtility.IsNull(UISuitAttributePanel.GetBgSprite_UISprite()) == false then
        UISuitAttributePanel.GetBgSprite_UISprite().height = bgHeight
    end
    if not CS.StaticUtility.IsNull(self:GetBgDes_GameObject()) then
        self:GetBgDes_GameObject():SetActive(true)
        self:GetBgDes_GameObject().transform.localPosition = CS.UnityEngine.Vector3(0, desHeight, 0)
    end
end

---刷新套装显示
function UISuitAttributePanel:RefreshSuitShow(level)
    local res, CurrentData = CS.Cfg_IntensifyTableManager.Instance.dic:TryGetValue(level)
    local res2, NextData = CS.Cfg_IntensifyTableManager.Instance.dic:TryGetValue(level + 1)
    if res then
        if res2 then
            self:RefreshContainer(self:GetNextSuit_UIGridContainer(), NextData, CurrentData, self:GetNextSuitAttributeName_UIGridContainer())
        else
            self:GetNextSuit_UIGridContainer().MaxCount = 0
            self:GetNextSuitAttributeName_UIGridContainer().MaxCount = 0
        end
        self:GetLevelFull_GO():SetActive(not res2)
        self:RefreshContainer(self:GetCurrentSuit_UIGridContainer(), CurrentData, nil, self:GetCurrentSuitAttributeName_UIGridContainer())
    end
end

---@param container UIGridContainer
---@param data TABLE.CFG_INTENSIFY
---@param compareData TABLE.CFG_INTENSIFY
---@param nameContainer UIGridContainer
function UISuitAttributePanel:RefreshContainer(container, data, compareData, nameContainer)
    if CS.StaticUtility.IsNull(nameContainer) or CS.StaticUtility.IsNull(container) then
        return
    end
    local playerCareer = Utility.EnumToInt(self:GetMainPlayerInfo().Career)
    container.MaxCount = #self.mAttributeName
    nameContainer.MaxCount = #self.mAttributeName
    for i = 0, #self.mAttributeName - 1 do
        local color = ternary(compareData, luaEnumColorType.Gray, luaEnumColorType.White)

        local go = container.controlList[i]
        local label = CS.Utility_Lua.GetComponent(go.transform, "UILabel")

        local nameGo = nameContainer.controlList[i]
        local nameLabel = CS.Utility_Lua.GetComponent(nameGo.transform, "UILabel")

        if not CS.StaticUtility.IsNull(label) then
            --属性名
            local name = self.mAttributeName[i + 1]

            --属性数据
            local lowData
            local topData
            local compLowData
            if i == 0 then
                lowData = data.attTaoMin
                topData = data.attTaoMax
                if compareData then
                    compLowData = compareData.attTaoMin
                end
            elseif i == 1 then
                lowData = data.maxHp
                if compareData then
                    compLowData = compareData.maxHp
                end
            elseif i == 2 then
                lowData = data.phyDefenceMin
                topData = data.phyDefenceMax
                if compareData then
                    compLowData = compareData.phyDefenceMin
                end
            elseif i == 3 then
                lowData = data.magicDefenceMin
                topData = data.magicDefenceMax
                if compareData then
                    compLowData = compareData.magicDefenceMin
                end
            end
            local info1 = self:GetAttitudeData(lowData, playerCareer)
            local info2 = self:GetAttitudeData(topData, playerCareer)
            local compInfo = self:GetAttitudeData(compLowData, playerCareer)
            local add = ternary(topData, "-", "")
            --颜色
            if compLowData then
                color = ternary(compInfo < info1, luaEnumColorType.Green, color)
            end

            --赋值
            label.text = color .. info1 .. add .. info2
            nameLabel.text = color .. name
        end
    end

end

---@param info TABLE.IntListList
function UISuitAttributePanel:GetAttitudeData(info, sex)
    if info and sex then
        for i = 0, info.list.Count do
            local data = info.list[i].list
            if data.Count >= 2 then
                if data[0] == sex then
                    return data[1]
                end
            end
        end
    end
    return ""
end



--endregion

return UISuitAttributePanel