---@class UISaleOrePanel_SaleItemTemplate:UIAuctionPanel_AuctionItemTemplateBase npc商店回购模板
local UISaleOrePanel_SaleItemTemplate = {}
setmetatable(UISaleOrePanel_SaleItemTemplate, luaComponentTemplates.UIAuctionPanel_AuctionItemTemplateBase)

UISaleOrePanel_SaleItemTemplate.mNameShow = {
    [0] = "单      价",
    [1] = "总      价"
}
--region 重写

---@param data customData
---@alias customData{Template:table,BagItemInfo:bagV2.BagItemInfo,priceDate:npcstoreV2.NpcStoreGrid,buyCallBack:function,isOnlyBuyOne:boolean}
function UISaleOrePanel_SaleItemTemplate:Init(data)
    if data then
        self.isShowAddAndReduceBtn = not data.isOnlyBuyOne
        self:RunBaseFunction("Init")
        self.num = 1
        self.mMinNum = 1
        self.mMaxNum = data.MaxNum == nil and 1 or data.MaxNum
        self.mCoinType = data.priceDate.npcStoreItem.priceItemId
        self.price = data.priceDate.npcStoreItem.priceCount
        self.buyCallBack = data.BuyCallBack
        self:SuitPanel()
        self:SetNum()
    end
end

---@return boolean 是否显示数目
function UISaleOrePanel_SaleItemTemplate:ShowNum()
    self.add_GameObject:SetActive(self:ShowAddBtn())
    self.reduce_GameObject:SetActive(self:ShowReduceBtn())
    return true
end

---@return boolean 是否显示加号
function UISaleOrePanel_SaleItemTemplate:ShowAddBtn()
    return self.isShowAddAndReduceBtn
end

---@return boolean 是否显示减号
function UISaleOrePanel_SaleItemTemplate:ShowReduceBtn()
    return self.isShowAddAndReduceBtn
end

---点击购买按钮
function UISaleOrePanel_SaleItemTemplate:OnShelfClicked(go)
    if self.buyCallBack ~= nil then
        self.buyCallBack(go, self.num)
    end
end

---刷新标题
function UISaleOrePanel_SaleItemTemplate:RefreshTitle()
    self.centerBtn_UILabel.text = "回 购"
end

--endregion

function UISaleOrePanel_SaleItemTemplate:SetNum()
    self.num_UIInput.value = self.num
    self:RefreshPriceShow()
end

---@return number 价格行数
function UISaleOrePanel_SaleItemTemplate:ShowCoin()
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
function UISaleOrePanel_SaleItemTemplate:RefreshPriceShow()
    self.mPriceLabel[0].text = self.price
    self.mPriceLabel[1].text = self.price * self.num
end

---刷新每行货币信息
---@param go UnityEngine.GameObject 每行货币
---@param i number 从0开始的行数
function UISaleOrePanel_SaleItemTemplate:RefreshLineCoin(go, i)
    local name = CS.Utility_Lua.Get(go.transform, "Label", "UILabel")
    local priceIcon = CS.Utility_Lua.Get(go.transform, "Sprite", "UISprite")
    local priceLabel = CS.Utility_Lua.Get(go.transform, "gold", "UILabel")
    name.text = self.mNameShow[i]
    self.mPriceLabel[i] = priceLabel
    if self:GetPriceItemInfo() ~= nil then
        priceIcon.spriteName = self:GetPriceItemInfo().icon
    end
end

---@return TABLE.CFG_ITEMS 货币信息
function UISaleOrePanel_SaleItemTemplate:GetPriceItemInfo()
    if self.mCoinInfo == nil then
        ___, self.mCoinInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mCoinType)
    end
    return self.mCoinInfo
end

---刷新玩家拥有
function UISaleOrePanel_SaleItemTemplate:GetPlayerHas()
    local selfCost = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(self.mCoinType)
    return selfCost
end

return UISaleOrePanel_SaleItemTemplate