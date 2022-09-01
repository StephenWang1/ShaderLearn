--[[本文件为工具自动生成,禁止手动修改]]
local fcmV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable fcmV2.ResAuthorityState
---@type fcmV2.ResAuthorityState
fcmV2_adj.metatable_ResAuthorityState = {
    _ClassName = "fcmV2.ResAuthorityState",
}
fcmV2_adj.metatable_ResAuthorityState.__index = fcmV2_adj.metatable_ResAuthorityState
--endregion

---@param tbl fcmV2.ResAuthorityState 待调整的table数据
function fcmV2_adj.AdjustResAuthorityState(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fcmV2_adj.metatable_ResAuthorityState)
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable fcmV2.ReqAuthority
---@type fcmV2.ReqAuthority
fcmV2_adj.metatable_ReqAuthority = {
    _ClassName = "fcmV2.ReqAuthority",
}
fcmV2_adj.metatable_ReqAuthority.__index = fcmV2_adj.metatable_ReqAuthority
--endregion

---@param tbl fcmV2.ReqAuthority 待调整的table数据
function fcmV2_adj.AdjustReqAuthority(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fcmV2_adj.metatable_ReqAuthority)
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.idNumber == nil then
        tbl.idNumberSpecified = false
        tbl.idNumber = ""
    else
        tbl.idNumberSpecified = true
    end
end

--region metatable fcmV2.ResFcmState
---@type fcmV2.ResFcmState
fcmV2_adj.metatable_ResFcmState = {
    _ClassName = "fcmV2.ResFcmState",
}
fcmV2_adj.metatable_ResFcmState.__index = fcmV2_adj.metatable_ResFcmState
--endregion

---@param tbl fcmV2.ResFcmState 待调整的table数据
function fcmV2_adj.AdjustResFcmState(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fcmV2_adj.metatable_ResFcmState)
    if tbl.fcmState == nil then
        tbl.fcmStateSpecified = false
        tbl.fcmState = 0
    else
        tbl.fcmStateSpecified = true
    end
    if tbl.onlineSeconds == nil then
        tbl.onlineSecondsSpecified = false
        tbl.onlineSeconds = 0
    else
        tbl.onlineSecondsSpecified = true
    end
end

return fcmV2_adj