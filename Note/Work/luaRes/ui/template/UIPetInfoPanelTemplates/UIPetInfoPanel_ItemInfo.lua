local UIPetInfoPanel_ItemInfo = {}
setmetatable(UIPetInfoPanel_ItemInfo,luaComponentTemplates.UIItemInfoPanel_ServentMainPart)
---刷新中央区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIPetInfoPanel_ItemInfo:RefreshCenterArea(bagItemInfo, itemInfo)
    --显示基础属性
    if itemInfo then
        local baseAttribute = self:CreateTemplateUnderArea(self:GetInfoTemplate_BaseAttribute_GO(), luaComponentTemplates.UIPetInfoPanel_ItemInfo_ServantAttributeInfo, self:GetCenterContentTable_UITable())
        baseAttribute:RefreshWithInfo(bagItemInfo, itemInfo)
    end
end
return UIPetInfoPanel_ItemInfo