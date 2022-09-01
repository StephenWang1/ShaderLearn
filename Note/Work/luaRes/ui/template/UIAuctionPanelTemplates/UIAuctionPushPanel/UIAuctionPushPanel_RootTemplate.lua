---推送总模板
---@class UIAuctionPushPanel_RootTemplate:TemplateBase
local UIAuctionPushPanel_RootTemplate = {}

---@param csData auctionV2.pushResponse
function UIAuctionPushPanel_RootTemplate:Init(csData)
    self.PushData = csData
    ---@type bagV2.BagItemInfo
    self.BagItemInfo = csData.item
    ---@type TABLE.CFG_ITEMS
    self.ItemInfo = self.BagItemInfo.ItemTABLE
    if self.ItemInfo == nil then
        ___, self.ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.BagItemInfo.itemId)
    end
    self:InitComponent()
    self:BindEvents()
    self:ShowItem()
    self.mToggleValue_UIToggle.gameObject:SetActive(self:NeedShowToggle())
end

--region 用于重写
---点击按钮
function UIAuctionPushPanel_RootTemplate:OnClickCenterButton()
end

function UIAuctionPushPanel_RootTemplate:OnToggleChange(isChoose)
end

function UIAuctionPushPanel_RootTemplate:NeedShowToggle()
    return false
end
--endregion

--region 用于调用
---是否是上架推送
function UIAuctionPushPanel_RootTemplate:IsShelvePush(isShelvePush)
    self.shelvesRoot:SetActive(isShelvePush)
    self.buyRoot:SetActive(not isShelvePush)
end
--endregion

function UIAuctionPushPanel_RootTemplate:InitComponent()
    ---@type UISprite 标题
    self.title_UILabel = self:Get("title", "UISprite")
    --region 道具
    ---道具节点
    ---@type UnityEngine.GameObject
    self.itemRoot_GameObject = self:Get("UIItem", "GameObject")

    ---道具icon节点
    ---@type UnityEngine.GameObject
    self.icon_GameObject = self:Get("UIItem/icon", "GameObject")

    ---道具icon
    ---@type UISprite
    self.icon_UISprite = self:Get("UIItem/icon", "UISprite")
    --endregion
    --region上架
    --上架节点
    ---上架节点
    ---@type UnityEngine.GameObject
    self.shelvesRoot = self:Get("SellShow", "GameObject")
    --上架价格
    ---上架价格节点
    ---@type UnityEngine.GameObject
    self.price_GameObject = self:Get("SellShow/Price", "GameObject")
    ---价格文本
    ---@type UILabel
    self.price_UILabel = self:Get("SellShow/Price/price", "UILabel")
    ---价格名字
    ---@type UILabel
    self.priceName_UILabel = self:Get("SellShow/Price/label", "UILabel")
    ---价格icon
    ---@type UISprite
    self.price_UISprite = self:Get("SellShow/Price/icon", "UISprite")
    --上架显示
    self.shelvesShowLabel = self:Get("SellShow/showLabal1", "UILabel")
    --endregion
    --region购买
    --购买节点
    self.buyRoot = self:Get("BuyShow", "GameObject")
    --购买显示
    self.buyShowLabel = self:Get("BuyShow/showLabel", "UILabel")
    --endregion
    --按钮
    self.mCenterButton_GameObject = self:Get("MiddleBtn", "GameObject")
    self.mCenterButton_UILabel = self:Get("MiddleBtn/Label", "UILabel")
    ---@type UIToggle
    self.mToggleValue_UIToggle = self:Get("toggle_value", "UIToggle")
end

function UIAuctionPushPanel_RootTemplate:BindEvents()
    CS.UIEventListener.Get(self.mCenterButton_GameObject).onClick = function()
        self:OnClickCenterButton()
    end
    CS.UIEventListener.Get(self.icon_GameObject).onClick = function()
        self:OnItemClicked()
    end
    CS.EventDelegate.Add(self.mToggleValue_UIToggle.onChange, function()
        self:OnToggleChange(self.mToggleValue_UIToggle.value)
    end)
end

---显示道具
function UIAuctionPushPanel_RootTemplate:ShowItem()
    if self.ItemInfo then
        self.icon_UISprite.spriteName = self.ItemInfo.icon
    end
end

---显示Tips
function UIAuctionPushPanel_RootTemplate:OnItemClicked()
    if self.BagItemInfo and self.ItemInfo then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.BagItemInfo, showAssistPanel = true })
    end
end

return UIAuctionPushPanel_RootTemplate


