--[[本文件为工具自动生成,禁止手动修改]]
local bufferV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData bufferV2.ResRemoveBuffer lua中的数据结构
---@return bufferV2.ResRemoveBuffer C#中的数据结构
function bufferV2.ResRemoveBuffer(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bufferV2.ResRemoveBuffer()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.bufferId ~= nil and decodedData.bufferIdSpecified ~= false then
        data.bufferId = decodedData.bufferId
    end
    if decodedData.bufferConfigId ~= nil and decodedData.bufferConfigIdSpecified ~= false then
        data.bufferConfigId = decodedData.bufferConfigId
    end
    return data
end

---@param decodedData bufferV2.BufferDeltaHP lua中的数据结构
---@return bufferV2.BufferDeltaHP C#中的数据结构
function bufferV2.BufferDeltaHP(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.bufferV2.BufferDeltaHP()
    data.id = decodedData.id
    if decodedData.deltaHP ~= nil and decodedData.deltaHPSpecified ~= false then
        data.deltaHP = decodedData.deltaHP
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.adder ~= nil and decodedData.adderSpecified ~= false then
        data.adder = decodedData.adder
    end
    if decodedData.adderType ~= nil and decodedData.adderTypeSpecified ~= false then
        data.adderType = decodedData.adderType
    end
    if decodedData.bufferId ~= nil and decodedData.bufferIdSpecified ~= false then
        data.bufferId = decodedData.bufferId
    end
    if decodedData.deltaMP ~= nil and decodedData.deltaMPSpecified ~= false then
        data.deltaMP = decodedData.deltaMP
    end
    if decodedData.mp ~= nil and decodedData.mpSpecified ~= false then
        data.mp = decodedData.mp
    end
    if decodedData.critical ~= nil and decodedData.criticalSpecified ~= false then
        data.critical = decodedData.critical
    end
    if decodedData.holyDamage ~= nil and decodedData.holyDamageSpecified ~= false then
        data.holyDamage = decodedData.holyDamage
    end
    if decodedData.deterHurt ~= nil and decodedData.deterHurtSpecified ~= false then
        data.deterHurt = decodedData.deterHurt
    end
    if decodedData.breakShield ~= nil and decodedData.breakShieldSpecified ~= false then
        data.breakShield = decodedData.breakShield
    end
    if decodedData.guardDamage ~= nil and decodedData.guardDamageSpecified ~= false then
        data.guardDamage = decodedData.guardDamage
    end
    if decodedData.servantReduceHurt ~= nil and decodedData.servantReduceHurtSpecified ~= false then
        data.servantReduceHurt = decodedData.servantReduceHurt
    end
    if decodedData.isShield ~= nil and decodedData.isShieldSpecified ~= false then
        data.isShield = decodedData.isShield
    end
    return data
end

return bufferV2