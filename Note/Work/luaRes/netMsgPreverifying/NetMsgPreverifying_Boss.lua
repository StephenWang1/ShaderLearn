--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--boss.xml

--region ID:30018 ReqMinMapMessage 打开小地图请求
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[30018] = function(msgID, csData)
    --在此处填入预校验代码
    --请求小地图时,先记录一次当前请求的地图ID
    CS.CSScene.MainPlayerInfo.MapInfoV2.MiniMapID = CS.CSScene.getMapID()
    return true
end
--endregion

--region ID:30023 ReqAncientBossDamageRankMessage 请求远古 boss 伤害排行
---@param msgID LuaEnumNetDef 消息ID
---@param csData bossV2.ReqAncientBossDamageRank lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[30023] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:30028 ReqShareAncientBossDamageRankMessage 请求联服远古 boss 伤害排行
---@param msgID LuaEnumNetDef 消息ID
---@param csData bossV2.ReqAncientBossDamageRank lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[30028] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:30029 ReqAncientBossDamageRankV2Message 请求远古 boss 伤害排行
---@param msgID LuaEnumNetDef 消息ID
---@param csData bossV2.ReqAncientBossDamageRank lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[30029] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--[[
--region ID:30022 ReqAncientBossDamageRankMessage boss刷新提示
---@param msgID LuaEnumNetDef 消息ID
---@param csData bossV2.ResBossRefresh lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[30022] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
--]]
