--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--bag.xml

--region ID:10002 ResBagInfoMessage 返回请求背包
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResBagInfo lua table类型消息数据
---@param csData bagV2.ResBagInfo C# class类型消息数据
netMsgPreprocessing[10002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():InitializeBagData(tblData)
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.BagInfo:InitializeBagInfo(csData)
    end
    luaclass.BagBetterMagicEquip:RefreshBagBetterMagicEquip()
    --region Lua推送
    gameMgr:GetPlayerDataMgr():GetMainPlayerBetterItemHintDataMgr():TryAddHintPackage(tblData, LuaEnumHintPackageSource.BagInfoMessage)
    --endregion
    --region 宝物
    gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():RefreshAllGem(tblData.extraEquip)
    --endregion
    --region 淬炼
    gameMgr:GetPlayerDataMgr():GetForgeQuenchDataMgr():RefreshForgeQuenchData()
    --endregion
end
--endregion

--region ID:10003 ResBagChangeMessage 背包发生变化
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResBagChange lua table类型消息数据
---@param csData bagV2.ResBagChange C# class类型消息数据
netMsgPreprocessing[10003] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    local CSBagInfo = CS.CSScene.MainPlayerInfo.BagInfo
    local CSServantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2
    local CSPlayerVipInfo = gameMgr:GetPlayerDataMgr():GetLuaMemberInfo():GetPlayerMemberLevel()


    -----这里先手动将移除的物品信息获取到,后续可以直接让服务器加上去
    --local RemovedIdList = tblData.removedIdList
    --if (RemovedIdList ~= nil and #RemovedIdList > 0) then
    --    local removeItems = CSBagInfo:GetItemIDs(csData.removedIdList)
    --    if(removeItems ~= nil) then
    --        tblData.removedItems = {}
    --        for i = 0, removeItems.Count - 1 do
    --            table.insert(tblData.removedItems, removeItems[i])
    --        end
    --    end
    --end
    -----endregion

    --region 元宝宝箱使用弹窗
    if tblData.action == LuaEnumBagChangeAction.MONEY_BOX_USE then
        local isYuanBaoChanged = false
        local newYuanBaoAmount = 0
        if tblData.coinList ~= nil and #tblData.coinList then
            for i = 1, #tblData.coinList do
                if tblData.coinList[i].itemId == 1000002 then
                    isYuanBaoChanged = true
                    newYuanBaoAmount = tblData.coinList[i].count
                    break
                end
            end
        end
        if isYuanBaoChanged then
            local oldYuanBao = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(1000002)
            if oldYuanBao < newYuanBaoAmount then
                local offset = newYuanBaoAmount - oldYuanBao
                ---@type UIAllTextTipsContainerPanel
                local uiAllTextTipsContainerPanel = uimanager:GetPanel("UIAllTextTipsContainerPanel")
                if uiAllTextTipsContainerPanel then
                    uiAllTextTipsContainerPanel.SendMiddleTopTips("[fffab3]获得了[-]", 1000002, '元宝' .. tostring(offset))
                else
                    uimanager:CreatePanel("UIAllTextTipsContainerPanel", function()
                        uiAllTextTipsContainerPanel.SendMiddleTopTips("[fffab3]获得了[-]", 1000002, '元宝' .. tostring(offset))
                    end)
                end
            end
        end
    end
    --endregion

    --region 新物品
    if tblData ~= nil and tblData.itemList ~= nil and #tblData.itemList > 0 and CSBagInfo:CheckNewItemOrigin(tblData.action) then
        if uimanager:GetPanel("UIBagPanel") ~= nil then
            CSBagInfo:UpdateNewItemInfo(csData.itemList)
        end
    end

    if tblData ~= nil and tblData.removedIdList ~= nil and #tblData.removedIdList > 0 then
        CSBagInfo:UpdateRemoveNewItemInfo(csData.removedIdList)
    end
    --endregion

    --region 替换的装备
    if tblData ~= nil and tblData.itemList ~= nil and #tblData.itemList > 0 and uimanager:GetPanel("UIBagPanel") ~= nil then
        if tblData.action == LuaEnumBagChangeAction.PUTOFF or tblData.action == LuaEnumBagChangeAction.PUTOFF_ChangeEquip then
            CSBagInfo:UpdateDemountEquipList(tblData.action, csData.itemList)
        end
    end
    --endregion

    --region 修改物品列表物品顺序(主要用于物品推送物品列表第一个物品)
    if csData ~= nil and csData.itemList ~= nil and csData.itemList.Count > 1 then
        local length = csData.itemList.Count - 1
        for k = 0, length do
            local bagItemInfo = csData.itemList[k]
            if bagItemInfo ~= nil and (bagItemInfo.itemId == 5000305) then
                local firstBagItemInfo = bagItemInfo
                csData.itemList[k] = csData.itemList[0]
                csData.itemList[0] = firstBagItemInfo
                break
            end
        end
    end
    --endregion

    ---刷新背包数据
    gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():RespondBagChange(tblData)
    ---背包变动可能会引动装备或者说锻造的红点变动,这些主要依附于装备的由装备管理类去处理
    gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():RespondBagChange(tblData)

    CSBagInfo:UpdateBagInfo(csData)

    --region 功勋变化导致官阶是否可以升级变化
    ---等级变化时触发一次合成官阶计算
    gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.OfficialState)
    --endregion

    --region 提示更好物品（只刷新对应类型的物品）
    local condition = tblData.action
    if tblData ~= nil and tblData.itemList ~= nil and #tblData.itemList > 0 and CS.Cfg_GlobalTableManager.Instance:IsItemHint_BagItemChangeAction(condition) then
        CSBagInfo.BagItemHint:TryRefreshBetterHintByList(csData.itemList)
    end
    --endregion

    --region 提示更好物品（移除）
    if tblData ~= nil and tblData.removeItemList ~= nil and #tblData.removeItemList > 0 then
        CSBagInfo.BagItemHint:RemoveHintItemByBagItemInfoList(csData.removeItemList)
    end
    --endregion

    --region Lua推送
    gameMgr:GetPlayerDataMgr():GetMainPlayerBetterItemHintDataMgr():TryAddHintPackage(tblData, LuaEnumHintPackageSource.BagChangeMessage)
    --endregion

    local uiredPointMgr = CS.CSUIRedPointManager.GetInstance()
    uiredPointMgr:CallRedPoint(CS.RedPointKey.SKILL_ALL);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.FURNACE_ALL);
    --uiredPointMgr:CallRedPoint(CS.RedPointKey.PLAYER_TurnGrow);
    ---背包红点
    uiredPointMgr:CallRedPoint(CS.RedPointKey.BAG_FULL);
    ---灵兽红点计算
    uiredPointMgr:CallRedPoint(CS.RedPointKey.SERVANT_EGG);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.SERVANT_EGG_FIRST);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.SERVANT_EGG_SECOND);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.SERVANT_EGG_THIRD);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.SERVANT_REIN);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.SERVANT_REIN_FIRST);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.SERVANT_REIN_SECOND);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.SERVANT_REIN_THIRD);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.SERVANT_EQUIP);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.SERVANT_EQUIP_FIRST);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.SERVANT_EQUIP_SECOND);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.SERVANT_EQUIP_THIRD);

    uiredPointMgr:CallRedPoint(CS.RedPointKey.Signet);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Signet_weap);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Signet_clothes);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Signet_BraceletL);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Signet_ringL);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Signet_belt);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Signet_shoe);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Signet_ringR);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Signet_BraceletR);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Signet_Necklace);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Signet_Helmet);

    uiredPointMgr:CallRedPoint(CS.RedPointKey.Element);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Element_weap);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Element_clothes);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Element_BraceletL);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Element_ringL);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Element_belt);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Element_shoe);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Element_ringR);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Element_BraceletR);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Element_Necklace);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Element_Helmet);

    --uiredPointMgr:CallRedPoint(CS.RedPointKey.Treasure_TaLuoPai);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.SERVANT_HUNJI_FIRST);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.SERVANT_HUNJI_SECOND);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.SERVANT_HUNJI_THIRD);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Activity_Competition);
    --uiredPointMgr:CallRedPoint(CS.RedPointKey.Synthesis_HasSynthesis);
    --uiredPointMgr:CallRedPoint(CS.RedPointKey.Synthesis_HasRolePanelRedPoint);
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Synthesis_HasServantPanelRedPoint)
    uiredPointMgr:CallRedPoint(CS.RedPointKey.Recharge_ContinueReward)
    uiredPointMgr:CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_HM))
    uiredPointMgr:CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_LX))
    uiredPointMgr:CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_TC))
    uiredPointMgr:CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_EquipElement));
    uiredPointMgr:CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Collection))
    uiredPointMgr:CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.JianDingRedPoint))

    --gameMgr:GetPlayerDataMgr():GetSynthesisInfo():CallAllRedPoint(tblData);
    ---@type LuaSynthesisMgr 合成相关数据
    local LuaSynthesisMgr = gameMgr:GetPlayerDataMgr():GetSynthesisMgr()
    LuaSynthesisMgr:SynthesisConditionUpdate(tblData)
    gameMgr:GetPlayerDataMgr():GetEquipProficientMgr():CallRed()

    --endregion

    --region 自动设置药品
    CSBagInfo:CheckSetDrug(csData.itemList)
    CSBagInfo:CheckChangeDrug()
    --endregion

    --region 播放拾取音效
    if csData ~= nil and csData.action == 31005 then
        if csData.coinList ~= nil then
            for i = 0, csData.coinList.Count - 1 do
                if csData.coinList[i] ~= nil then
                    CS.Cfg_ItemSoundTableManager.Instance:PlayItemSound(csData.coinList[i].itemId, CS.ItemSoundType.Gain)
                end
            end
        end
        if csData.itemList ~= nil then
            for i = 0, csData.itemList.Count - 1 do
                if csData.itemList[i] ~= nil then
                    CS.Cfg_ItemSoundTableManager.Instance:PlayItemSound(csData.itemList[i].ItemTABLE, CS.ItemSoundType.Gain)
                end
            end
        end
    end
    --endregion
    local isZhaoHuanLingLimitLevel = 0
    if CS.CSScene.MainPlayerInfo ~= nil then
        isZhaoHuanLingLimitLevel = CS.CSScene.MainPlayerInfo.Level >= LuaGlobalTableDeal.ZhaoHuanLingLimitLevel()
    end
    for i = 0, csData.itemList.Count - 1 do
        local itemid = LuaGlobalTableDeal.ZhaoHuanLingItemID()
        ---召唤令快捷栏刷新
        if isZhaoHuanLingLimitLevel == true then
            if csData.itemList[i] ~= nil and csData.itemList[i].itemId == LuaGlobalTableDeal.ZhaoHuanLingItemID() then
                Utility.PlaceCallToMake(false)
            end
        end
        ---圣域相关道具发生变化
        if csData.itemList[i] ~= nil and csData.itemList[i].itemId == CS.Cfg_GlobalTableManager.Instance.ShengYuItemID then
            luaEventManager.DoCallback(LuaCEvent.Task_ShengYu);
        end
        ---烟花道具发生变化
        if csData.itemList[i] ~= nil and csData.itemList[i].itemId == CS.Cfg_GlobalTableManager.Instance.YanHuaItemID then
            luaEventManager.DoCallback(LuaCEvent.Task_YanHua);
        end
    end

    ---刷新召唤令状态


    ---刷新灵兽池
    --for i = 0, csData.coinList.Count - 1 do
    --    --灵兽灵力
    --    if csData.coinList[i] ~= nil and csData.coinList[i].itemId == 1000020 then
    --        CSServantInfo.ResServantInfo.reinPool = csData.coinList[i].count
    --    end
    --end

    CS.CSMissionManager.Instance.isUpDateTaskSchedule = true;

    --region 气泡相关
    Utility.TryShowGodStoneFalshPop(tblData)
    --Utility.TryAddSendUnionRedPackPop(tblData)
    --endregion

    --region 尝试提示宝箱
    if csData.action ~= 2048 and uiStaticParameter.MainHintPanel ~= nil then
        ---非整理引起的提示忽略
        local isNeedHintBox = false
        for i = 0, csData.itemList.Count - 1 do
            ---@type bagV2.BagItemInfo
            local bagItem = csData.itemList[i]
            local type = bagItem.ItemTABLE.type
            local subType = bagItem.ItemTABLE.subType
            if (type == 5 and subType == 78) or (type == 6 and subType == 19) then
                isNeedHintBox = true
                break
            end
        end
        if isNeedHintBox then
            uiStaticParameter.MainHintPanel:RefreshSpecialBoxHint()
        end
    end
    --endregion

    --region 捐献物品
    if uiStaticParameter.UnionDonateOverlayItemLid > 0 then
        local bagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetBagItemBylId(uiStaticParameter.UnionDonateOverlayItemLid)
        if bagItemInfo ~= nil then
            Utility.CreateGuildBagItemPanel(bagItemInfo)
        end
        uiStaticParameter.UnionDonateOverlayItemLid = 0
    end
    --endregion

    --region 法宝
    --如果变动的物品里面有法宝的话，就刷新一下更好的法宝装备
    if tblData ~= nil then
        if luaclass.BagBetterMagicEquip:CheckItemListHaveMagicEquip(tblData.itemList) then
            luaclass.BagBetterMagicEquip:TryAddItems(tblData.itemList)
        elseif luaclass.BagBetterMagicEquip:CheckItemListHaveMagicEquip(tblData.removeItemList) then
            luaclass.BagBetterMagicEquip:TryRemoveItems(tblData.removeItemList)
        end
    end
    --endregion

    --region 战斗连击次数
    Utility.CombatHit_BagItemChange()
    --endregion

    --region 竞技回收
    gameMgr:GetPlayerDataMgr():GetCompetitionDataMgr():OnBagItemChange()
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.Activity_Competition_Recycle);
    --endregion

    --region 根据VIP等级自动使用元宝
    local CSBagRemain = CSBagInfo.EmptyGridCount
    local bagData = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetAllBagItemData()
    if CSBagRemain == 0 then
        for k, v in pairs(bagData) do
            local Lua_ItemsTABLE = clientTableManager.cfg_itemsManager:TryGetValue(v.itemId)
            if Lua_ItemsTABLE:GetVipMemberAutoUse() ~= 0 then
                if Lua_ItemsTABLE:GetVipMemberAutoUse() <= CSPlayerVipInfo then
                    networkRequest.ReqUseItem(v.count, v.lid, 0)
                end
            end
        end
    end
    --endregion

end
--endregion

--region ID:10005 ResUseItemMessage 使用道具返回消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResUseItem lua table类型消息数据
---@param csData bagV2.ResUseItem C# class类型消息数据
netMsgPreprocessing[10005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    ---使用回城石关闭背包
    if tblData.itemId == 8020001 then
        uimanager:ClosePanel("UIBagPanel")
    end

    --region 材料箱一个号买过之后，转生面版不再显示，故作此处理

    if (tblData.itemId == uiStaticParameter.mCurRoleReinBoxId) then
        --策划新需求，如果购买过该道具，则不显示Icon（换手机不考虑）
        local oldStr = CS.UnityEngine.PlayerPrefs.GetString("TurnGrowItem" .. tostring(CS.CSScene.MainPlayerInfo.ID))
        local strTable = string.Split(oldStr, '#')
        if (Utility.IsContainsValue(strTable, tostring(uiStaticParameter.mCurRoleReinBoxId))) then
            return ;
        else
            local newStr = oldStr .. "#" .. tostring(uiStaticParameter.mCurRoleReinBoxId)
            CS.UnityEngine.PlayerPrefs.SetString("TurnGrowItem" .. tostring(CS.CSScene.MainPlayerInfo.ID), newStr)
        end
    end

    --endregion

    --播放使用道具音效
    CS.Cfg_ItemSoundTableManager.Instance:PlayItemSound(tblData.itemId, CS.ItemSoundType.Use)
    CS.UIUseItemCDMask.RefreshCD(csData);
end
--endregion

--region ID:10009 ResRecycleEquipmentMessage 回收装备
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.RecycleSuccess lua table类型消息数据
---@param csData bagV2.RecycleSuccess C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[10009] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:10022 ResStorageInfoMessage 返回请求仓库
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResStorageInfo lua table类型消息数据
---@param csData bagV2.ResStorageInfo C# class类型消息数据
netMsgPreprocessing[10022] = function(msgID, tblData, csData)
    CS.CSScene.MainPlayerInfo.Storage:UpdateStorageInfo(csData)
    --在此处填入预处理代码
    if uiStaticParameter.mIsStorageNeedTidyChecked == false then
        uiStaticParameter.mIsStorageNeedTidyChecked = true
        if tblData and tblData.itemList ~= nil then
            local dic = {}
            local isNeedReqTidyStorage = false
            for i = 1, #tblData.itemList do
                local bagItem = tblData.itemList[i]
                if bagItem.bagIndex ~= nil then
                    if dic[bagItem.bagIndex] ~= nil then
                        isNeedReqTidyStorage = true
                        break
                    else
                        dic[bagItem.bagIndex] = true
                    end
                end
            end
            if isNeedReqTidyStorage then
                networkRequest.ReqTidyStorage()
            end
        end
    end
end
--endregion

--region ID:10023 ResStorageUpdateMessage 仓库更新变化
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResStorageUpdate lua table类型消息数据
---@param csData bagV2.ResStorageUpdate C# class类型消息数据
netMsgPreprocessing[10023] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.Storage:ChangeStorageInfo(csData)
end
--endregion

--region ID:10027 ResAddStorageMaxCountMessage 返回增加格子上限消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResAddStorageMaxCount lua table类型消息数据
---@param csData bagV2.ResAddStorageMaxCount C# class类型消息数据
netMsgPreprocessing[10027] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():RespondAddStorageMaxCount(tblData)
    CS.CSScene.MainPlayerInfo.Storage:ChangeStorageGrid(csData)
end
--endregion

--region ID:10038 ResIntensifyMessage 强化, 转移, 清除响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResIntensify lua table类型消息数据
---@param csData bagV2.ResIntensify C# class类型消息数据
netMsgPreprocessing[10038] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData.equipId > 0 then
        ---刷新背包
        gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():RespondIntensify(tblData)
        CS.CSScene.MainPlayerInfo.BagInfo:UpdateBagIntensifyInfo(csData)
    else
        ---刷新装备
        if csData.equipId <= -1000 then
            CS.CSScene.MainPlayerInfo.ServantInfoV2:UpdateEquipIntensifyInfo(csData)
            gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():OnResIntensifyMessageReceived(tblData)
        else
            CS.CSScene.MainPlayerInfo.EquipInfo:UpdateEquipIntensifyInfo(csData)
            gameMgr:GetPlayerDataMgr():GetLuaStrengthInfo():RefreshStrengthRedPoint()--因为有红点数据缓存操作，请保证此行代码在 gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():OnResIntensifyChange(tblData)之前
            gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():OnResIntensifyChange(tblData)
        end
    end
end
--endregion

--region ID:10042 ResGodFurnaceUpGradeMessage 神炉升级响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[10042] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_GEM);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_SOULBEAD);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_CHYANLAMP);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_THE_SOURCEOFATTACK);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_THE_SOURCEOFDEFENSE);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_ALL);
end
--endregion

--region ID:10043 ResLastingUpdateMessage 耐久值变化响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.LastingUpdate lua table类型消息数据
---@param csData bagV2.LastingUpdate C# class类型消息数据
netMsgPreprocessing[10043] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.EquipInfo ~= nil) then
        CS.CSScene.MainPlayerInfo.EquipInfo:UpdateEquipLastingInfo(csData)
    end
    gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():RefreshSingleEquipLasting(tblData)
end
--endregion

--region ID:10046 ReqlampUpgradeResMessage 赤炎灯灯芯升级返回
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.LampUpgradeRes lua table类型消息数据
---@param csData bagV2.LampUpgradeRes C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[10046] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():RespondLampUpgrade(tblData)
    if (tblData.type == 1) then
        CS.CSScene.MainPlayerInfo.BagInfo:UpdateChyanLamp(tblData.id);
    elseif (tblData.type == 2) then
        CS.CSScene.MainPlayerInfo.BagInfo:UpdateTheSourceOfAttack(tblData.id);
    elseif (tblData.type == 3) then
        CS.CSScene.MainPlayerInfo.BagInfo:UpdateTheSourceOfDefense(tblData.id);
    elseif (tblData.type == 4) then
        CS.CSScene.MainPlayerInfo.BagInfo:UpdateGem(tblData.id);
    end

    --region 宝物
    gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():RefreshSingleGemByLampUpgradeRes(tblData)
    --endregion

    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_GEM);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_SOULBEAD);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_CHYANLAMP);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_THE_SOURCEOFATTACK);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_THE_SOURCEOFDEFENSE);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_ALL);
end
--endregion

--region ID:10048 ResUpgradeSoulJadeMessage 生命精魄升级响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResUpgradeSoulJade lua table类型消息数据
---@param csData bagV2.ResUpgradeSoulJade C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[10048] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():RespondUpgradeSoulJade(tblData)
    CS.CSScene.MainPlayerInfo.BagInfo:UpdateEssenceOfLife(tblData.newId);

    --region 宝物
    gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():RefreshSingleGemByResUpgradeSoulJade(tblData)
    --endregion

    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_GEM);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_SOULBEAD);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_CHYANLAMP);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_THE_SOURCEOFATTACK);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_THE_SOURCEOFDEFENSE);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_ALL);
end
--endregion

--region ID:10050 ResPreyTreasureBagMessage 打开掠宝袋的返回
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.PreyTreasureBagResponse lua table类型消息数据
---@param csData bagV2.PreyTreasureBagResponse C# class类型消息数据
netMsgPreprocessing[10050] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --CS.CSScene.MainPlayerInfo.BagInfo:UpdateTreasureBag(csData)
end
--endregion

--region ID:10051 ResDrawPreyTreasureBagMessage 掠宝袋的领取响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.DrawPreyTreasureBagResponse lua table类型消息数据
---@param csData bagV2.DrawPreyTreasureBagResponse C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[10051] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:10056 ResGetNextSoulJadeMessage 魂玉合成返回
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResGetNextSoulJade lua table类型消息数据
---@param csData bagV2.ResGetNextSoulJade C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[10056] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:10058 ResEvolveMessage 装备进化返回
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResEvolve lua table类型消息数据
---@param csData bagV2.ResEvolve C# class类型消息数据
netMsgPreprocessing[10058] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData.equipId > 0 then
        ---刷新背包
        gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():RespondEvolve(tblData)
        CS.CSScene.MainPlayerInfo.BagInfo:UpdateBagEvolveInfo(csData)
    else
        ---刷新装备
        if csData.equipId <= -1000 then
            CS.CSScene.MainPlayerInfo.EquipInfo:UpdateEquipEvolveInfo(csData)
        end
    end
end
--endregion

--region ID:10060 ResBundlitemMessage 返回打捆的商店列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResBundlitem lua table类型消息数据
---@param csData bagV2.ResBundlitem C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[10060] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:10062 ResSuccessBuyBindlitemMessage 返回成功兑换打捆商品信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResSuccessBuyBindlitem lua table类型消息数据
---@param csData bagV2.ResSuccessBuyBindlitem C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[10062] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:10064 ResBuyMaterialWaySuccessMessage 返回快捷购买成功消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResBuyMaterialWaySuccess lua table类型消息数据
---@param csData bagV2.ResBuyMaterialWaySuccess C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[10064] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:10066 ResDayUseItemCountMessage 返回每日使用物品数量限制
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResDayUseItemCount lua table类型消息数据
---@param csData bagV2.ResDayUseItemCount C# class类型消息数据
netMsgPreprocessing[10066] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():RespondDayUseItemCount(tblData)
    CS.CSScene.MainPlayerInfo.BagInfo:RefreshJvLingZhuUseNumDic(csData)
    --if tblData.itemId == 8040007 then
    --    if uiStaticParameter.MainHintPanel ~= nil then
    --        uiStaticParameter.MainHintPanel:RefreshBigJuLingZhuUseCount()
    --    end
    --end
end
--endregion

--region ID:10070 ResUpdateItemOutputMessage 更新物品产出
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.UpdateItemOutput lua table类型消息数据
---@param csData bagV2.UpdateItemOutput C# class类型消息数据
netMsgPreprocessing[10070] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.ServerItemInfo:UpdateServerItemInfo(csData)
    end
end
--endregion

--region ID:10073 ResItemTipsMessage 物品获得提示
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResItemTips lua table类型消息数据
---@param csData bagV2.ResItemTips C# class类型消息数据
netMsgPreprocessing[10073] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:10075 ResPreyTreasureBoxMessage 打开掠宝袋宝箱的返回
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.PreyTreasureBoxResponse lua table类型消息数据
---@param csData bagV2.PreyTreasureBoxResponse C# class类型消息数据
netMsgPreprocessing[10075] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:10076 ResDrawPreyTreasureBoxMessage 掠宝袋宝箱的领取响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.DrawPreyTreasureBoxResponse lua table类型消息数据
---@param csData bagV2.DrawPreyTreasureBoxResponse C# class类型消息数据
netMsgPreprocessing[10076] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:10080 ResAwardPreyTreasureBoxMultiMessage 返回掠宝袋宝箱使用多个请求
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResAwardPreyTreasureBoxMulti lua table类型消息数据
---@param csData bagV2.ResAwardPreyTreasureBoxMulti C# class类型消息数据
netMsgPreprocessing[10080] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:10083 ResSmeltMessage 熔炼物品回包
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResSmelt lua table类型消息数据
---@param csData bagV2.ResSmelt C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[10083] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData ~= nil and tblData.rewards ~= nil and #tblData.rewards ~= 0 then
        local rewardInfoList = {}
        for i = 1, #tblData.rewards do
            local rewardInfo = tblData.rewards[i]
            local temp = {}
            temp.itemId = rewardInfo.itemId
            temp.count = rewardInfo.number
            table.insert(rewardInfoList, temp)
        end
        uimanager:CreatePanel("UIRewardTipsPanel", nil, { rewards = rewardInfoList }, { type = LuaEnumRewardTipsType.SmeltReWard })
    end
end
--endregion

--region ID:10085 ResBloodSmeltMessage 熔炼血继回包
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResBloodSmelt lua table类型消息数据
---@param csData bagV2.ResBloodSmelt C# class类型消息数据
netMsgPreprocessing[10085] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData.item.index == 0 then
        ---刷新背包
        gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():RespondBloodSmelt(tblData)
        CS.CSScene.MainPlayerInfo.BagInfo:UpdateBagItemByLid(csData.item.lid, csData.item)
    else

    end
end
--endregion

--region ID:10087 ResDivineSmeltMessage 熔炼胜利回包
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResDivineSmelt lua table类型消息数据
---@param csData bagV2.ResDivineSmelt C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[10087] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:10088 ResBagSizeByMonthCardMessage 返回背包格子上限消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResBagSizeByMonthCard lua table类型消息数据
---@param csData bagV2.ResBagSizeByMonthCard C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[10088] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        ---@type CSBagInfoV2
        local bagItemInfoV2 = mainPlayerInfo.BagInfo
        if tblData.maxGridCount then
            bagItemInfoV2.MaxGridCount = tblData.maxGridCount
        end
        if tblData.emptyGridCount then
            bagItemInfoV2.EmptyGridCount = tblData.emptyGridCount
        end
    end
    local luaBag = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
    luaBag:RefreshMaxGridCountByMonthCard(tblData)
end
--endregion

--region ID:10090 ResUpdateAutomaticCollectMessage 同步自动挖掘数量
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResUpdateAutomaticCollect lua table类型消息数据
---@param csData bagV2.ResUpdateAutomaticCollect C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[10090] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    if CS.CSScene.Sington ~= nil then
        CS.CSScene.Sington.GatherController.LastAutoGatherTimes = tblData.count
    elseif CS.CSScene.MainPlayerInfo.Data ~= nil then
        CS.CSScene.MainPlayerInfo.Data.automaticCollectCount = tblData.count
    end
end
--endregion

--[[
--region ID:10012 ResGetAttackDragBuyCountMessage 返回次数
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bagV2.ResGetAttackDragBuyCount lua table类型消息数据
---@param csData bagV2.ResGetAttackDragBuyCount C# class类型消息数据
netMsgPreprocessing[10012] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
--]]

--[[
--region ID:10034 ResItemApartMessage 物品拆分响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[10034] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
--]]
