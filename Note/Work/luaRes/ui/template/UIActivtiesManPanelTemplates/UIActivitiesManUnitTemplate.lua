---@class UIActivitiesManUnitTemplate
local UIActivitiesManUnitTemplate = {};

UIActivitiesManUnitTemplate.mCalendarVo = nil;

---@type CalendarItem
UIActivitiesManUnitTemplate.mCalendarItem = nil;

--region Components

function UIActivitiesManUnitTemplate:GetChoose_GameObject()
    if(self.mChoose_GameObject == nil) then
        self.mChoose_GameObject = self:Get("choose","GameObject");
    end
    return self.mChoose_GameObject;
end

function UIActivitiesManUnitTemplate:GetName_Text()
    if(self.mName_Text == nil) then
        self.mName_Text = self:Get("name","UILabel");
    end
    return self.mName_Text;
end

function UIActivitiesManUnitTemplate:GetTips_Text()
    if(self.mTips_Text == nil) then
        self.mTips_Text = self:Get("tips","UILabel");
    end
    return self.mTips_Text;
end

function UIActivitiesManUnitTemplate:GetBackGround_UISprite()
    if(self.mBackGround_UISprite == nil) then
        self.mBackGround_UISprite = self:Get("frame","UISprite");
    end
    return self.mBackGround_UISprite;
end

---@return LuaActivityItemSubInfo
function UIActivitiesManUnitTemplate:GetActivitySubData()
    if(self.mCalendarItem ~= nil) then
        local activityItem = self.mCalendarItem.ActivityItem;
        local state, activitySubData = activityItem:GetRunningState();
        if(self.mCalendarItem.dayTime ~= gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime()) then
            state = LuaActivityRunningState.NoOpen
        end
        if(activitySubData == nil) then
            activitySubData = activityItem:GetLastActivity();
        end
        return state, activitySubData;
    end
    return nil;
end

function UIActivitiesManUnitTemplate:GetActivityCalendarItem()
    return self.mCalendarItem;
end

--endregion

--region Method

--region CallFunction

function UIActivitiesManUnitTemplate:OnClickSelf()
    if(self.mCalendarItem ~= nil) then
        local state, activitySubData = self:GetActivitySubData();
        ---@type TABLE.cfg_daily_activity_time
        local tbl = activitySubData.Tbl;
        local panelNameAndParams = string.Split(tbl:GetPanelNameAndParams(), "#");
        if(panelNameAndParams ~= nil) then
            local panelName = panelNameAndParams[1];
            if(panelName ~= nil) then
                --table.remove(panelNameAndParams, 1);
                --local params = {};
                --for k,v in pairs(panelNameAndParams) do
                --    table.insert(params, tonumber(v));
                --end
                --if(#params > 0) then
                --    uimanager:CreatePanel(panelName, nil, table.unpack(params));
                --else
                --    uimanager:CreatePanel(panelName, nil, nil);
                --end
                uimanager:CreatePanel(panelName, nil, {activityItem = self.mCalendarItem});
            end
        end
    end
end

--endregion

--region Public

function UIActivitiesManUnitTemplate:UpdateUnit(calendarItem, chooseCallBack)
    --self.mCalendarVo = calendarVo;
    self.mCalendarItem = calendarItem;
    self.mChooseCallBack = chooseCallBack;
    self:UpdateUI();
end

function UIActivitiesManUnitTemplate:UpdateUI()
    if(self.mCalendarItem ~= nil) then
        ---@type LuaActivityItemSubInfo
        local stateCode, activitySubData = self:GetActivitySubData();
        if(activitySubData ~= nil) then
            ---@type TABLE.cfg_daily_activity_time
            local tbl = activitySubData.Tbl;
            self:GetName_Text().text = tbl:GetName()
            self:GetBackGround_UISprite().spriteName = tbl:GetBgName();
            if(stateCode == LuaActivityRunningState.IsRunning) then
                self:GetTips_Text().text = luaEnumColorType.Green.."正在进行[-]";
                self:GetBackGround_UISprite().color = CS.UnityEngine.Color.white;
            else
                --local intervalDay = CS.CSScene.MainPlayerInfo.CalendarInfoV2:GetIntervalDay(self.mCalendarVo.timeStampUtc);
                --local hourString = self.mCalendarVo:GetStartHour().."点";
                --local minuteString = self.mCalendarVo:GetStartMinute() == 0 and "" or self.mCalendarVo:GetStartMinute().."分";
                --self:GetTips_Text().text = luaEnumColorType.Gray..Utility.GetIntervalDayString(intervalDay)..hourString..minuteString;
                --self:GetBackGround_UISprite().color = CS.UnityEngine.Color.black;
                local intervalDay = gameMgr:GetLuaTimeMgr():GetIntervalDay(self.mCalendarItem.dayTime , gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime());
                local hourString = activitySubData:GetStartHour().."点";
                local minuteString = activitySubData:GetStartMinute() == 0 and "" or activitySubData:GetStartMinute().."分";
                self:GetTips_Text().text = luaEnumColorType.Gray..Utility.GetIntervalDayString(intervalDay)..hourString..minuteString;
                self:GetBackGround_UISprite().color = CS.UnityEngine.Color.black;
            --elseif(stateCode == LuaActivityRunningState.AllOver) then
            --    self:GetTips_Text().text = luaEnumColorType.Gray.."已结束[-]";
            --    self:GetBackGround_UISprite().color = CS.UnityEngine.Color.black;
            end
        end
    end
end

function UIActivitiesManUnitTemplate:OnSelect()
    self:OnClickSelf();
    self:GetChoose_GameObject():SetActive(true);
    if(self.mChooseCallBack ~= nil) then
        self.mChooseCallBack(self);
    end
end

function UIActivitiesManUnitTemplate:UnSelect()
    self:GetChoose_GameObject():SetActive(false);
end

--endregion

--region Private

function UIActivitiesManUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self.go).onClick = function()
        self:OnSelect();
    end
end

function UIActivitiesManUnitTemplate:RemoveEvents()

end

--endregion

--endregion

function UIActivitiesManUnitTemplate:Init()
    self:InitEvents();
end

function UIActivitiesManUnitTemplate:OnDestroy()
    self:RemoveEvents();
end

return UIActivitiesManUnitTemplate;
