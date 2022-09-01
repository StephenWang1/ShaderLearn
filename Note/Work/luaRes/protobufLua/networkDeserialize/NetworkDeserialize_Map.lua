--[[本文件为工具自动生成,禁止手动修改]]
--map.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---玩家进入地图
---msgID: 67009
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPlayerEnterMapMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67009 mapV2.ResPlayerEnterMap 玩家进入地图")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResPlayerEnterMap", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResPlayerEnterMap ~= nil then
        protoAdjust.map_adj.AdjustResPlayerEnterMap(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67009
    protobufMgr.mMsgDeserializedTblCache = res
end

---玩家切换地图
---msgID: 67010
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPlayerChangeMapMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67010 mapV2.ResPlayerChangeMap 玩家切换地图")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResPlayerChangeMap", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResPlayerChangeMap ~= nil then
        protoAdjust.map_adj.AdjustResPlayerChangeMap(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67010
    protobufMgr.mMsgDeserializedTblCache = res
end

---切换位置
---msgID: 67011
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResChangePosMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67011 mapV2.ResChangePos 切换位置")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResChangePos", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResChangePos ~= nil then
        protoAdjust.map_adj.AdjustResChangePos(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67011
    protobufMgr.mMsgDeserializedTblCache = res
end

---对象复活
---msgID: 67014
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResReliveMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67014 mapV2.ResRelive 对象复活")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResRelive", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResRelive ~= nil then
        protoAdjust.map_adj.AdjustResRelive(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67014
    protobufMgr.mMsgDeserializedTblCache = res
end

---玩家尝试进入地图
---msgID: 67018
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTryEnterMapMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67018 mapV2.ResTryEnterMap 玩家尝试进入地图")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResTryEnterMap", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResTryEnterMap ~= nil then
        protoAdjust.map_adj.AdjustResTryEnterMap(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67018
    protobufMgr.mMsgDeserializedTblCache = res
end

---同步boss和玩家总血量信息
---msgID: 67021
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPerformTotalHpMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67021 duplicateV2.ResPerformTotalHp 同步boss和玩家总血量信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResPerformTotalHp", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResPerformTotalHp ~= nil then
        protoAdjust.duplicate_adj.AdjustResPerformTotalHp(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67021
    protobufMgr.mMsgDeserializedTblCache = res
end

---玩家行会变化
---msgID: 67024
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPlayerUnionChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67024 mapV2.ResPlayerUnionChange 玩家行会变化")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResPlayerUnionChange", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResPlayerUnionChange ~= nil then
        protoAdjust.map_adj.AdjustResPlayerUnionChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67024
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回选择攻击模式
---msgID: 67030
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSwitchFightModelMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67030 mapV2.ResSwitchFightModel 返回选择攻击模式")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResSwitchFightModel", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResSwitchFightModel ~= nil then
        protoAdjust.map_adj.AdjustResSwitchFightModel(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67030
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回采集数据
---msgID: 67043
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGatherMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67043 mapV2.ResGatherState 返回采集数据")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResGatherState", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResGatherState ~= nil then
        protoAdjust.map_adj.AdjustResGatherState(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67043
    protobufMgr.mMsgDeserializedTblCache = res
end

---怪物归属改变
---msgID: 67051
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMonsterOwnerChangedMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67051 mapV2.RoundMonsterInfo 怪物归属改变")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.RoundMonsterInfo", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustRoundMonsterInfo ~= nil then
        protoAdjust.map_adj.AdjustRoundMonsterInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67051
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回生肖npc信息
---msgID: 67054
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAnimalNPCInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67054 mapV2.ResAnimalNPCInfo 返回生肖npc信息")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResAnimalNPCInfo", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResAnimalNPCInfo ~= nil then
        protoAdjust.map_adj.AdjustResAnimalNPCInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67054
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回天怒神像信息
---msgID: 67056
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSkyAngerGodInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67056 mapV2.ResSkyAngerGodInfo 返回天怒神像信息")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResSkyAngerGodInfo", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResSkyAngerGodInfo ~= nil then
        protoAdjust.map_adj.AdjustResSkyAngerGodInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67056
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送进入人数改变信息
---msgID: 67057
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResEnterNumRefreshMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67057 mapV2.EnterNumRefresh 发送进入人数改变信息")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.EnterNumRefresh", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustEnterNumRefresh ~= nil then
        protoAdjust.map_adj.AdjustEnterNumRefresh(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67057
    protobufMgr.mMsgDeserializedTblCache = res
end

---玩家信息改变
---msgID: 67059
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPlayerModChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67059 mapV2.RoundPlayerInfo 玩家信息改变")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.RoundPlayerInfo", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustRoundPlayerInfo ~= nil then
        protoAdjust.map_adj.AdjustRoundPlayerInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67059
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送合体特效给周围玩家
---msgID: 67060
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResServantCombineEffectMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67060 mapV2.ResServantInfo 发送合体特效给周围玩家")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResServantInfo", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResServantInfo ~= nil then
        protoAdjust.map_adj.AdjustResServantInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67060
    protobufMgr.mMsgDeserializedTblCache = res
end

---门票不足弹出快捷购买面板
---msgID: 67061
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTheTokenNotEnoughMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67061 mapV2.ResTheTokenNotEnough 门票不足弹出快捷购买面板")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResTheTokenNotEnough", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResTheTokenNotEnough ~= nil then
        protoAdjust.map_adj.AdjustResTheTokenNotEnough(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67061
    protobufMgr.mMsgDeserializedTblCache = res
end

---摊位进入视野
---msgID: 67063
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBoothEnterViewMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67063 mapV2.ResBoothEnterView 摊位进入视野")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResBoothEnterView", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResBoothEnterView ~= nil then
        protoAdjust.map_adj.AdjustResBoothEnterView(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67063
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回挖矿衰减开始信息
---msgID: 67064
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResStartMiningMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67064 mapV2.ResStartMining 返回挖矿衰减开始信息")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResStartMining", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResStartMining ~= nil then
        protoAdjust.map_adj.AdjustResStartMining(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67064
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回体力改变的消息
---msgID: 67065
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResChangeSpiritMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67065 mapV2.ResChangeSpirit 返回体力改变的消息")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResChangeSpirit", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResChangeSpirit ~= nil then
        protoAdjust.map_adj.AdjustResChangeSpirit(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67065
    protobufMgr.mMsgDeserializedTblCache = res
end

---行会镖车更新信息包
---msgID: 67069
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUpdateUnionCartInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67069 mapV2.ResUpdateUnionCartInfo 行会镖车更新信息包")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResUpdateUnionCartInfo", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResUpdateUnionCartInfo ~= nil then
        protoAdjust.map_adj.AdjustResUpdateUnionCartInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67069
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回玩家的仲裁信息
---msgID: 67071
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDropProtectMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67071 mapV2.reqDropProtect 返回玩家的仲裁信息")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.reqDropProtect", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustreqDropProtect ~= nil then
        protoAdjust.map_adj.AdjustreqDropProtect(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67071
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回玩家的仲裁小红点信息
---msgID: 67076
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDropProtectNoticeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67076 mapV2.dropProtectNotice 返回玩家的仲裁小红点信息")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.dropProtectNotice", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustdropProtectNotice ~= nil then
        protoAdjust.map_adj.AdjustdropProtectNotice(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67076
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送矿工状态
---msgID: 67081
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnMinerActivityTypeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67081 mapV2.MinerActivityType 发送矿工状态")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.MinerActivityType", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustMinerActivityType ~= nil then
        protoAdjust.map_adj.AdjustMinerActivityType(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67081
    protobufMgr.mMsgDeserializedTblCache = res
end

---查看NPC上玩家的领取排行
---msgID: 67086
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResReceiveRankingForNpcMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67086 mapV2.ResReceiveRankingForNpc 查看NPC上玩家的领取排行")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResReceiveRankingForNpc", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResReceiveRankingForNpc ~= nil then
        protoAdjust.map_adj.AdjustResReceiveRankingForNpc(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67086
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送神医满状态消息
---msgID: 67090
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDoctorHealthMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67090 mapV2.ResDoctorRecover 发送神医满状态消息")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResDoctorRecover", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResDoctorRecover ~= nil then
        protoAdjust.map_adj.AdjustResDoctorRecover(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67090
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送多数量特效
---msgID: 67091
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMultiItemEffectMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67091 mapV2.MultiItemEffect 发送多数量特效")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.MultiItemEffect", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustMultiItemEffect ~= nil then
        protoAdjust.map_adj.AdjustMultiItemEffect(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67091
    protobufMgr.mMsgDeserializedTblCache = res
end

---玩家死亡掉落物品信息
---msgID: 67097
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPlayerDieDropItemInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67097 mapV2.ResPlayerDropInfo 玩家死亡掉落物品信息")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResPlayerDropInfo", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResPlayerDropInfo ~= nil then
        protoAdjust.map_adj.AdjustResPlayerDropInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67097
    protobufMgr.mMsgDeserializedTblCache = res
end

---千年树妖刷新消息
---msgID: 67098
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTreeMonsterRefreshMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67098 mapV2.TreeMonsterRefreshCall 千年树妖刷新消息")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.TreeMonsterRefreshCall", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustTreeMonsterRefreshCall ~= nil then
        protoAdjust.map_adj.AdjustTreeMonsterRefreshCall(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67098
    protobufMgr.mMsgDeserializedTblCache = res
end

---响应传送到千年树妖
---msgID: 67100
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDeliverTreeMonsterMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67100 mapV2.DeliverTreeMonsterResult 响应传送到千年树妖")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.DeliverTreeMonsterResult", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustDeliverTreeMonsterResult ~= nil then
        protoAdjust.map_adj.AdjustDeliverTreeMonsterResult(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67100
    protobufMgr.mMsgDeserializedTblCache = res
end

---元灵修炼进入视野
---msgID: 67101
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResServantCultivateEnterViewMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67101 mapV2.ResServantCultivateEnterView 元灵修炼进入视野")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResServantCultivateEnterView", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResServantCultivateEnterView ~= nil then
        protoAdjust.map_adj.AdjustResServantCultivateEnterView(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67101
    protobufMgr.mMsgDeserializedTblCache = res
end

---通知客户端魔之boss倒计时开始
---msgID: 67103
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDemonBossInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67103 mapV2.ResDemonBossInfo 通知客户端魔之boss倒计时开始")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResDemonBossInfo", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResDemonBossInfo ~= nil then
        protoAdjust.map_adj.AdjustResDemonBossInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67103
    protobufMgr.mMsgDeserializedTblCache = res
end

---魔之boss总次数
---msgID: 67104
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDemonBossHasCountMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67104 mapV2.ResDemonBossHasCount 魔之boss总次数")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResDemonBossHasCount", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResDemonBossHasCount ~= nil then
        protoAdjust.map_adj.AdjustResDemonBossHasCount(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67104
    protobufMgr.mMsgDeserializedTblCache = res
end

---魔之boss次数更新
---msgID: 67105
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDemonBossUpdateHasCountMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67105 mapV2.ResDemonBossUpdateHasCount 魔之boss次数更新")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResDemonBossUpdateHasCount", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResDemonBossUpdateHasCount ~= nil then
        protoAdjust.map_adj.AdjustResDemonBossUpdateHasCount(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67105
    protobufMgr.mMsgDeserializedTblCache = res
end

---拉令失败返回冷却结束时间
---msgID: 67107
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDemonBossHelpFailureMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67107 mapV2.ResDemonBossHelpFailure 拉令失败返回冷却结束时间")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResDemonBossHelpFailure", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResDemonBossHelpFailure ~= nil then
        protoAdjust.map_adj.AdjustResDemonBossHelpFailure(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67107
    protobufMgr.mMsgDeserializedTblCache = res
end

---弹出拉令面板
---msgID: 67108
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDemonBossHelpToPeopleMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67108 mapV2.ResDemonBossHelpToPeople 弹出拉令面板")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResDemonBossHelpToPeople", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResDemonBossHelpToPeople ~= nil then
        protoAdjust.map_adj.AdjustResDemonBossHelpToPeople(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67108
    protobufMgr.mMsgDeserializedTblCache = res
end

---魔之boss死亡时可领取按钮
---msgID: 67110
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnDemonDieCanRewardMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67110 mapV2.DemonDieCanReward 魔之boss死亡时可领取按钮")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.DemonDieCanReward", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustDemonDieCanReward ~= nil then
        protoAdjust.map_adj.AdjustDemonDieCanReward(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67110
    protobufMgr.mMsgDeserializedTblCache = res
end

---进入视野告诉客户端魔之boss剩余时间
---msgID: 67112
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnDemonBossEndTimeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67112 mapV2.DemonBossEndTime 进入视野告诉客户端魔之boss剩余时间")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.DemonBossEndTime", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustDemonBossEndTime ~= nil then
        protoAdjust.map_adj.AdjustDemonBossEndTime(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67112
    protobufMgr.mMsgDeserializedTblCache = res
end

---神之boss信息
---msgID: 67113
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGodBossInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67113 mapV2.ResGodBossInfo 神之boss信息")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResGodBossInfo", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResGodBossInfo ~= nil then
        protoAdjust.map_adj.AdjustResGodBossInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67113
    protobufMgr.mMsgDeserializedTblCache = res
end

---联服封印塔加伤假buff消息
---msgID: 67114
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSealTowerAddDamageMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67114 mapV2.ResSealTowerAddDamage 联服封印塔加伤假buff消息")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResSealTowerAddDamage", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResSealTowerAddDamage ~= nil then
        protoAdjust.map_adj.AdjustResSealTowerAddDamage(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67114
    protobufMgr.mMsgDeserializedTblCache = res
end

---烤篝火跳字
---msgID: 67116
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBonfireAddExpMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67116 mapV2.BonfireAddExp 烤篝火跳字")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.BonfireAddExp", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustBonfireAddExp ~= nil then
        protoAdjust.map_adj.AdjustBonfireAddExp(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67116
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回篝火信息
---msgID: 67118
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBonfireInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67118 mapV2.ResBonfireInfo 返回篝火信息")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResBonfireInfo", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResBonfireInfo ~= nil then
        protoAdjust.map_adj.AdjustResBonfireInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67118
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回篝火信息
---msgID: 67119
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPlayerEnterBonfireStateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67119 mapV2.PlayerEnterBonfireState 返回篝火信息")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.PlayerEnterBonfireState", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustPlayerEnterBonfireState ~= nil then
        protoAdjust.map_adj.AdjustPlayerEnterBonfireState(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67119
    protobufMgr.mMsgDeserializedTblCache = res
end

---使用物品传送到地图
---msgID: 67125
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUseItemDeliverToMapMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67125 mapV2.ResUseItemDeliverToMap 使用物品传送到地图")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResUseItemDeliverToMap", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResUseItemDeliverToMap ~= nil then
        protoAdjust.map_adj.AdjustResUseItemDeliverToMap(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67125
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回活动地图信息
---msgID: 67130
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResActivityMapInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 67130 mapV2.ResActivityMapInfo 返回活动地图信息")
        return nil
    end
    local res = protobufMgr.Deserialize("mapV2.ResActivityMapInfo", buffer)
    if protoAdjust.map_adj ~= nil and protoAdjust.map_adj.AdjustResActivityMapInfo ~= nil then
        protoAdjust.map_adj.AdjustResActivityMapInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 67130
    protobufMgr.mMsgDeserializedTblCache = res
end

