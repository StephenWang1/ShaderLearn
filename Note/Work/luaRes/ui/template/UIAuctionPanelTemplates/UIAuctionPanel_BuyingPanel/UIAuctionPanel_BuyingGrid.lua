---@class UIAuctionPanel_BuyingGrid:TemplateBase 求购界面格子模板
local UIAuctionPanel_BuyingGrid = {}

setmetatable(UIAuctionPanel_BuyingGrid, luaComponentTemplates.UIAuctionPanel_AuctionGrid)

--region 组件
function UIAuctionPanel_BuyingGrid:GetBtnSell_GameObject()
    if self.mBtnSell_GameObject == nil then
        self.mBtnSell_GameObject = self:Get("Root/btn_sell", "GameObject")
    end
    return self.mBtnSell_GameObject
end

function UIAuctionPanel_BuyingGrid:GeBuyNum_UILabel()
    if self.mBuyNum_UILabel == nil then
        self.mBuyNum_UILabel = self:Get("Root/BuyNum", "UILabel")
    end
    return self.mBuyNum_UILabel
end

function UIAuctionPanel_BuyingGrid:GetRoot_GameObject()
    if self.mRoot_GameObject == nil then
        self.mRoot_GameObject = self:Get("Root", "GameObject")
    end
    return self.mRoot_GameObject
end
--endregion

--region  初始化
---@param panel UIAuctionPanel_BuyingPanel 父界面
function UIAuctionPanel_BuyingGrid:Init(panel)
    self.RootPanel = panel
    self:InitComponent()
    self:BindEvents()
end

function UIAuctionPanel_BuyingGrid:InitComponent()
    --region Item
    self.icon_GameObject = self:Get("Root/icon", "GameObject")
    self.icon_UISprite = self:Get("Root/icon", "UISprite")
    self.strength_UILabel = self:Get("Root/strengthen", "UILabel")
    self.name_UILabel = self:Get("Root/name", "UILabel")
    --endregion
    --endregion
    --region 一口价
    self.oncePriceIcon_UISprite = self:Get("Root/Price/ingotSymbol", "UISprite")
    self.oncePrice_UILabel = self:Get("Root/Price", "UILabel")
    --endregion

    ---@type UISprite 出售按钮背景
    self.BtnBG_UISprite = self:Get("Root/btn_sell", "UISprite")
    ---@type UILabel
    self.BtnBG_UILabel = self:Get("Root/btn_sell/CaptionLabel", "UILabel")
end

function UIAuctionPanel_BuyingGrid:BindEvents()
    CS.UIEventListener.Get(self.icon_GameObject).onClick = function()
        self:OnIconClicked()
    end
    CS.UIEventListener.Get(self:GetBtnSell_GameObject()).onClick = function(go)
        self:BuyBtnOnClick(go)
    end
end

--endregion

---@param auctionInfo.itemCount 求购总数量
---@param auctionInfo.price.count 求购单价
---@param auctionInfo.price.itemId 求购道具Id
---@param auctionInfo.auctionItemBuyProductsInfo.Count 当前求购数量
function UIAuctionPanel_BuyingGrid:RefreshUI(auctionInfo, sellBtnClick)
    if auctionInfo then
        self:GetRoot_GameObject():SetActive(true)
        self.AuctionInfo = auctionInfo
        self.itemId = auctionInfo.price.itemId
        if self.AuctionInfo.auctionItemBuyProductsInfo == nil then
            return
        end
        self.itemName = self.AuctionInfo.auctionItemBuyProductsInfo.name
        local isFind
        isFind, self.itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.itemId)
        local priceBagItemInfo = self.AuctionInfo.item
        isFind, self.priceInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(priceBagItemInfo.itemId)
        self.singlePrice = self.AuctionInfo.price.count
        self.maxNeedNum = self.AuctionInfo.itemCount
        self.minNeedNum = self.maxNeedNum - self.AuctionInfo.auctionItemBuyProductsInfo.count
        self.roleId = auctionInfo.roleId
        self.sellBtnClick = sellBtnClick
        self:ShowRoot(true)
        self:ShowItem()
        self:SetBuyNum()
        self:ShowPrice()
        self:ShowBuyBtn()
    else
        self:ResetGrid()
    end
    self.strength_UILabel.gameObject:SetActive(false)
end

function UIAuctionPanel_BuyingGrid:ShowItem()
    if self.itemName ~= nil then
        self.name_UILabel.text = self.itemName
        local icon = CS.Cfg_GlobalTableManager.Instance:GetSpecialNameIcon(self.itemName)
        self.icon_UISprite.spriteName = icon
    else
        self.name_UILabel.text = ""
        self.icon_UISprite.spriteName = ""
    end
end

function UIAuctionPanel_BuyingGrid:SetBuyNum()
    if self.minNeedNum ~= nil and self.maxNeedNum ~= nil then
        self:GeBuyNum_UILabel().text = tostring(self.minNeedNum) .. "/" .. tostring(self.maxNeedNum)
    else
        self:GeBuyNum_UILabel().text = ""
    end
end

function UIAuctionPanel_BuyingGrid:ShowPrice()
    if self.priceInfo ~= nil and self.oncePrice_UILabel ~= nil and self.oncePriceIcon_UISprite ~= nil then
        self.oncePriceIcon_UISprite.spriteName = self.priceInfo.icon
        self.oncePrice_UILabel.text = self.singlePrice
    else
        self.oncePriceIcon_UISprite = ""
        self.oncePrice_UILabel.text = ""
    end
end

function UIAuctionPanel_BuyingGrid:BuyBtnOnClick(go)
    if self.isSameRole then
        Utility.ShowPopoTips(go, nil, 227)
    else
        self.RootPanel:OnSellBtnClicked(go, self.itemInfo, self.AuctionInfo, self.go.transform.localPosition)
    end
end

function UIAuctionPanel_BuyingGrid:ShowBuyBtn()
    self.isSameRole = CS.CSScene.MainPlayerInfo.ID == self.roleId
    local hasItem = self:FilterIsItemInBag(self.itemInfo, self.AuctionInfo)
    local isGray = self.isSameRole or not hasItem
    local color = ternary(isGray, LuaEnumUnityColorType.Gray, LuaEnumUnityColorType.Normal)
    self.BtnBG_UISprite.color = color
    local textColor = ternary(isGray, "[878787]", "[C3F4FF]")
    self.BtnBG_UILabel.text = textColor .. "出售"
end

---判断背包中是都有可出售道具，用于按钮置灰
function UIAuctionPanel_BuyingGrid:FilterIsItemInBag(itemInfo, auctionInfo)
    if itemInfo ~= nil then
        local showItems = CS.CSScene.MainPlayerInfo.AuctionInfo:IsSameItemInBag(itemInfo)
        return showItems
    end
    if auctionInfo ~= nil then
        local auctionItemBuyProductsInfo = auctionInfo.auctionItemBuyProductsInfo
        local showItems = CS.CSScene.MainPlayerInfo.BagInfo:IsBagHasItemCanSellToAuction(auctionItemBuyProductsInfo)
        return showItems
    end
    return false
end

function UIAuctionPanel_BuyingGrid:ResetGrid()
    self:GetRoot_GameObject():SetActive(false)
end

return UIAuctionPanel_BuyingGrid