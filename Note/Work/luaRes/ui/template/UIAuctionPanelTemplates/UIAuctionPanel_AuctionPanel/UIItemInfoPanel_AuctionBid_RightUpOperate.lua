---@class UIItemInfoPanel_AuctionBid_RightUpOperate:UIItemInfoPanel_Info_RightUpOperateButtons 竞拍行-icon竞价右上角 竞价/一口价 按钮
local UIItemInfoPanel_AuctionBid_RightUpOperate = {}

setmetatable(UIItemInfoPanel_AuctionBid_RightUpOperate, luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)

---使用信息刷新(重写此方法改变按钮)
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_AuctionBid_RightUpOperate:RefreshWithInfo(commonData)
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    self.mBagItemInfo = bagItemInfo
    self.mItemInfo = itemInfo
    self:SetBtnState()
    self:BGSelfAdaptaion()
end

function UIItemInfoPanel_AuctionBid_RightUpOperate:SetBtnState()
    self:GetBtns_UIGridContainer().MaxCount = 2
    self:SetButtonShow(self:GetBtns_UIGridContainer().controlList[0], "竞价", function(go)
        self:BidItem(go)
    end)
    self:SetButtonShow(self:GetBtns_UIGridContainer().controlList[1], "购买", function(go)
        self:BuyItem(go)
    end)
end

---设置按钮显示及事件
function UIItemInfoPanel_AuctionBid_RightUpOperate:SetButtonShow(buttonGO, des, tab)
    ---@type UILabel
    local btnLabel = CS.Utility_Lua.Get(buttonGO.transform, "Label", "UILabel")
    local btnSp = CS.Utility_Lua.Get(buttonGO.transform, "backGround", "UISprite")
    btnLabel.text = luaEnumColorType.Red3 .. des
    btnLabel.color = CS.UnityEngine.Color(1, 1, 1, 1)
    btnSp.spriteName = "anniu8"
    self:GetShowClose_GameObject():SetActive(false)
    CS.UIEventListener.Get(buttonGO).onClick = function(go)
        tab(go)
    end
end

---@class AuctionBidData
---@field lid number 竞价道具lid
---@field go UnityEngine.GameObject 竞价按钮

---竞价
function UIItemInfoPanel_AuctionBid_RightUpOperate:BidItem(go)
    ---@type AuctionBidData
    local data = {}
    data.lid = self.mBagItemInfo.lid
    data.go = go
    luaEventManager.DoCallback(LuaCEvent.AuctionBidItemChangeBidState, data)
end

---购买
function UIItemInfoPanel_AuctionBid_RightUpOperate:BuyItem(go)
    local data = {}
    data.lid = self.mBagItemInfo.lid
    data.go = go
    luaEventManager.DoCallback(LuaCEvent.AuctionBidItemChangeBuyState, data)
end

return UIItemInfoPanel_AuctionBid_RightUpOperate