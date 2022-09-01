local UIFriendCircleCommentPanel = {};

local this = nil;

UIFriendCircleCommentPanel.mMaxTextLength = nil;

UIFriendCircleCommentPanel.mLastMaxText = nil;

--region Components

function UIFriendCircleCommentPanel:GetBtnClose_GameObject()
    if(this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/events/CloseBtn","GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UIFriendCircleCommentPanel:GetBtnPublish_GameObject()
    if(this.mBtnPublish_GameObject == nil) then
        this.mBtnPublish_GameObject = this:GetCurComp("WidgetRoot/events/PublishBtn","GameObject");
    end
    return this.mBtnPublish_GameObject;
end

function UIFriendCircleCommentPanel:GetBtnEmoticon_GameObject()
    if(this.mBtnEmoticon_GameObject == nil) then
        this.mBtnEmoticon_GameObject = this:GetCurComp("WidgetRoot/events/btn_emoticon","GameObject");
    end
    return this.mBtnEmoticon_GameObject;
end

function UIFriendCircleCommentPanel:GetContentInput_UIInput()
    if(this.mContentInput_UIInput == nil) then
        this.mContentInput_UIInput = this:GetCurComp("WidgetRoot/view/Input/ChatInput","UIInput");
    end
    return this.mContentInput_UIInput;
end

function UIFriendCircleCommentPanel:GetContentText_UIFaceText()
    if(this.mContentText_UIFaceText == nil) then
        this.mContentText_UIFaceText = this:GetCurComp("WidgetRoot/view/Input/ChatInput/Sprite","UIFaceText");
    end
    return this.mContentText_UIFaceText;
end

function UIFriendCircleCommentPanel:GetTextLength_Text()
    if(this.mTextLength_Text == nil) then
        this.mTextLength_Text = this:GetCurComp("WidgetRoot/view/number","UILabel");
    end
    return this.mTextLength_Text;
end

function UIFriendCircleCommentPanel:GetTargetName_Text()
    if(this.mTargetName_Text == nil) then
        this.mTargetName_Text = this:GetCurComp("WidgetRoot/window/title", "UILabel")
    end
    return this.mTargetName_Text;
end

function UIFriendCircleCommentPanel:GetButtonLabel_Text()
    if(this.mButtonLabel_Text == nil) then
        this.mButtonLabel_Text = this:GetCurComp("WidgetRoot/events/PublishBtn/Label","UILabel");
    end
    return this.mButtonLabel_Text;
end

function UIFriendCircleCommentPanel:GetEmotionComponent()
    if(this.mEmotionComponent == nil) then
        this.mEmotionComponent = this:GetCurComp("WidgetRoot/view/EmotionWindow", "UIEmotionComponent");
    end
    return this.mEmotionComponent;
end

function UIFriendCircleCommentPanel:GetMaxTextLength()
    if(this.mMaxTextLength == nil) then
        this.mMaxTextLength = 100;
    end
    return this.mMaxTextLength;
end

--endregion

--region Method

--region CallFunction

function UIFriendCircleCommentPanel:OnUIInputValueChanged()
    if(this.mCustomData ~= nil) then
        local length = Utility.GetStringLength(this:GetContentInput_UIInput().value);
        if(length <= this:GetMaxTextLength()) then
            this.mLastMaxText = this:GetContentInput_UIInput().value;
        else
            this:GetContentInput_UIInput().value = this.mLastMaxText;
            length = Utility.GetStringLength(this:GetContentInput_UIInput().value);
        end
        this:GetTextLength_Text().text = length.."/"..this:GetMaxTextLength();
    end
end

--endregion

--region Public

--endregion

--region Private

function UIFriendCircleCommentPanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIFriendCircleCommentPanel");
    end

    CS.UIEventListener.Get(this:GetBtnPublish_GameObject()).onClick = function()
        if(this.mCustomData ~= nil and this.mCustomData.postId ~= nil and this.mCustomData.replyId ~= nil) then
            local value = this:GetContentInput_UIInput().value
            value = this:GetEmotionComponent():ReplaceEmojiNameToEmoji(value);
            networkRequest.ReqFriendCircleReply(this.mCustomData.postId, this.mCustomData.replyId, value);
        end
        uimanager:ClosePanel("UIFriendCircleCommentPanel");
    end

    CS.UIEventListener.Get(this:GetBtnEmoticon_GameObject()).onClick = function()
        this:GetEmotionComponent().gameObject:SetActive(true);
    end

    this:GetEmotionComponent().onClickEmotion = function(spriteName)
        local length = Utility.GetStringLength(this:GetContentInput_UIInput().value) + Utility.GetStringLength(spriteName);
        if(length <= this:GetMaxTextLength()) then
            this:GetContentInput_UIInput():InsertText(spriteName)
        end
    end

    this.CallOnUIInputValueChanged = function()
        this:OnUIInputValueChanged();
    end
    CS.EventDelegate.Add(this:GetContentInput_UIInput().onChange, self.CallOnUIInputValueChanged);
end

function UIFriendCircleCommentPanel:RemoveEvents()

end

--endregion

--endregion

function UIFriendCircleCommentPanel:Init()
    this = self;
    this:InitEvents();
end

function UIFriendCircleCommentPanel:Show(customData)
    if(customData == nil) then
        customData = {};
    end
    if(customData.targetName == nil) then
        customData.targetName = "";
    end

    this.mCustomData = customData;
    this:OnUIInputValueChanged();
    if(this.mCustomData.isReply) then
        this:GetTargetName_Text().text = luaEnumColorType.Gray.."评论[-] ";
    else
        this:GetTargetName_Text().text = luaEnumColorType.Gray.."回复[-] "..luaEnumColorType.White..customData.targetName.."[-]";
    end
    this:GetButtonLabel_Text().text = this.mCustomData.isReply and "评论" or "回复";
    this:GetContentInput_UIInput().defaultText = this.mCustomData.isReply and "请输入需要评论的内容..." or "请输入需要回复的内容...";
end

function ondestroy()
    this:RemoveEvents();
end

return UIFriendCircleCommentPanel;