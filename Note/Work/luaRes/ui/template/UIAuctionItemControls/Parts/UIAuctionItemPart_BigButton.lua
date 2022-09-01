---@class UIAuctionItemPart_BigButton:UIAuctionItemPartsBase
local UIAuctionItemPart_BigButton = {}

setmetatable(UIAuctionItemPart_BigButton, luaComponentTemplates.AuctionItemPartBase)

---按钮文字组件
---@return UILabel
function UIAuctionItemPart_BigButton:GetButtonLabel()
    if self.mButtonLabel == nil then
        self.mButtonLabel = self:Get("Label", "UILabel")
    end
    return self.mButtonLabel
end

---初始化
---@param buttonLabelContent string
---@param buttonClickCallBack fun
function UIAuctionItemPart_BigButton:Initialize(buttonLabelContent, buttonClickCallBack)
    self:GetButtonLabel().text = buttonLabelContent
    CS.UIEventListener.Get(self.go).onClick = function()
        if buttonClickCallBack ~= nil then
            buttonClickCallBack()
        end
    end
end

function UIAuctionItemPart_BigButton:ResetAll()

end

return UIAuctionItemPart_BigButton