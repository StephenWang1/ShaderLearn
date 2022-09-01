local UIWayGetShopUnitTemplate = {}

setmetatable(UIWayGetShopUnitTemplate, luaComponentTemplates.UIShopUnitTemplate)

function UIWayGetShopUnitTemplate:GetMoneyType_Sprite()
    if (self.mMoneyType_Sprite == nil) then
        self.mMoneyType_Sprite = self:Get("widget/price/type", "UISprite");
    end
    return self.mMoneyType_Sprite;
end

function UIWayGetShopUnitTemplate:GetStoreItemNum()
    if (self.mBuyCount ~= nil) then
        return self.mBuyCount;
    end
    return 1;
end
--region Method

function UIWayGetShopUnitTemplate:SetViewUnit(wayGetId, failCallBack)
    self.isTryGetStore = false
    if (wayGetId ~= nil) then
        local isFindWayGetTable, wayGetTable = CS.Cfg_Way_GetTableManager.Instance:TryGetValue(wayGetId);
        if (isFindWayGetTable) then
            self.tryGetStore = self.tryGetStore == nil and 1 or self.tryGetStore + 1
            self.mWayGetTable = wayGetTable;

            if self.mWayGetTable.openType == LuaEnumWayGetFuncType.BuyCommodity and self.mWayGetTable.openPanel ~= "" then
                local itemParams = string.Split(self.mWayGetTable.openPanel, '#')
                if #itemParams >= 3 then
                    local storeId = ternary(itemParams[1] == "", 0, tonumber(itemParams[1]))
                    self.mBuyCount = ternary(itemParams[2] == "", 0, tonumber(itemParams[2]))
                    self.mIsBuyAndUse = ternary(itemParams[3] == "", 0, tonumber(itemParams[3]));

                    local isFind, storeTable = CS.Cfg_StoreTableManager.Instance:TryGetValue(storeId);
                    if (isFind) then
                        self.curStoreID = storeId
                        self.mStoreTable = storeTable;
                        CS.CSScene.MainPlayerInfo.StoreInfoV2:TryGetStoreInfo(storeTable, function()
                            local storeInfo = CS.CSScene.MainPlayerInfo.StoreInfoV2:GetStoreInfo(storeTable);
                            if (storeInfo ~= nil and not CS.StaticUtility.IsNull(self.go)) and storeInfo.storeId == self.curStoreID then
                                self.mCoroutineDelayUpdate = StopCoroutine(self.mCoroutineDelayUpdate);
                                self.mCoroutineDelayUpdate = nil;
                                self.mCoroutineDelayUpdate = StartCoroutine(self.IEnumDelayUpdate, self, storeInfo, false);
                            elseif(storeInfo == nil) then
                                ---@type UIFurnaceWayAndBuyPanel
                                local furnaceWayAndBuyPanel = uimanager:GetPanel("UIFurnaceWayAndBuyPanel")
                                if furnaceWayAndBuyPanel ~= nil then
                                    furnaceWayAndBuyPanel:UpdateUI()
                                end
                            end
                        end);
                    end
                end
            end
            self.mFailCallBack = failCallBack;
        end
    end
end

function UIWayGetShopUnitTemplate:OnClickBtnBuy()
    if (self.mShopData ~= nil) then
        local itemId = self.mStoreTable.moneyType;
        local itemTable = CS.Cfg_ItemsTableManager.Instance:GetItems(itemId);
        local isGetValue = false;
        local count = 0;
        if (itemTable ~= nil) then
            if (itemTable.type == luaEnumItemType.Coin) then
                if (CS.CSScene.MainPlayerInfo.BagInfo.DiamondIdList:Contains(itemId)) then
                    if (Utility.IsPushSpecialGift()) then
                        uimanager:CreatePanel("UIRechargeGiftPanel")
                        return
                    end
                    isGetValue = true;
                    count = CS.CSScene.MainPlayerInfo.BagInfo.DiamondNum;
                else
                    count = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(itemId);
                end
            elseif (itemTable.type == luaEnumItemType.Material) then
                isGetValue = true;
                if (itemId == 6210001 or itemId == 6210002) then
                    --创造宝石(绑定或者非绑定,两者数量需要同时计算)
                    count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCount(6210001)
                    count = count + CS.CSScene.MainPlayerInfo.BagInfo:GetItemCount(6210002)
                else
                    count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(itemId);
                end
            end

            self.mBuyCount = self.mBuyCount == nil and 1 or self.mBuyCount;
            self.mIsBuyAndUse = self.mIsBuyAndUse == nil and 0 or self.mIsBuyAndUse;
            if (count >= self.mShopData.price * self.mBuyCount) then
                networkRequest.ReqBuyItem(self.mShopData.storeId, self.mBuyCount, nil, self.mIsBuyAndUse);
            else
                if (self.mFailCallBack ~= nil) then
                    self.mFailCallBack(self:GetBtnBuy_GameObject(), itemId);
                end
            end
        end
    end
end
--endregion

return UIWayGetShopUnitTemplate