local UIIndividEscortChoosePanel_Ingot = {}

setmetatable(UIIndividEscortChoosePanel_Ingot, luaComponentTemplates.UIIndividEscortChoosePanel_Base)

function UIIndividEscortChoosePanel_Ingot:Init(panel)
    self:RunBaseFunction("Init", panel)
    self.personCarType = LuaEnumPersonDartCarType.INGOT
end

function UIIndividEscortChoosePanel_Ingot:RefreshPanel(commonData)
    self:RunBaseFunction("RefreshPanel", commonData)
end

return UIIndividEscortChoosePanel_Ingot