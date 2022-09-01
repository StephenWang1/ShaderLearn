---@class BetterItemHintItem_SingleItem:BetterItemHintItem_Base 血继推送物品
local BetterItemHintItem_SingleItem = {}

setmetatable(BetterItemHintItem_SingleItem,luaclass.BetterItemHintItem_Base)

--region 数据
---@type table 策划配置的单个物品表
BetterItemHintItem_SingleItem.singleItemConfigTable = nil
--endregion

--region 刷新
---数据刷新
---@param bagItemInfo bagV2.BagItemInfo
---@oaran configTable table
function BetterItemHintItem_SingleItem:RefreshData(bagItemInfo,configTable)
    self:RunBaseFunction("RefreshData",bagItemInfo)
    self.singleItemConfigTable = configTable
end
--endregion

--region 查询
---当前的推送触发是否可以推送
---@param reason LuaEnumBetterItemHintReason 触发原因
---@return boolean 是否可以推送
function BetterItemHintItem_SingleItem:CheckItemCanPushByReason(reason)
    if self.singleItemConfigTable == nil then
        return false
    end
    local triggerHintReasonIdTable = self.singleItemConfigTable.triggerReasonIdTable
    return Utility.IsContainsValue(triggerHintReasonIdTable,reason)
end
--endregion

return BetterItemHintItem_SingleItem