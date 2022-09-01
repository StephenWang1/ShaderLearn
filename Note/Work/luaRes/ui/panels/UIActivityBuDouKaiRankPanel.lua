---@class UIActivityBuDouKaiRankPanel:UIActivityRankPanel 武道会活动排行榜
local UIActivityBuDouKaiRankPanel = {}
setmetatable(UIActivityBuDouKaiRankPanel, luaPanelModules.UIActivityRankPanel)

function UIActivityBuDouKaiRankPanel:Init()
    self:RunBaseFunction('Init')
end

---@param id number cfg_activity_leaderboardId
---@param myRankId number 自己排行名次
---@param closeCallback function 关闭回调
function UIActivityBuDouKaiRankPanel:Show(customData)
    self:RunBaseFunction('Show', customData)
end


function UIActivityBuDouKaiRankPanel:Clear()
    self:RunBaseFunction('Clear')
end

function ondestroy()
    UIActivityBuDouKaiRankPanel:Clear()
end

--endregion

return UIActivityBuDouKaiRankPanel