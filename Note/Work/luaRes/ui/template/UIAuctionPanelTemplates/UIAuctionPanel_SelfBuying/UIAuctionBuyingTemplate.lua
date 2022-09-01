---@class UIAuctionBuyingTemplate:UIAuctionBuying_Base
local UIAuctionBuyingTemplate = {}

setmetatable(UIAuctionBuyingTemplate, luaComponentTemplates.UIAuctionBuying_Base)

---@param data any
function UIAuctionBuyingTemplate:Init(data, panel)
    self:RunBaseFunction("Init", data, panel)
    if data == nil then
        return
    end

    --region数据
    ---@type table
    self.data = data

    ---@type bagV2.BagItemInfo
    ---背包类型数据
    self.BagItemInfo = self.data.BagItemInfo

    ---市场价格数据
    ---@type auctionV2.MarketPriceSection
    self.PriceData = self.data.PriceData

    if self.PriceData then
        ---@type auctionV2.BuyProductsCondition
        ---求购条件
        self.Condition = self.PriceData.condition
    end
    --endregion

    --region 刷新
    ---@type number
    ---当前单价
    self.price = 0
    --刷新
    if self.PriceData then
        self:SetPriceData()
    end

    self:SetName()

    if self.Condition then
        local itemId = self.Condition.itemId
        ___, self.ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)

        ---@type number
        ---求购货币Id
        self.PriceItemId = self.Condition.currency
        ---@type  TABLE.CFG_ITEMS 货币道具信息
        ___, self.PriceItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.PriceItemId)
    end

    ---@type number 当前求购数目
    self.num = 1
    self:SetInitNum()

    self:SetPrice()
    self:SetPriceIcon()
    self:InitBtnState()
    --endregion
end

function UIAuctionBuyingTemplate:InitBtnState()
    self:SetButton(true)
    self.middleButtonLabel.text = "求购"
end

---设置初始数目
function UIAuctionBuyingTemplate:SetInitNum()
    ---非堆叠道具最大求购数目
    local globalNum = CS.Cfg_GlobalTableManager.Instance:GetBuyingMaxNum()
    self.maxNum = globalNum
    if self.ItemInfo then
        self.maxNum = ternary(self.ItemInfo.overlying > globalNum or globalNum == nil, self.ItemInfo.overlying, globalNum)
        self.num = self.ItemInfo.overlying
    end
    self:SetNum()
end

---设置价格显示
function UIAuctionBuyingTemplate:SetPriceData()
    self.lowPrice = self.PriceData.marketPriceSection . lowPrice
    self.topPrice = self.PriceData.marketPriceSection.topPrice
    local canMove = self.lowPrice ~= self.topPrice
    local sliderValue
    if canMove then
        local rate = CS.Cfg_GlobalTableManager.Instance:GetAuctionBuyingTipsPriceRate()
        if rate < 0 then
            rate = 1
        else
            rate = rate / 100
        end
        ---当前价格
        self.price = self.lowPrice + (self.topPrice - self.lowPrice) * rate
        sliderValue = (self.price - self.lowPrice) / (self.topPrice - self.lowPrice)
    else
        self.price = self.lowPrice
        sliderValue = 1
    end
    self:SetSliderCanMove(canMove)
    self.slider.value = sliderValue
end

---设置滑动条是否可移动
function UIAuctionBuyingTemplate:SetSliderCanMove(canMove)
    self.sliderForward_UISprite.color = ternary(canMove, LuaEnumUnityColorType.Normal, LuaEnumUnityColorType.Gray)
    self.slider_BoxCollider.enabled = canMove
    self.priceCollider.enabled = canMove
end

---设置价格显示
function UIAuctionBuyingTemplate:SetPrice()
    if self.price and self.num and not CS.StaticUtility.IsNull(self.priceInput) then
        local price = math.ceil(self.price)
        self.UnitPrice_UILabel.text = price
        self.priceInput.value = price * self.num
    end
end

---设置价格图片
function UIAuctionBuyingTemplate:SetPriceIcon()
    if self.PriceItemInfo then
        self.UnitPriceIcon_UISprite.spriteName = self.PriceItemInfo.icon
        self.priceIcon.spriteName = self.PriceItemInfo.icon
    end
end

---设置价格
function UIAuctionBuyingTemplate:PriceChange(inputValue)
    if inputValue and self.topPrice and self.lowPrice then
        local finalNum = tonumber(inputValue)
        if finalNum then
            if finalNum > self.topPrice then
                finalNum = self.topPrice
            elseif finalNum < self.lowPrice then
                finalNum = self.lowPrice
            end
        else
            finalNum = self.price
        end
        self.priceInput.value = finalNum
        self.price = finalNum
        self.slider.value = (self.price - self.lowPrice) / (self.topPrice - self.lowPrice)
        self:SetPrice()
    end
end

---滑条改变
function UIAuctionBuyingTemplate:SliderChange(sliderValue)
    if sliderValue and self.topPrice and self.lowPrice then
        self.price = (self.topPrice - self.lowPrice) * sliderValue + self.lowPrice
        self:SetPrice()
    end
end

---发布
function UIAuctionBuyingTemplate:MiddleButtonClicked(go)
    local canAddToAuction = CS.CSScene.MainPlayerInfo.AuctionInfo:CanAddToBuyingShelf()
    if canAddToAuction then
        if self:IsMoneyEnough() then
            self:ReqBuying()
            self:ClosePanel()
        else
            Utility.ShowPopoTips(go, nil, 98)
        end
    else
        Utility.ShowPopoTips(go, nil, 99)
    end
end

---货币是否足够
function UIAuctionBuyingTemplate:IsMoneyEnough()
    if self.price and self.num then
        local totalPrice = self.price * self.num
        local selfCost = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(self.PriceItemId)
        return totalPrice <= math.ceil(selfCost)
    end
    return false
end

---发起求购
function UIAuctionBuyingTemplate:ReqBuying()
    local condition = self.Condition
    if self.num then
        condition.count = self.num
        condition.minLevel = self.Condition.minLevel
    end
    local info = CS.bagV2.CoinInfo()
    if self.PriceItemId and self.price and self.Condition then
        info.itemId = self.PriceItemId
        info.count = math.ceil(self.price)
        networkRequest.ReqReleaseBuyProducts(info, condition, self.PriceData.name)
    end
end

---设置数量
function UIAuctionBuyingTemplate:NumChange(inputValue)
    if self.maxNum then
        local finalNum = tonumber(inputValue)
        if finalNum then
            if finalNum > self.maxNum then
                finalNum = self.maxNum
            elseif finalNum < 1 then
                finalNum = 1
            end
        else
            finalNum = self.num
        end
        self.num = finalNum
        self:SetNum()
    end
end

---设置数量
function UIAuctionBuyingTemplate:SetNum()
    if self.num and self.numInput then
        self.numInput.value = math.ceil(self.num)
        self:SetPrice()
    end
end

---减少数量
function UIAuctionBuyingTemplate:MinusButtonClicked()
    if self.num - 1 >= 1 then
        self.num = self.num - 1
        self:SetNum()
    end
end

---增加数量
function UIAuctionBuyingTemplate:PlusButtonClicked()
    if self.maxNum and self.num + 1 <= self.maxNum then
        self.num = self.num + 1
        self:SetNum()
    end
end

return UIAuctionBuyingTemplate