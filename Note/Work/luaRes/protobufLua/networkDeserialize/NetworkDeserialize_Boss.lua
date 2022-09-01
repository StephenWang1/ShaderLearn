--[[本文件为工具自动生成,禁止手动修改]]
--boss.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---个人BOSS面板信息
---msgID: 30002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPersonalBossInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 30002 bossV2.ResPersonalBossInfo 个人BOSS面板信息")
        return nil
    end
    local res = protobufMgr.Deserialize("bossV2.ResPersonalBossInfo", buffer)
    if protoAdjust.boss_adj ~= nil and protoAdjust.boss_adj.AdjustResPersonalBossInfo ~= nil then
        protoAdjust.boss_adj.AdjustResPersonalBossInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 30002
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送boss活动开启信息
---msgID: 30015
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBossActivityOpenMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 30015 bossV2.ResBossActivityOpen 发送boss活动开启信息")
        return nil
    end
    local res = protobufMgr.Deserialize("bossV2.ResBossActivityOpen", buffer)
    if protoAdjust.boss_adj ~= nil and protoAdjust.boss_adj.AdjustResBossActivityOpen ~= nil then
        protoAdjust.boss_adj.AdjustResBossActivityOpen(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 30015
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送野外boss开启信息
---msgID: 30017
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResFieldBossOpenMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 30017 bossV2.ResFieldBossInfo 发送野外boss开启信息")
        return nil
    end
    local res = protobufMgr.Deserialize("bossV2.ResFieldBossInfo", buffer)
    if protoAdjust.boss_adj ~= nil and protoAdjust.boss_adj.AdjustResFieldBossInfo ~= nil then
        protoAdjust.boss_adj.AdjustResFieldBossInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 30017
    protobufMgr.mMsgDeserializedTblCache = res
end

---打开小地图返回信息
---msgID: 30019
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMinMapMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 30019 bossV2.ResMinMapInfo 打开小地图返回信息")
        return nil
    end
    local res = protobufMgr.Deserialize("bossV2.ResMinMapInfo", buffer)
    if protoAdjust.boss_adj ~= nil and protoAdjust.boss_adj.AdjustResMinMapInfo ~= nil then
        protoAdjust.boss_adj.AdjustResMinMapInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 30019
    protobufMgr.mMsgDeserializedTblCache = res
end

---boss信息响应
---msgID: 30021
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetBossInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 30021 bossV2.ResGetBossInfo boss信息响应")
        return nil
    end
    local res = protobufMgr.Deserialize("bossV2.ResGetBossInfo", buffer)
    if protoAdjust.boss_adj ~= nil and protoAdjust.boss_adj.AdjustResGetBossInfo ~= nil then
        protoAdjust.boss_adj.AdjustResGetBossInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 30021
    protobufMgr.mMsgDeserializedTblCache = res
end

---boss刷新提示
---msgID: 30022
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBossRefreshMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 30022 bossV2.ResBossRefresh boss刷新提示")
        return nil
    end
    local res = protobufMgr.Deserialize("bossV2.ResBossRefresh", buffer)
    if protoAdjust.boss_adj ~= nil and protoAdjust.boss_adj.AdjustResBossRefresh ~= nil then
        protoAdjust.boss_adj.AdjustResBossRefresh(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 30022
    protobufMgr.mMsgDeserializedTblCache = res
end

---远古 boss 伤害排行响应
---msgID: 30024
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAncientBossDamageRankMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 30024 bossV2.ResAncientBossDamageRank 远古 boss 伤害排行响应")
        return nil
    end
    local res = protobufMgr.Deserialize("bossV2.ResAncientBossDamageRank", buffer)
    if protoAdjust.boss_adj ~= nil and protoAdjust.boss_adj.AdjustResAncientBossDamageRank ~= nil then
        protoAdjust.boss_adj.AdjustResAncientBossDamageRank(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 30024
    protobufMgr.mMsgDeserializedTblCache = res
end

---是否有远古 boss 存活
---msgID: 30026
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResHasAncientBossAliveMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 30026 bossV2.ResHasAncientBossAlive 是否有远古 boss 存活")
        return nil
    end
    local res = protobufMgr.Deserialize("bossV2.ResHasAncientBossAlive", buffer)
    if protoAdjust.boss_adj ~= nil and protoAdjust.boss_adj.AdjustResHasAncientBossAlive ~= nil then
        protoAdjust.boss_adj.AdjustResHasAncientBossAlive(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 30026
    protobufMgr.mMsgDeserializedTblCache = res
end

---boss面板魔之boss红点
---msgID: 30027
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnRefreshDemonBossInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 30027 bossV2.RefreshDemonBossInfo boss面板魔之boss红点")
        return nil
    end
    local res = protobufMgr.Deserialize("bossV2.RefreshDemonBossInfo", buffer)
    if protoAdjust.boss_adj ~= nil and protoAdjust.boss_adj.AdjustRefreshDemonBossInfo ~= nil then
        protoAdjust.boss_adj.AdjustRefreshDemonBossInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 30027
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回天魔boss信息
---msgID: 30031
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOmenComeBossInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 30031 bossV2.ResOmenComeBossInfo 返回天魔boss信息")
        return nil
    end
    local res = protobufMgr.Deserialize("bossV2.ResOmenComeBossInfo", buffer)
    if protoAdjust.boss_adj ~= nil and protoAdjust.boss_adj.AdjustResOmenComeBossInfo ~= nil then
        protoAdjust.boss_adj.AdjustResOmenComeBossInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 30031
    protobufMgr.mMsgDeserializedTblCache = res
end

