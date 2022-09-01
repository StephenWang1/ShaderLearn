---转移装备格子模板
---@class UIForgeTransferPanel_TransferGrid
local UIForgeTransferPanel_TransferGrid = {}

function UIForgeTransferPanel_TransferGrid:Init()
    self:InitComponent()
end

function UIForgeTransferPanel_TransferGrid:InitComponent()
    self.item_GameObject = self:Get("Item", "GameObject")
    self.strengthen_UILabel = self:Get("Item/strengthen", "UILabel")
    self.star_UISprite = self:Get("Item/star", "UISprite")
    self.icon_UISprite = self:Get("Item/icon", "UISprite")

    self.add_GameObject = self:Get("Add", "GameObject")
    self.lock_GameObject = self:Get("Lock", "GameObject")
end

function UIForgeTransferPanel_TransferGrid:RefreshItem(bagItemInfo, type)
    ---@type number
    self.Type = type
    ---@type bagV2.BagItemInfo
    self.BagItemInfo = bagItemInfo
    if self.Type then
        self:ShowItem()
    end
    if self.BagItemInfo then
        ___, self.ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.BagItemInfo.itemId)
    end
    self:ShowItemInfo()
end

---显示状态
function UIForgeTransferPanel_TransferGrid:ShowItem()
    if CS.StaticUtility.IsNull(self.lock_GameObject) == false then
        self.lock_GameObject:SetActive(self.Type == LuaEnumForgeTransferType.Lock)
    end
    if CS.StaticUtility.IsNull(self.add_GameObject) == false then
        self.add_GameObject:SetActive(self.Type == LuaEnumForgeTransferType.Add)
    end
    if CS.StaticUtility.IsNull(self.item_GameObject) == false then
        self.item_GameObject:SetActive(self.Type == LuaEnumForgeTransferType.Normal)
    end
end

---显示Item信息
function UIForgeTransferPanel_TransferGrid:ShowItemInfo()
    local icon = ""
    if self.ItemInfo then
        icon = self.ItemInfo.icon
    end
    self.icon_UISprite.spriteName = icon
    local isShow = self.BagItemInfo and self.BagItemInfo.intensify > 0
    if isShow then
        local strength, icon = Utility.GetIntensifyShow(self.BagItemInfo.intensify)
        self.strengthen_UILabel.text = strength
        self.star_UISprite.spriteName = icon
    end
    self.strengthen_UILabel.gameObject:SetActive(isShow)
    self.star_UISprite.gameObject:SetActive(isShow)
end

return UIForgeTransferPanel_TransferGrid