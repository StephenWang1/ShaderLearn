--[[本文件为工具自动生成,禁止手动修改]]
local commonV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable commonV2.IntIntStruct
---@type commonV2.IntIntStruct
commonV2_adj.metatable_IntIntStruct = {
    _ClassName = "commonV2.IntIntStruct",
}
commonV2_adj.metatable_IntIntStruct.__index = commonV2_adj.metatable_IntIntStruct
--endregion

---@param tbl commonV2.IntIntStruct 待调整的table数据
function commonV2_adj.AdjustIntIntStruct(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, commonV2_adj.metatable_IntIntStruct)
end

--region metatable commonV2.LongLongStruct
---@type commonV2.LongLongStruct
commonV2_adj.metatable_LongLongStruct = {
    _ClassName = "commonV2.LongLongStruct",
}
commonV2_adj.metatable_LongLongStruct.__index = commonV2_adj.metatable_LongLongStruct
--endregion

---@param tbl commonV2.LongLongStruct 待调整的table数据
function commonV2_adj.AdjustLongLongStruct(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, commonV2_adj.metatable_LongLongStruct)
end

--region metatable commonV2.IntStringStruct
---@type commonV2.IntStringStruct
commonV2_adj.metatable_IntStringStruct = {
    _ClassName = "commonV2.IntStringStruct",
}
commonV2_adj.metatable_IntStringStruct.__index = commonV2_adj.metatable_IntStringStruct
--endregion

---@param tbl commonV2.IntStringStruct 待调整的table数据
function commonV2_adj.AdjustIntStringStruct(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, commonV2_adj.metatable_IntStringStruct)
end

--region metatable commonV2.PlayerPropertyG2S
---@type commonV2.PlayerPropertyG2S
commonV2_adj.metatable_PlayerPropertyG2S = {
    _ClassName = "commonV2.PlayerPropertyG2S",
}
commonV2_adj.metatable_PlayerPropertyG2S.__index = commonV2_adj.metatable_PlayerPropertyG2S
--endregion

---@param tbl commonV2.PlayerPropertyG2S 待调整的table数据
function commonV2_adj.AdjustPlayerPropertyG2S(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, commonV2_adj.metatable_PlayerPropertyG2S)
    if tbl.emperorTokenId == nil then
        tbl.emperorTokenIdSpecified = false
        tbl.emperorTokenId = 0
    else
        tbl.emperorTokenIdSpecified = true
    end
    if tbl.tarotTonkenNum == nil then
        tbl.tarotTonkenNumSpecified = false
        tbl.tarotTonkenNum = 0
    else
        tbl.tarotTonkenNumSpecified = true
    end
end

return commonV2_adj