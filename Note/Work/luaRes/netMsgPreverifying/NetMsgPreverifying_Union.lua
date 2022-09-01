--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--union.xml

--region ID:23125 ReqToggleSendVoiceMessage 会长切换语音权限
---@param msgID LuaEnumNetDef 消息ID
---@param csData unionV2.ReqToggleSendVoice lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[23125] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:23126 ReqToggleVoiceOpenMessage 切换语音开关
---@param msgID LuaEnumNetDef 消息ID
---@param csData unionV2.ReqToggleVoiceOpen lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[23126] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:23135 ReqToggleSpeakerMessage 切换喇叭状态
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[23135] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:23156 ReqUnionBossBuffInfoMessage 请求鼓舞buff的信息
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[23156] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:23158 ReqUnionBossAddBuffMessage 花钱鼓舞
---@param msgID LuaEnumNetDef 消息ID
---@param csData unionV2.UnionBossAddBuff lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[23158] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:23159 ReqUnionBossRankMessage 用于客户端进入场景请求排行榜
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[23159] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
