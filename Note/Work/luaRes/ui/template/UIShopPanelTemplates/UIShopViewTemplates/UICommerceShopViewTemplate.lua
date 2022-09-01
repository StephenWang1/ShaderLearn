---@class UICommerceShopViewTemplate
local UICommerceShopViewTemplate = {}

setmetatable(UICommerceShopViewTemplate, luaComponentTemplates.UIShopViewTemplate)

--region Component

function UICommerceShopViewTemplate:GetScrollViewTable_UITable()
    if (self.mScrollViewTable_UITable == nil) then
        self.mScrollViewTable_UITable = self:Get("Scroll View", "UITable");
    end
    return self.mScrollViewTable_UITable;
end

function UICommerceShopViewTemplate:GetScrollView()
    if (self.mScrollView == nil) then
        self.mScrollView = self:Get("Scroll View", "UIScrollView");
    end
    return self.mScrollView;
end

function UICommerceShopViewTemplate:GetRefreshTime_GameObject()
    if (self.mRefreshTime_GameObject == nil) then
        self.mRefreshTime_GameObject = self:Get("Scroll View/refreshTime", "GameObject");
    end
    return self.mRefreshTime_GameObject;
end

function UICommerceShopViewTemplate:GetBtnRefresh_GameObject()
    if (self.mBtnRefresh_GameObject == nil) then
        self.mBtnRefresh_GameObject = self:Get("Scroll View/refreshTime/btnNowRefresh", "GameObject");
    end
    return self.mBtnRefresh_GameObject;
end

function UICommerceShopViewTemplate:GetTimerRefreshTime()
    if (self.mTimerRefreshTime == nil) then
        self.mTimerRefreshTime = self:Get("Scroll View/refreshTime/nextRefreshTime", "UITimer");
    end
    return self.mTimerRefreshTime;
end

--endregion

--region Method

--region Public

function UICommerceShopViewTemplate:SetShopShow(shopType)
    if (self.mSelectShopType == shopType) then
        return ;
    end
    self:ResetScrollView();
    CS.CSScene.MainPlayerInfo.StoreInfoV2:TryGetStore(shopType, function()
        self.mSelectShopType = shopType;
        self:UpdateShop();
    end)
end

function UICommerceShopViewTemplate:UpdateShop()
    if (self.mSelectShopType ~= nil) then
        local isFindShop, shopVo = CS.CSScene.MainPlayerInfo.StoreInfoV2.StoreDataDic:TryGetValue(self.mSelectShopType);
        if (isFindShop) then
            local listData = SplitToList(shopVo.storeUnitDic, 999);
            self:GetPageViewTemplate():Initialize(999, shopVo.storeUnitDic.Count, listData, luaComponentTemplates.UICommerceShopPageUnitTemplate);
            if (self.mIsResetPageScrollView) then
                self.mIsResetPageScrollView = false;
                self:GetPageViewTemplate():GetScrollView():ResetPosition();
            end

            self:UpdateNextRefreshTime();
            if (shopVo.storeUnitDic.Count > 4) then
                self:GetRefreshTime_GameObject().transform:SetAsLastSibling();
                self:GetScrollViewTable_UITable():Reposition();
            else
                self:GetScrollView():ResetPosition();
                self:GetRefreshTime_GameObject().transform.localPosition = self.mRefreshTimeOriginPosition;
            end
        end
    end
end

--endregion

--region Private

function UICommerceShopViewTemplate:UpdateNextRefreshTime()
    self:GetRefreshTime_GameObject():SetActive(false);
    if (self.mSelectShopType ~= nil) then
        local isFindShop, shopVo = CS.CSScene.MainPlayerInfo.StoreInfoV2.StoreDataDic:TryGetValue(self.mSelectShopType);
        if (isFindShop) then
            if (self.mSelectShopType == LuaEnumStoreType.CommerceIntegral) then
                self:GetRefreshTime_GameObject():SetActive(true);
                local GetTargetTime = function()
                    return shopVo.nextRefreshTime * 1000 - CS.CSServerTime.Instance.TotalMillisecond;
                end
                local targetTime = GetTargetTime();
                if (targetTime > 0) then
                    self:GetRefreshTime_GameObject():SetActive(true);
                    self:GetTimerRefreshTime():StartTimer(targetTime, nil, function()
                        return GetTargetTime()
                    end);
                else
                    self:GetRefreshTime_GameObject():SetActive(false);
                end
            end
        end
    end
end

function UICommerceShopViewTemplate:InitEvents()
    self:RunBaseFunction("InitEvents");

    CS.UIEventListener.Get(self:GetBtnRefresh_GameObject()).onClick = function()
        if (self.mSelectShopType ~= nil) then
            local isFindShop, shopVo = CS.CSScene.MainPlayerInfo.StoreInfoV2.StoreDataDic:TryGetValue(self.mSelectShopType);
            if (isFindShop) then
                local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(shopVo.refreshCostId);
                if (isFind) then
                    local mCount = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(shopVo.refreshCostId);
                    --if(not isFind) then
                    --mCount = 0;
                    --end
                    if (mCount >= shopVo.refreshCostNum) then
                        local temp = {}
                        temp.Content = "立即刷新商店?"
                        temp.IsShowGoldLabel = true
                        temp.CenterDescription = "刷新"
                        temp.GoldIcon = itemTable.icon
                        temp.GoldCount = shopVo.refreshCostNum
                        temp.CallBack = function()
                            networkRequest.ReqMaualFresh(1, self.mSelectShopType);
                        end
                        uimanager:CreatePanel("UIPromptPanel", function(panel)
                            if panel then
                                local bg = panel:GetCurComp("events/CenterBtn/Background", "UISprite")
                                if bg then
                                    bg.spriteName = 'anniu10'
                                end
                            end
                        end, temp)
                    else
                        Utility.ShowPopoTips(self:GetBtnRefresh_GameObject().transform, nil, 254, "UICommerceShopPanel");
                    end
                end
            end
        end
    end

    self.CallSelfResOpenStoreByIdMessage = function(msgId, msgData)
        if (self.mSelectShopType == msgData.storeClassId) then
            self:UpdateShop();
        end
    end

    --region NetEvents
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOpenStoreByIdMessage, self.CallSelfResOpenStoreByIdMessage);
    --endregion
end

--function UICommerceShopViewTemplate:RemoveEvents()
--    self:RunBaseFunction("RemoveEvents");
--    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResOpenStoreByIdMessage, self.CallSelfResOpenStoreByIdMessage);
--end

--endregion

--endregion

function UICommerceShopViewTemplate:Init(panel)
    self:RunBaseFunction("Init", panel);
    self.mRefreshTimeOriginPosition = self:GetRefreshTime_GameObject().transform.localPosition;
end

return UICommerceShopViewTemplate;