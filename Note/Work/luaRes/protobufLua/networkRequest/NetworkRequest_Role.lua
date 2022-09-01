--[[本文件为工具自动生成,禁止手动修改]]
--role.xml

--region ID:8006 请求获取角色转生信息
---请求获取角色转生信息
---msgID: 8006
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetRoleReinInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetRoleReinInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetRoleReinInfoMessage](LuaEnumNetDef.ReqGetRoleReinInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetRoleReinInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:8008 角色请求兑换修为
---角色请求兑换修为
---msgID: 8008
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRoleExchangeRein()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRoleExchangeReinMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRoleExchangeReinMessage](LuaEnumNetDef.ReqRoleExchangeReinMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqRoleExchangeReinMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:8009 请求角色转生
---请求角色转生
---msgID: 8009
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUpLevelRoleRein()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUpLevelRoleReinMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUpLevelRoleReinMessage](LuaEnumNetDef.ReqUpLevelRoleReinMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqUpLevelRoleReinMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:8016 请求改变玩家死亡状态
---请求改变玩家死亡状态
---msgID: 8016
---@param type number 必填参数 类型 1死亡 2复活
---@return boolean 网络请求是否成功发送
function networkRequest.ReqChangeRoleDieState(type)
    local reqTable = {}
    reqTable.type = type
    local reqMsgData = protobufMgr.Serialize("roleV2.ChangeRoleDieStateRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqChangeRoleDieStateMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqChangeRoleDieStateMessage](LuaEnumNetDef.ReqChangeRoleDieStateMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqChangeRoleDieStateMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqChangeRoleDieStateMessage", 8016, "ChangeRoleDieStateRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8021 请求立即复活
---请求立即复活
---msgID: 8021
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRoleImmediatelyRelive()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRoleImmediatelyReliveMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRoleImmediatelyReliveMessage](LuaEnumNetDef.ReqRoleImmediatelyReliveMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqRoleImmediatelyReliveMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:8023 请求角色设置
---请求角色设置
---msgID: 8023
---@param id number 必填参数
---@param state boolean 选填参数 勾选为true,去掉勾选为false
---@param roleSettingValue number 选填参数 参数值
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRoleSetting(id, state, roleSettingValue)
    local reqTable = {}
    reqTable.id = id
    if state ~= nil then
        reqTable.state = state
    end
    if roleSettingValue ~= nil then
        reqTable.roleSettingValue = roleSettingValue
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.RoleSettingRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRoleSettingMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRoleSettingMessage](LuaEnumNetDef.ReqRoleSettingMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRoleSettingMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRoleSettingMessage", 8023, "RoleSettingRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8028 请求一键升级内功
---请求一键升级内功
---msgID: 8028
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLevelUpInnerPower()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLevelUpInnerPowerMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLevelUpInnerPowerMessage](LuaEnumNetDef.ReqLevelUpInnerPowerMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqLevelUpInnerPowerMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:8030 请求重置角色设置
---请求重置角色设置
---msgID: 8030
---@return boolean 网络请求是否成功发送
function networkRequest.ReqResetRoleSetting()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqResetRoleSettingMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqResetRoleSettingMessage](LuaEnumNetDef.ReqResetRoleSettingMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqResetRoleSettingMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:8031 请求快捷键设置
---请求快捷键设置
---msgID: 8031
---@param index number 选填参数 编号
---@param type number 选填参数 类型
---@param num number 选填参数 参数值
---@return boolean 网络请求是否成功发送
function networkRequest.ReqHandyKeySetting(index, type, num)
    local reqTable = {}
    if index ~= nil then
        reqTable.index = index
    end
    if type ~= nil then
        reqTable.type = type
    end
    if num ~= nil then
        reqTable.num = num
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.HandyKeySettingRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqHandyKeySettingMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqHandyKeySettingMessage](LuaEnumNetDef.ReqHandyKeySettingMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqHandyKeySettingMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqHandyKeySettingMessage", 8031, "HandyKeySettingRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8032 请求交换快捷键设置
---请求交换快捷键设置
---msgID: 8032
---@param leftIndex number 必填参数 左编号
---@param rightIndex number 必填参数 右编号
---@return boolean 网络请求是否成功发送
function networkRequest.ReqExchangeHandyKey(leftIndex, rightIndex)
    local reqTable = {}
    reqTable.leftIndex = leftIndex
    reqTable.rightIndex = rightIndex
    local reqMsgData = protobufMgr.Serialize("roleV2.ExchangeHandyKeyRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqExchangeHandyKeyMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqExchangeHandyKeyMessage](LuaEnumNetDef.ReqExchangeHandyKeyMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqExchangeHandyKeyMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqExchangeHandyKeyMessage", 8032, "ExchangeHandyKeyRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8035 查看其他玩家信息请求
---查看其他玩家信息请求
---msgID: 8035
---@param targetId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOtherRoleInfo(targetId)
    local reqTable = {}
    reqTable.targetId = targetId
    local reqMsgData = protobufMgr.Serialize("roleV2.GetRoleInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOtherRoleInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOtherRoleInfoMessage](LuaEnumNetDef.ReqOtherRoleInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqOtherRoleInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqOtherRoleInfoMessage", 8035, "GetRoleInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8038 客户端查看别的玩家的通用信息请求
---客户端查看别的玩家的通用信息请求
---msgID: 8038
---@param targetId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOtherPlayerCommonInfo(targetId)
    local reqTable = {}
    reqTable.targetId = targetId
    local reqMsgData = protobufMgr.Serialize("roleV2.GetRoleInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOtherPlayerCommonInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOtherPlayerCommonInfoMessage](LuaEnumNetDef.ReqOtherPlayerCommonInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqOtherPlayerCommonInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqOtherPlayerCommonInfoMessage", 8038, "GetRoleInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8039 保存玩家设置
---保存玩家设置
---msgID: 8039
---@param roleSettings System.Collections.Generic.List1T<number> 列表参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSaveRoleSettings(roleSettings)
    local reqData = CS.roleV2.SaveRoleSettingsMsg()
    if roleSettings ~= nil then
        reqData.roleSettings:AddRange(roleSettings)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSaveRoleSettingsMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSaveRoleSettingsMessage](LuaEnumNetDef.ReqSaveRoleSettingsMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqSaveRoleSettingsMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:8041 查看内功信息
---查看内功信息
---msgID: 8041
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLookInnerPower()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLookInnerPowerMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLookInnerPowerMessage](LuaEnumNetDef.ReqLookInnerPowerMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqLookInnerPowerMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:8042 改名请求
---改名请求
---msgID: 8042
---@param name string 必填参数
---@param type number 必填参数 1玩家改名 2行会改名
---@return boolean 网络请求是否成功发送
function networkRequest.ReqEditName(name, type)
    local reqTable = {}
    reqTable.name = name
    reqTable.type = type
    local reqMsgData = protobufMgr.Serialize("roleV2.EditName" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqEditNameMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqEditNameMessage](LuaEnumNetDef.ReqEditNameMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqEditNameMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqEditNameMessage", 8042, "EditName", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8043 保存玩家技能设置
---保存玩家技能设置
---msgID: 8043
---@param skillId System.Collections.Generic.List1T<number> 列表参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSaveRoleSkillSettings(skillId)
    local reqData = CS.roleV2.SaveRoleSkillSettingsMsg()
    if skillId ~= nil then
        reqData.skillId:AddRange(skillId)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSaveRoleSkillSettingsMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSaveRoleSkillSettingsMessage](LuaEnumNetDef.ReqSaveRoleSkillSettingsMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqSaveRoleSkillSettingsMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:8050 请求领取离线泡点经验
---请求领取离线泡点经验
---msgID: 8050
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReceiveBubbleOfflineExp()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReceiveBubbleOfflineExpMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReceiveBubbleOfflineExpMessage](LuaEnumNetDef.ReqReceiveBubbleOfflineExpMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqReceiveBubbleOfflineExpMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:8052 请求泡点离线经验消息
---请求泡点离线经验消息
---msgID: 8052
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBubbleOfflineExp()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBubbleOfflineExpMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBubbleOfflineExpMessage](LuaEnumNetDef.ReqBubbleOfflineExpMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqBubbleOfflineExpMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:8053 切换自动寻路自动战斗状态
---切换自动寻路自动战斗状态
---msgID: 8053
---@param autoFind boolean 选填参数 自动寻路
---@param autoFight boolean 选填参数 自动战斗
---@return boolean 网络请求是否成功发送
function networkRequest.ReqChangeAutoOperate(autoFind, autoFight)
    local reqTable = {}
    if autoFind ~= nil then
        reqTable.autoFind = autoFind
    end
    if autoFight ~= nil then
        reqTable.autoFight = autoFight
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.AutoOperate" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqChangeAutoOperateMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqChangeAutoOperateMessage](LuaEnumNetDef.ReqChangeAutoOperateMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqChangeAutoOperateMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqChangeAutoOperateMessage", 8053, "AutoOperate", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8055 请求查看矿工信息
---请求查看矿工信息
---msgID: 8055
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetMinerInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetMinerInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetMinerInfoMessage](LuaEnumNetDef.ReqGetMinerInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetMinerInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:8058 请求雇佣矿工
---请求雇佣矿工
---msgID: 8058
---@param id number 选填参数
---@param x number 选填参数
---@param y number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqHireMiner(id, x, y)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    if x ~= nil then
        reqTable.x = x
    end
    if y ~= nil then
        reqTable.y = y
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.ReqHireMiner" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqHireMinerMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqHireMinerMessage](LuaEnumNetDef.ReqHireMinerMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqHireMinerMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqHireMinerMessage", 8058, "ReqHireMiner", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8059 请求领取矿石
---请求领取矿石
---msgID: 8059
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReceiveMineral()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReceiveMineralMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReceiveMineralMessage](LuaEnumNetDef.ReqReceiveMineralMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqReceiveMineralMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:8061 请求保存或修改小秘书记录
---请求保存或修改小秘书记录
---msgID: 8061
---@param secretaryType number 选填参数 1是提问 2是回答 3是问题反馈
---@param problem string 选填参数 保存提问
---@param answerType number 选填参数 回答类型 1 字符串  2 配置ID客户端读表
---@param solution string 选填参数 回答
---@param answerId number 选填参数 回答ID
---@param submissionProblem number 选填参数 是否已提交问题反馈 默认0未提交 1是已提交
---@param compulsoryProblem string 选填参数 问题反馈必填项
---@param wrongCompulsoryProblem string 选填参数 问题反馈非必填项
---@param lid number 选填参数 历史几率的唯一Id
---@param saveOrUpdate number 选填参数 是保存还是修改 0是保存，1是修改
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSaveSecretaryInfo(secretaryType, problem, answerType, solution, answerId, submissionProblem, compulsoryProblem, wrongCompulsoryProblem, lid, saveOrUpdate)
    local reqTable = {}
    if secretaryType ~= nil then
        reqTable.secretaryType = secretaryType
    end
    if problem ~= nil then
        reqTable.problem = problem
    end
    if answerType ~= nil then
        reqTable.answerType = answerType
    end
    if solution ~= nil then
        reqTable.solution = solution
    end
    if answerId ~= nil then
        reqTable.answerId = answerId
    end
    if submissionProblem ~= nil then
        reqTable.submissionProblem = submissionProblem
    end
    if compulsoryProblem ~= nil then
        reqTable.compulsoryProblem = compulsoryProblem
    end
    if wrongCompulsoryProblem ~= nil then
        reqTable.wrongCompulsoryProblem = wrongCompulsoryProblem
    end
    if lid ~= nil then
        reqTable.lid = lid
    end
    if saveOrUpdate ~= nil then
        reqTable.saveOrUpdate = saveOrUpdate
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.ReqSaveSecretaryInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSaveSecretaryInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSaveSecretaryInfoMessage](LuaEnumNetDef.ReqSaveSecretaryInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSaveSecretaryInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSaveSecretaryInfoMessage", 8061, "ReqSaveSecretaryInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8063 请求删除小秘书记录
---请求删除小秘书记录
---msgID: 8063
---@param lid number 选填参数 要删除的历史记录的唯一ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDeleteSecretaryInfo(lid)
    local reqTable = {}
    if lid ~= nil then
        reqTable.lid = lid
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.ReqDeleteSecretaryInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDeleteSecretaryInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDeleteSecretaryInfoMessage](LuaEnumNetDef.ReqDeleteSecretaryInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDeleteSecretaryInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDeleteSecretaryInfoMessage", 8063, "ReqDeleteSecretaryInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8066 检查小秘书推送前置任务是否完成
---检查小秘书推送前置任务是否完成
---msgID: 8066
---@param taskId number 选填参数 任务ID‘
---@param tableId number 选填参数 客户端用
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCheckPreTaskIsComplete(taskId, tableId)
    local reqTable = {}
    if taskId ~= nil then
        reqTable.taskId = taskId
    end
    if tableId ~= nil then
        reqTable.tableId = tableId
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.ReqCheckPreTaskIsComplete" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCheckPreTaskIsCompleteMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCheckPreTaskIsCompleteMessage](LuaEnumNetDef.ReqCheckPreTaskIsCompleteMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqCheckPreTaskIsCompleteMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqCheckPreTaskIsCompleteMessage", 8066, "ReqCheckPreTaskIsComplete", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8069 小秘书主线任务推送
---小秘书主线任务推送
---msgID: 8069
---@param type number 选填参数 类型 1点击任务，判断是否推送过
---@param taskId number 选填参数 任务ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqMainTaskPush(type, taskId)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if taskId ~= nil then
        reqTable.taskId = taskId
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.ReqMainTaskPush" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqMainTaskPushMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqMainTaskPushMessage](LuaEnumNetDef.ReqMainTaskPushMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqMainTaskPushMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqMainTaskPushMessage", 8069, "ReqMainTaskPush", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8071 请求小秘书历史记录
---请求小秘书历史记录
---msgID: 8071
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSeeSecretaryInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSeeSecretaryInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSeeSecretaryInfoMessage](LuaEnumNetDef.ReqSeeSecretaryInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqSeeSecretaryInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:8072 请求炼制大师面板信息
---请求炼制大师面板信息
---msgID: 8072
---@param type number 必填参数 1 修为， 2 灵力, 3-功勋
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRefineMasterPanel(type)
    local reqTable = {}
    reqTable.type = type
    local reqMsgData = protobufMgr.Serialize("roleV2.ReqRefineMasterPanel" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRefineMasterPanelMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRefineMasterPanelMessage](LuaEnumNetDef.ReqRefineMasterPanelMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRefineMasterPanelMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRefineMasterPanelMessage", 8072, "ReqRefineMasterPanel", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8074 请求炼制
---请求炼制
---msgID: 8074
---@param type number 必填参数 炼制类型：1-修为，2-灵力，3-功勋
---@param servantType number 选填参数 炼制灵力时填灵兽类型
---@param times number 选填参数 收益倍数：1-3，默认1倍
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRefineMaster(type, servantType, times)
    local reqTable = {}
    reqTable.type = type
    if servantType ~= nil then
        reqTable.servantType = servantType
    end
    if times ~= nil then
        reqTable.times = times
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.ReqRefine" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRefineMasterMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRefineMasterMessage](LuaEnumNetDef.ReqRefineMasterMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRefineMasterMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRefineMasterMessage", 8074, "ReqRefine", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8078 发送小秘书问题
---发送小秘书问题
---msgID: 8078
---@param content string 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSendQuestionInfo(content)
    local reqTable = {}
    if content ~= nil then
        reqTable.content = content
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.ReqSendQuestionInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSendQuestionInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSendQuestionInfoMessage](LuaEnumNetDef.ReqSendQuestionInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSendQuestionInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSendQuestionInfoMessage", 8078, "ReqSendQuestionInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8080 请求千纸鹤传送
---请求千纸鹤传送
---msgID: 8080
---@param mapId number 选填参数
---@param x number 选填参数
---@param y number 选填参数
---@param line number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPaperCraneDelivery(mapId, x, y, line)
    local reqTable = {}
    if mapId ~= nil then
        reqTable.mapId = mapId
    end
    if x ~= nil then
        reqTable.x = x
    end
    if y ~= nil then
        reqTable.y = y
    end
    if line ~= nil then
        reqTable.line = line
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.ReqPaperCraneDelivery" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPaperCraneDeliveryMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPaperCraneDeliveryMessage](LuaEnumNetDef.ReqPaperCraneDeliveryMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPaperCraneDeliveryMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPaperCraneDeliveryMessage", 8080, "ReqPaperCraneDelivery", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8085 查看联服其他玩家信息请求
---查看联服其他玩家信息请求
---msgID: 8085
---@param targetId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareOtherRoleInfo(targetId)
    local reqTable = {}
    reqTable.targetId = targetId
    local reqMsgData = protobufMgr.Serialize("roleV2.GetRoleInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareOtherRoleInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareOtherRoleInfoMessage](LuaEnumNetDef.ReqShareOtherRoleInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareOtherRoleInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareOtherRoleInfoMessage", 8085, "GetRoleInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8092 请求保存封号天赋
---请求保存封号天赋
---msgID: 8092
---@param zhanAddPoint number 选填参数 对战增伤新增点数,>=0
---@param zhanReducePoint number 选填参数 对战减伤新增点数,>=0
---@param faAddPoint number 选填参数 对法增伤新增点数,>=0
---@param faReducePoint number 选填参数 对法减伤新增点数,>=0
---@param daoAddPoint number 选填参数 对道增伤新增点数,>=0
---@param daoReducePoint number 选填参数 对道减伤新增点数,>=0
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSaveTitleTianfu(zhanAddPoint, zhanReducePoint, faAddPoint, faReducePoint, daoAddPoint, daoReducePoint)
    local reqTable = {}
    if zhanAddPoint ~= nil then
        reqTable.zhanAddPoint = zhanAddPoint
    end
    if zhanReducePoint ~= nil then
        reqTable.zhanReducePoint = zhanReducePoint
    end
    if faAddPoint ~= nil then
        reqTable.faAddPoint = faAddPoint
    end
    if faReducePoint ~= nil then
        reqTable.faReducePoint = faReducePoint
    end
    if daoAddPoint ~= nil then
        reqTable.daoAddPoint = daoAddPoint
    end
    if daoReducePoint ~= nil then
        reqTable.daoReducePoint = daoReducePoint
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.ReqSaveTitleTianfu" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSaveTitleTianfuMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSaveTitleTianfuMessage](LuaEnumNetDef.ReqSaveTitleTianfuMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSaveTitleTianfuMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSaveTitleTianfuMessage", 8092, "ReqSaveTitleTianfu", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8093 请求重置封号天赋
---请求重置封号天赋
---msgID: 8093
---@return boolean 网络请求是否成功发送
function networkRequest.ReqResetTitleTianfu()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqResetTitleTianfuMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqResetTitleTianfuMessage](LuaEnumNetDef.ReqResetTitleTianfuMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqResetTitleTianfuMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:8094 请求打开练功房面板
---请求打开练功房面板
---msgID: 8094
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOpenKongFuHousePanel()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOpenKongFuHousePanelMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOpenKongFuHousePanelMessage](LuaEnumNetDef.ReqOpenKongFuHousePanelMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqOpenKongFuHousePanelMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:8096 请求潜能信息
---请求潜能信息
---msgID: 8096
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPotentialInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPotentialInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPotentialInfoMessage](LuaEnumNetDef.ReqPotentialInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqPotentialInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:8098 请求激活潜能
---请求激活潜能
---msgID: 8098
---@param type number 选填参数 潜能类型 石化等等
---@return boolean 网络请求是否成功发送
function networkRequest.ReqActivePotential(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.ReqActivePotential" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqActivePotentialMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqActivePotentialMessage](LuaEnumNetDef.ReqActivePotentialMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqActivePotentialMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqActivePotentialMessage", 8098, "ReqActivePotential", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8099 请求升级潜能
---请求升级潜能
---msgID: 8099
---@param type number 选填参数 潜能类型 石化等等
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUpgradePotential(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.ReqUpgradePotential" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUpgradePotentialMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUpgradePotentialMessage](LuaEnumNetDef.ReqUpgradePotentialMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUpgradePotentialMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUpgradePotentialMessage", 8099, "ReqUpgradePotential", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8102 请求设置回收配置
---请求设置回收配置
---msgID: 8102
---@param setting table<roleV2.roleV2.SettingBean> 列表参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCollectionSetting(setting)
    local reqTable = {}
    if setting ~= nil then
        reqTable.setting = setting
    else
        reqTable.setting = {}
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.CollectionSetting" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCollectionSettingMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCollectionSettingMessage](LuaEnumNetDef.ReqCollectionSettingMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqCollectionSettingMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqCollectionSettingMessage", 8102, "CollectionSetting", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8104 请求自动拾取配置
---请求自动拾取配置
---msgID: 8104
---@param setting table<roleV2.roleV2.PickUpSettingBean> 列表参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPickUpSetting(setting)
    local reqTable = {}
    if setting ~= nil then
        reqTable.setting = setting
    else
        reqTable.setting = {}
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.PickUpSetting" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPickUpSettingMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPickUpSettingMessage](LuaEnumNetDef.ReqPickUpSettingMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPickUpSettingMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPickUpSettingMessage", 8104, "PickUpSetting", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8106 请求玩家模型数据
---请求玩家模型数据
---msgID: 8106
---@param roleId number 选填参数 玩家id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetRoleModelInfo(roleId)
    local reqTable = {}
    if roleId ~= nil then
        reqTable.roleId = roleId
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.ReqRoleModelInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetRoleModelInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetRoleModelInfoMessage](LuaEnumNetDef.ReqGetRoleModelInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetRoleModelInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetRoleModelInfoMessage", 8106, "ReqRoleModelInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8108 神秘老人请求兑换物品
---神秘老人请求兑换物品
---msgID: 8108
---@param changId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqMysteriousExchange(changId)
    local reqTable = {}
    if changId ~= nil then
        reqTable.changId = changId
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.ReqMysteriousExchange" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqMysteriousExchangeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqMysteriousExchangeMessage](LuaEnumNetDef.ReqMysteriousExchangeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqMysteriousExchangeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqMysteriousExchangeMessage", 8108, "ReqMysteriousExchange", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8111 增加boss击杀次数
---增加boss击杀次数
---msgID: 8111
---@param type number 必填参数 boss类型
---@param addType number 必填参数 1使用卷轴 2消耗砖石
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAddBossKillTimes(type, addType)
    local reqTable = {}
    reqTable.type = type
    reqTable.addType = addType
    local reqMsgData = protobufMgr.Serialize("roleV2.ReqAddBossKillTimes" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAddBossKillTimesMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAddBossKillTimesMessage](LuaEnumNetDef.ReqAddBossKillTimesMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAddBossKillTimesMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAddBossKillTimesMessage", 8111, "ReqAddBossKillTimes", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8113 请求领取系统预告奖励
---请求领取系统预告奖励
---msgID: 8113
---@param id number 选填参数 领取的ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRewardSystemPreview(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.ReqRewardSystemPreview" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRewardSystemPreviewMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRewardSystemPreviewMessage](LuaEnumNetDef.ReqRewardSystemPreviewMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRewardSystemPreviewMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRewardSystemPreviewMessage", 8113, "ReqRewardSystemPreview", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8114 请求消耗资源兑换经验
---请求消耗资源兑换经验
---msgID: 8114
---@param gear number 选填参数 兑换的档位
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAddRoleExpByResources(gear)
    local reqTable = {}
    if gear ~= nil then
        reqTable.gear = gear
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.ReqAddRoleExpByResources" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAddRoleExpByResourcesMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAddRoleExpByResourcesMessage](LuaEnumNetDef.ReqAddRoleExpByResourcesMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAddRoleExpByResourcesMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAddRoleExpByResourcesMessage", 8114, "ReqAddRoleExpByResources", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8117 转性
---转性
---msgID: 8117
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTransferSex()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTransferSexMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTransferSexMessage](LuaEnumNetDef.ReqTransferSexMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqTransferSexMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:8119 转职
---转职
---msgID: 8119
---@param career number 必填参数 想转的职业
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTransferCareer(career)
    local reqTable = {}
    reqTable.career = career
    local reqMsgData = protobufMgr.Serialize("roleV2.ReqTransferCareer" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTransferCareerMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTransferCareerMessage](LuaEnumNetDef.ReqTransferCareerMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqTransferCareerMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqTransferCareerMessage", 8119, "ReqTransferCareer", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8122 请求投保
---请求投保
---msgID: 8122
---@param index number 选填参数 对应的装备位置
---@param itemLid number 选填参数 物品唯一ID
---@param abandonInsured number 选填参数 0投保，1弃保
---@return boolean 网络请求是否成功发送
function networkRequest.ReqInsuredEquip(index, itemLid, abandonInsured)
    local reqTable = {}
    if index ~= nil then
        reqTable.index = index
    end
    if itemLid ~= nil then
        reqTable.itemLid = itemLid
    end
    if abandonInsured ~= nil then
        reqTable.abandonInsured = abandonInsured
    end
    local reqMsgData = protobufMgr.Serialize("roleV2.ReqInsuredEquip" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqInsuredEquipMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqInsuredEquipMessage](LuaEnumNetDef.ReqInsuredEquipMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqInsuredEquipMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqInsuredEquipMessage", 8122, "ReqInsuredEquip", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:8124 请求身上可投保列表
---请求身上可投保列表
---msgID: 8124
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCanInsuredEquip()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCanInsuredEquipMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCanInsuredEquipMessage](LuaEnumNetDef.ReqCanInsuredEquipMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqCanInsuredEquipMessage, nil, true)
    end
    return canSendMsg
end
--endregion

