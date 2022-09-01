local UIJoinOtherTeamUnitTemplate = {};

setmetatable(UIJoinOtherTeamUnitTemplate, luaComponentTemplates.UIJoinTeamUnitTemplate)

--region Method

--region Override

function UIJoinOtherTeamUnitTemplate:UpdateUnit(invitationPlayerInfo)
    self.mPlayerData = invitationPlayerInfo
    self:UpdateUI();
end

function UIJoinOtherTeamUnitTemplate:UpdateUI()
    if (self.mPlayerData ~= nil) then
        self:GetPlayerName_Text().text = self.mPlayerData.playerName;
        self:GetPlayerGuildName_Text().text = "";
        self:GetPlayerLevel_Text().text = self.mPlayerData.level;

        self:GetPlayerCareer_UISprite().spriteName = self:GetCareerSpriteName(self.mPlayerData.career, false);
        self:GetPlayerHead_UISprite().spriteName = "headicon" .. self.mPlayerData.sex .. self.mPlayerData.career;
    end
end

function UIJoinOtherTeamUnitTemplate:OnClickBtnDefine()
    if (self.mPlayerData ~= nil) then
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            networkRequest.ReqShareAcceptInvitation(1, self.mPlayerData.groupId, self.mPlayerData.targetId)
        else
            networkRequest.ReqAcceptInvitation(1, self.mPlayerData.groupId, self.mPlayerData.targetId)
        end
        local customData = {};
        customData.roleId = self.mPlayerData.targetId;
        customData.state = 1;
        luaEventManager.DoCallback(LuaCEvent.Team_OnJoinTeamStateChange, customData)
    end
end

function UIJoinOtherTeamUnitTemplate:OnClickBtnCancel()
    if (self.mPlayerData ~= nil) then
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            networkRequest.ReqShareAcceptInvitation(2, self.mPlayerData.groupId, self.mPlayerData.targetId)
        else
            networkRequest.ReqAcceptInvitation(2, self.mPlayerData.groupId, self.mPlayerData.targetId)
        end
        local customData = {};
        customData.roleId = self.mPlayerData.targetId;
        customData.state = 2;
        luaEventManager.DoCallback(LuaCEvent.Team_OnJoinTeamStateChange, customData)
    end
end

--endregion

--endregion

return UIJoinOtherTeamUnitTemplate;