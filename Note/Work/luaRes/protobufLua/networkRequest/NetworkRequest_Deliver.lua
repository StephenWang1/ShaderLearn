--[[本文件为工具自动生成,禁止手动修改]]
--deliver.xml

--region ID:72001 通过配置文件传送
---通过配置文件传送
---msgID: 72001
---@param deliverId number 选填参数 传送配置id
---@param isStone boolean 选填参数 是否通过传送石
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDeliverByConfig(deliverId, isStone)
    local reqTable = {}
    if deliverId ~= nil then
        reqTable.deliverId = deliverId
    end
    if isStone ~= nil then
        reqTable.isStone = isStone
    end
    local reqMsgData = protobufMgr.Serialize("deliverV2.ReqDeliverByConfig" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDeliverByConfigMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDeliverByConfigMessage](LuaEnumNetDef.ReqDeliverByConfigMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDeliverByConfigMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDeliverByConfigMessage", 72001, "ReqDeliverByConfig", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:72002 通过传送石传送
---通过传送石传送
---msgID: 72002
---@param deliverId number 选填参数 传送id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDeliverByTransStone(deliverId)
    local reqTable = {}
    if deliverId ~= nil then
        reqTable.deliverId = deliverId
    end
    local reqMsgData = protobufMgr.Serialize("deliverV2.ReqDeliverByTransStone" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDeliverByTransStoneMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDeliverByTransStoneMessage](LuaEnumNetDef.ReqDeliverByTransStoneMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDeliverByTransStoneMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDeliverByTransStoneMessage", 72002, "ReqDeliverByTransStone", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:72003 小飞鞋请求
---小飞鞋请求
---msgID: 72003
---@param taskId number 必填参数
---@param taskType number 必填参数 任务状态 1 可接、未接 2 接受 3 完成、提交
---@param mapId number 选填参数 地图id
---@param x number 选填参数 坐标x
---@param y number 选填参数 坐标y
---@param npcId number 选填参数 NPCID
---@param itemId number 选填参数 物品id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqFlyToGoal(taskId, taskType, mapId, x, y, npcId, itemId)
    local reqTable = {}
    reqTable.taskId = taskId
    reqTable.taskType = taskType
    if mapId ~= nil then
        reqTable.mapId = mapId
    end
    if x ~= nil then
        reqTable.x = x
    end
    if y ~= nil then
        reqTable.y = y
    end
    if npcId ~= nil then
        reqTable.npcId = npcId
    end
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    local reqMsgData = protobufMgr.Serialize("deliverV2.FlyToGoalRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqFlyToGoalMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqFlyToGoalMessage](LuaEnumNetDef.ReqFlyToGoalMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqFlyToGoalMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqFlyToGoalMessage", 72003, "FlyToGoalRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:72005 直接传送随机远点请求
---直接传送随机远点请求
---msgID: 72005
---@param taskId number 必填参数
---@param taskType number 必填参数 任务状态 1 可接、未接 2 接受 3 完成、提交
---@param mapId number 选填参数 地图id
---@param x number 选填参数 坐标x
---@param y number 选填参数 坐标y
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDirectlyTransfer(taskId, taskType, mapId, x, y)
    local reqTable = {}
    reqTable.taskId = taskId
    reqTable.taskType = taskType
    if mapId ~= nil then
        reqTable.mapId = mapId
    end
    if x ~= nil then
        reqTable.x = x
    end
    if y ~= nil then
        reqTable.y = y
    end
    local reqMsgData = protobufMgr.Serialize("deliverV2.DirectlyTransferRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDirectlyTransferMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDirectlyTransferMessage](LuaEnumNetDef.ReqDirectlyTransferMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDirectlyTransferMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDirectlyTransferMessage", 72005, "DirectlyTransferRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:72007 通过npc进入地图
---通过npc进入地图
---msgID: 72007
---@param npcId number 选填参数 npc唯一id
---@param deliverId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqEnterMapByNPC(npcId, deliverId)
    local reqTable = {}
    if npcId ~= nil then
        reqTable.npcId = npcId
    end
    if deliverId ~= nil then
        reqTable.deliverId = deliverId
    end
    local reqMsgData = protobufMgr.Serialize("deliverV2.ReqEnterMapByNPC" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqEnterMapByNPCMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqEnterMapByNPCMessage](LuaEnumNetDef.ReqEnterMapByNPCMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqEnterMapByNPCMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqEnterMapByNPCMessage", 72007, "ReqEnterMapByNPC", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:72008 直接传送随机点请求
---直接传送随机点请求
---msgID: 72008
---@param taskId number 必填参数
---@param taskType number 必填参数 任务状态 1 可接、未接 2 接受 3 完成、提交
---@param mapId number 选填参数 地图id
---@param x number 选填参数 坐标x
---@param y number 选填参数 坐标y
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDirectlyTransferRandomPoint(taskId, taskType, mapId, x, y)
    local reqTable = {}
    reqTable.taskId = taskId
    reqTable.taskType = taskType
    if mapId ~= nil then
        reqTable.mapId = mapId
    end
    if x ~= nil then
        reqTable.x = x
    end
    if y ~= nil then
        reqTable.y = y
    end
    local reqMsgData = protobufMgr.Serialize("deliverV2.DirectlyTransferRandomPointRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDirectlyTransferRandomPointMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDirectlyTransferRandomPointMessage](LuaEnumNetDef.ReqDirectlyTransferRandomPointMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDirectlyTransferRandomPointMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDirectlyTransferRandomPointMessage", 72008, "DirectlyTransferRandomPointRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:72009 通过小地图传送
---通过小地图传送
---msgID: 72009
---@param deliverId number 选填参数 传送配置id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqMinMapDeliver(deliverId)
    local reqTable = {}
    if deliverId ~= nil then
        reqTable.deliverId = deliverId
    end
    local reqMsgData = protobufMgr.Serialize("deliverV2.ReqMinMapDeliver" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqMinMapDeliverMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqMinMapDeliverMessage](LuaEnumNetDef.ReqMinMapDeliverMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqMinMapDeliverMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqMinMapDeliverMessage", 72009, "ReqMinMapDeliver", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:72011 请求本地图传送
---请求本地图传送
---msgID: 72011
---@param taskId number 选填参数 主线任务ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqThisMapTransfer(taskId)
    local reqTable = {}
    if taskId ~= nil then
        reqTable.taskId = taskId
    end
    local reqMsgData = protobufMgr.Serialize("deliverV2.ReqThisMapTransfer" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqThisMapTransferMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqThisMapTransferMessage](LuaEnumNetDef.ReqThisMapTransferMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqThisMapTransferMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqThisMapTransferMessage", 72011, "ReqThisMapTransfer", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:72013 小飞鞋飞动点请求
---小飞鞋飞动点请求
---msgID: 72013
---@param type number 选填参数 1:个人押镖 2:行会镖车
---@param cartId number 选填参数 个人镖车id
---@param x number 选填参数
---@param y number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqFlyToDynamicGoal(type, cartId, x, y)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if cartId ~= nil then
        reqTable.cartId = cartId
    end
    if x ~= nil then
        reqTable.x = x
    end
    if y ~= nil then
        reqTable.y = y
    end
    local reqMsgData = protobufMgr.Serialize("deliverV2.ReqFlyToDynamicGoal" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqFlyToDynamicGoalMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqFlyToDynamicGoalMessage](LuaEnumNetDef.ReqFlyToDynamicGoalMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqFlyToDynamicGoalMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqFlyToDynamicGoalMessage", 72013, "ReqFlyToDynamicGoal", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:72015 通用传送
---通用传送
---msgID: 72015
---@param deliverId number 必填参数
---@param reason number 选填参数 原因
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDeliverByReason(deliverId, reason)
    local reqTable = {}
    reqTable.deliverId = deliverId
    if reason ~= nil then
        reqTable.reason = reason
    end
    local reqMsgData = protobufMgr.Serialize("deliverV2.ReqDeliverByReason" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDeliverByReasonMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDeliverByReasonMessage](LuaEnumNetDef.ReqDeliverByReasonMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDeliverByReasonMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDeliverByReasonMessage", 72015, "ReqDeliverByReason", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:72016 精英任务传送
---精英任务传送
---msgID: 72016
---@param cfgId number 必填参数 cfg_taskboss.csv表id
---@param mapId number 选填参数 地图id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTaskBossDeliver(cfgId, mapId)
    local reqTable = {}
    reqTable.cfgId = cfgId
    if mapId ~= nil then
        reqTable.mapId = mapId
    end
    local reqMsgData = protobufMgr.Serialize("deliverV2.TaskBossDeliverReq" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTaskBossDeliverMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTaskBossDeliverMessage](LuaEnumNetDef.ReqTaskBossDeliverMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqTaskBossDeliverMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqTaskBossDeliverMessage", 72016, "TaskBossDeliverReq", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:72017 恶魔广场任务随机传送
---恶魔广场任务随机传送
---msgID: 72017
---@param targetMapId number 选填参数 目标地图id
---@param targetX number 选填参数 目标坐标x
---@param targetY number 选填参数 目标坐标y
---@param type number 选填参数 类型 1.取任务id2，取group
---@param group number 选填参数 组
---@param taskId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTaskRandomReq(targetMapId, targetX, targetY, type, group, taskId)
    local reqTable = {}
    if targetMapId ~= nil then
        reqTable.targetMapId = targetMapId
    end
    if targetX ~= nil then
        reqTable.targetX = targetX
    end
    if targetY ~= nil then
        reqTable.targetY = targetY
    end
    if type ~= nil then
        reqTable.type = type
    end
    if group ~= nil then
        reqTable.group = group
    end
    if taskId ~= nil then
        reqTable.taskId = taskId
    end
    local reqMsgData = protobufMgr.Serialize("deliverV2.TaskRandomReq" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTaskRandomReqMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTaskRandomReqMessage](LuaEnumNetDef.ReqTaskRandomReqMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqTaskRandomReqMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqTaskRandomReqMessage", 72017, "TaskRandomReq", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:72018 怪物攻城随机传送到怪物点
---怪物攻城随机传送到怪物点
---msgID: 72018
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRandomDeliverToMonster()
    local reqTable = {}
    local reqMsgData = protobufMgr.Serialize("deliverV2.ReqRandomDeliverToMonster" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRandomDeliverToMonsterMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRandomDeliverToMonsterMessage](LuaEnumNetDef.ReqRandomDeliverToMonsterMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRandomDeliverToMonsterMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRandomDeliverToMonsterMessage", 72018, "ReqRandomDeliverToMonster", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

