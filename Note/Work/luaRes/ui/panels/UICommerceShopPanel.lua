---@class UICommerceShopPanel:UIBase
local UICommerceShopPanel = {};

local this = nil;

UICommerceShopPanel.mSelectStoreType = nil;

--region Components

function UICommerceShopPanel:GetNotHasShop_GameObject()
    if (this.mNotHasShop_GameObject == nil) then
        this.mNotHasShop_GameObject = this:GetCurComp("WidgetRoot/window/notHas", "GameObject");
    end
    return this.mNotHasShop_GameObject;
end

function UICommerceShopPanel:GetIntegralBackGround_GameObject()
    if (this.mIntegralBackGround_GameObject == nil) then
        this.mIntegralBackGround_GameObject = this:GetCurComp("WidgetRoot/events/btn_integralShop/Background", "GameObject")
    end
    return this.mIntegralBackGround_GameObject;
end

function UICommerceShopPanel:GetDiamondBackGround_GameObject()
    if (this.mDiamondBackGround_GameObject == nil) then
        this.mDiamondBackGround_GameObject = this:GetCurComp("WidgetRoot/events/btn_diamondShop/Background", "GameObject")
    end
    return this.mDiamondBackGround_GameObject;
end

function UICommerceShopPanel:GetBtnIntegral_GameObject()
    if (this.mBtnIntegral_GameObject == nil) then
        this.mBtnIntegral_GameObject = this:GetCurComp("WidgetRoot/events/btn_integralShop", "GameObject")
    end
    return this.mBtnIntegral_GameObject;
end

function UICommerceShopPanel:GetBtnDiamond_GameObject()
    if (this.mBtnDiamond_GameObject == nil) then
        this.mBtnDiamond_GameObject = this:GetCurComp("WidgetRoot/events/btn_diamondShop", "GameObject")
    end
    return this.mBtnDiamond_GameObject;
end

function UICommerceShopPanel:GetBtnClose_GameObject()
    if (this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/events/btn_close", "GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UICommerceShopPanel:GetShopViewTemplate_GameObject()
    if (this.mShopViewTemplate_GameObject == nil) then
        this.mShopViewTemplate_GameObject = this:GetCurComp("WidgetRoot/integralShop", "GameObject");
    end
    return this.mShopViewTemplate_GameObject;
end

function UICommerceShopPanel:GetTglIntegral_UIToggle()
    if (this.mTglIntegral_UIToggle == nil) then
        this.mTglIntegral_UIToggle = this:GetCurComp("WidgetRoot/events/btn_integralShop", "UIToggle")
    end
    return this.mTglIntegral_UIToggle;
end

function UICommerceShopPanel:GetTglDiamond_UIToggle()
    if (this.mTglDiamond_UIToggle == nil) then
        this.mTglDiamond_UIToggle = this:GetCurComp("WidgetRoot/events/btn_diamondShop", "UIToggle");
    end
    return this.mTglDiamond_UIToggle;
end

function UICommerceShopPanel:GetShopViewTemplate()
    if (this.mShopViewTemplate == nil) then
        this.mShopViewTemplate = templatemanager.GetNewTemplate(this:GetShopViewTemplate_GameObject(), luaComponentTemplates.UICommerceShopViewTemplate, self)
    end
    return this.mShopViewTemplate;
end

--endregion

--region Method

--region Public

function UICommerceShopPanel:SelectStore(type)
    this.mSelectStoreType = type;
    if (type == LuaEnumStoreType.CommerceIntegral) then
        this:GetTglIntegral_UIToggle().isChecked = true;
        this:GetIntegralBackGround_GameObject():SetActive(false);
        this:GetDiamondBackGround_GameObject():SetActive(true);
    elseif (type == LuaEnumStoreType.CommerceDiamond) then
        this:GetTglDiamond_UIToggle().isChecked = true;
        this:GetIntegralBackGround_GameObject():SetActive(true);
        this:GetDiamondBackGround_GameObject():SetActive(false);
    end
    this:GetShopViewTemplate():OpenStoreById(type);
end

--endregion

--region Private

function UICommerceShopPanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnIntegral_GameObject()).onClick = function()
        this:SelectStore(LuaEnumStoreType.CommerceIntegral);
    end

    CS.UIEventListener.Get(this:GetBtnDiamond_GameObject()).onClick = function()
        this:SelectStore(LuaEnumStoreType.CommerceDiamond);
    end

    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UICommerceShopPanel");
    end
end

function UICommerceShopPanel:RemoveEvents()

end

--endregion

--endregion

function UICommerceShopPanel:Init()
    --self:AddCollider()
    this = self;

    this:InitEvents();
end

function UICommerceShopPanel:Show(firstParam, secondParam, thirdParam, customData)
    if (customData == nil) then
        customData = {};
    end
    if (customData.type == nil) then
        customData.type = LuaEnumStoreType.CommerceDiamond;
    end
    this:SelectStore(customData.type);
end

function ondestroy()
    this:RemoveEvents();

    this = nil;
end

return UICommerceShopPanel;