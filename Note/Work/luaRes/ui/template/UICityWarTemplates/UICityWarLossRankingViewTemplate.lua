local UICityWarLossRankingViewTemplate = {};

setmetatable(UICityWarLossRankingViewTemplate, luaComponentTemplates.UICityWarRankingViewTemplate)

function UICityWarLossRankingViewTemplate:GetUnitTemplateClass()
    return luaComponentTemplates.UICityWarLossRankingUnitTemplate;
end

return UICityWarLossRankingViewTemplate;