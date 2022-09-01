---@class UIActivitiesDesShaBaKPanel
local UIActivitiesDesShaBaKPanel = {};

---@type UIActivitiesDesShaBaKPanel
local this = nil;

---@type LuaActivityItemSubInfo
UIActivitiesDesShaBaKPanel.mActivitySubData = nil;

---@type LuaActivityItem
UIActivitiesDesShaBaKPanel.mActivity = nil;

---@type CalendarItem
UIActivitiesDesShaBaKPanel.mCalendarItem = nil;

--region Components

function UIActivitiesDesShaBaKPanel:GetBtnClose_GameObject()
    if(this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/ActivitiesDesPanel/window/Btn_Close","GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UIActivitiesDesShaBaKPanel:GetBtnLast_GameObject()
    if(this.mBtnLast_GameObject == nil) then
        this.mBtnLast_GameObject = this:GetCurComp("WidgetRoot/ActivitiesDesPanel/events/LastBtn","GameObject");
    end
    return this.mBtnLast_GameObject;
end

---@return UIActivitiesShaBaKDesViewTemplate
function UIActivitiesDesShaBaKPanel:GetActivitiesViewTemplate()
    if(this.mActivitiesViewTemplate == nil) then
        this.mActivitiesViewTemplate = templatemanager.GetNewTemplate(this:GetCurComp("WidgetRoot/ActivitiesDesPanel/view","GameObject"), luaComponentTemplates.UIActivitiesShaBaKDesViewTemplate);
    end
    return this.mActivitiesViewTemplate;
end

--function UIActivitiesDesShaBaKPanel:GetAwardGridContainer()
--    if(this.mAwardGridContainer == nil) then
--        this.mAwardGridContainer = this:GetCurComp("","");
--    end
--end

function UIActivitiesDesShaBaKPanel:GetUITable()
    if(this.mUITable == nil) then
        this.mUITable = this:GetCurComp("WidgetRoot/ActivitiesDesPanel/view/ScrollView/root/Grid","UITable");
        this.mUITable.IsDealy = true;
    end
    return this.mUITable;
end

---@return LuaActivityItemSubInfo
function UIActivitiesDesShaBaKPanel:GetActivitySubData()
    local state;
    if(this.mActivitySubData == nil) then
        if(this.mActivity ~= nil) then
            state, this.mActivitySubData = this.mActivity:GetRunningState();
            if(this.mActivitySubData == nil) then
                this.mActivitySubData = this.mActivity:GetLastActivity();
            end
        end
    end
    return state, this.mActivitySubData;
end


--endregion

--region Method

--region Private

function UIActivitiesDesShaBaKPanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIActivitiesDesShaBaKPanel");
    end

    CS.UIEventListener.Get(this:GetBtnLast_GameObject()).onClick = function()
        uimanager:ClosePanel("UIActivitiesDesShaBaKPanel");
        uimanager:ClosePanel("UICalendarPanel");
        local mapNpcId = CS.CSScene.MainPlayerInfo.MapInfoV2:GetLastMainCityMapNpcId(tonumber(323));
        CS.CSScene.MainPlayerInfo.AsyncOperationController.CalendarFindNpcOperation:DoOperation(mapNpcId, this.mCalendarVO);
    end
end

--endregion

--endregion

function UIActivitiesDesShaBaKPanel:Init()
    this = self;
    this:InitEvents();
end

function UIActivitiesDesShaBaKPanel:Show(customData)
    if(customData == nil) then
        customData = {};
    end

    --if(customData.calendarVO == nil) then
    --    uimanager:ClosePanel("UIActivitiesDesShaBaKPanel");
    --end
    --this.mCalendarVO = customData.calendarVO;
    --this:GetActivitiesViewTemplate():UpdateView(this.mCalendarVO.tableData);
    --this:GetUITable():Reposition();

    if(customData.calendarItem == nil) then
        uimanager:ClosePanel("UIActivitiesDesPanel");
    end
    this.mCalendarItem = customData.calendarItem;
    ---@type LuaActivityItem
    this.mActivity = this.mCalendarItem.ActivityItem;
    ---@type LuaActivityItemSubInfo
    local state, activitySubData = this:GetActivitySubData();
    if(activitySubData ~= nil) then
        this:GetActivitiesViewTemplate():UpdateView(activitySubData.Tbl, this.mCalendarItem);
    end
    this:GetUITable():Reposition();
end

function ondestroy()
    this = nil;
end

return UIActivitiesDesShaBaKPanel;