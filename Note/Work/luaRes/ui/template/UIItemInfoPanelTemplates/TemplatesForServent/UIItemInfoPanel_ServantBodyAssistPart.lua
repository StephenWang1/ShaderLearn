---@class UIItemInfoPanel_ServantBodyAssistPart :UIItemInfoPanel_ServantBodyMainPart
local UIItemInfoPanel_ServantBodyAssistPart = {}

setmetatable(UIItemInfoPanel_ServantBodyAssistPart, luaComponentTemplates.UIItemInfoPanel_ServantBodyMainPart)

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServantBodyAssistPart:RefreshRightUpArea()
end

---刷新底部区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServantBodyAssistPart:RefreshLowerArea()
    if self.commonData ~= nil and self.commonData.itemInfo.type ~= luaEnumItemType.Equip then
        --道具描述
        if self.commonData.itemInfo and self.commonData.itemInfo.tips2Specified then
            local tips2 = self:CreateTemplateUnderArea(self:GetInfoTemplate_SingleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_SingleLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.ItemDescription)
            tips2:RefreshWithInfo(self.commonData)
        end
    end
    --显示道具底部描述
    self:ShowButtonAreaDescription(self.commonData.itemInfo)
    --获取途径信息
    if self.commonData ~= nil and self.commonData.itemInfo then
        self.wayGetRead = self:CreateTemplateUnderArea(self:GetInfoTemplate_DoubleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_WaygetSignetLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.WayGetDescription)
        self.wayGetRead:RefreshWithInfo(self.commonData)
    end
end

---刷新左上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_ServantBodyAssistPart:RefreshTopLeftArea()
    --显示操作按钮
    if self.commonData ~= nil and self.commonData.TabBagItemInfoTable ~= nil then
        local buttons = self:CreateTemplateUnderArea(self:GetTopButtons_GO(), luaComponentTemplates.UIItemInfoPanel_Info_LeftTopOperateButtons, self:GetLeftTopTable_UITable(),LuaEnumItemInfoModuleType.PageOperate)
        buttons:RefreshWithInfo(self.commonData)
    end
end

return UIItemInfoPanel_ServantBodyAssistPart