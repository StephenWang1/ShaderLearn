--[[本文件为工具自动生成,禁止手动修改]]
--union.xml

--region ID:23001 申请加入行会
---申请加入行会
---msgID: 23001
---@param unionId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqApplyForEnterUnion(unionId)
    local reqTable = {}
    reqTable.unionId = unionId
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqApplyForEnterUnion" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqApplyForEnterUnionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqApplyForEnterUnionMessage](LuaEnumNetDef.ReqApplyForEnterUnionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqApplyForEnterUnionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqApplyForEnterUnionMessage", 23001, "ReqApplyForEnterUnion", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23004 申请创建行会
---申请创建行会
---msgID: 23004
---@param name string 必填参数 行会名字
---@param unionIcon number 必填参数 行会图标
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCreateUnion(name, unionIcon)
    local reqTable = {}
    reqTable.name = name
    reqTable.unionIcon = unionIcon
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqCreateUnion" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCreateUnionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCreateUnionMessage](LuaEnumNetDef.ReqCreateUnionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqCreateUnionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqCreateUnionMessage", 23004, "ReqCreateUnion", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23006 申请修改公告
---申请修改公告
---msgID: 23006
---@param announcement string 选填参数 新行会公告
---@return boolean 网络请求是否成功发送
function networkRequest.ReqChangeAnnouncement(announcement)
    local reqTable = {}
    if announcement ~= nil then
        reqTable.announcement = announcement
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqChangeAnnouncement" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqChangeAnnouncementMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqChangeAnnouncementMessage](LuaEnumNetDef.ReqChangeAnnouncementMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqChangeAnnouncementMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqChangeAnnouncementMessage", 23006, "ReqChangeAnnouncement", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23007 请求踢出玩家
---请求踢出玩家
---msgID: 23007
---@param memberId number 选填参数 选择的玩家ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqKickOutMember(memberId)
    local reqTable = {}
    if memberId ~= nil then
        reqTable.memberId = memberId
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqKickOutMember" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqKickOutMemberMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqKickOutMemberMessage](LuaEnumNetDef.ReqKickOutMemberMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqKickOutMemberMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqKickOutMemberMessage", 23007, "ReqKickOutMember", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23008 请求获取所有行会信息
---请求获取所有行会信息
---msgID: 23008
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetAllUnionInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetAllUnionInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetAllUnionInfoMessage](LuaEnumNetDef.ReqGetAllUnionInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetAllUnionInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23009 请求调整职位
---请求调整职位
---msgID: 23009
---@param memberId number 选填参数 调整的成员ID
---@param position number 选填参数 调整的职位对应的值
---@return boolean 网络请求是否成功发送
function networkRequest.ReqChangePosition(memberId, position)
    local reqTable = {}
    if memberId ~= nil then
        reqTable.memberId = memberId
    end
    if position ~= nil then
        reqTable.position = position
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqChangePosition" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqChangePositionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqChangePositionMessage](LuaEnumNetDef.ReqChangePositionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqChangePositionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqChangePositionMessage", 23009, "ReqChangePosition", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23010 请求获取玩家行会信息
---请求获取玩家行会信息
---msgID: 23010
---@param roleId System.Collections.Generic.List1T<number> 列表参数 玩家ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetPlayerUnionInfo(roleId)
    local reqData = CS.unionV2.ReqGetPlayerUnionInfo()
    if roleId ~= nil then
        reqData.roleId:AddRange(roleId)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetPlayerUnionInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetPlayerUnionInfoMessage](LuaEnumNetDef.ReqGetPlayerUnionInfoMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetPlayerUnionInfoMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:23011 请求获取申请入会列表信息
---请求获取申请入会列表信息
---msgID: 23011
---@param roleId System.Collections.Generic.List1T<number> 列表参数 玩家ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetApplyListInfo(roleId)
    local reqData = CS.unionV2.ReqGetApplyListInfo()
    if roleId ~= nil then
        reqData.roleId:AddRange(roleId)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetApplyListInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetApplyListInfoMessage](LuaEnumNetDef.ReqGetApplyListInfoMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetApplyListInfoMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:23013 请求捐赠金钱信息
---请求捐赠金钱信息
---msgID: 23013
---@param money number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDonateMoney(money)
    local reqTable = {}
    reqTable.money = money
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqDonateMoney" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDonateMoneyMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDonateMoneyMessage](LuaEnumNetDef.ReqDonateMoneyMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDonateMoneyMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDonateMoneyMessage", 23013, "ReqDonateMoney", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23014 请求退出或者解散行会
---请求退出或者解散行会
---msgID: 23014
---@param roleId number 必填参数
---@param quitType number 选填参数 1是退出行会   2是解散行会
---@return boolean 网络请求是否成功发送
function networkRequest.ReqQuitOrDissolveUnion(roleId, quitType)
    local reqTable = {}
    reqTable.roleId = roleId
    if quitType ~= nil then
        reqTable.quitType = quitType
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqQuitOrDissolveUnion" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqQuitOrDissolveUnionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqQuitOrDissolveUnionMessage](LuaEnumNetDef.ReqQuitOrDissolveUnionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqQuitOrDissolveUnionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqQuitOrDissolveUnionMessage", 23014, "ReqQuitOrDissolveUnion", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23018 请求处理申请列表信息
---请求处理申请列表信息
---msgID: 23018
---@param roleId number 必填参数 当前操作申请的玩家
---@param applyRoleId number 必填参数 要处理的玩家ID
---@param checkState number 选填参数 处理方式 1拒绝2同意
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCheckApplyList(roleId, applyRoleId, checkState)
    local reqTable = {}
    reqTable.roleId = roleId
    reqTable.applyRoleId = applyRoleId
    if checkState ~= nil then
        reqTable.checkState = checkState
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqCheckApplyList" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCheckApplyListMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCheckApplyListMessage](LuaEnumNetDef.ReqCheckApplyListMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqCheckApplyListMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqCheckApplyListMessage", 23018, "ReqCheckApplyList", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23020 获取行会积分
---获取行会积分
---msgID: 23020
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetUnionActive()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetUnionActiveMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetUnionActiveMessage](LuaEnumNetDef.ReqGetUnionActiveMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetUnionActiveMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23022 获取行会活跃奖励信息
---获取行会活跃奖励信息
---msgID: 23022
---@param activeId number 选填参数 要领取的活跃id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetUnionActiveReward(activeId)
    local reqTable = {}
    if activeId ~= nil then
        reqTable.activeId = activeId
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqGetUnionActiveReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetUnionActiveRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetUnionActiveRewardMessage](LuaEnumNetDef.ReqGetUnionActiveRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetUnionActiveRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetUnionActiveRewardMessage", 23022, "ReqGetUnionActiveReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23023 请求设置行会按钮
---请求设置行会按钮
---msgID: 23023
---@param type number 选填参数 设置类型  1是自动加入  2是兑换装备
---@param setValue number 选填参数 设置值 0是关闭 填转生等级  或者等级
---@param extraParam number 选填参数 设置的参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUnionSetUp(type, setValue, extraParam)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if setValue ~= nil then
        reqTable.setValue = setValue
    end
    if extraParam ~= nil then
        reqTable.extraParam = extraParam
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqUnionSetUp" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUnionSetUpMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUnionSetUpMessage](LuaEnumNetDef.ReqUnionSetUpMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUnionSetUpMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUnionSetUpMessage", 23023, "ReqUnionSetUp", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23027 请求获取行会boss信息
---请求获取行会boss信息
---msgID: 23027
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetUnionBossInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetUnionBossInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetUnionBossInfoMessage](LuaEnumNetDef.ReqGetUnionBossInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetUnionBossInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23029 请求获取行会个人挑战信息
---请求获取行会个人挑战信息
---msgID: 23029
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetUnionPersonChallengetInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetUnionPersonChallengetInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetUnionPersonChallengetInfoMessage](LuaEnumNetDef.ReqGetUnionPersonChallengetInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetUnionPersonChallengetInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23032 请求行会挑战排行
---请求行会挑战排行
---msgID: 23032
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetUnionChallengeRank()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetUnionChallengeRankMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetUnionChallengeRankMessage](LuaEnumNetDef.ReqGetUnionChallengeRankMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetUnionChallengeRankMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23035 请求发送召唤公告
---请求发送召唤公告
---msgID: 23035
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSendUnionAnnounce()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSendUnionAnnounceMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSendUnionAnnounceMessage](LuaEnumNetDef.ReqSendUnionAnnounceMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqSendUnionAnnounceMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23036 发红包
---发红包
---msgID: 23036
---@param money number 选填参数 元宝数
---@param content string 选填参数 文字内容
---@param count number 选填参数 个数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSendUnionRedPack(money, content, count)
    local reqTable = {}
    if money ~= nil then
        reqTable.money = money
    end
    if content ~= nil then
        reqTable.content = content
    end
    if count ~= nil then
        reqTable.count = count
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqSendUnionRedPack" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSendUnionRedPackMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSendUnionRedPackMessage](LuaEnumNetDef.ReqSendUnionRedPackMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSendUnionRedPackMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSendUnionRedPackMessage", 23036, "ReqSendUnionRedPack", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23037 抢红包
---抢红包
---msgID: 23037
---@param redPackId number 选填参数 红包id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRobRedPack(redPackId)
    local reqTable = {}
    if redPackId ~= nil then
        reqTable.redPackId = redPackId
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqRobRedPack" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRobRedPackMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRobRedPackMessage](LuaEnumNetDef.ReqRobRedPackMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRobRedPackMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRobRedPackMessage", 23037, "ReqRobRedPack", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23039 打开红包面板
---打开红包面板
---msgID: 23039
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOpenRedPackPanel()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOpenRedPackPanelMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOpenRedPackPanelMessage](LuaEnumNetDef.ReqOpenRedPackPanelMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqOpenRedPackPanelMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23041 查看红包详情
---查看红包详情
---msgID: 23041
---@param redPackId number 选填参数 红包id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRedPackDetail(redPackId)
    local reqTable = {}
    if redPackId ~= nil then
        reqTable.redPackId = redPackId
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqRedPackDetail" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRedPackDetailMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRedPackDetailMessage](LuaEnumNetDef.ReqRedPackDetailMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRedPackDetailMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRedPackDetailMessage", 23041, "ReqRedPackDetail", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23042 领取行会挑战通关奖励
---领取行会挑战通关奖励
---msgID: 23042
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetCrossReward()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetCrossRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetCrossRewardMessage](LuaEnumNetDef.ReqGetCrossRewardMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetCrossRewardMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23044 请求召唤行会boss（进入副本）
---请求召唤行会boss（进入副本）
---msgID: 23044
---@param itemId number 选填参数 boss召唤令
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCallUnionBoss(itemId)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqCallUnionBoss" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCallUnionBossMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCallUnionBossMessage](LuaEnumNetDef.ReqCallUnionBossMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqCallUnionBossMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqCallUnionBossMessage", 23044, "ReqCallUnionBoss", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23045 请求挑战行会boss（进入副本）
---请求挑战行会boss（进入副本）
---msgID: 23045
---@param line number 选填参数 副本唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqEnterUnionBoss(line)
    local reqTable = {}
    if line ~= nil then
        reqTable.line = line
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqEnterUnionBoss" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqEnterUnionBossMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqEnterUnionBossMessage](LuaEnumNetDef.ReqEnterUnionBossMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqEnterUnionBossMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqEnterUnionBossMessage", 23045, "ReqEnterUnionBoss", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23046 请求重置行會挑戰
---请求重置行會挑戰
---msgID: 23046
---@return boolean 网络请求是否成功发送
function networkRequest.ReqResetUnionChallenge()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqResetUnionChallengeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqResetUnionChallengeMessage](LuaEnumNetDef.ReqResetUnionChallengeMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqResetUnionChallengeMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23048 请求行会挑战通关奖励信息
---请求行会挑战通关奖励信息
---msgID: 23048
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUnionChallengeCrossRewardInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUnionChallengeCrossRewardInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUnionChallengeCrossRewardInfoMessage](LuaEnumNetDef.ReqUnionChallengeCrossRewardInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqUnionChallengeCrossRewardInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23049 请求弹劾会长
---请求弹劾会长
---msgID: 23049
---@param leaderId number 必填参数 会长id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqImpeachLeader(leaderId)
    local reqTable = {}
    reqTable.leaderId = leaderId
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqImpeachLeader" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqImpeachLeaderMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqImpeachLeaderMessage](LuaEnumNetDef.ReqImpeachLeaderMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqImpeachLeaderMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqImpeachLeaderMessage", 23049, "ReqImpeachLeader", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23050 请求修改行会名字
---请求修改行会名字
---msgID: 23050
---@param newUnionName string 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqChangeUnionName(newUnionName)
    local reqTable = {}
    if newUnionName ~= nil then
        reqTable.newUnionName = newUnionName
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqChangeUnionName" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqChangeUnionNameMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqChangeUnionNameMessage](LuaEnumNetDef.ReqChangeUnionNameMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqChangeUnionNameMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqChangeUnionNameMessage", 23050, "ReqChangeUnionName", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23051 一键申请入帮
---一键申请入帮
---msgID: 23051
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOneKeyApplyForUnion()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOneKeyApplyForUnionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOneKeyApplyForUnionMessage](LuaEnumNetDef.ReqOneKeyApplyForUnionMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqOneKeyApplyForUnionMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23054 请求升级行会图腾
---请求升级行会图腾
---msgID: 23054
---@param group number 选填参数 图腾类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLevelUpUnionTotem(group)
    local reqTable = {}
    if group ~= nil then
        reqTable.group = group
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqLevelUpUnionTotem" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLevelUpUnionTotemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLevelUpUnionTotemMessage](LuaEnumNetDef.ReqLevelUpUnionTotemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqLevelUpUnionTotemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqLevelUpUnionTotemMessage", 23054, "ReqLevelUpUnionTotem", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23056 请求内推玩家加入行会
---请求内推玩家加入行会
---msgID: 23056
---@param roleId number 选填参数 被邀请者
---@return boolean 网络请求是否成功发送
function networkRequest.ReqInviteForEnterUnion(roleId)
    local reqTable = {}
    if roleId ~= nil then
        reqTable.roleId = roleId
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqInviteForEnterUnion" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqInviteForEnterUnionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqInviteForEnterUnionMessage](LuaEnumNetDef.ReqInviteForEnterUnionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqInviteForEnterUnionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqInviteForEnterUnionMessage", 23056, "ReqInviteForEnterUnion", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23058 同意内推加入行会
---同意内推加入行会
---msgID: 23058
---@param unionId number 选填参数 行会id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAgreeUnionInvite(unionId)
    local reqTable = {}
    if unionId ~= nil then
        reqTable.unionId = unionId
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqAgreeUnionInvite" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAgreeUnionInviteMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAgreeUnionInviteMessage](LuaEnumNetDef.ReqAgreeUnionInviteMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAgreeUnionInviteMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAgreeUnionInviteMessage", 23058, "ReqAgreeUnionInvite", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23059 申请解散行会
---申请解散行会
---msgID: 23059
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDissolveUnion()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDissolveUnionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDissolveUnionMessage](LuaEnumNetDef.ReqDissolveUnionMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqDissolveUnionMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23061 请求仓库背包信息
---请求仓库背包信息
---msgID: 23061
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUnionWarehouseInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUnionWarehouseInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUnionWarehouseInfoMessage](LuaEnumNetDef.ReqUnionWarehouseInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqUnionWarehouseInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23063 请求捐献装备
---请求捐献装备
---msgID: 23063
---@param EquipmentId number 选填参数 捐献装备(唯一id)
---@param count number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDonateEquip(EquipmentId, count)
    local reqTable = {}
    if EquipmentId ~= nil then
        reqTable.EquipmentId = EquipmentId
    end
    if count ~= nil then
        reqTable.count = count
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqDonateEquip" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDonateEquipMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDonateEquipMessage](LuaEnumNetDef.ReqDonateEquipMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDonateEquipMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDonateEquipMessage", 23063, "ReqDonateEquip", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23065 请求兑换装备
---请求兑换装备
---msgID: 23065
---@param itemId number 选填参数 itemId
---@param count number 选填参数 数量
---@param EquipLid table<number> 列表参数 兑换装备唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqConversionEquip(itemId, count, EquipLid)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    if count ~= nil then
        reqTable.count = count
    end
    if EquipLid ~= nil then
        reqTable.EquipLid = EquipLid
    else
        reqTable.EquipLid = {}
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqConversionEquip" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqConversionEquipMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqConversionEquipMessage](LuaEnumNetDef.ReqConversionEquipMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqConversionEquipMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqConversionEquipMessage", 23065, "ReqConversionEquip", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23067 行会领导请求销毁装备
---行会领导请求销毁装备
---msgID: 23067
---@param EquipLid number 选填参数 兑换装备(唯一id)
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDestoryEquip(EquipLid)
    local reqTable = {}
    if EquipLid ~= nil then
        reqTable.EquipLid = EquipLid
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqDestoryEquip" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDestoryEquipMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDestoryEquipMessage](LuaEnumNetDef.ReqDestoryEquipMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDestoryEquipMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDestoryEquipMessage", 23067, "ReqDestoryEquip", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23069 请求行会仓库日志记录
---请求行会仓库日志记录
---msgID: 23069
---@return boolean 网络请求是否成功发送
function networkRequest.ReqIntegral()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqIntegralMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqIntegralMessage](LuaEnumNetDef.ReqIntegralMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqIntegralMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23073 请求行会信息列表
---请求行会信息列表
---msgID: 23073
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSendAllUnionInfo()
    local reqTable = {}
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqSendAllUnionInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSendAllUnionInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSendAllUnionInfoMessage](LuaEnumNetDef.ReqSendAllUnionInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSendAllUnionInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSendAllUnionInfoMessage", 23073, "ReqSendAllUnionInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23075 请求在线会长的行会列表
---请求在线会长的行会列表
---msgID: 23075
---@param roleId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetAssistantOnlineUnionInfo(roleId)
    local reqTable = {}
    reqTable.roleId = roleId
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqGetAssistantOnlineUnionInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetAssistantOnlineUnionInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetAssistantOnlineUnionInfoMessage](LuaEnumNetDef.ReqGetAssistantOnlineUnionInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetAssistantOnlineUnionInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetAssistantOnlineUnionInfoMessage", 23075, "ReqGetAssistantOnlineUnionInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23076 请求行会成员列表
---请求行会成员列表
---msgID: 23076
---@param unionId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUnionMemberInfo(unionId)
    local reqTable = {}
    if unionId ~= nil then
        reqTable.unionId = unionId
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqUnionMemberInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUnionMemberInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUnionMemberInfoMessage](LuaEnumNetDef.ReqUnionMemberInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUnionMemberInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUnionMemberInfoMessage", 23076, "ReqUnionMemberInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23078 移除行会黑名单
---移除行会黑名单
---msgID: 23078
---@param removeRoleId number 必填参数 要移除的玩家ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRemoveBlackApplyRole(removeRoleId)
    local reqTable = {}
    reqTable.removeRoleId = removeRoleId
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqRemoveBlackApplyRole" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRemoveBlackApplyRoleMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRemoveBlackApplyRoleMessage](LuaEnumNetDef.ReqRemoveBlackApplyRoleMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRemoveBlackApplyRoleMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRemoveBlackApplyRoleMessage", 23078, "ReqRemoveBlackApplyRole", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23079 一键忽略玩家入会申请
---一键忽略玩家入会申请
---msgID: 23079
---@param unionId number 必填参数 工会ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqIgnoreAllRole(unionId)
    local reqTable = {}
    reqTable.unionId = unionId
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqIgnoreAllRole" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqIgnoreAllRoleMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqIgnoreAllRoleMessage](LuaEnumNetDef.ReqIgnoreAllRoleMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqIgnoreAllRoleMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqIgnoreAllRoleMessage", 23079, "ReqIgnoreAllRole", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23080 一键同意玩家入会申请
---一键同意玩家入会申请
---msgID: 23080
---@param unionId number 必填参数 工会ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAgreeAllRoleJoinUnion(unionId)
    local reqTable = {}
    reqTable.unionId = unionId
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqAgreeAllRoleJoinUnion" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAgreeAllRoleJoinUnionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAgreeAllRoleJoinUnionMessage](LuaEnumNetDef.ReqAgreeAllRoleJoinUnionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAgreeAllRoleJoinUnionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAgreeAllRoleJoinUnionMessage", 23080, "ReqAgreeAllRoleJoinUnion", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23081 请求拉黑的玩家列表
---请求拉黑的玩家列表
---msgID: 23081
---@param roleId number 选填参数 拉黑的玩家ID
---@param unionId number 选填参数 工会ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetBlackApplyRole(roleId, unionId)
    local reqTable = {}
    if roleId ~= nil then
        reqTable.roleId = roleId
    end
    if unionId ~= nil then
        reqTable.unionId = unionId
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqGetBlackApplyRole" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetBlackApplyRoleMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetBlackApplyRoleMessage](LuaEnumNetDef.ReqGetBlackApplyRoleMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetBlackApplyRoleMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetBlackApplyRoleMessage", 23081, "ReqGetBlackApplyRole", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23083 仅显示在线成员
---仅显示在线成员
---msgID: 23083
---@param roleId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetOnlineMember(roleId)
    local reqTable = {}
    reqTable.roleId = roleId
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqGetOnlineMember" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetOnlineMemberMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetOnlineMemberMessage](LuaEnumNetDef.ReqGetOnlineMemberMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetOnlineMemberMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetOnlineMemberMessage", 23083, "ReqGetOnlineMember", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23084 踢出公会
---踢出公会
---msgID: 23084
---@param kickRoleId number 必填参数 要T出的成员ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqKickOutGuild(kickRoleId)
    local reqTable = {}
    reqTable.kickRoleId = kickRoleId
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqKickOutGuild" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqKickOutGuildMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqKickOutGuildMessage](LuaEnumNetDef.ReqKickOutGuildMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqKickOutGuildMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqKickOutGuildMessage", 23084, "ReqKickOutGuild", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23086 进行投票
---进行投票
---msgID: 23086
---@param isAgree boolean 必填参数 玩家是否同意  true为同意
---@return boolean 网络请求是否成功发送
function networkRequest.ReqImpeachmentInfo(isAgree)
    local reqTable = {}
    reqTable.isAgree = isAgree
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqImpeachmentInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqImpeachmentInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqImpeachmentInfoMessage](LuaEnumNetDef.ReqImpeachmentInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqImpeachmentInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqImpeachmentInfoMessage", 23086, "ReqImpeachmentInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23087 请求查看弹劾票行
---请求查看弹劾票行
---msgID: 23087
---@param isAgree boolean 必填参数 玩家是否同意  true为同意
---@return boolean 网络请求是否成功发送
function networkRequest.ReqImpeachmentVote(isAgree)
    local reqTable = {}
    reqTable.isAgree = isAgree
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqImpeachmentVote" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqImpeachmentVoteMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqImpeachmentVoteMessage](LuaEnumNetDef.ReqImpeachmentVoteMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqImpeachmentVoteMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqImpeachmentVoteMessage", 23087, "ReqImpeachmentVote", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23089 请求获取仓库列表
---请求获取仓库列表
---msgID: 23089
---@param unionId number 必填参数 id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetUnionItems(unionId)
    local reqTable = {}
    reqTable.unionId = unionId
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqGetUnionItems" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetUnionItemsMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetUnionItemsMessage](LuaEnumNetDef.ReqGetUnionItemsMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetUnionItemsMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetUnionItemsMessage", 23089, "ReqGetUnionItems", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23090 请求设置自动加入
---请求设置自动加入
---msgID: 23090
---@param unionId number 选填参数 id
---@param automaticPassing number 必填参数 修改的值
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAutomaticPassing(unionId, automaticPassing)
    local reqTable = {}
    if unionId ~= nil then
        reqTable.unionId = unionId
    end
    reqTable.automaticPassing = automaticPassing
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqAutomaticPassing" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAutomaticPassingMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAutomaticPassingMessage](LuaEnumNetDef.ReqAutomaticPassingMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAutomaticPassingMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAutomaticPassingMessage", 23090, "ReqAutomaticPassing", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23093 请求所有会徽
---请求所有会徽
---msgID: 23093
---@param isReturnRare boolean 选填参数 是否返回稀有图标（返回时true，不返回是false）
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetAllUnionIcon(isReturnRare)
    local reqTable = {}
    if isReturnRare ~= nil then
        reqTable.isReturnRare = isReturnRare
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqGetAllUnionIcon" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetAllUnionIconMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetAllUnionIconMessage](LuaEnumNetDef.ReqGetAllUnionIconMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetAllUnionIconMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetAllUnionIconMessage", 23093, "ReqGetAllUnionIcon", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23095 加入行会申请或撤销加入行会申请
---加入行会申请或撤销加入行会申请
---msgID: 23095
---@param unionId number 必填参数 行会ID
---@param joinOrWithdraw number 必填参数 加入申请或撤销申请 1是加入 2是撤销
---@return boolean 网络请求是否成功发送
function networkRequest.ReqJoinOrWithdrawUnion(unionId, joinOrWithdraw)
    local reqTable = {}
    reqTable.unionId = unionId
    reqTable.joinOrWithdraw = joinOrWithdraw
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqJoinOrWithdrawUnion" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqJoinOrWithdrawUnionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqJoinOrWithdrawUnionMessage](LuaEnumNetDef.ReqJoinOrWithdrawUnionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqJoinOrWithdrawUnionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqJoinOrWithdrawUnionMessage", 23095, "ReqJoinOrWithdrawUnion", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23096 请求日志
---请求日志
---msgID: 23096
---@param unionId number 选填参数 行会ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetUnionJournal(unionId)
    local reqTable = {}
    if unionId ~= nil then
        reqTable.unionId = unionId
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqGetUnionJournal" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetUnionJournalMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetUnionJournalMessage](LuaEnumNetDef.ReqGetUnionJournalMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetUnionJournalMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetUnionJournalMessage", 23096, "ReqGetUnionJournal", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23098 请求查看行会属性
---请求查看行会属性
---msgID: 23098
---@param unionId number 选填参数 行会ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetUnionAttribute(unionId)
    local reqTable = {}
    if unionId ~= nil then
        reqTable.unionId = unionId
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqGetUnionAttribute" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetUnionAttributeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetUnionAttributeMessage](LuaEnumNetDef.ReqGetUnionAttributeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetUnionAttributeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetUnionAttributeMessage", 23098, "ReqGetUnionAttribute", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23100 请求转让会长
---请求转让会长
---msgID: 23100
---@param newMonsterId number 选填参数 转让给此人的ID
---@param position number 选填参数 职位
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAssignmentMonster(newMonsterId, position)
    local reqTable = {}
    if newMonsterId ~= nil then
        reqTable.newMonsterId = newMonsterId
    end
    if position ~= nil then
        reqTable.position = position
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqAssignmentMonster" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAssignmentMonsterMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAssignmentMonsterMessage](LuaEnumNetDef.ReqAssignmentMonsterMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAssignmentMonsterMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAssignmentMonsterMessage", 23100, "ReqAssignmentMonster", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23102 发送消息处理确认转让会长
---发送消息处理确认转让会长
---msgID: 23102
---@param oldMonsterId number 选填参数 原会长ID
---@param position number 选填参数 职位
---@param newMonsterId number 选填参数 转让给此人的ID
---@param isAgree number 选填参数 1是同意当会长  2是不同意
---@return boolean 网络请求是否成功发送
function networkRequest.YesGetUnionMonster(oldMonsterId, position, newMonsterId, isAgree)
    local reqTable = {}
    if oldMonsterId ~= nil then
        reqTable.oldMonsterId = oldMonsterId
    end
    if position ~= nil then
        reqTable.position = position
    end
    if newMonsterId ~= nil then
        reqTable.newMonsterId = newMonsterId
    end
    if isAgree ~= nil then
        reqTable.isAgree = isAgree
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.YesGetUnionMonster" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.YesGetUnionMonsterMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.YesGetUnionMonsterMessage](LuaEnumNetDef.YesGetUnionMonsterMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.YesGetUnionMonsterMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("YesGetUnionMonsterMessage", 23102, "YesGetUnionMonster", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23104 请求行会升级
---请求行会升级
---msgID: 23104
---@param toLevel number 选填参数 要升到几级（或者说要降到几级）
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUnionUpgrade(toLevel)
    local reqTable = {}
    if toLevel ~= nil then
        reqTable.toLevel = toLevel
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqUnionUpgrade" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUnionUpgradeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUnionUpgradeMessage](LuaEnumNetDef.ReqUnionUpgradeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUnionUpgradeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUnionUpgradeMessage", 23104, "ReqUnionUpgrade", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23105 请求仓库一个格子的所有数据
---请求仓库一个格子的所有数据
---msgID: 23105
---@param itemId number 选填参数 装备的itemId
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetBagItemInfo(itemId)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqGetBagItemInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetBagItemInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetBagItemInfoMessage](LuaEnumNetDef.ReqGetBagItemInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetBagItemInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetBagItemInfoMessage", 23105, "ReqGetBagItemInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23107 请求改变行会图腾
---请求改变行会图腾
---msgID: 23107
---@param unionIcon number 选填参数 要升到几级（或者说要降到几级）
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUnionBadgeReplace(unionIcon)
    local reqTable = {}
    if unionIcon ~= nil then
        reqTable.unionIcon = unionIcon
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqUnionBadgeReplace" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUnionBadgeReplaceMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUnionBadgeReplaceMessage](LuaEnumNetDef.ReqUnionBadgeReplaceMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUnionBadgeReplaceMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUnionBadgeReplaceMessage", 23107, "ReqUnionBadgeReplace", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23108 请求改变行会升级的红点提示
---请求改变行会升级的红点提示
---msgID: 23108
---@param unionId number 选填参数 行会ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUpdateUnionUpgradeRedPoint(unionId)
    local reqTable = {}
    if unionId ~= nil then
        reqTable.unionId = unionId
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqUpdateUnionUpgradeRedPoint" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUpdateUnionUpgradeRedPointMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUpdateUnionUpgradeRedPointMessage](LuaEnumNetDef.ReqUpdateUnionUpgradeRedPointMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUpdateUnionUpgradeRedPointMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUpdateUnionUpgradeRedPointMessage", 23108, "ReqUpdateUnionUpgradeRedPoint", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23109 请求改变行会召唤令的使用职位
---请求改变行会召唤令的使用职位
---msgID: 23109
---@param position number 选填参数 职位
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUpdateUnionCallBackUsePosition(position)
    local reqTable = {}
    if position ~= nil then
        reqTable.position = position
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqUpdateUnionCallBackUsePosition" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUpdateUnionCallBackUsePositionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUpdateUnionCallBackUsePositionMessage](LuaEnumNetDef.ReqUpdateUnionCallBackUsePositionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUpdateUnionCallBackUsePositionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUpdateUnionCallBackUsePositionMessage", 23109, "ReqUpdateUnionCallBackUsePosition", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23110 会长选举请求参选
---会长选举请求参选
---msgID: 23110
---@return boolean 网络请求是否成功发送
function networkRequest.ReqJoinElection()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqJoinElectionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqJoinElectionMessage](LuaEnumNetDef.ReqJoinElectionMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqJoinElectionMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23111 会长选举投票请求
---会长选举投票请求
---msgID: 23111
---@param roleId number 必填参数 投给谁
---@param count number 选填参数 投几票
---@return boolean 网络请求是否成功发送
function networkRequest.ReqElectionVote(roleId, count)
    local reqTable = {}
    reqTable.roleId = roleId
    if count ~= nil then
        reqTable.count = count
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqElectionVote" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqElectionVoteMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqElectionVoteMessage](LuaEnumNetDef.ReqElectionVoteMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqElectionVoteMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqElectionVoteMessage", 23111, "ReqElectionVote", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23112 请求合并
---请求合并
---msgID: 23112
---@param unionId number 必填参数 目标行会 id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCombineUnion(unionId)
    local reqTable = {}
    reqTable.unionId = unionId
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqCombineUnion" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCombineUnionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCombineUnionMessage](LuaEnumNetDef.ReqCombineUnionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqCombineUnionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqCombineUnionMessage", 23112, "ReqCombineUnion", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23114 确认合并
---确认合并
---msgID: 23114
---@param unionId number 必填参数 申请行会 id
---@param agree number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqConfirmCombineUnion(unionId, agree)
    local reqTable = {}
    reqTable.unionId = unionId
    reqTable.agree = agree
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqConfirmCombineUnion" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqConfirmCombineUnionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqConfirmCombineUnionMessage](LuaEnumNetDef.ReqConfirmCombineUnionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqConfirmCombineUnionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqConfirmCombineUnionMessage", 23114, "ReqConfirmCombineUnion", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23115 请求战利品仓库
---请求战利品仓库
---msgID: 23115
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSpoilsHouse()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSpoilsHouseMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSpoilsHouseMessage](LuaEnumNetDef.ReqSpoilsHouseMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqSpoilsHouseMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23117 请求发放战利品
---请求发放战利品
---msgID: 23117
---@param SpoilsId number 选填参数 唯一id
---@param num number 选填参数 每个人数量
---@param memberList System.Collections.Generic.List1T<number> 列表参数 成员列表
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGiveSpoils(SpoilsId, num, memberList)
    local reqData = CS.unionV2.ReqGiveSpoils()
    if SpoilsId ~= nil then
        reqData.SpoilsId = SpoilsId
    end
    if num ~= nil then
        reqData.num = num
    end
    if memberList ~= nil then
        reqData.memberList:AddRange(memberList)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGiveSpoilsMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGiveSpoilsMessage](LuaEnumNetDef.ReqGiveSpoilsMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGiveSpoilsMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:23119 请求可发放战利品的成员列表
---请求可发放战利品的成员列表
---msgID: 23119
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCanGetSpoilsMembers()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCanGetSpoilsMembersMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCanGetSpoilsMembersMessage](LuaEnumNetDef.ReqCanGetSpoilsMembersMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqCanGetSpoilsMembersMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23121 领取占领城市的税收
---领取占领城市的税收
---msgID: 23121
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReceiveSeizeCityTax()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReceiveSeizeCityTaxMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReceiveSeizeCityTaxMessage](LuaEnumNetDef.ReqReceiveSeizeCityTaxMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqReceiveSeizeCityTaxMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23123 一键招人请求
---一键招人请求
---msgID: 23123
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOneKeyRecruit()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOneKeyRecruitMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOneKeyRecruitMessage](LuaEnumNetDef.ReqOneKeyRecruitMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqOneKeyRecruitMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23125 会长切换语音权限
---会长切换语音权限
---msgID: 23125
---@param roleId number 必填参数
---@param canSend number 必填参数 非 0 有权限
---@return boolean 网络请求是否成功发送
function networkRequest.ReqToggleSendVoice(roleId, canSend)
    local reqTable = {}
    reqTable.roleId = roleId
    reqTable.canSend = canSend
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqToggleSendVoice" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqToggleSendVoiceMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqToggleSendVoiceMessage](LuaEnumNetDef.ReqToggleSendVoiceMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqToggleSendVoiceMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqToggleSendVoiceMessage", 23125, "ReqToggleSendVoice", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23126 切换语音开关
---切换语音开关
---msgID: 23126
---@param open number 必填参数 非 0 开启
---@return boolean 网络请求是否成功发送
function networkRequest.ReqToggleVoiceOpen(open)
    local reqTable = {}
    reqTable.open = open
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqToggleVoiceOpen" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqToggleVoiceOpenMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqToggleVoiceOpenMessage](LuaEnumNetDef.ReqToggleVoiceOpenMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqToggleVoiceOpenMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqToggleVoiceOpenMessage", 23126, "ReqToggleVoiceOpen", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23129 魔法阵信息
---魔法阵信息
---msgID: 23129
---@return boolean 网络请求是否成功发送
function networkRequest.ReqMagicCircleInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqMagicCircleInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqMagicCircleInfoMessage](LuaEnumNetDef.ReqMagicCircleInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqMagicCircleInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23131 请求红包信息
---请求红包信息
---msgID: 23131
---@param id number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUnionRedBagInfo(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqUnionRedBagInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUnionRedBagInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUnionRedBagInfoMessage](LuaEnumNetDef.ReqUnionRedBagInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUnionRedBagInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUnionRedBagInfoMessage", 23131, "ReqUnionRedBagInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23133 发送红包
---发送红包
---msgID: 23133
---@param id number 选填参数 战利品id
---@param money number 选填参数
---@param count number 选填参数 可领人数
---@param type number 选填参数 id == 0时，1=钻石类型  2=元宝类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUnionSendRedBag(id, money, count, type)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    if money ~= nil then
        reqTable.money = money
    end
    if count ~= nil then
        reqTable.count = count
    end
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqSendRedBag" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUnionSendRedBagMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUnionSendRedBagMessage](LuaEnumNetDef.ReqUnionSendRedBagMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUnionSendRedBagMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUnionSendRedBagMessage", 23133, "ReqSendRedBag", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23134 领取红包
---领取红包
---msgID: 23134
---@param id number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRecieveUnionRedBag(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqRecieveUnionRedBag" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRecieveUnionRedBagMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRecieveUnionRedBagMessage](LuaEnumNetDef.ReqRecieveUnionRedBagMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRecieveUnionRedBagMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRecieveUnionRedBagMessage", 23134, "ReqRecieveUnionRedBag", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23135 切换喇叭状态
---切换喇叭状态
---msgID: 23135
---@return boolean 网络请求是否成功发送
function networkRequest.ReqToggleSpeaker()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqToggleSpeakerMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqToggleSpeakerMessage](LuaEnumNetDef.ReqToggleSpeakerMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqToggleSpeakerMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23137 请求帮会召唤令信息
---请求帮会召唤令信息
---msgID: 23137
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUnionCallBackInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUnionCallBackInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUnionCallBackInfoMessage](LuaEnumNetDef.ReqUnionCallBackInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqUnionCallBackInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23142 请求查看行会复仇
---请求查看行会复仇
---msgID: 23142
---@return boolean 网络请求是否成功发送
function networkRequest.ReqToViewUnionRevenge()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqToViewUnionRevengeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqToViewUnionRevengeMessage](LuaEnumNetDef.ReqToViewUnionRevengeMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqToViewUnionRevengeMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23144 行会复仇请求领奖
---行会复仇请求领奖
---msgID: 23144
---@param id number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRewardUnionRevenge(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqRewardUnionRevenge" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRewardUnionRevengeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRewardUnionRevengeMessage](LuaEnumNetDef.ReqRewardUnionRevengeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRewardUnionRevengeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRewardUnionRevengeMessage", 23144, "ReqRewardUnionRevenge", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23147 消耗元宝请求定位仇人位置
---消耗元宝请求定位仇人位置
---msgID: 23147
---@param id number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetRevengePoint(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.ReqGetRevengePoint" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetRevengePointMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetRevengePointMessage](LuaEnumNetDef.ReqGetRevengePointMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetRevengePointMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetRevengePointMessage", 23147, "ReqGetRevengePoint", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23149 联服同盟投票
---联服同盟投票
---msgID: 23149
---@param uniteUnionType number 选填参数 同盟类型
---@param uniteUnionCount number 选填参数 投票个数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqWillJoinUniteUnion(uniteUnionType, uniteUnionCount)
    local reqTable = {}
    if uniteUnionType ~= nil then
        reqTable.uniteUnionType = uniteUnionType
    end
    if uniteUnionCount ~= nil then
        reqTable.uniteUnionCount = uniteUnionCount
    end
    local reqMsgData = protobufMgr.Serialize("unionV2.WillJoinUniteUnionInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqWillJoinUniteUnionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqWillJoinUniteUnionMessage](LuaEnumNetDef.ReqWillJoinUniteUnionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqWillJoinUniteUnionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqWillJoinUniteUnionMessage", 23149, "WillJoinUniteUnionInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23151 请求所有联服同盟投票
---请求所有联服同盟投票
---msgID: 23151
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAllWillJoinUniteUnion()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAllWillJoinUniteUnionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAllWillJoinUniteUnionMessage](LuaEnumNetDef.ReqAllWillJoinUniteUnionMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqAllWillJoinUniteUnionMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23152 请求所有服所有联服同盟投票
---请求所有服所有联服同盟投票
---msgID: 23152
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAllOtherWillJoinUniteUnion()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAllOtherWillJoinUniteUnionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAllOtherWillJoinUniteUnionMessage](LuaEnumNetDef.ReqAllOtherWillJoinUniteUnionMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqAllOtherWillJoinUniteUnionMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23156 请求鼓舞buff的信息
---请求鼓舞buff的信息
---msgID: 23156
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUnionBossBuffInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUnionBossBuffInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUnionBossBuffInfoMessage](LuaEnumNetDef.ReqUnionBossBuffInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqUnionBossBuffInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:23158 花钱鼓舞
---花钱鼓舞
---msgID: 23158
---@param type number 必填参数 1为个人,2为行会.
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUnionBossAddBuff(type)
    local reqTable = {}
    reqTable.type = type
    local reqMsgData = protobufMgr.Serialize("unionV2.UnionBossAddBuff" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUnionBossAddBuffMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUnionBossAddBuffMessage](LuaEnumNetDef.ReqUnionBossAddBuffMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUnionBossAddBuffMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUnionBossAddBuffMessage", 23158, "UnionBossAddBuff", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:23159 用于客户端进入场景请求排行榜
---用于客户端进入场景请求排行榜
---msgID: 23159
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUnionBossRank()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUnionBossRankMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUnionBossRankMessage](LuaEnumNetDef.ReqUnionBossRankMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqUnionBossRankMessage, nil, true)
    end
    return canSendMsg
end
--endregion

