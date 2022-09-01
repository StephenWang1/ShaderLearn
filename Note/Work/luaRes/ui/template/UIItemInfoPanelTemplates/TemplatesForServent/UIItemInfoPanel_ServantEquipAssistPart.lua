---灵兽装备辅助界面
---@class UIItemInfoPanel_ServantEquipAssistPart:UIItemInfoPanel_ServantEquipMainPart
local UIItemInfoPanel_ServantEquipAssistPart = {}

setmetatable(UIItemInfoPanel_ServantEquipAssistPart, luaComponentTemplates.UIItemInfoPanel_ServantEquipMainPart)

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServantEquipAssistPart:RefreshRightUpArea()
end

---刷新底部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServantEquipAssistPart:RefreshLowerArea(bagItemInfo, itemInfo)
    if self.commonData ~= nil and self.commonData.itemInfo.type ~= luaEnumItemType.Equip then
        --道具描述
        if self.commonData.itemInfo and self.commonData.itemInfo.tips2Specified then
            local tips2 = self:CreateTemplateUnderArea(self:GetInfoTemplate_SingleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_SingleLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.ItemDescription)
            tips2:RefreshWithInfo(self.commonData)
        end
    end
    self:ShowButtonAreaDescription(self.commonData.itemInfo)
    --获取途径信息
    if self.commonData ~= nil and self.commonData.itemInfo then
        self.wayGetRead = self:CreateTemplateUnderArea(self:GetInfoTemplate_DoubleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_WaygetSignetLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.WayGetDescription)
        self.wayGetRead:RefreshWithInfo(self.commonData)
    end
end

---刷新左上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServantEquipAssistPart:RefreshTopLeftArea()
    --显示操作按钮
    if self.commonData ~= nil and self.commonData.TabBagItemInfoTable ~= nil then
        local buttons = self:CreateTemplateUnderArea(self:GetTopButtons_GO(), luaComponentTemplates.UIItemInfoPanel_Info_LeftTopOperateButtons, self:GetLeftTopTable_UITable(),LuaEnumItemInfoModuleType.PageOperate)
        buttons:RefreshWithInfo(self.commonData)
    end
end

return UIItemInfoPanel_ServantEquipAssistPart