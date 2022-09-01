---上架推送模板
---@class UIAuctionPushPanel_ShelvesPushTemplate:UIAuctionPushPanel_RootTemplate
local UIAuctionPushPanel_ShelvesPushTemplate = {}
setmetatable(UIAuctionPushPanel_ShelvesPushTemplate, luaComponentTemplates.UIAuctionPushPanel_RootTemplate)

function UIAuctionPushPanel_ShelvesPushTemplate:Init(data)
    self:RunBaseFunction("Init", data)
    self:ShowLabel()
    self:RefreshPrice()
    self:IsShelvePush(true)
end

function UIAuctionPushPanel_ShelvesPushTemplate:ShowLabel()
    self.title_UILabel.spriteName = "gainitem"
    self.priceName_UILabel.text = "交易行售价"
    self.mCenterButton_UILabel.text = "上架出售"
end

function UIAuctionPushPanel_ShelvesPushTemplate:RefreshPrice()
    if self.PushData and self.PushData.price and not CS.StaticUtility.IsNull(self.price_UILabel) then
        self.price_UILabel.text = self.PushData.price
    end
end

function UIAuctionPushPanel_ShelvesPushTemplate:OnClickCenterButton()
    networkRequest.ReqOpenTradeBefore()--先请求一次数据避免切换太快取不到数据
    --[[    local info = { itemId = self.PushData.priceItemId, count = math.ceil(self.PushData.price) }
        networkRequest.ReqAddToShelf(self.BagItemInfo.lid, self.BagItemInfo.count, info, Utility.EnumToInt(CS.auctionV2.AuctionItemType.THADED_PRODUCTS), false)]]
    local data = {}
    data.mNeedChooseBagItem = self.BagItemInfo
    uiTransferManager:TransferToPanel(LuaEnumTransferType.Auction_UpperShelf, data, nil)
    uimanager:ClosePanel("UIAuctionPushPanel")
end

return UIAuctionPushPanel_ShelvesPushTemplate