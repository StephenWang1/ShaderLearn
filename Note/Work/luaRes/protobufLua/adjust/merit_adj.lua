--[[本文件为工具自动生成,禁止手动修改]]
local meritV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable meritV2.ReqGetMeritData
---@type meritV2.ReqGetMeritData
meritV2_adj.metatable_ReqGetMeritData = {
    _ClassName = "meritV2.ReqGetMeritData",
}
meritV2_adj.metatable_ReqGetMeritData.__index = meritV2_adj.metatable_ReqGetMeritData
--endregion

---@param tbl meritV2.ReqGetMeritData 待调整的table数据
function meritV2_adj.AdjustReqGetMeritData(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, meritV2_adj.metatable_ReqGetMeritData)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable meritV2.ResUnionBattle
---@type meritV2.ResUnionBattle
meritV2_adj.metatable_ResUnionBattle = {
    _ClassName = "meritV2.ResUnionBattle",
}
meritV2_adj.metatable_ResUnionBattle.__index = meritV2_adj.metatable_ResUnionBattle
--endregion

---@param tbl meritV2.ResUnionBattle 待调整的table数据
function meritV2_adj.AdjustResUnionBattle(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, meritV2_adj.metatable_ResUnionBattle)
    if tbl.unionBattle == nil then
        tbl.unionBattle = {}
    else
        if meritV2_adj.AdjustUinonBattle ~= nil then
            for i = 1, #tbl.unionBattle do
                meritV2_adj.AdjustUinonBattle(tbl.unionBattle[i])
            end
        end
    end
end

--region metatable meritV2.UinonBattle
---@type meritV2.UinonBattle
meritV2_adj.metatable_UinonBattle = {
    _ClassName = "meritV2.UinonBattle",
}
meritV2_adj.metatable_UinonBattle.__index = meritV2_adj.metatable_UinonBattle
--endregion

---@param tbl meritV2.UinonBattle 待调整的table数据
function meritV2_adj.AdjustUinonBattle(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, meritV2_adj.metatable_UinonBattle)
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
    if tbl.activeValue == nil then
        tbl.activeValueSpecified = false
        tbl.activeValue = 0
    else
        tbl.activeValueSpecified = true
    end
    if tbl.rewardList == nil then
        tbl.rewardList = {}
    else
        if meritV2_adj.AdjustUnionMeritReward ~= nil then
            for i = 1, #tbl.rewardList do
                meritV2_adj.AdjustUnionMeritReward(tbl.rewardList[i])
            end
        end
    end
    if tbl.receiveType == nil then
        tbl.receiveTypeSpecified = false
        tbl.receiveType = 0
    else
        tbl.receiveTypeSpecified = true
    end
    if tbl.subtype == nil then
        tbl.subtypeSpecified = false
        tbl.subtype = 0
    else
        tbl.subtypeSpecified = true
    end
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable meritV2.UnionMeritReward
---@type meritV2.UnionMeritReward
meritV2_adj.metatable_UnionMeritReward = {
    _ClassName = "meritV2.UnionMeritReward",
}
meritV2_adj.metatable_UnionMeritReward.__index = meritV2_adj.metatable_UnionMeritReward
--endregion

---@param tbl meritV2.UnionMeritReward 待调整的table数据
function meritV2_adj.AdjustUnionMeritReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, meritV2_adj.metatable_UnionMeritReward)
    if tbl.rewardId == nil then
        tbl.rewardIdSpecified = false
        tbl.rewardId = 0
    else
        tbl.rewardIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable meritV2.ResLeaderGlory
---@type meritV2.ResLeaderGlory
meritV2_adj.metatable_ResLeaderGlory = {
    _ClassName = "meritV2.ResLeaderGlory",
}
meritV2_adj.metatable_ResLeaderGlory.__index = meritV2_adj.metatable_ResLeaderGlory
--endregion

---@param tbl meritV2.ResLeaderGlory 待调整的table数据
function meritV2_adj.AdjustResLeaderGlory(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, meritV2_adj.metatable_ResLeaderGlory)
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
    if tbl.leader == nil then
        tbl.leader = {}
    else
        if meritV2_adj.AdjustLeaderPosition ~= nil then
            for i = 1, #tbl.leader do
                meritV2_adj.AdjustLeaderPosition(tbl.leader[i])
            end
        end
    end
end

--region metatable meritV2.LeaderGlory
---@type meritV2.LeaderGlory
meritV2_adj.metatable_LeaderGlory = {
    _ClassName = "meritV2.LeaderGlory",
}
meritV2_adj.metatable_LeaderGlory.__index = meritV2_adj.metatable_LeaderGlory
--endregion

---@param tbl meritV2.LeaderGlory 待调整的table数据
function meritV2_adj.AdjustLeaderGlory(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, meritV2_adj.metatable_LeaderGlory)
    if tbl.leader == nil then
        tbl.leader = {}
    else
        if meritV2_adj.AdjustLeaderPosition ~= nil then
            for i = 1, #tbl.leader do
                meritV2_adj.AdjustLeaderPosition(tbl.leader[i])
            end
        end
    end
end

--region metatable meritV2.LeaderPosition
---@type meritV2.LeaderPosition
meritV2_adj.metatable_LeaderPosition = {
    _ClassName = "meritV2.LeaderPosition",
}
meritV2_adj.metatable_LeaderPosition.__index = meritV2_adj.metatable_LeaderPosition
--endregion

---@param tbl meritV2.LeaderPosition 待调整的table数据
function meritV2_adj.AdjustLeaderPosition(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, meritV2_adj.metatable_LeaderPosition)
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
    if tbl.meritValue == nil then
        tbl.meritValueSpecified = false
        tbl.meritValue = 0
    else
        tbl.meritValueSpecified = true
    end
    if tbl.rewardList == nil then
        tbl.rewardList = {}
    else
        if meritV2_adj.AdjustUnionMeritReward ~= nil then
            for i = 1, #tbl.rewardList do
                meritV2_adj.AdjustUnionMeritReward(tbl.rewardList[i])
            end
        end
    end
    if tbl.receiveType == nil then
        tbl.receiveTypeSpecified = false
        tbl.receiveType = 0
    else
        tbl.receiveTypeSpecified = true
    end
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.subtype == nil then
        tbl.subtypeSpecified = false
        tbl.subtype = 0
    else
        tbl.subtypeSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
end

--region metatable meritV2.ResUnionAchievement
---@type meritV2.ResUnionAchievement
meritV2_adj.metatable_ResUnionAchievement = {
    _ClassName = "meritV2.ResUnionAchievement",
}
meritV2_adj.metatable_ResUnionAchievement.__index = meritV2_adj.metatable_ResUnionAchievement
--endregion

---@param tbl meritV2.ResUnionAchievement 待调整的table数据
function meritV2_adj.AdjustResUnionAchievement(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, meritV2_adj.metatable_ResUnionAchievement)
    if tbl.stm == nil then
        tbl.stm = {}
    else
        if meritV2_adj.AdjustSubtypeMerit ~= nil then
            for i = 1, #tbl.stm do
                meritV2_adj.AdjustSubtypeMerit(tbl.stm[i])
            end
        end
    end
end

--region metatable meritV2.SubtypeMerit
---@type meritV2.SubtypeMerit
meritV2_adj.metatable_SubtypeMerit = {
    _ClassName = "meritV2.SubtypeMerit",
}
meritV2_adj.metatable_SubtypeMerit.__index = meritV2_adj.metatable_SubtypeMerit
--endregion

---@param tbl meritV2.SubtypeMerit 待调整的table数据
function meritV2_adj.AdjustSubtypeMerit(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, meritV2_adj.metatable_SubtypeMerit)
    if tbl.subtype == nil then
        tbl.subtypeSpecified = false
        tbl.subtype = 0
    else
        tbl.subtypeSpecified = true
    end
    if tbl.merit == nil then
        tbl.merit = {}
    else
        if meritV2_adj.AdjustMerit ~= nil then
            for i = 1, #tbl.merit do
                meritV2_adj.AdjustMerit(tbl.merit[i])
            end
        end
    end
end

--region metatable meritV2.Merit
---@type meritV2.Merit
meritV2_adj.metatable_Merit = {
    _ClassName = "meritV2.Merit",
}
meritV2_adj.metatable_Merit.__index = meritV2_adj.metatable_Merit
--endregion

---@param tbl meritV2.Merit 待调整的table数据
function meritV2_adj.AdjustMerit(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, meritV2_adj.metatable_Merit)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.thisType == nil then
        tbl.thisTypeSpecified = false
        tbl.thisType = 0
    else
        tbl.thisTypeSpecified = true
    end
    if tbl.theTitle == nil then
        tbl.theTitleSpecified = false
        tbl.theTitle = 0
    else
        tbl.theTitleSpecified = true
    end
    if tbl.rewardList == nil then
        tbl.rewardList = {}
    else
        if meritV2_adj.AdjustUnionMeritReward ~= nil then
            for i = 1, #tbl.rewardList do
                meritV2_adj.AdjustUnionMeritReward(tbl.rewardList[i])
            end
        end
    end
    if tbl.receiveType == nil then
        tbl.receiveTypeSpecified = false
        tbl.receiveType = 0
    else
        tbl.receiveTypeSpecified = true
    end
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable meritV2.ReqPositionInfo
---@type meritV2.ReqPositionInfo
meritV2_adj.metatable_ReqPositionInfo = {
    _ClassName = "meritV2.ReqPositionInfo",
}
meritV2_adj.metatable_ReqPositionInfo.__index = meritV2_adj.metatable_ReqPositionInfo
--endregion

---@param tbl meritV2.ReqPositionInfo 待调整的table数据
function meritV2_adj.AdjustReqPositionInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, meritV2_adj.metatable_ReqPositionInfo)
    if tbl.subtype == nil then
        tbl.subtypeSpecified = false
        tbl.subtype = 0
    else
        tbl.subtypeSpecified = true
    end
end

--region metatable meritV2.ResPositionInfo
---@type meritV2.ResPositionInfo
meritV2_adj.metatable_ResPositionInfo = {
    _ClassName = "meritV2.ResPositionInfo",
}
meritV2_adj.metatable_ResPositionInfo.__index = meritV2_adj.metatable_ResPositionInfo
--endregion

---@param tbl meritV2.ResPositionInfo 待调整的table数据
function meritV2_adj.AdjustResPositionInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, meritV2_adj.metatable_ResPositionInfo)
    if tbl.leader == nil then
        tbl.leader = {}
    else
        if meritV2_adj.AdjustLeaderPosition ~= nil then
            for i = 1, #tbl.leader do
                meritV2_adj.AdjustLeaderPosition(tbl.leader[i])
            end
        end
    end
end

--region metatable meritV2.ResReturnRewardState
---@type meritV2.ResReturnRewardState
meritV2_adj.metatable_ResReturnRewardState = {
    _ClassName = "meritV2.ResReturnRewardState",
}
meritV2_adj.metatable_ResReturnRewardState.__index = meritV2_adj.metatable_ResReturnRewardState
--endregion

---@param tbl meritV2.ResReturnRewardState 待调整的table数据
function meritV2_adj.AdjustResReturnRewardState(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, meritV2_adj.metatable_ResReturnRewardState)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.subtype == nil then
        tbl.subtypeSpecified = false
        tbl.subtype = 0
    else
        tbl.subtypeSpecified = true
    end
    if tbl.rewardState == nil then
        tbl.rewardStateSpecified = false
        tbl.rewardState = 0
    else
        tbl.rewardStateSpecified = true
    end
end

--region metatable meritV2.ReqRewardUinonBattle
---@type meritV2.ReqRewardUinonBattle
meritV2_adj.metatable_ReqRewardUinonBattle = {
    _ClassName = "meritV2.ReqRewardUinonBattle",
}
meritV2_adj.metatable_ReqRewardUinonBattle.__index = meritV2_adj.metatable_ReqRewardUinonBattle
--endregion

---@param tbl meritV2.ReqRewardUinonBattle 待调整的table数据
function meritV2_adj.AdjustReqRewardUinonBattle(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, meritV2_adj.metatable_ReqRewardUinonBattle)
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
end

--region metatable meritV2.ReqRewardLeaderGlory
---@type meritV2.ReqRewardLeaderGlory
meritV2_adj.metatable_ReqRewardLeaderGlory = {
    _ClassName = "meritV2.ReqRewardLeaderGlory",
}
meritV2_adj.metatable_ReqRewardLeaderGlory.__index = meritV2_adj.metatable_ReqRewardLeaderGlory
--endregion

---@param tbl meritV2.ReqRewardLeaderGlory 待调整的table数据
function meritV2_adj.AdjustReqRewardLeaderGlory(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, meritV2_adj.metatable_ReqRewardLeaderGlory)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable meritV2.ReqRewardUnionAchievement
---@type meritV2.ReqRewardUnionAchievement
meritV2_adj.metatable_ReqRewardUnionAchievement = {
    _ClassName = "meritV2.ReqRewardUnionAchievement",
}
meritV2_adj.metatable_ReqRewardUnionAchievement.__index = meritV2_adj.metatable_ReqRewardUnionAchievement
--endregion

---@param tbl meritV2.ReqRewardUnionAchievement 待调整的table数据
function meritV2_adj.AdjustReqRewardUnionAchievement(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, meritV2_adj.metatable_ReqRewardUnionAchievement)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable meritV2.ResMeritRedPoint
---@type meritV2.ResMeritRedPoint
meritV2_adj.metatable_ResMeritRedPoint = {
    _ClassName = "meritV2.ResMeritRedPoint",
}
meritV2_adj.metatable_ResMeritRedPoint.__index = meritV2_adj.metatable_ResMeritRedPoint
--endregion

---@param tbl meritV2.ResMeritRedPoint 待调整的table数据
function meritV2_adj.AdjustResMeritRedPoint(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, meritV2_adj.metatable_ResMeritRedPoint)
    if tbl.idList == nil then
        tbl.idList = {}
    end
end

return meritV2_adj