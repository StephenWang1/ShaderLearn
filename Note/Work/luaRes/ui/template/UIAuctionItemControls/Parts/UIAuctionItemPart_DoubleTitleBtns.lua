---双标题按钮
---@class UIAuctionItemPart_DoubleTitleBtns:UIAuctionItemPartsBase
local UIAuctionItemPart_DoubleTitleBtns = {}

setmetatable(UIAuctionItemPart_DoubleTitleBtns, luaComponentTemplates.AuctionItemPartBase)

function UIAuctionItemPart_DoubleTitleBtns:GetLeftBtn_Go()
    if self.mLeftBtnGo == nil then
        self.mLeftBtnGo = self:Get("right", "GameObject")
    end
    return self.mLeftBtnGo
end

function UIAuctionItemPart_DoubleTitleBtns:GetRightBtn_Go()
    if self.mRightBtnGo == nil then
        self.mRightBtnGo = self:Get("left", "GameObject")
    end
    return self.mRightBtnGo
end

---@return UIToggle
function UIAuctionItemPart_DoubleTitleBtns:GetLeftBtn_UIToggle()
    if self.mLeftBtnUIToggle == nil then
        self.mLeftBtnUIToggle = self:Get("right", "UIToggle")
    end
    return self.mLeftBtnUIToggle
end

---@return UIToggle
function UIAuctionItemPart_DoubleTitleBtns:GetRightBtn_UIToggle()
    if self.mRightBtnUIToggle == nil then
        self.mRightBtnUIToggle = self:Get("left", "UIToggle")
    end
    return self.mRightBtnUIToggle
end

function UIAuctionItemPart_DoubleTitleBtns:Init()
    local eventListener1 = CS.UIEventListener.Get(self:GetLeftBtn_Go())
    eventListener1.ClickIntervalTime = 0
    eventListener1.onClick = function(go)
        if self.mLeftClickedFunc then
            self.mLeftClickedFunc(go)
        end
    end
    local eventListener2 = CS.UIEventListener.Get(self:GetRightBtn_Go())
    eventListener2.ClickIntervalTime = 0
    eventListener2.onClick = function(go)
        if self.mRightClickedFunc then
            self.mRightClickedFunc(go)
        end
    end
end

function UIAuctionItemPart_DoubleTitleBtns:BindEvents(leftClick, rightClicked)
    self.mLeftClickedFunc = leftClick
    self.mRightClickedFunc = rightClicked
end

function UIAuctionItemPart_DoubleTitleBtns:SetToggleState(isLeft)
    self:GetLeftBtn_UIToggle():Set(isLeft)
    self:GetRightBtn_UIToggle():Set(not isLeft)
end

function UIAuctionItemPart_DoubleTitleBtns:ResetAll()
    self.mLeftClickedFunc = nil
    self.mRightClickedFunc = nil
end

return UIAuctionItemPart_DoubleTitleBtns