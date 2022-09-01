---@class UICalendarDateViewTemplate:TemplateBase 日期部分模板
local UICalendarDateViewTemplate = {};

UICalendarDateViewTemplate.mUnitDic = nil;

--UICalendarDateViewTemplate.mCurrentIndex = 0;

--region Components

function UICalendarDateViewTemplate:GetGridContainer()
    if (self.mGridContainer == nil) then
        self.mGridContainer = self:Get("ScrollView/Activities", "UIGridContainer");
    end
    return self.mGridContainer;
end

function UICalendarDateViewTemplate:GetSpringPanel()
    if (self.mSpringPanel == nil) then
        self.mSpringPanel = self:Get("ScrollView", "SpringPanel");
    end
    return self.mSpringPanel;
end

---@return UIScrollView
function UICalendarDateViewTemplate:GetScrollView()
    if (self.mUIScrollView == nil) then
        self.mUIScrollView = self:Get("ScrollView", "UIScrollView");
    end
    return self.mUIScrollView;
end

---@return UILoopScrollViewPlus 循环组件
function UICalendarDateViewTemplate:GetGrid_UILoopScrollViewPlus()
    if (self.mGridUILoopScrollViewPlus == nil) then
        self.mGridUILoopScrollViewPlus = self:Get("ScrollView/Activities", "UILoopScrollViewPlus");
    end
    return self.mGridUILoopScrollViewPlus
end

--endregion
---@type table<number, UICalendarDateUnitTemplate>
UICalendarDateViewTemplate.DateTempList = nil

function UICalendarDateViewTemplate:Init(panel)
    ---@type UIBase
    self.mOwnerPanel = panel
    self.DateTempList = {}
    self:InitEvents();
end

function UICalendarDateViewTemplate:InitEvents()
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Calendar_SelectDate, function (id, data)
        self:SwitchSelectDateUnit(data)
    end)

    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Calendar_OnCurrentTimeStampUtcChanged, function (id, time)
        self:CallOnCurrentTimeStampUtcChanged(time)
    end);
end

function UICalendarDateViewTemplate:CallOnCurrentTimeStampUtcChanged(time, isForceMove)
    local index = math.floor( (time - gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime()) / gameMgr:GetLuaTimeMgr().DayCostMillisecond) + gameMgr:GetPlayerDataMgr():GetActivityMgr():GetOpenServerDayMax3();
    --self:SetScrollViewPosition(index);
    local x = self:GetGrid_UILoopScrollViewPlus().Panel.clipOffset.x;
    local leftIndex = math.floor(x / self:GetGrid_UILoopScrollViewPlus().CellLeghth)
    local target = nil
    if(index <= leftIndex) then
        target = index;
    end
    if(index > leftIndex + 6) then
        target = index - 6
    end
    if(isForceMove) then
        target = index
    end

    if(target ~= nil) then
        target = target < 0 and 0 or target;
        local targetPosition = self:GetGrid_UILoopScrollViewPlus():GetJumpToLineV3(target);
        if(self:GetSpringPanel() ~= nil) then
            self:GetSpringPanel().enabled = false;
            self:GetSpringPanel().target = CS.UnityEngine.Vector3(-targetPosition.x + 40, targetPosition.y, targetPosition.z);
            self:GetSpringPanel().enabled = true;
        end
    end

    local template = self.DateTempList[index]
    if template then
        template:Select()
    end
end

---切换选中的日期个体
---@param date UICalendarDateUnitTemplate
function UICalendarDateViewTemplate:SwitchSelectDateUnit(date)
    if (self.mLastChooseUnit ~= nil and self.mLastChooseUnit.mTimeStampUtc ~= nil) then
        if (date.mTimeStampUtc ~= nil and date.mTimeStampUtc ~= self.mLastChooseUnit.mTimeStampUtc) then
            self.mLastChooseUnit:UnSelect();
        end
    end
    self.mLastChooseUnit = date;
end

function UICalendarDateViewTemplate:UpdateView()
    self:GetGrid_UILoopScrollViewPlus():Init(function(go, line)
        ---就显示33天的活动
        if line < 30 + gameMgr:GetLuaActivityMgr():GetOpenServerDayMax3() then
            local template = self:GetCellTemplate(go)
            if template then
                local targetDayWeeHoursDay = math.floor(gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime() + (line - gameMgr:GetLuaActivityMgr():GetOpenServerDayMax3()) * gameMgr:GetLuaTimeMgr().DayCostMillisecond)
                local calendarItem = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetTargetDayCalendarList(targetDayWeeHoursDay);
                template:UpdateUnit(calendarItem, targetDayWeeHoursDay)
                self.DateTempList[line] = template
                return true
            end
        end
        return false
    end, nil)
end

---@return UICalendarDateUnitTemplate
function UICalendarDateViewTemplate:GetCellTemplate(go)
    if CS.StaticUtility.IsNull(go) == false then
        if (self.mUnitDic == nil) then
            self.mUnitDic = {};
        end
        local template = self.mUnitDic[go]
        if template == nil then
            template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICalendarDateUnitTemplate);
            self.mUnitDic[go] = template
        end
        return template
    end
end

---选中指定的凌晨时间对于的日期单位
function UICalendarDateViewTemplate:SelectWithTimeStamp(timeStampUtc, isForceMove)
    if (self.mUnitDic ~= nil and timeStampUtc ~= nil) then
        ---因为是从3天前开始排列,所以日期的下标应该是-3开始
        local index = math.floor(((timeStampUtc - gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime()) / gameMgr:GetLuaTimeMgr().DayCostMillisecond) + gameMgr:GetLuaActivityMgr():GetOpenServerDayMax3())
        local template = self.DateTempList[index]
        if template then
            template:OnClickUnit();
        end

        self:CallOnCurrentTimeStampUtcChanged(timeStampUtc, isForceMove);
    end
end

return UICalendarDateViewTemplate;