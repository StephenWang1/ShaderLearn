---个人求购列表格子模板
---@class UIAuctionPanel_SelfBuyingListGridTemplate
local UIAuctionPanel_SelfBuyingListGridTemplate = {}

function UIAuctionPanel_SelfBuyingListGridTemplate:Init(panel)
    ---@type UIAuctionPanel_SelfBuyingListTemplate
    self.mRootPanel = panel
    self:InitComponent()
    self:BindEvents()
end

function UIAuctionPanel_SelfBuyingListGridTemplate:InitComponent()
    --region Item
    self.Item_GameObject = self:Get("Item", "GameObject")
    self.Strengthen_UILabel = self:Get("Item/strengthen", "UILabel")
    self.ItemIcon_UISprite = self:Get("Item/icon", "UISprite")
    self.ItemCount_UILabel = self:Get("Item/count", "UILabel")
    self.ItemName_UILabel = self:Get("Item/name", "UILabel")
    --endregion

    --regionPrice
    self.PriceText_UILabel = self:Get("Item/AuctionPrice/icon/price", "UILabel")
    self.PriceSprite_UISprite = self:Get("Item/AuctionPrice/icon", "UISprite")
    self.des_UILabel = self:Get("Item/AuctionPrice/des", "UILabel")
    --endregion
    ---下架
    self.Downput_GameObject = self:Get("Item/Obtained", "GameObject")
    ---时间
    ---@type UICountdownLabel
    self.TimeText_UICountDownLabel = self:Get("Item/des", "UICountdownLabel")
    self.TimeText_UILabel = self:Get("Item/des", "UILabel")

    ---审核中文字
    self.mTimeDelayShow = self:Get("Item/desTime", "UILabel")

    ---添加
    self.Add_GameObject = self:Get("add", "GameObject")
    ---背景
    self.BackFrame_UISprite = self:Get("backFrame", "UISprite")
end

function UIAuctionPanel_SelfBuyingListGridTemplate:BindEvents()
    CS.UIEventListener.Get(self.Downput_GameObject).onClick = function()
        self:OnRemoveClicked()
    end
end

function UIAuctionPanel_SelfBuyingListGridTemplate:RefreshUI(auctionInfo)
    ---@type boolean 是否过期
    self.isExpire = false
    if CS.StaticUtility.IsNull(self.Add_GameObject) == false then
        self.Add_GameObject:SetActive(auctionInfo == nil)
    end
    if CS.StaticUtility.IsNull(self.Item_GameObject) == false then
        self.Item_GameObject:SetActive(auctionInfo ~= nil)
    end
    if auctionInfo then
        ---@type auctionV2.AuctionItemInfo
        self.AuctionInfo = auctionInfo
        self:RefreshInfo()
        self:RefreshItem()
        self:RefreshPrice()
        self:RefreshTime()
    end
    self:RefreshStrengthenInfo()
end

---刷新数据
---@param self.AuctionInfo.itemCount 求购总数量
---@param  self.AuctionInfo.price.count 求购单价
---@param self.AuctionInfo.price.itemId 求购道具Id
---@param self.AuctionInfo.auctionItemBuyProductsInfo.count 当前求购数量
function UIAuctionPanel_SelfBuyingListGridTemplate:RefreshInfo()
    if self.AuctionInfo then
        ___, self.ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.AuctionInfo.price.itemId)
        self.BuyingInfo = self.AuctionInfo.auctionItemBuyProductsInfo
        self.BagItemInfo = self.AuctionInfo.item
        if self.BagItemInfo then
            ___, self.PriceItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.BagItemInfo.itemId)
        end
    end
end

---刷新Item显示
function UIAuctionPanel_SelfBuyingListGridTemplate:RefreshItem()
    if self.ItemInfo then
        self.ItemIcon_UISprite.spriteName = self.ItemInfo.icon
        self.ItemName_UILabel.text = self.ItemInfo.name
    else
        if self.AuctionInfo and self.AuctionInfo.auctionItemBuyProductsInfo then
            local name = self.AuctionInfo.auctionItemBuyProductsInfo.name
            self.ItemName_UILabel.text = name
            local icon = CS.Cfg_GlobalTableManager.Instance:GetSpecialNameIcon(name)
            self.ItemIcon_UISprite.spriteName = icon
        end
    end
    if self.BuyingInfo then
        self.ItemCount_UILabel.text = self.BuyingInfo.count
    end
end

---刷新价格显示
function UIAuctionPanel_SelfBuyingListGridTemplate:RefreshPrice()
    if self.PriceItemInfo and self.BuyingInfo and self.AuctionInfo then
        self.PriceSprite_UISprite.spriteName = self.PriceItemInfo.icon
        self.PriceText_UILabel.text = self.AuctionInfo.price.count
        local totalNeed = self.AuctionInfo.itemCount
        local current = self.AuctionInfo.auctionItemBuyProductsInfo.count
        local need = totalNeed - current
        self.des_UILabel.text = "(" .. need .. "/" .. totalNeed .. ")"
    end
end

---刷新时间显示
function UIAuctionPanel_SelfBuyingListGridTemplate:RefreshTime()
    self.TimeText_UICountDownLabel:StopCountDown()
    local timeDelay = self.AuctionInfo.delayTime
    if timeDelay and timeDelay ~= 0 and CS.CSAuctionInfoV2.NotOverTime(timeDelay) then
        --审核时间
        self.TimeText_UICountDownLabel.gameObject:SetActive(false)
        self.mTimeDelayShow.text = "[878787]审核中"
        self.mTimeDelayShow.gameObject:SetActive(true)
        self.TimeText_UICountDownLabel:StartCountDown(nil, 5, timeDelay, nil, nil, nil, function()
            self:OverDelayTime()
        end)
    else
        self:OverDelayTime()
    end
end

---审核结束
function UIAuctionPanel_SelfBuyingListGridTemplate:OverDelayTime()
    local time = self.AuctionInfo.overdueTime
    self.TimeText_UICountDownLabel.gameObject:SetActive(true)
    self.mTimeDelayShow.gameObject:SetActive(false)
    --过期时间
    if time and time ~= 0 and CS.CSAuctionInfoV2.NotOverTime(time) then
        self.TimeText_UICountDownLabel:StartCountDown(nil, 5, time, nil, nil, nil, function()
            self:OverTime()
        end)
    else
        self:OverTime()
    end
end

---过期
function UIAuctionPanel_SelfBuyingListGridTemplate:OverTime()
    self.TimeText_UILabel.text = "已过期"
    self.isExpire = true
end

---点击下架
function UIAuctionPanel_SelfBuyingListGridTemplate:OnRemoveClicked()
    if self.AuctionInfo and self.AuctionInfo.item and self.AuctionInfo.auctionItemBuyProductsInfo then
        if self.isExpire then
            local condition = CS.auctionV2.BuyProductsCondition()
            condition.itemId = self.AuctionInfo.price.itemId
            condition.count = self.AuctionInfo.auctionItemBuyProductsInfo.count
            condition.minLevel = self.AuctionInfo.auctionItemBuyProductsInfo.minLevel
            condition.maxLevel = self.AuctionInfo.auctionItemBuyProductsInfo.maxLevel
            condition.currency = LuaEnumCoinType.YuanBao
            condition.sex = self.AuctionInfo.auctionItemBuyProductsInfo.sex
            condition.career = self.AuctionInfo.auctionItemBuyProductsInfo.carreer
            local conditionInfo = self.AuctionInfo.auctionItemBuyProductsInfo.screenCondition
            for i = 0, conditionInfo .Count - 1 do
                condition.screenCondition:Add(conditionInfo[i])
            end
            condition.propertyTendency = self.AuctionInfo.auctionItemBuyProductsInfo.propertyTendency
            local name = self.AuctionInfo.auctionItemBuyProductsInfo.name
            networkRequest.ReqBuyProductsMarketPriceSection(condition, Utility.EnumToInt(CS.auctionV2.MarketPriceSectionType.RE_ADD), Utility.EnumToInt(CS.auctionV2.AuctionItemType.BUY_PRODUCTS), self.AuctionInfo.item.lid, name)
            --luaEventManager.DoCallback(LuaCEvent.AuctionBuyRemoveItem, self.isExpire)
        else
            local data = {}
            ---求购价格
            data.buyPrice = self.AuctionInfo.price.count
            ---@type  UIAuctionDialog_BuyingRemoveDidNotExpire
            data.Template = luaComponentTemplates.UIAuctionDialog_BuyingRemoveDidNotExpire
            data.AuctionInfo = self.AuctionInfo
            uimanager:CreatePanel("UIAuctionBuyingPanel", nil, data)
        end
    end
end

function UIAuctionPanel_SelfBuyingListGridTemplate:RefreshStrengthenInfo()
    self.Strengthen_UILabel.gameObject:SetActive(false)
end

--region 外部调用
function UIAuctionPanel_SelfBuyingListGridTemplate:ShowBG(isShow)
    local colorValue = ternary(isShow, 255, 1)
    local color = CS.UnityEngine.Color(255, 255, 255, colorValue / 255)
    self.BackFrame_UISprite.color = color
end

--endregion


return UIAuctionPanel_SelfBuyingListGridTemplate