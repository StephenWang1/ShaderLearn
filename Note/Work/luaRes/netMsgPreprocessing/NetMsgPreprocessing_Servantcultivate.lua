--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--servantcultivate.xml

--region ID:151002 ResServantCultivateInfoMessage 灵兽修炼信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData servantcultivateV2.resCultivateInfo lua table类型消息数据
---@param csData servantcultivateV2.resCultivateInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[151002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData ~= nil then
        if tblData.status == 1 then
            uiStaticParameter.nowPracticeIndex = tblData.type
        else
            uiStaticParameter.nowPracticeIndex = -1
        end
    else
        uiStaticParameter.nowPracticeIndex = -1
    end
    if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetLuaServantInfo() ~= nil then
        gameMgr:GetPlayerDataMgr():GetLuaServantInfo():RefreshServantPracticeData(tblData)
    end
end
--endregion

--region ID:151006 ResServantCultivateRedMessage 灵兽修炼小红点
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[151006] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.ServantInfoV2.IsServantCultivateRed = true
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_Practice_PUSH);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_Practice_Site1);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_Practice_Site2);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_Practice_Site3);
end
--endregion

--region ID:151008 ResServantCultivateBeAttackMessage 灵兽修炼被攻击
---@param msgID LuaEnumNetDef 消息ID
---@param tblData servantcultivateV2.cultivateRedInfo lua table类型消息数据
---@param csData servantcultivateV2.cultivateRedInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[151008] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData then
        local data = {}
        local flashId = 33
        data. id = flashId
        local haveFlashPromp = Utility.CheckFlashPrompt(1, flashId)
        if haveFlashPromp then
            Utility.RemoveFlashPrompt(1, flashId)
        end
        data.clickCallBack = function()
            Utility.RemoveFlashPrompt(1, flashId)
            local customData = {}
            local id = -1
            --1：受到攻击 2：死亡
            if tblData.reasons == 1 then
                id = 113
                local isFind, promptInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(113)
                if isFind then
                    local mapShow = ""
                    local isFindMap, mapInfo = CS.Cfg_MapTableManager.Instance.dic:TryGetValue(tblData.mapId)
                    if isFindMap then
                        mapShow = mapInfo.name .. "(" .. tblData.x .. "," .. tblData.y .. ")"
                    end
                    customData.str = string.format(promptInfo.des, mapShow, tblData.killName)
                end
            elseif tblData.reasons == 2 then
                id = 114
                local isFind, promptInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(114)
                if isFind then
                    customData.str = string.format(promptInfo.des, tblData.killName)
                end
            end
            customData.id = id
            customData.Callback = function()
                if tblData.reasons == 1 then
                    local dot2 = CS.SFMiscBase.Dot2(tblData.x, tblData.y)
                    CS.CSScene.MainPlayerInfo.AsyncOperationController.FindPointWithFlyShoes:DoOperation(tblData.mapId, dot2)
                elseif tblData.reasons == 2 then
                    Utility.ClosePromptTipsPanel()
                end
            end
            if id ~= -1 then
                Utility.ShowPromptTipsPanel(customData)
            end
        end
        Utility.TryAddFlashPromp(data)
        if uiStaticParameter.ServantFlashCount ~= nil then
            CS.CSListUpdateMgr.Instance:Remove(uiStaticParameter.ServantFlashCount)
        end
        if tblData.reasons == 1 then
            local time = LuaGlobalTableDeal.GetRemoveServantFlashTime()
            uiStaticParameter.ServantFlashCount = CS.CSListUpdateMgr.Add(time * 1000, nil, function()
                Utility.RemoveFlashPrompt(1, flashId)
            end, false)
        end
    end
end
--endregion
