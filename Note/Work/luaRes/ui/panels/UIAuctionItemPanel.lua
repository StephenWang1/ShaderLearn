---@class UIAuctionItemPanel:UIBase 交易行上架模板
local UIAuctionItemPanel = {}

--region 组件
function UIAuctionItemPanel:GetTemplateRoot()
    if self.mTemplateRoot == nil then
        self.mTemplateRoot = self:GetCurComp("WidgetRoot", "GameObject")
    end
    return self.mTemplateRoot
end

---@return UIPanel
function UIAuctionItemPanel:GetPanel()
    if self.mPanel == nil then
        self.mPanel = self:GetCurComp("", "UIPanel")
    end
    return self.mPanel
end
--endregion

--region 初始化
function UIAuctionItemPanel:Init()
    self:SetAlpha(1 / 255)
    self:BindMessage()
end

function UIAuctionItemPanel:BindMessage()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        if self.Template then
            if self.Template.IsAuctionItemController ~= nil and self.Template:IsAuctionItemController() then
                self.Template:OnBagCoinRefreshed()
            else
                self.Template:SetNum()
            end
        end
    end)
end

---@class AuctionItemData
---@field Template UIAuctionPanel_AuctionItemTemplateBase|UIAuctionItemController
---@field BagItemInfo bagV2.BagItemInfo
---@field PriceData auctionV2.MarketPriceSection
---@field ItemState auctionV2.BagItemState
---@field Type number
---@field NeedColider boolean
---@field itemInfo TABLE.CFG_ITEMS
---@param data AuctionItemData
function UIAuctionItemPanel:Show(data)
    if data == nil then
        self:ClosePanel()
        return
    end
    if data.Template then
        if data.Template.IsAuctionItemController ~= nil and data.Template:IsAuctionItemController() then
            ---@type UIAuctionPanel_AuctionItemTemplateBase
            self.Template = templatemanager.GetNewTemplate(self:GetTemplateRoot(), data.Template, self, data)
        else
            ---@type UIAuctionPanel_AuctionItemTemplateBase
            self.Template = templatemanager.GetNewTemplate(self:GetTemplateRoot(), data.Template, data)
        end
    end
    local showAssistPanel = false
    if data.showAssistPanel ~= nil then
        showAssistPanel = data.showAssistPanel
    end
    if data.BagItemInfo then
        uiStaticParameter.UIItemInfoManager:CreatePanel({
            bagItemInfo = data.BagItemInfo,
            itemInfo = data.BagItemInfo.ItemTABLE,
            showRight = false,
            showAssistPanel = showAssistPanel,
            isCloseCollider = true,
            refreshEndFunc = function(panel)
                local itemWidth
                itemWidth = panel:GetBackground_UISprite().width / 2
                local itemHeight = panel:GetBackground_UISprite().height / 2
                panel.go.transform.localPosition = CS.UnityEngine.Vector3(-itemWidth, 0, 0)
                local maxNum = panel:GetPanelGridContainer().MaxCount
                if maxNum == 1 then
                    itemWidth = 0
                end
                self:SetStartPosition(itemHeight, itemWidth, maxNum)
                self:SetAlpha(1)
            end })
    elseif data.itemInfo then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = data.itemInfo, showRight = false, showAssistPanel = showAssistPanel, isCloseCollider = true, refreshEndFunc = function(panel)
            local itemWidth
            itemWidth = panel:GetBackground_UISprite().width / 2
            local itemHeight = panel:GetBackground_UISprite().height / 2
            panel.go.transform.localPosition = CS.UnityEngine.Vector3(-itemWidth, 0, 0)
            local maxNum = panel:GetPanelGridContainer().MaxCount
            if maxNum == 1 then
                itemWidth = 0
            end
            self:SetStartPosition(itemHeight, itemWidth, maxNum)
            self:SetAlpha(1)
        end })
    end

    local needCol = true
    if data.NeedColider ~= nil then
        needCol = data.NeedColider
    end
    if needCol then
        self:AddCollider()
    end
end

function UIAuctionItemPanel:SetStartPosition(itemHeight, itemWidth)
    if self.Template then
        if self.Template.IsAuctionItemController ~= nil and self.Template:IsAuctionItemController() then
            self.Template:SetPosition(itemHeight, itemWidth)
        else
            local width = self.Template.bg_UISprite.width / 2;
            local head = ternary(self.Template:ShowTitleBtn(), self.Template.titleBtnHeight, 0)
            local height = itemHeight - 125 - head
            self:GetTemplateRoot().transform.localPosition = { x = width + itemWidth, y = height, z = 0 }
        end
    end
end
--endregion

---设置alpha
function UIAuctionItemPanel:SetAlpha(alpha)
    if self:GetPanel() then
        self:GetPanel().alpha = alpha
    end
end

function ondestroy()
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
end

return UIAuctionItemPanel