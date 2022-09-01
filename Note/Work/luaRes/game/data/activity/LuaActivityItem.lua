---@class LuaActivityItem
local LuaActivityItem = {}

---当前活动类型中的子活动
---@table<LuaActivityItemSubInfo>
LuaActivityItem.ActivityInfos = nil

---当前活动类型
---@type
LuaActivityItem.Type = nil
---当前活动历法排序
LuaActivityItem.SortIndex = nil

LuaActivityItem.StartActivityIndex = nil

---一天需要花费的毫秒时间
LuaActivityItem.DayCostMillisecond = 86400000

function LuaActivityItem:Init()
    self.ActivityInfos = {}
end

---同一个活动可能由于跨服/合服这些理由各种分开配置了同一个活动的多个活动数据,在判定的时候需要都进行判定
---@param tbl TABLE.cfg_daily_activity_time
function LuaActivityItem:Add(tbl)
    ---@type LuaActivityItemSubInfo
    local info = luaclass.LuaActivityItemSubInfo:New(self, tbl)
    local count = #self.ActivityInfos
    if(count == 0) then
        table.insert(self.ActivityInfos, info)
        self.StartActivityIndex = 1
    else
        local isInsert = false
        for i = count, 1, -1 do
            if(self.ActivityInfos[i].Tbl:GetStartTime() < tbl:GetStartTime()) then
                table.insert(self.ActivityInfos, i + 1, info)
                isInsert = true
                break;
            end
        end
        if(isInsert == false) then
            table.insert(self.ActivityInfos, 1, info)
        end
    end

    self.Type = tbl:GetActivityType()
    self.SortIndex = tbl:GetOrder()
end

---是否今日开启
function LuaActivityItem:IsTodayOpen()
    return self:IsCanOpenActivityByDay(gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime())
end

---是否能在指定时间天里面开启活动
---@param time number 指定日期的凌晨时间
function LuaActivityItem:IsCanOpenActivityByDay(time)
    ---@param activity LuaActivityItemSubInfo
    for i, activity in pairs(self.ActivityInfos) do
        if(activity:IsCanOpenActivityByDay(time)) then
            return true
        end
    end

    --if(self.Type == 16) then
    --    print("活动不开启 time:"..tostring(time).."    距离今天"..difDayTime.."    openServerTime:"..tostring(openServerTime).."   kuaFuTime:"..tostring(kuaFuTime).."     weekday:"..tostring(weekday).."    heFuDay:"..tostring(heFuDay)
    --            )
    --end
    return false
end

---是否正处于开启时间
---@param minute number/nil 当前天处于第几分钟,没有传东西的时候,自动获取当前时间
---@param day number/nil 当前天处于第几分钟,没有传东西的时候,自动获取当前日期凌晨时间
function LuaActivityItem:IsInOpenTime(minute, day)
    if(day == nil) then
        day = gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime()
    end

    if(self:IsCanOpenActivityByDay(day) == false) then
        return false
    end

    if(minute == nil) then
        minute = gameMgr:GetLuaTimeMgr():GetNowMinuteTime()
    end

    ---@param activity LuaActivityItemSubInfo
    for i, activity in pairs(self.ActivityInfos) do
        if(activity:IsInOpenTime(minute, day)) then
            return true
        end
    end
end

function LuaActivityItem:SetServerRunningState(state)
    self.mServerRunningState = state;
end

---local activityRunningState,activityItemSubInfo = self.mCalendarVo.ActivityItem:GetRunningState()
---是否活动正在进行中
---有些活动可能会提前结束(PS:行会首领杀了,活动就结束了)
---有些活动可能再结束之前会暂停(PS:怪物攻城 1次活动中会有3波怪  每波怪之后暂停)
---@return LuaActivityRunningState,LuaActivityItemSubInfo 不是结束或者未开启状态,回返回正在时间的活动
---注意如果返回LuaActivityRunningState.NoOpen 那么当LuaActivityItemSubInfo有值的时候 返回的是下一个活动
---如果没有值的时候,说明这个类型的活动当前全部完成了,再去手动调用GetLastActivity()获取最后一次活动信息
function LuaActivityItem:GetRunningState(dayWeeHoursTime, min)

    if(dayWeeHoursTime ~= nil) then
        if(min == nil) then
            if(dayWeeHoursTime < gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime()) then
                min = 1440
            elseif(dayWeeHoursTime > gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime()) then
                min = 0;
            end
        end
    else
        dayWeeHoursTime = gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime()
    end
    if(min == nil) then
        min = gameMgr:GetLuaTimeMgr():GetNowMinuteTime()
    end

    ---@param activity LuaActivityItemSubInfo
    for i, activity in pairs(self.ActivityInfos) do
        if(activity:IsInOpenTime(min)) then
            if(dayWeeHoursTime ~= nil and self:IsCanOpenActivityByDay(dayWeeHoursTime)) then
                return activity:GetRunningState(dayWeeHoursTime), activity
            end
        end
    end
    ---以前日期的
    if(dayWeeHoursTime ~= nil and dayWeeHoursTime < gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime()) then
        return LuaActivityRunningState.AllOver, nil
    end
    ---未来的
    if(dayWeeHoursTime ~= nil and dayWeeHoursTime > gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime()) then
        return LuaActivityRunningState.NoOpen, self:GetNextOpenActivity(0,dayWeeHoursTime)
    end

    local activityItemSubInfo = self:GetNextOpenActivity(nil, dayWeeHoursTime);
    --没有下次活动了,那么就是全部结束了
    if(activityItemSubInfo == nil) then
        return LuaActivityRunningState.AllOver, nil
    end

    return LuaActivityRunningState.NoOpen, activityItemSubInfo
end

function LuaActivityItem:GetTargetTimeActivity(timeStamp)
    ---@param activity LuaActivityItemSubInfo
    for i, activity in pairs(self.ActivityInfos) do
        if(timeStamp ~= nil and activity:IsCanOpenActivityByDay(timeStamp)) then
            return activity;
        end
    end
    return nil
end

---得到当前活动类型,下一次开启的具体活动信息
---@param time number/nil 当前天处于第几分钟
---@return LuaActivityItemSubInfo
function LuaActivityItem:GetNextOpenActivity(time, dayWeeHoursTime)
    if(time == nil) then
        time = gameMgr:GetLuaTimeMgr():GetNowMinuteTime()
    end
    if(dayWeeHoursTime == nil) then
        dayWeeHoursTime = gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime()
    end
    ---@type LuaActivityItemSubInfo
    local nextActivity = nil
    ---@param activity LuaActivityItemSubInfo
    for i, activity in pairs(self.ActivityInfos) do
        if(activity:IsMeetOtherCondition(time, dayWeeHoursTime) and  activity:GetStartTime() >= time) then
            --没有必要继续走了,插入表格的时候已经进行了排序
            nextActivity = activity;
            break
        end
    end
    return nextActivity
end

---获得这个活动的所有配置活动
---@return table<LuaActivityItemSubInfo>
function LuaActivityItem:GetAllActivity()
    return self.ActivityInfos
end

---得到最后一个活动(在当前没有下一次活动的情况下,拿到的是最后一次的活动)
---@return LuaActivityItemSubInfo
function LuaActivityItem:GetLastActivity()
    local index = #self.ActivityInfos
    return self.ActivityInfos[index]
end

---得到活动的跳转参数
---@return number,number 跳转类型,具体参数
function LuaActivityItem:GetJumpParam()
    ---@type LuaActivityRunningState,
    local runState, ActivityItemSubInfo = self:GetRunningState()
    if(ActivityItemSubInfo ~= nil) then
        local s = ActivityItemSubInfo.Tbl:GetJumpButton()
        local str = string.Split(ActivityItemSubInfo.Tbl:GetJumpButton(), '#')
        return tonumber(str[1]), tonumber(str[2])
    end
    return 0,0
end


---@class LuaActivityRunningState
LuaActivityRunningState = {
    ---全部结束
    AllOver = 0,
    ---提前结束
    EarlyTermination = 5,
    ---活动进行中
    IsRunning = 10,
    ---暂停
    Pause = 20,
    ---活动没有开启
    NoOpen = 99,
}

return LuaActivityItem