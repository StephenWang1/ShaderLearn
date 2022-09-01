---@class UIOverlordRank_UnitTemplate:UIRankItemTemplate 霸业单元模板
local UIOverlordRank_UnitTemplate = {}
setmetatable(UIOverlordRank_UnitTemplate, luaComponentTemplates.UIRankItemTemplate)

---@type Top_UIGridContainer 物品奖励
function UIOverlordRank_UnitTemplate:GetRewardGrid()
    if self.rewardGrid == nil and self.CloneManager ~= nil then
        self.rewardGrid = self.CloneManager:GetComponent("Total/rewardGrid", "Top_UIGridContainer", "rewardList", self.total)
    end
    return self.rewardGrid
end

---@type Top_UISprite 称号
function UIOverlordRank_UnitTemplate:GetTitleSprite()
    if self.titleSprite == nil and self.CloneManager ~= nil then
        self.titleSprite = self.CloneManager:GetComponent("Total/titleSprite", "Top_UISprite", "Title", self.total)
    end
    return self.titleSprite
end

---@type Top_UISprite 称号
function UIOverlordRank_UnitTemplate:GetTitleAnim()
    if self.titleAnim == nil and self.CloneManager ~= nil then
        self.titleAnim = self.CloneManager:GetComponent("Total/titleSprite", "Top_UISpriteAnimation", "Title", self.total)
    end
    return self.titleAnim
end

---@type Top_UILabel 行会排名
function UIOverlordRank_UnitTemplate:GetUnionRank()
    if self.unionRank == nil and self.CloneManager ~= nil then
        self.unionRank = self.CloneManager:GetComponent("Total/unionRank", "Top_UILabel", "label", self.total)
    end
    return self.unionRank
end

---@type Top_UILabel 行会名称
function UIOverlordRank_UnitTemplate:GetUnionName()
    if self.unionName == nil and self.CloneManager ~= nil then
        self.unionName = self.CloneManager:GetComponent("Total/unionName", "Top_UILabel", "label", self.total)
    end
    return self.unionName
end

---@type Top_UILabel 繁荣度
function UIOverlordRank_UnitTemplate:GetProsperity()
    if self.prosperity == nil and self.CloneManager ~= nil then
        self.prosperity = self.CloneManager:GetComponent("Total/prosperity", "Top_UILabel", "label", self.total)
    end
    return self.prosperity
end

---@type Top_UILabel 职位
function UIOverlordRank_UnitTemplate:GetUnionPosition()
    if self.unionPosition == nil and self.CloneManager ~= nil then
        self.unionPosition = self.CloneManager:GetComponent("Total/unionPosition", "Top_UILabel", "label", self.total)
    end
    return self.unionPosition
end

---@type Top_UILabel 玩家姓名
function UIOverlordRank_UnitTemplate:GetPlayerName()
    if self.playerName == nil and self.CloneManager ~= nil then
        self.playerName = self.CloneManager:GetComponent("Total/playerName", "Top_UILabel", "label", self.total)
    end
    return self.playerName
end

---@type Top_UILabel 贡献度
function UIOverlordRank_UnitTemplate:GetContribution()
    if self.contribution == nil and self.CloneManager ~= nil then
        self.contribution = self.CloneManager:GetComponent("Total/contribution", "Top_UILabel", "label", self.total)
    end
    return self.contribution
end

---@type Top_UILabel 玩家姓名2
function UIOverlordRank_UnitTemplate:GetSecondPlayerName()
    if self.secondPlayerName == nil and self.CloneManager ~= nil then
        self.secondPlayerName = self.CloneManager:GetComponent("Total/playerName2", "Top_UILabel", "label", self.total)
    end
    return self.secondPlayerName
end

---@type Top_UILabel 贡献度2
function UIOverlordRank_UnitTemplate:GetSecondContribution()
    if self.secondContribution == nil and self.CloneManager ~= nil then
        self.secondContribution = self.CloneManager:GetComponent("Total/contribution2", "Top_UILabel", "label", self.total)
    end
    return self.secondContribution
end

---@type Top_UILabel 玩家排名
function UIOverlordRank_UnitTemplate:GetPlayerRank()
    if self.playerRank == nil and self.CloneManager ~= nil then
        self.playerRank = self.CloneManager:GetComponent("Total/playerRank", "Top_UILabel", "label", self.total)
    end
    return self.playerRank
end

---@type Top_UILabel 领取按钮
function UIOverlordRank_UnitTemplate:GetRewardBtn()
    if self.rewardBtn == nil and self.CloneManager ~= nil then
        self.rewardBtn = self.CloneManager:GetComponent("Total/rewardBtn", "GameObject", "btn_get", self.total)
    end
    return self.rewardBtn
end

---@type Top_UILabel 特殊文本
function UIOverlordRank_UnitTemplate:GetOverlordText()
    if self.overlordText == nil and self.CloneManager ~= nil then
        self.overlordText = self.CloneManager:GetComponent("Total/overlordText", "Top_UILabel", "label", self.total)
    end
    return self.overlordText
end

---@type Top_UILabel 特殊文本(3)
function UIOverlordRank_UnitTemplate:GetSecondOverlordText()
    if self.secondOverlordText == nil and self.CloneManager ~= nil then
        self.secondOverlordText = self.CloneManager:GetComponent("Total/secondOverlordText", "Top_UILabel", "label", self.total)
    end
    return self.secondOverlordText
end

---@type Top_UILabel 特殊时间
function UIOverlordRank_UnitTemplate:GetOverlordTime()
    if self.overlordTime == nil and self.CloneManager ~= nil then
        self.overlordTime = self.CloneManager:GetComponent("Total/overlordTime", "Top_UILabel", "label", self.total)
    end
    return self.overlordTime
end

---@type UnityEngine.GameObject 已领取
function UIOverlordRank_UnitTemplate:GetReceivedRewardObj()
    if self.receivedRewardObj == nil and self.CloneManager ~= nil then
        self.receivedRewardObj = self.CloneManager:GetComponent("Total/receivedReward", "GameObject", "geted", self.total)
    end
    return self.receivedRewardObj
end

---@type UnityEngine.GameObject 竞技按钮
function UIOverlordRank_UnitTemplate:GetCompetitionBtn()
    if self.competitionBtn == nil and self.CloneManager ~= nil then
        self.competitionBtn = self.CloneManager:GetComponent("Total/btn_announce", "GameObject", "btn_announce", self.total)
    end
    return self.competitionBtn
end

--初始化变量
function UIOverlordRank_UnitTemplate:InitParameters()
    self:RunBaseFunction("InitParameters")
    self.isMain = false
    self.titleItemId = 0
end

function UIOverlordRank_UnitTemplate:SetTemplate(data)
    self.isMain = data.isMain
    self.tblInfo = data.tblInfo
    self.overlordRankId = data.tblInfo ~= nil and data.tblInfo.id or 0
    self.rewardInfoTemplateList = {}
    self:RunBaseFunction("SetTemplate", data)
end

function UIOverlordRank_UnitTemplate:InitComponents()
    self:RunBaseFunction("InitComponents")
    ---@type UnityEngine.Transform
    self.hightPoint = self:Get("hightPoint", "Transform")
    ---@type UnityEngine.Transform
    self.lowPoint = self:Get("lowPoint", "Transform")
    ---@type UnityEngine.GameObject 背景
    self.bg = self:Get("Background", "Top_UISprite")

    self.goWidght = CS.Utility_Lua.GetComponent(self.go.transform, "UIWidget")
    self.goBox = CS.Utility_Lua.GetComponent(self.go.transform, "BoxCollider")
end

function UIOverlordRank_UnitTemplate:SetOtherInfo()
    self:RefreshTitleInfo()
end

function UIOverlordRank_UnitTemplate:RefreshTitleInfo()
    if self.rankData == nil or self.rankData.merit == nil then
        self.titleInfo = nil
        return
    end
    local isFind, titleId

    for i = 0, self.rankData.merit.Count - 1 do
        titleId = self.rankData.merit[i].theTitle
        if titleId ~= 0 then
            isFind, self.titleInfo = CS.Cfg_TitleTableManager.Instance.dic:TryGetValue(titleId)
            if isFind then
                return
            end
        end
    end
end

function UIOverlordRank_UnitTemplate:RefreshTitle()
    if self.titleInfo == nil then
        return
    end
    if self.curEffectPool ~= nil then
        --删除之前的资源
        if CS.CSObjectPoolMgr.Instance ~= nil then
            CS.CSObjectPoolMgr.Instance:RemoveUIPoolItem(self.curEffectPool)
        end
    end
    CS.CSResourceManager.Singleton:AddQueueCannotDelete(self.titleInfo.model, CS.ResourceType.Effect, function(res)
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

function UIOverlordRank_UnitTemplate:OnDestroy()
    self.titleInfo = nil
    self:RunBaseFunction("OnDestroy")
end

return UIOverlordRank_UnitTemplate
