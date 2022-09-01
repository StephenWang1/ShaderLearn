---@class UIItemInfoPanel_AuctionBid_BuyRightUpOperate:UIItemInfoPanel_AuctionBid_RightUpOperate
local UIItemInfoPanel_AuctionBid_BuyRightUpOperate = {}

setmetatable(UIItemInfoPanel_AuctionBid_BuyRightUpOperate, luaComponentTemplates.UIItemInfoPanel_AuctionBid_RightUpOperate)

function UIItemInfoPanel_AuctionBid_BuyRightUpOperate:SetBtnState()
    self:GetBtns_UIGridContainer().MaxCount = 1
    self:SetButtonShow(self:GetBtns_UIGridContainer().controlList[0], "购买", function(go)
        self:BuyItem(go)
    end)
end

return UIItemInfoPanel_AuctionBid_BuyRightUpOperate