---@class UIAuctionPanel_AuctionItem_AuctionRemoveShelf:UIAuctionPanel_AuctionItemTemplateBase 竞拍下架模板
local UIAuctionPanel_AuctionItem_AuctionRemoveShelf = {}

setmetatable(UIAuctionPanel_AuctionItem_AuctionRemoveShelf, luaComponentTemplates.UIAuctionPanel_AuctionItemTemplateBase)

function UIAuctionPanel_AuctionItem_AuctionRemoveShelf:Init(data)
    self:RunBaseFunction("Init", data)
    ---@type auctionV2.AuctionItemInfo
    self.AuctionInfo = data.AuctionInfo
    self.num_UIInput.text = self.AuctionInfo.item.count
    self.num_BoxCollider.enabled = false
    self:SuitPanel()
end

function UIAuctionPanel_AuctionItem_AuctionRemoveShelf:IsNumLabelNeedSpace()
    return true
end

---@return boolean 是否是单个按钮
function UIAuctionPanel_AuctionItem_AuctionRemoveShelf:IsSingleBtn()
    return false
end

---@return boolean 是否显示滑条
function UIAuctionPanel_AuctionItem_AuctionRemoveShelf:ShowSlider()
    return false
end

---@return boolean 是否显示公示
function UIAuctionPanel_AuctionItem_AuctionRemoveShelf:ShowLabel()
    return false
end

function UIAuctionPanel_AuctionItem_AuctionRemoveShelf:ShowNum()
    return true
end

---@return number 价格行数
function UIAuctionPanel_AuctionItem_AuctionRemoveShelf:ShowCoin()
    local line = 0
    if self.AuctionInfo == nil then
        return line
    end

    local coinId = self.AuctionInfo.price.itemId
    local price = self.AuctionInfo.price.count
    if self.AuctionInfo.itemType == Utility.EnumToInt(CS.auctionV2.AuctionItemType.THADED_PRODUCTS) then
        ---交易品 说明是直购
        line = 1
        self.coin_UIGridContainer.MaxCount = 1
        local go = self.coin_UIGridContainer.controlList[0]
        self:RefreshSinglePrice(go, self:GetItemInfo(coinId), price, "一口价")
    else
        line = 3
        self.coin_UIGridContainer.MaxCount = 3
        if self.coin_UIGridContainer.controlList.Count >= 3 then
            local go1 = self.coin_UIGridContainer.controlList[0]
            self:RefreshSinglePrice(go1, self:GetItemInfo(coinId), price, "起拍价")
            local go2 = self.coin_UIGridContainer.controlList[1]

            local bidPrice = 0
            local auctionInfo = self.AuctionInfo.auctionItemLotInfo
            if auctionInfo then
                bidPrice = auctionInfo.bidPrice
            end
            self:RefreshSinglePrice(go2, self:GetItemInfo(coinId), bidPrice, "竞拍价")
            local go3 = self.coin_UIGridContainer.controlList[2]
            if auctionInfo then
                self:RefreshSinglePrice(go3, self:GetItemInfo(coinId), auctionInfo.fixedPrice, "一口价")
            end
        end
    end
    return line
end

---@param go UnityEngine.GameObject
---@param isShowIcon boolean 是否显示icon
---@param coinInfo TABLE.CFG_ITEMS 货币信息
---@param price number 价格
function UIAuctionPanel_AuctionItem_AuctionRemoveShelf:RefreshSinglePrice(go, coinInfo, price, title)
    local icon = CS.Utility_Lua.Get(go.transform, "Sprite", "UISprite")
    local priceLabel = CS.Utility_Lua.Get(go.transform, "gold", "UILabel")
    local titleLabel = CS.Utility_Lua.Get(go.transform, "Label", "UILabel")
    if coinInfo and not CS.StaticUtility.IsNull(icon) then
        icon.spriteName = coinInfo.icon
    end
    if not CS.StaticUtility.IsNull(priceLabel) then
        priceLabel.text = price
    end
    if not CS.StaticUtility.IsNull(titleLabel) then
        titleLabel.text = title
    end
end

---重新上架
function UIAuctionPanel_AuctionItem_AuctionRemoveShelf:OnLeftClicked()
    luaEventManager.DoCallback(LuaCEvent.AuctionItemReAdd, self.AuctionInfo)
    networkRequest.ReqMarketPriceSection(self.AuctionInfo.item.lid, Utility.EnumToInt(CS.auctionV2.MarketPriceSectionType.RE_ADD), self.AuctionInfo.itemType, 0)
    self:ClosePanel()
end

---下架
function UIAuctionPanel_AuctionItem_AuctionRemoveShelf:OnRightBtnClicked(go)
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

return UIAuctionPanel_AuctionItem_AuctionRemoveShelf