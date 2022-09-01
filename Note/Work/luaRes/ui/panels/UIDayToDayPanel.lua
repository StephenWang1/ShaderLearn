---每日目标界面
---@class 每日目标:UIBase
local UIDayToDayPanel = {}

--region 变量定义
---有效的活动列表
UIDayToDayPanel.availableActiveTable = {}
---服务器开服天数
UIDayToDayPanel.serverOpenDayNumber = 0
---活跃度奖励宝箱列表
UIDayToDayPanel.activeRewardList = nil
---选择类型
UIDayToDayPanel.selectType = LuaEnumDayToDayPanelType.DayActivity;

UIDayToDayPanel.isShowHuoYue = false;

---@type table<number,UIDayToDayPanel_MissionActivity>
UIDayToDayPanel.missionTemplateDic = {}

---活跃度变动历史(上次的活跃度)
UIDayToDayPanel.mLastActiveNum = 0;

UIDayToDayPanel.mMaxActiveNum = 6;
--endregion

--region 组件
---关闭按钮
function UIDayToDayPanel.GetCloseBtn_GameObject()
    if UIDayToDayPanel.mCloseBtn_GO == nil then
        UIDayToDayPanel.mCloseBtn_GO = UIDayToDayPanel:GetCurComp("WidgetRoot/window/Btn_Close", "GameObject")
    end
    return UIDayToDayPanel.mCloseBtn_GO
end

-----关闭按钮2
--function UIDayToDayPanel.GetCloseBtn2_GameObject()
--    if UIDayToDayPanel.mCloseBtn2_GO == nil then
--        UIDayToDayPanel.mCloseBtn2_GO = UIDayToDayPanel:GetCurComp("WidgetRoot/window2/Btn_Close", "GameObject")
--    end
--    return UIDayToDayPanel.mCloseBtn2_GO
--end

--region Toggle

---活动
--function UIDayToDayPanel.GetTglActivity_GameObject()
--    if UIDayToDayPanel.mTglActivity_GameObject == nil then
--        UIDayToDayPanel.mTglActivity_GameObject = UIDayToDayPanel:GetCurComp("WidgetRoot/events/Btn_activity", "GameObject")
--    end
--    return UIDayToDayPanel.mTglActivity_GameObject
--end

--function UIDayToDayPanel.GetTglActivityBg_GameObject()
--    if UIDayToDayPanel.mTglActivityBg_GameObject == nil then
--        UIDayToDayPanel.mTglActivityBg_GameObject = UIDayToDayPanel:GetCurComp("WidgetRoot/events/Btn_activity/bg", "GameObject")
--    end
--    return UIDayToDayPanel.mTglActivityBg_GameObject
--end

--function UIDayToDayPanel.GetTglActivityLine_UISprite()
--    if (UIDayToDayPanel.mTglActivityLine_UISprite == nil) then
--        UIDayToDayPanel.mTglActivityLine_UISprite = UIDayToDayPanel:GetCurComp("WidgetRoot/events/Btn_activity/line", "UISprite");
--    end
--    return UIDayToDayPanel.mTglActivityLine_UISprite;
--end

---限时
--function UIDayToDayPanel.GetTglLimitTime_GameObject()
--    if UIDayToDayPanel.mTglLimitTime_GameObject == nil then
--        UIDayToDayPanel.mTglLimitTime_GameObject = UIDayToDayPanel:GetCurComp("WidgetRoot/events/Btn_xianshi", "GameObject")
--    end
--    return UIDayToDayPanel.mTglLimitTime_GameObject
--end

--function UIDayToDayPanel.GetTglLimitTimeBg_GameObject()
--    if UIDayToDayPanel.mTglLimitTimeBg_GameObject == nil then
--        UIDayToDayPanel.mTglLimitTimeBg_GameObject = UIDayToDayPanel:GetCurComp("WidgetRoot/events/Btn_xianshi/bg", "GameObject")
--    end
--    return UIDayToDayPanel.mTglLimitTimeBg_GameObject
--end

--function UIDayToDayPanel.GetTglLimitTimeLine_UISprite()
--    if (UIDayToDayPanel.mTglLimitTimeLine_UISprite == nil) then
--        UIDayToDayPanel.mTglLimitTimeLine_UISprite = UIDayToDayPanel:GetCurComp("WidgetRoot/events/Btn_xianshi/line", "UISprite");
--    end
--    return UIDayToDayPanel.mTglLimitTimeLine_UISprite;
--end

---周历
--function UIDayToDayPanel.GetTglWeek_GameObject()
--    if UIDayToDayPanel.mTglWeek_GameObject == nil then
--        UIDayToDayPanel.mTglWeek_GameObject = UIDayToDayPanel:GetCurComp("WidgetRoot/events/Btn_week", "GameObject")
--    end
--    return UIDayToDayPanel.mTglWeek_GameObject
--end

--function UIDayToDayPanel.GetTglWeekBg_GameObject()
--    if UIDayToDayPanel.mTglWeekBg_GameObject == nil then
--        UIDayToDayPanel.mTglWeekBg_GameObject = UIDayToDayPanel:GetCurComp("WidgetRoot/events/Btn_week/bg", "GameObject")
--    end
--    return UIDayToDayPanel.mTglWeekBg_GameObject
--end

--function UIDayToDayPanel.GetTglWeekLine_UISprite()
--    if (UIDayToDayPanel.mTglWeekLine_UISprite == nil) then
--        UIDayToDayPanel.mTglWeekLine_UISprite = UIDayToDayPanel:GetCurComp("WidgetRoot/events/Btn_week/line", "UISprite");
--    end
--    return UIDayToDayPanel.mTglWeekLine_UISprite;
--end
--endregion

---活跃度高光
function UIDayToDayPanel.GetSliderLight_GameObject()
    if UIDayToDayPanel.mSliderLight_GameObject == nil then
        UIDayToDayPanel.mSliderLight_GameObject = UIDayToDayPanel:GetCurComp("WidgetRoot/DailyActivities/HuoYue/ScrollView/slider/light", "GameObject")
    end
    return UIDayToDayPanel.mSliderLight_GameObject;
end

function UIDayToDayPanel.GetSlider_GameObject()
    if UIDayToDayPanel.mSlider_GameObject == nil then
        UIDayToDayPanel.mSlider_GameObject = UIDayToDayPanel:GetCurComp("WidgetRoot/DailyActivities/HuoYue/ScrollView/slider", "GameObject")
    end
    return UIDayToDayPanel.mSlider_GameObject;
end

function UIDayToDayPanel.GetDailyActivities_GameObject()
    if UIDayToDayPanel.mDailyActivities_GameObject == nil then
        UIDayToDayPanel.mDailyActivities_GameObject = UIDayToDayPanel:GetCurComp("WidgetRoot/DailyActivities", "GameObject")
    end
    return UIDayToDayPanel.mDailyActivities_GameObject;
end

--function UIDayToDayPanel.GetBtn_Recycle_GameObject()
--    if UIDayToDayPanel.mBtn_Recycle_GameObject == nil then
--        UIDayToDayPanel.mBtn_Recycle_GameObject = UIDayToDayPanel:GetCurComp("WidgetRoot/DailyActivities/Btn_Recycle", "GameObject")
--    end
--    return UIDayToDayPanel.mBtn_Recycle_GameObject;
--end

function UIDayToDayPanel.GetWindow_GameObject()
    if UIDayToDayPanel.mWindow_GameObject == nil then
        UIDayToDayPanel.mWindow_GameObject = UIDayToDayPanel:GetCurComp("WidgetRoot/window", "GameObject")
    end
    return UIDayToDayPanel.mWindow_GameObject;
end

--function UIDayToDayPanel.GetWindow2_GameObject()
--    if UIDayToDayPanel.mWindow2_GameObject == nil then
--        UIDayToDayPanel.mWindow2_GameObject = UIDayToDayPanel:GetCurComp("WidgetRoot/window2", "GameObject")
--    end
--    return UIDayToDayPanel.mWindow2_GameObject;
--end

--function UIDayToDayPanel.GetBtn_Recycle_UISprite()
--    if UIDayToDayPanel.mBtn_Recycle_UISprite == nil then
--        UIDayToDayPanel.mBtn_Recycle_UISprite = UIDayToDayPanel:GetCurComp("WidgetRoot/DailyActivities/Btn_Recycle/arrow", "UISprite")
--    end
--    return UIDayToDayPanel.mBtn_Recycle_UISprite;
--end

---活跃度格子
function UIDayToDayPanel.GetActivesGrids_UIGridContainer()
    if UIDayToDayPanel.mActivesGrids_UIGridContainer == nil then
        UIDayToDayPanel.mActivesGrids_UIGridContainer = UIDayToDayPanel:GetCurComp("WidgetRoot/DailyActivities/UISkillColumn/Scroll View/Actives", "UIGridContainer")
    end
    return UIDayToDayPanel.mActivesGrids_UIGridContainer
end

function UIDayToDayPanel.GetActiveGrids_UIScrollView()
    if UIDayToDayPanel.mActiveGrids_UIScrollView == nil then
        UIDayToDayPanel.mActiveGrids_UIScrollView = UIDayToDayPanel:GetCurComp("WidgetRoot/DailyActivities/UISkillColumn/Scroll View", "UIScrollView")
    end
    return UIDayToDayPanel.mActiveGrids_UIScrollView
end

---活跃度滑动条背景图片
function UIDayToDayPanel.GetActiveSliderBG_UISprite()
    if UIDayToDayPanel.mActiveSliderBG_UISprite == nil then
        UIDayToDayPanel.mActiveSliderBG_UISprite = UIDayToDayPanel:GetCurComp("WidgetRoot/DailyActivities/HuoYue/ScrollView/slider/frame", "UISprite")
    end
    return UIDayToDayPanel.mActiveSliderBG_UISprite
end

---活跃度滑动条前景图片
function UIDayToDayPanel.GetActiveSliderFG_UISprite()
    if UIDayToDayPanel.mActiveSliderFG_UISprite == nil then
        UIDayToDayPanel.mActiveSliderFG_UISprite = UIDayToDayPanel:GetCurComp("WidgetRoot/DailyActivities/HuoYue/ScrollView/slider/p1", "UISprite")
    end
    return UIDayToDayPanel.mActiveSliderFG_UISprite
end

---@type UISlider
function UIDayToDayPanel.GetActiveSlider_UISlider()
    if UIDayToDayPanel.mActiveSlider_UISlider == nil then
        UIDayToDayPanel.mActiveSlider_UISlider = UIDayToDayPanel:GetCurComp("WidgetRoot/DailyActivities/HuoYue/ScrollView/slider", "UISlider")
    end
    return UIDayToDayPanel.mActiveSlider_UISlider
end

function UIDayToDayPanel.GetMyActive_GameObject()
    if UIDayToDayPanel.mMyActive_GameObject == nil then
        UIDayToDayPanel.mMyActive_GameObject = UIDayToDayPanel:GetCurComp("WidgetRoot/DailyActivities/MyActive", "GameObject")
    end
    return UIDayToDayPanel.mMyActive_GameObject
end

function UIDayToDayPanel.GetMyActiveTitle_GameObject()
    if UIDayToDayPanel.mMyActiveTitle_GameObject == nil then
        UIDayToDayPanel.mMyActiveTitle_GameObject = UIDayToDayPanel:GetCurComp("WidgetRoot/DailyActivities/MyActive/title", "GameObject")
    end
    return UIDayToDayPanel.mMyActiveTitle_GameObject
end

---活跃度数值
function UIDayToDayPanel.GetActiveValueLabel_UILabel()
    if UIDayToDayPanel.mActiveValueLabel_UILabel == nil then
        UIDayToDayPanel.mActiveValueLabel_UILabel = UIDayToDayPanel:GetCurComp("WidgetRoot/DailyActivities/MyActive/value", "UILabel")
    end
    return UIDayToDayPanel.mActiveValueLabel_UILabel
end

---奖励预设
function UIDayToDayPanel.GetRewardPrefab_GO()
    if UIDayToDayPanel.mRewardPrefab_GO == nil then
        UIDayToDayPanel.mRewardPrefab_GO = UIDayToDayPanel:GetCurComp("WidgetRoot/DailyActivities/day/Reward", "GameObject")
    end
    return UIDayToDayPanel.mRewardPrefab_GO
end

function UIDayToDayPanel.GetActiveRewardSpringPanel()
    if (UIDayToDayPanel.mActiveRewardSpringPanel == nil) then
        UIDayToDayPanel.mActiveRewardSpringPanel = UIDayToDayPanel:GetCurComp("WidgetRoot/DailyActivities/HuoYue/ScrollView", "SpringPanel");
    end
    return UIDayToDayPanel.mActiveRewardSpringPanel;
end

---@return UIScrollView
function UIDayToDayPanel:GetActiveReward_ScrollView()
    if (self.mActiveRewardScrollView == nil) then
        self.mActiveRewardScrollView = self:GetCurComp("WidgetRoot/DailyActivities/HuoYue/ScrollView", "UIScrollView");
    end
    return self.mActiveRewardScrollView
end

---@return UIPanel
function UIDayToDayPanel:GetActiveReward_UIPanel()
    if self:GetActiveReward_ScrollView() and self.mActiveUIPanel == nil then
        self.mActiveUIPanel = self:GetActiveReward_ScrollView().panel
        if self.mActiveUIPanel == nil then
            self.mActiveUIPanel = self:GetCurComp("WidgetRoot/DailyActivities/HuoYue/ScrollView", "UIPanel");
        end
    end
    return self.mActiveUIPanel
end

---@type UIGridContainer
function UIDayToDayPanel.GetActiveUIGridContainer()
    if (UIDayToDayPanel.mActiveGridContainer == nil) then
        UIDayToDayPanel.mActiveGridContainer = UIDayToDayPanel:GetCurComp("WidgetRoot/DailyActivities/HuoYue/ScrollView/Huoyue", "UIGridContainer");
    end
    return UIDayToDayPanel.mActiveGridContainer;
end

function UIDayToDayPanel:GetActiveIcon1_UISpriteAnimation()
    if (UIDayToDayPanel.mActiveIcon1_UISpriteAnimation == nil) then
        UIDayToDayPanel.mActiveIcon1_UISpriteAnimation = UIDayToDayPanel:GetCurComp("WidgetRoot/DailyActivities/MyActive/icon", "UISpriteAnimation");
    end
    return UIDayToDayPanel.mActiveIcon1_UISpriteAnimation;
end

function UIDayToDayPanel:GetActiveIcon2_UISpriteAnimation()
    if (UIDayToDayPanel.mActiveIcon2_UISpriteAnimation == nil) then
        UIDayToDayPanel.mActiveIcon2_UISpriteAnimation = UIDayToDayPanel:GetCurComp("WidgetRoot/DailyActivities/MyActive/bigfire", "UISpriteAnimation");
    end
    return UIDayToDayPanel.mActiveIcon2_UISpriteAnimation;
end

function UIDayToDayPanel:GetActiveNum_TweenScale()
    if (UIDayToDayPanel.mActiveNum_TweenScale == nil) then
        UIDayToDayPanel.mActiveNum_TweenScale = UIDayToDayPanel:GetCurComp("WidgetRoot/DailyActivities/MyActive/value", "TweenScale");
    end
    return UIDayToDayPanel.mActiveNum_TweenScale;
end

---周历按钮
--function UIDayToDayPanel.GetOneWeekActivityBtn_GameObject()
--    if UIDayToDayPanel.mOneWeekRewardBtn_GO == nil then
--        UIDayToDayPanel.mOneWeekRewardBtn_GO = UIDayToDayPanel:GetCurComp("WidgetRoot/events/Btn_owa", "GameObject")
--    end
--    return UIDayToDayPanel.mOneWeekRewardBtn_GO
--end

-----周历界面
--function UIDayToDayPanel.GetWeeklyActivityPanelGO_GameObject()
--    if UIDayToDayPanel.mWeeklyActivityPanelGO_GO == nil then
--        UIDayToDayPanel.mWeeklyActivityPanelGO_GO = UIDayToDayPanel:GetCurComp("WidgetRoot/UIOneWeekActive", "GameObject")
--    end
--    return UIDayToDayPanel.mWeeklyActivityPanelGO_GO
--end

---周历
---@return 每日目标周历
--function UIDayToDayPanel.GetWeeklyActivity_Template()
--    if UIDayToDayPanel.mWeeklyActivity_Template == nil then
--        UIDayToDayPanel.mWeeklyActivity_Template = templatemanager.GetNewTemplate(UIDayToDayPanel.GetWeeklyActivityPanelGO_GameObject(), luaComponentTemplates.UIDayToDayPanel_WeeklyActivity)
--    end
--    return UIDayToDayPanel.mWeeklyActivity_Template
--end

function UIDayToDayPanel:GetScrollViewSpringPanel()
    if (self.mScrollViewSpringPanel == nil) then
        self.mScrollViewSpringPanel = UIDayToDayPanel:GetCurComp("WidgetRoot/DailyActivities/UISkillColumn/Scroll View", "SpringPanel");
    end
    return self.mScrollViewSpringPanel;
end

--endregion

--region 初始化
function UIDayToDayPanel:Init()
    UIDayToDayPanel:BindUIEvents()
    UIDayToDayPanel:BindMessages()
    UIDayToDayPanel.mSpringPanelOriginPosition = UIDayToDayPanel:GetScrollViewSpringPanel().gameObject.transform.localPosition;
end

function UIDayToDayPanel:Show(customData)

    UIDayToDayPanel:RunBaseFunction("Show")
    if (customData == nil) then
        customData = {};
    end

    if (customData.type == nil) then
        customData.type = LuaEnumDayToDayPanelType.DayActivity;
    end
    UIDayToDayPanel.selectType = customData.type;

    UIDayToDayPanel.SetShowBySelectType(UIDayToDayPanel.selectType);

    UIDayToDayPanel:InitializeActiveProgress()

    --UIDayToDayPanel.GetWeeklyActivity_Template():SetShowState(false)

    --UIDayToDayPanel.isShowHuoYue = true;
    --
    --UIDayToDayPanel.SetShowActive(UIDayToDayPanel.isShowHuoYue);
    if self:GetActiveReward_UIPanel() then
        self.StartScrollPos = self:GetActiveReward_UIPanel().clipOffset
    end
    self:GetActiveReward_ScrollView().onDragFinished = function()
        self:RefreshRewardBoxPos()
    end
end

---绑定UI事件
function UIDayToDayPanel:BindUIEvents()
    CS.UIEventListener.Get(UIDayToDayPanel.GetCloseBtn_GameObject()).onClick = UIDayToDayPanel.OnCloseBtnClicked
    --CS.UIEventListener.Get(UIDayToDayPanel.GetCloseBtn2_GameObject()).onClick = UIDayToDayPanel.OnCloseBtnClicked
    --CS.UIEventListener.Get(UIDayToDayPanel.GetTglWeek_GameObject()).onClick = UIDayToDayPanel.OnOneWeekActivityButtonClicked
    --CS.UIEventListener.Get(UIDayToDayPanel.GetTglActivity_GameObject()).onClick = UIDayToDayPanel.OnActivityTglClicked
    --CS.UIEventListener.Get(UIDayToDayPanel.GetTglLimitTime_GameObject()).onClick = UIDayToDayPanel.OnLimitTimeTglClicked
    --CS.UIEventListener.Get(UIDayToDayPanel.GetBtn_Recycle_GameObject()).onClick = UIDayToDayPanel.OnClickBtnRecycle

    --UIDayToDayPanel:GetWeeklyActivity_Template():SetActivityClickedCallback(UIDayToDayPanel.OnWeeklyActivityClicked)
    CS.UIEventListener.Get(UIDayToDayPanel.GetMyActive_GameObject()).onClick = function()
        local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(LuaEnumCoinType.ActiveCoin);
        if (isFind) then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable });
        end
    end

    --UIDayToDayPanel.CallOnSetCurDailyTasks = function(msgId, msgData)
    --    UIDayToDayPanel.mCurDailyTasksMission = msgData;
    --end

    --luaEventManager.BindCallback(LuaCEvent.DailyTasks_SetCurTask, UIDayToDayPanel.CallOnSetCurDailyTasks);

    UIDayToDayPanel.CallOnGoToTask = function(msgId, msgData)
        local activeVo = CS.CSScene.MainPlayerInfo.ActiveInfo:GetCurrentActive();
        if activeVo then
            CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForObtainItemByGetWay:DoOperation(msgData.id, activeVo:GetItemGetWayTypeByMissionType());
        end
        --UIDayToDayPanel.GoToDailyTask(msgData.id);
        uimanager:ClosePanel("UIDayToDayPanel")
    end
    UIDayToDayPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Task_GotoTask, UIDayToDayPanel.CallOnGoToTask)

    UIDayToDayPanel.CallOnOpenSaleOreClick = function(msgId, msgData)
        local activeVo = CS.CSScene.MainPlayerInfo.ActiveInfo:GetCurrentActive();
        if activeVo ~= nil and activeVo.mission ~= nil and activeVo.mission.tbl_tasks ~= nil and activeVo.mission.tbl_tasks.subtype ~= 0 then
            --uimanager:CreatePanel("UISaleOrePanel", nil, { isopenBag = false, type = UIDayToDayPanel.mCurDailyTasksMission.tbl_tasks.subtype  })
            Utility.TryDoDailyTask(activeVo.mission, { buttonType = LuaEnumDailyTaskButtonType.Store });
        end
        uimanager:ClosePanel("UIDayToDayPanel");
    end
    UIDayToDayPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Task_BuyItem, UIDayToDayPanel.CallOnOpenSaleOreClick)
end

---绑定网络事件
function UIDayToDayPanel:BindMessages()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResActiveDataMessage, UIDayToDayPanel.OnResActiveDataMessageReceived)
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.ResBagChangeMessage, UIDayToDayPanel.RefreshMissionTemplat);

    UIDayToDayPanel:GetClientEventHandler():AddEvent(CS.CEvent.Task_GoalUpdate, UIDayToDayPanel.RefreshMissionTemplat)
    --自动任务
    UIDayToDayPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_AutoDoMission, UIDayToDayPanel.RefreshMissionTemplat)
    --完成任务消息
    UIDayToDayPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_CompleteTask, UIDayToDayPanel.RefreshMissionTemplat)
    UIDayToDayPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_UpDateTaskSchedule, UIDayToDayPanel.RefreshMissionTemplat)
    UIDayToDayPanel.CallUpdateActive = function(msgId, msgData)
        UIDayToDayPanel.RefreshActiveProgress();
    end
    UIDayToDayPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_OnActiveNumChange, UIDayToDayPanel.CallUpdateActive)

    UIDayToDayPanel.CallOnCurrentActiveChange = function(msgId, msgData)
        --local currentActiveVo = CS.CSScene.MainPlayerInfo.ActiveInfo:GetCurrentActive();
        for k, v in pairs(UIDayToDayPanel.missionTemplateDic) do
            v:UpdateChooseEffect();
        end
    end
    UIDayToDayPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_OnCurrentActiveChange, UIDayToDayPanel.CallOnCurrentActiveChange)
end
--endregion

--region UI事件
---关闭按钮点击事件
function UIDayToDayPanel.OnCloseBtnClicked()
    uimanager:ClosePanel("UIDayToDayPanel")
end

---奖励宝箱点击事件
---@param rewardBox table 奖励宝箱
---@param go GameObject
function UIDayToDayPanel.OnRewardBoxClicked(rewardBox, target)
    --print("奖励宝箱点击事件  宝箱ID: " .. tostring(rewardBox.rewardData.id))
    if rewardBox then
        local state = CS.CSScene.MainPlayerInfo.ActiveInfo:GetRewardState(rewardBox.rewardData.id)
        if rewardBox.isAbleToObtain then
            if rewardBox.rewardData then
                ---如果背包已满 弹出气泡
                if CS.CSScene.MainPlayerInfo ~= nil then
                    --- 检查是否可以向背包中添加物品
                    if not CS.CSScene.MainPlayerInfo.BagInfo:CheckIsAbleToAddItem(rewardBox.itemInfo) then
                        local icon = rewardBox:GetIconSprite_UISprite()
                        if icon ~= nil and not CS.StaticUtility.IsNull(icon.gameObject) then
                            Utility.ShowPopoTips(icon.gameObject, nil, 408, "UIDayToDayPanel")
                        end
                        return
                    end
                end

                networkRequest.ReqGetActiveRewards(rewardBox.rewardData.id)
                if target ~= nil and luaEventManager.HasCallback(LuaCEvent.Effect_FlyItemIcon) then
                    luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = rewardBox.getItemId, from = target.transform.position })
                end
            end
        else
            if rewardBox.itemInfo then
                if (not state) then
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = rewardBox.itemInfo, showRight = false })
                end
            end
        end
    end
end

---参加活动按钮点击事件
---@param activeData TABLE.ACTIVE
function UIDayToDayPanel.OnJoinActivityButtonClicked(activeData, mission)
    if activeData then
        local activeInfo = CS.CSScene.MainPlayerInfo.ActiveInfo:GetProgress(activeData.id);

        local activeState = CS.CSScene.MainPlayerInfo.ActiveInfo:GetActiveState(activeData.id)
        if activeState == 2 then
            if UIDayToDayPanel.DoActiveActivity(activeData, mission) then
                uimanager:ClosePanel("UIDayToDayPanel")
            end
            return
        end

        if CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:IsAnyPathToMainCityInCurrentMap() == false then
            ---不能前往主城时,不做活跃度,而是先回到主城再做活跃度任务
            CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:TryPauseOperation(function()
                UIDayToDayPanel.OnJoinActivityButtonClicked(activeData, mission)
            end)
        else
            if UIDayToDayPanel.DoActiveActivity(activeData, mission) then
                uimanager:ClosePanel("UIDayToDayPanel")
            else
            end
        end
    end
end

---根据界面打开类型显示UI
---@param selectType LuaEnumDayToDayPanelType
function UIDayToDayPanel.SetShowBySelectType(selectType)
    if (selectType == LuaEnumDayToDayPanelType.DayActivity) then
        UIDayToDayPanel.RefreshDailyActivities()
    end
end

--function UIDayToDayPanel.OnClickBtnRecycle()
--    UIDayToDayPanel.isShowHuoYue = not UIDayToDayPanel.isShowHuoYue;
--    UIDayToDayPanel.SetShowActive(UIDayToDayPanel.isShowHuoYue);
--
--end

--function UIDayToDayPanel.SetShowActive(isShow)
--    --UIDayToDayPanel.GetBtn_Recycle_UISprite().spriteName = isShow and "open2" or "open1";
--    UIDayToDayPanel.SetActiveRewardActive(isShow);
--    --UIDayToDayPanel.GetWindow2_GameObject():SetActive(not isShow);
--    UIDayToDayPanel.GetWindow_GameObject():SetActive(isShow);
--end

---周历按钮点击事件
--function UIDayToDayPanel.OnOneWeekActivityButtonClicked()
--    UIDayToDayPanel.selectType = LuaEnumDayToDayPanelType.Week;
--    --UIDayToDayPanel.GetWeeklyActivity_Template():SetShowState(true);
--    --if UIDayToDayPanel.GetWeeklyActivity_Template():GetShowState() then
--    --    UIDayToDayPanel.GetWeeklyActivity_Template():Refresh()
--    --end
--    UIDayToDayPanel.SetActiveRewardActive(false);
--    UIDayToDayPanel.GetTglActivityBg_GameObject():SetActive(true);
--    UIDayToDayPanel.GetTglLimitTimeBg_GameObject():SetActive(true);
--    UIDayToDayPanel.GetTglWeekBg_GameObject():SetActive(false);
--
--    UIDayToDayPanel.GetDailyActivities_GameObject():SetActive(false);
--
--    UIDayToDayPanel.GetWindow_GameObject():SetActive(true);
--    UIDayToDayPanel.GetWindow2_GameObject():SetActive(false);
--
--    UIDayToDayPanel.GetTglActivityLine_UISprite().spriteName = "unchoose";
--    UIDayToDayPanel.GetTglLimitTimeLine_UISprite().spriteName = "unchoose";
--    UIDayToDayPanel.GetTglWeekLine_UISprite().spriteName = "chcir";
--end

---活动按钮点击事件
--function UIDayToDayPanel.OnActivityTglClicked()
--    UIDayToDayPanel.selectType = LuaEnumDayToDayPanelType.DayActivity;
--    UIDayToDayPanel.GetActiveGrids_UIScrollView():ResetPosition();
--    UIDayToDayPanel.RefreshDailyActivities();
--    UIDayToDayPanel.GetDailyActivities_GameObject():SetActive(true);
--    UIDayToDayPanel.GetWeeklyActivity_Template():SetShowState(false);
--
--    UIDayToDayPanel.GetTglActivityBg_GameObject():SetActive(false);
--    UIDayToDayPanel.GetTglLimitTimeBg_GameObject():SetActive(true);
--    UIDayToDayPanel.GetTglWeekBg_GameObject():SetActive(true);
--
--    UIDayToDayPanel.GetDailyActivities_GameObject():SetActive(true);
--    UIDayToDayPanel.SetShowActive(UIDayToDayPanel.isShowHuoYue);
--
--    UIDayToDayPanel.GetTglActivityLine_UISprite().spriteName = "chcir";
--    UIDayToDayPanel.GetTglLimitTimeLine_UISprite().spriteName = "unchoose";
--    UIDayToDayPanel.GetTglWeekLine_UISprite().spriteName = "unchoose";
--end

---限时按钮点击事件
--function UIDayToDayPanel.OnLimitTimeTglClicked()
--    UIDayToDayPanel.selectType = LuaEnumDayToDayPanelType.LimitTime;
--    UIDayToDayPanel.GetActiveGrids_UIScrollView():ResetPosition();
--    UIDayToDayPanel.RefreshDailyLimitTime();
--    UIDayToDayPanel.GetDailyActivities_GameObject():SetActive(true);
--    UIDayToDayPanel.GetWeeklyActivity_Template():SetShowState(false);
--
--    UIDayToDayPanel.GetTglActivityBg_GameObject():SetActive(true);
--    --UIDayToDayPanel.GetTglLimitTimeBg_GameObject():SetActive(false);
--    UIDayToDayPanel.GetTglWeekBg_GameObject():SetActive(true);
--
--    UIDayToDayPanel.GetDailyActivities_GameObject():SetActive(true);
--    UIDayToDayPanel.SetShowActive(true);
--
--    --UIDayToDayPanel.GetTglActivityLine_UISprite().spriteName = "unchoose";
--    --UIDayToDayPanel.GetTglLimitTimeLine_UISprite().spriteName = "chcir";
--    --UIDayToDayPanel.GetTglWeekLine_UISprite().spriteName = "unchoose";
--end

---周历活动点击事件
---@param activeData TABLE.ACTIVE 活跃度活动数据
---@param isRightWeekDay boolean 是否为正确的星期
--function UIDayToDayPanel.OnWeeklyActivityClicked(activeData, isRightWeekDay)
--    if activeData then
--        if isRightWeekDay and UIDayToDayPanel.IsActivityCanParticipate(activeData) then
--            --若星期正确,点击后参加活动
--            uimanager:CreatePanel("UIActiveTipPanel", nil, activeData, function()
--                UIDayToDayPanel.OnJoinActivityButtonClicked(activeData)
--            end)
--        else
--            --若星期不正确,点击后弹出界面
--            uimanager:CreatePanel("UIActiveTipPanel", nil, activeData)
--        end
--    end
--end
--endregion

--region 网络事件
---接收到活跃度数据更新事件
function UIDayToDayPanel.OnResActiveDataMessageReceived(id, data)
    ---刷新活跃度信息
    --UIDayToDayPanel.RefreshActiveProgress()

    ----刷新奖励箱子
    UIDayToDayPanel.RefreshRewardBoxs()

    if (UIDayToDayPanel.selectType == LuaEnumDayToDayPanelType.DayActivity) then
        UIDayToDayPanel.RefreshDailyActivities();
    end
end
--endregion

--function UIDayToDayPanel.SetActiveRewardActive(isActive)
--    UIDayToDayPanel.GetActiveUIGridContainer().gameObject:SetActive(isActive);
--    UIDayToDayPanel.GetSlider_GameObject():SetActive(isActive);
--    UIDayToDayPanel.GetMyActiveTitle_GameObject():SetActive(isActive);
--end

--region 刷新每日目标
---刷新每日活动
function UIDayToDayPanel.RefreshDailyActivities()
    UIDayToDayPanel.RefreshJudgeParameter()
    UIDayToDayPanel.availableActiveTable = {}
    local activeTableMgr = CS.Cfg_ActiveTableManager.Instance.dic

    CS.Utility_Lua.luaForeachCsharp:Foreach(activeTableMgr, function(k, v)
        if (CS.CSScene.MainPlayerInfo ~= nil) then
            local stateCode = CS.CSScene.MainPlayerInfo.ActiveInfo:GetActiveState(v.id)
            --if (stateCode ~= 3) then
            table.insert(UIDayToDayPanel.availableActiveTable, v);
            --end
        else
            table.insert(UIDayToDayPanel.availableActiveTable, v);
        end
    end)

    table.insert(UIDayToDayPanel.availableActiveTable, { id = -1 });

    UIDayToDayPanel.UpdateSortOrder();

    table.sort(UIDayToDayPanel.availableActiveTable, UIDayToDayPanel.SortRule)

    UIDayToDayPanel.GetActivesGrids_UIGridContainer().MaxCount = Utility.GetTableCount(UIDayToDayPanel.availableActiveTable);

    local index = 0;
    for k_1, v_1 in pairs(UIDayToDayPanel.availableActiveTable) do
        local go = UIDayToDayPanel.GetActivesGrids_UIGridContainer().controlList[index];
        if UIDayToDayPanel.missionTemplateDic[go] == nil then
            UIDayToDayPanel.missionTemplateDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIDayToDayPanel_MissionActivity)
        end

        UIDayToDayPanel.missionTemplateDic[go]:RefreshData(v_1, index);
        UIDayToDayPanel.missionTemplateDic[go]:SetJoinButtonClickedCallback(UIDayToDayPanel.OnJoinActivityButtonClicked)
        index = index + 1;
    end

    --region 跳转到对应单元
    local currentActiveVo = CS.CSScene.MainPlayerInfo.ActiveInfo:GetCurrentActive();
    if (currentActiveVo ~= nil) then
        local originPosition = UIDayToDayPanel.mSpringPanelOriginPosition;
        if (originPosition ~= nil) then
            local index = 0;
            for k, v in pairs(UIDayToDayPanel.availableActiveTable) do
                if (v.id == currentActiveVo.id) then
                    break ;
                end
                index = index + 1;
            end
            index = index > UIDayToDayPanel.GetActivesGrids_UIGridContainer().MaxCount - 4 and UIDayToDayPanel.GetActivesGrids_UIGridContainer().MaxCount - 4 or index;
            index = index < 4 and 0 or index;
            local addY = index * UIDayToDayPanel.GetActivesGrids_UIGridContainer().CellHeight;
            UIDayToDayPanel:GetScrollViewSpringPanel().target = CS.UnityEngine.Vector3(originPosition.x, originPosition.y + addY, originPosition.z);
            UIDayToDayPanel:GetScrollViewSpringPanel().enabled = true;
        end
    end
    --endregion
end

function UIDayToDayPanel.IsComplete(activeData)
    return CS.CSScene.MainPlayerInfo.ActiveInfo:IsComplete(activeData);
end

function UIDayToDayPanel.GetActiveInfo()
    if (UIDayToDayPanel.mActiveInfo == nil) then
        UIDayToDayPanel.mActiveInfo = CS.CSScene.MainPlayerInfo.ActiveInfo;
    end
    return UIDayToDayPanel.mActiveInfo;
end

function UIDayToDayPanel.UpdateSortOrder()
    UIDayToDayPanel.mSortOrderDic = {};
    if (UIDayToDayPanel.availableActiveTable ~= nil) then
        for k, v in pairs(UIDayToDayPanel.availableActiveTable) do
            if (v.id == -1) then
                UIDayToDayPanel.mSortOrderDic[v.id] = UIDayToDayPanel:GetSortOrder(-1, v.id);
            else
                local aState = UIDayToDayPanel.GetActiveInfo():GetActiveState(v.id);
                UIDayToDayPanel.mSortOrderDic[v.id] = UIDayToDayPanel:GetSortOrder(aState, v.id);
            end
        end
    end
end

function UIDayToDayPanel.SortRule(a, b)
    local aSortValue = UIDayToDayPanel.mSortOrderDic[a.id];
    local bSortValue = UIDayToDayPanel.mSortOrderDic[b.id];

    if (aSortValue == bSortValue) then
        return CS.CSScene.MainPlayerInfo.ActiveInfo:GetActiveSortOrder(a.id) < CS.CSScene.MainPlayerInfo.ActiveInfo:GetActiveSortOrder(b.id);
    else
        return aSortValue < bSortValue;
    end
end

function UIDayToDayPanel:GetSortOrder(stateCode, id)

    if (id < 0) then
        return 7;
    end

    if (stateCode == 2) then
        --可领活跃度
        return 1
    elseif (stateCode == 1) then
        --可领任务奖励
        return 2
    elseif (stateCode == 4) then
        --可提交任务
        return 3
    elseif (stateCode == 5) then
        --可买任务
        return 10
    elseif (stateCode == 3) then
        --已完成
        return 99
    end

    local activeVo = UIDayToDayPanel.GetActiveInfo():GetProgress(id);
    if (activeVo ~= nil) then
        if (activeVo.completeCount >= activeVo.activeTable.secondStateTime) then
            return 6;
        end
    end

    return 5;
end

---刷新限时
--function UIDayToDayPanel.RefreshDailyLimitTime()
--    print("刷新限时活动")
--    UIDayToDayPanel.RefreshJudgeParameter()
--    UIDayToDayPanel.availableActiveTable = {}
--    local activeTableMgr = CS.Cfg_ActiveTableManager.Instance
--    local type = 2; ---限时
--    UIDayToDayPanel.availableActiveTable[type] = {};
--    for i, v in pairs(activeTableMgr) do
--        if UIDayToDayPanel.IsActivityShowAvailable(v) and v.type == type then
--            table.insert(UIDayToDayPanel.availableActiveTable[type], v)
--        end
--    end
--    UIDayToDayPanel.GetActivesGrids_UIGridContainer().MaxCount = #UIDayToDayPanel.availableActiveTable[type]
--    for i = 0, UIDayToDayPanel.GetActivesGrids_UIGridContainer().controlList.Count - 1 do
--        ---@type 每日目标活动
--        local dailyActiveTemplate = templatemanager.GetNewTemplate(UIDayToDayPanel.GetActivesGrids_UIGridContainer().controlList[i], luaComponentTemplates.UIDayToDayPanel_DailyActivity)
--        dailyActiveTemplate:RefreshData(UIDayToDayPanel.availableActiveTable[type][i + 1], i)
--        dailyActiveTemplate:SetJoinButtonClickedCallback(UIDayToDayPanel.OnJoinActivityButtonClicked)
--    end
--end
--endregion

--region 刷新活跃度进度
---初始化活跃度进度
function UIDayToDayPanel.InitializeActiveProgress()
    UIDayToDayPanel.InitializeRewards()
    UIDayToDayPanel.InitActiveProgress()
end

---初始化奖励
function UIDayToDayPanel.InitializeRewards()
    local gridContainer = UIDayToDayPanel.GetActiveUIGridContainer();
    gridContainer.MaxCount = CS.Cfg_Active_RewardTableManager.Instance.dic.Count;
    local index = 0;
    if (UIDayToDayPanel.activeRewardList == nil) then
        UIDayToDayPanel.activeRewardList = {};
    end

    local targetIndex = -1;

    CS.Utility_Lua.luaForeachCsharp:Foreach(CS.Cfg_Active_RewardTableManager.Instance.dic, function(k, v)
        local rewardGO = gridContainer.controlList[index];
        if (UIDayToDayPanel.activeRewardList[rewardGO] == nil) then
            UIDayToDayPanel.activeRewardList[rewardGO] = templatemanager.GetNewTemplate(rewardGO, luaComponentTemplates.UIDayToDayPanel_ActiveRewardBox)
        end
        UIDayToDayPanel.activeRewardList[rewardGO]:SetData(v)
        --temp:SetPosition(minRelativePos, maxRelativePos)
        UIDayToDayPanel.activeRewardList[rewardGO]:SetClickCallback(UIDayToDayPanel.OnRewardBoxClicked)

        if (targetIndex < 0) then
            if (UIDayToDayPanel.activeRewardList[rewardGO]:GetIsObtained()) then
                targetIndex = index;
            end
        end
        index = index + 1;
    end)

    if (targetIndex >= 0) then
        local maxIndex = gridContainer.MaxCount - UIDayToDayPanel.mMaxActiveNum;
        targetIndex = targetIndex > maxIndex and maxIndex or targetIndex;
        local x = gridContainer.CellWidth * targetIndex;
        UIDayToDayPanel.GetActiveRewardSpringPanel().target = CS.UnityEngine.Vector3(-x, 0, 0);
        UIDayToDayPanel.GetActiveRewardSpringPanel().enabled = true;
    end
end

function UIDayToDayPanel.InitActiveProgress()
    --刷新活跃度文字
    UIDayToDayPanel.GetActiveValueLabel_UILabel().text = CS.CSScene.MainPlayerInfo.ActiveInfo:GetActiveNumber()

    local value = UIDayToDayPanel.SetActiveProgressSliderBG(CS.CSScene.MainPlayerInfo.ActiveInfo:GetActiveNumber(), CS.Cfg_Active_RewardTableManager.Instance.MaxActiveNumber);
    UIDayToDayPanel.mLastActiveNum = CS.CSScene.MainPlayerInfo.ActiveInfo:GetActiveNumber();
    UIDayToDayPanel.SetActiveProgress(value);
end

---刷新活跃度进度
function UIDayToDayPanel.RefreshActiveProgress()
    --刷新活跃度文字
    UIDayToDayPanel.GetActiveValueLabel_UILabel().text = CS.CSScene.MainPlayerInfo.ActiveInfo:GetActiveNumber()
    ----刷新奖励箱子
    UIDayToDayPanel.RefreshRewardBoxs()
    --设置活跃度进度条
    UIDayToDayPanel.DynamicSettingActiveProgressSlider(CS.CSScene.MainPlayerInfo.ActiveInfo:GetActiveNumber(), CS.Cfg_Active_RewardTableManager.Instance.MaxActiveNumber)
    UIDayToDayPanel:GetActiveNum_TweenScale():SetOnFinished(UIDayToDayPanel.OnActiveNumTweenScaleFinished);
    UIDayToDayPanel:GetActiveNum_TweenScale():Play();
    UIDayToDayPanel:GetActiveIcon1_UISpriteAnimation().gameObject:SetActive(false);
    UIDayToDayPanel:GetActiveIcon2_UISpriteAnimation().gameObject:SetActive(true);
    UIDayToDayPanel:GetActiveIcon2_UISpriteAnimation():Play();
    UIDayToDayPanel:GetActiveIcon2_UISpriteAnimation().OnFinish = function()
        if (not CS.StaticUtility.IsNull(UIDayToDayPanel:GetActiveIcon1_UISpriteAnimation())) then
            UIDayToDayPanel:GetActiveIcon1_UISpriteAnimation().gameObject:SetActive(true);
            UIDayToDayPanel:GetActiveIcon2_UISpriteAnimation().gameObject:SetActive(false);
        end
    end
end

function UIDayToDayPanel.OnActiveNumTweenScaleFinished()
    UIDayToDayPanel:GetActiveNum_TweenScale():RemoveOnFinished(UIDayToDayPanel.OnActiveNumTweenScaleFinished);
    UIDayToDayPanel:GetActiveNum_TweenScale():PlayReverse();
end

---刷新奖励箱子
function UIDayToDayPanel.RefreshRewardBoxs()
    local targetIndex = -1;
    local gridContainer = UIDayToDayPanel.GetActiveUIGridContainer();
    if (gridContainer.MaxCount > 0) then
        for i = 0, gridContainer.MaxCount - 1 do
            local gobj = gridContainer.controlList[i];
            if (UIDayToDayPanel.activeRewardList[gobj] == nil) then
                UIDayToDayPanel.activeRewardList[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIDayToDayPanel_ActiveRewardBox)
            end
            UIDayToDayPanel.activeRewardList[gobj]:Refresh();
            --if(targetIndex < 0) then
            --    if(UIDayToDayPanel.activeRewardList[gobj]:GetIsObtained()) then
            --        targetIndex = i;
            --    end
            --end
        end
    end

    --if(targetIndex >= 0)then
    --    local maxIndex = gridContainer.MaxCount - 6;
    --    targetIndex = targetIndex > maxIndex and maxIndex or targetIndex;
    --    local x = gridContainer.CellWidth * targetIndex;
    --    UIDayToDayPanel.GetActiveRewardSpringPanel().target = CS.UnityEngine.Vector3(-x, 0, 0);
    --    UIDayToDayPanel.GetActiveRewardSpringPanel().enabled = true;
    --end
end

---设置活跃度进度滑动条
---@param count 进度值
---@param maxCount 最大值
function UIDayToDayPanel.DynamicSettingActiveProgressSlider(count, maxCount)

    count = count > maxCount and maxCount or count
    UIDayToDayPanel.SetActiveProgressSliderBG(count, maxCount)

    if (UIDayToDayPanel.mCoroutineUpdateActiveProgress ~= nil) then
        StopCoroutine(UIDayToDayPanel.mCoroutineUpdateActiveProgress);
        UIDayToDayPanel.mCoroutineUpdateActiveProgress = nil;
        --UIDayToDayPanel.SetActiveProgress(count / maxCount);
    end
    UIDayToDayPanel.mCoroutineUpdateActiveProgress = StartCoroutine(UIDayToDayPanel.CUpdateActiveProgress, count, maxCount, 0.5);
end

function UIDayToDayPanel.SetActiveProgressSliderBG(count, maxCount)
    if maxCount and count then
        if count < 0 then
            count = 0
        end
        if count > maxCount then
            count = maxCount
        end
        if count <= 0 then
            UIDayToDayPanel.GetActiveSliderFG_UISprite().gameObject:SetActive(false);
        else
            UIDayToDayPanel.GetActiveSliderFG_UISprite().gameObject:SetActive(true);
        end
    end

    local value = count / maxCount;
    --UIDayToDayPanel.GetSliderLight_GameObject():SetActive(value > 0.09);
    local width = UIDayToDayPanel.GetActiveSliderBG_UISprite().localSize.x;
    local x = UIDayToDayPanel.GetActiveSliderBG_UISprite().transform.localPosition.x + value * width;
    --local y = UIDayToDayPanel.GetSliderLight_GameObject().transform.localPosition.y;
    --local z = UIDayToDayPanel.GetSliderLight_GameObject().transform.localPosition.z;
    --UIDayToDayPanel.GetSliderLight_GameObject().transform.localPosition = CS.UnityEngine.Vector3(x, y, z);
    return value;
end

function UIDayToDayPanel.SetActiveProgress(value)
    UIDayToDayPanel.GetActiveSliderFG_UISprite().gameObject:SetActive(true)
    local interval = 75;
    local width = UIDayToDayPanel.GetActiveSliderBG_UISprite().width + interval;
    local otherValue = interval / width;
    local targetValue = value - otherValue < 0 and 0 or value - otherValue;
    local targetWidth = width * targetValue;
    UIDayToDayPanel.GetActiveSliderFG_UISprite().width = math.ceil(targetWidth);
end

function UIDayToDayPanel.CUpdateActiveProgress(targetValue, maxValue, time)
    local interval = targetValue - UIDayToDayPanel.mLastActiveNum;
    local value = UIDayToDayPanel.mLastActiveNum == nil and 0 or UIDayToDayPanel.mLastActiveNum;
    UIDayToDayPanel.mLastActiveNum = targetValue;
    if (interval > 0) then
        while (value < targetValue) do
            coroutine.yield(0);
            local num = time / CS.UnityEngine.Time.deltaTime;
            local unit = interval / num;
            value = value + unit;
            UIDayToDayPanel.SetActiveProgress(value / maxValue);
        end
        UIDayToDayPanel.SetActiveProgress(targetValue / maxValue);
    end
end
--endregion

--region 活跃度选项显示判断
---刷新判断使用的变量,如开服天数等
function UIDayToDayPanel.RefreshJudgeParameter()
    UIDayToDayPanel.serverOpenDayNumber = ternary(CS.CSScene.MainPlayerInfo.openServerDays == nil, 0, CS.CSScene.MainPlayerInfo.openServerDays)
end

function UIDayToDayPanel.GoToDailyTask(itemId)

    local activeVo = CS.CSScene.MainPlayerInfo.ActiveInfo:GetCurrentActive();
    if activeVo == nil or activeVo.mission == nil then
        return
    end
    if itemId ~= nil then
        activeVo.mission:SetTaskTarget(itemId)
    end
    CS.CSMissionManager.Instance.TaskFindItemID = itemId;
    CS.CSMissionManager.Instance:FindTaskTarget(activeVo.mission, true)
    uimanager:ClosePanel("UIDayToDayPanel")
end

--region 完成活跃度活动
---@param activeData TABLE.ACTIVE
---@return boolean 是否关闭本界面
function UIDayToDayPanel.DoActiveActivity(activeData, mission)
    return Utility.TryDoMainPlayerActive(activeData, mission)
end

--endregion

--endregion

--region 任务刷新

function UIDayToDayPanel.RefreshMissionTemplat()
    if UIDayToDayPanel.selectType ~= LuaEnumDayToDayPanelType.DayActivity then
        return
    end
    UIDayToDayPanel.RefreshDailyActivities()
end


--endregion

---初始化奖励
function UIDayToDayPanel:RefreshRewardBoxPos()
    ---@type UIGridContainer
    local gridContainer = UIDayToDayPanel.GetActiveUIGridContainer();
    if CS.StaticUtility.IsNull(gridContainer) or self.StartScrollPos == nil then
        return
    end
    local maxCell = gridContainer.controlList.Count
    local cellWidth = gridContainer.CellWidth
    local offset = self:GetActiveReward_UIPanel().clipOffset - self.StartScrollPos
    local index = math.floor((offset.x + cellWidth / 2) / cellWidth)
    local x = cellWidth * index
    local pos = self:GetActiveReward_ScrollView().transform.localPosition
    pos.x = -x
    self:GetActiveReward_ScrollView():Begin(pos, 10)
end

--region ondestroy
function ondestroy()

    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBagChangeMessage, UIDayToDayPanel.RefreshMissionTemplat);
    --luaEventManager.RemoveCallback(LuaCEvent.DailyTasks_SetCurTask, UIDayToDayPanel.CallOnSetCurDailyTasks);

    if (UIDayToDayPanel.mCoroutineUpdateActiveProgress ~= nil) then
        StopCoroutine(UIDayToDayPanel.mCoroutineUpdateActiveProgress);
        UIDayToDayPanel.mCoroutineUpdateActiveProgress = nil;
    end
end
--endregion

return UIDayToDayPanel