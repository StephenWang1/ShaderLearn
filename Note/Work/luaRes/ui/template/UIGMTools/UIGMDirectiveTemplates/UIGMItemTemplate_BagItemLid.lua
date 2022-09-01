local UIGMItemTemplate_BagItemLid = {}
setmetatable(UIGMItemTemplate_BagItemLid, luaComponentTemplates.UIGMItemTemplate)
function UIGMItemTemplate_BagItemLid:GetIndex_UILabel()
    if self.mIndex_UILabel == nil then
        self.mIndex_UILabel = self:Get("index", "UILabel")
    end
    return self.mIndex_UILabel
end

--region 界面
function UIGMItemTemplate_BagItemLid:ReFreshUI(bagItemInfo)
    self.bagItemInfo = bagItemInfo
    local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(bagItemInfo.itemId)
    if itemInfoIsFind then
        self.itemInfo = itemInfo
    end
    self:RefreshIcon()
    self:RefreshName()
    self:RefreshLid()
    self:RefreshGridIndex()
end

function UIGMItemTemplate_BagItemLid:RefreshIcon()
    if self.itemInfo ~= nil and self.icon_UISprite ~= nil then
        self.icon_UISprite.spriteName = self.itemInfo.icon
    end
end

function UIGMItemTemplate_BagItemLid:RefreshName()
    if self.itemInfo ~= nil and self.name_UILabel ~= nil then
        self.name_UILabel.text = self.itemInfo.name .. " : " .. tostring(self.itemInfo.id)
    end
end

function UIGMItemTemplate_BagItemLid:RefreshLid()
    if self.bagItemInfo ~= nil and self.id_UILabel ~= nil then
        self.id_UILabel.text = tostring(self.bagItemInfo.lid)
    end
end

function UIGMItemTemplate_BagItemLid:RefreshGridIndex()
    if self.bagItemInfo ~= nil and self:GetIndex_UILabel() ~= nil then
        self:GetIndex_UILabel().text = tostring(self.bagItemInfo.bagIndex + 1)
    end
end
--endregion
return UIGMItemTemplate_BagItemLid