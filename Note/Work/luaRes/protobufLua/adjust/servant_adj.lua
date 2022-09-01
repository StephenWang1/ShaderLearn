--[[本文件为工具自动生成,禁止手动修改]]
local servantV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable servantV2.ServantAttribute
---@type servantV2.ServantAttribute
servantV2_adj.metatable_ServantAttribute = {
    _ClassName = "servantV2.ServantAttribute",
}
servantV2_adj.metatable_ServantAttribute.__index = servantV2_adj.metatable_ServantAttribute
--endregion

---@param tbl servantV2.ServantAttribute 待调整的table数据
function servantV2_adj.AdjustServantAttribute(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_ServantAttribute)
end

--region metatable servantV2.ServantInfo
---@type servantV2.ServantInfo
servantV2_adj.metatable_ServantInfo = {
    _ClassName = "servantV2.ServantInfo",
}
servantV2_adj.metatable_ServantInfo.__index = servantV2_adj.metatable_ServantInfo
--endregion

---@param tbl servantV2.ServantInfo 待调整的table数据
function servantV2_adj.AdjustServantInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_ServantInfo)
    if tbl.servantId == nil then
        tbl.servantIdSpecified = false
        tbl.servantId = 0
    else
        tbl.servantIdSpecified = true
    end
    if tbl.attributes == nil then
        tbl.attributes = {}
    else
        if servantV2_adj.AdjustServantAttribute ~= nil then
            for i = 1, #tbl.attributes do
                servantV2_adj.AdjustServantAttribute(tbl.attributes[i])
            end
        end
    end
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.equips == nil then
        tbl.equips = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.equips do
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.equips[i])
            end
        end
    end
    if tbl.callAgainTime == nil then
        tbl.callAgainTimeSpecified = false
        tbl.callAgainTime = 0
    else
        tbl.callAgainTimeSpecified = true
    end
    if tbl.rein == nil then
        tbl.reinSpecified = false
        tbl.rein = 0
    else
        tbl.reinSpecified = true
    end
    if tbl.weight == nil then
        tbl.weightSpecified = false
        tbl.weight = 0
    else
        tbl.weightSpecified = true
    end
    if tbl.levelAttrs == nil then
        tbl.levelAttrs = {}
    else
        if servantV2_adj.AdjustServantAttribute ~= nil then
            for i = 1, #tbl.levelAttrs do
                servantV2_adj.AdjustServantAttribute(tbl.levelAttrs[i])
            end
        end
    end
    if tbl.nextLevelAttrs == nil then
        tbl.nextLevelAttrs = {}
    else
        if servantV2_adj.AdjustServantAttribute ~= nil then
            for i = 1, #tbl.nextLevelAttrs do
                servantV2_adj.AdjustServantAttribute(tbl.nextLevelAttrs[i])
            end
        end
    end
    if tbl.hp == nil then
        tbl.hpSpecified = false
        tbl.hp = 0
    else
        tbl.hpSpecified = true
    end
    if tbl.servantEgg == nil then
        tbl.servantEggSpecified = false
        tbl.servantEgg = nil
    else
        if tbl.servantEggSpecified == nil then 
            tbl.servantEggSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.servantEgg)
            end
        end
    end
    if tbl.exp == nil then
        tbl.expSpecified = false
        tbl.exp = 0
    else
        tbl.expSpecified = true
    end
    if tbl.combineHp == nil then
        tbl.combineHpSpecified = false
        tbl.combineHp = 0
    else
        tbl.combineHpSpecified = true
    end
    if tbl.combineMaxHp == nil then
        tbl.combineMaxHpSpecified = false
        tbl.combineMaxHp = 0
    else
        tbl.combineMaxHpSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.battleTime == nil then
        tbl.battleTimeSpecified = false
        tbl.battleTime = 0
    else
        tbl.battleTimeSpecified = true
    end
    if tbl.reviveState == nil then
        tbl.reviveStateSpecified = false
        tbl.reviveState = 0
    else
        tbl.reviveStateSpecified = true
    end
    if tbl.soulEquips == nil then
        tbl.soulEquips = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.soulEquips do
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.soulEquips[i])
            end
        end
    end
    if tbl.equippedSoul == nil then
        tbl.equippedSoulSpecified = false
        tbl.equippedSoul = 0
    else
        tbl.equippedSoulSpecified = true
    end
    if tbl.soulEquipOpen == nil then
        tbl.soulEquipOpenSpecified = false
        tbl.soulEquipOpen = false
    else
        tbl.soulEquipOpenSpecified = true
    end
    if tbl.fabacGridOpen == nil then
        tbl.fabacGridOpenSpecified = false
        tbl.fabacGridOpen = false
    else
        tbl.fabacGridOpenSpecified = true
    end
    if tbl.fightPower == nil then
        tbl.fightPowerSpecified = false
        tbl.fightPower = 0
    else
        tbl.fightPowerSpecified = true
    end
    if tbl.reinId == nil then
        tbl.reinIdSpecified = false
        tbl.reinId = 0
    else
        tbl.reinIdSpecified = true
    end
end

--region metatable servantV2.OtherServantInfo
---@type servantV2.OtherServantInfo
servantV2_adj.metatable_OtherServantInfo = {
    _ClassName = "servantV2.OtherServantInfo",
}
servantV2_adj.metatable_OtherServantInfo.__index = servantV2_adj.metatable_OtherServantInfo
--endregion

---@param tbl servantV2.OtherServantInfo 待调整的table数据
function servantV2_adj.AdjustOtherServantInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_OtherServantInfo)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.rein == nil then
        tbl.reinSpecified = false
        tbl.rein = 0
    else
        tbl.reinSpecified = true
    end
    if tbl.equips == nil then
        tbl.equips = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.equips do
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.equips[i])
            end
        end
    end
    if tbl.weight == nil then
        tbl.weightSpecified = false
        tbl.weight = 0
    else
        tbl.weightSpecified = true
    end
    if tbl.servantEgg == nil then
        tbl.servantEggSpecified = false
        tbl.servantEgg = nil
    else
        if tbl.servantEggSpecified == nil then 
            tbl.servantEggSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.servantEgg)
            end
        end
    end
    if tbl.soulEquips == nil then
        tbl.soulEquips = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.soulEquips do
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.soulEquips[i])
            end
        end
    end
    if tbl.equippedSoul == nil then
        tbl.equippedSoulSpecified = false
        tbl.equippedSoul = 0
    else
        tbl.equippedSoulSpecified = true
    end
    if tbl.reinId == nil then
        tbl.reinIdSpecified = false
        tbl.reinId = 0
    else
        tbl.reinIdSpecified = true
    end
end

--region metatable servantV2.ReqOtherServantInfo
---@type servantV2.ReqOtherServantInfo
servantV2_adj.metatable_ReqOtherServantInfo = {
    _ClassName = "servantV2.ReqOtherServantInfo",
}
servantV2_adj.metatable_ReqOtherServantInfo.__index = servantV2_adj.metatable_ReqOtherServantInfo
--endregion

---@param tbl servantV2.ReqOtherServantInfo 待调整的table数据
function servantV2_adj.AdjustReqOtherServantInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_ReqOtherServantInfo)
    if tbl.targetId == nil then
        tbl.targetIdSpecified = false
        tbl.targetId = 0
    else
        tbl.targetIdSpecified = true
    end
end

--region metatable servantV2.ResOtherServantInfo
---@type servantV2.ResOtherServantInfo
servantV2_adj.metatable_ResOtherServantInfo = {
    _ClassName = "servantV2.ResOtherServantInfo",
}
servantV2_adj.metatable_ResOtherServantInfo.__index = servantV2_adj.metatable_ResOtherServantInfo
--endregion

---@param tbl servantV2.ResOtherServantInfo 待调整的table数据
function servantV2_adj.AdjustResOtherServantInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_ResOtherServantInfo)
    if tbl.infos == nil then
        tbl.infos = {}
    else
        if servantV2_adj.AdjustOtherServantInfo ~= nil then
            for i = 1, #tbl.infos do
                servantV2_adj.AdjustOtherServantInfo(tbl.infos[i])
            end
        end
    end
end

--region metatable servantV2.ResServantInfo
---@type servantV2.ResServantInfo
servantV2_adj.metatable_ResServantInfo = {
    _ClassName = "servantV2.ResServantInfo",
}
servantV2_adj.metatable_ResServantInfo.__index = servantV2_adj.metatable_ResServantInfo
--endregion

---@param tbl servantV2.ResServantInfo 待调整的table数据
function servantV2_adj.AdjustResServantInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_ResServantInfo)
    if tbl.serverts == nil then
        tbl.serverts = {}
    else
        if servantV2_adj.AdjustServantInfo ~= nil then
            for i = 1, #tbl.serverts do
                servantV2_adj.AdjustServantInfo(tbl.serverts[i])
            end
        end
    end
    if tbl.expPool == nil then
        tbl.expPoolSpecified = false
        tbl.expPool = 0
    else
        tbl.expPoolSpecified = true
    end
    if tbl.reinPool == nil then
        tbl.reinPoolSpecified = false
        tbl.reinPool = 0
    else
        tbl.reinPoolSpecified = true
    end
end

--region metatable servantV2.ReqReceiveMana
---@type servantV2.ReqReceiveMana
servantV2_adj.metatable_ReqReceiveMana = {
    _ClassName = "servantV2.ReqReceiveMana",
}
servantV2_adj.metatable_ReqReceiveMana.__index = servantV2_adj.metatable_ReqReceiveMana
--endregion

---@param tbl servantV2.ReqReceiveMana 待调整的table数据
function servantV2_adj.AdjustReqReceiveMana(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_ReqReceiveMana)
end

--region metatable servantV2.ServantMana
---@type servantV2.ServantMana
servantV2_adj.metatable_ServantMana = {
    _ClassName = "servantV2.ServantMana",
}
servantV2_adj.metatable_ServantMana.__index = servantV2_adj.metatable_ServantMana
--endregion

---@param tbl servantV2.ServantMana 待调整的table数据
function servantV2_adj.AdjustServantMana(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_ServantMana)
    if tbl.receiveToday == nil then
        tbl.receiveTodaySpecified = false
        tbl.receiveToday = false
    else
        tbl.receiveTodaySpecified = true
    end
    if tbl.manaPoll == nil then
        tbl.manaPollSpecified = false
        tbl.manaPoll = 0
    else
        tbl.manaPollSpecified = true
    end
    if tbl.rechargeToday == nil then
        tbl.rechargeTodaySpecified = false
        tbl.rechargeToday = false
    else
        tbl.rechargeTodaySpecified = true
    end
    if tbl.receiveRecharge == nil then
        tbl.receiveRechargeSpecified = false
        tbl.receiveRecharge = false
    else
        tbl.receiveRechargeSpecified = true
    end
end

--region metatable servantV2.ReqServantChangeState
---@type servantV2.ReqServantChangeState
servantV2_adj.metatable_ReqServantChangeState = {
    _ClassName = "servantV2.ReqServantChangeState",
}
servantV2_adj.metatable_ReqServantChangeState.__index = servantV2_adj.metatable_ReqServantChangeState
--endregion

---@param tbl servantV2.ReqServantChangeState 待调整的table数据
function servantV2_adj.AdjustReqServantChangeState(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_ReqServantChangeState)
end

--region metatable servantV2.ServantIdInfo
---@type servantV2.ServantIdInfo
servantV2_adj.metatable_ServantIdInfo = {
    _ClassName = "servantV2.ServantIdInfo",
}
servantV2_adj.metatable_ServantIdInfo.__index = servantV2_adj.metatable_ServantIdInfo
--endregion

---@param tbl servantV2.ServantIdInfo 待调整的table数据
function servantV2_adj.AdjustServantIdInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_ServantIdInfo)
end

--region metatable servantV2.ReqUseServantEgg
---@type servantV2.ReqUseServantEgg
servantV2_adj.metatable_ReqUseServantEgg = {
    _ClassName = "servantV2.ReqUseServantEgg",
}
servantV2_adj.metatable_ReqUseServantEgg.__index = servantV2_adj.metatable_ReqUseServantEgg
--endregion

---@param tbl servantV2.ReqUseServantEgg 待调整的table数据
function servantV2_adj.AdjustReqUseServantEgg(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_ReqUseServantEgg)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.targetType == nil then
        tbl.targetTypeSpecified = false
        tbl.targetType = 0
    else
        tbl.targetTypeSpecified = true
    end
end

--region metatable servantV2.ReqInjectExp
---@type servantV2.ReqInjectExp
servantV2_adj.metatable_ReqInjectExp = {
    _ClassName = "servantV2.ReqInjectExp",
}
servantV2_adj.metatable_ReqInjectExp.__index = servantV2_adj.metatable_ReqInjectExp
--endregion

---@param tbl servantV2.ReqInjectExp 待调整的table数据
function servantV2_adj.AdjustReqInjectExp(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_ReqInjectExp)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.exp == nil then
        tbl.expSpecified = false
        tbl.exp = 0
    else
        tbl.expSpecified = true
    end
end

--region metatable servantV2.ServantExpUpdate
---@type servantV2.ServantExpUpdate
servantV2_adj.metatable_ServantExpUpdate = {
    _ClassName = "servantV2.ServantExpUpdate",
}
servantV2_adj.metatable_ServantExpUpdate.__index = servantV2_adj.metatable_ServantExpUpdate
--endregion

---@param tbl servantV2.ServantExpUpdate 待调整的table数据
function servantV2_adj.AdjustServantExpUpdate(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_ServantExpUpdate)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.exp == nil then
        tbl.expSpecified = false
        tbl.exp = 0
    else
        tbl.expSpecified = true
    end
    if tbl.pool == nil then
        tbl.poolSpecified = false
        tbl.pool = 0
    else
        tbl.poolSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.actId == nil then
        tbl.actIdSpecified = false
        tbl.actId = 0
    else
        tbl.actIdSpecified = true
    end
end

--region metatable servantV2.ServantHpUpdate
---@type servantV2.ServantHpUpdate
servantV2_adj.metatable_ServantHpUpdate = {
    _ClassName = "servantV2.ServantHpUpdate",
}
servantV2_adj.metatable_ServantHpUpdate.__index = servantV2_adj.metatable_ServantHpUpdate
--endregion

---@param tbl servantV2.ServantHpUpdate 待调整的table数据
function servantV2_adj.AdjustServantHpUpdate(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_ServantHpUpdate)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.hp == nil then
        tbl.hpSpecified = false
        tbl.hp = 0
    else
        tbl.hpSpecified = true
    end
    if tbl.maxHp == nil then
        tbl.maxHpSpecified = false
        tbl.maxHp = 0
    else
        tbl.maxHpSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.combineHp == nil then
        tbl.combineHpSpecified = false
        tbl.combineHp = 0
    else
        tbl.combineHpSpecified = true
    end
    if tbl.combineMaxHp == nil then
        tbl.combineMaxHpSpecified = false
        tbl.combineMaxHp = 0
    else
        tbl.combineMaxHpSpecified = true
    end
end

--region metatable servantV2.ReqServantRename
---@type servantV2.ReqServantRename
servantV2_adj.metatable_ReqServantRename = {
    _ClassName = "servantV2.ReqServantRename",
}
servantV2_adj.metatable_ReqServantRename.__index = servantV2_adj.metatable_ReqServantRename
--endregion

---@param tbl servantV2.ReqServantRename 待调整的table数据
function servantV2_adj.AdjustReqServantRename(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_ReqServantRename)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
end

--region metatable servantV2.ResServantName
---@type servantV2.ResServantName
servantV2_adj.metatable_ResServantName = {
    _ClassName = "servantV2.ResServantName",
}
servantV2_adj.metatable_ResServantName.__index = servantV2_adj.metatable_ResServantName
--endregion

---@param tbl servantV2.ResServantName 待调整的table数据
function servantV2_adj.AdjustResServantName(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_ResServantName)
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
end

--region metatable servantV2.ResServantLevelUp
---@type servantV2.ResServantLevelUp
servantV2_adj.metatable_ResServantLevelUp = {
    _ClassName = "servantV2.ResServantLevelUp",
}
servantV2_adj.metatable_ResServantLevelUp.__index = servantV2_adj.metatable_ResServantLevelUp
--endregion

---@param tbl servantV2.ResServantLevelUp 待调整的table数据
function servantV2_adj.AdjustResServantLevelUp(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_ResServantLevelUp)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.exp == nil then
        tbl.expSpecified = false
        tbl.exp = 0
    else
        tbl.expSpecified = true
    end
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
end

--region metatable servantV2.ResServantReinUp
---@type servantV2.ResServantReinUp
servantV2_adj.metatable_ResServantReinUp = {
    _ClassName = "servantV2.ResServantReinUp",
}
servantV2_adj.metatable_ResServantReinUp.__index = servantV2_adj.metatable_ResServantReinUp
--endregion

---@param tbl servantV2.ResServantReinUp 待调整的table数据
function servantV2_adj.AdjustResServantReinUp(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_ResServantReinUp)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.rein == nil then
        tbl.reinSpecified = false
        tbl.rein = 0
    else
        tbl.reinSpecified = true
    end
    if tbl.reinId == nil then
        tbl.reinIdSpecified = false
        tbl.reinId = 0
    else
        tbl.reinIdSpecified = true
    end
end

--region metatable servantV2.ResServantStateChange
---@type servantV2.ResServantStateChange
servantV2_adj.metatable_ResServantStateChange = {
    _ClassName = "servantV2.ResServantStateChange",
}
servantV2_adj.metatable_ResServantStateChange.__index = servantV2_adj.metatable_ResServantStateChange
--endregion

---@param tbl servantV2.ResServantStateChange 待调整的table数据
function servantV2_adj.AdjustResServantStateChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_ResServantStateChange)
end

--region metatable servantV2.ReqServantEquipSoul
---@type servantV2.ReqServantEquipSoul
servantV2_adj.metatable_ReqServantEquipSoul = {
    _ClassName = "servantV2.ReqServantEquipSoul",
}
servantV2_adj.metatable_ReqServantEquipSoul.__index = servantV2_adj.metatable_ReqServantEquipSoul
--endregion

---@param tbl servantV2.ReqServantEquipSoul 待调整的table数据
function servantV2_adj.AdjustReqServantEquipSoul(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_ReqServantEquipSoul)
end

--region metatable servantV2.ReqPurchaseServantSite
---@type servantV2.ReqPurchaseServantSite
servantV2_adj.metatable_ReqPurchaseServantSite = {
    _ClassName = "servantV2.ReqPurchaseServantSite",
}
servantV2_adj.metatable_ReqPurchaseServantSite.__index = servantV2_adj.metatable_ReqPurchaseServantSite
--endregion

---@param tbl servantV2.ReqPurchaseServantSite 待调整的table数据
function servantV2_adj.AdjustReqPurchaseServantSite(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, servantV2_adj.metatable_ReqPurchaseServantSite)
end

return servantV2_adj