---@class UIAuctionPanel_BuyingPanel_BagItemTemplate:UIBagTypeGrid 求购背包格子模板
local UIAuctionPanel_BuyingPanel_BagItemTemplate = {}

setmetatable(UIAuctionPanel_BuyingPanel_BagItemTemplate, luaComponentTemplates.UIBagType_Grid)

function UIAuctionPanel_BuyingPanel_BagItemTemplate:RefreshSingleGrid(bagItemInfo, itemTbl)
    if bagItemInfo and itemTbl then
        ---刷新icon
        self:SetCompSpriteName(self.Components.Icon, itemTbl.icon)
        self:SetCompLabelContent(self.Components.Count, (bagItemInfo.count > 1) and tostring(bagItemInfo.count) or nil)
    end
    self:SetCompActive(self.Components.BackGround, true)
end

return UIAuctionPanel_BuyingPanel_BagItemTemplate