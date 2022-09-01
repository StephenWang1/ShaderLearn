---@type 物品信息界面子界面
local UIItemInfoPanel_ServentFragmentMainPart = {}

setmetatable(UIItemInfoPanel_ServentFragmentMainPart, luaComponentTemplates.UIItemInfoPanel_PartBasic)

---刷新顶部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServentFragmentMainPart:RefreshUpperArea()
    local uiItem = self:CreateTemplateUnderArea(self:GetInfoTemplate_UIItem_GO(), luaComponentTemplates.UIItemInfoPanel_ServentUpInfo, self:GetUpperContentTable_UITable(),LuaEnumItemInfoModuleType.IconAndBaseMsg)
    uiItem:RefreshWithInfo(self.commonData)
end

---刷新中央区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServentFragmentMainPart:RefreshCenterArea()
    --显示当前灵兽碎片数量
    if self.commonData ~= nil and self.commonData.itemInfo then
        local serventFragmentNum = self:CreateTemplateUnderArea(self:GetInfoTemplate_SingleLine_GO(), luaComponentTemplates.UIItemInfoPanel_ServentFragmentNum, self:GetCenterContentTable_UITable(),LuaEnumItemInfoModuleType.BaseAttribute)
        serventFragmentNum:RefreshWithInfo(self.commonData)
    end
end

---刷新底部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServentFragmentMainPart:RefreshLowerArea()
    if self.commonData ~= nil and self.commonData.itemInfo.type ~= luaEnumItemType.Equip then
        --道具描述
        if self.commonData.itemInfo and self.commonData.itemInfo.tips2Specified then
            local tips2 = self:CreateTemplateUnderArea(self:GetInfoTemplate_SingleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_SingleLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.ItemDescription)
            tips2:RefreshWithInfo(self.commonData)
        end
    end
    self:ShowButtonAreaDescription()
    --获取途径信息
    if self.commonData ~= nil and self.commonData.bagItemInfo then
        self.wayGetRead = self:CreateTemplateUnderArea(self:GetInfoTemplate_DoubleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_WaygetSignetLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.WayGetDescription)
        self.wayGetRead:RefreshWithInfo(self.commonData)
    end
end

---显示灵兽碎片道具底部描述（禅道单82977修改底部描述）
function UIItemInfoPanel_ServentFragmentMainPart:ShowButtonAreaDescription()
    if self.commonData ~= nil and self.commonData.itemInfo then
        local bottomDes = self:CreateTemplateUnderArea(self:GetInfoTemplate_DoubleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_DoubleLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.ItemDescription2)
        bottomDes:RefreshWithInfo(self.commonData.itemInfo)
    end
end

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServentFragmentMainPart:RefreshRightUpArea()
    --显示操作按钮
    if self.commonData ~= nil and self.commonData.itemInfo then
        local buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_RightButtons_Go(), self:GetRightUpButtonsModule(luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons), self:GetUpRightTable_UITable(),LuaEnumItemInfoModuleType.RightUpOperate)
        buttons:RefreshWithInfo(self.commonData)
    end
end

---刷新右下角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServentFragmentMainPart:RefreshRightDownArea()
    --显示操作按钮
    if self.commonData ~= nil and self.commonData.bagItemInfo then
        local buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_RightDownButtons_Go(), luaComponentTemplates.UIItemInfoPanel_Info_RightDownOperateButtons, self:GetDownRightTable_UITable(),LuaEnumItemInfoModuleType.RightDownOperate)
        buttons:RefreshWithInfo(self.commonData)
    end
end
return UIItemInfoPanel_ServentFragmentMainPart