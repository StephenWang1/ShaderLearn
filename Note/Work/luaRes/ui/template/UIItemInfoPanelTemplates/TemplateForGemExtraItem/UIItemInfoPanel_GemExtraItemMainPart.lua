local UIItemInfoPanel_GemExtraItemMainPart = {}
setmetatable(UIItemInfoPanel_GemExtraItemMainPart, luaComponentTemplates.UIItemInfoPanel_MainPart)

---刷新顶部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_GemExtraItemMainPart:RefreshUpperArea()
    local UpperContent = self:CreateTemplateUnderArea(self:GetInfoTemplate_UIItem_GO(), luaComponentTemplates.UIItemInfoPanel_GemExtraItem_UIItem, self:GetUpperContentTable_UITable(),LuaEnumItemInfoModuleType.IconAndBaseMsg)
    UpperContent:RefreshWithInfo(self.commonData)
end

---刷新中央区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_GemExtraItemMainPart:RefreshCenterArea()
    --显示基础属性
    local baseAttribute = self:CreateTemplateUnderArea(self:GetInfoTemplate_BaseAttribute_GO(), luaComponentTemplates.UIItemInfoPanel_GemExtraItem_BaseAttribute, self:GetCenterContentTable_UITable(),LuaEnumItemInfoModuleType.BaseAttribute)
    baseAttribute:RefreshWithInfo(self.commonData)

    --额外属性
    if self.commonData ~= nil and self.commonData.itemInfo then
        local extraAttribute = self:CreateTemplateUnderArea(self:GetExtraAttribute_GO(), luaComponentTemplates.UIItemInfoPanel_GemExtraItem_ExtraAttribute, self:GetCenterContentTable_UITable(),LuaEnumItemInfoModuleType.ExtraAttribute)
        extraAttribute:RefreshWithInfo(self.commonData)
    end
end
return UIItemInfoPanel_GemExtraItemMainPart