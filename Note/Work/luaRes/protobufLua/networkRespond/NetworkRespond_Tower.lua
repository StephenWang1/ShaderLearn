--[[本文件为工具自动生成,禁止手动修改]]
--tower.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---发送通天塔面板信息
---msgID: 54001
---@param msgID LuaEnumNetDef 消息ID
---@return towerV2.ResRoleTowerInfo C#数据结构
function networkRespond.OnResRoleTowerInfoMessageReceived(msgID)
    ---@type towerV2.ResRoleTowerInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 54001 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 54001 towerV2.ResRoleTowerInfo 发送通天塔面板信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---C#中对消息结构引用到的某个类型的字段未实现,故需要打印出lua的网络日志
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRoleTowerInfoMessage", 54001, "ResRoleTowerInfo", tblData)
    end
    local csData
    if protobufMgr.DecodeTable.tower ~= nil and  protobufMgr.DecodeTable.tower.ResRoleTowerInfo ~= nil then
        csData = protobufMgr.DecodeTable.tower.ResRoleTowerInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

