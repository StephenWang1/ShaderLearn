---货币输入框
---@class UIAuctionItemPart_CoinInput:UIAuctionItemPartsBase
local UIAuctionItemPart_CoinInput = {}

setmetatable(UIAuctionItemPart_CoinInput, luaComponentTemplates.AuctionItemPartBase)

---获取标题文本组件
---@return UILabel
function UIAuctionItemPart_CoinInput:GetTitleLabel()
    if self.mTitleLabel == nil then
        self.mTitleLabel = self:Get("Label", "UILabel")
    end
    return self.mTitleLabel
end

---获取货币icon的Sprite组件
---@return UISprite
function UIAuctionItemPart_CoinInput:GetCoinIconSprite()
    if self.mCoinIconSprite == nil then
        self.mCoinIconSprite = self:Get("Sprite", "UISprite")
    end
    return self.mCoinIconSprite
end

---获取货币数量的Label组件
---@return UILabel
function UIAuctionItemPart_CoinInput:GetCoinNumberLabel()
    if self.mCoinNumberLabel == nil then
        self.mCoinNumberLabel = self:Get("gold", "UILabel")
    end
    return self.mCoinNumberLabel
end

---@return UIInput 货币输入
function UIAuctionItemPart_CoinInput:GetCoinInput_UIInput()
    if self.mCoinInput == nil then
        self.mCoinInput = self:Get("inputcount", "UIInput")
    end
    return self.mCoinInput
end

---@return UnityEngine.BoxCollider 货币输入
function UIAuctionItemPart_CoinInput:GetCoinInput_BoxCollider()
    if self.mCoinInputBoxCollider == nil then
        self.mCoinInputBoxCollider = self:Get("inputcount", "BoxCollider")
    end
    return self.mCoinInputBoxCollider
end

---初始化
---@param titleContent string
---@param coinItemTbl TABLE.CFG_ITEMS
---@param content string
function UIAuctionItemPart_CoinInput:Initialize(titleContent, coinItemTbl, content)
    self:GetTitleLabel().text = titleContent
    self:Refresh(coinItemTbl, content)
end

---刷新
---@param coinItemTbl TABLE.CFG_ITEMS
---@param content string
function UIAuctionItemPart_CoinInput:Refresh(coinItemTbl, content)
    self:RefreshItem(coinItemTbl)
    self:RefreshContent(content)
end

---开启价格输入框
function UIAuctionItemPart_CoinInput:OpenInput(isOpen, numChangeFunc)
    self:GetCoinInput_BoxCollider().enabled = false
    self:GetCoinInput_UIInput().gameObject:SetActive(isOpen)
    self:GetCoinNumberLabel().gameObject:SetActive(not isOpen)
    self:GetCoinInput_UIInput().submitOnUnselect = true
    CS.EventDelegate.Add(self:GetCoinInput_UIInput().onSubmit, function()
        if numChangeFunc then
            numChangeFunc(tonumber(self:GetCoinInput_UIInput().value), self:GetCoinInput_UIInput())
        end
    end)
    self.mOpenInput = isOpen
end

---刷新物品表数据
---@param coinItemTbl TABLE.CFG_ITEMS
function UIAuctionItemPart_CoinInput:RefreshItem(coinItemTbl)
    if coinItemTbl == nil then
        return
    end
    self:GetCoinIconSprite().spriteName = coinItemTbl.icon
end

---刷新数量
---@param content string
function UIAuctionItemPart_CoinInput:RefreshContent(content)
    if content == nil then
        return
    end
    if self.mOpenInput then
        self:GetCoinInput_UIInput().value = content
    else
        if content == nil then
            self:GetCoinNumberLabel().text = ""
        else
            self:GetCoinNumberLabel().text = tostring(content)
        end
    end
end

function UIAuctionItemPart_CoinInput:ResetAll()
    self:GetCoinNumberLabel().text = ""
    self:GetTitleLabel().text = ""
    self:GetCoinIconSprite().spriteName = ""
end

return UIAuctionItemPart_CoinInput