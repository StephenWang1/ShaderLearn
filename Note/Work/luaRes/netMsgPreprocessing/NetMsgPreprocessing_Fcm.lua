--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--fcm.xml

--region ID:34001 ResAuthorityStateMessage 认证状态
---@param msgID LuaEnumNetDef 消息ID
---@param tblData fcmV2.ResAuthorityState lua table类型消息数据
---@param csData fcmV2.ResAuthorityState C# class类型消息数据
netMsgPreprocessing[34001] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if isOpenLog then
        print("认证状态(<= 0 是没认证, > 0 是已认证的玩家年龄): ", tblData.state, "  frame:", CS.UnityEngine.Time.frameCount)
    end
    if csData and CS.CSGame.Sington ~= nil and CS.CSGame.Sington.AntiAddiction ~= nil then
        CS.CSGame.Sington.AntiAddiction:RefreshAuthorityState(csData)
    end
end
--endregion

--region ID:34003 ResFcmStateMessage 防沉迷状态 1-5对应小时
---@param msgID LuaEnumNetDef 消息ID
---@param tblData fcmV2.ResFcmState lua table类型消息数据
---@param csData fcmV2.ResFcmState C# class类型消息数据
netMsgPreprocessing[34003] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if isOpenLog then
        print("防沉迷状态(防沉迷状态 1-5对应半小时个数): ", tblData.fcmState, " 在线秒数: ", tblData.onlineSeconds, "  frame:", CS.UnityEngine.Time.frameCount)
    end
    if csData and CS.CSGame.Sington ~= nil and CS.CSGame.Sington.AntiAddiction ~= nil then
        CS.CSGame.Sington.AntiAddiction:RefreshFCMState(csData)
    end
end
--endregion
