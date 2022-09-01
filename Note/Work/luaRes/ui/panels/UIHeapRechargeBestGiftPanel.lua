--- DateTime: 2021/05/17 19:15
--- Description 累充豪礼

---@class UIHeapRechargeBestGiftPanel:UIBase
local UIHeapRechargeBestGiftPanel = {}

--region parameters
---全部奖励模板
UIHeapRechargeBestGiftPanel.allAwardTemplateDic = nil
--endregion

--region Init
function UIHeapRechargeBestGiftPanel:Init()
    self:InitParameters()
    self:InitComponents()
    self:BindEvent()
end

---@private
function UIHeapRechargeBestGiftPanel:InitParameters()
    self.allAwardTemplateDic = {}
    self.IsInitialized = false
end

---@private
function UIHeapRechargeBestGiftPanel:InitComponents()
    ---
    ---@type UILoopScrollViewPlus
    self.loop_Awards = self:GetCurComp("WidgetRoot/MainView/BestGift/scroll/grid", "UILoopScrollViewPlus")
    ---
    ---@type UICountdownLabel 倒计时组件
    self.countdown_label = self:GetCurComp("WidgetRoot/MainView/TimeCount", "UICountdownLabel")
end
--endregion

--region public methods
---@param activityData SpecialActivityPanelData
function UIHeapRechargeBestGiftPanel:Show(activityData)
    if (activityData == nil) then
        return
    end
    self.activityData = activityData
    self.SingleActivityData = gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetSingleActivityData(activityData.mEventID)
    if (self.SingleActivityData == nil or self.SingleActivityData.oneActivitiesInfo == nil) then
        return
    end
    self.rewards = self.SingleActivityData.oneActivitiesInfo
    self:SortAwardData()
    self:RefreshPanel()
end
--endregion

--region private methods
---@private
function UIHeapRechargeBestGiftPanel:RefreshPanel()
    self:RefreshCumulativeRecharge()
    self:StartCountDown()
end

---@private
---刷新累计充值展示
function UIHeapRechargeBestGiftPanel:RefreshCumulativeRecharge()
    if (self.loop_Awards == nil) then
        return
    end
    if not self.IsInitialized then
        self.loop_Awards:Init(self.RefreshCumulativeRechargeUnitTemplateView, nil)
        self.IsInitialized = true
    else
        self.loop_Awards:ResetPage()
    end
end

---@private
function UIHeapRechargeBestGiftPanel.RefreshCumulativeRechargeUnitTemplateView(go, line)
    if go == nil or line + 1 > #UIHeapRechargeBestGiftPanel.rewards then
        return false
    end
    if (UIHeapRechargeBestGiftPanel.allAwardTemplateDic[go] == nil) then
        UIHeapRechargeBestGiftPanel.allAwardTemplateDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIHeapRechargeBestGiftTemplate)

    end
    ---@type UIHeapRechargeBestGiftTemplate
    local temp = UIHeapRechargeBestGiftPanel.allAwardTemplateDic[go]
    temp:SetTemplate(UIHeapRechargeBestGiftPanel.rewards[line + 1])
    return true
end

---@private
---活动倒计时
function UIHeapRechargeBestGiftPanel:StartCountDown()
    if (self.countdown_label ~= nil and self.SingleActivityData ~= nil) then
        self.countdown_label:StartCountDown(nil, 8, self.SingleActivityData.leftTime * 1000,
                '活动倒计时 ', "", nil, nil)
    end
end

---@private
---奖励数据排序
function UIHeapRechargeBestGiftPanel:SortAwardData()
    if (self.rewards == nil) then
        return
    end
    ---@param a activitiesV2.OneActivitiesInfo
    ---@param b activitiesV2.OneActivitiesInfo
    table.sort(self.rewards, function(a, b)
        if (a == nil or b == nil) then
            return false
        end

        local specialActivityTbl1 = clientTableManager.cfg_special_activityManager:TryGetValue(a.configId)
        local specialActivityTbl2 = clientTableManager.cfg_special_activityManager:TryGetValue(b.configId)
        local count1, count2 = 0, 0
        if (specialActivityTbl1 ~= nil and specialActivityTbl2 ~= nil) then
            count1 = (specialActivityTbl1:GetGoal() ~= nil and specialActivityTbl1:GetGoal().list ~= nil and #specialActivityTbl1:GetGoal().list > 0) and specialActivityTbl1:GetGoal().list[1] or 0
            count2 = (specialActivityTbl2:GetGoal() ~= nil and specialActivityTbl2:GetGoal().list ~= nil and #specialActivityTbl2:GetGoal().list > 0) and specialActivityTbl2:GetGoal().list[1] or 0
        end

        if (a.finish == b.finish) then
            return count1 < count2
        elseif (a.finish == 2 or b.finish == 2) then
            return a.finish > b.finish
        elseif (a.finish ~= b.finish) then
            return a.finish < b.finish
        end

        return count1 < count2
    end)
end
--endregion

--region bind event
function UIHeapRechargeBestGiftPanel:BindEvent()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.mSingleActivityChange, function(magId, eventId)
        if self.activityData ~= nil and self.activityData.mEventID == eventId then
            self:Show({ mEventID = eventId })
        end
    end)
end

function UIHeapRechargeBestGiftPanel:OnClose()
    uimanager:ClosePanel('UIHeapRechargeBestGiftPanel')
end
--endregion

--region destroy
--endregion

return UIHeapRechargeBestGiftPanel