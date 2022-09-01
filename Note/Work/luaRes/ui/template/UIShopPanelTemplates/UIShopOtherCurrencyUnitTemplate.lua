local UIShopOtherCurrencyUnitTemplate = {};

UIShopOtherCurrencyUnitTemplate.mItemTable = nil;

--region Components

function UIShopOtherCurrencyUnitTemplate:GetIconUISprite_UISprite()
    if(self.mIconUISprite_UISprite == nil) then
        self.mIconUISprite_UISprite = self:Get("type", "UISprite");
    end
    return self.mIconUISprite_UISprite;
end

function UIShopOtherCurrencyUnitTemplate:GetValueLabel_UILabel()
    if(self.mValueLabel_UILabel == nil) then
        self.mValueLabel_UILabel = self:Get("value", "UILabel");
    end
    return self.mValueLabel_UILabel;
end

--endregion

--region Method

--region Public

function UIShopOtherCurrencyUnitTemplate:UpdateUnit(itemId, count)
    local isFindItem, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
    if(isFindItem) then
        self.mItemTable = itemTable;
        self:GetIconUISprite_UISprite().spriteName = self.mItemTable.icon;
        self:GetValueLabel_UILabel().text = count;
    end
end

--endregion

--region Private

function UIShopOtherCurrencyUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetIconUISprite_UISprite().gameObject).onClick = function()
        if(self.mItemTable ~= nil) then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.mItemTable })
        end
    end
end

--endregion

--endregion

function UIShopOtherCurrencyUnitTemplate:Init()
    self:InitEvents();
end

return UIShopOtherCurrencyUnitTemplate;