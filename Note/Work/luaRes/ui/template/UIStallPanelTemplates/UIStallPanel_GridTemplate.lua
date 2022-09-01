---@class UIStallPanel_GridTemplate:UIAuctionPanel_SelfSellGridTemplate
local UIStallPanel_GridTemplate = {}
setmetatable(UIStallPanel_GridTemplate, luaComponentTemplates.UIAuctionPanel_SelfSellGridTemplate)

function UIStallPanel_GridTemplate:BindEvents()
    CS.UIEventListener.Get(self.icon_GameObject).onClick = function(go)
        self:OnIconClicked(go)
    end
    CS.UIEventListener.Get(self.go).onClick = function()
        self:GridOnClick()
    end
end

function UIStallPanel_GridTemplate:InitComponents()
    self:RunBaseFunction("InitComponents")
    ---@type UISprite
    self.good_UISprite = self:Get("Info/icon/good", "UISprite")
end

---刷新UI
---@param info auctionV2.AuctionItemInfo 背包物品信息
---@param gridType 背包格子类型 格子类型
function UIStallPanel_GridTemplate:RefreshUI(info)
    self.Info_GameObject:SetActive(info ~= nil)
    if info ~= nil then
        self.AuctionInfo = info
        self.BagItemInfo = self.AuctionInfo.item
        if self.BagItemInfo then
            self:RefreshStrengthInfo()
            ___, self.ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.BagItemInfo.itemId)
            if self.ItemInfo then
                --物品图片
                if self.ItemIcon_UISprite then
                    self.ItemIcon_UISprite.spriteName = self.ItemInfo.icon
                end
                --物品数量
                if self.ItemCount_UILabel then
                    self.ItemCount_UILabel.text = ternary(self.BagItemInfo.count == 0 or self.BagItemInfo.count == 1, "", self.BagItemInfo.count)
                end
                --物品名字
                if self.ItemName_UILabel then
                    self.ItemName_UILabel.text =  Utility.GetShortShowLabel(self.ItemInfo.name)
                end
                --价格
                if self.PriceText_UILabel then
                    self.PriceText_UILabel.text = self.AuctionInfo.price.count
                end
                --货币icon
                if self.PriceSprite_UISprite then
                    local resPrice, priceItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.AuctionInfo.price.itemId)
                    if resPrice then
                        self.PriceSprite_UISprite.spriteName = priceItemInfo.icon
                    end
                end
                --设置绿色箭头
                local type = Utility.GetArrowType(self.BagItemInfo)
                self.good_UISprite.gameObject:SetActive(type ~= LuaEnumArrowType.NONE)
                if type ~= LuaEnumArrowType.NONE then
                    self.good_UISprite.spriteName = CS.Cfg_GlobalTableManager.Instance:GetArrowSpriteName(type)
                end
            end
        end
    end
end

---@param go UnityEngine.GameObject
function UIStallPanel_GridTemplate:OnIconClicked(go)
    if self.BagItemInfo and self.ItemInfo then
        if self.SelfSellPanel ~= nil and self.SelfSellPanel:IsMainPlayerStall() == true then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.BagItemInfo, showRight = false, showAssistPanel = true, showMoreAssistData = true, showTabBtns = false })
        else
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.BagItemInfo, showAssistPanel = true, showMoreAssistData = true, showTabBtns = false })
        end
        self:SaveFlyData()
    end
end

function UIStallPanel_GridTemplate:GridOnClick()
    if self.SelfSellPanel ~= nil and self.SelfSellPanel:IsMainPlayerStall() == true then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.BagItemInfo, showRight = false, showAssistPanel = true, showMoreAssistData = true, showTabBtns = true })
    else
        local auctionInfo = self.AuctionInfo
        if auctionInfo then
            local data = {}
            ---@type UIAuctionItemPanel_StallPanel
            data.Template = luaComponentTemplates.UIAuctionItemPanel_StallPanel
            data.AuctionInfo = auctionInfo
            data.BagItemInfo = self.BagItemInfo
            uimanager:CreatePanel('UIAuctionItemPanel', nil, data)
        end
    end
    self:SaveFlyData()
end

function UIStallPanel_GridTemplate:SaveFlyData()
    if self.SelfSellPanel then
        ---@type UIStallPanel
        local panel = self.SelfSellPanel
        panel.mBuyNum = 1
        panel.mStallBuyItemPos = self.icon_GameObject.transform.position
        local itemId = self.BagItemInfo.ItemTABLE.id
        panel.mStallBuyItemId = itemId
        panel:SaveBagData(itemId)
    end
end

return UIStallPanel_GridTemplate