local UIIndividEscortChoosePanel_ServantExp = {}
setmetatable(UIIndividEscortChoosePanel_ServantExp, luaComponentTemplates.UIIndividEscortChoosePanel_Base)
function UIIndividEscortChoosePanel_ServantExp:Init(panel)
    self:RunBaseFunction("Init", panel)
    self.personCarType = LuaEnumPersonDartCarType.SERVANTEXP
end

function UIIndividEscortChoosePanel_ServantExp:RefreshPanel(commonData)
    self:RunBaseFunction("RefreshPanel", commonData)
end
return UIIndividEscortChoosePanel_ServantExp