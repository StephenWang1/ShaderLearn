---选项框
---@class UIAuctionItemPart_Toggle:UIAuctionItemPartsBase
local UIAuctionItemPart_Toggle = {}

setmetatable(UIAuctionItemPart_Toggle, luaComponentTemplates.AuctionItemPartBase)

---获取开关组件
---@return UIToggle
function UIAuctionItemPart_Toggle:GetToggle()
    if self.mToggle == nil then
        self.mToggle = self:Get("Publicity", "UIToggle")
    end
    return self.mToggle
end

---获取内容文本组件
---@return UILabel
function UIAuctionItemPart_Toggle:GetShowingLabel()
    if self.mShowingLabel == nil then
        self.mShowingLabel = self:Get("Label", "UILabel")
    end
    return self.mShowingLabel
end

---获取当前开关状态
function UIAuctionItemPart_Toggle:GetValue()
    return self.mValue or false
end

function UIAuctionItemPart_Toggle:Init()
    CS.EventDelegate.Add(self:GetToggle().onChange, function()
        self.mValue = self:GetToggle().value
        if self.mStateCallBack ~= nil then
            self.mStateCallBack()
        end
    end)
end

---初始化
---@param isInitOpened boolean
---@param content string
---@param stateChangeCallback fun
function UIAuctionItemPart_Toggle:Initialize(isInitOpened, content, stateChangeCallback)
    self:GetShowingLabel().text = content
    self:GetToggle().value = isInitOpened
    self.mValue = isInitOpened
    self.mStateCallBack = stateChangeCallback
end

---设置值
function UIAuctionItemPart_Toggle:SetValue(state)
    if state == nil then
        state = false
    end

end

function UIAuctionItemPart_Toggle:ResetAll()
    self:GetShowingLabel().text = ""
    self:GetToggle().value = false
    self.mValue = false
    self.mStateCallBack = nil
end

return UIAuctionItemPart_Toggle