--[[本文件为工具自动生成,禁止手动修改]]
local fightV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable fightV2.BufferInfo
---@type fightV2.BufferInfo
fightV2_adj.metatable_BufferInfo = {
    _ClassName = "fightV2.BufferInfo",
}
fightV2_adj.metatable_BufferInfo.__index = fightV2_adj.metatable_BufferInfo
--endregion

---@param tbl fightV2.BufferInfo 待调整的table数据
function fightV2_adj.AdjustBufferInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fightV2_adj.metatable_BufferInfo)
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
    if tbl.addTime == nil then
        tbl.addTimeSpecified = false
        tbl.addTime = 0
    else
        tbl.addTimeSpecified = true
    end
    if tbl.totalTime == nil then
        tbl.totalTimeSpecified = false
        tbl.totalTime = 0
    else
        tbl.totalTimeSpecified = true
    end
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.bufferValue == nil then
        tbl.bufferValueSpecified = false
        tbl.bufferValue = 0
    else
        tbl.bufferValueSpecified = true
    end
    if tbl.bufferValue2 == nil then
        tbl.bufferValue2Specified = false
        tbl.bufferValue2 = 0
    else
        tbl.bufferValue2Specified = true
    end
    if tbl.data == nil then
        tbl.dataSpecified = false
        tbl.data = 0
    else
        tbl.dataSpecified = true
    end
    if tbl.addValue == nil then
        tbl.addValue = {}
    else
        if fightV2_adj.AdjustPlayerAttribute ~= nil then
            for i = 1, #tbl.addValue do
                fightV2_adj.AdjustPlayerAttribute(tbl.addValue[i])
            end
        end
    end
end

--region metatable fightV2.PlayerAttribute
---@type fightV2.PlayerAttribute
fightV2_adj.metatable_PlayerAttribute = {
    _ClassName = "fightV2.PlayerAttribute",
}
fightV2_adj.metatable_PlayerAttribute.__index = fightV2_adj.metatable_PlayerAttribute
--endregion

---@param tbl fightV2.PlayerAttribute 待调整的table数据
function fightV2_adj.AdjustPlayerAttribute(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fightV2_adj.metatable_PlayerAttribute)
end

--region metatable fightV2.HurtTarget
---@type fightV2.HurtTarget
fightV2_adj.metatable_HurtTarget = {
    _ClassName = "fightV2.HurtTarget",
}
fightV2_adj.metatable_HurtTarget.__index = fightV2_adj.metatable_HurtTarget
--endregion

---@param tbl fightV2.HurtTarget 待调整的table数据
function fightV2_adj.AdjustHurtTarget(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fightV2_adj.metatable_HurtTarget)
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
    if tbl.hp == nil then
        tbl.hpSpecified = false
        tbl.hp = 0
    else
        tbl.hpSpecified = true
    end
    if tbl.showHurt == nil then
        tbl.showHurtSpecified = false
        tbl.showHurt = 0
    else
        tbl.showHurtSpecified = true
    end
    if tbl.inner == nil then
        tbl.innerSpecified = false
        tbl.inner = 0
    else
        tbl.innerSpecified = true
    end
    if tbl.bufferList == nil then
        tbl.bufferList = {}
    end
    if tbl.specAtt == nil then
        tbl.specAttSpecified = false
        tbl.specAtt = 0
    else
        tbl.specAttSpecified = true
    end
    if tbl.hurtType == nil then
        tbl.hurtTypeSpecified = false
        tbl.hurtType = 0
    else
        tbl.hurtTypeSpecified = true
    end
    if tbl.effectType == nil then
        tbl.effectTypeSpecified = false
        tbl.effectType = 0
    else
        tbl.effectTypeSpecified = true
    end
    if tbl.isDodge == nil then
        tbl.isDodgeSpecified = false
        tbl.isDodge = false
    else
        tbl.isDodgeSpecified = true
    end
    if tbl.isCritical == nil then
        tbl.isCriticalSpecified = false
        tbl.isCritical = false
    else
        tbl.isCriticalSpecified = true
    end
    if tbl.x == nil then
        tbl.xSpecified = false
        tbl.x = 0
    else
        tbl.xSpecified = true
    end
    if tbl.y == nil then
        tbl.ySpecified = false
        tbl.y = 0
    else
        tbl.ySpecified = true
    end
    if tbl.servantReduceHurt == nil then
        tbl.servantReduceHurtSpecified = false
        tbl.servantReduceHurt = 0
    else
        tbl.servantReduceHurtSpecified = true
    end
    if tbl.burnMp == nil then
        tbl.burnMpSpecified = false
        tbl.burnMp = 0
    else
        tbl.burnMpSpecified = true
    end
    if tbl.holyHurt == nil then
        tbl.holyHurtSpecified = false
        tbl.holyHurt = 0
    else
        tbl.holyHurtSpecified = true
    end
    if tbl.targetX == nil then
        tbl.targetXSpecified = false
        tbl.targetX = 0
    else
        tbl.targetXSpecified = true
    end
    if tbl.targetY == nil then
        tbl.targetYSpecified = false
        tbl.targetY = 0
    else
        tbl.targetYSpecified = true
    end
    if tbl.multipleHolyHurt == nil then
        tbl.multipleHolyHurtSpecified = false
        tbl.multipleHolyHurt = 0
    else
        tbl.multipleHolyHurtSpecified = true
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
    if tbl.penetrateHurt == nil then
        tbl.penetrateHurtSpecified = false
        tbl.penetrateHurt = 0
    else
        tbl.penetrateHurtSpecified = true
    end
    if tbl.guardDamage == nil then
        tbl.guardDamageSpecified = false
        tbl.guardDamage = 0
    else
        tbl.guardDamageSpecified = true
    end
    if tbl.isSoulAttack == nil then
        tbl.isSoulAttackSpecified = false
        tbl.isSoulAttack = false
    else
        tbl.isSoulAttackSpecified = true
    end
    if tbl.isBack == nil then
        tbl.isBackSpecified = false
        tbl.isBack = false
    else
        tbl.isBackSpecified = true
    end
    if tbl.isShield == nil then
        tbl.isShieldSpecified = false
        tbl.isShield = false
    else
        tbl.isShieldSpecified = true
    end
    if tbl.shixue == nil then
        tbl.shixueSpecified = false
        tbl.shixue = 0
    else
        tbl.shixueSpecified = true
    end
end

--region metatable fightV2.FightRequest
---@type fightV2.FightRequest
fightV2_adj.metatable_FightRequest = {
    _ClassName = "fightV2.FightRequest",
}
fightV2_adj.metatable_FightRequest.__index = fightV2_adj.metatable_FightRequest
--endregion

---@param tbl fightV2.FightRequest 待调整的table数据
function fightV2_adj.AdjustFightRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fightV2_adj.metatable_FightRequest)
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
    if tbl.x == nil then
        tbl.xSpecified = false
        tbl.x = 0
    else
        tbl.xSpecified = true
    end
    if tbl.y == nil then
        tbl.ySpecified = false
        tbl.y = 0
    else
        tbl.ySpecified = true
    end
    if tbl.useBufferId == nil then
        tbl.useBufferIdSpecified = false
        tbl.useBufferId = 0
    else
        tbl.useBufferIdSpecified = true
    end
    if tbl.sign == nil then
        tbl.signSpecified = false
        tbl.sign = 0
    else
        tbl.signSpecified = true
    end
end

--region metatable fightV2.ResFightResult
---@type fightV2.ResFightResult
fightV2_adj.metatable_ResFightResult = {
    _ClassName = "fightV2.ResFightResult",
}
fightV2_adj.metatable_ResFightResult.__index = fightV2_adj.metatable_ResFightResult
--endregion

---@param tbl fightV2.ResFightResult 待调整的table数据
function fightV2_adj.AdjustResFightResult(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fightV2_adj.metatable_ResFightResult)
    if tbl.attackerId == nil then
        tbl.attackerIdSpecified = false
        tbl.attackerId = 0
    else
        tbl.attackerIdSpecified = true
    end
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
    if tbl.x == nil then
        tbl.xSpecified = false
        tbl.x = 0
    else
        tbl.xSpecified = true
    end
    if tbl.y == nil then
        tbl.ySpecified = false
        tbl.y = 0
    else
        tbl.ySpecified = true
    end
    if tbl.hurtList == nil then
        tbl.hurtList = {}
    else
        if fightV2_adj.AdjustHurtTarget ~= nil then
            for i = 1, #tbl.hurtList do
                fightV2_adj.AdjustHurtTarget(tbl.hurtList[i])
            end
        end
    end
    if tbl.mp == nil then
        tbl.mpSpecified = false
        tbl.mp = 0
    else
        tbl.mpSpecified = true
    end
    if tbl.skillExp == nil then
        tbl.skillExpSpecified = false
        tbl.skillExp = 0
    else
        tbl.skillExpSpecified = true
    end
    if tbl.useBufferId == nil then
        tbl.useBufferIdSpecified = false
        tbl.useBufferId = 0
    else
        tbl.useBufferIdSpecified = true
    end
    if tbl.farX == nil then
        tbl.farXSpecified = false
        tbl.farX = 0
    else
        tbl.farXSpecified = true
    end
    if tbl.farY == nil then
        tbl.farYSpecified = false
        tbl.farY = 0
    else
        tbl.farYSpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
end

--region metatable fightV2.ResHpMpChange
---@type fightV2.ResHpMpChange
fightV2_adj.metatable_ResHpMpChange = {
    _ClassName = "fightV2.ResHpMpChange",
}
fightV2_adj.metatable_ResHpMpChange.__index = fightV2_adj.metatable_ResHpMpChange
--endregion

---@param tbl fightV2.ResHpMpChange 待调整的table数据
function fightV2_adj.AdjustResHpMpChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fightV2_adj.metatable_ResHpMpChange)
    if tbl.hp == nil then
        tbl.hpSpecified = false
        tbl.hp = 0
    else
        tbl.hpSpecified = true
    end
    if tbl.mp == nil then
        tbl.mpSpecified = false
        tbl.mp = 0
    else
        tbl.mpSpecified = true
    end
    if tbl.maxHp == nil then
        tbl.maxHpSpecified = false
        tbl.maxHp = 0
    else
        tbl.maxHpSpecified = true
    end
    if tbl.maxMp == nil then
        tbl.maxMpSpecified = false
        tbl.maxMp = 0
    else
        tbl.maxMpSpecified = true
    end
end

--region metatable fightV2.ResObjectDie
---@type fightV2.ResObjectDie
fightV2_adj.metatable_ResObjectDie = {
    _ClassName = "fightV2.ResObjectDie",
}
fightV2_adj.metatable_ResObjectDie.__index = fightV2_adj.metatable_ResObjectDie
--endregion

---@param tbl fightV2.ResObjectDie 待调整的table数据
function fightV2_adj.AdjustResObjectDie(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fightV2_adj.metatable_ResObjectDie)
end

--region metatable fightV2.ResPlayerTotalHpPercnet
---@type fightV2.ResPlayerTotalHpPercnet
fightV2_adj.metatable_ResPlayerTotalHpPercnet = {
    _ClassName = "fightV2.ResPlayerTotalHpPercnet",
}
fightV2_adj.metatable_ResPlayerTotalHpPercnet.__index = fightV2_adj.metatable_ResPlayerTotalHpPercnet
--endregion

---@param tbl fightV2.ResPlayerTotalHpPercnet 待调整的table数据
function fightV2_adj.AdjustResPlayerTotalHpPercnet(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fightV2_adj.metatable_ResPlayerTotalHpPercnet)
end

--region metatable fightV2.ResInnerChange
---@type fightV2.ResInnerChange
fightV2_adj.metatable_ResInnerChange = {
    _ClassName = "fightV2.ResInnerChange",
}
fightV2_adj.metatable_ResInnerChange.__index = fightV2_adj.metatable_ResInnerChange
--endregion

---@param tbl fightV2.ResInnerChange 待调整的table数据
function fightV2_adj.AdjustResInnerChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fightV2_adj.metatable_ResInnerChange)
    if tbl.inner == nil then
        tbl.innerSpecified = false
        tbl.inner = 0
    else
        tbl.innerSpecified = true
    end
end

--region metatable fightV2.ResShouHuAttack
---@type fightV2.ResShouHuAttack
fightV2_adj.metatable_ResShouHuAttack = {
    _ClassName = "fightV2.ResShouHuAttack",
}
fightV2_adj.metatable_ResShouHuAttack.__index = fightV2_adj.metatable_ResShouHuAttack
--endregion

---@param tbl fightV2.ResShouHuAttack 待调整的table数据
function fightV2_adj.AdjustResShouHuAttack(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fightV2_adj.metatable_ResShouHuAttack)
    if tbl.buffId == nil then
        tbl.buffIdSpecified = false
        tbl.buffId = 0
    else
        tbl.buffIdSpecified = true
    end
end

--region metatable fightV2.ResPlayerTotalMagicPercnet
---@type fightV2.ResPlayerTotalMagicPercnet
fightV2_adj.metatable_ResPlayerTotalMagicPercnet = {
    _ClassName = "fightV2.ResPlayerTotalMagicPercnet",
}
fightV2_adj.metatable_ResPlayerTotalMagicPercnet.__index = fightV2_adj.metatable_ResPlayerTotalMagicPercnet
--endregion

---@param tbl fightV2.ResPlayerTotalMagicPercnet 待调整的table数据
function fightV2_adj.AdjustResPlayerTotalMagicPercnet(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fightV2_adj.metatable_ResPlayerTotalMagicPercnet)
end

--region metatable fightV2.ResBanCure
---@type fightV2.ResBanCure
fightV2_adj.metatable_ResBanCure = {
    _ClassName = "fightV2.ResBanCure",
}
fightV2_adj.metatable_ResBanCure.__index = fightV2_adj.metatable_ResBanCure
--endregion

---@param tbl fightV2.ResBanCure 待调整的table数据
function fightV2_adj.AdjustResBanCure(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fightV2_adj.metatable_ResBanCure)
end

--region metatable fightV2.SkillMoveInfo
---@type fightV2.SkillMoveInfo
fightV2_adj.metatable_SkillMoveInfo = {
    _ClassName = "fightV2.SkillMoveInfo",
}
fightV2_adj.metatable_SkillMoveInfo.__index = fightV2_adj.metatable_SkillMoveInfo
--endregion

---@param tbl fightV2.SkillMoveInfo 待调整的table数据
function fightV2_adj.AdjustSkillMoveInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fightV2_adj.metatable_SkillMoveInfo)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.moveInfo == nil then
        tbl.moveInfo = {}
    else
        if fightV2_adj.AdjustSkillMove ~= nil then
            for i = 1, #tbl.moveInfo do
                fightV2_adj.AdjustSkillMove(tbl.moveInfo[i])
            end
        end
    end
end

--region metatable fightV2.SkillMove
---@type fightV2.SkillMove
fightV2_adj.metatable_SkillMove = {
    _ClassName = "fightV2.SkillMove",
}
fightV2_adj.metatable_SkillMove.__index = fightV2_adj.metatable_SkillMove
--endregion

---@param tbl fightV2.SkillMove 待调整的table数据
function fightV2_adj.AdjustSkillMove(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fightV2_adj.metatable_SkillMove)
end

--region metatable fightV2.ResMedicineHpMpChange
---@type fightV2.ResMedicineHpMpChange
fightV2_adj.metatable_ResMedicineHpMpChange = {
    _ClassName = "fightV2.ResMedicineHpMpChange",
}
fightV2_adj.metatable_ResMedicineHpMpChange.__index = fightV2_adj.metatable_ResMedicineHpMpChange
--endregion

---@param tbl fightV2.ResMedicineHpMpChange 待调整的table数据
function fightV2_adj.AdjustResMedicineHpMpChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fightV2_adj.metatable_ResMedicineHpMpChange)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.hp == nil then
        tbl.hpSpecified = false
        tbl.hp = 0
    else
        tbl.hpSpecified = true
    end
    if tbl.mp == nil then
        tbl.mpSpecified = false
        tbl.mp = 0
    else
        tbl.mpSpecified = true
    end
    if tbl.addHp == nil then
        tbl.addHpSpecified = false
        tbl.addHp = 0
    else
        tbl.addHpSpecified = true
    end
    if tbl.addMp == nil then
        tbl.addMpSpecified = false
        tbl.addMp = 0
    else
        tbl.addMpSpecified = true
    end
end

--region metatable fightV2.ResLampCoreSeckill
---@type fightV2.ResLampCoreSeckill
fightV2_adj.metatable_ResLampCoreSeckill = {
    _ClassName = "fightV2.ResLampCoreSeckill",
}
fightV2_adj.metatable_ResLampCoreSeckill.__index = fightV2_adj.metatable_ResLampCoreSeckill
--endregion

---@param tbl fightV2.ResLampCoreSeckill 待调整的table数据
function fightV2_adj.AdjustResLampCoreSeckill(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, fightV2_adj.metatable_ResLampCoreSeckill)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.hp == nil then
        tbl.hpSpecified = false
        tbl.hp = 0
    else
        tbl.hpSpecified = true
    end
end

return fightV2_adj