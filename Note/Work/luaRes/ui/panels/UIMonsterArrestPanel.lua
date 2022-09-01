---@class UIMonsterArrestPanel:UIBase
local UIMonsterArrestPanel = {}

---@type table<number,table<number,CSMission>> 所有数据 group-table<CSMission>每组所有任务
UIMonsterArrestPanel.mAllData = {}

---@type table<number,number> 页签
UIMonsterArrestPanel.mAllBookMark = {}

---@type table<number,CSMission> 当前需要显示的任务
UIMonsterArrestPanel.mCurrentShowMissions = {}

---@type table<number,UIToggle> 组数对应toggle
UIMonsterArrestPanel.mGroupToToggle = {}

---@type table<number,UnityEngine.GameObject> 组数对应toggle
UIMonsterArrestPanel.mGoToChoose = {}

---@type table<number,UnityEngine.GameObject> 组数对应背景图片
UIMonsterArrestPanel.mGoToBg = nil
UIMonsterArrestPanel.mGoToNoChoose = nil

---@type table<number,boolean> 组数对应toggle
UIMonsterArrestPanel.mGroupToCanClick = nil

---@type TABLE.CFG_ACTIVITY_BOSS 传送数据
UIMonsterArrestPanel.mDetailsInfo = nil

UIMonsterArrestPanel.mCurrentGroup = nil

--region 组件
---@return UILoopScrollViewPlus 怪物显示
function UIMonsterArrestPanel:GetMonsterLoopScrollView()
    if self.mMonsterLoopScrollView == nil then
        self.mMonsterLoopScrollView = self:GetCurComp("WidgetRoot/view/MainView/Scroll View/MonsterGrid", "UILoopScrollViewPlus")
    end
    return self.mMonsterLoopScrollView
end

function UIMonsterArrestPanel:GetMonsterLoopScrollView_GameObject()
    if self.mMonsterLoopScrollView_GameObject == nil then
        self.mMonsterLoopScrollView_GameObject = self:GetCurComp("WidgetRoot/view/MainView/Scroll View/MonsterGrid", "GameObject")
    end
    return self.mMonsterLoopScrollView_GameObject
end

---@return UILoopScrollViewPlus 页签显示
function UIMonsterArrestPanel:GetBookMarkLoopScrollView()
    if self.mBookMarkLoopScrollView == nil then
        self.mBookMarkLoopScrollView = self:GetCurComp("WidgetRoot/view/BookMark/BookMark", "UILoopScrollViewPlus")
    end
    return self.mBookMarkLoopScrollView
end

---@return UnityEngine.GameObject 关闭按钮
function UIMonsterArrestPanel:GetCloseBtn_Go()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end

---@return UILabel 传送按钮文本
function UIMonsterArrestPanel:GetDetailBtnShow_UILabel()
    if self.mDetailBtnLb == nil then
        self.mDetailBtnLb = self:GetCurComp("WidgetRoot/events/detailBtn/Label", "UILabel")
    end
    return self.mDetailBtnLb
end

---@return UISprite 显示图片
function UIMonsterArrestPanel:GetShowActivity_UISprite()
    if self.mShowActivitySp == nil then
        self.mShowActivitySp = self:GetCurComp("WidgetRoot/view/MainView/sprite", "UISprite")
    end
    return self.mShowActivitySp
end

---@return UISprite
function UIMonsterArrestPanel:GetRewardInfo_Sp()
    if self.mRewardSp == nil then
        self.mRewardSp = self:GetCurComp("WidgetRoot/view/allReward/icon", "UISprite")
    end
    return self.mRewardSp
end

---@return UILabel
function UIMonsterArrestPanel:GetRewardInfo_UILabel()
    if self.mRewardLb == nil then
        self.mRewardLb = self:GetCurComp("WidgetRoot/view/allReward/count", "UILabel")
    end
    return self.mRewardLb
end

---@return UnityEngine.GameObject
function UIMonsterArrestPanel:GetRewardInfo_GO()
    if self.mRewardGO == nil then
        self.mRewardGO = self:GetCurComp("WidgetRoot/view/allReward", "GameObject")
    end
    return self.mRewardGO
end

--region 掉落展示
---@return UnityEngine.GameObject 掉落展示节点
function UIMonsterArrestPanel:GetDropRoot_Go()
    if self.mDropGo == nil then
        self.mDropGo = self:GetCurComp("WidgetRoot/view/Drop", "GameObject")
    end
    return self.mDropGo
end

---@return UIGridContainer 掉落Container
function UIMonsterArrestPanel:GetDropItem_UIGridContainer()
    if self.mDropContainer == nil then
        self.mDropContainer = self:GetCurComp("WidgetRoot/view/Drop/DropItem", "UIGridContainer")
    end
    return self.mDropContainer
end

--endregion
---@return UISprite
function UIMonsterArrestPanel:GetGoForKill_Sp()
    if self.mKillSp == nil then
        self.mKillSp = self:GetCurComp("WidgetRoot/view/MainView/btn_go", "UISprite")
    end
    return self.mKillSp
end

---@return UILabel
function UIMonsterArrestPanel:GetGoForKill_Lb()
    if self.mKillLb == nil then
        self.mKillLb = self:GetCurComp("WidgetRoot/view/MainView/btn_go/Label", "UILabel")
    end
    return self.mKillLb
end

---@return Top_OptimizeClipShaderScript
function UIMonsterArrestPanel:GetClipShader()
    if self.mClipShader == nil then
        self.mClipShader = self:GetCurComp("WidgetRoot/view/MainView/Scroll View", "Top_OptimizeClipShaderScript")
    end
    return self.mClipShader
end

---@return UnityEngine.GameObject
function UIMonsterArrestPanel:GetRewardEffect_Go()
    if self.mRewardEffect == nil then
        self.mRewardEffect = self:GetCurComp("WidgetRoot/view/MainView/btn_go/effect", "GameObject")
    end
    return self.mRewardEffect
end

--endregion

---@return LuaSfMonsterArrestData
function UIMonsterArrestPanel:GetDataManager()
    return gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetMonsterArrestData()
end

--region 初始化
function UIMonsterArrestPanel:Init()
    self.mCurrentGroup = nil
    self:BindEvents()
    self:BindMessage()
    self.mDropPos = self:GetDropRoot_Go().transform.localPosition
end

function UIMonsterArrestPanel:Show(customData)
    uiStaticParameter.IsReciveTaskWaitOpenMonsterArrestPanel = false
    self:RefreshPanelShow()
    local showGroup
    if customData and customData.Group then
        showGroup = customData.Group
    else
        showGroup = self:GetGroupInShow()
    end
    if showGroup then
        self:ChooseGroup(showGroup)
    end
    CS.CSMissionManager.Instance:CloseMonsterTaskTip()
    local uimission = uimanager:GetPanel("UIMissionPanel")
    if uimission ~= nil then
        if uimission.doMonsterTaskTip ~= nil then
            uimission.doMonsterTaskTip.gameObject:SetActive(false)
        end
    end
end

---获取显示时跳转的页签
---@return number
function UIMonsterArrestPanel:GetGroupInShow()
    if self.mAllData and self.mAllBookMark then
        ---选中一个可以领取任务奖励的页签
        for i = 1, #self.mAllBookMark do
            local group = self.mAllBookMark[i]
            local missions = self.mAllData[group]
            if self:IsGroupAllMissionFinish(missions) then
                return group
            end
        end
        return self.mAllBookMark[1]
    end
end

---@return boolean 是否该组下所有任务完成
function UIMonsterArrestPanel:IsGroupAllMissionFinish(missions)
    if missions and #missions > 0 then
        for j = 1, #missions do
            if missions[j].State ~= CS.ETaskV2_TaskState.HAS_COMPLETE then
                return false
            end
        end
        return true
    end
    return false
end

function UIMonsterArrestPanel:BindEvents()
    CS.UIEventListener.Get(self:GetCloseBtn_Go()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetGoForKill_Sp().gameObject).onClick = function(go)
        self:OnGoForKillClicked(go)
    end
end

function UIMonsterArrestPanel:BindMessage()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MonsterArrestDataChange, function()
        self:RefreshPanelShow()
        local canEnter, str, needFliter = self:IsMissionCanAllShow(self.mCurrentGroup)
        if canEnter then
            self:ChooseGroup(self.mCurrentGroup)
        else
            local showGroup = self:GetCanRewardGroup()
            if showGroup then
                self:ChooseGroup(showGroup)
            end
        end
    end)

    UIMonsterArrestPanel.OnResMonsterRewardTaskInfoPanelMessageReceived = function()
        self:GetDataManager():ResMonsterArrestInfoChange()
    end
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_MonsterTaskStatusChange, UIMonsterArrestPanel.OnResMonsterRewardTaskInfoPanelMessageReceived)
    self:GetClientEventHandler():AddEvent(CS.CEvent.Task_GoalUpdate, UIMonsterArrestPanel.OnResMonsterRewardTaskInfoPanelMessageReceived)

    UIMonsterArrestPanel.OnResUIBubbleMessageReceived = function()
        local pa
        if self.mDetailsInfo then
            pa = tonumber(self.mDetailsInfo.buttonParam)
        end
        -- self:ShowBubble()
        networkRequest.ReqDeliverByConfig(1023)
        local aim = {}
        local npcId = 61
        table.insert(aim, npcId)
        local PanelName = "UIDevilSquarePanel"
        CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation(aim, PanelName, CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC, pa)
        --  CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({89},"UIDevilSquarePanel")
        uimanager:ClosePanel('UIMonsterArrestPanel')
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUIBubbleMessage, UIMonsterArrestPanel.OnResUIBubbleMessageReceived)
end
--endregion

--region 数据处理
function UIMonsterArrestPanel:RefreshPanelShow()
    self.mAllData = self:GetDataManager():GetAllMissionData()
    self.mAllBookMark = self:GetDataManager():GetAllBookMark()
    self.mAllBookMark = self:FilterBookMark(self.mAllBookMark)
    self.mGroupToToggle = {}
    self.mGoToChoose = {}
    self.mGoToBg = {}
    self.mGoToNoChoose = {}
    self.mGroupToCanClick = {}
    self.mCurrentShowMissions = nil
    self:RefreshBookMarkShow()
    local data = CS.CSMissionManager.Instance:GetMonsterTaskDic()
    if data.Count <= 0 then
        self.CurrentTime = CS.UnityEngine.Time.time
    end
end

---筛选页签
function UIMonsterArrestPanel:FilterBookMark(allBook)
    local finalBookMark = {}
    for i = 1, #allBook do
        local group = allBook[i]
        local missions = self.mAllData[group]
        local activityBoss = clientTableManager.cfg_activity_bossManager:TryGetValue(group)
        if activityBoss:GetIsClose() == 0 then
            ---领取全部奖励后关闭页签
            if self:AnyMissionCanSubmit(missions) then
                table.insert(finalBookMark, group)
            end
        elseif activityBoss:GetIsClose() == 1 then
            ---领取全部奖励后仍然保留页签
            table.insert(finalBookMark, group)
        end
    end
    return finalBookMark
end

---是否有可提交的任务
---@param allmission table<number,CSMission>
function UIMonsterArrestPanel:AnyMissionCanSubmit(allmission)
    for i = 1, #allmission do
        if allmission[i].State ~= CS.ETaskV2_TaskState.HAS_SUBMIT then
            return true
        end
    end
    return false
end

---是否有未完成的任务
---@param allmission table<number,CSMission>
function UIMonsterArrestPanel:AnyMissionUnsubmitted(allmission)
    for i = 1, #allmission do
        if allmission[i].State ~= CS.ETaskV2_TaskState.HAS_SUBMIT then
            return true
        end
    end
    return false
end

---获取有可领奖励的组
function UIMonsterArrestPanel:GetCanRewardGroup()
    if self.mAllData and self.mAllBookMark then
        ---选中一个可以领取任务奖励的页签
        for i = 1, #self.mAllBookMark do
            local group = self.mAllBookMark[i]
            local missions = self.mAllData[group]
            if missions and #missions > 0 and self:IsMissionCanAllShow(group) then
                for j = 1, #missions do
                    if missions[j].State == CS.ETaskV2_TaskState.HAS_COMPLETE then
                        return group
                    end
                end
            end
        end
        return self.mAllBookMark[1]
    end
end

---@return CSMainPlayerInfo 玩家信息
function UIMonsterArrestPanel:GetPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return TABLE.CFG_PROMPTFRAME
function UIMonsterArrestPanel:CachePromptFrameData(id)
    if self.mPromptFrameData == nil then
        self.mPromptFrameData = {}
    end
    local info = self.mPromptFrameData[id]
    if info == nil then
        ___, info = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(id)
        self.mPromptFrameData[id] = info
    end
    return info
end
--endregion

--region 左侧页签

function UIMonsterArrestPanel:RefreshBookMarkShow()
    if self.mAllBookMark and #self.mAllBookMark > 0 then
        self:GetBookMarkLoopScrollView():Init(function(go, line)
            if line < #self.mAllBookMark then
                local group = self.mAllBookMark[line + 1]
                self:RefreshBookMark(go, group)
                return true
            else
                return false
            end
        end, nil)
    end
end

---刷新每一个页签数据
---@param bookInfo number 组数group
function UIMonsterArrestPanel:RefreshBookMark(go, group)
    if not CS.StaticUtility.IsNull(go) and group then
        ---@type UILabel
        local bgLb = CS.Utility_Lua.Get(go.transform, "background/Label", "UILabel")
        ---@type UILabel
        local checkLb = CS.Utility_Lua.Get(go.transform, "checkmark/Label", "UILabel")
        local checkMark = CS.Utility_Lua.Get(go.transform, "checkmark", "GameObject")
        local bgGo = CS.Utility_Lua.Get(go.transform, "background", "GameObject")
        local blackGo = CS.Utility_Lua.Get(go.transform, "noboss", "GameObject")
        local blackLb = CS.Utility_Lua.Get(go.transform, "noboss/Label", "UILabel")

        local canClick = true

        if not CS.StaticUtility.IsNull(bgLb) and not CS.StaticUtility.IsNull(checkLb) then
            local tableInfo = self:GetActivityBossTableInfoCache(group)
            local addData = ""
            local groupData = clientTableManager.cfg_activity_bossManager:TryGetValue(group)
            if groupData and self:GetPlayerInfo() then
                local condition = groupData:GetOnClick()
                if condition then
                    for i = 1, #condition.list do
                        local data = condition.list[i]
                        if data and #data.list >= 2 then
                            local condition = data.list[1]
                            local value = data.list[2]
                            if condition == 1 then
                                if self:GetPlayerInfo().Level < value then
                                    local canEnter, str, needFliter = self:IsMissionCanAllShow(group)
                                    if not canEnter then
                                        canClick = false
                                    end
                                end
                            elseif condition == 2 then
                                if self:GetPlayerInfo().ReinLevel < value then
                                    local canEnter, str, needFliter = self:IsMissionCanAllShow(group)
                                    if not canEnter then
                                        canClick = false
                                    end
                                end
                            end
                        end
                    end
                end
            end
            bgLb.text = luaEnumColorType.Gray .. tableInfo.tableName .. addData
            checkLb.text = tableInfo.tableName .. addData
            blackLb.text = "[454545]" .. tableInfo.tableName .. addData
            CS.UIEventListener.Get(go).onClick = function(go)
                if group ~= self.mCurrentGroup then
                    --点击页签添加条件
                    local needFliterByFinish = false
                    local canEnter, str, needFliter = self:IsMissionCanAllShow(group)
                    if canEnter then
                        self:RefreshItemClicked(group, tableInfo, go)
                    else
                        Utility.ShowPopoTips(go, str, 417)
                    end
                end
            end
            self.mGroupToToggle[group] = go
            self.mGoToChoose[go] = checkMark
            self.mGoToBg[go] = bgGo
            self.mGoToNoChoose[go] = blackGo
            self.mGroupToCanClick[group] = canClick
            checkMark:SetActive(false)
            bgGo:SetActive(canClick)
            blackGo:SetActive(not canClick)
        end
    end
end

function UIMonsterArrestPanel:IsMissionCanAllShow(group)
    local canEnter = true
    local str = ""
    local needFliter = false
    local groupData = clientTableManager.cfg_activity_bossManager:TryGetValue(group)
    if groupData and self:GetPlayerInfo() then
        local condition = groupData:GetOnClick()
        if condition then
            for i = 1, #condition.list do
                local data = condition.list[i]
                if data and #data.list >= 2 then
                    local missons = self.mAllData[group]
                    local condition = data.list[1]
                    local value = data.list[2]
                    if condition == 1 then
                        if self:GetPlayerInfo().Level < value then
                            --if self:IsAnyMissionFinish(missons) == false then
                            canEnter = false
                            local data = self:CachePromptFrameData(417)
                            if data then
                                str = string.format(data.content, value .. "级")
                            end
                            --end
                            needFliter = true
                        end
                    elseif condition == 2 then
                        if self:GetPlayerInfo().ReinLevel < value then
                            --if self:IsAnyMissionFinish(missons) == false then
                            canEnter = false
                            local data = self:CachePromptFrameData(417)
                            if data then
                                str = string.format(data.content, value .. "转")
                            end
                            --end
                            needFliter = true
                        end
                    end
                end
            end
        end
    end
    return canEnter, str, needFliter
end

---设置选中
---@param group number 第几组
---@param tableInfo TABLE.CFG_ACTIVITY_BOSS 活动数据
---@param go
function UIMonsterArrestPanel:RefreshItemClicked(group, tableInfo, go)
    if self.mAllData then
        local missons = self.mAllData[group]

        if self.mCurrentGroup then
            local lastGo = self.mGroupToToggle[self.mCurrentGroup]
            local check = self.mGoToChoose[lastGo]
            local bg = self.mGoToBg[lastGo]
            local noChoose = self.mGoToNoChoose[lastGo]
            local canEnter, str, needFliter = self:IsMissionCanAllShow(self.mCurrentGroup)
            if check then
                check:SetActive(false)
                noChoose:SetActive(not canEnter)
                bg:SetActive(canEnter)
            end
        end

        local check = self.mGoToChoose[go]
        local bg = self.mGoToBg[go]
        local noChoose = self.mGoToNoChoose[go]
        local canEnter, str, needFliter = self:IsMissionCanAllShow(group)
        if check then
            check:SetActive(true)
            bg:SetActive(false)
            noChoose:SetActive(false)
        end
        local canEnter, str, needFliter = self:IsMissionCanAllShow(group)
        if needFliter then
            missons = self:FliterMissionByState(missons)
        end
        self.mCurrentShowMissions = missons
        self:RefreshMonsterMissionShow(group)
        self:RefreshDetailShow(tableInfo)
        self.mDetailsInfo = tableInfo
        self.mCurrentGroup = group
        if missons then
            local finalMission = missons[#missons]
            self:GetDropRoot_Go().gameObject:SetActive(finalMission ~= nil)
            self:RefreshMonsterDrop(group)
            self:RefreshGoToKillInfo(missons)
        end
    end
end

function UIMonsterArrestPanel:FliterMissionByState(mission)
    local finalData = {}
    for i = 1, #mission do
        if mission[i].State == CS.ETaskV2_TaskState.HAS_COMPLETE or mission[i].State == CS.ETaskV2_TaskState.HAS_SUBMIT then
            table.insert(finalData, mission[i])
        end
    end
    return finalData
end

---@return boolean 是否有任意任务完成
function UIMonsterArrestPanel:IsAnyMissionFinish(missons)
    if missons then
        for i = 1, #missons do
            if missons[i].State == CS.ETaskV2_TaskState.HAS_COMPLETE then
                return true
            end
        end
    end
    return false
end

---设置选中
function UIMonsterArrestPanel:ChooseGroup(group)
    local go = self.mGroupToToggle[group]
    if go == nil then
        group = self:GetGroupInShow()
        go = self.mGroupToToggle[group]
    end
    local tableInfo = self:GetActivityBossTableInfoCache(group)
    self:RefreshItemClicked(group, tableInfo, go)
end

function UIMonsterArrestPanel:HasCompleteMission()

end

--endregion

--region 右侧显示
---刷新怪物显示
function UIMonsterArrestPanel:RefreshMonsterMissionShow(group)
    if self.mCurrentShowMissions then
        table.sort(self.mCurrentShowMissions, function(a, b)
            return self:GetDataManager():SortMission(a, b)
        end)
        if #self.mCurrentShowMissions == 3 then
            self:GetMonsterLoopScrollView().MaxCount = 3
            self:GetMonsterLoopScrollView_GameObject().transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0);
        else
            self:GetMonsterLoopScrollView().MaxCount = 2
            self:GetMonsterLoopScrollView_GameObject().transform.localPosition = CS.UnityEngine.Vector3(136, 0, 0);
        end
        self:GetMonsterLoopScrollView():Init(function(go, line)
            if self.mCurrentShowMissions == nil then
                return false
            end
            if line < #self.mCurrentShowMissions then
                local template = self:GetMonsterTemplate(go)
                if template then
                    local info = self.mCurrentShowMissions[line + 1]
                    template:RefreshUI(info, group, line + 1, self:GetClipShader())
                end
                return true
            else
                return false
            end
        end, nil)
    end
end

---@return UIMonsterArrestPanelTemplate 怪物模板
function UIMonsterArrestPanel:GetMonsterTemplate(go)
    if self.mGoToMonsterTemplate == nil then
        self.mGoToMonsterTemplate = {}
    end
    local template = self.mGoToMonsterTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIMonsterArrestPanelTemplate, self)
        self.mGoToMonsterTemplate[go] = template
    end
    return template
end

---获取Boss头像背景
function UIMonsterArrestPanel:GetBossHeadBgSp(type)
    if type == nil then
        return ""
    end
    if self.mBossTypeToSp == nil then
        self.mBossTypeToSp = {}
        local res, globalInfo = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22468)
        if res then
            local strs = string.Split(globalInfo.value, '&')
            for i = 1, #strs do
                local info = string.Split(strs[i], '#')
                if #info >= 2 then
                    local spName = info[#info]
                    for j = 1, #info - 1 do
                        local bossType = tonumber(info[j])
                        self.mBossTypeToSp[bossType] = spName
                    end
                end
            end
        end
    end
    if self.mBossTypeToSp then
        return self.mBossTypeToSp[type]
    end
end

--endregion

---@param info TABLE.CFG_ACTIVITY_BOSS 活动数据
function UIMonsterArrestPanel:RefreshDetailShow(info)
    if info then
        self:GetShowActivity_UISprite().spriteName = info.title
        self:RefreshRewardInfo(info.rewardGroup)
    end
end

---刷新奖励
---@param group number
function UIMonsterArrestPanel:RefreshRewardInfo(group)
    local rewardInfo = LuaGlobalTableDeal.GetMonsterArrestStepReward(group)
    -- print("rewardInfo", rewardInfo)
    -- self:GetDropItem_UIGridContainer().gameObject:SetActive(rewardInfo ~= nil)
    if rewardInfo then
        local itemInfo = self:GetItemInfoCache(rewardInfo.itemId)
        if itemInfo then
            self:GetRewardInfo_Sp().spriteName = itemInfo.icon
        end
        self:GetRewardInfo_UILabel().text = rewardInfo.count == 1 and "" or rewardInfo.count
    end
    CS.UIEventListener.Get(self:GetRewardInfo_Sp().gameObject).onClick = function(go)

        local bubbleId = LuaGlobalTableDeal.GetMonsterArrestStepRewardBubbleTipsId(group)
        if bubbleId then
            Utility.ShowPopoTips(go, nil, bubbleId)
        end
    end
end

--region 数据缓存
---@return TABLE.CFG_MONSTERS 怪物表数据
function UIMonsterArrestPanel:GetMonsterTableCache(id)
    if id == nil then
        return
    end
    if self.mMonsterIdToInfo == nil then
        self.mMonsterIdToInfo = {}
    end
    local info = self.mMonsterIdToInfo[id]
    if info == nil then
        ___, info = CS.Cfg_MonsterTableManager.Instance:TryGetValue(id)
        self.mMonsterIdToInfo[id] = info
    end
    return info
end

---@return TABLE.CFG_ACTIVITY_BOSS 活动数据
function UIMonsterArrestPanel:GetActivityBossTableInfoCache(id)
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

---@return TABLE.CFG_ITEMS 活动数据
function UIMonsterArrestPanel:GetItemInfoCache(id)
    if id then
        if self.mIdToItemInfo == nil then
            self.mIdToItemInfo = {}
        end
        local info = self.mIdToItemInfo[id]
        if info == nil then
            ___, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
            self.mIdToItemInfo[id] = info
        end
        return info
    end
end

--endregion

--region 传送按钮相关
---点击传送type为1的，mapID随机一个点传送；type为2的，打开界面，使用jumpID
function UIMonsterArrestPanel:OnDetailBtnClicked(go)
    if self.mDetailsInfo then
        if self.mDetailsInfo.type == 1 then
            self:SaveChooseBtn(go)
            networkRequest.ReqTaskRandomReq(0, 0, 0, 2, self.mDetailsInfo.group, 0)
        elseif self.mDetailsInfo.type == 2 then
            local pa = tonumber(self.mDetailsInfo.buttonParam)
            uiTransferManager:TransferToPanel(pa)
            self:ClosePanel()
        end
    end
end

---存储选中按钮
function UIMonsterArrestPanel:SaveChooseBtn(go)
    if not CS.StaticUtility.IsNull(go) then
        self.mCurrentDeliverChooseBtn = go
    end
end

---显示气泡
function UIMonsterArrestPanel:ShowBubble()
    if not CS.StaticUtility.IsNull(self.mCurrentDeliverChooseBtn) then
        Utility.ShowPopoTips(self.mCurrentDeliverChooseBtn, nil, 341)
    end
end

--endregion

--region 掉落展示
---@return number 根据任务获取目标monsterId
---@param mission CSMission
function UIMonsterArrestPanel:GetBoosIdByMission(mission)
    return self:GetDataManager():GetMonsterIdByMission(mission)
end

---@param group number 刷新掉落
function UIMonsterArrestPanel:RefreshMonsterDrop(group)
    if group == nil then
        return
    end

    local list = self:GetRewardList(group)
    if (list == nil) then
        return
    end
    self:GetDropItem_UIGridContainer().MaxCount = #list
    for i = 0, self:GetDropItem_UIGridContainer().controlList.Count - 1 do
        local go = self:GetDropItem_UIGridContainer().controlList[i]
        local itemInfo = self:GetItemInfoCache(list[i + 1].mItemID)
        local numLb = CS.Utility_Lua.Get(go.transform, "count", "UILabel")
        local count = list[i + 1].mNum
        numLb.text = count <= 1 and "" or count
        if itemInfo then
            ---@type UISprite
            local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
            if not CS.StaticUtility.IsNull(icon) then
                icon.spriteName = itemInfo.icon
                CS.UIEventListener.Get(icon.gameObject).onClick = function()
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, nil, showRight = false })
                end
            end
        end
    end
end

---@return table<number,RewardItemInfo>
function UIMonsterArrestPanel:GetRewardList(group)
    if self.mGroupToRewardList == nil then
        self.mGroupToRewardList = {}
    end
    local rewardList = self.mGroupToRewardList[group]
    if rewardList == nil then
        rewardList = {}
        local rewardInfo = clientTableManager.cfg_activity_bossManager:TryGetValue(group)
        if rewardInfo and rewardInfo:GetCompleteReward() then
            local list = rewardInfo:GetCompleteReward().list
            for i = 1, #list do
                local singleReward = list[i].list
                if singleReward and #singleReward >= 2 then
                    ---@type RewardItemInfo
                    local rewardItem = {}
                    rewardItem.mItemID = singleReward[1]
                    rewardItem.mNum = singleReward[2]
                    table.insert(rewardList, rewardItem)
                end
            end
        end
        self.mGroupToRewardList[group] = rewardList
    end
    return rewardList
end

--endregion

--region 刷新击杀按钮
---@param missons table<number,CSMission> 刷新当前group任务的前往击杀
function UIMonsterArrestPanel:RefreshGoToKillInfo(missons)
    local isAllFinish = self:IsAllMissionFinish(missons)
    self:GetGoForKill_Sp().spriteName = isAllFinish and "anniu10" or "anniu1"
    self:GetGoForKill_Lb().text = isAllFinish and "[FFF0C2]领取奖励[-]" or "[c3F4FF]前往击杀[-]"
    self.mCurrentFinishState = isAllFinish
    self:GetRewardEffect_Go():SetActive(isAllFinish)
end

---@param missons table<number,CSMission> 判断是否所有任务都完成
function UIMonsterArrestPanel:IsAllMissionFinish(missons)
    for i = 1, #missons do
        local mission = missons[i]
        if mission.State ~= CS.ETaskV2_TaskState.HAS_COMPLETE then
            return false
        end
    end
    return true
end

function UIMonsterArrestPanel:OnGoForKillClicked(go)
    if self.mCurrentGroup == nil then
        return
    end
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.AsyncOperationController:Stop();
        CS.CSMissionManager.Instance:ClearCurrentTask();
    end
    if self.mCurrentFinishState == true then
        networkRequest.ReqSubmitTask(self.mCurrentGroup, 1, 1)
        CS.CSMissionManager.Instance.NowMonsterTask = nil
        if self.mAllBookMark ~= nil and #self.mAllBookMark <= 1 then
            uimanager:ClosePanel("UIMonsterArrestPanel")
        end
    else
        local activityBossInfo = clientTableManager.cfg_activity_bossManager:TryGetValue(self.mCurrentGroup)
        if activityBossInfo then
            --1点击传送 2打开BOSS面板
            local type = activityBossInfo:GetType()
            local params = activityBossInfo:GetButtonParam()
            if type == 1 then
                local deliverId = tonumber(params)
                if deliverId == nil then
                    return
                end
                if self:CheckCanDeliver(deliverId) == true then
                    Utility.TryTransfer(deliverId)
                    self:ClosePanel()
                else
                    Utility.ShowPopoTips(go, nil, 509)
                end
            elseif type == 2 then
                local str = string.Split(params, "#")
                if #str >= 2 then
                    local customData = {}
                    customData.type = tonumber(str[1])
                    customData.subType = tonumber(str[2])
                    uimanager:CreatePanel("UIBossPanel", nil, customData)
                end
            end
        end
    end
end

--endregion

--region 传送条件判断

function UIMonsterArrestPanel:CheckCanDeliver(id)
    if id == nil then
        return false
    end
    local isFind, deliverTable = CS.Cfg_DeliverTableManager.Instance:TryGetValue(id);
    if isFind then
        local isMeet, type, meetNum = CS.Cfg_MapTableManager.Instance:IsMeetMapConditionGetNeedCount(deliverTable.toMapId)
        if not isMeet then
            return false
        end
    end
    return true
end

--endregion

function update()
    if UIMonsterArrestPanel.CurrentTime then
        UIMonsterArrestPanel.CurrentTime = nil
        if not Utility.GetActivityOpen(45) then
            UIMonsterArrestPanel:ClosePanel()
        end
    end
end

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResMonsterRewardTaskInfoPanelMessage, UIMonsterArrestPanel.OnResMonsterRewardTaskInfoPanelMessageReceived)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResUIBubbleMessage, UIMonsterArrestPanel.OnResUIBubbleMessageReceived)
end

return UIMonsterArrestPanel