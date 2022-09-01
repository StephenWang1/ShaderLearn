---@class UIRankManager:UIBase  排行榜管理类
local UIRankManager = {}

---根据类型返回相应的lua类
---@param isShareRank boolean 是否为联服排行榜
---@public
function UIRankManager:GetLuaClassOfRankType(type, isShareRank)
    --战力榜
    local isPowerRank = type == LuaEnumRankType.FIGHT_POWER_ALL
            or type == LuaEnumRankType.LEVEL_ZHANSHI
            or type == LuaEnumRankType.LEVEL_FASHI
            or type == LuaEnumRankType.LEVEL_DAOSHI
    --等级榜
    local isLevelRank = type == LuaEnumRankType.LEVEL_ALL
            or type == LuaEnumRankType.FIGHT_POWER_ZHANSHI
            or type == LuaEnumRankType.FIGHT_POWER_FASHI
            or type == LuaEnumRankType.FIGHT_POWER_DAOSHI
    --男神女神榜
    local isGodRank = type == LuaEnumRankType.FLOWER_MAN
            or type == LuaEnumRankType.FLOWER_WUMAN

    if isPowerRank or isLevelRank then
        --等级榜 战力榜
        return isShareRank and luaclass.UIShareRankNormalFeatureTemplate or luaclass.UIRankNormalShowModelFeatureTemplate
    elseif isGodRank then
        --男神榜 女神榜
        return luaclass.UIRankCharmFeatureTemplate
    elseif type == LuaEnumRankType.FINGER then
        --拳榜
        return luaclass.UIRankFistFeatureTemplate
    elseif type == LuaEnumRankType.DOBUSINESS then
        --经商榜
        return luaclass.UIRankDobusinessFeatureTemplate
    elseif type == LuaEnumRankType.LOVER then
        --恩爱榜
        return luaclass.UIRankLoverFeatureTemplate
    elseif type == LuaEnumRankType.FLOWER then
        --花榜
        return luaclass.UIRankFlowerFeatureTemplate
    elseif type == LuaEnumRankType.KILLMONSTER then
        --猎兽榜
        return luaclass.UIRankKillMonsterFeatureTemplate
    elseif type == LuaEnumRankType.GODTOWAR then
        --战神榜
        return luaclass.UIRankGodToWarFeatureTemplate
    elseif type == LuaEnumRankType.SERVANT then
        --灵兽榜
        return isShareRank and luaclass.UIShareRankServantFeatureTemplate or luaclass.UIRankServantFeatureTemplate
    elseif type == LuaEnumRankType.BATTLEDAMAGE then
        --战损榜
        return luaclass.UIRankBattleDamageFeatureTemplate
    elseif type == LuaEnumRankType.PREFIX then
        --阵法榜
        return isShareRank and luaclass.UIShareRankPrefixFeatureTemplate or luaclass.UIRankPrefixFeatureTemplate
    elseif type == LuaEnumRankType.FORMATION then
        return luaclass.UIRankFormationFeatureTemplate
    end
    return nil
end

---根据夺榜类型返回相应的lua类
---@public
function UIRankManager:GetLuaClassOfContendRankType(type, isMain)
    --战力榜
    local isPowerRank = type == LuaEnumRankType.FIGHT_POWER_ALL
            or type == LuaEnumRankType.LEVEL_ZHANSHI
            or type == LuaEnumRankType.LEVEL_FASHI
            or type == LuaEnumRankType.LEVEL_DAOSHI
    --等级榜
    local isLevelRank = type == LuaEnumRankType.LEVEL_ALL
            or type == LuaEnumRankType.FIGHT_POWER_ZHANSHI
            or type == LuaEnumRankType.FIGHT_POWER_FASHI
            or type == LuaEnumRankType.FIGHT_POWER_DAOSHI
    --男神女神榜
    local isGodRank = type == LuaEnumRankType.FLOWER_MAN
            or type == LuaEnumRankType.FLOWER_WUMAN

    if isLevelRank then
        --等级榜
        return luaclass.UIContendRank_UnitLevelFeatureClass
    elseif isPowerRank then
        --战力榜
        return luaclass.UIContendRank_UnitFeatureClass
    elseif isGodRank then
        --男神榜 女神榜
        return luaclass.UIContendRank_UnitNormalFeatureClass
    elseif type == LuaEnumRankType.FINGER then
        --拳榜
        return luaclass.UIContendRank_UnitNormalFeatureClass
    elseif type == LuaEnumRankType.DOBUSINESS then
        --经商榜
        return luaclass.UIContendRank_UnitDobusinessFeatureClass
    elseif type == LuaEnumRankType.LOVER then
        --恩爱榜
        return luaclass.UIRankLoverFeatureTemplate
    elseif type == LuaEnumRankType.FLOWER then
        --花榜
        return luaclass.UIContendRank_UnitNormalFeatureClass
    elseif type == LuaEnumRankType.KILLMONSTER then
        --猎兽榜
        return luaclass.UIContendRank_UnitNormalFeatureClass
    elseif type == LuaEnumRankType.GODTOWAR then
        --战神榜
        return luaclass.UIContendRank_UnitNormalFeatureClass
    elseif type == LuaEnumRankType.SERVANT then
        --灵兽榜
        return luaclass.UIContendRank_UnitServantlFeatureClass
    elseif type == LuaEnumRankType.BATTLEDAMAGE then
        --战损榜
        return luaclass.UIRankBattleDamageFeatureTemplate
    elseif type == LuaEnumRankType.PREFIX then
        --战勋榜
        return luaclass.UIRankPrefixFeatureTemplate
    end
    return nil
end

---根据霸业类型返回相应的视图lua类
---@public
function UIRankManager:GetLuaViewClassOfLeaderRankId(type)
    if type == 1 then
        return luaclass.UIOverlordRank_UnionViewClass
    elseif type == 2 then
        return luaclass.UIOverlordRank_LeaderViewClass
    elseif type == 3 then
        return luaclass.UIOverlordRank_MeritViewClass
    end
end

---根据霸业类型返回相应的单元lua类
---@public
function UIRankManager:GetLuaUnitClassOfLeaderRankType(type)
    if type == 1 then
        return luaclass.UIOverlordRank_UnionUnitClass
    elseif type == 2 then
        return luaclass.UIOverlordRank_LeaderUnitClass
    elseif type == 3 then
        return luaclass.UIOverlordRank_MeritUnitClass
    elseif type == 4 then
        return luaclass.UIOverlordRank_MiniUnitClass
    end
end

function UIRankManager:IsShowModel(type)
    --[[    local isPowerRank = type == LuaEnumRankType.FIGHT_POWER_ALL
                or type == LuaEnumRankType.LEVEL_ZHANSHI
                or type == LuaEnumRankType.LEVEL_FASHI
                or type == LuaEnumRankType.LEVEL_DAOSHI
        --等级榜
        local isLevelRank = type == LuaEnumRankType.LEVEL_ALL
                or type == LuaEnumRankType.FIGHT_POWER_ZHANSHI
                or type == LuaEnumRankType.FIGHT_POWER_FASHI
                or type == LuaEnumRankType.FIGHT_POWER_DAOSHI]]
    return type ~= nil and type ~= 0 and type ~= LuaEnumRankType.LOVER
end

--region 活动排行榜列表处理
---根据活动id获取活动排行榜列表
---@return tabel 第一个列表和第二个列表集合
function UIRankManager.GetActivityRankList(activityRankId)
    if CS.CSScene.MainPlayerInfo == nil then
        return nil
    end
    local activityRankTbl = {}
    local mainActivityRankInfo = CS.CSScene.MainPlayerInfo.ActivityInfo
    if activityRankId == LuaEnuActivityRankID.DefendKing then
        ---保卫国王
        activityRankTbl.main = Utility.ListChangeTable(mainActivityRankInfo.mainPlayerDefendKingRankList)
        activityRankTbl.other = Utility.ListChangeTable(mainActivityRankInfo.OtherPlayerDefendKingRankList)
    elseif activityRankId == LuaEnuActivityRankID.ShaBaK then
        ---沙巴克 (特殊处理)
        --local mineCampList, otherCampList = CS.CSScene.MainPlayerInfo.DuplicateV2:GetShaBaKRank();
        --activityRankTbl.main = Utility.ListChangeTable(mineCampList)
        --activityRankTbl.other = Utility.ListChangeTable(otherCampList)
    elseif activityRankId == LuaEnuActivityRankID.Goddess then
        ---女神赐福
        activityRankTbl.main = Utility.ListChangeTable(mainActivityRankInfo.GoddessList)
    elseif activityRankId == LuaEnuActivityRankID.UnionDartCar then
        ---行会押镖 (特殊处理)
        activityRankTbl.main = Utility.ListChangeTable(CS.CSScene.MainPlayerInfo.ActivityInfo:GetUnionDartCarList(0, 1))
        activityRankTbl.other = Utility.ListChangeTable(CS.CSScene.MainPlayerInfo.ActivityInfo:GetUnionDartCarList(0, 2))
    elseif activityRankId == LuaEnuActivityRankID.BuDouKai then
        ---武道会
        activityRankTbl.main = Utility.ListChangeTable(mainActivityRankInfo.BuDouKaiRankList)
    elseif activityRankId == LuaEnuActivityRankID.DreamLandMaze then
        ---幻境迷宫
        activityRankTbl.main = Utility.ListChangeTable(mainActivityRankInfo.DreamLandMazeMainPlayerRankList)
        activityRankTbl.other = Utility.ListChangeTable(mainActivityRankInfo.DreamLandMazeOtherPlayerRankList)
    end
    return activityRankTbl
end

---获取重新排序的活动排行榜列表
---@param activityRankId leaderboard表id
---@param featureType leaderboard配表（LuaEnumActivityRankComponentType）
function UIRankManager.GetActivityRankSortedList(activityRankId, featureType)
    local tbl = UIRankManager.GetActivityRankList(activityRankId)
    if tbl == nil then
        return nil
    end
    for i, v in pairs(tbl) do
        table.sort(v, function(l, r)
            return UIRankManager.ActivityRankSortFunc(activityRankId, featureType, l, r)
        end)
    end
    return tbl
end

---处理排序
---@param activityRankId number leaderboard表id
---@param RankComponentType number 功能类型
---@param l CS.ActivitySettleBaseV
---@param r CS.ActivitySettleBaseVO
function UIRankManager.ActivityRankSortFunc(activityRankId, RankComponentType, l, r)

    if RankComponentType == LuaEnumActivityRankComponentType.Ranking then
        ---排名
        if activityRankId == LuaEnuActivityRankID.Goddess then
            return l.integral > r.integral
        elseif activityRankId == LuaEnuActivityRankID.DefendKing then
            return l.integral > r.integral
        end
        return l.rank < r.rank
    elseif RankComponentType == LuaEnumActivityRankComponentType.BossHurt then
        ---BOSS伤害
        if activityRankId == LuaEnuActivityRankID.DreamLandMaze then
            return l.firstValue > r.firstValue
        end
    elseif RankComponentType == LuaEnumActivityRankComponentType.KillBoss then
        ---BOSS斩杀
        if activityRankId == LuaEnuActivityRankID.DreamLandMaze then
            return l.secondValue > r.secondValue
        end
    elseif RankComponentType == LuaEnumActivityRankComponentType.KillPlayer then
        ---击杀玩家数
        if activityRankId == LuaEnuActivityRankID.DefendKing then
            return l.thirdValue > r.thirdValue
        elseif activityRankId == LuaEnuActivityRankID.DreamLandMaze then
            return l.thirdValue > r.thirdValue
        end
        if activityRankId == LuaEnuActivityRankID.Goddess then
            return l.thirdValue > r.thirdValue
        end
        if activityRankId == LuaEnuActivityRankID.UnionDartCar then
            return l.secondValue > r.secondValue
        end
        if activityRankId == LuaEnuActivityRankID.BuDouKai then
            return l.KillNum > r.KillNum
        end
    elseif RankComponentType == LuaEnumActivityRankComponentType.Score then
        ---评分
        if activityRankId == LuaEnuActivityRankID.Goddess then
            if l.integral ~= r.integral then
                return l.integral > r.integral
            else
                if l.secondValue ~= r.secondValue then
                    return l.secondValue > r.secondValue
                else
                    return l.thirdValue > r.thirdValue
                end
            end
        else
            return l.integral > r.integral
        end

    elseif RankComponentType == LuaEnumActivityRankComponentType.Ingots then
        return l.secondValue > r.secondValue
        ---元宝收益
    elseif RankComponentType == LuaEnumActivityRankComponentType.OutputHurt then
        --- 输出
    elseif RankComponentType == LuaEnumActivityRankComponentType.TakeDamage then
        --- 承伤
    elseif RankComponentType == LuaEnumActivityRankComponentType.Cure then
        ---治疗
    elseif RankComponentType == LuaEnumActivityRankComponentType.LowAssassin then
        ---低级刺客
        return l.firstValue > r.firstValue
    elseif RankComponentType == LuaEnumActivityRankComponentType.SeniorAssassin then
        ---高级刺客
        return l.secondValue > r.secondValue
    elseif RankComponentType == LuaEnumActivityRankComponentType.Dead then
        ---阵亡
        if activityRankId == LuaEnuActivityRankID.DefendKing then
            return l.fourthValue > r.fourthValue
        end
        if activityRankId == LuaEnuActivityRankID.UnionDartCar then
            return l.thirdValue > r.thirdValue
        end
    elseif RankComponentType == LuaEnumActivityRankComponentType.DartDistance then
        ---押镖距离
        return l.Distance > r.Distance
    elseif RankComponentType == LuaEnumActivityRankComponentType.BetRate then
        --if activityRankId == LuaEnuActivityRankID.BuDouKai then
        --    return l.BuDouRankPlayerInfo.betRate > r.BuDouRankPlayerInfo.betRate
        --end
    elseif RankComponentType == LuaEnumActivityRankComponentType.BetAmount then
        --if activityRankId == LuaEnuActivityRankID.BuDouKai then
        --    return l.BuDouRankPlayerInfo.betAmount > r.BuDouRankPlayerInfo.betAmount
        --end
    end
    return false
end

--endregion

---点赞处理
function UIRankManager:RefreshLikeInfo(data)
    if data == nil or CS.CSScene.MainPlayerInfo == nil then
        return
    end
    local activityInfo = CS.CSScene.MainPlayerInfo.ActivityInfo
    if data.activityId == luaEnumActivityTypeByActivityTimeTable.ShaBaK then
        activityInfo:UpdateShaBaKLikeData(data)
    elseif data.activityId == luaEnumActivityTypeByActivityTimeTable.DartCar then
        activityInfo:UpdateUnionDartCarLikeData(data)
    elseif data.activityId == luaEnumActivityTypeByActivityTimeTable.GoddessesBless then
        activityInfo:RefreshGoddessesBlessLiseInfo(data)
    elseif data.activityId == luaEnumActivityTypeByActivityTimeTable.BuDouKai then
        activityInfo:UpdateBuDouKaiLikeData(data)
    elseif data.activityId == luaEnumActivityTypeByActivityTimeTable.DefendKing then
        if activityInfo.mainPlayerDefendKingRankList ~= nil and activityInfo.OtherPlayerDefendKingRankList ~= nil then
            activityInfo:RefreshDefendKingLikeData(data)
        end
    elseif data.activityId == luaEnumActivityTypeByActivityTimeTable.DreamlandMaze then
        activityInfo:RefreshDreamLandMazeLikeData(data)
    end
end

return UIRankManager