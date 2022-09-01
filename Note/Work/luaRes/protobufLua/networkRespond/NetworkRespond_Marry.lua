--[[本文件为工具自动生成,禁止手动修改]]
--marry.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---弹出誓言面板
---msgID: 114003
---@param msgID LuaEnumNetDef 消息ID
---@return marryV2.ResMatchmakerPanel C#数据结构
function networkRespond.OnResMatchmakerPanelMessageReceived(msgID)
    ---@type marryV2.ResMatchmakerPanel
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 114003 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 114003 marryV2.ResMatchmakerPanel 弹出誓言面板")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.marry ~= nil and  protobufMgr.DecodeTable.marry.ResMatchmakerPanel ~= nil then
        csData = protobufMgr.DecodeTable.marry.ResMatchmakerPanel(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回确认的誓言
---msgID: 114005
---@param msgID LuaEnumNetDef 消息ID
---@return marryV2.ResMatchmaker C#数据结构
function networkRespond.OnResMatchmakerMessageReceived(msgID)
    ---@type marryV2.ResMatchmaker
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 114005 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 114005 marryV2.ResMatchmaker 返回确认的誓言")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.marry ~= nil and  protobufMgr.DecodeTable.marry.ResMatchmaker ~= nil then
        csData = protobufMgr.DecodeTable.marry.ResMatchmaker(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回中断结婚
---msgID: 114008
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResInterruptMarryMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---弹出离婚确认解除
---msgID: 114011
---@param msgID LuaEnumNetDef 消息ID
---@return marryV2.ResDivorce C#数据结构
function networkRespond.OnResDivorceMessageReceived(msgID)
    ---@type marryV2.ResDivorce
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 114011 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 114011 marryV2.ResDivorce 弹出离婚确认解除")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.marry ~= nil and  protobufMgr.DecodeTable.marry.ResDivorce ~= nil then
        csData = protobufMgr.DecodeTable.marry.ResDivorce(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---对方超过7天未上线，免费强制离婚确认面板，和收费强制离婚确认面板
---msgID: 114012
---@param msgID LuaEnumNetDef 消息ID
---@return marryV2.ResConfirmDivorce C#数据结构
function networkRespond.OnResConfirmDivorceMessageReceived(msgID)
    ---@type marryV2.ResConfirmDivorce
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 114012 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 114012 marryV2.ResConfirmDivorce 对方超过7天未上线，免费强制离婚确认面板，和收费强制离婚确认面板")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.marry ~= nil and  protobufMgr.DecodeTable.marry.ResConfirmDivorce ~= nil then
        csData = protobufMgr.DecodeTable.marry.ResConfirmDivorce(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---在线离婚条件不足消息
---msgID: 114014
---@param msgID LuaEnumNetDef 消息ID
---@return marryV2.ResOnlineDivorceCondition C#数据结构
function networkRespond.OnResOnlineDivorceConditionMessageReceived(msgID)
    ---@type marryV2.ResOnlineDivorceCondition
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 114014 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 114014 marryV2.ResOnlineDivorceCondition 在线离婚条件不足消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResOnlineDivorceConditionMessage", 114014, "ResOnlineDivorceCondition", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回中断离婚
---msgID: 114016
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResInterruptDivorceMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---结婚改变消息
---msgID: 114017
---@param msgID LuaEnumNetDef 消息ID
---@return marryV2.ResChangeMarry C#数据结构
function networkRespond.OnResChangeMarryMessageReceived(msgID)
    ---@type marryV2.ResChangeMarry
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 114017 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 114017 marryV2.ResChangeMarry 结婚改变消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.marry ~= nil and  protobufMgr.DecodeTable.marry.ResChangeMarry ~= nil then
        csData = protobufMgr.DecodeTable.marry.ResChangeMarry(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---获取当前对象信息
---msgID: 114018
---@param msgID LuaEnumNetDef 消息ID
---@return marryV2.ResGetSpouse C#数据结构
function networkRespond.OnResGetSpouseMessageReceived(msgID)
    ---@type marryV2.ResGetSpouse
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 114018 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 114018 marryV2.ResGetSpouse 获取当前对象信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.marry ~= nil and  protobufMgr.DecodeTable.marry.ResGetSpouse ~= nil then
        csData = protobufMgr.DecodeTable.marry.ResGetSpouse(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---缺少戒指消息
---msgID: 114020
---@param msgID LuaEnumNetDef 消息ID
---@return marryV2.ResLackRings C#数据结构
function networkRespond.OnResLackRingsMessageReceived(msgID)
    ---@type marryV2.ResLackRings
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 114020 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 114020 marryV2.ResLackRings 缺少戒指消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.marry ~= nil and  protobufMgr.DecodeTable.marry.ResLackRings ~= nil then
        csData = protobufMgr.DecodeTable.marry.ResLackRings(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回中断悔婚
---msgID: 114023
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResInterruptRegretMarriageMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---查看玩家婚姻信息
---msgID: 114024
---@param msgID LuaEnumNetDef 消息ID
---@return marryV2.ResPlayerMarriageInformation C#数据结构
function networkRespond.OnResPlayerMarriageInformationMessageReceived(msgID)
    ---@type marryV2.ResPlayerMarriageInformation
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 114024 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 114024 marryV2.ResPlayerMarriageInformation 查看玩家婚姻信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.marry ~= nil and  protobufMgr.DecodeTable.marry.ResPlayerMarriageInformation ~= nil then
        csData = protobufMgr.DecodeTable.marry.ResPlayerMarriageInformation(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回升级婚戒
---msgID: 114025
---@param msgID LuaEnumNetDef 消息ID
---@return marryV2.ResUpdateRing C#数据结构
function networkRespond.OnResUpdateRingMessageReceived(msgID)
    ---@type marryV2.ResUpdateRing
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 114025 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 114025 marryV2.ResUpdateRing 返回升级婚戒")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResUpdateRingMessage", 114025, "ResUpdateRing", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回誓言
---msgID: 114027
---@param msgID LuaEnumNetDef 消息ID
---@return marryV2.ResSeeOath C#数据结构
function networkRespond.OnResSeeOathMessageReceived(msgID)
    ---@type marryV2.ResSeeOath
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 114027 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 114027 marryV2.ResSeeOath 返回誓言")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSeeOathMessage", 114027, "ResSeeOath", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回刻字
---msgID: 114030
---@param msgID LuaEnumNetDef 消息ID
---@return marryV2.ResSeeLettering C#数据结构
function networkRespond.OnResSeeLetteringMessageReceived(msgID)
    ---@type marryV2.ResSeeLettering
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 114030 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 114030 marryV2.ResSeeLettering 返回刻字")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSeeLetteringMessage", 114030, "ResSeeLettering", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---查看其他玩家婚姻信息
---msgID: 114038
---@param msgID LuaEnumNetDef 消息ID
---@return marryV2.ResSeeOthersMarriageInfo C#数据结构
function networkRespond.OnResSeeOthersMarriageInfoMessageReceived(msgID)
    ---@type marryV2.ResSeeOthersMarriageInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 114038 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 114038 marryV2.ResSeeOthersMarriageInfo 查看其他玩家婚姻信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.marry ~= nil and  protobufMgr.DecodeTable.marry.ResSeeOthersMarriageInfo ~= nil then
        csData = protobufMgr.DecodeTable.marry.ResSeeOthersMarriageInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

