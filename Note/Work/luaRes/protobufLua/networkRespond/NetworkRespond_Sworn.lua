--[[本文件为工具自动生成,禁止手动修改]]
--sworn.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---有结拜进行时返回正在结拜
---msgID: 113002
---@param msgID LuaEnumNetDef 消息ID
---@return swornV2.ResHasSworn C#数据结构
function networkRespond.OnResHasSwornMessageReceived(msgID)
    ---@type swornV2.ResHasSworn
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 113002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 113002 swornV2.ResHasSworn 有结拜进行时返回正在结拜")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResHasSwornMessage", 113002, "ResHasSworn", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---特效开始消息
---msgID: 113003
---@param msgID LuaEnumNetDef 消息ID
---@return swornV2.ResSpecialEffects C#数据结构
function networkRespond.OnResSpecialEffectsMessageReceived(msgID)
    ---@type swornV2.ResSpecialEffects
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 113003 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 113003 swornV2.ResSpecialEffects 特效开始消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.sworn ~= nil and  protobufMgr.DecodeTable.sworn.ResSpecialEffects ~= nil then
        csData = protobufMgr.DecodeTable.sworn.ResSpecialEffects(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回兄弟信息
---msgID: 113004
---@param msgID LuaEnumNetDef 消息ID
---@return swornV2.ResYourBrother C#数据结构
function networkRespond.OnResYourBrotherMessageReceived(msgID)
    ---@type swornV2.ResYourBrother
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 113004 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 113004 swornV2.ResYourBrother 返回兄弟信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.sworn ~= nil and  protobufMgr.DecodeTable.sworn.ResYourBrother ~= nil then
        csData = protobufMgr.DecodeTable.sworn.ResYourBrother(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---向队员发送结拜面板
---msgID: 113005
---@param msgID LuaEnumNetDef 消息ID
---@return swornV2.SendSwornInfo C#数据结构
function networkRespond.OnSendSwornInfoMessageReceived(msgID)
    ---@type swornV2.SendSwornInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 113005 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 113005 swornV2.SendSwornInfo 向队员发送结拜面板")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.sworn ~= nil and  protobufMgr.DecodeTable.sworn.SendSwornInfo ~= nil then
        csData = protobufMgr.DecodeTable.sworn.SendSwornInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回改变同意结义消息
---msgID: 113007
---@param msgID LuaEnumNetDef 消息ID
---@return swornV2.ResAgreeSworn C#数据结构
function networkRespond.OnResAgreeSwornMessageReceived(msgID)
    ---@type swornV2.ResAgreeSworn
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 113007 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 113007 swornV2.ResAgreeSworn 返回改变同意结义消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResAgreeSwornMessage", 113007, "ResAgreeSworn", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---中断结义
---msgID: 113009
---@param msgID LuaEnumNetDef 消息ID
---@return swornV2.ResInterruptSworn C#数据结构
function networkRespond.OnResInterruptSwornMessageReceived(msgID)
    ---@type swornV2.ResInterruptSworn
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 113009 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 113009 swornV2.ResInterruptSworn 中断结义")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.sworn ~= nil and  protobufMgr.DecodeTable.sworn.ResInterruptSworn ~= nil then
        csData = protobufMgr.DecodeTable.sworn.ResInterruptSworn(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---结义是否成功
---msgID: 113010
---@param msgID LuaEnumNetDef 消息ID
---@return swornV2.ResSwornSuccess C#数据结构
function networkRespond.OnResSwornSuccessMessageReceived(msgID)
    ---@type swornV2.ResSwornSuccess
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 113010 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 113010 swornV2.ResSwornSuccess 结义是否成功")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSwornSuccessMessage", 113010, "ResSwornSuccess", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---成功结义后返回新添加的兄弟信息
---msgID: 113015
---@param msgID LuaEnumNetDef 消息ID
---@return swornV2.ResAddBrother C#数据结构
function networkRespond.OnResAddBrotherMessageReceived(msgID)
    ---@type swornV2.ResAddBrother
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 113015 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 113015 swornV2.ResAddBrother 成功结义后返回新添加的兄弟信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.sworn ~= nil and  protobufMgr.DecodeTable.sworn.ResAddBrother ~= nil then
        csData = protobufMgr.DecodeTable.sworn.ResAddBrother(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---移除的兄弟信息
---msgID: 113016
---@param msgID LuaEnumNetDef 消息ID
---@return swornV2.ResRemoveBrother C#数据结构
function networkRespond.OnResRemoveBrotherMessageReceived(msgID)
    ---@type swornV2.ResRemoveBrother
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 113016 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 113016 swornV2.ResRemoveBrother 移除的兄弟信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.sworn ~= nil and  protobufMgr.DecodeTable.sworn.ResRemoveBrother ~= nil then
        csData = protobufMgr.DecodeTable.sworn.ResRemoveBrother(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---更新单个兄弟信息
---msgID: 113017
---@param msgID LuaEnumNetDef 消息ID
---@return swornV2.ResOneBrother C#数据结构
function networkRespond.OnResOneBrotherMessageReceived(msgID)
    ---@type swornV2.ResOneBrother
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 113017 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 113017 swornV2.ResOneBrother 更新单个兄弟信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.sworn ~= nil and  protobufMgr.DecodeTable.sworn.ResOneBrother ~= nil then
        csData = protobufMgr.DecodeTable.sworn.ResOneBrother(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回断义列表
---msgID: 113019
---@param msgID LuaEnumNetDef 消息ID
---@return swornV2.ResBreakOffRelations C#数据结构
function networkRespond.OnResBreakOffRelationsMessageReceived(msgID)
    ---@type swornV2.ResBreakOffRelations
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 113019 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 113019 swornV2.ResBreakOffRelations 返回断义列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.sworn ~= nil and  protobufMgr.DecodeTable.sworn.ResBreakOffRelations ~= nil then
        csData = protobufMgr.DecodeTable.sworn.ResBreakOffRelations(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

