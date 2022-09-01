---@class UIBossKillTipsPanel:UIBase
local UIBossKillTipsPanel = {}

function UIBossKillTipsPanel:InitComponents()

    self.PublicRoot = self:GetCurComp('WidgetRoot/view/Public', 'GameObject')

    self.blackbox = self:GetCurComp('WidgetRoot/blackbox', 'GameObject')

    ---center
    ---名称
    self.name = self:GetCurComp('WidgetRoot/view/lab_name', 'UILabel')
    ---击杀数量
    self.killNumber = self:GetCurComp('WidgetRoot/view/lab_killNum', 'UILabel')
    ---奖励
    self.rewardList = self:GetCurComp('WidgetRoot/view/DropItem', 'GameObject')

    ---down
    ---前往击杀
    self.btn_GotoKill = self:GetCurComp('WidgetRoot/view/btn_go', 'GameObject')
    self.btn_GotoKillSprite = self:GetCurComp('WidgetRoot/view/btn_go', 'UISprite')
    self.btn_GotoKill_Label = self:GetCurComp('WidgetRoot/view/btn_go/Label', 'UILabel')
    self.btn_GotoKilleffect1 = self:GetCurComp('WidgetRoot/view/btn_get/effect', 'GameObject')
    self.btn_GotoKilleffect2 = self:GetCurComp('WidgetRoot/view/btn_double/effect', 'GameObject')

    ---领取奖励
    self.btn_get = self:GetCurComp('WidgetRoot/view/btn_get', 'GameObject')
    ---二倍领取
    self.btn_double = self:GetCurComp('WidgetRoot/view/btn_double', 'GameObject')
    ---二倍领取花费
    self.cost = self:GetCurComp('WidgetRoot/view/cost', 'GameObject')
    self.costLabel = self:GetCurComp('WidgetRoot/view/cost', 'UILabel')
    self.costIcon = self:GetCurComp('WidgetRoot/view/cost/Sprite', 'UISprite')

    ---普通背景
    self.background = self:GetCurComp('WidgetRoot/window/background', 'GameObject')
    ---Boss背景
    self.background_boss = self:GetCurComp('WidgetRoot/window/background_boss', 'GameObject')

end

function UIBossKillTipsPanel:InitOther()
    self.btn_GotoKilleffect1.gameObject:SetActive(false)
    self.btn_GotoKilleffect2.gameObject:SetActive(false)
    CS.UIEventListener.Get(self.btn_GotoKill).onClick = function(go)
        self:GotoKill(go)
    end
    CS.UIEventListener.Get(self.btn_get).onClick = self.OnwReceiveAward
    CS.UIEventListener.Get(self.btn_double).onClick = function(go)
        self:TwoReceiveAward(go)
    end
    CS.UIEventListener.Get(self.blackbox).onClick = self.OnClikeBlackbox
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Task_EliteSelectLevel, self.RefreShNowSelectLevelInfo)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResEliteTaskInfoPanelMessage, UIBossKillTipsPanel.OnResEliteTaskInfoPanelMessage)
    UIBossKillTipsPanel:GetClientEventHandler():AddEvent(CS.CEvent.Task_GoalUpdate, UIBossKillTipsPanel.OnResEliteTaskInfoPanelMessage)
end

function UIBossKillTipsPanel:Init()
    self:InitComponents()
    self:InitOther()
end

---@type UIEliteMissionTemplates
UIBossKillTipsPanel.Headtemplate = nil

function UIBossKillTipsPanel:Show(data)
    self.offsPositionX = 0
    self.offsPositionY = 0
    if data ~= nil then
        self.offsY = data.offsY
        self.offsPositionY = data.offsPositionY
        self.offsPositionX = data.offsPositionX
        self.type = data.type
    end
    if self.type == nil then
        self.type = LuaEnumTaskType.Elite
    end
    self.position = self.go.transform.position
    self.position.x = self.offsPositionX
    self.position.y = self.offsPositionY
    self.go.transform.position = self.position

    self.localPosition = self.go.transform.localPosition
    self.localPosition.x = 150 + self.localPosition.x
    self.localPosition.y = -10 + self.localPosition.y
    self.go.transform.localPosition = self.localPosition
    self.isInit = false
    self.InitData()
    self:RefreshUI()
end

---初始化数据
function UIBossKillTipsPanel.InitData()
    local self = UIBossKillTipsPanel
    self.csmission = nil  -- CS.CSMissionManager.Instance:GetEliteTask()
    if self.type == LuaEnumTaskType.Elite then
        self.csmission = CS.CSMissionManager.Instance:GetEliteTask()
    elseif self.type == LuaEnumTaskType.Boss then
        self.csmission = CS.CSMissionManager.Instance:GetBossTask()
    end
    if self.csmission == nil then
        uimanager:ClosePanel('UIBossKillTipsPanel')
        return
    end
    self.Tab_Task = self.csmission.tbl_tasks
    self.tbl_taskBoss = self.csmission.tbl_taskBoss
    ---CS.List<TaskShowInfo> 
    self.TaskShowInfoList = self.csmission:GetDailyTaskShowInfo()
    self.TaskBossSelect = nil
    -- self.TaskBossList = Utility.GetTaskBossLevelListInfo(self.tbl_taskBoss)
    -- self.TaskBossTypeList = Utility.GetTaskBossTypeListInfo(self.tbl_taskBoss)
end

function UIBossKillTipsPanel:RefreshUI()
    local self = UIBossKillTipsPanel
    if self.Headtemplate == nil then
        self.Headtemplate = templatemanager.GetNewTemplate(self.PublicRoot, luaComponentTemplates.UIEliteMissionTemplates)
    end
    if self.rewardtemplate == nil then
        self.rewardtemplate = templatemanager.GetNewTemplate(self.rewardList, luaComponentTemplates.UIMissionRewardTemplates)
    end
    self.Headtemplate:InitData(self.csmission,LuaEnumUseUIEliteMissionTemplateSource.BossSkillTips)
    self.Headtemplate:RefreShBg( self.background, self.background_boss)
    self.rewardtemplate:InitData(self.Tab_Task)
    self.ShowBtn()
end

---设置按钮描述
function UIBossKillTipsPanel.ShowBtn()
    local nowTask = UIBossKillTipsPanel.csmission
    if nowTask ~= nil and nowTask.tbl_tasks ~= nil then
        UIBossKillTipsPanel.btn_GotoKill.gameObject:SetActive(nowTask.State ~= CS.ETaskV2_TaskState.HAS_COMPLETE)
        ---领取奖励
        UIBossKillTipsPanel.btn_get.gameObject:SetActive(nowTask.State == CS.ETaskV2_TaskState.HAS_COMPLETE)
        ---二倍领取
        UIBossKillTipsPanel.btn_double.gameObject:SetActive(nowTask.State == CS.ETaskV2_TaskState.HAS_COMPLETE)
        ---二倍领取花费
        UIBossKillTipsPanel.cost.gameObject:SetActive(nowTask.State == CS.ETaskV2_TaskState.HAS_COMPLETE)

        UIBossKillTipsPanel.SetTwoBuy()
    end
end

function UIBossKillTipsPanel.SetTwoBuy()
    local nowTask = UIBossKillTipsPanel.csmission
    if nowTask == nil or nowTask.tbl_tasks == nil then
        return
    end
    local mutireward = nowTask.tbl_tasks.mutireward
    if mutireward == nil or mutireward == "" then
        UIBossKillTipsPanel.btn_get.gameObject.transform.localPosition = CS.UnityEngine.Vector3(137.7, -194, 0);
        UIBossKillTipsPanel.btn_double.gameObject:SetActive(false)
        UIBossKillTipsPanel.cost.gameObject:SetActive(false)
        UIBossKillTipsPanel.btn_GotoKilleffect1.gameObject:SetActive(true)
        UIBossKillTipsPanel.btn_GotoKilleffect2.gameObject:SetActive(false)
        return
    else
        UIBossKillTipsPanel.btn_get.gameObject.transform.localPosition = CS.UnityEngine.Vector3(82, -194, 0);
        UIBossKillTipsPanel.btn_GotoKilleffect1.gameObject:SetActive(false)
        UIBossKillTipsPanel.btn_GotoKilleffect2.gameObject:SetActive(true)
    end

    local mutirewardList = _fSplit(mutireward, '#')
    if #mutirewardList ~= 3 then
        return
    end
    ---道具ID
    local itemid = mutirewardList[1]
    ---花费
    local costs = mutirewardList[2]
    ---倍数
    local multiple = mutirewardList[3]
    local isfind, item = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemid)
    local bagCostCoinNum = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(itemid)
    local labelColor = ternary(bagCostCoinNum >= tonumber(costs), luaEnumColorType.White, luaEnumColorType.Red)
    if isfind then
        UIBossKillTipsPanel.costIcon.spriteName = item.icon
    end
    UIBossKillTipsPanel.costLabel.text = labelColor .. costs

end

---一倍领取奖励
function UIBossKillTipsPanel:OnwReceiveAward()
    networkRequest.ReqSubmitTask(UIBossKillTipsPanel.csmission.tbl_tasks.id, 1)
    uimanager:ClosePanel('UIBossKillTipsPanel')
end

---二倍领取奖励
function UIBossKillTipsPanel:TwoReceiveAward(go)
    local nowTask = UIBossKillTipsPanel.csmission
    if nowTask ~= nil and nowTask.tbl_tasks ~= nil and nowTask.tbl_tasks.mutireward ~= nil and CS.StaticUtility.IsNullOrEmpty(nowTask.tbl_tasks.mutireward) == false then
        local mutirewardList = _fSplit(nowTask.tbl_tasks.mutireward, '#')
        if #mutirewardList ~= 3 then
            networkRequest.ReqSubmitTask(UIBossKillTipsPanel.csmission.tbl_tasks.id, 2)
            uimanager:ClosePanel('UIBossKillTipsPanel')
            return
        end
        ---道具ID
        local itemid = mutirewardList[1]
        ---花费
        local costs = mutirewardList[2]
        ---倍数
        local multiple = mutirewardList[3]
        local bagCostCoinNum = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(itemid)
        if bagCostCoinNum < tonumber(costs) then
            --Utility.ShowPopoTips(go.transform, nil, 411)
            Utility.JumpRechargePanel(go)
            return
        end
        networkRequest.ReqSubmitTask(UIBossKillTipsPanel.csmission.tbl_tasks.id, 2)
        uimanager:ClosePanel('UIBossKillTipsPanel')
    end
end

---前往击杀
function UIBossKillTipsPanel:GotoKill()
    local this = UIBossKillTipsPanel
    local nowSelectBoss = this.TaskBossSelect

    if nowSelectBoss == nil or type(nowSelectBoss) == "number" then
        return
    end

    local type = tonumber(this.tbl_taskBoss.type)
    if this.tbl_taskBoss ~= nil and (type == LuaEnumTaskBossType.Boss or type == LuaEnumTaskBossType.Elite) then
        if self.Headtemplate then
            local bossId = self.Headtemplate.mCurrentChooseMonsterId
            if bossId then
                local data = {}
                data.targetMonsterId = bossId
                uiTransferManager:TransferToPanel(tonumber(nowSelectBoss.JumpID), data)
            end
        end
        return
    end

    --[[
        if this.tbl_taskBoss ~= nil and tonumber(this.tbl_taskBoss.type) == LuaEnumTaskBossType.Boss then
            uiTransferManager:TransferToPanel(tonumber(nowSelectBoss.JumpID))
            return
        elseif tonumber(this.tbl_taskBoss.type) == LuaEnumTaskBossType.Elite then
            uiTransferManager:TransferToPanel(tonumber(nowSelectBoss.JumpID))
            return
        end
    ]]

    local mapID = nowSelectBoss.MapID
    local BranchmapID = nowSelectBoss.BranchmapID
    --local deliverID = nowSelectBoss.DeliverID

    if mapID == CS.CSScene.getMapID() or BranchmapID == CS.CSScene.getMapID() then
        CS.CSAutoFightMgr.Instance:Toggle(true);
        CS.Utility.ShowTips("[ffe7be]已在目标地图[-]", 1.5, CS.ColorType.White)
    else
        networkRequest.ReqTaskBossDeliver(this.tbl_taskBoss.id, mapID)
        --  networkRequest.ReqDeliverByConfig(deliverID, false)
    end
    uimanager:ClosePanel('UIBossKillTipsPanel')
end

function UIBossKillTipsPanel.RefreShNowSelectLevelInfo(id, data)
    UIBossKillTipsPanel.TaskBossSelect = data
end

function UIBossKillTipsPanel.OnClikeBlackbox()
    uimanager:ClosePanel('UIBossKillTipsPanel')
end

function UIBossKillTipsPanel.OnResEliteTaskInfoPanelMessage()
    UIBossKillTipsPanel.InitData()
    UIBossKillTipsPanel:RefreshUI()
end

return UIBossKillTipsPanel
