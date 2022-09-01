local UICommerceShopUnitTemplate = {};

setmetatable(UICommerceShopUnitTemplate, luaComponentTemplates.UIShopUnitTemplate);

UICommerceShopUnitTemplate.mOtherCurrencyUnitDic = nil;

UICommerceShopUnitTemplate.mIndex = 0;

--region Components

function UICommerceShopUnitTemplate:GetBackGround_GameObject()
    if (self.mBackGround_GameObject == nil) then
        self.mBackGround_GameObject = self:Get("widget/background", "GameObject");
    end
    return self.mBackGround_GameObject;
end

function UICommerceShopUnitTemplate:GetOtherCurrencyGridContainer()
    if (self.mOtherCurrencyGridContainer == nil) then
        self.mOtherCurrencyGridContainer = self:Get("widget/gridContainer", "UIGridContainer");
    end
    return self.mOtherCurrencyGridContainer;
end

function UICommerceShopUnitTemplate:GetMoneyType_Sprite()
    if (self.mMoneyType_Sprite == nil) then
        self.mMoneyType_Sprite = self:Get("widget/price/type", "UISprite");
    end
    return self.mMoneyType_Sprite;
end

function UICommerceShopUnitTemplate:GetGoodArrow_UISprite()
    if (self.mGoodArrow_UISprite == nil) then
        self.mGoodArrow_UISprite = self:Get("widget/good", "UISprite");
    end
    return self.mGoodArrow_UISprite;
end

function UICommerceShopUnitTemplate:GetOriginMoneyType_Sprite()
    if (self.mOriginMoneyType_Sprite == nil) then
        self.mOriginMoneyType_Sprite = self:Get("widget/originalprice/type", "UISprite");
    end
    return self.mOriginMoneyType_Sprite;
end

function UICommerceShopUnitTemplate:GetReplaceMoneyType_UISprite()
    if (self.mReplaceMoneyType_UISprite == nil) then
        self.mReplaceMoneyType_UISprite = self:Get("widget/replacePrice/Sprite", "UISprite");
    end
    return self.mReplaceMoneyType_UISprite;
end

function UICommerceShopUnitTemplate:GetReplaceMoneyValue_Text()
    if (self.mReplaceMoneyValue_Text == nil) then
        self.mReplaceMoneyValue_Text = self:Get("widget/replacePrice/value", "UILabel");
    end
    return self.mReplaceMoneyValue_Text
end

function UICommerceShopUnitTemplate:GetItemCount_Text()
    if (self.mItemCount_Text == nil) then
        self.mItemCount_Text = self:Get("widget/item/count", "UILabel");
    end
    return self.mItemCount_Text;
end

function UICommerceShopUnitTemplate:GetReplaceMoneyWidget_UIWidget()
    if (self.mReplaceMoneyWidget_UIWidget == nil) then
        self.mReplaceMoneyWidget_UIWidget = self:Get("widget/replacePrice", "UIWidget");
    end
    return self.mReplaceMoneyWidget_UIWidget;
end

--endregion

--region Method

--region CallFunction


function UICommerceShopUnitTemplate:OnClickUIItem()
    if (self:GetStoreType() == LuaEnumStoreType.CommerceIntegral) then
        if (self.mShopData.bagItemInfo ~= nil and CS.CSScene.MainPlayerInfo ~= nil) then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.mShopData.bagItemInfo, showRight = true, showAssistPanel = true, career = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career), showMoreAssistData = true, showTabBtns = true, showBind = true, showAction = true })
        else
            self:RunBaseFunction("OnClickUIItem");
        end
    else
        self:RunBaseFunction("OnClickUIItem");
    end
end

function UICommerceShopUnitTemplate:OnClickBtnBuy()
    if (self:GetStoreType() == LuaEnumStoreType.CommerceIntegral) then

        local mMoneyCount = 0
        local tableData = self.mShopData.storeTable
        if (tableData ~= nil) then
            mMoneyCount = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(tableData.moneyType);
        end

        local data = {}
        ---@type UICommerceShopPanel_Conversion
        data.Template = luaComponentTemplates.UICommerceShopPanel_Conversion
        data.mMoneyCount = mMoneyCount
        data.moneyType = tableData.moneyType
        data.price = self.mShopData.price
        data.storeId = self.mShopData.storeId
        data.storeTable = self.mShopData.storeTable;
        --  local isFindItem, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mShopData.storeTable.moneyType);
        --data.itemInfo = self.mShopData.itemTable
        data.BagItemInfo = self.mShopData.bagItemInfo;

        data.otherCurrency = self.mShopData.otherCurrency
        uimanager:CreatePanel("UIAuctionItemPanel", function(panel)
            ---@type UIAuctionItemPanel
            self.mAuctionItemPanel = panel
        end, data)
    else
        self:RunBaseFunction("OnClickBtnBuy");
    end
    -- if true then
    --     return
    -- end

    -- local tipsFunc = function()
    --     local TipsInfo = {}
    --     TipsInfo[LuaEnumTipConfigType.Describe] = "所需物品不足";
    --     TipsInfo[LuaEnumTipConfigType.Parent] = self:GetBtnBuy_GameObject().transform;
    --     TipsInfo[LuaEnumTipConfigType.ConfigID] = 68;
    --     uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
    -- end


    --     local tableData = self.mShopData.storeTable;
    --     if (tableData ~= nil) then
    --         local mMoneyCount = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(tableData.moneyType);
    --         --if(isGetValue) then
    --         if (mMoneyCount < self.mShopData.price) then
    --             return tipsFunc();
    --         end
    --         --end
    --         if (self.mShopData.otherCurrency ~= nil) then
    --             for i = 0, self.mShopData.otherCurrency.Count - 1 do
    --                 local itemIdAndCount = self.mShopData.otherCurrency[i];
    --                 if (itemIdAndCount.Length > 1) then
    --                     local itemId = itemIdAndCount[0];
    --                     local itemCount = itemIdAndCount[1];
    --                     local mCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(itemId);
    --                     if (mCount < itemCount) then
    --                         return tipsFunc();
    --                     end
    --                 end
    --             end
    --         end
    --         networkRequest.ReqBuyItem(self.mShopData.storeId, 1, tableData.itemId, 0);
    --     end
    -- else
    --     self:RunBaseFunction("OnClickBtnBuy");
    -- end
end

--endregion

--region Public

function UICommerceShopUnitTemplate:SetViewUnit(shopData, index)
    self:RunBaseFunction("SetViewUnit", shopData);
    if (index ~= nil) then
        self.mIndex = index;
    end
    self:GetBackGround_GameObject():SetActive(self.mIndex % 2 == 0);
    local arrowType = LuaEnumArrowType.NONE;
    if (self.mShopData.bagItemInfo ~= nil) then
        arrowType = Utility.GetArrowType(self.mShopData.bagItemInfo);
    end
    self:GetGoodArrow_UISprite().gameObject:SetActive(arrowType ~= LuaEnumArrowType.NONE);
    self:GetGoodArrow_UISprite().spriteName = arrowType == LuaEnumArrowType.GreenArrow and "arrow2" or "arrow3";
end

function UICommerceShopUnitTemplate:UpdateOtherCurrency()
    if (self.mOtherCurrencyUnitDic == nil) then
        self.mOtherCurrencyUnitDic = {};
    end
    local gridContainer = self:GetOtherCurrencyGridContainer();
    if (self.mShopData == nil) then
        gridContainer.MaxCount = 0;
        return ;
    end

    if (self.mShopData.otherCurrency ~= nil) then
        gridContainer.MaxCount = self.mShopData.otherCurrency.Count;
        for i = 0, gridContainer.MaxCount - 1 do
            local gobj = gridContainer.controlList[i];
            if (self.mOtherCurrencyUnitDic[gobj] == nil) then
                self.mOtherCurrencyUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIShopOtherCurrencyUnitTemplate);
            end
            local itemId = 0;
            local itemCount = 0;
            if (self.mShopData.otherCurrency[i].Length > 0) then
                itemId = self.mShopData.otherCurrency[i][0];
            end
            if (self.mShopData.otherCurrency[i].Length > 1) then
                itemCount = self.mShopData.otherCurrency[i][1];
            end
            self.mOtherCurrencyUnitDic[gobj]:UpdateUnit(itemId, itemCount);
        end
    else
        gridContainer.MaxCount = 0;
    end
    self:GetReplaceMoneyWidget_UIWidget().gameObject:SetActive(false);
    if (self.mShopData.storeTable ~= nil and self.mShopData.storeTable.replaceMoney ~= nil and self.mShopData.storeTable.replaceMoney ~= 0) then
        if (self:GetReplaceMoneyWidget_UIWidget() ~= nil) then
            self:GetReplaceMoneyWidget_UIWidget().gameObject:SetActive(true);
            self:GetValue_Text().text = self:GetValue_Text().text .. "/";
        end

        local itemId = self.mShopData.storeTable.replaceMoney;
        local count = self.mShopData.storeTable.replacePrice;

        if (self:GetReplaceMoneyValue_Text() ~= nil) then
            self:GetReplaceMoneyValue_Text().text = count;
        end
        local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
        if (isFind and self:GetReplaceMoneyType_UISprite() ~= nil) then
            self:GetReplaceMoneyType_UISprite().spriteName = itemTable.icon;
        end
    end
    if (self.mCoroutineDelay ~= nil) then
        StopCoroutine(self.mCoroutineDelay);
        self.mCoroutineDelay = nil;
    end
    self.mCoroutineDelay = StartCoroutine(self.CDelayUpdateAnchors, self);
end

function UICommerceShopUnitTemplate:CDelayUpdateAnchors()
    coroutine.yield(0);
    self:GetReplaceMoneyWidget_UIWidget():UpdateAnchors();
end

function UICommerceShopUnitTemplate:UpdateOriginPricePosition(hasOriginPrice)
    -- if(hasOriginPrice) then
    --    if(self.mOriginPricePosition ~= nil) then
    --        self:GetPrice_GameObject().transform.localPosition = self.mOriginPricePosition;
    --    end
    -- else
    --    self:GetPrice_GameObject().transform.localPosition = self:GetOriginPrice_GameObject().transform.localPosition;
    -- end
end

--endregion

--region Private

function UICommerceShopUnitTemplate:UpdateLimitBuy(remainBuyNum, maxLimitBuyNum)
    if (self:GetStoreType() == LuaEnumStoreType.CommerceIntegral) then
        self:GetLimitNum_Text().gameObject:SetActive(false);
        self:GetItemCount_Text().text = remainBuyNum > 1 and remainBuyNum or "";
    else
        self:GetLimitNum_Text().gameObject:SetActive(true);
        self:GetLimitNum_Text().text = remainBuyNum;
        self:GetItemCount_Text().text = "";
    end
end

function UICommerceShopUnitTemplate:UpdateBuyBtnLabel()
    if (self:GetStoreType() == LuaEnumStoreType.CommerceIntegral) then
        self:GetBtnBuy_Text().text = "兑换"
    else
        self:RunBaseFunction("UpdateBuyBtnLabel");
    end
end

function UICommerceShopUnitTemplate:InitEvents()
    self:RunBaseFunction("InitEvents");
    CS.UIEventListener.Get(self:GetMoneyType_Sprite().gameObject).onClick = function()
        if (self.mShopData ~= nil and self.mShopData.storeTable ~= nil) then
            local isFindItem, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mShopData.storeTable.moneyType);
            if (isFindItem) then
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable })
            end
        end
    end
end

function UICommerceShopUnitTemplate:Clear()
    self.mOtherCurrencyGridContainer = nil;
    self.mOtherCurrencyUnitDic = nil;
    if (self.mCoroutineDelay ~= nil) then
        StopCoroutine(self.mCoroutineDelay);
        self.mCoroutineDelay = nil;
    end
end

--endregion

--endregion

function UICommerceShopUnitTemplate:Init(ownerPanel)
    self:RunBaseFunction("Init", ownerPanel);
end

function UICommerceShopUnitTemplate:OnDestroy()
    self:RunBaseFunction("OnDestroy");
    self:Clear();
end

return UICommerceShopUnitTemplate