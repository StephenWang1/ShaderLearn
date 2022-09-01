--[[本文件为工具自动生成,禁止手动修改]]
--count.xml

--region ID:21003 请求副本道具使用次数
---请求副本道具使用次数
---msgID: 21003
---@param mapId number 选填参数 副本id
---@param globalId System.Collections.Generic.List1T<number> 列表参数 global配置id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetInstanceItemUseCount(mapId, globalId)
    local reqData = CS.countV2.ReqGetInstanceItemUseCount()
    if mapId ~= nil then
        reqData.mapId = mapId
    end
    if globalId ~= nil then
        reqData.globalId:AddRange(globalId)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetInstanceItemUseCountMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetInstanceItemUseCountMessage](LuaEnumNetDef.ReqGetInstanceItemUseCountMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetInstanceItemUseCountMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

