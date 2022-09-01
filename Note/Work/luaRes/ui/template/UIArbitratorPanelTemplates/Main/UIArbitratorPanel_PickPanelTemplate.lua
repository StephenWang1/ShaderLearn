local UIArbitratorPanel_PickPanelTemplate = {}
setmetatable(UIArbitratorPanel_PickPanelTemplate,luaComponentTemplates.UIArbitratorPanelTemplate)
function UIArbitratorPanel_PickPanelTemplate:RefreshPanel()
    self:RunBaseFunction("RefreshPanel")
    self:InitItemList({bagItemList = self:GetDropItemListByTypeTable({LuaEnumDropDataType.Pick_NoBodyGetItem,LuaEnumDropDataType.Pick_WaitGetCoinItem,LuaEnumDropDataType.Pick_WaitGiveBack_SameUnion,LuaEnumDropDataType.Pick_WaitGiveBack_DifferentUnion}),
                       gridTemplate = luaComponentTemplates.UIArbitratorPanel_PickGridTemplate})
    self:ShowPanel()
end
return UIArbitratorPanel_PickPanelTemplate