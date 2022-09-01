--[[本文件为工具自动生成,禁止手动修改]]
local moveV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable moveV2.ReqMove
---@type moveV2.ReqMove
moveV2_adj.metatable_ReqMove = {
    _ClassName = "moveV2.ReqMove",
}
moveV2_adj.metatable_ReqMove.__index = moveV2_adj.metatable_ReqMove
--endregion

---@param tbl moveV2.ReqMove 待调整的table数据
function moveV2_adj.AdjustReqMove(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, moveV2_adj.metatable_ReqMove)
    if tbl.x == nil then
        tbl.xSpecified = false
        tbl.x = 0
    else
        tbl.xSpecified = true
    end
    if tbl.y == nil then
        tbl.ySpecified = false
        tbl.y = 0
    else
        tbl.ySpecified = true
    end
    if tbl.action == nil then
        tbl.actionSpecified = false
        tbl.action = 0
    else
        tbl.actionSpecified = true
    end
end

--region metatable moveV2.ResMove
---@type moveV2.ResMove
moveV2_adj.metatable_ResMove = {
    _ClassName = "moveV2.ResMove",
}
moveV2_adj.metatable_ResMove.__index = moveV2_adj.metatable_ResMove
--endregion

---@param tbl moveV2.ResMove 待调整的table数据
function moveV2_adj.AdjustResMove(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, moveV2_adj.metatable_ResMove)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.x == nil then
        tbl.xSpecified = false
        tbl.x = 0
    else
        tbl.xSpecified = true
    end
    if tbl.y == nil then
        tbl.ySpecified = false
        tbl.y = 0
    else
        tbl.ySpecified = true
    end
    if tbl.action == nil then
        tbl.actionSpecified = false
        tbl.action = 0
    else
        tbl.actionSpecified = true
    end
end

--region metatable moveV2.ReqPlayerMoveRequest
---@type moveV2.ReqPlayerMoveRequest
moveV2_adj.metatable_ReqPlayerMoveRequest = {
    _ClassName = "moveV2.ReqPlayerMoveRequest",
}
moveV2_adj.metatable_ReqPlayerMoveRequest.__index = moveV2_adj.metatable_ReqPlayerMoveRequest
--endregion

---@param tbl moveV2.ReqPlayerMoveRequest 待调整的table数据
function moveV2_adj.AdjustReqPlayerMoveRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, moveV2_adj.metatable_ReqPlayerMoveRequest)
    if tbl.x == nil then
        tbl.xSpecified = false
        tbl.x = 0
    else
        tbl.xSpecified = true
    end
    if tbl.y == nil then
        tbl.ySpecified = false
        tbl.y = 0
    else
        tbl.ySpecified = true
    end
    if tbl.startTime == nil then
        tbl.startTimeSpecified = false
        tbl.startTime = 0
    else
        tbl.startTimeSpecified = true
    end
    if tbl.action == nil then
        tbl.actionSpecified = false
        tbl.action = 0
    else
        tbl.actionSpecified = true
    end
    if tbl.currentX == nil then
        tbl.currentXSpecified = false
        tbl.currentX = 0
    else
        tbl.currentXSpecified = true
    end
    if tbl.currentY == nil then
        tbl.currentYSpecified = false
        tbl.currentY = 0
    else
        tbl.currentYSpecified = true
    end
    if tbl.changePosFirst == nil then
        tbl.changePosFirstSpecified = false
        tbl.changePosFirst = false
    else
        tbl.changePosFirstSpecified = true
    end
end

--region metatable moveV2.ReqChangeDir
---@type moveV2.ReqChangeDir
moveV2_adj.metatable_ReqChangeDir = {
    _ClassName = "moveV2.ReqChangeDir",
}
moveV2_adj.metatable_ReqChangeDir.__index = moveV2_adj.metatable_ReqChangeDir
--endregion

---@param tbl moveV2.ReqChangeDir 待调整的table数据
function moveV2_adj.AdjustReqChangeDir(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, moveV2_adj.metatable_ReqChangeDir)
    if tbl.dir == nil then
        tbl.dirSpecified = false
        tbl.dir = ""
    else
        tbl.dirSpecified = true
    end
end

--region metatable moveV2.ResChangeDir
---@type moveV2.ResChangeDir
moveV2_adj.metatable_ResChangeDir = {
    _ClassName = "moveV2.ResChangeDir",
}
moveV2_adj.metatable_ResChangeDir.__index = moveV2_adj.metatable_ResChangeDir
--endregion

---@param tbl moveV2.ResChangeDir 待调整的table数据
function moveV2_adj.AdjustResChangeDir(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, moveV2_adj.metatable_ResChangeDir)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.dir == nil then
        tbl.dirSpecified = false
        tbl.dir = ""
    else
        tbl.dirSpecified = true
    end
end

return moveV2_adj