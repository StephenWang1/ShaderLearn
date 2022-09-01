---白日门活动管理类
---@class BaiRiMenActivityMgr:luaobject
local BaiRiMenActivityMgr = {}

--region 事件绑定/解绑
---客户端事件绑定
---@return EventHandlerManager
function BaiRiMenActivityMgr:GetClientEventHander()
    return self.mClientEventHandler
end

---lua中的事件绑定
---@return LuaEventHandler
function BaiRiMenActivityMgr:GetLuaEventHandler()
    return self.mLuaEventHandler
end
--endregion

--region 属性
---是否有任何活动在开启中
---@public
---@return boolean
function BaiRiMenActivityMgr:IsAnyActivityEnabled()
    return self.mIsAnyActivityEnabled == true
end
--endregion

--region 活动控制器
---获取所有活动的控制器列表
---@return table<number, BaiRiMenActControllerBase>
function BaiRiMenActivityMgr:GetAllActControllers()
    return self.mActivityControllers or {}
end

---根据bairimenActivity表的subType获取对应活动的控制器
---@param subType
---@return BaiRiMenActControllerBase
function BaiRiMenActivityMgr:GetActControllerBySubType(subType)
    if self.mActivityControllers == nil or subType == nil then
        return nil
    end
    for i = 1, #self.mActivityControllers do
        if self.mActivityControllers[i]:GetRepresentActivityTbl():GetSubtype() == subType then
            return self.mActivityControllers[i]
        end
    end
    return nil
end

---圣物活动控制器
---@return BaiRiMenActController_ShengWu
function BaiRiMenActivityMgr:GetActController_ShengWu()
    if self.mActController_ShengWu == nil then
        self.mActController_ShengWu = luaclass.BaiRiMenActController_ShengWu:New(self)
    end
    return self.mActController_ShengWu
end

---镖车活动控制器
---@return BaiRiMenActController_DartCar
function BaiRiMenActivityMgr:GetActController_DartCar()
    if self.mActController_DartCar == nil then
        self.mActController_DartCar = luaclass.BaiRiMenActController_DartCar:New(self)
    end
    return self.mActController_DartCar
end

---封赏活动控制器
---@return BaiRiMenActController_HuntingRewar
function BaiRiMenActivityMgr:GetActController_HuntingRewar()
    if self.mActController_HuntingRewar == nil then
        self.mActController_HuntingRewar = luaclass.BaiRiMenActController_HuntingRewar:New(self)
    end
    return self.mActController_HuntingRewar
end

---猎魔活动控制器
---@return BaiRiMenActController_Hunt
function BaiRiMenActivityMgr:GetActController_Hunt()
    if self.mActController_Hunt == nil then
        self.mActController_Hunt = luaclass.BaiRiMenActController_Hunt:New(self)
    end
    return self.mActController_Hunt
end

---联服活动控制器
---@return BaiRiMenActController_CrossServerActivity
function BaiRiMenActivityMgr:GetActController_CrossServerActivity()
    if self.mActController_CrossServerActivity == nil then
        self.mActController_CrossServerActivity = luaclass.BaiRiMenActController_CrossServerActivity:New(self)
    end
    return self.mActController_CrossServerActivity
end

---闯天关活动控制器
---@return BaiRiMenActController_ChuangTianGuan
function BaiRiMenActivityMgr:GetActController_ChuangTianGuan()
    if self.mActController_ChuangTianGuan == nil then
        self.mActController_ChuangTianGuan = luaclass.BaiRiMenActController_ChuangTianGuan:New(self)
    end
    return self.mActController_ChuangTianGuan
end

---苍月岛活动控制器
---@return BaiRiMenActController_CangYue
function BaiRiMenActivityMgr:GetActController_CangYue()
    if self.mActController_CangYue == nil then
        self.mActController_CangYue = luaclass.BaiRiMenActController_CangYue:New(self)
    end
    return self.mActController_CangYue
end


--endregion

--region 初始化
---初始化
---@private
function BaiRiMenActivityMgr:Init()
    self.mClientEventHandler = CS.EventHandlerManager(CS.EventHandlerManager.DispatchType.Event)
    self.mLuaEventHandler = eventHandler.CreateNew()
    ---重置活动列表
    ---@type table<number, BaiRiMenActControllerBase>
    self.mActivityControllers = {}
end
--endregion

--region 初始化活动
---初始化所有活动
---@private
function BaiRiMenActivityMgr:InitializeAllActivities()
    if self.mIsAllActivitiesInitialized == true then
        return
    end
    self.mIsAllActivitiesInitialized = true

    ---自行添加活动的实例
    ---圣物活动
    self:AddActivityController(self:GetActController_ShengWu())

    ---自行添加活动的实例
    ---镖车活动
    self:AddActivityController(self:GetActController_DartCar())

    ---自行添加活动的实例
    ---封赏活动
    self:AddActivityController(self:GetActController_HuntingRewar())

    ---自行添加活动的实例
    ---闯天关活动
    self:AddActivityController(self:GetActController_ChuangTianGuan())

    ---自行添加活动的实例
    ---猎魔活动
    self:AddActivityController(self:GetActController_Hunt())

    ---自行添加活动的实例
    ---联服活动
    self:AddActivityController(self:GetActController_CrossServerActivity())

    ---自行添加活动的实例
    ---苍月岛
    self:AddActivityController(self:GetActController_CangYue())

    ---活动控制器排序,按照表数据的order进行排序
    table.sort(self.mActivityControllers, function(left, right)
        if left:IsActivityShowToPlayer() == right:IsActivityShowToPlayer() then
            return left:GetRepresentActivityTbl():GetOrder() < right:GetRepresentActivityTbl():GetOrder()
        else
            return left:IsActivityShowToPlayer()
        end
    end)
end

---向活动列表中加入一个活动实例
---@private
---@param actController BaiRiMenActControllerBase
function BaiRiMenActivityMgr:AddActivityController(actController)
    if actController == nil or actController:GetRepresentActivityTbl() == nil then
        ---规避空表数据的控制器
        return
    end
    for i = 1, #self.mActivityControllers do
        if self.mActivityControllers[i] == actController then
            ---重复添加
            return
        end
        if self.mActivityControllers[i]:GetRepresentActivityID() == actController:GetRepresentActivityID() then
            ---不同的controller的id重复
            CS.UnityEngine.Debug.LogError(Utility.CombineStringQuickly("白日门活动加入了重复的 ActivityID:", actController:GetRepresentActivityID()))
            return
        end
    end
    table.insert(self.mActivityControllers, actController)
end

---激活列表中的活动控制器
---@private
function BaiRiMenActivityMgr:ActivatingActControllers()
    if self.mActivityControllers == nil then
        return
    end
    ---活动控制器初始化
    for i = 1, #self.mActivityControllers do
        local actController = self.mActivityControllers[i]
        actController:Initialize()
    end
end
--endregion

--region 开启时间
---重置开启时间
---@private
function BaiRiMenActivityMgr:ResetOpenTime()
    ---清空一些红点和开启时间相关的数据
    ---是否是第一次,与主界面红点有关
    ---@type boolean
    self.mIsFirstTime = nil
    ---是否有任何活动开启
    ---@type boolean
    self.mIsAnyActivityEnabled = nil
    ---当天显示给玩家的活动的开启时间列表
    ---@type table<LuaEnumBaiRiMenActivityType, table<number, {startTime:number,endTime:number}>>
    self.mActivityEnableStamps = nil

    ---主界面的白日门活动红点
    --local baiRiMenMainPanelRedPoint = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BaiRiMenActivity_MainPanelRedPoint)
    --CS.CSUIRedPointManager.GetInstance():RemoveLuaCallRedPointFunctionByInt(baiRiMenMainPanelRedPoint)
    --CS.CSUIRedPointManager.GetInstance():RegisterLuaCallRedPointFunction(baiRiMenMainPanelRedPoint, function()
    --    return self.mIsFirstTime == nil and self.mIsAnyActivityEnabled
    --end)
    -----绑定白日门活动界面打开事件,白日门活动界面打开后关闭主界面红点
    --if self.mOnPanelOpenedForFirstTime ~= nil then
    --    self:GetClientEventHander():RemoveEvent(CS.CEvent.OpenPanel, self.mOnPanelOpenedForFirstTime)
    --end
    --self.mOnPanelOpenedForFirstTime = function(id, panelName)
    --    if panelName ~= nil and panelName == "UIWhiteSunGatePanel" then
    --        self:GetClientEventHander():RemoveEvent(CS.CEvent.OpenPanel, self.mOnPanelOpenedForFirstTime)
    --        self.mIsFirstTime = false
    --        CS.CSUIRedPointManager.GetInstance():CallRedPoint(baiRiMenMainPanelRedPoint)
    --    end
    --end
    --self:GetClientEventHander():AddEvent(CS.CEvent.OpenPanel, self.mOnPanelOpenedForFirstTime)
end

---刷新活动开启时间区间
---@private
function BaiRiMenActivityMgr:RefreshActivityEnableTimes()
    ---@type table<LuaEnumBaiRiMenActivityType, table<number, {startTime:number,endTime:number}>>
    self.mActivityEnableStamps = {}
    for i = 1, #self.mActivityControllers do
        local actController = self.mActivityControllers[i]
        if actController:IsActivityShowToPlayer() then
            ---只检查开启的活动
            local tblDatas = actController:GetActivityTables()
            local tbl = {}
            ---获取该活动的有效区间
            for j = 1, #tblDatas do
                local startTimeStamp, endTimeStamp = self:GetStartAndEndTimeStampByDailyActivityTimeTbl(tblDatas[j]:GetActivityId(), actController:IsIgnoreWeekDayCheck())
                if startTimeStamp ~= 0 and endTimeStamp ~= 0 then
                    table.insert(tbl, { startTime = startTimeStamp, endTime = endTimeStamp })
                end
            end
            self.mActivityEnableStamps[actController:GetRepresentActivityTbl():GetSubtype()] = tbl
        else
            ---未开启的活动将被设置为不在开启时间内
            actController:SetActivityInOpenTimeState(false)
        end
    end
end

---从dailyActivityTime表中获取今天的开始时间和结束时间的毫秒时间戳
---@param dailyActivityTimeTblID number dailyActivityTime表的ID
---@param isIgnoreWeekday boolean|nil 是否忽略星期几
---@return number, number
function BaiRiMenActivityMgr:GetStartAndEndTimeStampByDailyActivityTimeTbl(dailyActivityTimeTblID, isIgnoreWeekday)
    ---@type TABLE.CFG_DAILY_ACTIVITY_TIME
    local dailyActivityTimeTblExist, dailyActivityTimeTbl = CS.Cfg_DailyActivityTimeTableManager.Instance:TryGetValue(dailyActivityTimeTblID)
    if dailyActivityTimeTbl == nil then
        return 0, 0
    end
    ---使用星期判定今天是否开启
    if isIgnoreWeekday ~= true then
        if dailyActivityTimeTbl.weekday and dailyActivityTimeTbl.weekday.list.Count > 0 then
            ---当前星期天数,0表示星期天,6表示星期六
            local currentDayOfWeek = CS.CSServerTime.DayOfWeek
            ---调整为1-7
            if currentDayOfWeek == 0 then
                currentDayOfWeek = 7
            end
            ---今天是否开启
            local isTodayOpened = false
            for i = 1, dailyActivityTimeTbl.weekday.list.Count do
                if currentDayOfWeek == dailyActivityTimeTbl.weekday.list[i - 1] then
                    isTodayOpened = true
                end
            end
            if isTodayOpened == false then
                return 0, 0
            end
        else
            return 0, 0
        end
    end
    ---当前时间戳(ms)
    local currentTimeStampMS = CS.CSServerTime.Instance.TotalMillisecond
    ---获取今天的零点时间(ms)
    local todayZeroTimeStampMS = (currentTimeStampMS - ((currentTimeStampMS + 28800000) % 86400000))
    return (todayZeroTimeStampMS + dailyActivityTimeTbl.startTime * 60000), (todayZeroTimeStampMS + dailyActivityTimeTbl.overTime * 60000)
end
--endregion

--region 帧刷新
---每帧刷新
---@private
function BaiRiMenActivityMgr:OnUpdate()
    if self.mIsInitialized == nil then
        if CS.CSServerTime.IsServerTimeReceived and CS.CSScene.Sington ~= nil then
            self.mIsInitialized = true
            ---初始化各个活动
            self:InitializeAllActivities()
            ---触发服务器时间同步事件
            self:OnServerTimeSynchronized()
        end
    else
        self:CheckActivityOpenTime()
        if self:IsAnyActivityEnabled() then
            self:DoUpdates()
        end
    end
end

---执行各个开启中的活动的Update
---@private
function BaiRiMenActivityMgr:DoUpdates()
    if self.mActivityControllers == nil then
        return
    end
    for i = 1, #self.mActivityControllers do
        if self.mActivityControllers[i]:IsActivityOpenedNow() then
            self.mActivityControllers[i]:OnUpdate()
        end
    end
end

---检查活动开启时间
---@private
function BaiRiMenActivityMgr:CheckActivityOpenTime()
    if self.mActivityEnableStamps == nil then
        ---等待服务器的第一次心跳包同步服务器时间
        if CS.CSServerTime.IsServerTimeReceived then
            ---刷新各个活动的开启时间区间
            self:RefreshActivityEnableTimes()
            ---刷新一次活动处于开启时间内的状态
            self:RefreshActivityInOpenTimeStates()
        end
    else
        ---如果有任何活动开启的状态变化,那么刷新该红点
        if self:RefreshActivityInOpenTimeStates() then
            ---刷新主界面红点
            --local baiRiMenMainPanelRedPoint = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BaiRiMenActivity_MainPanelRedPoint)
            --CS.CSUIRedPointManager.GetInstance():CallRedPoint(baiRiMenMainPanelRedPoint)
            local baiRiMenActivityInfoList = self:GetAllActControllers()
            if type(baiRiMenActivityInfoList) == 'table' and Utility.GetLuaTableCount(baiRiMenActivityInfoList) > 0 then
                for k,v in pairs(baiRiMenActivityInfoList) do
                    ---@type BaiRiMenActControllerBase
                    local baiRiMenActivity = v
                    if baiRiMenActivity ~= nil and CS.StaticUtility.IsNullOrEmpty(baiRiMenActivity:GetBaiRiMenRedPointKey()) == false then
                        baiRiMenActivity:CallRedPoint()
                    end
                end
            end
        end
    end
end

---刷新活动处于开启时间内的状态
---@private
---@return boolean 是否有变化
function BaiRiMenActivityMgr:RefreshActivityInOpenTimeStates()
    if self.mActivityEnableStamps == nil then
        return false
    end
    if self.mActivityInOpenTimeCache == nil then
        self.mActivityInOpenTimeCache = {}
    end
    ---当前时间戳(ms)
    local currentTimeStampMS = CS.CSServerTime.Instance.TotalMillisecond
    local isAnyActivityEnabled = false
    for i, v in pairs(self.mActivityEnableStamps) do
        local temp = v
        local isActivityInOpenTime = false
        for j = 1, #temp do
            if currentTimeStampMS > temp[j].startTime and currentTimeStampMS < temp[j].endTime then
                ---如果当前时间处于某一个活动子项的时间区间内,则认为该活动处于开启时间内
                isActivityInOpenTime = true
                break
            end
        end
        if isActivityInOpenTime then
            isAnyActivityEnabled = true
        end
        local oldState = self.mActivityInOpenTimeCache[i]
        if oldState ~= isActivityInOpenTime then
            ---如果当前帧的活动处于开启时间内的状态与之前不一致,则刷新活动在开启时间内的状态
            self.mActivityInOpenTimeCache[i] = isActivityInOpenTime
            local actController = self:GetActControllerBySubType(i)
            if actController then
                actController:SetActivityInOpenTimeState(isActivityInOpenTime)
            end
        end
    end
    if self.mIsAnyActivityEnabled ~= isAnyActivityEnabled then
        self.mIsAnyActivityEnabled = isAnyActivityEnabled
        return true
    end
    return false
end
--endregion

--region 事件
---服务器时间同步事件,只触发一次
---@private
function BaiRiMenActivityMgr:OnServerTimeSynchronized()
    ---重置活动开启时间区间相关的各个参数
    self:ResetOpenTime()
    ---检查一次活动开启时间
    self:CheckActivityOpenTime()
    ---服务器时间同步完成后,激活列表中的活动控制器
    self:ActivatingActControllers()
    ---绑定零点事件
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Common_ZeroEvent, function()
        ---零点时重新注册主界面红点
        self:ResetOpenTime()
        ---零点时向服务器请求所有开启了的活动数据,因为开服天数变化了
        self:RequestAllOpenedActivityServerData()
    end)
    ---绑定升级数据,角色升级是请求一次打开了的活动数据
    self:GetClientEventHander():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, function()
        self:RequestAllOpenedActivityServerData()
        self:RefreshActivityEnableTimes()
    end)
    ---绑定活动服务器数据
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSunActivitiesPanelMessage, function(id, tblData)
        self:OnActivityDataReceived(id, tblData)
    end)
    ---向服务器请求所有开启了的活动数据
    self:RequestAllOpenedActivityServerData()
end
--endregion

--region 服务器数据
---向服务器请求所有页签开启了的活动数据
---@public
function BaiRiMenActivityMgr:RequestAllOpenedActivityServerData()
    if self.mActivityControllers == nil then
        return
    end
    for i = 1, #self.mActivityControllers do
        local actController = self.mActivityControllers[i]
        if actController:IsActivityShowToPlayer() then
            self:RequestActivityServerData(actController:GetRepresentActivityTbl():GetActivityId())
        end
    end
end

---向服务器请求活动数据
---@private
---@param activityID number dailyActivityTime表的ID
function BaiRiMenActivityMgr:RequestActivityServerData(activityID)
    if activityID == nil or activityID == 0 then
        return
    end
    --print("Request", activityID)
    networkRequest.ReqSunActivitiesPanel(activityID)
end

---服务器活动消息回调
---@private
---@param tblData activitiesV2.ResSunActivitiesPanel
function BaiRiMenActivityMgr:OnActivityDataReceived(id, tblData)
    if tblData == nil or tblData.activityId == nil then
        return
    end
    --print("Received", tblData.activityId)
    local actControllers = self:GetAllActControllers()
    if actControllers == nil then
        return
    end
    local activityID = tblData.activityId
    ---@type BaiRiMenActControllerBase
    local actController
    for i = 1, #actControllers do
        local activityTbls = actControllers[i]:GetActivityTables()
        for j = 1, #activityTbls do
            if activityTbls[j]:GetActivityId() == activityID then
                actController = actControllers[i]
                break
            end
        end
    end
    if actController == nil then
        return
    end
    actController:RefreshServerData(tblData)
end
--endregion

--region 销毁
---销毁时执行
---@private
function BaiRiMenActivityMgr:OnDestroy()
    if self.mActivityControllers ~= nil then
        for i = 1, #self.mActivityControllers do
            self.mActivityControllers[i]:OnDestroy()
        end
    end
    if self.mClientEventHandler ~= nil then
        self.mClientEventHandler:UnRegAll()
    end
    if self.mLuaEventHandler ~= nil then
        self.mLuaEventHandler:ReleaseAll()
    end
    local baiRiMenMainPanelRedPoint = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BaiRiMenActivity_MainPanelRedPoint)
    CS.CSUIRedPointManager.GetInstance():RemoveLuaCallRedPointFunctionByInt(baiRiMenMainPanelRedPoint)
end
--endregion

return BaiRiMenActivityMgr