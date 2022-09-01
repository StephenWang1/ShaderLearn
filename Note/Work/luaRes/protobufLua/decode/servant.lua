--[[本文件为工具自动生成,禁止手动修改]]
local servantV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData servantV2.ServantAttribute lua中的数据结构
---@return servantV2.ServantAttribute C#中的数据结构
function servantV2.ServantAttribute(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.ServantAttribute()
    data.type = decodedData.type
    data.value = decodedData.value
    return data
end

---@param decodedData servantV2.ServantInfo lua中的数据结构
---@return servantV2.ServantInfo C#中的数据结构
function servantV2.ServantInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.ServantInfo()
    data.cfgId = decodedData.cfgId
    data.mid = decodedData.mid
    data.state = decodedData.state
    if decodedData.servantId ~= nil and decodedData.servantIdSpecified ~= false then
        data.servantId = decodedData.servantId
    end
    if decodedData.attributes ~= nil and decodedData.attributesSpecified ~= false then
        for i = 1, #decodedData.attributes do
            data.attributes:Add(servantV2.ServantAttribute(decodedData.attributes[i]))
        end
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.equips ~= nil and decodedData.equipsSpecified ~= false then
        for i = 1, #decodedData.equips do
            data.equips:Add(decodeTable.bag.BagItemInfo(decodedData.equips[i]))
        end
    end
    if decodedData.callAgainTime ~= nil and decodedData.callAgainTimeSpecified ~= false then
        data.callAgainTime = decodedData.callAgainTime
    end
    if decodedData.rein ~= nil and decodedData.reinSpecified ~= false then
        data.rein = decodedData.rein
    end
    if decodedData.weight ~= nil and decodedData.weightSpecified ~= false then
        data.weight = decodedData.weight
    end
    if decodedData.levelAttrs ~= nil and decodedData.levelAttrsSpecified ~= false then
        for i = 1, #decodedData.levelAttrs do
            data.levelAttrs:Add(servantV2.ServantAttribute(decodedData.levelAttrs[i]))
        end
    end
    if decodedData.nextLevelAttrs ~= nil and decodedData.nextLevelAttrsSpecified ~= false then
        for i = 1, #decodedData.nextLevelAttrs do
            data.nextLevelAttrs:Add(servantV2.ServantAttribute(decodedData.nextLevelAttrs[i]))
        end
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.servantEgg ~= nil and decodedData.servantEggSpecified ~= false then
        data.servantEgg = decodeTable.bag.BagItemInfo(decodedData.servantEgg)
    end
    if decodedData.exp ~= nil and decodedData.expSpecified ~= false then
        data.exp = decodedData.exp
    end
    if decodedData.combineHp ~= nil and decodedData.combineHpSpecified ~= false then
        data.combineHp = decodedData.combineHp
    end
    if decodedData.combineMaxHp ~= nil and decodedData.combineMaxHpSpecified ~= false then
        data.combineMaxHp = decodedData.combineMaxHp
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.battleTime ~= nil and decodedData.battleTimeSpecified ~= false then
        data.battleTime = decodedData.battleTime
    end
    if decodedData.reviveState ~= nil and decodedData.reviveStateSpecified ~= false then
        data.reviveState = decodedData.reviveState
    end
    if decodedData.soulEquips ~= nil and decodedData.soulEquipsSpecified ~= false then
        for i = 1, #decodedData.soulEquips do
            data.soulEquips:Add(decodeTable.bag.BagItemInfo(decodedData.soulEquips[i]))
        end
    end
    if decodedData.equippedSoul ~= nil and decodedData.equippedSoulSpecified ~= false then
        data.equippedSoul = decodedData.equippedSoul
    end
    if decodedData.soulEquipOpen ~= nil and decodedData.soulEquipOpenSpecified ~= false then
        data.soulEquipOpen = decodedData.soulEquipOpen
    end
    if decodedData.fabacGridOpen ~= nil and decodedData.fabacGridOpenSpecified ~= false then
        data.fabacGridOpen = decodedData.fabacGridOpen
    end
    if decodedData.fightPower ~= nil and decodedData.fightPowerSpecified ~= false then
        data.fightPower = decodedData.fightPower
    end
    if decodedData.reinId ~= nil and decodedData.reinIdSpecified ~= false then
        data.reinId = decodedData.reinId
    end
    return data
end

---@param decodedData servantV2.OtherServantInfo lua中的数据结构
---@return servantV2.OtherServantInfo C#中的数据结构
function servantV2.OtherServantInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.OtherServantInfo()
    data.cfgId = decodedData.cfgId
    data.mid = decodedData.mid
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.rein ~= nil and decodedData.reinSpecified ~= false then
        data.rein = decodedData.rein
    end
    if decodedData.equips ~= nil and decodedData.equipsSpecified ~= false then
        for i = 1, #decodedData.equips do
            data.equips:Add(decodeTable.bag.BagItemInfo(decodedData.equips[i]))
        end
    end
    if decodedData.weight ~= nil and decodedData.weightSpecified ~= false then
        data.weight = decodedData.weight
    end
    if decodedData.servantEgg ~= nil and decodedData.servantEggSpecified ~= false then
        data.servantEgg = decodeTable.bag.BagItemInfo(decodedData.servantEgg)
    end
    if decodedData.soulEquips ~= nil and decodedData.soulEquipsSpecified ~= false then
        for i = 1, #decodedData.soulEquips do
            data.soulEquips:Add(decodeTable.bag.BagItemInfo(decodedData.soulEquips[i]))
        end
    end
    if decodedData.equippedSoul ~= nil and decodedData.equippedSoulSpecified ~= false then
        data.equippedSoul = decodedData.equippedSoul
    end
    if decodedData.reinId ~= nil and decodedData.reinIdSpecified ~= false then
        data.reinId = decodedData.reinId
    end
    return data
end

---@param decodedData servantV2.ReqOtherServantInfo lua中的数据结构
---@return servantV2.ReqOtherServantInfo C#中的数据结构
function servantV2.ReqOtherServantInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.ReqOtherServantInfo()
    if decodedData.targetId ~= nil and decodedData.targetIdSpecified ~= false then
        data.targetId = decodedData.targetId
    end
    return data
end

---@param decodedData servantV2.ResOtherServantInfo lua中的数据结构
---@return servantV2.ResOtherServantInfo C#中的数据结构
function servantV2.ResOtherServantInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.ResOtherServantInfo()
    if decodedData.infos ~= nil and decodedData.infosSpecified ~= false then
        for i = 1, #decodedData.infos do
            data.infos:Add(servantV2.OtherServantInfo(decodedData.infos[i]))
        end
    end
    return data
end

---@param decodedData servantV2.ResServantInfo lua中的数据结构
---@return servantV2.ResServantInfo C#中的数据结构
function servantV2.ResServantInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.ResServantInfo()
    if decodedData.serverts ~= nil and decodedData.servertsSpecified ~= false then
        for i = 1, #decodedData.serverts do
            data.serverts:Add(servantV2.ServantInfo(decodedData.serverts[i]))
        end
    end
    if decodedData.expPool ~= nil and decodedData.expPoolSpecified ~= false then
        data.expPool = decodedData.expPool
    end
    if decodedData.reinPool ~= nil and decodedData.reinPoolSpecified ~= false then
        data.reinPool = decodedData.reinPool
    end
    return data
end

---@param decodedData servantV2.ReqReceiveMana lua中的数据结构
---@return servantV2.ReqReceiveMana C#中的数据结构
function servantV2.ReqReceiveMana(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.ReqReceiveMana()
    data.receiveType = decodedData.receiveType
    return data
end

---@param decodedData servantV2.ServantMana lua中的数据结构
---@return servantV2.ServantMana C#中的数据结构
function servantV2.ServantMana(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.ServantMana()
    if decodedData.receiveToday ~= nil and decodedData.receiveTodaySpecified ~= false then
        data.receiveToday = decodedData.receiveToday
    end
    if decodedData.manaPoll ~= nil and decodedData.manaPollSpecified ~= false then
        data.manaPoll = decodedData.manaPoll
    end
    if decodedData.rechargeToday ~= nil and decodedData.rechargeTodaySpecified ~= false then
        data.rechargeToday = decodedData.rechargeToday
    end
    if decodedData.receiveRecharge ~= nil and decodedData.receiveRechargeSpecified ~= false then
        data.receiveRecharge = decodedData.receiveRecharge
    end
    return data
end

---@param decodedData servantV2.ReqServantChangeState lua中的数据结构
---@return servantV2.ReqServantChangeState C#中的数据结构
function servantV2.ReqServantChangeState(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.ReqServantChangeState()
    data.toState = decodedData.toState
    data.type = decodedData.type
    return data
end

---@param decodedData servantV2.ServantIdInfo lua中的数据结构
---@return servantV2.ServantIdInfo C#中的数据结构
function servantV2.ServantIdInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.ServantIdInfo()
    data.type = decodedData.type
    return data
end

---@param decodedData servantV2.ReqUseServantEgg lua中的数据结构
---@return servantV2.ReqUseServantEgg C#中的数据结构
function servantV2.ReqUseServantEgg(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.ReqUseServantEgg()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.targetType ~= nil and decodedData.targetTypeSpecified ~= false then
        data.targetType = decodedData.targetType
    end
    return data
end

---@param decodedData servantV2.ReqInjectExp lua中的数据结构
---@return servantV2.ReqInjectExp C#中的数据结构
function servantV2.ReqInjectExp(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.ReqInjectExp()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.exp ~= nil and decodedData.expSpecified ~= false then
        data.exp = decodedData.exp
    end
    return data
end

---@param decodedData servantV2.ServantExpUpdate lua中的数据结构
---@return servantV2.ServantExpUpdate C#中的数据结构
function servantV2.ServantExpUpdate(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.ServantExpUpdate()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.exp ~= nil and decodedData.expSpecified ~= false then
        data.exp = decodedData.exp
    end
    if decodedData.pool ~= nil and decodedData.poolSpecified ~= false then
        data.pool = decodedData.pool
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.actId ~= nil and decodedData.actIdSpecified ~= false then
        data.actId = decodedData.actId
    end
    return data
end

---@param decodedData servantV2.ServantHpUpdate lua中的数据结构
---@return servantV2.ServantHpUpdate C#中的数据结构
function servantV2.ServantHpUpdate(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.ServantHpUpdate()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.maxHp ~= nil and decodedData.maxHpSpecified ~= false then
        data.maxHp = decodedData.maxHp
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.combineHp ~= nil and decodedData.combineHpSpecified ~= false then
        data.combineHp = decodedData.combineHp
    end
    if decodedData.combineMaxHp ~= nil and decodedData.combineMaxHpSpecified ~= false then
        data.combineMaxHp = decodedData.combineMaxHp
    end
    return data
end

---@param decodedData servantV2.ReqServantRename lua中的数据结构
---@return servantV2.ReqServantRename C#中的数据结构
function servantV2.ReqServantRename(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.ReqServantRename()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    return data
end

---@param decodedData servantV2.ResServantName lua中的数据结构
---@return servantV2.ResServantName C#中的数据结构
function servantV2.ResServantName(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.ResServantName()
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    return data
end

---@param decodedData servantV2.ResServantLevelUp lua中的数据结构
---@return servantV2.ResServantLevelUp C#中的数据结构
function servantV2.ResServantLevelUp(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.ResServantLevelUp()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.exp ~= nil and decodedData.expSpecified ~= false then
        data.exp = decodedData.exp
    end
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    return data
end

---@param decodedData servantV2.ResServantReinUp lua中的数据结构
---@return servantV2.ResServantReinUp C#中的数据结构
function servantV2.ResServantReinUp(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.ResServantReinUp()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.rein ~= nil and decodedData.reinSpecified ~= false then
        data.rein = decodedData.rein
    end
    if decodedData.reinId ~= nil and decodedData.reinIdSpecified ~= false then
        data.reinId = decodedData.reinId
    end
    return data
end

---@param decodedData servantV2.ResServantStateChange lua中的数据结构
---@return servantV2.ResServantStateChange C#中的数据结构
function servantV2.ResServantStateChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.ResServantStateChange()
    data.servantId = decodedData.servantId
    data.newState = decodedData.newState
    return data
end

---@param decodedData servantV2.ReqServantEquipSoul lua中的数据结构
---@return servantV2.ReqServantEquipSoul C#中的数据结构
function servantV2.ReqServantEquipSoul(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.ReqServantEquipSoul()
    data.position = decodedData.position
    return data
end

---@param decodedData servantV2.ReqPurchaseServantSite lua中的数据结构
---@return servantV2.ReqPurchaseServantSite C#中的数据结构
function servantV2.ReqPurchaseServantSite(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.servantV2.ReqPurchaseServantSite()
    data.site = decodedData.site
    data.type = decodedData.type
    return data
end

return servantV2