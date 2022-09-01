--[[本文件为工具自动生成,禁止手动修改]]
--share.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回进入共享服的信息
---msgID: 1003001
---@param msgID LuaEnumNetDef 消息ID
---@return shareV2.EnterShareMapInfo C#数据结构
function networkRespond.OnResEnterShareMapMessageReceived(msgID)
    ---@type shareV2.EnterShareMapInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1003001 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1003001 shareV2.EnterShareMapInfo 返回进入共享服的信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResEnterShareMapMessage", 1003001, "EnterShareMapInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---角色联盟类型信息
---msgID: 1003002
---@param msgID LuaEnumNetDef 消息ID
---@return uniteunionV2.ResRoleUniteType C#数据结构
function networkRespond.OnResRoleUniteTypeMessageReceived(msgID)
    ---@type uniteunionV2.ResRoleUniteType
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1003002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1003002 uniteunionV2.ResRoleUniteType 角色联盟类型信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRoleUniteTypeMessage", 1003002, "ResRoleUniteType", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

