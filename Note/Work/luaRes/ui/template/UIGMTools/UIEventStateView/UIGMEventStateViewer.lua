---@class UIGMEventStateViewer:TemplateBase
local UIGMEventStateViewer = {}

---@return UIPopupList
function UIGMEventStateViewer:GetEventTypePopupList()
    if self.mEventTypePopupList == nil then
        self.mEventTypePopupList = self:Get("EventTypePopupList", "UIPopupList")
    end
    return self.mEventTypePopupList
end

---@return UnityEngine.GameObject
function UIGMEventStateViewer:GetRefreshButtonGO()
    if self.mRefreshButtonGO == nil then
        self.mRefreshButtonGO = self:Get("RefreshButton", "GameObject")
    end
    return self.mRefreshButtonGO
end

---@return UIGridContainer
function UIGMEventStateViewer:GetEventListGridContainer()
    if self.mEventListGridContainer == nil then
        self.mEventListGridContainer = self:Get("EventScrollView/EventList", "UIGridContainer")
    end
    return self.mEventListGridContainer
end

function UIGMEventStateViewer:Init(panel)
    CS.EventDelegate.Add(self:GetEventTypePopupList().onChange, function()
        self:Refresh(self:GetEventTypePopupList().value)
    end)
    CS.UIEventListener.Get(self:GetRefreshButtonGO()).onClick = function()
        self:Refresh(self:GetEventTypePopupList().value)
    end
end

function UIGMEventStateViewer:Show()
    self.go:SetActive(true)
end

function UIGMEventStateViewer:Hide()
    self.go:SetActive(false)
end

---刷新
---C#Event
---C#Socket
---LuaEvent
---LuaNetMsg
---@param eventType string
function UIGMEventStateViewer:Refresh(eventType)
    if eventType == "C#Event" then
        self:RefreshEventListWithArray(CS.EventHandlerManager.GetClientEventCallBackState())
    elseif eventType == "C#Socket" then
        self:RefreshEventListWithArray(CS.EventHandlerManager.GetSocketEventCallBackState())
    elseif eventType == "LuaEvent" then
        self:RefreshEventListWithTable(luaEventManager.GetCallBackState())
    elseif eventType == "LuaNetMsg" then
        self:RefreshEventListWithTable(commonNetMsgDeal.GetCallBackState())
    end
end

---使用字符串数组刷新EventList
---@param array System.Array
function UIGMEventStateViewer:RefreshEventListWithArray(array)
    if array == nil then
        self:GetEventListGridContainer().MaxCount = 0
        return
    end
    local count = array.Length
    self:GetEventListGridContainer().MaxCount = count
    if count == 0 then
        return
    end
    for i = 1, count do
        local go = self:GetEventListGridContainer().controlList[i - 1]
        ---@type UILabel
        local label = self:GetCurComp(go, "InfoLabel", "UILabel")
        label.text = array[i - 1]
    end
end

---使用table刷新EventList
---@param table table
function UIGMEventStateViewer:RefreshEventListWithTable(table)
    if table == nil then
        self:GetEventListGridContainer().MaxCount = 0
        return
    end
    local count = #table
    self:GetEventListGridContainer().MaxCount = count
    if count == 0 then
        return
    end
    for i = 1, count do
        local go = self:GetEventListGridContainer().controlList[i - 1]
        ---@type UILabel
        local label = self:GetCurComp(go, "InfoLabel", "UILabel")
        label.text = table[i]
    end
end

return UIGMEventStateViewer