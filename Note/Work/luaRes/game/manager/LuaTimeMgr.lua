---@class LuaTimeMgr lua的时间管理类
local LuaTimeMgr = {}

---检测的间隔
LuaTimeMgr.UpdateFrame = 150
---检测的时间
LuaTimeMgr.UpdateFrameIndex = 0

---指定注册事件
---里面有.time   .action
LuaTimeMgr.TimeRegisterTable = {}

---自增注册事件
---里面有.time   .action
LuaTimeMgr.TimeRegisterAutoIncrementTable = {}

---自增时间事件的ID
LuaTimeMgr.AutoIncrementID = 1

---开服的服务器时间
---@private
LuaTimeMgr.OpenServerTime = nil

---开服天数
---@private
LuaTimeMgr.OpenServerDay = nil

---跨服的服务器时间
---@private
LuaTimeMgr.KuFuServerTime = nil

---跨服的服务器天数
---@private
LuaTimeMgr.KuFuServerDay = nil

---当前的凌晨时间
---@private
LuaTimeMgr.NowDayWeeHoursTime = nil

---一天有这么多毫秒
---@public
LuaTimeMgr.DayCostMillisecond = 86400000

LuaTimeMgr.LastGetNowDayWeeHoursTime = 0
---这里不置为nil就是为了给所有的不断调用
LuaTimeMgr.LastGetNowTime = 0

---@param tblData userV2.ResHeart lua table类型消息数据
function LuaTimeMgr:ResHeartMessage(tblData)
    self:UpdateNowDayWeeHoursTime(tblData.nowTime)
end

function LuaTimeMgr:Reset()
    self.LastGetNowDayWeeHoursTime = 0;
    self.LastGetNowTime = 0;

    self.OpenServerTime = nil;
    self.OpenServerDay = nil;
    self.KuFuServerTime = nil;
    self.KuFuServerDay = nil;
    self.CombineServerDay = nil;
    self.CombineServerTime = nil;
    self.NowDayWeeHoursTime = nil;
    self.TimeRegisterAutoIncrementTable = {};
    self.TimeRegisterTable = {}
end

--region 事件的注册与定时执行

---时间更新,每帧变化
function LuaTimeMgr:Update()
    --为了避免每帧检测(需要从C#中拿到时间数据,周期性检测时间,所以可能会相差几秒)
    if (self.UpdateFrameIndex < self.UpdateFrame) then
        self.UpdateFrameIndex = self.UpdateFrameIndex + 1;
        return
    end
    self.UpdateFrameIndex = 0;
    local now = CS.CSServerTime.Instance.TotalMillisecond;
    self:UpdateNormalEvent(now)
    self:UpdateAutoIncrementEvent(now)
end

---检测正常的注册事件
function LuaTimeMgr:UpdateNormalEvent(now)
    local actionEventId = nil
    for i, v in pairs(self.TimeRegisterTable) do
        if (v ~= nil and now >= v.time) then
            if (actionEventId == nil) then
                actionEventId = {}
            end
            table.insert(actionEventId, i);
            if (v.action ~= nil) then

                v.action(v.params);
            end
        end
    end
    if (actionEventId ~= nil) then
        for i, v in pairs(actionEventId) do
            self.TimeRegisterTable[v] = nil;
        end
    end
end

---检测自增的注册事件
function LuaTimeMgr:UpdateAutoIncrementEvent(now)
    local actionEventId = nil
    for i, v in pairs(self.TimeRegisterAutoIncrementTable) do
        if (v ~= nil and now >= v.time) then
            if (actionEventId == nil) then
                actionEventId = {}
            end
            table.insert(actionEventId, i);
            if (v.action ~= nil) then
                v.action(v.params);
            end
        end
    end
    if (actionEventId ~= nil) then
        for i, v in pairs(actionEventId) do
            self.TimeRegisterAutoIncrementTable[v] = nil;
        end
    end
end

---注册指定时间到点回调
---PS:当到达一个时间点之后的回调事件
---@param id LuaRegisterTimeFinishEvent 事件ID,相同ID的事件回调会互相覆盖(避免出现反复注册)
---@param time number 时间戳 到达这个时间的时候 会进行回调
---@param action funcition 到了时间会进行这个回调
---@param params all 回调参数
function LuaTimeMgr:RegisterTimeRespone(id, time, action, params)
    local respone = {}
    respone.time = time;
    respone.action = action;
    respone.params = params
    self.TimeRegisterTable[id] = respone
end

---移除指定回调
---@param id LuaRegisterTimeFinishEvent 事件ID,相同ID的事件回调会互相覆盖(避免出现反复注册)
function LuaTimeMgr:RemoveTimeRespone(id)
    self.TimeRegisterTable[id] = nil
end

---注册一个会自增的ID回调,他可以不断的进行相关的回调注册
---PS:当到达一个时间点之后的回调事件
---@param time number 时间戳 到达这个时间的时候 会进行回调
---@param action funcition 到了时间会进行这个回调
---@param params all 回调参数
---@return id number 自增事件ID  如果要移除 需要传入这个值
function LuaTimeMgr:RegisterAutoIncrementTimeRespone(time, action, params)
    local respone = {}
    respone.time = time;
    respone.action = action;
    respone.params = params
    self.AutoIncrementID = self.AutoIncrementID + 1

    self.TimeRegisterAutoIncrementTable[self.AutoIncrementID] = respone

    return self.AutoIncrementID
end

---移除自增回调
---需要传入注册时候返回的ID
function LuaTimeMgr:RemoveAutoIncrementTimeRespone(id)
    self.TimeRegisterAutoIncrementTable[id] = nil
end

---清理时间线事件
function LuaTimeMgr:Clear()
    self.TimeRegisterAutoIncrementTable = {}
    self.TimeRegisterTable = {}
end
--endregion

--region 各种类型的时间获取

--region 凌晨时间

---得到当前凌晨的时间戳
function LuaTimeMgr:GetNowDayWeeHoursTime()
    local dif = CS.CSServerTime.Instance.TotalMillisecond - self.LastGetNowDayWeeHoursTime;
    ---这里为了减少计算消耗,先判定下当前时间与上次时间是否相差至少60000毫秒
    if (self.NowDayWeeHoursTime == nil or self.NowDayWeeHoursTime == 0 or dif > 3000 or dif < -3000) then
        self.NowDayWeeHoursTime = nil
        self:UpdateNowDayWeeHoursTime()
        self.LastGetNowDayWeeHoursTime = CS.CSServerTime.Instance.TotalMillisecond
    end
    return self.NowDayWeeHoursTime
end

---更新当前当天凌晨时间戳(登入以及跨天的时候执行)
---有几个地方调用
---1.通过73022通用消息去更新当天的凌晨时间,这里是为了准确的更新时间,但是不排除服务器没有发包的情况(例如调时间)
---2.心跳包中检测与上次的时间是否相差一天,这里必定会调用,但是不一定准时准点,可能会相差一点点的时间
function LuaTimeMgr:UpdateNowDayWeeHoursTime(time, isServerNotice)
    ---发生了跨天事件
    if (self.NowDayWeeHoursTime == nil) then
        local now = CS.CSServerTime.Now
        local data = CS.System.DateTime(now.Year, now.Month, now.Day)
        self.NowDayWeeHoursTime = CS.CSServerTime.DateTimeToStampForMilli(data)
    elseif (isServerNotice) then
        --服务器通知跨天了(服务器的通知可能会存在几秒的误差,这里要进行判定)直接请求服务器时间
        --这里是为了确保心跳包传过来的时间就是下一天的世界,不然就算事件分发了,CSServerTime里面的时间还是错的,有毛用啊
        CS.CSNetwork.Instance:ReqHeartbeatMessage();
    elseif ((time - self.NowDayWeeHoursTime - 10000) > self.DayCostMillisecond) then
        local now = CS.CSServerTime.Now
        local data = CS.System.DateTime(now.Year, now.Month, now.Day)
        self.NowDayWeeHoursTime = CS.CSServerTime.DateTimeToStampForMilli(data)
        self:UpdateOpenServerTime();
        self:UpdateCombineServerTime();
        self.LastGetNowTime = CS.CSServerTime.Instance.TotalMillisecond
        self.NowTime = 0;
        ---分发零点事件
        luaEventManager.DoCallback(LuaCEvent.Common_ZeroEvent)
    end
end

--endregion

--region 当前时间

---现在时间(单位:分钟)
LuaTimeMgr.NowTime = 0

---得到当前时间(分钟)
function LuaTimeMgr:GetNowMinuteTime()
    local dif = CS.CSServerTime.Instance.TotalMillisecond - self.LastGetNowTime;
    --print("CS.CSServerTime.Instance.TotalMillisecond:"..tostring(CS.CSServerTime.Instance.TotalMillisecond).."     self.LastGetNowTime:"..tostring(self.LastGetNowTime).."     dif:"..tostring(dif))
    ---这里为了减少计算消耗,先判定下当前时间与上次时间是否相差至少60000毫秒
    if (self.NowTime == 0 or dif > 3000 or dif < -3000) then
        --当前服务器凌晨时间
        local TodayTimeStamp = self.NowDayWeeHoursTime
        --print("TodayTimeStamp:"..tostring(TodayTimeStamp))
        if TodayTimeStamp == nil then
            return 0
        end
        --当前服务器时间
        local nowTimeStamp = CS.CSServerTime.Instance.TotalMillisecond
        ---由于活动表里面的配置都是按照分钟来的,所以这里需要去计算出当前处于当天的第几分钟
        self.NowTime = math.floor((nowTimeStamp - TodayTimeStamp) / 60000)
        --print("nowTimeStamp:"..tostring(nowTimeStamp).."       TodayTimeStamp:"..tostring(TodayTimeStamp).."")
        ---这里设置获取的时间是为了获取到当前分钟的第一个毫秒,避免下次活动的时候误差
        self.LastGetNowTime = self.NowTime * 60000 + TodayTimeStamp
    end
    --print("self.NowTime:"..tostring(self.NowTime))
    return self.NowTime
end

---@public 获得当前服务器时间戳
---@return number
function LuaTimeMgr:GetServerNowTimeStamp()
    return CS.CSServerTime.Instance.TotalMillisecond;
end
--endregion

--region 开服时间
function LuaTimeMgr:GetOpenServerTime()
    --if (self.OpenServerTime == nil) then
    --    self:UpdateOpenServerTime()
    --end
    if(CS.CSScene.MainPlayerInfo ~= nil) then
        self.OpenServerTime = CS.CSScene.MainPlayerInfo.OpenServerTime
    end
    return self.OpenServerTime
end

function LuaTimeMgr:GetOpenServerDay(time)
    --if (self.OpenServerDay == nil) then
    --    self:UpdateOpenServerTime()
    --end
    if(CS.CSScene.MainPlayerInfo ~= nil) then
        self.OpenServerDay = CS.CSScene.MainPlayerInfo.ActualOpenDays
    end
    if (time ~= nil) then
        local dif = math.floor(time - self.NowDayWeeHoursTime) / self.DayCostMillisecond
        return self.OpenServerDay + dif
    end
    return self.OpenServerDay
end

---更新开服时间
function LuaTimeMgr:UpdateOpenServerTime()
    if(CS.CSScene.MainPlayerInfo ~= nil) then
        --先这样写  之后再整理相关的东西
        self.OpenServerTime = CS.CSScene.MainPlayerInfo.OpenServerTime
        self.OpenServerDay = CS.CSScene.MainPlayerInfo.ActualOpenDays
    end
end

---设置服务器时间
---@param OpenServerTime number 开服时间
---@param serverCurTime number 服务器当前时间
function LuaTimeMgr:SetServerTime(serverCurTime, OpenServerTime)
    self.OpenServerTime = OpenServerTime
    self.OpenServerDay = self:GetIntervalDay(serverCurTime, OpenServerTime) + 1
end
--endregion

--region 合服时间
function LuaTimeMgr:GetCombineServerTime()
    --if (self.CombineServerTime == nil or self.CombineServerTime == -1) then
    --    self:UpdateCombineServerTime()
    --end
    if(CS.CSScene.MainPlayerInfo ~= nil) then
        self.CombineServerTime = CS.CSScene.MainPlayerInfo.CombineServerTime
    end
    return self.CombineServerTime
end

function LuaTimeMgr:GetCombineServerDay(time)
    --if (self.CombineServerDay == nil or self.CombineServerDay == -1) then
    --    self:UpdateCombineServerTime()
    --end
    if(CS.CSScene.MainPlayerInfo ~= nil) then
        self.CombineServerDay = CS.CSScene.MainPlayerInfo.ActualCombineDays
    else
        return 0
    end
    if (self.CombineServerDay == 0) then
        return 0
    end
    if (time ~= nil) then
        local difDayTime = math.floor(time - self.NowDayWeeHoursTime) / self.DayCostMillisecond
        return self.CombineServerDay + difDayTime
    end
    return self.CombineServerDay
end

---更新合服时间
function LuaTimeMgr:UpdateCombineServerTime()
    if(CS.CSScene.MainPlayerInfo ~= nil) then
        self.CombineServerTime = CS.CSScene.MainPlayerInfo.CombineServerTime
        self.CombineServerDay = CS.CSScene.MainPlayerInfo.ActualCombineDays
    end
end

---设置服务器时间
---@param combineServerTime number 合服时间
---@param serverCurTime number 服务器当前时间
function LuaTimeMgr:SetCombineServerTime(serverCurTime, combineServerTime)
    combineServerTime = combineServerTime * 1000
    self.CombineServerTime = combineServerTime
    if (combineServerTime == 0) then
        self.CombineServerDay = 0;
    else
        self.CombineServerDay = self:GetIntervalDay(serverCurTime, combineServerTime) + 1
    end
end
--endregion

--region 联服(跨服)时间
---得到跨服的时间戳
---@return number 跨服时间戳
function LuaTimeMgr:GetKuaFuDay()
    return 0;
    --if(self.KuFuServerDay == nil) then
    --    self:UpdateKuFuServerTime()
    --end
    --return self.KuFuServerDay
end

function LuaTimeMgr:GetKuaFuTime()
    return 0;
    --if(self.KuFuServerTime == nil) then
    --    self:UpdateKuFuServerTime()
    --end
    --return self.KuFuServerTime
end

---更新跨服时间
function LuaTimeMgr:UpdateKuFuServerTime()
end
--endregion

--endregion

--region 时间计算

---@param time number 时间戳
---@return number 与当前相差多少天
function LuaTimeMgr:GetIntervalDay1(time)
    return (time - self.NowDayWeeHoursTime) / self.DayCostMillisecond
end

---得到day天之后的凌晨时间戳
---@param day number 天数
function LuaTimeMgr:GetAfterDayWeeHoursTimeTime(day)
    return self.NowDayWeeHoursTime + self.DayCostMillisecond * day;
end
--endregion

---@public 得到间隔天数
---@param firstTimeStamp number 时间戳1
---@param secondTimeStamp number 时间戳2
function LuaTimeMgr:GetIntervalDay(firstTimeStamp, secondTimeStamp)
    local intervalTimeStamp = (firstTimeStamp - secondTimeStamp);
    local intervalDay = math.floor(intervalTimeStamp / 1000 / 60 / 60 / 24);
    return intervalDay;
end

---返回指定时间戳所在的时间星期几 1234567
---@param time 毫秒
---@return number 1234567
function LuaTimeMgr:GetWeekDay(time)
    local DayOfWeek = Utility.EnumToInt(CS.CSServerTime.StampToDateTime(time).DayOfWeek)
    if (DayOfWeek == 0) then
        DayOfWeek = 7
    end
    return DayOfWeek
end

---获取剩余时间
---@param endTime number 结束时间时间戳
---@return number,number,number,number,number,number 年月日时分秒
function LuaTimeMgr:GetRemainTime(endTime)
    if endTime <= CS.CSServerTime.Instance.TotalMillisecond then
        return 0,0,0,0,0,0
    end
    local nowTimeDateTime = Utility.GetDateTimeByMillisecond(CS.CSServerTime.Instance.TotalMillisecond)
    local endTimeDateTime = Utility.GetDateTimeByMillisecond(endTime)
    return endTimeDateTime.Year - nowTimeDateTime.Year,endTimeDateTime.Month - nowTimeDateTime.Month,endTimeDateTime.Day - nowTimeDateTime.Day,endTimeDateTime.Hour - nowTimeDateTime.Hour,endTimeDateTime.Minute - nowTimeDateTime.Minute,endTimeDateTime.Second - endTimeDateTime.Second
end

---获取剩余时间描述1
---@param endTime number 结束时间时间戳
---@return string 描述内容（大于等于一天返回天时分，小于一天显示时分秒）
function LuaTimeMgr:GetRemainTimeDes1(endTime)
    local year,month,day,hour,minute,second = self:GetRemainTime(endTime)
    local totalDay = year * 365 + month * 30 + day
    if totalDay > 0 then
        return string.format("%d天%d小时%d分",totalDay,hour,minute)
    else
        return string.format("%d小时%d分%d秒",hour,minute,second)
    end
end

return LuaTimeMgr;