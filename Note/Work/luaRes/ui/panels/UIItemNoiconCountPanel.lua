local UIItemNoiconCountPanel ={}
function UIItemNoiconCountPanel:Init()
    self:InitConpoment()
    self:InitEvent()
end

function UIItemNoiconCountPanel:InitConpoment()
    self:AddCollider()
    self.reduce_GameObject = self:GetCurComp("WidgetRoot/view/reduce","GameObject")
    self.add_GameObject = self:GetCurComp("WidgetRoot/view/add","GameObject")
    self.btn_ensure_GameObject = self:GetCurComp("WidgetRoot/view/btn_ensure","GameObject")
    self.btn_cancel_GameObject = self:GetCurComp("WidgetRoot/view/btn_cancel","GameObject")
    self.inputcountLabel_UILabel = self:GetCurComp("WidgetRoot/view/inputcount","UIInput")
    self.itemgold_UILabel = self:GetCurComp("WidgetRoot/view/itemgold","UILabel")
    self.itemgoldSprite_UISprite = self:GetCurComp("WidgetRoot/view/itemgold/Sprite","UISprite")
end

---@param customData.beginCount 初始数量
---@param customData.goldItemInfo 货币的ItemInfo
---@param customData.singlePrice 单价
---@param customData.minBuyCount 最少购买数量
---@param customData.maxBuyCount 最大购买数量
---@param customData.ensureCallBack 确认按钮回调
function UIItemNoiconCountPanel:Show(customData)
    if customData ~= nil then
        self.beginCount = ternary(customData.beginCount == nil,1,customData.beginCount)
        self.minBuyCount =  ternary(customData.minBuyCount == nil,1,customData.minBuyCount)
        self.maxBuyCount = ternary(customData.maxBuyCount == nil,1,customData.maxBuyCount)
        self.singlePrice = ternary(customData.singlePrice == nil,1,customData.singlePrice)
        self.ensureCallBack = ternary(customData.ensureCallBack == nil,UIItemNoiconCountPanel.ClosePanel,customData.ensureCallBack)
        self.inputcountLabel_UILabel.value = tostring(self.beginCount)
        if customData.goldItemInfo ~= nil then
            self.itemgold_UILabel.gameObject:SetActive(true)
            self.itemgoldSprite_UISprite.spriteName = customData.goldItemInfo.icon
            self.itemgold_UILabel.text = self.singlePrice * self.beginCount
        else
            self.itemgold_UILabel.gameObject:SetActive(false)
        end
    end
end

function UIItemNoiconCountPanel:InitEvent()
    CS.UIEventListener.Get(self.reduce_GameObject).onClick = function()
        self:reduceBtnClick()
    end
    CS.UIEventListener.Get(self.add_GameObject).onClick = function()
        self:addBtnClick()
    end
    CS.UIEventListener.Get(self.btn_ensure_GameObject).onClick = function()
        self.ensureCallBack(tonumber(self.inputcountLabel_UILabel.value))
        self.ClosePanel()
    end
    CS.UIEventListener.Get(self.btn_cancel_GameObject).onClick = self.ClosePanel
end

--region BtnClick
function UIItemNoiconCountPanel:reduceBtnClick()
    local nowInputCount = tonumber(self.inputcountLabel_UILabel.value)
    self.inputcountLabel_UILabel.value = (ternary(nowInputCount > self.minBuyCount,tostring(nowInputCount - 1),tostring(nowInputCount)))
    self.itemgold_UILabel.text = ternary(nowInputCount > self.minBuyCount,tostring((nowInputCount - 1) * self.singlePrice),tostring(nowInputCount * self.singlePrice))
end

function UIItemNoiconCountPanel:addBtnClick()
    local nowInputCount = tonumber(self.inputcountLabel_UILabel.value)
    self.inputcountLabel_UILabel.value = (ternary(nowInputCount < self.maxBuyCount,tostring(nowInputCount + 1),tostring(nowInputCount)))
    self.itemgold_UILabel.text = ternary(nowInputCount < self.maxBuyCount,tostring((nowInputCount + 1) * self.singlePrice),tostring(nowInputCount * self.singlePrice))
end

function UIItemNoiconCountPanel.ClosePanel()
    uimanager:ClosePanel("UIItemNoiconCountPanel")
end
--endregion

return UIItemNoiconCountPanel