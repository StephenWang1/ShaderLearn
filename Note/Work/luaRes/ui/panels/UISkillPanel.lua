---技能界面
---@class UISkillPanel:UIBase
local UISkillPanel = {}

--region components
function UISkillPanel:ThisPanel()
    return UISkillPanel.mThisPanel
end

---技能信息面板GameObject
function UISkillPanel.GetSkillInfoPanel_GameObject()
    if UISkillPanel.mSkillInfoPanel_GameObject == nil then
        UISkillPanel.mSkillInfoPanel_GameObject = UISkillPanel:GetCurComp('WidgetRoot/UISkillInfoPanel', 'GameObject')
    end
    return UISkillPanel.mSkillInfoPanel_GameObject
end

---技能详情模板
---@return UISkillInfo_UISkillPanel
function UISkillPanel.UISkillInfo_UISkillPanel()
    if UISkillPanel.mUISkillInfo_UISkillPanel == nil then
        UISkillPanel.mUISkillInfo_UISkillPanel = templatemanager.GetNewTemplate(UISkillPanel.GetSkillInfoPanel_GameObject(), luaComponentTemplates.UISkillInfo_UISkillPanel, UISkillPanel)
    end
    return UISkillPanel.mUISkillInfo_UISkillPanel
end
---遮罩
function UISkillPanel.Box_GameObject()
    if UISkillPanel.mBox == nil then
        UISkillPanel.mBox = UISkillPanel:GetCurComp('WidgetRoot/window/box', 'GameObject')
    end
    return UISkillPanel.mBox
end

function UISkillPanel.CloseBtn()
    if UISkillPanel.btn_close == nil then
        UISkillPanel.btn_close = UISkillPanel:GetCurComp('WidgetRoot/events/btn_close', 'GameObject')
    end
    return UISkillPanel.btn_close
end

--endregion
function UISkillPanel:Init()
    UISkillPanel.mThisPanel = self
    UISkillPanel.mSubTabState = false
    --关闭面板
    CS.UIEventListener.Get(UISkillPanel.Box_GameObject()).onClick = UISkillPanel.ClosePanel;
    CS.UIEventListener.Get(UISkillPanel.CloseBtn()).onClick = UISkillPanel.ClosePanel;

    UISkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, UISkillPanel.OnMainPlayerLevelUpMessage)
    UISkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_AttackSkillExpInfoChange, UISkillPanel.OnResSkillUpgradeMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSkillMessage, UISkillPanel.OnResUseSkillBookMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, UISkillPanel.OnResBagItemChangedMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOneSkillChangeMessage, UISkillPanel.OnResSkillUpgradeMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSkillBookUseMessage, UISkillPanel.OnResUseSkillBookMessage)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_BagPanelIsOpen, UISkillPanel.BagPanelIsOpen)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_BagPanelIsClose, UISkillPanel.BagPanelIsClose)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_BtnBag, UISkillPanel.OnMainPanelBagClicked)

    if uimanager:GetPanel("UIBagPanel") ~= nil then
        UISkillPanel.OnMainPanelBagClicked()
    end
end

function UISkillPanel.Show(skillInfo)
    UISkillPanel.itemTemplates = nil
    UISkillPanel.isShowClose = true

    if skillInfo ~= nil then
        if skillInfo.template ~= nil then
            UISkillPanel.itemTemplates = skillInfo.template
        end
        if skillInfo.isShowClose ~= nil then
            UISkillPanel.isShowClose = skillInfo.isShowClose
        end
    end
    UISkillPanel.CloseBtn().gameObject:SetActive(UISkillPanel.isShowClose)
    UISkillPanel.IsStartInitRefreshUI = false
end

function update()
    if UISkillPanel.IsStartInitRefreshUI == false then
        UISkillPanel.RefreshUI(UISkillPanel.itemTemplates)
        UISkillPanel.IsStartInitRefreshUI = nil
    end
end

function UISkillPanel.RefreshUI(template)
    if template == nil then
        template = luaComponentTemplates.UISkillTemplate_UISkillPanel
    end
    UISkillPanel.UISkillInfo_UISkillPanel():RefreshUI(template)
end


--region 服务器消息
---主角升级消息
function UISkillPanel.OnMainPlayerLevelUpMessage()
    UISkillPanel:RefreshUI()
end

---技能升级消息
function UISkillPanel.OnResSkillUpgradeMessage(id, data)
    UISkillPanel.RefreshUI()
    if data ~= nil then
        if data.exp == 0 then
            UISkillPanel.UISkillInfo_UISkillPanel():RefreshInfoPanel()
        end
    end

end

---背包物品改变信息
function UISkillPanel.OnResBagItemChangedMessage(uiEvtID, data)
    UISkillPanel.RefreshUI()
    UISkillPanel.UISkillInfo_UISkillPanel():RefreshInfoPanel()
end

---技能书使用信息
function UISkillPanel.OnResUseSkillBookMessage(uiEvtID, data)
    UISkillPanel.RefreshUI()
    UISkillPanel.UISkillInfo_UISkillPanel():RefreshInfoPanel()
end
--endregion

--region 客户端消息
function UISkillPanel.BagPanelIsOpen()
    if (UISkillPanel.UISkillInfo_UISkillPanel() ~= nil and UISkillPanel.UISkillInfo_UISkillPanel().bagBoxCollider ~= nil) then
        UISkillPanel.UISkillInfo_UISkillPanel().bagBoxCollider:SetActive(true)
    end

end

function UISkillPanel.BagPanelIsClose()
    if (UISkillPanel.UISkillInfo_UISkillPanel() ~= nil and UISkillPanel.UISkillInfo_UISkillPanel().bagBoxCollider ~= nil) then
        UISkillPanel.UISkillInfo_UISkillPanel().bagBoxCollider:SetActive(false)
    end
end
--endregion

---关闭面板
function UISkillPanel.ClosePanel()
    uimanager:ClosePanel("UISkillPanel")
end

function UISkillPanel.OnMainPanelBagClicked()
    uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Skill })
end

function ondestroy()
    if (CS.CSScene.MainPlayerInfo == nil) then
        return
    end
    CS.CSScene.MainPlayerInfo.BagInfo.BagGirdNeedHightLight = false
    if uimanager:GetPanel("UIBagPanel") then
        ---若当前背包界面已打开,则切换到正常背包
        uimanager:CreatePanel("UIBagPanel", nil, LuaEnumBagType.Normal)
    end
    if UISkillPanel.UISkillInfo_UISkillPanel() ~= nil then
        UISkillPanel.UISkillInfo_UISkillPanel():CloseSkillInfoPanel()
    end

end

return UISkillPanel