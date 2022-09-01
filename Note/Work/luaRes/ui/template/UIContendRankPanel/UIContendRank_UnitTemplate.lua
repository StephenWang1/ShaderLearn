---@class UIContendRank_UnitTemplate: UIRankItemTemplate 夺榜单元
local UIContendRank_UnitTemplate = {}
setmetatable(UIContendRank_UnitTemplate, luaComponentTemplates.UIRankItemTemplate)

---@type Top_UIGridContainer 物品奖励
function UIContendRank_UnitTemplate:GetRewardGrid()
    if self.rewardGrid == nil and self.CloneManager ~= nil then
        self.rewardGrid = self.CloneManager:GetComponent("Total/rewardGrid", "Top_UIGridContainer", "rewardList", self.total)
    end
    return self.rewardGrid
end

---@type Top_UISprite 称号
function UIContendRank_UnitTemplate:GetTitleSprite()
    if self.titleSprite == nil and self.CloneManager ~= nil and not CS.StaticUtility.IsNull(self.CloneManager) then
        self.titleSprite = self.CloneManager:GetComponent("Total/titleSprite", "Top_UISprite", "Title", self.total)
    end
    return self.titleSprite
end

---@type Top_UISprite 称号
function UIContendRank_UnitTemplate:GetTitleAnim()
    if self.titleAnim == nil and self.CloneManager ~= nil then
        self.titleAnim = self.CloneManager:GetComponent("Total/titleSprite", "Top_UISpriteAnimation", "Title", self.total)
    end
    return self.titleAnim
end

---@type Top_UISprite  通用文本
function UIContendRank_UnitTemplate:GetNormalText()
    if self.normalText == nil and self.CloneManager ~= nil then
        self.normalText = self.CloneManager:GetComponent("Total/normalText", "Top_UILabel", "label", self.total)
    end
    return self.normalText
end

--初始化变量
function UIContendRank_UnitTemplate:InitParameters()
    self:RunBaseFunction("InitParameters")
    self.isMain = false
    self.titleItemId = 0
end

function UIContendRank_UnitTemplate:SetTemplate(data)
    self.isMain = data.isMain
    self.tblInfo = data.tblInfo
    self:RunBaseFunction("SetTemplate", data)
end

function UIContendRank_UnitTemplate:RefreshUseTemplate()
    self:GetRankReward()
    self:RunBaseFunction("RefreshUseTemplate")
end

function UIContendRank_UnitTemplate:GetRankReward()
    self.rewardList, self.title, self.titleItemId = CS.Cfg_RankingRewardTableManager.Instance:GetContendRankReward(self.rankConfigId, self.rankID)
end

function UIContendRank_UnitTemplate:RefreshTitle()
    if self.curEffectPool ~= nil then
        --删除之前的资源
        if CS.CSObjectPoolMgr.Instance ~= nil then
            CS.CSObjectPoolMgr.Instance:RemoveUIPoolItem(self.curEffectPool)
        end
    end
    CS.CSResourceManager.Singleton:AddQueueCannotDelete(self.title, CS.ResourceType.Effect, function(res)
        if CS.StaticUtility.IsNull(self.go) then
            return
        end
        if res == nil or self:GetTitleSprite() == nil or CS.StaticUtility.IsNull(self:GetTitleSprite()) then
            return
        end
        local go = res.MirrorObj
        if go == nil then
            return
        end
        ---@type UIAtlas
        local atlas = self:GetCurComp(go, "", "UIAtlas")
        if atlas ~= nil then
            self:GetTitleSprite().atlas = atlas
            atlas.ResPath = res.Path
            if self.useTemplate ~= nil then
                self.useTemplate:SetTitleShow(self, atlas)
            end
            self:GetTitleSprite():CreatePanel()
        end
    end, CS.ResourceAssistType.UI)
end

return UIContendRank_UnitTemplate