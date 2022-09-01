--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--user.xml

--region ID:1002 ResCreateRoleMessage 告知客户端需要创建角色
---@param msgID LuaEnumNetDef 消息ID
---@param tblData userV2.ResCreateRole lua table类型消息数据
---@param csData userV2.ResCreateRole C# class类型消息数据
netMsgPreprocessing[1002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    print('ResCreateRoleMessage----------------------')
end
--endregion

--region ID:1005 ResRandomNameMessage 告知随机名字
---@param msgID LuaEnumNetDef 消息ID
---@param tblData userV2.ResRandomName lua table类型消息数据
---@param csData userV2.ResRandomName C# class类型消息数据
netMsgPreprocessing[1005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:1006 ResEnterGameMessage 告知客户端进入游戏
---@param msgID LuaEnumNetDef 消息ID
---@param tblData userV2.ResEnterGame lua table类型消息数据
---@param csData userV2.ResEnterGame C# class类型消息数据
netMsgPreprocessing[1006] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:1007 ResLoginMessage 通知登录成功
---@param msgID LuaEnumNetDef 消息ID
---@param tblData userV2.ResLogin lua table类型消息数据
---@param csData userV2.ResLogin C# class类型消息数据
netMsgPreprocessing[1007] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData ~= nil then
        CS.UserManager.Instance.RoleBriefList:Clear()
        for i = 0, csData.roleList.Count - 1 do
            CS.UserManager.Instance.RoleBriefList:Add(csData.roleList[i])
        end
    end
end
--endregion

--region ID:1010 ResHeartMessage 心跳返回
---@param msgID LuaEnumNetDef 消息ID
---@param tblData userV2.ResHeart lua table类型消息数据
---@param csData userV2.ResHeart C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[1010] = function(msgID, tblData, csData)
    local netWork = CS.CSNetwork.Instance
    --在此处填入预处理代码
    netWork.HeartCheckTime = 0;
    if (netWork.HeartbeatNum == 0) then
        CS.CSServerTime.Instance:refreshTime(tblData.nowTime, tblData.clientTime);
    end

    CS.CSServerTime.IsServerTimeReceived = true;
    local count = netWork.HeartbeatNum
    if (count >= 1) then
        netWork.HeartbeatNum = 0;
    else
        netWork.HeartbeatNum = count + 1
    end
    if gameMgr:GetLuaTimeMgr() ~= nil and gameMgr:GetLuaTimeMgr().ResHeartMessage ~= nil then
        gameMgr:GetLuaTimeMgr():ResHeartMessage(tblData)
    end
    --CS.CSCalendarInfoV2.Instance:InitializeCalendarEndHeartBeatMessage();
    if uiStaticParameter.NeedPrintHeart then
        CS.UnityEngine.Debug.LogError("行会首领时间异常打印心跳包 clientTime:" .. tblData.clientTime .. "nowTime" .. tblData.nowTime)
        uiStaticParameter.NeedPrintHeart = false
    end
end
--endregion

--region ID:1019 ResAfterLoginInfoMessage 返回登陆前信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData userV2.ResAfterLoginInfo lua table类型消息数据
---@param csData userV2.ResAfterLoginInfo C# class类型消息数据
netMsgPreprocessing[1019] = function(msgID, tblData, csData)
    --在此处填入预处理代码

    CS.CSServerTime.ServerCurTime = tblData.serverCurTime;
    CS.CSServerTime.OpenServerTime = tblData.openServerTime;
    CS.CSServerTime.CombineServerTime = tblData.combineServerTime;
    gameMgr:GetLuaTimeMgr():SetCombineServerTime(tblData.serverCurTime, tblData.combineServerTime)
    gameMgr:GetLuaTimeMgr():SetServerTime(tblData.serverCurTime, tblData.openServerTime * 1000)
    local loadName = ''

    CS.CSScene.MainPlayerLianFuState = tblData.shareOpen ~= nil and tblData.shareOpen == 1

    if CS.CSScene.MainPlayerLianFuState then
        loadName = 'showbg10'
    else
        if (CS.Cfg_DailyActivityTimeTableManager.IsLoadFinish) then
            gameMgr:GetLuaActivityMgr():InitDailyActivities()
            local loadName = gameMgr:GetLuaActivityMgr():GetLoadingTextureName()
            CS.CSCalendarInfoV2.LoadingTextureName = loadName;
        end
    end

    if (loadName ~= nil and loadName ~= "") then
        local res = CS.CSResourceManager.Instance:AddQueueCannotDelete(loadName, CS.ResourceType.UIEffect, nil, CS.ResourceAssistType.ForceLoad);
        CS.UILoading.resPreLoadPath = res.Path;
    end
end
--endregion

--region ID:1020 ResForceRoleReloadMessage 资源重载或强制下线
---@param msgID LuaEnumNetDef 消息ID
---@param tblData userV2.ForceRoleReload lua table类型消息数据
---@param csData userV2.ForceRoleReload C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[1020] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr == nil or gameMgr:GetPlayerDataMgr() == nil then
        return
    end
    if tblData.type == LuaEnumClientDataChange.ResourceChange then
        Utility.OpenVersionUpdateHint()
    end
    if tblData.type == LuaEnumClientDataChange.ForcedOffline then
        gameMgr:ReturnLoginScene()
    end
end
--endregion

--region ID:1022 ResInviteCodeVerifyMessage 邀请码验证应答
---@param msgID LuaEnumNetDef 消息ID
---@param tblData userV2.ResInviteCodeVerify lua table类型消息数据
---@param csData userV2.ResInviteCodeVerify C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[1022] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    ---验证成功，关闭验证码界面
    if (tblData ~= nil and tblData.result == 0) then
        if (uimanager:GetPanel('UIPromptInviteCodeInputPanel') ~= nil) then
            uimanager:ClosePanel('UIPromptInviteCodeInputPanel')
        end
    end
end
--endregion
