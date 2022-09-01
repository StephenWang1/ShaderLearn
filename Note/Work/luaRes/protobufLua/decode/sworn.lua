--[[本文件为工具自动生成,禁止手动修改]]
local swornV2 = {}

local decodeTable = protobufMgr.DecodeTable

--[[swornV2.ResHasSworn 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData swornV2.SendSwornInfo lua中的数据结构
---@return swornV2.SendSwornInfo C#中的数据结构
function swornV2.SendSwornInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.swornV2.SendSwornInfo()
    if decodedData.swornInfo ~= nil and decodedData.swornInfoSpecified ~= false then
        for i = 1, #decodedData.swornInfo do
            data.swornInfo:Add(swornV2.StartBrotherInfo(decodedData.swornInfo[i]))
        end
    end
    if decodedData.leaderId ~= nil and decodedData.leaderIdSpecified ~= false then
        data.leaderId = decodedData.leaderId
    end
    if decodedData.longTime ~= nil and decodedData.longTimeSpecified ~= false then
        data.longTime = decodedData.longTime
    end
    return data
end

---@param decodedData swornV2.StartBrotherInfo lua中的数据结构
---@return swornV2.StartBrotherInfo C#中的数据结构
function swornV2.StartBrotherInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.swornV2.StartBrotherInfo()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.isAgree ~= nil and decodedData.isAgreeSpecified ~= false then
        data.isAgree = decodedData.isAgree
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    return data
end

---@param decodedData swornV2.BrotherInfo lua中的数据结构
---@return swornV2.BrotherInfo C#中的数据结构
function swornV2.BrotherInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.swornV2.BrotherInfo()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.intimacy ~= nil and decodedData.intimacySpecified ~= false then
        data.intimacy = decodedData.intimacy
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.isDissolution ~= nil and decodedData.isDissolutionSpecified ~= false then
        data.isDissolution = decodedData.isDissolution
    end
    if decodedData.disTime ~= nil and decodedData.disTimeSpecified ~= false then
        data.disTime = decodedData.disTime
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    return data
end

---@param decodedData swornV2.ResYourBrother lua中的数据结构
---@return swornV2.ResYourBrother C#中的数据结构
function swornV2.ResYourBrother(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.swornV2.ResYourBrother()
    if decodedData.brothers ~= nil and decodedData.brothersSpecified ~= false then
        for i = 1, #decodedData.brothers do
            data.brothers:Add(swornV2.BrotherInfo(decodedData.brothers[i]))
        end
    end
    return data
end

---@param decodedData swornV2.ReqAgreeSworn lua中的数据结构
---@return swornV2.ReqAgreeSworn C#中的数据结构
function swornV2.ReqAgreeSworn(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.swornV2.ReqAgreeSworn()
    if decodedData.agree ~= nil and decodedData.agreeSpecified ~= false then
        data.agree = decodedData.agree
    end
    return data
end

---@param decodedData swornV2.ResAgreeSworn lua中的数据结构
---@return swornV2.ResAgreeSworn C#中的数据结构
function swornV2.ResAgreeSworn(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.swornV2.ResAgreeSworn()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.isAgree ~= nil and decodedData.isAgreeSpecified ~= false then
        data.isAgree = decodedData.isAgree
    end
    return data
end

--[[swornV2.ResSwornSuccess 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData swornV2.ReqDissolutionBrother lua中的数据结构
---@return swornV2.ReqDissolutionBrother C#中的数据结构
function swornV2.ReqDissolutionBrother(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.swornV2.ReqDissolutionBrother()
    if decodedData.brotherId ~= nil and decodedData.brotherIdSpecified ~= false then
        data.brotherId = decodedData.brotherId
    end
    return data
end

---@param decodedData swornV2.ReqRegretsDissolution lua中的数据结构
---@return swornV2.ReqRegretsDissolution C#中的数据结构
function swornV2.ReqRegretsDissolution(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.swornV2.ReqRegretsDissolution()
    if decodedData.brotherId ~= nil and decodedData.brotherIdSpecified ~= false then
        data.brotherId = decodedData.brotherId
    end
    return data
end

---@param decodedData swornV2.ResAddBrother lua中的数据结构
---@return swornV2.ResAddBrother C#中的数据结构
function swornV2.ResAddBrother(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.swornV2.ResAddBrother()
    if decodedData.addBrothers ~= nil and decodedData.addBrothersSpecified ~= false then
        for i = 1, #decodedData.addBrothers do
            data.addBrothers:Add(swornV2.BrotherInfo(decodedData.addBrothers[i]))
        end
    end
    return data
end

---@param decodedData swornV2.ResRemoveBrother lua中的数据结构
---@return swornV2.ResRemoveBrother C#中的数据结构
function swornV2.ResRemoveBrother(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.swornV2.ResRemoveBrother()
    if decodedData.removeBrothers ~= nil and decodedData.removeBrothersSpecified ~= false then
        data.removeBrothers = swornV2.BrotherInfo(decodedData.removeBrothers)
    end
    return data
end

---@param decodedData swornV2.ResOneBrother lua中的数据结构
---@return swornV2.ResOneBrother C#中的数据结构
function swornV2.ResOneBrother(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.swornV2.ResOneBrother()
    if decodedData.theBrothers ~= nil and decodedData.theBrothersSpecified ~= false then
        data.theBrothers = swornV2.BrotherInfo(decodedData.theBrothers)
    end
    return data
end

---@param decodedData swornV2.ResBreakOffRelations lua中的数据结构
---@return swornV2.ResBreakOffRelations C#中的数据结构
function swornV2.ResBreakOffRelations(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.swornV2.ResBreakOffRelations()
    if decodedData.addBrothers ~= nil and decodedData.addBrothersSpecified ~= false then
        for i = 1, #decodedData.addBrothers do
            data.addBrothers:Add(swornV2.BrotherInfo(decodedData.addBrothers[i]))
        end
    end
    return data
end

---@param decodedData swornV2.ResSpecialEffects lua中的数据结构
---@return swornV2.ResSpecialEffects C#中的数据结构
function swornV2.ResSpecialEffects(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.swornV2.ResSpecialEffects()
    if decodedData.idList ~= nil and decodedData.idListSpecified ~= false then
        for i = 1, #decodedData.idList do
            data.idList:Add(decodedData.idList[i])
        end
    end
    return data
end

---@param decodedData swornV2.ResInterruptSworn lua中的数据结构
---@return swornV2.ResInterruptSworn C#中的数据结构
function swornV2.ResInterruptSworn(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.swornV2.ResInterruptSworn()
    if decodedData.idList ~= nil and decodedData.idListSpecified ~= false then
        for i = 1, #decodedData.idList do
            data.idList:Add(decodedData.idList[i])
        end
    end
    return data
end

return swornV2