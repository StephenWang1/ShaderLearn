---@class UICityWarRankingUnitTemplate
local UICityWarRankingUnitTemplate = {};

---@type duplicateV2.SabacRankInfo
UICityWarRankingUnitTemplate.mRankVo = nil;

UICityWarRankingUnitTemplate.mRankType = nil;

--region Components

function UICityWarRankingUnitTemplate:GetMineSign_GameObject()
    if(self.mMineSign_GameObject == nil) then
        self.mMineSign_GameObject = self:Get("chosenhight", "GameObject");
    end
    return self.mMineSign_GameObject;
end

function UICityWarRankingUnitTemplate:GetRankValue_Text()
    if(self.mRankValue_Text == nil) then
        self.mRankValue_Text = self:Get("rank","UILabel");
    end
    return self.mRankValue_Text;
end

function UICityWarRankingUnitTemplate:GetPlayerName_Text()
    if(self.mPlayerName_Text == nil) then
        self.mPlayerName_Text = self:Get("playerName","UILabel");
    end
    return self.mPlayerName_Text;
end

function UICityWarRankingUnitTemplate:GetScoreValue_Text()
    if(self.mScoreValue_Text == nil) then
        self.mScoreValue_Text = self:Get("score","UILabel");
    end
    return self.mScoreValue_Text;
end

function UICityWarRankingUnitTemplate:GetUnionName_Text()
    if(self.mUnionName_Text == nil) then
        self.mUnionName_Text = self:Get("union", "UILabel");
    end
    return self.mUnionName_Text;
end

function UICityWarRankingUnitTemplate:GetKillOrDieNum_Text()
    if(self.mKillOrDieNum_Text == nil) then
        self.mKillOrDieNum_Text = self:Get("kill", "UILabel");
    end
    return self.mKillOrDieNum_Text;
end

function UICityWarRankingUnitTemplate:GetCareer_Text()
    if(self.mCareer_Text == nil) then
        self.mCareer_Text = self:Get("careerSprite","UILabel");
    end
    return self.mCareer_Text;
end

function UICityWarRankingUnitTemplate:GetRankSprite_UISprite()
    if(self.mRankSprite_UISprite == nil) then
        self.mRankSprite_UISprite = self:Get("firstSprite","UISprite")
    end
    return self.mRankSprite_UISprite;
end

--function UICityWarRankingUnitTemplate:GetCareerSprite_UISprite()
--    if(self.mCareerSprite_UISprite == nil) then
--        self.mCareerSprite_UISprite = self:Get("careerSprite","UISprite");
--    end
--    return self.mCareerSprite_UISprite;
--end

--endregion

--region Method

--region Public

function UICityWarRankingUnitTemplate:UpdateUnit(rankVo, type)
    self.mRankVo = rankVo;
    self.mRankType = type;
    self:UpdateUI();
end

function UICityWarRankingUnitTemplate:UpdateUI()
    if(self.mRankVo ~= nil) then
        self:GetRankValue_Text().gameObject:SetActive(self.mRankVo.rank > 3);
        self:GetRankSprite_UISprite().gameObject:SetActive(self.mRankVo.rank <= 3);
        if(self.mRankVo.rank <= 3) then
            self:GetRankSprite_UISprite().spriteName = tostring(self.mRankVo.rank);
        end
        --self:GetCareerSprite_UISprite().spriteName = "job"..self.mRankVo.career + 1;
        self:GetMineSign_GameObject().gameObject:SetActive(self.mRankVo.roleId == CS.CSScene.MainPlayerInfo.ID);
        self:GetUnionName_Text().text = self.mRankVo.unionName;
        self:GetRankValue_Text().text = tostring(self.mRankVo.rank);
        self:GetPlayerName_Text().text = self.mRankVo.name;
        local score = self.mRankVo.newScore;
        self:GetScoreValue_Text().text = score == nil and 0 or score;
        self:GetCareer_Text().text = Utility.GetCareerName(self.mRankVo.career);
        --if(self.mRankType == Utility.EnumToInt(CS.duplicateV2.SabacRankType.Kill)) then
        --    self:GetKillOrDieNum_Text().text = self.mRankVo.killCount;
        --else
        --    self:GetKillOrDieNum_Text().text = self.mRankVo.dieCount;
        --end
    end
end

function UICityWarRankingUnitTemplate:UpdateOtherUI()
    if(self.mRankVo ~= nil) then
        self:GetKillOrDieNum_Text().text = self.mRankVo.killCount;
    end
end

--endregion

--region Private

function UICityWarRankingUnitTemplate:InitEvents()

end

function UICityWarRankingUnitTemplate:RemoveEvents()

end

--endregion

--endregion

function UICityWarRankingUnitTemplate:Init()
    self:InitEvents();
end

function UICityWarRankingUnitTemplate:OnDestroy()
    self:RemoveEvents();
end

return UICityWarRankingUnitTemplate;