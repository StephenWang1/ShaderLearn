--[[本文件为工具自动生成,禁止手动修改]]
local deliverV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable deliverV2.ReqDeliverByConfig
---@type deliverV2.ReqDeliverByConfig
deliverV2_adj.metatable_ReqDeliverByConfig = {
    _ClassName = "deliverV2.ReqDeliverByConfig",
}
deliverV2_adj.metatable_ReqDeliverByConfig.__index = deliverV2_adj.metatable_ReqDeliverByConfig
--endregion

---@param tbl deliverV2.ReqDeliverByConfig 待调整的table数据
function deliverV2_adj.AdjustReqDeliverByConfig(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, deliverV2_adj.metatable_ReqDeliverByConfig)
    if tbl.deliverId == nil then
        tbl.deliverIdSpecified = false
        tbl.deliverId = 0
    else
        tbl.deliverIdSpecified = true
    end
    if tbl.isStone == nil then
        tbl.isStoneSpecified = false
        tbl.isStone = false
    else
        tbl.isStoneSpecified = true
    end
end

--region metatable deliverV2.ReqDeliverByTransStone
---@type deliverV2.ReqDeliverByTransStone
deliverV2_adj.metatable_ReqDeliverByTransStone = {
    _ClassName = "deliverV2.ReqDeliverByTransStone",
}
deliverV2_adj.metatable_ReqDeliverByTransStone.__index = deliverV2_adj.metatable_ReqDeliverByTransStone
--endregion

---@param tbl deliverV2.ReqDeliverByTransStone 待调整的table数据
function deliverV2_adj.AdjustReqDeliverByTransStone(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, deliverV2_adj.metatable_ReqDeliverByTransStone)
    if tbl.deliverId == nil then
        tbl.deliverIdSpecified = false
        tbl.deliverId = 0
    else
        tbl.deliverIdSpecified = true
    end
end

--region metatable deliverV2.FlyToGoalRequest
---@type deliverV2.FlyToGoalRequest
deliverV2_adj.metatable_FlyToGoalRequest = {
    _ClassName = "deliverV2.FlyToGoalRequest",
}
deliverV2_adj.metatable_FlyToGoalRequest.__index = deliverV2_adj.metatable_FlyToGoalRequest
--endregion

---@param tbl deliverV2.FlyToGoalRequest 待调整的table数据
function deliverV2_adj.AdjustFlyToGoalRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, deliverV2_adj.metatable_FlyToGoalRequest)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
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
    if tbl.npcId == nil then
        tbl.npcIdSpecified = false
        tbl.npcId = 0
    else
        tbl.npcIdSpecified = true
    end
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
end

--region metatable deliverV2.ReqFlyToDynamicGoal
---@type deliverV2.ReqFlyToDynamicGoal
deliverV2_adj.metatable_ReqFlyToDynamicGoal = {
    _ClassName = "deliverV2.ReqFlyToDynamicGoal",
}
deliverV2_adj.metatable_ReqFlyToDynamicGoal.__index = deliverV2_adj.metatable_ReqFlyToDynamicGoal
--endregion

---@param tbl deliverV2.ReqFlyToDynamicGoal 待调整的table数据
function deliverV2_adj.AdjustReqFlyToDynamicGoal(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, deliverV2_adj.metatable_ReqFlyToDynamicGoal)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.cartId == nil then
        tbl.cartIdSpecified = false
        tbl.cartId = 0
    else
        tbl.cartIdSpecified = true
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
end

--region metatable deliverV2.DirectlyTransferRequest
---@type deliverV2.DirectlyTransferRequest
deliverV2_adj.metatable_DirectlyTransferRequest = {
    _ClassName = "deliverV2.DirectlyTransferRequest",
}
deliverV2_adj.metatable_DirectlyTransferRequest.__index = deliverV2_adj.metatable_DirectlyTransferRequest
--endregion

---@param tbl deliverV2.DirectlyTransferRequest 待调整的table数据
function deliverV2_adj.AdjustDirectlyTransferRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, deliverV2_adj.metatable_DirectlyTransferRequest)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
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
end

--region metatable deliverV2.DirectlyTransferRes
---@type deliverV2.DirectlyTransferRes
deliverV2_adj.metatable_DirectlyTransferRes = {
    _ClassName = "deliverV2.DirectlyTransferRes",
}
deliverV2_adj.metatable_DirectlyTransferRes.__index = deliverV2_adj.metatable_DirectlyTransferRes
--endregion

---@param tbl deliverV2.DirectlyTransferRes 待调整的table数据
function deliverV2_adj.AdjustDirectlyTransferRes(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, deliverV2_adj.metatable_DirectlyTransferRes)
end

--region metatable deliverV2.ReqEnterMapByNPC
---@type deliverV2.ReqEnterMapByNPC
deliverV2_adj.metatable_ReqEnterMapByNPC = {
    _ClassName = "deliverV2.ReqEnterMapByNPC",
}
deliverV2_adj.metatable_ReqEnterMapByNPC.__index = deliverV2_adj.metatable_ReqEnterMapByNPC
--endregion

---@param tbl deliverV2.ReqEnterMapByNPC 待调整的table数据
function deliverV2_adj.AdjustReqEnterMapByNPC(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, deliverV2_adj.metatable_ReqEnterMapByNPC)
    if tbl.npcId == nil then
        tbl.npcIdSpecified = false
        tbl.npcId = 0
    else
        tbl.npcIdSpecified = true
    end
    if tbl.deliverId == nil then
        tbl.deliverIdSpecified = false
        tbl.deliverId = 0
    else
        tbl.deliverIdSpecified = true
    end
end

--region metatable deliverV2.DirectlyTransferRandomPointRequest
---@type deliverV2.DirectlyTransferRandomPointRequest
deliverV2_adj.metatable_DirectlyTransferRandomPointRequest = {
    _ClassName = "deliverV2.DirectlyTransferRandomPointRequest",
}
deliverV2_adj.metatable_DirectlyTransferRandomPointRequest.__index = deliverV2_adj.metatable_DirectlyTransferRandomPointRequest
--endregion

---@param tbl deliverV2.DirectlyTransferRandomPointRequest 待调整的table数据
function deliverV2_adj.AdjustDirectlyTransferRandomPointRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, deliverV2_adj.metatable_DirectlyTransferRandomPointRequest)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
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
end

--region metatable deliverV2.ReqMinMapDeliver
---@type deliverV2.ReqMinMapDeliver
deliverV2_adj.metatable_ReqMinMapDeliver = {
    _ClassName = "deliverV2.ReqMinMapDeliver",
}
deliverV2_adj.metatable_ReqMinMapDeliver.__index = deliverV2_adj.metatable_ReqMinMapDeliver
--endregion

---@param tbl deliverV2.ReqMinMapDeliver 待调整的table数据
function deliverV2_adj.AdjustReqMinMapDeliver(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, deliverV2_adj.metatable_ReqMinMapDeliver)
    if tbl.deliverId == nil then
        tbl.deliverIdSpecified = false
        tbl.deliverId = 0
    else
        tbl.deliverIdSpecified = true
    end
end

--region metatable deliverV2.CanTransferTaskId
---@type deliverV2.CanTransferTaskId
deliverV2_adj.metatable_CanTransferTaskId = {
    _ClassName = "deliverV2.CanTransferTaskId",
}
deliverV2_adj.metatable_CanTransferTaskId.__index = deliverV2_adj.metatable_CanTransferTaskId
--endregion

---@param tbl deliverV2.CanTransferTaskId 待调整的table数据
function deliverV2_adj.AdjustCanTransferTaskId(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, deliverV2_adj.metatable_CanTransferTaskId)
    if tbl.taskId == nil then
        tbl.taskIdSpecified = false
        tbl.taskId = 0
    else
        tbl.taskIdSpecified = true
    end
end

--region metatable deliverV2.ReqThisMapTransfer
---@type deliverV2.ReqThisMapTransfer
deliverV2_adj.metatable_ReqThisMapTransfer = {
    _ClassName = "deliverV2.ReqThisMapTransfer",
}
deliverV2_adj.metatable_ReqThisMapTransfer.__index = deliverV2_adj.metatable_ReqThisMapTransfer
--endregion

---@param tbl deliverV2.ReqThisMapTransfer 待调整的table数据
function deliverV2_adj.AdjustReqThisMapTransfer(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, deliverV2_adj.metatable_ReqThisMapTransfer)
    if tbl.taskId == nil then
        tbl.taskIdSpecified = false
        tbl.taskId = 0
    else
        tbl.taskIdSpecified = true
    end
end

--region metatable deliverV2.ResThisMapTransfer
---@type deliverV2.ResThisMapTransfer
deliverV2_adj.metatable_ResThisMapTransfer = {
    _ClassName = "deliverV2.ResThisMapTransfer",
}
deliverV2_adj.metatable_ResThisMapTransfer.__index = deliverV2_adj.metatable_ResThisMapTransfer
--endregion

---@param tbl deliverV2.ResThisMapTransfer 待调整的table数据
function deliverV2_adj.AdjustResThisMapTransfer(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, deliverV2_adj.metatable_ResThisMapTransfer)
    if tbl.isSuccess == nil then
        tbl.isSuccessSpecified = false
        tbl.isSuccess = 0
    else
        tbl.isSuccessSpecified = true
    end
end

--region metatable deliverV2.ReqDeliverByReason
---@type deliverV2.ReqDeliverByReason
deliverV2_adj.metatable_ReqDeliverByReason = {
    _ClassName = "deliverV2.ReqDeliverByReason",
}
deliverV2_adj.metatable_ReqDeliverByReason.__index = deliverV2_adj.metatable_ReqDeliverByReason
--endregion

---@param tbl deliverV2.ReqDeliverByReason 待调整的table数据
function deliverV2_adj.AdjustReqDeliverByReason(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, deliverV2_adj.metatable_ReqDeliverByReason)
    if tbl.reason == nil then
        tbl.reasonSpecified = false
        tbl.reason = 0
    else
        tbl.reasonSpecified = true
    end
end

--region metatable deliverV2.TaskBossDeliverReq
---@type deliverV2.TaskBossDeliverReq
deliverV2_adj.metatable_TaskBossDeliverReq = {
    _ClassName = "deliverV2.TaskBossDeliverReq",
}
deliverV2_adj.metatable_TaskBossDeliverReq.__index = deliverV2_adj.metatable_TaskBossDeliverReq
--endregion

---@param tbl deliverV2.TaskBossDeliverReq 待调整的table数据
function deliverV2_adj.AdjustTaskBossDeliverReq(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, deliverV2_adj.metatable_TaskBossDeliverReq)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
end

--region metatable deliverV2.TaskRandomReq
---@type deliverV2.TaskRandomReq
deliverV2_adj.metatable_TaskRandomReq = {
    _ClassName = "deliverV2.TaskRandomReq",
}
deliverV2_adj.metatable_TaskRandomReq.__index = deliverV2_adj.metatable_TaskRandomReq
--endregion

---@param tbl deliverV2.TaskRandomReq 待调整的table数据
function deliverV2_adj.AdjustTaskRandomReq(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, deliverV2_adj.metatable_TaskRandomReq)
    if tbl.targetMapId == nil then
        tbl.targetMapIdSpecified = false
        tbl.targetMapId = 0
    else
        tbl.targetMapIdSpecified = true
    end
    if tbl.targetX == nil then
        tbl.targetXSpecified = false
        tbl.targetX = 0
    else
        tbl.targetXSpecified = true
    end
    if tbl.targetY == nil then
        tbl.targetYSpecified = false
        tbl.targetY = 0
    else
        tbl.targetYSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.group == nil then
        tbl.groupSpecified = false
        tbl.group = 0
    else
        tbl.groupSpecified = true
    end
    if tbl.taskId == nil then
        tbl.taskIdSpecified = false
        tbl.taskId = 0
    else
        tbl.taskIdSpecified = true
    end
end

--region metatable deliverV2.ReqRandomDeliverToMonster
---@type deliverV2.ReqRandomDeliverToMonster
deliverV2_adj.metatable_ReqRandomDeliverToMonster = {
    _ClassName = "deliverV2.ReqRandomDeliverToMonster",
}
deliverV2_adj.metatable_ReqRandomDeliverToMonster.__index = deliverV2_adj.metatable_ReqRandomDeliverToMonster
--endregion

---@param tbl deliverV2.ReqRandomDeliverToMonster 待调整的table数据
function deliverV2_adj.AdjustReqRandomDeliverToMonster(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, deliverV2_adj.metatable_ReqRandomDeliverToMonster)
end

return deliverV2_adj