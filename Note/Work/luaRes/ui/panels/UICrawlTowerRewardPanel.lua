---@class UICrawlTowerRewardPanel:UIBase
local UICrawlTowerRewardPanel = {}

--region 组件
function UICrawlTowerRewardPanel:GetReward_LoopScrollView()
    if (self.mRewardLoopScrollView == nil) then
        self.mRewardLoopScrollView = self:GetCurComp("WidgetRoot/ScrollView/GridContainer", "UILoopScrollViewPlus")
    end
    return self.mRewardLoopScrollView
end

function UICrawlTowerRewardPanel:GetTitle_UILabel()
    if (self.mTitleLabel == nil) then
        self.mTitleLabel = self:GetCurComp("WidgetRoot/labe_floor", "Top_UILabel")
    end
    return self.mTitleLabel
end

function UICrawlTowerRewardPanel:GetCloseBtn_GameObject()
    if (self.mCloseBtn == nil) then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end
--endregion

--region 初始化
function UICrawlTowerRewardPanel:Init()
    self:BindUIEvents()
end

function UICrawlTowerRewardPanel:Show()
    local key = CS.CSServerTime.Instance.TotalSeconds
    local time = CS.CSServerTime.StampToDateTime(key * 1000)
    self.Day = time.Day
    self.mRandomList = self:GetRandomList()
    self:RefreshUIPanel()
end

function UICrawlTowerRewardPanel:GetRandomList()
    math.randomseed(self.Day)
    local data = gameMgr:GetPlayerDataMgr():GetPlayerTowerInfo():GetPlayerTowerData().awardList

    local allIndex = {}
    for i = 1, #data do
        table.insert(allIndex, i)
    end

    local timeCount = 0
    local randomList = {}

    while #allIndex > 0 do
        local randomIndex = math.random(1, #allIndex)
        table.insert(randomList, allIndex[randomIndex])
        table.remove(allIndex, randomIndex)
        timeCount = timeCount + 1
        if timeCount > #data then
            break
        end
    end
    return randomList
end

function UICrawlTowerRewardPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetCloseBtn_GameObject()).onClick = function()
        self:CloseBtnOnClick()
    end
end
--endregion

--region 刷新面板
function UICrawlTowerRewardPanel:RefreshUIPanel()
    self:RefreshTitle()
    self:RefreshReward()
end

function UICrawlTowerRewardPanel:RefreshTitle()
    self:GetTitle_UILabel().text = "再挑战" .. (#clientTableManager.cfg_towerManager.dic - gameMgr:GetPlayerDataMgr():GetPlayerTowerInfo():GetPlayerTowerData().level) .. "关可掉所有奖励"
end

function UICrawlTowerRewardPanel:RefreshReward()
    local towerData = gameMgr:GetPlayerDataMgr():GetPlayerTowerInfo():GetPlayerTowerData()
    self:GetReward_LoopScrollView():Init(function(go, line)
        local data = towerData.awardList
        local index = self.mRandomList[line + 1]
        if (data == nil or line >= #data) then
            return false
        end
        local template = self:GetGOTemp(go)
        if template then
            local singleData = data[index]
            local isFinish = index <= towerData.level
            template:RefreshUI(singleData, isFinish)
        end
        return true
    end, nil)
end

---@return UICrawlTowerBestRewardTemplate
function UICrawlTowerRewardPanel:GetGOTemp(go)
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICrawlTowerBestRewardTemplate)
        self.mGoToTemplate[go] = template
    end
    return template
end
--endregion

--region 客户端事件
function UICrawlTowerRewardPanel:CloseBtnOnClick()
    uimanager:ClosePanel("UICrawlTowerRewardPanel")
end
--endregion

function ondestroy()

end

return UICrawlTowerRewardPanel