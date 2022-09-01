--[[本文件为工具自动生成,禁止手动修改]]
--union.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---申请入会状态变化
---msgID: 23002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResApplyForUnionStateChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23002 unionV2.ResApplyForUnionStateChange 申请入会状态变化")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResApplyForUnionStateChange", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResApplyForUnionStateChange ~= nil then
        protoAdjust.union_adj.AdjustResApplyForUnionStateChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23002
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送行会列表信息
---msgID: 23003
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSendAllUnionInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23003 unionV2.ResSendAllUnionInfo 发送行会列表信息")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResSendAllUnionInfo", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResSendAllUnionInfo ~= nil then
        protoAdjust.union_adj.AdjustResSendAllUnionInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23003
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送玩家所在行会信息
---msgID: 23005
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSendPlayerUnionInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23005 unionV2.ResSendPlayerUnionInfo 发送玩家所在行会信息")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResSendPlayerUnionInfo", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResSendPlayerUnionInfo ~= nil then
        protoAdjust.union_adj.AdjustResSendPlayerUnionInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23005
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送申请入会列表信息
---msgID: 23012
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSendApplyListInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23012 unionV2.ResSendApplyListInfo 发送申请入会列表信息")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResSendApplyListInfo", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResSendApplyListInfo ~= nil then
        protoAdjust.union_adj.AdjustResSendApplyListInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23012
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送退出行会成功信息
---msgID: 23015
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSendQuitUnionSuccessMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23015 unionV2.ResSendQuitUnionSuccess 发送退出行会成功信息")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResSendQuitUnionSuccess", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResSendQuitUnionSuccess ~= nil then
        protoAdjust.union_adj.AdjustResSendQuitUnionSuccess(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23015
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送修改公告信息
---msgID: 23016
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSendChangeAnnounceMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23016 unionV2.ResSendChangeAnnounce 发送修改公告信息")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResSendChangeAnnounce", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResSendChangeAnnounce ~= nil then
        protoAdjust.union_adj.AdjustResSendChangeAnnounce(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23016
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送调整职位信息
---msgID: 23017
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSendChangePositionMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23017 unionV2.ResSendChangePosition 发送调整职位信息")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResSendChangePosition", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResSendChangePosition ~= nil then
        protoAdjust.union_adj.AdjustResSendChangePosition(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23017
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送内推信息至被邀请者
---msgID: 23057
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResInviteForEnterUnionMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23057 unionV2.ResInviteForEnterUnion 发送内推信息至被邀请者")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResInviteForEnterUnion", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResInviteForEnterUnion ~= nil then
        protoAdjust.union_adj.AdjustResInviteForEnterUnion(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23057
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回解散行会
---msgID: 23060
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDissolveUnionMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23060 unionV2.ResDissolveUnion 返回解散行会")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResDissolveUnion", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResDissolveUnion ~= nil then
        protoAdjust.union_adj.AdjustResDissolveUnion(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23060
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回请求行会仓库
---msgID: 23062
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnionWarehouseInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23062 unionV2.ResUnionWarehouseInfo 返回请求行会仓库")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResUnionWarehouseInfo", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResUnionWarehouseInfo ~= nil then
        protoAdjust.union_adj.AdjustResUnionWarehouseInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23062
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回成功创建行会信息
---msgID: 23071
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSendCreateUnionSuccessMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23071 unionV2.ResSendCreateUnionSuccess 返回成功创建行会信息")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResSendCreateUnionSuccess", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResSendCreateUnionSuccess ~= nil then
        protoAdjust.union_adj.AdjustResSendCreateUnionSuccess(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23071
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回捐赠金钱信息
---msgID: 23072
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDonateMoneyMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23072 unionV2.ResDonateMoney 返回捐赠金钱信息")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResDonateMoney", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResDonateMoney ~= nil then
        protoAdjust.union_adj.AdjustResDonateMoney(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23072
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回行会成员列表
---msgID: 23077
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnionMemberInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23077 unionV2.ResUnionMemberInfo 返回行会成员列表")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResUnionMemberInfo", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResUnionMemberInfo ~= nil then
        protoAdjust.union_adj.AdjustResUnionMemberInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23077
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回拉黑的玩家列表
---msgID: 23082
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetBlackApplyRoleMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23082 unionV2.ResGetBlackApplyRole 返回拉黑的玩家列表")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResGetBlackApplyRole", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResGetBlackApplyRole ~= nil then
        protoAdjust.union_adj.AdjustResGetBlackApplyRole(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23082
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回被T的人的公会ID和名字
---msgID: 23085
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResKickOutGuildMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23085 unionV2.ResKickOutGuild 返回被T的人的公会ID和名字")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResKickOutGuild", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResKickOutGuild ~= nil then
        protoAdjust.union_adj.AdjustResKickOutGuild(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23085
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回弹劾票行
---msgID: 23088
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResImpeachmentVoteMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23088 unionV2.ResImpeachmentVote 返回弹劾票行")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResImpeachmentVote", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResImpeachmentVote ~= nil then
        protoAdjust.union_adj.AdjustResImpeachmentVote(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23088
    protobufMgr.mMsgDeserializedTblCache = res
end

---行会改变消息
---msgID: 23091
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTheUnionChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23091 unionV2.ResTheUnionChange 行会改变消息")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResTheUnionChange", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResTheUnionChange ~= nil then
        protoAdjust.union_adj.AdjustResTheUnionChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23091
    protobufMgr.mMsgDeserializedTblCache = res
end

---行会改变向周围玩家发送消息
---msgID: 23092
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnionNameChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23092 unionV2.ResUnionNameChange 行会改变向周围玩家发送消息")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResUnionNameChange", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResUnionNameChange ~= nil then
        protoAdjust.union_adj.AdjustResUnionNameChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23092
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回所有会徽
---msgID: 23094
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetAllUnionIconMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23094 unionV2.ResGetAllUnionIcon 返回所有会徽")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResGetAllUnionIcon", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResGetAllUnionIcon ~= nil then
        protoAdjust.union_adj.AdjustResGetAllUnionIcon(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23094
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回日志
---msgID: 23097
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetUnionJournalMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23097 unionV2.ResGetUnionJournal 返回日志")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResGetUnionJournal", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResGetUnionJournal ~= nil then
        protoAdjust.union_adj.AdjustResGetUnionJournal(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23097
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回行会属性
---msgID: 23099
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetUnionAttributeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23099 unionV2.ResGetUnionAttribute 返回行会属性")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResGetUnionAttribute", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResGetUnionAttribute ~= nil then
        protoAdjust.union_adj.AdjustResGetUnionAttribute(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23099
    protobufMgr.mMsgDeserializedTblCache = res
end

---收到了请求转让会长消息
---msgID: 23101
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnGetAssignmentMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23101 unionV2.GetAssignment 收到了请求转让会长消息")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.GetAssignment", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustGetAssignment ~= nil then
        protoAdjust.union_adj.AdjustGetAssignment(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23101
    protobufMgr.mMsgDeserializedTblCache = res
end

---发给双方转让会长处理的消息
---msgID: 23103
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnHandlingSuccessMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23103 unionV2.HandlingSuccess 发给双方转让会长处理的消息")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.HandlingSuccess", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustHandlingSuccess ~= nil then
        protoAdjust.union_adj.AdjustHandlingSuccess(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23103
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回行会仓库一个格子的所有数据
---msgID: 23106
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetBagItemInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23106 unionV2.ResGetBagItemInfo 返回行会仓库一个格子的所有数据")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResGetBagItemInfo", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResGetBagItemInfo ~= nil then
        protoAdjust.union_adj.AdjustResGetBagItemInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23106
    protobufMgr.mMsgDeserializedTblCache = res
end

---请求合并响应
---msgID: 23113
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResApplyCombineUnionMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23113 unionV2.ResApplyCombineUnion 请求合并响应")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResApplyCombineUnion", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResApplyCombineUnion ~= nil then
        protoAdjust.union_adj.AdjustResApplyCombineUnion(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23113
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回战利品仓库
---msgID: 23116
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSpoilsHouseMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23116 unionV2.ResSpoilsHouse 返回战利品仓库")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResSpoilsHouse", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResSpoilsHouse ~= nil then
        protoAdjust.union_adj.AdjustResSpoilsHouse(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23116
    protobufMgr.mMsgDeserializedTblCache = res
end

---战利品仓库更新消息
---msgID: 23118
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSpoilsHouseUpdateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23118 unionV2.ResSpoilsHouseUpdate 战利品仓库更新消息")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResSpoilsHouseUpdate", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResSpoilsHouseUpdate ~= nil then
        protoAdjust.union_adj.AdjustResSpoilsHouseUpdate(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23118
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回可发放战利品的成员列表
---msgID: 23120
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCanGetSpoilsMembersMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23120 unionV2.ResCanGetSpoilsMembers 返回可发放战利品的成员列表")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResCanGetSpoilsMembers", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResCanGetSpoilsMembers ~= nil then
        protoAdjust.union_adj.AdjustResCanGetSpoilsMembers(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23120
    protobufMgr.mMsgDeserializedTblCache = res
end

---更新行会今天的税收
---msgID: 23122
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUpdateTodayCityTaxMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23122 unionV2.updateTodayCityTax 更新行会今天的税收")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.updateTodayCityTax", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustupdateTodayCityTax ~= nil then
        protoAdjust.union_adj.AdjustupdateTodayCityTax(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23122
    protobufMgr.mMsgDeserializedTblCache = res
end

---语音权限信息
---msgID: 23124
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnionVoiceStatusMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23124 unionV2.UnionVoiceStatus 语音权限信息")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.UnionVoiceStatus", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustUnionVoiceStatus ~= nil then
        protoAdjust.union_adj.AdjustUnionVoiceStatus(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23124
    protobufMgr.mMsgDeserializedTblCache = res
end

---新行会消息
---msgID: 23127
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnionChatAnnounceMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23127 unionV2.ResUnionChatAnnounce 新行会消息")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResUnionChatAnnounce", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResUnionChatAnnounce ~= nil then
        protoAdjust.union_adj.AdjustResUnionChatAnnounce(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23127
    protobufMgr.mMsgDeserializedTblCache = res
end

---魔法阵开始
---msgID: 23128
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMagicCircleStartMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23128 unionV2.ResMagicCircleStart 魔法阵开始")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResMagicCircleStart", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResMagicCircleStart ~= nil then
        protoAdjust.union_adj.AdjustResMagicCircleStart(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23128
    protobufMgr.mMsgDeserializedTblCache = res
end

---魔法阵信息
---msgID: 23130
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMagicCircleInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23130 unionV2.ResMagicCircleInfo 魔法阵信息")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResMagicCircleInfo", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResMagicCircleInfo ~= nil then
        protoAdjust.union_adj.AdjustResMagicCircleInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23130
    protobufMgr.mMsgDeserializedTblCache = res
end

---红包信息响应
---msgID: 23132
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnionRedBagInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23132 unionV2.ResUnionRedBagInfo 红包信息响应")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResUnionRedBagInfo", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResUnionRedBagInfo ~= nil then
        protoAdjust.union_adj.AdjustResUnionRedBagInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23132
    protobufMgr.mMsgDeserializedTblCache = res
end

---行会成员喇叭状态
---msgID: 23136
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnionSpeakerStatusMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23136 unionV2.ResUnionSpeakerStatus 行会成员喇叭状态")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResUnionSpeakerStatus", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResUnionSpeakerStatus ~= nil then
        protoAdjust.union_adj.AdjustResUnionSpeakerStatus(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23136
    protobufMgr.mMsgDeserializedTblCache = res
end

---响应帮会召唤令信息
---msgID: 23138
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnionCallBackInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23138 unionV2.ResUnionCallBackInfo 响应帮会召唤令信息")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResUnionCallBackInfo", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResUnionCallBackInfo ~= nil then
        protoAdjust.union_adj.AdjustResUnionCallBackInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23138
    protobufMgr.mMsgDeserializedTblCache = res
end

---魔法阵boss召唤
---msgID: 23139
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnionMagicCallBossMessageReceived(msgID, buffer)
end

---魔法阵boss积分排行
---msgID: 23140
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnionMagicBossRankMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23140 unionV2.ResUnionMagicBossRank 魔法阵boss积分排行")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResUnionMagicBossRank", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResUnionMagicBossRank ~= nil then
        protoAdjust.union_adj.AdjustResUnionMagicBossRank(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23140
    protobufMgr.mMsgDeserializedTblCache = res
end

---更新代理会长职位
---msgID: 23141
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUpdateAgencyChairmanMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23141 unionV2.ResUpdateAgencyChairman 更新代理会长职位")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResUpdateAgencyChairman", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResUpdateAgencyChairman ~= nil then
        protoAdjust.union_adj.AdjustResUpdateAgencyChairman(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23141
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回查看行会复仇
---msgID: 23143
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResToViewUnionRevengeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23143 unionV2.ResToViewUnionRevenge 返回查看行会复仇")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResToViewUnionRevenge", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResToViewUnionRevenge ~= nil then
        protoAdjust.union_adj.AdjustResToViewUnionRevenge(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23143
    protobufMgr.mMsgDeserializedTblCache = res
end

---行会复仇领奖返回
---msgID: 23145
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRewardUnionRevengeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23145 unionV2.ResRewardUnionRevenge 行会复仇领奖返回")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResRewardUnionRevenge", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResRewardUnionRevenge ~= nil then
        protoAdjust.union_adj.AdjustResRewardUnionRevenge(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23145
    protobufMgr.mMsgDeserializedTblCache = res
end

---刷新一个行会仇人
---msgID: 23146
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAddUnionRevengeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23146 unionV2.ResAddUnionRevenge 刷新一个行会仇人")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResAddUnionRevenge", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResAddUnionRevenge ~= nil then
        protoAdjust.union_adj.AdjustResAddUnionRevenge(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23146
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回仇人位置
---msgID: 23148
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetRevengePointMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23148 unionV2.ResGetRevengePoint 返回仇人位置")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.ResGetRevengePoint", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustResGetRevengePoint ~= nil then
        protoAdjust.union_adj.AdjustResGetRevengePoint(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23148
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回所有联服同盟投票
---msgID: 23150
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAllWillJoinUniteUnionMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23150 unionV2.AllWillJoinUniteUnion 返回所有联服同盟投票")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.AllWillJoinUniteUnion", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustAllWillJoinUniteUnion ~= nil then
        protoAdjust.union_adj.AdjustAllWillJoinUniteUnion(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23150
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回所有服所有联服同盟投票
---msgID: 23153
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAllOtherWillJoinUniteUnionMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23153 unionV2.OtherAllUniteUnionVoteInfo 返回所有服所有联服同盟投票")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.OtherAllUniteUnionVoteInfo", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustOtherAllUniteUnionVoteInfo ~= nil then
        protoAdjust.union_adj.AdjustOtherAllUniteUnionVoteInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23153
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回个人排行榜,进副本就推,
---msgID: 23154
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnionBossPlayerRankInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23154 unionV2.UnionBossPlayerRankInfo 返回个人排行榜,进副本就推,")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.UnionBossPlayerRankInfo", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustUnionBossPlayerRankInfo ~= nil then
        protoAdjust.union_adj.AdjustUnionBossPlayerRankInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23154
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回公会排行榜, 进副本就推
---msgID: 23155
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnionBossUnionRankInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23155 unionV2.UnionBossUnionRankInfo 返回公会排行榜, 进副本就推")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.UnionBossUnionRankInfo", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustUnionBossUnionRankInfo ~= nil then
        protoAdjust.union_adj.AdjustUnionBossUnionRankInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23155
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回鼓舞buff的信息
---msgID: 23157
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnionBossBuffInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 23157 unionV2.UnionBossBuffInfo 返回鼓舞buff的信息")
        return nil
    end
    local res = protobufMgr.Deserialize("unionV2.UnionBossBuffInfo", buffer)
    if protoAdjust.union_adj ~= nil and protoAdjust.union_adj.AdjustUnionBossBuffInfo ~= nil then
        protoAdjust.union_adj.AdjustUnionBossBuffInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 23157
    protobufMgr.mMsgDeserializedTblCache = res
end

