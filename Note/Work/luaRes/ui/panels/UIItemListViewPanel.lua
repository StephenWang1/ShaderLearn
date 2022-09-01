local UIItemListViewPanel = {};

local this = nil

UIItemListViewPanel.mRankVo = nil;

--region Components

function UIItemListViewPanel:GetBackGround_GameObject()
    if (this.mBackGround_GameObject == nil) then
        this.mBackGround_GameObject = this:GetCurComp("WidgetRoot/window/backGround", "GameObject");
    end
    return this.mBackGround_GameObject;
end

function UIItemListViewPanel:GetBtnClose_GameObject()
    if (this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/event/CloseBtn", "GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UIItemListViewPanel:GetItemPageViewTemplate_GameObject()
    if (this.mItemPageViewTemplate_GameObject == nil) then
        this.mItemPageViewTemplate_GameObject = this:GetCurComp("WidgetRoot/view", "GameObject");
    end
    return this.mItemPageViewTemplate_GameObject;
end

function UIItemListViewPanel:GetItemPageViewTemplate()
    if (this.mItemPageViewTemplate == nil) then
        this.mItemPageViewTemplate = templatemanager.GetNewTemplate(this:GetItemPageViewTemplate_GameObject(), luaComponentTemplates.UIItemPageViewTemplate);
    end
    return this.mItemPageViewTemplate;
end

--endregion

--region Method

--region Public

--endregion

--region Private

function UIItemListViewPanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIItemListViewPanel");
    end;

    CS.UIEventListener.Get(this:GetBackGround_GameObject()).onClick = function()
        uimanager:ClosePanel("UIItemListViewPanel");
    end;
end

function UIItemListViewPanel:RemoveEvents()

end

--endregion

--endregion

function UIItemListViewPanel:Init()
    this = self;
    this:InitEvents();
end

function UIItemListViewPanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end

    if (customData.itemViewVoList ~= nil) then
        this:GetItemPageViewTemplate():UpdateToItemViewVoList(customData.itemViewVoList);
    elseif (customData.itemViewVos ~= nil) then
        this:GetItemPageViewTemplate():UpdateToItemViewVos(customData.itemViewVos);
    else
        uimanager:ClosePanel("UIItemListViewPanel");
    end
end

function ondestroy()
    this:RemoveEvents();
    this = nil;
end

return UIItemListViewPanel;