---@class LuaSystemInfo 系统开启信息
local LuaSystemInfo = {}

---检测功能是否开启
---@return boolean
function LuaSystemInfo:CheckSystemOpenState(id)
    return CS.CSSystemController.Sington:CheckSystem(id)
end

---客户端功能开启添加
function LuaSystemInfo:AddClientSystem(id)
    if self:CheckNeedAddClientSystem(id) then
        if CS.CSSystemController.Sington:AddClientOpenSystem(id) then
            luaEventManager.DoCallback(LuaCEvent.RefreshSystemGrid)
        end

    end
end

---客户端功能开启移除
function LuaSystemInfo:RemoveClientSystem(id)
    if CS.CSSystemController.Sington:RemoveClientOpenSystem(id) then
        luaEventManager.DoCallback(LuaCEvent.RefreshSystemGrid)
    end
end

---是否需要添加此id的客户端系统
---@return boolean
function LuaSystemInfo:CheckNeedAddClientSystem(id)
    return true
end

--endregion

return LuaSystemInfo