--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--deliver.xml

--region ID:72001 ReqDeliverByConfigMessage 通过配置文件传送
---@param msgID LuaEnumNetDef 消息ID
---@param csData deliverV2.ReqDeliverByConfig lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[72001] = function(msgID, csData)
    --在此处填入预校验代码
    if CS.CSScene.MainPlayerInfo.DeliverInfoV2.IsBreak then
        CS.CSScene.MainPlayerInfo.DeliverInfoV2:CacheDeliverInfo(csData.deliverId, false);
        return false
    end
    --若传送则关闭自动寻路和自动战斗
    CS.CSPathFinderManager.Instance:Reset(true, false)
    --清除当前任务
    CS.CSMissionManager.Instance:ClearCurrentTask()
    --清除并关闭目标选择系统
    CS.CSTargetGetWayManager.Instanece:Clear()
    return true
end
--endregion

--region ID:72002 ReqDeliverByTransStoneMessage 通过传送石传送
---@param msgID LuaEnumNetDef 消息ID
---@param csData deliverV2.ReqDeliverByTransStone lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[72002] = function(msgID, csData)
    --在此处填入预校验代码
    if CS.CSScene.MainPlayerInfo.DeliverInfoV2.IsBreak then
        CS.CSScene.MainPlayerInfo.DeliverInfoV2:CacheDeliverInfo(csData.deliverId, csData.isStone);
        return false
    end
    return true
end
--endregion

--region ID:72013 ReqFlyToDynamicGoalMessage 小飞鞋飞动点请求
---@param msgID LuaEnumNetDef 消息ID
---@param csData deliverV2.ReqFlyToDynamicGoal lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[72013] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:72015 ReqDeliverByReasonMessage 通用传送
---@param msgID LuaEnumNetDef 消息ID
---@param csData deliverV2.ReqDeliverByReason lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[72015] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:72016 ReqTaskBossDeliverMessage 精英任务传送
---@param msgID LuaEnumNetDef 消息ID
---@param csData deliverV2.TaskBossDeliverReq lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[72016] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:72018 ReqRandomDeliverToMonsterMessage 怪物攻城随机传送到怪物点
---@param msgID LuaEnumNetDef 消息ID
---@param csData deliverV2.ReqRandomDeliverToMonster lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[72018] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
