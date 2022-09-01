--[[本文件为工具自动生成,禁止手动修改]]
--task.xml

--region ID:102002 请求提交任务消息
---请求提交任务消息
---msgID: 102002
---@param taskId number 必填参数
---@param taskValue number 选填参数 参数值
---@param monsterTask number 选填参数 不传或者0 其他任务， 1：怪物悬赏
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSubmitTask(taskId, taskValue, monsterTask)
    local reqTable = {}
    reqTable.taskId = taskId
    if taskValue ~= nil then
        reqTable.taskValue = taskValue
    end
    if monsterTask ~= nil then
        reqTable.monsterTask = monsterTask
    end
    local reqMsgData = protobufMgr.Serialize("taskV2.SubmitTaskRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSubmitTaskMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSubmitTaskMessage](LuaEnumNetDef.ReqSubmitTaskMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSubmitTaskMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSubmitTaskMessage", 102002, "SubmitTaskRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:102005 请求打开面板
---请求打开面板
---msgID: 102005
---@param type number 必填参数 任务类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOpenPanelInfo(type)
    local reqTable = {}
    reqTable.type = type
    local reqMsgData = protobufMgr.Serialize("taskV2.OpenPanelInfoRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOpenPanelInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOpenPanelInfoMessage](LuaEnumNetDef.ReqOpenPanelInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqOpenPanelInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqOpenPanelInfoMessage", 102005, "OpenPanelInfoRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:102006 请求接受任务
---请求接受任务
---msgID: 102006
---@param taskId number 必填参数 任务id
---@param npcId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAcceptTask(taskId, npcId)
    local reqTable = {}
    reqTable.taskId = taskId
    if npcId ~= nil then
        reqTable.npcId = npcId
    end
    local reqMsgData = protobufMgr.Serialize("taskV2.AcceptTaskRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAcceptTaskMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAcceptTaskMessage](LuaEnumNetDef.ReqAcceptTaskMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAcceptTaskMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAcceptTaskMessage", 102006, "AcceptTaskRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:102007 请求立即完成指定任务
---请求立即完成指定任务
---msgID: 102007
---@param taskId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCompleteTaskQuickly(taskId)
    local reqTable = {}
    reqTable.taskId = taskId
    local reqMsgData = protobufMgr.Serialize("taskV2.CompleteTaskQuicklyRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCompleteTaskQuicklyMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCompleteTaskQuicklyMessage](LuaEnumNetDef.ReqCompleteTaskQuicklyMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqCompleteTaskQuicklyMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqCompleteTaskQuicklyMessage", 102007, "CompleteTaskQuicklyRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:102009 一键完成任务
---一键完成任务
---msgID: 102009
---@param taskId number 选填参数 任务
---@param count number 选填参数 次数
---@return boolean 网络请求是否成功发送
function networkRequest.ResAutoFinishTask(taskId, count)
    local reqTable = {}
    if taskId ~= nil then
        reqTable.taskId = taskId
    end
    if count ~= nil then
        reqTable.count = count
    end
    local reqMsgData = protobufMgr.Serialize("taskV2.AutoFinishTaskRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ResAutoFinishTaskMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ResAutoFinishTaskMessage](LuaEnumNetDef.ResAutoFinishTaskMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ResAutoFinishTaskMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ResAutoFinishTaskMessage", 102009, "AutoFinishTaskRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:102010 购买雇佣兵次数
---购买雇佣兵次数
---msgID: 102010
---@param times number 选填参数 次数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBuyMercenaryTaskTimes(times)
    local reqTable = {}
    if times ~= nil then
        reqTable.times = times
    end
    local reqMsgData = protobufMgr.Serialize("taskV2.BuyMercenaryTaskTimesRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBuyMercenaryTaskTimesMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBuyMercenaryTaskTimesMessage](LuaEnumNetDef.ReqBuyMercenaryTaskTimesMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqBuyMercenaryTaskTimesMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqBuyMercenaryTaskTimesMessage", 102010, "BuyMercenaryTaskTimesRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:102013 购买日常任务次数
---购买日常任务次数
---msgID: 102013
---@param type number 必填参数 类型
---@param times number 选填参数 次数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBuyDailyTaskTimes(type, times)
    local reqTable = {}
    reqTable.type = type
    if times ~= nil then
        reqTable.times = times
    end
    local reqMsgData = protobufMgr.Serialize("taskV2.BuyDailyTaskTimesRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBuyDailyTaskTimesMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBuyDailyTaskTimesMessage](LuaEnumNetDef.ReqBuyDailyTaskTimesMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqBuyDailyTaskTimesMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqBuyDailyTaskTimesMessage", 102013, "BuyDailyTaskTimesRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:102015 请求日常材料列表
---请求日常材料列表
---msgID: 102015
---@param profession number 选填参数 1铁匠  2屠夫  3药商
---@return boolean 网络请求是否成功发送
function networkRequest.ReqMaterialList(profession)
    local reqTable = {}
    if profession ~= nil then
        reqTable.profession = profession
    end
    local reqMsgData = protobufMgr.Serialize("taskV2.ReqMaterialList" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqMaterialListMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqMaterialListMessage](LuaEnumNetDef.ReqMaterialListMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqMaterialListMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqMaterialListMessage", 102015, "ReqMaterialList", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:102017 请求购买或者出售日常材料
---请求购买或者出售日常材料
---msgID: 102017
---@param buyOrSell number 选填参数 1是购买  2是出售
---@param itemId number 选填参数 itemId
---@param count number 选填参数 目前只能单个购买
---@param profession number 选填参数 1铁匠  2屠夫  3药商
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBuyMaterial(buyOrSell, itemId, count, profession)
    local reqTable = {}
    if buyOrSell ~= nil then
        reqTable.buyOrSell = buyOrSell
    end
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    if count ~= nil then
        reqTable.count = count
    end
    if profession ~= nil then
        reqTable.profession = profession
    end
    local reqMsgData = protobufMgr.Serialize("taskV2.ReqBuyMaterial" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBuyMaterialMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBuyMaterialMessage](LuaEnumNetDef.ReqBuyMaterialMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqBuyMaterialMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqBuyMaterialMessage", 102017, "ReqBuyMaterial", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:102019 提交日常任务物品
---提交日常任务物品
---msgID: 102019
---@param type number 必填参数 日常任务类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSubmitDailyItem(type)
    local reqTable = {}
    reqTable.type = type
    local reqMsgData = protobufMgr.Serialize("taskV2.ReqSubmitDailyItem" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSubmitDailyItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSubmitDailyItemMessage](LuaEnumNetDef.ReqSubmitDailyItemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSubmitDailyItemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSubmitDailyItemMessage", 102019, "ReqSubmitDailyItem", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:102022 请求任务设置
---请求任务设置
---msgID: 102022
---@param tips System.Collections.Generic.List1T<number> 列表参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTaskSetting(tips)
    local reqData = CS.taskV2.TaskSetting()
    if tips ~= nil then
        reqData.tips:AddRange(tips)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTaskSettingMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTaskSettingMessage](LuaEnumNetDef.ReqTaskSettingMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqTaskSettingMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:102024 购买精英任务
---购买精英任务
---msgID: 102024
---@return boolean 网络请求是否成功发送
function networkRequest.ReqEliteTaskBuyTimes()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqEliteTaskBuyTimesMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqEliteTaskBuyTimesMessage](LuaEnumNetDef.ReqEliteTaskBuyTimesMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqEliteTaskBuyTimesMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:102025 精英任务购买价格请求
---精英任务购买价格请求
---msgID: 102025
---@return boolean 网络请求是否成功发送
function networkRequest.ReqEliteBuyPrice()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqEliteBuyPriceMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqEliteBuyPriceMessage](LuaEnumNetDef.ReqEliteBuyPriceMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqEliteBuyPriceMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:102031 请求领取每日任务
---请求领取每日任务
---msgID: 102031
---@param monsterId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAccepNewDailyTask(monsterId)
    local reqTable = {}
    if monsterId ~= nil then
        reqTable.monsterId = monsterId
    end
    local reqMsgData = protobufMgr.Serialize("taskV2.ReqAccepNewDailyTask" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAccepNewDailyTaskMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAccepNewDailyTaskMessage](LuaEnumNetDef.ReqAccepNewDailyTaskMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAccepNewDailyTaskMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAccepNewDailyTaskMessage", 102031, "ReqAccepNewDailyTask", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:102032 请求提交每日任务
---请求提交每日任务
---msgID: 102032
---@param monsterId number 选填参数
---@param double boolean 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSubmitNewDailyTask(monsterId, double)
    local reqTable = {}
    if monsterId ~= nil then
        reqTable.monsterId = monsterId
    end
    if double ~= nil then
        reqTable.double = double
    end
    local reqMsgData = protobufMgr.Serialize("taskV2.ReqSubmitNewDailyTask" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSubmitNewDailyTaskMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSubmitNewDailyTaskMessage](LuaEnumNetDef.ReqSubmitNewDailyTaskMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSubmitNewDailyTaskMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSubmitNewDailyTaskMessage", 102032, "ReqSubmitNewDailyTask", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:102034 请求提交灵魂任务道具
---请求提交灵魂任务道具
---msgID: 102034
---@param taskId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSubmitSoulTaskItem(taskId)
    local reqTable = {}
    if taskId ~= nil then
        reqTable.taskId = taskId
    end
    local reqMsgData = protobufMgr.Serialize("taskV2.SubmitSoulTaskItem" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSubmitSoulTaskItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSubmitSoulTaskItemMessage](LuaEnumNetDef.ReqSubmitSoulTaskItemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSubmitSoulTaskItemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSubmitSoulTaskItemMessage", 102034, "SubmitSoulTaskItem", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:102035 请求领取灵魂任务奖励
---请求领取灵魂任务奖励
---msgID: 102035
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetSoulTaskReward()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetSoulTaskRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetSoulTaskRewardMessage](LuaEnumNetDef.ReqGetSoulTaskRewardMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetSoulTaskRewardMessage, nil, true)
    end
    return canSendMsg
end
--endregion

