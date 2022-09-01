---@class BetterItemHintItem_BloodEquip:BetterItemHintItem_Base 血继推送物品
local BetterItemHintItem_BloodEquip = {}

setmetatable(BetterItemHintItem_BloodEquip,luaclass.BetterItemHintItem_Base)

--region 数据
---@type TABLE.cfg_bloodsuit 血继套装表
BetterItemHintItem_BloodEquip.bloodSuitTable = nil
--endregion

--region 刷新
---数据刷新
---@param bagItemInfo bagV2.BagItemInfo
function BetterItemHintItem_BloodEquip:RefreshData(bagItemInfo)
    self:RunBaseFunction("RefreshData",bagItemInfo)
    if bagItemInfo ~= nil then
        self.bloodSuitTable = clientTableManager.cfg_bloodsuitManager:TryGetValue(bagItemInfo.itemId)
    end
end
--endregion

return BetterItemHintItem_BloodEquip