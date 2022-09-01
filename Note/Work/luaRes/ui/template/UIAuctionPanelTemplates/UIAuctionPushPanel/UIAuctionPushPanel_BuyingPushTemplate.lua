---拍卖行购买推送
---@class UIAuctionPushPanel_BuyingPushTemplate:UIAuctionPushPanel_RootTemplate
local UIAuctionPushPanel_BuyingPushTemplate = {}
setmetatable(UIAuctionPushPanel_BuyingPushTemplate, luaComponentTemplates.UIAuctionPushPanel_RootTemplate)

function UIAuctionPushPanel_BuyingPushTemplate:Init(data)
    self:RunBaseFunction("Init", data)
    self:ShowLabel()
    self:IsShelvePush(false)
end

function UIAuctionPushPanel_BuyingPushTemplate:ShowLabel()
    self.title_UILabel.spriteName = "newup"
    self.priceName_UILabel.text = "交易行售价"
    self.mCenterButton_UILabel.text = "前往购买"
    if self.ItemInfo then
        local id = self.ItemInfo.id
        local showInfo = CS.Cfg_GlobalTableManager.Instance:GetAuctionPushShowInfo(id)
        self.buyShowLabel.text = string.gsub(showInfo, '\\n', '\n')
    end
end

function UIAuctionPushPanel_BuyingPushTemplate:OnClickCenterButton()
    ---@type AuctionPanelData
    local data = {}
    data.pushData = self.BagItemInfo.lid
    data.auctionTradePushReason = LuaEnumAuctionTradePanelShowReason.GuessLikeBuyPush
    uiTransferManager:TransferToPanel(LuaEnumTransferType.Auction_Trade, data, nil)
end

return UIAuctionPushPanel_BuyingPushTemplate