--[[本文件为工具自动生成,禁止手动修改]]
--boss.xml

--region ID:30001 请求副本面板信息(通用)
---请求副本面板信息(通用)
---msgID: 30001
---@param insType number 选填参数 副本类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqInstancePanelInfo(insType)
    local reqTable = {}
    if insType ~= nil then
        reqTable.insType = insType
    end
    local reqMsgData = protobufMgr.Serialize("bossV2.ReqInstancePanelInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqInstancePanelInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqInstancePanelInfoMessage](LuaEnumNetDef.ReqInstancePanelInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqInstancePanelInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqInstancePanelInfoMessage", 30001, "ReqInstancePanelInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:30009 请求拾取主线boss奖励
---请求拾取主线boss奖励
---msgID: 30009
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPickUpMainTaskBoss()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPickUpMainTaskBossMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPickUpMainTaskBossMessage](LuaEnumNetDef.ReqPickUpMainTaskBossMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqPickUpMainTaskBossMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:30011 请求扫荡个人副本
---请求扫荡个人副本
---msgID: 30011
---@param instanceId number 选填参数 副本id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSwapPersonalBoss(instanceId)
    local reqTable = {}
    if instanceId ~= nil then
        reqTable.instanceId = instanceId
    end
    local reqMsgData = protobufMgr.Serialize("bossV2.ReqSwapPersonalBoss" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSwapPersonalBossMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSwapPersonalBossMessage](LuaEnumNetDef.ReqSwapPersonalBossMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSwapPersonalBossMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSwapPersonalBossMessage", 30011, "ReqSwapPersonalBoss", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:30016 请求野外boss开启信息
---请求野外boss开启信息
---msgID: 30016
---@param type number 选填参数 怪物类型
---@param subType number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqFieldBossOpen(type, subType)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if subType ~= nil then
        reqTable.subType = subType
    end
    local reqMsgData = protobufMgr.Serialize("bossV2.ReqFieldBossInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqFieldBossOpenMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqFieldBossOpenMessage](LuaEnumNetDef.ReqFieldBossOpenMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqFieldBossOpenMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqFieldBossOpenMessage", 30016, "ReqFieldBossInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:30018 打开小地图请求
---打开小地图请求
---msgID: 30018
---@return boolean 网络请求是否成功发送
function networkRequest.ReqMinMap()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqMinMapMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqMinMapMessage](LuaEnumNetDef.ReqMinMapMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqMinMapMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:30020 请求boss信息
---请求boss信息
---msgID: 30020
---@param id System.Collections.Generic.List1T<number> 列表参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetBossInfo(id)
    local reqData = CS.bossV2.ReqGetBossInfo()
    if id ~= nil then
        reqData.id:AddRange(id)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetBossInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetBossInfoMessage](LuaEnumNetDef.ReqGetBossInfoMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetBossInfoMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:30023 请求远古 boss 伤害排行
---请求远古 boss 伤害排行
---msgID: 30023
---@param bossId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAncientBossDamageRank(bossId)
    local reqTable = {}
    reqTable.bossId = bossId
    local reqMsgData = protobufMgr.Serialize("bossV2.ReqAncientBossDamageRank" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAncientBossDamageRankMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAncientBossDamageRankMessage](LuaEnumNetDef.ReqAncientBossDamageRankMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAncientBossDamageRankMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAncientBossDamageRankMessage", 30023, "ReqAncientBossDamageRank", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:30028 请求联服远古 boss 伤害排行
---请求联服远古 boss 伤害排行
---msgID: 30028
---@param bossId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareAncientBossDamageRank(bossId)
    local reqTable = {}
    reqTable.bossId = bossId
    local reqMsgData = protobufMgr.Serialize("bossV2.ReqAncientBossDamageRank" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareAncientBossDamageRankMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareAncientBossDamageRankMessage](LuaEnumNetDef.ReqShareAncientBossDamageRankMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareAncientBossDamageRankMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareAncientBossDamageRankMessage", 30028, "ReqAncientBossDamageRank", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:30029 请求远古 boss 伤害排行
---请求远古 boss 伤害排行
---msgID: 30029
---@param bossId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAncientBossDamageRankV2(bossId)
    local reqTable = {}
    reqTable.bossId = bossId
    local reqMsgData = protobufMgr.Serialize("bossV2.ReqAncientBossDamageRank" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAncientBossDamageRankV2Message] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAncientBossDamageRankV2Message](LuaEnumNetDef.ReqAncientBossDamageRankV2Message, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAncientBossDamageRankV2Message, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAncientBossDamageRankV2Message", 30029, "ReqAncientBossDamageRank", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:30030 请求天魔boss信息
---请求天魔boss信息
---msgID: 30030
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOmenComeBossInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOmenComeBossInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOmenComeBossInfoMessage](LuaEnumNetDef.ReqOmenComeBossInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqOmenComeBossInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:30032 请求使用扫荡券
---请求使用扫荡券
---msgID: 30032
---@param type number 选填参数 类型
---@param theId number 选填参数 对应逻辑的ID
---@param monsterId number 选填参数 宗师任务要完成的怪物ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUseMonsterCleanUpCoupons(type, theId, monsterId)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if theId ~= nil then
        reqTable.theId = theId
    end
    if monsterId ~= nil then
        reqTable.monsterId = monsterId
    end
    local reqMsgData = protobufMgr.Serialize("bossV2.ReqUseMonsterCleanUpCoupons" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUseMonsterCleanUpCouponsMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUseMonsterCleanUpCouponsMessage](LuaEnumNetDef.ReqUseMonsterCleanUpCouponsMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUseMonsterCleanUpCouponsMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUseMonsterCleanUpCouponsMessage", 30032, "ReqUseMonsterCleanUpCoupons", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

