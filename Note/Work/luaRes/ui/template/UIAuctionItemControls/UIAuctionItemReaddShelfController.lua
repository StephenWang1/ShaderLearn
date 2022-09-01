---竞拍行重新上架控制器
---@class UIAuctionItemReaddShelfController:UIAuctionItemController
local UIAuctionItemReaddShelfController = {}

setmetatable(UIAuctionItemReaddShelfController, luaComponentTemplates.AuctionItemController)

---初始化排版
function UIAuctionItemReaddShelfController:InitializeCompose()
    --[[****************************初始化数据*****************************]]
    ---@type {Template:table,BagItemInfo:bagV2.BagItemInfo,PriceData:auctionV2.MarketPriceSection,ItemState:number}
    local data = self:GetData()
    if data == nil or data.BagItemInfo == nil then
        return
    end
    ---当前物品数量
    ---@private
    self.mCurrentNumber = 1
    ---@type TABLE.CFG_ITEMS
    local diamondTbl
    ___, diamondTbl = CS.Cfg_ItemsTableManager.Instance:TryGetValue(LuaEnumCoinType.Diamond)

    --[[****************************排版并初始化组件*****************************]]
    self:AddSpace(10)

    ---@private
    self.mMinMaxNumberPart = self:AddNumberAndMinus()
    self.mMinMaxNumberPart:Initialize("数    目", data.BagItemInfo.count, data.BagItemInfo.count, false, true, self.mCurrentNumber)
    self.mMinMaxNumberPart:BindEvents(function()
        self:OnItemCountChanged()
    end)
    self.mMinMaxNumberPart:SetColliderState(false)

    self:AddSpace(10)
    ---@private
    self.mQiPaiCoinLabel = self:AddCoinInput()
    self.mQiPaiCoinLabel:Initialize("起拍价", diamondTbl, 0)

    self:AddSpace(13)
    ---@private
    self.mQiPaiSlider = self:AddSlider()
    self.mQiPaiSlider:Initialize(data.PriceData.marketPriceSection.lowPrice, data.PriceData.marketPriceSection.topPrice, function()
        self:OnQiPaiPriceValueChanged()
    end)

    self:AddSpace(13)
    ---@private
    self.mYiKouCoinLabel = self:AddCoinInput()
    self.mYiKouCoinLabel:Initialize("一口价", diamondTbl, 0)

    self:AddSpace(13)
    ---一口价倍数(一口价实际数值为起拍价与该倍数的乘积)
    ---@private
    self.mYiKouSlider = self:AddSlider()
    self.mYiKouSlider:Initialize(1, 3, function()
        self:OnYiKouPriceValueChanged()
    end)

    self:AddSpace(13)
    self.mTaxCoinLabel = self:AddCoinInput()
    self.mTaxCoinLabel:Initialize("交易税", diamondTbl, 0)

    self:AddSpace(10)
    self.mPublicToggle = self:AddToggle()
    self.mPublicToggle:Initialize(false, "是否公示 (交易税减半)", function()
        self:OnPublicTaxToggleChanged()
    end)

    self:AddSpace(10)
    self.mAddShelfButton = self:AddBigButton()
    self.mAddShelfButton:Initialize("上架", function()
        self:OnAddShelfButtonClicked()
    end)

    self:AddSpace(10)

    --[[****************************刷新*****************************]]
    self:RefreshCurrentNumber()
end

--[[****************************事件*****************************]]
---物品数量变化事件
---@private
function UIAuctionItemReaddShelfController:OnItemCountChanged()
    self:RefreshCurrentNumber()
end

---起拍价(单价)变化事件
---@private
function UIAuctionItemReaddShelfController:OnQiPaiPriceValueChanged()
    ---起拍价变化时需要重置一口价倍数
    self.mYiKouSlider:SetValue(0)
    self:RefreshQiPaiCoinAmount()
end

---一口价倍数变化事件
---@private
function UIAuctionItemReaddShelfController:OnYiKouPriceValueChanged()
    self:RefreshYiKouPriceCoinAmount()
end

---一口价倍数变化事件
---@private
function UIAuctionItemReaddShelfController:OnPublicTaxToggleChanged()
    self:RefreshTax()
end

---重新上架按钮点击事件
function UIAuctionItemReaddShelfController:OnAddShelfButtonClicked()
    local info = { itemId = LuaEnumCoinType.Diamond, count = self:GetQiPaiSinglePrice() }
    networkRequest.ReqReAddToShelf(self:GetData().BagItemInfo.lid, info, self.mPublicToggle:GetValue(),
            Utility.EnumToInt(CS.auctionV2.AuctionItemType.SALF_PRODUCTS), self:GetYiKouSummaryPrice())
    uimanager:ClosePanel("UIAuctionItemPanel")
end

--[[****************************刷新数量*****************************]]
---刷新当前物品数量
function UIAuctionItemReaddShelfController:RefreshCurrentNumber()
    self:RefreshQiPaiCoinAmount()
end

---刷新起拍价数量
function UIAuctionItemReaddShelfController:RefreshQiPaiCoinAmount()
    self.mQiPaiCoinLabel:RefreshContent(self:GetQiPaiSummaryPrice())
    self:RefreshYiKouPriceCoinAmount()
    self:RefreshTax()
end

---刷新一口价价格
function UIAuctionItemReaddShelfController:RefreshYiKouPriceCoinAmount()
    self.mYiKouCoinLabel:RefreshContent(self:GetYiKouSummaryPrice())
    self:RefreshTax()
end

---刷新税
function UIAuctionItemReaddShelfController:RefreshTax()
    local taxMin = self:GetTaxMin()
    local taxMax = self:GetTaxMax()
    self.mTaxCoinLabel:RefreshContent(tostring(taxMin) .. "-" .. tostring(taxMax))
end

--[[****************************获取税率*****************************]]
---获取交易税数值(小数,需要向上取整)
---@private
---@param amount
---@return number
function UIAuctionItemReaddShelfController:GetRateAmount(amount)
    local addNum = 0
    local rateInfo = self:GetRateTableData()
    local mMinPrice = self:GetData().PriceData.marketPriceSection.lowPrice
    if amount and rateInfo then
        local totalPrice = amount / mMinPrice * 100
        for i = 1, #rateInfo do
            if rateInfo[i][2] and rateInfo[i][1] and rateInfo[i][3] then
                if totalPrice >= rateInfo[i][2] then
                    local value1 = rateInfo[i][3] / 10000
                    local value2 = mMinPrice
                    addNum = addNum + value1 * value2
                else
                    local value1 = rateInfo[i][1] / 100
                    local value2 = amount - mMinPrice * value1
                    local value3 = rateInfo[i][3] / 10000
                    addNum = addNum + value3 * value2
                    break
                end
            end
        end
    end
    return addNum
end

---获取税率信息的表数据
---@private
function UIAuctionItemReaddShelfController:GetRateTableData()
    if self.mRateInfo == nil then
        ---@private
        self.mRateInfo = {}
        local res, tableData = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22017)
        if res then
            local str = string.Split(tableData.value, "&")
            for i = 1, #str do
                local tbl = {}
                local str2 = string.Split(str[i], "#")
                for j = 1, #str2 do
                    tbl[j] = tonumber(str2[j])
                    self.mRateInfo[i] = tbl
                end
            end
        end
    end
    return self.mRateInfo
end

--[[****************************获取数值*****************************]]
---获取交易的物品数量
---@return number
function UIAuctionItemReaddShelfController:GetItemCount()
    return self.mMinMaxNumberPart:GetCurrentNumber()
end

---获取起拍单价
---@return number
function UIAuctionItemReaddShelfController:GetQiPaiSinglePrice()
    return math.ceil(self.mQiPaiSlider:GetCurrentValue())
end

---获取起拍总价
---@return number
function UIAuctionItemReaddShelfController:GetQiPaiSummaryPrice()
    return self:GetQiPaiSinglePrice() * self:GetItemCount()
end

---获取一口价单价
---@return number
function UIAuctionItemReaddShelfController:GetYiKouSinglePrice()
    return math.ceil(self.mYiKouSlider:GetCurrentValue() * self:GetQiPaiSinglePrice())
end

---获取一口总价
---@return number
function UIAuctionItemReaddShelfController:GetYiKouSummaryPrice()
    return self:GetYiKouSinglePrice() * self:GetItemCount()
end

---获取交易税最低值
---@return number
function UIAuctionItemReaddShelfController:GetTaxMin()
    ---交易税最低值即起拍总价对应的税值
    if self.mPublicToggle:GetValue() then
        return math.ceil(self:GetRateAmount(self:GetQiPaiSinglePrice()) * 0.5)
    else
        return math.ceil(self:GetRateAmount(self:GetQiPaiSinglePrice()))
    end
end

---获取交易税最高值
---@return number
function UIAuctionItemReaddShelfController:GetTaxMax()
    ---交易税最高值即一口总价对应的税值
    if self.mPublicToggle:GetValue() then
        return math.ceil(self:GetRateAmount(self:GetYiKouSinglePrice()) * 0.5)
    else
        return math.ceil(self:GetRateAmount(self:GetYiKouSinglePrice()))
    end
end

return UIAuctionItemReaddShelfController