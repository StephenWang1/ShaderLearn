local UIConfigPanel_Skill = {}
setmetatable(UIConfigPanel_Skill, luaComponentTemplates.UIConfigPanel_PartBasic)
--region 组件
---技能面板打开按钮高亮背景
function UIConfigPanel_Skill:GetOpenSkillBtnHighLightBg()
    if self.mOpenSkillBtnHighLightBg == nil or CS.StaticUtility.IsNull(self.mOpenSkillBtnHighLightBg) then
        self.mOpenSkillBtnHighLightBg = self:Get("btn_skill/Checkmark", "GameObject");
    end
    return self.mOpenSkillBtnHighLightBg
end

---技能面板打开按钮高亮背景
function UIConfigPanel_Skill:GetOpenBagBtnHighLightBg()
    if self.mOpenBagBtnHighLightBg == nil or CS.StaticUtility.IsNull(self.mOpenBagBtnHighLightBg) then
        self.mOpenBagBtnHighLightBg = self:Get("btn_skill/Checkmark", "GameObject");
    end
    return self.mOpenBagBtnHighLightBg
end
--endregion

--region 初始设置
function UIConfigPanel_Skill:Init(uiConfigPanel)
    self:RunBaseFunction("Init",uiConfigPanel,LuaEnumConfigPanelOpenType.SkillConfigPanel)
    self:InitComponent()
    self:InitTemplates()
    self:BindEvents()
end

function UIConfigPanel_Skill:InitComponent()
    self.openSkillPanelBtn = self:Get("btn_skill","GameObject")
    self.openBagPanelBtn = self:Get("btn_props","GameObject")
    self.model1Btn = self:Get("shortcutsPanel/Btn_mode1","GameObject")
    self.model2Btn = self:Get("shortcutsPanel/Btn_mode1","GameObject")
    self.model1SkillPanel = self:Get("shortcutsPanel/skillPlan1","GameObject")
    self.model2SkillPanel = self:Get("shortcutsPanel/skillPlan2","GameObject")
    self.resetBtn = self:Get("shortcutsPanel/Btn_Clear","GameObject")
end

function UIConfigPanel_Skill:InitTemplates()
    self.model1SkillPanel = templatemanager.GetNewTemplate(self.model1SkillPanel, luaComponentTemplates.UISkillConfigPanel_Model1)
    self.model2SkillPanel = templatemanager.GetNewTemplate(self.model2SkillPanel, luaComponentTemplates.UISkillConfigPanel_Model2)
end

function UIConfigPanel_Skill:BindEvents()
    CS.UIEventListener.Get(self.openSkillPanelBtn).onClick = function()
        self:OpenSkillPanelBtnOnClick()
    end
    CS.UIEventListener.Get(self.openBagPanelBtn).onClick = function()
        self:OpenBagPanelBtnOnClick()
    end
    CS.UIEventListener.Get(self.model1Btn).onClick = function()

    end
    CS.UIEventListener.Get(self.model2Btn).onClick = function()

    end
    CS.UIEventListener.Get(self.resetBtn).onClick = function()

    end
end

--region 事件处理
---打开技能面板按钮点击
function UIConfigPanel_Skill:OpenSkillPanelBtnOnClick()
    if self:GetOpenSkillBtnHighLightBg() ~= nil then
        self:GetOpenSkillBtnHighLightBg():SetActive(true)
    end
    uimanager:ClosePanel("UIBagPanel")
    uimanager:CreatePanel("UISkillPanel",nil,{itemTemplates = luaComponentTemplates.UISkillPanel_ConfigGridTemplate,isShowClose = true})
end

---打开背包面板按钮点击
function UIConfigPanel_Skill:OpenBagPanelBtnOnClick()
    if self:GetOpenBagBtnHighLightBg() ~= nil then
        self:GetOpenBagBtnHighLightBg():SetActive(true)
    end
    uimanager:ClosePanel("UISkillPanel")
    uimanager:CreatePanel("UIBagPanel", nil, LuaEnumBagType.SkillConfig)
end

---打开模式1面板按钮点击
function UIConfigPanel_Skill:OpenModel1BtnOnClick()

end

---打开模式2面板按钮点击
function UIConfigPanel_Skill:OpenModel2BtnOnClick()

end

---重置按钮点击
function UIConfigPanel_Skill:OpenResetBtnOnClick()

end
--endregion
--endregion

--region 刷新面板
function UIConfigPanel_Skill:RefreshPanel()
    if self:CheckIsRefresh() == false then

    end
    self:InitRefresh()
end
--endregion

return UIConfigPanel_Skill