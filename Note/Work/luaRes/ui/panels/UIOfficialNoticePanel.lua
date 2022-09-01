---@class UIOfficialNoticePanel:UIBase 登录公告
local UIOfficialNoticePanel = {}

--region 组件
---关闭按钮
function UIOfficialNoticePanel.GetCloseButton_GameObject()
    if UIOfficialNoticePanel.mCloseButton == nil then
        UIOfficialNoticePanel.mCloseButton = UIOfficialNoticePanel:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return UIOfficialNoticePanel.mCloseButton
end

---确认按钮
function UIOfficialNoticePanel.GetKnowButton_GameObject()
    if UIOfficialNoticePanel.mKnowButton == nil then
        UIOfficialNoticePanel.mKnowButton = UIOfficialNoticePanel:GetCurComp("WidgetRoot/events/btn_know", "GameObject")
    end
    return UIOfficialNoticePanel.mKnowButton
end

---@return UIGridContainer 公告文本
function UIOfficialNoticePanel:GetNoteLabel_Container()
    if self.mNoteLabel == nil then
        self.mNoteLabel = self:GetCurComp("WidgetRoot/view/scrollview/Grid", "UIGridContainer")
    end
    return self.mNoteLabel
end

---公告标题
function UIOfficialNoticePanel:GetNoteTilte()
    if self.mNoteTilte == nil then
        self.mNoteTilte = self:GetCurComp("WidgetRoot/window/tilte", "UILabel")
    end
    return self.mNoteTilte
end

---@return Top_UITable 公告文本
function UIOfficialNoticePanel:GetNoteLabel_UITable()
    if self.mNoteTable == nil then
        self.mNoteTable = self:GetCurComp("WidgetRoot/view/scrollview/Grid", "Top_UITable")
    end
    return self.mNoteTable
end
--endregion

--region 数据
---@return HttpRequest
function UIOfficialNoticePanel:GetHttpRequest()
    if self.mHttpRequest == nil then
        self.mHttpRequest = CS.HttpRequest.Instance
    end
    return self.mHttpRequest
end
--endregion

--region 初始化
function UIOfficialNoticePanel:Init()
    UIOfficialNoticePanel.BindEvents()
end

function UIOfficialNoticePanel.BindEvents()
    CS.UIEventListener.Get(UIOfficialNoticePanel.GetCloseButton_GameObject()).onClick = UIOfficialNoticePanel.OnCloseButtonClicked
    CS.UIEventListener.Get(UIOfficialNoticePanel.GetKnowButton_GameObject()).onClick = UIOfficialNoticePanel.OnCloseButtonClicked
end

function UIOfficialNoticePanel:Show()
    self:ShowNote()
end
--endregion

--region UI事件
---点击关闭按钮
function UIOfficialNoticePanel.OnCloseButtonClicked()
    uimanager:ClosePanel(UIOfficialNoticePanel)
end

function UIOfficialNoticePanel:ShowNote()
    local info = self:GetHttpRequest().Notes
    self:GetNoteLabel_Container().MaxCount = info.Count
    for i = 0, info.Count - 1 do
        ---@type UnityEngine.GameObject
        local go = self:GetNoteLabel_Container().controlList[i]
        local nameLabel = CS.Utility_Lua.Get(go.transform, "call", "UILabel")
        local noteLabel = CS.Utility_Lua.Get(go.transform, "content", "UILabel")
        nameLabel.text = info[i].name
        noteLabel.text = info[i].note
    end
    self:GetNoteLabel_UITable():Reposition()
    local  gameDesc=Utility.GetGameName()
    if gameDesc~=nil and  gameDesc~=""  then
        self:GetNoteTilte().text="欢迎来到【"..gameDesc .."】世界"
    end
end

--endregion

return UIOfficialNoticePanel