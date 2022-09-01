---@class UIAuctionPanel_AuctionItem_TradeBuy:UIAuctionPanel_AuctionItemTemplateBase 元宝交易行购买模板
local UIAuctionPanel_AuctionItem_TradeBuy = {}

setmetatable(UIAuctionPanel_AuctionItem_TradeBuy, luaComponentTemplates.UIAuctionPanel_AuctionItemTemplateBase)

UIAuctionPanel_AuctionItem_TradeBuy.mCanBuyMaxNum = 0;

UIAuctionPanel_AuctionItem_TradeBuy.mNameShow = {
    [0] = "价格",
    [1] = "拥有"
}

UIAuctionPanel_AuctionItem_TradeBuy.mCoinType = LuaEnumCoinType.YuanBao

function UIAuctionPanel_AuctionItem_TradeBuy:GetMaxNum()
    return self.mCanBuyMaxNum;
end

---@param data customData
---@alias customData{BagItemInfo:bagV2.BagItemInfo,AuctionInfo:auctionV2.AuctionItemInfo,AuctionPanel:UIAuctionPanel}
function UIAuctionPanel_AuctionItem_TradeBuy:Init(data)
    self:RunBaseFunction("Init", data)

    ---@type  UIAuctionPanel
    self.auctionPanel = data.AuctionPanel
    --价格
    self.price = data.AuctionInfo.price.count
    --数目
    local mSellNum = data.BagItemInfo.count
    local playerCanBuy = 0

    local playerHas = self:GetPlayerHas()
    if playerHas then
        playerCanBuy = math.floor(playerHas / self.price)
    end

    --self.mMaxNum = math.min(mSellNum, playerCanBuy)
    self.mMaxNum = mSellNum;
    if self.mMaxNum == 0 then
        self.mMaxNum = 1
    end
    self.mCanBuyMaxNum = math.min(mSellNum, playerCanBuy)
    self.mCanBuyMaxNum = self.mCanBuyMaxNum <= 0 and 1 or self.mCanBuyMaxNum;
    self.mMinNum = 1
    self.num = self.mMaxNum
    --刷新
    self:SuitPanel()
    self:SetNum()
end

--region 重写
---@return boolean 是否显示标题
function UIAuctionPanel_AuctionItem_TradeBuy:ShowTitleBtn()
    return false
end

---@return boolean 是否显示数目
function UIAuctionPanel_AuctionItem_TradeBuy:ShowNum()
    return true
end

---@return number 价格行数
function UIAuctionPanel_AuctionItem_TradeBuy:ShowCoin()
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
function UIAuctionPanel_AuctionItem_TradeBuy:RefreshPriceShow()
    self.mPriceLabel[0].text = self.price * self.num
    local num = self:GetPlayerHas()
    local show = num
    if num == nil then
        show = 0
    end
    self.mPriceLabel[1].text = (self:IsCostEnough() and luaEnumColorType.White or luaEnumColorType.Red) .. show .. "[-]";
end

---刷新每行货币信息
---@param go UnityEngine.GameObject 每行货币
---@param i number 从0开始的行数
function UIAuctionPanel_AuctionItem_TradeBuy:RefreshLineCoin(go, i)
    local name = CS.Utility_Lua.Get(go.transform, "Label", "UILabel")
    local priceIcon = CS.Utility_Lua.Get(go.transform, "Sprite", "UISprite")
    local priceLabel = CS.Utility_Lua.Get(go.transform, "gold", "UILabel")
    name.text = self.mNameShow[i]
    self.mPriceLabel[i] = priceLabel
    priceIcon.spriteName = self:GetTradePriceItemInfo().icon
end

---@return TABLE.CFG_ITEMS 元宝交易行货币信息
function UIAuctionPanel_AuctionItem_TradeBuy:GetTradePriceItemInfo()
    if self.mCoinInfo == nil then
        ___, self.mCoinInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mCoinType)
    end
    return self.mCoinInfo
end

---@return boolean 是否显示滑条
function UIAuctionPanel_AuctionItem_TradeBuy:ShowSlider()
    return false
end

---@return boolean 是否是单个按钮
function UIAuctionPanel_AuctionItem_TradeBuy:IsSingleBtn()
    return true
end

---@return boolean 是否显示文本
function UIAuctionPanel_AuctionItem_TradeBuy:ShowLabel()
    return false
end

---点击购买按钮
function UIAuctionPanel_AuctionItem_TradeBuy:OnShelfClicked(go)
    if self.data and self.data.AuctionInfo then
        if self:IsCostEnough() then
            ---@type bagV2.BagItemInfo
            local bagItemInfo = self.data.AuctionInfo.item
            local priceId = self.mCoinType
            if Utility.IsItemCanBuy(bagItemInfo.ItemTABLE, go, priceId) then
                ---背包空间是否足够
                if not CS.CSScene.MainPlayerInfo.BagInfo:CheckIsAbleToAddItemOfNumbers(bagItemInfo.ItemTABLE, self.num) then
                    Utility.ShowPopoTips(go, nil, 422,"UIAuctionItemPanel")
                    return
                end

                local lid = bagItemInfo .lid
                networkRequest.ReqBuyAuctionAuction(lid, self.num, 1)
                if self.auctionPanel then
                    self.auctionPanel:GetAuctionInfoV2():BuyItem(lid)
                end
                luaEventManager.DoCallback(LuaCEvent.AuctionBuyTradeItem, self.num)
                self:ClosePanel()
            end
        else
            self:ShowMoneyNotEnoughTips(go)
        end
    end
end

---显示道具不足提示
function UIAuctionPanel_AuctionItem_TradeBuy:ShowMoneyNotEnoughTips(go)
    local EntranceType
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.AuctionIngotNotEnough
    EntranceType = LuaEnumRechargePointType.AuctionIngotNotEnoughToRewardGift
    Utility.ShowItemGetWay(self.mCoinType, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(100, 0), nil, EntranceType, "UIAuctionItemPanel");
end

---判断自己道具是否足够购买
function UIAuctionPanel_AuctionItem_TradeBuy:IsCostEnough()
    local isEnough = false
    if self.price and self.num then
        local playerHas = self:GetPlayerHas()
        if playerHas then
            isEnough = playerHas >= math.ceil(self.price * self.num)
        end
    end
    return isEnough
end

---刷新玩家拥有
function UIAuctionPanel_AuctionItem_TradeBuy:GetPlayerHas()
    local selfCost = CS.CSScene.MainPlayerInfo.BagInfo:GetAuctionIngotNum()
    --local selfCost = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(self.mCoinType)
    return selfCost
end

---刷新标题
function UIAuctionPanel_AuctionItem_TradeBuy:RefreshTitle()
    self.centerBtn_UILabel.text = "购买"
end

function UIAuctionPanel_AuctionItem_TradeBuy:SetNum()
    self.num_UIInput.value = self.num
    self:RefreshPriceShow()
end
--endregion

return UIAuctionPanel_AuctionItem_TradeBuy