---@type Utility
local Utility = Utility

LuaConditionType = {
    ---人物等级
    RoleLevel = 1,
    ---低于人物等级
    RoleLevelLessThan = 2,
    ---人物转生等级
    RoleReinLevel = 3,
    ---人物转生等级低于
    RoleReinLevelLessThan = 4,
    ---开服天数不小于
    OpenDaysOfServiceIsNotLessThan = 8,
    ---开服天数小于
    OpenDaysOfServiceIsLessThan = 9,
    ---月卡
    MothCardType = 22,
    ---充值钻石数量不低于...
    RechargeDiamondAmountNotLowerThan = 28,
    ---可替换材料
    ReplaceMaterial = 33,
    ---是否联服
    CheckShare = 48,
    ---灵兽的转生等级
    ServantReinLevel = 55,
    ---人物buff
    RoleBuffList = 57,
    ---官职等级
    OfficialSeal = 60,
    ---骑术技能等级
    QiShuSkillLevel = 62,
    ---充值钻石数小于x，过零点生效
    RechargedDiamondsGreaterLessThan = 63,
    ---充值钻石数大于等于x，过零点生效
    RechargedDiamondsGreaterThanOrEqual = 64,
    ---会员等级
    MemberLevel = 65,
    ---仅充值钻石
    RechargeDiamond = 78,
    ---会员等级区间
    MemberLevelInterval = 79,
    ---攻击力
    FightPower = 80,
    ---封号等级
    MilitaryRankTitle = 81,
    ---灵魂刻印等级
    SoulImprint = 83,
    ---法宝套装等级
    MagicEquipSuitLevel = 84,
    ---挖宝次数
    WaBaoCount = 85,
    ---阵法等级
    ZhenFaLevel = 86,
    ---佩戴神器数量
    MagicEquipSuitNum = 87,
    ---灵兽位和背包是否有灵兽
    ServantIndexAndBagHaveServant = 89,
    ---怪物击杀数量
    MonsterKill = 91,
    ---合服大于
    ServiceIsGreaterThan = 93,
    ---合服小于
    ServiceIsLessThan = 94,
    ---重铸总等级
    RecastTotalLevel = 95,
}

---@param id number TABLE.cfg_condition表格的id
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_LuaAndCS(id)
    ---@type TABLE.cfg_conditions
    local conditionTbl = clientTableManager.cfg_conditionsManager:TryGetValue(id)
    if conditionTbl == nil then
        return nil
    end
    local conditionResult = Utility.IsMainPlayerMatchCondition(id)
    if conditionResult == nil then
        ---@type LuaMatchConditionResult
        conditionResult = {}
        conditionResult.success = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(id)
        conditionResult.txt = conditionTbl:GetTxt()
        conditionResult.type = conditionTbl:GetConditionType()
        conditionResult.param = conditionTbl:GetConditionParam()
    end
    return conditionResult
end

---@class LuaMatchConditionResult
---@field success boolean 是否满足条件
---@field txt string 不满足的情况下的文本提示
---@field param string 目标条件
---@field type number 目标类型PS: 1为等级不足 2为转生不足
---@field mMothCardList table<number> 月卡要求的类型list类型
---@field mReplaceMatData ReplaceMatData 可替换道具数据

---@param id number TABLE.cfg_condition表格的id
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition(id)
    ---@type TABLE.cfg_conditions
    local conditionTbl = clientTableManager.cfg_conditionsManager:TryGetValue(id)
    if conditionTbl == nil then
        return
    end

    if (conditionTbl:GetConditionType() == LuaConditionType.RoleLevel) then
        return Utility.IsMainPlayerMatchCondition_RoleLevel(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.RoleLevelLessThan) then
        return Utility.IsMainPlayerMatchCondition_RoleLevelLessThan(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.RoleReinLevel) then
        return Utility.IsMainPlayerMatchCondition_RoleReinLevel(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.RoleReinLevelLessThan) then
        return Utility.IsMainPlayerMatchCondition_RoleReinLevelLessThan(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.RoleBuffList) then
        return Utility.IsMainPlayerMatchCondition_RoleBuffList(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.MothCardType) then
        return Utility.IsMainPlayerMatchCondition_MonthCard(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.ServantReinLevel) then
        return Utility.IsMainPlayerMatchCondition_ServantReinLevel(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.OfficialSeal) then
        return Utility.IsMainPlayerMatchCondition_OfficialSeal(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.QiShuSkillLevel) then
        return Utility.IsMainPlayerMatchCondition_QiShuSkill(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.RechargedDiamondsGreaterLessThan) then
        return Utility.IsMainPlayerMatchCondition_RechargedDiamondsGreaterLessThan(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.RechargedDiamondsGreaterThanOrEqual) then
        return Utility.IsMainPlayerMatchCondition_RechargedDiamondsGreaterThanOrEqual(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.MemberLevel) then
        return Utility.IsMainPlayerMatchCondition_MemberLevel(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.MemberLevelInterval) then
        return Utility.IsMainPlayerMatchCondition_MemberLevelInterval(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.SoulImprint) then
        return Utility.IsMainPlayerMatchCondition_SoulImprint(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.MagicEquipSuitLevel) then
        return Utility.IsMainPlayerMatchCondition_MagicEquipSuitLv(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.FightPower) then
        return Utility.IsMainPlayerMatchCondition_FightPower(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.MilitaryRankTitle) then
        return Utility.IsMainPlayerMatchCondition_MilitaryRankTitle(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.ReplaceMaterial) then
        return Utility.IsMainPlayerMatchCondition_ReplaceMaterial(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.RechargeDiamond) then
        return Utility.IsMainPlayerMatchCondition_RechargeDiamond(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.WaBaoCount) then
        return Utility.IsMainPlayerMatchCondition_WaBaoCiShu(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.MagicEquipSuitNum) then
        return Utility.IsMainPlayerMatchCondition_MagicEquipSuitNum(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.ServantIndexAndBagHaveServant) then
        return Utility.IsMainPlayerMatchCondition_ServantIndexAndBagHaveServant(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.ZhenFaLevel) then
        return Utility.IsMainPlayerMatchCondition_ZhenFaLevel(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.MonsterKill) then
        return Utility.IsMainPlayerMatchCondition_Monsterkill(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.ServiceIsGreaterThan) then
        return Utility.IsMainPlayerMatchCondition_ServiceIsGreaterThan(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.ServiceIsLessThan) then
        return Utility.IsMainPlayerMatchCondition_ServiceIsLessThan(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.OpenDaysOfServiceIsNotLessThan) then
        return Utility.IsMainPlayerMatchCondition_OpenDaysOfServiceIsNotLessThan(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.OpenDaysOfServiceIsLessThan) then
        return Utility.IsMainPlayerMatchCondition_OpenDaysOfServiceIsLessThan(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.RecastTotalLevel) then
        return Utility.IsMainPlayerMatchCondition_RecastTotalLevelThan(conditionTbl)
    elseif (conditionTbl:GetConditionType() == LuaConditionType.CheckShare) then
        return Utility.IsMainPlayerMatchCondition_CheckShare(conditionTbl)
    end
    return nil
end

---@param conditionsTbl TABLE.cfg_conditions
function Utility.IsMainPlayerMatchCondition_RoleLevel(conditionsTbl)
    local level = conditionsTbl:GetConditionParam().list[0]
    ---@type LuaMatchConditionResult
    local result = {}

    if (CS.CSScene.MainPlayerInfo.Level < level) then
        result.success = false;
        result.txt = conditionsTbl:GetShow()
        result.param = level
        result.type = 1
    else
        result.success = true
    end
    return result
end

---@param conditionsTbl TABLE.cfg_conditions
function Utility.IsMainPlayerMatchCondition_RoleLevelLessThan(conditionsTbl)
    local level = conditionsTbl:GetConditionParam().list[0]
    ---@type LuaMatchConditionResult
    local result = {}

    if (CS.CSScene.MainPlayerInfo.Level >= level) then
        result.success = false;
        result.txt = string.CSFormat(conditionsTbl:GetShow(), level)
        result.param = level
        result.type = 2
    else
        result.success = true
    end
    return result
end

---@param conditionsTbl TABLE.cfg_conditions
function Utility.IsMainPlayerMatchCondition_RoleReinLevel(conditionsTbl)
    local level = conditionsTbl:GetConditionParam().list[0]
    ---@type LuaMatchConditionResult
    local result = {}

    if (CS.CSScene.MainPlayerInfo.ReinLevel < level) then
        result.success = false;
    else
        result.success = true
    end
    result.txt = string.CSFormat(conditionsTbl:GetShow(), level)
    result.param = level
    result.type = 2
    return result
end

---玩家转生低于条件
function Utility.IsMainPlayerMatchCondition_RoleReinLevelLessThan(conditionsTbl)
    local level = conditionsTbl:GetConditionParam().list[0]
    ---@type LuaMatchConditionResult
    local result = {}

    if (CS.CSScene.MainPlayerInfo.ReinLevel >= level) then
        result.success = false;
    else
        result.success = true
    end
    result.type = 2
    result.txt = string.CSFormat(conditionsTbl:GetShow(), level)
    result.param = level
    return result
end

---@param conditionsTbl TABLE.cfg_conditions
function Utility.IsMainPlayerMatchCondition_RoleBuffList(conditionsTbl)
    local buffIdList = Utility.ListChangeTable(conditionsTbl:GetConditionParam().list)
    ---@type LuaMatchConditionResult
    local result = {}
    result.success = false;
    result.txt = string.CSFormat(conditionsTbl:GetShow())
    result.param = buffIdList
    result.type = LuaConditionType.RoleBuffList

    for k, v in pairs(buffIdList) do
        if type(v) == 'number' and CS.CSScene.MainPlayerInfo.BuffInfo:IsHasBuff(v) == true then
            result.success = true
            break
        end
    end
    return result
end

---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_MonthCard(conditionsTbl)
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo == nil then
        return nil
    end
    ---@type LuaMatchConditionResult
    local result = {}
    result.success = false
    result.txt = string.CSFormat(conditionsTbl:GetShow())
    ---@type vipV2.CardInfo
    local cardData = mainPlayerInfo.MonthCardInfo:GetJoinMonthCardInfo(LuaEnumCardType.Coceral)
    if conditionsTbl:GetConditionParam() then
        local conditionList = conditionsTbl:GetConditionParam().list
        result.mMothCardList = conditionList
    end
    if cardData and cardData.cardType ~= 0 and conditionsTbl:GetConditionParam() then
        local conditionList = conditionsTbl:GetConditionParam().list
        for i = 0, conditionList.Count - 1 do
            local conditionCard = conditionList[i]
            if conditionCard == cardData.cardType then
                result.success = true
                return result
            end
        end
    else
        result.success = false
    end
    return result
end

---条件列表（且）
---@param idList table<number>
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchConditionList_AND(idList)
    ---@type LuaMatchConditionResult
    local result = {}
    if type(idList) ~= 'table' or Utility.GetLuaTableCount(idList) <= 0 then
        result.success = false
        result.txt = "传入数据结构出错"
        result.param = nil
        result.type = nil
        return result
    end
    local conditionResult
    for k, v in pairs(idList) do
        conditionResult = Utility.IsMainPlayerMatchCondition_LuaAndCS(v)
        if conditionResult == nil then
            ---@type TABLE.cfg_conditions
            local conditionTbl = clientTableManager.cfg_conditionsManager:TryGetValue(v)
            result.success = false
            result.txt = conditionTbl:GetTxt()
            result.type = conditionTbl:GetConditionType()
            result.param = conditionTbl:GetConditionParam()
            result.id = v
            return result
        end
        if conditionResult.success == false then
            return conditionResult
        end
    end
    return conditionResult
end

---条件列表（或）
---@param idList table<number>
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchConditionList_OR(idList)
    ---@type LuaMatchConditionResult
    local result = {}
    if type(idList) ~= 'table' or Utility.GetLuaTableCount(idList) <= 0 then
        result.success = false
        result.txt = "传入数据结构出错"
        result.param = nil
        result.type = nil
        return result
    end
    local conditionResult
    for k, v in pairs(idList) do
        conditionResult = Utility.IsMainPlayerMatchCondition_LuaAndCS(v)
        if conditionResult == nil then
            ---@type TABLE.cfg_conditions
            local conditionTbl = clientTableManager.cfg_conditionsManager:TryGetValue(v)
            result.success = false
            result.txt = conditionTbl:GetTxt()
            result.type = conditionTbl:GetConditionType()
            result.param = conditionTbl:GetConditionParam()
            result.id = v
            return result
        end
        if conditionResult.success == true then
            return conditionResult
        end
    end
    return conditionResult
end

--region 灵兽转生等级判定

---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_ServantReinLevel(conditionsTbl)
    if (conditionsTbl == nil or conditionsTbl:GetConditionParam() == nil) then
        return nil;
    end
    ---@type LuaMatchConditionResult
    local result = {}
    result.type = LuaConditionType.ServantReinLevel
    result.txt = conditionsTbl:GetShow()
    local params = conditionsTbl:GetConditionParam().list
    local servantType = params[0]
    local servantReinLevel = params[2]
    ---@type servantV2.ServantInfo
    local servantInfo = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantInfoByType(servantType);
    if (servantInfo == nil) then
        result.success = false
    else
        result.success = servantInfo.rein >= servantReinLevel;
    end
    return result;
end
--endregion

---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_OfficialSeal(conditionsTbl)
    local playerSeal = gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo():GetOfficialInfo().officialPosistionId
    if conditionsTbl:GetConditionParam() == nil or conditionsTbl:GetConditionParam().list == nil or conditionsTbl:GetConditionParam().list.Count <= 0 then
        return
    end
    local conditionParam = conditionsTbl:GetConditionParam().list[0]
    ---@type LuaMatchConditionResult
    local result = {}
    result.success = playerSeal >= conditionParam
    result.txt = conditionsTbl:GetShow()
    result.param = conditionParam
    return result
end

---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_QiShuSkill(conditionsTbl)
    local skillLevel = 0
    local SkillInfoDic = gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr().SkillInfoDic
    local conditionParam = conditionsTbl:GetConditionParam().list[0]
    if SkillInfoDic ~= nil and SkillInfoDic[800001] ~= nil then
        skillLevel = SkillInfoDic[800001].level
    end
    ---@type LuaMatchConditionResult
    local result = {}
    result.success = skillLevel >= conditionParam
    result.txt = conditionsTbl:GetShow()
    result.param = conditionParam
    return result
end

---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_RechargedDiamondsGreaterLessThan(conditionsTbl)
    local totalRechargeCount = 0
    local conditionParam = conditionsTbl:GetConditionParam().list[0]
    local MainPlayerInfo = CS.CSScene.MainPlayerInfo
    if (MainPlayerInfo.RechargeInfo ~= nil and MainPlayerInfo.RechargeInfo.ResRechargeInfo ~= nil) then
        totalRechargeCount = CS.CSScene.MainPlayerInfo.RechargeInfo.ResRechargeInfo.totalRechargeCount
    end
    ---@type LuaMatchConditionResult
    local result = {}
    result.success = totalRechargeCount < conditionParam
    result.txt = conditionsTbl:GetShow()
    result.param = conditionParam
    return result
end

---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_RechargedDiamondsGreaterThanOrEqual(conditionsTbl)
    local totalRechargeCount = 0
    local conditionParam = conditionsTbl:GetConditionParam().list[0]
    local MainPlayerInfo = CS.CSScene.MainPlayerInfo
    if (MainPlayerInfo.RechargeInfo ~= nil and MainPlayerInfo.RechargeInfo.ResRechargeInfo ~= nil) then
        totalRechargeCount = CS.CSScene.MainPlayerInfo.RechargeInfo.ResRechargeInfo.totalRechargeCount
    end
    ---@type LuaMatchConditionResult
    local result = {}
    result.success = totalRechargeCount >= conditionParam
    result.txt = conditionsTbl:GetShow()
    result.param = conditionParam
    return result
end

---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_MemberLevel(conditionsTbl)
    ---@type number 玩家会员等级
    local mainPlayerMemberLevel = gameMgr:GetPlayerDataMgr():GetLuaMemberInfo():GetPlayerMemberLevel()
    local conditionParam = tonumber(conditionsTbl:GetConditionParam().list[0])
    ---@type LuaMatchConditionResult
    local result = {}
    result.success = mainPlayerMemberLevel >= conditionParam
    result.txt = conditionsTbl:GetTxt()
    result.param = conditionParam
    return result
end

---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_MemberLevelInterval(conditionsTbl)
    ---@type number 玩家会员等级
    local mainPlayerMemberLevel = gameMgr:GetPlayerDataMgr():GetLuaMemberInfo():GetPlayerMemberLevel()
    local minconditionParam = tonumber(conditionsTbl:GetConditionParam().list[0])
    local maxconditionParam = tonumber(conditionsTbl:GetConditionParam().list[1])
    ---@type LuaMatchConditionResult
    local result = {}
    result.success = (mainPlayerMemberLevel >= minconditionParam and mainPlayerMemberLevel <= maxconditionParam)
    result.txt = conditionsTbl:GetShow()
    result.param = conditionsTbl:GetConditionParam().list
    return result
end

---灵魂刻印类型判断
---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_SoulImprint(conditionsTbl)
    local curLevel = 10000000
    ---获取勋章装备位上的物品
    ---@type bagV2.BagItemInfo
    local medalBagItemInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipInfoByEquipIndex(LuaEquipmentItemType.POS_MEDAL)
    if medalBagItemInfo and medalBagItemInfo.ItemTABLE then
        local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(medalBagItemInfo.ItemTABLE.id)
        if itemTbl and itemTbl:GetItemLevel() then
            curLevel = itemTbl:GetItemLevel()
        end
    end
    local minLevel = tonumber(conditionsTbl:GetConditionParam().list[0])
    local maxLevel = tonumber(conditionsTbl:GetConditionParam().list[1])
    ---@type LuaMatchConditionResult
    local result = {}
    result.success = curLevel >= minLevel and curLevel <= maxLevel
    result.txt = conditionsTbl:GetTxt()
    result.param = conditionsTbl:GetConditionParam().list
    return result
end

---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_MagicEquipSuitLv(conditionsTbl)
    local configMagicSuitType = tonumber(conditionsTbl:GetConditionParam().list[0])
    local configMagicSuitLv = tonumber(conditionsTbl:GetConditionParam().list[1])
    local MagicEquipmentList = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetMagicEquipListBySuitType(configMagicSuitType)
    ---@type LuaMatchConditionResult
    local result = {}
    result.success = MagicEquipmentList ~= nil and MagicEquipmentList:GetBodyLowLevel() > 0 and MagicEquipmentList:GetBodyLowLevel() >= configMagicSuitLv
    result.txt = conditionsTbl:GetTxt()
    result.param = conditionsTbl:GetConditionParam().list
    return result
end

---攻击力类型判断
---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_FightPower(conditionsTbl)
    local curFightPower = CS.CSScene.MainPlayerInfo.FightPower
    local conditionParam = tonumber(conditionsTbl:GetConditionParam().list[0])
    ---@type LuaMatchConditionResult
    local result = {}
    result.success = curFightPower >= conditionParam
    result.txt = conditionsTbl:GetTxt()
    result.param = conditionParam
    return result
end

---封号等级类型判断
---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_MilitaryRankTitle(conditionsTbl)
    local curSealMarkLevel = CS.CSScene.MainPlayerInfo.SealMarkId
    local conditionParam = tonumber(conditionsTbl:GetConditionParam().list[0])
    ---@type LuaMatchConditionResult
    local result = {}
    result.success = curSealMarkLevel >= conditionParam
    result.txt = conditionsTbl:GetTxt()
    result.param = conditionParam
    return result
end

---@class ReplaceMatData
---@field num number 道具消耗数目
---@field allMat table<number,number> 所有材料itemID
---@field fullConditionItemId number 玩家满足条件的道具id,就是在所有材料里面，玩家满足条件的那个道具，如果没有，就是第一个
---@field playerHasTotal number 玩家背包中道具总数目

---可替换材料是否足够
---@param conditionsTbl TABLE.cfg_conditions
function Utility.IsMainPlayerMatchCondition_ReplaceMaterial(conditionsTbl)
    local conditionParam = conditionsTbl:GetConditionParam().list
    if conditionParam == nil then
        return
    end
    ---@type LuaMatchConditionResult
    local result = {}
    ---@type ReplaceMatData
    local matData = {}
    local allMat = {}
    local needCost = 0
    local fullConditionItemId
    local playerHasTotal = 0

    if conditionParam.Count >= 1 then
        needCost = tonumber(conditionParam[0])
    end

    for i = 1, conditionParam.Count - 1 do
        local mat = tonumber(conditionParam[i])
        table.insert(allMat, mat)

        local playerHas = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemAndCurCoinMoneyCount(mat)

        if playerHas >= needCost then
            fullConditionItemId = mat
        end

        local playerHas = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemAndCurCoinMoneyCount(mat)

        playerHasTotal = playerHasTotal + playerHas
    end
    if fullConditionItemId == nil then
        fullConditionItemId = allMat[1]
    end

    matData.allMat = allMat
    matData.num = needCost
    matData.fullConditionItemId = fullConditionItemId
    matData.playerHasTotal = playerHasTotal

    result.success = playerHasTotal >= needCost
    result.txt = conditionsTbl:GetTxt()
    result.param = conditionParam
    result.mReplaceMatData = matData
    return result
end


--懒鱼 14:44:50
--condition那边服务器让我把1000001这个ID去掉 只留了3000的数值
--
--懒鱼 14:45:08
--1000001\1010001\1030001
--
--懒鱼 14:45:34
--就这3个钻石ID直接代码里判定就行了
--
--懒鱼 14:45:44
--数值还是走那个conditionID
--
--你很怠惰啊 14:45:47
--那你下次又要加钻石怎么弄
--
--懒鱼 14:46:42
--我就喷回去
---充值钻石，只判断1000001
function Utility.IsMainPlayerMatchCondition_RechargeDiamond(conditionsTbl)
    local conditionParam = conditionsTbl:GetConditionParam().list
    if conditionParam == nil then
        return
    end
    local needCost = conditionParam[0]
    --local diamondId = conditionParam[1]
    local playerHas = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCurCoinAmount(1000001)
            + gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCurCoinAmount(1010001)
            + gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCurCoinAmount(1030001)
            + gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCurCoinAmount(1020001)
    ---@type LuaMatchConditionResult
    local result = {}
    result.success = playerHas >= needCost
    result.txt = conditionsTbl:GetTxt()
    result.param = conditionParam
    return result
end

---挖宝次数
function Utility.IsMainPlayerMatchCondition_WaBaoCiShu(conditionsTbl)
    local conditionParam = conditionsTbl:GetConditionParam().list
    if conditionParam == nil then
        return
    end
    local needCost = conditionParam[0]
    local playerHas = gameMgr:GetPlayerDataMgr():GetDigTreasureManager():GetDigCount()
    local result = {}
    result.success = playerHas >= needCost
    result.txt = conditionsTbl:GetTxt()
    result.param = conditionParam
    return result
end

---判断玩家神器等套装数量是否满足
---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_MagicEquipSuitNum(conditionsTbl)
    local MagicSuitNum = tonumber(conditionsTbl:GetConditionParam().list[0])
    local MagicSuitSubType = tonumber(conditionsTbl:GetConditionParam().list[1])
    local MagicSuitType = tonumber(conditionsTbl:GetConditionParam().list[2])
    local suitData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetMagicEquipListBySuitType(MagicSuitType)
    ---@type LuaMatchConditionResult
    local result = {}
    result.success = suitData ~= nil and suitData:GetEquipCount() >= MagicSuitNum
    result.txt = conditionsTbl:GetTxt()
    result.param = conditionsTbl:GetConditionParam().list
    return result
end

---判断玩家灵兽位和背包是否有灵兽
---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_ServantIndexAndBagHaveServant(conditionsTbl)
    local configHaveServant = tonumber(conditionsTbl:GetConditionParam().list[0]) == 1
    local bagHaveSeravnt = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemByType(luaEnumItemType.Assist, 8) ~= nil
    local bodyHaveServant = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():BodyHaveServant()
    local haveServant = bagHaveSeravnt == true or bodyHaveServant == true
    ---@type LuaMatchConditionResult
    local result = {}
    result.success = (haveServant == true and configHaveServant == true) or (haveServant == false and configHaveServant == false)
    result.txt = conditionsTbl:GetTxt()
    result.param = conditionsTbl:GetConditionParam().list
    return result
end

---判断玩家阵法是否达到等级限制
---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_ZhenFaLevel(conditionsTbl)
    local zhenFaMinLv = tonumber(conditionsTbl:GetConditionParam().list[0])
    local zhenFaMaxLv = tonumber(conditionsTbl:GetConditionParam().list[1])
    local curZhenFaLv = gameMgr:GetPlayerDataMgr():GetZhenFaManager():GetZhenFaInfo():GetZhenFaLevel()
    ---@type LuaMatchConditionResult
    local result = {}
    result.success = curZhenFaLv >= zhenFaMinLv and curZhenFaLv <= zhenFaMaxLv
    result.txt = conditionsTbl:GetTxt()
    result.param = conditionsTbl:GetConditionParam().list
    return result
end

---判断玩家是否击杀足够数量的怪物
---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_Monsterkill(conditionsTbl)
    local monsterNeed = tonumber(conditionsTbl:GetConditionParam().list[0])
    local monsterKill = gameMgr:GetPlayerDataMgr():GetReinDataManager():GetMonsterKill()
    local num = 0
    if monsterKill ~= nil then
        for k, v in pairs(monsterKill) do
            if v.conditionId == conditionsTbl:GetId() then
                num = v.killMonsterCount
            end
        end
    end
    ---@type LuaMatchConditionResult
    local result = {}
    result.success = tonumber(num) >= monsterNeed
    result.txt = conditionsTbl:GetTxt()
    result.param = conditionsTbl:GetConditionParam().list
    result.monsterKill = tonumber(num)
    return result
end

---判断合服天数是否大于
---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_ServiceIsGreaterThan(conditionsTbl)
    --合服第几天
    local heFuDay = gameMgr:GetLuaTimeMgr():GetCombineServerDay(gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime())

    local day = conditionsTbl:GetConditionParam().list[0]
    ---@type LuaMatchConditionResult
    local result = {}

    if (heFuDay >= day) then
        result.success = true
    else
        result.success = false;
        result.txt = conditionsTbl:GetTxt()
        result.param = day
        result.type = 93
    end
    return result
end

---判断合服天数是否小于
---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_ServiceIsLessThan(conditionsTbl)
    --合服第几天
    local heFuDay = gameMgr:GetLuaTimeMgr():GetCombineServerDay(gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime())

    local day = conditionsTbl:GetConditionParam().list[0]
    ---@type LuaMatchConditionResult
    local result = {}

    if (heFuDay < day) then
        result.success = true
    else
        result.success = false;
        result.txt = conditionsTbl:GetTxt()
        result.param = day
        result.type = 94
    end
    return result
end

---判断开服天数是否不小于
---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_OpenDaysOfServiceIsNotLessThan(conditionsTbl)
    --开服第几天
    local kaiFuDay = gameMgr:GetLuaTimeMgr():GetOpenServerDay()

    local day = conditionsTbl:GetConditionParam().list[0]
    ---@type LuaMatchConditionResult
    local result = {}

    if (kaiFuDay >= day) then
        result.success = true
    else
        result.success = false;
        result.txt = conditionsTbl:GetTxt()
        result.param = day
        result.type = 8
    end
    return result
end

---判断开服天数是否小于
---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_OpenDaysOfServiceIsLessThan(conditionsTbl)
    --开服第几天
    local kaiFuDay = gameMgr:GetLuaTimeMgr():GetOpenServerDay()

    local day = conditionsTbl:GetConditionParam().list[0]
    ---@type LuaMatchConditionResult
    local result = {}

    if (kaiFuDay < day) then
        result.success = true
    else
        result.success = false;
        result.txt = conditionsTbl:GetTxt()
        result.param = day
        result.type = 9
    end
    return result
end

---判断重铸总等级是否大于
---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_RecastTotalLevelThan(conditionsTbl)
    ---@type number 重铸总等级
    local recastTotalLevel = gameMgr:GetPlayerDataMgr():GetRecastMgr():GetRecastTotalLevel()

    local configLevel = tonumber(conditionsTbl:GetConditionParam().list[0])
    ---@type LuaMatchConditionResult
    local result = {}
    result.success = recastTotalLevel >= configLevel
    result.txt = conditionsTbl:GetTxt()
    result.param = configLevel
    return result
end

---判断是否联服
---@param conditionsTbl TABLE.cfg_conditions
---@return LuaMatchConditionResult
function Utility.IsMainPlayerMatchCondition_CheckShare(conditionsTbl)

    local isOpenShareMap = gameMgr:GetPlayerDataMgr():GetShareMapInfo():IsOpenShareMap()

    local param = tonumber(conditionsTbl:GetConditionParam().list[0])
    ---@type LuaMatchConditionResult
    local result = {}
    result.success = (isOpenShareMap and param == 1) or (not isOpenShareMap and param == 0)
    result.txt = conditionsTbl:GetTxt()
    result.param = param
    return result
end