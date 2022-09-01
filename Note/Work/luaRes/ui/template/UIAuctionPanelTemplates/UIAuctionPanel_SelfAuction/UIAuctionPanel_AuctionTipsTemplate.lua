---竞拍Tips模板
---@class UIAuctionPanel_AuctionTipsTemplate:TemplateBase
local UIAuctionPanel_AuctionTipsTemplate = {}

function UIAuctionPanel_AuctionTipsTemplate:Init(data)
    self.data = data
    if self.data.BagItemInfo then
        self.BagItemInfo = self.data.BagItemInfo
    end
    self:InitComponent()
    self:InitEvent()
    self:ShowData(data)
end

function UIAuctionPanel_AuctionTipsTemplate:InitComponent()
    self.icon = self:Get("UIItem/icon", "UISprite")
    self.icon_GameObject = self:Get("UIItem/icon", "GameObject")
    self.name = self:Get("UIItem/name", "UILabel")
    self.strength = self:Get("UIItem/strengthen", "UILabel")
    self.priceInput = self:Get("Price", "UIInput")
    self.priceCollider = self:Get("Price", "BoxCollider")
    self.numInput = self:Get("Count", "UIInput")
    self.numCollider = self:Get("Count", "BoxCollider")
    self.minusBtn = self:Get("Count/MinusBtn", "GameObject")
    self.plusBtn = self:Get("Count/PlusBtn", "GameObject")
    self.leftBtn = self:Get("LeftBtn", "GameObject")
    self.rightBtn = self:Get("RightBtn", "GameObject")
    self.middleBtn = self:Get("MiddleBtn", "GameObject")
    self.slider = self:Get("Slider", "UISlider")
    self.leftButtonLabel = self:Get("LeftBtn/Label", "UILabel")
    self.rightButtonLabel = self:Get("RightBtn/Label", "UILabel")
    ---起拍价
    self.Price_UILabel = self:Get("Price/price", "UILabel")
    ---起拍价Icon
    self.Price_UISprite = self:Get("Price/icon", "UISprite")
    ---一口价
    self.OncePrice_UILabel = self:Get("OncePrice/price", "UILabel")
    ---一口价Icon
    self.OncePrice_UISprite = self:Get("OncePrice/icon", "UISprite")
    ---交易税
    self.Rate_UILabel = self:Get("Rate/price", "UILabel")
    ---交易税Icon
    self.Rate_UISprite = self:Get("Rate/icon", "UISprite")
    ---是否公示
    self.publicity_UIToggle = self:Get("Publicity", "UIToggle")

end

function UIAuctionPanel_AuctionTipsTemplate:InitEvent()
    CS.UIEventListener.Get(self.leftBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.leftBtn).OnClickLuaDelegate = self.LeftButtonClicked
    CS.UIEventListener.Get(self.rightBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.rightBtn).OnClickLuaDelegate = self.RightButtonClicked
    CS.UIEventListener.Get(self.middleBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.middleBtn).OnClickLuaDelegate = self.MiddleButtonClicked
    CS.UIEventListener.Get(self.minusBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.minusBtn).OnClickLuaDelegate = self.MinusButtonClicked
    CS.UIEventListener.Get(self.icon_GameObject).onClick = function()
        self:OnIconClicked()
    end
    CS.UIEventListener.Get(self.plusBtn).onClick = function()
        self:PlusButtonClicked()
    end
    self.numInput.submitOnUnselect = true
    CS.EventDelegate.Add(self.numInput.onSubmit, function()
        self:NumChange(self.numInput.value)
    end)
    CS.EventDelegate.Add(self.slider.onChange, function()
        self:SliderChange(self.slider.value)
    end)
    self.priceInput.submitOnUnselect = true
    CS.EventDelegate.Add(self.priceInput.onSubmit, function()
        self:PriceChange(self.priceInput.value)
    end)
    CS.EventDelegate.Add(self.publicity_UIToggle.onChange, function()
        self:PublicityChange(self.publicity_UIToggle.value)
    end)
end

---刷新显示
function UIAuctionPanel_AuctionTipsTemplate:ShowData(data)
    self:ShowItem()
    self:RefreshOtherInfo()
end

---刷新Item显示
function UIAuctionPanel_AuctionTipsTemplate:ShowItem()
    if self.BagItemInfo then
        local res
        res, self.ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.BagItemInfo.itemId)
        if res then
            if self.icon and CS.StaticUtility.IsNull(self.icon.gameObject) == false then
                self.icon.spriteName = self.ItemInfo.icon
            end
            if self.name and CS.StaticUtility.IsNull(self.name) == false then
                self.name.text = self. BagItemInfo.ItemFullName
            end
            local priceInfo = self.ItemInfo.bidPriceSection
            if priceInfo then
                self.PriceItemId = priceInfo.list[0]
                self.lowPrice = priceInfo.list[1]
                self.highPrice = priceInfo.list[2]
                self.OncePriceMultiple = priceInfo.list[4]
            end
            local res
            res, self.CoinInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.PriceItemId)
            if res then
                self.OncePrice_UISprite.spriteName = self.CoinInfo.icon
                self.Price_UISprite.spriteName = self.CoinInfo.icon
                self.Rate_UISprite.spriteName = self.CoinInfo.icon
            end
        end
        self.MaxNum = self.BagItemInfo.count
        self:ShowAddButton(self.MaxNum > 1)
    end
end

---设置底部按钮显示
---@param isShowCenter 是否显示中间按钮（中间与左右互斥）
function UIAuctionPanel_AuctionTipsTemplate:SetButton(isShowCenter)
    if self.middleBtn and CS.StaticUtility.IsNull(self.middleBtn) == false then
        self.middleBtn:SetActive(isShowCenter)
    end
    if self.leftBtn and CS.StaticUtility.IsNull(self.leftBtn) == false then
        self.leftBtn:SetActive(not isShowCenter)
    end
    if self.rightBtn and CS.StaticUtility.IsNull(self.rightBtn) == false then
        self.rightBtn:SetActive(not isShowCenter)
    end
end

--region 用于重写
---刷新其他显示
function UIAuctionPanel_AuctionTipsTemplate:RefreshOtherInfo()
    self.num = 1
    self.sliderValue = 0
    self.slider.value = self.sliderValue
    self:SetButton(false)
    self:SetButtonLabel()
    self:SetNum(self.num)
    self.isPublicity = false
end

---设置按钮文字
function UIAuctionPanel_AuctionTipsTemplate:SetButtonLabel()
    self.leftButtonLabel.text = "取消"
    self.rightButtonLabel.text = "上架"
end

---左边按钮（默认关闭界面）
function UIAuctionPanel_AuctionTipsTemplate:LeftButtonClicked()
    self:ClosePanel()
end

---关闭界面
function UIAuctionPanel_AuctionTipsTemplate:ClosePanel()
    uimanager:ClosePanel("UIAuctionSellDialog")
end

---中间按钮
function UIAuctionPanel_AuctionTipsTemplate:MiddleButtonClicked()
end

---右边按钮
function UIAuctionPanel_AuctionTipsTemplate:RightButtonClicked()
    local canAddToAuction = CS.CSScene.MainPlayerInfo.AuctionInfo:CanAddToAuctionShelf()
    if canAddToAuction then
        self:ShowDoubleTips()
    else
        self:ShowBubble()
    end
end

---显示TIps
function UIAuctionPanel_AuctionTipsTemplate:ShowBubble()
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = self.rightBtn.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = 79
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

---二次弹窗
function UIAuctionPanel_AuctionTipsTemplate:ShowDoubleTips()
    if self.DoubleTips == nil then
        ___, self.DoubleTips = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(22)
    end
    if self.DoubleTips and self.CoinInfo and self.price and self.ItemInfo then
        local CancelInfo = {
            Title = self.DoubleTips.title,
            LeftDescription = self.DoubleTips.leftButton,
            RightDescription = self.DoubleTips.rightButton,
            ID = 22,
            Content = string.format(string.gsub(self.DoubleTips.des, "\\n", '\n'), math.ceil(self.price), self.CoinInfo.name, self.ItemInfo.name),
            CallBack = function()
                self:AddToShelf()
            end
        }
        uimanager:CreatePanel("UIPromptPanel", nil, CancelInfo)
    end
end

---上架道具
function UIAuctionPanel_AuctionTipsTemplate:AddToShelf()
    if self.BagItemInfo and self.num and self.price and self.PriceItemId then
        if (gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(self.BagItemInfo)) then
            gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():ShowInsurancePopup()
            return
        end
        local info = { itemId = self.PriceItemId, count = math.ceil(self.price) }
        networkRequest.ReqAddToShelf(self.BagItemInfo.lid, self.num, info, Utility.EnumToInt(CS.auctionV2.AuctionItemType.SALF_PRODUCTS), self.isPublicity)
    end
    self:ClosePanel()
end

---减少按钮
function UIAuctionPanel_AuctionTipsTemplate:MinusButtonClicked()
    if self.num - 1 > 0 then
        self:SetNum(self.num - 1)
    end
end

---增加按钮
function UIAuctionPanel_AuctionTipsTemplate:PlusButtonClicked()
    if self.MaxNum and self.num + 1 <= self.MaxNum then
        self:SetNum(self.num + 1)
    end
end

---数量输入改变
function UIAuctionPanel_AuctionTipsTemplate:NumChange(inputValue)
    local value = tonumber(inputValue)
    if value and value <= self.MaxNum and value > 0 then
        self:SetNum(value)
    else
        self.numInput.value = self.num
    end
end

---滑动条改变
function UIAuctionPanel_AuctionTipsTemplate:SliderChange(sliderValue)
    if self.currentLowPrice and self.currentHighPrice then
        self.sliderValue = sliderValue
        self:SetPrice(self.sliderValue * (self.currentHighPrice - self.currentLowPrice) + self.currentLowPrice)
    end
end

---是否隐藏滑动条
function UIAuctionPanel_AuctionTipsTemplate:HideSlider(isShow)
    if self.slider and CS.StaticUtility.IsNull(self.slider) == false then
        self.slider.gameObject:SetActive(isShow)
    end
end

---价格改变
function UIAuctionPanel_AuctionTipsTemplate:PriceChange(inputValue)
    if self.currentHighPrice and self.num then
        local value = tonumber(inputValue)
        if value then
            if value > 100 and value <= self.currentHighPrice then
                local sliderValue = (value - self.currentLowPrice) / (self.currentHighPrice - self.currentLowPrice)
                self.slider.value = sliderValue
                self:SetPrice(value)
            elseif value < self.currentLowPrice then
                self.slider.value = 0
                self:SetPrice(self.currentLowPrice)
            elseif value > self.currentHighPrice then
                self.slider.value = 1
                self:SetPrice(self.currentHighPrice)
            end
        else
            self.priceInput.value = math.ceil(self.price)
            local sliderValue = (self.price - self.currentLowPrice) / (self.currentHighPrice - self.currentLowPrice)
            self.slider.value = sliderValue
            self:SetPrice(self.price)
        end
    end
end

---设置增加减少按钮显示
function UIAuctionPanel_AuctionTipsTemplate:ShowAddButton(isShow)
    if CS.StaticUtility.IsNull(self.plusBtn) == false then
        self.plusBtn:SetActive(isShow)
    end
    if CS.StaticUtility.IsNull(self.minusBtn) == false then
        self.minusBtn:SetActive(isShow)
    end
end

---设置数量
function UIAuctionPanel_AuctionTipsTemplate:SetNum(value)
    if self.lowPrice and self.highPrice then
        self.num = value
        self.currentLowPrice = self.num * self.lowPrice
        self.currentHighPrice = self.num * self.highPrice
        self:SetPrice(self.sliderValue * (self.currentHighPrice - self.currentLowPrice) + self.currentLowPrice)
    end
end

---设置起拍价格
function UIAuctionPanel_AuctionTipsTemplate:SetPrice(value)
    self.price = value
    self.Price_UILabel.text = math.ceil(self.price)
    self:SetOncePrice()
    self:ShowRate()
end

---设置一口价
function UIAuctionPanel_AuctionTipsTemplate:SetOncePrice()
    if self.OncePriceMultiple and self.price then
        self.OncePrice_UILabel.text = math.ceil(self.OncePriceMultiple * self.price)
    end
end

---显示税率
function UIAuctionPanel_AuctionTipsTemplate:ShowRate()
    if self.OncePriceMultiple and self.price then
        local priceRate = self:GetRate((self.price))
        local maxPriceRate = self:GetRate((self.price * self.OncePriceMultiple))
        local half = ternary(self.isPublicity, 2, 1)
        if priceRate and maxPriceRate then
            self.Rate_UILabel.text = math.ceil(priceRate / half) .. "-" .. math.ceil(maxPriceRate / half)
        end
    end
end

---计算税率(单价和数量任何一个变动都要重新计算税率)
function UIAuctionPanel_AuctionTipsTemplate:GetRate(price)
    local addNum = 0
    local rateInfo = self:GetRateData()
    if price and rateInfo and self.ItemInfo then
        local totalPrice = price / self.ItemInfo.bidPriceSection.list[1] * 100
        for i = 1, #rateInfo do
            if rateInfo[i][2] and rateInfo[i][1] and rateInfo[i][3] then
                if totalPrice >= rateInfo[i][2] then
                    local value1 = rateInfo[i][3] / 10000
                    local value2 = self.ItemInfo.bidPriceSection.list[1]
                    addNum = addNum + value1 * value2
                else
                    local value1 = rateInfo[i][1] / 100
                    local value2 = price - self.ItemInfo.bidPriceSection.list[1] * value1
                    local value3 = rateInfo[i][3] / 10000
                    addNum = addNum + value3 * value2
                    break
                end
            end
        end
    end
    return addNum
end

---获取税率信息
function UIAuctionPanel_AuctionTipsTemplate:GetRateData()
    if self.RateInfo == nil then
        self.RateInfo = {}
        local res, tableData = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20300)
        if res then
            local str = string.Split(tableData.value, "&")
            for i = 1, #str do
                local tbl = {}
                local str2 = string.Split(str[i], "#")
                for j = 1, #str2 do
                    tbl[j] = tonumber(str2[j])
                    self.RateInfo[i] = tbl
                end
            end
        end
    end
    return self.RateInfo
end

---公示改变
function UIAuctionPanel_AuctionTipsTemplate:PublicityChange(value)
    self.isPublicity = value
    self:ShowRate()
end
--endregion

---点击头像
function UIAuctionPanel_AuctionTipsTemplate:OnIconClicked()
    if self.BagItemInfo and self.ItemInfo then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.BagItemInfo, showAssistPanel = true, showRight = false; })
    end
end

return UIAuctionPanel_AuctionTipsTemplate