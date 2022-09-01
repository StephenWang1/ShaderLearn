---@class UIAuctionPanel_AuctionItem_AuctionBid:UIAuctionPanel_AuctionItemTemplateBase 钻石交易行竞价模板
local UIAuctionPanel_AuctionItem_AuctionBid = {}

setmetatable(UIAuctionPanel_AuctionItem_AuctionBid, luaComponentTemplates.UIAuctionPanel_AuctionItemTemplateBase)

UIAuctionPanel_AuctionItem_AuctionBid.mNameShow = {
    [0] = "价格",
    [1] = "拥有",
}

UIAuctionPanel_AuctionItem_AuctionBid.mQuotaNameShow = {
    [0] = "价格",
    [1] = "拥有",
    [2] = "额度",
}

function UIAuctionPanel_AuctionItem_AuctionBid:GetNameShow()
    if Utility.IsAuctionDiamondQuotaOpen then
        return self.mQuotaNameShow
    else
        return self.mNameShow
    end
end

function UIAuctionPanel_AuctionItem_AuctionBid:GetNameNum()
    if Utility.IsAuctionDiamondQuotaOpen then
        return 3
    else
        return 2
    end
end

UIAuctionPanel_AuctionItem_AuctionBid.mCoinType = LuaEnumCoinType.Diamond

UIAuctionPanel_AuctionItem_AuctionBid.mCoin2Type = 1000023

function UIAuctionPanel_AuctionItem_AuctionBid:Init(data)
    self:RunBaseFunction("Init", data)
    self.AuctionInfo = data.AuctionInfo
    self.mMaxNum = data.BagItemInfo.count
    self.mMinNum = 1
    self.num = self.mMaxNum
    self.price = self.AuctionInfo.price.count
    self:SuitPanel()
    self:SetNum()
end

--region 用于重写
---不允许修改数目
function UIAuctionPanel_AuctionItem_AuctionBid:OnReduceBtnClicked(go)
end

---不允许修改数目
function UIAuctionPanel_AuctionItem_AuctionBid:OnAddBtnClicked(go)
end

---@return boolean 是否显示标题
function UIAuctionPanel_AuctionItem_AuctionBid:ShowTitleBtn()
    return false
end

---@return boolean 是否显示数目
function UIAuctionPanel_AuctionItem_AuctionBid:ShowNum()
    return true
end

---@return number 价格行数
function UIAuctionPanel_AuctionItem_AuctionBid:ShowCoin()
    local lineNum = self:GetNameNum()
    self.coin_UIGridContainer.MaxCount = lineNum
    self.mPriceLabel = {}
    for i = 0, lineNum - 1 do
        local go = self.coin_UIGridContainer.controlList[i]
        self:RefreshLineCoin(go, i)
    end
    return lineNum
end

---刷新每行货币信息
---@param go UnityEngine.GameObject 每行货币
---@param i number 从0开始的行数
---@param lineNum  number 总行数
function UIAuctionPanel_AuctionItem_AuctionBid:RefreshLineCoin(go, i)
    local name = CS.Utility_Lua.Get(go.transform, "Label", "UILabel")
    local priceIcon = CS.Utility_Lua.Get(go.transform, "Sprite", "UISprite")
    name.text = self:GetNameShow()[i]
    local priceLabel = CS.Utility_Lua.Get(go.transform, "gold", "UILabel")
    self.mPriceLabel[i] = priceLabel
    if i ~= 2 then
        priceIcon.spriteName = self:GetItemInfo(self.mCoinType).icon
    else
        priceIcon.spriteName = self:GetItemInfo(self.mCoin2Type).icon
    end
end

---@return boolean 是否显示滑条
function UIAuctionPanel_AuctionItem_AuctionBid:ShowSlider()
    return false
end

---@return boolean 是否是单个按钮
function UIAuctionPanel_AuctionItem_AuctionBid:IsSingleBtn()
    return true
end

---@return boolean 是否显示文本
function UIAuctionPanel_AuctionItem_AuctionBid:ShowLabel()
    return false
end

---用于数目变化后的处理
function UIAuctionPanel_AuctionItem_AuctionBid:SetNum()
    self.num_UIInput.value = self.num
    self:RefreshPriceShow()
end

---刷新价格显示
function UIAuctionPanel_AuctionItem_AuctionBid:RefreshPriceShow()
    local price = self:GetPrice()
    self.mPriceLabel[0].text = price
    if self:GetBagInfoV2() then
        local playerHas = Utility.GetAuctionDiamondNum()
        local color = playerHas >= price and luaEnumColorType.White or luaEnumColorType.Red
        self.mPriceLabel[1].text = color .. playerHas
    end
    if Utility.IsAuctionDiamondQuotaOpen and self.mPriceLabel[2] then
        if self:GetPlayerInfo() then
            local playerHas = self:GetPlayerInfo().Data.auctionDiamond
            local color = playerHas > price and luaEnumColorType.White or luaEnumColorType.Red
            self.mPriceLabel[2].text = color .. playerHas
        end
    end
end

---点击竞价按钮
function UIAuctionPanel_AuctionItem_AuctionBid:OnShelfClicked(go)
    if (Utility.IsPushSpecialGift()) then
        uimanager:CreatePanel("UIRechargeGiftPanel")
        return
    end
    local price = self:GetPrice()
    if self:IsCostEnough(price) then
        networkRequest.ReqAuctionLot(self.AuctionInfo.item.lid, Utility.EnumToInt(CS.auctionV2.AuctionType.BID))
        self:ClosePanel()
    else
        self:ShowMoneyNotEnoughTips(go)
    end
end

---获得竞价价格
function UIAuctionPanel_AuctionItem_AuctionBid:GetPrice()
    return Utility.GetBidPrice(self.AuctionInfo, self.num)
end

---显示道具不足提示
function UIAuctionPanel_AuctionItem_AuctionBid:ShowMoneyNotEnoughTips(go)
    Utility.JumpRechargePanel(go, LuaEnumRechargePointEntranceType.AuctionDiamondNotEnough)
end

function UIAuctionPanel_AuctionItem_AuctionBid:GetPromptDes()
    if self.mDes == nil then
        local res, info = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(78)
        if res then
            self.mDes = string.format(info.content, self:GetItemInfo(self.mCoinType).name)
        end
    end
    return self.mDes
end

---判断自己道具是否足够购买
function UIAuctionPanel_AuctionItem_AuctionBid:IsCostEnough(price)
    local isEnough = false
    if self.AuctionInfo and self.AuctionInfo.price then
        local selfCost = self:GetBagInfoV2():GetAuctionDiamondNum()
        if Utility.IsAuctionDiamondQuotaOpen then
            local diamond = self:GetPlayerInfo().Data.auctionDiamond
            isEnough = price <= math.ceil(selfCost) and price <= diamond
        else
            isEnough = price <= math.ceil(selfCost)
        end
    end
    return isEnough
end

---刷新标题
function UIAuctionPanel_AuctionItem_AuctionBid:RefreshTitle()
    self.centerBtn_UILabel.text = "竞价"
end
--endregion

return UIAuctionPanel_AuctionItem_AuctionBid