---玩家数据管理类
---@class PlayerDataManager:luaobject
local PlayerDataManager = {}

---@return LuaMainPlayerEquipMgr 主角的装备信息管理类
function PlayerDataManager:GetMainPlayerEquipMgr()
    if (self.mLuaMainPlayerEquipMgr == nil) then
        self.mLuaMainPlayerEquipMgr = luaclass.LuaMainPlayerEquipMgr:New()
    end
    return self.mLuaMainPlayerEquipMgr
end

---@return LuaPlayerBloodSuitEquipMgr 主角的血继装备信息管理类
function PlayerDataManager:GetMainPlayerBloodSuitEquipMgr()
    if (self.mLuaMainPlayerBloodSuitIEquipMgr == nil) then
        self.mLuaMainPlayerBloodSuitIEquipMgr = luaclass.LuaPlayerBloodSuitEquipMgr:New()
    end
    return self.mLuaMainPlayerBloodSuitIEquipMgr
end

---@return LuaPlayerBloodSuitResonanceMgr 主角的血继共鸣管理类
function PlayerDataManager:GetMainPlayerBloodSuitResonanceMgr()
    if (self.mLuaMainPlayerBloodSuitResonanceMgr == nil) then
        self.mLuaMainPlayerBloodSuitResonanceMgr = luaclass.LuaPlayerBloodSuitResonanceMgr:New()
    end
    return self.mLuaMainPlayerBloodSuitResonanceMgr
end

---@return LuaPlayerBloodSuitSmeltMgr 主角的血炼装备信息管理类
function PlayerDataManager:GetMainPlayerBloodSuitSmeltMgr()
    if (self.mLuaPlayerBloodSuitSmeltMgr == nil) then
        self.mLuaPlayerBloodSuitSmeltMgr = luaclass.LuaPlayerBloodSuitSmeltMgr:New()
        self.mLuaPlayerBloodSuitSmeltMgr:Init()
    end
    return self.mLuaPlayerBloodSuitSmeltMgr
end

---主角的背包信息管理类
---@return LuaMainPlayerBagMgr
function PlayerDataManager:GetMainPlayerBagMgr()
    if self.mMainPlayerBagMgr == nil then
        self.mMainPlayerBagMgr = luaclass.LuaMainPlayerBagMgr:New()
    end
    return self.mMainPlayerBagMgr
end

---装备精通管理
---@return LuaEquipProficientMgr
function PlayerDataManager:GetEquipProficientMgr()
    if self.mGetEquipProficientMgr == nil then
        self.mGetEquipProficientMgr = luaclass.LuaEquipProficientMgr:New()
    end
    return self.mGetEquipProficientMgr
end

---@return LuaUnionInfo 行会信息
function PlayerDataManager:GetUnionInfo()
    if (self.mUnionInfo == nil) then
        self.mUnionInfo = luaclass.LuaUnionInfo:New()
    end
    return self.mUnionInfo
end

---@return LuaServantInfo 灵兽信息
function PlayerDataManager:GetLuaServantInfo()
    if (self.mLuaServantInfo == nil) then
        self.mLuaServantInfo = luaclass.LuaServantInfo:New();
    end
    return self.mLuaServantInfo;
end

---@return LuaMemberInfo 会员信息
function PlayerDataManager:GetLuaMemberInfo()
    if (self.mLuaMemberInfo == nil) then
        self.mLuaMemberInfo = luaclass.LuaMemberInfo:New();
    end
    return self.mLuaMemberInfo;
end

---@return LuaRechargeInfo 充值信息
function PlayerDataManager:GetRechargeInfo()
    if (self.mRechargeInfo == nil) then
        self.mRechargeInfo = luaclass.LuaRechargeInfo:New()
    end
    return self.mRechargeInfo
end

---@return LuaVipInfo Vip信息
function PlayerDataManager:GetPlayerVipInfo()
    if (self.mPlayerVipInfo == nil) then
        self.mPlayerVipInfo = luaclass.LuaVipInfo:New()
    end
    return self.mPlayerVipInfo
end

---@return LuaVip2Info Vip2信息
function PlayerDataManager:GetPlayerVip2Info()
    if (self.mPlayerVip2Info == nil) then
        self.mPlayerVip2Info = luaclass.LuaVip2Info:New()
    end
    return self.mPlayerVip2Info
end

---@return LuaLeagueInfo 联盟信息
function PlayerDataManager:GetLeagueInfo()
    if self.mLeagueInfo == nil then
        self.mLeagueInfo = luaclass.LuaLeagueInfo:New()
    end
    return self.mLeagueInfo
end

---@return LuaShareMapInfo 联服信息
function PlayerDataManager:GetShareMapInfo()
    if self.mShareMapInfo == nil then
        self.mShareMapInfo = luaclass.LuaShareMapInfo:New()
    end
    return self.mShareMapInfo
end

---@return LuaXPSkillInfo 技能信息
function PlayerDataManager:GetXPSkillInfo()
    return self.mXPSkillInfo
end

---@return LuaGatherInfo 采集信息
function PlayerDataManager:GetGatherInfo()
    return self.mGatherInfo
end

---@return LuaTowerInfo 闯天关信息
function PlayerDataManager:GetPlayerTowerInfo()
    if (self.mPlayerTowerInfo == nil) then
        self.mPlayerTowerInfo = luaclass.LuaTowerInfo:New()
    end
    return self.mPlayerTowerInfo
end

---@return LuaMysteriousExchangeOldManInfo 神秘老人信息
function PlayerDataManager:GetLuaMysteriousExchangeOldManInfo()
    if (self.mLuaMysteriousExchangeOldManInfo == nil) then
        self.mLuaMysteriousExchangeOldManInfo = luaclass.LuaMysteriousExchangeOldManInfo:New()
    end
    return self.mLuaMysteriousExchangeOldManInfo
end

---@return LuaStrengthInfo 锻造相关数据（升星转移都可以）
function PlayerDataManager:GetLuaStrengthInfo()
    if self.mLuaStrengthInfo == nil then
        self.mLuaStrengthInfo = luaclass.LuaStrengthInfo:New()
    end
    return self.mLuaStrengthInfo
end

---@return LuaOfficialInfo 官阶信息
function PlayerDataManager:GetPlayerOfficialInfo()
    if (self.mPlayerOfficialInfo == nil) then
        self.mPlayerOfficialInfo = luaclass.LuaOfficialInfo:New()
    end
    return self.mPlayerOfficialInfo
end

---@return LuaAsyncOperationMgr Lua中的异步操作管理类
function PlayerDataManager:GetLuaAsyncOperationMgr()
    return self.mLuaAsyncOperationMgr
end

---@return LuaSynthesisMgr Lua中的合成管理
function PlayerDataManager:GetSynthesisMgr()
    return self.mLuaSynthesisMgr;
end

---@return LuaSpecialActivityData Lua中的特殊活动数据
function PlayerDataManager:GetSpecialActivityData()
    if self.mLuaSpecialActivityData == nil then
        self.mLuaSpecialActivityData = luaclass.LuaSpecialActivityData:New()
    end
    return self.mLuaSpecialActivityData
end

---获取白日门活动管理类
---@return BaiRiMenActivityMgr
function PlayerDataManager:GetBaiRiMenActivityMgr()
    return self.mBaiRiMenActivityMgr
end

---主角推送数据信息管理类
---@return BetterItemHintDataMgr
function PlayerDataManager:GetMainPlayerBetterItemHintDataMgr()
    if self.mMainPlayerBetterItemHintDataMgr == nil then
        self.mMainPlayerBetterItemHintDataMgr = luaclass.BetterItemHintDataMgr:New()
    end
    return self.mMainPlayerBetterItemHintDataMgr
end

--- 获取排行榜Lua数据
---@return LuaRankData
function PlayerDataManager:GetRankData()
    if self.rankData == nil then
        self.rankData = luaclass.LuaRankData:New()
    end
    return self.rankData
end

--- 获取灵兽任务
---@return LuaLsMissionInfo
function PlayerDataManager:GetLsMissionData()
    if self.lsMissionData == nil then
        self.lsMissionData = luaclass.LuaLsMissionInfo:New()
    end
    return self.lsMissionData
end

---@return LuaMainPlayerSkillMgr 主角的技能信息管理类
function PlayerDataManager:GetMainPlayerSkillMgr()
    if (self.mLuaMainPlayerSkillMgr == nil) then
        self.mLuaMainPlayerSkillMgr = luaclass.LuaMainPlayerSkillMgr:New()
    end
    return self.mLuaMainPlayerSkillMgr
end

---@return LuaRepairInfo
function PlayerDataManager:GetLuaRepairInfo()
    if self.mLuaRepairMgr == nil then
        self.mLuaRepairMgr = luaclass.LuaRepairInfo:New()
    end
    return self.mLuaRepairMgr
end

---主角的炼化信息管理类
---@return RefineMgr
function PlayerDataManager:GetMainPlayerRefineMgr()
    if self.mMainPlayerRefineMgr == nil then
        self.mMainPlayerRefineMgr = luaclass.RefineMgr:New()
    end
    return self.mMainPlayerRefineMgr
end

---主角的活动管理类
---@return LuaActivityMgr
function PlayerDataManager:GetActivityMgr()
    --if self.mGetActivityMgr == nil then
    --    self.mGetActivityMgr = luaclass.LuaActivityMgr:New()
    --end
    --return self.mGetActivityMgr
    return gameMgr:GetLuaActivityMgr()
end

---@return LuaInvestmentMgr 主角投资管理类
function PlayerDataManager:GetMainPlayerInvestmentMgr()
    if (self.mLuaInvestmentMgr == nil) then
        self.mLuaInvestmentMgr = luaclass.LuaInvestmentMgr:New()
    end
    return self.mLuaInvestmentMgr
end

---@return LuaInsureMgr 主角投保管理类
function PlayerDataManager:GetMainPlayerInsureMgr()
    if (self.mLuaInsureMgr == nil) then
        self.mLuaInsureMgr = luaclass.LuaInsureMgr:New()
    end
    return self.mLuaInsureMgr
end

---@return LuaSoulEquipMgr
function PlayerDataManager:GetLuaSoulEquipMgr()
    if (self.mLuaSoulEquipMgr == nil) then
        self.mLuaSoulEquipMgr = luaclass.LuaSoulEquipMgr:New()
    end
    return self.mLuaSoulEquipMgr;
end

---@return LuaSuitMgr
function PlayerDataManager:GetLuaSuitMgr()
    if (self.mLuaSuitMgr == nil) then
        self.mLuaSuitMgr = luaclass.LuaSuitMgr:New();
    end
    return self.mLuaSuitMgr;
end

---获取藏品数据
---@return LuaCollectionInfo
function PlayerDataManager:GetCollectionInfo()
    return self.mCollectionInfo
end

---玩家的外观数据
---@return LuaAppearanceInfo
function PlayerDataManager:GetAppearanceInfo()
    return self.mAppearanceInfo
end

---@return LuaPotentialEquipMgr 潜能武器
function PlayerDataManager:GetLuaPotentialEquipMgr()
    if (self.mLuaPotentialEquipMgr == nil) then
        self.mLuaPotentialEquipMgr = luaclass.LuaPotentialEquipMgr:New();
    end
    return self.mLuaPotentialEquipMgr
end

---封号天赋数据
---@return LuaMilitaryRankTitleFlairInfo
function PlayerDataManager:GetMilitaryRankTitleFlairInfo()
    if self.mMilitaryRankTitleFlairInfo == nil then
        self.mMilitaryRankTitleFlairInfo = luaclass.LuaMilitaryRankTitleFlairInfo:New()
    end
    return self.mMilitaryRankTitleFlairInfo
end

---潜能投资数据
---@return LuaPotentialInvestInfo
function PlayerDataManager:GetPotentialInvestInfo()
    if self.mPotentialInvestInfo == nil then
        self.mPotentialInvestInfo = luaclass.LuaPotentialInvestInfo:New()
    end
    return self.mPotentialInvestInfo
end

---@return LuaConfigManager
function PlayerDataManager:GetConfigManager()
    if self.mConfigManager == nil then
        self.mConfigManager = luaclass.LuaConfigManager:New()
    end
    return self.mConfigManager
end

---@public 沙巴克数据类
---@return LuaShaBaKDataMgr
function PlayerDataManager:GetShaBaKDataManager()
    if (self.mShaBaKDataManager == nil) then
        self.mShaBaKDataManager = luaclass.LuaShaBaKDataMgr:New();
    end
    return self.mShaBaKDataManager;
end

---@public 转生管理类
---@return LuaReinDataManager
function PlayerDataManager:GetReinDataManager()
    if (self.mReinDataManager == nil) then
        self.mReinDataManager = luaclass.LuaReinDataManager:New();
    end
    return self.mReinDataManager;
end

---@public 阵法管理类
---@return LuaZhenFaManager
function PlayerDataManager:GetZhenFaManager()
    if (self.mZhenFaManager == nil) then
        self.mZhenFaManager = luaclass.LuaZhenFaManager:New();
    end
    return self.mZhenFaManager;
end

---@public 珍珑棋局管理类 wxs
---@return LuaZhenlongqijuData
function PlayerDataManager:GetZhenlongqijuManager()
    if (self.mZhenlongqijuData == nil) then
        self.mZhenlongqijuData = luaclass.LuaZhenlongqijuData:New()
    end
    return self.mZhenlongqijuData
end
---@public 骑兵训练管理类 wxs
---@return CavalryDrillData
function PlayerDataManager:GetCavalryDrillManager()
    if (self.mCavalryDrillData == nil) then
        self.mCavalryDrillData = luaclass.CavalryDrillData:New()
    end
    return self.mCavalryDrillData
end

---@public 斗笠盾牌类
---@return LuaShieldAndHatManager
function PlayerDataManager:GetShieldAndHatManager()
    if self.ShieldAndHatManager == nil then
        self.ShieldAndHatManager = luaclass.ShieldAndHatManager:New()
    end
    return self.ShieldAndHatManager
end

---@public 幸运转盘类
---@return LuaLuckTurntableLotteryManager
function PlayerDataManager:GetLuckTurntableLotteryManager()
    if self.LuckTurntableLottery == nil then
        self.LuckTurntableLottery = luaclass.LuaLuckTurntableLotteryManager:New()
    end
    return self.LuckTurntableLottery
end

---@public 幸运转盘类
---@return LuaLuckTurn2tableLotteryManager
function PlayerDataManager:GetLuckTurn2tableLotteryManager()
    if self.LuckTurn2tableLottery == nil then
        self.LuckTurn2tableLottery = luaclass.LuaLuckTurn2tableLotteryManager:New()
    end
    return self.LuckTurn2tableLottery
end

---@public
---@return LuaBossDataManager
function PlayerDataManager:GetBossDataManager()
    if (self.mBossDataManager == nil) then
        self.mBossDataManager = luaclass.LuaBossDataManager:New();
    end
    return self.mBossDataManager
end

---@return LuaDigTreasureDataManager
function PlayerDataManager:GetDigTreasureManager()
    if (self.mDigTreasureManager == nil) then
        self.mDigTreasureManager = luaclass.LuaDigTreasureManager:New();
    end
    return self.mDigTreasureManager
end

---@public 系统预告数据管理
---@return LuaSystemPreviewInfoMgr
function PlayerDataManager:GetSystemPreviewMgr()
    if (self.mSystemPreviewManager == nil) then
        self.mSystemPreviewManager = luaclass.LuaSystemPreviewInfoMgr:New();
    end
    return self.mSystemPreviewManager
end

---主角经验兑换
---@return LuaMainPlayerExpExchange
function PlayerDataManager:GetMainPlayerExpExchange()
    return self.mLuaMainPlayerExpExchange
end

---鉴定数据管理
---@return LuaForgeIdentifyMgr
function PlayerDataManager:GetLuaForgeIdentifyMgr()
    if (self.mLuaForgeIdentifyMgr == nil) then
        self.mLuaForgeIdentifyMgr = luaclass.LuaForgeIdentifyMgr:New();
    end
    return self.mLuaForgeIdentifyMgr
end

---主角使用经验丹道具行为
---@return LuaMainPlayerUseExpProp
function PlayerDataManager:GetMainPlayerExpPropUsing()
    if self.mMainPlayerExpPropUsing == nil then
        self.mMainPlayerExpPropUsing = luaclass.LuaMainPlayerUseExpProp:New(self)
    end
    return self.mMainPlayerExpPropUsing
end

---怪物攻城数据管理
---@return LuaMonsterAttackMgr
function PlayerDataManager:GetLuaMonsterAttackMgr()
    if (self.mLuaMonsterAttackMgr == nil) then
        self.mLuaMonsterAttackMgr = luaclass.LuaMonsterAttackMgr:New();
    end
    return self.mLuaMonsterAttackMgr
end

---幽灵船数据管理
---@return LuaGhostShipMgr
function PlayerDataManager:GetLuaGhostShipMgr()
    if (self.mLuaGhostShipMgr == nil) then
        self.mLuaGhostShipMgr = luaclass.LuaGhostShipMgr:New();
    end
    return self.mLuaGhostShipMgr
end

---联盟数据管理
---@return LuaLeagueMgr
function PlayerDataManager:GetLuaLeagueMgr()
    if (self.mLuaLeagueManager == nil) then
        self.mLuaLeagueManager = luaclass.LuaLeagueMgr:New();
    end
    return self.mLuaLeagueManager
end

---联盟战旗数据管理 wxs
---@return LuaLeagueMgr
function PlayerDataManager:GetLuaLeagueFlagMgr()
    if (self.mLuaLeagueFlagManager == nil) then
        self.mLuaLeagueFlagManager = luaclass.LuaLeagueFlagMgr:New();
    end
    return self.mLuaLeagueFlagManager
end

---铭文红点数据管理
---@return LuaEquipRunesInfoMgr
function PlayerDataManager:GetLuaEquipRunesInfoMgr()
    if (self.mLuaEquipRunesInfoMgr == nil) then
        self.mLuaEquipRunesInfoMgr = luaclass.LuaEquipRunesInfoMgr:New();
    end
    return self.mLuaEquipRunesInfoMgr
end

---兵魂管理类
---@return LuaWeaponSoulMgr
function PlayerDataManager:GetLuaWeaponSoulMgr()
    if (self.mLuaWeaponSoulMgr == nil) then
        self.mLuaWeaponSoulMgr = luaclass.LuaWeaponSoulMgr:New();
    end
    return self.mLuaWeaponSoulMgr
end

---扶持礼包管理类
---@return LuaSupportAwardMgr
function PlayerDataManager:GetLuaSupportAwardMgr()
    if (self.mLuaSupportAwardMgr == nil) then
        self.mLuaSupportAwardMgr = luaclass.LuaSupportAwardMgr:New()
    end
    return self.mLuaSupportAwardMgr
end

---战灵复苏数据管理
---@return LuaBattleSoulAwakeMgr
function PlayerDataManager:GetLuaBattleSoulAwakeMgr()
    if (self.mLuaBattleSoulAwakeMgr == nil) then
        self.mLuaBattleSoulAwakeMgr = luaclass.LuaBattleSoulAwakeMgr:New();
    end
    return self.mLuaBattleSoulAwakeMgr
end

--[[*********************************事件绑定***********************************]]

---获取C#客户端事件绑定
---@return EventHandlerManager
function PlayerDataManager:GetClientEventHandler()
    if self.mClientEventHandler == nil then
        self.mClientEventHandler = CS.EventHandlerManager(CS.EventHandlerManager.DispatchType.Event)
    end
    return self.mClientEventHandler
end

---获取C#服务端事件绑定
---@return EventHandlerManager
function PlayerDataManager:GetServerEventHandler()
    if self.mServerEventHandler == nil then
        self.mServerEventHandler = CS.EventHandlerManager(CS.EventHandlerManager.DispatchType.Socket)
    end
    return self.mServerEventHandler
end

---获取一个Lua事件管理器
---@return LuaEventHandler
function PlayerDataManager:GetLuaEventHandler()
    if self.mLuaEventHandler == nil then
        self.mLuaEventHandler = eventHandler.CreateNew()
    end
    return self.mLuaEventHandler
end

---@return LuaLianZhiMgr 炼制大师数据管理
function PlayerDataManager:GetLuaLianZhiMgr()
    if (self.mLuaLianZhiMgr == nil) then
        self.mLuaLianZhiMgr = luaclass.LuaLianZhiMgr:New()
    end
    return self.mLuaLianZhiMgr
end

---@return LuaSfMissionManager 私服任务管理
function PlayerDataManager:GetSfMissionMgr()
    if (self.mSfMission == nil) then
        self.mSfMission = luaclass.LuaSfMissionManager:New()
    end
    return self.mSfMission
end

---@return LuaAccumulatedRechargeMissionMgr 累充计划管理
function PlayerDataManager:GeAccumulatedRechargeMissionMgr()
    if (self.mLuaAccumulatedRechargeMissionMgr == nil) then
        self.mLuaAccumulatedRechargeMissionMgr = luaclass.LuaAccumulatedRechargeMissionMgr:New()
    end
    return self.mLuaAccumulatedRechargeMissionMgr
end

---@return LuaDuplicateMgr 副本数据管理
function PlayerDataManager:GetLuaDuplicateMgr()
    if (self.mLuaDuplicateMgr == nil) then
        self.mLuaDuplicateMgr = luaclass.LuaDuplicateMgr:New()
    end
    return self.mLuaDuplicateMgr
end

---@return LuaCompetitionData 竞技数据管理
function PlayerDataManager:GetCompetitionDataMgr()
    if (self.LuaCompetitionData == nil) then
        self.LuaCompetitionData = luaclass.LuaCompetitionData:New()
    end
    return self.LuaCompetitionData
end

---@return LuaForgeQuenchDataManager 淬炼数据管理
function PlayerDataManager:GetForgeQuenchDataMgr()
    if self.mForgeQuenchDataMgr == nil then
        self.mForgeQuenchDataMgr = luaclass.LuaForgeQuenchDataManager:New()
    end
    return self.mForgeQuenchDataMgr
end

---@return LuaForgeQuenchSecondDataManager 淬炼2.0数据管理
function PlayerDataManager:GetForgeQuenchSecondDataMgr()
    if self.mForgeQuenchSecondDataMgr == nil then
        self.mForgeQuenchSecondDataMgr = luaclass.LuaForgeQuenchSecondDataManager:New()
    end
    return self.mForgeQuenchSecondDataMgr
end

---@return SettingManager 设置管理
function PlayerDataManager:GetSettingMgr()
    if (self.LuaSettingMgr == nil) then
        self.LuaSettingMgr = luaclass.SettingManager:New()
    end
    return self.LuaSettingMgr
end

---@return LuaRecastMgr 重铸管理类
function PlayerDataManager:GetRecastMgr()
    if (self.mLuaRecastMgr == nil) then
        self.mLuaRecastMgr = luaclass.LuaRecastMgr:New()
    end
    return self.mLuaRecastMgr
end

---@return LuaMainPlayerDataMgr lua角色数据管理类
function PlayerDataManager:GetMainPlayerDataMgr()
    if (self.LuaMainPlayerDataMgr == nil) then
        self.LuaMainPlayerDataMgr = luaclass.LuaMainPlayerDataMgr:New()
    end
    return self.LuaMainPlayerDataMgr
end

---@return LuaHorseDataManager 坐骑数据管理
function PlayerDataManager:GetHorseDataMgr()
    if self.mHorseDataMgr == nil then
        self.mHorseDataMgr = luaclass.LuaHorseDataManager:New()
    end
    return self.mHorseDataMgr
end

---@return DragonTreasureWarehouseData 巨龙宝藏仓库
function PlayerDataManager:GetDragonTreasureWarehouseData()
    if self.mDragonTreasureWarehouseData == nil then
        self.mDragonTreasureWarehouseData = luaclass.DragonTreasureWarehouseData:New()
    end
    return self.mDragonTreasureWarehouseData
end

---@return LuaFengShenZhiLuDataMgr 封神之路数据管理
function PlayerDataManager:GetFengShenZhiLuData()
    if self.mFengShenZhiLuData == nil then
        self.mFengShenZhiLuData = luaclass.FengShenZhiLuDataMgr:New()
    end
    return self.mFengShenZhiLuData
end

---@return LuaWarSpiritDataManager Lua战灵数据管理
function PlayerDataManager:GetLuaWarSpiritDataMgr()
    if self.mLuaWarSpiritData == nil then
        self.mLuaWarSpiritData = luaclass.LuaWarSpiritMgr:New()
    end
    return self.mLuaWarSpiritData
end


---@return LuaShortcutKeyMgr
function PlayerDataManager:GetShortcutMgr()
    if self.mShortcutMgr == nil then
        self.mShortcutMgr = luaclass.LuaShortcutKeyMgr:New()
    end
    return self.mShortcutMgr
end
---@return LuaDragonSupremacyInfoMgr 神龙争霸数据类
--function PlayerDataManager:GetDragonTreasureWarehouseMgr()
--    if self.mLuaDragonSupremacyInfoMgr == nil then
--       self.mLuaDragonSupremacyInfoMgr = luaclass.LuaDragonSupremacyInfoMgr:New()
--    end
--    return self.mLuaDragonSupremacyInfoMgr
--end

---@return LuaSFTPPutOperation SFTP上传数据类
function PlayerDataManager:GetLuaSFTPPutOperation()
    if self.mLuaSFTPPutOperation == nil then
        self.mLuaSFTPPutOperation = luaclass.LuaSFTPPutOperation:New()
    end
    return self.mLuaSFTPPutOperation
end
--[[*********************************周期函数***********************************]]

function PlayerDataManager:Init()
    self.mLuaMainPlayerEquipMgr = luaclass.LuaMainPlayerEquipMgr:New()
    self.mLuaAsyncOperationMgr = luaclass.LuaAsyncOperationMgr:New()
    self.mXPSkillInfo = luaclass.LuaXPSkillInfo:New(self)
    self.mGatherInfo = luaclass.LuaGatherInfo:New()

    self.mLuaSynthesisMgr = luaclass.LuaSynthesisMgr:New();
    self.mBaiRiMenActivityMgr = luaclass.BaiRiMenActivityMgr:New()
    self.mCollectionInfo = luaclass.LuaCollectionInfo:New(true, Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
    self.mAppearanceInfo = luaclass.LuaAppearanceInfo:New(self)
    self.mLuaMainPlayerExpExchange = luaclass.LuaMainPlayerExpExchange:New(self)
    self.mHorseMgr = luaclass.LuaHorseDataManager:New()

    uiStaticParameter.AllItemMaterialData = nil
    uiStaticParameter.IsEnterAncientBossPanel = false;
    uiStaticParameter.IsEnterCalendarPanel = false;
end

function PlayerDataManager:Update()
    if self:GetMainPlayerBetterItemHintDataMgr() ~= nil then
        self:GetMainPlayerBetterItemHintDataMgr():Update()
    end
    if self.mBaiRiMenActivityMgr ~= nil then
        self.mBaiRiMenActivityMgr:OnUpdate()
    end
    if self:GetMainPlayerBagMgr() then
        self:GetMainPlayerBagMgr():OnUpdate()
    end
    if self.mLuaMainPlayerExpExchange ~= nil then
        self.mLuaMainPlayerExpExchange:OnUpdate()
    end
    if self:GetForgeQuenchDataMgr() ~= nil then
        self:GetForgeQuenchDataMgr():Updata()
    end
    if self:GetForgeQuenchSecondDataMgr() ~= nil then
        self:GetForgeQuenchSecondDataMgr():Updata()
    end
    if self:GetLuaEquipRunesInfoMgr() ~= nil then
        self:GetLuaEquipRunesInfoMgr():Updata()
    end
end

function PlayerDataManager:Destroy()
    if self.mClientEventHandler ~= nil then
        self.mClientEventHandler:UnRegAll()
        self.mClientEventHandler = nil
    end

    if self.mServerEventHandler ~= nil then
        self.mServerEventHandler:UnRegAll()
        self.mServerEventHandler = nil
    end

    if self.mLuaEventHandler ~= nil then
        self.mLuaEventHandler:ReleaseAll()
        self.mLuaEventHandler = nil
    end

    if (self.mLuaServantInfo ~= nil) then
        self.mLuaServantInfo:OnDestroy()
        self.mLuaServantInfo = nil
    end

    if (self.mUnionInfo ~= nil) then
        self.mUnionInfo:OnDestroy()
        self.mUnionInfo = nil
    end

    if (self.mRechargeInfo ~= nil) then
        self.mRechargeInfo:OnDestroy()
        self.mRechargeInfo = nil
    end

    if (self.mPlayerVipInfo ~= nil) then
        self.mPlayerVipInfo:OnDestroy()
        self.mPlayerVipInfo = nil
    end

    if (self.mPlayerVip2Info ~= nil) then
        self.mPlayerVip2Info:OnDestroy()
        self.mPlayerVip2Info = nil
    end

    if (self.mPlayerTowerInfo ~= nil) then
        self.mPlayerTowerInfo:OnDestroy()
        self.mPlayerTowerInfo = nil
    end

    if self.mLuaAsyncOperationMgr then
        self.mLuaAsyncOperationMgr = luaclass.LuaAsyncOperationMgr:OnDestroy()
        self.mLuaAsyncOperationMgr = nil
    end

    if self.mGatherInfo ~= nil then
        self.mGatherInfo:OnDestroy()
    end

    if self.mLuaSynthesisMgr ~= nil then
        self.mLuaSynthesisMgr:Release()
    end

    if self.mLuaSpecialActivityData ~= nil then
        self.mLuaSpecialActivityData:Release()
    end

    if self.mBaiRiMenActivityMgr ~= nil then
        self.mBaiRiMenActivityMgr:OnDestroy()
    end

    if self.mCollectionInfo ~= nil then
        self.mCollectionInfo:OnDestroy()
    end

    if self.mLuaMainPlayerExpExchange ~= nil then
        self.mLuaMainPlayerExpExchange:OnDestroy()
    end

    if self.LuaMainPlayerDataMgr ~= nil then
        self.LuaMainPlayerDataMgr:OnDestroy()
        self.LuaMainPlayerDataMgr = nil
    end

    if self.mLuaWeaponSoulMgr ~= nil then
        self.mLuaWeaponSoulMgr:OnDestroy()
        self.mLuaWeaponSoulMgr = nil
    end
end

return PlayerDataManager