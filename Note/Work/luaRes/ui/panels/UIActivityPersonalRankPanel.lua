---@class UIActivityPersonalRankPanel:UIActivityRankPanel 单个类型活动排行榜
local UIActivityPersonalRankPanel = {}
setmetatable(UIActivityPersonalRankPanel, luaPanelModules.UIActivityRankPanel)
--region 局部变量

--endregion

--region 初始化

function UIActivityPersonalRankPanel:Init()
    self:RunBaseFunction('Init')
end

---@param id number cfg_activity_leaderboardId
---@param myRankId number 自己排行名次
---@param closeCallback function 关闭回调
function UIActivityPersonalRankPanel:Show(customData)
    self:RunBaseFunction('Show', customData)
end

--region ondestroy

function UIActivityPersonalRankPanel:Clear()
    self:RunBaseFunction("Clear")
end

function ondestroy()
    UIActivityPersonalRankPanel:Clear()
end

--endregion

return UIActivityPersonalRankPanel