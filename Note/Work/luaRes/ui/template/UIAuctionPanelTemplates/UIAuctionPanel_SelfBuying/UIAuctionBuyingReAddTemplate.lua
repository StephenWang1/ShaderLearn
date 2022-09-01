---@class UIAuctionBuyingReAddTemplate:UIAuctionBuyingTemplate
local UIAuctionBuyingReAddTemplate = {}

setmetatable(UIAuctionBuyingReAddTemplate, luaComponentTemplates.UIAuctionBuyingTemplate)

function UIAuctionBuyingReAddTemplate:InitBtnState()
    self:SetButton(false)
    self:ShowAddButton(true)
    self.leftButtonLabel.text = "重新求购"
    self.rightButtonLabel.text = "取消求购"
end

---数字输入框是否可点
function UIAuctionBuyingReAddTemplate:IsNumCanClick()
    return false
end

---获取道具数目信息
function UIAuctionBuyingReAddTemplate:SetInitNum()
    --local AuctionInfo = self.PriceData.marketPriceSection
    --
    -- local totalNeed = self.AuctionInfo.itemCount
    -- local current = self.AuctionInfo.auctionItemBuyProductsInfo.count
    -- local need = totalNeed - current
    -- self.des_UILabel.text = "(" .. need .. "/" .. totalNeed .. ")"

    self.num = self.PriceData.condition.count
end

---设置价格显示
function UIAuctionBuyingReAddTemplate:SetPriceData1()
    self.lowPrice = self.PriceData.marketPriceSection.lowPrice
    self.topPrice = self.PriceData.marketPriceSection.topPrice
    self.price = self.lowPrice
    local sliderValue
    if self.topPrice == self.lowPrice then
        sliderValue = 1
    else
        sliderValue = (self.price - self.lowPrice) / (self.topPrice - self.lowPrice)
    end

    self:SetSliderCanMove(false)

    self.slider.value = sliderValue
end

---重新求购
function UIAuctionBuyingReAddTemplate:LeftButtonClicked()
    if self.price then
        local id = self.PriceData.lid
        local info = { itemId = self.PriceItemId, count = math.ceil(self.price) }
        networkRequest.ReqReAddToShelf(id, info, false, Utility.EnumToInt(CS.auctionV2.AuctionItemType.BUY_PRODUCTS))
        self:ClosePanel()
    end
end

---取消求购
function UIAuctionBuyingReAddTemplate:RightButtonClicked()
    if self.PriceData then
        networkRequest.ReqRemoveFromShelf(self.PriceData.lid, Utility.EnumToInt(CS.auctionV2.AuctionItemType.BUY_PRODUCTS))
    end
    self:ClosePanel()
end

return UIAuctionBuyingReAddTemplate