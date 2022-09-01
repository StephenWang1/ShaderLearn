--[[本文件为工具自动生成,禁止手动修改]]
--sharesocialcontact.xml

--region ID:1500001 请求送花
---请求送花
---msgID: 1500001
---@param targetRid number 选填参数 对象玩家Id
---@param flowerCount number 选填参数 鲜花数量
---@param itemId number 选填参数 鲜花ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareSendFlowers(targetRid, flowerCount, itemId)
    local reqTable = {}
    if targetRid ~= nil then
        reqTable.targetRid = targetRid
    end
    if flowerCount ~= nil then
        reqTable.flowerCount = flowerCount
    end
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    local reqMsgData = protobufMgr.Serialize("socialcontactV2.ReqSendFlowers" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareSendFlowersMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareSendFlowersMessage](LuaEnumNetDef.ReqShareSendFlowersMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareSendFlowersMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareSendFlowersMessage", 1500001, "ReqSendFlowers", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1500003 请求花的数量
---请求花的数量
---msgID: 1500003
---@param itemId number 选填参数 鲜花的ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareGetTheFlowerCount(itemId)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    local reqMsgData = protobufMgr.Serialize("socialcontactV2.ReqGetTheFlowerCount" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareGetTheFlowerCountMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareGetTheFlowerCountMessage](LuaEnumNetDef.ReqShareGetTheFlowerCountMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareGetTheFlowerCountMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareGetTheFlowerCountMessage", 1500003, "ReqGetTheFlowerCount", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1500008 回赠
---回赠
---msgID: 1500008
---@param targetRid number 选填参数 赠送有缘人的ID
---@param itemId number 选填参数 收到的itemID
---@param count number 选填参数 数量
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareRebateFlower(targetRid, itemId, count)
    local reqTable = {}
    if targetRid ~= nil then
        reqTable.targetRid = targetRid
    end
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    if count ~= nil then
        reqTable.count = count
    end
    local reqMsgData = protobufMgr.Serialize("socialcontactV2.ReqRebateFlower" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareRebateFlowerMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareRebateFlowerMessage](LuaEnumNetDef.ReqShareRebateFlowerMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareRebateFlowerMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareRebateFlowerMessage", 1500008, "ReqRebateFlower", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1500009 回复感谢
---回复感谢
---msgID: 1500009
---@param itemId number 选填参数 收到的itemID
---@param targetRid number 选填参数 收到感谢的人id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareReplyToThank(itemId, targetRid)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    if targetRid ~= nil then
        reqTable.targetRid = targetRid
    end
    local reqMsgData = protobufMgr.Serialize("socialcontactV2.ReqReplyToThank" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareReplyToThankMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareReplyToThankMessage](LuaEnumNetDef.ReqShareReplyToThankMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareReplyToThankMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareReplyToThankMessage", 1500009, "ReqReplyToThank", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1500010 加为好友
---加为好友
---msgID: 1500010
---@param targetRid number 选填参数 ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareSendFlowerAddFriend(targetRid)
    local reqTable = {}
    if targetRid ~= nil then
        reqTable.targetRid = targetRid
    end
    local reqMsgData = protobufMgr.Serialize("socialcontactV2.ReqSendFlowerAddFriend" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareSendFlowerAddFriendMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareSendFlowerAddFriendMessage](LuaEnumNetDef.ReqShareSendFlowerAddFriendMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareSendFlowerAddFriendMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareSendFlowerAddFriendMessage", 1500010, "ReqSendFlowerAddFriend", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1500011 同意
---同意
---msgID: 1500011
---@param targetRid number 选填参数 ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareAgreeSendFlowerAddFriend(targetRid)
    local reqTable = {}
    if targetRid ~= nil then
        reqTable.targetRid = targetRid
    end
    local reqMsgData = protobufMgr.Serialize("socialcontactV2.ReqAgreeSendFlowerAddFriend" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareAgreeSendFlowerAddFriendMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareAgreeSendFlowerAddFriendMessage](LuaEnumNetDef.ReqShareAgreeSendFlowerAddFriendMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareAgreeSendFlowerAddFriendMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareAgreeSendFlowerAddFriendMessage", 1500011, "ReqAgreeSendFlowerAddFriend", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1500013 客户端请求通用消息
---客户端请求通用消息
---msgID: 1500013
---@param type number 选填参数
---@param data number 选填参数
---@param str string 选填参数
---@param data64 number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareCommon(type, data, str, data64)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if data ~= nil then
        reqTable.data = data
    end
    if str ~= nil then
        reqTable.str = str
    end
    if data64 ~= nil then
        reqTable.data64 = data64
    end
    local reqMsgData = protobufMgr.Serialize("playV2.CommonInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareCommonMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareCommonMessage](LuaEnumNetDef.ReqShareCommonMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareCommonMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareCommonMessage", 1500013, "CommonInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

