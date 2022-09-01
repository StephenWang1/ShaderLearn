---@class MagicEquipItemInfo_MainPart 法宝Tip界面
local MagicEquipItemInfo_MainPart = {}

setmetatable(MagicEquipItemInfo_MainPart, luaComponentTemplates.UIItemInfoPanel_MainPart)

---刷新顶部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function MagicEquipItemInfo_MainPart:RefreshUpperArea()
    ---@type MagicEquipItemInfo_UIItem
    local uiItemTemplate = self:CreateTemplateUnderArea(self:GetInfoTemplate_UIItem_GO(), luaComponentTemplates.MagicEquipItemInfo_UIItem, self:GetUpperContentTable_UITable(), LuaEnumItemInfoModuleType.IconAndBaseMsg)
    uiItemTemplate:RefreshWithInfo(self.commonData)
end

---刷新中央区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function MagicEquipItemInfo_MainPart:RefreshCenterArea()
    --显示基础属性
    local baseAttribute = self:GetBaseAttributeTemplate()
    baseAttribute:RefreshWithInfo(self.commonData, LuaEnumItemInfoModuleType.BaseAttribute)

    --额外属性
    if self.commonData ~= nil and self.commonData.itemInfo and (self.commonData.itemInfoSource == nil
            or self.commonData.itemInfoSource ~= luaEnumItemInfoSource.UIREFINERESULT) then
        local extraAttribute = self:CreateTemplateUnderArea(self:GetExtraAttribute_GO(), luaComponentTemplates.MagicEquipItemInfo_ExtraAttribute,
                self:GetCenterContentTable_UITable(), LuaEnumItemInfoModuleType.ExtraAttribute)
        extraAttribute:RefreshWithInfo(self.commonData)
    end
end

return MagicEquipItemInfo_MainPart