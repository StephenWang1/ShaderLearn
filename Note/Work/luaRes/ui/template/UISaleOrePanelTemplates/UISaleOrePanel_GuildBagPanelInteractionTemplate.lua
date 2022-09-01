---@class UISaleOrePanel_GuildBagPanelInteractionTemplate:UIAuctionPanel_AuctionItemTemplateBase 行会捐献
local UISaleOrePanel_GuildBagPanelInteractionTemplate = {}

setmetatable(UISaleOrePanel_GuildBagPanelInteractionTemplate, luaComponentTemplates.UIAuctionPanel_AuctionItemTemplateBase)

---积分
UISaleOrePanel_GuildBagPanelInteractionTemplate.mCoinType = 1000009

UISaleOrePanel_GuildBagPanelInteractionTemplate.mNameShow = {
    [0] = "积分",
    [1] = "拥有"
}

---@return CSUnionInfoV2
function UISaleOrePanel_GuildBagPanelInteractionTemplate:GetUnionInfoV2()
    if self.mUnionInfoV2 == nil and self:GetPlayerInfo() then
        self.mUnionInfoV2 = self:GetPlayerInfo().UnionInfoV2
    end
    return self.mUnionInfoV2
end


--region 重写

---@param data customData
function UISaleOrePanel_GuildBagPanelInteractionTemplate:Init(data)
    if data then
        self:RunBaseFunction("Init")
        self.num = 1
        self.mMinNum = 1
        self.mMaxNum = data.MaxNum == nil and 1 or data.MaxNum
        --self.mCoinType = data.priceDate.id
        self.price = data.singlePrice
        self.buyCallBack = data.BuyCallBack
        self.isShowAddAndReduceBtn = ternary(data.isShowAddAndReduceBtn == nil, true, data.isShowAddAndReduceBtn)
        self:SuitPanel()
        self:SetNum()
    end
end

---@return boolean 是否显示数目
function UISaleOrePanel_GuildBagPanelInteractionTemplate:ShowNum()
    self.add_GameObject:SetActive(self:ShowAddBtn())
    self.reduce_GameObject:SetActive(self:ShowReduceBtn())
    return true
end

---@return boolean 是否显示加号
function UISaleOrePanel_GuildBagPanelInteractionTemplate:ShowAddBtn()
    return self.isShowAddAndReduceBtn
end

---@return boolean 是否显示减号
function UISaleOrePanel_GuildBagPanelInteractionTemplate:ShowReduceBtn()
    return self.isShowAddAndReduceBtn
end

---点击购买按钮
function UISaleOrePanel_GuildBagPanelInteractionTemplate:OnShelfClicked(go)
    if self.buyCallBack ~= nil then
        self.buyCallBack(go, self.num)
    end
end

---刷新标题
function UISaleOrePanel_GuildBagPanelInteractionTemplate:RefreshTitle()
    self.centerBtn_UILabel.text = "捐献"
end

--endregion

function UISaleOrePanel_GuildBagPanelInteractionTemplate:SetNum()
    self.num_UIInput.value = self.num
    self:RefreshPriceShow()
end

---@return number 价格行数
function UISaleOrePanel_GuildBagPanelInteractionTemplate:ShowCoin()
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
function UISaleOrePanel_GuildBagPanelInteractionTemplate:RefreshPriceShow()
    self.mPriceLabel[0].text = self.price * self.num
    local playerHas = self:GetUnionInfoV2().UnionScore
    self.mPriceLabel[1].text = playerHas
end

---刷新每行货币信息
---@param go UnityEngine.GameObject 每行货币
---@param i number 从0开始的行数
function UISaleOrePanel_GuildBagPanelInteractionTemplate:RefreshLineCoin(go, i)
    local name = CS.Utility_Lua.Get(go.transform, "Label", "UILabel")
    local priceIcon = CS.Utility_Lua.Get(go.transform, "Sprite", "UISprite")
    local priceLabel = CS.Utility_Lua.Get(go.transform, "gold", "UILabel")
    name.text = self.mNameShow[i]
    self.mPriceLabel[i] = priceLabel
    local itemInfo = self:GetItemInfo(self.mCoinType)
    if itemInfo then
        priceIcon.spriteName = itemInfo.icon
    end
end

---@return TABLE.CFG_ITEMS 货币信息
function UISaleOrePanel_GuildBagPanelInteractionTemplate:GetPriceItemInfo()
    if self.mCoinInfo == nil then
        ___, self.mCoinInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mCoinType)
    end
    return self.mCoinInfo
end

---刷新玩家拥有
function UISaleOrePanel_GuildBagPanelInteractionTemplate:GetPlayerHas()
    local selfCost = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(self.mCoinType)
    return selfCost
end

return UISaleOrePanel_GuildBagPanelInteractionTemplate