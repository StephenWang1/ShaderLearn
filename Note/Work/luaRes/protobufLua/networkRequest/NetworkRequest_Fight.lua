--[[本文件为工具自动生成,禁止手动修改]]
--fight.xml

--region ID:69001 请求攻击
---请求攻击
---msgID: 69001
---@param skillId number 必填参数
---@param targetId number 选填参数
---@param x number 选填参数
---@param y number 选填参数
---@param useBufferId number 选填参数
---@param sign number 选填参数 自增量标记
---@return boolean 网络请求是否成功发送
function networkRequest.ReqFight(skillId, targetId, x, y, useBufferId, sign)
    local reqTable = {}
    reqTable.skillId = skillId
    if targetId ~= nil then
        reqTable.targetId = targetId
    end
    if x ~= nil then
        reqTable.x = x
    end
    if y ~= nil then
        reqTable.y = y
    end
    if useBufferId ~= nil then
        reqTable.useBufferId = useBufferId
    end
    if sign ~= nil then
        reqTable.sign = sign
    end
    local reqMsgData = protobufMgr.Serialize("fightV2.FightRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqFightMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqFightMessage](LuaEnumNetDef.ReqFightMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqFightMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqFightMessage", 69001, "FightRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

