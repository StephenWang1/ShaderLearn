local UICurrentTeamViewTemplate = {};

UICurrentTeamViewTemplate.mGroupData = nil;

UICurrentTeamViewTemplate.mUnitDic = nil;

--region Components

function UICurrentTeamViewTemplate:GetOtherPlayerTeamTalk_GameObject()
    if (self.mOtherPlayerTeamTalk_GameObject == nil) then
        self.mOtherPlayerTeamTalk_GameObject = self:Get("teamtalkOtherPlayer", "GameObject");
    end
    return self.mOtherPlayerTeamTalk_GameObject;
end

function UICurrentTeamViewTemplate:GetTeamTalkArrow_GameObject()
    if (self.mTeamTalkArrow_GameObject == nil) then
        self.mTeamTalkArrow_GameObject = self:Get("teamtalk/Sprite", "GameObject");
    end
    return self.mTeamTalkArrow_GameObject;
end

function UICurrentTeamViewTemplate:GetTeamName_Text()
    if (self.mTeamName_Text == nil) then
        self.mTeamName_Text = self:Get("Background/name", "UILabel");
    end
    return self.mTeamName_Text;
end

function UICurrentTeamViewTemplate:GetTeamTalk_Text()
    if (self.mTeamTalk_Text == nil) then
        self.mTeamTalk_Text = self:Get("teamtalk/Label", "UILabel");
    end
    return self.mTeamTalk_Text;
end

function UICurrentTeamViewTemplate:GetPeopleCount_Text()
    if (self.mPeopleCount_Text == nil) then
        self.mPeopleCount_Text = self:Get("Background/member", "UILabel");
    end
    return self.mPeopleCount_Text;
end

function UICurrentTeamViewTemplate:GetOtherPlayerTeamTalk_Text()
    if (self.mOtherPlayerTeamTalk_Text == nil) then
        self.mOtherPlayerTeamTalk_Text = self:Get("teamtalkOtherPlayer/Label", "UILabel");
    end
    return self.mOtherPlayerTeamTalk_Text;
end

function UICurrentTeamViewTemplate:GetTeamTalk_UIInput()
    if (self.mTeamTalk_UIInput == nil) then
        self.mTeamTalk_UIInput = self:Get("teamtalk", "UIInput");
    end
    return self.mTeamTalk_UIInput;
end

function UICurrentTeamViewTemplate:GetTeamGridContainer()
    if (self.mTeamGridContainer == nil) then
        self.mTeamGridContainer = self:Get("TeamPanelFrame/TeamList", "UIGridContainer");
    end
    return self.mTeamGridContainer;
end

--endregion

--region Method

--region CallFunction

function UICurrentTeamViewTemplate:OnUIInputValueChanged()
    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
        networkRequest.ReqShareCommon(luaEnumReqServerCommonType.GROUP_MANIFESTO, nil, self:GetTeamTalk_UIInput().text, nil)
    else
        networkRequest.ReqCommon(luaEnumReqServerCommonType.GROUP_MANIFESTO, nil, self:GetTeamTalk_UIInput().text, nil)
    end

    CS.CSScene.MainPlayerInfo.GroupInfoV2:SetTeamTalk(self:GetTeamTalk_UIInput().text);
end

--endregion

--region Public

function UICurrentTeamViewTemplate:UpdateView()
    self:UpdateUI();
end

function UICurrentTeamViewTemplate:UpdateUI()

    self:UpdateTeamMember();

    self.mGroupData = CS.CSScene.MainPlayerInfo.GroupInfoV2.GroupInfo;

    local hasGroup = CS.CSScene.MainPlayerInfo.GroupInfoV2.IsHaveGroup;
    local isCaptain = CS.CSScene.MainPlayerInfo.GroupInfoV2.IsCaptain;
    self:GetTeamTalk_UIInput().gameObject:SetActive(hasGroup and isCaptain);
    self:GetOtherPlayerTeamTalk_GameObject().gameObject:SetActive(hasGroup and not isCaptain);
    self:GetTeamTalkArrow_GameObject():SetActive(isCaptain);
    if (hasGroup) then
        self:GetTeamName_Text().text = self.mGroupData.leader.roleName .. "的队伍";
        local maxPeopleCount = CS.Cfg_GlobalTableManager.Instance:GetMaxTeamPeople();
        self:GetPeopleCount_Text().text = self.mGroupData.size .. "/" .. maxPeopleCount;
        self:GetTeamTalk_Text().text = self.mGroupData.manifesto;
        self:GetOtherPlayerTeamTalk_Text().text = self.mGroupData.manifesto;
    end
end

function UICurrentTeamViewTemplate:UpdateTeamMember()
    if (self.mUnitDic == nil) then
        self.mUnitDic = {};
    end

    local gridContainer = self:GetTeamGridContainer();
    local teamPlayerList = CS.CSScene.MainPlayerInfo.GroupInfoV2:GetSortTeamPlayerInfo();
    if (teamPlayerList ~= nil) then
        gridContainer.MaxCount = teamPlayerList.Count;
        for i = 0, gridContainer.MaxCount - 1 do
            local gobj = gridContainer.controlList[i];
            local key = i + 1;
            if (self.mUnitDic[key] == nil) then
                ---@type UICurrentTeamUnitTemplate
                self.mUnitDic[key] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UICurrentTeamUnitTemplate);
            end
            self.mUnitDic[key]:UpdateUnit(teamPlayerList[i], i);
        end
    end
end

--endregion

--region Private

function UICurrentTeamViewTemplate:InitEvents()
    self.CallOnUIInputValueChanged = function()
        self:OnUIInputValueChanged();
    end
    CS.EventDelegate.Add(self:GetTeamTalk_UIInput().onChange, self.CallOnUIInputValueChanged);
end

function UICurrentTeamViewTemplate:RemoveEvents()

end

function UICurrentTeamViewTemplate:Clear()
    self.mUnitDic = nil;
    self.mTeamGridContainer = nil;
    self.mTeamTalk_UIInput = nil;
    self.mPeopleCount_Text = nil;
    self.mTeamTalk_Text = nil;
    self.mTeamName_Text = nil;
end

--region Private

--endregion

function UICurrentTeamViewTemplate:Init()
    self:InitEvents();
end

return UICurrentTeamViewTemplate;