---@type 勋章信息界面子界面
---@class UIItemInfoPanel_MainPart_Medal:UIItemInfoPanel_PartBasic_Medal
local UIItemInfoPanel_MainPart_Medal = {}
setmetatable(UIItemInfoPanel_MainPart_Medal, luaComponentTemplates.UIItemInfoPanel_PartBasic_Medal)
---刷新顶部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_MainPart_Medal:RefreshUpperArea()
    self:GetUIItemTemplate():RefreshWithInfo(self.commonData)
end

---刷新中央区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_MainPart_Medal:RefreshCenterArea()
    --显示基础属性
    local baseAttribute = self:GetBaseAttributeTemplate();
    baseAttribute:RefreshWithInfo(self.commonData)
    --额外属性
    if self.commonData ~= nil and self.commonData.itemInfo then
        local extraAttribute = self:CreateTemplateUnderArea(self:GetExtraAttribute_GO(), luaComponentTemplates.UIItemInfoPanel_Info_ExtraAttribute_Medal, self:GetCenterContentTable_UITable(),LuaEnumItemInfoModuleType.ExtraAttribute)
        extraAttribute:RefreshWithInfo(self.commonData)
    end
end

--region 刷新底部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_MainPart_Medal:RefreshLowerArea()
    --道具描述
    if self.commonData ~= nil and self.commonData.itemInfo and self.commonData.itemInfo.type == luaEnumItemType.Equip then
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
function UIItemInfoPanel_MainPart_Medal:ShowButtonAreaDescription()
    if self.commonData ~= nil and self.commonData.itemInfo then
        ---@type UIItemInfoPanel_Info_DoubleLine
        local bottomDes = self:CreateTemplateUnderArea(self:GetInfoTemplate_DoubleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_DoubleLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.ItemDescription2)
        bottomDes:RefreshWithInfo(self.commonData)
    end
end
--endregion

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_MainPart_Medal:RefreshRightUpArea()
    --显示操作按钮
    if self.commonData ~= nil and self.commonData.itemInfo then
        ---@type UIItemInfoPanel_Info_RightUpOperateButtons
        local buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_RightButtons_Go(), self:GetRightUpButtonsModule(luaComponentTemplates.UIItemInfoPanel_Info_MedalRightUpOperateBtns), self:GetUpRightTable_UITable(),LuaEnumItemInfoModuleType.RightUpOperate)
        buttons:RefreshWithInfo(self.commonData)
    end
end

---刷新右下角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_MainPart_Medal:RefreshRightDownArea()
    --显示操作按钮
    if self.commonData ~= nil and self.commonData.itemInfo then
        local buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_RightDownButtons_Go(), luaComponentTemplates.UIItemInfoPanel_Info_RightDownOperateButtons, self:GetDownRightTable_UITable(),LuaEnumItemInfoModuleType.RightDownOperate)
        buttons:RefreshWithInfo(self.commonData)
    end
end
return UIItemInfoPanel_MainPart_Medal
