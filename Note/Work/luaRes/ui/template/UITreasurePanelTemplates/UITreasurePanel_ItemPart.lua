---@type 物品信息界面子界面
local UITreasurePanel_ItemPart = {}

setmetatable(UITreasurePanel_ItemPart, luaComponentTemplates.UIItemInfoPanel_MainPart)

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UITreasurePanel_ItemPart:RefreshRightUpArea(bagItemInfo, itemInfo, isMainPlayer)
    --显示操作按钮
        local buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_RightButtons_Go(), self:GetRightUpButtonsModule(), self:GetUpRightTable_UITable())
        buttons:RefreshWithInfo(bagItemInfo, itemInfo, isMainPlayer)
end

return UITreasurePanel_ItemPart