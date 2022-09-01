---@class UICombineServerShabakePanel
local UICombineServerShabakePanel = {};

---@type table <UnityEngine.GameObject, UICombineServerShabakeUnitTemplate>
UICombineServerShabakePanel.mUnitDic = nil;

---@type SpecialActivityPanelData
UICombineServerShabakePanel.mActivityData = nil;

function UICombineServerShabakePanel:GetTimeCount_UICountdownLabel()
    if (self.mTimeCount_UICountdownLabel == nil) then
        self.mTimeCount_UICountdownLabel = self:GetCurComp("WidgetRoot/view/TimeCount", "UICountdownLabel");
    end
    return self.mTimeCount_UICountdownLabel;
end

function UICombineServerShabakePanel:GetActivityGridContainer()
    if (self.mActivityGridContainer == nil) then
        self.mActivityGridContainer = self:GetCurComp("WidgetRoot/view/Scroll View/firstRankGrid", "UIGridContainer");
    end
    return self.mActivityGridContainer;
end

---@return UnityEngine.GameObject 跳转历法按钮
function UICombineServerShabakePanel:GetTransferCalendarBtn_GO()
    if self.mTransCalendarBtn == nil then
        self.mTransCalendarBtn = self:GetCurComp("WidgetRoot/events/btn_go", "GameObject")
    end
    return self.mTransCalendarBtn
end

---@private 获得活动详细数据
function UICombineServerShabakePanel:GetSingleActivityData()
    if (self.mActivityData ~= nil) then
        return gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetSingleActivityData(self.mActivityData.mEventID);
    end
    return nil;
end

---@public 更新UI
function UICombineServerShabakePanel:UpdateUI()
    if (self.mUnitDic == nil) then
        self.mUnitDic = {};
    end
    ---@type activitiesV2.ResOneActivitiesInfo
    local activityData = self:GetSingleActivityData();
    local gridContainer = self:GetActivityGridContainer();
    if (activityData ~= nil and activityData.oneActivitiesInfo ~= nil) then
        gridContainer.MaxCount = #activityData.oneActivitiesInfo;
        local index = 0;
        for k, v in pairs(activityData.oneActivitiesInfo) do
            local gobj = gridContainer.controlList[index];
            if (self.mUnitDic[gobj] == nil) then
                self.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UICombineServerShabakeUnitTemplate);
            end
            self.mUnitDic[gobj]:UpdateUnit(v, index);
            index = index + 1;
        end
    else
        gridContainer.MaxCount = 0;
    end

    local endTime = activityData.leftTime;
    if (endTime > 0) then
        self:GetTimeCount_UICountdownLabel():StartCountDown(nil, 8, endTime * 1000, "活动倒计时", nil, nil, function()
            self:GetTimeCount_UILabel().text = "已结束"
        end)
    else
        self:GetTimeCount_UILabel().text = "已结束"
    end
end

--region 初始化
function UICombineServerShabakePanel:Init()
    self:BindEvents()
end

---@private 显示(生命周期)
---@param customData SpecialActivityPanelData 界面显示参数
function UICombineServerShabakePanel:Show(customData)
    if (customData == nil) then
        return ;
    end

    self.mActivityData = customData;
    self:UpdateUI();
end

function UICombineServerShabakePanel:BindEvents()
    CS.UIEventListener.Get(self:GetTransferCalendarBtn_GO()).onClick = function()
        ---@param panel UICalendarPanel
        uimanager:CreatePanel("UICalendarPanel", function(panel)
            panel:JumpTargetNextActivityType(LuaEnumDailyActivityType.ShaBaKe)
            uimanager:ClosePanel("UIActivityCurrentPanel")
        end)
    end
end
--endregion

function ondestroy()

end

return UICombineServerShabakePanel;
