--[[本文件为工具自动生成,禁止手动修改]]
--rage.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---狂暴之力弹窗
---msgID: 130002
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResRageTipMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---狂暴之力状态响应
---msgID: 130005
---@param msgID LuaEnumNetDef 消息ID
---@return rageV2.RageState C#数据结构
function networkRespond.OnResRageStateMessageReceived(msgID)
    ---@type rageV2.RageState
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 130005 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 130005 rageV2.RageState 狂暴之力状态响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRageStateMessage", 130005, "RageState", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

