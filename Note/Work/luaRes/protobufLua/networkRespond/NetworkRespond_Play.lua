--[[本文件为工具自动生成,禁止手动修改]]
--play.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回客户端通用消息
---msgID: 73022
---@param msgID LuaEnumNetDef 消息ID
---@return playV2.CommonInfo C#数据结构
function networkRespond.OnResCommonMessageReceived(msgID)
    ---@type playV2.CommonInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 73022 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 73022 playV2.CommonInfo 返回客户端通用消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.play ~= nil and  protobufMgr.DecodeTable.play.CommonInfo ~= nil then
        csData = protobufMgr.DecodeTable.play.CommonInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回客户端地图通用消息
---msgID: 73026
---@param msgID LuaEnumNetDef 消息ID
---@return playV2.CommonInfo C#数据结构
function networkRespond.OnResMapCommonMessageReceived(msgID)
    ---@type playV2.CommonInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 73026 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 73026 playV2.CommonInfo 返回客户端地图通用消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.play ~= nil and  protobufMgr.DecodeTable.play.CommonInfo ~= nil then
        csData = protobufMgr.DecodeTable.play.CommonInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---需要弹出攻击模式提示面板
---msgID: 73027
---@param msgID LuaEnumNetDef 消息ID
---@return playV2.NeedHasAttackModePanel C#数据结构
function networkRespond.OnNeedHasAttackModePanelMessageReceived(msgID)
    ---@type playV2.NeedHasAttackModePanel
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 73027 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 73027 playV2.NeedHasAttackModePanel 需要弹出攻击模式提示面板")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("NeedHasAttackModePanelMessage", 73027, "NeedHasAttackModePanel", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

