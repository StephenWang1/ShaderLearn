---@type 物品信息界面子界面
---@class UIItemInfoPanel_ServentAssistPart:UIPetInfoPanel_PartBasic
local UIItemInfoPanel_ServentAssistPart = {}

setmetatable(UIItemInfoPanel_ServentAssistPart, luaComponentTemplates.UIItemInfoPanel_PartBasic)

---刷新顶部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServentAssistPart:RefreshUpperArea()
    --显示物品ICON和基础信息
    local uiItem = self:CreateTemplateUnderArea(self:GetInfoTemplate_UIItem_GO(), luaComponentTemplates.UIItemInfoPanel_ServentUpInfo, self:GetUpperContentTable_UITable(),LuaEnumItemInfoModuleType.IconAndBaseMsg)
    uiItem:RefreshWithInfo(self.commonData)
end

---刷新中央区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServentAssistPart:RefreshCenterArea()
    --显示基础属性
    if self.commonData ~= nil and self.commonData.itemInfo then
        local baseAttribute = self:CreateTemplateUnderArea(self:GetInfoTemplate_BaseAttribute_GO(), luaComponentTemplates.UIItemInfoPanel_ServentAttributeInfo, self:GetCenterContentTable_UITable(),LuaEnumItemInfoModuleType.BaseAttribute)
        baseAttribute:RefreshWithInfo(self.commonData)
    end

    --额外属性
    if self.commonData ~= nil and self.commonData.bagItemInfo and self.commonData.itemInfo then
        local extraAttribute = self:CreateTemplateUnderArea(self:GetExtraAttribute_GO(), luaComponentTemplates.UIItemInfoPanel_Info_ExtraAttribute, self:GetCenterContentTable_UITable(),LuaEnumItemInfoModuleType.ExtraAttribute)
        extraAttribute:RefreshWithInfo(self.commonData)
    end
end

---刷新底部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServentAssistPart:RefreshLowerArea()
    self:ShowButtonAreaDescription()
end

---显示道具底部描述(禅道单82977修改底部描述)
function UIItemInfoPanel_ServentAssistPart:ShowButtonAreaDescription()
    --道具描述
    if CS.Cfg_GlobalTableManager.Instance:ShowItemDescription(self.commonData.itemInfo) then
        if self.commonData ~= nil and self.commonData.itemInfo and self.commonData.itemInfo.tips2Specified then
            local tips2 = self:CreateTemplateUnderArea(self:GetInfoTemplate_SingleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_SingleLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.ItemDescription)
            tips2:RefreshWithInfo(self.commonData)
        end
    end
    --显示道具底部描述
    if self.commonData ~= nil and self.commonData.itemInfo then
        ---@type UIItemInfoPanel_Info_DoubleLine
        local bottomDes = self:CreateTemplateUnderArea(self:GetInfoTemplate_DoubleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_DoubleLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.ItemDescription2)
        bottomDes:RefreshWithInfo(self.commonData)
    end
    --获取途径信息
    if self.commonData ~= nil and self.commonData.itemInfo then
        self.wayGetRead = self:CreateTemplateUnderArea(self:GetInfoTemplate_DoubleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_WaygetSignetLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.WayGetDescription)
        self.wayGetRead:RefreshWithInfo(self.commonData)
    end
end

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServentAssistPart:RefreshRightUpArea()
end

---刷新右下角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServentAssistPart:RefreshRightDownArea()

end

---刷新左上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServentAssistPart:RefreshTopLeftArea()
    --显示操作按钮
    if self.commonData ~= nil and self.commonData.TabBagItemInfoTable ~= nil then
        local buttons = self:CreateTemplateUnderArea(self:GetTopButtons_GO(), luaComponentTemplates.UIItemInfoPanel_Info_LeftTopOperateButtons, self:GetLeftTopTable_UITable(),LuaEnumItemInfoModuleType.PageOperate)
        buttons:RefreshWithInfo(self.commonData)
    end
end
return UIItemInfoPanel_ServentAssistPart