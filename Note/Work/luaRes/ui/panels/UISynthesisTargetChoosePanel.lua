---@class UISynthesisTargetChoosePanel:UIBase
local UISynthesisTargetChoosePanel = {};

--region Components

function UISynthesisTargetChoosePanel:GetBackGround_GameObject()
    if (self.mBackGround_GameObject == nil) then
        self.mBackGround_GameObject = self:GetCurComp("WidgetRoot/events/backGround", "GameObject");
    end
    return self.mBackGround_GameObject;
end

---@return UISynthesisTargetChooseViewTemplate
function UISynthesisTargetChoosePanel:GetSynthesisTargetChooseView()
    if (self.mSynthesisTargetChooseView == nil) then
        self.mSynthesisTargetChooseView = templatemanager.GetNewTemplate(self:GetCurComp("WidgetRoot/view", "GameObject"), luaComponentTemplates.UISynthesisTargetChooseViewTemplate, self);
    end
    return self.mSynthesisTargetChooseView;
end

--endregion

--region Method

--region Public

--endregion

--region Private

---@private
function UISynthesisTargetChoosePanel:InitEvents()
    CS.UIEventListener.Get(self:GetBackGround_GameObject()).onClick = function()
        uimanager:ClosePanel("UISynthesisTargetChoosePanel");
    end;
end

--endregion

--endregion

function UISynthesisTargetChoosePanel:Init()
    self:InitEvents();
end

function UISynthesisTargetChoosePanel:Show(customData)
    if (customData.synthesisTables ~= nil) then
        self:GetSynthesisTargetChooseView():UpdateView(customData.synthesisTables);
    end
    if customData.CloseCallBack ~= nil then
        self.CloseCallBack = customData.CloseCallBack
    end
end

function UISynthesisTargetChoosePanel:onDestroy()
    if self.CloseCallBack ~= nil then
        self.CloseCallBack()
    end
end

return UISynthesisTargetChoosePanel;