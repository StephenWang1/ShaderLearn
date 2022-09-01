---交易行快捷购买的物品数量选择界面
---@class UIAuctionQuickBuyItemAmountPanel:UIBase
local UIAuctionQuickBuyItemAmountPanel = {}

---@return UIPanel
function UIAuctionQuickBuyItemAmountPanel:GetUIPanel()
    if self.mUIPanel == nil then
        self.mUIPanel = self:GetCurComp("", "UIPanel")
    end
    return self.mUIPanel
end

---@return UISprite
function UIAuctionQuickBuyItemAmountPanel:GetPurchaseButtonWidget()
    if self.mPurchaseButtonWidget == nil then
        self.mPurchaseButtonWidget = self:GetCurComp("WidgetRoot/view/dispose", "UIWidget")
    end
    return self.mPurchaseButtonWidget
end

---背景图
---@return UISprite
function UIAuctionQuickBuyItemAmountPanel:GetBackGround_UISprite()
    if self.mBackGroundSprite == nil then
        self.mBackGroundSprite = self:GetCurComp("WidgetRoot/window/background", "UISprite")
    end
    return self.mBackGroundSprite
end

---数量选取输入框
---@return UIInput
function UIAuctionQuickBuyItemAmountPanel:GetAmountChooseUIInput()
    if self.mAmountChooseUIInput == nil then
        self.mAmountChooseUIInput = self:GetCurComp("WidgetRoot/view/Num/inputcount", "UIInput")
    end
    return self.mAmountChooseUIInput
end

---减少数量按钮
---@return UnityEngine.GameObject
function UIAuctionQuickBuyItemAmountPanel:GetMinusBtn()
    if self.mMinusBtnGo == nil then
        self.mMinusBtnGo = self:GetCurComp("WidgetRoot/view/Num/reduce", "GameObject")
    end
    return self.mMinusBtnGo
end

---增加数量按钮
---@return UnityEngine.GameObject
function UIAuctionQuickBuyItemAmountPanel:GetAddBtn()
    if self.mAddBtnGo == nil then
        self.mAddBtnGo = self:GetCurComp("WidgetRoot/view/Num/add", "GameObject")
    end
    return self.mAddBtnGo
end

---获取货币格子
---@return UIGridContainer
function UIAuctionQuickBuyItemAmountPanel:GetCoinGridContainer()
    if self.mCoinGridContainer == nil then
        self.mCoinGridContainer = self:GetCurComp("WidgetRoot/view/Coin", "UIGridContainer")
    end
    return self.mCoinGridContainer
end

function UIAuctionQuickBuyItemAmountPanel:Init()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:RefreshUI()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        self:RefreshUI()
    end)
    CS.UIEventListener.Get(self:GetPurchaseButtonWidget().gameObject).onClick = function(go)
        self:OnPurchaseButtonClicked(go)
    end
    CS.UIEventListener.Get(self:GetMinusBtn()).onClick = function()
        self:OnMinusBtnClicked()
    end
    CS.UIEventListener.Get(self:GetAddBtn()).onClick = function()
        self:OnAddBtnClicked()
    end
    CS.EventDelegate.Add(self:GetAmountChooseUIInput().onChange, function()
        self:OnAmountChanged()
    end)
end

---@alias UIAuctionQuickBuyItemAmountPanelCustomData {clickCallBack:fun(buyCount:number),auctionItemInfo:auctionV2.AuctionItemInfo}
---@param customData UIAuctionQuickBuyItemAmountPanelCustomData
function UIAuctionQuickBuyItemAmountPanel:Show(customData)
    if customData == nil or customData.clickCallBack == nil or customData.auctionItemInfo == nil then
        self:ClosePanel()
        return
    end
    self.customData = customData
    self.mAmount = 1
    self.mMinAmount = 1
    self.mMaxAmount = self.customData.auctionItemInfo.item.count
    self:GetAmountChooseUIInput().validation = CS.UIInput.Validation.Integer
    self:RefreshUI()
    self:AddCollider()
    self:GetUIPanel().alpha = 0.1
    uiStaticParameter.UIItemInfoManager:CreatePanel({
        bagItemInfo = self.customData.auctionItemInfo.item,
        showRight = false,
        showAssistPanel = false,
        isCloseCollider = true,
        refreshEndFunc = function()
            self:GetUIPanel().alpha = 1
            self:RefreshLinks()
        end, })
end

---刷新UI
---@public
function UIAuctionQuickBuyItemAmountPanel:RefreshUI()
    if self.customData == nil or self.customData.auctionItemInfo == nil or self.customData.auctionItemInfo.price == nil then
        return
    end
    self:GetCoinGridContainer().MaxCount = 2
    local singlePriceGo = self:GetCoinGridContainer().controlList[0]
    local obtainCoinGo = self:GetCoinGridContainer().controlList[1]
    ---刷新单价
    ---@type UILabel
    local singlePriceLabel = self:GetComp(singlePriceGo.transform, "gold", "UILabel")
    ---@type UILabel
    local singlePriceTitle = self:GetComp(singlePriceGo.transform, "Label", "UILabel")
    ---@type UISprite
    local singlePriceIcon = self:GetComp(singlePriceGo.transform, "Sprite", "UISprite")
    local singlePriceData = self.customData.auctionItemInfo.price
    singlePriceTitle.text = "价格"
    local summaryPrice = singlePriceData.count * self.mAmount
    singlePriceLabel.text = tostring(summaryPrice)
    local singlePriceItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(singlePriceData.itemId)
    if singlePriceItemTbl then
        singlePriceIcon.spriteName = singlePriceItemTbl:GetIcon()
    else
        singlePriceIcon.spriteName = ""
    end
    ---刷新背包货币数据
    ---@type UILabel
    local obtainCoinLabel = self:GetComp(obtainCoinGo.transform, "gold", "UILabel")
    ---@type UILabel
    local obtainCoinTitle = self:GetComp(obtainCoinGo.transform, "Label", "UILabel")
    ---@type UISprite
    local obtainCoinIcon = self:GetComp(obtainCoinGo.transform, "Sprite", "UISprite")
    local bagAmount
    if (singlePriceData.itemId == LuaEnumAuctionTradeCoinSortType.YuanBao) then
        bagAmount = CS.CSScene.MainPlayerInfo.BagInfo:GetAuctionIngotNum()
    else
        bagAmount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(singlePriceData.itemId) +
                gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(singlePriceData.itemId)
    end

    obtainCoinTitle.text = "拥有"
    if singlePriceItemTbl then
        obtainCoinIcon.spriteName = singlePriceItemTbl:GetIcon()
    else
        obtainCoinIcon.spriteName = ""
    end
    if bagAmount >= summaryPrice then
        obtainCoinLabel.text = tostring(bagAmount)
    else
        obtainCoinLabel.text = "[ff0000]" .. tostring(bagAmount)
    end
    ---调整背景和按钮位置
    local bgHeight = 40 + self:GetCoinGridContainer().MaxCount * self:GetCoinGridContainer().CellHeight
            + self:GetPurchaseButtonWidget().height + self:GetAmountChooseUIInput().label.height
    self:GetBackGround_UISprite().height = bgHeight
    local pos = self:GetPurchaseButtonWidget().transform.localPosition
    pos.y = -35
    self:GetPurchaseButtonWidget().transform.localPosition = pos
end

---减少数量事件
---@private
function UIAuctionQuickBuyItemAmountPanel:OnMinusBtnClicked()
    local amount = self.mAmount - 1
    if amount <= 0 then
        amount = self.mMaxAmount
    end
    self:SetAmount(amount)
end

---增加数量事件
---@private
function UIAuctionQuickBuyItemAmountPanel:OnAddBtnClicked()
    local amount = self.mAmount + 1
    if amount > self.mMaxAmount then
        amount = self.mMaxAmount
    end
    self:SetAmount(amount)
end

function UIAuctionQuickBuyItemAmountPanel:SetAmount(amount)
    self.mIsSetBySelf = true
    self.mAmount = amount or 1
    self:GetAmountChooseUIInput().value = tostring(self.mAmount)
    self.mIsSetBySelf = false
end

---数量变化事件
---@private
function UIAuctionQuickBuyItemAmountPanel:OnAmountChanged()
    if self.mIsSetBySelf then
        self:RefreshUI()
        return
    end
    local str = self:GetAmountChooseUIInput().value
    local amount = tonumber(str)
    if amount ~= nil then
        self.mAmount = amount
    else
        self:SetAmount(self.mAmount)
    end
    self:RefreshUI()
end

---购买按钮事件
---@private
function UIAuctionQuickBuyItemAmountPanel:OnPurchaseButtonClicked(go)
    local auctionItemInfo = self.customData.auctionItemInfo
    ---检查货币数量是否足够
    local amountInBag = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(auctionItemInfo.price.itemId) +
            gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(auctionItemInfo.price.itemId)
    if amountInBag < auctionItemInfo.price.count * self.mAmount then
        Utility.TryShowFirstRechargePanel()
        uimanager:ClosePanel('UIAuctionQuickBuyItemAmountPanel')
        return
    end
    ---检查背包容量
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.BagInfo == nil then
        return
    end
    local csItemExist, csItem = CS.Cfg_ItemsTableManager.Instance:TryGetValue(auctionItemInfo.item.itemId)
    if csItem == nil then
        return
    end
    if CS.CSScene.MainPlayerInfo.BagInfo:CheckIsAbleToAddItemOfNumbers(csItem, auctionItemInfo.item.count) == false then
        Utility.ShowPopoTips(go, "背包剩余空间不足", 290, "UIAuctionQuickBuyItemAmountPanel")
        return
    end
    if self.customData ~= nil and self.customData.clickCallBack ~= nil then
        self.customData.clickCallBack(self.mAmount or 1)
        self:ClosePanel()
    end
end

function UIAuctionQuickBuyItemAmountPanel:ClosePanel()
    self:RunBaseFunction("ClosePanel")
    uimanager:ClosePanel("UIItemInfoPanel")
end

function ondestroy()
    uimanager:ClosePanel("UIItemInfoPanel")
end

return UIAuctionQuickBuyItemAmountPanel