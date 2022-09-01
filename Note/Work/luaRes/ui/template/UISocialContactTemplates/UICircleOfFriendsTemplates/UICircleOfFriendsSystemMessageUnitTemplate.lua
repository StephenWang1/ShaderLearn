---@class UICircleOfFriendsSystemMessageUnitTemplate
local UICircleOfFriendsSystemMessageUnitTemplate = {};

UICircleOfFriendsSystemMessageUnitTemplate.mType = nil;

UICircleOfFriendsSystemMessageUnitTemplate.mIsSendToServer = false;

--region Components

function UICircleOfFriendsSystemMessageUnitTemplate:GetTypeDes_Text()
    if(self.mTypeDes_Text == nil) then
        self.mTypeDes_Text = self:Get("name", "UILabel");
    end
    return self.mTypeDes_Text;
end

function UICircleOfFriendsSystemMessageUnitTemplate:GetToggle_UIToggle()
    if(self.mToggle_UIToggle == nil) then
        self.mToggle_UIToggle = self:Get("toggle", "UIToggle");
    end
    return self.mToggle_UIToggle;
end

--endregion

--region Method

--region Public

function UICircleOfFriendsSystemMessageUnitTemplate:UpdateUnit(type)
    self.mType = type;
    self.mIsSendToServer = false;
    self:UpdateUI();
end

function UICircleOfFriendsSystemMessageUnitTemplate:UpdateUI()
    if(self.mType ~= nil) then
        local stringDes = CS.Cfg_FriendCircleRssTableManager.Instance:GetSystemMessageTypeDes(self.mType);
        self:GetTypeDes_Text().text = stringDes;
        self:GetToggle_UIToggle().value = CS.CSScene.MainPlayerInfo.FriendInfoV2:IsSubscribeMessageType(self.mType);
        self.mIsSendToServer = true;
    end
end

--endregion

--region Private

function UICircleOfFriendsSystemMessageUnitTemplate:InitEvents()
    CS.EventDelegate.Add(self:GetToggle_UIToggle().onChange, function()
        if not self:GetToggle_UIToggle().value then
            if(not CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendsSystemMessageTypeDisabledList:Contains(self.mType)) then
                CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendsSystemMessageTypeDisabledList:Add(self.mType);
            end
        else
            if(CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendsSystemMessageTypeDisabledList:Contains(self.mType)) then
                CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendsSystemMessageTypeDisabledList:Remove(self.mType);
            end
        end
        if(self.mIsSendToServer) then
            networkRequest.ReqFriendCircleSysMsgConfig(CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendsSystemMessageTypeDisabledList);
        end
    end)
end

function UICircleOfFriendsSystemMessageUnitTemplate:RemoveEvents()

end

--endregion

--endregion

function UICircleOfFriendsSystemMessageUnitTemplate:Init()
    self:InitEvents();
end

function UICircleOfFriendsSystemMessageUnitTemplate:RemoveEvents()
    self:RemoveEvents();
end

return UICircleOfFriendsSystemMessageUnitTemplate;