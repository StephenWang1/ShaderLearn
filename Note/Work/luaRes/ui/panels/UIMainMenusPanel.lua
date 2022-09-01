--- 主界面面板
--- 挂载 摇杆面板,人物头像面板,技能面板,聊天面板
---@class UIMainMenusPanel:UIBase
local UIMainMenusPanel = {}

--UI界面层级为Resident
UIMainMenusPanel.PanelLayerType = CS.UILayerType.BasicPlane
---@type table 等待界面打开的队列
UIMainMenusPanel.WaitForPanelOpenedTbl = {}
---@type boolean 是否正在等待所有界面开始加载
UIMainMenusPanel.IsWaitForAllPanelStartLoad = false
---@type boolean 打开所有界面是否结束
UIMainMenusPanel.IsOpenPanelFinished = false
--- 掉落公告里已出现过物品ID
UIMainMenusPanel.mDropAnnounceRepetitiveItemList = CS.System.Collections.Generic["List`1[System.Int32]"]()
--- 挖掘公告里已出现过物品ID
UIMainMenusPanel.mGatherAnnounceRepetitiveItemList = CS.System.Collections.Generic["List`1[System.Int32]"]()
--- 银宝箱公告里已出现过物品ID
UIMainMenusPanel.mSilverBoxDropAnnounceRepetitiveItemList = CS.System.Collections.Generic["List`1[System.Int32]"]()
--- 金宝箱公告里已出现过物品ID
UIMainMenusPanel.mGoldBoxDropAnnounceRepetitiveItemList = CS.System.Collections.Generic["List`1[System.Int32]"]()
UIMainMenusPanel.FirstRechargeEffect = nil
UIMainMenusPanel.ReinItemCount = 0
--region parameters
--UIMainMenusPanel.LeftTopRoot = nil --左上锚点
--UIMainMenusPanel.LeftCenterRoot = nil --左中锚点
--UIMainMenusPanel.LeftDownRoot = nil -- 左下锚点
--UIMainMenusPanel.MiddleRoot = nil -- 中锚点
--UIMainMenusPanel.MiddleDownRoot = nil -- 中下锚点
--UIMainMenusPanel.RightTopRoot = nil --右上锚点
--UIMainMenusPanel.RightCenterRoot = nil --右中锚点
--UIMainMenusPanel.RightDownRoot = nil --右下锚点

UIMainMenusPanel.SkillPanel = nil --技能面板
UIMainMenusPanel.JoystickPanel = nil --摇杆面板
UIMainMenusPanel.RoleHeadPanel = nil --左上人物头像
UIMainMenusPanel.MiniMapPanel = nil --右上小地图面板

UIMainMenusPanel.LeftCenterPanelName = nil --左中面板名称

UIMainMenusPanel.ChatPrivateName = "暂时测试"

UIMainMenusPanel.mIsInitEnd = false;

UIMainMenusPanel.isAwaitComplete = true
UIMainMenusPanel.isStartEnterHot = false
UIMainMenusPanel.lastTemperature = 0
UIMainMenusPanel.lastGetTemperatureTime = 0;
---@type table
---回收公告金币、元宝、灵兽经验屏蔽轮次
UIMainMenusPanel.RecycleAnnounceShieldCountDic = {};
---@type number
---狼烟梦境掉落元宝屏蔽轮次
UIMainMenusPanel.DropAnnounceShieldCount = 0;
---@type number
---圣域空间掉落元宝屏蔽轮次
UIMainMenusPanel.DropAnnounceShieldCountInShengYu = 0;
---@type number
---掉落银宝箱屏蔽轮次
UIMainMenusPanel.DropAnnounceSilverBoxCount = 0;
---@type number
---掉落金宝箱屏蔽轮次
UIMainMenusPanel.DropAnnounceGoldBoxCount = 0;

---@type table
---公告信息缓存列表
UIMainMenusPanel.AnnounceTable = {};

---@type number
---公告信息缓存执行次数
UIMainMenusPanel.AnnounceDealIndex = 1
--endregion

--region 静态节点

--region 左侧
function UIMainMenusPanel:GetTopLeftStaticNode()
    if (UIMainMenusPanel.mTopLeftStaticNode == nil) then
        UIMainMenusPanel.mTopLeftStaticNode = UIMainMenusPanel:GetCurComp("TopLeft/StaticNode", "Transform")
    end
    return UIMainMenusPanel.mTopLeftStaticNode;
end

function UIMainMenusPanel:GetLeftStaticNode()
    if (UIMainMenusPanel.mLeftStaticNode == nil) then
        UIMainMenusPanel.mLeftStaticNode = UIMainMenusPanel:GetCurComp("Left/StaticNode", "Transform")
    end
    return UIMainMenusPanel.mLeftStaticNode;
end

function UIMainMenusPanel:GetDownLeftStaticNode()
    if (UIMainMenusPanel.mDownLeftStaticNode == nil) then
        UIMainMenusPanel.mDownLeftStaticNode = UIMainMenusPanel:GetCurComp("BottomLeft/StaticNode", "Transform")
    end
    return UIMainMenusPanel.mDownLeftStaticNode;
end
--endregion

--region 右侧
function UIMainMenusPanel:GetTopRightStaticNode()
    if (UIMainMenusPanel.mTopRightStaticNode == nil) then
        UIMainMenusPanel.mTopRightStaticNode = UIMainMenusPanel:GetCurComp("TopRight/StaticNode", "Transform")
    end
    return UIMainMenusPanel.mTopRightStaticNode;
end

function UIMainMenusPanel:GetRightStaticNode()
    if (UIMainMenusPanel.mRightStaticNode == nil) then
        UIMainMenusPanel.mRightStaticNode = UIMainMenusPanel:GetCurComp("Right/StaticNode", "Transform")
    end
    return UIMainMenusPanel.mRightStaticNode;
end

function UIMainMenusPanel:GetDownRightStaticNode()
    if (UIMainMenusPanel.mDownRightStaticNode == nil) then
        UIMainMenusPanel.mDownRightStaticNode = UIMainMenusPanel:GetCurComp("BottomRight/StaticNode", "Transform")
    end
    return UIMainMenusPanel.mDownRightStaticNode;
end
--endregion

--region 中间
function UIMainMenusPanel:GetTopStaticNode()
    if (UIMainMenusPanel.mTopStaticNode == nil) then
        UIMainMenusPanel.mTopStaticNode = UIMainMenusPanel:GetCurComp("Top/StaticNode", "Transform")
    end
    return UIMainMenusPanel.mTopStaticNode;
end

function UIMainMenusPanel:GetMiddleStaticNode()
    if (UIMainMenusPanel.mMiddleStaticNode == nil) then
        UIMainMenusPanel.mMiddleStaticNode = UIMainMenusPanel:GetCurComp("Middle/StaticNode", "Transform")
    end
    return UIMainMenusPanel.mMiddleStaticNode;
end

function UIMainMenusPanel:GetDownStaticNode()
    if (UIMainMenusPanel.mDownStaticNode == nil) then
        UIMainMenusPanel.mDownStaticNode = UIMainMenusPanel:GetCurComp("Bottom/StaticNode", "Transform")
    end
    return UIMainMenusPanel.mDownStaticNode;
end
--endregion

--endregion

--region 动态节点

--region 左侧

function UIMainMenusPanel:GetTopLeftDynamicNode()
    if (UIMainMenusPanel.mTopLeftDynamicNode == nil) then
        UIMainMenusPanel.mTopLeftDynamicNode = UIMainMenusPanel:GetCurComp("TopLeft/DynamicNode", "Transform")
    end
    return UIMainMenusPanel.mTopLeftDynamicNode;
end

function UIMainMenusPanel:GetLeftDynamicNode()
    if (UIMainMenusPanel.mLeftDynamicNode == nil) then
        UIMainMenusPanel.mLeftDynamicNode = UIMainMenusPanel:GetCurComp("Left/DynamicNode", "Transform")
    end
    return UIMainMenusPanel.mLeftDynamicNode;
end

function UIMainMenusPanel:GetDownLeftDynamicNode()
    if (UIMainMenusPanel.mDownLeftDynamicNode == nil) then
        UIMainMenusPanel.mDownLeftDynamicNode = UIMainMenusPanel:GetCurComp("BottomLeft/DynamicNode", "Transform")
    end
    return UIMainMenusPanel.mDownLeftDynamicNode;
end

--endregion

--region 右侧

function UIMainMenusPanel:GetTopRightDynamicNode()
    if (UIMainMenusPanel.mTopRightDynamicNode == nil) then
        UIMainMenusPanel.mTopRightDynamicNode = UIMainMenusPanel:GetCurComp("TopRight/DynamicNode", "Transform")
    end
    return UIMainMenusPanel.mTopRightDynamicNode;
end

function UIMainMenusPanel:GetRightDynamicNode()
    if (UIMainMenusPanel.mRightDynamicNode == nil) then
        UIMainMenusPanel.mRightDynamicNode = UIMainMenusPanel:GetCurComp("Right/DynamicNode", "Transform")
    end
    return UIMainMenusPanel.mRightDynamicNode;
end

function UIMainMenusPanel:GetDownRightDynamicNode()
    if (UIMainMenusPanel.mDownRightDynamicNode == nil) then
        UIMainMenusPanel.mDownRightDynamicNode = UIMainMenusPanel:GetCurComp("BottomRight/DynamicNode", "Transform")
    end
    return UIMainMenusPanel.mDownRightDynamicNode;
end

--endregion

--region 中间

function UIMainMenusPanel:GetTopDynamicNode()
    if (UIMainMenusPanel.mTopDynamicNode == nil) then
        UIMainMenusPanel.mTopDynamicNode = UIMainMenusPanel:GetCurComp("Middle/DynamicNode", "Transform")
    end
    return UIMainMenusPanel.mTopDynamicNode;
end

function UIMainMenusPanel:GetMiddleDynamicNode()
    if (UIMainMenusPanel.mMiddleDynamicNode == nil) then
        UIMainMenusPanel.mMiddleDynamicNode = UIMainMenusPanel:GetCurComp("Middle/DynamicNode", "Transform")
    end
    return UIMainMenusPanel.mMiddleDynamicNode;
end

function UIMainMenusPanel:GetDownDynamicNode()
    if (UIMainMenusPanel.mDownDynamicNode == nil) then
        UIMainMenusPanel.mDownDynamicNode = UIMainMenusPanel:GetCurComp("Bottom/DynamicNode", "Transform")
    end
    return UIMainMenusPanel.mDownDynamicNode;
end

--endregion

--endregion

--region init
function UIMainMenusPanel:Init()
    UIMainMenusPanel.mLeftTopRootTweenPosition = UIMainMenusPanel:GetCurComp("TopLeft/DynamicNode", "TweenPosition");
    UIMainMenusPanel.mLeftTopRootTweenAlpha = UIMainMenusPanel:GetCurComp("TopLeft/DynamicNode", "TweenAlpha");
    UIMainMenusPanel.mLeftRootTweenPosition = UIMainMenusPanel:GetCurComp("Left/DynamicNode", "TweenPosition");
    UIMainMenusPanel.mLeftRootTweenAlpha = UIMainMenusPanel:GetCurComp("Left/DynamicNode", "TweenAlpha");
    UIMainMenusPanel.mLeftDownRootTweenPosition = UIMainMenusPanel:GetCurComp("BottomLeft/DynamicNode", "TweenPosition");
    UIMainMenusPanel.mLeftDownRootTweenAlpha = UIMainMenusPanel:GetCurComp("BottomLeft/DynamicNode", "TweenAlpha");

    UIMainMenusPanel.mRightTopRootTweenPosition = UIMainMenusPanel:GetCurComp("TopRight/DynamicNode", "TweenPosition");
    UIMainMenusPanel.mRightTopRootTweenAlpha = UIMainMenusPanel:GetCurComp("TopRight/DynamicNode", "TweenAlpha");
    UIMainMenusPanel.mRightRootTweenPosition = UIMainMenusPanel:GetCurComp("Right/DynamicNode", "TweenPosition");
    UIMainMenusPanel.mRightRootTweenAlpha = UIMainMenusPanel:GetCurComp("Right/DynamicNode", "TweenAlpha");
    UIMainMenusPanel.mRightDownRootTweenPosition = UIMainMenusPanel:GetCurComp("BottomRight/DynamicNode", "TweenPosition");
    UIMainMenusPanel.mRightDownRootTweenAlpha = UIMainMenusPanel:GetCurComp("BottomRight/DynamicNode", "TweenAlpha");

    ---动画距离
    UIMainMenusPanel.mLeftTweenDistance = 500;
    UIMainMenusPanel.mRightTweenDistance = 1000;

    self:BindMessage()

    self.updateItem = CS.CSListUpdateMgr.Add(30000, nil, function()
        if CS.CSResUpdateMgr.Instance ~= nil then
            UIMainMenusPanel.isAwaitComplete = true
        end
    end)
    CS.CSListUpdateMgr.Instance:Add(self.updateItem)

    --UIMainMenusPanel.ReadChatRecord()
    UIMainMenusPanel.LoadRechargeEffect()

    local co = coroutine.create(UIMainMenusPanel.OpenPanelSync)
    coroutine.resume(co)

    networkRequest.ReqTitleList()
    networkRequest.ReqGetRechargeInfo()
    networkRequest.ReqRoleCycleGiftBoxInfo()
    UIMainMenusPanel.GetFriendList()
    UIMainMenusPanel.InitEffectTime()
    uiStaticParameter.isShowFlyShoes = false;
    UIMainMenusPanel:ShowRewardRedPoint()
    CS.Cfg_GlobalTableManager.Instance:ResetVIPLevelList()

    UIMainMenusPanel.InitJuLingZhuTimeInfo()

    UIMainMenusPanel.SendLoginInfoSuccess = false
    UIMainMenusPanel.SendLoginInfoErrorCount = 0
    self:SendLoginInfo()

    CS.GameDataSubmit.Instance:SendDataByInt(CS.EGameDataAction.MobileData, CS.ESendDataType.EnterGameSceneSuccess);
    CS.CSNetwork.Instance:ReqHeartbeatMessage()
    gameMgr:GetPlayerDataMgr():GetActivityMgr():InitDailyActivities()

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.LinkEffectAdded, function(msgId, addedLinkEffectId)
        if addedLinkEffectId == nil then
            return
        end
        local linkEffectTbl = clientTableManager.cfg_linkeffectManager:TryGetValue(addedLinkEffectId)
        if linkEffectTbl then
            local info = {}
            info.Str = Utility.CombineStringQuickly("[00ff00]获得 ", linkEffectTbl:GetDescription(), " 效果[-]")
            luaEventManager.DoCallback(LuaCEvent.SendMiddleTopTips, info)
        end
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.LinkEffectRemoved, function(msgId, removedLinkEffectId)
        if removedLinkEffectId == nil then
            return
        end
        local linkEffectTbl = clientTableManager.cfg_linkeffectManager:TryGetValue(removedLinkEffectId)
        if linkEffectTbl then
            local info = {}
            info.Str = Utility.CombineStringQuickly("[ff0000]失去 ", linkEffectTbl:GetDescription(), " 效果[-]")
            luaEventManager.DoCallback(LuaCEvent.SendMiddleTopTips, info)
        end
    end)

    ---发送重置为0
    if CS.CSScene.MainPlayerInfo then
        CS.CSScene.MainPlayerInfo.ConfigInfo:SetInt(CS.EConfigOption.ShowOption, 0)
    end
end

function UIMainMenusPanel:SendLoginInfo()
    if (UIMainMenusPanel.SendLoginInfoSuccess or UIMainMenusPanel.SendLoginInfoErrorCount > 10) then
        return
    end
    CS.GameDataSubmit.Instance:SendData(CS.EGameDataAction.QueryLogInName, "update", nil, UIMainMenusPanel.QueryLogInNameUpdate);
end

UIMainMenusPanel.SendLoginInfoSuccess = false
UIMainMenusPanel.SendLoginInfoErrorCount = 0

function UIMainMenusPanel.QueryLogInNameUpdate(success, data)
    if (success) then
        if (data == "1") then
            UIMainMenusPanel.SendLoginInfoSuccess = true
        end
    else
        CS.UnityEngine.Debug.LogError("QueryLogInName update 失败");
        UIMainMenusPanel.SendLoginInfoErrorCount = UIMainMenusPanel.SendLoginInfoErrorCount + 1
        CS.CSListUpdateMgr.Add(1000, nil, function()
            UIMainMenusPanel:SendLoginInfo()
        end)
    end
end

function UIMainMenusPanel.OpenPanelSync()
    local syncTime = 0.1
    UIMainMenusPanel.mIsInitEnd = false;
    UIMainMenusPanel.WaitForPanelOpenedTbl = {}
    UIMainMenusPanel.IsWaitForAllPanelStartLoad = true
    UIMainMenusPanel.IsOpenPanelFinished = false
    --最多等待5s
    local latestOpenPanelFinishedTime = CS.UnityEngine.Time.time + 5
    --创建其他与主菜单面板相同周期的，但不同层级类型的面板
    uimanager:CreatePanel("UIDialogTipsContainerPanel")
    uimanager:CreatePanel("HintPopTips")
    uimanager:CreatePanel("UIMainHintPanel")
    yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))

    --主菜单面板中的各种子面板
    yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))
    UIMainMenusPanel:AddMainMenuModule("UIServantHeadPanel", UIMainMenusPanel:GetTopLeftDynamicNode())
    yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))
    UIMainMenusPanel:AddMainMenuModule("UIMainChatPanel", UIMainMenusPanel:GetDownStaticNode())
    yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))
    --UIMainMenusPanel:AddMainMenuModule("UIEquipGoodHintPanel", UIMainMenusPanel:GetMiddleStaticNode())
    --yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))
    UIMainMenusPanel:AddMainMenuModule("UIMainSkillPanel", UIMainMenusPanel:GetDownRightDynamicNode())
    yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))
    UIMainMenusPanel:AddMainMenuModule("UIMapDirectionPanel", UIMainMenusPanel:GetTopRightStaticNode())
    yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))
    UIMainMenusPanel:AddMainMenuModule("UIActivitiesPanel", UIMainMenusPanel:GetTopRightDynamicNode(), function(panel)
        local isFind, mapTable = CS.Cfg_MapTableManager.Instance:TryGetValue(CS.CSScene.MainPlayerInfo.MapID);
        if (isFind) then
            if (mapTable.cls == 1) then
                if (panel.UIActivitiesPanelState) then
                    panel.OnArrowClick();
                end
            end
        end
    end);
    yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))
    UIMainMenusPanel:AddMainMenuModule("UIRechargeFirstSloganTipsPanel", UIMainMenusPanel:GetTopRightDynamicNode())
    yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))
    UIMainMenusPanel:AddMainMenuModule("UINavigationPanel", UIMainMenusPanel:GetRightStaticNode())
    yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))
    UIMainMenusPanel:AddMainMenuModule("UIJoystickPanel", UIMainMenusPanel:GetDownLeftDynamicNode())
    yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))
    --最后创建 ，防止查找不到其他组件
    UIMainMenusPanel:AddMainMenuModule("UILvPackPanel", UIMainMenusPanel:GetTopLeftStaticNode())
    yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))

    UIMainMenusPanel:AddMainMenuModule("UIRoleHeadPanel", UIMainMenusPanel:GetTopLeftStaticNode())
    yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))

    --创建其他与主菜单面板相同周期的，但不同层级类型的面板
    uimanager:CreatePanel("UIFlyShoesPanel")
    yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))
    uimanager:CreatePanel("UIEffectPanel")
    yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))
    uimanager:CreatePanel("UIRelifeCountDown")

    --欢迎界面
    if CS.NewEventProcess.IsNewRole then
        uimanager:CreatePanel("UIWelcomePanel", nil)
        yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))
    end
    uimanager:CreatePanel("UIAttributeTipsPanel");
    yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))

    -- UIMainMenusPanel:AddMainMenuModule("UIGameResloadPanel", UIMainMenusPanel:GetTopLeftStaticNode())
    -- yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))

    UIMainMenusPanel:OnResScene_OpenPanel(CS.CSScene:getMapID())

    yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))
    UIMainMenusPanel.ResetTweenOriginParameter();
    UIMainMenusPanel.mIsInitEnd = true;
    UIMainMenusPanel.IsWaitForAllPanelStartLoad = false
    UIMainMenusPanel.CheckIsAllPanelOpened()
    while UIMainMenusPanel.IsOpenPanelFinished == false do
        if CS.UnityEngine.Time.time > latestOpenPanelFinishedTime then
            UIMainMenusPanel.WaitForPanelOpenedTbl = {}
            UIMainMenusPanel.CheckIsAllPanelOpened()
        end
        yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))
    end
    yield_return(CS.NGUIAssist.GetWaitForSeconds(syncTime))
    UIMainMenusPanel:AddMainMenuModule("UIStrongerLeftMainPanel", UIMainMenusPanel:GetTopLeftDynamicNode())
    UIMainMenusPanel:OnAllMainPanelOpened()
    UIMainMenusPanel:SetCameraVolume()
end

--- 增加主界面的组件插件
--- @param moduleName 组件名称
--- @param moduleName 组件节点
function UIMainMenusPanel:AddMainMenuModule(moduleName, root, callBack, params)
    if (root == nil) then
        root = UIMainMenusPanel.go.transform
    end
    UIMainMenusPanel.WaitForPanelOpenedTbl[moduleName] = true
    uimanager:CreatePanel(moduleName, function(panel)
        if panel ~= nil then
            panel.go.transform.parent = root;
            panel.go.transform.localPosition = CS.UnityEngine.Vector3.zero;
            panel.go:SetActive(true)
            --if(root == UIMainMenusPanel:GetLeftDynamicNode()) then
            --    local uipanel = uimanager:GetPanel("UIRoleHeadPanel")
            --    if(uipanel ~= nil) then
            --        CS.UILayerMgr.Instance:SetLayer(uipanel.gameObject, CS.UILayerType.BasicPlane)
            --    end
            --end
            UIMainMenusPanel.WaitForPanelOpenedTbl[moduleName] = nil
            if (callBack ~= nil) then
                callBack(panel);
            end
            UIMainMenusPanel.CheckIsAllPanelOpened()
        end
    end, params)
end

function UIMainMenusPanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResAnnounceMessage, UIMainMenusPanel.ResAnnounceMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResTheTokenNotEnoughMessage, UIMainMenusPanel.OnEnterPassCheckNotEnough)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResEchoInviteTimeMessage, UIMainMenusPanel.OnResFingerTimeMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLoginMessage, UIMainMenusPanel.OnResLoginMessage)

    UIMainMenusPanel:GetClientEventHandler():AddEvent(CS.CEvent.UpdateOrientationState, UIMainMenusPanel.ResetTweenOriginParameter);
    UIMainMenusPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BreakDeliverPrompting, UIMainMenusPanel.OnBreakDeliverPrompting)
    UIMainMenusPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BuDouKaiStageRefresh, function()
        UIMainMenusPanel.OpenBuDouKaiPanel(true)
    end)
    UIMainMenusPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BuDouKaiDataRefresh, function()
        UIMainMenusPanel.OpenBuDouKaiPanel(false)
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Calendar_OnActivityStateChange, function(id, tblData)
        ---武道会活动结束
        if tblData ~= nil and tblData.activityId == luaEnumActivityTypeByActivityTimeTable.BuDouKai and tblData.status == 2 then
            UIMainMenusPanel.OpenBuDouKaiPanel(false)
        end
    end)

    UIMainMenusPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_OpenPromptUnsatisfyEnterPanel, UIMainMenusPanel.OnOpenPromptUnsatisfyEnterPanelReceived)

    UIMainMenusPanel:GetClientEventHandler():AddEvent(CS.CEvent.UI_MultiItemEffectShowEnd, UIMainMenusPanel.MultiItemEffectShowEndCallBack)
    UIMainMenusPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerBeginWalk, UIMainMenusPanel.MainPlayerBeginWalk)
    UIMainMenusPanel:GetClientEventHandler():AddEvent(CS.CEvent.Scene_EnterSceneAfter, UIMainMenusPanel.RefreshLeftCenterRootPanel)

    UIMainMenusPanel:GetClientEventHandler():AddEvent(CS.CEvent.StartClientReconnect, UIMainMenusPanel.OnStartClientReconnect)

    UIMainMenusPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_OnCalendarActivityStateChange, UIMainMenusPanel.OnCalendarActivityStageChange)

    ---左侧渐入
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainMenus_LeftFadeOut, UIMainMenusPanel.OnFadeOrderReceived)
    ---左侧渐出
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainMenus_LeftFadeIn, UIMainMenusPanel.OnFadeOrderReceived)
    ---右侧渐入
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainMenus_RightFadeIn, UIMainMenusPanel.OnFadeOrderReceived)
    ---右侧渐入
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainMenus_RightFadeOut, UIMainMenusPanel.OnFadeOrderReceived)
    ---全屏特效显示
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.SceneEffect_ShowEffect, UIMainMenusPanel.OnSceneEffectShow)

    -- UIMainMenusPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_SpyInfoChange, UIMainMenusPanel.ChangeSpyInfo)

    UIMainMenusPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_AncientBossWarning_FocusOnEnemy, function(id, targetID)
        if (targetID == nil) then
            return
        end
        --region 远古BOSS
        local isAncientBoss = false;
        local isFind, avater = CS.CSScene.Sington.AvatersID:TryGetValue(targetID);
        if (isFind) then
            if (avater.MonsterTable ~= nil) then
                isAncientBoss = CS.Cfg_AncientBossTableManager.Instance.dic:ContainsKey(avater.MonsterTable.id);
            end
        end
        if (isAncientBoss) then
            if (CS.CSScene.MainPlayerInfo.Level >= CS.Cfg_GlobalTableManager.CfgInstance.AncientBossRankShowNeedLevel) then
                local isopenendTime, endTime = UIMainMenusPanel.GetShowBossRankPanelTimeInfo()
                uimanager:CreatePanel("UIBossRankPanel", nil, { targetBoss = targetID, monsterId = avater.MonsterTable.id, isOpenCountdown = isopenendTime, countdownEndTime = endTime });
            end
        else
            uimanager:ClosePanel("UIBossRankPanel");
        end
        --endregion
    end)

    UIMainMenusPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_EnemyWarning_Clear, function(id, data)
        uimanager:ClosePanel("UIBossRankPanel");
    end)

    ---切换地图完成刷新面板
    UIMainMenusPanel:GetClientEventHandler():AddEvent(CS.CEvent.Scene_EnterSceneAfter, function()
        ---特殊参数面板打开，如果返回是面板名字是任务面板，则调用默认的面板切换规则
        --local specialPanelName = CS.Cfg_GlobalTableManager.Instance:GetPanelNameByParams(CS.CSScene:getMapID(), CS.CSScene.MainPlayerInfo.CalendarInfoV2:GetOpeningActivityIdList())
        local specialPanelName = CS.Cfg_GlobalTableManager.Instance:GetPanelNameByParams(CS.CSScene:getMapID(), gameMgr:GetPlayerDataMgr():GetActivityMgr():GetRunningActivityIdList());
        if specialPanelName ~= "UIMissionPanel" then
            self:ChangeLeftPanel(specialPanelName)
        else
            self:OnResScene_OpenPanel(CS.CSScene:getMapID())
        end
    end)
    ---参与活动变化
    UIMainMenusPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_PlayerActivityChange, function()
        ---@type table<CalendarItem>
        local list = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetRunningActivity()
        local RunningActivityIdTable = {}
        ---@param v CalendarItem
        for i, v in pairs(list) do
            local state, activity = v.ActivityItem:GetRunningState();
            if activity ~= nil and activity.Tbl ~= nil then
                table.insert(RunningActivityIdTable, activity.Tbl:GetId())
            end
        end
        self:ChangeLeftPanel(CS.Cfg_GlobalTableManager.Instance:GetPanelNameByParams(CS.CSScene:getMapID(), RunningActivityIdTable))
    end)

    CS.CSResourceManager.Singleton:AddQueue("700182", CS.ResourceType.UIEffect, nil, CS.ResourceAssistType.UI);
    CS.CSResourceManager.Singleton:AddQueue("700073", CS.ResourceType.UIEffect, nil, CS.ResourceAssistType.UI);
end

function UIMainMenusPanel.SetCameraVolume()

    if CS.CSScene.MainPlayerInfo.ConfigInfo == nil then
        return
    end
    if CS.CSScene.MainPlayerInfo.ConfigInfo:ContainOption(CS.EConfigOption.MapZoom) then
        local value = CS.CSScene.MainPlayerInfo.ConfigInfo:GetFloat(CS.EConfigOption.MapZoom)
        local nowValue = Utility.TransformRange(value, 0, 1, 1.25, 0.75)
        local f = CS.CSGame.Sington.ContentSize.y / 2 * CS.CSScene.SceneScale.y
        if CS.StaticUtility.IsNull(CS.UnityEngine.Camera.main) == false then
            CS.UnityEngine.Camera.main.orthographicSize = f * (nowValue)
        end
    else
        local nowValue = Utility.TransformRange(1, 1.25, 0.75, 0, 1)
        CS.CSScene.MainPlayerInfo.ConfigInfo:SetFloat(CS.EConfigOption.MapZoom, nowValue)
    end
end

---得到boss排行面板时间信息
---@return boolean,number
function UIMainMenusPanel.GetShowBossRankPanelTimeInfo()
    local uiGuildPalaceLeftMainPanel = uimanager:GetPanel("UIGuildPalaceLeftMainPanel")
    if uiGuildPalaceLeftMainPanel == nil then
        return nil, nil
    end
    local endtime = Utility.GetActivitySurplusTime(Utility.GetNowGuildDungeonAtciveID())
    return endtime ~= 0, endtime
end
--endregion

---加载首充特效
function UIMainMenusPanel.LoadRechargeEffect()
    if (CS.CSScene.MainPlayerInfo ~= nil and gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsFirstRecharge() == false) then
        CS.CSResourceManager.Singleton:AddQueue("700186", CS.ResourceType.UIEffect, function(res)
            UIMainMenusPanel.FirstRechargeEffect = res
            res.IsCanBeDelete = false;
        end
        , CS.ResourceAssistType.UI)
    end
end

---加载聊天记录
function UIMainMenusPanel.ReadChatRecord()
    if (CS.System.IO.Directory.Exists(CS.URL.mClientResPath .. "ChatRecord") == false) then
        CS.System.IO.Directory.CreateDirectory(CS.URL.mClientResPath .. "ChatRecord/" .. tostring(CS.CSScene.MainPlayerInfo.ID))
    else
        if (CS.System.IO.Directory.Exists(CS.URL.mClientResPath .. "ChatRecord/" .. tostring(CS.CSScene.MainPlayerInfo.ID)) == false) then
            CS.System.IO.Directory.CreateDirectory(CS.URL.mClientResPath .. "ChatRecord/" .. tostring(CS.CSScene.MainPlayerInfo.ID))
        end
    end

    --所有聊天记录
    local dic = CS.System.IO.Directory.GetFiles(CS.URL.mClientResPath .. "ChatRecord/" .. tostring(CS.CSScene.MainPlayerInfo.ID), "*.txt")
    if (dic.Length == 0) then
        return
    end
    for i = 1, dic.Length do
        --玩家ID作为存储名
        local filename = string.Split(CS.System.IO.Path.GetFileName(dic[i - 1]), ".")
        local res, fileNameInfo = CS.CSScene.MainPlayerInfo.ChatInfoV2.ChatRecordDic:TryGetValue(tonumber(filename[1]))
        if (not res) then
            CS.CSScene.MainPlayerInfo.ChatInfoV2.ChatRecordDic[tonumber(filename[1])] = CS.System.Collections.Generic["List`1[chatV2.ResChat]"]()
        end
        local record = string.Split(CS.FileUtility.ReadToEnd(dic[i - 1]), "&&")
        for k, v in pairs(record) do
            local resChat = CS.chatV2.ResChat()
            if (string.sub(v, 0, 1) == 's') then
                resChat.senderId = CS.CSScene.MainPlayerInfo.ID
                resChat.privateRoleId = tonumber(filename[1])
                resChat.privateName = UIMainMenusPanel.ChatPrivateName
            else
                resChat.senderId = tonumber(filename[1])
                resChat.privateRoleId = CS.CSScene.MainPlayerInfo.ID
                resChat.sendName = UIMainMenusPanel.ChatPrivateName
            end
            resChat.channel = 5
            resChat.message = string.sub(v, 2)
            CS.CSScene.MainPlayerInfo.ChatInfoV2.ChatRecordDic[tonumber(filename[1])]:Add(resChat)
        end
    end
end

---根据角色所在地图ID显示不同面板
function UIMainMenusPanel:OnResScene_OpenPanel(id)
    if (CS.CSScene.Sington:IsOnGoddesMap()) and UIMainMenusPanel.LeftCenterPanelName == "UIGoddessesBlessLeftMianPanel" then
        return
    end
    local params = nil
    local oldPanelName = UIMainMenusPanel.LeftCenterPanelName
    if oldPanelName == nil then
        oldPanelName = ""
    end
    UIMainMenusPanel.LeftCenterPanelName = "UIMissionPanel"
    local isfind, duplicate = CS.Cfg_DuplicateTableManager.Instance.dic:TryGetValue(id);
    if isfind then
        local panelName = CS.Cfg_GlobalTableManager.Instance:GetDuplicatePanelName(duplicate.type)
        if panelName ~= '' then
            UIMainMenusPanel.LeftCenterPanelName = panelName
        end
    end
    if Utility.IsSabacActivityChangeMissionPanel() then
        UIMainMenusPanel.LeftCenterPanelName = "UICityWarTipsPanel"
    end

    --白日门押镖
    if gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar():CheckPlayerHaveOptionDartCar() then
        local operationDartCar = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar():GetFirstOperationDartCar()
        if operationDartCar ~= nil then
            UIMainMenusPanel.LeftCenterPanelName = "UIBrmEscortLeftPanel"
            params = { operationDartCar = operationDartCar }
        end
    end

    if oldPanelName ~= UIMainMenusPanel.LeftCenterPanelName then
        uimanager:ClosePanel(oldPanelName)
        UIMainMenusPanel:AddMainMenuModule(UIMainMenusPanel.LeftCenterPanelName, UIMainMenusPanel:GetLeftDynamicNode(), nil, params)
    end
    --奖励面板逻辑
    local isRevert = UIMainMenusPanel.LeftCenterPanelName == 'UIMissionPanel'
    UIMainMenusPanel.MoveUILvpackPanel(isRevert)
end

---切换面板
function UIMainMenusPanel:ChangeLeftPanel(panelName, params)
    if UIMainMenusPanel.LeftCenterPanelName ~= panelName then
        uimanager:ClosePanel(UIMainMenusPanel.LeftCenterPanelName)
        UIMainMenusPanel:AddMainMenuModule(panelName, UIMainMenusPanel:GetLeftDynamicNode(), nil, params)
        UIMainMenusPanel.LeftCenterPanelName = panelName
        UIMainMenusPanel.MoveUILvpackPanel(false)
    end
end

---根据角色所在副本ID显示不同面板
function UIMainMenusPanel:OnResDuplication_OpenPanel(id)
    local isfind, dupinfo = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(id)
    if (isfind and LuaGlobalTableDeal.IsCountdownCopy(dupinfo.type)) then
        uimanager:CreatePanel("UIDevilSquareCountDownPanel")
    else
        if (uimanager:GetPanel('UIDevilSquareCountDownPanel')) then
            uimanager:ClosePanel("UIDevilSquareCountDownPanel")
        end
    end
end

---UILvPackPanel的操作
function UIMainMenusPanel.MoveUILvpackPanel(isRevert)
    local panel = uimanager:GetPanel('UILvPackPanel')
    if panel and panel.main then
        if panel.leftIconTemplate ~= nil and panel.leftIconTemplate.luaEnuLvPackPanelStage == LuaEnuLvPackPanelStage.LEFTICON then
            return
        end
        if panel.main.activeSelf then
            local x = isRevert and 0 or -1000
            panel.main.transform.localPosition = CS.UnityEngine.Vector3(x, 0, 0)
        end
    end
end

---刷新左中节点下面的面板
function UIMainMenusPanel.RefreshLeftCenterRootPanel(id, data)
    local id = CS.CSScene:getMapID()
    UIMainMenusPanel:OnResScene_OpenPanel(id)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_SECOND_PUSH)
    UIMainMenusPanel:OnResDuplication_OpenPanel(id)


    --[[    --恶魔广场
        if (CS.CSMapManager.Instance.mapInfoTbl ~= nil and CS.CSMapManager.Instance.mapInfoTbl.announceDeliver == 1023) then
            uimanager:CreatePanel("UIDevilSquareCountDownPanel")
        else
            uimanager:ClosePanel("UIDevilSquareCountDownPanel")
        end]]
end

---门票不足弹出快捷购买面板
function UIMainMenusPanel.OnEnterPassCheckNotEnough(id, luaData, csData)
    if (csData ~= nil and csData.conditionId ~= nil and csData.conditionId.Count ~= 0) then
        local isMatch = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(csData.conditionId);
        if isMatch then
            return
        end
        local data = {}
        data.type = LuaEnumUnsatisfyEnterPanelType.Tickets
        data.conditionList = csData.conditionId
        data.mapId = csData.mapId
        uimanager:CreatePanel("UIPromptUnsatisfyEnterPanel", nil, data)
    end
end

---接收打断传送提示消息
function UIMainMenusPanel.OnBreakDeliverPrompting(msgID)
    --二次弹框确认
    --local data = {
    --    Title = "[fbd671]提示",
    --    Content = "[c9b39c]英雄，前方战事凶猛，确定要退出副本吗",
    --    CallBack = function()
    --        CS.CSScene.MainPlayerInfo.DeliverInfoV2.IsBreak = false
    --        networkRequest.ReqDeliverByConfig(CS.CSScene.MainPlayerInfo.DeliverInfoV2.DeliverId,
    --                CS.CSScene.MainPlayerInfo.DeliverInfoV2.IsStone)
    --    end
    --}
    --uimanager:CreatePanel("UIPromptPanel", nil, data)
    CS.CSScene.MainPlayerInfo.DeliverInfoV2.IsBreak = false
    networkRequest.ReqDeliverByConfig(CS.CSScene.MainPlayerInfo.DeliverInfoV2.DeliverId,
            CS.CSScene.MainPlayerInfo.DeliverInfoV2.IsStone)
end

function UIMainMenusPanel.OpenBuDouKaiPanel(changeStage)
    ---@type LuaActivityItem
    local ActivityItem = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetCalendarActivity(LuaEnumDailyActivityType.WuDaoHui)
    local runningState, activityItemSubInfo = ActivityItem:GetRunningState()
    local buDouKaiIsOpen = (runningState == LuaActivityRunningState.IsRunning)
    local buDouKaiStage = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.BudowillInfo.mBuDouKaiStage)
    if buDouKaiIsOpen == false or buDouKaiStage == luaEnumBuDouKaiStage.FINALOVERR then
        UIMainMenusPanel:ChangeLeftPanel("UIMissionPanel")
    else
        if LuaGlobalTableDeal.IsWuDaoHuiMapId(CS.CSScene:getMapID()) then
            local UIBuDouKaiPanel = uimanager:GetPanel("UIBuDouKaiPanel")
            if UIBuDouKaiPanel ~= nil then
                if changeStage == true then
                    UIBuDouKaiPanel:Show()
                else
                    UIBuDouKaiPanel:RefreshData()
                end
            else
                UIMainMenusPanel:ChangeLeftPanel("UIBuDouKaiPanel")
            end
        end
    end

    local transferArenaInfo = CS.CSScene.MainPlayerInfo.BudowillInfo.TransferArenaInfo
    if transferArenaInfo ~= nil then
        local BuDouKaiStage = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.BudowillInfo.mBuDouKaiStage)
        if BuDouKaiStage == luaEnumBuDouKaiStage.PROMOTION or BuDouKaiStage == luaEnumBuDouKaiStage.FINAL then
            networkRequest.ReqMapCommon(LuaEnumCommonMapMsgType.BUDOUKAIREQ_TRANSFER, transferArenaInfo.data, transferArenaInfo.str)
            CS.CSScene.MainPlayerInfo.BudowillInfo:ClearTransferArenaInfo()
            uimanager:ClosePanel("UIPromptPanel")
        end
    end
end

function UIMainMenusPanel.OnCalendarActivityStageChange()
    ---武道会
    if uimanager:GetPanel("UIBuDouKaiPanel") ~= nil then
        local ActivityItem = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetCalendarActivity(LuaEnumDailyActivityType.WuDaoHui)
        local runningState, activityItemSubInfo = ActivityItem:GetRunningState()
        local buDouKaiIsOpen = (runningState == LuaActivityRunningState.IsRunning)
        if buDouKaiIsOpen == false then
            UIMainMenusPanel:ChangeLeftPanel("UIMissionPanel")
        end
    end
end

---接收到门票消息
---@param eventID
---@param data mapV2.ResTheTokenNotEnough
function UIMainMenusPanel.OnOpenPromptUnsatisfyEnterPanelReceived(eventID, data)
    UIMainMenusPanel.OnEnterPassCheckNotEnough(nil, nil, data)
end

--region MainMens接受事件,打开不同界面
function UIMainMenusPanel:OnResScene_EnterSceneAfter()
    if (CS.CSScene.MainPlayerInfo.HP <= 0) then
        self:OnResDeathEvent()
    end
end

--- 接受主角更新血量
--function UIMainMenusPanel:OnMainPlayerDead()
--    if (CS.CSAutoFightMgr.Instance ~= null) then
--        CS.CSAutoFightMgr.Instance:Toggle(false);
--     end
--     uimanager:CreatePanel("UIDeadGrayPanel", nil)
--end
--endregion

--region Method
---检查是否所以界面都已打开,若都已打开，则发送主界面加载完毕消息
function UIMainMenusPanel.CheckIsAllPanelOpened()
    if UIMainMenusPanel.IsWaitForAllPanelStartLoad then
        return
    end
    if Utility.GetTableCount(UIMainMenusPanel.WaitForPanelOpenedTbl) == 0 then
        UIMainMenusPanel:GetClientEventHandler():SendEvent(CS.CEvent.V2_MainPanelLoadFinished, nil)
        UIMainMenusPanel.IsOpenPanelFinished = true
    end
end

---主界面加载完毕事件
function UIMainMenusPanel:OnAllMainPanelOpened()
    self:InitializeAllMainHints()
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        ---@type LuaSynthesisMgr
        gameMgr:GetPlayerDataMgr():GetSynthesisMgr():InitData();

        ---初始化Boss数据
        CS.CSScene.MainPlayerInfo.BossInfoV2:Initialize();
        --if (CS.CSScene.MainPlayerInfo ~= nil) then
        --    CS.CSScene.MainPlayerInfo.CalendarInfoV2:TryInitializeCalendar(function()
        --        luaEventManager.DoCallback(LuaCEvent.Calendar_OnHeartBeatInitCalendar);
        --    end);
        --end
    end
end

---初始化所有主界面提示
function UIMainMenusPanel:InitializeAllMainHints()
    if uiStaticParameter.MainHintPanel then
        local mainChatPanel = uimanager:GetPanel("UIMainChatPanel")
        if mainChatPanel and CS.StaticUtility.IsNull(mainChatPanel.btn_bag) == false then
            ---初始化更好的背包物品提示
            uiStaticParameter.MainHintPanel:CreateHintInPosition(LuaEnumMainHintType.BetterBagItem, mainChatPanel.btn_bag.transform.position)
            ---初始化背包物品回收提示
            uiStaticParameter.MainHintPanel:CreateHintInPosition(LuaEnumMainHintType.RecycleBagItemTips, mainChatPanel.btn_bag.transform.position)
            ---初始化更好的背包物品提示（高等级）
            uiStaticParameter.MainHintPanel:CreateHintInPosition(LuaEnumMainHintType.BetterBagItem_HighLv, mainChatPanel.btn_bag.transform.position)
            ---初始化宝箱使用提示（高等级）
            uiStaticParameter.MainHintPanel:CreateHintInPosition(LuaEnumMainHintType.SpecialBoxUseHint, mainChatPanel.btn_bag.transform.position)
            ---初始化大聚灵珠推荐购买提示
            --uiStaticParameter.MainHintPanel:CreateHintInPosition(LuaEnumMainHintType.BigJuLingZhuRecommendBuy, mainChatPanel.btn_bag.transform.position)
        end
        --[[
        local navigationPanel = uimanager:GetPanel("UINavigationPanel")
        if navigationPanel and CS.StaticUtility.IsNull(navigationPanel:GetNavViewTemplate():GetBtnOpen_GameObject()) == false then
            ---初始化技能可学提示
            uiStaticParameter.MainHintPanel:CreateHintWithGameObject(LuaEnumMainHintType.SkillLearningAvailableTips, navigationPanel:GetNavViewTemplate():GetBtnOpen_GameObject())
        end
        ]]
    end
end

function UIMainMenusPanel.ChangeSpyInfo()
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    if CS.CSScene.MainPlayerInfo.mSpyInfo == nil then
        return
    end
    if CS.CSScene.MainPlayerInfo.mSpyInfo.isSpy == 1 then
        uimanager:CreatePanel("UISpyPanel")
    else
        uimanager:ClosePanel('UISpyPanel')
    end
end
--endregion

--region Public Method

function UIMainMenusPanel.ResetTweenOriginParameter()
    --region 起始坐标
    UIMainMenusPanel.mLeftDownNodeOriginPosition = UIMainMenusPanel:GetDownLeftDynamicNode().localPosition;
    UIMainMenusPanel.mLeftNodeOriginPosition = UIMainMenusPanel:GetLeftDynamicNode().localPosition;
    UIMainMenusPanel.mLeftTopOriginPosition = UIMainMenusPanel:GetTopLeftDynamicNode().localPosition;

    UIMainMenusPanel.mRightDownNodeOriginPosition = UIMainMenusPanel:GetDownRightDynamicNode().localPosition;
    UIMainMenusPanel.mRightNodeOriginPosition = UIMainMenusPanel:GetRightDynamicNode().localPosition;
    UIMainMenusPanel.mRightTopOriginPosition = UIMainMenusPanel:GetTopRightDynamicNode().localPosition;
    --endregion
end

function UIMainMenusPanel.OnFadeOrderReceived(msgId, panelName)

    if (UIMainMenusPanel.mFadeOrderQueue == nil) then
        UIMainMenusPanel.mFadeOrderQueue = {};
    end

    local customData = {};
    customData.msgId = msgId;
    customData.panelName = panelName;
    table.insert(UIMainMenusPanel.mFadeOrderQueue, 1, customData);

    if (UIMainMenusPanel.mCoroutineDelayFade == nil) then
        UIMainMenusPanel.mCoroutineDelayFade = StartCoroutine(UIMainMenusPanel.IEnumDelayFade);
    end

    --if (UIMainMenusPanel.mCoroutineDelayFade ~= nil) then
    --    StopCoroutine(UIMainMenusPanel.mCoroutineDelayFade);
    --    UIMainMenusPanel.mCoroutineDelayFade = nil;
    --end
    --UIMainMenusPanel.mCoroutineDelayFade = StartCoroutine(UIMainMenusPanel.IEnumDelayFade);
end

function UIMainMenusPanel.IEnumDelayFade()
    coroutine.yield(0);
    if (UIMainMenusPanel.mFadeOrderQueue ~= nil) then
        if (#UIMainMenusPanel.mFadeOrderQueue > 0 and UIMainMenusPanel.mIsInitEnd) then
            local type = UIMainMenusPanel.mFadeOrderQueue[1].msgId;
            local panelName = UIMainMenusPanel.mFadeOrderQueue[1].panelName;
            if (UIMainMenusPanel.mFadeOutPanels == nil) then
                UIMainMenusPanel.mFadeOutPanels = {};
            end
            if (type == LuaCEvent.MainMenus_RightFadeIn) then
                if (UIMainMenusPanel.TryFadeIn(panelName)) then
                    UIMainMenusPanel.PlayRightNodeFadeIn();
                end
            elseif (type == LuaCEvent.MainMenus_RightFadeOut) then
                UIMainMenusPanel.PlayRightNodeFadeOut();
                table.insert(UIMainMenusPanel.mFadeOutPanels, panelName);
            elseif (type == LuaCEvent.MainMenus_LeftFadeIn) then
                if (UIMainMenusPanel.TryFadeIn(panelName)) then
                    UIMainMenusPanel.PlayLeftNodeFadeIn();
                end
            elseif (type == LuaCEvent.MainMenus_LeftFadeOut) then
                UIMainMenusPanel.PlayLeftNodeFadeOut();
                table.insert(UIMainMenusPanel.mFadeOutPanels, panelName);
            end
        end
    end
    UIMainMenusPanel.mFadeOrderQueue = nil;
    StopCoroutine(UIMainMenusPanel.mCoroutineDelayFade);
    UIMainMenusPanel.mCoroutineDelayFade = nil;
end

function UIMainMenusPanel.TryFadeIn(panelName)
    for k, v in pairs(UIMainMenusPanel.mFadeOutPanels) do
        local panel = uimanager:GetPanel(v);
        if (panel ~= nil) then
            if (not CS.StaticUtility.IsNull(panel.go) and panel.go.activeSelf) then
                return false;
            end
        end
    end

    for k, v in pairs(UIMainMenusPanel.mFadeOutPanels) do
        if (v == panelName) then
            table.remove(UIMainMenusPanel.mFadeOutPanels, k);
            break ;
        end
    end
    return true;
end

---左侧渐入
function UIMainMenusPanel.PlayLeftNodeFadeIn()

    if CS.StaticUtility.IsNull((UIMainMenusPanel:GetTopLeftDynamicNode()) or CS.StaticUtility.IsNull(UIMainMenusPanel:GetLeftDynamicNode()) or CS.StaticUtility.IsNull(UIMainMenusPanel:GetDownLeftDynamicNode())) then
        return ;
    end

    UIMainMenusPanel:GetLeftDynamicNode().gameObject:SetActive(true);
    UIMainMenusPanel:GetTopLeftDynamicNode().gameObject:SetActive(true);
    UIMainMenusPanel:GetDownLeftDynamicNode().gameObject:SetActive(true);

    --region 左上
    local leftTopStartPosition = UIMainMenusPanel:GetTopLeftDynamicNode().localPosition;
    local leftTopEndPosition = UIMainMenusPanel.mLeftTopOriginPosition;
    UIMainMenusPanel.mLeftTopRootTweenPosition.from = leftTopStartPosition;
    UIMainMenusPanel.mLeftTopRootTweenPosition.to = leftTopEndPosition;
    UIMainMenusPanel.PlayTween(UIMainMenusPanel.mLeftTopRootTweenPosition, leftTopStartPosition, leftTopEndPosition);

    local leftTopStartAlpha = 0;
    local leftTopEndAlpha = 1;
    UIMainMenusPanel.mLeftTopRootTweenAlpha.from = leftTopStartAlpha;
    UIMainMenusPanel.mLeftTopRootTweenAlpha.to = leftTopEndAlpha;
    UIMainMenusPanel.PlayTween(UIMainMenusPanel.mLeftTopRootTweenAlpha, leftTopStartAlpha, leftTopEndAlpha);
    --endregion

    --region 左中
    local leftStartPosition = UIMainMenusPanel:GetLeftDynamicNode().localPosition;
    local leftEndPosition = UIMainMenusPanel.mLeftNodeOriginPosition;
    UIMainMenusPanel.PlayTween(UIMainMenusPanel.mLeftRootTweenPosition, leftStartPosition, leftEndPosition)

    local leftStartAlpha = 0;
    local leftEndAlpha = 1;
    UIMainMenusPanel.PlayTween(UIMainMenusPanel.mLeftRootTweenAlpha, leftStartAlpha, leftEndAlpha)
    --endregion

    --region 左下
    local leftDownStartPosition = UIMainMenusPanel:GetDownLeftDynamicNode().localPosition;
    local leftDownEndPosition = UIMainMenusPanel.mLeftDownNodeOriginPosition;
    UIMainMenusPanel.PlayTween(UIMainMenusPanel.mLeftDownRootTweenPosition, leftDownStartPosition, leftDownEndPosition)

    local leftDownStartAlpha = 0;
    local leftDownEndAlpha = 1;
    UIMainMenusPanel.PlayTween(UIMainMenusPanel.mLeftDownRootTweenAlpha, leftDownStartAlpha, leftDownEndAlpha)

    --endregion
end

---左侧渐出
function UIMainMenusPanel.PlayLeftNodeFadeOut()

    --UIMainMenusPanel.ResetTweenOriginParameter();

    if (not UIMainMenusPanel.mIsInitEnd) then
        UIMainMenusPanel:GetLeftDynamicNode().gameObject:SetActive(false);
        UIMainMenusPanel:GetTopLeftDynamicNode().gameObject:SetActive(false);
        UIMainMenusPanel:GetDownLeftDynamicNode().gameObject:SetActive(false);
        return ;
    end

    --region 左上
    local leftTopStartPosition = UIMainMenusPanel.mLeftTopOriginPosition;
    local leftTopEndPosition = CS.UnityEngine.Vector3(
            leftTopStartPosition.x - UIMainMenusPanel.mLeftTweenDistance,
            leftTopStartPosition.y, leftTopStartPosition.x);
    UIMainMenusPanel.mLeftTopRootTweenPosition.from = leftTopStartPosition;
    UIMainMenusPanel.mLeftTopRootTweenPosition.to = leftTopEndPosition;
    UIMainMenusPanel.PlayTween(UIMainMenusPanel.mLeftTopRootTweenPosition, leftTopStartPosition, leftTopEndPosition);

    local leftTopStartAlpha = 1;
    local leftTopEndAlpha = 0;
    UIMainMenusPanel.mLeftTopRootTweenAlpha.from = leftTopStartAlpha;
    UIMainMenusPanel.mLeftTopRootTweenAlpha.to = leftTopEndAlpha;
    UIMainMenusPanel.PlayTween(UIMainMenusPanel.mLeftTopRootTweenAlpha, leftTopStartAlpha, leftTopEndAlpha);
    --endregion

    --region 左中
    --local leftStartPosition = UIMainMenusPanel.mLeftNodeOriginPosition;
    --local leftEndPosition = CS.UnityEngine.Vector3(
    --        leftStartPosition.x - UIMainMenusPanel.mLeftTweenDistance,
    --        leftStartPosition.y, leftStartPosition.z);
    --
    --UIMainMenusPanel.PlayTween(UIMainMenusPanel.mLeftRootTweenPosition, leftStartPosition, leftEndPosition)

    local leftStartAlpha = 1;
    local leftEndAlpha = 0;

    --UIMainMenusPanel.PlayTween(UIMainMenusPanel.mLeftRootTweenAlpha, leftStartAlpha, leftEndAlpha)
    --endregion

    --region 左下
    --local leftDownStartPosition = UIMainMenusPanel.mLeftDownNodeOriginPosition
    --local leftDownEndPosition = CS.UnityEngine.Vector3(
    --        leftDownStartPosition.x - UIMainMenusPanel.mLeftTweenDistance,
    --        leftDownStartPosition.y, leftDownStartPosition.z);
    --UIMainMenusPanel.PlayTween(UIMainMenusPanel.mLeftDownRootTweenPosition, leftDownStartPosition, leftDownEndPosition)
    --
    --local leftDownStartAlpha = 1;
    --local leftDownEndAlpha = 0;
    --UIMainMenusPanel.PlayTween(UIMainMenusPanel.mLeftDownRootTweenAlpha, leftDownStartAlpha, leftDownEndAlpha)
    --endregion
end

---右侧渐入
function UIMainMenusPanel.PlayRightNodeFadeIn()

    UIMainMenusPanel:GetTopRightDynamicNode().gameObject:SetActive(true);
    UIMainMenusPanel:GetDownRightDynamicNode().gameObject:SetActive(true);
    UIMainMenusPanel:GetRightDynamicNode().gameObject:SetActive(true);

    --region 右上
    local rightTopStartPosition = UIMainMenusPanel:GetTopRightDynamicNode().localPosition;
    local rightTopEndPosition = UIMainMenusPanel.mRightTopOriginPosition;
    UIMainMenusPanel.PlayTween(UIMainMenusPanel.mRightTopRootTweenPosition, rightTopStartPosition, rightTopEndPosition)

    local rightTopStartAlpha = 0;
    local rightTopEndAlpha = 1;
    UIMainMenusPanel.PlayTween(UIMainMenusPanel.mRightTopRootTweenAlpha, rightTopStartAlpha, rightTopEndAlpha)
    --endregion

    --region 右下
    local rightDownStartPosition = UIMainMenusPanel:GetRightDynamicNode().transform.localPosition;
    local rightDownEndPosition = UIMainMenusPanel.mRightDownNodeOriginPosition;
    UIMainMenusPanel.PlayTween(UIMainMenusPanel.mRightDownRootTweenPosition, rightDownStartPosition, rightDownEndPosition)

    local rightDownStartAlpha = 0;
    local rightDownEndAlpha = 1;
    UIMainMenusPanel.PlayTween(UIMainMenusPanel.mRightDownRootTweenAlpha, rightDownStartAlpha, rightDownEndAlpha)
    --endregion
end

---右侧渐出
function UIMainMenusPanel.PlayRightNodeFadeOut()

    --UIMainMenusPanel.ResetTweenOriginParameter();

    if (not UIMainMenusPanel.mIsInitEnd) then
        UIMainMenusPanel:GetDownRightDynamicNode().gameObject:SetActive(false);
        UIMainMenusPanel:GetRightDynamicNode().gameObject:SetActive(false);
        UIMainMenusPanel:GetTopRightDynamicNode().gameObject:SetActive(false);
        return ;
    end

    --region 右上
    local rightTopStartPosition = UIMainMenusPanel.mRightTopOriginPosition;
    local rightTopEndPosition = CS.UnityEngine.Vector3(
            rightTopStartPosition.x + UIMainMenusPanel.mRightTweenDistance,
            rightTopStartPosition.y,
            rightTopStartPosition.z);
    UIMainMenusPanel.PlayTween(UIMainMenusPanel.mRightTopRootTweenPosition, rightTopStartPosition, rightTopEndPosition)

    local rightTopStartAlpha = 1;
    local rightTopEndAlpha = 0;
    UIMainMenusPanel.PlayTween(UIMainMenusPanel.mRightTopRootTweenAlpha, rightTopStartAlpha, rightTopEndAlpha)
    --endregion

    --region 右下
    local rightDownStartPosition = UIMainMenusPanel.mRightDownNodeOriginPosition
    local rightDownEndPosition = CS.UnityEngine.Vector3(
            rightDownStartPosition.x + UIMainMenusPanel.mRightTweenDistance,
            rightDownStartPosition.y,
            rightDownStartPosition.z);
    UIMainMenusPanel.PlayTween(UIMainMenusPanel.mRightDownRootTweenPosition, rightDownStartPosition, rightDownEndPosition)

    local rightDownStartAlpha = 1;
    local rightDownEndAlpha = 0;
    UIMainMenusPanel.PlayTween(UIMainMenusPanel.mRightDownRootTweenAlpha, rightDownStartAlpha, rightDownEndAlpha)
    --endregion
end

--endregion

--region 播放动画
function UIMainMenusPanel.PlayTween(tweenObj, fromPos, toPos)
    if tweenObj and CS.StaticUtility.IsNull(tweenObj) == false then
        tweenObj.from = fromPos
        tweenObj.to = toPos
        tweenObj:PlayTween()
    end
end
--endregion

--region 特效

--region UI屏幕特效

UIMainMenusPanel.EffectShowList = {}

UIMainMenusPanel.mIenumShowScemeEffect = nil

function UIMainMenusPanel.InitEffectTime()
    --UIMainMenusPanel.effectTime = CS.Cfg_GlobalTableManager.Instance.effectTime
end

function UIMainMenusPanel.OnSceneEffectShow(id, data)
    if data and data.sceneEffectId then
        UIMainMenusPanel.EffectShowList = {}
        table.insert(UIMainMenusPanel.EffectShowList, data)
    end
    if #UIMainMenusPanel.EffectShowList == 0 then
        return
    end
    if UIMainMenusPanel.mIenumShowScemeEffect ~= nil then
        StopCoroutine(UIMainMenusPanel.mIenumShowScemeEffect)
        UIMainMenusPanel.mIenumShowScemeEffect = nil
    end
    UIMainMenusPanel.mIenumShowScemeEffect = StartCoroutine(UIMainMenusPanel.IEnumSceneEffectShow)
end

function UIMainMenusPanel.IEnumSceneEffectShow()
    local curCount = 0
    local time = 1
    for k, v in pairs(UIMainMenusPanel.EffectShowList) do
        curCount = v.showCount == nil and 0 or v.showCount
        local isfind
        isfind, time = CS.Cfg_GlobalTableManager.Instance.effectTimeOfItemDIc:TryGetValue(v.showFlowerId)
        for i = 1, curCount do
            Utility.ShowScreenEffect(v.sceneEffectId)
            v.showCount = v.showCount - 1
            coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(time))
        end
        table.remove(UIMainMenusPanel.EffectShowList, k)
    end
end

--endregion

--region 场景特效

function UIMainMenusPanel.MainPlayerBeginWalk()
    uiStaticParameter.isCanCallBackHide = false
end

function UIMainMenusPanel.MultiItemEffectShowEndCallBack(msgId, effectId)
    ---烟花特效
    if effectId == 4000009 then
        local panel = uimanager:GetPanel("UIBattleDreamlandPanel")
        if uiStaticParameter.isHideFireworkPanel and uiStaticParameter.isCanCallBackHide then
            if panel then
                uiStaticParameter.isHideFireworkPanel = false
                return
            else
                local isFind, panelParams = CS.Cfg_NpcTableManager.Instance.OpenPanelParams:TryGetValue(63)
                if isFind then
                    local info = {}
                    for i = 0, panelParams.Length - 1 do
                        table.insert(info, panelParams[i])
                    end
                    uimanager:CreatePanel("UIBattleDreamlandPanel", nil, table.unpack(info))
                end
            end
        else
            if panel == nil then
                UIMainMenusPanel.ShowFirworkPromptTips()
            end
        end
    end
end

---烟花特效回调（显示烟花tips）
function UIMainMenusPanel.ShowFirworkPromptTips()
    local mapId = CS.CSScene.getMapID()
    local isLangyanmengjing = CS.Cfg_GlobalTableManager.Instance:IsLangYanMengJingMap(mapId)
    if isLangyanmengjing then
        return
    end
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20414)
    local str = info.value
    str = string.Split(str, '#')
    if isFind then
        local panel = uimanager:GetPanel('UIPromptPanel')
        local temp = {}
        temp.Title = ''
        temp.Content = str[1]
        --temp.LeftDescription = str[2]
        temp.RightDescription = str[3]
        temp.IsClose = false
        temp.CallBack = function()
            CS.CSScene.MainPlayerInfo.AsyncOperationController.LangYanMengJingDeliverAndOpenPanelOperation:DoOperation(tonumber(str[4]), 2, tonumber(str[5]))
            uimanager:ClosePanel('UIPromptPanel')
        end
        if panel then
            panel:Show(temp)
        else
            uimanager:CreatePanel("UIPromptPanel", nil, temp)
        end
    end
end
--endregion

--endregion

--region 猜拳
function UIMainMenusPanel.OnResFingerTimeMessage(msgID, tblData)
    if tblData then

        local id = tblData.isDeliver == 0 and 100 or 101
        local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(id)
        if isFind then
            local unit = {}
            unit.Content = string.format(info.des, tblData.dealerName)
            unit.LeftDescription = info.leftButton
            unit.Time = tblData.limitTime
            unit.CallBack = function()
                Utility.RemoveFlashPrompt(2, tblData.dealerId)
                networkRequest.ReqEchoInvite(tblData.dealerId, 1)
            end
            unit.CancelCallBack = function()
                Utility.RemoveFlashPrompt(2, tblData.dealerId)
                networkRequest.ReqEchoInvite(tblData.dealerId, 0)
            end

            ---@param countDown UICountdownLabel
            unit.TimeCallBack = function(countDown)
                countDown:StartCountBySecond(nil, 7, math.ceil(tblData.limitTime / 1000), luaEnumColorType.TimeCountRed, "后操作无效[-]", nil, function()
                    uimanager:ClosePanel('UIPromptPanel')
                end)
            end

            local panel = uimanager:GetPanel("UIPromptPanel")
            if panel then
                panel:Show(unit)
            else
                uimanager:CreatePanel("UIPromptPanel", nil, unit)
            end
        end
    end
end

--endregion

--region ondestroy
function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResAnnounceMessage, UIMainMenusPanel.ResAnnounceMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResEchoInviteTimeMessage, UIMainMenusPanel.OnResFingerTimeMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResTheTokenNotEnoughMessage, UIMainMenusPanel.OnEnterPassCheckNotEnough)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResLoginMessage, UIMainMenusPanel.OnResLoginMessage)

    --luaEventManager.RemoveCallback(LuaCEvent.MainMenus_LeftFadeOut, UIMainMenusPanel.OnFadeOrderReceived);
    --luaEventManager.RemoveCallback(LuaCEvent.MainMenus_LeftFadeIn, UIMainMenusPanel.OnFadeOrderReceived);
    --luaEventManager.RemoveCallback(LuaCEvent.MainMenus_RightFadeIn, UIMainMenusPanel.OnFadeOrderReceived);
    --luaEventManager.RemoveCallback(LuaCEvent.MainMenus_RightFadeOut, UIMainMenusPanel.OnFadeOrderReceived);
    --luaEventManager.RemoveCallback(LuaCEvent.SceneEffect_ShowEffect, UIMainMenusPanel.OnSceneEffectShow)

    if (UIMainMenusPanel.mCoroutineDelayFade ~= nil) then
        StopCoroutine(UIMainMenusPanel.mCoroutineDelayFade)
        UIMainMenusPanel.mCoroutineDelayFade = nil
    end
    if UIMainMenusPanel.mIenumShowScemeEffect ~= nil then
        StopCoroutine(UIMainMenusPanel.mIenumShowScemeEffect)
        UIMainMenusPanel.mIenumShowScemeEffect = nil
    end
    if UIMainMenusPanel.updateItem ~= nil and CS.CSListUpdateMgr.Instance ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(UIMainMenusPanel.updateItem)
        UIMainMenusPanel.updateItem = nil
    end
end
--endregion

--region 服务器消息响应
--region 公告响应
---@param tblData chatV2.ResAnnounce
---@param csData chatV2.ResAnnounce
function UIMainMenusPanel.ResAnnounceMessage(netMsgID, tblData, csData)
    table.insert(UIMainMenusPanel.AnnounceTable, tblData)
end

---处理公告响应
---@param tblData chatV2.ResAnnounce
function UIMainMenusPanel.RespondAnnounceMessage(tblData)
    if tblData == nil then
        return
    end
    if (tblData.timeType == 1) then
        if (not CS.CSAnnounceInfoV2.CheckAnnounceIsShield(tblData.params[1], tonumber(tblData.param) / 1000)) then
            return ;
        end
    end
    local id = 0
    if (tblData.params ~= nil) then
        id = tonumber(tblData.params[1])
        table.remove(tblData.params, 1)--移除第一项 因服务器原因 首项为ID
    end
    local specialinclude = false
    if (tblData ~= nil and tblData.mapId ~= nil) then
        specialinclude = CS.Utility_Lua.IsShowAnnounceWithLevel(tblData.mapId)---新手期特殊处理
    end
    if (tblData.mapId ~= nil and #tblData.mapId ~= 0) then
        local include = false;
        for k, v in pairs(tblData.mapId) do
            if (v == CS.CSScene.MainPlayerInfo.MapID) then
                include = true
            end
        end

        if (include or specialinclude) then
        else
            return
        end
    end
    if (tblData.alwaysSeen == 0) then
        if (CS.Utility_Lua.IsShowAnnounce() or specialinclude) then
            if (tblData.seenType ~= 1 and CS.CSScene.MainPlayerInfo.Level < CS.Cfg_GlobalTableManager.Instance.DropAnnounceSpecialAllCanSeeLevel) then
                return
            end
        end
        if (not CS.Utility_Lua.IsShowAnnounce()) then
            if (tblData.seenType == 1) then
                return
            end
        end
    end

    --region 等级转生条件
    local levelbool = false
    local reinbool = false
    if ((tblData.minRein ~= nil and tblData.minRein <= CS.CSScene.MainPlayerInfo.ReinLevel) and (tblData.maxRein ~= nil and tblData.maxRein >= CS.CSScene.MainPlayerInfo.ReinLevel)) then
        reinbool = true
    end
    if ((tblData.minLevel ~= nil and tblData.minLevel ~= 0 and tblData.minLevel <= CS.CSScene.MainPlayerInfo.Level) and (tblData.maxLevel ~= nil and tblData.maxLevel ~= 0 and tblData.maxLevel >= CS.CSScene.MainPlayerInfo.Level)) then
        levelbool = true
    end
    --if (tblData.minRein == nil or tblData.minRein == 0) then
    --    reinbool = true
    --end
    if (tblData.minLevel == nil or tblData.minLevel == 0) then
        levelbool = true
    end
    if (reinbool or levelbool) then
    else
        return
    end
    --endregion
    local str = tblData.announce
    if (tblData.params ~= nil) then
        str = CS.Utility_Lua.ParseAnnouncement(tblData.announce, tblData.params)
        if (str == nil) then
            return
        end
    end

    if (id == 502 or id == 504) then
        --掉落公告特殊需求：根据重复ID，屏蔽部分公告
        local needRoleLevel = CS.Cfg_GlobalTableManager.Instance.DropAnnounceLimitLevel;
        local needServerDay = CS.Cfg_GlobalTableManager.Instance.DropAnnounceLimitServerDay;
        local RepetitiveItemCount = CS.Cfg_GlobalTableManager.Instance.DropAnnounceLimitRepetitiveItemCount;
        local itemid = 0
        local itemcount = 0
        local mapid = 0
        if tblData.monsterTypeSpecified and tblData.monsterLevelSpecified and
                LuaGlobalTableDeal:IsPlayerLevelAndMonsterTypeLevelConfirmToAnnounce(CS.CSScene.MainPlayerInfo.Level,
                        tblData.monsterType, tblData.monsterLevel) then
            ---如果玩家等级、怪物类型和等级均处于需要被屏蔽的范围内,则屏蔽该怪物掉落公告
            return
        end
        if (id == 502) then
            ---普通掉落
            if (#tblData.params >= 11) then
                local tem = tblData.params[11]:Split('#')
                if (Utility.GetLuaTableCount(tem) >= 2) then
                    itemid = tonumber(tem[1])
                    itemcount = tonumber(tem[2])
                    mapid = tonumber(tblData.params[6])
                end
            end
        elseif (id == 504) then
            ---0-40级新手掉落
            if (#tblData.params >= 7) then
                local tem = tblData.params[7]:Split('#')
                if (Utility.GetLuaTableCount(tem) >= 2) then
                    itemid = tonumber(tem[1])
                    itemcount = tonumber(tem[2])
                end
            end
        end
        ---@type TABLE.CFG_ITEMS item信息
        local itemtab = CS.Cfg_ItemsTableManager.Instance:GetItems(itemid)
        ---转生凭证特殊处理，全等级阶段屏蔽，30轮出现一次
        if (itemtab.id == 6070001) then
            if (UIMainMenusPanel.ReinItemCount ~= 0) then
                UIMainMenusPanel.ReinItemCount = UIMainMenusPanel.ReinItemCount + 1
                if (UIMainMenusPanel.ReinItemCount == 15) then
                    UIMainMenusPanel.ReinItemCount = 0
                end
                return
            else
                UIMainMenusPanel.ReinItemCount = UIMainMenusPanel.ReinItemCount + 1
            end
        end
        ---转升等级大于0的装备不进行屏蔽
        if (itemtab ~= nil and itemtab.type == luaEnumItemType.Equip and itemtab.reinLv > 0) then
        else
            if (needRoleLevel >= CS.CSScene.MainPlayerInfo.Level and needServerDay >= CS.CSScene.MainPlayerInfo.OpenServerDayNumber) then
                if (UIMainMenusPanel.mDropAnnounceRepetitiveItemList:Contains(itemid)) then
                    UIMainMenusPanel.mDropAnnounceRepetitiveItemList:Remove(itemid)
                    UIMainMenusPanel.mDropAnnounceRepetitiveItemList:Add(itemid)
                    return
                else
                    if (UIMainMenusPanel.mDropAnnounceRepetitiveItemList.Count >= RepetitiveItemCount and UIMainMenusPanel.mDropAnnounceRepetitiveItemList) then
                        UIMainMenusPanel.mDropAnnounceRepetitiveItemList:RemoveAt(0)
                    end
                    UIMainMenusPanel.mDropAnnounceRepetitiveItemList:Add(itemid)
                end
            end
        end
        if (itemid == LuaEnumAuctionTradeCoinSortType.YuanBao and CS.Cfg_GlobalTableManager.Instance.DropAnnounceRepetitionItemCount ~= 0) then
            if (CS.Cfg_GlobalTableManager.CfgInstance:IsLangYanMengJingMap(mapid)) then
                if (itemcount >= CS.Cfg_GlobalTableManager.Instance.DropAnnounceRepetitionMinCount and itemcount <= CS.Cfg_GlobalTableManager.Instance.DropAnnounceRepetitionMaxCount) then
                    if (UIMainMenusPanel.DropAnnounceShieldCount == 0 or (UIMainMenusPanel.DropAnnounceShieldCount >= CS.Cfg_GlobalTableManager.Instance.DropAnnounceRepetitionItemCount)) then
                        --完成一次循环屏蔽后，将条件置0
                        UIMainMenusPanel.DropAnnounceShieldCount = 1
                    else
                        UIMainMenusPanel.DropAnnounceShieldCount = UIMainMenusPanel.DropAnnounceShieldCount + 1
                        return
                    end
                end
            elseif (CS.Cfg_GlobalTableManager.CfgInstance:IsShengYuKongJianMap(mapid)) then
                if (itemcount >= CS.Cfg_GlobalTableManager.Instance.DropAnnounceRepetitionMinCountInShengYu and itemcount <= CS.Cfg_GlobalTableManager.Instance.DropAnnounceRepetitionMaxCountInShengYu) then
                    if (UIMainMenusPanel.DropAnnounceShieldCountInShengYu == 0 or (UIMainMenusPanel.DropAnnounceShieldCountInShengYu >= CS.Cfg_GlobalTableManager.Instance.DropAnnounceRepetitionItemCountInShengYu)) then
                        --完成一次循环屏蔽后，将条件置0
                        UIMainMenusPanel.DropAnnounceShieldCountInShengYu = 1
                    else
                        UIMainMenusPanel.DropAnnounceShieldCountInShengYu = UIMainMenusPanel.DropAnnounceShieldCountInShengYu + 1
                        return
                    end
                end
            end
        end
    elseif (id == 3001 or id == 3002) then
        --挖掘公告特殊需求：根据重复ID，屏蔽部分公告
        local needRoleLevel = CS.Cfg_GlobalTableManager.Instance.GatherAnnounceLimitLevel;
        local needServerDay = CS.Cfg_GlobalTableManager.Instance.GatherAnnounceLimitServerDay;
        local RepetitiveItemCount = CS.Cfg_GlobalTableManager.Instance.GatherAnnounceLimitRepetitiveItemCount;
        local itemid = 0
        if (#tblData.params >= 7) then
            local tem = tblData.params[7]:Split('#')
            if (Utility.GetLuaTableCount(tem) >= 2) then
                itemid = tonumber(tem[1])
            end
        end
        if (needRoleLevel >= CS.CSScene.MainPlayerInfo.Level and needServerDay >= CS.CSScene.MainPlayerInfo.OpenServerDayNumber) then
            if (UIMainMenusPanel.mGatherAnnounceRepetitiveItemList:Contains(itemid)) then
                UIMainMenusPanel.mGatherAnnounceRepetitiveItemList:Remove(itemid)
                UIMainMenusPanel.mGatherAnnounceRepetitiveItemList:Add(itemid)
                return
            else
                if (UIMainMenusPanel.mGatherAnnounceRepetitiveItemList.Count >= RepetitiveItemCount and UIMainMenusPanel.mGatherAnnounceRepetitiveItemList.Count ~= 0) then
                    UIMainMenusPanel.mGatherAnnounceRepetitiveItemList:RemoveAt(0)
                end
                UIMainMenusPanel.mGatherAnnounceRepetitiveItemList:Add(itemid)
            end
        end
    elseif (id == 2001) then
        --回收公告, 表中未填的额外两个参数用来处理屏蔽规则：一个itmeid 一个itemCount
        if (#tblData.params >= 8) then
            local itemid = tblData.params[7]
            local itemcount = tonumber(tblData.params[8])
            if (UIMainMenusPanel.RecycleAnnounceShieldCountDic[itemid] == nil) then
                UIMainMenusPanel.RecycleAnnounceShieldCountDic[itemid] = 0
            end
            if (itemcount >= CS.Cfg_GlobalTableManager.Instance:GetRecycleAnnounceItemCountInDifferentLevel(itemid)) then
                if (UIMainMenusPanel.RecycleAnnounceShieldCountDic[itemid] == 0 or (UIMainMenusPanel.RecycleAnnounceShieldCountDic[itemid] >= CS.Cfg_GlobalTableManager.Instance.RecycleAnnounceRepetitionItemCount)) then
                    --完成一次循环屏蔽后，将条件置0
                    UIMainMenusPanel.RecycleAnnounceShieldCountDic[itemid] = 1
                else
                    UIMainMenusPanel.RecycleAnnounceShieldCountDic[itemid] = UIMainMenusPanel.RecycleAnnounceShieldCountDic[itemid] + 1
                    return
                end
            end
        end
    elseif (id == 16001) then
        ---银宝箱掉落
        local itemid = 0
        local RepetitiveItemCount = CS.Cfg_GlobalTableManager.Instance.SilverBoxDropAnnounceCount;
        if (#tblData.params >= 6) then
            local tem = tblData.params[6]:Split('#')
            if (Utility.GetLuaTableCount(tem) >= 2) then
                itemid = tonumber(tem[1])
            end
        end
        if (UIMainMenusPanel.mSilverBoxDropAnnounceRepetitiveItemList:Contains(itemid)) then
            UIMainMenusPanel.mSilverBoxDropAnnounceRepetitiveItemList:Remove(itemid)
            UIMainMenusPanel.mSilverBoxDropAnnounceRepetitiveItemList:Add(itemid)
            return
        else
            if (UIMainMenusPanel.mSilverBoxDropAnnounceRepetitiveItemList.Count >= RepetitiveItemCount and UIMainMenusPanel.mSilverBoxDropAnnounceRepetitiveItemList ~= 0) then
                UIMainMenusPanel.mSilverBoxDropAnnounceRepetitiveItemList:RemoveAt(0)
            end
            UIMainMenusPanel.mSilverBoxDropAnnounceRepetitiveItemList:Add(itemid)
        end
    elseif (id == 16002) then
        ---金宝箱掉落
        local itemid = 0
        local RepetitiveItemCount = CS.Cfg_GlobalTableManager.Instance.GoldBoxDropAnnounceCount;
        if (#tblData.params >= 6) then
            local tem = tblData.params[6]:Split('#')
            if (Utility.GetLuaTableCount(tem) >= 2) then
                itemid = tonumber(tem[1])
            end
        end
        if (UIMainMenusPanel.mGoldBoxDropAnnounceRepetitiveItemList:Contains(itemid)) then
            UIMainMenusPanel.mGoldBoxDropAnnounceRepetitiveItemList:Remove(itemid)
            UIMainMenusPanel.mGoldBoxDropAnnounceRepetitiveItemList:Add(itemid)
            return
        else
            if (UIMainMenusPanel.mGoldBoxDropAnnounceRepetitiveItemList.Count >= RepetitiveItemCount and UIMainMenusPanel.mGoldBoxDropAnnounceRepetitiveItemList.Count ~= 0) then
                UIMainMenusPanel.mGoldBoxDropAnnounceRepetitiveItemList:RemoveAt(0)
            end
            UIMainMenusPanel.mGoldBoxDropAnnounceRepetitiveItemList:Add(itemid)
        end
    end

    for i = 1, #tblData.showType do
        if (tblData.showType[i] == LuaEnumAnnounceType.Top) then
            ---跑马灯公告
            if (uiStaticParameter.isShowNotice) then
                UIMainMenusPanel.AddDataToUINoticePanel(str)
            end
        elseif (tblData.showType[i] == LuaEnumAnnounceType.MiddleTop) then
            ---寻宝二级公告
            UIMainMenusPanel.AddDataToUINoticeSecondPanel(str)
        elseif (tblData.showType[i] == LuaEnumAnnounceType.MiddleDown) then
            ---寻宝二级公告
            UIMainMenusPanel.AddDataToUINoticeSecondDownPanel(str)
        elseif (tblData.showType[i] == LuaEnumAnnounceType.System) then
            ---系统公告
            local parm = CS.chatV2.ResChat()
            parm.channel = 3
            parm.sound = false
            parm.message = str
            parm.time = CS.CSServerTime.Instance.TotalMillisecond
            UIMainMenusPanel:GetClientEventHandler():SendEvent(CS.CEvent.ResChatMessage, parm, parm)
        elseif (tblData.showType[i] == LuaEnumAnnounceType.Union) then
            ---帮会公告
            local parm = CS.chatV2.ResChat()
            parm.channel = 4
            parm.sound = false
            parm.message = str
            UIMainMenusPanel:GetClientEventHandler():SendEvent(CS.CEvent.ResChatMessage, parm, parm)
        elseif (tblData.showType[i] == LuaEnumAnnounceType.Team) then
            ---队伍公告
            local parm = CS.chatV2.ResChat()
            parm.channel = 6
            parm.sound = false
            parm.message = str
            UIMainMenusPanel:GetClientEventHandler():SendEvent(CS.CEvent.ResChatMessage, parm, parm)
        end
    end
end

function UIMainMenusPanel.CheckAnnounceTableNeedToSolve()
    if (#UIMainMenusPanel.AnnounceTable > 0) then
        UIMainMenusPanel.RespondAnnounceMessage(UIMainMenusPanel.AnnounceTable[1])
        table.remove(UIMainMenusPanel.AnnounceTable, 1)
    end
    return #UIMainMenusPanel.AnnounceTable > 0
end
function UIMainMenusPanel.AddDataToUINoticePanel(str)
    local NoticePanel = uimanager:GetPanel("UINoticePanel")
    if (NoticePanel == nil) then
        uimanager:CreatePanel("UINoticePanel", nil, str)
    else
        table.insert(NoticePanel.NoticeDataList, str)
    end
end

function UIMainMenusPanel.AddDataToUINoticeSecondPanel(str)
    local NoticePanel = uimanager:GetPanel("UINoticeSecondPanel")
    if (NoticePanel == nil) then
        uimanager:CreatePanel("UINoticeSecondPanel", nil, str)
    else
        table.insert(NoticePanel.NoticeDataList, str)
    end
end

function UIMainMenusPanel.AddDataToUINoticeSecondDownPanel(str)
    local NoticePanel = uimanager:GetPanel("UINoticeSecondDownPanel")
    if (NoticePanel == nil) then
        uimanager:CreatePanel("UINoticeSecondDownPanel", nil, str)
    else
        table.insert(NoticePanel.NoticeDataList, str)
    end
end
--endregion

--region 获取好友信息
function UIMainMenusPanel.GetFriendList()
    networkRequest.ReqOpenFriendPanel(1)
    networkRequest.ReqOpenFriendPanel(4)
    networkRequest.ReqOpenFriendPanel(7)
end
--endregion

--endregion

--region 换掉当前左边任务
function UIMainMenusPanel:ChangLeftPanel(newPanelName)
    local currentPanel = uimanager:GetPanel(newPanelName)
    if currentPanel then
        return
    end

    if (newPanelName ~= UIMainMenusPanel.LeftCenterPanelName) then
        uimanager:ClosePanel(UIMainMenusPanel.LeftCenterPanelName)
        UIMainMenusPanel.LeftCenterPanelName = newPanelName
        UIMainMenusPanel:AddMainMenuModule(UIMainMenusPanel.LeftCenterPanelName, UIMainMenusPanel:GetLeftDynamicNode())
    end
end
--endregion

--region 开始客户端的断线重连流程
function UIMainMenusPanel.OnStartClientReconnect()
    --只有在主场景中时才请求连接
    --local constant = CS.Constant
    --CS.CSInterfaceSingleton.NetReq:ReqReconnectMessage(constant.UserID_Game, constant.mSeverId, constant.platformid, 1, 0, constant, CS.CSServerTime:DateTimeToStampForMilli(CS.CSServerTime.Instance.ServerNowsMilli), "");
    local constant = CS.Constant
    CS.UnityEngine.Debug.LogError("开始客户端的断线重连流程:ReqLoginMessage_Extend:" .. constant.UserID_Game);
    if CS.CSScene.Sington ~= nil then
        CS.CSScene.Sington:RemoveAllAvatar();
    end
    CS.NetV2.ReqLoginMessage_Extend(constant.UserID_Game, constant.platformid, constant.mSeverId, constant.GameServerSign, constant.time, "", 0, CS.CSServerFile.ClientRegionID, 1)
end

function UIMainMenusPanel.OnResLoginMessage(uiEvtID, data)
    --CS.UnityEngine.Debug.LogError("收到OnResLoginMessage   开始初始化角色列表   然后 ReqChooseRoleMessage::" .. CS.Constant.RoleID_Game);
    CS.UserManager.Instance:InitRoleList(protobufMgr.DecodeTable.user.ResLogin(data))
    CS.NetV2.ReqChooseRoleMessage(CS.Constant.RoleID_Game)
end
--endregion

--region 聚灵珠推送

UIMainMenusPanel.CheckJuLingZhuGap = 0

function UIMainMenusPanel.InitJuLingZhuTimeInfo()
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22369)
    if isFind then
        UIMainMenusPanel.CheckJuLingZhuGap = (info.value == nil or info.value == '') and 0.02 or tonumber(info.value)
    end
end

function UIMainMenusPanel.UpDataCheckJuLingZhu()
    if CS.MainPlayerInfo ~= nil and uiStaticParameter.UpdataCheckJuLingZhuPush then
        if CS.UnityEngine.Time.time - uiStaticParameter.LastCheckJuLingZhuTime > UIMainMenusPanel.CheckJuLingZhuGap then
            uiStaticParameter.LastCheckJuLingZhuTime = CS.UnityEngine.Time.time
            CS.CSScene.MainPlayerInfo.BagInfo:CheckBeadsOfUpdata()
            if luaEventManager.HasCallback(LuaCEvent.RefreshJuLingZhuPush) then
                luaEventManager.DoCallback(LuaCEvent.RefreshJuLingZhuPush)
            end
        end
    end
end


--endregion

--region 红点
---显示领奖红点
function UIMainMenusPanel:ShowRewardRedPoint()
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    ---@type rechargegiftboxV2.RechargeGiftBoxInfo
    local csData = CS.CSScene.MainPlayerInfo.RechargeInfo.CurrentRechargeGiftBoxInfo
    if csData == nil then
        return
    end
    local isshow = false
    if (csData.continuousGiftBoxInfo.nowGroup ~= 0) then
        local info = csData.continuousGiftBoxInfo
        local mContinueCanReceiveList = info.rewardInfo

        local count = mContinueCanReceiveList.Count
        for i = 0, count - 1 do
            if (mContinueCanReceiveList[i].receive == 1) then
                isshow = true
            end
        end
        local days = CS.Utility_Lua.GetReaminTimeInDays(info.lastCompleteTime, CS.CSServerTime.Instance.TotalMillisecond)

        if (days >= 1) then
            UIMainMenusPanel.isshowCanRechargeToReward = true
        end
    end
    CS.CSScene.MainPlayerInfo.RechargeInfo.IsCanGetContinueReward = isshow
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.Recharge_ContinueReward);
end
--endregion

function update()
    if UIMainMenusPanel.isStartEnterHot == false and Utility.IsOpenFrontHotLoad == false then
        if CS.SDKManager.GameInterface ~= nil and CS.SDKManager.GameInterface:GetResUnzipProcess() == CS.ESDKResUnzipProcess.Finish and UIMainMenusPanel.isAwaitComplete then
            if CS.CSResUpdateMgr.Instance ~= nil then
                UIMainMenusPanel.isStartEnterHot = true
                CS.CSResUpdateMgr.Instance:AddGamingDownloadUpdateResource();
                if UIMainMenusPanel ~= nil then
                    UIMainMenusPanel:AddMainMenuModule("UIGameResloadPanel", UIMainMenusPanel:GetTopLeftStaticNode())
                end
            end
        end
    end
    if uiStaticParameter.isNeedSendMinReq ~= nil then
        uiStaticParameter.isNeedSendMinReq = uiStaticParameter.isNeedSendMinReq - 1
        --print(uiStaticParameter.isNeedSendMinReq)
        if uiStaticParameter.isNeedSendMinReq == 0 then
            uiStaticParameter.isNeedSendMinReq = nil
            networkRequest.ReqMinMap()
        end
    end
    if CS.UnityEngine.Time.time - UIMainMenusPanel.lastGetTemperatureTime > 10 then
        UIMainMenusPanel.lastGetTemperatureTime = CS.UnityEngine.Time.time;
        --SDKManager.GameInterface.GetTemperature
        Temperature(CS.SDKManager.GameInterface:GetTemperature())
    end
    UIMainMenusPanel.UpDataCheckJuLingZhu()

    local AnnounceDealIndex = 1
    while (AnnounceDealIndex <= 10) do
        AnnounceDealIndex = AnnounceDealIndex + 1
        if UIMainMenusPanel.CheckAnnounceTableNeedToSolve() == false then
            break
        end
    end
end

function Temperature(num)
    if num == 0 then
        return
    end
    if UIMainMenusPanel.lastTemperature == num then
        return
    end
    UIMainMenusPanel.lastTemperature = num;
    --SetAttachVisible true 里面 不主动调用SwitchAdaptModel，防止温度在分界点来回跳动导致不停盗用。
    if UIMainMenusPanel.lastTemperature <= 380 then
        CS.CSAdaptManager.Instance:SetAttachVisible(false, 0);
    elseif UIMainMenusPanel.lastTemperature >= 385 and UIMainMenusPanel.lastTemperature < 390 then
        CS.CSAdaptManager.Instance:SetAttachVisible(true, 2);
    elseif UIMainMenusPanel.lastTemperature >= 390 and UIMainMenusPanel.lastTemperature < 395 then
        CS.CSAdaptManager.Instance:SetAttachVisible(true, 1);
    elseif UIMainMenusPanel.lastTemperature >= 395 then
        CS.CSAdaptManager.Instance:SetAttachVisible(true, 0);
    end

end

return UIMainMenusPanel