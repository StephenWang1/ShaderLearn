--[[本文件为工具自动生成,禁止手动修改]]
local fightV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData fightV2.BufferInfo lua中的数据结构
---@return fightV2.BufferInfo C#中的数据结构
function fightV2.BufferInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fightV2.BufferInfo()
    if decodedData.bufferId ~= nil and decodedData.bufferIdSpecified ~= false then
        data.bufferId = decodedData.bufferId
    end
    if decodedData.bufferConfigId ~= nil and decodedData.bufferConfigIdSpecified ~= false then
        data.bufferConfigId = decodedData.bufferConfigId
    end
    if decodedData.addTime ~= nil and decodedData.addTimeSpecified ~= false then
        data.addTime = decodedData.addTime
    end
    if decodedData.totalTime ~= nil and decodedData.totalTimeSpecified ~= false then
        data.totalTime = decodedData.totalTime
    end
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.bufferValue ~= nil and decodedData.bufferValueSpecified ~= false then
        data.bufferValue = decodedData.bufferValue
    end
    if decodedData.bufferValue2 ~= nil and decodedData.bufferValue2Specified ~= false then
        data.bufferValue2 = decodedData.bufferValue2
    end
    if decodedData.data ~= nil and decodedData.dataSpecified ~= false then
        data.data = decodedData.data
    end
    if decodedData.addValue ~= nil and decodedData.addValueSpecified ~= false then
        for i = 1, #decodedData.addValue do
            data.addValue:Add(fightV2.PlayerAttribute(decodedData.addValue[i]))
        end
    end
    return data
end

---@param decodedData fightV2.PlayerAttribute lua中的数据结构
---@return fightV2.PlayerAttribute C#中的数据结构
function fightV2.PlayerAttribute(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fightV2.PlayerAttribute()
    data.type = decodedData.type
    data.num = decodedData.num
    return data
end

---@param decodedData fightV2.HurtTarget lua中的数据结构
---@return fightV2.HurtTarget C#中的数据结构
function fightV2.HurtTarget(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fightV2.HurtTarget()
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.showHurt ~= nil and decodedData.showHurtSpecified ~= false then
        data.showHurt = decodedData.showHurt
    end
    if decodedData.inner ~= nil and decodedData.innerSpecified ~= false then
        data.inner = decodedData.inner
    end
    if decodedData.bufferList ~= nil and decodedData.bufferListSpecified ~= false then
        for i = 1, #decodedData.bufferList do
            data.bufferList:Add(decodedData.bufferList[i])
        end
    end
    if decodedData.specAtt ~= nil and decodedData.specAttSpecified ~= false then
        data.specAtt = decodedData.specAtt
    end
    if decodedData.hurtType ~= nil and decodedData.hurtTypeSpecified ~= false then
        data.hurtType = decodedData.hurtType
    end
    if decodedData.effectType ~= nil and decodedData.effectTypeSpecified ~= false then
        data.effectType = decodedData.effectType
    end
    if decodedData.isDodge ~= nil and decodedData.isDodgeSpecified ~= false then
        data.isDodge = decodedData.isDodge
    end
    if decodedData.isCritical ~= nil and decodedData.isCriticalSpecified ~= false then
        data.isCritical = decodedData.isCritical
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.servantReduceHurt ~= nil and decodedData.servantReduceHurtSpecified ~= false then
        data.servantReduceHurt = decodedData.servantReduceHurt
    end
    if decodedData.burnMp ~= nil and decodedData.burnMpSpecified ~= false then
        data.burnMp = decodedData.burnMp
    end
    if decodedData.holyHurt ~= nil and decodedData.holyHurtSpecified ~= false then
        data.holyHurt = decodedData.holyHurt
    end
    if decodedData.targetX ~= nil and decodedData.targetXSpecified ~= false then
        data.targetX = decodedData.targetX
    end
    if decodedData.targetY ~= nil and decodedData.targetYSpecified ~= false then
        data.targetY = decodedData.targetY
    end
    if decodedData.multipleHolyHurt ~= nil and decodedData.multipleHolyHurtSpecified ~= false then
        data.multipleHolyHurt = decodedData.multipleHolyHurt
    end
    if decodedData.deterHurt ~= nil and decodedData.deterHurtSpecified ~= false then
        data.deterHurt = decodedData.deterHurt
    end
    if decodedData.breakShield ~= nil and decodedData.breakShieldSpecified ~= false then
        data.breakShield = decodedData.breakShield
    end
    if decodedData.penetrateHurt ~= nil and decodedData.penetrateHurtSpecified ~= false then
        data.penetrateHurt = decodedData.penetrateHurt
    end
    if decodedData.guardDamage ~= nil and decodedData.guardDamageSpecified ~= false then
        data.guardDamage = decodedData.guardDamage
    end
    if decodedData.isSoulAttack ~= nil and decodedData.isSoulAttackSpecified ~= false then
        data.isSoulAttack = decodedData.isSoulAttack
    end
    if decodedData.isBack ~= nil and decodedData.isBackSpecified ~= false then
        data.isBack = decodedData.isBack
    end
    if decodedData.isShield ~= nil and decodedData.isShieldSpecified ~= false then
        data.isShield = decodedData.isShield
    end
    if decodedData.shixue ~= nil and decodedData.shixueSpecified ~= false then
        data.shixue = decodedData.shixue
    end
    return data
end

---@param decodedData fightV2.FightRequest lua中的数据结构
---@return fightV2.FightRequest C#中的数据结构
function fightV2.FightRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fightV2.FightRequest()
    data.skillId = decodedData.skillId
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.useBufferId ~= nil and decodedData.useBufferIdSpecified ~= false then
        data.useBufferId = decodedData.useBufferId
    end
    if decodedData.sign ~= nil and decodedData.signSpecified ~= false then
        data.sign = decodedData.sign
    end
    return data
end

---@param decodedData fightV2.ResFightResult lua中的数据结构
---@return fightV2.ResFightResult C#中的数据结构
function fightV2.ResFightResult(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fightV2.ResFightResult()
    data.skillId = decodedData.skillId
    if decodedData.attackerId ~= nil and decodedData.attackerIdSpecified ~= false then
        data.attackerId = decodedData.attackerId
    end
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.hurtList ~= nil and decodedData.hurtListSpecified ~= false then
        for i = 1, #decodedData.hurtList do
            data.hurtList:Add(fightV2.HurtTarget(decodedData.hurtList[i]))
        end
    end
    if decodedData.mp ~= nil and decodedData.mpSpecified ~= false then
        data.mp = decodedData.mp
    end
    if decodedData.skillExp ~= nil and decodedData.skillExpSpecified ~= false then
        data.skillExp = decodedData.skillExp
    end
    if decodedData.useBufferId ~= nil and decodedData.useBufferIdSpecified ~= false then
        data.useBufferId = decodedData.useBufferId
    end
    if decodedData.farX ~= nil and decodedData.farXSpecified ~= false then
        data.farX = decodedData.farX
    end
    if decodedData.farY ~= nil and decodedData.farYSpecified ~= false then
        data.farY = decodedData.farY
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    return data
end

---@param decodedData fightV2.ResHpMpChange lua中的数据结构
---@return fightV2.ResHpMpChange C#中的数据结构
function fightV2.ResHpMpChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fightV2.ResHpMpChange()
    data.lid = decodedData.lid
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.mp ~= nil and decodedData.mpSpecified ~= false then
        data.mp = decodedData.mp
    end
    if decodedData.maxHp ~= nil and decodedData.maxHpSpecified ~= false then
        data.maxHp = decodedData.maxHp
    end
    if decodedData.maxMp ~= nil and decodedData.maxMpSpecified ~= false then
        data.maxMp = decodedData.maxMp
    end
    return data
end

---@param decodedData fightV2.ResObjectDie lua中的数据结构
---@return fightV2.ResObjectDie C#中的数据结构
function fightV2.ResObjectDie(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fightV2.ResObjectDie()
    data.lid = decodedData.lid
    data.killerId = decodedData.killerId
    return data
end

---@param decodedData fightV2.ResPlayerTotalHpPercnet lua中的数据结构
---@return fightV2.ResPlayerTotalHpPercnet C#中的数据结构
function fightV2.ResPlayerTotalHpPercnet(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fightV2.ResPlayerTotalHpPercnet()
    data.percent = decodedData.percent
    return data
end

---@param decodedData fightV2.ResInnerChange lua中的数据结构
---@return fightV2.ResInnerChange C#中的数据结构
function fightV2.ResInnerChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fightV2.ResInnerChange()
    data.lid = decodedData.lid
    if decodedData.inner ~= nil and decodedData.innerSpecified ~= false then
        data.inner = decodedData.inner
    end
    return data
end

---@param decodedData fightV2.ResShouHuAttack lua中的数据结构
---@return fightV2.ResShouHuAttack C#中的数据结构
function fightV2.ResShouHuAttack(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fightV2.ResShouHuAttack()
    data.shouhuId = decodedData.shouhuId
    data.ownerId = decodedData.ownerId
    if decodedData.buffId ~= nil and decodedData.buffIdSpecified ~= false then
        data.buffId = decodedData.buffId
    end
    return data
end

---@param decodedData fightV2.ResPlayerTotalMagicPercnet lua中的数据结构
---@return fightV2.ResPlayerTotalMagicPercnet C#中的数据结构
function fightV2.ResPlayerTotalMagicPercnet(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fightV2.ResPlayerTotalMagicPercnet()
    data.percent = decodedData.percent
    return data
end

---@param decodedData fightV2.ResBanCure lua中的数据结构
---@return fightV2.ResBanCure C#中的数据结构
function fightV2.ResBanCure(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fightV2.ResBanCure()
    data.targetId = decodedData.targetId
    return data
end

---@param decodedData fightV2.SkillMoveInfo lua中的数据结构
---@return fightV2.SkillMoveInfo C#中的数据结构
function fightV2.SkillMoveInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fightV2.SkillMoveInfo()
    data.attackId = decodedData.attackId
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.moveInfo ~= nil and decodedData.moveInfoSpecified ~= false then
        for i = 1, #decodedData.moveInfo do
            data.moveInfo:Add(fightV2.SkillMove(decodedData.moveInfo[i]))
        end
    end
    return data
end

---@param decodedData fightV2.SkillMove lua中的数据结构
---@return fightV2.SkillMove C#中的数据结构
function fightV2.SkillMove(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fightV2.SkillMove()
    data.targetId = decodedData.targetId
    data.x = decodedData.x
    data.y = decodedData.y
    return data
end

---@param decodedData fightV2.ResMedicineHpMpChange lua中的数据结构
---@return fightV2.ResMedicineHpMpChange C#中的数据结构
function fightV2.ResMedicineHpMpChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fightV2.ResMedicineHpMpChange()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.mp ~= nil and decodedData.mpSpecified ~= false then
        data.mp = decodedData.mp
    end
    if decodedData.addHp ~= nil and decodedData.addHpSpecified ~= false then
        data.addHp = decodedData.addHp
    end
    if decodedData.addMp ~= nil and decodedData.addMpSpecified ~= false then
        data.addMp = decodedData.addMp
    end
    return data
end

---@param decodedData fightV2.ResLampCoreSeckill lua中的数据结构
---@return fightV2.ResLampCoreSeckill C#中的数据结构
function fightV2.ResLampCoreSeckill(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.fightV2.ResLampCoreSeckill()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    return data
end

return fightV2