---@class UIAuctionPushPanel_PlayerTradePushTemplate:UIAuctionPushPanel_RootTemplate
local UIAuctionPushPanel_PlayerTradePushTemplate = {}

setmetatable(UIAuctionPushPanel_PlayerTradePushTemplate, luaComponentTemplates.UIAuctionPushPanel_RootTemplate)

function UIAuctionPushPanel_PlayerTradePushTemplate:Init(data)
    self:RunBaseFunction("Init", data)
    self:ShowLabel()
    self:IsShelvePush(false)
    self.Type = self.PushData.type
end

function UIAuctionPushPanel_PlayerTradePushTemplate:NeedShowToggle()
    return true
end

function UIAuctionPushPanel_PlayerTradePushTemplate:ShowLabel()
    self.title_UILabel.spriteName = "newup"
    self.priceName_UILabel.text = "交易行售价"
    self.mCenterButton_UILabel.text = "前往购买"
    if self.ItemInfo then
        local id = self.ItemInfo.id
        local showInfo = CS.Cfg_GlobalTableManager.Instance:GetAuctionPushShowInfo(id)
        self.buyShowLabel.text = string.gsub(showInfo, '\\n', '\n')
    end
end

function UIAuctionPushPanel_PlayerTradePushTemplate:OnClickCenterButton()
    if self.BagItemInfo then
        if self.Type == 1 then
            --交易行
            ---@type AuctionPanelData
            local data = {}
            local ownData = {}
            local itemId = self.BagItemInfo.itemId
            ownData.mChooseName = CS.Cfg_ItemsTableManager.Instance:GetItemName(itemId)
            ownData.mChooseItemId = itemId
            data.mOwnData = ownData
            data.auctionTradePushReason = LuaEnumAuctionTradePanelShowReason.TradePush
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Auction_Trade, data, nil)
        elseif self.Type == 4 then
            --装备行
            local data = {}
            local ownData = {}
            local itemId = self.BagItemInfo.itemId
            ownData.mChooseName = CS.Cfg_ItemsTableManager.Instance:GetItemName(itemId)
            ownData.mChooseItemId = itemId
            data.mOwnData = ownData
            data.auctionTradePushReason = LuaEnumAuctionTradePanelShowReason.SmeltPush
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Auction_Smelt, data, nil)
        end
    end
end

return UIAuctionPushPanel_PlayerTradePushTemplate