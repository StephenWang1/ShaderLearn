---灵兽肉身装备主要部分
---@class UIItemInfoPanel_ServantBodyMainPart:UIItemInfoPanel_ServantEquipMainPart
local UIItemInfoPanel_ServantBodyMainPart = {}

setmetatable(UIItemInfoPanel_ServantBodyMainPart, luaComponentTemplates.UIItemInfoPanel_ServantEquipMainPart)

function UIItemInfoPanel_ServantBodyMainPart:RefreshUpperArea()
    --显示物品ICON和基础信息
    ---@type UIItemInfoPanel_ServantBody_UIItem
    local uiItem = self:CreateTemplateUnderArea(self:GetInfoTemplate_UIItem_GO(), luaComponentTemplates.UIItemInfoPanel_ServantBody_UIItem, self:GetUpperContentTable_UITable(),LuaEnumItemInfoModuleType.IconAndBaseMsg)
    uiItem:RefreshWithInfo(self.commonData)
end

---刷新中央区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServantBodyMainPart:RefreshCenterArea()
    --显示基础属性
    if self.commonData ~= nil and self.commonData.itemInfo then
        ---@type UIItemInfoPanel_Info_ServantBodyBaseAttribute
        local baseAttribute = self:CreateTemplateUnderArea(self:GetInfoTemplate_BaseAttribute_GO(), luaComponentTemplates.UIItemInfoPanel_Info_ServantBodyBaseAttribute, self:GetCenterContentTable_UITable(),LuaEnumItemInfoModuleType.BaseAttribute)
        baseAttribute:RefreshWithInfo(self.commonData)
    end
    --额外属性
    if self.commonData ~= nil and self.commonData.bagItemInfo and self.commonData.itemInfo and (self.commonData.itemInfoSource == nil or self.commonData.itemInfoSource ~= luaEnumItemInfoSource.UIREFINERESULT)then
        local extraAttribute = self:CreateTemplateUnderArea(self:GetExtraAttribute_GO(), luaComponentTemplates.UIItemInfoPanel_Info_ExtraAttribute, self:GetCenterContentTable_UITable(),LuaEnumItemInfoModuleType.ExtraAttribute)
        extraAttribute:RefreshWithInfo(self.commonData)
    end
end

return UIItemInfoPanel_ServantBodyMainPart