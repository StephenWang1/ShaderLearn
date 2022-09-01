--[[本文件为工具自动生成,禁止手动修改]]
--socialcontact.xml

--region ID:150001 请求送花
---请求送花
---msgID: 150001
---@param targetRid number 选填参数 对象玩家Id
---@param flowerCount number 选填参数 鲜花数量
---@param itemId number 选填参数 鲜花ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSendFlowers(targetRid, flowerCount, itemId)
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
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSendFlowersMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSendFlowersMessage](LuaEnumNetDef.ReqSendFlowersMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSendFlowersMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSendFlowersMessage", 150001, "ReqSendFlowers", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:150003 请求花的数量
---请求花的数量
---msgID: 150003
---@param itemId number 选填参数 鲜花的ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetTheFlowerCount(itemId)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    local reqMsgData = protobufMgr.Serialize("socialcontactV2.ReqGetTheFlowerCount" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetTheFlowerCountMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetTheFlowerCountMessage](LuaEnumNetDef.ReqGetTheFlowerCountMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetTheFlowerCountMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetTheFlowerCountMessage", 150003, "ReqGetTheFlowerCount", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:150007 赠送有缘人
---赠送有缘人
---msgID: 150007
---@param lid number 选填参数
---@param count number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.FatePeople(lid, count)
    local reqTable = {}
    if lid ~= nil then
        reqTable.lid = lid
    end
    if count ~= nil then
        reqTable.count = count
    end
    local reqMsgData = protobufMgr.Serialize("socialcontactV2.FatePeople" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.FatePeopleMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.FatePeopleMessage](LuaEnumNetDef.FatePeopleMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.FatePeopleMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("FatePeopleMessage", 150007, "FatePeople", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:150008 回赠
---回赠
---msgID: 150008
---@param targetRid number 选填参数 赠送有缘人的ID
---@param itemId number 选填参数 收到的itemID
---@param count number 选填参数 数量
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRebateFlower(targetRid, itemId, count)
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
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRebateFlowerMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRebateFlowerMessage](LuaEnumNetDef.ReqRebateFlowerMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRebateFlowerMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRebateFlowerMessage", 150008, "ReqRebateFlower", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:150009 回复感谢
---回复感谢
---msgID: 150009
---@param itemId number 选填参数 收到的itemID
---@param targetRid number 选填参数 收到感谢的人id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReplyToThank(itemId, targetRid)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    if targetRid ~= nil then
        reqTable.targetRid = targetRid
    end
    local reqMsgData = protobufMgr.Serialize("socialcontactV2.ReqReplyToThank" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReplyToThankMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReplyToThankMessage](LuaEnumNetDef.ReqReplyToThankMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqReplyToThankMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqReplyToThankMessage", 150009, "ReqReplyToThank", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:150010 加为好友
---加为好友
---msgID: 150010
---@param targetRid number 选填参数 ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSendFlowerAddFriend(targetRid)
    local reqTable = {}
    if targetRid ~= nil then
        reqTable.targetRid = targetRid
    end
    local reqMsgData = protobufMgr.Serialize("socialcontactV2.ReqSendFlowerAddFriend" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSendFlowerAddFriendMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSendFlowerAddFriendMessage](LuaEnumNetDef.ReqSendFlowerAddFriendMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSendFlowerAddFriendMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSendFlowerAddFriendMessage", 150010, "ReqSendFlowerAddFriend", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:150011 同意
---同意
---msgID: 150011
---@param targetRid number 选填参数 ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAgreeSendFlowerAddFriend(targetRid)
    local reqTable = {}
    if targetRid ~= nil then
        reqTable.targetRid = targetRid
    end
    local reqMsgData = protobufMgr.Serialize("socialcontactV2.ReqAgreeSendFlowerAddFriend" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAgreeSendFlowerAddFriendMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAgreeSendFlowerAddFriendMessage](LuaEnumNetDef.ReqAgreeSendFlowerAddFriendMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAgreeSendFlowerAddFriendMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAgreeSendFlowerAddFriendMessage", 150011, "ReqAgreeSendFlowerAddFriend", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

