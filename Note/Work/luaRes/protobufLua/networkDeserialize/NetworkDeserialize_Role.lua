--[[本文件为工具自动生成,禁止手动修改]]
--role.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---通知属性发生变化
---msgID: 8001
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPlayerAttributeChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8001 roleV2.ResPlayerAttributeChange 通知属性发生变化")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResPlayerAttributeChange", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResPlayerAttributeChange ~= nil then
        protoAdjust.role_adj.AdjustResPlayerAttributeChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8001
    protobufMgr.mMsgDeserializedTblCache = res
end

---通知玩家经验发生变化
---msgID: 8003
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPlayerExpChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8003 roleV2.ResPlayerExpChange 通知玩家经验发生变化")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResPlayerExpChange", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResPlayerExpChange ~= nil then
        protoAdjust.role_adj.AdjustResPlayerExpChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8003
    protobufMgr.mMsgDeserializedTblCache = res
end

---通知玩家等级发生变化
---msgID: 8004
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPlayerLevelChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8004 roleV2.ResPlayerLevelChange 通知玩家等级发生变化")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResPlayerLevelChange", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResPlayerLevelChange ~= nil then
        protoAdjust.role_adj.AdjustResPlayerLevelChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8004
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送角色转生信息
---msgID: 8007
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSendRoleReinInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8007 roleV2.ResSendRoleReinInfo 发送角色转生信息")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResSendRoleReinInfo", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResSendRoleReinInfo ~= nil then
        protoAdjust.role_adj.AdjustResSendRoleReinInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8007
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送角色兑换修为结果
---msgID: 8010
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRoleExchangeReinResultMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8010 roleV2.ResRoleExchangeReinResult 发送角色兑换修为结果")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResRoleExchangeReinResult", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResRoleExchangeReinResult ~= nil then
        protoAdjust.role_adj.AdjustResRoleExchangeReinResult(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8010
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送总战斗力
---msgID: 8011
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTotalFightValueChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8011 roleV2.ResTotalFightValueChange 发送总战斗力")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResTotalFightValueChange", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResTotalFightValueChange ~= nil then
        protoAdjust.role_adj.AdjustResTotalFightValueChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8011
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送内功信息
---msgID: 8027
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSendInnerPowerInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8027 roleV2.ResSendInnerPowerInfo 发送内功信息")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResSendInnerPowerInfo", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResSendInnerPowerInfo ~= nil then
        protoAdjust.role_adj.AdjustResSendInnerPowerInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8027
    protobufMgr.mMsgDeserializedTblCache = res
end

---内功信息变化
---msgID: 8029
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResInnerPowerInfoChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8029 roleV2.ResInnerPowerInfoChange 内功信息变化")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResInnerPowerInfoChange", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResInnerPowerInfoChange ~= nil then
        protoAdjust.role_adj.AdjustResInnerPowerInfoChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8029
    protobufMgr.mMsgDeserializedTblCache = res
end

---查看其他玩家信息响应
---msgID: 8036
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOtherRoleInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8036 roleV2.RoleToOtherInfo 查看其他玩家信息响应")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.RoleToOtherInfo", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustRoleToOtherInfo ~= nil then
        protoAdjust.role_adj.AdjustRoleToOtherInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8036
    protobufMgr.mMsgDeserializedTblCache = res
end

---转生成功
---msgID: 8044
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRoleReinSuccessReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8044 roleV2.ResRoleReinSuccess 转生成功")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResRoleReinSuccess", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResRoleReinSuccess ~= nil then
        protoAdjust.role_adj.AdjustResRoleReinSuccess(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8044
    protobufMgr.mMsgDeserializedTblCache = res
end

---系统开启提醒
---msgID: 8045
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnSystemOpenReminderMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8045 roleV2.SystemOpenReminder 系统开启提醒")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.SystemOpenReminder", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustSystemOpenReminder ~= nil then
        protoAdjust.role_adj.AdjustSystemOpenReminder(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8045
    protobufMgr.mMsgDeserializedTblCache = res
end

---打开快捷栏
---msgID: 8046
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOpenKeySettingPanelMessageReceived(msgID, buffer)
end

---在线增加泡点经验消息
---msgID: 8047
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBubbleOnlineExpMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8047 roleV2.ResBubbleOnlineExp 在线增加泡点经验消息")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResBubbleOnlineExp", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResBubbleOnlineExp ~= nil then
        protoAdjust.role_adj.AdjustResBubbleOnlineExp(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8047
    protobufMgr.mMsgDeserializedTblCache = res
end

---泡点结束消息
---msgID: 8048
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOverBubblePointMessageReceived(msgID, buffer)
end

---返回泡点离线经验消息
---msgID: 8049
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBubbleOfflineExpMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8049 roleV2.BubbleOfflineExp 返回泡点离线经验消息")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.BubbleOfflineExp", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustBubbleOfflineExp ~= nil then
        protoAdjust.role_adj.AdjustBubbleOfflineExp(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8049
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回领取离线泡点经验
---msgID: 8051
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResReceiveBubbleOfflineExpMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8051 roleV2.BubbleOfflineExp 返回领取离线泡点经验")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.BubbleOfflineExp", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustBubbleOfflineExp ~= nil then
        protoAdjust.role_adj.AdjustBubbleOfflineExp(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8051
    protobufMgr.mMsgDeserializedTblCache = res
end

---玩家零点刷新信息
---msgID: 8054
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRefreshInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8054 roleV2.ResRefreshInfo 玩家零点刷新信息")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResRefreshInfo", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResRefreshInfo ~= nil then
        protoAdjust.role_adj.AdjustResRefreshInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8054
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回查看矿工信息
---msgID: 8056
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetMinerInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8056 roleV2.ResGetMinerInfo 返回查看矿工信息")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResGetMinerInfo", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResGetMinerInfo ~= nil then
        protoAdjust.role_adj.AdjustResGetMinerInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8056
    protobufMgr.mMsgDeserializedTblCache = res
end

---刷新矿石信息
---msgID: 8057
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUpdateMineInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8057 roleV2.ResUpdateMineInfo 刷新矿石信息")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResUpdateMineInfo", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResUpdateMineInfo ~= nil then
        protoAdjust.role_adj.AdjustResUpdateMineInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8057
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回变或取消间谍消息
---msgID: 8060
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPlayerSpyInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8060 roleV2.ResPlayerSpyInfo 返回变或取消间谍消息")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResPlayerSpyInfo", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResPlayerSpyInfo ~= nil then
        protoAdjust.role_adj.AdjustResPlayerSpyInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8060
    protobufMgr.mMsgDeserializedTblCache = res
end

---是否首冲改变
---msgID: 8065
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRoleFirstRechargeChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8065 roleV2.ResRoleFirstRechargeChange 是否首冲改变")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResRoleFirstRechargeChange", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResRoleFirstRechargeChange ~= nil then
        protoAdjust.role_adj.AdjustResRoleFirstRechargeChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8065
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回前置任务是否完成
---msgID: 8067
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCheckPreTaskIsCompleteMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8067 roleV2.ResCheckPreTaskIsComplete 返回前置任务是否完成")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResCheckPreTaskIsComplete", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResCheckPreTaskIsComplete ~= nil then
        protoAdjust.role_adj.AdjustResCheckPreTaskIsComplete(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8067
    protobufMgr.mMsgDeserializedTblCache = res
end

---改名返回
---msgID: 8068
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResEditNameMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8068 roleV2.ResEditName 改名返回")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResEditName", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResEditName ~= nil then
        protoAdjust.role_adj.AdjustResEditName(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8068
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回小秘书主线推送是否已经发过
---msgID: 8070
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMainTaskPushMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8070 roleV2.ResMainTaskPush 返回小秘书主线推送是否已经发过")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResMainTaskPush", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResMainTaskPush ~= nil then
        protoAdjust.role_adj.AdjustResMainTaskPush(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8070
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回炼制大师面板信息
---msgID: 8073
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRefineMasterPanelMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8073 roleV2.ResRefineMasterPanel 返回炼制大师面板信息")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResRefineMasterPanel", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResRefineMasterPanel ~= nil then
        protoAdjust.role_adj.AdjustResRefineMasterPanel(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8073
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回炼制结果
---msgID: 8075
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRefineMasterResultMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8075 roleV2.ResRefineResult 返回炼制结果")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResRefineResult", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResRefineResult ~= nil then
        protoAdjust.role_adj.AdjustResRefineResult(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8075
    protobufMgr.mMsgDeserializedTblCache = res
end

---更新钻石额度
---msgID: 8076
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUpdateAuctionDiamondMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8076 roleV2.UpdateAuctionDiamond 更新钻石额度")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.UpdateAuctionDiamond", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustUpdateAuctionDiamond ~= nil then
        protoAdjust.role_adj.AdjustUpdateAuctionDiamond(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8076
    protobufMgr.mMsgDeserializedTblCache = res
end

---身上的装备掉落变动
---msgID: 8079
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPlayerDieDropEquipByWearMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8079 roleV2.ResPlayerDieDropEquipByWear 身上的装备掉落变动")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResPlayerDieDropEquipByWear", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResPlayerDieDropEquipByWear ~= nil then
        protoAdjust.role_adj.AdjustResPlayerDieDropEquipByWear(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8079
    protobufMgr.mMsgDeserializedTblCache = res
end

---千纸鹤传送返回
---msgID: 8081
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPaperCraneDeliveryMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8081 roleV2.ResPaperCraneDelivery 千纸鹤传送返回")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResPaperCraneDelivery", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResPaperCraneDelivery ~= nil then
        protoAdjust.role_adj.AdjustResPaperCraneDelivery(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8081
    protobufMgr.mMsgDeserializedTblCache = res
end

---首充推送
---msgID: 8082
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResFirstChargePushMessageReceived(msgID, buffer)
end

---首充推送-新服优势
---msgID: 8083
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResNewFirstChargePushMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8083 roleV2.ResNewFirstChargePush 首充推送-新服优势")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResNewFirstChargePush", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResNewFirstChargePush ~= nil then
        protoAdjust.role_adj.AdjustResNewFirstChargePush(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8083
    protobufMgr.mMsgDeserializedTblCache = res
end

---系统开起感叹号提示
---msgID: 8084
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResNeedPromptMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8084 roleV2.ResNeedPrompt 系统开起感叹号提示")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResNeedPrompt", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResNeedPrompt ~= nil then
        protoAdjust.role_adj.AdjustResNeedPrompt(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8084
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回玩家在游戏服的联服的基本数据
---msgID: 8086
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGameBasicShareInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8086 roleV2.GameBasicShareInfo 返回玩家在游戏服的联服的基本数据")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.GameBasicShareInfo", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustGameBasicShareInfo ~= nil then
        protoAdjust.role_adj.AdjustGameBasicShareInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8086
    protobufMgr.mMsgDeserializedTblCache = res
end

---腕力刷新
---msgID: 8087
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRoleRefreshWanLiMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8087 roleV2.ResRoleRefreshWanLi 腕力刷新")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResRoleRefreshWanLi", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResRoleRefreshWanLi ~= nil then
        protoAdjust.role_adj.AdjustResRoleRefreshWanLi(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8087
    protobufMgr.mMsgDeserializedTblCache = res
end

---给客户端发送假buff消息
---msgID: 8088
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnRoleAddFakeBuffMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8088 roleV2.RoleAddFakeBuff 给客户端发送假buff消息")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.RoleAddFakeBuff", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustRoleAddFakeBuff ~= nil then
        protoAdjust.role_adj.AdjustRoleAddFakeBuff(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8088
    protobufMgr.mMsgDeserializedTblCache = res
end

---给客户端发送驯服次数信息
---msgID: 8089
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRoleTameMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8089 roleV2.ResRoleTame 给客户端发送驯服次数信息")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResRoleTame", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResRoleTame ~= nil then
        protoAdjust.role_adj.AdjustResRoleTame(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8089
    protobufMgr.mMsgDeserializedTblCache = res
end

---炼制大师红点信息
---msgID: 8090
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRefineMasterRedDotMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8090 roleV2.ResRefineMasterRedDot 炼制大师红点信息")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResRefineMasterRedDot", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResRefineMasterRedDot ~= nil then
        protoAdjust.role_adj.AdjustResRefineMasterRedDot(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8090
    protobufMgr.mMsgDeserializedTblCache = res
end

---给客户端发送封号天赋数据
---msgID: 8091
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTitleTianfuMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8091 roleV2.ResTitleTianfu 给客户端发送封号天赋数据")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResTitleTianfu", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResTitleTianfu ~= nil then
        protoAdjust.role_adj.AdjustResTitleTianfu(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8091
    protobufMgr.mMsgDeserializedTblCache = res
end

---练功房时间限制
---msgID: 8095
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResKongFuHouseTimeLimitMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8095 roleV2.ResKongFuHouseTimeLimit 练功房时间限制")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResKongFuHouseTimeLimit", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResKongFuHouseTimeLimit ~= nil then
        protoAdjust.role_adj.AdjustResKongFuHouseTimeLimit(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8095
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回潜能信息
---msgID: 8097
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPotentialInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8097 roleV2.RespotentialInfo 返回潜能信息")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.RespotentialInfo", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustRespotentialInfo ~= nil then
        protoAdjust.role_adj.AdjustRespotentialInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8097
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回潜能红点信息
---msgID: 8101
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRedPointPotentialMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8101 roleV2.ResPotentialRedPoint 返回潜能红点信息")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResPotentialRedPoint", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResPotentialRedPoint ~= nil then
        protoAdjust.role_adj.AdjustResPotentialRedPoint(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8101
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回回收配置
---msgID: 8103
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCollectionSettingMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8103 roleV2.CollectionSetting 返回回收配置")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.CollectionSetting", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustCollectionSetting ~= nil then
        protoAdjust.role_adj.AdjustCollectionSetting(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8103
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回玩家模型数据
---msgID: 8107
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRoleModelInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8107 roleV2.RoleModelInfo 返回玩家模型数据")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.RoleModelInfo", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustRoleModelInfo ~= nil then
        protoAdjust.role_adj.AdjustRoleModelInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8107
    protobufMgr.mMsgDeserializedTblCache = res
end

---神秘老人兑换详情
---msgID: 8109
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMysteriousExchangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8109 roleV2.ResMysteriousExchange 神秘老人兑换详情")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResMysteriousExchange", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResMysteriousExchange ~= nil then
        protoAdjust.role_adj.AdjustResMysteriousExchange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8109
    protobufMgr.mMsgDeserializedTblCache = res
end

---终极boss击杀数据
---msgID: 8110
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBossKillDataMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8110 roleV2.BossKillData 终极boss击杀数据")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.BossKillData", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustBossKillData ~= nil then
        protoAdjust.role_adj.AdjustBossKillData(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8110
    protobufMgr.mMsgDeserializedTblCache = res
end

---玩家系统预告开启信息
---msgID: 8112
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRoleSystemPreviewMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8112 roleV2.ResRoleSystemPreview 玩家系统预告开启信息")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResRoleSystemPreview", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResRoleSystemPreview ~= nil then
        protoAdjust.role_adj.AdjustResRoleSystemPreview(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8112
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回当前累计的经验值
---msgID: 8115
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRoleExpAccumulateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8115 roleV2.ResRoleExpAccumulate 返回当前累计的经验值")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResRoleExpAccumulate", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResRoleExpAccumulate ~= nil then
        protoAdjust.role_adj.AdjustResRoleExpAccumulate(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8115
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回创角邀请码
---msgID: 8116
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRoleInviteCodeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8116 roleV2.ResRoleInviteCode 返回创角邀请码")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResRoleInviteCode", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResRoleInviteCode ~= nil then
        protoAdjust.role_adj.AdjustResRoleInviteCode(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8116
    protobufMgr.mMsgDeserializedTblCache = res
end

---转性
---msgID: 8118
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTransferSexMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8118 roleV2.ResTransferSex 转性")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResTransferSex", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResTransferSex ~= nil then
        protoAdjust.role_adj.AdjustResTransferSex(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8118
    protobufMgr.mMsgDeserializedTblCache = res
end

---转职
---msgID: 8120
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTransferCareerMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8120 roleV2.ResTransferCareer 转职")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResTransferCareer", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResTransferCareer ~= nil then
        protoAdjust.role_adj.AdjustResTransferCareer(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8120
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回身上可投保列表
---msgID: 8121
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCanInsuredEquipMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8121 roleV2.ResCanInsuredEquip 返回身上可投保列表")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResCanInsuredEquip", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResCanInsuredEquip ~= nil then
        protoAdjust.role_adj.AdjustResCanInsuredEquip(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8121
    protobufMgr.mMsgDeserializedTblCache = res
end

---投保返回
---msgID: 8123
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResInsuredSuccesMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 8123 roleV2.ResInsuredSucces 投保返回")
        return nil
    end
    local res = protobufMgr.Deserialize("roleV2.ResInsuredSucces", buffer)
    if protoAdjust.role_adj ~= nil and protoAdjust.role_adj.AdjustResInsuredSucces ~= nil then
        protoAdjust.role_adj.AdjustResInsuredSucces(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 8123
    protobufMgr.mMsgDeserializedTblCache = res
end

