local UITeamViewTemplate = {};

---@type table<number,UITeamUnitTemplate>
UITeamViewTemplate.mNearbyUnitDic = nil;

UITeamViewTemplate.mGuildUnitDic = nil;

--region 属性
---@return CSMainPlayerInfo
function UITeamViewTemplate:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSUnionInfoV2
function UITeamViewTemplate:GetUnionInfoV2()
    if self.unionInfoV2 == nil and self:GetMainPlayerInfo() then
        self.unionInfoV2 = self:GetMainPlayerInfo().UnionInfoV2
    end
    return self.unionInfoV2
end

--endregion

--region Components

function UITeamViewTemplate:GetNearbyGridContainer()
    if (self.mNearbyGridContainer == nil) then
        self.mNearbyGridContainer = self:Get("NearbyTeamPanelSurface/TeamRequestList", "UIGridContainer");
    end
    return self.mNearbyGridContainer;
end

function UITeamViewTemplate:GetGuildGridContainer()
    if (self.mGuildGridContainer == nil) then
        self.mGuildGridContainer = self:Get("GuildTeamPanelSurface/TeamRequestList", "UIGridContainer");
    end
    return self.mGuildGridContainer;
end

---@return UnityEngine.GameObject 无队伍标志
function UITeamViewTemplate:GetNoTeam_GameObject()
    if self.mNoTeamShow == nil then
        self.mNoTeamShow = self:Get("NoTeam", "GameObject");
    end
    return self.mNoTeamShow
end

--endregion

--region Method

--region CallFunction

function UITeamViewTemplate:OnResNearbyGroupMessage()
    self:UpdateNearbyGroup();
end

function UITeamViewTemplate:OnResGuildGroupMessage()
    self:UpdateGuildGroup();
end

--endregion

--region Public

function UITeamViewTemplate:UpdateView()
    self:ClearCurrentShow()
    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
        networkRequest.ReqShareNearbyGroup()
    else
        networkRequest.ReqNearbyGroup();
    end
end

function UITeamViewTemplate:ClearCurrentShow()
    self:GetNearbyGridContainer().MaxCount = 0
    self:GetNoTeam_GameObject():SetActive(true)
end

function UITeamViewTemplate:UpdateNearbyGroup()
    if (self.mNearbyUnitDic == nil) then
        self.mNearbyUnitDic = {};
    end

    local nearbyGroupList = CS.CSScene.MainPlayerInfo.GroupInfoV2:GetNearbyGroupList();

    local gridContainer = self:GetNearbyGridContainer();

    self:GetNoTeam_GameObject():SetActive(nearbyGroupList == nil or nearbyGroupList.Count == 0)

    if (nearbyGroupList ~= nil) then
        gridContainer.MaxCount = nearbyGroupList.Count;
        for i = 0, gridContainer.MaxCount - 1 do
            local gobj = gridContainer.controlList[i];
            local key = i + 1;
            if (self.mNearbyUnitDic[key] == nil) then
                self.mNearbyUnitDic[key] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UITeamUnitTemplate);
            end
            local mainPlayerUnionName
            if self:GetUnionInfoV2() then
                mainPlayerUnionName = self:GetUnionInfoV2().UnionName
            end
            self.mNearbyUnitDic[key]:UpdateUnit(nearbyGroupList[i], i, mainPlayerUnionName);
        end
    else
        gridContainer.MaxCount = 0
    end
end

function UITeamViewTemplate:UpdateGuildGroup()
    if (self.mGuildUnitDic == nil) then
        self.mGuildUnitDic = {};
    end

    local guildGroupList = CS.CSScene.MainPlayerInfo.GroupInfoV2:GetGuildGroupList();
    local gridContainer = self:GetGuildGridContainer();
    if (guildGroupList ~= nil) then
        gridContainer.MaxCount = guildGroupList.Count;
        for i = 0, gridContainer.MaxCount - 1 do
            local gobj = gridContainer.controlList[i];
            local key = i + 1;
            if (self.mGuildUnitDic[key] == nil) then
                self.mGuildUnitDic[key] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UITeamUnitTemplate);
            end
            self.mGuildUnitDic[key]:UpdateUnit(guildGroupList[i], i);
        end
    end
end

--endregion

--region Private

function UITeamViewTemplate:InitEvents()

    self.CallOnResNearbyGroupMessage = function(msgId, msgData)
        self:OnResNearbyGroupMessage();
    end
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResNearbyGroupMessage, self.CallOnResNearbyGroupMessage);
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResShareNearbyGroupMessage, self.CallOnResNearbyGroupMessage);
end

function UITeamViewTemplate:RemoveEvents()
    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResNearbyGroupMessage, self.CallOnResNearbyGroupMessage);
    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResShareNearbyGroupMessage, self.CallOnResNearbyGroupMessage);
end

function UITeamViewTemplate:Clear()
    self.mNearbyGridContainer = nil;
    self.mGuildGridContainer = nil;
    self.mNearbyUnitDic = nil;
end

--endregion

--endregion

---@param panel UITeamPanel
function UITeamViewTemplate:Init(panel)
    self.mOwnerPanel = panel
    self:InitEvents();
    self:OnResNearbyGroupMessage()
end

function UITeamViewTemplate:OnDestroy()
    self:RemoveEvents();
    self:Clear();
end

return UITeamViewTemplate;