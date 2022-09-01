---@class UIActivityRankSecondPanel:UIActivityRankPanel 四列类型活动排行榜
local UIActivityRankSecondPanel = {}
setmetatable(UIActivityRankSecondPanel, luaPanelModules.UIActivityRankPanel)
function UIActivityRankSecondPanel:Init()
    self:RunBaseFunction('Init')
end

---@param id number cfg_activity_leaderboardId
---@param myRankId number 自己排行名次
---@param closeCallback function 关闭回调
function UIActivityRankSecondPanel:Show(customData)
    self:RunBaseFunction('Show', customData)
end


function UIActivityRankSecondPanel:Clear()
    self:RunBaseFunction('Clear')
end

function ondestroy()
    UIActivityRankSecondPanel:Clear()
end

--endregion
return UIActivityRankSecondPanel