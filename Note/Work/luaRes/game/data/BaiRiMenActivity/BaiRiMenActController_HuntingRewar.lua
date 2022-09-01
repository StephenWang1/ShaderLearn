---白日门封魔活动 调用示例   gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_HuntingRewar()
---@class BaiRiMenActController_HuntingRewar:BaiRiMenActControllerBase
local BaiRiMenActController_HuntingRewar = {}

setmetatable(BaiRiMenActController_HuntingRewar, luaclass.BaiRiMenActControllerBase)

function BaiRiMenActController_HuntingRewar:GetRepresentActivityID()
    return 20001
end

---得到默认白日门封赏活动表
function BaiRiMenActController_HuntingRewar:GetDefaultBairimen_activityTable()
    if self.mDefaulBairimen_activityTable == nil then
        self.mDefaulBairimen_activityTable = clientTableManager.cfg_bairimen_activityManager:TryGetValue(self:GetRepresentActivityID())
    end
    return self.mDefaulBairimen_activityTable
end

---通过monsterID获取表数据
function BaiRiMenActController_HuntingRewar:GetMonsterIDbyTable(monsterID)
    return clientTableManager.cfg_bairimen_activityManager:GetMonsterIDbyTable(monsterID, 2)
end

---得到白日门封赏活动时间表
function BaiRiMenActController_HuntingRewar:GetDaily_activity_timeTable()
    if self.mDaily_activity_timeTable == nil and self:GetDefaultBairimen_activityTable() ~= nil then
        local activeID = self:GetDefaultBairimen_activityTable():GetActivityId()
        self.mDaily_activity_timeTable = clientTableManager.cfg_daily_activity_timeManager:TryGetValue(activeID)
    end
    return self.mDaily_activity_timeTable
end

---得到白日门封赏活动开启时间
function BaiRiMenActController_HuntingRewar:GetActiveOpenTime()
    if self:GetDaily_activity_timeTable() == nil then
        return 0
    end
    return self:GetDaily_activity_timeTable():GetStartTime()
end

---得到白日门封赏活动结束时间
function BaiRiMenActController_HuntingRewar:GetActiveEndTime()
    if self:GetDaily_activity_timeTable() == nil then
        return 0
    end
    return self:GetDaily_activity_timeTable():GetOverTime()
end

---活動是否开启
function BaiRiMenActController_HuntingRewar:IsActiveOpen()
    local nowM = gameMgr:GetLuaTimeMgr():GetNowMinuteTime()
    if self:GetActiveOpenTime() < nowM and self:GetActiveEndTime() > nowM then
        return true
    end
    return false
end

---时间转换成字符串
function BaiRiMenActController_HuntingRewar:TimeChangeStr(Nums)
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

---得到白日门封赏活动可用次数
function BaiRiMenActController_HuntingRewar:GetAvailableNumber()
    if self:GetServerData() == nil or self:GetServerData().availNum == nil or #self:GetServerData().availNum == 0 then
        return 0
    end
    return self:GetServerData().availNum[1]
end

---获取当前剩余体力值
---@return number
function BaiRiMenActController_HuntingRewar:GetCurLastingStamina()
    if self:GetServerData() == nil or self:GetServerData().dayDoorPhysical == nil then
        return 0
    end
    return self:GetServerData().dayDoorPhysical
end

---得到活动最大次数
function BaiRiMenActController_HuntingRewar:GetMaxNumber()
    if self.mActiveMaxNumber == nil then
        local temp = LuaGlobalTableDeal.GetGlobalTabl(22768)
        if temp == nil then
            return 0
        end
        local tempstr = string.Split(temp.value, '#')
        if #tempstr >= 3 then
            self.mActiveMaxNumber = tonumber(tempstr[3])
        end
    end
    if self.mActiveMaxNumber == nil then
        return 0
    end
    return self.mActiveMaxNumber
end

---得到白日门封赏活动怪物信息
function BaiRiMenActController_HuntingRewar:GetServerDataInfoList()
    if self:GetServerData() == nil or self:GetServerData().info == nil then
        return nil
    end
    return self:GetServerData().info
end

---白日门封赏是否达到等级
function BaiRiMenActController_HuntingRewar:IsMeetLimitLevel()
    if CS.CSScene.MainPlayerInfo.Level>=70 then
        return true
    end
    return false
end


return BaiRiMenActController_HuntingRewar