---@class UIMonsterArrestPanelTemplate:TemplateBase
local UIMonsterArrestPanelTemplate = {}

function UIMonsterArrestPanelTemplate:InitComponents()

    ---top
    ---怪物名称
    self.lab_name = self:Get('view/Public/lab_name', 'UILabel')
    ---boss头像
    self.bossHead = self:Get('view/Public/BossHead/bossHead/headIcon', 'UISprite')
    ---boss头像背景
    ---@type UISprite
    self.bossHeadBg = self:Get('view/Public/BossHead/bossHead/headIconbg', 'UISprite')
    ---boss转生
    self.bossLevel = self:Get('view/Public/BossHead/lb_lv', 'UILabel')

    self.mBossHeadRoot = self:Get("view/Public/BossHead", "GameObject")
    ---击杀数量
    self.lab_killNum = self:Get('view/Public/lab_killNum', 'UILabel')

    ---centre
    ---任务奖励列表
    self.DropItem = self:Get('view/DropItem', 'Top_UIGridContainer')

    ---down
    ---前往击杀按钮图片
    self.btn_goSprite = self:Get('view/btn_go', 'UISprite')
    ---按钮描述
    self.btn_goLabel = self:Get('view/btn_go/Label', 'UILabel')
    ---按钮特效
    self.btn_goEffect = self:Get('view/btn_go/effect', 'GameObject')
    ---前往击杀按钮
    self.isCompleted = self:Get('view/isCompleted', 'GameObject')

    ---背景
    self.background = self:Get('window/background', 'UISprite')

    ---@type UnityEngine.GameObject
    self.mModelRoot = self:Get("view/modelScroll/Model", "GameObject")

end
function UIMonsterArrestPanelTemplate:InitOther()

end

---@param fatherPanel UIMonsterArrestPanel
function UIMonsterArrestPanelTemplate:Init(fatherPanel)
    self.fatherPanel = fatherPanel
    self:InitComponents()
    self:InitOther()

end

function UIMonsterArrestPanelTemplate:RefreshUI(csmission, group, index, clipShader)
    self.OptimizeClipShaderScript = clipShader
    self.mBossId = nil
    local tblGroupData = clientTableManager.cfg_activity_bossManager:TryGetValue(group)
    if tblGroupData == nil then
        return
    end
    local bossIdList = tblGroupData:GetModelParam().list
    if index and index > 0 and bossIdList and index <= #bossIdList then
        self.mBossId = bossIdList[index]
    end
    if csmission == nil then
        return
    end
    ---任务数据
    self.csmission = csmission
    ---任务表
    self.tbl_tasks = csmission.tbl_tasks
    ---taskGoals表列表
    self.tbl_taskGoalS = csmission.tbl_taskGoalS
    ---服务器任务数据
    self.nowtaskGoalInfo = csmission.taskParam
    self:RefreshBossInfo()
    self:RefreshDropItem(self.tbl_tasks)
    self:RefreshTaskSchedule(self.csmission)
    self:SetAllGrey()
end

---刷新boss信息
function UIMonsterArrestPanelTemplate:RefreshBossInfo()
    local monsterId = self.fatherPanel:GetBoosIdByMission(self.csmission)
    ---其实是monsterId
    self.monsterId = monsterId
    self.mBossHeadRoot:SetActive(self.mBossId == nil)

    local data = self:GetMonsterTableCache(monsterId)
    if data and CS.StaticUtility.IsNull(self.lab_name) == false then
        local isfindc, color = CS.Cfg_GlobalTableManager.Instance.monsterNameColorDic:TryGetValue(data.type)
        if isfindc then
            if self.csmission.State == CS.ETaskV2_TaskState.HAS_SUBMIT then
                color = CS.UnityEngine.Color.gray
            end
            self.lab_name.color = color
        end
        self.lab_name.text = data.name
        self.bossHead.spriteName = data.head
        if data.level ~= 0 then
            self.bossLevel.text = data.level
        else
            self.bossLevel.text = data.reinLv .. "转"
        end
        local type = data.type
        local sp = self:GetBossHeadBgSp(type)
        if sp then
            self.bossHeadBg.gameObject:SetActive(true)
            self.bossHeadBg.spriteName = sp
        end
    end

    local bossTable = clientTableManager.cfg_bossManager:TryGetValue(self.mBossId)
    local monsterTable = clientTableManager.cfg_monstersManager:TryGetValue(self.monsterId)
    self:ShowModel(bossTable, monsterTable)
end

---@return TABLE.CFG_MONSTERS
function UIMonsterArrestPanelTemplate:GetMonsterTableCache(id)
    if self.fatherPanel then
        return self.fatherPanel:GetMonsterTableCache(id)
    end
end

function UIMonsterArrestPanelTemplate:GetBossHeadBgSp(type)
    if self.fatherPanel then
        return self.fatherPanel:GetBossHeadBgSp(type)
    end
end

---刷新奖励列表
function UIMonsterArrestPanelTemplate:RefreshDropItem(Tab_Task)
    if self.rewardtemplate == nil then
        self.rewardtemplate = templatemanager.GetNewTemplate(self.DropItem, luaComponentTemplates.UIMissionRewardTemplates)
    end
    self.rewardtemplate:InitData(Tab_Task, self.csmission.State == CS.ETaskV2_TaskState.HAS_SUBMIT)
end

---刷新任务进度
function UIMonsterArrestPanelTemplate:RefreshTaskSchedule(csmission)
    local killNumber = gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetMonsterArrestData():GetMissionProgress(csmission, true, true)
    if self.nowtaskGoalInfo ~= nil and self.nowtaskGoalInfo > 0 and self.csmission.State ~= CS.ETaskV2_TaskState.HAS_SUBMIT then
        killNumber = '可悬赏' .. '[00ff00]' .. tostring(self.nowtaskGoalInfo) .. "[-]" .. '次'
    end
    self.lab_killNum.text = killNumber
end

---刷新领奖按钮
function UIMonsterArrestPanelTemplate:RefreshPrizeBtn(csmission)
    if csmission == nil then
        return
    end
    if csmission.State == CS.ETaskV2_TaskState.HAS_ACCEPT then
        self.btn_goLabel.text = "[c3F4FF]前往击杀[-]"
        self.btn_goSprite.spriteName = "anniu1"
    elseif csmission.State == CS.ETaskV2_TaskState.HAS_COMPLETE then
        self.btn_goLabel.text = "领取奖励"
        self.btn_goSprite.spriteName = "anniu10"
    elseif csmission.State == CS.ETaskV2_TaskState.HAS_SUBMIT then
        self.btn_goLabel.text = "已提交"
    end
    self.btn_go.gameObject:SetActive(csmission.State ~= CS.ETaskV2_TaskState.HAS_SUBMIT)
    self.isCompleted.gameObject:SetActive(csmission.State == CS.ETaskV2_TaskState.HAS_SUBMIT)
    self.btn_goEffect.gameObject:SetActive(csmission.State == CS.ETaskV2_TaskState.HAS_COMPLETE)
end

function UIMonsterArrestPanelTemplate:SetAllGrey()
    local color = CS.UnityEngine.Color.white
    if self.csmission.State == CS.ETaskV2_TaskState.HAS_SUBMIT then
        color = CS.UnityEngine.Color.black
    end
    self.bossHead.color = color
    self.background.color = color
    -- self.bossHead.color= color
    self.bossHeadBg.color = color
end

function UIMonsterArrestPanelTemplate:OnClickBtn_go(go)
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.AsyncOperationController:Stop();
        CS.CSMissionManager.Instance:ClearCurrentTask();
    end

    if self.fatherPanel ~= nil then
        self.fatherPanel:SaveChooseBtn(go)
    end
    if self.csmission.State == CS.ETaskV2_TaskState.HAS_ACCEPT then
        CS.CSMissionManager.Instance.NowMonsterTask = self.csmission
        local tbl_taskGoalS = self.csmission.tbl_taskGoalS
        local globalNumber = ""
        if tbl_taskGoalS ~= nil and tbl_taskGoalS.Length >= 1 then
            globalNumber = tbl_taskGoalS[0].global
        end
        if globalNumber ~= "" then

            local data = {}
            data.targetMonsterId = self.monsterId
            uiTransferManager:TransferToPanel(tonumber(globalNumber), data)
            return
        end

        networkRequest.ReqTaskRandomReq(0, 0, 0, 1, 0, self.tbl_tasks.id)
    elseif self.csmission.State == CS.ETaskV2_TaskState.HAS_COMPLETE then
        if CS.CSScene.MainPlayerInfo.BagInfo.EmptyGridCount < self.rewardtemplate.rewardList.MaxCount then
            ---若背包空位不足,则提示回收气泡
            Utility.ShowPopoTips(go, "背包已满，请先回收", 290, "UIMonsterArrestPanel")
        else
            networkRequest.ReqSubmitTask(self.csmission.tbl_tasks.id, 1)
            if self.rewardtemplate ~= nil then
                self.rewardtemplate:ItemFly()
            end

            CS.CSMissionManager.Instance.NowMonsterTask = nil
        end
    elseif self.csmission.State == CS.ETaskV2_TaskState.HAS_SUBMIT then
    end
end

---显示模型
---@param bossTable TABLE.cfg_boss
---@param monsterTable TABLE.cfg_monsters
function UIMonsterArrestPanelTemplate:ShowModel(bossTable, monsterTable)
    local RootGO = self.mModelRoot
    if bossTable == nil or monsterTable == nil or RootGO == nil then
        return
    end
    if self.ObservationModel == nil then
        self.ObservationModel = CS.ObservationModel()
    end
    --self.ObservationModel:ClearModel()
    self.ObservationModel.DefalutShaderType = 1
    self.ObservationModel:SetShowMotion(CS.CSMotion.Stand)
    self.ObservationModel:SetBindRenderQueue()
    self.ObservationModel:SetDragRoot(RootGO)
    local Scale = monsterTable:GetScale() * bossTable:GetModelScale() / 10000
    ---设置旋转
    self.ObservationModel:SetRotation(CS.UnityEngine.Vector3(27, 132, -27))
    self.ObservationModel:ResetCurScale()
    ---设置缩放
    self.ObservationModel:SetScaleSizeforRatio(Scale)
    ---设置位置
    self.ObservationModel:SetPosition(CS.UnityEngine.Vector3(bossTable:GetOffsetX(), bossTable:GetOffsetY(), 1500))
    ---创建模型
    self.ObservationModel:CreateModel(monsterTable:GetModel(), CS.EAvatarType.Monster, RootGO.transform, function()
        if self.OptimizeClipShaderScript ~= nil and self.ObservationModel ~= nil then
            self.OptimizeClipShaderScript:AddRenderList(self.ObservationModel.ModelRoot, true, false, true, false);
        end
    end)

end

return UIMonsterArrestPanelTemplate