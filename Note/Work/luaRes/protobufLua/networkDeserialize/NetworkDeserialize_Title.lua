--[[本文件为工具自动生成,禁止手动修改]]
--title.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---发送称号列表信息
---msgID: 33002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTitleListMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 33002 titleV2.ResTitleList 发送称号列表信息")
        return nil
    end
    local res = protobufMgr.Deserialize("titleV2.ResTitleList", buffer)
    if protoAdjust.title_adj ~= nil and protoAdjust.title_adj.AdjustResTitleList ~= nil then
        protoAdjust.title_adj.AdjustResTitleList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 33002
    protobufMgr.mMsgDeserializedTblCache = res
end

---获得称号
---msgID: 33003
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAddTitleMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 33003 titleV2.TitleInfo 获得称号")
        return nil
    end
    local res = protobufMgr.Deserialize("titleV2.TitleInfo", buffer)
    if protoAdjust.title_adj ~= nil and protoAdjust.title_adj.AdjustTitleInfo ~= nil then
        protoAdjust.title_adj.AdjustTitleInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 33003
    protobufMgr.mMsgDeserializedTblCache = res
end

---移除称号
---msgID: 33004
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRemoveTitleMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 33004 titleV2.ResRemoveTitle 移除称号")
        return nil
    end
    local res = protobufMgr.Deserialize("titleV2.ResRemoveTitle", buffer)
    if protoAdjust.title_adj ~= nil and protoAdjust.title_adj.AdjustResRemoveTitle ~= nil then
        protoAdjust.title_adj.AdjustResRemoveTitle(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 33004
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回佩戴称号
---msgID: 33006
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPutOnTitleMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 33006 titleV2.ResPutOnTitle 返回佩戴称号")
        return nil
    end
    local res = protobufMgr.Deserialize("titleV2.ResPutOnTitle", buffer)
    if protoAdjust.title_adj ~= nil and protoAdjust.title_adj.AdjustResPutOnTitle ~= nil then
        protoAdjust.title_adj.AdjustResPutOnTitle(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 33006
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回脱下称号
---msgID: 33008
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPutOffTitleMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 33008 titleV2.ResPutOffTitle 返回脱下称号")
        return nil
    end
    local res = protobufMgr.Deserialize("titleV2.ResPutOffTitle", buffer)
    if protoAdjust.title_adj ~= nil and protoAdjust.title_adj.AdjustResPutOffTitle ~= nil then
        protoAdjust.title_adj.AdjustResPutOffTitle(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 33008
    protobufMgr.mMsgDeserializedTblCache = res
end

