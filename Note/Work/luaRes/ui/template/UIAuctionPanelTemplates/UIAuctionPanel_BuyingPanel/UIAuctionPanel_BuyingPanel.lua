---@class UIAuctionPanel_BuyingPanel 求购面板模板
local UIAuctionPanel_BuyingPanel = {}

--region局部变量
---@type table<number,auctionV2.AuctionItemInfo> 页数对应信息
UIAuctionPanel_BuyingPanel.PageToInfo = {}

---页数对应刷新（避免重复刷新）
UIAuctionPanel_BuyingPanel.mPageToRefresh = {}

---@type table<UnityEngine.GameObject,UIAuctionPanel_BuyingGrid> 格子对应模板
UIAuctionPanel_BuyingPanel.GoToTemplate = {}

---当前页
UIAuctionPanel_BuyingPanel.mCurrentPage = nil

---强制重刷新
UIAuctionPanel_BuyingPanel.mIsNeedRefreshData = false

---求购货币类型
UIAuctionPanel_BuyingPanel.mCoinType = LuaEnumCoinType.YuanBao

---@type number 顶行
UIAuctionPanel_BuyingPanel.mTopLine = 0

---@type number
---每行个数
UIAuctionPanel_BuyingPanel.mLineNum = 1

---每页4条，刷新超过n*12条时请求下一页
UIAuctionPanel_BuyingPanel.mMaxCountPrePage = 4

---@type number
---缓存数据页数
UIAuctionPanel_BuyingPanel.mSaveData = 8



--endregion

--region属性
---@return UIAuctionPanel_BuyingPanel_Menu 竞拍目录模板
function UIAuctionPanel_BuyingPanel:GetMenuControllerTemplate()
    if self.buyingUIAuctionFiltrateList == nil then
        self.buyingUIAuctionFiltrateList = templatemanager.GetNewTemplate(self.toggleArea, luaComponentTemplates.UIAuctionPanel_BuyingPanel_Menu, self)
    end
    return self.buyingUIAuctionFiltrateList
end
--endregion

--region 组件
---@return UILoopScrollViewPlus 求购循环组件
function UIAuctionPanel_BuyingPanel:GetLoopScroll_UILoopScrollViewPlus()
    if self.mLoopComp == nil then
        self.mLoopComp = self:Get("ItemsArea/Scroll View/LoopScroll", "UILoopScrollViewPlus")
    end
    return self.mLoopComp
end

---@return UILoopScrollViewPlus 求购背包循环组件
function UIAuctionPanel_BuyingPanel:GetBagLoopScroll_UILoopScrollViewPlus()
    if self.mBagLoopComp == nil then
        self.mBagLoopComp = self:Get("ItemWindow/Scroll View/UIGrid", "UILoopScrollViewPlus")
    end
    return self.mBagLoopComp
end

--endregion

--region 初始化
---@param auctionPanel UIAuctionPanel
function UIAuctionPanel_BuyingPanel:Init(auctionPanel)
    self.AuctionPanel = auctionPanel
    self:InitConpoment()
    self:BindEvent()
    self:InitCoinInfo()
end

function UIAuctionPanel_BuyingPanel:InitConpoment()
    self.toggleArea = self:Get("ToggleArea", "GameObject")
    self.buyBtn = self:Get("btn_Buying", "GameObject")
    ---@type UnityEngine.GameObject 背包Go
    self.bagItem = self:Get("ItemWindow", "GameObject")
    self.nothingSprite = self:Get("ItemsArea/NoneTips", "GameObject")
    self.coin_Label = self:Get("Coin", "UILabel")

    ---@type UnityEngine.GameObject 求购滑条
    self.BuyingScroll = self:Get("ItemsArea/Scroll View", "GameObject")

    ---@type UnityEngine.GameObject 求购背景
    self.BagBG_GameObject = self:Get("ItemWindow/UISpritre", "GameObject")

    ---@type UISprite
    ---货币图片
    self.coin_UISprite = self:Get("Coin/Sprite2", "UISprite")
end

function UIAuctionPanel_BuyingPanel:BindEvent()
    CS.UIEventListener.Get(self.buyBtn).onClick = function()
        self:OnSelfBuyingButtonClicked()
    end
    CS.UIEventListener.Get(self.bagItem).onClick = function()
        self.bagItem:SetActive(false)
    end

    CS.UIEventListener.Get(self.coin_UISprite.gameObject).onClick = function()
        self:ShowMoneyTips()
    end
end
--endregion

---出售成功回调
function UIAuctionPanel_BuyingPanel:SubmitBuyProductsItem(tblData)
    self:RefreshBagItems(tblData)
    self:RefreshCurrentPage()
end

---筛选刷新背包面板
function UIAuctionPanel_BuyingPanel:RefreshBagItems(tblData)
    self.bagItemList = self:FilterShowBagItemList(self.sellBagItemInfo)
    if self.bagItemList == nil or self.bagItemList.Count == 0 or tblData.leftCount == 0 then
        self.bagItem:SetActive(false)
        return
    end
end

---筛选需要显示的背包列表
function UIAuctionPanel_BuyingPanel:FilterShowBagItemList()
    local bagItemList = self:filterBagItemInfo()
    return bagItemList
end

---跳转个人求购
function UIAuctionPanel_BuyingPanel:OnSelfBuyingButtonClicked()
    if self.AuctionPanel and self.AuctionPanel.SwitchToSelfBuyingPanel then
        self.AuctionPanel:SwitchToSelfBuyingPanel()
    end
end

--region货币
---刷新货币显示
function UIAuctionPanel_BuyingPanel:RefreshCoinShow()
    local value = self.AuctionPanel:GetBagInfoV2():GetCoinAmount(self.mCoinType)
    self.coin_Label.text = value
end

---初始化货币信息
function UIAuctionPanel_BuyingPanel:InitCoinInfo()
    if self:GetCoinInfo() then
        self.coin_UISprite.spriteName = self:GetCoinInfo().icon
    end
end

---@return TABLE.CFG_ITEMS 货币item信息
function UIAuctionPanel_BuyingPanel:GetCoinInfo()
    if self.mCoinInfo == nil then
        ___, self.mCoinInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mCoinType)
    end
    return self.mCoinInfo
end

---显示Tips
function UIAuctionPanel_BuyingPanel:ShowMoneyTips()
    if self:GetCoinInfo() then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self:GetCoinInfo() })
    end
end
--endregion

--region 功能
---筛选需要显示的背包物品
function UIAuctionPanel_BuyingPanel:filterBagItemInfo(bagItemList)
    if self.sellBagItemInfo ~= nil then
        local showItems = CS.CSScene.MainPlayerInfo.AuctionInfo:FilterSameItemByItemInfo(self.sellBagItemInfo)
        return showItems
    end
    if self.auctionInfo ~= nil then
        local auctionItemBuyProductsInfo = self.auctionInfo.auctionItemBuyProductsInfo
        local showItems = CS.CSScene.MainPlayerInfo.BagInfo:GetBagItemInfoByCondition(auctionItemBuyProductsInfo)
        return showItems
    end
end

---筛选按钮点击请求(左侧装备类型选择)
function UIAuctionPanel_BuyingPanel:FilterBtnClick(idList, params, page)
    local pageIndex = ternary(page == nil, 1, page)
    local minLv = 0
    local maxLv = 10 * 1000
    local itemType = Utility.EnumToInt(CS.auctionV2.AuctionItemType.BUY_PRODUCTS)
    local sortBy = Utility.EnumToInt(CS.auctionV2.SalfProductsSortType.BUYPRODUCTSPRICE)

    local list = CS.auctionV2.GetAuctionItemsRequest().screenCondition
    if list ~= nil then
        for i = 1, #idList do
            if idList[i] ~= "" then
                list:Add(idList[i])
            end
        end
    end
    networkRequest.ReqGetAuctionItems(pageIndex, minLv, maxLv, -1, nil, nil, -1, list, itemType, sortBy, true)
end
--endregion

--region 数据相关
---默认打开界面显示
function UIAuctionPanel_BuyingPanel:ShowPanel()
    -- self:ClearData()
    self.mPageToRefresh = {}
    self:GetMenuControllerTemplate():OpenPage(0)
    self:RefreshCoinShow()
    self:InitBuyingComp()
end

---清除数据重新刷新
function UIAuctionPanel_BuyingPanel:ClearCurrentData()
    self.PageToInfo = {}
end

---设置强制刷新
function UIAuctionPanel_BuyingPanel:SetNeedRefresh()
    self:InitBuyingComp()
end
--endregion

--region 求购面板显示
---背包高度
UIAuctionPanel_BuyingPanel.BagSizeHeight = 214

---背包偏移位置
UIAuctionPanel_BuyingPanel.mBagOffSizeHeight = 20

---获取交易数据刷新
---@param csData auctionV2.AuctionItemList
function UIAuctionPanel_BuyingPanel:RefreshItemShow(csData)
    if csData == nil then
        return
    end
    self.PageToInfo[csData.page] = csData.items
    if not CS.StaticUtility.IsNull(self.nothingSprite) then
        self.nothingSprite:SetActive(csData.toatlPageCount == 0)
    end
    self:GetLoopScroll_UILoopScrollViewPlus():RefreshCurrentPage()
end

---初始化组件
function UIAuctionPanel_BuyingPanel:InitBuyingComp()
    self:GetLoopScroll_UILoopScrollViewPlus():Init(function(go, line)
        return self:RefreshBuyingLine(go, line)
    end, function(line)
        self.mTopLine = line
    end)

end

---刷新每一行数据
---@param go UnityEngine.GameObject item
---@param line number 从零开始的行数
function UIAuctionPanel_BuyingPanel:RefreshBuyingLine(go, line)
    self:TradeDataManage(line)
    local lineData = self:GetLineDataFormTable(line)
    if #lineData > 0 and not CS.StaticUtility.IsNull(go) then
        for i = 1, #lineData do
            ---@type auctionV2.AuctionItemInfo
            local data = lineData[i]
            local template = self:GetGridTemplate(go)
            if template then
                template:RefreshUI(data)
            end
        end
        return true
    end
    return false
end

---数据请求控制（存储8页数据）
function UIAuctionPanel_BuyingPanel:TradeDataManage(line)
    local page = math.floor((line * self.mLineNum) / self.mMaxCountPrePage) + 1
    if self.PageToInfo[page] then
        return
    end
    self:ReqBuyingData(page, false)
    if page - self.mSaveData > 0 then
        self.PageToInfo[page - self.mSaveData] = nil
    end
    self.PageToInfo[page + self.mSaveData] = nil
end

---请求页数数据
function UIAuctionPanel_BuyingPanel:ReqBuyingData(page)
    self:GetMenuControllerTemplate():NetWorkReq(page)
end

---@return table<number,auctionV2.AuctionItemInfo>  统一处理数据 从table中取出某一行数据
function UIAuctionPanel_BuyingPanel:GetLineDataFormTable(line)
    local list = {}
    if self.PageToInfo then
        local page = math.floor((line * self.mLineNum) / self.mMaxCountPrePage) + 1
        local pageData = self.PageToInfo[page]
        if pageData then
            local listLength = pageData.Count
            local index = (line * self.mLineNum) % (self.mMaxCountPrePage)
            for i = index, index + self.mLineNum - 1 do
                if listLength > i and pageData[i] then
                    table.insert(list, pageData[i])
                end
            end
        end
    end
    return list
end

---@return UIAuctionPanel_BuyingGrid 拍卖行求购格子模板
function UIAuctionPanel_BuyingPanel:GetGridTemplate(go)
    if self.mGridToTemplate == nil then
        self.mGridToTemplate = {}
    end
    local template = self.mGridToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIAuctionPanel_BuyingGrid, self)
    end
    return template
end

---刷新当前页信息
function UIAuctionPanel_BuyingPanel:RefreshCurrentPage()
    local page = math.floor(self.mTopLine / (self.mMaxCountPrePage / self.mLineNum)) + 1
    self:ReqBuyingData(page, true)
    self:ReqBuyingData(page + 1, true)
end

---点击出售
function UIAuctionPanel_BuyingPanel:OnSellBtnClicked(go, itemInfo, auctionInfo, trans)
    self.singlePrice = auctionInfo.price.count
    self.priceInfo = auctionInfo.item
    self.needNum = auctionInfo.auctionItemBuyProductsInfo.count
    self.auctionInfo = auctionInfo
    self.sellBagItemInfo = itemInfo
    self.sellBtn = go
    local showList = self:FilterBagItemInfo(itemInfo, auctionInfo)
    local hasData = showList and showList.Count > 0
    self.bagItem:SetActive(hasData)
    if hasData then
        self:InitBagComp(showList)
    else
        Utility.ShowPopoTips(go.transform, nil, 96)
    end
    self:SetItemPos(trans)
end

---设置背包位置
function UIAuctionPanel_BuyingPanel:SetItemPos(trans)
    local startPos = self.bagItem.transform.localPosition
    local scale = CS.UnityEngine.Vector3.one
    local move = self.BuyingScroll.transform.localPosition.y
    local pos = move + trans.y - self.BagSizeHeight / 2 - self.mBagOffSizeHeight
    if pos < -160 then
        pos = move + trans.y + self.BagSizeHeight / 2 + self.mBagOffSizeHeight
        scale.y = -1
    end
    self.BagBG_GameObject.transform.localScale = scale
    startPos.y = pos
    self.bagItem.transform.localPosition = startPos
end

--endregion

--region 背包面板
---背包每行格子数
UIAuctionPanel_BuyingPanel.BagNumPreLine = 5

---筛选需要显示的背包物品
function UIAuctionPanel_BuyingPanel:FilterBagItemInfo(itemInfo, auctionInfo)
    if itemInfo ~= nil then
        local showItems = CS.CSScene.MainPlayerInfo.AuctionInfo:FilterSameItemByItemInfo(itemInfo)
        return showItems
    end
    if auctionInfo ~= nil then
        local auctionItemBuyProductsInfo = auctionInfo.auctionItemBuyProductsInfo
        local showItems = CS.CSScene.MainPlayerInfo.BagInfo:GetBagItemInfoByCondition(auctionItemBuyProductsInfo)
        return showItems
    end
end

---初始化背包组件
function UIAuctionPanel_BuyingPanel:InitBagComp(showList)
    self:GetBagLoopScroll_UILoopScrollViewPlus():Init(function(go, line)
        local lineData = self:GetBagLineData(showList, line)
        if #lineData > 0 or line <= 1 then
            local container = CS.Utility_Lua.Get(go.transform, "UIGridItem", "UIGridContainer")
            self:RefreshContainer(container, lineData)
            return true
        else
            return false
        end
    end)
end

---刷新背包显示
---@param container UIGridContainer 每行container
---@param data table<number,bagV2.BagItemInfo> 每行数据
function UIAuctionPanel_BuyingPanel:RefreshContainer(container, data)
    container.MaxCount = self.BagNumPreLine
    for i = 0, self.BagNumPreLine - 1 do
        local go = container.controlList[i]
        local template = self:GetBagItemTemplate(go)
        if template then
            local showInfo = data[i + 1]
            if showInfo then
                local itemTable = showInfo.ItemTABLE
                template:RefreshWithInfo(showInfo, itemTable)
            else
                template:RefreshWithInfo(nil, nil)
            end
        end
    end
end

---将列表拆成每行五个显示
function UIAuctionPanel_BuyingPanel:GetBagLineData(showList, line)
    local list = {}
    for i = line * self.BagNumPreLine, (line + 1) * self.BagNumPreLine - 1 do
        if i < showList.Count then
            table.insert(list, showList[i])
        end
    end
    return list
end

---@return UIAuctionPanel_BuyingPanel_BagItemTemplate 获取背包格子模板
function UIAuctionPanel_BuyingPanel:GetBagItemTemplate(go)
    if self.GoToBagTemplate == nil then
        self.GoToBagTemplate = {}
    end
    local template = self.GoToBagTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIAuctionPanel_BuyingPanel_BagItemTemplate, self, self:GetAuctionBuyingBagInteraction(), function(name)
            return self:FetchComponent(name)
        end)
        self.GoToBagTemplate[go] = template
    end
    return template
end

---@return UIAuctionPanel_BuyingPanel_BagItemInteraction 背包交互层模板
function UIAuctionPanel_BuyingPanel:GetAuctionBuyingBagInteraction()
    if self.mInteraction == nil then
        self.mInteraction = templatemanager.GetNewTemplate(self.go, luaComponentTemplates.UIAuctionPanel_BuyingPanel_BagItemInteraction, self, nil, nil)
    end
    return self.mInteraction
end

---获取背包格子模板组件
---@param name string 组件名字
---@return UnityEngine.GameObject 组件
function UIAuctionPanel_BuyingPanel:FetchComponent(name)
    if self.NameToGo == nil then
        self.NameToGo = {}
    end
    local go = self.NameToGo[name]
    if CS.StaticUtility.IsNull(go) then
        go = CS.Utility_Lua.Get(self:GetBagPrefab().transform, name, "GameObject")
    end
    return go
end

---@return UnityEngine.GameObject 背包复制用格子
function UIAuctionPanel_BuyingPanel:GetBagPrefab()
    if self.mCopyGo == nil then
        self.mCopyGo = self:Get("ItemWindow/UIItem", "GameObject")
    end
    return self.mCopyGo
end

---背包物品单机
function UIAuctionPanel_BuyingPanel:BagBtnOnClick(go, bagItemInfo)
    if bagItemInfo ~= nil then
        self.mCurrentChooseBagItemInfo = bagItemInfo
        --[[
        local maxbuycount = self:calCulateNeedNum(bagItemInfo, self.needNum)
        local customData = {
            beginCount = maxbuycount,
            bagItemInfo = bagItemInfo,
            singlePrice = self.singlePrice,
            priceBagItemInfo = self.priceInfo,
            maxBuyCount = maxbuycount,
            sellCallBack = function(priceBagItemInfo, itemBagItemInfo, num)
                networkRequest.ReqSubmitBuyProductsItem(priceBagItemInfo.lid, itemBagItemInfo.lid, num)
                uimanager:ClosePanel("UIAuctionSelling")
            end
        }
        uimanager:CreatePanel("UIAuctionSelling", nil, customData)
        --]]
        networkRequest.ReqMarketPriceSection(bagItemInfo.lid, Utility.EnumToInt(CS.auctionV2.MarketPriceSectionType.ADD), Utility.EnumToInt(CS.auctionV2.AuctionItemType.BUY_PRODUCTS), self.mCoinType)
    end
end

---@param info auctionV2.MarketPriceSection
function UIAuctionPanel_BuyingPanel:GetPriceSection(info)
    local maxbuycount = self:calCulateNeedNum(self.mCurrentChooseBagItemInfo, self.needNum)
    local data = {}
    ---@type UIAuctionPanel_AuctionItem_BuyingBuy
    data.Template = luaComponentTemplates.UIAuctionPanel_AuctionItem_BuyingBuy
    data.BagItemInfo = self.mCurrentChooseBagItemInfo
    data.MaxNum = maxbuycount
    data.SinglePrice = self.singlePrice
    data.PriceBagItemInfo = self.priceInfo
    data.PriceData = info
    uimanager:CreatePanel('UIAuctionItemPanel', nil, data)
end

function UIAuctionPanel_BuyingPanel:calCulateNeedNum(bagItemInfo, needNum)
    local needNum = needNum
    local itemInfoIsFInd, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(bagItemInfo.itemId)
    if itemInfoIsFInd then
        local bagItemInfoCount
        if itemInfo.reuseType ~= nil and itemInfo.reuseType.list ~= nil and itemInfo.reuseType.list[0] == LuaEnumItemUseNumType.ShowUIBagPanel and bagItemInfo ~= nil and bagItemInfo.leftUseNum ~= nil and bagItemInfo.leftUseNum > 1 then
            bagItemInfoCount = bagItemInfo.leftUseNum
        elseif itemInfo.overlying ~= nil and itemInfo.overlying ~= 1 and bagItemInfo.count > 1 then
            bagItemInfoCount = bagItemInfo.count
        else
            bagItemInfoCount = 1
        end
        needNum = ternary(needNum > bagItemInfoCount, bagItemInfoCount, needNum)
    end
    return needNum
end
--endregion

return UIAuctionPanel_BuyingPanel