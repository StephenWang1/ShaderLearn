---@class UIActivitiesManViewTemplate
local UIActivitiesManViewTemplate = {};

--UIActivitiesManViewTemplate.mCalendarVos = nil;

---@type table<CalendarItem>
UIActivitiesManViewTemplate.mCalendarItems = nil

---@type table<UnityEngine.GameObject, UIActivitiesManUnitTemplate>
UIActivitiesManViewTemplate.mUnitDic = nil;

UIActivitiesManViewTemplate.mLastChooseUnit = nil;

--region Components

function UIActivitiesManViewTemplate:GetUnitGridContainer()
    if(self.mUnitGridContainer == nil) then
        self.mUnitGridContainer = self:Get("UIActivitiesLable/Scroll View/activity","UIGridContainer");
    end
    return self.mUnitGridContainer;
end

function UIActivitiesManViewTemplate:GetScrollViewSpringPanel()
    if(self.mScrollViewSpringPanel == nil) then
        self.mScrollViewSpringPanel = self:Get("UIActivitiesLable/Scroll View", "SpringPanel");
    end
    return self.mScrollViewSpringPanel;
end

--endregion

--region Method

--region Public

---@param targetCalendarItem CalendarItem
function UIActivitiesManViewTemplate:UpdateView(targetCalendarItem)
    --self.mCalendarVos = CS.CSScene.MainPlayerInfo.CalendarInfoV2:GetActivityManCalendarVos();
    --
    --self:UpdateActivities();
    --local isSelectTarget = false;
    --if(targetVo ~= nil) then
    --    for i = 0, self.mCalendarVos.Count - 1 do
    --        local v = self.mCalendarVos[i];
    --        if(v.id == targetVo.id and v.timeStampUtc == targetVo.timeStampUtc) then
    --            isSelectTarget = true;
    --            self:SelectUnit(targetVo, i);
    --        end
    --    end
    --end
    --if(not isSelectTarget) then
    --    self:SelectDefaultUnit();
    --end

    self.mCalendarItems = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetActivityManCalendarData();
    self:UpdateActivities();
    local isSelectTarget = false;
    if(targetCalendarItem ~= nil) then
        for i = 1, #self.mCalendarItems do
            ---@type CalendarItem
            local v = self.mCalendarItems[i];
            if(v.type == targetCalendarItem.type and v.dayTime == targetCalendarItem.dayTime) then
                isSelectTarget = true;
                self:SelectUnit(targetCalendarItem, i - 1);
            end
        end
    end
    if(not isSelectTarget) then
        self:SelectDefaultUnit();
    end
end

function UIActivitiesManViewTemplate:UpdateActivities()
    if(self.mUnitDic == nil) then
        self.mUnitDic = {};
    end

    local gridContainer = self:GetUnitGridContainer();
    --if(self.mCalendarVos ~= nil) then
    --    gridContainer.MaxCount = self.mCalendarVos.Count;
    --    for i = 0, self.mCalendarVos.Count - 1 do
    --        local gobj = gridContainer.controlList[i];
    --        if(self.mUnitDic[gobj] == nil) then
    --            self.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIActivitiesManUnitTemplate);
    --        end
    --        self.mUnitDic[gobj]:UpdateUnit(self.mCalendarVos[i], function(unit)
    --            if(self.mLastChooseUnit ~= unit) then
    --                self:UnSelectLast();
    --                self.mLastChooseUnit = unit;
    --            end
    --        end);
    --    end
    --else
    --    gridContainer.MaxCount = 0;
    --end

    if(self.mCalendarItems ~= nil) then
        gridContainer.MaxCount = #self.mCalendarItems;
        local index = 0;
        for k,v in pairs(self.mCalendarItems) do
            local gobj = gridContainer.controlList[index];
            if(self.mUnitDic[gobj] == nil) then
                self.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIActivitiesManUnitTemplate);
            end
            self.mUnitDic[gobj]:UpdateUnit(v, function(unit)
                if(self.mLastChooseUnit ~= unit) then
                    self:UnSelectLast();
                    self.mLastChooseUnit = unit;
                end
            end);
            index = index + 1;
        end
    end
end

function UIActivitiesManViewTemplate:SelectDefaultUnit()
    --if(self.mCalendarVos ~= nil and self.mCalendarVos.Count > 0) then
    --    for i = 0, self.mCalendarVos.Count - 1 do
    --        local stateCode = CS.CSScene.MainPlayerInfo.CalendarInfoV2:GetActivityState(self.mCalendarVos[i]);
    --        if(stateCode == 0) then
    --            return self:SelectUnit(self.mCalendarVos[i], i);
    --        end
    --    end
    --    return self:SelectUnit(self.mCalendarVos[0], 0);
    --end

    if(self.mCalendarItems ~= nil and #self.mCalendarItems > 0) then
        ---@param v CalendarItem
        for k,v in pairs(self.mCalendarItems) do
            local stateCode, activitySubData = v.ActivityItem:GetRunningState();
            if(stateCode == LuaActivityRunningState.IsRunning) then
                return self:SelectUnit(v, k - 1);
            end
        end
        return self:SelectUnit(self.mCalendarItems[1], 0);
    end
end

---@param calendarItem CalendarItem
function UIActivitiesManViewTemplate:SelectUnit(calendarItem, index)
    --for k,v in pairs(self.mUnitDic) do
    --    if(v.mCalendarVo ~= nil) then
    --        if(v.mCalendarVo.id == calendarVo.id and v.mCalendarVo.timeStampUtc == calendarVo.timeStampUtc) then
    --            index = index > 0 and index or 0;
    --            index = index > self.mCalendarVos.Count - 6 and self.mCalendarVos.Count - 6 or index;
    --            self:GetScrollViewSpringPanel().target = CS.UnityEngine.Vector3(self.mOriginSpringPanelPosition.x, index * self:GetUnitGridContainer().CellHeight, 0);
    --            self:GetScrollViewSpringPanel().enabled = true;
    --            return v:OnSelect();
    --        end
    --    end
    --end
    --return self:SelectDefaultUnit();

    for k,v in pairs(self.mUnitDic) do
        local tCalendarItem = v:GetActivityCalendarItem();
        if(tCalendarItem ~= nil) then
            if(tCalendarItem.dayTime == calendarItem.dayTime and tCalendarItem.ActivityItem.Type == calendarItem.ActivityItem.Type and tCalendarItem.type == calendarItem.type) then
                index = index > 0 and index or 0;
                index = index > #self.mCalendarItems - 6 and #self.mCalendarItems - 6 or index;
                self:GetScrollViewSpringPanel().target = CS.UnityEngine.Vector3(self.mOriginSpringPanelPosition.x, index * self:GetUnitGridContainer().CellHeight, 0);
                self:GetScrollViewSpringPanel().enabled = true;
                return v:OnSelect();
            end
        end
    end
    return self:SelectDefaultUnit();
end

function UIActivitiesManViewTemplate:UnSelectLast()
    if(self.mLastChooseUnit ~= nil) then
        self.mLastChooseUnit:UnSelect();
    end
end

--endregion

--endregion

function UIActivitiesManViewTemplate:Init()
    self.mOriginSpringPanelPosition = self:GetScrollViewSpringPanel().transform.localPosition;
end


return UIActivitiesManViewTemplate;