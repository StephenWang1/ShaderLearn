---@class MythBossDataInfo 神级boss数据类
local MythBossDataInfo = {}

--region 数据
---@type number 服务器下次刷新时间
MythBossDataInfo.serverNextRefreshTime = nil
---@type number 最近进入过的神级boss房间的地图id
MythBossDataInfo.recentlyEnterGodBossRoomMapId = nil
---@type table<mapV2.GodBoss> 所有神级boss房间信息
MythBossDataInfo.GodBossRoomInfo = nil
--endregion

--region 刷新
---刷新神级boss信息
---@param tblData mapV2.ResGodBossInfo 神之boss服务器数据
function MythBossDataInfo:RefreshGodBossInfo(tblData)
    self:ClearData()
    if tblData ~= nil then
        self.serverNextRefreshTime = tblData.time
        self.recentlyEnterGodBossRoomMapId = tblData.enterMapId
        self.GodBossRoomInfo = tblData.boss
    end
    gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.Boss_God)
end

---数据清理
function MythBossDataInfo:ClearData()
    self.serverNextRefreshTime = nil
    self.recentlyEnterGodBossRoomMapId = nil
    self.GodBossRoomInfo = nil
    uiStaticParameter.GodBossRedPointLock = false
end
--endregion

--region 红点
---获取神级boss红点状态
function MythBossDataInfo:GetGodBossRedPointState()
    ---红点锁如果开着就不显示红点
    if uiStaticParameter.GodBossRedPointLock == true then
        return false
    end
    ---主角是否有权利杀死boss
    if clientTableManager.cfg_bossManager:BossMapCanMeet(1007) == false then
        return false
    end
    ---如果神级boss没有刷新，则没有红点
    if self:GodBossRoomHaveMonster() == false then
        return false
    end
    ---没有进入过神级boss房间显示红点
    if self.recentlyEnterGodBossRoomMapId == nil or self.recentlyEnterGodBossRoomMapId <= 0 then
        return true
    end
    ---查看最近进入的神级boss房间的boss是否存活
    if self.GodBossRoomInfo ~= nil and type(self.GodBossRoomInfo) == 'table' then
        for k,v in pairs(self.GodBossRoomInfo) do
            if v ~= nil and v.mapId ~= nil and v.mapId == self.recentlyEnterGodBossRoomMapId then
                return v.monsterLid ~= nil and type(v.monsterLid) == 'number' and v.monsterLid > 0
            end
        end
    end
    return false
end

---尝试关闭神级boss红点
function MythBossDataInfo:TryCloseGodBossRedPoint()
    if gameMgr:GetLuaRedPointManager():GetRedPointState(LuaRedPointName.Boss_God) == true then
        uiStaticParameter.GodBossRedPointLock = true
        gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.Boss_God)
    end
end

---尝试开启神级boss红点
function MythBossDataInfo:TryOpenGodBossRedPoint()
    if uiStaticParameter.GodBossRedPointLock == true then
        uiStaticParameter.GodBossRedPointLock = false
        gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.Boss_God)
    end
end
--endregion

--region 查询
---查询玩家是否可以进入地图
---@return 是否可以进入地图
function MythBossDataInfo:CheckMainPlayerCanEnterMap(mapId)
    if self.recentlyEnterGodBossRoomMapId == nil or self.recentlyEnterGodBossRoomMapId <= 0 then
        return true
    end
    return self.recentlyEnterGodBossRoomMapId == mapId
end

---神级boss房间是否有怪
---@return boolean 是否有怪
function MythBossDataInfo:GodBossRoomHaveMonster()
    if self.GodBossRoomInfo == nil or type(self.GodBossRoomInfo) ~= 'table' then
        return false
    end
    for k,v in pairs(self.GodBossRoomInfo) do
        if v ~= nil and v.monsterLid ~= nil and type(v.monsterLid) == 'number' and v.monsterLid > 0 then
            return true
        end
    end
    return false
end
--endregion

--region 获取
---获取刷新时间文本描述
---@return string 开始时间时间戳
function MythBossDataInfo:GetRefreshTimeDes()
    local nextRefreshTimeStamp = self.serverNextRefreshTime
    if nextRefreshTimeStamp == nil then
        nextRefreshTimeStamp = self:GetClientRefreshTime() * 1000
    end
    if nextRefreshTimeStamp ~= nil then
        local dateTime = Utility.GetDateTimeByMillisecond(nextRefreshTimeStamp)
        local nowDateTime = Utility.GetDateTimeByMillisecond(CS.CSScene.MainPlayerInfo.serverTime)
        local differentMonth = dateTime.Month - nowDateTime.Month
        local differentDay = dateTime.Day - nowDateTime.Day
        if differentDay ~= nil and differentMonth ~= nil then
            if differentMonth > 1 or differentDay > 1 then
                return ""
            elseif differentMonth == 1 or differentDay == 1 then
                return "明日" .. CS.Utility_Lua.NumberDesLeftAddZero(tostring(dateTime.Hour),2)  .. ":" ..CS.Utility_Lua.NumberDesLeftAddZero(tostring(dateTime.Minute),2)
            else
                return "今日" ..  CS.Utility_Lua.NumberDesLeftAddZero(tostring(dateTime.Hour),2)  .. ":" ..CS.Utility_Lua.NumberDesLeftAddZero(tostring(dateTime.Minute),2)
            end
        end
        return ""
    end
end

---获得客户端刷新时间
---@return number 下次刷新的时间戳
function MythBossDataInfo:GetClientRefreshTime()
    local clientActivityTimeIdList = LuaGlobalTableDeal:GetGodBossActivityTimeIdList()
    if clientActivityTimeIdList == nil then
        return
    end
    ---@type number 最小的时间/单位分钟
    local minTime = 0
    ---@type number 下次刷新时间/单位分钟
    local nextTime = 24 * 60
    ---@type System.DateTime
    local nowDateTime = Utility.GetDateTimeByMillisecond(CS.CSScene.MainPlayerInfo.serverTime)
    ---@type number 当前时间分钟总和
    local nowTotalMinuteTime = nowDateTime.Hour * 60 + nowDateTime.Minute
    if nowTotalMinuteTime < 0 then
        return
    end
    for k,v in pairs(clientActivityTimeIdList) do
        local activityTimeId = v
        local activityTimeTableIsFind,activityTimeTable = CS.Cfg_DailyActivityTimeTableManager.Instance:TryGetValue(activityTimeId)
        if activityTimeTableIsFind then
            if minTime == 0 or activityTimeTable.startTime < minTime then
                minTime = activityTimeTable.startTime
            end
            if nowTotalMinuteTime <= activityTimeTable.startTime and activityTimeTable.startTime < nextTime then
                nextTime = activityTimeTable.startTime
            end
        end
    end
    ---如果没有今天的刷新时间，则返回明天最早的刷新时间
    if nextTime == 24 * 60 then
        local hour = Utility.GetIntPart(minTime / 60)
        local minute = minTime - hour * 60
        local nowTimeStamp = Utility.GetMillisecondByYearTime(nowDateTime.Year,nowDateTime.Month,nowDateTime.Day,hour,minute,0)
        ---第二天时间
        return nowTimeStamp + (24 * 60 * 60)
    end
    ---今天的刷新时间
    local hour = Utility.GetIntPart(nextTime / 60)
    local minute = nextTime - hour * 60
    return Utility.GetMillisecondByYearTime(nowDateTime.Year,nowDateTime.Month,nowDateTime.Day,hour,minute,0)
end
--endregion

---游戏场景退回到登录/选角界面时触发
function MythBossDataInfo:OnExitDestroy()
    self:ClearData()
end

return MythBossDataInfo