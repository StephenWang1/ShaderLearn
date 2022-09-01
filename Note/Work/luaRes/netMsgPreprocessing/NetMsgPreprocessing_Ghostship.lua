--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--ghostship.xml

--region ID:132002 ResGhostShipStateMessage 幽灵船状态
---@param msgID LuaEnumNetDef 消息ID
---@param tblData ghostshipV2.GhostShipState lua table类型消息数据
---@param csData ghostshipV2.GhostShipState C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[132002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr == nil or gameMgr:GetPlayerDataMgr() == nil then
        return
    end
    if tblData then
        if tblData.state ~= nil then
            gameMgr:GetPlayerDataMgr():GetLuaGhostShipMgr():SetState(tblData.state == 1)
        end
        if tblData.first ~= nil then
            if tblData.first == 1 then
                local globalTbl = (LuaGlobalTableDeal.GetGlobalTabl(23047)).value
                if globalTbl == nil then
                    return
                end
                local info = string.Split(globalTbl, "#")
                local currentTime = CS.UnityEngine.Time.time
                local flashtemp = {}
                flashtemp.id = tonumber(info[1])
                local timeStamp = gameMgr:GetLuaTimeMgr():GetServerNowTimeStamp()
                flashtemp.mTime = tonumber(info[3]) + timeStamp
                flashtemp.clickCallBack = function()
                    local temp = {}
                    temp.ID = tonumber(info[2])
                    local currentTime2 = CS.UnityEngine.Time.time
                    local time = tonumber(info[3]) - ((currentTime2 - currentTime) * 1000)
                    temp.Time = time
                    temp.TimeType = LuaEnumSecondComfirmTimeType.MinuteAndSecond
                    temp.TimeEndCallBack = function()
                        uimanager:ClosePanel('UIPromptPanel')
                    end
                    temp.CallBack = function()
                        Utility.RemoveFlashPrompt(1, tonumber(info[1]))
                        Utility.TryTransfer(tonumber(info[4]))
                    end
                    temp.CancelCallBack = function()
                        Utility.RemoveFlashPrompt(1, tonumber(info[1]))
                        uimanager:ClosePanel('UIPromptPanel')
                    end
                    uimanager:CreatePanel("UIPromptPanel",nil,temp)
                end
                Utility.AddFlashPrompt(flashtemp)
            end
        end
    end
end
--endregion

--region ID:132003 ResGhostShipRoleDataMessage 幽灵船玩家数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData ghostshipV2.GhostShipRoleData lua table类型消息数据
---@param csData ghostshipV2.GhostShipRoleData C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[132003] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr == nil or gameMgr:GetPlayerDataMgr() == nil then
        return
    end
    if tblData ~= nil then
        if tblData.killTimes ~= nil and tblData.assistTimes ~= nil then
            gameMgr:GetPlayerDataMgr():GetLuaGhostShipMgr():SetKillState(tblData.killTimes)
            gameMgr:GetPlayerDataMgr():GetLuaGhostShipMgr():SetHelpState(tblData.assistTimes)
        end
    end
end
--endregion

--region ID:132004 ResGhostShipRoleTimeMessage 幽灵船剩余时间
---@param msgID LuaEnumNetDef 消息ID
---@param tblData ghostshipV2.GhostShipTime lua table类型消息数据
---@param csData ghostshipV2.GhostShipTime C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[132004] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr == nil or gameMgr:GetPlayerDataMgr() == nil then
        return
    end
    if tblData ~= nil then
        if tblData.surTime ~= nil then
            gameMgr:GetPlayerDataMgr():GetLuaGhostShipMgr():StartCount(tblData.surTime)
        end
    end
end
--endregion
