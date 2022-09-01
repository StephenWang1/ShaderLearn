---@class UICalendarViewTemplate
local UICalendarViewTemplate = {};

---@type table<UnityEngine.GameObject, UICalendarUnitTemplate>
UICalendarViewTemplate.mUnitDic = nil;

--region Components

function UICalendarViewTemplate:GetGridContainer()
    if (self.mGridContainer == nil) then
        self.mGridContainer = self:Get("Scroll View/Actives", "UIGridContainer");
    end
    return self.mGridContainer;
end

function UICalendarViewTemplate:GetScrollView()
    if (self.mScrollView == nil) then
        self.mScrollView = self:Get("Scroll View", "UIScrollView");
    end
    return self.mScrollView;
end

function UICalendarViewTemplate:GetScrollViewSpringPanel()
    if (self.mScrollViewSpringPanel == nil) then
        self.mScrollViewSpringPanel = self:Get("Scroll View", "SpringPanel");
    end
    return self.mScrollViewSpringPanel;
end

---@return UILoopScrollViewPlus
function UICalendarViewTemplate:GetLoopScrollViewComponent()
    if (self.mLoopScrollViewComponent == nil) then
        self.mLoopScrollViewComponent = self:Get("Scroll View", "UILoopScrollViewPlus");
    end
    return self.mLoopScrollViewComponent;
end

function UICalendarViewTemplate:GetLoopScrollViewArrowComponent()
    if (self.mLoopScrollViewArrowComponent == nil) then
        self.mLoopScrollViewArrowComponent = self:Get("arrowPanel", "UIScrollViewArrow");
    end
    return self.mLoopScrollViewArrowComponent;
end

--endregion

---@type table<CalendarItem>
UICalendarViewTemplate.CalendarItemList = nil

function UICalendarViewTemplate:Init(panel)
    ---@type UIBase
    self.mOwnerPanel = panel

    self:UpdateAllCalendarActivities()

    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Calendar_OnCalendarDateUnitClicked, function (id, data)
        self:JumpTargetDayStartIndex(data.mTimeStampUtc);
    end);

    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResAllCalendarGiftStateMessage, function (id, data)
        for k,v in pairs(self.mUnitDic) do
            v:OnCalendarGiftChange();
        end
    end);
end

UICalendarViewTemplate.CalendarJumpDic = {}
---更新所有历法的活动
---@return table<number, table<LuaActivityItem>>
function UICalendarViewTemplate:UpdateAllCalendarActivities()
    ---@type table<CalendarItem>
    self.CalendarItemList = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetAllCalendarList()

    self.CalendarJumpDic = {}
    local index = 1
    ---@param v CalendarItem
    for i, v in ipairs(self.CalendarItemList) do
        if(self.CalendarJumpDic[v.dayTime] == nil) then
            self.CalendarJumpDic[v.dayTime] = index;
        end
        index = index + 1
    end
end
UICalendarViewTemplate.LastShowUnitIndex = 0

function UICalendarViewTemplate:UpdateView()
    self:GetLoopScrollViewArrowComponent():InitMaxCount(10);
    self.LastShowUnitIndex = 0;
    self:GetLoopScrollViewComponent():Init(function(go, line)
        return self:OnLoopScrollViewTempCallBack(go, line)
    end, nil);
end


function UICalendarViewTemplate:OnLoopScrollViewTempCallBack(obj, line)
    if (self.mUnitDic == nil) then
        self.mUnitDic = {};
    end
    local count = #self.CalendarItemList;
    if (count > line) then
        ---@type CalendarItem
        local item = self.CalendarItemList[line + 1];
        if (self.mUnitDic[obj] == nil) then
            self.mUnitDic[obj] = templatemanager.GetNewTemplate(obj, luaComponentTemplates.UICalendarUnitTemplate);
        end
        self.mUnitDic[obj]:UpdateUnit(item);

        if(line > self.LastShowUnitIndex and line > 5) then
            --向右划
            ---@type CalendarItem
            local right = self.CalendarItemList[line - 4];

            self:MoveCalendarSendEventJumpDate(right.dayTime)
        end
        if(line < self.LastShowUnitIndex) then
            --向左划
            self:MoveCalendarSendEventJumpDate(item.dayTime)
        end
        self.LastShowUnitIndex = line

        return true;
    end
    return false;
end

UICalendarViewTemplate.JumpTarget = nil

---历法日期点击的时候,需要下方的活动自动滑动
function UICalendarViewTemplate:JumpTargetDayStartIndex(time)
    local index = self.CalendarJumpDic[time]
    if(index == nil) then
        return
    end

    if(time == gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime()) then
        local allCalendarList = gameMgr:GetLuaActivityMgr():GetAllCalendarList()
        local todayStartIndex = 0;
        ---@param v CalendarItem
        for k,v in pairs(allCalendarList) do
            if(v.dayTime ~= time) then
                todayStartIndex = k;
            else
                break;
            end
            --local state, activitySubInfo = v.ActivityItem:GetRunningState(v.dayTime);
            --if(state == LuaActivityRunningState.IsRunning or state == LuaActivityRunningState.Pause and v.ActivityItem.Type ~= LuaEnumDailyActivityType.CalendarGift)  then
            --    index = k;
            --    break;
            --end
            --
            --if(state == LuaActivityRunningState.NoOpen and v.ActivityItem.Type ~= LuaEnumDailyActivityType.CalendarGift)   then
            --    index = k;
            --    break;
            --end
        end
        index = todayStartIndex + 1;
        local todayCalendarList = gameMgr:GetLuaActivityMgr():GetTodayCalendarActivities();
        if(todayCalendarList ~= nil) then
            for k,v in pairs(todayCalendarList) do
                local state, activitySubInfo = v.ActivityItem:GetRunningState(v.dayTime);
                if(state == LuaActivityRunningState.IsRunning or state == LuaActivityRunningState.Pause and v.ActivityItem.Type ~= LuaEnumDailyActivityType.CalendarGift)  then
                    index = todayStartIndex + k;
                    break;
                end

                if(state == LuaActivityRunningState.NoOpen and v.ActivityItem.Type ~= LuaEnumDailyActivityType.CalendarGift)   then
                    index = todayStartIndex + k;
                    break;
                end
            end
            local offset = 2;
            local todayEndIndex = todayStartIndex + #todayCalendarList;
            index = index > todayEndIndex - offset and todayEndIndex - offset or index;
        end
    end


    self:JumpTargetIndex(index);
end

---@param calendarItem CalendarItem
function UICalendarViewTemplate:JumpTargetCalendar(calendarItem)
    if(calendarItem == nil) then
        return
    end
    local index = 1;
    ---@param v CalendarItem
    for k,v in pairs(self.CalendarItemList) do
        if(v == calendarItem) then
            index = k;
            break;
        end
    end

    self:JumpTargetIndex(index);
end

---历法日期点击的时候,需要下方的活动自动滑动
function UICalendarViewTemplate:JumpTargetIndex(index)

    if(index >= #self.CalendarItemList - 4) then
        index = #self.CalendarItemList - 4
    end

    --lua下标是从1开始 但是C#下标从0开始
    self.JumpTarget =  index - 1;

    local targetPosition = self:GetLoopScrollViewComponent():GetJumpToLineV3(self.JumpTarget);

    local x = -targetPosition.x;
    if(self.JumpTarget ~= 0) then
        x = x + 100;
    end

    self:GetScrollViewSpringPanel().target = CS.UnityEngine.Vector3(x, targetPosition.y, targetPosition.z);
    self:GetScrollViewSpringPanel().enabled = true;
end

---移动历法,需要发送事件,告知上方日期发生变动
function UICalendarViewTemplate:MoveCalendarSendEventJumpDate()
    local x = self:GetLoopScrollViewComponent().Panel.clipOffset.x + 300;
    if(x < 0) then
        x = 0;
    end
    local index = math.floor(x / self:GetLoopScrollViewComponent().CellLeghth)

    if(self.JumpTarget ~= nil) then
        ---这里是为了减少消耗,不然点击一个很后面的,会分发事件几百次,这里只分发最后的
        if(self.JumpTarget <= index + 1) then
            index = self.JumpTarget;
            self.JumpTarget = nil
        else
            return;
        end
    end
    --if(self:GetScrollViewSpringPanel().enabled== true) then
    --    return
    --end
    local time = 0;
    ---@param v number 下标
    ---@param t number 日期的时间
    for t, v in pairs(self.CalendarJumpDic) do
        if(v <= index + 1 and time < t) then
            time = t;
        end
    end

    if(time ~= 0 and time ~= self.LastMoveSelectTime) then
        self.LastMoveSelectTime = time;
        luaEventManager.DoCallback(LuaCEvent.Calendar_OnCurrentTimeStampUtcChanged, time)
    end
end

return UICalendarViewTemplate;