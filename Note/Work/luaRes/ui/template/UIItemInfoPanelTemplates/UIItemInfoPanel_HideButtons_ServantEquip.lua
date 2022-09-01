---灵兽肉身无按钮Tips
---@class UIItemInfoPanel_HideButtons_ServantEquip:UIItemInfoPanel_ServantEquipMainPart
local UIItemInfoPanel_HideButtons_ServantEquip = {}
setmetatable(UIItemInfoPanel_HideButtons_ServantEquip, luaComponentTemplates.UIItemInfoPanel_ServantEquipMainPart)

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_HideButtons_ServantEquip:RefreshRightUpArea(bagItemInfo, itemInfo, isMainPlayer)
end

---刷新右下角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_HideButtons_ServantEquip:RefreshRightDownArea(bagItemInfo, itemInfo, isMainPlayer)
end

---刷新底部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_HideButtons_ServantEquip:RefreshLowerArea(bagItemInfo, itemInfo)
    --道具描述
    if itemInfo.type ~= luaEnumItemType.Equip then
        if itemInfo and itemInfo.tips2Specified then
            local tips2 = self:CreateTemplateUnderArea(self:GetInfoTemplate_SingleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_SingleLine, self:GetLowerContentTable_UITable())
            tips2:RefreshWithInfo(itemInfo.tips2)
        end
    end
    self:ShowButtonAreaDescription(itemInfo)
end

return UIItemInfoPanel_HideButtons_ServantEquip