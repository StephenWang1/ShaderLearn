---@class UIJoinTeamPanel:UIBase
local UIJoinTeamPanel = {}

---@type UIJoinTeamPanel
local this = nil;

--region Components

function UIJoinTeamPanel:GetJoinTeamTemplate_GameObject()
    if (this.mJoinTeamTemplate_GameObject == nil) then
        this.mJoinTeamTemplate_GameObject = this:GetCurComp("WidgetRoot/Scroll View", "GameObject");
    end
    return this.mJoinTeamTemplate_GameObject;
end

function UIJoinTeamPanel:GetBtnClose_GameObject()
    if (this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/events/btn_close", "GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UIJoinTeamPanel:GetBtnRefresh_GameObject()
    if (this.mBtnRefresh_GameObject == nil) then
        this.mBtnRefresh_GameObject = this:GetCurComp("WidgetRoot/events/btn_refresh", "GameObject");
    end
    return this.mBtnRefresh_GameObject;
end

function UIJoinTeamPanel:GetBackGround_GameObject()
    if (this.mBackGround_GameObject == nil) then
        this.mBackGround_GameObject = this:GetCurComp("WidgetRoot/window/bg2", "GameObject")
    end
    return this.mBackGround_GameObject;
end

function UIJoinTeamPanel:GetJoinTeamViewTemplate()
    if (this.mJoinTeamViewTemplate == nil) then
        this.mJoinTeamViewTemplate = templatemanager.GetNewTemplate(this:GetJoinTeamTemplate_GameObject(), luaComponentTemplates.UIJoinTeamViewTemplate, self);
    end
    return this.mJoinTeamViewTemplate;
end

--endregion

--region CallFunction

function UIJoinTeamPanel:OnClickBtnClose()
    uimanager:ClosePanel("UIJoinTeamPanel");
end

--endregion

--region Method

--region Public

--endregion

--region Private

function UIJoinTeamPanel:InitEvents()

    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        this:OnClickBtnClose();
    end

    CS.UIEventListener.Get(this:GetBackGround_GameObject()).onClick = function()
        this:OnClickBtnClose();
    end

    CS.UIEventListener.Get(this:GetBtnRefresh_GameObject()).onClick = function()
        local type = this:GetJoinTeamViewTemplate():GetType()
        if (type ~= nil) then
            if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                networkRequest.ReqShareClearList(type);
            else
                networkRequest.ReqClearList(type);
            end
            CS.CSScene.MainPlayerInfo.GroupInfoV2:OnClearList();
            this:GetJoinTeamViewTemplate():UpdateView();
        end
    end
end

function UIJoinTeamPanel:RemoveEvents()

end

--endregion

--endregion

function UIJoinTeamPanel:Init()
    this = self;

    this:InitEvents();
end

function UIJoinTeamPanel:Show(customData)
    --CS.CSScene.MainPlayerInfo.GroupInfoV2.IsHaveNewTeamInvitat = false
    --CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.Team_Main);
    this:GetJoinTeamViewTemplate():UpdateView();
end

function ondestroy()
    this:RemoveEvents();
    Utility.RemoveFlashPrompt(1, 8)
    CS.CSScene.MainPlayerInfo.GroupInfoV2.IsHaveNewTeamInvitat = false
    --CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.Team_Main);
end

return UIJoinTeamPanel;