---@class FaZhenEquipItemInfo_UIItem:UIItemInfoPanel_Info_UIItem 法阵主面板
local FaZhenEquipItemInfo_UIItem = {}

setmetatable(FaZhenEquipItemInfo_UIItem, luaComponentTemplates.UIItemInfoPanel_Info_UIItem)

---刷新重量
function FaZhenEquipItemInfo_UIItem:RefreshWeight()
    local itemLv = clientTableManager.cfg_suitManager:GetSuitPartLv(self.ItemInfo.id)
    local subTypeName = LuaGlobalTableDeal:GetFaZhenSubtypeName(self.ItemInfo.subType)
    if type(itemLv) == 'number' and CS.StaticUtility.IsNullOrEmpty(subTypeName) == false then
        local showLv = CS.Utility_Lua.ArabicNumeralsToWordNumbers(itemLv) .. "级"
        self:GetWeight_UILabel().text = "类型  " .. showLv .. subTypeName
    else
        luaclass.UIRefresh:RefreshActive(self:GetWeight_UILabel(),false)
    end
end

return FaZhenEquipItemInfo_UIItem