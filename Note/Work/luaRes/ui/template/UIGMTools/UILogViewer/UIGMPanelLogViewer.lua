---@class GM界面的日志查看:TemplateBase
local UIGMPanelLogViewer = {}

--region 组件
---@return GM界面的日志查看的日志类型
function UIGMPanelLogViewer:GetLogTypePart()
    if self.mLogTypePart == nil then
        local go = self:Get("LogType", "GameObject")
        if go and CS.StaticUtility.IsNull(go) == false then
            self.mLogTypePart = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGMPanelLogViewer_LogType, self)
        end
    end
    return self.mLogTypePart
end

---@return GM界面的日志查看的日志列表
function UIGMPanelLogViewer:GetLogListPart()
    if self.mLogListPart == nil then
        local go = self:Get("LogList", "GameObject")
        if go and CS.StaticUtility.IsNull(go) == false then
            self.mLogListPart = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGMPanelLogViewer_LogList, self)
        end
    end
    return self.mLogListPart
end

---@return GM界面的日志查看的日志细节
function UIGMPanelLogViewer:GetLogDetailPart()
    if self.mLogDetailPart == nil then
        local go = self:Get("LogDetail", "GameObject")
        if go and CS.StaticUtility.IsNull(go) == false then
            self.mLogDetailPart = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGMPanelLogViewer_LogDetail, self)
        end
    end
    return self.mLogDetailPart
end

---@return UIWidget
function UIGMPanelLogViewer:GetLogDetailWidget()
    if self.mLogDetailWidget == nil then
        self.mLogDetailWidget = self:Get("LogDetail", "UIWidget")
    end
    return self.mLogDetailWidget
end

---@return UILabel 信息文本组件
function UIGMPanelLogViewer:GetInfoLabel()
    if self.mInfoLabel == nil then
        self.mInfoLabel = self:Get("LogList/InfoLabel", "UILabel")
    end
    return self.mInfoLabel
end
--endregion

--region 初始化
function UIGMPanelLogViewer:Init()
    self:InitComponents()
    DebugSwitch(true, false)
end

function UIGMPanelLogViewer:Show()
    self.go:SetActive(true)
    self:BindEvents()
end

function UIGMPanelLogViewer:Hide()
    self.go:SetActive(false)
    self:ReleaseEvents()
end

function UIGMPanelLogViewer:InitComponents()
    --绑定日志类型变化事件
    self:GetLogTypePart():SetCurrentLogTypeChangeEvent(function(type)
        self:GetLogListPart():OnLogTypeChanged(type)
        self:GetLogListPart():SetCurrentLogType(type)
        --self:GetLogListPart():GetBriefLogContent():SelectBriefLog(nil, true)
    end)
    --绑定简略列表变化事件
    self:GetLogListPart():GetBriefLogContent():SetSelectedBriefLogInfoChangedEvent(function(logInfo)
        self:GetLogDetailPart():RefreshLogInfo(logInfo, self:GetLogTypePart():GetCurrentLogType())
    end)
end

function UIGMPanelLogViewer:BindEvents()
    if self.bufferRefreshEvent == nil then
        self.bufferRefreshEvent = function()
            self:OnLogBufferRefreshed()
        end
    end
    CS.CSLogManager.Instance:BindBufferChangeEvent(self.bufferRefreshEvent)
end

function UIGMPanelLogViewer:ReleaseEvents()
    if self.bufferRefreshEvent and CS.CSLogManager.Instance then
        CS.CSLogManager.Instance:ReleaseBufferChangeEvent(self.bufferRefreshEvent)
    end
end
--endregion

--region 事件
---日志缓冲区刷新事件
function UIGMPanelLogViewer:OnLogBufferRefreshed()
    self:GetLogListPart():GetBriefLogContent():ReadBuffer()
end

---扩展细节按钮点击事件
function UIGMPanelLogViewer:OnExpandDetailButtonClicked()
    if self.mIsDetailExpand == nil then
        self.mIsDetailExpand = false
    end
    if self.mIsDetailExpand then
        self.mIsDetailExpand = false
        self:GetLogDetailWidget().width = 700
        self:GetLogTypePart().go:SetActive(true)
        self:GetLogListPart().go:SetActive(true)
        local pos = self:GetLogDetailPart():GetLogDisPlayer().transform.localPosition
        pos.x = -693
        self:GetLogDetailPart():GetLogDisPlayer().transform.localPosition = pos
        self:GetLogDetailPart():GetLogDisPlayer().limitLineCount = true
        self:GetLogDetailPart():GetLogDisPlayer().maxCountPerLine = 60
        self:GetLogDetailPart():GetLogDisPlayer():Refresh()
    else
        self.mIsDetailExpand = true
        self:GetLogDetailWidget().width = 1300
        self:GetLogTypePart().go:SetActive(false)
        self:GetLogListPart().go:SetActive(false)
        local pos = self:GetLogDetailPart():GetLogDisPlayer().transform.localPosition
        pos.x = -1280
        self:GetLogDetailPart():GetLogDisPlayer().transform.localPosition = pos
        self:GetLogDetailPart():GetLogDisPlayer().limitLineCount = true
        self:GetLogDetailPart():GetLogDisPlayer().maxCountPerLine = 120
        self:GetLogDetailPart():GetLogDisPlayer():Refresh()
    end
end
--endregion

--region 工具方法
---@param logType LuaEnumLogViewerLogType
function UIGMPanelLogViewer:GetLogTypeName(logType)
    if logType == LuaEnumLogViewerLogType.All then
        return "全部日志"
    end
    if logType == LuaEnumLogViewerLogType.NetworkMsg then
        return "网络消息"
    end
    if logType == LuaEnumLogViewerLogType.ClientMsg then
        return "客户端消息"
    end
    if logType == LuaEnumLogViewerLogType.UnityLog then
        return "Unity日志"
    end
    if logType == LuaEnumLogViewerLogType.LocalLog then
        return "本地日志"
    end
    if logType == LuaEnumLogViewerLogType.UnityError then
        return "Unity报错"
    end
    if logType == LuaEnumLogViewerLogType.UnityWarning then
        return "Unity警告"
    end
    return ""
end

---设置信息
---@param infoContent string
function UIGMPanelLogViewer:SetInfoContent(infoContent)
    if infoContent == nil then
        self:GetInfoLabel().text = ""
    else
        self:GetInfoLabel().text = infoContent
    end
end
--endregion

--region 析构
function UIGMPanelLogViewer:OnDestroy()
    self:ReleaseEvents()
end
--endregion

return UIGMPanelLogViewer