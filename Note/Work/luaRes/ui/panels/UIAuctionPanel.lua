---拍卖行
---@class UIAuctionPanel:UIBase
local UIAuctionPanel = {}

--region 局部变量

UIAuctionPanel.BranchPanel = {}

---存储当前界面类型
UIAuctionPanel.mCurrentOpenType = nil

---税率
UIAuctionPanel.mTexRate = nil

---拍卖行需要显示背包列表
---@type auctionV2.OpenTradeBeforeResponse
UIAuctionPanel.mShowBagInfo = nil

---上架成功界面
UIAuctionPanel.mSuccessPanel = nil

---竞拍按钮显示时间
UIAuctionPanel.OpenAuctionInfo = nil

---求购按钮显示时间
UIAuctionPanel.OpenBuyingInfo = nil

---是否打开背包
UIAuctionPanel.IsOpenBag = false

---打开背包或者拍卖行后选中道具（在上架推送和购买推送时才存在）
UIAuctionPanel.mOpenBagChooseItemLid = nil

---需要选中高亮的道具ID列表
UIAuctionPanel.needSelectItemIdList = nil
---需要选中高亮的道具类型
UIAuctionPanel.needSelectItemType = nil

---当前是否是猜你喜欢状态
UIAuctionPanel.IsCurrentShowLike = true

---上架界面默认打开面板
UIAuctionPanel.ShelfType = LuaEnumAuctionSelfSellType.Shelf

---当前选中购买道具信息
---@type auctionV2.AuctionItemInfo
UIAuctionPanel.mCurrentChooseTradeItemInfo = nil

---当前选中竞拍道具信息
---@type auctionV2.AuctionItemInfo
UIAuctionPanel.mCurrentChooseAuctionItemInfo = nil

---当前背包格子数目
UIAuctionPanel.mCurrentBagGridCount = 0

--region 用于判断改道具飞向邮件还是背包
---当前购买道具itemId
UIAuctionPanel.mTradeItemID = nil

---当前购买道具位置
UIAuctionPanel.mTradeItemPos = nil

---当前购买竞拍界面itemId
UIAuctionPanel.mAuctionBuyItemId = nil

---当前购买竞拍界面道具位置
UIAuctionPanel.mAuctionBuyItemPos = nil

---当前购买数目
UIAuctionPanel.mBuyNum = 1
--endregion

UIAuctionPanel.mNeedClosePanel = {}

---交易行打开原因参数，用于各种情况下判断参数使用，和UIAuctionPanel.mCustomOwnData一起使用
UIAuctionPanel.mAuctionPanelShowReason = nil

---用于存储show方法中需要的任何参数，根据原因判定参数用法
UIAuctionPanel.mCustomOwnData = nil

---背包需要在打开后选中的道具
---@type bagV2.BagItemInfo
UIAuctionPanel.mNeedChooseBagItem = nil
--endregion

--region 组件
---购买界面
function UIAuctionPanel:GetTradePanel_GameObject()
    if UIAuctionPanel.mTradePanel == nil then
        UIAuctionPanel.mTradePanel = UIAuctionPanel:GetCurComp("WidgetRoot/TradePanel", "GameObject")
    end
    return UIAuctionPanel.mTradePanel
end

---竞拍界面
function UIAuctionPanel.GetAuctionPanel_GameObject()
    if UIAuctionPanel.mAuctionPanel == nil then
        UIAuctionPanel.mAuctionPanel = UIAuctionPanel:GetCurComp("WidgetRoot/AuctionPanel", "GameObject")
    end
    return UIAuctionPanel.mAuctionPanel
end

---求购界面
function UIAuctionPanel.GetBuyingPanel_GameObject()
    if UIAuctionPanel.mBuyingPanel == nil then
        UIAuctionPanel.mBuyingPanel = UIAuctionPanel:GetCurComp("WidgetRoot/BuyingPanel", "GameObject")
    end
    return UIAuctionPanel.mBuyingPanel
end

---交易上架界面
function UIAuctionPanel.GetSelfSellPanel_GameObject()
    if UIAuctionPanel.mSelfSellPanel == nil then
        UIAuctionPanel.mSelfSellPanel = UIAuctionPanel:GetCurComp("WidgetRoot/SelfSellPanel", "GameObject")
    end
    return UIAuctionPanel.mSelfSellPanel
end

---竞拍上架界面
function UIAuctionPanel.GetSelfAuctionPanel_GameObject()
    if UIAuctionPanel.mSelfAuctionPanel == nil then
        UIAuctionPanel.mSelfAuctionPanel = UIAuctionPanel:GetCurComp("WidgetRoot/SelfAuctionPanel", "GameObject")
    end
    return UIAuctionPanel.mSelfAuctionPanel
end

---求购上架界面
function UIAuctionPanel.GetSelfBuyingPanel_GameObject()
    if UIAuctionPanel.mSelfBuyingPanel == nil then
        UIAuctionPanel.mSelfBuyingPanel = UIAuctionPanel:GetCurComp("WidgetRoot/SelfBuyingPanel", "GameObject")
    end
    return UIAuctionPanel.mSelfBuyingPanel
end

---摊位界面
function UIAuctionPanel.GetStallPanel_GameObject()
    if UIAuctionPanel.mStallPanel == nil then
        UIAuctionPanel.mStallPanel = UIAuctionPanel:GetCurComp("WidgetRoot/SelfSellPanel/StallPanel", "GameObject")
    end
    return UIAuctionPanel.mStallPanel
end

---背包界面
function UIAuctionPanel.GetBagPanel_GameObject()
    if UIAuctionPanel.mBagPanel == nil then
        UIAuctionPanel.mBagPanel = UIAuctionPanel:GetCurComp("WidgetRoot/BagPanel", "GameObject")
    end
    return UIAuctionPanel.mBagPanel
end

function UIAuctionPanel.GetStallPanel_GameObject()
    if UIAuctionPanel.mStallPanel == nil then
        UIAuctionPanel.mStallPanel = UIAuctionPanel:GetCurComp("WidgetRoot/StallPanel", "GameObject")
    end
    return UIAuctionPanel.mStallPanel
end

---关闭界面按钮
function UIAuctionPanel.GetCloseButton_GameObject()
    if UIAuctionPanel.mCloseButton == nil then
        UIAuctionPanel.mCloseButton = UIAuctionPanel:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    end
    return UIAuctionPanel.mCloseButton
end

---交易按钮
function UIAuctionPanel:GetTradeToggle_UIToggle()
    if UIAuctionPanel.mTradeToggle == nil then
        UIAuctionPanel.mTradeToggle = UIAuctionPanel:GetCurComp("WidgetRoot/events/SellToggle", "UIToggle")
    end
    return UIAuctionPanel.mTradeToggle
end

---竞拍按钮
function UIAuctionPanel.GetAuctionToggle_UIToggle()
    if UIAuctionPanel.mAuctionToggle == nil then
        UIAuctionPanel.mAuctionToggle = UIAuctionPanel:GetCurComp("WidgetRoot/events/AuctionToggle", "UIToggle")
    end
    return UIAuctionPanel.mAuctionToggle
end

---求购按钮
function UIAuctionPanel.GetBuyingToggle_UIToggle()
    if UIAuctionPanel.mBuyingToggle == nil then
        UIAuctionPanel.mBuyingToggle = UIAuctionPanel:GetCurComp("WidgetRoot/events/BuyingToggle", "UIToggle")
    end
    return UIAuctionPanel.mBuyingToggle
end

---摊位按钮
function UIAuctionPanel.GetStallToggle_UIToggle()
    if UIAuctionPanel.mStallToggle == nil then
        UIAuctionPanel.mStallToggle = UIAuctionPanel:GetCurComp("WidgetRoot/events/StallToggle", "UIToggle")
    end
    return UIAuctionPanel.mStallToggle
end

--region 页签
---@return UIGridContainer 页签container
function UIAuctionPanel:GetToggleArea_UIGridContainer()
    if self.mToggleContainer == nil then
        self.mToggleContainer = self:GetCurComp("WidgetRoot/events/ToggleArea", "UIGridContainer")
    end
    return self.mToggleContainer
end
--endregion

--endregion

--region 属性
---@return UIAuctionPanel_TradePanel 元宝交易模板
function UIAuctionPanel:GetTradePanelTemplate()
    if self.mTradePanelTemplate == nil then
        self.mTradePanelTemplate = templatemanager.GetNewTemplate(self:GetTradePanel_GameObject(), luaComponentTemplates.UIAuctionPanel_TradePanel, self)
    end
    return self.mTradePanelTemplate
end

---@return UIAuctionPanel_SelfSellPanel 个人出售模板
function UIAuctionPanel:GetSelfSellPanelTemplate()
    if self.mSelfSellPanelTemplate == nil then
        self.mSelfSellPanelTemplate = templatemanager.GetNewTemplate(UIAuctionPanel.GetSelfSellPanel_GameObject(), luaComponentTemplates.UIAuctionPanel_SelfSellPanel, self)
    end
    return self.mSelfSellPanelTemplate
end

---@return UIAuctionPanel_AuctionPanel 竞拍模板
function UIAuctionPanel:GetAuctionPanelTemplate()
    if self.mAuctionPanelTemplate == nil then
        self.mAuctionPanelTemplate = templatemanager.GetNewTemplate(UIAuctionPanel.GetAuctionPanel_GameObject(), luaComponentTemplates.UIAuctionPanel_AuctionPanel, self)
    end
    return self.mAuctionPanelTemplate
end

---@return UIAuctionPanel_SelfAuctionPanel 个人竞拍出售模板
function UIAuctionPanel:GetSelfAuctionPanelTemplate()
    if self.mSelfAuctionPanelTemplate == nil then
        self.mSelfAuctionPanelTemplate = templatemanager.GetNewTemplate(UIAuctionPanel.GetSelfAuctionPanel_GameObject(), luaComponentTemplates.UIAuctionPanel_SelfAuctionPanel, self)
    end
    return self.mSelfAuctionPanelTemplate
end

---@return UIAuctionPanel_BagPanel 拍卖行背包模板
function UIAuctionPanel:GetBagPanelTemplate()
    if self.mBagPanelTemplate == nil then
        self.mBagPanelTemplate = luaclass.UIAuctionPanel_BagPanel:NewWithGO(UIAuctionPanel.GetBagPanel_GameObject(), self)
    end
    return self.mBagPanelTemplate
end

---@return UIAuctionPanel_BuyingPanel 求购面板模板
function UIAuctionPanel:GetBuyingPanelTemplate()
    if self.BuyingPanelTemplate == nil then
        self.BuyingPanelTemplate = templatemanager.GetNewTemplate(UIAuctionPanel.GetBuyingPanel_GameObject(), luaComponentTemplates.UIAuctionPanel_BuyingPanel, self)
    end
    return self.BuyingPanelTemplate
end

---@return UIAuctionPanel_SelfBuyingPanel 个人求购面板
function UIAuctionPanel:GetSelfBuyingPanelTemplate()
    if self.mSelfBuyingPanelTemplate == nil then
        self.mSelfBuyingPanelTemplate = templatemanager.GetNewTemplate(UIAuctionPanel.GetSelfBuyingPanel_GameObject(), luaComponentTemplates.UIAuctionPanel_SelfBuyingPanel, self)
    end
    return self.mSelfBuyingPanelTemplate
end

---@return CSMainPlayerInfo 玩家信息
function UIAuctionPanel:GetPlayerInfo()
    if self.mPlayerInfo == nil then
        self.mPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mPlayerInfo
end

---@return CSAuctionInfoV2 拍卖行V2
function UIAuctionPanel:GetAuctionInfoV2()
    if self.mAuctionInfoV2 == nil and self:GetPlayerInfo() then
        self.mAuctionInfoV2 = self:GetPlayerInfo().AuctionInfo
    end
    return self.mAuctionInfoV2
end

---@return CSBagInfoV2 背包
function UIAuctionPanel:GetBagInfoV2()
    if self.mBagInfoV2 == nil and self:GetPlayerInfo() then
        self.mBagInfoV2 = self:GetPlayerInfo().BagInfo
    end
    return self.mBagInfoV2
end

---@return UnityEngine.Vector3 背包位置
function UIAuctionPanel:GetBagPos()
    if self.mBagPos == nil then
        local mainChatPanel = uimanager:GetPanel("UIMainChatPanel")
        if mainChatPanel then
            self.mBagPos = mainChatPanel.btn_bag.transform.position
        end
    end
    return self.mBagPos
end

---@return UnityEngine.Vector3 邮件位置
function UIAuctionPanel:GetMainPos()
    if self.mMailPos == nil then
        ---@type UIMainChatPanel
        local mainChatPanel = uimanager:GetPanel("UIMainChatPanel")
        if mainChatPanel then
            self.mMailPos = mainChatPanel.btn_social.transform.position
        end
    end
    return self.mMailPos
end

---获取道具目标位置
function UIAuctionPanel:GetCurrentTimeAimPos(itemId)
    local data = self:GetItemCache(itemId)
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

---购买前获取背包数目
function UIAuctionPanel:SaveCurrentBagGridCount(itemId)
    self.mCurrentBagGridCount = self:GetBagInfoV2().EmptyGridCount
    self.mCurrentBagHasItem = self:GetBagInfoV2():GetItemCountByItemId(itemId)
end
--endregion

--region 初始化
function UIAuctionPanel:Init()
    self.mNeedClosePanel = {}
    self:BindEvents()
    self:BindMessage()
    self:RefreshMoney()
    self:RefreshToggleShow()
    --self:ReqServerData()
end

---@class AuctionPanelData
---@field type luaEnumAuctionPanelType 交易行界面类型
---@field pushData number 推送道具lid/也可以是自定义(推送使用)
---@field auctionTradePushReason LuaEnumAuctionTradePanelShowReason 推送原因，用于不同原因下判断参数给哪个界面使用(推送使用)
---@field mOwnData table customType 任意数据(推送使用)
---@field needSelectItemIdList table<number,number> 需要选中itemId列表(选中使用)
---@field needSelectItemType luaEnumAuctionPanelType 需要选中类型和上面列表一起使用(选中使用)
---@field isTask boolean 貌似任务用的(不知道干嘛用的)
---@field isFastItem boolean 不知道谁加的(不知道干嘛用的)
---@field jumpID boolean 不知道干嘛用的(不知道干嘛用的)
---@field jumpID boolean 不知道干嘛用的(不知道干嘛用的)
---@field IsShowGuessLike boolean 是否打开猜你喜欢
---@field ShelfType LuaEnumAuctionSelfSellType 上架界面打开上架还是摆摊
---@field mNeedChooseBagItem bagV2.BagItemInfo 交易行背包需要自动选中道具信息

---@param customData AuctionPanelData
function UIAuctionPanel:Show(customData)
    self.mAuctionPanelShowReason = nil
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.Auction
    local openType = luaEnumAuctionPanelType.Guess
    if customData ~= nil then
        if customData.type then
            openType = customData.type
        end
        if customData.pushData then
            self.mOpenBagChooseItemLid = customData.pushData
        end

        if customData.auctionTradePushReason then
            self.mAuctionPanelShowReason = customData.auctionTradePushReason
        end

        if customData.mOwnData then
            self.mCustomOwnData = customData.mOwnData
        end

        if customData.needSelectItemIdList then
            self.needSelectItemIdList = customData.needSelectItemIdList
        end

        if customData.needSelectItemType then
            self.needSelectItemType = customData.needSelectItemType
        end

        if customData.isTask then
            self.mIsTask = customData.isTask
        end

        if customData.isFastItem ~= nil then
            self.mIsFastItem = customData.isFastItem
        end

        if customData.jumpID then
            self.mJumpID = customData.jumpID
        end
        if customData.IsShowGuessLike ~= nil then
            self.IsCurrentShowLike = customData.IsShowGuessLike
        end
        if customData.ShelfType then
            self.ShelfType = customData.ShelfType
        end

        if customData.mNeedChooseBagItem then
            self.mNeedChooseBagItem = customData.mNeedChooseBagItem
        end
    end

    self:SetTitleToggleChoose(openType)
end

function UIAuctionPanel:BindEvents()
    CS.UIEventListener.Get(UIAuctionPanel.GetCloseButton_GameObject()).onClick = function()
        self:ClosePanel()
    end
end

function UIAuctionPanel:BindMessage()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:OnBagChangeReceived()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        self:RefreshMoney()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_RefreshAuction_StallPanel, function(msgID, tblData)
        self:RefreshStallPanel(msgID, tblData)
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, function(msgID, tblData)
        self:RefreshToggleShow()
    end)


    --region 交易/竞拍/求购
    --详细信息
    UIAuctionPanel.OnAuctionDataReceivedCallBack = function(msgID, tblData, csData)
        self:OnAuctionDataReceived(tblData, csData)
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGetAuctionItemsMessage, UIAuctionPanel.OnAuctionDataReceivedCallBack)
    --endregion

    --region交易
    --交易查询
    UIAuctionPanel.OnResAuctionSearchMessageReceivedCallBack = function(msgID, tblData, csData)
        self:OnResAuctionSearchMessageReceived(csData)
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResAuctionSearchMessage, UIAuctionPanel.OnResAuctionSearchMessageReceivedCallBack)

    --购买成功
    UIAuctionPanel.OnBuyInfoReceivedCallBack = function(msgID, tblData, csData)
        self:OnBuyInfoReceived(csData)
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBuyAuctionItemMessage, UIAuctionPanel.OnBuyInfoReceivedCallBack)

    --猜你喜欢返回
    UIAuctionPanel.OnGuessLikeMessageReceivedFunc = function(msgID, tblData, csData)
        self:OnGuessLikeMessageReceived(csData)
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGuessYouLikeMessage, UIAuctionPanel.OnGuessLikeMessageReceivedFunc)

    UIAuctionPanel.AuctionItemChangeBuyState = function(msgID, data)
        self:OpenBuyItemPanel(data)
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.AuctionItemChangeBuyState, UIAuctionPanel.AuctionItemChangeBuyState)

    --endregion

    --region 交易/竞拍
    --购买失败
    UIAuctionPanel.OnLoseMessageReceivedCallBack = function()
        self:OnLoseMessageReceived()
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBuyLoseMessage, UIAuctionPanel.OnLoseMessageReceivedCallBack)

    --拍卖行背包点击事件
    UIAuctionPanel.OnBagGridClickedCallBack = function(msgID, bagItemInfo)
        self:OnBagGridClicked(msgID, bagItemInfo)
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.AuctionBagItemClicked, UIAuctionPanel.OnBagGridClickedCallBack)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.AuctionBidItemChangeBidState, UIAuctionPanel.OpenBidItemPanel)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.AuctionBidItemChangeBuyState, UIAuctionPanel.OpenAuctionBuyItemPanel)
    --endregion

    --region 个人出售/交易上架
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_TradeSellInfoChange, function()
        if UIAuctionPanel.mCurrentOpenType ~= luaEnumAuctionPanelType.SelfSell then
            return
        end
        self:OnResGetTradeShelfMessageReceived()
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.mCurrentReAddItemState, UIAuctionPanel.CurrentReAddItemState)
    --endregion

    --region 竞拍
    --竞拍成功
    UIAuctionPanel.OnResAuctionLotMessageReceivedCallBack = function()
        self:OnResAuctionLotMessageReceived()

    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResAuctionLotMessage, UIAuctionPanel.OnResAuctionLotMessageReceivedCallBack)
    UIAuctionPanel.OnResUpdateAuctionDiamondMessage = function()
        self:RefreshAuctionDiamond()
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUpdateAuctionDiamondMessage, UIAuctionPanel.OnResUpdateAuctionDiamondMessage)
    --endregion

    --region 个人竞拍/竞拍上架
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_AuctionSellInfoChange, function()
        self:OnResGetAuctionShelfMessageReceived()
    end)

    UIAuctionPanel.OnAuctionItemReAddMessageReceivedFunc = function(msgID, auctionInfo)
        self:OnAuctionItemReAddMessageReceived(auctionInfo)
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.AuctionItemReAdd, UIAuctionPanel.OnAuctionItemReAddMessageReceivedFunc)

    --endregion

    --region 求购
    --提交求购响应
    UIAuctionPanel.ResSubmitBuyProductsItemMessageReceivedCallBack = function(msgID, tblData, csData)
        self:ResSubmitBuyProductsItemMessageReceived(tblData)
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSubmitBuyProductsItemMessage, UIAuctionPanel.ResSubmitBuyProductsItemMessageReceivedCallBack)
    --endregion

    --region 个人出售/个人求购
    UIAuctionPanel.GetSellInfo = function(msgId, tblData, csData)
        self:GetSellInfoFunc(msgId, tblData, csData)
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResMarketPriceSectionMessage, UIAuctionPanel.GetSellInfo)
    --endregion

    UIAuctionPanel.OnResAuctionBuyTradeItem = function(id, num)
        self.mBuyNum = num
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.AuctionBuyTradeItem, UIAuctionPanel.OnResAuctionBuyTradeItem)

    UIAuctionPanel.OnResAuctionBuyAuctionItem = function(id, num)
        self.mBuyNum = num
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.AuctionBuyAuctionItem, UIAuctionPanel.OnResAuctionBuyAuctionItem)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.AuctionBuyRemoveItem, UIAuctionPanel.OnResAuctionBuyRemoveItem)
end

function UIAuctionPanel:ReqServerData()
    networkRequest.ReqGetShelfBoothInfo()
    networkRequest.ReqBoothMaps()
end
--endregion

--region 服务器消息
---刷新拍卖行摊位面板
function UIAuctionPanel:RefreshStallPanel(msgID, tblData)
    if UIAuctionPanel.mCurrentOpenType ~= luaEnumAuctionPanelType.SelfSell then
        return
    end
    self:GetSelfSellPanelTemplate():GetStallPanelTemplate():RefreshStallPanel()
end

---@param csData auctionV2.AuctionItemList 收到拍卖行信息
function UIAuctionPanel:OnAuctionDataReceived(tblData, csData)
    if self.mCurrentOpenType == luaEnumAuctionPanelType.Trade or self.mCurrentOpenType == luaEnumAuctionPanelType.Guess then
        self:GetTradePanelTemplate():RefreshPanel(csData)
    elseif self.mCurrentOpenType == luaEnumAuctionPanelType.Auction then
        self:GetAuctionPanelTemplate():RefreshItemShow(tblData, csData)
    elseif self.mCurrentOpenType == luaEnumAuctionPanelType.Buying then
        self:GetBuyingPanelTemplate():RefreshItemShow(csData)
    end
end

---@param csData auctionV2.SearchAuctionItemResponse 收到交易查询信息
function UIAuctionPanel:OnResAuctionSearchMessageReceived(csData)
    if self.mCurrentOpenType == luaEnumAuctionPanelType.Trade or self.mCurrentOpenType == luaEnumAuctionPanelType.Guess then
        self:GetTradePanelTemplate():RefreshPanel(csData.list)
    end
end

---收到购买失败消息
function UIAuctionPanel:OnLoseMessageReceived()
    if self.mCurrentOpenType == luaEnumAuctionPanelType.Trade then
        self:GetTradePanelTemplate():PurchaseResultCallBack()
    elseif self.mCurrentOpenType == luaEnumAuctionPanelType.Auction then
        self:GetAuctionPanelTemplate():RefreshCurrentPage()
    elseif self.mCurrentOpenType == luaEnumAuctionPanelType.Buying then
        -- self:GetBuyingPanelTemplate():RefreshItemShow(csData)
    end
end

---收到购买成功消息
---@param csData auctionV2.ItemMsg 购买道具信息
function UIAuctionPanel:OnBuyInfoReceived(csData)
    if self.mCurrentOpenType == luaEnumAuctionPanelType.Trade or self.mCurrentOpenType == luaEnumAuctionPanelType.Guess then
        self:GetTradePanelTemplate():PurchaseResultCallBack()
        local pos = self:GetCurrentTimeAimPos(self.mTradeItemID)
        if self.mTradeItemID and self.mTradeItemPos and pos then
            luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = self.mTradeItemID, from = self.mTradeItemPos, to = pos })
            self.mTradeItemID = nil
            self.mTradeItemPos = nil
            self.mCurrentBagGridCount = 0
        end
    end
end

---收到拍卖购买成功返回
function UIAuctionPanel:OnResAuctionLotMessageReceived()
    if self.mCurrentOpenType == luaEnumAuctionPanelType.Auction then
        self:GetAuctionPanelTemplate():RefreshCurrentPage()
        local pos = self:GetCurrentTimeAimPos(self.mAuctionBuyItemId)
        if self.mAuctionBuyItemId and self.mAuctionBuyItemPos and pos then
            luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = self.mAuctionBuyItemId, from = self.mAuctionBuyItemPos, to = pos })
            self.mAuctionBuyItemId = nil
            self.mAuctionBuyItemPos = nil
            self.mCurrentBagGridCount = 0
        end
    end
end

---收到求购出售消息
function UIAuctionPanel:ResSubmitBuyProductsItemMessageReceived(tblData)
    if self.mCurrentOpenType == luaEnumAuctionPanelType.Buying then
        self:GetBuyingPanelTemplate():SubmitBuyProductsItem(tblData)
    end
end

---@param csData auctionV2.GuessYouLikeResponse 猜你喜欢响应
function UIAuctionPanel:OnGuessLikeMessageReceived(csData)
    self:GetTradePanelTemplate():RefreshGuessYouLike(csData)
end

---收到出售价格信息
---@param csData auctionV2.MarketPriceSection
function UIAuctionPanel:GetSellInfoFunc(msgId, tblData, csData)
    if self.mCurrentOpenType == luaEnumAuctionPanelType.SelfSell then
        self:GetSelfSellPanelTemplate():GetSellInfoFunc(csData)
    elseif self.mCurrentOpenType == luaEnumAuctionPanelType.SelfBuying then
        self:GetSelfBuyingPanelTemplate().BuyingMenuTemplate:GetSellInfoFun(msgId, tblData, csData)
    elseif self.mCurrentOpenType == luaEnumAuctionPanelType.SelfAuction then
        self:GetSelfAuctionPanelTemplate():GetSellInfoFun(csData)
    elseif self.mCurrentOpenType == luaEnumAuctionPanelType.Buying then
        self:GetBuyingPanelTemplate():GetPriceSection(csData)
    end
end

--endregion

--region 客戶端消息
---背包改变消息
function UIAuctionPanel:OnBagChangeReceived()
    if self:GetBagPanelTemplate() and self:GetBagPanelTemplate().RefreshList and
            (self.mCurrentOpenType == luaEnumAuctionPanelType.SelfAuction or
                    self.mCurrentOpenType == luaEnumAuctionPanelType.SelfSell or
                    self.mCurrentOpenType == luaEnumAuctionPanelType.ShareStall) then
        self:GetBagPanelTemplate():RefreshList()
    end
end

---刷新金币显示
function UIAuctionPanel:RefreshMoney()
    if self.mCurrentOpenType == luaEnumAuctionPanelType.Trade or self.mCurrentOpenType == luaEnumAuctionPanelType.Guess then
        self:GetTradePanelTemplate():RefreshCoinShow()
    elseif self.mCurrentOpenType == luaEnumAuctionPanelType.Auction then
        self:GetAuctionPanelTemplate():RefreshCoinShow()
    elseif self.mCurrentOpenType == luaEnumAuctionPanelType.Buying then
        self:GetBuyingPanelTemplate():RefreshCoinShow()
    end
end

---拍卖行背包格子点击事件
function UIAuctionPanel:OnBagGridClicked(msgID, bagItemInfo)
    if self.mCurrentOpenType == luaEnumAuctionPanelType.SelfSell then
        self:GetSelfSellPanelTemplate():OnBagGridClickedFunc(msgID, bagItemInfo)
    elseif self.mCurrentOpenType == luaEnumAuctionPanelType.SelfAuction then
        self:GetSelfAuctionPanelTemplate():OnBagGridClickedFunc(msgID, bagItemInfo)
    end
end

---交易行点击下架道具类型
function UIAuctionPanel.CurrentReAddItemState(msgId, itemId)
    UIAuctionPanel:GetSelfSellPanelTemplate():SaveCurrentReAddShelfState(itemId)

end
--endregion

--region 交易行
--region 指引气泡
---@return number 气泡层级
function UIAuctionPanel:GetGuidBubbleLayer()
    if self.mGuidScrollViewUIPanel == nil then
        ---@type UIPanel
        self.mGuidScrollViewUIPanel = self:GetCurComp("WidgetRoot/TradePanel/ItemsArea/Scroll View", "UIPanel")
    end
    if self.mGuidScrollViewUIPanel then
        return self.mGuidScrollViewUIPanel.depth
    end
end

---角色打开交易行前5次，增加指引出售的气泡
function UIAuctionPanel:AddTradeBubbleTips()
    if self.mIsNeedPushBubble then
        self.mIsNeedPushBubble = false
        if self:GetPlayerInfo() then
            local time = self:GetPlayerInfo().ConfigInfo:GetInt(CS.EConfigOption.AuctionHintTipNum)
            if time == nil then
                time = 0
            end
            local tableIsFind, info = CS.Cfg_Guide_BubbleTableManager.Instance:TryGetValue(4)
            if tableIsFind then
                if time <= info.times then
                    local panelDepth = self:GetGuidBubbleLayer()
                    if panelDepth then
                        local data = {}
                        data.point = self:GetTradePanelTemplate().sellButton_GameObject
                        data.id = 4
                        data.depth = panelDepth
                        self.tipsTemplate = Utility.TryCreateHintTips(data)
                        time = time + 1
                        self:GetPlayerInfo().ConfigInfo:SetInt(CS.EConfigOption.AuctionHintTipNum, time)
                    end
                end
            end
        end
    end
end

---移除指引气泡
function UIAuctionPanel:RemoveTradeBubbleTips()
    if self.tipsTemplate then
        Utility.RemoveHintTips(self.tipsTemplate)
    end
end
--endregion

--region打开出售界面
---跳转交易行界面
function UIAuctionPanel:SwitchToTradePanel()
    if self:GetTradePanelTemplate() == nil then
        return
    end

    local type = ternary(self.IsCurrentShowLike, luaEnumAuctionPanelType.Guess, luaEnumAuctionPanelType.Trade)
    self:SwitchToPanel(type)

    self:AddTradeChooseItem()

    if self.mOpenBagChooseItemLid then
        self:GetTradePanelTemplate():ShowPanel(type)
        self:GetTradePanelTemplate():SetGuessLikeItemChoose(self.mOpenBagChooseItemLid, true)
        self.mOpenBagChooseItemLid = nil
    elseif self.mIsTask == true then
        type = luaEnumAuctionPanelType.Guess
        self:SellBackTab()
        self:GetTradePanelTemplate():ShowPanel(type, self.mJumpID)
    elseif self.mIsFastItem then
        type = luaEnumAuctionPanelType.Trade
        self:SellBackTab()
        self:GetTradePanelTemplate():ShowPanel(type, 103)
    elseif self.mAuctionPanelShowReason == LuaEnumAuctionTradePanelShowReason.TradePush and self.mCustomOwnData then
        self:GetTradePanelTemplate():ShowPanelWithSelectItemName(self.mCustomOwnData.mChooseName, self.mCustomOwnData.mChooseItemId, false)
        self.mCustomOwnData = nil
    else
        self:GetTradePanelTemplate():ShowPanel(type)
    end
    UIAuctionPanel.IsOpenBag = false
    self:AddTradeBubbleTips()
end

---添加交易需要选中itemId
function UIAuctionPanel:AddTradeChooseItem()
    local AuctionPanelType = luaEnumAuctionPanelType.Guess
    if self.needSelectItemType ~= nil then
        AuctionPanelType = self.needSelectItemType
    end
    if self.needSelectItemIdList then
        for key, value in pairs(self.needSelectItemIdList) do
            self:GetTradePanelTemplate():AddNeedChooseItemId(value, AuctionPanelType)
        end
    end
end
--endregion

--region 通过icon打开交易行购买界面
---打开当前选中道具购买界面
function UIAuctionPanel:OpenBuyItemPanel(data)
    local bagItemLid = data.lid
    local go = data.go
    if self.mCurrentChooseTradeItemInfo and bagItemLid == self.mCurrentChooseTradeItemInfo.item.lid then
        local priceId = self.mCurrentChooseTradeItemInfo.price.itemId
        if Utility.IsItemCanBuy(self.mCurrentChooseTradeItemInfo.item.ItemTABLE, go, priceId) then
            local price = self.mCurrentChooseTradeItemInfo.price.count
            if self.mCurrentChooseTradeItemInfo.price.itemId == LuaEnumCoinType.YuanBao then
                if not self:IsAuctionPanelByYuanBaoItemCostEnough(price) then
                    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.AuctionIngotNotEnough
                    local itemInfoPanel = uimanager:GetPanel("UIItemInfoPanel");
                    if (itemInfoPanel ~= nil) then
                        local panelCount = itemInfoPanel:GetPanelGridContainer().MaxCount;
                        if (panelCount > 1) then
                            local TipsInfo = {}
                            TipsInfo[LuaEnumTipConfigType.Describe] = "元宝不足";
                            TipsInfo[LuaEnumTipConfigType.Parent] = go.transform;
                            TipsInfo[LuaEnumTipConfigType.ConfigID] = 23
                            uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
                        else
                            Utility.ShowItemGetWay(LuaEnumCoinType.YuanBao, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(60, 0), nil, nil, "UIItemInfoPanel");
                        end
                    end
                    return
                end
            elseif self.mCurrentChooseTradeItemInfo.price.itemId == LuaEnumCoinType.Diamond then
                ---推送特殊礼包
                if (Utility.IsPushSpecialGift()) then
                    uimanager:CreatePanel("UIRechargeGiftPanel")
                    return
                end
                uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.AuctionDiamondNotEnough
                if not UIAuctionPanel:IsBuyCostEnough(price) then
                    Utility.JumpRechargePanel(go)
                    uimanager:ClosePanel("UIPetInfoPanel")
                    uimanager:ClosePanel("UIItemInfoPanel")
                    return
                end
            end
        else
            return
        end
        if self.mCurrentChooseTradeItemInfo.price.itemId == LuaEnumCoinType.Diamond then
            ---推送特殊礼包
            if (Utility.IsPushSpecialGift()) then
                uimanager:CreatePanel("UIRechargeGiftPanel")
                return
            end
        end

        ---背包空间是否足够
        if not CS.CSScene.MainPlayerInfo.BagInfo:CheckIsAbleToAddItemOfNumbers(self.mCurrentChooseTradeItemInfo.item.ItemTABLE, 1) then
            Utility.ShowPopoTips(go, nil, 422, "UIItemInfoPanel")
            return
        end

        local lid = self.mCurrentChooseTradeItemInfo.item.lid
        networkRequest.ReqBuyAuctionAuction(lid, 1, 1)
        self:GetAuctionInfoV2():BuyItem(lid)
        uimanager:ClosePanel("UIPetInfoPanel")
        uimanager:ClosePanel("UIItemInfoPanel")
    end
end

---交易直接购买货币是否足够
function UIAuctionPanel:IsAuctionPanelByYuanBaoItemCostEnough(price)
    --[[
    local isEnough = false
    if price then
        local selfCost = Utility.GetAuctionDiamondNum()
        isEnough = selfCost >= math.ceil(price)
    end
    return isEnough
    --]]
    return Utility.IsCoinEnough(price, LuaEnumCoinType.YuanBao)
end
--endregion
--endregion

--region 个人交易行
---打开个人出售界面
function UIAuctionPanel:SwitchToSellPanel()
    ---重新请求摊位信息
    self:ReqServerData()
    self:GetSelfSellPanelTemplate():ShowPanel(self.ShelfType)
    self:SwitchToPanel(luaEnumAuctionPanelType.SelfSell)
    if self:GetBagPanelTemplate() then
        self:GetBagPanelTemplate():RefreshList(luaEnumAuctionPanelType.SelfSell)
        if self.mOpenBagChooseItemLid then
            self:GetBagPanelTemplate():SetItemChoose(self.mOpenBagChooseItemLid, true)
        end
    end
    UIAuctionPanel.IsOpenBag = true
end

---收到个人出售
function UIAuctionPanel:OnResGetTradeShelfMessageReceived()
    self:GetSelfSellPanelTemplate():RefreshSelfSellList()
end
--endregion

--region 竞拍行
---打开竞拍界面
function UIAuctionPanel:SwitchToAuctionPanel()
    self:SwitchToPanel(luaEnumAuctionPanelType.Auction)
    if self:GetAuctionPanelTemplate() then
        self:GetAuctionPanelTemplate():ShowPanel()
    end
    UIAuctionPanel.IsOpenBag = false
end

---打开个人竞拍界面
function UIAuctionPanel:SwitchToSelfAuctionPanel()
    self:GetSelfAuctionPanelTemplate():ReqData()
    self:SwitchToPanel(luaEnumAuctionPanelType.SelfAuction)
    if self:GetBagPanelTemplate() and self:GetBagPanelTemplate().RefreshList then
        self:GetBagPanelTemplate():RefreshList(luaEnumAuctionPanelType.SelfAuction)
    end
    self.IsOpenBag = true
end

---刷新个人可使用钻石数目
function UIAuctionPanel:RefreshAuctionDiamond()
    if self.mCurrentOpenType == luaEnumAuctionPanelType.Auction then
        self:GetAuctionPanelTemplate():RefreshCoinShow()
    elseif self.mCurrentOpenType == luaEnumAuctionPanelType.Trade or self.mCurrentOpenType == luaEnumAuctionPanelType.Guess then
        self:GetTradePanelTemplate():RefreshCoinShow()
    end
end

--region 竞价
---直接竞价
---@param data AuctionBidData
function UIAuctionPanel.OpenBidItemPanel(msgID, data)
    local bidItem = UIAuctionPanel.mCurrentChooseAuctionItemInfo
    if data == nil or bidItem == nil then
        return
    end

    local lid = data.lid
    local go = data.go

    local bidPriceType = bidItem.price.itemId

    if lid == bidItem.item.lid then
        local price = Utility.GetBidPrice(bidItem, 1)
        if Utility.IsCoinEnough(price, bidPriceType) then
            UIAuctionPanel.mAuctionBuyItemId = nil--竞拍飞背包，所以清空选中
            networkRequest.ReqAuctionLot(lid, Utility.EnumToInt(CS.auctionV2.AuctionType.BID))
            uimanager:ClosePanel("UIPetInfoPanel")
            uimanager:ClosePanel("UIItemInfoPanel")
        else
            if bidPriceType == LuaEnumCoinType.Diamond then
                --钻石竞价
                --改为跳转充值
                uimanager:ClosePanel("UIPetInfoPanel")
                uimanager:ClosePanel("UIItemInfoPanel")
                -- Utility.ShowPopoTips(go, UIAuctionPanel:GetBidPromptDes(), 78)
                Utility.JumpRechargePanel(go)
            else
                --元宝竞价
                local EntranceType
                uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.AuctionIngotNotEnough
                EntranceType = LuaEnumRechargePointType.AuctionIngotNotEnoughToRewardGift
                Utility.ShowItemGetWay(bidPriceType, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(100, 0), nil, EntranceType, "UIAuctionItemPanel");
            end
        end
    end
end
--endregion

--region 直接购买
---一口价
function UIAuctionPanel.OpenAuctionBuyItemPanel(msgID, data)
    local lid = data.lid
    local go = data.go
    --直接购买
    if UIAuctionPanel.mCurrentChooseAuctionItemInfo and lid == UIAuctionPanel.mCurrentChooseAuctionItemInfo.item.lid then
        local bidItem = UIAuctionPanel.mCurrentChooseAuctionItemInfo
        local price = bidItem.auctionItemLotInfo.fixedPrice
        local bidPriceType = bidItem.price.itemId
        if Utility.IsCoinEnough(price, bidPriceType) then
            ---背包空间是否足够
            if not CS.CSScene.MainPlayerInfo.BagInfo:CheckIsAbleToAddItemOfNumbers(UIAuctionPanel.mCurrentChooseAuctionItemInfo.item.ItemTABLE, 1) then
                Utility.ShowPopoTips(go, nil, 422, "UIItemInfoPanel")
                return
            end
            networkRequest.ReqAuctionLot(lid, Utility.EnumToInt(CS.auctionV2.AuctionType.ONEPRICE))

            uimanager:ClosePanel("UIPetInfoPanel")
            uimanager:ClosePanel("UIItemInfoPanel")
        else
            if bidPriceType == LuaEnumCoinType.Diamond then
                --钻石一口价
                Utility.JumpRechargePanel(go)
                uimanager:ClosePanel("UIPetInfoPanel")
                uimanager:ClosePanel("UIItemInfoPanel")
            elseif bidPriceType == LuaEnumCoinType.YuanBao then
                --元宝一口价
                local EntranceType
                uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.AuctionIngotNotEnough
                EntranceType = LuaEnumRechargePointType.AuctionIngotNotEnoughToRewardGift
                Utility.ShowItemGetWay(bidPriceType, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(100, 0), nil, EntranceType, "UIAuctionItemPanel");
            end
        end
    end
end

---判断自己道具是否足够购买
function UIAuctionPanel:IsBuyCostEnough(price)
    local isEnough = false
    local selfCost = self:GetBagInfoV2():GetAuctionDiamondNum()
    if Utility.IsAuctionDiamondQuotaOpen then
        local diamond = self:GetPlayerInfo().Data.auctionDiamond
        isEnough = price <= math.ceil(selfCost) and price <= diamond
    else
        isEnough = price <= math.ceil(selfCost)
    end
    return isEnough
end
--endregion
--endregion

--region 个人竞拍
---收到个人竞拍
function UIAuctionPanel:OnResGetAuctionShelfMessageReceived()
    self:GetSelfAuctionPanelTemplate():RefreshListShow()
end

---竞拍重新上架
function UIAuctionPanel:OnAuctionItemReAddMessageReceived(auctionInfo)
    if self.mCurrentOpenType == luaEnumAuctionPanelType.SelfAuction then
        self:GetSelfAuctionPanelTemplate():OnReAddGridClickedFunc(auctionInfo)
    end
end
--endregion

--region 求购
---打开求购界面
function UIAuctionPanel:SwitchToBuyingPanel()
    self:SwitchToPanel(luaEnumAuctionPanelType.Buying)
    self:GetBuyingPanelTemplate():ShowPanel()
    self.IsOpenBag = false
end

---跳转个人求购界面
function UIAuctionPanel:SwitchToSelfBuyingPanel()
    self:GetSelfBuyingPanelTemplate()
    self:SwitchToPanel(luaEnumAuctionPanelType.SelfBuying)
    self.IsOpenBag = true
end

---移除道具
function UIAuctionPanel.OnResAuctionBuyRemoveItem(msgId, isExpire)
    if UIAuctionPanel.mCurrentOpenType == luaEnumAuctionPanelType.SelfBuying then
        UIAuctionPanel:GetSelfBuyingPanelTemplate().BuyingMenuTemplate:SaveRemoveData(isExpire)
    end
end

--endregion

--region 页签适配
UIAuctionPanel.mBookMarkName = {
    [luaEnumAuctionPanelType.Trade] = "交易行",
    [luaEnumAuctionPanelType.UnionAuction] = "行会竞拍",
    [luaEnumAuctionPanelType.Auction] = "竞拍行",
    [luaEnumAuctionPanelType.Buying] = "求购行",
    [luaEnumAuctionPanelType.Smelt] = "装备行",
    [luaEnumAuctionPanelType.TransactionRecord] = "交易记录",
    [luaEnumAuctionPanelType.ShareStall] = "跨服摆摊"
}
UIAuctionPanel.mBookMarkRedPoint = {
    [luaEnumAuctionPanelType.TransactionRecord] = CS.RedPointKey.AuctionTransactionRecord
}

---刷新页签显示
function UIAuctionPanel:RefreshToggleShow()
    local mShowToggleType = {}
    table.insert(mShowToggleType, luaEnumAuctionPanelType.Trade)

    --[[    if LuaGlobalTableDeal.GetIsOpenSmeltAuction() then
            table.insert(mShowToggleType, luaEnumAuctionPanelType.Smelt)
        end]]

    local isShowAuctionToggle = CS.CSScene.MainPlayerInfo.AuctionInfo:IsAuctionOpen()
    if isShowAuctionToggle then
        table.insert(mShowToggleType, luaEnumAuctionPanelType.Auction)
    end

    if self:IsShowUnionAuctionToggle() then
        table.insert(mShowToggleType, luaEnumAuctionPanelType.UnionAuction)
    end

    local isShowBuyingToggle = CS.CSScene.MainPlayerInfo.AuctionInfo:IsAuctionBuyingOpen()
    if isShowBuyingToggle then
        --table.insert(mShowToggleType, luaEnumAuctionPanelType.Buying)
    end

    table.insert(mShowToggleType, luaEnumAuctionPanelType.TransactionRecord)

    if Utility.IsOpenShareStall() then
        table.insert(mShowToggleType, luaEnumAuctionPanelType.ShareStall)
    end

    self:GetToggleArea_UIGridContainer().MaxCount = #mShowToggleType
    self.mGoToType = {}
    for i = 0, #mShowToggleType - 1 do
        local go = self:GetToggleArea_UIGridContainer().controlList[i]
        local type = mShowToggleType[i + 1]
        self.mGoToType[go] = type
        self:RefreshToggleState(go, type)
        local name1 = CS.Utility_Lua.Get(go.transform, "Background/label", "UILabel")
        local name2 = CS.Utility_Lua.Get(go.transform, "checkmark/label", "UILabel")
        ---@type UIRedPoint
        local redPoint = CS.Utility_Lua.Get(go.transform, "redPoint", "UIRedPoint")
        if not CS.StaticUtility.IsNull(name1) then
            name1.text = self.mBookMarkName[type]
        end
        if not CS.StaticUtility.IsNull(name2) then
            name2.text = self.mBookMarkName[type]
        end
        local redPointCall = self.mBookMarkRedPoint[type]
        if redPointCall then
            redPoint:AddRedPointKey(redPointCall)
        end
    end
end

---@param go UnityEngine.GameObject
---刷新单个Toggle
function UIAuctionPanel:RefreshToggleState(go, type)
    ---@type table<number,UIToggle>
    if self.mTypeToToggle == nil then
        self.mTypeToToggle = {}
    end
    local toggle = CS.Utility_Lua.GetComponent(go.transform, "UIToggle")
    self.mTypeToToggle[type] = toggle
    if not CS.StaticUtility.IsNull(toggle) then
        CS.EventDelegate.Add(toggle.onChange, function()
            self.IsOpenBag = false
            if toggle.value then
                self:ChooseToggleState(type)
            end
            Utility.HideBackGround(toggle, "Background", toggle.value)
        end)
    end
end

---对应Toggle选中
function UIAuctionPanel:ChooseToggleState(type)
    if type == luaEnumAuctionPanelType.Trade then
        if self.IsOpenBag then
            self:SwitchToSellPanel()
        else
            self:SwitchToTradePanel()
        end
    elseif type == luaEnumAuctionPanelType.Auction then
        if self.IsOpenBag then
            self:SwitchToSelfAuctionPanel()
        else
            self:SwitchToAuctionPanel()
        end
    elseif type == luaEnumAuctionPanelType.Buying then
        if self.IsOpenBag then
            self:SwitchToSelfBuyingPanel()
        else
            self:SwitchToBuyingPanel()
        end
    else
        self:SwitchToPanel(type)
    end
    if type ~= luaEnumAuctionPanelType.Trade then
        self:RemoveTradeBubbleTips()
    end
end

---@return boolean 是否显示行会竞拍页签
function UIAuctionPanel:IsShowUnionAuctionToggle()
    if self:GetPlayerInfo() then
        return self:GetPlayerInfo().UnionInfoV2.UnionID ~= 0
    end
    return false
end

---设置标题页签选中
---@param openType luaEnumAuctionPanelType
function UIAuctionPanel:SetTitleToggleChoose(openType)
    self.mCurrentOpenType = openType
    local toggleType
    if openType == luaEnumAuctionPanelType.Trade or openType == luaEnumAuctionPanelType.Guess then
        self.IsOpenBag = false
        toggleType = luaEnumAuctionPanelType.Trade
        self.mIsNeedPushBubble = true
    elseif openType == luaEnumAuctionPanelType.Auction then
        self.IsOpenBag = false
        toggleType = luaEnumAuctionPanelType.Auction
    elseif openType == luaEnumAuctionPanelType.Buying then
        self.IsOpenBag = false
        toggleType = luaEnumAuctionPanelType.Buying
    elseif openType == luaEnumAuctionPanelType.SelfSell then
        self.IsOpenBag = true
        toggleType = luaEnumAuctionPanelType.Trade
    elseif openType == luaEnumAuctionPanelType.SelfAuction then
        self.IsOpenBag = true
        toggleType = luaEnumAuctionPanelType.Auction
    elseif openType == luaEnumAuctionPanelType.SelfBuying then
        self.IsOpenBag = true
        toggleType = luaEnumAuctionPanelType.Buying
    elseif openType == luaEnumAuctionPanelType.TransactionRecord then
        toggleType = luaEnumAuctionPanelType.TransactionRecord
    elseif openType == luaEnumAuctionPanelType.Smelt then
        toggleType = luaEnumAuctionPanelType.Smelt
    elseif openType == luaEnumAuctionPanelType.ShareStall then
        self.IsOpenBag = true
        toggleType = luaEnumAuctionPanelType.ShareStall
    else
        toggleType = openType
    end

    if self.mTypeToToggle then
        local toggle = self.mTypeToToggle[toggleType]
        if toggle then
            toggle:Set(true)
        end
    end
end
--endregion

--region UI事件
---跳转界面
function UIAuctionPanel:SwitchToPanel(panelType)
    local lastType = self.mCurrentOpenType

    self.mCurrentOpenType = panelType
    self:GetTradePanel_GameObject():SetActive(panelType == luaEnumAuctionPanelType.Trade or panelType == luaEnumAuctionPanelType.Guess)
    self.GetAuctionPanel_GameObject():SetActive(panelType == luaEnumAuctionPanelType.Auction)
    self.GetBuyingPanel_GameObject():SetActive(panelType == luaEnumAuctionPanelType.Buying)
    self.GetSelfSellPanel_GameObject():SetActive(panelType == luaEnumAuctionPanelType.SelfSell)
    self.GetBagPanel_GameObject():SetActive(panelType == luaEnumAuctionPanelType.SelfSell or
            panelType == luaEnumAuctionPanelType.SelfAuction or
            panelType == luaEnumAuctionPanelType.ShareStall)
    self.GetSelfAuctionPanel_GameObject():SetActive(panelType == luaEnumAuctionPanelType.SelfAuction)
    self.GetSelfBuyingPanel_GameObject():SetActive(panelType == luaEnumAuctionPanelType.SelfBuying)
    self:SwitchToTransactionRecordPanel(panelType == luaEnumAuctionPanelType.TransactionRecord)
    local menuShow = self.mCurrentOpenType == luaEnumAuctionPanelType.Smelt or
            self.mCurrentOpenType == luaEnumAuctionPanelType.UnionAuction
    uimanager:ClosePanel("UIAuctionMenuPanel")
    self:SwitchToSmeltPanel(panelType == luaEnumAuctionPanelType.Smelt, menuShow)

    self:SwitchToUnionAuctionPanel(panelType == luaEnumAuctionPanelType.UnionAuction, menuShow)

    self:SwitchToTransShareStallPanel(panelType == luaEnumAuctionPanelType.ShareStall)
end

---出售跳转页签
function UIAuctionPanel:SellBackTab()
    -- UIAuctionPanel:GetTradePanelTemplate():GetMenuControllerTemplate():OpenPage(self.mJumpID)
    -- UIAuctionPanel:GetTradePanelTemplate():GetMenuControllerTemplate():SetToggleViewSpring(180)
    UIAuctionPanel:GetTradePanelTemplate():SetFirstItemChoose()
end

---@return TABLE.CFG_ITEMS 获取item缓存数据
function UIAuctionPanel:GetItemCache(itemId)
    if itemId then
        if self.mItemIdToInfo == nil then
            self.mItemIdToInfo = {}
        end
        local data = self.mItemIdToInfo[itemId]
        if data == nil then
            ___, data = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
            self.mItemIdToInfo[itemId] = data
        end
        return data
    end
end

--endregion

--region 交易记录
---@return
function UIAuctionPanel:SwitchToTransactionRecordPanel(isShow)
    local panelName = "UIAuctionTransactionRecordPanel"
    ---@type UIAuctionTransactionRecordPanel
    local panel = self:GetPanel(panelName, isShow)
    if panel then
        panel.go:SetActive(isShow)
        if isShow then
            panel:Show()
        end
    end
end
--endregion

--region 熔炼行
---@class AuctionMenuData 熔炼行目录数据
---@field template

---@class AuctionSmeltPanelData
---@field mSelectItemNameData AuctionSelectItemByNameData 根据文本和道具id选中道具

---@class AuctionSelectItemByNameData 熔炼行目录根据名字索引数据
---@field mName string  名字
---@field mItemId number  道具id
---@field mChooseNum number  选中个数

---打开熔炼行
function UIAuctionPanel:SwitchToSmeltPanel(isShow, menuShow)
    local panelName = "UIAuctionSmeltPanel"
    local memuName = "UIAuctionMenuPanel"
    --目录数据

    ---@type AuctionMenuData
    local menuCustomData = {}
    menuCustomData.template = luaComponentTemplates.UIAuctionSmeltPanel_MenuTemplate

    ---@type AuctionSmeltPanelData
    local smeltPanelData = {}
    if self.mAuctionPanelShowReason == LuaEnumAuctionTradePanelShowReason.SmeltPush and self.mCustomOwnData then
        ---@type AuctionSelectItemByNameData
        local SelectData = {}
        SelectData.mName = self.mCustomOwnData.mChooseName
        SelectData.mItemId = self.mCustomOwnData.mChooseItemId
        SelectData.mChooseNum = 1
        smeltPanelData.mSelectItemNameData = SelectData
        self.mCustomOwnData = nil
    end

    ---@type UIAuctionSmeltPanel
    local smeltPanel = self:GetPanel(panelName, isShow, smeltPanelData, function()
        self:GetPanel(memuName, isShow, menuCustomData)
    end)
    if smeltPanel then
        smeltPanel.go:SetActive(isShow)
        if isShow then
            smeltPanel:Show(smeltPanelData)
        else
            smeltPanel:CloseAllChoose()
        end

        ---@type UIAuctionMenuPanel
        local menuPanel = self:GetPanel(memuName, isShow, menuCustomData)
        if menuPanel then
            menuPanel.go:SetActive(menuShow)
            if isShow then
                menuPanel:Show(menuCustomData)
            end
        end
    end
end

function UIAuctionPanel:CreateMenu()

end

---endregion

--endregion

--region 行会竞拍
---@class UnionAuctionMemuData 熔炼行目录数据
---@field template

---@class UnionAuctionPanelData
---@field mSelectItemNameData AuctionSelectItemByNameData 根据文本和道具id选中道具

---打开行会竞拍
function UIAuctionPanel:SwitchToUnionAuctionPanel(isShow, menuShow)
    local panelName = "UIAuctionUnionPanel"
    local memuName = "UIAuctionMenuPanel"
    --目录数据

    ---@type AuctionMenuData
    local menuCustomData = {}
    menuCustomData.template = luaComponentTemplates.UIAuctionUnionPanel_MenuTemplate

    ---@type AuctionSmeltPanelData
    local smeltPanelData = {}
    if self.mAuctionPanelShowReason == LuaEnumAuctionTradePanelShowReason.SmeltPush and self.mCustomOwnData then
        ---@type AuctionSelectItemByNameData
        local SelectData = {}
        SelectData.mName = self.mCustomOwnData.mChooseName
        SelectData.mItemId = self.mCustomOwnData.mChooseItemId
        SelectData.mChooseNum = 1
        smeltPanelData.mSelectItemNameData = SelectData
        self.mCustomOwnData = nil
    end

    ---@type UIAuctionUnionPanel
    local auctionUnionPanel = self:GetPanel(panelName, isShow, smeltPanelData, function()
        self:GetPanel(memuName, isShow, menuCustomData)
    end)
    if auctionUnionPanel then
        auctionUnionPanel.go:SetActive(isShow)
        if isShow then
            auctionUnionPanel:Show(smeltPanelData)
        else
            -- auctionUnionPanel:CloseAllChoose()
        end

        ---@type UIAuctionMenuPanel
        local menuPanel = self:GetPanel(memuName, isShow, menuCustomData)
        if menuPanel then
            menuPanel.go:SetActive(menuShow)
            if isShow then
                menuPanel:Show(menuCustomData)
            end
        end
    end
end
---endregion

--endregion

--region 个人熔炼
---打开个人熔炼
function UIAuctionPanel:SwitchToSelfSmeltPanel(isShow)
    local panelName = ""
    ---@type
    local panel = self:GetPanel(panelName, isShow)
    if panel then
        panel.go:SetActive(isShow)
        if isShow then
            panel:Show()
        end
    end
end
--endregion

--region 跨服摆摊
---@return
function UIAuctionPanel:SwitchToTransShareStallPanel(isShow)
    ---@type UIServerSelfSellPanel
    local panel = self:GetPanel("UIServerSelfSellPanel", isShow)
    if panel then
        panel.go:SetActive(isShow)
        if isShow then
            panel:Show()
        end
    end

    if self:GetBagPanelTemplate() then
        self:GetBagPanelTemplate():RefreshList(luaEnumAuctionPanelType.SelfSell)
        if self.mOpenBagChooseItemLid then
            self:GetBagPanelTemplate():SetItemChoose(self.mOpenBagChooseItemLid, true)
        end
    end
    UIAuctionPanel.IsOpenBag = true
end
--endregion

---存储界面
function UIAuctionPanel:GetPanel(name, isShow, customData, callBack)
    if self.mNeedClosePanel == nil then
        self.mNeedClosePanel = {}
    end
    local getPanel = uimanager:GetPanel(name)
    if getPanel == nil and isShow then
        uimanager:CreatePanel(name, function(panel)
            getPanel = panel
            self.mNeedClosePanel[name] = panel
            if callBack then
                callBack()
            end
        end, customData)
    end
    return getPanel
end
--endregion

function update()
    UIAuctionPanel:GetBuyingPanelTemplate():GetAuctionBuyingBagInteraction():OnUpdate(CS.UnityEngine.Time.time)
end

---清理求购缓存item表数据
function UIAuctionPanel:ClearAuctionBuyingData()
    CS.Cfg_ItemsTableManager.Instance:ClearAuctionData()
end

--region ondestroy
function ondestroy()
    UIAuctionPanel:ClearAuctionBuyingData()
    UIAuctionPanel:RemoveTradeBubbleTips()
    for k, v in pairs(UIAuctionPanel.mNeedClosePanel) do
        uimanager:ClosePanel(v)
    end
    UIAuctionPanel:GetAuctionInfoV2():ClearStallParams()
end
--endregion

return UIAuctionPanel