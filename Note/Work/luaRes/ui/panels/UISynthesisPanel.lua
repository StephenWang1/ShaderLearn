---@class UISynthesisPanel:UIBase
local UISynthesisPanel = {};

---@type UISynthesisPanel
local this = nil;

--region Components

function UISynthesisPanel:GetBtnClose_GameObject()
    if (this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return this.mBtnClose_GameObject;
end

function UISynthesisPanel:GetSynthesisViewTemplate_GameObject()
    if (this.mSynthesisViewTemplate_GameObject == nil) then
        this.mSynthesisViewTemplate_GameObject = this:GetCurComp("WidgetRoot", "GameObject");
    end
    return this.mSynthesisViewTemplate_GameObject;
end

---@return UISynthesisViewTemplate
function UISynthesisPanel:GetSynthesisViewTemplate()
    if (this.mSynthesisViewTemplate == nil) then
        this.mSynthesisViewTemplate = templatemanager.GetNewTemplate(this:GetSynthesisViewTemplate_GameObject(), luaComponentTemplates.UISynthesisViewTemplate, self);
    end
    return this.mSynthesisViewTemplate;
end

--endregion

--region Method

--region CallFunction

--endregion

--region Public
---设置选择的物品
---@param bagItemInfo bagV2.BagItemInfo
function UISynthesisPanel:TrySetSelectBagItem(bagItemInfo)
    if self:GetSynthesisViewTemplate() ~= nil then
        if (self:GetSynthesisViewTemplate():TrySetSelectBagItem(bagItemInfo) ~= 1) then
            self:GetSynthesisViewTemplate():UpdateSynthesis();
        end
    end
end
--endregion

--region Private

function UISynthesisPanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UISynthesisPanel");
    end
end

function UISynthesisPanel:RemoveEvents()

end

--endregion

--endregion

function UISynthesisPanel:Init()
    this = self;
    this:InitEvents();
    self:BindMessage()
end

function UISynthesisPanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end

    if (customData.synthesisSuccessClosePanel == nil) then
        customData.synthesisSuccessClosePanel = false;
    end

    this:GetSynthesisViewTemplate():UpdateView(customData);
end

function UISynthesisPanel:BindMessage()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        self:GetSynthesisViewTemplate():UpdateSynthesisCost()
    end)
end

function update()
    this:GetSynthesisViewTemplate():OnUpdate();
end

function ondestroy()
    this:RemoveEvents();
    this = nil;

    uimanager:ClosePanel("UIRolePanel");
    --uimanager:ClosePanel("UIBagPanel");
    uimanager:ClosePanel("UIServantPanel");
    uimanager:ClosePanel("UISynthesisItemListPanel");
end

return UISynthesisPanel;