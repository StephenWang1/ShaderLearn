---主界面活动面板（右上角按钮）
---@class UIActivitiesPanel:UIBase
local UIActivitiesPanel = {}

--region 局部变量定义
---UI层级
UIActivitiesPanel.PanelLayerType = CS.UILayerType.BasicPlane
---当前活动面板状态
UIActivitiesPanel.UIActivitiesPanelState = true
---挑战Boss开启后横向间隔
UIActivitiesPanel.BossIconHorizontalInterval = 114
---挑战Boss行数
UIActivitiesPanel.BossRowNumber = 1
---存储每行按钮个数
---@type table<number,TABLE.CFG_NOTICEARRAY>
UIActivitiesPanel.ActivitiesPanelBtnCountTable = {}
---存储每个按钮读第几行表
UIActivitiesPanel.ActivitiesPanelBtnRowTable = {}
UIActivitiesPanel.mFirstRechargeTrans = nil

UIActivitiesPanel.AllRedKey = {}

UIActivitiesPanel.targetLabel = {}

UIActivitiesPanel.mUpdateTimer = 0;

---小地图控制器
---@type UIMiniMapController
UIActivitiesPanel.mMiniMapController = nil
--endregion

--region 组件
--region 活动整体面板和收缩按钮
---收缩箭头按钮
function UIActivitiesPanel.GetSArrow_GameObject()
    if UIActivitiesPanel.mArrowGo == nil then
        UIActivitiesPanel.mArrowGo = UIActivitiesPanel:GetCurComp("WidgetRoot/activity/btn_return", "GameObject")
    end
    return UIActivitiesPanel.mArrowGo
end

---箭头特效按钮
function UIActivitiesPanel.GetArrowEffect_RedPoint()
    if UIActivitiesPanel.mFadeEffect == nil then
        UIActivitiesPanel.mFadeEffect = UIActivitiesPanel:GetCurComp("WidgetRoot/activity/btn_return", "UIRedPoint")
    end
    return UIActivitiesPanel.mFadeEffect
end

---箭头特效按钮父物体
function UIActivitiesPanel.GetArrowEffect_GameObject()
    if UIActivitiesPanel.mArrowEffect == nil then
        UIActivitiesPanel.mArrowEffect = UIActivitiesPanel:GetCurComp("WidgetRoot/activity/btn_return/arrowEffect", "GameObject")
    end
    return UIActivitiesPanel.mArrowEffect
end

---活动面板Link组件
function UIActivitiesPanel:GetActivityPanel_UILinkerCollector()
    if UIActivitiesPanel.mActivityPanel_UILinkerCollector == nil then
        UIActivitiesPanel.mActivityPanel_UILinkerCollector = UIActivitiesPanel:GetCurComp("WidgetRoot/activity", "UILinkerCollector");
    end
    return UIActivitiesPanel.mActivityPanel_UILinkerCollector
end

---收缩箭头Rotation动画组件
function UIActivitiesPanel.GetSArrow_RotationTween()
    if UIActivitiesPanel.mArrowRotationTween == nil then
        UIActivitiesPanel.mArrowRotationTween = UIActivitiesPanel:GetCurComp("WidgetRoot/activity/btn_return", "Top_TweenRotation");
    end
    return UIActivitiesPanel.mArrowRotationTween
end
---活动面板Position动画组件
function UIActivitiesPanel.GetActivity_PositionTween()
    if UIActivitiesPanel.mActivityPositionTween == nil then
        UIActivitiesPanel.mActivityPositionTween = UIActivitiesPanel:GetCurComp("WidgetRoot/activity/activity", "Top_TweenPosition");
    end
    return UIActivitiesPanel.mActivityPositionTween
end
---活动面板Scale动画组件
---@return TweenScale
function UIActivitiesPanel.GetActivity_ScaleTween()
    if UIActivitiesPanel.mActivityScaleTween == nil then
        UIActivitiesPanel.mActivityScaleTween = UIActivitiesPanel:GetCurComp("WidgetRoot/activity/activity", "Top_TweenScale");
    end
    return UIActivitiesPanel.mActivityScaleTween
end
---活动面板Alpha动画组件
function UIActivitiesPanel.GetActivity_AlphaTween()
    if UIActivitiesPanel.mActivityAlphaTween == nil then
        UIActivitiesPanel.mActivityAlphaTween = UIActivitiesPanel:GetCurComp("WidgetRoot/activity/activity", "Top_TweenAlpha");
    end
    return UIActivitiesPanel.mActivityAlphaTween
end

---常显活动面板Scale动画组件
---@return TweenScale
function UIActivitiesPanel.GetActivityOut_ScaleTween()
    if UIActivitiesPanel.mActivityOutScaleTween == nil then
        UIActivitiesPanel.mActivityOutScaleTween = UIActivitiesPanel:GetCurComp("WidgetRoot/activity_out/activity", "Top_TweenScale");
    end
    return UIActivitiesPanel.mActivityOutScaleTween
end
---常显活动面板Alpha动画组件
function UIActivitiesPanel.GetActivityOut_AlphaTween()
    if UIActivitiesPanel.mActivityOutAlphaTween == nil then
        UIActivitiesPanel.mActivityOutAlphaTween = UIActivitiesPanel:GetCurComp("WidgetRoot/activity_out/activity", "Top_TweenAlpha");
    end
    return UIActivitiesPanel.mActivityOutAlphaTween
end

--endregion

--region 活动面板下的按钮
---排列行组件
function UIActivitiesPanel.GetActivityGrid()
    if UIActivitiesPanel.mactivityGridGroup == nil then
        UIActivitiesPanel.mactivityGridGroup = UIActivitiesPanel:GetCurComp("WidgetRoot/activity/activity/AllRow", "Top_UIGridContainer")
    end
    return UIActivitiesPanel.mactivityGridGroup
end

---常显排列行组件
---@return Top_UIGridContainer
function UIActivitiesPanel.GetActivityOutGrid()
    if UIActivitiesPanel.mactivityOutGridGroup == nil then
        UIActivitiesPanel.mactivityOutGridGroup = UIActivitiesPanel:GetCurComp("WidgetRoot/activity_out/activity/AllRow", "Top_UIGridContainer")
    end
    return UIActivitiesPanel.mactivityOutGridGroup
end
--endregion

--region 活动面板的活动按钮
---地图按钮
function UIActivitiesPanel.GetMapBtn()
    if UIActivitiesPanel.mMapBtn == nil then
        UIActivitiesPanel.mMapBtn = UIActivitiesPanel:GetCurComp("WidgetRoot/mapPanel/mapBg", "GameObject")
    end
    return UIActivitiesPanel.mMapBtn
end

function UIActivitiesPanel.GetRechargeFirstSloganPanel()
    UIActivitiesPanel.mRechargeFirstSlogan = uimanager:GetPanel("UIRechargeFirstSloganTipsPanel")
end

function UIActivitiesPanel.GetFirstRechargeOut_Transform()
    if (UIActivitiesPanel.mFirstRechargeOutTrans == nil) then
        UIActivitiesPanel.mFirstRechargeOutTrans = UIActivitiesPanel:GetCurComp("WidgetRoot/activity_out/activity/AllRow/Row1/UIRechargeFirstTips", "Transform")
    end
    if (UIActivitiesPanel.mFirstRechargeOutTrans == nil) then
        UIActivitiesPanel.mFirstRechargeOutTrans = UIActivitiesPanel:GetCurComp("WidgetRoot/activity_out/activity/AllRow/Row2/UIRechargeFirstTips", "Transform")
    end
    return UIActivitiesPanel.mFirstRechargeOutTrans
end

--endregion

--region 地图组件
---地图点根节点的transform组件
function UIActivitiesPanel.MapPointRoot_Trans()
    if UIActivitiesPanel.mMapPointRoot == nil then
        UIActivitiesPanel.mMapPointRoot = UIActivitiesPanel:GetCurComp("WidgetRoot/mapPanel/PointRoot", "Transform")
    end
    return UIActivitiesPanel.mMapPointRoot
end

---地图
function UIActivitiesPanel.MapGameObject()
    if UIActivitiesPanel.mMapGameObject == nil then
        UIActivitiesPanel.mMapGameObject = UIActivitiesPanel:GetCurComp("WidgetRoot/mapPanel", "GameObject")
    end
    return UIActivitiesPanel.mMapGameObject
end

---地图纹理根节点
function UIActivitiesPanel.MapTextureRoot()
    if UIActivitiesPanel.mMapTextureRoot == nil then
        UIActivitiesPanel.mMapTextureRoot = UIActivitiesPanel:GetCurComp("WidgetRoot/mapPanel/mapTexture", "GameObject")
    end
    return UIActivitiesPanel.mMapTextureRoot
end

---玩家点图片
function UIActivitiesPanel.PlayerPoint_UISprite()
    if UIActivitiesPanel.mPlayerPoint_UISprite == nil then
        UIActivitiesPanel.mPlayerPoint_UISprite = UIActivitiesPanel:GetCurComp("WidgetRoot/mapPanel/Points/Player", "UISprite")
    end
    return UIActivitiesPanel.mPlayerPoint_UISprite
end

---玩家点特效图片
function UIActivitiesPanel.PlayerEffect_UISprite()
    if UIActivitiesPanel.mPlayerEffect_UISprite == nil then
        UIActivitiesPanel.mPlayerEffect_UISprite = UIActivitiesPanel:GetCurComp("WidgetRoot/mapPanel/Points/Player/effect", "UISprite")
    end
    return UIActivitiesPanel.mPlayerEffect_UISprite
end

---单张图片预设
function UIActivitiesPanel.SpriteOnly_UISprite()
    if UIActivitiesPanel.mSpriteOnly_UISprite == nil then
        UIActivitiesPanel.mSpriteOnly_UISprite = UIActivitiesPanel:GetCurComp("WidgetRoot/mapPanel/MapObjects/point", "UISprite")
    end
    return UIActivitiesPanel.mSpriteOnly_UISprite
end

---带文字的图片预设
function UIActivitiesPanel.SpriteWithLabel_UICombination()
    if UIActivitiesPanel.mSpriteWithLabel_UICombination == nil then
        UIActivitiesPanel.mSpriteWithLabel_UICombination = UIActivitiesPanel:GetCurComp("WidgetRoot/mapPanel/MapObjects/pointWithLabel", "UICombination_SpriteAndLabel")
    end
    return UIActivitiesPanel.mSpriteWithLabel_UICombination
end

---地图名文字
function UIActivitiesPanel.MapNameLabel()
    if UIActivitiesPanel.mMapNameLabel == nil then
        UIActivitiesPanel.mMapNameLabel = UIActivitiesPanel:GetCurComp("WidgetRoot/mapPanel/mapBg/Actionview/cityname", "UILabel")
    end
    return UIActivitiesPanel.mMapNameLabel
end

---坐标文字
function UIActivitiesPanel.CoordinateLabel()
    if UIActivitiesPanel.mCoordinateLabel == nil then
        UIActivitiesPanel.mCoordinateLabel = UIActivitiesPanel:GetCurComp("WidgetRoot/mapPanel/mapBg/coordinate", "UILabel")
    end
    return UIActivitiesPanel.mCoordinateLabel
end

---区域名文字
function UIActivitiesPanel.AreaNameLabel()
    if UIActivitiesPanel.mAreaNameLabel == nil then
        UIActivitiesPanel.mAreaNameLabel = UIActivitiesPanel:GetCurComp("WidgetRoot/mapPanel/mapBg/areaname", "UILabel")
    end
    return UIActivitiesPanel.mAreaNameLabel
end

---@return UICalendarTipsTemplate
function UIActivitiesPanel:GetCalendarTipsTemplate()
    if (UIActivitiesPanel.mCalendarTipTemplate == nil) then
        local gobj = UIActivitiesPanel:GetCurComp("WidgetRoot/gotoActivityTips", "GameObject");
        if (gobj ~= nil) then
            UIActivitiesPanel.mCalendarTipTemplate = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UICalendarTipsTemplate, UIActivitiesPanel);
        end
    end
    return UIActivitiesPanel.mCalendarTipTemplate
end

---@return UICalendarTipsTemplate
function UIActivitiesPanel:GetOutCalendarTipsTemplate()
    if (UIActivitiesPanel.mOutCalendarTipTemplate == nil) then
        local gobj = UIActivitiesPanel:GetCurComp("WidgetRoot/outGotoActivityTips", "GameObject");
        if (gobj ~= nil) then
            UIActivitiesPanel.mOutCalendarTipTemplate = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UICalendarTipsTemplate, UIActivitiesPanel);
        end
    end
    return UIActivitiesPanel.mOutCalendarTipTemplate
end

---@return UIRechargeFirstSloganTipsPanel
function UIActivitiesPanel:GetUIRechargeFirstSloganTipsPanel()
    if self.mUIRechargeFirstSloganTipsPanel == nil then
        self.mUIRechargeFirstSloganTipsPanel = uimanager:GetPanel("UIRechargeFirstSloganTipsPanel")
    end
    return self.mUIRechargeFirstSloganTipsPanel
end
--endregion

--region 判断
--endregion
--endregion

--region 初始化
function UIActivitiesPanel:Init()
    networkRequest.ReqOpenPanel(luaEnumCompetitionType.Recycle)
    self:BindLuaRedPointCallBack()
    UIActivitiesPanel:GetCalendarTipsTemplate():Initialize();
    UIActivitiesPanel:GetOutCalendarTipsTemplate():Initialize();
    UIActivitiesPanel.InitOutRedPoint()
    UIActivitiesPanel:InitParams()
    self:BindUIEvents()
    --UIActivitiesPanel.ResetActivityBtn()
    UIActivitiesPanel.InitializeMiniMap()
    UIActivitiesPanel.OnArrowClick()
end

function UIActivitiesPanel:BindUIEvents()
    CS.UIEventListener.Get(UIActivitiesPanel.GetSArrow_GameObject()).onClick = UIActivitiesPanel.OnArrowClick
    CS.UIEventListener.Get(UIActivitiesPanel.GetMapBtn()).onClick = UIActivitiesPanel.OnMapBtnClick

    UIActivitiesPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRefreshInfoMessage, UIActivitiesPanel.onSystemOpenReminderMessageCallBack)
    UIActivitiesPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.SystemOpenReminderMessage, UIActivitiesPanel.onSystemOpenReminderMessageCallBack)
    UIActivitiesPanel:GetClientEventHandler():AddEvent(CS.CEvent.Scene_EnterSceneAfter, UIActivitiesPanel.onSystemOpenReminderMessageCallBack)
    UIActivitiesPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MapProcessAfterLoaded, UIActivitiesPanel.ResPlayerChangeMap)
    UIActivitiesPanel:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateActiveInfo, UIActivitiesPanel.ResetActivityBtn)
    UIActivitiesPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_CalendarActivityIsOpen, UIActivitiesPanel.OnCalendarActivityIsOpen)
    UIActivitiesPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_RefreshOutActivity, UIActivitiesPanel.OnRefreshOutActivity)
    UIActivitiesPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_EnterSafeArea, UIActivitiesPanel.OnEnterSafeArea);

    UIActivitiesPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ActivityButtons_CalendarButtonUpdate, function()
        UIActivitiesPanel:IsOpenCalendarTips(false);
        gameMgr:GetPlayerDataMgr():GetActivityMgr():SortTodayCalendar()
        UIActivitiesPanel.OnCalendarActivityIsOpen();
    end)

    UIActivitiesPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Calendar_OnCalendarGiftStateChange, function()
        gameMgr:GetPlayerDataMgr():GetActivityMgr():SortTodayCalendar()
        UIActivitiesPanel.OnCalendarActivityIsOpen();
    end)

    UIActivitiesPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Calendar_OnActivityStateChange, function()
        gameMgr:GetPlayerDataMgr():GetActivityMgr():SortTodayCalendar()
        UIActivitiesPanel.OnCalendarActivityIsOpen();
    end)

    UIActivitiesPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Common_ZeroEvent, function()
        gameMgr:GetPlayerDataMgr():GetActivityMgr():InitCalendarCatalog()
        UIActivitiesPanel.ResetActivityBtn()
    end)

    UIActivitiesPanel.CallOpenButtons = function()
        UIActivitiesPanel.OpenActivityPanel();
    end
    UIActivitiesPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ActivityButtons_OpenButtons, UIActivitiesPanel.CallOpenButtons)

    UIActivitiesPanel.CallCloseButtons = function()
        UIActivitiesPanel.CloseActivityPanel();
    end
    UIActivitiesPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ActivityButtons_CloseButtons, UIActivitiesPanel.CallCloseButtons)

    UIActivitiesPanel.CallOnOpenButtons = function()
        local monsterHeadPanel = uimanager:GetPanel("UIMonsterHeadPanel");
        if (monsterHeadPanel ~= nil and not CS.StaticUtility.IsNull(monsterHeadPanel.go) and monsterHeadPanel.go.activeSelf) then
            UIActivitiesPanel.TryStartNextUpdateTimer();
        end
    end
    UIActivitiesPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ActivityButtons_OnButtonsOpened, UIActivitiesPanel.CallOnOpenButtons)
    UIActivitiesPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Calendar_OnHeartBeatInitCalendar, UIActivitiesPanel.OnHeartBeatInitCalendar)
    UIActivitiesPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RefreshSystemGrid, UIActivitiesPanel.onSystemOpenReminderMessageCallBack)
    UIActivitiesPanel.GetActivity_ScaleTween():SetOnFinished(UIActivitiesPanel.OnActivityTweenCallBack)
    --UIActivitiesPanel.GetActivityOut_ScaleTween():SetOnFinished(UIActivitiesPanel.OnActivityOutTweenCallBack)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.mAllActivityChange, function()
        self:RefreshAllActivityIcon()
    end)
end

---初始化小地图
function UIActivitiesPanel.InitializeMiniMap()
    UIActivitiesPanel.mMiniMapController = UIActivitiesPanel.MapTextureRoot():AddComponent(typeof(CS.UIMiniMapController))
    UIActivitiesPanel.mMiniMapController:InitializePointRoot(UIActivitiesPanel.MapPointRoot_Trans())
    UIActivitiesPanel.mMiniMapController.spriteOnlyPrefab = UIActivitiesPanel.SpriteOnly_UISprite()
    UIActivitiesPanel.mMiniMapController.spriteAndLabelPrefab = UIActivitiesPanel.SpriteWithLabel_UICombination()
    UIActivitiesPanel.mMiniMapController.playerPoint = UIActivitiesPanel.PlayerPoint_UISprite()
    UIActivitiesPanel.mMiniMapController.playerPointEffect = UIActivitiesPanel.PlayerEffect_UISprite()
    UIActivitiesPanel.mMiniMapController.mapNameLabel = UIActivitiesPanel.MapNameLabel()
    UIActivitiesPanel.mMiniMapController.mainPlayerCoordinateLabel = UIActivitiesPanel.CoordinateLabel()
    UIActivitiesPanel.mMiniMapController.IsNeedShowCellState = true
    ---UIActivitiesPanel.mMiniMapController.areaStateLabel = UIActivitiesPanel.AreaNameLabel()--当前不需要显示安全区
    UIActivitiesPanel.mMiniMapController.ViewRange = CS.Cfg_GlobalTableManager.Instance.MiniMapViewRangeInRightCorner
    UIActivitiesPanel.mMiniMapController.IsLimitMaxMonsterCount = true
    UIActivitiesPanel.mMiniMapController.FontSizeMultiple = 1
    UIActivitiesPanel.ActivityOpenActive = false
end

---初始化参数
function UIActivitiesPanel:InitParams()
    if CS.CSMapManager.Instance ~= nil and CS.CSMapManager.Instance.mapInfoTbl ~= nil then
        UIActivitiesPanel.lastMapId = CS.CSMapManager.Instance.mapInfoTbl.id
    end
    if UIActivitiesPanel.activityBtnIconSize == nil then
        UIActivitiesPanel.activityBtnIconSize = UIActivitiesPanel:GetComp(UIActivitiesPanel.GetActivity_AlphaTween().transform, "activityBtn", "UISprite").localSize
    end
end

---刷新
function UIActivitiesPanel:Show()
    if self:GetActivityPanel_UILinkerCollector() and CS.StaticUtility.IsNull(self:GetActivityPanel_UILinkerCollector()) == false then
        self:GetActivityPanel_UILinkerCollector():Refresh()
    end
    UIActivitiesPanel.SetActivityGird()
end
--endregion

--region UI事件处理
---箭头点击事件
function UIActivitiesPanel.OnArrowClick(go)
    UIActivitiesPanel.SActivityPanel(go)
    --if (UIActivitiesPanel.GetRechargeFirstSloganPanel() ~= nil) then
    --    UIActivitiesPanel.GetRechargeFirstSloganPanel():GetTips_GameObject():SetActive(false)
    --end
end
---小地图点击事件
function UIActivitiesPanel.OnMapBtnClick(go)
    uimanager:CreatePanel("UIMapPanel")
end

function UIActivitiesPanel.OnActivityTweenCallBack()
    local transfer = CS.CSListUpdateMgr.Add(1, nil, UIActivitiesPanel.OnWaitActivityTweenCallBack)
    CS.CSListUpdateMgr.Instance:Add(transfer)
end

function UIActivitiesPanel.OnWaitActivityTweenCallBack()
    local pos = CS.UnityEngine.Vector3.zero
    if (UIActivitiesPanel.UIActivitiesPanelState) then
        if (CS.StaticUtility.IsNull(UIActivitiesPanel.GetFirstRechargeOut_Transform()) == false and UIActivitiesPanel.GetFirstRechargeOut_Transform().gameObject.activeSelf) then
            pos = UIActivitiesPanel.GetFirstRechargeOut_Transform().position
        end
    else
        if (UIActivitiesPanel.mFirstRechargeTrans ~= nil and CS.StaticUtility.IsNull(UIActivitiesPanel.mFirstRechargeTrans) == false) then
            pos = UIActivitiesPanel.mFirstRechargeTrans.position
        end
    end
    CS.CSGame.Sington.EventHandler:SendEvent(CS.CEvent.V2_ActivityTween, pos, UIActivitiesPanel.UIActivitiesPanelState)
end

function UIActivitiesPanel.OnActivityOutTweenCallBack()
    --CS.CSGame.Sington.EventHandler:SendEvent(CS.CEvent.V2_ActivityTween, 2)
end
--endregion

--region 服务器事件
function UIActivitiesPanel.onSystemOpenReminderMessageCallBack()
    UIActivitiesPanel.SetActivityGird()
    UIActivitiesPanel.SetActivityBtn()
end

---接收玩家切换地图事件
function UIActivitiesPanel.ResPlayerChangeMap()
    local isOpen = CS.Cfg_GlobalTableManager.CfgInstance:CheckIsOpenActiveMap(CS.CSScene.getMapID())
    local count = UIActivitiesPanel.GetActivityGrid().MaxCount
    UIActivitiesPanel.UIActivitiesPanelState = isOpen and count ~= 0
    UIActivitiesPanel.OnArrowClick(nil)
    --if UIActivitiesPanel.lastMapId ~= nil then
    --    local lastMapType = tonumber(string.sub(tostring(UIActivitiesPanel.lastMapId), 1, 1))
    --    local nowMapType = tonumber(string.sub(tostring(tblData.mid), 1, 1))
    --    if lastMapType ~= nowMapType then
    --        if lastMapType == 1 then
    --            UIActivitiesPanel.UIActivitiesPanelState = false
    --            UIActivitiesPanel.OnArrowClick(nil)
    --        end
    --        if nowMapType == 1 then
    --            UIActivitiesPanel.UIActivitiesPanelState = true
    --            UIActivitiesPanel.OnArrowClick(nil)
    --        end
    --    end
    --end
    --UIActivitiesPanel.lastMapId = tblData.mid
end

--endregion

--region 功能Cfg_NoticeTableManager
--region活动面板动画
---活动面板动画调用
function UIActivitiesPanel.SActivityPanel(go)
    UIActivitiesPanel.SArrow(go)
end

---箭头动画
function UIActivitiesPanel.SArrow(go)
    UIActivitiesPanel.PlayRepeatTween(UIActivitiesPanel.GetSArrow_RotationTween())
    UIActivitiesPanel.UIActivitiesPanelState = not UIActivitiesPanel.UIActivitiesPanelState
    UIActivitiesPanel.ActivityPlaneChange()
    if UIActivitiesPanel:GetUIRechargeFirstSloganTipsPanel() ~= nil then
        UIActivitiesPanel:GetUIRechargeFirstSloganTipsPanel():PlayScaleTween()
    end
end

---打开活动面板
function UIActivitiesPanel.OpenActivityPanel()
    if (UIActivitiesPanel.UIActivitiesPanelState) then
        UIActivitiesPanel.PlayRepeatTween(UIActivitiesPanel.GetSArrow_RotationTween())
        UIActivitiesPanel.UIActivitiesPanelState = false
        UIActivitiesPanel.ActivityPlaneChange()
    end
end

---关闭活动面板
function UIActivitiesPanel.CloseActivityPanel()
    if (not UIActivitiesPanel.UIActivitiesPanelState) then
        UIActivitiesPanel.PlayRepeatTween(UIActivitiesPanel.GetSArrow_RotationTween())
        UIActivitiesPanel.UIActivitiesPanelState = true
        UIActivitiesPanel.ActivityPlaneChange()
    end
end

---跳转地图
function UIActivitiesPanel.ChangeMap()
    --CS.UnityEngine.Debug.LogError("跳转地图")
end

---活动面板动画
function UIActivitiesPanel.ActivityPlaneChange()
    if (not UIActivitiesPanel.UIActivitiesPanelState) then
        luaEventManager.DoCallback(LuaCEvent.ActivityButtons_OnButtonsOpened);
        UIActivitiesPanel:GetClientEventHandler():SendEvent(CS.CEvent.V2_OnActivityButtonsOpened)
        --UIActivitiesPanel.GetArrowEffect_GameObject():SetActive(false)
        UIActivitiesPanel.ActivityOpenActive = false
    else
        luaEventManager.DoCallback(LuaCEvent.ActivityButtons_OnButtonsClosed);
        UIActivitiesPanel:GetClientEventHandler():SendEvent(CS.CEvent.V2_OnActivityButtonsClosed)
        --UIActivitiesPanel.GetArrowEffect_GameObject():SetActive(true)
        UIActivitiesPanel.ActivityOpenActive = true
    end
    UIActivitiesPanel.PlayRepeatTween(UIActivitiesPanel.GetActivity_ScaleTween())
    UIActivitiesPanel.PlayRepeatTween(UIActivitiesPanel.GetActivityOut_ScaleTween())
    --UIActivitiesPanel.PlayRepeatTween(UIActivitiesPanel.GetActivity_AlphaTween())
    --UIActivitiesPanel.PlayRepeatTween(UIActivitiesPanel.GetActivityOut_AlphaTween())
end

--region 如果有怪物头像面板 那么就定时检测更新活动按钮栏
function UIActivitiesPanel.TryStartNextUpdateTimer()
    if (UIActivitiesPanel.mCoroutineNextUpdateTimer == nil) then
        UIActivitiesPanel.mCoroutineNextUpdateTimer = StartCoroutine(UIActivitiesPanel.CTimerNextUpdate);
    end
end

---如果间隔事件内没有进行过操作则刷新按钮栏开关状态
function UIActivitiesPanel.CTimerNextUpdate()
    while (UIActivitiesPanel.mUpdateTimer < UIActivitiesPanel.GetTimerInterval()) do
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1));
        UIActivitiesPanel.mUpdateTimer = UIActivitiesPanel.mUpdateTimer + 1;
    end

    ---如果规定时间内没有进行操作则收起活动栏
    UIActivitiesPanel.CloseActivityPanel();
    UIActivitiesPanel.mUpdateTimer = 0;
    UIActivitiesPanel.mCoroutineNextUpdateTimer = nil;
end

---重置计时器时间
function UIActivitiesPanel.ResetNextUpdateTimer()
    UIActivitiesPanel.mUpdateTimer = 0;
end

function UIActivitiesPanel.GetTimerInterval()
    return CS.Cfg_GlobalTableManager.Instance:GetActivityButtonsUpdateIntervalTime();
end
--endregion

---重复正反播放
---@param tween Tween动画
function UIActivitiesPanel.PlayRepeatTween(tween)
    if UIActivitiesPanel.UIActivitiesPanelState then
        tween:PlayForward()
    else
        tween:PlayReverse()
    end
end
--endregion

--region按钮生成和排版
---对外调用的方法，重设活动排版
function UIActivitiesPanel.ResetActivityBtn()
    UIActivitiesPanel.InitVariate()
    UIActivitiesPanel.SetActivityGird()
    UIActivitiesPanel.SetActivityBtn()
    UIActivitiesPanel.InitArrowEffect()
end

function UIActivitiesPanel.OnHeartBeatInitCalendar()
    UIActivitiesPanel.SetActivityBtn();
end

function UIActivitiesPanel.InitVariate()
    UIActivitiesPanel.ActivitiesPanelBtnCountTable = {}
    UIActivitiesPanel.ActivitiesPanelBtnRowTable = {}
end

function UIActivitiesPanel.IsShowButton(noticeId)
    if (noticeId == LuaEnumNoticeType.Active) then
        return not CS.CSScene.MainPlayerInfo.ActiveInfo:IsActiveFinished();
    end
    return true;
end

---计数排版
function UIActivitiesPanel.SetActivityGird()
    UIActivitiesPanel.ActivitiesPanelBtnCountTable = {}
    UIActivitiesPanel.infoList = {}

    UIActivitiesPanel.ResetActiveyBtn()
    local TableRows = clientTableManager.cfg_noticeManager:GetNoticeIdList()
    if TableRows == nil or Utility.GetTableCount(TableRows) == 0 then
        UIActivitiesPanel.GetActivityGrid().MaxCount = 1
        UIActivitiesPanel.GetActivityOutGrid().MaxCount = 1
        local mrow = CS.Utility_Lua.GetComponent(UIActivitiesPanel.GetActivityGrid().controlList[0].transform, "Top_UIGridContainer")
        mrow.MaxCount = 0
        mrow = CS.Utility_Lua.GetComponent(UIActivitiesPanel.GetActivityOutGrid().controlList[0].transform, "Top_UIGridContainer")
        mrow.MaxCount = 0
        UIActivitiesPanel.GetSArrow_GameObject():SetActive(false)
        return
    end
    UIActivitiesPanel.GetSArrow_GameObject():SetActive(true)
    local count = Utility.GetTableCount(TableRows) - 1;
    for i = 0, count do
        ---@type TABLE.CFG_NOTICE
        local Info = CS.Cfg_NoticeTableManager.Instance:getActivityBtnDa(TableRows[i + 1])
        if Info then
            if UIActivitiesPanel.infoList[Info.id] == nil then
                UIActivitiesPanel.infoList[Info.id] = 1
                local nowRow = Info.position
                if UIActivitiesPanel.ActivitiesPanelBtnCountTable[nowRow] == nil then
                    UIActivitiesPanel.ActivitiesPanelBtnCountTable[nowRow] = {}
                end
                if (UIActivitiesPanel.IsShowButton(TableRows[i + 1])) then
                    table.insert(UIActivitiesPanel.ActivitiesPanelBtnCountTable[nowRow], Info)
                end
            end

        end
    end

    local index = 0
    for i, v in pairs(UIActivitiesPanel.ActivitiesPanelBtnCountTable) do
        index = index + 1
        UIActivitiesPanel.GetActivityGrid().MaxCount = index
        local mrow = CS.Utility_Lua.GetComponent(UIActivitiesPanel.GetActivityGrid().controlList[index - 1].transform, "Top_UIGridContainer")

        table.sort(UIActivitiesPanel.ActivitiesPanelBtnCountTable[i], UIActivitiesPanel.SortActivityBtn)

        mrow.MaxCount = Utility.GetTableCount(UIActivitiesPanel.ActivitiesPanelBtnCountTable[i])

        local evenNum = math.fmod(i, 2)
        if evenNum == 0 and UIActivitiesPanel.activityBtnIconSize ~= nil then
            UIActivitiesPanel.evenNumRowLocalPosition = CS.UnityEngine.Vector3(UIActivitiesPanel.GetActivityGrid().controlList[0].transform.localPosition.x + UIActivitiesPanel.activityBtnIconSize.x / 2, mrow.transform.localPosition.y, 0)
            mrow.transform.localPosition = UIActivitiesPanel.evenNumRowLocalPosition
        end
    end
    UIActivitiesPanel.SetOutActivityBtn(TableRows)
end

function UIActivitiesPanel.OnRefreshOutActivity()
    if (UIActivitiesPanel.mCoroutineSetOutActivityBtn ~= nil) then
        StopCoroutine(UIActivitiesPanel.mCoroutineSetOutActivityBtn);
        UIActivitiesPanel.mCoroutineSetOutActivityBtn = nil;
    end
    UIActivitiesPanel.mCoroutineSetOutActivityBtn = StartCoroutine(UIActivitiesPanel.CSetOutActivityBtn);
end

function UIActivitiesPanel.OnEnterSafeArea()
    UIActivitiesPanel.OpenActivityPanel()
end

function UIActivitiesPanel.CSetOutActivityBtn()
    coroutine.yield(0);
    local TableRows = CS.Cfg_NoticeTableManager.Instance:GetMeetAscriptionGroup(1)
    UIActivitiesPanel.SetOutActivityBtn(TableRows)
end

--region 箭头朝左
---设置展开状态下的(箭头朝左) 多行活动ICON
function UIActivitiesPanel.SetOutActivityBtn(TableRows)
    --1 Cfg_GlobalTableManager
    local filterActivityList = CS.Cfg_GlobalTableManager.Instance:FilterActivityList(TableRows)
    --2 AddRedPointKey
    local ActivityDic = UIActivitiesPanel.GetArrowEffect_RedPoint():OutActivityList(filterActivityList)

    local allLineData = UIActivitiesPanel:DealOutActivityData(ActivityDic)

    UIActivitiesPanel.mOutCalendarButtons = {};

    if allLineData then
        UIActivitiesPanel.GetActivityOutGrid().MaxCount = Utility.GetTableCount(allLineData)
        for i = 0, UIActivitiesPanel.GetActivityOutGrid().controlList.Count - 1 do
            local go = UIActivitiesPanel.GetActivityOutGrid().controlList[i]
            local mrow = CS.Utility_Lua.GetComponent(go.transform, "Top_UIGridContainer")
            UIActivitiesPanel.SetOutLineActivity(mrow, allLineData[i + 1]);
        end
    end

    for k, v in pairs(UIActivitiesPanel.mOutCalendarButtons) do
        if (v.activeSelf) then
            UIActivitiesPanel:GetOutCalendarTipsTemplate():SetParent(v);
            break ;
        end
    end

    UIActivitiesPanel.mFirstRechargeOutTrans = nil
    UIActivitiesPanel.OnActivityTweenCallBack();
end

---@param mContainer Top_UIGridContainer 活动栏的行数
---@param singleLine SingleLineData 当前活动行的活动
function UIActivitiesPanel.SetOutLineActivity(mrow, singleLine)
    if singleLine then
        mrow.MaxCount = #singleLine.data
        for j = 0, mrow.MaxCount - 1 do
            local obj = mrow.controlList[j]
            local noticeId = singleLine.data[j + 1]
            local NoticeTable = CS.Cfg_NoticeTableManager.Instance:getActivityBtnDa(noticeId)
            if (UIActivitiesPanel.mOutCalendarButtons == nil) then
                UIActivitiesPanel.mOutCalendarButtons = {};
            end
            if (NoticeTable.id == luaEnumActivityBtnType.Calendar) then
                table.insert(UIActivitiesPanel.mOutCalendarButtons, obj);
            end
            UIActivitiesPanel.InitActivityBtnData(obj, NoticeTable)
        end
    end
end

---@class LineActivity 单行活动数据
---@field allActivityData table<number,SingleActivityData> 所有活动数据

---@class SingleLineData 单个活动数据
---@field order number 排序
---@field data table<number,number> Tbl<noticeId>

---处理外面显示的活动，进行分类
---@return table<number,SingleLineData>
---@param ActivityDic  table<number,table<number,number>> Dictionary<int, List<uint>>
function UIActivitiesPanel:DealOutActivityData(ActivityDic)
    local allDic = {}
    for k, v in pairs(ActivityDic) do
        for i = 0, v.Count - 1 do
            local noticeId = v[i]
            local noticeTbl = clientTableManager.cfg_noticeManager:TryGetValue(noticeId)
            if noticeTbl then
                local line = noticeTbl:GetOutPosition()
                if line == nil or line <= 0 then
                    line = 1
                end
                local lineData = allDic[line]
                if lineData == nil then
                    lineData = {}
                    allDic[line] = lineData
                end
                table.insert(lineData, noticeId)
            end
        end
    end
    --单行内部排序
    for k, v in pairs(allDic) do
        table.sort(v, function(l, r)
            if l == nil or r == nil then
                return false
            end

            local leftTbl = self:CacheNoticeData(l)
            local rightTbl = self:CacheNoticeData(r)
            if leftTbl == nil or rightTbl == nil then
                return true
            end
            if leftTbl:GetOutOrder() == nil or rightTbl:GetOutOrder() == nil then
                return leftTbl:GetOutOrder() == nil
            end

            return leftTbl:GetOutOrder() < rightTbl:GetOutOrder()
        end)
    end
    --总数据整理
    local finalData = {}
    for k, v in pairs(allDic) do
        ---@type SingleLineData
        local singleLineData = {}
        singleLineData.order = k
        singleLineData.data = v
        table.insert(finalData, singleLineData)
    end
    --总数据排序
    table.sort(finalData, function(m, n)
        return m.order < n.order
    end)
    return finalData
end

---@return TABLE.cfg_notice
function UIActivitiesPanel:CacheNoticeData(noticeId)
    local noticeTbl = clientTableManager.cfg_noticeManager:TryGetValue(noticeId)
    return noticeTbl
end
--endregion

--region 箭头朝右
---设置缩进状态下的(箭头朝右) 多行活动ICON
function UIActivitiesPanel.SetActivityBtn(isEnter)
    local rowIndex = 0
    UIActivitiesPanel.mCalendarButtons = {};

    UIActivitiesPanel.AllRedKey = {}
    ---@param v TABLE.CFG_NOTICEARRAY
    for i, v in pairs(UIActivitiesPanel.ActivitiesPanelBtnCountTable) do
        ---@type Top_UIGridContainer
        local mRow = CS.Utility_Lua.GetComponent(UIActivitiesPanel.GetActivityGrid().controlList[rowIndex].transform, "Top_UIGridContainer")
        UIActivitiesPanel.SetLineActivity(mRow, v, rowIndex + 1);
        rowIndex = rowIndex + 1;
    end

    for k, v in pairs(UIActivitiesPanel.mCalendarButtons) do
        if (v.activeSelf) then
            UIActivitiesPanel:GetCalendarTipsTemplate():SetParent(v);
            break ;
        end
    end

    UIActivitiesPanel.mFirstRechargeOutTrans = nil
    UIActivitiesPanel.OnActivityTweenCallBack();

    if (isEnter) then
        UIActivitiesPanel:IsOpenCalendarTips(false);
    end
end

---@param mContainer Top_UIGridContainer 活动栏的行数
---@param tableArray TABLE.CFG_NOTICEARRAY 当前活动行的活动
function UIActivitiesPanel.SetLineActivity(mContainer, tableArray, rowIndex)
    ---@type table<TABLE.CFG_NOTICE>
    local lineData = UIActivitiesPanel.GetNowLineNotice(tableArray, rowIndex);

    mContainer.MaxCount = Utility.GetTableCount(lineData);
    --print("mContainer.MaxCount:"..mContainer.MaxCount)
    local btnindex = 0
    ---@param notice TABLE.CFG_NOTICE
    for i2, notice in pairs(lineData) do
        --print("btnindex:"..btnindex)
        local mBtn = mContainer.controlList[btnindex]
        if (notice.id == luaEnumActivityBtnType.FirstRechargeReward) then
            UIActivitiesPanel.mFirstRechargeTrans = mBtn.transform
        end

        if (UIActivitiesPanel.mCalendarButtons == nil) then
            UIActivitiesPanel.mCalendarButtons = {};
        end
        if (notice.id == luaEnumActivityBtnType.Calendar) then
            table.insert(UIActivitiesPanel.mCalendarButtons, mBtn);
        end
        --设置活动按钮的信息
        UIActivitiesPanel.InitActivityBtnData(mBtn, notice)

        btnindex = btnindex + 1
    end
end

---@param rowIndex number 活动栏的行数
---@param tableArray TABLE.CFG_NOTICEARRAY 当前活动行的活动
function UIActivitiesPanel.GetNowLineNotice(tableArray, rowIndex)
    local list = {};
    if (tableArray == nil) then
        return tableArray;
    end
    ---@param notice TABLE.CFG_NOTICE
    for i2, notice in pairs(tableArray) do
        if (notice.position == rowIndex) then
            table.insert(list, notice)
        end
    end
    return list
end

--endregion

---重置活动按钮
function UIActivitiesPanel.ResetActiveyBtn()
    local count = UIActivitiesPanel.GetActivityGrid().controlList.Count
    if count == 0 then
        return
    end
    for i = 0, count - 1 do
        local mRow = CS.Utility_Lua.GetComponent(UIActivitiesPanel.GetActivityGrid().controlList[i].transform, "Top_UIGridContainer")
        local mRowCount = mRow.controlList.Count
        for i2 = 0, mRowCount - 1 do
            mRow:ClearItem(i2)
        end
    end
    for i = 0, count - 1 do
        UIActivitiesPanel.GetActivityGrid():ClearItem(i)
    end

end

---@param data TABLE.CFG_NOTICE
function UIActivitiesPanel.BindActivitiesBtnEvent(Btn, data)

    CS.UIEventListener.Get(Btn.gameObject).onClick = nil
    CS.UIEventListener.Get(Btn.gameObject).onClick = function()

        if data.jumpId ~= 0 then
            uiTransferManager:TransferToPanel(data.jumpId)
        elseif data.id == luaEnumActivityBtnType.Survey then
            CS.UnityEngine.Application.OpenURL(string.format(data.yushe, tostring(CS.Constant.UserID_SDK), tostring(CS.Constant.LoginToken_SDK)))
        else

            local PanelName = data.yushe
            if data.id == 82 then
                local dialoguelList = CS.CSScene.MainPlayerInfo.SecretaryInfo.DialoguelList
                if dialoguelList ~= nil and dialoguelList.Count > 0 then
                    local data = dialoguelList[dialoguelList.Count - 1]
                    if data ~= nil and data.DialogueType ~= CS.SecretaryDialogueType.ProblemFeedback then
                        CS.Cfg_Secret_GameSecretary_PlaystrategyTableManager.Instance:GetSecretaryID("问题反馈");
                    end
                else
                    CS.Cfg_Secret_GameSecretary_PlaystrategyTableManager.Instance:GetSecretaryID("问题反馈");
                end
            end
            if (PanelName == "UIRechargePanel") then
                PanelName = "UIRechargeMainPanel"
                uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.Reward
                local table = {}
                if (CS.CSScene.MainPlayerInfo.ActualOpenDays == 1) then
                    --table.type = LuaEnumRechargeType.PreferenceGift
                    table.type = LuaEnumRechargeMainBookMarkType.Activity
                    table.customData = { type = luaEnumCompetitionType.PreferenceGift }
                else
                    --table.type = LuaEnumRechargeType.Reward
                    table.type = LuaEnumRechargeMainBookMarkType.Award
                end
                uimanager:CreatePanel(PanelName, nil, table)
            else
                local customData = {}
                local luaNoticeTable = clientTableManager.cfg_noticeManager:TryGetValue(data.id)
                if luaNoticeTable then
                    customData.Param = luaNoticeTable:GetParam()
                end
                uimanager:CreatePanel(PanelName, nil, customData)

                if (PanelName == "UICalendarPanel") then
                    uiStaticParameter:SetIsEnterCalendarPanel(true);
                end
            end
        end

        if UIActivitiesPanel.AllBtnInfo ~= nil and UIActivitiesPanel.AllBtnInfo[data.id] ~= nil and UIActivitiesPanel.AllBtnInfo[data.id].btns ~= nil and type(UIActivitiesPanel.AllBtnInfo[data.id].btns) == 'table' then
            local btns = UIActivitiesPanel.AllBtnInfo[data.id].btns
            for k, v in pairs(btns) do
                local redHint = CS.Utility_Lua.Get(v.transform, "Sprite", "GameObject")
                if CS.StaticUtility.IsNull(redHint) == false then
                    redHint:SetActive(false)
                end
            end
        else
            local redHint = CS.Utility_Lua.Get(Btn.transform, "Sprite", "GameObject")
            if CS.StaticUtility.IsNull(redHint) == false then
                redHint:SetActive(false)
            end
        end
        if data ~= nil then
            CS.CSScene.MainPlayerInfo.ActivityListInfo:RemoveRedHint(data.id)
        end
        UIActivitiesPanel.ResetNextUpdateTimer();
    end
end

---设置按钮
---@param Button GameObject 按钮
---@param tableData TABLE.CFG_NOTICE
function UIActivitiesPanel.InitActivityBtnData(Button, tableData)
    local BtnSprite = CS.Utility_Lua.GetComponent(Button.transform, "Top_UISprite");
    local spriteName = tableData.iconId;
    if tableData.id == luaEnumActivityBtnType.SpecialActivity_KuaFu or tableData.id == luaEnumActivityBtnType.SpecialActivity_Limit then
        UIActivitiesPanel:SaveSpecialActivityBtn(BtnSprite)
        UIActivitiesPanel:RefreshSpecialActivityIcon(BtnSprite)
    else
        UIActivitiesPanel:ClearSpecialActivityBtn(BtnSprite)
        BtnSprite.spriteName = spriteName;
    end
    local trans = Button.transform:Find("LabelTime");
    local effectTrans = Button.transform:Find("progressEffect");
    BtnSprite.transform.name = tableData.yushe
    ---@type UIRedPoint
    local redPoint = CS.Utility_Lua.GetComponent(effectTrans, "UIRedPoint");
    local redHint = CS.Utility_Lua.Get(BtnSprite.transform, "Sprite", "GameObject")
    if CS.StaticUtility.IsNull(redHint) == false and tableData ~= nil then
        redHint:SetActive(CS.CSScene.MainPlayerInfo.ActivityListInfo:NeedShowRedHint(tableData.id))
    end
    redPoint:RemoveRedPointKey();
    redPoint.enabled = true;
    if UIActivitiesPanel.AllBtnInfo == nil then
        UIActivitiesPanel.AllBtnInfo = {}
    end
    if tableData ~= nil then
        if UIActivitiesPanel.AllBtnInfo[tableData.id] == nil then
            local tblInfo = {}
            tblInfo.btns = {}
            table.insert(tblInfo.btns, Button)
            tblInfo.tableData = tableData
            UIActivitiesPanel.AllBtnInfo[tableData.id] = tblInfo
        else
            local tblInfo = UIActivitiesPanel.AllBtnInfo[tableData.id]
            if tblInfo ~= nil and tblInfo.btns ~= nil and type(tblInfo.btns) == 'table' then
                local btnName = tblInfo.tableData.yushe
                local removeBtnTable = {}
                for k, v in pairs(tblInfo.btns) do
                    if CS.StaticUtility.IsNull(v) == true or v.name ~= btnName then
                        table.insert(removeBtnTable, k)
                    end
                end
                local length = #removeBtnTable
                for k = length, 1, -1 do
                    local v = removeBtnTable[k]
                    table.remove(tblInfo.btns, v)
                end
                if Utility.IsContainsValue(tblInfo.btns, Button) == false then
                    table.insert(tblInfo.btns, Button)
                end
            end
        end
    end

    if (trans ~= nil) then
        trans.gameObject:SetActive(false);
        if (tableData ~= nil) then
            if (tableData.id == luaEnumActivityBtnType.Calendar) then
                redPoint.enabled = false;
                UIActivitiesPanel.OnProcessCalendar(trans, effectTrans, BtnSprite, Button, tableData)
            elseif tableData.id == luaEnumActivityBtnType.Competition then
                ---竞技特效显示
                if not CS.StaticUtility.IsNull(redPoint) then
                    redPoint:AddRedPointKey(CS.RedPointKey.Activity_Competition)
                end
                table.insert(UIActivitiesPanel.AllRedKey, CS.RedPointKey.Activity_Competition)
                if not CS.StaticUtility.IsNull(redPoint) then
                    redPoint:AddRedPointKey(CS.RedPointKey.Activity_Competition_Recycle)
                end
                table.insert(UIActivitiesPanel.AllRedKey, CS.RedPointKey.Activity_Competition_Recycle)
            elseif tableData.id == luaEnumActivityBtnType.Auction then
                if not CS.StaticUtility.IsNull(redPoint) then
                    redPoint:AddRedPointKey(CS.RedPointKey.AuctionAll)
                end
                table.insert(UIActivitiesPanel.AllRedKey, CS.RedPointKey.AuctionAll)
            elseif tableData.id == luaEnumActivityBtnType.Recharge then
                local Investment_All = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Investment_All)
                local AccumulatedRecharge = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.AccumulatedRecharge)
                local PotentialInvest = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.PotentialInvestRedPoint)
                local LianChongRedPoint = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LianChongRedPoint)
                if not CS.StaticUtility.IsNull(redPoint) then
                    redPoint:AddRedPointKey(CS.RedPointKey.Recharge)
                    redPoint:AddRedPointKey(CS.RedPointKey.Recharge_Reward)
                    redPoint:AddRedPointKey(CS.RedPointKey.Recharge_ContinueReward)
                    redPoint:AddRedPointKey(CS.RedPointKey.Activity_Competition_FirstKill)
                    redPoint:AddRedPointKey(CS.RedPointKey.Activity_Competition_FirstDrop)
                    redPoint:AddRedPointKey(CS.RedPointKey.Activity_Competition_Recycle)
                    redPoint:AddRedPointKey(CS.RedPointKey.Activity_Competition_ServerOpen)
                    redPoint:AddRedPointKey(Investment_All)
                    redPoint:AddRedPointKey(AccumulatedRecharge)
                    redPoint:AddRedPointKey(PotentialInvest)
                    redPoint:AddRedPointKey(LianChongRedPoint)
                end
                table.insert(UIActivitiesPanel.AllRedKey, CS.RedPointKey.Recharge)
                table.insert(UIActivitiesPanel.AllRedKey, CS.RedPointKey.Recharge_Reward)
                table.insert(UIActivitiesPanel.AllRedKey, CS.RedPointKey.Recharge_ContinueReward)
                table.insert(UIActivitiesPanel.AllRedKey, CS.RedPointKey.Activity_Competition_FirstKill)
                table.insert(UIActivitiesPanel.AllRedKey, CS.RedPointKey.Activity_Competition_FirstDrop)
                table.insert(UIActivitiesPanel.AllRedKey, CS.RedPointKey.Activity_Competition_Recycle)
                table.insert(UIActivitiesPanel.AllRedKey, CS.RedPointKey.Activity_Competition_ServerOpen)
                table.insert(UIActivitiesPanel.AllRedKey, Investment_All)
                table.insert(UIActivitiesPanel.AllRedKey, AccumulatedRecharge)
                table.insert(UIActivitiesPanel.AllRedKey, PotentialInvest)
                table.insert(UIActivitiesPanel.AllRedKey, LianChongRedPoint)
            elseif tableData.id == luaEnumActivityBtnType.DaJin then
                if not CS.StaticUtility.IsNull(redPoint) then

                    redPoint:AddRedPointKey(CS.RedPointKey.Active_MainMenuButton)
                end
                table.insert(UIActivitiesPanel.AllRedKey, CS.RedPointKey.Active_MainMenuButton)
            elseif tableData.id == luaEnumActivityBtnType.Commerce then
                if not CS.StaticUtility.IsNull(redPoint) then

                    redPoint:AddRedPointKey(CS.RedPointKey.Commerce_MainMenuButton)
                end
                table.insert(UIActivitiesPanel.AllRedKey, CS.RedPointKey.Commerce_MainMenuButton)
            elseif tableData.id == luaEnumActivityBtnType.Boss then
                if not CS.StaticUtility.IsNull(redPoint) then
                    redPoint:AddRedPointKey(CS.RedPointKey.BOSS_ALL)
                    local PersionalBossKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Boss_Persional);
                    redPoint:AddRedPointKey(PersionalBossKey)
                    table.insert(UIActivitiesPanel.AllRedKey, PersionalBossKey)
                    local Boss_ShengXiao = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Boss_ShengXiao);
                    redPoint:AddRedPointKey(Boss_ShengXiao)
                    table.insert(UIActivitiesPanel.AllRedKey, Boss_ShengXiao)
                end
                table.insert(UIActivitiesPanel.AllRedKey, CS.RedPointKey.BOSS_ALL)
            elseif tableData.id == luaEnumActivityBtnType.FirstRechargeReward then
                if not CS.StaticUtility.IsNull(redPoint) then
                    redPoint:AddRedPointKey(CS.RedPointKey.Recharge_FirstReward)
                    networkRequest.ReqGetRechargeInfo()
                end
                table.insert(UIActivitiesPanel.AllRedKey, CS.RedPointKey.Recharge_FirstReward)
            elseif tableData.id == luaEnumActivityBtnType.Rank then
                if not CS.StaticUtility.IsNull(redPoint) then
                    redPoint:AddRedPointKey(CS.RedPointKey.Rank_All)
                end
                table.insert(UIActivitiesPanel.AllRedKey, CS.RedPointKey.Rank_All)
            elseif tableData.id == luaEnumActivityBtnType.Treasure then
                if not CS.StaticUtility.IsNull(redPoint) then

                    redPoint:AddRedPointKey(CS.RedPointKey.Treasure_Warehouse)
                    -- redPoint:AddRedPointKey(CS.RedPointKey.Treasure_TaLuoPai)
                end
                table.insert(UIActivitiesPanel.AllRedKey, CS.RedPointKey.Treasure_Warehouse)
                -- table.insert(UIActivitiesPanel.AllRedKey, CS.RedPointKey.Treasure_TaLuoPai)
            elseif tableData.id == luaEnumActivityBtnType.ContantRank then
                if not CS.StaticUtility.IsNull(redPoint) then
                    redPoint:AddRedPointKey(CS.RedPointKey.Overlord_All)
                end
                table.insert(UIActivitiesPanel.AllRedKey, CS.RedPointKey.Overlord_All)
            elseif tableData.id == luaEnumActivityBtnType.EliteOffer then
                if not CS.StaticUtility.IsNull(redPoint) then
                    local MonsterArrest = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.MonsterArrest);
                    redPoint:AddRedPointKey(MonsterArrest)
                    table.insert(UIActivitiesPanel.AllRedKey, MonsterArrest)
                end
                table.insert(UIActivitiesPanel.AllRedKey, CS.RedPointKey.EliteOffer_Monster)
            elseif tableData.id == luaEnumActivityBtnType.LeagueVote then
                if not CS.StaticUtility.IsNull(redPoint) then
                    local LeagueVoteKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LeagueVote);
                    redPoint:AddRedPointKey(LeagueVoteKey)
                    table.insert(UIActivitiesPanel.AllRedKey, LeagueVoteKey)
                end
            elseif tableData.id == luaEnumActivityBtnType.SpecialActivity_KuaFu then
                if not CS.StaticUtility.IsNull(redPoint) then
                    local SpecialActivity = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.SpecialActivity_KuaFu);
                    redPoint:AddRedPointKey(SpecialActivity)
                    table.insert(UIActivitiesPanel.AllRedKey, SpecialActivity)
                end
            elseif tableData.id == luaEnumActivityBtnType.SpecialActivity_Limit then
                if not CS.StaticUtility.IsNull(redPoint) then
                    local SpecialActivity = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.SpecialActivity_Limit);
                    redPoint:AddRedPointKey(SpecialActivity)
                    table.insert(UIActivitiesPanel.AllRedKey, SpecialActivity)
                end
            elseif tableData.id == luaEnumActivityBtnType.LsMission then
                if not CS.StaticUtility.IsNull(redPoint) then
                    local lsMissionRed = gameMgr:GetPlayerDataMgr():GetLsMissionData():GetRedPointKey();
                    redPoint:AddRedPointKey(lsMissionRed)
                    table.insert(UIActivitiesPanel.AllRedKey, lsMissionRed)
                end
            elseif tableData.id == luaEnumActivityBtnType.BaiRiMenActivity then
                local baiRiMenActivityInfoList = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetAllActControllers()
                if type(baiRiMenActivityInfoList) == 'table' and Utility.GetLuaTableCount(baiRiMenActivityInfoList) > 0 then
                    for k,v in pairs(baiRiMenActivityInfoList) do
                        ---@type BaiRiMenActControllerBase
                        local baiRiMenActivity = v
                        if baiRiMenActivity ~= nil and CS.StaticUtility.IsNullOrEmpty(baiRiMenActivity:GetBaiRiMenRedPointKey()) == false then
                            local baiRiMenMainPanelRedPoint = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(baiRiMenActivity:GetBaiRiMenRedPointKey())
                            redPoint:AddRedPointKey(baiRiMenMainPanelRedPoint)
                            table.insert(UIActivitiesPanel.AllRedKey, baiRiMenMainPanelRedPoint)
                        end
                    end
                end
                --if not CS.StaticUtility.IsNull(redPoint) then
                --    local baiRiMenMainPanelRedPoint = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BaiRiMenActivity_MainPanelRedPoint);
                --    redPoint:AddRedPointKey(baiRiMenMainPanelRedPoint)
                --    table.insert(UIActivitiesPanel.AllRedKey, baiRiMenMainPanelRedPoint)
                --end
            elseif tableData.id == luaEnumActivityBtnType.ChuangTianGuan then
                if not CS.StaticUtility.IsNull(redPoint) then
                    local baiRiMenMainPanelRedPoint = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BaiRiMenActivity_MainPanelRedPoint);
                    redPoint:AddRedPointKey(baiRiMenMainPanelRedPoint)
                    table.insert(UIActivitiesPanel.AllRedKey, baiRiMenMainPanelRedPoint)
                end
            elseif tableData.id == luaEnumActivityBtnType.MemberPanel then
                if not CS.StaticUtility.IsNull(redPoint) then
                    local MemberPanelRewardRedPoint = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.MemberPanelRewardRedPoint);
                    redPoint:AddRedPointKey(MemberPanelRewardRedPoint)
                    table.insert(UIActivitiesPanel.AllRedKey, MemberPanelRewardRedPoint)
                end
            end
        end
    end

    --绑定活动按钮的事件
    UIActivitiesPanel.BindActivitiesBtnEvent(Button, tableData)
end

UIActivitiesPanel.mLastOpenActivityId = nil;
UIActivitiesPanel.mLastCloseActivityId = nil;

UIActivitiesPanel.mLasTipsActivityId = nil;

---@public 是否打开历法提示
---@param tbl TABLE.cfg_daily_activity_time
function UIActivitiesPanel:IsOpenCalendarTips(isOpen, tbl)
    if (tbl ~= nil) then
        if (tbl:GetActivityMapId() ~= nil and tbl:GetActivityMapId().list.Count > 0 and CS.CSScene.MainPlayerInfo:IsInMap(tbl:GetActivityMapId().list)) then
            isOpen = false;
        end

        local isCalendarGift = tbl:GetHaveGift() == nil and false or tbl:GetHaveGift() == 1;
        if (isCalendarGift) then
            isOpen = false;
        end
    end

    if (isOpen) then
        UIActivitiesPanel:GetCalendarTipsTemplate():OpenTips();
        UIActivitiesPanel:GetOutCalendarTipsTemplate():OpenTips();

        if (tbl ~= nil) then
            UIActivitiesPanel.mLasTipsActivityId = tbl:GetId();
        end
    else
        UIActivitiesPanel:GetCalendarTipsTemplate():CloseTips();
        UIActivitiesPanel:GetOutCalendarTipsTemplate():CloseTips();
    end
end

--region存储节日活动数据
function UIActivitiesPanel:ClearSpecialActivityBtn(BtnSprite)
    self.mSpecialActivitySp = {}
    for i = 1, #self.mSpecialActivitySp do
        if self.mSpecialActivitySp[i] == BtnSprite then
            self.mSpecialActivitySp[i] = nil
        end
    end
end

---存储特殊活动sp
---@param BtnSprite UISprite
function UIActivitiesPanel:SaveSpecialActivityBtn(BtnSprite)
    if self.mSpecialActivitySp == nil then
        self.mSpecialActivitySp = {}
    end
    table.insert(self.mSpecialActivitySp, BtnSprite)
end

---刷新特殊活动icon
---@param BtnSprite UISprite
function UIActivitiesPanel:RefreshSpecialActivityIcon(BtnSprite)
    if CS.StaticUtility.IsNull(BtnSprite) then
        return
    end
    local sp = gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetCurrentActivityIcon()
    BtnSprite.spriteName = sp
end

---刷新所有活动icon
function UIActivitiesPanel:RefreshAllActivityIcon()
    if self.mSpecialActivitySp then
        for k, v in pairs(self.mSpecialActivitySp) do
            self:RefreshSpecialActivityIcon(v)
        end
    end
end
--endregion

---@param tableData TABLE.CFG_NOTICE
function UIActivitiesPanel.OnProcessCalendar(trans, effectTrans, BtnSprite, Button, tableData)

    local timeLabel = CS.Utility_Lua.GetComponent(trans, "UILabel");

    local uiCountdown = CS.Utility_Lua.GetComponent(trans, "UICountdownLabel");
    if (uiCountdown == nil) then
        uiCountdown = trans.gameObject:AddComponent(typeof(CS.UICountdownLabel));
    end

    ---先停止倒计时
    uiCountdown:StopCountDown();

    --local effectTrans = CS.Utility_Lua.GetComponent(effectTrans, "CSUIEffectLoad");
    gameMgr:GetLuaTimeMgr():RemoveTimeRespone(LuaRegisterTimeFinishEvent.CalendarRefresh)
    local nextCalendar = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetNextCalendarItem()
    if (nextCalendar == nil) then
        UIActivitiesPanel:TryShowShareServerTimer(trans, timeLabel, uiCountdown);
        return ;
    end

    UIActivitiesPanel:GetCalendarTipsTemplate():SetCalendarItem(nextCalendar);
    UIActivitiesPanel:GetOutCalendarTipsTemplate():SetCalendarItem(nextCalendar);

    if (nextCalendar.type == LuaEnumCalendarItemType.NormalActivity) then
        local runningState, activityItemSubInfo = nextCalendar.ActivityItem:GetRunningState()
        if (runningState == LuaActivityRunningState.AllOver) then
            return ;
        end

        ---如果不是等级封印 或联服活动
        if (activityItemSubInfo.Tbl:GetActivityType() ~= LuaEnumDailyActivityType.LevelLimit and activityItemSubInfo.Tbl:GetActivityType() ~= LuaEnumDailyActivityType.ShareServer) then
            BtnSprite.spriteName = activityItemSubInfo.Tbl:GetMainIcon();
            local nextStartTimeStamp = nextCalendar.dayTime + activityItemSubInfo.Tbl:GetStartTime() * 60 * 1000
            local nextEndTimeStamp = nextCalendar.dayTime + activityItemSubInfo.Tbl:GetOverTime() * 60 * 1000
            if (runningState == LuaActivityRunningState.NoOpen) then
                effectTrans.gameObject:SetActive(false)
                timeLabel.gameObject:SetActive(true);
                local timeTxt = ""
                timeTxt = tostring(math.floor(activityItemSubInfo.Tbl:GetStartTime() / 60)) .. "点"
                local timeSecond = activityItemSubInfo.Tbl:GetStartTime() % 60;
                if (timeSecond ~= 0) then
                    timeTxt = timeTxt .. tostring(timeSecond) .. "分"
                end

                timeLabel.text = timeTxt .. "开启[-]"

                UIActivitiesPanel:TryOpenCountDownTime(nextStartTimeStamp, uiCountdown, trans.gameObject)
                if (UIActivitiesPanel.mLastCloseActivityId ~= activityItemSubInfo.Tbl:GetId()) then
                    UIActivitiesPanel.mLastCloseActivityId = activityItemSubInfo.Tbl:GetId();
                    --CS.CSScene.Sington.mClient:SendEvent(CS.CEvent.V2_CalendarActivityIsOpen, activityItemSubInfo.Tbl:GetId(), false);
                    UIActivitiesPanel:IsOpenCalendarTips(false, activityItemSubInfo.Tbl);
                end

                --print("活动是结束的,等待"..activityItemSubInfo.Tbl:GetName()..activityItemSubInfo.Tbl:GetId().."     GetNowMinuteTime"..gameMgr:GetLuaTimeMgr():GetNowMinuteTime()
                --        .."     GetStartTime"..activityItemSubInfo.Tbl:GetStartTime().."      GetOverTime:"..activityItemSubInfo.Tbl:GetOverTime())

                gameMgr:GetLuaTimeMgr():RegisterTimeRespone(LuaRegisterTimeFinishEvent.CalendarRefresh, nextStartTimeStamp, function()
                    --print("2222222222222222"..activityItemSubInfo.Tbl:GetName()..activityItemSubInfo.Tbl:GetId().."     GetNowMinuteTime"..gameMgr:GetLuaTimeMgr():GetNowMinuteTime()
                    --        .."     GetStartTime"..activityItemSubInfo.Tbl:GetStartTime().."      GetOverTime:"..activityItemSubInfo.Tbl:GetOverTime())
                    gameMgr:GetPlayerDataMgr():GetActivityMgr():SortTodayCalendar()
                    CS.CSScene.Sington.mClient:SendEvent(CS.CEvent.V2_CalendarActivityIsOpen, activityItemSubInfo.Tbl:GetId(), true);
                    UIActivitiesPanel:IsOpenCalendarTips(true, activityItemSubInfo.Tbl);
                    gameMgr:GetPlayerDataMgr():GetActivityMgr():SortCalendarList()
                    UIActivitiesPanel.ResetActivityBtn();
                end)
            else
                timeLabel.gameObject:SetActive(false);
                effectTrans.gameObject:SetActive(runningState == LuaActivityRunningState.IsRunning)

                --print("活动开启了"..activityItemSubInfo.Tbl:GetName()..activityItemSubInfo.Tbl:GetId().."     GetNowMinuteTime"..gameMgr:GetLuaTimeMgr():GetNowMinuteTime()
                --        .."     GetStartTime"..activityItemSubInfo.Tbl:GetStartTime().."      GetOverTime:"..activityItemSubInfo.Tbl:GetOverTime())

                if (runningState == LuaActivityRunningState.IsRunning) then
                    if (UIActivitiesPanel.mLastOpenActivityId ~= activityItemSubInfo.Tbl:GetId()) then
                        UIActivitiesPanel.mLastOpenActivityId = activityItemSubInfo.Tbl:GetId();
                        --CS.CSScene.Sington.mClient:SendEvent(CS.CEvent.V2_CalendarActivityIsOpen, activityItemSubInfo.Tbl:GetId(), true);
                        UIActivitiesPanel:IsOpenCalendarTips(true, activityItemSubInfo.Tbl);
                    end
                end
                timeLabel.text = ""
                gameMgr:GetLuaTimeMgr():RegisterTimeRespone(LuaRegisterTimeFinishEvent.CalendarRefresh, nextEndTimeStamp + 3000, function()

                    --print("已经开启的活动结束了"..activityItemSubInfo.Tbl:GetName()..activityItemSubInfo.Tbl:GetId().."     GetNowMinuteTime"..gameMgr:GetLuaTimeMgr():GetNowMinuteTime()
                    --        .."     GetStartTime"..activityItemSubInfo.Tbl:GetStartTime().."      GetOverTime:"..activityItemSubInfo.Tbl:GetOverTime())

                    CS.CSScene.Sington.mClient:SendEvent(CS.CEvent.V2_CalendarActivityIsOpen, activityItemSubInfo.Tbl:GetId(), false);
                    UIActivitiesPanel:IsOpenCalendarTips(false, activityItemSubInfo.Tbl);
                    gameMgr:GetPlayerDataMgr():GetActivityMgr():SortCalendarList()
                    UIActivitiesPanel.ResetActivityBtn();
                end)
            end
        else
            UIActivitiesPanel:TryShowShareServerTimer(trans, timeLabel, uiCountdown);
        end

    end

end

function UIActivitiesPanel:TryShowShareServerTimer(trans, timeLabel, uiCountdown)

    --首次联服开始之前预告
    if (gameMgr:GetPlayerDataMgr():GetShareMapInfo():GetOpenKuaFuNum() == 0) then
        trans.gameObject:SetActive(true);
        if (gameMgr:GetPlayerDataMgr():GetShareMapInfo().mBasicData ~= nil) then
            local endDay = math.floor((gameMgr:GetPlayerDataMgr():GetShareMapInfo().mBasicData.willUniteUnionTimeOpen - 28800000) / 86400000)
            local nowDay = math.floor((CS.CSServerTime.Instance.TotalMillisecond - 28800000) / 86400000)
            if (endDay - nowDay > 0) then
                timeLabel.text = "联服还有" .. tostring(endDay - nowDay) .. "天"
            else
                if (gameMgr:GetPlayerDataMgr():GetShareMapInfo().mBasicData.willUniteUnionTimeOpen < CS.CSServerTime.Instance.TotalMillisecond) then
                    uiCountdown:StopCountDown();
                    CS.UnityEngine.GameObject.Destroy(uiCountdown)
                    timeLabel.text = ""
                    return
                else
                    uiCountdown:StartCountDown(nil, 6, gameMgr:GetPlayerDataMgr():GetShareMapInfo().mBasicData.willUniteUnionTimeOpen, luaEnumColorType.Red .. "联服", nil, nil, function()
                        uiCountdown:StopCountDown()
                        uiCountdown.gameObject:SetActive(false)
                    end)
                    local finishTime = gameMgr:GetPlayerDataMgr():GetShareMapInfo().mBasicData.willUniteUnionTimeOpen + 3000
                    gameMgr:GetLuaTimeMgr():RegisterTimeRespone(LuaRegisterTimeFinishEvent.CalendarRefresh, finishTime, function()
                        CS.UnityEngine.GameObject.Destroy(uiCountdown)
                        gameMgr:GetPlayerDataMgr():GetActivityMgr():InitCalendarCatalog()
                        UIActivitiesPanel.ResetActivityBtn();
                    end)
                end
            end
        end
    end
end

---@class CalenderNextTimeCountDownInfo
---@field mNextTime number 活动开启前十分钟时间戳
---@field uiCountdown UICountdownLabel 倒计时组件
---@field mEndTime UICountdownLabel 倒计时组件

---在此方法中添加的时间，都会每秒刷新，直到到达开启时间前十分钟进行倒计时，并在结束后关闭组件
---@param nextStartTimeStamp number 下次活动开启时间戳（ms）
---@param uiCountdown UICountdownLabel 倒计时组件
function UIActivitiesPanel:TryOpenCountDownTime(nextStartTimeStamp, uiCountdown)
    if nextStartTimeStamp == nil or uiCountdown == nil then
        return
    end

    local currentTime = CS.CSServerTime.Instance.TotalMillisecond
    local countDownTime = nextStartTimeStamp - 10 * 60 * 1000
    ---已经在开启时间了直接倒计时，不进update判断
    if currentTime - countDownTime >= 0 then
        uiCountdown:StartCountDown(nil, 6, nextStartTimeStamp, luaEnumColorType.Red, nil, nil, function()
            uiCountdown:StopCountDown()
            uiCountdown.gameObject:SetActive(false)
        end)
        return
    end

    if self.mGoToTimeCountInfo == nil then
        ---@type table<UnityEngine.GameObject,CalenderNextTimeCountDownInfo>
        self.mGoToTimeCountInfo = {}
    end
    ---@type CalenderNextTimeCountDownInfo
    local nextTimeCount = self.mGoToTimeCountInfo[nextStartTimeStamp]
    if nextTimeCount == nil then
        nextTimeCount = {}
    end
    if nextStartTimeStamp == nextTimeCount.NextTime then
        return
    end
    nextTimeCount.mEndTime = nextStartTimeStamp
    nextTimeCount.mNextTime = countDownTime
    nextTimeCount.uiCountdown = uiCountdown
    self.mGoToTimeCountInfo[nextStartTimeStamp] = nextTimeCount
end

---活动时间刷新
function UIActivitiesPanel:UpdateActivityOpenTime()
    if self.mActivityTimeCount == nil then
        self.mActivityTimeCount = CS.UnityEngine.Time.time
    end
    if self.mGoToTimeCountInfo and Utility.GetTableCount(self.mGoToTimeCountInfo) > 0 and CS.UnityEngine.Time.time - self.mActivityTimeCount >= 1 then
        self.mActivityTimeCount = CS.UnityEngine.Time.time
        local currentTime = CS.CSServerTime.Instance.TotalMillisecond
        for k, timeInfo in pairs(self.mGoToTimeCountInfo) do
            if currentTime - timeInfo.mNextTime >= 0 then
                self.mGoToTimeCountInfo[k] = nil
                timeInfo.uiCountdown:StartCountDown(nil, 6, timeInfo.mEndTime, luaEnumColorType.Red, nil, nil, function()
                    timeInfo.uiCountdown:StopCountDown()
                    timeInfo.uiCountdown.gameObject:SetActive(false)
                end)
            end
        end
    end
end

---注：(需和里层同id活动按钮同样的红点key，否则会出现里层按钮高亮，外层按钮不显示)
function UIActivitiesPanel.InitOutRedPoint()
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[Utility.EnumToInt(CS.RedPointKey.Activity_Competition)] = luaEnumActivityBtnType.Competition
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[Utility.EnumToInt(CS.RedPointKey.Activity_Competition_Recycle)] = luaEnumActivityBtnType.Competition

    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[Utility.EnumToInt(CS.RedPointKey.Active_MainMenuButton)] = luaEnumActivityBtnType.DaJin
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[Utility.EnumToInt(CS.RedPointKey.Commerce_MainMenuButton)] = luaEnumActivityBtnType.Commerce
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[Utility.EnumToInt(CS.RedPointKey.BOSS_ALL)] = luaEnumActivityBtnType.Boss
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[Utility.EnumToInt(CS.RedPointKey.Recharge_FirstReward)] = luaEnumActivityBtnType.FirstRechargeReward
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[Utility.EnumToInt(CS.RedPointKey.Rank_All)] = luaEnumActivityBtnType.Rank
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[Utility.EnumToInt(CS.RedPointKey.Treasure_Warehouse)] = luaEnumActivityBtnType.Treasure
    --CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[CS.RedPointKey.Treasure_TaLuoPai] = luaEnumActivityBtnType.Treasure
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[Utility.EnumToInt(CS.RedPointKey.Overlord_All)] = luaEnumActivityBtnType.ContantRank
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[Utility.EnumToInt(CS.RedPointKey.AuctionAll)] = luaEnumActivityBtnType.Auction
    local SpecialActivity_KuaFu = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.SpecialActivity_KuaFu);
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[SpecialActivity_KuaFu] = luaEnumActivityBtnType.SpecialActivity_KuaFu
    local SpecialActivity_Limit = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.SpecialActivity_Limit);
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[SpecialActivity_Limit] = luaEnumActivityBtnType.SpecialActivity_Limit
    local baiRiMenMainPanelRedPoint = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BaiRiMenActivity_MainPanelRedPoint);
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[baiRiMenMainPanelRedPoint] = luaEnumActivityBtnType.BaiRiMenActivity
    local lsMission_AllRedPoint = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LsMission_All);
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[lsMission_AllRedPoint] = luaEnumActivityBtnType.LsMission

    local MemberPanelReward = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.MemberPanelRewardRedPoint);
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[MemberPanelReward] = luaEnumActivityBtnType.MemberPanel

    local MonsterArrest = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.MonsterArrest)
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[MonsterArrest] = luaEnumActivityBtnType.EliteOffer
    --领奖
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[Utility.EnumToInt(CS.RedPointKey.Recharge)] = luaEnumActivityBtnType.Recharge
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[Utility.EnumToInt(CS.RedPointKey.Recharge_Reward)] = luaEnumActivityBtnType.Recharge
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[Utility.EnumToInt(CS.RedPointKey.Recharge_ContinueReward)] = luaEnumActivityBtnType.Recharge
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[Utility.EnumToInt(CS.RedPointKey.Activity_Competition_FirstKill)] = luaEnumActivityBtnType.Recharge
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[Utility.EnumToInt(CS.RedPointKey.Activity_Competition_FirstDrop)] = luaEnumActivityBtnType.Recharge
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[Utility.EnumToInt(CS.RedPointKey.Activity_Competition_Recycle)] = luaEnumActivityBtnType.Recharge
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[Utility.EnumToInt(CS.RedPointKey.Activity_Competition_ServerOpen)] = luaEnumActivityBtnType.Recharge
    local Investment_All = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Investment_All);
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[Investment_All] = luaEnumActivityBtnType.Recharge
    local AccumulatedRecharge = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.AccumulatedRecharge);
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[AccumulatedRecharge] = luaEnumActivityBtnType.Recharge
    local PotentialInvest = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.PotentialInvestRedPoint);
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[PotentialInvest] = luaEnumActivityBtnType.Recharge
    local LianChong = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LianChongRedPoint);
    CS.Cfg_NoticeTableManager.Instance.RedNoticeDic[LianChong] = luaEnumActivityBtnType.Recharge
end

---活动面板排序
function UIActivitiesPanel.SortActivityBtn(a, b)
    if a and b then
        return a.order < b.order
    end
    return false
end

function UIActivitiesPanel.InitArrowEffect()
    if UIActivitiesPanel.GetArrowEffect_RedPoint() == nil or CS.StaticUtility.IsNull(UIActivitiesPanel.GetArrowEffect_RedPoint()) then
        return
    end
    UIActivitiesPanel.GetArrowEffect_RedPoint():RemoveRedPointKey()
    --UIActivitiesPanel.AllRedKey = {}
    for i, v in pairs(UIActivitiesPanel.AllRedKey) do
        UIActivitiesPanel.GetArrowEffect_RedPoint():AddRedPointKey(v)
    end
end

function UIActivitiesPanel.OnCalendarActivityIsOpen(id, data)
    UIActivitiesPanel.OnRefreshOutActivity();
    UIActivitiesPanel.ResetActivityBtn();
end

--endregion

--region 检测是否开启按钮
---检测开放判断方法
---@param 表中的开放类型
---@param 表中对应的参数
function UIActivitiesPanel.CheckOpenType(openType, canshu)
    if openType == LuaEnumActivitiesOpenType.OpenServerDays then
        return true
        --开服时间未做,暂时不考虑
        --return UIActivitiesPanel.CheckCanshu(canshu, CS.CSScene.MainPlayerInfo.openServerDays)

    elseif openType == LuaEnumActivitiesOpenType.MergeServerDays then
        --CS.UnityEngine.Debug.LogError("暂无合服时间")
        --开服时间未做,暂时不考虑
        return true
        --return UIActivitiesPanel.CheckOpenType(openType[0],openType[1],CS.CSScene.MainPlayerInfo.openServerDays)

    elseif openType == LuaEnumActivitiesOpenType.CurDate then
        --return false
        return UIActivitiesPanel.CheckCanshuData(canshu, CS.CSServerTime.Now.Day, CS.CSServerTime.Now.Month)

    elseif openType == LuaEnumActivitiesOpenType.PlayerLevel then
        --return true
        return UIActivitiesPanel.CheckCanshu(canshu, CS.CSScene.MainPlayerInfo.Level)

    elseif openType == LuaEnumActivitiesOpenType.PlayerReinLevel then
        --return false
        return UIActivitiesPanel.CheckCanshu(canshu, CS.CSScene.MainPlayerInfo.ReinLevel)
    end
end

---检测参数,解析参数格式（value#value）
---@param 表中对应的参数
---@param 表中对应的参数,比较的参数
function UIActivitiesPanel.CheckCanshu(canshu, nowvalue)
    local value = string.Split(canshu, "#")
    if nowvalue >= tonumber(value[1]) and nowvalue <= tonumber(value[2]) then
        return true
    else
        return false
    end
end
---检测日期参数,解析参数格式（value_value#value_value）
---@param 表中对应的参数
---@param 表中对应的参数,比较的参数
function UIActivitiesPanel.CheckCanshuData(canshu, day, month)
    local value = string.Split(canshu, "#")
    local mindayformonth = string.Split(value[1], "_")
    local maxdayformonth = string.Split(value[2], "_")
    if month >= tonumber(mindayformonth[1]) and month <= tonumber(maxdayformonth[1]) and day >= tonumber(mindayformonth[2]) and day <= tonumber(maxdayformonth[2]) then
        return true
    end
    return false
end
--endregion

--endregion

--region对外开放功能
---检测排版
function UIActivitiesPanel.CheckResetActivityBtn()
    if UIActivitiesPanel.CheckNeedResetActivityBtn() then
        gameMgr:GetPlayerDataMgr():GetActivityMgr():SortCalendarList()
        UIActivitiesPanel.ResetActivityBtn()
    else
    end
end

---检测是否要重新排版
function UIActivitiesPanel.CheckNeedResetActivityBtn()
    local mActivityTable = CS.Cfg_NoticeTableManager.Instance
    local TableRows = mActivityTable.dic.Count
    local NowActivityTable = UIActivitiesPanel.ActivitiesPanelBtnRowTable
    local BtnRowCount = 0
    for row = 1, TableRows do
        local nowRowTable = mActivityTable:getActivityBtnDa(row)
        if row == 1 then
        else
            --依次检测所有的活动按钮
            -- if UIActivitiesPanel.CheckOpenType(nowRowTable.openType, nowRowTable.canshu) then
            --检测是否需要打开
            BtnRowCount = BtnRowCount + 1
            if BtnRowCount <= #NowActivityTable then
                if row ~= NowActivityTable[BtnRowCount] then
                    return true
                end
            else
                return true
            end
            --  end
        end
    end
    return false
end

---检测当前是否要进行排版
---@param 当前按钮的开关状态
---@param 读表后得到的按钮的开关状态
function UIActivitiesPanel.CheckNeedReset(nowBool, NeedBool)
    if nowBool == NeedBool then
        return false
    else
        return true
    end
end

---检查按钮是否存在
---@param 按钮所在的行
---@param 按钮的名字
function UIActivitiesPanel.CheckBtnIsOpen(BtnRow, BtnName)
    if UIActivitiesPanel.GetActivityGrid().transform.GetChild(BtnRow).Find(BtnName) then
        return true
    end
    return false
end

---设置地图物体激活状态
function UIActivitiesPanel.SetMapObjActive(isActive)
    UIActivitiesPanel.MapGameObject():SetActive(isActive)
end

function UIActivitiesPanel:SwitchAcitivitiesState(state)
    UIActivitiesPanel.UIActivitiesPanelState = state
    UIActivitiesPanel.OnArrowClick()
end
--endregion


--region 红点回调注册
function UIActivitiesPanel:BindLuaRedPointCallBack()
    self.CompetitionRecycleRedPointCallBacks = function()
        if uiStaticParameter.CompetitionData and uiStaticParameter.CompetitionData.activityType == luaEnumCompetitionType.Recycle then
            local allData = {}
            local itemIdToActivity = {}
            for i = 0, uiStaticParameter.CompetitionData.info.activityDataInfo.Count - 1 do
                ---@type activityV2.ActivityDataInfo
                local singleInfo = uiStaticParameter.CompetitionData.info.activityDataInfo[i]
                if singleInfo.leftCount > 0 and singleInfo.roleGoalInfo and singleInfo.roleGoalInfo.rewardState ~= 2 then
                    local res, commmonInfo = CS.Cfg_Activity_CommonTableManager.Instance.dic:TryGetValue(singleInfo.activityId)
                    if res then
                        local goalIds = commmonInfo.goalIds
                        if goalIds and goalIds.list and goalIds.list.Count > 0 then
                            local goalId = goalIds.list[0]
                            local res1, goalInfo = CS.Cfg_ActivityGoalsTableManager.Instance.dic:TryGetValue(goalId)
                            if res1 then
                                local aims = goalInfo.goalParam
                                if aims then
                                    local hasItem = gameMgr:GetPlayerDataMgr():GetCompetitionDataMgr():HasRecycleItemInBag(aims)
                                    if hasItem then
                                        uiStaticParameter.mCompetitionRecycleRedPointActivityId = singleInfo.activityId
                                        uiStaticParameter.IsShowCompetitionRecycleRedPoint = true
                                        return true
                                    end
                                end
                            end
                        end
                    end
                end
            end
            uiStaticParameter.mCompetitionRecycleRedPointActivityId = -1
            uiStaticParameter.IsShowCompetitionRecycleRedPoint = false
            return false
        else
            uiStaticParameter.mCompetitionRecycleRedPointActivityId = -1
            uiStaticParameter.IsShowCompetitionRecycleRedPoint = false
            return false
        end
    end
    CS.CSUIRedPointManager.GetInstance():RegisterLuaCallRedPointFunction(CS.RedPointKey.Activity_Competition_Recycle, self.CompetitionRecycleRedPointCallBacks)

    local SpecialActivity_KuaFu = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.SpecialActivity_KuaFu);
    CS.CSUIRedPointManager.GetInstance():RegisterLuaCallRedPointFunction(SpecialActivity_KuaFu, function()
        return gameMgr:GetPlayerDataMgr():GetSpecialActivityData():IsAnyActivityHasRedPoint()
    end)
    local SpecialActivity_Limit = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.SpecialActivity_Limit);
    CS.CSUIRedPointManager.GetInstance():RegisterLuaCallRedPointFunction(SpecialActivity_Limit, function()
        return gameMgr:GetPlayerDataMgr():GetSpecialActivityData():IsAnyActivityHasRedPoint()
    end)

    gameMgr:GetPlayerDataMgr():GetSpecialActivityData():CallAllRedPoint()
end
--endregion

--region OnDestroy
function ondestroy()
    UIActivitiesPanel:GetClientEventHandler():RemoveEvent(CS.CEvent.Role_UpdateActiveInfo, UIActivitiesPanel.ResetActivityBtn)

    CS.CSUIRedPointManager.GetInstance():RemoveLuaCallRedPointFunction(CS.RedPointKey.Activity_Competition_Recycle)

    if (UIActivitiesPanel.mCoroutineNextUpdateTimer ~= nil) then
        StopCoroutine(UIActivitiesPanel.mCoroutineNextUpdateTimer);
        UIActivitiesPanel.mCoroutineNextUpdateTimer = nil;
    end

    if (UIActivitiesPanel.mCoroutineSetOutActivityBtn ~= nil) then
        StopCoroutine(UIActivitiesPanel.mCoroutineSetOutActivityBtn);
        UIActivitiesPanel.mCoroutineSetOutActivityBtn = nil;
    end
end
--endregion

--region update
function update()
    UIActivitiesPanel:UpdateActivityOpenTime()
end
--endregion

return UIActivitiesPanel