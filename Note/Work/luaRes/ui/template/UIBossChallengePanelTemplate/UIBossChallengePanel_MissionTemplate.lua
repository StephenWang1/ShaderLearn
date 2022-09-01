---@class UIBossChallengePanel_MissionTemplate:TemplaeBase 挑战boss任务模板
local UIBossChallengePanel_MissionTemplate = {}

--region 组件
---@return UnityEngine.GameObject
function UIBossChallengePanel_MissionTemplate:GetBtn_Go()
    if self.mBtn == nil then
        self.mBtn = self:Get("btn", "GameObject")
    end
    return self.mBtn
end

---@return UILabel
function UIBossChallengePanel_MissionTemplate:GetBtn_Lb()
    if self.mBtnLb == nil then
        self.mBtnLb = self:Get("btn/Label", "UILabel")
    end
    return self.mBtnLb
end

---@return UISprite
function UIBossChallengePanel_MissionTemplate:GetBtnSp()
    if self.mBtnSp == nil then
        self.mBtnSp = self:Get("btn/backGround", "UISprite")
    end
    return self.mBtnSp
end

---@return UILabel
function UIBossChallengePanel_MissionTemplate:GetMonsterName_Lb()
    if self.mMonsterNameLb == nil then
        self.mMonsterNameLb = self:Get("name", "UILabel")
    end
    return self.mMonsterNameLb
end

---@return UnityEngine.GameObject
function UIBossChallengePanel_MissionTemplate:GetModelRoot_GO()
    if self.mModelRoot == nil then
        self.mModelRoot = self:Get("modelScroll/Model", "GameObject")
    end
    return self.mModelRoot
end

---@return UIGridContainer
function UIBossChallengePanel_MissionTemplate:GetRewardContainer_UIGridContainer()
    if self.mAwardGrid == nil then
        self.mAwardGrid = self:Get("dropScroll/AwardGrid", "UIGridContainer")
    end
    return self.mAwardGrid
end

---@return UILabel
function UIBossChallengePanel_MissionTemplate:GetProgress_Lb()
    if self.mProgressLb == nil then
        self.mProgressLb = self:Get("killNum", "UILabel")
    end
    return self.mProgressLb
end

---@return UnityEngine.GameObject 领奖特效
function UIBossChallengePanel_MissionTemplate:GetRewardEffect()
    if self.mRewardEffect == nil then
        self.mRewardEffect = self:Get("btn/effect", "GameObject")
    end
    return self.mRewardEffect
end

---@return UnityEngine.GameObject 完成文本
function UIBossChallengePanel_MissionTemplate:GetFinish_Go()
    if self.mFinishGo == nil then
        self.mFinishGo = self:Get("complete", "GameObject")
    end
    return self.mFinishGo
end

---@return UnityEngine.GameObject 扫荡模块
function UIBossChallengePanel_MissionTemplate:GetDoubleBtn_Go()
    if self.mDoubleBtn_Go == nil then
        self.mDoubleBtn_Go = self:Get("doubleBtn", "GameObject")
    end
    return self.mDoubleBtn_Go
end

---@return CompleteTemplate 扫荡模板
function UIBossChallengePanel_MissionTemplate:GetCompleteTemplate()
    if self.CompleteTemplate == nil and CS.StaticUtility.IsNull(self:GetDoubleBtn_Go()) == false then
        self.CompleteTemplate = templatemanager.GetNewTemplate(self:GetDoubleBtn_Go(), luaComponentTemplates.CompleteTemplate)
    end
    return self.CompleteTemplate
end

---@return UnityEngine.GameObject 领取奖励模块
function UIBossChallengePanel_MissionTemplate:GetRewardBtn_Go()
    if self.mRewardBtn_Go == nil then
        self.mRewardBtn_Go = self:Get("rewardBtn", "GameObject")
    end
    return self.mRewardBtn_Go
end

---@return RewardTemplate 领取奖励模板
function UIBossChallengePanel_MissionTemplate:GetRewardTemplate()
    if self.RewardTemplate == nil and CS.StaticUtility.IsNull(self:GetRewardBtn_Go()) == false then
        self.RewardTemplate = templatemanager.GetNewTemplate(self:GetRewardBtn_Go(), luaComponentTemplates.RewardTemplate)
    end
    return self.RewardTemplate
end
--endregion

--region 初始化
function UIBossChallengePanel_MissionTemplate:Init()
    self.mMonsterId = nil
    CS.UIEventListener.Get(self:GetBtn_Go()).onClick = function()
        self:OnBtnClicked()
    end
end
--endregion

--region刷新
---@param mission taskV2.NewDailyTaskState
function UIBossChallengePanel_MissionTemplate:RefreshMission(mission, clipShader, taskId)
    if mission == nil or taskId == nil then
        return
    end
    self.OptimizeClipShaderScript = clipShader
    self.mMission = mission
    self.mTaskId = taskId
    self.bossCanClear = false
    if self.mMission ~= nil and type(self.mMission.bossId) == 'number' then
        self.bossTbl = clientTableManager.cfg_bossManager:TryGetValue(self.mMission.bossId)
    end
    if type(self.mTaskId) == 'number' then
        self.bossCanClear = clientTableManager.cfg_boss_taskManager:TaskCanClear(self.mTaskId)
    end
    self:RefreshBtn()
    self:RefreshMonster()
    self:RefreshRewardAndCost()
    self:RefreshProgress()
    self:RefreshClear()
end

--region按钮
---刷新按钮
function UIBossChallengePanel_MissionTemplate:RefreshBtn()
    local des = ""
    local sp = ""
    --1：未接取 2：已接取 3: 已完成 4：已领取
    local state = self.mMission.state
    if state == 1 then
        des = luaEnumColorType.Blue .. "接取任务"
        sp = "anniu16"
    elseif state == 2 then
        des = luaEnumColorType.Red3 .. "前往击杀"
        sp = "anniu14"
    elseif state == 3 then
        des = luaEnumColorType.SimpleYellow1 .. "领取奖励"
        sp = "anniu15"
    elseif state == 4 then
    end
    self:GetBtn_Lb().text = des
    self:GetBtnSp().spriteName = sp
    self:GetCompleteTemplate():RefreshJoinBtn(des, sp)
    self:GetRewardEffect():SetActive(state == 3)
    self:GetCompleteTemplate():ChangeJoinBtnEffect(state == 3)
    self:GetFinish_Go():SetActive(state == 4)
end

---按钮点击
function UIBossChallengePanel_MissionTemplate:OnBtnClicked()
    if self.mMission == nil then
        return
    end
    --1：未接取 2：已接取 3: 已完成 4：已领取
    local state = self.mMission.state
    if state == 1 then
        networkRequest.ReqAccepNewDailyTask(self.mMission.monsterId)
    elseif state == 2 then
        local bossInfo = clientTableManager.cfg_bossManager:TryGetValue(self.mMission.bossId)
        if bossInfo then
            local transferData = {}
            transferData.type = bossInfo:GetType()
            transferData.subType = bossInfo:GetSubType()
            --transferData.targetMonsterId = self.mMission.monsterId
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Boss_Elite, transferData)
            --[[            local deliverId = bossInfo:GetDeliverId()
                        Utility.TryTransfer(deliverId)]]
            uimanager:ClosePanel("UIBossChallengePanel")
        end
    elseif state == 3 then
        networkRequest.ReqSubmitNewDailyTask(self.mMission.monsterId)
    elseif state == 4 then
    end
end
--endregion

--region怪物信息
---刷新怪物显示
function UIBossChallengePanel_MissionTemplate:RefreshMonster()
    if self.mMission.monsterId == self.mMonsterId then
        return
    end
    if self.ObservationModel then
        self.ObservationModel:ClearModel()
    end
    self.mMonsterId = self.mMission.monsterId

    local monsterTbl = clientTableManager.cfg_monstersManager:TryGetValue(self.mMission.monsterId)
    if monsterTbl == nil then
        return
    end
    self:GetMonsterName_Lb().text = monsterTbl:GetName()
    local bossTbl = clientTableManager.cfg_bossManager:TryGetValue(self.mMission.bossId)
    if bossTbl == nil then
        return
    end
    self:ShowModel(bossTbl, monsterTbl)

end

---显示模型
---@param bossTable TABLE.cfg_boss
---@param monsterTable TABLE.cfg_monsters
function UIBossChallengePanel_MissionTemplate:ShowModel(bossTable, monsterTable)
    local RootGO = self:GetModelRoot_GO()
    if bossTable == nil or monsterTable == nil or RootGO == nil then
        return
    end
    if self.ObservationModel == nil then
        self.ObservationModel = CS.ObservationModel()
    end
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
--endregion

--region 奖励
function UIBossChallengePanel_MissionTemplate:RefreshRewardAndCost()
    local taskTbl = clientTableManager.cfg_boss_taskManager:TryGetValue(self.mTaskId)
    self:RefreshReward(taskTbl)
    self:RefreshRewardBtnTemplate(taskTbl)
end

---@private
---刷新领取
---@param taskTbl TABLE.cfg_boss_task
function UIBossChallengePanel_MissionTemplate:RefreshReward(taskTbl)
    if (taskTbl == nil) then
        return
    end
    local temrewardList = Utility.GetDataThatMeetsTheConditions(taskTbl:GetRewards())
    if temrewardList ~= nil then
        local rewardList = string.Split(temrewardList, '#')
        self:GetRewardContainer_UIGridContainer().MaxCount = math.floor((#rewardList) / 2)
        for i = 0, self:GetRewardContainer_UIGridContainer().controlList.Count - 1 do
            local go = self:GetRewardContainer_UIGridContainer().controlList[i]
            ---@type UISprite
            local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
            ---@type UILabel
            local count = CS.Utility_Lua.Get(go.transform, "count", "UILabel")
            if #temrewardList >= (i * 2 + 2) then
                local itemId = tonumber(rewardList[2 * i + 1])
                local num = tonumber(rewardList[2 * i + 2])
                local res, csItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
                if res then
                    icon.spriteName = csItemInfo.icon
                    CS.UIEventListener.Get(go).onClick = function()
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = csItemInfo })
                    end
                end
                count.text = num <= 1 and "" or num
            end
        end
    end
end

---@private
---刷新领取按钮
---@param taskTbl TABLE.cfg_boss_task
function UIBossChallengePanel_MissionTemplate:RefreshRewardBtnTemplate(taskTbl)
    if (taskTbl == nil) then
        return
    end
    local temCostList = Utility.GetDataThatMeetsTheConditions(taskTbl:GetConsume())
    if (temCostList ~= nil) then
        local temCost = string.Split(temCostList, '#')
        if (temCost ~= nil and #temCost > 1) then
            ---@type Cost
            local cost = {}
            cost.itemId = tonumber(temCost[1])
            cost.costNum = tonumber(temCost[2])
            if (self:GetRewardTemplate()) then
                ---@type ReceiveAwardCommonData
                local commonData = {}
                commonData.leftBtnCallBack = function()
                    networkRequest.ReqSubmitNewDailyTask(self.mMission.monsterId)
                end
                commonData.rightBtnCallBack = function()
                    networkRequest.ReqSubmitNewDailyTask(self.mMission.monsterId, true)
                end
                commonData.multipleCost = cost
                self:GetRewardTemplate():RefreshPanel(commonData)
            end
        end
    end
end

--endregion

--region进度
function UIBossChallengePanel_MissionTemplate:RefreshProgress()
    local taskTbl = clientTableManager.cfg_boss_taskManager:TryGetValue(self.mTaskId)
    if taskTbl then
        local color = self.mMission.curKillCount >= taskTbl:GetTime() and luaEnumColorType.Green or luaEnumColorType.Red1
        self:GetProgress_Lb().text = Utility.CombineStringQuickly("需要击杀次数  ", color, self.mMission.curKillCount, "[-]/", taskTbl:GetTime())
    end
end
--endregion

--region 扫荡
function UIBossChallengePanel_MissionTemplate:RefreshClear()
    local configShowClearBtn = LuaGlobalTableDeal:CanShowClearBtn()
    local showClearBtn = configShowClearBtn and self.mMission.state == 2 and self.bossCanClear
    luaclass.UIRefresh:RefreshActive(self:GetBtn_Go(), showClearBtn == false and self.mMission.state ~= 4 and self.mMission.state ~= 3)
    luaclass.UIRefresh:RefreshActive(self:GetDoubleBtn_Go(), showClearBtn and self.mMission.state ~= 4)
    luaclass.UIRefresh:RefreshActive(self:GetRewardBtn_Go(), showClearBtn == false and self.mMission.state == 3)
    if self.bossCanClear then
        if self:GetCompleteTemplate() ~= nil then
            ---@type CompleteTemplateCommonData
            local commonData = {}
            commonData.JoinBtnCallBack = function(go)
                self:OnBtnClicked()
            end
            commonData.ClearBtnCallBack = function()
                networkRequest.ReqUseMonsterCleanUpCoupons(LuaEnumClearType.Great_Master_Task, self.mTaskId, self.mMonsterId)
            end
            commonData.ClearCost = clientTableManager.cfg_boss_taskManager:GetTaskClearCost(self.mTaskId)
            self:GetCompleteTemplate():RefreshPanel(commonData)
        end
    end
end
--endregion
--endregion

return UIBossChallengePanel_MissionTemplate