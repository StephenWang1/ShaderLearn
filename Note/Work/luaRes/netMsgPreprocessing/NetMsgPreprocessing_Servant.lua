--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--servant.xml

--region ID:103001 ResServantInfoMessage 返回仆从信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData servantV2.ResServantInfo lua table类型消息数据
---@param csData servantV2.ResServantInfo C# class类型消息数据
netMsgPreprocessing[103001] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo == nil then
        return
    end
    if csData.expPoolSpecified then
        mainPlayerInfo.ServantInfoV2.ResServantInfo.expPool = csData.expPool
    end
    if (csData.reinPoolSpecified) then
        mainPlayerInfo.ServantInfoV2.ResServantInfo.reinPool = csData.reinPool
    end
    mainPlayerInfo.ServantInfoV2.ServantInfoList = csData.serverts
    gameMgr:GetPlayerDataMgr():GetLuaServantInfo():SetLuaServantInfo(tblData)
    if (mainPlayerInfo.ServantInfoV2.OldServantInfoList.Count < csData.serverts.Count) then
        mainPlayerInfo.ServantInfoV2.OldServantInfoList = csData.serverts
    end
    mainPlayerInfo.ServantInfoV2:UpdateServants_NEW(csData)
    mainPlayerInfo.ServantInfoV2:UpdateServants(csData.serverts)
    gameMgr:GetPlayerDataMgr():GetLuaStrengthInfo():CheckServantEquipChange()
    gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():OnResServantInfoReceived(tblData)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_SECOND_PUSH)
    ---灵兽合体初始化
    if uiStaticParameter.mInitCombitServant then
        uiStaticParameter.mInitCombitServant = false
        mainPlayerInfo:OperaCombitServantList(csData.serverts)
    end
    --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_GatherSoul)
    --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_GatherSoul1)
    --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_GatherSoul2)
    --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_GatherSoul3)
    --Utility.CallServantPracticeRedPoint()
    luaEventManager.DoCallback(LuaCEvent.AnimalBossHurtBuffRefresh)
end
--endregion

--region ID:103008 ResServantExpUpdateMessage 元灵经验更新
---@param msgID LuaEnumNetDef 消息ID
---@param tblData servantV2.ServantExpUpdate lua table类型消息数据
---@param csData servantV2.ServantExpUpdate C# class类型消息数据
netMsgPreprocessing[103008] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData and CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.ServantInfoV2.AddExpPool = csData.pool - CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.expPool
        local serventList = CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList
        if serventList ~= nil or serventList.Count ~= 0 then
            for i = 0, serventList.Count - 1 do
                if serventList[i] ~= nil then
                    if serventList[i].type == csData.type then
                        local luasingleservantinfo = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetLuaSingleServantInfo(tblData.type)
                        if (luasingleservantinfo ~= nil) then
                            luasingleservantinfo.exp = tblData.exp
                            luasingleservantinfo.level = tblData.level
                        end
                        serventList[i].exp = csData.exp
                        serventList[i].level = csData.level
                    end
                end
            end
        end
        local previousPoolExp = CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.expPool
        CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.expPool = csData.pool
        if csData.actId == 4001 then
            ---通过宝箱的方式增加的灵兽经验提示一下
            local offset = csData.pool - previousPoolExp
            if offset > 0 then
                ---@type UIAllTextTipsContainerPanel
                local uiAllTextTipsContainerPanel = uimanager:GetPanel("UIAllTextTipsContainerPanel")
                if uiAllTextTipsContainerPanel then
                    uiAllTextTipsContainerPanel.SendMiddleTopTips("[fffab3]获得了[-]", 1000021, '灵兽经验' .. tostring(offset))
                else
                    uimanager:CreatePanel("UIAllTextTipsContainerPanel", function()
                        uiAllTextTipsContainerPanel.SendMiddleTopTips("[fffab3]获得了[-]", 1000021, '灵兽经验' .. tostring(offset))
                    end)
                end
            end
        end
    end
    --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_LEVEL)
    --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_LEVEL_FIRST)
    --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_LEVEL_SECOND)
    --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_LEVEL_THIRD)
end
--endregion

--region ID:103009 ResServantHpUpdateMessage 元灵血量更新
---@param msgID LuaEnumNetDef 消息ID
---@param tblData servantV2.ServantHpUpdate lua table类型消息数据
---@param csData servantV2.ServantHpUpdate C# class类型消息数据
netMsgPreprocessing[103009] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData and CS.CSScene.MainPlayerInfo ~= nil then
        local serventList = CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList
        if serventList ~= nil or serventList.Count ~= 0 then
            for i = 0, serventList.Count - 1 do
                local info = serventList[i]
                if info ~= nil then
                    if info.type == csData.type then
                        local luasingleservantinfo = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetLuaSingleServantInfo(tblData.type)
                        if (luasingleservantinfo ~= nil) then
                            luasingleservantinfo.combineHp = tblData.combineHp
                            luasingleservantinfo.combineMaxHp = tblData.combineMaxHp
                            if (luasingleservantinfo.attributes ~= nil and Utility.GetLuaTableCount(luasingleservantinfo.attributes) > 0) then
                                local listCount = Utility.GetLuaTableCount(luasingleservantinfo.attributes)
                                for j = 1, listCount do
                                    local v = luasingleservantinfo.attributes[j];
                                    local type = v.type
                                    if (type == LuaEnumAttributeType.MaxHp) then
                                        v.value = tblData.maxHp
                                    end
                                end
                            end
                        end
                        info.combineHp = csData.combineHp
                        info.combineMaxHp = csData.combineMaxHp
                        if (info.attributes ~= nil and info.attributes.Count > 0) then
                            local listCount = info.attributes.Count - 1
                            for j = 0, listCount do
                                local v = info.attributes[j];
                                local type = v.type
                                if (type == LuaEnumAttributeType.MaxHp) then
                                    v.value = csData.maxHp
                                end
                            end
                        end
                    end
                end
            end
        end
        CS.CSScene.MainPlayerInfo:OperaMainCombitServantInfo(csData)
    end
end
--endregion

--region ID:103011 ResNameMessage 返回元灵名字
---@param msgID LuaEnumNetDef 消息ID
---@param tblData servantV2.ResServantName lua table类型消息数据
---@param csData servantV2.ResServantName C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[103011] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:103012 ResServantLevelUpMessage 灵兽升级包
---@param msgID LuaEnumNetDef 消息ID
---@param tblData servantV2.ResServantLevelUp lua table类型消息数据
---@param csData servantV2.ResServantLevelUp C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[103012] = function(msgID, tblData, csData)
    --在此处填入预处理代码

    local servant = CS.CSSceneExt.Sington:getAvatar(tblData.lid);
    if (servant == nil) then
        return ;
    end

    --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_LEVEL)
    --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_EQUIP)
    --if(tblData.type == 1) then
        --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_LEVEL_FIRST)
        --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_EQUIP_FIRST);
    --elseif(tblData.type == 2)then
        --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_LEVEL_SECOND)
        --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_EQUIP_SECOND);
    --elseif(tblData.type == 3)then
        --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_LEVEL_THIRD)
        --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_EQUIP_THIRD);
    --end
    --创建灵兽升级特效
    local r = CS.CSResourceManager.Singleton:AddQueue("upgrade", CS.ResourceType.Effect, function(res)
        if (res == nil or CS.CSScene.IsLanuchMainPlayer == false or servant.CacheTransform == nil or servant.Model == nil or servant.Model.Effect == nil) then
            return ;
        end

        local effect = servant.Model.Effect.GoTrans;
        if (effect == nil) then
            return ;
        end

        local RoleUpdatePoolItem = res:GetPoolItem(CS.EPoolType.Normal, 0, 2);
        if (RoleUpdatePoolItem == nil or RoleUpdatePoolItem.go == nil) then
            return ;
        end
        local obj = RoleUpdatePoolItem.go
        obj.transform.parent = effect;
        obj.transform.localPosition = CS.UnityEngine.Vector3(0, 0, -5);
        obj.transform.localScale = CS.UnityEngine.Vector3.one;
        obj:SetActive(true);
    end, CS.ResourceAssistType.UI);
    r.IsCanBeDelete = false;
end
--endregion

--region ID:103013 ResServantReinUpMessage 灵兽转生包
---@param msgID LuaEnumNetDef 消息ID
---@param tblData servantV2.ResServantReinUp lua table类型消息数据
---@param csData servantV2.ResServantReinUp C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[103013] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_EQUIP)
    --if(tblData.type == 1) then
    --    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_EQUIP_FIRST);
    --elseif(tblData.type == 2)then
    --    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_EQUIP_SECOND);
    --elseif(tblData.type == 3)then
    --    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_EQUIP_THIRD);
    --end
end
--endregion

--region ID:103014 ResUseServantEggMessage 返回使用灵兽蛋
---@param msgID LuaEnumNetDef 消息ID
---@param tblData servantV2.ResServantName lua table类型消息数据
---@param csData servantV2.ResServantName C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[103014] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:103016 ResOtherServantInfoMessage 返回他人灵兽信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData servantV2.ResOtherServantInfo lua table类型消息数据
---@param csData servantV2.ResOtherServantInfo C# class类型消息数据
netMsgPreprocessing[103016] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (csData) then
        CS.CSScene.MainPlayerInfo.ServantInfoV2:UpdateOtherServants_NEW(csData)
        CS.CSScene.MainPlayerInfo.ServantInfoV2:UpdateOhterServants(csData.infos)
        CS.CSScene.MainPlayerInfo.OtherPlayerInfo:RefreshOtherServantsMsg(csData)
        gameMgr:GetOtherPlayerDataMgr():RefreshOtherPlayerServantList(tblData)
    end
end
--endregion

--region ID:103017 ResServantStateChangeMessage 灵兽出战, 合体属性变化飘字
---@param msgID LuaEnumNetDef 消息ID
---@param tblData servantV2.ResServantStateChange lua table类型消息数据
---@param csData servantV2.ResServantStateChange C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[103017] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:103018 ResSingleServantInfoMessage 返回单个灵兽信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData servantV2.ServantInfo lua table类型消息数据
---@param csData servantV2.ServantInfo C# class类型消息数据
netMsgPreprocessing[103018] = function(msgID, tblData, csData)
    --增加或者移除灵兽战斗连击监听器
    Utility.CombatHit_SingleServantInfoChange(tblData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count > csData.type - 1 then
        gameMgr:GetPlayerDataMgr():GetLuaServantInfo():SetLuaSingleServantInfo(tblData.type, tblData)
        CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList[csData.type - 1] = csData
        CS.CSScene.MainPlayerInfo.ServantInfoV2.OldServantInfoList[csData.type - 1] = csData
        CS.CSScene.MainPlayerInfo.ServantInfoV2:UpdateServants_NEW(csData)
        CS.CSScene.MainPlayerInfo.ServantInfoV2:UpdateSingleServant(csData)
        CS.CSScene.MainPlayerInfo.ServantInfoV2:UpdateLiveServantList()
        CS.CSScene.MainPlayerInfo:OperaCombitServantInfo(csData)
        CS.CSNetwork.SendClientEvent(CS.CEvent.V2_ResServantInfo, csData.type);

        if(tblData ~= nil) then
            gameMgr:GetPlayerDataMgr():GetSynthesisMgr():CallAllRedPoint(nil, tblData.itemId)
            --灵兽法宝为自动穿戴，额外刷新法宝装备合成列表
            local servantMagicEquip = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():GetEquip(tblData.type,LuaEnumServantEquipIndexType.MagicEquip)
            if servantMagicEquip ~= nil then
                gameMgr:GetPlayerDataMgr():GetSynthesisMgr():CallAllRedPoint(nil, servantMagicEquip.itemId)
            end
        end
    end
    luaEventManager.DoCallback(LuaCEvent.AnimalBossHurtBuffRefresh)
    gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():OnResSingleServantInfoExMessageReceived(tblData)
end
--endregion

--region ID:103020 ResSingleServantInfoExMessage 返回单个灵兽信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData servantV2.ServantInfo lua table类型消息数据
---@param csData servantV2.ServantInfo C# class类型消息数据
netMsgPreprocessing[103020] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    local typeTemp = tblData.type
    if (csData.servantId ~= 0) then
        local changeList = CS.CSScene.MainPlayerInfo.ServantInfoV2:ServantChangeAttribute(typeTemp, csData.attributes);
        luaEventManager.DoCallback(LuaCEvent.Servant_AttributeChange, changeList);
    end
    gameMgr:GetPlayerDataMgr():GetLuaServantInfo():SetLuaSingleServantInfo(typeTemp, tblData)
    CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList[typeTemp - 1] = csData
    CS.CSScene.MainPlayerInfo.ServantInfoV2.OldServantInfoList[typeTemp - 1] = csData
    CS.CSScene.MainPlayerInfo.ServantInfoV2:UpdateServants_NEW(csData)
    CS.CSScene.MainPlayerInfo.ServantInfoV2:UpdateSingleServant(csData)
    CS.CSScene.MainPlayerInfo.ServantInfoV2:UpdateLiveServantList()
    CS.CSScene.MainPlayerInfo:OperaCombitServantInfo(csData)

    CS.CSNetwork.SendClientEvent(CS.CEvent.V2_ResServantInfo, typeTemp);

    local redPointMgr = CS.CSUIRedPointManager.GetInstance()
    redPointMgr:CallRedPoint(CS.RedPointKey.SERVANT_EGG);
    --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_GatherSoul)
    if (typeTemp == 1) then
        redPointMgr:CallRedPoint(CS.RedPointKey.SERVANT_EGG_FIRST);
        --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_GatherSoul1)
    elseif (typeTemp == 2) then
        redPointMgr:CallRedPoint(CS.RedPointKey.SERVANT_EGG_SECOND);
        --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_GatherSoul2)
    elseif (typeTemp == 3) then
        redPointMgr:CallRedPoint(CS.RedPointKey.SERVANT_EGG_THIRD);
        --CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_GatherSoul3)
    end

    --Utility.CallServantPracticeRedPoint()

    gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():OnResSingleServantInfoExMessageReceived(tblData)
end
--endregion

--region ID:103022 ResRemindOpenServantSiteMessage 提醒开启灵兽位
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[103022] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:103023 ResLoginMapServantHetTiMessage 登陆地图灵兽合体
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[103023] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    local Info = CS.CSSceneExt.MainPlayerInfo;
    if (Info ~= nil) then
        --Info.ServantInfoV2:ConstraintServantCombine();
        ---由服务器发起的灵兽自动合体,客户端不需要再发送合体消息,但是合体状态需要改成自动合体状态
        Info.ServantInfoV2.CombineWay = CS.AllCombineWay.Automatic;
    end
end
--endregion

--region ID:103026 ResOpneServantManaMessage 打开灵兽聚灵面板
---@param msgID LuaEnumNetDef 消息ID
---@param tblData servantV2.ServantMana lua table类型消息数据
---@param csData servantV2.ServantMana C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[103026] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetLuaServantInfo():SetGatherSoulData(tblData)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_GatherSoul)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_GatherSoul1)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_GatherSoul2)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_GatherSoul3)
end
--endregion
