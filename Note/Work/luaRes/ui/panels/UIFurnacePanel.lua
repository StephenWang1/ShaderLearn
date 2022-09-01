---@class UIFurnacePanel:UIBase
local UIFurnacePanel = {}

UIFurnacePanel.selectId = LuaEnumFurnaceOpenType.ChyanLamp;
UIFurnacePanel.mRolePanel = nil

--region 组件
--region UIGameObject
function UIFurnacePanel.GetCloseBtn_GameObject()
    if UIFurnacePanel.mBtnCloseGO == nil then
        UIFurnacePanel.mBtnCloseGO = UIFurnacePanel:GetCurComp("WidgetRoot/events/Btn_Close", "GameObject")
    end
    return UIFurnacePanel.mBtnCloseGO
end

---@return UnityEngine.GameObject 帮助按钮
function UIFurnacePanel.GetBtnHelp_GameObject()
    if UIFurnacePanel.mBtnHelp == nil then
        UIFurnacePanel.mBtnHelp = UIFurnacePanel:GetCurComp("WidgetRoot/events/btn_help", "GameObject")
    end
    return UIFurnacePanel.mBtnHelp
end

function UIFurnacePanel.GetUIMainPanel_GameObject()
    if (UIFurnacePanel.mUIMainPanel_GameObject == nil) then
        UIFurnacePanel.mUIMainPanel_GameObject = UIFurnacePanel:GetCurComp("WidgetRoot/UIMainPanel", "GameObject");
    end
    return UIFurnacePanel.mUIMainPanel_GameObject;
end
--endregion

--region UILabel

--endregion

--region Template
--function UIFurnacePanel.GetUIFurnacePreViewContent()
--    if (UIFurnacePanel.mPreViewContent == nil) then
--        UIFurnacePanel.mPreViewContent = templatemanager.GetNewTemplate(UIFurnacePanel.GetUIItemsColumn_GameObject(), luaComponentTemplates.UIFurnacePreviewContentTemplate, self)
--    end
--    return UIFurnacePanel.mPreViewContent;
--end

--function UIFurnacePanel.GetFurnaceQuickShopViewTemplate()
--    if (UIFurnacePanel.mFurnaceQuickShopViewTemplate == nil) then
--        UIFurnacePanel.mFurnaceQuickShopViewTemplate = templatemanager.GetNewTemplate(UIFurnacePanel.GetUIBuyPanel_GameObject(), luaComponentTemplates.UIFurnaceQuickShopViewTemplate);
--    end
--    return UIFurnacePanel.mFurnaceQuickShopViewTemplate;
--end

---@return UIFurnaceViewTemplate
function UIFurnacePanel:GetFurnaceViewTemplate()
    if (self.mFurnaceViewTemplate == nil) then
        self.mFurnaceViewTemplate = templatemanager.GetNewTemplate(self.GetUIMainPanel_GameObject(), luaComponentTemplates.UIFurnaceViewTemplate, self);
    end
    return self.mFurnaceViewTemplate;
end
--endregion
--endregion

--region Method

--region CallFunction

function UIFurnacePanel.UpdateUI(msgId, msgData)
    local selectId = UIFurnacePanel.selectId;
    if (msgId == LuaEnumNetDef.ReslampUpgradeResMessage or msgId == LuaEnumNetDef.ResUpgradeSoulJadeMessage) then
        UIFurnacePanel:GetFurnaceViewTemplate():SetUIShowWithSelectId(selectId, true)
    else
        UIFurnacePanel:GetFurnaceViewTemplate():SetUIShowWithSelectId(selectId, false)
    end
    if (UIFurnacePanel.mRolePanel ~= nil) then
        UIFurnacePanel.mRolePanel.equipShow:RefreshGrid();
        --UIFurnacePanel.mRolePanel:SelectItemByEquipIndex(selectId);
    end
end

function UIFurnacePanel.OnClosePanelButtonClicked()
    uimanager:ClosePanel("UIFurnacePanel")
    uimanager:ClosePanel("UIRolePanel");
end

---帮助
function UIFurnacePanel.OnButtonClickHelp()
    local meetGem = UIFurnacePanel.selectId == LuaEnumFurnaceOpenType.Gem
    local meetSoulBead = UIFurnacePanel.selectId == LuaEnumFurnaceOpenType.SoulBead
    local meetChyanLamp = UIFurnacePanel.selectId == LuaEnumFurnaceOpenType.ChyanLamp
    local meetAttack = UIFurnacePanel.selectId == LuaEnumFurnaceOpenType.TheSourceOfAttack
    local helpId = meetGem and 32 or meetSoulBead and 29 or meetChyanLamp and 28 or meetAttack and 30 or 31
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(helpId)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end
---宝石
function UIFurnacePanel.OnToggleClickGem()
    UIFurnacePanel.SetShowWithSelectId(LuaEnumFurnaceOpenType.Gem);
end

---魂玉
function UIFurnacePanel.OnToggleClickSoulBead()
    UIFurnacePanel.SetShowWithSelectId(LuaEnumFurnaceOpenType.SoulBead);
end

---赤炎灯
function UIFurnacePanel.OnToggleClickChyanLamp()
    UIFurnacePanel.SetShowWithSelectId(LuaEnumFurnaceOpenType.ChyanLamp);
end

---进攻之源
function UIFurnacePanel.OnToggleClickTheSourceOfAttack()
    UIFurnacePanel.SetShowWithSelectId(LuaEnumFurnaceOpenType.TheSourceOfAttack);
end

---防守之源
function UIFurnacePanel.OnToggleClickTheSourceOfDefense()
    UIFurnacePanel.SetShowWithSelectId(LuaEnumFurnaceOpenType.TheSourceOfDefense);
end

function UIFurnacePanel.OnClickEquipShow()
    return ;
end

function UIFurnacePanel.RolePanelEquipGridRefresh()
    return ;
end
--endregion

function UIFurnacePanel.SetShowWithSelectId(selectId)
    UIFurnacePanel.selectId = selectId;
    UIFurnacePanel:GetFurnaceViewTemplate():SetUIShowWithSelectId(selectId);
    if UIFurnacePanel.mRolePanel and CS.StaticUtility.IsNull(UIFurnacePanel.mRolePanel.go) == false then
        local equipIndex = Utility.GetEquipIndexWithFurnacePanelId(UIFurnacePanel.selectId);
        if (equipIndex ~= nil) then
            UIFurnacePanel.mRolePanel:SelectItemByEquipIndex(equipIndex);
        end
    end
end

function UIFurnacePanel.InitEvents()
    --region Toggle
    --CS.UIEventListener.Get(UIFurnacePanel.GetBloodSignTgl_GameObject()).onClick = UIFurnacePanel.OnToggleClickBloodSign
    --CS.UIEventListener.Get(UIFurnacePanel.GetShieldTgl_GameObject()).onClick = UIFurnacePanel.OnToggleClickShield
    --CS.UIEventListener.Get(UIFurnacePanel.GetSoulBeadTgl_GameObject()).onClick = UIFurnacePanel.OnToggleClickSoulBead
    --CS.UIEventListener.Get(UIFurnacePanel.GetGemTgl_GameObject()).onClick = UIFurnacePanel.OnToggleClickGem
    --CS.UIEventListener.Get(UIFurnacePanel.GetJadeTgl_GameObject()).onClick = UIFurnacePanel.OnToggleClickJade
    --CS.UIEventListener.Get(UIFurnacePanel.GetChyanLampTgl_GameObject()).onClick = UIFurnacePanel.OnToggleClickChyanLamp
    --CS.UIEventListener.Get(UIFurnacePanel.GetTheSourceOfAttackTgl_GameObject()).onClick = UIFurnacePanel.OnToggleClickTheSourceOfAttack
    --CS.UIEventListener.Get(UIFurnacePanel.GetTheSourceOfDefenseTgl_GameObject()).onClick = UIFurnacePanel.OnToggleClickTheSourceOfDefense
    --endregion
    --region Button
    CS.UIEventListener.Get(UIFurnacePanel.GetCloseBtn_GameObject()).onClick = UIFurnacePanel.OnClosePanelButtonClicked
    CS.UIEventListener.Get(UIFurnacePanel.GetBtnHelp_GameObject()).onClick = UIFurnacePanel.OnButtonClickHelp
    --endregion

    UIFurnacePanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Role_EquipGridClicked, UIFurnacePanel.OnClickEquipShow)
    UIFurnacePanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Role_EquipGridRefresh, UIFurnacePanel.RolePanelEquipGridRefresh)
    --region NetEvents
    UIFurnacePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGodFurnaceUpGradeMessage, UIFurnacePanel.UpdateUI)
    UIFurnacePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ReslampUpgradeResMessage, UIFurnacePanel.UpdateUI)
    UIFurnacePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, UIFurnacePanel.UpdateUI)
    UIFurnacePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUpgradeSoulJadeMessage, UIFurnacePanel.UpdateUI)
    --endregion
end
--endregion

---@param customData.type LuaEnumFurnaceOpenType
function UIFurnacePanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end

    if (customData.type == nil) then
        customData.type = LuaEnumFurnaceOpenType.ChyanLamp;
    end

    customData.equipShowTemplate = luaComponentTemplates.UIRolePanel_EquipTemplateFurnace;
    customData.equipItemTemplate = luaComponentTemplates.UIRolePanel_GridTemplateFurnace;
    UIFurnacePanel.mCustomData = customData;
    UIFurnacePanel.mDelayShowUIRolePanel = 3
end

function update()
    if (UIFurnacePanel.mDelayShowUIRolePanel ~= nil) then
        UIFurnacePanel.mDelayShowUIRolePanel = UIFurnacePanel.mDelayShowUIRolePanel - 1
        if UIFurnacePanel.mDelayShowUIRolePanel == 0 then
            UIFurnacePanel.mDelayShowUIRolePanel = nil
            ---添加关联界面
            UIFurnacePanel:AddRelationPanel("UIRolePanel");
            uimanager:ClosePanel("UIBagPanel")
            uimanager:CreatePanel("UIRolePanel", function(panel)
                if (not CS.StaticUtility.IsNull(UIFurnacePanel.go)) then
                    UIFurnacePanel.mRolePanel = panel
                    panel:ShowCloseButton(false);
                    if UIFurnacePanel.mCustomData ~= nil then
                        UIFurnacePanel.SetShowWithSelectId(UIFurnacePanel.mCustomData.type);
                    end
                    UIFurnacePanel.mCustomData = nil;
                end
            end, UIFurnacePanel.mCustomData);
        end
    end
end

function UIFurnacePanel:Init()
    UIFurnacePanel.InitEvents();
end

---设置帮助按钮显示
function UIFurnacePanel:SetHelpBtnShow(isShow)
    self.GetBtnHelp_GameObject():SetActive(false)
end

--region ondestroy
function ondestroy()
    uimanager:ClosePanel("UIRolePanel");
end
--endregion

return UIFurnacePanel
