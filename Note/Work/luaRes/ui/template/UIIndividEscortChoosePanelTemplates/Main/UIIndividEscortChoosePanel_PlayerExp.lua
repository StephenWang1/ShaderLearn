local UIIndividEscortChoosePanel_PlayerExp = {}
setmetatable(UIIndividEscortChoosePanel_PlayerExp, luaComponentTemplates.UIIndividEscortChoosePanel_Base)
function UIIndividEscortChoosePanel_PlayerExp:Init(panel)
    self:RunBaseFunction("Init", panel)
    self.personCarType = LuaEnumPersonDartCarType.PLAYEREXP
end

function UIIndividEscortChoosePanel_PlayerExp:RefreshPanel(commonData)
    self:RunBaseFunction("RefreshPanel", commonData)
end
return UIIndividEscortChoosePanel_PlayerExp