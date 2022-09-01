--[[本文件为工具自动生成,禁止手动修改]]
---网络消息定义
---@class LuaEnumNetDef
LuaEnumNetDef = {}

---客户端链接服务器成功
---ToClient
LuaEnumNetDef.ConnectSuccessMessage = 101

---客户端链接服务器失败
---ToClient
LuaEnumNetDef.ConnectFailedMessage = 102

---正常断线
---ToClient
LuaEnumNetDef.DisconnectMessage = 103

--region ID:1  user
---请求登录
---user  ReqLogin
---ToServer
LuaEnumNetDef.ReqLoginMessage = 1001

---告知客户端需要创建角色
---user  ResCreateRole
---ToClient
LuaEnumNetDef.ResCreateRoleMessage = 1002

---请求创建角色
---user  ReqCreateRole
---ToServer
LuaEnumNetDef.ReqCreateRoleMessage = 1003

---请求随机名字
---user  ReqRandomName
---ToServer
LuaEnumNetDef.ReqRandomNameMessage = 1004

---告知随机名字
---user  ResRandomName
---ToClient
LuaEnumNetDef.ResRandomNameMessage = 1005

---告知客户端进入游戏
---user  ResEnterGame
---ToClient
LuaEnumNetDef.ResEnterGameMessage = 1006

---通知登录成功
---user  ResLogin
---ToClient
LuaEnumNetDef.ResLoginMessage = 1007

---客户端请求进入游戏
---ToServer
LuaEnumNetDef.ReqEnterGameMessage = 1008

---心跳请求
---user  ReqHeart
---ToServer
LuaEnumNetDef.ReqHeartMessage = 1009

---心跳返回
---user  ResHeart
---ToClient
LuaEnumNetDef.ResHeartMessage = 1010

---版本错误的返回消息
---user  ResVersionError
---ToClient
LuaEnumNetDef.ResVersionErrorMessage = 1011

---玩家改名
---user  ResRoleName
---ToServer
LuaEnumNetDef.ReqChangeRoleNameMessage = 1012

---返回玩家名称
---user  ResRoleName
---ToClient
LuaEnumNetDef.ResNewRoleNameMessage = 1013

---选择角色进入游戏
---user  ReqRoleId
---ToServer
LuaEnumNetDef.ReqChooseRoleMessage = 1014

---重连进入游戏
---user  ReqReconnect
---ToServer
LuaEnumNetDef.ReqReconnectMessage = 1015

---删除角色
---user  ReqRoleId
---ToServer
LuaEnumNetDef.ReqDelRoleMessage = 1016

---断线响应
---user  DisconnectResponse
---ToClient
LuaEnumNetDef.ResDisconnectMessage = 1017

---返回robotGM指令
---user  ResRobotGM
---ToClient
LuaEnumNetDef.ResRobotGMMessage = 1018

---返回登陆前信息
---user  ResAfterLoginInfo
---ToClient
LuaEnumNetDef.ResAfterLoginInfoMessage = 1019

---资源重载或强制下线
---user  ForceRoleReload
---ToClient
LuaEnumNetDef.ResForceRoleReloadMessage = 1020

---请求邀请码验证
---user  ReqInviteCodeVerify
---ToServer
LuaEnumNetDef.ReqInviteCodeVerifyMessage = 1021

---邀请码验证应答
---user  ResInviteCodeVerify
---ToClient
LuaEnumNetDef.ResInviteCodeVerifyMessage = 1022
--endregion

--region ID:4  activity
---请求领取活动奖励
---activity  ReqGetActivityReward
---ToServer
LuaEnumNetDef.ReqGetActivityRewardMessage = 4001

---返回领取活动奖励
---activity  ResGetActivityReward
---ToClient
LuaEnumNetDef.ResGetActivityRewardMessage = 4002

---请求打开活动面板
---activity  ReqOpenPanel
---ToServer
LuaEnumNetDef.ReqOpenPanelMessage = 4003

---返回活动面板数据
---activity  ResOpenPanel
---ToClient
LuaEnumNetDef.ResOpenPanelMessage = 4004

---返回排行榜类型活动数据
---activity  ResRankActivity
---ToClient
LuaEnumNetDef.ResRankActivityMessage = 4005

---返回每周充值累计数量
---activity  ResWeekTotalRechargeNum
---ToClient
LuaEnumNetDef.ResWeekTotalRechargeNumMessage = 4006

---返回限时任务额外奖励
---activity  ResExtraReward
---ToClient
LuaEnumNetDef.ResExtraRewardMessage = 4007

---请求领取限时任务额外奖励
---activity  ReqGetExtraReward
---ToServer
LuaEnumNetDef.ReqGetExtraRewardMessage = 4008

---请求打开炼制面板
---activity  ReqOpenLianZhi
---ToServer
LuaEnumNetDef.ReqOpenLianZhiMessage = 4009

---返回经验炼制面板
---activity  ResOpenLianZhi
---ToClient
LuaEnumNetDef.ResOpenLianZhiMessage = 4010

---请求炼制
---activity  ReqLianZhi
---ToServer
LuaEnumNetDef.ReqLianZhiMessage = 4011

---发送带目标的活动数据改变
---activity  ResActivityDataChange
---ToClient
LuaEnumNetDef.ResActivityDataChangeMessage = 4012

---发送累计充值天数
---activity  ResLeijiRechargeDays
---ToClient
LuaEnumNetDef.ResLeijiRechargeDaysMessage = 4013

---发送活动boss信息
---activity  ResSendActivityBossInfo
---ToClient
LuaEnumNetDef.ResSendActivityBossInfoMessage = 4014

---发送活动配置改变
---activity  ResActivityConfigChange
---ToClient
LuaEnumNetDef.ResActivityConfigChangeMessage = 4015

---发送财富幸运儿信息
---activity  ResLuckTreasure
---ToClient
LuaEnumNetDef.ResLuckTreasureMessage = 4016

---发送寻宝送礼信息
---activity  ResHuntGiftNum
---ToClient
LuaEnumNetDef.ResHuntGiftNumMessage = 4017

---发送消费信息
---activity  ResSpendInfo
---ToClient
LuaEnumNetDef.ResSpendInfoMessage = 4018

---发送累计登录信息
---activity  ResSendTotalLoginDay
---ToClient
LuaEnumNetDef.ResSendTotalLoginDayMessage = 4019

---发送全民boss积分
---activity  ResSendBossScore
---ToClient
LuaEnumNetDef.ResSendBossScoreMessage = 4020

---发送首杀boss信息
---activity  ResSendFirstKillBoss
---ToClient
LuaEnumNetDef.ResSendFirstKillBossMessage = 4021

---请求领取首杀boss奖励
---activity  ReqGetFirstKillBossReward
---ToServer
LuaEnumNetDef.ReqGetFirstKillBossRewardMessage = 4022

---发送限时任务信息
---activity  ResTimeLimitTaskAll
---ToClient
LuaEnumNetDef.ResTimeLimitTaskAllMessage = 4023

---更新限时任务进度
---activity  ResUpdateTimeLimitTaskProgress
---ToClient
LuaEnumNetDef.ResUpdateTimeLimitTaskProgressMessage = 4024

---领取限时任务完成奖励
---activity  ReqDrawTimeLimitTaskReward
---ToServer
LuaEnumNetDef.ReqDrawTimeLimitTaskRewardMessage = 4025

---返回领取限时任务奖励
---activity  ResDrawTimeLimitTaskReward
---ToClient
LuaEnumNetDef.ResDrawTimeLimitTaskRewardMessage = 4026

---请求玩家排行数据
---activity  ReqRoleActivityRankInfo
---ToServer
LuaEnumNetDef.ReqRoleActivityRankInfoMessage = 4027

---返回玩家排行数据
---activity  ResRoleActivityRankInfo
---ToClient
LuaEnumNetDef.ResRoleActivityRankInfoMessage = 4028

---发送幸运转盘活动信息
---activity  ResSendLuckyWheelInfo
---ToClient
LuaEnumNetDef.ResSendLuckyWheelInfoMessage = 4029

---开始幸运转盘
---activity  ReqStartLuckyWheel
---ToServer
LuaEnumNetDef.ReqStartLuckyWheelMessage = 4030

---发送幸运转盘结果信息
---activity  ResSendLuckyWheelResult
---ToClient
LuaEnumNetDef.ResSendLuckyWheelResultMessage = 4031

---发送幸运转盘奖励
---activity  ReqGetLuckyWheelReward
---ToServer
LuaEnumNetDef.ReqGetLuckyWheelRewardMessage = 4032

---发送极品龙装开启通知消息
---ToClient
LuaEnumNetDef.ResRareDragonEquipActivityOpenMessage = 4033

---发送七日狂欢信息
---activity  ResHappySevenDayActivityInfo
---ToClient
LuaEnumNetDef.ResHappySevenDayActivityInfoMessage = 4034

---请求领取七日狂欢奖励
---activity  ReqDrawHappySevenDayActivityReward
---ToServer
LuaEnumNetDef.ReqDrawHappySevenDayActivityRewardMessage = 4035

---返回七日狂欢活动数据变动信息
---activity  ResHappySevenDayActivityDataChange
---ToClient
LuaEnumNetDef.ResHappySevenDayActivityDataChangeMessage = 4036

---通知条件活动开启
---activity  ResOpenConditionActivity
---ToClient
LuaEnumNetDef.ResOpenConditionActivityMessage = 4037

---请求抽奖
---activity  ReqRaffle
---ToServer
LuaEnumNetDef.ReqRaffleMessage = 4038

---返回抽奖结果
---activity  ResRaffleResult
---ToClient
LuaEnumNetDef.ResRaffleResultMessage = 4039

---通知活动boss状态
---activity  ResActivityBossState
---ToClient
LuaEnumNetDef.ResActivityBossStateMessage = 4040

---发送合服沙巴克行会信息
---activity  ResCombineSbkUnion
---ToClient
LuaEnumNetDef.ResCombineSbkUnionMessage = 4041

---发送活动期间魂石消费信息
---activity  ResSoulStoneCost
---ToClient
LuaEnumNetDef.ResSoulStoneCostMessage = 4042

---发送狂欢活动信息
---activity  ResCrazyHappy
---ToClient
LuaEnumNetDef.ResCrazyHappyMessage = 4043

---请求领取狂欢活动奖励
---activity  ReqDrawCrazyHappyReward
---ToServer
LuaEnumNetDef.ReqDrawCrazyHappyRewardMessage = 4044

---狂欢活动数据变化信息
---activity  ResCrazyHappyChangeInfo
---ToClient
LuaEnumNetDef.ResCrazyHappyChangeInfoMessage = 4045

---领取总奖励返回信息
---activity  ResCrazyHappyReward
---ToClient
LuaEnumNetDef.ResCrazyHappyRewardMessage = 4046

---限时秒杀剩余数量
---activity  ResLimitBuyCount
---ToClient
LuaEnumNetDef.ResLimitBuyCountMessage = 4047

---发送神秘商城积分
---activity  ResMysticStorePoint
---ToClient
LuaEnumNetDef.ResMysticStorePointMessage = 4048

---发送幸运转盘抽奖次数
---activity  ResRaffCount
---ToClient
LuaEnumNetDef.ResRaffCountMessage = 4049

---发送投资计划信息
---activity  ResInvestPlan
---ToClient
LuaEnumNetDef.ResInvestPlanMessage = 4050

---请求领取投资返利奖励
---activity  ReqDrawInvestPlanReward
---ToServer
LuaEnumNetDef.ReqDrawInvestPlanRewardMessage = 4051

---请求狂欢转盘抽奖
---activity  ReqCrazyRaffle
---ToServer
LuaEnumNetDef.ReqCrazyRaffleMessage = 4052

---返回狂欢转盘信息
---activity  ResCrazyRaffleInfo
---ToClient
LuaEnumNetDef.ResCrazyRaffleInfoMessage = 4053

---返回成长试炼信息
---activity  ResGrowTrailInfo
---ToClient
LuaEnumNetDef.ResGrowTrailInfoMessage = 4054

---返回成长试炼活动数据变化信息
---activity  ResGrowTrailDataChange
---ToClient
LuaEnumNetDef.ResGrowTrailDataChangeMessage = 4055

---请求领取成长试炼奖励
---activity  ReqDrawGrowTrailReward
---ToServer
LuaEnumNetDef.ReqDrawGrowTrailRewardMessage = 4056

---请求领取成长试炼终极奖励
---activity  ReqDrawGrowTrailFinalReward
---ToServer
LuaEnumNetDef.ReqDrawGrowTrailFinalRewardMessage = 4057

---返回成长试炼大奖成功领取
---activity  ResGrowTrailFinalRewardDrawSuccess
---ToClient
LuaEnumNetDef.ResGrowTrailFinalRewardDrawSuccessMessage = 4058

---返回成长试炼显示消息
---ToClient
LuaEnumNetDef.ResGrowTrailShowMessage = 4059

---请求设置自选转盘
---activity  ReqSetChoseTurntable
---ToServer
LuaEnumNetDef.ReqSetChoseTurntableMessage = 4060

---返回自选转盘信息
---activity  ResChoseTurntable
---ToClient
LuaEnumNetDef.ResChoseTurntableMessage = 4061

---请求面板信息
---ToServer
LuaEnumNetDef.ReqOpenGrowTrailInfoMessage = 4062

---请求面板信息
---activity  BuyLimitedOfferRequest
---ToServer
LuaEnumNetDef.ReqBuyLimitedOfferMessage = 4064

---返回限时特惠信息
---activity  ResSaleGiftInfo
---ToClient
LuaEnumNetDef.ResBuyLimitInfoMessage = 4065

---活动开启信息响应
---activity  ActivityOpenTable
---ToClient
LuaEnumNetDef.ResServerActivityDataMessage = 4066

---活动开启信息请求
---activity  ActivityOpenMsgRequest
---ToServer
LuaEnumNetDef.ReqServerActivityDataMessage = 4067

---怪物攻城排行榜
---activity  ResActivityMonsterRankScoreList
---ToClient
LuaEnumNetDef.ResActivityMonsterRankScoreListMessage = 4068

---怪物攻城信息下发
---activity  ResActivityMonsterAttackTimesInfo
---ToClient
LuaEnumNetDef.ResActivityMonsterAttackTimesInfoMessage = 4069

---怪物攻城活动阶段
---activity  ResActivityMonsterStage
---ToClient
LuaEnumNetDef.ResActivityMonsterStageMessage = 4070

---怪物攻城BOSS击杀排行榜
---activity  ResActivityMonsterKillBossRank
---ToClient
LuaEnumNetDef.ResActivityMonsterKillBossRankMessage = 4071

---怪物攻城采集宝箱
---activity  ReqGatherActivityMonsterBox
---ToClient
LuaEnumNetDef.ReqGatherActivityMonsterBoxMessage = 4072

---更新保卫国王活动面板
---activity  ResDefendKingActivityInfo
---ToClient
LuaEnumNetDef.ResDefendKingActivityInfoMessage = 4073

---保卫国王个人积分变动
---activity  ResDefendUpdateScore
---ToClient
LuaEnumNetDef.ResDefendUpdateScoreMessage = 4074

---保卫国王关闭活动面板
---ToClient
LuaEnumNetDef.ResDefendClosePanelMessage = 4075

---请求保卫国王上次活动排行
---activity  ReqDefendLastRank
---ToServer
LuaEnumNetDef.ReqDefendLastRankMessage = 4076

---返回保卫国王上次活动排行
---activity  ResDefendLastRank
---ToClient
LuaEnumNetDef.ResDefendLastRankMessage = 4077

---返回保卫国王活动结束消息
---activity  ResDefendOver
---ToClient
LuaEnumNetDef.ResDefendOverMessage = 4078

---活动状态改变
---activity  ResDailyActivityStatusChanged
---ToClient
LuaEnumNetDef.ResDailyActivityStatusChangedMessage = 4079

---活动状态
---activity  ResAllActivityCommonStatus
---ToClient
LuaEnumNetDef.ResActivityCommonStatusMessage = 4080

---boss积分
---activity  BossScoreRes
---ToClient
LuaEnumNetDef.ResBossScoreMessage = 4081

---boss积分奖励领取
---activity  GetBossScoreReward
---ToServer
LuaEnumNetDef.ReqGetBossScoreRewardMessage = 4082

---领取到的物品提示面板
---activity  TheActivityHasRewarded
---ToClient
LuaEnumNetDef.TheActivityHasRewardedMessage = 4083

---猎魔人激活成功
---ToClient
LuaEnumNetDef.ResLieMoResActiveMessage = 4084

---一键领取猎魔人
---ToServer
LuaEnumNetDef.ReqLieMoRenGetRewardMessage = 4085

---请求保卫国王排行
---ToServer
LuaEnumNetDef.ReqDefendKingRankMessage = 4086

---返回保卫国王排行
---activity  DefendRank
---ToClient
LuaEnumNetDef.ResDefendKingRankMessage = 4087

---首杀首爆个人红包
---activity  ServerRoleReward
---ToClient
LuaEnumNetDef.ResServerRoleRewardMessage = 4088

---请求保卫国王活动排行榜期数列表
---ToServer
LuaEnumNetDef.ReqDefendLastRankListMessage = 4089

---返回保卫国王活动排行榜期数列表
---activity  ResDefendRankList
---ToClient
LuaEnumNetDef.ResDefendLastRankListMessage = 4090

---玩家上线发送今日已结束的活动type（每日0点清空）
---activity  ResTodayClosedActivities
---ToClient
LuaEnumNetDef.ResTodayClosedActivitiesMessage = 4091

---请求玩家上线今日已结束的活动type
---ToServer
LuaEnumNetDef.ReqTodayClosedActivitiesMessage = 4092

---活动期黑铁矿消耗
---activity  ResBlackIronCost
---ToClient
LuaEnumNetDef.ResBlackIronCostMessage = 4093

---需要打开图标的历法活动
---activity  ResTodayOpenActivities
---ToClient
LuaEnumNetDef.ResTodayOpenActivitiesMessage = 4094

---请求全部历法下礼包状态
---ToServer
LuaEnumNetDef.ReqAllCalendarGiftStateMessage = 4096

---返回全部历法小礼包状态
---activity  ResReceivedGiftState
---ToClient
LuaEnumNetDef.ResAllCalendarGiftStateMessage = 4097

---请求领取历法小礼包
---activity  ReqReceiveGift
---ToServer
LuaEnumNetDef.ReqReceiveCalendarGiftMessage = 4098

---请求幸运转盘信息
---ToServer
LuaEnumNetDef.ReqLuckTurntableInfoMessage = 4099

---返回幸运转盘信息
---activity  LuckTurntableInfo
---ToClient
LuaEnumNetDef.ResLuckTurntableInfoMessage = 4100

---请求幸运转盘抽奖
---ToServer
LuaEnumNetDef.ReqLuckTurntableLotteryMessage = 4101

---返回幸运转盘抽奖
---activity  LotteryReward
---ToClient
LuaEnumNetDef.ResLuckTurntableLotteryMessage = 4102
--endregion

--region ID:6  chat
---请求GM命令
---chat  ReqGM
---ToServer
LuaEnumNetDef.ReqGMMessage = 6001

---返回GM命令执行结果
---chat  ResGM
---ToClient
LuaEnumNetDef.ResGMMessage = 6002

---请求聊天
---chat  ReqChat
---ToServer
LuaEnumNetDef.ReqChatMessage = 6003

---聊天结果
---chat  ResChat
---ToClient
LuaEnumNetDef.ResChatMessage = 6004

---查看他人信息
---chat  ReqLookOther
---ToServer
LuaEnumNetDef.ReqLookOtherMessage = 6006

---查看他人信息
---chat  ResLookOther
---ToClient
LuaEnumNetDef.ResLookOtherMessage = 6007

---公告消息
---chat  ResAnnounce
---ToClient
LuaEnumNetDef.ResAnnounceMessage = 6008

---拉取最近几条聊天历史
---chat  ReqPullChatHistory
---ToServer
LuaEnumNetDef.ReqPullChatHistoryMessage = 6009

---拉取聊天历史结果
---chat  ResPullChatHistory
---ToClient
LuaEnumNetDef.ResPullChatHistoryMessage = 6010

---发送特殊广播信息
---chat  ReqSendSpecialAnnounce
---ToServer
LuaEnumNetDef.ReqSendSpecialAnnounceMessage = 6011

---请求聊天按钮回复
---chat  ReqBtnsReply
---ToServer
LuaEnumNetDef.ReqBtnsReplyMessage = 6012

---请求塔罗神庙公告历史记录
---ToServer
LuaEnumNetDef.ReqHuntAnnounceMessage = 6013

---返回塔罗神庙公告历史记录
---chat  ResHuntAnnounceHistory
---ToClient
LuaEnumNetDef.ResHuntAnnounceMessage = 6014

---返回塔罗神庙公告更新
---chat  ResHuntAnnounceUpdate
---ToClient
LuaEnumNetDef.ResHuntAnnounceUpdateMessage = 6015
--endregion

--region ID:7  tip
---提示消息
---tip  PromptMsg
---ToClient
LuaEnumNetDef.ResPromptMessage = 7001

---提示气泡
---tip  ResUIBubbleMsg
---ToClient
LuaEnumNetDef.ResUIBubbleMessage = 7002
--endregion

--region ID:8  role
---通知属性发生变化
---role  ResPlayerAttributeChange
---ToClient
LuaEnumNetDef.ResPlayerAttributeChangeMessage = 8001

---玩家基本数据
---role  ResPlayerBasicInfo
---ToClient
LuaEnumNetDef.ResPlayerBasicInfoMessage = 8002

---通知玩家经验发生变化
---role  ResPlayerExpChange
---ToClient
LuaEnumNetDef.ResPlayerExpChangeMessage = 8003

---通知玩家等级发生变化
---role  ResPlayerLevelChange
---ToClient
LuaEnumNetDef.ResPlayerLevelChangeMessage = 8004

---请求获取角色转生信息
---ToServer
LuaEnumNetDef.ReqGetRoleReinInfoMessage = 8006

---发送角色转生信息
---role  ResSendRoleReinInfo
---ToClient
LuaEnumNetDef.ResSendRoleReinInfoMessage = 8007

---角色请求兑换修为
---ToServer
LuaEnumNetDef.ReqRoleExchangeReinMessage = 8008

---请求角色转生
---ToServer
LuaEnumNetDef.ReqUpLevelRoleReinMessage = 8009

---发送角色兑换修为结果
---role  ResRoleExchangeReinResult
---ToClient
LuaEnumNetDef.ResRoleExchangeReinResultMessage = 8010

---发送总战斗力
---role  ResTotalFightValueChange
---ToClient
LuaEnumNetDef.ResTotalFightValueChangeMessage = 8011

---发送宠物列表
---role  ResPetList
---ToClient
LuaEnumNetDef.ResPetListMessage = 8012

---发送玩家宠物信息
---role  ResCreatePet
---ToClient
LuaEnumNetDef.ResCreatePetMessage = 8013

---请求改变玩家死亡状态
---role  ChangeRoleDieStateRequest
---ToServer
LuaEnumNetDef.ReqChangeRoleDieStateMessage = 8016

---请求立即复活
---ToServer
LuaEnumNetDef.ReqRoleImmediatelyReliveMessage = 8021

---发送立即复活成功消息
---ToClient
LuaEnumNetDef.ResRoleSuccessReliveMessage = 8022

---请求角色设置
---role  RoleSettingRequest
---ToServer
LuaEnumNetDef.ReqRoleSettingMessage = 8023

---角色设置变化返回
---role  ResRoleSettingChange
---ToClient
LuaEnumNetDef.ResRoleSettingChangeMessage = 8024

---角色设置消息
---role  ResRoleSettingInfo
---ToClient
LuaEnumNetDef.ResRoleSettingInfoMessage = 8025

---发送角色经脉信息
---role  ResSendRoleVeinInfo
---ToClient
LuaEnumNetDef.ResSendRoleVeinInfoMessage = 8026

---发送内功信息
---role  ResSendInnerPowerInfo
---ToClient
LuaEnumNetDef.ResSendInnerPowerInfoMessage = 8027

---请求一键升级内功
---ToServer
LuaEnumNetDef.ReqLevelUpInnerPowerMessage = 8028

---内功信息变化
---role  ResInnerPowerInfoChange
---ToClient
LuaEnumNetDef.ResInnerPowerInfoChangeMessage = 8029

---请求重置角色设置
---ToServer
LuaEnumNetDef.ReqResetRoleSettingMessage = 8030

---请求快捷键设置
---role  HandyKeySettingRequest
---ToServer
LuaEnumNetDef.ReqHandyKeySettingMessage = 8031

---请求交换快捷键设置
---role  ExchangeHandyKeyRequest
---ToServer
LuaEnumNetDef.ReqExchangeHandyKeyMessage = 8032

---返回快捷键设置信息
---role  ResHandyKeySettingInfos
---ToClient
LuaEnumNetDef.ResHandyKeySettingInfosMessage = 8033

---返回切换经验buff状态
---ToClient
LuaEnumNetDef.ResSwitchExpBuffStateMessage = 8034

---查看其他玩家信息请求
---role  GetRoleInfo
---ToServer
LuaEnumNetDef.ReqOtherRoleInfoMessage = 8035

---查看其他玩家信息响应
---role  RoleToOtherInfo
---ToClient
LuaEnumNetDef.ResOtherRoleInfoMessage = 8036

---客户端查看别的玩家的通用信息响应
---role  OtherPlayerCommonInfo
---ToClient
LuaEnumNetDef.ResOtherPlayerCommonInfoMessage = 8037

---客户端查看别的玩家的通用信息请求
---role  GetRoleInfo
---ToServer
LuaEnumNetDef.ReqOtherPlayerCommonInfoMessage = 8038

---保存玩家设置
---role  SaveRoleSettingsMsg
---ToServer
LuaEnumNetDef.ReqSaveRoleSettingsMessage = 8039

---cd 改变
---role  CDBean
---ToClient
LuaEnumNetDef.ResCDChangedMessage = 8040

---查看内功信息
---ToServer
LuaEnumNetDef.ReqLookInnerPowerMessage = 8041

---改名请求
---role  EditName
---ToServer
LuaEnumNetDef.ReqEditNameMessage = 8042

---保存玩家技能设置
---role  SaveRoleSkillSettingsMsg
---ToServer
LuaEnumNetDef.ReqSaveRoleSkillSettingsMessage = 8043

---转生成功
---role  ResRoleReinSuccess
---ToClient
LuaEnumNetDef.ResRoleReinSuccess = 8044

---系统开启提醒
---role  SystemOpenReminder
---ToClient
LuaEnumNetDef.SystemOpenReminderMessage = 8045

---打开快捷栏
---ToClient
LuaEnumNetDef.ResOpenKeySettingPanelMessage = 8046

---在线增加泡点经验消息
---role  ResBubbleOnlineExp
---ToClient
LuaEnumNetDef.ResBubbleOnlineExpMessage = 8047

---泡点结束消息
---ToClient
LuaEnumNetDef.ResOverBubblePointMessage = 8048

---返回泡点离线经验消息
---role  BubbleOfflineExp
---ToClient
LuaEnumNetDef.ResBubbleOfflineExpMessage = 8049

---请求领取离线泡点经验
---ToServer
LuaEnumNetDef.ReqReceiveBubbleOfflineExpMessage = 8050

---返回领取离线泡点经验
---role  BubbleOfflineExp
---ToClient
LuaEnumNetDef.ResReceiveBubbleOfflineExpMessage = 8051

---请求泡点离线经验消息
---ToServer
LuaEnumNetDef.ReqBubbleOfflineExpMessage = 8052

---切换自动寻路自动战斗状态
---role  AutoOperate
---ToServer
LuaEnumNetDef.ReqChangeAutoOperateMessage = 8053

---玩家零点刷新信息
---role  ResRefreshInfo
---ToClient
LuaEnumNetDef.ResRefreshInfoMessage = 8054

---请求查看矿工信息
---ToServer
LuaEnumNetDef.ReqGetMinerInfoMessage = 8055

---返回查看矿工信息
---role  ResGetMinerInfo
---ToClient
LuaEnumNetDef.ResGetMinerInfoMessage = 8056

---刷新矿石信息
---role  ResUpdateMineInfo
---ToClient
LuaEnumNetDef.ResUpdateMineInfoMessage = 8057

---请求雇佣矿工
---role  ReqHireMiner
---ToServer
LuaEnumNetDef.ReqHireMinerMessage = 8058

---请求领取矿石
---ToServer
LuaEnumNetDef.ReqReceiveMineralMessage = 8059

---返回变或取消间谍消息
---role  ResPlayerSpyInfo
---ToClient
LuaEnumNetDef.ResPlayerSpyInfoMessage = 8060

---请求保存或修改小秘书记录
---role  ReqSaveSecretaryInfo
---ToServer
LuaEnumNetDef.ReqSaveSecretaryInfoMessage = 8061

---返回查看小秘书历史记录
---role  ResSeeSecretaryInfo
---ToClient
LuaEnumNetDef.ResSeeSecretaryInfoMessage = 8062

---请求删除小秘书记录
---role  ReqDeleteSecretaryInfo
---ToServer
LuaEnumNetDef.ReqDeleteSecretaryInfoMessage = 8063

---小秘书推送
---role  ResSecretaryPush
---ToClient
LuaEnumNetDef.ResSecretaryPushMessage = 8064

---是否首冲改变
---role  ResRoleFirstRechargeChange
---ToClient
LuaEnumNetDef.ResRoleFirstRechargeChangeMessage = 8065

---检查小秘书推送前置任务是否完成
---role  ReqCheckPreTaskIsComplete
---ToServer
LuaEnumNetDef.ReqCheckPreTaskIsCompleteMessage = 8066

---返回前置任务是否完成
---role  ResCheckPreTaskIsComplete
---ToClient
LuaEnumNetDef.ResCheckPreTaskIsCompleteMessage = 8067

---改名返回
---role  ResEditName
---ToClient
LuaEnumNetDef.ResEditNameMessage = 8068

---小秘书主线任务推送
---role  ReqMainTaskPush
---ToServer
LuaEnumNetDef.ReqMainTaskPushMessage = 8069

---返回小秘书主线推送是否已经发过
---role  ResMainTaskPush
---ToClient
LuaEnumNetDef.ResMainTaskPushMessage = 8070

---请求小秘书历史记录
---ToServer
LuaEnumNetDef.ReqSeeSecretaryInfoMessage = 8071

---请求炼制大师面板信息
---role  ReqRefineMasterPanel
---ToServer
LuaEnumNetDef.ReqRefineMasterPanelMessage = 8072

---返回炼制大师面板信息
---role  ResRefineMasterPanel
---ToClient
LuaEnumNetDef.ResRefineMasterPanelMessage = 8073

---请求炼制
---role  ReqRefine
---ToServer
LuaEnumNetDef.ReqRefineMasterMessage = 8074

---返回炼制结果
---role  ResRefineResult
---ToClient
LuaEnumNetDef.ResRefineMasterResultMessage = 8075

---更新钻石额度
---role  UpdateAuctionDiamond
---ToClient
LuaEnumNetDef.ResUpdateAuctionDiamondMessage = 8076

---返回小秘书信息
---role  ResBackSecretaryInfo
---ToClient
LuaEnumNetDef.ResBackSecretaryInfoMessage = 8077

---发送小秘书问题
---role  ReqSendQuestionInfo
---ToServer
LuaEnumNetDef.ReqSendQuestionInfoMessage = 8078

---身上的装备掉落变动
---role  ResPlayerDieDropEquipByWear
---ToClient
LuaEnumNetDef.ResPlayerDieDropEquipByWearMessage = 8079

---请求千纸鹤传送
---role  ReqPaperCraneDelivery
---ToServer
LuaEnumNetDef.ReqPaperCraneDeliveryMessage = 8080

---千纸鹤传送返回
---role  ResPaperCraneDelivery
---ToClient
LuaEnumNetDef.ResPaperCraneDeliveryMessage = 8081

---首充推送
---ToClient
LuaEnumNetDef.ResFirstChargePushMessage = 8082

---首充推送-新服优势
---role  ResNewFirstChargePush
---ToClient
LuaEnumNetDef.ResNewFirstChargePushMessage = 8083

---系统开起感叹号提示
---role  ResNeedPrompt
---ToClient
LuaEnumNetDef.ResNeedPromptMessage = 8084

---查看联服其他玩家信息请求
---role  GetRoleInfo
---ToServer
LuaEnumNetDef.ReqShareOtherRoleInfoMessage = 8085

---返回玩家在游戏服的联服的基本数据
---role  GameBasicShareInfo
---ToClient
LuaEnumNetDef.ResGameBasicShareInfoMessage = 8086

---腕力刷新
---role  ResRoleRefreshWanLi
---ToClient
LuaEnumNetDef.ResRoleRefreshWanLiMessage = 8087

---给客户端发送假buff消息
---role  RoleAddFakeBuff
---ToClient
LuaEnumNetDef.RoleAddFakeBuffMessage = 8088

---给客户端发送驯服次数信息
---role  ResRoleTame
---ToClient
LuaEnumNetDef.ResRoleTameMessage = 8089

---炼制大师红点信息
---role  ResRefineMasterRedDot
---ToClient
LuaEnumNetDef.ResRefineMasterRedDotMessage = 8090

---给客户端发送封号天赋数据
---role  ResTitleTianfu
---ToClient
LuaEnumNetDef.ResTitleTianfuMessage = 8091

---请求保存封号天赋
---role  ReqSaveTitleTianfu
---ToServer
LuaEnumNetDef.ReqSaveTitleTianfuMessage = 8092

---请求重置封号天赋
---ToServer
LuaEnumNetDef.ReqResetTitleTianfuMessage = 8093

---请求打开练功房面板
---ToServer
LuaEnumNetDef.ReqOpenKongFuHousePanelMessage = 8094

---练功房时间限制
---role  ResKongFuHouseTimeLimit
---ToClient
LuaEnumNetDef.ResKongFuHouseTimeLimitMessage = 8095

---请求潜能信息
---ToServer
LuaEnumNetDef.ReqPotentialInfoMessage = 8096

---返回潜能信息
---role  RespotentialInfo
---ToClient
LuaEnumNetDef.ResPotentialInfoMessage = 8097

---请求激活潜能
---role  ReqActivePotential
---ToServer
LuaEnumNetDef.ReqActivePotentialMessage = 8098

---请求升级潜能
---role  ReqUpgradePotential
---ToServer
LuaEnumNetDef.ReqUpgradePotentialMessage = 8099

---返回单个潜能信息
---role  potentialInfo
---ToClient
LuaEnumNetDef.ResSinglePotentialInfoMessage = 8100

---返回潜能红点信息
---role  ResPotentialRedPoint
---ToClient
LuaEnumNetDef.ResRedPointPotentialMessage = 8101

---请求设置回收配置
---role  CollectionSetting
---ToServer
LuaEnumNetDef.ReqCollectionSettingMessage = 8102

---返回回收配置
---role  CollectionSetting
---ToClient
LuaEnumNetDef.ResCollectionSettingMessage = 8103

---请求自动拾取配置
---role  PickUpSetting
---ToServer
LuaEnumNetDef.ReqPickUpSettingMessage = 8104

---返回自动拾取配置
---role  PickUpSetting
---ToClient
LuaEnumNetDef.ResPickUpSettingMessage = 8105

---请求玩家模型数据
---role  ReqRoleModelInfo
---ToServer
LuaEnumNetDef.ReqGetRoleModelInfoMessage = 8106

---返回玩家模型数据
---role  RoleModelInfo
---ToClient
LuaEnumNetDef.ResRoleModelInfoMessage = 8107

---神秘老人请求兑换物品
---role  ReqMysteriousExchange
---ToServer
LuaEnumNetDef.ReqMysteriousExchangeMessage = 8108

---神秘老人兑换详情
---role  ResMysteriousExchange
---ToClient
LuaEnumNetDef.ResMysteriousExchangeMessage = 8109

---终极boss击杀数据
---role  BossKillData
---ToClient
LuaEnumNetDef.ResBossKillDataMessage = 8110

---增加boss击杀次数
---role  ReqAddBossKillTimes
---ToServer
LuaEnumNetDef.ReqAddBossKillTimesMessage = 8111

---玩家系统预告开启信息
---role  ResRoleSystemPreview
---ToClient
LuaEnumNetDef.ResRoleSystemPreviewMessage = 8112

---请求领取系统预告奖励
---role  ReqRewardSystemPreview
---ToServer
LuaEnumNetDef.ReqRewardSystemPreviewMessage = 8113

---请求消耗资源兑换经验
---role  ReqAddRoleExpByResources
---ToServer
LuaEnumNetDef.ReqAddRoleExpByResourcesMessage = 8114

---返回当前累计的经验值
---role  ResRoleExpAccumulate
---ToClient
LuaEnumNetDef.ResRoleExpAccumulateMessage = 8115

---返回创角邀请码
---role  ResRoleInviteCode
---ToClient
LuaEnumNetDef.ResRoleInviteCodeMessage = 8116

---转性
---ToServer
LuaEnumNetDef.ReqTransferSexMessage = 8117

---转性
---role  ResTransferSex
---ToClient
LuaEnumNetDef.ResTransferSexMessage = 8118

---转职
---role  ReqTransferCareer
---ToServer
LuaEnumNetDef.ReqTransferCareerMessage = 8119

---转职
---role  ResTransferCareer
---ToClient
LuaEnumNetDef.ResTransferCareerMessage = 8120

---返回身上可投保列表
---role  ResCanInsuredEquip
---ToClient
LuaEnumNetDef.ResCanInsuredEquipMessage = 8121

---请求投保
---role  ReqInsuredEquip
---ToServer
LuaEnumNetDef.ReqInsuredEquipMessage = 8122

---投保返回
---role  ResInsuredSucces
---ToClient
LuaEnumNetDef.ResInsuredSuccesMessage = 8123

---请求身上可投保列表
---ToServer
LuaEnumNetDef.ReqCanInsuredEquipMessage = 8124
--endregion

--region ID:9  skill
---请求角色技能数据
---ToServer
LuaEnumNetDef.ReqSkillBasicInfoMessage = 9001

---返回角色技能数据
---skill  ResSkill
---ToClient
LuaEnumNetDef.ResSkillMessage = 9002

---请求升级技能
---skill  SkillIdInfo
---ToServer
LuaEnumNetDef.ReqLevelUpSkillMessage = 9003

---请求激活技能
---ToServer
LuaEnumNetDef.ReqActivateSkillMessage = 9004

---返回单个技能变化数据
---skill  ResOneSkillChange
---ToClient
LuaEnumNetDef.ResOneSkillChangeMessage = 9005

---返回多个技能变化数据
---skill  ResMultiSkillChange
---ToClient
LuaEnumNetDef.ResMultiSkillChangeMessage = 9006

---使用技能书
---skill  SkillBean
---ToClient
LuaEnumNetDef.ResSkillBookUseMessage = 9007

---设置技能映射
---skill  ReqSetSkillShortcut
---ToServer
LuaEnumNetDef.ReqSetSkillShortcutMessage = 9008

---秘技设置保存
---skill  SecretSkillUpdate
---ToServer
LuaEnumNetDef.ReqSecretSkillUpdateMessage = 9009

---秘技面板
---skill  SecretSkillInfo
---ToClient
LuaEnumNetDef.ResSecretSkillInfoMessage = 9010

---请求秘技面板
---ToServer
LuaEnumNetDef.ReqSecretSkillInfoMessage = 9011

---请求切换心阵
---skill  ReqSwitchFormation
---ToServer
LuaEnumNetDef.ReqSwitchFormationMessage = 9012

---请求卸下心法
---skill  ReqTakeOffSecret
---ToServer
LuaEnumNetDef.ReqTakeOffSecretMessage = 9013

---返回移除技能
---skill  SkillIdInfo
---ToClient
LuaEnumNetDef.ResRemoveSkillMessage = 9014

---上下阵心法回调
---skill  ResSecretBack
---ToClient
LuaEnumNetDef.ResSecretBackMessage = 9015

---切换心阵
---skill  ReqSwitchFormation
---ToClient
LuaEnumNetDef.ResSwitchFormationMessage = 9016

---xp 能量改变
---skill  ResXpSkillEnergyChange
---ToClient
LuaEnumNetDef.ResXpSkillEnergyChangeMessage = 9017

---请求升级装备专精
---skill  UpEquipProficient
---ToServer
LuaEnumNetDef.ReqUpEquipProficientMessage = 9018

---全部的装备专精信息
---skill  AllEquipProficientInfo
---ToClient
LuaEnumNetDef.ResAllEquipProficientInfoMessage = 9019

---单个装备专精信息
---skill  EquipProficientInfo
---ToClient
LuaEnumNetDef.ResEquipProficientInfoMessage = 9020

---学习特殊技能(不通过技能书)
---skill  ReqStudySpecialSkill
---ToServer
LuaEnumNetDef.ReqStudySpecialSkillMessage = 9021
--endregion

--region ID:10  bag
---请求背包信息
---ToServer
LuaEnumNetDef.ReqBagInfoMessage = 10001

---返回请求背包
---bag  ResBagInfo
---ToClient
LuaEnumNetDef.ResBagInfoMessage = 10002

---背包发生变化
---bag  ResBagChange
---ToClient
LuaEnumNetDef.ResBagChangeMessage = 10003

---请求使用道具
---bag  UseItemRequest
---ToServer
LuaEnumNetDef.ReqUseItemMessage = 10004

---使用道具返回消息
---bag  ResUseItem
---ToClient
LuaEnumNetDef.ResUseItemMessage = 10005

---增加装备页签格子上限消息
---ToServer
LuaEnumNetDef.ReqAddEquipMaxCountMessage = 10006

---请求回收装备
---bag  RecycleEquipmentRequest
---ToServer
LuaEnumNetDef.ReqRecycleEquipmentMessage = 10007

---扩容次数变化的消息
---bag  ResAddGridCountChange
---ToClient
LuaEnumNetDef.ResAddGridCountChangeMessage = 10008

---回收装备
---bag  RecycleSuccess
---ToClient
LuaEnumNetDef.ResRecycleEquipmentMessage = 10009

---使用攻击药水的返回
---bag  ResUseAttackDrag
---ToClient
LuaEnumNetDef.ResUseAttackDragMessage = 10010

---请求使用副本道具
---bag  UseInstanceItemRequest
---ToServer
LuaEnumNetDef.ReqUseInstanceItemMessage = 10011

---返回次数
---bag  ResGetAttackDragBuyCount
---ToClient
LuaEnumNetDef.ResGetAttackDragBuyCountMessage = 10012

---请求vip回收装备
---bag  VipRecycleEquipmentRequest
---ToServer
LuaEnumNetDef.ReqVipRecycleEquipmentMessage = 10013

---请删除特殊道具
---bag  DeleteSpecialItemRequest
---ToServer
LuaEnumNetDef.ReqDeleteSpecialItemMessage = 10014

---充值宝箱装
---bag  ResRechargeBoxInfo
---ToClient
LuaEnumNetDef.ResRechargeBoxInfoMessage = 10015

---出售活动道具
---bag  SellActivityItemRequest
---ToServer
LuaEnumNetDef.ReqSellActivityItemMessage = 10016

---请求抽奖
---bag  StartZhuanPanRequest
---ToServer
LuaEnumNetDef.ReqStartZhuanPanMessage = 10017

---返回转盘结果
---bag  ResZhuanPanResult
---ToClient
LuaEnumNetDef.ResZhuanPanResultMessage = 10018

---发送特殊道具激活情况
---bag  ResSpecialItemActivate
---ToClient
LuaEnumNetDef.ResSpecialItemActivateMessage = 10019

---请求特殊道具激活情况
---ToServer
LuaEnumNetDef.ReqSpecialItemActivateMessage = 10020

---请求仓库信息
---ToServer
LuaEnumNetDef.ReqStorageInfoMessage = 10021

---返回请求仓库
---bag  ResStorageInfo
---ToClient
LuaEnumNetDef.ResStorageInfoMessage = 10022

---仓库更新变化
---bag  ResStorageUpdate
---ToClient
LuaEnumNetDef.ResStorageUpdateMessage = 10023

---请求提取道具
---bag  StorageOutItemRequest
---ToServer
LuaEnumNetDef.ReqStorageOutItemMessage = 10024

---请求存储道具
---bag  StorageInItemRequest
---ToServer
LuaEnumNetDef.ReqStorageInItemMessage = 10025

---请求增加格子上限消息
---ToServer
LuaEnumNetDef.ReqAddStorageMaxCountMessage = 10026

---返回增加格子上限消息
---bag  ResAddStorageMaxCount
---ToClient
LuaEnumNetDef.ResAddStorageMaxCountMessage = 10027

---请求整理仓库
---ToServer
LuaEnumNetDef.ReqTidyStorageMessage = 10028

---添加交易物品
---bag  AddTradeItemRequest
---ToServer
LuaEnumNetDef.ReqAddTradeItemMessage = 10029

---返回交易物品添加
---bag  ResTradeItemChange
---ToClient
LuaEnumNetDef.ResTradeItemChangeMessage = 10030

---请求丢弃道具
---bag  DiscardItemRequest
---ToServer
LuaEnumNetDef.ReqDiscardItemMessage = 10031

---返回恢复药水效果
---bag  ResRecoveryDrug
---ToClient
LuaEnumNetDef.ResRecoveryDrugMessage = 10032

---物品拆分请求
---bag  ItemApart
---ToServer
LuaEnumNetDef.ReqItemApartMessage = 10033

---物品拆分响应
---ToClient
LuaEnumNetDef.ResItemApartMessage = 10034

---强化装备请求
---bag  ReqIntensify
---ToServer
LuaEnumNetDef.ReqIntensifyMessage = 10035

---强化转移请求
---bag  ReqIntensifyTrans
---ToServer
LuaEnumNetDef.ReqIntensifyTransferMessage = 10036

---清除强化请求
---bag  ReqIntensify
---ToServer
LuaEnumNetDef.ReqIntensifyClearMessage = 10037

---强化, 转移, 清除响应
---bag  ResIntensify
---ToClient
LuaEnumNetDef.ResIntensifyMessage = 10038

---请求销毁道具
---bag  Destruction
---ToServer
LuaEnumNetDef.ReqDestructionMessage = 10039

---整理背包
---bag  TidyItem
---ToServer
LuaEnumNetDef.ReqTidyItemMessage = 10040

---神炉升级请求
---bag  GemUpgrade
---ToServer
LuaEnumNetDef.ReqGodFurnaceUpGradeMessage = 10041

---神炉升级响应
---ToClient
LuaEnumNetDef.ResGodFurnaceUpGradeMessage = 10042

---耐久值变化响应
---bag  LastingUpdate
---ToClient
LuaEnumNetDef.ResLastingUpdateMessage = 10043

---批量使用聚灵珠
---bag  UseAllExpBox
---ToServer
LuaEnumNetDef.ReqUseAllExpBoxMessage = 10044

---赤炎灯灯芯升级
---bag  LampUpgrade
---ToServer
LuaEnumNetDef.ReqlampUpgradeMessage = 10045

---赤炎灯灯芯升级返回
---bag  LampUpgradeRes
---ToClient
LuaEnumNetDef.ReslampUpgradeResMessage = 10046

---生命精魄升级
---bag  ReqUpgradeSoulJade
---ToServer
LuaEnumNetDef.ReqUpgradeSoulJadeMessage = 10047

---生命精魄升级响应
---bag  ResUpgradeSoulJade
---ToClient
LuaEnumNetDef.ResUpgradeSoulJadeMessage = 10048

---掠宝袋领取请求
---bag  DrawPreyTreasureBag
---ToServer
LuaEnumNetDef.ReqDrawPreyTreasureBagMessage = 10049

---打开掠宝袋的返回
---bag  PreyTreasureBagResponse
---ToClient
LuaEnumNetDef.ResPreyTreasureBagMessage = 10050

---掠宝袋的领取响应
---bag  DrawPreyTreasureBagResponse
---ToClient
LuaEnumNetDef.ResDrawPreyTreasureBagMessage = 10051

---掠宝袋的抽奖
---bag  RafflePreyTreasureBag
---ToServer
LuaEnumNetDef.ReqRafflePreyTreasureBagMessage = 10053

---删除到期道具
---bag  RemoveTimeEnd
---ToServer
LuaEnumNetDef.ReqRemoveTimeEndItemMessage = 10054

---魂玉合成请求
---bag  ReqGetNextSoulJade
---ToServer
LuaEnumNetDef.ReqGetNextSoulJadeMessage = 10055

---魂玉合成返回
---bag  ResGetNextSoulJade
---ToClient
LuaEnumNetDef.ResGetNextSoulJadeMessage = 10056

---装备进化请求
---bag  ReqEvolve
---ToServer
LuaEnumNetDef.ReqEvolveMessage = 10057

---装备进化返回
---bag  ResEvolve
---ToClient
LuaEnumNetDef.ResEvolveMessage = 10058

---请求打捆的商店列表
---ToServer
LuaEnumNetDef.ReqBundlitemMessage = 10059

---返回打捆的商店列表
---bag  ResBundlitem
---ToClient
LuaEnumNetDef.ResBundlitemMessage = 10060

---请求购买打捆的物品
---bag  ReqBuyResBundlitem
---ToServer
LuaEnumNetDef.ReqBuyResBundlitemMessage = 10061

---返回成功兑换打捆商品信息
---bag  ResSuccessBuyBindlitem
---ToClient
LuaEnumNetDef.ResSuccessBuyBindlitemMessage = 10062

---请求快捷购买物品
---bag  ReqBuyMaterialWay
---ToServer
LuaEnumNetDef.ReqBuyMaterialWayMessage = 10063

---返回快捷购买成功消息
---bag  ResBuyMaterialWaySuccess
---ToClient
LuaEnumNetDef.ResBuyMaterialWaySuccessMessage = 10064

---请求每日使用物品数量限制
---bag  ReqDayUseItemCount
---ToServer
LuaEnumNetDef.ReqDayUseItemCountMessage = 10065

---返回每日使用物品数量限制
---bag  ResDayUseItemCount
---ToClient
LuaEnumNetDef.ResDayUseItemCountMessage = 10066

---请求能否使用聚灵珠
---bag  ReqCanUseGatherSpiritBead
---ToServer
LuaEnumNetDef.ReqCanUseGatherSpiritBeadMessage = 10067

---返回能否使用聚灵珠
---bag  ResCanUseGatherSpiritBead
---ToClient
LuaEnumNetDef.ResCanUseGatherSpiritBeadMessage = 10069

---更新物品产出
---bag  UpdateItemOutput
---ToClient
LuaEnumNetDef.ResUpdateItemOutputMessage = 10070

---使用兑换码
---bag  ReqUseCDKey
---ToServer
LuaEnumNetDef.ReqUseCDKeyMessage = 10071

---请求使用间谍牌
---bag  ReqUseSpyBrand
---ToServer
LuaEnumNetDef.ReqUseSpyBrandMessage = 10072

---物品获得提示
---bag  ResItemTips
---ToClient
LuaEnumNetDef.ResItemTipsMessage = 10073

---批量使用聚灵珠
---bag  UseExpBox
---ToServer
LuaEnumNetDef.ReqUseExpBoxMessage = 10074

---打开掠宝袋宝箱的返回
---bag  PreyTreasureBoxResponse
---ToClient
LuaEnumNetDef.ResPreyTreasureBoxMessage = 10075

---掠宝袋宝箱的领取响应
---bag  DrawPreyTreasureBoxResponse
---ToClient
LuaEnumNetDef.ResDrawPreyTreasureBoxMessage = 10076

---掠宝袋宝箱的抽奖
---bag  RafflePreyTreasureBox
---ToServer
LuaEnumNetDef.ReqRafflePreyTreasureBoxMessage = 10077

---掠宝袋宝箱领取请求
---bag  DrawPreyTreasureBox
---ToServer
LuaEnumNetDef.ReqDrawPreyTreasureBoxMessage = 10078

---掠宝袋宝箱使用多个请求
---bag  UsePreyTreasureBoxMulti
---ToServer
LuaEnumNetDef.ReqUsePreyTreasureBoxMultiMessage = 10079

---返回掠宝袋宝箱使用多个请求
---bag  ResAwardPreyTreasureBoxMulti
---ToClient
LuaEnumNetDef.ResAwardPreyTreasureBoxMultiMessage = 10080

---领取掠宝袋宝箱多个请求
---bag  AwardPreyTreasureBoxMulti
---ToServer
LuaEnumNetDef.ReqAwardPreyTreasureBoxMultiMessage = 10081

---请求熔炼物品
---bag  RecycleEquipmentRequest
---ToServer
LuaEnumNetDef.ReqSmeltMessage = 10082

---熔炼物品回包
---bag  ResSmelt
---ToClient
LuaEnumNetDef.ResSmeltMessage = 10083

---请求熔炼血继
---bag  ReqBloodSmelt
---ToServer
LuaEnumNetDef.ReqBloodSmeltMessage = 10084

---熔炼血继回包
---bag  ResBloodSmelt
---ToClient
LuaEnumNetDef.ResBloodSmeltMessage = 10085

---请求熔炼神力装备
---bag  ReqDivineSmelt
---ToServer
LuaEnumNetDef.ReqDivineSmeltMessage = 10086

---熔炼胜利回包
---bag  ResDivineSmelt
---ToClient
LuaEnumNetDef.ResDivineSmeltMessage = 10087

---返回背包格子上限消息
---bag  ResBagSizeByMonthCard
---ToClient
LuaEnumNetDef.ResBagSizeByMonthCardMessage = 10088

---请求使用元宝宝箱
---bag  UseMoneyBox
---ToServer
LuaEnumNetDef.ReqUseMoneyBoxMessage = 10089

---同步自动挖掘数量
---bag  ResUpdateAutomaticCollect
---ToClient
LuaEnumNetDef.ResUpdateAutomaticCollectMessage = 10090
--endregion

--region ID:11  treasurehunt
---获取寻宝信息
---ToServer
LuaEnumNetDef.ReqGetTreasureHuntMessage = 11101

---寻宝积分信息
---ToServer
LuaEnumNetDef.ReqPointInfoMessage = 11102

---寻宝请求
---treasurehunt  TreasureRequest
---ToServer
LuaEnumNetDef.ReqTreasureHuntMessage = 11103

---寻宝积分兑换请求
---treasurehunt  ExchangePointRequest
---ToServer
LuaEnumNetDef.ReqExchangePointMessage = 11104

---历史信息
---treasurehunt  HuntHistory
---ToClient
LuaEnumNetDef.ResServerHistoryMessage = 11105

---获取某个物品
---treasurehunt  GetTreasureItemRequest
---ToServer
LuaEnumNetDef.ReqGetItemMessage = 11106

---获取所有物品
---ToServer
LuaEnumNetDef.ReqGetWholeItemMessage = 11107

---寻宝仓库物品变动信息
---treasurehunt  TreasureItemChangeList
---ToClient
LuaEnumNetDef.ResTreasureItemChangedMessage = 11108

---寻宝仓库信息请求
---ToServer
LuaEnumNetDef.ReqTreasureStorehouseMessage = 11109

---寻宝仓库信息
---treasurehunt  TreasureHuntInfo
---ToClient
LuaEnumNetDef.ResTreasureStorehouseMessage = 11110

---寻宝结束信息
---ToClient
LuaEnumNetDef.ResTreasureEndMessage = 11111

---使用寻宝经验丹
---treasurehunt  ExpUseRequest
---ToServer
LuaEnumNetDef.ReqUseTreasureExpMessage = 11112

---使用寻宝经验丹响应
---treasurehunt  ExpUseRequest
---ToClient
LuaEnumNetDef.ResUseTreasureExpMessage = 11113

---寻宝界面宝箱请求
---ToServer
LuaEnumNetDef.ReqTreasureIdMessage = 11114

---寻宝界面宝箱响应
---treasurehunt  TreasureIdResponse
---ToClient
LuaEnumNetDef.ResTreasureIdMessage = 11115

---全服寻宝的奖励请求
---ToServer
LuaEnumNetDef.ReqServerTreasureRewardMessage = 11116

---取消全服寻宝的奖励请求
---ToServer
LuaEnumNetDef.ReqCancelServerTreasureRewardMessage = 11117

---寻宝仓库中回收装备请求
---treasurehunt  HuntCallbackRequest
---ToServer
LuaEnumNetDef.ReqHuntCallBackMessage = 11118

---寻宝仓库中回收装备响应
---treasurehunt  HuntCallbackResponse
---ToClient
LuaEnumNetDef.ResHuntCallBackMessage = 11119

---查看限时寻宝池请求
---ToServer
LuaEnumNetDef.ReqLimitTimeTreasureHuntPoolMessage = 11120

---查看限时寻宝池响应
---treasurehunt  LimitTimeTreasureHuntPool
---ToClient
LuaEnumNetDef.ResLimitTimeTreasureHuntPoolMessage = 11121

---寻宝新特戒今日是否显示提示
---treasurehunt  NewRingDisplay
---ToServer
LuaEnumNetDef.ReqNewRingDisplayMessage = 11122

---请求寻宝卡牌信息
---ToServer
LuaEnumNetDef.ReqTreasureCardMessage = 11123

---返回所有卡牌信息
---treasurehunt  AllCardInfo
---ToClient
LuaEnumNetDef.ResTreasureCardMessage = 11124

---请求翻牌
---treasurehunt  TurnCardRequset
---ToServer
LuaEnumNetDef.ReqTreasureTurnCardMessage = 11125

---返回翻牌失败信息
---treasurehunt  TurnCardFailInfo
---ToClient
LuaEnumNetDef.ResTreasureFailMessage = 11126

---请求寻宝卡牌私有结束信息
---treasurehunt  PrivateCardOverRequest
---ToServer
LuaEnumNetDef.ReqTreasurePrivateCardOverMessage = 11127

---返回翻牌私有信息
---treasurehunt  TurnCardPrivateInfo
---ToClient
LuaEnumNetDef.ResTreasurePrivateMessage = 11128

---请求历史信息
---ToServer
LuaEnumNetDef.ReqServerHistoryMessage = 11129

---寻宝仓库更新
---treasurehunt  StorageUpdateInfo
---ToClient
LuaEnumNetDef.ResHuntStorageUpdateMessage = 11130

---请求全服转生信息
---treasurehunt  ReinNumRequest
---ToServer
LuaEnumNetDef.ReqReinNumMessage = 11131

---返回全服转生信息
---treasurehunt  ReinNumResponse
---ToClient
LuaEnumNetDef.ResReinNumMessage = 11132

---请求挖宝
---treasurehunt  ReqDigTreasure
---ToServer
LuaEnumNetDef.ReqDigTreasureMessage = 11133

---挖宝仓库请求一键提取、使用
---treasurehunt  ReqOneKeyOperation
---ToServer
LuaEnumNetDef.ReqOneKeyOperationMessage = 11134

---挖宝仓库请求一键回收
---treasurehunt  ReqOneKeyCallBack
---ToServer
LuaEnumNetDef.ReqOneKeyCallBackMessage = 11135

---返回挖宝仓库信息
---treasurehunt  DigTreasureWareHouse
---ToClient
LuaEnumNetDef.ResDigTreasureWareHouseMessage = 11136

---请求打开挖宝仓库
---ToServer
LuaEnumNetDef.ReqOpenDigTreasureWareHouseMessage = 11137

---请求玩家挖宝次数
---ToServer
LuaEnumNetDef.ReqDigTreasureCountMessage = 11138

---玩家挖宝次数
---treasurehunt  RoleDigTreasureCount
---ToClient
LuaEnumNetDef.ResRoleDigTreasureCountMessage = 11139

---玩家挖宝状态数
---treasurehunt  DigTreasureState
---ToClient
LuaEnumNetDef.ResDigTreasureStateMessage = 11140

---玩家挖宝状态数
---treasurehunt  DigTreasureItems
---ToClient
LuaEnumNetDef.ResDigTreasureItemsMessage = 11141

---黄金挖宝活动状态
---treasurehunt  GoldDigActiveState
---ToClient
LuaEnumNetDef.ResGoldDigActiveStateMessage = 11142
--endregion

--region ID:13  equip
---所有装备信息
---equip  ResAllEquip
---ToClient
LuaEnumNetDef.ResAllEquipMessage = 13001

---请求一键换装
---equip  ReqOneKeyPutOnEquip
---ToServer
LuaEnumNetDef.ReqOneKeyPutOnEquipMessage = 13002

---装备信息更新
---equip  ResEquipChange
---ToClient
LuaEnumNetDef.ResEquipChangeMessage = 13003

---返回装备信息
---equip  ResItemInfo
---ToClient
LuaEnumNetDef.ResItemInfoMessage = 13004

---获取装备信息
---equip  ReqGetItemInfo
---ToServer
LuaEnumNetDef.ReqGetItemInfoMessage = 13005

---请求穿装备
---equip  ReqPutOnTheEquip
---ToServer
LuaEnumNetDef.ReqPutOnTheEquipMessage = 13006

---请求合成橙色装备
---equip  ReqCombineOrangeEquip
---ToServer
LuaEnumNetDef.ReqCombineOrangeEquipMessage = 13007

---请求脱装备
---equip  ReqPutOffEquip
---ToServer
LuaEnumNetDef.ReqPutOffTheEquipMessage = 13008

---返回改变成装备的样子
---equip  ResChangeAppearance
---ToClient
LuaEnumNetDef.ResChangeAppearanceMessage = 13009

---请求修理装备
---equip  ReqRepairEquip
---ToServer
LuaEnumNetDef.ReqRepairEquipMessage = 13010

---返回修理装备
---equip  ResRepairEquip
---ToClient
LuaEnumNetDef.ResRepairEquipMessage = 13011

---同步物品的使用次数
---equip  ItemUseCountInfo
---ToClient
LuaEnumNetDef.ResSynItemUseCountMessage = 13012

---请求镶嵌勋章
---equip  ReqInlayMedal
---ToServer
LuaEnumNetDef.ReqInlayMedalMessage = 13013

---返回修理灵兽肉身装备
---equip  ResRepairServantEquip
---ToClient
LuaEnumNetDef.ResRepairServantEquipMessage = 13014

---请求修理灵兽肉身装备
---equip  ReqRepairServantEquip
---ToServer
LuaEnumNetDef.ReqRepairServantEquipMessage = 13015

---装备炼制请求
---equip  ReqEquipRefine
---ToServer
LuaEnumNetDef.ReqEquipRefineMessage = 13016

---保存炼制属性请求
---equip  ReqSaveEquipRefine
---ToServer
LuaEnumNetDef.ReqSaveEquipRefineMessage = 13017

---装备炼制响应
---bag  BagItemInfo
---ToClient
LuaEnumNetDef.ResEquipRefineMessage = 13018

---单个套装法宝信息
---equip  MagicWeapon
---ToClient
LuaEnumNetDef.ResMagicWeaponInfoMessage = 13021

---全部法宝信息
---equip  AllMagicWeaponInfo
---ToClient
LuaEnumNetDef.ResAllMagicWeaponInfoMessage = 13022

---玩家获得过的法宝类型
---equip  UpdateGetedType
---ToClient
LuaEnumNetDef.ResUpdateGetedTypeMessage = 13023

---请求开启血继装备位
---equip  ReqOpenBloodSuitGrid
---ToServer
LuaEnumNetDef.ReqOpenBloodSuitGridMessage = 13024

---请求镶嵌魂装
---equip  ReqPutOnSoulEquip
---ToServer
LuaEnumNetDef.ReqPutOnSoulEquipMessage = 13025

---请求卸下镶嵌魂装
---equip  ReqPutOffSoulEquip
---ToServer
LuaEnumNetDef.ReqPutOffSoulEquipMessage = 13026

---返回魂装镶嵌数据
---equip  AllSoulEquipInfo
---ToClient
LuaEnumNetDef.ResAllSoulEquipInfoMessage = 13027

---请求魂装镶嵌数据
---ToServer
LuaEnumNetDef.ReqGetAllSoulInfoMessage = 13028

---请求洗炼魂装
---equip  ReqSoulEquipRefin
---ToServer
LuaEnumNetDef.ReqSoulEquipRefinMessage = 13029

---返回魂装洗炼结果
---equip  ResRefinResult
---ToClient
LuaEnumNetDef.ResRefinResultMessage = 13030

---全部魂装信息
---equip  WholeSoulEquips
---ToClient
LuaEnumNetDef.ResWholeSoulEquipsMessage = 13031

---请求鉴定装备
---equip  ReqAppraisaEquip
---ToServer
LuaEnumNetDef.ReqAppraisaEquipMessage = 13032

---返回鉴定结果
---equip  ResAppraisaResult
---ToClient
LuaEnumNetDef.ResAppraisaResultMessage = 13033

---鉴定勾选今日不在提示
---ToServer
LuaEnumNetDef.ReqAppraisaTodaynOTipMessage = 13034

---返回鉴定今日不在提示信息
---equip  ResAppraisaTip
---ToClient
LuaEnumNetDef.ResResAppraisaTipMessage = 13035

---配饰重铸
---equip  ReqRecast
---ToServer
LuaEnumNetDef.ReqRecastMessage = 13036

---配饰重铸
---equip  ResRecast
---ToClient
LuaEnumNetDef.ResRecastMessage = 13037

---请求解锁仙装镶嵌位
---equip  UnlockSoulEquipIndex
---ToServer
LuaEnumNetDef.ReqUnlockSoulEquipIndexMessage = 13038

---成长兵鉴升级或突破
---equip  ReqGrowthEquip
---ToServer
LuaEnumNetDef.ReqGrowthEquipMessage = 13039
--endregion

--region ID:16  store
---请求打开商店根据storeClassId
---store  ReqOpenStoreById
---ToServer
LuaEnumNetDef.ReqOpenStoreByIdMessage = 16001

---返回商店商品列表
---store  ResOpenStoreById
---ToClient
LuaEnumNetDef.ResOpenStoreByIdMessage = 16002

---发送商店单个商品变化信息
---store  ResSendStoreInfoChange
---ToClient
LuaEnumNetDef.ResSendStoreInfoChangeMessage = 16003

---购买请求
---store  ReqBuyItem
---ToServer
LuaEnumNetDef.ReqBuyItemMessage = 16004

---请求指定商品能购买的最大数量
---store  ReqMaxBuyCount
---ToServer
LuaEnumNetDef.ReqMaxBuyCountMessage = 16005

---返回指定商品能购买的最大数量
---store  ResMaxBuyCount
---ToClient
LuaEnumNetDef.ResMaxBuyCountMessage = 16006

---请求手动刷新
---store  ReqManualFresh
---ToServer
LuaEnumNetDef.ReqMaualFreshMessage = 16007

---请求一件商品信息
---store  ReqStoreInfo
---ToServer
LuaEnumNetDef.ReqStoreInfoMessage = 16014

---返回一件商品信息
---store  ResStoreInfo
---ToClient
LuaEnumNetDef.ResStoreInfoMessage = 16015

---请求合成
---store  ReqSynthesis
---ToServer
LuaEnumNetDef.ReqSynthesisMessage = 16016

---返回合成成功
---store  ResSynthesis
---ToClient
LuaEnumNetDef.ResSynthesisMessage = 16017

---购买回调
---store  ResBuyItem
---ToClient
LuaEnumNetDef.ResBuyItemMessage = 16018

---高级回收面板请求
---ToServer
LuaEnumNetDef.ReqMostResyclePanelMessage = 16019

---高级回收面板下发
---store  ResMostResyclePanel
---ToClient
LuaEnumNetDef.ResMostResyclePanelMessage = 16020

---高级回收请求
---store  ReqMostResycle
---ToServer
LuaEnumNetDef.ReqMostResycleMessage = 16021

---高级赎回
---store  ReqMostRedeem
---ToServer
LuaEnumNetDef.ReqMostRedeemMessage = 16022

---合成记录
---store  CombineRecord
---ToClient
LuaEnumNetDef.ResCombineRecordMessage = 16023

---淬炼请求
---store  ReqCuiLian
---ToServer
LuaEnumNetDef.ReqCuiLianMessage = 16024

---淬炼返回
---store  ResCuiLian
---ToClient
LuaEnumNetDef.ResCuiLianMessage = 16025
--endregion

--region ID:18  wing
---请求光翼信息
---ToServer
LuaEnumNetDef.ReqWingInfoMessage = 18001

---发送光翼信息
---wing  ResWingInfo
---ToClient
LuaEnumNetDef.ResWingInfoMessage = 18002

---请求升级光翼
---wing  ReqLevelUpWing
---ToServer
LuaEnumNetDef.ReqLevelUpWingMessage = 18003

---返回升级光翼
---wing  ResLevelUpWing
---ToClient
LuaEnumNetDef.ResLevelUpWingMessage = 18004
--endregion

--region ID:21  count
---返回数量的列表
---count  ResCountData
---ToClient
LuaEnumNetDef.ResCountDataMessage = 21001

---返回数量变化的消息
---count  ResCountChange
---ToClient
LuaEnumNetDef.ResCountChangeMessage = 21002

---请求副本道具使用次数
---count  ReqGetInstanceItemUseCount
---ToServer
LuaEnumNetDef.ReqGetInstanceItemUseCountMessage = 21003

---道具共享使用上限(已使用次数)
---count  ResCountShareUsed
---ToClient
LuaEnumNetDef.ResCountShareUsedLimitMessage = 21004
--endregion

--region ID:23  union
---申请加入行会
---union  ReqApplyForEnterUnion
---ToServer
LuaEnumNetDef.ReqApplyForEnterUnionMessage = 23001

---申请入会状态变化
---union  ResApplyForUnionStateChange
---ToClient
LuaEnumNetDef.ResApplyForUnionStateChangeMessage = 23002

---发送行会列表信息
---union  ResSendAllUnionInfo
---ToClient
LuaEnumNetDef.ResSendAllUnionInfoMessage = 23003

---申请创建行会
---union  ReqCreateUnion
---ToServer
LuaEnumNetDef.ReqCreateUnionMessage = 23004

---发送玩家所在行会信息
---union  ResSendPlayerUnionInfo
---ToClient
LuaEnumNetDef.ResSendPlayerUnionInfoMessage = 23005

---申请修改公告
---union  ReqChangeAnnouncement
---ToServer
LuaEnumNetDef.ReqChangeAnnouncementMessage = 23006

---请求踢出玩家
---union  ReqKickOutMember
---ToServer
LuaEnumNetDef.ReqKickOutMemberMessage = 23007

---请求获取所有行会信息
---ToServer
LuaEnumNetDef.ReqGetAllUnionInfoMessage = 23008

---请求调整职位
---union  ReqChangePosition
---ToServer
LuaEnumNetDef.ReqChangePositionMessage = 23009

---请求获取玩家行会信息
---union  ReqGetPlayerUnionInfo
---ToServer
LuaEnumNetDef.ReqGetPlayerUnionInfoMessage = 23010

---请求获取申请入会列表信息
---union  ReqGetApplyListInfo
---ToServer
LuaEnumNetDef.ReqGetApplyListInfoMessage = 23011

---发送申请入会列表信息
---union  ResSendApplyListInfo
---ToClient
LuaEnumNetDef.ResSendApplyListInfoMessage = 23012

---请求捐赠金钱信息
---union  ReqDonateMoney
---ToServer
LuaEnumNetDef.ReqDonateMoneyMessage = 23013

---请求退出或者解散行会
---union  ReqQuitOrDissolveUnion
---ToServer
LuaEnumNetDef.ReqQuitOrDissolveUnionMessage = 23014

---发送退出行会成功信息
---union  ResSendQuitUnionSuccess
---ToClient
LuaEnumNetDef.ResSendQuitUnionSuccessMessage = 23015

---发送修改公告信息
---union  ResSendChangeAnnounce
---ToClient
LuaEnumNetDef.ResSendChangeAnnounceMessage = 23016

---发送调整职位信息
---union  ResSendChangePosition
---ToClient
LuaEnumNetDef.ResSendChangePositionMessage = 23017

---请求处理申请列表信息
---union  ReqCheckApplyList
---ToServer
LuaEnumNetDef.ReqCheckApplyListMessage = 23018

---获取行会积分
---ToServer
LuaEnumNetDef.ReqGetUnionActiveMessage = 23020

---发送行会活跃信息
---union  ResSendUnionActiveInfo
---ToClient
LuaEnumNetDef.ResSendUnionActiveInfoMessage = 23021

---获取行会活跃奖励信息
---union  ReqGetUnionActiveReward
---ToServer
LuaEnumNetDef.ReqGetUnionActiveRewardMessage = 23022

---请求设置行会按钮
---union  ReqUnionSetUp
---ToServer
LuaEnumNetDef.ReqUnionSetUpMessage = 23023

---发送行会设置信息
---union  ResSendUnionSetUp
---ToClient
LuaEnumNetDef.ResSendUnionSetUpMessage = 23024

---是否有奖励角标
---union  ResHasRewardInfo
---ToClient
LuaEnumNetDef.ResHasRewardInfoMessage = 23025

---是否有申请角标
---union  ResHasApplyInfo
---ToClient
LuaEnumNetDef.ResHasApplyInfoMessage = 23026

---请求获取行会boss信息
---ToServer
LuaEnumNetDef.ReqGetUnionBossInfoMessage = 23027

---发送行会BOSS信息
---union  ResSendUnionBossInfo
---ToClient
LuaEnumNetDef.ResSendUnionBossInfoMessage = 23028

---请求获取行会个人挑战信息
---ToServer
LuaEnumNetDef.ReqGetUnionPersonChallengetInfoMessage = 23029

---发送行会个人挑战信息
---union  ResSendUnionPersonChallengetInfo
---ToClient
LuaEnumNetDef.ResSendUnionPersonChallengetInfoMessage = 23030

---发送行会挑战下一关卡信息
---union  ResUnionChallengeNextInstance
---ToClient
LuaEnumNetDef.ResUnionChallengeNextInstanceMessage = 23031

---请求行会挑战排行
---ToServer
LuaEnumNetDef.ReqGetUnionChallengeRankMessage = 23032

---发送行会挑战排行信息
---union  ResSendUnionChallengetRank
---ToClient
LuaEnumNetDef.ResSendUnionChallengetRankMessage = 23033

---返回行会BOSS副本归属信息
---union  ResUnionInstanceOwner
---ToClient
LuaEnumNetDef.ResUnionInstanceOwnerMessage = 23034

---请求发送召唤公告
---ToServer
LuaEnumNetDef.ReqSendUnionAnnounceMessage = 23035

---发红包
---union  ReqSendUnionRedPack
---ToServer
LuaEnumNetDef.ReqSendUnionRedPackMessage = 23036

---抢红包
---union  ReqRobRedPack
---ToServer
LuaEnumNetDef.ReqRobRedPackMessage = 23037

---抢红包返回
---union  ResRobRedPack
---ToClient
LuaEnumNetDef.ResRobRedPackMessage = 23038

---打开红包面板
---ToServer
LuaEnumNetDef.ReqOpenRedPackPanelMessage = 23039

---红包面板数据
---union  ResOpenRedPackPanel
---ToClient
LuaEnumNetDef.ResOpenRedPackPanelMessage = 23040

---查看红包详情
---union  ReqRedPackDetail
---ToServer
LuaEnumNetDef.ReqRedPackDetailMessage = 23041

---领取行会挑战通关奖励
---ToServer
LuaEnumNetDef.ReqGetCrossRewardMessage = 23042

---发送可领取行会挑战通关奖励
---union  ResCanGetCrossReward
---ToClient
LuaEnumNetDef.ResCanGetCrossRewardMessage = 23043

---请求召唤行会boss（进入副本）
---union  ReqCallUnionBoss
---ToServer
LuaEnumNetDef.ReqCallUnionBossMessage = 23044

---请求挑战行会boss（进入副本）
---union  ReqEnterUnionBoss
---ToServer
LuaEnumNetDef.ReqEnterUnionBossMessage = 23045

---请求重置行會挑戰
---ToServer
LuaEnumNetDef.ReqResetUnionChallengeMessage = 23046

---请求重置行會挑戰
---union  ResUnionRedPackInfo
---ToClient
LuaEnumNetDef.ResUnionRedPackInfoMessage = 23047

---请求行会挑战通关奖励信息
---ToServer
LuaEnumNetDef.ReqUnionChallengeCrossRewardInfoMessage = 23048

---请求弹劾会长
---union  ReqImpeachLeader
---ToServer
LuaEnumNetDef.ReqImpeachLeaderMessage = 23049

---请求修改行会名字
---union  ReqChangeUnionName
---ToServer
LuaEnumNetDef.ReqChangeUnionNameMessage = 23050

---一键申请入帮
---ToServer
LuaEnumNetDef.ReqOneKeyApplyForUnionMessage = 23051

---发送召唤公告
---union  ResSendUnionAnnounceResult
---ToClient
LuaEnumNetDef.ResSendUnionAnnounceResultMessage = 23052

---发送图腾信息
---union  ResTotemInfo
---ToClient
LuaEnumNetDef.ResTotemInfoMessage = 23053

---请求升级行会图腾
---union  ReqLevelUpUnionTotem
---ToServer
LuaEnumNetDef.ReqLevelUpUnionTotemMessage = 23054

---返回升级行会图腾信息
---union  ResLevelUpUnionTotem
---ToClient
LuaEnumNetDef.ResLevelUpUnionTotemMessage = 23055

---请求内推玩家加入行会
---union  ReqInviteForEnterUnion
---ToServer
LuaEnumNetDef.ReqInviteForEnterUnionMessage = 23056

---发送内推信息至被邀请者
---union  ResInviteForEnterUnion
---ToClient
LuaEnumNetDef.ResInviteForEnterUnionMessage = 23057

---同意内推加入行会
---union  ReqAgreeUnionInvite
---ToServer
LuaEnumNetDef.ReqAgreeUnionInviteMessage = 23058

---申请解散行会
---ToServer
LuaEnumNetDef.ReqDissolveUnionMessage = 23059

---返回解散行会
---union  ResDissolveUnion
---ToClient
LuaEnumNetDef.ResDissolveUnionMessage = 23060

---请求仓库背包信息
---ToServer
LuaEnumNetDef.ReqUnionWarehouseInfoMessage = 23061

---返回请求行会仓库
---union  ResUnionWarehouseInfo
---ToClient
LuaEnumNetDef.ResUnionWarehouseInfoMessage = 23062

---请求捐献装备
---union  ReqDonateEquip
---ToServer
LuaEnumNetDef.ReqDonateEquipMessage = 23063

---请求兑换装备
---union  ReqConversionEquip
---ToServer
LuaEnumNetDef.ReqConversionEquipMessage = 23065

---行会领导请求销毁装备
---union  ReqDestoryEquip
---ToServer
LuaEnumNetDef.ReqDestoryEquipMessage = 23067

---请求行会仓库日志记录
---ToServer
LuaEnumNetDef.ReqIntegralMessage = 23069

---返回行会仓库日志记录
---union  ResIntegral
---ToClient
LuaEnumNetDef.ResIntegralMessage = 23070

---返回成功创建行会信息
---union  ResSendCreateUnionSuccess
---ToClient
LuaEnumNetDef.ResSendCreateUnionSuccessMessage = 23071

---返回捐赠金钱信息
---union  ResDonateMoney
---ToClient
LuaEnumNetDef.ResDonateMoneyMessage = 23072

---请求行会信息列表
---union  ReqSendAllUnionInfo
---ToServer
LuaEnumNetDef.ReqSendAllUnionInfoMessage = 23073

---发送行会升级信息
---union  ResUnionUpGrade
---ToClient
LuaEnumNetDef.ResUnionUpGradeMessage = 23074

---请求在线会长的行会列表
---union  ReqGetAssistantOnlineUnionInfo
---ToServer
LuaEnumNetDef.ReqGetAssistantOnlineUnionInfoMessage = 23075

---请求行会成员列表
---union  ReqUnionMemberInfo
---ToServer
LuaEnumNetDef.ReqUnionMemberInfoMessage = 23076

---返回行会成员列表
---union  ResUnionMemberInfo
---ToClient
LuaEnumNetDef.ResUnionMemberInfoMessage = 23077

---移除行会黑名单
---union  ReqRemoveBlackApplyRole
---ToServer
LuaEnumNetDef.ReqRemoveBlackApplyRoleMessage = 23078

---一键忽略玩家入会申请
---union  ReqIgnoreAllRole
---ToServer
LuaEnumNetDef.ReqIgnoreAllRoleMessage = 23079

---一键同意玩家入会申请
---union  ReqAgreeAllRoleJoinUnion
---ToServer
LuaEnumNetDef.ReqAgreeAllRoleJoinUnionMessage = 23080

---请求拉黑的玩家列表
---union  ReqGetBlackApplyRole
---ToServer
LuaEnumNetDef.ReqGetBlackApplyRoleMessage = 23081

---返回拉黑的玩家列表
---union  ResGetBlackApplyRole
---ToClient
LuaEnumNetDef.ResGetBlackApplyRoleMessage = 23082

---仅显示在线成员
---union  ReqGetOnlineMember
---ToServer
LuaEnumNetDef.ReqGetOnlineMemberMessage = 23083

---踢出公会
---union  ReqKickOutGuild
---ToServer
LuaEnumNetDef.ReqKickOutGuildMessage = 23084

---返回被T的人的公会ID和名字
---union  ResKickOutGuild
---ToClient
LuaEnumNetDef.ResKickOutGuildMessage = 23085

---进行投票
---union  ReqImpeachmentInfo
---ToServer
LuaEnumNetDef.ReqImpeachmentInfoMessage = 23086

---请求查看弹劾票行
---union  ReqImpeachmentVote
---ToServer
LuaEnumNetDef.ReqImpeachmentVoteMessage = 23087

---返回弹劾票行
---union  ResImpeachmentVote
---ToClient
LuaEnumNetDef.ResImpeachmentVoteMessage = 23088

---请求获取仓库列表
---union  ReqGetUnionItems
---ToServer
LuaEnumNetDef.ReqGetUnionItemsMessage = 23089

---请求设置自动加入
---union  ReqAutomaticPassing
---ToServer
LuaEnumNetDef.ReqAutomaticPassingMessage = 23090

---行会改变消息
---union  ResTheUnionChange
---ToClient
LuaEnumNetDef.ResTheUnionChangeMessage = 23091

---行会改变向周围玩家发送消息
---union  ResUnionNameChange
---ToClient
LuaEnumNetDef.ResUnionNameChangeMessage = 23092

---请求所有会徽
---union  ReqGetAllUnionIcon
---ToServer
LuaEnumNetDef.ReqGetAllUnionIconMessage = 23093

---返回所有会徽
---union  ResGetAllUnionIcon
---ToClient
LuaEnumNetDef.ResGetAllUnionIconMessage = 23094

---加入行会申请或撤销加入行会申请
---union  ReqJoinOrWithdrawUnion
---ToServer
LuaEnumNetDef.ReqJoinOrWithdrawUnionMessage = 23095

---请求日志
---union  ReqGetUnionJournal
---ToServer
LuaEnumNetDef.ReqGetUnionJournalMessage = 23096

---返回日志
---union  ResGetUnionJournal
---ToClient
LuaEnumNetDef.ResGetUnionJournalMessage = 23097

---请求查看行会属性
---union  ReqGetUnionAttribute
---ToServer
LuaEnumNetDef.ReqGetUnionAttributeMessage = 23098

---返回行会属性
---union  ResGetUnionAttribute
---ToClient
LuaEnumNetDef.ResGetUnionAttributeMessage = 23099

---请求转让会长
---union  ReqAssignmentMonster
---ToServer
LuaEnumNetDef.ReqAssignmentMonsterMessage = 23100

---收到了请求转让会长消息
---union  GetAssignment
---ToClient
LuaEnumNetDef.GetAssignmentMessage = 23101

---发送消息处理确认转让会长
---union  YesGetUnionMonster
---ToServer
LuaEnumNetDef.YesGetUnionMonsterMessage = 23102

---发给双方转让会长处理的消息
---union  HandlingSuccess
---ToClient
LuaEnumNetDef.HandlingSuccessMessage = 23103

---请求行会升级
---union  ReqUnionUpgrade
---ToServer
LuaEnumNetDef.ReqUnionUpgradeMessage = 23104

---请求仓库一个格子的所有数据
---union  ReqGetBagItemInfo
---ToServer
LuaEnumNetDef.ReqGetBagItemInfoMessage = 23105

---返回行会仓库一个格子的所有数据
---union  ResGetBagItemInfo
---ToClient
LuaEnumNetDef.ResGetBagItemInfoMessage = 23106

---请求改变行会图腾
---union  ReqUnionBadgeReplace
---ToServer
LuaEnumNetDef.ReqUnionBadgeReplaceMessage = 23107

---请求改变行会升级的红点提示
---union  ReqUpdateUnionUpgradeRedPoint
---ToServer
LuaEnumNetDef.ReqUpdateUnionUpgradeRedPointMessage = 23108

---请求改变行会召唤令的使用职位
---union  ReqUpdateUnionCallBackUsePosition
---ToServer
LuaEnumNetDef.ReqUpdateUnionCallBackUsePositionMessage = 23109

---会长选举请求参选
---ToServer
LuaEnumNetDef.ReqJoinElectionMessage = 23110

---会长选举投票请求
---union  ReqElectionVote
---ToServer
LuaEnumNetDef.ReqElectionVoteMessage = 23111

---请求合并
---union  ReqCombineUnion
---ToServer
LuaEnumNetDef.ReqCombineUnionMessage = 23112

---请求合并响应
---union  ResApplyCombineUnion
---ToClient
LuaEnumNetDef.ResApplyCombineUnionMessage = 23113

---确认合并
---union  ReqConfirmCombineUnion
---ToServer
LuaEnumNetDef.ReqConfirmCombineUnionMessage = 23114

---请求战利品仓库
---ToServer
LuaEnumNetDef.ReqSpoilsHouseMessage = 23115

---返回战利品仓库
---union  ResSpoilsHouse
---ToClient
LuaEnumNetDef.ResSpoilsHouseMessage = 23116

---请求发放战利品
---union  ReqGiveSpoils
---ToServer
LuaEnumNetDef.ReqGiveSpoilsMessage = 23117

---战利品仓库更新消息
---union  ResSpoilsHouseUpdate
---ToClient
LuaEnumNetDef.ResSpoilsHouseUpdateMessage = 23118

---请求可发放战利品的成员列表
---ToServer
LuaEnumNetDef.ReqCanGetSpoilsMembersMessage = 23119

---返回可发放战利品的成员列表
---union  ResCanGetSpoilsMembers
---ToClient
LuaEnumNetDef.ResCanGetSpoilsMembersMessage = 23120

---领取占领城市的税收
---ToServer
LuaEnumNetDef.ReqReceiveSeizeCityTaxMessage = 23121

---更新行会今天的税收
---union  updateTodayCityTax
---ToClient
LuaEnumNetDef.ResUpdateTodayCityTaxMessage = 23122

---一键招人请求
---ToServer
LuaEnumNetDef.ReqOneKeyRecruitMessage = 23123

---语音权限信息
---union  UnionVoiceStatus
---ToClient
LuaEnumNetDef.ResUnionVoiceStatusMessage = 23124

---会长切换语音权限
---union  ReqToggleSendVoice
---ToServer
LuaEnumNetDef.ReqToggleSendVoiceMessage = 23125

---切换语音开关
---union  ReqToggleVoiceOpen
---ToServer
LuaEnumNetDef.ReqToggleVoiceOpenMessage = 23126

---新行会消息
---union  ResUnionChatAnnounce
---ToClient
LuaEnumNetDef.ResUnionChatAnnounceMessage = 23127

---魔法阵开始
---union  ResMagicCircleStart
---ToClient
LuaEnumNetDef.ResMagicCircleStartMessage = 23128

---魔法阵信息
---ToServer
LuaEnumNetDef.ReqMagicCircleInfoMessage = 23129

---魔法阵信息
---union  ResMagicCircleInfo
---ToClient
LuaEnumNetDef.ResMagicCircleInfoMessage = 23130

---请求红包信息
---union  ReqUnionRedBagInfo
---ToServer
LuaEnumNetDef.ReqUnionRedBagInfoMessage = 23131

---红包信息响应
---union  ResUnionRedBagInfo
---ToClient
LuaEnumNetDef.ResUnionRedBagInfoMessage = 23132

---发送红包
---union  ReqSendRedBag
---ToServer
LuaEnumNetDef.ReqUnionSendRedBagMessage = 23133

---领取红包
---union  ReqRecieveUnionRedBag
---ToServer
LuaEnumNetDef.ReqRecieveUnionRedBagMessage = 23134

---切换喇叭状态
---ToServer
LuaEnumNetDef.ReqToggleSpeakerMessage = 23135

---行会成员喇叭状态
---union  ResUnionSpeakerStatus
---ToClient
LuaEnumNetDef.ResUnionSpeakerStatusMessage = 23136

---请求帮会召唤令信息
---ToServer
LuaEnumNetDef.ReqUnionCallBackInfoMessage = 23137

---响应帮会召唤令信息
---union  ResUnionCallBackInfo
---ToClient
LuaEnumNetDef.ResUnionCallBackInfoMessage = 23138

---魔法阵boss召唤
---ToClient
LuaEnumNetDef.ResUnionMagicCallBossMessage = 23139

---魔法阵boss积分排行
---union  ResUnionMagicBossRank
---ToClient
LuaEnumNetDef.ResUnionMagicBossRankMessage = 23140

---更新代理会长职位
---union  ResUpdateAgencyChairman
---ToClient
LuaEnumNetDef.ResUpdateAgencyChairmanMessage = 23141

---请求查看行会复仇
---ToServer
LuaEnumNetDef.ReqToViewUnionRevengeMessage = 23142

---返回查看行会复仇
---union  ResToViewUnionRevenge
---ToClient
LuaEnumNetDef.ResToViewUnionRevengeMessage = 23143

---行会复仇请求领奖
---union  ReqRewardUnionRevenge
---ToServer
LuaEnumNetDef.ReqRewardUnionRevengeMessage = 23144

---行会复仇领奖返回
---union  ResRewardUnionRevenge
---ToClient
LuaEnumNetDef.ResRewardUnionRevengeMessage = 23145

---刷新一个行会仇人
---union  ResAddUnionRevenge
---ToClient
LuaEnumNetDef.ResAddUnionRevengeMessage = 23146

---消耗元宝请求定位仇人位置
---union  ReqGetRevengePoint
---ToServer
LuaEnumNetDef.ReqGetRevengePointMessage = 23147

---返回仇人位置
---union  ResGetRevengePoint
---ToClient
LuaEnumNetDef.ResGetRevengePointMessage = 23148

---联服同盟投票
---union  WillJoinUniteUnionInfo
---ToServer
LuaEnumNetDef.ReqWillJoinUniteUnionMessage = 23149

---返回所有联服同盟投票
---union  AllWillJoinUniteUnion
---ToClient
LuaEnumNetDef.ResAllWillJoinUniteUnionMessage = 23150

---请求所有联服同盟投票
---ToServer
LuaEnumNetDef.ReqAllWillJoinUniteUnionMessage = 23151

---请求所有服所有联服同盟投票
---ToServer
LuaEnumNetDef.ReqAllOtherWillJoinUniteUnionMessage = 23152

---返回所有服所有联服同盟投票
---union  OtherAllUniteUnionVoteInfo
---ToClient
LuaEnumNetDef.ResAllOtherWillJoinUniteUnionMessage = 23153

---返回个人排行榜,进副本就推,
---union  UnionBossPlayerRankInfo
---ToClient
LuaEnumNetDef.ResUnionBossPlayerRankInfoMessage = 23154

---返回公会排行榜, 进副本就推
---union  UnionBossUnionRankInfo
---ToClient
LuaEnumNetDef.ResUnionBossUnionRankInfoMessage = 23155

---请求鼓舞buff的信息
---ToServer
LuaEnumNetDef.ReqUnionBossBuffInfoMessage = 23156

---返回鼓舞buff的信息
---union  UnionBossBuffInfo
---ToClient
LuaEnumNetDef.ResUnionBossBuffInfoMessage = 23157

---花钱鼓舞
---union  UnionBossAddBuff
---ToServer
LuaEnumNetDef.ReqUnionBossAddBuffMessage = 23158

---用于客户端进入场景请求排行榜
---ToServer
LuaEnumNetDef.ReqUnionBossRankMessage = 23159
--endregion

--region ID:26  rank
---请求查看排行榜
---rank  ReqLookRank
---ToServer
LuaEnumNetDef.ReqLookRankMessage = 26001

---排行榜数据
---rank  ResLookRank
---ToClient
LuaEnumNetDef.ResLookRankMessage = 26002

---请求排行奖励信息
---rank  ReqRankRewardInfo
---ToServer
LuaEnumNetDef.ReqRankRewardInfoMessage = 26003

---发送排行奖励信息
---rank  ResRankRewardInfo
---ToClient
LuaEnumNetDef.ResRankRewardInfoMessage = 26004

---领取排行奖励
---rank  ReqReceiveReward
---ToServer
LuaEnumNetDef.ReqReceiveRewardMessage = 26005

---发送未领取奖励的排行列表
---rank  ResUnRewardRankTypes
---ToClient
LuaEnumNetDef.ResUnRewardRankTypesMessage = 26006

---请求排行榜详情
---rank  ReqRankDetail
---ToServer
LuaEnumNetDef.ReqRankDetailMessage = 26007

---战损榜详情响应
---rank  DamageItemRankInfo
---ToClient
LuaEnumNetDef.ResBattleDamageRankDatailMessage = 26008

---共享服请求查看排行榜
---rank  ReqLookRank
---ToServer
LuaEnumNetDef.ReqShareLookRankMessage = 26009

---排行榜数据
---rank  ResLookRank
---ToClient
LuaEnumNetDef.ResShareLookRankMessage = 26010
--endregion

--region ID:27  welfare
---请求签到信息
---ToServer
LuaEnumNetDef.ReqSignInfoMessage = 27001

---发送签到信息
---welfare  ResSignInfo
---ToClient
LuaEnumNetDef.ResSignInfoMessage = 27002

---请求签到领奖
---ToServer
LuaEnumNetDef.ReqGetSignRewardMessage = 27003

---请求cdkey领奖
---welfare  ReqCdkeyReward
---ToServer
LuaEnumNetDef.ReqCdkeyRewardMessage = 27004

---返回cdkey领奖结果
---welfare  ResCdkeyReward
---ToClient
LuaEnumNetDef.ResCdkeyRewardMessage = 27005

---请求领取累计签到天数奖励
---welfare  ReqDrawSummaryDayReward
---ToServer
LuaEnumNetDef.ReqDrawSummaryDayRewardMessage = 27006

---请求七天奖励信息
---ToServer
LuaEnumNetDef.ReqSevenDaysInfoMessage = 27007

---发送七天奖励信息
---welfare  ResSevenDaysInfo
---ToClient
LuaEnumNetDef.ResSevenDaysInfoMessage = 27008

---请求领取七天奖励
---welfare  ReqDrawSevenDays
---ToServer
LuaEnumNetDef.ReqDrawSevenDaysMessage = 27009

---在线奖励信息请求
---ToServer
LuaEnumNetDef.ReqOnlineRewardInfoMessage = 27010

---在线奖励领取请求
---welfare  OnlineRewardRequest
---ToServer
LuaEnumNetDef.ReqOnlineRewardMessage = 27011

---在线奖励领取响应
---welfare  OnlineRewardMsg
---ToClient
LuaEnumNetDef.ResOnlineRewardMessage = 27012

---每周在线礼券奖励请求
---ToServer
LuaEnumNetDef.ReqOnlineLiquanMessage = 27013

---请求奖励大厅信息
---welfare  GetRewardHall
---ToServer
LuaEnumNetDef.ReqGetRewardHallMessage = 27014

---发送奖励大厅信息
---welfare  RewardHall
---ToClient
LuaEnumNetDef.ResGetRewardHallMessage = 27015

---领取定时奖励
---welfare  TimingRewardRequest
---ToServer
LuaEnumNetDef.ReqTimingRewardMessage = 27016

---定时奖励信息
---welfare  TimingReward
---ToClient
LuaEnumNetDef.ResTimmngRewardInfoMessage = 27017

---请求定时奖励信息
---welfare  TimmngRewardInfo
---ToServer
LuaEnumNetDef.ReqTimmngRewardInfoMessage = 27018

---请求领取等级奖励
---welfare  GetLevelPacks
---ToServer
LuaEnumNetDef.ReqGetLevelPacksMessage = 27019

---等级奖励信息
---welfare  LevelPacksInfo
---ToClient
LuaEnumNetDef.ResLevelPacksInfoMessage = 27020

---请求领取等级奖励信息
---welfare  GetLevelPacksInfo
---ToServer
LuaEnumNetDef.ReqGetLevelPacksInfoMessage = 27021

---请求领取最后一个灵兽格子
---welfare  GetServantGrid
---ToServer
LuaEnumNetDef.ReqGetServantGridMessage = 27022
--endregion

--region ID:28  vip
---请求领取vip礼包
---vip  ReqBuyVipReward
---ToServer
LuaEnumNetDef.ReqBuyVipRewardMessage = 28004

---通知玩家vip等级发生变化
---vip  ResRoleVipInfoChange
---ToClient
LuaEnumNetDef.ResRoleVipInfoChangeMessage = 28005

---vip数据
---vip  ResRoleVipInfo
---ToClient
LuaEnumNetDef.ResRoleVipInfoMessage = 28006

---vip领过的数据
---vip  ResBuyVipReward
---ToClient
LuaEnumNetDef.ResBuyVipRewardMessage = 28007

---vip领过的数据
---vip  ResFreeVipReward
---ToClient
LuaEnumNetDef.ResFreeVipRewardMessage = 28008

---请求vip数据
---ToServer
LuaEnumNetDef.ReqVipInfoMessage = 28009

---请求购买月卡
---vip  CardId
---ToServer
LuaEnumNetDef.ReqBuyMonthCardMessage = 28010

---请求商会界面
---vip  CardKind
---ToServer
LuaEnumNetDef.ReqMonthCardPanelMessage = 28011

---返回商会界面
---vip  ResCardPanel
---ToClient
LuaEnumNetDef.ResMonthCardPanelMessage = 28012

---返回月卡信息
---vip  ResCardInfo
---ToClient
LuaEnumNetDef.ResMonthCardInfoMessage = 28013

---请求领取月卡每日福利
---vip  CardId
---ToServer
LuaEnumNetDef.ReqReceiveCardDayRewardMessage = 28014

---返回月卡改变
---vip  ResCardChange
---ToClient
LuaEnumNetDef.ResMonthCardChangeMessage = 28015

---请求月卡福利详情
---vip  CardId
---ToServer
LuaEnumNetDef.ReqCardDayRewardInfoMessage = 28016

---返回月卡福利详情
---vip  ResCardDayRewardInfo
---ToClient
LuaEnumNetDef.ResCardDayRewardInfoMessage = 28017

---返回使用月卡道具
---ToClient
LuaEnumNetDef.ResUseMonthCardItemMessage = 28018

---通知玩家vip2等级发生变化
---vip  ResRoleVip2InfoChange
---ToClient
LuaEnumNetDef.ResRoleVip2InfoChangeMessage = 28019

---vip2数据
---vip  ResRoleVip2Info
---ToClient
LuaEnumNetDef.ResRoleVip2InfoMessage = 28020

---请求超级会员数据
---ToServer
LuaEnumNetDef.ReqVipMemberInfoMessage = 28021

---返回超级会员数据
---vip  VipMemberInfo
---ToClient
LuaEnumNetDef.ResVipMemberInfoMessage = 28022

---领取等级奖励
---vip  VipMemberReveiveLevelReward
---ToServer
LuaEnumNetDef.ReqVipMemberLevelRewardMessage = 28024

---领取每日奖励
---ToServer
LuaEnumNetDef.ReqVipMemberDailyRewardMessage = 28025
--endregion

--region ID:30  boss
---请求副本面板信息(通用)
---boss  ReqInstancePanelInfo
---ToServer
LuaEnumNetDef.ReqInstancePanelInfoMessage = 30001

---个人BOSS面板信息
---boss  ResPersonalBossInfo
---ToClient
LuaEnumNetDef.ResPersonalBossInfoMessage = 30002

---请求拾取主线boss奖励
---ToServer
LuaEnumNetDef.ReqPickUpMainTaskBossMessage = 30009

---请求扫荡个人副本
---boss  ReqSwapPersonalBoss
---ToServer
LuaEnumNetDef.ReqSwapPersonalBossMessage = 30011

---发送boss活动开启信息
---boss  ResBossActivityOpen
---ToClient
LuaEnumNetDef.ResBossActivityOpenMessage = 30015

---请求野外boss开启信息
---boss  ReqFieldBossInfo
---ToServer
LuaEnumNetDef.ReqFieldBossOpenMessage = 30016

---发送野外boss开启信息
---boss  ResFieldBossInfo
---ToClient
LuaEnumNetDef.ResFieldBossOpenMessage = 30017

---打开小地图请求
---ToServer
LuaEnumNetDef.ReqMinMapMessage = 30018

---打开小地图返回信息
---boss  ResMinMapInfo
---ToClient
LuaEnumNetDef.ResMinMapMessage = 30019

---请求boss信息
---boss  ReqGetBossInfo
---ToServer
LuaEnumNetDef.ReqGetBossInfoMessage = 30020

---boss信息响应
---boss  ResGetBossInfo
---ToClient
LuaEnumNetDef.ResGetBossInfoMessage = 30021

---boss刷新提示
---boss  ResBossRefresh
---ToClient
LuaEnumNetDef.ResBossRefreshMessage = 30022

---请求远古 boss 伤害排行
---boss  ReqAncientBossDamageRank
---ToServer
LuaEnumNetDef.ReqAncientBossDamageRankMessage = 30023

---远古 boss 伤害排行响应
---boss  ResAncientBossDamageRank
---ToClient
LuaEnumNetDef.ResAncientBossDamageRankMessage = 30024

---boss 死亡响应
---boss  ResBossDie
---ToClient
LuaEnumNetDef.ResBossDieMessage = 30025

---是否有远古 boss 存活
---boss  ResHasAncientBossAlive
---ToClient
LuaEnumNetDef.ResHasAncientBossAliveMessage = 30026

---boss面板魔之boss红点
---boss  RefreshDemonBossInfo
---ToClient
LuaEnumNetDef.RefreshDemonBossInfoMessage = 30027

---请求联服远古 boss 伤害排行
---boss  ReqAncientBossDamageRank
---ToServer
LuaEnumNetDef.ReqShareAncientBossDamageRankMessage = 30028

---请求远古 boss 伤害排行
---boss  ReqAncientBossDamageRank
---ToServer
LuaEnumNetDef.ReqAncientBossDamageRankV2Message = 30029

---请求天魔boss信息
---ToServer
LuaEnumNetDef.ReqOmenComeBossInfoMessage = 30030

---返回天魔boss信息
---boss  ResOmenComeBossInfo
---ToClient
LuaEnumNetDef.ResOmenComeBossInfoMessage = 30031

---请求使用扫荡券
---boss  ReqUseMonsterCleanUpCoupons
---ToServer
LuaEnumNetDef.ReqUseMonsterCleanUpCouponsMessage = 30032
--endregion

--region ID:33  title
---请求称号列表信息
---ToServer
LuaEnumNetDef.ReqTitleListMessage = 33001

---发送称号列表信息
---title  ResTitleList
---ToClient
LuaEnumNetDef.ResTitleListMessage = 33002

---获得称号
---title  TitleInfo
---ToClient
LuaEnumNetDef.ResAddTitleMessage = 33003

---移除称号
---title  ResRemoveTitle
---ToClient
LuaEnumNetDef.ResRemoveTitleMessage = 33004

---请求佩戴称号
---title  ReqPutOnTitle
---ToServer
LuaEnumNetDef.ReqPutOnTitleMessage = 33005

---返回佩戴称号
---title  ResPutOnTitle
---ToClient
LuaEnumNetDef.ResPutOnTitleMessage = 33006

---请求脱下称号
---title  ReqPutOffTitle
---ToServer
LuaEnumNetDef.ReqPutOffTitleMessage = 33007

---返回脱下称号
---title  ResPutOffTitle
---ToClient
LuaEnumNetDef.ResPutOffTitleMessage = 33008
--endregion

--region ID:34  fcm
---认证状态
---fcm  ResAuthorityState
---ToClient
LuaEnumNetDef.ResAuthorityStateMessage = 34001

---请求认证
---fcm  ReqAuthority
---ToServer
LuaEnumNetDef.ReqAuthorityMessage = 34002

---防沉迷状态 1-5对应小时
---fcm  ResFcmState
---ToClient
LuaEnumNetDef.ResFcmStateMessage = 34003
--endregion

--region ID:36  mail
---获取邮件列表请求
---ToServer
LuaEnumNetDef.ReqGetMailListMessage = 36001

---邮件列表响应
---mail  MailList
---ToClient
LuaEnumNetDef.ResMailListMessage = 36002

---新邮件响应
---mail  MsgRemind
---ToClient
LuaEnumNetDef.ResNewMailMessage = 36003

---标记为已读请求
---mail  MailIdMsg
---ToServer
LuaEnumNetDef.ReqReadMailMessage = 36004

---提取物品请求
---mail  MailIdMsg
---ToServer
LuaEnumNetDef.ReqGetMailItemMessage = 36005

---提取物品响应
---mail  MailIdMsg
---ToClient
LuaEnumNetDef.ResGetMailItemMessage = 36006

---删除邮件请求
---mail  MailIdMsg
---ToServer
LuaEnumNetDef.ReqDeleteMailMessage = 36007

---删除邮件响应
---mail  MailIdMsg
---ToClient
LuaEnumNetDef.ResDeleteMailMessage = 36008
--endregion

--region ID:39  recharge
---获取充值界面信息
---ToServer
LuaEnumNetDef.ReqGetRechargeInfoMessage = 39001

---发送充值界面信息
---recharge  ResSendRechargeInfo
---ToClient
LuaEnumNetDef.ResSendRechargeInfoMessage = 39002

---请求领取累计(首充)奖励
---ToServer
LuaEnumNetDef.ReqTotalRechargeRewardMessage = 39003

---请求领取每日充值奖励
---ToServer
LuaEnumNetDef.ReqGetDayRechargeRewardMessage = 39005

---充值成功的消息
---ToClient
LuaEnumNetDef.ResRechargeSuccessMessage = 39007

---充值惊喜消息
---recharge  ResSendRechargeSurprise
---ToClient
LuaEnumNetDef.ResSendRechargeSurpriseMessage = 39008

---请求领取充值惊喜奖励
---ToServer
LuaEnumNetDef.ReqGetRechargeSurpriseRewardMessage = 39009

---请求领取限时直购奖励
---recharge  ReqGetThroughRechargeReward
---ToServer
LuaEnumNetDef.ReqGetThroughRechargeRewardMessage = 39010

---限时直购消息
---recharge  ResSendThroughRecharge
---ToClient
LuaEnumNetDef.ResSendThroughRechargeMessage = 39011

---请求领取返利充值奖励
---recharge  ReqGetBackRechargeReward
---ToServer
LuaEnumNetDef.ReqGetBackRechargeRewardMessage = 39012

---返回返利充值信息
---recharge  ResBackRechargeInfo
---ToClient
LuaEnumNetDef.ResBackRechargeInfoMessage = 39013

---充值入口
---recharge  ReqRechargeEntrance
---ToServer
LuaEnumNetDef.ReqRechargeEntranceMessage = 39014

---领取首充奖励
---recharge  ReqFirstRechargeReward
---ToServer
LuaEnumNetDef.ReqGetFirstRechargeRewardMessage = 39015

---发送终身限购列表
---recharge  ResLimitGiftBox
---ToClient
LuaEnumNetDef.ResLimitGiftBoxMessage = 39016

---完成首充的时间
---recharge  ResCompleteFirstChargeTime
---ToClient
LuaEnumNetDef.ResCompleteFirstChargeTimeMessage = 39017

---请求消除红点
---ToServer
LuaEnumNetDef.ReqClearFirstChargeRedPointMessage = 39018

---请求购买投资计划
---recharge  ReqBuyInvestPlanRequest
---ToServer
LuaEnumNetDef.ReqBuyInvestPlanMessage = 39019

---领取投资奖励
---recharge  ReqReceiveInvestRequest
---ToServer
LuaEnumNetDef.ReqReceiveInvestMessage = 39020

---返回投资计划数据
---recharge  ResInvestPlanData
---ToClient
LuaEnumNetDef.ResInvestPlanDataMessage = 39021

---请求投资计划数据
---ToServer
LuaEnumNetDef.ReqInvestPlanDataMessage = 39022

---请求某期投资计划数据
---recharge  ReqGetInvestPlanRequest
---ToServer
LuaEnumNetDef.ReqInvestPlanInfoMessage = 39023

---返回某期投资计划数据
---recharge  ResInvestPlanInfo
---ToClient
LuaEnumNetDef.ResInvestPlanInfoMessage = 39024

---领取累计充值奖励
---recharge  ReqReceiveCumRechargeRequest
---ToServer
LuaEnumNetDef.ReqReceiveCumRechargeMessage = 39025

---返回累计充值数据
---recharge  ResCumRechargeData
---ToClient
LuaEnumNetDef.ResCumRechargeDataMessage = 39026

---请求累计充值数据
---ToServer
LuaEnumNetDef.ReqCumRechargeDataMessage = 39027

---请求某期累计充值数据
---recharge  ReqGetCumRechargeRequest
---ToServer
LuaEnumNetDef.ReqCumRechargeInfoMessage = 39028

---返回某期累计充值数据
---recharge  ResCumChargeInfo
---ToClient
LuaEnumNetDef.ResCumChargeInfoMessage = 39029

---请求已经领取的首冲赠送
---ToServer
LuaEnumNetDef.ReqFirstRechargeGiveMessage = 39030

---返回已经领取的首冲赠送
---recharge  FirstRechargeGive
---ToClient
LuaEnumNetDef.ResFirstRechargeGiveMessage = 39031

---返回累计充值是否更新
---recharge  RewardState
---ToClient
LuaEnumNetDef.ResIfCumRechargeUpdateMessage = 39032

---检测累计充值是否有奖励可领
---ToServer
LuaEnumNetDef.ReqCumRechargeCanReceiveMessage = 39033

---检测累计充值是否开启
---recharge  CumChargeOpen
---ToClient
LuaEnumNetDef.ResCumChargeOpenMessage = 39034

---激活某一类型的时装投资
---recharge  ReqActiveFashionInvest
---ToServer
LuaEnumNetDef.ReqActiveFashionInvestMessage = 39035

---返回某一类型的时装投资数据
---recharge  ResFashionInvest
---ToClient
LuaEnumNetDef.ResFashionInvestMessage = 39036

---返回时装投资数据
---recharge  ResFashionInvestInfo
---ToClient
LuaEnumNetDef.ResFashionInvestInfoMessage = 39037

---领取时装投资奖励
---recharge  ReqReceiveFashionInvest
---ToServer
LuaEnumNetDef.ReqReceiveFashionInvestMessage = 39038

---时装投资红点包
---recharge  RewardState
---ToClient
LuaEnumNetDef.ResRedPointFashionInvestMessage = 39039
--endregion

--region ID:48  lingshou
---发送灵兽信息
---lingshou  ResLingShouInfo
---ToClient
LuaEnumNetDef.ResLingShouInfoMessage = 48001

---请求升级灵兽
---lingshou  ReqLevelUpLingShou
---ToServer
LuaEnumNetDef.ReqLevelUpLingShouMessage = 48002

---返回升级灵兽
---lingshou  ResLevelUpLingShou
---ToClient
LuaEnumNetDef.ResLevelUpLingShouMessage = 48003

---请求升级资质
---lingshou  ReqLevelUpLingShouTalent
---ToServer
LuaEnumNetDef.ReqLevelUpLingShouTalentMessage = 48004

---返回升级资质
---lingshou  ResLevelUpLingShouTalent
---ToClient
LuaEnumNetDef.ResLevelUpLingShouTalentMessage = 48005

---请求穿戴灵兽装备
---lingshou  ReqPutOnLingShouEquip
---ToServer
LuaEnumNetDef.ReqPutOnLingShouEquipMessage = 48006

---返回灵兽装备改变
---lingshou  ResLingShouEquipChange
---ToClient
LuaEnumNetDef.ResLingShouEquipChangeMessage = 48007

---请求脱下灵兽装备
---lingshou  ReqPutOffLingShouEquip
---ToServer
LuaEnumNetDef.ReqPutOffLingShouEquipMessage = 48008

---请求换肤
---lingshou  ReqPutOnSkin
---ToServer
LuaEnumNetDef.ReqPutOnSkinMessage = 48009

---返回皮肤改变
---lingshou  ResSkinChange
---ToClient
LuaEnumNetDef.ResSkinChangeMessage = 48010

---请求脱下皮肤
---lingshou  ReqPutOffLingSkin
---ToServer
LuaEnumNetDef.ReqPutOffLingSkinMessage = 48011

---请求激活灵兽
---lingshou  ReqActivateLingShou
---ToServer
LuaEnumNetDef.ReqActivateLingShouMessage = 48012

---请求升级天赋
---lingshou  ReqLevelUpTianFu
---ToServer
LuaEnumNetDef.ReqLevelUpTianFuMessage = 48013

---返回升级天赋
---lingshou  ResLevelUpTianFu
---ToClient
LuaEnumNetDef.ResLevelUpTianFuMessage = 48014

---发送移除皮肤消息
---lingshou  ResRemoveSkin
---ToClient
LuaEnumNetDef.ResRemoveSkinMessage = 48015

---请求圣灵
---lingshou  ReqShengLing
---ToServer
LuaEnumNetDef.ReqShengLingMessage = 48016

---请求灵兽任务面板
---ToServer
LuaEnumNetDef.ReqLingShouTaskPanelMessage = 48017

---请求灵兽任务面板
---lingshou  ResLingShouTaskPanel
---ToClient
LuaEnumNetDef.ResLingShouTaskPanelMessage = 48018

---更新灵兽任务信息
---lingshou  ResLingShouTaskInfo
---ToClient
LuaEnumNetDef.ResLingShouTaskInfoMessage = 48019

---更新灵兽章节信息
---lingshou  ResLinshouSectionInfo
---ToClient
LuaEnumNetDef.ResLinshouSectionInfoMessage = 48020

---领取任务奖励
---lingshou  ReqGetRewards
---ToServer
LuaEnumNetDef.ReqGetRewardsMessage = 48021

---领取章节奖励
---lingshou  ReqGetSecRewards
---ToServer
LuaEnumNetDef.ReqGetSecRewardsMessage = 48022

---完成所有灵兽任务
---ToServer
LuaEnumNetDef.ReqFinishAllLingshouTaskMessage = 48023

---立即开启
---lingshou  UnlockLingShouTask
---ToServer
LuaEnumNetDef.ReqUnlockLingShouTaskMessage = 48024

---解锁灵兽
---lingshou  UnlockSecEffect
---ToClient
LuaEnumNetDef.ResUnlockEffectMessage = 48025
--endregion

--region ID:54  tower
---发送通天塔面板信息
---tower  ResRoleTowerInfo
---ToClient
LuaEnumNetDef.ResRoleTowerInfoMessage = 54001

---请求通天塔面板信息
---ToServer
LuaEnumNetDef.ReqRoleTowerInfoMessage = 54002
--endregion

--region ID:56  official
---发送官职界面信息
---official  ResOfficialInfo
---ToClient
LuaEnumNetDef.ResOfficialInfoMessage = 56001

---请求官职晋升
---ToServer
LuaEnumNetDef.ReqOfficialUpMessage = 56002

---返回官职晋升结果
---official  ResOfficialUp
---ToClient
LuaEnumNetDef.ResOfficialUpMessage = 56003

---请求领取日活奖励
---official  ReqDrawDailyActiveReward
---ToServer
LuaEnumNetDef.ReqDrawDailyActiveRewardMessage = 56004

---返回领取日活奖励结果
---official  ResDrawDailyActiveReward
---ToClient
LuaEnumNetDef.ResDrawDailyActiveRewardMessage = 56005

---请求领取日常任务完成奖励
---official  ReqDrawDailyTaskReward
---ToServer
LuaEnumNetDef.ReqDrawDailyTaskRewardMessage = 56006

---同步官职和虎符信息,上线和变化都是这一条
---official  ResOfficialInfoV2
---ToClient
LuaEnumNetDef.ResOfficialInfoV2Message = 56011

---升级官职
---ToServer
LuaEnumNetDef.ReqOfficialUpgradeV2Message = 56012

---激活虎符
---official  ReqOfficialEmperorTokenActivateV2
---ToServer
LuaEnumNetDef.ReqOfficialEmperorTokenActivateV2Message = 56013
--endregion

--region ID:59  junxian
---升级向周围玩家发送消息
---junxian  ResRoundJunXianUp
---ToClient
LuaEnumNetDef.ResRoundJunXianUpMessage = 59001

---获取军衔当前等级
---ToServer
LuaEnumNetDef.ReqJunXianLevelMessage = 59006

---军衔当前等级响应
---junxian  ResJunXianLevel
---ToClient
LuaEnumNetDef.ResJunXianLevelMessage = 59007

---军衔升级请求
---junxian  ReqJunXianUp
---ToServer
LuaEnumNetDef.ReqJunXianUpMessage = 59008

---军衔升级响应
---junxian  ResJunXianUp
---ToClient
LuaEnumNetDef.ResJunXianUpMessage = 59009
--endregion

--region ID:67  map
---更新视野
---map  ResUpdateView
---ToClient
LuaEnumNetDef.ResUpdateViewMessage = 67001

---玩家进入视野
---map  ResPlayerEnterView
---ToClient
LuaEnumNetDef.ResPlayerEnterViewMessage = 67002

---怪物进入视野
---map  ResMonsterEnterView
---ToClient
LuaEnumNetDef.ResMonsterEnterViewMessage = 67003

---npc进入视野
---map  ResNpcEnterView
---ToClient
LuaEnumNetDef.ResNpcEnterViewMessage = 67004

---buff进入视野
---map  ResBufferEnterView
---ToClient
LuaEnumNetDef.ResBufferEnterViewMessage = 67005

---宠物进入视野
---map  ResPetEnterView
---ToClient
LuaEnumNetDef.ResPetEnterViewMessage = 67006

---英雄进入视野
---map  ResHeroEnterView
---ToClient
LuaEnumNetDef.ResHeroEnterViewMessage = 67007

---场景对象离开视野
---map  ResMapObjectExitView
---ToClient
LuaEnumNetDef.ResMapObjectExitViewMessage = 67008

---玩家进入地图
---map  ResPlayerEnterMap
---ToClient
LuaEnumNetDef.ResPlayerEnterMapMessage = 67009

---玩家切换地图
---map  ResPlayerChangeMap
---ToClient
LuaEnumNetDef.ResPlayerChangeMapMessage = 67010

---切换位置
---map  ResChangePos
---ToClient
LuaEnumNetDef.ResChangePosMessage = 67011

---玩家登录地图
---ToServer
LuaEnumNetDef.ReqLoginMapMessage = 67012

---事件进入视野
---map  ResEventEnterView
---ToClient
LuaEnumNetDef.ResEventEnterViewMessage = 67013

---对象复活
---map  ResRelive
---ToClient
LuaEnumNetDef.ResReliveMessage = 67014

---道具进入视野
---map  ResItemEnterView
---ToClient
LuaEnumNetDef.ResItemEnterViewMessage = 67015

---对象装备信息发生变化
---map  ResUpdateEquip
---ToClient
LuaEnumNetDef.ResUpdateEquipMessage = 67016

---玩家尝试进入地图
---map  TryEnterMapRequest
---ToServer
LuaEnumNetDef.ReqTryEnterMapMessage = 67017

---玩家尝试进入地图
---map  ResTryEnterMap
---ToClient
LuaEnumNetDef.ResTryEnterMapMessage = 67018

---通知客户端改变操作的玩家对象
---map  ResChangePlayer
---ToClient
LuaEnumNetDef.ResChangePlayerMessage = 67019

---通知其他玩家某个英雄的控制发生变化
---map  ResReplacePlayer
---ToClient
LuaEnumNetDef.ResReplacePlayerMessage = 67020

---同步boss和玩家总血量信息
---duplicate  ResPerformTotalHp
---ToClient
LuaEnumNetDef.ResPerformTotalHpMessage = 67021

---同步boss归属信息
---map  ResBossOwner
---ToClient
LuaEnumNetDef.ResBossOwnerMessage = 67022

---玩家翅膀变化
---map  ResPlayerWingChange
---ToClient
LuaEnumNetDef.ResPlayerWingChangeMessage = 67023

---玩家行会变化
---map  ResPlayerUnionChange
---ToClient
LuaEnumNetDef.ResPlayerUnionChangeMessage = 67024

---请求复活
---map  PlayerReliveRequest
---ToServer
LuaEnumNetDef.ReqPlayerReliveMessage = 67025

---玩家死亡次数信息
---map  ResPlayerReliveInfo
---ToClient
LuaEnumNetDef.ResPlayerReliveInfoMessage = 67026

---玩家时装变化
---map  ResPlayerFashionChange
---ToClient
LuaEnumNetDef.ResPlayerFashionChangeMessage = 67027

---玩家军衔变化
---map  ResPlayerJunxianChange
---ToClient
LuaEnumNetDef.ResPlayerJunxianChangeMessage = 67028

---请求切换攻击模式
---map  SwitchFightModelRequest
---ToServer
LuaEnumNetDef.ReqSwitchFightModelMessage = 67029

---返回选择攻击模式
---map  ResSwitchFightModel
---ToClient
LuaEnumNetDef.ResSwitchFightModelMessage = 67030

---拾取地图道具
---map  PickUpMapItemRequest
---ToServer
LuaEnumNetDef.ReqPickUpMapItemMessage = 67031

---通知场景变化消息
---map  ResNoticeViewTypeInfo
---ToClient
LuaEnumNetDef.ResNoticeViewTypeInfoMessage = 67032

---同步boss和玩家总血量信息
---map  ResAllPerformerTotalHp
---ToClient
LuaEnumNetDef.ResAllPerformerTotalHpMessage = 67033

---同步玩家威压信息
---map  ResPressureValue
---ToClient
LuaEnumNetDef.ResPressureValueMessage = 67034

---请求boss归属
---map  BossOwnerRequest
---ToServer
LuaEnumNetDef.ReqBossOwnerMessage = 67035

---同步boss复活信息
---map  BossReliveTime
---ToClient
LuaEnumNetDef.ResBossReliveTimeMessage = 67036

---玩家神装变化
---map  ResPlayerSzSuitChange
---ToClient
LuaEnumNetDef.ResPlayerSzSuitChangeMessage = 67037

---玩家传说变化
---map  ResPlayerLegendChange
---ToClient
LuaEnumNetDef.ResPlayerLegendChangeMessage = 67038

---返回墓碑信息
---map  ResTombInfo
---ToClient
LuaEnumNetDef.ResTombInfoMessage = 67040

---请求采集操作
---map  GatherOperatorRequest
---ToServer
LuaEnumNetDef.ReqGatherOperatorMessage = 67041

---返回采集数据
---map  ResGatherState
---ToClient
LuaEnumNetDef.ResGatherMessage = 67043

---地上物品归属改变
---map  RoundItemInfo
---ToClient
LuaEnumNetDef.ResItemOwnerChangedMessage = 67044

---元灵进入视野
---map  ResServantEnterView
---ToClient
LuaEnumNetDef.ResServantEnterViewMessage = 67045

---采集点进入视野
---map  ResCollectEnterView
---ToClient
LuaEnumNetDef.ResCollectEnterViewMessage = 67046

---停止采集
---ToServer
LuaEnumNetDef.ReqStopGatherMessage = 67047

---点击事件(比如开宝箱)
---map  ReqClickEvent
---ToServer
LuaEnumNetDef.ReqClickEventMessage = 67048

---返回地图对象死亡状态
---map  ResObjectDeadTime
---ToClient
LuaEnumNetDef.ResObjectDeadTimeMessage = 67049

---怪物技能释放预警
---map  WarningSkillInfo
---ToClient
LuaEnumNetDef.ResWaringSkillMessage = 67050

---怪物归属改变
---map  RoundMonsterInfo
---ToClient
LuaEnumNetDef.ResMonsterOwnerChangedMessage = 67051

---神兽切换状态
---map  RoundPetInfo
---ToClient
LuaEnumNetDef.ResPetStateChangeMessage = 67052

---请求生肖npc信息
---map  ReqAnimalNPCInfo
---ToServer
LuaEnumNetDef.ReqAnimalNPCInfoMessage = 67053

---返回生肖npc信息
---map  ResAnimalNPCInfo
---ToClient
LuaEnumNetDef.ResAnimalNPCInfoMessage = 67054

---请求天怒神像信息
---map  ReqSkyAngerGodInfo
---ToServer
LuaEnumNetDef.ReqSkyAngerGodInfoMessage = 67055

---返回天怒神像信息
---map  ResSkyAngerGodInfo
---ToClient
LuaEnumNetDef.ResSkyAngerGodInfoMessage = 67056

---发送进入人数改变信息
---map  EnterNumRefresh
---ToClient
LuaEnumNetDef.ResEnterNumRefreshMessage = 67057

---发送合体信息给周围玩家
---map  ResServantInfo
---ToClient
LuaEnumNetDef.ResServantCombineMessage = 67058

---玩家信息改变
---map  RoundPlayerInfo
---ToClient
LuaEnumNetDef.ResPlayerModChangeMessage = 67059

---发送合体特效给周围玩家
---map  ResServantInfo
---ToClient
LuaEnumNetDef.ResServantCombineEffectMessage = 67060

---门票不足弹出快捷购买面板
---map  ResTheTokenNotEnough
---ToClient
LuaEnumNetDef.ResTheTokenNotEnoughMessage = 67061

---物品掉落列表
---map  ResItemsDrop
---ToClient
LuaEnumNetDef.ResItemsDropMessage = 67062

---摊位进入视野
---map  ResBoothEnterView
---ToClient
LuaEnumNetDef.ResBoothEnterViewMessage = 67063

---返回挖矿衰减开始信息
---map  ResStartMining
---ToClient
LuaEnumNetDef.ResStartMiningMessage = 67064

---返回体力改变的消息
---map  ResChangeSpirit
---ToClient
LuaEnumNetDef.ResChangeSpiritMessage = 67065

---请求停止钓鱼
---ToServer
LuaEnumNetDef.ReqStopFishingMessage = 67066

---请求神医恢复
---map  ReqDoctorRecover
---ToServer
LuaEnumNetDef.ReqDoctorRecoverMessage = 67067

---返回玩家进战脱战状态
---map  ResPlayerBattleState
---ToClient
LuaEnumNetDef.ResPlayerBattleStateMessage = 67068

---行会镖车更新信息包
---map  ResUpdateUnionCartInfo
---ToClient
LuaEnumNetDef.ResUpdateUnionCartInfoMessage = 67069

---请求玩家的仲裁信息
---ToServer
LuaEnumNetDef.ReqDropProtectMessage = 67070

---返回玩家的仲裁信息
---map  reqDropProtect
---ToClient
LuaEnumNetDef.ResDropProtectMessage = 67071

---掉落物品赎回
---map  reqDropBuy
---ToServer
LuaEnumNetDef.ReqDropBuyMessage = 67072

---掉落物品领取奖励
---map  reqPickUpBuy
---ToServer
LuaEnumNetDef.ReqPickUpAwardMessage = 67073

---掉落物品无偿归还
---map  reqDropReturn
---ToServer
LuaEnumNetDef.ReqDropReturnMessage = 67074

---掉落物品归还领取
---map  reqDropReturnAward
---ToServer
LuaEnumNetDef.ReqDropReturnAwardMessage = 67075

---返回玩家的仲裁小红点信息
---map  dropProtectNotice
---ToClient
LuaEnumNetDef.ResDropProtectNoticeMessage = 67076

---野外登录时判断是否可以进入假比奇
---map  MainCityBranch
---ToClient
LuaEnumNetDef.MainCityBranchMessage = 67077

---发送守卫跪拜城主消息
---map  ResGuardBowLord
---ToClient
LuaEnumNetDef.ResGuardBowLordMessage = 67078

---发送矿工采矿消息
---map  ResMinerCollection
---ToClient
LuaEnumNetDef.ResMinerCollectionMessage = 67079

---停止矿工采矿消息
---map  ResStopMinerCollection
---ToClient
LuaEnumNetDef.ResStopMinerCollectionMessage = 67080

---发送矿工状态
---map  MinerActivityType
---ToClient
LuaEnumNetDef.MinerActivityTypeMessage = 67081

---玩家改变强化套装消息
---map  ResIntensifySuitChange
---ToClient
LuaEnumNetDef.ResIntensifySuitChangeMessage = 67082

---发送怪物活动预警
---map  MonsterActiveWarning
---ToClient
LuaEnumNetDef.ResMonsterActiveWarningMessage = 67083

---幻境副本领奖
---map  ReqNpcReceivePrize
---ToServer
LuaEnumNetDef.ReqNpcReceivePrizeMessage = 67084

---请求查看NPC上玩家的领取排行
---map  ReqReceiveRankingForNpc
---ToServer
LuaEnumNetDef.ReqReceiveRankingForNpcMessage = 67085

---查看NPC上玩家的领取排行
---map  ResReceiveRankingForNpc
---ToClient
LuaEnumNetDef.ResReceiveRankingForNpcMessage = 67086

---发送传送特效消息
---map  TransmitEffect
---ToClient
LuaEnumNetDef.ResTransmitEffectMessage = 67087

---火药桶爆炸
---fight  ResFightResult
---ToClient
LuaEnumNetDef.ResExplosiveEventMessage = 67088

---宠物死亡
---map  ResPetDie
---ToClient
LuaEnumNetDef.ResPetDieMessage = 67089

---发送神医满状态消息
---map  ResDoctorRecover
---ToClient
LuaEnumNetDef.ResDoctorHealthMessage = 67090

---发送多数量特效
---map  MultiItemEffect
---ToClient
LuaEnumNetDef.ResMultiItemEffectMessage = 67091

---聊天框寻路小飞鞋传送处理
---map  ReqLocationDelivery
---ToServer
LuaEnumNetDef.ReqLocationDeliveryMessage = 67092

---返回小飞鞋传送处理是否成功
---map  ResLocationDelivery
---ToClient
LuaEnumNetDef.ResLocationDeliveryMessage = 67093

---锁定怪物
---map  MonsterIdInfo
---ToServer
LuaEnumNetDef.ReqLockMonsterMessage = 67094

---采集之后需要生成骨架特效
---map  HasSkeleton
---ToClient
LuaEnumNetDef.HasSkeletonMessage = 67095

---钓鱼点类型切换
---map  ResFishingPointChange
---ToClient
LuaEnumNetDef.ResFishingPointChangeMessage = 67096

---玩家死亡掉落物品信息
---map  ResPlayerDropInfo
---ToClient
LuaEnumNetDef.ResPlayerDieDropItemInfoMessage = 67097

---千年树妖刷新消息
---map  TreeMonsterRefreshCall
---ToClient
LuaEnumNetDef.ResTreeMonsterRefreshMessage = 67098

---请求传送到千年树妖
---map  DeliverTreeMonsterInfo
---ToServer
LuaEnumNetDef.ReqDeliverTreeMonsterMessage = 67099

---响应传送到千年树妖
---map  DeliverTreeMonsterResult
---ToClient
LuaEnumNetDef.ResDeliverTreeMonsterMessage = 67100

---元灵修炼进入视野
---map  ResServantCultivateEnterView
---ToClient
LuaEnumNetDef.ResServantCultivateEnterViewMessage = 67101

---请求魔之boss信息
---map  ReqDemonBossInfo
---ToServer
LuaEnumNetDef.ReqDemonBossInfoMessage = 67102

---通知客户端魔之boss倒计时开始
---map  ResDemonBossInfo
---ToClient
LuaEnumNetDef.ResDemonBossInfoMessage = 67103

---魔之boss总次数
---map  ResDemonBossHasCount
---ToClient
LuaEnumNetDef.ResDemonBossHasCountMessage = 67104

---魔之boss次数更新
---map  ResDemonBossUpdateHasCount
---ToClient
LuaEnumNetDef.ResDemonBossUpdateHasCountMessage = 67105

---魔之请求拉令
---map  ReqDemonBossHelp
---ToServer
LuaEnumNetDef.ReqDemonBossHelpMessage = 67106

---拉令失败返回冷却结束时间
---map  ResDemonBossHelpFailure
---ToClient
LuaEnumNetDef.ResDemonBossHelpFailureMessage = 67107

---弹出拉令面板
---map  ResDemonBossHelpToPeople
---ToClient
LuaEnumNetDef.ResDemonBossHelpToPeopleMessage = 67108

---拉令传送
---map  ReqAcceptDemonBossHelp
---ToServer
LuaEnumNetDef.ReqAcceptDemonBossHelpMessage = 67109

---魔之boss死亡时可领取按钮
---map  DemonDieCanReward
---ToClient
LuaEnumNetDef.DemonDieCanRewardMessage = 67110

---请求领奖
---map  ReqDemonDieCanReward
---ToServer
LuaEnumNetDef.ReqDemonDieCanRewardMessage = 67111

---进入视野告诉客户端魔之boss剩余时间
---map  DemonBossEndTime
---ToClient
LuaEnumNetDef.DemonBossEndTimeMessage = 67112

---神之boss信息
---map  ResGodBossInfo
---ToClient
LuaEnumNetDef.ResGodBossInfoMessage = 67113

---联服封印塔加伤假buff消息
---map  ResSealTowerAddDamage
---ToClient
LuaEnumNetDef.ResSealTowerAddDamageMessage = 67114

---篝火进入视野
---map  ResBonfireEnterView
---ToClient
LuaEnumNetDef.ResBonfireEnterViewMessage = 67115

---烤篝火跳字
---map  BonfireAddExp
---ToClient
LuaEnumNetDef.ResBonfireAddExpMessage = 67116

---请求篝火信息
---map  ReqBonfireInfo
---ToServer
LuaEnumNetDef.ReqBonfireInfoMessage = 67117

---返回篝火信息
---map  ResBonfireInfo
---ToClient
LuaEnumNetDef.ResBonfireInfoMessage = 67118

---返回篝火信息
---map  PlayerEnterBonfireState
---ToClient
LuaEnumNetDef.ResPlayerEnterBonfireStateMessage = 67119

---联服请求玩家的仲裁信息
---ToServer
LuaEnumNetDef.ReqShareDropProtectMessage = 67120

---联服掉落物品赎回
---map  reqDropBuy
---ToServer
LuaEnumNetDef.ReqShareDropBuyMessage = 67121

---联服掉落物品领取奖励
---map  reqPickUpBuy
---ToServer
LuaEnumNetDef.ReqSharePickUpAwardMessage = 67122

---联服掉落物品无偿归还
---map  reqDropReturn
---ToServer
LuaEnumNetDef.ReqShareDropReturnMessage = 67123

---联服掉落物品归还领取
---map  reqDropReturnAward
---ToServer
LuaEnumNetDef.ReqShareDropReturnAwardMessage = 67124

---使用物品传送到地图
---map  ResUseItemDeliverToMap
---ToClient
LuaEnumNetDef.ResUseItemDeliverToMapMessage = 67125

---拾取地图道具列表
---map  PickUpMapItemsRequest
---ToServer
LuaEnumNetDef.ReqPickUpMapItemsMessage = 67126

---返回地图消失的道具
---map  AutoPickObjIds
---ToClient
LuaEnumNetDef.ResAutoPickObjIdsMessage = 67127

---拾取客户端返回
---map  ResPickUpTypeToClient
---ToClient
LuaEnumNetDef.ResPickUpTypeToClientMessage = 67128

---返回阵法信息
---map  ResPlayerZhenfaChange
---ToClient
LuaEnumNetDef.ResPlayerZhenfaChangeMessage = 67129

---返回活动地图信息
---map  ResActivityMapInfo
---ToClient
LuaEnumNetDef.ResActivityMapInfoMessage = 67130

---请求摊位传送
---map  ReqItemRadioTransfer
---ToClient
LuaEnumNetDef.ReqItemRadioTransferMessage = 67131
--endregion

--region ID:68  move
---请求慢走
---move  ReqMove
---ToServer
LuaEnumNetDef.ReqMoveMessage = 68001

---通知慢走
---move  ResMove
---ToClient
LuaEnumNetDef.ResMoveMessage = 68002

---请求改变朝向
---move  ReqChangeDir
---ToServer
LuaEnumNetDef.ReqChangeDirMessage = 68007

---返回改变朝向
---move  ResChangeDir
---ToClient
LuaEnumNetDef.ResChangeDirMessage = 68008

---前面玩家慢走快走
---move  ReqPlayerMoveRequest
---ToServer
LuaEnumNetDef.ReqPlayerMoveMessage = 68009
--endregion

--region ID:69  fight
---请求攻击
---fight  FightRequest
---ToServer
LuaEnumNetDef.ReqFightMessage = 69001

---返回攻击
---fight  ResFightResult
---ToClient
LuaEnumNetDef.ResFightResultMessage = 69002

---血量蓝量发生变化（用于单独的通知血量，比如说buffer伤害等等）
---fight  ResHpMpChange
---ToClient
LuaEnumNetDef.ResHpMpChangeMessage = 69004

--- 死亡消息（用于单独的通知对象的死亡,比如说buffer伤害等等）
---fight  ResObjectDie
---ToClient
LuaEnumNetDef.ResObjectDieMessage = 69006

---同步玩家总血量的百分比
---fight  ResPlayerTotalHpPercnet
---ToClient
LuaEnumNetDef.ResPlayerTotalHpPercnetMessage = 69008

---内功发生变化（用于单独的通知内功，内功回复）
---fight  ResInnerChange
---ToClient
LuaEnumNetDef.ResInnerChangeMessage = 69009

---返回守护攻击
---fight  ResShouHuAttack
---ToClient
LuaEnumNetDef.ResShouHuAttackMessage = 69010

---同步玩家总魔法值的百分比
---fight  ResPlayerTotalMagicPercnet
---ToClient
LuaEnumNetDef.ResPlayerTotalMagicPercnetMessage = 69011

---返回禁疗消息
---fight  ResBanCure
---ToClient
LuaEnumNetDef.ResBanCureMessage = 69012

---受技能位移
---fight  SkillMoveInfo
---ToClient
LuaEnumNetDef.ResSkillMoveMessage = 69013

---返回药品直接回血回蓝消息
---fight  ResMedicineHpMpChange
---ToClient
LuaEnumNetDef.ResMedicineHpMpChangeMessage = 69014

---返回秒杀提示
---fight  ResLampCoreSeckill
---ToClient
LuaEnumNetDef.ResLampCoreSeckillMessage = 69015
--endregion

--region ID:70  buffer
---通知移除buff
---buffer  ResRemoveBuffer
---ToClient
LuaEnumNetDef.ResRemoveBufferMessage = 70001

---通知添加buff
---fight  BufferInfo
---ToClient
LuaEnumNetDef.ResAddBufferMessage = 70002

---通知更新buff
---fight  BufferInfo
---ToClient
LuaEnumNetDef.ResUpdateBufferMessage = 70003

---buff造成的持续回血和伤害
---buffer  BufferDeltaHP
---ToClient
LuaEnumNetDef.ResBufferDeltaHPMessage = 70004
--endregion

--region ID:71  duplicate
---副本基本信息
---duplicate  ResDuplicateBasicInfo
---ToClient
LuaEnumNetDef.ResDuplicateBasicInfoMessage = 71001

---请求进入副本
---duplicate  ReqEnterDuplicate
---ToServer
LuaEnumNetDef.ReqEnterDuplicateMessage = 71002

---请求退出副本
---duplicate  ReqLeaveDuplicate
---ToServer
LuaEnumNetDef.ReqExitDuplicateMessage = 71003

---请求领取副本奖励
---duplicate  ReqDuplicateReward
---ToServer
LuaEnumNetDef.ReqRewardDuplicateMessage = 71004

---副本结束信息
---duplicate  ResDuplicateEnd
---ToClient
LuaEnumNetDef.ResDuplicateEndMessage = 71005

---发送天梯场景对象信息
---duplicate  ResUpdateTianTiMonsterInfo
---ToClient
LuaEnumNetDef.ResUpdateTianTiMonsterInfoMessage = 71007

---请求副本信息
---duplicate  ReqDuplicatePanelInfo
---ToServer
LuaEnumNetDef.ReqDuplicatePanelInfoMessage = 71008

---副本面板消息
---duplicate  ResDuplicatePanelInfo
---ToClient
LuaEnumNetDef.ResDuplicatePanelInfoMessage = 71009

---发送伤害排行变化信息
---duplicate  ResSendHurtRankInfo
---ToClient
LuaEnumNetDef.ResSendHurtRankInfoMessage = 71010

---返回副本剩余挑战次数信息
---duplicate  ResDuplicateLeftChallengeCount
---ToClient
LuaEnumNetDef.ResDuplicateLeftChallengeCountMessage = 71011

---返回副本结算消息
---duplicate  ResDuplicateReward
---ToClient
LuaEnumNetDef.ResDuplicateRewardMessage = 71012

---返回当前采集书页副本中的采集信息(进副本时传，断线重连时传)
---duplicate  ResTreasureMapCollectInitInfo
---ToClient
LuaEnumNetDef.ResTreasureMapCollectInitInfoMessage = 71013

---返回当前采集书页副本的改变信息
---duplicate  ResTreasureMapCollectChangeInfo
---ToClient
LuaEnumNetDef.ResTreasureMapCollectChangeInfoMessage = 71014

---沙巴克信息
---duplicate  SabacInfo
---ToClient
LuaEnumNetDef.ResSabacInfoMessage = 71015

---雕像死亡
---ToClient
LuaEnumNetDef.ResFlagDieMessage = 71016

---沙巴克面板
---ToServer
LuaEnumNetDef.ReqSabacPanelInfoMessage = 71017

---沙巴克面板响应
---duplicate  SabacPanelInfo
---ToClient
LuaEnumNetDef.ResSabacPanelInfoMessage = 71018

---快速完成副本请求
---duplicate  ReqAutoFinshDuplicate
---ToServer
LuaEnumNetDef.ReqAutoFinshDuplicateMessage = 71019

---快速完成副本相应
---duplicate  ResAutoFinshDuplicate
---ToClient
LuaEnumNetDef.ResAutoFinshDuplicateMessage = 71020

---发送暴君降临积分排名
---duplicate  TyrantDuplicateScore
---ToClient
LuaEnumNetDef.TyrantDuplicateScoreMessage = 71021

---请求暴君鼓舞
---duplicate  ReqInspireBuff
---ToServer
LuaEnumNetDef.ReqInspireBuffMessage = 71022

---返回暴君鼓舞
---duplicate  ResInspireBuff
---ToClient
LuaEnumNetDef.ResInspireBuffMessage = 71023

---暴君boss死亡发送消息
---duplicate  ResTyrantDeath
---ToClient
LuaEnumNetDef.ResTyrantDeathMessage = 71024

---发送副本道具信息
---duplicate  ResDuplicateItem
---ToClient
LuaEnumNetDef.ResDuplicateItemMessage = 71025

---发送玩家所在层数
---duplicate  ResDuplicateInfo
---ToClient
LuaEnumNetDef.ResDuplicateInfoMessage = 71026

---洞窟试炼返回玩家排行信息
---duplicate  CavesDuplicateRankInfo
---ToClient
LuaEnumNetDef.ResCavesDuplicateRankInfoMessage = 71027

---请求陵墓信息
---duplicate  ReqMausoleumDuplicate
---ToServer
LuaEnumNetDef.ReqMausoleumDuplicateMessage = 71028

---返回洞窟试炼开启时间
---duplicate  CavesDuplicateInitTime
---ToClient
LuaEnumNetDef.ResCavesDuplicateInitTimeMessage = 71029

---返回神威狱开启时间
---duplicate  ResGodPower
---ToClient
LuaEnumNetDef.ResGodPowerMessage = 71030

---进入门票信息
---duplicate  ResEntryTokenItem
---ToClient
LuaEnumNetDef.ResEntryTokenItemMessage = 71031

---狼烟梦境时间消息
---duplicate  ResWolfDreamTime
---ToClient
LuaEnumNetDef.ResWolfDreamTimeMessage = 71032

---请求狼烟梦境时间消息
---ToServer
LuaEnumNetDef.ReqWolfDreamTimeMessage = 71033

---发送圣域空间次数
---duplicate  ResSanctuarySpaceInfo
---ToClient
LuaEnumNetDef.ResSanctuarySpaceInfoMessage = 71034

---购买圣域空间次数
---duplicate  ReqButSanctuaryCount
---ToServer
LuaEnumNetDef.ReqButSanctuaryCountMessage = 71035

---返回副本boss信息
---duplicate  ResDuplicateBossInfo
---ToClient
LuaEnumNetDef.ResDuplicateBossInfoMessage = 71036

---返回犯人剩余坐牢时间
---duplicate  ResPrisonRemainTime
---ToClient
LuaEnumNetDef.ResPrisonRemainTimeMessage = 71037

---请求犯人剩余坐牢时间
---ToServer
LuaEnumNetDef.ReqPrisonRemainTimeMessage = 71038

---获取沙巴克排名
---duplicate  ReqGetSabacRankInfo
---ToServer
LuaEnumNetDef.ReqGetSabacRankInfoMessage = 71039

---沙巴克排名信息
---duplicate  ResSabacRankInfo
---ToClient
LuaEnumNetDef.ResSabacRankInfoMessage = 71040

---女神赐福兑换物品
---ToServer
LuaEnumNetDef.ReqGoddessBlessingExchangeMessage = 71041

---女神赐福信息
---duplicate  ResGoddessBlessingInfo
---ToClient
LuaEnumNetDef.ResGoddessBlessingInfoMessage = 71042

---幻境迷宫消息
---duplicate  ResDreamlandInfo
---ToClient
LuaEnumNetDef.ResDreamlandInfoMessage = 71043

---返回幻境可传送层数
---duplicate  ResCanDelivery
---ToClient
LuaEnumNetDef.ResCanDeliveryMessage = 71044

---请求幻境传送
---duplicate  ReqDeliveryDuplicate
---ToServer
LuaEnumNetDef.ReqDeliveryDuplicateMessage = 71045

---请求武道会下注
---duplicate  ReqDuboBet
---ToServer
LuaEnumNetDef.ReqDuboBetMessage = 71046

---请求查看武道会能下注
---ToServer
LuaEnumNetDef.ReqDuboLookBetMessage = 71047

---请求武道会下注
---duplicate  ResBetPlayerInfo
---ToClient
LuaEnumNetDef.ResDuboLookBetMessage = 71048

---请求查看武道会排行榜
---duplicate  ReqLookBudoMeet
---ToServer
LuaEnumNetDef.ReqLookDuboRankMessage = 71049

---响应查看武道会排行榜
---duplicate  ResBudoRank
---ToClient
LuaEnumNetDef.ResLookDuboRankMessage = 71050

---查看武道会阶段信息
---duplicate  BudoDuplicatePhaseInfo
---ToClient
LuaEnumNetDef.ResBudoDuplicatePhaseInfoMessage = 71051

---武道会玩家更新信息
---duplicate  BudoDuplicateUpdateInfo
---ToClient
LuaEnumNetDef.ResBudoDuplicateUpdateInfoMessage = 71052

---请求激活沙巴克法阵
---ToServer
LuaEnumNetDef.ReqStartSabacTacticsMessage = 71053

---沙巴克法阵状态
---duplicate  ResSabacTactics
---ToClient
LuaEnumNetDef.ResSabacTacticsMessage = 71054

---激活沙巴克法阵付费
---ToServer
LuaEnumNetDef.ReqActiveSabacTacticsMessage = 71055

---沙巴克法阵激活失败
---ToClient
LuaEnumNetDef.ResSabacTacticsFailMessage = 71056

---沙巴克法阵激活公告, 全服
---duplicate  ResSabacTacticsActived
---ToClient
LuaEnumNetDef.ResSabacTacticsActivedMessage = 71057

---沙巴克法阵激活效果
---duplicate  ResSabacTacticsEffect
---ToClient
LuaEnumNetDef.ResSabacTacticsEffectMessage = 71058

---沙巴克积分信息
---duplicate  SabacScoreInfo
---ToClient
LuaEnumNetDef.ResSabacScoreInfoMessage = 71059

---请求众筹面板信息
---ToServer
LuaEnumNetDef.ReqCrowdFundingPanelMessage = 71060

---发送众筹面板信息
---duplicate  ResCrowdFundingPanel
---ToClient
LuaEnumNetDef.ResCrowdFundingPanelMessage = 71061

---请求开启众筹
---duplicate  ReqOpenCrowdFunding
---ToServer
LuaEnumNetDef.ReqOpenCrowdFundingMessage = 71062

---请求捐赠
---duplicate  ReqDonateFunding
---ToServer
LuaEnumNetDef.ReqDonateFundingMessage = 71063

---发送酬金金额变化
---duplicate  ResCrowdFundingChange
---ToClient
LuaEnumNetDef.ResCrowdFundingChangeMessage = 71064

---请求掮客信息
---ToServer
LuaEnumNetDef.ReqOpenBrokerPanelMessage = 71065

---掮客面板信息
---duplicate  ResBrokerPanel
---ToClient
LuaEnumNetDef.ResBrokerPanelMessage = 71066

---掮客查询
---duplicate  ReqBrokerQuery
---ToServer
LuaEnumNetDef.ReqBrokerQueryMessage = 71067

---获取女神赐福排名
---duplicate  GetGoddessBlessingRank
---ToServer
LuaEnumNetDef.ReqGetGoddessBlessingRankInfoMessage = 71068

---女神赐福排名信息
---duplicate  GoddessBlessingRankInfo
---ToClient
LuaEnumNetDef.ResGoddessBlessingRankInfoMessage = 71069

---返回玩家活动数据
---duplicate  ResPlayerActivityDataRank
---ToClient
LuaEnumNetDef.ResPlayerActivityDataRankMessage = 71070

---活动点赞请求
---duplicate  LikeRequest
---ToServer
LuaEnumNetDef.ReqLikeMessage = 71071

---点赞返回
---duplicate  LikeResponseCommon
---ToClient
LuaEnumNetDef.ResLikeMessage = 71072

---请求玩家活动数据
---ToServer
LuaEnumNetDef.ReqPlayerActivityDataRankMessage = 71073

---弹出活动结算面板
---duplicate  ActivityEndRank
---ToClient
LuaEnumNetDef.ActivityEndRankMessage = 71074

---女神赐福结束
---ToClient
LuaEnumNetDef.ResGoddessBlessingEndMessage = 71075

---请求今日是否使用烟花
---ToServer
LuaEnumNetDef.ReqTodayUseFireworkMessage = 71076

---返回今日是否使用烟花
---duplicate  ResTodayUseFirework
---ToClient
LuaEnumNetDef.ResTodayUseFireworkMessage = 71077

---请求活动往期时间
---duplicate  ReqGBPreviousPeriodTime
---ToServer
LuaEnumNetDef.ReqGBPreviousPeriodTimeMessage = 71078

---活动往期时间响应
---duplicate  ResGBPreviousPeriodTime
---ToClient
LuaEnumNetDef.ResGBPreviousPeriodTimeMessage = 71079

---请求女神赐福往期数据
---duplicate  ReqGBPreviousPeriodInfo
---ToServer
LuaEnumNetDef.ReqGBPreviousPeriodInfoMessage = 71080

---往期女神赐福数据响应
---duplicate  GoddessBlessingRankInfo
---ToClient
LuaEnumNetDef.ResGBPreviousPeriodInfoMessage = 71081

---请求沙巴克历史记录
---duplicate  ResSabacRecord
---ToServer
LuaEnumNetDef.ReqSabacRecordMessage = 71082

---沙巴克历史记录
---duplicate  ResSabacRecord
---ToClient
LuaEnumNetDef.ResSabacRecordMessage = 71083

---查看往期内容（用于幻境）
---duplicate  ReqGetPreviousReview
---ToServer
LuaEnumNetDef.ReqGetPreviousReviewMessage = 71084

---返回往期内容时间
---duplicate  ResGetPreviousReview
---ToClient
LuaEnumNetDef.ResGetPreviousReviewMessage = 71085

---查看具体某个活动的往期内容（用于幻境）
---duplicate  ReqGetSpecificPreviousReview
---ToServer
LuaEnumNetDef.ReqGetSpecificPreviousReviewMessage = 71086

---返回幻境具体某一期的内容
---duplicate  ResDreamlandRankInfo
---ToClient
LuaEnumNetDef.ResDreamlandRankInfoMessage = 71087

---记录打开往期数据面板的玩家
---duplicate  ReqSeePreviousData
---ToServer
LuaEnumNetDef.ReqSeePreviousDataMessage = 71088

---记录关闭往期数据面板的玩家
---duplicate  ReqClosePreviousData
---ToServer
LuaEnumNetDef.ReqClosePreviousDataMessage = 71089

---返回武道会决赛圈
---duplicate  ResBudoMeetAround
---ToClient
LuaEnumNetDef.ResBudoMeetAroundMessage = 71090

---返回恶魔广场结束时间
---duplicate  ResDevilSquareEndTime
---ToClient
LuaEnumNetDef.ResDevilSquareEndTimeMessage = 71091

---请求恶魔广场剩余时间
---duplicate  ReqDevilSquareEndTime
---ToServer
LuaEnumNetDef.ReqDevilSquareHasTimeMessage = 71092

---返回恶魔广场剩余时间
---duplicate  ResDevilSquareHasTime
---ToClient
LuaEnumNetDef.ResDevilSquareHasTimeMessage = 71093

---使用恶魔卷轴后提示
---duplicate  ResUseDevilScrollPrompt
---ToClient
LuaEnumNetDef.ResUseDevilScrollPromptMessage = 71094

---请求复活塔罗神庙怪物
---duplicate  ReqReliveHuntMonster
---ToServer
LuaEnumNetDef.ReqReliveHuntMonsterMessage = 71095

---武道会押注信息
---duplicate  BudoBetBeiInfo
---ToClient
LuaEnumNetDef.ResBudoBetBeiInfoMessage = 71096

---武道会押注成功信息
---duplicate  BudoBetSuccess
---ToClient
LuaEnumNetDef.ResBudoBetSuccessMessage = 71097

---狼烟梦境放XP技能更改加速系数
---duplicate  ResWolfDreamXpSkillChangeTime
---ToClient
LuaEnumNetDef.ResWolfDreamXpSkillChangeTimeMessage = 71098

---地下行宫副本信息
---duplicate  UndergroundDuplicateInfo
---ToClient
LuaEnumNetDef.ResUndergroundDuplicateInfoMessage = 71099

---推送地下行宫气泡消息
---duplicate  PushBubble
---ToClient
LuaEnumNetDef.ResPushBubbleMessage = 71100

---行宫我的帮会排名
---duplicate  UndergroundMyUnionRank
---ToClient
LuaEnumNetDef.ResUndergroundMyUnionRankMessage = 71101

---夺宝奇兵副本信息
---duplicate  RaiderInfo
---ToClient
LuaEnumNetDef.ResRaiderDuplicateInfoMessage = 71102

---沙巴克个人积分排名信息
---duplicate  ResSabacRankInfo
---ToClient
LuaEnumNetDef.ResSabacPersonalRankInfoMessage = 71103

---获取沙巴克个人积分排名
---duplicate  ReqGetSabacRankInfo
---ToServer
LuaEnumNetDef.ReqGetSabacPersonalRankInfoMessage = 71104

---通天塔通关后获取到的奖励弹面板
---duplicate  ResTowerInstanceEndGetReward
---ToClient
LuaEnumNetDef.ResTowerInstanceEndGetRewardMessage = 71105
--endregion

--region ID:72  deliver
---通过配置文件传送
---deliver  ReqDeliverByConfig
---ToServer
LuaEnumNetDef.ReqDeliverByConfigMessage = 72001

---通过传送石传送
---deliver  ReqDeliverByTransStone
---ToServer
LuaEnumNetDef.ReqDeliverByTransStoneMessage = 72002

---小飞鞋请求
---deliver  FlyToGoalRequest
---ToServer
LuaEnumNetDef.ReqFlyToGoalMessage = 72003

---小飞鞋响应
---ToClient
LuaEnumNetDef.ResFlyToGoalMessage = 72004

---直接传送随机远点请求
---deliver  DirectlyTransferRequest
---ToServer
LuaEnumNetDef.ReqDirectlyTransferMessage = 72005

---直接传送响应
---deliver  DirectlyTransferRes
---ToClient
LuaEnumNetDef.ResDirectlyTransferMessage = 72006

---通过npc进入地图
---deliver  ReqEnterMapByNPC
---ToServer
LuaEnumNetDef.ReqEnterMapByNPCMessage = 72007

---直接传送随机点请求
---deliver  DirectlyTransferRandomPointRequest
---ToServer
LuaEnumNetDef.ReqDirectlyTransferRandomPointMessage = 72008

---通过小地图传送
---deliver  ReqMinMapDeliver
---ToServer
LuaEnumNetDef.ReqMinMapDeliverMessage = 72009

---返回可传送任务ID
---deliver  CanTransferTaskId
---ToClient
LuaEnumNetDef.CanTransferTaskIdMessage = 72010

---请求本地图传送
---deliver  ReqThisMapTransfer
---ToServer
LuaEnumNetDef.ReqThisMapTransferMessage = 72011

---返回本地图传送是否成功
---deliver  ResThisMapTransfer
---ToClient
LuaEnumNetDef.ResThisMapTransferMessage = 72012

---小飞鞋飞动点请求
---deliver  ReqFlyToDynamicGoal
---ToServer
LuaEnumNetDef.ReqFlyToDynamicGoalMessage = 72013

---小飞鞋飞动点响应
---ToClient
LuaEnumNetDef.ResFlyToDynamicGoalMessage = 72014

---通用传送
---deliver  ReqDeliverByReason
---ToServer
LuaEnumNetDef.ReqDeliverByReasonMessage = 72015

---精英任务传送
---deliver  TaskBossDeliverReq
---ToServer
LuaEnumNetDef.ReqTaskBossDeliverMessage = 72016

---恶魔广场任务随机传送
---deliver  TaskRandomReq
---ToServer
LuaEnumNetDef.ReqTaskRandomReqMessage = 72017

---怪物攻城随机传送到怪物点
---deliver  ReqRandomDeliverToMonster
---ToServer
LuaEnumNetDef.ReqRandomDeliverToMonsterMessage = 72018
--endregion

--region ID:73  play
---通知野外boss死亡准备领奖
---play  ResWorldBossDie
---ToClient
LuaEnumNetDef.ResWorldBossDieMessage = 73001

---请求领取野外boss掉落
---play  ReqRewardWorldBoss
---ToServer
LuaEnumNetDef.ReqRewardWorldBossMessage = 73002

---请求进入玩法地图
---play  ReqEnterPlayMap
---ToServer
LuaEnumNetDef.ReqEnterPlayMapMessage = 73003

---护盾触发消息
---play  ResHudunTrigger
---ToClient
LuaEnumNetDef.ResHudunTriggerMessage = 73004

---护盾值变化消息
---play  ResHudunChange
---ToClient
LuaEnumNetDef.ResHudunChangeMessage = 73005

---请求roll点
---ToServer
LuaEnumNetDef.ReqRollPointMessage = 73006

---返回roll点结果
---play  ResRollPoint
---ToClient
LuaEnumNetDef.ResRollPointMessage = 73007

---返回roll点结果
---play  ResMaxRollPoint
---ToClient
LuaEnumNetDef.ResMaxRollPointMessage = 73008

---请求对应类型boss的状态
---play  ReqFetchWorldBossState
---ToServer
LuaEnumNetDef.ReqFetchWorldBossStateMessage = 73009

---返回对应类型boss的状态
---play  ResFetchWorldBossState
---ToClient
LuaEnumNetDef.ResFetchWorldBossStateMessage = 73010

---请求使用战役道具
---play  ReqUseFightItem
---ToServer
LuaEnumNetDef.ReqUseFightItemMessage = 73011

---返回使用战役道具结果
---ToClient
LuaEnumNetDef.ResUseFightItemMessage = 73012

---返回使用次数信息
---play  ResFightItemBuyCount
---ToClient
LuaEnumNetDef.ResFightItemBuyCountMessage = 73013

---请求设置Boss提醒
---play  ReqSetBossRemind
---ToServer
LuaEnumNetDef.ReqSetBossRemindMessage = 73014

---返回设置Boss提醒
---play  ResSetBossRemind
---ToClient
LuaEnumNetDef.ResSetBossRemindMessage = 73015

---发送boss重生提醒
---play  ResBossRemindToRole
---ToClient
LuaEnumNetDef.ResBossRemindToRoleMessage = 73016

---请求使用道具次数信息
---ToServer
LuaEnumNetDef.ReqUseFightItemInfosMessage = 73017

---玩家击杀信息
---play  ResPlayerKillInfo
---ToClient
LuaEnumNetDef.ResPlayerKillInfoMessage = 73018

---发送boss死亡信息
---play  ResMapBossDeath
---ToClient
LuaEnumNetDef.ResMapBossDeathMessage = 73019

---请求购买次数
---play  ReqBuyCount
---ToServer
LuaEnumNetDef.ReqBuyCountMessage = 73020

---发送boss次数改变
---play  ResBossCount
---ToClient
LuaEnumNetDef.ResBossCountMessage = 73021

---返回客户端通用消息
---play  CommonInfo
---ToClient
LuaEnumNetDef.ResCommonMessage = 73022

---客户端请求通用消息
---play  CommonInfo
---ToServer
LuaEnumNetDef.ReqCommonMessage = 73023

---客户端请求地图通用消息
---play  CommonInfo
---ToServer
LuaEnumNetDef.ReqMapCommonMessage = 73024

---挖掘没次数播放溶解特效消息
---play  ResCorpseDissolution
---ToClient
LuaEnumNetDef.ResCorpseDissolutionMessage = 73025

---返回客户端地图通用消息
---play  CommonInfo
---ToClient
LuaEnumNetDef.ResMapCommonMessage = 73026

---需要弹出攻击模式提示面板
---play  NeedHasAttackModePanel
---ToClient
LuaEnumNetDef.NeedHasAttackModePanelMessage = 73027

---今日不在提醒
---play  TodayNoReminder
---ToServer
LuaEnumNetDef.TodayNoReminderMessage = 73028
--endregion

--region ID:79  biqi
---比奇开启提醒消息
---ToClient
LuaEnumNetDef.ResBiQiStartRemindMessage = 79001

---发送比奇怪物信息
---biqi  ResBiQiMonster
---ToClient
LuaEnumNetDef.ResBiQiMonsterMessage = 79002

---发送比奇敌对信息
---biqi  ResBiQiEnemy
---ToClient
LuaEnumNetDef.ResBiQiEnemyMessage = 79003

---发送积分排行信息
---biqi  ResScoreRank
---ToClient
LuaEnumNetDef.ResScoreRankMessage = 79004

---发送逆袭buff信息
---biqi  ResNixiBuffInfo
---ToClient
LuaEnumNetDef.ResNixiBuffInfoMessage = 79005

---发送积分领奖信息
---biqi  ResScoreReward
---ToClient
LuaEnumNetDef.ResScoreRewardMessage = 79006

---发送玩家积分信息
---biqi  ResRoleScore
---ToClient
LuaEnumNetDef.ResRoleScoreMessage = 79007

---请求积分领奖
---ToServer
LuaEnumNetDef.ReqScoreRewardMessage = 79008

---发送玩家视野内的阵营信息
---biqi  ResPlayerViewGroup
---ToClient
LuaEnumNetDef.ResPlayerViewGroupMessage = 79009

---提示即将切换阵营
---biqi  ResChangCampTip
---ToClient
LuaEnumNetDef.ResChangCampTipMessage = 79010
--endregion

--region ID:85  sealmark
---请求当前封号等级
---ToServer
LuaEnumNetDef.ReqSealMarkInfoMessage = 85001

---返回当前封号等级
---sealmark  ResSealMarkInfo
---ToClient
LuaEnumNetDef.ResSealMarkInfoMessage = 85002

---请求升级封号等级
---ToServer
LuaEnumNetDef.ReqUpgradeSealMarkMessage = 85003
--endregion

--region ID:100  friend
---返回好友信息
---friend  ResFriendInfo
---ToClient
LuaEnumNetDef.ResFriendInfoMessage = 100001

---请求打开好友面板
---friend  ReqOpenFriendPanel
---ToServer
LuaEnumNetDef.ReqOpenFriendPanelMessage = 100002

---请求好友查询
---friend  ReqSearchFriend
---ToServer
LuaEnumNetDef.ReqSearchFriendMessage = 100003

---请求添加好友
---friend  ReqAddFriend
---ToServer
LuaEnumNetDef.ReqAddFriendMessage = 100004

---返回好友变化信息
---friend  ResFriendChange
---ToClient
LuaEnumNetDef.ResFriendChangeMessage = 100005

---请求删除好友
---friend  ReqDeleteFriend
---ToServer
LuaEnumNetDef.ReqDeleteFriendMessage = 100006

---好友查询响应
---friend  SearchFriend
---ToClient
LuaEnumNetDef.ResSearchFriendMessage = 100007

---审批申请
---friend  checkApply
---ToServer
LuaEnumNetDef.ReqCheckApplyMessage = 100008

---召唤好友
---friend  SummonFriend
---ToServer
LuaEnumNetDef.ReqSummonFriendMessage = 100009

---好友召唤通知
---friend  SummonNotice
---ToClient
LuaEnumNetDef.ResSummonNoticeMessage = 100010

---确认召唤
---friend  ConfirmSummon
---ToServer
LuaEnumNetDef.ReqConfirmSummonMessage = 100011

---打探坐标
---friend  SummonFriend
---ToServer
LuaEnumNetDef.ReqTrackingMessage = 100012

---返回仇人坐标
---friend  AscertainPoint
---ToClient
LuaEnumNetDef.ResAscertainPointMessage = 100013

---拜师、收徒请求
---friend  TeacherDisciple
---ToServer
LuaEnumNetDef.ReqTeacherDiscipleMessage = 100014

---接收到拜师、收徒通知
---friend  TeacherDiscipleNotice
---ToClient
LuaEnumNetDef.ResTeacherDiscipleNoticeMessage = 100015

---请求可能认识的朋友
---ToServer
LuaEnumNetDef.ReqMayKnowFriendMessage = 100016

---返回可能认识的朋友
---friend  ResMayKnowFriend
---ToClient
LuaEnumNetDef.ResMayKnowFriendMessage = 100017

---清空申请列表
---ToServer
LuaEnumNetDef.ReqClearApplyListMessage = 100018

---请求编辑个人信息
---friend  ReqEditInfo
---ToServer
LuaEnumNetDef.ReqEditPersonalInfoMessage = 100019

---请求查看好友个人信息
---friend  ReqLookFriendInfo
---ToServer
LuaEnumNetDef.ReqLookFriendInfoMessage = 100020

---返回玩家个人信息
---friend  ResPersonalInfo
---ToClient
LuaEnumNetDef.ResPersonalInfoMessage = 100021

---修改好友备注
---friend  ReqEditRemark
---ToServer
LuaEnumNetDef.ReqEditRemarkMessage = 100022

---请求未读聊天
---friend  ChatTarget
---ToServer
LuaEnumNetDef.ReqUnreadChatMessage = 100023

---返回未读聊天
---friend  ResChatLog
---ToClient
LuaEnumNetDef.ResUnreadChatMessage = 100024

---设置已读
---friend  ChatTarget
---ToServer
LuaEnumNetDef.ReqSetReadMessage = 100025

---对方已读
---friend  ChatTarget
---ToClient
LuaEnumNetDef.ResAlreadyReadMessage = 100026

---请求聊天记录
---friend  ReqChatLog
---ToServer
LuaEnumNetDef.ReqPersonalChatMessage = 100027

---返回聊天记录
---friend  ResChatLog
---ToClient
LuaEnumNetDef.ResPersonalChatMessage = 100028

---请求朋友圈信息
---friend  GetFriendCircleInfo
---ToServer
LuaEnumNetDef.ReqGetFriendCircleMessage = 100029

---返回朋友圈信息
---friend  ResFriendCircle
---ToClient
LuaEnumNetDef.ResFriendCirleMessage = 100030

---单条朋友圈信息,发送,回复,点赞的响应
---friend  FriendCirclePostInfo
---ToClient
LuaEnumNetDef.ResSingleFriendCirleMessage = 100031

---请求朋友圈发动态
---friend  ReqFriendCirclePost
---ToServer
LuaEnumNetDef.ReqFriendCirclePostMessage = 100032

---请求朋友圈发回复
---friend  ReqFriendCircleReply
---ToServer
LuaEnumNetDef.ReqFriendCircleReplyMessage = 100033

---请求朋友圈点赞
---friend  ReqFriendCircleLike
---ToServer
LuaEnumNetDef.ReqFriendCircleLikeMessage = 100034

---点发送消息按钮
---friend  ChatTarget
---ToServer
LuaEnumNetDef.ReqAddSendChatMessage = 100035

---请求仇人位置
---friend  TargetId
---ToServer
LuaEnumNetDef.ReqEnemyPositionMessage = 100036

---返回仇人位置
---friend  ResEnemyPosition
---ToClient
LuaEnumNetDef.ResEnemyPositionMessage = 100037

---请求查看上次仇人位置
---friend  TargetId
---ToServer
LuaEnumNetDef.ReqLastEnemyPositionMessage = 100038

---请求悬赏列表
---friend  ReqOfferList
---ToServer
LuaEnumNetDef.ReqOfferListMessage = 100039

---返回悬赏列表
---friend  ResOfferList
---ToClient
LuaEnumNetDef.ResOfferListMessage = 100040

---发布悬赏
---friend  ReqPublishOffer
---ToServer
LuaEnumNetDef.ReqPublishOfferMessage = 100041

---好感度变化消息
---friend  ResFriendLoveChange
---ToClient
LuaEnumNetDef.ResFriendLoveChangeMessage = 100042

---撤回悬赏
---friend  ReqWithdrawOffer
---ToServer
LuaEnumNetDef.ReqWithdrawOfferMessage = 100043

---朋友圈有更新
---friend  ResFriendCircleUpdated
---ToClient
LuaEnumNetDef.ResFriendCircleUpdatedMessage = 100044

---提前出狱
---friend  ReqEarlyLeavePrison
---ToServer
LuaEnumNetDef.ReqEarlyLeavePrisonMessage = 100045

---查看申请人
---ToServer
LuaEnumNetDef.ReqLookApplicantMessage = 100046

---请求未查看的申请人
---ToServer
LuaEnumNetDef.ReqUnLookApplicantMessage = 100047

---返回未查看的申请人
---friend  UnLookApplicant
---ToClient
LuaEnumNetDef.ResUnLookApplicantMessage = 100048

---发送悬赏错误提示码
---friend  OfferMatterCode
---ToClient
LuaEnumNetDef.ResOfferMatterCodeMessage = 100049

---刷新刻字
---friend  UpdateLettering
---ToClient
LuaEnumNetDef.ResUpdateLetteringMessage = 100050

---更新悬赏列表
---friend  ResUpdateOfferList
---ToClient
LuaEnumNetDef.ResUpdateOfferListMessage = 100051

---朋友圈删除动态
---friend  ReqFriendCircleDelete
---ToServer
LuaEnumNetDef.ReqFriendCircleDeleteMessage = 100052

---请求接取怪物悬赏
---friend  OfferId
---ToServer
LuaEnumNetDef.ReqPickUpMonsterOfferMessage = 100053

---更新怪物悬赏左侧栏
---friend  UpdateMonsterOfferPanel
---ToClient
LuaEnumNetDef.ResUpdateMonsterOfferPanelMessage = 100054

---请求提交怪物悬赏
---friend  OfferId
---ToServer
LuaEnumNetDef.ReqSubmitMonsterOfferMessage = 100055

---请求删除私聊记录
---friend  ReqDeleteChatLog
---ToServer
LuaEnumNetDef.ReqDeleteChatLogMessage = 100056

---返回私聊更新
---friend  ResUpdateChatLog
---ToClient
LuaEnumNetDef.ResUpdateChatLogMessage = 100057

---更新完成人数
---friend  ResUpdateCompleteNum
---ToClient
LuaEnumNetDef.ResUpdateCompleteNumMessage = 100058

---好友上下线通知
---friend  ResFriendLogin
---ToClient
LuaEnumNetDef.ResFriendLoginMessage = 100059

---请求悬赏模糊查询
---friend  ReqSearchFriend
---ToServer
LuaEnumNetDef.ReqOfferSearchMessage = 100060

---返回悬赏模糊查询
---friend  ResOfferSearch
---ToClient
LuaEnumNetDef.ResOfferSearchMessage = 100061

---请求聊天框精确搜索
---friend  ReqSearchFriend
---ToServer
LuaEnumNetDef.ReqAccurateSearchMessage = 100062

---返回聊天框精确搜索
---friend  ResAccurateSearch
---ToClient
LuaEnumNetDef.ResAccurateSearchMessage = 100063

---请求更改朋友圈消息订阅
---friend  ReqFriendCircleSysMsgConfig
---ToServer
LuaEnumNetDef.ReqFriendCircleSysMsgConfigMessage = 100064

---请求悬赏列表
---friend  ReqOfferList
---ToServer
LuaEnumNetDef.ReqOfferShareListMessage = 100065

---发布悬赏
---friend  ReqPublishOffer
---ToServer
LuaEnumNetDef.ReqPublishOfferShareMessage = 100066

---撤回悬赏
---friend  ReqWithdrawOffer
---ToServer
LuaEnumNetDef.ReqWithdrawOfferShareMessage = 100067

---请求悬赏模糊查询
---friend  ReqSearchFriend
---ToServer
LuaEnumNetDef.ReqOfferShareSearchMessage = 100068
--endregion

--region ID:101  group
---请求组队面板信息
---ToServer
LuaEnumNetDef.ReqGroupDetailedInfoMessage = 101001

---请求改变队伍目标
---group  ReqChangeTarget
---ToServer
LuaEnumNetDef.ReqChangeTargetMessage = 101002

---请求转移队伍队长
---group  ReqChangeCaptain
---ToServer
LuaEnumNetDef.ReqChangeCaptainMessage = 101003

---请求创建队伍
---ToServer
LuaEnumNetDef.ReqCreatGroupMessage = 101004

---请求队伍踢出玩家
---group  ReqKickMember
---ToServer
LuaEnumNetDef.ReqKickMemberMessage = 101005

---玩家请求离开队伍
---group  ReqExitGroup
---ToServer
LuaEnumNetDef.ReqExitGroupMessage = 101006

---接受组队申请
---group  AcceptTeam
---ToServer
LuaEnumNetDef.ReqAcceptTeamApplicationMessage = 101007

---返回组队面板信息
---group  ResGroupDetailedInfo
---ToClient
LuaEnumNetDef.ResGroupDetailedInfoMessage = 101008

---请求打开组队请求界面
---ToServer
LuaEnumNetDef.ReqApplyListMessage = 101009

---请求加入队伍
---group  ReqJoinGroup
---ToServer
LuaEnumNetDef.ReqJoinGroupMessage = 101010

---返回组队请求列表界面
---group  ApplyList
---ToClient
LuaEnumNetDef.ResApplyListMessage = 101011

---玩家请求附近可以申请队伍列表
---ToServer
LuaEnumNetDef.ReqNearbyGroupMessage = 101012

---返回玩家请求附近可以申请队伍列表
---group  NearbyGroup
---ToClient
LuaEnumNetDef.ResNearbyGroupMessage = 101013

---请求邀请玩家
---group  ReqInvitationPlayer
---ToServer
LuaEnumNetDef.ReqInvitationPlayerMessage = 101014

---玩家接受邀请
---group  ReqAcceptInvitation
---ToServer
LuaEnumNetDef.ReqAcceptInvitationMessage = 101015

---玩家邀请列表响应
---group  ResInvitationList
---ToClient
LuaEnumNetDef.ResInvitationListMessage = 101016

---队伍请求邀请附近的人列表
---ToServer
LuaEnumNetDef.ReqNearPlayerMessage = 101017

---返回队伍请求邀请附近的人列表
---group  ResGroupInvitationNearbyList
---ToClient
LuaEnumNetDef.ResGroupInvitationNearbyListMessage = 101018

---队伍请求邀请好友列表
---ToServer
LuaEnumNetDef.ReqGroupInvitationFriendListMessage = 101019

---返回队伍请求邀请好友列表
---group  ResGroupInvitationFriendList
---ToClient
LuaEnumNetDef.ResGroupInvitationFriendListMessage = 101020

---队伍请求邀请行会列表
---ToServer
LuaEnumNetDef.ReqGroupInvitationUnionListMessage = 101021

---返回队伍请求邀请行会列表
---group  ResGroupInvitationUnionList
---ToClient
LuaEnumNetDef.ResGroupInvitationUnionListMessage = 101022

---请求清空列表
---group  ReqClearList
---ToServer
LuaEnumNetDef.ReqClearListMessage = 101023

---离开队伍响应
---ToClient
LuaEnumNetDef.ResLeaveTeamMessage = 101024

---消息提示
---group  MsgPrompt
---ToClient
LuaEnumNetDef.ResApplyTeamMessage = 101025

---玩家邀请列表请求
---ToServer
LuaEnumNetDef.ReqInvitationListMessage = 101026

---解散队伍
---ToServer
LuaEnumNetDef.ReqDissolveGroupMessage = 101027

---设置组队模式请求
---group  SetTeamModeRequest
---ToServer
LuaEnumNetDef.ReqSetTeamModeMessage = 101028

---屏蔽
---group  Shielding
---ToServer
LuaEnumNetDef.ReqShieldingMessage = 101029

---召唤令响应
---group  TeamCallBack
---ToClient
LuaEnumNetDef.ResCallBackMessage = 101030

---召唤令确认
---group  CheckCallBack
---ToServer
LuaEnumNetDef.ReqCheckCallBackMessage = 101031

---请求玩家是否在线及其部分消息
---group  ReqHasPlayerSomeInfo
---ToServer
LuaEnumNetDef.ReqHasPlayerSomeInfoMessage = 101032

---返回玩家是否在线及其部分消息
---group  ResHasPlayerSomeInfo
---ToClient
LuaEnumNetDef.ResHasPlayerSomeInfoMessage = 101033

---队长二次批复邀请
---group  ReqCaptainAcceptInvitation
---ToServer
LuaEnumNetDef.ReqCaptainAcceptInvitMessage = 101034

---组队玩家血量同步
---group  TeamPlayerHpInfo
---ToClient
LuaEnumNetDef.ResTeamPlayerHpMessage = 101035

---请求组队所有玩家血量同步
---group  ResTeamAllMemHpInfo
---ToClient
LuaEnumNetDef.ResTeamAllMemHpInfoMessage = 101036

---召唤令确认结果
---group  ResCallBack
---ToClient
LuaEnumNetDef.ResCheckCallBackMessage = 101037
--endregion

--region ID:102  task
---返回任务进度消息
---task  ResTaskProcess
---ToClient
LuaEnumNetDef.ResTaskProcessMessage = 102001

---请求提交任务消息
---task  SubmitTaskRequest
---ToServer
LuaEnumNetDef.ReqSubmitTaskMessage = 102002

---返回任务列表
---task  ResTaskData
---ToClient
LuaEnumNetDef.ResAllTaskListMessage = 102003

---返回支线任务状态
---task  ResOtherTaskState
---ToClient
LuaEnumNetDef.ResOtherTaskStateMessage = 102004

---请求打开面板
---task  OpenPanelInfoRequest
---ToServer
LuaEnumNetDef.ReqOpenPanelInfoMessage = 102005

---请求接受任务
---task  AcceptTaskRequest
---ToServer
LuaEnumNetDef.ReqAcceptTaskMessage = 102006

---请求立即完成指定任务
---task  CompleteTaskQuicklyRequest
---ToServer
LuaEnumNetDef.ReqCompleteTaskQuicklyMessage = 102007

---返回循环任务面板
---task  ResRecycleTaskInfo
---ToClient
LuaEnumNetDef.ResRecycleTaskInfoMessage = 102008

---一键完成任务
---task  AutoFinishTaskRequest
---ToServer
LuaEnumNetDef.ResAutoFinishTaskMessage = 102009

---购买雇佣兵次数
---task  BuyMercenaryTaskTimesRequest
---ToServer
LuaEnumNetDef.ReqBuyMercenaryTaskTimesMessage = 102010

---返回雇佣兵任务面板信息
---task  ResMercenaryTaskInfo
---ToClient
LuaEnumNetDef.ResMercenaryTaskInfoMessage = 102011

---返回日常任务面板信息
---task  ResDailyTaskInfo
---ToClient
LuaEnumNetDef.ResDailyTaskInfoMessage = 102012

---购买日常任务次数
---task  BuyDailyTaskTimesRequest
---ToServer
LuaEnumNetDef.ReqBuyDailyTaskTimesMessage = 102013

---返回主线任务面板
---task  ResMainTaskInfo
---ToClient
LuaEnumNetDef.ResMainTaskInfoMessage = 102014

---请求日常材料列表
---task  ReqMaterialList
---ToServer
LuaEnumNetDef.ReqMaterialListMessage = 102015

---返回日常材料列表
---task  ResMaterialList
---ToClient
LuaEnumNetDef.ResMaterialListMessage = 102016

---请求购买或者出售日常材料
---task  ReqBuyMaterial
---ToServer
LuaEnumNetDef.ReqBuyMaterialMessage = 102017

---返回支线任务信息
---task  ResMainOtherTaskInfoPanel
---ToClient
LuaEnumNetDef.ResMainOtherTaskInfoPanelMessage = 102018

---提交日常任务物品
---task  ReqSubmitDailyItem
---ToServer
LuaEnumNetDef.ReqSubmitDailyItemMessage = 102019

---攻略
---task  ResTaskStrategy
---ToClient
LuaEnumNetDef.ResTaskStrategyMessage = 102020

---返回精英任务
---task  ResEliteTaskInfoPanel
---ToClient
LuaEnumNetDef.ResEliteTaskInfoPanelMessage = 102021

---请求任务设置
---task  TaskSetting
---ToServer
LuaEnumNetDef.ReqTaskSettingMessage = 102022

---返回任务设置
---task  TaskSetting
---ToClient
LuaEnumNetDef.ResTaskSettingMessage = 102023

---购买精英任务
---ToServer
LuaEnumNetDef.ReqEliteTaskBuyTimesMessage = 102024

---精英任务购买价格请求
---ToServer
LuaEnumNetDef.ReqEliteBuyPriceMessage = 102025

---精英任务购买价格回复
---task  ResEliteBuyPrice
---ToClient
LuaEnumNetDef.ResEliteBuyPriceMessage = 102026

---返回Boss任务
---task  ResBossTaskInfoPanel
---ToClient
LuaEnumNetDef.ResBossTaskInfoPanelMessage = 102027

---返回怪物悬赏任务
---task  ResMonsterRewardTaskInfoPanel
---ToClient
LuaEnumNetDef.ResMonsterRewardTaskInfoPanelMessage = 102028

---任务奖励提示
---task  TheTaskHasRewarded
---ToClient
LuaEnumNetDef.ResTheTaskHasRewardedMessage = 102029

---现有全部
---ToClient
LuaEnumNetDef.ResMonsterTaskAllCompleteMessage = 102030

---请求领取每日任务
---task  ReqAccepNewDailyTask
---ToServer
LuaEnumNetDef.ReqAccepNewDailyTaskMessage = 102031

---请求提交每日任务
---task  ReqSubmitNewDailyTask
---ToServer
LuaEnumNetDef.ReqSubmitNewDailyTaskMessage = 102032

---全部日常任务信息
---task  ResAllNewDailyTaskInfo
---ToClient
LuaEnumNetDef.ResAllNewDailyTaskInfoMessage = 102033

---请求提交灵魂任务道具
---task  SubmitSoulTaskItem
---ToServer
LuaEnumNetDef.ReqSubmitSoulTaskItemMessage = 102034

---请求领取灵魂任务奖励
---ToServer
LuaEnumNetDef.ReqGetSoulTaskRewardMessage = 102035

---灵魂任务信息
---task  SoulTaskInfo
---ToClient
LuaEnumNetDef.ResSoulTaskStateMessage = 102036
--endregion

--region ID:103  servant
---返回仆从信息
---servant  ResServantInfo
---ToClient
LuaEnumNetDef.ResServantInfoMessage = 103001

---请求升级仆从
---servant  ReqInjectExp
---ToServer
LuaEnumNetDef.ReqUpServantMessage = 103002

---请求切换状态
---servant  ReqServantChangeState
---ToServer
LuaEnumNetDef.ReqServantChangeStateMessage = 103003

---请求元灵转生
---servant  ServantIdInfo
---ToServer
LuaEnumNetDef.ReqUpLevelServantReinMessage = 103004

---请求元灵兑换灵力
---servant  ServantIdInfo
---ToServer
LuaEnumNetDef.ReqServantExchangeReinMessage = 103005

---请求使用元灵蛋
---servant  ReqUseServantEgg
---ToServer
LuaEnumNetDef.ReqUseServantEggMessage = 103006

---请求仆从信息
---ToServer
LuaEnumNetDef.ReqServantInfoMessage = 103007

---元灵经验更新
---servant  ServantExpUpdate
---ToClient
LuaEnumNetDef.ResServantExpUpdateMessage = 103008

---元灵血量更新
---servant  ServantHpUpdate
---ToClient
LuaEnumNetDef.ResServantHpUpdateMessage = 103009

---请求修改元灵名字
---servant  ReqServantRename
---ToServer
LuaEnumNetDef.ReqRenameMessage = 103010

---返回元灵名字
---servant  ResServantName
---ToClient
LuaEnumNetDef.ResNameMessage = 103011

---灵兽升级包
---servant  ResServantLevelUp
---ToClient
LuaEnumNetDef.ResServantLevelUpMessage = 103012

---灵兽转生包
---servant  ResServantReinUp
---ToClient
LuaEnumNetDef.ResServantReinUpMessage = 103013

---返回使用灵兽蛋
---servant  ResServantName
---ToClient
LuaEnumNetDef.ResUseServantEggMessage = 103014

---请求他人灵兽信息
---servant  ReqOtherServantInfo
---ToServer
LuaEnumNetDef.ReqOtherServantInfoMessage = 103015

---返回他人灵兽信息
---servant  ResOtherServantInfo
---ToClient
LuaEnumNetDef.ResOtherServantInfoMessage = 103016

---灵兽出战, 合体属性变化飘字
---servant  ResServantStateChange
---ToClient
LuaEnumNetDef.ResServantStateChangeMessage = 103017

---返回单个灵兽信息
---servant  ServantInfo
---ToClient
LuaEnumNetDef.ResSingleServantInfoMessage = 103018

---请求通灵魂继
---servant  ReqServantEquipSoul
---ToServer
LuaEnumNetDef.ReqServantEquipSoulMessage = 103019

---返回单个灵兽信息
---servant  ServantInfo
---ToClient
LuaEnumNetDef.ResSingleServantInfoExMessage = 103020

---请求购买灵兽位信息
---servant  ReqPurchaseServantSite
---ToServer
LuaEnumNetDef.ReqPurchaseServantSiteMessage = 103021

---提醒开启灵兽位
---ToClient
LuaEnumNetDef.ResRemindOpenServantSiteMessage = 103022

---登陆地图灵兽合体
---ToClient
LuaEnumNetDef.ResLoginMapServantHetTiMessage = 103023

---请求领取灵兽灵力
---servant  ReqReceiveMana
---ToServer
LuaEnumNetDef.ReqReceiveManaMessage = 103024

---打开灵兽聚灵面板
---ToServer
LuaEnumNetDef.ReqOpneServantManaMessage = 103025

---打开灵兽聚灵面板
---servant  ServantMana
---ToClient
LuaEnumNetDef.ResOpneServantManaMessage = 103026
--endregion

--region ID:104  trade
---请求进行交易
---trade  ReqTrade
---ToServer
LuaEnumNetDef.ReqTradeMessage = 104001

---返回交易请求
---trade  ResTrade
---ToClient
LuaEnumNetDef.ResTradeMessage = 104002

---同意交易
---trade  ReqAgreeTrade
---ToServer
LuaEnumNetDef.ReqAgreeTradeMessage = 104003

---设置交易进度
---trade  ReqSetTradeProgress
---ToServer
LuaEnumNetDef.ReqSetTradeProgressMessage = 104006

---返回交易状态变化
---trade  ResTradeStateChange
---ToClient
LuaEnumNetDef.ResTradeStateChangeMessage = 104007

---交易开始
---trade  TradeInfo
---ToClient
LuaEnumNetDef.ResTradeStartMessage = 104008

---交易变化
---trade  TradeInfo
---ToClient
LuaEnumNetDef.ResTradeUpdateMessage = 104009

---添加物品请求
---trade  AddItemToTradeRequest
---ToServer
LuaEnumNetDef.ReqAddItemToTradeMessage = 104010

---去除物品请求
---trade  RemoveItemFromTradeRequest
---ToServer
LuaEnumNetDef.ReqRemoveItemFromTradeMessage = 104011

---设置交易金额
---trade  SetTradeMoneyRequest
---ToServer
LuaEnumNetDef.ReqSetTradeMoneyMessage = 104012
--endregion

--region ID:105  cart
---请求镖师面板
---ToServer
LuaEnumNetDef.ReqBodyGuardInfoMessage = 105001

---返回镖师面板
---cart  ResBodyGuardInfo
---ToClient
LuaEnumNetDef.ResBodyGuardInfoMessage = 105002

---请求参与押镖
---ToServer
LuaEnumNetDef.ReqJoinUnionCartMessage = 105003

---请求退出押镖
---ToServer
LuaEnumNetDef.ReqWithdrawUnionCartMessage = 105004

---返回押镖信息
---cart  ResUnionCartInfo
---ToClient
LuaEnumNetDef.ResUnionCartInfoMessage = 105005

---返回退出押镖响应
---ToClient
LuaEnumNetDef.ResWithdrawUnionCartMessage = 105006

---行会镖车结束消息
---cart  ResUnionCartFinish
---ToClient
LuaEnumNetDef.ResUnionCartFinishMessage = 105007

---请求个人押镖列表
---ToServer
LuaEnumNetDef.ReqPersonalCartListMessage = 105008

---返回个人押镖列表
---cart  ResPersonalCartList
---ToClient
LuaEnumNetDef.ResPersonalCartListMessage = 105009

---返回个人镖车动态
---cart  ResPersonalCartSituation
---ToClient
LuaEnumNetDef.ResPersonalCartSituationMessage = 105010

---请求押镖
---cart  ReqEscortCart
---ToServer
LuaEnumNetDef.ReqEscortCartMessage = 105011

---返回更新个人镖车列表
---cart  ResUpdatePersonalCart
---ToClient
LuaEnumNetDef.ResUpdatePersonalCartMessage = 105012

---请求领取押镖奖励
---cart  ReqReceiveReward
---ToServer
LuaEnumNetDef.ReqReceivePersonalCartRewardMessage = 105013

---返回个人镖车错误码
---cart  CartMatterCode
---ToClient
LuaEnumNetDef.ResCartMatterCodeMessage = 105014

---返回更新个人镖车血量
---cart  ResPersonalCartHpUpdate
---ToClient
LuaEnumNetDef.ResPersonalCartHpUpdateMessage = 105015

---请求行会押镖排行
---ToServer
LuaEnumNetDef.ReqUnionCartRankMessage = 105016

---返回行会押镖排行
---cart  UnionCartRank
---ToClient
LuaEnumNetDef.ResUnionCartRankMessage = 105017

---请求行会押镖上次活动排行
---cart  ReqUnionCartRankRecord
---ToServer
LuaEnumNetDef.ReqUnionCartLastRankMessage = 105018

---返回行会押镖上次活动排行
---cart  ResUnionCartRankRecord
---ToClient
LuaEnumNetDef.ResUnionCartLastRankMessage = 105019

---请求个人镖车坐标
---cart  ReqPersonalCartPosition
---ToServer
LuaEnumNetDef.ReqPersonalCartPositionMessage = 105020

---返回个人镖车坐标
---cart  ResPersonalCartPosition
---ToClient
LuaEnumNetDef.ResPersonalCartPositionMessage = 105021

---请求开始运货押镖
---cart  ReqStartFreightCar
---ToServer
LuaEnumNetDef.ReqStartFreightCarMessage = 105022

---运货押镖车信息
---cart  ResFreightCarInfo
---ToClient
LuaEnumNetDef.ResFreightCarInfoMessage = 105023

---返回个人押镖信息
---cart  ResRoleFreightInfo
---ToClient
LuaEnumNetDef.ResRoleFreightInfoMessage = 105024

---请求放弃押镖
---ToServer
LuaEnumNetDef.ReqGiveUpFreightCarMessage = 105025

---返会飙车血量
---cart  ResFreightCarHpChange
---ToClient
LuaEnumNetDef.ResFreightCarHpChangeMessage = 105026

---返回飙车XY变更
---cart  ResFreightCarPointChange
---ToClient
LuaEnumNetDef.ResFreightCarPointChangeMessage = 105027

---送货押镖结束包
---cart  ResFinishFreightCar
---ToClient
LuaEnumNetDef.ResFinishFreightCarMessage = 105028

---请求个人玩家押镖运货信息
---ToServer
LuaEnumNetDef.ReqGetRoleFreightCarInfoMessage = 105029
--endregion

--region ID:108  active
---玩家活跃度
---active  ActiveInfo
---ToClient
LuaEnumNetDef.ResActiveDataMessage = 108001

---领取活跃度奖励请求
---active  GetActiveRewardRequest
---ToServer
LuaEnumNetDef.ReqGetActiveRewardsMessage = 108002

---完成活跃度请求
---active  GetActiveCompleteRequest
---ToServer
LuaEnumNetDef.ReqGetActiveCompleteMessage = 108003
--endregion

--region ID:109  redbag
---发送红包请求
---redbag  RedBagDonateRequest
---ToServer
LuaEnumNetDef.ReqSendRedBagMessage = 109001

---红包信息
---redbag  RedBagInfo
---ToClient
LuaEnumNetDef.ResRedBagInfoMessage = 109002

---领取红包请求
---ToServer
LuaEnumNetDef.ReqGetRedBagMessage = 109003

---红包信息请求
---ToServer
LuaEnumNetDef.ReqRedBagInfoMessage = 109004

---第一次红包信息
---redbag  RedBagInfo
---ToClient
LuaEnumNetDef.ResFirstRedBagMessage = 109006

---别人发红包信息
---ToClient
LuaEnumNetDef.ResOtherSendRedBagMessage = 109007
--endregion

--region ID:110  element
---请求元素套装信息
---ToServer
LuaEnumNetDef.ReqElementSuitInfoMessage = 110001

---发送元素套装信息
---element  ResElementSuitInfo
---ToClient
LuaEnumNetDef.ResElementSuitInfoMessage = 110002

---请求镶嵌元素
---element  ReqPutUpElement
---ToServer
LuaEnumNetDef.ReqPutUpElementMessage = 110003

---请求取下元素
---element  ReqTakeOffElement
---ToServer
LuaEnumNetDef.ReqTakeOffElementMessage = 110004
--endregion

--region ID:111  auction
---获取商品列表请求
---auction  GetAuctionItemsRequest
---ToServer
LuaEnumNetDef.ReqGetAuctionItemsMessage = 111001

---商品列表响应
---auction  AuctionItemList
---ToClient
LuaEnumNetDef.ResGetAuctionItemsMessage = 111002

---获取自己的上架商品列表请求
---auction  GetOneSelfItemList
---ToServer
LuaEnumNetDef.ReqGetAuctionShelfMessage = 111003

---自己已上架商品列表响应
---auction  AuctionItemShelfList
---ToClient
LuaEnumNetDef.ResGetAuctionShelfMessage = 111004

---上架请求
---auction  AddToShelfRequest
---ToServer
LuaEnumNetDef.ReqAddToShelfMessage = 111005

---上架响应
---auction  AddToShelfResponse
---ToClient
LuaEnumNetDef.ResAddToShelfMessage = 111006

---重新上架请求
---auction  ReAddToShelfRequest
---ToServer
LuaEnumNetDef.ReqReAddToShelfMessage = 111007

---重新上架响应
---auction  AuctionItemInfo
---ToClient
LuaEnumNetDef.ResReAddToShelfMessage = 111008

---下架请求
---auction  PutOffRequest
---ToServer
LuaEnumNetDef.ReqRemoveFromShelfMessage = 111009

---下架响应
---auction  ItemMsg
---ToClient
LuaEnumNetDef.ResRemoveFromShelfMessage = 111010

---购买请求
---auction  BuyAuction
---ToServer
LuaEnumNetDef.ReqBuyAuctionAuctionMessage = 111011

---购买响应
---auction  ItemMsg
---ToClient
LuaEnumNetDef.ResBuyAuctionItemMessage = 111012

---吆喝请求
---auction  ItemIdMsg
---ToServer
LuaEnumNetDef.ReqAuctionChatMessage = 111013

---搜索请求
---auction  SearchAuctionItem
---ToServer
LuaEnumNetDef.ReqAuctionSearchMessage = 111014

---搜索响应
---auction  SearchAuctionItemResponse
---ToClient
LuaEnumNetDef.ResAuctionSearchMessage = 111015

---购买失败响应
---auction  lose
---ToClient
LuaEnumNetDef.ResBuyLoseMessage = 111016

---上架失败响应
---auction  lose
---ToClient
LuaEnumNetDef.ResAddToShelfLoseMessage = 111017

---请求拍卖品的价格区间
---auction  MarketPriceSectionRequest
---ToServer
LuaEnumNetDef.ReqMarketPriceSectionMessage = 111018

---拍卖品的价格区间响应
---auction  MarketPriceSection
---ToClient
LuaEnumNetDef.ResMarketPriceSectionMessage = 111019

---拍卖请求
---auction  auctionRequest
---ToServer
LuaEnumNetDef.ReqAuctionLotMessage = 111020

---拍卖响应
---auction  AuctionItemInfo
---ToClient
LuaEnumNetDef.ResAuctionLotMessage = 111021

---请求求购的价格区间
---auction  BuyProductsMarketPriceSectionRequest
---ToServer
LuaEnumNetDef.ReqBuyProductsMarketPriceSectionMessage = 111022

---发布求购请求
---auction  ReleaseBuyProductsRequest
---ToServer
LuaEnumNetDef.ReqReleaseBuyProductsMessage = 111023

---发布求购响应
---auction  AuctionItemInfo
---ToClient
LuaEnumNetDef.ResReleaseBuyProductsMessage = 111024

---提交求购的物品
---auction  SubmitBuyProductsItemRequest
---ToServer
LuaEnumNetDef.ReqSubmitBuyProductsItemMessage = 111025

---提交求购的物品响应
---auction  SubmitBuyProductsItemResponse
---ToClient
LuaEnumNetDef.ResSubmitBuyProductsItemMessage = 111026

---推送响应
---auction  pushResponse
---ToClient
LuaEnumNetDef.ResPushMessage = 111027

---购买失败原因响应
---auction  AuctionFailReason
---ToClient
LuaEnumNetDef.ResBuyFailReasonMessage = 111028

---猜你喜欢请求
---auction  GuessYouLikeRequest
---ToServer
LuaEnumNetDef.ReqGuessYouLikeMessage = 111029

---猜你喜欢响应
---auction  GuessYouLikeResponse
---ToClient
LuaEnumNetDef.ResGuessYouLikeMessage = 111030

---打开交易行之前的请求
---ToServer
LuaEnumNetDef.ReqOpenTradeBeforeMessage = 111031

---打开交易行之前的响应
---auction  OpenTradeBeforeResponse
---ToClient
LuaEnumNetDef.ResOpenTradeBeforeMessage = 111032

---请求交易记录
---auction  TeadeRecordReq
---ToServer
LuaEnumNetDef.ReqTradeRecordInfoMessage = 111033

---交易记录响应
---auction  TeadeRecordRes
---ToClient
LuaEnumNetDef.ResTradeRecordInfoMessage = 111034

---领取交易记录请求
---auction  TradeRecordId
---ToServer
LuaEnumNetDef.ReqReceiveTradeRecordMessage = 111035

---领取交易记录响应
---auction  TradeRecordId
---ToClient
LuaEnumNetDef.ResReceiveTradeRecordMessage = 111036

---交易记录红点提示
---auction  TradeRecordRedPoint
---ToClient
LuaEnumNetDef.ResTradeRecordRedPointMessage = 111037

---行会熔炼物品变动
---auction  UnionSmeltGoodsChange
---ToClient
LuaEnumNetDef.ResUnionSmeltGoodsChangeMessage = 111038

---请求行会熔炼商品
---ToServer
LuaEnumNetDef.ReqGetUnionSmeltItemMessage = 111039

---兑换行会熔炼商品
---auction  BuyUnionSmeltItem
---ToServer
LuaEnumNetDef.ReqBuyUnionSmeltItemMessage = 111040

---新增购买推送
---auction  AuctionPush
---ToClient
LuaEnumNetDef.ResAuctionPushMessage = 111041

---请求本次登录不再推送
---auction  CurLoginNoPush
---ToServer
LuaEnumNetDef.ReqCurLoginNoPushMessage = 111042

---请求快捷购买道具
---auction  ReqQuickAuctionItem
---ToServer
LuaEnumNetDef.ReqQuickAuctionItemMessage = 111043

---返回快捷购买道具
---auction  ResQuickAuctionItem
---ToClient
LuaEnumNetDef.ResQuickAuctionItemMessage = 111044
--endregion

--region ID:111  collect
---藏品上架请求
---collect  PutCollectionItemMsg
---ToServer
LuaEnumNetDef.ReqPutCollectionItemMessage = 111101

---藏品上架响应
---collect  PutCollectionItemMsg
---ToClient
LuaEnumNetDef.ResPutCollectionItemMessage = 111102

---藏品下架请求
---collect  RemoveCollectionItemMsg
---ToServer
LuaEnumNetDef.ReqRemoveCollectionItemMessage = 111103

---藏品下架响应
---collect  RemoveCollectionItemMsg
---ToClient
LuaEnumNetDef.ResRemoveCollectionItemMessage = 111104

---藏品交换位置架请求
---collect  SwapCollectionItemMsg
---ToServer
LuaEnumNetDef.ReqSwapCollectionItemMessage = 111105

---藏品交换位置响应
---collect  CabinetInfo
---ToClient
LuaEnumNetDef.ResSwapCollectionItemMessage = 111106

---藏品回收请求
---collect  CallbackCollectionMsg
---ToServer
LuaEnumNetDef.ReqCallbackCollectionMessage = 111107

---藏品回收响应
---collect  CallbackCollectionMsg
---ToClient
LuaEnumNetDef.ResCallbackCollectionMessage = 111108

---收藏柜信息
---collect  CabinetInfo
---ToClient
LuaEnumNetDef.ResCabinetMessage = 111109

---升级收藏柜请求
---ToServer
LuaEnumNetDef.ReqUpgradeCabinetMessage = 111119

---藏品合成请求
---collect  CollectionMergeRequest
---ToServer
LuaEnumNetDef.ReqCollectionMergeMessage = 111120
--endregion

--region ID:112  finger
---请求最近划拳对象
---ToServer
LuaEnumNetDef.ReqLatelyFingerPlayersMessage = 112001

---发送最近划拳对象
---finger  LatelyFingerPlayers
---ToClient
LuaEnumNetDef.ResLatelyFingerPlayersMessage = 112002

---邀请玩家划拳
---finger  ReqInviteFinger
---ToServer
LuaEnumNetDef.ReqInviteFingerMessage = 112003

---被挑战者收到邀请
---finger  ResInviteFinger
---ToClient
LuaEnumNetDef.ResInviteFingerMessage = 112004

---被挑战者请求回应邀请
---finger  ReqEchoInvite
---ToServer
LuaEnumNetDef.ReqEchoInviteMessage = 112005

---返回邀请结果
---finger  ResEchoInvite
---ToClient
LuaEnumNetDef.ResEchoInviteMessage = 112006

---请求使用筹码
---finger  ReqUseChip
---ToServer
LuaEnumNetDef.ReqUseChipMessage = 112007

---返回赢得奖励信息
---finger  ResRewardInfo
---ToClient
LuaEnumNetDef.ResFingerRewardInfoMessage = 112008

---请求出拳
---finger  ReqChoseFinger
---ToServer
LuaEnumNetDef.ReqChoseFingerMessage = 112009

---返回开始猜拳
---finger  ResAllChosed
---ToClient
LuaEnumNetDef.ResAllChosedMessage = 112010

---请求猜拳结果
---ToServer
LuaEnumNetDef.ReqFingerResultMessage = 112011

---返回猜拳结果
---finger  ResFingerReason
---ToClient
LuaEnumNetDef.ResFingerReasonMessage = 112012

---请求终止猜拳
---ToServer
LuaEnumNetDef.ReqTerminateFingerMessage = 112013

---返回终止猜拳
---finger  ResTerminate
---ToClient
LuaEnumNetDef.ResTerminateFingerMessage = 112014

---请求邀请剩余时间
---finger  ReqEchoInviteTime
---ToServer
LuaEnumNetDef.ReqEchoInviteTimeMessage = 112015

---返回邀请剩余时间
---finger  ResInviteFinger
---ToClient
LuaEnumNetDef.ResEchoInviteTimeMessage = 112016

---返回背包使用筹码
---ToClient
LuaEnumNetDef.ResUseBagChipMessage = 112017

---通知玩家对方已经出拳
---ToClient
LuaEnumNetDef.ResChoseFingerMessage = 112018
--endregion

--region ID:113  sworn
---请求结义
---ToServer
LuaEnumNetDef.ReqHasSwornMessage = 113001

---有结拜进行时返回正在结拜
---sworn  ResHasSworn
---ToClient
LuaEnumNetDef.ResHasSwornMessage = 113002

---特效开始消息
---sworn  ResSpecialEffects
---ToClient
LuaEnumNetDef.ResSpecialEffectsMessage = 113003

---返回兄弟信息
---sworn  ResYourBrother
---ToClient
LuaEnumNetDef.ResYourBrotherMessage = 113004

---向队员发送结拜面板
---sworn  SendSwornInfo
---ToClient
LuaEnumNetDef.SendSwornInfoMessage = 113005

---请求同意或不同意结义消息
---sworn  ReqAgreeSworn
---ToServer
LuaEnumNetDef.ReqAgreeSwornMessage = 113006

---返回改变同意结义消息
---sworn  ResAgreeSworn
---ToClient
LuaEnumNetDef.ResAgreeSwornMessage = 113007

---请求中断结义
---ToServer
LuaEnumNetDef.ReqInterruptSwornMessage = 113008

---中断结义
---sworn  ResInterruptSworn
---ToClient
LuaEnumNetDef.ResInterruptSwornMessage = 113009

---结义是否成功
---sworn  ResSwornSuccess
---ToClient
LuaEnumNetDef.ResSwornSuccessMessage = 113010

---请求解散兄弟关系
---sworn  ReqDissolutionBrother
---ToServer
LuaEnumNetDef.ReqDissolutionBrotherMessage = 113011

---请求撤回解散兄弟关系
---sworn  ReqRegretsDissolution
---ToServer
LuaEnumNetDef.ReqRegretsDissolutionMessage = 113012

---请求结义成功
---ToServer
LuaEnumNetDef.ReqSwornSuccessMessage = 113013

---请求解散时兄弟关系信息
---ToServer
LuaEnumNetDef.ReqBrotherInfoMessage = 113014

---成功结义后返回新添加的兄弟信息
---sworn  ResAddBrother
---ToClient
LuaEnumNetDef.ResAddBrotherMessage = 113015

---移除的兄弟信息
---sworn  ResRemoveBrother
---ToClient
LuaEnumNetDef.ResRemoveBrotherMessage = 113016

---更新单个兄弟信息
---sworn  ResOneBrother
---ToClient
LuaEnumNetDef.ResOneBrotherMessage = 113017

---请求断义列表
---ToServer
LuaEnumNetDef.ReqBreakOffRelationsMessage = 113018

---返回断义列表
---sworn  ResBreakOffRelations
---ToClient
LuaEnumNetDef.ResBreakOffRelationsMessage = 113019
--endregion

--region ID:114  marry
---请求结婚
---ToServer
LuaEnumNetDef.ReqMarryMessage = 114001

---弹出誓言面板
---marry  ResMatchmakerPanel
---ToClient
LuaEnumNetDef.ResMatchmakerPanelMessage = 114003

---确认誓言
---marry  ReqMatchmaker
---ToServer
LuaEnumNetDef.ReqMatchmakerMessage = 114004

---返回确认的誓言
---marry  ResMatchmaker
---ToClient
LuaEnumNetDef.ResMatchmakerMessage = 114005

---请求中断结婚
---ToServer
LuaEnumNetDef.ReqInterruptMarryMessage = 114007

---返回中断结婚
---ToClient
LuaEnumNetDef.ResInterruptMarryMessage = 114008

---请求升级婚戒
---ToServer
LuaEnumNetDef.ReqUpdateRingMessage = 114009

---请求离婚
---marry  ReqDivorce
---ToServer
LuaEnumNetDef.ReqDivorceMessage = 114010

---弹出离婚确认解除
---marry  ResDivorce
---ToClient
LuaEnumNetDef.ResDivorceMessage = 114011

---对方超过7天未上线，免费强制离婚确认面板，和收费强制离婚确认面板
---marry  ResConfirmDivorce
---ToClient
LuaEnumNetDef.ResConfirmDivorceMessage = 114012

---请求执行离婚
---marry  ReqImplementDivorce
---ToServer
LuaEnumNetDef.ReqImplementDivorceMessage = 114013

---在线离婚条件不足消息
---marry  ResOnlineDivorceCondition
---ToClient
LuaEnumNetDef.ResOnlineDivorceConditionMessage = 114014

---请求中断离婚
---ToServer
LuaEnumNetDef.ReqInterruptDivorceMessage = 114015

---返回中断离婚
---ToClient
LuaEnumNetDef.ResInterruptDivorceMessage = 114016

---结婚改变消息
---marry  ResChangeMarry
---ToClient
LuaEnumNetDef.ResChangeMarryMessage = 114017

---获取当前对象信息
---marry  ResGetSpouse
---ToClient
LuaEnumNetDef.ResGetSpouseMessage = 114018

---请求悔婚
---ToServer
LuaEnumNetDef.ReqRegretMarriageMessage = 114019

---缺少戒指消息
---marry  ResLackRings
---ToClient
LuaEnumNetDef.ResLackRingsMessage = 114020

---确认悔婚消息
---ToServer
LuaEnumNetDef.ReqConfirmRegretMarriageMessage = 114021

---请求中断中断悔婚
---ToServer
LuaEnumNetDef.ReqInterruptRegretMarriageMessage = 114022

---返回中断悔婚
---ToClient
LuaEnumNetDef.ResInterruptRegretMarriageMessage = 114023

---查看玩家婚姻信息
---marry  ResPlayerMarriageInformation
---ToClient
LuaEnumNetDef.ResPlayerMarriageInformationMessage = 114024

---返回升级婚戒
---marry  ResUpdateRing
---ToClient
LuaEnumNetDef.ResUpdateRingMessage = 114025

---请求查看誓言
---ToServer
LuaEnumNetDef.ReqSeeOathMessage = 114026

---返回誓言
---marry  ResSeeOath
---ToClient
LuaEnumNetDef.ResSeeOathMessage = 114027

---请求修改誓言
---marry  ReqUpdateOath
---ToServer
LuaEnumNetDef.ReqUpdateOathMessage = 114028

---请求查看刻字
---ToServer
LuaEnumNetDef.ReqSeeLetteringMessage = 114029

---返回刻字
---marry  ResSeeLettering
---ToClient
LuaEnumNetDef.ResSeeLetteringMessage = 114030

---请求修改刻字
---marry  ReqUpdateLettering
---ToServer
LuaEnumNetDef.ReqUpdateLetteringMessage = 114031

---输入完成誓言判断屏蔽字
---marry  ReqVerificationOath
---ToServer
LuaEnumNetDef.ReqVerificationOathMessage = 114032

---请求判断刻字屏蔽字
---marry  ReqVerificationLettering
---ToServer
LuaEnumNetDef.ReqVerificationLetteringMessage = 114033

---请求赠送钻石
---marry  ReqGiveJewel
---ToServer
LuaEnumNetDef.ReqGiveJewelMessage = 114034

---离婚时间到了清空数据
---ToServer
LuaEnumNetDef.ReqCleanMarryMessage = 114036

---请求查看其他玩家婚姻信息
---marry  ReqSeeOthersMarriageInfo
---ToServer
LuaEnumNetDef.ReqSeeOthersMarriageInfoMessage = 114037

---查看其他玩家婚姻信息
---marry  ResSeeOthersMarriageInfo
---ToClient
LuaEnumNetDef.ResSeeOthersMarriageInfoMessage = 114038
--endregion

--region ID:120  imprint
---请求印记信息
---ToServer
LuaEnumNetDef.ReqImprintInfoMessage = 120001

---返回印记信息
---imprint  ResImprintInfo
---ToClient
LuaEnumNetDef.ResImprintInfoMessage = 120002

---请求镶嵌
---imprint  ReqPutOnImprint
---ToServer
LuaEnumNetDef.ReqPutOnImprintMessage = 120003

---请求取下
---imprint  ReqTakeOffImprint
---ToServer
LuaEnumNetDef.ReqTakeOffImprintMessage = 120004

---镶嵌成功返回
---imprint  ResPutOnImprint
---ToClient
LuaEnumNetDef.ResPutOnImprintMessage = 120005

---取下成功返回
---imprint  ResTakeOffImprint
---ToClient
LuaEnumNetDef.ResTakeOffImprintMessage = 120006
--endregion

--region ID:121  appearance
---请求启用的时装列表
---ToServer
LuaEnumNetDef.ReqGetWearFashionMessage = 121001

---返回启用的时装列表
---appearance  ResGetWearFashion
---ToClient
LuaEnumNetDef.ResGetWearFashionMessage = 121002

---请求拥有的时装列表
---ToServer
LuaEnumNetDef.ReqGetHasFashionMessage = 121003

---返回拥有的时装列表
---appearance  ResGetHasFashion
---ToClient
LuaEnumNetDef.ResGetHasFashionMessage = 121004

---请求起用这件时装
---appearance  ReqEnableFashion
---ToServer
LuaEnumNetDef.ReqEnableFashionMessage = 121005

---请求起用关闭称谓
---appearance  ReqEnableTitle
---ToServer
LuaEnumNetDef.ReqEnableTitleMessage = 121007

---请求修改称谓
---appearance  ReqModifyTitle
---ToServer
LuaEnumNetDef.ReqModifyTitleMessage = 121008

---返回修改称谓
---appearance  ResModifyTitle
---ToClient
LuaEnumNetDef.ResModifyTitleMessage = 121009

---返回所有称谓
---appearance  ResGetHasAppellation
---ToClient
LuaEnumNetDef.ResGetHasAppellationMessage = 121010

---返回正在使用称谓
---appearance  ResEnableAppellation
---ToClient
LuaEnumNetDef.ResEnableAppellationMessage = 121011

---外观红点
---appearance  ResAppearanceRedPoint
---ToClient
LuaEnumNetDef.ResAppearanceRedPointMessage = 121012
--endregion

--region ID:122  merit
---请求霸业活动数据
---merit  ReqGetMeritData
---ToServer
LuaEnumNetDef.ReqGetMeritDataMessage = 122001

---返回行会之争
---merit  ResUnionBattle
---ToClient
LuaEnumNetDef.ResUnionBattleMessage = 122002

---霸业活动红点
---merit  ResMeritRedPoint
---ToClient
LuaEnumNetDef.ResMeritRedPointMessage = 122003

---返回领袖之路
---merit  ResLeaderGlory
---ToClient
LuaEnumNetDef.ResLeaderGloryMessage = 122004

---返回建功立业
---merit  ResUnionAchievement
---ToClient
LuaEnumNetDef.ResUnionAchievementMessage = 122005

---请求领奖行会之争
---merit  ReqRewardUinonBattle
---ToServer
LuaEnumNetDef.ReqRewardUinonBattleMessage = 122006

---请求领奖领袖之路
---merit  ReqRewardLeaderGlory
---ToServer
LuaEnumNetDef.ReqRewardLeaderGloryMessage = 122007

---请求领奖建功立业
---merit  ReqRewardUnionAchievement
---ToServer
LuaEnumNetDef.ReqRewardUnionAchievementMessage = 122008

---领奖返回
---merit  ResReturnRewardState
---ToClient
LuaEnumNetDef.ResReturnRewardStateMessage = 122009

---请求领袖之路小面板
---merit  ReqPositionInfo
---ToServer
LuaEnumNetDef.ReqPositionInfoMessage = 122010

---返回领袖之路小面板
---merit  ResPositionInfo
---ToClient
LuaEnumNetDef.ResPositionInfoMessage = 122011
--endregion

--region ID:123  booth
---摊位地图请求
---booth  BoothMaps
---ToServer
LuaEnumNetDef.ReqBoothMapsMessage = 123001

---摊位地图响应
---booth  BoothMapsResponse
---ToClient
LuaEnumNetDef.ResBoothMapsMessage = 123002

---创建摊位请求
---booth  CreateBoothRequest
---ToServer
LuaEnumNetDef.ReqCreateBoothMessage = 123003

---创建摊位响应
---booth  BoothInfo
---ToClient
LuaEnumNetDef.ResCreateBoothMessage = 123004

---改变摊位名字请求
---booth  ChangeBoothNameRequest
---ToServer
LuaEnumNetDef.ReqChangeBoothNameMessage = 123005

---改变摊位名字响应
---ToClient
LuaEnumNetDef.ResChangeBoothNameMessage = 123006

---取消摊位请求
---booth  CancelBooth
---ToServer
LuaEnumNetDef.ReqCancelBoothMessage = 123007

---取消摊位响应
---ToClient
LuaEnumNetDef.ResCancelBoothMessage = 123008

---请求摊位的商品列表信息
---booth  BoothIdMsg
---ToServer
LuaEnumNetDef.ReqGetBoothItemsMessage = 123009

---摊位的商品列表信息响应
---booth  BoothItemList
---ToClient
LuaEnumNetDef.ResGetBoothItemsMessage = 123010

---请求摊位信息
---booth  GetShelfBoothInfo
---ToServer
LuaEnumNetDef.ReqGetShelfBoothInfoMessage = 123011

---摊位信息响应
---booth  ResBoothInfo
---ToClient
LuaEnumNetDef.ResGetShelfBoothInfoMessage = 123012

---摊位购买请求
---booth  BoothBuy
---ToServer
LuaEnumNetDef.ReqBoothBuyMessage = 123013

---摊位购买响应
---ToClient
LuaEnumNetDef.ResBoothBuyMessage = 123014

---得到更新的摊位坐标请求
---booth  BoothPointRequest
---ToServer
LuaEnumNetDef.ReqGetUpdateBoothPointMessage = 123015

---得到更新的摊位坐标响应
---booth  BoothCoordinateIdMsg
---ToClient
LuaEnumNetDef.ResGetUpdateBoothPointMessage = 123016

---更新摊位坐标请求
---booth  BoothCoordinateIdMsg
---ToServer
LuaEnumNetDef.ReqUpdateBoothPointMessage = 123017

---更新摊位坐标响应
---booth  UpdateBoothPointResponse
---ToClient
LuaEnumNetDef.ResUpdateBoothPointMessage = 123018

---创建苍月摊位请求
---booth  CreateBoothRequest
---ToServer
LuaEnumNetDef.ReqCreateMoonBoothMessage = 123019

---请求摊位的商品列表信息
---booth  BoothIdMsg
---ToServer
LuaEnumNetDef.ReqGetMoonBoothItemsMessage = 123020

---请求广播来纳夫摊位坐标及物品信息
---booth  ReqUniteServerItemRadio
---ToServer
LuaEnumNetDef.ReqUniteServerItemRadioMessage = 123021
--endregion

--region ID:124  npcstore
---请求NPC商店
---npcstore  ReqGetNpcStoreInfo
---ToServer
LuaEnumNetDef.ReqGetNpcStoreMessage = 124001

---返回NPC商店
---npcstore  ResNpcStoreInfo
---ToClient
LuaEnumNetDef.ResNpcStoreMessage = 124002

---请求NPC商店出售列表
---npcstore  ReqSellList
---ToServer
LuaEnumNetDef.ReqGetNpcStoreSellListMessage = 124003

---返回NPC商店出售列表
---npcstore  NpcStoreGridList
---ToClient
LuaEnumNetDef.ResNpcStoreSellListMessage = 124004

---请求NPC商店上架
---npcstore  ReqPutOnNpcStoreItem
---ToServer
LuaEnumNetDef.ReqNpcStorePutOnMessage = 124005

---返回NPC商店上架
---npcstore  ResPutOnNpcStoreItem
---ToClient
LuaEnumNetDef.ResNpcStorePutOnMessage = 124006

---请求NPC商店购买
---npcstore  ReqBuyNpcStore
---ToServer
LuaEnumNetDef.ReqNpcStoreBuyMessage = 124007

---返回NPC商店购买
---npcstore  ResBuyNpcStore
---ToClient
LuaEnumNetDef.ResNpcStoreBuyMessage = 124008
--endregion

--region ID:127  rechargegiftbox
---请求充值礼包信息
---ToServer
LuaEnumNetDef.ReqRechargeGiftBoxMessage = 127001

---更新充值礼包信息
---rechargegiftbox  RechargeGiftBoxInfo
---ToClient
LuaEnumNetDef.ResUpdateRechargeGiftBoxMessage = 127002

---请求领取在线礼包
---rechargegiftbox  RewardId
---ToServer
LuaEnumNetDef.ReqReceiveOnlineGiftBoxMessage = 127003

---发送领取在线礼包返回消息
---rechargegiftbox  RewardId
---ToClient
LuaEnumNetDef.ResReceiveOnlineGiftBoxMessage = 127004

---请求领取累充礼包
---rechargegiftbox  RewardId
---ToServer
LuaEnumNetDef.ReqReceiveTotalRechargeGiftBoxMessage = 127005

---发送领取累充礼包返回消息
---rechargegiftbox  RewardId
---ToClient
LuaEnumNetDef.ResReceiveTotalRechargeGiftBoxMessage = 127006

---请求分享
---ToServer
LuaEnumNetDef.ReqShareMessage = 127007

---请求领取分享礼包
---rechargegiftbox  RewardId
---ToServer
LuaEnumNetDef.ReqReceiveShareGiftBoxMessage = 127008

---发送领取在线礼包返回消息
---rechargegiftbox  RewardId
---ToClient
LuaEnumNetDef.ResReceiveShareGiftBoxMessage = 127009

---请求领取连充礼包
---rechargegiftbox  RewardId
---ToServer
LuaEnumNetDef.ReqReceiveContinuousGiftBoxMessage = 127010

---发送领取连充礼包返回消息
---rechargegiftbox  RewardId
---ToClient
LuaEnumNetDef.ResReceiveContinuousGiftBoxMessage = 127011

---请求领取每日累充礼包
---rechargegiftbox  RewardId
---ToServer
LuaEnumNetDef.ReqReceiveDailyRechargeGiftBoxMessage = 127012

---发送领取每日累充礼包返回消息
---rechargegiftbox  RewardId
---ToClient
LuaEnumNetDef.ResReceiveDailyRechargeGiftBoxMessage = 127013

---开服循环礼包信息
---rechargegiftbox  ResRoleCycleGiftBoxInfo
---ToClient
LuaEnumNetDef.ResRoleCycleGiftBoxInfoMessage = 127014

---开服循环礼包请求
---ToServer
LuaEnumNetDef.ReqRoleCycleGiftBoxInfoMessage = 127015
--endregion

--region ID:128  activities
---返回所有打开的活动奖励
---activities  AllActivitiesOpenInfo
---ToClient
LuaEnumNetDef.ResAllOpenActivitiesMessage = 128001

---请求某类活动信息
---activities  ReqOneActivitiesInfo
---ToServer
LuaEnumNetDef.ReqGetOneActivitiesInfoMessage = 128002

---返回某类的活动信息
---activities  ResOneActivitiesInfo
---ToClient
LuaEnumNetDef.ResOneActivitiesInfoMessage = 128003

---请求领取活动奖励
---activities  ReqAwardActivitiesInfo
---ToServer
LuaEnumNetDef.ReqGetOneActivitiesAwardMessage = 128004

---返回领取活动奖励
---activities  ResAwardActivitiesInfo
---ToClient
LuaEnumNetDef.ResGetOneActivitiesAwardMessage = 128005

---返回某类活动的开启关闭信息
---activities  OneActivitiesInfo
---ToClient
LuaEnumNetDef.ResActivitiesOpenInfoMessage = 128006

---返回某类的活动信息
---activities  OneActivitiesInfo
---ToClient
LuaEnumNetDef.ResSubTypeActivitiesInfoMessage = 128007

---请求白日门活动面板信息
---activities  ReqSunActivitiesPanel
---ToServer
LuaEnumNetDef.ReqSunActivitiesPanelMessage = 128008

---返回白日门活动面板信息
---activities  ResSunActivitiesPanel
---ToClient
LuaEnumNetDef.ResSunActivitiesPanelMessage = 128009

---返回活动的部分变动信息.
---activities  ActivitiesPartInfo
---ToClient
LuaEnumNetDef.ResActivitiesPartInfoMessage = 128010

---同步客户端一个踢人的时间
---activities  ResKickOutTime
---ToClient
LuaEnumNetDef.ResKickOutTimeMessage = 128011
--endregion

--region ID:129  sabac
---请求排行榜
---ToServer
LuaEnumNetDef.ReqSabacDonateRankInfoMessage = 129001

---请求排行榜
---sabac  ResSabacDonateRankInfo
---ToClient
LuaEnumNetDef.ResSabacDonateRankInfoMessage = 129002

---请求捐献
---sabac  ReqSabacDonate
---ToServer
LuaEnumNetDef.ReqSabacDonateMessage = 129003
--endregion

--region ID:130  rage
---狂暴之力弹窗今天不再提示
---ToServer
LuaEnumNetDef.ReqChangeRageMessage = 130001

---狂暴之力弹窗
---ToClient
LuaEnumNetDef.ResRageTipMessage = 130002

---狂暴之力状态请求
---ToServer
LuaEnumNetDef.ReqRageStateMessage = 130003

---狂暴之力激活或取消请求
---rage  ActivateOrCancelRage
---ToServer
LuaEnumNetDef.ReqActivateOrCancelRageMessage = 130004

---狂暴之力状态响应
---rage  RageState
---ToClient
LuaEnumNetDef.ResRageStateMessage = 130005
--endregion

--region ID:131  zhenfa
---请求阵法信息
---ToServer
LuaEnumNetDef.ReqZhenfaInfoMessage = 131001

---发送阵法信息
---zhenfa  ResZhenfaInfo
---ToClient
LuaEnumNetDef.ResZhenfaInfoMessage = 131002

---请求培养阵法
---ToServer
LuaEnumNetDef.ReqUpgradeZhenfaMessage = 131003
--endregion

--region ID:132  ghostship
---请求协助
---ghostship  ReqAssist
---ToServer
LuaEnumNetDef.ReqAssistMessage = 132001

---幽灵船状态
---ghostship  GhostShipState
---ToClient
LuaEnumNetDef.ResGhostShipStateMessage = 132002

---幽灵船玩家数据
---ghostship  GhostShipRoleData
---ToClient
LuaEnumNetDef.ResGhostShipRoleDataMessage = 132003

---幽灵船剩余时间
---ghostship  GhostShipTime
---ToClient
LuaEnumNetDef.ResGhostShipRoleTimeMessage = 132004
--endregion

--region ID:150  socialcontact
---请求送花
---socialcontact  ReqSendFlowers
---ToServer
LuaEnumNetDef.ReqSendFlowersMessage = 150001

---返回送花
---ToClient
LuaEnumNetDef.ResSendFlowersMessage = 150002

---请求花的数量
---socialcontact  ReqGetTheFlowerCount
---ToServer
LuaEnumNetDef.ReqGetTheFlowerCountMessage = 150003

---返回花的数量
---socialcontact  ResGetTheFlowerCount
---ToClient
LuaEnumNetDef.ResGetTheFlowerCountMessage = 150004

---返回花的数量达到99或999
---socialcontact  ResTeXiao
---ToClient
LuaEnumNetDef.ResTeXiaoMessage = 150005

---返回默认打开的鲜花ID
---socialcontact  ResDefaultFlowerId
---ToClient
LuaEnumNetDef.ResDefaultFlowerIdMessage = 150006

---赠送有缘人
---socialcontact  FatePeople
---ToServer
LuaEnumNetDef.FatePeopleMessage = 150007

---回赠
---socialcontact  ReqRebateFlower
---ToServer
LuaEnumNetDef.ReqRebateFlowerMessage = 150008

---回复感谢
---socialcontact  ReqReplyToThank
---ToServer
LuaEnumNetDef.ReqReplyToThankMessage = 150009

---加为好友
---socialcontact  ReqSendFlowerAddFriend
---ToServer
LuaEnumNetDef.ReqSendFlowerAddFriendMessage = 150010

---同意
---socialcontact  ReqAgreeSendFlowerAddFriend
---ToServer
LuaEnumNetDef.ReqAgreeSendFlowerAddFriendMessage = 150011
--endregion

--region ID:151  servantcultivate
---灵兽开始修炼
---servantcultivate  reqCultivateInfo
---ToServer
LuaEnumNetDef.ReqServantCultivateBeginMessage = 151001

---灵兽修炼信息
---servantcultivate  resCultivateInfo
---ToClient
LuaEnumNetDef.ResServantCultivateInfoMessage = 151002

---灵兽结束修炼
---ToServer
LuaEnumNetDef.ReqServantCultivateStopMessage = 151003

---灵兽提取经验
---ToServer
LuaEnumNetDef.ReqServantCultivateTakeMessage = 151004

---灵兽修炼界面打开
---servantcultivate  reqOpenDlg
---ToServer
LuaEnumNetDef.ReqServantCultivateOpenDlgMessage = 151005

---灵兽修炼小红点
---ToClient
LuaEnumNetDef.ResServantCultivateRedMessage = 151006

---灵兽修炼飞地图坐标
---servantcultivate  reqFlyInfo
---ToServer
LuaEnumNetDef.ReqServantCultivateFlyMessage = 151007

---灵兽修炼被攻击
---servantcultivate  cultivateRedInfo
---ToClient
LuaEnumNetDef.ResServantCultivateBeAttackMessage = 151008
--endregion

--region ID:1001  sharegroup
---请求组队面板信息
---ToServer
LuaEnumNetDef.ReqShareGroupDetailedInfoMessage = 1001001

---请求改变队伍目标
---sharegroup  ReqChangeTarget
---ToServer
LuaEnumNetDef.ReqShareChangeTargetMessage = 1001002

---请求转移队伍队长
---sharegroup  ReqChangeCaptain
---ToServer
LuaEnumNetDef.ReqShareChangeCaptainMessage = 1001003

---请求创建队伍
---ToServer
LuaEnumNetDef.ReqShareCreatGroupMessage = 1001004

---请求队伍踢出玩家
---sharegroup  ReqKickMember
---ToServer
LuaEnumNetDef.ReqShareKickMemberMessage = 1001005

---玩家请求离开队伍
---sharegroup  ReqExitGroup
---ToServer
LuaEnumNetDef.ReqShareExitGroupMessage = 1001006

---接受组队申请
---sharegroup  AcceptTeam
---ToServer
LuaEnumNetDef.ReqShareAcceptApplyMessage = 1001007

---返回组队面板信息
---sharegroup  ResGroupDetailedInfo
---ToClient
LuaEnumNetDef.ResShareGroupDetailedInfoMessage = 1001008

---请求打开组队请求界面
---ToServer
LuaEnumNetDef.ReqShareApplyListMessage = 1001009

---请求加入队伍
---sharegroup  ReqJoinGroup
---ToServer
LuaEnumNetDef.ReqShareJoinGroupMessage = 1001010

---返回组队请求列表界面
---sharegroup  ApplyList
---ToClient
LuaEnumNetDef.ResShareApplyListMessage = 1001011

---玩家请求附近可以申请队伍列表
---ToServer
LuaEnumNetDef.ReqShareNearbyGroupMessage = 1001012

---返回玩家请求附近可以申请队伍列表
---sharegroup  NearbyGroup
---ToClient
LuaEnumNetDef.ResShareNearbyGroupMessage = 1001013

---请求邀请玩家
---sharegroup  ReqInvitationPlayer
---ToServer
LuaEnumNetDef.ReqShareInvitationPlayerMessage = 1001014

---玩家接受邀请
---sharegroup  ReqAcceptInvitation
---ToServer
LuaEnumNetDef.ReqShareAcceptInvitationMessage = 1001015

---玩家邀请列表响应
---sharegroup  ResInvitationList
---ToClient
LuaEnumNetDef.ResShareInvitationListMessage = 1001016

---队伍请求邀请附近的人列表
---ToServer
LuaEnumNetDef.ReqShareNearPlayerMessage = 1001017

---返回队伍请求邀请附近的人列表
---sharegroup  ResGroupInvitationNearbyList
---ToClient
LuaEnumNetDef.ResShareGroupInvitationNearbyListMessage = 1001018

---队伍请求邀请好友列表
---ToServer
LuaEnumNetDef.ReqShareGroupInvitationFriendListMessage = 1001019

---返回队伍请求邀请好友列表
---sharegroup  ResGroupInvitationFriendList
---ToClient
LuaEnumNetDef.ResShareGroupInvitationFriendListMessage = 1001020

---队伍请求邀请行会列表
---ToServer
LuaEnumNetDef.ReqShareGroupInvitationUnionListMessage = 1001021

---返回队伍请求邀请行会列表
---sharegroup  ResGroupInvitationUnionList
---ToClient
LuaEnumNetDef.ResShareGroupInvitationUnionListMessage = 1001022

---请求清空列表
---sharegroup  ReqClearList
---ToServer
LuaEnumNetDef.ReqShareClearListMessage = 1001023

---离开队伍响应
---ToClient
LuaEnumNetDef.ResShareLeaveTeamMessage = 1001024

---消息提示
---sharegroup  MsgPrompt
---ToClient
LuaEnumNetDef.ResShareApplyTeamMessage = 1001025

---玩家邀请列表请求
---ToServer
LuaEnumNetDef.ReqShareInvitationListMessage = 1001026

---解散队伍
---ToServer
LuaEnumNetDef.ReqShareDissolveGroupMessage = 1001027

---设置组队模式请求
---sharegroup  SetTeamModeRequest
---ToServer
LuaEnumNetDef.ReqShareSetTeamModeMessage = 1001028

---屏蔽
---sharegroup  Shielding
---ToServer
LuaEnumNetDef.ReqShareShieldingMessage = 1001029

---召唤令响应
---sharegroup  TeamCallBack
---ToClient
LuaEnumNetDef.ResShareCallBackMessage = 1001030

---召唤令确认
---sharegroup  CheckCallBack
---ToServer
LuaEnumNetDef.ReqShareCheckCallBackMessage = 1001031

---请求玩家是否在线及其部分消息
---sharegroup  ReqHasPlayerSomeInfo
---ToServer
LuaEnumNetDef.ReqShareHasPlayerSomeInfoMessage = 1001032

---返回玩家是否在线及其部分消息
---sharegroup  ResHasPlayerSomeInfo
---ToClient
LuaEnumNetDef.ResShareHasPlayerSomeInfoMessage = 1001033

---队长二次批复邀请
---sharegroup  ReqCaptainAcceptInvitation
---ToServer
LuaEnumNetDef.ReqShareCaptainAcceptInvitMessage = 1001034

---组队玩家血量同步
---sharegroup  TeamPlayerHpInfo
---ToClient
LuaEnumNetDef.ResShareTeamPlayerHpMessage = 1001035

---请求组队所有玩家血量同步
---sharegroup  ResTeamAllMemHpInfo
---ToClient
LuaEnumNetDef.ResShareTeamAllMemHpInfoMessage = 1001036

---召唤令确认结果
---sharegroup  ResCallBack
---ToClient
LuaEnumNetDef.ResShareCheckCallBackMessage = 1001037
--endregion

--region ID:1002  uniteunion
---返回所有同盟
---uniteunion  AllUniteUnion
---ToClient
LuaEnumNetDef.ResAllUniteUnionMessage = 1002001

---申请加入同盟
---uniteunion  UniteUnionType
---ToServer
LuaEnumNetDef.ReqApplyJoinUniteUnionMessage = 1002002

---申请退出同盟
---uniteunion  UniteUnionType
---ToServer
LuaEnumNetDef.ReqApplyExitUniteUnionMessage = 1002003

---请求某个同盟
---uniteunion  UniteUnionType
---ToServer
LuaEnumNetDef.ReqOneUniteUnionMessage = 1002004

---返回某个同盟
---uniteunion  UniteUnionInfo
---ToClient
LuaEnumNetDef.ResOneUniteUnionMessage = 1002005

---返回封印塔联盟排行
---uniteunion  ResUniteUnionSealTowerRank
---ToClient
LuaEnumNetDef.ResUniteUnionSealTowerRankMessage = 1002006

---请求封印塔联盟排行
---uniteunion  ReqUniteUnionSealTowerRank
---ToServer
LuaEnumNetDef.ReqUniteUnionSealTowerRankMessage = 1002007

---请求封印塔捐献
---uniteunion  ReqSealTowerDonation
---ToServer
LuaEnumNetDef.ReqSealTowerDonationMessage = 1002008

---返回封印塔捐献是否成功
---uniteunion  ResSealTowerDonation
---ToClient
LuaEnumNetDef.ResSealTowerDonationMessage = 1002009

---请求前往击杀封印塔怪物
---ToServer
LuaEnumNetDef.ReqGetSealTowerMonsterPointMessage = 1002010

---返回前往击杀封印塔怪物
---uniteunion  ResGetSealTowerMonsterPoint
---ToClient
LuaEnumNetDef.ResGetSealTowerMonsterPointMessage = 1002011
--endregion

--region ID:1003  share
---返回进入共享服的信息
---share  EnterShareMapInfo
---ToClient
LuaEnumNetDef.ResEnterShareMapMessage = 1003001

---角色联盟类型信息
---uniteunion  ResRoleUniteType
---ToClient
LuaEnumNetDef.ResRoleUniteTypeMessage = 1003002
--endregion

--region ID:1500  sharesocialcontact
---请求送花
---socialcontact  ReqSendFlowers
---ToServer
LuaEnumNetDef.ReqShareSendFlowersMessage = 1500001

---返回送花
---ToClient
LuaEnumNetDef.ResShareSendFlowersMessage = 1500002

---请求花的数量
---socialcontact  ReqGetTheFlowerCount
---ToServer
LuaEnumNetDef.ReqShareGetTheFlowerCountMessage = 1500003

---返回花的数量
---socialcontact  ResGetTheFlowerCount
---ToClient
LuaEnumNetDef.ResShareGetTheFlowerCountMessage = 1500004

---返回花的数量达到99或999
---socialcontact  ResTeXiao
---ToClient
LuaEnumNetDef.ResShareTeXiaoMessage = 1500005

---返回默认打开的鲜花ID
---socialcontact  ResDefaultFlowerId
---ToClient
LuaEnumNetDef.ResShareDefaultFlowerIdMessage = 1500006

---回赠
---socialcontact  ReqRebateFlower
---ToServer
LuaEnumNetDef.ReqShareRebateFlowerMessage = 1500008

---回复感谢
---socialcontact  ReqReplyToThank
---ToServer
LuaEnumNetDef.ReqShareReplyToThankMessage = 1500009

---加为好友
---socialcontact  ReqSendFlowerAddFriend
---ToServer
LuaEnumNetDef.ReqShareSendFlowerAddFriendMessage = 1500010

---同意
---socialcontact  ReqAgreeSendFlowerAddFriend
---ToServer
LuaEnumNetDef.ReqShareAgreeSendFlowerAddFriendMessage = 1500011

---返回客户端通用消息
---play  CommonInfo
---ToClient
LuaEnumNetDef.ResShareCommonMessage = 1500012

---客户端请求通用消息
---play  CommonInfo
---ToServer
LuaEnumNetDef.ReqShareCommonMessage = 1500013
--endregion
