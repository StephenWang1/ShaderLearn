---@class UIAuctionPanel_AuctionItem_AuctionAddShelf:UIAuctionPanel_AuctionItemTemplateBase 竞拍上架模板
local UIAuctionPanel_AuctionItem_AuctionAddShelf = {}

setmetatable(UIAuctionPanel_AuctionItem_AuctionAddShelf, luaComponentTemplates.UIAuctionPanel_AuctionItemTemplateBase)

UIAuctionPanel_AuctionItem_AuctionAddShelf.BuyNameShow = {
    [0] = "单     价",
    [1] = "总     价",
    [2] = "交易税"
}

UIAuctionPanel_AuctionItem_AuctionAddShelf.AuctionNameShow = {
    [0] = "起拍价",
    [1] = "一口价",
    [2] = "交易税"
}

---@param data customData
---@alias customData{Template:table,BagItemInfo:bagV2.BagItemInfo,PriceData:auctionV2.MarketPriceSection,ItemState:number}
function UIAuctionPanel_AuctionItem_AuctionAddShelf:Init(data)
    self.PriceItemId = LuaEnumCoinType.Diamond
    self:RunBaseFunction("Init", data)
    self.type = data.ItemState
    if self.type == LuaEnumDiamondShelfType.Mix then
        self.ShowType = LuaEnumDiamondShelfType.Auction
    else
        self.ShowType = self.type
    end
    self.mMaxNum = data.BagItemInfo.count
    self.mMinNum = 1
    self.num = self.mMinNum
    self.ItemInfo = data.BagItemInfo.ItemTABLE
    ---@type auctionV2.MarketPriceSection
    self.PriceData = data.PriceData

    if self.PriceData then
        self.OncePriceMultiple = self.PriceData.marketPriceSection.ratio
    end
    if self.OncePriceMultiple == nil or self.OncePriceMultiple == 0 then
        self.OncePriceMultiple = 1
    end

    self.isPublicity = false
    self:RefreshCurrentPrice()
    self:SuitPanel()
    if self.ShowType == LuaEnumDiamondShelfType.Auction then
        self.auctionBtn_GameObject:Set(true)
    else
        self.buyBtn_GameObject:Set(true)
    end
    self:ResetData()
end

function UIAuctionPanel_AuctionItem_AuctionAddShelf:ResetData()
    self.slider_UISlider.value = 0
    self:SetPrice(self.mMinPrice)
    self.num = self.mMinNum
    self:SetNum()
end

---刷新当前价格显示
function UIAuctionPanel_AuctionItem_AuctionAddShelf:RefreshCurrentPrice()

    local priceData = self.PriceData
    if priceData then
        self.mMaxPrice = priceData.marketPriceSection.topPrice
        self.mMinPrice = priceData.marketPriceSection.lowPrice
    end
end

function UIAuctionPanel_AuctionItem_AuctionAddShelf:IsNumLabelNeedSpace()
    return true
end

---@return boolean 是否显示标题
function UIAuctionPanel_AuctionItem_AuctionAddShelf:ShowTitleBtn()
    return self.type == LuaEnumDiamondShelfType.Mix
end

---@return boolean 是否显示数目
function UIAuctionPanel_AuctionItem_AuctionAddShelf:ShowNum()
    return true
end

---@return number 价格行数
function UIAuctionPanel_AuctionItem_AuctionAddShelf:ShowCoin()
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
function UIAuctionPanel_AuctionItem_AuctionAddShelf:RefreshLineCoin(go, i)
    local name = CS.Utility_Lua.Get(go.transform, "Label", "UILabel")
    local priceIcon = CS.Utility_Lua.Get(go.transform, "Sprite", "UISprite")
    if self.ShowType == LuaEnumDiamondShelfType.Buy then
        name.text = self.BuyNameShow[i]
    else
        name.text = self.AuctionNameShow[i]
    end
    local priceLabel = CS.Utility_Lua.Get(go.transform, "gold", "UILabel")
    self.mPriceLabel[i] = priceLabel
    priceIcon.spriteName = self:GetAuctionPriceItemInfo().icon
end

---@return TABLE.CFG_ITEMS 钻石信息
function UIAuctionPanel_AuctionItem_AuctionAddShelf:GetAuctionPriceItemInfo()
    if self.mPriceItemInfo == nil then
        ___, self.mPriceItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.PriceItemId)
    end
    return self.mPriceItemInfo
end

---@return boolean 是否显示滑条
function UIAuctionPanel_AuctionItem_AuctionAddShelf:ShowSlider()
    return self.mMinPrice ~= self.mMaxPrice
end

---@return boolean 是否是单个按钮
function UIAuctionPanel_AuctionItem_AuctionAddShelf:IsSingleBtn()
    return true
end

---@return boolean 是否显示公示
function UIAuctionPanel_AuctionItem_AuctionAddShelf:ShowLabel()
    return self.ShowType == LuaEnumDiamondShelfType.Auction
end

---切换竞价
function UIAuctionPanel_AuctionItem_AuctionAddShelf:OnAuctionBtnClicked()
    if self.ShowType == LuaEnumDiamondShelfType.Auction then
        return
    end
    self.ShowType = LuaEnumDiamondShelfType.Auction
    self:RefreshCurrentPrice()
    self.OncePriceMultiple = self.data.PriceData.auctionMarketPriceSection.ratio
    self:SuitPanel()
    self:ResetData()
end

---切换直购
function UIAuctionPanel_AuctionItem_AuctionAddShelf:OnBuyBtnClicked()
    if self.ShowType == LuaEnumDiamondShelfType.Buy then
        return
    end
    self.ShowType = LuaEnumDiamondShelfType.Buy
    self:RefreshCurrentPrice()
    self.OncePriceMultiple = 1
    self:SuitPanel()
    self:ResetData()
end

---滑条改变
function UIAuctionPanel_AuctionItem_AuctionAddShelf:SliderChange(sliderValue)
    if self.mMaxPrice and self.mMinPrice then
        local price = math.ceil(sliderValue * (self.mMaxPrice - self.mMinPrice)) + self.mMinPrice
        self:SetPrice(price)
    end
end

---设置价格
function UIAuctionPanel_AuctionItem_AuctionAddShelf:SetPrice(value)
    self.price = value
    self:RefreshPriceShow()
end

---公示改变
function UIAuctionPanel_AuctionItem_AuctionAddShelf:OnPublishToggleChange(value)
    self.isPublicity = value
    self:RefreshPriceShow()
end

---刷新价格显示
function UIAuctionPanel_AuctionItem_AuctionAddShelf:RefreshPriceShow()
    if self.mPriceLabel == nil then
        return
    end

    self.mPriceLabel[0].text = self.price
    self.mPriceLabel[1].text = self:SetOncePrice()
    self.mPriceLabel[2].text = self:ShowRate()

    --[[    if self.ShowType == LuaEnumDiamondShelfType.Buy then
            self.mPriceLabel[0].text = self.price
            self.mPriceLabel[1].text = self.price * self.num
            self.mPriceLabel[2].text = self:ShowRate() .. "(单个)"
        else


        end]]
end

---计算税率(单价和数量任何一个变动都要重新计算税率)
function UIAuctionPanel_AuctionItem_AuctionAddShelf:GetRate(price)
    local addNum = 0
    local rateInfo = self:GetRateData()
    if price and rateInfo then
        local totalPrice = price / self.mMinPrice * 100
        for i = 1, #rateInfo do
            if rateInfo[i][2] and rateInfo[i][1] and rateInfo[i][3] then
                if totalPrice >= rateInfo[i][2] then
                    local value1 = rateInfo[i][3] / 10000
                    local value2 = self.mMinPrice
                    addNum = addNum + value1 * value2
                else
                    local value1 = rateInfo[i][1] / 100
                    local value2 = price - self.mMinPrice * value1
                    local value3 = rateInfo[i][3] / 10000
                    addNum = addNum + value3 * value2
                    break
                end
            end
        end
    end
    return addNum
end

---获取税率信息
function UIAuctionPanel_AuctionItem_AuctionAddShelf:GetRateData()
    if self.RateInfo == nil then
        self.RateInfo = {}
        local res, tableData = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22017)
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

---显示税率
---@param isMax boolean 是否只需要上限
function UIAuctionPanel_AuctionItem_AuctionAddShelf:ShowRate()
    if self.price then
        if self.ShowType == LuaEnumDiamondShelfType.Buy then
            local maxPriceRate = self:GetRate((self.price))
            if maxPriceRate then
                return math.ceil(maxPriceRate)
            end
        else
            local maxPriceRate = self:GetRate((self.price * self.OncePriceMultiple))
            if maxPriceRate then
                local priceRate = self:GetRate(self.price)
                local half = ternary(self.isPublicity, 2, 1)
                if priceRate then
                    return math.ceil(priceRate / half) .. "-" .. math.ceil(maxPriceRate / half)
                end
            end
        end
    end
    return ""
end

---设置一口价
function UIAuctionPanel_AuctionItem_AuctionAddShelf:SetOncePrice()
    if self.OncePriceMultiple and self.price then
        return math.ceil(self.OncePriceMultiple * self.price)
    end
end

---上架
function UIAuctionPanel_AuctionItem_AuctionAddShelf:OnShelfClicked()
    local info = { itemId = self.PriceItemId, math.ceil(self.price) }
    if self.ShowType == LuaEnumDiamondShelfType.Buy then
        networkRequest.ReqAddToShelf(self.data.BagItemInfo.lid, self.num, info, Utility.EnumToInt(CS.auctionV2.AuctionItemType.THADED_PRODUCTS), false)
    else
        networkRequest.ReqAddToShelf(self.data.BagItemInfo.lid, self.num, info, Utility.EnumToInt(CS.auctionV2.AuctionItemType.SALF_PRODUCTS), self.isPublicity)
    end
    self:ClosePanel()
end

---设置数目
function UIAuctionPanel_AuctionItem_AuctionAddShelf:SetNum()
    self.num_UIInput.value = self.num
    self:RefreshPriceShow()
end

return UIAuctionPanel_AuctionItem_AuctionAddShelf