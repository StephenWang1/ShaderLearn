---@class RefineMgr:luaobject 炼化管理类
local RefineMgr = {}

--region 查询
---是否是精炼石
---@param itemId number
---@return boolean
function RefineMgr:IsRefineStone(itemId)
    local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    return itemInfo ~= nil and itemInfo:GetType() == luaEnumItemType.Material and itemInfo:GetSubType() == 23
end
--endregion

return RefineMgr