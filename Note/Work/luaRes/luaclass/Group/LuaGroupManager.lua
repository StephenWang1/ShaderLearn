---@class LuaGroupManager 组队
local LuaGroupManager = {}

--region 召唤令
---处理召唤令消息
---@param tblData shareGroupV2.TeamCallBack lua table类型消息数据
---@param csData shareGroupV2.TeamCallBack C# class类型消息数据
function LuaGroupManager:DealCallBackMessage(msgID, tblData, csData)
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.ID == csData.roleId then
        return
    end

    ---如果进入的地图是王者禁地而且玩家不满足王者禁地的商会条件,则不显示召唤
    ---@type TABLE.CFG_MAP
    local mapTblExist, mapTbl = CS.Cfg_MapTableManager.Instance:TryGetValue(tblData.mapId)
    if mapTbl and mapTbl.announceDeliver == 1024 then
        if mapTbl.conditionId ~= nil and CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(mapTbl.conditionId.list) == false then
            return
        end
    end

    ---召唤令闪烁提示
    local temp = {}
    local PromptWordID = 0
    ---@type SummonTisData
    local data = {}
    local monsterid = csData.monsterId
    local mapId = csData.mapId;

    ---行会/组队召唤，同地图不提示（烟花之地）
    if csData.type == 1 or csData.type == 2 then
        local resDup, dupTbl = CS.Cfg_DuplicateTableManager.Instance.dic:TryGetValue(tblData.mapId)
        if resDup and dupTbl.type == 47 then
            local playerMapId = CS.CSScene.getMapID()
            data.mNeedShowCost = playerMapId ~= tblData.mapId
        end
    end

    ---幽灵船召唤
    if csData.type == 6 then
        local globalTbl = (LuaGlobalTableDeal.GetGlobalTabl(23060)).value
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
            local isFind, promptWordTbl = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(tonumber(info[2]))
            if isFind then
                local name = tblData.name
                local mapId = tblData.mapId
                local monsterId = tblData.monsterId
                local monsterTbl = clientTableManager.cfg_monstersManager:TryGetValue(monsterId)
                local mapTbl = clientTableManager.cfg_mapManager:TryGetValue(mapId)
                if mapTbl ~= nil and monsterTbl ~= nil then
                    local des = string.format(promptWordTbl.des, name, mapTbl:GetName(), monsterTbl:GetName())
                    temp.Content = des
                end
            end
            local currentTime2 = CS.UnityEngine.Time.time
            local time = tonumber(info[3]) - ((currentTime2 - currentTime) * 1000)
            temp.Time = time
            temp.TimeType = LuaEnumSecondComfirmTimeType.MinuteAndSecond
            temp.TimeEndCallBack = function()
                uimanager:ClosePanel('UIPromptPanel')
            end
            temp.CallBack = function()
                Utility.RemoveFlashPrompt(1, tonumber(info[1]))
                networkRequest.ReqCheckCallBack(true, csData.roleId, csData.type)
            end
            temp.CancelCallBack = function()
                Utility.RemoveFlashPrompt(1, tonumber(info[1]))
                uimanager:ClosePanel('UIPromptPanel')
            end
            uimanager:CreatePanel("UIPromptPanel",nil,temp)
        end
        Utility.AddFlashPrompt(flashtemp)
        return
    end


    --人物限制是否达到
    local limit = CS.Cfg_GlobalTableManager.Instance.callLevelLimit
    ---战斗状态类型
    local combatObjectType = 0
    if csData.paramStrs ~= nil and csData.paramStrs.Count > 0 then
        combatObjectType = tonumber(csData.paramStrs[0])
        --print("接收到的战斗状态" .. tostring(combatObjectType))
    end
    if (csData.type == 1) then
        --组队召唤
        if limit.Length > 0 and CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.Level < limit[0] then
            return
        end
        temp.id = 4
        if monsterid ~= 0 or combatObjectType == Utility.EnumToInt(CS.EServerMapObjectType.Monster) then
            PromptWordID = 109
        elseif combatObjectType == Utility.EnumToInt(CS.EServerMapObjectType.Player) then
            PromptWordID = 117
        else
            PromptWordID = 77
        end
        Utility.RemoveFlashPrompt(1, 4)
    elseif (csData.type == 2) then
        --行会召唤
        if limit.Length > 1 and CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.Level < limit[1] then
            return
        end
        temp.id = 5

        --优先级/火堆-pk-攻击boss
        if tblData.isinfire == 1 then
            --篝火行会召唤
            PromptWordID = 153
        else
            if monsterid ~= 0 or combatObjectType == Utility.EnumToInt(CS.EServerMapObjectType.Monster) then
                PromptWordID = 108
            elseif combatObjectType == Utility.EnumToInt(CS.EServerMapObjectType.Player) then
                PromptWordID = 116
            else
                PromptWordID = 76
            end
        end
        Utility.RemoveFlashPrompt(1, 5)
    elseif (csData.type == 3) then
        -- 夫妻支援
        temp.id = 12
        PromptWordID = 78
        Utility.RemoveFlashPrompt(1, 12)
    elseif (csData.type == 5) then
        ---联盟召唤令
        if limit.Length > 1 and CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.Level < limit[1] then
            return
        end
        temp.id = 36
        if monsterid ~= 0 or combatObjectType == Utility.EnumToInt(CS.EServerMapObjectType.Monster) then
            PromptWordID = 140;
        elseif combatObjectType == Utility.EnumToInt(CS.EServerMapObjectType.Player) then
            PromptWordID = 141;
        else
            PromptWordID = 139;
        end
        Utility.RemoveFlashPrompt(1, 36)
    end

    local isFind, info = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(PromptWordID)
    if not isFind then
        if isOpenLog then
            luaDebug.Log("PromptWordID表数据有误   id: " .. PromptWordID)
        end
        return
    end
    if info.des == nil or info.des == "" then
        return
    end

    local isfind, mapInfo = CS.Cfg_MapTableManager.Instance.dic:TryGetValue(csData.mapId)
    if not isfind then
        if isOpenLog then
            luaDebug.Log("Map表数据有误   id: " .. csData.mapId)
        end
        return
    end

    --地图限制是否达到
    local isMeet, type, meetNum = CS.Cfg_MapTableManager.Instance:IsMeetMapConditionGetNeedCount(csData.mapId)
    if not isMeet then
        if type == LuaEnumConditionKeyType.GreatePlayerLevel or type == LuaEnumConditionKeyType.LessPlayerLevel then
            return
        elseif type == LuaEnumConditionKeyType.GreatReincarnationLevel or type == LuaEnumConditionKeyType.LessReincarnationLevel then
            return
        end
    end

    if tblData.isinfire == 1 then
        --优先级/火堆-pk-攻击boss
        --篝火行会召唤
        local fireType = tblData.firetype
        local luaFireInfo = clientTableManager.cfg_bonfireManager:TryGetValue(fireType)
        if luaFireInfo then
            data.Content = string.format(string.gsub(info.des, "\\n", '\n'), csData.name, mapInfo.name, luaFireInfo:GetName())
        end
    else
        if (monsterid ~= 0) then
            local monsterTableIsFind, monsterTable = CS.Cfg_MonsterTableManager.Instance:TryGetValue(monsterid)
            if (monsterTableIsFind) then
                local color = LuaGlobalTableDeal.GetMonsterNameColorByType(tostring(monsterTable.type))
                if (csData.name ~= nil and mapInfo.name ~= nil) then
                    data.Content = string.format(string.gsub(info.des, "\\n", '\n'), csData.name, mapInfo.name, color .. monsterTable.name)
                end
            end
        else
            if (csData.name ~= nil and mapInfo.name ~= nil) then
                data.Content = string.format(string.gsub(info.des, "\\n", '\n'), csData.name, mapInfo.name, "")
            end
        end
    end
    data.PromptWordID = PromptWordID

    data.Time = csData.time / 1000
    data.LastTime = csData.time
    data.mapId = csData.mapId
    data.CancelCallBack = function()
        Utility.RemoveFlashPrompt(1, temp.id)
    end
    data.TimeEndCallBack = function()
        Utility.RemoveFlashPrompt(1, temp.id)
        uimanager:ClosePanel("UISummonTipsPanel")
    end
    data.CallBack = function()
        ---如果为恶魔广场地图且剩余时间为0时
        --if LuaGlobalTableDeal.IsEMGCMap(csData.mapId) and uiStaticParameter.DevilRemaining == 0 then
        --    CS.CSScene.MainPlayerInfo.AsyncOperationController.LangYanMengJingDeliverAndOpenPanelOperation:DoOperation(1017, 2, 89)
        --    Utility.RemoveFlashPrompt(1, temp.id)
        --    return
        --end
        ---上古战场战勋等级不足
        if Utility.CanEnterAncientBattlefileldMap(csData.mapId) == false then
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Role_Prefix)
            Utility.RemoveFlashPrompt(1, temp.id)
            return
        end
        ---服务器需求
        if luaclass.RemoteHostDataClass:IsKuaFuMap() and csData.type ~= 2 and csData.type ~= 3 then
            networkRequest.ReqShareCheckCallBack(true, csData.roleId, csData.type)
        else
            networkRequest.ReqCheckCallBack(true, csData.roleId, csData.type)
        end
        Utility.RemoveFlashPrompt(1, temp.id)
        --if luaclass.RemoteHostDataClass:IsKuaFuMap() then
        --    networkRequest.ReqShareCheckCallBack(true, csData.roleId, csData.type)
        --else
        --    networkRequest.ReqCheckCallBack(true, csData.roleId, csData.type)
        --end
    end
    data.CenterDescription = info.leftButton
    data.IsToggleVisable = false
    data.IsShowCloseBtn = true
    temp.mTime = csData.time
    temp.panelPriority = data
    Utility.AddFlashPrompt(temp)

end
--endregion

return LuaGroupManager