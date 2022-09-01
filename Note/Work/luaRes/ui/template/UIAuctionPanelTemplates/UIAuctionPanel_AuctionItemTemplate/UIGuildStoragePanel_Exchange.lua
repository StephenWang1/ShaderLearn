---@class UIGuildStoragePanel_Exchange:UIAuctionPanel_AuctionItemTemplateBase 帮会仓库兑换模板
local UIGuildStoragePanel_Exchange = {}

setmetatable(UIGuildStoragePanel_Exchange, luaComponentTemplates.UIAuctionPanel_AuctionItemTemplateBase)

UIGuildStoragePanel_Exchange.mNameShow = {
    [1] = "积分",
    [2] = "拥有",
}

---积分
UIGuildStoragePanel_Exchange.mCoinType = 1000009

---@param data customData
---@alias customData{showList:table<number,bagV2.BagItemInfo>,AuctionInfo:auctionV2.AuctionItemInfo,AuctionPanel:UIAuctionPanel}
function UIGuildStoragePanel_Exchange:Init(data)
    self:RunBaseFunction("Init", data)
    ---@type table<number,bagV2.BagItemInfo>
    self.mShowList = data.showList
    if self.mShowList.Count > 0 then

        ---@type bagV2.BagItemInfo
        self.mBagItemInfo = self.mShowList[0]
        ---@type TABLE.CFG_ITEMS
        self.mItemInfo = self.mBagItemInfo.ItemTABLE
    end

    --价格
    self.price = self.mItemInfo.gongXian
    --数目
    local mSellNum = self.mShowList.Count

    self.mMaxNum = mSellNum;
    if self.mMaxNum == 0 or self.mMaxNum == nil then
        self.mMaxNum = 1
    end
    if self.mBagItemInfo.count > 1 then
        self.mMaxNum = self.mBagItemInfo.count;
    end

    self.mMinNum = 1
    self.num = self.mMinNum
    --刷新
    self:SuitPanel()
    self:SetNum()
end

--region 用于重写
---@return number 价格行数
function UIGuildStoragePanel_Exchange:ShowCoin()
    local lineNum = 2
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
function UIGuildStoragePanel_Exchange:RefreshLineCoin(go, i)
    local name = CS.Utility_Lua.Get(go.transform, "Label", "UILabel")
    local priceIcon = CS.Utility_Lua.Get(go.transform, "Sprite", "UISprite")
    local priceLabel = CS.Utility_Lua.Get(go.transform, "gold", "UILabel")
    name.text = self.mNameShow[i + 1]
    self.mPriceLabel[i] = priceLabel
    local itemInfo = self:GetItemInfo(self.mCoinType)
    if itemInfo then
        priceIcon.spriteName = itemInfo.icon
    end
end

---用于数目变化后的处理
function UIGuildStoragePanel_Exchange:SetNum()
    self.num_UIInput.value = self.num
    self:RefreshPriceShow()
end

---@return CSUnionInfoV2
function UIGuildStoragePanel_Exchange:GetUnionInfoV2()
    if self.mUnionInfoV2 == nil and self:GetPlayerInfo() then
        self.mUnionInfoV2 = self:GetPlayerInfo().UnionInfoV2
    end
    return self.mUnionInfoV2
end

---刷新价格显示
function UIGuildStoragePanel_Exchange:RefreshPriceShow()
    local price = self.price * self.num
    self.mPriceLabel[0].text = price
    if self:GetUnionInfoV2() then
        local playerHas = self:GetUnionInfoV2().UnionScore
        local color = playerHas >= price and luaEnumColorType.White or luaEnumColorType.Red
        self.mPriceLabel[1].text = color .. playerHas
    end
end

---点击上架按钮
function UIGuildStoragePanel_Exchange:OnShelfClicked(go)
    if self:IsExchangeEnough() then
        ---@type System.Collections.Generic.List1T
        local list = {}
        for i = 0, self.num - 1 do
            if i < self.mShowList.Count then
                local data = self.mShowList[i].lid
                table.insert(list, data)
            end
        end
        local itemId = self.mItemInfo.id
        networkRequest.ReqConversionEquip(itemId, self.num, list)
        uimanager:ClosePanel("UIPetInfoPanel")
        uimanager:ClosePanel("UIItemInfoPanel")
        self:ClosePanel()
    else
        Utility.ShowPopoTips(go, nil, 309)
    end
end

---兑换道具积分是否足够
function UIGuildStoragePanel_Exchange:IsExchangeEnough()
    local cost = self.price * self.num
    if self:GetUnionInfoV2() then
        local playerHas = self:GetUnionInfoV2().UnionScore
        return cost <= playerHas
    end
    return false
end

---刷新标题
function UIGuildStoragePanel_Exchange:RefreshTitle()
    self.centerBtn_UILabel.text = "兑换"
end
--endregion


return UIGuildStoragePanel_Exchange