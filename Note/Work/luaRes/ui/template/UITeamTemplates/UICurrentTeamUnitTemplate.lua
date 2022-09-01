---@class UICurrentTeamUnitTemplate:TemplateBase 组队单个模板
local UICurrentTeamUnitTemplate = {};

UICurrentTeamUnitTemplate.mPlayerData = nil;

--region Components

function UICurrentTeamUnitTemplate:GetPlayerHeadFrame_GameObject()
    if (self.mPlayerHeadFrame_GameObject == nil) then
        self.mPlayerHeadFrame_GameObject = self:Get("headframe", "GameObject");
    end
    return self.mPlayerHeadFrame_GameObject;
end

function UICurrentTeamUnitTemplate:GetGroupCaptain_GameObject()
    if (self.mGroupCaptain_GameObject == nil) then
        self.mGroupCaptain_GameObject = self:Get("leader", "GameObject");
    end
    return self.mGroupCaptain_GameObject;
end

function UICurrentTeamUnitTemplate:GetBackGround_GameObject()
    if (self.mBackGround_GameObject == nil) then
        self.mBackGround_GameObject = self:Get("bg", "GameObject");
    end
    return self.mBackGround_GameObject;
end

function UICurrentTeamUnitTemplate:GetPlayerHead_UISprite()
    if (self.mPlayerHead_UISprite == nil) then
        self.mPlayerHead_UISprite = self:Get("headframe/head", "UISprite");
    end
    return self.mPlayerHead_UISprite;
end

function UICurrentTeamUnitTemplate:GetPlayerCareer_UISprite()
    if (self.mPlayerCareer_UISprite == nil) then
        self.mPlayerCareer_UISprite = self:Get("lb_career", "UISprite");
    end
    return self.mPlayerCareer_UISprite;
end

function UICurrentTeamUnitTemplate:GetPlayerName_Text()
    if (self.mPlayerName_Text == nil) then
        self.mPlayerName_Text = self:Get("lb_name", "UILabel");
    end
    return self.mPlayerName_Text;
end

function UICurrentTeamUnitTemplate:GetPlayerLevel_Text()
    if (self.mPlayerLevel_Text == nil) then
        self.mPlayerLevel_Text = self:Get("lb_level", "UILabel");
    end
    return self.mPlayerLevel_Text;
end

function UICurrentTeamUnitTemplate:GetPlayerGuildName_Text()
    if (self.mPlayerGuildName_Text == nil) then
        self.mPlayerGuildName_Text = self:Get("lb_guild", "UILabel");
    end
    return self.mPlayerGuildName_Text;
end

--endregion

--region Method

--region Public

function UICurrentTeamUnitTemplate:UpdateUnit(playerData, index)
    self.mPlayerData = playerData;
    self:GetBackGround_GameObject():SetActive(index % 2 == 0);
    self:UpdateUI();
end

function UICurrentTeamUnitTemplate:UpdateUI()
    if (self.mPlayerData ~= nil) then
        self:GetGroupCaptain_GameObject():SetActive(self.mPlayerData.isCaptain);

        self:GetPlayerName_Text().text = self.mPlayerData.roleName;
        self:GetPlayerGuildName_Text().text = CS.CSScene.MainPlayerInfo.GroupInfoV2:GetTeamRelationString(self.mPlayerData);
        self:GetPlayerLevel_Text().text = self.mPlayerData.level;

        self:GetPlayerCareer_UISprite().spriteName = self.CareerIcon[self.mPlayerData.career]
        self:GetPlayerHead_UISprite().spriteName = Utility.GetPlayerHeadIconSpriteName(self.mPlayerData.sex, self.mPlayerData.career)
    end
end

--endregion

--region Private

UICurrentTeamUnitTemplate.CareerIcon = {
    [LuaEnumCareer.Warrior] = "zhan",
    [LuaEnumCareer.Master] = "fa",
    [LuaEnumCareer.Taoist] = "dao",
}

function UICurrentTeamUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetPlayerHeadFrame_GameObject()).onClick = function()
        if (self.mPlayerData ~= nil) then
            local isCaptain = CS.CSScene.MainPlayerInfo.GroupInfoV2.IsCaptain;
            local type = isCaptain and LuaEnumPanelIDType.TeamPanel_MyTeamPanel or LuaEnumPanelIDType.TeamPanel_Members;
            uimanager:CreatePanel("UIGuildTipsPanel", nil, {
                panelType = type,
                roleId = self.mPlayerData.roleId,
                roleName = self.mPlayerData.roleName,
                roleSex = self.mPlayerData.sex,
                roleCareer = self.mPlayerData.career,
                teamData = self.mPlayerData
            });
        end
    end
end

function UICurrentTeamUnitTemplate:RemoveEvents()

end

--endregion

--endregion

function UICurrentTeamUnitTemplate:Init()
    self:InitEvents();
end

function UICurrentTeamUnitTemplate:OnDestroy()
    self:RemoveEvents();
end

return UICurrentTeamUnitTemplate;