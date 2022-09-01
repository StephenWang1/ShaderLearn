--[[本文件为工具自动生成,禁止手动修改]]
--friend.xml

--region ID:100002 请求打开好友面板
---请求打开好友面板
---msgID: 100002
---@param type number 选填参数 1好友，2仇敌，3黑名单 4申请列表 7：私聊列表
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOpenFriendPanel(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqOpenFriendPanel" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOpenFriendPanelMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOpenFriendPanelMessage](LuaEnumNetDef.ReqOpenFriendPanelMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqOpenFriendPanelMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqOpenFriendPanelMessage", 100002, "ReqOpenFriendPanel", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100003 请求好友查询
---请求好友查询
---msgID: 100003
---@param idOrName string 选填参数 参数，玩家ID或玩家名
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSearchFriend(idOrName)
    local reqTable = {}
    if idOrName ~= nil then
        reqTable.idOrName = idOrName
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqSearchFriend" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSearchFriendMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSearchFriendMessage](LuaEnumNetDef.ReqSearchFriendMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSearchFriendMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSearchFriendMessage", 100003, "ReqSearchFriend", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100004 请求添加好友
---请求添加好友
---msgID: 100004
---@param type number 选填参数 1好友，3黑名单
---@param uid number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAddFriend(type, uid)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if uid ~= nil then
        reqTable.uid = uid
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqAddFriend" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAddFriendMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAddFriendMessage](LuaEnumNetDef.ReqAddFriendMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAddFriendMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAddFriendMessage", 100004, "ReqAddFriend", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100006 请求删除好友
---请求删除好友
---msgID: 100006
---@param type number 选填参数 1好友，2仇敌，3黑名单, 7最近私聊
---@param targetList number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDeleteFriend(type, targetList)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if targetList ~= nil then
        reqTable.targetList = targetList
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqDeleteFriend" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDeleteFriendMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDeleteFriendMessage](LuaEnumNetDef.ReqDeleteFriendMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDeleteFriendMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDeleteFriendMessage", 100006, "ReqDeleteFriend", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100008 审批申请
---审批申请
---msgID: 100008
---@param listId System.Collections.Generic.List1T<number> 列表参数
---@param flag boolean 必填参数 true:同意 false:拒绝
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCheckApply(listId, flag)
    local reqData = CS.friendV2.checkApply()
    if listId ~= nil then
        reqData.listId:AddRange(listId)
    end
    reqData.flag = flag
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCheckApplyMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCheckApplyMessage](LuaEnumNetDef.ReqCheckApplyMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqCheckApplyMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:100009 召唤好友
---召唤好友
---msgID: 100009
---@param roleId number 必填参数
---@param type number 选填参数 1:召唤 2:追踪
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSummonFriend(roleId, type)
    local reqTable = {}
    reqTable.roleId = roleId
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.SummonFriend" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSummonFriendMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSummonFriendMessage](LuaEnumNetDef.ReqSummonFriendMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSummonFriendMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSummonFriendMessage", 100009, "SummonFriend", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100011 确认召唤
---确认召唤
---msgID: 100011
---@param roleId number 必填参数
---@param isAgreed boolean 必填参数
---@param x number 选填参数
---@param y number 选填参数
---@param mapId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqConfirmSummon(roleId, isAgreed, x, y, mapId)
    local reqTable = {}
    reqTable.roleId = roleId
    reqTable.isAgreed = isAgreed
    if x ~= nil then
        reqTable.x = x
    end
    if y ~= nil then
        reqTable.y = y
    end
    if mapId ~= nil then
        reqTable.mapId = mapId
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ConfirmSummon" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqConfirmSummonMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqConfirmSummonMessage](LuaEnumNetDef.ReqConfirmSummonMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqConfirmSummonMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqConfirmSummonMessage", 100011, "ConfirmSummon", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100012 打探坐标
---打探坐标
---msgID: 100012
---@param roleId number 必填参数
---@param type number 选填参数 1:召唤 2:追踪
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTracking(roleId, type)
    local reqTable = {}
    reqTable.roleId = roleId
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.SummonFriend" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTrackingMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTrackingMessage](LuaEnumNetDef.ReqTrackingMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqTrackingMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqTrackingMessage", 100012, "SummonFriend", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100014 拜师、收徒请求
---拜师、收徒请求
---msgID: 100014
---@param targetId number 必填参数
---@param type number 选填参数 5拜师 6收徒
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTeacherDisciple(targetId, type)
    local reqTable = {}
    reqTable.targetId = targetId
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.TeacherDisciple" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTeacherDiscipleMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTeacherDiscipleMessage](LuaEnumNetDef.ReqTeacherDiscipleMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqTeacherDiscipleMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqTeacherDiscipleMessage", 100014, "TeacherDisciple", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100016 请求可能认识的朋友
---请求可能认识的朋友
---msgID: 100016
---@return boolean 网络请求是否成功发送
function networkRequest.ReqMayKnowFriend()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqMayKnowFriendMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqMayKnowFriendMessage](LuaEnumNetDef.ReqMayKnowFriendMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqMayKnowFriendMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:100018 清空申请列表
---清空申请列表
---msgID: 100018
---@return boolean 网络请求是否成功发送
function networkRequest.ReqClearApplyList()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqClearApplyListMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqClearApplyListMessage](LuaEnumNetDef.ReqClearApplyListMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqClearApplyListMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:100019 请求编辑个人信息
---请求编辑个人信息
---msgID: 100019
---@param brief string 选填参数 简介
---@param address string 选填参数 地址
---@param contactWay string 选填参数 联系方式
---@param openList System.Collections.Generic.List1T<number> 列表参数 公开给哪些类人看联系(所属关系)
---@return boolean 网络请求是否成功发送
function networkRequest.ReqEditPersonalInfo(brief, address, contactWay, openList)
    local reqData = CS.friendV2.ReqEditInfo()
    if brief ~= nil then
        reqData.brief = brief
    end
    if address ~= nil then
        reqData.address = address
    end
    if contactWay ~= nil then
        reqData.contactWay = contactWay
    end
    if openList ~= nil then
        reqData.openList:AddRange(openList)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqEditPersonalInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqEditPersonalInfoMessage](LuaEnumNetDef.ReqEditPersonalInfoMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqEditPersonalInfoMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:100020 请求查看好友个人信息
---请求查看好友个人信息
---msgID: 100020
---@param rid number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLookFriendInfo(rid)
    local reqTable = {}
    if rid ~= nil then
        reqTable.rid = rid
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqLookFriendInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLookFriendInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLookFriendInfoMessage](LuaEnumNetDef.ReqLookFriendInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqLookFriendInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqLookFriendInfoMessage", 100020, "ReqLookFriendInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100022 修改好友备注
---修改好友备注
---msgID: 100022
---@param rid number 选填参数 玩家id
---@param remark string 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqEditRemark(rid, remark)
    local reqTable = {}
    if rid ~= nil then
        reqTable.rid = rid
    end
    if remark ~= nil then
        reqTable.remark = remark
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqEditRemark" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqEditRemarkMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqEditRemarkMessage](LuaEnumNetDef.ReqEditRemarkMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqEditRemarkMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqEditRemarkMessage", 100022, "ReqEditRemark", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100023 请求未读聊天
---请求未读聊天
---msgID: 100023
---@param targetId number 选填参数 对方id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUnreadChat(targetId)
    local reqTable = {}
    if targetId ~= nil then
        reqTable.targetId = targetId
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ChatTarget" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUnreadChatMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUnreadChatMessage](LuaEnumNetDef.ReqUnreadChatMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUnreadChatMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUnreadChatMessage", 100023, "ChatTarget", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100025 设置已读
---设置已读
---msgID: 100025
---@param targetId number 选填参数 对方id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSetRead(targetId)
    local reqTable = {}
    if targetId ~= nil then
        reqTable.targetId = targetId
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ChatTarget" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSetReadMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSetReadMessage](LuaEnumNetDef.ReqSetReadMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSetReadMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSetReadMessage", 100025, "ChatTarget", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100027 请求聊天记录
---请求聊天记录
---msgID: 100027
---@param targetId number 选填参数
---@param chatId number 选填参数 记录唯一id
---@param count number 选填参数 id往上条数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPersonalChat(targetId, chatId, count)
    local reqTable = {}
    if targetId ~= nil then
        reqTable.targetId = targetId
    end
    if chatId ~= nil then
        reqTable.chatId = chatId
    end
    if count ~= nil then
        reqTable.count = count
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqChatLog" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPersonalChatMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPersonalChatMessage](LuaEnumNetDef.ReqPersonalChatMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPersonalChatMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPersonalChatMessage", 100027, "ReqChatLog", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100029 请求朋友圈信息
---请求朋友圈信息
---msgID: 100029
---@param beforeTime number 必填参数 之前看到的时间戳, 获取最新发 0
---@param roleId number 必填参数 请求别人的朋友圈, 填角色 id, 自己的填 0 或者自己的 id
---@param type number 必填参数 朋友圈 0, 我的动态 1, 消息列表 2
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetFriendCircle(beforeTime, roleId, type)
    local reqTable = {}
    reqTable.beforeTime = beforeTime
    reqTable.roleId = roleId
    reqTable.type = type
    local reqMsgData = protobufMgr.Serialize("friendV2.GetFriendCircleInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetFriendCircleMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetFriendCircleMessage](LuaEnumNetDef.ReqGetFriendCircleMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetFriendCircleMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetFriendCircleMessage", 100029, "GetFriendCircleInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100032 请求朋友圈发动态
---请求朋友圈发动态
---msgID: 100032
---@param message string 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqFriendCirclePost(message)
    local reqTable = {}
    reqTable.message = message
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqFriendCirclePost" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqFriendCirclePostMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqFriendCirclePostMessage](LuaEnumNetDef.ReqFriendCirclePostMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqFriendCirclePostMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqFriendCirclePostMessage", 100032, "ReqFriendCirclePost", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100033 请求朋友圈发回复
---请求朋友圈发回复
---msgID: 100033
---@param postId number 必填参数 回复的 post 的主 replayId
---@param replyId number 必填参数 回复的 reply id
---@param message string 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqFriendCircleReply(postId, replyId, message)
    local reqTable = {}
    reqTable.postId = postId
    reqTable.replyId = replyId
    reqTable.message = message
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqFriendCircleReply" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqFriendCircleReplyMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqFriendCircleReplyMessage](LuaEnumNetDef.ReqFriendCircleReplyMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqFriendCircleReplyMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqFriendCircleReplyMessage", 100033, "ReqFriendCircleReply", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100034 请求朋友圈点赞
---请求朋友圈点赞
---msgID: 100034
---@param postId number 必填参数
---@param replyId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqFriendCircleLike(postId, replyId)
    local reqTable = {}
    reqTable.postId = postId
    reqTable.replyId = replyId
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqFriendCircleLike" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqFriendCircleLikeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqFriendCircleLikeMessage](LuaEnumNetDef.ReqFriendCircleLikeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqFriendCircleLikeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqFriendCircleLikeMessage", 100034, "ReqFriendCircleLike", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100035 点发送消息按钮
---点发送消息按钮
---msgID: 100035
---@param targetId number 选填参数 对方id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAddSendChat(targetId)
    local reqTable = {}
    if targetId ~= nil then
        reqTable.targetId = targetId
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ChatTarget" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAddSendChatMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAddSendChatMessage](LuaEnumNetDef.ReqAddSendChatMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAddSendChatMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAddSendChatMessage", 100035, "ChatTarget", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100036 请求仇人位置
---请求仇人位置
---msgID: 100036
---@param targetId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqEnemyPosition(targetId)
    local reqTable = {}
    if targetId ~= nil then
        reqTable.targetId = targetId
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.TargetId" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqEnemyPositionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqEnemyPositionMessage](LuaEnumNetDef.ReqEnemyPositionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqEnemyPositionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqEnemyPositionMessage", 100036, "TargetId", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100038 请求查看上次仇人位置
---请求查看上次仇人位置
---msgID: 100038
---@param targetId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLastEnemyPosition(targetId)
    local reqTable = {}
    if targetId ~= nil then
        reqTable.targetId = targetId
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.TargetId" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLastEnemyPositionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLastEnemyPositionMessage](LuaEnumNetDef.ReqLastEnemyPositionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqLastEnemyPositionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqLastEnemyPositionMessage", 100038, "TargetId", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100039 请求悬赏列表
---请求悬赏列表
---msgID: 100039
---@param type number 选填参数 0:全服 1:个人
---@param npcId number 选填参数 请求的npcId
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOfferList(type, npcId)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if npcId ~= nil then
        reqTable.npcId = npcId
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqOfferList" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOfferListMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOfferListMessage](LuaEnumNetDef.ReqOfferListMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqOfferListMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqOfferListMessage", 100039, "ReqOfferList", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100041 发布悬赏
---发布悬赏
---msgID: 100041
---@param targetId number 选填参数 对象
---@param reward number 选填参数 赏金
---@param targetName string 选填参数 对象名字
---@param npcId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPublishOffer(targetId, reward, targetName, npcId)
    local reqTable = {}
    if targetId ~= nil then
        reqTable.targetId = targetId
    end
    if reward ~= nil then
        reqTable.reward = reward
    end
    if targetName ~= nil then
        reqTable.targetName = targetName
    end
    if npcId ~= nil then
        reqTable.npcId = npcId
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqPublishOffer" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPublishOfferMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPublishOfferMessage](LuaEnumNetDef.ReqPublishOfferMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPublishOfferMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPublishOfferMessage", 100041, "ReqPublishOffer", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100043 撤回悬赏
---撤回悬赏
---msgID: 100043
---@param targetId number 选填参数
---@param npcId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqWithdrawOffer(targetId, npcId)
    local reqTable = {}
    if targetId ~= nil then
        reqTable.targetId = targetId
    end
    if npcId ~= nil then
        reqTable.npcId = npcId
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqWithdrawOffer" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqWithdrawOfferMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqWithdrawOfferMessage](LuaEnumNetDef.ReqWithdrawOfferMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqWithdrawOfferMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqWithdrawOfferMessage", 100043, "ReqWithdrawOffer", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100045 提前出狱
---提前出狱
---msgID: 100045
---@param type number 选填参数 1:花费元宝 2:召唤boss 3:找替罪羊
---@param prisoner number 选填参数 想要顶替的犯人
---@return boolean 网络请求是否成功发送
function networkRequest.ReqEarlyLeavePrison(type, prisoner)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if prisoner ~= nil then
        reqTable.prisoner = prisoner
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqEarlyLeavePrison" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqEarlyLeavePrisonMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqEarlyLeavePrisonMessage](LuaEnumNetDef.ReqEarlyLeavePrisonMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqEarlyLeavePrisonMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqEarlyLeavePrisonMessage", 100045, "ReqEarlyLeavePrison", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100046 查看申请人
---查看申请人
---msgID: 100046
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLookApplicant()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLookApplicantMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLookApplicantMessage](LuaEnumNetDef.ReqLookApplicantMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqLookApplicantMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:100047 请求未查看的申请人
---请求未查看的申请人
---msgID: 100047
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUnLookApplicant()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUnLookApplicantMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUnLookApplicantMessage](LuaEnumNetDef.ReqUnLookApplicantMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqUnLookApplicantMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:100052 朋友圈删除动态
---朋友圈删除动态
---msgID: 100052
---@param postId number 必填参数
---@param replyId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqFriendCircleDelete(postId, replyId)
    local reqTable = {}
    reqTable.postId = postId
    reqTable.replyId = replyId
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqFriendCircleDelete" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqFriendCircleDeleteMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqFriendCircleDeleteMessage](LuaEnumNetDef.ReqFriendCircleDeleteMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqFriendCircleDeleteMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqFriendCircleDeleteMessage", 100052, "ReqFriendCircleDelete", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100053 请求接取怪物悬赏
---请求接取怪物悬赏
---msgID: 100053
---@param id number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPickUpMonsterOffer(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.OfferId" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPickUpMonsterOfferMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPickUpMonsterOfferMessage](LuaEnumNetDef.ReqPickUpMonsterOfferMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPickUpMonsterOfferMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPickUpMonsterOfferMessage", 100053, "OfferId", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100055 请求提交怪物悬赏
---请求提交怪物悬赏
---msgID: 100055
---@param id number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSubmitMonsterOffer(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.OfferId" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSubmitMonsterOfferMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSubmitMonsterOfferMessage](LuaEnumNetDef.ReqSubmitMonsterOfferMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSubmitMonsterOfferMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSubmitMonsterOfferMessage", 100055, "OfferId", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100056 请求删除私聊记录
---请求删除私聊记录
---msgID: 100056
---@param targetId number 选填参数
---@param ids System.Collections.Generic.List1T<number> 列表参数 要删除的记录ids
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDeleteChatLog(targetId, ids)
    local reqData = CS.friendV2.ReqDeleteChatLog()
    if targetId ~= nil then
        reqData.targetId = targetId
    end
    if ids ~= nil then
        reqData.ids:AddRange(ids)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDeleteChatLogMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDeleteChatLogMessage](LuaEnumNetDef.ReqDeleteChatLogMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqDeleteChatLogMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:100060 请求悬赏模糊查询
---请求悬赏模糊查询
---msgID: 100060
---@param idOrName string 选填参数 参数，玩家ID或玩家名
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOfferSearch(idOrName)
    local reqTable = {}
    if idOrName ~= nil then
        reqTable.idOrName = idOrName
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqSearchFriend" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOfferSearchMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOfferSearchMessage](LuaEnumNetDef.ReqOfferSearchMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqOfferSearchMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqOfferSearchMessage", 100060, "ReqSearchFriend", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100062 请求聊天框精确搜索
---请求聊天框精确搜索
---msgID: 100062
---@param idOrName string 选填参数 参数，玩家ID或玩家名
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAccurateSearch(idOrName)
    local reqTable = {}
    if idOrName ~= nil then
        reqTable.idOrName = idOrName
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqSearchFriend" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAccurateSearchMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAccurateSearchMessage](LuaEnumNetDef.ReqAccurateSearchMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAccurateSearchMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAccurateSearchMessage", 100062, "ReqSearchFriend", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100064 请求更改朋友圈消息订阅
---请求更改朋友圈消息订阅
---msgID: 100064
---@param systemMsgDisabled System.Collections.Generic.List1T<number> 列表参数 取消勾选的系统朋友圈消息类型, 里面没有的就是勾选的
---@return boolean 网络请求是否成功发送
function networkRequest.ReqFriendCircleSysMsgConfig(systemMsgDisabled)
    local reqData = CS.friendV2.ReqFriendCircleSysMsgConfig()
    if systemMsgDisabled ~= nil then
        reqData.systemMsgDisabled:AddRange(systemMsgDisabled)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqFriendCircleSysMsgConfigMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqFriendCircleSysMsgConfigMessage](LuaEnumNetDef.ReqFriendCircleSysMsgConfigMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqFriendCircleSysMsgConfigMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:100065 请求悬赏列表
---请求悬赏列表
---msgID: 100065
---@param type number 选填参数 0:全服 1:个人
---@param npcId number 选填参数 请求的npcId
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOfferShareList(type, npcId)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if npcId ~= nil then
        reqTable.npcId = npcId
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqOfferList" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOfferShareListMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOfferShareListMessage](LuaEnumNetDef.ReqOfferShareListMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqOfferShareListMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqOfferShareListMessage", 100065, "ReqOfferList", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100066 发布悬赏
---发布悬赏
---msgID: 100066
---@param targetId number 选填参数 对象
---@param reward number 选填参数 赏金
---@param targetName string 选填参数 对象名字
---@param npcId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPublishOfferShare(targetId, reward, targetName, npcId)
    local reqTable = {}
    if targetId ~= nil then
        reqTable.targetId = targetId
    end
    if reward ~= nil then
        reqTable.reward = reward
    end
    if targetName ~= nil then
        reqTable.targetName = targetName
    end
    if npcId ~= nil then
        reqTable.npcId = npcId
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqPublishOffer" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPublishOfferShareMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPublishOfferShareMessage](LuaEnumNetDef.ReqPublishOfferShareMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPublishOfferShareMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPublishOfferShareMessage", 100066, "ReqPublishOffer", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100067 撤回悬赏
---撤回悬赏
---msgID: 100067
---@param targetId number 选填参数
---@param npcId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqWithdrawOfferShare(targetId, npcId)
    local reqTable = {}
    if targetId ~= nil then
        reqTable.targetId = targetId
    end
    if npcId ~= nil then
        reqTable.npcId = npcId
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqWithdrawOffer" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqWithdrawOfferShareMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqWithdrawOfferShareMessage](LuaEnumNetDef.ReqWithdrawOfferShareMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqWithdrawOfferShareMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqWithdrawOfferShareMessage", 100067, "ReqWithdrawOffer", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:100068 请求悬赏模糊查询
---请求悬赏模糊查询
---msgID: 100068
---@param idOrName string 选填参数 参数，玩家ID或玩家名
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOfferShareSearch(idOrName)
    local reqTable = {}
    if idOrName ~= nil then
        reqTable.idOrName = idOrName
    end
    local reqMsgData = protobufMgr.Serialize("friendV2.ReqSearchFriend" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOfferShareSearchMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOfferShareSearchMessage](LuaEnumNetDef.ReqOfferShareSearchMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqOfferShareSearchMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqOfferShareSearchMessage", 100068, "ReqSearchFriend", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

