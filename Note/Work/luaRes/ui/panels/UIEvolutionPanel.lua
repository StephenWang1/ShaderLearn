---@class UIEvolutionPanel:UIBase
local UIEvolutionPanel = {};

local this = nil;

--region Components

--region GameObject

function UIEvolutionPanel:GetEvolutionTemplate_GameObject()
    if (this.mEvolutionTemplate_GameObject == nil) then
        this.mEvolutionTemplate_GameObject = this:GetCurComp("WidgetRoot", "GameObject");
    end
    return this.mEvolutionTemplate_GameObject;
end

function UIEvolutionPanel:GetBtnClose_GameObject()
    if (this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/events/btn_close", "GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UIEvolutionPanel:GetBtnHelp_GameObject()
    if (this.mBtnHelp_GameObject == nil) then
        this.mBtnHelp_GameObject = this:GetCurComp("WidgetRoot/events/btn_help", "GameObject");
    end
    return this.mBtnHelp_GameObject;
end

--endregion

---@return UIEvolutionViewTemplate
function UIEvolutionPanel:GetEvolutionTemplate()
    if (this.mEvolutionTemplate == nil) then
        this.mEvolutionTemplate = templatemanager.GetNewTemplate(this:GetEvolutionTemplate_GameObject(), luaComponentTemplates.UIEvolutionViewTemplate, self);
    end
    return this.mEvolutionTemplate;
end

--endregion

--region Method

--region CallFunction

function UIEvolutionPanel:OnBtnCloseClicked()
    this:CloseLeftPanel();
    uimanager:ClosePanel("UIEvolutionPanel");
end

--endregion

--region Public

--endregion

--region Private

function UIEvolutionPanel:CloseLeftPanel()
    uimanager:ClosePanel("UIRolePanel");
    uimanager:ClosePanel("UIBagPanel");
end

function UIEvolutionPanel:Initialize()

end

function UIEvolutionPanel:InitEvents()

    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        self:OnBtnCloseClicked();
    end

    CS.UIEventListener.Get(this:GetBtnHelp_GameObject()).onClick = function()
        local info
        local isFind = nil
        isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(77)
        if isFind then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
        end
    end

end

function UIEvolutionPanel:RemoveEvents()

end

--endregion

--endregion

function UIEvolutionPanel:Init()
    this = self;

    this:Initialize();
    this:InitEvents();
end

---@param customData table {leftPanelType, bagItemInfo}
function UIEvolutionPanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end

    if (customData.leftPanelType == nil) then
        customData.leftPanelType = LuaEnumStrengthenType.Role;
    end
    uimanager:ClosePanel("UIRolePanelTagPanel")
    this:GetEvolutionTemplate():ShowEvolution(customData);
end

function UIEvolutionPanel:SetEvolution(customData)
    this:GetEvolutionTemplate():ShowEvolution(customData);
end

function ondestroy()
    this:RemoveEvents();
    this:CloseLeftPanel();
    if CS.CSScene.MainPlayerInfo then
        CS.CSScene.MainPlayerInfo.BagInfo.EvolutionCostDic:Clear();
    end
end

return UIEvolutionPanel;