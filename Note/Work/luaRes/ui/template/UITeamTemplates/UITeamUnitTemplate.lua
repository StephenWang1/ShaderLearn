---@class UITeamUnitTemplate 队伍详细信息模板
local UITeamUnitTemplate = {};

UITeamUnitTemplate.mGroupData = nil;

--region Components

function UITeamUnitTemplate:GetBtnJoin_GameObject()
    if (self.mBtnJoin_GameObject == nil) then
        self.mBtnJoin_GameObject = self:Get("btn", "GameObject");
    end
    return self.mBtnJoin_GameObject;
end

function UITeamUnitTemplate:GetBackGround_GameObject()
    if (self.mBackGround_GameObject == nil) then
        self.mBackGround_GameObject = self:Get("bg", "GameObject");
    end
    return self.mBackGround_GameObject;
end

function UITeamUnitTemplate:GetTeamName_Text()
    if (self.mTeamName_Text == nil) then
        self.mTeamName_Text = self:Get("lb_name", "UILabel");
    end
    return self.mTeamName_Text;
end

function UITeamUnitTemplate:GetTeamTalk_Text()
    if (self.mTeamTalk_Text == nil) then
        self.mTeamTalk_Text = self:Get("lb_teamtalk", "UILabel");
    end
    return self.mTeamTalk_Text;
end

function UITeamUnitTemplate:GetPeopleCount_Text()
    if (self.mPeopleCount_Text == nil) then
        self.mPeopleCount_Text = self:Get("lb_people", "UILabel");
    end
    return self.mPeopleCount_Text;
end

--endregion

--region Method

--region Public
---刷新队伍信息
function UITeamUnitTemplate:UpdateUnit(groupData, index, mainPlayerUnionName)
    ---@type groupV2.GroupInfo
    self.mGroupData = groupData;
    self:GetBackGround_GameObject():SetActive(index % 2 == 0);
    self:UpdateShowText(mainPlayerUnionName);
end

function UITeamUnitTemplate:UpdateShowText(mainPlayerUnionName)
    if (self.mGroupData ~= nil) then
        local showName = self.mGroupData.leader.roleName
        if mainPlayerUnionName ~= nil and mainPlayerUnionName ~= "" and mainPlayerUnionName == self.mGroupData.leader.unionName then
            showName = showName .. "(同行会)"
        end
        self:GetTeamName_Text().text = showName;
        local maxPeopleCount = CS.Cfg_GlobalTableManager.Instance:GetMaxTeamPeople();
        self:GetPeopleCount_Text().text = self.mGroupData.size .. "/" .. maxPeopleCount;
        self:GetTeamTalk_Text().text = self.mGroupData.manifesto
    end
end

--endregion

--region Private

function UITeamUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetBtnJoin_GameObject()).onClick = function()
        if (self.mGroupData ~= nil) then
            if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                networkRequest.ReqShareJoinGroup(self.mGroupData.id, 2);
            else
                networkRequest.ReqJoinGroup(self.mGroupData.id, 2)
            end
        end
    end
end

function UITeamUnitTemplate:RemoveEvents()

end

function UITeamUnitTemplate:Clear()
    self.mGroupData = nil;
    self.mPeopleCount_Text = nil;
    self.mTeamTalk_Text = nil;
    self.mTeamName_Text = nil;
    self.mBackGround_GameObject = nil;
    self.mBtnJoin_GameObject = nil;
end

--endregion

--endregion

function UITeamUnitTemplate:Init()
    self:InitEvents();
end

function UITeamUnitTemplate:OnDestroy()
    self:RemoveEvents();
    self:Clear();
end

return UITeamUnitTemplate;