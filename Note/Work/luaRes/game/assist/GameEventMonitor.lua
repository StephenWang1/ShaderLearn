---游戏事件监听,监听并上传绑定数量超出预测数量的事件ID
---@class GameEventMonitor
local GameEventMonitor = {}

---@class EventMonitorType
GameEventMonitor.EventMonitorType = {
    ---C#的客户端事件
    Event = 1,
    ---C#的服务器事件
    Socket = 2,
    ---lua的客户端事件
    LuaEvent = 3,
    ---lua的服务器事件
    LuaNetMsg = 4
}

---C#客户端事件绑定限制数量
local eventBindLimitCount = 30
---C#服务器事件绑定限制数量
local socketBindLimitCount = 30
---Lua客户端事件绑定限制数量
local luaEventBindLimitCount = 30
---Lua网络事件绑定限制数量
local luaNetMsgBindLimitCount = 30

---初始化
---@private
function GameEventMonitor:Initialize()
    ---绑定C#客户端事件
    CS.EventHandlerManager.EventDispather.callbackBindWarningMaxCount = eventBindLimitCount
    CS.EventHandlerManager.EventDispather.callbackBindWarningCallBack = function(id, count)
        self:OnWarningReceived(self.EventMonitorType.Event, id, count)
    end
    ---绑定C#服务器事件
    CS.EventHandlerManager.SocketDispather.callbackBindWarningMaxCount = socketBindLimitCount
    CS.EventHandlerManager.SocketDispather.callbackBindWarningCallBack = function(id, count)
        self:OnWarningReceived(self.EventMonitorType.Socket, id, count)
    end
    ---绑定lua网络事件
    commonNetMsgDeal.BindWarningCountLimit = luaNetMsgBindLimitCount
    commonNetMsgDeal.BindWarningCallBack = function(id, count)
        self:OnWarningReceived(self.EventMonitorType.LuaNetMsg, id, count)
    end
    ---绑定lua客户端事件
    luaEventManager.BindWarningCountLimit = luaEventBindLimitCount
    luaEventManager.BindWarningCallBack = function(id, count)
        self:OnWarningReceived(self.EventMonitorType.LuaEvent, id, count)
    end
end

---警告接收事件
---@param monitorType EventMonitorType
function GameEventMonitor:OnWarningReceived(monitorType, id, count)
    local msgContent = "[GameEventBindMonitor](游戏事件绑定数量超出预测,请通知程序):"
    if monitorType == GameEventMonitor.EventMonitorType.Event then
        msgContent = msgContent .. "Event id:" .. tostring(id) .. " count:" .. tostring(count)
    elseif monitorType == GameEventMonitor.EventMonitorType.Socket then
        msgContent = msgContent .. "Socket id:" .. tostring(id) .. " count:" .. tostring(count)
    elseif monitorType == GameEventMonitor.EventMonitorType.LuaEvent then
        msgContent = msgContent .. "LuaEvent id:" .. tostring(id) .. " count:" .. tostring(count)
    elseif monitorType == GameEventMonitor.EventMonitorType.LuaNetMsg then
        msgContent = msgContent .. "LuaNetMsg id:" .. tostring(id) .. " count:" .. tostring(count)
    else
        msgContent = msgContent .. "Unknown id:" .. tostring(id) .. " count:" .. tostring(count)
    end
    if CS.GameDataSubmit.Instance ~= nil then
        CS.UnityEngine.Debug.LogError(msgContent)
    end
end

return GameEventMonitor