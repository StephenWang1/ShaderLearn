---场景class加载器
---@class SceneClassLoader
local SceneClassLoader = {}

---加载场景中用到的class
---@param luaclass luaclass
function SceneClassLoader:LoadSceneClasses(luaclass)
    ---主场景
    luaclass.LuaMainScene = require "luaRes.game.scene.LuaMainScene"

    self:LoadAllLuaAvatarClass()

    self:LoadAllGameDataClass()

    ---Lua中的异步操作管理类
    luaclass.LuaAsyncOperationMgr = require "luaRes.game.scene.asyncoperations.LuaAsyncOperationMgr"
    ---Lua中的异步操作工具类
    luaclass.LuaAsyncOperationUtility = require "luaRes.game.scene.asyncoperations.utility.LuaAsyncOperationUtility"

    ---Lua中的异步操作基类
    luaclass.LuaAsyncOperationBase = require "luaRes.game.scene.asyncoperations.LuaAsyncOperationBase"
    ---Lua中的异步操作示例类
    luaclass.LuaAsyncOperation_Example = require "luaRes.game.scene.asyncoperations.operations.LuaAsyncOperation_Example"
    ---前往地图并开启自动战斗
    luaclass.LuaAsyncOperation_GoMapAndAutoFight = require "luaRes.game.scene.asyncoperations.operations.LuaAsyncOperation_GoMapAndAutoFight"
    ---行会复仇
    luaclass.LuaAsyncOperation_UnionRevenge = require "luaRes.game.scene.asyncoperations.operations.LuaAsyncOperation_UnionRevenge"

    ---特殊活动
    ---特殊活动基类
    luaclass.SpecialActivityBase = require "luaRes.game.data.SpecialActivities.SpecialActivityBase"
    ---狂欢商店
    luaclass.LuaSpecialActivity_CarnivalShop = require "luaRes.game.data.SpecialActivities.SpecialActivity_CarnivalShop"

    ---白日门活动
    ---白日门活动管理类
    luaclass.BaiRiMenActivityMgr = require "luaRes.game.data.BaiRiMenActivity.BaiRiMenActivityMgr"
    ---白日门活动基类
    luaclass.BaiRiMenActControllerBase = require "luaRes.game.data.BaiRiMenActivity.BaiRiMenActControllerBase"
    ---白日门圣物活动
    luaclass.BaiRiMenActController_ShengWu = require "luaRes.game.data.BaiRiMenActivity.BaiRiMenActController_ShengWu"
    ---白日门押镖活动
    luaclass.BaiRiMenActController_DartCar = require "luaRes.game.data.BaiRiMenActivity.BaiRiMenActController_DartCar"
    ---白日门封赏活动
    luaclass.BaiRiMenActController_HuntingRewar = require "luaRes.game.data.BaiRiMenActivity.BaiRiMenActController_HuntingRewar"
    ---白日门猎魔活动
    luaclass.BaiRiMenActController_Hunt = require "luaRes.game.data.BaiRiMenActivity.BaiRiMenActController_Hunt"
    ---白日门联服活动
    luaclass.BaiRiMenActController_CrossServerActivity = require "luaRes.game.data.BaiRiMenActivity.BaiRiMenActController_CrossServerActivity"
    ---白日门闯天关活动
    luaclass.BaiRiMenActController_ChuangTianGuan = require "luaRes.game.data.BaiRiMenActivity.BaiRiMenActController_ChuangTianGuan"
    ---白日门苍月岛
    luaclass.BaiRiMenActController_CangYue = require "luaRes.game.data.BaiRiMenActivity.BaiRiMenActController_CangYue"


    ---藏品
    ---藏品数据类
    luaclass.LuaCollectionInfo = require "luaRes.game.data.LuaCollectionInfo"
    ---藏品物品数据
    luaclass.LuaCollectionItem = require "luaRes.game.data.collections.LuaCollectionItem"
    ---主角使用经验丹行为
    luaclass.LuaMainPlayerUseExpProp = require "luaRes.game.data.ExpPropUsing.LuaMainPlayerUseExpProp"
end

---加载luaAvatar相关表
---@private
function SceneClassLoader:LoadAllLuaAvatarClass()
    ---luaAvatar工厂
    luaclass.LuaAvatarFactory = require "luaRes.game.scene.LuaAvatarFactory"
    ---玩家数据管理器
    luaclass.LuaTimeMgr = require "luaRes.game.manager.LuaTimeMgr"
    ---玩家数据管理器
    luaclass.LuaTimeMgr = require "luaRes.game.manager.LuaTimeMgr"

    --region Avatar类
    ---luaAvatar对象基类
    luaclass.LuaAvatar = require "luaRes.game.scene.avatar.base.LuaAvatar"
    ---Lua中的主角类
    luaclass.LuaMainPlayer = require "luaRes.game.scene.avatar.LuaMainPlayer"
    ---Lua中的其他玩家类
    luaclass.LuaPlayer = require "luaRes.game.scene.avatar.LuaPlayer"
    ---Lua中的怪物类
    luaclass.LuaMonster = require "luaRes.game.scene.avatar.LuaMonster"
    ---Lua中的物品类
    luaclass.LuaItem = require "luaRes.game.scene.avatar.LuaItem"
    ---Lua中的NPC类
    luaclass.LuaNPC = require "luaRes.game.scene.avatar.LuaNPC"
    ---Lua中的宠物类
    luaclass.LuaPet = require "luaRes.game.scene.avatar.LuaPet"
    ---Lua中的灵兽类
    luaclass.LuaServant = require "luaRes.game.scene.avatar.LuaServant"
    ---Lua中的矿/鱼类
    luaclass.LuaMine = require "luaRes.game.scene.avatar.LuaMine"
    ---Lua中的摊位类
    luaclass.LuaBooth = require "luaRes.game.scene.avatar.LuaBooth"
    ---Lua中的火药桶类
    luaclass.LuaGunpowderBarrel = require "luaRes.game.scene.avatar.LuaGunpowderBarrel"

    ---Lua中的异步操作管理类
    luaclass.LuaAsyncOperationMgr = require "luaRes.game.scene.asyncoperations.LuaAsyncOperationMgr"
    ---Lua中的异步操作工具类
    luaclass.LuaAsyncOperationUtility = require "luaRes.game.scene.asyncoperations.utility.LuaAsyncOperationUtility"
    --endregion

    --region avatarInfo相关

    ---LuaAvatarInfo的基类
    luaclass.LuaAvatarInfo = require "luaRes.game.scene.avatar.base.LuaAvatarInfo"
    ---摊位的信息类
    luaclass.LuaAvatarInfo_Booth = require "luaRes.game.scene.avatar.info.LuaAvatarInfo_Booth"
    ---主角的信息类
    luaclass.LuaAvatarInfo_MainPlayer = require "luaRes.game.scene.avatar.info.LuaAvatarInfo_MainPlayer"
    ---怪物的信息类
    luaclass.LuaAvatarInfo_Monster = require "luaRes.game.scene.avatar.info.LuaAvatarInfo_Monster"
    ---NPC的信息类
    luaclass.LuaAvatarInfo_Npc = require "luaRes.game.scene.avatar.info.LuaAvatarInfo_Npc"
    ---召唤物的信息类
    luaclass.LuaAvatarInfo_Pet = require "luaRes.game.scene.avatar.info.LuaAvatarInfo_Pet"
    ---玩家的信息类
    luaclass.LuaAvatarInfo_Player = require "luaRes.game.scene.avatar.info.LuaAvatarInfo_Player"
    ---灵兽的信息类
    luaclass.LuaAvatarInfo_Servant = require "luaRes.game.scene.avatar.info.LuaAvatarInfo_Servant"
    --endregion

    --region head相关组件
    ---luaAvatarHead对象基类
    luaclass.LuaHead_Avatar = require "luaRes.game.scene.avatar.base.LuaHead_Avatar"

    ---Lua中的人物头顶组件组件类
    luaclass.LuaHead_Character = require "luaRes.game.scene.avatar.head.LuaHead_Character"
    ---Lua中的主角头顶组件类
    luaclass.LuaHead_MainPlayer = require "luaRes.game.scene.avatar.head.LuaHead_MainPlayer"
    ---Lua中的玩家头顶组件类
    luaclass.LuaHead_Player = require "luaRes.game.scene.avatar.head.LuaHead_Player"
    ---Lua中的怪物头顶组件类
    luaclass.LuaHead_Monster = require "luaRes.game.scene.avatar.head.LuaHead_Monster"
    ---Lua中的Npc头顶组件类
    luaclass.LuaHead_Npc = require "luaRes.game.scene.avatar.head.LuaHead_Npc"
    ---Lua中的召唤物头顶组件类
    luaclass.LuaHead_Pet = require "luaRes.game.scene.avatar.head.LuaHead_Pet"
    ---Lua中的灵兽头顶组件类
    luaclass.LuaHead_Servant = require "luaRes.game.scene.avatar.head.LuaHead_Servant"
    ---Lua中的摊位头顶组件组件类
    luaclass.LuaHead_Booth = require "luaRes.game.scene.avatar.head.LuaHead_Booth"
    ---Lua中的火药桶头顶组件组件类
    luaclass.LuaHead_GunpowderBarrel = require "luaRes.game.scene.avatar.head.LuaHead_GunpowderBarrel"
    --endregion

    --region model类

    ---luaAvatarModel 模型的基类
    luaclass.LuaAvatarModel = require "luaRes.game.scene.avatar.base.LuaAvatarModel"
    ---luaAvatarModel 摊位模型
    luaclass.LuaAvatarModel_Booth = require "luaRes.game.scene.avatar.model.LuaAvatarModel_Booth"
    ---luaAvatarModel 主角模型
    luaclass.LuaAvatarModel_MainPlayer = require "luaRes.game.scene.avatar.model.LuaAvatarModel_MainPlayer"
    ---luaAvatarModel 怪物模型
    luaclass.LuaAvatarModel_Monster = require "luaRes.game.scene.avatar.model.LuaAvatarModel_Monster"
    ---luaAvatarModel NPC模型
    luaclass.LuaAvatarModel_Npc = require "luaRes.game.scene.avatar.model.LuaAvatarModel_Npc"
    ---luaAvatarModel 宠物模型
    luaclass.LuaAvatarModel_Pet = require "luaRes.game.scene.avatar.model.LuaAvatarModel_Pet"
    ---luaAvatarModel 玩家模型
    luaclass.LuaAvatarModel_Player = require "luaRes.game.scene.avatar.model.LuaAvatarModel_Player"
    ---luaAvatarModel 灵兽模型
    luaclass.LuaAvatarModel_Servant = require "luaRes.game.scene.avatar.model.LuaAvatarModel_Servant"

    --endregion

end

---加载数据相关表
---@private
function SceneClassLoader:LoadAllGameDataClass()
    ---玩家数据管理器
    luaclass.LuaPlayerDataManager = require "luaRes.game.data.PlayerDataManager"

    ---其他数据管理器
    luaclass.LuaOtherPlayerDataManager = require "luaRes.game.data.OtherPlayerDataManager"

    --region 通用

    ---Lua中的材料数据
    luaclass.LuaMaterialData = require "luaRes.game.data.common.LuaMaterialData"

    ---Lua中延迟时间刷新消息
    luaclass.LuaDelayRefreshMessage = require "luaRes.game.data.common.LuaDelayRefreshMessage"


    --endregion

    --region 活动
    ---活动的管理类
    luaclass.LuaActivityMgr = require "luaRes.game.data.activity.LuaActivityMgr"
    ---一个活动的详细信息
    luaclass.LuaActivityItem = require "luaRes.game.data.activity.LuaActivityItem"
    ---一个活动的详细信息
    luaclass.LuaActivityItemSubInfo = require "luaRes.game.data.activity.LuaActivityItemSubInfo"
    --endregion

    ---Lua中的行会类
    luaclass.LuaUnionInfo = require "luaRes.game.data.LuaUnionInfo"
    ---Lua中的锻造类
    luaclass.LuaStrengthInfo = require "luaRes.game.data.LuaStrengthInfo"
    ---lua中的灵兽信息类
    luaclass.LuaServantInfo = require "luaRes.game.data.LuaServantInfo"
    ---lua中的会员信息类
    luaclass.LuaMemberInfo = require "luaRes.game.data.Member.LuaMemberInfo"
    ---Lua中的充值类
    luaclass.LuaRechargeInfo = require "luaRes.game.data.LuaRechargeInfo"
    ---Lua中的Vip类
    luaclass.LuaVipInfo = require "luaRes.game.data.LuaVipInfo"
    ---Lua中的Vip2类
    luaclass.LuaVip2Info = require "luaRes.game.data.LuaVip2Info"
    ---Lua中的技能信息
    luaclass.LuaXPSkillInfo = require "luaRes.game.data.LuaXPSkillInfo"
    ---Lua中的采集信息
    luaclass.LuaGatherInfo = require "luaRes.game.data.LuaGatherInfo"
    ---Lua中的玩家联盟信息
    luaclass.LuaLeagueInfo = require "luaRes.game.data.LuaLeagueInfo"
    ---Lua中的玩家联服相关信息
    luaclass.LuaShareMapInfo = require "luaRes.game.data.LuaShareMapInfo"
    ---Lua中系统开启信息
    luaclass.LuaSystemInfo = require "luaRes.game.data.LuaSystemInfo"
    ---Lua中的Tower类
    luaclass.LuaTowerInfo = require "luaRes.game.data.LuaTowerInfo"
    ---Lua中的神秘老人类
    luaclass.LuaMysteriousExchangeOldManInfo = require "luaRes.game.data.MysteriousExchange.LuaMysteriousExchangeOldManInfo"

    ---Lua中的商店信息
    luaclass.LuaStoreData = require "luaRes.game.data.LuaStoreData"
    ---Lua中的活动信息
    luaclass.LuaSpecialActivityData = require "luaRes.game.data.LuaSpecialActivityData"
    ---Lua中的Official类
    luaclass.LuaOfficialInfo = require "luaRes.game.data.Official.LuaOfficialInfo"

    --region 合成相关
    ---Lua中的合成管理
    luaclass.LuaSynthesisMgr = require "luaRes.game.data.synthesis.LuaSynthesisMgr"
    ---Lua中的合成大类
    luaclass.LuaSynthesis_MainCategory = require "luaRes.game.data.synthesis.LuaSynthesis_MainCategory"
    ---Lua中的合成分类
    luaclass.LuaSynthesis_SubCategory = require "luaRes.game.data.synthesis.LuaSynthesis_SubCategory"
    ---Lua中的合成单体
    luaclass.LuaSynthesis_Item = require "luaRes.game.data.synthesis.LuaSynthesis_Item"
    ---Lua中的合成单体列表
    luaclass.LuaSynthesis_ListItem = require "luaRes.game.data.synthesis.LuaSynthesis_ListItem"
    ---Lua中的角色合成数据
    luaclass.LuaSynthesisRoleData = require "luaRes.game.data.synthesis.LuaSynthesisRoleData"
    ---Lua中的合成当前选择的物品数据
    luaclass.LuaSynthesis_ChooseItemInfo = require "luaRes.game.data.synthesis.LuaSynthesis_ChooseItemInfo"
    --endregion

    ---Lua中的主角背包数据管理
    luaclass.LuaMainPlayerBagMgr = require "luaRes.game.data.bag.LuaMainPlayerBagMgr"
    ---Lua中的主角装备数据管理
    luaclass.LuaMainPlayerEquipMgr = require "luaRes.game.data.equip.LuaMainPlayerEquipMgr"
    ---Lua中的装备列表数据类
    luaclass.LuaPlayerEquipmentListData = require "luaRes.game.data.equip.SLSuit.LuaPlayerEquipmentListData"
    ---Lua中的装备套装加成
    luaclass.LuaEquipSuitAdditionItem = require "luaRes.game.data.equip.SLSuit.LuaEquipSuitAdditionItem"
    ---Lua中的装备数据类
    luaclass.LuaEquipDataItem = require "luaRes.game.data.equip.SLSuit.LuaEquipDataItem"
    ---Lua中的主角背包回收数据管理
    luaclass.LuaMainPlayerBagRecycleMgr = require "luaRes.game.data.bag.LuaMainPlayerBagRecycleMgr"
    ---Lua中的主角背包回收收益数据管理
    luaclass.LuaMainPlayerRecycleEarningMgr = require "luaRes.game.data.bag.Recycle.RecycleEarning.LuaMainPlayerRecycleEarningMgr"
    ---单个物品回收收益数据
    luaclass.ItemRecycleEarning = require "luaRes.game.data.bag.Recycle.RecycleEarning.ItemRecycleEarning"

    ---Lua中的主角血继装备数据管理
    luaclass.LuaPlayerBloodSuitEquipMgr = require "luaRes.game.data.equip.BloodSuit.LuaPlayerBloodSuitEquipMgr"
    ---Lua中的血继装备列表数据类
    luaclass.LuaPlayerEquipBloodSuitListData = require "luaRes.game.data.equip.BloodSuit.LuaPlayerEquipBloodSuitListData"
    ---Lua中的血继装备数据类
    luaclass.LuaEquipDataBloodSuitItem = require "luaRes.game.data.equip.BloodSuit.LuaEquipDataBloodSuitItem"
    ---Lua中的血继共鸣数据类
    luaclass.LuaPlayerBloodSuitResonanceMgr = require "luaRes.game.data.equip.BloodSuitResonance.LuaPlayerBloodSuitResonanceMgr"
    ---Lua中的血继共鸣组
    luaclass.LuaPlayerBloodSuitResonanceGroup = require "luaRes.game.data.equip.BloodSuitResonance.LuaPlayerBloodSuitResonanceGroup"
    ---Lua中的血继共单个物品信息
    luaclass.LuaPlayerBloodSuitResonanceItem = require "luaRes.game.data.equip.BloodSuitResonance.LuaPlayerBloodSuitResonanceItem"


    --region 精通
    ---Lua中的装备精通管理类
    luaclass.LuaEquipProficientMgr = require "luaRes.game.data.euqip_proficient.LuaEquipProficientMgr"
    --endregion

    --region 血炼
    luaclass.LuaPlayerBloodSuitSmeltMgr = require "luaRes.game.data.equip.BloodSuitSmelt.LuaPlayerBloodSuitSmeltMgr"
    --endregion

    --region 法宝
    ---法宝装备被列表数据类
    luaclass.LuaMagicEquipmentListData = require "luaRes.game.data.equip.MagicEquipSuit.LuaMagicEquipmentListData"
    ---法宝装备数据类
    luaclass.LuaMagicEquipDataItem = require "luaRes.game.data.equip.MagicEquipSuit.LuaMagicEquipDataItem"
    --endregion

    --region 宝物
    ---法宝列表信息类
    luaclass.LuaGemEquipmentListData = require "luaRes.game.data.equip.GemSuit.LuaGemEquipmentListData"
    ---法宝装备数据类
    luaclass.LuaGemEquipDataItem = require "luaRes.game.data.equip.GemSuit.LuaGemEquipDataItem"
    --endregion

    --region 排行榜
    luaclass.LuaRankData = require "luaRes.game.data.Rank.LuaRankData"
    --endregion

    --region 灵兽任务
    luaclass.LuaLsMissionInfo = require "luaRes.game.data.LsMission.LuaLsMissionInfo"
    --endregion

    --region 灵兽装备
    ---灵兽装备管理类
    luaclass.LuaServantEquipMgr = require "luaRes.game.data.servant.servantEquip.LuaServantEquipMgr"
    ---单个灵兽装备数据
    luaclass.LuaSingleServantEquipInfo = require "luaRes.game.data.servant.servantEquip.LuaSingleServantEquipInfo"
    --endregion

    --region 技能
    ---技能管理类
    luaclass.LuaMainPlayerSkillMgr = require "luaRes.game.data.skill.LuaMainPlayerSkillMgr"
    ---单个技能详细信息
    luaclass.LuaSkillDetailedInfo = require "luaRes.game.data.skill.LuaSkillDetailedInfo"
    --endregion

    --region 维修
    luaclass.LuaRepairInfo = require "luaRes.game.data.Repair.LuaRepairInfo"
    --endregion

    --region 炼化
    luaclass.RefineMgr = require "luaRes.game.data.Refine.RefineMgr"
    --endregion

    --region  篝火
    luaclass.LuaBonfireInfo = require "luaRes.game.data.Bonfire.LuaBonfireInfo"
    --endregion

    --region 投资
    ---投资管理
    luaclass.LuaInvestmentMgr = require "luaRes.game.data.investment.LuaInvestmentMgr"
    ---投资期数
    luaclass.LuaInvestmentTurm = require "luaRes.game.data.investment.LuaInvestmentTurm"
    ---投资单条数据
    luaclass.LuaInvestmentItem = require "luaRes.game.data.investment.LuaInvestmentItem"
    --endregion

    --region 魂装
    luaclass.LuaSoulEquipMgr = require "luaRes.game.data.SoulEquip.LuaSoulEquipMgr"
    --endregion

    --region 套装
    luaclass.LuaSuitMgr = require "luaRes.game.data.Suit.LuaSuitMgr"

    ---Lua中的炼制大师数据管理
    luaclass.LuaLianZhiMgr = require "luaRes.game.data.LianZhi.LuaLianZhiMgr"
    --endregion

    ---Lua中的累充计划活动
    luaclass.LuaAccumulatedRechargeMissionMgr = require "luaRes.game.data.activity.LuaAccumulatedRechargeMissionMgr"

    --region 外观
    ---lua中的外观类
    luaclass.LuaAppearanceInfo = require "luaRes.game.data.appearance.LuaAppearanceInfo"
    --endregion

    --region 潜能武器
    ---lua中的潜能类
    luaclass.LuaPotentialEquipMgr = require "luaRes.game.data.potential.LuaPotentialEquipMgr"
    --endregion

    --region 封号天赋
    luaclass.LuaMilitaryRankTitleFlairInfo = require "luaRes.game.data.LuaMilitaryRankTitleFlairInfo"
    --endregion

    ---Lua中的私服任务管理
    ---任务管理类
    luaclass.LuaSfMissionManager = require "luaRes.game.data.sfMission.LuaSfMissionManager"
    ---任务-挑战首领数据类
    luaclass.LusSfChallengeBossData = require "luaRes.game.data.sfMission.LusSfChallengeBossData"
    ---任务-精英任务(怪物悬赏)
    luaclass.LuaSfMonsterArrestData = require "luaRes.game.data.sfMission.LuaSfMonsterArrestData"
    ---任务-灵魂任务(灵魂任务)
    luaclass.LuaLingHunMissionData = require "luaRes.game.data.sfMission.LuaSfLingHunMissionData"
    --endregion

    --region 潜能投资
    luaclass.LuaPotentialInvestInfo = require "luaRes.game.data.LuaPotentialInvestInfo"
    --endregion

    --region 设置
    ---设置管理类
    luaclass.LuaConfigManager = require "luaRes.game.data.Config.LuaConfigManager"
    ---背包回收设置
    luaclass.LuaConfig_BagRecycle = require "luaRes.game.data.Config.LuaConfig_BagRecycle"
    --endregion

    luaclass.LuaCompetitionData = require "luaRes.game.data.Competition.LuaCompetitionData"

    --region 副本数据管理
    luaclass.LuaDuplicateMgr = require "luaRes.game.data.Duplicate.LuaDuplicateMgr"
    --endregion

    --region 设置
    luaclass.SettingManager = require "luaRes.game.data.Setting.SettingManager"
    --endregion

    --region 阵法
    ---阵法管理类
    luaclass.LuaZhenFaManager = require "luaRes.game.data.ZhenFa.LuaZhenFaManager"
    ---阵法信息类
    luaclass.LuaZhenFaInfo = require "luaRes.game.data.ZhenFa.ZhenFa.LuaZhenFaInfo"
    ---阵法装备管理类
    luaclass.LuaZhenFaEquipManager = require "luaRes.game.data.ZhenFa.Equip.LuaZhenFaEquipManager"
    ---阵法装备信息
    luaclass.LuaZhenFaEquip = require "luaRes.game.data.ZhenFa.Equip.LuaZhenFaEquip"
    --endregion

    --region 斗笠盾牌
    ---斗笠盾牌管理类
    luaclass.ShieldAndHatManager = require "luaRes.game.data.ShieldAndHat.LuaShieldAndHatManager"
    ---斗笠盾牌列表信息类
    luaclass.LuaShieldAndHatEquipmentListData = require "luaRes.game.data.equip.ShieldAndHatSuit.LuaShieldAndHatEquipmentListData"
    ---斗笠盾牌装备数据类
    luaclass.LuaShieldAndHatEquipDataItem = require "luaRes.game.data.equip.ShieldAndHatSuit.LuaShieldAndHatEquipDataItem"
    --endregion

    --region 幸运转盘
    ---幸运转盘管理类
    luaclass.LuaLuckTurntableLotteryManager = require "luaRes.game.data.LuckTurntableLottery.LuaLuckTurntableLotteryManager"
    --endregion


    luaclass.LuaMainPlayerExpExchange = require "luaRes.game.data.expexchange.LuaMainPlayerExpExchange"

    --region 重铸
    luaclass.LuaRecastMgr = require "luaRes.game.data.Recast.LuaRecastMgr"
    luaclass.LuaRecastList = require "luaRes.game.data.Recast.LuaRecastList"
    luaclass.LuaRecastEquipIndex = require "luaRes.game.data.Recast.LuaRecastEquipIndex"
    --endregion

    --region 平台
    luaclass.PlatformMgr = require"luaRes.game.data.platform.PlatformMgr"
    luaclass.PlatformInfo = require"luaRes.game.data.platform.PlatformInfo"
    --endregion

    --region 投保
    luaclass.LuaInsureMgr = require"luaRes.game.data.Insure.LuaInsureMgr"
    luaclass.LuaInsureItem = require"luaRes.game.data.Insure.LuaInsureItem"
    --endregion
end

return SceneClassLoader