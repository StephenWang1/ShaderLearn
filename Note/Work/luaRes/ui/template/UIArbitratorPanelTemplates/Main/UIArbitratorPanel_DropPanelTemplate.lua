local UIArbitratorPanel_DropPanelTemplate = {}
setmetatable(UIArbitratorPanel_DropPanelTemplate,luaComponentTemplates.UIArbitratorPanelTemplate)
function UIArbitratorPanel_DropPanelTemplate:RefreshPanel()
    self:RunBaseFunction("RefreshPanel")
    self:InitItemList({bagItemList = self:GetDropItemListByTypeTable({LuaEnumDropDataType.Drop_FreeGetItem,LuaEnumDropDataType.Drop_WaitGetItem}),
                       gridTemplate = luaComponentTemplates.UIArbitratorPanel_DropGridTemplate})
    self:ShowPanel()
end

return UIArbitratorPanel_DropPanelTemplate