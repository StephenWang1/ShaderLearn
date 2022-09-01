---@class GM界面的日志查看的日志类型:TemplateBase
local UIGMPanelLogViewer_LogType = {}

--region 组件
---日志类型下拉列表
---@return UIPopupList
function UIGMPanelLogViewer_LogType:GetLogTypePopupList()
    if self.mLogTypePopupList == nil then
        self.mLogTypePopupList = self:Get("LogTypePopupList", "UIPopupList")
    end
    return self.mLogTypePopupList
end

---@return UIPanel
function UIGMPanelLogViewer_LogType:GetPanel()
    if self.mPanel == nil then
        self.mPanel = self:Get("", "UIPanel")
    end
    return self.mPanel
end
--endregion

--region 属性
---获取当前日志类型,默认为网络消息
---@return LuaEnumLogViewerLogType
function UIGMPanelLogViewer_LogType:GetCurrentLogType()
    if self.mCurrentLogType == nil then
        self.mCurrentLogType = self:GetDefaultLogType()
    end
    return self.mCurrentLogType
end

---设置当前日志类型
---@param logType LuaEnumLogViewerLogType
function UIGMPanelLogViewer_LogType:SetCurrentLogType(logType)
    self.mCurrentLogType = logType
    self:OnCurrentLogTypeChanged()
end

function UIGMPanelLogViewer_LogType:GetDefaultLogType()
    return LuaEnumLogViewerLogType.All
end
--endregion

--region 初始化
---@param logViewer GM界面的日志查看
function UIGMPanelLogViewer_LogType:Init(logViewer)
    self.mLogViewer = logViewer
    self:GetPanel().depth = self:GetPanel().depth + 10
    CS.EventDelegate.Add(self:GetLogTypePopupList().onChange, function()
        self:OnPopupSelectionChanged()
    end)
end

function UIGMPanelLogViewer_LogType:Start()
    self:InitPopupList()
end

---初始化下拉框
function UIGMPanelLogViewer_LogType:InitPopupList()
    self.mPopupTbl = {}
    self:GetLogTypePopupList():Clear()
    self:AddPopupItem(LuaEnumLogViewerLogType.All)
    self:AddPopupItem(LuaEnumLogViewerLogType.NetworkMsg)
    self:AddPopupItem(LuaEnumLogViewerLogType.ClientMsg)
    self:AddPopupItem(LuaEnumLogViewerLogType.LocalLog)
    self:AddPopupItem(LuaEnumLogViewerLogType.UnityLog)
    self:AddPopupItem(LuaEnumLogViewerLogType.UnityWarning)
    self:AddPopupItem(LuaEnumLogViewerLogType.UnityError)
    self:GetLogTypePopupList().value = self:GetPopupListName(self:GetDefaultLogType())
end

---@param logType LuaEnumLogViewerLogType
function UIGMPanelLogViewer_LogType:AddPopupItem(logType)
    local name = self:GetPopupListName(logType)
    self.mPopupTbl[name] = logType
    self:GetLogTypePopupList():AddItem(name)
end
--endregion

--region 事件
---下拉框变化事件
function UIGMPanelLogViewer_LogType:OnPopupSelectionChanged()
    local currentValue = self:GetLogTypePopupList().value
    if Utility.IsContainsKey(self.mPopupTbl, currentValue) then
        self:SetCurrentLogType(self.mPopupTbl[currentValue])
    end
end

---设置当前日志类型变化事件
---@param logChangeEvent function function(self, currentLogType)
function UIGMPanelLogViewer_LogType:SetCurrentLogTypeChangeEvent(logChangeEvent)
    self.mLogChangeEvent = logChangeEvent
end

---当前日志类型变化事件
function UIGMPanelLogViewer_LogType:OnCurrentLogTypeChanged()
    if self.mLogChangeEvent ~= nil then
        self.mLogChangeEvent(self:GetCurrentLogType())
    end
end
--endregion

--region 下拉框信息
---@param logType LuaEnumLogViewerLogType
function UIGMPanelLogViewer_LogType:GetPopupListName(logType)
    return self.mLogViewer:GetLogTypeName(logType)
end
--endregion

return UIGMPanelLogViewer_LogType