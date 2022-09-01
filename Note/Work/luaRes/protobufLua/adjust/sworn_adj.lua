--[[本文件为工具自动生成,禁止手动修改]]
local swornV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable swornV2.ResHasSworn
---@type swornV2.ResHasSworn
swornV2_adj.metatable_ResHasSworn = {
    _ClassName = "swornV2.ResHasSworn",
}
swornV2_adj.metatable_ResHasSworn.__index = swornV2_adj.metatable_ResHasSworn
--endregion

---@param tbl swornV2.ResHasSworn 待调整的table数据
function swornV2_adj.AdjustResHasSworn(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, swornV2_adj.metatable_ResHasSworn)
    if tbl.isSworn == nil then
        tbl.isSwornSpecified = false
        tbl.isSworn = 0
    else
        tbl.isSwornSpecified = true
    end
end

--region metatable swornV2.SendSwornInfo
---@type swornV2.SendSwornInfo
swornV2_adj.metatable_SendSwornInfo = {
    _ClassName = "swornV2.SendSwornInfo",
}
swornV2_adj.metatable_SendSwornInfo.__index = swornV2_adj.metatable_SendSwornInfo
--endregion

---@param tbl swornV2.SendSwornInfo 待调整的table数据
function swornV2_adj.AdjustSendSwornInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, swornV2_adj.metatable_SendSwornInfo)
    if tbl.swornInfo == nil then
        tbl.swornInfo = {}
    else
        if swornV2_adj.AdjustStartBrotherInfo ~= nil then
            for i = 1, #tbl.swornInfo do
                swornV2_adj.AdjustStartBrotherInfo(tbl.swornInfo[i])
            end
        end
    end
    if tbl.leaderId == nil then
        tbl.leaderIdSpecified = false
        tbl.leaderId = 0
    else
        tbl.leaderIdSpecified = true
    end
    if tbl.longTime == nil then
        tbl.longTimeSpecified = false
        tbl.longTime = 0
    else
        tbl.longTimeSpecified = true
    end
end

--region metatable swornV2.StartBrotherInfo
---@type swornV2.StartBrotherInfo
swornV2_adj.metatable_StartBrotherInfo = {
    _ClassName = "swornV2.StartBrotherInfo",
}
swornV2_adj.metatable_StartBrotherInfo.__index = swornV2_adj.metatable_StartBrotherInfo
--endregion

---@param tbl swornV2.StartBrotherInfo 待调整的table数据
function swornV2_adj.AdjustStartBrotherInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, swornV2_adj.metatable_StartBrotherInfo)
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
    if tbl.isAgree == nil then
        tbl.isAgreeSpecified = false
        tbl.isAgree = 0
    else
        tbl.isAgreeSpecified = true
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

--region metatable swornV2.BrotherInfo
---@type swornV2.BrotherInfo
swornV2_adj.metatable_BrotherInfo = {
    _ClassName = "swornV2.BrotherInfo",
}
swornV2_adj.metatable_BrotherInfo.__index = swornV2_adj.metatable_BrotherInfo
--endregion

---@param tbl swornV2.BrotherInfo 待调整的table数据
function swornV2_adj.AdjustBrotherInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, swornV2_adj.metatable_BrotherInfo)
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
    if tbl.intimacy == nil then
        tbl.intimacySpecified = false
        tbl.intimacy = 0
    else
        tbl.intimacySpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.isDissolution == nil then
        tbl.isDissolutionSpecified = false
        tbl.isDissolution = 0
    else
        tbl.isDissolutionSpecified = true
    end
    if tbl.disTime == nil then
        tbl.disTimeSpecified = false
        tbl.disTime = 0
    else
        tbl.disTimeSpecified = true
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

--region metatable swornV2.ResYourBrother
---@type swornV2.ResYourBrother
swornV2_adj.metatable_ResYourBrother = {
    _ClassName = "swornV2.ResYourBrother",
}
swornV2_adj.metatable_ResYourBrother.__index = swornV2_adj.metatable_ResYourBrother
--endregion

---@param tbl swornV2.ResYourBrother 待调整的table数据
function swornV2_adj.AdjustResYourBrother(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, swornV2_adj.metatable_ResYourBrother)
    if tbl.brothers == nil then
        tbl.brothers = {}
    else
        if swornV2_adj.AdjustBrotherInfo ~= nil then
            for i = 1, #tbl.brothers do
                swornV2_adj.AdjustBrotherInfo(tbl.brothers[i])
            end
        end
    end
end

--region metatable swornV2.ReqAgreeSworn
---@type swornV2.ReqAgreeSworn
swornV2_adj.metatable_ReqAgreeSworn = {
    _ClassName = "swornV2.ReqAgreeSworn",
}
swornV2_adj.metatable_ReqAgreeSworn.__index = swornV2_adj.metatable_ReqAgreeSworn
--endregion

---@param tbl swornV2.ReqAgreeSworn 待调整的table数据
function swornV2_adj.AdjustReqAgreeSworn(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, swornV2_adj.metatable_ReqAgreeSworn)
    if tbl.agree == nil then
        tbl.agreeSpecified = false
        tbl.agree = 0
    else
        tbl.agreeSpecified = true
    end
end

--region metatable swornV2.ResAgreeSworn
---@type swornV2.ResAgreeSworn
swornV2_adj.metatable_ResAgreeSworn = {
    _ClassName = "swornV2.ResAgreeSworn",
}
swornV2_adj.metatable_ResAgreeSworn.__index = swornV2_adj.metatable_ResAgreeSworn
--endregion

---@param tbl swornV2.ResAgreeSworn 待调整的table数据
function swornV2_adj.AdjustResAgreeSworn(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, swornV2_adj.metatable_ResAgreeSworn)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.isAgree == nil then
        tbl.isAgreeSpecified = false
        tbl.isAgree = 0
    else
        tbl.isAgreeSpecified = true
    end
end

--region metatable swornV2.ResSwornSuccess
---@type swornV2.ResSwornSuccess
swornV2_adj.metatable_ResSwornSuccess = {
    _ClassName = "swornV2.ResSwornSuccess",
}
swornV2_adj.metatable_ResSwornSuccess.__index = swornV2_adj.metatable_ResSwornSuccess
--endregion

---@param tbl swornV2.ResSwornSuccess 待调整的table数据
function swornV2_adj.AdjustResSwornSuccess(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, swornV2_adj.metatable_ResSwornSuccess)
    if tbl.isSuccess == nil then
        tbl.isSuccessSpecified = false
        tbl.isSuccess = 0
    else
        tbl.isSuccessSpecified = true
    end
end

--region metatable swornV2.ReqDissolutionBrother
---@type swornV2.ReqDissolutionBrother
swornV2_adj.metatable_ReqDissolutionBrother = {
    _ClassName = "swornV2.ReqDissolutionBrother",
}
swornV2_adj.metatable_ReqDissolutionBrother.__index = swornV2_adj.metatable_ReqDissolutionBrother
--endregion

---@param tbl swornV2.ReqDissolutionBrother 待调整的table数据
function swornV2_adj.AdjustReqDissolutionBrother(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, swornV2_adj.metatable_ReqDissolutionBrother)
    if tbl.brotherId == nil then
        tbl.brotherIdSpecified = false
        tbl.brotherId = 0
    else
        tbl.brotherIdSpecified = true
    end
end

--region metatable swornV2.ReqRegretsDissolution
---@type swornV2.ReqRegretsDissolution
swornV2_adj.metatable_ReqRegretsDissolution = {
    _ClassName = "swornV2.ReqRegretsDissolution",
}
swornV2_adj.metatable_ReqRegretsDissolution.__index = swornV2_adj.metatable_ReqRegretsDissolution
--endregion

---@param tbl swornV2.ReqRegretsDissolution 待调整的table数据
function swornV2_adj.AdjustReqRegretsDissolution(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, swornV2_adj.metatable_ReqRegretsDissolution)
    if tbl.brotherId == nil then
        tbl.brotherIdSpecified = false
        tbl.brotherId = 0
    else
        tbl.brotherIdSpecified = true
    end
end

--region metatable swornV2.ResAddBrother
---@type swornV2.ResAddBrother
swornV2_adj.metatable_ResAddBrother = {
    _ClassName = "swornV2.ResAddBrother",
}
swornV2_adj.metatable_ResAddBrother.__index = swornV2_adj.metatable_ResAddBrother
--endregion

---@param tbl swornV2.ResAddBrother 待调整的table数据
function swornV2_adj.AdjustResAddBrother(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, swornV2_adj.metatable_ResAddBrother)
    if tbl.addBrothers == nil then
        tbl.addBrothers = {}
    else
        if swornV2_adj.AdjustBrotherInfo ~= nil then
            for i = 1, #tbl.addBrothers do
                swornV2_adj.AdjustBrotherInfo(tbl.addBrothers[i])
            end
        end
    end
end

--region metatable swornV2.ResRemoveBrother
---@type swornV2.ResRemoveBrother
swornV2_adj.metatable_ResRemoveBrother = {
    _ClassName = "swornV2.ResRemoveBrother",
}
swornV2_adj.metatable_ResRemoveBrother.__index = swornV2_adj.metatable_ResRemoveBrother
--endregion

---@param tbl swornV2.ResRemoveBrother 待调整的table数据
function swornV2_adj.AdjustResRemoveBrother(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, swornV2_adj.metatable_ResRemoveBrother)
    if tbl.removeBrothers == nil then
        tbl.removeBrothersSpecified = false
        tbl.removeBrothers = nil
    else
        if tbl.removeBrothersSpecified == nil then 
            tbl.removeBrothersSpecified = true
            if swornV2_adj.AdjustBrotherInfo ~= nil then
                swornV2_adj.AdjustBrotherInfo(tbl.removeBrothers)
            end
        end
    end
end

--region metatable swornV2.ResOneBrother
---@type swornV2.ResOneBrother
swornV2_adj.metatable_ResOneBrother = {
    _ClassName = "swornV2.ResOneBrother",
}
swornV2_adj.metatable_ResOneBrother.__index = swornV2_adj.metatable_ResOneBrother
--endregion

---@param tbl swornV2.ResOneBrother 待调整的table数据
function swornV2_adj.AdjustResOneBrother(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, swornV2_adj.metatable_ResOneBrother)
    if tbl.theBrothers == nil then
        tbl.theBrothersSpecified = false
        tbl.theBrothers = nil
    else
        if tbl.theBrothersSpecified == nil then 
            tbl.theBrothersSpecified = true
            if swornV2_adj.AdjustBrotherInfo ~= nil then
                swornV2_adj.AdjustBrotherInfo(tbl.theBrothers)
            end
        end
    end
end

--region metatable swornV2.ResBreakOffRelations
---@type swornV2.ResBreakOffRelations
swornV2_adj.metatable_ResBreakOffRelations = {
    _ClassName = "swornV2.ResBreakOffRelations",
}
swornV2_adj.metatable_ResBreakOffRelations.__index = swornV2_adj.metatable_ResBreakOffRelations
--endregion

---@param tbl swornV2.ResBreakOffRelations 待调整的table数据
function swornV2_adj.AdjustResBreakOffRelations(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, swornV2_adj.metatable_ResBreakOffRelations)
    if tbl.addBrothers == nil then
        tbl.addBrothers = {}
    else
        if swornV2_adj.AdjustBrotherInfo ~= nil then
            for i = 1, #tbl.addBrothers do
                swornV2_adj.AdjustBrotherInfo(tbl.addBrothers[i])
            end
        end
    end
end

--region metatable swornV2.ResSpecialEffects
---@type swornV2.ResSpecialEffects
swornV2_adj.metatable_ResSpecialEffects = {
    _ClassName = "swornV2.ResSpecialEffects",
}
swornV2_adj.metatable_ResSpecialEffects.__index = swornV2_adj.metatable_ResSpecialEffects
--endregion

---@param tbl swornV2.ResSpecialEffects 待调整的table数据
function swornV2_adj.AdjustResSpecialEffects(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, swornV2_adj.metatable_ResSpecialEffects)
    if tbl.idList == nil then
        tbl.idList = {}
    end
end

--region metatable swornV2.ResInterruptSworn
---@type swornV2.ResInterruptSworn
swornV2_adj.metatable_ResInterruptSworn = {
    _ClassName = "swornV2.ResInterruptSworn",
}
swornV2_adj.metatable_ResInterruptSworn.__index = swornV2_adj.metatable_ResInterruptSworn
--endregion

---@param tbl swornV2.ResInterruptSworn 待调整的table数据
function swornV2_adj.AdjustResInterruptSworn(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, swornV2_adj.metatable_ResInterruptSworn)
    if tbl.idList == nil then
        tbl.idList = {}
    end
end

return swornV2_adj