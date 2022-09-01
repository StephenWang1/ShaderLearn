---@class GM界面的日志查看的日志细节:TemplateBase
local UIGMPanelLogViewer_LogDetail = {}

--region 组件
---@return UIScrollView 内容的UIScrollView组件
function UIGMPanelLogViewer_LogDetail:GetContentScrollView()
    if self.mContentScrollView == nil then
        self.mContentScrollView = self:Get("LogDetailScrollView", "UIScrollView")
    end
    return self.mContentScrollView
end

---@return UILabel 内容文字组件
function UIGMPanelLogViewer_LogDetail:GetContentUILabel()
    if self.mContentUILabel == nil then
        self.mContentUILabel = self:Get("LogDetailScrollView/LogDetail", "UILabel")
    end
    return self.mContentUILabel
end

function UIGMPanelLogViewer_LogDetail:GetLogDisPlayer()
    if self.mLogDisplayer == nil then
        self.mLogDisplayer = self:Get("LogDetailScrollView/LogLines", "UIGMLogDisplayer")
    end
    return self.mLogDisplayer
end

function UIGMPanelLogViewer_LogDetail:GetExpandButton()
    if self.mExpandButton == nil then
        self.mExpandButton = self:Get("ExpandBtn", "GameObject")
    end
    return self.mExpandButton
end

-----@return UnityEngine.GameObject 差异标识
--function UIGMPanelLogViewer_LogDetail:GetDiffSignGameObject()
--    if self.mDiffSignGameObject == nil then
--        self.mDiffSignGameObject = self:Get("LogDetailBGDiff", "GameObject")
--    end
--    return self.mDiffSignGameObject
--end

function UIGMPanelLogViewer_LogDetail:FoldOnButton()
    if self.mFoldOnButton == nil then
        self.mFoldOnButton = self:Get("FoldOn", "GameObject")
    end
    return self.mFoldOnButton
end

function UIGMPanelLogViewer_LogDetail:UnfoldButton()
    if self.mUnfoldButton == nil then
        self.mUnfoldButton = self:Get("UnFold", "GameObject")
    end
    return self.mUnfoldButton
end

---@return UIButton 复制按钮
function UIGMPanelLogViewer_LogDetail:GetCopyButtonUIButton()
    if self.mCopyButtonGameObject == nil then
        self.mCopyButtonGameObject = self:Get("CopyBtn", "UIButton")
    end
    return self.mCopyButtonGameObject
end
--endregion

---@param logViewer GM界面的日志查看
function UIGMPanelLogViewer_LogDetail:Init(logViewer)
    self.mLogViewer = logViewer
    CS.EventDelegate.Add(self:GetCopyButtonUIButton().onClick, function()
        if self.logInfo and self.logInfo.Content ~= nil then
            CS.NGUITools.clipboard = CS.RichTextFactory.Binder:StripRichText(self.infoContent)
        end
    end)
    CS.UIEventListener.Get(self:GetExpandButton()).onClick = function()
        self.mLogViewer:OnExpandDetailButtonClicked()
        self:GetContentScrollView():ResetPosition()
    end
    CS.UIEventListener.Get(self:FoldOnButton()).onClick = function()
        self:GetLogDisPlayer():FoldOnAll()
    end
    CS.UIEventListener.Get(self:UnfoldButton()).onClick = function()
        self:GetLogDisPlayer():UnFoldAll()
    end
end

---刷新日志信息
---@param logInfo {LogIndex:number,FrameIndex:number,BriefInfo:string,Content:string,LogTime:string}
---@param logType LuaEnumLogViewerLogType
function UIGMPanelLogViewer_LogDetail:RefreshLogInfo(logInfo, logType)
    self.logInfo = logInfo
    if logInfo then
        self.infoContent = self:GetLogInfoHeadString(logInfo, logInfo.LogType, true) .. "\r\n" .. logInfo.Content
    else
        self.infoContent = ""
    end
    --self:GetContentUILabel().text = self.infoContent
    self:GetLogDisPlayer():Refresh(self.infoContent)
    self:GetContentScrollView():ResetPosition()
end

---获取日志信息的头字符串
---@param logInfo {LogIndex:number,FrameIndex:number,BriefInfo:string,Content:string,LogTime:string}
---@param logType LuaEnumLogViewerLogType
function UIGMPanelLogViewer_LogDetail:GetLogInfoHeadString(logInfo, logType, encodingSupported)
    if encodingSupported then
        return "[00f5cf]" .. self.mLogViewer:GetLogTypeName(logType) .. "        " .. logInfo.LogTime .. "        第" .. tostring(logInfo.FrameIndex) .. "帧[-]"
    else
        return self.mLogViewer:GetLogTypeName(logType) .. "        " .. logInfo.LogTime .. "        第" .. tostring(logInfo.FrameIndex) .. "帧"
    end
end

return UIGMPanelLogViewer_LogDetail