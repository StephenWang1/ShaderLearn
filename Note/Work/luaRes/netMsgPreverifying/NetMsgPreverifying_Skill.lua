--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--skill.xml

--region ID:9012 ReqSwitchFormationMessage 请求切换心阵
---@param msgID LuaEnumNetDef 消息ID
---@param csData skillV2.ReqSwitchFormation lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[9012] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:9013 ReqTakeOffSecretMessage 请求卸下心法
---@param msgID LuaEnumNetDef 消息ID
---@param csData skillV2.ReqTakeOffSecret lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[9013] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:9018 ReqUpEquipProficientMessage 请求升级装备专精
---@param msgID LuaEnumNetDef 消息ID
---@param csData skillV2.UpEquipProficient lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[9018] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:9021 ReqStudySpecialSkillMessage 学习特殊技能(不通过技能书)
---@param msgID LuaEnumNetDef 消息ID
---@param csData skillV2.ReqStudySpecialSkill lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[9021] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--[[
--region ID:9011 ReqSecretSkillInfoMessage 请求秘技面板
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[9011] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
--]]
