---@class UIItemInfoPanel_MainPart_Potential：UIItemInfoPanel_MainPart
local UIItemInfoPanel_MainPart_Potential = {}
setmetatable(UIItemInfoPanel_MainPart_Potential, luaComponentTemplates.UIItemInfoPanel_MainPart)

---重载刷新顶部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_MainPart_Potential:RefreshUpperArea()
    if (self.mUIItem == nil) then
        self.mUIItem = self:CreateTemplateUnderArea(self:GetInfoTemplate_UIItem_GO(), luaComponentTemplates.UIItemInfoPanel_Info_Potential, self:GetUpperContentTable_UITable(), LuaEnumItemInfoModuleType.IconAndBaseMsg)
    end
    self.mUIItem:RefreshWithInfo(self.commonData)
end

---重载刷新中央区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_MainPart_Potential:RefreshCenterArea()
    --显示基础属性
    local baseAttribute = self:GetBaseAttributeTemplate();
    baseAttribute:RefreshWithInfo(self.commonData, LuaEnumItemInfoModuleType.BaseAttribute)

    --额外属性
    local extraAttribute = self:CreateTemplateUnderArea(self:GetExtraAttribute_GO(), luaComponentTemplates.UIItemInfoPanel_Info_ExtraAttribute_Potential, self:GetCenterContentTable_UITable(), LuaEnumItemInfoModuleType.ExtraAttribute)
    extraAttribute:RefreshWithInfo(self.commonData)
end

return UIItemInfoPanel_MainPart_Potential