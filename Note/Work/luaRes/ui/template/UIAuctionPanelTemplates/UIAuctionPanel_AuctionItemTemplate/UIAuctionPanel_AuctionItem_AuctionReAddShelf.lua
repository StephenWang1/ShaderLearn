---@class UIAuctionPanel_AuctionItem_AuctionReAddShelf:UIAuctionPanel_AuctionItem_AuctionAddShelf 竞拍重新上架模板
local UIAuctionPanel_AuctionItem_AuctionReAddShelf = {}

setmetatable(UIAuctionPanel_AuctionItem_AuctionReAddShelf, luaComponentTemplates.UIAuctionPanel_AuctionItem_AuctionAddShelf)

function UIAuctionPanel_AuctionItem_AuctionReAddShelf:IsSingleBtn()
    return true
end

function UIAuctionPanel_AuctionItem_AuctionReAddShelf:RefreshTitle()
    self.num_BoxCollider.enabled = false
    self.centerBtn_UILabel.text = "重新上架"
end

function UIAuctionPanel_AuctionItem_AuctionReAddShelf:ResetData()
    self.slider_UISlider.value = 0
    self:SetPrice(self.mMinPrice)
    self.num = self.mMaxNum
    self:SetNum()
    self.mMinNum = self.mMaxNum
end

function UIAuctionPanel_AuctionItem_AuctionReAddShelf:OnShelfClicked()
    if self.price and self.PriceItemId then
        local info = { itemId = self.PriceItemId, count = math.ceil(self.price) }
        local type = ternary(self.ShowType == LuaEnumDiamondShelfType.Buy, Utility.EnumToInt(CS.auctionV2.AuctionItemType.THADED_PRODUCTS), Utility.EnumToInt(CS.auctionV2.AuctionItemType.SALF_PRODUCTS))
        networkRequest.ReqReAddToShelf(self.data.BagItemInfo.lid, info, self.isPublicity, type)
    end
    self:ClosePanel()
end

return UIAuctionPanel_AuctionItem_AuctionReAddShelf