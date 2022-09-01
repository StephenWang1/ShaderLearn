---@class UIStallPanel:UIBase
local UIStallPanel = {}

--region 道具飞入背包数据
---@type number 购买数目
UIStallPanel.mBuyNum = 1

---@type number 背包剩余格子数
UIStallPanel.mCurrentBagGridCount = nil

---@type number 背包当前所有数目
UIStallPanel.mCurrentBagHasItem = nil

---当前购买道具itemId
UIStallPanel.mStallBuyItemId = nil

---当前购买竞拍界面道具位置
UIStallPanel.mStallBuyItemPos = nil

---@return CSMainPlayerInfo 玩家信息
function UIStallPanel:GetPlayerInfo()
    if self.mPlayerInfo == nil then
        self.mPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mPlayerInfo
end

---@return CSBagInfoV2 背包
function UIStallPanel:GetBagInfoV2()
    if self.mBagInfoV2 == nil and self:GetPlayerInfo() then
        self.mBagInfoV2 = self:GetPlayerInfo().BagInfo
    end
    return self.mBagInfoV2
end

---@return UnityEngine.Vector3 背包位置
function UIStallPanel:GetBagPos()
    if self.mBagPos == nil then
        local mainChatPanel = uimanager:GetPanel("UIMainChatPanel")
        if mainChatPanel then
            self.mBagPos = mainChatPanel.btn_bag.transform.position
        end
    end
    return self.mBagPos
end

---@return UnityEngine.Vector3 邮件位置
function UIStallPanel:GetMainPos()
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
function UIStallPanel:GetCurrentTimeAimPos(itemId)
    local res, data = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
    if res and self.mCurrentBagGridCount and self.mCurrentBagHasItem and self.mBuyNum then
        local count = self.mCurrentBagGridCount
        local bagHas = self.mCurrentBagHasItem
        local leaveNum = data.overlying - bagHas % data.overlying
        local LimitBag = bagHas == 0 or (data.overlying ~= nil and bagHas ~= 0 and (leaveNum == data.overlying or leaveNum < self.mBuyNum))
        local isFlyMail = count == 0 and LimitBag
        return ternary(isFlyMail, self:GetMainPos(), self:GetBagPos())
    end
end

---存储购买前背包数据
function UIStallPanel:SaveBagData(itemId)
    self.mCurrentBagGridCount = self:GetBagInfoV2().EmptyGridCount
    self.mCurrentBagHasItem = self:GetBagInfoV2():GetItemCountByItemId(itemId)
end
--endregion

--region 组件
---@return UnityEngine.GameObject 未摆摊
function UIStallPanel:GetNoStallItem_Go()
    if self.mNoStallGo == nil then
        self.mNoStallGo = self:GetCurComp("WidgetRoot/StallPanel/NoStallItem", "GameObject")
    end
    return self.mNoStallGo
end

---是否是主角的摊位
---@return boolean
function UIStallPanel:IsMainPlayerStall()
    if self.boothInfo ~= nil then
        return self.boothInfo.IsMainPlayerBooth
    end
    return false
end

---摊位最大显示格子数量
function UIStallPanel:StallMaxShowGrid()
    return 8
end
--endregion

--region 初始化
function UIStallPanel:Init()
    self:InitComponent()
    self:BindEvent()
    self:BindNetMsg()
    --self:CreateBagPanel()
end

function UIStallPanel:InitComponent()
    self.titleName_UILabel = self:GetCurComp("WidgetRoot/window/name", "UILabel")
    self.boothList_UIGridContainer = self:GetCurComp("WidgetRoot/StallPanel/Scroll View/TradeSellList", "UIGridContainer")
    self.closeBtn = self:GetCurComp("WidgetRoot/window/event/Btn_Close", "GameObject")
    self.OpenActionStallPanelBtn = self:GetCurComp("WidgetRoot/events/btn_modify", "GameObject")
    self.btn_checkMoreCommodity = self:GetCurComp("WidgetRoot/events/btn_checkMoreCommodity", "GameObject")
    self.stall_ScrollView = self:GetCurComp("WidgetRoot/StallPanel/Scroll View", "UIScrollView")
end

function UIStallPanel:BindEvent()
    if self.closeBtn ~= nil then
        CS.UIEventListener.Get(self.closeBtn).onClick = self.ClosePanel
    end

    if self.OpenActionStallPanelBtn ~= nil then
        CS.UIEventListener.Get(self.OpenActionStallPanelBtn).onClick = self.OpenActionStallPanel
    end

    if self.btn_checkMoreCommodity ~= nil then
        CS.UIEventListener.Get(self.btn_checkMoreCommodity).onClick = self.CheckMoreCommodityBtnOnClick
    end

    self.StallItemBuyBtnOnClick = function(msgID, data)
        self:OpenBuyItemPanel(data)
    end

    if self.stall_ScrollView ~= nil then
        self.stall_ScrollView.onDragProgress = function()
            self:RefreshCheckMoreCommodityState()
        end
    end

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.AuctionStallItemChangeBuyState, self.StallItemBuyBtnOnClick)
end

function UIStallPanel:BindNetMsg()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBoothBuyMessage, UIStallPanel.OnResBoothBuyMessageReceived)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.StallBuyItem, UIStallPanel.OnStallBuyItemMessageReceived)
end

function UIStallPanel:InitParams()
    self.boothInfo = self.commonData.boothInfo
    self.csData = self.commonData.csData
    self.maxGirdNum = ternary(self.commonData.maxGirdNum == nil, 10, self.commonData.maxGirdNum)
    self.showItemList = ternary(self.csData == nil, nil, self.csData.items)
    self.gridsTemplate = {}
end
--endregion

--region 服务器消息
function UIStallPanel.OnResBoothBuyMessageReceived()
    local pos = UIStallPanel:GetCurrentTimeAimPos(UIStallPanel.mStallBuyItemId)
    if UIStallPanel.mStallBuyItemId and UIStallPanel.mStallBuyItemPos and pos then
        luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = UIStallPanel.mStallBuyItemId, from = UIStallPanel.mStallBuyItemPos, to = pos })
        UIStallPanel.mStallBuyItemId = nil
        UIStallPanel.mStallBuyItemPos = nil
        UIStallPanel.mCurrentBagGridCount = nil
    end
end
--endregion

--region 客户端消息
function UIStallPanel.OnStallBuyItemMessageReceived(id, num)
    UIStallPanel.mBuyNum = num
end
--endregion

--region 刷新
function UIStallPanel:Show(commonData)
    self.commonData = commonData
    if commonData == nil or commonData.csData == nil then
        uimanager:ClosePanel(self)
        return
    end
    self:InitParams()
    self:RefreshPanel()
end

function UIStallPanel:RefreshPanel()
    if self.titleName_UILabel ~= nil then
        self.titleName_UILabel.text = self.boothInfo.boothName
        self.titleName_UILabel.color = self.boothInfo.boothColor
    end
    if self.OpenActionStallPanelBtn ~= nil then
        self.OpenActionStallPanelBtn:SetActive(self:IsMainPlayerStall())
    end
    self:RefreshBoothList()
    self:RefreshCheckMoreCommodityState()
end

function UIStallPanel:RefreshBoothList()
    self:GetNoStallItem_Go():SetActive(self.csData.items.Count == 0 or self.csData == nil)
    if self.csData.items.Count == 0 or self.csData == nil then
        self.boothList_UIGridContainer.MaxCount = 0
    else
        if self.boothList_UIGridContainer ~= nil then
            self.boothList_UIGridContainer.MaxCount = self.maxGirdNum
            for k = 0, self.boothList_UIGridContainer.MaxCount - 1 do
                local v = self.boothList_UIGridContainer.controlList[k]
                local template
                if self:IsShareStallPanel() then
                    ---@type UIStallPanel_ShareGridTemplate
                    template = templatemanager.GetNewTemplate(v, luaComponentTemplates.UIStallPanel_ShareGridTemplate, self)
                else
                    ---@type UIStallPanel_GridTemplate
                    template = templatemanager.GetNewTemplate(v, luaComponentTemplates.UIStallPanel_GridTemplate, self)
                end
                template.gridIndex = k
                self.gridsTemplate[v] = template
                self:RefeshGrid(v)
            end
        end
    end
end

---刷新跳转贸易面板按钮状态
function UIStallPanel:RefreshCheckMoreCommodityState()
    if self.btn_checkMoreCommodity ~= nil then
        local checkMoreCommodityBtnState = self:GetCheckMoreCommodityState() and self:IsMainPlayerStall() == false
        self.btn_checkMoreCommodity:SetActive(checkMoreCommodityBtnState)
    end
end

function UIStallPanel:RefeshGrid(gridGameObject)
    if self.gridsTemplate ~= nil and self.gridsTemplate[gridGameObject] ~= nil and self.showItemList ~= nil then
        local mGridTemplate = self.gridsTemplate[gridGameObject]
        local gridIndex = mGridTemplate.gridIndex
        local auctionItemInfo = nil
        if self.showItemList.Count - 1 >= gridIndex then
            auctionItemInfo = self.showItemList[gridIndex]
        end
        mGridTemplate:RefreshUI(auctionItemInfo)
    end
end

function UIStallPanel:ResBoothBuyMessageeReceived(msgID, tblData, csData)
    local mMaxGridNum = CS.Cfg_GlobalTableManager.Instance:GetBoothGridMaxNum()
    self.showItemList = ternary(csData == nil or csData.items == nil, self.showItemList, csData.items)
    self.maxGirdNum = ternary(#tblData.items > mMaxGridNum, #tblData, mMaxGridNum)
    self:RefreshBoothList()
end

function UIStallPanel:CreateBagPanel()
    uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Stall })
end

function UIStallPanel.ClosePanel()
    uimanager:ClosePanel("UIStallPanel")
    uimanager:ClosePanel("UIBagPanel")
end

function UIStallPanel.OpenActionStallPanel()
    if UIStallPanel:IsShareStallPanel() then
        uiTransferManager:TransferToPanel(LuaEnumTransferType.ShareSell_Stall)
        return
    end

    uiStaticParameter.OpenAuctionStallPanelType = LuaEnumOpenAuctionStallPanelType.SelfStall
    networkRequest.ReqBoothMaps()
end

function UIStallPanel.CheckMoreCommodityBtnOnClick()
    uimanager:CreatePanel("UIAuctionPanel")
end

function UIStallPanel:OpenBuyItemPanel(data)
    ---改为直接购买
    if data then
        local lid = data.lid
        local go = data.go
        local stallGridTemplate = self:GetGridTemplateByBagItemInfoLid(lid)
        local price = stallGridTemplate.AuctionInfo.price.count
        local priceItemID = stallGridTemplate.AuctionInfo.price.itemId
        if self:IsCostEnough(price, priceItemID) then
            networkRequest.ReqBoothBuy(uiStaticParameter.BoothLid, lid, 1)
            uimanager:ClosePanel("UIPetInfoPanel")
            uimanager:ClosePanel("UIItemInfoPanel")
        else
            if priceItemID == LuaEnumCoinType.YuanBao then
                self:ShowMoneyNotEnoughTips(go)
            else
                Utility.JumpRechargePanel(go)
                uimanager:ClosePanel("UIPetInfoPanel")
                uimanager:ClosePanel("UIItemInfoPanel")
            end
        end
    end
    --[[
    local stallGridTemplate = self:GetGridTemplateByBagItemInfoLid(bagItemInfoLid)
    if stallGridTemplate == nil then
        return
    end
    local commonData = {}
    commonData.Template = luaComponentTemplates.UIAuctionItemPanel_StallPanel
    commonData.AuctionInfo = stallGridTemplate.AuctionInfo
    commonData.BagItemInfo = stallGridTemplate.BagItemInfo
    uimanager:CreatePanel('UIAuctionItemPanel', nil, commonData)
    --]]
end

---判断自己道具是否足够购买
function UIStallPanel:IsCostEnough(price, PriceId)
    local isEnough = false
    if price then
        local playerHas
        if PriceId == LuaEnumCoinType.YuanBao then
            playerHas = self:GetPlayerHas()
        elseif PriceId == LuaEnumCoinType.Diamond then
            playerHas = Utility.GetAuctionDiamondNum()
        end
        if playerHas then
            isEnough = playerHas >= math.ceil(price)
        end
    end
    return isEnough
end

---刷新玩家拥有
function UIStallPanel:GetPlayerHas()
    local selfCost = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCurCoinAmount(LuaEnumCoinType.YuanBao)
    return selfCost
end

---显示道具不足提示
function UIStallPanel:ShowMoneyNotEnoughTips(go)
    local str = nil
    local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(78)
    if isfind then
        local itemName = self:GetTradePriceItemInfo().name
        str = string.format(data.content, itemName)
        Utility.ShowPopoTips(go, str, 78)
        -- Utility.ShowPopoTips(go, str, 78, "UIAuctionItemPanel", { itemid = LuaEnumCoinType.YuanBao })
    end
end

---@return TABLE.CFG_ITEMS 元宝交易行货币信息
function UIStallPanel:GetTradePriceItemInfo()
    if self.mCoinInfo == nil then
        ___, self.mCoinInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(LuaEnumCoinType.YuanBao)
    end
    return self.mCoinInfo
end
--endregion

--region 获取
---通过物品唯一id获取拍卖行格子物品模板
function UIStallPanel:GetGridTemplateByBagItemInfoLid(bagItemInfoLid)
    for k, v in pairs(self.gridsTemplate) do
        if v ~= nil and v.BagItemInfo ~= nil and bagItemInfoLid == v.BagItemInfo.lid then
            return v
        end
    end
    return nil
end

---获取跳转贸易面板按钮显示状态
function UIStallPanel:GetCheckMoreCommodityState()
    if Utility.RightUpNoticeIsOpen(11) == false then
        return false
    end
    if self:IsShareStallPanel() then
        return false
    end
    if self.maxGirdNum <= self:StallMaxShowGrid() then
        self.checkMoreCommodityBtnState = true
    elseif self.maxGirdNum > self:StallMaxShowGrid() and self.stall_ScrollView ~= nil and self.stall_ScrollView:GetScrollViewSoftState(true) == CS.UIScrollView.ScrollViewSoftState.Buttom then
        self.checkMoreCommodityBtnState = true
    else
        self.checkMoreCommodityBtnState = false
    end
    return self.checkMoreCommodityBtnState
end
--endregion

function UIStallPanel:IsShareStallPanel()
    return self.boothInfo and self.boothInfo.Data and self.boothInfo.Data.type == 1
end

--region OnDestroy
function ondestroy()
    UIStallPanel:OnDestroy()
end

function UIStallPanel:OnDestroy()
    --luaEventManager.RemoveCallback(LuaCEvent.AuctionStallItemChangeBuyState, self.StallItemBuyBtnOnClick)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBoothBuyMessage, UIStallPanel.OnResBoothBuyMessageReceived)
    --luaEventManager.RemoveCallback(LuaCEvent.StallBuyItem, UIStallPanel.OnStallBuyItemMessageReceived)
end
--endregion

return UIStallPanel