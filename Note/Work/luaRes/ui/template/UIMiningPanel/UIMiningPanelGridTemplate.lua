---@class UIMiningPanelGridTemplate 挖矿格子模板
local UIMiningPanelGridTemplate = {}

function UIMiningPanelGridTemplate:Init()
    self:InitComponent()

    self:BindEvents()
end

function UIMiningPanelGridTemplate:InitComponent()
    ---@type UISprite
    self.icon_UISprite = self:Get("Icon", "UISprite")
    self.name_UILabel = self:Get("Name", "UILabel")
    self.num_UILabel = self:Get("Count", "UILabel")
end

function UIMiningPanelGridTemplate:BindEvents()
    CS.UIEventListener.Get(self.go).onClick = function()
        self:CreateTips()
    end
end

function UIMiningPanelGridTemplate:RefreshInfo(ItemId, num)
    ___, self.ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(ItemId)
    self:RefreshItem()
    self:RefreshNum(num)
end

---刷新基础信息显示
function UIMiningPanelGridTemplate:RefreshItem()
    if self.ItemInfo then
        self.icon_UISprite.spriteName = self.ItemInfo.icon
        self.name_UILabel.text = self.ItemInfo.name
    end
end

---刷新数量显示
function UIMiningPanelGridTemplate:RefreshNum(num)
    self.num_UILabel.text = num
end

---创建Tips
function UIMiningPanelGridTemplate:CreateTips()
    if self.ItemInfo then
        uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = self.ItemInfo})
    end
end

return UIMiningPanelGridTemplate