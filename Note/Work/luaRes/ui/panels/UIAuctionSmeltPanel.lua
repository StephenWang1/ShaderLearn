---@class UIAuctionSmeltPanel:UIBase 熔炼行
local UIAuctionSmeltPanel = {}

--region 局部变量定义
UIAuctionSmeltPanel.mMaxPage = 1
---@type number
---每行个数
UIAuctionSmeltPanel.mLineNum = 3

---每页12条，刷新超过n*12条时请求下一页
UIAuctionSmeltPanel.mMaxCountPrePage = 12

---@type table<number,auctionV2.AuctionItemInfo> 页数对应信息
UIAuctionSmeltPanel.PageToInfo = {}

UIAuctionSmeltPanel.mCoinType = LuaEnumCoinType.EquipCoin

UIAuctionSmeltPanel.mSortType = {
    [LuaEnumAuctionTradeSortType.PriceUp] = "价格↑",
    [LuaEnumAuctionTradeSortType.PriceDown] = "价格↓",
    [LuaEnumAuctionTradeSortType.TimeUp] = "时间↑",
    [LuaEnumAuctionTradeSortType.TimeDown] = "时间↓",
}

UIAuctionSmeltPanel.mSortTypeMenu = {
    LuaEnumAuctionTradeSortType.PriceUp, LuaEnumAuctionTradeSortType.PriceDown, LuaEnumAuctionTradeSortType.TimeUp, LuaEnumAuctionTradeSortType.TimeDown
}

UIAuctionSmeltPanel.mNeedChooseItemList = nil

---@type table<number,boolean> lid 对应选中
UIAuctionSmeltPanel.mLidToChoose = nil

---@type table<number,UIAuctionSmeltPanel_BuyGridTemplate> 存储当前设置过选中的模板
UIAuctionSmeltPanel.mCurrentChooseTemplate = nil
--endregion

--region 数据缓存
---@return UIAuctionPanel
function UIAuctionSmeltPanel:GetAuctionPanel()
    if self.mRootPanel == nil then
        self.mRootPanel = uimanager:GetPanel("UIAuctionPanel")
    end
    return self.mRootPanel
end

---@return TABLE.CFG_ITEMS 缓存item信息
function UIAuctionSmeltPanel:GetItemInfoCache(id)
    if id == nil then
        return
    end
    if self.mItemIdToInfo == nil then
        self.mItemIdToInfo = {}
    end
    local info = self.mItemIdToInfo[id]
    if info == nil then
        ___, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
        self.mItemIdToInfo[id] = info
    end
    return info
end

---@return TABLE.CFG_ITEM_TRADETYPE 缓存目录表数据
function UIAuctionSmeltPanel:CacheTradeTypeTableInfo(tradeId)
    if tradeId == nil then
        return
    end
    if self.mTradeIdToInfo == nil then
        self.mTradeIdToInfo = {}
    end
    local info = self.mTradeIdToInfo[tradeId]
    if info == nil then
        ___, info = CS.Cfg_Item_TradeTypeManager.Instance.dic:TryGetValue(tradeId)
        self.mTradeIdToInfo[tradeId] = info
    end
    return info
end

---@return CSMainPlayerInfo
function UIAuctionSmeltPanel:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSBagInfoV2
function UIAuctionSmeltPanel:GetBagInfoV2()
    if self.mBagInfoV2 == nil and self:GetMainPlayerInfo() then
        self.mBagInfoV2 = self:GetMainPlayerInfo().BagInfo
    end
    return self.mBagInfoV2
end
--endregion

--region 组件
---@return UnityEngine.GameObject 熔炼按钮
function UIAuctionSmeltPanel:GetSelfSmeltBtn_GO()
    if self.mSelfSmeltBtn == nil then
        self.mSelfSmeltBtn = self:GetCurComp("WidgetRoot/SellBtn", "GameObject")
    end
    return self.mSelfSmeltBtn
end

---@return UILoopScrollViewPlus
function UIAuctionSmeltPanel:GetSmelt_LoopScrollViewPlus()
    if self.mSmeltLoop == nil then
        self.mSmeltLoop = self:GetCurComp("WidgetRoot/ItemsArea/Scroll View/LoopScrollViewPlusTrade", "UILoopScrollViewPlus")
    end
    return self.mSmeltLoop
end

---@return UILabel 货币数目
function UIAuctionSmeltPanel:GetCoin_Lb()
    if self.mCoinLb == nil then
        self.mCoinLb = self:GetCurComp("WidgetRoot/HoldIngot", "UILabel")
    end
    return self.mCoinLb
end

---@return UISprite 货币图片
function UIAuctionSmeltPanel:GetCoin_Sp()
    if self.mCoinSp == nil then
        self.mCoinSp = self:GetCurComp("WidgetRoot/HoldIngot/Sprite2", "UISprite")
    end
    return self.mCoinSp
end

---@return UnityEngine.GameObject 排序go
function UIAuctionSmeltPanel:GetSortGo()
    if self.mSortGo == nil then
        self.mSortGo = self:GetCurComp("WidgetRoot/ToggleArea/CoinSort/Caption", "GameObject")
    end
    return self.mSortGo
end

---@return UILabel
function UIAuctionSmeltPanel:GetCaption_Lb()
    if self.mCaptionLb == nil then
        self.mCaptionLb = self:GetCurComp("WidgetRoot/ToggleArea/CoinSort/Caption/CaptionLabel", "UILabel")
    end
    return self.mCaptionLb
end

---@return TweenRotation 箭头旋转
function UIAuctionSmeltPanel:GetArrow_TweenRotation()
    if self.mArrowTween == nil then
        self.mArrowTween = self:GetCurComp("WidgetRoot/ToggleArea/CoinSort/Caption/Btn_program", "TweenRotation")
    end
    return self.mArrowTween
end

---@return UnityEngine.GameObject 关闭排序go
function UIAuctionSmeltPanel:GetCloseSortGo()
    if self.mCloseSortGo == nil then
        self.mCloseSortGo = self:GetCurComp("WidgetRoot/ToggleArea/CoinSort/Sort", "GameObject")
    end
    return self.mCloseSortGo
end

---@return UIGridContainer 排序container
function UIAuctionSmeltPanel:GetSortContainer()
    if self.mCloseSortGo == nil then
        self.mCloseSortGo = self:GetCurComp("WidgetRoot/ToggleArea/CoinSort/Sort", "UIGridContainer")
    end
    return self.mCloseSortGo
end

---@return UIInput 查询文本
function UIAuctionSmeltPanel:GetSearch_UIInput()
    if self.mSearchInput == nil then
        self.mSearchInput = self:GetCurComp("WidgetRoot/ToggleArea/Search", "UIInput")
    end
    return self.mSearchInput
end

---@return UnityEngine.GameObject 查询go
function UIAuctionSmeltPanel:GetSearch_Go()
    if self.mSearchGo == nil then
        self.mSearchGo = self:GetCurComp("WidgetRoot/ToggleArea/Search/search_btn", "GameObject")
    end
    return self.mSearchGo
end

---@return UnityEngine.Vector3 背包位置
function UIAuctionSmeltPanel:GetBagPos()
    if self.mBagPos == nil then
        local mainChatPanel = uimanager:GetPanel("UIMainChatPanel")
        if mainChatPanel then
            self.mBagPos = mainChatPanel.btn_bag.transform.position
        end
    end
    return self.mBagPos
end

---@return UnityEngine.Vector3 邮件位置
function UIAuctionSmeltPanel:GetMainPos()
    if self.mMailPos == nil then
        ---@type UIMainChatPanel
        local mainChatPanel = uimanager:GetPanel("UIMainChatPanel")
        if mainChatPanel then
            self.mMailPos = mainChatPanel.btn_social.transform.position
        end
    end
    return self.mMailPos
end

---@return UnityEngine.GameObject 没有东西
function UIAuctionSmeltPanel:GetNothing_GO()
    if self.mNothingGo == nil then
        self.mNothingGo = self:GetCurComp("WidgetRoot/ItemsArea/NoneTips", "GameObject")
    end
    return self.mNothingGo
end

--endregion

--region 初始化
function UIAuctionSmeltPanel:Init()
    self.needInitLoop = true
    self:BindMessage()
    self:BindEvent()
    self:InitCoin()
    self:InitSort()
end

---@param customData AuctionSmeltPanelData
function UIAuctionSmeltPanel:Show(customData)
    self.mCurrentChooseTemplate = {}
    self.mLidToChoose = {}
    self.mMaxPage = 1
    self.ChooseSort = false
    self:SetArrowShow()
    self:ChooseSortType(LuaEnumAuctionTradeSortType.TimeDown, false)
    self:CloseChooseSort()
    if customData and customData.mSelectItemNameData then
        self.mSelectItemNameData = customData.mSelectItemNameData

    end
end

function UIAuctionSmeltPanel:BindMessage()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.AuctionSmeltMenuChange, function(id, data)
        if self.go.activeSelf then
            self:ChooseMenuChange(data)
        end
    end)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.TryBuySmeltItem, function(id, data)
        if self.go.activeSelf then
            self:BuySingleItem(data)
        end
    end)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.SmeltBuyNumItem, function(id, data)
        self.mBuyNum = data
    end)

    ---@param csData auctionV2.AuctionItemList
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGetAuctionItemsMessage, function(msgID, tblData, csData)
        if self.go.activeSelf then
            self:ReceivedSmeltData(csData)
        end
    end)

    ---@param csData auctionV2.SearchAuctionItemResponse
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResAuctionSearchMessage, function(msgID, tblData, csData)
        if self.go.activeSelf then
            self:ReceivedSmeltData(csData.list)
        end
    end)

    ---@param csData auctionV2.ItemMsg
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBuyAuctionItemMessage, function(msgID, tblData, csData)
        if self.go.activeSelf then
            self:RefreshCurrentSmeltPage()
            self:FlyItem(csData.item)
        end
    end)

    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        self:RefreshCoin()
    end)
end

function UIAuctionSmeltPanel:BindEvent()
    CS.UIEventListener.Get(self:GetSelfSmeltBtn_GO()).onClick = function()
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Bag_Recycl)
    end
    CS.UIEventListener.Get(self:GetCoin_Sp().gameObject).onClick = function()
        if self.mCoinType then
            local itemInfo = self:GetItemInfoCache(self.mCoinType)
            if itemInfo then
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo })
            end
        end
    end
    CS.UIEventListener.Get(self:GetSortContainer().gameObject).onClick = function()
        self:CloseChooseSort()
    end
    CS.UIEventListener.Get(self:GetSortGo()).onClick = function()
        self:ShowChooseSort()
    end
    CS.UIEventListener.Get(self:GetSearch_Go()).onClick = function()
        self:OnSearchClicked()
    end
end

function UIAuctionSmeltPanel:DealSearchData()
    if self.mSelectItemNameData then
        self:GetSearch_UIInput().value = self.mSelectItemNameData.mName
        --self:AddNeedChooseItemId(self.mSelectItemNameData.mItemId)
        self.mSelectItemNameData = nil
    end
end

--endregion

--region 刷新熔炼数据显示
---@param csData auctionV2.AuctionItemList
function UIAuctionSmeltPanel:ReceivedSmeltData(csData)
    if csData and csData.page then
        if not CS.StaticUtility.IsNull(self:GetNothing_GO()) then
            self:GetNothing_GO():SetActive(csData.toatlPageCount == 0)
        end
        self.PageToInfo[csData.page] = csData
        self.mMaxPage = csData.toatlPageCount
        if self.needInitLoop then
            self:InitSmeltShow()
            self.needInitLoop = false
        else
            self:GetSmelt_LoopScrollViewPlus():RefreshCurrentPage()
        end
    end

end

function UIAuctionSmeltPanel:InitSmeltShow()
    if self.mSmeltData then
        self:GetSmelt_LoopScrollViewPlus():Init(function(go, line)
            local container = CS.Utility_Lua.Get(go.transform, "UIGridItem", "UIGridContainer")
            return self:RefreshSmeltLine(container, line)
        end, function(line)
            self.mTopLine = line
        end)
    end
end

---刷新交易每一行数据
function UIAuctionSmeltPanel:RefreshSmeltLine(container, line)
    self:DataManage(line)
    local lineData = self:GetSmeltItemData(line)
    if #lineData > 0 then
        if not CS.StaticUtility.IsNull(container) then
            container.MaxCount = #lineData
            for i = 1, #lineData do
                ---@type auctionV2.AuctionItemInfo
                local data = lineData[i]
                local lid = data.item.lid
                local itemId = data.item.itemId
                local go = container.controlList[i - 1]
                local template = self:GetGridTemplate(go)
                if template then
                    template:RefreshUI(data)
                    if self:IsItemNeedChoose(itemId) then
                        self.mLidToChoose[lid] = true
                        template:SetItemChoose(true)
                        table.insert(self.mCurrentChooseTemplate, template)
                    else
                        template:SetItemChoose(false)
                    end
                end
            end
            return true
        end
    end
    return false

end

---@return UIAuctionSmeltPanel_BuyGridTemplate 拍卖行交易格子模板
function UIAuctionSmeltPanel:GetGridTemplate(go)
    if self.mGridToTemplate == nil then
        self.mGridToTemplate = {}
    end
    local template = self.mGridToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIAuctionSmeltPanel_BuyGridTemplate, self)
        self.mGridToTemplate[go] = template
    end
    return template
end

---@return table<number,auctionV2.AuctionItemInfo>  获取交易显示数据（一行的数据）
function UIAuctionSmeltPanel:GetSmeltItemData(line)
    local tableDataList = self.PageToInfo
    local list = {}
    if tableDataList then
        local page = math.floor((line * self.mLineNum) / self.mMaxCountPrePage) + 1
        local pageData = tableDataList[page]
        if pageData and pageData.items then
            local listLength = pageData.items.Count
            if listLength then
                local index = (line * self.mLineNum) % (self.mMaxCountPrePage)
                for i = index, index + self.mLineNum - 1 do
                    if listLength > i and pageData.items[i] then
                        table.insert(list, pageData.items[i])
                    end
                end
            end
        end
    end
    return list
end

---数据控制请求
function UIAuctionSmeltPanel:DataManage(line)
    local page = math.floor((line * self.mLineNum) / self.mMaxCountPrePage) + 1
    if self.PageToInfo[page] then
        return
    end
    self:ReqSmeltData(page, false)
    if page - 5 > 0 then
        self.PageToInfo[page - 5] = nil
    end
    self.PageToInfo[page + 5] = nil

end

function UIAuctionSmeltPanel:ClearData()
    self.needInitLoop = true
    self.PageToInfo = {}
end

---购买返回
function UIAuctionSmeltPanel:RefreshCurrentSmeltPage()
    if self.mTopLine then
        local page = math.floor(self.mTopLine / (self.mMaxCountPrePage / self.mLineNum)) + 1
        self:ReqSmeltData(page, true)
        self:ReqSmeltData(page + 1, true)
    end
end

--endregion

--region 刷新货币
function UIAuctionSmeltPanel:InitCoin()
    if self.mCoinType then
        local iconInfo = self:GetItemInfoCache(self.mCoinType)
        if iconInfo then
            self:GetCoin_Sp().spriteName = iconInfo.icon
        end
    end
    self:RefreshCoin()
end

function UIAuctionSmeltPanel:RefreshCoin()
    if self:GetBagInfoV2() then
        local coin = self:GetBagInfoV2():GetCoinAmount(self.mCoinType)
        if coin then
            self:GetCoin_Lb().text = coin
        end
    end
end
--endregion

--region 刷新选项
---初始化排序
function UIAuctionSmeltPanel:InitSort()
    if self.mTypeToToggle == nil then
        self.mTypeToToggle = {}
    end
    self:GetSortContainer().MaxCount = #self.mSortTypeMenu
    for i = 0, self:GetSortContainer().controlList.Count - 1 do
        local type = self.mSortTypeMenu[i + 1]
        local go = self:GetSortContainer().controlList[i]
        local toggle = CS.Utility_Lua.GetComponent(go.transform, "UIToggle")
        ---@type UILabel
        local typeLabel = CS.Utility_Lua.Get(go.transform, "LabelValue", "UILabel")
        typeLabel.text = self.mSortType[type]
        CS.EventDelegate.Add(toggle.onChange, function()
            if toggle.value then
                typeLabel.text = self.mSortType[type]
                typeLabel.effectStyle = CS.UILabel.Effect.Outline
                self:ChooseSortType(type, true)
            else
                typeLabel.text = "[878787]" .. self.mSortType[type]
                typeLabel.effectStyle = CS.UILabel.Effect.None
            end
        end)
        CS.UIEventListener.Get(go).onClick = function()
            self:CloseChooseSort()
        end
        self.mTypeToToggle[type] = toggle
    end
end

---显示排序
function UIAuctionSmeltPanel:ShowChooseSort()
    self.ChooseSort = true
    self:SetArrowShow()
    self:GetSortContainer().gameObject:SetActive(true)
    local toggle = self.mTypeToToggle[self.mCurrentSortType]
    if toggle then
        toggle:Set(true)
    end
end

---关闭排序
function UIAuctionSmeltPanel:CloseChooseSort()
    self.ChooseSort = false
    self:SetArrowShow()
    self:GetSortContainer().gameObject:SetActive(false)
end

---选择排序
function UIAuctionSmeltPanel:ChooseSortType(type, needReq)
    self:ClearData()
    if self.mCurrentSortType ~= type then
        self.mCurrentSortType = type
        if needReq then
            self:ReqSmeltData(1, true)
        end
        self:SetMainShow(type)
    end
end

function UIAuctionSmeltPanel:SetMainShow(type)
    self:GetCaption_Lb().text = self.mSortType[type]
end

function UIAuctionSmeltPanel:SetArrowShow()
    if self.ChooseSort then
        self:GetArrow_TweenRotation():PlayForward()
    else
        self:GetArrow_TweenRotation():PlayReverse()
    end
end
--endregion

--region 消息请求
---点击搜索
function UIAuctionSmeltPanel:OnSearchClicked(page)
    self:ResetData()
    self:DealThirdMenuInfo()
    local matchesString = self:GetSearch_UIInput().value
    if matchesString == "" then
        self:NetReq(1)
        return
    end
    if page == nil then
        self:ClearData()
    end

    local minLv = self.minLv
    local maxLv = self.maxLv
    local career = self.career
    local sex = self.sex
    ---@type auctionV2.GetAuctionItemsRequest
    local info = CS.auctionV2.GetAuctionItemsRequest()
    info.page = ternary(page == nil or page == 0, 1, page)
    info.minLevel = minLv
    info.maxLevel = maxLv
    info.currency = -1
    info.sex = sex
    info.career = career
    info.toatlPageCount = -1
    if self.firstMenuID == -1 or self.firstMenuID == 0 then
        info.screenCondition:Add(0)
    else
        info.screenCondition:Add(self.firstMenuID)
        if self.secondMenuId ~= -1 then
            info.screenCondition:Add(self.secondMenuId)
        end
        for i = 1, #self.mOtherIds do
            local id = self.mOtherIds[i]
            if id ~= -1 then
                info.screenCondition:Add(id)
            end
        end
    end
    info.itemType = 4

    local type = self.mCurrentSortType
    --true 是 升序
    if type == LuaEnumAuctionTradeSortType.PriceUp then
        self.mHighToLow = true
        self.sortBy = LuaEnumAuctionPanelSortType.Price
    elseif type == LuaEnumAuctionTradeSortType.PriceDown then
        self.mHighToLow = false
        self.sortBy = LuaEnumAuctionPanelSortType.Price
    elseif type == LuaEnumAuctionTradeSortType.TimeUp then
        self.mHighToLow = false
        self.sortBy = LuaEnumAuctionPanelSortType.PutOnTime
    elseif type == LuaEnumAuctionTradeSortType.TimeDown then
        self.mHighToLow = true
        self.sortBy = LuaEnumAuctionPanelSortType.PutOnTime
    end
    local sortType = uiStaticParameter.mAuctionSortType[self.sortBy]

    info.sortBy = sortType
    info.sort = self.mPriceHighToLow
    info.propertyTendency = self.CareerPropertyTendency
    networkRequest.ReqAuctionSearch(matchesString, info)
end

---@param needRefresh boolean 是否需要强制刷新
function UIAuctionSmeltPanel:ReqSmeltData(page, needRefresh)
    if not needRefresh then
        if page == self.mCurrentReqPage then
            return
        end
    end
    self.mCurrentReqPage = page
    if page <= self.mMaxPage then
        self:NetReq(page)
    end
end

---请求数据
function UIAuctionSmeltPanel:NetReq(page)
    self:ResetData()
    self:DealThirdMenuInfo()
    local matchesString = self:GetSearch_UIInput().value
    if not CS.StaticUtility.IsNullOrEmpty(matchesString) then
        self:OnSearchClicked(page)
        return
    end
    local pageIndex = ternary(page == nil or page == 0, 1, page)
    local minLv = self.minLv
    local maxLv = self.maxLv
    local career = self.career
    local sex = self.sex
    local list = CS.auctionV2.GetAuctionItemsRequest().screenCondition
    if list ~= nil then
        if self.firstMenuID == -1 or self.firstMenuID == 0 then
            list:Add(0)
        else
            list:Add(self.firstMenuID)
            if self.secondMenuId ~= -1 then
                list:Add(self.secondMenuId)
            end
            for i = 1, #self.mOtherIds do
                local id = self.mOtherIds[i]
                if id ~= -1 then
                    list:Add(id)
                end
            end
        end
        --[[        for k, v in pairs(self.mFiveChoose) do
                    list:Add(v)
                end]]
    end
    local itemType = 4

    local type = self.mCurrentSortType
    --true 是 升序
    if type == LuaEnumAuctionTradeSortType.PriceUp then
        self.mHighToLow = true
        self.sortBy = LuaEnumAuctionPanelSortType.Price
    elseif type == LuaEnumAuctionTradeSortType.PriceDown then
        self.mHighToLow = false
        self.sortBy = LuaEnumAuctionPanelSortType.Price
    elseif type == LuaEnumAuctionTradeSortType.TimeUp then
        self.mHighToLow = false
        self.sortBy = LuaEnumAuctionPanelSortType.PutOnTime
    elseif type == LuaEnumAuctionTradeSortType.TimeDown then
        self.mHighToLow = true
        self.sortBy = LuaEnumAuctionPanelSortType.PutOnTime
    end
    local sortType = uiStaticParameter.mAuctionSortType[self.sortBy]
    networkRequest.ReqGetAuctionItems(pageIndex, minLv, maxLv, -1, sex, career, -1, list, itemType, sortType, self.mHighToLow, self.CareerPropertyTendency, 0)
end

---选中目录改变
function UIAuctionSmeltPanel:ChooseMenuChange(data)
    self:ClearSearchInfo()
    self:DealSearchData()
    self:ClearData()
    if data then
        self.mMaxPage = 1
        self.firstMenuID = data.firstMenuId
        self.secondMenuId = data.secondMenuId
        ---@type table<number,UIAuctionDropDown_SmeltSortTemplate>
        self.thirdMenuIds = data.mThirdTemplates
        self.mSmeltData = 1
        self:ReqSmeltData(1, true)
    end
end

---清除搜索信息
function UIAuctionSmeltPanel:ClearSearchInfo()
    self:GetSearch_UIInput().value = ""
end

function UIAuctionSmeltPanel:DealThirdMenuInfo()
    self.mOtherIds = {}
    if self.thirdMenuIds and #self.thirdMenuIds > 0 then
        for i = 1, #self.thirdMenuIds do
            local id = self.thirdMenuIds[i].mCurrentSortType
            local info = self:CacheTradeTypeTableInfo(id)
            if info and info.param then
                local param = info.param
                local datas = string.Split(param, '&')
                if #datas >= 2 then
                    local type = tonumber(datas[1])
                    local data = datas[2]
                    if type == 1 then
                        --使用等级
                        self:AnalysisLevel(type, data)
                    elseif type == 2 then
                        --转生等级
                        self:AnalysisLevel(type, data)
                    elseif type == 3 then
                        --性别
                        self:AnalysisSex(data)
                    elseif type == 4 then
                        --职业
                        self:AnalysisCareer(data)
                    elseif type == 5 then
                        self:AnalysisSpecialCareer(data)
                    end
                else
                    table.insert(self.mOtherIds, id)
                end
            else
                table.insert(self.mOtherIds, id)
            end
        end
    end
end

function UIAuctionSmeltPanel:ResetData()
    self.minLv = -1
    self.maxLv = -1
    self.sex = -1
    self.career = -1
    self.CareerPropertyTendency = -1
end

--region 设置职业等级等数据
---解析等级
function UIAuctionSmeltPanel:AnalysisLevel(type, data)
    if type == 2 then
        --转生等级
        local reinLvelList = string.Split(data, '#')
        self.minLv = tonumber(reinLvelList[1]) * 1000
        self.maxLv = tonumber(reinLvelList[2]) * 1000
    else
        --等级
        local levelList = string.Split(data, '#')
        self.minLv = tonumber(levelList[1])
        self.maxLv = tonumber(levelList[2])
    end
end

---解析性别
function UIAuctionSmeltPanel:AnalysisSex(data)
    self.sex = tonumber(data)
end

---解析职业
function UIAuctionSmeltPanel:AnalysisCareer(data)
    self.career = tonumber(data)
end

---解析职业偏向
function UIAuctionSmeltPanel:AnalysisSpecialCareer(data)
    self.CareerPropertyTendency = tonumber(data)
end
--endregion
--endregion

--region icon购买单个道具

---将要购买道具
---@type auctionV2.AuctionItemInfo
UIAuctionSmeltPanel.mCurrentWillBuyItemInfo = nil

---点击icon的购买
function UIAuctionSmeltPanel:BuySingleItem(data)
    local bagItemLid = data.lid
    local go = data.go
    if self.mCurrentWillBuyItemInfo and bagItemLid == self.mCurrentWillBuyItemInfo.item.lid then
        local price = self.mCurrentWillBuyItemInfo.price.count
        if not self:IsCostEnough(price) then
            local itemInfoPanel = uimanager:GetPanel("UIItemInfoPanel");
            if (itemInfoPanel ~= nil) then
                --local panelCount = itemInfoPanel:GetPanelGridContainer().MaxCount;

                --[[                if (panelCount > 1) and coinInfo then
                                    local str = coinInfo.name .. "不足"
                                    Utility.ShowPopoTips(go, str, 23)
                                else
                                    Utility.ShowItemGetWay(self.mCoinType, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(60, 0))
                                end]]
            end
            local coinInfo = self:GetItemInfoCache(self.mCoinType)
            local str = coinInfo.name .. "不足"
            Utility.ShowPopoTips(go, str, 23)
            return
        end
        ---背包空间是否足够
        if not CS.CSScene.MainPlayerInfo.BagInfo:CheckIsAbleToAddItemOfNumbers(self.mCurrentWillBuyItemInfo.item.ItemTABLE, 1) then
            Utility.ShowPopoTips(go, nil, 422, "UIItemInfoPanel")
            return
        end
        local lid = self.mCurrentWillBuyItemInfo.item.lid
        networkRequest.ReqBuyAuctionAuction(lid, 1, 4)
        self.mBuyNum = 1
        uimanager:ClosePanel("UIPetInfoPanel")
        uimanager:ClosePanel("UIItemInfoPanel")
    end
end

---购买货币是否足够
function UIAuctionSmeltPanel:IsCostEnough(price)
    local isEnough = false
    if price and self:GetBagInfoV2() then
        local selfCost = self:GetBagInfoV2():GetCoinAmount(self.mCoinType)
        isEnough = selfCost >= math.ceil(price)
    end
    return isEnough
end
--endregion

--region 设置道具飞背包
---设置可能购买道具信息
function UIAuctionSmeltPanel:SetBuyItemInfo(itemId, position)
    self.mChooseItemId = itemId
    self.mChooseItemPos = position
    self.mCurrentBagGridCount = self:GetBagInfoV2().EmptyGridCount
    self.mCurrentBagHasItem = self:GetBagInfoV2():GetItemCountByItemId(itemId)
end

---@param bagItemInfo bagV2.BagItemInfo
function UIAuctionSmeltPanel:FlyItem(bagItemInfo)
    if bagItemInfo and self.mChooseItemId and self.mChooseItemId == bagItemInfo.itemId then
        local pos = self:GetCurrentTimeAimPos(self.mChooseItemId)
        if self.mChooseItemId and self.mChooseItemPos and pos then
            luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = self.mChooseItemId, from = self.mChooseItemPos, to = pos })
            self.mChooseItemId = nil
            self.mChooseItemPos = nil
            self.mCurrentBagGridCount = 0
        end
    end
end

---获取道具目标位置
function UIAuctionSmeltPanel:GetCurrentTimeAimPos(itemId)
    local data = self:GetItemInfoCache(itemId)
    if data then
        local count = self.mCurrentBagGridCount
        local bagHas = self.mCurrentBagHasItem
        local leaveNum = data.overlying - bagHas % data.overlying
        local LimitBag = bagHas == 0 or (data.overlying ~= nil and bagHas ~= 0 and (leaveNum == data.overlying or leaveNum < self.mBuyNum))
        local isFlyMail = count == 0 and LimitBag
        return ternary(isFlyMail, self:GetMainPos(), self:GetBagPos())
    else
        if isOpenLog then
            luaDebug.LogError("购买道具飞入背包的道具id是" .. tostring(itemId) .. "没有获取正确数据")
        end
    end
end
--endregion

--region 设置道具选中
function UIAuctionSmeltPanel:AddNeedChooseItemId(itemID)
    if self.mNeedChooseItemList == nil then
        self.mNeedChooseItemList = {}
    end
    local data = {}
    data.itemId = itemID
    data.isChoose = false
    table.insert(self.mNeedChooseItemList, data)
end

---@return boolean 该道具是否需要选中
function UIAuctionSmeltPanel:IsItemNeedChoose(itemId)
    if self.mNeedChooseItemList then
        for i = 1, #self.mNeedChooseItemList do
            local data = self.mNeedChooseItemList[i]
            if data and data.itemId == itemId and data.isChoose == false then
                data.isChoose = true
                return true
            end
        end
    end
    return false
end

function UIAuctionSmeltPanel:CloseAllChoose()
    if self.mCurrentChooseTemplate then
        for i = 1, #self.mCurrentChooseTemplate do
            local template = self.mCurrentChooseTemplate[i]
            if template and CS.StaticUtility.IsNull(template.go) == false then
                template:SetItemChoose(false)
            end
        end
        self.mCurrentChooseTemplate = nil
    end
end



--endregion

return UIAuctionSmeltPanel