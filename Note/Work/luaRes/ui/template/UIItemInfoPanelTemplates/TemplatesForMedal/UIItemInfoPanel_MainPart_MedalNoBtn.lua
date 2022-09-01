---@type 勋章信息界面子界面
---@class UIItemInfoPanel_MainPart_MedalNoBtn:UIItemInfoPanel_MainPart_Medal
local UIItemInfoPanel_MainPart_MedalNoBtn = {}
setmetatable(UIItemInfoPanel_MainPart_MedalNoBtn, luaComponentTemplates.UIItemInfoPanel_MainPart_Medal)

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_MainPart_MedalNoBtn:RefreshRightUpArea(bagItemInfo, itemInfo, isMainPlayer)
    --显示操作按钮
end

---刷新右下角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_MainPart_MedalNoBtn:RefreshRightDownArea(bagItemInfo, itemInfo, isMainPlayer)
    --显示操作按钮
end

return UIItemInfoPanel_MainPart_MedalNoBtn