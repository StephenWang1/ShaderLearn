---@class UIAuctionPanel_AuctionItem_BuyingBuy:UIAuctionPanel_AuctionItemTemplateBase 求购购买面板
local UIAuctionPanel_AuctionItem_BuyingBuy = {}

setmetatable(UIAuctionPanel_AuctionItem_BuyingBuy, luaComponentTemplates.UIAuctionPanel_AuctionItemTemplateBase)

UIAuctionPanel_AuctionItem_BuyingBuy.BuyNameShow = {
    [0] = "售价",
    [1] = "扣税",
}

function UIAuctionPanel_AuctionItem_BuyingBuy:Init(data)
    self:RunBaseFunction("Init", data)
    self.mMaxNum = data.MaxNum
    self.mMinNum = 1
    self.num = self.mMinNum
    self.price = data.SinglePrice
    self.PriceBagItemInfo = data.PriceBagItemInfo

    ---@type auctionV2.MarketPriceSection
    local priceData = self.data.PriceData
    self.mMaxPrice = priceData.marketPriceSection.topPrice
    self.mMinPrice = self.data.PriceData.marketPriceSection.lowPrice
    self.mCoinType = LuaEnumCoinType.YuanBao
    self:SuitPanel()
    self:SetNum()
end

--region 用于重写
---@return boolean 是否显示标题
function UIAuctionPanel_AuctionItem_BuyingBuy:ShowTitleBtn()
    return false
end

---@return boolean 是否显示数目
function UIAuctionPanel_AuctionItem_BuyingBuy:ShowNum()
    return true
end

---@return number 价格行数
function UIAuctionPanel_AuctionItem_BuyingBuy:ShowCoin()
    local lineNum = 2
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
function UIAuctionPanel_AuctionItem_BuyingBuy:RefreshLineCoin(go, i)
    local name = CS.Utility_Lua.Get(go.transform, "Label", "UILabel")
    local priceIcon = CS.Utility_Lua.Get(go.transform, "Sprite", "UISprite")
    local priceLabel = CS.Utility_Lua.Get(go.transform, "gold", "UILabel")
    name.text = self.BuyNameShow[i]
    self.mPriceLabel[i] = priceLabel
    priceIcon.spriteName = self:GetBuyingPriceItemInfo().icon
end

---@return TABLE.CFG_ITEMS 钻石信息
function UIAuctionPanel_AuctionItem_BuyingBuy:GetBuyingPriceItemInfo()
    if self.mPriceItemInfo == nil then
        ___, self.mPriceItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mCoinType)
    end
    return self.mPriceItemInfo
end

---@return boolean 是否显示滑条
function UIAuctionPanel_AuctionItem_BuyingBuy:ShowSlider()
    return false
end

---@return boolean 是否是单个按钮
function UIAuctionPanel_AuctionItem_BuyingBuy:IsSingleBtn()
    return true
end

---@return boolean 是否显示文本
function UIAuctionPanel_AuctionItem_BuyingBuy:ShowLabel()
    return false
end

---用于数目变化后的处理
function UIAuctionPanel_AuctionItem_BuyingBuy:SetNum()
    self.num_UIInput.value = self.num
    self:RefreshPriceShow()

end

---刷新价格显示
function UIAuctionPanel_AuctionItem_BuyingBuy:RefreshPriceShow()
    self.mPriceLabel[0].text = self.price * self.num
    self.mPriceLabel[1].text = self:GetSingleRateValue(self.price) * self.num
end


--region 税率计算
---获取单个物品的税
function UIAuctionPanel_AuctionItem_BuyingBuy:GetSingleRateValue(singlePrice)
    if singlePrice then
        local rateInfo = self:GetRateData()
        local addNum = 0
        local totalPrice = 1 * singlePrice / self.mMinPrice * 100
        for i = 1, #rateInfo do
            if rateInfo[i][2] and rateInfo[i][1] and rateInfo[i][3] then
                if totalPrice >= rateInfo[i][2] then
                    local value1 = rateInfo[i][3] / 10000
                    local value2 = self.mMinPrice
                    addNum = addNum + value1 * value2
                else
                    local value1 = rateInfo[i][1] / 100
                    local value2 = singlePrice - self.mMinPrice * value1
                    local value3 = rateInfo[i][3] / 10000
                    addNum = addNum + value3 * value2
                    break
                end
            end
        end
        return math.ceil(addNum)
    end
end

---获取税率信息
function UIAuctionPanel_AuctionItem_BuyingBuy:GetRateData()
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

---点击出售按钮
function UIAuctionPanel_AuctionItem_BuyingBuy:OnShelfClicked(go)
    networkRequest.ReqSubmitBuyProductsItem(self.PriceBagItemInfo.lid, self.data.BagItemInfo.lid, self.num)
    self:ClosePanel()
end
---刷新标题
function UIAuctionPanel_AuctionItem_BuyingBuy:RefreshTitle()
    self.centerBtn_UILabel.text = "出售"
end
--endregion

return UIAuctionPanel_AuctionItem_BuyingBuy