---@class UIHeartFormationChoosePanel:UIBase
local UIHeartFormationChoosePanel = {};

local this = nil;

UIHeartFormationChoosePanel.PanelLayerType = CS.UILayerType.WindowsPlane

UIHeartFormationChoosePanel.mFormationChooseTemplateUnitDic = {};

UIHeartFormationChoosePanel.mSelectFormationId = 0;

--region Components

--region GameObject

function UIHeartFormationChoosePanel:GetBtnClose_GameObject()
    if(this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/events/CloseBtn","GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UIHeartFormationChoosePanel:GetCloseBtn_GameObject()
    if(this.mCloseBtn_GameObject == nil) then
        this.mCloseBtn_GameObject = this:GetCurComp("WidgetRoot/events/mask", "GameObject");
    end
    return this.mCloseBtn_GameObject;
end

function UIHeartFormationChoosePanel:GetBtnUse_GameObject()
    if(this.mBtnUse_GameObject == nil) then
        this.mBtnUse_GameObject = this:GetCurComp("WidgetRoot/events/btnUse", "GameObject");
    end
    return this.mBtnUse_GameObject;
end

function UIHeartFormationChoosePanel:GetNotHas_GameObject()
    if(this.mNotHas_GameObject == nil) then
        this.mNotHas_GameObject = this:GetCurComp("WidgetRoot/notHas", "GameObject");
    end
    return this.mNotHas_GameObject;
end

--endregion

function UIHeartFormationChoosePanel:GetUnitGridContainer()
    if(this.mUnitGridContainer == nil) then
        this.mUnitGridContainer = this:GetCurComp("WidgetRoot/Scroll View/formations", "UIGridContainer");
    end
    return this.mUnitGridContainer;
end

--endregion

--region Method

--region CallFunction

function UIHeartFormationChoosePanel:OnClickBtnClose()
    uimanager:ClosePanel("UIHeartFormationChoosePanel");
end

function UIHeartFormationChoosePanel:OnClickBtnUse()
    if(this.mSelectFormationId ~= nil and this.mSelectFormationId ~= 0) then
        networkRequest.ReqSwitchFormation(this.mSelectFormationId);
    end
    uimanager:ClosePanel("UIHeartFormationChoosePanel");
end

--endregion

--region Public

function UIHeartFormationChoosePanel:ShowHeartFormation()
    this.mFormationChooseTemplateUnitDic = {};
    this.mOldFormationList = CS.CSScene.MainPlayerInfo.SkillInfoV2.HeartSkillFormationList;
    if(this.mOldFormationList ~= nil) then
        this.mHasFormation = this.mOldFormationList.Count > 0;
        local gridContainer = this:GetUnitGridContainer();
        gridContainer.MaxCount = this.mOldFormationList.Count;
        for i = 0, gridContainer.MaxCount - 1 do
            local key = i + 1;
            local gobj = gridContainer.controlList[i];
            if(this.mFormationChooseTemplateUnitDic[key] == nil) then
                this.mFormationChooseTemplateUnitDic[key] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIHeartFormationChooseUnitTemplate);
            end
            this.mFormationChooseTemplateUnitDic[key]:ShowHeartFormationUnit(this.mOldFormationList[i]);
        end
    end

    this:GetNotHas_GameObject():SetActive(not this.mHasFormation);
end

--endregion

--region Private

function UIHeartFormationChoosePanel:InitEvents()
    CS.UIEventListener.Get(this:GetCloseBtn_GameObject()).onClick = this.OnClickBtnClose;
    CS.UIEventListener.Get(this:GetBtnUse_GameObject()).onClick = this.OnClickBtnUse;
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = this.OnClickBtnClose;

    this.CallOnChooseUnitClicked = function(msgId, chooseUnit)
        if(chooseUnit ~= nil) then
            this.mSelectFormationId = chooseUnit.mFormationId;
            if(this.mLastChooseUnit ~= nil and this.mLastChooseUnit ~= chooseUnit) then
                this.mLastChooseUnit:UnChoose();
            end
            this.mLastChooseUnit = chooseUnit;
        end
    end

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Skill_OnHeartSkillFormationChooseClicked, this.CallOnChooseUnitClicked)
end
--endregion

--endregion

function UIHeartFormationChoosePanel:Init()
    this = self;

    this:InitEvents();
end

function UIHeartFormationChoosePanel:Show()
    this:ShowHeartFormation();
end

return UIHeartFormationChoosePanel;