---@type 物品信息界面子界面
local UIItemInfoPanel_ServentMainPartNoButton = {}

setmetatable(UIItemInfoPanel_ServentMainPartNoButton, luaComponentTemplates.UIItemInfoPanel_ServentMainPart)

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServentMainPartNoButton:RefreshRightUpArea(bagItemInfo, itemInfo, isMainPlayer)
    ----显示操作按钮
    --if bagItemInfo then
    --    local buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_RightButtons_Go(), luaComponentTemplates.UIItemInfoPanel_Info_RightUpOperateButtons, self:GetUpRightTable_UITable())
    --    buttons:RefreshWithInfo(bagItemInfo, itemInfo, true)
    --end
end
return UIItemInfoPanel_ServentMainPartNoButton