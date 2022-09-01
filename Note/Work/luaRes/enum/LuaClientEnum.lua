---客户端Lua事件枚举
---事件枚举命名规则:
---    系统名_操作说明,按照驼峰命名法命名
---    如果能够确定某事件不能简单的归分到某个系统中,则定义在Common中,加入之前请务必想清楚
---枚举值规则:
---    同一系统的事件放在同一个region折叠区,从上向下依次增1
---    每个系统分配1000长度的ID
---每个系统均以region块折叠,以便分类查找
---每添加一个枚举值,都需要在枚举上加上注释,说明 1.枚举值的含义  2.枚举值对应的参数个数、意义
---@class LuaCEvent
LuaCEvent = {}

--region ID:0  Common
---通用，参考示例，每个消息都应当有这样的注释，无参数
LuaCEvent.Common_ForExample = 0000
---零点事件
LuaCEvent.Common_ZeroEvent = 0001
--endregion

--region ID:1 Bag
---背包格子单击事件,若该消息上绑定了方法,则在背包被点击时不触发原有事件
---参数1 bagV2.BagItemInfo
LuaCEvent.Bag_GridSingleClicked = 1001
---背包格子双击事件,若该消息上绑定了方法,则在背包被点击时不触发原有事件
---参数1 bagV2.BagItemInfo
LuaCEvent.Bag_GridDoubleClicked = 1002
---背包格子长按事件,若该消息上绑定了方法,则在背包被点击时不触发原有事件
---参数1 bagV2.BagItemInfo
LuaCEvent.Bag_GridHolden = 1003
---背包界面箭头点击事件,若该消息上绑定了方法,则在背包被点击时不触发原有事件
---参数1 bagV2.BagItemInfo
LuaCEvent.Bag_ArrowBtnClicked = 1004
---背包格子按下事件,若该消息上绑定了方法,则在背包被点击时不触发原有事件
---参数1 bagV2.BagItemInfo
LuaCEvent.Bag_GirdPressed = 1006
---背包开始拖拽事件,若该消息上绑定了方法,则在背包被点击时不触发原有事件
LuaCEvent.Bag_GirdStartDrag = 1007
---背包持续拖拽事件,若该消息上绑定了方法,则在背包被点击时不触发原有事件
LuaCEvent.Bag_GirdDrag = 1008
---背包结束拖拽事件,若该消息上绑定了方法,则在背包被点击时不触发原有事件
LuaCEvent.Bag_GirdEndDrag = 1009
---背包控制高光特效事件（开启和关闭）
---参数1 bool(true:开启高光特效 false:关闭高光特效)
LuaCEvent.Bag_ControlBagGirdHighLightEffect = 1010
---背包打开事件
LuaCEvent.Bag_BagPanelIsOpen = 1011
---背包关闭事件
LuaCEvent.Bag_BagPanelIsClose = 1012
---背包切换神力页签事件
LuaCEvent.Bag_BagPanelChangeSLPage = 1013
---自动回收使用事件
LuaCEvent.Bag_AutoRecycleUse = 1014
--endregion

--region ID:2 Role
---装备格子单击事件,若该消息上绑定了方法,则在装备格子点击时不触发原有事件
---参数1 RolePanel_EquipShow
LuaCEvent.Role_EquipGridClicked = 2001
---角色界面属性展示箭头点击事件，若该消息上绑定了方法,则在装备格子点击时不触发原有事件
---参数1 0：关闭 1：开启
LuaCEvent.Role_ArrowBtnClicked = 2002
---装备格子按下事件，若该消息上绑定了方法,则在装备格子点击时不触发原有事件
---参数1 ItemInfo
LuaCEvent.Role_EquipGridPressed = 2003
---装备格子开始拖拽事件，若该消息上绑定了方法,则在装备格子点击时不触发原有事件fA
---参数1 ItemInfo
LuaCEvent.Role_EquipGridStartDrag = 2004
---装备格子持续拖拽事件，若该消息上绑定了方法,则在装备格子点击时不触发原有事件
---参数1 ItemInfo
LuaCEvent.Role_EquipGridDrag = 2005
---装备格子结束拖拽事件，若该消息上绑定了方法,则在装备格子点击时不触发原有事件
LuaCEvent.Role_EquipGridEndDrag = 2006
---装备格子刷新事件，若改消息上绑定了方法，则在装备格子点击时不触发原有事件
LuaCEvent.Role_EquipGridRefresh = 2007
---将背包物品拖放到角色界面
---参数1: type:LuaEnumDropBagItemOnRolePanelType
---参数2: position:UnityEngine.Vector3
---参数3: bagItemInfo:bagV2.BagItemInfo
LuaCEvent.Role_DropBagItemOnRolePanel = 2008
---角色界面切换到神力界面状态
LuaCEvent.RolePanelChangeToDivineEquipState = 2009
--endregion

--region ID:4 Map
---玩家切换地图事件
---参数1 NetMsgPreprocessing_Map
LuaCEvent.Map_ResPlayerChangeMap = 4001
--endregion

--region ID:5 Navigation
---导航栏点击事件
---参数1 表数据
LuaCEvent.Navigation_OnClickUnit = 5001

---选择导航栏
---参数1 customData
--- customData.targetId (必填参数 nav表id)
--- customData.other (界面所需的其他参数 选填)
LuaCEvent.Navigation_OpenWithId = 5002

---导航栏渐入完毕
LuaCEvent.Navigation_OnFirstMenuFadeInFished = 5003

---导航栏刷新
LuaCEvent.Navigation_UpdateUnit = 5004

---导航栏打开某个界面
---参数1 界面名
LuaCEvent.Navigation_OpenPanelFinished = 5005

---关闭导航栏和其打开的面板
LuaCEvent.Navigation_CloseNavAndPanel = 5006

---导航栏关闭
LuaCEvent.Navigation_OnCloseFinished = 5007

---导航栏打开
LuaCEvent.Navigation_OnOpenFinished = 5008
--endregion

--region id:6 Union 行会/帮会
---帮会关闭按钮点击事件
LuaCEvent.Union_ClosePanel = 6001
---刷新行会熔炼仓库
LuaCEvent.RefreshUnionSmeltWarehouse = 6002
--endregion

--region id:7 ItemInfoPanel
---物品信息面板技能书使用按钮点击事件
LuaCEvent.ItemInfoPanel_SkillUseBtnClick = 7001
---物品信息面使用按钮点击闪烁事件
LuaCEvent.ItemInfoPanel_UseBtnClickBlink = 7002
---物品信息界面闪烁对象添加事件
LuaCEvent.ItemInfoPanel_AddBlinkList = 7003
---物品信息界面闪烁对象移除事件
LuaCEvent.ItemInfoPanel_RemoveBlinkList = 7004
--endregion

--region id:8 灵兽
---元灵属性面板拓展按钮
LuaCEvent.ServantArrowClicked = 8001

---元灵装备按钮点击
LuaCEvent.Servant_GridClicked = 8002

---元灵页签面板点击
---参数1 元灵界面类型
LuaCEvent.Servant_OnClickServantTag = 8003

---元灵背包打开事件
------参数1 UIBagPanel
LuaCEvent.Servant_OpenBagPanel = 8004

---元灵属性变化事件
------参数1 List<servantV2.ServantAttribute>
LuaCEvent.Servant_AttributeChange = 8005

---灵兽装备合成点击
LuaCEvent.Servant_OnEquipSynthesisClick = 8006

---灵兽装备炼化点击
LuaCEvent.Servant_OnEquipRefineClick = 8007
--endregion

--region id:9 Skill
---心法技能icon点击事件
---参数1 UIHeartSkillUnitTemplate
LuaCEvent.Skill_OnHeartSkillUnitClicked = 9001

---心阵格子点击事件
---参数1 秘籍技能类型
LuaCEvent.Skill_OnHeartSkillFormationUnitClicked = 9002

---心阵点击选择心阵
---参数1 当前选择的单元
LuaCEvent.Skill_OnHeartSkillFormationChooseClicked = 9003

---心阵点击使用心法
LuaCEvent.Skill_OnHeartSkillUseButtonClick = 9004

---技能自动释放开关设置
LuaCEvent.Skill_AutoRelease = 9005
---技能刷新
LuaCEvent.Skill_Refresh = 9006
---xp技能能量变化
LuaCEvent.XPSkillEnergyChanged = 9007
---xp技能变化
LuaCEvent.XPSkillChanged = 9008
---xp技能进入CD状态
LuaCEvent.XPSkillSliderIsInCD = 9009
---xp技能解除CD状态
LuaCEvent.XPSkillSliderCDFinished = 9010
--endregion

--region id:10 MainMenus

---左侧渐隐
---参数1 界面名
LuaCEvent.MainMenus_LeftFadeOut = 10001
---左侧渐入
---参数1 界面名
LuaCEvent.MainMenus_LeftFadeIn = 10002

---右侧渐隐
------参数1 界面名
LuaCEvent.MainMenus_RightFadeOut = 10003
---右侧渐入
------参数1 界面名
LuaCEvent.MainMenus_RightFadeIn = 10004
--endregion

--region id:11 MainChatPanel
---主界面背包按钮
LuaCEvent.MainChatPanel_BtnBag = 11001

---主界面社交
---参数1 界面打开类型
LuaCEvent.MainChatPanel_OpenSocialPanel = 11002

---主界面社交打开按钮回调
LuaCEvent.MainChatPanel_OnOpenPanelFinished = 11003

---聊天框上方物品向上自适应
LuaCEvent.MainChatPanel_UpAdaptive = 11004

---关闭MainChat界面消息
LuaCEvent.CloseMainChatPanel = 11005
--endregion

--region id:12 Repair 维修
---背包/角色/灵兽选中格子改变
LuaCEvent.RepairChooseListChange = 12001
---维修界面选中背包格子改变
LuaCEvent.RepairChooseBagGridChange = 12002
---维修界面选中角色格子改变
LuaCEvent.RepairChooseRoleGridChange = 12003
---维修界面选中灵兽格子改变
LuaCEvent.RepairChooseServantGridChange = 12004
---维修获取刷新后选中列表
LuaCEvent.RepairGetRefreshChooseList = 12005
---神力装备格子选中
LuaCEvent.RepairSLEquipGridClicked = 12006
---维修选中
LuaCEvent.RepairChooseItemChange = 12007
--endregion

--region id:13 进化
---进化添加材料成功
LuaCEvent.Evolution_OnAddCostSuccess = 13001

---进化添加材料按钮点击
---参数1 index 按钮索引
LuaCEvent.Evolution_OnAddCostButtonClick = 13002

---进化切换装备
---参数1 bagV2.BagItemInfo 
LuaCEvent.Evolution_OnChangeEquip = 13003

---进化减少材料按钮点击
---参数1 index 按钮索引
LuaCEvent.Evolution_OnLessCostSuccess = 13003

---进化背包格子点击
LuaCEvent.Evolution_OnBagGridClicked = 13004

---进化切换物品
LuaCEvent.Evolution_OnChangeItem = 13005
--endregion

--region id:14 Config
---双摇杆设置切换
LuaCEvent.DoubleJoysticksStatuChange = 14001
--endregion

--region id:15 Storage仓库
LuaCEvent.CloseStorage = 15001
---打捆高亮选中
LuaCEvent.BundlingPitch = 15002
---拖拽物品放到仓库界面内
---参数1: position:UnityEngine.Vector3
---参数2: bagItemInfo:bagV2.BagItemInfo
LuaCEvent.Storage_DropItemOnStoragePanel = 15003
--endregion

--region id:16 Auction 拍卖行
---拍卖行背包格子点击事件
LuaCEvent.AuctionBagItemClicked = 16001
--- 16002已弃用，可重新定义
---竞拍重新上架
LuaCEvent.AuctionItemReAdd = 16003
---拍卖行道具切换购买状态（元宝）
LuaCEvent.AuctionItemChangeBuyState = 16004
---拍卖行道具切换竞价状态（钻石）
LuaCEvent.AuctionBidItemChangeBidState = 16005
---拍卖行道具切换购买状态（钻石）
LuaCEvent.AuctionBidItemChangeBuyState = 16006
---拍卖行道具切换购买状态（摊位）
LuaCEvent.AuctionStallItemChangeBuyState = 16007
---拍卖行购买道具（元宝交易行）
LuaCEvent.AuctionBuyTradeItem = 16008
---竞拍行购买道具（钻石交易行）
LuaCEvent.AuctionBuyAuctionItem = 16009
---摊位购买道具
LuaCEvent.StallBuyItem = 16010
---求购下架道具发送是否过期
LuaCEvent.AuctionBuyRemoveItem = 16011
---交易行重新上架道具类型
LuaCEvent.mCurrentReAddItemState = 16012
---交易行熔炼目录选中发生变化
LuaCEvent.AuctionSmeltMenuChange = 16013
---购买单个熔炼道具
LuaCEvent.TryBuySmeltItem = 16014
---购买多个熔炼道具
LuaCEvent.SmeltBuyNumItem = 16015
---行会竞拍目录改变
LuaCEvent.mAuctionUnionMenuChange = 16016
---行会竞拍单个道具
LuaCEvent.mAuctionUnionTryBidItem = 16017
---行会竞拍一口价单个道具
LuaCEvent.mAuctionUnionTryBuyItem = 16018
--endregion

--region id 17 Team 队伍

LuaCEvent.Team_OnJoinTeamStateChange = 17001

--endregion

--region 1d 18 朋友圈
---参数1 friendV2.FriendInfo
LuaCEvent.Friend_OnCircleOfFriendsUpdateTipsClick = 18001

---朋友圈类型变动
---参数1
LuaCEvent.Friend_OnCircleOfFriendsTypeChanged = 18002

--endregion

--region 1d 19 印记
---初始选择装备
LuaCEvent.Signet_SelectEquipShow = 19001
---设置单个镶嵌icon信息
LuaCEvent.Signet_SelectOneItemInfo = 19002
---设置所有镶嵌icon信息
LuaCEvent.Signet_SelectAllItemInfo = 19003
---选择完成返回消息
LuaCEvent.Signet_SelectCompleteBackInfo = 19004
--endregion

--region id 20 任务

LuaCEvent.Task_NotHaveItem = 20001
---做任务
LuaCEvent.Task_GotoTask = 20002
---购买材料
LuaCEvent.Task_BuyItem = 20003
---商店选择取消
LuaCEvent.Task_UnShopSelect = 20004
---任务-圣域
LuaCEvent.Task_ShengYu = 20005
---任务-烟花
LuaCEvent.Task_YanHua = 20006
---精英任务选择等级
LuaCEvent.Task_EliteSelectLevel = 20007
---任务-闯天关
LuaCEvent.Task_CrawlTower = 20008
---任务-挑战boss
LuaCEvent.ChallengeBossDataChange = 20009
---任务-怪物悬赏
LuaCEvent.MonsterArrestDataChange = 20010
---任务-怪物悬赏(由于其他原因/等级等导致的刷新)
LuaCEvent.RefreshArrestMissionShow = 20011
---任务-灵魂任务
LuaCEvent.RefreshLingHunMission = 20012
--endregion

--region id 21 气泡提示
LuaCEvent.RecycleTipsIsOpenWithBagBtnClick = 21001
--endregion

--region id 22 快捷栏
---快捷栏刷新随机石特效
LuaCEvent.FastUseItem_UpdateRandomStoneEffect = 22001

--endregion

--region id:23 锻造
---升星背包道具选中改变
LuaCEvent.StrengthenBagItemChange = 23001
---被转移道具选中改变（左）
LuaCEvent.OriginTransferBagItemChange = 23002
---转移道具选中改变（右）
LuaCEvent.AimTransferBagItemChange = 23003
--endregion

--region id:25 合成
---合成点击背包
---bagItemInfo
LuaCEvent.Synthesis_OnBagItemClicked = 25001;
---合成系统改变选择
LuaCEvent.Synthesis_OnChangeItem = 25002;
---选择合成目标
---参数1 synthesisId number 合成表ID
LuaCEvent.Synthesis_OnSelectSynthesisTarget = 25003;
---合成灵兽界面点击头像
LuaCEvent.Synthesis_OnServantHeadClicked = 25004;

---合成列表界面主类型按钮点击
---参数1 data:table {unit:UISynthesisMainCategoryPage 页签按钮自身, type:number 按钮类型}
LuaCEvent.Synthesis_CallOnSynthesisMainCategoryOnClick = 25005;

---合成列表界面分类按钮点击
---参数1 data:table {unit:UISynthesisMainCategoryPage 页签按钮自身, type:number 按钮类型}
LuaCEvent.Synthesis_CallOnSynthesisSubCategoryOnClick = 25006;

---合成列表界面分类按钮点击
---参数1 data:table {unit:UISynthesisMainCategoryPage 页签按钮自身, type:number 按钮类型}
LuaCEvent.Synthesis_CallOnSynthesisItemOnClick = 25007;

---合成列表界面结果点击
---参数1 TABLE.CFG_ITEM
LuaCEvent.Synthesis_OnSynthesisListTargetClick = 25008;

---合成切换主材料
---参数1 合成表
LuaCEvent.Synthesis_OnSynthesisTargetChoose = 25009;

---刷新合成界面UI事件
LuaCEvent.Synthesis_UpdateUI = 25010;
--endregion

--region id:26 历法
---参数1 customData table
LuaCEvent.Calendar_SelectDate = 26001;

---心跳包同步时间之后初始化历法
LuaCEvent.Calendar_OnHeartBeatInitCalendar = 26002

---历法当查看的日期变化
LuaCEvent.Calendar_OnCurrentTimeStampUtcChanged = 26003;

---历法日期点击
LuaCEvent.Calendar_OnCalendarDateUnitClicked = 26004

---历法活动状态改变
LuaCEvent.Calendar_OnActivityStateChange = 26005

---历法小礼包状态改变
LuaCEvent.Calendar_OnCalendarGiftStateChange = 26006
--endregion

--region id:27 日常任务
---参数1 CSMission 设置当前任务
LuaCEvent.DailyTasks_SetCurTask = 27001;
--endregion

--region id:28 主界面活动按钮栏

---打开主界活动按钮
LuaCEvent.ActivityButtons_OpenButtons = 28001;

---当主界面活动按钮打开
LuaCEvent.ActivityButtons_OnButtonsOpened = 28002;

---关闭主界面活动按钮
LuaCEvent.ActivityButtons_CloseButtons = 28003;

---当主界面活动按钮关闭
LuaCEvent.ActivityButtons_OnButtonsClosed = 28004;

---主界面活动按钮更新
LuaCEvent.ActivityButtons_CalendarButtonUpdate = 28005;

--endregion

--region id:29 日常活跃

LuaCEvent.Active_UpdateActive = 29001;

--endregion

--region id:30 关闭面板

LuaCEvent.ClosePanel = 30001;

--endregion

--region id:31 炼制大师
LuaCEvent.SendMiddleTopTips = 31001;
--endregion

--region id:32 聊天
---聊天点击背包格子
LuaCEvent.OnClickChatBagItem = 32001
---帮会聊天点击背包格子
LuaCEvent.OnClickUnionChatBagItem = 32002
---朋友圈点击背包格子
LuaCEvent.OnClickFriendCircle = 32003
--endregion

--region id:33 血继熔炼
LuaCEvent.BloodSuitSmeltChooseItemChange = 33001

---血炼重写血继格子单击事件
LuaCEvent.BloodSuitPanelItemClicked = 33002
--endregion

--region id:34 神炼
---角色界面神炼选中道具
LuaCEvent.RoleForgeGodPowerSmeltItemClicked = 34001
---角色界面神炼切换按钮事件
LuaCEvent.ChangeRoleDivineState = 34002
---角色界面神炼目标切换
LuaCEvent.ChangeForgeGodPowerTarget = 34003
--endregion

--region id:35 节日/限时/活动
---所有活动数据变化
LuaCEvent.mAllActivityChange = 35001
---单个活动数据变化
LuaCEvent.mSingleActivityChange = 35002
--endregion

--region id:36 驯马
LuaCEvent.TrainingHorseTimeChange = 36001
--endregion

--region id:37 竞技
---回收背包数据改变
LuaCEvent.RecycleBagDataChange = 37001
--endregion

--region id:38 boss
LuaCEvent.FinalBossTimesChange = 38001
--endregion

--region id:39 鉴定
LuaCEvent.JianDingClick = 39001
LuaCEvent.JiandingChoose = 39002
LuaCEvent.RefreshCutDmg = 39003
--endregion

--region id:40 勋章镶嵌

---刷新背包向镶嵌面板发送
LuaCEvent.MedalInlay_Select = 40001;

---点击镶嵌面板向背包发送
LuaCEvent.MedalInlay_SelectOfBag = 40002;

---点击镶嵌面板向人物面板发送
LuaCEvent.MedalInlay_SelectOfRolePanel = 40003;
--endregion

--region id:50 武道会

---武道会玩家赔率刷新
LuaCEvent.WDH_OnPlayerBetUpdated = 50001;
---武道会押注玩家列表刷新
LuaCEvent.BuDouKaiBetPlayerListRefresh = 50002
---武道会押注单个玩家信息刷新
LuaCEvent.BuDouKaiBetSinglePlayerRefresh = 50003
---武道会押注列表信息刷新
LuaCEvent.BuDouKaiBetPlayerTableRefresh = 50004
--endregion

--region id:60 全屏特效

---全屏特效显示
LuaCEvent.SceneEffect_ShowEffect = 60001;

--endregion

--region id:70 推送

---推送任务
LuaCEvent.Push_Task = 70001;
---推送更好物品
LuaCEvent.Push_BetterItem = 70002
---更好物品刷新变动
LuaCEvent.BetterItemChange = 70003
--endregion

--region id:71 副本

---更新恶魔副本的剩余时间
LuaCEvent.UpdateDevilRemaining = 71001;

---更新恶魔副本的结束时间
LuaCEvent.UpdateDevilEndTime = 71001;

--endregion

--region id:80 关闭推送气泡
LuaCEvent.CloseDisplayBubble = 80001
--endregion

--region id:90 物品信息面板
---页签变换刷新面板
LuaCEvent.TabChangeRefreshPanel = 90001
--endregion

--region id:100 显示左侧天成特效
LuaCEvent.ShowLvPackEffect = 100001
--endregion

--region id:110 特效面板
---特效面板播放特效
---@param {effectId:int, scale:int, wordPosition:Vector3 ,callBack:function}
LuaCEvent.Effect_PlayEffect = 110001

---特效面板播放物品飞动
---@param {from:Vector3, to:Vector3, callBack:function}
LuaCEvent.Effect_FlyItemIcon = 110002
--endregion

--region id:120 其他玩家信息面板
---关闭其他玩家面板
---@param {OpenOtherPlayerPanelSource:LuaEnumOpenOtherPlayerPanelSource,OpenOtherPlayerPanelParams = UnityEngine.object}
LuaCEvent.CloseOtherPlayerPanel = 120001
--endregion

--region id:130 怪物头像
LuaCEvent.CloseMonsterHeadPanel = 130001
--endregion 关闭怪物头像

--region id：140 语音
LuaCEvent.RecordStateChange = 140001
--endregion

--region id：150 临时导航栏
LuaCEvent.SnapItemGridChange = 150001
--endregion

--region id: 160 炼化
LuaCEvent.Refine_OnBagItemClick = 160001

---第一个炼制材料清空
---参数1清空签的BagItemInfo
LuaCEvent.Refine_OnClearFirstBagItem = 160002
---第二个炼制材料清空
---参数1清空签的BagItemInfo
LuaCEvent.Refine_OnClearSecondBagItem = 160003

---第一个炼制材料变动
LuaCEvent.Refine_OnFirstBagItemChange = 160004
---第二个炼制材料变动
LuaCEvent.Refine_OnSecondBagItemChange = 160005
--endregion

--region id:170 高级回收
---高级回收,在高级回收界面增加选中的物品
---bagV2.BagItemInfo
LuaCEvent.HighRecycleAddItemInHighRecyclePanel = 170001
---高级回收,在高级回收界面减少选中的物品
---bagV2.BagItemInfo
LuaCEvent.HighRecycleRemoveItemInHighRecyclePanel = 170002
---高级回收,清空选中的物品
LuaCEvent.HighRecycleClearPreviewItems = 170003
---请求出售高级回收事件
---table 预期的收益
LuaCEvent.HighRecycleReqSaleEvent = 170004
--endregion

--region id：180 灵兽页签

---外部设置灵兽页签
LuaCEvent.OuterSetServantPlaceTab = 180001
---点击设置灵兽页签
LuaCEvent.OnClickSetServantPlaceTab = 180002
--endregion

--region id:190 刷新聚灵珠推送
LuaCEvent.RefreshJuLingZhuBead = 190001

--endregion

--region id：200 灵兽页签

---外部设置灵兽页签
LuaCEvent.ServantPracticeGetExp = 200001
--endregion

--region id：210 灵兽修炼

---灵兽修炼特效刷新
LuaCEvent.ServantPracticeEffectRefresh = 210001
--endregion

--region id: 220 烟花
---狼烟梦境时间变化消息
LuaCEvent.RefreshDreamlandRemainTimeChange = 220001
--endregion

--region id 230 魔之boss
---刷新魔之boss次数
LuaCEvent.RefreshMagicBossTime = 230001
---刷新魔之boss可领取奖励
LuaCEvent.RefreshCanGetReward = 230002
--endregion

--region id 240 释放xp技能
---刷新当前持续的xp技能
LuaCEvent.RefreshCurXpSkillId = 240001
--endregion

--region id 241 商城
---商城下次刷新时间刷新
---参数1 商城类型 LuaEnumStoreType
LuaCEvent.StoreFlushTimeRefresh = 241001
--endregion

--region id 242 buff
---生肖boss伤害buff
LuaCEvent.AnimalBossHurtBuffRefresh = 242002
--endregion

--region id 250 封印塔
---刷新封印塔信息
LuaCEvent.RefreshSealTowerDataInfo = 250001
---刷新封印塔单个数据
LuaCEvent.RefreshSingleSealTowerDataInfo = 250002
--endregion

--region id 251 联服联盟

---刷新联服联盟投票
LuaCEvent.RefreshAllLeagueUnionRankInfo = 251001
---玩家联服数据改变
LuaCEvent.PlayerLeagueInfoChange = 251002
--endregion

--region id 252 系统开启
LuaCEvent.RefreshSystemGrid = 252001
--endregion

--region id 253  血继
---刷新血继背包
LuaCEvent.RefreshBloodSuitBag = 253001
--endregion

--region id 254 法宝
---刷新所有法宝装备
LuaCEvent.RefreshAllMagicEquip = 254001
---刷新法宝装备
LuaCEvent.RefreshMagicEquip = 254002
---法宝装备页签点击
LuaCEvent.MagicEquipPageClicked = 254003
---法宝背包物品数据变动
LuaCEvent.BagMagicEquipItemChange = 254004
---其他玩家法宝面板页签按钮点击
LuaCEvent.OtherPlayerMagicEquipPageOnClick = 254005
--endregion

--region id 255 血繼
---刷新血繼穿戴信息
LuaCEvent.RefreshBlooodSuitEquipInfo = 255001
--endregion

--region id 256 白日门活动
---白日门活动数据接收事件
---参数1: LuaEnumBaiRiMenActivityType
LuaCEvent.BaiRiMenActivityDataReceived = 256001
---白日门活动处于开启时间的状态变化
---参数2: LuaEnumBaiRiMenActivityType
LuaCEvent.BaiRiMenActivityInOpenTimeStateChanged = 256002
--endregion

--region id 257 白日门押镖
---白日门镖车数据变更
LuaCEvent.BaiRiMenDartCarDataChange = 257001
--endregion

--region id 258 魂装
LuaCEvent.SoulEquip_OnSelectSoulEquip = 258001
---角色界面点击魂装
LuaCEvent.RolePanelClickedSoulEquip = 258002
---洗炼更改选中道具
LuaCEvent.AgainSoulChangeChooseItem = 258003
--endregion

--region id:259 仙装
---仙装界面改变选中道具
LuaCEvent.XianZhuangChooseGridChange = 259001
---仙装角色面板点击格子
LuaCEvent.mRoleGridClicked_XianZhuang = 259002
--endregion

--region id 260 藏品
---主角藏品数据刷新
LuaCEvent.CollectionInfoUpdate = 260001
---主角藏品连锁属性增加
---参数1 LinkEffect表ID
LuaCEvent.LinkEffectAdded = 26002
---主角藏品连锁属性减少
---参数1 LinkEffect表ID
LuaCEvent.LinkEffectRemoved = 26003
--endregion

--region id:261 神器
---神器界面改变选中道具
LuaCEvent.ShenQiChooseGridChange = 261001
---神器角色面板点击格子
LuaCEvent.mRoleGridClicked_ShenQi = 261002
--endregion

--region id:262 镶嵌类型通用
LuaCEvent.mInlaySingleDataChange = 262001
--endregion

--region id 263 倒计时
---开启活动结束倒计时提示
LuaCEvent.ActivityEndCountDownOpen = 263001
--endregion

--region id 264 充值领奖
LuaCEvent.RefreshRechargeBookMark = 264001
---累充红点状态变化
LuaCEvent.AccumulatedRechargeRedPointChange = 264002
--endregion

--region id 265 封号
LuaCEvent.RefreshFengHaoRemainPoint = 265001
--endregion

--region id 266 兑换经验
---主角兑换经验数据变化事件
LuaCEvent.Role_ExpExchangeDataChanged = 266001
--endregion

--region id 267 淬炼
---淬炼状态改变
LuaCEvent.ForgeQuenchStateChanged = 267001
---淬炼物品选中
LuaCEvent.ForgeQuenchItemCheck = 267002
--endregion

--region id 268 重铸
---重铸角色面板格子点击
LuaCEvent.ReforgedRoleGridClick = 268001
---重铸面板刷新
LuaCEvent.ReforgedPanelRefresh = 268002
---重铸结果
LuaCEvent.ReforgedResult = 268003
--endregion

--region id 269 幽灵船
---怪物归属变化
LuaCEvent.TargetStateChange = 269001
---剩余击杀数量变化
LuaCEvent.MonsterKillRemain = 269002
---幽灵船剩余时间
LuaCEvent.GhostShipTime = 269003
--endregion

--region id 270 挖宝
---黄金挖宝状态变化
LuaCEvent.GoldDigChange = 270001
--endregion

--region id 271 兵鉴装备
---兵鉴装备选中变化
LuaCEvent.BingJianChoose = 271001
--endregion

--region id 272 兵鉴任务
LuaCEvent.ClickWeaponBookUnit = 272001

--endregion

--region id 273 投保
---返回身上可投保列表
LuaCEvent.ResCanInsuredEquip = 273001
---投保返回
LuaCEvent.ResInsuredSucces = 273002
--endregion