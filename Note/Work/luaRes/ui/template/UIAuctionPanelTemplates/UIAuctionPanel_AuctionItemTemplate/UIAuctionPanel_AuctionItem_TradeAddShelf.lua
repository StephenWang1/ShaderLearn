---@class UIAuctionPanel_AuctionItem_TradeAddShelf:UIAuctionPanel_AuctionItemTemplateBase 元宝交易上架模板
local UIAuctionPanel_AuctionItem_TradeAddShelf = {}

setmetatable(UIAuctionPanel_AuctionItem_TradeAddShelf, luaComponentTemplates.UIAuctionPanel_AuctionItemTemplateBase)

UIAuctionPanel_AuctionItem_TradeAddShelf.mCoinName = {
    [0] = "单价",
    [1] = "总价",
    [2] = "扣税",
}

UIAuctionPanel_AuctionItem_TradeAddShelf.mCoinType = LuaEnumCoinType.YuanBao

---@param data customData
---@alias customData{Template:table,BagItemInfo:bagV2.BagItemInfo,PriceData:auctionV2.MarketPriceSection}
function UIAuctionPanel_AuctionItem_TradeAddShelf:Init(data)
    self:RunBaseFunction("Init", data)
    self.data = data

    self.mMinPrice = data.PriceData.marketPriceSection.lowPrice
    self.mMaxPrice = data.PriceData.marketPriceSection.topPrice
    self.price = self.mMinPrice

    self:SetNumData(data)
    self:SuitPanel()

    local defaultPrice = data.PriceData.marketPriceSection.defaultPrice
    if self:ShowSlider() and defaultPrice and self.mMaxPrice - self.mMinPrice ~= 0 then
        local rate = (defaultPrice - self.mMinPrice) / (self.mMaxPrice - self.mMinPrice)
        self.slider_UISlider.value = rate
    end
    self:SetNum()
end

---设置数目等，方便重写
function UIAuctionPanel_AuctionItem_TradeAddShelf:SetNumData(data)
    self.mMaxNum = data.BagItemInfo.count
    self.mMinNum = 1
    self.num = self.mMinNum
end

---@return boolean 是否显示标题
function UIAuctionPanel_AuctionItem_TradeAddShelf:ShowTitleBtn()
    return false
end

---@return boolean 是否显示数目
function UIAuctionPanel_AuctionItem_TradeAddShelf:ShowNum()
    return true
end

---@return number 价格行数
function UIAuctionPanel_AuctionItem_TradeAddShelf:ShowCoin()
    local lineNum = 3
    self.coin_UIGridContainer.MaxCount = lineNum
    self.mPriceLabel = {}
    for i = 0, lineNum - 1 do
        local go = self.coin_UIGridContainer.controlList[i]
        self:RefreshLineCoin(go, i)
    end
    return lineNum
end

---刷新每行货币信息
---@param go UnityEngine.GameObject 每行货币
---@param i number 从0开始的行数
---@param lineNum  number 总行数
function UIAuctionPanel_AuctionItem_TradeAddShelf:RefreshLineCoin(go, i)
    local name = CS.Utility_Lua.Get(go.transform, "Label", "UILabel")
    local priceIcon = CS.Utility_Lua.Get(go.transform, "Sprite", "UISprite")
    ---@type UIInput
    local priceLabel = CS.Utility_Lua.Get(go.transform, "inputcount", "UIInput")
    name.text = self.mCoinName[i]
    self.mPriceLabel[i] = priceLabel
    local iconInfo = self:GetTradePriceItemInfo()
    if iconInfo then
        priceIcon.spriteName = iconInfo.icon
    end
    if i == 0 then
        self.priceLabel.submitOnUnselect = true
        CS.EventDelegate.Add(self.priceLabel.onSubmit, function()
            self:OnInputChange(self.priceLabel.value, i)
        end)
    end
end

---价格某行改变
function UIAuctionPanel_AuctionItem_TradeAddShelf:OnInputChange(value, i)
    if i == 0 then
        if self.mMaxPrice and self.mMinPrice then
            local finalPrice = math.min(self.mMaxPrice, value)
            finalPrice = math.max(self.mMinPrice, value)
            self:SetPrice(finalPrice)
        end
    end
end

---获取货币信息
function UIAuctionPanel_AuctionItem_TradeAddShelf:GetTradePriceItemInfo()
    if self.mTradePriceInfo == nil then
        ___, self.mTradePriceInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mCoinType)
    end
    return self.mTradePriceInfo
end

---刷新价格显示
function UIAuctionPanel_AuctionItem_TradeAddShelf:RefreshPriceShow()
    self.mPriceLabel[0].value = self.price
    self.mPriceLabel[1].value = self.price * self.num
    self.mPriceLabel[2].value = self:GetRate() .. "(单个)"
end

---计算税率(单价和数量任何一个变动都要重新计算税率)
function UIAuctionPanel_AuctionItem_TradeAddShelf:GetRate()
    local rate = 0
    local rateInfo = self:GetRateData()
    if self.price and rateInfo then
        local addNum = 0
        local lowPrice = self.mMinPrice
        local totalPrice = (1 * self.price) / lowPrice * 100
        for i = 1, #rateInfo do
            if rateInfo[i][2] and rateInfo[i][1] and rateInfo[i][3] then
                if totalPrice >= rateInfo[i][2] then
                    local value1 = rateInfo[i][3] / 10000
                    local value2 = lowPrice
                    addNum = addNum + value1 * value2
                else
                    local value1 = rateInfo[i][1] / 100
                    local value2 = self.price - lowPrice * value1
                    local value3 = rateInfo[i][3] / 10000
                    addNum = addNum + value3 * value2
                    break
                end
            end
        end
        rate = math.ceil(addNum)
    end
    return rate
end

---获取税率信息
function UIAuctionPanel_AuctionItem_TradeAddShelf:GetRateData()
    if self.RateInfo == nil then
        self.RateInfo = {}
        local res, tableData = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20300)
        if res then
            local str = string.Split(tableData.value, "&")
            for i = 1, #str do
                local tbl = {}
                local str2 = string.Split(str[i], "#")
                for j = 1, #str2 do
                    tbl[j] = tonumber(str2[j])
                    self.RateInfo[i] = tbl
                end
            end
        end
    end
    return self.RateInfo
end

---@return boolean 是否显示滑条
function UIAuctionPanel_AuctionItem_TradeAddShelf:ShowSlider()
    return self.mMinPrice ~= self.mMaxPrice
end

---@return boolean 是否是单个按钮
function UIAuctionPanel_AuctionItem_TradeAddShelf:IsSingleBtn()
    return true
end

---@return boolean 是否显示文本
function UIAuctionPanel_AuctionItem_TradeAddShelf:ShowLabel()
    return false
end

---滑条改变
function UIAuctionPanel_AuctionItem_TradeAddShelf:SliderChange(sliderValue)
    if self.mMaxPrice and self.mMinPrice then
        local price = math.ceil(sliderValue * (self.mMaxPrice - self.mMinPrice)) + self.mMinPrice
        self:SetPrice(price)
    end
end

---设置价格
function UIAuctionPanel_AuctionItem_TradeAddShelf:SetPrice(value)
    self.price = value
    self:RefreshPriceShow()
end

---用于数目变化后的处理
function UIAuctionPanel_AuctionItem_TradeAddShelf:SetNum()
    self.num_UIInput.value = self.num
    self:RefreshPriceShow()
end

---点击上架按钮
function UIAuctionPanel_AuctionItem_TradeAddShelf:OnShelfClicked(go)
    if self.data and self.num and self.price then
        local info = { itemId = self.mCoinType, count = math.ceil(self.price) }
        networkRequest.ReqAddToShelf(self.data.BagItemInfo.lid, self.num, info, Utility.EnumToInt(CS.auctionV2.AuctionItemType.THADED_PRODUCTS), false)
        self:ClosePanel()
    end
end

---刷新标题
function UIAuctionPanel_AuctionItem_TradeAddShelf:RefreshTitle()
    self.centerBtn_UILabel.text = "上架"
    self.leftBtn_UILabel.text = "重新上架"
    self.rightBtn_UILabel.text = "下架"
end

return UIAuctionPanel_AuctionItem_TradeAddShelf