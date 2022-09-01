---白日门活动控制器基类
---@class BaiRiMenActControllerBase:luaobject
local BaiRiMenActControllerBase = {}

--[[******************************** 通用属性 *********************************]]
---获取白日门活动管理类
---@return BaiRiMenActivityMgr
function BaiRiMenActControllerBase:GetOwner()
    return self.mOwner
end

---获取代表性的活动表格数据
---@public
---@return TABLE.cfg_bairimen_activity
function BaiRiMenActControllerBase:GetRepresentActivityTbl()
    if self.mRepresentActivityTbl == nil then
        local id = self:GetRepresentActivityID()
        if id ~= 0 and id ~= nil then
            self.mRepresentActivityTbl = clientTableManager.cfg_bairimen_activityManager:TryGetValue(id)
        end
    end
    return self.mRepresentActivityTbl
end

---获取活动的表格数据列表
---@return table<number, TABLE.cfg_bairimen_activity>
function BaiRiMenActControllerBase:GetActivityTables()
    if self.mActivityTbls == nil then
        ---@type table<number, TABLE.cfg_bairimen_activity>
        self.mActivityTbls = {}
        local representTbl = self:GetRepresentActivityTbl()
        if representTbl then
            local subType = representTbl:GetSubtype()
            clientTableManager.cfg_bairimen_activityManager:ForPair(function(id, tblTemp)
                ---@type TABLE.cfg_bairimen_activity
                local tbl = tblTemp
                if tbl:GetSubtype() == subType then
                    table.insert(self.mActivityTbls, tblTemp)
                end
            end)
        end
        ---以id排序
        table.sort(self.mActivityTbls, function(left, right)
            return left:GetOrder() < right:GetOrder()
        end)
    end
    return self.mActivityTbls
end

---获取活动的服务器数据
---@private
---@return activitiesV2.ResSunActivitiesPanel
function BaiRiMenActControllerBase:GetServerData()
    return self.mServerData
end

--[[******************************** 初始化 *********************************]]
---@param owner BaiRiMenActivityMgr
function BaiRiMenActControllerBase:Init(owner)
    self.mOwner = owner
end

--[[******************************* 服务器数据 ****************************************]]
---刷新服务器数据
---@private
---@param tblData activitiesV2.ResSunActivitiesPanel
function BaiRiMenActControllerBase:RefreshServerData(tblData)
    if tblData == nil then
        return
    end
    local oldData = self.mServerData
    self.mServerData = tblData
    self:OnServerDataReceived(self.mServerData, oldData)
    if self:GetRepresentActivityTbl() ~= nil then
        luaEventManager.DoCallback(LuaCEvent.BaiRiMenActivityDataReceived, self:GetRepresentActivityTbl():GetSubtype())
    end
end

---请求服务器数据
---@public
function BaiRiMenActControllerBase:RequestServerData()
    if self:GetRepresentActivityTbl() == nil then
        return
    end
    self:GetOwner():RequestActivityServerData(self:GetRepresentActivityTbl():GetActivityId())
end

--[[******************************* 活动开启/关闭状态 ****************************************]]
---返回活动是否显示给玩家(即白日门活动中对应页签是否有效),如果返回false,则返回导致未开启的conditionType或者nil和conditionID或nil
---@return boolean, number|nil, number|nil 活动是否显示给玩家 导致未开启的conditionType 导致未开启的conditionID
function BaiRiMenActControllerBase:IsActivityShowToPlayer()
    local activityTbl = self:GetRepresentActivityTbl()
    if activityTbl == nil then
        return false
    end
    local openConditions = activityTbl:GetOpenCondition()
    if openConditions == nil or openConditions.list == nil or #openConditions.list == 0 then
        return true
    end
    local isOpenActivity, openConditionType, openConditionId = self:CheckConditions(openConditions.list)
    local isShowActivity, conditionType, conditionId = self:IsActivityBookMarkOpen()--页签开启的条件不返回
    local allShow = isOpenActivity and isShowActivity
    return allShow, openConditionType, openConditionId
end

---返回活动页签是否显示(,如果返回false,则返回导致页签不显示的conditionType或者nil和conditionID或nil
---@return boolean, number|nil, number|nil 活动页签是否显示 导致未开启的conditionType 导致未开启的conditionID
function BaiRiMenActControllerBase:IsActivityBookMarkOpen()
    local activityTbl = self:GetRepresentActivityTbl()
    if activityTbl == nil then
        return false
    end
    local showConditions = activityTbl:GetShowCondition()
    if showConditions == nil or showConditions.list == nil or #showConditions.list == 0 then
        return true
    end
    return self:CheckConditions(showConditions.list)
end

---是否忽略星期几的检查,在刷新活动的开启时间段时发挥作用,决定是否忽略检查DailyActivityTime表中的weekday,默认不忽略
---@return boolean|nil
function BaiRiMenActControllerBase:IsIgnoreWeekDayCheck()
    return nil
end

---检查condition列表(lua中)
---@alias conditionID number
---@param conditions table<number, conditionID>
---@return boolean, number|nil, number|nil condition是否成立 导致不成立的conditionType 导致不成立的conditionID
function BaiRiMenActControllerBase:CheckConditions(conditions)
    if conditions == nil then
        return true
    end
    if type(conditions) ~= "table" then
        return false
    end
    local conditionMgr = CS.Cfg_ConditionManager.Instance
    if conditionMgr == nil then
        return false
    end
    for i = 1, #conditions do
        local conditionID = conditions[i]
        if conditionMgr:IsMainPlayerMatchCondition(conditionID) == false then
            ---@type TABLE.CFG_CONDITIONS
            local conditionTblExist, conditionTbl = conditionMgr:TryGetValue(conditionID)
            if conditionTbl then
                return false, conditionTbl.conditionType, conditionID
            else
                return false
            end
        end
    end
    return true
end

---返回当前活动是否处于开启时间内,如果活动不显示给玩家则默认返回false
---@return boolean
function BaiRiMenActControllerBase:IsActivityOpenedNow()
    return self.mIsActivityOnOpenTime == true
end

---设置活动是否在开启时间内
---@private
---@param isInOpenTime boolean
function BaiRiMenActControllerBase:SetActivityInOpenTimeState(isInOpenTime)
    isInOpenTime = isInOpenTime == true
    if self.mIsActivityOnOpenTime == isInOpenTime then
        return
    end
    local oldOpened = self:IsActivityOpenedNow()
    self.mIsActivityOnOpenTime = isInOpenTime
    local currentOpened = self:IsActivityOpenedNow()
    if oldOpened == currentOpened then
        return
    end
    if currentOpened then
        ---如果活动进入开启时间且满足开启条件,则向服务器请求一次数据
        self:RequestServerData()
    end
    ---触发一次活动在开启时间内状态变化的事件
    self:OnActivityInOpenTimeStateChanged()
    ---发送这个事件
    if self:GetRepresentActivityTbl() ~= nil then
        luaEventManager.DoCallback(LuaCEvent.BaiRiMenActivityInOpenTimeStateChanged, self:GetRepresentActivityTbl():GetSubtype())
    end
end

--[[******************************** 可重写属性/方法 *********************************]]
---获取代表性的活动ID,同类型活动有多个活动表数据时任选一个填入
---@overload
---@return number
function BaiRiMenActControllerBase:GetRepresentActivityID()
    return 0
end

---初始化
---@overload
---@protected
function BaiRiMenActControllerBase:Initialize()

end

---活动处于开启时间内状态变化事件
---@overload
---@protected
function BaiRiMenActControllerBase:OnActivityInOpenTimeStateChanged()

end

---帧刷新,只有活动开启时间内才执行,用于计时/延时等低开销代码,不要在这里写高开销代码,否则后果自负
---@overload
---@protected
function BaiRiMenActControllerBase:OnUpdate()

end

---接收到活动的服务器数据事件,服务器数据从self:GetServerData()中获取
---@overload
---@protected
---@param currentData activitiesV2.ResSunActivitiesPanel 最新的服务器数据
---@param oldData activitiesV2.ResSunActivitiesPanel|nil 旧服务器数据
function BaiRiMenActControllerBase:OnServerDataReceived(currentData, oldData)

end

---销毁事件
---@overload
---@protected
function BaiRiMenActControllerBase:OnDestroy()

end

--[[******************************** 红点 *********************************]]
---获取白日门活动红点key
---@public
---@return number 白日门名+白日门活动表id
function BaiRiMenActControllerBase:GetBaiRiMenRedPointKey()
    if self:GetRepresentActivityTbl() == nil then
        return
    end
    return LuaRedPointName.BaiRiMenActivity_MainPanelRedPoint .. tostring(self:GetRepresentActivityTbl().id)
end

---是否绑定红点
---@public
---@return boolean
function BaiRiMenActControllerBase:BindRedPoint()
    return true
end

---红点回调触发
---@return boolean 红点状态
function BaiRiMenActControllerBase:RedPointCallBack()
    if self:RedPointIsClick() == true or self:GetRepresentActivityTbl() == nil or self:GetRepresentActivityTbl():GetRedPoint() == nil or self:IsActivityOpenedNow() == false then
        return false
    end
    local conditionIdList = self:GetRepresentActivityTbl():GetRedPoint().list
    local conditionResult = Utility.IsMainPlayerMatchConditionList_AND(conditionIdList)
    return conditionResult ~= nil and conditionResult.success
end

---红点是否点击过
---@return boolean
function BaiRiMenActControllerBase:RedPointIsClick()
    return self.isClickRedPoint == true
end

---设置红点点击状态
---@param state boolean
function BaiRiMenActControllerBase:SetRedPointClickState(state)
    if type(state) ~= 'boolean' then
        return
    end
    self.isClickRedPoint = state
end

---触发红点刷新
function BaiRiMenActControllerBase:CallRedPoint()
    gameMgr:GetLuaRedPointManager():CallRedPointKey(self:GetBaiRiMenRedPointKey())
end

function BaiRiMenActControllerBase:OnDestroy()
    self.isClickRedPoint = nil
end

return BaiRiMenActControllerBase