---@class UIItemInfoPanel_Stall_RightUpUperate:UIItemInfoPanel_AuctionTrade_RightUpOperate
local UIItemInfoPanel_Stall_RightUpUperate = {}

setmetatable(UIItemInfoPanel_Stall_RightUpUperate, luaComponentTemplates.UIItemInfoPanel_AuctionTrade_RightUpOperate)

function UIItemInfoPanel_Stall_RightUpUperate:Exchange(go)
    local data = {}
    data.lid = self.mBagItemInfo.lid
    data.go = go
    luaEventManager.DoCallback(LuaCEvent.AuctionStallItemChangeBuyState, data)
end

return UIItemInfoPanel_Stall_RightUpUperate