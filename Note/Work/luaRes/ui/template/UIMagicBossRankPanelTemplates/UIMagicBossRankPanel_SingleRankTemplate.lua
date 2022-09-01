local UIMagicBossRankPanel_SingleRankTemplate = {}

setmetatable(UIMagicBossRankPanel_SingleRankTemplate,luaComponentTemplates.UIRefreshTemplate)

--region 初始化
function UIMagicBossRankPanel_SingleRankTemplate:Init()
    self:InitComponent()
end

function UIMagicBossRankPanel_SingleRankTemplate:InitComponent()
    self.firstValue_UILabel = self:Get("firstValue","UILabel")
    self.secondValue_UILabel = self:Get("secondValue","UILabel")
    self.thirdValue_UILabel = self:Get("thirdValue","UILabel")
    self.backGround_UISprite = self:Get("bg","UISprite")
end
--endregion

--region 刷新
---@param commonData.rankInfo
function UIMagicBossRankPanel_SingleRankTemplate:RefreshPanel(commonData)
    if self:AnalysisParams(commonData) == false then
        return
    end
    if self.rankInfo.sidebar_FirstValue ~= nil then
        self:RefreshLabel(self.firstValue_UILabel,self.rankInfo.sidebar_FirstValue)
    end
    if self.rankInfo.sidebar_SecondValue ~= nil then
        self:RefreshLabel(self.secondValue_UILabel,self.rankInfo.sidebar_SecondValue)
    end
    if self.rankInfo.sidebar_ThirdValue ~= nil then
        self:RefreshLabel(self.thirdValue_UILabel,self.rankInfo.sidebar_ThirdValue)
    end
    if CS.StaticUtility.IsNullOrEmpty(self.backGroundSpriteName) == false then
        self:RefreshSprite(self.backGround_UISprite,self.backGroundSpriteName)
    end
end

---解析参数
function UIMagicBossRankPanel_SingleRankTemplate:AnalysisParams(commonData)
    if commonData == nil or commonData.rankInfo == nil then
        return false
    end
    self.rankInfo = commonData.rankInfo
    self.backGroundSpriteName = ternary(self.rankInfo.rid == CS.CSScene.MainPlayerInfo.ID,"BossRank_mychoose","rank_listbg")
    return true
end
--endregion

return UIMagicBossRankPanel_SingleRankTemplate