---@class UICarnivalExpPanel:UIBase
local UICarnivalExpPanel = {}

--region 组件
function UICarnivalExpPanel:GetTime_UICountdownLabel()
    if (self.mGetTime == nil) then
        self.mGetTime = self:GetCurComp("WidgetRoot/view/TimeCount", "UICountdownLabel")
    end
    return self.mGetTime
end
--endregion

function UICarnivalExpPanel:Show(activityData)
    self.activityAllData = activityData
    self.curType = activityData.mEventID
    self.curActivityId = activityData.mActivityID
    self:StartCountDown()
end

---活动倒计时
function UICarnivalExpPanel:StartCountDown()
    if self.activityAllData ~= nil and self.activityAllData.mFinishTime ~= nil then
        self:GetTime_UICountdownLabel():StartCountDown(nil, 8, self.activityAllData.mFinishTime * 1000,
                '活动倒计时', "", nil, nil)
    end
end

return UICarnivalExpPanel