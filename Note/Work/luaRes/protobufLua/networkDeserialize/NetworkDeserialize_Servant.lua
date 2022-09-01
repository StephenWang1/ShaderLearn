--[[本文件为工具自动生成,禁止手动修改]]
--servant.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回仆从信息
---msgID: 103001
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResServantInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 103001 servantV2.ResServantInfo 返回仆从信息")
        return nil
    end
    local res = protobufMgr.Deserialize("servantV2.ResServantInfo", buffer)
    if protoAdjust.servant_adj ~= nil and protoAdjust.servant_adj.AdjustResServantInfo ~= nil then
        protoAdjust.servant_adj.AdjustResServantInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 103001
    protobufMgr.mMsgDeserializedTblCache = res
end

---元灵经验更新
---msgID: 103008
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResServantExpUpdateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 103008 servantV2.ServantExpUpdate 元灵经验更新")
        return nil
    end
    local res = protobufMgr.Deserialize("servantV2.ServantExpUpdate", buffer)
    if protoAdjust.servant_adj ~= nil and protoAdjust.servant_adj.AdjustServantExpUpdate ~= nil then
        protoAdjust.servant_adj.AdjustServantExpUpdate(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 103008
    protobufMgr.mMsgDeserializedTblCache = res
end

---元灵血量更新
---msgID: 103009
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResServantHpUpdateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 103009 servantV2.ServantHpUpdate 元灵血量更新")
        return nil
    end
    local res = protobufMgr.Deserialize("servantV2.ServantHpUpdate", buffer)
    if protoAdjust.servant_adj ~= nil and protoAdjust.servant_adj.AdjustServantHpUpdate ~= nil then
        protoAdjust.servant_adj.AdjustServantHpUpdate(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 103009
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回元灵名字
---msgID: 103011
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResNameMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 103011 servantV2.ResServantName 返回元灵名字")
        return nil
    end
    local res = protobufMgr.Deserialize("servantV2.ResServantName", buffer)
    if protoAdjust.servant_adj ~= nil and protoAdjust.servant_adj.AdjustResServantName ~= nil then
        protoAdjust.servant_adj.AdjustResServantName(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 103011
    protobufMgr.mMsgDeserializedTblCache = res
end

---灵兽升级包
---msgID: 103012
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResServantLevelUpMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 103012 servantV2.ResServantLevelUp 灵兽升级包")
        return nil
    end
    local res = protobufMgr.Deserialize("servantV2.ResServantLevelUp", buffer)
    if protoAdjust.servant_adj ~= nil and protoAdjust.servant_adj.AdjustResServantLevelUp ~= nil then
        protoAdjust.servant_adj.AdjustResServantLevelUp(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 103012
    protobufMgr.mMsgDeserializedTblCache = res
end

---灵兽转生包
---msgID: 103013
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResServantReinUpMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 103013 servantV2.ResServantReinUp 灵兽转生包")
        return nil
    end
    local res = protobufMgr.Deserialize("servantV2.ResServantReinUp", buffer)
    if protoAdjust.servant_adj ~= nil and protoAdjust.servant_adj.AdjustResServantReinUp ~= nil then
        protoAdjust.servant_adj.AdjustResServantReinUp(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 103013
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回使用灵兽蛋
---msgID: 103014
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUseServantEggMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 103014 servantV2.ResServantName 返回使用灵兽蛋")
        return nil
    end
    local res = protobufMgr.Deserialize("servantV2.ResServantName", buffer)
    if protoAdjust.servant_adj ~= nil and protoAdjust.servant_adj.AdjustResServantName ~= nil then
        protoAdjust.servant_adj.AdjustResServantName(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 103014
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回他人灵兽信息
---msgID: 103016
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOtherServantInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 103016 servantV2.ResOtherServantInfo 返回他人灵兽信息")
        return nil
    end
    local res = protobufMgr.Deserialize("servantV2.ResOtherServantInfo", buffer)
    if protoAdjust.servant_adj ~= nil and protoAdjust.servant_adj.AdjustResOtherServantInfo ~= nil then
        protoAdjust.servant_adj.AdjustResOtherServantInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 103016
    protobufMgr.mMsgDeserializedTblCache = res
end

---灵兽出战, 合体属性变化飘字
---msgID: 103017
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResServantStateChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 103017 servantV2.ResServantStateChange 灵兽出战, 合体属性变化飘字")
        return nil
    end
    local res = protobufMgr.Deserialize("servantV2.ResServantStateChange", buffer)
    if protoAdjust.servant_adj ~= nil and protoAdjust.servant_adj.AdjustResServantStateChange ~= nil then
        protoAdjust.servant_adj.AdjustResServantStateChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 103017
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回单个灵兽信息
---msgID: 103018
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSingleServantInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 103018 servantV2.ServantInfo 返回单个灵兽信息")
        return nil
    end
    local res = protobufMgr.Deserialize("servantV2.ServantInfo", buffer)
    if protoAdjust.servant_adj ~= nil and protoAdjust.servant_adj.AdjustServantInfo ~= nil then
        protoAdjust.servant_adj.AdjustServantInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 103018
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回单个灵兽信息
---msgID: 103020
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSingleServantInfoExMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 103020 servantV2.ServantInfo 返回单个灵兽信息")
        return nil
    end
    local res = protobufMgr.Deserialize("servantV2.ServantInfo", buffer)
    if protoAdjust.servant_adj ~= nil and protoAdjust.servant_adj.AdjustServantInfo ~= nil then
        protoAdjust.servant_adj.AdjustServantInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 103020
    protobufMgr.mMsgDeserializedTblCache = res
end

---提醒开启灵兽位
---msgID: 103022
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRemindOpenServantSiteMessageReceived(msgID, buffer)
end

---登陆地图灵兽合体
---msgID: 103023
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResLoginMapServantHetTiMessageReceived(msgID, buffer)
end

---打开灵兽聚灵面板
---msgID: 103026
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOpneServantManaMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 103026 servantV2.ServantMana 打开灵兽聚灵面板")
        return nil
    end
    local res = protobufMgr.Deserialize("servantV2.ServantMana", buffer)
    if protoAdjust.servant_adj ~= nil and protoAdjust.servant_adj.AdjustServantMana ~= nil then
        protoAdjust.servant_adj.AdjustServantMana(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 103026
    protobufMgr.mMsgDeserializedTblCache = res
end

