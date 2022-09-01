local UIShopUnitTemplate = {};

UIShopUnitTemplate.mShopData = nil;

UIShopUnitTemplate.mOriginPricePosition = nil;

--region Components

--region GameObject

--function UIShopUnitTemplate:GetUIItemBtn_GameObject()
--    if(self.mUIItemBtn_GameObject == nil) then
--        self.mUIItemBtn_GameObject = self:Get("widget/item/bg", "GameObject");
--    end
--    return self.mUIItemBtn_GameObject;
--end

function UIShopUnitTemplate:GetUIItem_GameObject()
    if (self.mUIItem_GameObject == nil) then
        self.mUIItem_GameObject = self:Get("widget/item", "GameObject");
    end
    return self.mUIItem_GameObject;
end

function UIShopUnitTemplate:GetBtnBuy_GameObject()
    if (self.mBtnBuy_GameObject == nil) then
        self.mBtnBuy_GameObject = self:Get("widget/btn_buy", "GameObject");
    end
    return self.mBtnBuy_GameObject;
end

function UIShopUnitTemplate:GetChoose_GameObject()
    if (self.mChoose_GameObject == nil) then
        self.mChoose_GameObject = self:Get("widget/choose", "GameObject");
    end
    return self.mChoose_GameObject;
end

function UIShopUnitTemplate:GetOriginPrice_GameObject()
    if (self.mOriginPrice_GameObject == nil) then
        self.mOriginPrice_GameObject = self:Get("widget/originalprice", "GameObject");
    end
    return self.mOriginPrice_GameObject;
end

function UIShopUnitTemplate:GetPrice_GameObject()
    if (self.mPrice_GameObject == nil) then
        self.mPrice_GameObject = self:Get("widget/price", "GameObject");
    end
    return self.mPrice_GameObject;
end

function UIShopUnitTemplate:GetDisCount_GameObject()
    if (self.mDisCount_GameObject == nil) then
        self.mDisCount_GameObject = self:Get("widget/discount", "GameObject");
    end
    return self.mDisCount_GameObject;
end
--region UISprite

function UIShopUnitTemplate:GetOriginMoneyType_Sprite()
    return nil;
end

function UIShopUnitTemplate:GetLineOriginLine_Sprite()
    if (self.mLineOriginLine_Sprite == nil) then
        self.mLineOriginLine_Sprite = self:Get("widget/originalprice/Sprite", "UISprite");
    end
    return self.mLineOriginLine_Sprite;
end

function UIShopUnitTemplate:GetMoneyType_Sprite()
    if (self.mMoneyType_Sprite == nil) then
        self.mMoneyType_Sprite = self:Get("widget/moneyType", "UISprite");
    end
    return self.mMoneyType_Sprite;
end

---@type UnityEngine.GameObject
function UIShopUnitTemplate:GetSoldOutSprite_GameObject()
    if (self.mSoldOutSprite_GameObject == nil) then
        self.mSoldOutSprite_GameObject = self:Get("soldout/Sprite", "GameObject");
    end
    return self.mSoldOutSprite_GameObject;
end

function UIShopUnitTemplate:GetSoldOut_GameObject()
    if (self.mSoldOut_GameObject == nil) then
        self.mSoldOut_GameObject = self:Get("soldout", "GameObject");
    end
    return self.mSoldOut_GameObject;
end
--endregion

--region Text
function UIShopUnitTemplate:GetDisCount_Text()
    if (self.mDisCount_Text == nil) then
        self.mDisCount_Text = self:Get("widget/discount/value", "UILabel");
    end
    return self.mDisCount_Text;
end

function UIShopUnitTemplate:GetLimitNum_Text()
    if (self.mLimitNum_Text == nil) then
        self.mLimitNum_Text = self:Get("widget/limitNum", "UILabel");
    end
    return self.mLimitNum_Text;
end

function UIShopUnitTemplate:GetValue_Text()
    if (self.mValue_Text == nil) then
        self.mValue_Text = self:Get("widget/price/value", "UILabel");
    end
    return self.mValue_Text;
end

--function UIShopUnitTemplate:GetNow_Text()
--    if(self.mNow_Text == nil)then
--        self.mNow_Text = self:Get("widget/price/Label", "UILabel");
--    end
--    return self.mNow_Text;
--end

function UIShopUnitTemplate:GetOriginValue_Text()
    if (self.mOriginValue_Text == nil) then
        self.mOriginValue_Text = self:Get("widget/originalprice/value", "UILabel");
    end
    return self.mOriginValue_Text;
end

function UIShopUnitTemplate:GetOrigin_Text()
    if (self.mOrigin_Text == nil) then
        self.mOrigin_Text = self:Get("widget/originalprice/Label", "UILabel");
    end
    return self.mOrigin_Text;
end

function UIShopUnitTemplate:GetBtnBuy_Text()
    if (self.mBtnBuy_Text == nil) then
        self.mBtnBuy_Text = self:Get("widget/btn_buy/Label", "UILabel");
    end
    return self.mBtnBuy_Text;
end

function UIShopUnitTemplate:GetOpenShowStr_Text()
    if (self.mOpenShowStr_Text == nil) then
        self.mOpenShowStr_Text = self:Get("widget/openShowStr", "UILabel");
    end
    return self.mOpenShowStr_Text;
end

function UIShopUnitTemplate:GetUnitWidget_UIWidget()
    if (self.mUnitWidget_UIWidget == nil) then
        self.mUnitWidget_UIWidget = self:Get("widget", "UIWidget");
    end
    return self.mUnitWidget_UIWidget;
end

function UIShopUnitTemplate:GetReplaceCostWidget()
    if (self.mReplaceCostWidget == nil) then
        self.mReplaceCostWidget = self:Get("widget/replaceCost", "UIWidget");
    end
    return self.mReplaceCostWidget;
end

function UIShopUnitTemplate:GetReplaceCostValue()
    if (self.mReplaceCostValue == nil) then
        self.mReplaceCostValue = self:Get("widget/replaceCost/value", "UILabel");
    end
    return self.mReplaceCostValue;
end

function UIShopUnitTemplate:GetReplaceCostItemIcon()
    if (self.mReplaceCostItemIcon == nil) then
        self.mReplaceCostItemIcon = self:Get("widget/replaceCost/itemicon", "UISprite");
    end
    return self.mReplaceCostItemIcon;
end

--endregion

--endregion

--region Others
function UIShopUnitTemplate:GetUIItem()
    if (self.mUIItem == nil) then
        self.mUIItem = templatemanager.GetNewTemplate(self:GetUIItem_GameObject(), luaComponentTemplates.UIItem);
    end
    return self.mUIItem;
end
--endregion

--endregion

--region Method

--region Private

function UIShopUnitTemplate:GetStoreItemNum()
    return 1;
end

function UIShopUnitTemplate:GetStoreId()
    if (self.mShopData ~= nil) then
        return self.mShopData.storeId;
    end
    return 0;
end

--endregion

--region Public

function UIShopUnitTemplate:SetViewUnit(unitData, isBuyAndUse)
    --if(self.mCoroutineDelayUpdate ~= nil) then
    --    self.mCoroutineDelayUpdate = StopCoroutine(self.mCoroutineDelayUpdate);
    --    self.mCoroutineDelayUpdate = nil;
    --end
    --self.mCoroutineDelayUpdate = StartCoroutine(self.IEnumDelayUpdate, self, unitData, isBuyAndUse);
    self:IEnumDelayUpdate(unitData, isBuyAndUse);
end

function UIShopUnitTemplate:UpdateOriginPricePosition(hasOriginPrice)
    if (hasOriginPrice) then
        if (self.mOriginPricePosition ~= nil) then
            self:GetPrice_GameObject().transform.localPosition = self.mOriginPricePosition;
        end
    else
        self:GetPrice_GameObject().transform.localPosition = self:GetOriginPrice_GameObject().transform.localPosition;
    end
end

function UIShopUnitTemplate:IEnumDelayUpdate(unitData, isBuyAndUse)
    self.mShopData = unitData;
    local tableData = CS.Cfg_StoreTableManager.Instance:GetStoreItem(self.mShopData.storeId);
    if (tableData ~= nil) then
        local isFind0, itemTable0 = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(tableData.itemId);
        if (isFind0) then
            local reuseAmount = itemTable0.reuseAmount;
            reuseAmount = (reuseAmount == nil or reuseAmount == 0) and 1 or reuseAmount;
            local num = tableData.num * reuseAmount * self:GetStoreItemNum();
            self:GetUIItem():RefreshUIWithItemInfo(itemTable0, num);
        end
        --self:GetUIItem():GetEventListener().onClick = function()
        --    uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = itemTable0, showRight = false})
        --end
        local isFind1, itemTable1 = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(tableData.moneyType);
        if (isFind1) then
            self:GetMoneyType_Sprite().spriteName = tostring(itemTable1.icon)
            if (self:GetOriginMoneyType_Sprite() ~= nil) then
                self:GetOriginMoneyType_Sprite().spriteName = tostring(itemTable1.icon)
            end

        end
        --coroutine.yield(0);
        if (self:GetOriginMoneyType_Sprite() ~= nil) then
            self:GetOriginMoneyType_Sprite():MakePixelPerfect();
        end
        self:GetMoneyType_Sprite():MakePixelPerfect();

        local hasOriginPrice = tableData.originalPrice ~= nil and tableData.originalPrice ~= 0 and tableData.originalPrice ~= self.mShopData.price;
        self:GetOriginPrice_GameObject():SetActive(hasOriginPrice);
        self:GetDisCount_GameObject():SetActive(hasOriginPrice);
        local originalPrice = tableData.originalPrice * self:GetStoreItemNum();
        local curPrice = self.mShopData.price * self:GetStoreItemNum();
        if (hasOriginPrice) then
            self:GetOriginValue_Text().text = originalPrice;
            --self:GetNow_Text().text = "现价";
            self:GetValue_Text().text = curPrice;
            local ratio = ((curPrice * 10) % originalPrice == 0 and 10 or 100);
            self:GetDisCount_Text().text = math.floor((curPrice / tableData.originalPrice) * ratio);

            --self:GetUIItem():GetItemName_UILabel().gameObject.transform.localPosition = CS.UnityEngine.Vector3(48,26,0);
            --local originValueLocalPosition = self:GetOriginValue_Text().gameObject.transform.parent.localPosition;
            --self:GetValue_Text().gameObject.transform.parent.localPosition = CS.UnityEngine.Vector3(originValueLocalPosition.x, originValueLocalPosition.y - 26, originValueLocalPosition.z);
        else
            self:GetValue_Text().text = curPrice;
            --self:GetNow_Text().text = "";
            --self:GetUIItem():GetItemName_UILabel().gameObject.transform.localPosition = CS.UnityEngine.Vector3(48,15,0);
            --local originValueLocalPosition = self:GetOriginValue_Text().gameObject.transform.parent.localPosition;
            --self:GetValue_Text().gameObject.transform.parent.localPosition =  CS.UnityEngine.Vector3(originValueLocalPosition.x, originValueLocalPosition.y - 14, originValueLocalPosition.z);
        end
        self:UpdateOriginPricePosition(hasOriginPrice);
        self:GetLineOriginLine_Sprite().width = self:GetOriginValue_Text().width + 10;
        --coroutine.yield(0);
        --self:GetMoneyType_Sprite():UpdateAnchors();
        --self:GetValue_Text():UpdateAnchors();
        --self:GetLineOriginLine_Sprite():UpdateAnchors();
        --region 限购显示
        local selfDayBuyNum = self.mShopData.dayBuyNum;
        local selfLifeBuyNum = self.mShopData.lifeBuyNum;
        local serverDayBuyNum = self.mShopData.serverDayBuyNum;
        local serverLifeBuyNum = self.mShopData.serverLifeBuyNum;
        local refreshBuyNum = self.mShopData.refreshBuyNum;
        local serverRefreshBuyNum = self.mShopData.serverRefreshBuyNum;
        local tableData = CS.Cfg_StoreTableManager.Instance:GetStoreItem(self.mShopData.storeId);
        if (tableData ~= nil) then
            local selfMaxLimitBuyNum = 0;
            local selfLimitRemainBuyNum = 0;
            local serverMaxLimitBuyNum = 0;
            local serverLimitRemainBuyNum = 0;
            local isLimitSelf = false;
            local isLimitServer = false;
            --region 个人限购
            if (tableData.singleLimit ~= nil and tableData.singleLimit.list ~= nil) then
                local list = tableData.singleLimit.list;
                local limitType;
                if (list.Count > 0) then
                    limitType = tableData.singleLimit.list[0];
                end
                if (limitType == luaEnumShopLimitType.RandomLimitNum) then
                    selfMaxLimitBuyNum = self.mShopData.randomLimitNum;
                elseif (limitType == luaEnumShopLimitType.RefreshLimitNum) then
                    selfMaxLimitBuyNum = self.mShopData.randomLimitNum;
                else
                    if (list.Count > 1) then
                        selfMaxLimitBuyNum = tableData.singleLimit.list[1];
                    end
                end

                if (limitType == luaEnumShopLimitType.DayLimit) then
                    selfLimitRemainBuyNum = selfMaxLimitBuyNum - selfDayBuyNum;
                elseif (limitType == luaEnumShopLimitType.LifeLimit) then
                    selfLimitRemainBuyNum = selfMaxLimitBuyNum - selfLifeBuyNum;
                elseif (limitType == luaEnumShopLimitType.RefreshBuyLimit) then
                    selfLimitRemainBuyNum = selfMaxLimitBuyNum - refreshBuyNum;
                elseif (limitType == luaEnumShopLimitType.RandomLimitNum) then
                    selfLimitRemainBuyNum = selfMaxLimitBuyNum - selfDayBuyNum;
                elseif (limitType == luaEnumShopLimitType.RefreshLimitNum) then
                    selfLimitRemainBuyNum = selfMaxLimitBuyNum - selfDayBuyNum;
                end
                selfLimitRemainBuyNum = selfLimitRemainBuyNum > 0 and selfLimitRemainBuyNum or 0;
                isLimitSelf = true;
            end
            --endregion
            --region 全服限购
            if (tableData.allLimit ~= nil and tableData.allLimit.list ~= nil) then
                local list = tableData.allLimit.list;
                local limitType;
                if (list.Count > 0) then
                    limitType = tableData.allLimit.list[0];
                end

                if (limitType == luaEnumShopLimitType.RandomLimitNum) then
                    serverMaxLimitBuyNum = self.mShopData.randomLimitNum;
                elseif (limitType == luaEnumShopLimitType.RefreshLimitNum) then
                    serverMaxLimitBuyNum = self.mShopData.randomLimitNum;
                else
                    if (list.Count > 1) then
                        serverMaxLimitBuyNum = tableData.allLimit.list[1];
                    end
                end

                if (limitType == luaEnumShopLimitType.DayLimit) then
                    serverLimitRemainBuyNum = serverMaxLimitBuyNum - serverDayBuyNum;
                elseif (limitType == luaEnumShopLimitType.LifeLimit) then
                    serverLimitRemainBuyNum = serverMaxLimitBuyNum - serverLifeBuyNum;
                elseif (limitType == luaEnumShopLimitType.RefreshBuyLimit) then
                    serverLimitRemainBuyNum = serverMaxLimitBuyNum - serverRefreshBuyNum;
                elseif (limitType == luaEnumShopLimitType.RandomLimitNum) then
                    serverLimitRemainBuyNum = serverMaxLimitBuyNum - serverDayBuyNum;
                elseif (limitType == luaEnumShopLimitType.RefreshLimitNum) then
                    serverLimitRemainBuyNum = serverMaxLimitBuyNum - serverDayBuyNum;
                end
                serverLimitRemainBuyNum = serverLimitRemainBuyNum > 0 and serverLimitRemainBuyNum or 0;
                isLimitServer = true;
            end

            local remainBuyNum = 0;
            local maxLimitBuyNum = 0;
            if (isLimitServer and isLimitSelf) then
                if (serverLimitRemainBuyNum > selfLimitRemainBuyNum) then
                    remainBuyNum = selfLimitRemainBuyNum;
                    maxLimitBuyNum = selfMaxLimitBuyNum;
                elseif (isLimitServer) then
                    remainBuyNum = serverLimitRemainBuyNum;
                    maxLimitBuyNum = serverMaxLimitBuyNum;
                end
            elseif (isLimitSelf) then
                remainBuyNum = selfLimitRemainBuyNum;
                maxLimitBuyNum = selfMaxLimitBuyNum;
            elseif (isLimitServer) then
                maxLimitBuyNum = serverMaxLimitBuyNum;
                remainBuyNum = serverLimitRemainBuyNum;
            end

            self:GetLimitNum_Text().gameObject:SetActive(isLimitServer or isLimitSelf);
            local isSoldOut = remainBuyNum <= 0 and (isLimitServer or isLimitSelf);
            self:GetUIItem():SetIsLock(isSoldOut);
            self:GetSoldOut_GameObject():SetActive(isSoldOut);
            self:GetSoldOutSprite_GameObject():SetActive(false)
            self:GetUnitWidget_UIWidget().alpha = isSoldOut and 0.3 or 1;
            self:UpdateLimitBuy(remainBuyNum, maxLimitBuyNum, isLimitSelf, isLimitServer);
            --endregion

            if (tableData.buyCondition ~= "") then
                local isOpen, showStr = uimanager:IsOpenWithKey(tableData.buyCondition);
                if (not isOpen) then
                    self:GetOpenShowStr_Text().text = showStr;
                end
                self:GetBtnBuy_GameObject():SetActive(isOpen);
                self:GetOpenShowStr_Text().gameObject:SetActive(not isOpen);
            else
                self:GetOpenShowStr_Text().gameObject:SetActive(false);
            end
        end
        --endregion
    end

    if (self.mShopData.storeTable ~= nil and self.mShopData.storeTable.replaceMoney ~= nil and self.mShopData.storeTable.replaceMoney ~= 0) then
        if (self:GetReplaceCostWidget() ~= nil) then
            self:GetValue_Text().text = self:GetValue_Text().text .. "  /";
        end

        local itemId = self.mShopData.storeTable.replaceMoney;
        local count = self.mShopData.storeTable.replacePrice;

        if (self:GetReplaceCostValue() ~= nil) then
            self:GetReplaceCostValue().text = count;
        end
        local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
        if (isFind and self:GetReplaceCostItemIcon() ~= nil) then
            self:GetReplaceCostItemIcon().spriteName = itemTable.icon;
        end

        self:OnDealyUpdateWidget();
    else
        if (self:GetReplaceCostWidget() ~= nil) then
            self:GetReplaceCostWidget().gameObject:SetActive(false);
        end
    end

    if (not (isBuyAndUse == nil)) then
        self.isBuyAndUse = isBuyAndUse;
    end
    self:UpdateBuyBtnLabel();
end

---设置携程等待更新替换资源的widget
function UIShopUnitTemplate:OnDealyUpdateWidget()
    --if(self:GetReplaceCostWidget() ~= nil) then
    --    self:GetReplaceCostWidget():UpdateAnchors()
    --end

    if (self.mCoroutineDealyUpdateWidget ~= nil) then
        StopCoroutine(self.mCoroutineDealyUpdateWidget);
        self.mCoroutineDealyUpdateWidget = nil;
    end
    self.mCoroutineDealyUpdateWidget = StartCoroutine(self.ICoroutineDealyUpdateWidget, self, 1);
end

---携程等待更新替换资源的widget
function UIShopUnitTemplate:ICoroutineDealyUpdateWidget(delayTime)
    self:GetReplaceCostWidget().gameObject:SetActive(true);
    coroutine.yield(CS.NGUIAssist.waitForEndOfFrame);
    if (self:GetReplaceCostWidget() ~= nil) then
        self:GetReplaceCostWidget():UpdateAnchors()
    end
end

function UIShopUnitTemplate:GetStoreType()
    if (self.mShopData ~= nil and self.mShopData.storeTable ~= nil) then
        return self.mShopData.storeTable.sellId;
    end
    return nil;
end

function UIShopUnitTemplate:UpdateLimitBuy(remainBuyNum, maxLimitBuyNum, isLimitSelf, isLimitServer)
    if (remainBuyNum <= 0) then
        self:GetLimitNum_Text().text = "";
    else
        if (isLimitSelf) then
            self:GetLimitNum_Text().text = "限购" .. remainBuyNum .. "件";
        elseif (isLimitServer) then
            self:GetLimitNum_Text().text = "剩余" .. remainBuyNum .. "件";
        end
    end
end

function UIShopUnitTemplate:UpdateBuyBtnLabel()
    if (self.isBuyAndUse) then
        self:GetBtnBuy_Text().text = "购买并使用"
    else
        self:GetBtnBuy_Text().text = "购买"
    end
end

function UIShopUnitTemplate:SetChoose(isChoose)
    if (isChoose == nil) then
        isChoose = false;
    end
    if (not CS.StaticUtility.IsNull(self:GetChoose_GameObject())) then
        if (isChoose ~= self:GetChoose_GameObject().activeSelf) then
            self:GetChoose_GameObject():SetActive(isChoose);
        end
    end
end

--endregion

--region CallFunc
function UIShopUnitTemplate:OnClickBtnBuy()
    if (self.isBuyAndUse) then
        local tableData = self.mShopData.storeTable;
        if (tableData ~= nil) then
            networkRequest.ReqBuyItem(self.mShopData.storeId, 1, tableData.itemId, 1);
        end
    else
        if self.mShopData.itemTable ~= nil then
            uimanager:CreatePanel("UIDisposeItemPanel", nil, self.mShopData);
        end
    end
end

function UIShopUnitTemplate:OnResBuyItemMessage(storeInfo)
    if (storeInfo ~= nil) then
        if (not CS.StaticUtility.IsNull(self.go) and self.go.activeSelf) then
            if (self:GetStoreId() == storeInfo.storeId) then
                local storeTable = CS.Cfg_StoreTableManager.Instance:GetStoreItem(self:GetStoreId());
                if (storeTable ~= nil) then
                    luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = storeTable.itemId, from = self:GetUIItem().go.transform.position });
                end
            end
        end
    end
end

function UIShopUnitTemplate:OnClickUIItem()
    local tableData = CS.Cfg_StoreTableManager.Instance:GetStoreItem(self.mShopData.storeId);
    if (tableData ~= nil) then
        local isFind, itemdata = CS.Cfg_ItemsTableManager.Instance:TryGetValue(tableData.itemId);
        if (isFind) then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemdata, showRight = false })
        end
    end
end

--endregion

function UIShopUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetBtnBuy_GameObject()).onClick = function()
        self:OnClickBtnBuy();
    end

    CS.UIEventListener.Get(self:GetUIItem_GameObject()).onClick = function()
        self:OnClickUIItem();
    end

    self.CallOnResBuyItemMessage = function(msgId, msgData)
        self:OnResBuyItemMessage(msgData);
    end
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBuyItemMessage, self.CallOnResBuyItemMessage);
end

function UIShopUnitTemplate:RemoveEvents()
    --if(self.mCoroutineDelayUpdate ~= nil) then
    --    self.mCoroutineDelayUpdate = StopCoroutine(self.mCoroutineDelayUpdate);
    --    self.mCoroutineDelayUpdate = nil;
    --end

    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBuyItemMessage, self.CallOnResBuyItemMessage);
end

--endregion

function UIShopUnitTemplate:Start()
    self:InitEvents();
end

function UIShopUnitTemplate:Init(ownerPanel)
    self.mOwnerPanel = ownerPanel;
    --self:InitEvents();
    self.mOriginPricePosition = self:GetPrice_GameObject().transform.localPosition;
end

function UIShopUnitTemplate:OnDestroy()
    self:RemoveEvents()
end

return UIShopUnitTemplate;