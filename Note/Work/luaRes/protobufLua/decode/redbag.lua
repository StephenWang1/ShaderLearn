--[[本文件为工具自动生成,禁止手动修改]]
local redbagV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData redbagV2.RedBagDonateRequest lua中的数据结构
---@return redbagV2.RedBagDonateRequest C#中的数据结构
function redbagV2.RedBagDonateRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.redbagV2.RedBagDonateRequest()
    data.money = decodedData.money
    if decodedData.isTicket ~= nil and decodedData.isTicketSpecified ~= false then
        data.isTicket = decodedData.isTicket
    end
    return data
end

--[[redbagV2.RedBagInfo 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData redbagV2.SelfRedBagInfo lua中的数据结构
---@return redbagV2.SelfRedBagInfo C#中的数据结构
function redbagV2.SelfRedBagInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.redbagV2.SelfRedBagInfo()
    if decodedData.money ~= nil and decodedData.moneySpecified ~= false then
        data.money = decodedData.money
    end
    if decodedData.rank ~= nil and decodedData.rankSpecified ~= false then
        data.rank = decodedData.rank
    end
    data.getTimes = decodedData.getTimes
    data.lastTime = decodedData.lastTime
    return data
end

---@param decodedData redbagV2.RedBagRankInfo lua中的数据结构
---@return redbagV2.RedBagRankInfo C#中的数据结构
function redbagV2.RedBagRankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.redbagV2.RedBagRankInfo()
    if decodedData.rank ~= nil and decodedData.rankSpecified ~= false then
        data.rank = decodedData.rank
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.money ~= nil and decodedData.moneySpecified ~= false then
        data.money = decodedData.money
    end
    return data
end

---@param decodedData redbagV2.SendRoleInfo lua中的数据结构
---@return redbagV2.SendRoleInfo C#中的数据结构
function redbagV2.SendRoleInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.redbagV2.SendRoleInfo()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    return data
end

return redbagV2