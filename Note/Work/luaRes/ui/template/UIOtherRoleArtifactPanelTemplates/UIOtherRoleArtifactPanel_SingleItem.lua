---@class UIOtherRoleArtifactPanel_SingleItem:UIRoleArtifactPanel_SingleItem 其他玩家法宝单个装备模板
local UIOtherRoleArtifactPanel_SingleItem = {}

setmetatable(UIOtherRoleArtifactPanel_SingleItem,luaComponentTemplates.UIRoleArtifactPanel_SingleItem)

---刷新Add
function UIOtherRoleArtifactPanel_SingleItem:RefreshAdd()
    self:RefreshActive(self.Add_GameObject,false)
end

---物品点击
function UIOtherRoleArtifactPanel_SingleItem:ItemOnClick()
    if self.equipItemData == nil then
        return
    end
    local haveEquip = self:GridHaveEquip()
    if haveEquip then
        uiStaticParameter.UIItemInfoManager:CreatePanel({bagItemInfo = self.equipItemData.BagItemInfo,showRight = false,itemInfoSource = luaEnumItemInfoSource.UIOTHERROLEPANEL,showAssistPanel = true})
    end
end

return UIOtherRoleArtifactPanel_SingleItem