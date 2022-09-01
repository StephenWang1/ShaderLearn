---@class UIAuctionUnionPanel:UIBase 交易行-行会竞拍
local UIAuctionUnionPanel = {}

--region 局部变量定义
UIAuctionUnionPanel.mMaxPage = 1
---@type number
---每行个数
UIAuctionUnionPanel.mLineNum = 1

---每页12条，刷新超过n*12条时请求下一页
UIAuctionUnionPanel.mMaxCountPrePage = 4

---@type table<number,auctionV2.AuctionItemInfo> 页数对应信息
UIAuctionUnionPanel.PageToInfo = {}

UIAuctionUnionPanel.mNeedChooseItemList = nil

---@type table<number,boolean> lid 对应选中
UIAuctionUnionPanel.mLidToChoose = nil

---@type table<number,UIAuctionSmeltPanel_BuyGridTemplate> 存储当前设置过选中的模板
UIAuctionUnionPanel.mCurrentChooseTemplate = nil

---交易行请求类型
UIAuctionUnionPanel.itemType = 5

UIAuctionUnionPanel.mSelectType = {
    [LuaEnumAuctionPanelSecondMenuType.All] = Utility.EnumToInt(CS.auctionV2.SelectType.ALL),
    [LuaEnumAuctionPanelSecondMenuType.AuctionItem] = Utility.EnumToInt(CS.auctionV2.SelectType.AUCTION),
    [LuaEnumAuctionPanelSecondMenuType.BuyItem] = Utility.EnumToInt(CS.auctionV2.SelectType.SALEDIAMOND),
    [LuaEnumAuctionPanelSecondMenuType.JoinItem] = Utility.EnumToInt(CS.auctionV2.SelectType.JOINAUCTION),
}
--endregion

--region 数据缓存
---@return UIAuctionPanel
function UIAuctionUnionPanel:GetAuctionPanel()
    if self.mRootPanel == nil then
        self.mRootPanel = uimanager:GetPanel("UIAuctionPanel")
    end
    return self.mRootPanel
end

---@return TABLE.cfg_items 缓存item信息
function UIAuctionUnionPanel:GetItemInfoCache(id)
    if id == nil then
        return
    end
    if self.mItemIdToInfo == nil then
        self.mItemIdToInfo = {}
    end
    local info = self.mItemIdToInfo[id]
    if info == nil then
        info = clientTableManager.cfg_itemsManager:TryGetValue(id)
        self.mItemIdToInfo[id] = info
    end
    return info
end

---@return TABLE.CFG_ITEM_TRADETYPE 缓存目录表数据
function UIAuctionUnionPanel:CacheTradeTypeTableInfo(tradeId)
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
function UIAuctionUnionPanel:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSBagInfoV2
function UIAuctionUnionPanel:GetBagInfoV2()
    if self.mBagInfoV2 == nil and self:GetMainPlayerInfo() then
        self.mBagInfoV2 = self:GetMainPlayerInfo().BagInfo
    end
    return self.mBagInfoV2
end
--endregion

--region 组件
---@return UILoopScrollViewPlus
function UIAuctionUnionPanel:GetSmelt_LoopScrollViewPlus()
    if self.mSmeltLoop == nil then
        self.mSmeltLoop = self:GetCurComp("WidgetRoot/ItemsArea/Scroll View/UIGrid", "UILoopScrollViewPlus")
    end
    return self.mSmeltLoop
end

---@return UILabel 货币数目
function UIAuctionUnionPanel:GetCoin_Lb()
    if self.mCoinLb == nil then
        self.mCoinLb = self:GetCurComp("WidgetRoot/HoldIngot", "UILabel")
    end
    return self.mCoinLb
end

---@return UISprite 货币图片
function UIAuctionUnionPanel:GetCoin_Sp()
    if self.mCoinSp == nil then
        self.mCoinSp = self:GetCurComp("WidgetRoot/HoldIngot/Sprite2", "UISprite")
    end
    return self.mCoinSp
end

---@return UILabel
function UIAuctionUnionPanel:GetCaption_Lb()
    if self.mCaptionLb == nil then
        self.mCaptionLb = self:GetCurComp("WidgetRoot/ToggleArea/CoinSort/Caption/CaptionLabel", "UILabel")
    end
    return self.mCaptionLb
end

---@return UnityEngine.GameObject 关闭排序go
function UIAuctionUnionPanel:GetCloseSortGo()
    if self.mCloseSortGo == nil then
        self.mCloseSortGo = self:GetCurComp("WidgetRoot/ToggleArea/CoinSort/Sort", "GameObject")
    end
    return self.mCloseSortGo
end

---@return UnityEngine.Vector3 背包位置
function UIAuctionUnionPanel:GetBagPos()
    if self.mBagPos == nil then
        local mainChatPanel = uimanager:GetPanel("UIMainChatPanel")
        if mainChatPanel then
            self.mBagPos = mainChatPanel.btn_bag.transform.position
        end
    end
    return self.mBagPos
end

---@return UnityEngine.Vector3 邮件位置
function UIAuctionUnionPanel:GetMainPos()
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
function UIAuctionUnionPanel:GetNothing_GO()
    if self.mNothingGo == nil then
        self.mNothingGo = self:GetCurComp("WidgetRoot/ItemsArea/NoneTips", "GameObject")
    end
    return self.mNothingGo
end

--region 排序组件
---@return UnityEngine.GameObject 排序
function UIAuctionUnionPanel:GetSortToggle_GO()
    if self.mCloseSortGo == nil then
        self.mCloseSortGo = self:GetCurComp("WidgetRoot/ToggleArea", "GameObject")
    end
    return self.mCloseSortGo
end


--endregion

--endregion

--region 初始化
function UIAuctionUnionPanel:Init()
    self.needInitLoop = true
    self:InitCoinComp()
    self:InitCoinInfo()
    self:GetTitlePartTemplate()
    self:BindMessage()
    self:BindEvent()
end

function UIAuctionUnionPanel:InitCoinComp()
    self.money_UILabel = self:GetCurComp("WidgetRoot/Coin", "UILabel")
    self.money_GameObject = self:GetCurComp("WidgetRoot/Coin/Sprite2", "GameObject")
    self.money_UISprite = self:GetCurComp("WidgetRoot/Coin/Sprite2", "UISprite")
    ---@type UILabel 消费额度
    self.money2_UILabel = self:GetCurComp("WidgetRoot/Coin2", "UILabel")
    self.money2_GameObject = self:GetCurComp("WidgetRoot/Coin2/Sprite2", "GameObject")
    self.money2_UISprite = self:GetCurComp("WidgetRoot/Coin2/Sprite2", "UISprite")
    self.money2_UILabel.gameObject:SetActive(Utility.IsAuctionDiamondQuotaOpen)

    self.money3_UILabel = self:GetCurComp("WidgetRoot/HoldIngot", "UILabel")
    self.money3_GameObject = self:GetCurComp("WidgetRoot/HoldIngot/Sprite2", "GameObject")
    self.money3_UISprite = self:GetCurComp("WidgetRoot/HoldIngot/Sprite2", "UISprite")
end

---@param customData AuctionSmeltPanelData
function UIAuctionUnionPanel:Show(customData)
    self.mCurrentChooseTemplate = {}
    self.mLidToChoose = {}
    self.mMaxPage = 1
    self.ChooseSort = false
    self:ResetTitle()
    self:RefreshCoinShow()
end

function UIAuctionUnionPanel:BindMessage()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.mAuctionUnionMenuChange, function(id, data)
        if self.go.activeSelf then
            self:ChooseMenuChange(data)
        end
    end)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.mAuctionUnionTryBidItem, function(id, data)
        if self.go.activeSelf then
            self:BidSingleItem(data)
        end
    end)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.mAuctionUnionTryBuyItem, function(id, data)
        if self.go.activeSelf then
            self:BuySingleItem(data)
        end
    end)

    ---@param csData auctionV2.AuctionItemList
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGetAuctionItemsMessage, function(msgID, tblData, csData)
        if self.go.activeSelf then
            self:ReceivedAuctionUnionData(tblData)
        end
    end)

    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        self:RefreshCoinShow()
    end)

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUpdateAuctionDiamondMessage, function()
        self:RefreshCoinShow()
    end)

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResAuctionLotMessage, function(msgId, auctionItemInfo)
        if self:CanRefresh() then
            self:OnResAuctionLotMessage(auctionItemInfo)
        end
    end)

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBuyLoseMessage, function()
        if self:CanRefresh() then
            self:RefreshCurrentPage()
        end
    end)
end

function UIAuctionUnionPanel:CanRefresh()
    return CS.StaticUtility.IsNull(self.go) == false and self.go.activeSelf
end

function UIAuctionUnionPanel:BindEvent()
    CS.UIEventListener.Get(self:GetCoin_Sp().gameObject).onClick = function()
        if self.mCoinType then
            local itemInfo = self:GetItemInfoCache(self.mCoinType)
            if itemInfo then
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo })
            end
        end
    end
    CS.UIEventListener.Get(self.money_GameObject).onClick = function()
        self:ShowMoneyTips(self.IconInfo)
    end
    CS.UIEventListener.Get(self.money2_GameObject).onClick = function()
        if self.mDiamondIconInfo then
            self:ShowMoneyTips(self.mDiamondIconInfo)
        end
    end
    CS.UIEventListener.Get(self.money3_GameObject).onClick = function()
        if self.mYuanBaoInfo then
            self:ShowMoneyTips(self.mYuanBaoInfo)
        end
    end
end

--endregion

--region 刷新行会竞拍数据显示
---@param tblData auctionV2.AuctionItemList
function UIAuctionUnionPanel:ReceivedAuctionUnionData(tblData)
    if tblData and tblData.page then
        if not CS.StaticUtility.IsNull(self:GetNothing_GO()) then
            self:GetNothing_GO():SetActive(tblData.toatlPageCount == 0)
        end
        self.PageToInfo[tblData.page] = tblData
        self.mMaxPage = tblData.toatlPageCount
        if self.needInitLoop then
            self:InitAuctionUnionShow()
            self.needInitLoop = false
        else
            self:GetSmelt_LoopScrollViewPlus():RefreshCurrentPage()
        end
    end

end

function UIAuctionUnionPanel:InitAuctionUnionShow()
    self:GetSmelt_LoopScrollViewPlus():Init(function(go, line)
        return self:RefreshAuctionUnionSingleLine(go, line)
    end, function(line)
        self.mTopLine = line
    end)
end

---刷新行会交易单行数据
function UIAuctionUnionPanel:RefreshAuctionUnionSingleLine(go, line)
    self:DataManage(line)
    local lineData = self:GetAuctionUnionItemData(line)
    if not CS.StaticUtility.IsNull(go) and lineData then
        local template = self:GetGridTemplate(go)
        if template then
            template:RefreshSingleAuction(lineData)
        end
        return true
    end
    return false
end

---@return UIAuctionPanel_AuctionUnionGridTemplate 拍卖行交易格子模板
function UIAuctionUnionPanel:GetGridTemplate(go)
    if self.mGridToTemplate == nil then
        self.mGridToTemplate = {}
    end
    local template = self.mGridToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIAuctionPanel_AuctionUnionGridTemplate, self)
        self.mGridToTemplate[go] = template
    end
    return template
end

---@return auctionV2.AuctionItemInfo 获取交易显示数据（一行的数据）
function UIAuctionUnionPanel:GetAuctionUnionItemData(line)
    local page = math.floor(line / self.mMaxCountPrePage) + 1
    ---@type auctionV2.AuctionItemList
    local pageData = self.PageToInfo[page]
    if pageData and pageData.items then
        local tableDataList = pageData.items
        local index = line % self.mMaxCountPrePage + 1
        if index <= #tableDataList then
            return tableDataList[index]
        end
    end
    return nil
end

---数据控制请求
function UIAuctionUnionPanel:DataManage(line)
    local page = math.floor((line * self.mLineNum) / self.mMaxCountPrePage) + 1
    if self.PageToInfo[page] then
        return
    end
    self:ReqUnionAuctionData(page, false)
    if page - 5 > 0 then
        self.PageToInfo[page - 5] = nil
    end
    self.PageToInfo[page + 5] = nil
end

---清除所有缓存数据
function UIAuctionUnionPanel:ClearData()
    self.needInitLoop = true
    self.mMaxPage = 1
    self.PageToInfo = {}
end
--endregion

--region 消息请求
---@param needRefresh boolean 是否需要强制刷新
function UIAuctionUnionPanel:ReqUnionAuctionData(page, needRefresh)
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
function UIAuctionUnionPanel:NetReq(page)
    self:ResetData()
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
        end
    end

    local enumSortType, enumChooseType, mPriceHighToLow = self:GetCurrentSortType()
    local sortType = uiStaticParameter.mAuctionSortType[enumSortType]
    local selectType = self.mSelectType[enumChooseType]

    networkRequest.ReqGetAuctionItems(pageIndex, minLv, maxLv, -1, sex, career, -1, list, self.itemType, sortType, mPriceHighToLow, self.CareerPropertyTendency, selectType)
end

---选中目录改变
function UIAuctionUnionPanel:ChooseMenuChange(data)
    self:ClearData()
    if data then
        self.mMaxPage = 1
        self.firstMenuID = data.firstMenuId
        self.secondMenuId = data.secondMenuId
        self:ReqUnionAuctionData(1, true)
    end
end

---重置数据
function UIAuctionUnionPanel:ResetData()
    self.minLv = -1
    self.maxLv = -1
    self.sex = -1
    self.career = -1
    self.CareerPropertyTendency = -1
end

--region 设置职业等级等数据
---解析等级
function UIAuctionUnionPanel:AnalysisLevel(type, data)
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
function UIAuctionUnionPanel:AnalysisSex(data)
    self.sex = tonumber(data)
end

---解析职业
function UIAuctionUnionPanel:AnalysisCareer(data)
    self.career = tonumber(data)
end

---解析职业偏向
function UIAuctionUnionPanel:AnalysisSpecialCareer(data)
    self.CareerPropertyTendency = tonumber(data)
end
--endregion
--endregion

--region icon购买单个道具

---将要购买道具
---@type auctionV2.AuctionItemInfo
UIAuctionUnionPanel.mCurrentWillBuyItemInfo = nil

--region  单个道具竞价
---点击icon竞拍单个道具
function UIAuctionUnionPanel:BidSingleItem(data)
    if self.mCurrentWillBuyItemInfo == nil then
        return
    end

    self:ClearFlyData()
    local lid = data.lid
    local go = data.go
    --直接竞价
    if lid == self.mCurrentWillBuyItemInfo.item.lid then
        local price = Utility.GetBidPrice(self.mCurrentWillBuyItemInfo, 1)
        local coinType = self.mCurrentWillBuyItemInfo.price.itemId
        if self:IsCostEnough(price, coinType) then
            networkRequest.ReqAuctionLot(lid, Utility.EnumToInt(CS.auctionV2.AuctionType.BID))
            uimanager:ClosePanel("UIPetInfoPanel")
            uimanager:ClosePanel("UIItemInfoPanel")
        else
            if Utility.IsDiamondItemId(coinType) then
                ---@type CSMainPlayerInfo
                local mainPlayerInfo = CS.CSScene.MainPlayerInfo
                if mainPlayerInfo then
                    --if mainPlayerInfo.RechargeInfo.isFirstRecharge then
                    --    uimanager:CreatePanel("UIRechargeFirstTips")
                    --else
                    --    if (CS.CSVersionMgr.Instance.ServerVersion.OpenRecharge) then
                    --        --uimanager:CreatePanel("UIRechargePanel");
                    --        uimanager:CreatePanel("UIRechargeMainPanel", nil, LuaEnumRechargeMainBookMarkType.Recharge)
                    --    end
                    --end
                    Utility.TryShowFirstRechargePanel()
                end
                uimanager:ClosePanel("UIPetInfoPanel")
                uimanager:ClosePanel("UIItemInfoPanel")
            else
                Utility.ShowPopoTips(go, "元宝不足", 1)
            end
        end
    end
end
--endregion

--region 单个道具一口价
---点击icon购买单个道具
function UIAuctionUnionPanel:BuySingleItem(data)
    if self.mCurrentWillBuyItemInfo == nil then
        return
    end
    local lid = data.lid
    local go = data.go
    --直接购买
    if lid == self.mCurrentWillBuyItemInfo.item.lid then
        local price = self.mCurrentWillBuyItemInfo.auctionItemLotInfo.fixedPrice
        local coinType = self.mCurrentWillBuyItemInfo.price.itemId
        if self:IsCostEnough(price, coinType) then
            ---背包空间是否足够
            local res, csItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mCurrentWillBuyItemInfo.item.itemId)
            if res then
                if not CS.CSScene.MainPlayerInfo.BagInfo:CheckIsAbleToAddItemOfNumbers(csItemInfo, 1) then
                    Utility.ShowPopoTips(go, nil, 422, "UIItemInfoPanel")
                    return
                end
                networkRequest.ReqAuctionLot(lid, Utility.EnumToInt(CS.auctionV2.AuctionType.ONEPRICE))
                uimanager:ClosePanel("UIPetInfoPanel")
                uimanager:ClosePanel("UIItemInfoPanel")
            end
        else
            if Utility.IsDiamondItemId(coinType) then
                ---@type CSMainPlayerInfo
                local mainPlayerInfo = CS.CSScene.MainPlayerInfo
                if mainPlayerInfo then
                    Utility.TryShowFirstRechargePanel()
                end
                Utility.JumpRechargePanel(go, LuaEnumRechargePointEntranceType.AuctionDiamondNotEnough)
                uimanager:ClosePanel("UIPetInfoPanel")
                uimanager:ClosePanel("UIItemInfoPanel")
            else
                Utility.ShowPopoTips(go, "元宝不足", 1)
            end
        end
    end
end
--endregion

---购买货币是否足够
function UIAuctionUnionPanel:IsCostEnough(price, coinType)
    local isEnough = false
    if price and self:GetBagInfoV2() then
        if coinType == LuaEnumCoinType.YuanBao then
            local selfCost = self:GetBagInfoV2():GetCoinAmount(coinType)
            isEnough = selfCost >= math.ceil(price)
        elseif Utility.IsDiamondItemId(coinType) then
            local selfCost = Utility.GetAuctionDiamondNum()
            if Utility.IsAuctionDiamondQuotaOpen then
                local diamond = self:GetMainPlayerInfo().Data.auctionDiamond
                isEnough = price <= math.ceil(selfCost) and price <= diamond
            else
                isEnough = price <= math.ceil(selfCost)
            end
        else
            local selfCost = self:GetBagInfoV2():GetCoinAmount(coinType)
            if Utility.IsAuctionDiamondQuotaOpen then
                local diamond = self:GetMainPlayerInfo().Data.auctionDiamond
                isEnough = price <= math.ceil(selfCost) and price <= diamond
            else
                isEnough = price <= math.ceil(selfCost)
            end
        end
    end
    return isEnough
end
--endregion

--region 设置道具飞背包
---设置可能购买道具信息
---@param willBuyItem auctionV2.AuctionItemInfo 将购买的道具
---@param itemId number 购买道具itemId
---@param position UnityEngine.Vector3 购买道具位置
function UIAuctionUnionPanel:SetBuyItemInfo(itemId, position, willBuyItem)
    self.mChooseItemId = itemId
    self.mChooseItemPos = position
    self.mBuyNum = willBuyItem.item.count
    self.mCurrentBagGridCount = self:GetBagInfoV2().EmptyGridCount
    self.mCurrentBagHasItem = self:GetBagInfoV2():GetItemCountByItemId(itemId)
    self.mCurrentWillBuyItemInfo = willBuyItem
end

---清除数据
function UIAuctionUnionPanel:ClearBuyItemInfo()
    self:ClearFlyData()
    self.mCurrentWillBuyItemInfo = nil
end

function UIAuctionUnionPanel:ClearFlyData()
    self.mChooseItemId = nil
    self.mChooseItemPos = nil
    self.mCurrentBagGridCount = 0
end

---@param bagItemInfo bagV2.BagItemInfo
function UIAuctionUnionPanel:FlyItem(bagItemInfo)
    if bagItemInfo and self.mChooseItemId and self.mChooseItemId == bagItemInfo.itemId then
        local pos = self:GetCurrentTimeAimPos(self.mChooseItemId)
        if self.mChooseItemId and self.mChooseItemPos and pos then
            luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = self.mChooseItemId, from = self.mChooseItemPos, to = pos })
            self:ClearBuyItemInfo()
        end
    end
end

---获取道具目标位置
function UIAuctionUnionPanel:GetCurrentTimeAimPos(itemId)
    local data = self:GetItemInfoCache(itemId)
    if data then
        local count = self.mCurrentBagGridCount
        local bagHas = self.mCurrentBagHasItem
        local overLying = data:GetOverlying()
        local leaveNum = overLying - bagHas % overLying
        local LimitBag = bagHas == 0 or (overLying ~= nil and bagHas ~= 0 and (leaveNum == overLying or leaveNum < self.mBuyNum))
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
function UIAuctionUnionPanel:AddNeedChooseItemId(itemID)
    if self.mNeedChooseItemList == nil then
        self.mNeedChooseItemList = {}
    end
    local data = {}
    data.itemId = itemID
    data.isChoose = false
    table.insert(self.mNeedChooseItemList, data)
end

---@return boolean 该道具是否需要选中
function UIAuctionUnionPanel:IsItemNeedChoose(itemId)
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

function UIAuctionUnionPanel:CloseAllChoose()
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

--region 竞价成功
---@param auctionItemInfo auctionV2.AuctionItemInfo
function UIAuctionUnionPanel:OnResAuctionLotMessage(auctionItemInfo)
    self:RefreshCurrentPage()
    if self.mCurrentWillBuyItemInfo then
        self:FlyItem(auctionItemInfo.item)
    end
end

---刷新当前页信息
function UIAuctionUnionPanel:RefreshCurrentPage()
    if self.mTopLine == nil or self.mMaxCountPrePage == nil then
        return
    end
    local page = math.floor(self.mTopLine / self.mMaxCountPrePage) + 1
    self:ReqUnionAuctionData(page, true)
    self:ReqUnionAuctionData(page + 1, true)
end
--endregion

--region 排序部分
---@return UIAuctionPanel_AuctionDropDownBase
function UIAuctionUnionPanel:GetTitlePartTemplate()
    if self.mTitlePartTemplate == nil then
        self.mTitlePartTemplate = templatemanager.GetNewTemplate(self:GetSortToggle_GO(), luaComponentTemplates.UIAuctionPanel_AuctionDropDownBase, self)
    end
    return self.mTitlePartTemplate
end

---选中目录改变
function UIAuctionUnionPanel:OnTitleMenuChange()
    self:ClearData()
    self:ReqUnionAuctionData(1, true)
end

---获取当前排序类型
---@return LuaEnumAuctionPanelSortType,LuaEnumAuctionPanelSecondMenuType,boolean
function UIAuctionUnionPanel:GetCurrentSortType()
    if self:GetTitlePartTemplate() then
        return self:GetTitlePartTemplate():GetCurrentSortType()
    end
end

---充值目录
function UIAuctionUnionPanel:ResetTitle()
    if self:GetTitlePartTemplate() then
        self:GetTitlePartTemplate():ResetMenu()
    end
end
--endregion

--region货币
---初始化货币信息
function UIAuctionUnionPanel:InitCoinInfo()
    local res
    res, self.IconInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(LuaEnumCoinType.Diamond)
    if res then
        self.money_UISprite.spriteName = self.IconInfo.icon
    end
    local res2
    res2, self.mDiamondIconInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(1000023)
    if res2 then
        self.money2_UISprite.spriteName = self.mDiamondIconInfo.icon
    end

    local res3
    res3, self.mYuanBaoInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(LuaEnumCoinType.YuanBao)
    if res3 then
        self.money3_UISprite.spriteName = self.mYuanBaoInfo.icon
    end
end

---显示Tips
function UIAuctionUnionPanel:ShowMoneyTips(itemInfo)
    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo })
end

---刷新钻石显示
function UIAuctionUnionPanel:RefreshCoinShow()
    local coin = Utility.GetAuctionDiamondNum()
    if coin then
        self.money_UILabel.text = coin
    end
    if Utility.IsAuctionDiamondQuotaOpen then
        local diamond = self:GetMainPlayerInfo().Data.auctionDiamond
        if diamond then
            self.money2_UILabel.text = diamond
        end
    end
    local yuanBao = self:GetBagInfoV2():GetCoinAmount(LuaEnumCoinType.YuanBao)
    if yuanBao then
        self.money3_UILabel.text = yuanBao
    end
end
--endregion

return UIAuctionUnionPanel