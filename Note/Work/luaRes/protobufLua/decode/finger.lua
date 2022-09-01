--[[本文件为工具自动生成,禁止手动修改]]
local fingerV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData fingerV2.PlayerInfo lua中的数据结构
---@return fingerV2.PlayerInfo C#中的数据结构
function fingerV2.PlayerInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fingerV2.PlayerInfo()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.rank ~= nil and decodedData.rankSpecified ~= false then
        data.rank = decodedData.rank
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    return data
end

--[[fingerV2.LatelyFingerPlayers 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData fingerV2.GamePlayer lua中的数据结构
---@return fingerV2.GamePlayer C#中的数据结构
function fingerV2.GamePlayer(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fingerV2.GamePlayer()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    return data
end

---@param decodedData fingerV2.ReqInviteFinger lua中的数据结构
---@return fingerV2.ReqInviteFinger C#中的数据结构
function fingerV2.ReqInviteFinger(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fingerV2.ReqInviteFinger()
    if decodedData.playerId ~= nil and decodedData.playerIdSpecified ~= false then
        data.playerId = decodedData.playerId
    end
    if decodedData.playerName ~= nil and decodedData.playerNameSpecified ~= false then
        data.playerName = decodedData.playerName
    end
    return data
end

--[[fingerV2.ResInviteFinger 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData fingerV2.ReqEchoInvite lua中的数据结构
---@return fingerV2.ReqEchoInvite C#中的数据结构
function fingerV2.ReqEchoInvite(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fingerV2.ReqEchoInvite()
    if decodedData.dealerId ~= nil and decodedData.dealerIdSpecified ~= false then
        data.dealerId = decodedData.dealerId
    end
    if decodedData.isPlay ~= nil and decodedData.isPlaySpecified ~= false then
        data.isPlay = decodedData.isPlay
    end
    return data
end

---@param decodedData fingerV2.ResEchoInvite lua中的数据结构
---@return fingerV2.ResEchoInvite C#中的数据结构
function fingerV2.ResEchoInvite(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fingerV2.ResEchoInvite()
    if decodedData.dealer ~= nil and decodedData.dealerSpecified ~= false then
        data.dealer = fingerV2.PlayerInfo(decodedData.dealer)
    end
    if decodedData.player ~= nil and decodedData.playerSpecified ~= false then
        data.player = fingerV2.PlayerInfo(decodedData.player)
    end
    if decodedData.rewardInfo ~= nil and decodedData.rewardInfoSpecified ~= false then
        data.rewardInfo = fingerV2.ResRewardInfo(decodedData.rewardInfo)
    end
    return data
end

---@param decodedData fingerV2.ReqUseChip lua中的数据结构
---@return fingerV2.ReqUseChip C#中的数据结构
function fingerV2.ReqUseChip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fingerV2.ReqUseChip()
    if decodedData.chipNum ~= nil and decodedData.chipNumSpecified ~= false then
        data.chipNum = decodedData.chipNum
    end
    return data
end

---@param decodedData fingerV2.RewardInfo lua中的数据结构
---@return fingerV2.RewardInfo C#中的数据结构
function fingerV2.RewardInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fingerV2.RewardInfo()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.score ~= nil and decodedData.scoreSpecified ~= false then
        data.score = decodedData.score
    end
    if decodedData.chip ~= nil and decodedData.chipSpecified ~= false then
        data.chip = decodedData.chip
    end
    if decodedData.winScore ~= nil and decodedData.winScoreSpecified ~= false then
        data.winScore = decodedData.winScore
    end
    if decodedData.winChip ~= nil and decodedData.winChipSpecified ~= false then
        data.winChip = decodedData.winChip
    end
    return data
end

---@param decodedData fingerV2.ResRewardInfo lua中的数据结构
---@return fingerV2.ResRewardInfo C#中的数据结构
function fingerV2.ResRewardInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fingerV2.ResRewardInfo()
    if decodedData.dealerReward ~= nil and decodedData.dealerRewardSpecified ~= false then
        data.dealerReward = fingerV2.RewardInfo(decodedData.dealerReward)
    end
    if decodedData.playerReward ~= nil and decodedData.playerRewardSpecified ~= false then
        data.playerReward = fingerV2.RewardInfo(decodedData.playerReward)
    end
    return data
end

---@param decodedData fingerV2.ReqChoseFinger lua中的数据结构
---@return fingerV2.ReqChoseFinger C#中的数据结构
function fingerV2.ReqChoseFinger(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fingerV2.ReqChoseFinger()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData fingerV2.ResAllChosed lua中的数据结构
---@return fingerV2.ResAllChosed C#中的数据结构
function fingerV2.ResAllChosed(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fingerV2.ResAllChosed()
    if decodedData.dealerId ~= nil and decodedData.dealerIdSpecified ~= false then
        data.dealerId = decodedData.dealerId
    end
    if decodedData.dealerChose ~= nil and decodedData.dealerChoseSpecified ~= false then
        data.dealerChose = decodedData.dealerChose
    end
    if decodedData.playerId ~= nil and decodedData.playerIdSpecified ~= false then
        data.playerId = decodedData.playerId
    end
    if decodedData.playerChose ~= nil and decodedData.playerChoseSpecified ~= false then
        data.playerChose = decodedData.playerChose
    end
    return data
end

---@param decodedData fingerV2.ResFingerReason lua中的数据结构
---@return fingerV2.ResFingerReason C#中的数据结构
function fingerV2.ResFingerReason(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fingerV2.ResFingerReason()
    if decodedData.winner ~= nil and decodedData.winnerSpecified ~= false then
        data.winner = fingerV2.PlayerInfo(decodedData.winner)
    end
    if decodedData.loser ~= nil and decodedData.loserSpecified ~= false then
        data.loser = fingerV2.PlayerInfo(decodedData.loser)
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData fingerV2.ReqEchoInviteTime lua中的数据结构
---@return fingerV2.ReqEchoInviteTime C#中的数据结构
function fingerV2.ReqEchoInviteTime(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fingerV2.ReqEchoInviteTime()
    if decodedData.dealer ~= nil and decodedData.dealerSpecified ~= false then
        data.dealer = decodedData.dealer
    end
    return data
end

---@param decodedData fingerV2.ResTerminate lua中的数据结构
---@return fingerV2.ResTerminate C#中的数据结构
function fingerV2.ResTerminate(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fingerV2.ResTerminate()
    if decodedData.dealer ~= nil and decodedData.dealerSpecified ~= false then
        data.dealer = decodedData.dealer
    end
    if decodedData.player ~= nil and decodedData.playerSpecified ~= false then
        data.player = decodedData.player
    end
    return data
end

return fingerV2