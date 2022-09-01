--[[本文件为工具自动生成,禁止手动修改]]
local bufferV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable bufferV2.ResRemoveBuffer
---@type bufferV2.ResRemoveBuffer
bufferV2_adj.metatable_ResRemoveBuffer = {
    _ClassName = "bufferV2.ResRemoveBuffer",
}
bufferV2_adj.metatable_ResRemoveBuffer.__index = bufferV2_adj.metatable_ResRemoveBuffer
--endregion

---@param tbl bufferV2.ResRemoveBuffer 待调整的table数据
function bufferV2_adj.AdjustResRemoveBuffer(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bufferV2_adj.metatable_ResRemoveBuffer)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.bufferId == nil then
        tbl.bufferIdSpecified = false
        tbl.bufferId = 0
    else
        tbl.bufferIdSpecified = true
    end
    if tbl.bufferConfigId == nil then
        tbl.bufferConfigIdSpecified = false
        tbl.bufferConfigId = 0
    else
        tbl.bufferConfigIdSpecified = true
    end
end

--region metatable bufferV2.BufferDeltaHP
---@type bufferV2.BufferDeltaHP
bufferV2_adj.metatable_BufferDeltaHP = {
    _ClassName = "bufferV2.BufferDeltaHP",
}
bufferV2_adj.metatable_BufferDeltaHP.__index = bufferV2_adj.metatable_BufferDeltaHP
--endregion

---@param tbl bufferV2.BufferDeltaHP 待调整的table数据
function bufferV2_adj.AdjustBufferDeltaHP(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, bufferV2_adj.metatable_BufferDeltaHP)
    if tbl.deltaHP == nil then
        tbl.deltaHPSpecified = false
        tbl.deltaHP = 0
    else
        tbl.deltaHPSpecified = true
    end
    if tbl.hp == nil then
        tbl.hpSpecified = false
        tbl.hp = 0
    else
        tbl.hpSpecified = true
    end
    if tbl.adder == nil then
        tbl.adderSpecified = false
        tbl.adder = 0
    else
        tbl.adderSpecified = true
    end
    if tbl.adderType == nil then
        tbl.adderTypeSpecified = false
        tbl.adderType = 0
    else
        tbl.adderTypeSpecified = true
    end
    if tbl.bufferId == nil then
        tbl.bufferIdSpecified = false
        tbl.bufferId = 0
    else
        tbl.bufferIdSpecified = true
    end
    if tbl.deltaMP == nil then
        tbl.deltaMPSpecified = false
        tbl.deltaMP = 0
    else
        tbl.deltaMPSpecified = true
    end
    if tbl.mp == nil then
        tbl.mpSpecified = false
        tbl.mp = 0
    else
        tbl.mpSpecified = true
    end
    if tbl.critical == nil then
        tbl.criticalSpecified = false
        tbl.critical = false
    else
        tbl.criticalSpecified = true
    end
    if tbl.holyDamage == nil then
        tbl.holyDamageSpecified = false
        tbl.holyDamage = 0
    else
        tbl.holyDamageSpecified = true
    end
    if tbl.deterHurt == nil then
        tbl.deterHurtSpecified = false
        tbl.deterHurt = 0
    else
        tbl.deterHurtSpecified = true
    end
    if tbl.breakShield == nil then
        tbl.breakShieldSpecified = false
        tbl.breakShield = 0
    else
        tbl.breakShieldSpecified = true
    end
    if tbl.guardDamage == nil then
        tbl.guardDamageSpecified = false
        tbl.guardDamage = 0
    else
        tbl.guardDamageSpecified = true
    end
    if tbl.servantReduceHurt == nil then
        tbl.servantReduceHurtSpecified = false
        tbl.servantReduceHurt = 0
    else
        tbl.servantReduceHurtSpecified = true
    end
    if tbl.isShield == nil then
        tbl.isShieldSpecified = false
        tbl.isShield = false
    else
        tbl.isShieldSpecified = true
    end
end

return bufferV2_adj