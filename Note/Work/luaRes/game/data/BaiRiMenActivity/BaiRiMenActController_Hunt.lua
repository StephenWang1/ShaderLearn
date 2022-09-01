---@class BaiRiMenActController_Hunt:BaiRiMenActControllerBase 白日门猎魔
local BaiRiMenActController_Hunt = {}

setmetatable(BaiRiMenActController_Hunt, luaclass.BaiRiMenActControllerBase)

function BaiRiMenActController_Hunt:GetRepresentActivityID()
    return 30001
end

function BaiRiMenActController_Hunt:IsIgnoreWeekDayCheck()
    local activityTbl = self:GetRepresentActivityTbl()
    if activityTbl == nil then
        return
    end
    ---白日门猎魔活动由于服务器框架底层的一些问题,服务器那边一定会在openCondition的生效那天开启,所以客户端这边在这一天需要规避掉对
    ---本活动开启时间的星期几的判定
    local openConditions = activityTbl:GetOpenCondition()
    if openConditions ~= nil and openConditions.list and #openConditions.list > 0 then
        local conditionIDTemp = openConditions.list[1]
        local conditionTblTemp = clientTableManager.cfg_conditionsManager:TryGetValue(conditionIDTemp)
        if conditionTblTemp and conditionTblTemp:GetConditionType() == 8 then
            if conditionTblTemp:GetConditionParam() ~= nil and conditionTblTemp:GetConditionParam().list ~= nil
                    and conditionTblTemp:GetConditionParam().list.Count > 0 then
                local configedOpenServerDay = conditionTblTemp:GetConditionParam().list[0]
                local realOpenServerDay = gameMgr:GetLuaTimeMgr():GetOpenServerDay()
                return realOpenServerDay == configedOpenServerDay
            end
        end
    end
end

--region 数据

---接收到活动的服务器数据事件,服务器数据从self:GetServerData()中获取
---@private
---@param currentData activitiesV2.ResSunActivitiesPanel 最新的服务器数据
---@param oldData activitiesV2.ResSunActivitiesPanel|nil 旧服务器数据
function BaiRiMenActController_Hunt:OnServerDataReceived(currentData, oldData)
    self.mHuntBossData = currentData.info
    self.mCurKillNum = #currentData.availNum == 0 and 0 or currentData.availNum[1]
    self.mCurLastingStamina = currentData.dayDoorPhysical
end

--endregion

function BaiRiMenActController_Hunt:Initialize()
    self:RefreshBossBornInMap()
end

function BaiRiMenActController_Hunt:OnActivityInOpenTimeStateChanged()
    self:RefreshBossBornInMap()
end

---获取boss信息
---@private
---@return table<number, {bossID:number, x:number, y:number}>
function BaiRiMenActController_Hunt:GetBossInfos()
    if self.mBossInfos == nil then
        if CS.Cfg_GlobalTableManager.Instance then
            local tblExist, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22767)
            if tbl then
                ---@type table<number, {bossID:number, x:number, y:number}>
                self.mBossInfos = {}
                local strs1 = string.Split(tbl.value, '&')
                for i = 1, #strs1 do
                    local strs2 = string.Split(strs1[i], '#')
                    if #strs2 >= 3 then
                        local bossID = tonumber(strs2[1])
                        local x = tonumber(strs2[2])
                        local y = tonumber(strs2[3])
                        if bossID ~= nil and x ~= nil and y ~= nil then
                            table.insert(self.mBossInfos, { bossID = bossID, x = x, y = y })
                        end
                    end
                end
            end
        end
    end
    return self.mBossInfos
end

---刷新小地图上的boss出生点
---@private
function BaiRiMenActController_Hunt:RefreshBossBornInMap()
    local mHurtBossLayer = CS.UIMiniMapController.GetExtraPointLayer(LuaEnumMiniMapExtraDepth.BrmActHuntBoss, LuaEnumMiniMapExtraType.BossMapOnly)
    if self:IsActivityOpenedNow() and self:GetBossInfos() ~= nil then
        for i = 1, #self:GetBossInfos() do
            local temp = self:GetBossInfos()[i]
            local bossID = temp.bossID
            local monsterTbl = clientTableManager.cfg_monstersManager:TryGetValue(bossID)
            if monsterTbl then
                mHurtBossLayer:AddPoint(1006, true, temp.x, temp.y, "bossbron", Utility.CombineStringQuickly("[FF0000]", monsterTbl:GetName()))
            end
        end
    else
        mHurtBossLayer:RemoveAllPoints()
    end
end

--region 获取

function BaiRiMenActController_Hunt:GetShowBossClientData()
    if self.mHuntBossData == nil then
        self.mHuntBossData = {}
    end
    return self.mHuntBossData
end

function BaiRiMenActController_Hunt:GetCurKillNum()
    if self.mCurKillNum == nil then
        self.mCurKillNum = 0
    end
    return self.mCurKillNum
end

---获取当前剩余体力值
---@return number
function BaiRiMenActController_Hunt:GetCurLastingStamina()
    if self.mCurLastingStamina == nil then
        self.mCurLastingStamina = 0
    end
    return self.mCurLastingStamina
end

---得到默认白日门猎魔活动表
function BaiRiMenActController_Hunt:GetDefaultBairimen_activityTable()
    if self.mDefaulBairimen_activityTable == nil then
        self.mDefaulBairimen_activityTable = clientTableManager.cfg_bairimen_activityManager:TryGetValue(self:GetRepresentActivityID())
    end
    return self.mDefaulBairimen_activityTable
end

---得到白日门猎魔活动时间表
function BaiRiMenActController_Hunt:GetDaily_activity_timeTable()
    if self.mDaily_activity_timeTable == nil and self:GetDefaultBairimen_activityTable() ~= nil then
        local activeID = self:GetDefaultBairimen_activityTable():GetActivityId()
        self.mDaily_activity_timeTable = clientTableManager.cfg_daily_activity_timeManager:TryGetValue(activeID)
    end
    return self.mDaily_activity_timeTable
end

---得到白日门猎魔活动开启时间
function BaiRiMenActController_Hunt:GetActiveOpenTime()
    if self:GetDaily_activity_timeTable() == nil then
        return 0
    end
    return self:GetDaily_activity_timeTable():GetStartTime()
end

---得到白日门猎魔活动结束时间
function BaiRiMenActController_Hunt:GetActiveEndTime()
    if self:GetDaily_activity_timeTable() == nil then
        return 0
    end
    return self:GetDaily_activity_timeTable():GetOverTime()
end

---时间转换成字符串
function BaiRiMenActController_Hunt:TimeChangeStr(Nums)
    local h = math.modf(Nums / 60)
    local m = Nums % 60
    local h_str = tostring(h)
    local m_str = tostring(m)
    if h < 10 then
        h_str = "0" .. tostring(h)
    end
    if m < 10 then
        m_str = "0" .. tostring(m)
    end
    return h_str .. ":" .. m_str
end

--endregion

return BaiRiMenActController_Hunt