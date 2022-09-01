---@class UICityWarContributeRankUnitTemplate:TemplateBase
local UICityWarContributeRankUnitTemplate = {};

UICityWarContributeRankUnitTemplate.mOwnerPanel = nil;

---@type sabacV2.SabacDonateRankPlayer
UICityWarContributeRankUnitTemplate.mContributeRankData = nil;

function UICityWarContributeRankUnitTemplate:GetRankValue_Text()
    if (self.mRankDes_Text == nil) then
        self.mRankDes_Text = self:Get("rank", "UILabel");
    end
    return self.mRankDes_Text;
end

function UICityWarContributeRankUnitTemplate:GetName_Text()
    if (self.mName_Text == nil) then
        self.mName_Text = self:Get("name", "UILabel")
    end
    return self.mName_Text;
end

function UICityWarContributeRankUnitTemplate:GetContributeValue_Text()
    if (self.mContributeValue_Text == nil) then
        self.mContributeValue_Text = self:Get("contribute", "UILabel");
    end
    return self.mContributeValue_Text;
end

---@public
---@param contributeRankData sabacV2.SabacDonateRankPlayer
function UICityWarContributeRankUnitTemplate:UpdateUnit(contributeRankData, rank)
    self.mContributeRankData = contributeRankData;
    self.rank = rank
    self:UpdateUI();
end

---@public
function UICityWarContributeRankUnitTemplate:UpdateUI()
    if self.rank then
        local colorStr = Utility.GetShaBaKContributeRankColor(self.rank);
        local myRankStr = self.rank <= 0 and "未上榜  " or "第" .. self.rank .. "名 ";
        self:GetRankValue_Text().text = colorStr .. myRankStr .. "[-]";
        if (self.mContributeRankData ~= nil) then
            self:GetName_Text().text = '[ffdebc]' .. self.mContributeRankData.name;
            self:GetContributeValue_Text().text = "[ff4436]钻石" .. self.mContributeRankData.donamte .. "[-]";
        else
            self:GetName_Text().text = "[ffdebc]虚位以待";
            self:GetContributeValue_Text().text = "";
        end
    else
        self:GetRankValue_Text().text = ""
        self:GetName_Text().text = "";
        self:GetContributeValue_Text().text = "";
    end
end

function UICityWarContributeRankUnitTemplate:Init(panel)
    self.mOwnerPanel = panel;
end

return UICityWarContributeRankUnitTemplate;