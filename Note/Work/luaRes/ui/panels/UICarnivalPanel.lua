---@class UICarnivalPanel:UIBase 热血狂欢
local UICarnivalPanel = {}

UICarnivalPanel.mCarnivalCouponId = 1000028

---@return LuaSpecialActivityData
function UICarnivalPanel:GetDataManager()
    return gameMgr:GetPlayerDataMgr():GetSpecialActivityData()
end

--region组件
--region 任务
---@return UIToggle 任务页签
function UICarnivalPanel:GetMissionToggle_UIToggle()
    if self.mMissionToggle == nil then
        self.mMissionToggle = self:GetCurComp("WidgetRoot/view/CarnivalMissionToggle", "UIToggle")
    end
    return self.mMissionToggle
end

---@return UnityEngine.GameObject 任务部分
function UICarnivalPanel:GetMissionPart_Go()
    if self.mMissionPart == nil then
        self.mMissionPart = self:GetCurComp("WidgetRoot/view/CanivalMission", "GameObject")
    end
    return self.mMissionPart
end

---@return UILoopScrollViewPlus 任务loop
function UICarnivalPanel:GetMissionLoop_UILoopScrollView()
    if self.mMissionLoop == nil then
        self.mMissionLoop = self:GetCurComp("WidgetRoot/view/CanivalMission/scroll/type1", "UILoopScrollViewPlus")
    end
    return self.mMissionLoop
end

---@return Top_OptimizeClipShaderScript
function UICarnivalPanel:GetMissionScrollView_OptimizeClipShaderScript()
    if self.mMissionClip == nil then
        self.mMissionClip = self:GetCurComp("WidgetRoot/view/CanivalMission/scroll", "Top_OptimizeClipShaderScript")
    end
    return self.mMissionClip
end
--endregion

--region 商店
---@return UIToggle 商店页签
function UICarnivalPanel:GetShopToggle_UIToggle()
    if self.mShopToggle == nil then
        self.mShopToggle = self:GetCurComp("WidgetRoot/view/CarnivalCountToggle", "UIToggle")
    end
    return self.mShopToggle
end

---@return UnityEngine.GameObject 商店部分
function UICarnivalPanel:GetShopPart_Go()
    if self.mShopPart == nil then
        self.mShopPart = self:GetCurComp("WidgetRoot/view/CanivalCount", "GameObject")
    end
    return self.mShopPart
end

---@return UILoopScrollViewPlus 商店loop
function UICarnivalPanel:GetShopLoop_UILoopScrollView()
    if self.mShopLoop == nil then
        self.mShopLoop = self:GetCurComp("WidgetRoot/view/CanivalCount/scroll/grid", "UILoopScrollViewPlus")
    end
    return self.mShopLoop
end

---@return SpringPanel
function UICarnivalPanel:GetSpringPanel()
    if self.mSpring == nil then
        self.mSpring = self:GetCurComp("WidgetRoot/view/CanivalCount/scroll", "SpringPanel")
    end
    return self.mSpring
end

---@return UnityEngine.GameObject 狂欢点
function UICarnivalPanel:GetCarnivalCoupon_GO()
    if self.mCarnivalCouponGo == nil then
        self.mCarnivalCouponGo = self:GetCurComp("WidgetRoot/view/CarnivalCount", "GameObject")
    end
    return self.mCarnivalCouponGo
end

---@return UILabel 个人狂欢点显示
function UICarnivalPanel:GetSelfScore_UILabel()
    if self.mSelfScoreLb == nil then
        self.mSelfScoreLb = self:GetCurComp("WidgetRoot/view/CarnivalCount/count", "UILabel")
    end
    return self.mSelfScoreLb
end

---@return UISprite 个人狂欢点图片
function UICarnivalPanel:GetCarnivalCoupon_UISprite()
    if self.mCarnivalCouponSp == nil then
        self.mCarnivalCouponSp = self:GetCurComp("WidgetRoot/view/CarnivalCount/icon", "UISprite")
    end
    return self.mCarnivalCouponSp
end
--endregion

--region 倒计时
---@return UICountdownLabel 倒计时
function UICarnivalPanel:GetTimeCount_UICountdownLabel()
    if self.mTimeCountDownLb == nil then
        self.mTimeCountDownLb = self:GetCurComp("WidgetRoot/view/TimeCount", "UICountdownLabel")
    end
    return self.mTimeCountDownLb
end

---@return UILabel 倒计时文本
function UICarnivalPanel:GetTimeCount_UILabel()
    if self.mTimeCountDownUILabel == nil then
        self.mTimeCountDownUILabel = self:GetCurComp("WidgetRoot/view/TimeCount", "UILabel")
    end
    return self.mTimeCountDownUILabel
end
--endregion

--region 狂欢点
---@return UILoopScrollViewPlus 狂欢点
function UICarnivalPanel:GetScoreLoop_UILoopScrollViewPlus()
    if self.mScoreLoop == nil then
        self.mScoreLoop = self:GetCurComp("WidgetRoot/view/CanivalMission/Progress/type1", "UILoopScrollViewPlus")
    end
    return self.mScoreLoop
end

---@return Top_OptimizeClipShaderScript
function UICarnivalPanel:GetShopScrollView_OptimizeClipShaderScript()
    if self.mShopClip == nil then
        self.mShopClip = self:GetCurComp("WidgetRoot/view/CanivalCount/scroll", "Top_OptimizeClipShaderScript")
    end
    return self.mShopClip
end

--endregion

--region 红点
function UICarnivalPanel:GetMissionRed_UIRedPoint()
    if self.mMissionPoint == nil then
        self.mMissionPoint = self:GetCurComp("WidgetRoot/view/CarnivalMissionToggle/redPoint", "UIRedPoint")
    end
    return self.mMissionPoint
end

function UICarnivalPanel:GetShopRed_UIRedPoint()
    if self.mShopPoint == nil then
        self.mShopPoint = self:GetCurComp("WidgetRoot/view/CarnivalCountToggle/redPoint", "UIRedPoint")
    end
    return self.mShopPoint
end
--endregion

--endregion

--region初始化
function UICarnivalPanel:Init()
    self:OnceRefresh()
    self:BindEvents()
    self:BindMessage()
    self:BindRedPoint()
end

---@param activityData SpecialActivityPanelData
function UICarnivalPanel:Show(activityData)
    self.mActivityData = activityData
    self:RefreshPanelTime()
    local bookMarkType = 1
    if self.mCurrentPanelType == nil then
        if self:ShowRedPoint(LuaEnumCarnivalEventId.Activity) == false and self:ShowRedPoint(LuaEnumCarnivalEventId.Score) == true then
            bookMarkType = 2
        end
    else
        bookMarkType = self.mCurrentPanelType
    end
    self:ChooseToggle(bookMarkType)
end

function UICarnivalPanel:BindEvents()
    CS.UIEventListener.Get(self:GetMissionToggle_UIToggle().gameObject).onClick = function()
        self:ChooseToggle(1)
    end
    CS.UIEventListener.Get(self:GetShopToggle_UIToggle().gameObject).onClick = function()
        self:ChooseToggle(2)
    end

    CS.UIEventListener.Get(self:GetCarnivalCoupon_GO()).onClick = function()
        local data = self:CacheItemInfo(self.mCarnivalCouponId)
        if data then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = data, showRight = false })
        end
    end
end

function UICarnivalPanel:BindMessage()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.mSingleActivityChange, function(magId, eventId)
        if eventId == LuaEnumCarnivalEventId.Activity and self.mCurrentPanelType == 1 then
            self:RefreshActivity()
        elseif eventId == LuaEnumCarnivalEventId.Score and self.mCurrentPanelType == 2 then
            self:RefreshShop()
        end
    end)
end

---只刷新一次
function UICarnivalPanel:OnceRefresh()
    self:RefreshCarnivalCouponIcon()
end
--endregion

--region 页签

---@param type number 页签类型1任务/2商店
function UICarnivalPanel:ChooseToggle(type)
    self.mCurrentPanelType = type
    if type == 1 then
        self:OnMissionClicked()
    elseif type == 2 then
        self:OnShopClicked()
    end
end

---切换任务
function UICarnivalPanel:OnMissionClicked()
    local activityId = self:GetDataManager():GetActivityIdByEventId(LuaEnumCarnivalEventId.Activity)
    if activityId then
        networkRequest.ReqGetOneActivitiesInfo(activityId)
    end
    self:GetMissionToggle_UIToggle():Set(true)
    self:GetMissionPart_Go():SetActive(true)
    self:GetShopPart_Go():SetActive(false)
    self:GetCarnivalCoupon_GO():SetActive(false)
    self:GetMissionScrollView_OptimizeClipShaderScript():SetClipArea()
end

---切换商店
function UICarnivalPanel:OnShopClicked()
    local activityId = self:GetDataManager():GetActivityIdByEventId(LuaEnumCarnivalEventId.Score)
    if activityId then
        networkRequest.ReqGetOneActivitiesInfo(activityId)
    end
    self:GetShopToggle_UIToggle():Set(true)
    self:GetMissionPart_Go():SetActive(false)
    self:GetShopPart_Go():SetActive(true)
    self:GetCarnivalCoupon_GO():SetActive(true)
    self:GetShopScrollView_OptimizeClipShaderScript():SetClipArea()
end

--endregion

--region 活动任务
function UICarnivalPanel:RefreshActivity()
    local allActivity = gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetSingleActivityData(LuaEnumCarnivalEventId.Activity)
    if allActivity then
        local showList = allActivity.oneActivitiesInfo
        ---@param left activitiesV2.OneActivitiesInfo
        ---@param right activitiesV2.OneActivitiesInfo
        table.sort(showList, function(left, right)
            if left == nil or right == nil then
                return false
            end
            local tblDataLeft = self:CacheActivityInfo(left.configId)
            local tblDataRight = self:CacheActivityInfo(right.configId)
            local leftReward = self:GetDataManager():GetSingleActivityInfo(left.configId)
            local rightReward = self:GetDataManager():GetSingleActivityInfo(right.configId)

            if tblDataLeft == nil or tblDataRight == nil
                    or tblDataLeft:GetAwardType() == nil or tblDataRight:GetAwardType() == nil
                    or tblDataLeft:GetAwardType().list == nil or tblDataRight:GetAwardType().list == nil
                    or #tblDataLeft:GetAwardType().list < 2 or #tblDataRight:GetAwardType().list < 2
                    or leftReward == nil or rightReward == nil
                    or leftReward.goalInfo == nil or rightReward.goalInfo == nil then
                return false
            end

            local leftAim = tblDataLeft:GetAwardType().list[2]
            local rightAim = tblDataRight:GetAwardType().list[2]
            local leftReceived = leftReward.goalInfo.receivedCount
            local rightReceived = rightReward.goalInfo.receivedCount
            local leftFinishTime = leftReward.goalInfo.finishCount
            local rightFinishTime = rightReward.goalInfo.finishCount

            leftAim = leftAim == nil and 0 or leftAim
            rightAim = rightAim == nil and 0 or rightAim
            leftReceived = leftReceived == nil and 0 or leftReceived
            rightReceived = rightReceived == nil and 0 or rightReceived
            leftFinishTime = leftFinishTime == nil and 0 or leftFinishTime
            rightFinishTime = rightFinishTime == nil and 0 or rightFinishTime

            local leftCanReward = leftFinishTime - leftReceived
            local rightCanReward = rightFinishTime - rightReceived

            local leftState = leftReceived == leftAim and LuaEnumFinishState.Finish or (leftCanReward <= 0 and LuaEnumFinishState.UnFinish or LuaEnumFinishState.CanReceive)
            local rightState = rightReceived == rightAim and LuaEnumFinishState.Finish or (rightCanReward <= 0 and LuaEnumFinishState.UnFinish or LuaEnumFinishState.CanReceive)
            if leftState == rightState then
                return left.configId < right.configId
            else
                return leftState < rightState
            end
        end)
        --[[
                if self.mHasInitMission then
                    self:GetMissionLoop_UILoopScrollView():RefreshCurrentPage()
                else

                    self.mHasInitMission = true
                end
        ]]

        self:GetMissionLoop_UILoopScrollView():Init(function(go, line)
            if line < #allActivity.oneActivitiesInfo then
                local data = self:GetDataManager():GetSingleActivityInfo(allActivity.oneActivitiesInfo[line + 1].configId)
                if data then
                    self:RefreshMissionSingleLine(go, data)
                    return true
                else
                    return false
                end
            else
                return false
            end
        end)
    end
end

---@param data activitiesV2.OneActivitiesInfo
function UICarnivalPanel:RefreshMissionSingleLine(go, data)
    local template = self:GetMissionTemplate(go)
    if template then
        template:RefreshMission(data)
    end
end

---@return UICarnivalPanel_MissionTemplate
function UICarnivalPanel:GetMissionTemplate(go)
    if self.mGoToMissionTemplate == nil then
        self.mGoToMissionTemplate = {}
    end
    local template = self.mGoToMissionTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICarnivalPanel_MissionTemplate, self)
        self.mGoToMissionTemplate[go] = template
    end
    return template
end

--endregion

--region 狂欢点
function UICarnivalPanel:RefreshShop()
    self:GetShopLoop_UILoopScrollView():JumpToLine(0)
    local allActivity = gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetSingleActivityData(LuaEnumCarnivalEventId.Score)
    if allActivity == nil then
        return
    end
    local activityList = allActivity.oneActivitiesInfo
    if activityList == nil then
        return
    end
    local extData = self:GetDataManager():GetExtData(LuaEnumCarnivalEventId.Score)
    self:RefreshReceivedData(extData)
    self:GetSelfScore_UILabel().text = extData.bloodOrgyPoint
    if self.mHasInitShop then
        self:GetShopLoop_UILoopScrollView():RefreshCurrentPage()
    else
        self:GetShopLoop_UILoopScrollView():Init(function(go, line)
            if line < #activityList then
                extData = self:GetDataManager():GetExtData(LuaEnumCarnivalEventId.Score)
                local configId = activityList[line + 1].configId
                local state = self:GetActivityState(configId)
                self:RefreshShopSingleLine(go, configId, state, extData)
                return true
            else
                return false
            end
        end)
        self.mHasInitShop = true
    end
    local aimLine = self:GetFirstCanReward(activityList, extData) - 1
    if aimLine < 0 then
        aimLine = 0
    end
    if aimLine + 3 >= #activityList then
        aimLine = #activityList - 3
    end
    if self:GetSpringPanel() then
        self:GetSpringPanel().enabled = false
    end
    self:GetShopLoop_UILoopScrollView():JumpToLine(aimLine)
end

---获取跳转行
function UICarnivalPanel:GetFirstCanReward(activityList, extData)
    for i = 1, #activityList do
        local isCard = extData.bloodOrgyRechargeUnlock == 1
        local configId = activityList[i].configId
        local state = self:GetActivityState(configId)
        local tblInfo = self:CacheActivityInfo(configId)
        if tblInfo == nil or tblInfo:GetGoal() == nil or #tblInfo:GetGoal().list < 1 then
            return
        end
        local goal = tblInfo:GetGoal().list[1]
        local isFinish = extData.bloodOrgyPoint >= goal
        if isCard then
            if state ~= LuaEnumRewardState.Higher and isFinish then
                return i - 1
            end
        else
            if state ~= LuaEnumRewardState.Normal and isFinish then
                return i - 1
            end
        end
    end

    for j = 1, #activityList do
        local isCard = extData.bloodOrgyRechargeUnlock == 1
        local configId = activityList[j].configId
        local state = self:GetActivityState(configId)
        if state == LuaEnumRewardState.UnReward then
            return j - 1
        end
    end
    return 0
end

---刷新单行商店
---@param configId number
---@param state LuaEnumRewardState
---@param extData activitiesV2.ActivitiesPartInfo
function UICarnivalPanel:RefreshShopSingleLine(go, configId, state, extData)
    local template = self:GetCountTemplate(go)
    if template then
        template:RefreshShop(configId, state, extData)
    end
end

---存储活动领取状态
---@param extData activitiesV2.ActivitiesPartInfo
function UICarnivalPanel:RefreshReceivedData(extData)
    self.mConfigIdToState = {}
    if extData.bloodOrgyReceivedIds then
        for i = 1, #extData.bloodOrgyReceivedIds do
            local configId = extData.bloodOrgyReceivedIds[i]
            self.mConfigIdToState[configId] = LuaEnumRewardState.Normal
        end
    end
    if extData.bloodOrgyRechargeIds then
        for i = 1, #extData.bloodOrgyRechargeIds do
            local configId = extData.bloodOrgyRechargeIds[i]
            self.mConfigIdToState[configId] = LuaEnumRewardState.Higher
        end
    end
end

---@return LuaEnumRewardState 获取领取状态
function UICarnivalPanel:GetActivityState(configId)
    local state = LuaEnumRewardState.UnReward
    if self.mConfigIdToState and self.mConfigIdToState[configId] then
        state = self.mConfigIdToState[configId]
    end
    return state
end

---@return UICarnivalPanel_CountTemplate
function UICarnivalPanel:GetCountTemplate(go)
    if self.mGoToShopTemplate == nil then
        self.mGoToShopTemplate = {}
    end
    local template = self.mGoToShopTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICarnivalPanel_CountTemplate, self)
        self.mGoToShopTemplate[go] = template
    end
    return template
end

---刷新icon
function UICarnivalPanel:RefreshCarnivalCouponIcon()
    local data = self:CacheItemInfo(self.mCarnivalCouponId)
    if data then
        self:GetCarnivalCoupon_UISprite().spriteName = data.icon
    end
    self:GetSelfScore_UILabel().text = ""
end

---获取所有加锁奖励
function UICarnivalPanel:GetAllLockReward()
    if self.mAllRewardList == nil then
        self.mAllRewardList = {}
        local allActivity = gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetSingleActivityData(LuaEnumCarnivalEventId.Score)
        if allActivity == nil then
            return {}
        end
        local activityList = allActivity.oneActivitiesInfo
        if activityList == nil then
            return {}
        end
        for i = 1, #activityList do
            local configId = activityList[i].configId
            local tblInfo = self:CacheActivityInfo(configId)
            if tblInfo and tblInfo:GetChargeReward() then
                for i = 1, #tblInfo:GetChargeReward().list do
                    local info = tblInfo:GetChargeReward().list[i].list
                    if #info >= 2 then
                        ---@type CarnivalRewardInfo
                        local rewardInfo = {}
                        rewardInfo.itemId = info[1]
                        rewardInfo.num = info[2]
                        rewardInfo.isLock = true
                        table.insert(self.mAllRewardList, rewardInfo)
                    end
                end
            end
        end
    end
    return self.mAllRewardList
end
--endregion

--region 倒计时
---刷新倒计时显示
function UICarnivalPanel:RefreshPanelTime()
    if self.mActivityData == nil then
        return
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
---@return TABLE.CFG_ITEMS
function UICarnivalPanel:CacheItemInfo(id)
    if self.mItemIdToInfo == nil then
        self.mItemIdToInfo = {}
    end
    local data = self.mItemIdToInfo[id]
    if data == nil then
        ___, data = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
        self.mItemIdToInfo[id] = data
    end
    return data
end

---@return TABLE.cfg_special_activity
function UICarnivalPanel:CacheActivityInfo(id)
    if self.mActivityIdToInfo == nil then
        self.mActivityIdToInfo = {}
    end
    local info = self.mActivityIdToInfo[id]
    if info == nil then
        info = clientTableManager.cfg_special_activityManager:TryGetValue(id)
        self.mActivityIdToInfo[id] = info
    end
    return info
end

---@return TABLE.cfg_activity_goals
function UICarnivalPanel:CacheActivityGoalInfo(id)
    if self.mActivityIdToGoalInfo == nil then
        self.mActivityIdToGoalInfo = {}
    end
    local info = self.mActivityIdToGoalInfo[id]
    if info == nil then
        info = clientTableManager.cfg_special_activity_goalsManager:TryGetValue(id)
        self.mActivityIdToGoalInfo[id] = info
    end
    return info
end

--endregion

--region 红点
function UICarnivalPanel:BindRedPoint()
    self:BindSingleRedPoint(LuaEnumCarnivalEventId.Activity, self:GetMissionRed_UIRedPoint())
    self:BindSingleRedPoint(LuaEnumCarnivalEventId.Score, self:GetShopRed_UIRedPoint())
end

function UICarnivalPanel:BindSingleRedPoint(eventId, redPoint)
    local key = "SpecialActivity_" .. eventId
    local redPointKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(key)
    gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager():RemoveLuaCallRedPointFunctionByInt(redPointKey)
    gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(redPointKey, function()
        return self:ShowRedPoint(eventId)
    end)
    self:AddNeedRemoveRedPointKey(redPointKey)
    redPoint:AddRedPointKey(redPointKey)
end

---@return boolean  是否显示红点
function UICarnivalPanel:ShowRedPoint(eventID)
    return gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetSingleActivityState(eventID)
end

---添加红点
function UICarnivalPanel:AddNeedRemoveRedPointKey(intKey)
    if self.mNeedRemoveRedPointKey == nil then
        self.mNeedRemoveRedPointKey = {}
    end
    table.insert(self.mNeedRemoveRedPointKey, intKey)
end

---移除红点
function UICarnivalPanel:ClearAllRedPointKey()
    if self.mNeedRemoveRedPointKey then
        for i = 1, #self.mNeedRemoveRedPointKey do
            gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager():RemoveLuaCallRedPointFunctionByInt(self.mNeedRemoveRedPointKey[i])
        end
    end
end
--endregion

function UICarnivalPanel:HideSelf()
    self:RunBaseFunction("HideSelf")
    self.mCurrentPanelType = nil
end

function ondestroy()
    UICarnivalPanel:ClearAllRedPointKey()
end

return UICarnivalPanel