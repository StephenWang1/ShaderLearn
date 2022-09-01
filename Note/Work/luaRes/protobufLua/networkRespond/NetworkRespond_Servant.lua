--[[本文件为工具自动生成,禁止手动修改]]
--servant.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回仆从信息
---msgID: 103001
---@param msgID LuaEnumNetDef 消息ID
---@return servantV2.ResServantInfo C#数据结构
function networkRespond.OnResServantInfoMessageReceived(msgID)
    ---@type servantV2.ResServantInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 103001 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 103001 servantV2.ResServantInfo 返回仆从信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.servant ~= nil and  protobufMgr.DecodeTable.servant.ResServantInfo ~= nil then
        csData = protobufMgr.DecodeTable.servant.ResServantInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---元灵经验更新
---msgID: 103008
---@param msgID LuaEnumNetDef 消息ID
---@return servantV2.ServantExpUpdate C#数据结构
function networkRespond.OnResServantExpUpdateMessageReceived(msgID)
    ---@type servantV2.ServantExpUpdate
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 103008 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 103008 servantV2.ServantExpUpdate 元灵经验更新")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.servant ~= nil and  protobufMgr.DecodeTable.servant.ServantExpUpdate ~= nil then
        csData = protobufMgr.DecodeTable.servant.ServantExpUpdate(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---元灵血量更新
---msgID: 103009
---@param msgID LuaEnumNetDef 消息ID
---@return servantV2.ServantHpUpdate C#数据结构
function networkRespond.OnResServantHpUpdateMessageReceived(msgID)
    ---@type servantV2.ServantHpUpdate
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 103009 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 103009 servantV2.ServantHpUpdate 元灵血量更新")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.servant ~= nil and  protobufMgr.DecodeTable.servant.ServantHpUpdate ~= nil then
        csData = protobufMgr.DecodeTable.servant.ServantHpUpdate(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回元灵名字
---msgID: 103011
---@param msgID LuaEnumNetDef 消息ID
---@return servantV2.ResServantName C#数据结构
function networkRespond.OnResNameMessageReceived(msgID)
    ---@type servantV2.ResServantName
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 103011 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 103011 servantV2.ResServantName 返回元灵名字")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResNameMessage", 103011, "ResServantName", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---灵兽升级包
---msgID: 103012
---@param msgID LuaEnumNetDef 消息ID
---@return servantV2.ResServantLevelUp C#数据结构
function networkRespond.OnResServantLevelUpMessageReceived(msgID)
    ---@type servantV2.ResServantLevelUp
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 103012 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 103012 servantV2.ResServantLevelUp 灵兽升级包")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResServantLevelUpMessage", 103012, "ResServantLevelUp", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---灵兽转生包
---msgID: 103013
---@param msgID LuaEnumNetDef 消息ID
---@return servantV2.ResServantReinUp C#数据结构
function networkRespond.OnResServantReinUpMessageReceived(msgID)
    ---@type servantV2.ResServantReinUp
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 103013 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 103013 servantV2.ResServantReinUp 灵兽转生包")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResServantReinUpMessage", 103013, "ResServantReinUp", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回使用灵兽蛋
---msgID: 103014
---@param msgID LuaEnumNetDef 消息ID
---@return servantV2.ResServantName C#数据结构
function networkRespond.OnResUseServantEggMessageReceived(msgID)
    ---@type servantV2.ResServantName
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 103014 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 103014 servantV2.ResServantName 返回使用灵兽蛋")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResUseServantEggMessage", 103014, "ResServantName", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回他人灵兽信息
---msgID: 103016
---@param msgID LuaEnumNetDef 消息ID
---@return servantV2.ResOtherServantInfo C#数据结构
function networkRespond.OnResOtherServantInfoMessageReceived(msgID)
    ---@type servantV2.ResOtherServantInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 103016 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 103016 servantV2.ResOtherServantInfo 返回他人灵兽信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.servant ~= nil and  protobufMgr.DecodeTable.servant.ResOtherServantInfo ~= nil then
        csData = protobufMgr.DecodeTable.servant.ResOtherServantInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---灵兽出战, 合体属性变化飘字
---msgID: 103017
---@param msgID LuaEnumNetDef 消息ID
---@return servantV2.ResServantStateChange C#数据结构
function networkRespond.OnResServantStateChangeMessageReceived(msgID)
    ---@type servantV2.ResServantStateChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 103017 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 103017 servantV2.ResServantStateChange 灵兽出战, 合体属性变化飘字")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResServantStateChangeMessage", 103017, "ResServantStateChange", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回单个灵兽信息
---msgID: 103018
---@param msgID LuaEnumNetDef 消息ID
---@return servantV2.ServantInfo C#数据结构
function networkRespond.OnResSingleServantInfoMessageReceived(msgID)
    ---@type servantV2.ServantInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 103018 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 103018 servantV2.ServantInfo 返回单个灵兽信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.servant ~= nil and  protobufMgr.DecodeTable.servant.ServantInfo ~= nil then
        csData = protobufMgr.DecodeTable.servant.ServantInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回单个灵兽信息
---msgID: 103020
---@param msgID LuaEnumNetDef 消息ID
---@return servantV2.ServantInfo C#数据结构
function networkRespond.OnResSingleServantInfoExMessageReceived(msgID)
    ---@type servantV2.ServantInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 103020 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 103020 servantV2.ServantInfo 返回单个灵兽信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.servant ~= nil and  protobufMgr.DecodeTable.servant.ServantInfo ~= nil then
        csData = protobufMgr.DecodeTable.servant.ServantInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---提醒开启灵兽位
---msgID: 103022
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResRemindOpenServantSiteMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---登陆地图灵兽合体
---msgID: 103023
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResLoginMapServantHetTiMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---打开灵兽聚灵面板
---msgID: 103026
---@param msgID LuaEnumNetDef 消息ID
---@return servantV2.ServantMana C#数据结构
function networkRespond.OnResOpneServantManaMessageReceived(msgID)
    ---@type servantV2.ServantMana
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 103026 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 103026 servantV2.ServantMana 打开灵兽聚灵面板")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResOpneServantManaMessage", 103026, "ServantMana", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

