---@class UIMedalInlayPanelConsumablesUnitTemplate:UIMedalInlayPanelMosaicUnitTemplate 消耗位模板
local UIMedalInlayPanelConsumablesUnitTemplate = {}

setmetatable(UIMedalInlayPanelConsumablesUnitTemplate, luaComponentTemplates.UIMosaicUnitTemplate)

--region Show

--function UIMedalInlayPanelConsumablesUnitTemplate:SetTemplate(customData)
--    self:RunBaseFunction("SetTemplate", customData)
--    self.normalItemID = customData.normalItemID
--end

--function UIMedalInlayPanelConsumablesUnitTemplate:SetInfo(bagItemInfo, isEquip, isShow)
--    self:RunBaseFunction("SetInfo", bagItemInfo, isEquip, isShow)
--    self.add:SetActive(false)
--end

--function UIMedalInlayPanelConsumablesUnitTemplate:InitSprite()
--    if self.normalItemID == nil then
--        return
--    end
--    local isFind, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.normalItemID)
--    if isFind then
--        self.item:SetActive(true)
--        self.icon.spriteName = info.icon
--        self.icon.color = LuaEnumUnityColorType.Gray
--    end
--end

function UIMedalInlayPanelConsumablesUnitTemplate:ShowUnitItemInfo(isNull)
    if isNull then
        self.endurance.text = ''
        self.lb.text = '经验勋章'
        self.btn_replace:SetActive(false)
    else
        if isShow then
            self.lb.text = CS.Cfg_ItemsTableManager.Instance:GetDoubleMedalName(self.bagInfo.ItemTABLE.id)
            self.btn_replace:SetActive(false)
        else
            self.lb.text = self.bagInfo.ItemFullName
            self.icon.color = LuaEnumUnityColorType.White
            self.btn_replace:SetActive(true)
        end
    end
end

--仅清理
--function UIMedalInlayPanelConsumablesUnitTemplate:ClearInfo()
--    self:SetInfo(nil, false, false)
--    self.icon.spriteName = ''
--    self.add:SetActive(true)
--    self.bagInfo = nil
--    self.lid = 0
--    self.itemTab = nil
--    self.endurance.text = ''
--end

--endregion


return UIMedalInlayPanelConsumablesUnitTemplate