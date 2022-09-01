---@class UIHeartSkillInfoPanel
local UIHeartSkillInfoPanel = {};

--region Components

function UIHeartSkillInfoPanel:GetBackGround_GameObject()
    if (self.mBackGround_GameObject == nil) then
        self.mBackGround_GameObject = self:GetCurComp("WidgetRoot/events/box", "GameObject");
    end
    return self.mBackGround_GameObject;
end

function UIHeartSkillInfoPanel:GetHeartSkillInfoViewTemplate_GameObject()
    if (self.mHeartSkillInfoViewTemplate_GameObject == nil) then
        self.mHeartSkillInfoViewTemplate_GameObject = self:GetCurComp("WidgetRoot/infoPanel", "GameObject");
    end
    return self.mHeartSkillInfoViewTemplate_GameObject;
end

function UIHeartSkillInfoPanel:GetHeartSkillInfoViewTemplate()
    if (self.mHeartSkillInfoViewTemplate == nil) then
        self.mHeartSkillInfoViewTemplate = templatemanager.GetNewTemplate(self:GetHeartSkillInfoViewTemplate_GameObject(), luaComponentTemplates.UIHeartSkillInfoViewTemplate, self);
    end
    return self.mHeartSkillInfoViewTemplate;
end

--endregion

--region Method

--region Public

function UIHeartSkillInfoPanel:UpdateUI(skillId)
    self:GetHeartSkillInfoViewTemplate():UpdateHeartSkillInfo(skillId);
end

--endregion

--region Private

function UIHeartSkillInfoPanel:InitEvents()
    CS.UIEventListener.Get(self:GetBackGround_GameObject()).onClick = function()
        uimanager:ClosePanel("UIHeartSkillInfoPanel");
    end;
end

function UIHeartSkillInfoPanel:RemoveEvents()

end

--endregion

--endregion

function UIHeartSkillInfoPanel:Init()
    self:InitEvents();
end

function UIHeartSkillInfoPanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end

    if (customData.skillId == nil) then
        uimanager:ClosePanel("UIHeartSkillInfoPanel");
    end
    self:UpdateUI(customData.skillId);
end

function ondestroy()
    UIHeartSkillInfoPanel:RemoveEvents();
end

return UIHeartSkillInfoPanel;