--[[本文件为工具自动生成,禁止手动修改]]
--title.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---发送称号列表信息
---msgID: 33002
---@param msgID LuaEnumNetDef 消息ID
---@return titleV2.ResTitleList C#数据结构
function networkRespond.OnResTitleListMessageReceived(msgID)
    ---@type titleV2.ResTitleList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 33002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 33002 titleV2.ResTitleList 发送称号列表信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.title ~= nil and  protobufMgr.DecodeTable.title.ResTitleList ~= nil then
        csData = protobufMgr.DecodeTable.title.ResTitleList(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---获得称号
---msgID: 33003
---@param msgID LuaEnumNetDef 消息ID
---@return titleV2.TitleInfo C#数据结构
function networkRespond.OnResAddTitleMessageReceived(msgID)
    ---@type titleV2.TitleInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 33003 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 33003 titleV2.TitleInfo 获得称号")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.title ~= nil and  protobufMgr.DecodeTable.title.TitleInfo ~= nil then
        csData = protobufMgr.DecodeTable.title.TitleInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---移除称号
---msgID: 33004
---@param msgID LuaEnumNetDef 消息ID
---@return titleV2.ResRemoveTitle C#数据结构
function networkRespond.OnResRemoveTitleMessageReceived(msgID)
    ---@type titleV2.ResRemoveTitle
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 33004 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 33004 titleV2.ResRemoveTitle 移除称号")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.title ~= nil and  protobufMgr.DecodeTable.title.ResRemoveTitle ~= nil then
        csData = protobufMgr.DecodeTable.title.ResRemoveTitle(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回佩戴称号
---msgID: 33006
---@param msgID LuaEnumNetDef 消息ID
---@return titleV2.ResPutOnTitle C#数据结构
function networkRespond.OnResPutOnTitleMessageReceived(msgID)
    ---@type titleV2.ResPutOnTitle
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 33006 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 33006 titleV2.ResPutOnTitle 返回佩戴称号")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResPutOnTitleMessage", 33006, "ResPutOnTitle", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回脱下称号
---msgID: 33008
---@param msgID LuaEnumNetDef 消息ID
---@return titleV2.ResPutOffTitle C#数据结构
function networkRespond.OnResPutOffTitleMessageReceived(msgID)
    ---@type titleV2.ResPutOffTitle
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 33008 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 33008 titleV2.ResPutOffTitle 返回脱下称号")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.title ~= nil and  protobufMgr.DecodeTable.title.ResPutOffTitle ~= nil then
        csData = protobufMgr.DecodeTable.title.ResPutOffTitle(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

