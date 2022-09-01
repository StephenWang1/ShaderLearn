---@class GM界面的日志查看的日志列表:TemplateBase
local UIGMPanelLogViewer_LogList = {}

--region 组件
---@return UIInput 筛选文本输入框
function UIGMPanelLogViewer_LogList:GetFilterInput_UIInput()
    if self.mFilterInput_UIInput == nil then
        self.mFilterInput_UIInput = self:Get("Filter/FilterInput", "UIInput")
    end
    return self.mFilterInput_UIInput
end

---@return UIButton 筛选按钮游戏物体
function UIGMPanelLogViewer_LogList:GetFilterButton()
    if self.mFilterButtonGO == nil then
        self.mFilterButtonGO = self:Get("Filter/BeginFilterBtn", "UIButton")
    end
    return self.mFilterButtonGO
end

---@return UIButton 清空筛选游戏物体
function UIGMPanelLogViewer_LogList:GetFilterClearButton()
    if self.mFilterClearButtonGO == nil then
        self.mFilterClearButtonGO = self:Get("Filter/ClearFilterBtn", "UIButton")
    end
    return self.mFilterClearButtonGO
end

---@return UIButton 保存所有日志按钮
function UIGMPanelLogViewer_LogList:GetSaveAllLogButton()
    if self.mSaveAllLogButtonGO == nil then
        self.mSaveAllLogButtonGO = self:Get("SaveAllLogsBtn", "UIButton")
    end
    return self.mSaveAllLogButtonGO
end

---@return UnityEngine.GameObject 简略列表
function UIGMPanelLogViewer_LogList:GetBriefLogGameObject()
    if self.mBriefLogGO == nil then
        self.mBriefLogGO = self:Get("LogList", "GameObject")
    end
    return self.mBriefLogGO
end

---@return GM界面的日志简略列表 日志的简略列表
function UIGMPanelLogViewer_LogList:GetBriefLogContent()
    if self.mBriefLogContent == nil then
        self.mBriefLogContent = templatemanager.GetNewTemplate(self:GetBriefLogGameObject(), luaComponentTemplates.UIGMPanelLogViewer_BriefLog, self.mLogViewer)
    end
    return self.mBriefLogContent
end

---@return UIButton 获取刷新按钮
function UIGMPanelLogViewer_LogList:GetRefreshButton()
    if self.mRefreshButtonGO == nil then
        self.mRefreshButtonGO = self:Get("RefreshBtn", "UIButton")
    end
    return self.mRefreshButtonGO
end

---@return UnityEngine.GameObject
function UIGMPanelLogViewer_LogList:GetClearButton()
    if self.mClearButtonGO == nil then
        self.mClearButtonGO = self:Get("ClearBtn", "UIButton")
    end
    return self.mClearButtonGO
end

---@return UIToggle
function UIGMPanelLogViewer_LogList:GetOpenLogButton()
    if self.mOpenLogToggle == nil then
        self.mOpenLogToggle = self:Get("Tg_GMOpenLog", "UIToggle")
    end
    return self.mOpenLogToggle
end

---@return UILabel
function UIGMPanelLogViewer_LogList:GetOpenLogButtonLabel()
    if self.mOpenLogToggleLabel == nil then
        self.mOpenLogToggleLabel = self:Get("Tg_GMOpenLog/Label", "UILabel")
    end
    return self.mOpenLogToggleLabel
end
--endregion

--region 独立筛选
---网络消息的独立筛选
---@return UIGMPanelLogView_IndividualFilter_NetworkMsg
function UIGMPanelLogViewer_LogList:GetNetworkMsgIndividualFilter()
    if self.mNetworkMsgIndividualFilter == nil then
        local go = self:Get("IndividualFilter/NetworkMsgFilter", "GameObject")
        if go then
            self.mNetworkMsgIndividualFilter = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGMPanelLogView_IndividualFilter_NetworkMsg)
        end
    end
    return self.mNetworkMsgIndividualFilter
end

---隐藏所有的独立筛选
function UIGMPanelLogViewer_LogList:HideAllIndividualFilters()
    for i, v in pairs(LuaEnumLogViewerLogType) do
        if self:GetIndividualFilter(v) and CS.StaticUtility.IsNull(self:GetIndividualFilter(v).go) == false then
            self:GetIndividualFilter(v).go:SetActive(false)
        end
    end
end

---获取某类型的独立筛选模板
---@return UIGMPanelLogView_IndividualFilterBase
function UIGMPanelLogViewer_LogList:GetIndividualFilter(type)
    if type == LuaEnumLogViewerLogType.NetworkMsg then
        return self:GetNetworkMsgIndividualFilter()
    end
    return nil
end
--endregion

--region 属性
---@return string 当前筛选内容字符串
function UIGMPanelLogViewer_LogList:GetCurrentFilterContentString()
    return self:GetFilterInput_UIInput().value
end

---@return LuaEnumLogViewerLogType 日志类型
function UIGMPanelLogViewer_LogList:GetCurrentLogType()
    return self.mCurrentLogType
end

---@param currentLogType LuaEnumLogViewerLogType 日志类型
function UIGMPanelLogViewer_LogList:SetCurrentLogType(currentLogType)
    self.mCurrentLogType = currentLogType
    self:GetBriefLogContent():SetLogType(currentLogType)
end
--endregion

--region 初始化
---@param logViewer GM界面的日志查看
function UIGMPanelLogViewer_LogList:Init(logViewer)
    self.mLogViewer = logViewer
    if self:GetOpenLogButton() then
        self:GetOpenLogButton():Set(CS.CSLogManager.Instance.NetworkMsgLogger.IsOn)
    end
    if self:GetOpenLogButtonLabel() then
        self:GetOpenLogButtonLabel().text = "记录网络消息"
    end
    self:InitUIEvents()
end

function UIGMPanelLogViewer_LogList:InitUIEvents()
    CS.EventDelegate.Add(self:GetFilterClearButton().onClick, function()
        self:OnFilterClearButtonClicked()
    end)
    CS.EventDelegate.Add(self:GetFilterButton().onClick, function()
        self:OnFilterButtonClicked()
    end)
    CS.EventDelegate.Add(self:GetRefreshButton().onClick, function()
        self:OnRefreshButtonClicked()
    end)
    CS.EventDelegate.Add(self:GetClearButton().onClick, function()
        self:OnClearButtonClicked()
    end)
    CS.EventDelegate.Add(self:GetSaveAllLogButton().onClick, function()
        self.mLogViewer:SetInfoContent("正在保存日志")
        self:OnSaveAllLogButtonClicked()
    end)
    if self:GetOpenLogButton() then
        CS.EventDelegate.Add(self:GetOpenLogButton().onChange, function()
            DebugSwitch(true, self:GetOpenLogButton().value)
        end)
    end
end
--endregion

--region 事件
---日志类型变化事件
function UIGMPanelLogViewer_LogList:OnLogTypeChanged(type)
    self:HideAllIndividualFilters()
    local currentIndividualFilter = self:GetIndividualFilter(type)
    self:GetBriefLogContent():SetIndividualFilter(currentIndividualFilter)
    if currentIndividualFilter and CS.StaticUtility.IsNull(currentIndividualFilter.go) == false then
        currentIndividualFilter.go:SetActive(true)
    end
end

---清空按钮点击事件
function UIGMPanelLogViewer_LogList:OnFilterClearButtonClicked()
    self:GetFilterInput_UIInput().value = ""
    self:OnFilterButtonClicked()
end

---筛选按钮点击事件
function UIGMPanelLogViewer_LogList:OnFilterButtonClicked()
    local currentContentStr = self:GetCurrentFilterContentString()
    self:GetBriefLogContent():SetFilterString(currentContentStr)
end

---刷新按钮点击事件
function UIGMPanelLogViewer_LogList:OnRefreshButtonClicked()
    local currentContentStr = self:GetCurrentFilterContentString()
    self:GetBriefLogContent():SetFilterString(currentContentStr)
    self:GetBriefLogContent():SelectTemplate(nil)
    CS.CSLogManager.Instance:RefreshLogBuffer()
end

---清空按钮点击事件
function UIGMPanelLogViewer_LogList:OnClearButtonClicked()
    if self.mLogViewer:GetLogTypePart():GetCurrentLogType() == LuaEnumLogViewerLogType.All then
        CS.CSLogManager.Instance:ClearAll()
    else
        CS.CSLogManager.Instance:Clear(self.mLogViewer:GetLogTypePart():GetCurrentLogType())
    end
end

---保存所有日志按钮点击事件
function UIGMPanelLogViewer_LogList:OnSaveAllLogButtonClicked()
    CS.CSLogManager.Instance:SaveBufferLogsToLocalFiles(function(path)
        if path ~= nil and path ~= "" then
            self.mLogViewer:SetInfoContent("保存缓存区日志到" .. path)
        else
            self.mLogViewer:SetInfoContent("保存缓存区日志失败")
        end
    end)
end
--endregion

return UIGMPanelLogViewer_LogList