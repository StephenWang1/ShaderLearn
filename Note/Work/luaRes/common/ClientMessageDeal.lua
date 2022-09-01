---客户端消息处理
---统一处理lua层无消息接收者但与lua有关的消息
local ClientMessageDeal = {}
ClientMessageDeal.IsInit = false

---客户端事件分发
local clientEventHandler = CS.EventHandlerManager(CS.EventHandlerManager.DispatchType.Event)

local ClientEventClearAvoidList = nil

function ClientMessageDeal.Initialize()
    if (ClientMessageDeal.IsInit == false) then
        ClientMessageDeal.IsInit = true
        ClientMessageDeal.InitializeClientMessage()
        ClientMessageDeal.InitializeAnyBtnMessage()
    end
    if (ClientEventClearAvoidList == nil) then
        ClientEventClearAvoidList = CS.System.Collections.Generic["List`1[System.UInt32]"]();
        ClientEventClearAvoidList:Add(409)
        ClientEventClearAvoidList:Add(554)
        ClientEventClearAvoidList:Add(431)
        ClientEventClearAvoidList:Add(432)
        ClientEventClearAvoidList:Add(280)
        ClientEventClearAvoidList:Add(442)
        ClientEventClearAvoidList:Add(453)
        ClientEventClearAvoidList:Add(494)
        ClientEventClearAvoidList:Add(407)
        ClientEventClearAvoidList:Add(655)
        ClientEventClearAvoidList:Add(653)
        ClientEventClearAvoidList:Add(440)
        ClientEventClearAvoidList:Add(441)
        ClientEventClearAvoidList:Add(437)
        ClientEventClearAvoidList:Add(438)
        ClientEventClearAvoidList:Add(205)
        ClientEventClearAvoidList:Add(507)
        ClientEventClearAvoidList:Add(697)
        ClientEventClearAvoidList:Add(218)
        ClientEventClearAvoidList:Add(408)
        ClientEventClearAvoidList:Add(708)
        ClientEventClearAvoidList:Add(656)
        ClientEventClearAvoidList:Add(104)
    end
end

function ClientMessageDeal.OnReturnLogin(IsReturnRolePanel)
    if gameMgr.BindChangeAccountAutoEvent ~= nil then
        gameMgr:BindChangeAccountAutoEvent();
    end
    if (IsReturnRolePanel == true) then
        --CS.CSGame.Sington:OnReturnChooseRole()
        CS.UIManager.Instance:CloseAllPanel(nil, true, CS.ECloseAllPanel.ChangeScene);

        CS.CSGame.Sington:ClearBeforeLeaveGame();
        CS.CSSceneManager.Instance:Load(CS.SceneType.LoginScene, 0, false, false, true);
    else
        CS.CSGame.Sington:OnReturnLogin()
    end
    --CS.CSNetwork.Instance.SocketEventHander:Clear();
    gameMgr:GetLuaTimeMgr():Reset()
    --CS.CSNetwork.Instance.ClientEventHander:Clear(ClientEventClearAvoidList);
    --ClientMessageDeal.InitializeClientMessage()
end

---绑定回调
---@param clientMsg CEvent 客户端消息枚举
---@param callback fun<CEvent,...> 客户端消息处理回调函数
function ClientMessageDeal.BindCallback(clientMsg, callback)
    clientEventHandler:AddEvent(clientMsg, callback)
end

---移除回调
---@param clientMsg CEvent 客户端消息枚举
---@param callback fun<CEvent,...> 客户端消息处理回调函数
function ClientMessageDeal.RemoveCallback(clientMsg, callback)
    clientEventHandler:RemoveEvent(clientMsg, callback)
end

---绑定客户端消息处理函数至对应的客户端消息上
function ClientMessageDeal.InitializeClientMessage()
    ClientMessageDeal.BindCallback(CS.CEvent.TryReturnLoginPanel, ClientMessageDeal.OnTryReturnLoginPanel)
    ClientMessageDeal.BindCallback(CS.CEvent.TryReturnRolePanel, ClientMessageDeal.OnTryReturnRolePanel)
    ClientMessageDeal.BindCallback(CS.CEvent.TryReconnectNetWork, ClientMessageDeal.OnTryReconnectNetWork)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_AttackSkillExpInfoChange, ClientMessageDeal.OnResSkillUpgradeMessage)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_CreateXLuaPanel, uipanelconfig.OnCreateXLuaPanelEventReceived)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_FloatHeadStateChanged, ClientMessageDeal.OnFloatHeadStateChangedReceived)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_OpenMainPanel, ClientMessageDeal.OnV2_OpenMainPanelEventReceived)
    ClientMessageDeal.BindCallback(CS.CEvent.Scene_EnterSceneAfter, ClientMessageDeal.OnScene_EnterSceneAfterEventReceived)
    ClientMessageDeal.BindCallback(CS.CEvent.Scene_EnterSceneAfter, ClientMessageDeal.InitializeConfigDatas)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_CloseXLuaPanel, ClientMessageDeal.OnCloseXLuaPanelEventReceived)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_CloseAllXLuaPanel, ClientMessageDeal.CloseAllXLuaPanelEventReceived)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_JumpXLuaPanel, ClientMessageDeal.JumpXLuaPanelEventReceived)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_BagItemChanged, ClientMessageDeal.OnV2_BagItemChangedEventReceived)
    ClientMessageDeal.BindCallback(CS.CEvent.ReturnLoginRole, ClientMessageDeal.OnReturnLoginRole)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_MapProcessAfterLoaded, ClientMessageDeal.OnMapLoadedEventReceived)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_MonsterSiegeActivityStateChange, ClientMessageDeal.OnMonsterSiegeActivityStateChangeEventReceived)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_Task_OpenPanel, ClientMessageDeal.OnSpecialTask_OpenPanel)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_Task_ClosePanel, ClientMessageDeal.OnSpecialTask_ClosePanel)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_MainPlayerAppearanceListRefresh, ClientMessageDeal.OnMainPlayerAppearanceListRefresh)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_OnReachBooth, ClientMessageDeal.OnClickBooth)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_SelectUnitMultiplyClick, ClientMessageDeal.CarOnClick)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_ShowDailyTaskItemInfoPanel, ClientMessageDeal.OnShowDailyTaskItemInfo)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_ShowDailyActiveBossInfoPanel, ClientMessageDeal.OnShowDailyBossInfo)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_ClickURLAction, ClientMessageDeal.OnUrlActionItemNameClick);
    ClientMessageDeal.BindCallback(CS.CEvent.UnionIDChange, ClientMessageDeal.UnionIDChange);
    ClientMessageDeal.BindCallback(CS.CEvent.V2_OpenQuitPrompt, ClientMessageDeal.OpenQuitPrompt);
    ClientMessageDeal.BindCallback(CS.CEvent.V2_RelationwordsOpenItem, ClientMessageDeal.OnRelationwordsOpenItem);
    ClientMessageDeal.BindCallback(CS.CEvent.V2_DailyTaskShowTargetItem, ClientMessageDeal.OnDailyTaskShowTargetItem);
    ClientMessageDeal.BindCallback(CS.CEvent.DoLuaGC, ClientMessageDeal.OnDoLuaGCMessageReceived);
    ClientMessageDeal.BindCallback(CS.CEvent.V2_SecretaryOpenPanel, ClientMessageDeal.OnSecretaryOpenPanel);
    ClientMessageDeal.BindCallback(CS.CEvent.V2_OnClickFindDailyTaskRecommend, ClientMessageDeal.OnClickFindDailyTaskRecommend);
    ClientMessageDeal.BindCallback(CS.CEvent.V2_OpenOtherPlayerMsgPanel, ClientMessageDeal.OpenOtherPlayerMsgPanel);
    ClientMessageDeal.BindCallback(CS.CEvent.V2_SecretaryBookOpenPanel, ClientMessageDeal.OnSecretaryBookOpenPanel);
    ClientMessageDeal.BindCallback(CS.CEvent.Role_UpdateLevel_Delay, ClientMessageDeal.OnRole_UpdateLevel);
    ClientMessageDeal.BindCallback(CS.CEvent.V2_OpenBuDouKaiSettle, ClientMessageDeal.OnOpenBuDouKaiSettle);
    ClientMessageDeal.BindCallback(CS.CEvent.V2_CalendarActivityIsOpen, ClientMessageDeal.ActivityChange);
    ClientMessageDeal.BindCallback(CS.CEvent.V2_OpenUnionDartCarSettlePanel, ClientMessageDeal.OnOpenUnionDartCarSettlePanel);
    ClientMessageDeal.BindCallback(CS.CEvent.V2_OnAutomaticTeam, ClientMessageDeal.OnAutomaticTeam);
    ClientMessageDeal.BindCallback(CS.CEvent.V2_SceneMagicBallOnClick, ClientMessageDeal.OnSceneMagicBallOnClick)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_CanRewardUnionRedPack, ClientMessageDeal.UnionRedPackAttention)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_OnPaySuccessEvent, ClientMessageDeal.OnPaySuccessCallBack)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_OpenProtectKingPanel, ClientMessageDeal.OnOpenProtectKingPanel)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_OnActivityShaBaKEnd, ClientMessageDeal.OnActivityShaBaKEnd)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_BuDouKaiStageRefresh, ClientMessageDeal.BuDouKaiStageChange)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_LastingChange, ClientMessageDeal.OnEquipLastingChange)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_ClearEnterMapResponse, ClientMessageDeal.OnClearEnterMapResponse)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_MapResourceLoaded, ClientMessageDeal.OnMapResourceLoaded)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_FCMStateRefresh, ClientMessageDeal.OnFCMStateRefreshMessageReceived)
    ClientMessageDeal.BindCallback(CS.CEvent.Scene_EnterSceneAfter, ClientMessageDeal.OnEnterSceneAfter)
    ClientMessageDeal.BindCallback(CS.CEvent.RemoveMonthCard, ClientMessageDeal.OnMonthCardRemove)
    ClientMessageDeal.BindCallback(CS.CEvent.OnClickUseTerrinSkill, ClientMessageDeal.OnOnClickUseTerrinSkill)
    ClientMessageDeal.BindCallback(CS.CEvent.CSMagicBossWarning_FocusOnEvent, ClientMessageDeal.OnCSMagicBossWarning_FocusOnEvent)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_OpenPrefixPanel, ClientMessageDeal.OpenPrefixPanel)
    ClientMessageDeal.BindCallback(CS.CEvent.Role_UpdateLevel_Delay, ClientMessageDeal.onUpdataLevel)
    ClientMessageDeal.BindCallback(CS.CEvent.Role_UpdateReincarnation, ClientMessageDeal.onUpdateReinLv)
    ClientMessageDeal.BindCallback(CS.CEvent.Role_UpdateReinLevel_Delay, ClientMessageDeal.onUpdateReinLv_Delay)
    ClientMessageDeal.BindCallback(CS.CEvent.MagicBossCuontChange, ClientMessageDeal.OnMagicBossCuontChange)
    ClientMessageDeal.BindCallback(CS.CEvent.ReqBossRankMessage, ClientMessageDeal.ReqBossRankMessageReceived)
    ClientMessageDeal.BindCallback(CS.CEvent.V2_BagCoinsChanged, ClientMessageDeal.ReqBagCoinsChangedMessage)
    ClientMessageDeal.BindCallback(CS.CEvent.OpenBonfirePanel, ClientMessageDeal.OnOpenBonfirePanelMessage)
    ClientMessageDeal.BindCallback(CS.CEvent.CloseBonfirePanel, ClientMessageDeal.OnCloseBonfirePanelMessage)
    ClientMessageDeal.BindCallback(CS.CEvent.Buff_RemoveBuff, ClientMessageDeal.OnBuff_RemoveBuffMessage)
    ClientMessageDeal.BindCallback(CS.CEvent.PreloadingTtexture, ClientMessageDeal.OnPreloadingTtexture)
    ClientMessageDeal.BindCallback(CS.CEvent.FlyItemToBag, ClientMessageDeal.OnFlyItemToBag)
    ClientMessageDeal.BindCallback(CS.CEvent.FlyItemToDigTreasureWarehouse, ClientMessageDeal.OnFlyItemToDigTreasureWarehouse)
    ClientMessageDeal.BindCallback(CS.CEvent.TransferResult, ClientMessageDeal.OnTransferResult)
    ClientMessageDeal.BindCallback(CS.CEvent.PersonalBossCuontChange, ClientMessageDeal.OnPersonalBossCuontChange)
    ClientMessageDeal.BindCallback(CS.CEvent.GestureZoomScreen, ClientMessageDeal.OnGestureZoomScreen)
end

function ClientMessageDeal.InitializeAnyBtnMessage()
    CS.UIEventListener.anyBtnClickDelegate = ClientMessageDeal.OnAnyBtnClickShowEffect
    CS.Top_UITiledSameAtlasSprite.anyBtnClickDelegate = ClientMessageDeal.OnAnyBtnClickShowEffect
    --ClientMessageDeal.SpecialTask_OpenBag = false
end

---执行一次LuaGC的消息
function ClientMessageDeal.OnDoLuaGCMessageReceived()
    --print("Lua GC")
    collectgarbage("collect")
end


--region 客户端事件独立处理

--region 登入返回相关的事件

---尝试返回登入界面
function ClientMessageDeal.OnTryReturnLoginPanel(id, data)
    clientMessageDeal.OnReturnLogin(false);
end

---尝试返回选角界面
function ClientMessageDeal.OnTryReturnRolePanel(id, data)
    clientMessageDeal.OnReturnLogin(true);
end

---尝试网络重连
function ClientMessageDeal.OnTryReconnectNetWork(id, data)
    CS.CSNetwork.Instance:Reconection();
end

---endregion


---创建其他其他玩家头像显示
function ClientMessageDeal.OnFloatHeadStateChangedReceived(id, data)
    if (data and data.AvatarType == CS.EAvatarType.MainPlayer) then
        return
    end
    ---屏蔽npc显示
    if data and data.AvatarType == CS.EAvatarType.NPC then
        return
    end
    local isShowMonsterHead = false
    if data ~= nil and not (data.MonsterTable ~= nil and CS.Cfg_GlobalTableManager.Instance:HideMonsterHeadAndHpBar(data.MonsterTable.type)) then
        isShowMonsterHead = true
        if data.gatherTbl ~= nil then
            ---规避掉采集对象
            isShowMonsterHead = false
        end
    end
    if isShowMonsterHead then
        local panel = uimanager:GetPanel("UIMonsterHeadPanel")
        if panel then
            panel:Show(data)
            if (data.AvatarType == CS.EAvatarType.Monster) then
                if (data.MonsterTable.type == 2) then
                    if CS.StaticUtility.IsNull(panel.GetHeadBottom_UISprite()) == false then
                        panel.GetHeadBottom_UISprite().spriteName = "g2"
                    end
                elseif (data.MonsterTable.type == 3) then
                    if CS.StaticUtility.IsNull(panel.GetHeadBottom_UISprite()) == false then
                        panel.GetHeadBottom_UISprite().spriteName = "g3"
                    end
                end
            else
                panel.GetHeadBottom_UISprite().spriteName = "g1"
            end
        else

            uimanager:CreatePanel("UIMonsterHeadPanel", function(panelTemp)
                if panelTemp and CS.StaticUtility.IsNull(panelTemp.GetHeadBottom_UISprite()) == false then
                    if (data.AvatarType == CS.EAvatarType.Monster) then
                        if (data.MonsterTable.type == 2) then
                            panelTemp.GetHeadBottom_UISprite().spriteName = "g2"
                        elseif (data.MonsterTable.type == 3) then
                            panelTemp.GetHeadBottom_UISprite().spriteName = "g3"
                        end
                    else
                        panelTemp.GetHeadBottom_UISprite().spriteName = "g1"
                    end

                    ---设置深度比活动按钮栏低一个深度
                    local mainMenusPanel = uimanager:GetPanel("UIMainMenusPanel");
                    if (mainMenusPanel ~= nil and not CS.StaticUtility.IsNull(mainMenusPanel.go)) then
                        local panelComponent = CS.Utility_Lua.GetComponent(panelTemp.go, "UIPanel");
                        local targetPanelComponents = CS.Utility_Lua.GetComponent(mainMenusPanel.go, "UIPanel");
                        if (panelComponent ~= nil and targetPanelComponents ~= nil) then
                            panelComponent.depth = targetPanelComponents.depth - 1;
                        end
                    end
                end
            end, data)
        end
    else
        gameMgr:GetPlayerDataMgr():GetLuaGhostShipMgr():SetIsTarget(false)
        uimanager:ClosePanel("UIMonsterHeadPanel")
    end
    ClientMessageDeal.CarOnClick(id, data)
end

---接收到主界面消息
function ClientMessageDeal.OnV2_OpenMainPanelEventReceived(id, data)
    --头顶气泡要在最下面
    uimanager:CreatePanel("UIHeadShowPanel")
    uimanager:CreatePanel("UIMainMenusPanel", nil)
end

---进入场景后事件
function ClientMessageDeal.OnScene_EnterSceneAfterEventReceived(id, data)
    --region 第一次进入场景
    if uiStaticParameter.firstEnterScene == true then
        uiStaticParameter.firstEnterScene = false
        uiStaticParameter.voiceMgr = luaComponentTemplates.UIVoice_Mgr
        uiStaticParameter.voiceMgr:Init()
        CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.BOSS_ALL)
        if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.UnionInfoV2.IsOpenLister == true then
            CS.SDKManager.VoiceSDKInterface:RealTimeVoiceEnterRoom(1)
        end

        ---登录的时候请求一次钻石商店数据，用于判断是否有礼包没有购买
        networkRequest.ReqOpenStoreById(LuaEnumStoreType.DiamondRechargeGift)
        ---登录的时候请求一次限时礼包数据，用于判断是否有礼包没有购买
        networkRequest.ReqOpenStoreById(LuaEnumStoreType.LimitGift)
        ---登录的时候请求一次循环钻石限时商店数据，用于判断是否有礼包没有购买
        networkRequest.ReqOpenStoreById(LuaEnumStoreType.CircleDiamondRechargeGift)
        ---登录的时候请求所有行会信息，用于行会地宫活动
        networkRequest.ReqSendAllUnionInfo()
        ---登录的时候请求投资信息
        networkRequest.ReqInvestPlanData()
        ---登录的时候请求累计奖励的红点信息
        networkRequest.ReqCumRechargeCanReceive()
        ---登录的时候请求挖宝次数
        networkRequest.ReqDigTreasureCount()

        ---设置变强提示首次登陆
        if uiStaticParameter.isFirstStrongPrompt == false then
            uiStaticParameter.isFirstStrongPrompt = true
        end
        Utility.GuildDungeonPrompShow()

        local navPanel = uimanager:GetPanel("UINavigationPanel");
        if (navPanel ~= nil) then
            navPanel:GetNavViewTemplate():InitRedPoint();
        end

        ---对缓存的气泡数据进行处理
        if uiStaticParameter.flashCache then
            for i = 1, #uiStaticParameter.flashCache do
                Utility.AddFlashPrompt(uiStaticParameter.flashCache[i])
            end
            uiStaticParameter.flashCache = nil
        end

        CS.Cfg_RecoverSetTableManager.Instance:RefreshAllSettingOptionChooseState()
    end
    --endregion

    ---关闭自动挖掘功能
    if CS.CSScene.MainPlayerInfo then
        local isAutoGatherOpened = CS.CSScene.MainPlayerInfo.ConfigInfo:GetBool(CS.EConfigOption.AutoDig)
        if isAutoGatherOpened then
            CS.CSScene.MainPlayerInfo.ConfigInfo:SetBool(CS.EConfigOption.AutoDig, false)
        end
    end

    ---在切换地图时移除联服封印塔的伤害Buff,后续服务器会发送buff过来的
    --print("在切换地图时移除联服封印塔的伤害Buff,后续服务器会发送buff过来的")
    if luaclass.SealTowerDataInfo.isTowerAddDamageOpened then
        luaclass.SealTowerDataInfo.isTowerAddDamageOpened = false
        CS.CSScene.MainPlayerInfo.BuffInfo:RemoveClientBuff(13009001)
    end

    if uiStaticParameter.monthCardInfo ~= nil then
        ---对于初次进入游戏服务器时间未刷新而刷新月卡数据问题
        CS.CSScene.MainPlayerInfo.MonthCardInfo:UpdateMonthCardInfo(uiStaticParameter.monthCardInfo)
        uiStaticParameter.monthCardInfo = nil
    end

    --uimanager.PreloadPanels();
    uimanager:CreatePanel("UIMainMenusPanel", nil)
    if (CS.CSScene.MainPlayerInfo.HP <= 0 and uimanager:GetPanel("UIDeadGrayPanel") == nil) then
        uimanager:CreatePanel("UIDeadGrayPanel", nil)
    end

    --在地宫地图生成挖宝界面
    --print("当前地图ID",CS.CSScene.MainPlayerInfo.MapID,gameMgr:GetPlayerDataMgr():GetDigTreasureManager():IsShowDigPanel())
    if gameMgr:GetPlayerDataMgr():GetDigTreasureManager():IsShowDigPanel() then
        local panel = uimanager:GetPanel("UIDiggingTreasurePanel")
        if panel == nil then
            uimanager:CreatePanel("UIDiggingTreasurePanel")
        else
            panel:Show()
        end
    else
        uimanager:ClosePanel("UIDiggingTreasurePanel")
    end

    ----在幽灵船地图生成左侧界面
    local ghostMap = gameMgr:GetPlayerDataMgr():GetLuaGhostShipMgr():CheckMap()
    if ghostMap ~= nil then
        uimanager:CreatePanel("UIGhostShipLeftMainPanel")
    else
        uimanager:ClosePanel("UIGhostShipLeftMainPanel")
    end

    ClientMessageDeal.BuDouKaiStageChange()

    ---移除自动组队提示的气泡
    Utility.RemoveFlashPrompt(1, 31)
    gameMgr:OnEnterGameScene()
    networkRequest.ReqToViewUnionRevenge()
    gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitSmeltMgr():CallAllRedPoint()
    gameMgr:GetPlayerDataMgr():GetEquipProficientMgr():CallRed()
    gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr():CallSpecialRed()
    gameMgr:GetPlayerDataMgr():GetReinDataManager():CallUpReinLvRedPoint()
end

---初始化配置数据
function ClientMessageDeal.InitializeConfigDatas()
    uiStaticParameter.mIsFaceEquippedBefore = CS.CSScene.MainPlayerInfo.IConfigInfo:GetInt(LuaEnumLuaConfigID.IsFaceEquippedBefore) == 1
    uiStaticParameter.mIsDouliEquippedBefore = CS.CSScene.MainPlayerInfo.IConfigInfo:GetInt(LuaEnumLuaConfigID.IsDouliEquippedBefore) == 1
    uiStaticParameter.mIsLeftWeaponEquippedBefore = CS.CSScene.MainPlayerInfo.IConfigInfo:GetInt(LuaEnumLuaConfigID.IsLeftWeaponEquippedBefore) == 1
end

---关闭xlua界面事件
function ClientMessageDeal.OnCloseXLuaPanelEventReceived(id, data)
    if uimanager then
        uimanager:ClosePanel(data)
    end
end

---关闭所有xlua界面事件
function ClientMessageDeal.CloseAllXLuaPanelEventReceived(id, data)
    if data == CS.ECloseAllPanel.ChangeScene then
        uimanager:CloseAllPanelChangeScene()
    elseif data == CS.ECloseAllPanel.ChangeMap then
        uimanager:CloseAllPanelChangeMap()
    end
end

---根据jumpId跳转对应的界面
function ClientMessageDeal.JumpXLuaPanelEventReceived(id,data)
    if data then
        uiTransferManager:TransferToPanel(tonumber(data))
    end
end

---背包物品变化事件
function ClientMessageDeal.OnV2_BagItemChangedEventReceived(id, data)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.ROLE_EQUIP);
    gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr():RefreShRedData()
    gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitSmeltMgr():CallAllRedPoint()
    gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetMainPlayerBagRecycleMgr():AutoRecycle()
    gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():XianZhuangRedPointChange()
    gameMgr:GetPlayerDataMgr():GetReinDataManager():CallUpReinLvRedPoint()
    gameMgr:GetPlayerDataMgr():GetZhenFaManager():CallRedPoint()
    gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.SealMark))
    gameMgr:GetPlayerDataMgr():GetRecastMgr():CallRecastRedPoint()
end

---切换地图结束事件
function ClientMessageDeal.OnMapLoadedEventReceived(id, data)
    --切换地图时,请求一次小地图
    --networkRequest.ReqMinMap()
    uiStaticParameter.isNeedSendMinReq = 1
    if not uiStaticParameter.isOpenDefendKingLeftRankInfo then
        Utility.TryOpenActivityIcon(luaEnumActivityTypeByActivityTimeTable.DartCar)
    end
end

---怪物攻城阶段消息改变
function ClientMessageDeal.OnMonsterSiegeActivityStateChangeEventReceived(id, data)
    if data.stage then
        local MonsterSiegePanel = uimanager:GetPanel("UIMonsterSiegeTipsPanel")
        if data.stage == 1 then
            --print("第一阶段")
            if MonsterSiegePanel then
                MonsterSiegePanel:SwitchToFirstPanel()
                MonsterSiegePanel:RefreshFirstPanel()
            else
                uimanager:CreatePanel("UIMonsterSiegeTipsPanel", function(panel)
                    panel:SwitchToFirstPanel()
                    panel:RefreshFirstPanel()
                end)
            end
        elseif data.stage == 2 then
            --print("第二阶段")
            if MonsterSiegePanel then
                uimanager:GetPanel("UIMonsterSiegeTipsPanel"):SwitchToSecondPanel()
            else
                uimanager:CreatePanel("UIMonsterSiegeTipsPanel", function(panel)
                    panel:SwitchToSecondPanel()
                end)
            end
        elseif data.stage == 3 then
            --print("第三阶段")
            if MonsterSiegePanel then
            else
                uimanager:CreatePanel("UIMonsterSiegeTipsPanel", function(panel)
                    panel:SwitchToSecondPanel()
                    panel.DeleteAllMonsterPoint()
                end)
            end
        elseif data.stage == 4 then
            --print("第四阶段")
            if MonsterSiegePanel then
                uimanager:ClosePanel("UIMonsterSiegeTipsPanel")
            end
        end
    end
end

---技能经验变化
function ClientMessageDeal.OnResSkillUpgradeMessage()
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.SKILL_ALL);
    --CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.SKILL_PARTICULARS);
end

---防沉迷状态刷新事件
function ClientMessageDeal.OnFCMStateRefreshMessageReceived(id, data)
    if CS.CSGame.Sington ~= nil then
        local antiAddiction = CS.CSGame.Sington.AntiAddiction
        local age = antiAddiction.AuthorityState
        ---沉迷的半小时数,例如一小时对应2,一个半小时对应3
        local fcmstate = antiAddiction.FCMState
        ---总在线分钟数,每60s刷新一次
        local onlineTime = math.floor(antiAddiction.OnlineSeconds / 60)
        ---获取最大在线时间(分钟)
        local maxOnlineTime = 90
        if ClientMessageDeal.mOffLineTime == nil then
            local isReaden, str = CS.Cfg_GlobalTableManager.Instance:TryGetValue(997)
            if isReaden then
                ClientMessageDeal.mOffLineTime = {}
                local strs = string.Split(str.value, '#')
                table.insert(ClientMessageDeal.mOffLineTime, tonumber(strs[1]))
                table.insert(ClientMessageDeal.mOffLineTime, tonumber(strs[2]))
            end
        end
        if ClientMessageDeal.mOffLineTime ~= nil then
            local dayOfWeek = antiAddiction:GetServerDayOfWeek()
            local isHoliday = dayOfWeek == 0 or dayOfWeek == 6
            if isHoliday == false then
                ---若不处于周末,则检查是否处于节假日
                isHoliday = antiAddiction:IsServerTimeAtHoliday()
            end
            if isHoliday then
                ---周末,0表示周日,6表示周六
                maxOnlineTime = ClientMessageDeal.mOffLineTime[2]
            else
                maxOnlineTime = ClientMessageDeal.mOffLineTime[1]
            end
        end
        if (age == 0 and onlineTime < maxOnlineTime) or age >= 18 then
            ---未认证且未满游戏时间的账号和已成年账号不打开防沉迷提示
            return
        end
        ---剩余在线时间
        local lastTime = math.clamp(maxOnlineTime - onlineTime, 0, maxOnlineTime)
        local isOpen = false
        local reason = 0
        if uiStaticParameter.mIsFCMTipPanelOpenedByLastTime == nil then
            ---未成年人,第一次打开时显示防沉迷界面
            isOpen = true
            reason = 1
            uiStaticParameter.mIsFCMTipPanelOpenedByLastTime = true
        end
        if fcmstate ~= nil and fcmstate > 0 then
            ---若防沉迷状态>0,表示需要检验一下是否需要打开界面
            if uiStaticParameter.mIsFCMTipsPanelOpenedByFCMStateChange ~= nil and uiStaticParameter.mIsFCMTipsPanelOpenedByFCMStateChange ~= fcmstate then
                uiStaticParameter.mIsFCMTipsPanelOpenedByFCMStateChange = fcmstate
                isOpen = true
                reason = 2
            end
        end
        ---检测当前小时
        local currentServerHour = antiAddiction:GetServerNowHour()
        --if true then
        if currentServerHour >= 22 or currentServerHour < 8 then
            ---22点~8点，未成年人不可登入游戏
            isOpen = true
            reason = 3
        end
        if isOpen then
            uimanager:CreatePanel("UIAntiAddictionTipsPanel", nil, fcmstate, lastTime, reason)
        end
    end
end

---角色数据初始化完毕
function ClientMessageDeal.OnEnterSceneAfter(id, data)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_Practice_PUSH);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_Practice_Site1);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_Practice_Site2);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_Practice_Site3);
    ---移除常显活动列表
    CS.CSNetwork.SendDelayClientEvent(CS.CEvent.V2_RefreshOutActivity);
end

---月卡移除
function ClientMessageDeal.OnMonthCardRemove(id, cardInfo)
    if cardInfo ~= nil and cardInfo.cardType == LuaEnumCoceralCardType.MengZhongMonthTasteCard and cardInfo.endTime - CS.CSScene.MainPlayerInfo.serverTime <= 0 then
        Utility.TryAddFlashPromp({ id = LuaEnumFlashIdType.MengZhongCommerceHint, clickCallBack = function()
            Utility.RemoveFlashPrompt(1, LuaEnumFlashIdType.MengZhongCommerceHint)
            Utility.ShowSecondConfirmPanel({ PromptWordId = 103, ComfireAucion = function()
                uimanager:CreatePanel("UICommercePanel")
            end })
        end })
    end
end
--endregion

--region 点击NPC
---点击镖车
function ClientMessageDeal.CarOnClick(id, avater)
    ---镖车
    if avater ~= nil and avater.MonsterTable ~= nil and avater.MonsterTable.type == LuaEnumMonsterType.DartCar then
        if uiStaticParameter.InCarAcitivity == false then
            ---当前不在活动中
            if not CS.StaticUtility.IsNullOrEmpty(CS.CSScene.MainPlayerInfo.UIUnionName) and CS.CSScene.MainPlayerInfo.Level >= CS.Cfg_GlobalTableManager.Instance:GetDartCarPlayerLevel() then
                CS.CSScene.MainPlayerInfo.ActivityInfo.unionShowRank = true
                networkRequest.ReqJoinUnionCart()
            end
        elseif uiStaticParameter.InCarAcitivity == true then
            ---当前在活动中
            local UIGangEscortLeftPanel = uimanager:GetPanel("UIGangEscortLeftPanel")
            if UIGangEscortLeftPanel ~= nil then
                UIGangEscortLeftPanel:RefreshSelfState(true)
            end
        end
    end
end
--endregion

--region 点击摊位
function ClientMessageDeal.OnClickBooth(id, avatar)
    if avatar == nil then
        return
    end
    local boothLid = avatar.Owner.IBaseInfo.boothLid
    --local rid = avatar.Owner.IBaseInfo.rid
    uiStaticParameter.ClickBoothInfo = avatar.Owner.Info
    uiStaticParameter.BoothLid = boothLid
    if avatar.Owner.IBaseInfo and avatar.Owner.IBaseInfo.Data then
        ---苍月岛摊位特殊判断
        if avatar.Owner.IBaseInfo.Data.type == 1 then
            networkRequest.ReqGetMoonBoothItems(boothLid)
            return
        end
    end
    networkRequest.ReqGetBoothItems(boothLid)
end
--endregion

function ClientMessageDeal.OnShowDailyTaskItemInfo(msgId, msgData)
    local isFindItem, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(msgData);
    if (isFindItem) then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable, rightUpButtonsModule = luaComponentTemplates.UISpecialMissionPanel_ItemPartRightUpOperate, showRight = true, showAssistPanel = true, showMoreAssistData = true, showTabBtns = true })
        CS.CSScene.MainPlayerInfo.ActiveInfo.CurrentClickItemId = msgData;
    end
end

---因为活跃度设置引导事件响应在此事件之后  所以 此事件处理要做延时一帧
function ClientMessageDeal.OnShowDailyBossInfo(msgId, msgData)
    if (ClientMessageDeal.mCoroutineDelayShowDailyBossInfo ~= nil) then
        StopCoroutine(ClientMessageDeal.mCoroutineDelayShowDailyBossInfo);
        ClientMessageDeal.mCoroutineDelayShowDailyBossInfo = nil;
    end
    ClientMessageDeal.mCoroutineDelayShowDailyBossInfo = StartCoroutine(ClientMessageDeal.CDelayedShowDailyBossInfo, msgData);
end

function ClientMessageDeal.OnDailyTaskShowTargetItem(msgId, msgData)
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        local activeVo = CS.CSScene.MainPlayerInfo.ActiveInfo:GetProgress(msgData);
        if (activeVo ~= nil and activeVo.mission ~= nil) then
            uimanager:CreatePanel("UIActiveItemShowPanel", nil, { mission = activeVo.mission })
        end
    end
end

function ClientMessageDeal.CDelayedShowDailyBossInfo(msgData)
    coroutine.yield(0);
    local isFindMonster, monsterTable = CS.Cfg_MonsterTableManager.Instance:TryGetValue(msgData);
    if (isFindMonster) then
        local customData = {};
        customData.id = monsterTable.id;
        customData.level = monsterTable.level
        customData.color = CS.Cfg_MonsterTableManager.Instance:GetMonterNameColorByType(monsterTable.type)
        --local currentActiveVo = CS.CSScene.MainPlayerInfo.ActiveInfo:GetCurrentActive();
        --if (currentActiveVo ~= nil and currentActiveVo.activeTable ~= nil) then
        --    if (currentActiveVo.activeTable.goal == 4) then
        --        customData.color = CS.UnityEngine.Color(1, 0, 1);
        --    elseif (currentActiveVo.activeTable.goal == 5) then
        --        customData.color = CS.UnityEngine.Color(1, 0, 0);
        --    else
        --        customData.color = CS.UnityEngine.Color(1, 0, 0);
        --    end
        --else
        --    customData.color = CS.UnityEngine.Color(1, 0, 0);
        --end

        customData.isShowDisplayBtn = true;
        uimanager:CreatePanel("UIBossinfoPanel", function(panel)
            panel.go.transform.localPosition = CS.UnityEngine.Vector3(-150, 150, 0);
        end, customData);
    end
end

--region 任务打开面板
---打开面板
function ClientMessageDeal.OnSpecialTask_OpenPanel(id, data)
    --ClientMessageDeal.OnSpecialTask_OpenForge_Compound(id, data)
    if data == CS.TaskControlPanel.BagPanel then
        ClientMessageDeal.OnSpecialTask_OpenBag(id, data)
    elseif data == CS.TaskControlPanel.Forge_Compound then
        ClientMessageDeal.OnSpecialTask_OpenForge_Compound(id, data)
    elseif data == CS.TaskControlPanel.SpiritBeasts then
        ClientMessageDeal.OnSpecialTask_OpenSpiritBeasts(id, data)
    elseif data == CS.TaskControlPanel.Reincarnation then
        ClientMessageDeal.OnSpecialTask_OpenLevelOfMetempsychosis(id, data)
    elseif data == CS.TaskControlPanel.BagPanel_SelectItem then
        ClientMessageDeal.OnSecondTask_OpenBagPanel_SelectItem(id, data)
    elseif data == CS.TaskControlPanel.ShopPanel then
        ClientMessageDeal.OnSecondTask_OpenShopPanel(id, data)
    elseif data == CS.TaskControlPanel.Auction_UpperShelf then
        ClientMessageDeal.OnSecondTask_OpenAuction_UpperShelf(id, data)
    elseif data == CS.TaskControlPanel.Auction_BuyItem then
        ClientMessageDeal.OnSecondTask_OpenAuction_BuyItem(id, data)
    elseif data == CS.TaskControlPanel.Medal then
        ClientMessageDeal.OnSecondTask_OpenMedal(id, data)
    elseif data == CS.TaskControlPanel.CommonOpenPanel then
        ClientMessageDeal.OnSecondTask_CommonOpenPanel(id, data)

    elseif data == CS.TaskControlPanel.JoinGang then
        ClientMessageDeal.OnSecondTask_OpenJoinGang(id, data)
    end
    --CS.CSMissionManager.Instance.CurrentTask = nil
end

---支线任务使用物品跳转背包模块
function ClientMessageDeal.OnSecondTask_OpenBagPanel_SelectItem(msgId, msgData)
    local currentTask = CS.CSMissionManager.Instance.CurrentTask;
    if (currentTask.tbl_taskGoalS ~= nil and currentTask.tbl_taskGoalS.Length > 0) then
        local taskGoal = currentTask.tbl_taskGoalS[0];
        local useItemId = taskGoal.taskGoalParam;
        if (useItemId ~= nil and useItemId ~= 0) then
            local bagItem = CS.CSScene.MainPlayerInfo.BagInfo:GetBagItemInfo(useItemId)
            if (bagItem ~= nil) then
                uiTransferManager:TransferToPanel(LuaEnumTransferType.Bag_Base, nil, function()
                    local bagPanel = uimanager:GetPanel("UIBagPanel");
                    if (bagPanel ~= nil) then
                        bagPanel.SetFilterHighLight(false, function(bagItemInfo)
                            if (bagItemInfo ~= nil) then
                                if (bagItemInfo.lid == bagItem.lid) then
                                    return true;
                                end
                            end
                            return false;
                        end);
                    end
                end);
            else
                --local TipsInfo = {}
                --TipsInfo[LuaEnumTipConfigType.Parent] = self:GetTipsParent_Transform();
                --TipsInfo[LuaEnumTipConfigType.ConfigID] = 110
                --uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
                luaEventManager.DoCallback(LuaCEvent.Task_NotHaveItem);
            end
        end
    end
end

---支线任务跳转商城界面
function ClientMessageDeal.OnSecondTask_OpenShopPanel(msgId, msgData)
    local currentTask = CS.CSMissionManager.Instance.CurrentTask;
    if currentTask == nil then
        return
    end
    if (currentTask.tbl_taskGoalS ~= nil and currentTask.tbl_taskGoalS.Length > 0) then
        local taskGoal = currentTask.tbl_taskGoalS[0];
        local storeId = taskGoal.taskGoalParam;
        local isFind, storeTable = CS.Cfg_StoreTableManager.Instance:TryGetValue(storeId);
        if (isFind) then
            local storeType = storeTable.sellId;
            local customData = {};
            customData.type = storeType;
            customData.IsTaskOpen = true
            customData.chooseStore = {};
            table.insert(customData.chooseStore, storeId);
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Shop_Default, customData);
        end
    end
end

---支线任务取消商店选择
function ClientMessageDeal.OnSecondTask_CloseShopSelect(msgId, msgData)
    local uishopPanel = uimanager:GetPanel('UIShopPanel')
    if uishopPanel ~= nil then
        if uishopPanel.IsTaskOpen then
            uimanager:ClosePanel('UIShopPanel')
        end
        return
    end
    local currentTask = CS.CSMissionManager.Instance.CurrentTask;
    if currentTask == nil then
        return
    end
    if (currentTask.tbl_taskGoalS ~= nil and currentTask.tbl_taskGoalS.Length > 0) then
        local taskGoal = currentTask.tbl_taskGoalS[0];
        local storeId = taskGoal.taskGoalParam;
        local isFind, storeTable = CS.Cfg_StoreTableManager.Instance:TryGetValue(storeId);
        if (isFind) then
            local chooseStore = { }
            table.insert(chooseStore, storeId);
            luaEventManager.DoCallback(LuaCEvent.Task_UnShopSelect, chooseStore)
        end
    end
end

function ClientMessageDeal.OnSecondTask_CommonClosePanel(msgId, msgData, extraPrarm)
    if extraPrarm == "" or extraPrarm == nil or extraPrarm == 0 then
        return
    end
    local isfind, data = CS.Cfg_JumpUITableManager.Instance:TryGetValue(extraPrarm)
    if isfind then
        uimanager:ClosePanel(data.panels)
    end
end

function ClientMessageDeal.OnSecondTask_OpenAuction_UpperShelf(msgId, msgData)
    uiTransferManager:TransferToPanel(LuaEnumTransferType.Auction_UpperShelf);
end

function ClientMessageDeal.OnSecondTask_OpenAuction_BuyItem(msgId, msgData)
    local data = {}
    data.isTask = true
    local globle = ClientMessageDeal:GetNowTaskTargetGlobal(1)
    if globle ~= 0 and globle ~= nil and globle ~= "" then
        data.jumpID = globle
    end
    --  data.jumpID = 105
    uiTransferManager:TransferToPanel(LuaEnumTransferType.Auction_Trade, data, nil);
end

---通用获取当前技能目标特殊参数
function ClientMessageDeal:GetNowTaskTargetGlobal(number)
    local currentTask = CS.CSMissionManager.Instance.CurrentTask;
    if currentTask == nil then
        return
    end
    if number <= 0 then
        number = 1
    end
    local index = number - 1
    if (currentTask.tbl_taskGoalS ~= nil and currentTask.tbl_taskGoalS.Length > index) then
        local taskGoal = currentTask.tbl_taskGoalS[index];
        return taskGoal.global;
    end
    return nil
end

function ClientMessageDeal.OnSecondTask_OpenMedal(msgId, msgData)
    --打开战勋面板需求砍掉，需要添加复原即可
    --  uiTransferManager:TransferToPanel(LuaEnumTransferType.Role_Prefix);
end

function ClientMessageDeal.OnSecondTask_CommonOpenPanel(msgId, msgData)
    local currentTask = CS.CSMissionManager.Instance.CurrentTask;
    if currentTask == nil then
        return
    end
    if currentTask.tbl_taskGoalS ~= nil and currentTask.tbl_taskGoalS.Length >= 1 then
        if currentTask.tbl_taskGoalS[0] ~= nil then
            if currentTask.tbl_taskGoalS[0].global ~= nil then
                uiTransferManager:TransferToPanel(currentTask.tbl_taskGoalS[0].global);
            end
        end
    end
end

function ClientMessageDeal.OnSecondTask_OpenJoinGang(id, data)
    uimanager:CreatePanel("UIUnionManagerPanel", nil, true);
end

---关闭面板
function ClientMessageDeal.OnSpecialTask_ClosePanel(id, data, extraPrarm)
    if data == CS.TaskControlPanel.BagPanel then
        ClientMessageDeal.OnSpecialTask_CloseBag(id, data)
    elseif data == CS.TaskControlPanel.Forge_Compound then
        ClientMessageDeal.OnSpecialTask_CloseForge_Compound(id, data)
    elseif data == CS.TaskControlPanel.SpiritBeasts then
        ClientMessageDeal.OnSpecialTask_CloseSpiritBeasts(id, data)
    elseif data == CS.TaskControlPanel.Reincarnation then
        ClientMessageDeal.OnSpecialTask_CloseLevelOfMetempsychosis(id, data)
    elseif data == CS.TaskControlPanel.ShopPanel then
        ClientMessageDeal.OnSecondTask_CloseShopSelect(id, data)
    elseif data == CS.TaskControlPanel.CommonClosePanel then
        ClientMessageDeal.OnSecondTask_CommonClosePanel(id, data, extraPrarm)
    end
end

---任务完成直接打开背包穿戴装备
function ClientMessageDeal.OnSpecialTask_OpenBag(id, data)
    local RolePanel = uimanager:GetPanel("UIRolePanelTagPanel")
    local BagPanel = uimanager:GetPanel("UIBagPanel")
    if RolePanel == nil then
        uimanager:CreatePanel("UIRolePanelTagPanel")
    end
    if BagPanel == nil then
        local hintEquipBagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(2010001)
        local hintTable = {}
        if hintEquipBagItemInfo ~= nil then
            table.insert(hintTable, hintEquipBagItemInfo.lid)
        end
        uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Normal,
                                                   chosenBagItemIDs = hintTable,
                                                   focusedBagItemInfo = bagItemInfo,
                                                   openSourceType = LuaEnumPanelOpenSourceType.ByItemHint })
    end
end

---任务完成关闭背包界面
function ClientMessageDeal.OnSpecialTask_CloseBag(id, data)
    local RolePanel = uimanager:GetPanel("UIRolePanel")
    local BagPanel = uimanager:GetPanel("UIBagPanel")
    if RolePanel ~= nil then
        uimanager:ClosePanel("UIRolePanel")
    end
    if BagPanel ~= nil then
        uimanager:ClosePanel("UIBagPanel")
    end
end

---任务完成打开锻造合成界面
function ClientMessageDeal.OnSpecialTask_OpenForge_Compound(id, data)
    local ServantEggList = CS.CSScene.MainPlayerInfo.BagInfo:FilterServantEgg()
    if ServantEggList == nil or ServantEggList.Count <= 0 then
        return
    end
    uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_HM)

end
---任务完成关闭锻造合成界面
function ClientMessageDeal.OnSpecialTask_CloseForge_Compound(id, data)
    uimanager:ClosePanel("UISynthesisPanel")
    uimanager:ClosePanel('UIServantPanel')
    uimanager:ClosePanel('UIBagPanel')
end

---任务完成打开锻造合成界面
function ClientMessageDeal.OnSpecialTask_OpenSpiritBeasts(id, data)
    uimanager:CreatePanel("UILsSchoolPanel")

end
---任务完成关闭灵兽试炼界面
function ClientMessageDeal.OnSpecialTask_CloseSpiritBeasts(id, data)
    uimanager:ClosePanel("UILsSchoolPanel")
end

---任务接取打开转生面板
function ClientMessageDeal.OnSpecialTask_OpenLevelOfMetempsychosis(id, data)
    uiTransferManager:TransferToPanel(LuaEnumTransferType.Role_Rein)
end
---任务完成关闭角色面板
function ClientMessageDeal.OnSpecialTask_CloseLevelOfMetempsychosis(id, data)
    uimanager:ClosePanel("UIRolePanelTagPanel")
end


--endregion

---主角外观列表刷新事件
function ClientMessageDeal.OnMainPlayerAppearanceListRefresh()
    if uiStaticParameter.UseItemAndOpenAppearancePanelItemID and uiStaticParameter.UseItemAndOpenAppearancePanelMaxTime then
        if CS.UnityEngine.Time.time < uiStaticParameter.UseItemAndOpenAppearancePanelMaxTime then
            local itemID = uiStaticParameter.UseItemAndOpenAppearancePanelItemID
            local callBack = function(panel)
                if panel then
                    panel:Show(nil, itemID)
                end
            end
            uimanager:CreatePanel("UIRolePanelTagPanel", nil, { type = LuaEnumLeftTagType.UIOutlookPanel })
        end
    end
    uiStaticParameter.UseItemAndOpenAppearancePanelItemID = nil
    uiStaticParameter.UseItemAndOpenAppearancePanelMaxTime = nil
end

function ClientMessageDeal.OnReturnLoginRole()
    uimanager:CreatePanel("UILoginRolePanel")
end

ClientMessageDeal.anyBtnEffect = nil

---按钮点击特效产生
function ClientMessageDeal.OnAnyBtnClickShowEffect(go)

    local pos = Utility.GetTouchPoint()

    local v3 = CS.UnityEngine.Vector3(pos.x, pos.y, 0)
    local pressPos = CS.UICamera.currentCamera:ScreenToWorldPoint(v3)
    local localPos = CS.UIManager.Instance.UIRoot.transform:InverseTransformPoint(pressPos)
    localPos.z = -2500
    if ClientMessageDeal.anyBtnEffect ~= nil and not CS.StaticUtility.IsNull(ClientMessageDeal.anyBtnEffect) then
        ClientMessageDeal.anyBtnEffect.transform.localPosition = localPos
        ClientMessageDeal.anyBtnEffect:SetActive(false)
        ClientMessageDeal.anyBtnEffect:SetActive(true)
    else
        local res = CS.CSResourceManager.Singleton:AddQueueCannotDelete("800010", CS.ResourceType.UIEffect, function(res)
            if res ~= nil or res.MirrorObj ~= nil then
                if CS.StaticUtility.IsNull(go) == false and go.activeSelf == true then
                    local uiroot = CS.UILayerMgr.Instance:GetLayerObj(CS.UILayerType.TipsPlane)
                    if uiroot ~= nil or not CS.StaticUtility.IsNull(uiroot) then
                        ClientMessageDeal.anyBtnEffect = res:GetObjInst()
                        if ClientMessageDeal.anyBtnEffect then
                            ClientMessageDeal.anyBtnEffect.transform.parent = uiroot
                            ClientMessageDeal.anyBtnEffect.transform.localPosition = localPos
                            ClientMessageDeal.anyBtnEffect.transform.localScale = CS.UnityEngine.Vector3(100, 100, 100)
                        end
                    end
                end
            end
        end, CS.ResourceAssistType.UI)
        res.IsCanBeDelete = false;
    end
end

---链接点击事件处理
function ClientMessageDeal.OnUrlActionItemNameClick(id, data)
    --读取事件[url:]...[url/]
    local eventList = string.Split(tostring(data), '|')

    local type = eventList[1]

    ---type为open表示打开面板，后续为参数
    ---type为deliver表示传送，暂时读表
    if (type == "event:open") then
        local parms = {}
        local count = Utility.GetLuaTableCount(eventList)
        if (count > 2) then
            if (eventList[2] == "UIGuildTipsPanel") then
                eventList[3] = tonumber(eventList[3])
                if (eventList[3] == CS.CSScene.Sington.MainPlayer.BaseInfo.ID) then
                    return
                end
                --eventList[5] = tonumber(eventList[5])
                uimanager:CreatePanel("UIGuildTipsPanel", nil, {
                    panelType = #eventList > 4 and tonumber(eventList[5]) or 0,
                    roleId = #eventList > 2 and eventList[3] or 0,
                    roleName = #eventList > 3 and eventList[4] or "",
                    roleSex = Utility.GetLuaTableCount(eventList) > 5 and eventList[6] or nil,
                    roleCareer = Utility.GetLuaTableCount(eventList) > 6 and eventList[7] or nil,
                })
                return
            elseif (eventList[2] == "UIItemInfoPanel") then
                local bagItemInfo = CS.Utility_Lua.ReverseItemInfo(eventList[4])
                local roleId = nil
                local career = nil
                if eventList[5] ~= nil then
                    roleId = tonumber(eventList[5])
                end
                if eventList[6] ~= nil then
                    career = tonumber(eventList[6])
                end
                if bagItemInfo ~= nil then
                    eventList[4] = bagItemInfo
                else
                    eventList[4] = nil
                    return
                end
                if (CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemInfo.itemId)) then
                    ClientMessageDeal.ShowItemInfo(CS.Cfg_ItemsTableManager.Instance.dic[bagItemInfo.itemId], eventList[4], roleId, career)
                end
                return
            elseif (eventList[2] == "UINavigationPanel") then
                if (luaEventManager.HasCallback(LuaCEvent.Navigation_OpenWithId)) then
                    local customData = {};
                    customData.targetId = tonumber(eventList[3]);
                    luaEventManager.DoCallback(LuaCEvent.Navigation_OpenWithId, customData);
                end
                return
            elseif (eventList[2] == "UIAuctionPanel") then
                local customData = {};
                customData.type = tonumber(eventList[3]);
                uimanager:CreatePanel(eventList[2], nil, customData)
                return
            elseif (eventList[2] == "jump") then
                local jumpId = tonumber(eventList[3])
                if jumpId ~= nil then
                    uiTransferManager:TransferToPanel(jumpId)
                end
                return
            end
        end

        local name = eventList[2]
        local isShow, tips = CS.Cfg_GlobalTableManager.Instance:IsAnnounceCanOpenPanel(name)
        if not isShow then
            CS.Utility.ShowTips(tips, 1.5, CS.ColorType.Red)
            return
        end

        for i = 3, Utility.GetLuaTableCount(eventList) do
            table.insert(parms, eventList[i])
        end
        uimanager:CreatePanel(eventList[2], nil, table.unpack(parms))
    elseif (type == "event:deliver") then
        networkRequest.ReqDeliverByConfig(tonumber(eventList[2]), false)
    elseif (type == "role:") then
        --local parms = {}
        --for i = 2, Utility.GetLuaTableCount(eventList) do
        --    eventList[4] = tonumber(eventList[4])
        --    table.insert(parms, eventList[i])
        --    uimanager:CreatePanel("UIGuildTipsPanel", nil, table.unpack(parms))
        --end

        uimanager:CreatePanel("UIGuildTipsPanel", nil, {
            panelType = Utility.GetLuaTableCount(eventList) > 4 and tonumber(eventList[5]) or 0,
            roleId = Utility.GetLuaTableCount(eventList) > 2 and eventList[3] or 0,
            roleName = Utility.GetLuaTableCount(eventList) > 3 and eventList[4] or "",
            roleSex = Utility.GetLuaTableCount(eventList) > 5 and eventList[6] or nil,
            roleCareer = Utility.GetLuaTableCount(eventList) > 6 and eventList[7] or nil,
        })
    end
end

function ClientMessageDeal.ShowItemInfo(itemInfo, bagItemInfo, roleId, career)
    Utility.OpenItemInfoAndCheckMarryRing(bagItemInfo, roleId, career)
end

--region 帮会
---加入帮会后打开面板
function ClientMessageDeal.UnionIDChange()
    if uiStaticParameter.IsAutoSkillOpenPanel == true then
        uiStaticParameter.IsAutoSkillOpenPanel = false
        return
    end
    if CS.CSScene.MainPlayerInfo then
        local unionId = CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID
        if unionId and unionId ~= 0 then
            local panel = uimanager:GetPanel("UIGuildPanel")
            if panel == nil then
                uimanager:CreatePanel("UIGuildPanel")
                uimanager:ClosePanel("UIUnionManagerPanel")
            end
        end
    end
end

---帮会红包领取提醒
function ClientMessageDeal.UnionRedPackAttention(id, redBagId)
    Utility.RemoveFlashPrompt(1, 27)
    if redBagId and redBagId ~= 0 then
        local temp = {}
        temp.id = 27
        temp.clickCallBack = function()
            networkRequest.ReqUnionRedBagInfo(redBagId)
        end
        Utility.AddFlashPrompt(temp)
    end
end

function ClientMessageDeal.OnPaySuccessCallBack()
    networkRequest.ReqRechargeEntrance(uiStaticParameter.RechargePoint)
end
--endregion

---小秘书打开面板
function ClientMessageDeal.OnSecretaryOpenPanel(id, data)
    uiTransferManager:TransferToPanel(data)
end

function ClientMessageDeal.OnClickFindDailyTaskRecommend(msgId, msgData)
    uimanager:ClosePanel("UIDayToDayPanel");
end

---其他玩家信息面板打开
function ClientMessageDeal.OpenOtherPlayerMsgPanel(id, btnType, btnSubType)
    local otherPlayerInfo = CS.CSScene.MainPlayerInfo.OtherPlayerInfo
    if btnType ~= nil and uimanager:GetPanel("UIOtherPlayerMessagePanel") == nil then
        if btnType == LuaEnumOtherPlayerBtnType.MARRYRINGITEMINFO then
            ---婚戒信息面板
            if otherPlayerInfo ~= nil and otherPlayerInfo.OtherPlayerMarryInfo ~= nil then
                local marryInfo = otherPlayerInfo.OtherPlayerMarryInfo
                local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(marryInfo.marriageInfo.ringItemId)
                if itemInfoIsFind then
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = marryInfo.marriageInfo, itemInfo = itemInfo, roleId = CS.CSScene.MainPlayerInfo.OtherPlayerInfo.OtherRoleId })
                    otherPlayerInfo:ClearAllOtherPlayerInfo()
                end
            end
        else
            uimanager:CreatePanel("UIOtherPlayerMessagePanel", nil, { btnType = btnType, btnSubtype = btnSubType })
        end
    end
end

---打开秘籍面板
function ClientMessageDeal.OnSecretaryBookOpenPanel(id, data)
    uimanager:CreatePanel("UISecretBookPanel", nil, data)
end

--region 退出提示
function ClientMessageDeal.OpenQuitPrompt()
    uimanager:CreatePanel("UIQuitPanel")
end
--endregion

function ClientMessageDeal.OnRelationwordsOpenItem(id, data, isCanOperation)
    local mItemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(data)
    if mItemInfo ~= nil and mItemInfo.type == 8 and mItemInfo.subType == 4 and mItemInfo.useParam ~= nil and mItemInfo.useParam.list.Count == 3 then
        local BagItemInfo = CS.bagV2.BagItemInfo()
        BagItemInfo.itemId = mItemInfo.id
        BagItemInfo.luck = mItemInfo.useParam.list[1]
        BagItemInfo.maxStar = mItemInfo.useParam.list[1]
        if isCanOperation then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = BagItemInfo, rightUpButtonsModule = luaComponentTemplates.UIItemGetWay_ItemPartRightUpOperate, showRight = true })
        else
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = BagItemInfo, showRight = false })
        end
    else
        if isCanOperation then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = mItemInfo, rightUpButtonsModule = luaComponentTemplates.UIItemGetWay_ItemPartRightUpOperate, showRight = true })
        else
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = mItemInfo, showRight = false })
        end
    end
end

---升级刷新
function ClientMessageDeal.OnRole_UpdateLevel(id, data)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.Recharge);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.Recharge_Reward);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.FURNACE_ALL);
    ClientMessageDeal.CheckNeedSetAutoUseItemOne()

    ClientMessageDeal.RefreshPlaceCallToMake()

    gameMgr:GetLuaRedPointManager():CallMagicBossRedPoint(true)
    gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr():RefreShRedData()
    gameMgr:GetPlayerDataMgr():GetMainPlayerBetterItemHintDataMgr():TryHintAllItem(LuaEnumBetterItemHintReason.LevelUp)
    luaclass.BagBetterMagicEquip:RefreshBagBetterMagicEquip()
    gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.Boss_God)
    gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr():CallSpecialRed()
    gameMgr:GetPlayerDataMgr():GetSettingMgr():LevelChange()
    networkRequest.ReqRechargeGiftBox()
end

---刷新快捷栏道具信息
function ClientMessageDeal.RefreshPlaceCallToMake()
    local limitLevel = LuaGlobalTableDeal.ZhaoHuanLingLimitLevel()
    local itemid = LuaGlobalTableDeal.ZhaoHuanLingItemID()
    if CS.CSScene.MainPlayerInfo.Level ~= limitLevel then
        return
    end
    local isHave = CS.CSScene.MainPlayerInfo.BagInfo:IsContainByItemId(itemid)
    if isHave then
        Utility.PlaceCallToMake(true)
    end
end

---打开武道会结算面板
function ClientMessageDeal.OnOpenBuDouKaiSettle()
    if CS.CSScene.MainPlayerInfo.ActivityInfo.ShowRank == true then
        if (ClientMessageDeal.mOpenBuDouKaiRankPanel ~= nil) then
            StopCoroutine(ClientMessageDeal.mOpenBuDouKaiRankPanel)
            ClientMessageDeal.mOpenBuDouKaiRankPanel = nil
        end
        local openBuDouKaiRankPanelFunc = function(data)
            coroutine.yield(0.5)
            uimanager:CreatePanel("UIActivityRankPanel", nil, data)
        end
        ClientMessageDeal.mOpenBuDouKaiRankPanel = StartCoroutine(openBuDouKaiRankPanelFunc, { id = LuaEnuActivityRankID.BuDouKai })
    end
end

---历法活动变化
function ClientMessageDeal:ActivityChange(id, activityId, state)
    if activityId == luaEnumActivityTypeByActivityTimeTable.DartCar then
        if state == true then
            Utility.TryOpenActivityIcon(activityId)
        else
            Utility.CloseActivityIcon()
        end
    end
end

---打开行会押镖活动结算面板
function ClientMessageDeal.OnOpenUnionDartCarSettlePanel()
    local UIActivityRankPanel = uimanager:GetPanel("UIActivityRankPanel")
    if UIActivityRankPanel == nil then
        uimanager:CreatePanel("UIActivityRankPanel", nil, { id = LuaEnuActivityRankID.UnionDartCar, refreshCallBack = function()
            networkRequest.ReqUnionCartRank()
        end })
    else
        if luaEventManager.HasCallback(LuaEnumNetDef.ResUnionDartCarRankMessage) then
            luaEventManager.DoCallback(LuaEnumNetDef.ResUnionDartCarRankMessage)
        end
    end
end

--[[---接收到重置玩家位置消息,处理时间在场景处理消息之后(为了解决拉回时服务端又多拉回了一次(?)导致位置会有差异,但是服务端说可以用其他方法,暂时不需要该解决方案了)
--function ClientMessageDeal.OnScene_PlayerPositionResetedMsgReceived(id, data)
--    print("接收到重置玩家位置消息", data.x, data.y, data.reason)
--    CS.NetV2.ReqPlayerMoveMesage_Extend(data.x, data.y, CS.CSServerTime.Instance.TotalMillisecond, 2)
--end]]

---自动组队提示（敌帮22150 同帮22547）
function ClientMessageDeal.OnAutomaticTeam(msgId, msgData)
    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
        return
    end
    if uiStaticParameter.mAutoTeamTipsDoNotHintAgain == true then
        return
    end
    if (msgData ~= nil) then
        if msgData.state == Utility.EnumToInt(CS.AutomaticTeamState.ALLHAVETEAMS)
                or msgData.state == Utility.EnumToInt(CS.AutomaticTeamState.ALLNOTHAVETEAMS)
                or msgData.state == Utility.EnumToInt(CS.AutomaticTeamState.OTHERHASTEAM)
                or msgData.state == Utility.EnumToInt(CS.AutomaticTeamState.MEHAVETEAM) then
            --同行会
            if LuaGlobalTableDeal.NeedTeamPrompt(true) == false then
                return
            end

        elseif msgData.state == Utility.EnumToInt(CS.AutomaticTeamState.JOIN_OR_CHANGEPKMODEL)
                or msgData.state == Utility.EnumToInt(CS.AutomaticTeamState.JOIN_OR_FIGHT)
                or msgData.state == Utility.EnumToInt(CS.AutomaticTeamState.JOIN_REFUSE_CHANGEPKMODEL)
                or msgData.state == Utility.EnumToInt(CS.AutomaticTeamState.JOIN_REFUSE_FIGHT) then
            --不同行会
            if LuaGlobalTableDeal.NeedTeamPrompt(false) == false then
                return
            end
        else
            --状态异常
            return
        end

        local data = {}
        data.id = 31
        data.panelPriority = msgData
        data.clickCallBack = function()
            Utility.RemoveFlashPrompt(1, 31)
            CS.CSScene.Sington.AutomaticTeam:ClearAttackCount();
        end
        Utility.TryAddFlashPromp(data)
    end
end

function ClientMessageDeal.OnSceneMagicBallOnClick(id, msgData)
    local bagItemInfoList = CS.CSScene.MainPlayerInfo.MagicCircleInfo:GetAllMagicCircleMaterialInBag()
    if bagItemInfoList == nil or bagItemInfoList.Count == 0 then
        CS.Utility.ShowTips("暂无魔法神石")
        return
    end
    Utility.CreateItemUsePanel({ bagItemInfoList = bagItemInfoList, singleUseBtnOnClick = function()
        CS.CSScene.MainPlayerInfo.MagicCircleInfo:TryPlayMagicBallTween()
    end, moreUseBtnOnClick = function()
        CS.CSScene.MainPlayerInfo.MagicCircleInfo:TryPlayMagicBallTween()
    end })
end

---原来是打开保卫国王用，现在改成根据参数打开活动面板
function ClientMessageDeal.OnOpenProtectKingPanel(msgId, id)
    if id == LuaEnumUnionActivityType.ProtectKing then
        uimanager:CreatePanel("UIActivityRankPanel", nil, {
            id = LuaEnuActivityRankID.DefendKing
        })
    elseif id == LuaEnumUnionActivityType.ShaBake then
        uimanager:CreatePanel("UIActivityRankPanel", function()
            networkRequest.ReqGetSabacRankInfo(Utility.EnumToInt(CS.duplicateV2.SabacRankType.Kill), 1, uiStaticParameter.mShaBaKRankOnePageCount);
        end, {
            id = LuaEnuActivityRankID.ShaBaK,
            refreshCallBack = function()
                networkRequest.ReqGetSabacRankInfo(Utility.EnumToInt(CS.duplicateV2.SabacRankType.Kill), 1, uiStaticParameter.mShaBaKRankOnePageCount);
            end
        })
    end
end

function ClientMessageDeal.OnActivityShaBaKEnd()
    uiStaticParameter.mIsCurrentShaBaK = true;
    uimanager:CreatePanel("UIActivityRankPanel", function()
        networkRequest.ReqGetSabacRankInfo(Utility.EnumToInt(CS.duplicateV2.SabacRankType.Kill), 1, uiStaticParameter.mShaBaKRankOnePageCount);
    end, {
        id = LuaEnuActivityRankID.ShaBaK,
        refreshCallBack = function()
            networkRequest.ReqGetSabacRankInfo(Utility.EnumToInt(CS.duplicateV2.SabacRankType.Kill), 1, uiStaticParameter.mShaBaKRankOnePageCount);
        end
    })
end

function ClientMessageDeal.BuDouKaiStageChange()
    if uiStaticParameter.voiceMgr ~= nil then
        uiStaticParameter.voiceMgr:ChangeRecordState(true, LuaEnumControlRecordStateSource.NONE)
    end
end

function ClientMessageDeal.OnEquipLastingChange()
    Utility.TryOpenLowLastingPop()
end

---清理重复进入地图/重复切换坐标的事件
function ClientMessageDeal.OnClearEnterMapResponse()
    if (CS.CSMapManager.Instance == nil) then
        return
    end

    CS.CSMapManager.Instance:ClearEnterMapResponse();
end

---地图加载完成
function ClientMessageDeal.OnMapResourceLoaded()
    if (CS.CSMapManager.Instance == nil) then
        return
    end

    CS.CSMapManager.Instance:OnMapLoaded();
    gameMgr:SetClientPrepareFinished()
end

--region 药品自动保护设置

---检测是否需要设置自动血量用药
function ClientMessageDeal.CheckNeedSetAutoUseItemOne()
    if uiStaticParameter.GetMeetSetAutoUseItemOneParam() ~= nil then
        local fill = uiStaticParameter.GetMeetSetAutoUseItemOneParam()[1]
        local useItem = uiStaticParameter.GetMeetSetAutoUseItemOneParam()[2]
        local conditionID = uiStaticParameter.GetMeetSetAutoUseItemOneParam()[3]

        ---判断主角是否符合条件
        if CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionID) then
            if CS.CSScene.MainPlayerInfo == nil then
                return
            end
            local configInfo = CS.CSScene.MainPlayerInfo.ConfigInfo
            --拿到当前设置
            local curUseItem = configInfo:GetInt(CS.EConfigOption.AutoUseItem1)
            local curfill = configInfo:GetInt(CS.EConfigOption.AutoUseItem1Drag)

            if tonumber(useItem) == curUseItem and curfill == tonumber(fill) then
                clientMessageDeal.SetAutoUseItemOne(configInfo)
            end
        end
    end
end

---设置自动血量用药
function ClientMessageDeal.SetAutoUseItemOne(mainConfigInfo)
    if uiStaticParameter.GetSetAutoUseItemOneParam() ~= nil then
        if CS.CSScene.MainPlayerInfo == nil then
            return
        end
        local configInfo = mainConfigInfo == nil and CS.CSScene.MainPlayerInfo.ConfigInfo or mainConfigInfo
        local fill = uiStaticParameter.GetSetAutoUseItemOneParam()[1]
        local useItem = uiStaticParameter.GetSetAutoUseItemOneParam()[2]

        configInfo:SetInt(CS.EConfigOption.AutoUseItem1, tonumber(useItem))
        configInfo:SetInt(CS.EConfigOption.AutoUseItem1Drag, tonumber(fill))
    end
end
--endregion

---点击地面使用对地技能
function ClientMessageDeal.OnOnClickUseTerrinSkill(id, hit, SelectTerrinSkill)
    local touchEvent = CS.CSTouchEvent.Sington;
    local mainPlayer = CS.CSScene.Sington.MainPlayer
    touchEvent:TryChangeAutoStates();
    local vt3 = hit.point / CS.CSGame.Sington.PixelRatio;
    touchEvent.ClickCoord = CS.CSTouchEvent.dichotomyFind(vt3, CS.CSCell.Size.x, CS.CSCell.Size.y);
    local mskill = CS.CSScene.Sington.MainPlayer.SkillEngine:GetSkill(SelectTerrinSkill.id);
    if (mskill:isUseMP() == false) then
        CS.Utility.ShowRedTips("法力不足");
        return ;
    end
    if (mskill.IsCanRelease) then
        if (CS.CSScene.Sington.MainPlayer.SkillEngine.IsPublicCDing == false) then
            if (CS.CSAutoFight.IsExitPlayerControl() and mainPlayer.NewCell ~= nil) then
                local canAttack = CS.CSSkillEngine.GetBestLaunchCoord(mskill, mainPlayer.NewCell.Coord, touchEvent.ClickCoord);
                if (canAttack == false) then
                    return ;
                end
            end
            CS.CSScene.Sington.MainPlayer_Extend:TowardsAttackTerrain(mskill, mainPlayer, touchEvent.ClickCoord);
        else
            local skillInfo = CS.CSScene.MainPlayerInfo.SkillInfo;
            skillInfo.NowSelectSkill = CS.NowSelectSkill(mskill, touchEvent.ClickCoord, mainPlayer, CS.ESkillReleaseType.Position);
        end
    end
end
--endregion

--region 魔之Boss
---魔之boss触发预警
function ClientMessageDeal.OnCSMagicBossWarning_FocusOnEvent(id, data)
    if data == 0 then
        ---魔之boss消除预警
        uiStaticParameter.MagicBossInMainPlayerArea = false
        luaclass.MagicBossDataInfo:DelayCloseMagicBossPanel()
    else
        ---魔之boss触发预警
        uiStaticParameter.MagicBossInMainPlayerArea = true
        networkRequest.ReqDemonBossInfo(tonumber(data))
    end
end

---魔之boss数量变化事件
function ClientMessageDeal.OnMagicBossCuontChange()
    gameMgr:GetLuaRedPointManager():CallMagicBossRedPoint(true)
end

--endregion

--region 个人boss
---个人boss数量变化事件
function ClientMessageDeal.OnPersonalBossCuontChange()
    gameMgr:GetLuaRedPointManager():CallPersonalBossRedPoint()
end
--endregion


--region 上古战场
function ClientMessageDeal.OpenPrefixPanel()
    uiTransferManager:TransferToPanel(LuaEnumTransferType.Role_Prefix)
end

--endregion

---玩家等级更新
function ClientMessageDeal.onUpdataLevel()
    if CS.CSScene.MainPlayerInfo ~= nil then
        if CS.CSScene.MainPlayerInfo.Level >= LuaGlobalTableDeal:GetUnionDungeonEnterLevelLimit() then

            local key = "GuildDungeonPrompShowStartEnterLevel" .. CS.CSScene.MainPlayerInfo.ID
            if not CS.UnityEngine.PlayerPrefs.HasKey(key) then
                CS.UnityEngine.PlayerPrefs.SetInt(key, 1);
                Utility.GuildDungeonPrompShow()
            end
        end
    end
    gameMgr:GetPlayerDataMgr():GetReinDataManager():CallUpReinLvRedPoint()
end

---玩家转生等级更新
function ClientMessageDeal.onUpdateReinLv()
    gameMgr:GetLuaRedPointManager():CallMagicBossRedPoint(true)
    gameMgr:GetPlayerDataMgr():GetMainPlayerBetterItemHintDataMgr():TryHintAllItem(LuaEnumBetterItemHintReason.ReinLevelUp)
    luaclass.BagBetterMagicEquip:RefreshBagBetterMagicEquip()
    gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.Boss_God)
    gameMgr:GetPlayerDataMgr():GetReinDataManager():CallUpReinLvRedPoint()
end

---玩家转生登记延迟更新
function ClientMessageDeal.onUpdateReinLv_Delay()
    networkRequest.ReqRechargeGiftBox()
end

--region  boss排行
function ClientMessageDeal.ReqBossRankMessageReceived(msgId, bossId)
    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
        networkRequest.ReqShareAncientBossDamageRank(bossId)
    else
        if CS.CSScene.Sington == nil then
            return
        end
        local avater = CS.CSScene.Sington:getAvatar(bossId);
        if bossId ~= nil and avater ~= nil and avater.MonsterTable ~= nil then
            local monsterid = avater.MonsterTable.id
            local ancientTable = clientTableManager.cfg_ancient_bossManager:TryGetValue(monsterid)
            if ancientTable ~= nil and ancientTable:GetType() == 1 then
                networkRequest.ReqAncientBossDamageRankV2(bossId)
                return
            end
        end
        networkRequest.ReqAncientBossDamageRank(bossId)
    end
end
--endregion

--region 货币变化
function ClientMessageDeal.ReqBagCoinsChangedMessage()
    gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.SealMark))
    gameMgr:GetPlayerDataMgr():GetLuaStrengthInfo():RefreshStrengthRedPoint()
    gameMgr:GetPlayerDataMgr():GetZhenFaManager():CallRedPoint()
    gameMgr:GetPlayerDataMgr():GetRecastMgr():CallRecastRedPoint()
end

--endregion

--region 点击篝火
function ClientMessageDeal.OnOpenBonfirePanelMessage(msgId, lid, type)
    uimanager:CreatePanel("UIBonfirePanel", nil, lid, type)
end

---关闭篝火界面
function ClientMessageDeal.OnCloseBonfirePanelMessage(msgId, lid)
    if lid then
        ---@type UIBonfirePanel
        local panel = uimanager:GetPanel("UIBonfirePanel")
        if panel then
            panel:TryClosePanel(lid)
        end
    end
end
--endregion

--region 移除buf
---@param msgId number
---@param buffInfo fightV2.BufferInfo
---@param lid number 移除buff的对象的lid
function ClientMessageDeal.OnBuff_RemoveBuffMessage(msgId, buffInfo, lid)
    Utility.CombatHit_RemoveBuff(buffInfo, lid)
end
--endregion

--region 让物品从位置飞到背包
function ClientMessageDeal.OnFlyItemToBag(msgId, itemId, from)
    local bagPos = ClientMessageDeal:GetBagPos()
    luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = itemId, from = from, to = bagPos })
end

--region 让物品从位置飞到地宫挖宝仓库
function ClientMessageDeal.OnFlyItemToDigTreasureWarehouse(msgId, itemId, from)
    local pos = ClientMessageDeal:GetDigWarehousePos()
    luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = itemId, from = from, to = pos })
end

---@return UnityEngine.Vector3 背包位置
function ClientMessageDeal:GetBagPos()
    if self.mBagPos == nil then
        local mainChatPanel = uimanager:GetPanel("UIMainChatPanel")
        if mainChatPanel then
            self.mBagPos = mainChatPanel.btn_bag.transform.position
        end
    end
    return self.mBagPos
end

---@return UnityEngine.Vector3 仓库位置
function ClientMessageDeal:GetDigWarehousePos()
    if self.mWarehousePos == nil then
        local panel = uimanager:GetPanel("UIDiggingTreasurePanel")
        if panel then
            self.mWarehousePos = panel.Components.btn_warehouse.transform.position
        end
    end
    return self.mWarehousePos
end
--endregion

--region 传送
---@param msgId number
---@param transferResult TransferResult
function ClientMessageDeal.OnTransferResult(msgId, transferResult)
    if transferResult == nil then
        return
    end
    if transferResult.resultType ~= nil and transferResult.resultType == CS.Enum_TransferResult.ConsumablesNotEnough and transferResult.notEnoughItemId > 0 then
        local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(transferResult.notEnoughItemId)
        if itemInfo == nil then
            return
        end
        local des = clientTableManager.cfg_promptwordManager:GetSecondConfirmContent(96, itemInfo:GetName())
        local jumpId = transferResult.JumpId
        if type(jumpId) ~= 'number' or jumpId <= 0 then
            if transferResult.deliverId ~= nil and transferResult.notEnoughItemId ~= nil then
                jumpId = clientTableManager.cfg_deliverManager:GetJumpIdByItemId(transferResult.deliverId, transferResult.notEnoughItemId)
            end
        end
        if type(jumpId) ~= 'number' or jumpId <= 0 then
            return
        end
        CS.CSListUpdateMgr.Add(100, nil, function()
            Utility.ShowSecondConfirmPanel({ PromptWordId = 96, des = des, ComfireAucion = function()
                if type(jumpId) == 'number' then
                    uiTransferManager:TransferToPanel(jumpId)
                end
            end })
        end, false)
    end
end
--endregion

---@param Type number 类型
---@param openServerTime number 开服时间
---@param combineServerTime number 合服时间
---@param serverCurTime number 服务器当前时间
function ClientMessageDeal.OnPreloadingTtexture(msgId, Type, openServerTime, combineServerTime, serverCurTime)
    Utility.OnPreloadingTtexture(Type, openServerTime, combineServerTime, serverCurTime)
end

---手势缩放视角大小
function ClientMessageDeal.OnGestureZoomScreen(msgId, isenlarge)
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.Sington == nil then
        return
    end
    local istouchUI = CS.UICamera.selectedObject == nil or CS.UICamera.selectedObject.transform.name ~= "UI Root"
    if istouchUI then
        return
    end
    local value = CS.CSScene.MainPlayerInfo.ConfigInfo:GetFloat(CS.EConfigOption.MapZoom)
    if isenlarge then
        value = value + 0.04;
    else
        value = value - 0.04;
    end
    if value >= 1 then
        value = 1
        return
    end
    if value < 0 then
        value = 0
        return
    end
    local nowValue = Utility.TransformRange(value, 0, 1, 1.25, 0.75)
    CS.CSScene.MainPlayerInfo.ConfigInfo:SetFloat(CS.EConfigOption.MapZoom, value)
    local f = CS.CSGame.Sington.ContentSize.y / 2 * CS.CSScene.SceneScale.y
    if CS.StaticUtility.IsNull(CS.UnityEngine.Camera.main) == false then
        CS.UnityEngine.Camera.main.orthographicSize = f * (nowValue)
    end
end

return ClientMessageDeal