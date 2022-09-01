local UIMainMenusPanelMaskTemplate = {};

setmetatable(UIMainMenusPanelMaskTemplate, luaComponentTemplates.UIPanelMaskTemplate)

UIMainMenusPanelMaskTemplate.__index = UIMainMenusPanelMaskTemplate;

UIMainMenusPanelMaskTemplate.__base = luaComponentTemplates.UIPanelMaskTemplate;

function UIMainMenusPanelMaskTemplate:SetMask(gameObject, isMask)

end

return UIMainMenusPanelMaskTemplate;