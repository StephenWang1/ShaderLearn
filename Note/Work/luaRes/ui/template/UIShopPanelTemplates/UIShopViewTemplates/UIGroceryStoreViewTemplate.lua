local UIGroceryStoreViewTemplate = {};

setmetatable(UIGroceryStoreViewTemplate, luaComponentTemplates.UIShopViewTemplate)

function UIGroceryStoreViewTemplate:SetShopShow(shopType)
    if(self.mSelectShopType == shopType) then
        return;
    end
    CS.CSScene.MainPlayerInfo.StoreInfoV2:TryGetStore(shopType, function()
        local isFindShop, shopVo = CS.CSScene.MainPlayerInfo.StoreInfoV2.StoreDataDic:TryGetValue(shopType);
        if(isFindShop) then
            self.selectShopType = shopType;
            local listData = SplitToList(shopVo.storeUnitDic, 999);
            self:GetPageViewTemplate():Initialize(999, shopVo.storeUnitDic.Count, listData, luaComponentTemplates.UIShopPageUnitTemplate);

            if(self.mIsResetPageScrollView) then
                self.mIsResetPageScrollView = false;
                self:GetPageViewTemplate():GetScrollView():ResetPosition();
            end
        end
    end)
end

return UIGroceryStoreViewTemplate;