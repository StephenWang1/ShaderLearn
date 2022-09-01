---@class BingJianEquipItemInfo_MainPart:UIItemInfoPanel_MainPart 法阵主面板
local BingJianEquipItemInfo_MainPart = {}

setmetatable(BingJianEquipItemInfo_MainPart, luaComponentTemplates.UIItemInfoPanel_MainPart)

function BingJianEquipItemInfo_MainPart:RefreshCenterArea()
    if self.commonData ~= nil and self.commonData.itemInfo then
        local itemInfo = self:CreateTemplateUnderArea(self:GetInfoTemplate_SLEquip_GO(), luaComponentTemplates.UIItemInfoPanel_Info_BingJian, self:GetCenterContentTable_UITable(), LuaEnumItemInfoModuleType.BingJianInfo)
        itemInfo:RefreshWithInfo(self.commonData)
    end
    if self.commonData ~= nil and self.commonData.itemInfo then
        local extraAttribute = self:CreateTemplateUnderArea(self:GetExtraAttribute_GO(), luaComponentTemplates.UIItemInfoPanel_Info_ExtraAttribute_BingJian, self:GetCenterContentTable_UITable(),LuaEnumItemInfoModuleType.ExtraAttribute)
        extraAttribute:RefreshWithInfo(self.commonData)
    end

end

return BingJianEquipItemInfo_MainPart