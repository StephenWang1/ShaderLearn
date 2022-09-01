---UI界面中使用的的静态变量
local uiStaticParameter = {}

--[[****************************************************登录选角界面****************************************************]]


--[[****************************************************主界面**********************************************************]]
---主界面单例
uiStaticParameter.UIMainScenePanel = nil
uiStaticParameter.mNewInfos = 3
--[[****************************************************背包界面********************************************************]]
---背包界面,背包单页最大格数
uiStaticParameter.UIBagPanel_BAGGRIDMAXCOUNT = 35

uiStaticParameter.UIChatPanel_SelectIndex = 0
uiStaticParameter.UIChatPanel_SelectIndex_Default = 1
uiStaticParameter.UIChatPanel_GenericMaxCount = 50
uiStaticParameter.UIChatPanel_FiterIndexList = {}

--region 通用数据
uiStaticParameter.AllItemMaterialData = nil
--endregion


--[[****************************************************帮会界面********************************************************]]
--region Union
---帮会背包界面,背包单页最大格数
uiStaticParameter.PosStringList = {
    [LuaEnumGuildPosType.President] = "会长",
    [LuaEnumGuildPosType.VicePresident] = "副会长",
    [LuaEnumGuildPosType.Elder] = "长老",
    [LuaEnumGuildPosType.Owner] = "堂主",
    [LuaEnumGuildPosType.Elite] = "精英",
    [LuaEnumGuildPosType.Member] = "成员",
    [LuaEnumGuildPosType.ActingPresident] = "代理会长",
}

uiStaticParameter.PosStringListWithColor = {
    [LuaEnumGuildPosType.President] = "[fd0000]会长",
    [LuaEnumGuildPosType.VicePresident] = "[fd7700]副会长",
    [LuaEnumGuildPosType.Elder] = "[00ff00]长老",
    [LuaEnumGuildPosType.Owner] = "[ffff00]堂主",
    [LuaEnumGuildPosType.Elite] = "[00ffff]精英",
    [LuaEnumGuildPosType.Member] = "[dde6eb]成员",
    [LuaEnumGuildPosType.ActingPresident] = "[fd0000]代理会长",
}

---帮会成员打开查看玩家
uiStaticParameter.mUnionMemberOpenViewPerson = false

---帮会红包查看玩家
uiStaticParameter.mUnionRedPackOpenViewPerson = false

---帮会弹劾查看玩家
uiStaticParameter.mUnionAccuseViewPerson = false

---帮会购买改名卡
uiStaticParameter.mUnionInfoToShop = false

---首次登陆需要显示帮会推送
uiStaticParameter.mNeedShowUnionPush = false

---行会熔炼对象lid
uiStaticParameter.mUnionSmeltBagItemInfoLid = 0

--endregion
--[[****************************************************怪物头像界面****************************************************]]
---上次选择的单位ID
uiStaticParameter.previousSelectedUnitID = 0

--[[****************************************************文字提示界面****************************************************]]
uiStaticParameter.TextTipInit = false

--[[****************************************************灵兽头像界面****************************************************]]
---可以显示的灵兽数量
uiStaticParameter.ServantMaxCount = 0
---选中的灵兽种类
uiStaticParameter.SelectedServantType = 0

--[[****************************************************语音************************************************************]]
---语音管理器单例
uiStaticParameter.voiceMgr = nil
---房间号(默认为：平台id + serverid)
uiStaticParameter.serverRoom = tostring(CS.Constant.platformid) .. "_" .. tostring(CS.Constant.mSeverId)
--[[****************************************************GM命令**********************************************************]]
---是否开启GM地图传送
uiStaticParameter.isOpenGMSend = false
--[[************************************************社交-送花**********************************************************]]
---异性送花种类
uiStaticParameter.LastRoseFlowerType = LuaEnumFlowerType.FirstRose
---同性送花种类
uiStaticParameter.LastGoldOrchidType = LuaEnumFlowerType.FirstGoldOrchid
--[[************************************************社交-关系**********************************************************]]
uiStaticParameter.FriendRelation = {
    [LuaEnumSocialFriendRelationType.Self] = "自己",
    [LuaEnumSocialFriendRelationType.Friend] = "好友",
    [LuaEnumSocialFriendRelationType.ENEMY] = "仇人",
    [LuaEnumSocialFriendRelationType.BLACKLIST] = "黑名单",
    [LuaEnumSocialFriendRelationType.APPLY_LIST] = "申请列表",
    [LuaEnumSocialFriendRelationType.TEACHER] = "师傅",
    [LuaEnumSocialFriendRelationType.DIDCIPLE] = "徒弟",
    [LuaEnumSocialFriendRelationType.Brother] = "兄弟",
    [LuaEnumSocialFriendRelationType.Spouse] = "夫妻",
}
uiStaticParameter.MayKnowFriendCause = {
    [LuaEnumSocialMayKnowFriendCauseType.LastChat] = "最近跟你聊过天",
    [LuaEnumSocialMayKnowFriendCauseType.Union] = "跟你同一个行会",
    [LuaEnumSocialMayKnowFriendCauseType.Team] = "最近一起组过队",
    [LuaEnumSocialMayKnowFriendCauseType.Flower] = "最近给你送过花",
    [LuaEnumSocialMayKnowFriendCauseType.RandomOnLine] = "随机推荐",
}
uiStaticParameter.UnReadChatCount = 0
uiStaticParameter.PrivateChatID = 0
uiStaticParameter.ShowInfoToFriendType = false
uiStaticParameter.ShowInfoToSpouseType = false
uiStaticParameter.ShowInfoToBrotherType = false
--[[************************************************外观**********************************************************]]
---外观界面每页的物品数量
uiStaticParameter.UIAppearancePanel_PageItemCount = 20
---使用外观道具后如果有启用外观列表的变化则打开外观界面,该变量表示此物品ID
uiStaticParameter.UseItemAndOpenAppearancePanelItemID = nil
---使用外观道具后如果有启用外观列表的变化则打开外观界面,该变量表示最大延迟时间点
uiStaticParameter.UseItemAndOpenAppearancePanelMaxTime = nil
--[[************************************************寻路**********************************************************]]
---是否显示活动推送
uiStaticParameter.isShowNotice = true
--[[************************************************点击技能+号跳转技能键位设置界面**********************************************************]]
uiStaticParameter.mSkillConfigSelectedIndex = nil
--[[************************************************GM**********************************************************]]
uiStaticParameter.GMGenerateTemplate = nil
uiStaticParameter.GMMonsterTemplate = nil
--[[************************************************主界面提示**********************************************************]]
---主界面提示
---@type UIMainHintPanel
uiStaticParameter.MainHintPanel = nil
--[[************************************************聚灵珠升级跳过所有动画**********************************************************]]
uiStaticParameter.isBreakjlzEffect = false
--[[************************************************摊位**********************************************************]]
---摊位标题内容
uiStaticParameter.ClickBoothInfo = nil
uiStaticParameter.BoothLid = 0
uiStaticParameter.OpenAuctionStallPanelType = nil
--[[************************************************升级特效**********************************************************]]
---升级特效
uiStaticParameter.LevelUpEffect = nil
---经验条是否延迟
uiStaticParameter.ExpNeedDelay = true
---经验条延迟时间
uiStaticParameter.ExpDelayTime = 1
--[[************************************************押镖**********************************************************]]
---在镖车活动中
uiStaticParameter.InCarAcitivity = false
--[[************************************************物品信息界面**********************************************************]]
---物品信息面板管理
---@type UIItemInfoManager
uiStaticParameter.UIItemInfoManager = require "luaRes.ui.template.UIItemInfoPanelTemplates.Base.UIItemInfoManager"
---副面板内容管理
uiStaticParameter.AssistDataManager = require "luaRes.ui.template.UIItemInfoPanelTemplates.Base.AssistDataManager"
---对比物品内容管理
uiStaticParameter.CompareDataManager = require "luaRes.ui.template.UIItemInfoPanelTemplates.Base.CompareDataManager"
---页签物品内容管理
uiStaticParameter.TabDataManager = require "luaRes.ui.template.UIItemInfoPanelTemplates.Base.TabDataManager"
--[[************************************************气泡**********************************************************]]
---回收气泡内容
uiStaticParameter.RecycleBubbleContent = ""
---回收气泡点击
uiStaticParameter.RecycleBubbleOnClick = false

uiStaticParameter.mSocialChatFriendName = "";
--[[************************************************秘籍**********************************************************]]
uiStaticParameter.SecretBookPageTemplate = nil
--region 沙巴克

---沙巴克排行榜单页最大数量
uiStaticParameter.mShaBaKRankOnePageCount = 100;

--endregion

--[[************************************************烟花界面关闭后显示**********************************************************]]
uiStaticParameter.isHideFireworkPanel = false
uiStaticParameter.isCanCallBackHide = false

--region 交易行/拍卖行

uiStaticParameter.mAuctionSortType = {
    [LuaEnumAuctionPanelSortType.OverTime] = Utility.EnumToInt(CS.auctionV2.SalfProductsSortType.OVERDUETIME),
    [LuaEnumAuctionPanelSortType.BidPrice] = Utility.EnumToInt(CS.auctionV2.SalfProductsSortType.BIDPRICE),
    [LuaEnumAuctionPanelSortType.BuyPrice] = Utility.EnumToInt(CS.auctionV2.SalfProductsSortType.BUYPRODUCTSPRICE),
    [LuaEnumAuctionPanelSortType.FixedPrice] = Utility.EnumToInt(CS.auctionV2.SalfProductsSortType.FIXEDPRICE),
    [LuaEnumAuctionPanelSortType.Price] = Utility.EnumToInt(CS.auctionV2.SalfProductsSortType.PRICE),
    [LuaEnumAuctionPanelSortType.PutOnTime] = Utility.EnumToInt(CS.auctionV2.SalfProductsSortType.PUTONTIME),
}

--endregion

--region 菜单
---@type UIPlayerMenuBtnManager
uiStaticParameter.UIPlayerMenuBtnManager = require "luaRes.ui.template.UIGuildTipsPanelTemplates.Base.UIPlayerMenuBtnManager"

--endregion

--region 小飞鞋
uiStaticParameter.isShowFlyShoes = false;
--endregion

--region 千纸鹤
uiStaticParameter.isShowQianZhiHe = false;
--endregion

--[[************************************************类型对应PK模式**********************************************************]]
uiStaticParameter.SererTypeToPKName = {
    [LuaEnumFightMode.Peace] = "和平",
    [LuaEnumFightMode.Team] = "组队",
    [LuaEnumFightMode.Union] = "行会",
    [LuaEnumFightMode.All] = "全体",
    [LuaEnumFightMode.Camp] = "阵营",
}
--[[************************************************客户端充值埋点**********************************************************]]
---充值入口类型
uiStaticParameter.RechargePointPanelType = 0
---消费方式类型
uiStaticParameter.RechargePoint = 0

--[[************************************************排行榜**********************************************************]]
--面板类注册
uiStaticParameter.ActivityRankPanelViewClass = {
    --保卫国王
    [LuaEnuActivityRankID.DefendKing] = "UIActivityRankDefendKingView",
    --沙巴克
    [LuaEnuActivityRankID.ShaBaK] = "UIActivityRankShaBaKView",
    --女神赐福
    [LuaEnuActivityRankID.Goddess] = "UIActivityRankGoddlessView",
    --武道会
    [LuaEnuActivityRankID.BuDouKai] = "UIActivityRankBuDouKaiView",
    --幻境迷宫
    [LuaEnuActivityRankID.DreamLandMaze] = "UIActivityRankDreamLandMazeView",
    --行会押镖
    [LuaEnuActivityRankID.UnionDartCar] = "UIActivityRankUnionDartCarView",
}

--单元类注册
uiStaticParameter.ActivityRankPanelUnitClass = {
    --保卫国王
    [LuaEnuActivityRankID.DefendKing] = "UIActivityRankUnitDefendKingFeature",
    --女神赐福
    [LuaEnuActivityRankID.Goddess] = "UIActivityRankGoddessFeature",
    --武道会
    [LuaEnuActivityRankID.BuDouKai] = "UIActivityRankBuDouKaiFeature",
    --沙巴克
    [LuaEnuActivityRankID.ShaBaK] = "UIActivityRankUnitShaBaKFeature",
    --行会押镖
    [LuaEnuActivityRankID.UnionDartCar] = "UIActivityRankUnionDartCarFeature",
    --幻境迷宫
    [LuaEnuActivityRankID.DreamLandMaze] = "UIActivityRankUnionDreamLandMazeFeature"
}

--详细信息注册
uiStaticParameter.ActivityRankInfomationClass = {
    --保卫国王
    [LuaEnuActivityRankID.DefendKing] = "UIActivityRankInfoDefendKingView",
    --行会押镖
    [LuaEnuActivityRankID.UnionDartCar] = "UIActivityRankInfoUnionCarView",
    --沙巴克
    [LuaEnuActivityRankID.ShaBaK] = "UIActivityRankInfoShaBaKView",
    --幻境迷宫
    [LuaEnuActivityRankID.DreamLandMaze] = "UIActivityRankInfoDreamLandView",
    --女神赐福
    [LuaEnuActivityRankID.Goddess] = "UIActivityRankInfoGoddessView",
}

--沙巴克当前排行榜期数索引
uiStaticParameter.CurShaBaKRankIndex = 0
--当前保卫国王打开时间戳
uiStaticParameter.CurDefendKingTimeStamp = 0
--当前幻境打开时间戳
uiStaticParameter.CurHUANJINGTimeStamp = 0
--当前行会押镖打开时间戳
uiStaticParameter.CurUnionDartCarActivityTime = 0
--当前女神赐福打开时间戳
uiStaticParameter.CurGoddessActivityTime = 0
--当前武道会打开时间戳
uiStaticParameter.CurBuDouKaiActivityTime = 0

--当前活动的排行榜期数注册
uiStaticParameter.ActivityRankPanelType = {
    --沙巴克当前排行榜期数索引
    [101] = "CurShaBaKRankIndex",
    --保卫国王对应当前打开排行榜时间戳
    [237] = "CurDefendKingTimeStamp",
    --幻境对应当前打开排行榜时间戳
    [238] = "CurHUANJINGTimeStamp",
    --行会押镖对应当前打开排行榜时间戳
    [224] = "CurUnionDartCarActivityTime",
    --女神赐福对应当前打开排行榜时间戳
    [235] = "CurGoddessActivityTime",
    --武道会对应当前打开排行榜时间戳
    [236] = "CurBuDouKaiActivityTime",
}

---@type UIRankManager
uiStaticParameter.UIRankManager = require "luaRes.ui.template.UIRankTemplates.Base.UIRankManager"

uiStaticParameter.isOpenDefendKingLeftRankInfo = false

--[[************************************************是否需要重新发送小地图请求**********************************************************]]
---是否需要发送请求
---@type number
uiStaticParameter.isNeedSendMinReq = nil

--[[************************************************白名单列表**********************************************************]]
uiStaticParameter.isOpenWhiteList = false

--[[************************************************沙巴克传送提示显示**********************************************************]]
--沙巴克传送显示不在提示
uiStaticParameter.mSaBakIsShowToggle = false

--[[************************************************灵兽魂继界面数据**********************************************************]]
---当前选中的魂继装备位置, type(1 ~ 3) * 10000 + 格子号(格子号 = 格子位置 + 1, 从1开始)
---@type number
uiStaticParameter.mSelectedHunJiPos = nil

uiStaticParameter.mIsCurrentShaBaK = false;

---上次选择的私聊对象
uiStaticParameter.mLastSelectPrivateFriendName = nil;

--[[************************************************防沉迷**********************************************************]]
uiStaticParameter.mIsFCMTipsPanelOpenedByFCMStateChange = nil
uiStaticParameter.mIsFCMTipPanelOpenedByLastTime = nil

--region 行会
---行会捐献叠加物品捐献物品lid
uiStaticParameter.UnionDonateOverlayItemLid = 0
--endregion

--region 面巾
---@type boolean 面巾之前是否装备过
uiStaticParameter.mIsFaceEquippedBefore = nil
--endregion

--region 更新聚灵珠推送
uiStaticParameter.UpdataCheckJuLingZhuPush = false

uiStaticParameter.LastCheckJuLingZhuTime = 0
--endregion

--region 角色界面
---角色界面页签显示条件
uiStaticParameter.mRolePanelTagCondition = nil

--endregion

--region 推荐大聚灵珠
---获取推荐大聚灵珠周期
---@return number
function uiStaticParameter.GetRecommandBigJuLingZhuPeriod()
    if uiStaticParameter.mRecommandBigJuLIngZhuPeriod == nil and CS.Cfg_GlobalTableManager.Instance ~= nil then
        local tbl
        ___, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22384)
        if tbl ~= nil and tbl.value ~= nil then
            uiStaticParameter.mRecommandBigJuLIngZhuPeriod = tonumber(tbl.value)
        end
    end
    return uiStaticParameter.mRecommandBigJuLIngZhuPeriod
end

---大聚灵珠提示是否存在
uiStaticParameter.mIsBigJuLingZhuTipExist = false
--endregion

--region 可买药品特效condition
function uiStaticParameter.GetShowCanBuyMedicineEffectCondition()
    if uiStaticParameter.mShowCanBuyMedicineEffectCondition == nil and CS.Cfg_GlobalTableManager.Instance ~= nil then
        local tbl
        ___, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22387)
        if tbl ~= nil and tbl.value ~= nil then
            uiStaticParameter.mShowCanBuyMedicineEffectCondition = tonumber(tbl.value)
        end
    end
    return uiStaticParameter.mShowCanBuyMedicineEffectCondition
end
--endregion

--region 炼化

---上次炼化的产物
uiStaticParameter.mLastRefineResult = nil;

--endregion

--region 设置自动使用

---符合设置自动使用药品条件
function uiStaticParameter.GetMeetSetAutoUseItemOneParam()

    if uiStaticParameter.mMeetSetAutoUseItemOneCondition == nil then
        local isFind, info = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22395)
        if isFind then
            local allInfo = string.Split(info.value, '&');
            uiStaticParameter.mMeetSetAutoUseItemOneCondition = string.Split(allInfo[1], '#')
            uiStaticParameter.mSetAutoUseItemOneParam = string.Split(allInfo[2], '#')
        end
    end
    return uiStaticParameter.mMeetSetAutoUseItemOneCondition
end

---设置自动使用药品参数
function uiStaticParameter.GetSetAutoUseItemOneParam()
    if uiStaticParameter.mSetAutoUseItemOneParam == nil then
        local isFind, info = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22395)
        if isFind then
            local allInfo = string.Split(info.value, '&');
            uiStaticParameter.mMeetSetAutoUseItemOneCondition = string.Split(allInfo[1], '#')
            uiStaticParameter.mSetAutoUseItemOneParam = string.Split(allInfo[2], '#')
        end
    end
    return uiStaticParameter.mSetAutoUseItemOneParam
end

--endregion

--region 死亡掉落
---死亡掉落物品参数
uiStaticParameter.mDeadAndDropItemParam = nil
---死亡掉落物品时间
uiStaticParameter.mDeadAndDropItemTime = nil
--endregion

--region 灵兽
uiStaticParameter.mInitCombitServant = true

--region 灵兽修炼
uiStaticParameter.ServantFlashCount = nil

---灵兽修炼红点标记
uiStaticParameter.NeedCallServantPracticeRedPoint = false
--endregion
--endregion

--region 自动组队提示本次登录不再提示
uiStaticParameter.mAutoTeamTipsDoNotHintAgain = nil
--endregion

--region 第一次进入场景
uiStaticParameter.firstEnterScene = true
--endregion

--region 梦境时间

function uiStaticParameter.GetDreamlandTimeShowTipsCondition()
    if uiStaticParameter.mDreamlandTimeShowTipsCondition == nil then
        local isFind, info = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22400)
        if isFind then
            uiStaticParameter.mDreamlandTimeShowTipsCondition = info.value
        end
    end
    return uiStaticParameter.mDreamlandTimeShowTipsCondition
end

--endregion

--region 霸业
---建功立业显示文本
function uiStaticParameter.GetMeridShowTextTbl()
    if uiStaticParameter.mMeritShowTextTbl == nil then
        local isFind, info = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22437)
        if isFind then
            uiStaticParameter.mMeritShowTextTbl = string.Split(info.value, '#')
        end
    end
    return uiStaticParameter.mMeritShowTextTbl
end
--endregion


--region 狼烟梦境
---狼烟梦境最小层
function uiStaticParameter.GetBattleDreamlandMinFloor()
    if uiStaticParameter.mBattleDreamlandMinFloor == nil then
        local isFind, info = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22445)
        if isFind then
            local floorInfo = string.Split(info.value, '#')
            uiStaticParameter.mBattleDreamlandMinFloor = tonumber(floorInfo[1])
            uiStaticParameter.mBattleDreamlandMaxFloor = tonumber(floorInfo[2])
        end
    end
    return uiStaticParameter.mBattleDreamlandMinFloor
end
---狼烟梦境最大层
function uiStaticParameter.GetBattleDreamlandMaxFloor()
    if uiStaticParameter.mBattleDreamlandMaxFloor == nil then
        local isFind, info = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22445)
        if isFind then
            local floorInfo = string.Split(info.value, '#')
            uiStaticParameter.mBattleDreamlandMinFloor = tonumber(floorInfo[1])
            uiStaticParameter.mBattleDreamlandMaxFloor = tonumber(floorInfo[2])
        end
    end
    return uiStaticParameter.mBattleDreamlandMaxFloor
end

--endregion

--region 商会
---商会月卡服务器数据（主要用于规避初次进入游戏初始化月卡数据的时候，服务器时间没有刷新的情况）
uiStaticParameter.monthCardInfo = nil
---月卡被激活（从未激活到激活时为true，显示过后变为false）
uiStaticParameter.startActive = false
--endregion

uiStaticParameter.CallbackResTreeMonsterRefreshTrans = nil

--[[****************************************************恶魔广场数据界面********************************************************]]
---恶魔广场剩余时间
uiStaticParameter.DevilRemaining = {}
---恶魔广场结束时间戳(用来倒计时计算显示时间)
uiStaticParameter.DevilEndTime = {}
--[[****************************************************恶魔广场数据END********************************************************]]


--[[****************************************************悬赏数据界面********************************************************]]
--uiStaticParameter.IsReciveTaskWaitOpenMonsterArrestPanel = true
--[[****************************************************悬赏数据界面 End********************************************************]]

---是否直接使用行会召唤令
uiStaticParameter.isJustUseGuildCallOrder = false;


--[[****************************************************任务********************************************************]]
---是否是自动任务打开面板
uiStaticParameter.IsAutoSkillOpenPanel = false
--[[****************************************************任务 End********************************************************]]
--[[****************************************************行会召唤令使用********************************************************]]
---行会召唤令协程
uiStaticParameter.UnionTokenCoroutine = nil

--region 竞技-回收
---是否是自动任务打开面板
uiStaticParameter.CompetitionData = nil
---是否显示红点
uiStaticParameter.IsShowCompetitionRecycleRedPoint = false
---红点所在行的活动id
uiStaticParameter.mCompetitionRecycleRedPointActivityId = -1
--endregion

--region 首次登陆变强提示
uiStaticParameter.isFirstStrongPrompt = false
--endregion

--region 魔之boss
---主角身边是否有魔之boss
uiStaticParameter.MagicBossInMainPlayerArea = false
---魔之boss红点锁
uiStaticParameter.MagicBossRedPointLock = false
---魔之boss请求协助结束时间
uiStaticParameter.MagicBossReqHelpEndTime = 0
---魔之boss请求协助击杀的怪物id
uiStaticParameter.MagicBossReqHelpKillMonsterId = 0
--endregion

--region 远古BOSS

---是否进入过远古Boss界面
uiStaticParameter.IsEnterAncientBossPanel = false;

--endregion

--region xp技能
---当前有效的持续xp技能ID
uiStaticParameter.CurXpSkillId = 0
--endregion

--region 自动战斗

---是否要求在切换地图后开启自动战斗(存在一些情况,例如在点击NPC切换到指定地图的时候,需要开启自动战斗)
uiStaticParameter.IsRequireOpenAutoFight = false
---上次要求开始的时间  避免由于请求失败,数据没有清理的情况下,导致下次清理存在异常
uiStaticParameter.LastRequireOpenAutoFightTime = 0

---要求下次切换地图后开启自动战斗
function uiStaticParameter.RequireOpenAutoFight()
    uiStaticParameter.IsRequireOpenAutoFight = true;
    uiStaticParameter.LastRequireOpenAutoFightTime = CS.UnityEngine.Time.time
end

---要求下次切换地图后开启自动战斗
---@return Boolean true的话开启自动战斗
function uiStaticParameter.IsExitRequireOpenAutoFight()
    if (uiStaticParameter.IsRequireOpenAutoFight == true) then
        uiStaticParameter.IsRequireOpenAutoFight = false
        if (CS.UnityEngine.Time.time - uiStaticParameter.LastRequireOpenAutoFightTime < 5) then
            return true
        end
    end
    return false
end

--endregion

--region 锻造
--region 转移
uiStaticParameter.NeedPushTransfer = true
--endregion
--endregion

--region 切换地图后开启自动战斗
---设置传送后开启自动战斗
function uiStaticParameter.SetOpenAutoFightAfterDeliver()
    uiStaticParameter.mIsNeedOpenAutoFightAfterDeliver = true
    uiStaticParameter.mSetOpenAutoFightTime = CS.UnityEngine.Time.time
end

---是否需要传送后开启自动战斗
function uiStaticParameter.GetIsNeedOpenAutoFightAfterDeliver()
    if uiStaticParameter.mIsNeedOpenAutoFightAfterDeliver == true then
        uiStaticParameter.mIsNeedOpenAutoFightAfterDeliver = false
        local currentTime = CS.UnityEngine.Time.time
        if uiStaticParameter.mSetOpenAutoFightTime ~= nil and currentTime - uiStaticParameter.mSetOpenAutoFightTime < 10 then
            --取一个最大时间10s,10s前的不考虑
            uiStaticParameter.mSetOpenAutoFightTime = nil
            return true
        end
        uiStaticParameter.mSetOpenAutoFightTime = nil
    end
    return false
end
--endregion

---如果服务器消息在界面创建之前发会导致闪烁气泡无法创建，所以做个缓存
uiStaticParameter.flashCache = nil

--region 法宝

---@type table<LuaRedPointName,LuaEnumMagicEquipSuitType> 法宝类型对应法宝红点
uiStaticParameter.magicEquipRedPointDic = {
    [LuaEnumMagicEquipSuitType.ShengXiao] = LuaRedPointName.MagicEquip_SX,
    [LuaEnumMagicEquipSuitType.LingHun] = LuaRedPointName.MagicEquip_Soul,
    [LuaEnumMagicEquipSuitType.LiLiang] = LuaRedPointName.MagicEquip_Power,
    [LuaEnumMagicEquipSuitType.XinLing] = LuaRedPointName.MagicEquip_XL,
    [LuaEnumMagicEquipSuitType.XianQi] = LuaRedPointName.MagicEquip_XQ,
}

--endregion

--region 血继套装
---血继套装属性类型名字
uiStaticParameter.mAttributeData = {
    [LuaEnumAttributeType.MaxHp] = "血    量",
    [LuaEnumAttributeType.PhyAttackMax] = "攻    击",
    [LuaEnumAttributeType.MagicAttackMax] = "魔    法",
    [LuaEnumAttributeType.TaoAttackMax] = "道    术",
    [LuaEnumAttributeType.PhyDefenceMax] = "防    御",
    [LuaEnumAttributeType.MagicDefenceMax] = "魔    防",
    [LuaEnumAttributeType.HolyAttackMax] = "切    割",
    [LuaEnumAttributeType.HolyDefenceMax] = "神圣防",
    [LuaEnumAttributeType.Critical] = "爆    伤",
}

---血继套装属性类型
uiStaticParameter.mBloodSuitUseData = {
    LuaEnumAttributeType.PhyAttackMax,
    LuaEnumAttributeType.MagicAttackMax,
    LuaEnumAttributeType.TaoAttackMax,
    LuaEnumAttributeType.PhyDefenceMax,
    LuaEnumAttributeType.MagicDefenceMax,
    LuaEnumAttributeType.MaxHp,
    LuaEnumAttributeType.Critical,
    LuaEnumAttributeType.HolyAttackMax,
    LuaEnumAttributeType.HolyDefenceMax,
}

---血继套装名字
uiStaticParameter.mBloodSuitTypeName = {
    [LuaEquipBloodSuitType.Yao] = "兽级",
    [LuaEquipBloodSuitType.Xian] = "仙级",
    [LuaEquipBloodSuitType.Mo] = "魔级",
    [LuaEquipBloodSuitType.Ling] = "灵级",
    [LuaEquipBloodSuitType.Shen] = "神级",
}

---血继套装类型
uiStaticParameter.mBloodSuitType = {
    LuaEquipBloodSuitType.Yao,
    LuaEquipBloodSuitType.Xian,
    LuaEquipBloodSuitType.Mo,
    LuaEquipBloodSuitType.Ling,
    LuaEquipBloodSuitType.Shen,
}

---根据item表数据获取血继子类型
---@param itemTbl TABLE.CFG_ITEMS
---@return LuaEquipBloodSuitItemSubType
function uiStaticParameter.GetBloodSuitSubTypeByItemTable(itemTbl)
    if itemTbl then
        local bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(itemTbl.id)
        if bloodsuitTbl then
            if bloodsuitTbl:GetType() == 1 then
                return LuaEquipBloodSuitItemSubType.ServantEgg
            elseif bloodsuitTbl:GetType() == 2 then
                return LuaEquipBloodSuitItemSubType.ServantBodyEquip
            end
        end
    end
end

---根据血继物品类型获取血继子类型
---@param suitItemType LuaEquipBloodSuitItemType
---@return LuaEquipBloodSuitItemSubType
function uiStaticParameter.GetBloodSuitSubTypeBySuitItemType(suitItemType)
    if suitItemType == nil then
        return
    end
    if suitItemType == LuaEquipBloodSuitItemType.egg1 or
            suitItemType == LuaEquipBloodSuitItemType.egg2 or
            suitItemType == LuaEquipBloodSuitItemType.egg3 or
            suitItemType == LuaEquipBloodSuitItemType.egg4 or
            suitItemType == LuaEquipBloodSuitItemType.egg5 or
            suitItemType == LuaEquipBloodSuitItemType.egg6 or
            suitItemType == LuaEquipBloodSuitItemType.egg7 or
            suitItemType == LuaEquipBloodSuitItemType.egg8 then
        return LuaEquipBloodSuitItemSubType.ServantEgg
    elseif suitItemType == LuaEquipBloodSuitItemType.body1 or
            suitItemType == LuaEquipBloodSuitItemType.body2 or
            suitItemType == LuaEquipBloodSuitItemType.body3 or
            suitItemType == LuaEquipBloodSuitItemType.body4 then
        return LuaEquipBloodSuitItemSubType.ServantBodyEquip
    end
end
--endregion

--region 神力套装
---神力套装类型
uiStaticParameter.mDivineSuitType = {
    LuaEquipmentItemType.POS_SL_WEAPON,
    LuaEquipmentItemType.POS_SL_CLOTHES,
    LuaEquipmentItemType.POS_SL_HEAD,
    LuaEquipmentItemType.POS_SL_NECKLACE,
    LuaEquipmentItemType.POS_SL_LEFT_HAND,
    LuaEquipmentItemType.POS_SL_MEDAL,
    LuaEquipmentItemType.POS_SL_RIGHT_HAND,
    LuaEquipmentItemType.POS_SL_LEFT_RING,
    LuaEquipmentItemType.POS_SL_FABAO,
    LuaEquipmentItemType.POS_SL_RIGHT_RING,
}

---神力套装名字
uiStaticParameter.mDivineSuitName = {
    [LuaEquipmentItemType.POS_SL_WEAPON] = "武器",
    [LuaEquipmentItemType.POS_SL_HEAD] = "头盔",
    [LuaEquipmentItemType.POS_SL_CLOTHES] = "衣服",
    [LuaEquipmentItemType.POS_SL_NECKLACE] = "项链",
    [LuaEquipmentItemType.POS_SL_FABAO] = "法宝",
    [LuaEquipmentItemType.POS_SL_MEDAL] = "勋章",
    [LuaEquipmentItemType.POS_SL_LEFT_HAND] = "手镯",
    [LuaEquipmentItemType.POS_SL_RIGHT_HAND] = "手镯",
    [LuaEquipmentItemType.POS_SL_LEFT_RING] = "戒指",
    [LuaEquipmentItemType.POS_SL_RIGHT_RING] = "戒指",
}



--endregion

--region 封号

---获取当前升级封号的物品及数量
---@return ReplaceMateriaUpgradeConditionInformationBase
function uiStaticParameter.GetUpSealMarkNeedInfo()
    --if uiStaticParameter.mSealMarkNeedInfo == nil then
    ---@type ReplaceMateriaUpgradeConditionInformationBase
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    local nextID = CS.CSScene.MainPlayerInfo.SealMarkId + 1
    local prefixTbl = clientTableManager.cfg_prefix_titleManager:TryGetValue(nextID)
    if prefixTbl == nil then
        return
    end
    local mSealMarkNeedInfo = {}

    ---判断各物品是不是满足升级条件
    mSealMarkNeedInfo.conditionInfo = {}
    local needList = prefixTbl:GetCostItem()
    if needList ~= nil and #needList.list > 0 then
        local result, itemId
        for i = 1, #needList.list do
            if needList.list[i] ~= nil then
                ---@type LuaMatchConditionResult
                result = Utility.IsMainPlayerMatchCondition(needList.list[i])
                if result and result.mReplaceMatData then
                    itemId = result.mReplaceMatData.fullConditionItemId
                    mSealMarkNeedInfo.conditionInfo[i] = Utility.GetReplaceMateriaUpgradeConditionInformationItem(result, nil, itemId)
                end
            end
        end
    end

    ---判断所有条件是不是都满足升级
    mSealMarkNeedInfo.canBeUpgraded = true
    if (mSealMarkNeedInfo.conditionInfo ~= nil and #mSealMarkNeedInfo.conditionInfo > 0) then
        for i = 1, #mSealMarkNeedInfo.conditionInfo do
            if (mSealMarkNeedInfo.conditionInfo[i] ~= nil and mSealMarkNeedInfo.conditionInfo[i].conditions ~= nil) then
                if (not mSealMarkNeedInfo.conditionInfo[i].conditions.success) then
                    mSealMarkNeedInfo.canBeUpgraded = false
                    break
                end
            end
        end
    end
    --end
    return mSealMarkNeedInfo
end

--endregion

--region 连充
---首次显示连充红点
uiStaticParameter.InitializedLCRedPoint = false

---设置并回调红点
function uiStaticParameter.SetLCRedPointValue(value)
    if value == uiStaticParameter.InitializedLCRedPoint then
        return
    end
    uiStaticParameter.InitializedLCRedPoint = value
    if value then
        ---清除红点
        networkRequest.ReqClearFirstChargeRedPoint()
    end
    gameMgr:GetLuaRedPointManager():CallRedPoint(Utility.EnumToInt(CS.RedPointKey.Recharge_ContinueReward))
end

--endregion

--region 狂暴药剂
---当前提示使用狂暴药剂次数
uiStaticParameter.HintUseCrazyDrugNum = 0
---提示使用狂暴药剂最大次数
uiStaticParameter.HintUseCrazyDrugMaxNum = 1
--endregion

--region 循环钻石礼包
uiStaticParameter.CirCleDiamondList = {}
--endregion

--region 神级boss
---神级boss红点锁
uiStaticParameter.GodBossRedPointLock = false
--endregion

--region 官位
---@type LuaEnumOfficialPositionLastOperationReason 官位上次操作类型
uiStaticParameter.OfficialPositionLastRefreshOperation = nil
--endregion

---是否进入过历法界面
uiStaticParameter.IsEnterCalendarPanel = false;

function uiStaticParameter:SetIsEnterCalendarPanel(isEnter)
    if (uiStaticParameter.IsEnterCalendarPanel ~= isEnter) then
        uiStaticParameter.IsEnterCalendarPanel = isEnter;
        gameMgr:GetPlayerDataMgr():GetActivityMgr():UpdateNextCalendarItem();
    end
    luaEventManager.DoCallback(LuaCEvent.ActivityButtons_CalendarButtonUpdate);
end

--region 仲裁官
---是否是在跨服打开仲裁官面板
uiStaticParameter.OpenPanelIsKuaFuMap = false
--endregion

--region 查行会首领倒计时异常
uiStaticParameter.NeedPrintHeart = false
--endregion

--region 仓库
---仓库是否需要整理检查标记,每个账号只检测一次,主要是由客户端排序更改为服务器排序后,线上玩家仓库中需要进行检查,如果仓库中有重复bagIndex的物品需要请求服务器排序
uiStaticParameter.mIsStorageNeedTidyChecked = false
--endregion

--region 推送
---穿装备打开角色面板锁
uiStaticParameter.PutOnEquipAutoOpenRolePanel = true
--endregion

--region
---个人boss红点锁
uiStaticParameter.PersonalBossRedPointLock = false
--endregion

--region 存储聚宝盆buff位置
uiStaticParameter.mJuBaoPenBufferPos = nil
--endregion

--region 转生
---当前账号当前转生等级所需要的材料箱子Id
uiStaticParameter.mCurRoleReinBoxId = 0
--endregion

--region 幻兽
---是否打开幻兽检测
---@type bool
uiStaticParameter.OpenEudemonsDetection = false
--endregion

--region 神医
uiStaticParameter.mDoctorCD = 0
--endregion

--region 跨服摆摊
uiStaticParameter.curShareSellType = LuaEnumAuctionSelfSellType.Stall
--endregion

--region 邀请码
---系统分发的验证码
uiStaticParameter.invitationCode = ''
---输入验证码
uiStaticParameter.inputInvitationCode = ''
--endregion

--region 重铸
---@type LuaEnumRecastType 重铸选择的对象类型
uiStaticParameter.RecastChooseEquipIndex = nil
--endregion

return uiStaticParameter