---活动副本排行Item
local UIActivityDuplicateRankItemTemplate = { {} }

function UIActivityDuplicateRankItemTemplate:Init()
    self:InitComponents()
end
--通过工具生成 控件变量
function UIActivityDuplicateRankItemTemplate:InitComponents()
    --名字
    self.mName_UILabel = self:Get("Name", "Top_UILabel")
    --排行
    self.mRank_UILabel = self:Get("Number", "Top_UILabel")
    --等级
    self.mLevel_UILabel = self:Get("Level", "Top_UILabel")
    --职业
    self.mCareer_UILabel = self:Get("Career", "Top_UILabel")
    --分数
    self.mScore_UILabel = self:Get("Score", "Top_UILabel")
    --奖励
    self.mRewardList_UIGrid = self:Get("Awards", "UIGridContainer")
    --排行
    self.mRankBg_UISprite = self:Get("NumberSp", "UISprite")
end

function UIActivityDuplicateRankItemTemplate:Show(rank, name, level, career, score, reward)
    self.mName_UILabel.text = name
    self.mRank_UILabel.text = rank
    self.mLevel_UILabel.text = level
    self.mCareer_UILabel.text = Utility.GetCareerName(career)
    self.mScore_UILabel.text = score
    self.mRewardList_UIGrid.MaxCount = reward.list.Count
    for i = 0, self.mRewardList_UIGrid.MaxCount - 1 do
        local template = templatemanager.GetNewTemplate(self.mRewardList_UIGrid.controlList[i], luaComponentTemplates.UIActivityDuplicateRewardItemTemplate)
        template:RefreshUI(reward.list[i].list[0], reward.list[i].list[1])
    end
    self.mRankBg_UISprite.spriteName = ""
    if rank == 1 then
        self.mRankBg_UISprite.spriteName = "rank1"
    elseif rank == 2 then
        self.mRankBg_UISprite.spriteName = "rank2"
    elseif rank == 3 then
        self.mRankBg_UISprite.spriteName = "rank3"
    end
end

return UIActivityDuplicateRankItemTemplate