local UISkillPanel_ConfigGridTemplate = {}
setmetatable(UISkillPanel_ConfigGridTemplate,luaComponentTemplates.UISkillTemplate_UISkillPanel)

--region 初始化

--endregion

--region 重写功能
---重写刷新按钮状态
function UISkillPanel_ConfigGridTemplate:RefreshUpgradeBtnState()
    self.Btn_Upgrade.gameObject:SetActive(false)
    self.Btn_Learn:SetActive(true)
    self.self.UseSkillBookBtn:SetActive(false)
end

---重写刷新tips
function UISkillPanel_ConfigGridTemplate:RefreshTips()
    self.Tips.gameObject:SetActive(false)
end

---重写自动释放文本
function UISkillPanel_ConfigGridTemplate:RefreshAutoText()
    self.AutoObj:SetActive(false)
end

---重写学习按钮点击功能为加入
function UISkillPanel_ConfigGridTemplate:OnStudySkillBookBtn()
    print("加入")
end

---重写icon技能点击
function UISkillPanel_ConfigGridTemplate:OnSelectSelf()
    print()
end
--endregion

return UISkillPanel_ConfigGridTemplate