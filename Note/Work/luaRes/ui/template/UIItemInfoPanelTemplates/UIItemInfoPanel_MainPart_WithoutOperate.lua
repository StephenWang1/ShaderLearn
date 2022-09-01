---@type 物品信息界面子界面
local UIItemInfoPanel_MainPart_WithoutOperate = {}

setmetatable(UIItemInfoPanel_MainPart_WithoutOperate, luaComponentTemplates.UIItemInfoPanel_MainPart)

---刷新底部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_MainPart_WithoutOperate:RefreshLowerArea(bagItemInfo, itemInfo)

end

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_MainPart_WithoutOperate:RefreshRightUpArea(bagItemInfo, itemInfo, isMainPlayer)

end

---刷新右下角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_MainPart_WithoutOperate:RefreshRightDownArea(bagItemInfo, itemInfo, isMainPlayer)
end

return UIItemInfoPanel_MainPart_WithoutOperate