---@class UIRankShowModelFeatureTemplate:UIRankNormalFeatureTemplate
local UIRankNormalShowModelFeatureTemplate = {}
setmetatable(UIRankNormalShowModelFeatureTemplate, luaclass.UIRankNormalFeatureTemplate)

function UIRankNormalShowModelFeatureTemplate:OnTemplatBtnClick(target, go)
    if target.rankData == nil then
        return
    end
    ---@type UIRankPanel
    local panel = uimanager:GetPanel("UIRankPanel")
    if panel then
        panel.OnHideReward(nil)
        panel.RefreshModelView(target.rid, target.rankData)
    end
end

return UIRankNormalShowModelFeatureTemplate