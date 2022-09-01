---@class UIActivitiesDesProtectTheKingPanel
local UIActivitiesDesProtectTheKingPanel = {};

---@type UIActivitiesDesProtectTheKingPanel
local this = nil;

---@type LuaActivityItemSubInfo
UIActivitiesDesProtectTheKingPanel.mActivitySubData = nil;

---@type LuaActivityItem
UIActivitiesDesProtectTheKingPanel.mActivity = nil;

---@type CalendarItem
UIActivitiesDesProtectTheKingPanel.mCalendarItem = nil;

--region Components

function UIActivitiesDesProtectTheKingPanel:GetBtnClose_GameObject()
    if(this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/ActivitiesDesPanel/window/Btn_Close","GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UIActivitiesDesProtectTheKingPanel:GetBtnLast_GameObject()
    if(this.mBtnLast_GameObject == nil) then
        this.mBtnLast_GameObject = this:GetCurComp("WidgetRoot/ActivitiesDesPanel/events/LastBtn","GameObject");
    end
    return this.mBtnLast_GameObject;
end

function UIActivitiesDesProtectTheKingPanel:GetActivitiesViewTemplate()
    if(this.mActivitiesViewTemplate == nil) then
        this.mActivitiesViewTemplate = templatemanager.GetNewTemplate(this:GetCurComp("WidgetRoot/ActivitiesDesPanel/view","GameObject"), luaComponentTemplates.UIActivitiesDesViewTemplate);
    end
    return this.mActivitiesViewTemplate;
end

function UIActivitiesDesProtectTheKingPanel:GetUITable()
    if(this.mUITable == nil) then
        this.mUITable = this:GetCurComp("WidgetRoot/ActivitiesDesPanel/view/ScrollView/Grid","UITable");
        this.mUITable.IsDealy = true;
    end
    return this.mUITable;
end

---@return LuaActivityItemSubInfo
function UIActivitiesDesProtectTheKingPanel:GetActivitySubData()
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

--region Public

--endregion

--region Private

function UIActivitiesDesProtectTheKingPanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIActivitiesDesProtectTheKingPanel");
    end

    CS.UIEventListener.Get(this:GetBtnLast_GameObject()).onClick = function()
        uimanager:ClosePanel("UIActivitiesDesProtectTheKingPanel");
        uimanager:ClosePanel("UICalendarPanel");
        local mapNpcId = CS.CSScene.MainPlayerInfo.MapInfoV2:GetLastMainCityMapNpcId(tonumber(323));
        CS.CSScene.MainPlayerInfo.AsyncOperationController.CalendarFindNpcOperation:DoOperation(mapNpcId, this.mCalendarVO);
    end
end

--endregion

--endregion

function UIActivitiesDesProtectTheKingPanel:Init()
    this = self;
    this:InitEvents();
end

function UIActivitiesDesProtectTheKingPanel:Show(customData)
    if(customData == nil) then
        customData = {};
    end
    --
    --if(customData.calendarVO == nil) then
    --    uimanager:ClosePanel("UIActivitiesDesProtectTheKingPanel");
    --end
    --this.mCalendarVO = customData.calendarVO;
    --this:GetActivitiesViewTemplate():UpdateView(this.mCalendarVO.tableData);
    --this:GetUITable():Reposition();

    if(customData.calendarItem == nil) then
        uimanager:ClosePanel("UIActivitiesDesPanel");
    end
    this.mCalendarItem = customData.calendarItem;
    this.mActivity =  this.mCalendarItem.ActivityItem;

    ---@type LuaActivityItemSubInfo
    local state, activitySubData = this:GetActivitySubData();
    if(activitySubData ~= nil) then
        this:GetActivitiesViewTemplate():UpdateView(activitySubData.Tbl);
    end
    this:GetUITable():Reposition();
end

function ondestroy()
    this = nil;
end
return UIActivitiesDesProtectTheKingPanel;