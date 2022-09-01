---帮会福利界面
---@class UIGuildBenefitsPanel:UIBase
local UIGuildBenefitsPanel = {}

--region 局部变量定义
---缓存详细贡献界面
UIGuildBenefitsPanel.mDetailsPanel = nil
--endregion

--region组件
---@return UnityEngine.GameObject 战利品节点
function UIGuildBenefitsPanel:GetSpoilsRoot_GameObject()
    if self.mSpoilsRootGo == nil then
        self.mSpoilsRootGo = self:GetCurComp("", "GameObject")
    end
    return self.mSpoilsRootGo
end

function UIGuildBenefitsPanel:GetIngot_UILabel()
    if (self.mIngot == nil) then
        self.mIngot = self:GetCurComp("WidgetRoot/panel/Taxes/ingot", "UILabel")
    end
    return self.mIngot
end

---@return UILabel 今日帮会总贡献度
function UIGuildBenefitsPanel:GetTodayContribution_UILabel()
    if self.mTodayContribution == nil then
        self.mTodayContribution = self:GetCurComp("WidgetRoot/window/all/myContribution", "UILabel")
    end
    return self.mTodayContribution
end

---@return UILoopScrollViewPlus
function UIGuildBenefitsPanel:GetRewardList_UILoopScrollViewPlus()
    if self.mRewardLoopScrollView == nil then
        self.mRewardLoopScrollView = self:GetCurComp("WidgetRoot/panel/Scroll View/Actives", "UILoopScrollViewPlus")
    end
    return self.mRewardLoopScrollView
end

---@return UnityEngine.GameObject 等级不足遮罩
function UIGuildBenefitsPanel:GetLevelLimitShadow_GameObject()
    if self.mLevelLimitShadow == nil then
        self.mLevelLimitShadow = self:GetCurComp("WidgetRoot/panel/Hide", "GameObject")
    end
    return self.mLevelLimitShadow
end

---@return UILabel 个人贡献度
function UIGuildBenefitsPanel:GetPersonalContribution_UILabel()
    if self.mPersonalContributionLb == nil then
        self.mPersonalContributionLb = self:GetCurComp("WidgetRoot/window/my/myContribution", "UILabel")
    end
    return self.mPersonalContributionLb
end

---@return UnityEngine.GameObject 领奖按钮
function UIGuildBenefitsPanel:GetRewardBtn_GO()
    if self.mRewardBtnGo == nil then
        self.mRewardBtnGo = self:GetCurComp("WidgetRoot/panel/btn_get", "GameObject")
    end
    return self.mRewardBtnGo
end

---@return UIGridContainer 奖励显示
function UIGuildBenefitsPanel:GetRewardList_UIGridContainer()
    if self.mRewardContainer == nil then
        self.mRewardContainer = self:GetCurComp("WidgetRoot/panel/Scroll View/Rewards", "UIGridContainer")
    end
    return self.mRewardContainer
end

---@return UILabel 条件文本
function UIGuildBenefitsPanel:GetConditions_UILabel()
    if self.mConditionsLb == nil then
        self.mConditionsLb = self:GetCurComp("WidgetRoot/panel/Conditions", "UILabel")
    end
    return self.mConditionsLb
end
--endregion

--region 属性
---@return CSMainPlayerInfo 玩家信息
function UIGuildBenefitsPanel:GetPlayerInfo()
    if self.mPlayerInfo == nil then
        self.mPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mPlayerInfo
end

---@return CSUnionInfoV2
function UIGuildBenefitsPanel:GetUnionInfoV2()
    if self.mUnionInfoV2 == nil and self:GetPlayerInfo() then
        self.mUnionInfoV2 = self:GetPlayerInfo().UnionInfoV2
    end
    return self.mUnionInfoV2
end
--endregion

--region初始化
function UIGuildBenefitsPanel:Init()
    self:BindMessage()
    self:BindEvent()
end

function UIGuildBenefitsPanel:Show()
    networkRequest.ReqGetPlayerUnionInfo()
    networkRequest.ReqUnionMemberInfo(self:GetUnionInfoV2().UnionID)
    self:RefreshGuildWage()
end

function UIGuildBenefitsPanel:BindMessage()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_UnionInfoChange, function()
        self:RefreshContributeDetail()
        self:RefreshGuildWage()
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUpdateTodayCityTaxMessage, UIGuildBenefitsPanel.RefreshGuildWage)
end

function UIGuildBenefitsPanel:BindEvent()
    CS.UIEventListener.Get(self:GetRewardBtn_GO()).onClick = function()
        networkRequest.ReqGetUnionActiveReward(-1)
        --修改于2021/3/18 按钮卡顿原因是发送领取请求与获取信息请求服务器返回方法相同 所以做了两次一模一样的页面刷新 ——czb
        --networkRequest.ReqGetPlayerUnionInfo()
    end
end
--endregion

--region UI事件

---刷新税收
function UIGuildBenefitsPanel:RefreshGuildWage()
    local info = self:GetUnionInfoV2().UnionInfo
    if info then
        self:GetTodayContribution_UILabel().text = Utility.GetUnionActiveValue(info.unionInfo.rank)
    end
    self:GetLevelLimitShadow_GameObject():SetActive(not self:GetUnionInfoV2():HasPlayerLevelCanGetBenefits())
end

--endregion

--region 贡献度明细（右边面板）
---刷新帮会贡献度明细
function UIGuildBenefitsPanel:RefreshContributeDetail()
    ---@alias unionContributionDetails{id:number,count:number}
    ---@type table<number,table<unionContributionDetails>>
    local showDetails = self:GetUnionInfoV2():GetUnionBenefitsDetails()
    self:GetRewardList_UILoopScrollViewPlus():Init(function(go, line)
        if (line < showDetails.Count) then
            local details = showDetails[line]
            local template = self:GetContributeDetailsTemplate(go)
            if template then
                template:Refresh(details, line)
            end
            return true
        else
            return false
        end
    end, nil)
    self:RefreshPersonaContribution(showDetails)
end

---@return UIGuildBenefitsPanel_ActiveDetailsGridTemplate 贡献度明细模板
function UIGuildBenefitsPanel:GetContributeDetailsTemplate(go)
    if self.mGoToDetailseTemplate == nil then
        self.mGoToDetailseTemplate = {}
    end
    local template = self.mGoToDetailseTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGuildBenefitsPanel_ActiveDetailsGridTemplate, self)
    end
    return template
end

---@return TABLE.CFG_UNION_ACTIVE 活动详情
function UIGuildBenefitsPanel:GetUnionActiveInfo(activeId)
    if self.mUnionActiveToInfo == nil then
        self.mUnionActiveToInfo = {}
    end
    local info = self.mUnionActiveToInfo[activeId]
    if info == nil then
        ___, info = CS.Cfg_Union_ActiveTableManager.Instance.dic:TryGetValue(activeId)
    end
    return info
end
--endregion

--region （左边面板全部）
---刷新个人总共贡献
function UIGuildBenefitsPanel:RefreshPersonaContribution(showDetails)
    local total = CS.CSUnionInfoV2.GetPersonalContribution(showDetails)
    self:GetPersonalContribution_UILabel().text = total

    self:RefreshRewardList(total)

    local canShowBtn = self:GetUnionInfoV2():HasUnclaimedReward()
    self:GetRewardBtn_GO():SetActive(canShowBtn)
end

---刷新奖励列表
function UIGuildBenefitsPanel:RefreshRewardList(total)
    local hasReward = self:GetUnionInfoV2().UnionInfo.activeRewardGet
    local NextReward = CS.Cfg_GlobalTableManager.Instance:GetContributionRewardList(hasReward)
    if NextReward and NextReward.Count > 0 then
        local RewardList = {}
        local totalNum = NextReward.Count
        local group = math.floor((totalNum - 1) / 2)
        for i = 0, group do
            local idIndex = 2 * i + 1
            local numIndex = 2 * (i + 1)
            if idIndex < totalNum and numIndex < totalNum then
                local info = {}
                info.id = NextReward[idIndex]
                info.num = NextReward[numIndex]
                table.insert(RewardList, info)
            end
        end
        self:RefreshRewardContainer(RewardList)

        local aim = NextReward[0]
        local color = total >= aim and luaEnumColorType.Green or luaEnumColorType.Red
        local show = color .. total .. "[-][ffffff]/" .. aim .. "[-]"
        self:GetConditions_UILabel().text = "[878787]贡献达到" .. show .. "可领取"
    end
end

---刷新奖励
function UIGuildBenefitsPanel:RefreshRewardContainer(rewardList)
    if rewardList and #rewardList > 0 then
        self:GetRewardList_UIGridContainer().MaxCount = #rewardList
        for i = 1, #rewardList do
            local go = self:GetRewardList_UIGridContainer().controlList[i - 1]
            if not CS.StaticUtility.IsNull(go) then
                ---@type UISprite
                local iconSp = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
                ---@type UILabel
                local numLb = CS.Utility_Lua.Get(go.transform, "icon/count", "UILabel")
                if not CS.StaticUtility.IsNull(iconSp) and not CS.StaticUtility.IsNull(numLb) then
                    local info = rewardList[i]
                    local id = info.id
                    local num = info.num
                    local itemInfo = self:GetItemInfo(id)
                    if itemInfo then
                        iconSp.spriteName = itemInfo.icon
                        CS.UIEventListener.Get(iconSp.gameObject).onClick = function()
                            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
                        end
                    end
                    numLb.text = num
                end
            end
        end
    end
end

---@return TABLE.CFG_ITEMS 获取道具表缓存数据
function UIGuildBenefitsPanel:GetItemInfo(id)
    if self.mItemIdToInfo == nil then
        self.mItemIdToInfo = {}
    end
    local info = self.mItemIdToInfo[id]
    if info == nil then
        ___, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
    end
    return info
end
--endregion

function ondestroy()
    if UIGuildBenefitsPanel.mDetailsPanel then
        uimanager:ClosePanel(UIGuildBenefitsPanel.mDetailsPanel)
    end
end

return UIGuildBenefitsPanel