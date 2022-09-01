----@type 物品信息界面子界面（灵兽蛋无按钮）
---@class UIItemInfoPanel_HideButtons_ServantEgg:UIItemInfoPanel_ServentMainPart
local UIItemInfoPanel_HideButtons_ServantEgg = {}
setmetatable(UIItemInfoPanel_HideButtons_ServantEgg, luaComponentTemplates.UIItemInfoPanel_ServentMainPart)

---刷新底部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_HideButtons_ServantEgg:RefreshLowerArea(bagItemInfo, itemInfo)
    self:ShowButtonAreaDescription(itemInfo)
end

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_HideButtons_ServantEgg:RefreshRightUpArea(bagItemInfo, itemInfo, isMainPlayer)
end

---刷新右下角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_HideButtons_ServantEgg:RefreshRightDownArea(bagItemInfo, itemInfo, isMainPlayer)
end

return UIItemInfoPanel_HideButtons_ServantEgg