---@class UIAuctionBuying_Base:TemplateBase
local UIAuctionBuying_Base = {}

---@param panel UIAuctionBuyingPanel 求购Tips界面
---@param data any 传入数据
function UIAuctionBuying_Base:Init(data, panel)
    self:InitComponent()
    self:InitEvent()
    self:SuitPanel()
end

function UIAuctionBuying_Base:InitComponent()
    ---@type UILabel
    ---道具名字
    self.name = self:Get("name", "UILabel")

    --region 价格
    ---@type UIInput
    ---价格输入
    self.priceInput = self:Get("Price", "UIInput")
    ---@type UnityEngine.BoxCollider
    ---总价BC
    self.priceCollider = self:Get("Price", "BoxCollider")
    ---@type UISprite
    ---总价图片
    self.priceIcon = self:Get("Price/icon", "UISprite")
    ---@type UILabel
    ---总价文本（可以换成别的）
    self.priceName = self:Get("Price/label", "UILabel")
    --endregion

    self.numInput = self:Get("Count", "UIInput")
    ---@type UnityEngine.BoxCollider
    self.numCollider = self:Get("Count", "BoxCollider")

    self.minusBtn = self:Get("Count/MinusBtn", "GameObject")
    ---@type UnityEngine.BoxCollider
    self.minusCollider = self:Get("Count/MinusBtn", "BoxCollider")

    self.plusBtn = self:Get("Count/PlusBtn", "GameObject")
    ---@type UnityEngine.BoxCollider
    self.plusBtnCollider = self:Get("Count/PlusBtn", "BoxCollider")

    self.leftBtn = self:Get("LeftBtn", "GameObject")
    self.rightBtn = self:Get("RightBtn", "GameObject")
    ---@type UnityEngine.GameObject
    self.middleBtn = self:Get("MiddleBtn", "GameObject")
    self.leftButtonLabel = self:Get("LeftBtn/Label", "UILabel")
    self.rightButtonLabel = self:Get("RightBtn/Label", "UILabel")
    self.middleButtonLabel = self:Get("MiddleBtn/Label", "UILabel")

    ---@type UISlider
    ---滑动条
    self.slider = self:Get("Slider", "UISlider")
    ---@type UISprite
    ---滑动条前置图片
    self.sliderForward_UISprite = self:Get("Slider/Foreground", "UISprite")
    ---@type UnityEngine.BoxCollider
    ---滑条BC
    self.slider_BoxCollider = self:Get("Slider", "BoxCollider")

    ---@type UISprite
    ---单价图片
    self.UnitPriceIcon_UISprite = self:Get("Slider/Thumb/Tip/Price/icon", "UISprite")
    ---@type UILabel
    ---单价价格
    self.UnitPrice_UILabel = self:Get("Slider/Thumb/Tip/Price/price", "UILabel")

    ---单价标题GO
    ---@type UnityEngine.GameObject
    self.unitPriceTitle_Go = self:Get("showLabel", "GameObject")
end

function UIAuctionBuying_Base:InitEvent()
    CS.UIEventListener.Get(self.leftBtn).onClick = function()
        self:LeftButtonClicked()
    end
    CS.UIEventListener.Get(self.rightBtn).onClick = function()
        self:RightButtonClicked()
    end
    CS.UIEventListener.Get(self.middleBtn).onClick = function(go)
        self:MiddleButtonClicked(go)
    end
    CS.UIEventListener.Get(self.minusBtn).onClick = function()
        self:MinusButtonClicked()
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
end

--region 用于重写
function UIAuctionBuying_Base:ClosePanel()
    uimanager:ClosePanel("UIAuctionBuyingPanel")
end

---左边按钮（默认关闭界面）
function UIAuctionBuying_Base:LeftButtonClicked()
    self:ClosePanel()
end

---中间按钮
function UIAuctionBuying_Base:MiddleButtonClicked()
    self:ClosePanel()
end

---右边按钮
function UIAuctionBuying_Base:RightButtonClicked()
    self:ClosePanel()
end

---减少按钮
function UIAuctionBuying_Base:MinusButtonClicked()
end

---增加按钮
function UIAuctionBuying_Base:PlusButtonClicked()
end

---数量输入改变
function UIAuctionBuying_Base:NumChange(inputValue)
end

---输入价格改变
function UIAuctionBuying_Base:PriceChange(inputValue)
end

---滑动条改变
function UIAuctionBuying_Base:SliderChange(sliderValue)
end

---是否显示滑条
function UIAuctionBuying_Base:IsShowSlider()
    return true
end

---数字输入框是否可点
function UIAuctionBuying_Base:IsNumCanClick()
    return true
end

---总价输入框是否可点
function UIAuctionBuying_Base:IsTotalPriceCanClick()
    return true
end

--endregion

--region 便于调用的通用方法
---设置增加减少按钮显示
function UIAuctionBuying_Base:ShowAddButton(isShow)
    if self.plusBtn and CS.StaticUtility.IsNull(self.plusBtn) == false then
        self.plusBtn:SetActive(isShow)
    end
    if self.minusBtn and CS.StaticUtility.IsNull(self.minusBtn) == false then
        self.minusBtn:SetActive(isShow)
    end
end

---设置底部按钮显示
---@param isShowCenter boolean 是否显示中间按钮（中间与左右互斥）
function UIAuctionBuying_Base:SetButton(isShowCenter)
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

---设置名字显示
function UIAuctionBuying_Base:SetName()
    local name
    if self.ItemInfo then
        name = self.ItemInfo.name
    else
        if self.PriceData then
            name = self.PriceData.name
        end
    end
    if self.BagItemInfo then
        name = self.BagItemInfo.ItemFullName
    end
    self.name.text = name
end

---适配界面
function UIAuctionBuying_Base:SuitPanel()
    self.slider.gameObject:SetActive(self:IsShowSlider())
    self.unitPriceTitle_Go:SetActive(self:IsShowSlider())
    self.numCollider.enabled = self:IsNumCanClick()
    self.minusCollider.enabled = self:IsNumCanClick()
    self.plusBtnCollider.enabled = self:IsNumCanClick()
    self.priceCollider.enabled = self:IsTotalPriceCanClick()
    self:RefreshLabelShow()
    local originPos = self.middleBtn.transform.localPosition
    local pos = self:IsShowSlider() and -166 or -86
    originPos.y = pos
    self.middleBtn.transform.localPosition = originPos
end

---刷新文本显示
function UIAuctionBuying_Base:RefreshLabelShow()
    self.priceName.text = "总价"
end


--endregion

return UIAuctionBuying_Base