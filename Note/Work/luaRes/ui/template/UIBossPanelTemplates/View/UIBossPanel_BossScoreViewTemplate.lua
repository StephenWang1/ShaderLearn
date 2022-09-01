---@class UIBossPanel_BossScoreViewTemplate
local UIBossPanel_BossScoreViewTemplate = {}

--region boss积分组件

---@return UILabel boss积分
function UIBossPanel_BossScoreViewTemplate:GetBossScore_UILabel()
    if self.mScoreLabel == nil then
        self.mScoreLabel = self:Get("label_integral/num", "UILabel")
    end
    return self.mScoreLabel
end

---@return UILabel 剩余天数
function UIBossPanel_BossScoreViewTemplate:GetBossScoreTimeLeft_UILabel()
    if self.mTimeLeftLabel == nil then
        self.mTimeLeftLabel = self:Get("label_remainDay/num", "UILabel")
    end
    return self.mTimeLeftLabel
end

---@return UILoopScrollViewPlus 列表组件
function UIBossPanel_BossScoreViewTemplate:GetScore_LoopScrollViewPlus()
    if self.mLoopScore == nil then
        self.mLoopScore = self:Get("scroll/grid", "UILoopScrollViewPlus")
    end
    return self.mLoopScore
end

---@return UnityEngine.GameObject 猎魔人按钮
function UIBossPanel_BossScoreViewTemplate:GetMonsterHunterBtn_GameObject()
    if self.mMonsterHunterBtn == nil then
        self.mMonsterHunterBtn = self:Get("btn_monsterHunter", "GameObject")
    end
    return self.mMonsterHunterBtn
end

---@return UnityEngine.GameObject 猎魔人锁标记
function UIBossPanel_BossScoreViewTemplate:GetMonsterLock_GameObject()
    if self.mMonsterLock == nil then
        self.mMonsterLock = self:Get("btn_monsterHunter/Lock", "GameObject")
    end
    return self.mMonsterLock
end

---@return UnityEngine.GameObject 加锁特效
function UIBossPanel_BossScoreViewTemplate:GetMonsterLockEffect_GameObject()
    if self.mMonsterLockEffect == nil then
        self.mMonsterLockEffect = self:Get("btn_monsterHunter/bg/effectLock", "GameObject")
    end
    return self.mMonsterLockEffect
end

---@return  UnityEngine.GameObject 猎魔人特效
function UIBossPanel_BossScoreViewTemplate:GetMonsterHunterEffect_GameObject()
    if self.mMonsterHunterEffect == nil then
        self.mMonsterHunterEffect = self:Get("btn_monsterHunter/bg/effectHunter", "GameObject")
    end
    return self.mMonsterHunterEffect
end

---@return UnityEngine.GameObject 帮助按钮
function UIBossPanel_BossScoreViewTemplate:GetHelpBtn_GO()
    if self.mHelpBtn_Go == nil then
        self.mHelpBtn_Go = self:Get("btn_help", "GameObject")
    end
    return self.mHelpBtn_Go
end

---@return  UIGridContainer
function UIBossPanel_BossScoreViewTemplate:GetLevel1Container()
    if self.mLevel1Container == nil then
        self.mLevel1Container = self:Get("reward_show/1", "UIGridContainer")
    end
    return self.mLevel1Container
end

---@return  UIGridContainer
function UIBossPanel_BossScoreViewTemplate:GetLevel2Container()
    if self.mLevel2Container == nil then
        self.mLevel2Container = self:Get("reward_show/2", "UIGridContainer")
    end
    return self.mLevel2Container
end

---@return  UIGridContainer
function UIBossPanel_BossScoreViewTemplate:GetLevel3Container()
    if self.mLevel3Container == nil then
        self.mLevel3Container = self:Get("reward_show/3", "UIGridContainer")
    end
    return self.mLevel3Container
end

--endregion

---@return CSMainPlayerInfo 主角信息
function UIBossPanel_BossScoreViewTemplate:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSActivityInfoV2
function UIBossPanel_BossScoreViewTemplate:GetActivityInfo()
    if self.mActivityInfo == nil and self:GetMainPlayerInfo() then
        self.mActivityInfo = self:GetMainPlayerInfo().ActivityInfo
    end
    return self.mActivityInfo
end

---@return activityV2.BossScoreRewards 第一行数据
function UIBossPanel_BossScoreViewTemplate:GetFirstLineData()
    local firstLineData = self:GetBossScoreData(0)
    return firstLineData
end

---@return TABLE.CFG_BOSS_INTEGRAL_REWARD
function UIBossPanel_BossScoreViewTemplate:GetFirstLineTableData()
    local firstLineData = self:GetFirstLineData()
    if firstLineData then
        local tableInfo = self:GetIntegralData(firstLineData.id)
        return tableInfo
    end
end

---初始化组件
function UIBossPanel_BossScoreViewTemplate:InitBossScoreComp()
    self:BindEvents()
    self:GetScore_LoopScrollViewPlus():Init(function(go, line)
        local info = self:GetBossScoreData(line)
        if info then
            local template = self:GetBossScoreTemplate(go)
            local tableData = self:GetIntegralData(info.id)
            template:Refresh(info, line, self.Integral.Count, tableData, self:HasBossCard())
            return true
        else
            return false
        end
    end)
    self:RefreshIntegralProgress()
end

function UIBossPanel_BossScoreViewTemplate:BindEvents()
    CS.UIEventListener.Get(self:GetMonsterHunterBtn_GameObject()).onClick = function(go)
        self:OnMonsterHunterClicked(go)
    end
    CS.UIEventListener.Get(self:GetHelpBtn_GO()).onClick = function(go)
        self:OnHelpBtnClicked(go)
    end
end

---刷新数据 方便修改调用的数据
---@return activityV2.BossScoreRewards
function UIBossPanel_BossScoreViewTemplate:GetBossScoreData(line)
    if self.Integral == nil then
        self.Integral = self:GetActivityInfo().BoosIntegral
    end
    if line < self.Integral.Count and line >= 0 then
        return self.Integral[line]
    end
    return nil
end

---获取猎魔人卡数据
function UIBossPanel_BossScoreViewTemplate:HasBossCard()
    return self:GetActivityInfo().BossScoreResInfo.isCard
end

---刷新boss积分显示
function UIBossPanel_BossScoreViewTemplate:RefreshBoosScorePanel()
    if self:GetActivityInfo() then
        ---@type activityV2.BossScoreRes
        local data = self:GetActivityInfo().BossScoreResInfo
        if data then
            self:GetBossScore_UILabel().text = luaEnumColorType.DeepYellow1 .. data.score
            self:GetBossScoreTimeLeft_UILabel().text = data.day .. " 天"
            self:GetScore_LoopScrollViewPlus():RefreshCurrentPage()
            self:GetMonsterLock_GameObject():SetActive(not data.isCard)
            self:GetMonsterLockEffect_GameObject():SetActive(not data.isCard)
            local coinList = self:GetActivityInfo():GetShowRewardInfo()
            self:GetMonsterHunterEffect_GameObject():SetActive(data.isCard and coinList.Count > 0)
        end
    end
end

---跳转到最新行
function UIBossPanel_BossScoreViewTemplate:RefreshIntegralProgress()
    local line = self:GetActivityInfo():GetJumpLine()
    local jumpLine = math.max(0, line - 2)
    if self.Integral then
        local maxLine = self.Integral.Count
        if jumpLine + 4 >= maxLine then
            jumpLine = maxLine - 4
        end
    end

    self:GetScore_LoopScrollViewPlus():JumpToLine(jumpLine)
end

---@return UIBossScoreGridTemplate 获取boss积分格子模板
function UIBossPanel_BossScoreViewTemplate:GetBossScoreTemplate(go)
    if self.mBossScoreGoToTemplate == nil then
        self.mBossScoreGoToTemplate = {}
    end
    local template = self.mBossScoreGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIBossScoreGridTemplate, self)
        self.mBossScoreGoToTemplate[go] = template
    end
    return template
end

---@return TABLE.CFG_BOSS_INTEGRAL_REWARD
function UIBossPanel_BossScoreViewTemplate:GetIntegralData(id)
    if id == nil then
        return
    end
    if self.mIdToIntegralData == nil then
        self.mIdToIntegralData = {}
    end
    local data = self.mIdToIntegralData[id]
    if data == nil then
        ___, data = CS.Cfg_Boss_Integral_Reward.Instance.dic:TryGetValue(id)
        self.mIdToIntegralData[id] = data
    end
    return data
end

---点击猎魔人
function UIBossPanel_BossScoreViewTemplate:OnMonsterHunterClicked(go)
    local customData = {}
    customData.type = 1
    customData.isCard = self:HasBossCard()
    customData.rewardList = self:GetFirstLineTableData()
    uimanager:CreatePanel("UIMonsterHunterActivePanel", nil, customData)
end

---点击帮助按钮
function UIBossPanel_BossScoreViewTemplate:OnHelpBtnClicked(go)
    local isFind, descriptionInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(157)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, descriptionInfo)
    end
end

---未完成气泡文字
function UIBossPanel_BossScoreViewTemplate:GetUnFinishBubbleShow()
    if self.UnFinishShow == nil then
        ___, self.UnFinishShow = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(222)
    end
    return self.UnFinishShow.content
end

---@return string 击杀boss数量气泡文字
function UIBossPanel_BossScoreViewTemplate:GetBossKillBubbleShow()
    if self.mKillBossShow == nil then
        ___, self.mKillBossShow = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(221)
    end
    return self.mKillBossShow.content
end

---boss积分消息回调
function UIBossPanel_BossScoreViewTemplate:OnResBossScore()
    self.Integral = self:GetActivityInfo().BoosIntegral
    self:RefreshBoosScorePanel()
end

---boss积分视图状态切换回调
function UIBossPanel_BossScoreViewTemplate:SetViewState(isOpen)
    if isOpen then
        if self.HasInitBossScore == nil then
            self.HasInitBossScore = true
            self:RefreshBoosScorePanel()
            self:InitBossScoreComp()
            local firstLineData = self:GetFirstLineData()
            self:RefreshScoreReward(firstLineData)
        end
    end
    self.go:SetActive(isOpen)
end

---@return TABLE.CFG_ITEMS 道具信息
function UIBossPanel_BossScoreViewTemplate:GetItemInfo(id)
    if id == nil then
        return
    end
    if self.mItemIdToInfo == nil then
        self.mItemIdToInfo = {}
    end
    local info = self.mItemIdToInfo[id]
    if info == nil then
        ___, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
        self.mItemIdToInfo[id] = info
    end
    return info
end

--region 赛季奖励
---@param firstLineData activityV2.BossScoreRewards
function UIBossPanel_BossScoreViewTemplate:RefreshScoreReward(firstLineData)
    local info = self:GetIntegralData(firstLineData.id)
    if info then
        local level1 = info.rewardShow1
        local level2 = info.rewardShow2
        local level3 = info.rewardShow3
        self:RefreshGridContainer(self:GetLevel1Container(), level1)
        self:RefreshGridContainer(self:GetLevel2Container(), level2)
        self:RefreshGridContainer(self:GetLevel3Container(), level3)
    end
end

---@param container UIGridContainer
---@param rewardList TABLE.IntListList
function UIBossPanel_BossScoreViewTemplate:RefreshGridContainer(container, rewardList)
    if not CS.StaticUtility.IsNull(container) and rewardList then
        container.MaxCount = rewardList.list.Count
        for i = 0, container.controlList.Count - 1 do
            local go = container.controlList[i]
            local info = rewardList.list[i]
            if info.list.Count >= 2 then
                local id = info.list[0]
                local num = info.list[1]
                self:RefreshSingleGrid(go, id, num)
            end
        end
    end
end

---刷新单个格子
function UIBossPanel_BossScoreViewTemplate:RefreshSingleGrid(go, id, num)
    ---@type UISprite
    local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
    ---@type UILabel
    local count = CS.Utility_Lua.Get(go.transform, "count", "UILabel")
    if not CS.StaticUtility.IsNull(icon) then
        local itemInfo = self:GetItemInfo(id)
        if itemInfo then
            icon.spriteName = itemInfo.icon
        end
        CS.UIEventListener.Get(icon.gameObject).onClick = function()
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
        end
    end
    if not CS.StaticUtility.IsNull(count) then
        local showNum = num == 1 and "" or num
        count.text = showNum
    end
end

---是否显示左侧页签
---@public
function UIBossPanel_BossScoreViewTemplate:IsShowLeftPageView()
    return false
end

return UIBossPanel_BossScoreViewTemplate