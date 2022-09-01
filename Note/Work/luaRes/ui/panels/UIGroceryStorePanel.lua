local UIGroceryStorePanel = {};

local this = nil;

--region Components

function UIGroceryStorePanel:GetBtnClose_GameObject()
    if (this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return this.mBtnClose_GameObject;
end

function UIGroceryStorePanel:GetShopView_GameObject()
    if (this.mShopView_GameObject == nil) then
        this.mShopView_GameObject = this:GetCurComp("WidgetRoot/Sale", "GameObject");
    end
    return this.mShopView_GameObject;
end

function UIGroceryStorePanel:GetShopViewTemplate()
    if (this.mShopViewTemplate == nil) then
        this.mShopViewTemplate = templatemanager.GetNewTemplate(this:GetShopView_GameObject(), luaComponentTemplates.UIGroceryStoreViewTemplate, self);
    end
    return this.mShopViewTemplate;
end

--endregion

--region Method

--region Private

function UIGroceryStorePanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIGroceryStorePanel");
    end
end

function UIGroceryStorePanel:RemoveEvents()

end

--endregion

--endregion

function UIGroceryStorePanel:Init()
    this = self;
    this:InitEvents();
end

function UIGroceryStorePanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end

    this:GetShopViewTemplate():OpenStoreById(LuaEnumStoreType.GroceryStore);
end

function ondestroy()
    this:RemoveEvents();
    this = nil;
end

return UIGroceryStorePanel;