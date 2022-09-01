--[[本文件为工具自动生成,禁止手动修改]]
--welfare.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---发送签到信息
---msgID: 27002
---@param msgID LuaEnumNetDef 消息ID
---@return welfareV2.ResSignInfo C#数据结构
function networkRespond.OnResSignInfoMessageReceived(msgID)
    ---@type welfareV2.ResSignInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 27002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 27002 welfareV2.ResSignInfo 发送签到信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSignInfoMessage", 27002, "ResSignInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回cdkey领奖结果
---msgID: 27005
---@param msgID LuaEnumNetDef 消息ID
---@return welfareV2.ResCdkeyReward C#数据结构
function networkRespond.OnResCdkeyRewardMessageReceived(msgID)
    ---@type welfareV2.ResCdkeyReward
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 27005 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 27005 welfareV2.ResCdkeyReward 返回cdkey领奖结果")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCdkeyRewardMessage", 27005, "ResCdkeyReward", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---发送七天奖励信息
---msgID: 27008
---@param msgID LuaEnumNetDef 消息ID
---@return welfareV2.ResSevenDaysInfo C#数据结构
function networkRespond.OnResSevenDaysInfoMessageReceived(msgID)
    ---@type welfareV2.ResSevenDaysInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 27008 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 27008 welfareV2.ResSevenDaysInfo 发送七天奖励信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSevenDaysInfoMessage", 27008, "ResSevenDaysInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---在线奖励领取响应
---msgID: 27012
---@param msgID LuaEnumNetDef 消息ID
---@return welfareV2.OnlineRewardMsg C#数据结构
function networkRespond.OnResOnlineRewardMessageReceived(msgID)
    ---@type welfareV2.OnlineRewardMsg
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 27012 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 27012 welfareV2.OnlineRewardMsg 在线奖励领取响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResOnlineRewardMessage", 27012, "OnlineRewardMsg", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---发送奖励大厅信息
---msgID: 27015
---@param msgID LuaEnumNetDef 消息ID
---@return welfareV2.RewardHall C#数据结构
function networkRespond.OnResGetRewardHallMessageReceived(msgID)
    ---@type welfareV2.RewardHall
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 27015 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 27015 welfareV2.RewardHall 发送奖励大厅信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResGetRewardHallMessage", 27015, "RewardHall", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---定时奖励信息
---msgID: 27017
---@param msgID LuaEnumNetDef 消息ID
---@return welfareV2.TimingReward C#数据结构
function networkRespond.OnResTimmngRewardInfoMessageReceived(msgID)
    ---@type welfareV2.TimingReward
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 27017 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 27017 welfareV2.TimingReward 定时奖励信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResTimmngRewardInfoMessage", 27017, "TimingReward", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---等级奖励信息
---msgID: 27020
---@param msgID LuaEnumNetDef 消息ID
---@return welfareV2.LevelPacksInfo C#数据结构
function networkRespond.OnResLevelPacksInfoMessageReceived(msgID)
    ---@type welfareV2.LevelPacksInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 27020 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 27020 welfareV2.LevelPacksInfo 等级奖励信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResLevelPacksInfoMessage", 27020, "LevelPacksInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

