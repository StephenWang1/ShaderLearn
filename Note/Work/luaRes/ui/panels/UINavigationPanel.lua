---@class UINavigationPanel:UIBase
local UINavigationPanel = {};

---@type UINavigationPanel
local this = nil;

UINavigationPanel.mCurrentMenuLayer = nil;

UINavigationPanel.mCloseTimer = 0;

--region Components

--region GameObject

--endregion

---@return UINavigationViewTemplate
function UINavigationPanel:GetNavViewTemplate()
    if (this.mNavViewTemplate == nil) then
        this.mNavViewTemplate = templatemanager.GetNewTemplate(this:GetCurComp("WidgetRoot/root", "GameObject"), luaComponentTemplates.UINavigationViewTemplate)
    end
    return this.mNavViewTemplate;
end

--endregion

--region Method

--region CallFunction
function UINavigationPanel:OnNavOpen()
    local mainMenusPanel = uimanager:GetPanel("UIMainMenusPanel");
    if (mainMenusPanel ~= nil) then
        mainMenusPanel.PlayRightNodeFadeOut();
    end
    luaEventManager.DoCallback(LuaCEvent.Navigation_OnOpenFinished);
end

function UINavigationPanel.OnUpdateNavigation()
    UINavigationPanel:GetNavViewTemplate():UpdateUnit();
end

function UINavigationPanel.CloseTheNavigationAndPanel()
    UINavigationPanel:GetNavViewTemplate():CloseShow(2);
end

---导航栏关闭之后回调
function UINavigationPanel:OnNavClosed()

    if (this.mSkillTipPanel ~= nil) then
        this.mSkillTipPanel:Hide();
        this.mSkillTipPanel = nil;
    end

    local mainMenusPanel = uimanager:GetPanel("UIMainMenusPanel");
    if (mainMenusPanel ~= nil) then
        mainMenusPanel.PlayRightNodeFadeIn();
    end

    this:TryCloseNavTimer();

    local effectPanel = uimanager:GetPanel("UIEffectPanel");
    if (effectPanel ~= nil) then
        effectPanel:CloseEffect("700087");
        effectPanel:CloseEffect("700088");
        effectPanel:CloseEffect("700089");
    end

    this:GetNavViewTemplate():GetBtnOpen_GameObject():SetActive(true);
    this:GetNavViewTemplate():GetBtnClose_GameObject():SetActive(false);

    luaEventManager.DoCallback(LuaCEvent.Navigation_OnCloseFinished)
end

UINavigationPanel.mTransferParamsCache = nil

function UINavigationPanel.OnNavigationSelect(msgId, customData)
    UINavigationPanel.mTransferParamsCache = nil;
    UINavigationPanel:GetNavViewTemplate():Select(customData);
    local layer = UINavigationPanel:GetNavViewTemplate().mSelectMenuLayer
    if (layer == nil) then
        UINavigationPanel:GetNavViewTemplate():OnClickBtnOpen();
    elseif (layer == LuaEnumNavMenusLayer.First) then
        UINavigationPanel:GetNavViewTemplate():ShowLayer(layer);
    else
        UINavigationPanel.mTransferParamsCache = customData;
        UINavigationPanel:GetNavViewTemplate():CloseShow(0);
    end
end

function UINavigationPanel.OnFirstMenuFadeInFished()
    if (UINavigationPanel.mSkillTipPanel ~= nil) then
        UINavigationPanel.mSkillTipPanel:SetPosition(UINavigationPanel:GetNavUnitByNavId(4).go.transform.position);
    end
    this:TryStartCloseNavTimer();
end

function UINavigationPanel.OnClickNavUnit()
    if (UINavigationPanel.mSkillTipPanel ~= nil) then
        UINavigationPanel.mSkillTipPanel:Hide();
        UINavigationPanel.mSkillTipPanel = nil;
    end

    this:TryCloseNavTimer();
    --uimanager:ClosePanel("UIServantPanel");
    --uimanager:ClosePanel("UIRolePanelTagPanel");
end

--endregion

--region Public

function UINavigationPanel:GetSkillDialogTipsPos()
    if (this:GetNavViewTemplate().mSelectMenuLayer ~= nil) then
        if (this:GetNavViewTemplate().mSelectMenuLayer == LuaEnumNavMenusLayer.First) then
            return this:GetNavUnitByNavId(4) ~= nil and this:GetNavUnitByNavId(4).go.transform.position or CS.UnityEngine.Vector3.zero;
        else
            return this:GetNavUnitByNavId(21) ~= nil and this:GetNavUnitByNavId(21).go.transform.position or CS.UnityEngine.Vector3.zero;
        end
    end
    return this:GetNavViewTemplate():GetBtnOpen_GameObject().transform.position;
end

function UINavigationPanel:GetNavUnitByNavId(navId)
    return this:GetNavViewTemplate():GetButtonByNavId(navId);
end

function UINavigationPanel:GetNavIsOpen()
    if (this == nil) then
        return false;
    else
        return not this:GetNavViewTemplate():GetBtnOpen_GameObject().activeSelf;
    end
end

--endregion

--region Private

function UINavigationPanel:ResetCloseTime()
    this.mCloseTimer = 0;
end

function UINavigationPanel:GetTimerInterval()
    return CS.Cfg_GlobalTableManager.Instance:GetCloseNavTime();
end

function UINavigationPanel:TryStartCloseNavTimer()
    if (this.mCoroutineCloseTimer == nil) then
        this.mCoroutineCloseTimer = StartCoroutine(this.CCloseNavTimer);
    end
end

function UINavigationPanel:TryCloseNavTimer()
    if (this.mCoroutineCloseTimer ~= nil) then
        this.mCoroutineCloseTimer = StopCoroutine(this.mCoroutineCloseTimer);
        this.mCoroutineCloseTimer = nil;
    end
    this:ResetCloseTime();
end

function UINavigationPanel.CCloseNavTimer()
    UINavigationPanel.mCloseTimer = 0;

    while (this.mCloseTimer < this:GetTimerInterval()) do
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1));
        this.mCloseTimer = this.mCloseTimer + 1;
    end

    ---如果规定时间内没有进行操作则收起导航栏栏
    this.CloseTheNavigationAndPanel();
    this.mCoroutineCloseTimer = nil;
    this.mCloseTimer = 0;
end

function UINavigationPanel:InitEvents()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Navigation_OpenWithId, this.OnNavigationSelect)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Navigation_OnFirstMenuFadeInFished, this.OnFirstMenuFadeInFished)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Navigation_OnClickUnit, this.OnClickNavUnit)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Navigation_UpdateUnit, this.OnUpdateNavigation)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Navigation_CloseNavAndPanel, this.CloseTheNavigationAndPanel)
    self:GetClientEventHandler():AddEvent(CS.CEvent.ClickTerrain, function()
        if self:GetNavIsOpen() then
            self.CloseTheNavigationAndPanel()
        end
    end)
end

function UINavigationPanel:RemoveEvents()
    --luaEventManager.RemoveCallback(LuaCEvent.Navigation_OpenWithId, this.OnNavigationSelect);
    --luaEventManager.RemoveCallback(LuaCEvent.Navigation_OnFirstMenuFadeInFished, this.OnFirstMenuFadeInFished);
    --luaEventManager.RemoveCallback(LuaCEvent.Navigation_OnClickUnit, this.OnClickNavUnit);
    --luaEventManager.RemoveCallback(LuaCEvent.Navigation_UpdateUnit, this.OnUpdateNavigation);
    --luaEventManager.RemoveCallback(LuaCEvent.Navigation_CloseNavAndPanel, this.CloseTheNavigationAndPanel);

    this:TryCloseNavTimer();
end

--endregion

--endregion

function UINavigationPanel:Init()
    this = self;

    this:InitEvents();
    this:GetNavViewTemplate():Initialize(
            function()
                this:OnNavOpen();
            end,
            function()
                if(this.mTransferParamsCache ~= nil) then
                    --this:GetNavViewTemplate():OnClickBtnOpen();
                    local params = this.mTransferParamsCache;
                    this.OnNavigationSelect(nil, params);
                    this.mTransferParamsCache = nil;
                else
                    this:OnNavClosed();
                end
            end);
end

function ondestroy()
    this:RemoveEvents();
    this = nil;
end

return UINavigationPanel;