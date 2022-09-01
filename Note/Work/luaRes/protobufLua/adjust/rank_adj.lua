--[[本文件为工具自动生成,禁止手动修改]]
local rankV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable rankV2.RoleRankInfo
---@type rankV2.RoleRankInfo
rankV2_adj.metatable_RoleRankInfo = {
    _ClassName = "rankV2.RoleRankInfo",
}
rankV2_adj.metatable_RoleRankInfo.__index = rankV2_adj.metatable_RoleRankInfo
--endregion

---@param tbl rankV2.RoleRankInfo 待调整的table数据
function rankV2_adj.AdjustRoleRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rankV2_adj.metatable_RoleRankInfo)
    if tbl.uid == nil then
        tbl.uidSpecified = false
        tbl.uid = 0
    else
        tbl.uidSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.vipLevel == nil then
        tbl.vipLevelSpecified = false
        tbl.vipLevel = 0
    else
        tbl.vipLevelSpecified = true
    end
    if tbl.rein == nil then
        tbl.reinSpecified = false
        tbl.rein = 0
    else
        tbl.reinSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.fightPower == nil then
        tbl.fightPowerSpecified = false
        tbl.fightPower = 0
    else
        tbl.fightPowerSpecified = true
    end
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
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
    if tbl.isOnline == nil then
        tbl.isOnlineSpecified = false
        tbl.isOnline = false
    else
        tbl.isOnlineSpecified = true
    end
    if tbl.teamId == nil then
        tbl.teamIdSpecified = false
        tbl.teamId = 0
    else
        tbl.teamIdSpecified = true
    end
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
    if tbl.param == nil then
        tbl.paramSpecified = false
        tbl.param = 0
    else
        tbl.paramSpecified = true
    end
    if tbl.sid == nil then
        tbl.sidSpecified = false
        tbl.sid = 0
    else
        tbl.sidSpecified = true
    end
    if tbl.towerHigh == nil then
        tbl.towerHighSpecified = false
        tbl.towerHigh = 0
    else
        tbl.towerHighSpecified = true
    end
    if tbl.monthCard == nil then
        tbl.monthCardSpecified = false
        tbl.monthCard = 0
    else
        tbl.monthCardSpecified = true
    end
    if tbl.extraParam == nil then
        tbl.extraParamSpecified = false
        tbl.extraParam = 0
    else
        tbl.extraParamSpecified = true
    end
    if tbl.vipMemberLevel == nil then
        tbl.vipMemberLevelSpecified = false
        tbl.vipMemberLevel = 0
    else
        tbl.vipMemberLevelSpecified = true
    end
    if tbl.zhenfaLevel == nil then
        tbl.zhenfaLevelSpecified = false
        tbl.zhenfaLevel = 0
    else
        tbl.zhenfaLevelSpecified = true
    end
    if tbl.zhenfaExp == nil then
        tbl.zhenfaExpSpecified = false
        tbl.zhenfaExp = 0
    else
        tbl.zhenfaExpSpecified = true
    end
    if tbl.zhenfaId == nil then
        tbl.zhenfaIdSpecified = false
        tbl.zhenfaId = 0
    else
        tbl.zhenfaIdSpecified = true
    end
end

--region metatable rankV2.ReqLookRank
---@type rankV2.ReqLookRank
rankV2_adj.metatable_ReqLookRank = {
    _ClassName = "rankV2.ReqLookRank",
}
rankV2_adj.metatable_ReqLookRank.__index = rankV2_adj.metatable_ReqLookRank
--endregion

---@param tbl rankV2.ReqLookRank 待调整的table数据
function rankV2_adj.AdjustReqLookRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rankV2_adj.metatable_ReqLookRank)
    if tbl.rankId == nil then
        tbl.rankIdSpecified = false
        tbl.rankId = 0
    else
        tbl.rankIdSpecified = true
    end
end

--region metatable rankV2.ResLookRank
---@type rankV2.ResLookRank
rankV2_adj.metatable_ResLookRank = {
    _ClassName = "rankV2.ResLookRank",
}
rankV2_adj.metatable_ResLookRank.__index = rankV2_adj.metatable_ResLookRank
--endregion

---@param tbl rankV2.ResLookRank 待调整的table数据
function rankV2_adj.AdjustResLookRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rankV2_adj.metatable_ResLookRank)
    if tbl.roleRankDataInfos == nil then
        tbl.roleRankDataInfos = {}
    else
        if rankV2_adj.AdjustRoleRankDataInfo ~= nil then
            for i = 1, #tbl.roleRankDataInfos do
                rankV2_adj.AdjustRoleRankDataInfo(tbl.roleRankDataInfos[i])
            end
        end
    end
    if tbl.ranking == nil then
        tbl.rankingSpecified = false
        tbl.ranking = 0
    else
        tbl.rankingSpecified = true
    end
    if tbl.rankId == nil then
        tbl.rankIdSpecified = false
        tbl.rankId = 0
    else
        tbl.rankIdSpecified = true
    end
    if tbl.refreshTime == nil then
        tbl.refreshTimeSpecified = false
        tbl.refreshTime = 0
    else
        tbl.refreshTimeSpecified = true
    end
end

--region metatable rankV2.RoleRankDataInfo
---@type rankV2.RoleRankDataInfo
rankV2_adj.metatable_RoleRankDataInfo = {
    _ClassName = "rankV2.RoleRankDataInfo",
}
rankV2_adj.metatable_RoleRankDataInfo.__index = rankV2_adj.metatable_RoleRankDataInfo
--endregion

---@param tbl rankV2.RoleRankDataInfo 待调整的table数据
function rankV2_adj.AdjustRoleRankDataInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rankV2_adj.metatable_RoleRankDataInfo)
    if tbl.roleRankInfo == nil then
        tbl.roleRankInfoSpecified = false
        tbl.roleRankInfo = nil
    else
        if tbl.roleRankInfoSpecified == nil then 
            tbl.roleRankInfoSpecified = true
            if rankV2_adj.AdjustRoleRankInfo ~= nil then
                rankV2_adj.AdjustRoleRankInfo(tbl.roleRankInfo)
            end
        end
    end
    if tbl.wifeRankInfo == nil then
        tbl.wifeRankInfoSpecified = false
        tbl.wifeRankInfo = nil
    else
        if tbl.wifeRankInfoSpecified == nil then 
            tbl.wifeRankInfoSpecified = true
            if rankV2_adj.AdjustRoleRankInfo ~= nil then
                rankV2_adj.AdjustRoleRankInfo(tbl.wifeRankInfo)
            end
        end
    end
    if tbl.servantRankInfo == nil then
        tbl.servantRankInfoSpecified = false
        tbl.servantRankInfo = nil
    else
        if tbl.servantRankInfoSpecified == nil then 
            tbl.servantRankInfoSpecified = true
            if rankV2_adj.AdjustServantRankInfo ~= nil then
                rankV2_adj.AdjustServantRankInfo(tbl.servantRankInfo)
            end
        end
    end
    if tbl.damageItemRankInfo == nil then
        tbl.damageItemRankInfoSpecified = false
        tbl.damageItemRankInfo = nil
    else
        if tbl.damageItemRankInfoSpecified == nil then 
            tbl.damageItemRankInfoSpecified = true
            if rankV2_adj.AdjustDamageItemRankInfo ~= nil then
                rankV2_adj.AdjustDamageItemRankInfo(tbl.damageItemRankInfo)
            end
        end
    end
end

--region metatable rankV2.ReqRankRewardInfo
---@type rankV2.ReqRankRewardInfo
rankV2_adj.metatable_ReqRankRewardInfo = {
    _ClassName = "rankV2.ReqRankRewardInfo",
}
rankV2_adj.metatable_ReqRankRewardInfo.__index = rankV2_adj.metatable_ReqRankRewardInfo
--endregion

---@param tbl rankV2.ReqRankRewardInfo 待调整的table数据
function rankV2_adj.AdjustReqRankRewardInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rankV2_adj.metatable_ReqRankRewardInfo)
    if tbl.rankId == nil then
        tbl.rankIdSpecified = false
        tbl.rankId = 0
    else
        tbl.rankIdSpecified = true
    end
end

--region metatable rankV2.ResRankRewardInfo
---@type rankV2.ResRankRewardInfo
rankV2_adj.metatable_ResRankRewardInfo = {
    _ClassName = "rankV2.ResRankRewardInfo",
}
rankV2_adj.metatable_ResRankRewardInfo.__index = rankV2_adj.metatable_ResRankRewardInfo
--endregion

---@param tbl rankV2.ResRankRewardInfo 待调整的table数据
function rankV2_adj.AdjustResRankRewardInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rankV2_adj.metatable_ResRankRewardInfo)
    if tbl.rankId == nil then
        tbl.rankIdSpecified = false
        tbl.rankId = 0
    else
        tbl.rankIdSpecified = true
    end
    if tbl.refreshTime == nil then
        tbl.refreshTimeSpecified = false
        tbl.refreshTime = 0
    else
        tbl.refreshTimeSpecified = true
    end
    if tbl.yesterdayRank == nil then
        tbl.yesterdayRankSpecified = false
        tbl.yesterdayRank = 0
    else
        tbl.yesterdayRankSpecified = true
    end
    if tbl.isReceive == nil then
        tbl.isReceiveSpecified = false
        tbl.isReceive = false
    else
        tbl.isReceiveSpecified = true
    end
    if tbl.todayRank == nil then
        tbl.todayRankSpecified = false
        tbl.todayRank = 0
    else
        tbl.todayRankSpecified = true
    end
end

--region metatable rankV2.ReqReceiveReward
---@type rankV2.ReqReceiveReward
rankV2_adj.metatable_ReqReceiveReward = {
    _ClassName = "rankV2.ReqReceiveReward",
}
rankV2_adj.metatable_ReqReceiveReward.__index = rankV2_adj.metatable_ReqReceiveReward
--endregion

---@param tbl rankV2.ReqReceiveReward 待调整的table数据
function rankV2_adj.AdjustReqReceiveReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rankV2_adj.metatable_ReqReceiveReward)
    if tbl.rankId == nil then
        tbl.rankIdSpecified = false
        tbl.rankId = 0
    else
        tbl.rankIdSpecified = true
    end
end

--region metatable rankV2.ResUnRewardRankTypes
---@type rankV2.ResUnRewardRankTypes
rankV2_adj.metatable_ResUnRewardRankTypes = {
    _ClassName = "rankV2.ResUnRewardRankTypes",
}
rankV2_adj.metatable_ResUnRewardRankTypes.__index = rankV2_adj.metatable_ResUnRewardRankTypes
--endregion

---@param tbl rankV2.ResUnRewardRankTypes 待调整的table数据
function rankV2_adj.AdjustResUnRewardRankTypes(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rankV2_adj.metatable_ResUnRewardRankTypes)
    if tbl.rankId == nil then
        tbl.rankId = {}
    end
end

--region metatable rankV2.SingleServantRankInfo
---@type rankV2.SingleServantRankInfo
rankV2_adj.metatable_SingleServantRankInfo = {
    _ClassName = "rankV2.SingleServantRankInfo",
}
rankV2_adj.metatable_SingleServantRankInfo.__index = rankV2_adj.metatable_SingleServantRankInfo
--endregion

---@param tbl rankV2.SingleServantRankInfo 待调整的table数据
function rankV2_adj.AdjustSingleServantRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rankV2_adj.metatable_SingleServantRankInfo)
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable rankV2.ServantRankInfo
---@type rankV2.ServantRankInfo
rankV2_adj.metatable_ServantRankInfo = {
    _ClassName = "rankV2.ServantRankInfo",
}
rankV2_adj.metatable_ServantRankInfo.__index = rankV2_adj.metatable_ServantRankInfo
--endregion

---@param tbl rankV2.ServantRankInfo 待调整的table数据
function rankV2_adj.AdjustServantRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rankV2_adj.metatable_ServantRankInfo)
    if tbl.servants == nil then
        tbl.servants = {}
    else
        if rankV2_adj.AdjustSingleServantRankInfo ~= nil then
            for i = 1, #tbl.servants do
                rankV2_adj.AdjustSingleServantRankInfo(tbl.servants[i])
            end
        end
    end
end

--region metatable rankV2.DamageItemRankInfo
---@type rankV2.DamageItemRankInfo
rankV2_adj.metatable_DamageItemRankInfo = {
    _ClassName = "rankV2.DamageItemRankInfo",
}
rankV2_adj.metatable_DamageItemRankInfo.__index = rankV2_adj.metatable_DamageItemRankInfo
--endregion

---@param tbl rankV2.DamageItemRankInfo 待调整的table数据
function rankV2_adj.AdjustDamageItemRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rankV2_adj.metatable_DamageItemRankInfo)
    if tbl.infos == nil then
        tbl.infosSpecified = false
        tbl.infos = nil
    else
        if tbl.infosSpecified == nil then 
            tbl.infosSpecified = true
            if rankV2_adj.AdjustItemsInfo ~= nil then
                rankV2_adj.AdjustItemsInfo(tbl.infos)
            end
        end
    end
end

--region metatable rankV2.ItemsInfo
---@type rankV2.ItemsInfo
rankV2_adj.metatable_ItemsInfo = {
    _ClassName = "rankV2.ItemsInfo",
}
rankV2_adj.metatable_ItemsInfo.__index = rankV2_adj.metatable_ItemsInfo
--endregion

---@param tbl rankV2.ItemsInfo 待调整的table数据
function rankV2_adj.AdjustItemsInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rankV2_adj.metatable_ItemsInfo)
    if tbl.infos == nil then
        tbl.infos = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.infos do
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.infos[i])
            end
        end
    end
end

--region metatable rankV2.ReqRankDetail
---@type rankV2.ReqRankDetail
rankV2_adj.metatable_ReqRankDetail = {
    _ClassName = "rankV2.ReqRankDetail",
}
rankV2_adj.metatable_ReqRankDetail.__index = rankV2_adj.metatable_ReqRankDetail
--endregion

---@param tbl rankV2.ReqRankDetail 待调整的table数据
function rankV2_adj.AdjustReqRankDetail(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rankV2_adj.metatable_ReqRankDetail)
    if tbl.rankId == nil then
        tbl.rankIdSpecified = false
        tbl.rankId = 0
    else
        tbl.rankIdSpecified = true
    end
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
end

return rankV2_adj