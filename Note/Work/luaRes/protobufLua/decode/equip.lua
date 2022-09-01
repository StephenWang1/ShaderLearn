--[[本文件为工具自动生成,禁止手动修改]]
local equipV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData equipV2.EquipsChange lua中的数据结构
---@return equipV2.EquipsChange C#中的数据结构
function equipV2.EquipsChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.EquipsChange()
    if decodedData.equipIndex ~= nil and decodedData.equipIndexSpecified ~= false then
        data.equipIndex = decodedData.equipIndex
    end
    if decodedData.changeEquip ~= nil and decodedData.changeEquipSpecified ~= false then
        data.changeEquip = decodeTable.bag.BagItemInfo(decodedData.changeEquip)
    end
    return data
end

---@param decodedData equipV2.ResAllEquip lua中的数据结构
---@return equipV2.ResAllEquip C#中的数据结构
function equipV2.ResAllEquip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ResAllEquip()
    if decodedData.equipList ~= nil and decodedData.equipListSpecified ~= false then
        for i = 1, #decodedData.equipList do
            data.equipList:Add(equipV2.EquipsChange(decodedData.equipList[i]))
        end
    end
    if decodedData.infos ~= nil and decodedData.infosSpecified ~= false then
        for i = 1, #decodedData.infos do
            data.infos:Add(equipV2.ResRecast(decodedData.infos[i]))
        end
    end
    return data
end

---@param decodedData equipV2.ReqOneKeyPutOnEquip lua中的数据结构
---@return equipV2.ReqOneKeyPutOnEquip C#中的数据结构
function equipV2.ReqOneKeyPutOnEquip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ReqOneKeyPutOnEquip()
    if decodedData.pos ~= nil and decodedData.posSpecified ~= false then
        for i = 1, #decodedData.pos do
            data.pos:Add(decodedData.pos[i])
        end
    end
    if decodedData.uniqueId ~= nil and decodedData.uniqueIdSpecified ~= false then
        for i = 1, #decodedData.uniqueId do
            data.uniqueId:Add(decodedData.uniqueId[i])
        end
    end
    return data
end

---@param decodedData equipV2.ResEquipChange lua中的数据结构
---@return equipV2.ResEquipChange C#中的数据结构
function equipV2.ResEquipChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ResEquipChange()
    if decodedData.equipChange ~= nil and decodedData.equipChangeSpecified ~= false then
        for i = 1, #decodedData.equipChange do
            data.equipChange:Add(equipV2.EquipsChange(decodedData.equipChange[i]))
        end
    end
    if decodedData.reason ~= nil and decodedData.reasonSpecified ~= false then
        data.reason = decodedData.reason
    end
    return data
end

---@param decodedData equipV2.ResItemInfo lua中的数据结构
---@return equipV2.ResItemInfo C#中的数据结构
function equipV2.ResItemInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ResItemInfo()
    if decodedData.changeEquip ~= nil and decodedData.changeEquipSpecified ~= false then
        data.changeEquip = decodeTable.bag.BagItemInfo(decodedData.changeEquip)
    end
    return data
end

---@param decodedData equipV2.ReqGetItemInfo lua中的数据结构
---@return equipV2.ReqGetItemInfo C#中的数据结构
function equipV2.ReqGetItemInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ReqGetItemInfo()
    if decodedData.armId ~= nil and decodedData.armIdSpecified ~= false then
        data.armId = decodedData.armId
    end
    return data
end

---@param decodedData equipV2.ReqPutOnTheEquip lua中的数据结构
---@return equipV2.ReqPutOnTheEquip C#中的数据结构
function equipV2.ReqPutOnTheEquip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ReqPutOnTheEquip()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.equipId ~= nil and decodedData.equipIdSpecified ~= false then
        data.equipId = decodedData.equipId
    end
    return data
end

---@param decodedData equipV2.ReqCombineOrangeEquip lua中的数据结构
---@return equipV2.ReqCombineOrangeEquip C#中的数据结构
function equipV2.ReqCombineOrangeEquip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ReqCombineOrangeEquip()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.heroId ~= nil and decodedData.heroIdSpecified ~= false then
        data.heroId = decodedData.heroId
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.equipId ~= nil and decodedData.equipIdSpecified ~= false then
        data.equipId = decodedData.equipId
    end
    return data
end

---@param decodedData equipV2.ReqPutOffEquip lua中的数据结构
---@return equipV2.ReqPutOffEquip C#中的数据结构
function equipV2.ReqPutOffEquip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ReqPutOffEquip()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData equipV2.ResChangeAppearance lua中的数据结构
---@return equipV2.ResChangeAppearance C#中的数据结构
function equipV2.ResChangeAppearance(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ResChangeAppearance()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.subtype ~= nil and decodedData.subtypeSpecified ~= false then
        data.subtype = decodedData.subtype
    end
    if decodedData.itemid ~= nil and decodedData.itemidSpecified ~= false then
        data.itemid = decodedData.itemid
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData equipV2.ReqRepairEquip lua中的数据结构
---@return equipV2.ReqRepairEquip C#中的数据结构
function equipV2.ReqRepairEquip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ReqRepairEquip()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        for i = 1, #decodedData.itemId do
            data.itemId:Add(decodedData.itemId[i])
        end
    end
    return data
end

---@param decodedData equipV2.ResRepairEquip lua中的数据结构
---@return equipV2.ResRepairEquip C#中的数据结构
function equipV2.ResRepairEquip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ResRepairEquip()
    if decodedData.bodyEquips ~= nil and decodedData.bodyEquipsSpecified ~= false then
        for i = 1, #decodedData.bodyEquips do
            data.bodyEquips:Add(decodeTable.bag.BagItemInfo(decodedData.bodyEquips[i]))
        end
    end
    if decodedData.bagEquips ~= nil and decodedData.bagEquipsSpecified ~= false then
        for i = 1, #decodedData.bagEquips do
            data.bagEquips:Add(decodeTable.bag.BagItemInfo(decodedData.bagEquips[i]))
        end
    end
    return data
end

---@param decodedData equipV2.ItemUseCountInfo lua中的数据结构
---@return equipV2.ItemUseCountInfo C#中的数据结构
function equipV2.ItemUseCountInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ItemUseCountInfo()
    if decodedData.itemTypeId ~= nil and decodedData.itemTypeIdSpecified ~= false then
        data.itemTypeId = decodedData.itemTypeId
    end
    if decodedData.useNum ~= nil and decodedData.useNumSpecified ~= false then
        data.useNum = decodedData.useNum
    end
    return data
end

---@param decodedData equipV2.ReqInlayMedal lua中的数据结构
---@return equipV2.ReqInlayMedal C#中的数据结构
function equipV2.ReqInlayMedal(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ReqInlayMedal()
    if decodedData.equipOwnId ~= nil and decodedData.equipOwnIdSpecified ~= false then
        data.equipOwnId = decodedData.equipOwnId
    end
    if decodedData.inlayId ~= nil and decodedData.inlayIdSpecified ~= false then
        data.inlayId = decodedData.inlayId
    end
    if decodedData.pos ~= nil and decodedData.posSpecified ~= false then
        data.pos = decodedData.pos
    end
    return data
end

---@param decodedData equipV2.ResRepairServantEquip lua中的数据结构
---@return equipV2.ResRepairServantEquip C#中的数据结构
function equipV2.ResRepairServantEquip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ResRepairServantEquip()
    if decodedData.bodyEquips ~= nil and decodedData.bodyEquipsSpecified ~= false then
        for i = 1, #decodedData.bodyEquips do
            data.bodyEquips:Add(decodeTable.bag.BagItemInfo(decodedData.bodyEquips[i]))
        end
    end
    if decodedData.bagEquips ~= nil and decodedData.bagEquipsSpecified ~= false then
        for i = 1, #decodedData.bagEquips do
            data.bagEquips:Add(decodeTable.bag.BagItemInfo(decodedData.bagEquips[i]))
        end
    end
    return data
end

---@param decodedData equipV2.ReqRepairServantEquip lua中的数据结构
---@return equipV2.ReqRepairServantEquip C#中的数据结构
function equipV2.ReqRepairServantEquip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ReqRepairServantEquip()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        for i = 1, #decodedData.itemId do
            data.itemId:Add(decodedData.itemId[i])
        end
    end
    return data
end

---@param decodedData equipV2.ReqEquipRefine lua中的数据结构
---@return equipV2.ReqEquipRefine C#中的数据结构
function equipV2.ReqEquipRefine(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ReqEquipRefine()
    data.equipId1 = decodedData.equipId1
    data.equipId2 = decodedData.equipId2
    return data
end

---@param decodedData equipV2.ReqSaveEquipRefine lua中的数据结构
---@return equipV2.ReqSaveEquipRefine C#中的数据结构
function equipV2.ReqSaveEquipRefine(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ReqSaveEquipRefine()
    data.equipId = decodedData.equipId
    data.index = decodedData.index
    return data
end

---@param decodedData equipV2.ReqWearMagicWeapon lua中的数据结构
---@return equipV2.ReqWearMagicWeapon C#中的数据结构
function equipV2.ReqWearMagicWeapon(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ReqWearMagicWeapon()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    return data
end

---@param decodedData equipV2.ReqTakeOffMagicWeapon lua中的数据结构
---@return equipV2.ReqTakeOffMagicWeapon C#中的数据结构
function equipV2.ReqTakeOffMagicWeapon(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ReqTakeOffMagicWeapon()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData equipV2.MagicWeapon lua中的数据结构
---@return equipV2.MagicWeapon C#中的数据结构
function equipV2.MagicWeapon(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.MagicWeapon()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.itemInfo ~= nil and decodedData.itemInfoSpecified ~= false then
        data.itemInfo = decodeTable.bag.BagItemInfo(decodedData.itemInfo)
    end
    if decodedData.action ~= nil and decodedData.actionSpecified ~= false then
        data.action = decodedData.action
    end
    return data
end

---@param decodedData equipV2.MagicWeaponInfo lua中的数据结构
---@return equipV2.MagicWeaponInfo C#中的数据结构
function equipV2.MagicWeaponInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.MagicWeaponInfo()
    if decodedData.suitType ~= nil and decodedData.suitTypeSpecified ~= false then
        data.suitType = decodedData.suitType
    end
    if decodedData.magicWeapon ~= nil and decodedData.magicWeaponSpecified ~= false then
        for i = 1, #decodedData.magicWeapon do
            data.magicWeapon:Add(equipV2.MagicWeapon(decodedData.magicWeapon[i]))
        end
    end
    if decodedData.skillId ~= nil and decodedData.skillIdSpecified ~= false then
        data.skillId = decodedData.skillId
    end
    return data
end

---@param decodedData equipV2.AllMagicWeaponInfo lua中的数据结构
---@return equipV2.AllMagicWeaponInfo C#中的数据结构
function equipV2.AllMagicWeaponInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.AllMagicWeaponInfo()
    if decodedData.allInfo ~= nil and decodedData.allInfoSpecified ~= false then
        for i = 1, #decodedData.allInfo do
            data.allInfo:Add(equipV2.MagicWeaponInfo(decodedData.allInfo[i]))
        end
    end
    if decodedData.typed ~= nil and decodedData.typedSpecified ~= false then
        data.typed = equipV2.UpdateGetedType(decodedData.typed)
    end
    return data
end

---@param decodedData equipV2.UpdateGetedType lua中的数据结构
---@return equipV2.UpdateGetedType C#中的数据结构
function equipV2.UpdateGetedType(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.UpdateGetedType()
    if decodedData.typed ~= nil and decodedData.typedSpecified ~= false then
        for i = 1, #decodedData.typed do
            data.typed:Add(decodedData.typed[i])
        end
    end
    return data
end

---@param decodedData equipV2.ReqOpenBloodSuitGrid lua中的数据结构
---@return equipV2.ReqOpenBloodSuitGrid C#中的数据结构
function equipV2.ReqOpenBloodSuitGrid(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ReqOpenBloodSuitGrid()
    data.equipIndex = decodedData.equipIndex
    data.costIndex = decodedData.costIndex
    return data
end

---@param decodedData equipV2.ReqPutOnSoulEquip lua中的数据结构
---@return equipV2.ReqPutOnSoulEquip C#中的数据结构
function equipV2.ReqPutOnSoulEquip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ReqPutOnSoulEquip()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.itemLid ~= nil and decodedData.itemLidSpecified ~= false then
        data.itemLid = decodedData.itemLid
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.subIndex ~= nil and decodedData.subIndexSpecified ~= false then
        data.subIndex = decodedData.subIndex
    end
    return data
end

---@param decodedData equipV2.ReqPutOffSoulEquip lua中的数据结构
---@return equipV2.ReqPutOffSoulEquip C#中的数据结构
function equipV2.ReqPutOffSoulEquip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ReqPutOffSoulEquip()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.subIndex ~= nil and decodedData.subIndexSpecified ~= false then
        data.subIndex = decodedData.subIndex
    end
    return data
end

---@param decodedData equipV2.AllSoulEquipInfo lua中的数据结构
---@return equipV2.AllSoulEquipInfo C#中的数据结构
function equipV2.AllSoulEquipInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.AllSoulEquipInfo()
    if decodedData.soulEquips ~= nil and decodedData.soulEquipsSpecified ~= false then
        for i = 1, #decodedData.soulEquips do
            data.soulEquips:Add(equipV2.SoulEquip(decodedData.soulEquips[i]))
        end
    end
    if decodedData.activeSuitId ~= nil and decodedData.activeSuitIdSpecified ~= false then
        for i = 1, #decodedData.activeSuitId do
            data.activeSuitId:Add(decodedData.activeSuitId[i])
        end
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData equipV2.WholeSoulEquips lua中的数据结构
---@return equipV2.WholeSoulEquips C#中的数据结构
function equipV2.WholeSoulEquips(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.WholeSoulEquips()
    if decodedData.allSoulEquipInfo ~= nil and decodedData.allSoulEquipInfoSpecified ~= false then
        for i = 1, #decodedData.allSoulEquipInfo do
            data.allSoulEquipInfo:Add(equipV2.AllSoulEquipInfo(decodedData.allSoulEquipInfo[i]))
        end
    end
    return data
end

---@param decodedData equipV2.SoulEquip lua中的数据结构
---@return equipV2.SoulEquip C#中的数据结构
function equipV2.SoulEquip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.SoulEquip()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.soulEquipInfo ~= nil and decodedData.soulEquipInfoSpecified ~= false then
        for i = 1, #decodedData.soulEquipInfo do
            data.soulEquipInfo:Add(equipV2.SoulEquipInfo(decodedData.soulEquipInfo[i]))
        end
    end
    return data
end

---@param decodedData equipV2.SoulEquipInfo lua中的数据结构
---@return equipV2.SoulEquipInfo C#中的数据结构
function equipV2.SoulEquipInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.SoulEquipInfo()
    if decodedData.subIndex ~= nil and decodedData.subIndexSpecified ~= false then
        data.subIndex = decodedData.subIndex
    end
    if decodedData.itemInfo ~= nil and decodedData.itemInfoSpecified ~= false then
        data.itemInfo = decodeTable.bag.BagItemInfo(decodedData.itemInfo)
    end
    if decodedData.active ~= nil and decodedData.activeSpecified ~= false then
        data.active = decodedData.active
    end
    return data
end

---@param decodedData equipV2.UnlockSoulEquipIndex lua中的数据结构
---@return equipV2.UnlockSoulEquipIndex C#中的数据结构
function equipV2.UnlockSoulEquipIndex(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.UnlockSoulEquipIndex()
    if decodedData.subIndex ~= nil and decodedData.subIndexSpecified ~= false then
        data.subIndex = decodedData.subIndex
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData equipV2.ReqSoulEquipRefin lua中的数据结构
---@return equipV2.ReqSoulEquipRefin C#中的数据结构
function equipV2.ReqSoulEquipRefin(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ReqSoulEquipRefin()
    if decodedData.itemLid ~= nil and decodedData.itemLidSpecified ~= false then
        data.itemLid = decodedData.itemLid
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData equipV2.ResRefinResult lua中的数据结构
---@return equipV2.ResRefinResult C#中的数据结构
function equipV2.ResRefinResult(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ResRefinResult()
    if decodedData.soulEquips ~= nil and decodedData.soulEquipsSpecified ~= false then
        data.soulEquips = equipV2.SoulEquip(decodedData.soulEquips)
    end
    return data
end

---@param decodedData equipV2.ReqAppraisaEquip lua中的数据结构
---@return equipV2.ReqAppraisaEquip C#中的数据结构
function equipV2.ReqAppraisaEquip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ReqAppraisaEquip()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.souce ~= nil and decodedData.souceSpecified ~= false then
        data.souce = decodedData.souce
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData equipV2.ResAppraisaResult lua中的数据结构
---@return equipV2.ResAppraisaResult C#中的数据结构
function equipV2.ResAppraisaResult(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ResAppraisaResult()
    if decodedData.appraisaEquip ~= nil and decodedData.appraisaEquipSpecified ~= false then
        data.appraisaEquip = decodeTable.bag.BagItemInfo(decodedData.appraisaEquip)
    end
    return data
end

---@param decodedData equipV2.ResAppraisaTip lua中的数据结构
---@return equipV2.ResAppraisaTip C#中的数据结构
function equipV2.ResAppraisaTip(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ResAppraisaTip()
    if decodedData.toDayTip ~= nil and decodedData.toDayTipSpecified ~= false then
        data.toDayTip = decodedData.toDayTip
    end
    return data
end

---@param decodedData equipV2.ReqRecast lua中的数据结构
---@return equipV2.ReqRecast C#中的数据结构
function equipV2.ReqRecast(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ReqRecast()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData equipV2.ResRecast lua中的数据结构
---@return equipV2.ResRecast C#中的数据结构
function equipV2.ResRecast(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.ResRecast()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        data.info = equipV2.JewelryRecastInfo(decodedData.info)
    end
    return data
end

---@param decodedData equipV2.JewelryRecastInfo lua中的数据结构
---@return equipV2.JewelryRecastInfo C#中的数据结构
function equipV2.JewelryRecastInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.equipV2.JewelryRecastInfo()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    return data
end

--[[equipV2.ReqGrowthEquip 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return equipV2