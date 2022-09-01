local UIGuildSmeltBagPanel_StorageGridTemplate = {}

setmetatable(UIGuildSmeltBagPanel_StorageGridTemplate,luaComponentTemplates.UIGuildBagPanel_StorageGridTemplate)

---单击
function UIGuildSmeltBagPanel_StorageGridTemplate:OnSingleClicked()
    if self.OneItemAllInfo and self.OneItemAllInfo.ItemTABLE then
        local data = {}
        data.BagItemInfo = self.OneItemAllInfo
        if data.BagItemInfo ~= nil then
            data.AuctionInfo = luaclass.UnionSmeltDataInfo:GetUnionSmeltWareHouseAuctionItem(data.BagItemInfo.lid)
        end
        ---@type UIAuctionPanel_SmeltItem
        data.Template = luaComponentTemplates.UIAuctionPanel_GuildSmeltWareItem
        uimanager:CreatePanel('UIAuctionItemPanel', nil, data)
    end
end

return UIGuildSmeltBagPanel_StorageGridTemplate