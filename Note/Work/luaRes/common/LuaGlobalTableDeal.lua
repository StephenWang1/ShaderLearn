local LuaGlobalTableDeal = {}

---@return TABLE.CFG_GLOBAL
function LuaGlobalTableDeal.GetGlobalTabl(id)
    if id == nil then
        return nil
    end
    local isfind, data = CS.Cfg_GlobalTableManager.Instance:TryGetValue(id)
    return data
end

--region召唤令快捷设置信息
---召唤令限制等级
function LuaGlobalTableDeal.ZhaoHuanLingLimitLevel()
    if LuaGlobalTableDeal.mZhaoHuanLingLimitLevel == nil then
        LuaGlobalTableDeal.SetZhaoHuanLing()
    end
    return LuaGlobalTableDeal.mZhaoHuanLingLimitLevel
end
---召唤令ID
function LuaGlobalTableDeal.ZhaoHuanLingItemID()
    if LuaGlobalTableDeal.mZhaoHuanLingItemID == nil then
        LuaGlobalTableDeal.SetZhaoHuanLing()
    end
    return LuaGlobalTableDeal.mZhaoHuanLingItemID
end

---召唤令提示气泡限制次数
function LuaGlobalTableDeal.ZhaoHuanLingTipLimitNumber()
    if LuaGlobalTableDeal.mZhaoHuanLingTipLimitNumber == nil then
        LuaGlobalTableDeal.SetZhaoHuanLing()
    end
    return LuaGlobalTableDeal.mZhaoHuanLingTipLimitNumber
end

---设置召唤令快捷设置信息
function LuaGlobalTableDeal.SetZhaoHuanLing()
    local data = LuaGlobalTableDeal.GetGlobalTabl(22464)
    if data == nil then
        return
    end
    local strList = _fSplit(data.value, "#")
    if strList ~= nil and #strList == 3 then
        LuaGlobalTableDeal.mZhaoHuanLingLimitLevel = tonumber(strList[1])
        LuaGlobalTableDeal.mZhaoHuanLingItemID = tonumber(strList[2])
        LuaGlobalTableDeal.mZhaoHuanLingTipLimitNumber = tonumber(strList[3])
    end
end

function LuaGlobalTableDeal.ZhaoHuanLingShowNameBossTypeTable()
    if LuaGlobalTableDeal.mZhaoHuanLingShowNameBossTypeTable == nil then
        LuaGlobalTableDeal.SetZhaoHuanLingShowNameBossType()
    end
    return LuaGlobalTableDeal.mZhaoHuanLingShowNameBossTypeTable
end

function LuaGlobalTableDeal.SetZhaoHuanLingShowNameBossType()
    LuaGlobalTableDeal.mZhaoHuanLingShowNameBossTypeTable = {}

    local data = LuaGlobalTableDeal.GetGlobalTabl(22491)
    if data == nil then
        return
    end
    local strList = _fSplit(data.value, "#")
    if strList ~= nil then
        for i = 1, Utility.GetLuaTableCount(strList) do
            table.insert(LuaGlobalTableDeal.mZhaoHuanLingShowNameBossTypeTable, tonumber(strList[i]))
        end
    end
end

function LuaGlobalTableDeal.ZhaoHuanLingSecondConfirmLevel()
    if LuaGlobalTableDeal.mZhaoHuanLingSecondConfirmLevel == nil then
        LuaGlobalTableDeal.SetZhaoHuanLingSecondConfirmLevel()
    end
    return LuaGlobalTableDeal.mZhaoHuanLingSecondConfirmLevel
end

function LuaGlobalTableDeal.SetZhaoHuanLingSecondConfirmLevel()
    local data = LuaGlobalTableDeal.GetGlobalTabl(22492)
    if data == nil then
        return
    end
    LuaGlobalTableDeal.mZhaoHuanLingSecondConfirmLevel = tonumber(data.value)
end

function LuaGlobalTableDeal.ZhaoHuanLingDontNeedSecondConfirmMapTable()
    if LuaGlobalTableDeal.mZhaoHuanLingDontNeedSecondConfirmMapTable == nil then
        LuaGlobalTableDeal.SetZhaoHuanLingDontNeedSecondConfirmMap()
    end
    return LuaGlobalTableDeal.mZhaoHuanLingDontNeedSecondConfirmMapTable
end

function LuaGlobalTableDeal.SetZhaoHuanLingDontNeedSecondConfirmMap()
    LuaGlobalTableDeal.mZhaoHuanLingDontNeedSecondConfirmMapTable = {}

    local data = LuaGlobalTableDeal.GetGlobalTabl(22493)
    if data == nil then
        return
    end
    local strList = _fSplit(data.value, "#")
    if strList ~= nil then
        for i = 1, Utility.GetLuaTableCount(strList) do
            table.insert(LuaGlobalTableDeal.mZhaoHuanLingDontNeedSecondConfirmMapTable, tonumber(strList[i]))
        end
    end
end

--endregion

--region 交易行
---@return table<number,number> 元宝交易限制条件，condition集合
function LuaGlobalTableDeal.GetAuctionBuyYuanBaoItemLimit()
    if LuaGlobalTableDeal.mAuctionBuyYuanBaoItemLimit == nil then
        LuaGlobalTableDeal.mAuctionBuyYuanBaoItemLimit = {}
        local info = LuaGlobalTableDeal.GetGlobalTabl(22470)
        if info then
            local strs = string.Split(info.value, '#')
            for i = 1, #strs do
                table.insert(LuaGlobalTableDeal.mAuctionBuyYuanBaoItemLimit, tonumber(strs[i]))
            end
        end
    end
    return LuaGlobalTableDeal.mAuctionBuyYuanBaoItemLimit
end

---@param type number 等级1/转生等级2
function LuaGlobalTableDeal.GetAuctionBuyYuanBaoItemLevelLimit(type)
    if LuaGlobalTableDeal.mAuctionBuyYuanBaoItemLevelLimit == nil then
        LuaGlobalTableDeal.mAuctionBuyYuanBaoItemLevelLimit = {}
        local info = LuaGlobalTableDeal.GetGlobalTabl(22471)
        if info then
            local strs = string.Split(info.value, '#')
            if #strs >= 2 then
                LuaGlobalTableDeal.mAuctionBuyYuanBaoItemLevelLimit[1] = tonumber(strs[1])
                LuaGlobalTableDeal.mAuctionBuyYuanBaoItemLevelLimit[2] = tonumber(strs[2])
            end
        end
    end
    if LuaGlobalTableDeal.mAuctionBuyYuanBaoItemLevelLimit then
        return LuaGlobalTableDeal.mAuctionBuyYuanBaoItemLevelLimit[type]
    end
end

--endregion

--region 怪物
---查找怪物名字颜色
---@param type number 怪物类型
---@return string 怪物颜色
function LuaGlobalTableDeal.GetMonsterNameColorByType(type)

    if LuaGlobalTableDeal.mMonsterNameColorTable == nil then
        LuaGlobalTableDeal.mMonsterNameColorTable = {}
        local info = LuaGlobalTableDeal.GetGlobalTabl(20336)
        if info then
            local strs = string.Split(info.value, '&')
            for i = 1, #strs do
                local color = string.Split(strs[i], '#')
                if (#color == 2) then
                    LuaGlobalTableDeal.mMonsterNameColorTable[color[1]] = color[2]
                end
            end
        end
    end
    if (Utility.IsContainsKey(LuaGlobalTableDeal.mMonsterNameColorTable, type)) then
        return "[" .. LuaGlobalTableDeal.mMonsterNameColorTable[type] .. "]"
    else
        return "[FFFFFF]"
    end
end
--endregion

--region 怪物悬赏
---@alias MonsterArrestStepReward {itemId:number,count:number}
---@return MonsterArrestStepReward
function LuaGlobalTableDeal.GetMonsterArrestStepReward(group)
    if LuaGlobalTableDeal.mMonsterArrestStepReward == nil then
        LuaGlobalTableDeal.mMonsterArrestStepReward = {}
        local info = LuaGlobalTableDeal.GetGlobalTabl(22449)
        if info then
            local strs = string.Split(info.value, '&')
            for i = 1, #strs do
                local rewardList = string.Split(strs[i], '#')
                if #rewardList >= 3 then
                    local group = tonumber(rewardList[1])
                    local reward = {}
                    reward.itemId = tonumber(rewardList[2])
                    reward.count = tonumber(rewardList[3])
                    LuaGlobalTableDeal.mMonsterArrestStepReward[group] = reward
                end
            end
        end
    end
    return LuaGlobalTableDeal.mMonsterArrestStepReward[group]
end

function LuaGlobalTableDeal.GetMonsterArrestStepRewardBubbleTipsId(group)
    if LuaGlobalTableDeal.mMonsterArrestStepRewardBubbleTipsId == nil then
        LuaGlobalTableDeal.mMonsterArrestStepRewardBubbleTipsId = {}
    end
    local info = LuaGlobalTableDeal.GetGlobalTabl(22475)
    if info then
        local strs = string.Split(info.value, '#')
        local group = #strs / 2
        for i = 0, group - 1 do
            if (2 * i + 2) <= #strs then
                local group = tonumber(strs[2 * i + 1])
                local bubbleId = tonumber(strs[2 * i + 2])
                LuaGlobalTableDeal.mMonsterArrestStepRewardBubbleTipsId[group] = bubbleId
            end
        end
    end
    return LuaGlobalTableDeal.mMonsterArrestStepRewardBubbleTipsId[group]
end

--endregion

--region 恶魔广场
---@return boolean  判断当前时间是否需要显示加号闪烁标记
function LuaGlobalTableDeal.IsTimeNeedFlickerAddSign(time)
    if LuaGlobalTableDeal.mDevilSquareAddFlickerShowTime == nil then
        local info = LuaGlobalTableDeal.GetGlobalTabl(22484)
        if info then
            LuaGlobalTableDeal.mDevilSquareAddFlickerShowTime = tonumber(info.value)
        end
    end
    if LuaGlobalTableDeal.mDevilSquareAddFlickerShowTime then
        return time < LuaGlobalTableDeal.mDevilSquareAddFlickerShowTime
    end
    return false
end

---恶魔广场的地图组信息
function LuaGlobalTableDeal.EMOGUANGCHANGMapGroup()
    if LuaGlobalTableDeal.mEMOGUANGCHANGMapGroup == nil then
        LuaGlobalTableDeal.mEMOGUANGCHANGMapGroup = {}
        local info = LuaGlobalTableDeal.GetGlobalTabl(22459)
        if info then
            local allEMGCMApInfo = string.Split(info.value, '&')
            for i = 0, #allEMGCMApInfo do
                local mapInfo = string.Split(allEMGCMApInfo[i], '#')
                if mapInfo ~= nil and #mapInfo > 0 then
                    table.insert(LuaGlobalTableDeal.mEMOGUANGCHANGMapGroup, mapInfo)
                end
            end
        end
    end
    return LuaGlobalTableDeal.mEMOGUANGCHANGMapGroup
end

---是否是恶魔广场地图
---@return boolean
function LuaGlobalTableDeal.IsEMGCMap(mapId)
    local list = LuaGlobalTableDeal.EMOGUANGCHANGMapGroup()
    for i = 1, #list do
        if #list[i] > 2 then
            if tonumber(list[i][3]) == mapId then
                return true
            end
        end
    end
    return false
end

---需要显示倒计时的副本
---@param duplicateType number 副本类型
---@return boolean
function LuaGlobalTableDeal.IsCountdownCopy(duplicateType)
    if LuaGlobalTableDeal.mCountdownCopyGroup == nil then
        LuaGlobalTableDeal.mCountdownCopyGroup = {}
        local info = LuaGlobalTableDeal.GetGlobalTabl(22453)
        if info then
            local allCountdownCopy = string.Split(info.value, '&')
            for i = 0, #allCountdownCopy do
                local mapInfo = string.Split(allCountdownCopy[i], '#')
                if mapInfo ~= nil and #mapInfo > 0 then
                    table.insert(LuaGlobalTableDeal.mCountdownCopyGroup, tonumber(mapInfo[1]))
                end
            end
        end
    end
    for i = 1, #LuaGlobalTableDeal.mCountdownCopyGroup do
        if (duplicateType == LuaGlobalTableDeal.mCountdownCopyGroup[i]) then
            return true
        end
    end
    return false
end

--endregion

--region 挑战boss
function LuaGlobalTableDeal.GetBossGoMapUnitColorTbl()
    if LuaGlobalTableDeal.mBossGoMapUnitColorTb == nil then
        local info = LuaGlobalTableDeal.GetGlobalTabl(22499)
        if info then
            LuaGlobalTableDeal.mBossGoMapUnitColorTb = string.Split(info.value, '#')
        end
    end
    return LuaGlobalTableDeal.mBossGoMapUnitColorTb
end
--endregion

--region 行会
--region 行会仇人
---查看行会仇人花费
function LuaGlobalTableDeal.GetUnionEnemyCostTbl()
    if LuaGlobalTableDeal.mUnionEnemyCost == nil then
        local info = LuaGlobalTableDeal.GetGlobalTabl(22507)
        if info then
            LuaGlobalTableDeal.mUnionEnemyCost = string.Split(info.value, '#')
        end
    end
    return LuaGlobalTableDeal.mUnionEnemyCost
end
--endregion

--region 行会地牢活动
---行会地牢最后一张地图ID
---@return string
function LuaGlobalTableDeal:GetUnionDungeonEndMapID()
    if self.mUnionEndMapID == nil then
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22625)
        if tableInfo then
            self.mUnionEndMapID = tableInfo.value
        end
    end
    return self.mUnionEndMapID
end

---行会地宫第一张地图ID
---@return number
function LuaGlobalTableDeal:GetUnionDungeonStartMapID()
    if self.mUnionDungeonStartMapID == nil then
        local tableInfo = self.GetGlobalTabl(22681)
        if tableInfo then
            self.mUnionDungeonStartMapID = tonumber(tableInfo.value)
        end
    end
    return self.mUnionDungeonStartMapID
end

---行会地宫活动开启时间列表
---@return table<number,UnionDungeonActiveInfo>
function LuaGlobalTableDeal:GetUnionDungeonOpenActiveList()
    if self.mUnionDungeonOpenActiveList == nil then
        self.mUnionDungeonOpenActiveList = {}
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22627)
        if tableInfo then
            local temp = _fSplit(tableInfo.value, "&")
            for i, v in pairs(temp) do
                local infoList = _fSplit(v, "#")
                if #infoList == 3 then
                    ---@class UnionDungeonActiveInfo
                    local activeInfo = {
                        startTime = tonumber(infoList[1]),
                        endTime = tonumber(infoList[2]),
                        activeID = tonumber(infoList[3]),
                    }
                    table.insert(self.mUnionDungeonOpenActiveList, activeInfo)
                end
            end
        end
    end
    return self.mUnionDungeonOpenActiveList
end

---帮会地牢进入等级限制
function LuaGlobalTableDeal:GetUnionDungeonEnterLevelLimit()
    if self.mUnionDungeonEnterLevelLimit == nil then
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22633)
        if tableInfo then
            self.mUnionDungeonEnterLevelLimit = tonumber(tableInfo.value)
        end
    end
    return self.mUnionDungeonEnterLevelLimit
end

---帮会气泡消失时间
function LuaGlobalTableDeal:GetUnionDungeonBubbleTime()
    if self.mUnionDungeonBubbleTime == nil then
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22638)
        if tableInfo then
            self.mUnionDungeonBubbleTime = tonumber(tableInfo.value)
        end
    end
    return self.mUnionDungeonBubbleTime
end
--endregion
--endregion

--region 熔炼

---熔炼默认显示的奖励预览
function LuaGlobalTableDeal.GetSmeltDefaultRewardPreview()
    if LuaGlobalTableDeal.mSmeltDefaultRewardPreview == nil then
        local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22517)
        if isFind then
            LuaGlobalTableDeal.mSmeltDefaultRewardPreview = string.Split(info.value, '#')
        end
    end
    return LuaGlobalTableDeal.mSmeltDefaultRewardPreview
end

---熔炼行开启限制
function LuaGlobalTableDeal.OpenSmeltAuctionConditionList()
    if LuaGlobalTableDeal.mSmeltAuctionConditionList == nil then
        local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22524)
        if isFind then
            LuaGlobalTableDeal.mSmeltAuctionConditionList = string.Split(info.value, '#')
        end
    end
    return LuaGlobalTableDeal.mSmeltAuctionConditionList
end

---熔炼行是否开启
function LuaGlobalTableDeal.GetIsOpenSmeltAuction()
    if LuaGlobalTableDeal.OpenSmeltAuctionConditionList() ~= nil then
        for i = 1, #LuaGlobalTableDeal.OpenSmeltAuctionConditionList() do
            local conditionID = tonumber(LuaGlobalTableDeal.OpenSmeltAuctionConditionList()[i])
            if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionID) then
                return false
            end
        end
    end
    return true
end

---熔炼背包页签开启限制
function LuaGlobalTableDeal.OpenBagSmeltMarkCondition()
    if LuaGlobalTableDeal.mBagSmeltMarkConditionTbl == nil then
        local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22525)
        if isFind then
            LuaGlobalTableDeal.mBagSmeltMarkConditionTbl = string.Split(info.value, '#')
        end
    end
    return LuaGlobalTableDeal.mBagSmeltMarkConditionTbl
end

---熔炼收益tips显示信息（bg#标题）
function LuaGlobalTableDeal.GetSmeltRewardTipsViewInfo()
    if LuaGlobalTableDeal.SmeltRewardTipsViewInfo == nil then
        local info = LuaGlobalTableDeal.GetGlobalTabl(22592)
        if info then
            LuaGlobalTableDeal.SmeltRewardTipsViewInfo = string.Split(info.value, '#')
        end
    end
    return LuaGlobalTableDeal.SmeltRewardTipsViewInfo
end

---是否开启熔炼背包
function LuaGlobalTableDeal.IsOpenSmeltBag()
    if LuaGlobalTableDeal.openSmeltBagTag == nil then
        LuaGlobalTableDeal.openSmeltBagTag = 0
        local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22973)
        if isFind then
            LuaGlobalTableDeal.openSmeltBagTag = tonumber(info.value)
        end
    end
    return LuaGlobalTableDeal.openSmeltBagTag == 1
end

---获取熔炼物品的消耗品信息
function LuaGlobalTableDeal.GetSmeltConsumeItemInfo()
    if LuaGlobalTableDeal.mSmeltConsumeItemInfo == nil then

        local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22979)
        if isFind then
            local itemInfo = string.Split(info.value, '#')
            if #itemInfo > 1 then
                LuaGlobalTableDeal.mSmeltConsumeItemInfo = {
                    itemId = tonumber(itemInfo[1]),
                    count = tonumber(itemInfo[2])
                }
            end
        end
    end
    return LuaGlobalTableDeal.mSmeltConsumeItemInfo
end

--endregion

--region 天宫神剪
---获取天宫神剪deliver表信息
function LuaGlobalTableDeal.GetTianGongShenJianNpcDeliverInfoTable()
    if LuaGlobalTableDeal.TianGongShenJianNpcDeliverInfoTable == nil then
        LuaGlobalTableDeal.TianGongShenJianNpcDeliverInfoTable = {}
        local globalInfoIsFind, globalInfo = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22518)
        if globalInfoIsFind then
            local deliverIdTable = string.Split(globalInfo.value, '#')
            if deliverIdTable ~= nil and type(deliverIdTable) == 'table' and #deliverIdTable > 0 then
                for k, v in pairs(deliverIdTable) do
                    local deliverTableInfoIsFind, deliverTableInfo = CS.Cfg_DeliverTableManager.Instance:TryGetValue(v)
                    if deliverTableInfoIsFind then
                        table.insert(LuaGlobalTableDeal.TianGongShenJianNpcDeliverInfoTable, deliverTableInfo)
                    end
                end
            end
        end
    end
    return LuaGlobalTableDeal.TianGongShenJianNpcDeliverInfoTable
end

---获取进入天宫神剪的花费
function LuaGlobalTableDeal.GetTianGongShenJianCost()
    local itemId, price
    local globalInfoIsFind, globalInfo = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22522)
    if globalInfoIsFind then
        local costTable = string.Split(globalInfo.value, '#')
        if costTable ~= nil and type(costTable) == 'table' and #costTable > 1 then
            itemId = costTable[2]
            price = costTable[1]
        end
    end
    return itemId, price
end
--endregion

--region 奖励结算

---奖励结算显示的奖励bg
---@type table<number,string> number为奖励类型 string为bg图片名称
---
function LuaGlobalTableDeal.GetRewardBgTextureDic()
    if LuaGlobalTableDeal.mRewardBgTextureDic == nil then
        LuaGlobalTableDeal.mRewardBgTextureDic = {}
        local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22521)
        if isFind then
            local infos = string.Split(info.value, '&')
            for i = 1, #infos do
                local textureInfo = string.Split(infos[i], '#')
                if #textureInfo > 1 then
                    LuaGlobalTableDeal.mRewardBgTextureDic[tonumber(textureInfo[1])] = textureInfo[2]
                end
            end
        end
    end
    return LuaGlobalTableDeal.mRewardBgTextureDic
end
--endregion

--region 灵兽
---开启条件
function LuaGlobalTableDeal:GetServantOpenTips(index)
    if self.ServantOpenTipsGroup == nil then
        local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20243)
        if isFind then
            self.ServantOpenTipsGroup = string.Split(info.value, "#")
        end
    end
    if (#self.ServantOpenTipsGroup >= index) then
        return self.ServantOpenTipsGroup[index]
    else
        return ""
    end
end

---灵兽修炼
function LuaGlobalTableDeal.GetRemoveServantFlashTime()
    if LuaGlobalTableDeal.RemoveServantFlashTime == nil then
        local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22527)
        if isFind then
            LuaGlobalTableDeal.RemoveServantFlashTime = tonumber(info.value)
        end
    end
    return LuaGlobalTableDeal.RemoveServantFlashTime
end

function LuaGlobalTableDeal.IsOpenServantRein()
    local isFind, globalTable = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20233)
    if (isFind) then
        local ShowReinLevel = tonumber(string.Split(globalTable.value, "#")[1])
        if ShowReinLevel then
            for i = 0, CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count - 1 do
                if CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList[i].level >= ShowReinLevel then
                    return true
                end
            end
        end
    end
end

---灵兽聚灵满级速率
function LuaGlobalTableDeal.GetServantGatherSoulMaxLevelSpeed()
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22584)
    if isFind then
        LuaGlobalTableDeal.ServantGatherSoulMaxLevelSpeed = tonumber(info.value)
    end
    return LuaGlobalTableDeal.ServantGatherSoulMaxLevelSpeed
end

---获取灵兽装备栏的人物等级和转生等级限制
---@return number,number 人物的等级和转生等级
function LuaGlobalTableDeal.GetServantEquipShowLevelAndReinLevel()
    if LuaGlobalTableDeal.mServantEquipShowMainPlayerLevel ~= nil and LuaGlobalTableDeal.mServantEquipShowMainPlayerReinLevel ~= nil then
        return LuaGlobalTableDeal.mServantEquipShowMainPlayerLevel, LuaGlobalTableDeal.mServantEquipShowMainPlayerReinLevel
    end
    ---@type TABLE.CFG_GLOBAL
    local tbl
    ___, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22687)
    if tbl and tbl.value ~= nil then
        local numStrs = _fSplit(tbl.value, '#')
        if numStrs and #numStrs >= 2 then
            LuaGlobalTableDeal.mServantEquipShowMainPlayerLevel = tonumber(numStrs[1])
            LuaGlobalTableDeal.mServantEquipShowMainPlayerReinLevel = tonumber(numStrs[2])
            return LuaGlobalTableDeal.mServantEquipShowMainPlayerLevel, LuaGlobalTableDeal.mServantEquipShowMainPlayerReinLevel
        end
    end
    return 0, 0
end

---获取灵兽开启角色装备ConditionIdList
---@param servantSeatType luaEnumServantSeatType
---@return table<number> conditionId列表
function LuaGlobalTableDeal.GetServantOpenRoleEquipConditionIdList(servantSeatType)
    if LuaGlobalTableDeal.ServantOpenRoleEquipConditionIdDic == nil then
        local info = LuaGlobalTableDeal.GetGlobalTabl(22787)
        if info ~= nil then
            LuaGlobalTableDeal.ServantOpenRoleEquipConditionIdDic = {}
            local servantTypeAndConditionList = string.Split(info.value, '&')
            for k, v in pairs(servantTypeAndConditionList) do
                if v ~= nil then
                    local servantConditionList = string.Split(v, '#')
                    if type(servantConditionList) == 'table' and Utility.GetLuaTableCount(servantConditionList) > 0 then
                        local servantType = tonumber(servantConditionList[1])
                        table.remove(servantConditionList, 1)
                        LuaGlobalTableDeal.ServantOpenRoleEquipConditionIdDic[servantType] = Utility.ChangeNumberTable(servantConditionList)
                    end
                end
            end
        end
    end
    if servantSeatType ~= nil and LuaGlobalTableDeal.ServantOpenRoleEquipConditionIdDic ~= nil then
        return LuaGlobalTableDeal.ServantOpenRoleEquipConditionIdDic[servantSeatType]
    end
end

---是否可以显示灵兽头像面板（影响UIServantHeadPanel）
---@return boolean
function LuaGlobalTableDeal.CanShowServantHeadPanel()
    if LuaGlobalTableDeal.showServantHeadPanelConditionList == nil then
        local info = LuaGlobalTableDeal.GetGlobalTabl(23008)
        if info ~= nil then
            LuaGlobalTableDeal.showServantHeadPanelConditionList = Utility.ChangeNumberTable(string.Split(info.value, '#'))
        end
    end
    if type(LuaGlobalTableDeal.showServantHeadPanelConditionList) == 'table' and #LuaGlobalTableDeal.showServantHeadPanelConditionList > 0 then
        return Utility.IsMainPlayerMatchConditionList_AND(LuaGlobalTableDeal.showServantHeadPanelConditionList).success
    end
    return false
end
--endregion

--region 商城
LuaGlobalTableDeal.StoreReplaceCoinGroup = {}

---可替换货币
function LuaGlobalTableDeal.GetStoreReplaceCoinTab()
    if LuaGlobalTableDeal.mStoreReplaceCoin == nil then
        LuaGlobalTableDeal.mStoreReplaceCoin = {}
        local info = LuaGlobalTableDeal.GetGlobalTabl(22532)
        if info then
            LuaGlobalTableDeal.StoreReplaceCoinGroup = string.Split(info.value, '&')
            for i = 1, #LuaGlobalTableDeal.StoreReplaceCoinGroup do
                local tab = string.Split(LuaGlobalTableDeal.StoreReplaceCoinGroup, '#')
                for j = 2, #tab do
                    table.insert(LuaGlobalTableDeal.mStoreReplaceCoin[tab[1]], tab[j])
                end
            end
        end
    end
    return LuaGlobalTableDeal.mStoreReplaceCoin
end
--endregion

--region 我要变强
---获取复活显示变强提示最大等级
function LuaGlobalTableDeal.GetReliveShowBianQiangHintMaxLevel()
    if LuaGlobalTableDeal.mReliveShowBianQiangHintMaxLevel == nil then
        local info = LuaGlobalTableDeal.GetGlobalTabl(22535)
        if info then
            LuaGlobalTableDeal.mReliveShowBianQiangHintMaxLevel = tonumber(info.value)
        end
    end
    return LuaGlobalTableDeal.mReliveShowBianQiangHintMaxLevel
end
--endregion

--region 技能
function LuaGlobalTableDeal.GetSkillElementShowInfo(id)
    if LuaGlobalTableDeal.mSkillElementShowInfo == nil then
        LuaGlobalTableDeal.mSkillElementShowInfo = {}
        local info = LuaGlobalTableDeal.GetGlobalTabl(22537)
        if info then
            local strs = string.Split(info.value, '&')
            for i = 1, #strs do
                local str = string.Split(strs[i], '#')
                if #str >= 2 then
                    local id = tonumber(str[1])
                    if id then
                        LuaGlobalTableDeal.mSkillElementShowInfo[id] = str[2]
                    end
                end
            end
        end
    end
    return LuaGlobalTableDeal.mSkillElementShowInfo[id]
end

---是否有任何禁止施法的buff存在在主角身上
---@return boolean
function LuaGlobalTableDeal.IsAnyAntiSkillReleaseBuffExistInMainPlayer()
    if CS.CSScene.MainPlayerInfo == nil then
        return false
    end
    ---@type CSBuffInfoV2
    local buffInfo = CS.CSScene.MainPlayerInfo.BuffInfo
    if buffInfo == nil then
        return false
    end
    return buffInfo:IsHasForbidenUseSkillBuff()
end
--endregion

--region 任务
---特殊处理原地自动提交任务
function LuaGlobalTableDeal.Task_SpecialOpenPanelSubmitTask()
    if LuaGlobalTableDeal.mTask_SpecialOpenPanelSubmitTask == nil then
        LuaGlobalTableDeal.SetSpecialOpenPanelSubmitTask()
    end
    return LuaGlobalTableDeal.mTask_SpecialOpenPanelSubmitTask
end

---设置特殊处理原地自动提交任务
function LuaGlobalTableDeal.SetSpecialOpenPanelSubmitTask()
    local data = LuaGlobalTableDeal.GetGlobalTabl(22534)
    if data == nil then
        return
    end
    local strList = _fSplit(data.value, "#")
    LuaGlobalTableDeal.mTask_SpecialOpenPanelSubmitTask = strList
end

---指定任务点击之后打开变强面板
function LuaGlobalTableDeal.Task_SpecialOpenPowPanel()
    if LuaGlobalTableDeal.mTask_SpecialOpenPowPanel == nil then
        LuaGlobalTableDeal.SetTask_SpecialOpenPowPanel()
    end
    return LuaGlobalTableDeal.mTask_SpecialOpenPowPanel
end

---设置指定任务点击之后打开变强面板
function LuaGlobalTableDeal.SetTask_SpecialOpenPowPanel()
    local data = LuaGlobalTableDeal.GetGlobalTabl(22536)
    if data == nil then
        return
    end
    local strList = _fSplit(data.value, "#")
    LuaGlobalTableDeal.mTask_SpecialOpenPowPanel = strList
end

--region 挑战boss
---@return number 挑战次数
function LuaGlobalTableDeal:GetChallengeBossTimes()
    if self.mChallengeTimes == nil then
        self:GetChallengeBossData()
    end
    return self.mChallengeTimes
end

---@return boolean 玩家是都可以进行挑战boss任务
function LuaGlobalTableDeal:IsMainPlayerMatchChallengeBossCondition()
    if self.mChallengeCondition == nil then
        self:GetChallengeBossData()
    end
    local state = Utility.IsMainPlayerMatchCondition(self.mChallengeCondition)
    return state.success
end

---获取数据
function LuaGlobalTableDeal:GetChallengeBossData()
    local data = self.GetGlobalTabl(22873)
    if data then
        local strs = string.Split(data.value, '#')
        if #strs >= 2 then
            self.mChallengeCondition = tonumber(strs[1])
            self.mChallengeTimes = tonumber(strs[2])
        end
    end
end
--endregion

--endregion

--region 组队
---是否需要组队提示
function LuaGlobalTableDeal.NeedTeamPrompt(isSameUnion)
    local ConditionTable
    if isSameUnion then
        if LuaGlobalTableDeal.mSameUnionCondition == nil then
            LuaGlobalTableDeal.mSameUnionCondition = {}
            local data = LuaGlobalTableDeal.GetGlobalTabl(22150)
            if data then
                local conditions = string.Split(data.value, '#')
                if #conditions >= 2 then
                    LuaGlobalTableDeal.mSameUnionCondition.MinCondition = tonumber(conditions[1])
                    LuaGlobalTableDeal.mSameUnionCondition.MaxCondition = tonumber(conditions[2])
                end
            end
        end
        ConditionTable = LuaGlobalTableDeal.mSameUnionCondition
    else
        if LuaGlobalTableDeal.mDifferentUnionCondition == nil then
            LuaGlobalTableDeal.mDifferentUnionCondition = {}
            local data = LuaGlobalTableDeal.GetGlobalTabl(22547)
            if data then
                local conditions = string.Split(data.value, '#')
                if #conditions >= 2 then
                    LuaGlobalTableDeal.mDifferentUnionCondition.MinCondition = tonumber(conditions[1])
                    LuaGlobalTableDeal.mDifferentUnionCondition.MaxCondition = tonumber(conditions[2])
                end
            end
        end
        ConditionTable = LuaGlobalTableDeal.mDifferentUnionCondition
    end
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo and ConditionTable and ConditionTable.MinCondition and ConditionTable.MaxCondition then
        return mainPlayerInfo.Level >= ConditionTable.MinCondition and mainPlayerInfo.Level <= ConditionTable.MaxCondition
    end
    return false
end

---日常任务获取额外次数道具字典
function LuaGlobalTableDeal:DailyTaskAddTimeItemDic()
    if LuaGlobalTableDeal.dailyTaskAddTimeItemList == nil then
        LuaGlobalTableDeal.dailyTaskAddTimeItemList = LuaGlobalTableDeal.GetDailyTaskAddTimeItemList()
    end
    return LuaGlobalTableDeal.dailyTaskAddTimeItemList
end
---得到日常任务获取额外次数道具字典
function LuaGlobalTableDeal.GetDailyTaskAddTimeItemList()
    local tableDic = {}
    local isFind, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22612)
    if isFind then
        local tempList = _fSplit(tbl.value, "&")
        for i = 1, #tempList do
            local info = _fSplit(tempList[i], "#")
            if #info == 2 then
                local type = tonumber(info[1])
                local itemID = tonumber(info[2])
                tableDic[type] = itemID
            end
        end
    end
    return tableDic
end

---日常任务三倍领取条件限制
function LuaGlobalTableDeal:DailyTaskThreeAwardLimit()
    if LuaGlobalTableDeal.dailyTaskThreeAwardLimit == nil then
        local isFind, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22614)
        if isFind then
            LuaGlobalTableDeal.dailyTaskThreeAwardLimit = tonumber(tbl.value)
        end
    end
    return LuaGlobalTableDeal.dailyTaskThreeAwardLimit
end
--endregion

--region 公告
---获取怪物类型与等级的限制
---@alias MonsterTypeAndLevelLimitList table<number,{playerMinLevel:number,playerMaxLevel:number,monsterLimits:table<number,{monsterType:number,monsterMinLevel:number,monsterMaxLevel:number}>}>
---@private
---@return MonsterTypeAndLevelLimitList
function LuaGlobalTableDeal:GetMonsterTypeAndLevelLimitForAnnounce()
    if self.mMonsterTypeAndLevelLimitList == nil then
        self.mMonsterTypeAndLevelLimitList = {}
        local isFind, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22548)
        if isFind and tbl then
            local content = tbl.value
            local strs1 = string.Split(content, '&')
            for i = 1, #strs1 do
                local strTemp = strs1[i]
                local strs2 = string.Split(strTemp, '#')
                local tblTemp = {}
                if #strs2 > 1 then
                    tblTemp.playerMinLevel = tonumber(strs2[1])
                    tblTemp.playerMaxLevel = tonumber(strs2[2])
                    tblTemp.monsterLimits = {}
                    local index = 0
                    local monsterMinLevelTemp, monsterMaxLevelTemp, monsterType
                    for j = 3, #strs2 do
                        index = index + 1
                        if index == 1 then
                            monsterType = tonumber(strs2[j])
                        elseif index == 2 then
                            monsterMinLevelTemp = tonumber(strs2[j])
                        elseif index == 3 then
                            monsterMaxLevelTemp = tonumber(strs2[j])
                            index = 0
                            table.insert(tblTemp.monsterLimits, { monsterType = monsterType, monsterMinLevel = monsterMinLevelTemp, monsterMaxLevel = monsterMaxLevelTemp })
                        end
                    end
                end
                if tblTemp.playerMinLevel and tblTemp.playerMaxLevel then
                    table.insert(self.mMonsterTypeAndLevelLimitList, tblTemp)
                end
            end
        end
    end
    return self.mMonsterTypeAndLevelLimitList
end

---玩家等级和怪物类型、等级是否符合需要被公告屏蔽
---@param mainPlayerLevel number
---@param monsterType number
---@param monsterLevel number
---@return boolean 是否需要被公告屏蔽
function LuaGlobalTableDeal:IsPlayerLevelAndMonsterTypeLevelConfirmToAnnounce(mainPlayerLevel, monsterType, monsterLevel)
    if mainPlayerLevel == nil or monsterLevel == nil or monsterType == nil then
        return false
    end
    local tbl = self:GetMonsterTypeAndLevelLimitForAnnounce()
    for i = 1, #tbl do
        local tblTemp = tbl[i]
        if mainPlayerLevel >= tblTemp.playerMinLevel and mainPlayerLevel <= tblTemp.playerMaxLevel then
            for j = 1, #tblTemp.monsterLimits do
                local tblTemp2 = tblTemp.monsterLimits[j]
                if tblTemp2.monsterType == monsterType and monsterLevel <= tblTemp2.monsterMaxLevel and monsterLevel >= tblTemp2.monsterMinLevel then
                    return true
                end
            end
        end
    end
    return false
end
--endregion

--region 充值
function LuaGlobalTableDeal:GetSpecialFirstRebateTable()
    local isFind, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22586)
    if isFind then
        local cont = string.Split(tbl.value, "#")
        return cont
    else
        return {}
    end
end

---获取返利货币itemid
function LuaGlobalTableDeal:GetRebateCoinItemId()
    if self.mRebateCoinItemId ~= nil then
        return self.mRebateCoinItemId
    end
    local info = LuaGlobalTableDeal.GetGlobalTabl(22088)
    if info then
        self.mRebateCoinItemId = tonumber(info.value)
    end
    return self.mRebateCoinItemId
end
--endregion

--region 社交
---是否可以编辑自我介绍
function LuaGlobalTableDeal:CanEditorMyIntroduction()
    local globalTable = LuaGlobalTableDeal.GetGlobalTabl(22552);
    return CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(tonumber(globalTable.value));
end
--endregion

--region 腕力精力相关

--region 腕力
---腕力最大值
---@return number
function LuaGlobalTableDeal:GetWristStrengthMaxValue()
    if LuaGlobalTableDeal.mWristStrengthMaxValue == nil then
        LuaGlobalTableDeal.mWristStrengthMaxValue = 0
        local info = LuaGlobalTableDeal.GetGlobalTabl(22313)
        if info then
            local strInfo = string.Split(info.value, '#')
            LuaGlobalTableDeal.mWristStrengthMaxValue = tonumber(strInfo[1])
        end
    end
    return LuaGlobalTableDeal.mWristStrengthMaxValue
end

---腕力比例尺
---@return number
function LuaGlobalTableDeal:GetWristStrengthScale()
    if LuaGlobalTableDeal.mWristStrengthScale == nil then
        LuaGlobalTableDeal.mWristStrengthScale = 1
        self:SetWristStrengthAndEnergyScale()
    end
    return LuaGlobalTableDeal.mWristStrengthScale
end

---腕力药水商品id
---@return number
function LuaGlobalTableDeal:GetWristStrengthStoreId()
    if LuaGlobalTableDeal.mWristStrengthStoreId == nil then
        LuaGlobalTableDeal.mWristStrengthStoreId = 0
        self:SetWristStrengthAndEnergyStoreId()
    end
    return LuaGlobalTableDeal.mWristStrengthStoreId
end

--endregion

--region 精力

---精力最大值
---@return number
function LuaGlobalTableDeal:GetEnergyMaxValue()
    if LuaGlobalTableDeal.mEnergyMaxValue == nil then
        LuaGlobalTableDeal.mEnergyMaxValue = 0
        local info = LuaGlobalTableDeal.GetGlobalTabl(22314)
        if info then
            local strInfo = string.Split(info.value, '#')
            LuaGlobalTableDeal.mEnergyMaxValue = tonumber(strInfo[1])
        end
    end
    return LuaGlobalTableDeal.mEnergyMaxValue
end

---精力比例尺
---@return number
function LuaGlobalTableDeal:GetEnergyScale()
    if LuaGlobalTableDeal.mEnergyScale == nil then
        LuaGlobalTableDeal.mEnergyScale = 1
        self:SetWristStrengthAndEnergyScale()
    end
    return LuaGlobalTableDeal.mEnergyScale
end

---精力药水商品id
---@return number
function LuaGlobalTableDeal:GetEnergyStoreId()
    if LuaGlobalTableDeal.mEnergyStoreId == nil then
        LuaGlobalTableDeal.mEnergyStoreId = 0
        self:SetWristStrengthAndEnergyStoreId()
    end
    return LuaGlobalTableDeal.mEnergyStoreId
end

--endregion

---设置腕力精力比例尺
function LuaGlobalTableDeal:SetWristStrengthAndEnergyScale()
    local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22557)
    if tableInfo then
        local info = string.Split(tableInfo.value, '#')
        if #info > 0 then
            LuaGlobalTableDeal.mWristStrengthScale = tonumber(info[1])
        end
        if #info > 1 then
            LuaGlobalTableDeal.mEnergyScale = tonumber(info[2])
        end
    end
end

---设置腕力精力商品id
function LuaGlobalTableDeal:SetWristStrengthAndEnergyStoreId()
    local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22558)
    if tableInfo then
        local info = string.Split(tableInfo.value, '#')
        if #info > 0 then
            LuaGlobalTableDeal.mWristStrengthStoreId = tonumber(info[1])
        end
        if #info > 1 then
            LuaGlobalTableDeal.mEnergyStoreId = tonumber(info[2])
        end
    end
end

--endregion

--region 挑战Boss新版

---得到挑战BOSS页签描述总字典
---@return table<number,table<number,BossSubTab>>
function LuaGlobalTableDeal.BossSubTabDesDic()
    ---重新选角后要重新初始化数据
    if LuaGlobalTableDeal.bossSubTableDesDicInitRid == nil or CS.CSScene.MainPlayerInfo.ID ~= LuaGlobalTableDeal.bossSubTableDesDicInitRid then
        LuaGlobalTableDeal.bossSubTableDesDicInitRid = CS.CSScene.MainPlayerInfo.ID
        LuaGlobalTableDeal.mBossSubTabDesDic = nil
    end
    if LuaGlobalTableDeal.mBossSubTabDesDic == nil then
        LuaGlobalTableDeal.mBossSubTabDesDic = LuaGlobalTableDeal.GetBossSubTabDes()
    end
    return LuaGlobalTableDeal.mBossSubTabDesDic
end

---检测boss类型是否开启
---@param bossType LuaEnumBossType boss大类
---@param bossSubType number boss子类型
function LuaGlobalTableDeal.CheckBossTypeIsOpen(bossType, bossSubType)
    if LuaGlobalTableDeal.mBossSubTabDesDic == nil then
        LuaGlobalTableDeal.BossSubTabDesDic()
    end
    if LuaGlobalTableDeal.mBossSubTabDesDic ~= nil and type(LuaGlobalTableDeal.mBossSubTabDesDic) == 'table' and LuaGlobalTableDeal.mBossSubTabDesDic[bossType] ~= nil then
        local BossConfigInfoList = LuaGlobalTableDeal.mBossSubTabDesDic[bossType]
        for k, v in pairs(BossConfigInfoList) do
            if v ~= nil and v.type == bossSubType then
                if v.conditionList == nil or type(v.conditionList) ~= 'table' then
                    return true
                else
                    local condtion = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(v.conditionList)
                    local showCondition = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(v.SelectconditionList)
                    return condtion and showCondition
                end
            end
        end
    end
    return false
end

---得到Boss子页签描述列表
---@return table<number,BossSubTab>
function LuaGlobalTableDeal.GetBossSubTabList(mainType)
    if mainType ~= nil and LuaGlobalTableDeal.BossSubTabDesDic() ~= nil then
        local dic = LuaGlobalTableDeal.BossSubTabDesDic()
        local list = dic[mainType]
        return list
    end
    return nil
end

---检测子页签点击条件
---@param bossType LuaEnumBossType boss大类
---@param bossSubType number boss子类型
---@return boolean
function LuaGlobalTableDeal.CheckBossSelectConditionList(bossType, bossSubType)
    if LuaGlobalTableDeal.mBossSubTabDesDic == nil then
        LuaGlobalTableDeal.BossSubTabDesDic()
    end
    if LuaGlobalTableDeal.mBossSubTabDesDic ~= nil and type(LuaGlobalTableDeal.mBossSubTabDesDic) == 'table' and LuaGlobalTableDeal.mBossSubTabDesDic[bossType] ~= nil then
        local BossConfigInfoList = LuaGlobalTableDeal.mBossSubTabDesDic[bossType]
        for k, v in pairs(BossConfigInfoList) do
            if v ~= nil and v.type == bossSubType then
                if v.SelectconditionList == nil or type(v.SelectconditionList) ~= 'table' then
                    return true
                else
                    local showCondition = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(v.SelectconditionList)
                    return showCondition
                end
            end
        end
    end
    return false
end

---检测子页签置灰条件
---@param bossType LuaEnumBossType boss大类
---@param bossSubType number boss子类型
---@return boolean
function LuaGlobalTableDeal.CheckBossGrayConditionList(bossType, bossSubType)
    if LuaGlobalTableDeal.mBossSubTabDesDic == nil then
        LuaGlobalTableDeal.BossSubTabDesDic()
    end
    if LuaGlobalTableDeal.mBossSubTabDesDic ~= nil and type(LuaGlobalTableDeal.mBossSubTabDesDic) == 'table' and LuaGlobalTableDeal.mBossSubTabDesDic[bossType] ~= nil then
        local BossConfigInfoList = LuaGlobalTableDeal.mBossSubTabDesDic[bossType]
        for k, v in pairs(BossConfigInfoList) do
            if v ~= nil and v.type == bossSubType then
                if v.pageGrayConditionList == nil or type(v.pageGrayConditionList) ~= 'table' then
                    return true
                else
                    local showCondition = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(v.pageGrayConditionList)
                    return showCondition
                end
            end
        end
    end
    return false
end

---获取子页签置灰逻辑类型
---@param bossType LuaEnumBossType boss大类
---@param bossSubType number boss子类型
---@return LuaEnumBossPanelSubtypePageGrayLogicType
function LuaGlobalTableDeal.GetBossPageGrayLogicType(bossType, bossSubType)
    if LuaGlobalTableDeal.mBossSubTabDesDic == nil then
        LuaGlobalTableDeal.BossSubTabDesDic()
    end
    if LuaGlobalTableDeal.mBossSubTabDesDic ~= nil and type(LuaGlobalTableDeal.mBossSubTabDesDic) == 'table' and LuaGlobalTableDeal.mBossSubTabDesDic[bossType] ~= nil then
        local BossConfigInfoList = LuaGlobalTableDeal.mBossSubTabDesDic[bossType]
        for k, v in pairs(BossConfigInfoList) do
            if v ~= nil and v.type == bossSubType and v.pageGrayLogicType ~= nil then
                return v.pageGrayLogicType
            end
        end
    end
    return LuaEnumBossPanelSubtypePageGrayLogicType.Normal
end

---得到子页签描述显示
---@private
function LuaGlobalTableDeal.GetBossSubTabDes()
    local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22568)
    if tableInfo then
        ---@type table<number,table<BossSubTab>>
        local SubTabDesDic = {}
        local temp1 = string.Split(tableInfo.value, "&")
        for i, v in pairs(temp1) do
            local temp2 = string.Split(v, "#")
            if #temp2 > 4 then
                ---@class BossSubTab
                local BossSubTab = {
                    ---类型
                    type = tonumber(temp2[2]),
                    ---类型描述
                    typeDes = temp2[3],
                    ---详细信息描述
                    detailDes = temp2[4],
                    ---特殊掉落展示
                    speDrop = LuaGlobalTableDeal.GetBossSubTabDropShow(temp2[1], temp2[2]),
                    ---页签限制
                    conditionList = Utility.ChangeNumberTable(string.Split(temp2[5], '_')),
                    ---默认选择页签限制
                    SelectconditionList = Utility.ChangeNumberTable(string.Split(temp2[6], '_'))
                }
                if #temp2 > 6 then
                    BossSubTab.bubbleId = tonumber(temp2[7])
                end
                if #temp2 > 7 then
                    BossSubTab.pageGrayConditionList = Utility.ChangeNumberTable(string.Split(temp2[8], '_'))
                end
                if #temp2 > 8 then
                    ---@type LuaEnumBossPanelSubtypePageGrayLogicType 页签置灰显示逻辑类型
                    BossSubTab.pageGrayLogicType = tonumber(temp2[9])
                end
                if SubTabDesDic[tonumber(temp2[1])] == nil then
                    SubTabDesDic[tonumber(temp2[1])] = {}
                end
                table.insert(SubTabDesDic[tonumber(temp2[1])], BossSubTab)
            end
        end
        return SubTabDesDic
    end
    return nil
end
---得到子页签描述显示特殊显示
---@private
function LuaGlobalTableDeal.GetBossSubTabDropShow(type, subtype)
    local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22587)
    if tableInfo then
        local temp1 = string.Split(tableInfo.value, "&")
        for i, v in pairs(temp1) do
            local temp2 = string.Split(v, "#")
            if #temp2 == 3 then
                if (type == temp2[1] and subtype == temp2[2]) then
                    local idList = CS.System.Collections.Generic["List`1[System.Int32]"]()
                    idList:Add(temp2[3])
                    return Utility.GetBossPanelDropListByList(idList)
                end
            end
        end
    end
    return nil
end
---获取boss页签
---@private
function LuaGlobalTableDeal.GetBossAllPageInfoList()
    if LuaGlobalTableDeal.mBossAllPageInfoList == nil then
        LuaGlobalTableDeal.mBossAllPageInfoList = {}
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22573)
        if tableInfo then
            local allPage = string.Split(tableInfo.value, '&')
            if #allPage > 0 then
                for i = 1, #allPage do
                    local info = string.Split(allPage[i], '#')
                    if info and #info > 1 then
                        table.insert(LuaGlobalTableDeal.mBossAllPageInfoList, info)
                    end
                end
            end
        end
    end
    return LuaGlobalTableDeal.mBossAllPageInfoList
end

--region 远古boss

---@type table<number,number>
function LuaGlobalTableDeal.GetAllAncientBossHelpIdDic()
    if LuaGlobalTableDeal.mAllAncientBossHelpIdDic == nil then
        LuaGlobalTableDeal.mAllAncientBossHelpIdDic = {}
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22704)
        if tableInfo then
            local allAncientBossHelpIds = string.Split(tableInfo.value, "&")
            for i, v in pairs(allAncientBossHelpIds) do
                local ancientBossHelpId = string.Split(v, "#")
                if #ancientBossHelpId > 1 then
                    LuaGlobalTableDeal.mAllAncientBossHelpIdDic[tonumber(ancientBossHelpId[1])] = tonumber(ancientBossHelpId[2])
                end
            end
        end
    end
    return LuaGlobalTableDeal.mAllAncientBossHelpIdDic
end

---获取远古boss的帮助id
function LuaGlobalTableDeal.GetAncientBossHelpId(monsterID)
    if LuaGlobalTableDeal.GetAllAncientBossHelpIdDic()[monsterID] ~= nil then
        return LuaGlobalTableDeal.GetAllAncientBossHelpIdDic()[monsterID]
    elseif LuaGlobalTableDeal.GetAllAncientBossHelpIdDic()[0] ~= nil then
        return LuaGlobalTableDeal.GetAllAncientBossHelpIdDic()[0]
    end
    return 0
end

--endregion

--endregion

--region 魔之boss
---获取击杀魔之boss最大次数
function LuaGlobalTableDeal.GetAttackMagicBossMaxNum()
    if LuaGlobalTableDeal.mAttackMagicBossMaxNum == nil then
        LuaGlobalTableDeal.InitAttackMagicBossMaxNum()
    end
    return LuaGlobalTableDeal.mAttackMagicBossMaxNum
end

---初始化击杀魔之boss最大次数
function LuaGlobalTableDeal.InitAttackMagicBossMaxNum()
    local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22570)
    if tableInfo then
        local info = string.Split(tableInfo.value, '#')
        if #info > 0 then
            LuaGlobalTableDeal.mAttackMagicBossMaxNum = tonumber(info[1])
        end
        if #info > 1 then
            LuaGlobalTableDeal.mMagicBossReliveTime = tonumber(info[2])
        end
    end
end

---获取协助次数最大值
function LuaGlobalTableDeal.GetXieZhuMaxNum()
    if LuaGlobalTableDeal.mXieZhuMaxNum == nil then
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22571)
        if tableInfo then
            LuaGlobalTableDeal.mXieZhuMaxNum = tonumber(tableInfo.value)
        end
    end
    return LuaGlobalTableDeal.mXieZhuMaxNum
end

---获取添加击杀次数材料itemid
function LuaGlobalTableDeal.GetAddKillNumMaterialItemId()
    if LuaGlobalTableDeal.mAddKillNumMaterialItemId == nil then
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22577)
        if tableInfo then
            LuaGlobalTableDeal.mAddKillNumMaterialItemId = tonumber(tableInfo.value)
        end
    end
    return LuaGlobalTableDeal.mAddKillNumMaterialItemId
end

---主角是否满足显示魔之boss红点
---@return boolean 是否显示魔之boss红点
function LuaGlobalTableDeal.ShowMagicBossRedPointByConditionTable()
    if LuaGlobalTableDeal.mMagicBossRedPointConditionTable == nil then
        LuaGlobalTableDeal.InitMagicBossRedPointConditionTable()
    end
    if LuaGlobalTableDeal.mMagicBossRedPointConditionTable ~= nil then
        return CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(LuaGlobalTableDeal.mMagicBossRedPointConditionTable)
    end
    return false
end

---初始化魔之boss的红点condition表
function LuaGlobalTableDeal.InitMagicBossRedPointConditionTable()
    if LuaGlobalTableDeal.mMagicBossRedPointConditionTable == nil then
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22581)
        if tableInfo then
            LuaGlobalTableDeal.mMagicBossRedPointConditionTable = string.Split(tableInfo.value, '#')
            LuaGlobalTableDeal.mMagicBossRedPointConditionTable = Utility.ChangeNumberTable(LuaGlobalTableDeal.mMagicBossRedPointConditionTable)
        end
    end
    return LuaGlobalTableDeal.mMagicBossRedPointConditionTable
end

---主角是否满足显示魔之boss红点
---@return boolean 是否显示魔之boss闪烁气泡
function LuaGlobalTableDeal.ShowMagicBossFlashByConditionTable()
    if LuaGlobalTableDeal.mMagicBossFlashConditionTable == nil then
        LuaGlobalTableDeal.InitMagicBossFlashConditionTable()
    end
    if LuaGlobalTableDeal.mMagicBossFlashConditionTable ~= nil then
        return CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(LuaGlobalTableDeal.mMagicBossFlashConditionTable)
    end
    return false
end

---初始化魔之boss的闪烁气泡condition表
function LuaGlobalTableDeal.InitMagicBossFlashConditionTable()
    if LuaGlobalTableDeal.mMagicBossFlashConditionTable == nil then
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22588)
        if tableInfo then
            LuaGlobalTableDeal.mMagicBossFlashConditionTable = string.Split(tableInfo.value, '#')
            LuaGlobalTableDeal.mMagicBossFlashConditionTable = Utility.ChangeNumberTable(LuaGlobalTableDeal.mMagicBossFlashConditionTable)
        end
    end
    return LuaGlobalTableDeal.mMagicBossFlashConditionTable
end

---获取魔之boss奖励表（策划要求所有的魔之boss的奖励都一样，有问题找高翔）
function LuaGlobalTableDeal.GetMagicBossRewardTable()
    if LuaGlobalTableDeal.MagicBossRewardTable ~= nil then
        return LuaGlobalTableDeal.MagicBossRewardTable
    end
    LuaGlobalTableDeal.MagicBossRewardTable = {}
    local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22580)
    if tableInfo ~= nil then
        local rewardTable = string.Split(tableInfo.value, '&')
        if rewardTable ~= nil and type(rewardTable) == 'table' then
            for k, v in pairs(rewardTable) do
                local strTable = string.Split(v, '#')
                if strTable ~= nil and type(strTable) == 'table' and #strTable > 1 then
                    local rewardInfoTable = {}
                    local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(tonumber(strTable[1]))
                    if itemInfoIsFind then
                        rewardInfoTable.itemInfo = itemInfo
                        rewardInfoTable.itemId = tonumber(strTable[1])
                        rewardInfoTable.count = tonumber(strTable[2])
                    end
                    table.insert(LuaGlobalTableDeal.MagicBossRewardTable, rewardInfoTable)
                end
            end
        end
    end
    return LuaGlobalTableDeal.MagicBossRewardTable
end

---获取魔之boss范围数据
function LuaGlobalTableDeal.GetMagicBossRangeNumber()
    if LuaGlobalTableDeal.MagicBossRange ~= nil then
        return LuaGlobalTableDeal.MagicBossRange
    end
    local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22575)
    if tableInfo ~= nil then
        LuaGlobalTableDeal.MagicBossRange = tonumber(tableInfo.value)
    end
    return LuaGlobalTableDeal.MagicBossRange
end

---获取魔之boss自动领取奖励时间(秒)
function LuaGlobalTableDeal.GetMagicBossAutoGetRewardTime()
    if LuaGlobalTableDeal.MagicBossAutoGetRewardTime ~= nil then
        return LuaGlobalTableDeal.MagicBossAutoGetRewardTime
    end
    local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22598)
    if tableInfo ~= nil then
        LuaGlobalTableDeal.MagicBossAutoGetRewardTime = tonumber(tableInfo.value)
    end
    return LuaGlobalTableDeal.MagicBossAutoGetRewardTime
end

---获取魔之boss开服天数conditionId
function LuaGlobalTableDeal.GetMagicBossOpenServerDayConditionId()
    if LuaGlobalTableDeal.MagicBossOpenServerDayConditionId ~= nil then
        return LuaGlobalTableDeal.MagicBossOpenServerDayConditionId
    end
    local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22600)
    if tableInfo ~= nil then
        LuaGlobalTableDeal.MagicBossOpenServerDayConditionId = tonumber(tableInfo.value)
    end
    return LuaGlobalTableDeal.MagicBossOpenServerDayConditionId
end

---获取魔之boss类型配置数据
---@param magicBossType LuaEnumMagicBossDropType 魔之boss掉落类型
---@return table 魔之boss配置信息
function LuaGlobalTableDeal.GetMagicBossTypeConfigInfo(magicBossType)
    if LuaGlobalTableDeal.MagicBossTypeConfigInfoTable ~= nil and type(LuaGlobalTableDeal.MagicBossTypeConfigInfoTable) == 'table' then
        return LuaGlobalTableDeal.MagicBossTypeConfigInfoTable[magicBossType]
    end
    if LuaGlobalTableDeal.MagicBossTypeConfigInfoTable == nil then
        LuaGlobalTableDeal.MagicBossTypeConfigInfoTable = {}
    end
    local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22608)
    if tableInfo ~= nil then
        local magicBossTypeInfoTable = string.Split(tableInfo.value, '&')
        if magicBossTypeInfoTable ~= nil then
            for k, v in pairs(magicBossTypeInfoTable) do
                if v ~= nil and CS.StaticUtility.IsNullOrEmpty(v) == false then
                    local singleMagicBossTypeInfoTable = string.Split(v, '#')
                    if singleMagicBossTypeInfoTable ~= nil and #singleMagicBossTypeInfoTable > 3 then
                        local magicBossTypeConfigInfo = {}
                        magicBossTypeConfigInfo.type = singleMagicBossTypeInfoTable[1]
                        magicBossTypeConfigInfo.killNumMax = singleMagicBossTypeInfoTable[2]
                        magicBossTypeConfigInfo.killRecoverTime = singleMagicBossTypeInfoTable[3]
                        magicBossTypeConfigInfo.killNumRecoverItemId = singleMagicBossTypeInfoTable[4]
                        LuaGlobalTableDeal.MagicBossTypeConfigInfoTable[tonumber(magicBossTypeConfigInfo.type)] = magicBossTypeConfigInfo
                    end
                end
            end
        end
    end
    return LuaGlobalTableDeal.MagicBossTypeConfigInfoTable[magicBossType]
end

---获取魔之boss总击杀次数
---@return number 总击杀次数
function LuaGlobalTableDeal.GetMagicBossTotalKillNum()
    if LuaGlobalTableDeal.totalKillNumMax == nil then
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22779)
        if tableInfo ~= nil then
            local strTbl = string.Split(tableInfo.value, '#')
            if type(strTbl) == 'table' and Utility.GetLuaTableCount(strTbl) > 0 then
                LuaGlobalTableDeal.totalKillNumMax = tonumber(strTbl[1])
            end
        end
    end
    return LuaGlobalTableDeal.totalKillNumMax
end

---通过按钮subtype获取魔之boss掉落类型
---@param btnSubType number 按钮subType
---@return LuaEnumMagicBossDropType 魔之boss类型
function LuaGlobalTableDeal.GetMagicBossTypeByBtnSubType(btnSubType)
    if LuaGlobalTableDeal.BtnSubtypeChangeMagicBossTypeTable ~= nil and type(LuaGlobalTableDeal.BtnSubtypeChangeMagicBossTypeTable) == 'table' then
        return LuaGlobalTableDeal.BtnSubtypeChangeMagicBossTypeTable[btnSubType]
    end
    if LuaGlobalTableDeal.BtnSubtypeChangeMagicBossTypeTable == nil then
        LuaGlobalTableDeal.BtnSubtypeChangeMagicBossTypeTable = {}
    end
    local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22609)
    if tableInfo ~= nil then
        local magicBossBtnSubTypeTable = string.Split(tableInfo.value, '&')
        if magicBossBtnSubTypeTable ~= nil then
            for k, v in pairs(magicBossBtnSubTypeTable) do
                local btnTypeAndMagicBossTypeTable = string.Split(v, '#')
                if btnTypeAndMagicBossTypeTable ~= nil and type(btnTypeAndMagicBossTypeTable) == 'table' and Utility.GetLuaTableCount(btnTypeAndMagicBossTypeTable) > 1 then
                    local magciBossType = tonumber(btnTypeAndMagicBossTypeTable[1])
                    local btnSubtype = tonumber(btnTypeAndMagicBossTypeTable[2])
                    LuaGlobalTableDeal.BtnSubtypeChangeMagicBossTypeTable[tonumber(btnSubtype)] = tonumber(magciBossType)
                end
            end
        end
    end
    return LuaGlobalTableDeal.BtnSubtypeChangeMagicBossTypeTable[btnSubType]
end
--endregion

--region 宝箱
---宝箱使用的vip提示是否显示
function LuaGlobalTableDeal:IsSpecialBoxUseVIPTipsShow(mainPlayerLevel, itemID)
    if mainPlayerLevel == nil or itemID == nil then
        return false
    end
    if self.mSpecialBoxUseVIPTipsShowConditions == nil then
        ---@type TABLE.CFG_GLOBAL
        local globalTbl
        ___, globalTbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22579)
        if globalTbl and globalTbl.value ~= nil then
            self.mSpecialBoxUseVIPTipsShowConditions = {}
            local strs = string.Split(globalTbl.value, '&')
            for i = 1, #strs do
                local strs2 = string.Split(strs[i], '#')
                if #strs2 >= 2 then
                    local itemIDTemp = tonumber(strs2[1])
                    local vipLevelTemp = tonumber(strs2[2])
                    self.mSpecialBoxUseVIPTipsShowConditions[itemIDTemp] = vipLevelTemp
                end
            end
        end
    end
    if self.mSpecialBoxUseVIPTipsShowConditions then
        local maxVIPLevel = self.mSpecialBoxUseVIPTipsShowConditions[itemID]
        if maxVIPLevel then
            return mainPlayerLevel <= maxVIPLevel
        else
            return false
        end
    else
        return false
    end
end
--endregion

--region 狼烟梦境
---xp技能对应的狼烟梦境的时间系数
function LuaGlobalTableDeal:LYMJTimeValueOfXpSkillIdDic()
    if self.mLYMJTimeValueOfXpSkillIdDic == nil then
        self.mLYMJTimeValueOfXpSkillIdDic = {}
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22578)
        if tableInfo then
            local lymjAllXpInfo = string.Split(tableInfo.value, '&')
            for i = 1, #lymjAllXpInfo do
                local lymhXpInfo = string.Split(lymjAllXpInfo[i], '#')
                if #lymhXpInfo > 1 then
                    self.mLYMJTimeValueOfXpSkillIdDic[tonumber(lymhXpInfo[1])] = tonumber(lymhXpInfo[3]) / 10000
                end
            end
        end
    end
    return self.mLYMJTimeValueOfXpSkillIdDic
end
--endregion

--region 宝物属性描述

---获取灯芯的描述
function LuaGlobalTableDeal:GetLightComponentDes()
    if self.mLightComponentDes == nil then
        self.mLightComponentDes = ''
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22616)
        if tableInfo then
            self.mLightComponentDes = tableInfo.value
        end
    end
    return self.mLightComponentDes
end

---获取宝石的描述
function LuaGlobalTableDeal:GetGemDes()
    if self.mGemDes == nil then
        self.mGemDes = ''
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22617)
        if tableInfo then
            self.mGemDes = tableInfo.value
        end
    end
    return self.mGemDes
end

---获取进攻之源的描述
function LuaGlobalTableDeal:GetJingongzhiyuanDes()
    if self.mJinggongzhiyuanDes == nil then
        self.mJinggongzhiyuanDes = ''
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22618)
        if tableInfo then
            self.mJinggongzhiyuanDes = tableInfo.value
        end
    end
    return self.mJinggongzhiyuanDes
end

---获取宝物的类型名称
---@param itemId number
---@return string
function LuaGlobalTableDeal:GetGemTypeName(itemId)
    local defaultDes = ""
    if type(itemId) ~= 'number' then
        return defaultDes
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil then
        return defaultDes
    end
    local ConfigGemTypeNameTable = self:GetConfigGemTypeNameTable()
    if type(ConfigGemTypeNameTable) ~= 'table' or #ConfigGemTypeNameTable <= 0 then
        return defaultDes
    end
    for k, v in pairs(ConfigGemTypeNameTable) do
        ---@type ConfigGemNameParams
        local configGemNameParams = v
        if configGemNameParams.subType == itemTbl:GetSubType() then
            return configGemNameParams.typeName
        end
    end
    return defaultDes
end

---@class ConfigGemNameParams 配置的宝物参数名字类
---@field subType number
---@field typeName string

---获取配置的宝物的类型列表
---@return table<ConfigGemNameParams>
function LuaGlobalTableDeal:GetConfigGemTypeNameTable()
    if self.configGemTypeNameTable == nil then
        if self.configGemTypeNameTable == nil then
            self.configGemTypeNameTable = {}
        end
        local tbl = LuaGlobalTableDeal.GetGlobalTabl(90006)
        if tbl ~= nil then
            local gemTypeNameTable = string.Split(tbl.value, '&')
            if type(gemTypeNameTable) == 'table' and #gemTypeNameTable > 0 then
                for k, v in pairs(gemTypeNameTable) do
                    local configParams = string.Split(v, '#')
                    if type(configParams) == 'table' and #configParams > 1 then
                        ---@type ConfigGemNameParams
                        local configGemNameParams = {}
                        configGemNameParams.subType = tonumber(configParams[1])
                        configGemNameParams.typeName = configParams[2]
                        table.insert(self.configGemTypeNameTable, configGemNameParams)
                    end
                end
            end
        end
    end
    return self.configGemTypeNameTable
end

---获取宝物套装物品名字格式
---@param subType LuaEnumEquipSubType
---@return string
function LuaGlobalTableDeal.GetGemSuitItemNameFormat(subType)
    if LuaGlobalTableDeal.GemSuitItemNameFormatTable == nil then
        local tbl = LuaGlobalTableDeal.GetGlobalTabl(22890)
        if tbl == nil then
            return
        end
        LuaGlobalTableDeal.GemSuitItemNameFormatTable = {}
        local gemSuitDesFormatList = string.Split(tbl.value, '&')
        if type(gemSuitDesFormatList) ~= 'table' then
            return
        end
        for k, v in pairs(gemSuitDesFormatList) do
            local subTypeAndDesFormat = string.Split(v, '#')
            if type(subTypeAndDesFormat) == 'table' and Utility.GetLuaTableCount(subTypeAndDesFormat) > 1 then
                local subType = tonumber(subTypeAndDesFormat[1])
                local desFormat = subTypeAndDesFormat[2]
                LuaGlobalTableDeal.GemSuitItemNameFormatTable[subType] = desFormat
            end
        end
    end

    if type(LuaGlobalTableDeal.GemSuitItemNameFormatTable) == 'table' then
        return LuaGlobalTableDeal.GemSuitItemNameFormatTable[subType]
    end
end
--endregion

--region 灵兽减伤相关

---需要添加生肖boss伤害buff的怪物id
---return table<number,TABLE.CFG_ANIMALS_BOSS>
function LuaGlobalTableDeal:GetNeedAddAnimalBossHurtBuffMonsterIDDic()
    if self.NeedAddAnimalBossHurtBuffMonsterIDDic == nil then
        self.NeedAddAnimalBossHurtBuffMonsterIDDic = {}
        local info = LuaGlobalTableDeal.GetGlobalTabl(22655)
        if info then
            local allInfo = string.Split(info.value, '&')
            for i = 1, #allInfo do
                local info = string.Split(allInfo[i], '#')
                if #info > 1 then
                    local animalInfo = clientTableManager.cfg_animals_bossManager:TryGetValue(tonumber(info[2]))
                    self.NeedAddAnimalBossHurtBuffMonsterIDDic[tonumber(info[1])] = animalInfo
                end
            end
        end
    end
    return self.NeedAddAnimalBossHurtBuffMonsterIDDic
end

---生肖boss伤害buff
---return boolean
function LuaGlobalTableDeal:IsNeedAddAnimalBossHurtBuff(monsterId)
    if self:GetNeedAddAnimalBossHurtBuffMonsterIDDic() ~= nil then
        self.isGetedAnimalBossBuffInfo = false
        ---@type TABLE.CFG_ANIMALS_BOSS
        self.curAddBuffAnimalBossInfo = self:GetNeedAddAnimalBossHurtBuffMonsterIDDic()[monsterId]
        return self.curAddBuffAnimalBossInfo ~= nil
    end
    return false
end

---获取生肖boss伤害buff显示数据
---@return number number 符合只数 伤害百分比
function LuaGlobalTableDeal:GetMeetAnimalBossServantBuffShowInfo()
    ---不重复获取buff数据
    if not self.isGetedAnimalBossBuffInfo then
        self.AnimalBossHurtBuffValue = 0
        self.AnimalBossHurtBuffValueTwo = 0
        self.AnimalBossHurtBuffValue, self.AnimalBossHurtBuffValueTwo = self:CalculationAnimalBossServantBuff()
        self.isGetedAnimalBossBuffInfo = true
    end
    return self.AnimalBossHurtBuffValue, self.AnimalBossHurtBuffValueTwo
end

---计算生肖boss伤害buff显示数据
---@return number number 符合只数 伤害百分比
function LuaGlobalTableDeal:CalculationAnimalBossServantBuff()
    local value, valueTwo = 0, 0
    if CS.CSScene.MainPlayerInfo ~= nil and self.curAddBuffAnimalBossInfo ~= nil then

        local targetLevel, targetReinLevel = 0, 0

        if self.curAddBuffAnimalBossInfo:GetConditionLevel() ~= nil and self.curAddBuffAnimalBossInfo:GetConditionLevel().list ~= nil then
            if self.curAddBuffAnimalBossInfo:GetConditionLevel().list.Count > 0 then
                targetLevel = self.curAddBuffAnimalBossInfo:GetConditionLevel().list[0]
            end
            if self.curAddBuffAnimalBossInfo:GetConditionLevel().list.Count > 1 then
                targetReinLevel = self.curAddBuffAnimalBossInfo:GetConditionLevel().list[1]
            end
        end

        ---获取主角灵兽信息
        local servantInfoList = CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList
        local count = 0
        for i = 0, servantInfoList.Count - 1 do
            ---限制条件
            if servantInfoList[i].cfgId ~= 0 and servantInfoList[i].state ~= 0 then
                if servantInfoList[i].level >= targetLevel and servantInfoList[i].rein >= targetReinLevel then
                    count = count + 1
                end
            end
        end
        local scaleList = nil
        ---获取伤害比例
        if self.curAddBuffAnimalBossInfo:GetConditionRoleLevel() ~= nil and self.curAddBuffAnimalBossInfo:GetConditionRoleLevel().list ~= nil then
            scaleList = self.curAddBuffAnimalBossInfo:GetConditionRoleLevel().list
        end

        if count > 0 and scaleList ~= nil and #scaleList > count then
            value = count
            valueTwo = scaleList[count + 1] / 100
        end
    end
    return value, valueTwo
end

---是否需要刷新此buff
---@return boolean
function LuaGlobalTableDeal:CheckRefreshAnimalBossBuff()
    local value, valueTwo = self:CalculationAnimalBossServantBuff()
    if value ~= self.AnimalBossHurtBuffValue then
        self.isGetedAnimalBossBuffInfo = false
    end
    return value ~= self.AnimalBossHurtBuffValue
end

--endregion

--region 联盟
--region 联盟投票

---联盟投票顶部
function LuaGlobalTableDeal:GetLeagueVoteTops()
    if self.mLeagueVoteTops == nil then
        self.mLeagueVoteTops = {}
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22605)
        if tableInfo then
            local topsInfo = string.Split(tableInfo.value, '&')
            for i = 1, #topsInfo do
                local topInfo = string.Split(topsInfo[i], '#')
                if #topInfo > 4 then
                    table.insert(self.mLeagueVoteTops, {
                        type = tonumber(topInfo[1]),
                        str = topInfo[2],
                        width = tonumber(topInfo[3]),
                        posX = tonumber(topInfo[4]),
                        isShowArrow = tonumber(topInfo[5]) == 1,
                    })
                end
            end
        end
    end
    return self.mLeagueVoteTops
end

--endregion

--region 联盟NPC
---@return number 退出联盟CD
function LuaGlobalTableDeal:GetQuitLeagueCD()
    if self.mQuitLeagueCD == nil then
        self.mQuitLeagueCD = 0
        local tableInfo = self.GetGlobalTabl(22604)
        if tableInfo then
            self.mQuitLeagueCD = tonumber(tableInfo.value)
        end
    end
    return self.mQuitLeagueCD
end

---@return number 每个联盟最大行会数目
function LuaGlobalTableDeal:GetPerLeagueMaxUnionNum()
    if self.mPerLeagueMaxUnionNum == nil then
        local tableInfo = self.GetGlobalTabl(22603)
        if tableInfo then
            self.mPerLeagueMaxUnionNum = tonumber(tableInfo.value)
        end
    end
    return self.mPerLeagueMaxUnionNum
end

---@return table<number,table<>>
function LuaGlobalTableDeal:GetLeagueMapNpcIdList()
    if self.mLeagueMapNpcIdList == nil then
        self.mLeagueMapNpcIdList = {}
        local tableInfo = self.GetGlobalTabl(22602)
        if tableInfo then
            local strs = string.Split(tableInfo.value, '&')
            for i = 1, #strs do
                local info = strs[i]
                local data = string.Split(info, '#')
                if #data >= 2 then
                    local mapNpcInfo = {}
                    mapNpcInfo.Id = tonumber(data[1])
                    mapNpcInfo.MapNpcId = tonumber(data[2])
                    table.insert(self.mLeagueMapNpcIdList, mapNpcInfo)
                end
            end
        end
    end
    return self.mLeagueMapNpcIdList
end
--endregion

--endregion

--region 封印塔
---获取封印塔联盟伤害加成描述内容
---@param rank number 排名
---@return string 伤害加成描述内容
function LuaGlobalTableDeal:GetSealTowerDamageDes(rank)
    if self.sealTowerDamageDesTable == nil then
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22643)
        if tableInfo then
            self.sealTowerDamageDesTable = {}
            local sealTowerDamageDesTable = string.Split(tableInfo.value, '#')
            for k, v in pairs(sealTowerDamageDesTable) do
                self.sealTowerDamageDesTable[k - 1] = v
            end
        end
    end
    if self.sealTowerDamageDesTable ~= nil and type(self.sealTowerDamageDesTable) == 'table' then
        return self.sealTowerDamageDesTable[rank]
    end
end

---获取献祭材料
---@return table 献祭材料数据
---@return number 可献祭次数
function LuaGlobalTableDeal:GetSacrificialMaterial()
    if self.sealTowerSacrificialMaterialsTable == nil then
        self:InitSacrificialMaterials()
    end
    if self.sealTowerSacrificialMaterialsTable ~= nil then
        for k, v in pairs(self.sealTowerSacrificialMaterialsTable) do
            if v ~= nil and v.itemInfo ~= nil then
                local itemInfo = v.itemInfo
                local bagItemCount = 0
                if itemInfo.type == luaEnumItemType.Coin then
                    bagItemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinNum(itemInfo.id)
                else
                    bagItemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCount(itemInfo.id)
                end
                ---可兑换的积分数量
                local integralMaxNum = Utility.GetIntPart(bagItemCount / v.needNum)
                if integralMaxNum > 0 then
                    return v, integralMaxNum
                end
            end
        end
    end

    ---默认返回
    local materialInfo = self.sealTowerSacrificialMaterialsTable[#self.sealTowerSacrificialMaterialsTable]
    return materialInfo, 0
end

---初始化献祭材料信息
function LuaGlobalTableDeal:InitSacrificialMaterials()
    if self.sealTowerSacrificialMaterialsTable == nil then
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22661)
        if tableInfo then
            local materialInfoTable = string.Split(tableInfo.value, '&')
            self.sealTowerSacrificialMaterialsTable = {}
            for k = #materialInfoTable, 1, -1 do
                local singleMaterialInfoTable = string.Split(materialInfoTable[k], '#')
                if singleMaterialInfoTable ~= nil and type(singleMaterialInfoTable) == 'table' and #singleMaterialInfoTable > 7 then
                    local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(tonumber(singleMaterialInfoTable[2]))
                    if itemInfoIsFind == true then
                        local singleMaterial = {}
                        ---类型
                        singleMaterial.type = tonumber(singleMaterialInfoTable[1])
                        singleMaterial.itemId = tonumber(singleMaterialInfoTable[2])
                        singleMaterial.itemInfo = itemInfo
                        ---单次捐献需要材料数量
                        singleMaterial.needNum = tonumber(singleMaterialInfoTable[3])
                        ---单次捐献增加的捐献值
                        singleMaterial.sacrificialValue = tonumber(singleMaterialInfoTable[4])
                        ---按钮文本
                        singleMaterial.btnText = singleMaterialInfoTable[5]
                        ---标题文本
                        singleMaterial.titleName = singleMaterialInfoTable[6]
                        ---捐献是否有上限
                        singleMaterial.haveMaxLimit = tonumber(singleMaterialInfoTable[7]) == 1
                        ---超过可捐献数量显示的气泡id
                        singleMaterial.exceedMaxLimitPopoId = tonumber(singleMaterialInfoTable[8])
                        table.insert(self.sealTowerSacrificialMaterialsTable, singleMaterial)
                    end
                end
            end
        end
    end
end
--endregion

--region 联服开启预告
---获取连服开始提示信息
---@param remainTime number 开始剩余时间
---@return table 提示信息
function LuaGlobalTableDeal:GetLianFuStartNoticeInfo(remainTime)
    if self.lianFuStartNoticeInfoTable == nil then
        self:InitLianFuStartNoticeInfo()
    end
    local lianFuStartNoticeInfo = nil
    if self.lianFuStartNoticeInfoTable ~= nil then
        for k, v in pairs(self.lianFuStartNoticeInfoTable) do
            if v ~= nil and v.remainNoticeTime ~= nil and remainTime <= v.remainNoticeTime then
                lianFuStartNoticeInfo = v
            end
        end
    end
    return lianFuStartNoticeInfo
end

---通过连服开始时间获取连服开始提示信息表
---@param endTime number 连服开始时间(时间戳)
---@return table 提示信息表
function LuaGlobalTableDeal:GetLianFuStartNoticeTableByEndTime(endTime)
    if self.lianFuStartNoticeInfoTable == nil then
        self:InitLianFuStartNoticeInfo()
    end
    if self.lianFuStartNoticeInfoTable ~= nil and type(self.lianFuStartNoticeInfoTable) == 'table' then
        local noticeTable = {}
        for k, v in pairs(self.lianFuStartNoticeInfoTable) do
            local hintEndTime = endTime - v.remainNoticeTime * 1000
            local remainTime = hintEndTime - CS.CSScene.MainPlayerInfo.serverTime
            if remainTime > 0 then
                table.insert(noticeTable, v)
            end
        end
        return noticeTable
    end
end

---初始化连服开始提示信息
function LuaGlobalTableDeal:InitLianFuStartNoticeInfo()
    if self.lianFuStartNoticeInfoTable == nil then
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22664)
        if tableInfo then
            self.lianFuStartNoticeInfoTable = {}
            local singleLianFuStartNoticeInfoTable = string.Split(tableInfo.value, '&')
            for k, v in pairs(singleLianFuStartNoticeInfoTable) do
                local singleLianFuStartNoticTable = string.Split(v, '#')
                if singleLianFuStartNoticTable ~= nil and type(singleLianFuStartNoticTable) == 'table' and #singleLianFuStartNoticTable > 1 then
                    local info = {}
                    info.type = k
                    info.remainNoticeTime = singleLianFuStartNoticTable[1]
                    info.noticeType = tonumber(singleLianFuStartNoticTable[2])
                    info.params = {}
                    for k = 3, #singleLianFuStartNoticTable do
                        if singleLianFuStartNoticTable[k] ~= nil then
                            table.insert(info.params, singleLianFuStartNoticTable[k])
                        end
                    end
                    table.insert(self.lianFuStartNoticeInfoTable, info)
                end
            end
        end
    end
end
--endregion

--region 商会
---获取月卡返利时间
function LuaGlobalTableDeal:GetMonthCardRebateTime()
    if self.mMonthCardRebateTime == nil then
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22550)
        if tableInfo then
            local data = string.Split(tableInfo.value, '#')
            if #data >= 3 then
                self.mMonthCardRebateTime = tonumber(data[3])
            end
        end
    end
    return self.mMonthCardRebateTime
end
--endregion

--region 法宝
---获取法宝套装配置参数
---@return table<LuaEnumMagicEquipSuitType,MagicEquipTypeConfigParams> 法宝装备配置参数
function LuaGlobalTableDeal:GetMagicEquipConfigParams()
    if self.magicEquipConfigParams == nil then
        self:InitMagicEquipConfigParams()
    end
    return self.magicEquipConfigParams
end

---获取法宝套装配置参数
---@param suitType LuaEnumMagicEquipSuitType 法宝装备类型
---@return MagicEquipTypeConfigParams 单个套装法宝配置参数
function LuaGlobalTableDeal:GetMagicEquipConfigParamsBySuitType(suitType)
    if self.magicEquipConfigParams == nil then
        self:InitMagicEquipConfigParams()
    end
    return self.magicEquipConfigParams[suitType]
end

---法宝类型是否已经解锁
---@param suitType LuaEnumMagicEquipSuitType 法宝装备类型
---@return boolean 是否解锁
function LuaGlobalTableDeal:MagicEquipTypeIsUnLock(suitType)
    if suitType == nil then
        return false
    end
    local magicEquipConfigInfo = self:GetMagicEquipConfigParamsBySuitType(suitType)
    if magicEquipConfigInfo == nil or magicEquipConfigInfo.conditonIdTable == nil or type(magicEquipConfigInfo.conditonIdTable) ~= 'table' then
        return false
    end
    return CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(magicEquipConfigInfo.conditonIdTable)
end

---获取法宝底图图片
---@param equipIndex number 装备位
function LuaGlobalTableDeal:GetBaseBackGroundSpriteName(equipIndex)
    local suitType = clientTableManager.cfg_magicweaponManager:AnalysisTypeByEquipIndex(equipIndex)
    local baseEquipIndex = clientTableManager.cfg_magicweaponManager:GetBaseEquipIndexByEquipIndex(equipIndex)
    if suitType ~= nil then
        local magicGlobalConfig = self:GetMagicEquipConfigParamsBySuitType(suitType)
        if magicGlobalConfig ~= nil and magicGlobalConfig.backGroundSpriteNameTable ~= nil then
            return magicGlobalConfig.backGroundSpriteNameTable[baseEquipIndex]
        end
    end
end

---获取玩家可以显示的法宝套装显示数据
---@return table<LuaEnumMagicEquipSuitType,MagicEquipTypeConfigParams> 法宝装备配置参数
function LuaGlobalTableDeal:GetMainPlayerCanShowPage()
    local magicEquipConfigParams = self:GetMagicEquipConfigParams()
    if magicEquipConfigParams ~= nil and type(magicEquipConfigParams) == 'table' and Utility.GetTableCount(magicEquipConfigParams) > 0 then
        local params = {}
        for k, v in pairs(magicEquipConfigParams) do
            if v ~= nil and luaclass.MagicEquipPage:CheckSuitTypePageShowState(v.type) then
                params[k] = v
            end
        end
        self:SortShowPage(params)
        return params
    end
    return nil
end

---页签排序
---@return table<LuaEnumMagicEquipSuitType,MagicEquipTypeConfigParams>
function LuaGlobalTableDeal:SortShowPage(showPageConfigParamsList)
    if type(showPageConfigParamsList) ~= 'table' then
        return
    end
    table.sort(showPageConfigParamsList, function(firstConfigParams, secondConfigParams)
        ---@type MagicEquipTypeConfigParams
        local curFirstConfigParams = firstConfigParams
        ---@type MagicEquipTypeConfigParams
        local curSecondConfigParams = secondConfigParams
        if type(curFirstConfigParams) == 'table' and type(curFirstConfigParams.pageOrder) == 'number' and type(curSecondConfigParams) == 'table' and type(curSecondConfigParams.pageOrder) == 'number' then
            return curFirstConfigParams.pageOrder < curSecondConfigParams.pageOrder
        end
        return true
    end)
    return showPageConfigParamsList
end

---获取其他玩家可以显示的法宝套装的显示数据
function LuaGlobalTableDeal:GetOtherPlayerCanShowPage()
    local magicEquipConfigParams = self:GetMagicEquipConfigParams()
    if magicEquipConfigParams ~= nil and type(magicEquipConfigParams) == 'table' and Utility.GetTableCount(magicEquipConfigParams) > 0 then
        local params = {}
        for k, v in pairs(magicEquipConfigParams) do
            if v ~= nil and (gameMgr:GetOtherPlayerDataMgr():IsShowSuitType(v.type)) then
                params[k] = v
            end
        end
        self:SortShowPage(params)
        return params
    end
    return nil
end

---初始化法宝装备配置参数
function LuaGlobalTableDeal:InitMagicEquipConfigParams()
    self:InitMagicEquipPanelParams()
    self:InitMagicEquipBackGroundSpriteName()
end

---@class MagicEquipTypeConfigParams 法宝类型配置参数
---@field type LuaEnumMagicEquipSuitType 法宝装备类型
---@field pageName string 法宝页签名字
---@field suitCount number 套装最大数量
---@field pageOrder number 页签显示优先级
---@field conditonIdTable table 页签显示条件列表
---@field backGroundSpriteNameTable table<LuaEquipmentItemType,string> 背景图名字列表

---初始化法宝装备面板参数
function LuaGlobalTableDeal:InitMagicEquipPanelParams()
    if self.magicEquipConfigParams == nil then
        self.magicEquipConfigParams = {}
    end
    local tbl = LuaGlobalTableDeal.GetGlobalTabl(22711)
    if tbl == nil then
        return
    end
    local magicEquipTypeParamsTable = string.Split(tbl.value, '&')
    if magicEquipTypeParamsTable == nil then
        return
    end
    for k, v in pairs(magicEquipTypeParamsTable) do
        local singleMagicEquipParamsTable = string.Split(v, '#')
        if singleMagicEquipParamsTable ~= nil and type(singleMagicEquipParamsTable) == 'table' and Utility.GetLuaTableCount(singleMagicEquipParamsTable) > 3 then
            ---@type LuaEnumMagicEquipSuitType 法宝装备类型
            local type = tonumber(singleMagicEquipParamsTable[1])
            ---@type MagicEquipTypeConfigParams
            local configParams = self.magicEquipConfigParams[type]
            if configParams == nil then
                self.magicEquipConfigParams[type] = {}
                configParams = self.magicEquipConfigParams[type]
            end

            ---@type LuaEnumMagicEquipSuitType 法宝装备类型
            configParams.type = tonumber(singleMagicEquipParamsTable[1])
            ---@type string 页签名字
            configParams.pageName = singleMagicEquipParamsTable[2]
            ---@type number 套装最大数量
            configParams.suitCount = tonumber(singleMagicEquipParamsTable[3])
            configParams.pageOrder = tonumber(singleMagicEquipParamsTable[4])
            ---@type table 条件id表
            configParams.conditonIdTable = {}
            for index = 5, Utility.GetLuaTableCount(singleMagicEquipParamsTable) do
                table.insert(configParams.conditonIdTable, tonumber(singleMagicEquipParamsTable[index]))
            end
            self.magicEquipConfigParams[configParams.type] = configParams
        end
    end
end

---初始化法宝装备底图参数
function LuaGlobalTableDeal:InitMagicEquipBackGroundSpriteName()
    if self.magicEquipConfigParams == nil then
        self.magicEquipConfigParams = {}
    end
    local tbl = LuaGlobalTableDeal.GetGlobalTabl(22717)
    if tbl == nil then
        return
    end
    local magicEquipTypeParamsTable = string.Split(tbl.value, '&')
    if magicEquipTypeParamsTable == nil then
        return
    end
    for k, v in pairs(magicEquipTypeParamsTable) do
        local singleMagicEquipBackGroundSpriteNameTable = string.Split(v, '#')
        if singleMagicEquipBackGroundSpriteNameTable ~= nil and type(singleMagicEquipBackGroundSpriteNameTable) == 'table' and Utility.GetLuaTableCount(singleMagicEquipBackGroundSpriteNameTable) > 1 then
            ---@type LuaEnumMagicEquipSuitType 法宝装备类型
            local type = tonumber(singleMagicEquipBackGroundSpriteNameTable[1])
            ---@type MagicEquipTypeConfigParams
            local configParams = self.magicEquipConfigParams[type]
            if configParams == nil then
                self.magicEquipConfigParams[type] = {}
                configParams = self.magicEquipConfigParams[type]
            end
            ---@type LuaEnumMagicEquipSuitType 法宝装备类型
            configParams.type = type
            configParams.backGroundSpriteNameTable = {}
            for k = 2, Utility.GetLuaTableCount(singleMagicEquipBackGroundSpriteNameTable) do
                ---@type LuaEquipmentItemType 法宝基础装备位置
                local baseEquipIndex = 400 + k - 1
                ---@type string 法宝装备背景底图名字
                local backGroundSpriteName = singleMagicEquipBackGroundSpriteNameTable[k]
                configParams.backGroundSpriteNameTable[baseEquipIndex] = backGroundSpriteName
            end
            self.magicEquipConfigParams[type] = configParams
        end
    end
end

---获取套装类型对应的等级最低的套装表id
---@param suitType LuaEnumMagicEquipSuitType 套装类型
---@return number 套装id
function LuaGlobalTableDeal:GetBaseSuitId(suitType)
    if suitType == nil then
        return
    end
    if self.baseSuitIdTable == nil then
        self:InitBaseSuitIdTable()
    end
    if self.baseSuitIdTable ~= nil and self.baseSuitIdTable[suitType] ~= nil then
        return self.baseSuitIdTable[suitType].baseSuitId
    end
end

---初始化基础套装id表
function LuaGlobalTableDeal:InitBaseSuitIdTable()
    if self.baseSuitIdTable == nil then
        local tbl = LuaGlobalTableDeal.GetGlobalTabl(22724)
        if tbl ~= nil then
            self.baseSuitIdTable = {}
            local suitTypeAndSuitIdTable = string.Split(tbl.value, '&')
            if suitTypeAndSuitIdTable ~= nil and Utility.GetTableCount(suitTypeAndSuitIdTable) > 0 then
                for k, v in pairs(suitTypeAndSuitIdTable) do
                    local baseSuitTable = string.Split(v, '#')
                    if baseSuitTable ~= nil and type(baseSuitTable) and Utility.GetTableCount(baseSuitTable) > 1 then
                        local infoTable = {}
                        infoTable.suitType = tonumber(baseSuitTable[1])
                        infoTable.baseSuitId = tonumber(baseSuitTable[2])
                        self.baseSuitIdTable[infoTable.suitType] = infoTable
                    end
                end
            end
        end
    end
end

---是否开启玩家法宝装备按钮
---@param level number 玩家等级
---@return boolean 是否显示法宝装备按钮
function LuaGlobalTableDeal:IsOpenPlayerMagicEquipBtn(level, isMainPlayer)
    if self.openMagicEquipBtnLevel == nil then
        local tbl = LuaGlobalTableDeal.GetGlobalTabl(22722)
        if tbl ~= nil then
            self.openMagicEquipBtnLevel = tonumber(tbl.value)
        end
    end
    if self.openMagicEquipBtnLevel ~= nil and type(self.openMagicEquipBtnLevel) == 'number' then
        if level < self.openMagicEquipBtnLevel then
            return false
        end
    end
    if isMainPlayer == nil then
        isMainPlayer = true
    end
    if isMainPlayer then
        ---主角装备了法宝则显示按钮
        local magicEquipCount = 0
        if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr() ~= nil then
            for i, v in pairs(LuaEnumMagicEquipSuitType) do
                local list = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetMagicEquipListBySuitType(v)
                if list then
                    magicEquipCount = magicEquipCount + list:GetEquipCount()
                end
            end
        end
        --print("main player ", magicEquipCount)
        return magicEquipCount > 0
    else
        ---其他玩家装备了法宝则显示按钮
        local magicEquipCount = 0
        if gameMgr:GetOtherPlayerDataMgr() then
            for i, v in pairs(LuaEnumMagicEquipSuitType) do
                local list = gameMgr:GetOtherPlayerDataMgr():GetMagicEquipListBySuitType(v)
                if list then
                    magicEquipCount = magicEquipCount + list:GetEquipCount()
                end
            end
        end
        --print("other player ", magicEquipCount)
        return magicEquipCount > 0
    end
end
--endregion

--region 礼包
---终身限购礼包开启状态
function LuaGlobalTableDeal:GetLastRechargeOpenConditionState()
    if self.mLastRechargeCondition == nil then
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22738)
        if tableInfo then
            self.mLastRechargeCondition = string.Split(tableInfo.value, '#')
        else
            return false
        end
    end
    return CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(self.mLastRechargeCondition)
end
--endregion

--region 神级boss
---获取神级boss活动时间表id列表
function LuaGlobalTableDeal:GetGodBossActivityTimeIdList()
    if self.mGodBossActivityTimeIdList == nil then
        local data = LuaGlobalTableDeal.GetGlobalTabl(22739)
        if data ~= nil then
            self.mGodBossActivityTimeIdList = string.Split(data.value, '#')
        end
    end
    return self.mGodBossActivityTimeIdList
end
--endregion

--region 小飞鞋
---是否是禁止显示小飞鞋的地图id
---@param mapId number 地图id
---@return boolean 是否禁止显示
function LuaGlobalTableDeal:IsForbidShowFlyShoesMapId(mapId)
    if self.forbidShowFlyShoesMapIdTable == nil then
        local data = LuaGlobalTableDeal.GetGlobalTabl(22740)
        if data ~= nil then
            self.forbidShowFlyShoesMapIdTable = Utility.ChangeNumberTable(string.Split(data.value, '#'))
        end
    end
    if self.forbidShowFlyShoesMapIdTable ~= nil then
        return Utility.IsContainsValue(self.forbidShowFlyShoesMapIdTable, mapId)
    end
    return false
end
--endregion

---得到道具跳转到合成界面的处理
function LuaGlobalTableDeal.GetItemJumpSynthesisData()
    local data = LuaGlobalTableDeal.GetGlobalTabl(22721)
    if data == nil then
        return
    end
    local strList = _fSplit(data.value, "&")
    local allJumpData = {}
    for i, jumpDataStr in pairs(strList) do
        local jumpData = _fSplit(jumpDataStr, "#")
        local itemID = tonumber(jumpData[1])

        local customData = {}
        customData.firstType = tonumber(jumpData[2])
        customData.secondType = tonumber(jumpData[3])
        customData.thirdItemId = tonumber(jumpData[4])

        allJumpData[itemID] = customData
    end
    return allJumpData;
end

--region 灵兽任务

---获取灵兽任务解锁落星位花费信息
---@return <number,number>
function LuaGlobalTableDeal:GetLsMissionLxUnlockCoinInfo()
    if self.mLsMissionLxUnlockCoinInfo == nil then
        self.mLsMissionLxUnlockCoinInfo = {}
        local data = LuaGlobalTableDeal.GetGlobalTabl(22287)
        if data and data.value then
            local goldInfos = string.Split(data.value, '#')
            if #goldInfos > 1 then
                local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(tonumber(goldInfos[1]))
                if itemTbl then
                    self.mLsMissionLxUnlockCoinInfo = {
                        goldId = tonumber(goldInfos[1]),
                        count = tonumber(goldInfos[2]),
                        icon = itemTbl:GetIcon() == nil and '' or itemTbl:GetIcon(),
                        name = itemTbl:GetName() == nil and '' or itemTbl:GetName(),
                    }
                end
            end
        end
    end
    return self.mLsMissionLxUnlockCoinInfo
end

---获取灵兽任务解锁天成位花费信息
---@return <number,number>
function LuaGlobalTableDeal:GetLsMissionTcUnlockCoinInfo()
    if self.mLsMissionTcUnlockCoinInfo == nil then
        self.mLsMissionTcUnlockCoinInfo = {}
        local data = LuaGlobalTableDeal.GetGlobalTabl(22360)
        if data and data.value then
            local goldInfos = string.Split(data.value, '#')
            if #goldInfos > 1 then
                local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(tonumber(goldInfos[1]))
                if itemTbl then
                    self.mLsMissionTcUnlockCoinInfo = {
                        goldId = tonumber(goldInfos[1]),
                        count = tonumber(goldInfos[2]),
                        icon = itemTbl:GetIcon() == nil and '' or itemTbl:GetIcon(),
                        name = itemTbl:GetName() == nil and '' or itemTbl:GetName(),
                    }
                end
            end
        end
    end
    return self.mLsMissionTcUnlockCoinInfo
end

---获取灵兽任务解锁描述信息
---@return <string,string>
function LuaGlobalTableDeal:GetLsMissionUnLockDescription()
    if self.mLsMissionUnLockDescriptionInfo == nil then
        local data = LuaGlobalTableDeal.GetGlobalTabl(22819)
        if data and data.value then
            self.mLsMissionUnLockDescriptionInfo = string.Split(data.value, '#')
        end
    end
    return self.mLsMissionUnLockDescriptionInfo
end
--endregion

--region 推送
---获取单物品推送配置表
---@return table<table> 单个物品推送表
function LuaGlobalTableDeal:GetSingleItemHintConfigTable()
    if self.SingleItemHintConfigTable == nil then
        local data = LuaGlobalTableDeal.GetGlobalTabl(22737)
        if data and data.value then
            local singleItemStrTable = string.Split(data.value, '&')
            if singleItemStrTable ~= nil and #singleItemStrTable > 0 then
                self.SingleItemHintConfigTable = {}
                for k, v in pairs(singleItemStrTable) do
                    local singleItemConfigTable = string.Split(v, '_')
                    if singleItemConfigTable ~= nil and #singleItemConfigTable > 2 then
                        local tbl = {}
                        tbl.itemId = tonumber(singleItemConfigTable[1])
                        ---@type table<LuaEnumBetterItemHintReason> 触发原因条件id表
                        tbl.triggerReasonIdTable = Utility.ChangeNumberTable(string.Split(singleItemConfigTable[2], '#'))
                        ---@type table<number> 推送conditonId表
                        tbl.pushConditionIdTable = Utility.ChangeNumberTable(string.Split(singleItemConfigTable[3], '#'))
                        table.insert(self.SingleItemHintConfigTable, tbl)
                    end
                end
            end
        end
    end
    return self.SingleItemHintConfigTable
end

---@class BetterBagItemHintConfigParams
---@field hintType LuaEnumMainHint_BetterBagItemType
---@field autoClickHintTotalTime number 自动点击提示总时间(秒)

---获取更好道具推送自动点击提示时间
---@param hintType LuaEnumMainHint_BetterBagItemType
---@return number 自动点击提示总时间(秒)
function LuaGlobalTableDeal:GetBetterItemHintAutoClickHintTotalTime(hintType)
    if hintType == nil then
        return
    end
    local betterItemHintConfigList = self:GetBetterItemHintConfigList()
    if type(betterItemHintConfigList) == 'table' and betterItemHintConfigList[hintType] ~= nil then
        return betterItemHintConfigList[hintType].autoClickHintTotalTime
    end
end

---获取自动点击提示配置列表
---@return table<LuaEnumMainHint_BetterBagItemType,BetterBagItemHintConfigParams>
function LuaGlobalTableDeal:GetBetterItemHintConfigList()
    if self.BetterItemHintConfigList == nil then
        self.BetterItemHintConfigList = {}
        local data = LuaGlobalTableDeal.GetGlobalTabl(23002)
        local configParamsList = string.Split(data.value, '&')
        if type(configParamsList) == 'table' then
            for k, v in pairs(configParamsList) do
                local configParams = string.Split(v, '#')
                if type(configParams) == 'table' and #configParams > 1 then
                    ---@type BetterBagItemHintConfigParams
                    local betterBagItemHintConfigParams = {}
                    betterBagItemHintConfigParams.hintType = tonumber(configParams[1])
                    betterBagItemHintConfigParams.autoClickHintTotalTime = tonumber(configParams[2]) / 1000
                    self.BetterItemHintConfigList[betterBagItemHintConfigParams.hintType] = betterBagItemHintConfigParams
                end
            end
        end
    end
    return self.BetterItemHintConfigList
end
--endregion

--region 装备
---获取属性计算系数
---@return table<number>
function LuaGlobalTableDeal.GetAttributeComputingCoefficient()
    if LuaGlobalTableDeal.AttributeComputingCoefficientTable == nil then
        local tbl = LuaGlobalTableDeal.GetGlobalTabl(20176)
        if tbl ~= nil then
            LuaGlobalTableDeal.AttributeComputingCoefficientTable = Utility.ChangeNumberTable(string.Split(tbl.value, '#'))
        end
    end
    return LuaGlobalTableDeal.AttributeComputingCoefficientTable
end
--endregion

--region 白日门活动

--region 白日门猎魔
---获取猎魔最大次数
function LuaGlobalTableDeal.GetTotalHuntCount()
    if LuaGlobalTableDeal.mTotalHuntCount == nil then
        LuaGlobalTableDeal.mTotalHuntCount = 0
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22768)
        if tableInfo and tableInfo.value then
            local tbl = string.Split(tableInfo.value, '#')
            LuaGlobalTableDeal.mTotalHuntCount = tonumber(tbl[4])
        end
    end
    return LuaGlobalTableDeal.mTotalHuntCount
end

--endregion

--region 白日门货运
---初始化押镖通用数据
function LuaGlobalTableDeal.InitYaBiaoCommonData()
    if LuaGlobalTableDeal.YaBiaoCommonTable == nil then
        LuaGlobalTableDeal.YaBiaoCommonTable = {}
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22772)
        if tableInfo and tableInfo.value then
            local commonTable = string.Split(tableInfo.value, '#')
            if type(commonTable) == 'table' and Utility.GetLuaTableCount(commonTable) then
                LuaGlobalTableDeal.YaBiaoCommonTable.YaBiaoMaxNum = tonumber(commonTable[1])
                LuaGlobalTableDeal.YaBiaoCommonTable.PlunderDartMaxNum = tonumber(commonTable[2])
            end
        end
    end
end

---获取押镖总次数
---@return number 押镖总次数
function LuaGlobalTableDeal.GetYaBiaoNumMax()
    if LuaGlobalTableDeal.YaBiaoCommonTable == nil then
        LuaGlobalTableDeal.InitYaBiaoCommonData()
    end
    if LuaGlobalTableDeal.YaBiaoCommonTable ~= nil then
        return LuaGlobalTableDeal.YaBiaoCommonTable.YaBiaoMaxNum
    end
    return 3
end

---获取劫镖总次数
---@return number 劫镖总次数
function LuaGlobalTableDeal.GetPlunderNumMax()
    if LuaGlobalTableDeal.YaBiaoCommonTable == nil then
        LuaGlobalTableDeal.InitYaBiaoCommonData()
    end
    if LuaGlobalTableDeal.YaBiaoCommonTable ~= nil then
        return LuaGlobalTableDeal.YaBiaoCommonTable.PlunderDartMaxNum
    end
end
--endregion
--endregion

--region 珍宝袋
---珍宝袋稀有道具
function LuaGlobalTableDeal.GetTreasureBagRareItemList()
    if LuaGlobalTableDeal.mTreasureBagRareItemList == nil then
        LuaGlobalTableDeal.mTreasureBagRareItemList = 0
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22783)
        if tableInfo and tableInfo.value then
            LuaGlobalTableDeal.mTreasureBagRareItemList = string.Split(tableInfo.value, '#')
        end
    end
    return LuaGlobalTableDeal.mTreasureBagRareItemList
end
--endregion

--region 狂暴药剂
---获取狂暴药剂推送的物品
---@return bagV2.BagItemInfo
function LuaGlobalTableDeal.GetCrazyDrugHintBagItemInfo()
    local drazyDrugItemidList = LuaGlobalTableDeal.GetCrazyDrugItemIdList()
    if type(drazyDrugItemidList) == 'table' then
        for k, v in pairs(drazyDrugItemidList) do
            if type(v) == 'number' then
                local bagItemInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetBagItemInfoByItemId(v)
                if bagItemInfo ~= nil then
                    return bagItemInfo
                end
            end
        end
    end
end

---是否石狂暴药剂
---@param itemId number
---@return boolean
function LuaGlobalTableDeal.IsCrazyDrug(itemId)
    if type(itemId) ~= 'number' then
        return false
    end
    local crazyDrugItemIdList = LuaGlobalTableDeal.GetCrazyDrugItemIdList()
    if type(crazyDrugItemIdList) ~= 'table' then
        return false
    end
    return Utility.IsContainsValue(crazyDrugItemIdList, itemId)
end

---获取狂暴药剂ItemId列表
---@return table<number>
function LuaGlobalTableDeal.GetCrazyDrugItemIdList()
    if LuaGlobalTableDeal.mCrazyDrugItemIdList == nil then
        LuaGlobalTableDeal.mCrazyDrugItemIdList = {}
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22803)
        if tableInfo and tableInfo.value then
            LuaGlobalTableDeal.mCrazyDrugItemIdList = Utility.ChangeNumberTable(string.Split(tableInfo.value, '#'))
        end
    end
    return LuaGlobalTableDeal.mCrazyDrugItemIdList
end

---获取狂暴药剂提示推送限制条件列表
function LuaGlobalTableDeal.GetCrazyDrugHintConditionIdList()
    if LuaGlobalTableDeal.mCrazyDrugHintConditionList == nil then
        LuaGlobalTableDeal.mCrazyDrugHintConditionList = {}
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22804)
        if tableInfo and tableInfo.value then
            LuaGlobalTableDeal.mCrazyDrugHintConditionList = Utility.ChangeNumberTable(string.Split(tableInfo.value, '#'))
        end
    end
    return LuaGlobalTableDeal.mCrazyDrugHintConditionList
end

---获取提示狂暴药剂连击次数
---@return number
function LuaGlobalTableDeal.GetHintCrazyDrugComboAttackNum()
    if LuaGlobalTableDeal.mHintCrazyDrugComboAttackNum == nil then
        LuaGlobalTableDeal.mHintCrazyDrugComboAttackNum = {}
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22809)
        if tableInfo and tableInfo.value then
            LuaGlobalTableDeal.mHintCrazyDrugComboAttackNum = tonumber(tableInfo.value)
        end
    end
    if LuaGlobalTableDeal.mHintCrazyDrugComboAttackNum == nil then
        return 10
    end
    return LuaGlobalTableDeal.mHintCrazyDrugComboAttackNum
end

---获取注册狂暴药剂提示参数_移除buffid列表
---@return table<number>
function LuaGlobalTableDeal.GetRegisterCrazyDrugHitParams_RemoveBuffIdList()
    if LuaGlobalTableDeal.mRegisterCrazyDrugHitParams_RemoveBuffIdList == nil then
        LuaGlobalTableDeal.mRegisterCrazyDrugHitParams_RemoveBuffIdList = {}
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22833)
        if tableInfo and tableInfo.value then
            LuaGlobalTableDeal.mRegisterCrazyDrugHitParams_RemoveBuffIdList = Utility.ChangeNumberTable(string.Split(tableInfo.value, '&'))
        end
    end
    return LuaGlobalTableDeal.mRegisterCrazyDrugHitParams_RemoveBuffIdList
end

---是否是移除buff提示狂暴药剂的buff
---@param buffId number
---@return boolean
function LuaGlobalTableDeal.IsRemoveBuffIdListCrazyDrugHintParams(buffId)
    local buffIdList = LuaGlobalTableDeal.GetRegisterCrazyDrugHitParams_RemoveBuffIdList()
    if type(buffIdList) ~= 'table' then
        return false
    end
    return Utility.IsContainsValue(buffIdList, buffId)
end
--endregion

--region 篝火
---喝酒推送限制条件
---@return table<number>
function LuaGlobalTableDeal.DrinkWineHintConditionIdList()
    if LuaGlobalTableDeal.mDrinkWineHintConditionIdList == nil then
        LuaGlobalTableDeal.mDrinkWineHintConditionIdList = {}
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22810)
        if tableInfo and tableInfo.value then
            LuaGlobalTableDeal.mDrinkWineHintConditionIdList = Utility.ChangeNumberTable(string.Split(tableInfo.value, '#'))
        end
    end
    return LuaGlobalTableDeal.mDrinkWineHintConditionIdList
end
--endregion

--region 特殊活动
---@class RewardItemInfo 通用活动奖励类型
---@field mItemID number itemId/boxId
---@field mNum number 奖励数目

--region 占领皇宫
---@return table<number,RewardItemInfo>参与奖励
function LuaGlobalTableDeal:GetSpecialActivity_SBKJoinRewardList()
    if self.mSpecialActivity_SBKJoinReward == nil then
        self.mSpecialActivity_SBKJoinReward = self:GetIntListListTypeRewardTblData(22816)
    end
    return self.mSpecialActivity_SBKJoinReward
end

---@return table<number,RewardItemInfo>获胜奖励
function LuaGlobalTableDeal:GetSpecialActivity_SBKWinRewardList()
    if self.mSpecialActivity_SBKWinReward == nil then
        self.mSpecialActivity_SBKWinReward = self:GetIntListListTypeRewardTblData(22815)
    end
    return self.mSpecialActivity_SBKWinReward
end
--endregion
--endregion

---获取通用IntListList类型奖励(仅有奖励id和数目)表数据
---@return table<number,RewardItemInfo>
function LuaGlobalTableDeal:GetIntListListTypeRewardTblData(globalId)
    local rewardList = {}
    if globalId == nil or globalId <= 0 then
        return rewardList
    end

    local info = self.GetGlobalTabl(globalId)
    if info then
        local strs = string.Split(info.value, '&')
        for i = 1, #strs do
            local singleData = strs[i]
            local singleInfos = string.Split(singleData, '#')
            if #singleInfos >= 2 then
                ---@type RewardItemInfo
                local singleReward = {}
                singleReward.mItemID = singleInfos[1]
                singleReward.mNum = singleInfos[2]
                table.insert(rewardList, singleReward)
            end
        end
    end
    return rewardList
end

---获取通用单个数目数据
function LuaGlobalTableDeal:GetSingleNumber(globalId)
    local num = 0
    local info = self.GetGlobalTabl(globalId)
    if info then
        num = tonumber(info.value)
    end
    return num
end

--region 物品使用
---@class UseItemOpenSecondConfirmPanelItem
---@field itemId number 物品id
---@field promptWordId number 二次确认表id
---@field conditionIdList table<number> 条件id表

---获取使用物品打开二次确认面板的物品列表
---@return table<number,UseItemOpenSecondConfirmPanelItem>
function LuaGlobalTableDeal.GetUseItemOpenSecondConfirmPanelItemList()
    if LuaGlobalTableDeal.mUseItemOpenSecondConfirmPanelItemList ~= nil then
        return LuaGlobalTableDeal.mUseItemOpenSecondConfirmPanelItemList
    end
    local info = LuaGlobalTableDeal.GetGlobalTabl(22824)
    if info ~= nil then
        local strTable = string.Split(info.value, '&')
        if type(strTable) == 'table' then
            LuaGlobalTableDeal.mUseItemOpenSecondConfirmPanelItemList = {}
            for k, v in pairs(strTable) do
                ---@type UseItemOpenSecondConfirmPanelItem
                local tbl = {}
                local params = string.Split(v, '#')
                if type(params) == 'table' and Utility.GetLuaTableCount(params) > 2 then
                    tbl.itemId = tonumber(Utility.GetAndRemoveTableValue(params, 1))
                    tbl.promptWordId = tonumber(Utility.GetAndRemoveTableValue(params, 1))
                    tbl.conditionIdList = Utility.ChangeNumberTable(params)
                    LuaGlobalTableDeal.mUseItemOpenSecondConfirmPanelItemList[tbl.itemId] = tbl
                end
            end
        end
    end
    return LuaGlobalTableDeal.mUseItemOpenSecondConfirmPanelItemList
end

---获取使用物品打开二次确认面板的物品
---@param itemId number
---@return UseItemOpenSecondConfirmPanelItem
function LuaGlobalTableDeal.GetUseItemOpenSecondConfirmPanelItem(itemId)
    if type(itemId) ~= 'number' then
        return
    end
    local UseItemOpenSecondConfirmPanelItemList = LuaGlobalTableDeal.GetUseItemOpenSecondConfirmPanelItemList()
    if type(UseItemOpenSecondConfirmPanelItemList) ~= 'table' then
        return
    end
    return UseItemOpenSecondConfirmPanelItemList[itemId]
end

---物品是否需要打开二次确认面板
---@param itemId number
---@return number/nil 二次确认表id
function LuaGlobalTableDeal.ItemNeedOpenSecondConfirmPanel(itemId)
    local useItemOpenSecondConfirmPanelItem = LuaGlobalTableDeal.GetUseItemOpenSecondConfirmPanelItem(itemId)
    if useItemOpenSecondConfirmPanelItem == nil then
        return
    end
    local conditionResult = Utility.IsMainPlayerMatchConditionList_AND(useItemOpenSecondConfirmPanelItem.conditionIdList)
    if conditionResult == nil or conditionResult.success == false then
        return
    end
    return useItemOpenSecondConfirmPanelItem.promptWordId
end
--endregion

---得到投资期数花费列表
---@return table<number,number>
function LuaGlobalTableDeal.GetInvestmentPriceList()
    if LuaGlobalTableDeal.mInvestmentPriceList == nil then
        LuaGlobalTableDeal.mInvestmentPriceList = {}
        local data = LuaGlobalTableDeal.GetGlobalTabl(22822)
        if data == nil then
            return
        end
        local str = string.Split(data.value, '&')
        for i, v in pairs(str) do
            table.insert(LuaGlobalTableDeal.mInvestmentPriceList, tonumber(v))
        end
    end
    return LuaGlobalTableDeal.mInvestmentPriceList
end

--region 灵兽法宝
---@class ServantMagicEquipDefaultEquip
---@field equipIndex number
---@field itemId number
---@field conditionIdList table<number>


---获取灵兽法宝默认装备列表
---@return table<number,ServantMagicEquipDefaultEquip>
function LuaGlobalTableDeal.GetServantMagicEquipDefaultEquipList()
    if LuaGlobalTableDeal.mServantMagicEquipDefaultEquipList ~= nil then
        return LuaGlobalTableDeal.mServantMagicEquipDefaultEquipList
    end
    local info = LuaGlobalTableDeal.GetGlobalTabl(22826)
    if info ~= nil then
        local strTable = string.Split(info.value, '&')
        if type(strTable) == 'table' then
            LuaGlobalTableDeal.mServantMagicEquipDefaultEquipList = {}
            for k, v in pairs(strTable) do
                ---@type ServantMagicEquipDefaultEquip
                local tbl = {}
                local params = string.Split(v, '#')
                if type(params) == 'table' and Utility.GetLuaTableCount(params) > 2 then
                    tbl.equipIndex = tonumber(Utility.GetAndRemoveTableValue(params, 1))
                    tbl.itemId = tonumber(Utility.GetAndRemoveTableValue(params, 1))
                    tbl.conditionIdList = Utility.ChangeNumberTable(params)
                    LuaGlobalTableDeal.mServantMagicEquipDefaultEquipList[tbl.equipIndex] = tbl
                end
            end
        end
    end
    return LuaGlobalTableDeal.mServantMagicEquipDefaultEquipList
end

---@param equipIndex number
---@return ServantMagicEquipDefaultEquip
function LuaGlobalTableDeal.GetServantMagicEquipDefaultEquipInfo(equipIndex)
    if type(equipIndex) ~= 'number' then
        return
    end
    local ServantMagicEquipDefaultEquipList = LuaGlobalTableDeal.GetServantMagicEquipDefaultEquipList()
    if type(ServantMagicEquipDefaultEquipList) ~= 'table' then
        return
    end
    return ServantMagicEquipDefaultEquipList[equipIndex]
end

---是否是灵兽默认法宝
---@param itemId number
---@return boolean
function LuaGlobalTableDeal.IsServantDefaultMagicEquip(itemId)
    if type(itemId) ~= 'number' then
        return false
    end
    local ServantMagicEquipDefaultEquipList = LuaGlobalTableDeal.GetServantMagicEquipDefaultEquipList()
    if type(ServantMagicEquipDefaultEquipList) ~= 'table' then
        return false
    end
    for k, v in pairs(ServantMagicEquipDefaultEquipList) do
        if v ~= nil and v.itemId == itemId then
            return true
        end
    end
    return false
end
--endregion

--region 人物功能页签
---@class UIRolePanelTagPanelConfigParams
---@field leftTagType LuaEnumLeftTagType
---@field order number

---获取角色左侧标签面板配置参数列表
---@return table<LuaEnumLeftTagType,UIRolePanelTagPanelConfigParams>
function LuaGlobalTableDeal.GetUIRolePanelTagPanelConfigParamsList()
    if LuaGlobalTableDeal.mUIRolePanelTagPanelConfigParamsList ~= nil then
        return LuaGlobalTableDeal.mUIRolePanelTagPanelConfigParamsList
    end
    local info = LuaGlobalTableDeal.GetGlobalTabl(22828)
    if info ~= nil then
        local strTable = string.Split(info.value, '&')
        if type(strTable) == 'table' then
            LuaGlobalTableDeal.mUIRolePanelTagPanelConfigParamsList = {}
            for k, v in pairs(strTable) do
                ---@type UIRolePanelTagPanelConfigParams
                local tbl = {}
                local params = string.Split(v, '#')
                if type(params) == 'table' and Utility.GetLuaTableCount(params) > 1 then
                    tbl.leftTagType = tonumber(params[1])
                    tbl.order = tonumber(params[2])
                    LuaGlobalTableDeal.mUIRolePanelTagPanelConfigParamsList[tbl.leftTagType] = tbl
                end
            end
        end
    end
    return LuaGlobalTableDeal.mUIRolePanelTagPanelConfigParamsList
end

---获取排序后的左侧页签id列表
---@param originLeftTagIdList table<LuaEnumLeftTagType> 原始左侧页签id列表
---@return table<LuaEnumLeftTagType> 排序后的左侧页签id列表
function LuaGlobalTableDeal.GetSortLeftTagIdList(originLeftTagIdList)
    if type(originLeftTagIdList) ~= 'table' then
        return {}
    end
    local UIRolePanelTagPanelConfigParamsList = LuaGlobalTableDeal.GetUIRolePanelTagPanelConfigParamsList()
    if type(UIRolePanelTagPanelConfigParamsList) ~= 'table' or Utility.GetTableCount(UIRolePanelTagPanelConfigParamsList) <= 0 then
        return {}
    end
    local sortList = {}
    for k, v in pairs(originLeftTagIdList) do
        ---未配置order的情况下默认order是999
        local sortParams = {}
        sortParams.leftTagType = v
        sortParams.order = 999

        if UIRolePanelTagPanelConfigParamsList[v] ~= nil then
            sortParams.order = UIRolePanelTagPanelConfigParamsList[v].order
        end
        table.insert(sortList, sortParams)
    end
    table.sort(sortList, function(firstSortParams, secondSortParams)
        return firstSortParams.order < secondSortParams.order
    end)
    local sortLeftTagIdList = {}
    for k, v in pairs(sortList) do
        if v ~= nil and v.leftTagType ~= nil then
            table.insert(sortLeftTagIdList, v.leftTagType)
        end
    end
    return sortLeftTagIdList
end
--endregion

---获取intlistjinghao类型数据
function LuaGlobalTableDeal.GetIntListJingHaoTypeList(globalId)
    local data = LuaGlobalTableDeal.GetGlobalTabl(globalId)
    if data then
        return string.Split(data.value, '#')
    end
end

---GetLianZhiGongXunCondition
function LuaGlobalTableDeal.GetLianZhiGongXunCondition()
    if LuaGlobalTableDeal.mLianZhiGongXunCondition == nil then
        LuaGlobalTableDeal.mLianZhiGongXunCondition = {}
        local data = LuaGlobalTableDeal.GetGlobalTabl(22831)
        if data then
            local tempSet = string.Split(data.value, '&')
            for i, v in pairs(tempSet) do
                local strS = string.Split(v, '#')
                if #strS >= 2 then
                    local tableData = {
                        ---限制ID
                        conditionID = tonumber(strS[1]),
                        ---气泡Id
                        propID = tonumber(strS[2])
                    }
                    --  print(tableData.conditionID, tableData.propID)
                    table.insert(LuaGlobalTableDeal.mLianZhiGongXunCondition, tableData)
                end
            end
        end
    end
    return LuaGlobalTableDeal.mLianZhiGongXunCondition
end

--region 武道会
---获取武道会地图id列表
---@return table<number>
function LuaGlobalTableDeal.GetWuDaoHuiMapIdList()
    if LuaGlobalTableDeal.mWuDaoHuiMapIdList ~= nil then
        return LuaGlobalTableDeal.mWuDaoHuiMapIdList
    end
    local info = LuaGlobalTableDeal.GetGlobalTabl(22837)
    if info ~= nil then
        LuaGlobalTableDeal.mWuDaoHuiMapIdList = Utility.ChangeNumberTable(string.Split(info.value, '#'))
    end
    return LuaGlobalTableDeal.mWuDaoHuiMapIdList
end

---是否是武道会地图id
---@param mapId number
---@return boolean
function LuaGlobalTableDeal.IsWuDaoHuiMapId(mapId)
    local wuDaoHuiMapIdList = LuaGlobalTableDeal.GetWuDaoHuiMapIdList()
    if type(wuDaoHuiMapIdList) ~= 'table' then
        return false
    end
    return Utility.IsContainsValue(wuDaoHuiMapIdList, mapId)
end
--endregion

--region限时活动限购礼包

---获取限时礼包
function LuaGlobalTableDeal.GetTotalSpeciallyPreferentialCount()
    if LuaGlobalTableDeal.mTotalSpeciallyPreferentialCount == nil then
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22850)
        if tableInfo ~= nil and tableInfo.value ~= nil then
            LuaGlobalTableDeal.mTotalSpeciallyPreferentialCount = tonumber(tableInfo.value)
        end
        if LuaGlobalTableDeal.mTotalSpeciallyPreferentialCount == nil then
            LuaGlobalTableDeal.mTotalSpeciallyPreferentialCount = 3
        end
    end
    return LuaGlobalTableDeal.mTotalSpeciallyPreferentialCount
end


--endregion

---得到马牌限制列表
---@return table<number,number>
function LuaGlobalTableDeal.GetMaPaiOpenLimit()
    if LuaGlobalTableDeal.mMaPaiOpenLimitIDList == nil then
        LuaGlobalTableDeal.mMaPaiOpenLimitIDList = {}
        local data = LuaGlobalTableDeal.GetGlobalTabl(22845)
        if data == nil then
            return
        end
        local str = string.Split(data.value, '&')
        for i, v in pairs(str) do
            table.insert(LuaGlobalTableDeal.mMaPaiOpenLimitIDList, tonumber(v))
        end
    end
    return LuaGlobalTableDeal.mMaPaiOpenLimitIDList
end

--region 塔罗暗殿
---获取使用塔罗牌描述内容
---@return string
function LuaGlobalTableDeal.GetUseTowerCardNumDes()
    if LuaGlobalTableDeal.mUseTowerCardNumDes == nil then
        local data = LuaGlobalTableDeal.GetGlobalTabl(22856)
        if data == nil then
            return ""
        end
        LuaGlobalTableDeal.mUseTowerCardNumDes = data.value
    end
    return LuaGlobalTableDeal.mUseTowerCardNumDes
end

---获取使用塔罗牌描述内容
---@return string
function LuaGlobalTableDeal.GetBlessedNumDes()
    if LuaGlobalTableDeal.mBlessedNumDes == nil then
        local data = LuaGlobalTableDeal.GetGlobalTabl(22857)
        if data == nil then
            return ""
        end
        LuaGlobalTableDeal.mBlessedNumDes = data.value
    end
    return LuaGlobalTableDeal.mBlessedNumDes
end
--endregion

--region 累充（领奖）
---累充活动开启状态
function LuaGlobalTableDeal:GetAccumulatedRechargeConditionState()
    if self.mAccumulatedRechargeConditionState == nil then
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22862)
        if tableInfo then
            self.mAccumulatedRechargeConditionState = string.Split(tableInfo.value, '#')
        else
            return false
        end
    end
    return Utility.IsMainPlayerMatchConditionList_AND(self.mAccumulatedRechargeConditionState).success
end

---换算充值钻石比例
---@return number RMB数目
function LuaGlobalTableDeal:GetRMBToRechargeDiamondRate(diamondNum)
    if diamondNum == nil then
        return
    end
    if self.mRechargeDiamondRate == nil then
        self:DealDiamondRate()
    end
    if self.mRechargeDiamondRate == nil then
        return
    end
    return math.ceil(diamondNum / self.mRechargeDiamondRate)
end

---换算补偿钻石比例
---@return number RMB数目
function LuaGlobalTableDeal:GetRMBToReimburseDiamondRate(diamondNum)
    if diamondNum == nil then
        return
    end
    if self.mReimburseDiamondRate == nil then
        self:DealDiamondRate()
    end
    if self.mReimburseDiamondRate == nil then
        return
    end
    return math.ceil(diamondNum / self.mReimburseDiamondRate)
end

---读表
function LuaGlobalTableDeal:DealDiamondRate()
    --充值时人民币兑换钻石比例，两种：补偿钻石#充值钻石，不支持小数
    local info = self.GetGlobalTabl(20522)
    if info then
        local str = string.Split(info.value, '#')
        if str and #str >= 2 then
            self.mReimburseDiamondRate = tonumber(str[1])
            self.mRechargeDiamondRate = tonumber(str[2])
        end
    end
end
--endregion

--region 仓库
---@class WarehouseAddSpaceConfigParams 仓库增加空间配置参数
---@field costItemId number 需要花费的道具id
---@field costNum number 需要花费的数量

---获取仓库增加空间配置参数
---@return WarehouseAddSpaceConfigParams
function LuaGlobalTableDeal:GetWarehouseAddSpaceConfigParams()
    if LuaGlobalTableDeal.mWarehouseAddSpaceConfigParams ~= nil then
        return LuaGlobalTableDeal.mWarehouseAddSpaceConfigParams
    end
    local data = LuaGlobalTableDeal.GetGlobalTabl(22871)
    if data ~= nil then
        local configParams = string.Split(data.value, '#')
        if type(configParams) == 'table' and Utility.GetTableCount(configParams) > 1 then
            local costItemId = tonumber(configParams[1])
            local costNum = tonumber(configParams[2])

            ---@type WarehouseAddSpaceConfigParams
            LuaGlobalTableDeal.mWarehouseAddSpaceConfigParams = {}
            LuaGlobalTableDeal.mWarehouseAddSpaceConfigParams.costItemId = costItemId
            LuaGlobalTableDeal.mWarehouseAddSpaceConfigParams.costNum = costNum
        end
    end
    return LuaGlobalTableDeal.mWarehouseAddSpaceConfigParams
end
--endregion

--region 狂暴之力
---狂暴之力限制
function LuaGlobalTableDeal.GetRageConditionID()
    if LuaGlobalTableDeal.mRageConditionID == nil then
        LuaGlobalTableDeal.mRageConditionID = 0
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22882)
        if tableInfo then
            local info = string.Split(tableInfo.value, '#')
            if info and #info > 0 then
                LuaGlobalTableDeal.mRageConditionID = tonumber(info[1])
            end
        end
    end
    return LuaGlobalTableDeal.mRageConditionID
end
--endregion

---得到练功房任务显示特效任务ID
function LuaGlobalTableDeal.GetLianGongFangEffectTaskList()
    if LuaGlobalTableDeal.mGetLianGongFangTaskEffect == nil then
        LuaGlobalTableDeal.mGetLianGongFangTaskEffect = {}
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22910)
        if tableInfo then
            local temp = string.Split(tableInfo.value, '&')
            for i, v in pairs(temp) do
                table.insert(LuaGlobalTableDeal.mGetLianGongFangTaskEffect, string.Split(v, '#'))
            end
        end
    end
    return LuaGlobalTableDeal.mGetLianGongFangTaskEffect
end

---得到回收任务ID
function LuaGlobalTableDeal.GetHuiShouEffectTaskIList()
    if LuaGlobalTableDeal.mGetHuiShouEffectTaskIList == nil then
        LuaGlobalTableDeal.mGetHuiShouEffectTaskIList = {}
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22911)
        if tableInfo then
            LuaGlobalTableDeal.mGetHuiShouEffectTaskIList = string.Split(tableInfo.value, '#')
        end
    end
    return LuaGlobalTableDeal.mGetHuiShouEffectTaskIList
end

---得到幫會任务ID
function LuaGlobalTableDeal.GetBangHuiEffectTaskIList()
    if LuaGlobalTableDeal.mBangHuiEffectTaskIList == nil then
        LuaGlobalTableDeal.mBangHuiEffectTaskIList = {}
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(23014)
        if tableInfo then
            LuaGlobalTableDeal.mBangHuiEffectTaskIList = string.Split(tableInfo.value, '#')
        end
    end
    return LuaGlobalTableDeal.mBangHuiEffectTaskIList
end

--region 个人boss

function LuaGlobalTableDeal.GetNeedItemAndCountByBossId(bossId)
    return LuaGlobalTableDeal.GetBossNeedItemDic()[bossId]
end

---获取个人boss花费
---@param bossId number boss表id
---@return Cost
function LuaGlobalTableDeal.GetNeedItemAndCountByBossId_Cost(bossId)
    local globalBossCost = LuaGlobalTableDeal.GetNeedItemAndCountByBossId(bossId)
    if globalBossCost ~= nil then
        ---@type Cost
        local Cost = {}
        Cost.itemId = globalBossCost.itemId
        Cost.costNum = globalBossCost.count
        return Cost
    end
end

function LuaGlobalTableDeal.GetBossNeedItemDic()
    if LuaGlobalTableDeal.mBossNeedItemDic == nil then
        LuaGlobalTableDeal.mBossNeedItemDic = {}
        local tableInfo = LuaGlobalTableDeal.GetGlobalTabl(22891)
        if tableInfo then
            local info = string.Split(tableInfo.value, '&')
            if info then
                for i = 1, #info do
                    local needInfo = string.Split(info[i], '#')
                    if #needInfo > 2 then
                        LuaGlobalTableDeal.mBossNeedItemDic[tonumber(needInfo[1])] = {
                            itemId = tonumber(needInfo[2]),
                            count = tonumber(needInfo[3])
                        }
                    end
                end
            end
        end
    end
    return LuaGlobalTableDeal.mBossNeedItemDic
end


--endregion

--region自动回收
---@return number 获得开启回收的格子数据
function LuaGlobalTableDeal:GetAutoRecycleBagGridNum()
    if self.mAutoRecycleBagGrid == nil then
        self:GetAutoRecycleData()
    end
    return self.mAutoRecycleBagGrid
end

---@return number 玩家开启自动回收的会员等级
function LuaGlobalTableDeal:GetAutoRecyclePlayerCondition()
    if self.mAutoRecycleCondition == nil then
        self:GetAutoRecycleData()
    end
    return self.mAutoRecycleCondition
end

---获取自动回收数据
function LuaGlobalTableDeal:GetAutoRecycleData()
    local recycleInfo = self.GetGlobalTabl(22913)
    if recycleInfo then
        local strs = string.Split(recycleInfo.value, '#')
        if #strs >= 2 then
            self.mAutoRecycleCondition = tonumber(strs[1])
            self.mAutoRecycleBagGrid = tonumber(strs[2])
        end
    end
end
--endregion

---@public 获取灯芯显示的等阶宝物ID
---@return table<number, number>
function LuaGlobalTableDeal:GetLightComponentIds()
    if (self.mLightComponentIds == nil) then
        self.mLightComponentIds = {};
        local globalTable = LuaGlobalTableDeal.GetGlobalTabl(22925);
        if (globalTable ~= nil) then
            local levelAndIds = string.Split(globalTable.value, "&");
            if (levelAndIds ~= nil) then
                for k, v in pairs(levelAndIds) do
                    local levelAndId = string.Split(v, "#");
                    if (#levelAndIds > 1) then
                        local level = tonumber(levelAndId[1]);
                        local id = tonumber(levelAndId[2]);
                        table.insert(self.mLightComponentIds, id);
                    end
                end
            end
        end
    end
    return self.mLightComponentIds;
end

---@public 获取宝石显示的等阶宝物ID
---@return table<number, number>
function LuaGlobalTableDeal:GetGemComponentIds()
    if (self.mGemComponentIds == nil) then
        self.mGemComponentIds = {};
        local globalTable = LuaGlobalTableDeal.GetGlobalTabl(22927);
        if (globalTable ~= nil) then
            local levelAndIds = string.Split(globalTable.value, "&");
            if (levelAndIds ~= nil) then
                for k, v in pairs(levelAndIds) do
                    local levelAndId = string.Split(v, "#");
                    if (#levelAndIds > 1) then
                        local level = tonumber(levelAndId[1]);
                        local id = tonumber(levelAndId[2]);
                        table.insert(self.mGemComponentIds, id);
                    end
                end
            end
        end
    end
    return self.mGemComponentIds;
end

---@public 获取魂玉显示的等阶宝物ID
---@return table<number, number>
function LuaGlobalTableDeal:GetSoulJadeComponentIds()
    if (self.mSoulJadeComponentIds == nil) then
        self.mSoulJadeComponentIds = {};
        local globalTable = LuaGlobalTableDeal.GetGlobalTabl(22926);
        if (globalTable ~= nil) then
            local levelAndIds = string.Split(globalTable.value, "&");
            if (levelAndIds ~= nil) then
                for k, v in pairs(levelAndIds) do
                    local levelAndId = string.Split(v, "#");
                    if (#levelAndIds > 1) then
                        local level = tonumber(levelAndId[1]);
                        local id = tonumber(levelAndId[2]);
                        table.insert(self.mSoulJadeComponentIds, id);
                    end
                end
            end
        end
    end
    return self.mSoulJadeComponentIds;
end

---@class ReinPanelShowItemParams
---@field conditionId number 条件ID
---@field itemId number 道具ID
---@field transferId number 跳转ID
---@field effectId number 特效ID
---@private 转生界面展示的物品信息字典
---@type table<number, ReinPanelShowItemParams>
LuaGlobalTableDeal.mReinPanelShowItemDataDic = nil;

---@public 获得转生面板展示的物品信息
---@param itemId number
---@return ReinPanelShowItemParams
function LuaGlobalTableDeal:GetReinPanelShowItemData(itemId)
    if (self.mReinPanelShowItemDataDic == nil) then
        self.mReinPanelShowItemDataDic = {};

        local globalId = 22955;
        local globalTbl = LuaGlobalTableDeal.GetGlobalTabl(globalId);
        if (globalTbl ~= nil) then
            local dataStrings = string.Split(globalTbl.value, "&");
            for k, v in pairs(dataStrings) do
                local conditionIdAndItemId = string.Split(v, "#");
                if (#conditionIdAndItemId >= 4) then
                    ---@type ReinPanelShowItemParams
                    local params = {};
                    params.conditionId = tonumber(conditionIdAndItemId[1]);
                    params.itemId = tonumber(conditionIdAndItemId[2]);
                    params.transferId = tonumber(conditionIdAndItemId[3]);
                    params.effectId = tonumber(conditionIdAndItemId[4]);
                    self.mReinPanelShowItemDataDic[params.itemId] = params;
                end
            end
        end
    end

    if (itemId ~= nil) then
        return self.mReinPanelShowItemDataDic[itemId];
    else
        return self.mReinPanelShowItemDataDic;
    end
end

--region 设置
---获取等级变动设置小地图显示boss出生点toggle的conditionId列表
---@return table<number>
function LuaGlobalTableDeal.GetLevelChangeSetMapBossBornToggleConditionList()
    if type(LuaGlobalTableDeal.LevelChangeSetMapBossBornToggleConditionList) ~= 'table' then
        local globalTbl = LuaGlobalTableDeal.GetGlobalTabl(22956)
        if globalTbl ~= nil then
            LuaGlobalTableDeal.LevelChangeSetMapBossBornToggleConditionList = Utility.ChangeNumberTable(string.Split(globalTbl.value, '#'))
        end
    end
    return LuaGlobalTableDeal.LevelChangeSetMapBossBornToggleConditionList
end
--endregion

---@public 获得死亡界面下面按钮的显示条件
---@return table<number, number>
function LuaGlobalTableDeal:GetDeadPanelOtherBtnShowConditions()
    if (self.mDeadPanelOtherBtnShowConditions == nil) then
        self.mDeadPanelOtherBtnShowConditions = {};
        local globalId = 22957;
        local globalTbl = self.GetGlobalTabl(globalId);
        if (globalTbl ~= nil) then
            local conditionStrings = string.Split(globalTbl.value, "#");
            if (conditionStrings ~= nil) then
                for k, v in pairs(conditionStrings) do
                    table.insert(self.mDeadPanelOtherBtnShowConditions, tonumber(v));
                end
            end
        end
    end
    return self.mDeadPanelOtherBtnShowConditions;
end

---@class DeadPanelOtherButtonData
---@field type number 按钮类型
---@field iconName string 按钮图片名
---@field transferId number 跳转ID
---@public 获得死亡面板跳转按钮的数据
---@param type number
---@return DeadPanelOtherButtonData
function LuaGlobalTableDeal:GetDeadPanelOtherButtonData(type)
    if (self.mDeadPanelOtherButtonDataDic == nil) then
        self.mDeadPanelOtherButtonDataDic = {};
        local globalId = 22958;
        local globalTbl = self.GetGlobalTabl(globalId);
        if (globalTbl ~= nil) then
            local dataStrings = string.Split(globalTbl.value, "&");
            if (dataStrings ~= nil) then
                for k, v in pairs(dataStrings) do
                    local typeAndNameAndId = string.Split(v, "#");
                    if (#typeAndNameAndId >= 3) then
                        local tempType = tonumber(typeAndNameAndId[1]);
                        local iconName = typeAndNameAndId[2];
                        local transferId = tonumber(typeAndNameAndId[3]);
                        self.mDeadPanelOtherButtonDataDic[tempType] = { type = tempType, iconName = iconName, transferId = transferId };
                    end
                end
            end
        end
    end
    return self.mDeadPanelOtherButtonDataDic[type];
end

--region 行会
---@return number 个人红包最大钻石数目
function LuaGlobalTableDeal:GetPersonalRedPackMaxDiamondNum()
    if self.mPersonalPackDiamondMaxNum == nil then
        self.mPersonalPackDiamondMaxNum = self:GetSingleNumber(22961)

    end
    return self.mPersonalPackDiamondMaxNum
end

---@return number 个人红包数量下限
function LuaGlobalTableDeal:GetPersonalRedPackMinNum()
    if self.mPersonalPackMinPackNum == nil then
        self.mPersonalPackMinPackNum = self:GetSingleNumber(22963)

    end
    return self.mPersonalPackMinPackNum
end

---@return number 可领红包条件
function LuaGlobalTableDeal:GetPersonalRedPackRewardCondition()
    if self.mPersonalPackRewardCondition == nil then
        self.mPersonalPackRewardCondition = self:GetSingleNumber(22962)
    end
    return self.mPersonalPackRewardCondition
end

--endregion

--region 藏品
---主角是否开启藏品(最上层的基础藏品开启，玩家等级或转生等级）
---@return boolean,string,string,string 开启状态，未开启的气泡文本描述，未开启的图片名,未开启的图片后缀名
function LuaGlobalTableDeal:MainPlayerIsOpenCollection()
    if self.mMainPlayerIsOpenCollection == nil then
        self.mMainPlayerIsOpenCollection = {}
        local tbl = self.GetGlobalTabl(22968)
        self.mMainPlayerIsOpenCollection = Utility.ChangeNumberTable(string.Split(tbl.value, '#'))
    end
    local isOpen, popoStr, spriteName, spriteNameDes = true, "系统未开启", "", ""
    if type(self.mMainPlayerIsOpenCollection) == 'table' and #self.mMainPlayerIsOpenCollection > 1 then
        spriteName = self.mMainPlayerIsOpenCollection[1]
        local conditionId = self.mMainPlayerIsOpenCollection[2]
        local mainPlayerResult = Utility.IsMainPlayerMatchCondition_LuaAndCS(conditionId)
        isOpen = mainPlayerResult.success
        spriteNameDes = mainPlayerResult.txt
    end
    return isOpen, popoStr, spriteName, spriteNameDes
end
--endregion

--region 特戒
function LuaGlobalTableDeal.GetRingSecRewardDic()
    if LuaGlobalTableDeal.mRingSecRewardDic == nil then
        LuaGlobalTableDeal.mRingSecRewardDic = {}
        local tbl = LuaGlobalTableDeal.GetGlobalTabl(22967)
        if tbl and tbl.value then
            local allSecReard = string.Split(tbl.value, '&')
            local secReard, key
            for i = 1, #allSecReard do
                secReard = string.Split(allSecReard[i], '#')
                if #secReard > 1 then
                    key = tonumber(secReard[1])
                    table.remove(secReard, 1)
                    LuaGlobalTableDeal.mRingSecRewardDic[key] = secReard
                end
            end
        end
    end
    return LuaGlobalTableDeal.mRingSecRewardDic
end


--endregion

--region 兵鉴任务
function LuaGlobalTableDeal.GetCurWeaponBookRewardItemId(sec)
    local rewardInfo = LuaGlobalTableDeal.GetWeaponBookSecRewardDic()[sec]
    if rewardInfo and #rewardInfo > 0 then
        local sex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex)
        local career = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
        for i = 1, #rewardInfo do
            if (rewardInfo[i].sex == 0 or rewardInfo[i].sex == sex) and (rewardInfo[i].career == 0 or rewardInfo[i].career == career) then
                 return rewardInfo[i].itemId
            end
        end
    end
    return 0
end

function LuaGlobalTableDeal.GetWeaponBookSecRewardDic()
    if LuaGlobalTableDeal.mWeaponBookSecRewardDic == nil then
        LuaGlobalTableDeal.mWeaponBookSecRewardDic = {}
        local tbl = LuaGlobalTableDeal.GetGlobalTabl(23098)
        if tbl and tbl.value then
            local allSecReward = string.Split(tbl.value, '&')
            local secReward, key
            for i = 1, #allSecReward do
                secReward = string.Split(allSecReward[i], '#')
                if #secReward > 1 then
                    key = tonumber(secReward[1])
                    local rewardItemTbl = {}
                    for i = 1, #secReward do
                        local rewardItem = string.Split(secReward[i], '-')
                        if #rewardItem > 2 then
                            table.insert(rewardItemTbl, {
                                itemId = tonumber(rewardItem[1]),
                                count = tonumber(rewardItem[2]),
                                career = tonumber(rewardItem[3]),
                                sex = tonumber(rewardItem[4]),
                            })
                        end
                    end
                    LuaGlobalTableDeal.mWeaponBookSecRewardDic[key] = rewardItemTbl
                end
            end
        end
    end
    return LuaGlobalTableDeal.mWeaponBookSecRewardDic
end


--endregion

--region Boss次数购买
---读取数据
function LuaGlobalTableDeal:GetBossBuyTimesData()
    local data = self.GetGlobalTabl(22974)
    ---@type Cost
    self.mBossBuyCost = {}
    if data then
        local strs = string.Split(data.value, '#')
        if #strs >= 3 then
            self.mBossBuyCost.itemId = tonumber(strs[1])
            self.mBossBuyCost.costNum = tonumber(strs[2])
        end
    end
end

---@return Cost 购买货币消耗
function LuaGlobalTableDeal:GetBossBuyCost()
    if self.mBossBuyCost == nil then
        self:GetBossBuyTimesData()
    end
    return self.mBossBuyCost
end

---@return number 购买默认次数
function LuaGlobalTableDeal:GetBossBuyNormalTime()
    if self.mBossBuyNormalTime == nil then
        local data = self.GetGlobalTabl(22993)
        if data then
            self.mBossBuyNormalTime = tonumber(data.value)
        end
    end
    return self.mBossBuyNormalTime
end
--endregion

--region 阵法
---@class ZhenFaConfigInfo 阵法配置信息
---@field equipIndex LuaEnumPlayerEquipIndex 装备位
---@field baseSpriteName string 底图名字

---获取阵法配置数据列表
---@return table<ZhenFaConfigInfo>
function LuaGlobalTableDeal:GetZhenFaConfigInfoList()
    if self.zhenFaConfigInfoList == nil then
        self.zhenFaConfigInfoList = {}
        local data = self.GetGlobalTabl(22985)
        local zhenFaConfigParamsList = string.Split(data.value, '&')
        for k, v in pairs(zhenFaConfigParamsList) do
            local zhenFaConfigParams = string.Split(v, '#')
            if type(zhenFaConfigParams) == 'table' and #zhenFaConfigParams > 1 then
                ---@type ZhenFaConfigInfo
                local zhenFaConfigInfo = {}
                zhenFaConfigInfo.equipIndex = tonumber(zhenFaConfigParams[1])
                zhenFaConfigInfo.baseSpriteName = zhenFaConfigParams[2]
                table.insert(self.zhenFaConfigInfoList, zhenFaConfigInfo)
            end
        end
    end
    return self.zhenFaConfigInfoList
end

---通过装备位获取阵法配置信息
---@param equipIndex LuaEnumPlayerEquipIndex
---@return ZhenFaConfigInfo
function LuaGlobalTableDeal:GetZhenFaConfigInfo(equipIndex)
    local zhenFaConfigInfoList = self:GetZhenFaConfigInfoList()
    if type(zhenFaConfigInfoList) == 'table' and Utility.GetLuaTableCount(zhenFaConfigInfoList) > 0 then
        for k, v in pairs(zhenFaConfigInfoList) do
            ---@type ZhenFaConfigInfo
            local zhenFaConfigInfo = v
            if zhenFaConfigInfo.equipIndex == equipIndex then
                return zhenFaConfigInfo
            end
        end
    end
end

---是否是阵法装备位(装备)
---@param equipIndex LuaEnumPlayerEquipIndex
---@return boolean
function LuaGlobalTableDeal:IsConfigZhenFaEquipIndex(equipIndex)
    return self:GetZhenFaConfigInfo(equipIndex) ~= nil
end

---获取法阵装备子类型名字
---@param subType LuaEnumEquipSubType
---@return string
function LuaGlobalTableDeal:GetFaZhenSubtypeName(subType)
    if self.ZhenFaSubtypeNameList == nil then
        self.ZhenFaSubtypeNameList = {}
        local data = self.GetGlobalTabl(22994)
        local zhenFaConfigParamsList = string.Split(data.value, '&')
        for k, v in pairs(zhenFaConfigParamsList) do
            local zhenFaConfigParams = string.Split(v, '#')
            if type(zhenFaConfigParams) == 'table' and #zhenFaConfigParams > 1 then
                self.ZhenFaSubtypeNameList[tonumber(zhenFaConfigParams[1])] = zhenFaConfigParams[2]
            end
        end
    end
    if type(subType) == 'number' then
        return self.ZhenFaSubtypeNameList[subType]
    end
end
--endregion

--region 扫荡
---是否可以显示扫荡按钮
---@return boolean
function LuaGlobalTableDeal:CanShowClearBtn()
    if self.showClearBtnConditionList == nil then
        local data = self.GetGlobalTabl(23004)
        if data ~= nil then
            self.showClearBtnConditionList = Utility.ChangeNumberTable(string.Split(data.value, '#'))
        end
    end
    if type(self.showClearBtnConditionList) == 'table' and #self.showClearBtnConditionList > 0 then
        return Utility.IsMainPlayerMatchConditionList_AND(self.showClearBtnConditionList).success
    end
    return true
end
--endregion

--region 回收
---是否显示快速回收
---@return boolean
function LuaGlobalTableDeal:IsShowQuickRecycle()
    if self.showQuickRecycleConditionList == nil then
        local data = self.GetGlobalTabl(23007)
        if data ~= nil then
            self.showQuickRecycleConditionList = Utility.ChangeNumberTable(string.Split(data.value, '#'))
        end
    end
    if type(self.showQuickRecycleConditionList) == 'table' and #self.showQuickRecycleConditionList > 0 then
        return Utility.IsMainPlayerMatchConditionList_AND(self.showQuickRecycleConditionList).success
    end
    return true
end

---检测开启快速回收的系统的开启状态
---@return LuaMatchConditionResult
function LuaGlobalTableDeal:CheckOpenQuickRecycleSystemIsOpen()
    if self.mOpenQuickRecycleSystemIsOpenConditionList == nil then
        local data = self.GetGlobalTabl(23013)
        if data ~= nil then
            self.mOpenQuickRecycleSystemIsOpenConditionList = Utility.ChangeNumberTable(string.Split(data.value, '#'))
        end
    end
    if type(self.mOpenQuickRecycleSystemIsOpenConditionList) == 'table' and #self.mOpenQuickRecycleSystemIsOpenConditionList > 0 then
        return Utility.IsMainPlayerMatchConditionList_AND(self.mOpenQuickRecycleSystemIsOpenConditionList)
    end
end
--endregion

---得到会员提示左侧框显示ID
---@return table<number,TABLE.IntListJingHao>
function LuaGlobalTableDeal:GetHuiYuanTaskJumpIDDic()
    if self.HuiYuanTaskJumpDic == nil then
        self.HuiYuanTaskJumpDic = {}
        local data = LuaGlobalTableDeal.GetGlobalTabl(23018)
        if data ~= nil then
            local temp = string.Split(data.value, '&')
            for i, v in pairs(temp) do
                local str = string.Split(v, '#')
                local list = {}
                for i = 2, #str do
                    table.insert(list, tonumber(str[i]))
                end
                local ID = tonumber(str[1])
                self.HuiYuanTaskJumpDic[ID] = list
            end
        end
    end
    return self.HuiYuanTaskJumpDic
end
--endregion

---副本npc面板开启限制
function LuaGlobalTableDeal:ConditionDevilSquarePanelDic()
    if self.mConditionDevilSquarePanelDic == nil then
        local data = self.GetGlobalTabl(23020)
        self.mConditionDevilSquarePanelDic = {}
        if data ~= nil then
            local temp = string.Split(data.value, '&')
            for i, v in pairs(temp) do
                local strS = string.Split(v, '#')
                local key = tonumber(strS[1])
                local valueList = {}
                for i = 2, #strS do
                    table.insert(valueList, tonumber(strS[i]))
                end
                self.mConditionDevilSquarePanelDic[key] = valueList
            end
        end
    end
    return self.mConditionDevilSquarePanelDic
end

---@return boolean 仙装镶嵌系统是否开启(默认开)
function LuaGlobalTableDeal:XianZhuangInlaySystemIsOpen()
    if self.mOpenXianZhuangInlaySystemIsOpen == nil then
        local data = self.GetGlobalTabl(23028)
        if data ~= nil then
            self.mOpenXianZhuangInlaySystemIsOpen = Utility.ChangeNumberTable(string.Split(data.value, '#'))
        end
    end
    if type(self.mOpenXianZhuangInlaySystemIsOpen) == 'table' and #self.mOpenXianZhuangInlaySystemIsOpen > 0 then
        return Utility.IsMainPlayerMatchConditionList_AND(self.mOpenXianZhuangInlaySystemIsOpen).success
    end
    return true
end

return LuaGlobalTableDeal