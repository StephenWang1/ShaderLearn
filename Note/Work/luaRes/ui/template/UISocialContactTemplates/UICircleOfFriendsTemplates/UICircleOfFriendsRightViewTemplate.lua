---@class UICircleOfFriendsRightViewTemplate
local UICircleOfFriendsRightViewTemplate = {};

--region Components

function UICircleOfFriendsRightViewTemplate:GetBtnReturnCircle_GameObject()
    if (self.mBtnReturnCircle_GameObject == nil) then
        self.mBtnReturnCircle_GameObject = self:Get("ReturnCircle", "GameObject");
    end
    return self.mBtnReturnCircle_GameObject;
end

function UICircleOfFriendsRightViewTemplate:GetMyNewTip_GameObject()
    if (self.mMyNewTip_GameObject == nil) then
        self.mMyNewTip_GameObject = self:Get("ChatArea/ChatMessage", "GameObject");
    end
    return self.mMyNewTip_GameObject;
end

function UICircleOfFriendsRightViewTemplate:GetBtnMyNewTip_GameObject()
    if (self.mBtnMyNewTip_GameObject == nil) then
        self.mBtnMyNewTip_GameObject = self:Get("ChatArea/ChatMessage/Message/bg", "GameObject");
    end
    return self.mBtnMyNewTip_GameObject;
end

function UICircleOfFriendsRightViewTemplate:GetBtnNews_GameObject()
    if (self.mBtnNews_GameObject == nil) then
        self.mBtnNews_GameObject = self:Get("BtnMessage", "GameObject");
    end
    return self.mBtnNews_GameObject;
end

function UICircleOfFriendsRightViewTemplate:GetSystemMessageSetting_GameObject()
    if (self.mSystemMessageSetting_GameObject == nil) then
        self.mBtnSystemMessageSetting_GameObject = self:Get("BtnSystemMessage", "GameObject");
    end
    return self.mBtnSystemMessageSetting_GameObject;
end

function UICircleOfFriendsRightViewTemplate:GetCircleOfFriendParent_GameObject()
    if (self.mCircleOfFriendParent_GameObject == nil) then
        self.mCircleOfFriendParent_GameObject = self:Get("ChatArea/CircleOfFriendParent", "GameObject");
    end
    return self.mCircleOfFriendParent_GameObject;
end

function UICircleOfFriendsRightViewTemplate:GetChatMessageViewParent_GameObject()
    if (self.mChatMessageViewParent_GameObject == nil) then
        self.mChatMessageViewParent_GameObject = self:Get("ChatArea/ChatMessageViewParent", "GameObject");
    end
    return self.mChatMessageViewParent_GameObject;
end

function UICircleOfFriendsRightViewTemplate:GetChatMessage_UISprite()
    if (self.mChatMessage_UISprite == nil) then
        self.mChatMessage_UISprite = self:Get("BtnMessage", "UISprite");
    end
    return self.mChatMessage_UISprite;
end

function UICircleOfFriendsRightViewTemplate:GetCircleOfFriendsViewComponent()
    if (self.mCircleOfFriendsViewComponent == nil) then
        self.mCircleOfFriendsViewComponent = self:Get("ChatArea/CircleOfFriendParent/Chat Area/Grild", "CircleOfFriendsViewComponent");
    end
    return self.mCircleOfFriendsViewComponent;
end

function UICircleOfFriendsRightViewTemplate:GetMyNesCircleOfFriendsViewComponent()
    if (self.mMyNesCircleOfFriendsViewComponent == nil) then
        self.mMyNesCircleOfFriendsViewComponent = self:Get("ChatArea/ChatMessageViewParent/ChatMessageView/parent", "CircleOfMyNewsViewComponent");
    end
    return self.mMyNesCircleOfFriendsViewComponent;
end

function UICircleOfFriendsRightViewTemplate:GetCircleOfFriendsOwner_Text()
    if (self.mCircleOfFriendsOwner_Text == nil) then
        self.mCircleOfFriendsOwner_Text = self:Get("Text1", "UILabel")
    end
    return self.mCircleOfFriendsOwner_Text;
end

function UICircleOfFriendsRightViewTemplate:GetSystemMessageViewTemplate()
    if (self.mSystemMessageViewTemplate == nil) then
        self.mSystemMessageViewTemplate = templatemanager.GetNewTemplate(self:Get("SystemMessageSettingPanel", "GameObject"), luaComponentTemplates.UICircleOfFriendsSystemMessageViewTemplate);
    end
    return self.mSystemMessageViewTemplate;
end

function UICircleOfFriendsRightViewTemplate:GetDragScrollView1_GameObject()
    if (self.mDragScrollView1_GameObject == nil) then
        self.mDragScrollView1_GameObject = self:Get("ChatArea/UIDragScrollView1", "GameObject");
    end
    return self.mDragScrollView1_GameObject;
end

function UICircleOfFriendsRightViewTemplate:GetDragScrollView2_GameObject()
    if (self.mDragScrollView2_GameObject == nil) then
        self.mDragScrollView2_GameObject = self:Get("ChatArea/UIDragScrollView2", "GameObject");
    end
    return self.mDragScrollView2_GameObject;
end

function UICircleOfFriendsRightViewTemplate:GetCurrentCircleOfFriendType()
    return CS.CSScene.MainPlayerInfo.FriendInfoV2.CurrentCircleOfFriendType;
end

--endregion

--region Method

function UICircleOfFriendsRightViewTemplate:OnCircleOfFriendsTypeChanged(type)
    self:GetCircleOfFriendParent_GameObject():SetActive(true);
    self:GetChatMessageViewParent_GameObject():SetActive(false);
    self:GetDragScrollView1_GameObject():SetActive(true);
    self:GetDragScrollView2_GameObject():SetActive(false);
    if (type == CS.CircleOfFriendType.MyCircles) then
        if (CS.CSScene.MainPlayerInfo ~= nil) then
            self:UpdateView(CS.CSServerTime.Instance.TotalMillisecond, CS.CSScene.MainPlayerInfo.ID, type);
        end
    elseif (type == CS.CircleOfFriendType.AllCircles) then
        if (CS.CSScene.MainPlayerInfo ~= nil) then
            self:UpdateView(CS.CSServerTime.Instance.TotalMillisecond, CS.CSScene.MainPlayerInfo.ID, type);
        end
    elseif (type == CS.CircleOfFriendType.MyCircles_MyNews) then
        self:GetCircleOfFriendParent_GameObject():SetActive(false);
        self:GetChatMessageViewParent_GameObject():SetActive(true);
        self:GetDragScrollView1_GameObject():SetActive(false);
        self:GetDragScrollView2_GameObject():SetActive(true);
        if (CS.CSScene.MainPlayerInfo ~= nil) then
            self:UpdateView(CS.CSServerTime.Instance.TotalMillisecond, CS.CSScene.MainPlayerInfo.ID, type);
        end
    elseif (type == CS.CircleOfFriendType.SystemCircles) then
        if (CS.CSScene.MainPlayerInfo ~= nil) then
            self:UpdateView(CS.CSServerTime.Instance.TotalMillisecond, CS.CSScene.MainPlayerInfo.ID, type);
        end
    end
end

--region Public

function UICircleOfFriendsRightViewTemplate:UpdateView(timeStamp, ownerId, type)
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        CS.CSScene.MainPlayerInfo.FriendInfoV2:SetCurrentCircleOfFriendsType(type);
        local friend = CS.CSScene.MainPlayerInfo.FriendInfoV2:GetFriend(ownerId);
        if (friend ~= nil) then
            self:GetCircleOfFriendsViewComponent():UpdateOwner(ownerId);
            CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendsOwner = friend;
        end
        local typeNumber = CS.CSFriendInfoV2.GetCircleOfFriendsToServerType(type);
        networkRequest.ReqGetFriendCircle(timeStamp, ownerId, typeNumber);
    end
    self:UpdateOwnerString();
    self:UpdateMyNewsTip();
end

function UICircleOfFriendsRightViewTemplate:UpdateMyNewsTip()
    local owner = CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendsOwner;
    local hasUnRead = CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendUnReadCount > 0 and owner.rid == CS.CSScene.MainPlayerInfo.ID;
    self:GetMyNewTip_GameObject():SetActive(hasUnRead);
    self:GetCircleOfFriendParent_GameObject().transform.localPosition = hasUnRead and CS.UnityEngine.Vector3(222, 193, 0) or CS.UnityEngine.Vector3(222, 244, 0);
    self:GetChatMessageViewParent_GameObject().transform.localPosition = hasUnRead and CS.UnityEngine.Vector3(222, 193, 0) or CS.UnityEngine.Vector3(222, 244, 0);
end

function UICircleOfFriendsRightViewTemplate:UpdateBtnShow()
    local owner = CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendsOwner;
    local spriteName1 = "FriendCircle_return";
    local spriteName2 = "FriendCircle_myState";
    local spriteName = (self:GetCurrentCircleOfFriendType() == CS.CircleOfFriendType.MyCircles) and spriteName1 or spriteName2;
    if (owner ~= nil) then
        if (owner.rid == CS.CSScene.MainPlayerInfo.ID) then
            self:GetChatMessage_UISprite().spriteName = spriteName;
            self:GetBtnReturnCircle_GameObject():SetActive(self:GetCurrentCircleOfFriendType() == CS.CircleOfFriendType.MyCircles_MyNews);
            self:GetBtnNews_GameObject():SetActive(self:GetCurrentCircleOfFriendType() == CS.CircleOfFriendType.MyCircles);
            self:GetSystemMessageSetting_GameObject():SetActive(self:GetCurrentCircleOfFriendType() == CS.CircleOfFriendType.SystemCircles);
        else
            self:GetChatMessage_UISprite().spriteName = spriteName1;
            self:GetBtnNews_GameObject():SetActive(false);
            self:GetSystemMessageSetting_GameObject():SetActive(false);
            self:GetBtnReturnCircle_GameObject():SetActive(false);
        end
    else
        self:GetChatMessage_UISprite().spriteName = spriteName;
        self:GetBtnReturnCircle_GameObject():SetActive(self:GetCurrentCircleOfFriendType() == CS.CircleOfFriendType.MyCircles_MyNews);
        self:GetBtnNews_GameObject():SetActive(self:GetCurrentCircleOfFriendType() == CS.CircleOfFriendType.MyCircles);
        self:GetSystemMessageSetting_GameObject():SetActive(self:GetCurrentCircleOfFriendType() == CS.CircleOfFriendType.SystemCircles);
    end
end

function UICircleOfFriendsRightViewTemplate:UpdateOwnerString()
    --local otherName = CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendsOwner.remark == "" and CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendsOwner.name or CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendsOwner.remark;
    local otherName = CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendsOwner.name;
    local isMine = CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendsOwner.rid == CS.CSScene.MainPlayerInfo.ID;
    local ownerStr = isMine and "全部动态" or otherName .. "的动态";
    if (isMine) then
        if (self:GetCurrentCircleOfFriendType() == CS.CircleOfFriendType.AllCircles) then
            self:GetCircleOfFriendsOwner_Text().text = ownerStr;
        elseif (self:GetCurrentCircleOfFriendType() == CS.CircleOfFriendType.MyCircles) then
            self:GetCircleOfFriendsOwner_Text().text = "我的动态";
        elseif (self:GetCurrentCircleOfFriendType() == CS.CircleOfFriendType.SystemCircles) then
            self:GetCircleOfFriendsOwner_Text().text = "系统订阅";
        elseif (self:GetCurrentCircleOfFriendType() == CS.CircleOfFriendType.MyCircles_MyNews) then
            self:GetCircleOfFriendsOwner_Text().text = "";
        end
    else
        self:GetCircleOfFriendsOwner_Text().text = ownerStr;
    end

    self:UpdateBtnShow();
    self:UpdateMyNewsTip();
end

function UICircleOfFriendsRightViewTemplate:SelectFriendFirstCircleOfFriends(circleOfFriendsId)
    self:GetCircleOfFriendsViewComponent():SelectOneCircleOfFriends(circleOfFriendsId);
end

function UICircleOfFriendsRightViewTemplate:UpdateSingleCircleOfFriends(single)
    if (single ~= nil) then
        self:GetCircleOfFriendsViewComponent():UpdateCircleOfFriends(single, CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendsOwner.rid);
    end
end

function UICircleOfFriendsRightViewTemplate:Clear()
    self:GetCircleOfFriendsViewComponent():Clear();
end

--endregion

--region Private

function UICircleOfFriendsRightViewTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetBtnNews_GameObject()).onClick = function()
        luaEventManager.DoCallback(LuaCEvent.Friend_OnCircleOfFriendsTypeChanged, CS.CircleOfFriendType.MyCircles_MyNews);
    end

    CS.UIEventListener.Get(self:GetBtnReturnCircle_GameObject()).onClick = function()
        luaEventManager.DoCallback(LuaCEvent.Friend_OnCircleOfFriendsTypeChanged, CS.CircleOfFriendType.MyCircles);
    end

    CS.UIEventListener.Get(self:GetSystemMessageSetting_GameObject()).onClick = function()
        self:GetSystemMessageViewTemplate():UpdateView();
    end

    CS.UIEventListener.Get(self:GetBtnMyNewTip_GameObject()).onClick = function()
        CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendUnReadCount = 0;
        self:UpdateMyNewsTip();
        luaEventManager.DoCallback(LuaCEvent.Friend_OnCircleOfFriendsTypeChanged, CS.CircleOfFriendType.MyCircles_MyNews);
    end

    self.CallOnCircleOfFriendsTypeChanged = function(msgId, msgData)
        self:OnCircleOfFriendsTypeChanged(msgData);
    end
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Friend_OnCircleOfFriendsTypeChanged, self.CallOnCircleOfFriendsTypeChanged);

    self.CallOnResFriendCircleUpdatedMessage = function()
        self:UpdateMyNewsTip();
    end
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResFriendCircleUpdatedMessage, self.CallOnResFriendCircleUpdatedMessage);
end

function UICircleOfFriendsRightViewTemplate:RemoveEvents()
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Friend_OnCircleOfFriendsTypeChanged, self.CallOnCircleOfFriendsTypeChanged);
    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResFriendCircleUpdatedMessage, self.CallOnResFriendCircleUpdatedMessage);
end

--endregion

--endregion

---@param panel UIBase
function UICircleOfFriendsRightViewTemplate:Init(panel)
    self.mOwnerPanel = panel
    self:InitEvents();
end

function UICircleOfFriendsRightViewTemplate:OnDestroy()
    self:RemoveEvents();
end

return UICircleOfFriendsRightViewTemplate