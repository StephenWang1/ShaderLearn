---聚灵珠Tips模板
---@class UIItemInfoPanel_GatheringBeads_MainPart:UIItemInfoPanel_MainPart
local UIItemInfoPanel_GatheringBeads_MainPart = {}
setmetatable(UIItemInfoPanel_GatheringBeads_MainPart, luaComponentTemplates.UIItemInfoPanel_MainPart)

---@return UIItemInfoPanel_GatheringBeads_UIItem
function UIItemInfoPanel_GatheringBeads_MainPart:GetUIItemTemplate()
    if (self.mUIItem == nil) then
        self.mUIItem = self:CreateTemplateUnderArea(self:GetInfoTemplate_UIItem_GO(), luaComponentTemplates.UIItemInfoPanel_GatheringBeads_UIItem, self:GetUpperContentTable_UITable())
    end
    return self.mUIItem;
end

--region 显示方法
---使用背包物品信息刷新
---@param bagItemInfo bagV2.BagItemInfo
function UIItemInfoPanel_GatheringBeads_MainPart:RefreshWithBagItemInfo(data)
    if data then
        self.BagItemInfo = data.BagItemInfo
        self.ItemInfo = data.ItemInfo
        self.GatheringBeadsInfo = data.GatheringBeadsData
        self:RefreshUpperArea(self.BagItemInfo, self.ItemInfo, self.GatheringBeadsInfo)
        self:RefreshCenterArea(self.BagItemInfo, self.ItemInfo, nil)
        self:RefreshLowerArea(self.BagItemInfo, self.ItemInfo)
        self:RefreshRightUpArea(self.BagItemInfo, self.ItemInfo, true, self.GatheringBeadsInfo)
        self:RefreshRightDownArea(self.BagItemInfo, self.ItemInfo, true)
        self:CheckCenterAreaHaveContent()
        self:AdjustPartSize()
    end
end

function UIItemInfoPanel_GatheringBeads_MainPart:RefreshUpperArea(bagItemInfo, itemInfo, gatheringInfo)
    self:GetUIItemTemplate():RefreshWithInfo(bagItemInfo, itemInfo, gatheringInfo)
end

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_GatheringBeads_MainPart:RefreshRightUpArea(bagItemInfo, itemInfo, isMainPlayer, gatheringInfo)
    --显示操作按钮
    if bagItemInfo then
        local buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_RightButtons_Go(), self:GetRightUpButtonsModule(), self:GetUpRightTable_UITable())
        buttons:RefreshWithInfo(bagItemInfo, itemInfo, isMainPlayer, gatheringInfo)
    end
end

return UIItemInfoPanel_GatheringBeads_MainPart