local UICircleOfFriendsLeftViewTemplate = {};

UICircleOfFriendsLeftViewTemplate.mUnitDic = nil;

--region Components

--function UICircleOfFriendsLeftViewTemplate:GetGridContainer_UIContainer()
--    if(self.mGridContainer == nil) then
--        self.mGridContainer = self:Get("Scroll View/player","UIGridContainer");
--    end
--    return self.mGridContainer;
--end

function UICircleOfFriendsLeftViewTemplate:GetTglAllCircle_UIToggle()
    if (self.mTglAllCircle_UIToggle == nil) then
        self.mTglAllCircle_UIToggle = self:Get("tglGroup/tgl_allCircle", "UIToggle");
    end
    return self.mTglAllCircle_UIToggle;
end

function UICircleOfFriendsLeftViewTemplate:GetTglMyCircle_UIToggle()
    if (self.mTglMyCircle_UIToggle == nil) then
        self.mTglMyCircle_UIToggle = self:Get("tglGroup/tgl_myCircle", "UIToggle");
    end
    return self.mTglMyCircle_UIToggle;
end

function UICircleOfFriendsLeftViewTemplate:GetTglSystemCircle_UIToggle()
    if (self.mTglSystemCircle_UIToggle == nil) then
        self.mTglSystemCircle_UIToggle = self:Get("tglGroup/tgl_systemCircle", "UIToggle");
    end
    return self.mTglSystemCircle_UIToggle;
end

--endregion

--region Method

--region Public

function UICircleOfFriendsLeftViewTemplate:UpdateView()
    self:Select(CS.CircleOfFriendType.AllCircles);
end

function UICircleOfFriendsLeftViewTemplate:Select(type)
    if (type == CS.CircleOfFriendType.AllCircles) then
        self:GetTglAllCircle_UIToggle().value = true;
    elseif (type == CS.CircleOfFriendType.MyCircles) then
        self:GetTglMyCircle_UIToggle().value = true;
    elseif (type == CS.CircleOfFriendType.SystemCircles) then
        self:GetTglSystemCircle_UIToggle().value = true;
    end
    luaEventManager.DoCallback(LuaCEvent.Friend_OnCircleOfFriendsTypeChanged, type);
end

--function UICircleOfFriendsLeftViewTemplate:UpdateFriendCircleUpdated()
--    if(self.mUnitDic == nil) then
--        self.mUnitDic = {};
--    end
--
--    local list = self:GetFriendCircleUpdateList();
--    if(list ~= nil) then
--        local gridContainer = self:GetGridContainer_UIContainer();
--        gridContainer.MaxCount = #list;
--        local index = 0;
--        for k,v in pairs(list) do
--            local gobj = gridContainer.controlList[index];
--            if(self.mUnitDic[gobj] == nil) then
--                self.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UICircleOfFriendsLeftUnitTemplate);
--            end
--            self.mUnitDic[gobj]:UpdateUnit(v, index);
--            index = index + 1;
--        end
--    end
--end

--endregion

--region Private

--function UICircleOfFriendsLeftViewTemplate:GetFriendCircleUpdateList()
--    local list = {};
--    if(CS.CSScene.MainPlayerInfo.FriendInfoV2.FriendCircleUpdateDic ~= nil and CS.CSScene.MainPlayerInfo.FriendInfoV2.FriendCircleUpdateDic.Count > 0) then
--        for k,v in pairs(CS.CSScene.MainPlayerInfo.FriendInfoV2.FriendCircleUpdateDic) do
--            local rid = v.updateRoleId;
--            local friendInfo = CS.CSScene.MainPlayerInfo.FriendInfoV2:GetFriend(rid);
--            if(friendInfo ~= nil) then
--                table.insert(list, friendInfo);
--            end
--        end
--    end
--    local Sort = function(a,b)
--        return a.relation > b.relation;
--    end
--    table.sort(list, Sort);
--    return list;
--end

function UICircleOfFriendsLeftViewTemplate:Clear()
    self.mGridContainer = nil;
    self.mUnitDic = nil;
end

function UICircleOfFriendsLeftViewTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetTglAllCircle_UIToggle().gameObject).onClick = function()
        self:Select(CS.CircleOfFriendType.AllCircles);
    end

    CS.UIEventListener.Get(self:GetTglMyCircle_UIToggle().gameObject).onClick = function()
        self:Select(CS.CircleOfFriendType.MyCircles);
    end

    CS.UIEventListener.Get(self:GetTglSystemCircle_UIToggle().gameObject).onClick = function()
        self:Select(CS.CircleOfFriendType.SystemCircles);
    end

    self.OnCircleOfFriendsTypeChanged = function(msgId, msgData)
        if (msgData == CS.CircleOfFriendType.MyCircles_MyNews) then
            self:GetTglMyCircle_UIToggle().isChecked = true;
        end
    end
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Friend_OnCircleOfFriendsTypeChanged, self.OnCircleOfFriendsTypeChanged)
end

function UICircleOfFriendsLeftViewTemplate:RemoveEvents()
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Friend_OnCircleOfFriendsTypeChanged, self.OnCircleOfFriendsTypeChanged);
end

--endregion

--endregion

---@param panel UISocialContactPanel
function UICircleOfFriendsLeftViewTemplate:Init(panel)
    self.mOwnerPanel = panel
    self:InitEvents();
    self:GetTglAllCircle_UIToggle().value = true;
end

function UICircleOfFriendsLeftViewTemplate:OnDestroy()
    self:RemoveEvents();
end

return UICircleOfFriendsLeftViewTemplate;