--[[本文件为工具自动生成,禁止手动修改]]
local deliverV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData deliverV2.ReqDeliverByConfig lua中的数据结构
---@return deliverV2.ReqDeliverByConfig C#中的数据结构
function deliverV2.ReqDeliverByConfig(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.deliverV2.ReqDeliverByConfig()
    if decodedData.deliverId ~= nil and decodedData.deliverIdSpecified ~= false then
        data.deliverId = decodedData.deliverId
    end
    if decodedData.isStone ~= nil and decodedData.isStoneSpecified ~= false then
        data.isStone = decodedData.isStone
    end
    return data
end

---@param decodedData deliverV2.ReqDeliverByTransStone lua中的数据结构
---@return deliverV2.ReqDeliverByTransStone C#中的数据结构
function deliverV2.ReqDeliverByTransStone(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.deliverV2.ReqDeliverByTransStone()
    if decodedData.deliverId ~= nil and decodedData.deliverIdSpecified ~= false then
        data.deliverId = decodedData.deliverId
    end
    return data
end

---@param decodedData deliverV2.FlyToGoalRequest lua中的数据结构
---@return deliverV2.FlyToGoalRequest C#中的数据结构
function deliverV2.FlyToGoalRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.deliverV2.FlyToGoalRequest()
    data.taskId = decodedData.taskId
    data.taskType = decodedData.taskType
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.npcId ~= nil and decodedData.npcIdSpecified ~= false then
        data.npcId = decodedData.npcId
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

--[[deliverV2.ReqFlyToDynamicGoal 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData deliverV2.DirectlyTransferRequest lua中的数据结构
---@return deliverV2.DirectlyTransferRequest C#中的数据结构
function deliverV2.DirectlyTransferRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.deliverV2.DirectlyTransferRequest()
    data.taskId = decodedData.taskId
    data.taskType = decodedData.taskType
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    return data
end

---@param decodedData deliverV2.DirectlyTransferRes lua中的数据结构
---@return deliverV2.DirectlyTransferRes C#中的数据结构
function deliverV2.DirectlyTransferRes(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.deliverV2.DirectlyTransferRes()
    data.taskId = decodedData.taskId
    return data
end

---@param decodedData deliverV2.ReqEnterMapByNPC lua中的数据结构
---@return deliverV2.ReqEnterMapByNPC C#中的数据结构
function deliverV2.ReqEnterMapByNPC(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.deliverV2.ReqEnterMapByNPC()
    if decodedData.npcId ~= nil and decodedData.npcIdSpecified ~= false then
        data.npcId = decodedData.npcId
    end
    if decodedData.deliverId ~= nil and decodedData.deliverIdSpecified ~= false then
        data.deliverId = decodedData.deliverId
    end
    return data
end

---@param decodedData deliverV2.DirectlyTransferRandomPointRequest lua中的数据结构
---@return deliverV2.DirectlyTransferRandomPointRequest C#中的数据结构
function deliverV2.DirectlyTransferRandomPointRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.deliverV2.DirectlyTransferRandomPointRequest()
    data.taskId = decodedData.taskId
    data.taskType = decodedData.taskType
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    return data
end

---@param decodedData deliverV2.ReqMinMapDeliver lua中的数据结构
---@return deliverV2.ReqMinMapDeliver C#中的数据结构
function deliverV2.ReqMinMapDeliver(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.deliverV2.ReqMinMapDeliver()
    if decodedData.deliverId ~= nil and decodedData.deliverIdSpecified ~= false then
        data.deliverId = decodedData.deliverId
    end
    return data
end

---@param decodedData deliverV2.CanTransferTaskId lua中的数据结构
---@return deliverV2.CanTransferTaskId C#中的数据结构
function deliverV2.CanTransferTaskId(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.deliverV2.CanTransferTaskId()
    if decodedData.taskId ~= nil and decodedData.taskIdSpecified ~= false then
        data.taskId = decodedData.taskId
    end
    return data
end

---@param decodedData deliverV2.ReqThisMapTransfer lua中的数据结构
---@return deliverV2.ReqThisMapTransfer C#中的数据结构
function deliverV2.ReqThisMapTransfer(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.deliverV2.ReqThisMapTransfer()
    if decodedData.taskId ~= nil and decodedData.taskIdSpecified ~= false then
        data.taskId = decodedData.taskId
    end
    return data
end

---@param decodedData deliverV2.ResThisMapTransfer lua中的数据结构
---@return deliverV2.ResThisMapTransfer C#中的数据结构
function deliverV2.ResThisMapTransfer(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.deliverV2.ResThisMapTransfer()
    if decodedData.isSuccess ~= nil and decodedData.isSuccessSpecified ~= false then
        data.isSuccess = decodedData.isSuccess
    end
    return data
end

--[[deliverV2.ReqDeliverByReason 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[deliverV2.TaskBossDeliverReq 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData deliverV2.TaskRandomReq lua中的数据结构
---@return deliverV2.TaskRandomReq C#中的数据结构
function deliverV2.TaskRandomReq(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.deliverV2.TaskRandomReq()
    if decodedData.targetMapId ~= nil and decodedData.targetMapIdSpecified ~= false then
        data.targetMapId = decodedData.targetMapId
    end
    if decodedData.targetX ~= nil and decodedData.targetXSpecified ~= false then
        data.targetX = decodedData.targetX
    end
    if decodedData.targetY ~= nil and decodedData.targetYSpecified ~= false then
        data.targetY = decodedData.targetY
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.group ~= nil and decodedData.groupSpecified ~= false then
        data.group = decodedData.group
    end
    if decodedData.taskId ~= nil and decodedData.taskIdSpecified ~= false then
        data.taskId = decodedData.taskId
    end
    return data
end

--[[deliverV2.ReqRandomDeliverToMonster 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return deliverV2