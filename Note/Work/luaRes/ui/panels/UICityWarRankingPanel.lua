---@class UICityWarRankingPanel:UIBase
local UICityWarRankingPanel = {};

UICityWarRankingPanel.mSelectType = nil;

--region Components

function UICityWarRankingPanel:GetFirstTitle_GameObject()
    if(self.mFirstTitle_GameObject == nil) then
        self.mFirstTitle_GameObject = self:GetCurComp("WidgetRoot/Panel/Titles/Title1", "GameObject");
    end
    return self.mFirstTitle_GameObject;
end

function UICityWarRankingPanel:GetSecondTitle_GameObject()
    if(self.mSecondTitle_GameObject == nil) then
        self.mSecondTitle_GameObject = self:GetCurComp("WidgetRoot/Panel/Titles/Title2", "GameObject");
    end
    return self.mSecondTitle_GameObject;
end

function UICityWarRankingPanel:GetBtnHelp_GameObject()
    if(self.mBtnHelp_GameObject == nil) then
        self.mBtnHelp_GameObject = self:GetCurComp("WidgetRoot/event/btn_help", "GameObject");
    end
    return self.mBtnHelp_GameObject;
end

function UICityWarRankingPanel:GetBtnClose_GameObject()
    if(self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/event/CloseBtn","GameObject")
    end
    return self.mBtnClose_GameObject;
end

function UICityWarRankingPanel:GetCityWarRankingViewTemplate_GameObject()
    if(self.mCityWarRankingViewTemplate_GameObject == nil) then
        self.mCityWarRankingViewTemplate_GameObject = self:GetCurComp("WidgetRoot/Panel/ScrollView","GameObject");
    end
    return self.mCityWarRankingViewTemplate_GameObject;
end

function UICityWarRankingPanel:GetCityWarLossRankingViewTemplate_GameObject()
    if(self.mCityWarLossRankingViewTemplate_GameObject == nil) then
        self.mCityWarLossRankingViewTemplate_GameObject = self:GetCurComp("WidgetRoot/Panel/LossScrollView","GameObject");
    end
    return self.mCityWarLossRankingViewTemplate_GameObject;
end

function UICityWarRankingPanel:GetCityWarSelfRankingUnitTemplate_GameObject()
    if(self.mCityWarSelfRankingUnitTemplate_GameObject == nil) then
        self.mCityWarSelfRankingUnitTemplate_GameObject = self:GetCurComp("WidgetRoot/Panel/myRankData","GameObject");
    end
    return self.mCityWarSelfRankingUnitTemplate_GameObject;
end

--function UICityWarRankingPanel:GetTglKill_UIToggle()
--    if(self.mTglKill_UIToggle == nil) then
--        self.mTglKill_UIToggle = self:GetCurComp("WidgetRoot/event/KillingBtn","UIToggle");
--    end
--    return self.mTglKill_UIToggle;
--end
--
--function UICityWarRankingPanel:GetTglDefence_UIToggle()
--    if(self.mTglDefence_UIToggle == nil) then
--        self.mTglDefence_UIToggle = self:GetCurComp("WidgetRoot/event/DefenceBtn","UIToggle");
--    end
--    return self.mTglDefence_UIToggle;
--end
--
--function UICityWarRankingPanel:GetTglDamage_UIToggle()
--    if(self.mTglDamage_UIToggle == nil) then
--        self.mTglDamage_UIToggle = self:GetCurComp("WidgetRoot/event/DamageBtn","UIToggle");
--    end
--    return self.mTglDamage_UIToggle;
--end

function UICityWarRankingPanel:GetFirstTitleDieOrKill_UILabel()
    if(self.mFirstTitleDieOrKill_UILabel == nil) then
        self.mFirstTitleDieOrKill_UILabel = self:GetCurComp("WidgetRoot/Panel/Titles/Title1/dieOrKill","UILabel");
    end
    return self.mFirstTitleDieOrKill_UILabel;
end

function UICityWarRankingPanel:GetCityWarRankingViewTemplate()
    if(self.mCityWarRankingViewTemplate == nil) then
        self.mCityWarRankingViewTemplate = templatemanager.GetNewTemplate(self:GetCityWarRankingViewTemplate_GameObject(), luaComponentTemplates.UICityWarRankingViewTemplate);
    end
    return self.mCityWarRankingViewTemplate;
end

function UICityWarRankingPanel:GetCityWarLossRankingViewTemplate()
    if(self.mCityWarLossRankingViewTemplate == nil) then
        self.mCityWarLossRankingViewTemplate = templatemanager.GetNewTemplate(self:GetCityWarLossRankingViewTemplate_GameObject(), luaComponentTemplates.UICityWarLossRankingViewTemplate);
    end
    return self.mCityWarLossRankingViewTemplate;
end

function UICityWarRankingPanel:GetCityWarSelfRankingUnitTemplate()
    if(self.mCityWarSelfRankingUnitTemplate == nil) then
        self.mCityWarSelfRankingUnitTemplate = templatemanager.GetNewTemplate(self:GetCityWarSelfRankingUnitTemplate_GameObject(),luaComponentTemplates.UICityWarSelfRankingUnitTemplate)
    end
    return self.mCityWarSelfRankingUnitTemplate
end

--endregion

--region Method

--region CallFunction

--function UICityWarRankingPanel:OnResSabacRankInfoMessageReceived(msgData)
--    if(msgData.type == Utility.EnumToInt(CS.duplicateV2.SabacRankType.Lose)) then
--        self:GetCityWarLossRankingViewTemplate():UpdateView(msgData.type);
--    else
--        self:GetCityWarRankingViewTemplate():UpdateView(msgData.type);
--    end
--
--    local selfRankVo =  CS.CSScene.MainPlayerInfo.DuplicateV2:GetSelfRankVo(self.mSelectType);
--    self:GetCityWarSelfRankingUnitTemplate_GameObject():SetActive(selfRankVo ~= nil);
--    if(selfRankVo ~= nil) then
--        self:GetCityWarSelfRankingUnitTemplate():UpdateUnit(selfRankVo, self.mSelectType);
--    end
--end

---@param msgData duplicateV2.ResSabacRankInfo
function UICityWarRankingPanel:OnResSabacPersonalRankInfoMessage(msgData)
    self:UpdateUI();
end

--endregion

--region Public

--function UICityWarRankingPanel:UpdateTitles()
--    if(self.mSelectType == Utility.EnumToInt(CS.duplicateV2.SabacRankType.Kill)) then
--        self:GetFirstTitle_GameObject():SetActive(true);
--        self:GetSecondTitle_GameObject():SetActive(false);
--        self:GetFirstTitleDieOrKill_UILabel().text = "击杀";
--    elseif(self.mSelectType == Utility.EnumToInt(CS.duplicateV2.SabacRankType.Guard)) then
--        self:GetFirstTitle_GameObject():SetActive(true);
--        self:GetSecondTitle_GameObject():SetActive(false);
--        self:GetFirstTitleDieOrKill_UILabel().text = "死亡";
--    else
--        self:GetFirstTitle_GameObject():SetActive(false);
--        self:GetSecondTitle_GameObject():SetActive(true);
--    end
--end

function UICityWarRankingPanel:UpdateUI()
    self:GetCityWarRankingViewTemplate():ResetLoopScrollView();
    self:GetCityWarLossRankingViewTemplate():ResetLoopScrollView();
    self:GetCityWarRankingViewTemplate():UpdateView(0);
end

--function UICityWarRankingPanel:SelectWithType(type)
--    local CSType = CS.duplicateV2.SabacRankType.Kill;
--    if(type == LuaEnumCityWarPanelType.KillPanel) then
--        CSType = CS.duplicateV2.SabacRankType.Kill;
--        self:GetTglKill_UIToggle().isChecked = true;
--    elseif(type == LuaEnumCityWarPanelType.Defence)  then
--        CSType = CS.duplicateV2.SabacRankType.Guard;
--        self:GetTglDefence_UIToggle().isChecked = true;
--    elseif(type == LuaEnumCityWarPanelType.Damage)  then
--        CSType = CS.duplicateV2.SabacRankType.Lose;
--        self:GetTglDamage_UIToggle().isChecked = true;
--    end
--    self.mSelectType = type;
--    self:UpdateTitles();
--    self:GetCityWarRankingViewTemplate():ResetLoopScrollView();
--    self:GetCityWarLossRankingViewTemplate():ResetLoopScrollView();
--    networkRequest.ReqGetSabacRankInfo(Utility.EnumToInt(CSType), 1, uiStaticParameter.mShaBaKRankOnePageCount);
--end

--endregion

--region Private

function UICityWarRankingPanel:InitEvents()
    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UICityWarRankingPanel");
    end

    CS.UIEventListener.Get(self:GetBtnHelp_GameObject()).onClick = function()
        local isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(81)
        if isFind then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
        end
    end

    --CS.UIEventListener.Get(self:GetTglKill_UIToggle().gameObject).onClick = function()
    --    self:SelectWithType(LuaEnumCityWarPanelType.KillPanel);
    --end
    --
    --CS.UIEventListener.Get(self:GetTglDefence_UIToggle().gameObject).onClick = function()
    --    self:SelectWithType(LuaEnumCityWarPanelType.Defence);
    --end
    --
    --CS.UIEventListener.Get(self:GetTglDamage_UIToggle().gameObject).onClick = function()
    --    self:SelectWithType(LuaEnumCityWarPanelType.Damage);
    --end

    --self.CallOnResSabacRankInfoMessageReceived = function(msgId, msgData)
    --    self:OnResSabacRankInfoMessageReceived(msgData);
    --end
    --self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSabacRankInfoMessage, self.CallOnResSabacRankInfoMessageReceived)

    self.CallOnResSabacPersonalRankInfoMessage = function(msgId, msgData)
        self:OnResSabacPersonalRankInfoMessage(msgData);
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSabacPersonalRankInfoMessage, self.CallOnResSabacPersonalRankInfoMessage)
end
--endregion

--endregion

function UICityWarRankingPanel:Init()
    self:InitEvents();
end

function UICityWarRankingPanel:Show(customData)
    if(customData == nil) then
        customData = {};
    end

    --if(customData.type == nil) then
    --    customData.type = LuaEnumCityWarPanelType.KillPanel;
    --end

    --self:SelectWithType(customData.type);

    networkRequest.ReqGetSabacPersonalRankInfo(0,1,50);
end

return UICityWarRankingPanel;