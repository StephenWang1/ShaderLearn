---@class UITeamPanel:UIBase
local UITeamPanel = {};

---@type UITeamPanel
local this = nil;

UITeamPanel.mTeamReqStringDic = nil;

UITeamPanel.mTeamJoinStringDic = nil;

--region Components

--region GameObject

function UITeamPanel:GetBtnClose_GameObject()
    if (this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return this.mBtnClose_GameObject;
end

function UITeamPanel:GetTeamViewTemplate_GameObject()
    if (this.mTeamViewTemplate_GameObject == nil) then
        this.mTeamViewTemplate_GameObject = this:GetCurComp("WidgetRoot/SurfaceGroup", "GameObject");
    end
    return this.mTeamViewTemplate_GameObject;
end

function UITeamPanel:GetCurrentTeamViewTemplate_GameObject()
    if (this.mCurrentTeamViewTemplate_GameObject == nil) then
        this.mCurrentTeamViewTemplate_GameObject = this:GetCurComp("WidgetRoot/FrameGroup", "GameObject");
    end
    return this.mCurrentTeamViewTemplate_GameObject;
end

function UITeamPanel:GetBtnCreate_GameObject()
    if (this.mBtnCreate_GameObject == nil) then
        this.mBtnCreate_GameObject = this:GetCurComp("WidgetRoot/events/btn_creation", "GameObject");
    end
    return this.mBtnCreate_GameObject;
end

function UITeamPanel:GetBtnQuit_GameObject()
    if (this.mBtnQuit_GameObject == nil) then
        this.mBtnQuit_GameObject = this:GetCurComp("WidgetRoot/events/btn_quit", "GameObject");
    end
    return this.mBtnQuit_GameObject;
end

function UITeamPanel:GetBtnDissolve_GameObject()
    if (this.mBtnDissolve_GameObject == nil) then
        this.mBtnDissolve_GameObject = this:GetCurComp("WidgetRoot/events/btn_dissolve", "GameObject")
    end
    return this.mBtnDissolve_GameObject;
end

function UITeamPanel:GetBtnTeamReq_GameObject()
    if (this.mBtnTeamReq_GameObject == nil) then
        this.mBtnTeamReq_GameObject = this:GetCurComp("WidgetRoot/events/btn_teamrequest", "GameObject")
    end
    return this.mBtnTeamReq_GameObject;
end

function UITeamPanel:GetOtherTeamType_GameObject()
    if (this.mOtherTeamType_GameObject == nil) then
        this.mOtherTeamType_GameObject = this:GetCurComp("WidgetRoot/events/TypeTemp/teamType", "GameObject");
    end
    return this.mOtherTeamType_GameObject;
end

--endregion

function UITeamPanel:GetOtherTeamType_Text()
    if (this.mOtherTeamType_Text == nil) then
        this.mOtherTeamType_Text = this:GetCurComp("WidgetRoot/events/TypeTemp/teamType/CaptionLabel", "UILabel");
    end
    return this.mOtherTeamType_Text;
end

function UITeamPanel:GetTeamViewTemplate()
    if (this.mTeamViewTemplate == nil) then
        this.mTeamViewTemplate = templatemanager.GetNewTemplate(this:GetTeamViewTemplate_GameObject(), luaComponentTemplates.UITeamViewTemplate, self);
    end
    return this.mTeamViewTemplate;
end

---@return UICurrentTeamViewTemplate
function UITeamPanel:GetCurrentTeamViewTemplate()
    if (this.mCurrentTeamViewTemplate == nil) then
        this.mCurrentTeamViewTemplate = templatemanager.GetNewTemplate(this:GetCurrentTeamViewTemplate_GameObject(), luaComponentTemplates.UICurrentTeamViewTemplate);
    end
    return this.mCurrentTeamViewTemplate;
end

function UITeamPanel:GetUIDropDownComponent()
    if (this.mUIDropDownComponent == nil) then
        this.mUIDropDownComponent = this:GetCurComp("WidgetRoot/events/TypeTemp/DropDown", "Top_UIDropDown");
    end
    return this.mUIDropDownComponent;
end

--endregion

--region Method

--region CallFunction

function UITeamPanel.OnResGroupDetailedInfoMessage(msgId, msgData)
    this:UpdateTeamPanel();
end

function UITeamPanel.OnTeamStateChange()
    this:UpdateTeamPanel();
end

function UITeamPanel:OnTeamReqButtonClick()
    local count = CS.CSScene.MainPlayerInfo.GroupInfoV2.ApplyList.Count + CS.CSScene.MainPlayerInfo.GroupInfoV2.InvitationPlayerList.Count;
    if (count > 0) then
        uimanager:CreatePanel("UIJoinTeamPanel");
    else
        Utility.ShowPopoTips(this:GetBtnTeamReq_GameObject().transform, nil, 293, "UITeamPanel");
    end
end

--endregion

--region CallFunction

function UITeamPanel:OnTeamReqDropDownUnitClick(string)
    local teamReqType = this.mTeamReqStringDic[string];
    if (teamReqType ~= nil) then
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            networkRequest.ReqShareCommon(luaEnumReqServerCommonType.GROUP_CAPTION_SET_ALLOW_MODE, teamReqType);
        else
            networkRequest.ReqCommon(luaEnumReqServerCommonType.GROUP_CAPTION_SET_ALLOW_MODE, teamReqType);
        end
    end
end

function UITeamPanel:OnTeamJoinDropDownUnitClick(string)
    local teamJoinType = this.mTeamJoinStringDic[string];
    if (teamJoinType ~= nil) then
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            networkRequest.ReqShareCommon(luaEnumReqServerCommonType.GROUP_MEMBER_SET_ALLOW_MODE, teamJoinType);
        else
            networkRequest.ReqCommon(luaEnumReqServerCommonType.GROUP_MEMBER_SET_ALLOW_MODE, teamJoinType);
        end
    end
end

--endregion

--region Public

function UITeamPanel:UpdateTeamPanel()
    self:ClearData()
    if (CS.CSScene.MainPlayerInfo.GroupInfoV2.IsHaveGroup) then
        this:GetTeamViewTemplate_GameObject():SetActive(false);
        this:GetCurrentTeamViewTemplate_GameObject():SetActive(true);
        this:GetCurrentTeamViewTemplate():UpdateView();
    else
        this:GetTeamViewTemplate_GameObject():SetActive(true);
        this:GetCurrentTeamViewTemplate_GameObject():SetActive(false);
        this:GetTeamViewTemplate():UpdateView();
    end
    this:UpdateShowButton();
end

function UITeamPanel:UpdateShowButton()
    local hasGroup = CS.CSScene.MainPlayerInfo.GroupInfoV2.IsHaveGroup;
    local isCaptain = CS.CSScene.MainPlayerInfo.GroupInfoV2.IsCaptain
    this:GetBtnCreate_GameObject():SetActive(not hasGroup)
    this:GetBtnQuit_GameObject():SetActive(hasGroup);
    --this:GetBtnDissolve_GameObject():SetActive(hasGroup and CS.CSScene.MainPlayerInfo.GroupInfoV2.IsCaptain);
    this:GetBtnTeamReq_GameObject():SetActive((hasGroup and isCaptain))
    if (this:GetBtnTeamReq_GameObject().activeSelf) then
        this:GetUIDropDownComponent().transform.parent.localPosition = CS.UnityEngine.Vector3(400, -55, 0);
    else
        this:GetUIDropDownComponent().transform.parent.localPosition = CS.UnityEngine.Vector3(560, -55, 0);
    end
    this:GetUIDropDownComponent().OnValueChange:Clear();

    if (hasGroup) then
        this:GetUIDropDownComponent().gameObject:SetActive(isCaptain);
        this:GetOtherTeamType_GameObject():SetActive(not isCaptain);

        local teamReqTypeStrings = {};
        table.insert(teamReqTypeStrings, Utility.GetTeamReqTypeString(LuaEnumTeamReqType.UnionAutoJoin));
        table.insert(teamReqTypeStrings, Utility.GetTeamReqTypeString(LuaEnumTeamReqType.TeamLeaderReview));
        local type = CS.CSScene.MainPlayerInfo.GroupInfoV2.GroupInfo.captainAllowMode;
        if (type == nil) then
            type = LuaEnumTeamReqType.TeamLeaderReview;
        end
        if (isCaptain) then
            this:GetUIDropDownComponent():SetOptions(teamReqTypeStrings);
            this:GetUIDropDownComponent():SetCaptionLabel(teamReqTypeStrings[type]);
            this:GetUIDropDownComponent().OnValueChange:Add(function(params)
                this:OnTeamReqDropDownUnitClick(params.Label);
            end);
        else
            this:GetOtherTeamType_Text().text = teamReqTypeStrings[type];
        end
    else
        this:GetUIDropDownComponent().gameObject:SetActive(true);
        this:GetOtherTeamType_GameObject():SetActive(false);
        local teamJoinTypeStrings = {};
        table.insert(teamJoinTypeStrings, Utility.GetTeamJoinTypeString(LuaEnumTeamJoinType.UnionAutoJoin));
        table.insert(teamJoinTypeStrings, Utility.GetTeamJoinTypeString(LuaEnumTeamJoinType.AnyAutoJoin));
        table.insert(teamJoinTypeStrings, Utility.GetTeamJoinTypeString(LuaEnumTeamJoinType.NeedVerify));
        this:GetUIDropDownComponent():SetOptions(teamJoinTypeStrings);
        local type = CS.CSScene.MainPlayerInfo.Data.groupMemberAllowMode;
        if (type == nil) then
            type = LuaEnumTeamJoinType.NeedVerify;
        end
        this:GetUIDropDownComponent():SetCaptionLabel(teamJoinTypeStrings[type]);
        this:GetUIDropDownComponent().OnValueChange:Add(function(params)
            this:OnTeamJoinDropDownUnitClick(params.Label);
        end);
    end
end

--endregion

--region Private

function UITeamPanel:Initialize()
    this.UIMainChatPanel = uimanager:GetPanel("UIMainChatPanel")
    if (this.UIMainChatPanel ~= nil) then
        this.UIMainChatPanel.mCurChoosePanel = LuaEnumSocialPanelType.TeamPanel
        this.UIMainChatPanel.SocialBtnCanClick = false
        this.UIMainChatPanel.UIOpenIsShow()
    end

    if (this.mTeamReqStringDic == nil) then
        this.mTeamReqStringDic = {};
        this.mTeamReqStringDic[Utility.GetTeamReqTypeString(LuaEnumTeamReqType.UnionAutoJoin)] = LuaEnumTeamReqType.UnionAutoJoin;
        this.mTeamReqStringDic[Utility.GetTeamReqTypeString(LuaEnumTeamReqType.TeamLeaderReview)] = LuaEnumTeamReqType.TeamLeaderReview;
    end

    if (this.mTeamJoinStringDic == nil) then
        this.mTeamJoinStringDic = {};
        this.mTeamJoinStringDic[Utility.GetTeamJoinTypeString(LuaEnumTeamJoinType.UnionAutoJoin)] = LuaEnumTeamJoinType.UnionAutoJoin;
        this.mTeamJoinStringDic[Utility.GetTeamJoinTypeString(LuaEnumTeamJoinType.AnyAutoJoin)] = LuaEnumTeamJoinType.AnyAutoJoin;
        this.mTeamJoinStringDic[Utility.GetTeamJoinTypeString(LuaEnumTeamJoinType.NeedVerify)] = LuaEnumTeamJoinType.NeedVerify;
    end
end

function UITeamPanel:InitEvents()
    --region NetEvents
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGroupDetailedInfoMessage, this.OnResGroupDetailedInfoMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResShareGroupDetailedInfoMessage, this.OnResGroupDetailedInfoMessage)
    --endregion

    --region ClientEvents
    UITeamPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_TeamStatuChange, this.OnTeamStateChange);
    --endregion

    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UITeamPanel");
    end

    CS.UIEventListener.Get(this:GetBtnTeamReq_GameObject()).onClick = function()
        this:OnTeamReqButtonClick();
    end

    CS.UIEventListener.Get(this:GetBtnCreate_GameObject()).onClick = function(go)
        local mapId = CS.CSScene.getMapID()
        local meetLYMJ = CS.Cfg_GlobalTableManager.Instance:IsLangYanMengJingMap(mapId)
        if meetLYMJ then
            Utility.ShowPopoTips(go, nil, 280, "UITeamPanel")
            return
        end
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            networkRequest.ReqShareCreatGroup()
        else
            networkRequest.ReqCreatGroup()
        end
    end

    CS.UIEventListener.Get(this:GetBtnDissolve_GameObject()).onClick = function()
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            networkRequest.ReqShareDissolveGroup();
        else
            networkRequest.ReqDissolveGroup();
        end
    end

    CS.UIEventListener.Get(this:GetBtnQuit_GameObject()).onClick = function()
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            networkRequest.ReqShareExitGroup(CS.CSScene.MainPlayerInfo.ID)
        else
            networkRequest.ReqExitGroup(CS.CSScene.MainPlayerInfo.ID);
        end
        CS.CSScene.MainPlayerInfo.GroupInfoV2:OnClearList();
    end
end

function UITeamPanel:RemoveEvents()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResGroupDetailedInfoMessage, this.OnResGroupDetailedInfoMessage);
    UITeamPanel:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_TeamStatuChange, this.OnTeamStateChange);
end

--endregion

--endregion

function UITeamPanel:Init()
    this = self;
    this:Initialize();
    this:InitEvents();
end

function UITeamPanel:Show(customData)
    this:UpdateTeamPanel();
    ---打开面板时清除一次队伍数据，避免服务器没返回还显示原来的队伍信息
    CS.CSScene.MainPlayerInfo.GroupInfoV2:ClearTeamData()
    if (customData == nil) then
        customData = {};
    end

    if (customData.type == nil) then
        customData.type = LuaEnumTeamPanelType.Normal;
    end
    if (customData.type == LuaEnumTeamPanelType.TeamReq) then
        if (this:GetBtnTeamReq_GameObject().activeSelf) then
            this:OnTeamReqButtonClick();
        end
    end
end

function UITeamPanel:ClearData()
    CS.CSScene.MainPlayerInfo.GroupInfoV2:ClearTeamData()
end

function ondestroy()
    if (this.UIMainChatPanel ~= nil) then
        if (not this.UIMainChatPanel.InnerClosePanel) then
            this.UIMainChatPanel.UIOpenIsHide()
        end
        this.UIMainChatPanel.InnerClosePanel = false
        this.UIMainChatPanel.SocialBtnCanClick = true
    end

    this:RemoveEvents();
    this = nil;
    UITeamPanel:ClearData()
end

return UITeamPanel;