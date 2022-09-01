---@class UICalendarUnitTemplate
local UICalendarUnitTemplate = {};


--region Components

function UICalendarUnitTemplate:GetBtnEffect_GameObject()
    if (self.mBtnEffect_GameObject == nil) then
        self.mBtnEffect_GameObject = self:Get("btnEffect", "GameObject");
    end
    return self.mBtnEffect_GameObject;
end

function UICalendarUnitTemplate:GetNow_GameObject()
    if (self.mNow_GameObject == nil) then
        self.mNow_GameObject = self:Get("now", "GameObject");
    end
    return self.mNow_GameObject;
end

function UICalendarUnitTemplate:GetOver_GameObject()
    if (self.mOver_GameObject == nil) then
        self.mOver_GameObject = self:Get("over", "GameObject");
    end
    return self.mOver_GameObject;
end

function UICalendarUnitTemplate:GetOver_UILabel()
    if (self.mOver_UILabel == nil) then
        self.mOver_UILabel = self:Get("over", "Top_UILabel");
    end
    return self.mOver_UILabel;
end

function UICalendarUnitTemplate:GetDes_GameObject()
    if (self.mDes_GameObject == nil) then
        self.mDes_GameObject = self:Get("des", "GameObject");
    end
    return self.mDes_GameObject;
end

function UICalendarUnitTemplate:GetDes_UILabel()
    if (self.mDes_UILabel == nil) then
        self.mDes_UILabel = self:Get("des", "Top_UILabel");
    end
    return self.mDes_UILabel;
end

function UICalendarUnitTemplate:GetBtnGo_GameObject()
    if (self.mBtnGo_GameObject == nil) then
        self.mBtnGo_GameObject = self:Get("btn", "GameObject")
    end
    return self.mBtnGo_GameObject;
end

function UICalendarUnitTemplate:GetBtnGetGift_GameObject()
    if (self.mBtnGetGift_GameObject == nil) then
        self.mBtnGetGift_GameObject = self:Get("btnGetReward", "GameObject")
    end
    return self.mBtnGetGift_GameObject;
end

function UICalendarUnitTemplate:GetBtnDetails_GameObject()
    return self.go;
end

function UICalendarUnitTemplate:GetFirstRewardSign_GameObject()
    if (self.mFirstRewardSign_GameObject == nil) then
        self.mFirstRewardSign_GameObject = self:Get("FirstShabakeRewardText", "GameObject");
    end
    return self.mFirstRewardSign_GameObject;
end

function UICalendarUnitTemplate:GetTitle_GameObject()
    if(self.mTitle_GameObject == nil) then
        self.mTitle_GameObject = self:Get("Title","GameObject")
    end
    return self.mTitle_GameObject;
end

--function UICalendarUnitTemplate:GetIcon_UISprite()
--    if (self.mIcon_UISprite == nil) then
--        self.mIcon_UISprite = self:Get("icon", "UISprite")
--    end
--    return self.mIcon_UISprite;
--end

function UICalendarUnitTemplate:GetBackGround_UISprite()
    if (self.mBackGround_UISprite == nil) then
        self.mBackGround_UISprite = self:Get("bg", "UISprite");
    end
    return self.mBackGround_UISprite;
end

function UICalendarUnitTemplate:GetName_UISprite()
    if (self.mName_UISprite == nil) then
        self.mName_UISprite = self:Get("name", "UISprite");
    end
    return self.mName_UISprite;
end

function UICalendarUnitTemplate:GetLevelSeal_UISprite()
    if (self.mLevelSeal_UISprite == nil) then
        self.mLevelSeal_UISprite = self:Get("level/Sprite", "UISprite");
    end
    return self.mLevelSeal_UISprite;
end

function UICalendarUnitTemplate:GetTime_Text()
    if (self.mTime_Text == nil) then
        self.mTime_Text = self:Get("time", "UILabel");
    end
    return self.mTime_Text;
end

function UICalendarUnitTemplate:GetLevel_Text()
    if (self.mLevel_Text == nil) then
        self.mLevel_Text = self:Get("level", "UILabel");
    end
    return self.mLevel_Text;
end

---行会合并显示
function UICalendarUnitTemplate:GetUnionLabel_Sprite()
    if (self.mUnionLabel_Sprite == nil) then
        self.mUnionLabel_Sprite = self:Get("union", "UISprite");
    end
    return self.mUnionLabel_Sprite;
end

--function UICalendarUnitTemplate:GetName_Text()
--    if (self.mName_Text == nil) then
--        self.mName_Text = self:Get("name", "UILabel");
--    end
--    return self.mName_Text;
--end

function UICalendarUnitTemplate:GetState_Text()
    if (self.mState_Text == nil) then
        self.mState_Text = self:Get("state", "UILabel");
    end
    return self.mState_Text;
end

function UICalendarUnitTemplate:GetLevelSealDes_Text()
    if (self.mLevelSealDes_Text == nil) then
        self.mLevelSealDes_Text = self:Get("level", "UILabel");
    end
    return self.mLevelSealDes_Text;
end

function UICalendarUnitTemplate:GetLevelSealTimer()
    if (self.mLevelSealTimer == nil) then
        self.mLevelSealTimer = self:Get("Lvunlocktimer", "UITimer");
    end
    return self.mLevelSealTimer;
end

function UICalendarUnitTemplate:GetUITimer()
    if (self.mUITimer == nil) then
        self.mUITimer = self:Get("timer", "UITimer")
    end
    return self.mUITimer;
end

function UICalendarUnitTemplate:GetTextureLoader()
    if (self.mTextureLoader == nil) then
        self.mTextureLoader = self:Get("icon", "CSUIEffectLoad");
    end
    return self.mTextureLoader;
end

--endregion

---@type CalendarItem
UICalendarUnitTemplate.Data = nil;
---@type boolean 是否能开启(存在各种条件,如果已经为false了,那么没有必要再去判定时间了)
UICalendarUnitTemplate.IsCanOpen = nil;

function UICalendarUnitTemplate:Init()
    self:BindEvent()
end

function UICalendarUnitTemplate:BindEvent()
    CS.UIEventListener.Get(self:GetBtnGo_GameObject()).onClick = function(go)
        self:OnClickGoToActivity()
    end

    CS.UIEventListener.Get(self.go).onClick = function()
        self:OnClickBtnDetails();
    end

    CS.UIEventListener.Get(self:GetBtnGetGift_GameObject()).onClick = function()
        if(self.Data ~= nil) then
            -----@type LuaActivityItem
            --local activity = self.Data.ActivityItem;
            --local runState, ActivityItemSubInfo = activity:GetRunningState()
            --if(ActivityItemSubInfo == nil) then
            --    ActivityItemSubInfo = activity:GetLastActivity()
            --end
            --if(gameMgr:GetPlayerDataMgr():GetActivityMgr():GetCalendarGiftState(ActivityItemSubInfo.Tbl:GetId()) == 1) then
            --    networkRequest.ReqReceiveCalendarGift(ActivityItemSubInfo.Tbl:GetId());
            --end
            self:OnClickBtnDetails();
        end
    end
end
--region 历法活动的显示
---@param data CalendarItem
function UICalendarUnitTemplate:UpdateUnit(data)
    self.Data = data;
    self:UpdateUI();
end

function UICalendarUnitTemplate:UpdateUI()
    if(self.Data ~= nil) then
        if(self.Data.type == LuaEnumCalendarItemType.NormalActivity) then
            self:ShowNormalActivity(self.Data);
        end
    end
end

function UICalendarUnitTemplate:OnCalendarGiftChange()
    self:UpdateUI();
end

---@param data CalendarItem
function UICalendarUnitTemplate:ShowNormalActivity(data)
    ---@type LuaActivityItem
    local activity = data.ActivityItem;

    local runState, ActivityItemSubInfo = activity:GetRunningState(data.dayTime)

    --if(activity.Type == LuaEnumDailyActivityType.LevelLimit) then
    --    ---@param v LuaActivityItemSubInfo
    --    for k,v in pairs(activity.ActivityInfos) do
    --        if(v.Tbl:GetServiceTime().list:Contains(gameMgr:GetLuaTimeMgr():GetOpenServerDay(data.dayTime))) then
    --            ActivityItemSubInfo = v;
    --            break;
    --        end
    --    end
    --end

    if(ActivityItemSubInfo == nil) then
        ActivityItemSubInfo = activity:GetTargetTimeActivity(data.dayTime);
    end

    if(ActivityItemSubInfo == nil) then
        ActivityItemSubInfo = activity:GetLastActivity();
    end

    local dayDif = (data.dayTime - gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime()) / 86400000

    self:ShowCalendarBackgroundAndName(dayDif == 0, ActivityItemSubInfo.Tbl:GetNameIcon(), ActivityItemSubInfo.Tbl:GetBackGround())

    self:ShowCalendarTime(data.dayTime, dayDif, ActivityItemSubInfo.Tbl:GetStartTime())

    if(ActivityItemSubInfo.Tbl:GetActivityType() == 29) then
        self:ShowShareServer(ActivityItemSubInfo, data.dayTime);
    else
        self:ShowLevelCondition(ActivityItemSubInfo)
    end

    self:UpdateActivityState(runState, ActivityItemSubInfo);

    self:GetFirstRewardSign_GameObject():SetActive(gameMgr:GetLuaActivityMgr():IsFirstSabacActivity(data));
    self:GetTitle_GameObject():SetActive(gameMgr:GetLuaActivityMgr():HasSystemOpen(data));
end

---刷新历法背景图以及名称
function UICalendarUnitTemplate:ShowCalendarBackgroundAndName(todayIsOpen, name, background)
    self:GetName_UISprite().spriteName = name
    local textureName = todayIsOpen and background or background.."_1";

    self:GetTextureLoader():ChangeEffect(textureName);
end

---刷新历法开启时间
---@param day number 日期早上凌晨的时间戳
---@param dayDif number 距离今天的差值
---@param startTime number 当前的开启时间(单位分分钟)
function UICalendarUnitTemplate:ShowCalendarTime(day, dayDif, startTime)
    self:GetState_Text().text = "";
    local isLevelLimit = self.Data.ActivityItem.Type == LuaEnumDailyActivityType.LevelLimit;

    if(dayDif < 0) then
        local endStr = isLevelLimit and "已解封" or "已结束";
        self:GetTime_Text().text = luaEnumColorType.Gray .. endStr
        return;
    end

    local timeTxt = ""
    timeTxt = tostring(math.floor(startTime/60)).."点"
    local timeSecond = startTime % 60;
    if(timeSecond ~= 0) then
        timeTxt = timeTxt..tostring(timeSecond).."分"
    end
    timeTxt = timeTxt..(isLevelLimit and "解锁[-]" or "开启[-]");
    self:GetLevelSealTimer().gameObject:SetActive(false);
    local uiCountdown = CS.Utility_Lua.GetComponent(self:GetTime_Text().gameObject, "UICountdownLabel");
    if (uiCountdown == nil) then
        uiCountdown = self:GetTime_Text().gameObject:AddComponent(typeof(CS.UICountdownLabel));
    end
    uiCountdown:StopCountDown();
    ---等级封印
    if(isLevelLimit) then
        local getIntervalTime = function()
            local intervalTimeStamp = day + startTime * 60 * 1000 - gameMgr:GetLuaTimeMgr():GetServerNowTimeStamp();
            local dayTimeStamp = 24 * 60 * 60 * 1000;
            local hourTimeStamp = 60 * 60 * 1000;
            local minuteTimeStamp = 60 * 1000
            local remainTimeStamp = intervalTimeStamp % dayTimeStamp;
            local intervalDay = math.floor(intervalTimeStamp / dayTimeStamp);
            local remainHour = math.floor(remainTimeStamp / hourTimeStamp);
            local remainMinute = math.floor((remainTimeStamp % hourTimeStamp) / (60 * 1000));
            local remainSecond = math.floor(remainTimeStamp % minuteTimeStamp / 1000);
            return intervalTimeStamp, intervalDay, remainHour, remainMinute, remainSecond;
        end

        local intervalTimeStamp, intervalDay, remainHour, remainMinute, remainSecond = getIntervalTime();
        if(intervalTimeStamp > 0) then
            if(intervalDay > 0) then
                self:GetTime_Text().text = luaEnumColorType.Red.."解封时间  "..intervalDay.."天"..remainHour.."小时[-]"
            else
                if(remainHour <= 0) then
                    --self:GetTime_Text().text = luaEnumColorType.Red.."解封时间  "..remainMinute.."分钟"..remainSecond.."秒[-]";
                    --self:GetLevelSealTimer().gameObject:SetActive(true);
                    --self:GetLevelSealTimer():StartTimer(intervalTimeStamp, function()
                    --    local timeStamp, day, hour, minute, second = getIntervalTime();
                    --    self:GetTime_Text().text = luaEnumColorType.Red.."解封时间  "..minute.."分钟"..second.."秒[-]";
                    --end, function()
                    --    self:UpdateUI()
                    --end, nil);
                    uiCountdown:StartCountDown(nil, 8, day + startTime * 60 * 1000 , luaEnumColorType.Red.."解封时间  ", nil, nil, function()
                        self:UpdateUI()
                    end)
                else
                    self:GetTime_Text().text = luaEnumColorType.Red.."解封时间  "..remainHour.."小时"..remainMinute.."分钟[-]";
                end
            end
        end

        return;
    end

    if(dayDif == 0) then
        --当天开启
        self:GetTime_Text().text = luaEnumColorType.White .. timeTxt;;
    elseif(dayDif == 1) then
        self:GetTime_Text().text = luaEnumColorType.Gray .. "明天" .. timeTxt;
    elseif(dayDif == 2) then
        self:GetTime_Text().text = luaEnumColorType.Gray .. "后天" .. timeTxt;
    else
        self:GetTime_Text().text = luaEnumColorType.Gray .. CS.CSServerTime.StampToDateTime(day):ToString("M月d日") .. timeTxt;
    end
end

---@public 显示联服信息
---@param ActivityItemSubInfo LuaActivityItemSubInfo
function UICalendarUnitTemplate:ShowShareServer(timeStamp)
    self:GetState_Text().gameObject:SetActive(false);
    if(gameMgr:GetLuaActivityMgr() ~= nil) then
        local shareData = gameMgr:GetLuaActivityMgr():GetShareServerData(timeStamp);
        if(shareData ~= nil) then
            --local serverIds = {};
            local showText = "";
            local serverIdStrings = string.Split(shareData.shareServers, ",");
            if(serverIdStrings ~= nil) then
                local index = 0;
                for k,v in pairs(serverIdStrings) do
                    --table.insert(serverIds, math.floor(tonumber(v) / 1000));
                    local endStr = (index > 0 and index % 2 == 0) and "\n" or "  "
                    showText = showText .. "s"..math.floor(tonumber(v) / 1000)..endStr;
                    index = index + 1;
                end
            end
            self:GetState_Text().gameObject:SetActive(true);
            self:GetState_Text().text = luaEnumColorType.White..showText.."[-]";
        end
    end
end

---历法存在等级开启的条件
---@param ActivityItemSubInfo LuaActivityItemSubInfo
function UICalendarUnitTemplate:ShowLevelCondition(ActivityItemSubInfo)
    local isToday = self.Data.dayTime == gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime();
    self.IsCanOpen = true
    self:GetState_Text().gameObject:SetActive(false);
    self:GetLevel_Text().text = "";
    local id = ActivityItemSubInfo.Tbl:GetCondition();
    local color = isToday and CS.UnityEngine.Color.white or CS.UnityEngine.Color.black;
    self:GetLevel_Text().color = color
    self:GetLevelSeal_UISprite().color = color;
    self:GetLevelSeal_UISprite().gameObject:SetActive(ActivityItemSubInfo.Tbl:GetActivityType() == LuaEnumDailyActivityType.LevelLimit);
    if(ActivityItemSubInfo.Tbl:GetActivityType() == LuaEnumDailyActivityType.LevelLimit) then
        --print("等级封印"..ActivityItemSubInfo.Tbl:GetId());
        self:GetLevel_Text().text = ActivityItemSubInfo.Tbl:GetParam();
    else
        if (id ~= nil and id ~= 0) then
            if (not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(id)) then
                local isFindCondition, conditionTable = CS.Cfg_ConditionManager.Instance:TryGetValue(id)
                if (isFindCondition) then
                    if (conditionTable.conditionType == 1 and conditionTable.conditionParam.list ~= nil and conditionTable.conditionParam.list.Count > 0) then
                        local level = conditionTable.conditionParam.list[0];
                        if(CS.CSScene.MainPlayerInfo.Level <= level) then
                            self.IsCanOpen = false
                            self:GetState_Text().gameObject:SetActive(true);
                            self:GetState_Text().text = luaEnumColorType.Red1..level .. "级开启[-]";
                        end
                    end
                end
            end
        end
    end

end

---更新历法的活动状态
---@param runState LuaActivityRunningState 是否能进行开启活动
---@param ActivityItemSubInfo LuaActivityItemSubInfo
function UICalendarUnitTemplate:UpdateActivityState(runState, ActivityItemSubInfo)

    ---未达到这个日期
    local dateNotReached = self.Data.dayTime > gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime();

    local isToday = self.Data.dayTime == gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime();
    local isBefore = self.Data.dayTime < gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime();

    self:GetBtnGetGift_GameObject():SetActive(false);

    if(isBefore) then
        --已经过去了
        self:ProcessBeforeDay(runState, ActivityItemSubInfo)
    elseif(isToday == true) then
        self:ProcessToday(runState, ActivityItemSubInfo)
    elseif(dateNotReached) then
        self:ProcessOverDayActivity()
    end

end

--region 处理已经过期的活动
---处理已经过日子的活动
---@param runState LuaActivityRunningState 是否能进行开启活动
---@param ActivityItemSubInfo LuaActivityItemSubInfo
function UICalendarUnitTemplate:ProcessBeforeDay(runState, ActivityItemSubInfo)
    local isCalendarGift = ActivityItemSubInfo.Tbl:GetHaveGift() == nil and false or ActivityItemSubInfo.Tbl:GetHaveGift() == 1;
    local hasReward = ActivityItemSubInfo.Tbl:GetRewardShow() ~= nil and ActivityItemSubInfo.Tbl:GetRewardShow() ~= "";
    local canGetCalendarGift = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetCalendarGiftState(ActivityItemSubInfo.Tbl:GetId()) == 1 and hasReward;
    local isLevelLimit = ActivityItemSubInfo.Tbl:GetActivityType() == LuaEnumDailyActivityType.LevelLimit;
    local isShareServer = ActivityItemSubInfo.Tbl:GetActivityType() == LuaEnumDailyActivityType.ShareServer;
    self:GetOver_UILabel().text = isCalendarGift and "已解锁" or (isLevelLimit and "已解封" or (isShareServer and "已开启" or "已结束"));
    ---结束文本
    if(isCalendarGift) then
        self:GetOver_GameObject():SetActive(canGetCalendarGift == false);
    else
        self:GetOver_GameObject():SetActive(true);
    end

    self:GetBtnGetGift_GameObject():SetActive(canGetCalendarGift);

    self:GetBtnGo_GameObject().gameObject:SetActive(false)
    self:GetTime_Text().gameObject:SetActive(false)
end
--endregion

--region 处理当日的活动
---@param runState LuaActivityRunningState 是否能进行开启活动
---@param ActivityItemSubInfo LuaActivityItemSubInfo
function UICalendarUnitTemplate:ProcessToday(runState, ActivityItemSubInfo)
    local hasReward = ActivityItemSubInfo.Tbl:GetRewardShow() ~= nil and ActivityItemSubInfo.Tbl:GetRewardShow() ~= "";
    local isCalendarGift = ActivityItemSubInfo.Tbl:GetHaveGift() == nil and false or ActivityItemSubInfo.Tbl:GetHaveGift() == 1;
    local canGetCalendarGift = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetCalendarGiftState(ActivityItemSubInfo.Tbl:GetId()) == 1 and hasReward;
    local isLevelLimit = ActivityItemSubInfo.Tbl:GetActivityType() == LuaEnumDailyActivityType.LevelLimit;
    local isShareServer = ActivityItemSubInfo.Tbl:GetActivityType() == LuaEnumDailyActivityType.ShareServer;
    self:GetOver_UILabel().text = isCalendarGift and "已解锁" or (isLevelLimit and "已解封" or (isShareServer and "已开启" or "已结束"));
    
    ---由于活动表里面的配置都是按照分钟来的,所以这里需要去计算出当前处于当天的第几分钟
    local time = gameMgr:GetLuaTimeMgr():GetNowMinuteTime()

    if(ActivityItemSubInfo:IsInOpenTime(time)) then
        self:ProcessRunningActivity(runState, ActivityItemSubInfo)
    elseif(ActivityItemSubInfo:GetIsOver(time)) then
        self:GetBtnGetGift_GameObject():SetActive(canGetCalendarGift);
        self:GetOver_GameObject():SetActive(true);
        if(canGetCalendarGift) then
            self:GetOver_GameObject():SetActive(false);
        end
        self:GetBtnGo_GameObject().gameObject:SetActive(false)
        self:GetTime_Text().gameObject:SetActive(false)
    else
        self:GetBtnGetGift_GameObject():SetActive(canGetCalendarGift);
        local isEnd = not (runState == LuaActivityRunningState.IsRunning or runState == LuaActivityRunningState.NoOpen or runState == LuaActivityRunningState.Pause)
        self:GetOver_GameObject():SetActive(isEnd);

        self:GetBtnGo_GameObject().gameObject:SetActive(false)
        self:GetTime_Text().gameObject:SetActive(not isEnd);
    end
end

---@param runState LuaActivityRunningState 是否能进行开启活动
---@param ActivityItemSubInfo LuaActivityItemSubInfo
function UICalendarUnitTemplate:ProcessBeforeRunning(runState, ActivityItemSubInfo)
    local isCalendarGift = ActivityItemSubInfo.Tbl:GetHaveGift() == nil and false or ActivityItemSubInfo.Tbl:GetHaveGift() == 1;
    local hasReward = ActivityItemSubInfo.Tbl:GetRewardShow() ~= nil and ActivityItemSubInfo.Tbl:GetRewardShow() ~= "";
    local canGetCalendarGift = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetCalendarGiftState(ActivityItemSubInfo.Tbl:GetId()) == 1 and hasReward;
    local isLevelLimit = ActivityItemSubInfo.Tbl:GetActivityType() == LuaEnumDailyActivityType.LevelLimit;
    local isShareServer = ActivityItemSubInfo.Tbl:GetActivityType() == LuaEnumDailyActivityType.ShareServer;
    self:GetOver_UILabel().text = isCalendarGift and "已解锁" or (isLevelLimit and "已解封" or (isShareServer and "已开启" or "已结束"));

    self:GetBtnGetGift_GameObject():SetActive(false);
    self:GetBtnGetGift_GameObject():SetActive(false);
    self:GetOver_GameObject():SetActive(false);
    self:GetBtnGo_GameObject().gameObject:SetActive(false)
    self:GetTime_Text().gameObject:SetActive(true)
end

---@param runState LuaActivityRunningState 是否能进行开启活动
---@param ActivityItemSubInfo LuaActivityItemSubInfo
function UICalendarUnitTemplate:ProcessRunningActivity(runState, ActivityItemSubInfo)
    local hasReward = ActivityItemSubInfo.Tbl:GetRewardShow() ~= nil and ActivityItemSubInfo.Tbl:GetRewardShow() ~= "";
    local isCalendarGift = ActivityItemSubInfo.Tbl:GetHaveGift() == nil and false or ActivityItemSubInfo.Tbl:GetHaveGift() == 1;
    local canGetCalendarGift = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetCalendarGiftState(ActivityItemSubInfo.Tbl:GetId()) == 1 and hasReward;
    local isLevelLimit = ActivityItemSubInfo.Tbl:GetActivityType() == LuaEnumDailyActivityType.LevelLimit;
    local isShareServer = ActivityItemSubInfo.Tbl:GetActivityType() == LuaEnumDailyActivityType.ShareServer;
    self:GetOver_UILabel().text = isCalendarGift and "已解锁" or (isLevelLimit and "已解封" or (isShareServer and "已开启" or "已结束"));

    if(isCalendarGift) then
        --礼包没有前往按钮
        self:GetBtnGo_GameObject().gameObject:SetActive(false)

        if(canGetCalendarGift and runState ~= LuaActivityRunningState.NoOpen) then
            self:GetBtnGetGift_GameObject():SetActive(true);
        else
            self:GetOver_GameObject():SetActive(true);
            self:GetBtnGetGift_GameObject():SetActive(false);
        end
    else
        self:GetBtnGetGift_GameObject():SetActive(false);
        self:GetOver_GameObject():SetActive(runState == LuaActivityRunningState.EarlyTermination or runState == LuaActivityRunningState.AllOver);
        --if(self.Data.ActivityItem.Type == 44) then
        --    print("runState:"..runState);
        --end
        self:GetTime_Text().gameObject:SetActive(false)
        self:GetBtnGo_GameObject().gameObject:SetActive(runState == LuaActivityRunningState.IsRunning)
    end
    self:GetTime_Text().gameObject:SetActive(false)
end

---@param runState LuaActivityRunningState 是否能进行开启活动
---@param ActivityItemSubInfo LuaActivityItemSubInfo
function UICalendarUnitTemplate:ProcessOverActivity(runState, ActivityItemSubInfo)
    local isCalendarGift = ActivityItemSubInfo.Tbl:GetHaveGift() == nil and false or ActivityItemSubInfo.Tbl:GetHaveGift() == 1;
    local hasReward = ActivityItemSubInfo.Tbl:GetRewardShow() ~= nil and ActivityItemSubInfo.Tbl:GetRewardShow() ~= "";
    local canGetCalendarGift = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetCalendarGiftState(ActivityItemSubInfo.Tbl:GetId()) == 1 and hasReward;
    local isLevelLimit = ActivityItemSubInfo.Tbl:GetActivityType() == LuaEnumDailyActivityType.LevelLimit;
    local isShareServer = ActivityItemSubInfo.Tbl:GetActivityType() == LuaEnumDailyActivityType.ShareServer;
    self:GetOver_UILabel().text = isCalendarGift and "已解锁" or (isLevelLimit and "已解封" or (isShareServer and "已开启" or "已结束"));
    ---结束文本
    if(isCalendarGift) then
        self:GetOver_GameObject():SetActive(canGetCalendarGift == false);
    else
        self:GetOver_GameObject():SetActive(true);
    end

    self:GetBtnGetGift_GameObject():SetActive(canGetCalendarGift);

    self:GetBtnGo_GameObject().gameObject:SetActive(false)
    self:GetTime_Text().gameObject:SetActive(false)
end

--endregion

--region 处理未来的活动
function UICalendarUnitTemplate:ProcessOverDayActivity()
    self:GetBtnGetGift_GameObject():SetActive(false);
    self:GetBtnGetGift_GameObject():SetActive(false);
    self:GetOver_GameObject():SetActive(false);
    self:GetBtnGo_GameObject().gameObject:SetActive(false)
    self:GetTime_Text().gameObject:SetActive(true)
end

--endregion

--region 历法的点击之后的处理

function UICalendarUnitTemplate:OnClickBtnDetails()
    if(self.Data ~= nil) then
        ---@type LuaActivityItem
        local activity = self.Data.ActivityItem;
        ---@type LuaActivityItemSubInfo
        local ActivityItemSubInfo = activity:GetTargetTimeActivity(self.Data.dayTime);
        if(ActivityItemSubInfo == nil) then
            ActivityItemSubInfo = activity:GetLastActivity()
        end
        if(ActivityItemSubInfo ~= nil) then
            local panelName = ActivityItemSubInfo.Tbl:GetButtonType();
            uimanager:CreatePanel(panelName, nil, { calendarItem = self.Data });
        end
    end

    --if (self.mCalendarVO ~= nil) then
    --    local panelName = self.mCalendarVO.tableData.buttonType;
    --    uimanager:CreatePanel(panelName, nil, { calendarVO = self.mCalendarVO });
    --end
end

---历法前往按钮
function UICalendarUnitTemplate:OnClickGoToActivity()
    local isCloseCalendar = false;
    if(self.Data.type == LuaEnumCalendarItemType.NormalActivity) then
        isCloseCalendar = self:OnProcessNormalActivity(self.Data.ActivityItem)
    end
end

--region 普通活动点击处理

---处理历法内的普通活动
---@param activity LuaActivityItem
function UICalendarUnitTemplate:OnProcessNormalActivity(activity)

    local runState, ActivityItemSubInfo = activity:GetRunningState()

    if(runState == LuaActivityRunningState.AllOver) then
        return
    end
    if self:NotJoinCalendarTip(ActivityItemSubInfo.Tbl) then
        return
    end

    local isContinue = true
    local isClosePanel = true;
    if(activity.Type == LuaEnumDailyActivityType.GuildEscort) then
        --行会押镖
        isContinue, isClosePanel = self:OnProcessGuildEscort(activity, ActivityItemSubInfo)
    elseif(activity.Type == LuaEnumDailyActivityType.GuildBoss) then
        --行会boss
        isContinue, isClosePanel = self:OnProcessGuildBoss(activity, ActivityItemSubInfo)
    elseif(activity.Type == LuaEnumDailyActivityType.HJMiGong) then
        --幻境迷宫
        isContinue, isClosePanel = self:OnProcessHJMiGong(activity, ActivityItemSubInfo)
    elseif(activity.Type == LuaEnumDailyActivityType.DemonsComing) then
        --天魔降临
        isContinue = true
        isClosePanel = false
    end

    if(isContinue == true) then
        if(ActivityItemSubInfo ~= nil) then
            local type, param = activity:GetJumpParam()
            self:OnJumpActivity(type, param)
        end
    end

    if(isClosePanel == true) then
        uimanager:ClosePanel("UICalendarPanel");
    end
end

--region 通用处理

---正常跳转
---@param type number 跳转类型
---@param param number 跳转参数
function UICalendarUnitTemplate:OnJumpActivity(type, param)
    if (type == 1) then
        --点击后直接传送到目标地图坐标
        if (param ~= nil) then
            local isFind, deliverTable = CS.Cfg_DeliverTableManager.Instance:TryGetValue(param);
            if (isFind) then
                networkRequest.ReqDeliverByConfig(param)
            else
                CS.UnityEngine.Debug.LogError("没有在传送表DeliverTable中找到对应ID:"..tonumber(param).."  看看哪个策划又双叒叕填错了")
            end
        end
    elseif (type == 2) then
        --点击关闭历法界面，寻路到对应npc，然后打开npc面板
        local res = CS.CSScene.MainPlayerInfo.AsyncOperationController.CalendarFindNpcOperation:DoOperation(param);
        if CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(res) < 0 then
            CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:TryPauseOperation(function()
                self:OnJumpActivity(type, param);
                uimanager:ClosePanel("UICalendarPanel");
            end)
            return
        end
    elseif (type == 3) then
        --上次去过的主城的npcid
        local mapNpcId = CS.CSScene.MainPlayerInfo.MapInfoV2:GetLastMainCityMapNpcId(param);
        mapNpcId = mapNpcId == 0 and 341 or mapNpcId;
        local res = CS.CSScene.MainPlayerInfo.AsyncOperationController.CalendarFindNpcOperation:DoOperation(mapNpcId);
        if CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(res) < 0 then
            CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:TryPauseOperation(function()
                self:OnJumpActivity(type, param);
                uimanager:ClosePanel("UICalendarPanel");
            end)
            return
        end
    elseif (type == 4) then
        ---天魔降临跳转时特殊处理传参
        if(self.Data.ActivityItem.Type == LuaEnumDailyActivityType.DemonsComing) then
            uiTransferManager:TransferToPanel(param,{ calendarItem = self.Data })
        else
            uiTransferManager:TransferToPanel(param)
        end
        
    end
end

---达不到参加历法条件提示
---@param tbl TABLE.cfg_daily_activity_time
function UICalendarUnitTemplate:NotJoinCalendarTip(tbl)
    --if(tbl ~= nil and tbl:GetCondition() ~= nil and tbl:GetCondition() ~= 0) then
    --    local conditionId = tbl:GetCondition();
    --    if (not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionId)) then
    --        local isFind1, bubbleTable = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(262)
    --        if isFind1 then
    --            local isFind2, conditionTable = CS.Cfg_ConditionManager.Instance:TryGetValue(conditionId);
    --            if (isFind2) then
    --                if (conditionTable.conditionParam ~= nil and conditionTable.conditionParam.list.Count > 0) then
    --                    local des = string.format(bubbleTable.content, conditionTable.conditionParam.list[0]);
    --                    Utility.ShowPopoTips(self:GetBtnGo_GameObject(), des, 262, "UICalendarPanel");
    --                    return true
    --                end
    --            end
    --        end
    --    end
    --end
    --return false
    local noJoin, des = gameMgr:GetLuaActivityMgr():NotJoinCalendarTip(tbl);
    if(noJoin and des ~= nil) then
        Utility.ShowPopoTips(self:GetBtnGo_GameObject(), des, 262, "UICalendarPanel");
        return true;
    end
    return false;
end

--endregion

--region 各各活动的特殊处理

---行会押镖
---@param activity LuaActivityItem
---@param activityItemSubInfo LuaActivityItemSubInfo 当前开启的活动
---@return boolean,boolean 是否继续执行通用逻辑,是否关闭界面(只有当第一个为true的时候才会生效)
function UICalendarUnitTemplate:OnProcessGuildEscort(activity, activityItemSubInfo)
    -----@type CSMainPlayerInfo
    --local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    --if mainPlayerInfo then
    --    local UnionInfo = mainPlayerInfo.UnionInfoV2
    --    if UnionInfo and UnionInfo.UnionID == 0 then
    --        local go = self:GetBtnGo_GameObject()
    --        Utility.ShowPopoTips(go, nil, 134)
    --        return false, false
    --    end
    --end
    ----请求加入帮会押镖活动
    --Utility.ReqJoinUnionDartCarActivity(self:GetBtnGo_GameObject())
    --return true
    return gameMgr:GetLuaActivityMgr():TryGoToGuildEscort(self:GetBtnGo_GameObject(), activity, activityItemSubInfo);
end

---行会首领
---@param activity LuaActivityItem
---@param activityItemSubInfo LuaActivityItemSubInfo 当前开启的活动
---@return boolean,boolean 是否继续执行通用逻辑,是否关闭界面(只有当第一个为true的时候才会生效)
function UICalendarUnitTemplate:OnProcessGuildBoss(activity, activityItemSubInfo)
    -----@type CSMainPlayerInfo
    --local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    --if mainPlayerInfo then
    --    local UnionInfo = mainPlayerInfo.UnionInfoV2
    --    if UnionInfo and UnionInfo.UnionID == 0 then
    --        Utility.ShowUnionPush()
    --        return false, false
    --    end
    --end
    --return true
    return gameMgr:GetLuaActivityMgr():TryGoToGuildBoss(self:GetBtnGo_GameObject(), activity, activityItemSubInfo);
end


---幻境迷宫
---@param activity LuaActivityItem
---@param activityItemSubInfo LuaActivityItemSubInfo 当前开启的活动
---@return boolean,boolean 是否继续执行通用逻辑,是否关闭界面(只有当第一个为true的时候才会生效)
function UICalendarUnitTemplate:OnProcessHJMiGong(activity, activityItemSubInfo)
    --networkRequest.ReqDeliverByConfig(activityItemSubInfo.Tbl:GetDeliverId())
    --return true, true
    return gameMgr:GetLuaActivityMgr():TryGoToHJMiGong(self:GetBtnGo_GameObject(),activity, activityItemSubInfo);
end

--endregion

--endregion



--endregion

return UICalendarUnitTemplate;