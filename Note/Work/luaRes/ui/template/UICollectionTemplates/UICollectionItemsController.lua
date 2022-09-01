---收藏物品列表控制器
---@class UICollectionItemsController:TemplateBase
local UICollectionItemsController = {}

--region 组件
---@return UnityEngine.GameObject
function UICollectionItemsController:GetCollectionTemplateGo()
    if self.mCollectionTemplateGo == nil then
        self.mCollectionTemplateGo = self:Get("item/collectionTemplate", "GameObject")
    end
    return self.mCollectionTemplateGo
end

---@return UIPageRecyclingContainer1T
function UICollectionItemsController:GetPageRecyclingContainer()
    if self.mPageRecyclingContainer == nil then
        self.mPageRecyclingContainer = self:Get("item/Scroll View/UIGrid", "UIPageRecyclingContainerForGameObject")
    end
    return self.mPageRecyclingContainer
end

---@return UIGridContainer
function UICollectionItemsController:GetPageIndexGridContainer()
    if self.mPageIndexGridContainer == nil then
        self.mPageIndexGridContainer = self:Get("grid", "UIGridContainer")
    end
    return self.mPageIndexGridContainer
end

---@return UIScrollView
function UICollectionItemsController:GetScrollView()
    if self.mScrollView == nil then
        self.mScrollView = self:Get("item/Scroll View", "UIScrollView")
    end
    return self.mScrollView
end

---获取物品模板预设
---@return UnityEngine.GameObject
function UICollectionItemsController:GetItemTemplatePrefabGo()
    if self.mItemTemplateParentGo == nil then
        self.mItemTemplateParentGo = self:Get("item/itemPrefabParent", "GameObject")
    end
    return self.mItemTemplateParentGo
end
--endregion

--region 常量
---获取物品格子宽度
---@return number
function UICollectionItemsController:GetItemGridWidth()
    return 82
end

---获取物品格子高度
---@return number
function UICollectionItemsController:GetItemGridHeight()
    return 82
end
--endregion

--region 属性
---获取归属界面
---@return UICollectionPanel
function UICollectionItemsController:GetOwnerPanel()
    return self.mOwnerPanel
end

---中心页模板
---@return UICollectionPageTemplate
function UICollectionItemsController:GetCenterPageTemplate()
    local centerPageIndex = self:GetCenterPageIndex()
    local go = self:GetPagesInViewRange()[centerPageIndex]
    return self:GetPageTemplate(go)
end

---藏品交互层
---@return UIBagTypeContainerInteraction
function UICollectionItemsController:GetCollectionInteraction()
    if self.mCollectionInteraction == nil then
        self.mCollectionInteraction = templatemanager.GetNewTemplate(self.go, luaComponentTemplates.UICollectionTypeContainerInteraction,
                self:GetOwnerPanel(),
                self:GetDraggableCollectionItem(),
                self:GetScrollView()
        )
    end
    return self.mCollectionInteraction
end

---可拖拽的藏品物品
---@return UICollectionItemDraggableItem
function UICollectionItemsController:GetDraggableCollectionItem()
    if self.mDraggableCollectionItem == nil then
        local go = self:Get("item/draggableCollectionItem", "GameObject")
        self.mDraggableCollectionItem = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICollectionItemDraggableItem, self:GetOwnerPanel())
    end
    return self.mDraggableCollectionItem
end

---获取归属的藏品信息
---@return LuaCollectionInfo
function UICollectionItemsController:GetCollectionInfo()
    return self.mCollectionInfo
end

---获取页数
---@return number
function UICollectionItemsController:GetPageCount()
    if self.mPageCount == nil then
        return 0
    end
    return self.mPageCount
end

---获取中心页索引,范围:1 ~ pageCount
---@return number
function UICollectionItemsController:GetCenterPageIndex()
    if self.mCenterIndex == nil then
        return 0
    end
    return self.mCenterIndex
end

---获取视野范围内的页的索引和其对应的GameObject(索引从1开始)
---@public
---@return table<number,UnityEngine.GameObject>
function UICollectionItemsController:GetPagesInViewRange()
    if self.mPagesInViewRange == nil then
        self.mPagesInViewRange = {}
    end
    return self.mPagesInViewRange
end

---获取当前拖拽的藏品物品的lid
---@return number
function UICollectionItemsController:GetCurrentDraggedCollectionItemLid()
    return self.mCurrentDraggedCollectionItemLid
end

---获取当前拖拽的物品所遮挡的坐标列表
---@return table<number, CollectionCoord>
function UICollectionItemsController:GetCurrentDraggedCoverCoordList()
    if self.mCurrentDraggedCoverCoordList == nil then
        self.mCurrentDraggedCoverCoordList = {}
    end
    return self.mCurrentDraggedCoverCoordList
end

---获取当前拖拽的物品所遮挡的核心坐标列表
---@return table<number, CollectionCoord>
function UICollectionItemsController:GetCurrentDraggedCoverCoreCoordList()
    if self.mCurrentDraggedCoverCoreCoordList == nil then
        self.mCurrentDraggedCoverCoreCoordList = {}
    end
    return self.mCurrentDraggedCoverCoreCoordList
end
--endregion

--region 初始化
---@param ownerPanel UICollectionPanel
---@param collectionInfo LuaCollectionInfo
function UICollectionItemsController:Init(ownerPanel, collectionInfo)
    self.mOwnerPanel = ownerPanel
    self.mCollectionInfo = collectionInfo
    if self.mCollectionInfo == nil then
        self.mCollectionInfo = gameMgr:GetPlayerDataMgr():GetCollectionInfo()
    end
    self:GetItemTemplatePrefabGo():SetActive(false)
    self:GetCollectionTemplateGo():SetActive(false)
end
--endregion

--region 刷新UI
---刷新UI
---@public
function UICollectionItemsController:RefreshUI()
    local collectionInfo = gameMgr:GetPlayerDataMgr():GetCollectionInfo()
    local pageCount = self:CalculatePageCount(collectionInfo)
    if pageCount <= 0 then
        pageCount = 1
    end
    local unlockedGridCount = collectionInfo:GetUnlockedGridCount()
    local previousCenterPageIndex = self:GetCenterPageIndex()
    if self.mUnlockedGridCountCache ~= unlockedGridCount or self.mPageCount ~= pageCount then
        ---如果页数或已解锁的格子数量更改了,那么重新初始化页循环组件
        self.mUnlockedGridCountCache = unlockedGridCount
        self.mPageCount = pageCount
        self:GetPageRecyclingContainer():Initialize(pageCount, function(go, index)
            self:OnPageEnterViewRange(go, index)
        end, function(go, index)
            self:OnPageExitViewRange(go, index)
        end, function(centerIndex)
            self:OnCenterPageIndexChanged(centerIndex)
        end)
    else
        ---如果页数没有变化,则只刷新视野内的页
        self:RefreshAllPages()
    end
    ---刷新下方的页数标识
    self:RefreshPageBookMarks()
    ---检查,如果之前的当前中心页超过了当前的最大页数,那么应当主动切换到最大页以保证不显示正确
    if previousCenterPageIndex ~= nil and previousCenterPageIndex >= self:GetPageCount() then
        self:GetPageRecyclingContainer():SwitchToPageWithAnimation(self:GetPageCount() - 1, 10)
    end
end

---@param collectionInfo LuaCollectionInfo
function UICollectionItemsController:CalculatePageCount(collectionInfo)
    ---策划语录:
    ---第65个格子开始为锁住状态，每升1级解锁的格子数按照藏品阁解锁表内填写的格数；解锁完第2页，第3、4、5页逐页解锁，直到表内格数解锁完
    ---其他玩家只展示有藏品摆放的页数
    local pageCount = math.ceil(collectionInfo:GetSummaryGridCount() / collectionInfo:GetCollectionGridCountPerPage())
    if pageCount <= 1 then
        pageCount = 2
    end
    return pageCount
end
--endregion

--region 翻页
---切页
---@param pageIndex number 目标页
---@param withAnimation boolean|nil 是否使用动画过渡过去
function UICollectionItemsController:SwitchToPage(pageIndex, withAnimation)
    if self.mCenterIndex == pageIndex then
        return
    end
    if withAnimation then
        self:GetPageRecyclingContainer():SwitchToPageWithAnimation(self.mCenterIndex, 10)
    else
        self:GetPageRecyclingContainer():SwitchToPageWithoutAnimation(self.mCenterIndex)
    end
end

---刷新页签
---@public
function UICollectionItemsController:RefreshPageBookMarks()
    local pageCount = self:GetPageCount()
    self:GetPageIndexGridContainer().MaxCount = pageCount
    for i = 1, pageCount do
        local go = self:GetPageIndexGridContainer().controlList[i - 1]
        ---@type UISprite
        local sprite = self:GetCurComp(go, "", "UISprite")
        if i == self.mCenterIndex then
            sprite.spriteName = "scrlight"
        else
            sprite.spriteName = "scrbg"
        end
        sprite:MakePixelPerfect()
    end
end

---页进入视野范围事件
---@private
---@param go UnityEngine.GameObject
---@param index number
function UICollectionItemsController:OnPageEnterViewRange(go, index)
    local template = self:GetPageTemplate(go)
    if template then
        self:RefreshPageTemplateWithPageIndex(index + 1, template)
    end
    self:GetPagesInViewRange()[index + 1] = go
end

---页退出视野范围事件
---@private
---@param go UnityEngine.GameObject
---@param index number
function UICollectionItemsController:OnPageExitViewRange(go, index)
    self:GetPagesInViewRange()[index + 1] = nil
end

---中心页索引变化事件
---@private
---@param centerIndex number
function UICollectionItemsController:OnCenterPageIndexChanged(centerIndex)
    self.mCenterIndex = centerIndex + 1
    self:RefreshPageBookMarks()
end
--endregion

--region 帧刷新
---每帧刷新
---@param time number 当前帧时间
function UICollectionItemsController:OnUpdate(time)
    self:GetCollectionInteraction():OnUpdate(time)
end
--endregion

--region 页刷新
---使用页索引刷新页模板
---@param pageIndex number
---@param pageTemplate UICollectionPageTemplate
function UICollectionItemsController:RefreshPageTemplateWithPageIndex(pageIndex, pageTemplate)
    if pageTemplate == nil or pageIndex == nil then
        return
    end
    pageTemplate:RefreshPage(self:GetCollectionInfo(), pageIndex)
end

---获取页的模板
---@param pageGo UnityEngine.GameObject
---@return UICollectionPageTemplate
function UICollectionItemsController:GetPageTemplate(pageGo)
    if self.mPageGoToTemplate == nil then
        ---@type table<UnityEngine.GameObject, UICollectionPageTemplate>
        self.mPageGoToTemplate = {}
    end
    local template = self.mPageGoToTemplate[pageGo]
    if template == nil then
        template = templatemanager.GetNewTemplate(pageGo, luaComponentTemplates.UICollectionPageTemplate, self)
        self.mPageGoToTemplate[pageGo] = template
    end
    return template
end
--endregion

--region 格子刷新
---刷新单个格子
---@param collectionItemGrid UICollectionItemGrid 格子
---@param collectionItem LuaCollectionItem|nil 格子所归属的藏品信息
function UICollectionItemsController:RefreshSingleGrid(collectionItemGrid, collectionItem)
    ---如果格子已解锁，且坐标处于被拖拽的格子内,则显示一个特效
    local isCoreDraggedItem = false
    for i = 1, #self:GetCurrentDraggedCoverCoreCoordList() do
        if self:GetCurrentDraggedCoverCoreCoordList()[i].x == collectionItemGrid.mCoordX
                and self:GetCurrentDraggedCoverCoreCoordList()[i].y == collectionItemGrid.mCoordY then
            isCoreDraggedItem = true
            break
        end
    end
    if isCoreDraggedItem and collectionItemGrid.mIsLocked ~= true then
        if self:IsCurrentDragEffective() then
            ---如果可以拖拽到这个位置,则都显示绿色
            collectionItemGrid:SetCompActive(collectionItemGrid.Components.GreenMask, true)
        else
            ---如果不能拖拽到这个位置,则不可拖拽的格子(包括非被拖拽物品的非空格子)显示红色,其他部分显示绿色
            if collectionItem ~= nil and self:GetCurrentDraggedCollectionItemLid() ~= collectionItem:GetCollectionLid() then
                collectionItemGrid:SetCompActive(collectionItemGrid.Components.RedMask, true)
            else
                collectionItemGrid:SetCompActive(collectionItemGrid.Components.GreenMask, true)
            end
        end
    end
end
--endregion

--region 刷新全部页
---刷新所有页
---@public
function UICollectionItemsController:RefreshAllPages()
    local pagesInViewRange = self:GetPagesInViewRange()
    if pagesInViewRange then
        for index, go in pairs(pagesInViewRange) do
            local pageTemplate = self:GetPageTemplate(go)
            if pageTemplate then
                self:RefreshPageTemplateWithPageIndex(index, pageTemplate)
            end
        end
    end
end
--endregion

--region 拖拽
---设置拖拽物的覆盖坐标
---@param coveredCoordList table<number, CollectionCoord>|nil
---@param coveredCoreCoordList table<number, CollectionCoord>|nil
function UICollectionItemsController:SetDraggingCoveredCoords(coveredCoordList, coveredCoreCoordList)
    for i = #self:GetCurrentDraggedCoverCoordList(), 1, -1 do
        self:GetCurrentDraggedCoverCoordList()[i] = nil
    end
    if coveredCoordList then
        for i = 1, #coveredCoordList do
            table.insert(self:GetCurrentDraggedCoverCoordList(), coveredCoordList[i])
        end
    end
    for i = #self:GetCurrentDraggedCoverCoreCoordList(), 1, -1 do
        self:GetCurrentDraggedCoverCoreCoordList()[i] = nil
    end
    if coveredCoreCoordList then
        for i = 1, #coveredCoreCoordList do
            table.insert(self:GetCurrentDraggedCoverCoreCoordList(), coveredCoreCoordList[i])
        end
    end
end

---返回拖拽是否有效的状态
---@return boolean|nil 是否可以设置到坐标
function UICollectionItemsController:IsCurrentDragEffective()
    return self.mDragEffective
end

---设置拖拽是否有效的状态
---@param state boolean|nil 是否可以设置到坐标
function UICollectionItemsController:SetCanDragEffectiveState(state)
    self.mDragEffective = state
end

---尝试将被拖拽的物品放置在当前页的坐标上
---@param draggedBagItem bagV2.BagItemInfo
---@param coveredCoreCoordList table<number, CollectionCoord>
function UICollectionItemsController:TrySetDraggedBagItemInCoord(draggedBagItem, coveredCoreCoordList)
    if draggedBagItem == nil or coveredCoreCoordList == nil or #coveredCoreCoordList == 0 then
        return
    end
    if self:GetCollectionInfo() == nil or self:GetCollectionInfo().mIsOwnedByMainPlayer ~= true then
        return
    end
    ---找到遮住的格子中的左上角坐标,优先行
    local xMin = 100000
    local yMin = 100000
    ---@type CollectionCoord
    local selectedOriginCoord = nil
    for i = 1, #coveredCoreCoordList do
        local coordTemp = coveredCoreCoordList[i]
        if coordTemp.x <= xMin and coordTemp.y <= yMin then
            xMin = coordTemp.x
            yMin = coordTemp.y
            selectedOriginCoord = coordTemp
        end
    end
    if selectedOriginCoord == nil then
        return
    end
    ---尝试向服务器请求上架/交换位置
    local pageIndex = self:GetCenterPageIndex()
    local bagItemInCarbinet = self:GetCollectionInfo():GetCollectionItemByCollectionID(draggedBagItem.itemId)
    if bagItemInCarbinet ~= nil and bagItemInCarbinet:GetCollectionLid() ~= draggedBagItem.lid
            and self:GetCollectionInfo():IsLeftBetterThanRight(bagItemInCarbinet:GetCollectionBagItem(), draggedBagItem) then
        ---如果从背包拖过来且藏品阁中有该物品且比当前物品更好,则二次弹窗确认
        local result, resultStr = self:GetCollectionInfo():TryReqPutOnCollectionItem(draggedBagItem, pageIndex, selectedOriginCoord.x, selectedOriginCoord.y, false)
        if result == false then
            CS.Utility.ShowRedTips(resultStr)
        else
            local wordTbl, tblExist
            tblExist, wordTbl = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(155)
            if tblExist and wordTbl then
                local x = selectedOriginCoord.x
                local y = selectedOriginCoord.y
                Utility.ShowSecondConfirmPanel({ PromptWordId = 155, ComfireAucion = function()
                    self:GetCollectionInfo():TryReqPutOnCollectionItem(draggedBagItem, pageIndex, x, y, true)
                end })
            else
                self:GetCollectionInfo():TryReqPutOnCollectionItem(draggedBagItem, pageIndex, selectedOriginCoord.x, selectedOriginCoord.y, true)
            end
        end
    else
        local result, resultStr = self:GetCollectionInfo():TryReqPutOnCollectionItem(draggedBagItem, pageIndex, selectedOriginCoord.x, selectedOriginCoord.y, true)
        if result == false and resultStr ~= nil then
            CS.Utility.ShowRedTips(resultStr)
        end
    end
end
--endregion

--region 藏品格子交互
---执行单击
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@param isLocked boolean 是否是被锁住的格子
function UICollectionItemsController:DoGridSingleClick(grid, mCollectionItem, isLocked)
    if mCollectionItem == nil or mCollectionItem:GetCollectionBagItem() == nil then
        return
    end
    uiStaticParameter.UIItemInfoManager:CreatePanel({
        bagItemInfo = mCollectionItem:GetCollectionBagItem(),
        showRight = true,
        showAssistPanel = true,
        career = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career),
        showMoreAssistData = true,
        showTabBtns = true,
        showBind = true,
        showAction = true })
end

---执行双击
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
function UICollectionItemsController:DoGridDoubleClick(grid, mCollectionItem)

end

---执行长按
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
function UICollectionItemsController:DoGridLongPress(grid, mCollectionItem)

end

---执行开始拖拽
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@param pos UnityEngine.Vector3
function UICollectionItemsController:DoGridStartDrag(grid, mCollectionItem, pos)
    if mCollectionItem then
        self.mCurrentDraggedCollectionItemLid = mCollectionItem:GetCollectionLid()
        self:RefreshUI()
    end
end

---执行正在被拖拽
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@param pos UnityEngine.Vector3
function UICollectionItemsController:DoGridBeingDragged(grid, mCollectionItem, pos)
    local pageTemplate = self:GetCenterPageTemplate()
    if pageTemplate then
        local widget = self:GetDraggableCollectionItem():GetIconSprite()
        local coveredGridList, coveredCoreGridList = pageTemplate:CalculateWidgetCoveredGrids(widget)
        self:SetDraggingCoveredCoords(coveredGridList, coveredCoreGridList)
        ---设置被拖拽对象的颜色
        local isAnyCenterCoveredGridExist = false
        if coveredCoreGridList ~= nil and #coveredCoreGridList > 0 then
            for i = 1, #coveredCoreGridList do
                local coordTemp = coveredCoreGridList[i]
                if coordTemp.x >= 0 and coordTemp.x < luaclass.LuaCollectionInfo.GetCollectionGridCountPerLine() and
                        coordTemp.y >= 0 and coordTemp.y < luaclass.LuaCollectionInfo.GetCollectionGridCountPerColumn() then
                    isAnyCenterCoveredGridExist = true
                end
            end
        end
        if isAnyCenterCoveredGridExist == false then
            self:GetDraggableCollectionItem():SetIconColor(CS.UnityEngine.Color.white)
            self:SetCanDragEffectiveState(nil)
        else
            ---找到遮住的格子中的左上角坐标,优先行
            local x = 100000
            local y = 100000
            for i = 1, #coveredCoreGridList do
                local coordTemp = coveredCoreGridList[i]
                if coordTemp.x <= x and coordTemp.y <= y then
                    x = coordTemp.x
                    y = coordTemp.y
                end
            end
            if x == 100000 or y == 100000 then
                return
            end
            local result = self:GetCollectionInfo():TryReqPutOnCollectionItem(mCollectionItem:GetCollectionBagItem(),
                    self:GetCenterPageIndex(), x, y, false)
            if result then
                ---如果可以设置到该位置,设置icon为白色
                self:GetDraggableCollectionItem():SetIconColor(CS.UnityEngine.Color.white)
                self:SetCanDragEffectiveState(true)
            else
                ---如果可以设置到该位置,设置icon为红色
                self:GetDraggableCollectionItem():SetIconColor(CS.UnityEngine.Color.red)
                self:SetCanDragEffectiveState(false)
            end
        end
        self:RefreshAllPages()
    end
end

---执行结束拖拽
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@param pos UnityEngine.Vector3
---@param isDestroyed boolean 是否因销毁导致的结束拖拽
function UICollectionItemsController:DoGridEndDrag(grid, mCollectionItem, pos, isDestroyed)
    self.mCurrentDraggedCollectionItemLid = nil
    if isDestroyed ~= true then
        local pageTemplate = self:GetCenterPageTemplate()
        if pageTemplate and mCollectionItem ~= nil then
            local widget = self:GetDraggableCollectionItem():GetIconSprite()
            local coveredGridList, coveredCoreGridList = pageTemplate:CalculateWidgetCoveredGrids(widget)
            local isAnyCenterCoveredGridExist = false
            if coveredCoreGridList ~= nil and #coveredCoreGridList > 0 then
                for i = 1, #coveredCoreGridList do
                    local coordTemp = coveredCoreGridList[i]
                    if coordTemp.x >= 0 and coordTemp.x < luaclass.LuaCollectionInfo.GetCollectionGridCountPerLine() and
                            coordTemp.y >= 0 and coordTemp.y < luaclass.LuaCollectionInfo.GetCollectionGridCountPerColumn() then
                        isAnyCenterCoveredGridExist = true
                    end
                end
            end
            if isAnyCenterCoveredGridExist then
                ---如果有任何一个核心格子被覆盖,那么尝试交换位置
                self:TrySetDraggedBagItemInCoord(mCollectionItem:GetCollectionBagItem(), coveredCoreGridList)
            else
                ---如果没有任何核心格子被覆盖,且被拖拽到了背包上,那么认为玩家希望下架该藏品
                ---@type UIBagPanel
                local bagPanel = uimanager:GetPanel("UIBagPanel")
                if bagPanel and bagPanel.go ~= nil and CS.StaticUtility.IsNull(bagPanel.go) == false and bagPanel.go.activeInHierarchy
                        and bagPanel:GetScrollView_UIPanel() ~= nil then
                    ---@type UnityEngine.Vector3
                    local blWorldPos = bagPanel:GetScrollView_UIPanel().worldCorners[0]
                    ---@type UnityEngine.Vector3
                    local trWorldPos = bagPanel:GetScrollView_UIPanel().worldCorners[2]
                    if pos.x > blWorldPos.x and pos.x < trWorldPos.x and pos.y > blWorldPos.y and pos.y < trWorldPos.y then
                        ---如果移到的了背包界面中,那么意味着将下架该藏品
                        self:GetCollectionInfo():ReqPutOffCollectionItem(mCollectionItem:GetCollectionLid())
                    end
                end
            end
        end
    end
    self:SetDraggingCoveredCoords()
    self:SetCanDragEffectiveState(nil)
    self:RefreshUI()
end
--endregion

--region 格子组件获取方法
---获取格子中的组件名对应的预设
---@return UnityEngine.GameObject
function UICollectionItemsController:FetchPrefabForGrid(compName)
    if self.mPrefabForGrid == nil then
        self.mPrefabForGrid = {}
    end
    local prefabGoTemp = self.mPrefabForGrid[compName]
    if self.mPrefabForGrid[compName] ~= nil then
        return prefabGoTemp
    end
    local prefabGo = self:GetItemTemplatePrefabGo()
    if CS.StaticUtility.IsNull(prefabGo) then
        return
    end
    prefabGoTemp = prefabGo.transform:Find(compName)
    local go
    if prefabGoTemp ~= nil then
        go = prefabGoTemp.gameObject
        self.mPrefabForGrid[compName] = go
    end
    return go
end
--endregion

return UICollectionItemsController