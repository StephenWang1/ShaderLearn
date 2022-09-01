---@class UIAuctionPanel_AuctionItem_UnionAuction_YuanBaoOnePrice:UIAuctionPanel_AuctionItem_AuctionBuy 行会一口价(元宝）
local UIAuctionPanel_AuctionItem_UnionAuction_YuanBaoOnePrice = {}
setmetatable(UIAuctionPanel_AuctionItem_UnionAuction_YuanBaoOnePrice, luaComponentTemplates.UIAuctionPanel_AuctionItem_AuctionBuy)

UIAuctionPanel_AuctionItem_UnionAuction_YuanBaoOnePrice.mCoinType = LuaEnumCoinType.YuanBao

UIAuctionPanel_AuctionItem_UnionAuction_YuanBaoOnePrice.mNameShow = {
    [0] = "价格",
    [1] = "拥有",
}

---不允许修改数目
function UIAuctionPanel_AuctionItem_UnionAuction_YuanBaoOnePrice:OnReduceBtnClicked(go)

end

---不允许修改数目
function UIAuctionPanel_AuctionItem_UnionAuction_YuanBaoOnePrice:OnAddBtnClicked(go)

end

---@return number 价格行数
function UIAuctionPanel_AuctionItem_UnionAuction_YuanBaoOnePrice:ShowCoin()
    local lineNum = self:GetNameNum()
    self.coin_UIGridContainer.MaxCount = lineNum
    self.mPriceLabel = {}
    for i = 0, lineNum - 1 do
        local go = self.coin_UIGridContainer.controlList[i]
        self:RefreshLineCoin(go, i)
    end
    return lineNum
end

---刷新价格显示
function UIAuctionPanel_AuctionItem_UnionAuction_YuanBaoOnePrice:RefreshPriceShow()
    local totalPrice = self.price
    self.mPriceLabel[0].text = totalPrice
    if self:GetBagInfoV2() then
        local isEnough = self:IsCostEnough(totalPrice)
        local color = isEnough and luaEnumColorType.White or luaEnumColorType.Red
        local playerhas
        if (self.mCoinType == LuaEnumCoinType.YuanBao) then
            playerhas = self:GetBagInfoV2():GetAuctionIngotNum()
        else
            playerhas = self:GetBagInfoV2():GetCoinAmount(self.mCoinType)
        end
        self.mPriceLabel[1].text = color .. playerhas
    end
end

---点击购买按钮
function UIAuctionPanel_AuctionItem_UnionAuction_YuanBaoOnePrice:OnShelfClicked(go)
    if self:IsCostEnough(self.price) then
        ---背包空间是否足够
        local csItemInfo = self:GetItemInfo(self.AuctionInfo.item.itemId)
        if csItemInfo then
            if not CS.CSScene.MainPlayerInfo.BagInfo:CheckIsAbleToAddItemOfNumbers(csItemInfo, self.num) then
                Utility.ShowPopoTips(go, nil, 422, "UIAuctionItemPanel")
                return
            end
        end
        networkRequest.ReqAuctionLot(self.AuctionInfo.item.lid, Utility.EnumToInt(CS.auctionV2.AuctionType.ONEPRICE))
        luaEventManager.DoCallback(LuaCEvent.AuctionBuyAuctionItem, self.num)
        self:ClosePanel()
    else
        self:ShowMoneyNotEnoughTips(go)
    end
end

---判断自己道具是否足够购买
function UIAuctionPanel_AuctionItem_UnionAuction_YuanBaoOnePrice:IsCostEnough(price)
    local isEnough = false
    if self.AuctionInfo and self.AuctionInfo.price then
        local selfCost
        if (self.mCoinType == LuaEnumCoinType.YuanBao) then
            selfCost = self:GetBagInfoV2():GetAuctionIngotNum()
        else
            selfCost = self:GetBagInfoV2():GetCoinAmount(self.mCoinType)
        end
        isEnough = price <= math.ceil(selfCost)
    end
    return isEnough
end

---显示道具不足提示
function UIAuctionPanel_AuctionItem_UnionAuction_YuanBaoOnePrice:ShowMoneyNotEnoughTips(go)
    local EntranceType
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.AuctionIngotNotEnough
    EntranceType = LuaEnumRechargePointType.AuctionIngotNotEnoughToRewardGift
    Utility.ShowItemGetWay(self.mCoinType, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(100, 0), nil, EntranceType, "UIAuctionItemPanel");
end

---输入数目改变
function UIAuctionPanel_AuctionItem_UnionAuction_YuanBaoOnePrice:NumChange(inputValue)
    self:SetNum()
end

return UIAuctionPanel_AuctionItem_UnionAuction_YuanBaoOnePrice