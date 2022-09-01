---@class LuaGhostShipMgr 鉴定管理类
local LuaGhostShipMgr = {}

---检查是否可以进入
function LuaGhostShipMgr:GetState()
    if self.state == nil then
        return false
    end
    return self.state
end

---储存开启状态
function LuaGhostShipMgr:SetState(state)
    self.state = state
end

---存储击杀数量
function LuaGhostShipMgr:SetKillState(num)
    self.killNum = num
end

---存储协助击杀数量
function LuaGhostShipMgr:SetHelpState(num)
    self.helpNum = num
    luaEventManager.DoCallback(LuaCEvent.MonsterKillRemain)
end

---获取剩余数量
function LuaGhostShipMgr:GetRemainNum()
    if self.helpNum == nil then
        self.helpNum = 0
    end
    if self.killNum == nil then
        self.killNum = 0
    end
    return self.killNum, self.helpNum
end

---获取是否有怪物归属
function LuaGhostShipMgr:GetIsTarget()
    if self.target == nil then
        self.target = false
    end
    return self.target
end

---储存怪物归属状态
function LuaGhostShipMgr:SetIsTarget(target)
    self.target = target
    luaEventManager.DoCallback(LuaCEvent.TargetStateChange)
end

---获取是否可以再次请求
function LuaGhostShipMgr:GetTimer()
    if self.time == nil then
        self.time = true
    end
    local remainTime = 0
    if self.time == false then
        remainTime = self.untilTime - gameMgr:GetLuaTimeMgr():GetServerNowTimeStamp()
        if remainTime <= 0 then
            self.time = true
        end
    end
    return self.time, math.ceil(remainTime / 1000)
end

---设置时间
function LuaGhostShipMgr:SetTime()
    local globalTbl = (LuaGlobalTableDeal.GetGlobalTabl(23060)).value
    if globalTbl == nil then
        return
    end
    local info = string.Split(globalTbl, "#")
    self.time = false
    self.untilTime = gameMgr:GetLuaTimeMgr():GetServerNowTimeStamp() + tonumber(info[3])
end

---检查跳转地图是否为幽灵船
function LuaGhostShipMgr:CheckMap()
    local mapId = CS.CSScene.MainPlayerInfo.MapID
    local mapInfo = (LuaGlobalTableDeal.GetGlobalTabl(23051)).value
    local mapData = string.Split(mapInfo, "&")
    for i = 1, #mapData do
        local map = string.Split(mapData[i], "#")
        if mapId == tonumber(map[1]) then
            return mapId
        end
    end
    return nil
end

---开始倒计时
function LuaGhostShipMgr:StartCount(time)
    self.curCount = gameMgr:GetLuaTimeMgr():GetServerNowTimeStamp()
    self.count = time
    luaEventManager.DoCallback(LuaCEvent.GhostShipTime, time)
end

---获取时间

function LuaGhostShipMgr:GetCount()
    if self.curCount == nil then
        return nil
    end
    local remain = self.count - (gameMgr:GetLuaTimeMgr():GetServerNowTimeStamp() - self.curCount)
    return remain
end

---存储正在攻击的怪物ID
function LuaGhostShipMgr:SetMonsterId(monsterId)
    self.monsterId = monsterId
end

---获取正在攻击的怪物ID
function LuaGhostShipMgr:GetMonsterId()
    return self.monsterId
end

return LuaGhostShipMgr