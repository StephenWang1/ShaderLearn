local UIElement_StoneListTemplate = {}
--region 初始化
function UIElement_StoneListTemplate:Init()
    self:InitComponent()
    self:InitEvents()
    self:InitParams()
end

function UIElement_StoneListTemplate:InitComponent()
    self.mStoneList_ScrollView = self:Get("stoneList", "UIScrollView")
    self.mStoneList_UIGridContainer = self:Get("stoneList/activityBtns", "UIGridContainer")
    self.mNoElementTips_GameObject = self:Get("NoElementtips", "GameObject")
    self.mNoElementTipsGet_GameObject = self:Get("NoElementtips/GetSignet", "GameObject")
    self.mNoReplaceElement_GameObject = self:Get("NoSignet", "GameObject")
    self.mNoReplaceElementGet_GameObject = self:Get("NoSignet/Get", "GameObject")
    self.mNoReplaceElementInfo_GameObject = self:Get("NoSignet/elementInfo", "GameObject")
    self.mNoReplaceElementNameInfo_UILabel = self:Get("NoSignet/elementInfo/ElementType", "UILabel")
    self.mNoReplaceElementAttackInfo_UILabel = self:Get("NoSignet/elementInfo/AttackType", "UILabel")
    self.mStoneInfo = self:Get("stoneInfo", "GameObject")
    self.mStoneInfoRightElementInfo_TweenPosition = self:Get("stoneInfo/rightElementInfo", "TweenPosition")
    self.mStoneInfoElementType_UILabel = self:Get("stoneInfo/rightElementInfo/ElementType", "UILabel")
    self.mStoneInfoAttackType_UILabel = self:Get("stoneInfo/rightElementInfo/AttackType", "UILabel")
    self.mStoneInfoLeftElementInfo_GameObject = self:Get("stoneInfo/leftElementInfo", "GameObject")
    self.leftInfoElementType_UILabel = self:Get("stoneInfo/leftElementInfo/ElementType", "UILabel")
    self.leftInfoAttackTypeName_UILabel = self:Get("stoneInfo/leftElementInfo/AttackType", "UILabel")
    self.mArrow_GameObject = self:Get("stoneInfo/arrow", "GameObject")
    self.mStoneListBack_Go = self:Get("back", "GameObject")
    self.mStoneList_SpringPanel = self:Get("stoneList", "SpringPanel")
    --self.mHint_GameObject = self:Get("stoneInfo/Hint","GameObject")
end

function UIElement_StoneListTemplate:InitEvents()
    CS.UIEventListener.Get(self.mNoElementTipsGet_GameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.mNoElementTipsGet_GameObject).OnClickLuaDelegate = self.NoElementTipsGetOnClick
    CS.UIEventListener.Get(self.mNoReplaceElementGet_GameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.mNoReplaceElementGet_GameObject).OnClickLuaDelegate = self.NoReplaceElementTipsGetOnClick
end

function UIElement_StoneListTemplate:InitParams()
    self.originPosition = self.mStoneList_ScrollView.transform.localPosition
    self.singleLineNum = self.mStoneList_UIGridContainer.MaxPerLine
    self.singleLineHigh = self.mStoneList_UIGridContainer.CellHeight
    self.scrollviewShowLineNum = 2
end
--endregion

--region 事件
function UIElement_StoneListTemplate:NoElementTipsGetOnClick()
    uiTransferManager:TransferToPanel(LuaEnumTransferType.UISecretBookPanel_Element)
end

function UIElement_StoneListTemplate:NoReplaceElementTipsGetOnClick()
    uiTransferManager:TransferToPanel(LuaEnumTransferType.UISecretBookPanel_Element)
end
--endregion

--region 刷新
function UIElement_StoneListTemplate:RefreshPanel(commoonData)
    local AnalysisParamsSucceed = self:AnalysisParams(commoonData)
    self:ResetPanel()
    self.go:SetActive(AnalysisParamsSucceed)
    if AnalysisParamsSucceed then
        self:RefreshBackGround()
        if self.equipItemClass ~= nil then
            if self.isCanInlay == true and self.ElementBagItemInfoList.Count == 0 then
                if self.bodyElementInfo == nil then
                    self.mNoElementTips_GameObject:SetActive(true)
                else
                    self:RefreshNoReplaceStonePanel()
                end
                return
            end
            if self.ElementBagItemInfoList ~= nil and self.ElementBagItemInfoList.Count > 0 then
                self:RefreshStoneList()
                return
            end
        end
    end
    self:RefreshStoneInfo()
end

function UIElement_StoneListTemplate:RefreshBackGround()
    self.mStoneListBack_Go:SetActive(self.ElementBagItemInfoList ~= nil and self.ElementBagItemInfoList.Count > 0)
end

function UIElement_StoneListTemplate:ResetPanel()
    if self.go ~= nil then
        self.go:SetActive(false)
    end
    if self.mNoElementTips_GameObject ~= nil then
        self.mNoElementTips_GameObject:SetActive(false)
    end
    if self.mNoReplaceElement_GameObject ~= nil then
        self.mNoReplaceElement_GameObject:SetActive(false)
    end
    if self.mNoReplaceElementInfo_GameObject ~= nil then
        self.mNoReplaceElementInfo_GameObject:SetActive(false)
    end
    if self.mStoneList_ScrollView ~= nil then
        self.mStoneList_ScrollView.gameObject:SetActive(false)
    end
    if self.mStoneInfo ~= nil then
        self.mStoneInfo:SetActive(false)
    end
end

function UIElement_StoneListTemplate:AnalysisParams(commoonData)
    if commoonData ~= nil then
        self.ElementBagItemInfoList = commoonData.list
        self.equipItemClass = commoonData.equipItemClass
        self.isCanInlay = false
        if self.equipItemClass ~= nil then
            self.isCanInlay = self.equipItemClass.isCanInlay
        end
        self.elementTableInfo = nil
        if self.equipItemClass ~= nil and self.equipItemClass.elementTableInfo ~= nil then
            self.elementTableInfo = self.equipItemClass.elementTableInfo
        end
        if self.gridTemplate ~= nil then
            self.gridTemplate:SetChoose(false)
            self.gridTemplate = nil
        end
        if self.equipItemClass ~= nil and self.equipItemClass.equipIndex ~= nil then
            self.equipIndex = self.equipItemClass.equipIndex
        end
        self.chooseElementItemId = commoonData.chooseElementItemId
        self.bodyElementInfo = CS.CSScene.MainPlayerInfo.ElementInfo:GetElement(self.equipIndex)
    end
    return commoonData ~= nil
end

function UIElement_StoneListTemplate:RefreshNoReplaceStonePanel()
    self.mNoReplaceElement_GameObject:SetActive(true)
    if self.bodyElementInfo ~= nil then
        self.mNoReplaceElementInfo_GameObject:SetActive(true)
        self:RefreshElementStoneInfo(self.mNoReplaceElementNameInfo_UILabel, self.mNoReplaceElementAttackInfo_UILabel, self.bodyElementInfo.id, Utility.GetElementColor())
    end
end

function UIElement_StoneListTemplate:RefreshStoneList()
    --local bestElementItemInfo = self:GetBestElementItemInfo()
    if self.mStoneList_ScrollView ~= nil then
        self.mStoneList_ScrollView.gameObject:SetActive(true)
    end
    self.stoneListTemplate = {}
    self.mStoneList_UIGridContainer.MaxCount = self.ElementBagItemInfoList.Count

    ---元素石刷新
    if self.ElementBagItemInfoList.Count <= 0 then
        return
    end
    self:RemoveStoneListRefreshListUpdate()
    self.chooseIndex = self:GetChooseIndexByChooseElementItemId()
    self.refreshIndex = 0
    self:AddStoneListRefreshListUpdate(function()
        self:RefreshSingleElementStone({index = self.refreshIndex,chooseIndex = self.chooseIndex})
        self.refreshIndex = self.refreshIndex + 1
        if self.refreshIndex >= self.mStoneList_UIGridContainer.MaxCount then
            self:RemoveStoneListRefreshListUpdate()
            self:ScrollViewToChoosePosition(self.chooseIndex)
        end
    end)
end

---刷新单个元素石
function UIElement_StoneListTemplate:RefreshSingleElementStone(commonData)
    if commonData == nil or commonData.index == nil or commonData.chooseIndex == nil then
        return
    end
    local elementBagItemInfo = nil
    if commonData.index < self.ElementBagItemInfoList.Count then
        elementBagItemInfo = self.ElementBagItemInfoList[commonData.index]
    end
    if elementBagItemInfo == nil then
        return
    end
    local elementItemInfo = nil
    if commonData.index < self.ElementBagItemInfoList.Count then
        elementItemInfo = CS.Cfg_ElementTableManager.Instance:getElementStone(self.ElementBagItemInfoList[commonData.index].itemId)
    end
    local grid = self.mStoneList_UIGridContainer.controlList[commonData.index]
    local arrowType = LuaEnumArrowType.NONE
    local IsBetter = ternary(self.equipIndex == nil, false, CS.CSScene.MainPlayerInfo.ElementInfo:CompareEquipIndexElement(elementBagItemInfo, self.equipIndex))
    local isCanUse = CS.CSScene.MainPlayerInfo.ElementInfo:IsCanInlayByEquipIndex(self.equipIndex, elementBagItemInfo)
    if IsBetter == true then
        if isCanUse then
            arrowType = LuaEnumArrowType.GreenArrow
        else
            arrowType = LuaEnumArrowType.YellowArrow
        end
    end
    local commonData = {
        bagItemInfo = elementBagItemInfo,
        itemInfo = elementItemInfo,
        index = commonData.index,
        chooseIndex = commonData.chooseIndex,
        arrowType = arrowType,
        btnCallBack = function(grid, go, bagItemInfo, itemInfo)
            self:StoneGridOnClick(grid, go, bagItemInfo, itemInfo)
        end
    }
    local gridTemplate = templatemanager.GetNewTemplate(grid, luaComponentTemplates.UIElement_StoneListGrid)
    gridTemplate:RefreshUI(commonData)
    self.stoneListTemplate[grid] = gridTemplate
end
--endregion


--region 重置scrollView的位置
function UIElement_StoneListTemplate:ScrollViewResetPosition()
    if self.mStoneList_SpringPanel ~= nil and self.originPosition ~= nil then
        self.mStoneList_SpringPanel.target = self.originPosition
        self.mStoneList_SpringPanel.enabled = true
    end
end
--endregion

--region 自动下拉到对应选择高亮的元素石位置
function UIElement_StoneListTemplate:ScrollViewToChoosePosition(chooseIndex)
    local curLineNum = Utility.GetMaxIntPart((chooseIndex + 1) / self.singleLineNum)
    local downMoveLineNum = curLineNum - self.scrollviewShowLineNum
    if downMoveLineNum > 0 and self.mStoneList_SpringPanel ~= nil and self.originPosition ~= nil then
        self.mStoneList_SpringPanel.target = self.originPosition + CS.UnityEngine.Vector3.up * downMoveLineNum * self.singleLineHigh
        self.mStoneList_SpringPanel.enabled = true
    end
end
--endregion

---获取最好元素的iteminfo
function UIElement_StoneListTemplate:GetBestElementItemInfo()
    if self.equipItemClass.equipIndex == nil then
        return nil
    end
    local bestElementBagItemInfo = self.ElementInfo:AutoChooseElement(self.equipItemClass.equipIndex)
    if bestElementBagItemInfo == nil then
        return nil
    end
    local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(bestElementBagItemInfo.itemId)
    return itemInfo
end

---元素石格子点击事件
function UIElement_StoneListTemplate:StoneGridOnClick(grid, go, bagItemInfo, itemInfo, elementPanelTemplate)
    if self.stoneListTemplate == nil then
        return
    end

    if self.gridTemplate ~= nil then
        self.gridTemplate:SetChoose(false)
    end
    self.gridTemplate = grid
    self:RefreshStoneInfo()
end

---刷新元素石信息
function UIElement_StoneListTemplate:RefreshStoneInfo()
    self.mStoneInfo:SetActive(self.gridTemplate ~= nil)
    if self.gridTemplate ~= nil then
        if self.bodyElementInfo ~= nil then
            self.mArrow_GameObject:SetActive(true)
            self.mStoneInfoLeftElementInfo_GameObject:SetActive(true)
            self.mStoneInfoRightElementInfo_TweenPosition:PlayReverse()
            if self.bodyElementInfo ~= nil then
                self:RefreshElementStoneInfo(self.leftInfoElementType_UILabel, self.leftInfoAttackTypeName_UILabel, self.bodyElementInfo.id, Utility.GetElementColor())
            end
        else
            self.mArrow_GameObject:SetActive(false)
            self.mStoneInfoLeftElementInfo_GameObject:SetActive(false)
            self.mStoneInfoRightElementInfo_TweenPosition:PlayForward()
        end
        local isGoodColor = ternary(CS.CSScene.MainPlayerInfo.ElementInfo:IsCanInlayByEquipIndex(self.equipIndex, self.gridTemplate.bagItemInfo) and CS.CSScene.MainPlayerInfo.ElementInfo:CompareEquipIndexElement(self.gridTemplate.bagItemInfo, self.equipIndex), luaEnumColorType.Green
        , luaEnumColorType.White)
        self:RefreshElementStoneInfo(self.mStoneInfoElementType_UILabel, self.mStoneInfoAttackType_UILabel, self.gridTemplate.bagItemInfo.itemId, Utility.GetElementColor())
    end
end

---刷新元素石信息
function UIElement_StoneListTemplate:RefreshElementStoneInfo(nameLabel, attackLabel, itemId, color)
    local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId)
    local elementInfoIsFind, elementInfo = CS.Cfg_ElementTableManager.Instance:TryGetValue(itemId)
    if elementInfoIsFind and itemInfoIsFind then
        local stoneElementTypeName = CS.CSScene.MainPlayerInfo.ElementInfo:GetElementAttackName(elementInfo)
        local stoneElementAttackContent = CS.CSScene.MainPlayerInfo.ElementInfo:GetElementAttackAttributeContent(elementInfo)
        nameLabel.text = itemInfo.name .. CS.Utility_Lua.GetItemColorByQualityValue(itemInfo.quality)
        --.. " Lv" .. elementInfo.quality
        attackLabel.text = color .. stoneElementTypeName .. stoneElementAttackContent
        --self.mHint_GameObject:SetActive(not CS.CSScene.MainPlayerInfo.ElementInfo:IsCanInlayByEquipIndex(self.equipIndex,self.gridTemplate.bagItemInfo))
    end
end

---通过元素石itemid获取对应的选择下标
function UIElement_StoneListTemplate:GetChooseIndexByChooseElementItemId()
    local chooseIndex = 0
    if self.chooseElementItemId ~= nil and self.chooseElementItemId ~= 0 then
        local length = self.ElementBagItemInfoList.Count - 1
        for k = 0, length do
            local bagItemInfo = self.ElementBagItemInfoList[k]
            if bagItemInfo ~= nil and bagItemInfo.itemId == self.chooseElementItemId then
                chooseIndex = k
                break
            end
        end
    end
    return chooseIndex
end

---移除元素石列表刷新ListUpdate
function UIElement_StoneListTemplate:RemoveStoneListRefreshListUpdate()
    if self.delayRefreshElementStone ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.delayRefreshElementStone)
        self.delayRefreshElementStone = nil
    end
end

---添加元素石列表刷新ListUpdate
function UIElement_StoneListTemplate:AddStoneListRefreshListUpdate(action)
    if self.delayRefreshElementStone ~= nil then
        self:RemoveStoneListRefreshListUpdate()
    end
    self.delayRefreshElementStone = CS.CSListUpdateMgr.Add(20, nil, function()
        action()
    end, true)
end

function UIElement_StoneListTemplate:OnDestroy()
    self:RemoveStoneListRefreshListUpdate()
end

return UIElement_StoneListTemplate