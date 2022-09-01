---@class LuaSpecialActivityData
local LuaSpecialActivityData = {}

---@type table<number,boolean> activityId对应是否开启
LuaSpecialActivityData.mAllOpenActivityOpenState = nil
---@type table<number,boolean> eventID对应开启状态
LuaSpecialActivityData.mAllOpenEventIDs = nil

---@type table<number,number> 存储需要提前向服务器请求的活动activityId
LuaSpecialActivityData.mReqEventIdList = {
    ---狂欢商店
    8,
}

---客户端事件监听
---@return EventHandlerManager
function LuaSpecialActivityData:GetClientEventHandler()
    if self.mClientEventHandler == nil then
        self.mClientEventHandler = CS.EventHandlerManager(CS.EventHandlerManager.DispatchType.Event)
    end
    return self.mClientEventHandler
end

function LuaSpecialActivityData:Init()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:OnBagItemChanged()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        self:OnBagCoinChanged()
    end)
end

---@param data activitiesV2.AllActivitiesOpenInfo
function LuaSpecialActivityData:SaveActivityData(data)
    self.mAllOpenActivityOpenState = {}
    self.mAllOpenEventIDs = {}
    if data.allOpenTypeStauts then
        for i = 1, #data.allOpenTypeStauts do
            local activityId = data.allOpenTypeStauts[i]
            self.mAllOpenActivityOpenState[activityId] = true
            local specialActivityTbl = clientTableManager.cfg_special_activityManager:TryGetValue(activityId)
            if specialActivityTbl then
                self.mAllOpenEventIDs[specialActivityTbl:GetEventId()] = true
            end
        end
    end

    ---从服务器开启的活动中找到需要及时获取服务器数据的活动ID,并向服务器请求该活动的具体数据
    if self.mReqEventIdList and #self.mReqEventIdList > 0 and data.allOpenTypeStauts ~= nil then
        for i = 1, #self.mReqEventIdList do
            local eventID = self.mReqEventIdList[i]
            local openedActivityID
            for j = 1, #data.allOpenTypeStauts do
                local activityId = data.allOpenTypeStauts[j]
                local specialActivityTbl = clientTableManager.cfg_special_activityManager:TryGetValue(activityId)
                if specialActivityTbl then
                    if specialActivityTbl:GetEventId() == eventID then
                        openedActivityID = activityId
                        break
                    end
                end
            end
            if openedActivityID ~= nil then
                networkRequest.ReqGetOneActivitiesInfo(openedActivityID)
            end
        end
    end

    ---将所有id活动请求一遍，缓存数据
    if data.allOpenTypeStauts then
        for p = 1, #data.allOpenTypeStauts do
            local activityId = data.allOpenTypeStauts[p]
            local specialActivityTbl = clientTableManager.cfg_special_activityManager:TryGetValue(activityId)
            if specialActivityTbl then
                self:SetTheFirstLoginRedDot(specialActivityTbl)
                self:SaveEventIdToActivityId(specialActivityTbl:GetEventId(), activityId)
                if self:GetSingleActivityData(specialActivityTbl:GetEventId()) == nil then
                    networkRequest.ReqGetOneActivitiesInfo(activityId)
                end
            end
        end
    end

    if data.allRedId then
        for i = 1, #data.allRedId do
            local specialActivityTbl = clientTableManager.cfg_special_activityManager:TryGetValue(data.allRedId[i])
            if specialActivityTbl then
                self:ChangeSingleActivityRedPointState(specialActivityTbl:GetEventId(), true)
            end
        end
        self:CallAllRedPoint()
    end
    luaEventManager.DoCallback(LuaCEvent.mAllActivityChange)
end

---客户端手动设置首次登录红点
---@param specialActivityTbl TABLE.cfg_special_activity
function LuaSpecialActivityData:SetTheFirstLoginRedDot(specialActivityTbl)
    if (specialActivityTbl == nil) then
        return
    end
    if (specialActivityTbl:GetEventId() == 17 and (self.firstRedPointDic == nil or self.firstRedPointDic[specialActivityTbl:GetEventId()] == nil)) then
        if (self.firstRedPointDic == nil) then
            self.firstRedPointDic = {}
        end
        self:ChangeSingleActivityRedPointState(specialActivityTbl:GetEventId(), true)
        self.firstRedPointDic[specialActivityTbl:GetEventId()] = false
    end
end

---与服务器的约定，这里的id对应special_activity表
---
---比如一个活动里面有001-005的id，服务器只发001，根据这个id获取表里的eventId字段,通过ReqGetOneActivitiesInfoMessage请求所有数据
---@return table<number,number>
function LuaSpecialActivityData:GetOpenActivityData()
    local openList = {}
    if self.mAllOpenActivityOpenState then
        self.mAddSpecialActivity = false
        for k, v in pairs(self.mAllOpenActivityOpenState) do
            if v and self:GetActivityNeedShow(k) then
                table.insert(openList, k)
            end
        end
    end
    return openList
end

---热血派对只显示
---@return boolean 特殊活动是否需要显示
function LuaSpecialActivityData:GetActivityNeedShow(activityId)
    local specialActivityTbl = clientTableManager.cfg_special_activityManager:TryGetValue(activityId)
    if specialActivityTbl == nil then
        return true
    end
    if self:IsCarnivalActivity(specialActivityTbl:GetEventId()) then
        if self.mAddSpecialActivity then
            return false
        else
            self.mAddSpecialActivity = true
            return true
        end
    end
    return true
end

---@return boolean 是否是热血派对
---@param eventId number
function LuaSpecialActivityData:IsCarnivalActivity(eventId)
    return eventId == LuaEnumCarnivalEventId.Activity or eventId == LuaEnumCarnivalEventId.Score
end

---改变活动状态
---@param activityId number
---@param state boolean true打开/false关闭
function LuaSpecialActivityData:ChangeActivityOpenState(activityId, state)
    if self.mAllOpenActivityOpenState == nil then
        self.mAllOpenActivityOpenState = {}
    end
    if self.mAllOpenEventIDs == nil then
        self.mAllOpenEventIDs = {}
    end
    self.mAllOpenActivityOpenState[activityId] = state
    local specialActivityTbl = clientTableManager.cfg_special_activityManager:TryGetValue(activityId)
    if specialActivityTbl then
        local eventId = specialActivityTbl:GetEventId()
        self.mAllOpenEventIDs[eventId] = state
        if state == false then
            ---活动关闭移除红点
            self:ChangeSingleActivityRedPointState(eventId, state)
        else
            networkRequest.ReqGetOneActivitiesInfo(activityId)
        end
    end
    luaEventManager.DoCallback(LuaCEvent.mAllActivityChange)
end

---获得活动开启状态
---@param eventId number 活动表中的eventId
function LuaSpecialActivityData:GetActivityOpenState(eventId)
    if eventId == nil then
        return false
    end
    if self.mAllOpenEventIDs == nil then
        self.mAllOpenEventIDs = {}
    end
    local state = self.mAllOpenEventIDs[eventId]
    if state == nil then
        state = false
        self.mAllOpenEventIDs[eventId] = state
    end
    return state
end

--region eventId对应单个活动Id
function LuaSpecialActivityData:SaveEventIdToActivityId(eventID, activityId)
    if self.mEventIdToActivityId == nil then
        self.mEventIdToActivityId = {}
    end
    self.mEventIdToActivityId[eventID] = activityId
end

---根据eventId获取活动id
function LuaSpecialActivityData:GetActivityIdByEventId(eventID)
    if self.mEventIdToActivityId then
        return self.mEventIdToActivityId[eventID]
    end
end
--endregion

--region 单个活动数据
---@return SpecialActivity_CarnivalShop
function LuaSpecialActivityData:GetCarnivalShop()
    if self.mSpecialActivityCarnivalShop == nil then
        self.mSpecialActivityCarnivalShop = luaclass.LuaSpecialActivity_CarnivalShop:New(self)
    end
    return self.mSpecialActivityCarnivalShop
end

---存储单个活动数据
---@param eventId number
---@param data activitiesV2.ResOneActivitiesInfo
function LuaSpecialActivityData:SaveSingleActivityData(eventId, data)
    if self.mEventIdToData == nil then
        self.mEventIdToData = {}
    end
    self.mEventIdToData[eventId] = data
    self:SaveSingleActivityInfo(eventId, data)
    self:SaveExtData(data.extInfo)
    luaEventManager.DoCallback(LuaCEvent.mSingleActivityChange, eventId)
    self:ReCalculateRedPoint(eventId)
end

---返回单个活动数据
---@return activitiesV2.ResOneActivitiesInfo
function LuaSpecialActivityData:GetSingleActivityData(eventId)
    if self.mEventIdToData then
        return self.mEventIdToData[eventId]
    end
end

---挖宝回馈
---根据活动id 确定最大奖励要求数量 以及奖励物品
function LuaSpecialActivityData:GetDigTreasureRepayActivityData(configId)
    local configData = clientTableManager.cfg_special_activityManager:TryGetValue(configId)
    if configData == nil then
        return nil
    end
    local res = {}
    res.goal = configData.goal.list[1]
    res.award = configData.award.list
    return res
end

---活动数据变化事件
---@private
---@param changedActivityEventID
function LuaSpecialActivityData:OnActivityChanged(changedActivityEventID)
    if changedActivityEventID == 8 then
        ---狂欢商店
        local redPointState = self:GetCarnivalShop():GetRedPointState()
        self:ChangeSingleActivityRedPointState(changedActivityEventID, redPointState)
    elseif changedActivityEventID == 19 then
        --挖宝回馈红点计算
        local finishd =  self.mEventIdToData[changedActivityEventID].oneActivitiesInfo
        for i = 1, #finishd do
            if finishd[i].finish == LuaDigTreasureRepayActivityState.CAN_RECEIVE then
                --可领取 需要添加红点
                self:ChangeSingleActivityRedPointState(changedActivityEventID, true)
                return
            end
        end
        self:ChangeSingleActivityRedPointState(changedActivityEventID, false)
    end
end
--endregion

--region 刷新单条活动数据
---@param data activitiesV2.ResOneActivitiesInfo
function LuaSpecialActivityData:SaveSingleActivityInfo(eventId, data)
    if self.mEventIdToActivityAllInfo == nil then
        self.mEventIdToActivityAllInfo = {}
    end
    local allEventInfo = self.mEventIdToActivityAllInfo[eventId]
    if allEventInfo == nil then
        allEventInfo = {}
        self.mEventIdToActivityAllInfo[eventId] = allEventInfo
    end
    if data.oneActivitiesInfo then
        for i = 1, #data.oneActivitiesInfo do
            local singleInfo = data.oneActivitiesInfo[i]
            allEventInfo[singleInfo.configId] = singleInfo
        end
    end
end

---改变单个活动数据
---@param data activitiesV2.OneActivitiesInfo
function LuaSpecialActivityData:ChangeSingleActivityInfo(data)
    local tblInfo = clientTableManager.cfg_special_activityManager:TryGetValue(data.configId)
    if tblInfo == nil then
        return
    end
    if self.mEventIdToActivityAllInfo == nil then
        self.mEventIdToActivityAllInfo = {}
    end
    local allEventInfo = self.mEventIdToActivityAllInfo[tblInfo:GetEventId()]
    if allEventInfo == nil then
        allEventInfo = {}
    end
    allEventInfo[data.configId] = data
    luaEventManager.DoCallback(LuaCEvent.mSingleActivityChange, tblInfo:GetEventId())
    self:ReCalculateRedPoint(tblInfo:GetEventId())
end

---获取单个活动数据
---@return activitiesV2.OneActivitiesInfo
function LuaSpecialActivityData:GetSingleActivityInfo(configId)
    local tblInfo = clientTableManager.cfg_special_activityManager:TryGetValue(configId)
    if tblInfo == nil then
        return
    end
    if self.mEventIdToActivityAllInfo == nil then
        return
    end
    local allEventInfo = self.mEventIdToActivityAllInfo[tblInfo:GetEventId()]
    if allEventInfo == nil then
        return
    end
    return allEventInfo[configId]
end
--endregion

--region 刷新额外数据
---存储额外数据
---@param data activitiesV2.ActivitiesPartInfo
function LuaSpecialActivityData:SaveExtData(data)
    if data == nil then
        return
    end
    if self.mEventIdToExtData == nil then
        self.mEventIdToExtData = {}
    end
    if data.type ~= nil then
        self.mEventIdToExtData[data.type] = data
    end
end

---@param data activitiesV2.ActivitiesPartInfo
function LuaSpecialActivityData:ChangeExtData(data)
    if data == nil then
        return
    end
    if self.mEventIdToExtData == nil then
        self.mEventIdToExtData = {}
    end
    self.mEventIdToExtData[data.type] = data
    luaEventManager.DoCallback(LuaCEvent.mSingleActivityChange, LuaEnumCarnivalEventId.Score)
    self:ReCalculateRedPoint(data.type)
end

---@return activitiesV2.ActivitiesPartInfo
function LuaSpecialActivityData:GetExtData(eventId)
    if self.mEventIdToExtData then
        return self.mEventIdToExtData[eventId]
    end
end
--endregion

--region 红点数据
---重新计算活动的红点
---@param eventID
function LuaSpecialActivityData:ReCalculateRedPoint(eventID)
    if self:GetActivityOpenState(eventID) == false then
        return
    end
    self:OnActivityChanged(eventID)
    self:CallAllRedPoint()
end

---存储单个红点状态
---@param eventId number 活动类型（special_activity表的eventId）
---@param state boolean 是否显示
function LuaSpecialActivityData:ChangeSingleActivityRedPointState(eventId, state)
    if self.mCurrentChangeRedPoint == nil then
        ---当前有变化的红点列表
        self.mCurrentChangeRedPoint = {}
    end

    if self.mActivityTypeToRedPoint == nil then
        ---红点状态缓存
        self.mActivityTypeToRedPoint = {}
    end
    if eventId == LuaEnumCarnivalEventId.Score or eventId == LuaEnumCarnivalEventId.Activity then
        self.mCurrentChangeRedPoint[eventId] = true
    else
        local currentRedPointState = self:GetSingleActivityState(eventId)
        if currentRedPointState ~= state then
            self.mCurrentChangeRedPoint[eventId] = true
        end
    end
    self.mActivityTypeToRedPoint[eventId] = state
    self:CallAllRedPoint()
end

---call所有红点
function LuaSpecialActivityData:CallAllRedPoint()
    if self.mCurrentChangeRedPoint then
        for k, v in pairs(self.mCurrentChangeRedPoint) do
            local key = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey("SpecialActivity_" .. k)
            if key then
                CS.CSUIRedPointManager.GetInstance():CallRedPoint(key)
            end
        end
    end
    local SpecialActivity_Limit = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.SpecialActivity_Limit)
    local SpecialActivity_KuaFu = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.SpecialActivity_KuaFu)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(SpecialActivity_Limit)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(SpecialActivity_KuaFu)
    self.mCurrentChangeRedPoint = {}
end

---@return boolean 是否显示红点
function LuaSpecialActivityData:GetSingleActivityState(eventId)
    if self.mActivityTypeToRedPoint == nil then
        self.mActivityTypeToRedPoint = {}
    end
    local state = self.mActivityTypeToRedPoint[eventId]
    if state == nil then
        state = false
    end
    return state
end

---@return boolean 是否有活动红点
function LuaSpecialActivityData:IsAnyActivityHasRedPoint()
    if self.mActivityTypeToRedPoint then
        for k, v in pairs(self.mActivityTypeToRedPoint) do
            if v then
                return true
            end
        end
    end
    return false
end
--endregion

--region 事件
---背包物品变化事件
---@private
function LuaSpecialActivityData:OnBagItemChanged()
    ---背包物品变化时,重新计算狂欢商店红点
    self:ReCalculateRedPoint(8)
end

---背包货币变化事件
---@private
function LuaSpecialActivityData:OnBagCoinChanged()
    ---背包货币变化时,重新计算狂欢商店红点
    self:ReCalculateRedPoint(8)
end
--endregion

--region活动icon

---获取当前显示活动icon
---@return string
function LuaSpecialActivityData:GetCurrentActivityIcon()
    local allActivity = self:GetOpenActivityData()
    local eventType = 1
    for i = 1, #allActivity do
        local activityId = allActivity[i]
        local tblData = clientTableManager.cfg_special_activityManager:TryGetValue(activityId)
        if tblData and tblData:GetEventType() > eventType then
            eventType = tblData:GetEventType()
        end
    end
    return self:GetEventTypeToIcon(eventType)
end

function LuaSpecialActivityData:GetEventTypeToIcon(eventType)
    if self.mEventTypeToIcon == nil then
        self.mEventTypeToIcon = {}
        local globalInfo = LuaGlobalTableDeal.GetGlobalTabl(22870)
        if globalInfo then
            local strs = string.Split(globalInfo.value, '&')
            for i = 1, #strs do
                local info = string.Split(strs[i], '#')
                if #info >= 2 then
                    local type = tonumber(info[1])
                    local icon = info[2]
                    if type and icon then
                        self.mEventTypeToIcon[type] = icon
                    end
                end
            end
        end
    end
    local icon = self.mEventTypeToIcon[eventType]
    if icon then
        return icon
    end
    return "1006"
end
--endregion

function LuaSpecialActivityData:Release()
    if self.mClientEventHandler ~= nil then
        self.mClientEventHandler:UnRegAll()
    end
    self.firstRedPointDic = nil
end

return LuaSpecialActivityData