--[[本文件为工具自动生成,禁止手动修改]]
--share.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回进入共享服的信息
---msgID: 1003001
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResEnterShareMapMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1003001 shareV2.EnterShareMapInfo 返回进入共享服的信息")
        return nil
    end
    local res = protobufMgr.Deserialize("shareV2.EnterShareMapInfo", buffer)
    if protoAdjust.share_adj ~= nil and protoAdjust.share_adj.AdjustEnterShareMapInfo ~= nil then
        protoAdjust.share_adj.AdjustEnterShareMapInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1003001
    protobufMgr.mMsgDeserializedTblCache = res
end

---角色联盟类型信息
---msgID: 1003002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRoleUniteTypeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1003002 uniteunionV2.ResRoleUniteType 角色联盟类型信息")
        return nil
    end
    local res = protobufMgr.Deserialize("uniteunionV2.ResRoleUniteType", buffer)
    if protoAdjust.uniteunion_adj ~= nil and protoAdjust.uniteunion_adj.AdjustResRoleUniteType ~= nil then
        protoAdjust.uniteunion_adj.AdjustResRoleUniteType(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1003002
    protobufMgr.mMsgDeserializedTblCache = res
end

