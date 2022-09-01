---@class BloodSuitItemInfo_MainPart:UIItemInfoPanel_PartBasic
local BloodSuitItemInfo_MainPart = {}

setmetatable(BloodSuitItemInfo_MainPart, luaComponentTemplates.UIItemInfoPanel_MainPart)

---刷新顶部区域
---@param commonData table
function BloodSuitItemInfo_MainPart:RefreshUpperArea(commonData)
    if self.commonData ~= nil and self.commonData.bagItemInfo and self.commonData.itemInfo then
        local bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(self.commonData.itemInfo.id)
        if bloodsuitTbl then
            if bloodsuitTbl:GetType() == 1 then
                --灵兽蛋
                --显示物品ICON和基础信息
                local uiItem = self:CreateTemplateUnderArea(self:GetInfoTemplate_UIItem_GO(),
                        luaComponentTemplates.UIItemInfoPanel_ServentUpInfo, self:GetUpperContentTable_UITable(), LuaEnumItemInfoModuleType.IconAndBaseMsg)
                uiItem:RefreshWithInfo(self.commonData)
            else
                --灵兽肉身
                --显示物品ICON和基础信息
                ---@type UIItemInfoPanel_ServantBody_UIItem
                local uiItem = self:CreateTemplateUnderArea(self:GetInfoTemplate_UIItem_GO(), luaComponentTemplates.UIItemInfoPanel_ServantBody_UIItem, self:GetUpperContentTable_UITable(), LuaEnumItemInfoModuleType.IconAndBaseMsg)
                uiItem:RefreshWithInfo(self.commonData)
            end
        end
    end
end

---刷新中央区域
---@param commonData table
function BloodSuitItemInfo_MainPart:RefreshCenterArea(commonData)
    --额外属性
    if self.commonData ~= nil and self.commonData.bagItemInfo and self.commonData.itemInfo and (self.commonData.itemInfoSource == nil
            or self.commonData.itemInfoSource ~= luaEnumItemInfoSource.UIREFINERESULT) then
        ---@type BloodSuitItemInfoComp_ExtraAttribute
        local extraAttribute = self:CreateTemplateUnderArea(self:GetExtraAttribute_GO(), luaComponentTemplates.UIItemInfoPanel_Info_BloodSuitExtraAttribute,
                self:GetCenterContentTable_UITable(), LuaEnumItemInfoModuleType.ExtraAttribute)
        extraAttribute:RefreshWithInfo(self.commonData)
    end
end

-----刷新底部区域
-----@param commonData table
--function BloodSuitItemInfo_MainPart:RefreshLowerArea(commonData)
--    self:ShowButtonAreaDescription()
--    --获取途径信息
--    if self.commonData ~= nil and self.commonData.itemInfo then
--        self.wayGetRead = self:CreateTemplateUnderArea(self:GetInfoTemplate_DoubleLine_GO(), luaComponentTemplates.UIItemInfoPanel_Info_WaygetSignetLine, self:GetLowerContentTable_UITable(),LuaEnumItemInfoModuleType.WayGetDescription)
--        self.wayGetRead:RefreshWithInfo(self.commonData)
--    end
--end

return BloodSuitItemInfo_MainPart