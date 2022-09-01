local UIAuctionSelling = {}

--region 初始化
function UIAuctionSelling:Init()
    self:AddCollider()
    self:InitConpoment()
    self:InitTemplate()
    self:BindEvent()
end

function UIAuctionSelling:InitConpoment()
    self.UIItem_GameObject = self:GetCurComp("WidgetRoot/view/UIItem", "GameObject")
    self.Count_UIInput = self:GetCurComp("WidgetRoot/view/Count", "UIInput")
    self.MinusBtn_GameObject = self:GetCurComp("WidgetRoot/view/Count/MinusBtn", "GameObject")
    self.PlusBtn_GameObject = self:GetCurComp("WidgetRoot/view/Count/PlusBtn", "GameObject")
    self.SellBtn_GameObject = self:GetCurComp("WidgetRoot/view/SellBtn", "GameObject")
    self.TotalPrice_GameObject = self:GetCurComp("WidgetRoot/view/TotalPrice", "GameObject")
    self.TradeTaxPrice_GameObject = self:GetCurComp("WidgetRoot/view/TradeTaxPrice", "GameObject")
    self.CloseBtn_GameObject = self:GetCurComp("WidgetRoot/event/CloseBtn", "GameObject")
    self.TotalPrice_UILabel = self:GetCurComp("WidgetRoot/view/TotalPrice/price", "UILabel")
    self.TotalIcon_UISprite = self:GetCurComp("WidgetRoot/view/TotalPrice/icon", "UISprite")
    self.TradePrice_UILabel = self:GetCurComp("WidgetRoot/view/TradeTaxPrice/price", "UILabel")
    self.TradeIcon_UISprite = self:GetCurComp("WidgetRoot/view/TradeTaxPrice/icon", "UISprite")
end

function UIAuctionSelling:InitTemplate()
    self.itemTemplate = templatemanager.GetNewTemplate(self.UIItem_GameObject, luaComponentTemplates.UIItem)
end

function UIAuctionSelling:BindEvent()
    CS.UIEventListener.Get(self.CloseBtn_GameObject).onClick = self.ClosePanel
    CS.UIEventListener.Get(self.MinusBtn_GameObject).onClick = function()
        self:reduceBtnClick()
    end
    CS.UIEventListener.Get(self.PlusBtn_GameObject).onClick = function()
        self:addBtnClick()
    end
    CS.UIEventListener.Get(self.SellBtn_GameObject).onClick = function()
        self:SellBtnClick()
    end
    CS.UIEventListener.Get(self.itemTemplate:GetItemIcon_UISprite().gameObject).onClick = function()
        self:IconClick()
    end
    self.Count_UIInput.submitOnUnselect = true
    CS.EventDelegate.Add(self.Count_UIInput.onSubmit, function()
        self:InputNum(self.Count_UIInput.value)
    end)
end

---@param customData.bagItemInfo 物品信息
---@param customData.beginCount 初始数量
---@param customData.minBuyCount 最少购买数量
---@param customData.maxBuyCount 最大购买数量
function UIAuctionSelling:Show(customData)
    if customData.bagItemInfo == nil then
        self:ClosePanel()
        return
    end
    self.bagItemInfo = customData.bagItemInfo
    self.beginCount = ternary(customData.beginCount == nil, 1, customData.beginCount)
    self.minBuyCount = ternary(customData.minBuyCount == nil, 1, customData.minBuyCount)
    self.maxBuyCount = ternary(customData.maxBuyCount == nil, 99, customData.maxBuyCount)
    self.singlePrice = ternary(customData.singlePrice == nil, 1, customData.singlePrice)
    self.priceBagItemInfo = ternary(customData.priceBagItemInfo == nil, nil, customData.priceBagItemInfo)
    self.sellCallBack = customData.sellCallBack

    local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.bagItemInfo.itemId)
    if itemInfoIsFind then
        self.itemInfo = itemInfo
        self.ratePrice = self:GetSingleRateValue(self.singlePrice, self.itemInfo, self:GetRateData(), self.beginCount)
    end
    self.ratePrice = ternary(self.ratePrice == nil, self.singlePrice, self.ratePrice)
    self.num = self.beginCount
    self:RefreshPanel()
end
--endregion

--region 点击事件
function UIAuctionSelling.ClosePanel()
    uimanager:ClosePanel("UIAuctionSelling")
end

function UIAuctionSelling:reduceBtnClick()
    local nowInputCount = tonumber(self.Count_UIInput.value)
    self.ratePrice = self:GetSingleRateValue(self.singlePrice, self.itemInfo, self:GetRateData(), nowInputCount)
    self.Count_UIInput.value = (ternary(nowInputCount > self.minBuyCount, tostring(nowInputCount - 1), tostring(nowInputCount)))
    self.TotalPrice_UILabel.text = ternary(nowInputCount > self.minBuyCount, tostring((nowInputCount - 1) * self.singlePrice), tostring(nowInputCount * self.singlePrice))
    self.TradePrice_UILabel.text = self:CheckHaveRemainder(ternary(nowInputCount > self.minBuyCount, tostring((nowInputCount - 1) * self.ratePrice), tostring(nowInputCount * self.ratePrice)))
end

function UIAuctionSelling:addBtnClick()
    local nowInputCount = tonumber(self.Count_UIInput.value)
    self.ratePrice = self:GetSingleRateValue(self.singlePrice, self.itemInfo, self:GetRateData(), nowInputCount)
    self.Count_UIInput.value = (ternary(nowInputCount < self.maxBuyCount, tostring(nowInputCount + 1), tostring(nowInputCount)))
    self.TotalPrice_UILabel.text = ternary(nowInputCount < self.maxBuyCount, tostring((nowInputCount + 1) * self.singlePrice), tostring(nowInputCount * self.singlePrice))
    self.TradePrice_UILabel.text = self:CheckHaveRemainder(ternary(nowInputCount < self.maxBuyCount, tostring((nowInputCount + 1) * self.ratePrice), tostring(nowInputCount * self.ratePrice)))
end

function UIAuctionSelling:SellBtnClick()
    if self.sellCallBack ~= nil then
        self.sellCallBack(self.priceBagItemInfo, self.bagItemInfo, self.Count_UIInput.value)
    end
end

function UIAuctionSelling:IconClick()
    if self.bagItemInfo and self.itemInfo then
        uiStaticParameter.UIItemInfoManager:CreatePanel({bagItemInfo = self.bagItemInfo})
    end
end

function UIAuctionSelling:InputNum(value)
    self.num = tonumber(value)
    self.num = ternary(tonumber(self.num) < self.minBuyCount, self.minBuyCount, self.num)
    self.num = ternary(tonumber(self.num) > self.maxBuyCount, self.maxBuyCount, self.num)
    self:RefreshPanel()
end
--endregion

--region 面板刷新
function UIAuctionSelling:RefreshPanel()
    self.itemTemplate:RefreshUIWithItemInfo(self.itemInfo)
    self.Count_UIInput.value = tostring(self.num)
    self.ratePrice = self:CheckHaveRemainder(self.ratePrice)
    self.TotalPrice_UILabel.text = tostring(self.singlePrice * tonumber(self.Count_UIInput.value))
    self.TradePrice_UILabel.text = tostring(self.ratePrice * tonumber(self.Count_UIInput.value))
    if self.priceBagItemInfo ~= nil then
        local priceItemInfoIsFind, priceItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.priceBagItemInfo.itemId)
        if priceItemInfoIsFind then
            self.TotalIcon_UISprite.spriteName = priceItemInfo.icon
            self.TradeIcon_UISprite.spriteName = priceItemInfo.icon
        end
    end
    self.MinusBtn_GameObject:SetActive(self.maxBuyCount > 1)
    self.PlusBtn_GameObject:SetActive(self.maxBuyCount > 1)
end
--endregion

--region 税率计算
---获取单个物品的税
function UIAuctionSelling:GetSingleRateValue(singlePrice, itemInfo, rateInfo, num)
    if singlePrice and rateInfo and itemInfo then
        local addNum = 0
        local totalPrice = 1 * singlePrice / itemInfo.dealPriceSection.list[1] * 100
        for i = 1, #rateInfo do
            if rateInfo[i][2] and rateInfo[i][1] and rateInfo[i][3] then
                if totalPrice >= rateInfo[i][2] then
                    local value1 = rateInfo[i][3] / 10000
                    local value2 = itemInfo.dealPriceSection.list[1]
                    addNum = addNum + value1 * value2
                else
                    local value1 = rateInfo[i][1] / 100
                    local value2 = singlePrice - itemInfo.dealPriceSection.list[1] * value1
                    local value3 = rateInfo[i][3] / 10000
                    addNum = addNum + value3 * value2
                    break
                end
            end
        end
        return addNum
    end
end

---获取税率信息
function UIAuctionSelling:GetRateData()
    local rateInfo
    rateInfo = {}
    local res, tableData = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20300)
    if res then
        local str = string.Split(tableData.value, "&")
        for i = 1, #str do
            local tbl = {}
            local str2 = string.Split(str[i], "#")
            for j = 1, #str2 do
                tbl[j] = tonumber(str2[j])
                rateInfo[i] = tbl
            end
        end
    end
    return rateInfo
end

---判断是否有余数，如果有余数就返回，如过没有就取余数
function UIAuctionSelling:CheckHaveRemainder(value)
    local left, right = math.modf(tonumber(value))
    return ternary(right > 0, left + 1, left)
end

--endregion

return UIAuctionSelling