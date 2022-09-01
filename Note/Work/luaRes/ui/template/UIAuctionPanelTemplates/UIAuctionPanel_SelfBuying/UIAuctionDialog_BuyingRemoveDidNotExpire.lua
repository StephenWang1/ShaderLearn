---@class UIAuctionDialog_BuyingRemoveDidNotExpire:UIAuctionBuyingReAddTemplate
local UIAuctionDialog_BuyingRemoveDidNotExpire = {}

setmetatable(UIAuctionDialog_BuyingRemoveDidNotExpire, luaComponentTemplates.UIAuctionBuyingReAddTemplate)

---是否显示滑条
function UIAuctionDialog_BuyingRemoveDidNotExpire:IsShowSlider()
    return false
end

---数字输入框是否可点
function UIAuctionDialog_BuyingRemoveDidNotExpire:IsNumCanClick()
    return false
end

---总价输入框是否可点
function UIAuctionDialog_BuyingRemoveDidNotExpire:IsTotalPriceCanClick()
    return false
end

---获取道具数目信息
function UIAuctionDialog_BuyingRemoveDidNotExpire:SetInitNum()
    if self.data.AuctionInfo then
        self.name.text = self.data.AuctionInfo.auctionItemBuyProductsInfo.name
        self.priceInput.value = self.data.AuctionInfo.price.count
    end
    self.num = self.data.buyPrice
end

function UIAuctionDialog_BuyingRemoveDidNotExpire:SetPrice()

end

---刷新文本显示
function UIAuctionDialog_BuyingRemoveDidNotExpire:RefreshLabelShow()
    self.priceName.text = "单价"
end

function UIAuctionDialog_BuyingRemoveDidNotExpire:InitBtnState()
    self:SetButton(true)
    self:ShowAddButton(true)
    self.middleButtonLabel.text = "取消求购"
end

---取消求购
function UIAuctionDialog_BuyingRemoveDidNotExpire:MiddleButtonClicked()
    if self.data and self.data.AuctionInfo then
        networkRequest.ReqRemoveFromShelf(self.data.AuctionInfo.item.lid, Utility.EnumToInt(CS.auctionV2.AuctionItemType.BUY_PRODUCTS))
    end
    self:ClosePanel()
end

return UIAuctionDialog_BuyingRemoveDidNotExpire