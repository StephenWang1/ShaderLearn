---@type 勋章辅助子界面
---@class UIItemInfoPanel_AssistPart_Medal:UIItemInfoPanel_MainPart_Medal
local UIItemInfoPanel_AssistPart_Medal = {}
setmetatable(UIItemInfoPanel_AssistPart_Medal, luaComponentTemplates.UIItemInfoPanel_MainPart_Medal)

---刷新顶部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_AssistPart_Medal:RefreshUpperArea()
    --显示物品ICON和基础信息
    local uiItem = self:CreateTemplateUnderArea(self:GetInfoTemplate_UIItem_GO(), luaComponentTemplates.UIItemInfoPanel_Info_Medal, self:GetUpperContentTable_UITable(),LuaEnumItemInfoModuleType.IconAndBaseMsg)
    uiItem:RefreshWithInfo(self.commonData)
end

---刷新中央区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_AssistPart_Medal:RefreshCenterArea()
    --显示基础属性
    local baseAttribute = self:GetBaseAttributeTemplate();
    baseAttribute:RefreshWithInfo(self.commonData)
    --额外属性
    if self.commonData ~= nil and self.commonData.bagItemInfo and self.commonData.itemInfo then
        local extraAttribute = self:CreateTemplateUnderArea(self:GetExtraAttribute_GO(), luaComponentTemplates.UIItemInfoPanel_Info_ExtraAttribute_Medal, self:GetCenterContentTable_UITable(),LuaEnumItemInfoModuleType.ExtraAttribute)
        extraAttribute:RefreshWithInfo(self.commonData)
    end
end

---刷新底部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_AssistPart_Medal:RefreshLowerArea()
    --道具描述
    if  self.commonData ~= nil and self.commonData.itemInfo and self.commonData.itemInfo.type == luaEnumItemType.Equip then
        local tips2 = self:CreateTemplateUnderArea(self:GetInfoTemplate_SingleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_SingleLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.ItemDescription)
        tips2:RefreshWithInfo(self.commonData)
    end
    self:ShowButtonAreaDescription()
    --获取途径信息
    if self.commonData ~= nil and self.commonData.itemInfo then
        self.wayGetRead = self:CreateTemplateUnderArea(self:GetInfoTemplate_DoubleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_WaygetSignetLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.WayGetDescription)
        self.wayGetRead:RefreshWithInfo(self.commonData)
    end
end

---显示道具底部描述(禅道单82977修改底部描述)
function UIItemInfoPanel_AssistPart_Medal:ShowButtonAreaDescription()
    if self.commonData ~= nil and self.commonData.itemInfo then
        local bottomDes = self:CreateTemplateUnderArea(self:GetInfoTemplate_DoubleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_DoubleLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.ItemDescription2)
        bottomDes:RefreshWithInfo(self.commonData)
    end
end

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_AssistPart_Medal:RefreshRightUpArea()
end

---刷新右下角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_AssistPart_Medal:RefreshRightDownArea()

end

return UIItemInfoPanel_AssistPart_Medal