--[[本文件为工具自动生成,禁止手动修改]]
local meritV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData meritV2.ReqGetMeritData lua中的数据结构
---@return meritV2.ReqGetMeritData C#中的数据结构
function meritV2.ReqGetMeritData(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.meritV2.ReqGetMeritData()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData meritV2.ResUnionBattle lua中的数据结构
---@return meritV2.ResUnionBattle C#中的数据结构
function meritV2.ResUnionBattle(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.meritV2.ResUnionBattle()
    if decodedData.unionBattle ~= nil and decodedData.unionBattleSpecified ~= false then
        for i = 1, #decodedData.unionBattle do
            data.unionBattle:Add(meritV2.UinonBattle(decodedData.unionBattle[i]))
        end
    end
    return data
end

---@param decodedData meritV2.UinonBattle lua中的数据结构
---@return meritV2.UinonBattle C#中的数据结构
function meritV2.UinonBattle(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.meritV2.UinonBattle()
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.activeValue ~= nil and decodedData.activeValueSpecified ~= false then
        data.activeValue = decodedData.activeValue
    end
    if decodedData.rewardList ~= nil and decodedData.rewardListSpecified ~= false then
        for i = 1, #decodedData.rewardList do
            data.rewardList:Add(meritV2.UnionMeritReward(decodedData.rewardList[i]))
        end
    end
    if decodedData.receiveType ~= nil and decodedData.receiveTypeSpecified ~= false then
        data.receiveType = decodedData.receiveType
    end
    if decodedData.subtype ~= nil and decodedData.subtypeSpecified ~= false then
        data.subtype = decodedData.subtype
    end
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData meritV2.UnionMeritReward lua中的数据结构
---@return meritV2.UnionMeritReward C#中的数据结构
function meritV2.UnionMeritReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.meritV2.UnionMeritReward()
    if decodedData.rewardId ~= nil and decodedData.rewardIdSpecified ~= false then
        data.rewardId = decodedData.rewardId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData meritV2.ResLeaderGlory lua中的数据结构
---@return meritV2.ResLeaderGlory C#中的数据结构
function meritV2.ResLeaderGlory(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.meritV2.ResLeaderGlory()
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.leader ~= nil and decodedData.leaderSpecified ~= false then
        for i = 1, #decodedData.leader do
            data.leader:Add(meritV2.LeaderPosition(decodedData.leader[i]))
        end
    end
    return data
end

---@param decodedData meritV2.LeaderGlory lua中的数据结构
---@return meritV2.LeaderGlory C#中的数据结构
function meritV2.LeaderGlory(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.meritV2.LeaderGlory()
    if decodedData.leader ~= nil and decodedData.leaderSpecified ~= false then
        for i = 1, #decodedData.leader do
            data.leader:Add(meritV2.LeaderPosition(decodedData.leader[i]))
        end
    end
    return data
end

---@param decodedData meritV2.LeaderPosition lua中的数据结构
---@return meritV2.LeaderPosition C#中的数据结构
function meritV2.LeaderPosition(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.meritV2.LeaderPosition()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.meritValue ~= nil and decodedData.meritValueSpecified ~= false then
        data.meritValue = decodedData.meritValue
    end
    if decodedData.rewardList ~= nil and decodedData.rewardListSpecified ~= false then
        for i = 1, #decodedData.rewardList do
            data.rewardList:Add(meritV2.UnionMeritReward(decodedData.rewardList[i]))
        end
    end
    if decodedData.receiveType ~= nil and decodedData.receiveTypeSpecified ~= false then
        data.receiveType = decodedData.receiveType
    end
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.subtype ~= nil and decodedData.subtypeSpecified ~= false then
        data.subtype = decodedData.subtype
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    return data
end

---@param decodedData meritV2.ResUnionAchievement lua中的数据结构
---@return meritV2.ResUnionAchievement C#中的数据结构
function meritV2.ResUnionAchievement(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.meritV2.ResUnionAchievement()
    if decodedData.stm ~= nil and decodedData.stmSpecified ~= false then
        for i = 1, #decodedData.stm do
            data.stm:Add(meritV2.SubtypeMerit(decodedData.stm[i]))
        end
    end
    return data
end

---@param decodedData meritV2.SubtypeMerit lua中的数据结构
---@return meritV2.SubtypeMerit C#中的数据结构
function meritV2.SubtypeMerit(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.meritV2.SubtypeMerit()
    if decodedData.subtype ~= nil and decodedData.subtypeSpecified ~= false then
        data.subtype = decodedData.subtype
    end
    if decodedData.merit ~= nil and decodedData.meritSpecified ~= false then
        for i = 1, #decodedData.merit do
            data.merit:Add(meritV2.Merit(decodedData.merit[i]))
        end
    end
    return data
end

---@param decodedData meritV2.Merit lua中的数据结构
---@return meritV2.Merit C#中的数据结构
function meritV2.Merit(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.meritV2.Merit()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.thisType ~= nil and decodedData.thisTypeSpecified ~= false then
        data.thisType = decodedData.thisType
    end
    if decodedData.theTitle ~= nil and decodedData.theTitleSpecified ~= false then
        data.theTitle = decodedData.theTitle
    end
    if decodedData.rewardList ~= nil and decodedData.rewardListSpecified ~= false then
        for i = 1, #decodedData.rewardList do
            data.rewardList:Add(meritV2.UnionMeritReward(decodedData.rewardList[i]))
        end
    end
    if decodedData.receiveType ~= nil and decodedData.receiveTypeSpecified ~= false then
        data.receiveType = decodedData.receiveType
    end
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData meritV2.ReqPositionInfo lua中的数据结构
---@return meritV2.ReqPositionInfo C#中的数据结构
function meritV2.ReqPositionInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.meritV2.ReqPositionInfo()
    if decodedData.subtype ~= nil and decodedData.subtypeSpecified ~= false then
        data.subtype = decodedData.subtype
    end
    return data
end

---@param decodedData meritV2.ResPositionInfo lua中的数据结构
---@return meritV2.ResPositionInfo C#中的数据结构
function meritV2.ResPositionInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.meritV2.ResPositionInfo()
    if decodedData.leader ~= nil and decodedData.leaderSpecified ~= false then
        for i = 1, #decodedData.leader do
            data.leader:Add(meritV2.LeaderPosition(decodedData.leader[i]))
        end
    end
    return data
end

---@param decodedData meritV2.ResReturnRewardState lua中的数据结构
---@return meritV2.ResReturnRewardState C#中的数据结构
function meritV2.ResReturnRewardState(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.meritV2.ResReturnRewardState()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.subtype ~= nil and decodedData.subtypeSpecified ~= false then
        data.subtype = decodedData.subtype
    end
    if decodedData.rewardState ~= nil and decodedData.rewardStateSpecified ~= false then
        data.rewardState = decodedData.rewardState
    end
    return data
end

---@param decodedData meritV2.ReqRewardUinonBattle lua中的数据结构
---@return meritV2.ReqRewardUinonBattle C#中的数据结构
function meritV2.ReqRewardUinonBattle(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.meritV2.ReqRewardUinonBattle()
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    return data
end

---@param decodedData meritV2.ReqRewardLeaderGlory lua中的数据结构
---@return meritV2.ReqRewardLeaderGlory C#中的数据结构
function meritV2.ReqRewardLeaderGlory(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.meritV2.ReqRewardLeaderGlory()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData meritV2.ReqRewardUnionAchievement lua中的数据结构
---@return meritV2.ReqRewardUnionAchievement C#中的数据结构
function meritV2.ReqRewardUnionAchievement(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.meritV2.ReqRewardUnionAchievement()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData meritV2.ResMeritRedPoint lua中的数据结构
---@return meritV2.ResMeritRedPoint C#中的数据结构
function meritV2.ResMeritRedPoint(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.meritV2.ResMeritRedPoint()
    if decodedData.idList ~= nil and decodedData.idListSpecified ~= false then
        for i = 1, #decodedData.idList do
            data.idList:Add(decodedData.idList[i])
        end
    end
    return data
end

return meritV2