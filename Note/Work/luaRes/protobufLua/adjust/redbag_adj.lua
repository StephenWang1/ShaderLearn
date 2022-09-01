--[[本文件为工具自动生成,禁止手动修改]]
local redbagV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable redbagV2.RedBagDonateRequest
---@type redbagV2.RedBagDonateRequest
redbagV2_adj.metatable_RedBagDonateRequest = {
    _ClassName = "redbagV2.RedBagDonateRequest",
}
redbagV2_adj.metatable_RedBagDonateRequest.__index = redbagV2_adj.metatable_RedBagDonateRequest
--endregion

---@param tbl redbagV2.RedBagDonateRequest 待调整的table数据
function redbagV2_adj.AdjustRedBagDonateRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, redbagV2_adj.metatable_RedBagDonateRequest)
    if tbl.isTicket == nil then
        tbl.isTicketSpecified = false
        tbl.isTicket = false
    else
        tbl.isTicketSpecified = true
    end
end

--region metatable redbagV2.RedBagInfo
---@type redbagV2.RedBagInfo
redbagV2_adj.metatable_RedBagInfo = {
    _ClassName = "redbagV2.RedBagInfo",
}
redbagV2_adj.metatable_RedBagInfo.__index = redbagV2_adj.metatable_RedBagInfo
--endregion

---@param tbl redbagV2.RedBagInfo 待调整的table数据
function redbagV2_adj.AdjustRedBagInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, redbagV2_adj.metatable_RedBagInfo)
    if tbl.moneyPool == nil then
        tbl.moneyPoolSpecified = false
        tbl.moneyPool = 0
    else
        tbl.moneyPoolSpecified = true
    end
    if tbl.history == nil then
        tbl.history = {}
    end
    if tbl.ranks == nil then
        tbl.ranks = {}
    else
        if redbagV2_adj.AdjustRedBagRankInfo ~= nil then
            for i = 1, #tbl.ranks do
                redbagV2_adj.AdjustRedBagRankInfo(tbl.ranks[i])
            end
        end
    end
    if tbl.selfInfo == nil then
        tbl.selfInfoSpecified = false
        tbl.selfInfo = nil
    else
        if tbl.selfInfoSpecified == nil then 
            tbl.selfInfoSpecified = true
            if redbagV2_adj.AdjustSelfRedBagInfo ~= nil then
                redbagV2_adj.AdjustSelfRedBagInfo(tbl.selfInfo)
            end
        end
    end
    if tbl.getMoney == nil then
        tbl.getMoneySpecified = false
        tbl.getMoney = 0
    else
        tbl.getMoneySpecified = true
    end
    if tbl.sendRole == nil then
        tbl.sendRoleSpecified = false
        tbl.sendRole = nil
    else
        if tbl.sendRoleSpecified == nil then 
            tbl.sendRoleSpecified = true
            if redbagV2_adj.AdjustSendRoleInfo ~= nil then
                redbagV2_adj.AdjustSendRoleInfo(tbl.sendRole)
            end
        end
    end
    if tbl.haveFirstGet == nil then
        tbl.haveFirstGetSpecified = false
        tbl.haveFirstGet = false
    else
        tbl.haveFirstGetSpecified = true
    end
end

--region metatable redbagV2.SelfRedBagInfo
---@type redbagV2.SelfRedBagInfo
redbagV2_adj.metatable_SelfRedBagInfo = {
    _ClassName = "redbagV2.SelfRedBagInfo",
}
redbagV2_adj.metatable_SelfRedBagInfo.__index = redbagV2_adj.metatable_SelfRedBagInfo
--endregion

---@param tbl redbagV2.SelfRedBagInfo 待调整的table数据
function redbagV2_adj.AdjustSelfRedBagInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, redbagV2_adj.metatable_SelfRedBagInfo)
    if tbl.money == nil then
        tbl.moneySpecified = false
        tbl.money = 0
    else
        tbl.moneySpecified = true
    end
    if tbl.rank == nil then
        tbl.rankSpecified = false
        tbl.rank = 0
    else
        tbl.rankSpecified = true
    end
end

--region metatable redbagV2.RedBagRankInfo
---@type redbagV2.RedBagRankInfo
redbagV2_adj.metatable_RedBagRankInfo = {
    _ClassName = "redbagV2.RedBagRankInfo",
}
redbagV2_adj.metatable_RedBagRankInfo.__index = redbagV2_adj.metatable_RedBagRankInfo
--endregion

---@param tbl redbagV2.RedBagRankInfo 待调整的table数据
function redbagV2_adj.AdjustRedBagRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, redbagV2_adj.metatable_RedBagRankInfo)
    if tbl.rank == nil then
        tbl.rankSpecified = false
        tbl.rank = 0
    else
        tbl.rankSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.money == nil then
        tbl.moneySpecified = false
        tbl.money = 0
    else
        tbl.moneySpecified = true
    end
end

--region metatable redbagV2.SendRoleInfo
---@type redbagV2.SendRoleInfo
redbagV2_adj.metatable_SendRoleInfo = {
    _ClassName = "redbagV2.SendRoleInfo",
}
redbagV2_adj.metatable_SendRoleInfo.__index = redbagV2_adj.metatable_SendRoleInfo
--endregion

---@param tbl redbagV2.SendRoleInfo 待调整的table数据
function redbagV2_adj.AdjustSendRoleInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, redbagV2_adj.metatable_SendRoleInfo)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
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
end

return redbagV2_adj