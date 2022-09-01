local UIAutoTeamTipsPanel = {};

UIAutoTeamTipsPanel.mAutoTeamVo = nil;

--region Components

function UIAutoTeamTipsPanel:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/events/close", "GameObject");
    end
    return self.mBtnClose_GameObject;
end

function UIAutoTeamTipsPanel:GetBtnJoinTeam_GameObject()
    if (self.mBtnJoinTeam_GameObject == nil) then
        self.mBtnJoinTeam_GameObject = self:GetCurComp("WidgetRoot/events/btnJoinTeam", "GameObject");
    end
    return self.mBtnJoinTeam_GameObject;
end

function UIAutoTeamTipsPanel:GetBtnPlunder_GameObject()
    if (self.mBtnPlunder_GameObject == nil) then
        self.mBtnPlunder_GameObject = self:GetCurComp("WidgetRoot/events/btnPlunder", "GameObject");
    end
    return self.mBtnPlunder_GameObject;
end

function UIAutoTeamTipsPanel:GetBtnChangeModel_GameObject()
    if (self.mBtnChangeModel_GameObject == nil) then
        self.mBtnChangeModel_GameObject = self:GetCurComp("WidgetRoot/events/btnChangeModel", "GameObject");
    end
    return self.mBtnChangeModel_GameObject;
end

function UIAutoTeamTipsPanel:GetTipsContent_Text()
    if (self.mTipsContent_Text == nil) then
        self.mTipsContent_Text = self:GetCurComp("WidgetRoot/view/Content", "UILabel")
    end
    return self.mTipsContent_Text;
end

---下次不再提示的toggle
---@return UIToggle
function UIAutoTeamTipsPanel:GetDoNotHintAgain_UIToggle()
    if self.mDoNotHintAgain_UIToggle == nil then
        self.mDoNotHintAgain_UIToggle = self:GetCurComp("WidgetRoot/view/toggle_value", "UIToggle")
    end
    return self.mDoNotHintAgain_UIToggle
end
--endregion

--region Method

--region Public

function UIAutoTeamTipsPanel:UpdateUI()
    if (self.mAutoTeamVo ~= nil) then
        self:GetTipsContent_Text().text = self:GetContentString();
        self:UpdateButtonState();
    else
        uimanager:ClosePanel("UIAutoTeamTipsPanel");
    end
end

function UIAutoTeamTipsPanel:UpdateButtonState()
    if (self.mAutoTeamVo ~= nil) then
        if (self.mAutoTeamVo.state == Utility.EnumToInt(CS.AutomaticTeamState.ALLHAVETEAMS)
                or self.mAutoTeamVo.state == Utility.EnumToInt(CS.AutomaticTeamState.ALLNOTHAVETEAMS)
                or self.mAutoTeamVo.state == Utility.EnumToInt(CS.AutomaticTeamState.MEHAVETEAM)
                or self.mAutoTeamVo.state == Utility.EnumToInt(CS.AutomaticTeamState.OTHERHASTEAM)) then
            self:GetBtnChangeModel_GameObject():SetActive(false);
            self:GetBtnPlunder_GameObject():SetActive(false);
            self:GetBtnJoinTeam_GameObject():SetActive(true);
            self:GetBtnJoinTeam_GameObject().transform.localPosition = CS.UnityEngine.Vector3(0, -35, 0);
        elseif (self.mAutoTeamVo.state == Utility.EnumToInt(CS.AutomaticTeamState.JOIN_OR_CHANGEPKMODEL)) then
            self:GetBtnChangeModel_GameObject():SetActive(true);
            self:GetBtnPlunder_GameObject():SetActive(false);
            self:GetBtnJoinTeam_GameObject():SetActive(true);
            self:GetBtnJoinTeam_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-90, -35, 0);
            self:GetBtnChangeModel_GameObject().transform.localPosition = CS.UnityEngine.Vector3(90, -35, 0);
        elseif (self.mAutoTeamVo.state == Utility.EnumToInt(CS.AutomaticTeamState.JOIN_REFUSE_CHANGEPKMODEL)) then
            self:GetBtnChangeModel_GameObject():SetActive(true);
            self:GetBtnPlunder_GameObject():SetActive(false);
            self:GetBtnJoinTeam_GameObject():SetActive(false);
            self:GetBtnChangeModel_GameObject().transform.localPosition = CS.UnityEngine.Vector3(0, -35, 0);
        elseif (self.mAutoTeamVo.state == Utility.EnumToInt(CS.AutomaticTeamState.JOIN_OR_FIGHT)) then
            self:GetBtnChangeModel_GameObject():SetActive(false);
            self:GetBtnPlunder_GameObject():SetActive(true);
            self:GetBtnJoinTeam_GameObject():SetActive(true);
            self:GetBtnJoinTeam_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-90, -35, 0);
            self:GetBtnPlunder_GameObject().transform.localPosition = CS.UnityEngine.Vector3(90, -35, 0);
        elseif (self.mAutoTeamVo.state == Utility.EnumToInt(CS.AutomaticTeamState.JOIN_REFUSE_FIGHT)) then
            self:GetBtnChangeModel_GameObject():SetActive(false);
            self:GetBtnPlunder_GameObject():SetActive(true);
            self:GetBtnJoinTeam_GameObject():SetActive(false);
            self:GetBtnPlunder_GameObject().transform.localPosition = CS.UnityEngine.Vector3(0, -35, 0);
        end
    end
end

--endregion

--region Private

function UIAutoTeamTipsPanel:GetContentString()
    if (self.mAutoTeamVo ~= nil) then
        return CS.Cfg_GlobalTableManager.Instance:GetAutoTeamContentString(self.mAutoTeamVo.state, self.mAutoTeamVo);
    end
    return "是否加入目标队伍";
end

function UIAutoTeamTipsPanel:InitEvents()
    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIAutoTeamTipsPanel");
    end

    CS.UIEventListener.Get(self:GetBtnJoinTeam_GameObject()).onClick = function()
        if (self.mAutoTeamVo ~= nil) then
            local params = self.mAutoTeamVo:GetJoinTeamParam();
            if (params ~= 0 and params ~= nil) then
                if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                    networkRequest.ReqShareJoinGroup(params, 2);
                else
                    networkRequest.ReqJoinGroup(params, 2);
                end
            end
        end
        uimanager:ClosePanel("UIAutoTeamTipsPanel");
    end

    CS.UIEventListener.Get(self:GetBtnPlunder_GameObject()).onClick = function()
        if (self.mAutoTeamVo ~= nil) then
            local targetAvatar = CS.CSScene.Sington:getAvatar(self.mAutoTeamVo.targetPlayerId);
            CS.CSScene.Sington.MainPlayer.TouchEvent:SetTarget(targetAvatar);
            CS.CSAutoFightMgr.Instance:Toggle(true);
        end
        uimanager:ClosePanel("UIAutoTeamTipsPanel");
    end

    CS.UIEventListener.Get(self:GetBtnChangeModel_GameObject()).onClick = function()
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Role_Equip_Atr);
        uimanager:ClosePanel("UIAutoTeamTipsPanel");
    end

    self:GetDoNotHintAgain_UIToggle().gameObject:SetActive(true)
    self:GetDoNotHintAgain_UIToggle().value = uiStaticParameter.mAutoTeamTipsDoNotHintAgain == true
    CS.EventDelegate.Add(self:GetDoNotHintAgain_UIToggle().onChange, function()
        uiStaticParameter.mAutoTeamTipsDoNotHintAgain = self:GetDoNotHintAgain_UIToggle().value
    end)
end

function UIAutoTeamTipsPanel:RemoveEvents()

end

--endregion

--endregion

function UIAutoTeamTipsPanel:Init()
    self:InitEvents();
end

function UIAutoTeamTipsPanel:Show(customData)
    self.mAutoTeamVo = customData;
    self:UpdateUI();
end

function ondestroy()
    UIAutoTeamTipsPanel:RemoveEvents();
    if uiStaticParameter.mAutoTeamTipsDoNotHintAgain == true then
        ---若不需要提示,则清除提示
        Utility.RemoveFlashPrompt(1, 31)
    end
end

return UIAutoTeamTipsPanel;