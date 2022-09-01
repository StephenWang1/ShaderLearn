local UIArbitratorPanelTemplate = {}
--region 基础数据
---单页显示物品最大数量
UIArbitratorPanelTemplate.singlePageItemCount = 5
---所有物品列表
UIArbitratorPanelTemplate.DropItemTable = {}
---视野内的物品（页数-->格子模板列表）
UIArbitratorPanelTemplate.InViewItems = {}
--endregion
--region 组件
---物品列表
function UIArbitratorPanelTemplate:GetItemList()
    if self.ItemList == nil or CS.StaticUtility.IsNull(self.ItemList) then
        self.ItemList = self:Get("ItemList","GameObject")
    end
    return self.ItemList
end

---没有物品提示
function UIArbitratorPanelTemplate:GetNoItem_GameObject()
    if self.NoItem_GameObject == nil or CS.StaticUtility.IsNull(self.NoItem_GameObject) then
        self.NoItem_GameObject = self:Get("noitem","GameObject")
    end
    return self.NoItem_GameObject
end

---物品循环组件
function UIArbitratorPanelTemplate:GetUIGrid_UIPageRecyclingContainerForGameObject()
    if self.UIGrid_UIPageRecyclingContainerForGameObject == nil or CS.StaticUtility.IsNull(self.UIGrid_UIPageRecyclingContainerForGameObject) then
        self.UIGrid_UIPageRecyclingContainerForGameObject = self:Get("ItemList/Scroll View/UIGrid","UIPageRecyclingContainerForGameObject")
    end
    return self.UIGrid_UIPageRecyclingContainerForGameObject
end

---箭头指示
function UIArbitratorPanelTemplate:GetArrow_GameObject()
    if self.Arrow_GameObject == nil or CS.StaticUtility.IsNull(self.Arrow_GameObject) then
        self.Arrow_GameObject = self:Get("arrow","GameObject")
    end
    return self.Arrow_GameObject
end
--endregion

--region 刷新
--region UI刷新
---显示面板
function UIArbitratorPanelTemplate:ShowPanel()
    if self.go ~= nil and not CS.StaticUtility.IsNull(self.go) then
        self.go:SetActive(true)
    end
    self:StartCortinueToRefresh()
    self:RefreshNoItem()
    self:RefreshArrow()
end

---隐藏面板
function UIArbitratorPanelTemplate:HidePanel()
    if self.go ~= nil and not CS.StaticUtility.IsNull(self.go) then
        self.go:SetActive(false)
    end
    self:StopCortinueToRefresh()
    self:RefreshNoItem()
end

---刷新面板
function UIArbitratorPanelTemplate:RefreshPanel()
    self.DropItemTable = {}
    self.InViewItems = {}
end

---刷新无物品提示面板
function UIArbitratorPanelTemplate:RefreshNoItem()
    if self:GetNoItem_GameObject() ~= nil and not CS.StaticUtility.IsNull(self:GetNoItem_GameObject()) then
        self:GetNoItem_GameObject():SetActive(self.DropItemTable ~= nil and #self.DropItemTable == 0)
    end
end

---刷新箭头
function UIArbitratorPanelTemplate:RefreshArrow()
    if self:GetArrow_GameObject() ~= nil and not CS.StaticUtility.IsNull(self:GetArrow_GameObject()) then
        self:GetArrow_GameObject():SetActive(self.curPage ~= nil and self.curPage + 1 < self.maxPage)
    end
end
--endregion

--region 循环页面刷新
---初始化物品列表
function UIArbitratorPanelTemplate:InitItemList(itemListCommonData)
    self.maxPage = Utility.GetMaxIntPart(#self.DropItemTable / self.singlePageItemCount)
    self.gridTemplate = itemListCommonData.gridTemplate
    self.curPage = self:GetCurIndex()
    --print(self.curPage)
    if self:GetUIGrid_UIPageRecyclingContainerForGameObject() ~= nil and not CS.StaticUtility.IsNull(self:GetUIGrid_UIPageRecyclingContainerForGameObject()) then
        self:GetUIGrid_UIPageRecyclingContainerForGameObject():Initialize(self.maxPage,
                function(obj, page)self:OnPageEnterViewRange(obj, page) end,
                function(obj,page)self:OnPageExitViewRange(obj, page) end,
                function(page)self:OnCenterPageIndexChanged(page) end,self.curPage - 1)
    end
end

---当前页进入视野
function UIArbitratorPanelTemplate:OnPageEnterViewRange(obj, page)
    if obj ~= nil then
        local items = {}
        local curTable = self:GetDropItemTableByPage(page)
        local mUIGridContainer = self:GetCurComp(obj.transform,"UIGridItem","UIGridContainer")
        if mUIGridContainer ~= nil then
            mUIGridContainer.MaxCount = #curTable
            for k = 0,mUIGridContainer.MaxCount - 1 do
                local grid_go = mUIGridContainer.controlList[k]
                local info = curTable[k + 1]
                if grid_go ~= nil and info ~= nil then
                    local template = templatemanager.GetNewTemplate(grid_go,self.gridTemplate)
                    template:RefreshUI(info)
                    table.insert(items,template)
                end
            end
        end
        self.InViewItems[page + 1] = items
    end
end

function UIArbitratorPanelTemplate:OnPageExitViewRange(obj,page)
    if self.InViewItems ~= nil and self.InViewItems[page + 1] ~= nil then
        self.InViewItems[page + 1] = {}
    end
end

---中心页变化
function UIArbitratorPanelTemplate:OnCenterPageIndexChanged(page)
    self.curPage = page
    self:RefreshArrow()
end
--endregion
--endregion

--region 获取数据
---通过类型表获取掉落物品列表
function UIArbitratorPanelTemplate:GetDropItemListByTypeTable(typeTable)
    local index = 0
    for k,v in pairs(typeTable)do
        local dropItemList = CS.CSScene.MainPlayerInfo.DropInfo:GetItemListByDropType(v)
        local length = dropItemList.Count - 1
        for k = 0,length do
            index = index + 1
            local dropItem = {curIndex = index,type = v,curDropItem = dropItemList[k]}
            table.insert(self.DropItemTable,index,dropItem)
        end
    end
    return self.DropItemTable
end

---通过页数获取当前页显示列表
function UIArbitratorPanelTemplate:GetDropItemTableByPage(page)
    local dropItemTable = {}
    if self.DropItemTable ~= nil then
        local minIndex = page * self.singlePageItemCount + 1
        local maxIndex = (page + 1) * self.singlePageItemCount
        for k = minIndex,maxIndex do
            table.insert(dropItemTable,self.DropItemTable[k])
        end
    end
    return dropItemTable
end

---获取当前显示页(主要处理当前页没有数据，则刷新上一页数据)
function UIArbitratorPanelTemplate:GetCurIndex()
    if self.curPage == nil or CS.StaticUtility.IsNull(self:GetUIGrid_UIPageRecyclingContainerForGameObject()) == true then
        return 1
    end
    self.curPage = self:GetUIGrid_UIPageRecyclingContainerForGameObject().CenterPageIndex
    local curPage = self.curPage - 1
    local curDropItemsTable = self:GetDropItemTableByPage(curPage)
    if #curDropItemsTable > 0  then
        return self.curPage
    else
        if self.curPage > 0 then
            return self.curPage - 1
        else
            return self.curPage
        end
    end
end
--endregion

--region 协程刷新数据
---开启协程
function UIArbitratorPanelTemplate:StartCortinueToRefresh()
    if self.RefreshCortinue == nil then
        self.RefreshCortinue = StartCoroutine(function() self:RefreshTime() end)
    end
end

---关闭协程
function UIArbitratorPanelTemplate:StopCortinueToRefresh()
    if self.RefreshCortinue ~= nil then
        StopCoroutine(self.RefreshCortinue)
        self.RefreshCortinue = nil
    end
end
--endregion

--region 刷新时间
function UIArbitratorPanelTemplate:RefreshTime()
    while(true)do
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(0.5))
        if self.InViewItems ~= nil then
            for page,table in pairs(self.InViewItems) do
                if table ~= nil then
                    for k,grid in pairs(table) do
                        grid:RefreshTime()
                    end
                end
            end
        end
    end
end
--endregion

function UIArbitratorPanelTemplate:OnDestroy()
    self:StopCortinueToRefresh()
end
return UIArbitratorPanelTemplate