---@class LuaRedPointManager:luaobject
local LuaRedPointManager = {};

--region Component

---@class CSUIRedPointManager
function LuaRedPointManager:GetCSUIRedPointManager()
    return CS.CSUIRedPointManager:GetInstance();
end

--endregion

--region Method

--region Public

---@param isDelay boolean 是否参与延时计算(默认为true)
function LuaRedPointManager:CallRedPoint(key, isDelay)
    --if(isDelay == nil) then
    --    isDelay = true;
    --end

    --if(isDelay) then
    self:GetCSUIRedPointManager():CallRedPoint(key);
    --else
    --    self:GetCSUIRedPointManager():JustCallRedPoint(key);
    --end
end

function LuaRedPointManager:GetRedPointKey(redType, ...)
    local param = { ... }
    if redType == LuaEnumRedPointType.Synthesis then
        local servantEquipIndex = param[1]
        if servantEquipIndex ~= nil and type(servantEquipIndex) == 'number' and servantEquipIndex > 0 then
            if servantEquipIndex == LuaEnumServantEquipIndex.HM_SeravntEquip_Nao then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasHMNaoSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.HM_SeravntEquip_Xin then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasHMXinSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.HM_SeravntEquip_Gu then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasHMGuSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.HM_SeravntEquip_Xue then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasHMXueSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.HM_SeravntEquip_XiangLian then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasHMXiangLianSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.HM_SeravntEquip_LeftRing then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasHMLeftJieZhiSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.HM_SeravntEquip_RightRing then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasHMRightJieZhiSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.HM_SeravntEquip_LeftHand then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasHMLeftShouZhuoSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.HM_SeravntEquip_RightHand then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasHMRightShouZhuoSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.HM_SeravntEquip_Belt then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasHMYaoDaiSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.HM_SeravntEquip_Shoes then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasHMXieziSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.HM_MagicWeapon then
                return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_HM_MagicWeapon);

            elseif servantEquipIndex == LuaEnumServantEquipIndex.LX_SeravntEquip_Nao then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasLXNaoSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.LX_SeravntEquip_Xin then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasLXXinSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.LX_SeravntEquip_Gu then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasLXGuSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.LX_SeravntEquip_Xue then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasLXXueSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.LX_SeravntEquip_XiangLian then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasLXXiangLianSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.LX_SeravntEquip_LeftRing then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasLXLeftJieZhiSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.LX_SeravntEquip_RightRing then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasLXRightJieZhiSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.LX_SeravntEquip_LeftHand then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasLXLeftShouZhuoSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.LX_SeravntEquip_RightHand then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasLXRightShouZhuoSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.LX_SeravntEquip_Belt then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasLXYaoDaiSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.LX_SeravntEquip_Shoes then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasLXXieziSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.LX_MagicWeapon then
                return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_LX_MagicWeapon);

            elseif servantEquipIndex == LuaEnumServantEquipIndex.TC_SeravntEquip_Nao then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasTCNaoSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.TC_SeravntEquip_Xin then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasTCXinSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.TC_SeravntEquip_Gu then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasTCGuSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.TC_SeravntEquip_Xue then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasTCXueSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.TC_SeravntEquip_XiangLian then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasTCXiangLianSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.TC_SeravntEquip_LeftRing then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasTCLeftJieZhiSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.TC_SeravntEquip_RightRing then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasTCRightJieZhiSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.TC_SeravntEquip_LeftHand then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasTCLeftShouZhuoSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.TC_SeravntEquip_RightHand then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasTCRightShouZhuoSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.TC_SeravntEquip_Belt then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasTCYaoDaiSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.TC_SeravntEquip_Shoes then
                return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasTCXieziSynthesis)
            elseif servantEquipIndex == LuaEnumServantEquipIndex.TC_MagicWeapon then
                return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_TC_MagicWeapon);
            end
        end
    end
    return nil;
end
--function LuaRedPointManager:GetSynthesisListRedPointName(layer, type, itemId)
--    if(self.mSynthesisListRedPointNameDic == nil) then
--        self.mSynthesisListRedPointNameDic = {};
--    end
--    local name = (layer ~= nil and layer.."_" or "")..(type ~= nil and type.."_" or "")..(itemId ~= nil and itemId.."_" or "");
--
--
--end

function LuaRedPointManager:GetRoleEquipRedPointKey(equipIndex)
    if equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_WEAPON) then
        return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasWeaponSynthesis)
    elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_CLOTHES) then
        return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasClothesSynthesis)
    elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_HAND) then
        return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasLeftBraceletSynthesis)
    elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_RING) then
        return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasLeftRingSynthesis)
    elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_BELT) then
        return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasBeltSynthesis)
    elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_SHOES) then
        return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasShoesSynthesis)
    elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_RING) then
        return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasRightRingSynthesis)
    elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_HAND) then
        return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasRightBraceletSynthesis)
    elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_NECKLACE) then
        return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasNecklaceSynthesis)
    elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_HEAD) then
        return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasHelmetSynthesis)
    elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_LAMP) then
        return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasLampSynthesis)
    elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_SOULJADE) then
        return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasJadeSoulSynthesis)
    elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_RAWANIMA) then
        return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasRareTreasureSynthesis)
    elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_GEMGLOVE) then
        return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasJewelrySynthesis)
    elseif equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_MEDAL) then
        return Utility.EnumToInt(CS.RedPointKey.Synthesis_HasMedalSynthesis)
    end
    return nil;
end

function LuaRedPointManager:GetSynthesisEquipElementRedPointKey(index)
    if index == Utility.EnumToInt(CS.EEquipIndex.POS_WEAPON) then
        return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_WeaponElement)
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_CLOTHES) then
        return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_ClothesElement)
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_HAND) then
        return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_LeftBraceletElement)
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_RING) then
        return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_LeftRingElement)
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_BELT) then
        return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_BeltElement)
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_SHOES) then
        return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_ShoesElement)
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_RING) then
        return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_RightRingElement)
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_HAND) then
        return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_RightBraceletElement)
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_NECKLACE) then
        return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_NecklaceElement)
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_HEAD) then
        return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_HelmetElement)
    end
    return nil;
end

function LuaRedPointManager:GetSynthesisEquipSignetRedPointKey(index)
    if index == Utility.EnumToInt(CS.EEquipIndex.POS_WEAPON) then
        return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_WeaponSignet)
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_CLOTHES) then
        return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_ClothesSignet)
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_HAND) then
        return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_LeftBraceletSignet)
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_RING) then
        return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_LeftRingSignet)
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_BELT) then
        return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_BeltSignet)
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_SHOES) then
        return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_ShoesSignet)
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_RING) then
        return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_RightRingSignet)
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_HAND) then
        return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_RightBraceletSignet)
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_NECKLACE) then
        return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_NecklaceSignet)
    elseif index == Utility.EnumToInt(CS.EEquipIndex.POS_HEAD) then
        return self:GetLuaRedPointKey(LuaRedPointName.Synthesis_HelmetSignet)
    end
    return nil;
end

---获取合成列表物品按钮红点名
function LuaRedPointManager:GetSynthesisListRedPointName(itemId)
    if (itemId ~= nil) then
        --if(self:HasSynthesisRedKey(itemId)) then
        return "SynthesisList_ThirdPage_" .. itemId;
        --else
        --    return nil;
        --end
    end
    return "SynthesisList_All";
end

function LuaRedPointManager:GetSynthesisListSecondPageButtonRedPointName(firstType, secondType)
    if (firstType ~= nil and secondType ~= nil) then
        return "SynthesisList_" .. firstType .. "_" .. secondType;
    end
    return "SynthesisList_All";
end

function LuaRedPointManager:GetSynthesisListFirstPageButtonRedPointName(firstType)
    if (firstType ~= nil) then
        return "SynthesisList_" .. firstType;
    end
    return "SynthesisList_All";
end

function LuaRedPointManager:GetAllSynthesisListRedPointName()
    return "SynthesisList_All";
end

function LuaRedPointManager:GetLuaRedPointKey(redPointName)
    return self:GetCSUIRedPointManager():GetLuaRedPointKey(redPointName);
end
--endregion

--region Private

---注册红点计算类型(lua or cs)
function LuaRedPointManager:InitLuaCallRedPointType()
    --self:GetCSUIRedPointManager():RegisterRedPointCallType(CS.RedPointKey.BOSS_ALL, CS.RedPointCallType.LUA_AND_CS);
    self:GetCSUIRedPointManager():RegisterRedPointCallType(CS.RedPointKey.Recharge, CS.RedPointCallType.LUA_OR_CS);
    self:GetCSUIRedPointManager():RegisterRedPointCallType(CS.RedPointKey.Signet, CS.RedPointCallType.LUA_AND_CS);
    self:GetCSUIRedPointManager():RegisterRedPointCallType(CS.RedPointKey.Recharge_Reward, CS.RedPointCallType.LUA);
    self:GetCSUIRedPointManager():RegisterRedPointCallType(CS.RedPointKey.Recharge_ContinueReward, CS.RedPointCallType.LUA_OR_CS);
    self:GetCSUIRedPointManager():RegisterRedPointCallType(CS.RedPointKey.BOSS_ANCIENT, CS.RedPointCallType.LUA_AND_CS);
end

---注册红点计算逻辑回调
function LuaRedPointManager:InitLuaCallRedPointFunction()
    --region 官阶
    ---官阶信息
    local OfficialState_AllKey = self:GetLuaRedPointKey(LuaRedPointName.OfficialState);
    self.CallIsShowOfficialStateRedKey = function()
        return self:IsShowOfficialStateRedPoint()
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(OfficialState_AllKey, self.CallIsShowOfficialStateRedKey);
    --endregion

    --region boss
    self.CallIsShowBossAllKey = function()
        return self:IsIsShowDemonBossKey()
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(Utility.EnumToInt(CS.RedPointKey.BOSS_ALL), self.CallIsShowBossAllKey);

    local DemonBossKey = self:GetLuaRedPointKey(LuaRedPointName.BOSS_Demon);
    self.CallIsShowDemonBossKey = function()
        return self:IsIsShowDemonBossKey();
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(DemonBossKey, self.CallIsShowDemonBossKey);

    ---远古BOSS 计算逻辑
    self.CallLuaIsShowAncientBoss = function()
        return not uiStaticParameter.IsEnterAncientBossPanel;
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(CS.RedPointKey.BOSS_ANCIENT, self.CallLuaIsShowAncientBoss);

    ---个人boss
    local PersonalBossKey = self:GetLuaRedPointKey(LuaRedPointName.Boss_Persional);
    self.CallIsShowPersionBossKey = function()
        return self:IsShowPersionBossRedPoint();
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(PersonalBossKey, self.CallIsShowPersionBossKey);

    --endregion


    self.CallRecharge = function()
        if (CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.RechargeInfo == nil) then
            return false;
        end
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.Recharge_Reward);
        return gameMgr:GetPlayerDataMgr():GetRechargeInfo().IsExitdailyRechargeGiftBoxReward
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(Utility.EnumToInt(CS.RedPointKey.Recharge), self.CallRecharge);

    self.CallRecharge_Reward = function()
        if (CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.RechargeInfo == nil) then
            return false;
        end
        local isShow = CS.CSScene.MainPlayerInfo.RechargeInfo:IsShowRewardRedPoint() or gameMgr:GetPlayerDataMgr():GetRechargeInfo().IsExitdailyRechargeGiftBoxReward;
        return isShow
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(Utility.EnumToInt(CS.RedPointKey.Recharge_Reward), self.CallRecharge_Reward);

    self.CallSignet = function()
        if (CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.SignetV2 == nil) then
            return false;
        end
        if self.SignetNoticeTable == nil then
            self.SignetNoticeTable = clientTableManager.cfg_noticeManager:TryGetValue(57)
        end
        local isShow = CS.CSScene.MainPlayerInfo.SignetV2:RedEquipSignetSelect() and Utility.IsNoticeOpenSystem(self.SignetNoticeTable)
        return isShow
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(Utility.EnumToInt(CS.RedPointKey.Signet), self.CallSignet);

    --region 竞技
    ---等级竞技
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_DengJi), function()
        ---@type UICompetitionPanel
        local completePanel = uimanager:GetPanel("UICompetitionPanel")
        if completePanel == nil then
            return false
        end
        return completePanel:GetOpenServerActivityRedPointState(1)
    end)
    ---灵兽竞技
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_LingShou), function()
        ---@type UICompetitionPanel
        local completePanel = uimanager:GetPanel("UICompetitionPanel")
        if completePanel == nil then
            return false
        end
        return completePanel:GetOpenServerActivityRedPointState(2)
    end)
    ---元石竞技
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_YuanShi), function()
        ---@type UICompetitionPanel
        local completePanel = uimanager:GetPanel("UICompetitionPanel")
        if completePanel == nil then
            return false
        end
        return completePanel:GetOpenServerActivityRedPointState(3)
    end)
    ---灯芯竞技
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_DengXin), function()
        ---@type UICompetitionPanel
        local completePanel = uimanager:GetPanel("UICompetitionPanel")
        if completePanel == nil then
            return false
        end
        return completePanel:GetOpenServerActivityRedPointState(4)
    end)
    ---勋章竞技
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_XunZhang), function()
        ---@type UICompetitionPanel
        local completePanel = uimanager:GetPanel("UICompetitionPanel")
        if completePanel == nil then
            return false
        end
        return completePanel:GetOpenServerActivityRedPointState(5)
    end)
    ---星级竞技
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_XingJi), function()
        ---@type UICompetitionPanel
        local completePanel = uimanager:GetPanel("UICompetitionPanel")
        if completePanel == nil then
            return false
        end
        return completePanel:GetOpenServerActivityRedPointState(6)
    end)
    ---战勋竞技
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.Competition_KaiFu_ZhanXun), function()
        ---@type UICompetitionPanel
        local completePanel = uimanager:GetPanel("UICompetitionPanel")
        if completePanel == nil then
            return false
        end
        return completePanel:GetOpenServerActivityRedPointState(7)
    end)
    --endregion

    --region 灵兽修炼
    --self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.ServantPractice_HM), function()
    --    return self:IsShowServantPracticeRedPoint(luaEnumServantType.HM)
    --end)
    --self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.ServantPractice_LX), function()
    --    return self:IsShowServantPracticeRedPoint(luaEnumServantType.LX)
    --end)
    --self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.ServantPractice_TC), function()
    --    return self:IsShowServantPracticeRedPoint(luaEnumServantType.TC)
    --end)
    --endregion


    --region 联盟投票
    local LeagueVoteKey = self:GetLuaRedPointKey(LuaRedPointName.LeagueVote);
    self.CallIsShowLeagueVoteRedKey = function()
        return self:IsShowLeagueVoteRedKey()
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(LeagueVoteKey, self.CallIsShowLeagueVoteRedKey);
    --endregion

    --region 法宝
    ---法宝All
    local magicEquip_AllKey = self:GetLuaRedPointKey(LuaRedPointName.MagicEquip_All);
    self.CallIsShowMagicAllEquipRedKey = function()
        return self:IsShowMagicEquipRedPoint()
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(magicEquip_AllKey, self.CallIsShowMagicAllEquipRedKey);

    ---生肖法宝
    local magicEquip_SXKey = self:GetLuaRedPointKey(LuaRedPointName.MagicEquip_SX);
    self.CallIsShowMagicEquip_SXRedKey = function()
        return self:IsShowMagicEquipRedPointBySuitType(LuaEnumMagicEquipSuitType.ShengXiao)
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(magicEquip_SXKey, self.CallIsShowMagicEquip_SXRedKey);

    ---灵魂法宝
    local magicEquip_SoulKey = self:GetLuaRedPointKey(LuaRedPointName.MagicEquip_Soul);
    self.CallIsShowMagicEquip_SoulRedKey = function()
        return self:IsShowMagicEquipRedPointBySuitType(LuaEnumMagicEquipSuitType.LingHun)
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(magicEquip_SoulKey, self.CallIsShowMagicEquip_SoulRedKey);

    ---力量法宝
    local magicEquip_PowerKey = self:GetLuaRedPointKey(LuaRedPointName.MagicEquip_Power);
    self.CallIsShowMagicEquip_PowerRedKey = function()
        return self:IsShowMagicEquipRedPointBySuitType(LuaEnumMagicEquipSuitType.LiLiang)
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(magicEquip_PowerKey, self.CallIsShowMagicEquip_PowerRedKey);

    ---心灵法宝
    local magicEquip_XLKey = self:GetLuaRedPointKey(LuaRedPointName.MagicEquip_XL);
    self.CallIsShowMagicEquip_XLRedKey = function()
        return self:IsShowMagicEquipRedPointBySuitType(LuaEnumMagicEquipSuitType.XinLing)
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(magicEquip_XLKey, self.CallIsShowMagicEquip_XLRedKey);

    ---仙器法宝
    local magicEquip_XQKey = self:GetLuaRedPointKey(LuaRedPointName.MagicEquip_XQ);
    self.CallIsShowMagicEquip_XQRedKey = function()
        return self:IsShowMagicEquipRedPointBySuitType(LuaEnumMagicEquipSuitType.XianQi)
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(magicEquip_XQKey, self.CallIsShowMagicEquip_XQRedKey);
    --endregion

    --region Boss面板
    ---神级boss
    local bossGod_Key = self:GetLuaRedPointKey(LuaRedPointName.Boss_God);
    self.CallIsBossGod = function()
        return luaclass.FinalBossDataInfo:GetMythBossDataInfo():GetGodBossRedPointState()
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(bossGod_Key, self.CallIsBossGod);
    --endregion

    --region 血继
    ---血继总类型
    local BloodSuit_All = self:GetLuaRedPointKey(LuaRedPointName.BloodSuit_All);
    self.CallIsShowBloodSuit_All = function()
        return self:IsShowBloodSuitRed()
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(BloodSuit_All, self.CallIsShowBloodSuit_All);

    ---血继 妖
    local BloodSuit_Yao = self:GetLuaRedPointKey(LuaRedPointName.BloodSuit_Yao);
    self.CallIsShowBloodSuit_Yao = function()
        return self:IsShowBloodSuitRed(LuaEquipBloodSuitType.Yao)
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(BloodSuit_Yao, self.CallIsShowBloodSuit_Yao);

    ---血继 仙
    local BloodSuit_Xian = self:GetLuaRedPointKey(LuaRedPointName.BloodSuit_Xian);
    self.CallIsShowBloodSuit_BloodSuit_Xian = function()
        return self:IsShowBloodSuitRed(LuaEquipBloodSuitType.Xian)
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(BloodSuit_Xian, self.CallIsShowBloodSuit_BloodSuit_Xian);

    ---血继 魔
    local BloodSuit_Mo = self:GetLuaRedPointKey(LuaRedPointName.BloodSuit_Mo);
    self.CallIsShowBloodSuit_BloodSuit_Mo = function()
        return self:IsShowBloodSuitRed(LuaEquipBloodSuitType.Mo)
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(BloodSuit_Mo, self.CallIsShowBloodSuit_BloodSuit_Mo);

    ---血继 灵
    local BloodSuit_Ling = self:GetLuaRedPointKey(LuaRedPointName.BloodSuit_Ling);
    self.CallIsShowBloodSuit_BloodSuit_Ling = function()
        return self:IsShowBloodSuitRed(LuaEquipBloodSuitType.Ling)
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(BloodSuit_Ling, self.CallIsShowBloodSuit_BloodSuit_Ling);

    ---血继 神
    local BloodSuit_Shen = self:GetLuaRedPointKey(LuaRedPointName.BloodSuit_Shen);
    self.CallIsShowBloodSuit_BloodSuit_Shen = function()
        return self:IsShowBloodSuitRed(LuaEquipBloodSuitType.Shen)
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(BloodSuit_Shen, self.CallIsShowBloodSuit_BloodSuit_Shen);
    --endregion

    --region 血炼
    ---血继总类型
    local key = LuaRedPointName.BloodSuitSmelt_All
    local BloodSuitSmelt_All = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(key);
    self.CallIsShowBloodSuitSmelt_All = function()
        return self:IsShowBloodSuitSmeltRed(key)
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(BloodSuitSmelt_All, self.CallIsShowBloodSuitSmelt_All);

    ---血炼 妖
    local key = LuaRedPointName.BloodSuitSmelt_Yao
    local BloodSuitSmelt_Yao = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(key);
    self.CallIsShowBloodSuitSmelt_Yao = function()
        return self:IsShowBloodSuitSmeltRed(key)
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(BloodSuitSmelt_Yao, self.CallIsShowBloodSuitSmelt_Yao);

    ---血炼 仙
    local key = LuaRedPointName.BloodSuitSmelt_Xian
    local BloodSuitSmelt_Xian = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(key);
    self.CallIsShowBloodSuitSmelt_Xian = function()
        return self:IsShowBloodSuitSmeltRed(key)
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(BloodSuitSmelt_Xian, self.CallIsShowBloodSuitSmelt_Xian);

    ---血炼 魔
    local key = LuaRedPointName.BloodSuitSmelt_Mo
    local BloodSuitSmelt_Mo = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(key);
    self.CallIsShowBloodSuitSmelt_Mo = function()
        return self:IsShowBloodSuitSmeltRed(key)
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(BloodSuitSmelt_Mo, self.CallIsShowBloodSuitSmelt_Mo);

    ---血炼 灵
    local key = LuaRedPointName.BloodSuitSmelt_Ling
    local BloodSuitSmelt_Ling = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(key);
    self.CallIsShowBloodSuitSmelt_Ling = function()
        return self:IsShowBloodSuitSmeltRed(key)
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(BloodSuitSmelt_Ling, self.CallIsShowBloodSuitSmelt_Ling);

    ---血炼 神
    local key = LuaRedPointName.BloodSuitSmelt_Shen
    local BloodSuitSmelt_Shen = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(key);
    self.CallIsShowBloodSuitSmelt_Shen = function()
        return self:IsShowBloodSuitSmeltRed(key)
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(BloodSuitSmelt_Shen, self.CallIsShowBloodSuit_BloodSuit_Shen);
    --endregion

    --region神炼
    local key = LuaRedPointName.ForgeGodPowerSmelt_All
    local ForgeGodPowerSmelt_All = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(key);
    self.CallIsShowForgeGodPowerSmelt_All = function()
        return gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():IsShowForgeGodPowerSmeltRed()
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(ForgeGodPowerSmelt_All, self.CallIsShowForgeGodPowerSmelt_All);
    --endregion

    --endregion

    --region 封号
    local SealMark = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.SealMark);
    self.CallIsShowSealMarkRedKey = function()
        return self:IsShowSealMarkRedKey()
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(SealMark, self.CallIsShowSealMarkRedKey);

    -- 封号天赋
    local TitleTalentMark = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.TitleTalentMark);
    self.CallIsShowTitleTalentMarkRedKey = function()
        if not CS.CSSystemController.Sington:CheckSystem(67) then
            return false
        end
        -- 未到开启等级 不展示红点
        local isFind, tbl_global = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22918)
        if isFind then
            if tonumber(tbl_global.value) > CS.CSScene.MainPlayerInfo.SealMarkId then
                return false
            end
        end
        local TalentData = gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():GetTalentData()
        return TalentData[7] > 0
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(TitleTalentMark, self.CallIsShowTitleTalentMarkRedKey);
    --endregion

    --region 潜能
    local Potential = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Potential);
    self.CallIsShowPotentialRedKey = function()
        if uiStaticParameter.PotentialRedPointInfo then
            for i = 0, 3 do
                if uiStaticParameter.PotentialRedPointInfo[i] == true then
                    return true
                end
            end
        end
        return false
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(Potential, self.CallIsShowPotentialRedKey);
    --endregion

    --region 阵法
    local ZhenFa = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ZhenFa);
    self.CallIsShowZhenFaRedKey = function()
        if not CS.CSSystemController.Sington:CheckSystem(83) then
            return false
        end
        return gameMgr:GetPlayerDataMgr():GetZhenFaManager():IsShowZhenFaRedPoint()
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(ZhenFa, self.CallIsShowZhenFaRedKey);
    --endregion

    --region 升星
    ---升星总类型
    local key = LuaRedPointName.Strength_All
    local allStrength = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(key);
    self.CallIsShowAllStrength = function()
        return gameMgr:GetPlayerDataMgr():GetLuaStrengthInfo():NeedShowAllStrengthRedPoint()
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(allStrength, self.CallIsShowAllStrength);
    --endregion

    --region 维修
    local key = LuaRedPointName.Repair_Servant
    local Repair_Servant = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(key);
    self.CallIsShowRepairServant = function()
        return gameMgr:GetPlayerDataMgr():GetLuaRepairInfo():NeedShowServantRepairRedPoint()
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(Repair_Servant, self.CallIsShowRepairServant);
    --endregion

    --region 装备专精
    local key = LuaRedPointName.Equip_Proficient
    local Equip_Proficient = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(key);
    self.CallIsShowProficient = function()
        return gameMgr:GetPlayerDataMgr():GetEquipProficientMgr().RedActive
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(Equip_Proficient, self.CallIsShowProficient);
    --endregion

    --region 连充
    self.CallIsShowConRechargeKey = function()
        return self:IsShowConRechargeKey()
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(Utility.EnumToInt(CS.RedPointKey.Recharge_ContinueReward), self.CallIsShowConRechargeKey);
    --endregion

    --region
    ---投资总红点
    local Investment_All = self:GetLuaRedPointKey(LuaRedPointName.Investment_All);
    self.CallIsShowInvestment_All = function()
        return self:IsShowInvestmentRed(LuaRedPointName.Investment_All)
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(Investment_All, self.CallIsShowInvestment_All);

    ---投资红点1
    local Investment_One = self:GetLuaRedPointKey(LuaRedPointName.Investment_One);
    self.CallIsShowInvestment_One = function()
        return self:IsShowInvestmentRed(LuaRedPointName.Investment_One)
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(Investment_One, self.CallIsShowInvestment_One);

    ---投资红点2
    local Investment_Two = self:GetLuaRedPointKey(LuaRedPointName.Investment_Two);
    self.CallIsShowInvestment_Two = function()
        return self:IsShowInvestmentRed(LuaRedPointName.Investment_Two)
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(Investment_Two, self.CallIsShowInvestment_Two);

    --endregion

    --region 炼制功勋推送
    --local LianZhi_LingShou = self:GetLuaRedPointKey(LuaRedPointName.LianZhi_LingShou);
    --self.CallIsShowLianZhi_LingShou = function()
    --    return gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr().isPushRed_LingShou
    --end
    --self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(LianZhi_LingShou, self.CallIsShowLianZhi_LingShou);

    local LianZhi_GongXun = self:GetLuaRedPointKey(LuaRedPointName.LianZhi_GongXun);
    self.CallIsShowLianZhi_GongXun = function()
        return gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr().isPushRed_GongXun
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(LianZhi_GongXun, self.CallIsShowLianZhi_GongXun);

    local LianZhi_XiuWei = self:GetLuaRedPointKey(LuaRedPointName.LianZhi_XiuWei);
    self.CallIsShowLianZhi_XiuWei = function()
        return gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr().isPushRed_XiuWei
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(LianZhi_XiuWei, self.CallIsShowLianZhi_XiuWei);
    --endregion

    --region 骑术技能红点推送
    local QiShuSkill = self:GetLuaRedPointKey(LuaRedPointName.QiShuSkill);
    self.CallIsShowQiShuSkill = function()
        return gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr():IsCanLearnQishuSkill()
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(QiShuSkill, self.CallIsShowQiShuSkill);
    --endregion

    --region 藏品
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.Collection), function()
        return gameMgr:GetPlayerDataMgr():GetCollectionInfo():IsRedPointShouldExist()
    end)
    --endregion

    --region 累充计划（领奖）
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.AccumulatedRecharge), function()
        return gameMgr:GetPlayerDataMgr():GeAccumulatedRechargeMissionMgr():IsShowRedPoint()
    end)
    --endregion

    --region 外观
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.NewAppearance), function()
        if gameMgr:GetPlayerDataMgr() == nil or gameMgr:GetPlayerDataMgr():GetAppearanceInfo() == nil then
            return false
        end
        local result = gameMgr:GetPlayerDataMgr():GetAppearanceInfo():IsRedPointShouldShow()
        return result
    end)
    --endregion

    --region 潜能投资红点
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.PotentialInvestRedPoint), function()
        return gameMgr:GetPlayerDataMgr():GetPotentialInvestInfo():IsShowRedPoint()
    end)
    --endregion

    --region 会员面板
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.MemberPanelRewardRedPoint), function()
        return gameMgr:GetPlayerDataMgr():GetLuaMemberInfo():IsShowRedPoint()
    end)
    --endregion

    --region 怪物悬赏红点
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.MonsterArrest), function()
        return gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetMonsterArrestData():IsShowRedPoint()
    end)
    --endregion

    --region 仙装红点
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.XianZhuangPush), function()
        return gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():HasBetterXianZhuangEquipInBag()
    end)
    --endregion

    --region 转生
    self.CanUpReinLv = function()
        return gameMgr:GetPlayerDataMgr():GetReinDataManager():IsShowReinRedPoint()
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.LuaRoleReinRedPoint), self.CanUpReinLv);
    --endregion

    --region 系统预告
    local SystemPreviewRed = self:GetLuaRedPointKey(LuaRedPointName.SystemPreview);
    self.CallIsShowSystemPreview = function()
        return gameMgr:GetPlayerDataMgr():GetSystemPreviewMgr():IsShowAllRedPoint()
    end
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(SystemPreviewRed, self.CallIsShowSystemPreview);
    --endregion

    --region 鉴定红点
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.JianDingRedPoint), function()
        return gameMgr:GetPlayerDataMgr():GetLuaForgeIdentifyMgr():IsShowRedPoint()
    end)
    --endregion

    --region 连充红点
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.LianChongRedPoint), function()
        return gameMgr:GetPlayerDataMgr():GeAccumulatedRechargeMissionMgr():CheckRedPoint()
    end)
    --endregion

    --region 重铸红点
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.Recast_DengZuo), function()
        if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetRecastMgr():GetRecastList():GetRecastInfo(LuaEnumRecastType.DengZuo) ~= nil then
            return CS.StaticUtility.IsNullOrEmpty(gameMgr:GetPlayerDataMgr():GetRecastMgr():GetRecastList():GetRecastInfo(LuaEnumRecastType.DengZuo):CanUpRecastLevel())
        end
    end)
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.Recast_YuPei), function()
        if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetRecastMgr():GetRecastList():GetRecastInfo(LuaEnumRecastType.YuPei) ~= nil then
            return CS.StaticUtility.IsNullOrEmpty(gameMgr:GetPlayerDataMgr():GetRecastMgr():GetRecastList():GetRecastInfo(LuaEnumRecastType.YuPei):CanUpRecastLevel())
        end
    end)
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.Recast_MiBao), function()
        if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetRecastMgr():GetRecastList():GetRecastInfo(LuaEnumRecastType.MiBao) ~= nil then
            return CS.StaticUtility.IsNullOrEmpty(gameMgr:GetPlayerDataMgr():GetRecastMgr():GetRecastList():GetRecastInfo(LuaEnumRecastType.MiBao):CanUpRecastLevel())
        end
    end)
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.Recast_BaoShi), function()
        if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetRecastMgr():GetRecastList():GetRecastInfo(LuaEnumRecastType.BaoShi) ~= nil then
            return CS.StaticUtility.IsNullOrEmpty(gameMgr:GetPlayerDataMgr():GetRecastMgr():GetRecastList():GetRecastInfo(LuaEnumRecastType.BaoShi):CanUpRecastLevel())
        end
    end)
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.Recast_LingHunKeYin), function()
        if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetRecastMgr():GetRecastList():GetRecastInfo(LuaEnumRecastType.LingHunKeYin) ~= nil then
            return CS.StaticUtility.IsNullOrEmpty(gameMgr:GetPlayerDataMgr():GetRecastMgr():GetRecastList():GetRecastInfo(LuaEnumRecastType.LingHunKeYin):CanUpRecastLevel())
        end
    end)
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.Recast_MianSha), function()
        if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetRecastMgr():GetRecastList():GetRecastInfo(LuaEnumRecastType.MianSha) ~= nil then
            return CS.StaticUtility.IsNullOrEmpty(gameMgr:GetPlayerDataMgr():GetRecastMgr():GetRecastList():GetRecastInfo(LuaEnumRecastType.MianSha):CanUpRecastLevel())
        end
    end)
    --endregion

    --region 生肖Boss红点
    self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(LuaRedPointName.Boss_ShengXiao), function()
        return gameMgr:GetPlayerDataMgr():GetBossDataManager():ShengXiaoRedPoint()
    end)
    --endregion

end

---进入游戏后注册红点回调
function LuaRedPointManager:EnterGameInitLuaCallRedPointFunction()
    --region 白日门活动红点
    local baiRiMenActivityInfoList = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetAllActControllers()
    if type(baiRiMenActivityInfoList) == 'table' and Utility.GetLuaTableCount(baiRiMenActivityInfoList) > 0 then
        for k, v in pairs(baiRiMenActivityInfoList) do
            ---@type BaiRiMenActControllerBase
            local baiRiMenActivity = v
            if baiRiMenActivity ~= nil and CS.StaticUtility.IsNullOrEmpty(baiRiMenActivity:GetBaiRiMenRedPointKey()) == false then
                self:GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self:GetLuaRedPointKey(baiRiMenActivity:GetBaiRiMenRedPointKey()), function()
                    return baiRiMenActivity:RedPointCallBack()
                end)
            end
        end
    end
    --endregion
end

---进入游戏后刷新红点
function LuaRedPointManager:EnterGameCallRedPointFunction()
    ---大退进入游戏显示红点
    --self:SetTheFirstLoginRedDot(LuaRedPointName.DigTreasureRedPoint)
    ---每次进入游戏显示红点
    --self:SetTheFirstLoginRedDot(LuaRedPointName.DigTreasureRedPoint,true)
end

---@type <number,boolean> 首次登录红点字典<id,state>
LuaRedPointManager.firstLoginRedDotDic = {}

---设置首次登录红点
---@param id number
---@param state boolean
---@param isCall boolean 是否调用Call方法
function LuaRedPointManager:SetTheFirstLoginRedDot(id, state, isCall)
    if (id == nil or id == '') then
        return
    end
    if (self.firstLoginRedDotDic == nil) then
        self.firstLoginRedDotDic = {}
    end
    ---@type boolean 上一次的红点状态
    local oldState = self.firstLoginRedDotDic[id]
    ---如果是新的红点类型，不管有没有设置状态，都会被改变 
    ---如果不是新的红点类型，只有设置状态才会被改变
    if (self.firstLoginRedDotDic[id] == nil) then
        self.firstLoginRedDotDic[id] = state == nil and true or state
    else
        if (state ~= nil) then
            self.firstLoginRedDotDic[id] = state
        end
    end
    if ((isCall == nil or isCall == true) and oldState ~= self.firstLoginRedDotDic[id]) then
        self:CallRedPointKey(id)
    end
end

---获取首次登录红点状态
---@param id number
---@return boolean 红点状态
function LuaRedPointManager:GetTheFirstLoginRedDot(id)
    if (self.firstLoginRedDotDic == nil or id == nil or id == '') then
        return false
    end
    if (self.firstLoginRedDotDic[id] == nil) then
        return false
    end
    return self.firstLoginRedDotDic[id]
end

---Call所有首次登录的红点
function LuaRedPointManager:CallAllTheFirstLoginRedDot()
    if (self.firstLoginRedDotDic == nil) then
        return
    end
    for i, v in pairs(self.firstLoginRedDotDic) do
        self:CallRedPointKey(i)
    end
end
--endregion

--region boss
---刷新魔之boss红点
function LuaRedPointManager:IsIsShowDemonBossKey()
    --if (CS.CSScene.MainPlayerInfo ~= nil) then
    --    return luaclass.MagicBossDataInfo:ShowMagicBossRedPoint()
    --end
    return false
end

---触发刷新魔之boss红点
---@param closeRedPoint boolean 强制关闭红点
---@param callReason LuaEnumCallMagicBossRedPointReason 红点触发来源
function LuaRedPointManager:CallMagicBossRedPoint(closeRedPoint, callReason)
    uiStaticParameter.MagicBossRedPointLock = closeRedPoint
    self:CallRedPointKey(CS.RedPointKey.BOSS_ALL)
    self:CallRedPointKey(LuaRedPointName.BOSS_Demon)
end
--endregion

--region 官阶
---是否显示官阶红点
---@return boolean 官阶红点
function LuaRedPointManager:IsShowOfficialStateRedPoint()
    if gameMgr == nil or gameMgr:GetPlayerDataMgr() == nil or gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo() == nil
            or gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo():GetNextOfficialTable() == nil then
        return false
    end
    return CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo():getCurLevelUpConditionsId()) and
            gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo():getCurLevelUpCostItemId()) >= gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo():getCurLevelUpCostItemCount()
end
--endregion

--region 法宝
---是否显示法宝红点
---@return boolean 法宝红点
function LuaRedPointManager:IsShowMagicEquipRedPoint()
    if gameMgr == nil or gameMgr:GetPlayerDataMgr() == nil or LuaGlobalTableDeal:IsOpenPlayerMagicEquipBtn(CS.CSScene.MainPlayerInfo.Level, true) == false then
        return false
    end
    return gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():HaveCanEquippedMagicEquip()
end

---是否显示法宝类型红点
---@param suitType LuaEnumMagicEquipSuitType 法宝套装类型
---@return boolean
function LuaRedPointManager:IsShowMagicEquipRedPointBySuitType(suitType)
    if gameMgr == nil or gameMgr:GetPlayerDataMgr() == nil or LuaGlobalTableDeal:IsOpenPlayerMagicEquipBtn(CS.CSScene.MainPlayerInfo.Level, true) == false then
        return false
    end
    local magicEquipmentListDataInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetMagicEquipListBySuitType(suitType)
    if magicEquipmentListDataInfo == nil then
        return false
    end
    return magicEquipmentListDataInfo:HaveCanEquip()
end
--endregion

---是否显示血继类型红点
---@param suitType LuaEquipBloodSuitType 血继套装类型
---@return boolean
function LuaRedPointManager:IsShowBloodSuitRed(type)
    if gameMgr == nil or gameMgr:GetPlayerDataMgr() == nil then
        return false
    end
    return gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr():IsShowBloodSuitRed(type)
end
--endregion

---是否显示投资类型红点
---@param type LuaRedPointName 投资红点类型
---@return boolean
function LuaRedPointManager:IsShowInvestmentRed(type)
    if gameMgr == nil or gameMgr:GetPlayerDataMgr() == nil then
        return false
    end
    return gameMgr:GetPlayerDataMgr():GetMainPlayerInvestmentMgr():IsOpenRed(type)
end
--endregion

--region 血炼

---是否显示血炼类型红点
---@param type LuaRedPointName 血继套装类型
---@return boolean
function LuaRedPointManager:IsShowBloodSuitSmeltRed(type)
    if gameMgr == nil or gameMgr:GetPlayerDataMgr() == nil then
        return false
    end
    return gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitSmeltMgr():GetTypeItemCanShowRedPoint(type)
end
--endregion

--region 灵兽修炼
---@return boolean 是否显示该灵兽修炼提示红点(没有修炼，活着)
function LuaRedPointManager:IsShowServantPracticeRedPoint(servantType)
    return gameMgr:GetPlayerDataMgr():GetLuaServantInfo():CanShowRedPoint(servantType)
end
--endregion

--region 联盟

---是否显示联盟投票红点
function LuaRedPointManager:IsShowLeagueVoteRedKey()
    if gameMgr:GetPlayerDataMgr() ~= nil then
        return gameMgr:GetPlayerDataMgr():GetLeagueInfo():GetTodayLeagueVoteType() == LuaEnumLeagueType.None
    end
    return false
end

--endregion

--region 封号

---是否显示封号红点
function LuaRedPointManager:IsShowSealMarkRedKey()
    if not CS.CSSystemController.Sington:CheckSystem(67) then
        return false
    end

    if CS.CSScene.MainPlayerInfo ~= nil then
        ---判断是否满级
        local curID = CS.CSScene.MainPlayerInfo.SealMarkId

        local nextTblInfo = clientTableManager.cfg_prefix_titleManager:TryGetValue(curID + 1)
        if nextTblInfo == nil then
            return false
        end
    end

    if uiStaticParameter.GetUpSealMarkNeedInfo() ~= nil then
        if (not uiStaticParameter.GetUpSealMarkNeedInfo().canBeUpgraded) then
            return false
        end
    end

    return true
end
--endregion

--region lua部分显示连充红点
function LuaRedPointManager:IsShowConRechargeKey()
    if gameMgr:GetPlayerDataMgr() ~= nil then
        return gameMgr:GetPlayerDataMgr():GetRechargeInfo():ShowLuaLCRedPoint()
    end
    return false
end
--endregion

function LuaRedPointManager:Initialize()
    self:InitLuaCallRedPointType();
    self:InitLuaCallRedPointFunction();
end

function LuaRedPointManager:EnterGameInitialize()
    self:EnterGameInitLuaCallRedPointFunction()
end

function LuaRedPointManager:EnterGameCallRedPoint()
    self:EnterGameCallRedPointFunction()
end
--endregion

--region Common
---添加红点
---@param redPoint Top_UIRedPoint 红点组件
---@param id number 红点枚举
function LuaRedPointManager:AddRedPointKey(redPoint, id)
    local key = id
    if type(id) == 'string' then
        key = self:GetLuaRedPointKey(id);
    end
    redPoint:AddRedPointKey(key)
end

---触发红点
---@param id number 红点枚举
function LuaRedPointManager:CallRedPointKey(id)
    local key = id
    if type(id) == 'string' then
        key = self:GetLuaRedPointKey(id);
    end
    self:CallRedPoint(key)
end

---获取红点状态
---@return boolean 红点是否激活
function LuaRedPointManager:GetRedPointState(id)
    local key = id
    if type(id) == 'string' then
        key = self:GetLuaRedPointKey(id);
    end
    return self:GetCSUIRedPointManager():GetRedPointValue(key);
end
--endregion
--region 个人Boss
---个人boss是否显示
---@return boolean
function LuaRedPointManager:IsShowPersionBossRedPoint()
    if uiStaticParameter.PersonalBossRedPointLock then
        return false
    end
    if not Utility.CheckSystemOpenState(78) then
        return false
    end
    local isFind, personalBossDic = CS.CSScene.MainPlayerInfo.BossInfoV2.BossInfoDic:TryGetValue(LuaEnumBossType.PersonalBoss)
    if isFind then
        local personalBossTable = Utility.CSDicChangeTable(personalBossDic)
        if personalBossTable ~= nil then
            for k, v in pairs(personalBossTable) do
                local bossList = v
                if bossList ~= nil and bossList.Count > 0 then
                    local length = bossList.Count - 1
                    for i = 0, length do
                        local CSBossInfo = bossList[i]
                        if CSBossInfo ~= nil and CSBossInfo.Count > 0 then
                            local bossInfo = clientTableManager.cfg_bossManager:TryGetValue(CSBossInfo.BossId)
                            if Utility.IsMeetBossCondition(bossInfo) then
                                return true
                            end
                        end
                    end
                end
            end
        end
    end
    return false
end

---触发刷新个人boss红点
function LuaRedPointManager:CallPersonalBossRedPoint()
    self:CallRedPointKey(LuaRedPointName.Boss_Persional)
end

--endregion

return LuaRedPointManager;