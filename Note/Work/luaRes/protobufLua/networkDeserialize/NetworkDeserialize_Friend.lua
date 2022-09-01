--[[本文件为工具自动生成,禁止手动修改]]
--friend.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回好友信息
---msgID: 100001
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResFriendInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100001 friendV2.ResFriendInfo 返回好友信息")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.ResFriendInfo", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustResFriendInfo ~= nil then
        protoAdjust.friend_adj.AdjustResFriendInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100001
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回好友变化信息
---msgID: 100005
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResFriendChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100005 friendV2.ResFriendChange 返回好友变化信息")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.ResFriendChange", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustResFriendChange ~= nil then
        protoAdjust.friend_adj.AdjustResFriendChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100005
    protobufMgr.mMsgDeserializedTblCache = res
end

---好友查询响应
---msgID: 100007
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSearchFriendMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100007 friendV2.SearchFriend 好友查询响应")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.SearchFriend", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustSearchFriend ~= nil then
        protoAdjust.friend_adj.AdjustSearchFriend(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100007
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回仇人坐标
---msgID: 100013
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAscertainPointMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100013 friendV2.AscertainPoint 返回仇人坐标")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.AscertainPoint", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustAscertainPoint ~= nil then
        protoAdjust.friend_adj.AdjustAscertainPoint(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100013
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回可能认识的朋友
---msgID: 100017
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMayKnowFriendMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100017 friendV2.ResMayKnowFriend 返回可能认识的朋友")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.ResMayKnowFriend", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustResMayKnowFriend ~= nil then
        protoAdjust.friend_adj.AdjustResMayKnowFriend(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100017
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回玩家个人信息
---msgID: 100021
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPersonalInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100021 friendV2.ResPersonalInfo 返回玩家个人信息")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.ResPersonalInfo", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustResPersonalInfo ~= nil then
        protoAdjust.friend_adj.AdjustResPersonalInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100021
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回未读聊天
---msgID: 100024
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnreadChatMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100024 friendV2.ResChatLog 返回未读聊天")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.ResChatLog", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustResChatLog ~= nil then
        protoAdjust.friend_adj.AdjustResChatLog(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100024
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回聊天记录
---msgID: 100028
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPersonalChatMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100028 friendV2.ResChatLog 返回聊天记录")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.ResChatLog", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustResChatLog ~= nil then
        protoAdjust.friend_adj.AdjustResChatLog(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100028
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回朋友圈信息
---msgID: 100030
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResFriendCirleMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100030 friendV2.ResFriendCircle 返回朋友圈信息")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.ResFriendCircle", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustResFriendCircle ~= nil then
        protoAdjust.friend_adj.AdjustResFriendCircle(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100030
    protobufMgr.mMsgDeserializedTblCache = res
end

---单条朋友圈信息,发送,回复,点赞的响应
---msgID: 100031
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSingleFriendCirleMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100031 friendV2.FriendCirclePostInfo 单条朋友圈信息,发送,回复,点赞的响应")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.FriendCirclePostInfo", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustFriendCirclePostInfo ~= nil then
        protoAdjust.friend_adj.AdjustFriendCirclePostInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100031
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回仇人位置
---msgID: 100037
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResEnemyPositionMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100037 friendV2.ResEnemyPosition 返回仇人位置")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.ResEnemyPosition", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustResEnemyPosition ~= nil then
        protoAdjust.friend_adj.AdjustResEnemyPosition(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100037
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回悬赏列表
---msgID: 100040
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOfferListMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100040 friendV2.ResOfferList 返回悬赏列表")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.ResOfferList", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustResOfferList ~= nil then
        protoAdjust.friend_adj.AdjustResOfferList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100040
    protobufMgr.mMsgDeserializedTblCache = res
end

---好感度变化消息
---msgID: 100042
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResFriendLoveChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100042 friendV2.ResFriendLoveChange 好感度变化消息")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.ResFriendLoveChange", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustResFriendLoveChange ~= nil then
        protoAdjust.friend_adj.AdjustResFriendLoveChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100042
    protobufMgr.mMsgDeserializedTblCache = res
end

---朋友圈有更新
---msgID: 100044
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResFriendCircleUpdatedMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100044 friendV2.ResFriendCircleUpdated 朋友圈有更新")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.ResFriendCircleUpdated", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustResFriendCircleUpdated ~= nil then
        protoAdjust.friend_adj.AdjustResFriendCircleUpdated(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100044
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回未查看的申请人
---msgID: 100048
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnLookApplicantMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100048 friendV2.UnLookApplicant 返回未查看的申请人")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.UnLookApplicant", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustUnLookApplicant ~= nil then
        protoAdjust.friend_adj.AdjustUnLookApplicant(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100048
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送悬赏错误提示码
---msgID: 100049
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOfferMatterCodeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100049 friendV2.OfferMatterCode 发送悬赏错误提示码")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.OfferMatterCode", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustOfferMatterCode ~= nil then
        protoAdjust.friend_adj.AdjustOfferMatterCode(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100049
    protobufMgr.mMsgDeserializedTblCache = res
end

---刷新刻字
---msgID: 100050
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUpdateLetteringMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100050 friendV2.UpdateLettering 刷新刻字")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.UpdateLettering", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustUpdateLettering ~= nil then
        protoAdjust.friend_adj.AdjustUpdateLettering(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100050
    protobufMgr.mMsgDeserializedTblCache = res
end

---更新悬赏列表
---msgID: 100051
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUpdateOfferListMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100051 friendV2.ResUpdateOfferList 更新悬赏列表")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.ResUpdateOfferList", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustResUpdateOfferList ~= nil then
        protoAdjust.friend_adj.AdjustResUpdateOfferList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100051
    protobufMgr.mMsgDeserializedTblCache = res
end

---更新怪物悬赏左侧栏
---msgID: 100054
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUpdateMonsterOfferPanelMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100054 friendV2.UpdateMonsterOfferPanel 更新怪物悬赏左侧栏")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.UpdateMonsterOfferPanel", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustUpdateMonsterOfferPanel ~= nil then
        protoAdjust.friend_adj.AdjustUpdateMonsterOfferPanel(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100054
    protobufMgr.mMsgDeserializedTblCache = res
end

---更新完成人数
---msgID: 100058
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUpdateCompleteNumMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100058 friendV2.ResUpdateCompleteNum 更新完成人数")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.ResUpdateCompleteNum", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustResUpdateCompleteNum ~= nil then
        protoAdjust.friend_adj.AdjustResUpdateCompleteNum(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100058
    protobufMgr.mMsgDeserializedTblCache = res
end

---好友上下线通知
---msgID: 100059
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResFriendLoginMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100059 friendV2.ResFriendLogin 好友上下线通知")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.ResFriendLogin", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustResFriendLogin ~= nil then
        protoAdjust.friend_adj.AdjustResFriendLogin(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100059
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回悬赏模糊查询
---msgID: 100061
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOfferSearchMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100061 friendV2.ResOfferSearch 返回悬赏模糊查询")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.ResOfferSearch", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustResOfferSearch ~= nil then
        protoAdjust.friend_adj.AdjustResOfferSearch(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100061
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回聊天框精确搜索
---msgID: 100063
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAccurateSearchMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 100063 friendV2.ResAccurateSearch 返回聊天框精确搜索")
        return nil
    end
    local res = protobufMgr.Deserialize("friendV2.ResAccurateSearch", buffer)
    if protoAdjust.friend_adj ~= nil and protoAdjust.friend_adj.AdjustResAccurateSearch ~= nil then
        protoAdjust.friend_adj.AdjustResAccurateSearch(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 100063
    protobufMgr.mMsgDeserializedTblCache = res
end

