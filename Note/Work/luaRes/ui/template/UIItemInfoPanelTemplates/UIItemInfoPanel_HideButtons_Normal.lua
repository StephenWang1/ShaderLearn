---@type 物品信息界面子界面(无按钮)
---@class UIItemInfoPanel_HideButtons_Normal:UIItemInfoPanel_MainPart
local UIItemInfoPanel_HideButtons_Normal = {}
setmetatable(UIItemInfoPanel_HideButtons_Normal, luaComponentTemplates.UIItemInfoPanel_MainPart)

---刷新底部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_HideButtons_Normal:RefreshLowerArea(bagItemInfo, itemInfo)
    --道具描述
    if itemInfo.type ~= luaEnumItemType.Equip then
        if itemInfo and itemInfo.tips2Specified then
            local tips2 = self:CreateTemplateUnderArea(self:GetInfoTemplate_SingleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_SingleLine, self:GetLowerContentTable_UITable())
            tips2:RefreshWithInfo(itemInfo.tips2)
        end
    end
    self:ShowButtonAreaDescription(itemInfo)
end

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_HideButtons_Normal:RefreshRightUpArea(bagItemInfo, itemInfo)
end

return UIItemInfoPanel_HideButtons_Normal