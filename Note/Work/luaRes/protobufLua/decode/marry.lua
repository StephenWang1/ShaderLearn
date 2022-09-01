--[[本文件为工具自动生成,禁止手动修改]]
local marryV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData marryV2.ResMatchmakerPanel lua中的数据结构
---@return marryV2.ResMatchmakerPanel C#中的数据结构
function marryV2.ResMatchmakerPanel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.marryV2.ResMatchmakerPanel()
    data.man = marryV2.MarriedPeople(decodedData.man)
    data.woman = marryV2.MarriedPeople(decodedData.woman)
    data.ringItemId = decodedData.ringItemId
    return data
end

---@param decodedData marryV2.MarriedPeople lua中的数据结构
---@return marryV2.MarriedPeople C#中的数据结构
function marryV2.MarriedPeople(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.marryV2.MarriedPeople()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    return data
end

---@param decodedData marryV2.ReqMatchmaker lua中的数据结构
---@return marryV2.ReqMatchmaker C#中的数据结构
function marryV2.ReqMatchmaker(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.marryV2.ReqMatchmaker()
    if decodedData.matchmaker ~= nil and decodedData.matchmakerSpecified ~= false then
        data.matchmaker = decodedData.matchmaker
    end
    return data
end

---@param decodedData marryV2.ResMatchmaker lua中的数据结构
---@return marryV2.ResMatchmaker C#中的数据结构
function marryV2.ResMatchmaker(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.marryV2.ResMatchmaker()
    if decodedData.checkingMatchmaker ~= nil and decodedData.checkingMatchmakerSpecified ~= false then
        data.checkingMatchmaker = decodedData.checkingMatchmaker
    end
    return data
end

---@param decodedData marryV2.ReqDivorce lua中的数据结构
---@return marryV2.ReqDivorce C#中的数据结构
function marryV2.ReqDivorce(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.marryV2.ReqDivorce()
    if decodedData.divorceType ~= nil and decodedData.divorceTypeSpecified ~= false then
        data.divorceType = decodedData.divorceType
    end
    return data
end

---@param decodedData marryV2.ResDivorce lua中的数据结构
---@return marryV2.ResDivorce C#中的数据结构
function marryV2.ResDivorce(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.marryV2.ResDivorce()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.spouse ~= nil and decodedData.spouseSpecified ~= false then
        data.spouse = marryV2.MarriedPeople(decodedData.spouse)
    end
    return data
end

---@param decodedData marryV2.ResConfirmDivorce lua中的数据结构
---@return marryV2.ResConfirmDivorce C#中的数据结构
function marryV2.ResConfirmDivorce(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.marryV2.ResConfirmDivorce()
    if decodedData.confirmDivorceType ~= nil and decodedData.confirmDivorceTypeSpecified ~= false then
        data.confirmDivorceType = decodedData.confirmDivorceType
    end
    if decodedData.spouse ~= nil and decodedData.spouseSpecified ~= false then
        data.spouse = marryV2.MarriedPeople(decodedData.spouse)
    end
    return data
end

---@param decodedData marryV2.ReqImplementDivorce lua中的数据结构
---@return marryV2.ReqImplementDivorce C#中的数据结构
function marryV2.ReqImplementDivorce(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.marryV2.ReqImplementDivorce()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

--[[marryV2.ResOnlineDivorceCondition 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData marryV2.ResChangeMarry lua中的数据结构
---@return marryV2.ResChangeMarry C#中的数据结构
function marryV2.ResChangeMarry(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.marryV2.ResChangeMarry()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.spouse ~= nil and decodedData.spouseSpecified ~= false then
        data.spouse = marryV2.MarriedPeople(decodedData.spouse)
    end
    return data
end

---@param decodedData marryV2.ResGetSpouse lua中的数据结构
---@return marryV2.ResGetSpouse C#中的数据结构
function marryV2.ResGetSpouse(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.marryV2.ResGetSpouse()
    if decodedData.spouse ~= nil and decodedData.spouseSpecified ~= false then
        data.spouse = marryV2.MarriedPeople(decodedData.spouse)
    end
    if decodedData.isCanRemarry ~= nil and decodedData.isCanRemarrySpecified ~= false then
        data.isCanRemarry = decodedData.isCanRemarry
    end
    if decodedData.divorceTime ~= nil and decodedData.divorceTimeSpecified ~= false then
        data.divorceTime = decodedData.divorceTime
    end
    if decodedData.marryRing ~= nil and decodedData.marryRingSpecified ~= false then
        data.marryRing = marryV2.MarryRingInfo(decodedData.marryRing)
    end
    return data
end

---@param decodedData marryV2.MarryRingInfo lua中的数据结构
---@return marryV2.MarryRingInfo C#中的数据结构
function marryV2.MarryRingInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.marryV2.MarryRingInfo()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.needCount ~= nil and decodedData.needCountSpecified ~= false then
        data.needCount = decodedData.needCount
    end
    return data
end

---@param decodedData marryV2.ResLackRings lua中的数据结构
---@return marryV2.ResLackRings C#中的数据结构
function marryV2.ResLackRings(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.marryV2.ResLackRings()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    return data
end

--[[marryV2.ResUpdateRing 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData marryV2.ResPlayerMarriageInformation lua中的数据结构
---@return marryV2.ResPlayerMarriageInformation C#中的数据结构
function marryV2.ResPlayerMarriageInformation(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.marryV2.ResPlayerMarriageInformation()
    if decodedData.man ~= nil and decodedData.manSpecified ~= false then
        data.man = marryV2.MarriedPeople(decodedData.man)
    end
    if decodedData.woman ~= nil and decodedData.womanSpecified ~= false then
        data.woman = marryV2.MarriedPeople(decodedData.woman)
    end
    if decodedData.ringItemId ~= nil and decodedData.ringItemIdSpecified ~= false then
        data.ringItemId = decodedData.ringItemId
    end
    if decodedData.marryTime ~= nil and decodedData.marryTimeSpecified ~= false then
        data.marryTime = decodedData.marryTime
    end
    if decodedData.number ~= nil and decodedData.numberSpecified ~= false then
        data.number = decodedData.number
    end
    if decodedData.intimacyValue ~= nil and decodedData.intimacyValueSpecified ~= false then
        data.intimacyValue = decodedData.intimacyValue
    end
    if decodedData.serverId ~= nil and decodedData.serverIdSpecified ~= false then
        data.serverId = decodedData.serverId
    end
    if decodedData.manOath ~= nil and decodedData.manOathSpecified ~= false then
        data.manOath = decodedData.manOath
    end
    if decodedData.womanOath ~= nil and decodedData.womanOathSpecified ~= false then
        data.womanOath = decodedData.womanOath
    end
    return data
end

--[[marryV2.ResSeeOath 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData marryV2.ReqUpdateOath lua中的数据结构
---@return marryV2.ReqUpdateOath C#中的数据结构
function marryV2.ReqUpdateOath(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.marryV2.ReqUpdateOath()
    if decodedData.matchmaker ~= nil and decodedData.matchmakerSpecified ~= false then
        data.matchmaker = decodedData.matchmaker
    end
    return data
end

--[[marryV2.ResSeeLettering 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData marryV2.ReqUpdateLettering lua中的数据结构
---@return marryV2.ReqUpdateLettering C#中的数据结构
function marryV2.ReqUpdateLettering(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.marryV2.ReqUpdateLettering()
    if decodedData.lettering ~= nil and decodedData.letteringSpecified ~= false then
        data.lettering = decodedData.lettering
    end
    return data
end

---@param decodedData marryV2.ReqVerificationOath lua中的数据结构
---@return marryV2.ReqVerificationOath C#中的数据结构
function marryV2.ReqVerificationOath(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.marryV2.ReqVerificationOath()
    if decodedData.matchmaker ~= nil and decodedData.matchmakerSpecified ~= false then
        data.matchmaker = decodedData.matchmaker
    end
    return data
end

---@param decodedData marryV2.ReqVerificationLettering lua中的数据结构
---@return marryV2.ReqVerificationLettering C#中的数据结构
function marryV2.ReqVerificationLettering(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.marryV2.ReqVerificationLettering()
    if decodedData.lettering ~= nil and decodedData.letteringSpecified ~= false then
        data.lettering = decodedData.lettering
    end
    return data
end

---@param decodedData marryV2.ReqGiveJewel lua中的数据结构
---@return marryV2.ReqGiveJewel C#中的数据结构
function marryV2.ReqGiveJewel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.marryV2.ReqGiveJewel()
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData marryV2.ReqSeeOthersMarriageInfo lua中的数据结构
---@return marryV2.ReqSeeOthersMarriageInfo C#中的数据结构
function marryV2.ReqSeeOthersMarriageInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.marryV2.ReqSeeOthersMarriageInfo()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    return data
end

---@param decodedData marryV2.ResSeeOthersMarriageInfo lua中的数据结构
---@return marryV2.ResSeeOthersMarriageInfo C#中的数据结构
function marryV2.ResSeeOthersMarriageInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.marryV2.ResSeeOthersMarriageInfo()
    if decodedData.marriageInfo ~= nil and decodedData.marriageInfoSpecified ~= false then
        data.marriageInfo = marryV2.ResPlayerMarriageInformation(decodedData.marriageInfo)
    end
    return data
end

return marryV2