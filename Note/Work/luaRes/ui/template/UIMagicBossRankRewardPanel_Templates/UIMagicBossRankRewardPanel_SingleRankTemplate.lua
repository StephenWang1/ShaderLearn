local UIMagicBossRankRewardPanel_SingleRankTemplate = {}

setmetatable(UIMagicBossRankRewardPanel_SingleRankTemplate,luaComponentTemplates.UIRefreshTemplate)

--region 初始化
function UIMagicBossRankRewardPanel_SingleRankTemplate:Init()
    self:InitComponent()
end

function UIMagicBossRankRewardPanel_SingleRankTemplate:InitComponent()
    self.ranking_UISprite = self:Get("Total/rankingSprite","UISprite")
    self.ranking_UILabel = self:Get("Total/rankingValue","UILabel")
    self.reward_UIGridContainer = self:Get("quiteDropGrid","UIGridContainer")
    self.backGround_GameObject = self:Get("Background","GameObject")
end
--endregion

--region 刷新
function UIMagicBossRankRewardPanel_SingleRankTemplate:RefreshPanel(commonData)
    if self:AnalysisParams(commonData) == false then
        self.go:SetActive(false)
        return
    end
    self:RefreshRanking()
    self:RefreshRewardList()
    self:RefreshBackGround()
end

function UIMagicBossRankRewardPanel_SingleRankTemplate:AnalysisParams(commonData)
    if commonData == nil or commonData.singleRankRewardInfo == nil or commonData.index == nil or commonData.singleRankRewardInfo.RankRewardCommonInfo == nil then
        return false
    end
    self.singleRankRewardInfo = commonData.singleRankRewardInfo
    self.singleRankRewardTableInfo = commonData.singleRankRewardInfo.RankRewardCommonInfo
    self.index = commonData.index
end

function UIMagicBossRankRewardPanel_SingleRankTemplate:RefreshRanking()
    if CS.StaticUtility.IsNull(self.ranking_UISprite) == false and CS.StaticUtility.IsNull(self.ranking_UILabel) == false then
        local rewardRankingType = self.singleRankRewardInfo.RankingType
        self.ranking_UISprite.gameObject:SetActive(rewardRankingType == LuaEnumRewardRankingType.Sprite)
        self.ranking_UILabel.gameObject:SetActive(rewardRankingType == LuaEnumRewardRankingType.Label)
        if rewardRankingType == LuaEnumRewardRankingType.Sprite then
            self.ranking_UISprite.spriteName = self.singleRankRewardInfo.RankintTypeContent
        elseif rewardRankingType == LuaEnumRewardRankingType.Label then
            self.ranking_UILabel.text = self.singleRankRewardInfo.RankintTypeContent
        end
    end
end

function UIMagicBossRankRewardPanel_SingleRankTemplate:RefreshRewardList()
    if self.singleRankRewardTableInfo ~= nil and self.singleRankRewardTableInfo.reward ~= nil and self.singleRankRewardTableInfo.reward.list.Count > 0 and CS.StaticUtility.IsNull(self.reward_UIGridContainer) == false then
        self.reward_UIGridContainer.MaxCount = self.singleRankRewardTableInfo.reward.list.Count
        local length = self.singleRankRewardTableInfo.reward.list.Count - 1
        for k = 0,length do
            local rewardInfoList = self.singleRankRewardTableInfo.reward.list[k]
            if rewardInfoList ~= nil and rewardInfoList.list.Count ~= nil and rewardInfoList.list.Count > 1 then
                local itemId = rewardInfoList.list[0]
                local count = rewardInfoList.list[1]
                local itemInfoIsFind,itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId)
                if itemInfoIsFind == true then
                    local go = self.reward_UIGridContainer.controlList[k]
                    local template = templatemanager.GetNewTemplate(go,luaComponentTemplates.UIItem)
                    template:RefreshUIWithItemInfo(itemInfo,count)
                    CS.UIEventListener.Get(go).onClick = function(go)
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
                    end
                end
            end
        end
    end
end

function UIMagicBossRankRewardPanel_SingleRankTemplate:RefreshBackGround()
    if CS.StaticUtility.IsNull(self.backGround_GameObject) == false then
        self.backGround_GameObject:SetActive(self.index % 2 == 0)
    end
end
--endregion

return UIMagicBossRankRewardPanel_SingleRankTemplate