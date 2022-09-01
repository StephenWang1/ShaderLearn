---@class UIAuctionPanel_BuyingPanel_Menu :UIAuctionFiltrateList
local UIAuctionPanel_BuyingPanel_Menu = {}
setmetatable(UIAuctionPanel_BuyingPanel_Menu, luaComponentTemplates.UIAuctionFiltrateList)

function UIAuctionPanel_BuyingPanel_Menu:ReqFilterItems(page)
    ---@type UIAuctionPanel_BuyingPanel
    local TradeMenu = self.RootPanel
    TradeMenu:ClearCurrentData()
    self:NetWorkReq(page)
    TradeMenu:SetNeedRefresh()
end

function UIAuctionPanel_BuyingPanel_Menu:NetWorkReq(page)
    local pageIndex = ternary(page == nil, 1, page)
    local minLv = -1
    local maxLv = -1
    local itemType = Utility.EnumToInt(CS.auctionV2.AuctionItemType.BUY_PRODUCTS)
    local sortBy = Utility.EnumToInt(CS.auctionV2.SalfProductsSortType.BUYPRODUCTSPRICE)

    local list = CS.auctionV2.GetAuctionItemsRequest().screenCondition
    for i = 1, #self.filtrateConditionList do
        if self.filtrateConditionList[i] ~= "" then
            list:Add(self.filtrateConditionList[i])
        end
    end
    networkRequest.ReqGetAuctionItems(pageIndex, minLv, maxLv, -1, -1, -1, -1, list, itemType, sortBy, false, self.CareerPropertyTendency)
end

return UIAuctionPanel_BuyingPanel_Menu