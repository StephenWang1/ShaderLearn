--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--duplicate.xml

--region ID:71041 ReqGoddessBlessingExchangeMessage 女神赐福兑换物品
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[71041] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:71053 ReqStartSabacTacticsMessage 请求激活沙巴克法阵
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[71053] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:71055 ReqActiveSabacTacticsMessage 激活沙巴克法阵付费
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[71055] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:71060 ReqCrowdFundingPanelMessage 请求众筹面板信息
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[71060] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:71062 ReqOpenCrowdFundingMessage 请求开启众筹
---@param msgID LuaEnumNetDef 消息ID
---@param csData duplicateV2.ReqOpenCrowdFunding lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[71062] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:71063 ReqDonateFundingMessage 请求捐赠
---@param msgID LuaEnumNetDef 消息ID
---@param csData duplicateV2.ReqDonateFunding lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[71063] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:71065 ReqOpenBrokerPanelMessage 请求掮客信息
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[71065] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:71067 ReqBrokerQueryMessage 掮客查询
---@param msgID LuaEnumNetDef 消息ID
---@param csData duplicateV2.ReqBrokerQuery lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[71067] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:71068 ReqGetGoddessBlessingRankInfoMessage 获取女神赐福排名
---@param msgID LuaEnumNetDef 消息ID
---@param csData duplicateV2.GetGoddessBlessingRank lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[71068] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:71071 ReqLikeMessage 活动点赞请求
---@param msgID LuaEnumNetDef 消息ID
---@param csData duplicateV2.LikeRequest lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[71071] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:71076 ReqTodayUseFireworkMessage 请求今日是否使用烟花
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[71076] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:71078 ReqGBPreviousPeriodTimeMessage 请求活动往期时间
---@param msgID LuaEnumNetDef 消息ID
---@param csData duplicateV2.ReqGBPreviousPeriodTime lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[71078] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:71080 ReqGBPreviousPeriodInfoMessage 请求女神赐福往期数据
---@param msgID LuaEnumNetDef 消息ID
---@param csData duplicateV2.ReqGBPreviousPeriodInfo lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[71080] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:71082 ReqSabacRecordMessage 请求沙巴克历史记录
---@param msgID LuaEnumNetDef 消息ID
---@param csData duplicateV2.ResSabacRecord lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[71082] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:71092 ReqDevilSquareHasTimeMessage 请求恶魔广场剩余时间
---@param msgID LuaEnumNetDef 消息ID
---@param csData duplicateV2.ReqDevilSquareEndTime lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[71092] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:71104 ReqGetSabacPersonalRankInfoMessage 获取沙巴克个人积分排名
---@param msgID LuaEnumNetDef 消息ID
---@param csData duplicateV2.ReqGetSabacRankInfo lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[71104] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--[[
--region ID:71095 ReqReliveHuntMonsterMessage 请求复活塔罗神庙怪物
---@param msgID LuaEnumNetDef 消息ID
---@param csData duplicateV2.ReqReliveHuntMonster lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[71095] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
--]]

--[[
--region ID:71072 ResLikeMessage 点赞返回
---@param msgID LuaEnumNetDef 消息ID
---@param csData duplicateV2.LikeResponseCommon lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[71072] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
--]]
