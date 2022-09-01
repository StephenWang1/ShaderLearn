---藏品界面右侧部分
---@class UICollectionRightPart:TemplateBase
local UICollectionRightPart = {}

--region 组件
---属性文字容器
---@return UIGridContainer
function UICollectionRightPart:GetAttributeGridContainer()
    if self.mGongJiAttrLabel == nil then
        self.mGongJiAttrLabel = self:Get("Main/Scroll View/Attribute", "UIGridContainer")
    end
    return self.mGongJiAttrLabel
end

---连锁属性的容器
---@return UIGridContainer
function UICollectionRightPart:GetLinkEffectGridContainer()
    if self.mLinkEffectGridContainer == nil then
        self.mLinkEffectGridContainer = self:Get("Main/collectionScroll/collectionItem", "UIGridContainer")
    end
    return self.mLinkEffectGridContainer
end

---等级经验进度条
---@return UISlider
function UICollectionRightPart:GetLevelExpSlider()
    if self.mLevelExpSlider == nil then
        self.mLevelExpSlider = self:Get("Main/level/Slider", "UISlider")
    end
    return self.mLevelExpSlider
end

---经验文本
---@return UILabel
function UICollectionRightPart:GetExpLabel()
    if self.mExpLabel == nil then
        self.mExpLabel = self:Get("Main/level/Num", "UILabel")
    end
    return self.mExpLabel
end

---等级文本
---@return UILabel
function UICollectionRightPart:GetLevelLabel()
    if self.mLevelLabel == nil then
        self.mLevelLabel = self:Get("Main/level/lv", "UILabel")
    end
    return self.mLevelLabel
end

---下个等级属性的根节点
---@return UnityEngine.GameObject
function UICollectionRightPart:GetNextLevelAttributeGo()
    if self.mNextLevelAttributeGo == nil then
        self.mNextLevelAttributeGo = self:Get("Main/nextAttribute", "GameObject")
    end
    return self.mNextLevelAttributeGo
end

---下个等级藏品格子数增量文本
---@return UILabel
function UICollectionRightPart:GetNextLevelGridCountAddedLabel()
    if self.mNextLevelGridCountAddedLabel == nil then
        self.mNextLevelGridCountAddedLabel = self:Get("Main/nextAttribute/Scroll View/Attribute/trellis", "UILabel")
    end
    return self.mNextLevelGridCountAddedLabel
end

---下个等级藏品格子数增量文本
---@return UILabel
function UICollectionRightPart:GetNextLevelHPAddedLabel()
    if self.mNextLevelHPAddedLabel == nil then
        self.mNextLevelHPAddedLabel = self:Get("Main/nextAttribute/Scroll View/Attribute/hp", "UILabel")
    end
    return self.mNextLevelHPAddedLabel
end

---升级按钮
---@return UnityEngine.GameObject
function UICollectionRightPart:GetLevelUpBtnGo()
    if self.mLevelUpBtnGo == nil then
        self.mLevelUpBtnGo = self:Get("Main/Btn_Up", "GameObject")
    end
    return self.mLevelUpBtnGo
end

---@return UnityEngine.GameObject
function UICollectionRightPart:GetLevelMaxGo()
    if self.mLevelMaxGo == nil then
        self.mLevelMaxGo = self:Get("Main/levelMax", "GameObject")
    end
    return self.mLevelMaxGo
end

---升级按钮文本
---@return UILabel
function UICollectionRightPart:GetLevelUpBtnLabel()
    if self.mLevelUpBtnLabel == nil then
        self.mLevelUpBtnLabel = self:Get("Main/Btn_Up/Label", "UILabel")
    end
    return self.mLevelUpBtnLabel
end

---升级提示特效
---@return UnityEngine.GameObject
function UICollectionRightPart:GetLevelUpHintEffectGo()
    if self.mLevelUpHintEffectGo == nil then
        self.mLevelUpHintEffectGo = self:Get("Main/Btn_Up/effect", "GameObject")
    end
    return self.mLevelUpHintEffectGo
end
--endregion

--region 属性
---归属的藏品界面
---@return UICollectionPanel
function UICollectionRightPart:GetOwnerPanel()
    return self.mCollectionPanel
end

---代表的藏品信息
---@return LuaCollectionInfo
function UICollectionRightPart:GetCollectionInfo()
    return self.mCollectionInfo
end

---获取归属者的职业
---@return LuaEnumCareer
function UICollectionRightPart:GetCareer()
    return self.mCareer
end
--endregion

--region 初始化
---@param collectionPanel UICollectionPanel
---@param collectionInfo LuaCollectionInfo
---@param career LuaEnumCareer
function UICollectionRightPart:Init(collectionPanel, collectionInfo, career)
    self.mCollectionPanel = collectionPanel
    self.mCollectionInfo = collectionInfo
    self.mCareer = career
    CS.UIEventListener.Get(self:GetLevelUpBtnGo()).onClick = function(go)
        self:OnLevelUpBtnClicked(go)
    end
end
--endregion

--region 刷新
function UICollectionRightPart:OnEnable()
    ---开启时刷新一下UI
    self:RefreshUI()
end

function UICollectionRightPart:RefreshUI()
    if self:GetCollectionInfo() == nil then
        return
    end
    self:RefreshAttributes()
    self:RefreshLinkEffects()
    self:RefreshCabinetLevelAndExp()
end

---刷新藏品属性的展示(每个藏品的属性 + 激活的连锁属性)
---@private
function UICollectionRightPart:RefreshAttributes()
    ---最小攻击/魔法/道术
    local atkMin = 0
    ---最大攻击/魔法/道术
    local atkMax = 0
    ---攻击/魔法/道术文本
    local atkStr = "攻击"
    if self.mCareer == LuaEnumCareer.Warrior then
        atkStr = "攻击"
    elseif self.mCareer == LuaEnumCareer.Master then
        atkStr = "魔法"
    elseif self.mCareer == LuaEnumCareer.Taoist then
        atkStr = "道术"
    end
    ---最小物防
    local defMin = 0
    ---最大物防
    local defMax = 0
    ---最小魔防
    local magDefMin = 0
    ---最大魔防
    local magDefMax = 0
    ---生命最小值
    local hp = 0
    ---魔法
    local mp = 0
    ---闪避
    local dodge = 0
    ---精确
    local accurate = 0
    ---暴击
    local critical = 0
    ---抗暴
    local resistanceCrit = 0
    ---最小切割伤害
    local holyAttackMin = 0
    ---最大切割伤害
    local holyAttackMax = 0
    ---计算藏品属性
    for i, v in pairs(self:GetCollectionInfo():GetCollectionDic()) do
        if self.mCareer == LuaEnumCareer.Warrior then
            atkMin = atkMin + self:FetchAttributeFromAttributeList(v, LuaEnumAttributeType.PhyAttackMin)
            atkMax = atkMax + self:FetchAttributeFromAttributeList(v, LuaEnumAttributeType.PhyAttackMax)
        elseif self.mCareer == LuaEnumCareer.Master then
            atkMin = atkMin + self:FetchAttributeFromAttributeList(v, LuaEnumAttributeType.MagicAttackMin)
            atkMax = atkMax + self:FetchAttributeFromAttributeList(v, LuaEnumAttributeType.MagicAttackMax)
        elseif self.mCareer == LuaEnumCareer.Taoist then
            atkMin = atkMin + self:FetchAttributeFromAttributeList(v, LuaEnumAttributeType.TaoAttackMin)
            atkMax = atkMax + self:FetchAttributeFromAttributeList(v, LuaEnumAttributeType.TaoAttackMax)
        end
        defMin = defMin + self:FetchAttributeFromAttributeList(v, LuaEnumAttributeType.PhyDefenceMin)
        defMax = defMax + self:FetchAttributeFromAttributeList(v, LuaEnumAttributeType.PhyDefenceMax)
        magDefMin = magDefMin + self:FetchAttributeFromAttributeList(v, LuaEnumAttributeType.MagicDefenceMin)
        magDefMax = magDefMax + self:FetchAttributeFromAttributeList(v, LuaEnumAttributeType.MagicDefenceMax)
        hp = hp + self:FetchAttributeFromAttributeList(v, LuaEnumAttributeType.MaxHp)
    end
    ---计算连锁属性
    if self:GetCollectionInfo():GetLinkEffectIDList() ~= nil then
        for i = 1, #self:GetCollectionInfo():GetLinkEffectIDList() do
            local linkEffectTbl = clientTableManager.cfg_linkeffectManager:TryGetValue(self:GetCollectionInfo():GetLinkEffectIDList()[i])
            if linkEffectTbl ~= nil then
                defMin = defMin + linkEffectTbl:GetPhyDefMin()
                defMax = defMax + linkEffectTbl:GetPhyDefMax()
                magDefMin = magDefMin + linkEffectTbl:GetMagicDefMin()
                magDefMax = magDefMax + linkEffectTbl:GetMagicDefMax()

                if self.mCareer == LuaEnumCareer.Warrior then
                    if linkEffectTbl:GetHp() ~= nil and linkEffectTbl:GetHp().list ~= nil and #linkEffectTbl:GetHp().list > 0 then
                        hp = hp + linkEffectTbl:GetHp().list[1].list[2]
                    end
                    atkMin = atkMin + linkEffectTbl:GetPhyAttMin()
                    atkMax = atkMax + linkEffectTbl:GetPhyAttMax()
                elseif self.mCareer == LuaEnumCareer.Master then
                    if linkEffectTbl:GetHp() ~= nil and linkEffectTbl:GetHp().list ~= nil and #linkEffectTbl:GetHp().list > 0 then
                        hp = hp + linkEffectTbl:GetHp().list[2].list[2]
                    end
                    atkMin = atkMin + linkEffectTbl:GetMagicAttMin()
                    atkMax = atkMax + linkEffectTbl:GetMagicAttMax()
                elseif self.mCareer == LuaEnumCareer.Taoist then
                    if linkEffectTbl:GetHp() ~= nil and linkEffectTbl:GetHp().list ~= nil and #linkEffectTbl:GetHp().list > 0 then
                        hp = hp + linkEffectTbl:GetHp().list[3].list[2]
                    end
                    atkMin = atkMin + linkEffectTbl:GetTaoAttMin()
                    atkMax = atkMax + linkEffectTbl:GetTaoAttMax()
                end
                mp = mp + linkEffectTbl:GetMp()
                dodge = dodge + linkEffectTbl:GetDodge()
                accurate = accurate + linkEffectTbl:GetAccurate()
                critical = critical + linkEffectTbl:GetShowCritical()
                resistanceCrit = resistanceCrit + linkEffectTbl:GetResistanceCrit()
                holyAttackMin = holyAttackMin + linkEffectTbl:GetHolyAttackMin()
                holyAttackMax = holyAttackMax + linkEffectTbl:GetHolyAttackMax()
            end
        end
    end
    local isShowEmptyAttr = false
    local attrPairs = {}
    if isShowEmptyAttr or atkMin ~= 0 or atkMax ~= 0 then
        table.insert(attrPairs, { atkStr, atkMin, atkMax })
    end
    if isShowEmptyAttr or defMin ~= 0 or defMax ~= 0 then
        table.insert(attrPairs, { "防御", defMin, defMax })
    end
    if isShowEmptyAttr or magDefMin ~= 0 or magDefMax ~= 0 then
        table.insert(attrPairs, { "魔防", magDefMin, magDefMax })
    end
    if isShowEmptyAttr or hp ~= 0 then
        table.insert(attrPairs, { "血量", hp })
    end
    if isShowEmptyAttr or mp ~= 0 then
        table.insert(attrPairs, { "蓝量", mp })
    end
    if isShowEmptyAttr or critical ~= 0 then
        local criticalTemp = critical * 0.01
        criticalTemp = criticalTemp == math.floor(criticalTemp) and math.floor(criticalTemp) or criticalTemp
        table.insert(attrPairs, { "暴击", criticalTemp .. "%" })
    end
    if isShowEmptyAttr or resistanceCrit ~= 0 then
        local resistanceCritTemp = resistanceCrit * 0.01
        resistanceCritTemp = resistanceCritTemp == math.floor(resistanceCritTemp) and math.floor(resistanceCritTemp) or resistanceCritTemp
        table.insert(attrPairs, { "抗暴", resistanceCritTemp .. "%" })
    end
    if isShowEmptyAttr or accurate ~= 0 then
        table.insert(attrPairs, { "准确", accurate })
    end
    if isShowEmptyAttr or dodge ~= 0 then
        table.insert(attrPairs, { "敏捷", dodge })
    end
    if isShowEmptyAttr or holyAttackMin ~= 0 or holyAttackMax ~= 0 then
        table.insert(attrPairs, { "切割", holyAttackMin, holyAttackMax })
    end
    self:GetAttributeGridContainer().MaxCount = #attrPairs
    for i = 1, #attrPairs do
        self:SetAttributeToGo(self:GetAttributeGridContainer().controlList[i - 1], table.unpack(attrPairs[i]))
    end
end

---设置属性
---@param go UnityEngine.GameObject
---@param attributeName string
---@param value number
---@param maxValue
function UICollectionRightPart:SetAttributeToGo(go, attributeName, value, maxValue)
    ---@type UILabel
    local titleLabel = self:GetCurComp(go, "Label", "UILabel")
    ---@type UILabel
    local valueLabel = self:GetCurComp(go, "", "UILabel")
    titleLabel.text = Utility.CombineStringQuickly("[878787]", attributeName)
    if value == nil then
        valueLabel.text = ""
    elseif maxValue == nil then
        valueLabel.text = tostring(value)
    else
        valueLabel.text = Utility.CombineStringQuickly(value, "-", maxValue)
    end
end

---获取藏品的浮动属性
---@private
---@param collectionItem LuaCollectionItem
---@param attributeType LuaEnumAttributeType
---@return number
function UICollectionRightPart:FetchAttributeFromAttributeList(collectionItem, attributeType)
    local bagItem = collectionItem:GetCollectionBagItem()
    if bagItem ~= nil and bagItem.rateAttribute ~= nil then
        for i = 1, #bagItem.rateAttribute do
            if bagItem.rateAttribute[i].type == attributeType then
                return bagItem.rateAttribute[i].num
            end
        end
    end
    return 0
end

---刷新连锁属性
---@private
function UICollectionRightPart:RefreshLinkEffects()
    local linkEffectIDList = self:GetCollectionInfo():GetLinkEffectIDList()
    if linkEffectIDList == nil or #linkEffectIDList == 0 then
        self:GetLinkEffectGridContainer().MaxCount = 0
    else
        local count = #linkEffectIDList
        ---@type table<number, table<number, TABLE.cfg_linkeffect>>
        self.mActiveLinkEffectTypeList = {}
        for i = 1, #linkEffectIDList do
            local tbl = clientTableManager.cfg_linkeffectManager:TryGetValue(linkEffectIDList[i])
            if tbl and tbl:GetSubType() ~= nil then
                local list = self.mActiveLinkEffectTypeList[tbl:GetSubType()]
                if list == nil then
                    list = {}
                    self.mActiveLinkEffectTypeList[tbl:GetSubType()] = list
                end
                table.insert(list, tbl)
            end
        end

        self:GetLinkEffectGridContainer().MaxCount = Utility.GetTableCount(self.mActiveLinkEffectTypeList)
        if self.mChosenLinkEffectID == nil then
            for i, v in pairs(self.mActiveLinkEffectTypeList) do
                self.mChosenLinkEffectID = i
                break
            end
        end
        local index = 0
        for i, v in pairs(self.mActiveLinkEffectTypeList) do
            local go = self:GetLinkEffectGridContainer().controlList[index]
            local template = self:GetLinkEffectCellTemplateByCellGo(go)
            template:Refresh(v[1])
            template:SetChosenState(self.mChosenLinkEffectSubType == i)
            index = index + 1
        end
    end
end

---@private
---@param go UnityEngine.GameObject
---@return UICollectionRightPart_LinkEffectCell
function UICollectionRightPart:GetLinkEffectCellTemplateByCellGo(go)
    if self.mLinkEffectCells == nil then
        self.mLinkEffectCells = {}
    end
    local template = self.mLinkEffectCells[go]
    if template == nil then
        if self.mCellClickCallBack == nil then
            self.mCellClickCallBack = function(...)
                self:OnLinkEffectCellClicked(...)
            end
        end
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICollectionRightPart_LinkEffectCell, self, self.mCellClickCallBack)
        self.mLinkEffectCells[go] = template
    end
    return template
end

---刷新藏宝阁等级及经验
---@private
function UICollectionRightPart:RefreshCabinetLevelAndExp()
    local currentLevel = self:GetCollectionInfo():GetCabinetLevel()
    local exp = self:GetCollectionInfo():GetCabinetExp()
    local collectionBoxTbl = clientTableManager.cfg_collectionboxManager:TryGetValue(currentLevel)
    local nextLevel = currentLevel + 1
    local nextCollectionBoxTbl = clientTableManager.cfg_collectionboxManager:TryGetValue(nextLevel)
    local levelUpRequiredExp = 0
    if nextCollectionBoxTbl ~= nil then
        levelUpRequiredExp = nextCollectionBoxTbl:GetRequired()
    end
    if nextCollectionBoxTbl ~= nil then
        ---如果下一级存在,则显示当前经验,下一级经验
        if levelUpRequiredExp <= 0 then
            self:GetLevelExpSlider().value = math.clamp01(1)
        else
            self:GetLevelExpSlider().value = math.clamp01(exp / levelUpRequiredExp)
        end
        self:GetLevelUpBtnGo():SetActive(true)
        self:GetLevelMaxGo():SetActive(false)
        self:GetLevelLabel().text = "Lv." .. tostring(currentLevel)
        self:GetExpLabel().text = Utility.CombineStringQuickly(exp, "/", levelUpRequiredExp)
        self:GetNextLevelAttributeGo():SetActive(true)
        self:GetNextLevelGridCountAddedLabel().text = "+" .. tostring(nextCollectionBoxTbl:GetOpenBox() - collectionBoxTbl:GetOpenBox())
        self:GetNextLevelHPAddedLabel().text = Utility.CombineStringQuickly("+",
                tostring((nextCollectionBoxTbl:GetHp() - collectionBoxTbl:GetHp()) * 0.01),
                "%")
        self:GetLevelUpBtnLabel().text = "升级"
        self:GetLevelUpHintEffectGo():SetActive(exp >= levelUpRequiredExp)
    else
        ---如果下一级不存在,则显示已满足
        self:GetLevelUpBtnGo():SetActive(false)
        self:GetLevelMaxGo():SetActive(true)
        self:GetLevelLabel().text = "Lv." .. tostring(currentLevel)
        --经验值文本显示  当前经验值/上一级的经验值
        if collectionBoxTbl ~= nil then
            self:GetExpLabel().text = Utility.CombineStringQuickly(exp, "/", collectionBoxTbl:GetRequired())
        else
            self:GetExpLabel().text = "已满级"
        end
        self:GetLevelExpSlider().value = 1
        self:GetNextLevelAttributeGo():SetActive(false)
        self:GetLevelUpBtnLabel().text = "已满级"
        self:GetLevelUpHintEffectGo():SetActive(false)
    end
end
--endregion

--region UI事件
---@param linkEffectCell UICollectionRightPart_LinkEffectCell
---@param linkEffectTbl TABLE.cfg_linkeffect
---@param go UnityEngine.GameObject
function UICollectionRightPart:OnLinkEffectCellClicked(linkEffectCell, linkEffectTbl, go)
    if linkEffectCell == nil or linkEffectTbl == nil or go == nil then
        return
    end
    if self.mChosenLinkEffectCell ~= nil then
        self.mChosenLinkEffectCell:SetChosenState(false)
    end
    self.mChosenLinkEffectCell = linkEffectCell
    self.mChosenLinkEffectSubType = linkEffectTbl:GetId()
    if self.mChosenLinkEffectCell ~= nil then
        self.mChosenLinkEffectCell:SetChosenState(true)
    end
    if self.mActiveLinkEffectTypeList == nil then
        return
    end
    local subType = linkEffectTbl:GetSubType()
    local list = self.mActiveLinkEffectTypeList[subType]
    uimanager:CreatePanel("UICollectionInfoPanel", nil, self:GetCollectionInfo(), self:GetCareer(), list)
end

---升级按钮点击事件,升级或者弹出提示
---@param go UnityEngine.GameObject
function UICollectionRightPart:OnLevelUpBtnClicked(go)
    local currentLevel = self:GetCollectionInfo():GetCabinetLevel()
    local exp = self:GetCollectionInfo():GetCabinetExp()
    local nextLevel = currentLevel + 1
    local nextCollectionBoxTbl = clientTableManager.cfg_collectionboxManager:TryGetValue(nextLevel)
    local levelUpRequiredExp = 0
    if nextCollectionBoxTbl ~= nil then
        levelUpRequiredExp = nextCollectionBoxTbl:GetRequired()
    end
    if nextCollectionBoxTbl ~= nil then
        ---有升级空间
        if exp >= levelUpRequiredExp then
            ---可以升级
            self:GetCollectionInfo():ReqLevelUpCabinet()
        else
            ---经验不足不能升级
            Utility.ShowPopoTips(go, "升级条件不满足", 290, self:GetOwnerPanel()._PanelName)
        end
    else
        ---等级已满
        Utility.ShowPopoTips(go, "已满级", 290, self:GetOwnerPanel()._PanelName)
    end
end
--endregion

return UICollectionRightPart