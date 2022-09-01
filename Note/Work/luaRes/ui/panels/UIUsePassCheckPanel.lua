local UIUsePassCheckPanel = {};

--region Components

function UIUsePassCheckPanel:GetBackGround_GameObject()
    if(self.mBackGround_GameObject == nil) then
        self.mBackGround_GameObject = self:GetCurComp("WidgetRoot/events/backGround", "GameObject");
    end
    return self.mBackGround_GameObject;
end

function UIUsePassCheckPanel:GetUIUsePassCheckViewTemplate()
    if(self.mUIUsePassCheckViewTemplate == nil) then
        self.mUIUsePassCheckViewTemplate = templatemanager.GetNewTemplate(self:GetCurComp("WidgetRoot","GameObject"), luaComponentTemplates.UIUsePassCheckViewTemplate);
    end
    return self.mUIUsePassCheckViewTemplate;
end

--endregion

--region Method

function UIUsePassCheckPanel:UpdateButtons(itemTable)
    self:GetUIUsePassCheckViewTemplate():UpdateView(itemTable);
end

--region Private

function UIUsePassCheckPanel:InitEvents()
    CS.UIEventListener.Get(self:GetBackGround_GameObject()).onClick = function()
        uimanager:ClosePanel("UIUsePassCheckPanel");
    end
end

--endregion

--endregion

function UIUsePassCheckPanel:Init()
    self:InitEvents();
end

function UIUsePassCheckPanel:Show(customData)
    if(customData.mItemInfo ~= nil) then
        self:UpdateButtons(customData.mItemInfo);
    end
end

return UIUsePassCheckPanel;