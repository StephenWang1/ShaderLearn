--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--friend.xml

--region ID:100029 ReqGetFriendCircleMessage 请求朋友圈信息
---@param msgID LuaEnumNetDef 消息ID
---@param csData friendV2.GetFriendCircleInfo lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[100029] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:100032 ReqFriendCirclePostMessage 请求朋友圈发动态
---@param msgID LuaEnumNetDef 消息ID
---@param csData friendV2.ReqFriendCirclePost lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[100032] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:100033 ReqFriendCircleReplyMessage 请求朋友圈发回复
---@param msgID LuaEnumNetDef 消息ID
---@param csData friendV2.ReqFriendCircleReply lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[100033] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:100034 ReqFriendCircleLikeMessage 请求朋友圈点赞
---@param msgID LuaEnumNetDef 消息ID
---@param csData friendV2.ReqFriendCircleLike lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[100034] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:100035 ReqAddSendChatMessage 点发送消息按钮
---@param msgID LuaEnumNetDef 消息ID
---@param csData friendV2.ChatTarget lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[100035] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:100046 ReqLookApplicantMessage 查看申请人
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[100046] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:100047 ReqUnLookApplicantMessage 请求未查看的申请人
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[100047] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:100052 ReqFriendCircleDeleteMessage 朋友圈删除动态
---@param msgID LuaEnumNetDef 消息ID
---@param csData friendV2.ReqFriendCircleDelete lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[100052] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:100062 ReqAccurateSearchMessage 请求聊天框精确搜索
---@param msgID LuaEnumNetDef 消息ID
---@param csData friendV2.ReqSearchFriend lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[100062] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:100064 ReqFriendCircleSysMsgConfigMessage 请求更改朋友圈消息订阅
---@param msgID LuaEnumNetDef 消息ID
---@param csData friendV2.ReqFriendCircleSysMsgConfig lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[100064] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--[[
--region ID:100050 ResUpdateLetteringMessage 刷新刻字
---@param msgID LuaEnumNetDef 消息ID
---@param csData friendV2.UpdateLettering lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[100050] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
--]]
