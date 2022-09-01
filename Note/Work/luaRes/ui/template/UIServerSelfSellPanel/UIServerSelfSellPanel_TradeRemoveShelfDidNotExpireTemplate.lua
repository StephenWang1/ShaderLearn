---@class UIServerSelfSellPanel_TradeRemoveShelfDidNotExpireTemplate:UIAuctionPanel_AuctionItem_TradeRemoveShelfDidNotExpire 跨服摆摊下架模板(未到期)
local UIServerSelfSellPanel_TradeRemoveShelfDidNotExpireTemplate = {}
setmetatable(UIServerSelfSellPanel_TradeRemoveShelfDidNotExpireTemplate,luaComponentTemplates.UIAuctionPanel_AuctionItem_TradeRemoveShelfDidNotExpire)

---重载下架消息
function UIServerSelfSellPanel_TradeRemoveShelfDidNotExpireTemplate:OnShelfClicked(go)
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


return UIServerSelfSellPanel_TradeRemoveShelfDidNotExpireTemplate