---@class UICircleOfFriendsViewTemplate:TemplateBase
local UICircleOfFriendsViewTemplate = {};

UICircleOfFriendsViewTemplate.mCustomData = nil;

UICircleOfFriendsViewTemplate.mCircleOfFriendType = nil;
--region Components

--region GameObject

function UICircleOfFriendsViewTemplate:GetPublishCircle_GameObject()
    if (self.mPublishCircle_GameObject == nil) then
        self.mPublishCircle_GameObject = self:Get("bgleft/btn_publish", "GameObject");
    end
    return self.mPublishCircle_GameObject;
end

function UICircleOfFriendsViewTemplate:GetBtnReturnMyFriendCircle_GameObject()
    if (self.mBtnReturnMyFriendCircle_GameObject == nil) then
        self.mBtnReturnMyFriendCircle_GameObject = self:Get("bgleft/btn_return", "GameObject");
    end
    return self.mBtnReturnMyFriendCircle_GameObject;
end

function UICircleOfFriendsViewTemplate:GetCircleOfFriendsLeftViewTemplate_GameObject()
    if (self.mCircleOfFriendsLeftViewTemplate_GameObject == nil) then
        self.mCircleOfFriendsLeftViewTemplate_GameObject = self:Get("bgleft", "GameObject");
    end
    return self.mCircleOfFriendsLeftViewTemplate_GameObject;
end

function UICircleOfFriendsViewTemplate:GetCircleOfFriendsRightViewTemplate_GameObject()
    if (self.mCircleOfFriendsRightViewTemplate_GameObject == nil) then
        self.mCircleOfFriendsRightViewTemplate_GameObject = self:Get("bgright", "GameObject");
    end
    return self.mCircleOfFriendsRightViewTemplate_GameObject;
end

function UICircleOfFriendsViewTemplate:GetCircleOfFriendsOwner_Text()
    if (self.mCircleOfFriendsOwner_Text == nil) then
        self.mCircleOfFriendsOwner_Text = self:Get("bgright/Text1", "UILabel")
    end
    return self.mCircleOfFriendsOwner_Text;
end

function UICircleOfFriendsViewTemplate:GetClientEventHandler()
    return CS.CSGame.Sington.EventHandler;
end

--endregion

---左侧朋友动态列表模板
function UICircleOfFriendsViewTemplate:GetCircleOfFriendsLeftViewTemplate()
    if (self.mCircleOfFriendsLeftViewTemplate == nil) then
        self.mCircleOfFriendsLeftViewTemplate = templatemanager.GetNewTemplate(self:GetCircleOfFriendsLeftViewTemplate_GameObject(), luaComponentTemplates.UICircleOfFriendsLeftViewTemplate, self.mOwnerPanel);
    end
    return self.mCircleOfFriendsLeftViewTemplate;
end

---右侧朋友圈内容模板
function UICircleOfFriendsViewTemplate:GetCircleOfFriendsRightViewTemplate()
    if (self.mCircleOfFriendsRightViewTemplate == nil) then
        self.mCircleOfFriendsRightViewTemplate = templatemanager.GetNewTemplate(self:GetCircleOfFriendsRightViewTemplate_GameObject(), luaComponentTemplates.UICircleOfFriendsRightViewTemplate, self.mOwnerPanel);
    end
    return self.mCircleOfFriendsRightViewTemplate;
end

--endregion

--region Method

--region CallFunction

function UICircleOfFriendsViewTemplate:OnFriendCircleCommentClicked(msgData)
    local customData = {};
    customData.postId = msgData.post.id;
    customData.replyId = msgData.post.id;
    customData.targetName = msgData.post.roleInfo.name;
    customData.isReply = true;
    uimanager:CreatePanel("UIFriendCircleCommentPanel", nil, customData);
end

function UICircleOfFriendsViewTemplate:OnCommentClicked(mainId, replyTo, targetName)
    local customData = {};
    customData.postId = mainId;
    customData.replyId = replyTo;
    customData.targetName = targetName;
    customData.isReply = false;
    uimanager:CreatePanel("UIFriendCircleCommentPanel", nil, customData);
end

function UICircleOfFriendsViewTemplate:OnFriendCircleUpdated(msgData)
    if (self.go ~= nil and not CS.StaticUtility.IsNull(self.go)) then
        if (CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendsOwner ~= nil and CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendsOwner.rid == CS.CSScene.MainPlayerInfo.ID) then
            if (self.mCircleOfFriendType ~= nil) then
                local typeNumber = CS.CSFriendInfoV2.GetCircleOfFriendsToServerType(self.mCircleOfFriendType);
                networkRequest.ReqGetFriendCircle(msgData.updateTime, CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendsOwner.rid, typeNumber);
            end
        end
        --self:GetCircleOfFriendsLeftViewTemplate():UpdateFriendCircleUpdated();
    end
end

function UICircleOfFriendsViewTemplate:OnCircleOfFriendsUpdateTipsClick(friendInfo)
    if (friendInfo ~= nil) then
        local isFind, friendUpdatedVo = CS.CSScene.MainPlayerInfo.FriendInfoV2.FriendCircleUpdateDic:TryGetValue(friendInfo.rid)
        if (isFind) then
            local customData = {};
            customData.targetId = friendInfo.rid;
            customData.targetTime = friendUpdatedVo.updateTime;
            CS.CSScene.MainPlayerInfo.FriendInfoV2:RemoveFriendCircleUpdated(friendInfo.rid);
            self:UpdateView(customData);
        end
    end
end

--function UICircleOfFriendsViewTemplate:OnCircleOfFriendsOwnerChanged()
--    self:UpdateOwner();
--end

--endregion

--region Public

function UICircleOfFriendsViewTemplate:UpdateView(customData)
    if (customData == nil) then
        customData = {};
    end

    if (customData.targetId == nil) then
        customData.targetId = CS.CSScene.MainPlayerInfo.ID;
    end

    if (customData.targetTime == nil) then
        customData.targetTime = CS.CSServerTime.Instance.TotalMillisecond;
    end
    self.mCustomData = customData;
    self:GetCircleOfFriendsLeftViewTemplate():UpdateView();
    self:GetCircleOfFriendsRightViewTemplate():UpdateView(self.mCustomData.targetTime, self.mCustomData.targetId, CS.CircleOfFriendType.AllCircles);
    self.mCircleOfFriendType = CS.CircleOfFriendType.AllCircles;
    self:UpdateBtnShow();
end

function UICircleOfFriendsViewTemplate:UpdateBtnShow()
    local ownerId = CS.CSScene.MainPlayerInfo.ID;
    if (CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendsOwner ~= nil) then
        ownerId = CS.CSScene.MainPlayerInfo.FriendInfoV2.CircleOfFriendsOwner.rid;
    end
    self:GetPublishCircle_GameObject():SetActive(ownerId == CS.CSScene.MainPlayerInfo.ID);
    --self:GetBtnReturnMyFriendCircle_GameObject():SetActive(ownerId ~= CS.CSScene.MainPlayerInfo.ID);
    self:GetBtnReturnMyFriendCircle_GameObject():SetActive(false);
end

---刷新单条朋友圈
function UICircleOfFriendsViewTemplate:UpdateSingleCircleOfFriends(single)
    self:GetCircleOfFriendsRightViewTemplate():UpdateSingleCircleOfFriends(single);
end

function UICircleOfFriendsViewTemplate:HideView()

end

--endregion

--region Private

function UICircleOfFriendsViewTemplate:InitEvents()

    CS.UIEventListener.Get(self:GetPublishCircle_GameObject()).onClick = function()
        uimanager:CreatePanel("UIFriendCirclePublishPanel");
    end

    CS.UIEventListener.Get(self:GetBtnReturnMyFriendCircle_GameObject()).onClick = function()
        self:GetCircleOfFriendsRightViewTemplate():UpdateView(CS.CSServerTime.Instance.TotalMillisecond, CS.CSScene.MainPlayerInfo.ID, 0);
        networkRequest.ReqGetFriendCircle(CS.CSServerTime.Instance.TotalMillisecond, CS.CSScene.MainPlayerInfo.ID, 0);
    end
    --self.CallOnCircleOfFriendsOwnerChanged = function(msgId, msgData)
    --    self:OnCircleOfFriendsOwnerChanged();
    --end
    --self:GetClientEventHandler():AddEvent(CS.CEvent.V2_Friend_OnCircleOfFriendsOwnerChanged, self.CallOnCircleOfFriendsOwnerChanged);

    self.CallOnResSingleFriendCirleMessage = function(msgId, msgData)
        self:UpdateSingleCircleOfFriends(msgData);
    end
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_Friend_UpdateSingleCircleOfFriends, self.CallOnResSingleFriendCirleMessage);

    self.CallOnFriendCircleCommentClicked = function(msgId, msgData)
        self:OnFriendCircleCommentClicked(msgData)
    end
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_Friend_OnFriendCircleCommentClicked, self.CallOnFriendCircleCommentClicked);

    self.CallOnCommentClicked = function(msgId, mainId, replyTo, targetName)
        self:OnCommentClicked(mainId, replyTo, targetName);
    end
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_Friend_OnCommentClicked, self.CallOnCommentClicked);

    self.CallOnFriendCircleUpdated = function(msgId, msgData)
        self:OnFriendCircleUpdated(msgData);
    end
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_Friend_OnFriendCircleUpdated, self.CallOnFriendCircleUpdated);

    self.CallOnCircleOfFriendsUpdateTipsClick = function(msgId, msgData)
        self:OnCircleOfFriendsUpdateTipsClick(msgData);
    end
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Friend_OnCircleOfFriendsUpdateTipsClick, self.CallOnCircleOfFriendsUpdateTipsClick);

    self.CallOnCircleOfFriendsTypeChanged = function(msgId, msgData)
        self.mCircleOfFriendType = msgData;
    end
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Friend_OnCircleOfFriendsTypeChanged, self.CallOnCircleOfFriendsTypeChanged)

    self.CallOnResFriendCirleMessage = function(msgId, msgData)
        if (msgData.type == 2 and CS.CSScene.MainPlayerInfo.FriendInfoV2.CurrentCircleOfFriendType == CS.CircleOfFriendType.MyCircles_MyNews) then
            self:GetCircleOfFriendsRightViewTemplate():GetMyNesCircleOfFriendsViewComponent():UpdateView();
        end
    end
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResFriendCirleMessage, self.CallOnResFriendCirleMessage);

    self.CallOnCircleOfFriendsTypeChanged = function(msgId, msgData)
        self:UpdateBtnShow();
    end
    self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Friend_OnCircleOfFriendsTypeChanged, self.CallOnCircleOfFriendsTypeChanged);
end

function UICircleOfFriendsViewTemplate:RemoveEvents()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResFriendCirleMessage, self.CallOnResFriendCirleMessage);
    self:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_Friend_UpdateSingleCircleOfFriends, self.CallOnResSingleFriendCirleMessage);
    self:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_Friend_OnFriendCircleCommentClicked, self.CallOnFriendCircleCommentClicked)
    self:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_Friend_OnCommentClicked, self.CallOnCommentClicked);
    self:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_Friend_OnFriendCircleUpdated, self.CallOnFriendCircleUpdated);
    self:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_Friend_OnCircleOfFriendsOwnerChanged, self.CallOnCircleOfFriendsOwnerChanged);

    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Friend_OnCircleOfFriendsUpdateTipsClick, self.CallOnCircleOfFriendsUpdateTipsClick);
    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResFriendCirleMessage, self.CallOnResFriendCirleMessage);
    self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Friend_OnCircleOfFriendsTypeChanged, self.CallOnCircleOfFriendsTypeChanged);
end

function UICircleOfFriendsViewTemplate:Clear()
    self.mCircleOfFriendsRightViewTemplate = nil;
    self.mCircleOfFriendsLeftViewTemplate = nil;
    self.mCircleOfFriendsOwner_Text = nil;
    self.mCircleOfFriendsRightViewTemplate_GameObject = nil;
    self.mCircleOfFriendsLeftViewTemplate_GameObject = nil;
    self.mPublishCircle_GameObject = nil;
    self.mClientHandler = nil;
end
--endregion

--endregion

--function UICircleOfFriendsViewTemplate:OnEnable()
--    self:InitEvents();
--end
--
--function UICircleOfFriendsViewTemplate:OnDisable()
--    self:RemoveEvents();
--end

---@param panel UISocialContactPanel
function UICircleOfFriendsViewTemplate:Init(panel)
    self.mOwnerPanel = panel
    self:InitEvents();
end

function UICircleOfFriendsViewTemplate:OnDestroy()
    self:RemoveEvents();
    self:Clear();
end

return UICircleOfFriendsViewTemplate;