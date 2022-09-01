--[[本文件为工具自动生成,禁止手动修改]]
local junxianV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable junxianV2.ReqJunXianLevel
---@type junxianV2.ReqJunXianLevel
junxianV2_adj.metatable_ReqJunXianLevel = {
    _ClassName = "junxianV2.ReqJunXianLevel",
}
junxianV2_adj.metatable_ReqJunXianLevel.__index = junxianV2_adj.metatable_ReqJunXianLevel
--endregion

---@param tbl junxianV2.ReqJunXianLevel 待调整的table数据
function junxianV2_adj.AdjustReqJunXianLevel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, junxianV2_adj.metatable_ReqJunXianLevel)
end

--region metatable junxianV2.ResJunXianLevel
---@type junxianV2.ResJunXianLevel
junxianV2_adj.metatable_ResJunXianLevel = {
    _ClassName = "junxianV2.ResJunXianLevel",
}
junxianV2_adj.metatable_ResJunXianLevel.__index = junxianV2_adj.metatable_ResJunXianLevel
--endregion

---@param tbl junxianV2.ResJunXianLevel 待调整的table数据
function junxianV2_adj.AdjustResJunXianLevel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, junxianV2_adj.metatable_ResJunXianLevel)
    if tbl.thisJunXianId == nil then
        tbl.thisJunXianIdSpecified = false
        tbl.thisJunXianId = 0
    else
        tbl.thisJunXianIdSpecified = true
    end
    if tbl.nextJunXianId == nil then
        tbl.nextJunXianIdSpecified = false
        tbl.nextJunXianId = 0
    else
        tbl.nextJunXianIdSpecified = true
    end
    if tbl.thisNbValue == nil then
        tbl.thisNbValueSpecified = false
        tbl.thisNbValue = 0
    else
        tbl.thisNbValueSpecified = true
    end
end

--region metatable junxianV2.ReqJunXianUp
---@type junxianV2.ReqJunXianUp
junxianV2_adj.metatable_ReqJunXianUp = {
    _ClassName = "junxianV2.ReqJunXianUp",
}
junxianV2_adj.metatable_ReqJunXianUp.__index = junxianV2_adj.metatable_ReqJunXianUp
--endregion

---@param tbl junxianV2.ReqJunXianUp 待调整的table数据
function junxianV2_adj.AdjustReqJunXianUp(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, junxianV2_adj.metatable_ReqJunXianUp)
    if tbl.thisJunXianId == nil then
        tbl.thisJunXianIdSpecified = false
        tbl.thisJunXianId = 0
    else
        tbl.thisJunXianIdSpecified = true
    end
    if tbl.nextJunXianId == nil then
        tbl.nextJunXianIdSpecified = false
        tbl.nextJunXianId = 0
    else
        tbl.nextJunXianIdSpecified = true
    end
    if tbl.thisNbValue == nil then
        tbl.thisNbValueSpecified = false
        tbl.thisNbValue = 0
    else
        tbl.thisNbValueSpecified = true
    end
end

--region metatable junxianV2.ResJunXianUp
---@type junxianV2.ResJunXianUp
junxianV2_adj.metatable_ResJunXianUp = {
    _ClassName = "junxianV2.ResJunXianUp",
}
junxianV2_adj.metatable_ResJunXianUp.__index = junxianV2_adj.metatable_ResJunXianUp
--endregion

---@param tbl junxianV2.ResJunXianUp 待调整的table数据
function junxianV2_adj.AdjustResJunXianUp(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, junxianV2_adj.metatable_ResJunXianUp)
    if tbl.thisJunXianId == nil then
        tbl.thisJunXianIdSpecified = false
        tbl.thisJunXianId = 0
    else
        tbl.thisJunXianIdSpecified = true
    end
    if tbl.nextJunXianId == nil then
        tbl.nextJunXianIdSpecified = false
        tbl.nextJunXianId = 0
    else
        tbl.nextJunXianIdSpecified = true
    end
    if tbl.maxNbValue == nil then
        tbl.maxNbValueSpecified = false
        tbl.maxNbValue = 0
    else
        tbl.maxNbValueSpecified = true
    end
end

--region metatable junxianV2.ResRoundJunXianUp
---@type junxianV2.ResRoundJunXianUp
junxianV2_adj.metatable_ResRoundJunXianUp = {
    _ClassName = "junxianV2.ResRoundJunXianUp",
}
junxianV2_adj.metatable_ResRoundJunXianUp.__index = junxianV2_adj.metatable_ResRoundJunXianUp
--endregion

---@param tbl junxianV2.ResRoundJunXianUp 待调整的table数据
function junxianV2_adj.AdjustResRoundJunXianUp(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, junxianV2_adj.metatable_ResRoundJunXianUp)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.thisJunXianId == nil then
        tbl.thisJunXianIdSpecified = false
        tbl.thisJunXianId = 0
    else
        tbl.thisJunXianIdSpecified = true
    end
end

return junxianV2_adj