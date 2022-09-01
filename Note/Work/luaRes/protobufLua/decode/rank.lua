--[[本文件为工具自动生成,禁止手动修改]]
local rankV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData rankV2.RoleRankInfo lua中的数据结构
---@return rankV2.RoleRankInfo C#中的数据结构
function rankV2.RoleRankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rankV2.RoleRankInfo()
    if decodedData.uid ~= nil and decodedData.uidSpecified ~= false then
        data.uid = decodedData.uid
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.vipLevel ~= nil and decodedData.vipLevelSpecified ~= false then
        data.vipLevel = decodedData.vipLevel
    end
    if decodedData.rein ~= nil and decodedData.reinSpecified ~= false then
        data.rein = decodedData.rein
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.fightPower ~= nil and decodedData.fightPowerSpecified ~= false then
        data.fightPower = decodedData.fightPower
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.isOnline ~= nil and decodedData.isOnlineSpecified ~= false then
        data.isOnline = decodedData.isOnline
    end
    if decodedData.teamId ~= nil and decodedData.teamIdSpecified ~= false then
        data.teamId = decodedData.teamId
    end
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.param ~= nil and decodedData.paramSpecified ~= false then
        data.param = decodedData.param
    end
    if decodedData.sid ~= nil and decodedData.sidSpecified ~= false then
        data.sid = decodedData.sid
    end
    if decodedData.towerHigh ~= nil and decodedData.towerHighSpecified ~= false then
        data.towerHigh = decodedData.towerHigh
    end
    --C#的rankV2.RoleRankInfo类中没有找到monthCard字段,不填充数据
    --C#的rankV2.RoleRankInfo类中没有找到extraParam字段,不填充数据
    --C#的rankV2.RoleRankInfo类中没有找到vipMemberLevel字段,不填充数据
    --C#的rankV2.RoleRankInfo类中没有找到zhenfaLevel字段,不填充数据
    --C#的rankV2.RoleRankInfo类中没有找到zhenfaExp字段,不填充数据
    --C#的rankV2.RoleRankInfo类中没有找到zhenfaId字段,不填充数据
    return data
end

---@param decodedData rankV2.ReqLookRank lua中的数据结构
---@return rankV2.ReqLookRank C#中的数据结构
function rankV2.ReqLookRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rankV2.ReqLookRank()
    if decodedData.rankId ~= nil and decodedData.rankIdSpecified ~= false then
        data.rankId = decodedData.rankId
    end
    return data
end

---@param decodedData rankV2.ResLookRank lua中的数据结构
---@return rankV2.ResLookRank C#中的数据结构
function rankV2.ResLookRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rankV2.ResLookRank()
    if decodedData.roleRankDataInfos ~= nil and decodedData.roleRankDataInfosSpecified ~= false then
        for i = 1, #decodedData.roleRankDataInfos do
            data.roleRankDataInfos:Add(rankV2.RoleRankDataInfo(decodedData.roleRankDataInfos[i]))
        end
    end
    if decodedData.ranking ~= nil and decodedData.rankingSpecified ~= false then
        data.ranking = decodedData.ranking
    end
    if decodedData.rankId ~= nil and decodedData.rankIdSpecified ~= false then
        data.rankId = decodedData.rankId
    end
    if decodedData.refreshTime ~= nil and decodedData.refreshTimeSpecified ~= false then
        data.refreshTime = decodedData.refreshTime
    end
    return data
end

---@param decodedData rankV2.RoleRankDataInfo lua中的数据结构
---@return rankV2.RoleRankDataInfo C#中的数据结构
function rankV2.RoleRankDataInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rankV2.RoleRankDataInfo()
    if decodedData.roleRankInfo ~= nil and decodedData.roleRankInfoSpecified ~= false then
        data.roleRankInfo = rankV2.RoleRankInfo(decodedData.roleRankInfo)
    end
    if decodedData.wifeRankInfo ~= nil and decodedData.wifeRankInfoSpecified ~= false then
        data.wifeRankInfo = rankV2.RoleRankInfo(decodedData.wifeRankInfo)
    end
    if decodedData.servantRankInfo ~= nil and decodedData.servantRankInfoSpecified ~= false then
        data.servantRankInfo = rankV2.ServantRankInfo(decodedData.servantRankInfo)
    end
    if decodedData.damageItemRankInfo ~= nil and decodedData.damageItemRankInfoSpecified ~= false then
        data.damageItemRankInfo = rankV2.DamageItemRankInfo(decodedData.damageItemRankInfo)
    end
    return data
end

---@param decodedData rankV2.ReqRankRewardInfo lua中的数据结构
---@return rankV2.ReqRankRewardInfo C#中的数据结构
function rankV2.ReqRankRewardInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rankV2.ReqRankRewardInfo()
    if decodedData.rankId ~= nil and decodedData.rankIdSpecified ~= false then
        data.rankId = decodedData.rankId
    end
    return data
end

---@param decodedData rankV2.ResRankRewardInfo lua中的数据结构
---@return rankV2.ResRankRewardInfo C#中的数据结构
function rankV2.ResRankRewardInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rankV2.ResRankRewardInfo()
    if decodedData.rankId ~= nil and decodedData.rankIdSpecified ~= false then
        data.rankId = decodedData.rankId
    end
    if decodedData.refreshTime ~= nil and decodedData.refreshTimeSpecified ~= false then
        data.refreshTime = decodedData.refreshTime
    end
    if decodedData.yesterdayRank ~= nil and decodedData.yesterdayRankSpecified ~= false then
        data.yesterdayRank = decodedData.yesterdayRank
    end
    if decodedData.isReceive ~= nil and decodedData.isReceiveSpecified ~= false then
        data.isReceive = decodedData.isReceive
    end
    if decodedData.todayRank ~= nil and decodedData.todayRankSpecified ~= false then
        data.todayRank = decodedData.todayRank
    end
    return data
end

---@param decodedData rankV2.ReqReceiveReward lua中的数据结构
---@return rankV2.ReqReceiveReward C#中的数据结构
function rankV2.ReqReceiveReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rankV2.ReqReceiveReward()
    if decodedData.rankId ~= nil and decodedData.rankIdSpecified ~= false then
        data.rankId = decodedData.rankId
    end
    return data
end

---@param decodedData rankV2.ResUnRewardRankTypes lua中的数据结构
---@return rankV2.ResUnRewardRankTypes C#中的数据结构
function rankV2.ResUnRewardRankTypes(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rankV2.ResUnRewardRankTypes()
    if decodedData.rankId ~= nil and decodedData.rankIdSpecified ~= false then
        for i = 1, #decodedData.rankId do
            data.rankId:Add(decodedData.rankId[i])
        end
    end
    return data
end

---@param decodedData rankV2.SingleServantRankInfo lua中的数据结构
---@return rankV2.SingleServantRankInfo C#中的数据结构
function rankV2.SingleServantRankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rankV2.SingleServantRankInfo()
    data.servantCfgId = decodedData.servantCfgId
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData rankV2.ServantRankInfo lua中的数据结构
---@return rankV2.ServantRankInfo C#中的数据结构
function rankV2.ServantRankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rankV2.ServantRankInfo()
    data.roleId = decodedData.roleId
    if decodedData.servants ~= nil and decodedData.servantsSpecified ~= false then
        for i = 1, #decodedData.servants do
            data.servants:Add(rankV2.SingleServantRankInfo(decodedData.servants[i]))
        end
    end
    return data
end

---@param decodedData rankV2.DamageItemRankInfo lua中的数据结构
---@return rankV2.DamageItemRankInfo C#中的数据结构
function rankV2.DamageItemRankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rankV2.DamageItemRankInfo()
    if decodedData.infos ~= nil and decodedData.infosSpecified ~= false then
        data.infos = rankV2.ItemsInfo(decodedData.infos)
    end
    return data
end

---@param decodedData rankV2.ItemsInfo lua中的数据结构
---@return rankV2.ItemsInfo C#中的数据结构
function rankV2.ItemsInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rankV2.ItemsInfo()
    if decodedData.infos ~= nil and decodedData.infosSpecified ~= false then
        for i = 1, #decodedData.infos do
            data.infos:Add(decodeTable.bag.BagItemInfo(decodedData.infos[i]))
        end
    end
    return data
end

---@param decodedData rankV2.ReqRankDetail lua中的数据结构
---@return rankV2.ReqRankDetail C#中的数据结构
function rankV2.ReqRankDetail(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rankV2.ReqRankDetail()
    if decodedData.rankId ~= nil and decodedData.rankIdSpecified ~= false then
        data.rankId = decodedData.rankId
    end
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    return data
end

return rankV2