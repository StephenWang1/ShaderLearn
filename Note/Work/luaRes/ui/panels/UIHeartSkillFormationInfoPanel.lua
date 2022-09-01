
---@class UIHeartSkillFormationInfoPanel
local UIHeartSkillFormationInfoPanel = {};

--region Components

function UIHeartSkillFormationInfoPanel:GetBackGround_GameObject()
    if(self.mBackGround_GameObject == nil) then
        self.mBackGround_GameObject = self:GetCurComp("WidgetRoot/events/box","GameObject");
    end
    return self.mBackGround_GameObject;
end

function UIHeartSkillFormationInfoPanel:GetHeartSkillFormationInfoViewTemplate()
    if(self.mHeartSkillFormationInfoViewTemplate == nil) then
        self.mHeartSkillFormationInfoViewTemplate = templatemanager.GetNewTemplate(self:GetCurComp("WidgetRoot/infoPanel", "GameObject"), luaComponentTemplates.UIHeartSkillFormationInfoViewTemplate);
    end
    return self.mHeartSkillFormationInfoViewTemplate;
end

--endregion

--region Method

--region Public

function UIHeartSkillFormationInfoPanel:UpdateUI(formationId, formationLevel)
    self:GetHeartSkillFormationInfoViewTemplate():UpdateView(formationId, formationLevel);
end

--endregion

--region Private

function UIHeartSkillFormationInfoPanel:InitEvents()
    CS.UIEventListener.Get(self:GetBackGround_GameObject()).onClick = function()
        uimanager:ClosePanel("UIHeartSkillFormationInfoPanel");
    end;
end

function UIHeartSkillFormationInfoPanel:RemoveEvents()

end

--endregion

--endregion

function UIHeartSkillFormationInfoPanel:Init()
    self:InitEvents();
end

function UIHeartSkillFormationInfoPanel:Show(customData)
    if(customData == nil) then
        customData = {};
    end

    if(customData.formationId == nil) then
        uimanager:ClosePanel("UIHeartSkillFormationInfoPanel");
    end

    if(customData.formationLevel == nil) then
        customData.formationLevel = 1;
    end

    self:UpdateUI(customData.formationId, customData.formationLevel);
end

function ondestroy()

end

return UIHeartSkillFormationInfoPanel;