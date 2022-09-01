--[[本文件为工具自动生成,禁止手动修改]]
local equipV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable equipV2.EquipsChange
---@type equipV2.EquipsChange
equipV2_adj.metatable_EquipsChange = {
    _ClassName = "equipV2.EquipsChange",
}
equipV2_adj.metatable_EquipsChange.__index = equipV2_adj.metatable_EquipsChange
--endregion

---@param tbl equipV2.EquipsChange 待调整的table数据
function equipV2_adj.AdjustEquipsChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_EquipsChange)
    if tbl.equipIndex == nil then
        tbl.equipIndexSpecified = false
        tbl.equipIndex = 0
    else
        tbl.equipIndexSpecified = true
    end
    if tbl.changeEquip == nil then
        tbl.changeEquipSpecified = false
        tbl.changeEquip = nil
    else
        if tbl.changeEquipSpecified == nil then 
            tbl.changeEquipSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.changeEquip)
            end
        end
    end
end

--region metatable equipV2.ResAllEquip
---@type equipV2.ResAllEquip
equipV2_adj.metatable_ResAllEquip = {
    _ClassName = "equipV2.ResAllEquip",
}
equipV2_adj.metatable_ResAllEquip.__index = equipV2_adj.metatable_ResAllEquip
--endregion

---@param tbl equipV2.ResAllEquip 待调整的table数据
function equipV2_adj.AdjustResAllEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ResAllEquip)
    if tbl.equipList == nil then
        tbl.equipList = {}
    else
        if equipV2_adj.AdjustEquipsChange ~= nil then
            for i = 1, #tbl.equipList do
                equipV2_adj.AdjustEquipsChange(tbl.equipList[i])
            end
        end
    end
    if tbl.infos == nil then
        tbl.infos = {}
    else
        if equipV2_adj.AdjustResRecast ~= nil then
            for i = 1, #tbl.infos do
                equipV2_adj.AdjustResRecast(tbl.infos[i])
            end
        end
    end
end

--region metatable equipV2.ReqOneKeyPutOnEquip
---@type equipV2.ReqOneKeyPutOnEquip
equipV2_adj.metatable_ReqOneKeyPutOnEquip = {
    _ClassName = "equipV2.ReqOneKeyPutOnEquip",
}
equipV2_adj.metatable_ReqOneKeyPutOnEquip.__index = equipV2_adj.metatable_ReqOneKeyPutOnEquip
--endregion

---@param tbl equipV2.ReqOneKeyPutOnEquip 待调整的table数据
function equipV2_adj.AdjustReqOneKeyPutOnEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ReqOneKeyPutOnEquip)
    if tbl.pos == nil then
        tbl.pos = {}
    end
    if tbl.uniqueId == nil then
        tbl.uniqueId = {}
    end
end

--region metatable equipV2.ResEquipChange
---@type equipV2.ResEquipChange
equipV2_adj.metatable_ResEquipChange = {
    _ClassName = "equipV2.ResEquipChange",
}
equipV2_adj.metatable_ResEquipChange.__index = equipV2_adj.metatable_ResEquipChange
--endregion

---@param tbl equipV2.ResEquipChange 待调整的table数据
function equipV2_adj.AdjustResEquipChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ResEquipChange)
    if tbl.equipChange == nil then
        tbl.equipChange = {}
    else
        if equipV2_adj.AdjustEquipsChange ~= nil then
            for i = 1, #tbl.equipChange do
                equipV2_adj.AdjustEquipsChange(tbl.equipChange[i])
            end
        end
    end
    if tbl.reason == nil then
        tbl.reasonSpecified = false
        tbl.reason = 0
    else
        tbl.reasonSpecified = true
    end
end

--region metatable equipV2.ResItemInfo
---@type equipV2.ResItemInfo
equipV2_adj.metatable_ResItemInfo = {
    _ClassName = "equipV2.ResItemInfo",
}
equipV2_adj.metatable_ResItemInfo.__index = equipV2_adj.metatable_ResItemInfo
--endregion

---@param tbl equipV2.ResItemInfo 待调整的table数据
function equipV2_adj.AdjustResItemInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ResItemInfo)
    if tbl.changeEquip == nil then
        tbl.changeEquipSpecified = false
        tbl.changeEquip = nil
    else
        if tbl.changeEquipSpecified == nil then 
            tbl.changeEquipSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.changeEquip)
            end
        end
    end
end

--region metatable equipV2.ReqGetItemInfo
---@type equipV2.ReqGetItemInfo
equipV2_adj.metatable_ReqGetItemInfo = {
    _ClassName = "equipV2.ReqGetItemInfo",
}
equipV2_adj.metatable_ReqGetItemInfo.__index = equipV2_adj.metatable_ReqGetItemInfo
--endregion

---@param tbl equipV2.ReqGetItemInfo 待调整的table数据
function equipV2_adj.AdjustReqGetItemInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ReqGetItemInfo)
    if tbl.armId == nil then
        tbl.armIdSpecified = false
        tbl.armId = 0
    else
        tbl.armIdSpecified = true
    end
end

--region metatable equipV2.ReqPutOnTheEquip
---@type equipV2.ReqPutOnTheEquip
equipV2_adj.metatable_ReqPutOnTheEquip = {
    _ClassName = "equipV2.ReqPutOnTheEquip",
}
equipV2_adj.metatable_ReqPutOnTheEquip.__index = equipV2_adj.metatable_ReqPutOnTheEquip
--endregion

---@param tbl equipV2.ReqPutOnTheEquip 待调整的table数据
function equipV2_adj.AdjustReqPutOnTheEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ReqPutOnTheEquip)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.equipId == nil then
        tbl.equipIdSpecified = false
        tbl.equipId = 0
    else
        tbl.equipIdSpecified = true
    end
end

--region metatable equipV2.ReqCombineOrangeEquip
---@type equipV2.ReqCombineOrangeEquip
equipV2_adj.metatable_ReqCombineOrangeEquip = {
    _ClassName = "equipV2.ReqCombineOrangeEquip",
}
equipV2_adj.metatable_ReqCombineOrangeEquip.__index = equipV2_adj.metatable_ReqCombineOrangeEquip
--endregion

---@param tbl equipV2.ReqCombineOrangeEquip 待调整的table数据
function equipV2_adj.AdjustReqCombineOrangeEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ReqCombineOrangeEquip)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.heroId == nil then
        tbl.heroIdSpecified = false
        tbl.heroId = 0
    else
        tbl.heroIdSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.equipId == nil then
        tbl.equipIdSpecified = false
        tbl.equipId = 0
    else
        tbl.equipIdSpecified = true
    end
end

--region metatable equipV2.ReqPutOffEquip
---@type equipV2.ReqPutOffEquip
equipV2_adj.metatable_ReqPutOffEquip = {
    _ClassName = "equipV2.ReqPutOffEquip",
}
equipV2_adj.metatable_ReqPutOffEquip.__index = equipV2_adj.metatable_ReqPutOffEquip
--endregion

---@param tbl equipV2.ReqPutOffEquip 待调整的table数据
function equipV2_adj.AdjustReqPutOffEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ReqPutOffEquip)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable equipV2.ResChangeAppearance
---@type equipV2.ResChangeAppearance
equipV2_adj.metatable_ResChangeAppearance = {
    _ClassName = "equipV2.ResChangeAppearance",
}
equipV2_adj.metatable_ResChangeAppearance.__index = equipV2_adj.metatable_ResChangeAppearance
--endregion

---@param tbl equipV2.ResChangeAppearance 待调整的table数据
function equipV2_adj.AdjustResChangeAppearance(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ResChangeAppearance)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.subtype == nil then
        tbl.subtypeSpecified = false
        tbl.subtype = 0
    else
        tbl.subtypeSpecified = true
    end
    if tbl.itemid == nil then
        tbl.itemidSpecified = false
        tbl.itemid = 0
    else
        tbl.itemidSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable equipV2.ReqRepairEquip
---@type equipV2.ReqRepairEquip
equipV2_adj.metatable_ReqRepairEquip = {
    _ClassName = "equipV2.ReqRepairEquip",
}
equipV2_adj.metatable_ReqRepairEquip.__index = equipV2_adj.metatable_ReqRepairEquip
--endregion

---@param tbl equipV2.ReqRepairEquip 待调整的table数据
function equipV2_adj.AdjustReqRepairEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ReqRepairEquip)
    if tbl.itemId == nil then
        tbl.itemId = {}
    end
end

--region metatable equipV2.ResRepairEquip
---@type equipV2.ResRepairEquip
equipV2_adj.metatable_ResRepairEquip = {
    _ClassName = "equipV2.ResRepairEquip",
}
equipV2_adj.metatable_ResRepairEquip.__index = equipV2_adj.metatable_ResRepairEquip
--endregion

---@param tbl equipV2.ResRepairEquip 待调整的table数据
function equipV2_adj.AdjustResRepairEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ResRepairEquip)
    if tbl.bodyEquips == nil then
        tbl.bodyEquips = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.bodyEquips do
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.bodyEquips[i])
            end
        end
    end
    if tbl.bagEquips == nil then
        tbl.bagEquips = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.bagEquips do
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.bagEquips[i])
            end
        end
    end
end

--region metatable equipV2.ItemUseCountInfo
---@type equipV2.ItemUseCountInfo
equipV2_adj.metatable_ItemUseCountInfo = {
    _ClassName = "equipV2.ItemUseCountInfo",
}
equipV2_adj.metatable_ItemUseCountInfo.__index = equipV2_adj.metatable_ItemUseCountInfo
--endregion

---@param tbl equipV2.ItemUseCountInfo 待调整的table数据
function equipV2_adj.AdjustItemUseCountInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ItemUseCountInfo)
    if tbl.itemTypeId == nil then
        tbl.itemTypeIdSpecified = false
        tbl.itemTypeId = 0
    else
        tbl.itemTypeIdSpecified = true
    end
    if tbl.useNum == nil then
        tbl.useNumSpecified = false
        tbl.useNum = 0
    else
        tbl.useNumSpecified = true
    end
end

--region metatable equipV2.ReqInlayMedal
---@type equipV2.ReqInlayMedal
equipV2_adj.metatable_ReqInlayMedal = {
    _ClassName = "equipV2.ReqInlayMedal",
}
equipV2_adj.metatable_ReqInlayMedal.__index = equipV2_adj.metatable_ReqInlayMedal
--endregion

---@param tbl equipV2.ReqInlayMedal 待调整的table数据
function equipV2_adj.AdjustReqInlayMedal(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ReqInlayMedal)
    if tbl.equipOwnId == nil then
        tbl.equipOwnIdSpecified = false
        tbl.equipOwnId = 0
    else
        tbl.equipOwnIdSpecified = true
    end
    if tbl.inlayId == nil then
        tbl.inlayIdSpecified = false
        tbl.inlayId = 0
    else
        tbl.inlayIdSpecified = true
    end
    if tbl.pos == nil then
        tbl.posSpecified = false
        tbl.pos = 0
    else
        tbl.posSpecified = true
    end
end

--region metatable equipV2.ResRepairServantEquip
---@type equipV2.ResRepairServantEquip
equipV2_adj.metatable_ResRepairServantEquip = {
    _ClassName = "equipV2.ResRepairServantEquip",
}
equipV2_adj.metatable_ResRepairServantEquip.__index = equipV2_adj.metatable_ResRepairServantEquip
--endregion

---@param tbl equipV2.ResRepairServantEquip 待调整的table数据
function equipV2_adj.AdjustResRepairServantEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ResRepairServantEquip)
    if tbl.bodyEquips == nil then
        tbl.bodyEquips = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.bodyEquips do
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.bodyEquips[i])
            end
        end
    end
    if tbl.bagEquips == nil then
        tbl.bagEquips = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.bagEquips do
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.bagEquips[i])
            end
        end
    end
end

--region metatable equipV2.ReqRepairServantEquip
---@type equipV2.ReqRepairServantEquip
equipV2_adj.metatable_ReqRepairServantEquip = {
    _ClassName = "equipV2.ReqRepairServantEquip",
}
equipV2_adj.metatable_ReqRepairServantEquip.__index = equipV2_adj.metatable_ReqRepairServantEquip
--endregion

---@param tbl equipV2.ReqRepairServantEquip 待调整的table数据
function equipV2_adj.AdjustReqRepairServantEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ReqRepairServantEquip)
    if tbl.itemId == nil then
        tbl.itemId = {}
    end
end

--region metatable equipV2.ReqEquipRefine
---@type equipV2.ReqEquipRefine
equipV2_adj.metatable_ReqEquipRefine = {
    _ClassName = "equipV2.ReqEquipRefine",
}
equipV2_adj.metatable_ReqEquipRefine.__index = equipV2_adj.metatable_ReqEquipRefine
--endregion

---@param tbl equipV2.ReqEquipRefine 待调整的table数据
function equipV2_adj.AdjustReqEquipRefine(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ReqEquipRefine)
end

--region metatable equipV2.ReqSaveEquipRefine
---@type equipV2.ReqSaveEquipRefine
equipV2_adj.metatable_ReqSaveEquipRefine = {
    _ClassName = "equipV2.ReqSaveEquipRefine",
}
equipV2_adj.metatable_ReqSaveEquipRefine.__index = equipV2_adj.metatable_ReqSaveEquipRefine
--endregion

---@param tbl equipV2.ReqSaveEquipRefine 待调整的table数据
function equipV2_adj.AdjustReqSaveEquipRefine(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ReqSaveEquipRefine)
end

--region metatable equipV2.ReqWearMagicWeapon
---@type equipV2.ReqWearMagicWeapon
equipV2_adj.metatable_ReqWearMagicWeapon = {
    _ClassName = "equipV2.ReqWearMagicWeapon",
}
equipV2_adj.metatable_ReqWearMagicWeapon.__index = equipV2_adj.metatable_ReqWearMagicWeapon
--endregion

---@param tbl equipV2.ReqWearMagicWeapon 待调整的table数据
function equipV2_adj.AdjustReqWearMagicWeapon(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ReqWearMagicWeapon)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
end

--region metatable equipV2.ReqTakeOffMagicWeapon
---@type equipV2.ReqTakeOffMagicWeapon
equipV2_adj.metatable_ReqTakeOffMagicWeapon = {
    _ClassName = "equipV2.ReqTakeOffMagicWeapon",
}
equipV2_adj.metatable_ReqTakeOffMagicWeapon.__index = equipV2_adj.metatable_ReqTakeOffMagicWeapon
--endregion

---@param tbl equipV2.ReqTakeOffMagicWeapon 待调整的table数据
function equipV2_adj.AdjustReqTakeOffMagicWeapon(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ReqTakeOffMagicWeapon)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable equipV2.MagicWeapon
---@type equipV2.MagicWeapon
equipV2_adj.metatable_MagicWeapon = {
    _ClassName = "equipV2.MagicWeapon",
}
equipV2_adj.metatable_MagicWeapon.__index = equipV2_adj.metatable_MagicWeapon
--endregion

---@param tbl equipV2.MagicWeapon 待调整的table数据
function equipV2_adj.AdjustMagicWeapon(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_MagicWeapon)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.itemInfo == nil then
        tbl.itemInfoSpecified = false
        tbl.itemInfo = nil
    else
        if tbl.itemInfoSpecified == nil then 
            tbl.itemInfoSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.itemInfo)
            end
        end
    end
    if tbl.action == nil then
        tbl.actionSpecified = false
        tbl.action = 0
    else
        tbl.actionSpecified = true
    end
end

--region metatable equipV2.MagicWeaponInfo
---@type equipV2.MagicWeaponInfo
equipV2_adj.metatable_MagicWeaponInfo = {
    _ClassName = "equipV2.MagicWeaponInfo",
}
equipV2_adj.metatable_MagicWeaponInfo.__index = equipV2_adj.metatable_MagicWeaponInfo
--endregion

---@param tbl equipV2.MagicWeaponInfo 待调整的table数据
function equipV2_adj.AdjustMagicWeaponInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_MagicWeaponInfo)
    if tbl.suitType == nil then
        tbl.suitTypeSpecified = false
        tbl.suitType = 0
    else
        tbl.suitTypeSpecified = true
    end
    if tbl.magicWeapon == nil then
        tbl.magicWeapon = {}
    else
        if equipV2_adj.AdjustMagicWeapon ~= nil then
            for i = 1, #tbl.magicWeapon do
                equipV2_adj.AdjustMagicWeapon(tbl.magicWeapon[i])
            end
        end
    end
    if tbl.skillId == nil then
        tbl.skillIdSpecified = false
        tbl.skillId = 0
    else
        tbl.skillIdSpecified = true
    end
end

--region metatable equipV2.AllMagicWeaponInfo
---@type equipV2.AllMagicWeaponInfo
equipV2_adj.metatable_AllMagicWeaponInfo = {
    _ClassName = "equipV2.AllMagicWeaponInfo",
}
equipV2_adj.metatable_AllMagicWeaponInfo.__index = equipV2_adj.metatable_AllMagicWeaponInfo
--endregion

---@param tbl equipV2.AllMagicWeaponInfo 待调整的table数据
function equipV2_adj.AdjustAllMagicWeaponInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_AllMagicWeaponInfo)
    if tbl.allInfo == nil then
        tbl.allInfo = {}
    else
        if equipV2_adj.AdjustMagicWeaponInfo ~= nil then
            for i = 1, #tbl.allInfo do
                equipV2_adj.AdjustMagicWeaponInfo(tbl.allInfo[i])
            end
        end
    end
    if tbl.typed == nil then
        tbl.typedSpecified = false
        tbl.typed = nil
    else
        if tbl.typedSpecified == nil then 
            tbl.typedSpecified = true
            if equipV2_adj.AdjustUpdateGetedType ~= nil then
                equipV2_adj.AdjustUpdateGetedType(tbl.typed)
            end
        end
    end
end

--region metatable equipV2.UpdateGetedType
---@type equipV2.UpdateGetedType
equipV2_adj.metatable_UpdateGetedType = {
    _ClassName = "equipV2.UpdateGetedType",
}
equipV2_adj.metatable_UpdateGetedType.__index = equipV2_adj.metatable_UpdateGetedType
--endregion

---@param tbl equipV2.UpdateGetedType 待调整的table数据
function equipV2_adj.AdjustUpdateGetedType(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_UpdateGetedType)
    if tbl.typed == nil then
        tbl.typed = {}
    end
end

--region metatable equipV2.ReqOpenBloodSuitGrid
---@type equipV2.ReqOpenBloodSuitGrid
equipV2_adj.metatable_ReqOpenBloodSuitGrid = {
    _ClassName = "equipV2.ReqOpenBloodSuitGrid",
}
equipV2_adj.metatable_ReqOpenBloodSuitGrid.__index = equipV2_adj.metatable_ReqOpenBloodSuitGrid
--endregion

---@param tbl equipV2.ReqOpenBloodSuitGrid 待调整的table数据
function equipV2_adj.AdjustReqOpenBloodSuitGrid(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ReqOpenBloodSuitGrid)
end

--region metatable equipV2.ReqPutOnSoulEquip
---@type equipV2.ReqPutOnSoulEquip
equipV2_adj.metatable_ReqPutOnSoulEquip = {
    _ClassName = "equipV2.ReqPutOnSoulEquip",
}
equipV2_adj.metatable_ReqPutOnSoulEquip.__index = equipV2_adj.metatable_ReqPutOnSoulEquip
--endregion

---@param tbl equipV2.ReqPutOnSoulEquip 待调整的table数据
function equipV2_adj.AdjustReqPutOnSoulEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ReqPutOnSoulEquip)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.itemLid == nil then
        tbl.itemLidSpecified = false
        tbl.itemLid = 0
    else
        tbl.itemLidSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.subIndex == nil then
        tbl.subIndexSpecified = false
        tbl.subIndex = 0
    else
        tbl.subIndexSpecified = true
    end
end

--region metatable equipV2.ReqPutOffSoulEquip
---@type equipV2.ReqPutOffSoulEquip
equipV2_adj.metatable_ReqPutOffSoulEquip = {
    _ClassName = "equipV2.ReqPutOffSoulEquip",
}
equipV2_adj.metatable_ReqPutOffSoulEquip.__index = equipV2_adj.metatable_ReqPutOffSoulEquip
--endregion

---@param tbl equipV2.ReqPutOffSoulEquip 待调整的table数据
function equipV2_adj.AdjustReqPutOffSoulEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ReqPutOffSoulEquip)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.subIndex == nil then
        tbl.subIndexSpecified = false
        tbl.subIndex = 0
    else
        tbl.subIndexSpecified = true
    end
end

--region metatable equipV2.AllSoulEquipInfo
---@type equipV2.AllSoulEquipInfo
equipV2_adj.metatable_AllSoulEquipInfo = {
    _ClassName = "equipV2.AllSoulEquipInfo",
}
equipV2_adj.metatable_AllSoulEquipInfo.__index = equipV2_adj.metatable_AllSoulEquipInfo
--endregion

---@param tbl equipV2.AllSoulEquipInfo 待调整的table数据
function equipV2_adj.AdjustAllSoulEquipInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_AllSoulEquipInfo)
    if tbl.soulEquips == nil then
        tbl.soulEquips = {}
    else
        if equipV2_adj.AdjustSoulEquip ~= nil then
            for i = 1, #tbl.soulEquips do
                equipV2_adj.AdjustSoulEquip(tbl.soulEquips[i])
            end
        end
    end
    if tbl.activeSuitId == nil then
        tbl.activeSuitId = {}
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable equipV2.WholeSoulEquips
---@type equipV2.WholeSoulEquips
equipV2_adj.metatable_WholeSoulEquips = {
    _ClassName = "equipV2.WholeSoulEquips",
}
equipV2_adj.metatable_WholeSoulEquips.__index = equipV2_adj.metatable_WholeSoulEquips
--endregion

---@param tbl equipV2.WholeSoulEquips 待调整的table数据
function equipV2_adj.AdjustWholeSoulEquips(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_WholeSoulEquips)
    if tbl.allSoulEquipInfo == nil then
        tbl.allSoulEquipInfo = {}
    else
        if equipV2_adj.AdjustAllSoulEquipInfo ~= nil then
            for i = 1, #tbl.allSoulEquipInfo do
                equipV2_adj.AdjustAllSoulEquipInfo(tbl.allSoulEquipInfo[i])
            end
        end
    end
end

--region metatable equipV2.SoulEquip
---@type equipV2.SoulEquip
equipV2_adj.metatable_SoulEquip = {
    _ClassName = "equipV2.SoulEquip",
}
equipV2_adj.metatable_SoulEquip.__index = equipV2_adj.metatable_SoulEquip
--endregion

---@param tbl equipV2.SoulEquip 待调整的table数据
function equipV2_adj.AdjustSoulEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_SoulEquip)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.soulEquipInfo == nil then
        tbl.soulEquipInfo = {}
    else
        if equipV2_adj.AdjustSoulEquipInfo ~= nil then
            for i = 1, #tbl.soulEquipInfo do
                equipV2_adj.AdjustSoulEquipInfo(tbl.soulEquipInfo[i])
            end
        end
    end
end

--region metatable equipV2.SoulEquipInfo
---@type equipV2.SoulEquipInfo
equipV2_adj.metatable_SoulEquipInfo = {
    _ClassName = "equipV2.SoulEquipInfo",
}
equipV2_adj.metatable_SoulEquipInfo.__index = equipV2_adj.metatable_SoulEquipInfo
--endregion

---@param tbl equipV2.SoulEquipInfo 待调整的table数据
function equipV2_adj.AdjustSoulEquipInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_SoulEquipInfo)
    if tbl.subIndex == nil then
        tbl.subIndexSpecified = false
        tbl.subIndex = 0
    else
        tbl.subIndexSpecified = true
    end
    if tbl.itemInfo == nil then
        tbl.itemInfoSpecified = false
        tbl.itemInfo = nil
    else
        if tbl.itemInfoSpecified == nil then 
            tbl.itemInfoSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.itemInfo)
            end
        end
    end
    if tbl.active == nil then
        tbl.activeSpecified = false
        tbl.active = false
    else
        tbl.activeSpecified = true
    end
end

--region metatable equipV2.UnlockSoulEquipIndex
---@type equipV2.UnlockSoulEquipIndex
equipV2_adj.metatable_UnlockSoulEquipIndex = {
    _ClassName = "equipV2.UnlockSoulEquipIndex",
}
equipV2_adj.metatable_UnlockSoulEquipIndex.__index = equipV2_adj.metatable_UnlockSoulEquipIndex
--endregion

---@param tbl equipV2.UnlockSoulEquipIndex 待调整的table数据
function equipV2_adj.AdjustUnlockSoulEquipIndex(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_UnlockSoulEquipIndex)
    if tbl.subIndex == nil then
        tbl.subIndexSpecified = false
        tbl.subIndex = 0
    else
        tbl.subIndexSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable equipV2.ReqSoulEquipRefin
---@type equipV2.ReqSoulEquipRefin
equipV2_adj.metatable_ReqSoulEquipRefin = {
    _ClassName = "equipV2.ReqSoulEquipRefin",
}
equipV2_adj.metatable_ReqSoulEquipRefin.__index = equipV2_adj.metatable_ReqSoulEquipRefin
--endregion

---@param tbl equipV2.ReqSoulEquipRefin 待调整的table数据
function equipV2_adj.AdjustReqSoulEquipRefin(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ReqSoulEquipRefin)
    if tbl.itemLid == nil then
        tbl.itemLidSpecified = false
        tbl.itemLid = 0
    else
        tbl.itemLidSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable equipV2.ResRefinResult
---@type equipV2.ResRefinResult
equipV2_adj.metatable_ResRefinResult = {
    _ClassName = "equipV2.ResRefinResult",
}
equipV2_adj.metatable_ResRefinResult.__index = equipV2_adj.metatable_ResRefinResult
--endregion

---@param tbl equipV2.ResRefinResult 待调整的table数据
function equipV2_adj.AdjustResRefinResult(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ResRefinResult)
    if tbl.soulEquips == nil then
        tbl.soulEquipsSpecified = false
        tbl.soulEquips = nil
    else
        if tbl.soulEquipsSpecified == nil then 
            tbl.soulEquipsSpecified = true
            if equipV2_adj.AdjustSoulEquip ~= nil then
                equipV2_adj.AdjustSoulEquip(tbl.soulEquips)
            end
        end
    end
end

--region metatable equipV2.ReqAppraisaEquip
---@type equipV2.ReqAppraisaEquip
equipV2_adj.metatable_ReqAppraisaEquip = {
    _ClassName = "equipV2.ReqAppraisaEquip",
}
equipV2_adj.metatable_ReqAppraisaEquip.__index = equipV2_adj.metatable_ReqAppraisaEquip
--endregion

---@param tbl equipV2.ReqAppraisaEquip 待调整的table数据
function equipV2_adj.AdjustReqAppraisaEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ReqAppraisaEquip)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.souce == nil then
        tbl.souceSpecified = false
        tbl.souce = 0
    else
        tbl.souceSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable equipV2.ResAppraisaResult
---@type equipV2.ResAppraisaResult
equipV2_adj.metatable_ResAppraisaResult = {
    _ClassName = "equipV2.ResAppraisaResult",
}
equipV2_adj.metatable_ResAppraisaResult.__index = equipV2_adj.metatable_ResAppraisaResult
--endregion

---@param tbl equipV2.ResAppraisaResult 待调整的table数据
function equipV2_adj.AdjustResAppraisaResult(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ResAppraisaResult)
    if tbl.appraisaEquip == nil then
        tbl.appraisaEquipSpecified = false
        tbl.appraisaEquip = nil
    else
        if tbl.appraisaEquipSpecified == nil then 
            tbl.appraisaEquipSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.appraisaEquip)
            end
        end
    end
end

--region metatable equipV2.ResAppraisaTip
---@type equipV2.ResAppraisaTip
equipV2_adj.metatable_ResAppraisaTip = {
    _ClassName = "equipV2.ResAppraisaTip",
}
equipV2_adj.metatable_ResAppraisaTip.__index = equipV2_adj.metatable_ResAppraisaTip
--endregion

---@param tbl equipV2.ResAppraisaTip 待调整的table数据
function equipV2_adj.AdjustResAppraisaTip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ResAppraisaTip)
    if tbl.toDayTip == nil then
        tbl.toDayTipSpecified = false
        tbl.toDayTip = 0
    else
        tbl.toDayTipSpecified = true
    end
end

--region metatable equipV2.ReqRecast
---@type equipV2.ReqRecast
equipV2_adj.metatable_ReqRecast = {
    _ClassName = "equipV2.ReqRecast",
}
equipV2_adj.metatable_ReqRecast.__index = equipV2_adj.metatable_ReqRecast
--endregion

---@param tbl equipV2.ReqRecast 待调整的table数据
function equipV2_adj.AdjustReqRecast(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ReqRecast)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable equipV2.ResRecast
---@type equipV2.ResRecast
equipV2_adj.metatable_ResRecast = {
    _ClassName = "equipV2.ResRecast",
}
equipV2_adj.metatable_ResRecast.__index = equipV2_adj.metatable_ResRecast
--endregion

---@param tbl equipV2.ResRecast 待调整的table数据
function equipV2_adj.AdjustResRecast(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ResRecast)
    if tbl.info == nil then
        tbl.infoSpecified = false
        tbl.info = nil
    else
        if tbl.infoSpecified == nil then 
            tbl.infoSpecified = true
            if equipV2_adj.AdjustJewelryRecastInfo ~= nil then
                equipV2_adj.AdjustJewelryRecastInfo(tbl.info)
            end
        end
    end
end

--region metatable equipV2.JewelryRecastInfo
---@type equipV2.JewelryRecastInfo
equipV2_adj.metatable_JewelryRecastInfo = {
    _ClassName = "equipV2.JewelryRecastInfo",
}
equipV2_adj.metatable_JewelryRecastInfo.__index = equipV2_adj.metatable_JewelryRecastInfo
--endregion

---@param tbl equipV2.JewelryRecastInfo 待调整的table数据
function equipV2_adj.AdjustJewelryRecastInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_JewelryRecastInfo)
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
end

--region metatable equipV2.ReqGrowthEquip
---@type equipV2.ReqGrowthEquip
equipV2_adj.metatable_ReqGrowthEquip = {
    _ClassName = "equipV2.ReqGrowthEquip",
}
equipV2_adj.metatable_ReqGrowthEquip.__index = equipV2_adj.metatable_ReqGrowthEquip
--endregion

---@param tbl equipV2.ReqGrowthEquip 待调整的table数据
function equipV2_adj.AdjustReqGrowthEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, equipV2_adj.metatable_ReqGrowthEquip)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

return equipV2_adj