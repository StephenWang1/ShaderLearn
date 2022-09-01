--[[本文件为工具自动生成,禁止手动修改]]
--biqi.xml

--region ID:79008 请求积分领奖
---请求积分领奖
---msgID: 79008
---@return boolean 网络请求是否成功发送
function networkRequest.ReqScoreReward()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqScoreRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqScoreRewardMessage](LuaEnumNetDef.ReqScoreRewardMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqScoreRewardMessage, nil, true)
    end
    return canSendMsg
end
--endregion

