local UIJoinTeamViewTemplate = {};

UIJoinTeamViewTemplate.mMyTeamUnitDic = nil;
UIJoinTeamViewTemplate.mOtherTeamUnitDic = nil;
---当前的类型 1: 组队申请列表 2：组队邀请列表
UIJoinTeamViewTemplate.mCurShowType = nil;

--region Components

function UIJoinTeamViewTemplate:GetGridContainer()
    if (self.mGridContainer == nil) then
        self.mGridContainer = self:Get("player", "UIGridContainer");
    end
    return self.mGridContainer;
end

--endregion

--region Method

--region CallFunction

function UIJoinTeamViewTemplate:OnJoinTeamStateChange(msgId, msgData)
    if (msgData.roleId ~= nil and msgData.state ~= nil) then
        CS.CSScene.MainPlayerInfo.GroupInfoV2:OnApplyLisStateChange(msgData.roleId, msgData.state);
    end
    self:UpdateView();
end

--endregion

--region Public

function UIJoinTeamViewTemplate:UpdateView()

    local hasGroup = CS.CSScene.MainPlayerInfo.GroupInfoV2.IsHaveGroup;
    local isCaptain = CS.CSScene.MainPlayerInfo.GroupInfoV2.IsCaptain;

    if (hasGroup and isCaptain) then
        self:UpdateMyTeamReq()
    elseif (not hasGroup) then
        self:UpdateOtherTeamReq()
    end
    if (self:GetGridContainer().MaxCount <= 0) then
        uimanager:ClosePanel("UIJoinTeamPanel");
    end
end

function UIJoinTeamViewTemplate:UpdateMyTeamReq()
    self.mCurShowType = 1;
    if (self.mMyTeamUnitDic == nil) then
        self.mMyTeamUnitDic = {};
    end
    local applyList = CS.CSScene.MainPlayerInfo.GroupInfoV2.ApplyList;
    local gridContainer = self:GetGridContainer();
    if (applyList ~= nil) then
        gridContainer.MaxCount = applyList.Count;

        for i = 0, gridContainer.MaxCount - 1 do
            local gobj = gridContainer.controlList[i]
            local key = i + 1;
            if (self.mMyTeamUnitDic[gobj] == nil) then
                self.mMyTeamUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIJoinTeamUnitTemplate);
            end
            self.mMyTeamUnitDic[gobj]:UpdateUnit(applyList[i]);
        end
    end
end

function UIJoinTeamViewTemplate:UpdateOtherTeamReq()
    self.mCurShowType = 2;
    if (self.mOtherTeamUnitDic == nil) then
        self.mOtherTeamUnitDic = {};
    end
    local invitationPlayerList = CS.CSScene.MainPlayerInfo.GroupInfoV2.InvitationPlayerList;
    if (invitationPlayerList ~= nil) then
        local gridContainer = self:GetGridContainer();
        gridContainer.MaxCount = invitationPlayerList.Count;

        for i = 0, gridContainer.MaxCount - 1 do
            local gobj = gridContainer.controlList[i]
            local key = i + 1;
            if (self.mOtherTeamUnitDic[gobj] == nil) then
                self.mOtherTeamUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIJoinOtherTeamUnitTemplate);
            end
            self.mOtherTeamUnitDic[gobj]:UpdateUnit(invitationPlayerList[i]);
        end
    end
end

function UIJoinTeamViewTemplate:GetType()
    return self.mCurShowType;
end

--endregion

--region Private

function UIJoinTeamViewTemplate:InitEvents()
    self.CallOnJoinTeamStateChange = function(msgId, msgData)
        self:OnJoinTeamStateChange(msgId, msgData);
    end
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Team_OnJoinTeamStateChange, self.CallOnJoinTeamStateChange)
end

function UIJoinTeamViewTemplate:RemoveEvents()
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Team_OnJoinTeamStateChange, self.CallOnJoinTeamStateChange)
end

function UIJoinTeamViewTemplate:Clear()
    self.mUnitDic = nil;
    self.mGridContainer = nil;
end

--endregion

--endregion

---@param panel UIJoinTeamPanel
function UIJoinTeamViewTemplate:Init(panel)
    self.mOwnerPanel = panel
    self:InitEvents();
end

function UIJoinTeamViewTemplate:OnDestroy()
    self:RemoveEvents();
    self:Clear();
end

return UIJoinTeamViewTemplate;