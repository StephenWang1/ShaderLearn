---@class UIAuctionPanel_AuctionItem_AuctionRemoveShelfDidNotExpire:UIAuctionPanel_AuctionItem_AuctionRemoveShelf 钻石交易行未过期下架
local UIAuctionPanel_AuctionItem_AuctionRemoveShelfDidNotExpire = {}

setmetatable(UIAuctionPanel_AuctionItem_AuctionRemoveShelfDidNotExpire, luaComponentTemplates.UIAuctionPanel_AuctionItem_AuctionRemoveShelf)

---@return boolean 是否是单个按钮
function UIAuctionPanel_AuctionItem_AuctionRemoveShelfDidNotExpire:IsSingleBtn()
    return true
end

---下架
function UIAuctionPanel_AuctionItem_AuctionRemoveShelfDidNotExpire:OnShelfClicked(go)
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

---刷新标题
function UIAuctionPanel_AuctionItem_AuctionRemoveShelfDidNotExpire:RefreshTitle()
    self.centerBtn_UILabel.text = "下架"
end

return UIAuctionPanel_AuctionItem_AuctionRemoveShelfDidNotExpire