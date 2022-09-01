--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--treasurehunt.xml

--region ID:11101 ReqGetTreasureHuntMessage 获取寻宝信息
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[11101] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:11103 ReqTreasureHuntMessage 寻宝请求
---@param msgID LuaEnumNetDef 消息ID
---@param csData treasureHuntV2.TreasureRequest lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[11103] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:11109 ReqTreasureStorehouseMessage 寻宝仓库信息请求
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[11109] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:11112 ReqUseTreasureExpMessage 使用寻宝经验丹
---@param msgID LuaEnumNetDef 消息ID
---@param csData treasureHuntV2.ExpUseRequest lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[11112] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:11116 ReqServerTreasureRewardMessage 全服寻宝的奖励请求
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[11116] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:11118 ReqHuntCallBackMessage 寻宝仓库中回收装备请求
---@param msgID LuaEnumNetDef 消息ID
---@param csData treasureHuntV2.HuntCallbackRequest lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[11118] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:11123 ReqTreasureCardMessage 请求寻宝卡牌信息
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[11123] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:11125 ReqTreasureTurnCardMessage 请求翻牌
---@param msgID LuaEnumNetDef 消息ID
---@param csData treasureHuntV2.TurnCardRequset lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[11125] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:11129 ReqServerHistoryMessage 请求历史信息
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[11129] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:11131 ReqReinNumMessage 请求全服转生信息
---@param msgID LuaEnumNetDef 消息ID
---@param csData treasureHuntV2.ReinNumRequest lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[11131] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--[[
--region ID:11106 ReqGetItemMessage 获取某个物品
---@param msgID LuaEnumNetDef 消息ID
---@param csData treasureHuntV2.GetTreasureItemRequest lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[11106] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
--]]
