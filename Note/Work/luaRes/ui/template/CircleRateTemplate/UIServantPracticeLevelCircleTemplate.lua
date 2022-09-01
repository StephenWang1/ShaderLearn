---@class UIServantPracticeLevelCircleTemplate:CircleRateBaseTemplate 灵兽经验球
local UIServantPracticeLevelCircleTemplate = {}

setmetatable(UIServantPracticeLevelCircleTemplate, luaComponentTemplates.CircleRateBaseTemplate)

---@return boolean 默认该组件球和波浪的图片在同一节点下且不存在父子级别关系
---如果波浪是球子节点，重写此方法且返回false
function UIServantPracticeLevelCircleTemplate:IsSameRoot()
    return false
end

function UIServantPracticeLevelCircleTemplate:GetCircle_UISprite()
    if self.mBall == nil then
        self.mBall = self:Get("Sprite2", "UISprite")
    end
    return self.mBall
end

function UIServantPracticeLevelCircleTemplate:GetWave_UISprite()
    if self.mWave == nil then
        self.mWave = self:Get("panel/Sprite3", "UIWidget")
    end
    return self.mWave
end

return UIServantPracticeLevelCircleTemplate