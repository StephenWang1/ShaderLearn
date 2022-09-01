---@class UICommerceShopPanel_Conversion:UIAuctionPanel_AuctionItemTemplateBase 商会积分兑换m面板
local UICommerceShopPanel_Conversion = {}

setmetatable(UICommerceShopPanel_Conversion, luaComponentTemplates.UIAuctionPanel_AuctionItemTemplateBase)

function UICommerceShopPanel_Conversion:Init(data)
    self:RunBaseFunction("Init", data)

    self.mMoneyCount = data.mMoneyCount
    self.mMoneyItemID = data.moneyType
    self.price = data.price
    self.otherCurrency = data.otherCurrency
    self.storeId = data.storeId
    self.storeTable = data.storeTable
    self.numChange = 1
    self.isCanBuy = true
    self.itemTable=data.itemTable

    self.showData = self:SetShowData()
    --刷新
    self:SuitPanel()
    self:SetNum()
    --self:RefreshPos(self.itemTable)
end

function UICommerceShopPanel_Conversion:ShowNum()
    return true
end

function UICommerceShopPanel_Conversion:SetShowData()
    local data = {}
    if self.otherCurrency ~= nil then
        for i = 1, self.otherCurrency.Count do
            data[i] = {
                itemId = self.otherCurrency[i - 1][0],
                price = self.otherCurrency[i - 1][1],
                name = "道具",
                iconName = CS.Cfg_ItemsTableManager.Instance:GetIconName(self.otherCurrency[i - 1][0]),
            }
        end
        data[self.otherCurrency.Count + 1] = {
            itemId = self.mMoneyItemID,
            price = self.price,
            name = "价格",
            iconName = CS.Cfg_ItemsTableManager.Instance:GetIconName(self.mMoneyItemID),
        }
        data[self.otherCurrency.Count + 2] = {
            itemId = self.mMoneyItemID,
            price = self.price,
            name = "拥有",
            iconName = CS.Cfg_ItemsTableManager.Instance:GetIconName(self.mMoneyItemID),
        }
    else
        data[1] = {
            itemId = self.mMoneyItemID,
            price = self.price,
            name = "价格",
            iconName = CS.Cfg_ItemsTableManager.Instance:GetIconName(self.mMoneyItemID),
        }
        data[2] = {
            itemId = self.mMoneyItemID,
            price = self.price,
            name = "拥有",
            iconName = CS.Cfg_ItemsTableManager.Instance:GetIconName(self.mMoneyItemID),
        }
    end
    return data

end

--region 用于重写
---@return number 价格行数
function UICommerceShopPanel_Conversion:ShowCoin()
    self.coin_UIGridContainer.MaxCount = #self.showData
    self.mPriceLabel = {}
    for i = 1, #self.showData do
        local go = self.coin_UIGridContainer.controlList[i - 1]
        self:RefreshLineCoin(go, i, self.showData[i])
    end
    return #self.showData
end

---刷新每行货币信息
---@param go UnityEngine.GameObject 每行货币
---@param  显示数据表
function UICommerceShopPanel_Conversion:RefreshLineCoin(go, i, data)
    local name = CS.Utility_Lua.Get(go.transform, "Label", "UILabel")
    local priceIcon = CS.Utility_Lua.Get(go.transform, "Sprite", "UISprite")
    local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
    local priceLabel = CS.Utility_Lua.Get(go.transform, "gold", "UILabel")
    name.text = data.name
    priceIcon.spriteName = data.iconName
    icon.spriteName = data.iconName
    icon.gameObject:SetActive(true)
    priceIcon.gameObject:SetActive(false)
    self.mPriceLabel[i] = priceLabel
end

---用于数目变化后的处理
function UICommerceShopPanel_Conversion:SetNum()
    if self.numChange <= 1 then
        self.num_UIInput.value = 1
    else
        self.num_UIInput.value = self.numChange
    end

    self:RefreshPriceShow()
end
---点击数目增加
function UICommerceShopPanel_Conversion:OnAddBtnClicked(go)
    -- self.numChange = self.numChange + 1
    -- self:SetNum()
end

---点击减少按钮
---交易行的逻辑，减少到最小值继续减少变成最大值，要修改可以重写此方法，一定要调用SetNum刷新
function UICommerceShopPanel_Conversion:OnReduceBtnClicked(go)
    -- self.numChange = self.numChange - 1
    -- if self.numChange <= 1 then
    --     self.numChange = 1
    -- end
    -- self:SetNum()
end


---刷新价格显示
function UICommerceShopPanel_Conversion:RefreshPriceShow()
    self.isCanBuy = true
    local Length = #self.mPriceLabel
    for i = 1, Length - 1 do
        local count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(self.showData[i].itemId)
        local color = ""
        if count < self.showData[i].price *self.numChange and self.showData[i].name=="道具" then
            color = "[e85038]"
            self.isCanBuy = false
        end
        self.mPriceLabel[i].text = color .. count
    end
    local color = ""
    local number = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(self.mMoneyItemID);
    self.mPriceLabel[Length - 1].text = self.showData[Length - 1].price*self.numChange
    if self.showData[Length - 1].price*self.numChange > number then
        color = "[e85038]"
        self.isCanBuy = false
    end
    self.mPriceLabel[Length].text =color..number;
end

---点击兑换按钮
function UICommerceShopPanel_Conversion:OnShelfClicked(go)
    if self.isCanBuy then
        networkRequest.ReqBuyItem(self.storeId, self.numChange, self.storeTable.itemId, 0);
        uimanager:ClosePanel('UIAuctionItemPanel')
        uimanager:ClosePanel('UIItemInfoPanel')
    else
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Describe] = "所需物品不足";
        TipsInfo[LuaEnumTipConfigType.Parent] = go.transform;
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 68;
        uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
    end
end


---刷新标题
function UICommerceShopPanel_Conversion:RefreshTitle()
    self.centerBtn_UILabel.text = "兑换"
end

-- function  UICommerceShopPanel_Conversion:RefreshPos(itemTable)
--     uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable, isCloseCollider = true, refreshEndFunc = function(panel)
--         local itemWidth = panel:GetBackground_UISprite().width/2
--         local itemHight = panel:GetBackground_UISprite().height / 2+30
--         panel.go.transform.localPosition = CS.UnityEngine.Vector3(-itemWidth, 0, 0)
--         self:SetStartPoision(itemWidth,itemHight)
--        -- self:SetAlpha(1)
--     end, showRight = false })
    
-- end

-- function UICommerceShopPanel_Conversion:SetStartPoision(itemWidth,itemHight)
--     if (not CS.StaticUtility.IsNull(self.NumBg_UISprite)) then
--         local width =self.NumBg_UISprite.width / 2+76;
--         local height = itemHight - self.NumBg_UISprite.height / 2 -137;
--         self.go.transform.localPosition = CS.UnityEngine.Vector3(width, height, 0)
--     end
-- end


--endregion
return UICommerceShopPanel_Conversion