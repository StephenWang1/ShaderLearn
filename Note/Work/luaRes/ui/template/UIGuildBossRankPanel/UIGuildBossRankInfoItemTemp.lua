---@class UIGuildBossRankInfoItemTemp 行会首领boss左侧界面 排行的个人数据
local UIGuildBossRankInfoItemTemp = {}

--region 组件

---@return Top_UILabel 排行等级
function UIGuildBossRankInfoItemTemp:GetRankLevelLabel()
    if self.mGetRankLevelLabel == nil then
        self.mGetRankLevelLabel = self:Get("rankLevel", "Top_UILabel")
    end
    return self.mGetRankLevelLabel
end


---@return Top_UILabel 名字
function UIGuildBossRankInfoItemTemp:GetPlayerNameLabel()
    if self.mGetPlayerNameLabel == nil then
        self.mGetPlayerNameLabel = self:Get("name", "Top_UILabel")
    end
    return self.mGetPlayerNameLabel
end


---@return Top_UILabel 分数
function UIGuildBossRankInfoItemTemp:GetScoreLabel()
    if self.mGetScoreLabel == nil then
        self.mGetScoreLabel = self:Get("score", "Top_UILabel")
    end
    return self.mGetScoreLabel
end
--endregion

function UIGuildBossRankInfoItemTemp:Init()

end

---公会排名
---@param data unionV2.UnionBossUnionRankStrcut
function UIGuildBossRankInfoItemTemp:UpdateUnionUnit(data)
    if(data == nil) then
        return;
    end

    if(tonumber(data.rankNo) == -1) then
        self:GetRankLevelLabel().text = "未入榜"
    else
        self:GetRankLevelLabel().text = tostring(data.rankNo)
    end

    if(data.score >= 100000) then
        self:GetScoreLabel().text = string.format("%.2f", data.score/10000).."万"
    else
        self:GetScoreLabel().text = tostring(data.score)
    end
    self:GetPlayerNameLabel().text = data.unionName
end

---个人排名
---@param data unionV2.UnionBossPlayerRankStrcut
function UIGuildBossRankInfoItemTemp:UpdatePersonUnit(data)
    if(data == nil) then
        return;
    end
    if(tonumber(data.rankNo) == -1) then
        self:GetRankLevelLabel().text = "未入榜"
    else
        self:GetRankLevelLabel().text = tostring(data.rankNo)
    end

    if(data.score >= 100000) then
        self:GetScoreLabel().text = string.format("%.2f", data.score/10000).."万"
    else
        self:GetScoreLabel().text = tostring(data.score)
    end
    self:GetPlayerNameLabel().text = data.playerName
end


return UIGuildBossRankInfoItemTemp