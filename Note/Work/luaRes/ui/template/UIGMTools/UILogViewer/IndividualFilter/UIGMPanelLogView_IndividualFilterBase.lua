---独立筛选基类
---@class UIGMPanelLogView_IndividualFilterBase:TemplateBase
local UIGMPanelLogView_IndividualFilterBase = {}

---执行筛选
---@param logInfo {LogIndex:number,FrameIndex:number,BriefInfo:string,Content:string,LogTime:string}
---@return boolean 执行筛选
function UIGMPanelLogView_IndividualFilterBase:DoFilter(logInfo)
    return true
end

return UIGMPanelLogView_IndividualFilterBase