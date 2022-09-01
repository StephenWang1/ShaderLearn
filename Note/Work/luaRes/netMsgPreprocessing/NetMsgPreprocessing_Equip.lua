--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--equip.xml

--region ID:13001 ResAllEquipMessage 所有装备信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData equipV2.ResAllEquip lua table类型消息数据
---@param csData equipV2.ResAllEquip C# class类型消息数据
netMsgPreprocessing[13001] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    ---先同步C#里面的装备数据
    if CS.CSScene.MainPlayerInfo then
        CS.CSScene.MainPlayerInfo.EquipInfo:OnAllEquipMessageReceived(csData)
    end

    gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():OnAllEquipMessageReceived(tblData);
    gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():XianZhuangRedPointChange();

    CS.CSNetwork.SendClientEvent(CS.CEvent.V2_EquipUpdated);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.ROLE_EQUIP);
    gameMgr:GetPlayerDataMgr():GetZhenFaManager():OnResAllEquipMessage(tblData)
    gameMgr:GetPlayerDataMgr():GetShieldAndHatManager():SetEquipList(tblData.equipList)
    gameMgr:GetPlayerDataMgr():GetRecastMgr():RefreshRecastList(tblData.infos)
end
--endregion

--region ID:13003 ResEquipChangeMessage 装备信息更新
---@param msgID LuaEnumNetDef 消息ID
---@param tblData equipV2.ResEquipChange lua table类型消息数据
---@param csData equipV2.ResEquipChange C# class类型消息数据
netMsgPreprocessing[13003] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (CS.CSScene.MainPlayerInfo == nil) then
        return ;
    end
    CS.CSScene.MainPlayerInfo.EquipInfo:OnEquipChangeMessageReceived(csData)

    gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():OnEquipChangeMessageReceived(tblData);
    gameMgr:GetPlayerDataMgr():GetLuaStrengthInfo():CheckBodyEquipChange()
    gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr():RefreShRedData()
    gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitSmeltMgr():CallAllRedPoint()
    gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():XianZhuangRedPointChange();
    gameMgr:GetPlayerDataMgr():GetLuaForgeIdentifyMgr():SetRedPointShow(true)

    gameMgr:GetPlayerDataMgr():GetShieldAndHatManager():ChangeEquipList(tblData.equipChange)

    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_GEM);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_SOULBEAD);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_CHYANLAMP);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_THE_SOURCEOFATTACK);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_THE_SOURCEOFDEFENSE);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_ALL);
    --CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.Synthesis_HasSynthesis);
    --CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.Synthesis_HasRolePanelRedPoint);
    --region 替换的装备
    if csData ~= nil and csData.equipChange ~= nil and uimanager:GetPanel("UIRolePanel") ~= nil and (tblData.reason ~= LuaEnumEquipChangeReason.REFINER) then
        --print("reason"..tblData.reason);
        local bagItemInfoTable = {}
        local length = csData.equipChange.Count - 1
        for k = 0, length do
            table.insert(bagItemInfoTable, csData.equipChange[k].changeEquip)
            --if(csData.equipChange[k].changeEquip ~= nil) then
            --    print("替换的装备:  "..csData.equipChange[k].changeEquip.ItemFullName .. csData.equipChange[k].changeEquip.lid);
            --else
            --    print("替换的装备为空！！！！！！");
            --end
        end
        CS.CSScene.MainPlayerInfo.BagInfo:UpdateDemountEquipList(LuaEnumBagChangeAction.PUTON, bagItemInfoTable)
    end
    --endregion

    --region 装备音效处理
    if csData ~= nil and csData.equipChange ~= nil then
        for i = 0, csData.equipChange.Count - 1 do
            local itemchange = csData.equipChange[i].changeEquip
            if itemchange ~= nil then
                CS.Cfg_ItemSoundTableManager.Instance:PlayItemSound(itemchange.ItemTABLE, CS.ItemSoundType.Use)
            end
        end
    end
    --endregion

    --region 第一次穿戴面巾时,需要打开角色界面并提示面巾
    if uiStaticParameter.mIsFaceEquippedBefore == false then
        local isChecked = false
        if tblData and tblData.equipChange then
            for i = 1, #tblData.equipChange do
                local tblTemp = tblData.equipChange[i]
                if tblTemp and tblTemp.equipIndex == LuaEnumEquiptype.Face and tblTemp.changeEquip ~= nil then
                    ---面巾的服务器装备位与表格中的subtype一致
                    isChecked = true
                    break
                end
            end
        end
        if isChecked then
            ---@type UIRolePanel
            local rolePanel = uimanager:GetPanel("UIRolePanel")
            if rolePanel ~= nil then
                rolePanel:ShowFaceTips()
            else
                local customData = { type = LuaEnumLeftTagType.UIRolePanel }
                uimanager:CreatePanel("UIRolePanelTagPanel", nil, customData, function(panel)
                    if panel then
                        panel:ShowFaceTips()
                    end
                end)
            end
            --保存下面巾之前装备过的状态
            if CS.CSScene.MainPlayerInfo ~= nil then
                uiStaticParameter.mIsFaceEquippedBefore = true
                CS.CSScene.MainPlayerInfo.IConfigInfo:SetInt(LuaEnumLuaConfigID.IsFaceEquippedBefore, 1)
            end
        end

    end
    --endregion

    --region 第一次穿戴斗笠时,需要打开角色界面并提示斗笠
    if uiStaticParameter.mIsDouliEquippedBefore == false then
        local isChecked = false
        if tblData and tblData.equipChange then
            for i = 1, #tblData.equipChange do
                local tblTemp = tblData.equipChange[i]
                if tblTemp and tblTemp.equipIndex == LuaEnumEquiptype.DouLi and tblTemp.changeEquip ~= nil then
                    ---斗笠的服务器装备位与表格中的subtype一致
                    isChecked = true
                    break
                end
            end
        end
        if isChecked then
            ---@type UIRolePanel
            local rolePanel = uimanager:GetPanel("UIRolePanel")
            if rolePanel ~= nil then
                rolePanel:ShowDouLiTips()
            else
                local customData = { type = LuaEnumLeftTagType.UIRolePanel }
                uimanager:CreatePanel("UIRolePanelTagPanel", nil, customData, function(panel)
                    if panel then
                        panel:ShowDouLiTips()
                    end
                end)
            end
            --保存下面巾之前装备过的状态
            if CS.CSScene.MainPlayerInfo ~= nil then
                uiStaticParameter.mIsDouliEquippedBefore = true
                CS.CSScene.MainPlayerInfo.IConfigInfo:SetInt(LuaEnumLuaConfigID.IsDouliEquippedBefore, 1)
            end
        end

    end
    --endregion

    --region 第一次穿戴左手武器时,需要打开角色界面并提示左手武器
    if uiStaticParameter.mIsLeftWeaponEquippedBefore == false then
        local isChecked = false
        if tblData and tblData.equipChange then
            for i = 1, #tblData.equipChange do
                local tblTemp = tblData.equipChange[i]
                if tblTemp and tblTemp.equipIndex == LuaEnumEquiptype.LeftWeapon and tblTemp.changeEquip ~= nil then
                    ---左手武器的服务器装备位与表格中的subtype一致
                    isChecked = true
                    break
                end
            end
        end
        if isChecked then
            ---@type UIRolePanel
            local rolePanel = uimanager:GetPanel("UIRolePanel")
            if rolePanel ~= nil then
                rolePanel:ShowLeftWeaponTips()
            else
                local customData = { type = LuaEnumLeftTagType.UIRolePanel }
                uimanager:CreatePanel("UIRolePanelTagPanel", nil, customData, function(panel)
                    if panel then
                        panel:ShowLeftWeaponTips()
                    end
                end)
            end
            --保存下左手武器之前装备过的状态
            if CS.CSScene.MainPlayerInfo ~= nil then
                uiStaticParameter.mIsLeftWeaponEquippedBefore = true
                CS.CSScene.MainPlayerInfo.IConfigInfo:SetInt(LuaEnumLuaConfigID.IsLeftWeaponEquippedBefore, 1)
            end
        end

    end
    --endregion

    gameMgr:GetPlayerDataMgr():GetZhenFaManager():OnResEquipChangeMessage(tblData)
end
--endregion

--region ID:13011 ResRepairEquipMessage 返回修理装备
---@param msgID LuaEnumNetDef 消息ID
---@param tblData equipV2.ResRepairEquip lua table类型消息数据
---@param csData equipV2.ResRepairEquip C# class类型消息数据
netMsgPreprocessing[13011] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.EquipInfo:UpdateEquipLasting(csData.bodyEquips)
    CS.CSScene.MainPlayerInfo.BagInfo:UpdateEquipLasting(csData.bagEquips)

    gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():OnResRepairEquipMessage(tblData);

end
--endregion

--region ID:13012 ResSynItemUseCountMessage 同步物品的使用次数
---@param msgID LuaEnumNetDef 消息ID
---@param tblData equipV2.ItemUseCountInfo lua table类型消息数据
---@param csData equipV2.ItemUseCountInfo C# class类型消息数据
netMsgPreprocessing[13012] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.BagInfo:UpdateItemUseCount(csData)
end
--endregion

--region ID:13014 ResRepairServantEquipMessage 返回修理灵兽肉身装备
---@param msgID LuaEnumNetDef 消息ID
---@param tblData equipV2.ResRepairServantEquip lua table类型消息数据
---@param csData equipV2.ResRepairServantEquip C# class类型消息数据
netMsgPreprocessing[13014] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData.bagEquips then
        CS.CSScene.MainPlayerInfo.BagInfo:UpdateEquipLasting(csData.bagEquips)
    end
    if csData.bodyEquips then
        CS.CSScene.MainPlayerInfo.ServantInfoV2:UpdateEquipLasting(csData.bodyEquips)
        gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():OnResRepairEquipMessage(tblData)
    end

    gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():OnResRepairServantEquipMessage(tblData);
end
--endregion

--region ID:13018 ResEquipRefineMessage 装备炼制响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.BagItemInfo lua table类型消息数据
---@param csData bagV2.BagItemInfo C# class类型消息数据
netMsgPreprocessing[13018] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (not CS.CSScene.MainPlayerInfo.EquipInfo:TryUpdateEquip(csData)) then
        if (not CS.CSScene.MainPlayerInfo.ServantInfoV2:TryUpdateServantEquip(csData)) then
            CS.CSScene.MainPlayerInfo.BagInfo:UpdateSingleBagItemInfo(csData);
        end
    end

    local refinePanel = uimanager:GetPanel("UIRefinePanel");
    if (refinePanel ~= nil) then
        if (refinePanel:GetFirstChooseBagItemInfo() ~= nil and refinePanel:GetSecondChooseBagItemInfo() ~= nil) then
            uimanager:CreatePanel("UIRefineResultPanel", nil, { result = csData })
        elseif (refinePanel:GetFirstChooseBagItemInfo() == nil and refinePanel:GetSecondChooseBagItemInfo() == nil) then
            local isGetValue = false;
            local bagItemInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipInfo(csData.lid);
            local servantEquipInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantEquip(csData.lid);
            if (bagItemInfo ~= nil) then
                uiStaticParameter.mLastRefineResult = bagItemInfo;
            elseif (servantEquipInfo ~= nil) then
                uiStaticParameter.mLastRefineResult = servantEquipInfo;
            else
                isGetValue, bagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo.BagItems:TryGetValue(csData.lid);
                if (isGetValue) then
                    uiStaticParameter.mLastRefineResult = bagItemInfo;
                else
                    uiStaticParameter.mLastRefineResult = nil;
                end
            end

            refinePanel:AutoAddRefine();
        end
    end

    gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():OnResEquipRefineMessage(tblData);
end
--endregion

--region ID:13021 ResMagicWeaponInfoMessage 单个套装法宝信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData equipV2.MagicWeapon lua table类型消息数据
---@param csData equipV2.MagicWeapon C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[13021] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():RefreshSingleMagicEquip(tblData)
end
--endregion

--region ID:13022 ResAllMagicWeaponInfoMessage 全部法宝信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData equipV2.AllMagicWeaponInfo lua table类型消息数据
---@param csData equipV2.AllMagicWeaponInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[13022] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr().RefreshAllMagicEquipList ~= nil then
        gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():RefreshAllMagicEquipList(tblData)
    end
    if luaclass.MagicEquipPage ~= nil then
        luaclass.MagicEquipPage:RefreshServerPageState(tblData.typed)
    end
end
--endregion

--region ID:13023 ResUpdateGetedTypeMessage 玩家获得过的法宝类型
---@param msgID LuaEnumNetDef 消息ID
---@param tblData equipV2.UpdateGetedType lua table类型消息数据
---@param csData equipV2.UpdateGetedType C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[13023] = function(msgID, tblData, csData)
    luaclass.MagicEquipPage:RefreshServerPageState(tblData)
end
--endregion

--region ID:13027 ResAllSoulEquipInfoMessage 返回魂装镶嵌数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData equipV2.AllSoulEquipInfo lua table类型消息数据
---@param csData equipV2.AllSoulEquipInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[13027] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():UpdateSoulEquipSetInfo(tblData);
end
--endregion

--region ID:13030 ResRefinResultMessage 返回魂装洗炼结果
---@param msgID LuaEnumNetDef 消息ID
---@param tblData equipV2.ResRefinResult lua table类型消息数据
---@param csData equipV2.ResRefinResult C# class类型消息数据
netMsgPreprocessing[13030] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    local soulEquip = tblData.soulEquips
    if soulEquip then
        if soulEquip.index > 0 then
            gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetLuaSoulEquipData().mEquipIndexToSoulEquipDic[soulEquip.index]:UpdateVo(soulEquip)
        else
            if csData then
                local bagItemInfo = csData.soulEquips.itemInfo
                CS.CSScene.MainPlayerInfo.BagInfo:UpdateBagItemByLid(bagItemInfo.lid, bagItemInfo)
            end
        end
    end
    gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():RespondAgainRefine(tblData)
end
--endregion

--region ID:13031 ResWholeSoulEquipsMessage 全部魂装信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData equipV2.WholeSoulEquips lua table类型消息数据
---@param csData equipV2.WholeSoulEquips C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[13031] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():UpdateAllSoulEquip(tblData);
end
--endregion

--region ID:13033 ResAppraisaResultMessage 返回鉴定结果
---@param msgID LuaEnumNetDef 消息ID
---@param tblData equipV2.ResAppraisaResult lua table类型消息数据
---@param csData equipV2.ResAppraisaResult C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[13033] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    local csBagItem = protobufMgr.DecodeTable.bag.BagItemInfo(tblData.appraisaEquip)
    if tblData.appraisaEquip.index == 0 then
        if CS.CSScene.MainPlayerInfo then
            CS.CSScene.MainPlayerInfo.BagInfo:UpdateSingleBagItemInfo(csBagItem)
        end
        gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():RespondJianDing(tblData)
    end

    if CS.CSScene.MainPlayerInfo then
        CS.CSScene.MainPlayerInfo.EquipInfo:TryUpdateEquip(csBagItem)
    end
    gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():RefreshJianDingData(tblData);


end
--endregion

--region ID:13035 ResResAppraisaTipMessage 返回鉴定今日不在提示信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData equipV2.ResAppraisaTip lua table类型消息数据
---@param csData equipV2.ResAppraisaTip C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[13035] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetLuaForgeIdentifyMgr():GetToggleState(tblData.toDayTip)
end
--endregion

--region ID:13037 ResRecastMessage 配饰重铸
---@param msgID LuaEnumNetDef 消息ID
---@param tblData equipV2.ResRecast lua table类型消息数据
---@param csData equipV2.ResRecast C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[13037] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr == nil or gameMgr:GetPlayerDataMgr() == nil then
        return
    end
    gameMgr:GetPlayerDataMgr():GetRecastMgr():RefreshRecast(tblData)
end
--endregion

--[[
--region ID:13009 ResChangeAppearanceMessage 返回改变成装备的样子
---@param msgID LuaEnumNetDef 消息ID
---@param tblData equipV2.ResChangeAppearance lua table类型消息数据
---@param csData equipV2.ResChangeAppearance C# class类型消息数据
netMsgPreprocessing[13009] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
--]]
