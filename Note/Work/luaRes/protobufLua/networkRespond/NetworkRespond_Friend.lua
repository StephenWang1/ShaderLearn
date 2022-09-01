--[[本文件为工具自动生成,禁止手动修改]]
--friend.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回好友信息
---msgID: 100001
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.ResFriendInfo C#数据结构
function networkRespond.OnResFriendInfoMessageReceived(msgID)
    ---@type friendV2.ResFriendInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100001 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100001 friendV2.ResFriendInfo 返回好友信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.friend ~= nil and  protobufMgr.DecodeTable.friend.ResFriendInfo ~= nil then
        csData = protobufMgr.DecodeTable.friend.ResFriendInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回好友变化信息
---msgID: 100005
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.ResFriendChange C#数据结构
function networkRespond.OnResFriendChangeMessageReceived(msgID)
    ---@type friendV2.ResFriendChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100005 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100005 friendV2.ResFriendChange 返回好友变化信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.friend ~= nil and  protobufMgr.DecodeTable.friend.ResFriendChange ~= nil then
        csData = protobufMgr.DecodeTable.friend.ResFriendChange(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---好友查询响应
---msgID: 100007
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.SearchFriend C#数据结构
function networkRespond.OnResSearchFriendMessageReceived(msgID)
    ---@type friendV2.SearchFriend
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100007 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100007 friendV2.SearchFriend 好友查询响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.friend ~= nil and  protobufMgr.DecodeTable.friend.SearchFriend ~= nil then
        csData = protobufMgr.DecodeTable.friend.SearchFriend(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回仇人坐标
---msgID: 100013
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.AscertainPoint C#数据结构
function networkRespond.OnResAscertainPointMessageReceived(msgID)
    ---@type friendV2.AscertainPoint
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100013 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100013 friendV2.AscertainPoint 返回仇人坐标")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResAscertainPointMessage", 100013, "AscertainPoint", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回可能认识的朋友
---msgID: 100017
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.ResMayKnowFriend C#数据结构
function networkRespond.OnResMayKnowFriendMessageReceived(msgID)
    ---@type friendV2.ResMayKnowFriend
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100017 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100017 friendV2.ResMayKnowFriend 返回可能认识的朋友")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.friend ~= nil and  protobufMgr.DecodeTable.friend.ResMayKnowFriend ~= nil then
        csData = protobufMgr.DecodeTable.friend.ResMayKnowFriend(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回玩家个人信息
---msgID: 100021
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.ResPersonalInfo C#数据结构
function networkRespond.OnResPersonalInfoMessageReceived(msgID)
    ---@type friendV2.ResPersonalInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100021 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100021 friendV2.ResPersonalInfo 返回玩家个人信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.friend ~= nil and  protobufMgr.DecodeTable.friend.ResPersonalInfo ~= nil then
        csData = protobufMgr.DecodeTable.friend.ResPersonalInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回未读聊天
---msgID: 100024
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.ResChatLog C#数据结构
function networkRespond.OnResUnreadChatMessageReceived(msgID)
    ---@type friendV2.ResChatLog
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100024 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100024 friendV2.ResChatLog 返回未读聊天")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.friend ~= nil and  protobufMgr.DecodeTable.friend.ResChatLog ~= nil then
        csData = protobufMgr.DecodeTable.friend.ResChatLog(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回聊天记录
---msgID: 100028
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.ResChatLog C#数据结构
function networkRespond.OnResPersonalChatMessageReceived(msgID)
    ---@type friendV2.ResChatLog
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100028 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100028 friendV2.ResChatLog 返回聊天记录")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.friend ~= nil and  protobufMgr.DecodeTable.friend.ResChatLog ~= nil then
        csData = protobufMgr.DecodeTable.friend.ResChatLog(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回朋友圈信息
---msgID: 100030
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.ResFriendCircle C#数据结构
function networkRespond.OnResFriendCirleMessageReceived(msgID)
    ---@type friendV2.ResFriendCircle
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100030 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100030 friendV2.ResFriendCircle 返回朋友圈信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.friend ~= nil and  protobufMgr.DecodeTable.friend.ResFriendCircle ~= nil then
        csData = protobufMgr.DecodeTable.friend.ResFriendCircle(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---单条朋友圈信息,发送,回复,点赞的响应
---msgID: 100031
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.FriendCirclePostInfo C#数据结构
function networkRespond.OnResSingleFriendCirleMessageReceived(msgID)
    ---@type friendV2.FriendCirclePostInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100031 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100031 friendV2.FriendCirclePostInfo 单条朋友圈信息,发送,回复,点赞的响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.friend ~= nil and  protobufMgr.DecodeTable.friend.FriendCirclePostInfo ~= nil then
        csData = protobufMgr.DecodeTable.friend.FriendCirclePostInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回仇人位置
---msgID: 100037
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.ResEnemyPosition C#数据结构
function networkRespond.OnResEnemyPositionMessageReceived(msgID)
    ---@type friendV2.ResEnemyPosition
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100037 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100037 friendV2.ResEnemyPosition 返回仇人位置")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.friend ~= nil and  protobufMgr.DecodeTable.friend.ResEnemyPosition ~= nil then
        csData = protobufMgr.DecodeTable.friend.ResEnemyPosition(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回悬赏列表
---msgID: 100040
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.ResOfferList C#数据结构
function networkRespond.OnResOfferListMessageReceived(msgID)
    ---@type friendV2.ResOfferList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100040 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100040 friendV2.ResOfferList 返回悬赏列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.friend ~= nil and  protobufMgr.DecodeTable.friend.ResOfferList ~= nil then
        csData = protobufMgr.DecodeTable.friend.ResOfferList(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---好感度变化消息
---msgID: 100042
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.ResFriendLoveChange C#数据结构
function networkRespond.OnResFriendLoveChangeMessageReceived(msgID)
    ---@type friendV2.ResFriendLoveChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100042 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100042 friendV2.ResFriendLoveChange 好感度变化消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.friend ~= nil and  protobufMgr.DecodeTable.friend.ResFriendLoveChange ~= nil then
        csData = protobufMgr.DecodeTable.friend.ResFriendLoveChange(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---朋友圈有更新
---msgID: 100044
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.ResFriendCircleUpdated C#数据结构
function networkRespond.OnResFriendCircleUpdatedMessageReceived(msgID)
    ---@type friendV2.ResFriendCircleUpdated
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100044 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100044 friendV2.ResFriendCircleUpdated 朋友圈有更新")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.friend ~= nil and  protobufMgr.DecodeTable.friend.ResFriendCircleUpdated ~= nil then
        csData = protobufMgr.DecodeTable.friend.ResFriendCircleUpdated(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回未查看的申请人
---msgID: 100048
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.UnLookApplicant C#数据结构
function networkRespond.OnResUnLookApplicantMessageReceived(msgID)
    ---@type friendV2.UnLookApplicant
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100048 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100048 friendV2.UnLookApplicant 返回未查看的申请人")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.friend ~= nil and  protobufMgr.DecodeTable.friend.UnLookApplicant ~= nil then
        csData = protobufMgr.DecodeTable.friend.UnLookApplicant(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送悬赏错误提示码
---msgID: 100049
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.OfferMatterCode C#数据结构
function networkRespond.OnResOfferMatterCodeMessageReceived(msgID)
    ---@type friendV2.OfferMatterCode
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100049 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100049 friendV2.OfferMatterCode 发送悬赏错误提示码")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResOfferMatterCodeMessage", 100049, "OfferMatterCode", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---刷新刻字
---msgID: 100050
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.UpdateLettering C#数据结构
function networkRespond.OnResUpdateLetteringMessageReceived(msgID)
    ---@type friendV2.UpdateLettering
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100050 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100050 friendV2.UpdateLettering 刷新刻字")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.friend ~= nil and  protobufMgr.DecodeTable.friend.UpdateLettering ~= nil then
        csData = protobufMgr.DecodeTable.friend.UpdateLettering(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---更新悬赏列表
---msgID: 100051
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.ResUpdateOfferList C#数据结构
function networkRespond.OnResUpdateOfferListMessageReceived(msgID)
    ---@type friendV2.ResUpdateOfferList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100051 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100051 friendV2.ResUpdateOfferList 更新悬赏列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.friend ~= nil and  protobufMgr.DecodeTable.friend.ResUpdateOfferList ~= nil then
        csData = protobufMgr.DecodeTable.friend.ResUpdateOfferList(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---更新怪物悬赏左侧栏
---msgID: 100054
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.UpdateMonsterOfferPanel C#数据结构
function networkRespond.OnResUpdateMonsterOfferPanelMessageReceived(msgID)
    ---@type friendV2.UpdateMonsterOfferPanel
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100054 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100054 friendV2.UpdateMonsterOfferPanel 更新怪物悬赏左侧栏")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.friend ~= nil and  protobufMgr.DecodeTable.friend.UpdateMonsterOfferPanel ~= nil then
        csData = protobufMgr.DecodeTable.friend.UpdateMonsterOfferPanel(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---更新完成人数
---msgID: 100058
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.ResUpdateCompleteNum C#数据结构
function networkRespond.OnResUpdateCompleteNumMessageReceived(msgID)
    ---@type friendV2.ResUpdateCompleteNum
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100058 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100058 friendV2.ResUpdateCompleteNum 更新完成人数")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.friend ~= nil and  protobufMgr.DecodeTable.friend.ResUpdateCompleteNum ~= nil then
        csData = protobufMgr.DecodeTable.friend.ResUpdateCompleteNum(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---好友上下线通知
---msgID: 100059
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.ResFriendLogin C#数据结构
function networkRespond.OnResFriendLoginMessageReceived(msgID)
    ---@type friendV2.ResFriendLogin
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100059 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100059 friendV2.ResFriendLogin 好友上下线通知")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.friend ~= nil and  protobufMgr.DecodeTable.friend.ResFriendLogin ~= nil then
        csData = protobufMgr.DecodeTable.friend.ResFriendLogin(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回悬赏模糊查询
---msgID: 100061
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.ResOfferSearch C#数据结构
function networkRespond.OnResOfferSearchMessageReceived(msgID)
    ---@type friendV2.ResOfferSearch
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100061 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100061 friendV2.ResOfferSearch 返回悬赏模糊查询")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResOfferSearchMessage", 100061, "ResOfferSearch", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回聊天框精确搜索
---msgID: 100063
---@param msgID LuaEnumNetDef 消息ID
---@return friendV2.ResAccurateSearch C#数据结构
function networkRespond.OnResAccurateSearchMessageReceived(msgID)
    ---@type friendV2.ResAccurateSearch
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 100063 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 100063 friendV2.ResAccurateSearch 返回聊天框精确搜索")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.friend ~= nil and  protobufMgr.DecodeTable.friend.ResAccurateSearch ~= nil then
        csData = protobufMgr.DecodeTable.friend.ResAccurateSearch(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

