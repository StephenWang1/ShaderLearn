--[[本文件为工具自动生成,禁止手动修改]]
local cartV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable cartV2.ResBodyGuardInfo
---@type cartV2.ResBodyGuardInfo
cartV2_adj.metatable_ResBodyGuardInfo = {
    _ClassName = "cartV2.ResBodyGuardInfo",
}
cartV2_adj.metatable_ResBodyGuardInfo.__index = cartV2_adj.metatable_ResBodyGuardInfo
--endregion

---@param tbl cartV2.ResBodyGuardInfo 待调整的table数据
function cartV2_adj.AdjustResBodyGuardInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_ResBodyGuardInfo)
    if tbl.cartState == nil then
        tbl.cartStateSpecified = false
        tbl.cartState = 0
    else
        tbl.cartStateSpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.mapName == nil then
        tbl.mapNameSpecified = false
        tbl.mapName = ""
    else
        tbl.mapNameSpecified = true
    end
    if tbl.x == nil then
        tbl.xSpecified = false
        tbl.x = 0
    else
        tbl.xSpecified = true
    end
    if tbl.y == nil then
        tbl.ySpecified = false
        tbl.y = 0
    else
        tbl.ySpecified = true
    end
end

--region metatable cartV2.ResUnionCartInfo
---@type cartV2.ResUnionCartInfo
cartV2_adj.metatable_ResUnionCartInfo = {
    _ClassName = "cartV2.ResUnionCartInfo",
}
cartV2_adj.metatable_ResUnionCartInfo.__index = cartV2_adj.metatable_ResUnionCartInfo
--endregion

---@param tbl cartV2.ResUnionCartInfo 待调整的table数据
function cartV2_adj.AdjustResUnionCartInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_ResUnionCartInfo)
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
    if tbl.joinNum == nil then
        tbl.joinNumSpecified = false
        tbl.joinNum = 0
    else
        tbl.joinNumSpecified = true
    end
    if tbl.moveInterval == nil then
        tbl.moveIntervalSpecified = false
        tbl.moveInterval = 0
    else
        tbl.moveIntervalSpecified = true
    end
    if tbl.distance == nil then
        tbl.distanceSpecified = false
        tbl.distance = 0
    else
        tbl.distanceSpecified = true
    end
    if tbl.totalDis == nil then
        tbl.totalDisSpecified = false
        tbl.totalDis = 0
    else
        tbl.totalDisSpecified = true
    end
    if tbl.myScore == nil then
        tbl.myScoreSpecified = false
        tbl.myScore = 0
    else
        tbl.myScoreSpecified = true
    end
    if tbl.cartState == nil then
        tbl.cartStateSpecified = false
        tbl.cartState = 0
    else
        tbl.cartStateSpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.x == nil then
        tbl.xSpecified = false
        tbl.x = 0
    else
        tbl.xSpecified = true
    end
    if tbl.y == nil then
        tbl.ySpecified = false
        tbl.y = 0
    else
        tbl.ySpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
    if tbl.isInRange == nil then
        tbl.isInRangeSpecified = false
        tbl.isInRange = 0
    else
        tbl.isInRangeSpecified = true
    end
    if tbl.opposeNum == nil then
        tbl.opposeNumSpecified = false
        tbl.opposeNum = 0
    else
        tbl.opposeNumSpecified = true
    end
end

--region metatable cartV2.UnionCartRank
---@type cartV2.UnionCartRank
cartV2_adj.metatable_UnionCartRank = {
    _ClassName = "cartV2.UnionCartRank",
}
cartV2_adj.metatable_UnionCartRank.__index = cartV2_adj.metatable_UnionCartRank
--endregion

---@param tbl cartV2.UnionCartRank 待调整的table数据
function cartV2_adj.AdjustUnionCartRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_UnionCartRank)
    if tbl.selfInfos == nil then
        tbl.selfInfos = {}
    else
        if cartV2_adj.AdjustUnionCartRankPlayerInfo ~= nil then
            for i = 1, #tbl.selfInfos do
                cartV2_adj.AdjustUnionCartRankPlayerInfo(tbl.selfInfos[i])
            end
        end
    end
    if tbl.otherInfos == nil then
        tbl.otherInfos = {}
    else
        if cartV2_adj.AdjustUnionCartRankPlayerInfo ~= nil then
            for i = 1, #tbl.otherInfos do
                cartV2_adj.AdjustUnionCartRankPlayerInfo(tbl.otherInfos[i])
            end
        end
    end
    if tbl.common == nil then
        tbl.commonSpecified = false
        tbl.common = nil
    else
        if tbl.commonSpecified == nil then 
            tbl.commonSpecified = true
            if cartV2_adj.AdjustUnionCartRankCommon ~= nil then
                cartV2_adj.AdjustUnionCartRankCommon(tbl.common)
            end
        end
    end
end

--region metatable cartV2.UnionCartRankPlayerInfo
---@type cartV2.UnionCartRankPlayerInfo
cartV2_adj.metatable_UnionCartRankPlayerInfo = {
    _ClassName = "cartV2.UnionCartRankPlayerInfo",
}
cartV2_adj.metatable_UnionCartRankPlayerInfo.__index = cartV2_adj.metatable_UnionCartRankPlayerInfo
--endregion

---@param tbl cartV2.UnionCartRankPlayerInfo 待调整的table数据
function cartV2_adj.AdjustUnionCartRankPlayerInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_UnionCartRankPlayerInfo)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.selfDis == nil then
        tbl.selfDisSpecified = false
        tbl.selfDis = 0
    else
        tbl.selfDisSpecified = true
    end
    if tbl.killNum == nil then
        tbl.killNumSpecified = false
        tbl.killNum = 0
    else
        tbl.killNumSpecified = true
    end
    if tbl.diedNum == nil then
        tbl.diedNumSpecified = false
        tbl.diedNum = 0
    else
        tbl.diedNumSpecified = true
    end
    if tbl.grade == nil then
        tbl.gradeSpecified = false
        tbl.grade = 0
    else
        tbl.gradeSpecified = true
    end
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
    if tbl.titleType == nil then
        tbl.titleTypeSpecified = false
        tbl.titleType = 0
    else
        tbl.titleTypeSpecified = true
    end
    if tbl.like == nil then
        tbl.like = {}
    end
end

--region metatable cartV2.UnionCartRankCommon
---@type cartV2.UnionCartRankCommon
cartV2_adj.metatable_UnionCartRankCommon = {
    _ClassName = "cartV2.UnionCartRankCommon",
}
cartV2_adj.metatable_UnionCartRankCommon.__index = cartV2_adj.metatable_UnionCartRankCommon
--endregion

---@param tbl cartV2.UnionCartRankCommon 待调整的table数据
function cartV2_adj.AdjustUnionCartRankCommon(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_UnionCartRankCommon)
    if tbl.totalDis == nil then
        tbl.totalDisSpecified = false
        tbl.totalDis = 0
    else
        tbl.totalDisSpecified = true
    end
    if tbl.totalKill == nil then
        tbl.totalKillSpecified = false
        tbl.totalKill = 0
    else
        tbl.totalKillSpecified = true
    end
    if tbl.totalDied == nil then
        tbl.totalDiedSpecified = false
        tbl.totalDied = 0
    else
        tbl.totalDiedSpecified = true
    end
    if tbl.rankDis == nil then
        tbl.rankDisSpecified = false
        tbl.rankDis = 0
    else
        tbl.rankDisSpecified = true
    end
    if tbl.rankKill == nil then
        tbl.rankKillSpecified = false
        tbl.rankKill = 0
    else
        tbl.rankKillSpecified = true
    end
    if tbl.rankDied == nil then
        tbl.rankDiedSpecified = false
        tbl.rankDied = 0
    else
        tbl.rankDiedSpecified = true
    end
    if tbl.rankGrade == nil then
        tbl.rankGradeSpecified = false
        tbl.rankGrade = 0
    else
        tbl.rankGradeSpecified = true
    end
    if tbl.isArrive == nil then
        tbl.isArriveSpecified = false
        tbl.isArrive = false
    else
        tbl.isArriveSpecified = true
    end
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
end

--region metatable cartV2.ResUnionCartFinish
---@type cartV2.ResUnionCartFinish
cartV2_adj.metatable_ResUnionCartFinish = {
    _ClassName = "cartV2.ResUnionCartFinish",
}
cartV2_adj.metatable_ResUnionCartFinish.__index = cartV2_adj.metatable_ResUnionCartFinish
--endregion

---@param tbl cartV2.ResUnionCartFinish 待调整的table数据
function cartV2_adj.AdjustResUnionCartFinish(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_ResUnionCartFinish)
    if tbl.rank == nil then
        tbl.rankSpecified = false
        tbl.rank = nil
    else
        if tbl.rankSpecified == nil then 
            tbl.rankSpecified = true
            if cartV2_adj.AdjustUnionCartRank ~= nil then
                cartV2_adj.AdjustUnionCartRank(tbl.rank)
            end
        end
    end
    if tbl.showTime == nil then
        tbl.showTimeSpecified = false
        tbl.showTime = 0
    else
        tbl.showTimeSpecified = true
    end
end

--region metatable cartV2.ReqUnionCartRankRecord
---@type cartV2.ReqUnionCartRankRecord
cartV2_adj.metatable_ReqUnionCartRankRecord = {
    _ClassName = "cartV2.ReqUnionCartRankRecord",
}
cartV2_adj.metatable_ReqUnionCartRankRecord.__index = cartV2_adj.metatable_ReqUnionCartRankRecord
--endregion

---@param tbl cartV2.ReqUnionCartRankRecord 待调整的table数据
function cartV2_adj.AdjustReqUnionCartRankRecord(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_ReqUnionCartRankRecord)
end

--region metatable cartV2.ResUnionCartRankRecord
---@type cartV2.ResUnionCartRankRecord
cartV2_adj.metatable_ResUnionCartRankRecord = {
    _ClassName = "cartV2.ResUnionCartRankRecord",
}
cartV2_adj.metatable_ResUnionCartRankRecord.__index = cartV2_adj.metatable_ResUnionCartRankRecord
--endregion

---@param tbl cartV2.ResUnionCartRankRecord 待调整的table数据
function cartV2_adj.AdjustResUnionCartRankRecord(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_ResUnionCartRankRecord)
    if tbl.rank == nil then
        tbl.rankSpecified = false
        tbl.rank = nil
    else
        if tbl.rankSpecified == nil then 
            tbl.rankSpecified = true
            if cartV2_adj.AdjustUnionCartRank ~= nil then
                cartV2_adj.AdjustUnionCartRank(tbl.rank)
            end
        end
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable cartV2.ResPersonalCartList
---@type cartV2.ResPersonalCartList
cartV2_adj.metatable_ResPersonalCartList = {
    _ClassName = "cartV2.ResPersonalCartList",
}
cartV2_adj.metatable_ResPersonalCartList.__index = cartV2_adj.metatable_ResPersonalCartList
--endregion

---@param tbl cartV2.ResPersonalCartList 待调整的table数据
function cartV2_adj.AdjustResPersonalCartList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_ResPersonalCartList)
    if tbl.cartList == nil then
        tbl.cartList = {}
    else
        if cartV2_adj.AdjustPersonalCartInfo ~= nil then
            for i = 1, #tbl.cartList do
                cartV2_adj.AdjustPersonalCartInfo(tbl.cartList[i])
            end
        end
    end
    if tbl.beRobbedCount == nil then
        tbl.beRobbedCountSpecified = false
        tbl.beRobbedCount = 0
    else
        tbl.beRobbedCountSpecified = true
    end
    if tbl.robCount == nil then
        tbl.robCountSpecified = false
        tbl.robCount = 0
    else
        tbl.robCountSpecified = true
    end
end

--region metatable cartV2.PersonalCartInfo
---@type cartV2.PersonalCartInfo
cartV2_adj.metatable_PersonalCartInfo = {
    _ClassName = "cartV2.PersonalCartInfo",
}
cartV2_adj.metatable_PersonalCartInfo.__index = cartV2_adj.metatable_PersonalCartInfo
--endregion

---@param tbl cartV2.PersonalCartInfo 待调整的table数据
function cartV2_adj.AdjustPersonalCartInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_PersonalCartInfo)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.cfgId == nil then
        tbl.cfgIdSpecified = false
        tbl.cfgId = 0
    else
        tbl.cfgIdSpecified = true
    end
    if tbl.startTime == nil then
        tbl.startTimeSpecified = false
        tbl.startTime = 0
    else
        tbl.startTimeSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
    if tbl.canReward == nil then
        tbl.canRewardSpecified = false
        tbl.canReward = 0
    else
        tbl.canRewardSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.hp == nil then
        tbl.hpSpecified = false
        tbl.hp = 0
    else
        tbl.hpSpecified = true
    end
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
end

--region metatable cartV2.ResPersonalCartSituation
---@type cartV2.ResPersonalCartSituation
cartV2_adj.metatable_ResPersonalCartSituation = {
    _ClassName = "cartV2.ResPersonalCartSituation",
}
cartV2_adj.metatable_ResPersonalCartSituation.__index = cartV2_adj.metatable_ResPersonalCartSituation
--endregion

---@param tbl cartV2.ResPersonalCartSituation 待调整的table数据
function cartV2_adj.AdjustResPersonalCartSituation(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_ResPersonalCartSituation)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.cfgId == nil then
        tbl.cfgIdSpecified = false
        tbl.cfgId = 0
    else
        tbl.cfgIdSpecified = true
    end
    if tbl.targetName == nil then
        tbl.targetNameSpecified = false
        tbl.targetName = ""
    else
        tbl.targetNameSpecified = true
    end
    if tbl.targetUnionName == nil then
        tbl.targetUnionNameSpecified = false
        tbl.targetUnionName = ""
    else
        tbl.targetUnionNameSpecified = true
    end
    if tbl.mapName == nil then
        tbl.mapNameSpecified = false
        tbl.mapName = ""
    else
        tbl.mapNameSpecified = true
    end
    if tbl.x == nil then
        tbl.xSpecified = false
        tbl.x = 0
    else
        tbl.xSpecified = true
    end
    if tbl.y == nil then
        tbl.ySpecified = false
        tbl.y = 0
    else
        tbl.ySpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
end

--region metatable cartV2.ReqEscortCart
---@type cartV2.ReqEscortCart
cartV2_adj.metatable_ReqEscortCart = {
    _ClassName = "cartV2.ReqEscortCart",
}
cartV2_adj.metatable_ReqEscortCart.__index = cartV2_adj.metatable_ReqEscortCart
--endregion

---@param tbl cartV2.ReqEscortCart 待调整的table数据
function cartV2_adj.AdjustReqEscortCart(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_ReqEscortCart)
    if tbl.cfgId == nil then
        tbl.cfgIdSpecified = false
        tbl.cfgId = 0
    else
        tbl.cfgIdSpecified = true
    end
end

--region metatable cartV2.ResUpdatePersonalCart
---@type cartV2.ResUpdatePersonalCart
cartV2_adj.metatable_ResUpdatePersonalCart = {
    _ClassName = "cartV2.ResUpdatePersonalCart",
}
cartV2_adj.metatable_ResUpdatePersonalCart.__index = cartV2_adj.metatable_ResUpdatePersonalCart
--endregion

---@param tbl cartV2.ResUpdatePersonalCart 待调整的table数据
function cartV2_adj.AdjustResUpdatePersonalCart(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_ResUpdatePersonalCart)
    if tbl.addList == nil then
        tbl.addList = {}
    else
        if cartV2_adj.AdjustPersonalCartInfo ~= nil then
            for i = 1, #tbl.addList do
                cartV2_adj.AdjustPersonalCartInfo(tbl.addList[i])
            end
        end
    end
    if tbl.removeList == nil then
        tbl.removeList = {}
    end
end

--region metatable cartV2.ReqReceiveReward
---@type cartV2.ReqReceiveReward
cartV2_adj.metatable_ReqReceiveReward = {
    _ClassName = "cartV2.ReqReceiveReward",
}
cartV2_adj.metatable_ReqReceiveReward.__index = cartV2_adj.metatable_ReqReceiveReward
--endregion

---@param tbl cartV2.ReqReceiveReward 待调整的table数据
function cartV2_adj.AdjustReqReceiveReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_ReqReceiveReward)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.bei == nil then
        tbl.beiSpecified = false
        tbl.bei = 0
    else
        tbl.beiSpecified = true
    end
end

--region metatable cartV2.CartMatterCode
---@type cartV2.CartMatterCode
cartV2_adj.metatable_CartMatterCode = {
    _ClassName = "cartV2.CartMatterCode",
}
cartV2_adj.metatable_CartMatterCode.__index = cartV2_adj.metatable_CartMatterCode
--endregion

---@param tbl cartV2.CartMatterCode 待调整的table数据
function cartV2_adj.AdjustCartMatterCode(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_CartMatterCode)
    if tbl.code == nil then
        tbl.codeSpecified = false
        tbl.code = 0
    else
        tbl.codeSpecified = true
    end
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
end

--region metatable cartV2.ResPersonalCartHpUpdate
---@type cartV2.ResPersonalCartHpUpdate
cartV2_adj.metatable_ResPersonalCartHpUpdate = {
    _ClassName = "cartV2.ResPersonalCartHpUpdate",
}
cartV2_adj.metatable_ResPersonalCartHpUpdate.__index = cartV2_adj.metatable_ResPersonalCartHpUpdate
--endregion

---@param tbl cartV2.ResPersonalCartHpUpdate 待调整的table数据
function cartV2_adj.AdjustResPersonalCartHpUpdate(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_ResPersonalCartHpUpdate)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.hp == nil then
        tbl.hpSpecified = false
        tbl.hp = 0
    else
        tbl.hpSpecified = true
    end
    if tbl.isRobbed == nil then
        tbl.isRobbedSpecified = false
        tbl.isRobbed = 0
    else
        tbl.isRobbedSpecified = true
    end
end

--region metatable cartV2.ReqPersonalCartPosition
---@type cartV2.ReqPersonalCartPosition
cartV2_adj.metatable_ReqPersonalCartPosition = {
    _ClassName = "cartV2.ReqPersonalCartPosition",
}
cartV2_adj.metatable_ReqPersonalCartPosition.__index = cartV2_adj.metatable_ReqPersonalCartPosition
--endregion

---@param tbl cartV2.ReqPersonalCartPosition 待调整的table数据
function cartV2_adj.AdjustReqPersonalCartPosition(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_ReqPersonalCartPosition)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable cartV2.ResPersonalCartPosition
---@type cartV2.ResPersonalCartPosition
cartV2_adj.metatable_ResPersonalCartPosition = {
    _ClassName = "cartV2.ResPersonalCartPosition",
}
cartV2_adj.metatable_ResPersonalCartPosition.__index = cartV2_adj.metatable_ResPersonalCartPosition
--endregion

---@param tbl cartV2.ResPersonalCartPosition 待调整的table数据
function cartV2_adj.AdjustResPersonalCartPosition(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_ResPersonalCartPosition)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.x == nil then
        tbl.xSpecified = false
        tbl.x = 0
    else
        tbl.xSpecified = true
    end
    if tbl.y == nil then
        tbl.ySpecified = false
        tbl.y = 0
    else
        tbl.ySpecified = true
    end
end

--region metatable cartV2.LikeList
---@type cartV2.LikeList
cartV2_adj.metatable_LikeList = {
    _ClassName = "cartV2.LikeList",
}
cartV2_adj.metatable_LikeList.__index = cartV2_adj.metatable_LikeList
--endregion

---@param tbl cartV2.LikeList 待调整的table数据
function cartV2_adj.AdjustLikeList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_LikeList)
    if tbl.likes == nil then
        tbl.likes = {}
    end
end

--region metatable cartV2.ReqStartFreightCar
---@type cartV2.ReqStartFreightCar
cartV2_adj.metatable_ReqStartFreightCar = {
    _ClassName = "cartV2.ReqStartFreightCar",
}
cartV2_adj.metatable_ReqStartFreightCar.__index = cartV2_adj.metatable_ReqStartFreightCar
--endregion

---@param tbl cartV2.ReqStartFreightCar 待调整的table数据
function cartV2_adj.AdjustReqStartFreightCar(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_ReqStartFreightCar)
    if tbl.carConfigId == nil then
        tbl.carConfigIdSpecified = false
        tbl.carConfigId = 0
    else
        tbl.carConfigIdSpecified = true
    end
end

--region metatable cartV2.ResFreightCarInfo
---@type cartV2.ResFreightCarInfo
cartV2_adj.metatable_ResFreightCarInfo = {
    _ClassName = "cartV2.ResFreightCarInfo",
}
cartV2_adj.metatable_ResFreightCarInfo.__index = cartV2_adj.metatable_ResFreightCarInfo
--endregion

---@param tbl cartV2.ResFreightCarInfo 待调整的table数据
function cartV2_adj.AdjustResFreightCarInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_ResFreightCarInfo)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.masterId == nil then
        tbl.masterIdSpecified = false
        tbl.masterId = 0
    else
        tbl.masterIdSpecified = true
    end
    if tbl.hostId == nil then
        tbl.hostIdSpecified = false
        tbl.hostId = 0
    else
        tbl.hostIdSpecified = true
    end
    if tbl.masterUnionId == nil then
        tbl.masterUnionIdSpecified = false
        tbl.masterUnionId = 0
    else
        tbl.masterUnionIdSpecified = true
    end
    if tbl.uniteUnionType == nil then
        tbl.uniteUnionTypeSpecified = false
        tbl.uniteUnionType = 0
    else
        tbl.uniteUnionTypeSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.masterName == nil then
        tbl.masterNameSpecified = false
        tbl.masterName = ""
    else
        tbl.masterNameSpecified = true
    end
    if tbl.carConfigId == nil then
        tbl.carConfigIdSpecified = false
        tbl.carConfigId = 0
    else
        tbl.carConfigIdSpecified = true
    end
    if tbl.hp == nil then
        tbl.hpSpecified = false
        tbl.hp = 0
    else
        tbl.hpSpecified = true
    end
    if tbl.yabiaoId == nil then
        tbl.yabiaoIdSpecified = false
        tbl.yabiaoId = 0
    else
        tbl.yabiaoIdSpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.x == nil then
        tbl.xSpecified = false
        tbl.x = 0
    else
        tbl.xSpecified = true
    end
    if tbl.y == nil then
        tbl.ySpecified = false
        tbl.y = 0
    else
        tbl.ySpecified = true
    end
    if tbl.line == nil then
        tbl.lineSpecified = false
        tbl.line = 0
    else
        tbl.lineSpecified = true
    end
end

--region metatable cartV2.ResRoleFreightInfo
---@type cartV2.ResRoleFreightInfo
cartV2_adj.metatable_ResRoleFreightInfo = {
    _ClassName = "cartV2.ResRoleFreightInfo",
}
cartV2_adj.metatable_ResRoleFreightInfo.__index = cartV2_adj.metatable_ResRoleFreightInfo
--endregion

---@param tbl cartV2.ResRoleFreightInfo 待调整的table数据
function cartV2_adj.AdjustResRoleFreightInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_ResRoleFreightInfo)
    if tbl.deliveryCount == nil then
        tbl.deliveryCountSpecified = false
        tbl.deliveryCount = 0
    else
        tbl.deliveryCountSpecified = true
    end
    if tbl.plunderCount == nil then
        tbl.plunderCountSpecified = false
        tbl.plunderCount = 0
    else
        tbl.plunderCountSpecified = true
    end
end

--region metatable cartV2.ResFreightCarHpChange
---@type cartV2.ResFreightCarHpChange
cartV2_adj.metatable_ResFreightCarHpChange = {
    _ClassName = "cartV2.ResFreightCarHpChange",
}
cartV2_adj.metatable_ResFreightCarHpChange.__index = cartV2_adj.metatable_ResFreightCarHpChange
--endregion

---@param tbl cartV2.ResFreightCarHpChange 待调整的table数据
function cartV2_adj.AdjustResFreightCarHpChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_ResFreightCarHpChange)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.hp == nil then
        tbl.hpSpecified = false
        tbl.hp = 0
    else
        tbl.hpSpecified = true
    end
end

--region metatable cartV2.ResFreightCarPointChange
---@type cartV2.ResFreightCarPointChange
cartV2_adj.metatable_ResFreightCarPointChange = {
    _ClassName = "cartV2.ResFreightCarPointChange",
}
cartV2_adj.metatable_ResFreightCarPointChange.__index = cartV2_adj.metatable_ResFreightCarPointChange
--endregion

---@param tbl cartV2.ResFreightCarPointChange 待调整的table数据
function cartV2_adj.AdjustResFreightCarPointChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_ResFreightCarPointChange)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.x == nil then
        tbl.xSpecified = false
        tbl.x = 0
    else
        tbl.xSpecified = true
    end
    if tbl.y == nil then
        tbl.ySpecified = false
        tbl.y = 0
    else
        tbl.ySpecified = true
    end
    if tbl.line == nil then
        tbl.lineSpecified = false
        tbl.line = 0
    else
        tbl.lineSpecified = true
    end
end

--region metatable cartV2.ResFinishFreightCar
---@type cartV2.ResFinishFreightCar
cartV2_adj.metatable_ResFinishFreightCar = {
    _ClassName = "cartV2.ResFinishFreightCar",
}
cartV2_adj.metatable_ResFinishFreightCar.__index = cartV2_adj.metatable_ResFinishFreightCar
--endregion

---@param tbl cartV2.ResFinishFreightCar 待调整的table数据
function cartV2_adj.AdjustResFinishFreightCar(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, cartV2_adj.metatable_ResFinishFreightCar)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
end

return cartV2_adj