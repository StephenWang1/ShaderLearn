---@class UIAuctionItemPanel_StallPanel:UIAuctionPanel_AuctionItemTemplateBase
local UIAuctionItemPanel_StallPanel = {}

setmetatable(UIAuctionItemPanel_StallPanel, luaComponentTemplates.UIAuctionPanel_AuctionItemTemplateBase)

UIAuctionItemPanel_StallPanel.mNameShow = {
    [0] = "价格",
    [1] = "拥有",
}

UIAuctionItemPanel_StallPanel.mNameQuotaShow = {
    [0] = "价格",
    [1] = "拥有",
    [2] = "额度"
}

function UIAuctionItemPanel_StallPanel:GetNameShow()
    if Utility.IsAuctionDiamondQuotaOpen then
        return self.mNameQuotaShow
    else
        return self.mNameShow
    end
end

UIAuctionItemPanel_StallPanel.mCoin2Type = 1000023

--UIAuctionItemPanel_StallPanel.mCoinType = LuaEnumCoinType.YuanBao

---@param data customData
---@alias customData{BagItemInfo:bagV2.BagItemInfo,AuctionInfo:auctionV2.AuctionItemInfo,AuctionPanel:UIAuctionPanel}
function UIAuctionItemPanel_StallPanel:Init(data)
    self:RunBaseFunction("Init", data)
    self.mMaxNum = data.BagItemInfo.count
    self.mMinNum = 1
    self.num = self.mMinNum
    self.auctionPanel = data.AuctionPanel
    self.price = data.AuctionInfo.price.count
    self.mCoinType = data.AuctionInfo.price.itemId
    self:SuitPanel()
    self:SetNum()
end

--region 重写
---@return boolean 是否显示标题
function UIAuctionItemPanel_StallPanel:ShowTitleBtn()
    return false
end

---@return boolean 是否显示数目
function UIAuctionItemPanel_StallPanel:ShowNum()
    return true
end

---@return number 价格行数
function UIAuctionItemPanel_StallPanel:ShowCoin()
    local isShowQuota = Utility.IsAuctionDiamondQuotaOpen and Utility.IsDiamondItemId(self.mCoinType)
    local lineNum = isShowQuota and 3 or 2
    self.coin_UIGridContainer.MaxCount = lineNum
    self.mPriceLabel = {}
    for i = 0, lineNum - 1 do
        local go = self.coin_UIGridContainer.controlList[i]
        self:RefreshLineCoin(go, i)
    end
    return lineNum
end

---刷新价格显示
function UIAuctionItemPanel_StallPanel:RefreshPriceShow()
    local price = self.price * self.num
    self.mPriceLabel[0].text = price
    local playerHas = 0
    if self.mCoinType == LuaEnumCoinType.YuanBao then
        playerHas = self:GetPlayerHas()
    else
        playerHas = Utility.GetAuctionDiamondNum()
    end
    local color = playerHas >= price and luaEnumColorType.White or luaEnumColorType.Red
    self.mPriceLabel[1].text = color .. playerHas

    if Utility.IsAuctionDiamondQuotaOpen then
        if Utility.IsDiamondItemId(self.mCoinType) then
            if self:GetPlayerInfo() then
                local playerHas = self:GetPlayerInfo().Data.auctionDiamond
                local color = playerHas >= price and luaEnumColorType.White or luaEnumColorType.Red
                self.mPriceLabel[2].text = color .. playerHas
            end
        end
    end
end

---刷新每行货币信息
---@param go UnityEngine.GameObject 每行货币
---@param i number 从0开始的行数
function UIAuctionItemPanel_StallPanel:RefreshLineCoin(go, i)
    local name = CS.Utility_Lua.Get(go.transform, "Label", "UILabel")
    local priceIcon = CS.Utility_Lua.Get(go.transform, "Sprite", "UISprite")
    local priceLabel = CS.Utility_Lua.Get(go.transform, "gold", "UILabel")
    name.text = self:GetNameShow()[i]
    self.mPriceLabel[i] = priceLabel
    if i ~= 2 then
        priceIcon.spriteName = self:GetItemInfo(self.mCoinType).icon
    else
        priceIcon.spriteName = self:GetItemInfo(self.mCoin2Type).icon
    end
end

---@return TABLE.CFG_ITEMS 元宝交易行货币信息
function UIAuctionItemPanel_StallPanel:GetTradePriceItemInfo()
    if self.mCoinInfo == nil then
        ___, self.mCoinInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mCoinType)
    end
    return self.mCoinInfo
end

---@return boolean 是否显示滑条
function UIAuctionItemPanel_StallPanel:ShowSlider()
    return false
end

---@return boolean 是否是单个按钮
function UIAuctionItemPanel_StallPanel:IsSingleBtn()
    return true
end

---@return boolean 是否显示文本
function UIAuctionItemPanel_StallPanel:ShowLabel()
    return false
end

---点击购买按钮
function UIAuctionItemPanel_StallPanel:OnShelfClicked(go)
    if self.data and self.data.AuctionInfo then
        if self:IsCostEnough() then
            local lid = self.data.AuctionInfo.item.lid
            luaEventManager.DoCallback(LuaCEvent.StallBuyItem, self.num)
            networkRequest.ReqBoothBuy(uiStaticParameter.BoothLid, lid, self.num)
            self:ClosePanel()
        else
            if self.mCoinType == LuaEnumCoinType.YuanBao then
                self:ShowMoneyNotEnoughTips(go)
            else
                Utility.JumpRechargePanel(go)
            end
        end
    end
end

---显示道具不足提示
function UIAuctionItemPanel_StallPanel:ShowMoneyNotEnoughTips(go)
    local str = nil
    local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(78)
    if isfind then
        local itemName = self:GetTradePriceItemInfo().name
        str = string.format(data.content, itemName)
        --Utility.ShowPopoTips(go, str, 78, "UIAuctionItemPanel", { itemid = self.mCoinType })
        local EntranceType = LuaEnumRechargePointType.StallIngotNotEnoughToRewardGift
        if Utility.IsDiamondItemId(self.mCoinType) then
            EntranceType = LuaEnumRechargePointType.StallDiamondNotEnoughToRewardGift
        end
        Utility.ShowItemGetWay(self.mCoinType, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(100, 0), nil, EntranceType, "UIAuctionItemPanel")
    end
end

---判断自己道具是否足够购买
function UIAuctionItemPanel_StallPanel:IsCostEnough()
    local isEnough = false
    if self.price and self.num then
        local playerHas
        if self.mCoinType == LuaEnumCoinType.Diamond then
            playerHas = Utility.GetAuctionDiamondNum()
        else
            playerHas = self:GetPlayerHas()
        end

        if playerHas then
            isEnough = playerHas >= math.ceil(self.price * self.num)
        end
    end
    return isEnough
end

---刷新玩家拥有
function UIAuctionItemPanel_StallPanel:GetPlayerHas()
    return gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCurCoinAmount(self.mCoinType)
end

---刷新标题
function UIAuctionItemPanel_StallPanel:RefreshTitle()
    self.centerBtn_UILabel.text = "购买"
end

function UIAuctionItemPanel_StallPanel:SetNum()
    self.num_UIInput.value = self.num
    self:RefreshPriceShow()
end
--endregion

return UIAuctionItemPanel_StallPanel