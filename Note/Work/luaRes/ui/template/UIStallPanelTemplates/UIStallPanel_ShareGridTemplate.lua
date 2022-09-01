---@class UIStallPanel_ShareGridTemplate:UIStallPanel_GridTemplate 跨服摆摊格子模板
local UIStallPanel_ShareGridTemplate = {}
setmetatable(UIStallPanel_ShareGridTemplate, luaComponentTemplates.UIStallPanel_GridTemplate)

function UIStallPanel_ShareGridTemplate:GridOnClick()
    if self.SelfSellPanel ~= nil and self.SelfSellPanel:IsMainPlayerStall() == true then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.BagItemInfo, showRight = false, showAssistPanel = true, showMoreAssistData = true, showTabBtns = true })
    else
        local auctionInfo = self.AuctionInfo
        if auctionInfo then
            local data = {}
            ---@type UIAuctionItemPanel_ShareStallPanel
            data.Template = luaComponentTemplates.UIAuctionItemPanel_ShareStallPanel
            data.AuctionInfo = auctionInfo
            data.BagItemInfo = self.BagItemInfo
            uimanager:CreatePanel('UIAuctionItemPanel', nil, data)
        end
    end
    self:SaveFlyData()
end

return UIStallPanel_ShareGridTemplate