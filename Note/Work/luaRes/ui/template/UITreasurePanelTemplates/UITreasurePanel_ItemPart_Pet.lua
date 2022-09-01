---@type 物品信息界面子界面
local UITreasurePanel_ItemPart_Pet = {}

setmetatable(UITreasurePanel_ItemPart_Pet, luaComponentTemplates.UIItemInfoPanel_ServentMainPart)

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UITreasurePanel_ItemPart_Pet:RefreshRightUpArea(bagItemInfo, itemInfo, isMainPlayer)
    --显示操作按钮
        local buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_RightButtons_Go(), self:GetRightUpButtonsModule(), self:GetUpRightTable_UITable())
        buttons:RefreshWithInfo(bagItemInfo, itemInfo, isMainPlayer)
end

return UITreasurePanel_ItemPart_Pet