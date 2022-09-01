---血继套装格子的解锁弹窗
---@class UIPromptBloodSuitPanel:UIBase
local UIPromptBloodSuitPanel = {}

---@return UnityEngine.GameObject
function UIPromptBloodSuitPanel:GetCloseButtonGO()
    if self.mCloseButtonGO == nil then
        self.mCloseButtonGO = self:GetCurComp("events/close", "GameObject")
    end
    return self.mCloseButtonGO
end

---@return UILabel
function UIPromptBloodSuitPanel:GetContentLabel()
    if self.mContentLabel == nil then
        self.mContentLabel = self:GetCurComp("view/Content", "UILabel")
    end
    return self.mContentLabel
end

---@return UIToggle
function UIPromptBloodSuitPanel:GetCoinLeftUIToggle()
    if self.mCoinLeftUIToggle == nil then
        self.mCoinLeftUIToggle = self:GetCurComp("view/CostItem/Diamonds", "UIToggle")
    end
    return self.mCoinLeftUIToggle
end

---@return UISprite
function UIPromptBloodSuitPanel:GetCoinLeftIconSprite()
    if self.mCoinLeftIconSprite == nil then
        self.mCoinLeftIconSprite = self:GetCurComp("view/CostItem/Diamonds/icon", "UISprite")
    end
    return self.mCoinLeftIconSprite
end

---@return UILabel
function UIPromptBloodSuitPanel:GetCoinLeftAmountLabel()
    if self.mCoinLeftAmountLabel == nil then
        self.mCoinLeftAmountLabel = self:GetCurComp("view/CostItem/Diamonds/Label", "UILabel")
    end
    return self.mCoinLeftAmountLabel
end

---@return UIToggle
function UIPromptBloodSuitPanel:GetCoinRightUIToggle()
    if self.mCoinRightUIToggle == nil then
        self.mCoinRightUIToggle = self:GetCurComp("view/CostItem/GoldIngot", "UIToggle")
    end
    return self.mCoinRightUIToggle
end

---@return UISprite
function UIPromptBloodSuitPanel:GetCoinRightIconSprite()
    if self.mCoinRightIconSprite == nil then
        self.mCoinRightIconSprite = self:GetCurComp("view/CostItem/GoldIngot/icon", "UISprite")
    end
    return self.mCoinRightIconSprite
end

---@return UILabel
function UIPromptBloodSuitPanel:GetCoinRightAmountLabel()
    if self.mCoinRightAmountLabel == nil then
        self.mCoinRightAmountLabel = self:GetCurComp("view/CostItem/GoldIngot/Label", "UILabel")
    end
    return self.mCoinRightAmountLabel
end

function UIPromptBloodSuitPanel:GetLeftBtnGO()
    if self.mLeftBtnGO == nil then
        self.mLeftBtnGO = self:GetCurComp("events/LeftBtn", "GameObject")
    end
    return self.mLeftBtnGO
end

function UIPromptBloodSuitPanel:GetRightBtnGO()
    if self.mRightBtnGO == nil then
        self.mRightBtnGO = self:GetCurComp("events/RightBtn", "GameObject")
    end
    return self.mRightBtnGO
end

function UIPromptBloodSuitPanel:Init()
    CS.UIEventListener.Get(self:GetCloseButtonGO()).onClick = function()
        self:ClosePanel()
    end
    CS.EventDelegate.Add(self:GetCoinLeftUIToggle().onChange, function()
        if self:GetCoinLeftUIToggle().value then
            self:OnCoinToggleChanged(1)
        end
    end)
    CS.EventDelegate.Add(self:GetCoinRightUIToggle().onChange, function()
        if self:GetCoinRightUIToggle().value then
            self:OnCoinToggleChanged(2)
        end
    end)
    CS.UIEventListener.Get(self:GetLeftBtnGO()).onClick = function()
        self:OnCancelBtnClicked()
    end
    CS.UIEventListener.Get(self:GetRightBtnGO()).onClick = function()
        self:OnSubmitBtnClicked()
    end
end

---@param equipIndex number 装备位
---@param bloodSuitLattice TABLE.cfg_bloodsuit_lattice 血继格子解锁表数据
function UIPromptBloodSuitPanel:Show(equipIndex, bloodSuitLattice)
    self:GetContentLabel().text = "确认解锁该血继位？"
    self.equipIndex = equipIndex
    self.bloodSuitLattice = bloodSuitLattice
    self.costs = {}
    if self.bloodSuitLattice ~= nil and self.bloodSuitLattice:GetCost() ~= nil and self.bloodSuitLattice:GetCost().list ~= nil then
        for i = 1, #self.bloodSuitLattice:GetCost().list do
            local temp = self.bloodSuitLattice:GetCost().list[i].list
            if #temp >= 2 then
                table.insert(self.costs, temp)
            end
        end
    end
    self.costTypeCount = #self.costs
    if self.costTypeCount == 0 then
        self:ClosePanel()
        return
    end
    if self.costTypeCount == 1 then
        local pos = self:GetCoinLeftUIToggle().transform.localPosition
        pos.x = -30
        self:GetCoinLeftUIToggle().transform.localPosition = pos
        self:GetCoinLeftUIToggle().gameObject:SetActive(true)
        self:GetCoinRightUIToggle().gameObject:SetActive(false)

        self:RefreshCoin(self:GetCoinLeftUIToggle(), self:GetCoinLeftIconSprite(), self:GetCoinLeftAmountLabel(), self.costs[1][1], self.costs[1][2])
        self:GetCoinLeftUIToggle():Set(true, false)
    elseif self.costTypeCount == 2 then
        self:GetCoinLeftUIToggle().gameObject:SetActive(true)
        self:GetCoinRightUIToggle().gameObject:SetActive(true)

        local isSelectedOne = false
        if self:RefreshCoin(self:GetCoinLeftUIToggle(), self:GetCoinLeftIconSprite(), self:GetCoinLeftAmountLabel(), self.costs[1][1], self.costs[1][2]) then
            self:GetCoinLeftUIToggle():Set(true, false)
            isSelectedOne = true
        end
        if self:RefreshCoin(self:GetCoinRightUIToggle(), self:GetCoinRightIconSprite(), self:GetCoinRightAmountLabel(), self.costs[2][1], self.costs[2][2]) then
            if isSelectedOne == false then
                self:GetCoinRightUIToggle():Set(true, false)
                isSelectedOne = true
            end
        end
        --默认选择一个
        if isSelectedOne == false then
            self:GetCoinLeftUIToggle():Set(true, false)
        end
    end
end

---@private
---@param uiToggle UIToggle
---@param iconSprite UISprite
---@param amountLabel UILabel
---@param itemID number
---@param itemAmount number
---@return boolean 货币是否够用
function UIPromptBloodSuitPanel:RefreshCoin(uiToggle, iconSprite, amountLabel, itemID, itemAmount)
    local currentCoinAmount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(itemID)
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemID)
    iconSprite.spriteName = itemTbl:GetIcon()
    amountLabel.text = tostring(itemAmount)
    if itemAmount > currentCoinAmount then
        return false
    end
    return true
end

---货币开关变化事件
---@param coinIndex number 1:使用左边的货币 2:使用右边的货币
function UIPromptBloodSuitPanel:OnCoinToggleChanged(coinIndex)
    self.mSelectedIndex = coinIndex
    return
end

---解锁按钮点击事件
function UIPromptBloodSuitPanel:OnSubmitBtnClicked()
    if self.costs == nil or #self.costs <= 0 then
        return
    end
    local coinIndex = self.mSelectedIndex
    local itemID = self.costs[coinIndex][1]
    local itemAmount = self.costs[coinIndex][2]
    local currentCoinAmount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(itemID)
    if currentCoinAmount >= itemAmount then
        ---向服务器请求使用costindex解锁
        networkRequest.ReqOpenBloodSuitGrid(self.equipIndex, coinIndex - 1)
        self:ClosePanel()
    else
        local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemID)
        Utility.ShowPopoTips(self:GetRightBtnGO(), itemTbl:GetName() .. "数量不足", 205, "UIPromptBloodSuitPanel")
    end
end

---取消按钮点击事件
function UIPromptBloodSuitPanel:OnCancelBtnClicked()
    self:ClosePanel()
end

return UIPromptBloodSuitPanel