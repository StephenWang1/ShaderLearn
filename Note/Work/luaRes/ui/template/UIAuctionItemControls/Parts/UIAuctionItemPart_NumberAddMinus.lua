---数量增减
---@class UIAuctionItemPart_NumberAddMinus:UIAuctionItemPartsBase
local UIAuctionItemPart_NumberAddMinus = {}

setmetatable(UIAuctionItemPart_NumberAddMinus, luaComponentTemplates.AuctionItemPartBase)

---数字的标题文本
---@return UILabel
function UIAuctionItemPart_NumberAddMinus:GetNumberTitleLabel()
    if self.mNumberTitleLabel == nil then
        self.mNumberTitleLabel = self:Get("lb_number", "UILabel")
    end
    return self.mNumberTitleLabel
end

---数字输入框
---@return UIInput
function UIAuctionItemPart_NumberAddMinus:GetNumberInput()
    if self.mNumberInput == nil then
        self.mNumberInput = self:Get("inputcount", "UIInput")
    end
    return self.mNumberInput
end

---减少按钮
---@return UnityEngine.GameObject
function UIAuctionItemPart_NumberAddMinus:GetReduceButtonGO()
    if self.mReduceButtonGO == nil then
        self.mReduceButtonGO = self:Get("reduce", "GameObject")
    end
    return self.mReduceButtonGO
end

---增加按钮
---@return UnityEngine.GameObject
function UIAuctionItemPart_NumberAddMinus:GetAddButtonGO()
    if self.mAddButtonGO == nil then
        self.mAddButtonGO = self:Get("add", "GameObject")
    end
    return self.mAddButtonGO
end

---数字输入框
---@return UIInput
function UIAuctionItemPart_NumberAddMinus:GetNumberInput_Box()
    if self.mNumberInputBox == nil then
        self.mNumberInputBox = self:Get("inputcount", "BoxCollider")
    end
    return self.mNumberInputBox
end

---减少按钮
---@return UnityEngine.GameObject
function UIAuctionItemPart_NumberAddMinus:GetReduceButton_Box()
    if self.mReduceButtonBox == nil then
        self.mReduceButtonBox = self:Get("reduce", "BoxCollider")
    end
    return self.mReduceButtonBox
end

---增加按钮
---@return UnityEngine.GameObject
function UIAuctionItemPart_NumberAddMinus:GetAddButton_Box()
    if self.mAddButtonBox == nil then
        self.mAddButtonBox = self:Get("add", "BoxCollider")
    end
    return self.mAddButtonBox
end

---获取当前数量
---@return number
function UIAuctionItemPart_NumberAddMinus:GetCurrentNumber()
    return self.currentNumber
end

function UIAuctionItemPart_NumberAddMinus:Init()
    self.minNumber = 0
    self.maxNumber = 0
    self.canAddToMin = false
    self.canMinusToMax = false
    self.currentNumber = -1
    self:GetNumberInput().submitOnUnselect = true
    CS.EventDelegate.Add(self:GetNumberInput().onSubmit, function()
        if self.mIsSettingInputInternal then
            return
        end
        self:OnNumberInputChanged()
    end)
    local eventListener1 = CS.UIEventListener.Get(self:GetAddButtonGO())
    eventListener1.ClickIntervalTime = 0
    eventListener1.onClick = function()
        self:OnAddButtonClicked()
    end
    local eventListener2 = CS.UIEventListener.Get(self:GetReduceButtonGO())
    eventListener2.ClickIntervalTime = 0
    eventListener2.onClick = function()
        self:OnMinusButtonClicked()
    end
end

---初始化
---@param titleName string 标题
---@param minNumber number 最小数目,默认为0
---@param maxNumber number 最大数目,默认为0
---@param canAddToMin boolean 是否可以由最大值增加到最小值,默认为false
---@param canMinusToMax boolean 是否可以由最小值减少到最大值,默认为false
---@param currentNumber number 当前数目,若数目为nil则默认为最小值
function UIAuctionItemPart_NumberAddMinus:Initialize(titleName, minNumber, maxNumber, canAddToMin, canMinusToMax, currentNumber)
    self:GetNumberTitleLabel().text = titleName
    self.minNumber = minNumber ~= nil and minNumber or 0
    self.maxNumber = maxNumber ~= nil and maxNumber or 0
    if self.minNumber > self.maxNumber then
        ---修正最大值和最小值的顺序
        local temp = self.minNumber
        self.minNumber = self.maxNumber
        self.maxNumber = temp
    end
    self.canAddToMin = canAddToMin ~= nil and canAddToMin or false
    self.canMinusToMax = canMinusToMax ~= nil and canMinusToMax or false
    self:SetCurrentNumber(currentNumber ~= nil and currentNumber or self.minNumber)
end

function UIAuctionItemPart_NumberAddMinus:SetColliderState(state)
    self:GetAddButton_Box().enabled = state
    self:GetReduceButton_Box().enabled = state
    self:GetNumberInput_Box().enabled = state
end

---绑定事件
---@param numberChanged fun
function UIAuctionItemPart_NumberAddMinus:BindEvents(numberChanged)
    ---@private
    self.mOnNumberChangedEvent = numberChanged
end

---设置当前数量
---@param number number
function UIAuctionItemPart_NumberAddMinus:SetCurrentNumber(number)
    if number == nil then
        return
    end
    number = math.clamp(number, self.minNumber, self.maxNumber)
    if number == self.currentNumber then
        return
    end
    self.currentNumber = number
    self:SetInputLabelInternal(tostring(self.currentNumber), true)
    if self.mOnNumberChangedEvent ~= nil then
        self.mOnNumberChangedEvent()
    end
end

---@private
function UIAuctionItemPart_NumberAddMinus:SetInputLabelInternal(textContent)
    if textContent == nil then
        return
    end
    ---@private
    self.mIsSettingInputInternal = true
    self:GetNumberInput().text = textContent
    self.mIsSettingInputInternal = false
end

---输入的数字变化事件
---@private
function UIAuctionItemPart_NumberAddMinus:OnNumberInputChanged()
    local textTemp = self:GetNumberInput().text
    local number = tonumber(textTemp)
    if number == nil then
        return
    end
    if number < self.minNumber then
        self:GetNumberInput().text = self.minNumber
    elseif number > self.maxNumber then
        self:GetNumberInput().text = self.maxNumber
    end

    self:SetCurrentNumber(number)
end

---增加按钮点击事件
---@private
function UIAuctionItemPart_NumberAddMinus:OnAddButtonClicked()
    local number = self.currentNumber + 1
    if number > self.maxNumber and self.canAddToMin then
        number = self.minNumber
    end
    self:SetCurrentNumber(number)
end

---减少按钮点击事件
---@private
function UIAuctionItemPart_NumberAddMinus:OnMinusButtonClicked()
    local number = self.currentNumber - 1
    if number < self.minNumber and self.canMinusToMax then
        number = self.maxNumber
    end
    self:SetCurrentNumber(number)
end

function UIAuctionItemPart_NumberAddMinus:ResetAll()
    self:SetColliderState(true)
    self.minNumber = 0
    self.maxNumber = 0
    self.canAddToMin = false
    self.canMinusToMax = false
    self.currentNumber = -1
    self.mOnNumberChangedEvent = nil
end

return UIAuctionItemPart_NumberAddMinus