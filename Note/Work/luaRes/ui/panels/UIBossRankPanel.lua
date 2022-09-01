---@class UIBossRankPanel:UIBase
local UIBossRankPanel = {};
local this = nil;

UIBossRankPanel.mBossId = 0;
UIBossRankPanel.mMonsterId = 0;
UIBossRankPanel.showTips_bool = true
--region Components

function UIBossRankPanel:GetWindowRoot_GameObject()
    if (this.mWindowRoot_GameObject == nil) then
        this.mWindowRoot_GameObject = this:GetCurComp("WidgetRoot/Tween/root", "GameObject");
    end
    return this.mWindowRoot_GameObject;
end

function UIBossRankPanel:GetBtnArrowEffect_GameObject()
    if (this.mBtnArrowEffect_GameObject == nil) then
        this.mBtnArrowEffect_GameObject = this:GetCurComp("WidgetRoot/Tween/events/BtnHide/arrowEffect", "GameObject");
    end
    return this.mBtnArrowEffect_GameObject;
end

function UIBossRankPanel:GetBtnReward_GameObject()
    if (this.mBtnReward_GameObject == nil) then
        this.mBtnReward_GameObject = this:GetCurComp("WidgetRoot/Tween/root/Panel/rewardlist", "GameObject");
    end
    return this.mBtnReward_GameObject;
end

function UIBossRankPanel:GetBtnClose_GameObject()
    if (this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/Tween/events/CloseBtn", "GameObject");
    end
    return this.mBtnClose_GameObject;
end

function UIBossRankPanel:GetHelpBtn_GameObject()
    if (this.mHelpBtn_GameObject == nil) then
        this.mHelpBtn_GameObject = this:GetCurComp("WidgetRoot/Tween/events/btn_help", "GameObject");
    end
    return this.mHelpBtn_GameObject;
end

function UIBossRankPanel:GetBossRankViewTemplate()
    if (this.mBossRankViewTemplate == nil) then
        this.mBossRankViewTemplate = templatemanager.GetNewTemplate(this:GetCurComp("WidgetRoot/Tween/root/Panel", "GameObject"), luaComponentTemplates.UIBossDamageRankViewTemplate)
    end
    return this.mBossRankViewTemplate;
end

function UIBossRankPanel:GetTween_TweenPosition()
    if (this.mTween_TweenPosition == nil) then
        this.mTween_TweenPosition = this:GetCurComp("WidgetRoot/Tween", "Top_TweenPosition");
    end
    return this.mTween_TweenPosition;
end

function UIBossRankPanel:GetHideBtn_GameObject()
    if (this.mHide_GameObject == nil) then
        this.mHide_GameObject = this:GetCurComp("WidgetRoot/Tween/events/BtnHide", "GameObject");
    end
    return this.mHide_GameObject;
end

function UIBossRankPanel:GetEndTime()
    if (self.mEndTime == nil) then
        self.mEndTime = self:GetCurComp("WidgetRoot/Tween/events/Time", "UICountdownLabel");
    end
    return self.mEndTime;
end

--endregion

--region Method

--region CallFunction

function UIBossRankPanel.OnResAncientBossDamageRankMessage()
    this:UpdateRank();
end

--endregion

--region Public

function UIBossRankPanel:UpdateRank()
    this:GetBossRankViewTemplate():UpdateView();
    self:RefreshEndTime()
end

--endregion

--region Private

function UIBossRankPanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIBossRankPanel");
    end
    CS.UIEventListener.Get(this:GetHelpBtn_GameObject()).onClick = function()
        this:OnClickHelpBtnCallBack();
    end
    CS.UIEventListener.Get(UIBossRankPanel:GetHideBtn_GameObject()).onClick = UIBossRankPanel.OnClickHideBtnCallBack

    CS.UIEventListener.Get(this:GetBtnReward_GameObject()).onClick = function()
        uimanager:CreatePanel("UIBossRankRewardPanel", nil, { monsterId = this.mMonsterId });
    end

    this.CallOnMainPlayerGetHurt = function(msgId, msgData)
        if (msgData ~= nil) then
            this:GetBossRankViewTemplate():UpdateCounterAttackTarget(msgData);
        end
    end
    this:GetClientEventHandler():AddEvent(CS.CEvent.OnMainPlayerGetHurt, this.CallOnMainPlayerGetHurt)

    this.CallOnSelectUnit = function(msgId, msgData)
        this:GetBossRankViewTemplate():OnMainPlayerSelectUnit();
    end
    this:GetClientEventHandler():AddEvent(CS.CEvent.V2_SelectUnit, this.CallOnSelectUnit)

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResAncientBossDamageRankMessage, this.OnResAncientBossDamageRankMessage)
end
--endregion

--endregion

function UIBossRankPanel:Init()
    ---@type UIBossRankPanel
    this = self;
    this:InitEvents();
end

function UIBossRankPanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end
    if (customData.targetBoss == nil) then
        uimanager:ClosePanel("UIBossRankPanel");
        return ;
    end
    if (this.mBossId ~= customData.targetBoss) then
        this.mBossId = customData.targetBoss;
        CS.CSScene.MainPlayerInfo.BossInfoV2:StartShowBossDamageRank(this.mBossId);
    end
    if (customData.monsterId ~= nil) then
        this.mMonsterId = customData.monsterId;
    end
    ---是否开启倒计时
    if (customData.isOpenCountdown ~= nil) then
        self.isOpenCountdown=customData.isOpenCountdown
    end
    ---倒计时结束时间
    if (customData.countdownEndTime ~= nil) then
        self.countdownEndTime=customData.countdownEndTime
    end

    self:UpdateRank();
end

function UIBossRankPanel:RefreshEndTime()
    local isshow=self.isOpenCountdown==true and  self.countdownEndTime~=0 and  self.countdownEndTime~=nil
    self:GetEndTime().gameObject:SetActive(isshow)
    if isshow then
        self:GetEndTime():StartCountDown(nil, 7, self.countdownEndTime, "", "")
    end
end

function UIBossRankPanel:OnClickHelpBtnCallBack()
    if (this.mMonsterId ~= nil) then
        ---改为配表
        local helpId = LuaGlobalTableDeal.GetAncientBossHelpId(this.mMonsterId)
        local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(helpId)
        if isFind then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
        end
    end
end

function UIBossRankPanel.OnClickHideBtnCallBack()
    UIBossRankPanel:GetTween_TweenPosition():SetOnFinished(UIBossRankPanel.ClinkHideBtnCallBack)
    if UIBossRankPanel.showTips_bool then
        UIBossRankPanel:GetTween_TweenPosition():PlayReverse()
        UIBossRankPanel.showTips_bool = false
    else
        UIBossRankPanel:GetTween_TweenPosition():PlayForward()
        UIBossRankPanel:GetWindowRoot_GameObject():SetActive(UIBossRankPanel.showTips_bool);
        UIBossRankPanel.showTips_bool = true
    end
end

function UIBossRankPanel.ClinkHideBtnCallBack()
    local v3 = CS.UnityEngine.Vector3.zero
    if not UIBossRankPanel.showTips_bool then
        v3.z = 180
        uimanager:ClosePanel("UIBossRankRewardPanel")
    end
    UIBossRankPanel:GetHideBtn_GameObject().transform.localEulerAngles = v3

    UIBossRankPanel:GetWindowRoot_GameObject():SetActive(UIBossRankPanel.showTips_bool);
end

function ondestroy()
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        CS.CSScene.MainPlayerInfo.BossInfoV2:StopShowBossDamageRank();
    end
    uimanager:ClosePanel("UIBossRankRewardPanel")
end

return UIBossRankPanel;