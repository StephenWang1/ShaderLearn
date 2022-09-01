local UIItemInfoPanel_Info_WaygetSignetLine = {}
setmetatable(UIItemInfoPanel_Info_WaygetSignetLine, luaComponentTemplates.UIItemInfoPanel_Info_DoubleLine)

---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_WaygetSignetLine:RefreshWithInfo(commonData)
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    if bagItemInfo ~= nil and bagItemInfo.lid ~= nil then
        self.wayGetContent = CS.CSScene.MainPlayerInfo.BagInfo:GetGetWayTextByFromInfo(bagItemInfo)
    elseif itemInfo ~= nil then
        self.wayGetContent = CS.CSScene.MainPlayerInfo.BagInfo:GetGetWayByItemInfo(itemInfo.id)
    end
    if self.wayGetContent == "" then
        self.go:SetActive(false)
        return
    end
    self:GetText1Label_UILabel().gameObject:SetActive(false)
    self:GetTextLabel_UILabel().text = self.wayGetContent
end
return UIItemInfoPanel_Info_WaygetSignetLine