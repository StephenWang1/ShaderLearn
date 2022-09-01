---@class UIItemInfoPanel_AuctionSmelt_RightUpOperate:UIItemInfoPanel_AuctionTrade_RightUpOperate
local UIItemInfoPanel_AuctionSmelt_RightUpOperate = {}
setmetatable(UIItemInfoPanel_AuctionSmelt_RightUpOperate, luaComponentTemplates.UIItemInfoPanel_AuctionTrade_RightUpOperate)

function UIItemInfoPanel_AuctionSmelt_RightUpOperate:Exchange(go)
    local data = {}
    data.go = go
    data.lid = self.mBagItemInfo.lid
    luaEventManager.DoCallback(LuaCEvent.TryBuySmeltItem, data)
end

return UIItemInfoPanel_AuctionSmelt_RightUpOperate