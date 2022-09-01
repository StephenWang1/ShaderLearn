---@class UIServerSelfSellPanel_TradAddShelfMixTemplate:UIAuctionPanel_AuctionItem_TradAddShelfMix 跨服摆摊混合模板元宝/钻石
local UIServerSelfSellPanel_TradAddShelfMixTemplate = {}
setmetatable(UIServerSelfSellPanel_TradAddShelfMixTemplate, luaComponentTemplates.UIAuctionPanel_AuctionItem_TradAddShelfMix)

---重载点击上架
function UIServerSelfSellPanel_TradAddShelfMixTemplate:OnShelfClicked()
    if self.data and self.num and self.price then
        if (gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(self.data.BagItemInfo)) then
            gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():ShowInsurancePopup()
            return
        end
        local info = { itemId = self.mCoinType, count = math.ceil(self.price) }
        --TODO 跨服摆摊判断
        networkRequest.ReqAddToShelf(self.data.BagItemInfo.lid, self.num, info, Utility.EnumToInt(CS.auctionV2.AuctionItemType.MOON_BOOTH), false)
    end
    self:ClosePanel()
end

return UIServerSelfSellPanel_TradAddShelfMixTemplate