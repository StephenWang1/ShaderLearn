---@class UIGMPanelLogView_SingleBriefLog:TemplateBase
local UIGMPanelLogView_SingleBriefLog = {}

--region 组件
---@return UILabel 索引文字组件
function UIGMPanelLogView_SingleBriefLog:GetIndexLabel()
    if self.mIndexLabel == nil then
        self.mIndexLabel = self:Get("IndexLabel", "UILabel")
    end
    return self.mIndexLabel
end

---@return UILabel 时间文字组件
function UIGMPanelLogView_SingleBriefLog:GetTimeLabel()
    if self.mTimeLabel == nil then
        self.mTimeLabel = self:Get("TimeLabel", "UILabel")
    end
    return self.mTimeLabel
end

---@return UILabel 日志类型文字组件
function UIGMPanelLogView_SingleBriefLog:GetLogTypeLabel()
    if self.mLogTypeLabel == nil then
        self.mLogTypeLabel = self:Get("LogTypeLabel", "UILabel")
    end
    return self.mLogTypeLabel
end

---@return UILabel 帧索引文字组件
function UIGMPanelLogView_SingleBriefLog:GetFrameIndexLabel()
    if self.mFrameIndexLabel == nil then
        self.mFrameIndexLabel = self:Get("FrameIndexLabel", "UILabel")
    end
    return self.mFrameIndexLabel
end

---@return UILabel 简略介绍文字组件
function UIGMPanelLogView_SingleBriefLog:GetBriefIntroductionLabel()
    if self.mBriefIntroductionLabel == nil then
        self.mBriefIntroductionLabel = self:Get("BriefIntroduction", "UILabel")
    end
    return self.mBriefIntroductionLabel
end

---@return UnityEngine.GameObject 被选中的标识游戏物体
function UIGMPanelLogView_SingleBriefLog:GetSelectedGameObject()
    if self.mSelectedGO == nil then
        self.mSelectedGO = self:Get("Selected", "GameObject")
    end
    return self.mSelectedGO
end

---@return UnityEngine.GameObject 差异标识
function UIGMPanelLogView_SingleBriefLog:GetDiffSign_GameObject()
    if self.mDiffSignGO == nil then
        self.mDiffSignGO = self:Get("DiffSign", "GameObject")
    end
    return self.mDiffSignGO
end
--endregion

--region 初始化
---@param logViewer GM界面的日志查看
function UIGMPanelLogView_SingleBriefLog:Init(logViewer)
    self.mLogViewer = logViewer
    self:SetSelectedState(false)
    self:BindUIEvent()
end

function UIGMPanelLogView_SingleBriefLog:BindUIEvent()
    CS.UIEventListener.Get(self.go).onClick = function()
        self:OnClicked()
    end
end
--endregion

--region 刷新
---绑定点击事件
---@param clickEvent function 点击事件 function(info)
function UIGMPanelLogView_SingleBriefLog:BindClickEvent(clickEvent)
    self.mClickEvent = clickEvent
end

---刷新
---@param info {LogIndex:number,FrameIndex:number,BriefInfo:string,Content:string,LogTime:string}
function UIGMPanelLogView_SingleBriefLog:Refresh(info, index)
    self.info = info
    self:SetSelectedState(false)
    self:GetIndexLabel().text = tostring(index) .. '.'
    self:GetLogTypeLabel().text = self.mLogViewer:GetLogTypeName(self.info.LogType)
    self:GetFrameIndexLabel().text = "第" .. tostring(info.FrameIndex) .. "帧"
    self:GetBriefIntroductionLabel().text = info.BriefInfo
    self:GetTimeLabel().text = info.LogTime
    self:GetDiffSign_GameObject():SetActive(info.LogIndex % 2 == 0)
end

---设置被选中状态
function UIGMPanelLogView_SingleBriefLog:SetSelectedState(isSelected)
    self:GetSelectedGameObject():SetActive(isSelected)
end
--endregion

--region 事件
---点击事件
function UIGMPanelLogView_SingleBriefLog:OnClicked()
    if self.mClickEvent then
        self.mClickEvent(self)
    end
end
--endregion

return UIGMPanelLogView_SingleBriefLog