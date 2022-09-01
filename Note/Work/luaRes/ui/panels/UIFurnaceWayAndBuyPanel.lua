---最开始此面板只用于宝物(created by zyb), 后来改成通用的获取途径(changed by ykj)但是命名没有修改, 所以沿用此命名
---@class UIFurnaceWayAndBuyPanel:UIBase
local UIFurnaceWayAndBuyPanel = {};

UIFurnaceWayAndBuyPanel.mCloseCallBack = nil;

UIFurnaceWayAndBuyPanel.mPanelParams = nil;

UIFurnaceWayAndBuyPanel.mShowGiftRechargeId = 0;
---是否有快捷购买
UIFurnaceWayAndBuyPanel.mIsHasShop = false;
---是否有交易行购买
UIFurnaceWayAndBuyPanel.mIsAuctionCountChange = true;
---@type auctionV2.ResQuickAuctionItem
UIFurnaceWayAndBuyPanel.mQuickAuctionItems = nil

---@type auctionV2.ResQuickAuctionItem 上次交易行的数据缓存
UIFurnaceWayAndBuyPanel.mLastQuickAuctionItems = nil;
--region Components

--region GameObject
function UIFurnaceWayAndBuyPanel:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/root/events/btn_close", "GameObject");
    end
    return self.mBtnClose_GameObject;
end

function UIFurnaceWayAndBuyPanel:GetBackGround_GameObject()
    if (self.mBackGround_GameObject == nil) then
        self.mBackGround_GameObject = self:GetCurComp("WidgetRoot/root/events/box", "GameObject");
    end
    return self.mBackGround_GameObject;
end

---@return UILabel
function UIFurnaceWayAndBuyPanel:GetGiftWayLabel_Text()
    if (self.mGiftWayLabel_Text == nil) then
        self.mGiftWayLabel_Text = self:GetCurComp("WidgetRoot/root/view/ScrollView/quickGift", "UILabel");
    end
    return self.mGiftWayLabel_Text;
end

---交易行快捷购买
---@return UILabel
function UIFurnaceWayAndBuyPanel:GetAuctionWayGetLabel_Text()
    if self.mAuctionWayGetLabel_Text == nil then
        self.mAuctionWayGetLabel_Text = self:GetCurComp("WidgetRoot/root/view/ScrollView/auctionBuy", "UILabel")
    end
    return self.mAuctionWayGetLabel_Text
end

function UIFurnaceWayAndBuyPanel:GetShopWayLabel_GameObject()
    if (self.mShopWayLabel_GameObject == nil) then
        self.mShopWayLabel_GameObject = self:GetCurComp("WidgetRoot/root/view/ScrollView/quickBuy", "GameObject");
    end
    return self.mShopWayLabel_GameObject;
end

function UIFurnaceWayAndBuyPanel:GetOtherWayLabel_GameObject()
    if (self.mOtherWayLabel_GameObject == nil) then
        self.mOtherWayLabel_GameObject = self:GetCurComp("WidgetRoot/root/view/ScrollView/otherWay", "GameObject");
    end
    return self.mOtherWayLabel_GameObject;
end

function UIFurnaceWayAndBuyPanel:GetOtherWayLabel_UILabel()
    if (self.mOtherWayLabel_UILabel == nil) then
        self.mOtherWayLabel_UILabel = self:GetCurComp("WidgetRoot/root/view/ScrollView/otherWay", "UILabel");
    end
    return self.mOtherWayLabel_UILabel;
end

--function UIFurnaceWayAndBuyPanel:GetLeftArrowBackGround_GameObject()
--    if(self.mLeftArrowBackGround_GameObject == nil) then
--        self.mLeftArrowBackGround_GameObject = self:GetCurComp("WidgetRoot/root/window/background/Sprite0","GameObject");
--    end
--    return self.mLeftArrowBackGround_GameObject;
--end

--function UIFurnaceWayAndBuyPanel:GetDownArrowBackGround_GameObject()
--    if(self.mDownArrowBackGround_GameObject == nil) then
--        self.mDownArrowBackGround_GameObject = self:GetCurComp("WidgetRoot/root/window/background/Sprite1","GameObject");
--    end
--    return self.mDownArrowBackGround_GameObject;
--end

function UIFurnaceWayAndBuyPanel:GetWindowRoot_GameObject()
    if (self.mWindowRoot_GameObject == nil) then
        self.mWindowRoot_GameObject = self:GetCurComp("WidgetRoot/root", "GameObject");
    end
    return self.mWindowRoot_GameObject;
end

function UIFurnaceWayAndBuyPanel:GetWidgetRoot_Transform()
    if (self.mWidgetRoot_Transform == nil) then
        self.mWidgetRoot_Transform = self:GetCurComp("WidgetRoot", "Transform");
    end
    return self.mWidgetRoot_Transform;
end

function UIFurnaceWayAndBuyPanel:GetUITable_UITable()
    if (self.mUITable_UITable == nil) then
        self.mUITable_UITable = self:GetCurComp("WidgetRoot/root/view/ScrollView", "UITable");
        --self.mUITable_UITable.IsDealy = true;
    end
    return self.mUITable_UITable;
end

function UIFurnaceWayAndBuyPanel:GetScrollView()
    if (self.mScrollView == nil) then
        self.mScrollView = self:GetCurComp("WidgetRoot/root/view/ScrollView", "UIScrollView");
    end
    return self.mScrollView;
end

function UIFurnaceWayAndBuyPanel:GetScrollViewPanel()
    if (self.mScrollViewPanel == nil) then
        self.mScrollViewPanel = self:GetCurComp("WidgetRoot/root/view/ScrollView", "UIPanel");
    end
    return self.mScrollViewPanel;
end

function UIFurnaceWayAndBuyPanel:GetRootWidget_UIWidget()
    if (self.mRootWidget_UIWidget == nil) then
        self.mRootWidget_UIWidget = self:GetCurComp("WidgetRoot/root", "UIWidget");
    end
    return self.mRootWidget_UIWidget;
end

---@return UIWayGetAndBuyViewTemplate
function UIFurnaceWayAndBuyPanel:GetWayGetAndBuyViewTemplate()
    if (self.mWayGetAndBuyViewTemplate == nil) then
        self.mWayGetAndBuyViewTemplate = templatemanager.GetNewTemplate(self:GetCurComp("WidgetRoot/root/view", "GameObject"), luaComponentTemplates.UIWayGetAndBuyViewTemplate, self.EntranceWay, self);
    end
    return self.mWayGetAndBuyViewTemplate;
end

function UIFurnaceWayAndBuyPanel:GetArrowDialogViewComponent()
    if (self.mArrowDialogViewComponent == nil) then
        self.mArrowDialogViewComponent = CS.Utility_Lua.GetComponent(self:GetWindowRoot_GameObject(), 'UIArrowDialogView');
    end
    return self.mArrowDialogViewComponent;
end

--function UIFurnaceWayAndBuyPanel:GetArrowLeftRootPosition()
--    return CS.UnityEngine.Vector3(150,0,0);
--end
--
--function UIFurnaceWayAndBuyPanel:GetArrowDownRootPosition()
--    return CS.UnityEngine.Vector3(-150,445,0);
--end

--endregion

--endregion

--region Method

--region Public

--endregion

--region Private

function UIFurnaceWayAndBuyPanel:InitEvents()
    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIFurnaceWayAndBuyPanel");
    end
    CS.UIEventListener.Get(self:GetBackGround_GameObject()).onClick = function()
        uimanager:ClosePanel("UIFurnaceWayAndBuyPanel");
    end

    self.CallOnResBuyItemMessage = function(msgId, msgData)
        ---@type CSStoreInfoV2
        local storeInfoV2 = CS.CSScene.MainPlayerInfo.StoreInfoV2
        local storeInfo = storeInfoV2:GetStoreInfo(msgData.storeId);

        if (storeInfo == nil) then
            self:UpdateUI();
        else
            self:UpdateWayGet();
        end
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBuyItemMessage, self.CallOnResBuyItemMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResQuickAuctionItemMessage, function(msgID, data)
        if (self.mLastQuickAuctionItems ~= nil) then
            self.mIsAuctionCountChange = #self.mLastQuickAuctionItems.items ~= #data.items;
        else
            self.mIsAuctionCountChange = true;
        end
        ---@type auctionV2.ResQuickAuctionItem
        self.mLastQuickAuctionItems = data;
        self.mQuickAuctionItems = data
        self:RefreshAuctionItems();
        if (self.mIsAuctionCountChange) then
            self:UpdateUI();
        else
            self:UpdateWayGet();
        end
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBuyAuctionItemMessage, function(msgID, data)
        ---@type auctionV2.ItemMsg
        local dataTemp = data
        self:GetWayGetAndBuyViewTemplate():PlayAuctionBuyResultAnimation(dataTemp)
        self:RequestQuickAuctionData()
    end)
    -- self:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerBeginWalk, UIFurnaceWayAndBuyPanel.MainPlayerBeginWalk)
    self:GetClientEventHandler():AddEvent(CS.CEvent.OpenPanel, UIFurnaceWayAndBuyPanel.OpenPanelCallBack)

end
--endregion

--endregion

function UIFurnaceWayAndBuyPanel:Init()
    self.mQuickAuctionBuyDic = {}
    self.mWayGetDic = {};
    self:AddCollider();
    self:InitEvents();
end

---@param furnacePanelOpenType LuaEnumFurnaceOpenType
function UIFurnaceWayAndBuyPanel:Show(customData)
    local itemId;
    local globalId;
    if (customData == nil) then
        customData = {};
    end

    if (customData.itemId ~= nil) then
        itemId = customData.itemId;
    end

    if (customData.globalId ~= nil) then
        globalId = customData.globalId;
    end

    if (customData.arrowDir == nil) then
        customData.arrowDir = LuaEnumWayGetPanelArrowDirType.Down;
    end

    if (customData.offset == nil) then
        customData.offset = CS.UnityEngine.Vector2.zero;
    end

    if (customData.isAutoArrow == nil) then
        customData.isAutoArrow = true;
    end

    if (customData.titleName == nil) then
        self:GetOtherWayLabel_UILabel().text = "  获取途径"
    else
        self:GetOtherWayLabel_UILabel().text = customData.titleName
    end

    if (customData.closeCallBack ~= nil) then
        self.mCloseCallBack = customData.closeCallBack;
    end
    if (customData.EntranceWay ~= nil) then
        self.EntranceWay = customData.EntranceWay
    end

    if (customData.dependPanel ~= nil) then
        self.mDependPanel = customData.dependPanel;
    end

    self:GetBackGround_GameObject():SetActive(customData.isShowBox == nil or customData.isShowBox == true)

    self.mPanelParams = customData;
    self:RequestQuickAuctionData()
    self:GetWidgetRoot_Transform().gameObject:SetActive(false);
    self:RefreshAuctionItems()
    self:UpdateUI();
end

---请求交易行快捷购买数据
function UIFurnaceWayAndBuyPanel:RequestQuickAuctionData()
    ---每次请求前先清除数据
    self.mQuickAuctionItems = nil
    if self.mPanelParams == nil then
        return
    end
    local itemId = self.mPanelParams.itemId;
    if itemId == nil then
        return
    end
    local tblData
    local temp = clientTableManager.cfg_wayget_fastauctionManager:TryGetValue(itemId)
    if temp == nil then
        local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
        tblData = clientTableManager.cfg_wayget_fastauctionManager:TryGetValue(itemInfo:GetLinkItemId())
    else
        tblData = clientTableManager.cfg_wayget_fastauctionManager:TryGetValue(itemId)
    end

    if tblData == nil then
        return
    end
    local items = tblData:GetItems()
    if items ~= nil and items.list ~= nil and #items.list > 0 then
        networkRequest.ReqQuickAuctionItem(items.list)
    end
end

function UIFurnaceWayAndBuyPanel:UpdateUI()
    if (self.mPanelParams == nil) then
        return uimanager:ClosePanel("UIFurnaceWayAndBuyPanel");
    end

    self:UpdateWayGetData();
    --self:RefreshAuctionItems()
    if (self.mWayGetInfo == nil) then
        uimanager:ClosePanel("UIFurnaceWayAndBuyPanel");
    end

    if (not self.mIsHasShop or self.mIsAuctionCountChange) then
        self:UpdateWayGet();
    end
end

---@private 更新获取途径数据
function UIFurnaceWayAndBuyPanel:UpdateWayGetData()
    self.mIsHasShop = false;
    local itemId = self.mPanelParams.itemId;
    local globalId = self.mPanelParams.globalId;
    local wayGetArray = self.mPanelParams.wayGetArray;
    local bossTimesBuy = self.mPanelParams.bossTimesBuy

    self.mWayGetInfo = {};
    if itemId ~= nil then
        local isGetValue, tableValue = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
        if isGetValue and tableValue.wayGet ~= nil then
            local length = tableValue.wayGet.list.Count - 1
            for k = 0, length do
                local wayGetId = tableValue.wayGet.list[k]
                table.insert(self.mWayGetInfo, wayGetId)
            end
        end
    elseif globalId ~= nil then
        local globalInfoIsFind, globalInfo = CS.Cfg_GlobalTableManager.Instance:TryGetValue(globalId)
        if globalInfoIsFind then
            local strings = string.Split(globalInfo.value, '#')
            for k, v in pairs(strings) do
                table.insert(self.mWayGetInfo, tonumber(v));
            end
        end
    elseif wayGetArray ~= nil then
        if type(wayGetArray) == "table" and #wayGetArray > 0 then
            for i = 1, #wayGetArray do
                table.insert(self.mWayGetInfo, wayGetArray[i])
            end
        end
    elseif bossTimesBuy then
        self.mWayGetDic[LuaEnumWayGetType.BossTimeAdd] = bossTimesBuy;
    end

    self.mWayGetDic[LuaEnumWayGetType.QuickBuy] = {};
    self.mWayGetDic[LuaEnumWayGetType.Gift] = {};
    self.mWayGetDic[LuaEnumWayGetType.QuickGet] = {};
    --self.mWayGetDic[LuaEnumWayGetType.QuickAuctionBuy] = {};

    if (self.mWayGetInfo ~= nil) then
        for k, v in pairs(self.mWayGetInfo) do
            local wayGetInfoIsFind, wayGetInfoTemp = CS.Cfg_Way_GetTableManager.Instance:TryGetValue(v)
            if wayGetInfoIsFind then
                if (wayGetInfoTemp.conditions ~= nil and wayGetInfoTemp.conditions.list.Count > 0) then
                    if (CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(wayGetInfoTemp.conditions.list)) then
                        self:CheckAddReplaceGift(wayGetInfoTemp, function()
                            self:UpdateWayGet();
                        end, function()
                            self:UpdateWayGet();
                        end);
                    end
                else
                    self:CheckAddReplaceGift(wayGetInfoTemp, function()
                        self:UpdateWayGet();
                    end, function()
                        self:UpdateWayGet();
                    end);
                end
            end
        end
    end
end

function UIFurnaceWayAndBuyPanel:UpdateWayGet()
    if (CS.StaticUtility.IsNull(self.go) or CS.StaticUtility.IsNull(self:GetWayGetAndBuyViewTemplate().go)) then
        return ;
    end
    if (self.mWayGetDic ~= nil) then
        self:GetWayGetAndBuyViewTemplate():UpdateView(self.mWayGetDic);
        if (self:GetGiftWayLabel_Text().gameObject.activeSelf) then
            if (self.mShowGiftRechargeId ~= 0) then
                local isFind, rechargeTable = CS.Cfg_RechargeTableManager.Instance:TryGetValue(self.mShowGiftRechargeId);
                if (isFind) then
                    self:GetGiftWayLabel_Text().text = "  " .. rechargeTable.name;
                end
            end
        end
        if (self.mWayGetDic[LuaEnumWayGetType.QuickAuctionBuy] == nil) then
            self.mWayGetDic[LuaEnumWayGetType.QuickAuctionBuy] = {};
        end

        self:GetShopWayLabel_GameObject():SetActive(#self.mWayGetDic[LuaEnumWayGetType.QuickBuy] > 0);
        self:GetOtherWayLabel_GameObject():SetActive(#self.mWayGetDic[LuaEnumWayGetType.QuickGet] > 0);
        self:GetGiftWayLabel_Text().gameObject:SetActive(#self.mWayGetDic[LuaEnumWayGetType.Gift] > 0);
        self:GetAuctionWayGetLabel_Text().gameObject:SetActive(#self.mWayGetDic[LuaEnumWayGetType.QuickAuctionBuy] > 0)
    end
    self:UpdateArrowWindow();
    self:GetWidgetRoot_Transform().gameObject:SetActive(true);
end

function UIFurnaceWayAndBuyPanel:UpdateArrowWindow()
    local isRefreshHideItem = self.mPanelParams.isRefreshHideItem == true or self.mPanelParams.target.activeInHierarchy == true
    if (self.mPanelParams ~= nil and self.mPanelParams.target ~= nil and not CS.StaticUtility.IsNull(self.mPanelParams.target)) and isRefreshHideItem then
        self:UpdateArrowComponent(self.mPanelParams.arrowDir, self.mPanelParams.target.transform.position, self.mPanelParams.offset);
    end
    self:GetUITable_UITable().enabled = true
    self:GetUITable_UITable():Reposition();
    self.mDelayUpdateScrollViewFrameCount = 10;
end

function update()
    if (UIFurnaceWayAndBuyPanel.mDelayUpdateScrollViewFrameCount ~= nil and UIFurnaceWayAndBuyPanel.mDelayUpdateScrollViewFrameCount > 0) then
        UIFurnaceWayAndBuyPanel.mDelayUpdateScrollViewFrameCount = UIFurnaceWayAndBuyPanel.mDelayUpdateScrollViewFrameCount - 1;
        if (UIFurnaceWayAndBuyPanel.mDelayUpdateScrollViewFrameCount <= 0) then
            UIFurnaceWayAndBuyPanel:GetScrollView():ResetPosition();
        end
    end
end

---@param wayGetTable TABLE.CFG_WAY_GET
function UIFurnaceWayAndBuyPanel:CheckAddReplaceGift(wayGetTable, successCallBack, failCallBack)
    if (wayGetTable == nil) then
        return ;
    end

    if (wayGetTable.openType == LuaEnumWayGetFuncType.BuyCommodity) then
        local isReplace = false;
        if (wayGetTable.priority ~= nil and wayGetTable.priority.list.Count > 0) then
            local targetId = wayGetTable.priority.list[0];
            local isFind, targetTable = CS.Cfg_Way_GetTableManager.Instance:TryGetValue(targetId);
            if (isFind) then
                if (targetTable.openType == LuaEnumWayGetFuncType.BuyGift) then
                    local isHas, rechargeId = CS.Cfg_Way_GetTableManager.Instance:HasGiftReplaceToQuickBuy(targetTable);
                    if (isHas) then
                        if (not Utility.HasTableValue(self.mWayGetDic[LuaEnumWayGetType.Gift], targetTable.id)) then
                            isReplace = true;
                            table.insert(self.mWayGetDic[LuaEnumWayGetType.Gift], targetTable.id);
                            self.mShowGiftRechargeId = rechargeId;
                        end
                    end
                end
            end
        end
        if (not isReplace) then
            self.mIsHasShop = true;
            self:TryGetWayGetStore(wayGetTable, function()
                ---
                self.mWayGetDic[LuaEnumWayGetType.QuickBuy] = {};
                local isExistInAuctionItems = false
                if wayGetTable.openPanel then
                    local storeIdStrs = string.Split(wayGetTable.openPanel, '#')
                    if #storeIdStrs > 0 then
                        local storeId = tonumber(storeIdStrs[1])
                        if storeId then
                            ---@type TABLE.CFG_STORE
                            local tblExist, tbl = CS.Cfg_StoreTableManager.Instance:TryGetValue(storeId)
                            if tbl then
                                if self.mQuickAuctionCoinTypeDic[tbl.moneyType] then
                                    isExistInAuctionItems = true
                                end
                            end
                        end
                    end
                end
                if isExistInAuctionItems then
                    ---如果交易行中有对应的货币选项,则不往商城物品列表中加入该物品
                    return
                end
                table.insert(self.mWayGetDic[LuaEnumWayGetType.QuickBuy], wayGetTable.id);
                if (successCallBack ~= nil) then
                    successCallBack();
                end
            end, function()
                local hasWayGetId = false;
                local pos = 0;
                for k, v in pairs(self.mWayGetDic[LuaEnumWayGetType.QuickBuy]) do
                    if (v == wayGetTable.id) then
                        hasWayGetId = true;
                        pos = k;
                        break ;
                    end
                end
                if (hasWayGetId) then
                    table.remove(self.mWayGetDic[LuaEnumWayGetType.QuickBuy], pos);
                end
                if (failCallBack ~= nil) then
                    failCallBack();
                end
            end);
        end
    elseif (wayGetTable.openType == LuaEnumWayGetFuncType.BuyGift) then
        local isHas, rechargeId = CS.Cfg_Way_GetTableManager.Instance:HasGiftReplaceToQuickBuy(wayGetTable);
        if (isHas) then
            if (not Utility.HasTableValue(self.mWayGetDic[LuaEnumWayGetType.Gift], wayGetTable.id)) then
                table.insert(self.mWayGetDic[LuaEnumWayGetType.Gift], wayGetTable.id);
                self.mShowGiftRechargeId = rechargeId;
            end
        end
    else
        table.insert(self.mWayGetDic[LuaEnumWayGetType.QuickGet], wayGetTable.id);
    end
end

function UIFurnaceWayAndBuyPanel:TryGetWayGetStore(wayGetTable, successCallBack, failCallBack)
    local itemParams = string.Split(wayGetTable.openPanel, '#')
    if #itemParams >= 3 then
        local storeId = ternary(itemParams[1] == "", 0, tonumber(itemParams[1]))
        local isFind, storeTable = CS.Cfg_StoreTableManager.Instance:TryGetValue(storeId);

        if (isFind and storeId) then
            ---@class CSStoreInfoV2
            local storeInfoV2 = CS.CSScene.MainPlayerInfo.StoreInfoV2
            storeInfoV2:TryGetStoreInfo(storeId, function()
                --self.mStoreCallBackDic[storeId] = nil
                local isFindTemp, storeDataList = CS.Cfg_Way_GetTableManager.Instance:TryGetWayGetTableStore(wayGetTable);
                if (isFindTemp) then
                    if (storeDataList.Count > 0) then
                        local storeIdTemp = storeDataList[0];
                        --print(wayGetTable.id, storeIdTemp)
                        local storeInfo = CS.CSScene.MainPlayerInfo.StoreInfoV2:GetStoreInfo(storeIdTemp);
                        if (storeInfo ~= nil) then
                            if (successCallBack ~= nil) then
                                successCallBack();
                            end
                        else
                            if (failCallBack ~= nil) then
                                failCallBack();
                            end
                        end
                    end
                end
            end);
        end
    end
end

function UIFurnaceWayAndBuyPanel:UpdateArrowComponent(arrowDirType, wordPosition, offset)
    local labelHeight = (self:GetShopWayLabel_GameObject().activeSelf and 20 + self:GetUITable_UITable().padding.y or 0)
            + (self:GetOtherWayLabel_GameObject().activeSelf and 20 + self:GetUITable_UITable().padding.y or 0)
            + (self:GetAuctionWayGetLabel_Text().gameObject.activeSelf and 20 + self:GetUITable_UITable().padding.y or 0);
    local otherHeight = 20 + self:GetUITable_UITable().padding.y * self:GetWayGetAndBuyViewTemplate():GetGridUnitIntervalCount() + labelHeight;
    local scrollViewHeight = self:GetWayGetAndBuyViewTemplate():GetContentHeight() + otherHeight;
    local height = scrollViewHeight + 20;
    local scrollViewPanel = self:GetScrollViewPanel();
    if (scrollViewPanel ~= nil) then
        local centerX = scrollViewPanel.clipRange.x;
        local sizeX = scrollViewPanel.clipRange.z;
        scrollViewPanel.clipRange = CS.UnityEngine.Vector4(centerX, -scrollViewHeight / 2, sizeX, scrollViewHeight);
    end
    self:GetArrowDialogViewComponent():UpdateView(arrowDirType, wordPosition, offset, height);
end

---刷新交易行物品列表
function UIFurnaceWayAndBuyPanel:RefreshAuctionItems()
    ---交易行中已有的货币类型,在商店列表中需要规避掉
    self.mQuickAuctionCoinTypeDic = {}
    self.mWayGetDic[LuaEnumWayGetType.QuickAuctionBuy] = {};
    if self.mQuickAuctionItems == nil or self.mQuickAuctionItems.items == nil or #self.mQuickAuctionItems.items == 0 then
        return
    end

    local quickBuyList = self.mWayGetDic[LuaEnumWayGetType.QuickBuy]
    local quickAuctionBuyList = self.mWayGetDic[LuaEnumWayGetType.QuickAuctionBuy]
    if quickAuctionBuyList == nil or quickBuyList == nil then
        return
    end
    ---处理交易行快捷购买列表
    for i = 1, #self.mQuickAuctionItems.items do
        local auctionItem = self.mQuickAuctionItems.items[i]
        if auctionItem.priceSpecified and auctionItem.price ~= nil then
            table.insert(quickAuctionBuyList, auctionItem)
            self.mQuickAuctionCoinTypeDic[auctionItem.price.itemId] = true
        end
    end

    ---如果交易行里面有某货币物品,则删掉商城快捷购买里对应货币的物品
    for i = #quickBuyList, 1, -1 do
        local waygetId = quickBuyList[i]
        local waygetTbl = clientTableManager.cfg_way_getManager:TryGetValue(waygetId)
        if waygetTbl and waygetTbl:GetOpenType() == 3 then
            ---如果是快捷购买里的物品,检查下是否在交易行快捷列表里能找到对应货币的物品,如果有的话,那么删掉快捷购买队列里的物品
            local str = waygetTbl:GetOpenPanel()
            local splitedStrs = string.Split(str, '#')
            if #splitedStrs >= 2 then
                local storeItemId = tonumber(splitedStrs[1])
                ---@type TABLE.CFG_STORE
                local tblExist, tbl = CS.Cfg_StoreTableManager.Instance:TryGetValue(storeItemId)
                if tbl and self.mQuickAuctionCoinTypeDic[tbl.moneyType] then
                    ---如果交易行中有对应货币的物品的话,移除商城列表中的对应物品
                    table.remove(quickBuyList, i)
                end
            end
        end
    end

end

function UIFurnaceWayAndBuyPanel.MainPlayerBeginWalk()
    uimanager:ClosePanel("UIFurnaceWayAndBuyPanel")
end

function UIFurnaceWayAndBuyPanel.OpenPanelCallBack(id, panelName)
    if panelName ~= "UIFurnaceWayAndBuyPanel" and panelName ~= "UIItemInfoPanel" and panelName ~= "UIBubbleTipsPanel" then
        uimanager:ClosePanel("UIFurnaceWayAndBuyPanel")
    end
end

function ondestroy()
    if (UIFurnaceWayAndBuyPanel.mCloseCallBack ~= nil) then
        UIFurnaceWayAndBuyPanel.mCloseCallBack();
    end

    if (UIFurnaceWayAndBuyPanel.mDependPanel ~= nil) then
        uimanager:ClosePanel(UIFurnaceWayAndBuyPanel.mDependPanel);
    end

    --UIFurnaceWayAndBuyPanel.mStoreCallBackDic = nil
end

return UIFurnaceWayAndBuyPanel;