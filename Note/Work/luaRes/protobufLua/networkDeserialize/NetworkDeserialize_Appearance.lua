--[[本文件为工具自动生成,禁止手动修改]]
--appearance.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回修改称谓
---msgID: 121009
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResModifyTitleMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 121009 appearanceV2.ResModifyTitle 返回修改称谓")
        return nil
    end
    local res = protobufMgr.Deserialize("appearanceV2.ResModifyTitle", buffer)
    if protoAdjust.appearance_adj ~= nil and protoAdjust.appearance_adj.AdjustResModifyTitle ~= nil then
        protoAdjust.appearance_adj.AdjustResModifyTitle(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 121009
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回所有称谓
---msgID: 121010
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetHasAppellationMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 121010 appearanceV2.ResGetHasAppellation 返回所有称谓")
        return nil
    end
    local res = protobufMgr.Deserialize("appearanceV2.ResGetHasAppellation", buffer)
    if protoAdjust.appearance_adj ~= nil and protoAdjust.appearance_adj.AdjustResGetHasAppellation ~= nil then
        protoAdjust.appearance_adj.AdjustResGetHasAppellation(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 121010
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回正在使用称谓
---msgID: 121011
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResEnableAppellationMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 121011 appearanceV2.ResEnableAppellation 返回正在使用称谓")
        return nil
    end
    local res = protobufMgr.Deserialize("appearanceV2.ResEnableAppellation", buffer)
    if protoAdjust.appearance_adj ~= nil and protoAdjust.appearance_adj.AdjustResEnableAppellation ~= nil then
        protoAdjust.appearance_adj.AdjustResEnableAppellation(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 121011
    protobufMgr.mMsgDeserializedTblCache = res
end

---外观红点
---msgID: 121012
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAppearanceRedPointMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 121012 appearanceV2.ResAppearanceRedPoint 外观红点")
        return nil
    end
    local res = protobufMgr.Deserialize("appearanceV2.ResAppearanceRedPoint", buffer)
    if protoAdjust.appearance_adj ~= nil and protoAdjust.appearance_adj.AdjustResAppearanceRedPoint ~= nil then
        protoAdjust.appearance_adj.AdjustResAppearanceRedPoint(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 121012
    protobufMgr.mMsgDeserializedTblCache = res
end

