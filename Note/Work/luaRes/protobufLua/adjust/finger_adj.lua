--[[本文件为工具自动生成,禁止手动修改]]
local fingerV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable fingerV2.PlayerInfo
---@type fingerV2.PlayerInfo
fingerV2_adj.metatable_PlayerInfo = {
    _ClassName = "fingerV2.PlayerInfo",
}
fingerV2_adj.metatable_PlayerInfo.__index = fingerV2_adj.metatable_PlayerInfo
--endregion

---@param tbl fingerV2.PlayerInfo 待调整的table数据
function fingerV2_adj.AdjustPlayerInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fingerV2_adj.metatable_PlayerInfo)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
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
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.rank == nil then
        tbl.rankSpecified = false
        tbl.rank = 0
    else
        tbl.rankSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
end

--region metatable fingerV2.LatelyFingerPlayers
---@type fingerV2.LatelyFingerPlayers
fingerV2_adj.metatable_LatelyFingerPlayers = {
    _ClassName = "fingerV2.LatelyFingerPlayers",
}
fingerV2_adj.metatable_LatelyFingerPlayers.__index = fingerV2_adj.metatable_LatelyFingerPlayers
--endregion

---@param tbl fingerV2.LatelyFingerPlayers 待调整的table数据
function fingerV2_adj.AdjustLatelyFingerPlayers(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fingerV2_adj.metatable_LatelyFingerPlayers)
    if tbl.players == nil then
        tbl.players = {}
    else
        if fingerV2_adj.AdjustGamePlayer ~= nil then
            for i = 1, #tbl.players do
                fingerV2_adj.AdjustGamePlayer(tbl.players[i])
            end
        end
    end
end

--region metatable fingerV2.GamePlayer
---@type fingerV2.GamePlayer
fingerV2_adj.metatable_GamePlayer = {
    _ClassName = "fingerV2.GamePlayer",
}
fingerV2_adj.metatable_GamePlayer.__index = fingerV2_adj.metatable_GamePlayer
--endregion

---@param tbl fingerV2.GamePlayer 待调整的table数据
function fingerV2_adj.AdjustGamePlayer(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fingerV2_adj.metatable_GamePlayer)
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
end

--region metatable fingerV2.ReqInviteFinger
---@type fingerV2.ReqInviteFinger
fingerV2_adj.metatable_ReqInviteFinger = {
    _ClassName = "fingerV2.ReqInviteFinger",
}
fingerV2_adj.metatable_ReqInviteFinger.__index = fingerV2_adj.metatable_ReqInviteFinger
--endregion

---@param tbl fingerV2.ReqInviteFinger 待调整的table数据
function fingerV2_adj.AdjustReqInviteFinger(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fingerV2_adj.metatable_ReqInviteFinger)
    if tbl.playerId == nil then
        tbl.playerIdSpecified = false
        tbl.playerId = 0
    else
        tbl.playerIdSpecified = true
    end
    if tbl.playerName == nil then
        tbl.playerNameSpecified = false
        tbl.playerName = ""
    else
        tbl.playerNameSpecified = true
    end
end

--region metatable fingerV2.ResInviteFinger
---@type fingerV2.ResInviteFinger
fingerV2_adj.metatable_ResInviteFinger = {
    _ClassName = "fingerV2.ResInviteFinger",
}
fingerV2_adj.metatable_ResInviteFinger.__index = fingerV2_adj.metatable_ResInviteFinger
--endregion

---@param tbl fingerV2.ResInviteFinger 待调整的table数据
function fingerV2_adj.AdjustResInviteFinger(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fingerV2_adj.metatable_ResInviteFinger)
    if tbl.dealerId == nil then
        tbl.dealerIdSpecified = false
        tbl.dealerId = 0
    else
        tbl.dealerIdSpecified = true
    end
    if tbl.dealerName == nil then
        tbl.dealerNameSpecified = false
        tbl.dealerName = ""
    else
        tbl.dealerNameSpecified = true
    end
    if tbl.isDeliver == nil then
        tbl.isDeliverSpecified = false
        tbl.isDeliver = 0
    else
        tbl.isDeliverSpecified = true
    end
    if tbl.limitTime == nil then
        tbl.limitTimeSpecified = false
        tbl.limitTime = 0
    else
        tbl.limitTimeSpecified = true
    end
end

--region metatable fingerV2.ReqEchoInvite
---@type fingerV2.ReqEchoInvite
fingerV2_adj.metatable_ReqEchoInvite = {
    _ClassName = "fingerV2.ReqEchoInvite",
}
fingerV2_adj.metatable_ReqEchoInvite.__index = fingerV2_adj.metatable_ReqEchoInvite
--endregion

---@param tbl fingerV2.ReqEchoInvite 待调整的table数据
function fingerV2_adj.AdjustReqEchoInvite(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fingerV2_adj.metatable_ReqEchoInvite)
    if tbl.dealerId == nil then
        tbl.dealerIdSpecified = false
        tbl.dealerId = 0
    else
        tbl.dealerIdSpecified = true
    end
    if tbl.isPlay == nil then
        tbl.isPlaySpecified = false
        tbl.isPlay = 0
    else
        tbl.isPlaySpecified = true
    end
end

--region metatable fingerV2.ResEchoInvite
---@type fingerV2.ResEchoInvite
fingerV2_adj.metatable_ResEchoInvite = {
    _ClassName = "fingerV2.ResEchoInvite",
}
fingerV2_adj.metatable_ResEchoInvite.__index = fingerV2_adj.metatable_ResEchoInvite
--endregion

---@param tbl fingerV2.ResEchoInvite 待调整的table数据
function fingerV2_adj.AdjustResEchoInvite(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fingerV2_adj.metatable_ResEchoInvite)
    if tbl.dealer == nil then
        tbl.dealerSpecified = false
        tbl.dealer = nil
    else
        if tbl.dealerSpecified == nil then 
            tbl.dealerSpecified = true
            if fingerV2_adj.AdjustPlayerInfo ~= nil then
                fingerV2_adj.AdjustPlayerInfo(tbl.dealer)
            end
        end
    end
    if tbl.player == nil then
        tbl.playerSpecified = false
        tbl.player = nil
    else
        if tbl.playerSpecified == nil then 
            tbl.playerSpecified = true
            if fingerV2_adj.AdjustPlayerInfo ~= nil then
                fingerV2_adj.AdjustPlayerInfo(tbl.player)
            end
        end
    end
    if tbl.rewardInfo == nil then
        tbl.rewardInfoSpecified = false
        tbl.rewardInfo = nil
    else
        if tbl.rewardInfoSpecified == nil then 
            tbl.rewardInfoSpecified = true
            if fingerV2_adj.AdjustResRewardInfo ~= nil then
                fingerV2_adj.AdjustResRewardInfo(tbl.rewardInfo)
            end
        end
    end
end

--region metatable fingerV2.ReqUseChip
---@type fingerV2.ReqUseChip
fingerV2_adj.metatable_ReqUseChip = {
    _ClassName = "fingerV2.ReqUseChip",
}
fingerV2_adj.metatable_ReqUseChip.__index = fingerV2_adj.metatable_ReqUseChip
--endregion

---@param tbl fingerV2.ReqUseChip 待调整的table数据
function fingerV2_adj.AdjustReqUseChip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fingerV2_adj.metatable_ReqUseChip)
    if tbl.chipNum == nil then
        tbl.chipNumSpecified = false
        tbl.chipNum = 0
    else
        tbl.chipNumSpecified = true
    end
end

--region metatable fingerV2.RewardInfo
---@type fingerV2.RewardInfo
fingerV2_adj.metatable_RewardInfo = {
    _ClassName = "fingerV2.RewardInfo",
}
fingerV2_adj.metatable_RewardInfo.__index = fingerV2_adj.metatable_RewardInfo
--endregion

---@param tbl fingerV2.RewardInfo 待调整的table数据
function fingerV2_adj.AdjustRewardInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fingerV2_adj.metatable_RewardInfo)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.score == nil then
        tbl.scoreSpecified = false
        tbl.score = 0
    else
        tbl.scoreSpecified = true
    end
    if tbl.chip == nil then
        tbl.chipSpecified = false
        tbl.chip = 0
    else
        tbl.chipSpecified = true
    end
    if tbl.winScore == nil then
        tbl.winScoreSpecified = false
        tbl.winScore = 0
    else
        tbl.winScoreSpecified = true
    end
    if tbl.winChip == nil then
        tbl.winChipSpecified = false
        tbl.winChip = 0
    else
        tbl.winChipSpecified = true
    end
end

--region metatable fingerV2.ResRewardInfo
---@type fingerV2.ResRewardInfo
fingerV2_adj.metatable_ResRewardInfo = {
    _ClassName = "fingerV2.ResRewardInfo",
}
fingerV2_adj.metatable_ResRewardInfo.__index = fingerV2_adj.metatable_ResRewardInfo
--endregion

---@param tbl fingerV2.ResRewardInfo 待调整的table数据
function fingerV2_adj.AdjustResRewardInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fingerV2_adj.metatable_ResRewardInfo)
    if tbl.dealerReward == nil then
        tbl.dealerRewardSpecified = false
        tbl.dealerReward = nil
    else
        if tbl.dealerRewardSpecified == nil then 
            tbl.dealerRewardSpecified = true
            if fingerV2_adj.AdjustRewardInfo ~= nil then
                fingerV2_adj.AdjustRewardInfo(tbl.dealerReward)
            end
        end
    end
    if tbl.playerReward == nil then
        tbl.playerRewardSpecified = false
        tbl.playerReward = nil
    else
        if tbl.playerRewardSpecified == nil then 
            tbl.playerRewardSpecified = true
            if fingerV2_adj.AdjustRewardInfo ~= nil then
                fingerV2_adj.AdjustRewardInfo(tbl.playerReward)
            end
        end
    end
end

--region metatable fingerV2.ReqChoseFinger
---@type fingerV2.ReqChoseFinger
fingerV2_adj.metatable_ReqChoseFinger = {
    _ClassName = "fingerV2.ReqChoseFinger",
}
fingerV2_adj.metatable_ReqChoseFinger.__index = fingerV2_adj.metatable_ReqChoseFinger
--endregion

---@param tbl fingerV2.ReqChoseFinger 待调整的table数据
function fingerV2_adj.AdjustReqChoseFinger(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fingerV2_adj.metatable_ReqChoseFinger)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable fingerV2.ResAllChosed
---@type fingerV2.ResAllChosed
fingerV2_adj.metatable_ResAllChosed = {
    _ClassName = "fingerV2.ResAllChosed",
}
fingerV2_adj.metatable_ResAllChosed.__index = fingerV2_adj.metatable_ResAllChosed
--endregion

---@param tbl fingerV2.ResAllChosed 待调整的table数据
function fingerV2_adj.AdjustResAllChosed(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fingerV2_adj.metatable_ResAllChosed)
    if tbl.dealerId == nil then
        tbl.dealerIdSpecified = false
        tbl.dealerId = 0
    else
        tbl.dealerIdSpecified = true
    end
    if tbl.dealerChose == nil then
        tbl.dealerChoseSpecified = false
        tbl.dealerChose = 0
    else
        tbl.dealerChoseSpecified = true
    end
    if tbl.playerId == nil then
        tbl.playerIdSpecified = false
        tbl.playerId = 0
    else
        tbl.playerIdSpecified = true
    end
    if tbl.playerChose == nil then
        tbl.playerChoseSpecified = false
        tbl.playerChose = 0
    else
        tbl.playerChoseSpecified = true
    end
end

--region metatable fingerV2.ResFingerReason
---@type fingerV2.ResFingerReason
fingerV2_adj.metatable_ResFingerReason = {
    _ClassName = "fingerV2.ResFingerReason",
}
fingerV2_adj.metatable_ResFingerReason.__index = fingerV2_adj.metatable_ResFingerReason
--endregion

---@param tbl fingerV2.ResFingerReason 待调整的table数据
function fingerV2_adj.AdjustResFingerReason(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fingerV2_adj.metatable_ResFingerReason)
    if tbl.winner == nil then
        tbl.winnerSpecified = false
        tbl.winner = nil
    else
        if tbl.winnerSpecified == nil then 
            tbl.winnerSpecified = true
            if fingerV2_adj.AdjustPlayerInfo ~= nil then
                fingerV2_adj.AdjustPlayerInfo(tbl.winner)
            end
        end
    end
    if tbl.loser == nil then
        tbl.loserSpecified = false
        tbl.loser = nil
    else
        if tbl.loserSpecified == nil then 
            tbl.loserSpecified = true
            if fingerV2_adj.AdjustPlayerInfo ~= nil then
                fingerV2_adj.AdjustPlayerInfo(tbl.loser)
            end
        end
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable fingerV2.ReqEchoInviteTime
---@type fingerV2.ReqEchoInviteTime
fingerV2_adj.metatable_ReqEchoInviteTime = {
    _ClassName = "fingerV2.ReqEchoInviteTime",
}
fingerV2_adj.metatable_ReqEchoInviteTime.__index = fingerV2_adj.metatable_ReqEchoInviteTime
--endregion

---@param tbl fingerV2.ReqEchoInviteTime 待调整的table数据
function fingerV2_adj.AdjustReqEchoInviteTime(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fingerV2_adj.metatable_ReqEchoInviteTime)
    if tbl.dealer == nil then
        tbl.dealerSpecified = false
        tbl.dealer = 0
    else
        tbl.dealerSpecified = true
    end
end

--region metatable fingerV2.ResTerminate
---@type fingerV2.ResTerminate
fingerV2_adj.metatable_ResTerminate = {
    _ClassName = "fingerV2.ResTerminate",
}
fingerV2_adj.metatable_ResTerminate.__index = fingerV2_adj.metatable_ResTerminate
--endregion

---@param tbl fingerV2.ResTerminate 待调整的table数据
function fingerV2_adj.AdjustResTerminate(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fingerV2_adj.metatable_ResTerminate)
    if tbl.dealer == nil then
        tbl.dealerSpecified = false
        tbl.dealer = 0
    else
        tbl.dealerSpecified = true
    end
    if tbl.player == nil then
        tbl.playerSpecified = false
        tbl.player = 0
    else
        tbl.playerSpecified = true
    end
end

return fingerV2_adj