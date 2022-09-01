--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--servant.xml

--region ID:103003 ReqServantChangeStateMessage 请求切换状态
---@param msgID LuaEnumNetDef 消息ID
---@param csData servantV2.ReqServantChangeState lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[103003] = function(msgID, csData)
    --在此处填入预校验代码
    if csData and csData.toState == 2 and CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:RecordCombineReleaseInServantSeat(csData.type)
    end
    return true
end
--endregion

--region ID:103006 ReqUseServantEggMessage 请求使用元灵蛋
---@param msgID LuaEnumNetDef 消息ID
---@param csData servantV2.ReqUseServantEgg lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[103006] = function(msgID, csData)
    --在此处填入预校验代码
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.ServantInfoV2 ~= nil then
        CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:RecordReplaceServantEggInServantSeat(csData.itemId, csData.targetType)
    end
    return true
end
--endregion

--region ID:103021 ReqPurchaseServantSiteMessage 请求购买灵兽位信息
---@param msgID LuaEnumNetDef 消息ID
---@param csData servantV2.ReqPurchaseServantSite lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[103021] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
