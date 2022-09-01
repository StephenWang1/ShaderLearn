--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--bag.xml

--region ID:10004 ReqUseItemMessage 请求使用道具
---@param msgID LuaEnumNetDef 消息ID
---@param csData bagV2.UseItemRequest lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[10004] = function(msgID, csData)
    --在此处填入预校验代码
    if (CS.CSScene.MainPlayerInfo == nil) then
        return
    end
    local res2, bagItemExit = CS.CSScene.MainPlayerInfo.BagInfo.BagItems:TryGetValue(csData.itemId)
    if res2 then
        local res, itemExit = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemExit.itemId)
        if res then
            --使用幻兽蛋类型
            --[[            if (itemExit.type == luaEnumItemType.Assist and itemExit.subType == 8) then
                local res1, typeInfo = CS.Cfg_ServantTableManager.Instance.dic:TryGetValue(itemExit.useParam.list[0])
                if res1 then
                    if (csData.clientParam ~= 0) then
                        networkRequest.ReqUseServantEgg(csData.itemId, csData.clientParam)
                    else
                        if (typeInfo.type == 4) then
                            local pos = 0
                            local servantPanel = uimanager:GetPanel("UIServantPanel")
                            if servantPanel ~= nil then
                                ---优先选择空灵兽位，其次选择当前选中的灵兽位
                                pos = uiStaticParameter.SelectedServantType
                                if (servantPanel:GetSelectHeadInfo().info.servantId ~= 0) then
                                    pos = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetEmptyServantPos()
                                    if pos == 0 then
                                        pos = uiStaticParameter.SelectedServantType
                                    end
                                end
                            else
                                pos = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetBodyLowServantIndex()
                            end
                            if (pos ~= 0) then
                                networkRequest.ReqUseServantEgg(csData.itemId, pos)
                            end
                        else
                            networkRequest.ReqUseServantEgg(csData.itemId, typeInfo.type)
                        end
                    end
                end
                return false
            end]]
            if itemExit.type == luaEnumItemType.Appearance then
                --使用外观道具时,若下一次启用的外观列表有变化,则打开外观界面并选中相应的页签(3s之内)
                uiStaticParameter.UseItemAndOpenAppearancePanelMaxTime = CS.UnityEngine.Time.time + 3
                uiStaticParameter.UseItemAndOpenAppearancePanelItemID = bagItemExit.itemId
            end
            if bagItemExit.itemId == LuaEnumSpecialPropItemID.RandomStone then
                ---随机石使用时,若为非自动寻路的状态,则记录并后续中继寻路
                if CS.CSPathFinderManager.Instance ~= nil and CS.CSPathFinderManager.Instance.IsPathFinding == false and CS.CSScene.Sington ~= nil and CS.CSScene.Sington.MainPlayer ~= nil and CS.CSScene.Sington.MainPlayer.Moveing then
                    ---仅在非自动寻路时生效
                    --清空传送后寻路
                    CS.CSScene.Sington.SetPathFindAfterDeliver:Clear()
                    --当自动寻路关闭,当前攻击目标为空且正在进行地图寻路时,使用随机石后继续该寻路
                    local cachedCoord = CS.CSScene.Sington.MainPlayer.TouchEvent.Coord
                    --当前目标为空或者为自己时,才记录随机传送目标
                    local touchEventType = CS.CSScene.Sington.MainPlayer.TouchEvent.Type
                    local isPickupingSomething = CS.CSAutoFightMgr.Instance.AutoPickUp:IsPickingSomething()
                    --print("touchEventType", touchEventType)
                    --print("isPickupingSomething", isPickupingSomething)
                    if touchEventType ~= CS.ETouchType.Attack and touchEventType ~= CS.ETouchType.AttackTerrain
                            and touchEventType ~= CS.ETouchType.Gather and isPickupingSomething == false then
                        --print("SetPathFindTargetAfterDeliver")
                        CS.CSScene.Sington.SetPathFindAfterDeliver:SetPathFindTargetAfterDeliver(cachedCoord, 5, Utility.EnumToInt(CS.NewEventProcess.PositionChangeReason.RandomStone))
                        --end
                    end
                    ---如果正在前往采集,则停止采集操作
                    if CS.CSScene.MainPlayerInfo.AsyncOperationController.CurrentAsyncOperation ~= nil and CS.CSScene.MainPlayerInfo.AsyncOperationController.CurrentAsyncOperation.OperationType == CS.MainPlayerAsyncOperation.EMainPlayerAsyncOperationType.GoForGather then
                        --print("CS.CSScene.MainPlayerInfo.AsyncOperationController.CurrentAsyncOperation:Stop(true)")
                        CS.CSScene.MainPlayerInfo.AsyncOperationController:Stop()
                    end
                end
            end

            --使用行会召唤令
            if (itemExit.type == luaEnumItemType.Assist and itemExit.subType == 6) then
                if uiStaticParameter.UnionTokenCoroutine ~= nil then
                    StopCoroutine(uiStaticParameter.UnionTokenCoroutine)
                    uiStaticParameter.UnionTokenCoroutine = nil
                end
                local hasGroup = CS.CSScene.MainPlayerInfo.GroupInfoV2.IsHaveGroup;
                local isCaptain = CS.CSScene.MainPlayerInfo.GroupInfoV2.IsCaptain
                if (CS.CSScene.MainPlayerInfo.GroupInfoV2.GroupInfo ~= nil) then
                    local type = CS.CSScene.MainPlayerInfo.GroupInfoV2.GroupInfo.captainAllowMode;
                    if (type == LuaEnumTeamReqType.UnionAutoJoin) then
                        return true;
                    end
                end

                if (hasGroup and isCaptain) then
                    if (uiStaticParameter.isJustUseGuildCallOrder) then
                        uiStaticParameter.isJustUseGuildCallOrder = false;
                        return true;
                    else
                        if uiStaticParameter.UnionTokenCoroutine == nil then
                            uiStaticParameter.UnionTokenCoroutine = StartCoroutine(function()
                                coroutine.yield(0)
                                local customData = {};
                                customData.id = 112;
                                customData.Callback = function()
                                    uiStaticParameter.isJustUseGuildCallOrder = true;
                                    networkRequest.ReqUseItem(csData.count, csData.itemId, csData.clientParam, csData.clientParams);
                                    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                                        networkRequest.ReqShareCommon(luaEnumReqServerCommonType.GROUP_CAPTION_SET_ALLOW_MODE, LuaEnumTeamReqType.UnionAutoJoin);
                                    else
                                        networkRequest.ReqCommon(luaEnumReqServerCommonType.GROUP_CAPTION_SET_ALLOW_MODE, LuaEnumTeamReqType.UnionAutoJoin);
                                    end
                                end
                                Utility.ShowPromptTipsPanel(customData);
                            end)
                        end
                        return false;
                    end
                end
            end

            --如果是使用经验丹,需要判定下是否需要打开经验丹界面,如果需要打开经验丹界面,则认为阻塞本次使用道具
            if itemExit.type == luaEnumItemType.Drug and itemExit.subType == 4 then
                if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetMainPlayerExpPropUsing() ~= nil
                        and gameMgr:GetPlayerDataMgr():GetMainPlayerExpPropUsing():IsNeedOpenExpItemPanel(csData) then
                    uimanager:CreatePanel("UIExpItemPanel", nil, csData.itemId)
                    return false
                end
            end

            ---DeliverID
            if (itemExit.type == luaEnumItemType.Assist and itemExit.subType == 50) then
                local develiverID = 0
                if (itemExit.useParam ~= nil and itemExit.useParam.list ~= nil and itemExit.useParam.list.Count > 0) then
                    develiverID = itemExit.useParam.list[0];
                    ---获取传送条件
                    local transferResult = Utility.TryTransfer(develiverID)
                    ---小飞鞋不足
                    if (transferResult ~= nil and transferResult.resultType == CS.Enum_TransferResult.ConsumablesNotEnough) then
                        return false
                    end
                    ---尝试传送
                    uimanager:ClosePanel("UIBagPanel")
                    networkRequest.ReqDeliverByConfig(develiverID)
                    return false
                end
            end
        end
    end

    return true
end
--endregion

--region ID:10057 ReqEvolveMessage 装备进化请求
---@param msgID LuaEnumNetDef 消息ID
---@param csData bagV2.ReqEvolve lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[10057] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:10086 ReqDivineSmeltMessage 请求熔炼神力装备
---@param msgID LuaEnumNetDef 消息ID
---@param csData bagV2.ReqDivineSmelt lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[10086] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
