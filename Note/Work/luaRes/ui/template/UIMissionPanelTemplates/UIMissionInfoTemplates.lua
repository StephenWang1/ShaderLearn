---任务栏信息模板
---@class UIMissionInfoTemplates:TemplateBase
local UIMissionInfoTemplates = {}

function UIMissionInfoTemplates:InitComponents()
    ---@type Top_UILabel  标题
    -- self.lb_tilte = self:Get("mission/lb_tilte", "Top_UILabel")
    ---@type Top_UILabel 内容
    self.lb_content = self:Get("mission/lb_content", "Top_UILabel")
    self.lb_content2 = self:Get("mission/lb_content2", "Top_UILabel")

    self.lb_content_target = self:Get("mission/lb_content_target", "Top_UILabel")
    self.lb_content_target2 = self:Get("mission/lb_content_target2", "Top_UILabel")
    ---@type Top_UILabel 任务状态
    self.lb_state = self:Get("mission/lb_state", "Top_UILabel")
    ---@type UnityEngine.GameObject 单个任务
    self.mission = self:Get("mission", "GameObject")
    ---@type Top_UISprite 背景图片
    self.bg = self:Get("mission/bg", "Top_UISprite")
    ---@type Top_UISprite 任务类型图片
    self.task_type = self:Get("mission/task_type", "Top_UISprite")
    ---@type Top_UISprite 任务类型底板图片
    self.bg2 = self:Get("mission/bg2", "Top_UISprite")
    ---@type Top_UISprite 任务类型底板图片
    self.effect = self:Get("mission/effect", "CSUIEffectLoad")
    ---@type Top_UISprite 个人镖车特效（被攻击）
    self.personDartCarEffect = self:Get("mission/persondartcar_effect", "GameObject")
    ---@type Top_UISprite 精英任务正在进行中特效
    self.elite_effect = self:Get("mission/elite_effect", "GameObject")
    ---@type Top_UISprite 怪物任务正在进行中特效
    self.monster_effect = self:Get("mission/monster_effect", "GameObject")

    ---完成艺术字
    ---@type UnityEngine.GameObject
    self.completed = self:Get("mission/lb_state/completed", "GameObject")
    ---任务完成特效
    self.completeEffect = nil
    ---任务进行中特效
    self.underwayEffect = nil
    ---rc
    self.DailyEffect = nil

    self.MissionPanel = nil
    self.mMission = nil
    self.Color_Green = "[00ff00]"
    self.Color_Red = '[E85038FF]'
    self.Color_White = '[DDE6EBFF]'
    self.Color_Lucency = '[00000000]'
    self.Color_Change = self.Color_White
end

function UIMissionInfoTemplates:InitOther()
    ---背景最小值
    self.bgSize_Y_Min = 20;
    ---字体间距
    self.LabelInterval = 3;
    ---顶部间距
    self.TopInterval = 12;
    ---底部留白间距
    self.BottomBorder = -10;

    self.mClient = nil
    CS.UIEventListener.Get(self.bg.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.bg.gameObject).OnClickLuaDelegate = self.OnClick
end

function UIMissionInfoTemplates:Init()
    self:InitComponents()
    self:InitOther()
end

function UIMissionInfoTemplates:RefreshUI(data, MissionPanel, missionClipArea)
    if missionClipArea ~= nil then
        self.missionClipArea = missionClipArea
    end
    if data == nil then
        return
    end
    self.missionInfo = data
    if self.showType ~= data.showType then
        self:InitEffectInfo()
    end
    self.mMission = nil
    self:InitPanleInfo()
    self.showType = data.showType
    if data.showType == LuaEnumShowTaskType.Common then
        self:CommonTask(data, MissionPanel)
    elseif data.showType == LuaEnumShowTaskType.Acitvity then
        self:AcitvityTask(data)
    elseif data.showType == LuaEnumShowTaskType.Reward then
        self:RewardTask(data)
    elseif data.showType == LuaEnumShowTaskType.YanHua or data.showType == LuaEnumShowTaskType.ShengYu then
        self:ItemTask(data)
    elseif data.showType == LuaEnumTaskType.PersonDartCar_Normal then
        self:RefreshPersonDartCar(data)
    elseif data.showType == LuaEnumShowTaskType.Elite then
        self:CommonTask(data, MissionPanel)
        self.elite_effect:SetActive(data.State == CS.ETaskV2_TaskState.HAS_COMPLETE)
    elseif data.showType == LuaEnumShowTaskType.Boss then
        self:CommonTask(data, MissionPanel)
    elseif data.showType == LuaEnumShowTaskType.Monster then
        self:MonsterTask()
    elseif data.showType == LuaEnumShowTaskType.CrawlTower then
        self:CrawlTowerTask()
    end
end

--初始化面板信息
function UIMissionInfoTemplates:InitPanleInfo()
    self.completed.gameObject:SetActive(false)
    self.lb_content.text = ''
    self.lb_content2.text = ''
    self.lb_content_target.text = ''
    self.lb_content_target2.text = ''
    self.lb_state.text = ''
    self.lb_statetextDes = '进行中'
    if self.IenumRefreshTime ~= nil then
        StopCoroutine(self.IenumRefreshTime)
        self.IenumRefreshTime = nil
    end
end

--初始化面板特效信息
function UIMissionInfoTemplates:InitEffectInfo()
    if not CS.StaticUtility.IsNull(self.completeEffect) then
        self.completeEffect.transform.localScale = CS.Vector3.zero;
    end

    if not CS.StaticUtility.IsNull(self.underwayEffect) then
        self.underwayEffect.transform.localScale = CS.Vector3.zero;
    end

    if not CS.StaticUtility.IsNull(self.DailyEffect) then
        self.DailyEffect.transform.localScale = CS.Vector3.zero;
    end

    if not CS.StaticUtility.IsNull(self.personDartCarEffect) then
        self.personDartCarEffect:SetActive(false)
    end
    self.elite_effect:SetActive(false)
    self.monster_effect:SetActive(false)
end

--region 普通任务
---普通任务
function UIMissionInfoTemplates:CommonTask(data, MissionPanel)

    self.MissionPanel = MissionPanel
    self.OldmMission = self.mMission
    self.OldTaskShowInfo = self.TaskShowInfo
    self.mMission = data
    local tbl_task = data.tbl_tasks
    local contenttext = ''
    local contenttext2 = ''
    local lb_statetext = ''
    local statetextActive = true
    self.lb_content_target.gameObject:SetActive(false);
    self.lb_content_target2.gameObject:SetActive(false);
    self.completed.gameObject:SetActive(false)
    self.TaskShowInfo = data:GetDailyTaskShowInfo()
    if data.State == CS.ETaskV2_TaskState.HAS_ACCEPT then
        contenttext = self:Setcontent(self.TaskShowInfo, 0, self.lb_content_target, true)
        contenttext2 = self:Setcontent(self.TaskShowInfo, 1, self.lb_content_target2, true)
    elseif data.State == CS.ETaskV2_TaskState.HAS_COMPLETE then
        if tbl_task.dialoguetype == 2 then
            contenttext = self:Setcontent(self.TaskShowInfo, 0, self.lb_content_target)
            contenttext2 = self:Setcontent(self.TaskShowInfo, 1, self.lb_content_target2)
            -- lb_statetext = self.Color_Green .. '完成'
            statetextActive = false
            self.completed.gameObject:SetActive(true)
        else
            statetextActive = true
            contenttext = self.Color_White .. tostring(tbl_task.completeinfo)

            if tbl_task ~= nil then
                if tbl_task.type == LuaEnumTaskType.SecondTask or tbl_task.type == LuaEnumTaskType.Elite or tbl_task.type == LuaEnumTaskType.Boss then
                    self.lb_statetextDes = ""
                    self.completed.gameObject:SetActive(true)
                else
                    self.lb_statetextDes = '进行中'
                end
            end
            lb_statetext = self.Color_Green .. self.lb_statetextDes
        end
        self.lb_content_target.gameObject:SetActive(false);
        self.lb_content_target2.gameObject:SetActive(false);

    else
        contenttext = self.Color_White .. tostring(tbl_task.taskInfo)
        local des = ""
        if self.mMission.IsNeedBuy == true then
            des = self.Color_Red .. "可买"
        else
            des = self.Color_Green .. "可接"
        end
        lb_statetext = des
    end
    self:SetTaskType(tbl_task.type)
    --self.lb_tilte.text = self.Color_White .. tostring(tbl_task.name)
    self.lb_content.text = contenttext
    self.lb_content2.text = contenttext2

    self:SetSize(self.lb_content, self.lb_content2, self.lb_content_target, self.lb_content_target2, data.State)
    --  self:SetEffects()
    self.lb_state.enabled = statetextActive
    if statetextActive then
        self.lb_state.text = lb_statetext
    end
    if self.mMission ~= nil and self.mMission.tbl_tasks ~= nil and self.mMission.tbl_tasks.type ~= LuaEnumTaskType.MainTask then
        if not CS.StaticUtility.IsNull(self.DailyEffect) then
            self.DailyEffect.transform.localScale = CS.Vector3.zero;
        end
        if not CS.StaticUtility.IsNull(self.underwayEffect) then
            self.underwayEffect.transform.localScale = CS.Vector3.zero;
        end

    end
end

---普通任务点击事件
function UIMissionInfoTemplates:CommonTaskOnClick()
    -- local isfind,data=CS.Cfg_TaskTableManager.Instance:TryGetValue(self.mMission.taskId)
    -- if  isfind  then
    --     local jump=data.jump
    --     if jump~=nil and jump.list~=nil then
    --         local data=CS.Cfg_TaskJumpTableManager.Instance:GteMainMenuList(jump)
    --         if  uimanager:GetPanel("UIMissionOperationTipsPanel")==nil then
    --             uimanager:CreatePanel('UIMissionOperationTipsPanel',nil,data,self.go.transform.localPosition.y)
    --         else
    --             uimanager:ClosePanel('UIMissionOperationTipsPanel')
    --         end
    --     end
    --     return
    -- end
    if self:SpecialOpenPanelSubmitTask(self.mMission, true) then
        return
    end
    if uimanager:GetPanel("UIMissionOperationTipsPanel") ~= nil then
        uimanager:ClosePanel('UIMissionOperationTipsPanel')
        CS.CSMissionManager.Instance.IsUIOpenJumpTip = false;
    else
        self:OpenGuidancePanel(self.mMission.State ~= CS.ETaskV2_TaskState.HAS_COMPLETE)
    end
    if CS.CSMissionManager.Instance:IsNeedJumpNormalTaskShowTip(self.mMission) then
        return
    end

    if (self.mMission.State == CS.ETaskV2_TaskState.HAS_COMPLETE) then
        if (self.mMission.tbl_tasks ~= nil and self.mMission.tbl_tasks.type == 5) then
            uimanager:CreatePanel("UIMissionAwardPanel", function(panel)
                if self.mMission ~= nil then
                    panel.ShowTask(self.mMission.tbl_tasks, self.mMission);
                end
            end)
            return ;
        end

        if (self.mMission.tbl_tasks.tnpc == nil) then
            uimanager:CreatePanel("UIMissionAwardPanel", function(panel)
                panel.ShowTask(self.mMission.tbl_tasks, self.mMission);
            end)
            return ;
        elseif (self.mMission.tbl_tasks.tnpc.list ~= nil and self.mMission.tbl_tasks.tnpc.list.Count <= 0) then
            uimanager:CreatePanel("UIMissionAwardPanel", function(panel)
                panel.ShowTask(self.mMission.tbl_tasks, self.mMission);
            end)
            return ;
        end
    end
    if self.mMission.State == CS.ETaskV2_TaskState.HAS_ACCEPT then
        if self.mMission.tbl_tasks.taskGoalType == 29 then
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Role_Prefix);
            return
        end
    end

    -- local CurrentTask=CS.CSMissionManager.Instance.CurrentTask
    -- if CurrentTask~=nil and  self.mMission~=nil  then
    --     if self.mMission.taskId== CurrentTask.taskId and CurrentTask:IsMainTask() then
    --         luaEventManager.DoCallback(LuaCEvent.Push_Task,self.mMission.taskId);
    --     end  
    -- end
    CS.CSAutoPauseMgr.Instance:ExitPauseState(false)
    --寻找任务目标
    CS.CSMissionManager.Instance:FindTaskTarget(self.mMission)
end

---特殊任务-直接打开面板提交
function UIMissionInfoTemplates:SpecialOpenPanelSubmitTask(Mission, isOperation)

    if Mission == nil or Mission.tbl_tasks == nil then
        return false
    end
    if Mission.State == CS.ETaskV2_TaskState.HAS_COMPLETE then
        local table = LuaGlobalTableDeal.Task_SpecialOpenPanelSubmitTask()
        if table == nil then
            return false
        end
        for k, v in pairs(table) do
            if tonumber(Mission.tbl_tasks.id) == tonumber(v) then
                if not isOperation then
                    return true
                end
                uimanager:CreatePanel("UIMissionAwardPanel", function(panel)
                    panel.ShowTask(Mission.tbl_tasks, self.mMission);
                end)
                return true
            end
        end
    end
    if self.mMission.State == CS.ETaskV2_TaskState.HAS_ACCEPT then
        local table = LuaGlobalTableDeal.Task_SpecialOpenPowPanel()
        if table == nil then
            return false
        end
        for k, v in pairs(table) do
            if tonumber(Mission.tbl_tasks.id) == tonumber(v) then
                if not isOperation then
                    return true
                end
                uimanager:CreatePanel("UIStrongerPanel")
                return true
            end
        end
    end

    return false
end

---打开任务引导面板
function UIMissionInfoTemplates:OpenGuidancePanel(isOpen)
    if isOpen == false then
        if uimanager:GetPanel("UIMissionOperationTipsPanel") ~= nil then
            uimanager:ClosePanel('UIMissionOperationTipsPanel')
            CS.CSMissionManager.Instance.IsUIOpenJumpTip = false;
        end
        return
    end
    local specialMission = CS.CSMissionManager.Instance:IsNeedJumpNormalTaskShowTip(self.mMission)
    local CurrentTask = CS.CSMissionManager.Instance.CurrentTask
    if (CurrentTask ~= nil and self.mMission ~= nil and CurrentTask.taskId == self.mMission.taskId) or specialMission then
        if self.mMission.tbl_tasks ~= nil and ((self.mMission.tbl_tasks.type == LuaEnumTaskType.MainTask and CS.CSMissionManager.Instance.IsProgressMainTask) or specialMission) then
            local isfind, data = CS.Cfg_TaskTableManager.Instance:TryGetValue(self.mMission.taskId)
            if isfind then
                local jump = data.jump
                if jump ~= nil and jump.list ~= nil then
                    local data = CS.Cfg_TaskJumpTableManager.Instance:GteMainMenuList(jump)
                    if uimanager:GetPanel("UIMissionOperationTipsPanel") == nil then
                        uimanager:CreatePanel('UIMissionOperationTipsPanel', nil, data, self.go.transform)
                        CS.CSMissionManager.Instance.IsUIOpenJumpTip = true;
                        return
                    end
                end
            end
        end
    end
    CS.CSMissionManager.Instance.IsUIOpenJumpTip = false;
end

function UIMissionInfoTemplates:OnMissionClick()
    if self.showType ~= LuaEnumShowTaskType.Common then
        return
    end
    if self:SpecialOpenPanelSubmitTask(self.mMission, false) then
        return
    end
    --寻找任务目标
    CS.CSMissionManager.Instance.CurrentTask = self.mMission
    CS.CSMissionManager.Instance.IsDetectionTaskCompleted = true
    CS.CSMissionManager.Instance:CompleteTaskDoexecute()
end
--endregion
--region 活跃任务
---活跃任务
function UIMissionInfoTemplates:NotInfoAcitvityTask()
    if self.underwayEffect ~= nil and self.underwayEffect.gameObject ~= nil then
        self.underwayEffect.gameObject:SetActive(false)
    end
    self.completed.gameObject:SetActive(false)
    self.lb_content_target.gameObject:SetActive(false);
    self.lb_content.text = luaEnumColorType.White .. '每日活跃度'
    self.lb_content2.text = ''
    self:SetSize(self.lb_content, self.lb_content2, self.lb_content_target, self.lb_content_target2)
    self.lb_state.enabled = true
    self.lb_state.text = Utility.SetScheduleColor(CS.CSScene.MainPlayerInfo.ActiveInfo:GetActiveNumber(), CS.Cfg_Active_RewardTableManager.Instance.MaxActiveNumber)
end

--活跃任务
function UIMissionInfoTemplates:AcitvityTask(data)
    self:SetTaskType(LuaEnumTaskType.Everyday)
    if data == nil or data.taskShowInfo == nil then
        self:NotInfoAcitvityTask()
        return ;
    end

    self.OldTaskShowInfo = self.TaskShowInfo
    self.TaskShowInfo = data.taskShowInfo
    self.lb_state.enabled = false
    local str1 = self:Setcontent(self.TaskShowInfo, 0, self.lb_content_target);
    local str2 = self:Setcontent(self.TaskShowInfo, 1, self.lb_content_target2);
    if(str1 == "" and str2 == "") then
        self:NotInfoAcitvityTask()
        return ;
    end
    self.lb_content.text = str1
    self.lb_content2.text = str2
    self:SetSize(self.lb_content, self.lb_content2, self.lb_content_target, self.lb_content_target2, data.State)
    if not CS.StaticUtility.IsNull(self.underwayEffect) then
        self.underwayEffect.transform.localScale = CS.Vector3.zero;
    end
    if not CS.StaticUtility.IsNull(self.DailyEffect) then
        self:SetEffectSize(self.DailyEffect)
    end
    local isChange = self.OldTaskShowInfo ~= nil and self.TaskShowInfo ~= nil and self.OldTaskShowInfo.Count == 2 and self.TaskShowInfo.Count == 2 and self.OldTaskShowInfo[1].CurCount ~= self.TaskShowInfo[1].CurCount
    if self.OldTaskShowInfo == nil or isChange then
        CS.CSMissionManager.Instance:DailyTipChange()
    end
end

---活跃度任务点击事件
function UIMissionInfoTemplates:AcitvityTaskOnClick()
    uimanager:CreatePanel("UIGainGoldGuidePanel")
    --    Utility.TryDoMainPlayerCurrentActive();
end
--endregion
--region 悬赏任务
--- 悬赏任务
function UIMissionInfoTemplates:RewardTask(data)
    --设置底图
    self:SetTaskType(LuaEnumTaskType.MonsterArrest)
    if data == nil or data.taskShowInfo == nil then
        return ;
    end
    self.TaskShowInfo = data.taskShowInfo
    self.lb_state.enabled = false
    self.lb_content.text = self:Setcontent(self.TaskShowInfo, 0, self.lb_content_target)
    self.lb_content2.text = ' '

    self:SetSize(self.lb_content, self.lb_content2, self.lb_content_target, self.lb_content_target2, data.State)

    --设置首个进度居中
    local mask1Position = self.lb_content_target2.transform.localPosition
    mask1Position.y = -(self.bgSize_Y_Min)
    self.lb_content_target2.transform.localPosition = mask1Position
    local allArrestVODic = CS.CSScene.MainPlayerInfo.FriendInfoV2.AllArrestVODic
    if self.TaskShowInfo[0].Id == nil or self.TaskShowInfo[0].Id == 0 or allArrestVODic == nil then
        return
    end
    local isFind, info = allArrestVODic:TryGetValue(self.TaskShowInfo[0].Id)
    if isFind then
        if info:GetRemainTime() ~= 0 then
            self.IenumRefreshTime = StartCoroutine(UIMissionInfoTemplates.IEnumRefreshTime, self, info:GetRemainTime(), self.lb_content2)
        end
    end
    local Iscomplete = self.TaskShowInfo ~= nil and self.TaskShowInfo.Count >= 1 and self.TaskShowInfo[0].CurCount >= self.TaskShowInfo[0].MaxCount
    self.completed:SetActive(Iscomplete)
    self.lb_content_target.gameObject:SetActive(not Iscomplete)
end

--悬赏任务点击事件
function UIMissionInfoTemplates:RewardOnClick()
    if self.TaskShowInfo == nil or self.TaskShowInfo.Count == 0 then
        return
    end
    local allArrestVODic = CS.CSScene.MainPlayerInfo.FriendInfoV2.AllArrestVODic
    local isFind, info = allArrestVODic:TryGetValue(self.TaskShowInfo[0].Id)
    if isFind then
        CS.CSScene.MainPlayerInfo.AsyncOperationController.ArrestFindNPC:DoOperation(info)
    end
end


--endregion
--region 道具任务
function UIMissionInfoTemplates:ItemTask(data)
    self:SetTaskType(LuaEnumTaskType.ShengYu)
    if data == nil or data.taskShowInfo == nil then
        return ;
    end
    self.OldTaskShowInfo = self.TaskShowInfo
    self.TaskShowInfo = data.taskShowInfo
    self.lb_state.enabled = false
    self.lb_content.text = self:Setcontent(self.TaskShowInfo, 0, self.lb_content_target)
    self.lb_content2.text = self:Setcontent(self.TaskShowInfo, 1, self.lb_content_target2)
    if self.TaskShowInfo ~= nil and self.TaskShowInfo.Count == 1 then
        self.lb_content_target.text = "[00ff00]" .. self.TaskShowInfo[0].ExtraDes
    end
    if self.TaskShowInfo ~= nil and self.TaskShowInfo.Count == 2 then
        self.lb_content_target.text = "[00ff00]" .. self.TaskShowInfo[0].ExtraDes
        self.lb_content_target2.text = "[00ff00]" .. self.TaskShowInfo[1].ExtraDes
    end
    self:SetSize(self.lb_content, self.lb_content2, self.lb_content_target, self.lb_content_target2, data.State)
    if not CS.StaticUtility.IsNull(self.underwayEffect) then
        self.underwayEffect.transform.localScale = CS.Vector3.zero;
    end
end
--endregion
--region 圣域道具任务
function UIMissionInfoTemplates:OnClickShengYuTask()
    local mapNpcID = CS.Cfg_GlobalTableManager.Instance.ShengYuMapNpcID;
    CS.CSScene.MainPlayerInfo.AsyncOperationController.RelationwordsFindNPC:FindStart(mapNpcID);
    --CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({74},"UISanctuaryPanel")
end

---烟花任务点击
function UIMissionInfoTemplates:OnClickYanHuaTask()
    if not CS.CSMissionManager.Instance.IsShowYanHuaPanel then
        local mapNpcID = CS.Cfg_GlobalTableManager.Instance.MengJingMapNpcID;
        CS.CSScene.MainPlayerInfo.AsyncOperationController.RelationwordsFindNPC:FindStart(mapNpcID);
    else

        --若批量使用类型为弹出数量界面选择使用数量
        local useFunction = function(count)
            self:TryUseFireworkFunc(count)
        end
        local isfind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(CS.Cfg_GlobalTableManager.Instance.YanHuaItemID)
        if isfind then
            local maxCount = CS.CSScene.MainPlayerInfo.DuplicateV2:SelectFireworkCount(CS.CSMissionManager.Instance.YanHuaItemNumber)
            uimanager:CreatePanel("UIItemCountPanel", function()
                uimanager:ClosePanel("UIItemInfoPanel")
            end, {
                Title = "使 用",
                ItemInfo = itemInfo,
                CallBack = useFunction,
                MinCount = 1,
                BeginningCount = maxCount,
                MaxCount = maxCount == 0 and 1 or maxCount
            })
        end

    end

    --CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({74},"UISanctuaryPanel")
end

---尝试使用烟花
function UIMissionInfoTemplates:TryUseFireworkFunc(count)
    --判断是否超过时间界限而非使用界限
    if CS.CSScene.MainPlayerInfo.DuplicateV2:IsOutOfBoundsOfCount(count) then
        self:ShowOutOfBoundsFireworkTips(count)
    else
        self:UseFirworkItemCount(count)
    end
end

---使用烟花最终方法
function UIMissionInfoTemplates:UseFirworkItemCount(count)
    local mBagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(CS.Cfg_GlobalTableManager.Instance.YanHuaItemID)
    networkRequest.ReqUseItem(count, mBagItemInfo.lid)
    uimanager:ClosePanel("UIBagPanel")
    uimanager:ClosePanel("UIPromptPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
    uimanager:ClosePanel('UIItemInfoPanel')
    uimanager:ClosePanel("UIItemCountPanel")
end

---显示超界烟花tips
function UIMissionInfoTemplates:ShowOutOfBoundsFireworkTips(count)
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20413)
    if isFind then
        local str = info.value
        str = string.Split(str, '#')
        local temp = {}
        temp.Title = ''
        temp.Content = str[1]
        --temp.LeftDescription = str[2]
        temp.RightDescription = str[3]
        temp.IsClose = false
        temp.CallBack = function()
            self:UseFirworkItemCount(count)
        end
        uimanager:CreatePanel("UIPromptPanel", nil, temp)
    end
end


--endregion
--region 个人镖车
function UIMissionInfoTemplates:RefreshPersonDartCar(data)
    self:SetTaskType(LuaEnumTaskType.PersonDartCar_Normal)
    if data ~= nil and data.dataParameter ~= nil then
        local personDartCarInfo = data.dataParameter
        if personDartCarInfo.CanReward == true then
            self.lb_content.text = personDartCarInfo.YaBiaoTable.name
            if self.IenumRefreshTime ~= nil then
                StopCoroutine(self.IenumRefreshTime)
                self.IenumRefreshTime = nil
            end
            self.lb_content2.text = ''
            self.lb_content_target.text = ""
            self.lb_content_target2.text = ''
            self.completed:SetActive(true)
            self.lb_content_target.gameObject:SetActive(false)
        elseif personDartCarInfo.CanReward == false and personDartCarInfo.RemainTime > 0 then
            self.lb_content.text = personDartCarInfo.YaBiaoTable.name
            self.lb_content_target.text = personDartCarInfo:GetRemainTime()
            self.lb_content2.text = "镖车血量"
            self.lb_content_target2.text = personDartCarInfo.Hp .. "/" .. personDartCarInfo.MonsterInfo.maxHp
            self.completed:SetActive(false)
            self.lb_content_target2.gameObject:SetActive(true)
        end
        self:SetSize(self.lb_content, self.lb_content2, self.lb_content_target, self.lb_content_target2, data.State)

        if personDartCarInfo.RemainTime ~= 0 then
            self.IenumRefreshTime = StartCoroutine(UIMissionInfoTemplates.PersonDartCarIEnumRefreshTime, self, personDartCarInfo.RemainTime, self.lb_content_target)
        end

        if self.personDartCarEffect ~= nil then
            if personDartCarInfo.IsBeAttack == true then
                self.personDartCarEffect:SetActive(true)
            else
                self.personDartCarEffect:SetActive(false)
            end
        end
    end
end

function UIMissionInfoTemplates:PersonDartCarOnClick(go)
    if self.missionInfo ~= nil and self.missionInfo.dataParameter ~= nil then
        local personDartCarInfo = self.missionInfo.dataParameter
        if personDartCarInfo ~= nil then
            if personDartCarInfo.CanReward == true then
                CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({ personDartCarInfo.ReceiveNpcId }, "UIIndividEscortPanel", CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC, personDartCarInfo.ReceiveNpcId)
            else
                networkRequest.ReqPersonalCartPosition(personDartCarInfo.CarLid)
            end
        end
    end
end
--endregion
--region 精英任务
function UIMissionInfoTemplates:EliteOnClick(go)

    local csmission = CS.CSMissionManager.Instance:GetEliteTask()
    if csmission ~= nil and csmission.tbl_taskGoalS ~= nil and csmission.tbl_taskGoalS.Count ~= 0 then
        local data = {}
        --data.monstersID = tonumber(csmission.tbl_taskGoalS[0].global)    
        data.offsY = self.go.transform.localPosition.y -- UIMissionOperationTipsPanel.offs 
        data.offsPositionY = self.go.transform.position.y
        data.offsPositionX = self.go.transform.position.x
        data.type = LuaEnumTaskType.Elite
        uimanager:CreatePanel('UIBossKillTipsPanel', nil, data)
    end
end
--endregion
--region Boss任务
function UIMissionInfoTemplates:BossOnClick(go)

    local csmission = CS.CSMissionManager.Instance:GetBossTask()
    if csmission ~= nil and csmission.tbl_taskGoalS ~= nil and csmission.tbl_taskGoalS.Count ~= 0 then
        local data = {}
        --data.monstersID = tonumber(csmission.tbl_taskGoalS[0].global)    
        data.offsY = self.go.transform.localPosition.y -- UIMissionOperationTipsPanel.offs 
        data.offsPositionY = self.go.transform.position.y
        data.offsPositionX = self.go.transform.position.x
        data.type = LuaEnumTaskType.Boss
        uimanager:CreatePanel('UIBossKillTipsPanel', nil, data)
    end
end
--endregion

--region 闯天关任务
function UIMissionInfoTemplates:CrawlTowerTask()
    self:SetTaskType(LuaEnumTaskType.CrawlTower)
    local missionManager = CS.CSMissionManager.Instance

    self.OldTaskShowInfo = self.TaskShowInfo
    self.TaskShowInfo = missionManager:GetItemTowerShowInfo()
    self.lb_state.enabled = false
    self.lb_content.text = self:Setcontent(self.TaskShowInfo, 0, self.lb_content_target)
    self.lb_content_target.text = ""  --tostring(self.TaskShowInfo[0].CurCount) .. "/1"
    self.lb_content_target.transform.localPosition = CS.UnityEngine.Vector3(137, -20, 0)
    self:SetSize(self.lb_content, self.lb_content2, self.lb_content_target, self.lb_content_target2)
    if not CS.StaticUtility.IsNull(self.underwayEffect) then
        self.underwayEffect.transform.localScale = CS.Vector3.zero;
    end
end

function UIMissionInfoTemplates:CrawlTowerOnClick(go)
    local deliverID = CS.Cfg_GlobalTableManager.Instance.TowerDeliverId;
    Utility.TryTransfer(deliverID, false);
    --CS.CSScene.MainPlayerInfo.AsyncOperationController.RelationwordsFindNPC:FindStart(mapNpcID);
end
--endregion
--region 怪物悬赏
---怪物任务执行
function UIMissionInfoTemplates:MonsterTask()
    self:SetTaskType(LuaEnumTaskType.Monster)
    local missionManager = CS.CSMissionManager.Instance
    local isAccomp = missionManager.AccomplishMonsterTaskIDList.Count ~= 0
    self.completed.gameObject:SetActive(isAccomp)

    self.OldTaskShowInfo = self.TaskShowInfo
    self.TaskShowInfo = missionManager:GetMonsterTaskShowInfo()
    self.lb_state.enabled = false

    local str = self:Setcontent(self.TaskShowInfo, 1, self.lb_content_target2)
    local mission = gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetMonsterArrestData():GetCurrentShowMonsterArrestMission()
    if mission then
        local monsterId = self:GetBoosIdByMission(mission)
        if monsterId then
            local monsteTbl = clientTableManager.cfg_monstersManager:TryGetValue(monsterId)
            if monsteTbl then
                str = "击杀" .. monsteTbl:GetName()
                self:RefreshMonsterArrestProgress(mission)
            end
        end
    end
    self.lb_content.text = self:Setcontent(self.TaskShowInfo, 0, self.lb_content_target)
    self.lb_content2.text = str
    self:SetSize(self.lb_content, self.lb_content2, self.lb_content_target, self.lb_content_target2)
    if not CS.StaticUtility.IsNull(self.underwayEffect) then
        self.underwayEffect.transform.localScale = CS.Vector3.zero;
    end
    self.monster_effect.gameObject:SetActive(CS.CSMissionManager.Instance.IsProgressMonsterTask)
end

function UIMissionInfoTemplates:RefreshMonsterArrestProgress(csmission)
    if csmission == nil then
        return
    end
    local TaskShowInfo = csmission:GetDailyTaskShowInfo()
    if TaskShowInfo == nil or TaskShowInfo.Count == 0 then
        return
    end
    local CurCount = TaskShowInfo[0].CurCount
    local MaxCount = TaskShowInfo[0].MaxCount
    if CurCount == 0 then
        CurCount = "[ff0000]" .. CurCount .. "[-]"
    elseif CurCount == MaxCount then
        if csmission.State == CS.ETaskV2_TaskState.HAS_SUBMIT then
            CurCount = "[878787]" .. CurCount .. "[-]"
        else
            CurCount = "[00ff00]" .. CurCount .. "[-]"
        end
    end
    local killNumber = CurCount .. "/" .. MaxCount
    self.lb_state.enabled = true
    self.lb_state.text = killNumber
end

---@return number 根据任务获取MonsterName
---@param mission CSMission
function UIMissionInfoTemplates:GetBoosIdByMission(mission)
    if mission == nil then
        return ""
    end
    local tbl_taskGoalS = mission.tbl_taskGoalS
    if tbl_taskGoalS == nil or tbl_taskGoalS.Count == 0 then
        return
    end
    local nowGoalS = tbl_taskGoalS[0]
    if nowGoalS == nil then
        return
    end
    local globleID = nowGoalS.taskGoalParam
    local bossID = 0
    if nowGoalS.taskGoalType == 85 then
        bossID = self:GetMissionGoalInfo(globleID)
    elseif nowGoalS.taskGoalType == 1 then
        bossID = nowGoalS.taskGoalParam
    end
    return bossID
end

---@return number 任务bossId
function UIMissionInfoTemplates:GetMissionGoalInfo(globleID)
    if self.mMissionGoalInfo == nil then
        self.mMissionGoalInfo = {}
    end
    local info = self.mMissionGoalInfo[globleID]
    if info == nil then
        local isfindG, dataG = CS.Cfg_GlobalTableManager.Instance:TryGetValue(globleID)
        if isfindG then
            local strList = _fSplit(dataG.value, '#')
            if strList ~= nil and #strList >= 1 then
                info = tonumber(strList[1])
                self.mMissionGoalInfo[globleID] = info
            end
        end
    end
    return info
end

---@return TABLE.CFG_ACTIVITY_BOSS 活动数据
function UIMissionInfoTemplates:GetActivityBossTableInfoCache(id)
    if id then
        if self.mIdToBossTableInfo == nil then
            self.mIdToBossTableInfo = {}
        end
        local info = self.mIdToBossTableInfo[id]
        if info == nil then
            ___, info = CS.Cfg_Activity_BossTableManager.Instance.dic:TryGetValue(id)
            self.mIdToBossTableInfo[id] = info
        end
        return info
    end
end

function UIMissionInfoTemplates:MonsterOnClick(go)
    uimanager:CreatePanel('UIMonsterArrestPanel')
end
--endregion
--region 任务数据处理
---设置描述
function UIMissionInfoTemplates:Setcontent(TaskShowInfo, number, contentMask, isNeedColor)
    if TaskShowInfo == nil then
        return ''
    end
    contentMask.gameObject:SetActive(true);
    local stateColor = ''
    if TaskShowInfo.Count <= number then
        return ''
    end
    --描述
    local describe = TaskShowInfo[number].Des
    local curCount = TaskShowInfo[number].CurCount
    local maxCount = TaskShowInfo[number].MaxCount
    if tonumber(curCount) < 10 then
        curCount = "  " .. curCount
    end
    if tonumber(maxCount) < 10 then
        maxCount = maxCount .. "  "
    end
    --条件
    local condition = curCount .. '/' .. maxCount
    local isReach = tonumber(curCount) >= tonumber(maxCount)
    if isReach then
        condition = self.Color_Green .. condition
    end
    if TaskShowInfo[number].MaxCount == 0 then
        condition = ""
    end
    self:TaskChange(condition, contentMask, number, curCount)
    if describe ~= "" then
        return describe
    else
        return ''
    end


end

---任务进行中数量发生变化
function UIMissionInfoTemplates:TaskChange(condition, contentMask, number, curCount)
    contentMask.gameObject:SetActive(true);
    contentMask.text = condition
    if self.OldTaskShowInfo == nil then
        return
    end
    if self.OldTaskShowInfo.Count <= number then
        return
    end
    if self.OldTaskShowInfo[number] == nil then
        return
    end
    if tonumber(self.OldTaskShowInfo[number].CurCount) == tonumber(curCount) then
        return
    end
    local TweenColor = CS.Utility_Lua.GetComponent(contentMask.gameObject, "Top_TweenColor")
    if TweenColor ~= nil then
        TweenColor:PlayTween()
    end

end

---任务类型
function UIMissionInfoTemplates:SetTaskType(TaskType)
    if TaskType == LuaEnumTaskType.MainTask then
        self.task_type.spriteName = 'zhuxian'
        self.bg2.spriteName = 'zhuxiandise'
        return '主线 '
    elseif TaskType == LuaEnumTaskType.Mercenary then
        self.task_type.spriteName = 'zhixian'
        self.bg2.spriteName = 'zhixiandise'
        return '雇佣 '
    elseif TaskType == LuaEnumTaskType.ToopTask then
        self.task_type.spriteName = 'zhixian'
        self.bg2.spriteName = 'zhixiandise'
        return '循环 '
    elseif TaskType == LuaEnumTaskType.Everyday then
        self.task_type.spriteName = 'richang'
        self.bg2.spriteName = 'richangdise'
        return '日常 '
    elseif TaskType == LuaEnumTaskType.SecondTask then
        self.task_type.spriteName = 'rein'
        self.bg2.spriteName = 'zhixiandise'
        return '支线'
    elseif TaskType == LuaEnumTaskType.MonsterArrest then
        self.task_type.spriteName = 'xuanshang'
        self.bg2.spriteName = 'xuanshangdise'
        return '悬赏'
    elseif TaskType == LuaEnumTaskType.ShengYu or TaskType == LuaEnumTaskType.YanHua then
        self.task_type.spriteName = 'ingot'
        self.bg2.spriteName = 'ingotdise'
        return '道具'
    elseif TaskType == LuaEnumTaskType.PersonDartCar_Normal then
        self.task_type.spriteName = 'Escort'
        self.bg2.spriteName = 'ingotdise'
        return '个人镖车'
    elseif TaskType == LuaEnumTaskType.Elite then
        self.task_type.spriteName = 'jingying'
        self.bg2.spriteName = 'jingyingdise'
        return '精英'
    elseif TaskType == LuaEnumTaskType.Boss then
        self.task_type.spriteName = 'BossTask'
        self.bg2.spriteName = 'BossTaskdise'
        return 'Boss'
    elseif TaskType == LuaEnumTaskType.Monster then
        self.task_type.spriteName = 'monsterarrest'
        self.bg2.spriteName = 'monsterarrestdise'
        return '怪物'
    elseif TaskType == LuaEnumTaskType.CrawlTower then
        self.task_type.spriteName = 'tower'
        self.bg2.spriteName = 'towerdise'
        return '闯天关'
    end
    return ''

end
--endregion
--region 位置面板设置
---设置面板大小
function UIMissionInfoTemplates:SetSize(content1, content2, mask1, mask2, state)
    ---描述1的宽度
    local content1_height = 0;
    ---描述2的宽度
    local content2_height = 0;
    ---顶部留白
    local TopInterval = self.TopInterval + 4
    ---底部留白
    local BottomBorder = self.BottomBorder;
    ---背景大小系数
    local bgSizeCoefficient = 1
    ---字体间距大小
    local LabelInterval = 4
    content1.fontSize = 18
    content2.fontSize = 18
    local content1Position = content1.transform.localPosition
    if content1.text ~= '' then
        content1Position.y = -self.TopInterval
        content1.transform.localPosition = content1Position

        local mask1Position = mask1.transform.localPosition
        mask1Position.y = -self.TopInterval
        mask1.transform.localPosition = mask1Position
        content1_height = content1.height
    end
    if content2.text == '' then
        TopInterval = 0
        BottomBorder = 0
        --设置描述一位置大小
        content1.fontSize = 18
        --设置描述一位置大小
        content1Position.y = -(self.bgSize_Y_Min)
        content1.transform.localPosition = content1Position
        --数量参数位置大小
        local mask1Position = mask1.transform.localPosition
        mask1Position.y = content1Position.y
        mask1.transform.localPosition = mask1Position
        bgSizeCoefficient = 2;
        self.lb_content_target2.gameObject:SetActive(false);
    end
    if content2.text ~= '' then
        content2_height = content2.height
        local newPosition = content1.transform.localPosition - CS.UnityEngine.Vector3(0, content1_height + self.LabelInterval, 0);
        content2.transform.localPosition = newPosition
        local mask2Position = mask2.transform.localPosition
        mask2Position.y = newPosition.y
        mask2.transform.localPosition = mask2Position
        LabelInterval = self.LabelInterval
    end

    local size_Y = content1_height + content2_height + self.bgSize_Y_Min * bgSizeCoefficient + BottomBorder + LabelInterval + TopInterval;

    local statePosition = self.lb_state.transform.localPosition
    statePosition.y = math.modf(self.bg2.transform.localPosition.y - size_Y / 2) - 1
    self.lb_state.transform.localPosition = statePosition
    self.lb_state.fontSize = 18
    self.bg.height = size_Y
    self.bg:ResizeCollider()
    self.bg2.height = size_Y
    if not CS.StaticUtility.IsNull(self.underwayEffect) and self.missionInfo ~= nil and self.missionInfo.showType == LuaEnumShowTaskType.Common then
        self:SetEffectSize(self.underwayEffect.gameObject)
    end
end

---设置面板位置
function UIMissionInfoTemplates:SetPosition(position_Y)
    local newPosition = self.go.transform.localPosition
    newPosition.y = position_Y
    self.go.transform.localPosition = newPosition
end

--endregion
--region 加载特效
---设置完成特效
function UIMissionInfoTemplates:LoadEffect(taskID)
    if self.OldmMission == nil then
        return
    end
    if self.OldmMission.taskId ~= taskID then
        return
    end
    if CS.StaticUtility.IsNull(self.completeEffect) or not CS.StaticUtility.IsNull(self.completeEffect.GameObject) then
        CS.CSResourceManager.Singleton:AddQueueCannotDelete("700001", CS.ResourceType.UIEffect, function(res)
            if res and res.MirrorObj then
                if self.bg ~= nil then
                    local poolItem = res:GetUIPoolItem(CS.EPoolType.Normal, 0, 2)
                    self.completeEffect = poolItem.go
                    if self.completeEffect then
                        local effectparent = self.bg.gameObject.transform
                        self.completeEffect.transform.parent = effectparent
                        self.completeEffect.transform.localPosition = CS.UnityEngine.Vector3(0, -self.bg.height / 2 - 1, 0)
                        self.completeEffect.transform.localScale = CS.UnityEngine.Vector3(100, self.bg.height * 2 - 20, 100)
                        if self.missionClipArea ~= nil then
                            self.missionClipArea:AddRenderList(self.completeEffect, true)
                        end
                    end
                end
            end
        end
        , CS.ResourceAssistType.UI)
    else
        self.completeEffect.transform.localPosition = CS.UnityEngine.Vector3(0, -self.bg.height / 2 - 1, 0)
        self.completeEffect.transform.localScale = CS.UnityEngine.Vector3(100, self.bg.height * 2 - 20, 100)
        self.completeEffect.gameObject:SetActive(false);
        self.completeEffect.gameObject:SetActive(true);
    end

end

---设置正在进行中特效
function UIMissionInfoTemplates:SetEffects(isopen)
    if self.mMission == nil then
        return
    end
    if self.underwayEffect == nil then
        CS.CSResourceManager.Singleton:AddQueueCannotDelete("700003", CS.ResourceType.UIEffect, function(res)
            if res and res.MirrorObj then
                if self.bg ~= nil then
                    if CS.StaticUtility.IsNull(self.underwayEffect) then
                        local poolItem = res:GetUIPoolItem()
                        if poolItem ~= nil then
                            self.underwayEffect = poolItem.go
                            local effectparent = self.bg.gameObject.transform
                            self.underwayEffect.transform.parent = effectparent
                            local isNeedShowEffect = false
                            if self.mMission ~= nil and self.mMission.tbl_tasks ~= nil and self.mMission.tbl_tasks.type == LuaEnumTaskType.MainTask and isopen then
                                isNeedShowEffect = true
                            end
                            self.underwayEffect:SetActive(isNeedShowEffect)
                            self:SetEffectSize(self.underwayEffect.gameObject)
                            if self.missionClipArea ~= nil then
                                self.missionClipArea:AddRenderList(self.underwayEffect, true)
                            end
                        end
                    end
                end
            end
        end
        , CS.ResourceAssistType.UI)
    else
        self.underwayEffect:SetActive(self.mMission.tbl_tasks.type == LuaEnumTaskType.MainTask and isopen)
        self:SetEffectSize(self.underwayEffect.gameObject)
    end
end

---设置日常活跃待领取特效
function UIMissionInfoTemplates:SetDailyEffects(open)
    if self.DailyEffect == nil then
        CS.CSResourceManager.Singleton:AddQueueCannotDelete("700149", CS.ResourceType.UIEffect, function(res)
            if res and res.MirrorObj then
                if self.bg ~= nil then
                    if CS.StaticUtility.IsNull(self.DailyEffect) then
                        local poolItem = res:GetUIPoolItem()
                        self.DailyEffect = poolItem.go
                        local effectparent = self.bg.gameObject.transform
                        self.DailyEffect.transform.parent = effectparent
                        self.DailyEffect.gameObject:SetActive(open)
                        -- CS.CSMissionManager.Instance.isProgressDailyTask=open
                        self:SetEffectSize(self.DailyEffect.gameObject)

                        if self.missionClipArea ~= nil then
                            self.missionClipArea:AddRenderList(self.DailyEffect, true)
                        end
                    end
                end
            end
        end
        , CS.ResourceAssistType.UI)
    else
        --  CS.CSMissionManager.Instance.isProgressDailyTask=open
        self.DailyEffect.gameObject:SetActive(open)
        self:SetEffectSize(self.DailyEffect.gameObject)
    end
end

function UIMissionInfoTemplates:SetEffectSize(underwayEffect)
    underwayEffect.transform.localPosition = CS.UnityEngine.Vector3(0, -self.bg.height / 2 + 0.5, 0)
    underwayEffect.transform.localScale = CS.UnityEngine.Vector3(100, self.bg.height * 2 - 20 - 4, 100)
end
--endregion

---点击任务执行任务
function UIMissionInfoTemplates:OnClick(go)
    if self.mClickEvent ~= nil then
        self.mClickEvent(self, go)
        return
    end
    if self.showType == LuaEnumShowTaskType.Common then
        self:CommonTaskOnClick()
    elseif self.showType == LuaEnumShowTaskType.Acitvity then
        self:AcitvityTaskOnClick()
    elseif self.showType == LuaEnumShowTaskType.Reward then
        self:RewardOnClick()
    elseif self.showType == LuaEnumShowTaskType.ShengYu then
        self:OnClickShengYuTask()
    elseif self.showType == LuaEnumShowTaskType.YanHua then
        self:OnClickYanHuaTask()
    elseif self.showType == LuaEnumTaskType.PersonDartCar_Normal then
        self:PersonDartCarOnClick(go)
    elseif self.showType == LuaEnumShowTaskType.Elite then
        self:EliteOnClick(go)
    elseif self.showType == LuaEnumShowTaskType.Boss then
        self:BossOnClick(go)
    elseif self.showType == LuaEnumShowTaskType.Monster then
        self:MonsterOnClick(go)
    elseif self.showType == LuaEnumShowTaskType.CrawlTower then
        self:CrawlTowerOnClick(go)
    end

    ---如果最近一次寻路失败,那么可以猜测在副本里不能抵达寻路目标点,所以先请求暂停并弹窗
    if CS.CSPathFinderManager.Instance.IsLatestPathFindRequestFailed then
        CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:TryPauseOperation(function()
            self:OnClick(go)
        end)
        return
    end
    ---设置特效
    self:CloseMiningPanel()
end

---重置UI
function UIMissionInfoTemplates:ResetUI()
    self:BindClickEvent(nil)
    self.completed.gameObject:SetActive(false)
    if self.completeEffect ~= nil and self.completeEffect.gameObject ~= nil then
        self.completeEffect.gameObject:SetActive(false)
    end
    if self.underwayEffect ~= nil and self.underwayEffect.gameObject ~= nil then
        self.underwayEffect.gameObject:SetActive(false)
    end
    if self.DailyEffect ~= nil and self.DailyEffect.gameObject ~= nil then
        self.DailyEffect.gameObject:SetActive(false)
    end
    self.lb_content.text = ''
    self.lb_content2.text = ''
    self.lb_content_target.text = ''
    self.lb_content_target2.text = ''
    self.lb_state.text = ''
    self.lb_statetextDes = ''
    if self.IenumRefreshTime ~= nil then
        StopCoroutine(self.IenumRefreshTime)
        self.IenumRefreshTime = nil
    end
end

---绑定点击事件
---@param clickEvent fun(template:UIMissionInfoTemplates,go:UnityEngine.GameObject)
function UIMissionInfoTemplates:BindClickEvent(clickEvent)
    if clickEvent ~= nil and type(clickEvent) ~= "function" then
        clickEvent = nil
    end
    self.mClickEvent = clickEvent
end

---点击任务关闭挖矿面板
function UIMissionInfoTemplates:CloseMiningPanel()
    local miningPanel = uimanager:GetPanel("UIMiningPanel")
    uimanager:ClosePanel(miningPanel)
end

function UIMissionInfoTemplates:IEnumRefreshTime(time, label)
    if label == nil or CS.StaticUtility.IsNull(label) then
        return
    end
    local isRefresh = true
    local refreshTime = time
    local defaultStr = self.showType == LuaEnumShowTaskType.Reward and luaEnumColorType.Gray .. '剩余时间 ' or ''
    local isMonsterRed = false
    local decimal = 0
    while isRefresh do
        if refreshTime <= 0 then
            isRefresh = false
            label.text = defaultStr .. "00:00:00"
            if self.IenumRefreshTime ~= nil then
                StopCoroutine(self.IenumRefreshTime)
                self.IenumRefreshTime = nil
            end
            return
        end
        local hour, minute, second = Utility.MillisecondToFormatTime(refreshTime)
        local str = string.format("%02.0f:%02.0f:%02.0f", hour, minute, second)
        if self.showType == LuaEnumShowTaskType.Reward then
            if minute < 2 and not isMonsterRed then
                isMonsterRed = true
                defaultStr = luaEnumColorType.Red .. '剩余时间'
            end
            minute, decimal = math.modf(minute)
            second, decimal = math.modf(second)
            str = string.format("%02.0f:%02.0f", minute, second)
        end
        label.text = defaultStr .. str
        refreshTime = refreshTime - 1000
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    end
end

---个人押镖时间刷新
function UIMissionInfoTemplates:PersonDartCarIEnumRefreshTime(time, label)
    if label == nil or CS.StaticUtility.IsNull(label) then
        return
    end
    local isRefresh = true
    local refreshTime = time
    local defaultStr = self.showType == LuaEnumShowTaskType.Reward and luaEnumColorType.Gray .. '剩余时间 ' or ''
    local isMonsterRed = false
    local decimal = 0
    while isRefresh do
        if refreshTime <= 0 then
            isRefresh = false
            label.text = defaultStr .. ""
            if self.IenumRefreshTime ~= nil then
                StopCoroutine(self.IenumRefreshTime)
                self.IenumRefreshTime = nil
            end
            return
        end
        local hour, minute, second = Utility.MillisecondToFormatTime(refreshTime)
        local str = string.format("%02.0f:%02.0f:%02.0f", hour, minute, second)
        if self.showType == LuaEnumShowTaskType.Reward then
            if minute < 2 and not isMonsterRed then
                isMonsterRed = true
                defaultStr = luaEnumColorType.Red .. '剩余时间'
            end
            minute, decimal = math.modf(minute)
            second, decimal = math.modf(second)
            str = string.format("%02.0f:%02.0f", minute, second)
        end
        label.text = defaultStr .. str
        refreshTime = refreshTime - 1000
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    end
end

function ondestroy()
    if self.IenumRefreshTime ~= nil then
        StopCoroutine(self.IenumRefreshTime)
        self.IenumRefreshTime = nil
    end
end

return UIMissionInfoTemplates