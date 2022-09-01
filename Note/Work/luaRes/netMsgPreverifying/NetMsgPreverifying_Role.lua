--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--role.xml

--region ID:8055 ReqGetMinerInfoMessage 请求查看矿工信息
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[8055] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:8058 ReqHireMinerMessage 请求雇佣矿工
---@param msgID LuaEnumNetDef 消息ID
---@param csData roleV2.ReqHireMiner lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[8058] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:8059 ReqReceiveMineralMessage 请求领取矿石
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[8059] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:8069 ReqMainTaskPushMessage 小秘书主线任务推送
---@param msgID LuaEnumNetDef 消息ID
---@param csData roleV2.ReqMainTaskPush lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[8069] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:8072 ReqRefineMasterPanelMessage 请求炼制大师面板信息
---@param msgID LuaEnumNetDef 消息ID
---@param csData roleV2.ReqRefineMasterPanel lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[8072] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:8074 ReqRefineMessage 请求炼制
---@param msgID LuaEnumNetDef 消息ID
---@param csData roleV2.ReqRefine lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[8074] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:8096 ReqPotentialInfoMessage 请求潜能信息
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[8096] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:8098 ReqActivePotentialMessage 请求激活潜能
---@param msgID LuaEnumNetDef 消息ID
---@param csData roleV2.ReqActivePotential lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[8098] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:8099 ReqUpgradePotentialMessage 请求升级潜能
---@param msgID LuaEnumNetDef 消息ID
---@param csData roleV2.ReqUpgradePotential lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[8099] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:8114 ReqAddRoleExpByResourcesMessage 请求消耗资源兑换经验
---@param msgID LuaEnumNetDef 消息ID
---@param csData roleV2.ReqAddRoleExpByResources lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[8114] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:8117 ReqTransferSexMessage 转性
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[8117] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:8119 ReqTransferCareerMessage 转职
---@param msgID LuaEnumNetDef 消息ID
---@param csData roleV2.ReqTransferCareer lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[8119] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--[[
--region ID:8107 ResRoleModelInfoMessage 返回玩家模型数据
---@param msgID LuaEnumNetDef 消息ID
---@param csData roleV2.RoleModelInfo lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[8107] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
--]]
