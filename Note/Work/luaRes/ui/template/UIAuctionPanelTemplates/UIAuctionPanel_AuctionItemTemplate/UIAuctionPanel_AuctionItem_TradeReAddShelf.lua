---@class UIAuctionPanel_AuctionItem_TradeReAddShelf: UIAuctionPanel_AuctionItem_TradAddShelfMix 元宝交易重新上架模板
local UIAuctionPanel_AuctionItem_TradeReAddShelf = {}

setmetatable(UIAuctionPanel_AuctionItem_TradeReAddShelf, luaComponentTemplates.UIAuctionPanel_AuctionItem_TradAddShelfMix)

---设置数目等，方便重写
function UIAuctionPanel_AuctionItem_TradeReAddShelf:SetNumData(data)
    self.mMaxNum = data.BagItemInfo.count
    self.mMinNum = data.BagItemInfo.count
    self.num = self.mMinNum
end

function UIAuctionPanel_AuctionItem_TradeReAddShelf:IsSingleBtn()
    return true
end

function UIAuctionPanel_AuctionItem_TradeReAddShelf:RefreshTitle()
    self.num_BoxCollider.enabled = false
    self.centerBtn_UILabel.text = "重新上架"
end

function UIAuctionPanel_AuctionItem_TradeReAddShelf:OnShelfClicked()
    if self.data and self.num and self.price then
        local info = { itemId = self.mCoinType, count = math.ceil(self.price) }
        networkRequest.ReqReAddToShelf(self.data.BagItemInfo.lid, info, false, Utility.EnumToInt(CS.auctionV2.AuctionItemType.THADED_PRODUCTS))
    end
    self:ClosePanel()
end

return UIAuctionPanel_AuctionItem_TradeReAddShelf