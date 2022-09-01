--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--collect.xml

--region ID:111101 ReqPutCollectionItemMessage 藏品上架请求
---@param msgID LuaEnumNetDef 消息ID
---@param csData collect.PutCollectionItemMsg lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[111101] = function(msgID, csData)
    --在此处填入预校验代码
    --print("发送藏品上架请求", "lid:" .. csData.lid .. "第" .. csData.page .. "页  (" .. csData.x .. ", " .. csData.y .. ")")
    return true
end
--endregion

--region ID:111103 ReqRemoveCollectionItemMessage 藏品下架请求
---@param msgID LuaEnumNetDef 消息ID
---@param csData collect.RemoveCollectionItemMsg lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[111103] = function(msgID, csData)
    --在此处填入预校验代码
    --print("发送藏品下架请求", "lid", csData.itemId)
    return true
end
--endregion

--region ID:111105 ReqSwapCollectionItemMessage 藏品交换位置架请求
---@param msgID LuaEnumNetDef 消息ID
---@param csData collect.SwapCollectionItemMsg lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[111105] = function(msgID, csData)
    --在此处填入预校验代码
    --print("发送藏品交换位置架请求", "lid:" .. csData.itemId .. "第" .. csData.page .. "页  (" .. csData.x .. ",  " .. csData.y .. ")")
    return true
end
--endregion

--region ID:111107 ReqCallbackCollectionMessage 藏品回收请求
---@param msgID LuaEnumNetDef 消息ID
---@param csData collect.CallbackCollectionMsg lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[111107] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:111119 ReqUpgradeCabinetMessage 升级收藏柜请求
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[111119] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:111120 ReqCollectionMergeMessage 藏品合成请求
---@param msgID LuaEnumNetDef 消息ID
---@param csData collect.CollectionMergeRequest lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[111120] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
