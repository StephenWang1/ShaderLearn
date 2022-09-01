--[[本文件为工具自动生成,禁止手动修改]]
--rank.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---排行榜数据
---msgID: 26002
---@param msgID LuaEnumNetDef 消息ID
---@return rankV2.ResLookRank C#数据结构
function networkRespond.OnResLookRankMessageReceived(msgID)
    ---@type rankV2.ResLookRank
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 26002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 26002 rankV2.ResLookRank 排行榜数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---C#中对消息结构引用到的某个类型的字段未实现,故需要打印出lua的网络日志
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResLookRankMessage", 26002, "ResLookRank", tblData)
    end
    local csData
    if protobufMgr.DecodeTable.rank ~= nil and  protobufMgr.DecodeTable.rank.ResLookRank ~= nil then
        csData = protobufMgr.DecodeTable.rank.ResLookRank(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送排行奖励信息
---msgID: 26004
---@param msgID LuaEnumNetDef 消息ID
---@return rankV2.ResRankRewardInfo C#数据结构
function networkRespond.OnResRankRewardInfoMessageReceived(msgID)
    ---@type rankV2.ResRankRewardInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 26004 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 26004 rankV2.ResRankRewardInfo 发送排行奖励信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRankRewardInfoMessage", 26004, "ResRankRewardInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---发送未领取奖励的排行列表
---msgID: 26006
---@param msgID LuaEnumNetDef 消息ID
---@return rankV2.ResUnRewardRankTypes C#数据结构
function networkRespond.OnResUnRewardRankTypesMessageReceived(msgID)
    ---@type rankV2.ResUnRewardRankTypes
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 26006 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 26006 rankV2.ResUnRewardRankTypes 发送未领取奖励的排行列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.rank ~= nil and  protobufMgr.DecodeTable.rank.ResUnRewardRankTypes ~= nil then
        csData = protobufMgr.DecodeTable.rank.ResUnRewardRankTypes(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---战损榜详情响应
---msgID: 26008
---@param msgID LuaEnumNetDef 消息ID
---@return rankV2.DamageItemRankInfo C#数据结构
function networkRespond.OnResBattleDamageRankDatailMessageReceived(msgID)
    ---@type rankV2.DamageItemRankInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 26008 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 26008 rankV2.DamageItemRankInfo 战损榜详情响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.rank ~= nil and  protobufMgr.DecodeTable.rank.DamageItemRankInfo ~= nil then
        csData = protobufMgr.DecodeTable.rank.DamageItemRankInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---排行榜数据
---msgID: 26010
---@param msgID LuaEnumNetDef 消息ID
---@return rankV2.ResLookRank C#数据结构
function networkRespond.OnResShareLookRankMessageReceived(msgID)
    ---@type rankV2.ResLookRank
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 26010 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 26010 rankV2.ResLookRank 排行榜数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---C#中对消息结构引用到的某个类型的字段未实现,故需要打印出lua的网络日志
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResShareLookRankMessage", 26010, "ResLookRank", tblData)
    end
    local csData
    if protobufMgr.DecodeTable.rank ~= nil and  protobufMgr.DecodeTable.rank.ResLookRank ~= nil then
        csData = protobufMgr.DecodeTable.rank.ResLookRank(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

