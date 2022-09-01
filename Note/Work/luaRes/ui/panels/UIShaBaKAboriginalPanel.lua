local UIShaBaKAboriginalPanel = {};

local this = nil;

UIShaBaKAboriginalPanel.mCostItemId = 0;

UIShaBaKAboriginalPanel.mCostItemNum = 0;

--region Components

function UIShaBaKAboriginalPanel:GetBtnClose_GameObject()
    if (this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/event/btn_close", "GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UIShaBaKAboriginalPanel:GetBtnEnter_GameObject()
    if (this.mBtnEnter_GameObject == nil) then
        this.mBtnEnter_GameObject = this:GetCurComp("WidgetRoot/event/btnEnter", "GameObject")
    end
    return this.mBtnEnter_GameObject;
end

function UIShaBaKAboriginalPanel:GetBtnHelp_GameObject()
    if (this.mBtnHelp_GameObject == nil) then
        this.mBtnHelp_GameObject = this:GetCurComp("WidgetRoot/event/btn_help", "GameObject")
    end
    return this.mBtnHelp_GameObject;
end

function UIShaBaKAboriginalPanel:GetCostItemIcon_UISprite()
    if (this.mCostItemIcon_UISprite == nil) then
        this.mCostItemIcon_UISprite = this:GetCurComp("WidgetRoot/view/costItem/Sprite", "UISprite");
    end
    return this.mCostItemIcon_UISprite;
end

function UIShaBaKAboriginalPanel:GetCostItemValue_Text()
    if (this.mCostItemValue_Text == nil) then
        this.mCostItemValue_Text = this:GetCurComp("WidgetRoot/view/costItem", "UILabel");
    end
    return this.mCostItemValue_Text;
end

function UIShaBaKAboriginalPanel:GetDes_Text()
    if (this.mDes_Text == nil) then
        this.mDes_Text = this:GetCurComp("WidgetRoot/view/lb_describe", "UILabel");
    end
    return this.mDes_Text;
end

function UIShaBaKAboriginalPanel:GetDeliverId()
    return 1026;
end

function UIShaBaKAboriginalPanel:GetDuplicateInfo()
    if this.mDuplicateInfo == nil then
        this.mDuplicateInfo = CS.CSScene.MainPlayerInfo.DuplicateV2
    end
    return this.mDuplicateInfo
end

function UIShaBaKAboriginalPanel:GetUnionInfo()
    if this.mUnionInfo == nil then
        this.mUnionInfo = CS.CSScene.MainPlayerInfo.UnionInfoV2
    end
    return this.mUnionInfo
end

function UIShaBaKAboriginalPanel:GetLeagueInfo()
    if self.mLeagueInfo == nil then
        self.mLeagueInfo = CS.CSScene.MainPlayerInfo.LeagueInfo
    end
    return self.mLeagueInfo
end

--endregion

--region Method

function UIShaBaKAboriginalPanel:OnClickBtnEnter()
    if (this.mCostItemId ~= nil) then
        local mNum = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(this.mCostItemId);
        if (this.mCostItemNum > mNum) then
            local TipsInfo = {}
            TipsInfo[LuaEnumTipConfigType.Describe] = CS.Cfg_ItemsTableManager.Instance:GetItemName(this.mCostItemId) .. "不足"
            TipsInfo[LuaEnumTipConfigType.Parent] = this:GetBtnEnter_GameObject().transform;
            TipsInfo[LuaEnumTipConfigType.ConfigID] = 23
            return uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
        end
    end

    local isOpenActive = this:GetDuplicateInfo():IsOpenShaBaK()
    if isOpenActive then
        local isStatueDestroy = this:GetDuplicateInfo().IsStatuDestroy
        if isStatueDestroy then
            local OccupyUnionId = this:GetDuplicateInfo().OccupyShabakUnionId
            local OccupyLeagueType = self:GetDuplicateInfo().OccupyShabakLeagueType
            if OccupyLeagueType ~= 0 then
                local playerLeagueType = self:GetLeagueInfo().LeagueType
                if playerLeagueType == OccupyLeagueType then
                    CS.Utility.ShowTips("守方成员不可传送")
                else
                    networkRequest.ReqDeliverByConfig(1026)
                    uimanager:ClosePanel("UIShaBaKAboriginalPanel");
                end
            elseif OccupyUnionId and OccupyUnionId ~= 0 then
                local playerUnionId = this:GetUnionInfo().UnionID
                if playerUnionId == OccupyUnionId then
                    CS.Utility.ShowTips("守方成员不可传送")
                else
                    networkRequest.ReqDeliverByConfig(1026)
                    uimanager:ClosePanel("UIShaBaKAboriginalPanel");
                end
            else
                CS.Utility.ShowTips("占领皇宫后非守方才可使用")
            end
        else
            CS.Utility.ShowTips("请先摧毁雕像")
        end
    else
        CS.Utility.ShowTips("不在活动时间内")
    end
end

--region Public

function UIShaBaKAboriginalPanel:UpdateUI()
    this:GetCostItemValue_Text().text = "";
    this:GetDes_Text().text = CS.Cfg_DescriptionTableManager.Instance:GetShaBakDes();

    local isFind, deliverTable = CS.Cfg_DeliverTableManager.Instance:TryGetValue(this:GetDeliverId());
    if (isFind) then
        this.mTableData = deliverTable
        local isOccupyShaBaK = false;
        if (CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.UnionInfoV2 ~= nil and CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID ~= 0 and CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionInfo ~= nil) then
            isOccupyShaBaK = CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionInfo.unionInfo.seizeCityId == 1002;
        end
        local coinData
        if isOccupyShaBaK and this.mTableData.special == 1 and self.mTableData.speciaItem ~= nil then
            coinData = this.mTableData.speciaItem
        else
            if this.mTableData.item then
                coinData = this.mTableData.item
            end
        end
        local info = string.Split(coinData, '#')
        if info and #info >= 2 then
            this.mCostItemId = tonumber(info[1])
            this.mCostItemNum = tonumber(info[2])
        end
        this:GetCostItemValue_Text().gameObject:SetActive(this.mCostItemNum > 0);
        this:GetCostItemValue_Text().text = this.mCostItemNum;
    end
end

--endregion

--region Private

function UIShaBaKAboriginalPanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIShaBaKAboriginalPanel");
    end;

    CS.UIEventListener.Get(this:GetBtnEnter_GameObject()).onClick = function()
        this:OnClickBtnEnter();
    end;

    CS.UIEventListener.Get(this:GetBtnHelp_GameObject()).onClick = function()
        local isFind, desInfo = CS.Cfg_DescriptionTableManager.Instance:TryGetValue(139)
        if isFind then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, desInfo)
        end
    end;
end

function UIShaBaKAboriginalPanel:RemoveEvents()

end

--endregion

--endregion

function UIShaBaKAboriginalPanel:Init()
    this = self;
    this:InitEvents();
end

function UIShaBaKAboriginalPanel:Show()
    this:UpdateUI();
end

function ondestroy()
    this:RemoveEvents();
    this = nil;
end

return UIShaBaKAboriginalPanel;