local RoleMarryRingItemInfo_MainPart = {}
setmetatable(RoleMarryRingItemInfo_MainPart,luaComponentTemplates.UIItemInfoPanel_MainPart)
---刷新顶部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function RoleMarryRingItemInfo_MainPart:RefreshUpperArea()
    local marryRingItem = self:CreateTemplateUnderArea(self:GetInfoTemplate_UIItem_GO(), luaComponentTemplates.RoleMarryRingItemInfo_UIItem, self:GetUpperContentTable_UITable(),LuaEnumItemInfoModuleType.IconAndBaseMsg)
    marryRingItem:RefreshWithInfo(self.commonData)
end

---刷新中央区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function RoleMarryRingItemInfo_MainPart:RefreshCenterArea()
    if self.commonData ~= nil and self.commonData.bagItemInfo and self.commonData.itemInfo then
        local baseAttribute = self:CreateTemplateUnderArea(self:GetInfoTemplate_BaseAttribute_GO(), luaComponentTemplates.RoleMarryRingItemInfo_BaseInfo, self:GetCenterContentTable_UITable(),LuaEnumItemInfoModuleType.BaseAttribute)
        baseAttribute:RefreshWithInfo(self.commonData)
    end
    if self.commonData ~= nil and self.commonData.bagItemInfo and self.commonData.itemInfo then
        local extraAttribute = self:CreateTemplateUnderArea(self:GetExtraAttribute_GO(), luaComponentTemplates.RoleMarryRingItemInfo_ExtraAttribute, self:GetCenterContentTable_UITable(),LuaEnumItemInfoModuleType.ExtraAttribute)
        extraAttribute:RefreshWithInfo(self.commonData)
    end
end

--region 刷新底部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function RoleMarryRingItemInfo_MainPart:RefreshLowerArea()
    ----道具描述
    --if CS.Cfg_GlobalTableManager.Instance:ShowItemDescription(self.commonData.itemInfo) then
    --    if self.commonData ~= nil and self.commonData.itemInfo and self.commonData.itemInfo.tips2Specified then
    --        local tips2 = self:CreateTemplateUnderArea(self:GetInfoTemplate_SingleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_SingleLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.ItemDescription)
    --        tips2:RefreshWithInfo(self.commonData)
    --    end
    --end
    --self:ShowButtonAreaDescription(self.commonData.itemInfo)
    ----获取途径信息
    --if self.commonData ~= nil and self.commonData.itemInfo then
    --    self.wayGetRead = self:CreateTemplateUnderArea(self:GetInfoTemplate_DoubleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_WaygetSignetLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.WayGetDescription)
    --    self.wayGetRead:RefreshWithInfo(self.commonData)
    --end
end

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function RoleMarryRingItemInfo_MainPart:RefreshRightUpArea()
    --显示操作按钮
    if self.commonData ~= nil and self.commonData.itemInfo then
        ---@type UIItemInfoPanel_Info_RightUpOperateButtons
        local buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_RightButtons_Go(), self:GetRightUpButtonsModule(luaComponentTemplates.RoleMarryRingItemInfo_RightUpOperateButtons), self:GetUpRightTable_UITable(),LuaEnumItemInfoModuleType.RightUpOperate)
        buttons:RefreshWithInfo(self.commonData)
    end
end
return RoleMarryRingItemInfo_MainPart