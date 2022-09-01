---@class UIItemInfoPanel_Info_ExtraAttribute_Potential：UIItemInfoPanel_Info_ExtraAttribute 重载额外属性视图
local UIItemInfoPanel_Info_ExtraAttribute_Potential = {}
setmetatable(UIItemInfoPanel_Info_ExtraAttribute_Potential, luaComponentTemplates.UIItemInfoPanel_Info_ExtraAttribute)

---重载刷新额外属性
---@param bagItemInfo bagV2.BagItemInfo 背包信息
---@param itemInfo TABLE.CFG_ITEMS 物品信息
function UIItemInfoPanel_Info_ExtraAttribute_Potential:RefreshAttributes(bagItemInfo, itemInfo)
    local name = "潜能属性"
    local desc = CS.Utility_Lua.ReplaceSpecialCharToColor(equip_proficient:GetTips(), "[ffe36f]");
    self:AddAttribute(name, "", desc)
end

return UIItemInfoPanel_Info_ExtraAttribute_Potential