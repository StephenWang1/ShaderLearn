--- 网络消息定义枚举
require 'luaRes.enum.LuaEnumNetDef'
--- 加载Lua客户端枚举
require 'luaRes.enum.LuaClientEnum'
--- 加载背包变化行为枚举
require 'luaRes.enum.LuaEnum_BagChangeAction'

---@class LuaEnumSex 性别类型
LuaEnumSex = {
    ---通用
    Common = 0,
    ---男
    Man = 1,
    ---女
    WoMan = 2,
}

---@class LuaEnumCareer 职业类型
LuaEnumCareer = {
    ---通用
    Common = 0,
    ---战士
    Warrior = 1,
    ---法师
    Master = 2,
    ---道士
    Taoist = 3,
    ---刺客
    Assassin = 4,
    ---村民
    CunMin = 5,
}

---@class 货币类型
LuaEnumCoinType = {
    ---钻石
    Diamond = 1000001,
    ---补单钻石
    Diamond1 = 1010001,
    ---拍卖钻石
    Diamond2 = 1020001,
    ---福利钻石
    Diamond3 = 1030001,
    ---返利钻石
    Diamond4 = 1040001,
    ---元宝
    YuanBao = 1000002,
    ---绑元
    BangYuan = 1000003,
    ---金币
    JinBi = 1000004,
    ---绑金
    BangJin = 1000005,
    ---角色经验
    PlayerExp = 1000006,
    ---宝石碎片
    GemFragment = 1000007,
    ---寻宝积分
    TreasureIntegral = 1000013,
    ---灯芯碎片
    LampFragment = 1000014,
    ---生命精魄碎片
    EssenceOfLifeFragment = 1000015,
    ---进攻之源碎片
    TheSourceOfAttackFragment = 1000016,
    ---防守之源碎片
    TheSourceOfDefenseFragment = 1000017,
    ---声望
    ShengWang = 1000018,
    ---灵兽经验
    ServantExp = 1000021,
    ---活跃度
    ActiveCoin = 1000022,
    ---聚灵点
    JuLingDian = 1000024,
    ---修炼点
    XiuLianDian = 1000025,
    ---装备币
    EquipCoin = 1000026,
    ---收藏值
    ShouCangZhi = 1000046,
    ---练功点
    LianGongDian = 1000047,
    ---骑术经验
    QiShuExp = 7000033,
}

---@class LuaEnumRechargeType 充值类型
LuaEnumRechargeType = {
    ---常规充值
    NormalRecharge = 1,
    ---首次充值
    FirstRecharge = 2,
    ---元宝直购
    IngotPurchase = 3,
    ---直购
    DirectPurchase = 6,
    ---活动充值
    ActivityRecharge = 7,
    ---投资充值
    InvestmentRecharge = 8,
    ---零元购
    ZeroPurchase = 9,
    ---领奖
    Reward = 10,
    ---连续充值
    ContinueRecharge = 11,
    ---终身限购
    LastRecharge = 12,
    ---投资1
    Investment1 = 13,
    ---投资2
    Investment2 = 14,
    ---累计充值（领奖）
    AccumulatedRecharge = 15,
    ---潜能投资
    PotentialInvest = 16,
    ---特惠礼包
    PreferenceGift = 17,
}

---@class LuaEnumItemType
luaEnumItemType = {
    ---资源货币
    Coin = 1,
    ---装备
    Equip = 2,
    ---药剂
    Drug = 3,
    ---技能书
    SkillBook = 4,
    ---宝箱
    TreasureBox = 5,
    ---材料
    Material = 6,
    ---技能经验
    SkillExp = 7,
    ---辅助
    Assist = 8,
    ---元素
    Element = 9,
    ---灵兽碎片
    ServantFragment = 11,
    ---印记
    Signet = 12,
    ---外观
    Appearance = 13,
    ---月卡
    MouthCard = 14,
    ---魂继
    HunJi = 15,
    ---高级技能熟练度
    HighLvSkillExp = 16,
    ---藏品
    Collection = 17,
}

---@class 材料类型（item材料类型的subType）
luaEnumMaterialType = {
    ---矿石
    mine = 1,
    ---肉类
    meat = 2,
    ---药材
    MedicinalHerb = 3,
    ---地图凭证
    MapPassCheck = 9,
    ---烟花
    Firework = 10,
    --- 玫瑰花
    Rose = 16,
    ---金兰花
    JinLan = 17,
    ---悬赏令
    rewardOrder = 18,
    ---烟花之地
    LandOfFireworks = 39,

}

---@class 特殊道具物品ID
LuaEnumSpecialPropItemID = {
    ---随机卷轴
    RandomScroll = 8010001,
    ---随机石
    RandomStone = 8140003,
    ---比奇回城石
    ReturnBiQiCityStone = 8140001,
    ---盟重回城石
    ReturnMengZhongCityStone = 8140002,
    ---白日门回城石
    ReturnBaiRiMenStone = 8140004,
}

---@class 物品信息界面初始化类型
LuaEnumItemInfoPanelInitType = {
    ---使用背包物品信息初始化
    InitWithBagItemInfo = 0,
    ---使用物品信息初始化
    InitWithItemInfo = 1,
    ---使用元灵信息初始化
    InitYuanLingInfo = 2,
}

---@class 物品信息界面物品操作类型
LuaEnumItemOperateType = {
    ---取消,关闭Tips
    Cancel = 0,
    ---丢弃
    Discard = 1,
    ---使用
    Use = 2,
    ---装备
    Equip = 3,
    ---打开
    Open = 4,
    ---销毁
    Destroy = 5,
    ---拆分
    Split = 6,
    ---锻造,打开锻造界面
    Forge = 7,
    ---合成,传送合成NPC,打开合成界面
    Combine = 8,
    ---行会捐献
    Donate = 9,
    ---兑换帮会仓库装备
    ExchangeInUnion = 10,
    ---出售
    Sell = 11,
    ---获取
    Gain = 12,
    ---维修
    Repair = 13,
    ---拍卖行上架
    AuctionHouse = 14,
    ---进化
    Evolution = 15,
    ---捆绑
    Bundle = 16,
    ---拍卖行竞拍
    Auction = 17,
    ---镶嵌
    Mosaic = 18,
    ---婚戒操作
    MarryRing = 19,
    ---融合
    Blend = 20,
    ---日常任务道具使用
    DailyTaskItemUse = 21,
    ---日常任务道具出售
    DailyTaskItemSell = 22,
    ---魂继通灵
    HunJiTongLing = 23,
    ---炼化
    Refine = 24,
    ---熔炼
    Semelt = 25,
    ---升阶
    PromoteClass = 26,
    ---洗炼
    AgainRefine = 27,
    ---收藏
    Collect = 28,
    ---仙装镶嵌
    XianZhuangInlay = 29,
    ---提升会员
    UpgradeMembership = 30,
    ---鉴定
    JianDing = 31,
    ---升级
    ShengJi = 32,
    ---突破
    TuPo = 33,
}

---@class 背包打开类型
LuaEnumBagOpenType = {
    ---背包
    Bag = 0,
    ---回收
    Recycle = 1,
    ---转移
    Transfer = 2
}

---@class LuaEnumBagType
LuaEnumBagType = {
    ---正常打开的背包
    Normal = 1,
    ---正常打开的回收界面
    Recycle = 2,
    ---与技能界面组合的背包
    Skill = 3,
    ---与角色界面组合的背包
    Role = 4,
    ---与灵兽界面组合的背包
    Servant = 5,
    ---与个人仓库界面组合的背包
    PlayerWarehouse = 6,
    ---与材料界面组合的背包
    Material = 7,
    ---与锻造界面组合的背包
    Strength = 8,
    ---与转移界面组合的背包
    Transfer = 9,
    ---与维修界面组合的背包
    Repair = 10,
    ---与技能设置界面组合的背包
    SkillConfig = 11,
    ---与打捆界面组合的背包
    Bundle = 12,
    ---与灵兽维修组合的背包
    ServantRepairBag = 13,
    ---进化与背包
    Evolution = 50,
    ---合成与背包
    Synthesis = 51,
    ---与镶嵌界面组合的背包
    Mosaic = 52,
    ---元素提示背包
    ElementHint = 53,
    ---印记提示背包
    SignetHint = 54,
    ---摊位
    Stall = 55,
    ---第一个任务未完成背包
    UnFinishFirstMission = 56,
    ---行会召唤令提示背包
    UnionSummonTokenHint = 57,
    ---高等级灵兽背包
    Servant_HighLv = 58,
    ---交易背包
    Trade = 59,
    ---心法界面背包
    HeartSkill = 60,
    ---高级回收背包
    HighRecycle = 61,
    ---炼化背包
    Refine = 62,
    ---熔炼背包
    Smelt = 63,
    ---血继熔炼背包
    BloodSuitSmelt = 64,
    ---血继背包
    BloodSuit = 65,
    ---神炼背包
    ForgeBloodSmelt = 66,
    ---洗炼背包
    AgainRefine = 67,
    ---藏品背包
    Collection = 68,
    ---藏品回收
    CollectionRecycle = 69,
    ---鉴定背包
    JianDing = 70,
    ---淬炼背包
    ForgeQuench = 71,
}

---@class 背包格子类型
LuaEnumBagGridType = {
    ---可以上锁
    CanLock = 0,
    ---无
    None = 1,
    ---打开
    Open = 2,
    ---已上锁
    Lock = 3,
    ---屏蔽置灰
    Block = 4
}

---@class LuaEnumFurnaceOpenType 神炉界面打开类型
LuaEnumFurnaceOpenType = {
    ---赤炎灯
    ChyanLamp = 1,
    ---魂玉
    SoulBead = 2,
    ---宝石
    Gem = 3,
    ---进攻之源
    TheSourceOfAttack = 4,
    ---防守之源
    TheSourceOfDefense = 5,
}

---@class LuaEnumBossType
LuaEnumBossType = {

    ---野外boss
    WorldBoss = 2,
    ---精英boss
    EliteBoss = 3,
    ---终极boss
    FinalBoss = 4,
    ---boss积分
    BossScore = 5,
    ---游荡BOSS
    WanderBoss = 6,
    ---暗之boss
    DarkBoss = 7,
    ---魔之boss
    DemonBoss = 8,
    ---生肖boss
    ZodiacBOSS = 9,
    ---个人boss
    PersonalBoss = 10,
}

---@class 锻造界面打开类型
LuaEnumForgeOpenType = {
    ---强化
    Strengthen = 0,
    ---元素
    Element = 2,
    ---印记
    Signet = 3,
}

---@class LuaEnumStrengthenType 打开锻造界面类型
LuaEnumStrengthenType = {
    ---强化背包的装备
    Bag = 0,
    ---强化元灵的装备
    YuanLing = 1,
    --- 强化角色的装备
    Role = 2,
}

---设置界面打开类型
---@class LuaEnumConfigPanelOpenType
LuaEnumConfigPanelOpenType = {
    ---基础
    BasePanel = 1,
    ---保护
    ProtectPanel = 2,
    ---拾取
    PickupPanel = 3,
    ---显示
    ShowPanel = 4,
    ---模式
    ModePanel = 5,
    ---反馈
    FeedbackPanel = 8,
    ---技能键位设置
    SkillConfigPanel = 7,
}

---在cfg_active表中使用
---@class 活跃度目标类型
LuaEnumActiveGoalType = {
    ---挖矿
    GATHER_MINE = 1,
    ---挖肉
    GATHER_BODY = 2,
    ---杀怪
    KILL_MONSTER = 3,
    ---击杀精英怪
    KILL_ELITE_BOSS = 4,
    ---击杀boss
    KILL_BOSS = 5,
    ---商城购买
    SHOP_BUY = 6,
    ---拍卖行买卖
    AUCTION_BUY = 7,
    ---背包回收 = 装备回收
    BAG_RECYCLE = 8,
    ---锻造装备
    INTENSIFY = 9,
    ---宝物升级
    GOD_FURNACE = 10,
    ---学习技能 = 全部学完之后隐藏学习条目）
    LEARN_SKILL = 11,
    ---升级技能（全部升级后隐藏升级条目）
    UPLEVEL_SKILL = 12,
    ---领取闯天关奖励
    TOWER = 13,
    ---送花
    SEND_FLOWER = 14,
    ---猜拳
    FINGER = 15,
    ---内功升级
    UP_INNER_POWER = 16,
    ---转生
    REIN = 17,
    ---战勋升级
    ZHANXUN = 18,
    ---完成日常任务
    DailyTask = 19,
    ---铁匠任务
    BlacksmithTask = 20,
    ---屠夫任务
    ButcherTask = 21,
    ---药商任务
    DruggistTask = 22,
    ---流浪汉任务
    TrampTask = 26,
    ---渔夫任务
    FishermanTask = 27,
    ---雇佣兵任务
    MercenaryTask = 23,
}

---@class 帮会职位类型
LuaEnumGuildPosType = {
    ---会长
    President = 20,
    ---副会长
    VicePresident = 15,
    ---长老
    Elder = 10,
    ---堂主
    Owner = 5,
    ---精英
    Elite = 1,
    ---成员
    Member = 0,
    ---代理会长
    ActingPresident = 19
}

---@class 帮会打开界面类型
LuaEnumGuildPanelType = {
    ---帮会信息
    GuildInfo = 1,
    ---帮会成员列表
    GuildMember = 2,
    ---帮会仓库
    GuildWarehouse = 3,
    ---帮会福利
    GuildWelfare = 4,
    ---所有帮会列表
    GuildList = 5,
    ---行会活动
    GuildActivity = 6,
    ---行会熔炼
    GuildSmelt = 7,
}

---@class 帮会界面类型
LuaEnumGuildGridType = {
    President = 1,
    Member = 2,
    None = 3,
}

---@class 商店类型
LuaEnumStoreType = {
    ---快捷商店
    QuickShop = 1,
    ---钻石商城
    Diamond = 2,
    ---元宝商城
    YuanBao = 3,
    --- 周末商城 (现促销商城)
    WeeklyPurchaseShop = 4,
    ---宝石系统商店
    GemQuickShop = 5,
    ---转生商店
    TurnGrowShop = 6,
    ---金币商店
    GoldShop = 7,
    ---杂货铺
    GroceryStore = 14,
    ---商会钻石商店
    CommerceDiamond = 16,
    ---商会积分商店
    CommerceIntegral = 17,
    ---钻石限时商店
    DiamondRechargeGift = 18,
    ---限时礼包
    LimitGift = 20,
    ---循环钻石限时商店
    CircleDiamondRechargeGift = 21,
}

---@class 商店界面类型
LuaEnumShopPanelType = {
    ---背包随身
    BagCarryOn = 1,
    ---元宝商城
    Market = 2,
    ---神炉随身商店
    FurnaceCarryOn = 3,
}

---@class 商店限购类型
luaEnumShopLimitType = {
    ---每日限购
    DayLimit = 1,
    ---终身限购
    LifeLimit = 2,
    ---神秘商人限购
    MysteriousLimit = 3,
    ---刷新重置限购
    RefreshBuyLimit = 4,
    ---随机限购数量
    RandomLimitNum = 5,
    ---刷新吸纳狗
    RefreshLimitNum = 6,
}

---每日目标界面类型
LuaEnumDayToDayPanelType = {
    ---每日活动
    DayActivity = 1,
    ---限时
    LimitTime = 2,
    ---周历
    Week = 3,
}

---@class Condition表 conditionType字段
LuaEnumConditionKeyType = {
    GreatePlayerLevel = 1, ---不低于等级
    LessPlayerLevel = 2, ---低于等级
    GreatReincarnationLevel = 3, ---不低于转世等级
    LessReincarnationLevel = 4, ---低于转世等级
    GreatGuildLevel = 5, ---不低于行会等级
    GreatVipLevel = 6, ---不低于VIP等级
    LessVipLevel = 7, ---低于VIP等级
    GreatOpenServerDay = 8, ---开服天数不小于
    LessOpenServerDay = 9, ---开服天数小于
    GreateCombatValue = 10, ---不低于战力
    LessCombatValue = 11, ---低于战力
    GreateHeroWingLevel = 12, ---主角光翼等级
    PlayerLevelAndReincarnationLevel = 13, --- string#string#string#string 等级下限#等级上限#转生下限#转生上限
    ---灵兽不低于转生等级
    GreatServantReinLevel = 14,
    ---灵兽不低于等级
    GreatServantLevel = 15,
    FixedTimeSecond = 16, ---固定时间段 3600#7200表示距离凌晨3600秒时间到7200秒 即凌晨一点到两点
    FixedTimeWeek = 17, --- 固定时间(星期)
    MapConsumable = 20, --- 地图消耗材料
    Prefix = 21, ---战勋
    JoinStorage = 22, ---加入商会
    ResourceConsumable = 33, --- 资源货币消耗材料
    ServerOpenPanel = 35, ---服务器打开界面使用的条件,客户端不处理并应返回true
    VIPLimit = 43, ---不低于VIP等级
    UnionClassification = 45, ---公会分级
    KillMapAllMonster = 46, ---击杀指定地图中所有怪物
    NeedOfficialState = 60, ---需要达到的官阶等级
}

---@class 活动组
LuaEnumActivityGroup = {
    ---开服活动
    OpenServerActivity = 1,
    ---常驻活动
    ConstActivity = 2,
    ---限时活动
    LimitTimeActivity = 3,
    ---奖励大厅
    PrizeHall = 4,
}

---@class 活动类型
luaEnumActivityType = {
    ---特惠礼包
    SpecialOfferGift = 1,
    ---全民竞技
    AllPeopleFight = 2,
    ---全民Boss
    AllPeopleBoss = 3,
    ---限时礼包
    LimitTimeGift = 4,
}

---@class 奖励大厅内容类型
LuaEnumWelfareType = {
    ---七日奖励
    SevenDayAward = 1,
    ---每日签到
    EveryDaySign = 2,
    ---在线奖励
    OnLineAward = 3,
    ---定时奖励
    TimeingAward = 4,
}

---@class 定时奖励类型
LuaEnumTimingRewardType = {
    ---每日固定时间
    TimeDay = 1,
    ---每周固定时间
    TimeWeek = 2,
}

---@class LuaEnumGuildTipType 选中玩家功能菜单按钮id  Cfg_guild_Buttons
LuaEnumGuildTipType = {
    ---添加好友
    AddFriend = 1,
    ---私聊
    PrivateChat = 2,
    ---夫妻赠送钻石
    SendDiamond = 3,
    ---邀请入队
    InvitedTeam = 4,
    ---申请入队
    ApplyTeam = 5,
    ---送花
    SendFlowers = 6,
    ---划拳
    PullFist = 7,
    ---邀请入会
    InviteMembership = 8,
    ---申请入会
    ApplyUnion = 9,
    ---设置职位
    SetPosition = 10,
    ---踢出公会
    OutGuild = 11,
    ---转让队长
    TransferCaptain = 12,
    ---踢出队伍
    OutTemp = 13,
    ---授权语音
    AuthorizationVoice = 14,
    ---取消授权语音
    UnAuthorizationVoice = 15,
    ---查看他人灵兽
    CheckOtherPeopleServant = 18,
    ---查看灵兽主人信息
    CheckMasterInfo = 19,
    --- 查看玩家信息
    CheckInformation = 20,
    --- 离开队伍
    LeaveTeam = 21,
    ---查看圈子
    LookCircle = 22,
    ---交易
    Deal = 23,
    ---拜师
    OurTutors = 24,
    ---移除黑名单
    RemoveBlackList = 25,
    ---追踪
    Track = 26,
    ---面对面交易
    Trade = 27,
}

---@class LuaEnumPanelIDType 面板ID类型
LuaEnumPanelIDType = {
    ---他玩家头像/怪物头像面板
    MonsterHeadPanel = 101,
    ---堂主面板
    GuildOwnerListPanel = 102,
    ---队伍面板_我的队伍页签
    TeamPanel_MyTeamPanel = 103,
    ---红包发送者头像页签
    LuckyMoneyPanel_SendRolePanel = 104,
    ---社交面板
    SocialChatPanel = 105,
    ---聊天面板
    ChatPanel = 106,
    ---普通帮会成员面板
    GuildMemberListPanel = 107,
    ---队伍面板队员
    TeamPanel_Members = 108,
    ---排行榜人物信息面板
    RankPanel_RoleInfo = 109,
    ---会长，副会长，长老
    GuildLeaderListPanel = 110,
    ---主角自身头像面板
    SelfHeadPanel = 111,
    ---会长面板
    GuildChairman = 112,
    ---灵兽头像预览
    ServantHeadPanel = 113,
    ---悬赏头像预览
    ArrestHeadPanel = 114,
    ---仇人头像预览
    HatredHeadPanel = 115,
    ---个人镖车预览
    PersonDartCarHeadPanel = 116,
    ---行会复仇面板
    UnionRevengePanel = 117,
    ---跨服聊天面板
    RemoteChatPanel = 118,
}

---@class 活动开启类型
LuaEnumActivitiesOpenType = {
    ---开服天数
    OpenServerDays = 1,
    ---合服天数
    MergeServerDays = 2,
    ---具体日期
    CurDate = 3,
    ---等级
    PlayerLevel = 4,
    ---转生等级
    PlayerReinLevel = 5
}

---@class 地图界面点的类型
LuaEnumUIMapPointType = {
    ---怪物
    Monster = 1,
    ---传送门
    Transfer = 2,
    ---NPC
    NPC = 3
}

---@class 月卡子面板类型
LuaEnumMonthCardChildPanelType = {
    ---Vip
    UIVipPanel = 0,
    ---特权
    UIPrivilegeCard = 1,
    ---充值
    UIRechargePanel = 2
}

---@class 角色界面类型
LuaEnumRolePanelType = {
    ---主角(默认)
    MainPlayer = 0,
    ---其他角色
    OtherPlayer = 1
}

---界面打开来源
---@class LuaEnumPanelOpenSourceType
LuaEnumPanelOpenSourceType = {
    ---其他
    Other = 0,
    ---由主界面角色头像打开
    ByRoleHeadPanel = 1,
    ---由背包界面打开
    ByBagPanel = 2,
    ---由灵兽界面打开
    ByServantPanel = 3,
    ---由锻造界面打开
    ByStrengthenPanel = 4,
    ---由物品Tips界面打开
    ByItemInfoPanel = 5,
    ---由物品提示打开
    ByItemHint = 6,
    ---由灵兽提示打开
    ByServantHint = 7,
    ---查看他人灵兽
    ByCheckOtherPeopleServant = 8,
    ---任务打开背包穿戴装备
    ByTaskUseEquip = 9,
    ---高等级灵兽推荐
    ByServantHintHighLv = 10,
    ---查看他人信息
    ByOtherRole = 11,
    ---合成界面打开
    BySynthesis = 12,
    ---炼化打开
    ByRefine = 13,
    ---炼制大师打开
    ByRefineMaster = 14,
    ---由神炼界面打开
    ByForgeGodPowerSmelt = 14,
}

---@class 任务类型
LuaEnumTaskType = {
    ---主线任务
    MainTask = 1,
    ---2环任务
    ToopTask = 2,
    ---3雇佣兵
    Mercenary = 3,
    ---4日常
    Everyday = 4,
    ---支线任务
    SecondTask = 5,
    ---怪物悬赏
    MonsterArrest = 6,
    --烟花
    YanHua = 7,
    --圣域
    ShengYu = 8,
    --精英
    Elite = 9,
    --Boss
    Boss = 10,
    --怪物
    Monster = 11,
    ---个人镖车（正常）（层级最低）
    PersonDartCar_Normal = 100,
}
---@class 任务Boss类型
LuaEnumTaskBossType = {
    --精英
    Elite = 1,
    --Boss
    Boss = 2,
}

---@class 日常任务类型
LuaEnumDailyTaskType = {
    ---铁匠任务
    BlacksmithTask = 1,
    ---屠夫任务
    ButcherTask = 2,
    ---药商任务
    DruggistTask = 3,
    ---流浪汉任务
    TrampTask = 4,
    ---渔夫任务
    FishermanTask = 5,
    ---雇佣兵任务
    MercenaryTask = 6,
}

---@class 任务显示类型
LuaEnumShowTaskType = {
    ---普通任务
    Common = 1,
    ---活跃任务
    Acitvity = 2,
    ---悬赏任务
    Reward = 3,
    --怪物悬赏
    YanHua = 4,
    --圣域
    ShengYu = 5,
    --精英任务
    Elite = 6,
    --Boss任务
    Boss = 7,
    --怪物悬赏
    Monster = 8,
    --闯天关
    CrawlTower = 9,
}

---@class 采集类型
LuaEnumGatherType = {
    ---挖肉
    DigMeat = 1,
    ---尸体挖掘
    DigDeadBody = 2,
    ---挖矿
    Mining = 3,
    ---采药
    GatherHerp = 4,
    ---收集宝箱
    CollectBox = 5,
    ---驯马
    TrainingHorse = 12,
}

---@class DropShow表 displayConditionType字段（显示条件类型）
LuaEnumDropShowType = {

    ---开服天数
    OpenServiceDays = 1,
    ---限制时间：开始时间#结束时间
    LimitedTime = 2,
    ---指定活动开启：活动id
    SpecifiedActivity = 3,
    ---角色创建天数
    RoleCreationDays = 4,
    ---角色等级
    RoleLevel = 5
}

---任务子类型
LuaEnumTaskSubtype = {
    ---杀怪
    KillMonster = 1,
    ---收集道具
    CollectItems = 2,
    ---达到等级
    AchieveLevel = 3,
    ---完成副本
    CompleteCopy = 4,
    ---死亡次数
    DieNumber = 5,
    ---PK
    PK = 6,
    ---时间限制
    TimeLimit = 7,
    ---对话
    Dialogue = 8,
    ---地图杀怪
    MapKillMonster = 9,
    ---装备等级
    EquipmentLevel = 10,
    ---挖矿
    Mining = 11,
    ---采集
    Gather = 12,
    ---合成装备
    CompoundEquipment = 15,
    ---击杀特定地图特定怪物
    KillSpecialMonster = 16,
    ---学习技能书数量
    LearningSkillNumber = 17,
    ---巢穴副本任务
    Nest = 21,
    ---获得肉身装备
    GetBodyEquip = 27,
}

---装备类型
LuaEnumEquiptype = {
    ---武器
    Weapon = 1,
    ---头盔
    Helmet = 2,
    ---衣服
    Clothes = 3,
    ---项链
    Necklace = 4,
    ---手镯
    Bracelet = 5,
    ---戒指
    Ring = 6,
    ---腰带
    Belt = 7,
    ---鞋子
    Shoe = 8,
    ---护肩
    Shoulder = 9,
    ---面甲
    Mask = 10,
    ---护膝
    Kneecap = 11,
    ---吊坠
    Pendant = 12,
    ---赤焰灯
    Light = 13,
    ---灯芯
    LightComponent = 14,
    ---魂玉
    SoulJade = 15,
    ---生命精魄
    ShengMingJingPo = 16,
    ---宝石
    Gem = 17,
    ---元灵秘宝
    TheSecretTreasureOfYuanling = 18,
    ---进攻之源
    Jingongzhiyuan = 19,
    ---守护之源
    Shouhuzhiyuan = 20,
    ---宝石手套
    Baoshishoutao = 21,
    ---勋章
    Medal = 22,
    ---双倍勋章
    DoubleMedal = 23,
    ---面巾
    Face = 24,
    ---婚戒
    WeddingRing = 520,
    ---主印
    MainSignet = 30,
    ---辅印
    SubSignet = 31,
    ---左手武器
    LeftWeapon = 39,
    ---斗笠
    DouLi = 40,
}

---等级奖励飞入位置
LuaEnumFlyPos = {
    ---不飞入
    None = 0,
    ---飞入神炉
    GodFurnace = 1,
    ---飞入背包
    Bag = 2,
    ---灵兽1
    Ls1 = 3,
    ---灵兽2
    Ls2 = 4,
    ---灵兽3
    Ls3 = 5
}

---等级奖励类型
LuaEnumLevelRewardType = {
    ---道具
    item = 1,
    ---打开界面
    OpenPanel = 2,
}

---@class Lua对话框形状类型
LuaEnumDialogTipsShapeType = {
    ---右下角箭头第一种，
    RightBottomArrow_One = 1,
    ---右侧箭头第二种
    RightArrow_Two = 2,
    ---方形朝下箭头 第三种
    BottomSquare_Three = 3,
    ---无箭头
    NoArrow = 4,
    ---右箭头带tween动画
    RightArrowWithTweenPosition = 5,
    ---提示点击提醒
    HintClickTips = 6,
}

---@class Lua对话框提示逻辑类型
LuaEnumDialogTipsType = {

}

---元素石装备类型
LuaEnumElementStonToEquipType = {
    ---武器、衣服
    WeaponAndClothes = 1,
    ---戒指、手镯
    RingAndBracelet = 2,
    ---项链、头盔
    NecklaceAndHelmet = 3,
    ---鞋子、腰带
    ShoeAndBelt = 4,
    ---赤魂灯、魂玉、宝石
    LightAndSoulJadeAndGem = 5,
}

---元素类别
LuaEnumElementType = {
    ---电
    Electricity = 1,
    ---火
    Fire = 2,
    ---冰
    Ice = 3,
    ---黑暗
    Dark = 4,
    ---穿刺
    Impale = 5,
}

---@class 秘籍技能类型(心法技能)
LuaEnumSecretSkillType = {
    ---生命秘籍
    SecretLife = 1,
    ---元素攻击类
    SecretElementalAttack = 2,
    ---防御秘籍
    SecretDefense = 3,
    ---元素防御
    SecretElementalDefense = 4,
    ---抵御职业类
    SecretResistanceToOccupation = 5,
    ---抵御技能类
    SecretResistanceToSkill = 6,
}
---@class 婚戒操作面板
LuaEnumWeddingPanelType = {
    ---戒指面板
    WeddingRingPanel = 1,
    ---宣言刻字面板
    MoreInfoPanel = 2,
}

---@class 元灵界面类型
LuaEnumServantPanelType = {
    None = 0,
    ---基础面板
    BasePanel = 1,
    ---升级面板
    LevelPanel = 2,
    ---转生面板
    ReinPanel = 3,
    ---魂继面板
    HunJiPanel = 4,
}

---@class 元灵状态
LuaEnumServantStateType = {
    ---死亡
    Death = 0,
    ---出战
    Battle = 1,
    ---合体
    Combine = 2,
    ---收回
    Rest = 3,
}

---@class LuaEnumServantSpeciesType 元灵类型
LuaEnumServantSpeciesType = {
    None = 0,
    ---寒芒
    First = 1,
    ---落星
    Second = 2,
    ---天成
    Third = 3,
    ---通用
    Forth = 4,
}

---@class 文字提示类型
LuaEnumTextTipsType = {
    ---中间提示
    MiddleTips = 1,
    ---中上提示
    MiddleTopTips = 2,
    ---左下提示
    LeftBottomTips = 3,
    ---延迟中间提示
    DelayMiddleTips = 4,
}

---@class 怪物类型
LuaEnumMonsterType = {
    ---普通怪物
    Normal = 1,
    ---精英怪物
    Elite = 2,
    ---Boss
    Boss = 3,
    ---静态怪物
    Static = 4,
    ---矿区拟人怪
    MiningAreaMonster = 9,
    DartCar = 11,
    ---个人镖车
    PersonDartCar = 17,
}

---@class LuaEnumAttributeType 属性类型
LuaEnumAttributeType = {
    NULL = 0,
    ---血量
    MaxHp = 1,
    ---魔法
    MaxMp = 2,
    ---内力
    InnerPowerMax = 3,
    ---攻击下限
    PhyAttackMin = 4,
    ---攻击上限
    PhyAttackMax = 5,
    ---魔法攻击下限
    MagicAttackMin = 6,
    ---魔法攻击上限
    MagicAttackMax = 7,
    ---道术攻击下限
    TaoAttackMin = 8,
    ---道术攻击上限
    TaoAttackMax = 9,
    ---物防
    PhyDefenceMin = 10,
    ---物防
    PhyDefenceMax = 11,
    ---魔防
    MagicDefenceMin = 12,
    ---魔防
    MagicDefenceMax = 13,
    ---暴击
    Critical = 14,
    ---爆伤
    CriticalDamage = 15,
    ---准确
    Accurate = 16,
    ---闪避
    Dodge = 17,
    ---生命回复
    HpRecover = 18,
    ---魔防回复
    MpRecover = 19,
    ---内力回复
    InnerPowerRecover = 20,
    ---幸运
    Luck = 21,
    ---抗暴
    ResistanceCrit = 22,
    ---神圣最大攻击
    HolyAttackMax = 26,
    ---攻速
    AttackSpeed = 27,
    ---PK攻击
    PkAtt = 28,
    ---PK防御
    PkDef = 29,
    ---穿透
    PenetrationAttributes = 31,
    ---腕力
    Brawn = 32,
    ---负重
    BearingWeight = 33,
    ---电攻
    ElectricAttack = 35,
    ---火攻
    FireAttack = 36,
    ---冰攻
    IceAttack = 37,
    ---暗攻
    DarkAttack = 38,
    ---穿刺攻
    PunctureAttack = 39,
    ---电防
    ElectricDefence = 40,
    ---火防
    FireDefence = 41,
    ---冰防
    IceDefence = 42,
    ---暗防
    DarkDefence = 43,
    ---穿刺防
    PunctureDefence = 44,
    zsResistPercent = 45,
    fsResistPercent = 46,
    dsResistPercent = 47,
    ---暗防
    phantomHp = 48,
    ---诅咒
    curse = 49,
    ---麻痹
    MbRate = 50,
    ---神圣最大防御
    HolyDefenceMax = 51,
    ---神圣最小攻击
    HolyAttackMin = 58,
    ---神圣最小防御
    HolyDefenceMin = 59,
    ---最小电攻
    ElectricAttackMin = 60,
    ---最小火攻
    FireAttackMin = 61,
    ---最小冰攻
    IceAttackMin = 62,
    ---最小暗攻
    DarkAttackMin = 63,
    ---最小穿刺攻
    PunctureAttackMin = 64,
    ---最小电防
    ElectricDefenceMin = 65,
    ---最小火防
    FireDefenceMin = 66,
    ---最小冰防
    IceDefenceMin = 67,
    ---最小暗防
    DarkDefenceMin = 68,
    ---最小穿刺防
    PunctureDefenceMin = 69,
    ---打怪经验倍数
    MonsterDieAddExpBei = 70,
    ---客户端暴击
    showCritical = 71,
    ---掉宝率
    AddDropTreasure = 73,
    ---对怪物增伤
    MonsterHuntAdd = 85,
    ---灵兽生命
    ServantHP = 86,
    ---灵兽最大物防
    ServantPhyDefMax = 87,
    ---灵兽最小物防
    ServantPhyDefMIn = 88,
    ---灵兽最大物防
    ServantMagicDefMax = 89,
    ---灵兽最小物防
    ServantMagicDefMIn = 90,
    ---灵兽合体继承攻击
    ServantInheritAttack = 91,
    ---灵兽合体继承生命
    ServantInheritHp = 92,
    ---灵兽合体继承防御
    ServantInheritDefense = 93,
}

---@class 社交面板
LuaEnumSocialPanelType = {
    ---邮件面板
    MailPanel = 1,
    ---私聊面板
    SocialChatPanel = 2,
    ---队伍面板
    TeamPanel = 3,
    ---排行榜界面
    RankPanel = 4,
    ---帮会面板
    GuildPanel = 5,

}

---@class 社交面板列表
LuaEnumSocialLieBiaoType = {
    ---我的好友
    HaoYouLieBiao = 1,
    ---仇人
    ChouRenLieBiao = 2,
    ---黑名单
    HeiMingDanLieBiao = 3,
    ---申请列表
    ShenQingLieBiao = 4,
    ---最近聊天
    ZuiJinLieBiao = 7,
}

---@class 社交好友面板
LuaEnumSocialFriendPanelType = {
    ---聊天界面
    LastChatPanel = 1,
    ---好友信息界面
    FriendInfoPanel = 2,
    ---添加好友界面
    AddFriendPanel = 3,
    ---朋友圈
    FriendCirclePanel = 4,
}

---@class 社交好友关系
LuaEnumSocialFriendRelationType = {
    ---默认
    Null = 0,
    ---好友
    Friend = 1,
    ---仇人
    ENEMY = 2,
    ---黑名单
    BLACKLIST = 3,
    ---申请列表
    APPLY_LIST = 4,
    ---师傅
    TEACHER = 5,
    ---徒弟
    DIDCIPLE = 6,
    ---陌生人
    Strange = 7,
    ---兄弟
    Brother = 8,
    ---夫妻
    Spouse = 9,
    ---自己
    Self = 10,
    ---小秘书
    Secretary = 9999,
}

---@class 社交好友关系功能
LuaEnumFriendRelationFuncType = {
    ---夫妻buff
    SpouseBuff = 1,
    ---兄弟buff
    BrotherBuff = 2,
    ---送花
    Flower = 3,
    ---划拳
    Finger = 4,
    ---交易
    Deal = 5,
    ---朋友圈
    FriendCircle = 6,
    ---支援
    Summon = 7,
    ---私聊
    Chat = 8,
    ---队伍
    Team = 9,
    ---行会
    Union = 10,
    ---查看其他玩家信息
    PlayerMessage = 11,
}

---@class 社交可能好友来源
LuaEnumSocialMayKnowFriendCauseType = {
    ---共同好友
    LastChat = 1,
    ---共同帮会
    Union = 2,
    ---最近组队
    Team = 3,
    ---全服顶尖
    Flower = 4,
    ---随机在线
    RandomOnLine = 5,
}

---@class NPCID
LuaEnumNPCType = {
    ---维修
    Repair = 23,
    ---比奇杂货铺老板
    BiQiWarehouseClerk = 101,
    ---行会管理员
    UnionManager = 118,
    ---悦来客栈老板
    MengZhongWarehouseBoss = 206,
    ---仓库管理员
    MengZhongWarehouseClerk = 207,
}

---@class 拖拽结束类型
LuaEnumEndDragType = {
    ---角色面板
    RolePanel = 1,
    ---背包面板
    BagPanel = 2,
}

---@class 挑战类型
LuaEnumChallengeType = {
    ---已挑战
    HasChallenged = 1,
    ---待挑战
    ToBeChallenged = 2,
    ---未挑战
    NoteChallenged = 3,
}

---@class 拍卖行Tips类型
LuaEnumAuctionTipsType = {
    ---购买
    Buy = 1,
    ---上架
    Sell = 2,
    ---下架
    Remove = 3,
    ---过期
    OutTime = 4,
}

---@class LuaEnumGetAwardType 奖励领取状态
LuaEnumGetAwardType = {

    ---可领取
    Get = 1,
    ---不可领取
    NotGet = 2,
    ---已领取
    Geted = 3,

}

---@class LuaEnumLvPackTaskType 等级奖励任务类型
LuaEnumLvPackTaskType = {
    ---获取奖励
    GetAward = 1,
    ---灵兽试炼
    OpenLsSchoolPanel = 2,
    ---灵兽学院
    LsSchool = 3,

}

---@class 元灵装备显示状态
LuaEnumServantEquipShowType = {
    ---正常
    Normal = 0,
    ---置灰
    Gray = 1,
}

---@class 导航栏层级
LuaEnumNavMenusLayer = {
    First = 1,
    Second = 2,
    Third = 3,
}

---@class 录音状态
LuaEnumRecordState = {
    Null = 1,
    Record = 2,
    CallOff = 3,
    Pause = 4,
}

---@class 元灵属性拓展状态
LuaEnumServantEquipType = {
    ---隐藏
    Hide = 0,
    ---显示
    Show = 1,
}

---@class 元灵装备显示颜色状态
LuaEnumServantEquipShowColorType = {
    ---正常颜色
    Normal = 0,
    ---置灰
    Gray = 1,
}

---@class UI界面状态
LuaEnumUIState = {
    ---尚未初始化完毕状态
    NotYetInitialized = 0,
    ---正常状态
    Normal = 1,
    ---将要被销毁
    IsGoingToBeDestroyed = 2,
}

LuaEnumSkillUpLevelErrorCode = {
    ---满足条件可升级
    Non = "",
    ---技能未学习
    NotGet = "技能未学习",
    ---技能经验不足
    SkillExpNotEnough = "技能经验不足",
    ---已满级
    Max = "技能已满级",
    ---条件不满足
    ConditionNotEnough = "条件不足",
}
---@class 猜拳类型
luaEnumGuessFistType = {
    None = 0,
    Stone = 1,
    Scissors = 2,
    Fabric = 3
}

---@class 导航栏id枚举
luaEnumNavigationType = {
    ---锻造
    Forge = 1,
    ---宝物
    Furnace = 2,
    ---帮会
    Union = 3,
    ---帮会仓库
    GuildBag = 6,
    ---帮会成员
    GuildMember = 7,
    ---帮会信息
    GuildInfo = 8,
    ---帮会列表
    GuildList = 9,
    ---赤炎灯
    ChyanLamp = 10,
    ---魂玉
    SoulBead = 11,
    ---宝石
    Gem = 12,
    ---进攻之源
    TheSourceOfAttack = 13,
    ---防守之源
    TheSourceOfDefense = 14,
    ---技能详情
    SkillDetails = 21,
    ---技能专精
    SkillProficient = 22,
    ---星级
    StarLevel = 23,
    ---技能键位
    SkillKeyPos = 25,
    ---元素
    Element = 26,
    ---升星
    ForgeUpStar = 27,
    ---印记
    Signet = 29,
    ---帮会申请
    GuildApply = 30,
    ---心法
    HeartSkill = 31,
    ---心阵
    HeartFormation = 32,
    ---帮会管理
    GuildManage = 33,
    ---进化
    Evolution = 34,
    ---合成
    Synthesis = 35,
    ---炼化
    Refine = 42,
    ---精炼
    JingLian = 43,
    ---血炼
    BloodSuitSmelt = 44,
    ---神炼
    ForgeGodPowerSmelt = 45,
    ---镶嵌
    Inlay = 46,
    ---仙装
    XianZhuang = 49,
    ---幻化
    HuanHua = 52,
    ---阵法
    ZhenFa = 53,
    --鉴定
    JianDing = 54,
    ---淬炼
    ForgeQuench = 56,
    ---重铸
    Recast = 58,
    ---重铸-灵魂刻印
    Recast_LingHunKeYin = 59,
    ---重铸-面纱
    Recast_MianSha = 60,
    ---重铸-灯座
    Recast_DengZuo = 61,
    ---重铸-玉佩
    Recast_YuPei = 62,
    ---重铸-宝饰
    Recast_BaoShi = 63,
    ---重铸-秘宝
    Recast_MiBao = 64,
}

---@class 颜色枚举
luaEnumColorType = {

    ---主信息颜色
    White = "[dde6eb]",

    ---次要信息颜色
    Gray = "[878787]",

    ---灰色2
    Gray1 = "[CACACA]",

    ---灰色3
    Gray2 = "[5C5C5C]",

    ---灰色4
    Gray3 = "[585858]",
    ---灰色5
    Gray4 = "[454545]",

    ---高亮
    WhiteHighlight = "[c39a4e]",

    ---属性提升满足条件
    Green = "[00ff00]",
    ---队长绿
    Green1 = "[3EEF35]",
    ---Tips绿
    Green2 = "[39ce1b]",

    Green3 = "[00ff00]",

    ---警告色
    Red = "[e85038]",

    --region 其他红色
    Red1 = "[ff0000]",

    Red2 = "[ff00ff]",

    Red3 = "[FFcda5]",

    ---倒计时红色
    TimeCountRed = "[bb3520]",
    --endregion

    ---底边栏二级字色
    BlueWhite = "[27e8db]",

    ---蓝色
    Blue = "[C3F4FF]",
    Blue2 = '[2977EB]',
    Blue3 = '[73ddf7]',

    ---星星黄色
    Yellow = "[fbd671]",
    ---橙色
    Orange = '[FF8F5E]',
    Orange2 = "[ff6a29]",

    ---蓝紫色
    BluePurple = "[84b2ff]",

    ---深黄色
    DeepYellow = "[ffc947]",
    ---深黄色1
    DeepYellow1 = "[fbcf82]",

    ---浅黄色
    SimpleYellow = "[fffbf5]",
    ---浅黄色1
    SimpleYellow1 = "[fff0c2]",
    ---浅黄色2
    SimpleYellow2 = "[e7c580]",
    ---弹窗通用浅黄色
    SimpleYellow3 = "[fffff0]",

    ---棕色
    Brown = "[402d20]",

    ---浅紫色
    SimplePurple = "[9496DCFF]",

    ---紫色
    Purple = "[b645f6]",

}

LuaEnumUnityColorType = {
    ---置灰颜色
    Gray = CS.UnityEngine.Color(0, 0, 0, 1),
    ---透明颜色
    Transparent = CS.UnityEngine.Color(1, 1, 1, 1 / 255),
    ---正常颜色
    Normal = CS.UnityEngine.Color(1, 1, 1, 1),
    ---白色
    White = CS.UnityEngine.Color(221 / 255, 230 / 255, 235 / 255),
    ---灰色
    Grey = CS.UnityEngine.Color(155 / 255, 155 / 255, 155 / 255),
    ---暗灰色
    DarkGray = CS.UnityEngine.Color(86 / 255, 86 / 255, 86 / 255),
    ---绿色
    Green = CS.UnityEngine.Color(45 / 255, 248 / 255, 18 / 255),
    ---黄色
    Yellow = CS.UnityEngine.Color(243 / 255, 181 / 255, 18 / 255),
    ---黑色
    Black = CS.UnityEngine.Color.black,
    ---文本描边黑色
    OutLineBlack = CS.UnityEngine.Color(36 / 255, 36 / 255, 36 / 255),
    ---半透明
    HalfTransparent = CS.UnityEngine.Color(0, 0, 0, 128 / 255),
}

---@class 心法心阵界面显示类型
LuaEnumHeartSkillShowType = {
    ---心法
    HeartSkill = 0,
    ---心阵
    HeartFormation = 1,
}

---通用提示框方向类型
LuaEnumPromptframeDirectionType = {
    ---上
    UP = 1,
    ---下
    DOWN = 2,
    ---左
    LEFT = 3,
    ---右
    RIGHT = 4,
}

---通用提示框配置参数类型
LuaEnumTipConfigType = {
    ---1 配置ID
    ConfigID = 1,
    ---2 父物体
    Parent = 2,
    ---3 偏移量
    Excursion = 3,
    ---4 描述
    Describe = 4,
    ---5 方向
    Direction = 5,
    ---6 依附面板
    DependPanel = 6,
    ---7 配置表
    ConfigTable = 7,
    ---8 其他
    Other = 8,
}

---@class 神炉升级状态码
LuaEnumFurnaceUpLevelStateCode = {
    ---无异常状态(可升级)
    None = 0,
    ---材料不足
    MaterialNotEnough = 1,
    ---已达满级
    AlreadyFull = 2,
}

---@class 排行榜类型
LuaEnumRankType = {

    None = 0,
    --- 等级总榜
    LEVEL_ALL = 1,
    ---战力总榜
    FIGHT_POWER_ALL = 2,
    --- 战士等级榜
    LEVEL_ZHANSHI = 3;
    --- 法师等级榜
    LEVEL_FASHI = 4;
    ---战士等级榜
    LEVEL_DAOSHI = 5;
    ---战力战士榜
    FIGHT_POWER_ZHANSHI = 6;
    ---战力法师榜
    FIGHT_POWER_FASHI = 7;
    --- 战力道士榜
    FIGHT_POWER_DAOSHI = 8;
    ---猜拳
    FINGER = 9;
    ---鲜花男神榜
    FLOWER_MAN = 10;
    --- 鲜花女神榜
    FLOWER_WUMAN = 11,
    --- 恩爱榜
    LOVER = 13,
    ---灵兽榜
    SERVANT = 14,
    ---送花榜
    FLOWER = 15,
    ---经商榜
    DOBUSINESS = 16,
    ---猎兽榜
    KILLMONSTER = 17,
    ---战神榜
    GODTOWAR = 18,
    ---战损榜
    BATTLEDAMAGE = 19,
    ---战勋榜
    PREFIX = 20,
    ---阵法榜
    FORMATION = 31,
}

---@class 夺榜类型
LuaEnumContendRankType = {
    --- 等级总榜
    LEVEL = 1,
    ---战力总榜
    FIGHT_POWER_ALL = 2,
    ---猜拳
    FINGER = 9;
    ---男神榜
    FLOWER_MAN = 10;
    --- 女神榜
    FLOWER_WUMAN = 11,
    ---灵兽榜
    SERVANT = 14,
    ---送花榜
    FLOWER = 15,
    ---经商榜
    DOBUSINESS = 16,
    ---猎魔榜
    KILLMONSTER = 17,
    ---战神榜
    GODTOWAR = 18,
}

---@class 技能可操作的状态码
---0 可学习 1 可升级 2 可升熟练度 -1 没有可以操作
LuaEnumSkillStateCode = {
    ---没有可操作
    NON = -1,
    ---可学习
    Study = 0,
    ---可升级
    UpLevel = 1,
    ---可升熟练度
    Proficiency = 2,
}

---@class 通用消息类型
LuaEnumCommonMsgType = {
    CommonResNameByID = 1,
    ---零点事件
    MidNight = 2,
    ---穿脱装备
    PutOnTheEquip = 4,
    ---商业化-竞技活动可领取
    Activity_CanAward = 8,
    ---玩家零点等级变化
    PlayerZeroLevelChange = 11,
    ---玩家每天首次登陆
    FirstLogIn = 14,
    ---请求数据通用 （联盟数据响应规则（data：luaEnumLeagueInfoMsgType data64:数据））
    CountType = 24,
    ---返回联盟预选投票的结果
    LeagueVoteResult = 25,
}

---@class 组队类型
LuaEnumTeamType = {
    ---邀请
    Invite = 1,
    ---队长获得申请列表
    Apply = 2,
    ---队长获得二次申请列表（由队员邀请的玩家）
    AgainApply = 3,
}

---@class 组队面板跳转类型
LuaEnumTeamPanelType = {
    ---普通打开
    Normal = 1,
    ---组队请求
    TeamReq = 2,
}

---@class 送花类型
LuaEnumFlowerType = {
    ---金兰花
    FirstGoldOrchid = 6030008,
    ---99朵金兰花
    SecondGoldOrchid = 6030009,
    ---999朵金兰花
    ThirdGoldOrchid = 6030010,
    ---玫瑰花
    FirstRose = 6030005,
    ---99朵玫瑰花
    SecondRose = 6030006,
    ---999朵玫瑰花
    ThirdRose = 6030007,
}

---@class 拍卖行一级页签类型
LuaEnumAuctionFiltrateFirstOrderType = {
    Equip = 1,
    Gem = 17,
    Element = 23,
    Signet = 46,
    SkillBook = 58,
    Servant = 62,
    ServantEgg = 63,
    ServantBody = 64,
    ServantEquip = 65,
    TurnGrowStone = 92,
    Other = 103
}

---@class 装备进化类型
LuaEnumEquipEvolutionType = {
    ---普通
    Normal = 1,
    ---神级
    God = 2,
    ---圣级
    Holy = 3,
    ---至尊
    Supreme = 4,
}

---@class 外观类型
LuaEnumAppearanceType = {
    ---武器
    Weapon = 1,
    ---头盔
    Helmet = 2,
    ---衣服
    Clothes = 3,
    ---翅膀
    Wing = 4,
    ---称号
    Title = 5,
    ---称谓
    Appellation = 6
}

---@class 地图传送类型
LuaEnumUIMapDeliverType = {
    ---比奇
    BiQi = 1,
    ---土城
    TuCheng = 2,
    ---比奇分线
    BiQiFenXian = 3,
    ---白日门
    BaiRiMen = 4,
}

---使用次数显示类型
LuaEnumItemUseNumType = {
    ---显示在道具tips上
    ShowUIItemInfoPanel = 1,
    ---显示在背包上
    ShowUIBagPanel = 2
}

---技能键位界面打开类型
LuaEnumSkillConfigPanelOpenType = {
    ---技能列表
    Skill = 1,
    ---背包
    Bag = 2,
}

---@class LuaEnumLeftTagType 左侧导航栏面板类型
LuaEnumLeftTagType = {
    ---角色面板
    UIRolePanel = 1,
    ---转生面板
    UIRoleTurnGrowPanel = 2,
    ---军衔面板
    UIRolePrefixPanel = 3,
    ---内功面板
    UIRolePowerPanel = 4,
    ---血继面板
    UIRoleBloodSuitPanel = 5,
    ---封号面板
    UIMilitaryRankTitlePanel = 6,
    ---官位面板
    UIOfficialPositionPanel = 7,
    ---收藏界面
    UICollectionPanel = 8,
    ---外观界面
    UIOutlookPanel = 9,
    ---潜能面板
    UIRolePotentialPanel = 10,
}

---UI(系统模块跳转)id
LuaEnumTransferType = {

    --region 技能

    ---心法
    HeartSkill = 101,
    ---技能心阵
    HeartFormation = 102,
    ---技能
    SkillDetails = 103,
    --endregion

    --region 宝物

    ---宝物赤炎灯
    FurnaceLight = 201,
    ---宝物魂玉
    FurnaceSoulBead = 202,
    ---宝物宝石
    FurnaceGem = 203,
    ---宝物进攻之源
    FurnaceTheSourceOfAttack = 204,
    ---宝物防守之源
    FurnaceTheSourceOfDefence = 205,

    --endregion

    --region 设置

    ---设置基础
    ConfigBase = 301,
    ---设置拾取
    ConfigPickup = 302,
    ---设置反馈
    ConfigFeedback = 303,
    ---设置模式
    ConfigPattern = 304,
    ---设置键位
    ConfigKeyPos = 305,
    ---设置保护
    ConfigProtect = 307,
    --endregion

    --region 锻造

    ---元素-角色
    Element_Role = 401,
    ---升星-角色
    Strengthen_Role = 402,
    ---转移-角色
    Transfer_Role = 403,
    ---印记-角色
    Imprint_Role = 404,

    ---元素-背包
    Element_Bag = 405,
    ---升星-背包
    Strengthen_Bag = 406,
    ---转移-背包
    Transfer_Bag = 407,
    ---印记-背包
    Imprint_Bag = 408,

    ---进化-背包
    Evolution_Bag = 409,
    ---进化-角色
    Evolution_Role = 410,

    ---升星-元灵
    Strengthen_Servant = 411,

    ---合成-背包
    Synthesis_Bag = 412,
    ---合成-角色
    Synthesis_Role = 413,
    ---合成-灵兽
    Synthesis_Servant = 414,
    ---合成列表
    Synthesis_List = 415,

    ---魂装镶嵌
    SoulEquip = 416,
    ---仙器镶嵌
    XianQiEquip = 417,
    ---神器镶嵌
    ShenQiEquip = 418,

    ---鉴定面板
    ForgeIdentify = 4201,

    --endregion

    --region 帮会

    ---帮会-首页
    Guild_Info = 501,
    ---帮会-成员
    Guild_Member = 502,
    ---帮会-福利
    --Guild_List = 503,
    Guild_Welfare = 503,
    ---帮会-仓库
    Guild_WareHouse = 504,
    -----帮会-申请
    --Guild_Apply = 505,
    -----帮会-管理
    --Guild_Manage = 506,
    ---帮会-熔炼
    Guild_Smelt = 507,
    ---帮会-活动
    Guild_Activity = 508,
    --endregion

    --region 人物

    ---人物战勋
    Role_Prefix = 601,
    --人物转生
    Role_Rein = 602,
    --人物装备
    Role_Equip = 603,
    ---人物属性
    Role_Equip_Atr = 604,
    ---虎符
    Role_Position_HuFu = 606,
    ---藏品
    Role_Collection = 607,
    ---潜能-石化
    Role_Potential = 609,
    ---潜能-诅咒
    Role_Potential_ZuZhou = 610,
    ---潜能-急速
    Role_Potential_JiSu = 611,
    ---人物-转生/等级
    Role_Rein_LevelExpExchange = 612,
    --endregion

    --region 灵兽

    ---灵兽主界面(寒芒)
    Servant_Base_HM = 701,
    ---灵兽主界面(落星)
    Servant_Base_LX = 702,
    ---灵兽主界面(天成)
    Servant_Base_TC = 703,

    ---灵兽升级(寒芒)
    Servant_Upgrade_HM = 704,
    ---灵兽升级(落星)
    Servant_Upgrade_LX = 705,
    ---灵兽升级(天成)
    Servant_Upgrade_TC = 706,

    ---灵兽肉身(寒芒)
    Servant_Flesh_HM = 707,
    ---灵兽肉身(落星)
    Servant_Flesh_LX = 708,
    ---灵兽肉身(天成)
    Servant_Flesh_TC = 709,

    ---灵兽合体(寒芒)
    Servant_Combit_HM = 710,
    ---灵兽合体(落星)
    Servant_Combit_LX = 711,
    ---灵兽合体(天成)
    Servant_Combit_TC = 712,

    ---灵兽出战(寒芒)
    Servant_Battle_HM = 713,
    ---灵兽出战(落星)
    Servant_Battle_LX = 714,
    ---灵兽出战(天成)
    Servant_Battle_TC = 715,

    ---灵兽转生(寒芒)
    Servant_Rein_HM = 716,
    ---灵兽转生(落星)
    Servant_Rein_LX = 717,
    ---灵兽转生(天成)
    Servant_Rein_TC = 718,

    --endregion

    --region 背包

    ---背包主界面
    Bag_Base = 801,
    ---背包回收
    Bag_Recycl = 802,
    ---背包熔炼
    Bag_Smelt = 803,
    --endregion

    --region 挑战boss

    ---精英boss
    Boss_Elite = 1001,
    ---巢穴boss
    Boss_Nest = 1002,
    ---终极boss
    Boss_Final = 1003,
    ---boss积分
    Boss_Integral = 1004,
    ---魔之Boss
    Boss_Demon = 1005,
    ---暗之Boss
    Boss_Dark = 1006,
    ---游荡BOSS
    Boss_Wander = 3002,
    ---终极boss-远古boss
    Boss_Final_Ancient = 1007,
    ---终极boss-神级boss
    Boss_Final_God = 1008,
    ---个人boss
    Boss_Personal = 1009,
    ---生肖boss
    Boss_Zodiac = 1010,
    --endregion

    --region 商城
    ---商城-金币
    Shop_Gold = 1101,
    ---商城-钻石
    Shop_Diamond = 1102,
    ---商城-元宝
    Shop_YuanBao = 1103,
    ---商城-默认
    Shop_Default = 1104,
    ---商城-商会
    Shop_Commerce = 1105,
    ---商城-商会塔罗牌
    Shop_CommerceTaLuoPai = 1106,
    ---商城-钻石 PS:1102 存在一定的条件
    Shop_CommerceTaLuoPai = 1129,
    --endregion

    --region 交易
    Auction_Trade = 1201,
    ---拍卖
    Auction_Auction = 1202,
    ---上架
    Auction_UpperShelf = 1203,
    ---摊位上架
    Auction_StallShelf = 1204,
    ---熔炼
    Auction_Smelt = 1205,
    ---行会竞拍
    Auction_Union = 1206,
    --endregion

    --region 组队
    Team_TeamPanel = 1301,
    ---组队申请
    Team_Req = 1302,
    --endregion

    --region 社交
    ---社交-朋友圈
    Friend_CircleOfFriends = 1401,
    ---社交-送花
    Friend_Flower = 1402,
    ---社交-追踪
    Friend_ArrestTrack = 1403,
    ---社交好友列表
    Friend_FrindInfoPanel = 1405,
    ---社交聊天
    Friend_FriendChat = 1406,
    --endregion

    --region 辅助
    ---物品聚灵珠
    Aid_JuLingZhu = 1501,
    --endregion

    --region 跳转商会
    CommercePanel = 1601,
    --endregion

    --region 二次确认
    SecondConfirm_Marry = 1801,
    --endregion

    --region 改名卡
    Rename_Role = 1901,
    Rename_Union = 1902,
    --endregion

    --region 充值
    ---首充
    FirstRecharge = 2501,
    ---充值
    Recharge = 2601,
    ---领奖充值
    Recharge_Award = 2602,
    ---特惠礼包
    Recharge_SpecialGift = 2603,
    ---潜能投资
    Recharge_Potential = 2604,
    --endregion

    --region 秘籍
    ---获取装备
    UISecretBookPanel_GetEquip = 2701,
    ---印记掉落
    UISecretBookPanel_Signet = 2702,
    ---元素掉落
    UISecretBookPanel_Element = 2703,
    --endregion

    --region 炼化
    Refine = 3001,
    --endregion


    --region 灵兽修炼
    SpiritPractice = 3004,
    --endregion

    --region 灵兽聚灵
    GatherSoul = 3201,
    --endregion

    --region 血炼
    ---血炼-血继
    BloodSuitSmelt_BloodSuit = 3007,
    ---血炼-背包
    BloodSuitSmelt_Bag = 3008,
    --endregion

    --region 神炼
    ---神炼-人物
    SLSuitSmelt_Role = 3009,
    ---神练-背包
    SLSuitSmelt_Bag = 30010,
    --endregion

    --region 法宝
    ---角色-法宝
    MagicEquip_UIRolePanel = 3301,
    --endregion

    --region 血继
    ---血继-兽
    BloodEquip_Yao = 3401,
    ---血继-仙
    BloodEquip_Xian = 3402,
    ---血继-魔
    BloodEquip_Mo = 3403,
    ---血继-灵
    BloodEquip_Ling = 3404,
    ---血继-神
    BloodEquip_Shen = 3405,
    --endregion

    --region 白日门活动
    BaiRiMenActivity_ShengWu = 3501,
    BaiRiMenActivity_FengShang = 3502,
    BaiRiMenActivity_LieMo = 3503,
    BaiRiMenActivity_HuoYun = 3504,
    BaiRiMenActivity_LianFu = 3505,
    BaiRiMenActivity_CangYue = 3506,
    --endregion

    --region 特殊活动
    ---限时活动-狂欢商店
    SpecialMenActivity_KHSD = 3601,
    ---限时活动-限时礼包
    SpecialMenActivity_XSLB = 3602,
    --endregion

    --region洗炼
    ---洗炼-角色
    AgainRefine_Role = 3011,
    ---洗炼-背包
    AgainRefine_Bag = 3012,
    --endregion

    --region 跳转历法
    ---历法-行会地宫
    Calender_HHDG = 3702,
    ---历法-行会首领
    Calender_HHSL = 3703,
    --endregion

    --region 跳转竞技
    ---冲级奖励
    Competition_LevelUp = 3801,
    ---首杀奖励
    Competition_FirstKill = 3802,
    ---首爆奖励
    Competition_FirstDropReward = 3803,
    ---装备回收
    Competition_EquipRecycle = 3804,
    --endregion

    --region 跳转会员
    ---会员面板
    Member_Panel = 3901,
    ---钻石会员
    Member_ZuanShi = 3902,
    ---星耀会员
    Member_XingYao = 3903,
    ---白银会员
    Member_BaiYin = 3904,
    ---黄金会员
    Member_HuangJin = 3905,
    ---白金会员
    Member_BaiJin = 3906,
    ---王者会员
    Member_WangZhe = 3907,
    ---荣耀会员
    Member_RongYao = 3908,
    ---神圣会员
    Member_ShenSheng = 3909,
    ---永恒会员
    Member_YongHeng = 3910,
    ---至尊会员
    Member_ZhiZun = 3911,
    --endregion

    --region 跨服摆摊
    ---跨服摆摊- 上架
    ShareSell_Shelf = 4901,
    ---跨服摆摊- 摆摊
    ShareSell_Stall = 4902,
    --endregion

    --region 重铸
    ---重铸-魂印
    Recast_HunYin = 5001,
    ---重铸-面纱
    Recast_MianSha = 5002,
    ---重铸-灯座
    Recast_DengZuo = 5003,
    ---重铸-玉佩
    Recast_YuPei = 5004,
    ---重铸-宝饰
    Recast_BaoShi = 5005,
    ---重铸-秘宝
    Recast_MiBao = 5006,
    --endregion
}

---GM界面子页签类型
LuaEnumGMPanelType = {
    ---快速命令
    GMQuickOrder = 1,
    ---日志查看
    GMLogViewer = 2,
    ---道具生成
    GMGenerate = 3,
    ---Hierarchy GUI
    GMHierarchy = 4,
    ---模型控制
    GMModelControl = 5,
    Tool = 6,
    ---背包物品lid
    BagItemLid = 7,
    ---客户端机器人
    ClientRobot = 8,
    ---怪物生成
    GMMonster = 9,
    ---模型预览
    GMModelExhibition = 10,
    ---事件状态查看
    EventStateView = 11,
    --下载服务器资源
    LoadServerResources = 12,
}

luaSplitType = {
    jinghao = 1,
    xiahuaxian = 2,
    maohao = 3
}

LuaEnumVoiceRoomType = {
    ---帮会房间
    UnionRoon = 1,
    ---队伍房间
    TeamRoom = 2
}

LuaEnumVoiceType = {
    ---语音消息
    VoiceMessage = 1,
    ---实时语音
    RealTimeVoice = 2
}

---语音消息类型
LuaEnumVoiceMessageType = {
    ---通用语音消息类型
    COMMON = 1,
    ---不发送服务器语音消息类型
    NOSERVER = 2,
}

luaEnumRenameType = {
    ---角色改名卡
    Role = 1,
    ---帮会改名卡
    Union = 2
}

---@class LuaEnumLogViewerLogType 日志面板日志类型
LuaEnumLogViewerLogType = {
    ---全部
    All = 0,
    ---网络消息
    NetworkMsg = 1,
    ---客户端消息
    ClientMsg = 2,
    ---本地日志
    LocalLog = 3,
    ---Unity日志
    UnityLog = 4,
    ---Unity警告
    UnityWarning = 5,
    ---Unity异常日志
    UnityError = 6,
}

---仓库ItemTips类型
LuaEnumStorageTipsType = {
    ---取消
    Quit = 0,
    ---存入
    Deposit = 1,
    ---取出
    TakeOut = 2,
    ---捐献
    Donate = 3,
}

---活动特殊条件显示类型
luaEnumAcitivityDuplicateSpecialConditionType = {
    ---战勋等级显示条件
    Warxun = 1
}

LuaEnumWayGetFuncType = {
    ---创建面板
    CreatePanel = 1,
    ---寻路和打开小飞鞋
    FindPathAndOpenFlyShose = 2,
    ---购买商品
    BuyCommodity = 3,
    ---前往杀怪
    GoAndKillMonster = 4,
    ---秘籍
    SecretBook = 5,
    ---查阅秘籍
    CheckSecretBook = 7,
    ---购买礼包
    BuyGift = 8,
    ---精英任务
    EliteTask = 10,
    ---尸王殿
    SHIWANGDIAN = 12,
}

LuaEnumWayGetType = {
    ---快速购买
    QuickBuy = 1,
    ---快速获取
    QuickGet = 2,
    ---礼包
    Gift = 3,
    ---交易行快捷购买
    QuickAuctionBuy = 4,
    ---boss击杀次数快捷购买
    BossTimeAdd = 5,
}

---拍卖行界面打开类型
---@class luaEnumAuctionPanelType
luaEnumAuctionPanelType = {
    ---交易
    Trade = 1,
    ---竞拍
    Auction = 2,
    ---求购
    Buying = 3,
    ---个人出售
    SelfSell = 4,
    ---个人竞拍
    SelfAuction = 5,
    ---个人求购
    SelfBuying = 6,
    ---摊位
    Stall = 7,
    ---猜你喜欢
    Guess = 8,
    ---交易记录
    TransactionRecord = 9,
    ---熔炼行
    Smelt = 10,
    ---个人熔炼
    SelfSmelt = 11,
    ---行会竞拍
    UnionAuction = 12,
    ---跨服摆摊
    ShareStall = 13,
}

---结义类型
LuaEnumSwornType = {
    --结义
    Swore = 1,
    --断义
    Absolute = 2,
}

---拍卖行目录类型
LuaEnumAuctionMenuType = {
    ---装备
    Equip = 1,
    ---宝物
    Treasure = 17,
    ---元素
    Element = 23,
    ---印记
    Signet = 46,
    ---技能书
    SkillBool = 58,
    ---灵兽相关
    Servant = 62,
    ---转生神石
    ReincarnationStone = 92,
    ---其他
    Other = 103,
}

---任务tips类型
LuaEnumMissionTipsType = {
    ---装备了tip
    Equip = 0,
    ---技能了tip
    Skill = 1,
    ---获得了tip
    Gain = 2,
    ---拾取了tip
    Pickup = 3,
    ---挖到了
    Digup = 4,
}

---主界面提示类型
---@class LuaEnumMainHintType
LuaEnumMainHintType = {
    ---更好的背包物品提示
    BetterBagItem = 1,
    ---回收背包物品提示
    RecycleBagItemTips = 2,
    ---可学技能提示
    SkillLearningAvailableTips = 3,
    ---更好的背包物品提示（高等级）
    BetterBagItem_HighLv = 4,
    ---推荐购买大聚灵珠(聚灵珠系统已去掉)
    BigJuLingZhuRecommendBuy = 5,
    ---使用宝箱提示
    SpecialBoxUseHint = 6,
}

---主界面提示中更好装备提示的子类型(按优先级从小到大排序,如果优先级变化则需要重新配置C#中CSBagItemHint.BagHintType的枚举数值)
---@class LuaEnumMainHint_BetterBagItemType
LuaEnumMainHint_BetterBagItemType = {
    ---空
    None = -1,
    ---未定义
    Undefined = 0,
    ---更好的血继装备
    BetterBloodEquip = 20,
    ---装备熔炼
    EquipMelting = 30,
    ---装备宝箱
    EquipBox = 40,
    ---有用的灵兽碎片
    UsefulServantFragment = 50,
    ---行会召唤令
    UnionSummonToken = 60,
    ---道具(策划配置)
    DeployProp = 70,
    ---塔罗牌推送
    TowerCardHint = 80,
    ---更好融合装备
    BetterBlendEquip = 90,
    ---灵兽经验丹(策划说算是宝箱类型)
    ServantExpBox = 100,
    ---灵兽装备炼化
    ServantEquipRefine = 186,
    ---炼化
    EquipRefine = 190,
    ---灵兽装备合成
    ServantEquipSynthesis = 196,
    ---合成
    EquipSynthesis = 200,
    ---元素提示
    BetterElement = 300,
    ---印记提示
    BetterSignet = 400,
    ---魂装镶嵌
    SoulEquip = 450,
    ---宝箱
    TreasureBox = 500,
    ---可用技能
    AvailableSkill = 600,
    ---灵兽肉身（通用）
    ServantBodyRecommend_COMMON = 701,
    ---灵兽肉身（寒芒）
    ServantBodyRecommend_HM = 702,
    ---灵兽肉身（落星）
    ServantBodyRecommend_LX = 703,
    ---灵兽肉身（天成）
    ServantBodyRecommend_TC = 704,
    ---灵兽生肖装备(通用)
    ServantEquipRecommend_Common = 801,
    ---灵兽生肖装备(寒芒)
    ServantEquipRecommend_HM = 802,
    ---灵兽生肖装备(落星)
    ServantEquipRecommend_LX = 803,
    ---灵兽生肖装备(天成)
    ServantEquipRecommend_TC = 804,
    ---推荐灵兽上阵(通用)
    ServantRecommend_COMMON = 901,
    ---推荐灵兽上阵(寒芒)
    ServantRecommend_HM = 902,
    ---推荐灵兽上阵(落星)
    ServantRecommend_LX = 903,
    ---推荐灵兽上阵(天成)
    ServantRecommend_TC = 904,
    ---更好装备
    BetterEquip = 1000,
    ---人物法宝装备
    RoleMagicEquip = 1500,
    ---人物时装推送
    Appearance = 1800,
    ---单个物品推送（针对策划配置的itemId对应的东西进行推送，这类物品正常来说推送频率很低）
    SingleItemHint = 2000,
}

---@class LuaEnumBetterItemHintReason 更好物品推送提示原因
LuaEnumBetterItemHintReason = {
    ---无原因
    None = 0,
    ---主角等级提升
    LevelUp = 1,
    ---主角转生等级提升
    ReinLevelUp = 2,
    ---背包物品刷新
    BagItemRefresh = 3,
    ---技能信息刷新
    SkillInfoRefresh = 4,
    ---游戏开始
    GameStart = 5,
    ---灵兽等级提升
    ServantLevelUp = 6,
    ---灵兽转生等级提升
    ServantReinLevelUp = 7,
    ---背包变动，灵兽不限制等级刷新
    ServantWithoutLevelRefresh = 8,
    ---怪物归属改变且归属是主角
    MonsterOwnerChangeIsMainPlayer = 9,
    ---炼化
    Refine = 10,
    ---合成
    Synthesis = 11,
    ---熔炼
    Melting = 12,
    ---背包整体数据变动
    BagDataChange = 13,
    ---重新刷新下一个物品
    ReshowItem = 14,
}

---@class LuaEnumHintPackageSource 推送包来源
LuaEnumHintPackageSource = {
    ---整体背包数据变化
    BagInfoMessage = 1,
    ---背包数据变化
    BagChangeMessage = 2,
}

---@class LuaEnumBetterItemDataSource 更好物品数据来源
LuaEnumBetterItemDataSource = {
    Bag = 1,
}

LuaEnumMilitaryRankPanelAttributeType = {
    ---神圣攻击
    HolyAttack = 0,
    ---神圣防御
    HolyDefence = 1,
}

---Buff表type字段
LuaEnumBuffType = {
    ---气血石buff
    BloodStone = 20,
    ---双倍经验buff
    DounbleExp = 21,
    ---精力腕力buff
    WristStrengthOrEnergy = 43,
    ---生肖boss伤害buff(玩家攻击生肖BOSS根据 灵兽满足等级条件的只数 造成不同比例的伤害)
    AnimalBossHurtBuff = 53,
    ---显示用Buff
    ForShowOnly = 79,
    ---狂暴Buff
    Violent = 91,
    ---boss护盾Buff
    BossShieldBuff = 92,
    ---飞升buff
    FeiSheng = 98,
    ---自动拾取
    AutoPick = 100,
    ---自动回收
    AutoRecycle = 201,
    ---自动挖掘
    AutoGather = 202,
}

---转移道具显示类型
LuaEnumForgeTransferType = {
    ---普通
    Normal = 1,
    ---上锁
    Lock = 2,
    ---可添加
    Add = 3,
}

LuaEnumMainChatType = {
    ---邮件
    Mail = 1,
    ---队伍
    Team = 2,
    ---好友
    Friend = 3,
}

---挖矿体力类型
LuaEnumMiningPowerType = {
    ---体力旺盛 绿色
    Green = 1,
    ---铿锵有力 蓝色
    Blue = 2,
    ---有点疲惫 黄色
    Yellow = 3,
    ---非常疲惫 粉红色
    Pink = 4,
    ---精疲力尽 红色
    Red = 5,
}

---摊位类型
LuaEnumStallType = {
    ---本服
    MainServer = 1,
    ---跨服
    CrossServer = 2
}

---点击头像面板子类型（仇人）
luaEnumClickEnemyHeadChildType = {
    ---仇人
    Enemy = 1,
    ---悬赏
    Arrest = 2,

}

---格子交互类型
---@class LuaEnumGridInteractionType
LuaEnumGridInteractionType = {
    ---无
    None = 0,
    ---单击
    SingleClick = 1,
    ---双击
    DoubleClick = 2,
    ---长按
    LongPress = 3,
    ---长按后拖拽
    DragAfterLongPress = 4,
}

---获取途径功能类型 (与上面重复)
--LuaEnumWayGetFuncType = {
--    ---打开面板
--    OpenPanel = 1,
--    ---传送坐标
--    TransferPoint = 2,
--    ---商店快捷购买
--    StoreBuy = 3,
--}

---沙城争霸界面类型
LuaEnumCityWarPanelType = {
    ---杀戮榜
    KillPanel = 1,
    ---守护榜
    Defence = 2,
    ---战损榜
    Damage = 3,
}

---公告类型
LuaEnumAnnounceType = {
    ---跑马灯公告
    Top = 1,
    ---二级顶部公告
    MiddleTop = 2,
    ---系统公告
    System = 3,
    ---帮会公告
    Union = 4,
    ---队伍公告
    Team = 5,
    ---二级底部公告
    MiddleDown = 6,
}

---拖拽背包物品到角色界面的类型
---@class LuaEnumDropBagItemOnRolePanelType
LuaEnumDropBagItemOnRolePanelType = {
    ---背包界面拖拽物品到角色界面
    ByBagPanel = 1,
}

LuaEnumUIOrderType = {
    ---打开面板
    OpenPanel = 1,
    ---关闭面板
    ClosePanel = 2,
}

---婚姻功能类型
LuaEnumMarriageType = {
    ---结婚
    Marry = 1,
    ---婚礼
    Wedding = 2,
    ---破镜重圆一级
    FirstBrokenMirror = 3,
    ---婚戒操作
    WeddingRingMore = 4,
    ---离婚
    Divorce = 5,
    ---破镜重圆二级
    SecondBrokenMirror = 6,
    ---申请离婚
    ApplyDivorce = 7,
    ---强制离婚
    ForceDivorce = 8,
    ---婚戒升级
    WeddingRingUp = 9,
    ---修改誓言
    ChangeOath = 10,
    ---头像刻字
    HeadOath = 11,
}
---婚姻状态枚举
LuaEnumMaritalState = {
    ---结婚
    Married = 1,
    ---未婚
    UnMarried = 2,
}

---维修格子状态
LuaEnumRepairGridState = {
    ---选中
    Choose = 1,
    ---未选中
    UnChoose = 2,
    ---置灰
    Gray = 3,
}

---活动栏按钮对应的notice表id
LuaEnumNoticeType = {
    ---活跃度
    Active = 17,
}

---活跃度任务显示奖励类型
luaEnumActiveShowRewardType = {
    ---接受前
    BeforeAccept = 1,
    ---接受后
    AfterAccept = 2,
}

---角色面板类型
luaEnumRolePanelType = {
    ---基础
    Base = 1,
    ---角色属性
    DataDelta = 2,
}

---镖车状态
LuaEnumCarState = {
    ---无归属
    NoAttribution = 0,
    ---争夺中
    IsFight = 1,
    ---被占领
    BeOccupied = 2
}

---货币颜色
LuaEnumCoinsColor = {
    ---无归属
    JinBi = "[ffdc38]",
    ---争夺中
    YuanBao = "[ffbc1c]",
    ---被占领
    ZuanShi = "[cca6ff]",
}

LuaEnumServerState = {
    ---维护
    Maintain = 4,
    ---新服
    NewServer = 1,
    ---畅通
    Smooth = 2,
    ---爆满
    Full = 3,
}

---掉落物品类型
LuaEnumDropDataType = {
    ---掉落无偿领取物品
    Drop_FreeGetItem = 0,
    ---掉落待赎回物品
    Drop_WaitGetItem = 1,
    ---拾取无人赎回物品
    Pick_NoBodyGetItem = 2,
    ---拾取待领取赎金物品
    Pick_WaitGetCoinItem = 3,
    ---拾取待归还物品（同帮会）
    Pick_WaitGiveBack_SameUnion = 4,
    ---拾取待归还物品（不同帮会）
    Pick_WaitGiveBack_DifferentUnion = 5,
}

---二次确认类型
---@class LuaEnumSecondConfirmType
LuaEnumSecondConfirmType = {
    ---仲裁官掉落购买二次确认
    Aribitrator_DropBuy = 31,
    ---仲裁官拾取归还二次确认
    Aribitrator_PickGiveBack = 32,
    ---镖车进入副本二次确认
    DortCar_EnterDuplicate = 33,
    ---商会花费二次确认
    CommerceCost = 40,
    ---商会续费二次确认
    CommerceRenew = 41,
    ---前往镖车活动二次确认
    ComeDartActivity = 47,
    ---个人镖车被攻击
    PersonCarBeAttack = 59,
    ---个人镖车被击杀
    PersonCarBeKill = 60,
    ---个人镖车成功抵达
    PersonCarSuccess = 61,
}

---帮助面板类型
LuaEnumHelpPanelType = {
    Aribitrator_Help = 94,
}

---气泡枚举
LuaEnumPopoTipsType = {
    ---元宝不足
    NoEnoughYuanBao = 139,
    ---背包已满
    FullBag = 140,
    ---赎回领取已达上限
    Arbitrator_CantReceive = 141,
    ---商会货币不足
    CommerceNoEnoughMoney = 149,
}

luaEnumActivityBtnType = {
    ---交易行
    Auction = 11,
    ---排行榜
    Rank = 12,
    ---日活
    Active = 17,
    ---历法
    Calendar = 28,
    ---商会
    Commerce = 29,
    ---竞技
    Competition = 30,
    ---充值
    Recharge = 34,
    ---Boss
    Boss = 15,
    ---首充奖励
    FirstRechargeReward = 25,
    ---寻宝
    Treasure = 27,
    ---夺榜
    ContantRank = 41,
    ---霸业
    Overlord = 43,
    ---精英悬赏
    EliteOffer = 45,
    ---联服活动
    SpecialActivity_KuaFu = 50,
    ---限时活动
    SpecialActivity_Limit = 51,
    ---联盟投票
    LeagueVote = 54,
    ---调查问卷
    Survey = 56,
    ---灵兽任务
    LsMission = 66,
    ---白日门活动
    BaiRiMenActivity = 68,
    ---闯天关
    ChuangTianGuan = 70,
    ---会员
    MemberPanel = 80,
    ---大金指南
    DaJin = 81,
}

---婚戒功能
LuaEnumWeddingRingFuncType = {
    AddFriendLove = 1,
    ChangeOath = 2,
    SpouseSalutation = 3,
    HeadOath = 4,
    SpouseBuff = 5,
    SpouseSkill = 6,
    SendDiamond = 7,
}

---物品信息界面物品类型
---@class LuaEnumItemInfoPanelItemType
LuaEnumItemInfoPanelItemType = {
    ---人物装备
    RoleEquip = 1,
    ---灵兽蛋
    Servant_Egg = 2,
    ---灵兽装备
    Servant_Equip = 3,
    ---灵兽肉身
    Servant_BodyEquip = 4,
    ---婚戒
    MarryRing = 5,
    ---勋章
    DoubleMedal = 6,
    ---其他物品信息
    Other = 7,
    ---灵兽碎片
    Servant_Fragment = 8,
    ---背包戒指
    MarryRing_Bag = 9,
    ---角色戒指
    MarryRing_Role = 10,
    ---日常任务Item
    SpecialMission = 11,
    ---灵兽肉身通用
    Servant_BodyCommon = 12,
    ---宝物额外物品
    GemExtraItem = 13,
    ---魂继物品
    HunJi = 14,
    ---法宝
    MagicEquip = 15,
    ---灵兽血继tips
    BloodSuit = 16,
    ---神力装备
    DivineEquip = 17,
    ---暗器
    AnQi = 18,
    ---藏品
    Collection = 19,
    ---潜能武器
    PotentialEauip = 20,
    ---升级VIP
    UpgradeMembership = 21,
    ---阵法装备
    ZhengFaEquip = 22,
    ---兵鉴装备
    BingJianSL = 23,
}

---称谓id类型
LuaEnumAppellation = {
    ---帮会
    Union = 1,
    ---婚姻
    Marrige = 2,
}

---物品信息面板模块类型
LuaEnumItemInfoPanelModulesType = {

}

---月卡种类
LuaEnumCardType = {
    ---商会
    Coceral = 1,
}

---商会月卡种类
LuaEnumCoceralCardType = {
    ---无月卡
    None = 0,
    ---比奇月卡
    BiqiMonthCard = 1,
    ---盟重月卡
    MengZhongMonthCard = 2,
    ---盟重体验卡
    MengZhongMonthTasteCard = 3,
}

---月卡价格类型
LuaEnumMonthCardPriceType = {
    ---原价
    Origin_Price = 1,
    ---开服特价
    OpenServer_Price = 2,
    ---续费折扣价
    Renew_Price = 3,
}

LuaEnumDailyTaskButtonType = {
    ---任务
    Task = 1,
    ---商店
    Store = 2,
    ---其他
    Other = 3,
}

---月卡价格文本格式类型
luaEnumMonthCardPriceTextType = {
    ---盟重原价文本格式
    MengZhongOriginPriceText = 0,
    ---盟重限时价文本格式
    MengZhongPriceLimitTimePriceText = 1,
    ---盟重现价文本格式
    MengZhongNowPriceText = 2,
    ---比奇现价文本格式
    BiQiNowPriceText = 3,
    ---无文本格式
    None = 999
}

---活动(对应cfg_daily_activity_time表)
luaEnumActivityTypeByActivityTimeTable = {
    ---无
    NONE = 1,
    ---行会押镖
    DartCar = 224,
    ---女神赐福
    GoddessesBless = 235,
    ---武道会
    BuDouKai = 236,
    ---保卫国王
    DefendKing = 237,
    ---幻境迷宫
    DreamlandMaze = 238,
    ---魔法阵
    MagicCircle = 253,
    ---沙巴克
    ShaBaK = 101,
    HHSL = 433
}

---帮会发放玩家列表类型
luaEnumUnionGrantPlayerListType = {
    ---单选玩家列表
    OnePlayerList = 1,
    ---多选玩家列表
    AllPlayerList = 2,
}

---下注玩家列表类型
luaEnumBetPlayerListType = {
    ---晋级
    PROMOTION = 1,
    ---争霸
    CONTENTHEGEMONY = 2,
}

---武道会状态
luaEnumBuDouKaiStage = {
    ---刚入场
    NONE = 0,
    ---等待
    WAIT = 1,
    ---预选赛
    TRIIALS = 2,
    ---第一次中场休息
    FRISTREST = 3,
    ---第一次中场休息结束
    FRISTRESTOVER = 4,
    ---晋级赛
    PROMOTION = 5,
    ---第二次中场休息
    SCEONDREST = 6,
    ---第二次中场休息结束
    SCEONDRESTOVER = 7,
    ---争霸赛
    FINAL = 8,
    ---争霸赛结束
    FINALOVERR = 9,
}

---武道会阶段状态
luaEnumBuDouKaiStageState = {
    ---无
    NONE = 0,
    ---未开始
    NOSTART = 1,
    ---等待开始
    WAITSTART = 2,
    ---正在进行中
    INPROGRESS = 3,
    ---结束
    END = 4,
}

---客户端地图通用响应消息类型
LuaEnumCommonMapMsgType = {
    ---组队成员血量
    GROUPHP = 1,
    ---武道会请求传送信息
    BUDOUKAIREQ_TRANSFER = 2,
    ---通知墙是否可撞
    MEET_WALL = 3,
    ---武道会杀人数/存活数
    BUDOUKAI_KILLNUM = 4,
    ---武道会赔率
    BUDOUKAI_ODDS = 5,
    ---进入仓库未加入商会
    NotJoinedChamberOfCommerce = 6,
    ---神庙寻宝
    Hunt_Status = 8,
    ---神庙传送
    Temple_Trans = 9,
    ---怪物尸体采集状态改变
    GatherMonsterStateChange = 10,
    ---腕力药水推送
    WristPotionPush = 11,
    ---精力药水推送
    EnergyPotionPush = 12,
    ---播放经验飘字
    PlayExpFloateWord = 13,
    ---客户端可以发进入地图的包了
    Can_Login_Map = 14,
    ---神级boss活动开启
    GodBossActivityOpen = 15,
    ---登入跨服地图次数
    LoginLeagueMapTime = 24,
    ---隐藏地图倒计时消息
    HidenMapCountDown = 32,
}

---沙巴克提示类型
luaEnumShaBakTipsType = {
    ---城主雕像死亡
    FlagDie = 1,
    ---密道法阵激活成功预警
    MiDaoFaZhenWarring = 2,
}

LuaEnumShaBaKShopDeliveryOpenType = {
    ---商店传送员
    ShopDelivery = 1;
    ---行会管理员
    GuildManager = 2;
}

---副本类型
luaEnumDuplicateType = {
    ---圣域空间
    Sanctuary = 25
}

---历法活动id
luaEnumCalendarActivityId = {
    ---武道会
    BUDOUKAI = 236
}

---灵兽类型
---@class luaEnumServantType
luaEnumServantType = {
    ---无
    NONE = 0,
    ---寒芒
    HM = 1,
    ---落星
    LX = 2,
    ---天成
    TC = 3,
    ---通用
    COMMON = 4
}

---灵兽位类型
---@class luaEnumServantSeatType
luaEnumServantSeatType = {
    ---寒芒
    HM = 1,
    ---落星
    LX = 2,
    ---天成
    TC = 3
}

---@class luaEnumCompetitionType 商业化-竞技类型
luaEnumCompetitionType = {
    ---冲级
    LevelUp = 1,
    ---战勋
    Prefix = 2,
    ---首杀
    FirstKill = 3,
    ---首爆
    FirstDrop = 4,
    ---回收
    Recycle = 5,
    ---开服竞技
    OpenActivity = 6,

    ---特惠礼包(特殊增加的,与activity_common无关)
    PreferenceGift = 1000,
    ---潜能投资(特殊增加的,与activity_common无关)
    PotentialInvest = 1001,
}

---获取最好聚灵珠途径
luaEnumGetBeadsJvLingZhuType = {
    NORMAL = 0,
    PRICE = 1,
    CoinsChange = 2,
}

---武道会擂台状态类型
luaEnumArenaStageType = {
    ---关闭
    CLOSE = 0,
    ---打开
    OPEN = 1,
}

---秘籍链接种类
luaEnumGetSecretBookType = {
    Item = 1,
    Panel = 2,
    NPC = 3,
    GameSecret = 4,
}

---充值奖励类型
luaEnumRechargeRewardType = {
    ---在线奖励
    Online = 1,
    ---累充奖励
    Recharge = 2,
    ---直购奖励
    Buy = 3,
    ---分享
    Share = 4,
    ---限时直购
    LimitBuy = 5,
    ---每次累充
    DayRecharge = 6,
    ---元宝礼包
    IngotRecharge = 7,
    ---钻石礼包
    DiamondRechargeGift = 11,
    ---终生限购
    LastRecharge = 12,
    ---循环钻石
    CircleDiamondGift = 13,
}

---聊天频道类型
luaEnumChatChannelType = {
    ---综合
    COMPREHENSIVE = 0,
    ---世界
    WORLD = 1,
    ---附近
    NEARBY = 2,
    ---系统
    SYSTEM = 3,
    ---帮会
    UNION = 4,
    ---私聊
    PRIVATE = 5,
    ---组队
    TEAM = 6
}

---物品信息面板信息来源
---@class luaEnumItemInfoSource
luaEnumItemInfoSource = {
    ---无
    NONE = 0,
    ---角色面板
    UIROLEPANEL = 1,
    ---其他角色面板
    UIOTHERROLEPANEL = 2,
    ---炼化
    UIREFINERESULT = 3,
}

---回收设置选项类型
---@class luaEnumRecycleSettingOptionType
luaEnumRecycleSettingOptionType = {
    ---人物升星装备
    ROLEEQUIP_UPSTAR = 1,
    ---人物转生装备
    ROLEEQUIP_REIN = 2,
    ---转生灵兽
    ServantEgg_REIN = 3,
    ---转生灵兽装备
    ServantEquip_REIN = 4,
    ---藏品
    Collection = 5,
    ---青铜器
    QingTongQi = 5,
    ---陶器
    TaoQi = 6,
    ---瓷器
    CiQi = 7,
    ---玉器
    YuQi = 8,
    ---金银器
    JinYinQi = 9,
    ---法器
    FaQi = 10,
}

---回收设置选项勾选类型
---@class luaEnumRecycleSettingOptionCheckType
luaEnumRecycleSettingOptionCheckType = {
    ---单选
    SINGLECHOOSE = 1,
    ---多选（单个勾选）
    MUILTIPLECHOOSE_SingleCheck = 2,
    ---多选（多个勾选）
    MUILTIPLECHOOSE_MULTIPECHECK = 3,
}

---回收选项类型(当前以被改成了Recover表id)
---@class luaEnumRecycleOptionType
luaEnumRecycleOptionType = {
    ---等级装备
    LEVELEQUIP = 1,
    ---转生装备
    REINLVEQUIP = 2,
    ---特殊装备
    SPECIALEQUIP = 3,
    ---药品
    DRUG = 4,
    ---技能书
    SKILLBOOK = 5,
    ---灵兽
    SERVANT = 6,
    ---灵兽肉身
    SERVANTBODY = 7,
    ---灵兽装备
    SERVANTEQUIP = 8,
    ---转生石
    REINSTONE = 9,
    ---元素
    ELEMENT = 10,
    ---印记
    SIGNET = 11,
    ---其他材料
    OTHERMATERIAL = 12,
    ---藏品
    COLLECTION = 13,
    ---仙装
    XianZhuang = 14,
    QingTongQi = 35,
    TaoQi = 36,
    CiQi = 37,
    YuQi = 38,
    JinYinQi = 39,
    FaQi = 40
}

---维修类型
luaEnumRepairType = {
    ---角色装备
    Role = 1,
    ---背包装备
    Bag = 2,
    ---灵兽装备
    Servant = 3,
    ---神力装备
    Divine = 4,
}

---服务器请求通用消息类型
luaEnumReqServerCommonType = {
    COMMON_REQ_NAME_BY_ID = 1,
    LOGOUT = 2, --主动退出
    BACK_TO_CHOOSE_ROLE = 3, --返回选角
    START_FAIL_EXCEPTION = 4, --服务器启动失败原因
    GROUP_MANIFESTO = 5, --组队宣言
    PlayIsOnLine = 6; --玩家是否在线
    GROUP_CAPTION_SET_ALLOW_MODE = 7, --队长设置自己的组队模式  data:设置模式  1：同会 2:验证
    GROUP_MEMBER_SET_ALLOW_MODE = 8, --设置自己的组队模式 data:设置模式  1：同会，2：任何 3：验证
    --请求获取自己已经进入塔罗神庙的免费的次数
    HUNT_MONSTER_MAP_NO_SPEND_COUNT = 9,
    ---商店刷新时间通知
    StoreNextFlush = 10,
    CountType = 12, ---请求数据请求通用（联盟数据需要参数 data：luaEnumLeagueInfoMsgType）
    ---联服信息
    ShareBasicInfo = 14,
}

---服务器响应通用消息类型
luaEnumRspServerCommonType = {
    CommonResNameByID = 1,
    ---零点事件
    MidNight = 2,
    ---穿脱装备
    PutOnTheEquip = 4,
    ---商业化-竞技活动可领取
    Activity_CanAward = 8,
    ---玩家是否在线 0 不在 1 在
    PlayIsOnLine = 9,
    ---跳转好友聊天界面
    TransferFriendChat = 10,
    ---玩家零点等级变化
    PlayerZeroLevelChange = 11,
    ---使用祝福油 0 无变化 1 +1 2 -1
    UseLuckOilCallBack = 12,
    ---使用诅咒神水 0 无变化 1 +1 2 -1
    UseCurseWaterCallBack = 13,
    ---玩家每天首次登陆
    FirstLogIn = 14,
    ---打开武道会结算面板
    OpenBuDouKaiRankPanel = 15,
    ---寻宝仓库有道具
    TreasureWarehouseHaveProp = 16,
    ---组队被拒绝
    Group_Refuse = 17,
    ---返回获取自己已经进入塔罗神庙的免费的次数  data:次数
    HUNT_MONSTER_MAP_NO_SPEND_COUNT = 18,
    ---灵兽修炼坐标设置失败
    ServantCultivate_Fly_Fail = 22,
    ---商店刷新时间通知
    StoreNextFlush = 23,
    ---跨服状态
    KuaFuState = 27,
    ---人物通过经验宝箱获得经验 data：count data64:itemId
    RoleExpChangeByExpBox = 28,
    ---活动红点
    SpecialActivity = 29,
    ---灵兽经验和灵力
    ServantExpAndReinPool = 30,
    ---角色获得声望跳字
    AddShengWang = 33,
    ---重启客户端
    RestartClient = 34,
}

---行会管理员打开类型
LuaEnumShaBaKGuildManagerPanelType = {
    ---商店传送员
    ShopDelivery = 1,
    ---行会排名
    UnionRank = 2,
    ---行会推荐
    UnionRecRecommend = 3,
}

---@class LuaEnumPersonDartCarStateType 个人押镖镖车状态类型
LuaEnumPersonDartCarStateType = {
    ---无
    NONE = 0,
    ---待出发
    WITEDRIVING = 1,
    ---正在运行的镖车
    DRIVING = 2,
    ---运送结束待领取奖励的镖车
    ENDDRIVING = 3,
}

---个人押镖面板状态类型
LuaEnumPersonDartCarPanelStateType = {
    NORMAL = 1,
    SPECIAL1 = 2,
}

---个人押镖镖车状态类型
LuaEnumPersonCarStateType = {
    ---被攻击
    BEATTACK = 1,
    ---被击杀
    BEKILL = 2,
    ---成功到达
    SUCCESS = 3,
}

---@class LuaEnumPersonCarEndType 个人押镖镖车结束状态
LuaEnumPersonCarEndType = {
    ---无
    NONE = 0,
    ---失败
    DEFEAT = 1,
    ---成功
    SUCCESS = 2,
}

---个人镖车发车错误码
LuaEnumPersonCarStartDefault = {
    ---冷却中
    LOADING = 1,
}

---@class LuaEnumDartCarState 镖车状态类型
LuaEnumDartCarState = {
    Stop = 0,
    Run = 1,
}

---闪烁气泡id类型
LuaEnumFlashIdType = {
    ---个人押镖被攻击
    PersonDartCar_BeAttack = 18,
    ---个人押镖被击杀
    PersonDartCar_BeKill = 19,
    ---个人押镖成功抵达
    PersonDartCar_Success = 20,
    ---魔法神石提醒
    MagicGodStoneHint = 25,
    ---魔法结阵开启提醒
    MagicCircleIsOpenHint = 26,
    ---发放帮会红包提醒
    UnionSendRedPack = 27,
    ---领取帮会红包提醒
    CanRewardUnionRedPack = 28,
    ---商會推送
    MengZhongCommerceHint = 30,
    ---特殊地图
    DeliverSpecialMap = 38,
}

---@class LuaEnumAuctionSelfSellType
LuaEnumAuctionSelfSellType = {
    ---上架
    Shelf = 1,
    ---摆摊
    Stall = 2,
}

---推送类型
LuaEnumCheatPushTabelType = {
    ---秘籍
    SecretBook = 1,
    ---任务
    Mission = 2,
}

LuaEnumWayGetPanelArrowDirType = {
    ---箭头向左
    Left = 1,
    ---箭头向下
    Down = 2,
    ---箭头固定左上
    LeftUp = 3,
    ---箭头固定上
    Top = 4,
    ---向上箭头但是箭头在左边
    TopLeft = 5,
    ---右边向上但是箭头在右边
    TopRight = 6,
}

---箭头类型
---@class LuaEnumArrowType
LuaEnumArrowType = {
    NONE = -1,
    ---绿色箭头
    GreenArrow = 0,
    ---黄色箭头
    YellowArrow = 1,
}

---点击Tip面板装备的时候,所指向的目标类型
---@class LuaEnumEquipTargetType
LuaEnumEquipTargetType = {
    --没有特殊指定,就按以前的走
    None = 0,
    --灵兽位1-寒芒
    Servant_1 = 1,
    --灵兽位2-落星
    Servant_2 = 2,
    --灵兽位3-天成
    Servant_3 = 3,
}

---聊天信息按钮类型
LuaEnumChatInfoBtnType = {
    ---回赠鲜花
    RebateFlower = 1,
    ---鲜花回复
    FlowerReply = 2,
    ---添加好友
    AddFriend = 3,
    ---同意好友申请
    Agree = 4,
}

---物品信息面板模块类型
LuaEnumItemInfoModuleType = {
    ---Icon和基础信息
    IconAndBaseMsg = 1,
    ---基础属性
    BaseAttribute = 2,
    ---额外属性
    ExtraAttribute = 3,
    ---道具描述
    ItemDescription = 4,
    ---获取途径描述
    WayGetDescription = 5,
    ---右上角操作按钮
    RightUpOperate = 6,
    ---右下角操作按钮
    RightDownOperate = 7,
    ---页签按钮
    PageOperate = 8,
    ---道具描述2
    ItemDescription2 = 9,
    ---道具列表（可兑换，可获取）
    ItemList = 10,
    ---道具的唯一固定下方的技能
    ItemFixLowerSkill = 11,
    ---兵鉴tips
    BingJianInfo = 12,
}

---经验大师面板按钮类型
LuaEnumRefineMasterLeftPanelBtnType = {
    ---炼制修为
    RoleExp = 1,
    ---炼制灵兽修为
    ServantExp = 2,
    ---炼制功勋
    GongXun = 3,
}

---钻石上架类型
LuaEnumDiamondShelfType = {
    ---直购
    Buy = 1,
    ---竞拍
    Auction = 2,
    ---混合
    Mix = 3
}

---交易上架类型
LuaEnumAuctionTradeShelfType = {
    ---元宝
    YuanBao = 1,
    ---钻石
    Diamond = 2,
    ---混合
    Mix = 3,
}

---拍卖行竞拍界面二级目录类型
---@class LuaEnumAuctionPanelSecondMenuType
LuaEnumAuctionPanelSecondMenuType = {
    ---所有
    All = 1,
    ---竞拍道具
    AuctionItem = 2,
    ---直售道具
    BuyItem = 3,
    ---参与竞价道具
    JoinItem = 4,
}

---@class LuaEnumAuctionPanelSortType
LuaEnumAuctionPanelSortType = {
    ---结束时间
    OverTime = 1,
    ---竞价价格
    BidPrice = 2,
    ---一口价
    FixedPrice = 3,
    ---价格
    Price = 4,
    ---求购价格
    BuyPrice = 5,
    ---上架时间
    PutOnTime = 6,
}

LuaEnumAuctionTradeSortType = {
    ---价格升序
    PriceUp = 1,
    ---价格降序
    PriceDown = 2,
    ---时间升序
    TimeUp = 3,
    ---时间降序
    TimeDown = 4
}

LuaEnumAuctionTradeCoinSortType = {
    ---全部
    All = -1,
    ---钻石
    Diamond = 1000001,
    ---元宝
    YuanBao = 1000002,
}

LuaEnumAuctionTransactionRecordType = {
    ---全部
    All = 1,
    ---出售
    Sale = 2,
    ---购买
    Buy = 3,
    ---跨服出售
    ShareSell = 4,
    ---跨服购买
    ShareBuy = 5,
}

---其他玩家信息面板按钮类型
LuaEnumOtherPlayerBtnType = {
    ---无
    NONE = 0,
    ---角色
    ROLE = 1,
    ---灵兽
    SERVANT = 2,
    ---婚戒物品信息
    MARRYRINGITEMINFO = 3,
}

---其他玩家信息面板按钮子类型
LuaEnumOtherPlayerBtnSubtype = {
    ---无
    NONE = 0,
    ---其他角色
    OTHERROLE = 1,
    ---寒芒灵兽位
    SERVANT_HANMANG = 2,
    ---落星灵兽位
    SERVANT_LUOXING = 3,
    ---天成灵兽位
    SERVANT_TIANCHENG = 4,
}

---附件自适应类型
---@class LuaEnumAdjustAdaptionType
LuaEnumAdjustAdaptionType = {
    ---无
    None = 0,
    ---左适配
    Left = 1,
    ---右适配
    Right = 2,
    ---左上适配
    LeftUp = 3,
    ---右上适配
    RightUp = 4,
    ---左下适配
    LeftDown = 5,
    ---右下适配
    RightDown = 6,
}

LuaEnumFightMode = {
    ---和平
    Peace = 0,
    ---组队
    Team = 1,
    ---行会
    Union = 2,
    ---全体
    All = 3,
    ---阵营
    Camp = 5,

}

LuaEnumUnsatisfyEnterPanelType = {
    --门票
    Tickets = 1,
    --仓库
    Storage = 2,
}

---充值入口
LuaEnumRechargePointEntranceType = {
    --商城
    Shop = 1,
    --商城购买钻石不足
    ShopDiamondNotEnough = 2,
    --商城钻石获取
    ShopDiamondGetWay = 3,

    --上方领奖按钮(充值)
    Reward = 4,
    --首充
    FirstRecharge = 5,

    --交易行
    Auction = 6,
    --交易行购买钻石不足
    AuctionDiamondNotEnough = 7,
    --交易行购买钻石获取
    AuctionDiamondGetWay = 8,

    --购买日常任务钻石不足
    BuyDailyTaskDiamondNotEnough = 9,

    --聚灵珠
    JLZPanel = 10,

    --背包
    BagPanel = 11,

    --商会
    CommercePanel = 12,
    --商会商城购买钻石不足
    CommerceShopDiamondNotEnough = 13,

    --NPC商店
    NPCStore = 14,

    --连充
    ContinueRecharge = 15,
    --冲级奖励
    LevelUpReward = 16,
    --首杀奖励
    FirstKillReward = 17,
    --首爆奖励
    FirstDropReward = 18,
    --战勋奖励
    PrefixReward = 19,

    --天成任务
    LSSchoolPanel = 20,

    --购买第二只灵兽位货币不足
    SecondServantSiteCurrencyNotEnough = 21,
    --购买第三只灵兽位货币不足
    ThirdServantSiteCurrencyNotEnough = 22,

    --任务通关礼包
    TaskOpenRechargePanel = 23,

    --钻石礼包购买
    DiamondRechargeGiftPanel = 25,

    --合成面板
    SynthesisPanel = 26,

    --商会商城购买创造宝石不足
    CommerceShopGemsNotEnough = 27,

    --商城购买元宝不足
    ShopIngotNotEnough = 28,

    --商城元宝获取
    ShopIngotGetWay = 29,

    --交易行购买元宝获取
    AuctionIngotGetWay = 30,

    --背包元宝获取
    BagIngotGetWay = 31,

    --交易行购买元宝不足
    AuctionIngotNotEnough = 32,

    --商会月卡购买元宝不足
    CommercePanelIngotNotEnough = 33,

    --商会商城购买元宝不足
    CommerceShopIngotNotEngough = 34,

    --NPC商店元宝不足进行购买直充礼包
    NPCStoreIngotNotEnough = 35,

    --第二只灵兽位购买元宝不足
    SecondServantSiteIngotNotEnough = 36,
    --第三只灵兽位购买元宝不足
    ThirdServantSiteIngotNotEnough = 37,

    --钻石购买时推荐礼包
    DiamondToPushGiftPanel = 38,

    --灵兽聚灵面板
    ServantGatherSoulPanel = 39,

    --灵兽法宝
    ServantMagicWeapon = 40,

    --魔之Boss面板
    MagicBossPanel = 41,
    --开服活动
    OpenActivity = 42,

    --背包钻石获取
    BagDiamondGetWay = 43,

    --摊位
    Stall = 44,

    --每日累充
    DayRecharge = 45,

    --充值有礼（首次联服活动）
    CrossServerRechargeToReward = 46,

    --限购礼包（首次联服活动）
    CrossServerLimitGift = 47,

    --领奖内元宝礼包
    IngotGiftToReward = 48,

    --投资
    Investment = 49,

    --狂欢派对
    Carnival = 50,

    --闯天关
    CrawlTower = 51,

    --死亡复活
    PlayerDead = 52,

    --潜能投资
    PotentialInvest = 53,

    --会员点前往提升
    MemberPromote = 54,
    --会员点秒升会员礼包
    MemberGift = 55,

    --狂暴之力
    BerserkPower = 56,

    --交易行快捷购买
    QuickAuctionBuy = 57,

    --商城快捷购买
    QuickShopBuy = 58,

    --购买经验丹
    BuyExpElixir = 59,

    --练功房
    PracticeRoom = 60,

    --鉴定钻石不足
    AuthenticateDiamondNotEnough = 61,

    --行会鼓舞钻石不足
    UnionInspireDiamondNotEnough = 62,
}

---消费方式
LuaEnumRechargePointType = {
    --由商城进入直接充值
    ShopPanelToRecharge = 101,
    --由商城进入购买礼包
    ShopPanelToRewardGift = 102,

    --商城钻石不足进入直接充值
    ShopPanelDiamondNotEnoughToRecharge = 201,
    --商城钻石不足进入购买礼包
    ShopPanelDiamondNotEnoughToRewardGift = 202,
    --商城下方钻石Icon获取进入直接充值
    ShopPanelDiamondGetWayToRecharge = 203,
    --商城下方钻石Icon获取进入购买礼包
    ShopPanelDiamondGetWayToRewardGift = 204,
    --商城元宝不足进行购买直充礼包
    ShopPanelIngotNotEnoughToRewardGift = 205,
    --商城元宝获取
    ShopPanelIngotGetWayToRewardGift = 206,
    --商城金币不足购买直充礼包
    ShopPanelGoldNotEnoughToRewardGift = 207,
    --商城金币获取购买直充礼包
    ShopPanelGoldGetWayToRewardGift = 208,

    --由领奖进入直接充值
    RewardPanelToRecharge = 401,
    --由领奖进入购买礼包
    RewardPanelToRewardGift = 402,

    --由首充进入直接充值
    FirstRechargePanelToRecharge = 501,
    --由首充进入购买礼包
    FirstRechargePanelToRewardGift = 502,

    --交易行购买钻石不足进入直接充值
    AuctionDiamondNotEnoughToRecharge = 601,
    --交易行购买钻石不足进入购买礼包
    AuctionDiamondNotEnoughToRewardGift = 602,
    --交易行购买元宝不足进行直充礼包
    AuctionIngotNotEnoughToRewardGift = 603,
    --交易行获取元宝进入直充礼包
    AuctionIngotGetWayToRewardGift = 604,
    --交易行获取钻石进入直接充值
    AuctionDiamondGetWayToRecharge = 605,
    --交易行获取钻石进入购买礼包
    AuctionDiamondGetWayToRewardGift = 606,

    --购买日常任务钻石不足进入直接充值
    BuyDailyTaskDiamondNotEnoughToRecharge = 901,
    --购买日常任务钻石不足进入购买礼包
    BuyDailyTaskDiamondNotEnoughToRewardGift = 902,
    --购买日常任务金币不足进入直充礼包
    BuyDailyTaskGoldNotEnoughToRewardGift = 903,

    --使用聚灵珠元宝不足
    UseJLZIngotNotEnough = 1001,
    --使用聚灵珠金币不足
    UseJLZGoldNotEnough = 1002,
    --使用聚灵珠聚灵点不足
    UseJLZPointNotEnough = 1003,
    --使用聚灵珠聚钻石不足
    UseJLZDiamondNotEnough = 1004,

    --背包金币获取进行购买直充礼包
    BagGoldGetWayToRewardGift = 1101,
    --背包元宝获取进行购买直充礼包
    BagIngotGetWayToRewardGift = 1102,

    --商会月卡购买钻石不足进入直接充值
    CommercePanelDiamondNotEnoughToRecharge = 1201,
    --商会月卡购买钻石不足进入购买礼包
    CommercePanelDiamondNotEnoughToRewardGift = 1202,
    --商会月卡购买元宝不足购买直充礼包
    CommercePanelIngotNotEnoughToRewardGift = 1203,
    --商会商城购买钻石不足进入直接充值
    CommerceShopDiamondNotEnoughToRecharge = 1204,
    --商会商城购买钻石不足进入购买礼包
    CommerceShopDiamondNotEnoughToRewardGift = 1205,
    --商会商城购买元宝不足购买直充礼包
    CommerceShopIngotNotEngoughToRewardGift = 1206,

    --猎魔人进行充值
    LieMoRen = 1301,

    --NPC商店金币不足进行购买直充礼包
    NPCStoreGoldNotEnoughToRewardGift = 1401,
    --NPC商店元宝不足进行购买直充礼包
    NPCStoreIngotNotEnoughToRewardGift = 1402,

    --连充进行直接充值
    ContinueRechargeToRecharge = 1501,
    --连充进行购买礼包
    ContinueRechargeToRewardGift = 1502,

    --冲级奖励不足进行购买直充礼包
    LevelUpRewardIngotNotEnoughToRewardGift = 1601,
    --首杀奖励不足进行购买直充礼包
    FirstKillRewardIngotNotEnoughToRewardGift = 1701,
    --首爆奖励不足进行购买直充礼包
    FirstDropRewardIngotNotEnoughToRewardGift = 1801,
    --战勋奖励不足进行购买直充礼包
    PrefixRewardIngotNotEnoughToRewardGift = 1901,

    --灵兽学院元宝获取进行购买直充礼包
    LSSchoolIngotNotEnoughToRewardGift = 2001,

    --第二只灵兽位购买进行直接充值
    SecondServantSiteDiamondNotEnoughToRecharge = 2101,
    --第二只灵兽位购买进行购买礼包
    SecondServantSiteDiamondNotEnoughToRewardGift = 2102,
    --第二只灵兽位购买进行购买直充礼包
    SecondServantSiteIngotNotEnoughToRewardGift = 2103,

    --第三只灵兽位购买进行直接充值
    ThirdServantSiteDiamondNotEnoughToRecharge = 2201,
    --第三只灵兽位购买进行购买礼包
    ThirdServantSiteDiamondNotEnoughToRewardGift = 2202,
    --第三只灵兽位购买进行购买直充礼包
    ThirdServantSiteIngotNotEnoughToRewardGift = 2203,

    --通关礼包进行直接充值
    TaskRechargePanelToRecharge = 2301,
    --通关礼包进行购买直充礼包
    TaskRechargePanelToRewardGift = 2302,

    --宝箱钥匙
    BoxKey = 2401,
    --金/银宝箱
    SpecialBox = 2402,

    --钻石礼包不足跳转进行直接充值
    DiamondRechargeGiftPanelNotEnoughToRecharge = 2501,
    --钻石礼包不足跳转进行购买直充礼包
    DiamondRechargeGiftPanelNotEnoughToRewardGift = 2502,

    --合成面板材料不足进行直接充值
    SynthesisPanelMaterialsNotEnoughToRecharge = 2601,
    --合成面板材料不足进行购买直充礼包
    SynthesisPanelMaterialsNotEnoughToRewardGift = 2602,

    --商会商城购买创造宝石不足进入直接充值
    CommerceShopGemsNotEnoughToRecharge = 2701,
    --商会商城购买创造宝石不足进入购买礼包
    CommerceShopGemsNotEnoughToRewardGift = 2702,

    --商城元宝不足购买直接充值
    ShopPanelIngotNotEnoughToRecharge = 2801,
    --商城元宝不足购买直充礼包
    ShopPanelIngotNotEnoughToBuyRewardGift = 2802,

    --商城元宝获取购买直接充值
    ShopPanelIngotGetWayToRecharge = 2901,
    --商城元宝获取购买直充礼包
    ShopPanelIngotGetWayToBuyRewardGift = 2902,

    --交易行获取元宝进入直接充值
    AuctionIngotGetWayToReCharge = 3001,
    --交易行获取元宝进入直充礼包
    AuctionIngotGetWayToBuyRewardGift = 3002,

    --背包获取元宝进入直接充值
    BagIngotGetWayToReCharge = 3101,
    --背包获取元宝进入直充礼包
    BagIngotGetWayToBuyRewardGift = 3102,

    --交易行元宝不足进入直接充值
    AuctionIngotNotEnoughToReCharge = 3201,
    --交易行元宝不足进入直充礼包
    AuctionIngotNotEnoughToBuyRewardGift = 3202,

    --商会月卡元宝不足进入直接充值
    CommercePanelIngotNotEnoughToReCharge = 3301,
    --商会月卡元宝不足进入直充礼包
    CommercePanelIngotNotEnoughToBuyRewardGift = 3302,

    --商会商城购买元宝不足进入直接充值
    CommerceShopIngotNotEnoughToReCharge = 3401,
    --商会商城购买元宝不足进入直充礼包
    CommerceShopIngotNotEnoughToBuyRewardGift = 3402,

    --NPC商店元宝不足进入直接充值
    NPCStoreIngotNotEnoughToReCharge = 3501,
    --NPC商店元宝不足进入直充礼包
    NPCStoreIngotNotEnoughToBuyRewardGift = 3502,

    --第二只灵兽位购买元宝不足进入直接充值
    SecondServantSiteIngotNotEnoughToReCharge = 3601,
    --第二只灵兽位购买元宝不足进入直充礼包
    SecondServantSiteIngotNotEnoughToBuyRewardGift = 3602,
    --第三只灵兽位购买元宝不足进入直接充值
    ThirdServantSiteIngotNotEnoughToReCharge = 3701,
    --第三只灵兽位购买元宝不足进入直充礼包
    ThirdServantSiteIngotNotEnoughToBuyRewardGift = 3702,

    --推荐礼包购买钻石不足进入直接充值
    DiamondToPushGiftPanelToRecharge = 3801,
    --推荐礼包购买钻石不足进入直充礼包
    DiamondToPushGiftPanelToRewardGift = 3802,

    --灵兽聚灵面板充值按钮进入直接充值
    ServantGatherSoulPanelToRecharge = 3901,
    --灵兽聚灵面板充值按钮进入直充礼包
    ServantGatherSoulPanelToRewardGift = 3902,

    --灵兽法宝进入直接充值
    ServantMagicWeaponToRecharge = 4001,
    --灵兽法宝进入直充礼包
    ServantMagicWeaponToRewardGift = 4002,

    --魔之Boss进入直接充值
    MagicBossPanelToRecharge = 4101,
    --魔之Boss进入直充礼包
    MagicBossPanelToRewardGift = 4102,

    --背包点击钻石获取进入直接充值
    BagPanelDiamondGetWayToRecharge = 4301,
    --背包点击钻石获取进入直充礼包
    BagPanelDiamondGetWayToRewardGift = 4302,

    --摊位购买元宝不足进行直充礼包
    StallIngotNotEnoughToRewardGift = 4401,
    --摊位购买钻石不足进行直充礼包
    StallDiamondNotEnoughToRewardGift = 4402,

    --每日累充礼包进入充值
    DayRechargeToRecharge = 4501,
    --每日累充礼包进入购买礼包
    DayRechargeToRewardGift = 4502,

    --联服充值有礼进入充值
    CrossServerRechargeToRewardToRecharge = 4601,
    --联服充值有礼进入购买礼包
    CrossServerRechargeToRewardToRewardGift = 4602,

    --联服限购礼包进入充值
    CrossServerLimitGiftToRecharge = 4701,
    --联服限购礼包进入购买礼包
    CrossServerLimitGiftToRewardGift = 4702,

    --领奖界面元宝礼包进入充值
    IngotGiftToRewardToRecharge = 4801,
    --领奖界面元宝礼包进入购买礼包
    IngotGiftToRewardToRewardGift = 4802,

    --投资进入充值
    InvestmentToRecharge = 4901,
    --投资进入购买礼包
    InvestmentToRewardGift = 4902,

    --狂欢派对进入充值
    CarnivalToRecharge = 5001,
    --狂欢派对进入购买礼包
    CarnivalToRewardGift = 5002,

    --闯天关进入充值
    CrawlTowerToRecharge = 5101,
    --闯天关进入购买礼包
    CrawlTowerToRewardGift = 5102,

    --死亡复活进入充值
    PlayerDeadToRecharge = 5201,
    --死亡复活进入购买礼包
    PlayerDeadToRewardGift = 5202,

    --潜能投资进入充值
    PotentialInvestToRecharge = 5301,
    --潜能投资进入购买礼包
    PotentialInvestToRewardGift = 5302,

    --会员前往充值进入充值
    MemberPromoteToRecharge = 5401,
    --会员前往充值进入购买礼包
    MemberPromoteToRewardGift = 5402,

    --会员礼包进入充值
    MemberGiftToRecharge = 5501,
    --会员礼包进入购买礼包
    MemberGiftToRewardGift = 5502,

    --狂暴之力进入充值
    BerserkPowerToRecharge = 5601,
    --狂暴之力进入购买礼包
    BerserkPowerToRewardGift = 5602,

    --交易行快捷购买进入充值
    QuickAuctionBuyToRecharge = 5701,
    --交易行快捷购买进入购买礼包
    QuickAuctionBuyToRewardGift = 5702,

    --商城快捷购买进入充值
    QuickShopBuyToRecharge = 5801,
    --商城快捷购买进入购买礼包
    QuickShopBuyToRewardGift = 5802,

    --购买经验丹进入充值
    BuyExpElixirToRecharge = 5901,
    --购买经验丹进入购买礼包
    BuyExpElixirToRewardGift = 5902,

    --练功房进入充值
    PracticeRoomToRecharge = 6001,
    --练功房进入购买礼包
    PracticeRoomToRewardGift = 6002,

    --鉴定钻石不足进入充值
    AuthenticateDiamondNotEnoughToRecharge = 6101,
    --鉴定钻石不足进入购买礼包
    AuthenticateDiamondNotEnoughToRewardGift = 6102,

    --行会鼓舞钻石不足进入充值
    UnionInspireDiamondNotEnoughToRecharge = 6201,
    --行会鼓舞钻石不足进入购买礼包
    UnionInspireDiamondNotEnoughToRewardGift = 6202,

}

---个人押镖来源类型
LuaEnumPersonDartCarSourceType = {
    ---无
    NONE = 0,
    ---比奇发车
    BIQI = 1001,
    ---盟重发车
    MENGZHONG = 1002,
}

---个人押镖镖车列表类型
LuaEnumPersonDartCarListType = {
    NONE = 0,
    ---推荐镖车列表
    RecommendDartCarList = 1,
    ---前往领取镖车列表
    ToReceiveDartCarList = 2,
    ---领取镖车列表
    ReceiveDartCarList = 3,
}

---@class LuaEnumPersonDartCarType 个人镖车类型
LuaEnumPersonDartCarType = {
    NONE = 0,
    ---玩家经验镖车
    PLAYEREXP = 1,
    ---元宝镖车
    INGOT = 2,
    ---灵兽经验镖车
    SERVANTEXP = 3,
    ---白日门镖车-本服
    BaiRiMen_Locality = 4,
    ---白日门镖车-联服
    BaiRiMen_ShareServer = 5,
}

---活动排行榜面板类对应key
LuaEnuActivityRankID = {
    ---保卫国王
    DefendKing = 1,
    ---沙巴克
    ShaBaK = 2,
    ---女神赐福
    Goddess = 3,
    ---行会押镖
    UnionDartCar = 4,
    ---幻境迷宫
    DreamLandMaze = 5,
    ---武道会
    BuDouKai = 6,
}
---等级奖励面板状态
LuaEnuLvPackPanelStage = {
    ---默认状态
    NORMAL = 1,
    ---左侧icon显示状态
    LEFTICON = 2,
}

---历法活动类型
LuaEnmumDailyActivityType = {
    ---行会押镖
    UnionDartCar = 27,
    ---保卫国王
    DefendKing = 33,
}

---背包物品变化类型
LuaEnumBagChangeType = {
    NONE = 0,
    ---物品变化
    ItemChange = 1,
    ---货币变化
    CoinChange = 2,
}

LuaEnumUnionElectionBenefits = {
    ---职位任命
    PositionAppointment = 141,
    ---活动特权
    ActivityPrivilege = 142,
    ---成员管理
    MemberManage = 143,
    ---战利分配
    LootDistinction = 144,
    ---首任奖励
    FirstPrize = 145,
}

---排行榜称号类型
LuaEnumRankTitleType = {
    Mvp = 1,
    --最强护卫
    Defend = 2,
    --最强斩杀
    kill = 3,
    --最多死亡
    Dead = 4,
}

---队伍请求加入类型
LuaEnumTeamReqType = {
    ---同帮会自动加入
    UnionAutoJoin = 1,
    ---队长审核
    TeamLeaderReview = 2,
}

---队伍邀请加入类型
LuaEnumTeamJoinType = {
    ---同帮会自动加入
    UnionAutoJoin = 1,
    ---任何自动加入
    AnyAutoJoin = 2,
    ---需要本人验证
    NeedVerify = 3,
}

---打开其他玩家面板来源
LuaEnumOpenOtherPlayerPanelSource = {
    ---悬赏
    XuanShange = 1,
}

---武道会按钮类型
LuaEnumBuDouKaiBtnType = {
    ---不显示按钮
    NONE = 0,
    ---显示押注按钮
    SHOWBETBUTTON = 1,
    ---显示详细排行按钮
    SHOWRANKBUTTON = 2,
}

---帮会聊天选项类型
LuaEnumGuildChatChooseType = {
    ---关闭
    None = 0,
    ---表情
    Emotion = 1,
    ---背包
    Bag = 2,
    ---坐标
    Location = 3,
    ---设置
    Setting = 4,
}

---@class 合成逻辑类型
LuaEnumSynthesisType = {
    ---固定合成
    Normal = 0,
    ---随机合成
    Random = 1,
    ---分解
    Resolve = 2,
}

---@class LuaEnumDailyActivityType 日常活动类型（cfg_daily_activity_time.activityType）
LuaEnumDailyActivityType = {
    ---沙巴克
    ShaBaKe = 16,
    ---行会押镖
    GuildEscort = 27,
    ---联服
    ShareServer = 29,
    ---等级封印
    LevelLimit = 30,
    ---女神赐福
    Goddess = 31,
    ---保卫国王
    DefendTheKing = 33,
    ---幻境迷宫
    HJMiGong = 34,
    ---武道会
    WuDaoHui = 35,
    ---行会地宫
    HangHuiDiGong = 42,
    ---行会首领
    GuildBoss = 46,
    ---系统开启小礼包
    CalendarGift = 56,
    ---天魔降临
    DemonsComing = 69,
}

---活动点赞类型
LuaEnumActivityLikeType = {
    ---隐藏
    HidePraise = "",
    ---普通点赞
    NormalPraise = "ActivityRank_unpraise",
    ---点赞（高亮）
    HightPraise = "ActivityRank_praise",
    ---互赞
    MutualPraise = "ActivityRank_doublepraise",
}

---点赞类型
LuaEnumPraiseType = {
    ---空
    None = 0,
    ---互相点赞
    TogetherPraise = 1,
    ---有点赞
    HavePraise = 2,
    ---没有点赞
    NoPraise = 3,
}

---行会活动类型
LuaEnumUnionActivityType = {
    ---沙巴克
    ShaBake = 16,
    ---行会押镖
    UnionCart = 27,
    ---保卫国王
    ProtectKing = 33
}

---竞技活动目标类型
LuaEnumCompetitionAimType = {
    ---全服首杀
    ServerFistKill = 3000,
    ---个人首杀
    SelfFirstKill = 1010,
    ---全服首爆
    ServerFistDrop = 3001,
    ---个人首爆
    SelfFirstDrop = 1011,
}

---控制录音状态来源
LuaEnumControlRecordStateSource = {
    ---无
    NONE = 0,
    ---武道会
    BuDouKai = 1,
}

---二次确认时间类型
---@class LuaEnumSecondComfirmTimeType
LuaEnumSecondComfirmTimeType = {
    ---秒
    Second = 1,
    ---分和秒
    MinuteAndSecond = 2,
}

---行会战利品发放列表类型
LuaEnumGuildSendBenefitsListType = {
    ---选择列表
    ChooseList = 1,
    ---移除列表
    RemoveList = 2,
}

---商会特权类型
LuaEnumCommerceRightType = {
    ---无
    NONE = 0,
    ---商会特权
    CommerceRight = 1,
    ---塔罗神庙
    Fane = 2,
    ---商会商店
    CommerceStore = 3,
    ---积分商店
    IntegralStore = 4,
    ---王者禁地
    KingForbidden = 5,
    ---魔之Boss
    MoZhiBoss = 6,
    ---商会商城
    CommerceShop = 7,
}

---掠宝袋状态
LuaEnumTreasureBagState = {
    ---未开启
    UnOpen = 1,
    ---可领取
    Open = 2,
    ---下一个
    Next = 3,
    ---可以关闭
    Close = 4,
    ---第一次刷新（假数据）
    FirstRefresh = 5,
    ---第二次刷新（真数据）
    SecondRefresh = 6,
    ---自动开启
    AutoOpen = 7
}

--region 排行榜组件
LuaRankComponentSystem = {
    ---排行名次
    ranking = 1,
    ---名字
    name = 2,
    ---职业
    career = 3,
    ---等级
    level = 4,
    ---灵兽
    servant = 5,
    ---划拳积分
    finger = 6,
    ---奖励宝箱
    rewardBox = 7,
    ---魅力值
    charm = 8,
    ---夫妻信息
    lover = 9,
    ---亲密度
    intimacy = 10,
    ---性别
    sex = 11,
    ---送花数
    flower = 12,
    ---元宝交易额
    dealIngot = 13,
    ---行会
    guild = 14,
    ---boss击杀数
    killBoss = 15,
    ---人物击杀数
    KillPlayer = 16,
    ---装备掉落
    quiteDrop = 17,
    ---详情
    details = 18,
    ---战勋
    prefix = 19,
    ---称号
    title = 20,
    ---奖励
    reward = 21,
    ---排行文本（夺榜）
    rankingStr = 22,
    ---通用文本（都是用param 赋值）
    normalStr = 23,
    ---法阵等级
    formation = 24,
}

---缓存池错误id
LuaEnumCachePoolFaultCode = {
    ---正常
    NONE = 0,
    ---超出克隆数量
    EXCEEDMAXCOUNT = 1,
    ---克隆出错
    PushOutDefeat = 2,
}

---
LuaEnumFirstRechargePushType = {
    ---新服优势
    NewServerPush = 1,
    ---首充推送
    FirstRechargePush = 2,
}

---炼化界面左侧界面类型
LuaEnumRefineLeftPanelType = {
    ---角色装备
    RoleEquip = 1;
    ---背包
    Bag = 2;
    ---灵兽
    Servant = 3;
}

---lua中使用的ConfigID,使用CS.CSScene.MainPlayerInfo.ConfigInfo的GetInt方法和SetInt方法来获取和设置,进入场景后有效
LuaEnumLuaConfigID = {
    ---面巾之前是否装备过,0表示没有装备过,1表示装备过
    IsFaceEquippedBefore = 1000001,
    ---斗笠之前是否装备过,0表示没有装备过,1表示装备过
    IsDouliEquippedBefore = 1000002,
    ---左手武器之前是否装备过,0表示没有装备过,1表示装备过
    IsLeftWeaponEquippedBefore = 1000003,
}

---购买灵兽位货币类型
LuaEnumBuyServantSiteType = {
    ---钻石
    Diamond = 1;
    ---元宝
    Ingot = 2
}

---传送员页签类型
LuaEnumTeleportType = {
    ---主城地图
    MainCityMap = 1,
    ---等级地图
    levelMap = 2,
    ---转生地图
    ReinMap = 3,
    ---特殊地图
    SpecialMap = 6,
    ---衣服地图
    ClothesMap = 7,
}

---装备变化原因(服务器数据)
LuaEnumEquipChangeReason = {
    ---炼化
    REFINER = 1,
    ---其他
    OTHER = 2,
    ---升星
    UP_STAR = 6
}
---霸业组件类型
LuaEnumOverlordComponentType = {
    ---行会排名
    UnionRank = 1,
    ---行会名称
    UnionName = 2,
    ---繁荣度
    Prosperity = 3,
    ---奖励预览
    UnionReward = 4,
    ---职位
    UnionPosition = 5,
    ---玩家姓名
    PlayerName = 6,
    ---贡献度
    Contribution = 7,
    ---玩家排名
    PlayerRank = 8,
    ---领取按钮
    GetRewardBtn = 9,
    ---排名图片
    RankSprite = 10,
    ---特殊文本
    OverlordText = 11,
    ---特殊时间
    OverlordTime = 12,
    ---称号
    Title = 13,
    ---竞技按钮
    CompetitionBtn = 14,

    ---玩家姓名(领袖特殊)
    SecondPlayerName = 106,
    ---贡献度 （领袖特殊）
    SecondContribution = 107,
    ---特殊文本
    SecondOverlordText = 108,
    ---已领取
    ReceivedReward = 109,

}

---道具使用次数id
LuaEnumItemCountId = {
    ---白银宝箱
    AgBox = 5770010,
    ---金宝箱
    AuBox = 5770011,
}

---主城地图
---@class LuaEnumMainCity
LuaEnumMainCity = {
    ---非主城
    None = 0,
    ---比奇
    BiQi = 1,
    ---盟重
    MengZhong = 2,
    ---白日门
    BaiRiMen = 3,
    ---玛法森林
    MaFaSenLin = 4,
    ---沙巴克
    ShaBaKe = 5,
    ---绿洲
    LvZhou = 6
}

---奖励排行榜名次类型
LuaEnumRewardRankingType = {
    None = 0,
    Label = 1,
    Sprite = 2,
}

LuaEnumBoxRewardType = {
    None = 0,
    ---单个
    Single = 1,
    ---全部
    All = 2,

}
---活动排行榜组件类型
LuaEnumActivityRankComponentType = {
    None = 0,
    ---玩家名字
    PlayerName = 1,
    ---BOSS伤害
    BossHurt = 2,
    ---BOSS斩杀
    KillBoss = 3,
    ---击杀玩家数
    KillPlayer = 4,
    ---评分
    Score = 5,
    ---点赞
    Like = 6,
    ---元宝收益
    Ingots = 7,
    --- 输出
    OutputHurt = 8,
    --- 承伤
    TakeDamage = 9,
    ---治疗
    Cure = 10,
    ---战损
    BsttlrDamage = 11,
    ---战损详情按钮
    BsttlrDamageBtn = 12,
    ---奖励
    Reward = 13,
    ---低级刺客
    LowAssassin = 14,
    ---高级刺客
    SeniorAssassin = 15,
    ---阵亡
    Dead = 16,
    ---押镖距离
    DartDistance = 17,
    ---排名
    Ranking = 18,
    ---赔率
    BetRate = 19,
    ---被押注金额
    BetAmount = 20,
}

LuaEnumRewardTipsType = {
    ---普通奖励
    Normal = 1,
    ---精英悬赏
    PostReward = 2,
    ---行会首领奖励
    HangHuiShouLing = 7,
    ---熔炼奖励
    SmeltReWard = 50,
}

---luaAvatar类型
---@class LuaEnumAvatarType
LuaEnumAvatarType = {
    ---无
    None = 0,
    ---主角
    MainPlayer = 1,
    ---玩家
    Player = 2,
    ---怪物
    Monster = 3,
    ---NPC
    NPC = 4,
    ---宠物
    Pet = 5,
    ---道具
    Item = 6,
    ---守卫
    Guard = 7,
    ---触发器
    Trigger = 8,
    ---坟墓
    Grave = 9,
    ---灵兽
    Servant = 10,
    ---矿/鱼
    Mine = 11,
    ---摊位
    Booth = 12,
    ---火药桶
    GunpowderBarrel = 13,
    ---其他
    Other = 100,
}
---位置改变原因
---@class luaEnumTransReason
luaEnumTransReason = {
    ---配置传送
    DeliverConfig = 28,
    ---小地图传送
    MinMapDeliver = 32,
    ---精英任务
    Elit_Task = 41,
    ---任务
    Task = 43,
    ---千纸鹤
    PAPER_CRANE = 45,
    ---恶魔广场随机任务传送
    TASK_EMOGUANGCHANGRANDOM = 46,
    ---跨服摆摊传送
    ShareStall_CangYue = 54,
}

---灵兽修炼信息改变原因
LuaEnumServantPracticeInfoChangeReason = {
    --查看
    Look = 1,
    --修炼打开
    Open = 2,
    --修炼暂停
    Stop = 3,
    --提取
    Take = 4,
    --打开对话框更新
    dlgUpdate = 5,
    --更新等级和转生
    update = 6,
    --满了停
    Full = 7,
    --自动修炼
    Auto = 8,
    --修炼修改坐标
    Fly = 9,
    ---清除CD
    ClearCD = 10
}

---@class LuaEnumSynthesisLeftPanelType 合成左侧界面类型
LuaEnumSynthesisLeftPanelType = {
    ---角色
    Role = 1,
    ---背包
    Bag = 2,
    ---灵兽
    Servant = 3,
    ---合成列表
    SynthesisList = 4,
}

---复活类型
LuaEnumReliveType = {
    Null = 0,
    ---回城复活
    BackCityRelive = 1,
    ---原地复活
    StandRelive = 2
}

---红点类型
LuaEnumRedPointType = {
    ---合成
    Synthesis = 26,
}

---@class LuaEnumServantEquipIndex 灵兽装备位
LuaEnumServantEquipIndex = {
    ---寒芒脑
    HM_SeravntEquip_Nao = 1101,
    ---寒芒心
    HM_SeravntEquip_Xin = 1102,
    ---寒芒骨
    HM_SeravntEquip_Gu = 1103,
    ---寒芒血
    HM_SeravntEquip_Xue = 1104,
    ---寒芒项链
    HM_SeravntEquip_XiangLian = 1001,
    ---寒芒左戒指
    HM_SeravntEquip_LeftRing = 1002,
    ---寒芒右戒指
    HM_SeravntEquip_RightRing = 1012,
    ---寒芒左手镯
    HM_SeravntEquip_LeftHand = 1003,
    ---寒芒右手镯
    HM_SeravntEquip_RightHand = 1013,
    ---寒芒腰带
    HM_SeravntEquip_Belt = 1004,
    ---寒芒鞋子
    HM_SeravntEquip_Shoes = 1005,
    ---寒芒法宝
    HM_MagicWeapon = 1006,

    ---落星脑
    LX_SeravntEquip_Nao = 2101,
    ---落星心
    LX_SeravntEquip_Xin = 2102,
    ---落星骨
    LX_SeravntEquip_Gu = 2103,
    ---落星血
    LX_SeravntEquip_Xue = 2104,
    ---落星项链
    LX_SeravntEquip_XiangLian = 2001,
    ---落星左戒指
    LX_SeravntEquip_LeftRing = 2002,
    ---落星右戒指
    LX_SeravntEquip_RightRing = 2012,
    ---落星左手镯
    LX_SeravntEquip_LeftHand = 2003,
    ---落星右手镯
    LX_SeravntEquip_RightHand = 2013,
    ---落星腰带
    LX_SeravntEquip_Belt = 2004,
    ---落星鞋子
    LX_SeravntEquip_Shoes = 2005,
    ---落星法宝
    LX_MagicWeapon = 2006,

    ---天成脑
    TC_SeravntEquip_Nao = 3101,
    ---天成心
    TC_SeravntEquip_Xin = 3102,
    ---天成骨
    TC_SeravntEquip_Gu = 3103,
    ---天成血
    TC_SeravntEquip_Xue = 3104,
    ---天成项链
    TC_SeravntEquip_XiangLian = 3001,
    ---天成左戒指
    TC_SeravntEquip_LeftRing = 3002,
    ---天成右戒指
    TC_SeravntEquip_RightRing = 3012,
    ---天成左手镯
    TC_SeravntEquip_LeftHand = 3003,
    ---天成右手镯
    TC_SeravntEquip_RightHand = 3013,
    ---天成腰带
    TC_SeravntEquip_Belt = 3004,
    ---天成鞋子
    TC_SeravntEquip_Shoes = 3005,
    ---天成法宝
    TC_MagicWeapon = 3006,
}

---更好物品推送状态类型
---@class LuaEnumBetterItemHintStateType
LuaEnumBetterItemHintStateType = {
    ---不推送
    NONE = 0,
    ---推送带icon的提示
    IconHint = 1,
    ---推送纯文本的提示
    TextHint = 2,
}

---红点名
---@class LuaRedPointName
LuaRedPointName = {
    --region 合成

    ---灵兽合成寒芒
    Synthesis_HM = "Synthesis_HM",
    ---灵兽合成落星
    Synthesis_LX = "Synthesis_LX",
    ---灵兽合成天成
    Synthesis_TC = "Synthesis_TC",
    ---寒芒法宝
    Synthesis_HM_MagicWeapon = "Synthesis_HM_MagicWeapon",
    ---落星法宝
    Synthesis_LX_MagicWeapon = "Synthesis_LX_MagicWeapon",
    ---天成法宝
    Synthesis_TC_MagicWeapon = "Synthesis_TC_MagicWeapon",

    ---装备元素合成
    Synthesis_EquipElement = "Synthesis_BodyElement",
    ---武器元素合成
    Synthesis_WeaponElement = "Synthesis_WeaponElement",
    ---衣服元素合成
    Synthesis_ClothesElement = "Synthesis_ClothesElement",
    ---头盔元素合成
    Synthesis_HelmetElement = "Synthesis_HelmetElement",
    ---左手镯元素合成
    Synthesis_LeftBraceletElement = "Synthesis_LeftBraceletElement",
    ---右手镯元素合成
    Synthesis_RightBraceletElement = "Synthesis_RightBraceletElement",
    ---左戒指元素
    Synthesis_LeftRingElement = "Synthesis_LeftRingElement",
    ---右戒指元素
    Synthesis_RightRingElement = "Synthesis_RightRingElement",
    ---鞋子元素合成
    Synthesis_ShoesElement = "Synthesis_ShoesElement",
    ---项链元素合成
    Synthesis_NecklaceElement = "Synthesis_NecklaceElement",
    ---腰带元素合成
    Synthesis_BeltElement = "Synthesis_BeltElement",

    ---身上印记合成
    Synthesis_EquipSignet = "Synthesis_EquipSignet";
    ---武器印记合成
    Synthesis_WeaponSignet = "Synthesis_WeaponSignet",
    ---衣服印记合成
    Synthesis_ClothesSignet = "Synthesis_ClothesSignet",
    ---头盔印记合成
    Synthesis_HelmetSignet = "Synthesis_HelmetSignet",
    ---左手镯印记合成
    Synthesis_LeftBraceletSignet = "Synthesis_LeftBraceletSignet",
    ---右手镯印记合成
    Synthesis_RightBraceletSignet = "Synthesis_RightBraceletSignet",
    ---左戒指印记
    Synthesis_LeftRingSignet = "Synthesis_LeftRingSignet",
    ---右戒指印记
    Synthesis_RightRingSignet = "Synthesis_RightRingSignet",
    ---鞋子印记合成
    Synthesis_ShoesSignet = "Synthesis_ShoesSignet",
    ---项链印记合成
    Synthesis_NecklaceSignet = "Synthesis_NecklaceSignet",
    ---腰带印记合成
    Synthesis_BeltSignet = "Synthesis_BeltSignet",
    --endregion

    ---灵兽聚灵
    ServantGatherSoul = "ServantGatherSoul",

    --region boss面板
    ---魔之boss
    BOSS_Demon = "BOSS_Demon",
    ---终极boss
    Boss_Final = "Boss_Final",
    ---神级boss
    Boss_God = "Boss_God",
    ---个人boss
    Boss_Persional = "Boss_Persional",
    ---生肖boss
    Boss_ShengXiao = "Boss_ShengXiao",
    --endregion


    --region 竞技
    ---等级竞技
    Competition_KaiFu_DengJi = "Competition_KaiFu_DengJi",
    ---灵兽竞技
    Competition_KaiFu_LingShou = "Competition_KaiFu_LingShou",
    ---元石竞技
    Competition_KaiFu_YuanShi = "Competition_KaiFu_YuanShi",
    ---灯芯竞技
    Competition_KaiFu_DengXin = "Competition_KaiFu_DengXin",
    ---勋章竞技
    Competition_KaiFu_XunZhang = "Competition_KaiFu_XunZhang",
    ---星级竞技
    Competition_KaiFu_XingJi = "Competition_KaiFu_XingJi",
    ---战勋竞技
    Competition_KaiFu_ZhanXun = "Competition_KaiFu_ZhanXun",
    --endregion

    --region 灵兽修炼
    ServantPractice_HM = "ServantPractice_HM",
    ServantPractice_LX = "ServantPractice_LX",
    ServantPractice_TC = "ServantPractice_TC",
    --endregion
    ---联盟投票
    LeagueVote = "LeagueVote",

    --region 法宝

    MagicEquip_All = "MagicEquip_All",
    ---生肖法宝
    MagicEquip_SX = "MagicEquip_SX",
    ---灵魂法宝
    MagicEquip_Soul = "MagicEquip_Soul",
    ---力量法宝
    MagicEquip_Power = "MagicEquip_Power",
    ---心灵法宝
    MagicEquip_XL = "MagicEquip_XL",
    ---仙器法宝
    MagicEquip_XQ = "MagicEquip_XQ",

    --endregion

    --region 血继

    BloodSuit_All = "BloodSuit_All",
    ---血继 妖装备套装
    BloodSuit_Yao = "BloodSuit_Yao",
    ---血继 仙装备套装
    BloodSuit_Xian = "BloodSuit_Xian",
    ---血继 魔装备套装
    BloodSuit_Mo = "BloodSuit_Mo",
    ---血继 灵装备套装
    BloodSuit_Ling = "BloodSuit_Ling",
    ---血继 神装备套装
    BloodSuit_Shen = "BloodSuit_Shen",

    ---血继装备位1
    BloodSuit_egg1 = "BloodSuit_egg1",
    ---血继装备位2
    BloodSuit_egg2 = "BloodSuit_egg2",
    ---血继装备位3
    BloodSuit_egg3 = "BloodSuit_egg3",
    ---血继装备位4
    BloodSuit_egg4 = "BloodSuit_egg4",
    ---血继装备位5
    BloodSuit_egg5 = "BloodSuit_egg5",
    ---血继装备位6
    BloodSuit_egg6 = "BloodSuit_egg6",
    ---血继装备位7
    BloodSuit_egg7 = "BloodSuit_egg7",
    ---血继装备位8
    BloodSuit_egg8 = "BloodSuit_egg8",

    ---血继肉身装备位1
    BloodSuit_body1 = "BloodSuit_body1",
    ---血继肉身装备位2
    BloodSuit_body2 = "BloodSuit_body2",
    ---血继肉身装备位3
    BloodSuit_body3 = "BloodSuit_body3",
    ---血继肉身装备位4
    BloodSuit_body4 = "BloodSuit_body4",

    --endregion

    --region 血炼
    BloodSuitSmelt_All = "BloodSuitSmelt_All",
    ---血继 妖装备套装
    BloodSuitSmelt_Yao = "BloodSuitSmelt_Yao",
    ---血继 仙装备套装
    BloodSuitSmelt_Xian = "BloodSuitSmelt_Xian",
    ---血继 魔装备套装
    BloodSuitSmelt_Mo = "BloodSuitSmelt_Mo",
    ---血继 灵装备套装
    BloodSuitSmelt_Ling = "BloodSuitSmelt_Ling",
    ---血继 神装备套装
    BloodSuitSmelt_Shen = "BloodSuitSmelt_Shen",
    --endregion

    --region 神炼红点
    ForgeGodPowerSmelt_All = "ForgeGodPowerSmelt_All",
    --endregion

    --region 活动红点
    ---跨服
    SpecialActivity_KuaFu = "SpecialActivity_KuaFu",
    ---限时
    SpecialActivity_Limit = "SpecialActivity_Limit",
    --endregion

    --region 灵兽任务
    LsMission_All = "LsMission_All",
    --endregion

    --region 封号
    SealMark = "SealMark",
    -- 封号天赋
    TitleTalentMark = "TitleTalentMark",
    --endregion

    --region 潜能
    Potential = "Potential",
    --endregion

    --region 阵法
    ZhenFa = "ZhenFa",
    --endregion

    --region 白日门活动红点
    ---白日门活动主界面红点,点一次就没了
    BaiRiMenActivity_MainPanelRedPoint = "BaiRiMenActivity_MainPanelRedPoint",
    --endregion

    --region 升星红点
    Strength_All = "Strength_All",
    --endregion

    --region 维修红点
    ---灵兽维修
    Repair_Servant = "Repair_Servant",
    --endregion

    --region 装备专精红点
    ---装备专精红点
    Equip_Proficient = "Equip_Proficient",
    --endregion

    --region 投资红点
    ---投资总红点
    Investment_All = "Investment_All",
    ---投资红点1
    Investment_One = "Investment_One",
    ---投资红点2
    Investment_Two = "Investment_Two",
    --endregion

    --region 官阶红点
    OfficialState = "OfficialState",
    --endregion

    --region 炼制大师推送红点
    ---炼制灵兽修为推送红点
    LianZhi_LingShou = "LianZhi_LingShou",
    ---炼制角色修为推送红点
    LianZhi_XiuWei = "LianZhi_XiuWei",
    ---炼制功勋
    LianZhi_GongXun = "LianZhi_GongXun",
    --endregion

    --region 骑术技能红点
    QiShuSkill = "QiShuSkill",
    --endregion

    --region 藏品
    Collection = "Collection",
    --endregion

    --region 累充（领奖）
    AccumulatedRecharge = "AccumulatedRecharge",
    --endregion

    --region 外观红点
    NewAppearance = "NewAppearance",
    --endregion

    --region 左侧外观页签红点
    Outlook = "Outlook",
    --endregion

    --region 潜能投资
    PotentialInvestRedPoint = "PotentialInvestRedPoint",
    --endregion

    --region 会员面板
    ---会员段位奖励红点
    MemberPanelRewardRedPoint = "MemberPanelRewardRedPoint",
    --endregion

    --region 怪物悬赏
    MonsterArrest = "MonsterArrest",
    --endregion

    --region 仙装
    XianZhuangPush = "XianZhuang",
    --endregion

    ---主角转生红点
    LuaRoleReinRedPoint = "LuaRoleReinRedPoint",

    ---系统预告
    SystemPreview = "SystemPreview",

    ---经验兑换
    ExpExchange = "ExpExchange",

    --region 鉴定
    JianDingRedPoint = "JianDingRedPoint",
    --endregion

    --region 淬炼
    ForgeQuenchAllRedPoint = "ForgeQuenchRedPoint_All",
    --endregion

    --region 连充
    LianChongRedPoint = "LianChongRedPoint",
    --endregion

    --region 重铸
    Recast_DengZuo = "Recast_DengZuo",
    Recast_YuPei = "Recast_YuPei",
    Recast_MiBao = "Recast_MiBao",
    Recast_BaoShi = "Recast_BaoShi",
    Recast_LingHunKeYin = "Recast_LingHunKeYin",
    Recast_MianSha = "Recast_MianSha",
    --endregion
}

---挑战Boss操作类型
LuaEnumBossOperationType = {
    ---寻找目标
    FindTarget = 1,
    ---生成气泡
    Bubble = 2,
    ---跳转面板
    JumpPanel = 3,
    ---寻路到某点
    Deliver = 4,
    ---寻找目标寻找传送员
    FindTargetTeleporter = 5,
    ---直接前往deliverID所对应的地点
    GoToDeliverDirectly = 6,
    ---副本类型（直接传送到副本内部）
    EnterDuplicate = 7,
}

---魔之boss检测的装备类型
LuaEnumMagicBossCheckEquipType = {
    ---无
    None = 0,
    ---装备转生等级
    Equip = 1,
    ---灵兽
    Servant = 2,
}

---魔之boss刷新次数类型
LuaEnumMagicBossTimeType = {
    ---击杀次数
    KillNum = 1,
    ---求助次数
    HelpNum = 2,
}

---魔之boss求助失败类型
LuaEnumMagicBossReqHelpDefaultType = {
    ---冷却中
    InTheCooling = 1,
}

---AuctionItem部位类型
---@class LuaEnumAuctionItemPartType
LuaEnumAuctionItemPartType = {
    ---空格
    Space = -1,
    ---无
    None = 0,
    ---大按钮
    BigButton = 1,
    ---滑动条
    Slider = 2,
    ---数量增减
    NumberAddMinus = 3,
    ---货币输入框
    CoinInput = 4,
    ---双按钮
    DoubleButtons = 5,
    ---双标题按钮
    DoubleTitleBtns = 6,
    ---选项框
    Toggle = 7,
}

---行会熔炼物品变化类型（服务器类型）
LuaEnumUnionSmeltItemChangeType = {
    ---增加
    Add = 1,
    ---移除
    Remove = 2,
}

---可领取魔之boss奖励类型
LuaEnumCanGetMagicBossAwardType = {
    ---不可领取
    None = 0,
    ---在范围内
    WithinRange = 1,
    ---不在范围内
    NotWithinRange = 2,
}

---魔之boss对于主角而言的状态类型
LuaEnumMagicBossAttackTypeForMainPlayerType = {
    None = 0,
    ---正常
    Normal = 1,
    ---boss战斗(归属是自己)
    BossAttack_Mine = 2,
    ---boss战斗(归属不是自己)
    BossAttack_OtherPlayer = 3,
    ---boss死亡(归属是自己)
    BossDead_Mine = 4,
    ---boss死亡(归属是同帮会)
    BossDead_SameUnion = 5,
    ---boss死亡（归属不是同帮会）
    BossDead_DifferentUnion = 6,
}

---魔之boss掉落类型
---@class LuaEnumMagicBossDropType
LuaEnumMagicBossDropType = {
    None = 0,
    ---掉装备的魔之boss
    DropEquip = 1,
    ---掉首饰的魔之boss
    DropJewelry = 2,
    ---掉落技能书的魔之boss
    DropSkillBook = 3,
}

---合成条件匹配逻辑类型
---@class LuaEnumSynthesisConditionMatchType
LuaEnumSynthesisConditionMatchType = {
    ---多种条件满足一条
    OR = 1,
    ---多种条件全部满足
    AND = 2,
}

---合成条件类型
---@class LuaEnumSynthesisConditionType
LuaEnumSynthesisConditionType = {
    ---检测玩家等级是否处于等级区间段
    PlayerLevel = 1,
    ---检测玩家转生等级是否处于区间段
    PlayerReinLevel = 2,
    ---任意一只灵兽等级处于该区间
    SomeServantLevel = 3,
    ---任意一只灵兽转生等级处于该区间
    SomeServantReinLevel = 4,
    ---是否有合成的主材料
    HasMainMaterial = 5,
    ---开服天数
    OpenServerDay = 6,
    ---偏职业 0;表示所有职业 1:战士 2:法师 3:道士
    NearOccupation = 7,
    ---玩家性别 0表示所有性别  1:Man 2:WoMan
    MainPlayerLevelSex = 8,
    ---解锁寒芒灵兽
    UnLock_HMServant = 9,
    ---解锁落星灵兽
    UnLock_LXServant = 10,
    ---解锁天成灵兽
    UnLock_TCServant = 11,
    ---是否检测优先级显示，优先级高的则不显示优先级低的
    CheckShowPriority = 12,
}

---合成条件类型
---@class LuaEnumSynthesisMaterialExitPos
LuaEnumSynthesisMaterialExitPos = {
    ---主材料如果在人物身上
    PlayerBodyEquip = 1,
    ---主材料如果在灵兽位上
    PlayerServant = 2,
    ---主材料如果在灵兽装备位上
    PlayerServantEquip = 3,
    ---主材料如果在灵兽装备或者人物装备位上
    PlayerServantRoleEquip = 4,
}

---闯天关左侧星级类型
---@class LuaEnumTowerLeftPanelStarType
LuaEnumTowerLeftPanelStarType = {
    ---是否通关
    Boss = 1,
    ---血量剩余
    HP = 2,
    ---击杀所用时间
    Time = 3,
}

---物品使用回复参数
---@class LuaEnumUseItemParam
LuaEnumUseItemParam = {
    ---可以使用
    CanUse = 1,
    ---使用等级不足
    UseLvNotEnough = 2,
    ---使用转生等级不足
    UseReinLvNotEnough = 3,
    ---没有配置item表
    NoConfigItem = 4,
    ---没有主角信息
    NoMainPlayerInfo = 5,
    ---法宝套装类型未解锁
    MagicEquipSuitTypeLocked = 6,
    ---法阵装备位未解锁
    FaZhenEquipIndexIsLock = 7,
    ---阵法装备配置不满足
    FaZhenConfigDiscontent = 8,
}

---物品表useCondition类型
---@class LuaEnumUseConditionType
LuaEnumUseConditionType = {
    ---且
    And = 0,
    ---或
    Or = 1,
}

---装备副类型
---@class LuaEnumEquipSubType
LuaEnumEquipSubType = {
    ---所有,仅用于工具等
    All = -1,
    --- <summary>武器</summary>
    Equip_wuqi = 1,
    --- <summary>头盔</summary>
    Equip_toukui = 2,
    ---<summary>衣服</summary>
    Equip_yifu = 3,
    --- <summary>项链</summary>
    Equip_xianglian = 4,
    --- <summary>手镯</summary>
    Equip_shouzhuo = 5,
    --- <summary>戒指</summary>
    Equip_jiezhi = 6,
    --- <summary>腰带</summary>
    Equip_yaodai = 7,
    --- <summary>鞋子</summary>
    Equip_xiezi = 8,
    --- <summary>护肩</summary>
    Equip_hujian = 9,
    ---<summary>面甲</summary>
    Equip_mianjia = 10,
    --- <summary>护膝</summary>
    Equip_huxi = 11,
    --- <summary>吊坠</summary>
    Equip_diaozhui = 12,
    --- <summary>赤焰灯</summary>
    Equip_chiyandeng = 13,
    --- <summary>赤焰灯芯</summary>
    Equip_chiyandengxin = 14,
    ---<summary>魂玉</summary>
    Equip_hunyu = 15,
    ---<summary>生命精魄</summary>
    Equip_shengmingjingpo = 16,
    --- <summary>宝石</summary>
    Equip_gem = 17,
    --- <summary>元灵秘宝</summary>
    Equip_yuanlingmibao = 18,
    --- <summary>进攻之源</summary>
    Equip_jingongzhiyuan = 19,
    --- <summary>守护之源</summary>
    Equip_shouhuzhiyuan = 20,
    --- <summary>宝石手套</summary>
    Equip_baoshishoutao = 21,
    --- <summary>勋章 </summary>
    Equip_xunzhang = 22,
    ---<summary> 双倍勋章</summary>
    Equip_doublexunzhang = 23,
    --- <summary>面巾 </summary>
    Equip_face = 24,
    --- <summary>虎符 </summary>
    Equip_hufu = 26,
    --- <summary>官印 </summary>
    Equip_seal = 27,
    --- <summary>马牌 </summary>
    Equip_maPai = 28,
    --- <summary>暗器 </summary>
    Equip_AnQi = 29,

    ---主印
    MainSignet = 30,
    ---辅印
    SubSignet = 31,

    --- <summary> 特戒 </summary>
    SpecialRing = 32,
    --- <summary> 阵法装备1 </summary>
    Equip_zhenfa_1 = 34,
    --- <summary> 阵法装备2 </summary>
    Equip_zhenfa_2 = 35,
    --- <summary> 阵法装备3 </summary>
    Equip_zhenfa_3 = 36,
    --- <summary> 阵法装备4 </summary>
    Equip_zhenfa_4 = 37,
    --- <summary> 盾牌 </summary>
    Equip_Shield = 39,
    --- <summary> 斗笠 </summary>
    Equip_Hat = 40,
    --- <summary>寒芒项链 </summary>
    Equip_HS_HangMangXiangLian = 81,
    --- <summary> 寒芒戒指 </summary>
    Equip_HS_HangMangJieZhi = 82,
    ---<summary>寒芒手镯</summary>
    Equip_HS_HangMangShouZhuo = 83,
    ---<summary>寒芒腰带 </summary>
    Equip_HS_HanMangBelt = 84,
    ---<summary> 寒芒鞋</summary>
    Equip_HS_HanMangShoes = 85,
    ---<summary>寒芒法宝 </summary>
    Equip_HS_HanMang_MagicWeapon = 86,
    --- <summary>落星项链</summary>
    Equip_HS_LuoXingXiangLian = 91,
    --- <summary> 落星戒指 </summary>
    Equip_HS_LuoXingJieZhi = 92,
    --- <summary>落星手镯</summary>
    Equip_HS_LuoXingShouZhuo = 93,
    ---<summary> 落星腰带</summary>
    Equip_HS_LuoXingBelt = 94,
    --- <summary>落星鞋子</summary>
    Equip_HS_LuoXingShoes = 95,
    --- <summary> 落星法宝 </summary>
    Equip_HS_LuoXing_MagicWeapon = 96,
    --- <summary>天成项链</summary>
    Equip_HS_TianChengXiangLian = 101,
    --- <summary>天成戒指 </summary>
    Equip_HS_TianChengJieZhi = 102,
    --- <summary>天成手镯 </summary>
    Equip_HS_TianChengShouZhuo = 103,
    ---<summary>天成腰带</summary>
    Equip_HS_TianChengBelt = 104,
    --- <summary>天成鞋子</summary>
    Equip_HS_TianChengShoes = 105,
    ---<summary>天成法宝</summary>
    Equip_HS_TianCheng_MagicWeapon = 106,
    --- <summary> 寒芒脑</summary>
    Equip_HS_HanMangNao = 121,
    --- <summary> 寒芒心</summary>
    Equip_HS_HanMangXin = 122,
    --- <summary>寒芒骨 </summary>
    Equip_HS_HanMangGu = 123,
    --- <summary>寒芒血 </summary>
    Equip_HS_HanMangXue = 124,
    --- <summary>落星脑</summary>
    Equip_HS_LuoXingNao = 131,
    --- <summary>落星心</summary>
    Equip_HS_LuoXingXin = 132,
    --- <summary> 落星骨 </summary>
    Equip_HS_LuoXingGu = 133,
    --- <summary> 落星血</summary>
    Equip_HS_LuoXingXue = 134,
    ---  <summary>天成脑 </summary>
    Equip_HS_TianChengNao = 141,
    --- <summary> 天成心 </summary>
    Equip_HS_TianChengXin = 142,
    --- <summary>天成骨</summary>
    Equip_HS_TianChengGu = 143,
    --- <summary>天成血 </summary>
    Equip_HS_TianChengXue = 144,
    --- <summary>通用脑</summary>
    Equip_HS_CommonNao = 151,
    --- <summary> 通用心 </summary>
    Equip_HS_CommonXin = 152,
    ---<summary>通用骨</summary>
    Equip_HS_CommonGu = 153,
    --- <summary> 通用血 </summary>
    Equip_HS_CommonXue = 154,
    --- <summary> 法宝 </summary>
    Equip_MagicWeapon = 160,
}

---装备的列表类型(PS: 每种装备列表类型都存在属于自己的装备面板,他们每件装备所对应的装备下标也一样不相同)
---@class LuaEquipmentListType
LuaEquipmentListType = {
    ---正常装备
    Base = 0,
    ---神力套装1
    SLSuit_JIYI = 1,
    ---神力套装2
    ShenLi_Equip2 = 2,
    ---兵鉴套装
    Sl_BingJian = 6,
}

---血继装备类型
---@class LuaEquipBloodSuitType
LuaEquipBloodSuitType = {
    ---非血继套装
    None = 0,
    ---妖级
    Yao = 1,
    ---仙级
    Xian = 2,
    ---魔级
    Mo = 3,
    ---灵级
    Ling = 4,
    ---神级
    Shen = 5
}
---血继装备位下标类型
---@class LuaEquipBloodSuitItemType
LuaEquipBloodSuitItemType = {
    ---空
    None = 0,
    ---灵兽蛋1号位
    egg1 = 1,
    ---灵兽蛋2号位
    egg2 = 2,
    ---灵兽蛋3号位
    egg3 = 3,
    ---灵兽蛋4号位
    egg4 = 4,
    ---灵兽蛋5号位
    egg5 = 5,
    ---灵兽蛋6号位
    egg6 = 6,
    ---灵兽蛋7号位
    egg7 = 7,
    ---灵兽蛋8号位
    egg8 = 8,
    ---肉身1号位
    body1 = 9,
    ---灵兽蛋2号位
    body2 = 10,
    ---灵兽蛋3号位
    body3 = 11,
    ---灵兽蛋4号位
    body4 = 12
}
---血继物品的子类型
---@class LuaEquipBloodSuitItemSubType
LuaEquipBloodSuitItemSubType = {
    ---灵兽蛋
    ServantEgg = 1,
    ---灵兽肉身装备
    ServantBodyEquip = 2,
}

---装备位下标(跟进不同的装备列表,会发生改表,这里只是一个基础下标值)
---@class LuaEquipmentItemType
LuaEquipmentItemType = {
    ---武器
    POS_WEAPON = 1,
    ---头盔
    POS_HEAD = 2,
    ---衣服
    POS_CLOTHES = 3,
    ---项链
    POS_NECKLACE = 4,
    ---左手镯
    POS_LEFT_HAND = 5,
    ---右手镯
    POS_RIGHT_HAND = 51,
    ---左戒指
    POS_LEFT_RING = 6,
    ---右戒指
    POS_RIGHT_RING = 61,
    ---腰带
    POS_BELT = 7,
    ---鞋子
    POS_SHOES = 8,
    ---灯
    POS_LAMP = 13,
    ---魂玉
    POS_SOULJADE = 15,
    ---元灵
    POS_RAWANIMA = 18,
    ---宝石手套
    POS_GEMGLOVE = 21,
    ---勋章
    POS_MEDAL = 22,
    ---双倍勋章
    POS_DoubleMEDAL = 23,
    ---面巾
    POS_FACE = 24,
    ---虎符
    POS_HUFU = 26,
    ---官印
    POS_SEAL = 27,
    ---马牌
    POS_MaPai = 28,
    ---暗器
    POS_AnQi = 29,

    ---主印
    MainSignet = 30,
    ---辅印
    SubSignet = 31,
    ---特戒左
    SpecialRingL = 32,
    ---特戒右
    SpecialRingR = 33,
    ---阵法装备1
    POS_ZHENFA_EQUIP_1 = 34,
    ---阵法装备2
    POS_ZHENFA_EQUIP_2 = 35,
    ---阵法装备3
    POS_ZHENFA_EQUIP_3 = 36,
    ---阵法装备4
    POS_ZHENFA_EQUIP_4 = 37,
    ---左手武器
    POS_LeftWeapon = 39,
    ---斗笠
    POS_DouLi = 40,
    ---神力武器
    POS_SL_WEAPON = 301,
    ---神力头盔
    POS_SL_HEAD = 302,
    ---神力衣服
    POS_SL_CLOTHES = 303,
    ---神力项链
    POS_SL_NECKLACE = 304,
    ---神力法宝
    POS_SL_FABAO = 305,
    ---神力勋章
    POS_SL_MEDAL = 306,
    ---神力左手镯
    POS_SL_LEFT_HAND = 307,
    ---神力右手镯
    POS_SL_RIGHT_HAND = 357,
    ---神力左戒子
    POS_SL_LEFT_RING = 308,
    ---神力右戒子
    POS_SL_RIGHT_RING = 358,

    ---法宝装备1
    POS_MagicIndexOne = 401,
    ---法宝装备2
    POS_MagicIndexTwo = 402,
    ---法宝装备3
    POS_MagicIndexThree = 403,
    ---法宝装备4
    POS_MagicIndexFour = 404,
    ---法宝装备5
    POS_MagicIndexFive = 405,
    ---法宝装备6
    POS_MagicIndexSix = 406,
    ---法宝装备7
    POS_MagicIndexSeven = 407,
    ---法宝装备8
    POS_MagicIndexEight = 408,
    ---法宝装备9
    POS_MagicIndexNine = 409,
    ---法宝装备10
    POS_MagicIndexTen = 410,
    ---法宝装备11
    POS_MagicIndexEleven = 411,
    ---法宝装备12
    POS_MagicIndexTwelve = 412,

    ---婚戒
    POS_MARRY_RING = 520,

}

---物品信息面板刷新类型
LuaEnumItemInfoPanelRefreshType = {
    ---面板数量相同刷新
    SamePanelNumRefresh = 1,
    ---全部刷新
    AllRefresh = 2,
}

---交易行选中道具原因
---@class LuaEnumAuctionTradePanelShowReason
LuaEnumAuctionTradePanelShowReason = {
    ---猜你喜欢购买推送
    GuessLikeBuyPush = 1,
    ---交易界面购买推送
    TradePush = 2,
    ---装备行推送
    SmeltPush = 3,
}

---交易推送类型
LuaEnumAuctionPushType = {
    ---上架猜你喜欢购买推送
    GuessLikePush = 1,
    ---玩家上架推送
    PlayerTradePush = 2,
    ---行会竞拍推送
    AuctionUnionPush = 3
}

---物品信息面板页签类型
---@class LuaEnumItemInfoPanelPageType
LuaEnumItemInfoPanelPageType = {
    ---角色
    Role = 0,
    ---寒芒
    Servant_HM = 1,
    ---落星
    Servant_LX = 2,
    ---天成
    Servant_TC = 3,
}

---合成中使用材料逻辑类型
---@class LuaEnumSynthesisUseMaterialLogicType
LuaEnumSynthesisUseMaterialLogicType = {
    ---全部取用
    All = 0,
    ---只算背包
    OnlyBag = 1,
    ---角色与背包
    RoleAndBag = 2,
    ---寒芒灵兽与背包
    HMAndBag = 3,
    ---落星灵兽与背包
    LXAndBag = 4,
    ---天成灵兽与背包
    TCAndBag = 5,
}

---等级描述类型
---@class LuaEnumLevelDesType
LuaEnumLevelDesType = {
    ---装备
    Equip = 1,
}

---联盟类型（TABLE.cfg_league id）
---@class LuaEnumLeagueType
LuaEnumLeagueType = {
    None = 0,
    ---勇气
    Courage = 1,
    ---无畏
    Fearless = 2,
    ---荣耀
    Glory = 3,
    ---自由
    Free = 4,
}

---联盟投票组件类型
---@class LuaEnumLeagueComponentType
LuaEnumLeagueComponentType = {
    ---行会基础信息 （行会 渠道 服区）
    UnionInfo = 1,
    ---繁荣度
    prosperity = 2,
    ---人数
    pepoleCount = 3,
    ---荣耀联盟人数
    GloryCount = 4,
    ---自由联盟人数
    FreeCount = 5,
    ---勇气联盟人数
    CourageCount = 6,
    ---无畏联盟人数
    FearlessCount = 7
}

---联盟通用请求响应消息类型
---@class luaEnumLeagueInfoMsgType
luaEnumLeagueInfoMsgType = {
    ---联盟预选截止时间
    LeaguePreselectEndTime = 235,
    ---当天联盟投票类型
    ThatDayLeagueVoteType = 236,
}

---联服开始提示类型
---@class luaEnumLianFuStartNoticeType
luaEnumLianFuStartNoticeType = {
    ---二次确认
    SecondConfirm = 1,
    ---头顶倒计时
    HeadCountDown = 2,
}

---联服结束时间类型
---@class LuaEnumLianFuEndTimeType
LuaEnumLianFuEndTimeType = {
    ---联服开始时间
    LianFuStartTime = 1,
}

---注册的时间结束回调
---@class LuaRegisterTimeFinishEvent
LuaRegisterTimeFinishEvent = {
    None = 1,
    ---跨服开始倒计时
    KuaFuStartCountDown = 2,
    KuaFuStartCountDown_One = 2001,
    KuaFuStartCountDown_Two = 2002,
    KuaFuStartCountDown_Three = 2003,
    ---联盟投票开始事件
    LeagueVoteBegin = 3,
    ---联盟投票结束事件
    LeagueVoteEnd = 4,

    ---历法刷新
    CalendarRefresh = 1001,
}

---联盟职位类型
---@class LuaEnumLianMengPost
LuaEnumLianMengPost = {
    ---盟主
    MengZhu = 1,
    ---副盟主LuaEnumMagicEquipSuitType
    FuMengZhu = 2,
    ---成员
    ChengYuan = 3,
}

---左侧主任务栏排序index,越大UI上排序越靠上
---@class LuaEnumLeftMainMissionSortIndex
LuaEnumLeftMainMissionSortIndex = {
    ---空index,最小值应大于它才有效,小于等于None时表示该行不显示了
    None = -1000000,
    ---灵魂任务
    LingHunRenWu = -30,
    ---我要元宝
    WoYaoYuanBao = -20,
    ---我要经验
    WoYaoJingYan = -15,
    ---挂机地图
    GuaJiMap = -10,
    ---个人镖车
    PersonDartCar = 0,
    ---日活
    DailyTask = 81,
    ---日活正在进行中
    DailyTaskIsInProgress = 82,
    ---日活高等级状态
    DailyTaskUpperState = 80,
    ---灵魂任务
    LingHunRenWu = 90,
    ---圣域
    ShengYu = 99,
    ---烟花
    YanHua = 100,
    ---闯天关
    CrawlTower = 110,
    ---兵鉴
    WeaponBook = 1000,
    ---支线任务
    SecondTask = 800,
    ---低优先级主线任务
    LowPriorityMainTask = 899,
    ---悬赏
    Reward = 920,
    ---Boss任务
    BossTask = 949,
    ---精英任务
    EliteTask = 950,
    ---怪物任务
    MonsterTask = 980,
    ---挑战boss进行中
    ChallengeBoss = 985,
    ---挑战boss完成状态
    ChallengeBossFinish = 985,
    ---挑战boss接取任务
    ChallengeBossReceive = 985,
    ---主线任务
    MainTask = 2999,
    ---高优先级怪物任务(低等级时,怪物任务优先于主线任务)
    HighPriorityMonsterTask = 1200,
    --[[****************************]]
    ---个人镖车完成
    PersonDartCarAccomplish = 3000,
    ---支线任务完成
    SecondTaskAccomplish = 3800,
    ---低优先级主线任务完成
    LowPriorityMainTaskAccomplish = 3899,
    ---Boss任务完成
    BossTaskAccomplish = 3949,
    ---精英任务完成
    EliteTaskAccomplish = 3950,
    ---怪物任务完成
    MonsterTaskAccomplish = 3960,
    ---主线任务完成
    MainTaskAccomplish = 4000,
    ---高优先级怪物任务完成(低等级时,怪物任务优先于主线任务)
    HighPriorityMonsterTaskAccomplish = 4200,
}

---@class LuaEnumCommonCountType
LuaEnumCommonCountType = {
    ---联盟投票类型
    LeagueVoteCount = 238,
    ---神力激活
    SLSuitActive = 239
}

---打开拍卖行内摆摊面板来源类型
LuaEnumOpenAuctionStallPanelType = {
    ---自己的摊位
    SelfStall = 1,
}

---@class LuaEnumBloodSuitSmeltType 血继熔炼类型
LuaEnumBloodSuitSmeltType = {
    ---血继
    BloodSuit = 1,
    ---背包
    Bag = 2,
}

---@class LuaEnumMagicEquipSuitType 法宝套装类型
LuaEnumMagicEquipSuitType = {
    ---生肖
    ShengXiao = 1,
    ---灵魂
    LingHun = 2,
    ---力量
    LiLiang = 3,
    ---心灵
    XinLing = 4,
    ---仙器
    XianQi = 5,
}
---@class LuaEnumShieldAndHatEquipSuitType 盾牌斗笠套装类型
LuaEnumShieldAndHatEquipSuitType = {
    ---正常的盾牌斗笠套装类型
    Normal = 1,
}

---@class LuaEnumGemEquipSuitType 宝物套装类型
LuaEnumGemEquipSuitType = {
    ---正常的宝物套装类型
    Normal = 1,
}

---@class LuaEnumGemEquipType 宝物类型
LuaEnumGemEquipType = {
    ---灯芯
    DengXin = 1,
    ---进攻之源
    JinGongZhiYuan = 2,
    ---守护之源
    ShouHuZhiYuan = 3,
    ---宝石
    BaoShi = 4,
    ---生命精魄
    ShengMingJingPo = 5
}

---@class LuaEnumMagicEquipChangeActionType 法宝装备变化行为类型
LuaEnumMagicEquipChangeActionType = {
    ---无
    Null = 0,
    ---穿戴
    Add = 1,
    ---卸下
    Remove = 2,
}

---@class LuaEnumFinalBossType 终极boss类型
LuaEnumFinalBossType = {
    ---远古Boss
    AncientBoss = 1,
    ---神级Boss
    MythBoss = 2,
    ---仙装boss
    XianZhuangBoss = 3,
    ---神器boss
    ShengQiBoss = 4,
    ---灵魂Boss
    LingHunBoss = 5,
    ---封号Boss
    FengHaoBoss = 6
}

---使用任务boss列表模板来源
---@class LuaEnumUseUIEliteMissionTemplateSource
LuaEnumUseUIEliteMissionTemplateSource = {
    ---宗师任务面板
    SpecialMission = 1,
    ---Boss技能面板
    BossSkillTips = 2,
}

---道具的使用结果
---@class LuaItemCanUseResult
LuaItemCanUseResult = {
    ---不可使用
    None = 0,
    ---可以使用
    CanUse = 1,
    ---使用等级不足
    UseLvNotEnough = 2,
    ---使用转生等级不足
    UseReinLvNotEnough = 3,
    ---没有配置item表
    NoConfigItem = 4,
    ---没有主角信息
    NoMainPlayerInfo = 5,
    ---没有灵兽信息
    NoServantInfo = 6,
    ---没有穿戴前置神力法宝
    NoEquipPrepositionSLFaBao = 7,
    ---穿戴的前置神力法宝等级不足
    EquipSLFaBaoLevelNotEnough = 8,
    ---性别不符
    Sex = 9,
}

---灵兽任务状态
---@class LuaLsMissionStateEnum
LuaLsMissionStateEnum = {
    --无状态
    None = 0,
    --可领取
    CanGet = 1,
    --不可领取
    NotGet = 2,
    --已领取
    Geted = 3,
}

---灵兽任务章节状态
---@class LuaLsMissionStcStateEnum
LuaLsMissionSecStateEnum = {
    --未解锁
    Lock = 0,
    --解锁
    UnLock = 1,
    --可领取
    CanGet = 2,
    --已领取
    Geted = 3,
}

---道具的存放位置(各种炼化/合成消耗的材料都可以使用)
---@class LuaItemSavePos
LuaItemSavePos = {
    ---背包
    Bag = 1,
    ---人物装备(包含普通装备以及神力装备)
    RoleEquip = 2,
    ---人物血继
    RoleXJ = 3,
    ---人物灵兽位
    RoleServant = 4,
    ---灵兽位-寒芒
    ServantEquip_HM = 6,
    ---灵兽位-落星
    ServantEquip_LX = 7,
    ---灵兽位-天成
    ServantEquip_TC = 8,
    ---元素
    Elements = 9,
    ---印记
    Imprint = 10,
    ---法宝
    MagicWeapon = 11,
}

---@class LuaEnumBaiRiMenActivityType
LuaEnumBaiRiMenActivityType = {
    ---圣物
    ShengWu = 1,
    ---封赏
    FengShang = 2,
    ---猎魔
    LieMo = 3,
    ---货运
    HuoYun = 4,
    ---联服
    LianFu = 5,
    ---闯天关
    ChuangTianGuan = 6,
    ---苍月岛
    CangYue = 7,
}

---@class LuaEnumMiniMapExtraDepth
LuaEnumMiniMapExtraDepth = {
    ---C#中层级___主角点特效层级
    layerIndex_mainPlayerEffect = 1215,
    ---C#中层级___主角点层级
    layerIndex_mainPlayer = 1205,

    ---C#中层级___主角寻路终点层级
    layerIndex_pathFindEndPoint = 195,
    ---C#中层级___寻路点层级
    layerIndex_pathFindingPoint = 185,
    ---C#中层级___其他玩家层级
    layerIndex_otherPlayer = 175,
    ---C#中层级___个人押镖
    layerIndex_personbiaoChe = 165,
    ---C#中层级___镖车
    layerIndex_biaoChe = 155,
    ---白日门猎魔的boss
    BrmActHuntBoss = 152,
    ---BOSS中的水晶
    ShuiJing = 148,
    ---C#中层级___采集点
    layerIndex_gatherPoint = 145,
    ---C#中层级___boss出生点
    layerIndex_bossBorn = 135,
    ---C#中层级___boss层级
    layerIndex_boss = 125,
    ---C#中层级___极品怪物层级
    layerIndex_excellentMonster = 115,
    ---C#中层级___精英怪物层级
    layerIndex_eliteMonster = 105,
    ---C#中层级___小怪层级
    layerIndex_littleMonster = 95,
    ---C#中层级___墓碑层级
    layerIndex_tombstone = 85,
    ---C#中层级___npc层级
    layerIndex_npc = 75,
    ---C#中层级___传送阵层级
    layerIndex_teleport = 65,
}

---@class LuaEnumMiniMapExtraType
LuaEnumMiniMapExtraType = {
    NoShow = 0,
    NormalMapOnly = 1,
    BossMapOnly = 2,
    NormalAndBossMap = 3,
}

---@class LuaEnumBaiRiMenDartCarDataChangeType 白日门镖车数据变更类型
LuaEnumBaiRiMenDartCarDataChangeType = {
    All = 1,
    Hp = 2,
    Position = 3,
    MainPlayerInfo = 4,
}

---@class LuaEnumCallMagicBossRedPointReason
LuaEnumCallMagicBossRedPointReason = {
    EnterGame = 1,
}

---@class LuaEnumRemainTimeType
LuaEnumRemainTimeType = {
    ---单个类型boss击杀次数恢复剩余时间
    SingleTypeRecoverKillNumRemainTime = 1,
    ---总击杀次数恢复时间
    TotalKillNumRecoverRemainTime = 2,
}

---@class LuaEnumBossPanelSubtypePageGrayLogicType boss面板子页签置逻辑类型
LuaEnumBossPanelSubtypePageGrayLogicType = {
    Normal = 1,
    ByGrayConditionList = 2,
}

---@class LuaEnumRecommendEquippedAvatarType 推荐装备的对象的类型
LuaEnumRecommendEquippedAvatarType = {
    MainPlayer = 0,
    Servant_HM = 1,
    Servant_LX = 2,
    Servant_TC = 3,
}

---@class LuaEnumCalendarItemType 历法的信息类型
LuaEnumCalendarItemType = {
    ---正常的活动
    NormalActivity = 1

}

---@class LuaEnumServantEquipIndexType 灵兽装备位类型
LuaEnumServantEquipIndexType = {
    ---法宝装备
    MagicEquip = 6,
}

---@class LuaEnumAgainRefineType 洗炼界面类型
LuaEnumAgainRefineType = {
    ---魂装
    Soul = 1,
    ---背包
    Bag = 2,
}

---@class LuaEnumCarnivalEventId 狂欢派对eventID
LuaEnumCarnivalEventId = {
    ---活动
    Activity = 7,
    ---积分
    Score = 12,
}

---@class LuaEnumFinishState 任务完成状态
LuaEnumFinishState = {
    ---可领
    CanReceive = 1,
    ---未完成
    UnFinish = 2,
    ---已完成
    Finish = 3,
}

---@class LuaEnumRewardState 分级奖励状态
LuaEnumRewardState = {
    ---未领
    UnReward = 0,
    ---已领普通
    Normal = 1,
    ---已领高级
    Higher = 2,
}

---@class LuaEnumOfficialPositionLastOperationReason 官位上一次操作原因
LuaEnumOfficialPositionLastOperationReason = {
    ---初始化
    Init = 1,
    ---提升官位
    UpOfficialPosition = 2,
    ---激活虎符
    ActiveHuFu = 3,
    ---取消虎符
    UnActiveHuFu = 4,
}

---@class LuaEnumBuffSourceType buff来源
LuaEnumBuffSourceType = {
    ---服务器buff
    ServerBuff = 1,
    ---客户端buff
    ClientBuff = 2,
}

---@class LuaEnumBagPanelExpandType 背包界面扩展类型,新增一个类型需要在UIBagPanel中注册该类型对应的子物体
LuaEnumBagPanelExpandType = {
    Recycle = 1,
    Collection = 2,
}

---@class LuaSpecailActivityRewardState 限时活动奖励状态
LuaSpecailActivityRewardState = {
    ---不可领取
    NotGet = 0,
    ---已领取
    Geted = 1,
    ---可领取
    Get = 2,
}
---@class LuaDigTreasureRepayActivityState 挖宝回馈奖励状态
LuaDigTreasureRepayActivityState = {
    ---不可领取
    NOT_RECEIVE = 0,
    ---已领取
    RECEIVE = 1,
    ---可领取
    CAN_RECEIVE = 2,
}

---@class LuaEnumSoulEquipType 魂装类型
LuaEnumSoulEquipType = {
    ---魂装
    HunZhuang = 10001,
    ---仙装
    XianZhuang = 10002,
    ---神器
    ShenQi = 10003,
}

---@class LuaEnumCountDownEndType 倒计时结束类型
LuaEnumCountDownEndType = {
    ---暗殿活动结束
    DarkPalaceActivityEnd = 1,
}

---@class LuaEnumCountDownEndShowType 倒计时结束显示类型
LuaEnumCountDownEndShowType = {
    ---图片文本图片
    SpriteLabelSprite = 1,
}

---@class LuaEnumExtraAttributeType 额外属性类型
LuaEnumExtraAttributeType = {
    ---额外伤害
    ExtraDps = 1,
    ---额外比例伤害
    ExtraDpsPer = 2,
    ---暴击率
    Critical = 3,
    ---暴击伤害
    CriticalDamage = 4,
    ---伤害减免
    HurtReduce = 5,
    ---吸血
    BloodSuck = 6,
    ---吸血率
    BloodSuckPer = 7,
    ---吸血量
    BloodSuckExtra = 8,
    ---灵兽额外伤害
    PetExtraDps = 9,
    ---灵兽额外比例伤害
    PetExtraDpsPer = 10,
    ---掉落率
    DropPre = 11,
    ---最大额外伤害
    ExtraDpsMax = 12,
    ---最小额外伤害
    ExtraDpsMin = 13,
    ---最大额外减伤
    HurtReduceMax = 14,
    ---最小额外减伤
    HurtReduceMin = 15,
    ---最大物理攻击
    PhyAttackMax = 16,
    ---最小物理攻击
    PhyAttackMin = 17,
    ---最大魔法攻击
    MagicAttackMax = 18,
    ---最小魔法攻击
    MagicAttackMin = 19,
    ---最大道术攻击
    TaoAttackMax = 20,
    ---最小道术攻击
    TaoAttackMin = 21,
    ---最大物理防御
    PhyDefenceMax = 22,
    ---最小物理防御
    PhyDefenceMin = 23,
    ---最大魔法防御
    MagicDefenceMax = 24,
    ---最小魔法防御
    MagicDefenceMin = 25,
    ---生命
    Hp = 26,
    ---百分比最大物防
    PhyDefMaxPercent = 27,
    ---百分比最小物防
    PhyDefMinPercent = 28,
    ---百分比最大魔防
    MagicDefMaxPercent = 29,
    ---百分比最小魔防
    MagicDefMinPercent = 30,
    ---百分比血量
    HpPercent = 31,
    ---穿透
    PenetrationAttributes = 32,
    ---百分比伤害
    DivineEquipHurtAdd = 33,
    ---暴击抵抗
    ResistanceCritical = 34,
    ---技能伤害百分比
    DivineEquipSkillAdd = 35,
    ---通用暴击率
    CommonCritical = 36,
    ---幸运
    Luck = 37,
}

---@class LuaEnumCollectionType 藏品类型
LuaEnumCollectionType = {
    ---青铜器
    QingTongQi = 1,
    ---陶器
    TaoQi = 2,
    ---瓷器
    CiQi = 3,
    ---玉器
    YuQi = 4,
    ---金银器
    JinYinQi = 5,
    ---法器
    FaQi = 6,
}

---@class LuaEnumInlayEffectTblParamsType 镶嵌效果表杂项参数类型
LuaEnumInlayEffectTblParamsType = {
    ---杂项参数颜色
    EffectColor = 1,
}

---@class LuaEnumAttributeValueShowType 属性值显示类型
LuaEnumAttributeValueShowType = {
    ---正常数值
    Normal = 1,
    ---万分数
    AllGrades = 2,
    ---百分数
    Percent = 3,
}

---@class LuaEnumRelationAttributeShowType 关联属性显示类型
LuaEnumRelationAttributeShowType = {
    ---类性1 “ - ”
    Type1 = 1,
}

---@class LuaEnumSpecialActivityRedPointCloseType 特殊活动红点关闭类型
LuaEnumSpecialActivityRedPointCloseType = {
    ClickPage = 1,
}

---@class LuaEnumRageStateType 狂暴之力状态
LuaEnumRageStateType = {

    ---未满足条件未激活
    NotMeetCondtionAndNotActivated = 0,
    ---满足条件未激活
    MeetCondtionAndNotActivated = 1,
    ---满足条件已激活
    MeetCondtionAndActivated = 2,
    ---未满足条件已激活
    NotMeetCondtionAndActivated = 3,
}

---@class LuaEnumRecycleItemType 回收类型
LuaEnumRecycleItemType = {
    ---装备
    Equip = 1,
    ---灵兽
    Servant = 2,
    ---灵兽肉身
    ServantBody = 3,
    ---灵兽装备
    ServantEquip = 4,
    ---宝物
    Gem = 5,
    ---神石（转生凭证）
    GodStone = 6,
    ---元素
    Element = 7,
    ---印记
    Signet = 8,
    ---材料
    Material = 9,
    ---药品
    Drug = 10,
    ---藏品
    Collections = 11,
    ---仙装
    XianZhuang = 12,
    ---技能书
    SkillBook = 13,
}

---@class LuaEnumSuitType 套装类型
LuaEnumSuitType = {
    ---魂装
    SoulSuit = 10001,
    ---仙装
    XianSuit = 10002,
    ---宝物套装
    GemSuit = 20001,
}

---@class LuaEnumCityWarRankRewardType 沙巴克积分奖励类型
LuaEnumCityWarRankRewardType = {
    ---积分排行奖励
    ScoreRankReward = 1,
    ---个人积分奖励
    PersonalReward = 2,
}

---@class LuaEnumRecycleAdditionType 回收收益加成类型
LuaEnumRecycleAdditionType = {
    ---buff
    Buff = 1,
    ---会员
    Member = 2,
    ---Vip
    Vip = 3,
    ---月卡
    MonthCard = 4,
}

---@class LuaEnumRewardRankType 奖励列表类型
LuaEnumRewardRankType = {
    ---行会首领个人奖励排行
    UnionBoss_PersonRank = 1,
    ---行会首领行会奖励排行
    UnionBoss_UnionRank = 2,
}

---@class LuaEnumSynthesisItemListType 合成物品列表刷新类型
LuaEnumSynthesisItemListType = {
    ---数据变动刷新
    DataChangeRefresh = 1,
}

---@class LuaEnumMemberPanelType 会员界面页签类型
LuaEnumMemberPanelType = {
    ---青铜会员
    Member_Bronze = 1,
    ---白银会员
    Member_Silver = 2,
    ---黄金会员
    Member_Gold = 3,
    ---白金会员
    Member_Platinum = 4,
    ---钻石会员
    Member_Diamond = 5,
    ---星耀会员
    Member_StarShine = 6,
    ---王者会员
    Member_TheKing = 7,
    ---荣耀会员
    Member_Glory = 8,
    ---神圣会员
    Member_Holy = 9,
    ---永恒会员
    Member_Eternal = 11,
    ---至尊会员
    Member_Supreme = 12,
}

---扫荡类型
---@class LuaEnumClearType
LuaEnumClearType = {
    ---宗师任务
    Great_Master_Task = 1,
    ---个人boss
    PersonBoss = 2,
}

---领奖/充值主界面页签类型
---@class LuaEnumRechargeMainBookMarkType
LuaEnumRechargeMainBookMarkType = {
    ---活动页签
    Activity = 1,
    ---领奖页签
    Award = 2,
    ---充值页签
    Recharge = 3,
    ---终身限购页签
    LastRecharge = 4,
    ---连冲
    LianChong = 5,
}

---人物装备位
---@class LuaEnumPlayerEquipIndex
LuaEnumPlayerEquipIndex = {
    ---灵符
    LingFu = 34,
    ---八卦盘
    BaGuaPan = 35,
    ---灵尘
    LingChen = 36,
    ---仙珠
    XianZhu = 37,
}

---系统预告页签类型
---@class LuaEnumSystemPageType
LuaEnumSystemPageType = {
    ---系统预告
    System = 0,
    ---变强
    Stronge = 1,
}

LuaEnumRoleReinPanelType = {
    ---转生界面
    ReinPanel = 1,
    ---兑换经验界面
    ExpExchange = 2,
}

---@class LuaEnumDeliverType deliver类型 => deliverId
LuaEnumDeliverType = {
    RecycleNpc = 1093,
}

---@class LuaEnumForgeQuenchItemCheckReason
LuaEnumForgeQuenchItemCheckReason = {
    ForgeQuenchList = 1,
    Role = 2,
    Bag = 3,
}

---@class LuaEnumClientDataChange
LuaEnumClientDataChange = {
    ---资源变更
    ResourceChange = 0,
    ---强制下线
    ForcedOffline = 1
}

---@class LuaEnumRecastType 重铸类型
LuaEnumRecastType = {
    DengZuo = 13,
    YuPei = 15,
    MiBao = 18,
    BaoShi = 21,
    LingHunKeYin = 22,
    MianSha = 24,
}

---@class LuaInsuranceBigTabType
LuaInsuranceBigTabType = {
    --投保
    Insurance = 1,
    --弃保
    WaiveInsurance = 2,
}

---@class LuaInsuranceSubTabType
LuaInsuranceSubTabType = {
    --人物
    Role = 1,
    --背包
    Bag = 2,
}