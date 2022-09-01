---@class UIBossChallengePanel:UIBase 首领挑战
local UIBossChallengePanel = {}

--region组件
---@return UnityEngine.GameObject 关闭按钮
function UIBossChallengePanel:GetCloseBtn_Go()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/window/btn_close", "GameObject")
    end
    return self.mCloseBtn
end

---@return UnityEngine.GameObject boss节点
function UIBossChallengePanel:GetBossRoot_GO()
    if self.mBossRootGo == nil then
        self.mBossRootGo = self:GetCurComp("WidgetRoot/view/boss", "GameObject")
    end
    return self.mBossRootGo
end

---@return UnityEngine.GameObject 完成节点
function UIBossChallengePanel:GetFinishRoot_GO()
    if self.mFinishGo == nil then
        self.mFinishGo = self:GetCurComp("WidgetRoot/view/complete", "GameObject")
    end
    return self.mFinishGo
end

---@return UILabel 进度
function UIBossChallengePanel:GetProgress_UILabel()
    if self.mProgressLb == nil then
        self.mProgressLb = self:GetCurComp("WidgetRoot/view/slogan/num", "UILabel")
    end
    return self.mProgressLb
end

---@return UILoopScrollViewPlus 任务组件
function UIBossChallengePanel:GetTaskLoop_UILoopScrollViewPlus()
    if self.mTaskLoop == nil then
        self.mTaskLoop = self:GetCurComp("WidgetRoot/view/boss/scroll/Grid", "UILoopScrollViewPlus")
    end
    return self.mTaskLoop
end

---@return Top_OptimizeClipShaderScript
function UIBossChallengePanel:GetClipShader()
    if self.mClipShader == nil then
        self.mClipShader = self:GetCurComp("WidgetRoot/view/boss/scroll", "Top_OptimizeClipShaderScript")
    end
    return self.mClipShader
end
--endregion

--region 初始化
function UIBossChallengePanel:Init()
    self:BindEvents()
    self:BindMessage()
end

function UIBossChallengePanel:Show()
    self:RefreshAllTask(true)
end

function UIBossChallengePanel:BindEvents()
    CS.UIEventListener.Get(self:GetCloseBtn_Go()).onClick = function()
        self:ClosePanel()
    end
end

function UIBossChallengePanel:BindMessage()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ChallengeBossDataChange, function()
        self:RefreshAllTask()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged,function()
        self:OnResBagItemChanged()
    end)
end
--endregion

--region 显示任务
---刷新任务显示
function UIBossChallengePanel:RefreshAllTask(isInit)
    self:GetBossRoot_GO():SetActive(false)
    self:GetFinishRoot_GO():SetActive(false)
    ---@type taskV2.ResAllNewDailyTaskInfo
    local totalData = gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetChallengeBossData():GetAllChallengeBossData()
    if totalData == nil then
        return
    end
    local time = totalData.tadayCount
    local totalTime = LuaGlobalTableDeal:GetChallengeBossTimes()
    if time == nil or totalTime == nil then
        return
    end

    local allMission = totalData.state
    local hasMission = time < totalTime
    self:GetProgress_UILabel().text = Utility.CombineStringQuickly("剩余次数    ", totalTime - time, "/", totalTime)
    self:GetBossRoot_GO():SetActive(hasMission)
    self:GetFinishRoot_GO():SetActive(not hasMission)
    if hasMission then
        self:GetTaskLoop_UILoopScrollViewPlus():Init(function(go, line)
            if line < #allMission then
                ---@type taskV2.NewDailyTaskState
                local data = allMission[line + 1]
                local template = self:GetMissionTemplate(go)
                if template then
                    template:RefreshMission(data, self:GetClipShader(), totalData.taskId)
                end
                return true
            else
                return false
            end
        end, nil)

    end
    if isInit and #allMission == 0 then
        local info = clientTableManager.cfg_promptframeManager:TryGetValue(485)
        if info and info:GetContent() then
            CS.Utility.ShowTips(info:GetContent(), 1.5, CS.ColorType.Red)
        end
        uimanager:ClosePanel("UIBossChallengePanel")
    end
end

function UIBossChallengePanel:OnResBagItemChanged()
    if type(self.mGoToTemplate) == 'table' then
        for k,v in pairs(self.mGoToTemplate) do
            ---@type UIBossChallengePanel_MissionTemplate
            local template = v
            template:RefreshClear()
        end
    end
end

---@return UIBossChallengePanel_MissionTemplate
function UIBossChallengePanel:GetMissionTemplate(go)
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIBossChallengePanel_MissionTemplate)
        self.mGoToTemplate[go] = template
    end
    return template
end
--endregion


return UIBossChallengePanel