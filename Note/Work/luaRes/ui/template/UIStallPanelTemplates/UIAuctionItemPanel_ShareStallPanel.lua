---@class UIAuctionItemPanel_ShareStallPanel:UIAuctionItemPanel_StallPanel
local UIAuctionItemPanel_ShareStallPanel = {}
setmetatable(UIAuctionItemPanel_ShareStallPanel,luaComponentTemplates.UIAuctionItemPanel_StallPanel)

---点击购买按钮
function UIAuctionItemPanel_ShareStallPanel:OnShelfClicked(go)
    if self.data and self.data.AuctionInfo then
        if self:IsCostEnough() then
            local lid = self.data.AuctionInfo.item.lid
            luaEventManager.DoCallback(LuaCEvent.StallBuyItem, self.num)
            networkRequest.ReqBoothBuy(uiStaticParameter.BoothLid, lid, self.num,1)
            self:ClosePanel()
        else
            if self.mCoinType == LuaEnumCoinType.YuanBao then
                self:ShowMoneyNotEnoughTips(go)
            else
                Utility.JumpRechargePanel(go)
            end
        end
    end
end


return UIAuctionItemPanel_ShareStallPanel