--[[本文件为工具自动生成,禁止手动修改]]
--skill.xml

--region ID:9001 请求角色技能数据
---请求角色技能数据
---msgID: 9001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSkillBasicInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSkillBasicInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSkillBasicInfoMessage](LuaEnumNetDef.ReqSkillBasicInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqSkillBasicInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:9003 请求升级技能
---请求升级技能
---msgID: 9003
---@param skillId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLevelUpSkill(skillId)
    local reqTable = {}
    reqTable.skillId = skillId
    local reqMsgData = protobufMgr.Serialize("skillV2.SkillIdInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLevelUpSkillMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLevelUpSkillMessage](LuaEnumNetDef.ReqLevelUpSkillMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqLevelUpSkillMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqLevelUpSkillMessage", 9003, "SkillIdInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:9004 请求激活技能
---请求激活技能
---msgID: 9004
---@return boolean 网络请求是否成功发送
function networkRequest.ReqActivateSkill()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqActivateSkillMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqActivateSkillMessage](LuaEnumNetDef.ReqActivateSkillMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqActivateSkillMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:9008 设置技能映射
---设置技能映射
---msgID: 9008
---@param skillShortcut System.Collections.Generic.List1T<number> 列表参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSetSkillShortcut(skillShortcut)
    local reqData = CS.skillV2.ReqSetSkillShortcut()
    if skillShortcut ~= nil then
        reqData.skillShortcut:AddRange(skillShortcut)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSetSkillShortcutMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSetSkillShortcutMessage](LuaEnumNetDef.ReqSetSkillShortcutMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqSetSkillShortcutMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:9009 秘技设置保存
---秘技设置保存
---msgID: 9009
---@param skillId number 选填参数 保存技能设置时技能id
---@param site number 选填参数 位置 1-6
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSecretSkillUpdate(skillId, site)
    local reqTable = {}
    if skillId ~= nil then
        reqTable.skillId = skillId
    end
    if site ~= nil then
        reqTable.site = site
    end
    local reqMsgData = protobufMgr.Serialize("skillV2.SecretSkillUpdate" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSecretSkillUpdateMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSecretSkillUpdateMessage](LuaEnumNetDef.ReqSecretSkillUpdateMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSecretSkillUpdateMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSecretSkillUpdateMessage", 9009, "SecretSkillUpdate", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:9011 请求秘技面板
---请求秘技面板
---msgID: 9011
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSecretSkillInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSecretSkillInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSecretSkillInfoMessage](LuaEnumNetDef.ReqSecretSkillInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqSecretSkillInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:9012 请求切换心阵
---请求切换心阵
---msgID: 9012
---@param form number 选填参数 心阵id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSwitchFormation(form)
    local reqTable = {}
    if form ~= nil then
        reqTable.form = form
    end
    local reqMsgData = protobufMgr.Serialize("skillV2.ReqSwitchFormation" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSwitchFormationMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSwitchFormationMessage](LuaEnumNetDef.ReqSwitchFormationMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSwitchFormationMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSwitchFormationMessage", 9012, "ReqSwitchFormation", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:9013 请求卸下心法
---请求卸下心法
---msgID: 9013
---@param skillId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTakeOffSecret(skillId)
    local reqTable = {}
    if skillId ~= nil then
        reqTable.skillId = skillId
    end
    local reqMsgData = protobufMgr.Serialize("skillV2.ReqTakeOffSecret" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTakeOffSecretMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTakeOffSecretMessage](LuaEnumNetDef.ReqTakeOffSecretMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqTakeOffSecretMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqTakeOffSecretMessage", 9013, "ReqTakeOffSecret", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:9018 请求升级装备专精
---请求升级装备专精
---msgID: 9018
---@param type number 选填参数 升级专精的位置，配置表里的type
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUpEquipProficient(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("skillV2.UpEquipProficient" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUpEquipProficientMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUpEquipProficientMessage](LuaEnumNetDef.ReqUpEquipProficientMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUpEquipProficientMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUpEquipProficientMessage", 9018, "UpEquipProficient", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:9021 学习特殊技能(不通过技能书)
---学习特殊技能(不通过技能书)
---msgID: 9021
---@param skillId number 选填参数 特殊技能学习
---@return boolean 网络请求是否成功发送
function networkRequest.ReqStudySpecialSkill(skillId)
    local reqTable = {}
    if skillId ~= nil then
        reqTable.skillId = skillId
    end
    local reqMsgData = protobufMgr.Serialize("skillV2.ReqStudySpecialSkill" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqStudySpecialSkillMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqStudySpecialSkillMessage](LuaEnumNetDef.ReqStudySpecialSkillMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqStudySpecialSkillMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqStudySpecialSkillMessage", 9021, "ReqStudySpecialSkill", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

