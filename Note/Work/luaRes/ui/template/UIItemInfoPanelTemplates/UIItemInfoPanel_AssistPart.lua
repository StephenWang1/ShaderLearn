---@class UIItemInfoPanel_AssistPart :UIItemInfoPanel_PartBasic
local UIItemInfoPanel_AssistPart = {}

setmetatable(UIItemInfoPanel_AssistPart, luaComponentTemplates.UIItemInfoPanel_PartBasic)

---刷新顶部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_AssistPart:RefreshUpperArea()
    --显示物品ICON和基础信息
    self:GetUIItemTemplate():RefreshWithInfo(self.commonData)
end

---刷新中央区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_AssistPart:RefreshCenterArea()
    --显示基础属性
    if self.commonData ~= nil and self.commonData.itemInfo then
        --只有装备显示基础属性
        if self.commonData.itemInfo.type == luaEnumItemType.Equip then
            local baseAttribute = self:CreateTemplateUnderArea(self:GetInfoTemplate_BaseAttribute_GO(), luaComponentTemplates.UIItemInfoPanel_Info_BaseAttribute, self:GetCenterContentTable_UITable(),LuaEnumItemInfoModuleType.BaseAttribute)
            baseAttribute:RefreshWithInfo(self.commonData)
        end
    end

    --额外属性
    if self.commonData ~= nil and self.commonData.bagItemInfo and self.commonData.itemInfo  and (self.commonData.itemInfoSource == nil or self.commonData.itemInfoSource ~= luaEnumItemInfoSource.UIREFINERESULT) then
        local extraAttribute = self:CreateTemplateUnderArea(self:GetExtraAttribute_GO(), luaComponentTemplates.UIItemInfoPanel_Info_ExtraAttribute, self:GetCenterContentTable_UITable(),LuaEnumItemInfoModuleType.ExtraAttribute)
        extraAttribute:RefreshWithInfo(self.commonData)
    end
end

---刷新底部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_AssistPart:RefreshLowerArea()
    self:AddLowerFixedArea();
    if CS.Cfg_GlobalTableManager.Instance:ShowItemDescription(self.commonData.itemInfo) then
        --道具描述
        if self.commonData ~= nil and self.commonData.itemInfo and self.commonData.itemInfo.tips2Specified then
            local tips2 = self:CreateTemplateUnderArea(self:GetInfoTemplate_SingleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_SingleLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.ItemDescription)
            tips2:RefreshWithInfo(self.commonData)
        end
    end
    self:ShowButtonAreaDescription(self.commonData.itemInfo)
    --物品列表
    if self.commonData ~= nil and self.commonData.itemInfo ~= nil and self.commonData.getItemList ~= nil and self.commonData.getItemList.Count > 0 then
        local getItemListTemplate = self:CreateTemplateUnderArea(self:GetItemListTemplate_GO(), luaComponentTemplates.UIItemInfoPanel_Info_ItemList, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.ItemList)
        getItemListTemplate:RefreshWithInfo(self.commonData)
    end
    --获取途径信息
    if self.commonData ~= nil and self.commonData.itemInfo then
        self.wayGetRead = self:CreateTemplateUnderArea(self:GetInfoTemplate_DoubleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_WaygetSignetLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.WayGetDescription)
        self.wayGetRead:RefreshWithInfo(self.commonData)
    end
end

---显示道具底部描述(禅道单82977修改底部描述)
function UIItemInfoPanel_AssistPart:ShowButtonAreaDescription()
    if self.commonData ~= nil and self.commonData.itemInfo then
        local bottomDes = self:CreateTemplateUnderArea(self:GetInfoTemplate_DoubleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_DoubleLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.ItemDescription2)
        bottomDes:RefreshWithInfo(self.commonData)
    end
end

---底部可能会增加各种各样的
function UIItemInfoPanel_AssistPart:AddLowerFixedArea()
    self:AddSkillDescArea()
end

function UIItemInfoPanel_AssistPart:AddSkillDescArea()
    ---@type UIItemInfoPanel_Info_FixLowerSkill
    local bottomDes = self:CreateTemplateUnderArea(self:GetInfoTemplate_SkillDesc_GO(), luaComponentTemplates.UIItemInfoPanel_Info_FixLowerSkill,
            self:GetLowerContentTable_UITable(), LuaEnumItemInfoModuleType.ItemFixLowerSkill)
    bottomDes:RefreshWithInfo(self.commonData)
end

---刷新左上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_AssistPart:RefreshTopLeftArea()
    --显示操作按钮
    if self.commonData ~= nil and self.commonData.TabBagItemInfoTable ~= nil then
        local buttons = self:CreateTemplateUnderArea(self:GetTopButtons_GO(), luaComponentTemplates.UIItemInfoPanel_Info_LeftTopOperateButtons, self:GetLeftTopTable_UITable(),LuaEnumItemInfoModuleType.PageOperate)
        buttons:RefreshWithInfo(self.commonData)
    end
end

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_AssistPart:RefreshRightUpArea(bagItemInfo, itemInfo)
    if self.commonData ~= nil and self.commonData.itemInfo then
        ---@type UIItemInfoPanel_Info_RightUpOperateButtons
        local buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_RightButtons_Go(), self:GetRightUpButtonsModule(luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons), self:GetUpRightTable_UITable(),LuaEnumItemInfoModuleType.RightUpOperate)
        buttons:RefreshWithInfo(self.commonData)
    end
end

---刷新右下角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_AssistPart:RefreshRightDownArea(bagItemInfo, itemInfo, isMainPlayer)

end
return UIItemInfoPanel_AssistPart