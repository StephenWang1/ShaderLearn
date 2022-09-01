---@class UICollectionTypeContainerInteraction_OtherPlayer:UICollectionTypeContainerInteraction
local UICollectionTypeContainerInteraction_OtherPlayer = {}

setmetatable(UICollectionTypeContainerInteraction_OtherPlayer, luaComponentTemplates.UICollectionTypeContainerInteraction)

---空格子是否可以交互
---@return boolean
function UICollectionTypeContainerInteraction_OtherPlayer:IsEmptyGridInteractionAvailable()
    return false
end

---单击是否可用
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@return boolean
function UICollectionTypeContainerInteraction_OtherPlayer:IsSingleClickedAvailable(grid, mCollectionItem)
    return true
end

---双击是否可用
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@return boolean
function UICollectionTypeContainerInteraction_OtherPlayer:IsDoubleClickedAvailable(grid, mCollectionItem)
    return false
end

---长按是否可用
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@return boolean
function UICollectionTypeContainerInteraction_OtherPlayer:IsLongPressAvailable(grid, mCollectionItem)
    return false
end

---长按后拖拽是否可用
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@return boolean
function UICollectionTypeContainerInteraction_OtherPlayer:IsDragAvailable(grid, mCollectionItem)
    return false
end

return UICollectionTypeContainerInteraction_OtherPlayer