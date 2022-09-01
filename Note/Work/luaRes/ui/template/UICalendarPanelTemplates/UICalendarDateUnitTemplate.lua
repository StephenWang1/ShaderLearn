---@class UICalendarDateUnitTemplate 日历日期格子模板
local UICalendarDateUnitTemplate = {};

UICalendarDateUnitTemplate.mTimeStampUtc = nil;

--region Components

--function UICalendarDateUnitTemplate:GetArrow_GameObject()
--    if(self.mArrow_GameObject == nil) then
--        self.mArrow_GameObject = self:Get("arrow","GameObject");
--    end
--    return self.mArrow_GameObject;
--end

function UICalendarDateUnitTemplate:GetFirstRewardSign_GameObject()
    if (self.mFirstRewardSign_GameObject == nil) then
        self.mFirstRewardSign_GameObject = self:Get("FirstRewardSign", "GameObject");
    end
    return self.mFirstRewardSign_GameObject;
end

function UICalendarDateUnitTemplate:GetFirstRewardSign_UISprite()
    if (self.mFirstRewardSign_UISprite == nil) then
        self.mFirstRewardSign_UISprite = self:Get("FirstRewardSign", "Top_UISprite");
    end
    return self.mFirstRewardSign_UISprite;
end

function UICalendarDateUnitTemplate:GetToggle_UIToggle()
    if (self.mToggle_UIToggle == nil) then
        self.mToggle_UIToggle = self:Get("", "UIToggle");
    end
    return self.mToggle_UIToggle;
end

function UICalendarDateUnitTemplate:GetDate_Text()
    if (self.mTimeStampUtc_Text == nil) then
        self.mTimeStampUtc_Text = self:Get("day", "UILabel");
    end
    return self.mTimeStampUtc_Text;
end

function UICalendarDateUnitTemplate:GetFrame_UISprite()
    if (self.mFrame_UISprite == nil) then
        self.mFrame_UISprite = self:Get("frame", "UISprite");
    end
    return self.mFrame_UISprite;
end

function UICalendarDateUnitTemplate:GetMonth_Text()
    if (self.mMonth_Text == nil) then
        self.mMonth_Text = self:Get("Month", "UILabel");
    end
    return self.mMonth_Text;
end

function UICalendarDateUnitTemplate:GetDaysToday_Text()
    if (self.mDaysToday_Text == nil) then
        self.mDaysToday_Text = self:Get("Daily_Today", "UILabel");
    end
    return self.mDaysToday_Text;
end

function UICalendarDateUnitTemplate:GetDaysNormal_Text()
    if (self.mDaysNormal_Text == nil) then
        self.mDaysNormal_Text = self:Get("Daily_Normal", "UILabel");
    end
    return self.mDaysNormal_Text;
end

--endregion

UICalendarDateUnitTemplate.SelectTimeStampUtc = nil

function UICalendarDateUnitTemplate:Init()
    self:InitEvents();
end

function UICalendarDateUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self.go).onClick = function()
        self:OnClickUnit();
    end
end

function UICalendarDateUnitTemplate:OnClickUnit()
    self:Select();
    luaEventManager.DoCallback(LuaCEvent.Calendar_OnCalendarDateUnitClicked, self);
end

---@param calendarItem CalendarItem
function UICalendarDateUnitTemplate:UpdateUnit(calendarItems, timeStamp)
    self.mCalendarItems = calendarItems;
    self.mTimeStampUtc = timeStamp;
    self:UpdateUI();
end

function UICalendarDateUnitTemplate:UpdateUI()
    self:GetFirstRewardSign_GameObject():SetActive(self:HasFirstFirstReward());

    if (self.mTimeStampUtc ~= nil) then

        local intervalDay = math.floor((self.mTimeStampUtc - gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime()) / gameMgr:GetLuaTimeMgr().DayCostMillisecond)
        local isToday = intervalDay == 0

        self:UpdateIcon(false);
        self:GetDate_Text().color = isToday and CS.Utility_Lua.HexToColor("FFFFFF") or CS.Utility_Lua.HexToColor("878787");
        self:GetDate_Text().effectColor = isToday and CS.Utility_Lua.HexToColor("C39A4E") or CS.UnityEngine.Color.black;

        self:UpdateDate(intervalDay)
        self:UpdateIntervalDay(intervalDay)
    end
end

---更新日期(月/日)
---@param intervalDay number
function UICalendarDateUnitTemplate:UpdateDate(intervalDay)
    local data = CS.CSServerTime.StampToDateTime(self.mTimeStampUtc)
    --月份
    self:GetMonth_Text().text = intervalDay == 0 and "[bb994c]" .. data.Month .. "月[-]" or data.Month .. "月";
    --日期
    self:GetDaysNormal_Text().text = data.Day
    self:GetDaysToday_Text().text = data.Day

    self:GetDaysNormal_Text().gameObject:SetActive(intervalDay ~= 0)
    self:GetDaysToday_Text().gameObject:SetActive(intervalDay == 0)
end

---更新目标日期距离当天的天数差
---@param intervalDay number
function UICalendarDateUnitTemplate:UpdateIntervalDay(intervalDay)
    local intervalDayString = Utility.GetIntervalDayString(intervalDay);
    self:GetDate_Text().text = intervalDayString;

    if (intervalDay > 0) then
        self:GetMonth_Text().color = CS.UnityEngine.Color.gray;
        self:GetDaysNormal_Text().color = CS.UnityEngine.Color.gray;
        self:GetDaysToday_Text().color = CS.UnityEngine.Color.black;
        self:GetFrame_UISprite().color = CS.UnityEngine.Color.black;
    elseif (intervalDay < 0) then
        self:GetMonth_Text().color = CS.UnityEngine.Color.gray;
        self:GetDaysNormal_Text().color = CS.UnityEngine.Color.gray;
        self:GetDaysToday_Text().color = CS.UnityEngine.Color.black;
        self:GetFrame_UISprite().color = CS.UnityEngine.Color.white;
    else
        self:GetMonth_Text().color = CS.UnityEngine.Color.white;
        self:GetDaysNormal_Text().color = CS.UnityEngine.Color.white;
        self:GetDaysToday_Text().color = CS.UnityEngine.Color.white;
        self:GetFrame_UISprite().color = CS.UnityEngine.Color.white;
    end
end

function UICalendarDateUnitTemplate:UpdateIcon(isChoose)
    self:GetFrame_UISprite().spriteName = isChoose and "Calendar_open" or "Calendar_close";
end

function UICalendarDateUnitTemplate:Select()
    luaEventManager.DoCallback(LuaCEvent.Calendar_SelectDate, self)
    self:GetToggle_UIToggle().isChecked = true;
    self.SelectTimeStampUtc = self.mTimeStampUtc
    self:UpdateIcon(true);
end

function UICalendarDateUnitTemplate:UnSelect()
    self:UpdateIcon(false);
end

---是否有首次活动奖励 或者 是否是系统开启
function UICalendarDateUnitTemplate:HasFirstFirstReward()
    if (self.mCalendarItems ~= nil and #self.mCalendarItems > 0) then
        ---@param v CalendarItem
        for k,v in pairs(self.mCalendarItems) do
            local stateCode, activitySubData = v.ActivityItem:GetRunningState(v.dayTime);
            if(activitySubData == nil) then
                activitySubData = v.ActivityItem:GetTargetTimeActivity(v.dayTime);
            end
            local isFirst = gameMgr:GetPlayerDataMgr():GetActivityMgr():IsFirstSabacActivity(v);
            local isOver = stateCode ~= LuaActivityRunningState.AllOver;
            local isTime = v.dayTime >= gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime();
            if(isFirst and isOver and isTime) then
                self:GetFirstRewardSign_UISprite().spriteName = "Calendar_FirstRewardSign"
                return true;
            elseif(activitySubData ~= nil and activitySubData.Tbl:GetActivityType() == 29 and gameMgr:GetPlayerDataMgr():GetShareMapInfo():GetOpenKuaFuNum() == 0) then
                self:GetFirstRewardSign_UISprite().spriteName = "Calendar_LeagueOpenSign"
                return true
            end
        end
    end

    if(self:HasSystemOpen()) then
        self:GetFirstRewardSign_UISprite().spriteName = "Calendar_NewSystem"
        return true;
    end

    return false;
end

function UICalendarDateUnitTemplate:HasSystemOpen()
    if (self.mCalendarItems ~= nil and #self.mCalendarItems > 0) then
        ---@param v CalendarItem
        for k,v in pairs(self.mCalendarItems) do
            if(gameMgr:GetLuaActivityMgr():HasSystemOpen(v)) then
                return true;
            end
        end
    end
    return false;
end

return UICalendarDateUnitTemplate;