---背包界面被拖拽的物品
---@class UIBagDraggedItem:UIBagTypeDraggableItem
local UIBagDraggedItem = {}

setmetatable(UIBagDraggedItem, luaComponentTemplates.UIBagType_DraggableItem)

return UIBagDraggedItem