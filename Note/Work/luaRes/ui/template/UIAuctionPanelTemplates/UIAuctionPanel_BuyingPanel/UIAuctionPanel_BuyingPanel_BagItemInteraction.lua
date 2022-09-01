---@class UIAuctionPanel_BuyingPanel_BagItemInteraction:UIBagTypeContainerInteraction 求购背包交互层模板
local UIAuctionPanel_BuyingPanel_BagItemInteraction = {}

setmetatable(UIAuctionPanel_BuyingPanel_BagItemInteraction, luaComponentTemplates.UIBagType_Interaction)

function UIAuctionPanel_BuyingPanel_BagItemInteraction:IsSingleClickedAvailable(grid, bagItemInfo, itemTbl)
    return true
end

---长按是否可用
---@param grid UIBagTypeGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
---@return boolean
function UIAuctionPanel_BuyingPanel_BagItemInteraction:IsLongPressAvailable(grid, bagItemInfo, itemTbl)
    return true
end

function UIAuctionPanel_BuyingPanel_BagItemInteraction:DoSingleClick(grid, bagItemInfo, itemTbl)
    ---@type UIAuctionPanel_BuyingPanel
    local panel = self.mRelyPanel
    panel:BagBtnOnClick(grid, bagItemInfo)
end

function UIAuctionPanel_BuyingPanel_BagItemInteraction:DoLongPress(grid, bagItemInfo, itemTbl)
    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTbl, showAssistPanel = true })
end

return UIAuctionPanel_BuyingPanel_BagItemInteraction