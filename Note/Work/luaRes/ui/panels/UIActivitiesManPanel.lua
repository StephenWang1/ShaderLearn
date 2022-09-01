---@class UIActivitiesManPanel
local UIActivitiesManPanel = {};

---@type UIActivitiesManPanel
local this = nil;

--region Components

function UIActivitiesManPanel:GetBtnClose_GameObject()
    if(this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/root/events/btn_close","GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UIActivitiesManPanel:GetActivitiesManViewTemplate_GameObject()
    if(this.mActivitiesManViewTemplate_GameObject == nil) then
        this.mActivitiesManViewTemplate_GameObject = this:GetCurComp("WidgetRoot/root/UIActivitiesLablePanel", "GameObject");
    end
    return this.mActivitiesManViewTemplate_GameObject;
end

---@return UIActivitiesManViewTemplate
function UIActivitiesManPanel:GetActivitiesManViewTemplate()
    if(this.mActivitiesManViewTemplate == nil) then
        this.mActivitiesManViewTemplate = templatemanager.GetNewTemplate(this:GetActivitiesManViewTemplate_GameObject(), luaComponentTemplates.UIActivitiesManViewTemplate);
    end
    return this.mActivitiesManViewTemplate;
end

--endregion

--region Method

--region Private

function UIActivitiesManPanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIActivitiesManPanel");
    end
end

function UIActivitiesManPanel:RemoveEvents()

end

--endregion

--endregion

function UIActivitiesManPanel:Init()
    this = self;

    this:InitEvents();
end

function UIActivitiesManPanel:Show(customData)
    if(customData == nil) then
        customData = {};
    end
    this:GetActivitiesManViewTemplate():UpdateView(customData.targetCalendarVo);
end

function ondestroy()
    this:RemoveEvents();

    this = nil;
end

return UIActivitiesManPanel;