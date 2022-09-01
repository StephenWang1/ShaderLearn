---@class UICommerceShopPageUnitTemplate:UIShopPageUnitTemplate
local UICommerceShopPageUnitTemplate = {};

setmetatable(UICommerceShopPageUnitTemplate, luaComponentTemplates.UIShopPageUnitTemplate);

--region Override

function UICommerceShopPageUnitTemplate:OnResSendStoreInfoChangeMessage(id, tableData)
    local storeId = tableData.storeInfo.storeId;
    if (self.mShopUnitDic ~= nil) then
        for k, v in pairs(self.mShopUnitDic) do
            if (v:GetStoreId() == storeId) then
                local storeUnitVo = CS.CSScene.MainPlayerInfo.StoreInfoV2:GetStoreInfo(storeId);
                v:SetViewUnit(storeUnitVo);
                break ;
            end
        end
    end
end

function UICommerceShopPageUnitTemplate:GetShopUnitTemplate()
    return luaComponentTemplates.UICommerceShopUnitTemplate;
end

function UICommerceShopPageUnitTemplate:UpdateUnit(shopDataList)
    local gridContainer = self:GetUnitGridContainer();
    if (shopDataList == nil) then
        gridContainer.MaxCount = 0;
        local commerceShopPanel = uimanager:GetPanel("UICommerceShopPanel");
        if (commerceShopPanel ~= nil and not CS.StaticUtility.IsNull(commerceShopPanel:GetNotHasShop_GameObject())) then
            commerceShopPanel:GetNotHasShop_GameObject():SetActive(true);
        end
        return ;
    end

    if (self.mShopUnitDic == nil) then
        self.mShopUnitDic = {};
    end

    local sortFunc = function(a, b)
        local isFind1, itemTable1 = CS.Cfg_StoreTableManager.Instance:TryGetValue(a.storeId)
        local isFind2, itemTable2 = CS.Cfg_StoreTableManager.Instance:TryGetValue(b.storeId)
        if (isFind1 and isFind2) then
            return itemTable1.index < itemTable2.index;
        end
        return false;
    end
    table.sort(shopDataList, sortFunc);

    gridContainer.MaxCount = #shopDataList;
    local index = 0;
    for k, v in pairs(shopDataList) do
        local gobj = gridContainer.controlList[index];
        if (self.mShopUnitDic[gobj] == nil) then
            self.mShopUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, self:GetShopUnitTemplate(), self.mOwnerPanel);
        end

        self.mShopUnitDic[gobj]:SetViewUnit(v, index);
        self.mShopUnitDic[gobj]:UpdateOtherCurrency();
        index = index + 1;
    end

    local commerceShopPanel = uimanager:GetPanel("UICommerceShopPanel");
    if (commerceShopPanel ~= nil and not CS.StaticUtility.IsNull(commerceShopPanel:GetNotHasShop_GameObject())) then
        commerceShopPanel:GetNotHasShop_GameObject():SetActive(gridContainer.MaxCount == 0);
    end

end

--endregion

return UICommerceShopPageUnitTemplate;