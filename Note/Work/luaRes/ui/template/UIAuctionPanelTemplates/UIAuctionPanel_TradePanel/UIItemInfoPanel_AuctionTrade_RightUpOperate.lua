---@class UIItemInfoPanel_AuctionTrade_RightUpOperate:UIItemInfoPanel_Info_RightUpOperateButtons 拍卖行右上角购买按钮
local UIItemInfoPanel_AuctionTrade_RightUpOperate = {}

setmetatable(UIItemInfoPanel_AuctionTrade_RightUpOperate, luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons)

---使用信息刷新(重写此方法改变按钮)
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_AuctionTrade_RightUpOperate:RefreshWithInfo(commonData)
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    self.mBagItemInfo = bagItemInfo
    self.mItemInfo = itemInfo
    self:GetBtns_UIGridContainer().MaxCount = 1
    self:SetButtonShow(self:GetBtns_UIGridContainer().controlList[0], "购买")
    self:BGSelfAdaptaion()
end

---设置按钮显示及事件
function UIItemInfoPanel_AuctionTrade_RightUpOperate:SetButtonShow(buttonGO, des)
    ---@type UILabel
    local btnLabel = CS.Utility_Lua.Get(buttonGO.transform, "Label", "UILabel")
    local btnSp = CS.Utility_Lua.Get(buttonGO.transform, "backGround", "UISprite")
    self:GetShowClose_GameObject():SetActive(false)
    btnLabel.text = luaEnumColorType.Red3 .. des
    btnLabel.color = CS.UnityEngine.Color(1, 1, 1, 1)
    btnSp.spriteName = "anniu8"
    CS.UIEventListener.Get(buttonGO).onClick = function(go)
        self:Exchange(go)
    end
end

function UIItemInfoPanel_AuctionTrade_RightUpOperate:Exchange(go)
    local data = {}
    data.go = go
    data.lid = self.mBagItemInfo.lid
    luaEventManager.DoCallback(LuaCEvent.AuctionItemChangeBuyState, data)
end

return UIItemInfoPanel_AuctionTrade_RightUpOperate