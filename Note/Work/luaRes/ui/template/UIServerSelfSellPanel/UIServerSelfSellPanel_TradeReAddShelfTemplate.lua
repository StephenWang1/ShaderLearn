---@class UIServerSelfSellPanel_TradeReAddShelfTemplate:UIAuctionPanel_AuctionItem_TradAddShelfMix 跨服摆摊重新上架模板
local UIServerSelfSellPanel_TradeReAddShelfTemplate = {}
setmetatable(UIServerSelfSellPanel_TradeReAddShelfTemplate, luaComponentTemplates.UIAuctionPanel_AuctionItem_TradAddShelfMix)

---设置数目等，方便重写
function UIServerSelfSellPanel_TradeReAddShelfTemplate:SetNumData(data)
    self.mMaxNum = data.BagItemInfo.count
    self.mMinNum = data.BagItemInfo.count
    self.num = self.mMinNum
end

function UIServerSelfSellPanel_TradeReAddShelfTemplate:IsSingleBtn()
    return true
end

function UIServerSelfSellPanel_TradeReAddShelfTemplate:RefreshTitle()
    self.num_BoxCollider.enabled = false
    self.centerBtn_UILabel.text = "重新上架"
end

---重载重新上架消息
function UIServerSelfSellPanel_TradeReAddShelfTemplate:OnShelfClicked(go)
    if not Utility.IsOpenShareStall() then
        Utility.ShowPopoTips(go,nil,123,"UIAuctionItemPanel")
    end
    if self.data and self.num and self.price then
        --TODO 跨服摆摊判断
        local info = { itemId = self.mCoinType, count = math.ceil(self.price) }
        networkRequest.ReqReAddToShelf(self.data.BagItemInfo.lid, info, false, Utility.EnumToInt(CS.auctionV2.AuctionItemType.MOON_BOOTH))
    end
    self:ClosePanel()
end

return UIServerSelfSellPanel_TradeReAddShelfTemplate