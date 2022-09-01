---@class UIActivityCurrentBase:UIBase 活动基类
local UIActivityCurrentBase = {}

local CheckNullFunction = CS.StaticUtility.IsNull

---@return CSUIRedPointManager
function UIActivityCurrentBase:GetCSUIRedPointManager()
    return CS.CSUIRedPointManager:GetInstance();
end

---@return LuaSpecialActivityData
function UIActivityCurrentBase:GetDataManager()
    return gameMgr:GetPlayerDataMgr():GetSpecialActivityData()
end

--region 组件
---@return UIGridContainer 页签Loop
---@public
function UIActivityCurrentBase:GetBookMark_UIGridContainer()
end

---@public
---@return UnityEngine.GameObject 关闭按钮
function UIActivityCurrentBase:GetCloseBtn_GameObject()
end
--endregion

--region 初始化
---@protected
---初始化
function UIActivityCurrentBase:Init()
    self.mCurrentChooseActivityId = nil
    self:BindEvents()
end

---protected
function UIActivityCurrentBase:Show(customData)
    self:RefreshPanel()
end

---@protected
function UIActivityCurrentBase:BindEvents()
    if CheckNullFunction(self:GetCloseBtn_GameObject()) == false then
        CS.UIEventListener.Get(self:GetCloseBtn_GameObject()).onClick = function()
            self:ClosePanel()
        end
    end
end

function UIActivityCurrentBase:RefreshPanel()
    local allOpenActivity = gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetOpenActivityData()
    if allOpenActivity then
        self.mOpenActivityList = allOpenActivity
        self:RefreshBookMark()
    end
    gameMgr:GetPlayerDataMgr():GetSpecialActivityData():CallAllRedPoint()
end
--endregion


---刷新页签
---@param group number 组
---protected
function UIActivityCurrentBase:RefreshBookMark()
    if self.mOpenActivityList == nil then
        return
    end
    table.sort(self.mOpenActivityList, function(l, r)
        if l == nil or r == nil then
            return false
        end
        local leftData = self:CacheSpecialActivityData(l)
        local rightData = self:CacheSpecialActivityData(r)
        if leftData and rightData then
            return leftData:GetOrder() < rightData:GetOrder()
        end
        return false
    end)

    ---@type table<number,number> 存储eventID 对应服务器发的活动id
    self.mBookMarkTypeToActivityID = {}
    self.mBookMarkTypeToGo = {}
    if CheckNullFunction(self:GetBookMark_UIGridContainer()) == false then
        self:GetBookMark_UIGridContainer().MaxCount = #self.mOpenActivityList
        for i = 0, self:GetBookMark_UIGridContainer().controlList.Count - 1 do
            local go = self:GetBookMark_UIGridContainer().controlList[i].gameObject
            local template = self:GetBookMarkTemplate(go)
            ---@type number
            local activityID = self.mOpenActivityList[i + 1]
            local data = self:CacheSpecialActivityData(activityID)
            if data then
                local eventID = data:GetEventId()
                --红点
                ---@type UIRedPoint
                local redPoint = CS.Utility_Lua.Get(go.transform, "redPoint", "UIRedPoint")
                redPoint:RemoveRedPointKey()

                local isCarnival = eventID == LuaEnumCarnivalEventId.Activity or eventID == LuaEnumCarnivalEventId.Score

                if isCarnival then
                    self:AddRedPoint(LuaEnumCarnivalEventId.Activity, redPoint)
                    self:AddRedPoint(LuaEnumCarnivalEventId.Score, redPoint)
                else
                    self:AddRedPoint(eventID, redPoint)
                end
                --刷新
                self.mBookMarkTypeToActivityID[eventID] = activityID
                self.mBookMarkTypeToGo[eventID] = go
                if template and data then
                    local name = data:GetEventName()
                    if isCarnival then
                        name = "狂欢派对"
                    end
                    template:SetLbInfo(name)
                end
                CS.UIEventListener.Get(go).onClick = function(go)
                    self:OnBookMarkClicked(eventID)
                end
            end
        end
    end
end

function UIActivityCurrentBase:AddRedPoint(eventID, redPoint)
    local key = "SpecialActivity_" .. eventID
    local redPointKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(key)
    gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager():RemoveLuaCallRedPointFunctionByInt(redPointKey)
    gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(redPointKey, function()
        return self:ShowRedPoint(eventID)
    end)
    self:AddNeedRemoveRedPointKey(redPointKey)
    redPoint:AddRedPointKey(redPointKey)
end

---@return boolean  是否显示红点
function UIActivityCurrentBase:ShowRedPoint(eventID)
    return gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetSingleActivityState(eventID)
end

---@return UICommonBookMarkTemplate
---protected
function UIActivityCurrentBase:GetBookMarkTemplate(go)
    if CheckNullFunction(go) then
        return
    end
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICommonBookMarkTemplate)
        self.mGoToTemplate[go] = template
    end
    return template
end

---根据活动id选中页签
function UIActivityCurrentBase:ChooseBookMarkByActivityId(activityId)
    local data = self:CacheSpecialActivityData(activityId)
    if data then
        self:ChooseBookMarkByEventId(data:GetEventId())
    end
end

---外部调用选中页签
---public
---@param eventId number 对应 cfg_special_activity eventId
function UIActivityCurrentBase:ChooseBookMarkByEventId(eventId)
    if eventId == nil then
        return
    end
    if self.mBookMarkTypeToGo then
        local go = self.mBookMarkTypeToGo[eventId]
        local template = self:GetBookMarkTemplate(go)
        if template then
            template:ChooseItem(true)
        end
    end
    self:OnBookMarkClicked(eventId)
end

---@return TABLE.cfg_special_activity 缓存活动表数据
function UIActivityCurrentBase:CacheSpecialActivityData(activityID)
    if self.mActivityIDToData == nil then
        self.mActivityIDToData = {}
    end
    local tblData = self.mActivityIDToData[activityID]
    if tblData == nil then
        tblData = clientTableManager.cfg_special_activityManager:TryGetValue(activityID)
    end
    return tblData
end

---@class SpecialActivityPanelData
---@field mActivityID number 活动id
---@field mEventID number 活动类型
---@field mFinishTime number 活动结束时间戳(秒时间戳)
---@field mStartTime number 活动开始时间戳（秒时间戳）

---protected
---@param chooseType number 对应 cfg_special_activity eventId
function UIActivityCurrentBase:OnBookMarkClicked(chooseType)
    if self.mBookMarkTypeToActivityID then
        local activityID = self.mBookMarkTypeToActivityID[chooseType]
        if activityID and (not self:GetDataManager():IsCarnivalActivity(chooseType)) then
            networkRequest.ReqGetOneActivitiesInfo(activityID)
        end
        self.mCurrentChooseActivityId = activityID
        self:HidOtherPanel(chooseType)
        self:TryShowPanel(activityID, chooseType)
        self:ClickPageTryChangeRedPoint(activityID,chooseType)
    end
end

---protected
---@param chooseType number 对应 cfg_special_activity eventId
function UIActivityCurrentBase:ClickPageTryChangeRedPoint(activityID,chooseType)
    local specialActivityTbl = clientTableManager.cfg_special_activityManager:TryGetValue(activityID)
    if specialActivityTbl == nil then
        return
    end
    if specialActivityTbl:GetRedPoint() == LuaEnumSpecialActivityRedPointCloseType.ClickPage then
        gameMgr:GetPlayerDataMgr():GetSpecialActivityData():ChangeSingleActivityRedPointState(chooseType, false)
    end
end

---关闭其他界面
function UIActivityCurrentBase:HidOtherPanel(chooseType)
    if self.mEventIdToPanel then
        for k, v in pairs(self.mEventIdToPanel) do
            if k ~= chooseType then
                uimanager:HidePanel(v)
            end
        end
    end
end

---显示界面
function UIActivityCurrentBase:TryShowPanel(activityID, chooseType)
    local panel = self:GetCreatedPanel(chooseType)
    ---@type SpecialActivityPanelData
    local customData = {}
    customData.mActivityID = activityID
    customData.mEventID = chooseType
    customData.mStartTime, customData.mFinishTime = self:GetStartFinishTime(activityID)
    if panel then
        uimanager:ReShowPanel(panel)
        panel:Show(customData)
    else
        local data = self:CacheSpecialActivityData(activityID)
        if data and data:GetPanel() and data:GetPanel() ~= "" then

            uimanager:CreatePanel(data:GetPanel(), function(panel)
                self:SaveCreatePanel(chooseType, panel)
                if CS.StaticUtility.IsNull(self.go) then
                    self:DestroyPanel()
                end
            end, customData)
        end
    end
end

---@return number 结束时间戳/毫秒
function UIActivityCurrentBase:GetStartFinishTime(activityID)
    local startTime = 0
    local endTime = 0
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    local data = self:CacheSpecialActivityData(activityID)
    if data then
        local type = data:GetEventType()
        ---@type activitiesV2.ResOneActivitiesInfo
        local activityData = gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetSingleActivityData(data:GetEventId())
        local lastDay = data:GetEventLast()
        if activityData and activityData.leftTime then
            endTime = activityData.leftTime
            startTime = endTime - lastDay * 24 * 60 * 60
        else
            if isOpenLog then
                print("服务器没有发活动id为", activityID, "活动类型为", data:GetEventId(), "的结束时间")
            end
        end
    end
    return startTime, endTime
end

---存储当前打开界面
function UIActivityCurrentBase:SaveCreatePanel(chooseType, panel)
    if self.mEventIdToPanel == nil then
        self.mEventIdToPanel = {}
    end
    self.mEventIdToPanel[chooseType] = panel
end

---获取当前已创建界面
function UIActivityCurrentBase:GetCreatedPanel(chooseType)
    if self.mEventIdToPanel == nil then
        self.mEventIdToPanel = {}
    end
    return self.mEventIdToPanel[chooseType]
end

---关闭界面
function UIActivityCurrentBase:DestroyPanel()
    if self.mEventIdToPanel then
        for k, v in pairs(self.mEventIdToPanel) do
            uimanager:ClosePanel(v)
        end
    end
    self:ClearAllRedPointKey()
end

--region 红点管理
---添加红点
function UIActivityCurrentBase:AddNeedRemoveRedPointKey(intKey)
    if self.mNeedRemoveRedPointKey == nil then
        self.mNeedRemoveRedPointKey = {}
    end
    table.insert(self.mNeedRemoveRedPointKey, intKey)
end

---移除红点
function UIActivityCurrentBase:ClearAllRedPointKey()
    if self.mNeedRemoveRedPointKey then
        for i = 1, #self.mNeedRemoveRedPointKey do
            gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager():RemoveLuaCallRedPointFunctionByInt(self.mNeedRemoveRedPointKey[i])
        end
    end
end
--endregion

return UIActivityCurrentBase