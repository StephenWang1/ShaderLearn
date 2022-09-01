---@class UIServerSelfSellPanel_TradeRemoveShelfTemplate:UIAuctionPanel_AuctionItem_TradeRemoveShelf 跨服摆摊下架模板（已过期）
local UIServerSelfSellPanel_TradeRemoveShelfTemplate = {}
setmetatable(UIServerSelfSellPanel_TradeRemoveShelfTemplate,luaComponentTemplates.UIAuctionPanel_AuctionItem_TradeRemoveShelf)

---重载重新上架
function UIServerSelfSellPanel_TradeRemoveShelfTemplate:OnLeftClicked()
    self:ClosePanel()
    networkRequest.ReqMarketPriceSection(self.data.BagItemInfo.lid, Utility.EnumToInt(CS.auctionV2.MarketPriceSectionType.RE_ADD), Utility.EnumToInt(CS.auctionV2.AuctionItemType.THADED_PRODUCTS),0)
end

---重载下架
function UIServerSelfSellPanel_TradeRemoveShelfTemplate:OnRightBtnClicked(go)
    local bagInfo = self:GetBagInfoV2().EmptyGridCount
    if bagInfo and bagInfo <= 0 then
        Utility.ShowPopoTips(go, nil, 336)
        return
    end
    if self.AuctionInfo then
        networkRequest.ReqRemoveFromShelf(self.AuctionInfo.item.lid, self.AuctionInfo.itemType)
    end
    self:ClosePanel()
end

return UIServerSelfSellPanel_TradeRemoveShelfTemplate