--[[本文件为工具自动生成,禁止手动修改]]
--sworn.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---有结拜进行时返回正在结拜
---msgID: 113002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResHasSwornMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 113002 swornV2.ResHasSworn 有结拜进行时返回正在结拜")
        return nil
    end
    local res = protobufMgr.Deserialize("swornV2.ResHasSworn", buffer)
    if protoAdjust.sworn_adj ~= nil and protoAdjust.sworn_adj.AdjustResHasSworn ~= nil then
        protoAdjust.sworn_adj.AdjustResHasSworn(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 113002
    protobufMgr.mMsgDeserializedTblCache = res
end

---特效开始消息
---msgID: 113003
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSpecialEffectsMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 113003 swornV2.ResSpecialEffects 特效开始消息")
        return nil
    end
    local res = protobufMgr.Deserialize("swornV2.ResSpecialEffects", buffer)
    if protoAdjust.sworn_adj ~= nil and protoAdjust.sworn_adj.AdjustResSpecialEffects ~= nil then
        protoAdjust.sworn_adj.AdjustResSpecialEffects(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 113003
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回兄弟信息
---msgID: 113004
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResYourBrotherMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 113004 swornV2.ResYourBrother 返回兄弟信息")
        return nil
    end
    local res = protobufMgr.Deserialize("swornV2.ResYourBrother", buffer)
    if protoAdjust.sworn_adj ~= nil and protoAdjust.sworn_adj.AdjustResYourBrother ~= nil then
        protoAdjust.sworn_adj.AdjustResYourBrother(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 113004
    protobufMgr.mMsgDeserializedTblCache = res
end

---向队员发送结拜面板
---msgID: 113005
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnSendSwornInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 113005 swornV2.SendSwornInfo 向队员发送结拜面板")
        return nil
    end
    local res = protobufMgr.Deserialize("swornV2.SendSwornInfo", buffer)
    if protoAdjust.sworn_adj ~= nil and protoAdjust.sworn_adj.AdjustSendSwornInfo ~= nil then
        protoAdjust.sworn_adj.AdjustSendSwornInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 113005
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回改变同意结义消息
---msgID: 113007
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAgreeSwornMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 113007 swornV2.ResAgreeSworn 返回改变同意结义消息")
        return nil
    end
    local res = protobufMgr.Deserialize("swornV2.ResAgreeSworn", buffer)
    if protoAdjust.sworn_adj ~= nil and protoAdjust.sworn_adj.AdjustResAgreeSworn ~= nil then
        protoAdjust.sworn_adj.AdjustResAgreeSworn(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 113007
    protobufMgr.mMsgDeserializedTblCache = res
end

---中断结义
---msgID: 113009
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResInterruptSwornMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 113009 swornV2.ResInterruptSworn 中断结义")
        return nil
    end
    local res = protobufMgr.Deserialize("swornV2.ResInterruptSworn", buffer)
    if protoAdjust.sworn_adj ~= nil and protoAdjust.sworn_adj.AdjustResInterruptSworn ~= nil then
        protoAdjust.sworn_adj.AdjustResInterruptSworn(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 113009
    protobufMgr.mMsgDeserializedTblCache = res
end

---结义是否成功
---msgID: 113010
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSwornSuccessMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 113010 swornV2.ResSwornSuccess 结义是否成功")
        return nil
    end
    local res = protobufMgr.Deserialize("swornV2.ResSwornSuccess", buffer)
    if protoAdjust.sworn_adj ~= nil and protoAdjust.sworn_adj.AdjustResSwornSuccess ~= nil then
        protoAdjust.sworn_adj.AdjustResSwornSuccess(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 113010
    protobufMgr.mMsgDeserializedTblCache = res
end

---成功结义后返回新添加的兄弟信息
---msgID: 113015
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAddBrotherMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 113015 swornV2.ResAddBrother 成功结义后返回新添加的兄弟信息")
        return nil
    end
    local res = protobufMgr.Deserialize("swornV2.ResAddBrother", buffer)
    if protoAdjust.sworn_adj ~= nil and protoAdjust.sworn_adj.AdjustResAddBrother ~= nil then
        protoAdjust.sworn_adj.AdjustResAddBrother(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 113015
    protobufMgr.mMsgDeserializedTblCache = res
end

---移除的兄弟信息
---msgID: 113016
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRemoveBrotherMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 113016 swornV2.ResRemoveBrother 移除的兄弟信息")
        return nil
    end
    local res = protobufMgr.Deserialize("swornV2.ResRemoveBrother", buffer)
    if protoAdjust.sworn_adj ~= nil and protoAdjust.sworn_adj.AdjustResRemoveBrother ~= nil then
        protoAdjust.sworn_adj.AdjustResRemoveBrother(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 113016
    protobufMgr.mMsgDeserializedTblCache = res
end

---更新单个兄弟信息
---msgID: 113017
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOneBrotherMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 113017 swornV2.ResOneBrother 更新单个兄弟信息")
        return nil
    end
    local res = protobufMgr.Deserialize("swornV2.ResOneBrother", buffer)
    if protoAdjust.sworn_adj ~= nil and protoAdjust.sworn_adj.AdjustResOneBrother ~= nil then
        protoAdjust.sworn_adj.AdjustResOneBrother(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 113017
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回断义列表
---msgID: 113019
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBreakOffRelationsMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 113019 swornV2.ResBreakOffRelations 返回断义列表")
        return nil
    end
    local res = protobufMgr.Deserialize("swornV2.ResBreakOffRelations", buffer)
    if protoAdjust.sworn_adj ~= nil and protoAdjust.sworn_adj.AdjustResBreakOffRelations ~= nil then
        protoAdjust.sworn_adj.AdjustResBreakOffRelations(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 113019
    protobufMgr.mMsgDeserializedTblCache = res
end

