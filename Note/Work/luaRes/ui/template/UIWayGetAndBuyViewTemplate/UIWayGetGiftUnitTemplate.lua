local UIWayGetGiftUnitTemplate = {};

UIWayGetGiftUnitTemplate.mUIItemDic = nil;

UIWayGetGiftUnitTemplate.mRechargeTable = nil;

--region Components

function UIWayGetGiftUnitTemplate:GetUIItemGridContainer()
    if (self.mUIItemGridContainer == nil) then
        self.mUIItemGridContainer = self:Get("grid", "UIGridContainer");
    end
    return self.mUIItemGridContainer;
end

function UIWayGetGiftUnitTemplate:GetBtnBuy_GameObject()
    if (self.mBtnBuy_GameObject == nil) then
        self.mBtnBuy_GameObject = self:Get("btn_buy", "GameObject");
    end
    return self.mBtnBuy_GameObject;
end

function UIWayGetGiftUnitTemplate:GetRechargeValue_Text()
    if (self.mRechargeValue_Text == nil) then
        self.mRechargeValue_Text = self:Get("btn_buy/Label", "UILabel");
    end
    return self.mRechargeValue_Text;
end

--endregion

--region Method

function UIWayGetGiftUnitTemplate:UpdateUnit(wayGetId)
    local isFind, wayGetTable = CS.Cfg_Way_GetTableManager.Instance:TryGetValue(wayGetId);
    if (isFind) then
        self.mWayGetTable = wayGetTable;
        self:UpdateGift();
    end
end

function UIWayGetGiftUnitTemplate:UpdateGift()
    if (self.mUIItemDic == nil) then
        self.mUIItemDic = {};
    end

    if (self.mWayGetTable ~= nil) then
        local isHas, rechargeId = CS.Cfg_Way_GetTableManager.Instance:HasGiftReplaceToQuickBuy(self.mWayGetTable);
        if (isHas) then
            local isFind, rechargeTable = CS.Cfg_RechargeTableManager.Instance:TryGetValue(rechargeId);
            if (isFind) then
                self.mRechargeTable = rechargeTable;
                self:GetRechargeValue_Text().text = "¥" .. math.floor(self.mRechargeTable.rmb / 100);
            end
            local list = CS.Cfg_BoxTableManager.Instance:GetSemicolonReward(rechargeTable.reward);
            local gridContainer = self:GetUIItemGridContainer();
            if (list ~= nil) then
                gridContainer.MaxCount = list.Count;
                for i = 0, list.Count - 1 do
                    local gobj = gridContainer.controlList[i];
                    if (self.mUIItemDic[gobj] == nil) then
                        self.mUIItemDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
                    end
                    local itemId = list[i].itemId;
                    local itemNum = list[i].count;
                    local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
                    if (isFind) then
                        self.mUIItemDic[gobj]:RefreshUIWithItemInfo(itemTable, itemNum);
                    end
                end
            else
                gridContainer.MaxCount = 0;
            end
        end
    end
end

--endregion

function UIWayGetGiftUnitTemplate:Init(EntranceType)
    CS.UIEventListener.Get(self:GetBtnBuy_GameObject()).onClick = function()
        --调用充值SDK
        if (EntranceType ~= nil) then
            uiStaticParameter.RechargePoint = EntranceType
        end
        if (CS.CSVersionMgr.Instance.ServerVersion.OpenRecharge) then
            if CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor or CS.CSGameState.RunPlatform == CS.ERunPlatform.AndroidEditor then
                networkRequest.ReqGM("@43 " .. tostring(self.mRechargeTable.id))
            else
                local data = Utility:GetPayData(self.mRechargeTable)
                if (data ~= nil) then
                    CS.SDKManager.GameInterface:Pay(data:GetPayParams())
                end
            end
        end
        --PaySDK

        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:ClosePanel("UIDisposeItemPanel")
        uimanager:ClosePanel("UIFurnaceWayAndBuyPanel")
        --uimanager:CreatePanel("UIRechargePanel");
    end
end

function UIWayGetGiftUnitTemplate:OnDestroy()

end

return UIWayGetGiftUnitTemplate;