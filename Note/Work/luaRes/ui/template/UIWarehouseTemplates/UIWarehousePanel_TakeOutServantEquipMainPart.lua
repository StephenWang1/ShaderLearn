---仓库重写灵兽装备Tips(取出)
---@class UIWarehousePanel_TakeOutServantEquipMainPart:UIItemInfoPanel_ServantEquipMainPart
local UIWarehousePanel_TakeOutServantEquipMainPart = {}
setmetatable(UIWarehousePanel_TakeOutServantEquipMainPart, luaComponentTemplates.UIItemInfoPanel_ServantEquipMainPart)

---刷新右上角区域（重写右上角按钮）
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIWarehousePanel_TakeOutServantEquipMainPart:RefreshRightUpArea(bagItemInfo, itemInfo, isMainPlayer)
    --显示操作按钮
    if bagItemInfo then
        local buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_RightButtons_Go(), self:GetRightUpButtonsModule(), self:GetUpRightTable_UITable())
        buttons:RefreshWithInfo(bagItemInfo, itemInfo, isMainPlayer)
    end
end

---刷新底部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIWarehousePanel_TakeOutServantEquipMainPart:RefreshLowerArea(bagItemInfo, itemInfo)
    --道具描述
    if itemInfo.type ~= luaEnumItemType.Equip then
        if itemInfo and itemInfo.tips2Specified then
            local tips2 = self:CreateTemplateUnderArea(self:GetInfoTemplate_SingleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_SingleLine, self:GetLowerContentTable_UITable())
            tips2:RefreshWithInfo(itemInfo.tips2)
        end
    end
    self:ShowButtonAreaDescription(itemInfo)
end

return UIWarehousePanel_TakeOutServantEquipMainPart