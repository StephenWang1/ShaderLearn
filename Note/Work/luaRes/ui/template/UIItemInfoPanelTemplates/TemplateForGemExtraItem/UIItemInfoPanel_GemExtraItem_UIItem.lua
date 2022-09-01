local UIItemInfoPanel_GemExtraItem_UIItem = {}
setmetatable(UIItemInfoPanel_GemExtraItem_UIItem, luaComponentTemplates.UIItemInfoPanel_Info_UIItem)

function UIItemInfoPanel_GemExtraItem_UIItem:RefreshUIItem()
    if self:GetUIItemRoot_GameObject() and CS.StaticUtility.IsNull(self:GetUIItemRoot_GameObject()) == false then
        local extraEquipList = self.ExtraEquipList
        local itemInfo = self.ItemInfo
        local bagItemInfo = self.BagItemInfo
        if (extraEquipList ~= nil) then
            self:GetUIItem_UIItemInfoPanel():AddExtraEquips(extraEquipList);
        end
        if bagItemInfo then
            self:GetUIItem_UIItemInfoPanel():RefreshUIWithBagItemInfo(bagItemInfo)
        else
            self:GetUIItem_UIItemInfoPanel():RefreshUIWithItemInfo(itemInfo)
        end
        self:GetUIItem_UIItemInfoPanel():RefreshName(CS.Cfg_GlobalTableManager.Instance:GemGetItemIdByEquipIndex(self.ItemInfo.subType))
        self:GetUIItem_UIItemInfoPanel():RefreshGemIconBySubType(CS.Cfg_GlobalTableManager.Instance:GetGemSubTypeByGemExtraSubType(self.ItemInfo.subType),true)
        self:GetUIItem_UIItemInfoPanel():GetItemIcon_UISprite().spriteName = CS.Cfg_GlobalTableManager.Instance:GetIconNameByGemExtraSubType(self.ItemInfo.subType)
    end
end

return UIItemInfoPanel_GemExtraItem_UIItem