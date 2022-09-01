---独立筛选(网络消息)
---@class UIGMPanelLogView_IndividualFilter_NetworkMsg:UIGMPanelLogView_IndividualFilterBase
local UIGMPanelLogView_IndividualFilter_NetworkMsg = {}

---@return UIInput
function UIGMPanelLogView_IndividualFilter_NetworkMsg:GetMsgIDInput()
    if self.mMsgIDInput == nil then
        self.mMsgIDInput = self:Get("MsgIDFilter/Input", "UIInput")
    end
    return self.mMsgIDInput
end

---@return UIPopupList
function UIGMPanelLogView_IndividualFilter_NetworkMsg:GetMsgDirectionPopupList()
    if self.mMsgDirPopupList == nil then
        self.mMsgDirPopupList = self:Get("MsgDirectionFilter/MsgDirectionPopupList", "UIPopupList")
    end
    return self.mMsgDirPopupList
end

function UIGMPanelLogView_IndividualFilter_NetworkMsg:Init()
    self:GetMsgIDInput().value = ""
    CS.EventDelegate.Add(self:GetMsgIDInput().onChange, function()
        local value = self:GetMsgIDInput().value
        if value and value ~= "" then
            local id = tonumber(value)
            self:OnMsgIDChanged(id)
        else
            self:OnMsgIDChanged(0)
        end
    end)
    self:GetMsgDirectionPopupList():Clear()
    self:GetMsgDirectionPopupList():AddItem("All")
    self:GetMsgDirectionPopupList():AddItem("ToClient")
    self:GetMsgDirectionPopupList():AddItem("ToServer")
    self:GetMsgDirectionPopupList().value = "All"
    CS.EventDelegate.Add(self:GetMsgDirectionPopupList().onChange, function()
        self:OnMsgDirectionChanged(self:GetMsgDirectionPopupList().value)
    end)
end

---筛选
function UIGMPanelLogView_IndividualFilter_NetworkMsg:DoFilter(logInfo)
    if logInfo and logInfo.ExtraData then
        --筛选消息ID
        if self.mID ~= nil and self.mID ~= 0 then
            if self.mID ~= math.abs(logInfo.ExtraData) then
                return false
            end
        end
        --筛选消息流向
        if self.mMsgDirectionFilter ~= nil and self.mMsgDirectionFilter ~= 0 then
            return self.mMsgDirectionFilter * logInfo.ExtraData >= 0
        end
        return true
    end
    return false
end

---消息ID变化
---@param id number
function UIGMPanelLogView_IndividualFilter_NetworkMsg:OnMsgIDChanged(id)
    self.mID = id
end

---消息流向变化
---@param msgDirString string
function UIGMPanelLogView_IndividualFilter_NetworkMsg:OnMsgDirectionChanged(msgDirString)
    if msgDirString then
        if msgDirString == "ToServer" then
            self.mMsgDirectionFilter = 1
            return
        elseif msgDirString == "ToClient" then
            self.mMsgDirectionFilter = -1
            return
        end
    end
    self.mMsgDirectionFilter = 0
end

return UIGMPanelLogView_IndividualFilter_NetworkMsg