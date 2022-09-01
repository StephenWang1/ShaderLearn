---@class UIActivityRankThirdPanel:UIActivityRankPanel 五列类型活动排行榜
local UIActivityRankThirdPanel = {}
setmetatable(UIActivityRankThirdPanel, luaPanelModules.UIActivityRankPanel)
--region 初始化

function UIActivityRankThirdPanel:Init()
    self:RunBaseFunction('Init')
end

---@param id number cfg_activity_leaderboardId
---@param myRankId number 自己排行名次
---@param closeCallback function 关闭回调
function UIActivityRankThirdPanel:Show(customData)
    self:RunBaseFunction('Show', customData)
end

--region ondestroy

function UIActivityRankThirdPanel:Clear()
    self:RunBaseFunction('Clear')
end

function ondestroy()
    UIActivityRankThirdPanel:Clear()
end

--endregion
return UIActivityRankThirdPanel