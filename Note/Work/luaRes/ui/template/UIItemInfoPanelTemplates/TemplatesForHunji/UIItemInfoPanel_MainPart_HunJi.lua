---@class UIItemInfoPanel_MainPart_HunJi:UIItemInfoPanel_PartBasic_Medal
local UIItemInfoPanel_MainPart_HunJi = {}

setmetatable(UIItemInfoPanel_MainPart_HunJi, luaComponentTemplates.UIItemInfoPanel_MainPart)

---魂继技能
---@return UIItemInfoPanel_Info_HunJiSkillTemplate
function UIItemInfoPanel_MainPart_HunJi:GetHunJiSkillsTemplate()
    if self.mHunJiSkillsTemplate == nil then
        local go = self:GetCurComp(self.widgetRoot_Go, "templates/tonglingskilltemplate", "GameObject")
        self.mHunJiSkillsTemplate = self:CreateTemplateUnderArea(go, luaComponentTemplates.UIItemInfoPanel_Info_HunJiSkillTemplate, self:GetUpperContentTable_UITable())
    end
    return self.mHunJiSkillsTemplate
end

function UIItemInfoPanel_MainPart_HunJi:RefreshUpperArea(commonData)
    local UpperContent = self:CreateTemplateUnderArea(self:GetInfoTemplate_UIItem_GO(), luaComponentTemplates.UIItemInfoPanel_Info_UIItem, self:GetUpperContentTable_UITable())
    UpperContent:RefreshWithInfo(self.commonData)
    local attributes = self:CreateTemplateUnderArea(self:GetInfoTemplate_BaseAttribute_GO(), luaComponentTemplates.UIItemInfoPanel_Info_BaseAttribute, self:GetUpperContentTable_UITable())
    attributes:RefreshWithInfo(self.commonData)
    if commonData then
        ---@type TABLE.CFG_ITEMS
        local info = commonData.itemInfo
        if info and info.compoundParam ~= nil and info.compoundParam.list.Count > 0 then
            self:GetHunJiSkillsTemplate():RefreshWithInfo(commonData)
        end
    end
end

function UIItemInfoPanel_MainPart_HunJi:RefreshCenterArea(commonData)

end

return UIItemInfoPanel_MainPart_HunJi