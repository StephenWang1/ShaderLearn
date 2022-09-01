---灵兽装备主界面
---@class  UIItemInfoPanel_ServantEquipMainPart :UIItemInfoPanel_MainPart
local UIItemInfoPanel_ServantEquipMainPart = {}
setmetatable(UIItemInfoPanel_ServantEquipMainPart, luaComponentTemplates.UIItemInfoPanel_MainPart)

---刷新顶部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServantEquipMainPart:RefreshUpperArea()
    --显示物品ICON和基础信息
    ---@type UIItemInfoPanel_ServantEquip_UIItem
    local uiItem = self:CreateTemplateUnderArea(self:GetInfoTemplate_UIItem_GO(), luaComponentTemplates.UIItemInfoPanel_ServantEquip_UIItem, self:GetUpperContentTable_UITable(),LuaEnumItemInfoModuleType.IconAndBaseMsg)
    uiItem:RefreshWithInfo(self.commonData)
end

---刷新中央区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServantEquipMainPart:RefreshCenterArea()
    --显示基础属性
    if self.commonData ~= nil and self.commonData.itemInfo and not CS.CSServantInfoV2.IsServantMagicWeapon(self.commonData.itemInfo) then
        ---@type UIItemInfoPanel_Info_ServantEquipBaseAttribute
        local baseAttribute = self:CreateTemplateUnderArea(self:GetInfoTemplate_BaseAttribute_GO(), luaComponentTemplates.UIItemInfoPanel_Info_ServantEquipBaseAttribute, self:GetCenterContentTable_UITable(),LuaEnumItemInfoModuleType.BaseAttribute)
        baseAttribute:RefreshWithInfo(self.commonData)
    end

    if self.commonData ~= nil and self.commonData.itemInfo and (self.commonData.itemInfoSource == nil or self.commonData.itemInfoSource ~= luaEnumItemInfoSource.UIREFINERESULT)then
        local extraAttribute = self:CreateTemplateUnderArea(self:GetExtraAttribute_GO(), luaComponentTemplates.UIItemInfoPanel_Info_ExtraAttribute, self:GetCenterContentTable_UITable(),LuaEnumItemInfoModuleType.ExtraAttribute)
        extraAttribute:RefreshWithInfo(self.commonData)
    end
end

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServantEquipMainPart:RefreshRightUpArea()
    --显示操作按钮
    if self.commonData ~= nil and self.commonData.itemInfo then
        local buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_RightButtons_Go(), self:GetRightUpButtonsModule(luaComponentTemplates.UIITemPanel_Info_ServantEquipRightUpOperate), self:GetUpRightTable_UITable(),LuaEnumItemInfoModuleType.RightUpOperate)
        buttons:RefreshWithInfo(self.commonData)
    end
end

---刷新右下角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServantEquipMainPart:RefreshRightDownArea()
    --显示操作按钮
    if self.commonData ~= nil and self.commonData.itemInfo then
        local buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_RightDownButtons_Go(), luaComponentTemplates.UIItemInfoPanel_Info_RightDownOperateButtons, self:GetDownRightTable_UITable(),LuaEnumItemInfoModuleType.RightDownOperate)
        buttons:RefreshWithInfo(self.commonData)
    end
end

return UIItemInfoPanel_ServantEquipMainPart