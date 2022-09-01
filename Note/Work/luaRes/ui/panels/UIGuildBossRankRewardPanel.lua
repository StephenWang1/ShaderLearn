---行会首领奖励界面
local UIGuildBossRankRewardPanel = {}

--region 组件
function UIGuildBossRankRewardPanel:GetBtnClose()
    if (self.mGetBtnClose == nil) then
        self.mGetBtnClose = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    end
    return self.mGetBtnClose
end

function UIGuildBossRankRewardPanel:GeRewardGridContainer()
    if (self.mGeRewardGridContainer == nil) then
        self.mGeRewardGridContainer = self:GetCurComp("WidgetRoot/view/ScrollView/Grid", "Top_UIGridContainer")
    end
    return self.mGeRewardGridContainer
end
--endregion

UIGuildBossRankRewardPanel.TableList = nil

function UIGuildBossRankRewardPanel:Init()
    self:BindEvent()
end

function UIGuildBossRankRewardPanel:BindEvent()
    --关闭界面
    CS.UIEventListener.Get(self:GetBtnClose()).onClick = function()
        uimanager:ClosePanel("UIGuildBossRankRewardPanel")
    end
end

---@class RankRewardParams
---@field rankRewardType LuaEnumRewardRankType

---@param commonData RankRewardParams
function UIGuildBossRankRewardPanel:Show(commonData)
    if self:AnalysisParams(commonData) == false then
        uimanager:ClosePanel(self)
        return
    end
    self:InitData()
end

---@param commonData RankRewardParams
---@return boolean
function UIGuildBossRankRewardPanel:AnalysisParams(commonData)
    if type(commonData) ~= 'table' or commonData.rankRewardType == nil then
        return false
    end
    self.rankRewardType = commonData.rankRewardType
    return true
end

function UIGuildBossRankRewardPanel:InitData()
    UIGuildBossRankRewardPanel.TableList = clientTableManager.cfg_union_boss_rankManager:GetRewardRankList(self.rankRewardType)
    self:UpdateGrid()
end

function UIGuildBossRankRewardPanel:UpdateGrid()
    if type(UIGuildBossRankRewardPanel.TableList) ~= 'table' then
        return
    end
    self:GeRewardGridContainer().MaxCount = #UIGuildBossRankRewardPanel.TableList
    local index = 0
    ---@param union_boss_rank TABLE.cfg_union_boss_rank
    for i, union_boss_rank in pairs(UIGuildBossRankRewardPanel.TableList) do
        local obj = self:GeRewardGridContainer().controlList[index]

        ---@type GuildBossRankRewardItemTemp
        local temp = templatemanager.GetNewTemplate(obj, luaComponentTemplates.GuildBossRankRewardItemTemp)
        temp:UpdateUnit(union_boss_rank)
        index = index + 1
    end
end

return UIGuildBossRankRewardPanel