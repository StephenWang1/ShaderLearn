---@class UIAuctionSmeltPanel_BuyGridTemplate:UIAuctionGridItem 熔炼行购买格子模板
local UIAuctionSmeltPanel_BuyGridTemplate = {}

setmetatable(UIAuctionSmeltPanel_BuyGridTemplate, luaComponentTemplates.UIAuctionGridItem)

function UIAuctionSmeltPanel_BuyGridTemplate:GetPrefabGO()
    if self.mPrefabGO == nil and self:GetRootPanel() then
        self.mPrefabGO = self:GetRootPanel():GetCurComp("WidgetRoot/ItemsArea/uiAuctionItemTemplate", "GameObject")
    end
    return self.mPrefabGO
end

---@return UIAuctionSmeltPanel
function UIAuctionSmeltPanel_BuyGridTemplate:GetRootPanel()
    return self.RootPanel
end

---点击格子
function UIAuctionSmeltPanel_BuyGridTemplate:OnAuctionItemClicked()
    if self.AuctionInfo then
        local data = {}
        data.AuctionInfo = self.AuctionInfo
        data.BagItemInfo = self.AuctionInfo.item
        ---@type UIAuctionPanel_SmeltItem
        data.Template = luaComponentTemplates.UIAuctionPanel_SmeltItem
        uimanager:CreatePanel('UIAuctionItemPanel', nil, data)
        self:SetBuyItemInfo()
        self:SaveFlyInfo()
    end
end

function UIAuctionSmeltPanel_BuyGridTemplate:OnIconClicked()
    if self.BagItemInfo and self.ItemInfo and self:GetRootPanel() then
        self:GetRootPanel().mCurrentWillBuyItemInfo = self.AuctionInfo
        ---@type UIItemInfoPanel_AuctionTrade_RightUpOperate
        local rightUpTemplate = luaComponentTemplates.UIItemInfoPanel_AuctionSmelt_RightUpOperate
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.BagItemInfo, showAssistPanel = true, showMoreAssistData = true, showTabBtns = true, rightUpButtonsModule = rightUpTemplate, showMoreAssistData = true, showBtnIdTable = true })
        --self:SetBuyItemInfo()
        --luaEventManager.DoCallback(LuaCEvent.AuctionBuyTradeItem, 1)
        self:SaveFlyInfo()
    end
end

function UIAuctionSmeltPanel_BuyGridTemplate:SaveFlyInfo()
    if self:GetRootPanel() then
        local pos = self:GetIcon_Go().gameObject.transform.position
        self:GetRootPanel():SetBuyItemInfo(self.ItemInfo.id, pos)
    end
end

return UIAuctionSmeltPanel_BuyGridTemplate