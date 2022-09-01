local UIMagicBossRankRewardPanel = {}
--region 初始化
function UIMagicBossRankRewardPanel:Init()
    self:InitComponent()
    self:BindEvents()
end

function UIMagicBossRankRewardPanel:InitComponent()
    self.title_UILabel = self:GetCurComp("WidgetRoot/window/title","UILabel")
    self.grid_UIGridContainer = self:GetCurComp("WidgetRoot/view/ScrollView/Grid","UIGridContainer")
    self.closeBtn_GameObject = self:GetCurComp("WidgetRoot/events/CloseBtn","GameObject")
end

function UIMagicBossRankRewardPanel:BindEvents()
    CS.UIEventListener.Get(self.closeBtn_GameObject).onClick = function(go)
        uimanager:ClosePanel(self)
    end
end
--endregion

--region 刷新
---@param commonData.rankRewardInfo
function UIMagicBossRankRewardPanel:Show(commonData)
    if self:AnalysisParams(commonData) == false then
        uimanager:ClosePanel(self)
    end
    self:RefreshTitle()
    self:RefreshRankList()
end

function UIMagicBossRankRewardPanel:AnalysisParams(commonData)
    if commonData == nil or commonData.rankRewardInfo == nil or commonData.rankRewardInfo.SingleRankRewardInfoList == nil then
        return false
    end
    self.title = commonData.rankRewardInfo.Title
    self.singleRankRewardList = commonData.rankRewardInfo.SingleRankRewardInfoList
    return true
end

function UIMagicBossRankRewardPanel:RefreshTitle()
    if CS.StaticUtility.IsNullOrEmpty(self.title) == false and CS.StaticUtility.IsNull(self.title_UILabel) == false then
        self.title_UILabel.text = self.title
    end
end

function UIMagicBossRankRewardPanel:RefreshRankList()
    if self.singleRankRewardList ~= nil and self.singleRankRewardList.Count > 0 and CS.StaticUtility.IsNull(self.grid_UIGridContainer) == false then
        self.grid_UIGridContainer.MaxCount = self.singleRankRewardList.Count
        local length = self.singleRankRewardList.Count - 1
        for k = 0,length do
            local singleRankRewardInfo = self.singleRankRewardList[k]
            local go = self.grid_UIGridContainer.controlList[k]
            local template = templatemanager.GetNewTemplate(go,luaComponentTemplates.UIMagicBossRankRewardPanel_SingleRankTemplate)
            template:RefreshPanel({singleRankRewardInfo = singleRankRewardInfo,index = k})
        end
    end
end
--endregion
return UIMagicBossRankRewardPanel