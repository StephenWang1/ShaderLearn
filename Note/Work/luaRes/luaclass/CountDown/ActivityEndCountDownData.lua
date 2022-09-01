---@class ActivityEndCountDownData:luaobject 活动结束倒计时数据类
local ActivityEndCountDownData = {}

--region 数据
---@type table<LuaEnumCountDownEndType,CountDownEndPackage> 待推送倒计时结束包列表
ActivityEndCountDownData.CountDownEndPackageTable = nil
--endregion

--region 数据刷新
---载入一个倒计时包
---@param countDownType LuaEnumCountDownEndType
---@param tblData table
function ActivityEndCountDownData:PushCountDown(countDownType,tblData)
    if countDownType == LuaEnumCountDownEndType.DarkPalaceActivityEnd then
        local countDownEndPackage = luaclass.CountDownEndPackage:New()
        countDownEndPackage:AnalysisKickOutTime(countDownType,tblData)
        if self.CountDownEndPackageTable == nil then
            self.CountDownEndPackageTable = {}
        end
        if countDownEndPackage.AnalysisState then
            self.CountDownEndPackageTable[countDownType] = countDownEndPackage
        end
        self:TryOpenUpdateRefresh()
    end
end

---尝试开启Update刷新
function ActivityEndCountDownData:TryOpenUpdateRefresh()
    if self.delayRefresh ~= nil then
        return
    end
    self.delayRefresh = CS.CSListUpdateMgr.Add(200,nil,function()
        self:CheckAndPushCountDownEndPackage()
    end,true)
end

---关闭Update刷新
function ActivityEndCountDownData:CloseUpdateRefresh()
    if self.delayRefresh ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.delayRefresh)
    end
    self.delayRefresh = nil
end

---检测推送倒计时结束包
function ActivityEndCountDownData:CheckAndPushCountDownEndPackage()
    if type(self.CountDownEndPackageTable) ~= 'table' then
        return
    end
    local haveDataChange = false
    for k,v in pairs(self.CountDownEndPackageTable) do
        ---@type CountDownEndPackage
        local package = v
        if package:CanPushHintCountDown() == true then
            haveDataChange = true
            package:SetPushHintState(true)
        end
        if package.AnalysisState == false or package:IsObsoletePackage() == true then
            haveDataChange = true
            self.CountDownEndPackageTable[k] = nil
        end
    end
    if haveDataChange == true then
        luaEventManager.DoCallback(LuaCEvent.ActivityEndCountDownOpen)
    end
end
--endregion

--region 获取
---获取需要提示的倒计时包列表
---@return table<CountDownEndPackage>
function ActivityEndCountDownData:GetHintCountDownPackageList()
    local mHintCountDownPackageList = {}
    if self.CountDownEndPackageTable == nil then
        return mHintCountDownPackageList
    end
    for k,v in pairs(self.CountDownEndPackageTable) do
        ---@type CountDownEndPackage
        local countDownEndPackage = v
        if countDownEndPackage:IsObsoletePackage() == false then
            table.insert(mHintCountDownPackageList,countDownEndPackage)
        end
    end
    return mHintCountDownPackageList
end
--endregion

--region 查询
---查询是否有对应id的倒计时提示
---@param TimeClockId number 倒计时表
---@return boolean
function ActivityEndCountDownData:CheckHaveHintTimeClock(TimeClockId)
    if type(self.CountDownEndPackageTable) ~= 'table' then
        return false
    end
    for k,v in pairs(self.CountDownEndPackageTable) do
        ---@type CountDownEndPackage
        local countDownEndPackage = v
        if countDownEndPackage.TimeClockId == TimeClockId then
            return true
        end
    end
    return false
end
--endregion

---游戏场景退回到登录/选角界面时触发
function ActivityEndCountDownData:OnExitDestroy()
    self.CountDownEndPackageTable = {}
    self:CloseUpdateRefresh()
end
return ActivityEndCountDownData