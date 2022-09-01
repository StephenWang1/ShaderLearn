--[[本文件为工具自动生成,禁止手动修改]]
local marryV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable marryV2.ResMatchmakerPanel
---@type marryV2.ResMatchmakerPanel
marryV2_adj.metatable_ResMatchmakerPanel = {
    _ClassName = "marryV2.ResMatchmakerPanel",
}
marryV2_adj.metatable_ResMatchmakerPanel.__index = marryV2_adj.metatable_ResMatchmakerPanel
--endregion

---@param tbl marryV2.ResMatchmakerPanel 待调整的table数据
function marryV2_adj.AdjustResMatchmakerPanel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ResMatchmakerPanel)
end

--region metatable marryV2.MarriedPeople
---@type marryV2.MarriedPeople
marryV2_adj.metatable_MarriedPeople = {
    _ClassName = "marryV2.MarriedPeople",
}
marryV2_adj.metatable_MarriedPeople.__index = marryV2_adj.metatable_MarriedPeople
--endregion

---@param tbl marryV2.MarriedPeople 待调整的table数据
function marryV2_adj.AdjustMarriedPeople(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_MarriedPeople)
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
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
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

--region metatable marryV2.ReqMatchmaker
---@type marryV2.ReqMatchmaker
marryV2_adj.metatable_ReqMatchmaker = {
    _ClassName = "marryV2.ReqMatchmaker",
}
marryV2_adj.metatable_ReqMatchmaker.__index = marryV2_adj.metatable_ReqMatchmaker
--endregion

---@param tbl marryV2.ReqMatchmaker 待调整的table数据
function marryV2_adj.AdjustReqMatchmaker(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ReqMatchmaker)
    if tbl.matchmaker == nil then
        tbl.matchmakerSpecified = false
        tbl.matchmaker = ""
    else
        tbl.matchmakerSpecified = true
    end
end

--region metatable marryV2.ResMatchmaker
---@type marryV2.ResMatchmaker
marryV2_adj.metatable_ResMatchmaker = {
    _ClassName = "marryV2.ResMatchmaker",
}
marryV2_adj.metatable_ResMatchmaker.__index = marryV2_adj.metatable_ResMatchmaker
--endregion

---@param tbl marryV2.ResMatchmaker 待调整的table数据
function marryV2_adj.AdjustResMatchmaker(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ResMatchmaker)
    if tbl.checkingMatchmaker == nil then
        tbl.checkingMatchmakerSpecified = false
        tbl.checkingMatchmaker = ""
    else
        tbl.checkingMatchmakerSpecified = true
    end
end

--region metatable marryV2.ReqDivorce
---@type marryV2.ReqDivorce
marryV2_adj.metatable_ReqDivorce = {
    _ClassName = "marryV2.ReqDivorce",
}
marryV2_adj.metatable_ReqDivorce.__index = marryV2_adj.metatable_ReqDivorce
--endregion

---@param tbl marryV2.ReqDivorce 待调整的table数据
function marryV2_adj.AdjustReqDivorce(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ReqDivorce)
    if tbl.divorceType == nil then
        tbl.divorceTypeSpecified = false
        tbl.divorceType = 0
    else
        tbl.divorceTypeSpecified = true
    end
end

--region metatable marryV2.ResDivorce
---@type marryV2.ResDivorce
marryV2_adj.metatable_ResDivorce = {
    _ClassName = "marryV2.ResDivorce",
}
marryV2_adj.metatable_ResDivorce.__index = marryV2_adj.metatable_ResDivorce
--endregion

---@param tbl marryV2.ResDivorce 待调整的table数据
function marryV2_adj.AdjustResDivorce(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ResDivorce)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.spouse == nil then
        tbl.spouseSpecified = false
        tbl.spouse = nil
    else
        if tbl.spouseSpecified == nil then 
            tbl.spouseSpecified = true
            if marryV2_adj.AdjustMarriedPeople ~= nil then
                marryV2_adj.AdjustMarriedPeople(tbl.spouse)
            end
        end
    end
end

--region metatable marryV2.ResConfirmDivorce
---@type marryV2.ResConfirmDivorce
marryV2_adj.metatable_ResConfirmDivorce = {
    _ClassName = "marryV2.ResConfirmDivorce",
}
marryV2_adj.metatable_ResConfirmDivorce.__index = marryV2_adj.metatable_ResConfirmDivorce
--endregion

---@param tbl marryV2.ResConfirmDivorce 待调整的table数据
function marryV2_adj.AdjustResConfirmDivorce(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ResConfirmDivorce)
    if tbl.confirmDivorceType == nil then
        tbl.confirmDivorceTypeSpecified = false
        tbl.confirmDivorceType = 0
    else
        tbl.confirmDivorceTypeSpecified = true
    end
    if tbl.spouse == nil then
        tbl.spouseSpecified = false
        tbl.spouse = nil
    else
        if tbl.spouseSpecified == nil then 
            tbl.spouseSpecified = true
            if marryV2_adj.AdjustMarriedPeople ~= nil then
                marryV2_adj.AdjustMarriedPeople(tbl.spouse)
            end
        end
    end
end

--region metatable marryV2.ReqImplementDivorce
---@type marryV2.ReqImplementDivorce
marryV2_adj.metatable_ReqImplementDivorce = {
    _ClassName = "marryV2.ReqImplementDivorce",
}
marryV2_adj.metatable_ReqImplementDivorce.__index = marryV2_adj.metatable_ReqImplementDivorce
--endregion

---@param tbl marryV2.ReqImplementDivorce 待调整的table数据
function marryV2_adj.AdjustReqImplementDivorce(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ReqImplementDivorce)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable marryV2.ResOnlineDivorceCondition
---@type marryV2.ResOnlineDivorceCondition
marryV2_adj.metatable_ResOnlineDivorceCondition = {
    _ClassName = "marryV2.ResOnlineDivorceCondition",
}
marryV2_adj.metatable_ResOnlineDivorceCondition.__index = marryV2_adj.metatable_ResOnlineDivorceCondition
--endregion

---@param tbl marryV2.ResOnlineDivorceCondition 待调整的table数据
function marryV2_adj.AdjustResOnlineDivorceCondition(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ResOnlineDivorceCondition)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.spouse == nil then
        tbl.spouseSpecified = false
        tbl.spouse = nil
    else
        if tbl.spouseSpecified == nil then 
            tbl.spouseSpecified = true
            if marryV2_adj.AdjustMarriedPeople ~= nil then
                marryV2_adj.AdjustMarriedPeople(tbl.spouse)
            end
        end
    end
end

--region metatable marryV2.ResChangeMarry
---@type marryV2.ResChangeMarry
marryV2_adj.metatable_ResChangeMarry = {
    _ClassName = "marryV2.ResChangeMarry",
}
marryV2_adj.metatable_ResChangeMarry.__index = marryV2_adj.metatable_ResChangeMarry
--endregion

---@param tbl marryV2.ResChangeMarry 待调整的table数据
function marryV2_adj.AdjustResChangeMarry(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ResChangeMarry)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.spouse == nil then
        tbl.spouseSpecified = false
        tbl.spouse = nil
    else
        if tbl.spouseSpecified == nil then 
            tbl.spouseSpecified = true
            if marryV2_adj.AdjustMarriedPeople ~= nil then
                marryV2_adj.AdjustMarriedPeople(tbl.spouse)
            end
        end
    end
end

--region metatable marryV2.ResGetSpouse
---@type marryV2.ResGetSpouse
marryV2_adj.metatable_ResGetSpouse = {
    _ClassName = "marryV2.ResGetSpouse",
}
marryV2_adj.metatable_ResGetSpouse.__index = marryV2_adj.metatable_ResGetSpouse
--endregion

---@param tbl marryV2.ResGetSpouse 待调整的table数据
function marryV2_adj.AdjustResGetSpouse(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ResGetSpouse)
    if tbl.spouse == nil then
        tbl.spouseSpecified = false
        tbl.spouse = nil
    else
        if tbl.spouseSpecified == nil then 
            tbl.spouseSpecified = true
            if marryV2_adj.AdjustMarriedPeople ~= nil then
                marryV2_adj.AdjustMarriedPeople(tbl.spouse)
            end
        end
    end
    if tbl.isCanRemarry == nil then
        tbl.isCanRemarrySpecified = false
        tbl.isCanRemarry = 0
    else
        tbl.isCanRemarrySpecified = true
    end
    if tbl.divorceTime == nil then
        tbl.divorceTimeSpecified = false
        tbl.divorceTime = 0
    else
        tbl.divorceTimeSpecified = true
    end
    if tbl.marryRing == nil then
        tbl.marryRingSpecified = false
        tbl.marryRing = nil
    else
        if tbl.marryRingSpecified == nil then 
            tbl.marryRingSpecified = true
            if marryV2_adj.AdjustMarryRingInfo ~= nil then
                marryV2_adj.AdjustMarryRingInfo(tbl.marryRing)
            end
        end
    end
end

--region metatable marryV2.MarryRingInfo
---@type marryV2.MarryRingInfo
marryV2_adj.metatable_MarryRingInfo = {
    _ClassName = "marryV2.MarryRingInfo",
}
marryV2_adj.metatable_MarryRingInfo.__index = marryV2_adj.metatable_MarryRingInfo
--endregion

---@param tbl marryV2.MarryRingInfo 待调整的table数据
function marryV2_adj.AdjustMarryRingInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_MarryRingInfo)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.needCount == nil then
        tbl.needCountSpecified = false
        tbl.needCount = 0
    else
        tbl.needCountSpecified = true
    end
end

--region metatable marryV2.ResLackRings
---@type marryV2.ResLackRings
marryV2_adj.metatable_ResLackRings = {
    _ClassName = "marryV2.ResLackRings",
}
marryV2_adj.metatable_ResLackRings.__index = marryV2_adj.metatable_ResLackRings
--endregion

---@param tbl marryV2.ResLackRings 待调整的table数据
function marryV2_adj.AdjustResLackRings(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ResLackRings)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
end

--region metatable marryV2.ResUpdateRing
---@type marryV2.ResUpdateRing
marryV2_adj.metatable_ResUpdateRing = {
    _ClassName = "marryV2.ResUpdateRing",
}
marryV2_adj.metatable_ResUpdateRing.__index = marryV2_adj.metatable_ResUpdateRing
--endregion

---@param tbl marryV2.ResUpdateRing 待调整的table数据
function marryV2_adj.AdjustResUpdateRing(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ResUpdateRing)
end

--region metatable marryV2.ResPlayerMarriageInformation
---@type marryV2.ResPlayerMarriageInformation
marryV2_adj.metatable_ResPlayerMarriageInformation = {
    _ClassName = "marryV2.ResPlayerMarriageInformation",
}
marryV2_adj.metatable_ResPlayerMarriageInformation.__index = marryV2_adj.metatable_ResPlayerMarriageInformation
--endregion

---@param tbl marryV2.ResPlayerMarriageInformation 待调整的table数据
function marryV2_adj.AdjustResPlayerMarriageInformation(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ResPlayerMarriageInformation)
    if tbl.man == nil then
        tbl.manSpecified = false
        tbl.man = nil
    else
        if tbl.manSpecified == nil then 
            tbl.manSpecified = true
            if marryV2_adj.AdjustMarriedPeople ~= nil then
                marryV2_adj.AdjustMarriedPeople(tbl.man)
            end
        end
    end
    if tbl.woman == nil then
        tbl.womanSpecified = false
        tbl.woman = nil
    else
        if tbl.womanSpecified == nil then 
            tbl.womanSpecified = true
            if marryV2_adj.AdjustMarriedPeople ~= nil then
                marryV2_adj.AdjustMarriedPeople(tbl.woman)
            end
        end
    end
    if tbl.ringItemId == nil then
        tbl.ringItemIdSpecified = false
        tbl.ringItemId = 0
    else
        tbl.ringItemIdSpecified = true
    end
    if tbl.marryTime == nil then
        tbl.marryTimeSpecified = false
        tbl.marryTime = 0
    else
        tbl.marryTimeSpecified = true
    end
    if tbl.number == nil then
        tbl.numberSpecified = false
        tbl.number = 0
    else
        tbl.numberSpecified = true
    end
    if tbl.intimacyValue == nil then
        tbl.intimacyValueSpecified = false
        tbl.intimacyValue = 0
    else
        tbl.intimacyValueSpecified = true
    end
    if tbl.serverId == nil then
        tbl.serverIdSpecified = false
        tbl.serverId = 0
    else
        tbl.serverIdSpecified = true
    end
    if tbl.manOath == nil then
        tbl.manOathSpecified = false
        tbl.manOath = ""
    else
        tbl.manOathSpecified = true
    end
    if tbl.womanOath == nil then
        tbl.womanOathSpecified = false
        tbl.womanOath = ""
    else
        tbl.womanOathSpecified = true
    end
end

--region metatable marryV2.ResSeeOath
---@type marryV2.ResSeeOath
marryV2_adj.metatable_ResSeeOath = {
    _ClassName = "marryV2.ResSeeOath",
}
marryV2_adj.metatable_ResSeeOath.__index = marryV2_adj.metatable_ResSeeOath
--endregion

---@param tbl marryV2.ResSeeOath 待调整的table数据
function marryV2_adj.AdjustResSeeOath(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ResSeeOath)
    if tbl.matchmaker == nil then
        tbl.matchmakerSpecified = false
        tbl.matchmaker = ""
    else
        tbl.matchmakerSpecified = true
    end
end

--region metatable marryV2.ReqUpdateOath
---@type marryV2.ReqUpdateOath
marryV2_adj.metatable_ReqUpdateOath = {
    _ClassName = "marryV2.ReqUpdateOath",
}
marryV2_adj.metatable_ReqUpdateOath.__index = marryV2_adj.metatable_ReqUpdateOath
--endregion

---@param tbl marryV2.ReqUpdateOath 待调整的table数据
function marryV2_adj.AdjustReqUpdateOath(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ReqUpdateOath)
    if tbl.matchmaker == nil then
        tbl.matchmakerSpecified = false
        tbl.matchmaker = ""
    else
        tbl.matchmakerSpecified = true
    end
end

--region metatable marryV2.ResSeeLettering
---@type marryV2.ResSeeLettering
marryV2_adj.metatable_ResSeeLettering = {
    _ClassName = "marryV2.ResSeeLettering",
}
marryV2_adj.metatable_ResSeeLettering.__index = marryV2_adj.metatable_ResSeeLettering
--endregion

---@param tbl marryV2.ResSeeLettering 待调整的table数据
function marryV2_adj.AdjustResSeeLettering(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ResSeeLettering)
    if tbl.lettering == nil then
        tbl.letteringSpecified = false
        tbl.lettering = ""
    else
        tbl.letteringSpecified = true
    end
end

--region metatable marryV2.ReqUpdateLettering
---@type marryV2.ReqUpdateLettering
marryV2_adj.metatable_ReqUpdateLettering = {
    _ClassName = "marryV2.ReqUpdateLettering",
}
marryV2_adj.metatable_ReqUpdateLettering.__index = marryV2_adj.metatable_ReqUpdateLettering
--endregion

---@param tbl marryV2.ReqUpdateLettering 待调整的table数据
function marryV2_adj.AdjustReqUpdateLettering(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ReqUpdateLettering)
    if tbl.lettering == nil then
        tbl.letteringSpecified = false
        tbl.lettering = ""
    else
        tbl.letteringSpecified = true
    end
end

--region metatable marryV2.ReqVerificationOath
---@type marryV2.ReqVerificationOath
marryV2_adj.metatable_ReqVerificationOath = {
    _ClassName = "marryV2.ReqVerificationOath",
}
marryV2_adj.metatable_ReqVerificationOath.__index = marryV2_adj.metatable_ReqVerificationOath
--endregion

---@param tbl marryV2.ReqVerificationOath 待调整的table数据
function marryV2_adj.AdjustReqVerificationOath(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ReqVerificationOath)
    if tbl.matchmaker == nil then
        tbl.matchmakerSpecified = false
        tbl.matchmaker = ""
    else
        tbl.matchmakerSpecified = true
    end
end

--region metatable marryV2.ReqVerificationLettering
---@type marryV2.ReqVerificationLettering
marryV2_adj.metatable_ReqVerificationLettering = {
    _ClassName = "marryV2.ReqVerificationLettering",
}
marryV2_adj.metatable_ReqVerificationLettering.__index = marryV2_adj.metatable_ReqVerificationLettering
--endregion

---@param tbl marryV2.ReqVerificationLettering 待调整的table数据
function marryV2_adj.AdjustReqVerificationLettering(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ReqVerificationLettering)
    if tbl.lettering == nil then
        tbl.letteringSpecified = false
        tbl.lettering = ""
    else
        tbl.letteringSpecified = true
    end
end

--region metatable marryV2.ReqGiveJewel
---@type marryV2.ReqGiveJewel
marryV2_adj.metatable_ReqGiveJewel = {
    _ClassName = "marryV2.ReqGiveJewel",
}
marryV2_adj.metatable_ReqGiveJewel.__index = marryV2_adj.metatable_ReqGiveJewel
--endregion

---@param tbl marryV2.ReqGiveJewel 待调整的table数据
function marryV2_adj.AdjustReqGiveJewel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ReqGiveJewel)
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable marryV2.ReqSeeOthersMarriageInfo
---@type marryV2.ReqSeeOthersMarriageInfo
marryV2_adj.metatable_ReqSeeOthersMarriageInfo = {
    _ClassName = "marryV2.ReqSeeOthersMarriageInfo",
}
marryV2_adj.metatable_ReqSeeOthersMarriageInfo.__index = marryV2_adj.metatable_ReqSeeOthersMarriageInfo
--endregion

---@param tbl marryV2.ReqSeeOthersMarriageInfo 待调整的table数据
function marryV2_adj.AdjustReqSeeOthersMarriageInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ReqSeeOthersMarriageInfo)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
end

--region metatable marryV2.ResSeeOthersMarriageInfo
---@type marryV2.ResSeeOthersMarriageInfo
marryV2_adj.metatable_ResSeeOthersMarriageInfo = {
    _ClassName = "marryV2.ResSeeOthersMarriageInfo",
}
marryV2_adj.metatable_ResSeeOthersMarriageInfo.__index = marryV2_adj.metatable_ResSeeOthersMarriageInfo
--endregion

---@param tbl marryV2.ResSeeOthersMarriageInfo 待调整的table数据
function marryV2_adj.AdjustResSeeOthersMarriageInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, marryV2_adj.metatable_ResSeeOthersMarriageInfo)
    if tbl.marriageInfo == nil then
        tbl.marriageInfoSpecified = false
        tbl.marriageInfo = nil
    else
        if tbl.marriageInfoSpecified == nil then 
            tbl.marriageInfoSpecified = true
            if marryV2_adj.AdjustResPlayerMarriageInformation ~= nil then
                marryV2_adj.AdjustResPlayerMarriageInformation(tbl.marriageInfo)
            end
        end
    end
end

return marryV2_adj