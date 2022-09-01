---@class UIServerSelfSellPanel_UnitTemplate:UIAuctionPanel_SelfSellGridTemplate 跨服摆摊出售单元模板
local UIServerSelfSellPanel_UnitTemplate = {}

setmetatable(UIServerSelfSellPanel_UnitTemplate, luaComponentTemplates.UIAuctionPanel_SelfSellGridTemplate)
--region override
function UIServerSelfSellPanel_UnitTemplate:InitComponents()
    self:RunBaseFunction("InitComponents")
    ---@type UnityEngine.GameObject 小喇叭喊话
    self.btn_trumpet = self:Get("Info/btn_trumpet", "GameObject")

end

function UIServerSelfSellPanel_UnitTemplate:BindEvents()
    self:RunBaseFunction("BindEvents")
    CS.UIEventListener.Get(self.btn_trumpet).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_trumpet).OnClickLuaDelegate = self.OnTrumpetClick
end

---下架
function UIServerSelfSellPanel_UnitTemplate:OnRemoveClicked()
    if self.AuctionInfo then
        local data = {}
        data.AuctionInfo = self.AuctionInfo
        data.BagItemInfo = self.BagItemInfo
        data.Template = luaComponentTemplates.UIServerSelfSellPanel_TradeRemoveShelfDidNotExpireTemplate
        uimanager:CreatePanel('UIAuctionItemPanel', nil, data)
        self.mChooseBagItemInfo = self.BagItemInfo
    end
end

---上架过期
function UIServerSelfSellPanel_UnitTemplate:OverdueTime()
    self.TimeText_UILabel.text = ""
end
--endregion

--region UIEvent
---小喇叭点击
function UIServerSelfSellPanel_UnitTemplate:OnTrumpetClick()
    local boothInfo = CS.CSScene.MainPlayerInfo.AuctionInfo.BoothInfo
    if boothInfo and boothInfo.hasBooth then
        networkRequest.ReqUniteServerItemRadio(boothInfo.boothCoordinateId, boothInfo.boothId, self.BagItemInfo)
    end

end
--endregion

--region View

---刷新喇叭视图
function UIServerSelfSellPanel_UnitTemplate:RefreshTrumptView()

end

--endregion


return UIServerSelfSellPanel_UnitTemplate