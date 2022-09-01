---@class UICarnivalPanel_ScoreTemplate:TemplateBase
local UICarnivalPanel_ScoreTemplate = {}

UICarnivalPanel_ScoreTemplate.mRewardId = 1000028

--region  组件
---@return UILabel
function UICarnivalPanel_ScoreTemplate:GetScore_UILabel()
    if self.mScoreLb == nil then
        self.mScoreLb = self:Get("progress", "UILabel")
    end
    return self.mScoreLb
end

---@return UnityEngine.GameObject
function UICarnivalPanel_ScoreTemplate:GetReward_Go()
    if self.mRewardGo == nil then
        self.mRewardGo = self:Get("RewardItem", "GameObject")
    end
    return self.mRewardGo
end
---@return UILabel
function UICarnivalPanel_ScoreTemplate:GetScore_UILabel()
    if self.mScoreLb == nil then
        self.mScoreLb = self:Get("progress", "UILabel")
    end
    return self.mScoreLb
end

---@return UISprite 奖励icon
function UICarnivalPanel_ScoreTemplate:GetRewardIcon_UISprite()
    if self.mRewardSprite == nil then
        self.mRewardSprite = self:Get("RewardItem/icon", "UISprite")
    end
    return self.mRewardSprite
end

---@return UILabel 奖励数目
function UICarnivalPanel_ScoreTemplate:GetRewardNum_UILabel()
    if self.mRewardNum == nil then
        self.mRewardNum = self:Get("RewardItem/count", "UILabel")
    end
    return self.mRewardNum
end

---@return UILabel 领取状态
function UICarnivalPanel_ScoreTemplate:GetRewardState_UILabel()
    if self.mRewardState == nil then
        self.mRewardState = self:Get("RewardItem/Label", "UILabel")
    end
    return self.mRewardState
end
--endregion

--region 数据
---@return TABLE.CFG_ITEMS
function UICarnivalPanel_ScoreTemplate:GetItemInfo(id)
    if self.mRootPanel then
        return self.mRootPanel:CacheItemInfo(id)
    end
end
--endregion

--region 初始化
---@param panel UICarnivalPanel
function UICarnivalPanel_ScoreTemplate:Init(panel)
    self.mRootPanel = panel
    self:BindEvents()
end

function UICarnivalPanel_ScoreTemplate:BindEvents()
    CS.UIEventListener.Get(self:GetReward_Go()).onClick = function(go)
        self:OnRewardClicked(go)
    end
end
--endregion

---刷新狂欢点
function UICarnivalPanel_ScoreTemplate:RefreshScore(line, rate)
    if line then
        self:GetScore_UILabel().text = (line + 1) * rate

        local rewardInfo = self:GetItemInfo(self.mRewardId)
        if rewardInfo then
            self:GetRewardIcon_UISprite().spriteName = rewardInfo.icon
        end
        self:GetRewardNum_UILabel().text = ""
        self:GetRewardState_UILabel().text = "可领取"
    end
    self:GetScore_UILabel().gameObject:SetActive(line ~= nil)
    self:GetReward_Go():SetActive(line ~= nil)
end

---点击领奖按钮
function UICarnivalPanel_ScoreTemplate:OnRewardClicked(go)

end

return UICarnivalPanel_ScoreTemplate