---@type 物品信息界面子界面(灵兽蛋)
---@class UIItemInfoPanel_ServentMainPart:UIPetInfoPanel_PartBasic
local UIItemInfoPanel_ServentMainPart = {}

setmetatable(UIItemInfoPanel_ServentMainPart, luaComponentTemplates.UIItemInfoPanel_PartBasic)

---刷新顶部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServentMainPart:RefreshUpperArea()
    --显示物品ICON和基础信息
    local uiItem = self:CreateTemplateUnderArea(self:GetInfoTemplate_UIItem_GO(), luaComponentTemplates.UIItemInfoPanel_ServentUpInfo, self:GetUpperContentTable_UITable(),LuaEnumItemInfoModuleType.IconAndBaseMsg)
    uiItem:RefreshWithInfo(self.commonData)
end

---刷新中央区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServentMainPart:RefreshCenterArea()
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
function UIItemInfoPanel_ServentMainPart:RefreshLowerArea()
    --道具描述
    if CS.Cfg_GlobalTableManager.Instance:ShowItemDescription(self.commonData.itemInfo) then
        if self.commonData ~= nil and self.commonData.itemInfo and self.commonData.itemInfo.tips2Specified then
            local tips2 = self:CreateTemplateUnderArea(self:GetInfoTemplate_SingleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_SingleLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.ItemDescription)
            tips2:RefreshWithInfo(self.commonData)
        end
    end
    --显示道具底部描述
    self:ShowButtonAreaDescription()
    --获取途径信息
    if self.commonData ~= nil and self.commonData.itemInfo then
        self.wayGetRead = self:CreateTemplateUnderArea(self:GetInfoTemplate_DoubleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_WaygetSignetLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.WayGetDescription)
        self.wayGetRead:RefreshWithInfo(self.commonData)
    end
end

---灵兽蛋 显示底部描述(禅道单82977修改底部描述)
function UIItemInfoPanel_ServentMainPart:ShowButtonAreaDescription()
    if self.commonData ~= nil and self.commonData.itemInfo then
        ---@type UIItemInfoPanel_Info_DoubleLine
        local bottomDes = self:CreateTemplateUnderArea(self:GetInfoTemplate_DoubleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_DoubleLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.ItemDescription2)
        bottomDes:RefreshWithInfo(self.commonData)
    end
end

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServentMainPart:RefreshRightUpArea()
    --显示操作按钮
    if self.commonData ~= nil and self.commonData.itemInfo then
        local buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_RightButtons_Go(), self:GetRightUpButtonsModule(luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons), self:GetUpRightTable_UITable(),LuaEnumItemInfoModuleType.RightUpOperate)
        buttons:RefreshWithInfo(self.commonData)
    end
end

---刷新右下角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServentMainPart:RefreshRightDownArea()
    --显示操作按钮
    if self.commonData ~= nil and self.commonData.bagItemInfo then
        local buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_RightDownButtons_Go(), luaComponentTemplates.UIItemInfoPanel_Info_RightDownOperateButtons, self:GetDownRightTable_UITable(),LuaEnumItemInfoModuleType.RightDownOperate)
        buttons:RefreshWithInfo(self.commonData)
    end
end
return UIItemInfoPanel_ServentMainPart