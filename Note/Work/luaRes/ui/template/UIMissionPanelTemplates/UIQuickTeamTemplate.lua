---@class UIQuickTeamTemplate:TemplateBase
local UIQuickTeamTemplate = {}
UIQuickTeamTemplate.TeamList_UIGridContainer = nil
UIQuickTeamTemplate.ShortcutTeamList = {}
UIQuickTeamTemplate.TeamInfoList = nil
--UIQuickTeamTemplate.QuickTeamInfo = {
----    "附近队伍",
----    "创建队伍",
----}

--队伍列表
function UIQuickTeamTemplate:TeamList_UIGridContainer()
    if self.mTeamList == nil then
        self.mTeamList = CS.Utility_Lua.GetComponent(self.go, "UIGridContainer")
    end
    return self.mTeamList
end

---初始化
function UIQuickTeamTemplate:Init()
    if CS.CSScene.MainPlayerInfo then
        CS.CSScene.MainPlayerInfo.GroupInfoV2.TeamStart = 1
    end
    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
        networkRequest.ReqShareSetTeamMode(1);
    else
        networkRequest.ReqSetTeamMode(1);
    end

    UIQuickTeamTemplate.TeamList_UIGridContainer = CS.Utility_Lua.GetComponent(self.go, "UIGridContainer")
end

---刷新信息
function UIQuickTeamTemplate:RefreshTeamInfo()
    UIQuickTeamTemplate.TeamList_UIGridContainer.gameObject:SetActive(true)
    UIQuickTeamTemplate.OnResGroupDetailedInfoMessage()
    --if UIQuickTeamTemplate.TeamInfoList == nil then
    --    UIQuickTeamTemplate.TeamInformationSet(UIQuickTeamTemplate.QuickTeamInfo, false)
    --else
    --    if UIQuickTeamTemplate.TeamInfoList.Count == 0 then
    --        UIQuickTeamTemplate.TeamInformationSet(UIQuickTeamTemplate.QuickTeamInfo, false)
    --    end
    --end
    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
        networkRequest.ReqShareGroupDetailedInfo()
    else
        networkRequest.ReqGroupDetailedInfo()
    end
end

---队伍信息
function UIQuickTeamTemplate.TeamInformationSet(data, IsHaveTeam)


    --local IsCaptain = CS.CSScene.MainPlayerInfo.GroupInfoV2.IsCaptain
    --local GroupInfo = CS.CSScene.MainPlayerInfo.GroupInfoV2.GroupInfo
    --if IsHaveTeam then
    --    Count = data.Count
    --    if GroupInfo ~= nil then
    --        --if(IsCaptain) then
    --        --    Count = data.Count + 1
    --        --end
    --        UIQuickTeamTemplate.TeamList_UIGridContainer.MaxCount = Count
    --        local item = UIQuickTeamTemplate.TeamList_UIGridContainer.controlList[0]
    --        if(UIQuickTeamTemplate.ShortcutTeamList[item] == nil) then
    --            UIQuickTeamTemplate.ShortcutTeamList[item] = templatemanager.GetNewTemplate(item, luaComponentTemplates.UIShortcutTeamTemplates)
    --        end
    --        UIQuickTeamTemplate.ShortcutTeamList[item]:Refresh(GroupInfo.leader, IsHaveTeam)
    --        index = index + 1;
    --    end
    --
    --    --if IsCaptain then
    --    --    local item = UIQuickTeamTemplate.TeamList_UIGridContainer.controlList[Count - 1]
    --    --    local template = templatemanager.GetNewTemplate(item, luaComponentTemplates.UIShortcutTeamTemplates)
    --    --    template:Refresh("邀请玩家", IsHaveTeam)
    --    --end
    --
    ----else
    ----    Count = 2
    --end
    networkRequest.ReqMapCommon(1);
    local index = 0
    local Count = data.Count;
    UIQuickTeamTemplate.TeamList_UIGridContainer.MaxCount = Count
    for i = 0, Count - 1 do
        local v = data[i]
        --local IsConform = true
        --if GroupInfo ~= nil then
        --    IsConform = GroupInfo.leader.roleId ~= v.roleId
        --end
        --if IsConform then
        local item = UIQuickTeamTemplate.TeamList_UIGridContainer.controlList[index]
        ---@type UIShortcutTeamTemplates
        local template = UIQuickTeamTemplate.ShortcutTeamList[item]
        if template == nil then
            template = templatemanager.GetNewTemplate(item, luaComponentTemplates.UIShortcutTeamTemplates, self)
            UIQuickTeamTemplate.ShortcutTeamList[item] = template
        end
        template:Refresh(v, IsHaveTeam)
        index = index + 1;
        --end
    end
    --if IsCaptain then
    --    local item = UIQuickTeamTemplate.TeamList_UIGridContainer.controlList[Count - 1]
    --    local template = templatemanager.GetNewTemplate(item, luaComponentTemplates.UIShortcutTeamTemplates)
    --    template:Refresh("邀请玩家", IsHaveTeam)
    --end
end

---返回队伍信息
function UIQuickTeamTemplate.OnResGroupDetailedInfoMessage()
    UIQuickTeamTemplate.TeamInfoList = CS.CSScene.MainPlayerInfo.GroupInfoV2:GetSortTeamPlayerInfo();
    if UIQuickTeamTemplate.TeamInfoList.Count == 0 then
        --UIQuickTeamTemplate.TeamInformationSet(UIQuickTeamTemplate.QuickTeamInfo, false)
    else
        UIQuickTeamTemplate.TeamInformationSet(UIQuickTeamTemplate.TeamInfoList, true)
    end
end

---离开队伍消息
function UIQuickTeamTemplate.OnResLeaveTeamMessage()
    CS.CSScene.MainPlayerInfo.GroupInfoV2:QuitTeam()
    UIQuickTeamTemplate.OnResGroupDetailedInfoMessage()
end

function UIQuickTeamTemplate.CreatUITeamPanelCallBack()
end

function UIQuickTeamTemplate:OnDestroy()
    UIQuickTeamTemplate.TeamList_UIGridContainer = nil
    UIQuickTeamTemplate.ShortcutTeamList = {}
    UIQuickTeamTemplate.TeamInfoList = nil
    --if (CS.CSScene.MainPlayerInfo ~= nil) then
    --    CS.CSScene.MainPlayerInfo.GroupInfoV2:ClearCacheAll()
    --end
end
return UIQuickTeamTemplate