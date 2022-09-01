---获取的管理类型,用来设置以及或者到活动日历以及活动数据
---@class LuaActivityMgr
local LuaActivityMgr = {}

---历法中可能存在的活动
---@type table<number:活动类型, LuaActivityItem>
LuaActivityMgr.CalendarActivities = nil

---历法中可能存在的活动数量
---@type number
LuaActivityMgr.CalendarActivitiesCount = 0

---@type table<number, number> 未领取小礼包的历法 <id, state>
---state 0:不可领取 1:未领取, 2:已领取
LuaActivityMgr.mCalendarGiftStateDic = nil;

---上次更新活动的时间
---@type number
LuaActivityMgr.LastUpdateActivityTime = nil

---得到一个最大值为3的开服天数,用来做虚假的历法
function LuaActivityMgr:GetOpenServerDayMax3()
    local day = gameMgr:GetLuaTimeMgr():GetOpenServerDay() - 1
    if (day > 3) then
        return 3;
    end
    return day;
end

---初始化每日活动数据
function LuaActivityMgr:InitDailyActivities()
    --self.CalendarActivities = {}
    self:ForPairTable();

    self:InitCalendarCatalog()
    self:InitializeCSCallFunction()

end

function LuaActivityMgr:ForPairTable()
    if self.CalendarActivities ~= nil and self.CalendarActivitiesCount ~= nil and self.CalendarActivitiesCount > 0 then
        return
    end

    self.CalendarActivities = {  }

    clientTableManager.cfg_daily_activity_timeManager:ForPair(function(key, value)
        ---@type TABLE.cfg_daily_activity_time
        local daily_activity_time = value
        if (daily_activity_time:GetIsCalendarShow() == 1) then
            local type = daily_activity_time:GetActivityType()
            if (self.CalendarActivities[type] == nil) then
                self.CalendarActivities[type] = luaclass.LuaActivityItem:New()
            end
            ---@type LuaActivityItem
            local item = self.CalendarActivities[type]
            item:Add(daily_activity_time)
            self.CalendarActivitiesCount = self.CalendarActivitiesCount + 1
        end
    end);
end

---初始化历法目录 (这个目录只有在登入以及跨天的时候去执行更新一次)
---将前3天+后面1个月的所有活动组成清单列表
function LuaActivityMgr:InitCalendarCatalog()
    if (Utility.GetTableCount(self.CalendarActivities) == 0) then
        self:ForPairTable();
    end
    --得到当天凌晨的时间戳
    local NowDayWeeHoursTime = gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime()
    ---@type table<CalendarItem>
    self.CalendarList = {}
    self.CalendarDic = {}
    self.NextCalendarItem = nil

    local openServerDay = gameMgr:GetLuaTimeMgr():GetOpenServerDay();
    local start = self:GetOpenServerDayMax3() * -1;

    self:GenerateShamActivity();

    --从前3天开始获取活动
    for offsetDay = start, 30 do
        ---@param activity LuaActivityItem
        for index, activity in pairs(self.CalendarActivities) do
            local targetDayWeeHoursDay = NowDayWeeHoursTime + offsetDay * gameMgr:GetLuaTimeMgr().DayCostMillisecond
            if (activity:IsCanOpenActivityByDay(targetDayWeeHoursDay)) then
                self:InsertActivityToCalendar(targetDayWeeHoursDay, activity)
            end
        end
    end
    --历法排序
    self:SortCalendarList();
    self:SortCalendarDic()
end

LuaActivityMgr.mPushBeforeFirstDayActivityTypeDic = nil;

function LuaActivityMgr:GetPushBeforeFirstDayActivityTypeDic()
    if (self.mPushBeforeFirstDayActivityTypeDic == nil) then
        self.mPushBeforeFirstDayActivityTypeDic = {};
        local globalTable = LuaGlobalTableDeal.GetGlobalTabl(22545);
        if (globalTable ~= nil) then
            local strs = string.Split(globalTable.value, "#");
            for k, v in pairs(strs) do
                local type = tonumber(v);
                self.mPushBeforeFirstDayActivityTypeDic[type] = type;
            end
        end
    end
    return self.mPushBeforeFirstDayActivityTypeDic;
end

function LuaActivityMgr:GenerateShamActivity()
    if (gameMgr:GetLuaTimeMgr():GetOpenServerDay() <= 3) then
        local time = gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime() - (gameMgr:GetLuaTimeMgr():GetOpenServerDay() + 1) * gameMgr:GetLuaTimeMgr().DayCostMillisecond
        local targetDayWeeHoursDay = (6 - gameMgr:GetLuaTimeMgr():GetOpenServerDay()) * gameMgr:GetLuaTimeMgr().DayCostMillisecond + gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime();
        local typeDic = self:GetPushBeforeFirstDayActivityTypeDic();
        ---@param v LuaActivityItem
        for k, v in pairs(self.CalendarActivities) do
            if (v:IsCanOpenActivityByDay(targetDayWeeHoursDay) and typeDic[v.Type] ~= nil) then
                self:InsertActivityToCalendar(time, v);
            end
        end
    end
end

---@private 注册C#中调用活动数据的接口
function LuaActivityMgr:InitializeCSCallFunction()
    ---沙巴克
    self.CallCSIsOpenShaBaKe = function()
        return Utility.IsOpenShaBaKe();
    end
    CS.CSCalendarInfoV2.Instance:RegisterIsOpenShaBaKeCallFunction(self.CallCSIsOpenShaBaKe);

    ---当天所有活动
    self.CallCSUpdateTodayActivityId = function()
        self:CSUpdateTodayActivityId();
    end
    CS.CSCalendarInfoV2.Instance:RegisterCallUpdateTodayActivityId(self.CallUpdateTodayActivityId);

    ---C#中查看活动状态
    self.CallCSGetActivityState = function(activityType)
        return self:CSGetActivityState(activityType);
    end
    CS.CSCalendarInfoV2.Instance:RegisterLuaGetCalendarActivityState(self.CallUpdateTodayActivityId);

    ---C#中查看是否有正在进行的活动
    self.CallCSHasRunningActivity = function()
        return self:CSHasRunningActivity();
    end
    CS.CSCalendarInfoV2.Instance:RegisterLuaGetHasRunningActivity(self.CallCSHasRunningActivity);
end

---得到指定的历法活动
---@return LuaActivityItem
function LuaActivityMgr:GetCalendarActivity(type)
    if (self.CalendarActivities ~= nil) then
        return self.CalendarActivities[type];
    end
    return nil;
end

---@public 更新历法小礼包的领取状态
---@param list table<number> 未领取的小礼包活动id
function LuaActivityMgr:UpdateCalendarGiftState(list)
    if (list ~= nil) then
        self.mCalendarGiftStateDic = {};
        for k, v in pairs(list) do
            ---因为服务器只会下发已经领取的, 所以这里state设置就只能为1;
            self.mCalendarGiftStateDic[v] = 0;
        end
    end
    luaEventManager.DoCallback(LuaCEvent.Calendar_OnCalendarGiftStateChange)
    --CS.CSNetwork.SendClientEvent(CS.CEvent.Role_UpdateActiveInfo);
end

---@public 获得活动大使显示的活动数据
---@return table<CalendarItem>
function LuaActivityMgr:GetActivityManCalendarData()
    local days = 7;
    local list = self:GetLastFewDaysCalendarData(days);
    local returnList = {};
    ---@param v CalendarItem
    for k, v in pairs(list) do
        local state, activitySubData = v.ActivityItem:GetRunningState();
        if (activitySubData == nil) then
            activitySubData = v.ActivityItem:GetLastActivity();
        end

        if (activitySubData ~= nil) then
            if (self:IsShowInActivityMan(activitySubData.Tbl)) then
                table.insert(returnList, v);
            end
        end
    end
    return returnList;
end

---@public 获得最近几天的历法活动数据
---@return table<CalendarItem>
function LuaActivityMgr:GetLastFewDaysCalendarData(days)
    local todayTimeStamp = gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime();
    local returnList = {};
    if (days > 0) then
        for i = 0, days - 1 do
            local targetDayTimeStamp = todayTimeStamp + i * gameMgr:GetLuaTimeMgr().DayCostMillisecond;
            local targetList = self:GetTargetDayCalendarList(targetDayTimeStamp);
            if (targetList ~= nil) then
                for k, v in pairs(targetList) do
                    table.insert(returnList, v);
                end
            end
        end
    end
    return returnList;
end

---@param state number 0:不可领取 1:未领取, 2:已领取
function LuaActivityMgr:GetCalendarGiftState(activityId)
    ---@type TABLE.cfg_daily_activity_time
    local tbl = clientTableManager.cfg_daily_activity_timeManager:TryGetValue(activityId);
    if (tbl ~= nil and tbl:GetHaveGift() ~= 1) then
        return 0;
    end
    if (self.mCalendarGiftStateDic ~= nil) then
        if (self.mCalendarGiftStateDic[activityId] ~= nil) then
            return self.mCalendarGiftStateDic[activityId];
        end
    end
    return 1
end

---得到当前的凌晨时间
function LuaActivityMgr:GetDayWeeHoursTime(date, offsetDay)
    local data = CS.System.DateTime(date.Year, date.Month, date.Day)
    local weekMillisecondTime = CS.CSServerTime.DateTimeToStampForMilli(data)
    if (offsetDay ~= nil) then
        weekMillisecondTime = weekMillisecondTime + offsetDay * 86400000
    end
    return weekMillisecondTime
end

---目标活动示范开启
function LuaActivityMgr:IsOpenActivity(type)
    if (self.CalendarActivities[type] ~= nil and self.CalendarActivities[type]:IsInOpenTime()) then
        return true
    end
    return false
end

--region 历法信息

---@class CalendarItem 历法信息
---@field dayTime number 当日日期的凌晨时间戳
---@field type LuaEnumCalendarItemType 数据类型 (1:正常的活动) 考虑到以后可能会把一些奇奇怪怪的东西塞进来
---@field ActivityItem LuaActivityItem 活动信息
---@field OtherItem table 其他奇奇怪怪的东西
---@field SortIndex number 历法排序

---历法中可能存在的活动
---@type table<CalendarItem>
LuaActivityMgr.CalendarList = nil

---@type table<number:凌晨时间, table<CalendarItem>>
LuaActivityMgr.CalendarDic = nil

---@param time number 历法的世界
---@param activity LuaActivityItem 活动数据
function LuaActivityMgr:InsertActivityToCalendar(time, activity)
    ---@type CalendarItem
    local CalendarItem = {}
    CalendarItem.type = LuaEnumCalendarItemType.NormalActivity
    CalendarItem.dayTime = time
    CalendarItem.ActivityItem = activity
    CalendarItem.SortIndex = activity.SortIndex
    table.insert(self.CalendarList, CalendarItem);

    if (self.CalendarDic[time] == nil) then
        self.CalendarDic[time] = {}
    end
    table.insert(self.CalendarDic[time], CalendarItem)
end

---得到所有历法显示的活动
---@return table<CalendarItem>
function LuaActivityMgr:GetAllCalendarList()
    return self.CalendarList;
end

---得到下次指定的历法活动
---@return CalendarItem
function LuaActivityMgr:GetNextTargetCalendar(type)
    local nowTime = gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime()
    for i = 0, 30 do
        ---计算凌晨时间
        local time = nowTime + gameMgr:GetLuaTimeMgr().DayCostMillisecond * i

        local list = self.CalendarDic[time];
        if (list ~= nil) then
            ---@param calendarItem CalendarItem
            for index, calendarItem in pairs(list) do
                if (calendarItem.ActivityItem.Type == type) then
                    --这里就不进行状态获取了,简单的判定下时间就够了
                    if (i > 0) then
                        --明天之后的活动肯定是没有开启的
                        return calendarItem
                    end
                    ---@param ActivityItemSubInfo LuaActivityItemSubInfo
                    for ActivityItemSubInfoIndex, ActivityItemSubInfo in pairs(calendarItem.ActivityItem:GetAllActivity()) do
                        if (ActivityItemSubInfo:GetOverTime() > gameMgr:GetLuaTimeMgr():GetNowMinuteTime()) then
                            ---活动还没有接受
                            return calendarItem
                        end
                    end
                end
            end
        end
    end
    return nil
end

---得到今天的所有历法活动
---@return table<CalendarItem>
function LuaActivityMgr:GetTodayCalendarActivities()
    local time = gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime();
    local returnList = {};
    if (self.CalendarList ~= nil) then
        ---@param v CalendarItem
        for k, v in pairs(self.CalendarList) do
            if (v.dayTime == time) then
                table.insert(returnList, v);
            elseif (v.dayTime > time) then
                break ;
            end
        end
    end
    return returnList;
end

---得到指定日期的所有历法活动
---@return table<CalendarItem>
function LuaActivityMgr:GetTargetDayCalendarActivities(time)
    if (self.CalendarDic == nil or self.CalendarDic[time] == nil) then
        return {}
    end
    return self.CalendarDic[time];
end

---得到下次开启的历法活动
---@param list table<CalendarItem>
---@return CalendarItem
function LuaActivityMgr:GetNextOpenActivity(list)
    ---@type LuaActivityItemSubInfo
    local nextActivityItemSubInfo = nil;

    ---@type CalendarItem
    local nextCalendarItem = nil;

    ---@type LuaActivityRunningState
    local nextActivityRunningState = LuaActivityRunningState.NoOpen;

    ---@param calendarItem CalendarItem
    for i, calendarItem in pairs(list) do
        local runningState, activityItemSubInfo = calendarItem.ActivityItem:GetRunningState()

        if (activityItemSubInfo ~= nil) then
            local hasGift = false;
            if (activityItemSubInfo ~= nil) then
                ---是否有礼包(暂时有礼包就认为是系统预告类型, 不参与推送)
                hasGift = activityItemSubInfo.Tbl:GetHaveGift() == 1
            end
            ---因为已经进行了排序,所以第一个不是全部结束的活动就是下次的活动
            if (runningState ~= LuaActivityRunningState.AllOver) then
                if (hasGift) then
                    if (not uiStaticParameter.IsEnterCalendarPanel) then
                        nextCalendarItem = calendarItem;
                        --return
                    end
                else
                    if (nextActivityItemSubInfo == nil or runningState == LuaActivityRunningState.IsRunning or nextActivityItemSubInfo:GetStartTime() > activityItemSubInfo:GetStartTime()) then
                        nextActivityItemSubInfo = activityItemSubInfo;
                        nextActivityRunningState = runningState;
                        nextCalendarItem = calendarItem;
                    end
                end
            end
        end
    end

    return nextCalendarItem
end

---重新排列今天的活动(其他天的活动只有跨天的时候会变化的,所以只需要排列今天的就好)
function LuaActivityMgr:SortTodayCalendar()
    self:SortCalendarList()
end

---对历法信息进行排序
---@param targetTime number 只对指定的时间的活动进行排序
function LuaActivityMgr:SortCalendarList(targetTime)
    if (self.CalendarList == nil) then
        return ;
    end
    self:SortFormData(self.CalendarList)
    --print(#self.CalendarList)
    -------@param leftInfo CalendarItem
    --for i, leftInfo in pairs(self.CalendarList) do
    --    local leftActivityRunningState, leftActivityItemSubInfo = leftInfo.ActivityItem:GetRunningState(leftInfo.dayTime,0);
    --    print(leftActivityItemSubInfo.Tbl:GetName())
    --end
    self:UpdateNextCalendarItem();
end

---对历法字典信息进行排序
function LuaActivityMgr:SortCalendarDic()
    if (self.CalendarDic == nil) then
        return ;
    end
    for i, v in pairs(self.CalendarDic) do
        self:SortFormData(v)
    end
end

---排序表单数据
function LuaActivityMgr:SortFormData(formData)
    if (formData == nil) then
        return
    end
    table.sort(formData, function(a, b)
        ---@type CalendarItem
        local leftInfo = a
        ---@type CalendarItem
        local rightInfo = b
        if (a == b) then
            return false
        end

        --if(targetTime ~= nil and leftInfo.dayTime ~= rightInfo.dayTime and leftInfo.dayTime ~= targetTime) then
        --    return false
        --end

        ---先按照日期去排序,日期早的放左边
        if (leftInfo.dayTime ~= rightInfo.dayTime) then
            return leftInfo.dayTime < rightInfo.dayTime
        end

        local min = nil;
        local dayTime = nil;
        if (leftInfo.dayTime > gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime()) then
            ---往后的时间,都应该是以0点为分割去查询
            min = 0
            dayTime = leftInfo.dayTime;
        end

        local leftActivityRunningState, leftActivityItemSubInfo = leftInfo.ActivityItem:GetRunningState(dayTime, min)
        local rightActivityRunningState, rightActivityItemSubInfo = rightInfo.ActivityItem:GetRunningState(dayTime, min)

        if (leftActivityItemSubInfo == nil or rightActivityItemSubInfo == nil) then
            ---按照活动状态排序全部结束的在最左边    然后就是(已开启/暂停/提前结束),   未开启的
            if (leftActivityRunningState ~= rightActivityRunningState) then
                return leftActivityRunningState < rightActivityRunningState
            end
            ---全部结束的活动/未开启但是开启时间相同的 直接按照活动表的排序来排
            if (leftInfo.ActivityItem.SortIndex ~ rightInfo.ActivityItem.SortIndex) then
                return leftInfo.ActivityItem.SortIndex < rightInfo.ActivityItem.SortIndex
            end
            return leftInfo.ActivityItem.Type < rightInfo.ActivityItem.Type
        end

        ---按照活动状态排序全部结束的在最左边    然后就是(已开启/暂停/提前结束),   未开启的
        if (leftActivityRunningState ~= rightActivityRunningState) then
            return leftActivityRunningState < rightActivityRunningState
        end
        --print("leftActivityRunningState:"..leftActivityRunningState.."      "..leftActivityItemSubInfo.Tbl:GetName()..leftActivityItemSubInfo:GetStartTime().."     "
        --        ..rightActivityItemSubInfo.Tbl:GetName()..rightActivityItemSubInfo:GetStartTime())
        ---未开启的活动按照开启时间排序
        if (leftActivityRunningState == LuaActivityRunningState.NoOpen) then
            if (leftActivityItemSubInfo:GetStartTime() ~= rightActivityItemSubInfo:GetStartTime()) then
                return leftActivityItemSubInfo:GetStartTime() < rightActivityItemSubInfo:GetStartTime()
            end
        end

        ---全部结束的活动/未开启但是开启时间相同的 直接按照活动表的排序来排
        if (leftInfo.ActivityItem.SortIndex ~ rightInfo.ActivityItem.SortIndex) then
            return leftInfo.ActivityItem.SortIndex < rightInfo.ActivityItem.SortIndex
        end
        return leftInfo.ActivityItem.Type < rightInfo.ActivityItem.Type
    end)
end

---得到当前正在进行的/即将开启的历法信息
function LuaActivityMgr:UpdateNextCalendarItem()
    local last = self.NextCalendarItem;
    self.NextCalendarItem = nil
    ---@param calendarItem CalendarItem
    for i, calendarItem in pairs(self.CalendarList) do
        ---最基本的条件怎么也是在当天或者当天之后的活动
        if (calendarItem.dayTime == gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime()) then
            ---如果是正常的活动的话
            if (calendarItem.type == LuaEnumCalendarItemType.NormalActivity) then
                local runningState, activityItemSubInfo = calendarItem.ActivityItem:GetRunningState()
                local hasGift = false;
                if (activityItemSubInfo ~= nil) then
                    ---是否有礼包(暂时有礼包就认为是系统预告类型, 不参与推送)
                    hasGift = activityItemSubInfo.Tbl:GetHaveGift() == 1
                end
                ---因为已经进行了排序,所以第一个不是全部结束的活动就是下次的活动
                if (runningState ~= LuaActivityRunningState.AllOver) then
                    if (hasGift) then
                        if (not uiStaticParameter.IsEnterCalendarPanel) then
                            self.NextCalendarItem = calendarItem;
                            break
                        end
                    else
                        if (self.NextCalendarItem ~= nil) then
                            if (runningState == LuaActivityRunningState.IsRunning) then
                                self.NextCalendarItem = calendarItem;
                                break
                            end
                        else
                            if (runningState ~= LuaActivityRunningState.AllOver and runningState ~= LuaActivityRunningState.EarlyTermination) then
                                self.NextCalendarItem = calendarItem;
                                break
                            end
                        end
                    end
                end
            end
        end
    end
    if (last ~= self.NextCalendarItem) then
        CS.CSNetwork.SendClientEvent(CS.CEvent.Role_UpdateActiveInfo);
    end
end

---得到下次开启的活动
---@return CalendarItem
function LuaActivityMgr:GetNextCalendarItem()
    return self.NextCalendarItem;
end

---@return table<CalendarItem>
function LuaActivityMgr:GetRunningActivity()
    ---@type table<CalendarItem>
    local list = self:GetTodayCalendarActivities()

    local open = {}

    ---@param v CalendarItem
    for i, v in ipairs(list) do
        local state, activity = v.ActivityItem:GetRunningState()
        if (state == LuaActivityRunningState.IsRunning) then
            table.insert(open, v)
        end
    end
    return open;
end

function LuaActivityMgr:GetRunningActivityIdList()
    CS.CSCalendarInfoV2.Instance.RunningActivityIdList:Clear();
    local runningActivities = self:GetRunningActivity();
    if (runningActivities ~= nil) then
        ---@param v CalendarItem
        for k, v in pairs(runningActivities) do
            local state, activitySubInfo = v.ActivityItem:GetRunningState();
            if (activitySubInfo ~= nil) then
                CS.CSCalendarInfoV2.Instance.RunningActivityIdList:Add(activitySubInfo.Tbl:GetId());
            end
        end
    end
    return CS.CSCalendarInfoV2.Instance.RunningActivityIdList;
end

---@return table<CalendarItem>
function LuaActivityMgr:GetTargetDayCalendarList(time)
    return self.CalendarDic[time]
end

---@public 是否在活动大使中显示
---@param tbl TABLE.cfg_daily_activity_time
function LuaActivityMgr:IsShowInActivityMan(tbl)
    --local tbl = clientTableManager.cfg_daily_activity_timeManager:TryGetValue(activityId);
    local panelNameAndParams = tbl:GetPanelNameAndParams();
    if (panelNameAndParams ~= nil and panelNameAndParams ~= "") then
        return true;
    end
    return false;
end

---@public 是否是开服第一次沙巴克
---@param calendarItem CalendarItem
function LuaActivityMgr:IsFirstSabacActivity(calendarItem)
    if (calendarItem == nil) then
        return false;
    end
    if (calendarItem.ActivityItem == nil) then
        return false;
    end
    local openServerTimeStamp = gameMgr:GetLuaTimeMgr():GetOpenServerTime() * 1000;
    local state, activitySubData = calendarItem.ActivityItem:GetRunningState()
    if (activitySubData == nil) then
        activitySubData = calendarItem.ActivityItem:GetLastActivity();
    end
    if (activitySubData ~= nil and calendarItem.ActivityItem.Type == LuaEnumDailyActivityType.ShaBaKe) then
        if (calendarItem.dayTime >= openServerTimeStamp) then
            local openDays = gameMgr:GetLuaTimeMgr():GetOpenServerDay();
            local tableFirstDay = 1;
            ---@type TABLE.IntListJingHao
            local serviceTimeList = activitySubData.Tbl:GetServiceTime()
            if (serviceTimeList ~= nil and serviceTimeList.list.Count > 0) then
                tableFirstDay = serviceTimeList.list[0];
            end
            local intervalDay = gameMgr:GetLuaTimeMgr():GetIntervalDay(calendarItem.dayTime, openServerTimeStamp);
            return intervalDay <= tableFirstDay;
        end
    end
    return false;
end

---@public 是否是合第一次沙巴克
---@param calendarItem CalendarItem
function LuaActivityMgr:IsCombineFirstSabacActivity(calendarItem)
    if (calendarItem == nil) then
        return false;
    end
    if (calendarItem.ActivityItem == nil) then
        return false;
    end

    local combineServerTimeStamp = gameMgr:GetLuaTimeMgr():GetCombineServerTime();
    local state, activitySubData = calendarItem.ActivityItem:GetRunningState()
    if (activitySubData == nil) then
        activitySubData = calendarItem.ActivityItem:GetLastActivity();
        if (calendarItem.ActivityItem.Type == LuaEnumDailyActivityType.ShaBaKe) then
            if (calendarItem.dayTime >= combineServerTimeStamp) then
                local tableFirstDay = 1;
                ---@type TABLE.IntListJingHao
                local mergeTimeList = activitySubData.Tbl:GetMergeTime()
                if (mergeTimeList ~= nil and mergeTimeList.list.Count > 0) then
                    tableFirstDay = mergeTimeList.list[0];
                end
                local intervalDay = gameMgr:GetLuaTimeMgr():GetIntervalDay(calendarItem.dayTime, combineServerTimeStamp);
                return intervalDay <= tableFirstDay;
            end
        end
    end
    return false;
end

function LuaActivityMgr:GetTodayShaBaKeState()
    local activityType = LuaEnumDailyActivityType.ShaBaKe;
    local todayActivities = self:GetTodayCalendarActivities();
    ---@param v CalendarItem
    for k, v in pairs(todayActivities) do
        if (v.ActivityItem.Type == activityType) then
            local state, activitySubInfo = v.ActivityItem:GetRunningState();
            return state;
        end
    end
    return LuaActivityRunningState.NoOpen
end

---@public 是否有系统预告
---@param calendarItem CalendarItem
function LuaActivityMgr:HasSystemOpen(calendarItem)
    if (calendarItem == nil) then
        return false;
    end
    if (calendarItem.ActivityItem == nil) then
        return false;
    end
    local activities = calendarItem.ActivityItem:GetAllActivity();
    if (activities ~= nil) then
        ---@param v LuaActivityItemSubInfo
        for k, v in pairs(activities) do
            if (v.Tbl.GetNewSystem ~= nil and v.Tbl:GetNewSystem() == 1) then
                return true;
            end
        end
    end
    return false;
end

---@return string
function LuaActivityMgr:GetLoadingTextureName()
    ---@type table<number,CalendarItem>
    local table = self:GetTodayCalendarActivities()
    if table == nil then
        return ""
    end
    for i, v in pairs(table) do
        if v.ActivityItem ~= nil then
            ---@type LuaActivityItemSubInfo
            --  local State, subinfo = v.ActivityItem:GetRunningState()
            local subinfo = v.ActivityItem:GetLastActivity()
            if subinfo ~= nil then
                ---@type TABLE.cfg_daily_activity_time
                local Tbl = subinfo.Tbl
                if Tbl ~= nil then
                    return Tbl:GetLoading()
                end
            end
        end
    end
    return ""
end

--endregion

--region C#中调用的方法

---@private 更新C#中的今天的所有活动id
function LuaActivityMgr:CSUpdateTodayActivityId()
    CS.CalendarInfoV2.Instance.TodayAllActivityIdList:Clear();
    local calendarItems = self:GetTodayCalendarActivities();
    if (calendarItems ~= nil) then
        ---@param v CalendarItem
        for k, v in pairs(calendarItems) do
            local state, activitySubInfo = v.ActivityItem:GetRunningState();
            if (activitySubInfo == nil) then
                activitySubInfo = v.ActivityItem:GetLastActivity();
            end
            if (activitySubInfo ~= nil) then
                CS.CalendarInfoV2.Instance.TodayAllActivityIdList:Add(activitySubInfo.Tbl:GetId());
            end
        end
    end
end

---@private C#中获取今天活动的开启状态
---@return boolean 是否开启
function LuaActivityMgr:CSGetActivityState(activityType)
    local todayCalendarItem = self:GetTodayCalendarActivities();
    if (todayCalendarItem ~= nil) then
        ---@param v CalendarItem
        for k, v in pairs(todayCalendarItem) do
            if (v.ActivityItem.Type == activityType) then
                local state, activitySubInfo = v.ActivityItem:GetRunningState();
                return state == LuaActivityRunningState.IsRunning;
            end
        end
    end
    return false;
end

---@private C#中获取是否有正在进行的活动
---@return boolean
function LuaActivityMgr:CSHasRunningActivity()
    local todayCalendarItem = self:GetTodayCalendarActivities();
    if (todayCalendarItem ~= nil) then
        ---@param v CalendarItem
        for k, v in pairs(todayCalendarItem) do
            local state, activitySubInfo = v.ActivityItem:GetRunningState();
            if (state == LuaActivityRunningState.IsRunning) then
                if (activitySubInfo ~= nil) then
                    local isCalendarGift = activitySubInfo.Tbl:GetHaveGift() == nil and false or activitySubInfo.Tbl:GetHaveGift() == 1;
                    local canGetCalendarGift = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetCalendarGiftState(activitySubInfo.Tbl:GetId()) == 1;
                    if (isCalendarGift) then
                        if (canGetCalendarGift and not uiStaticParameter.IsEnterCalendarPanel) then
                            CS.CalendarInfoV2.Instance.RunningActivityId = activitySubInfo.Tbl:GetId();
                            return true;
                        end
                    else
                        ---如果不在活动地图中才提示
                        if (activitySubInfo.Tbl:GetActivityMapId() ~= nil and activitySubInfo.Tbl:GetActivityMapId().list.Count > 0) then
                            if (not CS.CSScene.MainPlayerInfo:IsInMap(activitySubInfo.Tbl:GetActivityMapId().list)) then
                                CS.CalendarInfoV2.Instance.RunningActivityId = activitySubInfo.Tbl:GetId();
                                return true;
                            end
                        else
                            CS.CalendarInfoV2.Instance.RunningActivityId = activitySubInfo.Tbl:GetId();
                            return true;
                        end
                    end
                end
            end
        end
    end
    return false;
end

--endregion

---@public 尝试前往历法活动
---@param calendarItem CalendarItem
---@return number 0:正常参加 5:活动已结束 10:条件不满足
function LuaActivityMgr:TryGoToCalendarActivity(calendarItem)
    if (calendarItem.type == LuaEnumCalendarItemType.NormalActivity) then
        return self:TryGoToNormalActivity(calendarItem.ActivityItem)
    end
end


--region 尝试前往历法活动

---处理历法内的普通活动
---@param activity LuaActivityItem
---@return number 0:正常参加 5:活动已结束 10:条件不满足
function LuaActivityMgr:TryGoToNormalActivity(activity)

    local runState, ActivityItemSubInfo = activity:GetRunningState()

    if (runState == LuaActivityRunningState.AllOver) then
        return 5;
    end
    if self:NotJoinCalendarTip(ActivityItemSubInfo.Tbl) then
        return 10;
    end

    local isContinue = true
    local isClosePanel = false;
    if (activity.Type == LuaEnumDailyActivityType.GuildEscort) then
        --行会押镖
        isContinue, isClosePanel = self:TryGoToGuildEscort(nil)
    elseif (activity.Type == LuaEnumDailyActivityType.GuildBoss) then
        --行会boss
        isContinue, isClosePanel = self:TryGoToGuildBoss(nil, activity, ActivityItemSubInfo)
    elseif (activity.Type == LuaEnumDailyActivityType.HJMiGong) then
        --幻境迷宫
        isContinue, isClosePanel = self:TryGoToHJMiGong(nil, activity, ActivityItemSubInfo)
    end

    if (isContinue == true) then
        if (ActivityItemSubInfo ~= nil) then
            local type, param = activity:GetJumpParam()
            self:TryGoToCommonActivity(type, param)
        end
    end
    return 0;
end

--region 通用处理

---正常跳转
---@param type number 跳转类型
---@param param number 跳转参数
function LuaActivityMgr:TryGoToCommonActivity(type, param)
    if (type == 1) then
        --点击后直接传送到目标地图坐标
        if (param ~= nil) then
            local isFind, deliverTable = CS.Cfg_DeliverTableManager.Instance:TryGetValue(param);
            if (isFind) then
                networkRequest.ReqDeliverByConfig(param)
            else
                CS.UnityEngine.Debug.LogError("没有在传送表DeliverTable中找到对应ID:" .. tonumber(param) .. "  看看哪个策划又双叒叕填错了")
            end
        end
    elseif (type == 2) then
        --点击关闭历法界面，寻路到对应npc，然后打开npc面板
        local res = CS.CSScene.MainPlayerInfo.AsyncOperationController.CalendarFindNpcOperation:DoOperation(param);
        if CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(res) < 0 then
            CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:TryPauseOperation(function()
                self:TryGoToCommonActivity(type, param);
                uimanager:ClosePanel("UICalendarPanel");
            end)
            return
        end
    elseif (type == 3) then
        --上次去过的主城的npcid
        local mapNpcId = CS.CSScene.MainPlayerInfo.MapInfoV2:GetLastMainCityMapNpcId(param);

        local res = CS.CSScene.MainPlayerInfo.AsyncOperationController.CalendarFindNpcOperation:DoOperation(mapNpcId);
        if CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(res) < 0 then
            CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:TryPauseOperation(function()
                self:TryGoToCommonActivity(type, param);
                uimanager:ClosePanel("UICalendarPanel");
            end)
            return
        end
    elseif (type == 4) then
        uiTransferManager:TransferToPanel(param)
    else
        uimanager:CreatePanel("UICalendarPanel");
    end
end

---达不到参加历法条件提示
---@param tbl TABLE.cfg_daily_activity_time
function LuaActivityMgr:NotJoinCalendarTip(tbl)
    if (tbl ~= nil and tbl:GetCondition() ~= nil and tbl:GetCondition() ~= 0) then
        local conditionId = tbl:GetCondition();
        if (not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionId)) then
            local isFind1, bubbleTable = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(262)
            if isFind1 then
                local isFind2, conditionTable = CS.Cfg_ConditionManager.Instance:TryGetValue(conditionId);
                if (isFind2) then
                    if (conditionTable.conditionParam ~= nil and conditionTable.conditionParam.list.Count > 0) then
                        local des = string.format(bubbleTable.content, conditionTable.conditionParam.list[0]);
                        --Utility.ShowPopoTips(self:GetBtnGo_GameObject(), des, 262, "UICalendarPanel");
                        return true, des;
                    end
                end
            end
        end
    end
    return false
end

--endregion


--endregion


--region 各各活动的特殊处理

---行会押镖
---@param activity LuaActivityItem
---@param activityItemSubInfo LuaActivityItemSubInfo 当前开启的活动
---@param go UnityEngine.GameObject 提示附着节点
---@return boolean,boolean 是否继续执行通用逻辑,是否关闭界面(只有当第一个为true的时候才会生效)
function LuaActivityMgr:TryGoToGuildEscort(go, activity, ActivityItemSubInfo)
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        local UnionInfo = mainPlayerInfo.UnionInfoV2
        if UnionInfo and UnionInfo.UnionID == 0 then
            if (go ~= nil and not CS.StaticUtility.IsNull(go)) then
                Utility.ShowPopoTips(go, nil, 134)
            end
            return false, false
        end
    end
    --请求加入帮会押镖活动
    Utility.ReqJoinUnionDartCarActivity(go)
    return true
end

---行会首领
---@param activity LuaActivityItem
---@param activityItemSubInfo LuaActivityItemSubInfo 当前开启的活动
---@param go UnityEngine.GameObject 提示附着节点
---@return boolean,boolean 是否继续执行通用逻辑,是否关闭界面(只有当第一个为true的时候才会生效)
function LuaActivityMgr:TryGoToGuildBoss(go, activity, ActivityItemSubInfo)
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        local UnionInfo = mainPlayerInfo.UnionInfoV2
        if UnionInfo and UnionInfo.UnionID == 0 then
            Utility.ShowUnionPush()
            return false, false
        end
    end
    return true
end

---幻境迷宫
---@param activity LuaActivityItem
---@param activityItemSubInfo LuaActivityItemSubInfo 当前开启的活动
---@param go UnityEngine.GameObject 提示附着节点
---@return boolean,boolean 是否继续执行通用逻辑,是否关闭界面(只有当第一个为true的时候才会生效)
function LuaActivityMgr:TryGoToHJMiGong(go, activity, activityItemSubInfo)
    --networkRequest.ReqDeliverByConfig(activityItemSubInfo.Tbl:GetDeliverId())
    return true, true
end

---@type table<number, number> 时间戳对应的联服次数
LuaActivityMgr.mDateToShareStepDic = nil;

---@public 设置时间戳对应联服次数
function LuaActivityMgr:SetDateToShareStep(timeStamp, shareStep)
    if (self.mDateToShareStepDic == nil) then
        self.mDateToShareStepDic = {};
    end
    self.mDateToShareStepDic[timeStamp] = shareStep;
end

---@return roleV2.ShareOpenTimeInfo
function LuaActivityMgr:GetShareServerData(timeStamp)
    if (self.mDateToShareStepDic ~= nil) then
        local shareStep = self.mDateToShareStepDic[timeStamp];
        shareStep = shareStep == nil and 1 or shareStep;
        local shareMapData = gameMgr:GetPlayerDataMgr():GetShareMapInfo():GetShareMapData();
        if (shareMapData ~= nil) then
            ---@type roleV2.ShareOpenTimeInfo
            local shareData = shareMapData.shareOpenTimes[shareStep];
            return shareData;
        end
    end
    return nil;
end

--endregion



return LuaActivityMgr