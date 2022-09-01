---@class UIVoiceBubbleTipsPanel:UIBase
local UIVoiceBubbleTipsPanel = {}
setmetatable(UIVoiceBubbleTipsPanel, luaPanelModules.UIBubbleTipsPanel);
---设置位置
function UIVoiceBubbleTipsPanel:SetLabelSite(direction)
    local y = 32;
    local x = (self.rightSprite.height + 10) / 2;
    if direction == LuaEnumPromptframeDirectionType.UP then
        self.Label.transform.localPosition = CS.UnityEngine.Vector3(0, -y, 0)
    elseif direction == LuaEnumPromptframeDirectionType.DOWN then
        self.Label.transform.localPosition = CS.UnityEngine.Vector3(0, y, 0)
    elseif direction == LuaEnumPromptframeDirectionType.LEFT then
        self.Label.transform.localPosition = CS.UnityEngine.Vector3(x, 0, 0)
    elseif direction == LuaEnumPromptframeDirectionType.RIGHT then
        self.Label.transform.localPosition = CS.UnityEngine.Vector3(-x, 0, 0)
    end
end



return UIVoiceBubbleTipsPanel