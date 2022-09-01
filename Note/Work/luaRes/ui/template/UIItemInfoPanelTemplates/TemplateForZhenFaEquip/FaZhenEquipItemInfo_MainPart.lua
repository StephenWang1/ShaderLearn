---@class FaZhenEquipItemInfo_MainPart:UIItemInfoPanel_MainPart 法阵主面板
local FaZhenEquipItemInfo_MainPart = {}

setmetatable(FaZhenEquipItemInfo_MainPart, luaComponentTemplates.UIItemInfoPanel_MainPart)

---刷新顶部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function FaZhenEquipItemInfo_MainPart:RefreshUpperArea()
    local elementAttribute =  self:CreateTemplateUnderArea(self:GetInfoTemplate_UIItem_GO(), luaComponentTemplates.FaZhenEquipItemInfo_UIItem, self:GetUpperContentTable_UITable(), LuaEnumItemInfoModuleType.IconAndBaseMsg)
    if elementAttribute ~= nil then
        elementAttribute:RefreshWithInfo(self.commonData)
    end
end

---@return FaZhenEquipItemInfo_BaseAttribute
function FaZhenEquipItemInfo_MainPart:GetBaseAttributeTemplate()
    if (self.mBaseAttribute == nil) then
        self.mBaseAttribute = self:CreateTemplateUnderArea(self:GetInfoTemplate_BaseAttribute_GO(), luaComponentTemplates.FaZhenEquipItemInfo_BaseAttribute, self:GetCenterContentTable_UITable(), LuaEnumItemInfoModuleType.BaseAttribute)
    end
    return self.mBaseAttribute;
end

return FaZhenEquipItemInfo_MainPart