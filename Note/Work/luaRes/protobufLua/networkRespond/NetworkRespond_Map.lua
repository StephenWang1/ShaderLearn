--[[本文件为工具自动生成,禁止手动修改]]
--map.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---玩家进入地图
---msgID: 67009
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResPlayerEnterMap C#数据结构
function networkRespond.OnResPlayerEnterMapMessageReceived(msgID)
    ---@type mapV2.ResPlayerEnterMap
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67009 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67009 mapV2.ResPlayerEnterMap 玩家进入地图")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.ResPlayerEnterMap ~= nil then
        csData = protobufMgr.DecodeTable.map.ResPlayerEnterMap(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---玩家切换地图
---msgID: 67010
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResPlayerChangeMap C#数据结构
function networkRespond.OnResPlayerChangeMapMessageReceived(msgID)
    ---@type mapV2.ResPlayerChangeMap
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67010 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67010 mapV2.ResPlayerChangeMap 玩家切换地图")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.ResPlayerChangeMap ~= nil then
        csData = protobufMgr.DecodeTable.map.ResPlayerChangeMap(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---切换位置
---msgID: 67011
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResChangePos C#数据结构
function networkRespond.OnResChangePosMessageReceived(msgID)
    ---@type mapV2.ResChangePos
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67011 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67011 mapV2.ResChangePos 切换位置")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.ResChangePos ~= nil then
        csData = protobufMgr.DecodeTable.map.ResChangePos(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---对象复活
---msgID: 67014
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResRelive C#数据结构
function networkRespond.OnResReliveMessageReceived(msgID)
    ---@type mapV2.ResRelive
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67014 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67014 mapV2.ResRelive 对象复活")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.ResRelive ~= nil then
        csData = protobufMgr.DecodeTable.map.ResRelive(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---玩家尝试进入地图
---msgID: 67018
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResTryEnterMap C#数据结构
function networkRespond.OnResTryEnterMapMessageReceived(msgID)
    ---@type mapV2.ResTryEnterMap
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67018 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67018 mapV2.ResTryEnterMap 玩家尝试进入地图")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.ResTryEnterMap ~= nil then
        csData = protobufMgr.DecodeTable.map.ResTryEnterMap(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---同步boss和玩家总血量信息
---msgID: 67021
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResPerformTotalHp C#数据结构
function networkRespond.OnResPerformTotalHpMessageReceived(msgID)
    ---@type duplicateV2.ResPerformTotalHp
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67021 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67021 duplicateV2.ResPerformTotalHp 同步boss和玩家总血量信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResPerformTotalHpMessage", 67021, "ResPerformTotalHp", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---玩家行会变化
---msgID: 67024
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResPlayerUnionChange C#数据结构
function networkRespond.OnResPlayerUnionChangeMessageReceived(msgID)
    ---@type mapV2.ResPlayerUnionChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67024 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67024 mapV2.ResPlayerUnionChange 玩家行会变化")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResPlayerUnionChangeMessage", 67024, "ResPlayerUnionChange", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回选择攻击模式
---msgID: 67030
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResSwitchFightModel C#数据结构
function networkRespond.OnResSwitchFightModelMessageReceived(msgID)
    ---@type mapV2.ResSwitchFightModel
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67030 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67030 mapV2.ResSwitchFightModel 返回选择攻击模式")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSwitchFightModelMessage", 67030, "ResSwitchFightModel", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回采集数据
---msgID: 67043
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResGatherState C#数据结构
function networkRespond.OnResGatherMessageReceived(msgID)
    ---@type mapV2.ResGatherState
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67043 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67043 mapV2.ResGatherState 返回采集数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.ResGatherState ~= nil then
        csData = protobufMgr.DecodeTable.map.ResGatherState(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---怪物归属改变
---msgID: 67051
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.RoundMonsterInfo C#数据结构
function networkRespond.OnResMonsterOwnerChangedMessageReceived(msgID)
    ---@type mapV2.RoundMonsterInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67051 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67051 mapV2.RoundMonsterInfo 怪物归属改变")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.RoundMonsterInfo ~= nil then
        csData = protobufMgr.DecodeTable.map.RoundMonsterInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回生肖npc信息
---msgID: 67054
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResAnimalNPCInfo C#数据结构
function networkRespond.OnResAnimalNPCInfoMessageReceived(msgID)
    ---@type mapV2.ResAnimalNPCInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67054 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67054 mapV2.ResAnimalNPCInfo 返回生肖npc信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResAnimalNPCInfoMessage", 67054, "ResAnimalNPCInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回天怒神像信息
---msgID: 67056
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResSkyAngerGodInfo C#数据结构
function networkRespond.OnResSkyAngerGodInfoMessageReceived(msgID)
    ---@type mapV2.ResSkyAngerGodInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67056 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67056 mapV2.ResSkyAngerGodInfo 返回天怒神像信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSkyAngerGodInfoMessage", 67056, "ResSkyAngerGodInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---发送进入人数改变信息
---msgID: 67057
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.EnterNumRefresh C#数据结构
function networkRespond.OnResEnterNumRefreshMessageReceived(msgID)
    ---@type mapV2.EnterNumRefresh
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67057 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67057 mapV2.EnterNumRefresh 发送进入人数改变信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResEnterNumRefreshMessage", 67057, "EnterNumRefresh", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---玩家信息改变
---msgID: 67059
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.RoundPlayerInfo C#数据结构
function networkRespond.OnResPlayerModChangeMessageReceived(msgID)
    ---@type mapV2.RoundPlayerInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67059 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67059 mapV2.RoundPlayerInfo 玩家信息改变")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.RoundPlayerInfo ~= nil then
        csData = protobufMgr.DecodeTable.map.RoundPlayerInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送合体特效给周围玩家
---msgID: 67060
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResServantInfo C#数据结构
function networkRespond.OnResServantCombineEffectMessageReceived(msgID)
    ---@type mapV2.ResServantInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67060 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67060 mapV2.ResServantInfo 发送合体特效给周围玩家")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.ResServantInfo ~= nil then
        csData = protobufMgr.DecodeTable.map.ResServantInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---门票不足弹出快捷购买面板
---msgID: 67061
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResTheTokenNotEnough C#数据结构
function networkRespond.OnResTheTokenNotEnoughMessageReceived(msgID)
    ---@type mapV2.ResTheTokenNotEnough
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67061 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67061 mapV2.ResTheTokenNotEnough 门票不足弹出快捷购买面板")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.ResTheTokenNotEnough ~= nil then
        csData = protobufMgr.DecodeTable.map.ResTheTokenNotEnough(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---摊位进入视野
---msgID: 67063
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResBoothEnterView C#数据结构
function networkRespond.OnResBoothEnterViewMessageReceived(msgID)
    ---@type mapV2.ResBoothEnterView
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67063 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67063 mapV2.ResBoothEnterView 摊位进入视野")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.ResBoothEnterView ~= nil then
        csData = protobufMgr.DecodeTable.map.ResBoothEnterView(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回挖矿衰减开始信息
---msgID: 67064
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResStartMining C#数据结构
function networkRespond.OnResStartMiningMessageReceived(msgID)
    ---@type mapV2.ResStartMining
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67064 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67064 mapV2.ResStartMining 返回挖矿衰减开始信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResStartMiningMessage", 67064, "ResStartMining", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回体力改变的消息
---msgID: 67065
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResChangeSpirit C#数据结构
function networkRespond.OnResChangeSpiritMessageReceived(msgID)
    ---@type mapV2.ResChangeSpirit
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67065 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67065 mapV2.ResChangeSpirit 返回体力改变的消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResChangeSpiritMessage", 67065, "ResChangeSpirit", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---行会镖车更新信息包
---msgID: 67069
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResUpdateUnionCartInfo C#数据结构
function networkRespond.OnResUpdateUnionCartInfoMessageReceived(msgID)
    ---@type mapV2.ResUpdateUnionCartInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67069 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67069 mapV2.ResUpdateUnionCartInfo 行会镖车更新信息包")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.ResUpdateUnionCartInfo ~= nil then
        csData = protobufMgr.DecodeTable.map.ResUpdateUnionCartInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回玩家的仲裁信息
---msgID: 67071
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.reqDropProtect C#数据结构
function networkRespond.OnResDropProtectMessageReceived(msgID)
    ---@type mapV2.reqDropProtect
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67071 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67071 mapV2.reqDropProtect 返回玩家的仲裁信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.reqDropProtect ~= nil then
        csData = protobufMgr.DecodeTable.map.reqDropProtect(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回玩家的仲裁小红点信息
---msgID: 67076
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.dropProtectNotice C#数据结构
function networkRespond.OnResDropProtectNoticeMessageReceived(msgID)
    ---@type mapV2.dropProtectNotice
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67076 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67076 mapV2.dropProtectNotice 返回玩家的仲裁小红点信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.dropProtectNotice ~= nil then
        csData = protobufMgr.DecodeTable.map.dropProtectNotice(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送矿工状态
---msgID: 67081
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.MinerActivityType C#数据结构
function networkRespond.OnMinerActivityTypeMessageReceived(msgID)
    ---@type mapV2.MinerActivityType
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67081 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67081 mapV2.MinerActivityType 发送矿工状态")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.MinerActivityType ~= nil then
        csData = protobufMgr.DecodeTable.map.MinerActivityType(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---查看NPC上玩家的领取排行
---msgID: 67086
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResReceiveRankingForNpc C#数据结构
function networkRespond.OnResReceiveRankingForNpcMessageReceived(msgID)
    ---@type mapV2.ResReceiveRankingForNpc
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67086 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67086 mapV2.ResReceiveRankingForNpc 查看NPC上玩家的领取排行")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.ResReceiveRankingForNpc ~= nil then
        csData = protobufMgr.DecodeTable.map.ResReceiveRankingForNpc(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送神医满状态消息
---msgID: 67090
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResDoctorRecover C#数据结构
function networkRespond.OnResDoctorHealthMessageReceived(msgID)
    ---@type mapV2.ResDoctorRecover
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67090 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67090 mapV2.ResDoctorRecover 发送神医满状态消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResDoctorHealthMessage", 67090, "ResDoctorRecover", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---发送多数量特效
---msgID: 67091
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.MultiItemEffect C#数据结构
function networkRespond.OnResMultiItemEffectMessageReceived(msgID)
    ---@type mapV2.MultiItemEffect
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67091 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67091 mapV2.MultiItemEffect 发送多数量特效")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.MultiItemEffect ~= nil then
        csData = protobufMgr.DecodeTable.map.MultiItemEffect(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---玩家死亡掉落物品信息
---msgID: 67097
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResPlayerDropInfo C#数据结构
function networkRespond.OnResPlayerDieDropItemInfoMessageReceived(msgID)
    ---@type mapV2.ResPlayerDropInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67097 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67097 mapV2.ResPlayerDropInfo 玩家死亡掉落物品信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResPlayerDieDropItemInfoMessage", 67097, "ResPlayerDropInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---千年树妖刷新消息
---msgID: 67098
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.TreeMonsterRefreshCall C#数据结构
function networkRespond.OnResTreeMonsterRefreshMessageReceived(msgID)
    ---@type mapV2.TreeMonsterRefreshCall
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67098 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67098 mapV2.TreeMonsterRefreshCall 千年树妖刷新消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.TreeMonsterRefreshCall ~= nil then
        csData = protobufMgr.DecodeTable.map.TreeMonsterRefreshCall(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---响应传送到千年树妖
---msgID: 67100
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.DeliverTreeMonsterResult C#数据结构
function networkRespond.OnResDeliverTreeMonsterMessageReceived(msgID)
    ---@type mapV2.DeliverTreeMonsterResult
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67100 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67100 mapV2.DeliverTreeMonsterResult 响应传送到千年树妖")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.DeliverTreeMonsterResult ~= nil then
        csData = protobufMgr.DecodeTable.map.DeliverTreeMonsterResult(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---元灵修炼进入视野
---msgID: 67101
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResServantCultivateEnterView C#数据结构
function networkRespond.OnResServantCultivateEnterViewMessageReceived(msgID)
    ---@type mapV2.ResServantCultivateEnterView
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67101 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67101 mapV2.ResServantCultivateEnterView 元灵修炼进入视野")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.ResServantCultivateEnterView ~= nil then
        csData = protobufMgr.DecodeTable.map.ResServantCultivateEnterView(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---通知客户端魔之boss倒计时开始
---msgID: 67103
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResDemonBossInfo C#数据结构
function networkRespond.OnResDemonBossInfoMessageReceived(msgID)
    ---@type mapV2.ResDemonBossInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67103 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67103 mapV2.ResDemonBossInfo 通知客户端魔之boss倒计时开始")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResDemonBossInfoMessage", 67103, "ResDemonBossInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---魔之boss总次数
---msgID: 67104
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResDemonBossHasCount C#数据结构
function networkRespond.OnResDemonBossHasCountMessageReceived(msgID)
    ---@type mapV2.ResDemonBossHasCount
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67104 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67104 mapV2.ResDemonBossHasCount 魔之boss总次数")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResDemonBossHasCountMessage", 67104, "ResDemonBossHasCount", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---魔之boss次数更新
---msgID: 67105
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResDemonBossUpdateHasCount C#数据结构
function networkRespond.OnResDemonBossUpdateHasCountMessageReceived(msgID)
    ---@type mapV2.ResDemonBossUpdateHasCount
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67105 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67105 mapV2.ResDemonBossUpdateHasCount 魔之boss次数更新")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResDemonBossUpdateHasCountMessage", 67105, "ResDemonBossUpdateHasCount", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---拉令失败返回冷却结束时间
---msgID: 67107
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResDemonBossHelpFailure C#数据结构
function networkRespond.OnResDemonBossHelpFailureMessageReceived(msgID)
    ---@type mapV2.ResDemonBossHelpFailure
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67107 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67107 mapV2.ResDemonBossHelpFailure 拉令失败返回冷却结束时间")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResDemonBossHelpFailureMessage", 67107, "ResDemonBossHelpFailure", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---弹出拉令面板
---msgID: 67108
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResDemonBossHelpToPeople C#数据结构
function networkRespond.OnResDemonBossHelpToPeopleMessageReceived(msgID)
    ---@type mapV2.ResDemonBossHelpToPeople
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67108 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67108 mapV2.ResDemonBossHelpToPeople 弹出拉令面板")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResDemonBossHelpToPeopleMessage", 67108, "ResDemonBossHelpToPeople", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---魔之boss死亡时可领取按钮
---msgID: 67110
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.DemonDieCanReward C#数据结构
function networkRespond.OnDemonDieCanRewardMessageReceived(msgID)
    ---@type mapV2.DemonDieCanReward
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67110 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67110 mapV2.DemonDieCanReward 魔之boss死亡时可领取按钮")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("DemonDieCanRewardMessage", 67110, "DemonDieCanReward", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---进入视野告诉客户端魔之boss剩余时间
---msgID: 67112
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.DemonBossEndTime C#数据结构
function networkRespond.OnDemonBossEndTimeMessageReceived(msgID)
    ---@type mapV2.DemonBossEndTime
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67112 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67112 mapV2.DemonBossEndTime 进入视野告诉客户端魔之boss剩余时间")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("DemonBossEndTimeMessage", 67112, "DemonBossEndTime", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---神之boss信息
---msgID: 67113
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResGodBossInfo C#数据结构
function networkRespond.OnResGodBossInfoMessageReceived(msgID)
    ---@type mapV2.ResGodBossInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67113 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67113 mapV2.ResGodBossInfo 神之boss信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResGodBossInfoMessage", 67113, "ResGodBossInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---联服封印塔加伤假buff消息
---msgID: 67114
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResSealTowerAddDamage C#数据结构
function networkRespond.OnResSealTowerAddDamageMessageReceived(msgID)
    ---@type mapV2.ResSealTowerAddDamage
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67114 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67114 mapV2.ResSealTowerAddDamage 联服封印塔加伤假buff消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSealTowerAddDamageMessage", 67114, "ResSealTowerAddDamage", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---烤篝火跳字
---msgID: 67116
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.BonfireAddExp C#数据结构
function networkRespond.OnResBonfireAddExpMessageReceived(msgID)
    ---@type mapV2.BonfireAddExp
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67116 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67116 mapV2.BonfireAddExp 烤篝火跳字")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResBonfireAddExpMessage", 67116, "BonfireAddExp", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回篝火信息
---msgID: 67118
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResBonfireInfo C#数据结构
function networkRespond.OnResBonfireInfoMessageReceived(msgID)
    ---@type mapV2.ResBonfireInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67118 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67118 mapV2.ResBonfireInfo 返回篝火信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResBonfireInfoMessage", 67118, "ResBonfireInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回篝火信息
---msgID: 67119
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.PlayerEnterBonfireState C#数据结构
function networkRespond.OnResPlayerEnterBonfireStateMessageReceived(msgID)
    ---@type mapV2.PlayerEnterBonfireState
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67119 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67119 mapV2.PlayerEnterBonfireState 返回篝火信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.map ~= nil and  protobufMgr.DecodeTable.map.PlayerEnterBonfireState ~= nil then
        csData = protobufMgr.DecodeTable.map.PlayerEnterBonfireState(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---使用物品传送到地图
---msgID: 67125
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResUseItemDeliverToMap C#数据结构
function networkRespond.OnResUseItemDeliverToMapMessageReceived(msgID)
    ---@type mapV2.ResUseItemDeliverToMap
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67125 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67125 mapV2.ResUseItemDeliverToMap 使用物品传送到地图")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResUseItemDeliverToMapMessage", 67125, "ResUseItemDeliverToMap", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回活动地图信息
---msgID: 67130
---@param msgID LuaEnumNetDef 消息ID
---@return mapV2.ResActivityMapInfo C#数据结构
function networkRespond.OnResActivityMapInfoMessageReceived(msgID)
    ---@type mapV2.ResActivityMapInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 67130 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 67130 mapV2.ResActivityMapInfo 返回活动地图信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResActivityMapInfoMessage", 67130, "ResActivityMapInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

