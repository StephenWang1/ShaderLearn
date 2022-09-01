local UIGuildSendBenefitsPromptPanel = {}

function UIGuildSendBenefitsPromptPanel:Init()
    self:InitComponent()
    self:BindEvents()
end

function UIGuildSendBenefitsPromptPanel:InitComponent()
    self.closeBtn_GameObject = self:GetCurComp("events/close", "GameObject")
    self.chatInput_UIInput = self:GetCurComp("view/Chat Input", "UIInput")
    self.icon_UISprite = self:GetCurComp("view/Chat Input/icon", "UISprite")
    self.guildingot_UILabel = self:GetCurComp("view/Guildingot", "UILabel")
    self.cancelBtn_GameObject = self:GetCurComp("events/LeftBtn", "GameObject")
    self.confirmBtn_GameObject = self:GetCurComp("events/RightBtn", "GameObject")
    self.chatInput_UILabel = self:GetCurComp("view/Chat Input/Label", "UILabel")
    ---@type UILabel
    self.chatInputGoldName_UILabel = self:GetCurComp("view/Chat Input/goldName", "UILabel")
    ---@type UILabel
    self.guildingotGoldName_UILabel = self:GetCurComp("view/Guildingot/goldName", "UILabel")
end

function UIGuildSendBenefitsPromptPanel:BindEvents()
    CS.UIEventListener.Get(self.closeBtn_GameObject).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self.icon_UISprite.gameObject).onClick = function()
        self:SpriteIconOnClick()
    end
    CS.UIEventListener.Get(self.cancelBtn_GameObject).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self.confirmBtn_GameObject).onClick = function()
        self:ConfirmOnClick()
    end
    self.chatInput_UIInput.submitOnUnselect = true
    CS.EventDelegate.Add(self.chatInput_UIInput.onSubmit, function()
        self:RefreshValue()
    end)
end

--region 刷新
---@param commonData.minValue 刷入數值最小值
---@param commonData.maxValue 刷入數值最大值
---@param commonData.itemInfo 物品信息
---@param commonData.confirmCallBack 確認按鈕回調
function UIGuildSendBenefitsPromptPanel:Show(commonData)
    self:AnalysisData(commonData)
    self:RefreshPanel()
    self.chatInput_UIInput.value = CS.Cfg_GlobalTableManager.Instance:GetDefaultSpoilsNum()
    self:RefreshValue()
end

function UIGuildSendBenefitsPromptPanel:AnalysisData(commonData)
    self.minValue = ternary(commonData.minValue == nil, 0, commonData.minValue)
    self.maxValue = ternary(commonData.maxValue == nil, 999999999, commonData.maxValue)
    ---@type TABLE.CFG_ITEMS
    self.itemInfo = commonData.itemInfo
    local goldName = CS.Cfg_ItemsTableManager.Instance:GetItemName(self.itemInfo.id)
    self.chatInputGoldName_UILabel.text = goldName
    self.guildingotGoldName_UILabel.text = goldName
    self.confirmCallBack = commonData.confirmCallBack
    self.multiple = ternary(commonData.multiple == nil, 1, commonData.multiple)
    self.showMaxValue = ternary(commonData.showMaxValue == nil, 9999, commonData.showMaxValue)
    if commonData.IsClosePanel == nil then
        self.IsClosePanel = true
    else
        self.IsClosePanel = commonData.IsClosePanel
    end
end

function UIGuildSendBenefitsPromptPanel:RefreshPanel()
    if self.icon_UISprite ~= nil and self.itemInfo ~= nil then
        self.icon_UISprite.spriteName = self.itemInfo.icon
    end
end
--endregion

--region UI事件
function UIGuildSendBenefitsPromptPanel:ClosePanel()
    uimanager:ClosePanel(self)
end

function UIGuildSendBenefitsPromptPanel:SpriteIconOnClick()
    if self.itemInfo ~= nil then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.itemInfo })
    end
end

function UIGuildSendBenefitsPromptPanel:ConfirmOnClick()
    if self.IsClosePanel then
        self:ClosePanel()
    end
    if self.confirmCallBack ~= nil then
        self:confirmCallBack()
    end
end

function UIGuildSendBenefitsPromptPanel:RefreshValue()
    local value = tonumber(self.chatInput_UIInput.value)
    if value == nil then
        value = 0
    end
    if value < self.minValue then
        value = self.minValue
    elseif value > self.maxValue then
        value = self.maxValue
    end
    self.chatInput_UIInput.value = value
    self.inputValue = value
    self.totalNum = value * self.multiple
    if self.guildingot_UILabel ~= nil then
        local nowValue = Utility.GetBBCode(self.totalNum <= self.showMaxValue) .. tostring(self.totalNum) .. "[-]"
        local text = nowValue .. "/" .. tostring(self.showMaxValue)
        self.guildingot_UILabel.text = text
    end
end
--endregion

--region 查询
---查询是否超额
function UIGuildSendBenefitsPromptPanel:IsExcess()
    local nowValue = self.totalNum
    local maxValue = self.showMaxValue
    return nowValue > maxValue
end
--endregion

return UIGuildSendBenefitsPromptPanel