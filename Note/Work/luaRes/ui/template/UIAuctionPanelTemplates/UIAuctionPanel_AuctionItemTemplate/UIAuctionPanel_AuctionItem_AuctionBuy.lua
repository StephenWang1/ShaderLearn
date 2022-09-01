---@class UIAuctionPanel_AuctionItem_AuctionBuy:UIAuctionPanel_AuctionItem_AuctionBid 钻石交易行购买模板
local UIAuctionPanel_AuctionItem_AuctionBuy = {}

setmetatable(UIAuctionPanel_AuctionItem_AuctionBuy, luaComponentTemplates.UIAuctionPanel_AuctionItem_AuctionBid)

function UIAuctionPanel_AuctionItem_AuctionBuy:GetMaxNum()
    return self.mCanBuyMaxNum;
end

function UIAuctionPanel_AuctionItem_AuctionBuy:Init(data)
    self:RunBaseFunction("Init", data)
    ---@type auctionV2.AuctionItemInfo
    self.AuctionInfo = data.AuctionInfo

    --价格
    if self:GetIsBuy() then
        self.price = self.AuctionInfo.price.count
    else
        if self.AuctionInfo.auctionItemLotInfo then
            self.price = self.AuctionInfo.auctionItemLotInfo.fixedPrice
        else
            self.price = self.AuctionInfo.price.count
        end
    end

    --数目
    local mSellNum = data.BagItemInfo.count
    local playerCanBuy = 0
    local playerHas = self:GetBagInfoV2():GetAuctionDiamondNum()
    if playerHas then
        playerCanBuy = math.floor(playerHas / self.price)
    end

    self.mCanBuyMaxNum = math.min(mSellNum, playerCanBuy)
    self.mCanBuyMaxNum = self.mCanBuyMaxNum <= 0 and 1 or self.mCanBuyMaxNum;
    --self.mMaxNum = math.min(mSellNum, playerCanBuy)
    self.mMaxNum = mSellNum;

    if self.mMaxNum == 0 then
        self.mMaxNum = 1
    end
    self.mMinNum = 1
    self.num = self.mMaxNum

    self:SuitPanel()
    self:SetNum()
end

---点击数目增加
function UIAuctionPanel_AuctionItem_AuctionBuy:OnAddBtnClicked(go)
    if self.num and self.num + 1 <= self.mMaxNum then
        self.num = self.num + 1
        self:SetNum()
    end
end

---点击减少按钮
---交易行的逻辑，减少到最小值继续减少变成最大值，要修改可以重写此方法，一定要调用SetNum刷新
function UIAuctionPanel_AuctionItem_AuctionBuy:OnReduceBtnClicked(go)
    if self.num then
        if self.num - 1 >= self.mMinNum then
            self.num = self.num - 1
        else
            self.num = self:GetMaxNum();
        end
        self:SetNum()
    end
end
---刷新价格显示
function UIAuctionPanel_AuctionItem_AuctionBuy:RefreshPriceShow()
    local totalPrice = self.price * self.num
    self.mPriceLabel[0].text = totalPrice
    if self:GetBagInfoV2() then
        local isEnough = self:IsDiamondEnough(totalPrice)
        local color = isEnough and luaEnumColorType.White or luaEnumColorType.Red
        self.mPriceLabel[1].text = color .. self:GetBagInfoV2():GetAuctionDiamondNum();
    end
    if Utility.IsAuctionDiamondQuotaOpen then
        if self:GetPlayerInfo() then
            local isEnough = self:IsDiamondQuotaEnough(totalPrice)
            local color = isEnough and luaEnumColorType.White or luaEnumColorType.Red
            self.mPriceLabel[2].text = color .. self:GetPlayerInfo().Data.auctionDiamond .. "[-]";
        end
    end
end

---判断自己道具是否足够购买
function UIAuctionPanel_AuctionItem_AuctionBuy:IsDiamondEnough(price)
    if self.AuctionInfo and self.AuctionInfo.price then
        local selfCost = Utility.GetAuctionDiamondNum()
        return price <= math.ceil(selfCost)
    end
    return false
end

function UIAuctionPanel_AuctionItem_AuctionBuy:IsDiamondQuotaEnough(price)
    if self.AuctionInfo and self.AuctionInfo.price then
        local diamond = self:GetPlayerInfo().Data.auctionDiamond
        return price <= diamond
    end
    return false
end

---点击购买按钮
function UIAuctionPanel_AuctionItem_AuctionBuy:OnShelfClicked(go)
    if (Utility.IsPushSpecialGift()) then
        uimanager:CreatePanel("UIRechargeGiftPanel")
        return
    end
    if self:IsCostEnough(self.price * self.num) then
        if self:GetIsBuy() then
            ---背包空间是否足够
            local res, csItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.AuctionInfo.item.itemId)
            if res then
                if not CS.CSScene.MainPlayerInfo.BagInfo:CheckIsAbleToAddItemOfNumbers(csItemInfo, self.num) then
                    Utility.ShowPopoTips(go, nil, 422, "UIAuctionItemPanel")
                    return
                end
                networkRequest.ReqBuyAuctionAuction(self.AuctionInfo.item.lid, self.num, 1)
            end
        else
            local res, csItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.AuctionInfo.item.itemId)
            if res then
                ---背包空间是否足够
                if not CS.CSScene.MainPlayerInfo.BagInfo:CheckIsAbleToAddItemOfNumbers(csItemInfo, self.num) then
                    Utility.ShowPopoTips(go, nil, 422, "UIAuctionItemPanel")
                    return
                end
                networkRequest.ReqAuctionLot(self.AuctionInfo.item.lid, Utility.EnumToInt(CS.auctionV2.AuctionType.ONEPRICE))
            end
        end
        luaEventManager.DoCallback(LuaCEvent.AuctionBuyAuctionItem, self.num)
        self:ClosePanel()
    else
        self:ShowMoneyNotEnoughTips(go)
    end
end

function UIAuctionPanel_AuctionItem_AuctionBuy:GetIsBuy()
    if self.isBuy == nil and self.data then
        self.isBuy = self.data.AuctionInfo.itemType == Utility.EnumToInt(CS.auctionV2.AuctionItemType.THADED_PRODUCTS)
    end
    return self.isBuy
end

---刷新标题
function UIAuctionPanel_AuctionItem_AuctionBuy:RefreshTitle()
    self.centerBtn_UILabel.text = "购买"
end

return UIAuctionPanel_AuctionItem_AuctionBuy