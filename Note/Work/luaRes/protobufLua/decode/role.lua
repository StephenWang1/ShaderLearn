--[[本文件为工具自动生成,禁止手动修改]]
local roleV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData roleV2.PetBean lua中的数据结构
---@return roleV2.PetBean C#中的数据结构
function roleV2.PetBean(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.PetBean()
    data.id = decodedData.id
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData roleV2.AttributeInfo lua中的数据结构
---@return roleV2.AttributeInfo C#中的数据结构
function roleV2.AttributeInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.AttributeInfo()
    data.attributeType = decodedData.attributeType
    data.attributeValue = decodedData.attributeValue
    return data
end

---@param decodedData roleV2.SpecialRingBean lua中的数据结构
---@return roleV2.SpecialRingBean C#中的数据结构
function roleV2.SpecialRingBean(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.SpecialRingBean()
    data.type = decodedData.type
    data.level = decodedData.level
    return data
end

---@param decodedData roleV2.ReinItemBean lua中的数据结构
---@return roleV2.ReinItemBean C#中的数据结构
function roleV2.ReinItemBean(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ReinItemBean()
    data.itemId = decodedData.itemId
    if decodedData.useNum ~= nil and decodedData.useNumSpecified ~= false then
        data.useNum = decodedData.useNum
    end
    return data
end

---@param decodedData roleV2.VeinBean lua中的数据结构
---@return roleV2.VeinBean C#中的数据结构
function roleV2.VeinBean(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.VeinBean()
    data.newId = decodedData.newId
    if decodedData.fightValue ~= nil and decodedData.fightValueSpecified ~= false then
        data.fightValue = decodedData.fightValue
    end
    return data
end

---@param decodedData roleV2.InnerPowerInfoBean lua中的数据结构
---@return roleV2.InnerPowerInfoBean C#中的数据结构
function roleV2.InnerPowerInfoBean(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.InnerPowerInfoBean()
    data.innerCfgId = decodedData.innerCfgId
    data.innerExp = decodedData.innerExp
    return data
end

---@param decodedData roleV2.RoleSettingBean lua中的数据结构
---@return roleV2.RoleSettingBean C#中的数据结构
function roleV2.RoleSettingBean(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.RoleSettingBean()
    data.id = decodedData.id
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    data.roleSettingValue = decodedData.roleSettingValue
    return data
end

---@param decodedData roleV2.HandyKeyBean lua中的数据结构
---@return roleV2.HandyKeyBean C#中的数据结构
function roleV2.HandyKeyBean(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.HandyKeyBean()
    data.index = decodedData.index
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.param ~= nil and decodedData.paramSpecified ~= false then
        data.param = decodedData.param
    end
    return data
end

---@param decodedData roleV2.OtherPlayerCommonInfo lua中的数据结构
---@return roleV2.OtherPlayerCommonInfo C#中的数据结构
function roleV2.OtherPlayerCommonInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.OtherPlayerCommonInfo()
    data.otherRoleId = decodedData.otherRoleId
    data.teamId = decodedData.teamId
    data.selfTeamId = decodedData.selfTeamId
    if decodedData.isFriend ~= nil and decodedData.isFriendSpecified ~= false then
        data.isFriend = decodedData.isFriend
    end
    if decodedData.isBlack ~= nil and decodedData.isBlackSpecified ~= false then
        data.isBlack = decodedData.isBlack
    end
    return data
end

---@param decodedData roleV2.RoleToOtherInfo lua中的数据结构
---@return roleV2.RoleToOtherInfo C#中的数据结构
function roleV2.RoleToOtherInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.RoleToOtherInfo()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.roleName ~= nil and decodedData.roleNameSpecified ~= false then
        data.roleName = decodedData.roleName
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.line ~= nil and decodedData.lineSpecified ~= false then
        data.line = decodedData.line
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.maxHp ~= nil and decodedData.maxHpSpecified ~= false then
        data.maxHp = decodedData.maxHp
    end
    if decodedData.weapon ~= nil and decodedData.weaponSpecified ~= false then
        data.weapon = decodedData.weapon
    end
    if decodedData.armor ~= nil and decodedData.armorSpecified ~= false then
        data.armor = decodedData.armor
    end
    if decodedData.buffers ~= nil and decodedData.buffersSpecified ~= false then
        for i = 1, #decodedData.buffers do
            data.buffers:Add(decodeTable.fight.BufferInfo(decodedData.buffers[i]))
        end
    end
    if decodedData.mp ~= nil and decodedData.mpSpecified ~= false then
        data.mp = decodedData.mp
    end
    if decodedData.maxMp ~= nil and decodedData.maxMpSpecified ~= false then
        data.maxMp = decodedData.maxMp
    end
    if decodedData.vipLevel ~= nil and decodedData.vipLevelSpecified ~= false then
        data.vipLevel = decodedData.vipLevel
    end
    if decodedData.wing ~= nil and decodedData.wingSpecified ~= false then
        data.wing = decodedData.wing
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.unionPos ~= nil and decodedData.unionPosSpecified ~= false then
        data.unionPos = decodedData.unionPos
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.equipList ~= nil and decodedData.equipListSpecified ~= false then
        for i = 1, #decodedData.equipList do
            data.equipList:Add(decodeTable.bag.BagItemInfo(decodedData.equipList[i]))
        end
    end
    if decodedData.helmet ~= nil and decodedData.helmetSpecified ~= false then
        data.helmet = decodedData.helmet
    end
    if decodedData.extraEquipList ~= nil and decodedData.extraEquipListSpecified ~= false then
        for i = 1, #decodedData.extraEquipList do
            data.extraEquipList:Add(decodeTable.bag.ExtraEquip(decodedData.extraEquipList[i]))
        end
    end
    if decodedData.wearPosition ~= nil and decodedData.wearPositionSpecified ~= false then
        for i = 1, #decodedData.wearPosition do
            data.wearPosition:Add(decodeTable.appearance.wearPosition(decodedData.wearPosition[i]))
        end
    end
    if decodedData.marryInfo ~= nil and decodedData.marryInfoSpecified ~= false then
        data.marryInfo = decodeTable.marry.ResPlayerMarriageInformation(decodedData.marryInfo)
    end
    if decodedData.appellation ~= nil and decodedData.appellationSpecified ~= false then
        data.appellation = decodedData.appellation
    end
    if decodedData.attr ~= nil and decodedData.attrSpecified ~= false then
        for i = 1, #decodedData.attr do
            data.attr:Add(roleV2.PlayerAttribute(decodedData.attr[i]))
        end
    end
    if decodedData.nbValue ~= nil and decodedData.nbValueSpecified ~= false then
        data.nbValue = decodedData.nbValue
    end
    if decodedData.imprint ~= nil and decodedData.imprintSpecified ~= false then
        for i = 1, #decodedData.imprint do
            data.imprint:Add(decodeTable.imprint.ImprintInfo(decodedData.imprint[i]))
        end
    end
    if decodedData.element ~= nil and decodedData.elementSpecified ~= false then
        for i = 1, #decodedData.element do
            data.element:Add(decodeTable.element.ElementInfo(decodedData.element[i]))
        end
    end
    if decodedData.face ~= nil and decodedData.faceSpecified ~= false then
        data.face = decodedData.face
    end
    if decodedData.monthCard ~= nil and decodedData.monthCardSpecified ~= false then
        for i = 1, #decodedData.monthCard do
            data.monthCard:Add(decodedData.monthCard[i])
        end
    end
    if decodedData.isChairman ~= nil and decodedData.isChairmanSpecified ~= false then
        data.isChairman = decodedData.isChairman
    end
    if decodedData.hostId ~= nil and decodedData.hostIdSpecified ~= false then
        data.hostId = decodedData.hostId
    end
    if decodedData.magicWeapon ~= nil and decodedData.magicWeaponSpecified ~= false then
        data.magicWeapon = decodeTable.equip.AllMagicWeaponInfo(decodedData.magicWeapon)
    end
    if decodedData.rein ~= nil and decodedData.reinSpecified ~= false then
        data.rein = decodedData.rein
    end
    if decodedData.officialPosistionId ~= nil and decodedData.officialPosistionIdSpecified ~= false then
        data.officialPosistionId = decodedData.officialPosistionId
    end
    if decodedData.soulEquip ~= nil and decodedData.soulEquipSpecified ~= false then
        data.soulEquip = decodeTable.equip.WholeSoulEquips(decodedData.soulEquip)
    end
    if decodedData.emperorTokenId ~= nil and decodedData.emperorTokenIdSpecified ~= false then
        data.emperorTokenId = decodedData.emperorTokenId
    end
    if decodedData.cabinetInfo ~= nil and decodedData.cabinetInfoSpecified ~= false then
        data.cabinetInfo = decodeTable.collect.CabinetInfo(decodedData.cabinetInfo)
    end
    if decodedData.vipMember ~= nil and decodedData.vipMemberSpecified ~= false then
        data.vipMember = roleV2.VipMember(decodedData.vipMember)
    end
    if decodedData.sealMarkId ~= nil and decodedData.sealMarkIdSpecified ~= false then
        data.sealMarkId = decodedData.sealMarkId
    end
    if decodedData.zhenfa ~= nil and decodedData.zhenfaSpecified ~= false then
        data.zhenfa = decodeTable.zhenfa.ZhenfaInfo(decodedData.zhenfa)
    end
    if decodedData.resRecasts ~= nil and decodedData.resRecastsSpecified ~= false then
        for i = 1, #decodedData.resRecasts do
            data.resRecasts:Add(decodeTable.equip.ResRecast(decodedData.resRecasts[i]))
        end
    end
    if decodedData.shield ~= nil and decodedData.shieldSpecified ~= false then
        data.shield = decodedData.shield
    end
    if decodedData.bambooHat ~= nil and decodedData.bambooHatSpecified ~= false then
        data.bambooHat = decodedData.bambooHat
    end
    return data
end

---@param decodedData roleV2.VipMember lua中的数据结构
---@return roleV2.VipMember C#中的数据结构
function roleV2.VipMember(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.VipMember()
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    return data
end

---@param decodedData roleV2.PlayerAttribute lua中的数据结构
---@return roleV2.PlayerAttribute C#中的数据结构
function roleV2.PlayerAttribute(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.PlayerAttribute()
    data.type = decodedData.type
    data.num = decodedData.num
    return data
end

---@param decodedData roleV2.ResPlayerAttributeChange lua中的数据结构
---@return roleV2.ResPlayerAttributeChange C#中的数据结构
function roleV2.ResPlayerAttributeChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResPlayerAttributeChange()
    data.uid = decodedData.uid
    if decodedData.power ~= nil and decodedData.powerSpecified ~= false then
        data.power = decodedData.power
    end
    if decodedData.attr ~= nil and decodedData.attrSpecified ~= false then
        for i = 1, #decodedData.attr do
            data.attr:Add(roleV2.PlayerAttribute(decodedData.attr[i]))
        end
    end
    if decodedData.changeAttr ~= nil and decodedData.changeAttrSpecified ~= false then
        for i = 1, #decodedData.changeAttr do
            data.changeAttr:Add(roleV2.PlayerAttribute(decodedData.changeAttr[i]))
        end
    end
    if decodedData.changePower ~= nil and decodedData.changePowerSpecified ~= false then
        data.changePower = decodedData.changePower
    end
    return data
end

---@param decodedData roleV2.ResPlayerBasicInfo lua中的数据结构
---@return roleV2.ResPlayerBasicInfo C#中的数据结构
function roleV2.ResPlayerBasicInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResPlayerBasicInfo()
    if decodedData.power ~= nil and decodedData.powerSpecified ~= false then
        data.power = decodedData.power
    end
    if decodedData.attr ~= nil and decodedData.attrSpecified ~= false then
        for i = 1, #decodedData.attr do
            data.attr:Add(roleV2.PlayerAttribute(decodedData.attr[i]))
        end
    end
    if decodedData.hp ~= nil and decodedData.hpSpecified ~= false then
        data.hp = decodedData.hp
    end
    if decodedData.mp ~= nil and decodedData.mpSpecified ~= false then
        data.mp = decodedData.mp
    end
    if decodedData.innerPower ~= nil and decodedData.innerPowerSpecified ~= false then
        data.innerPower = decodedData.innerPower
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.reinLevel ~= nil and decodedData.reinLevelSpecified ~= false then
        data.reinLevel = decodedData.reinLevel
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.exp ~= nil and decodedData.expSpecified ~= false then
        data.exp = decodedData.exp
    end
    if decodedData.createTime ~= nil and decodedData.createTimeSpecified ~= false then
        data.createTime = decodedData.createTime
    end
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.line ~= nil and decodedData.lineSpecified ~= false then
        data.line = decodedData.line
    end
    if decodedData.maxHp ~= nil and decodedData.maxHpSpecified ~= false then
        data.maxHp = decodedData.maxHp
    end
    if decodedData.maxMp ~= nil and decodedData.maxMpSpecified ~= false then
        data.maxMp = decodedData.maxMp
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.maxInnerPower ~= nil and decodedData.maxInnerPowerSpecified ~= false then
        data.maxInnerPower = decodedData.maxInnerPower
    end
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.roleExtraValues ~= nil and decodedData.roleExtraValuesSpecified ~= false then
        data.roleExtraValues = roleV2.RoleExtraValues(decodedData.roleExtraValues)
    end
    if decodedData.activeInfo ~= nil and decodedData.activeInfoSpecified ~= false then
        data.activeInfo = decodeTable.active.ActiveInfo(decodedData.activeInfo)
    end
    if decodedData.roleSettings ~= nil and decodedData.roleSettingsSpecified ~= false then
        for i = 1, #decodedData.roleSettings do
            data.roleSettings:Add(decodedData.roleSettings[i])
        end
    end
    if decodedData.cds ~= nil and decodedData.cdsSpecified ~= false then
        for i = 1, #decodedData.cds do
            data.cds:Add(roleV2.CDBean(decodedData.cds[i]))
        end
    end
    if decodedData.skillShortcut ~= nil and decodedData.skillShortcutSpecified ~= false then
        for i = 1, #decodedData.skillShortcut do
            data.skillShortcut:Add(decodedData.skillShortcut[i])
        end
    end
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.vipLevel ~= nil and decodedData.vipLevelSpecified ~= false then
        data.vipLevel = decodedData.vipLevel
    end
    if decodedData.titleId ~= nil and decodedData.titleIdSpecified ~= false then
        data.titleId = decodedData.titleId
    end
    if decodedData.unionPos ~= nil and decodedData.unionPosSpecified ~= false then
        data.unionPos = decodedData.unionPos
    end
    if decodedData.isSabacUnion ~= nil and decodedData.isSabacUnionSpecified ~= false then
        data.isSabacUnion = decodedData.isSabacUnion
    end
    if decodedData.openServerTime ~= nil and decodedData.openServerTimeSpecified ~= false then
        data.openServerTime = decodedData.openServerTime
    end
    if decodedData.combineServerTime ~= nil and decodedData.combineServerTimeSpecified ~= false then
        data.combineServerTime = decodedData.combineServerTime
    end
    if decodedData.nbValueMax ~= nil and decodedData.nbValueMaxSpecified ~= false then
        data.nbValueMax = decodedData.nbValueMax
    end
    if decodedData.buffers ~= nil and decodedData.buffersSpecified ~= false then
        for i = 1, #decodedData.buffers do
            data.buffers:Add(decodeTable.fight.BufferInfo(decodedData.buffers[i]))
        end
    end
    if decodedData.roleSkillSettings ~= nil and decodedData.roleSkillSettingsSpecified ~= false then
        for i = 1, #decodedData.roleSkillSettings do
            data.roleSkillSettings:Add(decodedData.roleSkillSettings[i])
        end
    end
    if decodedData.thisJunXianId ~= nil and decodedData.thisJunXianIdSpecified ~= false then
        data.thisJunXianId = decodedData.thisJunXianId
    end
    if decodedData.reinExp ~= nil and decodedData.reinExpSpecified ~= false then
        data.reinExp = decodedData.reinExp
    end
    if decodedData.mergeCount ~= nil and decodedData.mergeCountSpecified ~= false then
        data.mergeCount = decodedData.mergeCount
    end
    if decodedData.firstRecharge ~= nil and decodedData.firstRechargeSpecified ~= false then
        data.firstRecharge = decodedData.firstRecharge
    end
    if decodedData.zeroLevel ~= nil and decodedData.zeroLevelSpecified ~= false then
        data.zeroLevel = decodedData.zeroLevel
    end
    if decodedData.zeroRein ~= nil and decodedData.zeroReinSpecified ~= false then
        data.zeroRein = decodedData.zeroRein
    end
    if decodedData.auctionDiamond ~= nil and decodedData.auctionDiamondSpecified ~= false then
        data.auctionDiamond = decodedData.auctionDiamond
    end
    if decodedData.sabacUnionId ~= nil and decodedData.sabacUnionIdSpecified ~= false then
        data.sabacUnionId = decodedData.sabacUnionId
    end
    if decodedData.groupMemberAllowMode ~= nil and decodedData.groupMemberAllowModeSpecified ~= false then
        data.groupMemberAllowMode = decodedData.groupMemberAllowMode
    end
    if decodedData.sabacUnionName ~= nil and decodedData.sabacUnionNameSpecified ~= false then
        data.sabacUnionName = decodedData.sabacUnionName
    end
    if decodedData.monthCard ~= nil and decodedData.monthCardSpecified ~= false then
        for i = 1, #decodedData.monthCard do
            data.monthCard:Add(decodedData.monthCard[i])
        end
    end
    if decodedData.unionRank ~= nil and decodedData.unionRankSpecified ~= false then
        data.unionRank = decodedData.unionRank
    end
    if decodedData.wanLi ~= nil and decodedData.wanLiSpecified ~= false then
        data.wanLi = decodedData.wanLi
    end
    if decodedData.sealMarkId ~= nil and decodedData.sealMarkIdSpecified ~= false then
        data.sealMarkId = decodedData.sealMarkId
    end
    if decodedData.isSabacUniteUnion ~= nil and decodedData.isSabacUniteUnionSpecified ~= false then
        data.isSabacUniteUnion = decodedData.isSabacUniteUnion
    end
    if decodedData.SabacUniteType ~= nil and decodedData.SabacUniteTypeSpecified ~= false then
        data.SabacUniteType = decodedData.SabacUniteType
    end
    if decodedData.vipMember ~= nil and decodedData.vipMemberSpecified ~= false then
        data.vipMember = roleV2.VipMember(decodedData.vipMember)
    end
    if decodedData.rechargeFirst ~= nil and decodedData.rechargeFirstSpecified ~= false then
        data.rechargeFirst = decodedData.rechargeFirst
    end
    if decodedData.rechargeTotal ~= nil and decodedData.rechargeTotalSpecified ~= false then
        data.rechargeTotal = decodedData.rechargeTotal
    end
    if decodedData.automaticCollectCount ~= nil and decodedData.automaticCollectCountSpecified ~= false then
        data.automaticCollectCount = decodedData.automaticCollectCount
    end
    return data
end

---@param decodedData roleV2.GameBasicShareInfo lua中的数据结构
---@return roleV2.GameBasicShareInfo C#中的数据结构
function roleV2.GameBasicShareInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.GameBasicShareInfo()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.shareNum ~= nil and decodedData.shareNumSpecified ~= false then
        data.shareNum = decodedData.shareNum
    end
    if decodedData.willUniteUnionTimeOpen ~= nil and decodedData.willUniteUnionTimeOpenSpecified ~= false then
        data.willUniteUnionTimeOpen = decodedData.willUniteUnionTimeOpen
    end
    if decodedData.willCrossServerGroup ~= nil and decodedData.willCrossServerGroupSpecified ~= false then
        for i = 1, #decodedData.willCrossServerGroup do
            data.willCrossServerGroup:Add(decodedData.willCrossServerGroup[i])
        end
    end
    if decodedData.unionVoteBeginTime ~= nil and decodedData.unionVoteBeginTimeSpecified ~= false then
        data.unionVoteBeginTime = decodedData.unionVoteBeginTime
    end
    if decodedData.unionVoteEndTime ~= nil and decodedData.unionVoteEndTimeSpecified ~= false then
        data.unionVoteEndTime = decodedData.unionVoteEndTime
    end
    if decodedData.enterShare ~= nil and decodedData.enterShareSpecified ~= false then
        data.enterShare = decodedData.enterShare
    end
    if decodedData.voteUnionType ~= nil and decodedData.voteUnionTypeSpecified ~= false then
        data.voteUnionType = decodedData.voteUnionType
    end
    if decodedData.shareOpenTimes ~= nil and decodedData.shareOpenTimesSpecified ~= false then
        for i = 1, #decodedData.shareOpenTimes do
            data.shareOpenTimes:Add(roleV2.ShareOpenTimeInfo(decodedData.shareOpenTimes[i]))
        end
    end
    if decodedData.enterShareNum ~= nil and decodedData.enterShareNumSpecified ~= false then
        data.enterShareNum = decodedData.enterShareNum
    end
    if decodedData.shareOpenTime ~= nil and decodedData.shareOpenTimeSpecified ~= false then
        data.shareOpenTime = decodedData.shareOpenTime
    end
    return data
end

---@param decodedData roleV2.ShareOpenTimeInfo lua中的数据结构
---@return roleV2.ShareOpenTimeInfo C#中的数据结构
function roleV2.ShareOpenTimeInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ShareOpenTimeInfo()
    if decodedData.shareNum ~= nil and decodedData.shareNumSpecified ~= false then
        data.shareNum = decodedData.shareNum
    end
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    if decodedData.shareServers ~= nil and decodedData.shareServersSpecified ~= false then
        data.shareServers = decodedData.shareServers
    end
    return data
end

---@param decodedData roleV2.RoleExtraValues lua中的数据结构
---@return roleV2.RoleExtraValues C#中的数据结构
function roleV2.RoleExtraValues(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.RoleExtraValues()
    if decodedData.freeReliveCount ~= nil and decodedData.freeReliveCountSpecified ~= false then
        data.freeReliveCount = decodedData.freeReliveCount
    end
    if decodedData.nextReliveTime ~= nil and decodedData.nextReliveTimeSpecified ~= false then
        data.nextReliveTime = decodedData.nextReliveTime
    end
    if decodedData.weapon ~= nil and decodedData.weaponSpecified ~= false then
        data.weapon = decodedData.weapon
    end
    if decodedData.clothes ~= nil and decodedData.clothesSpecified ~= false then
        data.clothes = decodedData.clothes
    end
    if decodedData.helmet ~= nil and decodedData.helmetSpecified ~= false then
        data.helmet = decodedData.helmet
    end
    if decodedData.face ~= nil and decodedData.faceSpecified ~= false then
        data.face = decodedData.face
    end
    return data
end

---@param decodedData roleV2.ResPlayerExpChange lua中的数据结构
---@return roleV2.ResPlayerExpChange C#中的数据结构
function roleV2.ResPlayerExpChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResPlayerExpChange()
    data.curExp = decodedData.curExp
    data.logAction = decodedData.logAction
    data.addExp = decodedData.addExp
    data.curInnerPowerExp = decodedData.curInnerPowerExp
    data.addInnerPowerExp = decodedData.addInnerPowerExp
    data.addHsExp = decodedData.addHsExp
    return data
end

---@param decodedData roleV2.ResPlayerLevelChange lua中的数据结构
---@return roleV2.ResPlayerLevelChange C#中的数据结构
function roleV2.ResPlayerLevelChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResPlayerLevelChange()
    data.uid = decodedData.uid
    data.curExp = decodedData.curExp
    data.curLevel = decodedData.curLevel
    if decodedData.levelPower ~= nil and decodedData.levelPowerSpecified ~= false then
        data.levelPower = decodedData.levelPower
    end
    return data
end

---@param decodedData roleV2.ResSendRoleReinInfo lua中的数据结构
---@return roleV2.ResSendRoleReinInfo C#中的数据结构
function roleV2.ResSendRoleReinInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResSendRoleReinInfo()
    data.cfgId = decodedData.cfgId
    if decodedData.reinNum ~= nil and decodedData.reinNumSpecified ~= false then
        data.reinNum = decodedData.reinNum
    end
    if decodedData.fightValue ~= nil and decodedData.fightValueSpecified ~= false then
        data.fightValue = decodedData.fightValue
    end
    if decodedData.exchangeNum ~= nil and decodedData.exchangeNumSpecified ~= false then
        data.exchangeNum = decodedData.exchangeNum
    end
    if decodedData.useNum ~= nil and decodedData.useNumSpecified ~= false then
        for i = 1, #decodedData.useNum do
            data.useNum:Add(roleV2.ReinItemBean(decodedData.useNum[i]))
        end
    end
    if decodedData.reinLevel ~= nil and decodedData.reinLevelSpecified ~= false then
        data.reinLevel = decodedData.reinLevel
    end
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(roleV2.KillBossInfo(decodedData.info[i]))
        end
    end
    return data
end

---@param decodedData roleV2.KillBossInfo lua中的数据结构
---@return roleV2.KillBossInfo C#中的数据结构
function roleV2.KillBossInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.KillBossInfo()
    if decodedData.conditionId ~= nil and decodedData.conditionIdSpecified ~= false then
        data.conditionId = decodedData.conditionId
    end
    if decodedData.killMonsterCount ~= nil and decodedData.killMonsterCountSpecified ~= false then
        data.killMonsterCount = decodedData.killMonsterCount
    end
    return data
end

---@param decodedData roleV2.ResRoleReinSuccess lua中的数据结构
---@return roleV2.ResRoleReinSuccess C#中的数据结构
function roleV2.ResRoleReinSuccess(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResRoleReinSuccess()
    return data
end

---@param decodedData roleV2.ResRoleExchangeReinResult lua中的数据结构
---@return roleV2.ResRoleExchangeReinResult C#中的数据结构
function roleV2.ResRoleExchangeReinResult(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResRoleExchangeReinResult()
    data.reinNum = decodedData.reinNum
    data.exchangeNum = decodedData.exchangeNum
    data.roleLevel = decodedData.roleLevel
    data.exchange = decodedData.exchange
    return data
end

---@param decodedData roleV2.ResTotalFightValueChange lua中的数据结构
---@return roleV2.ResTotalFightValueChange C#中的数据结构
function roleV2.ResTotalFightValueChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResTotalFightValueChange()
    data.totalFightValue = decodedData.totalFightValue
    return data
end

---@param decodedData roleV2.ResPetList lua中的数据结构
---@return roleV2.ResPetList C#中的数据结构
function roleV2.ResPetList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResPetList()
    if decodedData.petBean ~= nil and decodedData.petBeanSpecified ~= false then
        for i = 1, #decodedData.petBean do
            data.petBean:Add(roleV2.PetBean(decodedData.petBean[i]))
        end
    end
    return data
end

---@param decodedData roleV2.ResCreatePet lua中的数据结构
---@return roleV2.ResCreatePet C#中的数据结构
function roleV2.ResCreatePet(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResCreatePet()
    data.petId = decodedData.petId
    data.type = decodedData.type
    return data
end

---@param decodedData roleV2.ChangeRoleDieStateRequest lua中的数据结构
---@return roleV2.ChangeRoleDieStateRequest C#中的数据结构
function roleV2.ChangeRoleDieStateRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ChangeRoleDieStateRequest()
    data.type = decodedData.type
    return data
end

---@param decodedData roleV2.RoleSettingRequest lua中的数据结构
---@return roleV2.RoleSettingRequest C#中的数据结构
function roleV2.RoleSettingRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.RoleSettingRequest()
    data.id = decodedData.id
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.roleSettingValue ~= nil and decodedData.roleSettingValueSpecified ~= false then
        data.roleSettingValue = decodedData.roleSettingValue
    end
    return data
end

---@param decodedData roleV2.ResRoleSettingChange lua中的数据结构
---@return roleV2.ResRoleSettingChange C#中的数据结构
function roleV2.ResRoleSettingChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResRoleSettingChange()
    data.roleSettingBean = roleV2.RoleSettingBean(decodedData.roleSettingBean)
    return data
end

---@param decodedData roleV2.ResRoleSettingInfo lua中的数据结构
---@return roleV2.ResRoleSettingInfo C#中的数据结构
function roleV2.ResRoleSettingInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResRoleSettingInfo()
    if decodedData.roleSettingBean ~= nil and decodedData.roleSettingBeanSpecified ~= false then
        for i = 1, #decodedData.roleSettingBean do
            data.roleSettingBean:Add(roleV2.RoleSettingBean(decodedData.roleSettingBean[i]))
        end
    end
    return data
end

---@param decodedData roleV2.ResSendRoleVeinInfo lua中的数据结构
---@return roleV2.ResSendRoleVeinInfo C#中的数据结构
function roleV2.ResSendRoleVeinInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResSendRoleVeinInfo()
    data.roleVein = roleV2.VeinBean(decodedData.roleVein)
    return data
end

---@param decodedData roleV2.ResSendInnerPowerInfo lua中的数据结构
---@return roleV2.ResSendInnerPowerInfo C#中的数据结构
function roleV2.ResSendInnerPowerInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResSendInnerPowerInfo()
    data.powerBeans = roleV2.InnerPowerInfoBean(decodedData.powerBeans)
    return data
end

---@param decodedData roleV2.ResInnerPowerInfoChange lua中的数据结构
---@return roleV2.ResInnerPowerInfoChange C#中的数据结构
function roleV2.ResInnerPowerInfoChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResInnerPowerInfoChange()
    data.changeBean = roleV2.InnerPowerInfoBean(decodedData.changeBean)
    return data
end

---@param decodedData roleV2.HandyKeySettingRequest lua中的数据结构
---@return roleV2.HandyKeySettingRequest C#中的数据结构
function roleV2.HandyKeySettingRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.HandyKeySettingRequest()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.num ~= nil and decodedData.numSpecified ~= false then
        data.num = decodedData.num
    end
    return data
end

---@param decodedData roleV2.ExchangeHandyKeyRequest lua中的数据结构
---@return roleV2.ExchangeHandyKeyRequest C#中的数据结构
function roleV2.ExchangeHandyKeyRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ExchangeHandyKeyRequest()
    data.leftIndex = decodedData.leftIndex
    data.rightIndex = decodedData.rightIndex
    return data
end

---@param decodedData roleV2.ResHandyKeySettingInfos lua中的数据结构
---@return roleV2.ResHandyKeySettingInfos C#中的数据结构
function roleV2.ResHandyKeySettingInfos(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResHandyKeySettingInfos()
    if decodedData.list ~= nil and decodedData.listSpecified ~= false then
        for i = 1, #decodedData.list do
            data.list:Add(roleV2.HandyKeyBean(decodedData.list[i]))
        end
    end
    return data
end

---@param decodedData roleV2.GetRoleInfo lua中的数据结构
---@return roleV2.GetRoleInfo C#中的数据结构
function roleV2.GetRoleInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.GetRoleInfo()
    data.targetId = decodedData.targetId
    return data
end

---@param decodedData roleV2.SaveRoleSettingsMsg lua中的数据结构
---@return roleV2.SaveRoleSettingsMsg C#中的数据结构
function roleV2.SaveRoleSettingsMsg(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.SaveRoleSettingsMsg()
    if decodedData.roleSettings ~= nil and decodedData.roleSettingsSpecified ~= false then
        for i = 1, #decodedData.roleSettings do
            data.roleSettings:Add(decodedData.roleSettings[i])
        end
    end
    return data
end

---@param decodedData roleV2.SaveRoleSkillSettingsMsg lua中的数据结构
---@return roleV2.SaveRoleSkillSettingsMsg C#中的数据结构
function roleV2.SaveRoleSkillSettingsMsg(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.SaveRoleSkillSettingsMsg()
    if decodedData.skillId ~= nil and decodedData.skillIdSpecified ~= false then
        for i = 1, #decodedData.skillId do
            data.skillId:Add(decodedData.skillId[i])
        end
    end
    return data
end

---@param decodedData roleV2.CDBean lua中的数据结构
---@return roleV2.CDBean C#中的数据结构
function roleV2.CDBean(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.CDBean()
    data.type = decodedData.type
    data.key = decodedData.key
    data.endTime = decodedData.endTime
    return data
end

---@param decodedData roleV2.EditName lua中的数据结构
---@return roleV2.EditName C#中的数据结构
function roleV2.EditName(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.EditName()
    data.name = decodedData.name
    data.type = decodedData.type
    return data
end

---@param decodedData roleV2.ResEditName lua中的数据结构
---@return roleV2.ResEditName C#中的数据结构
function roleV2.ResEditName(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResEditName()
    if decodedData.isSuccess ~= nil and decodedData.isSuccessSpecified ~= false then
        data.isSuccess = decodedData.isSuccess
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.reason ~= nil and decodedData.reasonSpecified ~= false then
        data.reason = decodedData.reason
    end
    return data
end

---@param decodedData roleV2.SystemOpenReminder lua中的数据结构
---@return roleV2.SystemOpenReminder C#中的数据结构
function roleV2.SystemOpenReminder(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.SystemOpenReminder()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.configId ~= nil and decodedData.configIdSpecified ~= false then
        data.configId = decodedData.configId
    end
    if decodedData.levelDiffer ~= nil and decodedData.levelDifferSpecified ~= false then
        data.levelDiffer = decodedData.levelDiffer
    end
    if decodedData.yiKaiQi ~= nil and decodedData.yiKaiQiSpecified ~= false then
        for i = 1, #decodedData.yiKaiQi do
            data.yiKaiQi:Add(decodedData.yiKaiQi[i])
        end
    end
    return data
end

---@param decodedData roleV2.ResBubbleOnlineExp lua中的数据结构
---@return roleV2.ResBubbleOnlineExp C#中的数据结构
function roleV2.ResBubbleOnlineExp(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResBubbleOnlineExp()
    if decodedData.exp ~= nil and decodedData.expSpecified ~= false then
        data.exp = decodedData.exp
    end
    if decodedData.bubbleTime ~= nil and decodedData.bubbleTimeSpecified ~= false then
        data.bubbleTime = decodedData.bubbleTime
    end
    if decodedData.totalTime ~= nil and decodedData.totalTimeSpecified ~= false then
        data.totalTime = decodedData.totalTime
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    if decodedData.servantExp ~= nil and decodedData.servantExpSpecified ~= false then
        data.servantExp = decodedData.servantExp
    end
    return data
end

---@param decodedData roleV2.BubbleOfflineExp lua中的数据结构
---@return roleV2.BubbleOfflineExp C#中的数据结构
function roleV2.BubbleOfflineExp(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.BubbleOfflineExp()
    if decodedData.exp ~= nil and decodedData.expSpecified ~= false then
        data.exp = decodedData.exp
    end
    if decodedData.vipExp ~= nil and decodedData.vipExpSpecified ~= false then
        data.vipExp = decodedData.vipExp
    end
    if decodedData.developExp ~= nil and decodedData.developExpSpecified ~= false then
        data.developExp = decodedData.developExp
    end
    if decodedData.offlineTime ~= nil and decodedData.offlineTimeSpecified ~= false then
        data.offlineTime = decodedData.offlineTime
    end
    if decodedData.vipPercent ~= nil and decodedData.vipPercentSpecified ~= false then
        data.vipPercent = decodedData.vipPercent
    end
    return data
end

---@param decodedData roleV2.AutoOperate lua中的数据结构
---@return roleV2.AutoOperate C#中的数据结构
function roleV2.AutoOperate(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.AutoOperate()
    if decodedData.autoFind ~= nil and decodedData.autoFindSpecified ~= false then
        data.autoFind = decodedData.autoFind
    end
    if decodedData.autoFight ~= nil and decodedData.autoFightSpecified ~= false then
        data.autoFight = decodedData.autoFight
    end
    return data
end

---@param decodedData roleV2.ResRefreshInfo lua中的数据结构
---@return roleV2.ResRefreshInfo C#中的数据结构
function roleV2.ResRefreshInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResRefreshInfo()
    if decodedData.activeInfo ~= nil and decodedData.activeInfoSpecified ~= false then
        data.activeInfo = decodeTable.active.ActiveInfo(decodedData.activeInfo)
    end
    return data
end

---@param decodedData roleV2.ResGetMinerInfo lua中的数据结构
---@return roleV2.ResGetMinerInfo C#中的数据结构
function roleV2.ResGetMinerInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResGetMinerInfo()
    if decodedData.miner ~= nil and decodedData.minerSpecified ~= false then
        for i = 1, #decodedData.miner do
            data.miner:Add(roleV2.MinerInfo(decodedData.miner[i]))
        end
    end
    if decodedData.mine ~= nil and decodedData.mineSpecified ~= false then
        for i = 1, #decodedData.mine do
            data.mine:Add(roleV2.MineInfo(decodedData.mine[i]))
        end
    end
    return data
end

---@param decodedData roleV2.MinerInfo lua中的数据结构
---@return roleV2.MinerInfo C#中的数据结构
function roleV2.MinerInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.MinerInfo()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.activityType ~= nil and decodedData.activityTypeSpecified ~= false then
        data.activityType = decodedData.activityType
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.point ~= nil and decodedData.pointSpecified ~= false then
        data.point = decodedData.point
    end
    return data
end

---@param decodedData roleV2.MineInfo lua中的数据结构
---@return roleV2.MineInfo C#中的数据结构
function roleV2.MineInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.MineInfo()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData roleV2.ResUpdateMineInfo lua中的数据结构
---@return roleV2.ResUpdateMineInfo C#中的数据结构
function roleV2.ResUpdateMineInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResUpdateMineInfo()
    if decodedData.mine ~= nil and decodedData.mineSpecified ~= false then
        for i = 1, #decodedData.mine do
            data.mine:Add(roleV2.MineInfo(decodedData.mine[i]))
        end
    end
    return data
end

---@param decodedData roleV2.ReqHireMiner lua中的数据结构
---@return roleV2.ReqHireMiner C#中的数据结构
function roleV2.ReqHireMiner(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ReqHireMiner()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    return data
end

---@param decodedData roleV2.ResPlayerSpyInfo lua中的数据结构
---@return roleV2.ResPlayerSpyInfo C#中的数据结构
function roleV2.ResPlayerSpyInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResPlayerSpyInfo()
    if decodedData.isSpy ~= nil and decodedData.isSpySpecified ~= false then
        data.isSpy = decodedData.isSpy
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.wing ~= nil and decodedData.wingSpecified ~= false then
        data.wing = decodedData.wing
    end
    if decodedData.titleId ~= nil and decodedData.titleIdSpecified ~= false then
        data.titleId = decodedData.titleId
    end
    if decodedData.thisJunXianId ~= nil and decodedData.thisJunXianIdSpecified ~= false then
        data.thisJunXianId = decodedData.thisJunXianId
    end
    if decodedData.appellation ~= nil and decodedData.appellationSpecified ~= false then
        data.appellation = decodeTable.appearance.TitleInfo(decodedData.appellation)
    end
    if decodedData.wearInfo ~= nil and decodedData.wearInfoSpecified ~= false then
        for i = 1, #decodedData.wearInfo do
            data.wearInfo:Add(decodeTable.appearance.wearPosition(decodedData.wearInfo[i]))
        end
    end
    if decodedData.extraValues ~= nil and decodedData.extraValuesSpecified ~= false then
        data.extraValues = roleV2.RoleExtraValues(decodedData.extraValues)
    end
    if decodedData.remainTime ~= nil and decodedData.remainTimeSpecified ~= false then
        data.remainTime = decodedData.remainTime
    end
    return data
end

---@param decodedData roleV2.ReqSaveSecretaryInfo lua中的数据结构
---@return roleV2.ReqSaveSecretaryInfo C#中的数据结构
function roleV2.ReqSaveSecretaryInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ReqSaveSecretaryInfo()
    if decodedData.secretaryType ~= nil and decodedData.secretaryTypeSpecified ~= false then
        data.secretaryType = decodedData.secretaryType
    end
    if decodedData.problem ~= nil and decodedData.problemSpecified ~= false then
        data.problem = decodedData.problem
    end
    if decodedData.answerType ~= nil and decodedData.answerTypeSpecified ~= false then
        data.answerType = decodedData.answerType
    end
    if decodedData.solution ~= nil and decodedData.solutionSpecified ~= false then
        data.solution = decodedData.solution
    end
    if decodedData.answerId ~= nil and decodedData.answerIdSpecified ~= false then
        data.answerId = decodedData.answerId
    end
    if decodedData.submissionProblem ~= nil and decodedData.submissionProblemSpecified ~= false then
        data.submissionProblem = decodedData.submissionProblem
    end
    if decodedData.compulsoryProblem ~= nil and decodedData.compulsoryProblemSpecified ~= false then
        data.compulsoryProblem = decodedData.compulsoryProblem
    end
    if decodedData.wrongCompulsoryProblem ~= nil and decodedData.wrongCompulsoryProblemSpecified ~= false then
        data.wrongCompulsoryProblem = decodedData.wrongCompulsoryProblem
    end
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.saveOrUpdate ~= nil and decodedData.saveOrUpdateSpecified ~= false then
        data.saveOrUpdate = decodedData.saveOrUpdate
    end
    return data
end

---@param decodedData roleV2.ResSeeSecretaryInfo lua中的数据结构
---@return roleV2.ResSeeSecretaryInfo C#中的数据结构
function roleV2.ResSeeSecretaryInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResSeeSecretaryInfo()
    if decodedData.secretaryInfo ~= nil and decodedData.secretaryInfoSpecified ~= false then
        for i = 1, #decodedData.secretaryInfo do
            data.secretaryInfo:Add(roleV2.Secretary(decodedData.secretaryInfo[i]))
        end
    end
    return data
end

---@param decodedData roleV2.ResBackSecretaryInfo lua中的数据结构
---@return roleV2.ResBackSecretaryInfo C#中的数据结构
function roleV2.ResBackSecretaryInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResBackSecretaryInfo()
    if decodedData.secretaryInfo ~= nil and decodedData.secretaryInfoSpecified ~= false then
        data.secretaryInfo = roleV2.Secretary(decodedData.secretaryInfo)
    end
    return data
end

---@param decodedData roleV2.Secretary lua中的数据结构
---@return roleV2.Secretary C#中的数据结构
function roleV2.Secretary(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.Secretary()
    if decodedData.secretaryType ~= nil and decodedData.secretaryTypeSpecified ~= false then
        data.secretaryType = decodedData.secretaryType
    end
    if decodedData.problem ~= nil and decodedData.problemSpecified ~= false then
        data.problem = decodedData.problem
    end
    if decodedData.answerType ~= nil and decodedData.answerTypeSpecified ~= false then
        data.answerType = decodedData.answerType
    end
    if decodedData.solution ~= nil and decodedData.solutionSpecified ~= false then
        data.solution = decodedData.solution
    end
    if decodedData.answerId ~= nil and decodedData.answerIdSpecified ~= false then
        data.answerId = decodedData.answerId
    end
    if decodedData.submissionProblem ~= nil and decodedData.submissionProblemSpecified ~= false then
        data.submissionProblem = decodedData.submissionProblem
    end
    if decodedData.compulsoryProblem ~= nil and decodedData.compulsoryProblemSpecified ~= false then
        data.compulsoryProblem = decodedData.compulsoryProblem
    end
    if decodedData.wrongCompulsoryProblem ~= nil and decodedData.wrongCompulsoryProblemSpecified ~= false then
        data.wrongCompulsoryProblem = decodedData.wrongCompulsoryProblem
    end
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    if decodedData.createTime ~= nil and decodedData.createTimeSpecified ~= false then
        data.createTime = decodedData.createTime
    end
    return data
end

---@param decodedData roleV2.ReqDeleteSecretaryInfo lua中的数据结构
---@return roleV2.ReqDeleteSecretaryInfo C#中的数据结构
function roleV2.ReqDeleteSecretaryInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ReqDeleteSecretaryInfo()
    if decodedData.lid ~= nil and decodedData.lidSpecified ~= false then
        data.lid = decodedData.lid
    end
    return data
end

---@param decodedData roleV2.ResSecretaryPush lua中的数据结构
---@return roleV2.ResSecretaryPush C#中的数据结构
function roleV2.ResSecretaryPush(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResSecretaryPush()
    if decodedData.pushId ~= nil and decodedData.pushIdSpecified ~= false then
        data.pushId = decodedData.pushId
    end
    return data
end

---@param decodedData roleV2.ResRoleFirstRechargeChange lua中的数据结构
---@return roleV2.ResRoleFirstRechargeChange C#中的数据结构
function roleV2.ResRoleFirstRechargeChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResRoleFirstRechargeChange()
    if decodedData.firstRecharge ~= nil and decodedData.firstRechargeSpecified ~= false then
        data.firstRecharge = decodedData.firstRecharge
    end
    return data
end

---@param decodedData roleV2.ReqCheckPreTaskIsComplete lua中的数据结构
---@return roleV2.ReqCheckPreTaskIsComplete C#中的数据结构
function roleV2.ReqCheckPreTaskIsComplete(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ReqCheckPreTaskIsComplete()
    if decodedData.taskId ~= nil and decodedData.taskIdSpecified ~= false then
        data.taskId = decodedData.taskId
    end
    if decodedData.tableId ~= nil and decodedData.tableIdSpecified ~= false then
        data.tableId = decodedData.tableId
    end
    return data
end

---@param decodedData roleV2.ResCheckPreTaskIsComplete lua中的数据结构
---@return roleV2.ResCheckPreTaskIsComplete C#中的数据结构
function roleV2.ResCheckPreTaskIsComplete(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResCheckPreTaskIsComplete()
    if decodedData.isComplete ~= nil and decodedData.isCompleteSpecified ~= false then
        data.isComplete = decodedData.isComplete
    end
    if decodedData.tableId ~= nil and decodedData.tableIdSpecified ~= false then
        data.tableId = decodedData.tableId
    end
    return data
end

---@param decodedData roleV2.ReqMainTaskPush lua中的数据结构
---@return roleV2.ReqMainTaskPush C#中的数据结构
function roleV2.ReqMainTaskPush(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ReqMainTaskPush()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.taskId ~= nil and decodedData.taskIdSpecified ~= false then
        data.taskId = decodedData.taskId
    end
    return data
end

---@param decodedData roleV2.ResMainTaskPush lua中的数据结构
---@return roleV2.ResMainTaskPush C#中的数据结构
function roleV2.ResMainTaskPush(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResMainTaskPush()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.taskId ~= nil and decodedData.taskIdSpecified ~= false then
        data.taskId = decodedData.taskId
    end
    if decodedData.send ~= nil and decodedData.sendSpecified ~= false then
        data.send = decodedData.send
    end
    return data
end

---@param decodedData roleV2.ReqRefineMasterPanel lua中的数据结构
---@return roleV2.ReqRefineMasterPanel C#中的数据结构
function roleV2.ReqRefineMasterPanel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ReqRefineMasterPanel()
    data.type = decodedData.type
    return data
end

---@param decodedData roleV2.ResRefineMasterPanel lua中的数据结构
---@return roleV2.ResRefineMasterPanel C#中的数据结构
function roleV2.ResRefineMasterPanel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResRefineMasterPanel()
    if decodedData.cfgId ~= nil and decodedData.cfgIdSpecified ~= false then
        data.cfgId = decodedData.cfgId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData roleV2.ReqRefine lua中的数据结构
---@return roleV2.ReqRefine C#中的数据结构
function roleV2.ReqRefine(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ReqRefine()
    data.type = decodedData.type
    if decodedData.servantType ~= nil and decodedData.servantTypeSpecified ~= false then
        data.servantType = decodedData.servantType
    end
    if decodedData.times ~= nil and decodedData.timesSpecified ~= false then
        data.times = decodedData.times
    end
    return data
end

---@param decodedData roleV2.ResRefineMasterRedDot lua中的数据结构
---@return roleV2.ResRefineMasterRedDot C#中的数据结构
function roleV2.ResRefineMasterRedDot(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResRefineMasterRedDot()
    if decodedData.reinExp ~= nil and decodedData.reinExpSpecified ~= false then
        data.reinExp = decodedData.reinExp
    end
    if decodedData.feats ~= nil and decodedData.featsSpecified ~= false then
        data.feats = decodedData.feats
    end
    if decodedData.servantReinExp ~= nil and decodedData.servantReinExpSpecified ~= false then
        data.servantReinExp = decodedData.servantReinExp
    end
    return data
end

---@param decodedData roleV2.ResRefineResult lua中的数据结构
---@return roleV2.ResRefineResult C#中的数据结构
function roleV2.ResRefineResult(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResRefineResult()
    if decodedData.isSuccess ~= nil and decodedData.isSuccessSpecified ~= false then
        data.isSuccess = decodedData.isSuccess
    end
    if decodedData.reason ~= nil and decodedData.reasonSpecified ~= false then
        data.reason = decodedData.reason
    end
    if decodedData.gain ~= nil and decodedData.gainSpecified ~= false then
        data.gain = decodedData.gain
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData roleV2.UpdateAuctionDiamond lua中的数据结构
---@return roleV2.UpdateAuctionDiamond C#中的数据结构
function roleV2.UpdateAuctionDiamond(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.UpdateAuctionDiamond()
    if decodedData.auctionDiamond ~= nil and decodedData.auctionDiamondSpecified ~= false then
        data.auctionDiamond = decodedData.auctionDiamond
    end
    return data
end

---@param decodedData roleV2.ReqSendQuestionInfo lua中的数据结构
---@return roleV2.ReqSendQuestionInfo C#中的数据结构
function roleV2.ReqSendQuestionInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ReqSendQuestionInfo()
    if decodedData.content ~= nil and decodedData.contentSpecified ~= false then
        data.content = decodedData.content
    end
    return data
end

---@param decodedData roleV2.ResPlayerDieDropEquipByWear lua中的数据结构
---@return roleV2.ResPlayerDieDropEquipByWear C#中的数据结构
function roleV2.ResPlayerDieDropEquipByWear(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResPlayerDieDropEquipByWear()
    if decodedData.dropType ~= nil and decodedData.dropTypeSpecified ~= false then
        data.dropType = decodedData.dropType
    end
    if decodedData.itemLid ~= nil and decodedData.itemLidSpecified ~= false then
        data.itemLid = decodedData.itemLid
    end
    return data
end

---@param decodedData roleV2.ReqPaperCraneDelivery lua中的数据结构
---@return roleV2.ReqPaperCraneDelivery C#中的数据结构
function roleV2.ReqPaperCraneDelivery(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ReqPaperCraneDelivery()
    if decodedData.mapId ~= nil and decodedData.mapIdSpecified ~= false then
        data.mapId = decodedData.mapId
    end
    if decodedData.x ~= nil and decodedData.xSpecified ~= false then
        data.x = decodedData.x
    end
    if decodedData.y ~= nil and decodedData.ySpecified ~= false then
        data.y = decodedData.y
    end
    if decodedData.line ~= nil and decodedData.lineSpecified ~= false then
        data.line = decodedData.line
    end
    return data
end

---@param decodedData roleV2.ResPaperCraneDelivery lua中的数据结构
---@return roleV2.ResPaperCraneDelivery C#中的数据结构
function roleV2.ResPaperCraneDelivery(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResPaperCraneDelivery()
    if decodedData.isSuccess ~= nil and decodedData.isSuccessSpecified ~= false then
        data.isSuccess = decodedData.isSuccess
    end
    return data
end

---@param decodedData roleV2.ResNewFirstChargePush lua中的数据结构
---@return roleV2.ResNewFirstChargePush C#中的数据结构
function roleV2.ResNewFirstChargePush(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResNewFirstChargePush()
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    return data
end

---@param decodedData roleV2.ResNeedPrompt lua中的数据结构
---@return roleV2.ResNeedPrompt C#中的数据结构
function roleV2.ResNeedPrompt(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResNeedPrompt()
    if decodedData.needPromptList ~= nil and decodedData.needPromptListSpecified ~= false then
        for i = 1, #decodedData.needPromptList do
            data.needPromptList:Add(decodedData.needPromptList[i])
        end
    end
    return data
end

---@param decodedData roleV2.ResRoleRefreshWanLi lua中的数据结构
---@return roleV2.ResRoleRefreshWanLi C#中的数据结构
function roleV2.ResRoleRefreshWanLi(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResRoleRefreshWanLi()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.wanLi ~= nil and decodedData.wanLiSpecified ~= false then
        data.wanLi = decodedData.wanLi
    end
    return data
end

---@param decodedData roleV2.RoleAddFakeBuff lua中的数据结构
---@return roleV2.RoleAddFakeBuff C#中的数据结构
function roleV2.RoleAddFakeBuff(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.RoleAddFakeBuff()
    if decodedData.buffers ~= nil and decodedData.buffersSpecified ~= false then
        data.buffers = decodeTable.fight.BufferInfo(decodedData.buffers)
    end
    if decodedData.addOrRemove ~= nil and decodedData.addOrRemoveSpecified ~= false then
        data.addOrRemove = decodedData.addOrRemove
    end
    return data
end

---@param decodedData roleV2.ResRoleTame lua中的数据结构
---@return roleV2.ResRoleTame C#中的数据结构
function roleV2.ResRoleTame(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResRoleTame()
    if decodedData.goldTameCount ~= nil and decodedData.goldTameCountSpecified ~= false then
        data.goldTameCount = decodedData.goldTameCount
    end
    if decodedData.diamondTameCount ~= nil and decodedData.diamondTameCountSpecified ~= false then
        data.diamondTameCount = decodedData.diamondTameCount
    end
    return data
end

---@param decodedData roleV2.ResTitleTianfu lua中的数据结构
---@return roleV2.ResTitleTianfu C#中的数据结构
function roleV2.ResTitleTianfu(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResTitleTianfu()
    if decodedData.zhanAddPoint ~= nil and decodedData.zhanAddPointSpecified ~= false then
        data.zhanAddPoint = decodedData.zhanAddPoint
    end
    if decodedData.zhanReducePoint ~= nil and decodedData.zhanReducePointSpecified ~= false then
        data.zhanReducePoint = decodedData.zhanReducePoint
    end
    if decodedData.faAddPoint ~= nil and decodedData.faAddPointSpecified ~= false then
        data.faAddPoint = decodedData.faAddPoint
    end
    if decodedData.faReducePoint ~= nil and decodedData.faReducePointSpecified ~= false then
        data.faReducePoint = decodedData.faReducePoint
    end
    if decodedData.daoAddPoint ~= nil and decodedData.daoAddPointSpecified ~= false then
        data.daoAddPoint = decodedData.daoAddPoint
    end
    if decodedData.daoReducePoint ~= nil and decodedData.daoReducePointSpecified ~= false then
        data.daoReducePoint = decodedData.daoReducePoint
    end
    if decodedData.available ~= nil and decodedData.availableSpecified ~= false then
        data.available = decodedData.available
    end
    return data
end

---@param decodedData roleV2.ReqSaveTitleTianfu lua中的数据结构
---@return roleV2.ReqSaveTitleTianfu C#中的数据结构
function roleV2.ReqSaveTitleTianfu(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ReqSaveTitleTianfu()
    if decodedData.zhanAddPoint ~= nil and decodedData.zhanAddPointSpecified ~= false then
        data.zhanAddPoint = decodedData.zhanAddPoint
    end
    if decodedData.zhanReducePoint ~= nil and decodedData.zhanReducePointSpecified ~= false then
        data.zhanReducePoint = decodedData.zhanReducePoint
    end
    if decodedData.faAddPoint ~= nil and decodedData.faAddPointSpecified ~= false then
        data.faAddPoint = decodedData.faAddPoint
    end
    if decodedData.faReducePoint ~= nil and decodedData.faReducePointSpecified ~= false then
        data.faReducePoint = decodedData.faReducePoint
    end
    if decodedData.daoAddPoint ~= nil and decodedData.daoAddPointSpecified ~= false then
        data.daoAddPoint = decodedData.daoAddPoint
    end
    if decodedData.daoReducePoint ~= nil and decodedData.daoReducePointSpecified ~= false then
        data.daoReducePoint = decodedData.daoReducePoint
    end
    return data
end

---@param decodedData roleV2.ResKongFuHouseTimeLimit lua中的数据结构
---@return roleV2.ResKongFuHouseTimeLimit C#中的数据结构
function roleV2.ResKongFuHouseTimeLimit(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResKongFuHouseTimeLimit()
    if decodedData.times ~= nil and decodedData.timesSpecified ~= false then
        for i = 1, #decodedData.times do
            data.times:Add(decodedData.times[i])
        end
    end
    return data
end

---@param decodedData roleV2.potentialInfo lua中的数据结构
---@return roleV2.potentialInfo C#中的数据结构
function roleV2.potentialInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.potentialInfo()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.star ~= nil and decodedData.starSpecified ~= false then
        data.star = decodedData.star
    end
    if decodedData.isOpen ~= nil and decodedData.isOpenSpecified ~= false then
        data.isOpen = decodedData.isOpen
    end
    return data
end

---@param decodedData roleV2.RespotentialInfo lua中的数据结构
---@return roleV2.RespotentialInfo C#中的数据结构
function roleV2.RespotentialInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.RespotentialInfo()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(roleV2.potentialInfo(decodedData.info[i]))
        end
    end
    return data
end

---@param decodedData roleV2.ResPotentialRedPoint lua中的数据结构
---@return roleV2.ResPotentialRedPoint C#中的数据结构
function roleV2.ResPotentialRedPoint(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResPotentialRedPoint()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData roleV2.ReqActivePotential lua中的数据结构
---@return roleV2.ReqActivePotential C#中的数据结构
function roleV2.ReqActivePotential(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ReqActivePotential()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData roleV2.ReqUpgradePotential lua中的数据结构
---@return roleV2.ReqUpgradePotential C#中的数据结构
function roleV2.ReqUpgradePotential(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ReqUpgradePotential()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData roleV2.SettingBean lua中的数据结构
---@return roleV2.SettingBean C#中的数据结构
function roleV2.SettingBean(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.SettingBean()
    data.id = decodedData.id
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData roleV2.CollectionSetting lua中的数据结构
---@return roleV2.CollectionSetting C#中的数据结构
function roleV2.CollectionSetting(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.CollectionSetting()
    if decodedData.setting ~= nil and decodedData.settingSpecified ~= false then
        for i = 1, #decodedData.setting do
            data.setting:Add(roleV2.SettingBean(decodedData.setting[i]))
        end
    end
    return data
end

---@param decodedData roleV2.PickUpSettingBean lua中的数据结构
---@return roleV2.PickUpSettingBean C#中的数据结构
function roleV2.PickUpSettingBean(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.PickUpSettingBean()
    data.id = decodedData.id
    if decodedData.parentId ~= nil and decodedData.parentIdSpecified ~= false then
        data.parentId = decodedData.parentId
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData roleV2.PickUpSetting lua中的数据结构
---@return roleV2.PickUpSetting C#中的数据结构
function roleV2.PickUpSetting(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.PickUpSetting()
    if decodedData.setting ~= nil and decodedData.settingSpecified ~= false then
        for i = 1, #decodedData.setting do
            data.setting:Add(roleV2.PickUpSettingBean(decodedData.setting[i]))
        end
    end
    return data
end

---@param decodedData roleV2.ReqRoleModelInfo lua中的数据结构
---@return roleV2.ReqRoleModelInfo C#中的数据结构
function roleV2.ReqRoleModelInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ReqRoleModelInfo()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    return data
end

---@param decodedData roleV2.RoleModelInfo lua中的数据结构
---@return roleV2.RoleModelInfo C#中的数据结构
function roleV2.RoleModelInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.RoleModelInfo()
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.armor ~= nil and decodedData.armorSpecified ~= false then
        data.armor = decodedData.armor
    end
    if decodedData.weapon ~= nil and decodedData.weaponSpecified ~= false then
        data.weapon = decodedData.weapon
    end
    if decodedData.helmet ~= nil and decodedData.helmetSpecified ~= false then
        data.helmet = decodedData.helmet
    end
    if decodedData.face ~= nil and decodedData.faceSpecified ~= false then
        data.face = decodedData.face
    end
    if decodedData.wearPosition ~= nil and decodedData.wearPositionSpecified ~= false then
        for i = 1, #decodedData.wearPosition do
            data.wearPosition:Add(decodeTable.appearance.wearPosition(decodedData.wearPosition[i]))
        end
    end
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.shield ~= nil and decodedData.shieldSpecified ~= false then
        data.shield = decodedData.shield
    end
    if decodedData.bambooHat ~= nil and decodedData.bambooHatSpecified ~= false then
        data.bambooHat = decodedData.bambooHat
    end
    return data
end

---@param decodedData roleV2.ReqMysteriousExchange lua中的数据结构
---@return roleV2.ReqMysteriousExchange C#中的数据结构
function roleV2.ReqMysteriousExchange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ReqMysteriousExchange()
    if decodedData.changId ~= nil and decodedData.changIdSpecified ~= false then
        data.changId = decodedData.changId
    end
    return data
end

---@param decodedData roleV2.ResMysteriousExchange lua中的数据结构
---@return roleV2.ResMysteriousExchange C#中的数据结构
function roleV2.ResMysteriousExchange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResMysteriousExchange()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(roleV2.MysteriousExchangInfo(decodedData.info[i]))
        end
    end
    return data
end

---@param decodedData roleV2.MysteriousExchangInfo lua中的数据结构
---@return roleV2.MysteriousExchangInfo C#中的数据结构
function roleV2.MysteriousExchangInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.MysteriousExchangInfo()
    if decodedData.changId ~= nil and decodedData.changIdSpecified ~= false then
        data.changId = decodedData.changId
    end
    if decodedData.changeNum ~= nil and decodedData.changeNumSpecified ~= false then
        data.changeNum = decodedData.changeNum
    end
    return data
end

---@param decodedData roleV2.BossKillData lua中的数据结构
---@return roleV2.BossKillData C#中的数据结构
function roleV2.BossKillData(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.BossKillData()
    if decodedData.killDatas ~= nil and decodedData.killDatasSpecified ~= false then
        for i = 1, #decodedData.killDatas do
            data.killDatas:Add(roleV2.BossTypeKillData(decodedData.killDatas[i]))
        end
    end
    return data
end

---@param decodedData roleV2.BossTypeKillData lua中的数据结构
---@return roleV2.BossTypeKillData C#中的数据结构
function roleV2.BossTypeKillData(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.BossTypeKillData()
    data.surTimes = decodedData.surTimes
    data.maxTimes = decodedData.maxTimes
    data.type = decodedData.type
    data.buyTimes = decodedData.buyTimes
    return data
end

---@param decodedData roleV2.ReqAddBossKillTimes lua中的数据结构
---@return roleV2.ReqAddBossKillTimes C#中的数据结构
function roleV2.ReqAddBossKillTimes(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ReqAddBossKillTimes()
    data.type = decodedData.type
    data.addType = decodedData.addType
    return data
end

---@param decodedData roleV2.ResRoleSystemPreview lua中的数据结构
---@return roleV2.ResRoleSystemPreview C#中的数据结构
function roleV2.ResRoleSystemPreview(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResRoleSystemPreview()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(roleV2.SystemPreview(decodedData.info[i]))
        end
    end
    return data
end

---@param decodedData roleV2.SystemPreview lua中的数据结构
---@return roleV2.SystemPreview C#中的数据结构
function roleV2.SystemPreview(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.SystemPreview()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.rewardType ~= nil and decodedData.rewardTypeSpecified ~= false then
        data.rewardType = decodedData.rewardType
    end
    return data
end

---@param decodedData roleV2.ReqRewardSystemPreview lua中的数据结构
---@return roleV2.ReqRewardSystemPreview C#中的数据结构
function roleV2.ReqRewardSystemPreview(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ReqRewardSystemPreview()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData roleV2.ReqAddRoleExpByResources lua中的数据结构
---@return roleV2.ReqAddRoleExpByResources C#中的数据结构
function roleV2.ReqAddRoleExpByResources(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ReqAddRoleExpByResources()
    if decodedData.gear ~= nil and decodedData.gearSpecified ~= false then
        data.gear = decodedData.gear
    end
    return data
end

---@param decodedData roleV2.ResRoleExpAccumulate lua中的数据结构
---@return roleV2.ResRoleExpAccumulate C#中的数据结构
function roleV2.ResRoleExpAccumulate(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResRoleExpAccumulate()
    if decodedData.hasCount ~= nil and decodedData.hasCountSpecified ~= false then
        data.hasCount = decodedData.hasCount
    end
    if decodedData.hasExp ~= nil and decodedData.hasExpSpecified ~= false then
        data.hasExp = decodedData.hasExp
    end
    return data
end

---@param decodedData roleV2.ResRoleInviteCode lua中的数据结构
---@return roleV2.ResRoleInviteCode C#中的数据结构
function roleV2.ResRoleInviteCode(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResRoleInviteCode()
    if decodedData.inviteCode ~= nil and decodedData.inviteCodeSpecified ~= false then
        data.inviteCode = decodedData.inviteCode
    end
    return data
end

---@param decodedData roleV2.ResTransferSex lua中的数据结构
---@return roleV2.ResTransferSex C#中的数据结构
function roleV2.ResTransferSex(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResTransferSex()
    data.sex = decodedData.sex
    return data
end

---@param decodedData roleV2.ReqTransferCareer lua中的数据结构
---@return roleV2.ReqTransferCareer C#中的数据结构
function roleV2.ReqTransferCareer(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ReqTransferCareer()
    data.career = decodedData.career
    return data
end

---@param decodedData roleV2.ResTransferCareer lua中的数据结构
---@return roleV2.ResTransferCareer C#中的数据结构
function roleV2.ResTransferCareer(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.roleV2.ResTransferCareer()
    data.career = decodedData.career
    return data
end

--[[roleV2.ResCanInsuredEquip 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[roleV2.InsuredEquip 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[roleV2.ReqInsuredEquip 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[roleV2.ResInsuredSucces 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return roleV2