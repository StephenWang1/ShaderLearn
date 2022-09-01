---仓库重写灵兽蛋Tips
---@class UIWarehousePanel_ServantEggMainPart:UIItemInfoPanel_ServentMainPart
local UIWarehousePanel_ServantEggMainPart = {}
setmetatable(UIWarehousePanel_ServantEggMainPart, luaComponentTemplates.UIItemInfoPanel_ServentMainPart)

---刷新右上角区域（重写右上角按钮）
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIWarehousePanel_ServantEggMainPart:RefreshRightUpArea(bagItemInfo, itemInfo, isMainPlayer)
    --显示操作按钮
    if bagItemInfo then
        local buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_RightButtons_Go(), self:GetRightUpButtonsModule(), self:GetUpRightTable_UITable())
        buttons:RefreshWithInfo(bagItemInfo, itemInfo, true)
    end
end

---刷新底部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIWarehousePanel_ServantEggMainPart:RefreshLowerArea(bagItemInfo, itemInfo)
    self:ShowButtonAreaDescription(itemInfo)
end

return UIWarehousePanel_ServantEggMainPart