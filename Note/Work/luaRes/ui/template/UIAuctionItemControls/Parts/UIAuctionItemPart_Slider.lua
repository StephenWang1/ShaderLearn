---滑动条
---@class UIAuctionItemPart_Slider:UIAuctionItemPartsBase
local UIAuctionItemPart_Slider = {}

setmetatable(UIAuctionItemPart_Slider, luaComponentTemplates.AuctionItemPartBase)

---获取进度条
---@private
---@return UISlider
function UIAuctionItemPart_Slider:GetSlider()
    if self.mSlider == nil then
        self.mSlider = self:Get("", "UISlider")
    end
    return self.mSlider
end

---获取当前数值(非百分比)
---@return number
function UIAuctionItemPart_Slider:GetCurrentValue()
    return self.mValue
end

function UIAuctionItemPart_Slider:Init()
    self.mMinNumber = 0
    self.mMaxNumber = 1
    self.mValue = 0
    self:GetSlider().value = 0
    CS.EventDelegate.Add(self:GetSlider().onChange, function()
        if self.mIsSettingInputInternal then
            return
        end
        self:OnSliderChanged()
    end)
end

---初始化
---@param minNumber number 最小值
---@param maxNumber number 最大值
---@param changeCallback fun
function UIAuctionItemPart_Slider:Initialize(minNumber, maxNumber, changeCallback)
    self.mMinNumber = minNumber ~= nil and minNumber or 0
    self.mMaxNumber = maxNumber ~= nil and maxNumber or 0
    self.mChangeCallback = changeCallback
    self.mValue = self.mMinNumber + self:GetSlider().value * (self.mMaxNumber - self.mMinNumber)
end

---重置状态数据
function UIAuctionItemPart_Slider:ResetValue(minNumber, maxNumber)
    self:GetSlider().value = 0
    self.mMinNumber = minNumber ~= nil and minNumber or 0
    self.mMaxNumber = maxNumber ~= nil and maxNumber or 0
    self.mValue = self.mMinNumber + self:GetSlider().value * (self.mMaxNumber - self.mMinNumber)
end

---设置值(数值,非百分比)
---@param value number
function UIAuctionItemPart_Slider:SetValue(value)
    if value == nil then
        return
    end
    if self.mMinNumber == self.mMaxNumber then
        return
    end
    self:GetSlider().value = (value - self.mMinNumber) / (self.mMaxNumber - self.mMinNumber)
end

---@private
function UIAuctionItemPart_Slider:OnSliderChanged()
    self.mValue = self.mMinNumber + self:GetSlider().value * (self.mMaxNumber - self.mMinNumber)
    if self.mChangeCallback ~= nil then
        self.mChangeCallback()
    end
end

function UIAuctionItemPart_Slider:ResetAll()
    self:GetSlider().value = 0
    self.mMinNumber = 0
    self.mMaxNumber = 0
    self.mValue = 0
    self.mChangeCallback = nil
end

return UIAuctionItemPart_Slider