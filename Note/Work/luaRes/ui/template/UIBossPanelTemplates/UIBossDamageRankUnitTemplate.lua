---@class UIBossDamageRankUnitTemplate
local UIBossDamageRankUnitTemplate = {};

UIBossDamageRankUnitTemplate.mRankData = nil;

--region Components

function UIBossDamageRankUnitTemplate:GetBtnAttack_GameObject()
    if (self.mBtnAttack_GameObject == nil) then
        self.mBtnAttack_GameObject = self:Get("killplayer", "GameObject");
    end
    return self.mBtnAttack_GameObject;
end

function UIBossDamageRankUnitTemplate:GetRankSprite_UISprite()
    if (self.mRankSprite_UISprite == nil) then
        self.mRankSprite_UISprite = self:Get("rankSprite", "UISprite");
    end
    return self.mRankSprite_UISprite;
end

function UIBossDamageRankUnitTemplate:GetBackGround_UISprite()
    if (self.mBackGround_UISprite == nil) then
        self.mBackGround_UISprite = self:Get("bg", "UISprite");
    end
    return self.mBackGround_UISprite;
end

function UIBossDamageRankUnitTemplate:GetRankValue_Text()
    if (self.mRankValue_Text == nil) then
        self.mRankValue_Text = self:Get("firstValue", "UILabel");
    end
    return self.mRankValue_Text;
end

function UIBossDamageRankUnitTemplate:GetPlayerName_Text()
    if (self.mPlayerName_Text == nil) then
        self.mPlayerName_Text = self:Get("secondValue", "UILabel");
    end
    return self.mPlayerName_Text;
end

function UIBossDamageRankUnitTemplate:GetDamageValue_Text()
    if (self.mDamageValue_Text == nil) then
        self.mDamageValue_Text = self:Get("thirdValue", "UILabel");
    end
    return self.mDamageValue_Text;
end

--endregion

--region Method

--region Public

function UIBossDamageRankUnitTemplate:UpdateUnit(rankData, playerUnionRank)
    self.mRankData = rankData;
    self.mPlayerUnionRank = playerUnionRank
    self:UpdateUI();
end

function UIBossDamageRankUnitTemplate:UpdateUI()
    if (self.mRankData ~= nil) then
        self:GetRankValue_Text().text = self.mRankData.rank;
        local isMyUnion = false;
        local isSelf = false;
        if (CS.CSScene.MainPlayerInfo ~= nil) then
            isSelf = self.mRankData.roleId == CS.CSScene.MainPlayerInfo.ID;
            isMyUnion = self.mRankData.unionId ~= 0 and self.mRankData.unionId == CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID;
        end
        local colorStr = "[21a72d]"
        if isMyUnion or isSelf then
            colorStr = luaEnumColorType.Blue2
        else
            local unionRank = self.mRankData.unionRank
            if self.mPlayerUnionRank == 1 then
                if unionRank == 2 then
                    colorStr = "[ed6328]"
                end
            else
                if unionRank == 1 then
                    colorStr = "[ed6328]"
                end
            end
        end
        --colorStr = isSelf and luaEnumColorType.White or colorStr;
        --self:GetBackGround_UISprite().spriteName = isSelf and "BossRank_mychoose" or "rank_listbg";
        self:GetPlayerName_Text().text = colorStr .. self.mRankData.roleName .. "[-]";
        self:GetDamageValue_Text().text = colorStr .. Utility.GetNumStr(self.mRankData.hurt) .. "[-]";
        self:GetRankSprite_UISprite().gameObject:SetActive(false);
        --self:GetRankSprite_UISprite().gameObject:SetActive(self.mRankData.rank <= 3);
        --self:GetRankValue_Text().gameObject:SetActive(self.mRankData.rank > 3);
        --if(self.mRankData.rank <= 3) then
        --    self:GetRankSprite_UISprite().spriteName = "paihang"..self.mRankData.rank;
        --end

        self:GetBtnAttack_GameObject():SetActive(self.mRankData.roleId ~= CS.CSScene.MainPlayerInfo.ID and self.mRankData.rank <= 10 and not isMyUnion);
    end
end

--endregion

--region Private

function UIBossDamageRankUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetBtnAttack_GameObject()).onClick = function()
        if (self.mRankData ~= nil) then
            local targetAvatar = CS.CSScene.Sington:getAvatar(self.mRankData.roleId);
            CS.CSScene.Sington.MainPlayer.TouchEvent:SetTarget(targetAvatar);
            --CS.CSAutoFightMgr.Instance:Toggle(true);
        end
    end;
end

function UIBossDamageRankUnitTemplate:RemoveEvents()

end

--endregion

--endregion

function UIBossDamageRankUnitTemplate:Init()
    self:InitEvents();
end

function UIBossDamageRankUnitTemplate:OnDestroy()
    self:RemoveEvents();
end

return UIBossDamageRankUnitTemplate;