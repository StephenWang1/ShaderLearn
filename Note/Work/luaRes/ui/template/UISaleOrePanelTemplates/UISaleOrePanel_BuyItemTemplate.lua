---@class UISaleOrePanel_BuyItemTemplate:UIAuctionPanel_AuctionItemTemplateBase npc商店购买模板
local UISaleOrePanel_BuyItemTemplate = {}
setmetatable(UISaleOrePanel_BuyItemTemplate, luaComponentTemplates.UIAuctionPanel_AuctionItemTemplateBase)

UISaleOrePanel_BuyItemTemplate.mNameShow = {
    [0] = "价      格",
    [1] = "拥      有"
}
--region 重写

---@param data customData
---@alias customData{Template:table,BagItemInfo:bagV2.BagItemInfo,priceDate:npcstoreV2.NpcStoreGrid,buyCallBack:function,isOnlyBuyOne:boolean}
function UISaleOrePanel_BuyItemTemplate:Init(data)
    if data then
        self.isOnlyBuyOne = data.isOnlyBuyOne
        self:RunBaseFunction("Init")
        self.num = data.curNum == nil or data.curNum == 0 and 1 or data.curNum
        self.mMinNum = 1
        self.mMaxNum = data.isOnlyBuyOne and 1 or data.priceDate.count
        self.mCoinType = data.priceDate.npcStoreItem.priceItemId
        self.price = data.priceDate.npcStoreItem.priceCount
        self.buyCallBack = data.BuyCallBack
        self:SuitPanel()
        self:SetNum()
    end
end

---点击减少按钮
---逻辑，减少到最小值继续减少变成可购买最大值
function UISaleOrePanel_BuyItemTemplate:OnReduceBtnClicked(go)
    if self.isOnlyBuyOne then
        Utility.ShowPopoTips(go, nil, 285, "UIAuctionItemPanel")
        return
    end

    if self.num then
        if self.num - 1 >= self.mMinNum then
            self.num = self.num - 1
        else
            self.num = self:GetCanBuyCount()
        end
        self:SetNum()
    end
end

---点击数目增加
function UISaleOrePanel_BuyItemTemplate:OnAddBtnClicked(go)
    if self.isOnlyBuyOne then
        Utility.ShowPopoTips(go, nil, 285, "UIAuctionItemPanel")
        return
    end
    if self.num and self.num + 1 <= self.mMaxNum then
        self.num = self.num + 1
        self:SetNum()
    end
end

---@return boolean 是否显示数目
function UISaleOrePanel_BuyItemTemplate:ShowNum()
    self.add_GameObject:SetActive(self:ShowAddBtn())
    self.reduce_GameObject:SetActive(self:ShowReduceBtn())
    return true
end

---@return boolean 是否显示加号
function UISaleOrePanel_BuyItemTemplate:ShowAddBtn()
    return true
    -- self.isOnlyBuyOne
end

---@return boolean 是否显示减号
function UISaleOrePanel_BuyItemTemplate:ShowReduceBtn()
    return true
    --self.isOnlyBuyOne
end

---点击购买按钮
function UISaleOrePanel_BuyItemTemplate:OnShelfClicked(go)
    if self.buyCallBack ~= nil then
        self.buyCallBack(go, self.num)
    end
end

---刷新标题
function UISaleOrePanel_BuyItemTemplate:RefreshTitle()
    self.centerBtn_UILabel.text = "购 买"
end

--endregion

function UISaleOrePanel_BuyItemTemplate:SetNum()
    self.num_UIInput.value = self.num
    self:RefreshPriceShow()
end

---@return number 价格行数
function UISaleOrePanel_BuyItemTemplate:ShowCoin()
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
function UISaleOrePanel_BuyItemTemplate:RefreshPriceShow()
    local needNum = self.price * self.num
    self.mPriceLabel[0].text = self.price * self.num
    local num = self:GetPlayerHas()
    local show = num
    if num == nil then
        show = 0
    end
    self.mPriceLabel[1].text = needNum > show and luaEnumColorType.Red .. show or show
end

---刷新每行货币信息
---@param go UnityEngine.GameObject 每行货币
---@param i number 从0开始的行数
function UISaleOrePanel_BuyItemTemplate:RefreshLineCoin(go, i)
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
function UISaleOrePanel_BuyItemTemplate:GetPriceItemInfo()
    if self.mCoinInfo == nil then
        ___, self.mCoinInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mCoinType)
    end
    return self.mCoinInfo
end

---刷新玩家拥有
function UISaleOrePanel_BuyItemTemplate:GetPlayerHas()
    local selfCost = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(self.mCoinType)
    return selfCost
end

---获取可买最大值
function UISaleOrePanel_BuyItemTemplate:GetCanBuyCount()
    if self.isOnlyBuyOne then
        return 1
    end
    local curMaxCoin = self:GetPlayerHas()
    local count = math.floor(curMaxCoin / self.price)
    return count == 0 and 1 or count > self.mMaxNum and self.mMaxNum or count
end

return UISaleOrePanel_BuyItemTemplate