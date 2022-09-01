---@class UIAppearancePanelPagesCtrlTemplate:TemplateBase
local UIAppearancePanelPagesCtrlTemplate = {}

---外观物品GameObject
---@return UnityEngine.GameObject
function UIAppearancePanelPagesCtrlTemplate:GetAppearanceItemGO()
    if self.mAppearanceItemGO == nil then
        self.mAppearanceItemGO = self:Get("Item", "GameObject")
    end
    return self.mAppearanceItemGO
end

---称号物品GameObject
---@return UnityEngine.GameObject
function UIAppearancePanelPagesCtrlTemplate:GetTitleGO()
    if self.mTitleGO == nil then
        self.mTitleGO = self:Get("Title", "GameObject")
    end
    return self.mTitleGO
end

---页格子GridContainer
---@return UIGridContainer
function UIAppearancePanelPagesCtrlTemplate:GetAppearancePageGridContainer()
    if self.mAppearancePageGridContainer == nil then
        self.mAppearancePageGridContainer = self:Get("Item/ScrollView/Pages", "UIGridContainer")
    end
    return self.mAppearancePageGridContainer
end

---称号GridContainer
---@return UIGridContainer
function UIAppearancePanelPagesCtrlTemplate:GetTitleGridContainer()
    if self.mTitleGridContainer == nil then
        self.mTitleGridContainer = self:Get("Title/ScrollView/Grid", "UIGridContainer")
    end
    return self.mTitleGridContainer
end

---获取UIScrollView
---@return UIScrollView
function UIAppearancePanelPagesCtrlTemplate:GetScrollView()
    if self.mScrollView == nil then
        self.mScrollView = self:Get("Item/ScrollView", "UIScrollView")
    end
    return self.mScrollView
end

---获取UIScrollView的UIPanel组件
---@return UIPanel
function UIAppearancePanelPagesCtrlTemplate:GetScrollViewUIPanel()
    if self.mScrollViewUIPanel == nil then
        self.mScrollViewUIPanel = self:Get("Item/ScrollView", "UIPanel")
    end
    return self.mScrollViewUIPanel
end

---将子物体放置在中心
---@return UICenterOnChild
function UIAppearancePanelPagesCtrlTemplate:GetCenterOnChild()
    if self.mPageCenterOnChild == nil then
        self.mPageCenterOnChild = self:Get("Item/ScrollView/Pages", "UICenterOnChild")
    end
    return self.mPageCenterOnChild
end

function UIAppearancePanelPagesCtrlTemplate:Init()
    --每一页的宽度
    self.mPageWidth = 400
    self.mScrollViewTransXInit = self:GetScrollViewUIPanel().transform.localPosition.x
    self.mScrollViewOffsetInit = self:GetScrollViewUIPanel().clipOffset.x
    self.mScrollViewCenterInit = self:GetScrollViewUIPanel().baseClipRegion.x
end

---设置格子点击事件
---@param gridClickCallback function
function UIAppearancePanelPagesCtrlTemplate:SetGridClickCallback(gridClickCallback)
    self.mGridClickCallback = gridClickCallback
end

---设置称号点击事件
---@param titleClickCallback function
function UIAppearancePanelPagesCtrlTemplate:SetTitleClickCallback(titleClickCallback)
    self.mTitleClickCallback = titleClickCallback
end

---刷新
---@param infoList System.Collections.Generic.IList1T
---@param bookMarkIndex number
---@param selectedInfo bagV2.BagItemInfo|titleV2.TitleInfo
---@param isTitle boolean
function UIAppearancePanelPagesCtrlTemplate:Refresh(infoList, bookMarkIndex, selectedInfo, isTitle)
    if isTitle == false then
        if CS.StaticUtility.IsNull(self:GetAppearanceItemGO()) == false then
            self:GetAppearanceItemGO():SetActive(true)
        end
        if CS.StaticUtility.IsNull(self:GetTitleGO()) == false then
            self:GetTitleGO():SetActive(false)
        end
        self:RefreshWithAppearance(infoList, bookMarkIndex, selectedInfo)
    else
        if CS.StaticUtility.IsNull(self:GetAppearanceItemGO()) == false then
            self:GetAppearanceItemGO():SetActive(false)
        end
        if CS.StaticUtility.IsNull(self:GetTitleGO()) == false then
            self:GetTitleGO():SetActive(true)
        end
        self:RefreshWithTitle(infoList, bookMarkIndex, selectedInfo)
    end
end

---刷新外观
---@private
function UIAppearancePanelPagesCtrlTemplate:RefreshWithAppearance(infoList, bookMarkIndex, selectedInfo)
    --获取符合筛选条件的物品数量
    local maxBagItemInfoListCount = 0
    if infoList then
        maxBagItemInfoListCount = infoList.Count
        local numTemp = 0
        for i = 0, maxBagItemInfoListCount - 1 do
            if self:IsAppearanceSubType(infoList[i], bookMarkIndex) then
                numTemp = numTemp + 1
            end
        end
        maxBagItemInfoListCount = numTemp
    end
    --获取并设置总页数
    local pageCount = 0
    if infoList ~= nil then
        pageCount = math.ceil(maxBagItemInfoListCount / uiStaticParameter.UIAppearancePanel_PageItemCount)
    end
    if pageCount == 0 then
        pageCount = 1
    end
    local gridIndex = 0
    self:GetAppearancePageGridContainer().MaxCount = pageCount
    local currentPage = -1
    --逐页逐格子刷新
    for i = 0, pageCount - 1 do
        local pageGridsGO = self:GetAppearancePageGridContainer().controlList[i]
        ---@type UIGridContainer
        local pageGrids = CS.Utility_Lua.GetComponent(pageGridsGO.transform, "UIGridContainer")
        if pageGrids then
            pageGrids.MaxCount = uiStaticParameter.UIAppearancePanel_PageItemCount
            for j = 0, uiStaticParameter.UIAppearancePanel_PageItemCount - 1 do
                local gridGO = pageGrids.controlList[j]
                local gridTemplate = self:GetGridTemplate(gridGO)
                if gridTemplate then
                    local info
                    if infoList and gridIndex < infoList.Count then
                        info = infoList[gridIndex]
                    end
                    if info then
                        if self:IsAppearanceSubType(info, bookMarkIndex) then
                            gridTemplate:Refresh(info, info == selectedInfo)
                            if info == selectedInfo then
                                currentPage = i
                            end
                        else
                            gridTemplate:Refresh(nil, false)
                        end
                    else
                        gridTemplate:Refresh(nil, false)
                    end
                    gridIndex = gridIndex + 1
                end
            end
        end
    end
    --切换到选中的物品所在的页
    if currentPage ~= -1 then
        self:SwitchToPage(currentPage)
    else
        self:SwitchToPage(0)
    end
end

---刷新称号
---@private
function UIAppearancePanelPagesCtrlTemplate:RefreshWithTitle(infoList, bookMarkIndex, selectedInfo)
    --获取符合筛选条件的物品数量
    local titleInfoListCount = 0
    if infoList then
        titleInfoListCount = infoList.Count
    end
    self:GetTitleGridContainer().MaxCount = titleInfoListCount
    if titleInfoListCount > 0 then
        for i = 0, titleInfoListCount - 1 do
            local go = self:GetTitleGridContainer().controlList[i]
            local titleTemplate = self:GetTitleTemplate(go)
            if titleTemplate ~= nil then
                local infoTemp = infoList[i]
                titleTemplate:Refresh(infoTemp, selectedInfo == infoTemp)
            end
        end
    end
end

function UIAppearancePanelPagesCtrlTemplate:Destroy()
    local titleInfoListCount = self:GetTitleGridContainer().MaxCount
    if titleInfoListCount > 0 then
        for i = 0, titleInfoListCount - 1 do
            local go = self:GetTitleGridContainer().controlList[i]
            local titleTemplate = self:GetTitleTemplate(go)
            if titleTemplate ~= nil then
                titleTemplate:Destroy()
            end
        end
    end
end

---切换到页
---@param pageIndex number 页索引,从0开始计数
function UIAppearancePanelPagesCtrlTemplate:SwitchToPage(pageIndex)
    self:SetScrollViewRelativeOffset(pageIndex * self.mPageWidth)
    self:GetCenterOnChild():Recenter()
end

---设置ScrollView组件的相对Offset(相对于初始状态)
function UIAppearancePanelPagesCtrlTemplate:SetScrollViewRelativeOffset(offset)
    local clipOffset = self:GetScrollViewUIPanel().clipOffset
    clipOffset.x = self.mScrollViewOffsetInit + offset
    self:GetScrollViewUIPanel().clipOffset = clipOffset
    local transLocalPos = self:GetScrollViewUIPanel().transform.localPosition
    transLocalPos.x = self.mScrollViewTransXInit - offset
    self:GetScrollViewUIPanel().transform.localPosition = transLocalPos
end

---外观物品是否是外观子类型
---@param bagItemInfo bagV2.BagItemInfo 外观物品
---@param subType number 子类型
function UIAppearancePanelPagesCtrlTemplate:IsAppearanceSubType(bagItemInfo, subType)
    if bagItemInfo == nil then
        return false
    end
    local itemTbl, isItemTblExist, appearanceTbl, isAppearanceTblExist
    isItemTblExist, itemTbl = CS.Cfg_ItemsTableManager.Instance:TryGetValue(bagItemInfo.itemId)
    if isItemTblExist and itemTbl.appearanceId ~= 0 then
        isAppearanceTblExist, appearanceTbl = CS.Cfg_AppearanceTableManager.Instance:TryGetValue(itemTbl.appearanceId)
        if isAppearanceTblExist and subType == appearanceTbl.type then
            return true
        end
    end
    return false
end

---获取称号模板对象
---@return UIAppearancePanelTitleTemplate
function UIAppearancePanelPagesCtrlTemplate:GetTitleTemplate(go)
    if go and CS.StaticUtility.IsNull(go) == false then
        if self.mTitleTemplates == nil then
            self.mTitleTemplates = {}
        end
        if Utility.IsContainsKey(self.mTitleTemplates, go) == false then
            local template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIAppearancePanelTitleTemplate)
            self.mTitleTemplates[go] = template
            template.rootCtrl = self
            CS.UIEventListener.Get(go).LuaEventTable = template
            CS.UIEventListener.Get(go).OnClickLuaDelegate = self.OnTitleClicked
            return template
        else
            return self.mTitleTemplates[go]
        end
    end
    return nil
end

---称号点击事件
---@param template UIAppearancePanelTitleTemplate
---@param go UnityEngine.GameObject
function UIAppearancePanelPagesCtrlTemplate.OnTitleClicked(template, go)
    if template then
        local pageCtrlTemplate = template.rootCtrl
        if pageCtrlTemplate and pageCtrlTemplate.mTitleClickCallback then
            pageCtrlTemplate.mTitleClickCallback(template)
        end
    end
end

---获取格子模板对象
---@return UIAppearancePanelGridTemplate
function UIAppearancePanelPagesCtrlTemplate:GetGridTemplate(go)
    if go and CS.StaticUtility.IsNull(go) == false then
        if self.mGridsToTemplate == nil then
            self.mGridsToTemplate = {}
        end
        if Utility.IsContainsKey(self.mGridsToTemplate, go) == false then
            local template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIAppearancePanelGridTemplate)
            self.mGridsToTemplate[go] = template
            template.rootCtrl = self
            CS.UIEventListener.Get(go).LuaEventTable = template
            CS.UIEventListener.Get(go).OnClickLuaDelegate = self.OnGridClicked
            return template
        else
            return self.mGridsToTemplate[go]
        end
    end
    return nil
end

---@param template UIAppearancePanelGridTemplate
---@param go UnityEngine.GameObject
function UIAppearancePanelPagesCtrlTemplate.OnGridClicked(template, go)
    if template then
        local pageCtrlTemplate = template.rootCtrl
        if pageCtrlTemplate and pageCtrlTemplate.mGridClickCallback then
            pageCtrlTemplate.mGridClickCallback(template)
        end
    end
end

return UIAppearancePanelPagesCtrlTemplate