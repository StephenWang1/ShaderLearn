---@class UIWhiteSunGateHuntingRewardTemplate
local UIWhiteSunGateHuntingRewardTemplate= {}

function UIWhiteSunGateHuntingRewardTemplate:InitComponents()
    self.mModelRoot = self:Get("WidgetRoot/left/roleModel", "GameObject")
end

function UIWhiteSunGateHuntingRewardTemplate:InitOther()

end

---初始化数据
function UIWhiteSunGateHuntingRewardTemplate:Init()
    self:InitComponents()
    self:InitOther()
end

return UIWhiteSunGateHuntingRewardTemplate