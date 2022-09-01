---@class UIHeartSkillPanel
local UIHeartSkillPanel = {};

local this = nil;

UIHeartSkillPanel.mSelectType = nil;

--region Component

--region GameObject

function UIHeartSkillPanel:GetHeartSkillTemplate_GameObject()
    if this.mSecretSkillTemplate_GameObject == nil then
        this.mSecretSkillTemplate_GameObject = this:GetCurComp('WidgetRoot/UIHeartSkillPanel', 'GameObject')
    end
    return this.mSecretSkillTemplate_GameObject
end

function UIHeartSkillPanel:GetBtnClose_GameObject()
    if (this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp('WidgetRoot/events/btn_close', 'GameObject')
    end
    return this.mBtnClose_GameObject;
end

--function UIHeartSkillPanel:GetBtnHelp_GameObject()
--    if(this.mBtnHelp_GameObject == nil) then
--        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/UIHeartSkillPanel/UIHeartSkillFormationPanel/events/btn_help","GameObject");
--    end
--    return this.mBtnClose_GameObject;
--end

--endregion

---@return UIHeartSkillViewTemplate
function UIHeartSkillPanel:GetHeartSkillTemplate()
    if this.mUISecretSkillTemplate == nil then
        this.mUISecretSkillTemplate = templatemanager.GetNewTemplate(this:GetHeartSkillTemplate_GameObject(), luaComponentTemplates.UIHeartSkillViewTemplate, self)
    end
    return this.mUISecretSkillTemplate
end

--endregion

--region Method

--region CallFunction

function UIHeartSkillPanel.OnClickBtnClose()
    uimanager:ClosePanel("UIHeartSkillPanel");
end

--endregion

--region Public

function UIHeartSkillPanel:ShowPanel(showType)

    if (showType == nil) then
        showType = LuaEnumHeartSkillShowType.HeartSkill;
    end

    this.mSelectType = showType;
    if (this.mSelectType == LuaEnumHeartSkillShowType.HeartSkill) then
        this:GetHeartSkillTemplate():ShowHeartSkill();
        CS.CSScene.MainPlayerInfo.SkillInfoV2:SetDefaultHeartSkillType()
        this:GetHeartSkillTemplate_GameObject().transform.localPosition = CS.UnityEngine.Vector3(440, 0, 0);
    elseif (this.mSelectType == LuaEnumHeartSkillShowType.HeartFormation) then
        this:GetHeartSkillTemplate():ShowSkillFormation();
        this:GetHeartSkillTemplate_GameObject().transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0);
    end
end

function UIHeartSkillPanel.OnMainPanelBagClicked()
    uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.HeartSkill })
end
--endregion

--region Private

function UIHeartSkillPanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = this.OnClickBtnClose;
    --CS.UIEventListener.Get(this:GetBtnHelp_GameObject()).onClick = function()
    --    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance:TryGetValue(43)
    --    if isFind then
    --        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    --    end
    --end

    this.CallOnResSecretBackMessage = function(msgId, msgData)
        if (this.mSelectType == LuaEnumHeartSkillShowType.HeartSkill) then
            CS.CSScene.MainPlayerInfo.SkillInfoV2:SetDefaultHeartSkillType()
        else
            if (msgData.upOrDown == 1) then
                this:GetHeartSkillTemplate():GetHeartSkillFormationTemplate():PlayUseEffect(msgData.type)
            end
        end
    end

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSecretBackMessage, this.CallOnResSecretBackMessage)

    this.CallOnResSwitchFormationMessage = function(msgId, msgData)
        this:GetHeartSkillTemplate():GetHeartSkillFormationTemplate():PlayUseFormationEffect(msgData.form ~= 0)
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSwitchFormationMessage, this.CallOnResSwitchFormationMessage)

    this.CallOnMainChatPanelBtnBag = function(msgId, msgData)
        if (this.mSelectType == LuaEnumHeartSkillShowType.HeartFormation) then
            uimanager:ClosePanel("UIHeartSkillPanel");
            uimanager:CreatePanel("UIBagPanel");
        else
            UIHeartSkillPanel.OnMainPanelBagClicked()
        end
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_BtnBag, this.CallOnMainChatPanelBtnBag)
end

function UIHeartSkillPanel:RemoveEvents()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResSecretBackMessage, this.CallOnResSecretBackMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResSwitchFormationMessage, this.CallOnResSwitchFormationMessage);
    --luaEventManager.RemoveCallback(LuaCEvent.MainChatPanel_BtnBag, this.CallOnMainChatPanelBtnBag);
    --luaEventManager.RemoveCallback(LuaCEvent.MainChatPanel_BtnBag, this.OnMainPanelBagClicked)
end

--endregion

--endregion

function UIHeartSkillPanel:Init()
    this = self;
    CS.CSScene.MainPlayerInfo.SkillInfoV2:SetDefaultHeartSkillType()
    this:InitEvents();
end

---@param customData.type LuaEnumHeartSkillShowType
function UIHeartSkillPanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end
    if (customData.type == nil) then
        customData.type = LuaEnumHeartSkillShowType.HeartSkill;
    end

    this:ShowPanel(customData.type);
    if uimanager:GetPanel("UIBagPanel") ~= nil then
        UIHeartSkillPanel.OnMainPanelBagClicked()
    end
end

--function update()
--    this:GetHeartSkillTemplate():OnUpdate();
--end

function ondestroy()
    this:RemoveEvents();
end

return UIHeartSkillPanel;