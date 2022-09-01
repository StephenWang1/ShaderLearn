local BetterItemHint_Data = {}
--region 获取
---获取提示状态类型
---@param hintType LuaEnumMainHint_BetterBagItemType 提示类型
---@return LuaEnumBetterItemHintStateType 提示推送状态类型
function BetterItemHint_Data:GetHintStateType(hintType)
    if self.hintTypePushLimitParamsTable == nil or type(self.hintTypePushLimitParamsTable) ~= 'table' then
        self:InitHintParams()
    end
    local specialHintStateType = self:SpecialHintStateType(hintType)
    if specialHintStateType == false then
        local hintTypeLimitParams = self.hintTypePushLimitParamsTable[hintType]
        if hintTypeLimitParams ~= nil and type(hintTypeLimitParams) == 'table' then
            local noPushConditionIdTable = hintTypeLimitParams.noPushConditionIdTable
            if noPushConditionIdTable ~= nil and type(noPushConditionIdTable) == 'table' and CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(noPushConditionIdTable) == true then
                return LuaEnumBetterItemHintStateType.NONE
            end
            local mainPlayerInfo = CS.CSScene.MainPlayerInfo
            local pushIconHintLimitTable = hintTypeLimitParams.pushIconHintLimitTable
            if pushIconHintLimitTable ~= nil and type(pushIconHintLimitTable) == 'table' and CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(pushIconHintLimitTable) == true then
                return LuaEnumBetterItemHintStateType.IconHint
            end
            local pushTextHintLimitTable = hintTypeLimitParams.pushTextHintLimitTable
            if pushTextHintLimitTable ~= nil and type(pushTextHintLimitTable) == 'table' and CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(pushTextHintLimitTable) == true then
                return LuaEnumBetterItemHintStateType.TextHint
            end
        end
    else
        return specialHintStateType
    end
    return LuaEnumBetterItemHintStateType.NONE
end

---特殊提示状态类型设置
function BetterItemHint_Data:SpecialHintStateType(hintType)
    if hintType == LuaEnumMainHint_BetterBagItemType.UnionSummonToken then
        local state = CS.StaticUtility.IsNullOrEmpty(CS.CSScene.MainPlayerInfo.UIUnionName) == false and CS.CSScene.MainPlayerInfo.UnionInfoV2:MainPlayerPosCanUseSummonToken() == true and CS.CSScene.MainPlayerInfo.UnionInfoV2:SummonTokenCDTimeIsOver() == true
        return ternary(state == true, LuaEnumBetterItemHintStateType.IconHint, LuaEnumBetterItemHintStateType.TextHint)
    end
    return false
end

---初始化提示参数
function BetterItemHint_Data:InitHintParams()
    if self.hintTypePushLimitParamsTable ~= nil and type(self.hintTypePushLimitParamsTable) == 'table' then
        return self.hintTypePushLimitParamsTable
    end
    local globalInfoIsFind, globalInfo = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22549)
    if globalInfoIsFind == true then
        self.hintTypePushLimitParamsTable = {}
        local AllHintTypeLimitTable = string.Split(globalInfo.value, '&')
        if AllHintTypeLimitTable ~= nil then
            for k, v in pairs(AllHintTypeLimitTable) do
                local hintTypeLimitTable = string.Split(v, '_')
                if hintTypeLimitTable ~= nil and type(hintTypeLimitTable) == 'table' and #hintTypeLimitTable > 2 then
                    local BetterHintLimitParams = {}
                    BetterHintLimitParams.hintType = tonumber(hintTypeLimitTable[1])
                    BetterHintLimitParams.pushIconHintLimitTable = Utility.ChangeNumberTable(string.Split(hintTypeLimitTable[2], '#'))
                    BetterHintLimitParams.pushTextHintLimitTable = Utility.ChangeNumberTable(string.Split(hintTypeLimitTable[3], '#'))
                    if #hintTypeLimitTable > 3 then
                        BetterHintLimitParams.noPushConditionIdTable = Utility.ChangeNumberTable(string.Split(hintTypeLimitTable[4], '#'))
                    end
                    self.hintTypePushLimitParamsTable[BetterHintLimitParams.hintType] = BetterHintLimitParams
                end
            end
        end
    end
end

---获取C#提示类型枚举
---@param 提示类型 LuaEnumMainHint_BetterBagItemType
function BetterItemHint_Data:GetCSHintType(hintType)
    if hintType == LuaEnumMainHint_BetterBagItemType.None then
        return CS.CSBagItemHint.BagHintType.None
    elseif hintType == LuaEnumMainHint_BetterBagItemType.Undefined then
        return CS.CSBagItemHint.BagHintType.Undefined
    elseif hintType == LuaEnumMainHint_BetterBagItemType.TowerCardHint then
        return CS.CSBagItemHint.BagHintType.TowerCardHint
    elseif hintType == LuaEnumMainHint_BetterBagItemType.BetterBlendEquip then
        return CS.CSBagItemHint.BagHintType.BetterBlendEquip
    elseif hintType == LuaEnumMainHint_BetterBagItemType.BetterEquip then
        return CS.CSBagItemHint.BagHintType.BetterEquip
    elseif hintType == LuaEnumMainHint_BetterBagItemType.BetterElement then
        return CS.CSBagItemHint.BagHintType.BetterElement
    elseif hintType == LuaEnumMainHint_BetterBagItemType.BetterSignet then
        return CS.CSBagItemHint.BagHintType.BetterSignet
    elseif hintType == LuaEnumMainHint_BetterBagItemType.AvailableSkill then
        return CS.CSBagItemHint.BagHintType.AvailableSkill
    elseif hintType == LuaEnumMainHint_BetterBagItemType.ServantRecommend_COMMON then
        return CS.CSBagItemHint.BagHintType.ServantRecommend_Common
    elseif hintType == LuaEnumMainHint_BetterBagItemType.ServantRecommend_HM then
        return CS.CSBagItemHint.BagHintType.ServantRecommend_HM
    elseif hintType == LuaEnumMainHint_BetterBagItemType.ServantRecommend_LX then
        return CS.CSBagItemHint.BagHintType.ServantRecommend_LX
    elseif hintType == LuaEnumMainHint_BetterBagItemType.ServantRecommend_TC then
        return CS.CSBagItemHint.BagHintType.ServantRecommend_TC
    elseif hintType == LuaEnumMainHint_BetterBagItemType.UsefulServantFragment then
        return CS.CSBagItemHint.BagHintType.UsefulServantFragment
    elseif hintType == LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_COMMON then
        return CS.CSBagItemHint.BagHintType.ServantBodyRecommend_Common
    elseif hintType == LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_HM then
        return CS.CSBagItemHint.BagHintType.ServantBodyRecommend_HM
    elseif hintType == LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_LX then
        return CS.CSBagItemHint.BagHintType.ServantBodyRecommend_LX
    elseif hintType == LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_TC then
        return CS.CSBagItemHint.BagHintType.ServantBodyRecommend_TC
    elseif hintType == LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_HM then
        return CS.CSBagItemHint.BagHintType.ServantEquipRecommend_HM
    elseif hintType == LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_LX then
        return CS.CSBagItemHint.BagHintType.ServantEquipRecommend_LX
    elseif hintType == LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_TC then
        return CS.CSBagItemHint.BagHintType.ServantEquipRecommend_TC
    elseif hintType == LuaEnumMainHint_BetterBagItemType.TreasureBox then
        return CS.CSBagItemHint.BagHintType.TreasureBox
    elseif hintType == LuaEnumMainHint_BetterBagItemType.ServantExpBox then
        return CS.CSBagItemHint.BagHintType.ServantExpBox
    elseif hintType == LuaEnumMainHint_BetterBagItemType.UnionSummonToken then
        return CS.CSBagItemHint.BagHintType.UnionSummonToken
    elseif hintType == LuaEnumMainHint_BetterBagItemType.DeployProp then
        return CS.CSBagItemHint.BagHintType.DeployProp
    elseif hintType == LuaEnumMainHint_BetterBagItemType.EquipRefine then
        return CS.CSBagItemHint.BagHintType.EquipRefine
    elseif hintType == LuaEnumMainHint_BetterBagItemType.EquipBox then
        return CS.CSBagItemHint.BagHintType.EquipBox
    elseif hintType == LuaEnumMainHint_BetterBagItemType.EquipSynthesis then
        return CS.CSBagItemHint.BagHintType.EquipSynthesis
    elseif hintType == LuaEnumMainHint_BetterBagItemType.ServantEquipSynthesis then
        return CS.CSBagItemHint.BagHintType.ServantEquipSynthesis
    elseif hintType == LuaEnumMainHint_BetterBagItemType.ServantEquipRefine then
        return CS.CSBagItemHint.BagHintType.ServantEquipRefine
    elseif hintType == LuaEnumMainHint_BetterBagItemType.EquipMelting then
        return CS.CSBagItemHint.BagHintType.EquipMelting
    elseif hintType == LuaEnumMainHint_BetterBagItemType.BetterBloodEquip then
        return LuaEnumMainHint_BetterBagItemType.BetterBloodEquip
    elseif hintType == LuaEnumMainHint_BetterBagItemType.SingleItemHint then
        return LuaEnumMainHint_BetterBagItemType.SingleItemHint
    elseif hintType == LuaEnumMainHint_BetterBagItemType.SoulEquip then
        return LuaEnumMainHint_BetterBagItemType.SoulEquip
    elseif hintType == LuaEnumMainHint_BetterBagItemType.RoleMagicEquip then
        return LuaEnumMainHint_BetterBagItemType.RoleMagicEquip
    elseif hintType == LuaEnumMainHint_BetterBagItemType.Appearance then
        return LuaEnumMainHint_BetterBagItemType.Appearance
    end
    return nil
end
--endregion
return BetterItemHint_Data