--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--cart.xml

--region ID:105002 ResBodyGuardInfoMessage 返回镖师面板
---@param msgID LuaEnumNetDef 消息ID
---@param tblData cartV2.ResBodyGuardInfo lua table类型消息数据
---@param csData cartV2.ResBodyGuardInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[105002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:105005 ResUnionCartInfoMessage 返回押镖信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData cartV2.ResUnionCartInfo lua table类型消息数据
---@param csData cartV2.ResUnionCartInfo C# class类型消息数据
netMsgPreprocessing[105005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil then
        uiStaticParameter.InCarAcitivity = true
        CS.CSScene.MainPlayerInfo.UnionDartCarInfo:RefreshUnionDartCarInfo(csData)
        uimanager:CreatePanel("UIGangEscortLeftPanel",nil,tblData)
    end
end
--endregion

--region ID:105006 ResWithdrawUnionCartMessage 返回退出押镖响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[105006] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    uiStaticParameter.InCarAcitivity = false
    uimanager:ClosePanel("UIGangEscortLeftPanel")
    Utility.TryStopUnionDartCarFindPath()
end
--endregion

--region ID:105007 ResUnionCartFinishMessage 行会镖车结束消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData cartV2.ResUnionCartFinish lua table类型消息数据
---@param csData cartV2.ResUnionCartFinish C# class类型消息数据
netMsgPreprocessing[105007] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    local UIGangEscortLeftPanel = uimanager:GetPanel("UIGangEscortLeftPanel")
    if tblData ~= nil and tblData.rank.common.isArrive == true and UIGangEscortLeftPanel ~= nil then
        UIGangEscortLeftPanel:TryClosePanelAndPlaySuccessEffect(tblData,csData)
    else
        Utility.CloseUnionDartCarActivity()
        CS.CSScene.MainPlayerInfo.ActivityInfo:UpdateUnionDartCarFinishRankInfo(csData)
    end
end
--endregion

--region ID:105009 ResPersonalCartListMessage 返回个人押镖列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData cartV2.ResPersonalCartList lua table类型消息数据
---@param csData cartV2.ResPersonalCartList C# class类型消息数据
netMsgPreprocessing[105009] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.PersonDartcarInfo:UpdateAllDartCarList(csData)
end
--endregion

--region ID:105010 ResPersonalCartSituationMessage 返回个人镖车动态
---@param msgID LuaEnumNetDef 消息ID
---@param tblData cartV2.ResPersonalCartSituation lua table类型消息数据
---@param csData cartV2.ResPersonalCartSituation C# class类型消息数据
netMsgPreprocessing[105010] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    ---策划暂时取消镖车相关的气泡刷新
    --local dartCarName = ""
    --local dartCarInfo = nil
    --if tblData ~= nil and tblData.id ~= nil then
    --    dartCarInfo = CS.CSScene.MainPlayerInfo.PersonDartcarInfo:GetDartCarByCarLid(csData.id)
    --end
    --if tblData ~= nil and tblData.cfgId ~= nil then
    --    dartCarName = CS.Cfg_PersonDartCarTableManager.Instance:GetYaBiaoNameById(tblData.cfgId)
    --end
    --local mapName = ""
    --if tblData ~= nil and tblData.mapName ~= nil and tblData.x ~= nil and tblData.y ~= nil then
    --    mapName =  luaEnumColorType.Red .. tblData.mapName ..tostring(tblData.x) .. "," .. tostring(tblData.y)
    --end
    ----print("镖车动态" .. tostring(tblData.type))
    --if tblData.type == LuaEnumPersonCarStateType.BEATTACK then
    --    Utility.TryAddFlashPromp({id = LuaEnumFlashIdType.PersonDartCar_BeAttack,clickCallBack = function()
    --        Utility.RemoveFlashPrompt(1,LuaEnumFlashIdType.PersonDartCar_BeAttack)
    --        Utility.ShowSecondConfirmPanel({PromptWordId = LuaEnumSecondConfirmType.PersonCarBeAttack,
    --                                        des = CS.Cfg_PromptWordTableManager.Instance:GetShowContent(LuaEnumSecondConfirmType.PersonCarBeAttack,dartCarName,tblData.targetUnionName,tblData.targetName,mapName),
    --                                        ComfireAucion = function()
    --                                            local dot2 = CS.SFMiscBase.Dot2(tblData.x, tblData.y)
    --                                            CS.CSScene.MainPlayerInfo.AsyncOperationController.PersonDartCarFindPathOperation:DoOperation(tblData.id,tblData.mapId, dot2)
    --                                            uimanager:ClosePanel("UIPromptPanel")
    --                                            uimanager:ClosePanel("UIIndividEscortPanel")
    --                                        end})
    --    end})
    --elseif dartCarInfo ~= nil and tblData.type == LuaEnumPersonCarStateType.BEKILL then
    --    Utility.TryAddFlashPromp({id = LuaEnumFlashIdType.PersonDartCar_BeKill,clickCallBack = function()
    --        Utility.RemoveFlashPrompt(1,LuaEnumFlashIdType.PersonDartCar_BeKill)
    --        Utility.ShowSecondConfirmPanel({PromptWordId = LuaEnumSecondConfirmType.PersonCarBeKill,
    --                                        des = CS.Cfg_PromptWordTableManager.Instance:GetShowContent(LuaEnumSecondConfirmType.PersonCarBeKill,dartCarName,tblData.targetUnionName,tblData.targetName),
    --                                        ComfireAucion = function()
    --                                            CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({dartCarInfo.ReceiveNpcId },"UIIndividEscortPanel",CS.EAutoPathFindSourceSystemType.Normal,CS.EAutoPathFindType.Normal_TowardNPC,dartCarInfo.ReceiveNpcId)
    --                                            uimanager:ClosePanel("UIPromptPanel")
    --                                            uimanager:ClosePanel("UIIndividEscortPanel")
    --                                        end})
    --    end})
    --elseif dartCarInfo ~= nil and tblData.type == LuaEnumPersonCarStateType.SUCCESS then
    --    Utility.TryAddFlashPromp({id = LuaEnumFlashIdType.PersonDartCar_Success,clickCallBack = function()
    --        Utility.RemoveFlashPrompt(1,LuaEnumFlashIdType.PersonDartCar_Success)
    --        Utility.ShowSecondConfirmPanel({PromptWordId = LuaEnumSecondConfirmType.PersonCarSuccess,
    --                                        des = CS.Cfg_PromptWordTableManager.Instance:GetShowContent(LuaEnumSecondConfirmType.PersonCarSuccess,dartCarName),
    --                                        ComfireAucion = function()
    --                                            CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({dartCarInfo.ReceiveNpcId },"UIIndividEscortPanel",CS.EAutoPathFindSourceSystemType.Normal,CS.EAutoPathFindType.Normal_TowardNPC,dartCarInfo.ReceiveNpcId)
    --                                            uimanager:ClosePanel("UIPromptPanel")
    --                                            uimanager:ClosePanel("UIIndividEscortPanel")
    --                                        end})
    --    end})
    --end
end
--endregion

--region ID:105012 ResUpdatePersonalCartMessage 返回更新个人镖车列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData cartV2.ResUpdatePersonalCart lua table类型消息数据
---@param csData cartV2.ResUpdatePersonalCart C# class类型消息数据
netMsgPreprocessing[105012] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.PersonDartcarInfo:UpdateDartCarChangeData(csData)
end
--endregion

--region ID:105014 ResCartMatterCodeMessage 返回个人镖车错误码
---@param msgID LuaEnumNetDef 消息ID
---@param tblData cartV2.CartMatterCode lua table类型消息数据
---@param csData cartV2.CartMatterCode C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[105014] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:105015 ResPersonalCartHpUpdateMessage 返回更新个人镖车血量
---@param msgID LuaEnumNetDef 消息ID
---@param tblData cartV2.ResPersonalCartHpUpdate lua table类型消息数据
---@param csData cartV2.ResPersonalCartHpUpdate C# class类型消息数据
netMsgPreprocessing[105015] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.PersonDartcarInfo:UpdateSingleDartCarParams(csData)
end
--endregion

--region ID:105017 ResUnionCartRankMessage 返回行会押镖排行
---@param msgID LuaEnumNetDef 消息ID
---@param tblData cartV2.UnionCartRank lua table类型消息数据
---@param csData cartV2.UnionCartRank C# class类型消息数据
netMsgPreprocessing[105017] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.ActivityInfo:UpdateUnionDartCarRankInfo(csData)
end
--endregion

--region ID:105019 ResUnionCartLastRankMessage 返回行会押镖上次活动排行
---@param msgID LuaEnumNetDef 消息ID
---@param tblData cartV2.ResUnionCartRankRecord lua table类型消息数据
---@param csData cartV2.ResUnionCartRankRecord C# class类型消息数据
netMsgPreprocessing[105019] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.ActivityInfo:UpdateLastUnionDartCarRankInfo(csData)
end
--endregion

--region ID:105021 ResPersonalCartPositionMessage 返回个人镖车坐标
---@param msgID LuaEnumNetDef 消息ID
---@param tblData cartV2.ResPersonalCartPosition lua table类型消息数据
---@param csData cartV2.ResPersonalCartPosition C# class类型消息数据
netMsgPreprocessing[105021] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData ~= nil then
        local dot2 = CS.SFMiscBase.Dot2(tblData.x, tblData.y)
        CS.CSScene.MainPlayerInfo.AsyncOperationController.PersonDartCarFindPathOperation:DoOperation(tblData.id,tblData.mapId, dot2)
    end
end
--endregion

--region ID:105023 ResFreightCarInfoMessage 运货押镖车信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData cartV2.ResFreightCarInfo lua table类型消息数据
---@param csData cartV2.ResFreightCarInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[105023] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil and gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar() ~= nil and gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar().RefreshOperationDartCar ~= nil then
        gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar():RefreshOperationDartCar(tblData)
    end
end
--endregion

--region ID:105024 ResRoleFreightInfoMessage 返回个人押镖信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData cartV2.ResRoleFreightInfo lua table类型消息数据
---@param csData cartV2.ResRoleFreightInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[105024] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil and gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar() ~= nil and gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar().RefreshMainPlayerDartCarBaseInfo ~= nil then
        gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar():RefreshMainPlayerDartCarBaseInfo(tblData)
    end
end
--endregion

--region ID:105026 ResFreightCarHpChangeMessage 返会飙车血量
---@param msgID LuaEnumNetDef 消息ID
---@param tblData cartV2.ResFreightCarHpChange lua table类型消息数据
---@param csData cartV2.ResFreightCarHpChange C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[105026] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil and gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar() ~= nil and gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar().RefreshOperationDartCarHp ~= nil then
        gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar():RefreshOperationDartCarHp(tblData)
    end
end
--endregion

--region ID:105027 ResFreightCarPointChangeMessage 返回飙车XY变更
---@param msgID LuaEnumNetDef 消息ID
---@param tblData cartV2.ResFreightCarPointChange lua table类型消息数据
---@param csData cartV2.ResFreightCarPointChange C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[105027] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar():RefreshOperationDartCarPos(tblData)
end
--endregion

--region ID:105028 ResFinishFreightCarMessage 送货押镖结束包
---@param msgID LuaEnumNetDef 消息ID
---@param tblData cartV2.ResFinishFreightCar lua table类型消息数据
---@param csData cartV2.ResFinishFreightCar C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[105028] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil and gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar() ~= nil and gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar().TryCloseLeftPanel ~= nil then
        gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar():TryCloseLeftPanel(tblData.lid)
        gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar():TryHintPlayerStartDartCar()
    end
end
--endregion
