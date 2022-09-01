local UIJoinTeamUnitTemplate = {}

UIJoinTeamUnitTemplate.mPlayerData = {};

--region Components

--region GameObject

function UIJoinTeamUnitTemplate:GetBackGround_GameObject()
    if (self.mBackGround_GameObject == nil) then
        self.mBackGround_GameObject = self:Get("fengexian", "GameObject");
    end
    return self.mBackGround_GameObject;
end

function UIJoinTeamUnitTemplate:GetBtnCancel_GameObject()
    if (self.mBtnCancel_GameObject == nil) then
        self.mBtnCancel_GameObject = self:Get("btn_jujue", "GameObject");
    end
    return self.mBtnCancel_GameObject;
end

function UIJoinTeamUnitTemplate:GetBtnDefine_GameObject()
    if (self.mBtnDefine_GameObject == nil) then
        self.mBtnDefine_GameObject = self:Get("btn_jieshou", "GameObject");
    end
    return self.mBtnDefine_GameObject;
end

--endregion

function UIJoinTeamUnitTemplate:GetPlayerHead_UISprite()
    if (self.mPlayerHead_UISprite == nil) then
        self.mPlayerHead_UISprite = self:Get("player", "UISprite");
    end
    return self.mPlayerHead_UISprite;
end

function UIJoinTeamUnitTemplate:GetPlayerCareer_UISprite()
    if (self.mPlayerCareer_UISprite == nil) then
        self.mPlayerCareer_UISprite = self:Get("career", "UISprite");
    end
    return self.mPlayerCareer_UISprite;
end

function UIJoinTeamUnitTemplate:GetPlayerName_Text()
    if (self.mPlayerName_Text == nil) then
        self.mPlayerName_Text = self:Get("title", "UILabel");
    end
    return self.mPlayerName_Text;
end

function UIJoinTeamUnitTemplate:GetPlayerLevel_Text()
    if (self.mPlayerLevel_Text == nil) then
        self.mPlayerLevel_Text = self:Get("level", "UILabel");
    end
    return self.mPlayerLevel_Text;
end

function UIJoinTeamUnitTemplate:GetPlayerGuildName_Text()
    if (self.mPlayerGuildName_Text == nil) then
        self.mPlayerGuildName_Text = self:Get("guild", "UILabel");
    end
    return self.mPlayerGuildName_Text;
end

--endregion

--region Method

--region CallFunction

function UIJoinTeamUnitTemplate:OnClickBtnDefine()
    if (self.mPlayerData ~= nil) then
        if (self.mPlayerData.type == Utility.EnumToInt(CS.JoinTeamReqType.Normal)) then
            if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                networkRequest.ReqShareAcceptApply(1, self.mPlayerData.roleId)
            else
                networkRequest.ReqAcceptTeamApplication(1, self.mPlayerData.roleId)
            end
        elseif (self.mPlayerData.type == Utility.EnumToInt(CS.JoinTeamReqType.NeedTwoAgree)) then
            if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                networkRequest.ReqShareCaptainAcceptInvit(1, self.mPlayerData.roleId, self.mPlayerData.invitingRoleId);
            else
                networkRequest.ReqCaptainAcceptInvit(1, self.mPlayerData.roleId, self.mPlayerData.invitingRoleId);
            end
        end
        local customData = {};
        customData.roleId = self.mPlayerData.roleId;
        customData.state = 1;
        luaEventManager.DoCallback(LuaCEvent.Team_OnJoinTeamStateChange, customData)
    end
end

function UIJoinTeamUnitTemplate:OnClickBtnCancel()
    if (self.mPlayerData ~= nil) then
        if (self.mPlayerData.type == Utility.EnumToInt(CS.JoinTeamReqType.Normal)) then
            if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                networkRequest.ReqShareAcceptApply(2, self.mPlayerData.roleId)
            else
                networkRequest.ReqAcceptTeamApplication(2, self.mPlayerData.roleId)
            end
        elseif (self.mPlayerData.type == Utility.EnumToInt(CS.JoinTeamReqType.NeedTwoAgree)) then
            if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                networkRequest.ReqShareCaptainAcceptInvit(2, self.mPlayerData.roleId, self.mPlayerData.invitingRoleId);
            else
                networkRequest.ReqCaptainAcceptInvit(2, self.mPlayerData.roleId, self.mPlayerData.invitingRoleId);
            end
        end
        local customData = {};
        customData.roleId = self.mPlayerData.roleId;
        customData.state = 2;
        luaEventManager.DoCallback(LuaCEvent.Team_OnJoinTeamStateChange, customData)
    end
end

function UIJoinTeamUnitTemplate:OnClickPlayerHead()
    uimanager:CreatePanel("UIGuildTipsPanel", nil, {
        panelType = LuaEnumPanelIDType.MonsterHeadPanel,
        roleId = self.mPlayerData.roleId,
        roleName = self.mPlayerData.roleName
    })
end

--endregion

--region Public

function UIJoinTeamUnitTemplate:UpdateUnit(playerData)
    self.mPlayerData = playerData
    self:UpdateUI();
end

function UIJoinTeamUnitTemplate:UpdateUI()
    if (self.mPlayerData ~= nil) then
        self:GetPlayerName_Text().text = self.mPlayerData.roleName;
        self:GetPlayerGuildName_Text().text = CS.CSScene.MainPlayerInfo.GroupInfoV2:GetTeamRelationString(self.mPlayerData);
        self:GetPlayerLevel_Text().text = self.mPlayerData.level;

        self:GetPlayerCareer_UISprite().spriteName = self:GetCareerSpriteName(self.mPlayerData.career, self.mPlayerData.isCaptain);
        self:GetPlayerHead_UISprite().spriteName = "headicon" .. self.mPlayerData.sex .. self.mPlayerData.career;
    end
end

--endregion

--region Private

function UIJoinTeamUnitTemplate:GetCareerSpriteName(career, isCaptain)
    if (isCaptain == nil) then
        isCaptain = false;
    end

    if (isCaptain) then
        return "teamjob_leader";
    elseif (career ~= nil) then
        return "teamjob_" .. career;
    end
    return "";
end

function UIJoinTeamUnitTemplate:InitEvents()

    CS.UIEventListener.Get(self:GetBtnDefine_GameObject()).onClick = function()
        self:OnClickBtnDefine();
    end

    CS.UIEventListener.Get(self:GetBtnCancel_GameObject()).onClick = function()
        self:OnClickBtnCancel();
    end

    CS.UIEventListener.Get(self:GetPlayerHead_UISprite().gameObject).onClick = function()
        self:OnClickPlayerHead();
    end
end

function UIJoinTeamUnitTemplate:RemoveEvents()

end

function UIJoinTeamUnitTemplate:Clear()
    self.mPlayerGuildName_Text = nil;
    self.mPlayerLevel_Text = nil;
    self.mPlayerName_Text = nil;
    self.mPlayerCareer_UISprite = nil;
    self.mPlayerHead_UISprite = nil;
    self.mBtnDefine_GameObject = nil;
    self.mBtnCancel_GameObject = nil;
    self.mBackGround_GameObject = nil;
    self.mPlayerData = nil;
end

--endregion

--endregion

function UIJoinTeamUnitTemplate:Init()
    self:InitEvents();
end

function UIJoinTeamUnitTemplate:OnDestroy()
    self:Clear();
end

return UIJoinTeamUnitTemplate;