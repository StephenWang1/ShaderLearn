---@class UICircleOfFriendsSystemMessageViewTemplate
local UICircleOfFriendsSystemMessageViewTemplate = {};

UICircleOfFriendsSystemMessageViewTemplate.mUnitDic = nil;

--region Components

function UICircleOfFriendsSystemMessageViewTemplate:GetBackGround_GameObject()
    if(self.mBackGround_GameObject == nil) then
        self.mBackGround_GameObject = self:Get("backGround","GameObject");
    end
    return self.mBackGround_GameObject;
end

function UICircleOfFriendsSystemMessageViewTemplate:GetGridContainer()
    if(self.mGridContainer == nil) then
        self.mGridContainer = self:Get("gridContainer", "UIGridContainer");
    end
    return self.mGridContainer;
end

--endregion

--region Method

--region Public

function UICircleOfFriendsSystemMessageViewTemplate:UpdateView()
    self.go:SetActive(true);
    self:UpdateUI();
end

function UICircleOfFriendsSystemMessageViewTemplate:UpdateUI()
    if(self.mUnitDic == nil) then
        self.mUnitDic = {};
    end

    local gridContainer = self:GetGridContainer();
    local typeList = CS.Cfg_FriendCircleRssTableManager.Instance:GetAllSystemMessageType();
    if(typeList ~= nil and typeList.Count > 0) then
        gridContainer.MaxCount = typeList.Count;
        for i = 0, gridContainer.MaxCount - 1 do
            local gobj = gridContainer.controlList[i];
            if(self.mUnitDic[gobj] == nil) then
                self.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UICircleOfFriendsSystemMessageUnitTemplate);
            end
            self.mUnitDic[gobj]:UpdateUnit(typeList[i]);
        end
    else
        gridContainer.MaxCount = 0;
    end
end

--endregion

--region Private

function UICircleOfFriendsSystemMessageViewTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetBackGround_GameObject()).onClick = function()
        if(not CS.StaticUtility.IsNull(self.go)) then
            self.go:SetActive(false);
        end
    end
end

function UICircleOfFriendsSystemMessageViewTemplate:RemoveEvents()

end

--endregion

--endregion

function UICircleOfFriendsSystemMessageViewTemplate:Init()
    self:InitEvents();
end

function UICircleOfFriendsSystemMessageViewTemplate:OnDestroy()
    self:RemoveEvents();
end

return UICircleOfFriendsSystemMessageViewTemplate;