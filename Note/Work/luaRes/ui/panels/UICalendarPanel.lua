---@class UICalendarPanel:UIBase
local UICalendarPanel = {};

--region Components

function UICalendarPanel:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/DailyActivitiesPanel/window/Btn_Close", "GameObject")
    end
    return self.mBtnClose_GameObject;
end

function UICalendarPanel:GetNoActive_GameObject()
    if (self.mNoActive_GameObject == nil) then
        self.mNoActive_GameObject = self:GetCurComp("WidgetRoot/DailyActivitiesPanel/NoActive", "GameObject");
    end
    return self.mNoActive_GameObject;
end

function UICalendarPanel:GetTodayDate_Text()
    if (self.mTodayDate_Text == nil) then
        self.mTodayDate_Text = self:GetCurComp("WidgetRoot/DailyActivitiesPanel/CalendarInfo/daily", "UILabel");
    end
    return self.mTodayDate_Text;
end

---@return UICalendarDateViewTemplate
function UICalendarPanel:GetCalendarDateViewTemplate()
    if (self.mCalendarDateViewTemplate == nil) then
        self.mCalendarDateViewTemplate = templatemanager.GetNewTemplate(self:GetCurComp("WidgetRoot/DailyActivitiesPanel/ActivitiesEvents", "GameObject"), luaComponentTemplates.UICalendarDateViewTemplate, self);
    end
    return self.mCalendarDateViewTemplate;
end

---@return UICalendarViewTemplate
function UICalendarPanel:GetCalendarViewTemplate()
    if (self.mCalendarViewTemplate == nil) then
        self.mCalendarViewTemplate = templatemanager.GetNewTemplate(self:GetCurComp("WidgetRoot/DailyActivitiesPanel/ActivitiesList", "GameObject"), luaComponentTemplates.UICalendarViewTemplate, self);
    end
    return self.mCalendarViewTemplate;
end

--endregion

--region Init
function UICalendarPanel:Init()
    self:InitEvents();
end

function UICalendarPanel:InitEvents()
    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UICalendarPanel");
    end
end
--endregion

function UICalendarPanel:Show(customData)
    self:GetCalendarViewTemplate():UpdateView();
    self:GetCalendarDateViewTemplate():UpdateView();

    self:GetCalendarDateViewTemplate():SelectWithTimeStamp(gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime(), true)

    uiStaticParameter:SetIsEnterCalendarPanel(true);
    if customData then
        if customData.type then
            self:JumpTargetNextActivityType(customData.type)
        end
    end
end

---@param type LuaEnumDailyActivityType 活动类型
function UICalendarPanel:JumpTargetNextActivityType(type)
    local calendarItem = gameMgr:GetLuaActivityMgr():GetNextTargetCalendar(type)
    self:JumpTargetCalendar(calendarItem)
end

---@param calendarItem CalendarItem
function UICalendarPanel:JumpTargetCalendar(calendarItem)
    if calendarItem then
        self:GetCalendarViewTemplate():JumpTargetCalendar(calendarItem)
    end
end

return UICalendarPanel;