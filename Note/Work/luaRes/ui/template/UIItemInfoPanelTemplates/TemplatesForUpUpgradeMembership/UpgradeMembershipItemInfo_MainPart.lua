local UpgradeMembershipItemInfo_MainPart = {}
setmetatable(UpgradeMembershipItemInfo_MainPart,luaComponentTemplates.UIItemInfoPanel_MainPart)

---刷新右上角区域
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS
function UpgradeMembershipItemInfo_MainPart:RefreshRightUpArea()
    --显示操作按钮
    if self.commonData ~= nil and self.commonData.itemInfo then
        ---@type UIItemInfoPanel_Info_RightUpOperateButtons
        local buttons = self:CreateTemplateUnderArea(self:GetInfoTemplate_RightButtons_Go(), self:GetRightUpButtonsModule(luaComponentTemplates.UpgradeMembershipItemInfo_RightUpOperateButtons), self:GetUpRightTable_UITable(),LuaEnumItemInfoModuleType.RightUpOperate)
        buttons:RefreshWithInfo(self.commonData)
    end
end
return UpgradeMembershipItemInfo_MainPart