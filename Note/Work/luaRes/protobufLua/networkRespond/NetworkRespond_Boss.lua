--[[本文件为工具自动生成,禁止手动修改]]
--boss.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---个人BOSS面板信息
---msgID: 30002
---@param msgID LuaEnumNetDef 消息ID
---@return bossV2.ResPersonalBossInfo C#数据结构
function networkRespond.OnResPersonalBossInfoMessageReceived(msgID)
    ---@type bossV2.ResPersonalBossInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 30002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 30002 bossV2.ResPersonalBossInfo 个人BOSS面板信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResPersonalBossInfoMessage", 30002, "ResPersonalBossInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---发送boss活动开启信息
---msgID: 30015
---@param msgID LuaEnumNetDef 消息ID
---@return bossV2.ResBossActivityOpen C#数据结构
function networkRespond.OnResBossActivityOpenMessageReceived(msgID)
    ---@type bossV2.ResBossActivityOpen
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 30015 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 30015 bossV2.ResBossActivityOpen 发送boss活动开启信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResBossActivityOpenMessage", 30015, "ResBossActivityOpen", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---发送野外boss开启信息
---msgID: 30017
---@param msgID LuaEnumNetDef 消息ID
---@return bossV2.ResFieldBossInfo C#数据结构
function networkRespond.OnResFieldBossOpenMessageReceived(msgID)
    ---@type bossV2.ResFieldBossInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 30017 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 30017 bossV2.ResFieldBossInfo 发送野外boss开启信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.boss ~= nil and  protobufMgr.DecodeTable.boss.ResFieldBossInfo ~= nil then
        csData = protobufMgr.DecodeTable.boss.ResFieldBossInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---打开小地图返回信息
---msgID: 30019
---@param msgID LuaEnumNetDef 消息ID
---@return bossV2.ResMinMapInfo C#数据结构
function networkRespond.OnResMinMapMessageReceived(msgID)
    ---@type bossV2.ResMinMapInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 30019 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 30019 bossV2.ResMinMapInfo 打开小地图返回信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.boss ~= nil and  protobufMgr.DecodeTable.boss.ResMinMapInfo ~= nil then
        csData = protobufMgr.DecodeTable.boss.ResMinMapInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---boss信息响应
---msgID: 30021
---@param msgID LuaEnumNetDef 消息ID
---@return bossV2.ResGetBossInfo C#数据结构
function networkRespond.OnResGetBossInfoMessageReceived(msgID)
    ---@type bossV2.ResGetBossInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 30021 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 30021 bossV2.ResGetBossInfo boss信息响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResGetBossInfoMessage", 30021, "ResGetBossInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---boss刷新提示
---msgID: 30022
---@param msgID LuaEnumNetDef 消息ID
---@return bossV2.ResBossRefresh C#数据结构
function networkRespond.OnResBossRefreshMessageReceived(msgID)
    ---@type bossV2.ResBossRefresh
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 30022 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 30022 bossV2.ResBossRefresh boss刷新提示")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.boss ~= nil and  protobufMgr.DecodeTable.boss.ResBossRefresh ~= nil then
        csData = protobufMgr.DecodeTable.boss.ResBossRefresh(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---远古 boss 伤害排行响应
---msgID: 30024
---@param msgID LuaEnumNetDef 消息ID
---@return bossV2.ResAncientBossDamageRank C#数据结构
function networkRespond.OnResAncientBossDamageRankMessageReceived(msgID)
    ---@type bossV2.ResAncientBossDamageRank
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 30024 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 30024 bossV2.ResAncientBossDamageRank 远古 boss 伤害排行响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.boss ~= nil and  protobufMgr.DecodeTable.boss.ResAncientBossDamageRank ~= nil then
        csData = protobufMgr.DecodeTable.boss.ResAncientBossDamageRank(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---是否有远古 boss 存活
---msgID: 30026
---@param msgID LuaEnumNetDef 消息ID
---@return bossV2.ResHasAncientBossAlive C#数据结构
function networkRespond.OnResHasAncientBossAliveMessageReceived(msgID)
    ---@type bossV2.ResHasAncientBossAlive
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 30026 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 30026 bossV2.ResHasAncientBossAlive 是否有远古 boss 存活")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.boss ~= nil and  protobufMgr.DecodeTable.boss.ResHasAncientBossAlive ~= nil then
        csData = protobufMgr.DecodeTable.boss.ResHasAncientBossAlive(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---boss面板魔之boss红点
---msgID: 30027
---@param msgID LuaEnumNetDef 消息ID
---@return bossV2.RefreshDemonBossInfo C#数据结构
function networkRespond.OnRefreshDemonBossInfoMessageReceived(msgID)
    ---@type bossV2.RefreshDemonBossInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 30027 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 30027 bossV2.RefreshDemonBossInfo boss面板魔之boss红点")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.boss ~= nil and  protobufMgr.DecodeTable.boss.RefreshDemonBossInfo ~= nil then
        csData = protobufMgr.DecodeTable.boss.RefreshDemonBossInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回天魔boss信息
---msgID: 30031
---@param msgID LuaEnumNetDef 消息ID
---@return bossV2.ResOmenComeBossInfo C#数据结构
function networkRespond.OnResOmenComeBossInfoMessageReceived(msgID)
    ---@type bossV2.ResOmenComeBossInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 30031 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 30031 bossV2.ResOmenComeBossInfo 返回天魔boss信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResOmenComeBossInfoMessage", 30031, "ResOmenComeBossInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

