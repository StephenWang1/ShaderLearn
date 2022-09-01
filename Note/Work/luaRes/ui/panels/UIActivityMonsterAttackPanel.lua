---@class UIActivityMonsterAttackPanel:UIBase 联服活动-怪物攻城
local UIActivityMonsterAttackPanel = {}

--region 组件
---@return UnityEngine.GameObject 进入活动
function UIActivityMonsterAttackPanel:GetEnterMonsterAttackActivityBtn_GO()
    if self.mMonsterAttackActivityGo == nil then
        self.mMonsterAttackActivityGo = self:GetCurComp("WidgetRoot/view/btn_Enter", "GameObject")
    end
    return self.mMonsterAttackActivityGo
end

---@return UILabel 活动描述
function UIActivityMonsterAttackPanel:GetActivityDes_UILabel()
    if self.mActivityDes == nil then
        self.mActivityDes = self:GetCurComp("WidgetRoot/view/Des", "UILabel")
    end
    return self.mActivityDes
end

---@return UICountdownLabel 倒计时
function UIActivityMonsterAttackPanel:GetTimeCount_UICountdownLabel()
    if self.mTimeCount == nil then
        self.mTimeCount = self:GetCurComp("WidgetRoot/view/TimeCount", "UICountdownLabel")
    end
    return self.mTimeCount
end

---@return UILabel 倒计时文本
function UIActivityMonsterAttackPanel:GetTimeCount_UILabel()
    if self.mTimeCountLb == nil then
        self.mTimeCountLb = self:GetCurComp("WidgetRoot/view/TimeCount", "UILabel")
    end
    return self.mTimeCountLb
end

--endregion

--region 初始化
function UIActivityMonsterAttackPanel:Init()
    self:BindEvents()
end

---@param activityData SpecialActivityPanelData
function UIActivityMonsterAttackPanel:Show(activityData)
    if activityData == nil then
        self:ClosePanel()
        return
    end
    self.mActivityData = activityData
    self:RefreshPanelShow()
end

function UIActivityMonsterAttackPanel:BindEvents()
    CS.UIEventListener.Get(self:GetEnterMonsterAttackActivityBtn_GO()).onClick = function()
        self:OnEnterMonsterAttackActivityBtnClicked()
    end
end
--endregion

--region 刷新界面显示
---刷新界面显示
function UIActivityMonsterAttackPanel:RefreshPanelShow()
    local activityId = self.mActivityData.mActivityID
    if activityId then
        local data = self:CacheActivityData(activityId)
        if data then
            self:GetActivityDes_UILabel().text = data:GetSmallName()
        end
    end
    local finishTime = self.mActivityData.mFinishTime
    if finishTime then
        self:GetTimeCount_UICountdownLabel():StartCountDown(nil, 8, finishTime * 1000, "活动倒计时", nil, nil, function()
            self:GetTimeCount_UILabel().text = "已结束"
        end)
    end
end

--endregion

--region 缓存数据
---@return TABLE.cfg_special_activity
function UIActivityMonsterAttackPanel:CacheActivityData(activityId)
    if self.mActivityIdToInfo == nil then
        self.mActivityIdToInfo = {}
    end
    local data = self.mActivityIdToInfo[activityId]
    if data == nil then
        data = clientTableManager.cfg_special_activityManager:TryGetValue(activityId)
        self.mActivityIdToInfo[activityId] = data
    end
    return data
end

--endregion

--region 进入活动
---进入活动
function UIActivityMonsterAttackPanel:OnEnterMonsterAttackActivityBtnClicked()
    if(CS.CSScene.MainPlayerInfo.Level < 70) then
        Utility.ShowPopoTips(self:GetEnterMonsterAttackActivityBtn_GO(), "等级不足70级,无法前往", 450, "UIActivityMonsterAttackPanel")
    else
        CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({ 347 }, "UISealTowerPanel", CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC, nil)
        uimanager:ClosePanel("UIActivityCurrentPanel")
    end
end
--endregion

return UIActivityMonsterAttackPanel