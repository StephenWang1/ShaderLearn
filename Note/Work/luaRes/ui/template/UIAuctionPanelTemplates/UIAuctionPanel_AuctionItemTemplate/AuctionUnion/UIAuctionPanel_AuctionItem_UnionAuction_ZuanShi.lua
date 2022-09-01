---@class UIAuctionPanel_AuctionItem_UnionAuction_ZuanShi:UIAuctionPanel_AuctionItem_AuctionBid 行会竞拍模板_元宝
local UIAuctionPanel_AuctionItem_UnionAuction_ZuanShi = {}

setmetatable(UIAuctionPanel_AuctionItem_UnionAuction_ZuanShi, luaComponentTemplates.UIAuctionPanel_AuctionItem_AuctionBid)

UIAuctionPanel_AuctionItem_UnionAuction_ZuanShi.mNameShow = {
    [0] = "价格",
    [1] = "拥有",
}


---不允许修改数目
function UIAuctionPanel_AuctionItem_UnionAuction_ZuanShi:OnReduceBtnClicked(go)
end

---不允许修改数目
function UIAuctionPanel_AuctionItem_UnionAuction_ZuanShi:OnAddBtnClicked(go)
end

---@return number 价格行数
function UIAuctionPanel_AuctionItem_UnionAuction_ZuanShi:ShowCoin()
    local lineNum = 2
    self.coin_UIGridContainer.MaxCount = lineNum
    self.mPriceLabel = {}
    for i = 0, lineNum - 1 do
        local go = self.coin_UIGridContainer.controlList[i]
        self:RefreshLineCoin(go, i)
    end
    return lineNum
end

---刷新价格显示
function UIAuctionPanel_AuctionItem_UnionAuction_ZuanShi:RefreshPriceShow()
    local price = self:GetPrice()
    self.mPriceLabel[0].text = price
    if self:GetBagInfoV2() then
        local playerHas
        if (self.mCoinType == LuaEnumCoinType.Diamond) then
            playerHas = self:GetBagInfoV2():GetAuctionDiamondNum()
        else
            playerHas = self:GetBagInfoV2():GetCoinAmount(self.mCoinType)
        end
        local color = playerHas > price and luaEnumColorType.White or luaEnumColorType.Red
        self.mPriceLabel[1].text = color .. playerHas
    end
end

---点击竞价按钮
function UIAuctionPanel_AuctionItem_UnionAuction_ZuanShi:OnShelfClicked(go)

    local price = self:GetPrice()
    if self:IsCostEnough(price) then
        networkRequest.ReqAuctionLot(self.AuctionInfo.item.lid, Utility.EnumToInt(CS.auctionV2.AuctionType.BID))
        self:ClosePanel()
    else
        self:ShowMoneyNotEnoughTips(go)
    end

end

---判断自己道具是否足够购买
function UIAuctionPanel_AuctionItem_UnionAuction_ZuanShi:IsCostEnough(price)
    local isEnough = false
    if self.AuctionInfo and self.AuctionInfo.price then
        local selfCost
        if (self.mCoinType == LuaEnumCoinType.Diamond) then
            selfCost = self:GetBagInfoV2():GetAuctionDiamondNum()
        else
            selfCost = self:GetBagInfoV2():GetCoinAmount(self.mCoinType)
        end
        isEnough = price <= math.ceil(selfCost)
    end
    return isEnough
end

---显示道具不足提示
function UIAuctionPanel_AuctionItem_UnionAuction_ZuanShi:ShowMoneyNotEnoughTips(go)
    local EntranceType
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.AuctionIngotNotEnough
    EntranceType = LuaEnumRechargePointType.AuctionIngotNotEnoughToRewardGift
    Utility.ShowItemGetWay(self.mCoinType, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(100, 0), nil, EntranceType, "UIAuctionItemPanel");
end

---输入数目改变
function UIAuctionPanel_AuctionItem_UnionAuction_ZuanShi:NumChange(inputValue)
    self:SetNum()
end

return UIAuctionPanel_AuctionItem_UnionAuction_ZuanShi