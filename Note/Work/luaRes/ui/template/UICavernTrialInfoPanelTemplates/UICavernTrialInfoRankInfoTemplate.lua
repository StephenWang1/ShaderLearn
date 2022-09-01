local UICavernTrialInfoRankInfoTemplate = {}

function UICavernTrialInfoRankInfoTemplate:Init()
    self:InitComponents()
end
--通过工具生成 控件变量
function UICavernTrialInfoRankInfoTemplate:InitComponents()
    --名字
    self.mName_UILabel = self:Get("name", "UILabel")
    --排名
    self.mRank_UILabel = self:Get("rank", "UILabel")
    --数量
    self.mCount_UILabel = self:Get("count", "UILabel")
    --是否是我
    self.mIsMe_UILabel = self:Get("isMe", "GameObject")
end

---刷新
function UICavernTrialInfoRankInfoTemplate:Refresh(name, rank, count, isMe)
    self.mName_UILabel.text = name
    self.mRank_UILabel.text = tostring(rank)
    self.mCount_UILabel.text = tostring(count)
    self.mIsMe_UILabel:SetActive(isMe)
end

return UICavernTrialInfoRankInfoTemplate