local UIChangeNamePanel = {};

local this = nil;

UIChangeNamePanel.mSureCallBack = nil;

UIChangeNamePanel.mCancelCallBack = nil;

--region Components

--region GameObject

function UIChangeNamePanel:GetLeftButton_GameObject()
    if (this.mLeftButton_GameObject == nil) then
        this.mLeftButton_GameObject = this:GetCurComp("events/LeftBtn", "GameObject");
    end
    return this.mLeftButton_GameObject;
end

function UIChangeNamePanel:GetRightButton_GameObject()
    if (this.mRightButton_GameObject == nil) then
        this.mRightButton_GameObject = this:GetCurComp("events/RightBtn", "GameObject");
    end
    return this.mRightButton_GameObject;
end

function UIChangeNamePanel:GetCloseButton_GameObject()
    if (this.mCloseButton_GameObject == nil) then
        this.mCloseButton_GameObject = this:GetCurComp("events/close", "GameObject");
    end
    return this.mCloseButton_GameObject;
end
--endregion

function UIChangeNamePanel:GetChangeNameInput()
    if (this.mChangeNameInput == nil) then
        this.mChangeNameInput = this:GetCurComp("Chat Input", "UIInput");
    end
    return this.mChangeNameInput;
end

function UIChangeNamePanel:GetPanelTitle_UILabel()
    if (UIChangeNamePanel.mPanelTitle == nil) then
        UIChangeNamePanel.mPanelTitle = self:GetCurComp("view/Title", "UILabel")
    end
    return UIChangeNamePanel.mPanelTitle
end
--endregion

--region Method

--region CallFunction

function UIChangeNamePanel.OnClickBtnSure()

    if (this.mSureCallBack ~= nil) then
        this.mSureCallBack(this.GetChangeNameInput().value);
    end

    uimanager:ClosePanel("UIChangeNamePanel");
end

function UIChangeNamePanel.OnClickBtnClose()

    if (this.mCancelCallBack ~= nil) then
        this.mCancelCallBack();
    end

    uimanager:ClosePanel("UIChangeNamePanel");
end

function UIChangeNamePanel.CloseBtnOnClick()
    uimanager:ClosePanel("UIChangeNamePanel");
end
--endregion

--region Public
--endregion

--region Private
function UIChangeNamePanel:InitEvents()
    --region ClientEvents
    CS.UIEventListener.Get(this:GetLeftButton_GameObject()).onClick = this.OnClickBtnClose
    CS.UIEventListener.Get(this:GetRightButton_GameObject()).onClick = this.OnClickBtnSure
    CS.UIEventListener.Get(this:GetCloseButton_GameObject()).onClick = this.CloseBtnOnClick
    --endregion
end

function UIChangeNamePanel:RemoveEvents()

end
--endregion

--endregion

function UIChangeNamePanel:Init()
    this = self;

    this:InitEvents();
end

---@param customData
---customData.defaultValue
---customData.SureCallBack
---customData.CancelCallBack
function UIChangeNamePanel:Show(customData, title)

    if (customData.SureCallBack ~= nil) then
        this.mSureCallBack = customData.SureCallBack;
    end

    if (customData.CancelCallBack ~= nil) then
        this.mCancelCallBack = customData.CancelCallBack;
    end

    if (title ~= nil) then
        UIChangeNamePanel:GetPanelTitle_UILabel().text = title
    end
    this.GetChangeNameInput().value = customData.defaultValue == nil and "" or customData.defaultValue;
end

function ondestroy()
    this:RemoveEvents();
end

return UIChangeNamePanel;