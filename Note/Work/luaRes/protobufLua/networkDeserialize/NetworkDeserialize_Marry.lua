--[[本文件为工具自动生成,禁止手动修改]]
--marry.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---弹出誓言面板
---msgID: 114003
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMatchmakerPanelMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 114003 marryV2.ResMatchmakerPanel 弹出誓言面板")
        return nil
    end
    local res = protobufMgr.Deserialize("marryV2.ResMatchmakerPanel", buffer)
    if protoAdjust.marry_adj ~= nil and protoAdjust.marry_adj.AdjustResMatchmakerPanel ~= nil then
        protoAdjust.marry_adj.AdjustResMatchmakerPanel(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 114003
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回确认的誓言
---msgID: 114005
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMatchmakerMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 114005 marryV2.ResMatchmaker 返回确认的誓言")
        return nil
    end
    local res = protobufMgr.Deserialize("marryV2.ResMatchmaker", buffer)
    if protoAdjust.marry_adj ~= nil and protoAdjust.marry_adj.AdjustResMatchmaker ~= nil then
        protoAdjust.marry_adj.AdjustResMatchmaker(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 114005
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回中断结婚
---msgID: 114008
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResInterruptMarryMessageReceived(msgID, buffer)
end

---弹出离婚确认解除
---msgID: 114011
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDivorceMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 114011 marryV2.ResDivorce 弹出离婚确认解除")
        return nil
    end
    local res = protobufMgr.Deserialize("marryV2.ResDivorce", buffer)
    if protoAdjust.marry_adj ~= nil and protoAdjust.marry_adj.AdjustResDivorce ~= nil then
        protoAdjust.marry_adj.AdjustResDivorce(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 114011
    protobufMgr.mMsgDeserializedTblCache = res
end

---对方超过7天未上线，免费强制离婚确认面板，和收费强制离婚确认面板
---msgID: 114012
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResConfirmDivorceMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 114012 marryV2.ResConfirmDivorce 对方超过7天未上线，免费强制离婚确认面板，和收费强制离婚确认面板")
        return nil
    end
    local res = protobufMgr.Deserialize("marryV2.ResConfirmDivorce", buffer)
    if protoAdjust.marry_adj ~= nil and protoAdjust.marry_adj.AdjustResConfirmDivorce ~= nil then
        protoAdjust.marry_adj.AdjustResConfirmDivorce(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 114012
    protobufMgr.mMsgDeserializedTblCache = res
end

---在线离婚条件不足消息
---msgID: 114014
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOnlineDivorceConditionMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 114014 marryV2.ResOnlineDivorceCondition 在线离婚条件不足消息")
        return nil
    end
    local res = protobufMgr.Deserialize("marryV2.ResOnlineDivorceCondition", buffer)
    if protoAdjust.marry_adj ~= nil and protoAdjust.marry_adj.AdjustResOnlineDivorceCondition ~= nil then
        protoAdjust.marry_adj.AdjustResOnlineDivorceCondition(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 114014
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回中断离婚
---msgID: 114016
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResInterruptDivorceMessageReceived(msgID, buffer)
end

---结婚改变消息
---msgID: 114017
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResChangeMarryMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 114017 marryV2.ResChangeMarry 结婚改变消息")
        return nil
    end
    local res = protobufMgr.Deserialize("marryV2.ResChangeMarry", buffer)
    if protoAdjust.marry_adj ~= nil and protoAdjust.marry_adj.AdjustResChangeMarry ~= nil then
        protoAdjust.marry_adj.AdjustResChangeMarry(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 114017
    protobufMgr.mMsgDeserializedTblCache = res
end

---获取当前对象信息
---msgID: 114018
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetSpouseMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 114018 marryV2.ResGetSpouse 获取当前对象信息")
        return nil
    end
    local res = protobufMgr.Deserialize("marryV2.ResGetSpouse", buffer)
    if protoAdjust.marry_adj ~= nil and protoAdjust.marry_adj.AdjustResGetSpouse ~= nil then
        protoAdjust.marry_adj.AdjustResGetSpouse(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 114018
    protobufMgr.mMsgDeserializedTblCache = res
end

---缺少戒指消息
---msgID: 114020
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResLackRingsMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 114020 marryV2.ResLackRings 缺少戒指消息")
        return nil
    end
    local res = protobufMgr.Deserialize("marryV2.ResLackRings", buffer)
    if protoAdjust.marry_adj ~= nil and protoAdjust.marry_adj.AdjustResLackRings ~= nil then
        protoAdjust.marry_adj.AdjustResLackRings(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 114020
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回中断悔婚
---msgID: 114023
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResInterruptRegretMarriageMessageReceived(msgID, buffer)
end

---查看玩家婚姻信息
---msgID: 114024
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPlayerMarriageInformationMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 114024 marryV2.ResPlayerMarriageInformation 查看玩家婚姻信息")
        return nil
    end
    local res = protobufMgr.Deserialize("marryV2.ResPlayerMarriageInformation", buffer)
    if protoAdjust.marry_adj ~= nil and protoAdjust.marry_adj.AdjustResPlayerMarriageInformation ~= nil then
        protoAdjust.marry_adj.AdjustResPlayerMarriageInformation(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 114024
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回升级婚戒
---msgID: 114025
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUpdateRingMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 114025 marryV2.ResUpdateRing 返回升级婚戒")
        return nil
    end
    local res = protobufMgr.Deserialize("marryV2.ResUpdateRing", buffer)
    if protoAdjust.marry_adj ~= nil and protoAdjust.marry_adj.AdjustResUpdateRing ~= nil then
        protoAdjust.marry_adj.AdjustResUpdateRing(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 114025
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回誓言
---msgID: 114027
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSeeOathMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 114027 marryV2.ResSeeOath 返回誓言")
        return nil
    end
    local res = protobufMgr.Deserialize("marryV2.ResSeeOath", buffer)
    if protoAdjust.marry_adj ~= nil and protoAdjust.marry_adj.AdjustResSeeOath ~= nil then
        protoAdjust.marry_adj.AdjustResSeeOath(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 114027
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回刻字
---msgID: 114030
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSeeLetteringMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 114030 marryV2.ResSeeLettering 返回刻字")
        return nil
    end
    local res = protobufMgr.Deserialize("marryV2.ResSeeLettering", buffer)
    if protoAdjust.marry_adj ~= nil and protoAdjust.marry_adj.AdjustResSeeLettering ~= nil then
        protoAdjust.marry_adj.AdjustResSeeLettering(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 114030
    protobufMgr.mMsgDeserializedTblCache = res
end

---查看其他玩家婚姻信息
---msgID: 114038
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSeeOthersMarriageInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 114038 marryV2.ResSeeOthersMarriageInfo 查看其他玩家婚姻信息")
        return nil
    end
    local res = protobufMgr.Deserialize("marryV2.ResSeeOthersMarriageInfo", buffer)
    if protoAdjust.marry_adj ~= nil and protoAdjust.marry_adj.AdjustResSeeOthersMarriageInfo ~= nil then
        protoAdjust.marry_adj.AdjustResSeeOthersMarriageInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 114038
    protobufMgr.mMsgDeserializedTblCache = res
end

