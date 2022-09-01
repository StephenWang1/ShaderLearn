---@class UIActivityManEnterPanel:UIBase
local UIActivityManEnterPanel = {};

UIActivityManEnterPanel.mActivityId = nil;

UIActivityManEnterPanel.mActivityTimeTable = nil;

UIActivityManEnterPanel.mUIItemDic = nil;

---@type CalendarItem
UIActivityManEnterPanel.mCalendarItem = nil;

--region Components

function UIActivityManEnterPanel:GetBtnLast_GameObject()
    if (self.mBtnLast_GameObject == nil) then
        self.mBtnLast_GameObject = self:GetCurComp("WidgetRoot/events/btnLast", "GameObject");
    end
    return self.mBtnLast_GameObject;
end

function UIActivityManEnterPanel:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/events/btnClose", "GameObject");
    end
    return self.mBtnClose_GameObject;
end

function UIActivityManEnterPanel:GetBtnEnter_GameObject()
    if (self.mBtnEnter_GameObject == nil) then
        self.mBtnEnter_GameObject = self:GetCurComp("WidgetRoot/events/btnEnter", "GameObject");
    end
    return self.mBtnEnter_GameObject;
end

function UIActivityManEnterPanel:GetBtnHelp_GameObject()
    if (self.mBtnHelp_GameObject == nil) then
        self.mBtnHelp_GameObject = self:GetCurComp("WidgetRoot/events/btn_help", "GameObject");
    end
    return self.mBtnHelp_GameObject;
end

function UIActivityManEnterPanel:GetEnterCondition_GameObject()
    if (self.mEnterCondition_GameObject == nil) then
        self.mEnterCondition_GameObject = self:GetCurComp("WidgetRoot/view/introduce/enterConditon", "GameObject");
    end
    return self.mEnterCondition_GameObject;
end

function UIActivityManEnterPanel:GetName_Text()
    if (self.mName_Text == nil) then
        self.mName_Text = self:GetCurComp("WidgetRoot/window/title", "UILabel");
    end
    return self.mName_Text;
end

function UIActivityManEnterPanel:GetRewardName_Text()
    if (self.mRewardName_Text == nil) then
        self.mRewardName_Text = self:GetCurComp("WidgetRoot/view/introduce/labelGroup/title", "UILabel");
    end
    return self.mRewardName_Text;
end

function UIActivityManEnterPanel:GetLevelLimit_Text()
    if (self.mLevelLimit_Text == nil) then
        self.mLevelLimit_Text = self:GetCurComp("WidgetRoot/view/introduce/enterConditon/levleTitle", "UILabel");
    end
    return self.mLevelLimit_Text;
end

function UIActivityManEnterPanel:GetAwardGridContainer()
    if (self.mAwardGridContainer == nil) then
        self.mAwardGridContainer = self:GetCurComp("WidgetRoot/view/Scroll View/Awards", "UIGridContainer");
    end
    return self.mAwardGridContainer;
end

function UIActivityManEnterPanel:GetDes_Label()
    if (self.mDesLabel == nil) then
        self.mDesLabel = self:GetCurComp("WidgetRoot/window/des", "Top_UILabel")
    end
    return self.mDesLabel;
end

function UIActivityManEnterPanel:GetGrid_GridContainer()
    if (self.mGrid == nil) then
        self.mGrid = self:GetCurComp("WidgetRoot/window/Grid", "Top_UIGridContainer")
    end
    return self.mGrid;
end

function UIActivityManEnterPanel:GetActivityId()
    return 0;
end

function UIActivityManEnterPanel:GetHelpId()
    return 0;
end

--endregion

--region Method

--region CallFunction

function UIActivityManEnterPanel:OnCloseSelf()

end

function UIActivityManEnterPanel:OnClickBtnClose()
    uimanager:ClosePanel("UIActivitiesManPanel");
    self:OnCloseSelf();
end

function UIActivityManEnterPanel:OnClickBtnEnter()
    local stateCode = self:GetEnterActivityStateCode()
    if (stateCode == 1) then
        return Utility.ShowPopoTips(self:GetBtnEnter_GameObject(), nil, 266, "UIActivityManEnterPanel");
    elseif (stateCode == 2) then
        return Utility.ShowPopoTips(self:GetBtnEnter_GameObject(), nil, 265, "UIActivityManEnterPanel");
    else
        self:OnClickBtnClose();
        if (self.mActivityTimeTable ~= nil) then
            if (self.mActivityTimeTable.deliverId ~= nil and self.mActivityTimeTable.deliverId ~= 0) then
                ---@type TABLE.CFG_DELIVER
                --[[                local isDeliverTblExist, deliverTbl
                                isDeliverTblExist, deliverTbl = CS.Cfg_DeliverTableManager.Instance:TryGetValue(self.mActivityTimeTable.deliverId)
                                if isDeliverTblExist then
                                    if CS.CSPathFinderManager.Instance:SetFixedDestination(deliverTbl.toMapId,
                                            CS.SFMiscBase.Dot2(deliverTbl.x, deliverTbl.y),
                                            CS.EAutoPathFindSourceSystemType.Calendar, CS.EAutoPathFindType.Calendar_FindNPC,
                                            deliverTbl.range, deliverTbl.id) == false then

                                    end
                                end]]
                networkRequest.ReqDeliverByConfig(self.mActivityTimeTable.deliverId)
            end
        end
    end
end

function UIActivityManEnterPanel:OnClickBtnLast()

end

--endregion

--region Public

function UIActivityManEnterPanel:UpdateUI()
    if (self.mActivityTimeTable ~= nil) then
        self:UpdateLevelLimit();
        self:UpdateAwards();
        self:UpdateRewardName();
    end
end

function UIActivityManEnterPanel:UpdateRewardName()

end

function UIActivityManEnterPanel:UpdateLevelLimit()
    self:GetEnterCondition_GameObject():SetActive(false);
    if (self.mActivityTimeTable ~= nil) then
        local isFind, conditionTable = CS.Cfg_ConditionManager.Instance:TryGetValue(self.mActivityTimeTable.condition);
        if (isFind) then
            if (conditionTable.conditionType == 1) then
                if (conditionTable.conditionParam ~= nil and conditionTable.conditionParam.list.Count > 0) then
                    self:GetLevelLimit_Text().text = "人物等级" .. conditionTable.conditionParam.list[0] .. "级";
                    self:GetEnterCondition_GameObject():SetActive(true);
                end
            end
        end
    end
end

function UIActivityManEnterPanel:UpdateAwards()
    if (self.mUIItemDic == nil) then
        self.mUIItemDic = {};
    end

    local gridContainer = self:GetAwardGridContainer();
    if (self.mActivityTimeTable ~= nil) then
        self:GetName_Text().text = self.mActivityTimeTable.name;
        local itemIds, nums = CS.Cfg_DailyActivityTimeTableManager.Instance:GetActivityAwardShow(self.mActivityTimeTable);
        if (itemIds ~= nil) then
            gridContainer.MaxCount = itemIds.Count;
            for i = 0, itemIds.Count - 1 do
                local gobj = gridContainer.controlList[i];
                if (self.mUIItemDic[gobj] == nil) then
                    self.mUIItemDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
                end
                local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemIds[i]);
                if (isFind) then
                    self.mUIItemDic[gobj]:RefreshUIWithItemInfo(itemTable, nums[i]);

                    CS.UIEventListener.Get(gobj).onClick = function()
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable, showRight = false })
                    end
                end
            end
        end
    else
        gridContainer.MaxCount = 0;
    end
end

--endregion

--region Private

function UIActivityManEnterPanel:GetEnterActivityStateCode()
    if (self.mActivityTimeTable ~= nil) then
        if (self.mActivityTimeTable.deliverId ~= nil and self.mActivityTimeTable.deliverId ~= 0) then


            local deliverIds = self.mActivityTimeTable.deliverId;
            if (deliverIds ~= nil and deliverIds > 0) then
                local deliverId = deliverIds;
                local isFind0, deliverTable = CS.Cfg_DeliverTableManager.Instance:TryGetValue(deliverId);
                if (isFind0) then
                    local isMatch = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(self.mActivityTimeTable.condition)

                    local tbl = clientTableManager.cfg_daily_activity_timeManager:TryGetValue(self:GetActivityId())

                    local isOpen = gameMgr:GetPlayerDataMgr():GetActivityMgr():IsOpenActivity(tbl:GetActivityType())
                    if (not isMatch) then
                        local isFind1, conditionTable = CS.Cfg_ConditionManager.Instance:TryGetValue(self.mActivityTimeTable.condition);
                        if (isFind1) then
                            if (conditionTable.conditionType == 1) then
                                return 1;
                            end
                        end
                    elseif (not isOpen) then
                        return 2;
                    end

                    return 0;
                end
            end
        end
    end
end

function UIActivityManEnterPanel:InitEvents()
    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        self:OnClickBtnClose();
    end;

    CS.UIEventListener.Get(self:GetBtnHelp_GameObject()).onClick = function()
        local isFind, desTable = CS.Cfg_DescriptionTableManager.Instance:TryGetValue(self:GetHelpId())
        if isFind then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, desTable);
        end
    end

    CS.UIEventListener.Get(self:GetBtnEnter_GameObject()).onClick = function()
        self:OnClickBtnEnter();
    end

    CS.UIEventListener.Get(self:GetBtnLast_GameObject()).onClick = function()
        self:OnClickBtnLast()
    end
end

function UIActivityManEnterPanel:RemoveEvents()

end

--endregion

--endregion

function UIActivityManEnterPanel:Init()
    self:InitEvents();
end

function UIActivityManEnterPanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end

    self.mCalendarItem = customData.activityItem;
    local isFind, activityTimeTable = CS.Cfg_DailyActivityTimeTableManager.Instance:TryGetValue(self:GetActivityId());
    if (isFind) then
        self.mActivityTimeTable = activityTimeTable;
        self:UpdateUI();
    end
end

function UIActivityManEnterPanel:OnDestroy()
    self:RemoveEvents();
end

function ondestroy()
    UIActivityManEnterPanel:RemoveEvents();
end

return UIActivityManEnterPanel;