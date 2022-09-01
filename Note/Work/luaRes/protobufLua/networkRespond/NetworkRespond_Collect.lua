--[[本文件为工具自动生成,禁止手动修改]]
--collect.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---藏品上架响应
---msgID: 111102
---@param msgID LuaEnumNetDef 消息ID
---@return collect.PutCollectionItemMsg C#数据结构
function networkRespond.OnResPutCollectionItemMessageReceived(msgID)
    ---@type collect.PutCollectionItemMsg
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111102 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111102 collect.PutCollectionItemMsg 藏品上架响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResPutCollectionItemMessage", 111102, "PutCollectionItemMsg", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---藏品下架响应
---msgID: 111104
---@param msgID LuaEnumNetDef 消息ID
---@return collect.RemoveCollectionItemMsg C#数据结构
function networkRespond.OnResRemoveCollectionItemMessageReceived(msgID)
    ---@type collect.RemoveCollectionItemMsg
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111104 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111104 collect.RemoveCollectionItemMsg 藏品下架响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRemoveCollectionItemMessage", 111104, "RemoveCollectionItemMsg", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---藏品交换位置响应
---msgID: 111106
---@param msgID LuaEnumNetDef 消息ID
---@return collect.CabinetInfo C#数据结构
function networkRespond.OnResSwapCollectionItemMessageReceived(msgID)
    ---@type collect.CabinetInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111106 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111106 collect.CabinetInfo 藏品交换位置响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSwapCollectionItemMessage", 111106, "CabinetInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---藏品回收响应
---msgID: 111108
---@param msgID LuaEnumNetDef 消息ID
---@return collect.CallbackCollectionMsg C#数据结构
function networkRespond.OnResCallbackCollectionMessageReceived(msgID)
    ---@type collect.CallbackCollectionMsg
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111108 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111108 collect.CallbackCollectionMsg 藏品回收响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCallbackCollectionMessage", 111108, "CallbackCollectionMsg", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---收藏柜信息
---msgID: 111109
---@param msgID LuaEnumNetDef 消息ID
---@return collect.CabinetInfo C#数据结构
function networkRespond.OnResCabinetMessageReceived(msgID)
    ---@type collect.CabinetInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 111109 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 111109 collect.CabinetInfo 收藏柜信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCabinetMessage", 111109, "CabinetInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

