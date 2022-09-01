---@class UIShopViewTemplate
local UIShopViewTemplate = {};

UIShopViewTemplate.mSelectShopType = nil;
--UIShopViewTemplate.mShopUnitDic = {};
--UIShopViewTemplate.mShopDataDic = {};

---选择的商店
UIShopViewTemplate.mChooseStore = nil;

UIShopViewTemplate.mOnPageUnitNum = 999;
---scrollView初始偏移量
UIShopViewTemplate.mScrollViewOriginOffset = nil;
---scrollView初始位置
UIShopViewTemplate.mScrollViewOriginPosition = nil;

---是否重置页ScrollView
UIShopViewTemplate.mIsResetPageScrollView = false;

--region Components

--region GameObject

function UIShopViewTemplate:GetScrollViewSpringPanel()
    if (self.mScrollViewSpringPanel == nil) then
        self.mScrollViewSpringPanel = self:Get("Scroll View", "SpringPanel");
    end
    return self.mScrollViewSpringPanel;
end

function UIShopViewTemplate:GetShopScrollViewPanel()
    if (self.mShopScrollViewPanel == nil) then
        self.mShopScrollViewPanel = self:Get("Scroll View", "UIPanel");
    end
    return self.mShopScrollViewPanel;
end

function UIShopViewTemplate:GetShopViewUnit_GameObject()
    if (self.mShopViewUnit_GameObject == nil) then
        self.mShopViewUnit_GameObject = self:Get("Scroll View/itemgrid/item", "GameObject");
    end
    return self.mShopViewUnit_GameObject;
end

function UIShopViewTemplate:GetUICoinsShowView_GameObject()
    if (self.mUICoinsShowView_GameObject == nil) then
        self.mUICoinsShowView_GameObject = self:Get("CoinsShowView", "GameObject");
    end
    return self.mUICoinsShowView_GameObject;
end

function UIShopViewTemplate:GetShopDesc_UILabel()
    if (self.mGetShopDesc_UILabel == nil) then
        self.mGetShopDesc_UILabel = self:Get("Scroll View/ShopDesc", "UILabel");
    end
    return self.mGetShopDesc_UILabel;
end

---商店描述倒计时组件
---@return UICountdownLabel
function UIShopViewTemplate:GetShopDescCountDown()
    if self.mShopDescCountDown == nil then
        self.mShopDescCountDown = self:Get("Scroll View/ShopDesc", "UICountdownLabel")
    end
    return self.mShopDescCountDown
end
--endregion

--region UILabel

--function UIShopViewTemplate:GetNextRefreshTime_Text()
--    if(self.mNextRefreshTime_Text == nil) then
--        self.mNextRefreshTime_Text = self:Get("");
--    end
--end

--endregion

function UIShopViewTemplate:GetUICoinsShowView()
    if (self.mUICoinsShowView == nil) then
        self.mUICoinsShowView = templatemanager.GetNewTemplate(self:GetUICoinsShowView_GameObject(), luaComponentTemplates.UICoinsShowViewTemplate, self.mOwnerPanel);
    end
    return self.mUICoinsShowView;
end

--function UIShopViewTemplate:GetItemGrid_UIGridContainer()
--    if (self.mItemGrid_UIContainer == nil) then
--        self.mItemGrid_UIContainer = self:Get("Scroll View/itemgrid", "UIGridContainer");
--    end
--    return self.mItemGrid_UIContainer;
--end

function UIShopViewTemplate:GetShopViewUnit()
    if (self.mShopViewUnit == nil) then
        self.mShopViewUnit = templatemanager.GetNewTemplate(self:GetShopViewUnit_GameObject(), luaComponentTemplates.UIShopUnitTemplate, self.mOwnerPanel);
    end
    return self.mShopViewUnit;
end

function UIShopViewTemplate:GetPageViewTemplate()
    if (self.mPageViewTemplate == nil) then
        self.mPageViewTemplate = templatemanager.GetNewTemplate(self.go, luaComponentTemplates.UIPageViewTemplate, self.mOwnerPanel);
    end
    return self.mPageViewTemplate;
end

function UIShopViewTemplate:GetClientEventHandler()
    if (self.mClientHandler == nil) then
        self.mClientHandler = CS.EventHandlerManager(CS.EventHandlerManager.DispatchType.Event)
    end
    return self.mClientHandler;
end

--endregion

--region Method

--region CallFunc

function UIShopViewTemplate:OnResOpenStoreByIdMessage(id, tableData)

    if (self.mSelectShopType == tableData.storeClassId) then
        self:SetShopShow(self.mSelectShopType);
    end

    --if(self.mCoroutineDelayTime ~= nil) then
    --    StopCoroutine(self.mCoroutineDelayTime);
    --    self.mCoroutineDelayTime = nil;
    --end
    --self.mCoroutineDelayTime = StartCoroutine(self.CDelayTime, self)
end

--function UIShopViewTemplate:CDelayTime()
--    --coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(0.2));
--    coroutine.yield(0);
--    coroutine.yield(0);
--
--    --self.go:SetActive(true);
--    self.mCoroutineDelayTime = nil;
--end

--endregion

--region Public

function UIShopViewTemplate:OpenStoreById(shopType, chooseStore)
    self.mIsResetPageScrollView = true;
    networkRequest.ReqOpenStoreById(shopType);
    self.mSelectShopType = shopType;
    --self.go:SetActive(false);
    if (chooseStore ~= nil) then
        self.mChooseStore = chooseStore;
    end
end

function UIShopViewTemplate:ClearStore()
    self:GetPageViewTemplate():ClearUnit();
end

function UIShopViewTemplate:SetShopShow(shopType)
    self:ResetScrollView();
    local targetStoreGameObject;
    local isFindShop, shopVo = CS.CSScene.MainPlayerInfo.StoreInfoV2.StoreDataDic:TryGetValue(shopType)
    if (isFindShop) then
        self.mSelectShopType = shopType;
        local listData = SplitToListSetShopShow(shopVo.storeUnitDic, self.mOnPageUnitNum);
        self:GetPageViewTemplate():Initialize(self.mOnPageUnitNum, shopVo.storeUnitDic.Count, listData, luaComponentTemplates.UIShopPageUnitTemplate);
        if (self.mIsResetPageScrollView) then
            self.mIsResetPageScrollView = false;
            self:GetPageViewTemplate():GetScrollView():ResetPosition();
        end

        if (self.mChooseStore ~= nil) then
            for k, v in pairs(self:GetPageViewTemplate().mUnitComponentDic) do
                local firstChooseGameObject = v:SetChooseStore(self.mChooseStore);
                if (targetStoreGameObject == nil) then
                    targetStoreGameObject = firstChooseGameObject;
                end
            end
        end
        self:UpdateCoinsText();

        if (shopType == LuaEnumStoreType.CommerceDiamond) then
            self:ProcessCommerceDiamond(listData);
        else
            self:ProcessDefault();
        end

        self:GetClientEventHandler():SendEvent(CS.CEvent.UI_ShopSelectChanged, shopVo)
    end

    if (targetStoreGameObject ~= nil) then
        self:TrySetSpringPanel(targetStoreGameObject);
    end
end

---处理默认商店的处理
function UIShopViewTemplate:ProcessDefault()
    if (self:GetShopDesc_UILabel() ~= nil) then
        self:GetShopDesc_UILabel().gameObject:SetActive(false);
    end
end

---处理商会商城的一些特殊处理,例如在在最底层增加显示文本
function UIShopViewTemplate:ProcessCommerceDiamond(listData)
    if (self:GetShopDesc_UILabel() ~= nil) then
        self:GetShopDesc_UILabel().gameObject:SetActive(true);
        if (listData ~= nil and listData[1] ~= nil) then
            local count = #listData[1];
            local line = math.ceil((count / 3))
            self:GetShopDesc_UILabel().transform.localPosition = CS.UnityEngine.Vector3(319, line * -120 + 30, 0);
        else
            local line = 0
            self:GetShopDesc_UILabel().transform.localPosition = CS.UnityEngine.Vector3(319, line * -120 + 30, 0);
        end
        self:RefreshCommerceCountDown()
    end
end

function UIShopViewTemplate:RefreshCommerceCountDown()
    self:GetShopDescCountDown():StartCountDown(100, 6,
            gameMgr:GetGameDataManager():GetLuaStoreData():GetCommerceStoreFlushTime(), "商会商店", "后刷新", nil, function()
                ---倒计时结束时,再次请求一次
                self.mRequestFlushTimeDelayFrameCount = 30
            end)
end

function UIShopViewTemplate:UpdateCoinsText()
    local tabledata = CS.Cfg_StoreClassTableManager.Instance:GetStoreClassWithStoreType(self.mSelectShopType);
    if (tabledata ~= nil) then
        local showCoinsList = tabledata.moneyShow ~= nil and tabledata.moneyShow.list or nil;
        self:GetUICoinsShowView():SetShowCoinsWithList(showCoinsList);
    end
end

function UIShopViewTemplate:TrySetSpringPanel(targetStoreGameObject)
    if (self.mCoroutineSetSpring ~= nil) then
        StopCoroutine(self.mCoroutineSetSpring);
        self.mCoroutineSetSpring = nil;
    end
    self.mCoroutineSetSpring = StartCoroutine(self.CDelaySetSpringPanel, self, targetStoreGameObject);
end

function UIShopViewTemplate:CDelaySetSpringPanel(targetStoreGameObject)
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(0.2));
    self:SetSpringPanel(targetStoreGameObject)
    self.mCoroutineSetSpring = nil;
end

function UIShopViewTemplate:SetSpringPanel(targetStoreGameObject)
    if (not CS.StaticUtility.IsNull(targetStoreGameObject)) then
        local targetY = 191;
        if (targetStoreGameObject.transform.localPosition.y < -(120 * 3)) then
            targetY = math.abs(targetStoreGameObject.transform.localPosition.y) - 191 + 50
        end
        self:GetScrollViewSpringPanel().target = CS.UnityEngine.Vector3(self:GetScrollViewSpringPanel().transform.localPosition.x, targetY, self:GetScrollViewSpringPanel().transform.localPosition.z);
        self:GetScrollViewSpringPanel().enabled = true;
    end
end

--endregion

--region Private

function UIShopViewTemplate:ResetScrollView()
    if (self.mScrollViewOriginPosition ~= nil) then
        self:GetShopScrollViewPanel().transform.localPosition = self.mScrollViewOriginPosition;
    end
    if (self.mScrollViewOriginOffset) then
        self:GetShopScrollViewPanel().clipOffset = self.mScrollViewOriginOffset;
    end
end

function UIShopViewTemplate:InitEvents()
    self.CallFuncResOpenStoreByIdMessage = function(id, tabledata)
        self:OnResOpenStoreByIdMessage(id, tabledata);
        if self.mSelectShopType == LuaEnumStoreType.CommerceDiamond then
            gameMgr:GetGameDataManager():GetLuaStoreData():RequestStoreFlushTime(LuaEnumStoreType.CommerceDiamond)
        end
    end
    self.RefreshCoinTextByMessage = function()
        self:UpdateCoinsText()
    end

    --region NetEvents
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.ResOpenStoreByIdMessage, self.CallFuncResOpenStoreByIdMessage);
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, self.RefreshCoinTextByMessage);
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOpenStoreByIdMessage, self.CallFuncResOpenStoreByIdMessage);
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.StoreFlushTimeRefresh, function(id, data)
        if data == LuaEnumStoreType.CommerceDiamond and self.mSelectShopType == LuaEnumStoreType.CommerceDiamond then
            self:RefreshCommerceCountDown()
        end
    end)
    --endregion
end

function UIShopViewTemplate:RemoveEvents()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResOpenStoreByIdMessage, self.CallFuncResOpenStoreByIdMessage);

    if (self.mCoroutineDelayTime ~= nil) then
        StopCoroutine(self.mCoroutineDelayTime);
        self.mCoroutineDelayTime = nil;
    end

    if (self.mCoroutineSetSpring ~= nil) then
        StopCoroutine(self.mCoroutineSetSpring);
        self.mCoroutineSetSpring = nil;
    end
end

function UIShopViewTemplate:Clear()
    self.mShopViewUnit_GameObject = nil;
    self.mUICoinsShowView_GameObject = nil;
    self.mUICoinsShowView = nil;
    self.mItemGrid_UIContainer = nil;
    self.mShopViewUnit = nil;
    self.mPageViewTemplate = nil;
    self.mSelectShopType = nil;
    self.mClientHandler = nil;
end

--endregion

--endregion

--function UIShopViewTemplate:OnEnable()
--    self:InitEvents();
--end
--
--function UIShopViewTemplate:OnDisable()
--    self:RemoveEvents();
--end

function UIShopViewTemplate:Init(panel)
    ---@type UIBase
    self.mOwnerPanel = panel
    self:InitEvents();
    self.mScrollViewOriginPosition = self:GetShopScrollViewPanel().transform.localPosition;
    self.mScrollViewOriginOffset = self:GetShopScrollViewPanel().clipOffset;
end

function UIShopViewTemplate:OnUpdate()
    if self.mRequestFlushTimeDelayFrameCount then
        self.mRequestFlushTimeDelayFrameCount = self.mRequestFlushTimeDelayFrameCount - 1
        if self.mRequestFlushTimeDelayFrameCount == 0 then
            if self.mSelectShopType == LuaEnumStoreType.CommerceDiamond then
                networkRequest.ReqOpenStoreById(LuaEnumStoreType.CommerceDiamond);
            end
            self.mRequestFlushTimeDelayFrameCount = nil
        end
    end
end

function UIShopViewTemplate:OnDestroy()
    self:RemoveEvents();
    self:Clear();
end

return UIShopViewTemplate;