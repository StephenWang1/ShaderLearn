---@class UIAuctionPanel_AuctionItemTemplateBase:TemplateBase 上架模板总
local UIAuctionPanel_AuctionItemTemplateBase = {}

---@param data customData
---@alias customData{Template:table,BagItemInfo:bagV2.BagItemInfo,PriceData:auctionV2.MarketPriceSection,ItemState:number}
function UIAuctionPanel_AuctionItemTemplateBase:Init(data)
    self.data = data
    self:InitComponent()
    self:BindEvent()
    self:RefreshTitle()
    self.titleBtnHeight = 34
end

function UIAuctionPanel_AuctionItemTemplateBase:InitComponent()
    ---@type UnityEngine.GameObject
    ---标题
    self.TitleBtn_GameObject = self:Get("view/TitleBtns", "GameObject")

    ---@type UIToggle
    ---竞拍Toggle
    self.auctionBtn_GameObject = self:Get("view/TitleBtns/left", "UIToggle")

    ---@type UIToggle
    ---直购Toggle
    self.buyBtn_GameObject = self:Get("view/TitleBtns/right", "UIToggle")

    ---@type UISprite
    ---背景
    self.bg_UISprite = self:Get("window/background", "UISprite")

    ---@type UnityEngine.BoxCollider
    ---背景collider
    self.bg_BoxColloder = self:Get("window/background", "BoxCollider")

    ---@type UIGridContainer
    ---价格
    self.coin_UIGridContainer = self:Get("view/Coin", "UIGridContainer")

    --region 数目
    ---@type UnityEngine.GameObject
    ---数目节点
    self.num_GameObject = self:Get("view/Num", "GameObject")
    ---@type UIInput
    ---输入数目
    self.num_UIInput = self:Get("view/Num/inputcount", "UIInput")
    ---@type UnityEngine.BoxCollider
    ---数字输入
    self.num_BoxCollider = self:Get("view/Num/inputcount", "BoxCollider")
    ---@type UnityEngine.GameObject
    ---减少数目
    self.reduce_GameObject = self:Get("view/Num/reduce", "GameObject")
    ---@type UnityEngine.GameObject
    ---增加数目
    self.add_GameObject = self:Get("view/Num/add", "GameObject")
    ---@type UILabel
    ---数目名字
    self.mNameTitle_UILabel = self:Get("view/Num/lb_number", "UILabel")
    ---数字背景
    ---@type UISprite
    self.NumBg_UISprite = self:Get("view/Num/inputcount/Background", "UISprite")
    --endregion

    --region 按钮
    self.btn_GameObject = self:Get("view/dispose", "GameObject")
    self.centerBtn_UILabel = self:Get("view/dispose/Label", "UILabel")
    self.btns_GameObject = self:Get("view/btns", "GameObject")
    self.leftBtn_GameObject = self:Get("view/btns/left", "GameObject")
    self.leftBtn_UILabel = self:Get("view/btns/left/Label", "UILabel")
    self.right_GameObject = self:Get("view/btns/right", "GameObject")
    self.rightBtn_UILabel = self:Get("view/btns/right/Label", "UILabel")
    --endregion

    --region 滑条
    ---@type UISlider
    ---滑条
    self.slider_UISlider = self:Get("view/Slider", "UISlider")
    --endregion

    ---@type UILabel
    ---是否公示
    self.showLabel = self:Get("view/Public", "GameObject")

    ---@type UIToggle
    ---公示Toggle
    self.publish_UIToggle = self:Get("view/Public/Publicity", "UIToggle")

    ---@type UnityEngine.GameObject
    ---视图节点
    self.view_GameObject = self:Get("view", "GameObject")
end

function UIAuctionPanel_AuctionItemTemplateBase:BindEvent()
    CS.UIEventListener.Get(self.add_GameObject).onClick = function(go)
        self:OnAddBtnClicked(go)
    end
    CS.UIEventListener.Get(self.reduce_GameObject).onClick = function(go)
        self:OnReduceBtnClicked(go)
    end
    CS.EventDelegate.Add(self.auctionBtn_GameObject.onChange, function()
        if (self.auctionBtn_GameObject.value) then
            self:OnBuyBtnClicked()
        end
    end)

    CS.EventDelegate.Add(self.buyBtn_GameObject.onChange, function()
        if (self.buyBtn_GameObject.value) then
            self:OnAuctionBtnClicked()
        end
    end)

    CS.UIEventListener.Get(self.btn_GameObject).onClick = function(go)
        self:OnShelfClicked(go)
    end
    CS.UIEventListener.Get(self.leftBtn_GameObject).onClick = function(go)
        self:OnLeftClicked(go)
    end
    CS.UIEventListener.Get(self.right_GameObject).onClick = function(go)
        self:OnRightBtnClicked(go)
    end
    self.num_UIInput.submitOnUnselect = true
    CS.EventDelegate.Add(self.num_UIInput.onSubmit, function()
        self:NumChange(self.num_UIInput.value)
    end)
    CS.EventDelegate.Add(self.slider_UISlider.onChange, function()
        self:SliderChange(self.slider_UISlider.value)
    end)
    CS.EventDelegate.Add(self.publish_UIToggle.onChange, function()
        self:OnPublishToggleChange(self.publish_UIToggle.value)
    end)
end

---点击数目增加
function UIAuctionPanel_AuctionItemTemplateBase:OnAddBtnClicked(go)
    if self.num and self.num + 1 <= self.mMaxNum then
        self.num = self.num + 1
        self:SetNum()
    end
end

---点击减少按钮
---交易行的逻辑，减少到最小值继续减少变成最大值，要修改可以重写此方法，一定要调用SetNum刷新
function UIAuctionPanel_AuctionItemTemplateBase:OnReduceBtnClicked(go)
    if self.num then
        if self.num - 1 >= self.mMinNum then
            self.num = self.num - 1
        else
            self.num = self:GetMaxNum();
        end
        self:SetNum()
    end
end

function UIAuctionPanel_AuctionItemTemplateBase:GetMaxNum()
    return self.mMaxNum;
end

---输入数目改变
function UIAuctionPanel_AuctionItemTemplateBase:NumChange(inputValue)
    local num = tonumber(inputValue)
    if num and self.mMaxNum then
        if num > self.mMaxNum then
            self.num = self.mMaxNum
        elseif num < self.mMinNum then
            self.num = self.mMinNum
        else
            self.num = num
        end
        self:SetNum()
    end
end

---改变滑条数值
function UIAuctionPanel_AuctionItemTemplateBase:SetSliderValue(defaultPrice)
    ---刷新默认价格
    if self:ShowSlider() and defaultPrice and self.mMaxPrice - self.mMinPrice ~= 0 then
        local rate = (defaultPrice - self.mMinPrice) / (self.mMaxPrice - self.mMinPrice)
        if defaultPrice == 0 then
            rate = 0
        end
        self.slider_UISlider.value = rate
        self:SliderChange(rate,defaultPrice)
    end
    self:SetNum()
end

--region 用于重写
function UIAuctionPanel_AuctionItemTemplateBase:IsNumLabelNeedSpace()
    return false
end

---@return boolean 是否显示标题
function UIAuctionPanel_AuctionItemTemplateBase:ShowTitleBtn()
    return false
end

---@return boolean 是否显示数目
function UIAuctionPanel_AuctionItemTemplateBase:ShowNum()
    return true
end

---@return number 价格行数
function UIAuctionPanel_AuctionItemTemplateBase:ShowCoin()
    return 0
end

---@return boolean 是否显示滑条
function UIAuctionPanel_AuctionItemTemplateBase:ShowSlider()
    return false
end

---@return boolean 是否是单个按钮
function UIAuctionPanel_AuctionItemTemplateBase:IsSingleBtn()
    return true
end

---@return boolean 是否显示文本
function UIAuctionPanel_AuctionItemTemplateBase:ShowLabel()
    return false
end

---@return boolean 是否显示加号
function UIAuctionPanel_AuctionItemTemplateBase:ShowAddBtn()
    return true
end

---@return boolean 是否显示减号
function UIAuctionPanel_AuctionItemTemplateBase:ShowReduceBtn()
    return true
end

---滑条改变
function UIAuctionPanel_AuctionItemTemplateBase:SliderChange(sliderValue,defaultPrice)
end

---点击竞拍按钮(左按钮)
function UIAuctionPanel_AuctionItemTemplateBase:OnAuctionBtnClicked()
end

---点击直购按钮（右按钮）
function UIAuctionPanel_AuctionItemTemplateBase:OnBuyBtnClicked(go)
end

---用于数目变化后的处理
function UIAuctionPanel_AuctionItemTemplateBase:SetNum()
end

---公示改变
function UIAuctionPanel_AuctionItemTemplateBase:OnPublishToggleChange(value)
end

---点击上架按钮
function UIAuctionPanel_AuctionItemTemplateBase:OnShelfClicked(go)
end

---左边按钮
function UIAuctionPanel_AuctionItemTemplateBase:OnLeftClicked()
end

---右边按钮
function UIAuctionPanel_AuctionItemTemplateBase:OnRightBtnClicked(go)
end

---刷新标题
function UIAuctionPanel_AuctionItemTemplateBase:RefreshTitle()
    self.centerBtn_UILabel.text = "上架"
    self.leftBtn_UILabel.text = "重新上架"
    self.rightBtn_UILabel.text = "下架"
end

function UIAuctionPanel_AuctionItemTemplateBase:RefreshNumName()
    self.mNameTitle_UILabel.text = ternary(self:IsNumLabelNeedSpace(), "数     目", "数目")
end

--endregion

---适配界面（数据处理一定要在此方法之前）
function UIAuctionPanel_AuctionItemTemplateBase:SuitPanel()
    self:RefreshNumName()
    local topOffset = 10--顶部到数字间距10
    local numHeight = 8--初始偏移
    local startPos = CS.UnityEngine.Vector3.zero

    local height = numHeight - topOffset --数字高度

    local normalHeight = 40

    self.TitleBtn_GameObject:SetActive(self:ShowTitleBtn())
    if self:ShowTitleBtn() then
        startPos.y = 43
        self.TitleBtn_GameObject.transform.localPosition = startPos
    end

    --设置数字位置
    self.num_GameObject:SetActive(self:ShowNum())
    if self:ShowNum() then
        startPos.y = height
        self.num_GameObject.transform.localPosition = startPos

        local numHeight = 34
        height = height - numHeight / 2
    end

    --设置价格位置
    local coinLine = self:ShowCoin()
    if coinLine and coinLine ~= 0 then
        local coinHeight = 32
        local coinOffset = 10
        if self:ShowNum() then
            height = height - coinHeight / 2 - coinOffset
        end

        startPos.y = height
        self.coin_UIGridContainer.gameObject.transform.localPosition = startPos

        local coinPreHeight = 42
        height = height - (coinLine - 1) * coinPreHeight - coinHeight / 2
    end


    --设置滑条位置
    self.slider_UISlider.gameObject:SetActive(self:ShowSlider())
    if self:ShowSlider() then
        local sliderOffset = 26
        local sliderHeight = 16
        height = height - sliderHeight / 2 - sliderOffset

        startPos.y = height
        self.slider_UISlider.gameObject.transform.localPosition = startPos

        height = height - sliderHeight / 2
    end

    self.showLabel:SetActive(self:ShowLabel())
    if self:ShowLabel() then
        local labelHeight = 20
        local labelOffset = 26
        height = height - labelHeight / 2 - labelOffset

        startPos.y = height
        self.showLabel.transform.localPosition = startPos
        height = height - labelHeight / 2
    end

    local btnOffset = ternary(self:ShowSlider(), 26, 10) -- 按钮偏移
    local btnHeight = 48
    height = height - btnOffset - btnHeight / 2

    startPos.y = height
    self.btn_GameObject:SetActive(self:IsSingleBtn())
    self.btns_GameObject:SetActive(not self:IsSingleBtn())
    if self:IsSingleBtn() then
        self.btn_GameObject.transform.localPosition = startPos
    else
        self.btns_GameObject.transform.localPosition = startPos
    end

    local finalOffset = 10
    height = height - btnHeight - 7 - finalOffset

    startPos.y = self.bg_UISprite.transform.localPosition.y / 2 + 36
    self.view_GameObject.transform.localPosition = startPos

    --height = height - self.titleBtnHeight

    self.bg_UISprite.height = -height

    --self.bg_UISprite:ResizeCollider()--这个方法没有用
    local size = self.bg_BoxColloder.size
    size.y = self.bg_UISprite.height
    self.bg_BoxColloder.size = size
    local center = self.bg_BoxColloder.center
    center.y = -self.bg_UISprite.height / 2
    self.bg_BoxColloder.center = center
end

function UIAuctionPanel_AuctionItemTemplateBase:ClosePanel()
    uimanager:ClosePanel("UIAuctionItemPanel")
end

---@return CSMainPlayerInfo
function UIAuctionPanel_AuctionItemTemplateBase:GetPlayerInfo()
    if self.mPlayerInfo == nil then
        self.mPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mPlayerInfo
end

---@return CSBagInfoV2
function UIAuctionPanel_AuctionItemTemplateBase:GetBagInfoV2()
    if self.mBagInfo == nil and self:GetPlayerInfo() then
        self.mBagInfo = self:GetPlayerInfo().BagInfo
    end
    return self.mBagInfo
end

---@return TABLE.CFG_ITEMS
function UIAuctionPanel_AuctionItemTemplateBase:GetItemInfo(itemId)
    if self.mIdToItemInfo == nil then
        self.mIdToItemInfo = {}
    end
    local data = self.mIdToItemInfo[itemId]
    if data == nil then
        ___, data = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
        self.mIdToItemInfo[itemId] = data
    end
    return data
end

return UIAuctionPanel_AuctionItemTemplateBase