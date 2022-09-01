local UIShopPanel = {}

UIShopPanel.selectId = nil;
UIShopPanel.PanelLayerType = CS.UILayerType.WindowsPanel;

UIShopPanel.mChooseStore = nil;

---按钮字典
UIShopPanel.mToggleDic = nil;

--region Components
--region GameObject
function UIShopPanel.GetTglCommon_GameObject()
    if (UIShopPanel.mTglCommon_GameObject == nil) then
        UIShopPanel.mTglCommon_GameObject = UIShopPanel:GetCurComp("WidgetRoot/events/toggles/btn_common", "GameObject");
    end
    return UIShopPanel.mTglCommon_GameObject;
end

function UIShopPanel.GetTglCommon_UIToggle()
    if (UIShopPanel.mTglCommon_UIToggle == nil) then
        UIShopPanel.mTglCommon_UIToggle = UIShopPanel:GetCurComp("WidgetRoot/events/toggles/btn_common", "UIToggle");
    end
    return UIShopPanel.mTglCommon_UIToggle;
end

--function UIShopPanel.GetTglBianQiang_GameObject()
--    if (UIShopPanel.mTglBianQiang_GameObject == nil) then
--        UIShopPanel.mTglBianQiang_GameObject = UIShopPanel:GetCurComp("WidgetRoot/events/toggles/btn_bianqiang", "GameObject");
--    end
--    return UIShopPanel.mTglBianQiang_GameObject;
--end

function UIShopPanel.GetTglLiquan_GameObject()
    if (UIShopPanel.mTglLiquan_GameObject == nil) then
        UIShopPanel.mTglLiquan_GameObject = UIShopPanel:GetCurComp("WidgetRoot/events/toggles/btn_liquan", "GameObject");
    end
    return UIShopPanel.mTglLiquan_GameObject;
end

function UIShopPanel.GetTglLiquan_UIToggle()
    if (UIShopPanel.mTglLiquan_UIToggle == nil) then
        UIShopPanel.mTglLiquan_UIToggle = UIShopPanel:GetCurComp("WidgetRoot/events/toggles/btn_liquan", "UIToggle");
    end
    return UIShopPanel.mTglLiquan_UIToggle;
end

function UIShopPanel.GetTglWeeklyPurchase_GameObject()
    if (UIShopPanel.mTglWeeklyPurchase_GameObject == nil) then
        UIShopPanel.mTglWeeklyPurchase_GameObject = UIShopPanel:GetCurComp("WidgetRoot/events/toggles/btn_weeklyPurchase", "GameObject");
    end
    return UIShopPanel.mTglWeeklyPurchase_GameObject;
end

function UIShopPanel.GetTglWeeklyPurchase_UIToggle()
    if (UIShopPanel.mTglWeeklyPurchase_UIToggle == nil) then
        UIShopPanel.mTglWeeklyPurchase_UIToggle = UIShopPanel:GetCurComp("WidgetRoot/events/toggles/btn_weeklyPurchase", "UIToggle");
    end
    return UIShopPanel.mTglWeeklyPurchase_UIToggle;
end

function UIShopPanel.GetTglGold_UIToggle()
    if (UIShopPanel.mTglGold_UIToggle == nil) then
        UIShopPanel.mTglGold_UIToggle = UIShopPanel:GetCurComp("WidgetRoot/events/toggles/btn_gold", "UIToggle");
    end
    return UIShopPanel.mTglGold_UIToggle;
end

function UIShopPanel.GetTglGold_GameObject()
    if (UIShopPanel.mTglGold_GameObject == nil) then
        UIShopPanel.mTglGold_GameObject = UIShopPanel:GetCurComp("WidgetRoot/events/toggles/btn_gold", "GameObject");
    end
    return UIShopPanel.mTglGold_GameObject;
end

function UIShopPanel.GetTglCommerceShop_UIToggle()
    if (UIShopPanel.mTglCommerceShop_UIToggle == nil) then
        UIShopPanel.mTglCommerceShop_UIToggle = UIShopPanel:GetCurComp("WidgetRoot/events/toggles/btn_CommerceShop", "UIToggle");
    end
    return UIShopPanel.mTglCommerceShop_UIToggle;
end

function UIShopPanel.GetTglCommerceShop_GameObject()
    if (UIShopPanel.mTglCommerceShop_GameObject == nil) then
        UIShopPanel.mTglCommerceShop_GameObject = UIShopPanel:GetCurComp("WidgetRoot/events/toggles/btn_CommerceShop", "GameObject");
    end
    return UIShopPanel.mTglCommerceShop_GameObject;
end

function UIShopPanel.GetBtnClose_GameObject()
    if (UIShopPanel.mBtnClose_GameObject == nil) then
        UIShopPanel.mBtnClose_GameObject = UIShopPanel:GetCurComp("WidgetRoot/events/btn_close", "GameObject");
    end
    return UIShopPanel.mBtnClose_GameObject;
end

function UIShopPanel.GetShopViewTemplate_GameObject()
    if (UIShopPanel.mShopViewTemplate_GameObject == nil) then
        UIShopPanel.mShopViewTemplate_GameObject = UIShopPanel:GetCurComp("WidgetRoot/view", "GameObject");
    end
    return UIShopPanel.mShopViewTemplate_GameObject;
end

--function UIShopPanel.GetBackGround_GameObject()
--    if (UIShopPanel.mBackGround_GameObject == nil) then
--        UIShopPanel.mBackGround_GameObject = UIShopPanel:GetCurComp("WidgetRoot/window/box", "GameObject");
--    end
--    return UIShopPanel.mBackGround_GameObject;
--end

function UIShopPanel.GetBtnRecharge_GameObject()
    if (UIShopPanel.mBtnRecharge_GameObject == nil) then
        UIShopPanel.mBtnRecharge_GameObject = UIShopPanel:GetCurComp("WidgetRoot/events/btn_recharge", "GameObject");
    end
    return UIShopPanel.mBtnRecharge_GameObject;
end
--endregion

--region UILabel

function UIShopPanel.GetNextRefreshTime_Text()
    if (UIShopPanel.mNextRefreshTime_Text == nil) then
        UIShopPanel.mNextRefreshTime_Text = UIShopPanel:GetCurComp("WidgetRoot/window/CountDown", "UILabel");
    end
    return UIShopPanel.mNextRefreshTime_Text;
end

--endregion
--function UIShopPanel.GetTglGrid_UIGrid()
--    if (UIShopPanel.mTglGrid_UIGrid == nil) then
--        UIShopPanel.mTglGrid_UIGrid = UIShopPanel:GetCurComp("WidgetRoot/events/toggles", "UIGrid");
--    end
--    return UIShopPanel.mTglGrid_UIGrid;
--end

function UIShopPanel.GetShopViewTemplate()
    if (UIShopPanel.mShopViewTemplate == nil) then
        UIShopPanel.mShopViewTemplate = templatemanager.GetNewTemplate(UIShopPanel.GetShopViewTemplate_GameObject(), luaComponentTemplates.UIShopViewTemplate, UIShopPanel);
    end
    return UIShopPanel.mShopViewTemplate;
end

function UIShopPanel.GetGridPageList_UIGridContainer()
    if (UIShopPanel.mGridPageList_UIGridContainer == nil) then
        UIShopPanel.mGridPageList_UIGridContainer = UIShopPanel:GetCurComp("WidgetRoot/view/page1", "UIGridContainer");
    end
    return UIShopPanel.mGridPageList_UIGridContainer;
end

---格子页标记
function UIShopPanel.GetGridPageList_UIGridContainer()
    if UIShopPanel.mGridPageList_UIGridContainer == nil then
        UIShopPanel.mGridPageList_UIGridContainer = UIShopPanel:GetCurComp("WidgetRoot/view/page1", "UIGridContainer")
    end
    return UIShopPanel.mGridPageList_UIGridContainer
end

function UIShopPanel.GetToggleWithShopType(shopType)
    if (shopType == LuaEnumStoreType.GoldShop) then
    elseif (shopType == LuaEnumStoreType.Diamond) then
    elseif (shopType == LuaEnumStoreType.WeeklyPurchaseShop) then
    elseif (shopType == LuaEnumStoreType.YuanBao) then
    end
end

--region VIP
function UIShopPanel:GetVipRoot_GameObject()
    if (self.mVipRootGo == nil) then
        self.mVipRootGo = self:GetCurComp("WidgetRoot/view/Vip", "GameObject")
    end
    return self.mVipRootGo
end

function UIShopPanel:GetVipLevel_UILabel()
    if (self.mVipLevel == nil) then
        self.mVipLevel = self:GetCurComp("WidgetRoot/view/Vip/viplv", "Top_UILabel")
    end
    return self.mVipLevel
end

function UIShopPanel:GetVipProgress_UISlider()
    if (self.mVipProgress == nil) then
        self.mVipProgress = self:GetCurComp("WidgetRoot/view/Vip/Slider", "Top_UISlider")
    end
    return self.mVipProgress
end

function UIShopPanel:GetVipExp_UILabel()
    if (self.mVipExp == nil) then
        self.mVipExp = self:GetCurComp("WidgetRoot/view/Vip/Slider/num", "Top_UILabel")
    end
    return self.mVipExp
end
--endregion

--endregion

--region Method

function UIShopPanel.Initialize()
    if (UIShopPanel.mToggleDic == nil) then
        UIShopPanel.mToggleDic = {};
    end
    if (UIShopPanel.GetTglGold_UIToggle().gameObject.activeSelf) then
        UIShopPanel.mToggleDic[LuaEnumStoreType.GoldShop] = UIShopPanel.GetTglGold_UIToggle();
    end
    if (UIShopPanel.GetTglCommon_UIToggle().gameObject.activeSelf) then
        UIShopPanel.mToggleDic[LuaEnumStoreType.Diamond] = UIShopPanel.GetTglCommon_UIToggle();
    end
    if (UIShopPanel.GetTglWeeklyPurchase_UIToggle().gameObject.activeSelf) then
        UIShopPanel.mToggleDic[LuaEnumStoreType.WeeklyPurchaseShop] = UIShopPanel.GetTglWeeklyPurchase_UIToggle();
    end
    if (UIShopPanel.GetTglLiquan_UIToggle().gameObject.activeSelf) then
        UIShopPanel.mToggleDic[LuaEnumStoreType.YuanBao] = UIShopPanel.GetTglLiquan_UIToggle();
    end

    if (UIShopPanel.GetTglCommerceShop_UIToggle().gameObject.activeSelf) then
        UIShopPanel.mToggleDic[LuaEnumStoreType.CommerceDiamond] = UIShopPanel.GetTglCommerceShop_UIToggle();
    end
end

function UIShopPanel:InitEvents()
    self.ResRoleVip2InfoChangeFunc = function(msgId, msgData)
        self:RefreshVip()
    end
    UIShopPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRoleVip2InfoChangeMessage, self.ResRoleVip2InfoChangeFunc)
    --region UIEvents
    CS.UIEventListener.Get(UIShopPanel.GetTglCommon_GameObject()).onClick = UIShopPanel.OnToggleClickCommon;
    CS.UIEventListener.Get(UIShopPanel.GetTglLiquan_GameObject()).onClick = UIShopPanel.OnToggleClickLiquan;
    CS.UIEventListener.Get(UIShopPanel.GetTglWeeklyPurchase_GameObject()).onClick = UIShopPanel.OnToggleClickWeeklyPurchase;
    CS.UIEventListener.Get(UIShopPanel.GetTglGold_GameObject()).onClick = UIShopPanel.OnTglClickGold;
    CS.UIEventListener.Get(UIShopPanel.GetTglCommerceShop_GameObject()).onClick = UIShopPanel.OnTglClickCommerceShop;
    CS.UIEventListener.Get(UIShopPanel.GetBtnRecharge_GameObject()).onClick = UIShopPanel.OnBtnClickRecharge;
    CS.UIEventListener.Get(UIShopPanel.GetBtnClose_GameObject()).onClick = UIShopPanel.OnBtnClickClose;
    --CS.UIEventListener.Get(UIShopPanel.GetBackGround_GameObject()).onClick = UIShopPanel.OnBtnClickClose;
    UIShopPanel:GetClientEventHandler():AddEvent(CS.CEvent.UI_ShopSelectChanged, UIShopPanel.OnShopSelectChanged);
    --endregion
end

function UIShopPanel.RemoveEvents()
    UIShopPanel:GetClientEventHandler():RemoveEvent(CS.CEvent.UI_ShopSelectChanged, UIShopPanel.OnShopSelectChanged);
end

--region CallFunction
function UIShopPanel.OnToggleClickCommon()
    UIShopPanel.SetShopShowWithShopType(LuaEnumStoreType.Diamond);
end

function UIShopPanel.OnToggleClickLiquan()
    UIShopPanel.SetShopShowWithShopType(LuaEnumStoreType.YuanBao);
end

function UIShopPanel.OnToggleClickWeeklyPurchase()
    UIShopPanel.SetShopShowWithShopType(LuaEnumStoreType.WeeklyPurchaseShop);
end

function UIShopPanel.OnTglClickGold()
    UIShopPanel.SetShopShowWithShopType(LuaEnumStoreType.GoldShop);
end

function UIShopPanel.OnTglClickCommerceShop()
    UIShopPanel.SetShopShowWithShopType(LuaEnumStoreType.CommerceDiamond);
end

function UIShopPanel.OnBtnClickClose()
    uimanager:ClosePanel("UIShopPanel")
    if uiStaticParameter.mUnionInfoToShop then
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Guild_Info)
    end
end

function UIShopPanel.OnShopSelectChanged(id, shopVo)
    if (shopVo ~= nil) then
        local curTime = os.time();
        local isTimer = shopVo.storeClassId == LuaEnumStoreType.WeeklyPurchaseShop;
        if (isTimer) then
            local remainTimeStamp = shopVo.nextRefreshTime - curTime;
            remainTimeStamp = remainTimeStamp < 0 and 0 or remainTimeStamp;
            UIShopPanel.GetNextRefreshTime_Text().gameObject:SetActive(true);
            UIShopPanel.GetNextRefreshTime_Text().text = "下次刷新 : " .. UIShopPanel.GetTimeStr(remainTimeStamp);
            if (UIShopPanel.timerCoroutine ~= nil) then
                StopCoroutine(UIShopPanel.timerCoroutine);
                UIShopPanel.timerCoroutine = nil;
            end
            UIShopPanel.timerCoroutine = StartCoroutine(UIShopPanel.IEnumTimer, remainTimeStamp);
        else
            UIShopPanel.GetNextRefreshTime_Text().gameObject:SetActive(false);
            if (UIShopPanel.timerCoroutine ~= nil) then
                StopCoroutine(UIShopPanel.timerCoroutine);
                UIShopPanel.timerCoroutine = nil;
            end
        end
    end
end

function UIShopPanel.OnBtnClickRecharge()
    Utility.TryShowFirstRechargePanel()
end
--endregion

--region Coroutine
---@param timeStamp (s)
function UIShopPanel.IEnumTimer(timeStamp)
    while (timeStamp > 0) do
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1));
        timeStamp = timeStamp - 1;
        UIShopPanel.GetNextRefreshTime_Text().text = "下次刷新 : " .. UIShopPanel.GetTimeStr(timeStamp);
    end
    UIShopPanel.SetShopShowWithShopType(UIShopPanel.selectId);
end
--endregion

function UIShopPanel.GetTimeStr(timeStamp)
    local days = Utility.GetIntPart(timeStamp / 60 / 60 / 24);
    local hours = Utility.GetIntPart(timeStamp / 60 / 60 % 24);
    local minutes = Utility.GetIntPart(timeStamp / 60 % 60);
    local second = Utility.GetIntPart(timeStamp % 60);
    if (timeStamp / 60 / 60 % 24 > hours) then
        hours = hours + 1;
    end
    if (hours <= 1) then
        return minutes .. "分钟" .. second .. "秒";
    else
        return days .. "天" .. hours .. "小时";
    end
end

function UIShopPanel.SetShopShowWithShopType(shopType)
    if (UIShopPanel.selectId == shopType) then
        return ;
    end
    UIShopPanel.GetShopViewTemplate():ClearStore();
    UIShopPanel.selectId = shopType;
    UIShopPanel.GetShopViewTemplate():OpenStoreById(UIShopPanel.selectId, UIShopPanel.mChooseStore);
    if (UIShopPanel.mToggleDic ~= nil) then
        UIShopPanel.mToggleDic[UIShopPanel.selectId].isChecked = true;
        for k, v in pairs(UIShopPanel.mToggleDic) do
            if (v ~= nil and not CS.StaticUtility.IsNull(v)) then
                local backGround = v.gameObject.transform:Find("Background");
                if (backGround ~= nil) then
                    backGround.gameObject:SetActive(k ~= UIShopPanel.selectId);
                end
            end
        end
    end
end

function UIShopPanel.RefreshBtnPosition()
    local shopList = CS.Cfg_StoreClassTableManager.Instance:GetStoreWithPanelType(LuaEnumShopPanelType.Market);
    if (shopList.Count > 0) then
        for i = 0, shopList.Count - 1 do
            local v = shopList[i]
            if (v.sellId == LuaEnumStoreType.Diamond) then
                UIShopPanel.GetTglCommon_GameObject().transform:SetSiblingIndex(i);
            elseif (v.sellId == LuaEnumStoreType.YuanBao) then
                UIShopPanel.GetTglLiquan_GameObject().transform:SetSiblingIndex(i);
            elseif (v.sellId == LuaEnumStoreType.WeeklyPurchaseShop) then
                UIShopPanel.GetTglWeeklyPurchase_GameObject().transform:SetSiblingIndex(i);
            elseif (v.sellId == LuaEnumStoreType.GoldShop) then
                UIShopPanel.GetTglGold_GameObject().transform:SetSiblingIndex(i);
            end
        end
    end

    --UIShopPanel.GetTglGrid_UIGrid():Reposition();
end

--endregion

function UIShopPanel:Show(customData)
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.Shop

    if (customData == nil) then
        customData = {};
    end

    if (customData == 16) then
        customData = {};
        customData.type = 16
    end

    if (customData.type == nil) then
        customData.type = LuaEnumStoreType.YuanBao;
    end
    --customData.chooseStore = {};
    --table.insert(customData.chooseStore, 7006001);
    if (customData.chooseStore ~= nil) then
        UIShopPanel.mChooseStore = customData.chooseStore;
    end
    if customData.IsTaskOpen == nil then
        UIShopPanel.IsTaskOpen = false
    else
        UIShopPanel.IsTaskOpen = customData.IsTaskOpen
    end

    UIShopPanel.SetShopShowWithShopType(customData.type);
end

function UIShopPanel:Init()
    UIShopPanel.Initialize();
    self:InitEvents();
    UIShopPanel.RefreshBtnPosition();
    self:RefreshVip()
end

function update()
    UIShopPanel.GetShopViewTemplate():OnUpdate()
end

--region 刷新VIP
function UIShopPanel:RefreshVip()
    local vip2info = gameMgr:GetPlayerDataMgr():GetPlayerVip2Info()
    local vip2data = vip2info:GetPlayerVip2Data()
    self:GetVipLevel_UILabel().text = vip2info:GetPlayerVip2Level()
    local tableinfo = clientTableManager.cfg_vip_levelManager:TryGetValue(vip2data.level)
    if (tableinfo ~= nil) then
        self:GetVipProgress_UISlider().value = vip2data.exp / tableinfo:GetNeedExp()
        self:GetVipExp_UILabel().text = tostring(vip2data.exp) .. "/" .. tableinfo:GetNeedExp()
    end
end
--endregion

function ondestroy()
    uiStaticParameter.mUnionInfoToShop = false
    UIShopPanel.RemoveEvents();
    if (UIShopPanel.timerCoroutine ~= nil) then
        StopCoroutine(UIShopPanel.timerCoroutine);
        UIShopPanel.timerCoroutine = nil;
    end
    uimanager:ClosePanel("UIVipInfoPanel")
end

return UIShopPanel