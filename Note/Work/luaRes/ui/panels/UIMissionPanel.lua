---@class UIMissionPanel:UIBase
local UIMissionPanel = {}

UIMissionPanel.QuickTeam = nil
UIMissionPanel.QuickTeamTip = nil
UIMissionPanel.IsShow = true
UIMissionPanel.PanelLayerType = CS.UILayerType.BasicPlane
UIMissionPanel.isMonsterArrestShow = false
UIMissionPanel.isActiveShow = false

---组队按钮图片
function UIMissionPanel.Btn_team_GameObject()
    if UIMissionPanel.mBtn_team == nil then
        UIMissionPanel.mBtn_team = UIMissionPanel:GetCurComp("WidgetRoot/Root/btn_team", "GameObject")
    end
    return UIMissionPanel.mBtn_team
end

function UIMissionPanel.GetTglTeam_UIToggle()
    if (UIMissionPanel.mTglTeam_UIToggle == nil) then
        UIMissionPanel.mTglTeam_UIToggle = CS.Utility_Lua.GetComponent(UIMissionPanel.Btn_mission_GameObject(), "UIToggle")
    end
    return UIMissionPanel.mTglTeam_UIToggle;
end

--任务按钮图片
function UIMissionPanel.Btn_mission_GameObject()
    if UIMissionPanel.mBtn_mission == nil then
        UIMissionPanel.mBtn_mission = UIMissionPanel:GetCurComp("WidgetRoot/Root/btn_mission", "GameObject")
    end
    return UIMissionPanel.mBtn_mission
end

function UIMissionPanel.GetTglMission_UIToggle()
    if (UIMissionPanel.mTglMission_UIToggle == nil) then
        UIMissionPanel.mTglMission_UIToggle = CS.Utility_Lua.GetComponent(UIMissionPanel.Btn_mission_GameObject(), "UIToggle")
    end
    return UIMissionPanel.mTglMission_UIToggle;
end

function UIMissionPanel.GetPanelScrollView()
    if (UIMissionPanel.mPanelScrollView == nil) then
        UIMissionPanel.mPanelScrollView = UIMissionPanel:GetCurComp("WidgetRoot/Root/MsiionPanel", "UIScrollView");
    end
    return UIMissionPanel.mPanelScrollView;
end

function UIMissionPanel.MsiionPanel()
    if (UIMissionPanel.mMsiionPanel == nil) then
        UIMissionPanel.mMsiionPanel = UIMissionPanel:GetCurComp("WidgetRoot/Root/MsiionPanel", "UIPanel");
    end
    return UIMissionPanel.mMsiionPanel;
end

function UIMissionPanel:Init()
    ---缩进按钮
    UIMissionPanel.btn_jiantou = self:GetCurComp("WidgetRoot/Root/btn_jiantou", "Top_TweenPosition")
    ---缩进按钮图片
    UIMissionPanel.btn_jiantou_Sprite = self:GetCurComp("WidgetRoot/Root/btn_jiantou/Sprite", "Transform")

    UIMissionPanel.root = self:GetCurComp("WidgetRoot/Root", "GameObject")

    UIMissionPanel.doTaskTip = self:GetCurComp("WidgetRoot/Root/MsiionPanel/MsiionList/DoTaskTip", "GameObject")
    UIMissionPanel.doDailyTaskTip = self:GetCurComp("WidgetRoot/Root/MsiionPanel/MsiionList/DoDailyTaskTip", "GameObject")
    UIMissionPanel.doMonsterTaskTip = self:GetCurComp("WidgetRoot/Root/MsiionPanel/MsiionList/DoMonsterTaskTip", "GameObject")

    UIMissionPanel.MissionBg = self:GetCurComp("WidgetRoot/Root/MissionBg", "GameObject")
    CS.UIEventListener.Get(UIMissionPanel.btn_jiantou.gameObject).onClick = UIMissionPanel.OnClinkFoldBtn

    CS.UIEventListener.Get(UIMissionPanel.Btn_team_GameObject()).onClick = UIMissionPanel.OnClinkTeam
    CS.UIEventListener.Get(UIMissionPanel.Btn_mission_GameObject()).onClick = UIMissionPanel.OnClinkMission
    ---@type UIQuickTeamTemplate
    UIMissionPanel.QuickTeam = templatemanager.GetNewTemplate(UIMissionPanel:GetCurComp("WidgetRoot/Root/MsiionPanel/TeamList", "GameObject"), luaComponentTemplates.UIQuickTeamTemplate)
    UIMissionPanel.QuickTeamTip = templatemanager.GetNewTemplate(UIMissionPanel:GetCurComp("WidgetRoot/Root/NewTips", "GameObject"), luaComponentTemplates.UITeamTipTemplate)
    UIMissionPanel.QuickTeamChild = UIMissionPanel:GetCurComp("WidgetRoot/Root/MsiionPanel/child", "GameObject")

    UIMissionPanel.OnResGroupDetailedInfoMessage = function(msgId, msgData)
        UIMissionPanel.QuickTeam.OnResGroupDetailedInfoMessage(msgId, msgData);
    end

    UIMissionPanel:GetSocketEventHandler():AddEvent(LuaEnumNetDef.ResGroupDetailedInfoMessage, UIMissionPanel.OnResGroupDetailedInfoMessage)
    UIMissionPanel:GetSocketEventHandler():AddEvent(LuaEnumNetDef.ResShareGroupDetailedInfoMessage, UIMissionPanel.OnResGroupDetailedInfoMessage)

    UIMissionPanel.OnResLeaveTeamMessage = function(msgId, msgData)
        UIMissionPanel.QuickTeam.OnResLeaveTeamMessage(msgId, msgData)
    end
    UIMissionPanel:GetSocketEventHandler():AddEvent(LuaEnumNetDef.ResLeaveTeamMessage, UIMissionPanel.OnResLeaveTeamMessage)
    UIMissionPanel:GetSocketEventHandler():AddEvent(LuaEnumNetDef.ResShareLeaveTeamMessage, UIMissionPanel.OnResLeaveTeamMessage)

    ---@type Top_UIGridContainer
    UIMissionPanel.MsiionList = UIMissionPanel:GetCurComp("WidgetRoot/Root/MsiionPanel/MsiionList", "UIGridContainer")
    UIMissionPanel.missionTemplate = templatemanager.GetNewTemplate(UIMissionPanel.MsiionList.gameObject, luaComponentTemplates.UIMissionPanel_Mission)
    UIMissionPanel.QuickTeam.go.gameObject:SetActive(false)
    UIMissionPanel.QuickTeamChild:SetActive(false)
    --更新目标任务
    UIMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.Task_GoalUpdate, UIMissionPanel.OnRefreshUI)
    --自动任务
    UIMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_AutoDoMission, UIMissionPanel.AutoDoMission)
    --完成任务消息
    UIMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_CompleteTask, UIMissionPanel.CompleteTask)
    ---地图加载完成后的处理
    UIMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MapProcessAfterLoaded, UIMissionPanel.OnResPlayerChangeMapMessageReceived)
    --角色更新等级
    UIMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, UIMissionPanel.onUpdataLevel)
    --队伍状态改变
    UIMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_TeamStatuChange, UIMissionPanel.onTeamStatuChange)
    --活跃度状态变化
    UIMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_ActiveAcceptStatusChange, UIMissionPanel.OnActiveAcceptStatusChange)
    --活跃度状态变化
    UIMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_OnCurrentActiveChange, UIMissionPanel.ActiveChange)
    --任务更新数据
    UIMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_UpDateTaskSchedule, UIMissionPanel.ActiveNumberChange)
    --任务更新数据
    UIMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainMissionStateChanged, UIMissionPanel.MainMissionStateChanged)
    --怪物悬赏更新数据
    UIMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MonsterArrestChange, UIMissionPanel.MonsterArrestChange)
    --去做任务提示
    UIMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_NoNowTaskTip, UIMissionPanel.DoTaskTipChange)
    --日活做任务提示
    UIMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_DoDailyTaskTip, UIMissionPanel.DoDailyTaskTipChange)
    --怪物任务做任务提示
    UIMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_DoMonsterTaskTipChange, UIMissionPanel.DoMonsteraskTipChange)

    --个人镖车更新数据
    UIMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_PersonDartCarRefresh, UIMissionPanel.OnPersonDartCarRefresh)
    --任务跳转界面刷新
    UIMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainMissionJumpTipShowChanged, UIMissionPanel.OnMainMissionJumpTipShowChanged)
    --精英任务提示
    UIMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_EliteTaskEffeChange, UIMissionPanel.OnEliteTaskEffeChange)
    --怪物任务提示
    UIMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MonsterTaskEffeChange, UIMissionPanel.OnMonsterTaskEffeChange)
    --怪物任务刷新
    UIMissionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MonsterTaskNowSelectChange, UIMissionPanel.RefreShMonsterTaskShow)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Task_NotHaveItem, UIMissionPanel.OnNotHasTaskUseItem)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Task_ShengYu, UIMissionPanel.RefreShShengYu)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Task_CrawlTower, UIMissionPanel.RefreshTowerMission)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Task_YanHua, UIMissionPanel.RefreShYanHua)

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResActiveDataMessage, UIMissionPanel.OnResActiveDataMessageReceived)
    UIMissionPanel.RefreshBtnstatu()

    UIMissionPanel.IsOpenShengYu = nil
    UIMissionPanel.IsOpenYanHua = nil
    UIMissionPanel.IsOpenTower = nil
    UIMissionPanel.doDailyTaskTipPosition = UIMissionPanel.doDailyTaskTip.transform.localPosition
    UIMissionPanel.doMonsterTaskTipPosition = UIMissionPanel.doMonsterTaskTip.transform.localPosition
    UIMissionPanel.doTaskTipPosition = UIMissionPanel.doTaskTip.transform.localPosition
    networkRequest.ReqWolfDreamTime()
    self:SetLeftItemActive()
end

---设置左侧任务模块开关
function UIMissionPanel:SetLeftItemActive()
    CS.CSMissionManager.Instance.yanHuaSwitch = false
end

---长时间未点击进入自动任务
function UIMissionPanel.AutoDoMission(id, data)
    UIMissionPanel.missionTemplate:DoAutoMission()
end

---更新数据
function UIMissionPanel.OnRefreshUI(id, type, mission)
    if type == CS.ETaskV2_TaskState.HAS_ACCEPT then
        UIMissionPanel.missionTemplate:RefreshUI(mission)
    else
        UIMissionPanel.missionTemplate:Show()
    end
    UIMissionPanel.missionTemplate:RefreshUI(mission, LuaEnumShowTaskType.Elite)
    -- UIMissionPanel.missionTemplate:RefreshUI(mission, LuaEnumShowTaskType.Monster)
    if mission ~= nil and mission.showType == LuaEnumShowTaskType.Monster then
        UIMissionPanel.missionTemplate:Show()
    end
    --UIMissionPanel.missionTemplate:RefreshUIWithType(mission, LuaEnumShowTaskType.Monster)
    CS.CSScene.MainPlayerInfo.ActiveInfo:OnActiveStateChanged();

    UIMissionPanel.ItemInfoExhibitionChange()
end

---完成任务回调
function UIMissionPanel.CompleteTask(id, data)
    local isFind, taskTable = CS.Cfg_TaskTableManager.Instance:TryGetValue(data)
    if isFind and taskTable.type == 4 then
        return
    end
    local size = CS.UnityEngine.Vector3(1, 1, 1)
    local pos = CS.UnityEngine.Vector3(0, 200, 0)
    Utility.ShowScreenEffect(700002, size, pos)
    UIMissionPanel.missionTemplate:SetTaskCompleteEffects(data)
end

---刷新日常任务特效
function UIMissionPanel.OnActiveAcceptStatusChange(id, data)
    UIMissionPanel.missionTemplate:Show()
    UIMissionPanel.missionTemplate:SetDailyTaskEffects(data)
end

---刷新主线任务特效显示
function UIMissionPanel.MainMissionStateChanged(id, isOpen)
    UIMissionPanel.missionTemplate:SetTaskEffects(isOpen)
end

--region 其他非任务类型面板显示刷新
--活动变化
function UIMissionPanel.ActiveChange()
    local IsShowActivityTemplat = CS.CSMissionManager.Instance:IsShowActivityTemplat()
    if IsShowActivityTemplat ~= UIMissionPanel.isActiveShow then
        UIMissionPanel.isActiveShow = IsShowActivityTemplat
        UIMissionPanel.missionTemplate:Show()
    end
    UIMissionPanel.ActiveNumberChange()
end

function UIMissionPanel.ActiveNumberChange()
    local currentActive = CS.CSScene.MainPlayerInfo.ActiveInfo:GetCurrentActive()
    if currentActive == nil then
        UIMissionPanel.missionTemplate:RefreshOtherTypeUI(nil, LuaEnumShowTaskType.Acitvity);
        return
    end
    UIMissionPanel.missionTemplate:RefreshOtherTypeUI(currentActive:GetDailyTaskShowInfo(), LuaEnumShowTaskType.Acitvity);
end

--怪物悬赏数据更新
function UIMissionPanel.MonsterArrestChange()
    if CS.CSMissionManager.Instance.MonsterArrestIsShow ~= UIMissionPanel.isMonsterArrestShow then
        UIMissionPanel.isMonsterArrestShow = CS.CSMissionManager.Instance.MonsterArrestIsShow
        UIMissionPanel.missionTemplate:Show()
    end

    local allArrestVODic = CS.CSScene.MainPlayerInfo.FriendInfoV2.AllArrestVODic
    local currentArrest = CS.CSScene.MainPlayerInfo.FriendInfoV2.CurMonsterArrestIDList
    if currentArrest.Count == 0 then
        return
    end
    for i = 0, currentArrest.Count - 1 do
        local isFind, arrestVO = allArrestVODic:TryGetValue(currentArrest[i])
        if isFind then
            UIMissionPanel.missionTemplate:RefreshOtherTypeUI(arrestVO:GetDailyTaskShowInfo(), LuaEnumShowTaskType.Reward)
            return
        end
    end
end

--道具信息展示
function UIMissionPanel.ItemInfoExhibitionChange()
    local info = CS.CSMissionManager.Instance:GetItemShengYuShowInfo();
    UIMissionPanel.missionTemplate:RefreshOtherTypeUI(info, LuaEnumShowTaskType.ShengYu);
    info = CS.CSMissionManager.Instance:GetItemYanHuaShowInfo()
    UIMissionPanel.missionTemplate:RefreshOtherTypeUI(info, LuaEnumShowTaskType.YanHua);
end

---刷新闯天关
function UIMissionPanel.RefreshTowerMission()
    if UIMissionPanel.IsOpenTower == nil or UIMissionPanel.IsOpenTower ~= CS.CSMissionManager.Instance:IsOpenYanHuaTemplat() then
        UIMissionPanel.missionTemplate:Show()
        UIMissionPanel.IsOpenTower = CS.CSMissionManager.Instance:IsOpenTowerTemplat()
    end
    local info = CS.CSMissionManager.Instance:GetItemTowerShowInfo()
    UIMissionPanel.missionTemplate:RefreshOtherTypeUI(info, LuaEnumShowTaskType.CrawlTower);
end

---刷新圣域
function UIMissionPanel.RefreShShengYu()
    if UIMissionPanel.IsOpenShengYu == nil or UIMissionPanel.IsOpenShengYu ~= CS.CSMissionManager.Instance:IsOpenShengYuTemplat() then
        UIMissionPanel.missionTemplate:Show()
        UIMissionPanel.IsOpenShengYu = CS.CSMissionManager.Instance:IsOpenShengYuTemplat()
    end
    local info = CS.CSMissionManager.Instance:GetItemShengYuShowInfo();
    UIMissionPanel.missionTemplate:RefreshOtherTypeUI(info, LuaEnumShowTaskType.ShengYu);
end

function UIMissionPanel.RefreShYanHua()
    if UIMissionPanel.IsOpenYanHua == nil or UIMissionPanel.IsOpenYanHua ~= CS.CSMissionManager.Instance:IsOpenYanHuaTemplat() then
        UIMissionPanel.missionTemplate:Show()
        UIMissionPanel.IsOpenYanHua = CS.CSMissionManager.Instance:IsOpenYanHuaTemplat()
    end
    local info = CS.CSMissionManager.Instance:GetItemYanHuaShowInfo()
    UIMissionPanel.missionTemplate:RefreshOtherTypeUI(info, LuaEnumShowTaskType.YanHua);
end

--endregion
--做任务提示
function UIMissionPanel.DoTaskTipChange(id, data)
    UIMissionPanel.SetDoTaskTipPosition()
    UIMissionPanel.doTaskTip.gameObject:SetActive(data)
end

function UIMissionPanel.SetDoTaskTipPosition()
    local Positiony = -1
    if UIMissionPanel.missionTemplate ~= nil then
        Positiony = UIMissionPanel.missionTemplate:GetMissionTypePosition(LuaEnumShowTaskType.Common, LuaEnumTaskType.MainTask)
    end
    if Positiony == nil or Positiony == -1 then
        return
    end
    UIMissionPanel.doTaskTipPosition.y = Positiony
    UIMissionPanel.doTaskTip.transform.localPosition = UIMissionPanel.doTaskTipPosition
end

---日活做任务提示
function UIMissionPanel.DoDailyTaskTipChange(id, data)
    local Positiony = -1
    if UIMissionPanel.missionTemplate ~= nil then
        Positiony = UIMissionPanel.missionTemplate:GetMissionTypePosition(LuaEnumShowTaskType.Acitvity)
    end
    if Positiony == nil or Positiony == -1 then
        UIMissionPanel.doDailyTaskTip.gameObject:SetActive(false)
        return
    end
    UIMissionPanel.doDailyTaskTipPosition.y = Positiony - 10
    UIMissionPanel.doDailyTaskTip.transform.localPosition = UIMissionPanel.doDailyTaskTipPosition
    UIMissionPanel.doDailyTaskTip.gameObject:SetActive(data)
end

---怪物任务做任务提示
function UIMissionPanel.DoMonsteraskTipChange(id, data)
    local Positiony = -1
    if UIMissionPanel.missionTemplate ~= nil then
        Positiony = UIMissionPanel.missionTemplate:GetMissionTypePosition(LuaEnumShowTaskType.Monster)
    end
    if Positiony == nil or Positiony == -1 then
        CS.CSMissionManager.Instance:CloseMonsterTaskTip()
        UIMissionPanel.doMonsterTaskTip.gameObject:SetActive(false)
        return
    end
    UIMissionPanel.doMonsterTaskTipPosition.y = Positiony - 10
    UIMissionPanel.doMonsterTaskTip.transform.localPosition = UIMissionPanel.doMonsterTaskTipPosition
    UIMissionPanel.doMonsterTaskTip.gameObject:SetActive(data)
end

---任务跳转提示界面刷新
function UIMissionPanel.OnMainMissionJumpTipShowChanged(id, data)
    UIMissionPanel.missionTemplate:SetMainTaskJumpPanel(data)
end

function UIMissionPanel.OnEliteTaskEffeChange(id, data)
    local elite = UIMissionPanel.missionTemplate:SetTaskTemplates(LuaEnumShowTaskType.Elite)
    if elite ~= nil then
        elite.elite_effect.gameObject:SetActive(data)
    end

end

---怪物任务特效刷新
function UIMissionPanel.OnMonsterTaskEffeChange(id, data)
    local monster = UIMissionPanel.missionTemplate:SetTaskTemplates(LuaEnumShowTaskType.Monster)
    if monster ~= nil then
        monster.monster_effect.gameObject:SetActive(data)
    end
end
---刷新怪物任务显示
function UIMissionPanel.RefreShMonsterTaskShow()
    UIMissionPanel.missionTemplate:Show()
end

--个人镖车刷新
function UIMissionPanel.OnPersonDartCarRefresh(id, personDartCarInfo)
    if UIMissionPanel.missionTemplate ~= nil then
        --if personDartCarInfo == nil then
        --    UIMissionPanel.missionTemplate:ShowMissions()
        --else
        --    UIMissionPanel.missionTemplate:RefreshSinglePersonDartCarUI(personDartCarInfo)
        --end
        ---策划要求单个镖车被攻击，则置顶该镖车，所以需要全部重新刷新，如果不指定，则可以单条进行刷新
        UIMissionPanel.missionTemplate:ShowMissions()
        UIMissionPanel.missionTemplate:SetPosition(true)
    end
    if CS.CSScene.MainPlayerInfo.PersonDartcarInfo:HaveReceiveDartCar() == false then
        Utility.RemoveFlashPrompt(1, LuaEnumFlashIdType.PersonDartCar_Success)
    end
end

function UIMissionPanel:Show()
    UIMissionPanel.missionTemplate:Show()
    UIMissionPanel.MonsterArrestChange()
end

---切换地图刷新任务显示
function UIMissionPanel.OnResPlayerChangeMapMessageReceived()
    UIMissionPanel.mIsDirty = true
    --UIMissionPanel.missionTemplate:Show()
    --local mapID = CS.CSScene:getMapID()
end


--region 点击事件
---组队按钮点击事件
function UIMissionPanel:OnClinkTeam()
    UIMissionPanel.QuickTeam.go.gameObject:SetActive(true)
    UIMissionPanel.MsiionList.gameObject:SetActive(false)
    if UIMissionPanel.QuickTeam ~= nil then
        UIMissionPanel.QuickTeam:RefreshTeamInfo()
    end
    UIMissionPanel.GetPanelScrollView():ResetPosition();
end

---任务按钮点击事件
function UIMissionPanel:OnClinkMission()
    UIMissionPanel.QuickTeam.go.gameObject:SetActive(false)
    UIMissionPanel.MsiionList.gameObject:SetActive(true)
    UIMissionPanel.GetPanelScrollView():ResetPosition();
end
--endregion
---组队面板刷新 MessageType 消息类型 0 离开队伍 1其他操作
--function UIMissionPanel.OnResGroupDetailedInfoMessage(MessageType)
--    if MessageType == 1 then
--        UIMissionPanel.QuickTeam.OnResGroupDetailedInfoMessage()
--    elseif MessageType == 0 then
--        UIMissionPanel.QuickTeam.OnResLeaveTeamMessage()
--    end
--end
---缩进按键点击事件
function UIMissionPanel.OnClinkFoldBtn()
    UIMissionPanel.btn_jiantou:SetOnFinished(UIMissionPanel.ClinkFoldBtnCallBack);
    if UIMissionPanel.IsShow then
        UIMissionPanel.btn_jiantou:PlayForward()
        UIMissionPanel.IsShow = false
    else
        UIMissionPanel.btn_jiantou:PlayReverse()
        UIMissionPanel.IsShow = true
    end
end

---缩进按钮回调
function UIMissionPanel.ClinkFoldBtnCallBack()
    local v3 = CS.UnityEngine.Vector3.zero
    if UIMissionPanel.IsShow == false then
        v3.z = 180
    end
    UIMissionPanel.btn_jiantou_Sprite.transform.localEulerAngles = v3
end

function UIMissionPanel.onUpdataLevel()
    UIMissionPanel.mIsDirty = true
    --UIMissionPanel.missionTemplate:Show()
end

function update()
    if UIMissionPanel.mIsDirty then
        UIMissionPanel.mIsDirty = false
        UIMissionPanel.missionTemplate:Show()
    end
end

---组队状态改变
function UIMissionPanel.onTeamStatuChange()
    UIMissionPanel.RefreshBtnstatu()
end

function UIMissionPanel.OnNotHasTaskUseItem()
    local currentTask = CS.CSMissionManager.Instance.CurrentTask;
    if (currentTask ~= nil) then
        local list = UIMissionPanel.missionTemplate.MissionListTable;
        for k, v in pairs(list) do
            if (v.mMission ~= nil) then
                if (v.mMission.taskId == currentTask.taskId) then
                    local TipsInfo = {}
                    TipsInfo[LuaEnumTipConfigType.Parent] = v.go.transform;
                    TipsInfo[LuaEnumTipConfigType.ConfigID] = 110
                    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIMissionPanel";
                    return uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
                end
            end
        end
    end

end

function UIMissionPanel.RefreshBtnstatu()
    local isOpen = CS.CSScene.MainPlayerInfo.GroupInfoV2.IsHaveGroup
    local v3 = UIMissionPanel.root.transform.localPosition
    local x = isOpen and 26 or -20
    UIMissionPanel.root.transform.localPosition = CS.UnityEngine.Vector3(x, v3.y, 0)
    if (not isOpen) then
        UIMissionPanel.GetTglMission_UIToggle().value = true;
        UIMissionPanel.GetTglTeam_UIToggle().value = false;
        UIMissionPanel:OnClinkMission();
    else
        UIMissionPanel.GetTglMission_UIToggle().value = false;
        UIMissionPanel.GetTglTeam_UIToggle().value = true;
    end

    UIMissionPanel.Btn_mission_GameObject():SetActive(isOpen)
    UIMissionPanel.Btn_team_GameObject():SetActive(isOpen)
    UIMissionPanel.MissionBg:SetActive(isOpen)
end

function UIMissionPanel.OnResActiveDataMessageReceived()
    UIMissionPanel.missionTemplate:RefreshActive()
end

function UIMissionPanel.ScrollViewRefresh(Offset)
    if UIMissionPanel.MsiionPanel() == nil then
        return
    end
    if Offset == nil then
        local transform = UIMissionPanel.MsiionPanel().gameObject.transform.localPosition
        transform.y = 100
        UIMissionPanel.MsiionPanel().gameObject.transform.localPosition = transform;
        UIMissionPanel.MsiionPanel().clipOffset = CS.UnityEngine.Vector2(0, -75);
        return
    end
    local clipOffset = Offset
    if Offset > 0 then
        clipOffset = Offset * -1
    end
    local transform = UIMissionPanel.MsiionPanel().gameObject.transform.localPosition
    transform.y = -clipOffset - 28
    UIMissionPanel.MsiionPanel().gameObject.transform.localPosition = transform;
    UIMissionPanel.MsiionPanel().clipOffset = CS.UnityEngine.Vector2(0, Offset + 43);
end

function ondestroy()
    UIMissionPanel.isMonsterArrestShow = false
    UIMissionPanel.isActiveShow = false
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResActiveDataMessage, UIMissionPanel.OnResActiveDataMessageReceived)
    --luaEventManager.RemoveCallback(LuaCEvent.Task_NotHaveItem, UIMissionPanel.OnNotHasTaskUseItem);
    --luaEventManager.RemoveCallback(LuaCEvent.Task_ShengYu, UIMissionPanel.RefreShShengYu);
    --luaEventManager.RemoveCallback(LuaCEvent.Task_YanHua, UIMissionPanel.RefreShYanHua);
    CS.CSMissionManager.Instance:ClearCurrentTask()
end

return UIMissionPanel