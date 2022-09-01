---@class UIAuctionPanel_AuctionItem_TradAddShelfMix:UIAuctionPanel_AuctionItemTemplateBase 交易上架混合模板元宝/钻石）
local UIAuctionPanel_AuctionItem_TradAddShelfMix = {}

setmetatable(UIAuctionPanel_AuctionItem_TradAddShelfMix, luaComponentTemplates.UIAuctionPanel_AuctionItemTemplateBase)

UIAuctionPanel_AuctionItem_TradAddShelfMix.mCoinName = {
    [0] = "单价",
    [1] = "总价",
    [2] = "扣税",
}

---@param data customData
---@alias customData{Template:table,BagItemInfo:bagV2.BagItemInfo,PriceData:auctionV2.MarketPriceSection}
function UIAuctionPanel_AuctionItem_TradAddShelfMix:Init(data)
    self:RunBaseFunction("Init", data)
    self.data = data
    ---@type auctionV2.MarketPriceSection
    self.mPriceData = data.PriceData
    ---@type auctionV2.BaseMarketPriceSection 元宝数据
    self.mYuanBaoData = self.mPriceData.marketPriceSection
    ---@type auctionV2.BaseMarketPriceSection 钻石数据
    self.mDiamondData = self.mPriceData.otherMarketPriceSection

    self.mMaxNum = data.BagItemInfo.count
    self.mMinNum = 1

    self.mType = data.ItemState
    if self.mType == LuaEnumAuctionTradeShelfType.Mix then
        self.mShowType = LuaEnumAuctionTradeShelfType.YuanBao
    elseif self.mType == LuaEnumAuctionTradeShelfType.YuanBao then
        self.mShowType = LuaEnumAuctionTradeShelfType.YuanBao
    elseif self.mType == LuaEnumAuctionTradeShelfType.Diamond then
        self.mShowType = LuaEnumAuctionTradeShelfType.Diamond
    else
        return
    end

    self:RefreshCurrentPrice()
    self:SuitPanel()
    if self.mShowType == LuaEnumAuctionTradeShelfType.YuanBao then
        --self.auctionBtn_GameObject:Set(true)
        self.buyBtn_GameObject:Set(true)
    else
        --self.buyBtn_GameObject:Set(true)
        self.auctionBtn_GameObject:Set(true)
    end
    self:RefreshSlider()
end

---刷新当前价格显示
function UIAuctionPanel_AuctionItem_TradAddShelfMix:RefreshCurrentPrice()
    if self.mShowType == LuaEnumAuctionTradeShelfType.YuanBao then
        self.mMaxPrice = self.mYuanBaoData ~= nil and self.mYuanBaoData.topPrice or 0
        self.mMinPrice = self.mYuanBaoData ~= nil and self.mYuanBaoData.lowPrice or 0
    else
        self.mMaxPrice = self.mDiamondData.topPrice
        self.mMinPrice = self.mDiamondData.lowPrice
    end
    self.mCoinType = LuaEnumCoinType.YuanBao
    if self.mShowType == LuaEnumAuctionTradeShelfType.Diamond then
        self.mCoinType = LuaEnumCoinType.Diamond
    end

    self:ResetData()
end

function UIAuctionPanel_AuctionItem_TradAddShelfMix:RefreshSlider()
    local defaultPrice
    if self.mShowType == LuaEnumAuctionTradeShelfType.YuanBao then
        if self.mYuanBaoData then
            defaultPrice = self.mYuanBaoData.defaultPrice
        end
    else
        if self.mDiamondData then
            defaultPrice = self.mDiamondData.defaultPrice
        end
    end
    self:SetSliderValue(defaultPrice)
end

---刷新标题
function UIAuctionPanel_AuctionItem_TradAddShelfMix:RefreshTitle()
    self.centerBtn_UILabel.text = "上架"
    self.leftBtn_UILabel.text = "重新上架"
    self.rightBtn_UILabel.text = "下架"
end

---@return boolean 是否显示标题
function UIAuctionPanel_AuctionItem_TradAddShelfMix:ShowTitleBtn()
    return self.mType == LuaEnumAuctionTradeShelfType.Mix
end

---@return number 价格行数
function UIAuctionPanel_AuctionItem_TradAddShelfMix:ShowCoin()
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
function UIAuctionPanel_AuctionItem_TradAddShelfMix:RefreshLineCoin(go, i)
    local name = CS.Utility_Lua.Get(go.transform, "Label", "UILabel")
    local priceIcon = CS.Utility_Lua.Get(go.transform, "Sprite", "UISprite")
    name.text = self.mCoinName[i]
    local itemInfo = self:GetItemInfoCache(self.mCoinType)
    if itemInfo then
        priceIcon.spriteName = itemInfo.icon
    end
    ---@type UIInput
    local priceLabel = CS.Utility_Lua.Get(go.transform, "inputcount", "UIInput")
    ---@type UnityEngine.BoxCollider
    local col = CS.Utility_Lua.Get(go.transform, "inputcount", "BoxCollider")
    local goldLabel = CS.Utility_Lua.Get(go.transform, "gold", "GameObject")
    local sign = CS.Utility_Lua.Get(go.transform, "inputcount/sign", "GameObject")
    self.mPriceLabel[i] = priceLabel
    goldLabel:SetActive(false)
    priceLabel.gameObject:SetActive(true)
    if i == 0 then
        priceLabel.submitOnUnselect = true
        CS.EventDelegate.Add(priceLabel.onSubmit, function()
            self:OnInputChange(tonumber(priceLabel.value), i, priceLabel)
        end)
        col.enabled = true
    else
        col.enabled = false
    end
    sign:SetActive(i == 0)
end

---价格某行改变
function UIAuctionPanel_AuctionItem_TradAddShelfMix:OnInputChange(value, i, uiInput)
    if value ~= nil and i == 0 then
        if self.mMaxPrice and self.mMinPrice then
            local finalPrice = math.min(self.mMaxPrice, value)
            finalPrice = math.max(self.mMinPrice, finalPrice)
            self:SetSliderValue(finalPrice)
            uiInput.value = finalPrice
        end
    end
end

---@return TABLE.CFG_ITEMS
function UIAuctionPanel_AuctionItem_TradAddShelfMix:GetItemInfoCache(itemId)
    if self.mItemIdToInfo == nil then
        self.mItemIdToInfo = {}
    end
    local data = self.mItemIdToInfo[itemId]
    if data == nil then
        ___, data = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
    end
    return data
end

---@return boolean 是否显示滑条
function UIAuctionPanel_AuctionItem_TradAddShelfMix:ShowSlider()
    return self.mMinPrice ~= self.mMaxPrice
end

---@return boolean 是否是单个按钮
function UIAuctionPanel_AuctionItem_TradAddShelfMix:IsSingleBtn()
    return true
end

---切换元宝
function UIAuctionPanel_AuctionItem_TradAddShelfMix:OnAuctionBtnClicked()
    if self.mShowType == LuaEnumAuctionTradeShelfType.YuanBao then
        return
    end
    self.mShowType = LuaEnumAuctionTradeShelfType.YuanBao
    self:RefreshCurrentPrice()
    self:SuitPanel()
    self:RefreshSlider()
end

---切换钻石
function UIAuctionPanel_AuctionItem_TradAddShelfMix:OnBuyBtnClicked()
    if self.mShowType == LuaEnumAuctionTradeShelfType.Diamond then
        return
    end
    self.mShowType = LuaEnumAuctionTradeShelfType.Diamond
    self:RefreshCurrentPrice()
    self:SuitPanel()
    self:RefreshSlider()
end

function UIAuctionPanel_AuctionItem_TradAddShelfMix:ResetData()
    self.num = self.mMinNum
    self.slider_UISlider.value = 0
    self:SetPrice(self.mMinPrice)
    self:SetNum()
end

---滑条改变
function UIAuctionPanel_AuctionItem_TradAddShelfMix:SliderChange(sliderValue, defaultPrice)
    if self.mMaxPrice and self.mMinPrice then
        local price = math.ceil(sliderValue * (self.mMaxPrice - self.mMinPrice)) + self.mMinPrice
        if type(defaultPrice) == 'number' then
            price = defaultPrice
        end
        self:SetPrice(price)
    end
end

---设置价格
function UIAuctionPanel_AuctionItem_TradAddShelfMix:SetPrice(value)
    self.price = value
    self:RefreshPriceShow()
end

---刷新价格显示
function UIAuctionPanel_AuctionItem_TradAddShelfMix:RefreshPriceShow()
    if self.mPriceLabel == nil or self.price == nil then
        return
    end
    self.mPriceLabel[0].value = self.price
    self.mPriceLabel[1].value = self.price * self.num
    self.mPriceLabel[2].value = self:GetRate() .. "(单个)"
end

---计算税率(单价和数量任何一个变动都要重新计算税率)
function UIAuctionPanel_AuctionItem_TradAddShelfMix:GetRate()
    local rate = 0
    local rateInfo = self:GetYuanBaoRateData()
    if self.mShowType == LuaEnumAuctionTradeShelfType.Diamond then
        rateInfo = self:GetDiamondRateData()
    end
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
function UIAuctionPanel_AuctionItem_TradAddShelfMix:GetYuanBaoRateData()
    if self.YuanBaoRateInfo == nil then
        self.YuanBaoRateInfo = {}
        local res, tableData = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20300)
        if res then
            local str = string.Split(tableData.value, "&")
            for i = 1, #str do
                local tbl = {}
                local str2 = string.Split(str[i], "#")
                for j = 1, #str2 do
                    tbl[j] = tonumber(str2[j])
                    self.YuanBaoRateInfo[i] = tbl
                end
            end
        end
    end
    return self.YuanBaoRateInfo
end

---获取税率信息
function UIAuctionPanel_AuctionItem_TradAddShelfMix:GetDiamondRateData()
    if self.DiamondRateInfo == nil then
        self.DiamondRateInfo = {}
        local res, tableData = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22017)
        if res then
            local str = string.Split(tableData.value, "&")
            for i = 1, #str do
                local tbl = {}
                local str2 = string.Split(str[i], "#")
                for j = 1, #str2 do
                    tbl[j] = tonumber(str2[j])
                    self.DiamondRateInfo[i] = tbl
                end
            end
        end
    end
    return self.DiamondRateInfo
end

---上架
function UIAuctionPanel_AuctionItem_TradAddShelfMix:OnShelfClicked(go)
    local info = { itemId = self.mCoinType, count = math.ceil(self.price) }
    networkRequest.ReqAddToShelf(self.data.BagItemInfo.lid, self.num, info, Utility.EnumToInt(CS.auctionV2.AuctionItemType.THADED_PRODUCTS), false)
    self:ClosePanel()
end

---设置数目
function UIAuctionPanel_AuctionItem_TradAddShelfMix:SetNum()
    self.num_UIInput.value = self.num
    self:RefreshPriceShow()
end

return UIAuctionPanel_AuctionItem_TradAddShelfMix
