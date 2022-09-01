---@class UIAuctionPanel_AuctionItem_TradeRemoveShelfDidNotExpire:UIAuctionPanel_AuctionItem_TradeRemoveShelf 元宝交易下架模板（未到期）
local UIAuctionPanel_AuctionItem_TradeRemoveShelfDidNotExpire = {}

setmetatable(UIAuctionPanel_AuctionItem_TradeRemoveShelfDidNotExpire, luaComponentTemplates.UIAuctionPanel_AuctionItem_TradeRemoveShelf)

---刷新标题
function UIAuctionPanel_AuctionItem_TradeRemoveShelfDidNotExpire:RefreshTitle()
    self.centerBtn_UILabel.text = "下架"
end

---@return boolean 是否是单个按钮
function UIAuctionPanel_AuctionItem_TradeRemoveShelfDidNotExpire:IsSingleBtn()
    return true
end

---下架
function UIAuctionPanel_AuctionItem_TradeRemoveShelfDidNotExpire:OnShelfClicked(go)
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

return UIAuctionPanel_AuctionItem_TradeRemoveShelfDidNotExpire