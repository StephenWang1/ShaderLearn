---@class UICityWarContributeRankRewardUnitTemplate:TemplateBase
local UICityWarContributeRankRewardUnitTemplate = {};

UICityWarContributeRankRewardUnitTemplate.mOwnerPanel = nil;

---@type TABLE.cfg_sbk_donate_reward
UICityWarContributeRankRewardUnitTemplate.mRewardTable = nil;

function UICityWarContributeRankRewardUnitTemplate:GetRewardDes_Text()
    if(self.mRewardDes_Text == nil) then
        self.mRewardDes_Text = self:Get("","UILabel")
    end
    return self.mRewardDes_Text;
end

---@public
---@param tbl TABLE.cfg_sbk_donate_reward
function UICityWarContributeRankRewardUnitTemplate:UpdateUnit(tbl)
    self.mRewardTable = tbl;
    self:UpdateUI();
end

---@public
function UICityWarContributeRankRewardUnitTemplate:UpdateUI()
    if(self.mRewardTable ~= nil) then
        local colorStr = Utility.GetShaBaKContributeRankColor(self.mRewardTable:GetId());
        local rankStr = self.mRewardTable:GetId() == 0 and colorStr.."第5名以下[-]" or colorStr.."第"..self.mRewardTable:GetId().."名[-]";
        self:GetRewardDes_Text().text = rankStr.." "..self.mRewardTable:GetTips();
    end
end

function UICityWarContributeRankRewardUnitTemplate:Init(panel)
    self.mOwnerPanel = panel;
end

return UICityWarContributeRankRewardUnitTemplate;