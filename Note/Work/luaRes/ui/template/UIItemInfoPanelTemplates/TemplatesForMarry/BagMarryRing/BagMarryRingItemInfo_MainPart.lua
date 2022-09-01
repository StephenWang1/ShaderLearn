local BagMarryRingItemInfo_MainPart = {}
setmetatable(BagMarryRingItemInfo_MainPart,luaComponentTemplates.UIItemInfoPanel_MainPart)
---刷新顶部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function BagMarryRingItemInfo_MainPart:RefreshUpperArea()
    local marryRingItem = self:CreateTemplateUnderArea(self:GetInfoTemplate_UIItem_GO(), luaComponentTemplates.BagMarryRingItemInfo_UIItem, self:GetUpperContentTable_UITable(),LuaEnumItemInfoModuleType.IconAndBaseMsg)
    marryRingItem:RefreshWithInfo(self.commonData)
end

---刷新中央区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function BagMarryRingItemInfo_MainPart:RefreshCenterArea()
    if self.commonData ~= nil and self.commonData.itemInfo then
        local baseAttribute = self:CreateTemplateUnderArea(self:GetInfoTemplate_BaseAttribute_GO(), luaComponentTemplates.BagMarryRingItemInfo_BaseInfo, self:GetCenterContentTable_UITable(),LuaEnumItemInfoModuleType.BaseAttribute)
        baseAttribute:RefreshWithInfo(self.commonData)
    end
end

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function BagMarryRingItemInfo_MainPart:RefreshRightUpArea()
    --显示操作按钮
    if self.commonData ~= nil and self.commonData.itemInfo then
        ---@type UIItemInfoPanel_Info_RightUpOperateButtons
        local buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_RightButtons_Go(), self:GetRightUpButtonsModule(luaComponentTemplates.BagMarryRingItemInfo_RightUpOperateButtons), self:GetUpRightTable_UITable(),LuaEnumItemInfoModuleType.RightUpOperate)
        buttons:RefreshWithInfo(self.commonData)
    end
end
return BagMarryRingItemInfo_MainPart