---@class UIItemInfoPanel_AuctionUnionBid_RightUpOperate:UIItemInfoPanel_AuctionBid_RightUpOperate
local UIItemInfoPanel_AuctionUnionBid_RightUpOperate = {}
setmetatable(UIItemInfoPanel_AuctionUnionBid_RightUpOperate, luaComponentTemplates.UIItemInfoPanel_AuctionBid_RightUpOperate)

---竞价
function UIItemInfoPanel_AuctionUnionBid_RightUpOperate:BidItem(go)
    local data = {}
    data.lid = self.mBagItemInfo.lid
    data.go = go
    luaEventManager.DoCallback(LuaCEvent.mAuctionUnionTryBidItem, data)
end

---购买
function UIItemInfoPanel_AuctionUnionBid_RightUpOperate:BuyItem(go)
    local data = {}
    data.lid = self.mBagItemInfo.lid
    data.go = go
    luaEventManager.DoCallback(LuaCEvent.mAuctionUnionTryBuyItem, data)
end

return UIItemInfoPanel_AuctionUnionBid_RightUpOperate