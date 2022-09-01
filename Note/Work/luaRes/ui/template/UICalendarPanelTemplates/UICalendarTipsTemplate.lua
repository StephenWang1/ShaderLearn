---@class UICalendarTipsTemplate
local UICalendarTipsTemplate = {};

---@type UIActivitiesPanel
UICalendarTipsTemplate.mOwnerPanel = nil;

UICalendarTipsTemplate.mDelayTime = 10;

---@type CalendarItem
UICalendarTipsTemplate.mCalendarItem = nil;

function UICalendarTipsTemplate:GetRoot_GameObject()
    if (self.mRoot_GameObject == nil) then
        self.mRoot_GameObject = self:Get("root", "GameObject");
    end
    return self.mRoot_GameObject;
end

function UICalendarTipsTemplate:GetBtnGo_GameObject()
    if (self.mBtnGo_GameObject == nil) then
        self.mBtnGo_GameObject = self:Get("root/bg", "GameObject");
    end
    return self.mBtnGo_GameObject;
end

function UICalendarTipsTemplate:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnGo_GameObject = self:Get("root/close", "GameObject");
    end
    return self.mBtnGo_GameObject;
end

function UICalendarTipsTemplate:GetDelayTime()
    local isFind, globalTable = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22855);
    if (isFind) then
        self.mDelayTime = tonumber(globalTable.value);
    end

    if (self.mDelayTime <= 0) then
        self.mDelayTime = 20;
    end
    return self.mDelayTime
end

---@public 组件初始化
function UICalendarTipsTemplate:Initialize()
    self:CloseTips();
end

-----@public 设置父节点
function UICalendarTipsTemplate:SetParent(gobj)
    self.go.transform:SetParent(gobj.transform);
    self.go.transform.localPosition = CS.UnityEngine.Vector3.zero;
    self.go.transform.localScale = CS.UnityEngine.Vector3.one;
end

function UICalendarTipsTemplate:SetCalendarItem(calendarItem)
    self.mCalendarItem = calendarItem;
end

---@public 打开提示
function UICalendarTipsTemplate:OpenTips()
    if (self.go) then
        self.go:SetActive(true);
    end
    if (self.mCoroutineDelayTime ~= nil) then
        StopCoroutine(self.mCoroutineDelayTime);
        self.mCoroutineDelayTime = nil;
    end
    self.mCoroutineDelayTime = StartCoroutine(self.CDelayTime, self);
end

---@public 关闭提示
function UICalendarTipsTemplate:CloseTips()
    self.go:SetActive(false);
end

---@private 延迟协程
function UICalendarTipsTemplate:CDelayTime()
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(self:GetDelayTime()));
    self:CloseTips();
end

--function UICalendarTipsTemplate:OnCalendarActivityIsOpen(activityId, state, gobj)
--    if(state) then
--        ---@type TABLE.cfg_daily_activity_time
--        local tbl = clientTableManager.cfg_daily_activity_timeManager:TryGetValue(activityId);
--        if(tbl ~= nil) then
--            local activities = gameMgr:GetLuaActivityMgr():GetTodayCalendarActivities();
--            if(activities ~= nil) then
--                ---@param v CalendarItem
--                for k,v in pairs(activities) do
--                    local state, activityItemSubInfo = v.ActivityItem:GetRunningState();
--                    if(state == LuaActivityRunningState.IsRunning) then
--                        if(activityItemSubInfo ~= nil and activityItemSubInfo.Tbl:GetId() == activityId) then
--                            self.mCalendarItem = v;
--                            break;
--                        end
--                    end
--                end
--            end
--        end
--        self:SetParent(gobj);
--        self:OpenTips();
--    end
--end

---@private 初始化UI事件
function UICalendarTipsTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetBtnGo_GameObject()).onClick = function()
        if (self.mCalendarItem ~= nil) then
            gameMgr:GetLuaActivityMgr():TryGoToCalendarActivity(self.mCalendarItem);
        end
        if (self.mOwnerPanel ~= nil) then
            self.mOwnerPanel:IsOpenCalendarTips(false);
        else
            self:CloseTips();
        end
    end;

    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        if (self.mOwnerPanel ~= nil) then
            self.mOwnerPanel:IsOpenCalendarTips(false);
        else
            self:CloseTips();
        end
    end;

    --if(self.mOwnerPanel ~= nil) then
    --    self.CallOnCalendarActivityIsOpen = function(msgId, activityId, state, gobj)
    --        self:OnCalendarActivityIsOpen(activityId, state, gobj);
    --    end
    --    self.mOwnerPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_CalendarActivityIsOpen, self.CallOnCalendarActivityIsOpen);
    --end
end

function UICalendarTipsTemplate:Init(panel)
    self.mOwnerPanel = panel;
    self:InitEvents();
end

function UICalendarTipsTemplate:OnDestroy()
    if (self.mCoroutineDelayTime ~= nil) then
        StopCoroutine(self.mCoroutineDelayTime);
        self.mCoroutineDelayTime = nil;
    end
end

return UICalendarTipsTemplate;