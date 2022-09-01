---@class UIBossWakeUpPanel:UIBase 限时活动-BOSS觉醒
local UIBossWakeUpPanel = {}

--region 组件
---@return UnityEngine.GameObject 进入活动
function UIBossWakeUpPanel:GetEnterActivityBtn_GO()
    if self.mEnterActivityGo == nil then
        self.mEnterActivityGo = self:GetCurComp("WidgetRoot/events/btn_go", "GameObject")
    end
    return self.mEnterActivityGo
end

---@return UILabel 活动描述
function UIBossWakeUpPanel:GetActivityDes_UILabel()
    if self.mActivityDes == nil then
        self.mActivityDes = self:GetCurComp("WidgetRoot/view/desc/Label", "UILabel")
    end
    return self.mActivityDes
end

---@return UICountdownLabel 倒计时
function UIBossWakeUpPanel:GetTimeCount_UICountdownLabel()
    if self.mTimeCountLabel == nil then
        self.mTimeCountLabel = self:GetCurComp("WidgetRoot/view/TimeCount", "UICountdownLabel")
    end
    return self.mTimeCountLabel
end

---@return UILabel 倒计时文本
function UIBossWakeUpPanel:GetTimeCount_UILabel()
    if self.mTimeCountLb == nil then
        self.mTimeCountLb = self:GetCurComp("WidgetRoot/view/TimeCount", "UILabel")
    end
    return self.mTimeCountLb
end

--endregion

--region 初始化
function UIBossWakeUpPanel:Init()
    self:BindEvents()
end

---@param activityData SpecialActivityPanelData
function UIBossWakeUpPanel:Show(activityData)
    if activityData == nil then
        self:ClosePanel()
        return
    end
    self.mActivityData = activityData

    self:RefreshPanelShow()
end

function UIBossWakeUpPanel:BindEvents()
    CS.UIEventListener.Get(self:GetEnterActivityBtn_GO()).onClick = function()
        self:OnEnterActivityBtnClicked()
    end
end
--endregion

--region 刷新界面显示
---刷新界面显示
function UIBossWakeUpPanel:RefreshPanelShow()
    local finishTime = self.mActivityData.mFinishTime
    if finishTime then
        self:GetTimeCount_UICountdownLabel():StartCountDown(nil, 8, finishTime * 1000, "活动倒计时", nil, nil, function()
            self:GetTimeCount_UILabel().text = "已结束"
        end)
    end
end

--endregion

--region 进入活动
---进入活动
function UIBossWakeUpPanel:OnEnterActivityBtnClicked()
    uimanager:CreatePanel("UIBossPanel")
end
--endregion

return UIBossWakeUpPanel