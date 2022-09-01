---采集进度条
---@class UIGatherProgressPanel:UIBase
local UIGatherProgressPanel = {}

---采集进度条
---@return UISprite
function UIGatherProgressPanel:GetGatherProgress()
    if self.mGatherProgress == nil then
        self.mGatherProgress = self:GetCurComp("WidgetRoot/gatherprogress", "UISprite")
    end
    return self.mGatherProgress
end

---@param gatherID number gather表的ID
function UIGatherProgressPanel:Show(gatherID, startTime)
    if gatherID == nil or gatherID == 0 or startTime == nil then
        self:ClosePanel()
        return
    end
    ---@type TABLE.CFG_GATHER
    local gatherTblExist, gatherTbl = CS.Cfg_GatherTableManager.Instance:TryGetValue(gatherID)
    if gatherTbl == nil then
        self:ClosePanel()
        return
    end
    self.mStartTime = startTime
    self.mTimeInterval = gatherTbl.gatherTime / 1000
    self.mEndTime = self.mStartTime + self.mTimeInterval
end

function UIGatherProgressPanel:OnUpdate()
    if CS.CSSceneExt.Sington == nil or CS.CSSceneExt.Sington.GatherController.IsGathering == false then
        self:ClosePanel()
        return
    end
    local percentage = 1
    if self.mStartTime and self.mTimeInterval and self.mEndTime and self.mTimeInterval > 0 then
        local timeOffset = CS.UnityEngine.Time.time - self.mStartTime
        percentage = timeOffset / self.mTimeInterval
        percentage = math.clamp01(percentage)
    end
    self:GetGatherProgress().fillAmount = percentage
end

function update()
    UIGatherProgressPanel:OnUpdate()
end

return UIGatherProgressPanel