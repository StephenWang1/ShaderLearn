---拍卖行交易界面
---@class UIAuctionPanel_TradePanel:TemplateBase
local UIAuctionPanel_TradePanel = {}

UIAuctionPanel_TradePanel.CareerToTradeId = {
    [CS.ECareer.Warrior] = 107,
    [CS.ECareer.Master] = 108,
    [CS.ECareer.Taoist] = 109,
}

UIAuctionPanel_TradePanel.mCurrentChooseGuessLikeChange = nil

--region 局部变量
---@type table<number,auctionV2.AuctionItemInfo> 页数对应信息
UIAuctionPanel_TradePanel.PageToInfo = {}

---@type table<UnityEngine.GameObject,UIAuctionGridItem> 格子对应模板
UIAuctionPanel_TradePanel.GoToTemplate = {}

---当前页
UIAuctionPanel_TradePanel.mCurrentPage = nil

---强制重刷新
UIAuctionPanel_TradePanel.mNeedRefreshAll = false

---强制刷新当前页
UIAuctionPanel_TradePanel.mNeedRefreshCurrentPage = false

---是否是老数据
UIAuctionPanel_TradePanel.mIsOldData = false

---@type table<number,boolean> lid 对应选中
UIAuctionPanel_TradePanel.mLidToChoose = {}

---@type table<number,boolean> lid 对应猜你喜欢选中
UIAuctionPanel_TradePanel.mLidToGuessLikeChoose = {}

---@type table<number,UIAuctionGridItem>  lid 对应格子模板
UIAuctionPanel_TradePanel.mLidToTemplate = nil

---是否需要开启所有选中框
UIAuctionPanel_TradePanel.mIsNeeOpenAllEffect = false

---是否需要开启第一个选中框
UIAuctionPanel_TradePanel.mIsNeeOpenFirstEffect = false

---当前选中第一个道具
UIAuctionPanel_TradePanel.mCurrentChooseFirstItem = nil

---组件页数对应Obj
---@type table<number,UnityEngine.GameObject>
UIAuctionPanel_TradePanel.mPageToObj = {}

---交易货币类型
---@type number
UIAuctionPanel_TradePanel.mCoinType = LuaEnumCoinType.YuanBao

---钻石货币
---@type number
UIAuctionPanel_TradePanel.mDiamondCoin = LuaEnumCoinType.Diamond

---@type number
---每行个数
UIAuctionPanel_TradePanel.mLineNum = 3

---每页12条，刷新超过n*12条时请求下一页
UIAuctionPanel_TradePanel.mMaxCountPrePage = 12

---最后一行行数
UIAuctionPanel_TradePanel.finalLine = 0

---每页对应数据
---@type table<number, auctionV2.GuessYouLikeResponse>
UIAuctionPanel_TradePanel.mPageTOGuessData = {}

---猜你喜欢总页数
UIAuctionPanel_TradePanel.GuessTotalPage = 2

---是否刷新
UIAuctionPanel_TradePanel.hasRefresh = false

--endregion

--region 属性
---@return UIAuctionPanel_TradePanel_Menu 交易目录模板
function UIAuctionPanel_TradePanel:GetMenuControllerTemplate()
    if self.mMenuController == nil then
        self.mMenuController = templatemanager.GetNewTemplate(self.toggleRoot_GameObject, luaComponentTemplates.UIAuctionPanel_TradePanel_Menu, self)
    end
    return self.mMenuController
end
--endregion

--region 初始化
---@param panel UIAuctionPanel
function UIAuctionPanel_TradePanel:Init(panel)
    self.mLidToTemplate = {}
    self.mPageTOGuessData = {}
    self.mPageTOTradeData = {}
    self.AuctionPanel = panel
    self.mLidToChoose = {}
    self.mLidToGuessLikeChoose = {}
    self:InitComponent()
    self:InitCoinInfo()
    self:BindEvents()
end

function UIAuctionPanel_TradePanel:InitComponent()
    self.toggleRoot_GameObject = self:Get("ToggleArea", "GameObject")
    self.sellButton_GameObject = self:Get("SellBtn", "GameObject")

    --region 货币
    --元宝
    self.money_UILabel = self:Get("HoldIngot", "UILabel")
    self.money_UISprite = self:Get("HoldIngot/Sprite2", "UISprite")
    self.money_GameObject = self:Get("HoldIngot/Sprite2", "GameObject")
    --钻石
    self.mDiamond_UILabel = self:Get("Diamond", "UILabel")
    self.mDiamond_UISprite = self:Get("Diamond/Sprite2", "UISprite")
    self.mDiamond_GameObject = self:Get("Diamond/Sprite2", "GameObject")
    --钻石额度
    self.mDiamondQuota_UILabel = self:Get("DiamondQuota", "UILabel")
    self.mDiamondQuota_UISprite = self:Get("DiamondQuota/Sprite2", "UISprite")
    self.mDiamondQuota_GameObject = self:Get("DiamondQuota/Sprite2", "GameObject")
    --endregion

    self.gridRoot_GameObject = self:Get("ItemsArea/Scroll View", "GameObject")
    ---@type UIScrollView
    ---Scroll
    self.gridRoot_ScrollView = self:Get("ItemsArea/Scroll View", "UIScrollView")

    ---@type UnityEngine.GameObject
    ---无数据图片
    self.nothingSprite = self:Get("ItemsArea/NoneTips", "GameObject")

    ---@type UILoopScrollViewPlus
    self.mLoopScrollViewPlus = self:Get("ItemsArea/Scroll View/LoopScrollViewPlus", "UILoopScrollViewPlus")

    ---@type UILoopScrollViewPlus
    self.mLoopScrollViewPlusTrade = self:Get("ItemsArea/Scroll View/LoopScrollViewPlusTrade", "UILoopScrollViewPlus")
    ---@type UnityEngine.GameObject 猜你喜欢Go
    self.mGuessGo = self:Get("ToggleArea/text", "GameObject")

end

---初始化货币信息
function UIAuctionPanel_TradePanel:InitCoinInfo()
    local res

    res, self.mIconInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mCoinType)
    if res then
        self.money_UISprite.spriteName = self.mIconInfo.icon
    end

    res, self.mDiamondInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mDiamondCoin)
    if res then
        self.mDiamond_UISprite.spriteName = self.mDiamondInfo.icon
    end

    res, self.mDiamondQuotaInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(1000023)
    if res then
        self.mDiamondQuota_UISprite.spriteName = self.mDiamondQuotaInfo.icon
    end
end

function UIAuctionPanel_TradePanel:BindEvents()
    CS.UIEventListener.Get(self.sellButton_GameObject).onClick = function()
        self:OnSellButtonClicked()
    end

    CS.UIEventListener.Get(self.money_GameObject).onClick = function()
        if self.mIconInfo then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.mIconInfo })
        end
    end
    CS.UIEventListener.Get(self.mDiamond_GameObject).onClick = function()
        if self.mDiamondInfo then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.mDiamondInfo })
        end
    end

    self.mDiamondQuota_UILabel.gameObject:SetActive(Utility.IsAuctionDiamondQuotaOpen)
    CS.UIEventListener.Get(self.mDiamondQuota_GameObject).onClick = function()
        if self.mDiamondQuotaInfo then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.mDiamondQuotaInfo })
        end
    end
end

---打开界面
function UIAuctionPanel_TradePanel:ShowPanel(type, mJumpIDType)
    self.Type = type
    self:ShowGuessLikePanel(type == luaEnumAuctionPanelType.Guess)
    local id
    if type == luaEnumAuctionPanelType.Guess then
        id = -1
        self:RefreshAllData(1)
        self.RefreshGuessLike = false
    else
        id = 0
    end
    if mJumpIDType then
        id = mJumpIDType
    end
    self:GetMenuControllerTemplate():OpenPage(id)
    self:RefreshCoinShow()
end

---根据搜索字段筛选所有该道具
function UIAuctionPanel_TradePanel:ShowPanelWithSelectItemName(showName, itemId, needChooseFirstItem)
    if needChooseFirstItem and itemId then
        self:AddNeedChooseItemId(itemId, luaEnumAuctionPanelType.Trade)
    end
    self:ShowGuessLikePanel(false)
    self:GetMenuControllerTemplate():SelectSpecialItem(showName)
    self:RefreshCoinShow()
end

--endregion

--region 服务器消息
---购买返回消息
function UIAuctionPanel_TradePanel:PurchaseResultCallBack()
    uimanager:ClosePanel('UIAuctionDialog')
    if self.AuctionPanel.IsCurrentShowLike then
        if self.mCurrentChooseFirstItem then
            self:SetGuessLikeItemChoose(self.mCurrentChooseFirstItem, false)
        end
        self:RefreshGuessLikeCurrentPage()
    else
        self:RefreshCurrentPage()
    end
end
--endregion

--region 数据相关
---刷新货币显示
function UIAuctionPanel_TradePanel:RefreshCoinShow()
    local value = self.AuctionPanel:GetBagInfoV2():GetAuctionIngotNum()
    self.money_UILabel.text = value
    self.mDiamond_UILabel.text = Utility.GetAuctionDiamondNum()
    local diamondQuota = self.AuctionPanel:GetPlayerInfo().Data.auctionDiamond
    if diamondQuota then
        self.mDiamondQuota_UILabel.text = diamondQuota
    end
end

---设置某个格子选中
function UIAuctionPanel_TradePanel:SetItemChoose(lid, isChoose)
    self.mLidToChoose[lid] = isChoose
    local template = self.mLidToTemplate[lid]
    if template then
        template:SetItemChoose(isChoose)
    end
end

---设置猜你喜欢道具选中
function UIAuctionPanel_TradePanel:SetGuessLikeItemChoose(lid, isChoose)
    self.mLidToGuessLikeChoose[lid] = isChoose
    local template = self.mLidToTemplate[lid]
    if template then
        template:SetItemChoose(isChoose)
    end
end

---选中第一个格子
function UIAuctionPanel_TradePanel:SetFirstItemChoose()
    self.mIsNeeOpenFirstEffect = true
end

---选中所有格子
function UIAuctionPanel_TradePanel:SelectAllItemChoose(isopen)
    UIAuctionPanel_TradePanel.mIsNeeOpenAllEffect = isopen
end

--endregion

--region UI事件
---点击出售
function UIAuctionPanel_TradePanel:OnSellButtonClicked()
    if self.AuctionPanel then
        self.AuctionPanel:SwitchToSellPanel()
        self.AuctionPanel:RemoveTradeBubbleTips()
    end
end

---设置三级页签选中（在推送的情况下）
---此功能暂时关闭（不确定会不会加回来）
function UIAuctionPanel_TradePanel:ChooseThirdType()
    self:SetNeedRefresh()
    local chooseInfo = CS.Cfg_GlobalTableManager.Instance:GetAuctionPushChooseMenuId()
    if chooseInfo and chooseInfo.Length >= 2 then
        local FirstMenuId = chooseInfo[0]
        local needChoose = {}
        local career = CS.CSScene.MainPlayerInfo.Career
        needChoose[14] = self.CareerToTradeId[career]--三级页签14选相同职业
        needChoose[15] = chooseInfo[1]--三级页签15选相同等级
        self:GetMenuControllerTemplate():OpenPage(1, nil, needChoose)
    end
end
--endregion

--region 猜你喜欢
function UIAuctionPanel_TradePanel:InitGuessLikeComp()
    self.mLoopScrollViewPlus:Init(function(go, line)
        local container = CS.Utility_Lua.Get(go.transform, "UIGridItem", "UIGridContainer")
        local btn = CS.Utility_Lua.Get(go.transform, "btn", "GameObject")
        return self:RefreshSingleLine(container, btn, line)
    end, function(line)
        self.mGuessLikeTopLine = line
    end)
end

---@param csData auctionV2.GuessYouLikeResponse 猜你喜欢响应
function UIAuctionPanel_TradePanel:RefreshGuessYouLike(csData)
    if csData and csData.items and csData.items.Count > 0 and csData.totalPage ~= 0 then
        self.mPageTOGuessData[csData.page] = csData
        self.finalLine = 0
        self.GuessTotalPage = csData.totalPage
        if not self.RefreshGuessLike and csData.totalPage ~= 0 then
            self:InitGuessLikeComp()
            self.RefreshGuessLike = true
        end
        self.mLoopScrollViewPlus:RefreshCurrentPage()
        if (csData.page < csData.totalPage) then
            self:ReqGuessYouLikePageData(csData.page + 1, 2)
        end
    end
    if csData.totalPage == 0 and csData.itemType ~= 0 then
        self:ShowAll()
    end
    self.nothingSprite:SetActive(false)
end

---@param line number 第几行
---@return auctionV2.AuctionItemInfo 拍卖行数据
function UIAuctionPanel_TradePanel:GetAuctionGuessItemData(line)
    return self:GetLineDataFormTable(self.mPageTOGuessData, line)
end

---刷新每一行数据
---@param container UIGridContainer 数据行
---@param btn UnityEngine.GameObject 按钮行
---@return boolean 该行是否有数据
function UIAuctionPanel_TradePanel:RefreshSingleLine(container, btn, line)
    local lineData = self:GetAuctionGuessItemData(line)
    if #lineData > 0 then
        if not CS.StaticUtility.IsNull(container) then
            container.MaxCount = #lineData
            for i = 1, #lineData do
                local go = container.controlList[i - 1]
                local template = self:GetGridTemplate(go)
                if template then
                    ---@type auctionV2.AuctionItemInfo
                    local auctionItemInfo = lineData[i]
                    local lid = auctionItemInfo.item.lid

                    self.mLidToTemplate[lid] = template
                    template:RefreshUI(auctionItemInfo)
                    if self.mLidToGuessLikeChoose[auctionItemInfo.item.lid] then
                        template:SetItemChoose(true)
                    else
                        template:SetItemChoose(false)
                    end
                    if (self:TryChooseItemByItemId(auctionItemInfo.item, luaEnumAuctionPanelType.Guess)) then
                        self:SetGuessLikeItemChoose(lid, true)
                    end
                    local itemTable = auctionItemInfo.item.ItemTABLE
                    if self.mIsNeeOpenFirstEffect and line == 0 and i == 1 and self:IsItemJULINGZHU(itemTable) then
                        self.mIsNeeOpenFirstEffect = false
                        self.mCurrentChooseFirstItem = lid
                        self:SetGuessLikeItemChoose(lid, true)
                    end
                end
            end
            btn:SetActive(false)
            container.gameObject:SetActive(true)
            return true
        end
    else
        if self.finalLine == 0 or self.finalLine == line then
            self.finalLine = line
            btn:SetActive(true)
            container.gameObject:SetActive(false)
            local showAllBtn = CS.Utility_Lua.Get(btn.transform, "LookAll", "GameObject")
            local changeBtn = CS.Utility_Lua.Get(btn.transform, "Change", "GameObject")
            CS.UIEventListener.Get(showAllBtn).onClick = function()
                self:ShowAll()
            end
            CS.UIEventListener.Get(changeBtn).onClick = function()
                --self.mCurrentChooseGuessLikeChange = CS.UnityEngine.Time.time
                self:RefreshAllData(1)
            end
            if line == 1 or line == 2 then
                local pos = btn.transform.localPosition
                pos.y = -180 + 118 * (line - 1)
                btn.transform.localPosition = pos
            else
                btn.transform.localPosition = CS.UnityEngine.Vector3.zero
            end
            return true
        else
            return false
        end
    end
end

---@return UIAuctionGridItem 拍卖行交易格子模板
function UIAuctionPanel_TradePanel:GetGridTemplate(go)
    if self.mGridToTemplate == nil then
        self.mGridToTemplate = {}
    end
    local template = self.mGridToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIAuctionGridItem, self)
        self.mGridToTemplate[go] = template
    end
    return template
end

---换一批
---默认请求两页数据
function UIAuctionPanel_TradePanel:RefreshAllData(type)
    self.mLoopScrollViewPlus:ResetPage()
    self.mPageTOGuessData = {}
    self:ReqGuessYouLikePageData(1, type)
    self.finalLine = 0
end

function UIAuctionPanel_TradePanel:RefreshGuessLikeCurrentPage()
    local page = math.floor(self.mGuessLikeTopLine / (self.mMaxCountPrePage / self.mLineNum)) + 1
    self:ReqGuessYouLikePageData(page, 2)
    self:ReqGuessYouLikePageData(page + 1, 2)
end

---查看全部
function UIAuctionPanel_TradePanel:ShowAll()
    self.AuctionPanel.IsCurrentShowLike = false
    self:ShowGuessLikePanel(false)
    self.AuctionPanel:SwitchToTradePanel()
end

---猜你喜欢数据控制，避免多次请求以及重复刷新
---第一版，以n*12为节点请求
function UIAuctionPanel_TradePanel:GuessLikeDataManage(line)
    if (line % self.mMaxCountPrePage == 0) then
        local page = math.ceil(line / self.mMaxCountPrePage + 1)
        if self.mPageTOGuessData and self.mPageTOGuessData[page] == nil then
            self:ReqGuessYouLikePageData(page, 2)
        end
    end
end

---请求猜你喜欢数据
---@param page number 页数
function UIAuctionPanel_TradePanel:ReqGuessYouLikePageData(page, type)
    if page > 0 then
        networkRequest.ReqGuessYouLike(Utility.EnumToInt(CS.auctionV2.AuctionItemType.THADED_PRODUCTS), page, 12, 1, type)
    end
end

--endregion

--region 交易面板
---初始组件
function UIAuctionPanel_TradePanel:InitTradeComp()
    self.mLoopScrollViewPlusTrade:Init(function(go, line)
        local container = CS.Utility_Lua.Get(go.transform, "UIGridItem", "UIGridContainer")
        return self:RefreshTradeLine(container, line)
    end, function(line)
        self.mTopLine = line
    end)
end

---刷新交易每一行数据
function UIAuctionPanel_TradePanel:RefreshTradeLine(container, line)
    self:TradeDataManage(line)
    local lineData = self:GetAuctionTradeItemData(line)
    if #lineData > 0 then
        if not CS.StaticUtility.IsNull(container) then
            container.MaxCount = #lineData
            for i = 1, #lineData do
                ---@type auctionV2.AuctionItemInfo
                local data = lineData[i]
                local lid = data.item.lid

                local go = container.controlList[i - 1]
                local template = self:GetGridTemplate(go)
                if template then
                    template:RefreshUI(data)
                    self.mLidToTemplate[data.item.lid] = template
                    if self.mLidToChoose[data.item.lid] then
                        template:SetItemChoose(true)
                    else
                        template:SetItemChoose(false)
                    end
                    if (self:TryChooseItemByItemId(data.item, luaEnumAuctionPanelType.Trade)) then
                        self:SetItemChoose(lid, true)

                    end
                    --如果当前你有选中先关掉

                    if self.mCurrentChooseFirstItem and self.mCurrentChooseFirstItem ~= lid then
                        self:SetItemChoose(self.mCurrentChooseFirstItem, false)
                    end
                    if self.mIsNeeOpenFirstEffect and line == 0 and i == 1 then
                        self.mCurrentChooseFirstItem = lid
                        self:SetItemChoose(lid, true)
                    end

                end
            end
            return true
        end
    end
    return false
end

---@return table<number,auctionV2.AuctionItemInfo>  获取交易显示数据
function UIAuctionPanel_TradePanel:GetAuctionTradeItemData(line)
    return self:GetLineDataFormTable(self.PageToInfo, line)
end

---获取交易数据刷新
---@param csData auctionV2.AuctionItemList
function UIAuctionPanel_TradePanel:RefreshPanel(csData)
    if self.AuctionPanel.IsCurrentShowLike then
        self.AuctionPanel.IsCurrentShowLike = false
        self:ShowGuessLikePanel(false)
    end
    if csData == nil then
        return
    end

    self.PageToInfo[csData.page] = csData

    if not CS.StaticUtility.IsNull(self.nothingSprite) then
        self.nothingSprite:SetActive(csData.toatlPageCount == 0)
    end
    self.mLoopScrollViewPlusTrade:RefreshCurrentPage()
end

---数据请求控制
function UIAuctionPanel_TradePanel:TradeDataManage(line)
    local page = math.floor((line * self.mLineNum) / self.mMaxCountPrePage) + 1
    if self.PageToInfo[page] then
        return
    end
    self:ReqTradeData(page, false)
    if page - 5 > 0 then
        self.PageToInfo[page - 5] = nil
    end
    self.PageToInfo[page + 5] = nil
end

---请求页数数据
---@param needRefresh boolean 是否需要强制刷新
function UIAuctionPanel_TradePanel:ReqTradeData(page, needRefresh)
    if not needRefresh then
        if page == self.mCurrentReqPage then
            return
        end
    end
    self.mCurrentReqPage = page
    self:GetMenuControllerTemplate():NetWorkReq(page)
end

---清除当前所有数据
function UIAuctionPanel_TradePanel:ClearCurrentData()
    self.PageToInfo = {}
end

---重置界面
function UIAuctionPanel_TradePanel:SetNeedRefresh()
    self:InitTradeComp()
end

---刷新当前页信息
function UIAuctionPanel_TradePanel:RefreshCurrentPage()
    local page = math.floor(self.mTopLine / (self.mMaxCountPrePage / self.mLineNum)) + 1
    self:ReqTradeData(page, true)
    self:ReqTradeData(page + 1, true)
end

--endregion

--region通用方法
---切换面板显示
function UIAuctionPanel_TradePanel:ShowGuessLikePanel(isShow)
    self.mLoopScrollViewPlus.gameObject:SetActive(isShow)
    self:GetMenuControllerTemplate().search_UIInput.gameObject:SetActive(not isShow)
    self:GetMenuControllerTemplate().priceSort_GameObject:SetActive(not isShow)
    self:GetMenuControllerTemplate().mCoinSort_GameObject:SetActive(not isShow)
    self.mGuessGo:SetActive(isShow)
    self.mLoopScrollViewPlusTrade.gameObject:SetActive(not isShow)
end

---@return table<number,auctionV2.AuctionItemInfo>  统一处理数据 从table中取出某一行数据
function UIAuctionPanel_TradePanel:GetLineDataFormTable(tableDataList, line)
    local list = {}
    if tableDataList then
        local page = math.floor((line * self.mLineNum) / self.mMaxCountPrePage) + 1
        local pageData = tableDataList[page]
        if pageData and pageData.items then
            local listLength = pageData.items.Count
            local index = (line * self.mLineNum) % (self.mMaxCountPrePage)
            for i = index, index + self.mLineNum - 1 do
                if listLength > i and pageData.items[i] then
                    table.insert(list, pageData.items[i])
                end
            end
        end
    end
    return list
end

---是否是聚灵珠
function UIAuctionPanel_TradePanel:IsItemJULINGZHU(itemTbl)
    if itemTbl.type == luaEnumItemType.Assist and itemTbl.subType == 4 then
        return true
    end
    return false
end
--endregion

--region 设置道具选中

--region 根据道具itemId选中道具
---@param bagItemInfo bagV2.BagItemInfo
function UIAuctionPanel_TradePanel:TryChooseItemByItemId(bagItemInfo, type)
    local itemInfo = bagItemInfo.ItemTABLE
    if itemInfo then
        return self:IsItemNeedChoose(itemInfo.id, type)
    end
end

---添加需要选中itemId
---@param type number luaEnumAuctionPanelType.Guess/Trade
function UIAuctionPanel_TradePanel:AddNeedChooseItemId(itemId, type)
    if self.mNeedChooseItemIDList == nil then
        self.mNeedChooseItemIDList = {}
    end
    local data = {}
    data.itemId = itemId
    data.isChoose = false
    data.type = type
    table.insert(self.mNeedChooseItemIDList, data)
end

---判断该道具是否需要选中
---@param type number luaEnumAuctionPanelType.Guess/Trade
function UIAuctionPanel_TradePanel:IsItemNeedChoose(itemId, type)
    if self.mNeedChooseItemIDList then
        for i = 1, #self.mNeedChooseItemIDList do
            local data = self.mNeedChooseItemIDList[i]
            if not data.isChoose and data.type == type and data.itemId == itemId then
                self.mNeedChooseItemIDList[i].isChoose = true
                return true
            end
        end
    end
    return false
end
--endregion

--region 根据道具lid选中道具


--endregion
--endregion

return UIAuctionPanel_TradePanel