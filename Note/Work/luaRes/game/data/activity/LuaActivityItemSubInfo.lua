---@class LuaActivityItemSubInfo 某个类型活动的子活动(例如怪物攻城活动,有3个时间段的子怪物攻城活动)
local LuaActivityItemSubInfo = {}

---@type LuaActivityItem
LuaActivityItemSubInfo.Activity = nil

---@type TABLE.cfg_daily_activity_time
LuaActivityItemSubInfo.Tbl = nil

---@type activityV2.ResDailyActivityStatusChanged
LuaActivityItemSubInfo.mServerActivityData = nil;

---@param tbl TABLE.cfg_daily_activity_time
function LuaActivityItemSubInfo:Init(activityItem, tbl)
    self.Activity = activityItem
    self.Tbl = tbl;
end

---是否能在指定时间天里面开启活动
---@param time number 指定天的凌晨时间戳
function LuaActivityItemSubInfo:IsCanOpenActivityByDay(time)
    ---difDayTime的数值跟输入参数 offsetDay一样, 如果按照一下计算逻辑  会多计算一遍偏移天数导致不准确
    --开服时间第X天
    local openServerTime = gameMgr:GetLuaTimeMgr():GetOpenServerDay(time)
    --跨服时间第X天  现在没有跨服天数处理
    --local kuaFuTime = self:GetKuaFuDay() == 0 and 0 or (self:GetKuaFuDay() + difDayTime);
    local kuaFuTime = 0;
    --星期几
    local weekday = gameMgr:GetLuaTimeMgr():GetWeekDay(time)
    --合服第几天
    local heFuDay = gameMgr:GetLuaTimeMgr():GetCombineServerDay(time)

    --if(self:GetType() == 27) then
        --print("活动不开启 time:"..tostring(time).."    距离今天"..(gameMgr:GetLuaTimeMgr():GetIntervalDay1(time)).."    openServerTime:"..tostring(openServerTime).."   kuaFuTime:"..tostring(kuaFuTime).."     weekday:"..tostring(weekday).."    heFuDay:"..tostring(heFuDay)
        --        )
    --end
    --需要优先执行完所有的开服活动次数,并且冷却之后
    local lastCdOpenServerTime = 0;
    local canOpen = false;

    canOpen = false;
    canOpen = self:CanOpenActivityToShareServer(time);
    if(canOpen) then
        return true;
    end



    --- by 曹众博 2012/4/29 合服活动被跨服影响 策划说不应该影响跨服 将126行注释掉的代码转移到跨服逻辑判断之前
    if(self.Tbl:GetIsShare() ~= 1) then
        --region 根据合服判断显示不显示
        ---联服活动不走合服日期状态
        lastCdOpenServerTime = 0
        canOpen = false;
        canOpen, lastCdOpenServerTime = self:CanOpenActivityToCombineServer(heFuDay);
        if(canOpen) then
            return true;
        end
        --目前合服还没有做
        --if(self.Tbl:GetMergeTime() ~= nil and self.Tbl:GetMergeTime().list ~= nil) then
        --    for i = 0, self.Tbl:GetMergeTime().list.Count - 1 do
        --        local day = self.Tbl:GetMergeTime().list[i]
        --        local cd = day + self.Tbl:GetMergeTimeCD()
        --        if(lastCdOpenServerTime < cd) then
        --            lastCdOpenServerTime = cd
        --        end
        --        if(day == heFuDay) then
        --            return true
        --        end
        --    end
        --end

        if(heFuDay > 0 and heFuDay <= lastCdOpenServerTime) then
            --还没有冷却完成所有的开服活动
            return false
        end
        --endregion
    end


    -----如果处于联服状态中, 只看开服跟日常
    if(gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetShareMapInfo():IsOpenShareMap()) then
        --region 根据开服天数判断显示
        lastCdOpenServerTime = 0;
        canOpen = false;
        canOpen, lastCdOpenServerTime = self:CanOpenActivityToOpenServer(openServerTime);
        if(canOpen) then
            return true;
        end
        if(openServerTime > 0 and openServerTime <= lastCdOpenServerTime) then
            --还没有冷却完成所有的开服活动
            return false
        end
        --endregion

        --region 根据日常星期判断显示
        canOpen = false;
        canOpen = self:CanOpenActivityToWeekDay(weekday);
        if(canOpen) then
            return true;
        end
        --endregion
        return false;
    end

    ---如果没有处于联服活动则执行所有逻辑
    --region 根据合服天数限制判断显示不显示
    canOpen = false;
    canOpen = self:CanOpenActivityToCombineDayLimit(heFuDay);
    if(not canOpen) then
        return false;
    end
    --endregion

    ---假如是跨服活动
    if(self.Tbl:GetIsShare() == 1) then
        if gameMgr:GetPlayerDataMgr()==nil and  CS.CSScene.MainPlayerLianFuState==false then
            return false
        end
        if(gameMgr:GetPlayerDataMgr():GetShareMapInfo():IsOpenShareMap() == false) then
            return false
        end
    end

--- 合服的活动被跨服覆盖
--    if(self.Tbl:GetIsShare() ~= 1) then
--        --region 根据合服判断显示不显示
--        ---联服活动不走合服日期状态
--        lastCdOpenServerTime = 0
--        canOpen = false;
--        canOpen, lastCdOpenServerTime = self:CanOpenActivityToCombineServer(heFuDay);
--        if(canOpen) then
--            return true;
--        end
--        --目前合服还没有做
--        --if(self.Tbl:GetMergeTime() ~= nil and self.Tbl:GetMergeTime().list ~= nil) then
--        --    for i = 0, self.Tbl:GetMergeTime().list.Count - 1 do
--        --        local day = self.Tbl:GetMergeTime().list[i]
--        --        local cd = day + self.Tbl:GetMergeTimeCD()
--        --        if(lastCdOpenServerTime < cd) then
--        --            lastCdOpenServerTime = cd
--        --        end
--        --        if(day == heFuDay) then
--        --            return true
--        --        end
--        --    end
--        --end
--
--        if(heFuDay > 0 and heFuDay <= lastCdOpenServerTime) then
--            --还没有冷却完成所有的开服活动
--            return false
--        end
--        --endregion
--    end

    --region 开服天数判断
    lastCdOpenServerTime = 0;
    canOpen = false;
    canOpen, lastCdOpenServerTime = self:CanOpenActivityToOpenServer(openServerTime);
    if(canOpen) then
        return true;
    end


    --if(self.Tbl:GetServiceTime() ~= nil and self.Tbl:GetServiceTime().list ~= nil) then
    --    for i = 0, self.Tbl:GetServiceTime().list.Count - 1 do
    --        local day = self.Tbl:GetServiceTime().list[i]
    --        local cd = day + self.Tbl:GetTimeCD()
    --        if(lastCdOpenServerTime < cd) then
    --            lastCdOpenServerTime = cd
    --        end
    --        if(day == openServerTime) then
    --            return true
    --        end
    --    end
    --end

    if(openServerTime > 0 and openServerTime <= lastCdOpenServerTime) then
        --还没有冷却完成所有的开服活动
        return false
    end
    --endregion

    --region 日常周几判断
    canOpen = false;
    canOpen = self:CanOpenActivityToWeekDay(weekday);
    if(canOpen) then
        return true;
    end
    --endregion
    return false
end

---@private 根据开服天数判断能否开活动
---@param openServerDay 开服第几天
function LuaActivityItemSubInfo:CanOpenActivityToOpenServer(openServerDay)
    if(self.Tbl == nil) then
        return false;
    end
    local lastCdOpenServerTime = 0;
    if(self.Tbl:GetServiceTime() ~= nil and self.Tbl:GetServiceTime().list ~= nil) then
        for i = 0, self.Tbl:GetServiceTime().list.Count - 1 do
            local day = self.Tbl:GetServiceTime().list[i]
            local cd = day + self.Tbl:GetTimeCD()
            if(lastCdOpenServerTime < cd) then
                lastCdOpenServerTime = cd
            end
            if(day == openServerDay) then
                return true, lastCdOpenServerTime
            end
        end
    end
    return false, lastCdOpenServerTime
end

---@private 根据合服天数判断是否开活动
---@param heFuDay number 合服天数
function LuaActivityItemSubInfo:CanOpenActivityToCombineServer(heFuDay)
    if(self.Tbl == nil) then
        return false;
    end
    local lastCdOpenServerTime = 0;
    if(self.Tbl:GetMergeTime() ~= nil and self.Tbl:GetMergeTime().list ~= nil) then
        for i = 0, self.Tbl:GetMergeTime().list.Count - 1 do
            local day = self.Tbl:GetMergeTime().list[i]
            local cd = day + self.Tbl:GetMergeTimeCD()
            if(lastCdOpenServerTime < cd) then
                lastCdOpenServerTime = cd
            end
            if(day == heFuDay) then
                return true,lastCdOpenServerTime
            end
        end
    end
    return false,lastCdOpenServerTime
end

---@private 根据周几判断是否开活动
---@param weekDay number 周几
function LuaActivityItemSubInfo:CanOpenActivityToWeekDay(weekDay)
    if(self.Tbl == nil) then
        return false;
    end

    if(self.Tbl:GetWeekday() ~= nil and self.Tbl:GetWeekday().list ~= nil) then
        for i = 0, self.Tbl:GetWeekday().list.Count - 1 do
            if(self.Tbl:GetWeekday().list[i] == weekDay) then
                return true
            end
        end
    end
    return false;
end

---@private 合服天数条件判断是否显示活动
function LuaActivityItemSubInfo:CanOpenActivityToCombineDayLimit(combineDay)
    if(self.Tbl == nil) then
        return false;
    end
    if(combineDay > 0) then
        if(self.Tbl:GetMergeTimeProhibit() ~= nil and self.Tbl:GetMergeTimeProhibit() > combineDay) then
            return false;
        end
    end
    return true;
end

---@private 联服活动(类型29的特殊判断)判断是否开启
function LuaActivityItemSubInfo:CanOpenActivityToShareServer(timeStamp)
    if(self.Tbl == nil) then
        return false;
    end
    if(gameMgr:GetPlayerDataMgr()~= nil) then
        if(self.Tbl:GetActivityType() == 29) then
            local shareMapData = gameMgr:GetPlayerDataMgr():GetShareMapInfo():GetShareMapData();
            if(shareMapData ~= nil) then
                local IsOpenShareMap = gameMgr:GetPlayerDataMgr():GetShareMapInfo():IsOpenShareMap();
                --local curDate = CS.Utility_Lua.GetYearMonthDayDescribeByMillisecond(shareMapData.shareOpenTime)
                --local date =  CS.Utility_Lua.GetYearMonthDayDescribeByMillisecond(shareMapData.willUniteUnionTimeOpen)
                --if(date.Length >= 3 and curDate.Length >= 3) then
                --    local year = date[0];
                --    local month = date[1];
                --    local day = date[2];
                --    local curYear = curDate[0];
                --    local curMonth = curDate[1];
                --    local curDay = curDate[2]
                    local targetTimeStamp = shareMapData.willUniteUnionTimeOpen
                    local curTargetTimeStamp = shareMapData.shareOpenTime
                    local isTime = timeStamp == curTargetTimeStamp or timeStamp == gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime();
                    if(shareMapData.shareNum == 0) then
                        if(timeStamp == targetTimeStamp and self.Tbl:GetId() == CS.Cfg_GlobalTableManager.CfgInstance:GetCurCrossServerActivityId(1)) then
                            gameMgr:GetLuaActivityMgr():SetDateToShareStep(timeStamp, 1);
                            return true;
                        end

                        if(IsOpenShareMap and isTime and self.Tbl:GetId() == CS.Cfg_GlobalTableManager.CfgInstance:GetCurCrossServerActivityId(1)) then
                            gameMgr:GetLuaActivityMgr():SetDateToShareStep(timeStamp, 1);
                            return true;
                        end
                    else
                        ---@param v roleV2.ShareOpenTimeInfo
                        for k, v in pairs(shareMapData.shareOpenTimes) do
                            if(v.time == shareMapData.willUniteUnionTimeOpen and timeStamp == targetTimeStamp and self.Tbl:GetId() == CS.Cfg_GlobalTableManager.CfgInstance:GetCurCrossServerActivityId(k)) then
                                gameMgr:GetLuaActivityMgr():SetDateToShareStep(timeStamp, k);
                                return true;
                            end

                            if(v.time == shareMapData.shareOpenTime and timeStamp == gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime() and self.Tbl:GetId() == CS.Cfg_GlobalTableManager.CfgInstance:GetCurCrossServerActivityId(k)) then
                                gameMgr:GetLuaActivityMgr():SetDateToShareStep(timeStamp, k);
                                return true;
                            end
                        end

                        if(IsOpenShareMap and isTime and self.Tbl:GetId() == CS.Cfg_GlobalTableManager.CfgInstance:GetCurCrossServerActivityId(1)) then
                            gameMgr:GetLuaActivityMgr():SetDateToShareStep(timeStamp, shareMapData.shareNum);
                            return true;
                        end
                    end
                --end
            end
        end
    end

    return false;
end


---@public 设置服务器活动开启状态
---@param serverData activityV2.ResDailyActivityStatusChanged
function LuaActivityItemSubInfo:SetServerData(serverData)
    self.mServerActivityData = serverData;
end

---@param state LuaActivityRunningState 默认状态
---@return LuaActivityRunningState
function LuaActivityItemSubInfo:GetRunningStateByServerRunningState(state)
    ---@type number 服务器的活动开启状态 1.开启 2.正常结束 3.提前结束 4.暂停 5.重启
    if(self.mServerActivityData ~= nil) then
        local serverState = self.mServerActivityData.status
        if(serverState ~= nil) then
            if(serverState == 1) then
                return LuaActivityRunningState.IsRunning;
            elseif(serverState == 2) then
                return LuaActivityRunningState.AllOver;
            elseif(serverState == 3) then
                return LuaActivityRunningState.EarlyTermination;
            elseif(serverState == 4) then
                return LuaActivityRunningState.Pause;
            elseif(serverState == 5) then
                return LuaActivityRunningState.IsRunning;
            end
        end
    end
    return state
end

---得到当前活动的运行状态
---@return LuaActivityRunningState
function LuaActivityItemSubInfo:GetRunningState(timeStamp)
    local isCalendarGift = self.Tbl:GetHaveGift() == nil and false or self.Tbl:GetHaveGift() == 1;
    if(isCalendarGift) then
        if(gameMgr:GetPlayerDataMgr() ~= nil) then
            local canGetCalendarGift = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetCalendarGiftState(self.Tbl:GetId()) == 1;
            if(canGetCalendarGift) then
                return LuaActivityRunningState.IsRunning
            else
                return LuaActivityRunningState.AllOver
            end
        end
    else
        ---@type activityV2.ResDailyActivityStatusChanged
        local serverData = self.mServerActivityData;
        if(serverData ~= nil) then
            if(timeStamp == serverData.zeroTime) then
                return self:GetRunningStateByServerRunningState(LuaActivityRunningState.IsRunning)
            end
        end
        return LuaActivityRunningState.IsRunning
    end
    return LuaActivityRunningState.NoOpen
end

---是否正处于开启时间
---@param nowMin 当前的时间(分钟)
function LuaActivityItemSubInfo:IsInOpenTime(nowMin, day)
    if(day == nil) then
        day = gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime()
    end
    --print("当前活动:"..self.Tbl:GetName().."  当前时间:"..nowMin.."     self.Tbl:GetStartTime():"..tostring(self.Tbl:GetStartTime()).."    self.Tbl:GetOverTime():"..tostring(self.Tbl:GetOverTime()))
    ---大于等于开启时间,并且小于等于开启时间
    if(nowMin >= self.Tbl:GetStartTime() and nowMin < self.Tbl:GetOverTime()) then
        if(day == nil) then
            if(self:IsCanOpenActivityByDay(day) == false) then
                return false
            end
        end

        return true
    end
    return false
end

---得到下次开启的时间
---@param now 当前的时间(分钟)
function LuaActivityItemSubInfo:GetNextOpenTime(now)
    return self.Tbl:GetStartTime() - now;
end

---得到是否未开启
---@param nowMin 当前的时间(分钟)
---@param day 指定日期凌晨的时间错
---@return LuaActivityRunningState
function LuaActivityItemSubInfo:GetIsNotOpen(nowMin, day)
    return nowMin < self:GetStartTime()
end


---得到是否已经结束
---@param nowMin 当前的时间(分钟)
---@param day 指定日期凌晨的时间错
---@return LuaActivityRunningState
function LuaActivityItemSubInfo:GetIsOver(nowMin, day)
    local todayTime = gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime();
    if(day == nil) then
        day = todayTime
    end
    if(day < todayTime) then
        ---昨天的活动,那么肯定是已经结束了
        return true
    elseif(day > todayTime) then
        ---明天的活动,现在肯定是没有开启的
        return false
    end

    if(self.Tbl:GetStartTime() > nowMin) then
        return false;
    end

    if(self.Tbl:GetOverTime() == 0)then
        return true
    end
    return nowMin >= self.Tbl:GetOverTime()
end

---得到开启时间
function LuaActivityItemSubInfo:GetStartTime()
    return self.Tbl:GetStartTime()
end

---@public 得到开启时间(几点)
function LuaActivityItemSubInfo:GetStartHour()
    if(self.Tbl ~= nil) then
        return math.floor(self:GetStartTime() / 60);
    end
    return 0;
end

---@public 得到开启时间(几分)
function LuaActivityItemSubInfo:GetStartMinute()
    if(self.Tbl ~= nil) then
        return math.floor(self:GetStartTime() % 60);
    end
    return 0;
end

---得到结束时间
function LuaActivityItemSubInfo:GetOverTime()
    return self.Tbl:GetOverTime()
end

---@public 得到结束时间(几点)
function LuaActivityItemSubInfo:GetOvertHour()
    if(self.Tbl ~= nil) then
        return math.floor(self:GetOverTime() / 60);
    end
    return 0;
end

---@public 得到结束时间(几分)
function LuaActivityItemSubInfo:GetOverMinute()
    if(self.Tbl ~= nil) then
        return math.floor(self:GetOverTime() % 60);
    end
    return 0;
end


function LuaActivityItemSubInfo:GetID()
    return self.Tbl:GetId()
end

function LuaActivityItemSubInfo:GetType()
    return self.Tbl:GetActivityType()
end

---@param min number 需要判定的一个的分钟时间
---@param dayWeeHoursTime number 需要判定的一天凌晨时间
function LuaActivityItemSubInfo:IsMeetOtherCondition(min, dayWeeHoursTime)
    if(self.Tbl:GetActivityType() == LuaEnumDailyActivityType.LevelLimit) then
        return self:ProcessLimitLevelActivity(min, dayWeeHoursTime);
    end

    return true
end
--region 处理特殊的一些活动额外条件

---处理等级封印条件
---@param min number 需要判定的一个的分钟时间
---@param dayWeeHoursTime number 需要判定的一天凌晨时间
function LuaActivityItemSubInfo:ProcessLimitLevelActivity(min, dayWeeHoursTime)
    if(self:IsCanOpenActivityByDay(dayWeeHoursTime)) then
        return true
    end
    return false
end
--endregion

return  LuaActivityItemSubInfo