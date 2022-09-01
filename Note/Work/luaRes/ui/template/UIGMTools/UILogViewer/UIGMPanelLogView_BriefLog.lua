---@class GM界面的日志简略列表:TemplateBase
local UIGMPanelLogView_BriefLog = {}

--region 组件
---@return UIScrollView
function UIGMPanelLogView_BriefLog:GetBriefLogsScrollView()
    if self.mBriefLogsScrollView == nil then
        self.mBriefLogsScrollView = self:Get("BriefLogListScrollView", "UIScrollView")
    end
    return self.mBriefLogsScrollView
end

---循环简略日志列表
---@return LoopScrollView
function UIGMPanelLogView_BriefLog:GetCircleBriefLogsScrollView()
    if self.mCircleBriefLogsScrollView == nil then
        self.mCircleBriefLogsScrollView = self:Get("BriefLogListScrollView/CircleBriefLogs", "LoopScrollView")
    end
    return self.mCircleBriefLogsScrollView
end

---@return UIPanel
function UIGMPanelLogView_BriefLog:GetBriefLogsUIPanel()
    if self.mBriefLogsUIPanel == nil then
        self.mBriefLogsUIPanel = self:Get("BriefLogListScrollView", "UIPanel")
    end
    return self.mBriefLogsUIPanel
end

---@return UnityEngine.GameObject
function UIGMPanelLogView_BriefLog:GetBlockGameObject()
    if self.mBlockGameObject == nil then
        self.mBlockGameObject = self:Get("BriefLogListScrollView/Block", "GameObject")
    end
    return self.mBlockGameObject
end
--endregion

--region 初始化
---@param logViewer GM界面的日志查看
function UIGMPanelLogView_BriefLog:Init(logViewer)
    self.mLogViewer = logViewer
end
--endregion

--region 筛选
---设置筛选文本
---@param filterString string 筛选文本
function UIGMPanelLogView_BriefLog:SetFilterString(filterString)
    if filterString == nil then
        self.mFilterString = ""
    else
        ---替换空字符串
        self.mFilterString = string.gsub(string.lower(filterString), " ", "")
    end
    self:RefreshContent()
end

---设置独立的筛选器
---@param individualFilter UIGMPanelLogView_IndividualFilterBase 筛选文本的索引
function UIGMPanelLogView_BriefLog:SetIndividualFilter(individualFilter)
    self.mIndividualFilter = individualFilter
    self:RefreshContent()
end

---筛选日志
---@param logInfo {LogIndex:number,FrameIndex:number,BriefInfo:string,Content:string,LogTime:string} 日志信息
---@return boolean 该日志信息是否能被筛选出来
function UIGMPanelLogView_BriefLog:FilterLog(logInfo)
    if logInfo == nil then
        return false
    end
    --正常筛选
    if self.mFilterString and self.mFilterString ~= "" then
        local targetString = string.gsub(string.lower(logInfo.Content), " ", "")
        if string.find(targetString, self.mFilterString) then
            return true
        end
        return false
    end
    --独立筛选
    if self.mIndividualFilter then
        return self.mIndividualFilter:DoFilter(logInfo)
    end
    return true
end
--endregion

--region 属性
---@return number
function UIGMPanelLogView_BriefLog:GetCurrentLogIndex()
    return self.mCurrentSelectedLogIndex
end

---@param value number
function UIGMPanelLogView_BriefLog:SetCurrentLogIndex(value)
    self.mCurrentSelectedLogIndex = value
end

---获取日志类型
---@return LuaEnumLogViewerLogType
function UIGMPanelLogView_BriefLog:GetLogType()
    return self.mCurrentLogType
end

---设置日志类型
---@param currentLogType LuaEnumLogViewerLogType
function UIGMPanelLogView_BriefLog:SetLogType(currentLogType)
    self.mCurrentLogType = currentLogType
    self:RefreshContent()
end

---获取当前选中的日志信息
function UIGMPanelLogView_BriefLog:GetCurrentSelectedLogInfo()
    return self.mCurrentSelectedLogInfo
end

---设置当前选中的日志信息
---@param logInfo userdata 当前选中的日志信息
---@param force boolean 是否强制刷新
function UIGMPanelLogView_BriefLog:SetCurrentSelectedLogInfo(logInfo, force)
    if force == nil then
        force = false
    end
    if self.mCurrentSelectedLogInfo == logInfo and force == false then
        if logInfo == nil then
            self:SetCurrentLogIndex(nil)
        end
        return
    end
    if logInfo == nil then
        self:SetCurrentLogIndex(nil)
    else
        self:SetCurrentLogIndex(logInfo.LogIndex)
    end
    self.mCurrentSelectedLogInfo = logInfo
    self:OnCurrentSelectedBriefLogInfoChanged()
end

---获取当前选中的物体
function UIGMPanelLogView_BriefLog:GetCurrentSelectedTemplate()
    return self.mCurrentSelectedTemplate
end

---设置当前选中的物体
---@param template UIGMPanelLogView_SingleBriefLog
---@param force boolean
function UIGMPanelLogView_BriefLog:SetCurrentSelectedTemplate(template, force)
    if force == nil then
        force = false
    end
    if self.mCurrentSelectedTemplate == template and force == false then
        return
    end
    if self.mCurrentSelectedTemplate and CS.StaticUtility.IsNull(self.mCurrentSelectedTemplate.go) == false then
        self.mCurrentSelectedTemplate:SetSelectedState(false)
    end
    self.mCurrentSelectedTemplate = template
    if self.mCurrentSelectedTemplate and CS.StaticUtility.IsNull(self.mCurrentSelectedTemplate.go) == false then
        self.mCurrentSelectedTemplate:SetSelectedState(true)
    end
end

---日志缓冲列表
---@return CS.System.Collections.IList
function UIGMPanelLogView_BriefLog:GetLogCacheList()
    if self.mLogCacheList == nil then
        self.mLogCacheList = CS.System.Collections.Generic["List`1[System.Object]"]()
    end
    return self.mLogCacheList
end
--endregion

--region 读取刷新操作
---读取缓冲区
function UIGMPanelLogView_BriefLog:ReadBuffer()
    self.mCurrentLogBuffer = {}
    for i, v in pairs(LuaEnumLogViewerLogType) do
        self.mCurrentLogBuffer[v] = CS.CSLogManager.Instance:GetBufferLogList(v)
    end
    self:RefreshContent()
end

---刷新内容
function UIGMPanelLogView_BriefLog:RefreshContent()
    if self.mCurrentLogBuffer == nil then
        self:ReadBuffer()
        return
    end
    if self.mRefreshContentIEnumerator then
        --正在刷新时不进行新的刷新
        return
    end
    self.mRefreshContentIEnumerator = StartCoroutine(self.RefreshCircleContentIEnumerator, self)
end

---刷新内容协程
function UIGMPanelLogView_BriefLog:RefreshCircleContentIEnumerator()
    self:BeforeRefresh()
    coroutine.yield(0)
    self:SetLogCacheList()
    coroutine.yield(0)
    self:AfterRefresh()
end

---在刷新前
function UIGMPanelLogView_BriefLog:BeforeRefresh()
    self:GetBlockGameObject():SetActive(true)
    self.refreshStartTime = CS.UnityEngine.Time.time
    --最短刷新时长为0.35s
    self.minRefreshEndTime = self.refreshStartTime + 0.35
end

---设定缓冲列表
function UIGMPanelLogView_BriefLog:SetLogCacheList()
    --清空缓存列表
    self:GetLogCacheList():Clear()
    --当前的日志列表
    local mCurrentLogList
    if self:GetLogType() == LuaEnumLogViewerLogType.All then
        mCurrentLogList = CS.CSLogManager.Instance:GetAllBufferLogList()
    else
        mCurrentLogList = self.mCurrentLogBuffer[self:GetLogType()]
    end
    --筛选
    if mCurrentLogList and mCurrentLogList.Count > 0 then
        for i = 0, mCurrentLogList.Count - 1 do
            local logInfo = mCurrentLogList[i]
            if self:FilterLog(logInfo) then
                self:GetLogCacheList():Add(logInfo)
            end
        end
    end
    --翻转日志列表
    --self:GetLogCacheList():Reverse()

    self:ReverseList()

    coroutine.yield(0)
    --清空循环列表
    self:GetCircleBriefLogsScrollView():ResetToBegining(true)
    --赋值给循环列表
    self:GetCircleBriefLogsScrollView():Init(self:GetLogCacheList(), function(item, data)
        self:OnCircleBriefLogsScrollViewInited(item, data)
    end)
    self:GetCircleBriefLogsScrollView():ResetToBegining(true)
end

function UIGMPanelLogView_BriefLog:ReverseList()
    local list =  self:GetLogCacheList()
    local max = list.Count/2 - 1
    for i=0,max do
        local temp = list[i]
        list[i] = list[list.Count - i - 1]
        list[list.Count - i - 1] = temp
    end
end

---在刷新后
function UIGMPanelLogView_BriefLog:AfterRefresh()
    while (self.refreshStartTime < self.minRefreshEndTime)
    do
        self.refreshStartTime = CS.UnityEngine.Time.time
        coroutine.yield(0)
    end
    self:GetBriefLogsUIPanel().alpha = 1
    self:GetBlockGameObject():SetActive(false)
    self.mRefreshContentIEnumerator = nil
end

---循环日志列表对象初始化
function UIGMPanelLogView_BriefLog:OnCircleBriefLogsScrollViewInited(item, data)
    local go = item.widget
    local template = self:GetSingleBriefLogTemplate(go)
    template:Refresh(data, self:GetLogCacheList().Count - item.dataIndex)
    if data ~= nil and data.LogIndex ~= nil then
        template:SetSelectedState(self:GetCurrentLogIndex() == data.LogIndex)
    else
        template:SetSelectedState(false)
    end
end

---获取一个GameObject对应的模板
---@return UIGMPanelLogView_SingleBriefLog
function UIGMPanelLogView_BriefLog:GetSingleBriefLogTemplate(go)
    if go then
        if self.mBriefLogTemplates == nil then
            self.mBriefLogTemplates = {}
        end
        if Utility.IsContainsKey(self.mBriefLogTemplates, go) then
            return self.mBriefLogTemplates[go]
        else
            ---@type UIGMPanelLogView_SingleBriefLog
            local template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGMPanelLogViewer_SingleBriefLog, self.mLogViewer)
            self.mBriefLogTemplates[go] = template
            template:BindClickEvent(function(temp)
                self:OnBriefLogClicked(temp)
            end)
            return template
        end
    end
    return nil
end
--endregion

--region 事件
---点击事件
---@param template UIGMPanelLogView_SingleBriefLog
function UIGMPanelLogView_BriefLog:OnBriefLogClicked(template)
    if self:GetCurrentSelectedTemplate() == template then
        self:SelectTemplate(nil)
    else
        self:SelectTemplate(template)
    end
end

---选中一个模板
function UIGMPanelLogView_BriefLog:SelectTemplate(template, force)
    if template then
        self:SetCurrentSelectedLogInfo(template.info, force)
        self:SetCurrentSelectedTemplate(template, force)
    else
        self:SetCurrentSelectedLogInfo(nil, force)
        self:SetCurrentSelectedTemplate(nil, force)
    end
end

---设置当前选中的简略日志变化事件
---@param event function function(logInfo)
function UIGMPanelLogView_BriefLog:SetSelectedBriefLogInfoChangedEvent(event)
    self.mCurrentSelectedBriefLogInfoChangedEvent = event
end

---当前选中的简略信息变化事件
function UIGMPanelLogView_BriefLog:OnCurrentSelectedBriefLogInfoChanged()
    if self.mCurrentSelectedBriefLogInfoChangedEvent then
        self.mCurrentSelectedBriefLogInfoChangedEvent(self:GetCurrentSelectedLogInfo())
    end
end
--endregion

--region 析构
function UIGMPanelLogView_BriefLog:OnDestroy()
    if self and self.mRefreshContentIEnumerator ~= nil then
        StopCoroutine(self.mRefreshContentIEnumerator)
        self.mRefreshContentIEnumerator = nil
    end
end
--endregion

return UIGMPanelLogView_BriefLog