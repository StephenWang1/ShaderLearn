---@class UICompetitionPanel_Type2Template:copytemplatebase 类型2模板 首杀
local UICompetitionPanel_Type2Template = {}

setmetatable(UICompetitionPanel_Type2Template, luaComponentTemplates.copytemplatebase)

local CheckNullFunction = CS.StaticUtility.IsNull
local CSUtility_Lua = CS.Utility_Lua

---@param panel UICompetitionPanel
function UICompetitionPanel_Type2Template:Init(panel)
    self.RootPanel = panel
    self:InitComponent()
    self:BindEvents()
end

function UICompetitionPanel_Type2Template:GetPrefabGO()
    if self.mPrefabGo == nil and self.RootPanel then
        self.mPrefabGo = self.RootPanel:GetCurComp("WidgetRoot/view/scroll/type2/template", "GameObject")
    end
    return self.mPrefabGo
end

--region 组件
---@return UnityEngine.GameObject bossGo
function UICompetitionPanel_Type2Template:GetBossHeadGo()
    if self.mBossHeadGo == nil then
        self.mBossHeadGo = self:GetUIComponentController():GetCustomType(self.mBoss, "GameObject")
    end
    return self.mBossHeadGo
end

---@return UISprite boss头像Icon
function UICompetitionPanel_Type2Template:GetBossHeadIcon_UISprite()
    if self.mBossHeadSp == nil and CheckNullFunction(self:GetBossHeadGo()) == false then
        self.mBossHeadSp = CSUtility_Lua.Get(self:GetBossHeadGo().transform, "headIcon", "UISprite")
    end
    return self.mBossHeadSp
end

---@return UISprite boss头像背景
function UICompetitionPanel_Type2Template:GetBoosHeadIconBG_UISprite()
    if self.mHeadIconBg_UISprite == nil and CheckNullFunction(self:GetBossHeadGo()) == false then
        self.mHeadIconBg_UISprite = CSUtility_Lua.Get(self:GetBossHeadGo().transform, "headIconBg", "UISprite")
    end
    return self.mHeadIconBg_UISprite
end

---@return UnityEngine.GameObject 领奖按钮
function UICompetitionPanel_Type2Template:GetBtnReward_Go()
    if self.mBtnRewardGo == nil then
        self.mBtnRewardGo = self:GetUIComponentController():GetCustomType(self.btnGet_GameObject, "GameObject")
    end
    return self.mBtnRewardGo
end

---@return UILabel 领奖文本
function UICompetitionPanel_Type2Template:GetRewardBtn_UILabel()
    if self.mRewardBtnLb == nil and CheckNullFunction(self:GetBtnReward_Go()) then
        self.mRewardBtnLb = CSUtility_Lua.Get(self:GetBtnReward_Go().transform, "lab_name", "UILabel")
    end
    return self.mRewardBtnLb
end

---@return UISprite 领奖背景图片
function UICompetitionPanel_Type2Template:GetRewardBtnBG_UISprite()
    if self.mRewardBtnBgSp == nil and CheckNullFunction(self:GetBtnReward_Go()) then
        self.mRewardBtnBgSp = CSUtility_Lua.Get(self:GetBtnReward_Go().transform, "backGround", "UISprite")
    end
    return self.mRewardBtnBgSp
end

function UICompetitionPanel_Type2Template:GetRewardEffect_Go()
    if self.mRewardEffectGo == nil and CheckNullFunction(self:GetBtnReward_Go()) == false then
        self.mRewardEffectGo = CSUtility_Lua.Get(self:GetBtnReward_Go().transform, "effect", "GameObject")
    end
    return self.mRewardEffectGo
end

---@return UIGridContainer 奖励列表
function UICompetitionPanel_Type2Template:GetRewardList_UIGridContainer()
    if self.mRewardListContainer == nil then
        self.mRewardListContainer = self:GetUIComponentController():GetCustomType(self.mRewardList_UIGridContainer, "UIGridContainer")
    end
    return self.mRewardListContainer
end

---@return UnityEngine.GameObject 红包按钮
function UICompetitionPanel_Type2Template:GetRedPacketBtn_Go()
    if self.mRedPackedBtnGo == nil then
        self.mRedPackedBtnGo = self:GetUIComponentController():GetCustomType(self.mRedPacket_Go, "GameObject")
    end
    return self.mRedPackedBtnGo
end


--endregion

function UICompetitionPanel_Type2Template:InitComponent()
    ---@type UILabel
    ---标题文字
    self.title_UILabel = "name"

    ---bossHead路径
    self.mBoss = "bossHead"

    ---@type UILabel
    ---怪物等级
    self.monsterLevel_UILabel = "lb_lv"

    ---@type UILabel
    ---状态文字
    self.mState_UILabel = "state"

    ---@type UnityEngine.GameObject
    ---领取按钮
    self.btnGet_GameObject = "btn_get"

    ---@type UILabel
    ---领完文字
    self.finish_SP = self:Get("finish", "UILabel")

    ---@type UIGridContainer
    ---奖励列表
    self.mRewardList_UIGridContainer = "rewardList"

    ---@type UISprite
    ---背景图片
    self.Bg_UISprite = "backGround"

    ---@return UnityEngine.GameObject 红包按钮
    self.mRedPacket_Go = "redPacket"

    ---@type UISprite
    ---icon3 标签
    self.mIcon3_Sp = "icon3"

    ---未完成GO
    ---@type UnityEngine.GameObject
    self.UnFinish_GO = "unFinish"
end

function UICompetitionPanel_Type2Template:BindEvents()
    if CheckNullFunction(self:GetBtnReward_Go()) == false then
        CS.UIEventListener.Get(self:GetBtnReward_Go()).onClick = function(go)
            self:OnGetBrnClicked(go)
        end
    end
    CS.UIEventListener.Get(self:GetRedPacketBtn_Go()).onClick = function(go)
        self:OnRedPackedClicked(go)
    end
end

---@param data activityV2.ActivityDataInfo
---@param tableData TABLE.CFG_ACTIVITY_COMMON
function UICompetitionPanel_Type2Template:Refresh(data, tableData, registerNum)
    if data == nil or tableData == nil then
        return
    end

    self.data = data
    self.tblData = tableData
    self.finish = false
    self.isFinish = false
    self.notFinish = false
    self.hasGet = false

    self:GetShowInfo(data, tableData)--获取首杀玩家数据 1
    self:ShowBtnState(data, tableData)--使用了首杀玩家数据 2
    self:ShowRewardInfo()
    self:RefreshBasicData(tableData)
    self:RefreshColorEct()
end

---刷新基本显示信息
---@param tableData TABLE.CFG_ACTIVITY_COMMON 表数据
function UICompetitionPanel_Type2Template:RefreshBasicData(tableData)
    if tableData == nil then
        return
    end
    --刷新目标
    if tableData.goalIds and tableData.goalIds.list.Count > 0 then
        local goalId = tableData.goalIds.list[0]
        local res, goalInfo = CS.Cfg_ActivityGoalsTableManager.Instance.dic:TryGetValue(goalId)
        if res then
            self.redPacketTitle = "首杀" .. goalInfo.goalShow
            local monsterId = goalInfo.goalParam
            if goalInfo.goalType == 3000 then
                local extend = goalInfo.goalExtParams
                if extend and extend.list and extend.list.Count > 0 then
                    monsterId = extend.list[0]
                end
            end

            local res1, monsterInfo = CS.Cfg_MonsterTableManager.Instance.dic:TryGetValue(monsterId)
            if res1 then
                self:GetBossHeadIcon_UISprite().spriteName = monsterInfo.head
                local showLevel = monsterInfo.level
                if monsterInfo.reinLv and monsterInfo.reinLv ~= 0 then
                    showLevel = monsterInfo.reinLv .. "转"
                end
                self:GetUIComponentController():SetLabelContent(self.monsterLevel_UILabel, showLevel)
                local color = self.hasGet and luaEnumColorType.Gray or ""
                local titleStr = color .. goalInfo.goalShow .. "(" .. showLevel .. "级)"
                self:GetUIComponentController():SetLabelContent(self.title_UILabel, titleStr)
            end
        end
    end
    self:GetUIComponentController():SetSpriteName(self.mIcon3_Sp, tableData.icon3)
end

---@return string 获取显示信息
---@param tableData TABLE.CFG_ACTIVITY_COMMON
---@param data activityV2.ActivityDataInfo
function UICompetitionPanel_Type2Template:GetShowInfo(data, tableData)
    ---是否是首杀玩家
    self.isFirstKillPlayer = nil
    self.firstKillerData = nil
    ---全民红包奖励Id
    self.mSecondGoalId = nil
    ---首杀玩家信息
    self.mFirstKillPlayerInfo = {}
    ---是否是个人奖励
    self.isSelfReward = false
    ---是否需要显示红包
    self.isShowSecondReward = false

    local isFirstAward = false

    local isFinish = false
    if data and tableData then
        if tableData.activityType == LuaEnumCompetitionAimType.ServerFistKill then
            --表示现在是全服数据
            local firstKillerData = nil
            if data.serverGoalInfo.serverGoalInfos then
                ---@type table<number,activityV2.ServerGoalInfo>
                local serverGoalList = data.serverGoalInfo.serverGoalInfos
                local hasRewardList = data.serverGoalInfo.roleCanRewardGoalId
                local progress = 0
                for i = 0, serverGoalList.Count - 1 do
                    ---@type activityV2.ServerGoalInfo
                    local info = serverGoalList[i]
                    if info.ok then
                        progress = progress + 1
                    end
                end
                self.mTitleName = luaEnumColorType.Gray .. "已击杀(" .. progress .. "/" .. serverGoalList.Count .. ")只"
            end
            if not isFinish then
                self.bubbleId = 193
            end
            if self.isFirstKillPlayer then
                self.isShowSecondReward = isFirstAward
            else
                self.isShowSecondReward = true
            end
        elseif tableData.activityType == 1010 then
            --表示现在是个人数据
            self.isSelfReward = true
            if data.roleGoalInfo.roleGoalInfos then
                ---@type table<number,activityV2.RoleGoalInfo>
                local roleGoalList = data.roleGoalInfo.roleGoalInfos
                for i = 0, roleGoalList.Count - 1 do
                    ---@type activityV2.RoleGoalInfo
                    local info = roleGoalList[i]
                    if info.ok then
                        isFinish = true
                        self.finish = true
                        self.mTitleName = luaEnumColorType.Gray .. "已击杀(1/1)只"
                    end
                end
            end
            if not isFinish then
                self.finish = false
                self.bubbleId = 194
                self.mTitleName = luaEnumColorType.Gray .. "已击杀(0/1)只"
            end
        end
    end
    self:GetUIComponentController():SetLabelContent(self.mState_UILabel, self.mTitleName)
end

---显示奖励信息
function UICompetitionPanel_Type2Template:ShowRewardInfo()
    if not CS.StaticUtility.IsNull(self:GetRewardList_UIGridContainer()) and self.tblData then
        ---@type TABLE.CFG_ACTIVITY_COMMON
        local tableData = self.tblData
        --刷新奖励
        local showList = {}
        --获取数据
        if tableData.award then
            for i = 0, tableData.award.list.Count - 1 do
                local single = tableData.award.list[i]
                if single.list.Count >= 2 then
                    local data = {}
                    data.id = single.list[0]
                    data.num = single.list[1]
                    data.type = 1
                    table.insert(showList, data)
                end
            end
        end
        --刷新显示
        self:GetRewardList_UIGridContainer().MaxCount = #showList
        for i = 1, #showList do
            local data = showList[i]
            local go = self:GetRewardList_UIGridContainer().controlList[i - 1]
            local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
            local num = CS.Utility_Lua.Get(go.transform, "count", "UILabel")

            local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(data.id)
            if res then
                icon.spriteName = itemInfo.icon
                icon.color = self.hasGet and LuaEnumUnityColorType.DarkGray or LuaEnumUnityColorType.Normal
                CS.UIEventListener.Get(go).onClick = function()
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
                end
            end
            if (data.num == 1) then
                num.text = ""
            else
                num.text = data.num
            end
        end
    end
end

---点击领取奖励
function UICompetitionPanel_Type2Template:OnGetBrnClicked(go)
    if self.data and self.finish then
        networkRequest.ReqGetActivityReward(self.data.activityId, self.tblData.activityType, self.goalId, 1)
        networkRequest.ReqOpenPanel(self.tblData.clientType)
    else
        if self.bubbleId then
            Utility.ShowPopoTips(go, nil, self.bubbleId)
        end
    end
end

---@param data activityV2.ActivityDataInfo
---刷新完成和按钮状态
function UICompetitionPanel_Type2Template:ShowBtnState(data, tableData)
    local state = CS.CSActivityInfoV2.GetFirstDropActivityState(data)
    self.hasGet = state == 2
    local isFinish = state == 1
    local notFinish = state == 0
    --local isCanReward = isFinish and not  self.hasGet

    local finishState = self:GetCurrentGoalInfo(data, tableData)
    self.finish = finishState

    local showLabel = ternary(finishState, "可领取", luaEnumColorType.Gray .. "未完成")
    if CheckNullFunction(self:GetRewardBtn_UILabel()) == false then
        self:GetRewardBtn_UILabel().text = showLabel
    end

    self:GetUIComponentController():SetObjectActive(self.finish_SP, self.hasGet)

    local isShowRedPack = finishState and not self.isFirstKillPlayer and tableData.activityType == LuaEnumCompetitionAimType.ServerFistKill
    self:GetUIComponentController():SetObjectActive(self.mRedPacket_Go, isShowRedPack)

    ---可领取按钮状态 /首杀/个人首杀
    local isServeFirstFinish = tableData.activityType == LuaEnumCompetitionAimType.ServerFistKill
    local isSelfFinish = tableData.activityType == LuaEnumCompetitionAimType.SelfFirstKill and isFinish
    local isCanRewardBtnState = (finishState and self.isFirstKillPlayer and isServeFirstFinish) or (isSelfFinish)
    self:GetUIComponentController():SetObjectActive(self.btnGet_GameObject, isCanRewardBtnState)
    if CheckNullFunction(self:GetRewardEffect_Go()) == false then
        self:GetRewardEffect_Go():SetActive(isCanRewardBtnState)
    end

    if CheckNullFunction(self:GetRewardBtnBG_UISprite()) == false then
        local color = ternary(isFinish, LuaEnumUnityColorType.Normal, LuaEnumUnityColorType.Transparent)
        self:GetRewardBtnBG_UISprite().color = color
    end

    self:GetUIComponentController():SetObjectActive(self.UnFinish_GO, notFinish)
end

---@return boolean  当前是否有任务可领
---@param data activityV2.ActivityDataInfo
function UICompetitionPanel_Type2Template:GetCurrentGoalInfo(data, tableData)
    if tableData == nil then
        return
    end

    if tableData.activityType == LuaEnumCompetitionAimType.ServerFistKill then
        --表示现在是全服数据
        if data.serverGoalInfo.serverGoalInfos then
            ---@type table<number,activityV2.ServerGoalInfo>
            local serverGoalList = data.serverGoalInfo.serverGoalInfos
            local hasRewardList = data.serverGoalInfo.roleCanRewardGoalId
            for i = 0, serverGoalList.Count - 1 do
                ---@type activityV2.ServerGoalInfo
                local info = serverGoalList[i]
                if info.ok then
                    if self.RootPanel and self.RootPanel:GetMainPlayerInfo() then
                        local id = self.RootPanel:GetMainPlayerInfo().ID
                        if id == info.finishRoleId then
                            if not info.award then
                                self.isFirstKillPlayer = true
                                if self.isFirstKillPlayer then
                                    self.firstKillerData = info
                                    self.goalId = info.goalId
                                end
                                return true
                            end
                        end
                        if not self:IsGoalHasReward(hasRewardList, info.goalId) and self.mSecondGoalId == nil then
                            self.isFirstKillPlayer = false
                            self.mSecondGoalId = info.goalId
                            self.mFirstKillPlayerInfo.PlayerId = info.finishRoleId
                            self.mFirstKillPlayerInfo.PlayerName = info.finishName
                            self.mFirstKillPlayerInfo.Sex = info.finishSex
                            self.mFirstKillPlayerInfo.Career = info.finishCarrer
                            return true
                        end
                    end
                end
            end
        end
    else
        if (data.roleGoalInfo ~= nil) then
            return data.roleGoalInfo.rewardState ~= 0
        end
    end
    return false
end

---点击红包按钮
function UICompetitionPanel_Type2Template:OnRedPackedClicked()
    if self.data and self.tblData then
        local data = {}
        data.ActivityId = self.data.activityId
        data.ActivityType = self.tblData.activityType
        data.GoalId = self.mSecondGoalId
        data.PlayerInfo = self.mFirstKillPlayerInfo
        data.ClientType = self.tblData.clientType
        data.Type = 2
        data.Title = self.redPacketTitle
        uimanager:CreatePanel("UIRedPacketPanel", nil, data)
    end
end

---设置背景颜色
function UICompetitionPanel_Type2Template:SetBGColor(isShow)
    local color = ternary(isShow, LuaEnumUnityColorType.Normal, LuaEnumUnityColorType.Transparent)
    self:GetUIComponentController():SetSpriteColor(self.Bg_UISprite, color)
    self:GetUIComponentController():Apply()
end

---判断该目标是否可领
function UICompetitionPanel_Type2Template:IsGoalHasReward(rewardList, goalId)
    if rewardList and rewardList.Count > 0 then
        for i = 0, rewardList.Count - 1 do
            if goalId == rewardList[i] then
                return true
            end
        end
    end
    return false
end

---刷新跟状态有关需要改变颜色的
function UICompetitionPanel_Type2Template:RefreshColorEct()
    local color = self.hasGet and LuaEnumUnityColorType.DarkGray or LuaEnumUnityColorType.Normal
    self:GetBossHeadIcon_UISprite().color = color
    self:GetBoosHeadIconBG_UISprite().color = color
    self:GetUIComponentController():SetSpriteColor(self.mIcon3_Sp, color)
    local lbColor = self.hasGet and luaEnumColorType.Gray or ""
    self:GetUIComponentController():SetLabelContent(self.finish_SP, lbColor .. "已完成")
end

return UICompetitionPanel_Type2Template