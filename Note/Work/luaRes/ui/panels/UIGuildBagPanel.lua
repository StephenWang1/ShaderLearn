---帮会仓库界面
---@class UIGuildBagPanel:UIBase
local UIGuildBagPanel = {}

--region 局部变量定义
-----页数对应刷新（避免重复刷新）
--UIGuildBagPanel.mPageToRefresh = {}
--
-----帮会仓库页数对应刷新（避免重复刷新）
--UIGuildBagPanel.mGuildBagPageToRefresh = {}

---帮会仓库最大格子数
UIGuildBagPanel.guildGridMaxIndex = nil

UIGuildBagPanel.mPageSprite = {
    [true] = "scrlight",
    [false] = "scrbg",
}


--endregion

--region 属性
---@return number 每页格子数
function UIGuildBagPanel:GetPerPageGridNum()
    return 30
end

---@return CSPlayerInfo 玩家信息
function UIGuildBagPanel:GetPlayerInfo()
    if self.playerInfo == nil then
        self.playerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.playerInfo
end

---@return CSServantInfoV2 灵兽信息
function UIGuildBagPanel:GetServantInfoV2()
    if self.mServantInfo == nil then
        if self:GetPlayerInfo() then
            self.mServantInfo = self:GetPlayerInfo().ServantInfoV2
        end
    end
    return self.mServantInfo
end

--region背包属性
---@return CSBagInfoV2 背包信息
function UIGuildBagPanel:GetBagInfo()
    if self.mBagInfo == nil then
        if self:GetPlayerInfo() then
            self.mBagInfo = self:GetPlayerInfo().BagInfo
        end
    end
    return self.mBagInfo
end

---@return number 背包最大格子数
function UIGuildBagPanel:GetBagMaxGridCount()
    return self:GetBagInfo().MaxGridCount
end

---@return number 背包最大页数
function UIGuildBagPanel:GetBagMaxPageCount()
    local pageCount = 0
    if self:GetPerPageGridNum() ~= 0 then
        pageCount = math.ceil(self:GetBagMaxGridCount() / self:GetPerPageGridNum())
    end
    if pageCount <= 0 then
        pageCount = 1
    end
    return pageCount
end

---@return table<number,bagV2.BagItemInfo> 获取背包物品列表
function UIGuildBagPanel:GetBagInfoList()
    local list = self:GetBagInfo():GetBagItemList()
    local showList = {}
    for i = 0, list.Count - 1 do
        ---@type bagV2.BagItemInfo
        local bagItemInfo = list[i]
        if bagItemInfo and bagItemInfo.ItemTABLE then
            if bagItemInfo.ItemTABLE.isDonate == 1 then
                table.insert(showList, bagItemInfo)
            end
        end
    end
    return showList
end

---@return UnityEngine.GameObject 背包复制用格子
function UIGuildBagPanel:GetBagPrefab()
    if self.mCopyGo == nil then
        self.mCopyGo = self:GetCurComp("WidgetRoot/view/itemTemplateComponents", "GameObject")
    end
    return self.mCopyGo
end

---交互
---@return UIGuildBagPanel_Interaction
function UIGuildBagPanel:GetGuildBagInteraction()
    if self.mInteraction == nil then
        self.mInteraction = templatemanager.GetNewTemplate(self.go, luaComponentTemplates.UIGuildBagPanel_Interaction, self, nil, nil)
    end
    return self.mInteraction
end

---获取背包格子模板组件
---@param name string 组件名字
---@return UnityEngine.GameObject 组件
function UIGuildBagPanel:FetchComponent(name)
    if self.NameToGo == nil then
        self.NameToGo = {}
    end
    local go = self.NameToGo[name]
    if CS.StaticUtility.IsNull(go) then
        go = self:GetComp(self:GetBagPrefab().transform, name, "GameObject")
    end
    return go
end
--endregion

--region 仓库属性
---@return CSUnionInfoV2 获取帮会信息
function UIGuildBagPanel:GetUnionInfoV2()
    if self.mUnionInfoV2 == nil then
        if self:GetPlayerInfo() then
            self.mUnionInfoV2 = self:GetPlayerInfo().UnionInfoV2
        end
    end
    return self.mUnionInfoV2
end
--endregion

--endregion

--region 组件
---@return UIPageRecyclingContainer1T 背包控制器
function UIGuildBagPanel:GetBagRecycleController()
    if self.mBagRecycle == nil then
        self.mBagRecycle = self:GetCurComp("WidgetRoot/GuildBagScroll View/WarehouseContent", "UIPageRecyclingContainerForGameObject")
    end
    return self.mBagRecycle
end

---@return UIPageRecyclingContainer1T 仓库控制器
function UIGuildBagPanel:GetWarehouseRecycleController()
    if self.mWarehouseRecycle == nil then
        self.mWarehouseRecycle = self:GetCurComp("WidgetRoot/MyBagScroll View/WarehouseContent", "UIPageRecyclingContainerForGameObject")
    end
    return self.mWarehouseRecycle
end

---@return UILabel 积分Label
function UIGuildBagPanel:GetContributionLabel()
    if self.mContributionLabel == nil then
        self.mContributionLabel = self:GetCurComp("WidgetRoot/panel/lb_integral", "UILabel")
    end
    return self.mContributionLabel
end

---@return UIToggle 筛选按钮全部
function UIGuildBagPanel:GetAllToggle()
    if self.mAllToggle == nil then
        self.mAllToggle = self:GetCurComp("WidgetRoot/panel/Toggle/AllTemplate", "UIToggle")
    end
    return self.mAllToggle
end

---@return UIToggle 筛选按钮灵兽蛋
function UIGuildBagPanel:GetServantEggToggle()
    if self.mServantToggle == nil then
        self.mServantToggle = self:GetCurComp("WidgetRoot/panel/Toggle/ServantTemplate", "UIToggle")
    end
    return self.mServantToggle
end

---@return UIToggle 筛选按钮肉身
function UIGuildBagPanel:GetServantBodyToggle()
    if self.mServantBodyToggle == nil then
        self.mServantBodyToggle = self:GetCurComp("WidgetRoot/panel/Toggle/ServantEquipsTemplate", "UIToggle")
    end
    return self.mServantBodyToggle
end

---@return UIToggle 筛选按钮其他道具
function UIGuildBagPanel:GetOtherEquipToggle()
    if self.mOtherEquipToggle == nil then
        self.mOtherEquipToggle = self:GetCurComp("WidgetRoot/panel/Toggle/OtherEquipsTemplate", "UIToggle")
    end
    return self.mOtherEquipToggle
end

---@return UIGridContainer 背包页签
function UIGuildBagPanel:GetBagPageContainer()
    if self.mBagPageContainer == nil then
        self.mBagPageContainer = self:GetCurComp("WidgetRoot/Guildbaggrid", "UIGridContainer")
    end
    return self.mBagPageContainer
end

---@return UIGridContainer 仓库页签
function UIGuildBagPanel:GetWarehousePageContainer()
    if self.mWarehousePageContainer == nil then
        self.mWarehousePageContainer = self:GetCurComp("WidgetRoot/Mybaggrid", "UIGridContainer")
    end
    return self.mWarehousePageContainer
end

---@return UnityEngine.GameObject 仓库帮助
function UIGuildBagPanel:GetWarehouseHelpBtn_GameObject()
    if self.mHelpBtn == nil then
        self.mHelpBtn = self:GetCurComp("WidgetRoot/panel/btn_help", "GameObject")
    end
    return self.mHelpBtn
end

--endregion

--region 初始化
function UIGuildBagPanel:Init()
    self:BindMessage()
    self:BindEvents()
end

function UIGuildBagPanel:Show()
    networkRequest.ReqUnionWarehouseInfo()
    self:InitBagRecycleController()
    self:InitBagPage()
    self:InitWarehouseRecycleController()
    self:RefreshPanelShow()
    self:GetAllToggle():Set(true)
end

function UIGuildBagPanel:BindEvents()
    CS.EventDelegate.Add(self:GetAllToggle().onChange, function()
        self:InitWarehouseRecycleController()
    end)
    CS.EventDelegate.Add(self:GetServantEggToggle().onChange, function()
        self:InitWarehouseRecycleController()
    end)
    CS.EventDelegate.Add(self:GetServantBodyToggle().onChange, function()
        self:InitWarehouseRecycleController()
    end)
    CS.EventDelegate.Add(self:GetOtherEquipToggle().onChange, function()
        self:InitWarehouseRecycleController()
    end)
    CS.UIEventListener.Get(self:GetWarehouseHelpBtn_GameObject()).onClick = function()
        self:OnHelpBtnClicked()
    end
end

function UIGuildBagPanel:BindMessage()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_UnionBagInfoChange, function()
        self:InitWarehouseRecycleController()
        self:RefreshPanelShow()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        local targetPage = self.mCurrentBagPage == nil and 0 or self.mCurrentBagPage;
        self:InitBagRecycleController()
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGetBagItemInfoMessage, UIGuildBagPanel.OnResGetBagItemInfoMessageReceived)
end
--endregion

--region 服务器事件
---收到单个ItemList
---@param csData unionV2.ResGetBagItemInfo
function UIGuildBagPanel.OnResGetBagItemInfoMessageReceived(msgId, tblData, csData)
    if csData then
        local showList = CS.CSServantInfoV2.SortServantEquipFunc(csData.itemList)
        if showList.Count > 0 then
            local data = {}
            ---@type UIGuildStoragePanel_Exchange
            data.Template = luaComponentTemplates.UIGuildStoragePanel_Exchange
            data.showList = showList
            data.BagItemInfo = showList[0]
            data.showAssistPanel = true
            uimanager:CreatePanel("UIAuctionItemPanel", nil, data)
        end
    end
end
--endregion

--region UI事件
--region 背包
---刷新背包显示
function UIGuildBagPanel:InitBagRecycleController()
    --if(self.mPageToRefresh == nil) then
    --    self.mPageToRefresh = {};
    --end
    local targetPage = self.mCurrentBagPage == nil and 0 or self.mCurrentBagPage;
    self:GetBagRecycleController():Initialize(self:GetBagMaxPageCount(), function(pageObj, pageIndex)
        self:OnPageEnterView(pageObj, pageIndex)
    end, nil, function(page)
        self:OnCenterPageIndexChanged(page)
    end, targetPage)
    self:RefreshBagPage(targetPage);
end

---背包页进入视野
function UIGuildBagPanel:OnPageEnterView(pageObj, pageIndex)
    --local currentPage = pageIndex + 1
    --if self.mPageToRefresh[currentPage] == nil or not self.mPageToRefresh[currentPage] then
    --    self.mPageToRefresh[currentPage] = true
    --    self.mPageToRefresh[currentPage - 2] = false
    --    self.mPageToRefresh[currentPage + 2] = false
    local bagItemList = self:GetBagInfoList()
    local container = CS.Utility_Lua.GetComponent(pageObj.transform:Find("Content"), "UIGridContainer")
    container.MaxCount = self:GetPerPageGridNum()
    for i = 0, container.controlList.Count - 1 do
        local gp = container.controlList[i]
        local template = self:GetGridTemplate(gp)
        local index = self:GetPerPageGridNum() * pageIndex + i + 1
        if index <= #bagItemList then
            local bagItemInfo = bagItemList[index]
            local itemInfo
            if bagItemInfo and bagItemInfo.ItemTABLE then
                itemInfo = bagItemInfo.ItemTABLE
            end
            template:RefreshWithInfo(bagItemInfo, itemInfo, false)
        else
            template:RefreshWithInfo(nil, nil, false)
        end
    end
    --end
end

---刷新中心页
function UIGuildBagPanel:OnCenterPageIndexChanged(page)
    self:RefreshBagPage(page)
end

---获取背包格子模板
---@param go UnityEngine.GameObject 背包格子
---@return UIGuildBagPanel_BagGridTemplate
function UIGuildBagPanel:GetGridTemplate(go)
    if CS.StaticUtility.IsNull(go) then
        return nil
    end
    if self.mBagGridToTemplate == nil then
        self.mBagGridToTemplate = {}
    end
    local gridTemplate = self.mBagGridToTemplate[go]
    if gridTemplate == nil then
        ---@type UIGuildBagPanel_BagGridTemplate
        gridTemplate = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGuildBagPanel_BagGridTemplate, nil, self:GetGuildBagInteraction(), function(name)
            return self:FetchComponent(name)
        end)
        self.mBagGridToTemplate[go] = gridTemplate
    end
    return gridTemplate
end

---初始化帮会背包页签
function UIGuildBagPanel:InitBagPage()
    self:GetBagPageContainer().MaxCount = math.ceil(self:GetBagMaxPageCount())
    self:RefreshBagPage(0)
end

---刷新当前页签
function UIGuildBagPanel:RefreshBagPage(page)
    if self.mCurrentBagPage then
        self:SetPageSprite(self:GetBagPageContainer(), self.mCurrentBagPage, false)
    end
    self:SetPageSprite(self:GetBagPageContainer(), page, true)
    self.mCurrentBagPage = page
end
--endregion

--region仓库
---刷新仓库显示
function UIGuildBagPanel:InitWarehouseRecycleController()
    local page = 1;
    local targetPage = self.mCurrentWarehousePage == nil and 0 or self.mCurrentWarehousePage;
    if self:GetUnionInfoV2() and self:GetUnionInfoV2().StorageItemInfo then
        self.storageList = self:GetFilteredStorageList()
        self.guildGridMaxIndex = self:GetUnionInfoV2().StorageItemInfo.maxEquipGridCount
        page = math.ceil(self.guildGridMaxIndex / self:GetPerPageGridNum())
    end
    self:GetWarehouseRecycleController():Initialize(page, function(pageObj, pageIndex)
        self:OnWarehousePageEnterView(pageObj, pageIndex)
    end, nil, function(page)
        self:OnWarehouseCenterPageIndexChanged(page)
    end, targetPage);
    self:InitWarehousePage(page, targetPage)
end

---仓库页进入视野
function UIGuildBagPanel:OnWarehousePageEnterView(pageObj, pageIndex)
    --local currentPage = pageIndex + 1
    --if self.mGuildBagPageToRefresh[currentPage] == nil or not self.mPageToRefresh[currentPage] then
    --    self.mPageToRefresh[currentPage] = true
    --    self.mPageToRefresh[currentPage - 2] = false
    --    self.mPageToRefresh[currentPage + 2] = false
    local container = CS.Utility_Lua.GetComponent(pageObj.transform:Find("Content"), "UIGridContainer")
    container.MaxCount = self:GetPerPageGridNum()
    for i = 0, container.controlList.Count - 1 do
        local gp = container.controlList[i]
        local template = self:GetGuildBagGridTemplate(gp)
        if self.storageList then
            local index = self:GetPerPageGridNum() * pageIndex + i + 1
            if index <= self.guildGridMaxIndex then
                local OnItemAllInfo = self.storageList[index]
                local itemInfo
                if OnItemAllInfo then
                    itemInfo = self:GetItemInfo(OnItemAllInfo.itemId)
                    template:RefreshItem(OnItemAllInfo, itemInfo, false)
                else
                    template:RefreshItem(nil, nil, false)
                end
            else
                template:RefreshItem(nil, nil, true)
            end
        else
            template:RefreshItem(nil, nil, false)
        end
    end
    --end
end

---刷新仓库中心页
function UIGuildBagPanel:OnWarehouseCenterPageIndexChanged(page)
    self:RefreshWarehousePage(page)
end

---@return UIGuildBagPanel_StorageGridTemplate 获取帮会仓库格子模板
function UIGuildBagPanel:GetGuildBagGridTemplate(go)
    if self.mGuildBagGridToTemplate == nil then
        self.mGuildBagGridToTemplate = {}
    end
    local template = self.mGuildBagGridToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGuildBagPanel_StorageGridTemplate)
        self.mGuildBagGridToTemplate[go] = template
    end
    return template
end

---@return table<number,unionV2.OneItemAllInfo>获取需要显示仓库道具
function UIGuildBagPanel:GetFilteredStorageList()
    local list = {}
    local allList = self:GetUnionInfoV2():GetUnionBagSortList()
    for i = 0, allList.Count - 1 do
        ---@type unionV2.OneItemAllInfo 单个格子信息
        local OneItemAllInfo = allList[i]
        local itemInfo = self:GetItemInfo(OneItemAllInfo.itemId)
        if itemInfo then
            if self:GetAllToggle().value then
                table.insert(list, OneItemAllInfo)
            elseif self:GetServantEggToggle().value then
                if CS.CSServantInfoV2.isServantEgg(itemInfo) then
                    table.insert(list, OneItemAllInfo)
                end
            elseif self:GetServantBodyToggle().value then
                if CS.CSServantInfoV2.IsServantBody(itemInfo.subType) or CS.CSServantInfoV2.IsServantJustEquip(itemInfo.subType) then
                    table.insert(list, OneItemAllInfo)
                end
            elseif self:GetOtherEquipToggle().value then
                if CS.CSServantInfoV2.isServantEgg(itemInfo) == false and CS.CSServantInfoV2.IsServantBody(itemInfo.subType) == false and CS.CSServantInfoV2.IsServantJustEquip(itemInfo.subType) == false then
                    table.insert(list, OneItemAllInfo)
                end
            end
        end
    end
    return list
end

---@return TABLE.CFG_ITEMS itemInfo
function UIGuildBagPanel:GetItemInfo(itemId)
    local itemInfo
    if itemId then
        if self.mItemIdToItemInfo == nil then
            self.mItemIdToItemInfo = {}
        end
        itemInfo = self.mItemIdToItemInfo[itemId]
        if itemInfo == nil then
            local res, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
            if res then
                itemInfo = info
                self.mItemIdToItemInfo[itemId] = itemInfo
            end
        end
    end
    return itemInfo
end

---初始化仓库页签
function UIGuildBagPanel:InitWarehousePage(page, targetPage)
    targetPage = targetPage == nil and 0 or targetPage;
    self:GetWarehousePageContainer().MaxCount = page
    self:RefreshWarehousePage(targetPage);
end

---刷新仓库页签显示
function UIGuildBagPanel:RefreshWarehousePage(page)
    if self.mCurrentWarehousePage then
        self:SetPageSprite(self:GetWarehousePageContainer(), self.mCurrentWarehousePage, false)
    end
    self:SetPageSprite(self:GetWarehousePageContainer(), page, true)
    self.mCurrentWarehousePage = page
end
--endregion

---设置仓库和背包页签
function UIGuildBagPanel:SetPageSprite(container, page, isChoose)
    if page >= container .controlList.Count then
        return
    end
    local go = container.controlList[page]
    if self.mPageGoToSprite == nil then
        self.mPageGoToSprite = {}
    end
    ---@type UISprite
    local sprite = self.mPageGoToSprite[go]
    if sprite == nil then
        sprite = CS.Utility_Lua.GetComponent(go.transform, "UISprite")
        self.mPageGoToSprite[go] = sprite
    end
    sprite.spriteName = self.mPageSprite[isChoose]
end

---刷新界面显示
function UIGuildBagPanel:RefreshPanelShow()
    if self:GetUnionInfoV2() then
        local score = self:GetUnionInfoV2().UnionScore
        if score then
            self:GetContributionLabel().text = "我的背包(积分" .. score .. ")"
        end
    end
end

---点击帮助按钮
function UIGuildBagPanel:OnHelpBtnClicked()
    local isFind, desInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(3)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, desInfo)
    end
end
--endregion

--region Update
function update()
    UIGuildBagPanel:GetGuildBagInteraction():OnUpdate(CS.UnityEngine.Time.time)
end
--endregion

return UIGuildBagPanel