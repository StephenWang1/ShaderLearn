--[[本文件为工具自动生成,禁止手动修改]]
local roleV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable roleV2.PetBean
---@type roleV2.PetBean
roleV2_adj.metatable_PetBean = {
    _ClassName = "roleV2.PetBean",
}
roleV2_adj.metatable_PetBean.__index = roleV2_adj.metatable_PetBean
--endregion

---@param tbl roleV2.PetBean 待调整的table数据
function roleV2_adj.AdjustPetBean(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_PetBean)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable roleV2.AttributeInfo
---@type roleV2.AttributeInfo
roleV2_adj.metatable_AttributeInfo = {
    _ClassName = "roleV2.AttributeInfo",
}
roleV2_adj.metatable_AttributeInfo.__index = roleV2_adj.metatable_AttributeInfo
--endregion

---@param tbl roleV2.AttributeInfo 待调整的table数据
function roleV2_adj.AdjustAttributeInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_AttributeInfo)
end

--region metatable roleV2.SpecialRingBean
---@type roleV2.SpecialRingBean
roleV2_adj.metatable_SpecialRingBean = {
    _ClassName = "roleV2.SpecialRingBean",
}
roleV2_adj.metatable_SpecialRingBean.__index = roleV2_adj.metatable_SpecialRingBean
--endregion

---@param tbl roleV2.SpecialRingBean 待调整的table数据
function roleV2_adj.AdjustSpecialRingBean(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_SpecialRingBean)
end

--region metatable roleV2.ReinItemBean
---@type roleV2.ReinItemBean
roleV2_adj.metatable_ReinItemBean = {
    _ClassName = "roleV2.ReinItemBean",
}
roleV2_adj.metatable_ReinItemBean.__index = roleV2_adj.metatable_ReinItemBean
--endregion

---@param tbl roleV2.ReinItemBean 待调整的table数据
function roleV2_adj.AdjustReinItemBean(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ReinItemBean)
    if tbl.useNum == nil then
        tbl.useNumSpecified = false
        tbl.useNum = 0
    else
        tbl.useNumSpecified = true
    end
end

--region metatable roleV2.VeinBean
---@type roleV2.VeinBean
roleV2_adj.metatable_VeinBean = {
    _ClassName = "roleV2.VeinBean",
}
roleV2_adj.metatable_VeinBean.__index = roleV2_adj.metatable_VeinBean
--endregion

---@param tbl roleV2.VeinBean 待调整的table数据
function roleV2_adj.AdjustVeinBean(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_VeinBean)
    if tbl.fightValue == nil then
        tbl.fightValueSpecified = false
        tbl.fightValue = 0
    else
        tbl.fightValueSpecified = true
    end
end

--region metatable roleV2.InnerPowerInfoBean
---@type roleV2.InnerPowerInfoBean
roleV2_adj.metatable_InnerPowerInfoBean = {
    _ClassName = "roleV2.InnerPowerInfoBean",
}
roleV2_adj.metatable_InnerPowerInfoBean.__index = roleV2_adj.metatable_InnerPowerInfoBean
--endregion

---@param tbl roleV2.InnerPowerInfoBean 待调整的table数据
function roleV2_adj.AdjustInnerPowerInfoBean(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_InnerPowerInfoBean)
end

--region metatable roleV2.RoleSettingBean
---@type roleV2.RoleSettingBean
roleV2_adj.metatable_RoleSettingBean = {
    _ClassName = "roleV2.RoleSettingBean",
}
roleV2_adj.metatable_RoleSettingBean.__index = roleV2_adj.metatable_RoleSettingBean
--endregion

---@param tbl roleV2.RoleSettingBean 待调整的table数据
function roleV2_adj.AdjustRoleSettingBean(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_RoleSettingBean)
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = false
    else
        tbl.stateSpecified = true
    end
end

--region metatable roleV2.HandyKeyBean
---@type roleV2.HandyKeyBean
roleV2_adj.metatable_HandyKeyBean = {
    _ClassName = "roleV2.HandyKeyBean",
}
roleV2_adj.metatable_HandyKeyBean.__index = roleV2_adj.metatable_HandyKeyBean
--endregion

---@param tbl roleV2.HandyKeyBean 待调整的table数据
function roleV2_adj.AdjustHandyKeyBean(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_HandyKeyBean)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.param == nil then
        tbl.paramSpecified = false
        tbl.param = 0
    else
        tbl.paramSpecified = true
    end
end

--region metatable roleV2.OtherPlayerCommonInfo
---@type roleV2.OtherPlayerCommonInfo
roleV2_adj.metatable_OtherPlayerCommonInfo = {
    _ClassName = "roleV2.OtherPlayerCommonInfo",
}
roleV2_adj.metatable_OtherPlayerCommonInfo.__index = roleV2_adj.metatable_OtherPlayerCommonInfo
--endregion

---@param tbl roleV2.OtherPlayerCommonInfo 待调整的table数据
function roleV2_adj.AdjustOtherPlayerCommonInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_OtherPlayerCommonInfo)
    if tbl.isFriend == nil then
        tbl.isFriendSpecified = false
        tbl.isFriend = false
    else
        tbl.isFriendSpecified = true
    end
    if tbl.isBlack == nil then
        tbl.isBlackSpecified = false
        tbl.isBlack = false
    else
        tbl.isBlackSpecified = true
    end
end

--region metatable roleV2.RoleToOtherInfo
---@type roleV2.RoleToOtherInfo
roleV2_adj.metatable_RoleToOtherInfo = {
    _ClassName = "roleV2.RoleToOtherInfo",
}
roleV2_adj.metatable_RoleToOtherInfo.__index = roleV2_adj.metatable_RoleToOtherInfo
--endregion

---@param tbl roleV2.RoleToOtherInfo 待调整的table数据
function roleV2_adj.AdjustRoleToOtherInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_RoleToOtherInfo)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.roleName == nil then
        tbl.roleNameSpecified = false
        tbl.roleName = ""
    else
        tbl.roleNameSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.line == nil then
        tbl.lineSpecified = false
        tbl.line = 0
    else
        tbl.lineSpecified = true
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
    if tbl.weapon == nil then
        tbl.weaponSpecified = false
        tbl.weapon = 0
    else
        tbl.weaponSpecified = true
    end
    if tbl.armor == nil then
        tbl.armorSpecified = false
        tbl.armor = 0
    else
        tbl.armorSpecified = true
    end
    if tbl.buffers == nil then
        tbl.buffers = {}
    else
        if adjustTable.fight_adj ~= nil and adjustTable.fight_adj.AdjustBufferInfo ~= nil then
            for i = 1, #tbl.buffers do
                adjustTable.fight_adj.AdjustBufferInfo(tbl.buffers[i])
            end
        end
    end
    if tbl.mp == nil then
        tbl.mpSpecified = false
        tbl.mp = 0
    else
        tbl.mpSpecified = true
    end
    if tbl.maxMp == nil then
        tbl.maxMpSpecified = false
        tbl.maxMp = 0
    else
        tbl.maxMpSpecified = true
    end
    if tbl.vipLevel == nil then
        tbl.vipLevelSpecified = false
        tbl.vipLevel = 0
    else
        tbl.vipLevelSpecified = true
    end
    if tbl.wing == nil then
        tbl.wingSpecified = false
        tbl.wing = 0
    else
        tbl.wingSpecified = true
    end
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
    if tbl.unionPos == nil then
        tbl.unionPosSpecified = false
        tbl.unionPos = 0
    else
        tbl.unionPosSpecified = true
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
    if tbl.equipList == nil then
        tbl.equipList = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
            for i = 1, #tbl.equipList do
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.equipList[i])
            end
        end
    end
    if tbl.helmet == nil then
        tbl.helmetSpecified = false
        tbl.helmet = 0
    else
        tbl.helmetSpecified = true
    end
    if tbl.extraEquipList == nil then
        tbl.extraEquipList = {}
    else
        if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustExtraEquip ~= nil then
            for i = 1, #tbl.extraEquipList do
                adjustTable.bag_adj.AdjustExtraEquip(tbl.extraEquipList[i])
            end
        end
    end
    if tbl.wearPosition == nil then
        tbl.wearPosition = {}
    else
        if adjustTable.appearance_adj ~= nil and adjustTable.appearance_adj.AdjustwearPosition ~= nil then
            for i = 1, #tbl.wearPosition do
                adjustTable.appearance_adj.AdjustwearPosition(tbl.wearPosition[i])
            end
        end
    end
    if tbl.marryInfo == nil then
        tbl.marryInfoSpecified = false
        tbl.marryInfo = nil
    else
        if tbl.marryInfoSpecified == nil then 
            tbl.marryInfoSpecified = true
            if adjustTable.marry_adj ~= nil and adjustTable.marry_adj.AdjustResPlayerMarriageInformation ~= nil then
                adjustTable.marry_adj.AdjustResPlayerMarriageInformation(tbl.marryInfo)
            end
        end
    end
    if tbl.appellation == nil then
        tbl.appellationSpecified = false
        tbl.appellation = ""
    else
        tbl.appellationSpecified = true
    end
    if tbl.attr == nil then
        tbl.attr = {}
    else
        if roleV2_adj.AdjustPlayerAttribute ~= nil then
            for i = 1, #tbl.attr do
                roleV2_adj.AdjustPlayerAttribute(tbl.attr[i])
            end
        end
    end
    if tbl.nbValue == nil then
        tbl.nbValueSpecified = false
        tbl.nbValue = 0
    else
        tbl.nbValueSpecified = true
    end
    if tbl.imprint == nil then
        tbl.imprint = {}
    else
        if adjustTable.imprint_adj ~= nil and adjustTable.imprint_adj.AdjustImprintInfo ~= nil then
            for i = 1, #tbl.imprint do
                adjustTable.imprint_adj.AdjustImprintInfo(tbl.imprint[i])
            end
        end
    end
    if tbl.element == nil then
        tbl.element = {}
    else
        if adjustTable.element_adj ~= nil and adjustTable.element_adj.AdjustElementInfo ~= nil then
            for i = 1, #tbl.element do
                adjustTable.element_adj.AdjustElementInfo(tbl.element[i])
            end
        end
    end
    if tbl.face == nil then
        tbl.faceSpecified = false
        tbl.face = 0
    else
        tbl.faceSpecified = true
    end
    if tbl.monthCard == nil then
        tbl.monthCard = {}
    end
    if tbl.isChairman == nil then
        tbl.isChairmanSpecified = false
        tbl.isChairman = 0
    else
        tbl.isChairmanSpecified = true
    end
    if tbl.hostId == nil then
        tbl.hostIdSpecified = false
        tbl.hostId = 0
    else
        tbl.hostIdSpecified = true
    end
    if tbl.magicWeapon == nil then
        tbl.magicWeaponSpecified = false
        tbl.magicWeapon = nil
    else
        if tbl.magicWeaponSpecified == nil then 
            tbl.magicWeaponSpecified = true
            if adjustTable.equip_adj ~= nil and adjustTable.equip_adj.AdjustAllMagicWeaponInfo ~= nil then
                adjustTable.equip_adj.AdjustAllMagicWeaponInfo(tbl.magicWeapon)
            end
        end
    end
    if tbl.rein == nil then
        tbl.reinSpecified = false
        tbl.rein = 0
    else
        tbl.reinSpecified = true
    end
    if tbl.officialPosistionId == nil then
        tbl.officialPosistionIdSpecified = false
        tbl.officialPosistionId = 0
    else
        tbl.officialPosistionIdSpecified = true
    end
    if tbl.soulEquip == nil then
        tbl.soulEquipSpecified = false
        tbl.soulEquip = nil
    else
        if tbl.soulEquipSpecified == nil then 
            tbl.soulEquipSpecified = true
            if adjustTable.equip_adj ~= nil and adjustTable.equip_adj.AdjustWholeSoulEquips ~= nil then
                adjustTable.equip_adj.AdjustWholeSoulEquips(tbl.soulEquip)
            end
        end
    end
    if tbl.emperorTokenId == nil then
        tbl.emperorTokenIdSpecified = false
        tbl.emperorTokenId = 0
    else
        tbl.emperorTokenIdSpecified = true
    end
    if tbl.cabinetInfo == nil then
        tbl.cabinetInfoSpecified = false
        tbl.cabinetInfo = nil
    else
        if tbl.cabinetInfoSpecified == nil then 
            tbl.cabinetInfoSpecified = true
            if adjustTable.collect_adj ~= nil and adjustTable.collect_adj.AdjustCabinetInfo ~= nil then
                adjustTable.collect_adj.AdjustCabinetInfo(tbl.cabinetInfo)
            end
        end
    end
    if tbl.vipMember == nil then
        tbl.vipMemberSpecified = false
        tbl.vipMember = nil
    else
        if tbl.vipMemberSpecified == nil then 
            tbl.vipMemberSpecified = true
            if roleV2_adj.AdjustVipMember ~= nil then
                roleV2_adj.AdjustVipMember(tbl.vipMember)
            end
        end
    end
    if tbl.sealMarkId == nil then
        tbl.sealMarkIdSpecified = false
        tbl.sealMarkId = 0
    else
        tbl.sealMarkIdSpecified = true
    end
    if tbl.zhenfa == nil then
        tbl.zhenfaSpecified = false
        tbl.zhenfa = nil
    else
        if tbl.zhenfaSpecified == nil then 
            tbl.zhenfaSpecified = true
            if adjustTable.zhenfa_adj ~= nil and adjustTable.zhenfa_adj.AdjustZhenfaInfo ~= nil then
                adjustTable.zhenfa_adj.AdjustZhenfaInfo(tbl.zhenfa)
            end
        end
    end
    if tbl.resRecasts == nil then
        tbl.resRecasts = {}
    else
        if adjustTable.equip_adj ~= nil and adjustTable.equip_adj.AdjustResRecast ~= nil then
            for i = 1, #tbl.resRecasts do
                adjustTable.equip_adj.AdjustResRecast(tbl.resRecasts[i])
            end
        end
    end
    if tbl.shield == nil then
        tbl.shieldSpecified = false
        tbl.shield = 0
    else
        tbl.shieldSpecified = true
    end
    if tbl.bambooHat == nil then
        tbl.bambooHatSpecified = false
        tbl.bambooHat = 0
    else
        tbl.bambooHatSpecified = true
    end
end

--region metatable roleV2.VipMember
---@type roleV2.VipMember
roleV2_adj.metatable_VipMember = {
    _ClassName = "roleV2.VipMember",
}
roleV2_adj.metatable_VipMember.__index = roleV2_adj.metatable_VipMember
--endregion

---@param tbl roleV2.VipMember 待调整的table数据
function roleV2_adj.AdjustVipMember(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_VipMember)
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
end

--region metatable roleV2.PlayerAttribute
---@type roleV2.PlayerAttribute
roleV2_adj.metatable_PlayerAttribute = {
    _ClassName = "roleV2.PlayerAttribute",
}
roleV2_adj.metatable_PlayerAttribute.__index = roleV2_adj.metatable_PlayerAttribute
--endregion

---@param tbl roleV2.PlayerAttribute 待调整的table数据
function roleV2_adj.AdjustPlayerAttribute(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_PlayerAttribute)
end

--region metatable roleV2.ResPlayerAttributeChange
---@type roleV2.ResPlayerAttributeChange
roleV2_adj.metatable_ResPlayerAttributeChange = {
    _ClassName = "roleV2.ResPlayerAttributeChange",
}
roleV2_adj.metatable_ResPlayerAttributeChange.__index = roleV2_adj.metatable_ResPlayerAttributeChange
--endregion

---@param tbl roleV2.ResPlayerAttributeChange 待调整的table数据
function roleV2_adj.AdjustResPlayerAttributeChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResPlayerAttributeChange)
    if tbl.power == nil then
        tbl.powerSpecified = false
        tbl.power = 0
    else
        tbl.powerSpecified = true
    end
    if tbl.attr == nil then
        tbl.attr = {}
    else
        if roleV2_adj.AdjustPlayerAttribute ~= nil then
            for i = 1, #tbl.attr do
                roleV2_adj.AdjustPlayerAttribute(tbl.attr[i])
            end
        end
    end
    if tbl.changeAttr == nil then
        tbl.changeAttr = {}
    else
        if roleV2_adj.AdjustPlayerAttribute ~= nil then
            for i = 1, #tbl.changeAttr do
                roleV2_adj.AdjustPlayerAttribute(tbl.changeAttr[i])
            end
        end
    end
    if tbl.changePower == nil then
        tbl.changePowerSpecified = false
        tbl.changePower = 0
    else
        tbl.changePowerSpecified = true
    end
end

--region metatable roleV2.ResPlayerBasicInfo
---@type roleV2.ResPlayerBasicInfo
roleV2_adj.metatable_ResPlayerBasicInfo = {
    _ClassName = "roleV2.ResPlayerBasicInfo",
}
roleV2_adj.metatable_ResPlayerBasicInfo.__index = roleV2_adj.metatable_ResPlayerBasicInfo
--endregion

---@param tbl roleV2.ResPlayerBasicInfo 待调整的table数据
function roleV2_adj.AdjustResPlayerBasicInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResPlayerBasicInfo)
    if tbl.power == nil then
        tbl.powerSpecified = false
        tbl.power = 0
    else
        tbl.powerSpecified = true
    end
    if tbl.attr == nil then
        tbl.attr = {}
    else
        if roleV2_adj.AdjustPlayerAttribute ~= nil then
            for i = 1, #tbl.attr do
                roleV2_adj.AdjustPlayerAttribute(tbl.attr[i])
            end
        end
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
    if tbl.innerPower == nil then
        tbl.innerPowerSpecified = false
        tbl.innerPower = 0
    else
        tbl.innerPowerSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.reinLevel == nil then
        tbl.reinLevelSpecified = false
        tbl.reinLevel = 0
    else
        tbl.reinLevelSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.exp == nil then
        tbl.expSpecified = false
        tbl.exp = 0
    else
        tbl.expSpecified = true
    end
    if tbl.createTime == nil then
        tbl.createTimeSpecified = false
        tbl.createTime = 0
    else
        tbl.createTimeSpecified = true
    end
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
    end
    if tbl.line == nil then
        tbl.lineSpecified = false
        tbl.line = 0
    else
        tbl.lineSpecified = true
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
    if tbl.maxInnerPower == nil then
        tbl.maxInnerPowerSpecified = false
        tbl.maxInnerPower = 0
    else
        tbl.maxInnerPowerSpecified = true
    end
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
    if tbl.roleExtraValues == nil then
        tbl.roleExtraValuesSpecified = false
        tbl.roleExtraValues = nil
    else
        if tbl.roleExtraValuesSpecified == nil then 
            tbl.roleExtraValuesSpecified = true
            if roleV2_adj.AdjustRoleExtraValues ~= nil then
                roleV2_adj.AdjustRoleExtraValues(tbl.roleExtraValues)
            end
        end
    end
    if tbl.activeInfo == nil then
        tbl.activeInfoSpecified = false
        tbl.activeInfo = nil
    else
        if tbl.activeInfoSpecified == nil then 
            tbl.activeInfoSpecified = true
            if adjustTable.active_adj ~= nil and adjustTable.active_adj.AdjustActiveInfo ~= nil then
                adjustTable.active_adj.AdjustActiveInfo(tbl.activeInfo)
            end
        end
    end
    if tbl.roleSettings == nil then
        tbl.roleSettings = {}
    end
    if tbl.cds == nil then
        tbl.cds = {}
    else
        if roleV2_adj.AdjustCDBean ~= nil then
            for i = 1, #tbl.cds do
                roleV2_adj.AdjustCDBean(tbl.cds[i])
            end
        end
    end
    if tbl.skillShortcut == nil then
        tbl.skillShortcut = {}
    end
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
    if tbl.vipLevel == nil then
        tbl.vipLevelSpecified = false
        tbl.vipLevel = 0
    else
        tbl.vipLevelSpecified = true
    end
    if tbl.titleId == nil then
        tbl.titleIdSpecified = false
        tbl.titleId = 0
    else
        tbl.titleIdSpecified = true
    end
    if tbl.unionPos == nil then
        tbl.unionPosSpecified = false
        tbl.unionPos = 0
    else
        tbl.unionPosSpecified = true
    end
    if tbl.isSabacUnion == nil then
        tbl.isSabacUnionSpecified = false
        tbl.isSabacUnion = false
    else
        tbl.isSabacUnionSpecified = true
    end
    if tbl.openServerTime == nil then
        tbl.openServerTimeSpecified = false
        tbl.openServerTime = 0
    else
        tbl.openServerTimeSpecified = true
    end
    if tbl.combineServerTime == nil then
        tbl.combineServerTimeSpecified = false
        tbl.combineServerTime = 0
    else
        tbl.combineServerTimeSpecified = true
    end
    if tbl.nbValueMax == nil then
        tbl.nbValueMaxSpecified = false
        tbl.nbValueMax = 0
    else
        tbl.nbValueMaxSpecified = true
    end
    if tbl.buffers == nil then
        tbl.buffers = {}
    else
        if adjustTable.fight_adj ~= nil and adjustTable.fight_adj.AdjustBufferInfo ~= nil then
            for i = 1, #tbl.buffers do
                adjustTable.fight_adj.AdjustBufferInfo(tbl.buffers[i])
            end
        end
    end
    if tbl.roleSkillSettings == nil then
        tbl.roleSkillSettings = {}
    end
    if tbl.thisJunXianId == nil then
        tbl.thisJunXianIdSpecified = false
        tbl.thisJunXianId = 0
    else
        tbl.thisJunXianIdSpecified = true
    end
    if tbl.reinExp == nil then
        tbl.reinExpSpecified = false
        tbl.reinExp = 0
    else
        tbl.reinExpSpecified = true
    end
    if tbl.mergeCount == nil then
        tbl.mergeCountSpecified = false
        tbl.mergeCount = 0
    else
        tbl.mergeCountSpecified = true
    end
    if tbl.firstRecharge == nil then
        tbl.firstRechargeSpecified = false
        tbl.firstRecharge = 0
    else
        tbl.firstRechargeSpecified = true
    end
    if tbl.zeroLevel == nil then
        tbl.zeroLevelSpecified = false
        tbl.zeroLevel = 0
    else
        tbl.zeroLevelSpecified = true
    end
    if tbl.zeroRein == nil then
        tbl.zeroReinSpecified = false
        tbl.zeroRein = 0
    else
        tbl.zeroReinSpecified = true
    end
    if tbl.auctionDiamond == nil then
        tbl.auctionDiamondSpecified = false
        tbl.auctionDiamond = 0
    else
        tbl.auctionDiamondSpecified = true
    end
    if tbl.sabacUnionId == nil then
        tbl.sabacUnionIdSpecified = false
        tbl.sabacUnionId = 0
    else
        tbl.sabacUnionIdSpecified = true
    end
    if tbl.groupMemberAllowMode == nil then
        tbl.groupMemberAllowModeSpecified = false
        tbl.groupMemberAllowMode = 0
    else
        tbl.groupMemberAllowModeSpecified = true
    end
    if tbl.sabacUnionName == nil then
        tbl.sabacUnionNameSpecified = false
        tbl.sabacUnionName = ""
    else
        tbl.sabacUnionNameSpecified = true
    end
    if tbl.monthCard == nil then
        tbl.monthCard = {}
    end
    if tbl.unionRank == nil then
        tbl.unionRankSpecified = false
        tbl.unionRank = 0
    else
        tbl.unionRankSpecified = true
    end
    if tbl.wanLi == nil then
        tbl.wanLiSpecified = false
        tbl.wanLi = 0
    else
        tbl.wanLiSpecified = true
    end
    if tbl.sealMarkId == nil then
        tbl.sealMarkIdSpecified = false
        tbl.sealMarkId = 0
    else
        tbl.sealMarkIdSpecified = true
    end
    if tbl.isSabacUniteUnion == nil then
        tbl.isSabacUniteUnionSpecified = false
        tbl.isSabacUniteUnion = false
    else
        tbl.isSabacUniteUnionSpecified = true
    end
    if tbl.SabacUniteType == nil then
        tbl.SabacUniteTypeSpecified = false
        tbl.SabacUniteType = 0
    else
        tbl.SabacUniteTypeSpecified = true
    end
    if tbl.vipMember == nil then
        tbl.vipMemberSpecified = false
        tbl.vipMember = nil
    else
        if tbl.vipMemberSpecified == nil then 
            tbl.vipMemberSpecified = true
            if roleV2_adj.AdjustVipMember ~= nil then
                roleV2_adj.AdjustVipMember(tbl.vipMember)
            end
        end
    end
    if tbl.rechargeFirst == nil then
        tbl.rechargeFirstSpecified = false
        tbl.rechargeFirst = 0
    else
        tbl.rechargeFirstSpecified = true
    end
    if tbl.rechargeTotal == nil then
        tbl.rechargeTotalSpecified = false
        tbl.rechargeTotal = 0
    else
        tbl.rechargeTotalSpecified = true
    end
    if tbl.automaticCollectCount == nil then
        tbl.automaticCollectCountSpecified = false
        tbl.automaticCollectCount = 0
    else
        tbl.automaticCollectCountSpecified = true
    end
end

--region metatable roleV2.GameBasicShareInfo
---@type roleV2.GameBasicShareInfo
roleV2_adj.metatable_GameBasicShareInfo = {
    _ClassName = "roleV2.GameBasicShareInfo",
}
roleV2_adj.metatable_GameBasicShareInfo.__index = roleV2_adj.metatable_GameBasicShareInfo
--endregion

---@param tbl roleV2.GameBasicShareInfo 待调整的table数据
function roleV2_adj.AdjustGameBasicShareInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_GameBasicShareInfo)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.shareNum == nil then
        tbl.shareNumSpecified = false
        tbl.shareNum = 0
    else
        tbl.shareNumSpecified = true
    end
    if tbl.willUniteUnionTimeOpen == nil then
        tbl.willUniteUnionTimeOpenSpecified = false
        tbl.willUniteUnionTimeOpen = 0
    else
        tbl.willUniteUnionTimeOpenSpecified = true
    end
    if tbl.willCrossServerGroup == nil then
        tbl.willCrossServerGroup = {}
    end
    if tbl.unionVoteBeginTime == nil then
        tbl.unionVoteBeginTimeSpecified = false
        tbl.unionVoteBeginTime = 0
    else
        tbl.unionVoteBeginTimeSpecified = true
    end
    if tbl.unionVoteEndTime == nil then
        tbl.unionVoteEndTimeSpecified = false
        tbl.unionVoteEndTime = 0
    else
        tbl.unionVoteEndTimeSpecified = true
    end
    if tbl.enterShare == nil then
        tbl.enterShareSpecified = false
        tbl.enterShare = 0
    else
        tbl.enterShareSpecified = true
    end
    if tbl.voteUnionType == nil then
        tbl.voteUnionTypeSpecified = false
        tbl.voteUnionType = 0
    else
        tbl.voteUnionTypeSpecified = true
    end
    if tbl.shareOpenTimes == nil then
        tbl.shareOpenTimes = {}
    else
        if roleV2_adj.AdjustShareOpenTimeInfo ~= nil then
            for i = 1, #tbl.shareOpenTimes do
                roleV2_adj.AdjustShareOpenTimeInfo(tbl.shareOpenTimes[i])
            end
        end
    end
    if tbl.enterShareNum == nil then
        tbl.enterShareNumSpecified = false
        tbl.enterShareNum = 0
    else
        tbl.enterShareNumSpecified = true
    end
    if tbl.shareOpenTime == nil then
        tbl.shareOpenTimeSpecified = false
        tbl.shareOpenTime = 0
    else
        tbl.shareOpenTimeSpecified = true
    end
end

--region metatable roleV2.ShareOpenTimeInfo
---@type roleV2.ShareOpenTimeInfo
roleV2_adj.metatable_ShareOpenTimeInfo = {
    _ClassName = "roleV2.ShareOpenTimeInfo",
}
roleV2_adj.metatable_ShareOpenTimeInfo.__index = roleV2_adj.metatable_ShareOpenTimeInfo
--endregion

---@param tbl roleV2.ShareOpenTimeInfo 待调整的table数据
function roleV2_adj.AdjustShareOpenTimeInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ShareOpenTimeInfo)
    if tbl.shareNum == nil then
        tbl.shareNumSpecified = false
        tbl.shareNum = 0
    else
        tbl.shareNumSpecified = true
    end
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
    if tbl.shareServers == nil then
        tbl.shareServersSpecified = false
        tbl.shareServers = ""
    else
        tbl.shareServersSpecified = true
    end
end

--region metatable roleV2.RoleExtraValues
---@type roleV2.RoleExtraValues
roleV2_adj.metatable_RoleExtraValues = {
    _ClassName = "roleV2.RoleExtraValues",
}
roleV2_adj.metatable_RoleExtraValues.__index = roleV2_adj.metatable_RoleExtraValues
--endregion

---@param tbl roleV2.RoleExtraValues 待调整的table数据
function roleV2_adj.AdjustRoleExtraValues(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_RoleExtraValues)
    if tbl.freeReliveCount == nil then
        tbl.freeReliveCountSpecified = false
        tbl.freeReliveCount = 0
    else
        tbl.freeReliveCountSpecified = true
    end
    if tbl.nextReliveTime == nil then
        tbl.nextReliveTimeSpecified = false
        tbl.nextReliveTime = 0
    else
        tbl.nextReliveTimeSpecified = true
    end
    if tbl.weapon == nil then
        tbl.weaponSpecified = false
        tbl.weapon = 0
    else
        tbl.weaponSpecified = true
    end
    if tbl.clothes == nil then
        tbl.clothesSpecified = false
        tbl.clothes = 0
    else
        tbl.clothesSpecified = true
    end
    if tbl.helmet == nil then
        tbl.helmetSpecified = false
        tbl.helmet = 0
    else
        tbl.helmetSpecified = true
    end
    if tbl.face == nil then
        tbl.faceSpecified = false
        tbl.face = 0
    else
        tbl.faceSpecified = true
    end
end

--region metatable roleV2.ResPlayerExpChange
---@type roleV2.ResPlayerExpChange
roleV2_adj.metatable_ResPlayerExpChange = {
    _ClassName = "roleV2.ResPlayerExpChange",
}
roleV2_adj.metatable_ResPlayerExpChange.__index = roleV2_adj.metatable_ResPlayerExpChange
--endregion

---@param tbl roleV2.ResPlayerExpChange 待调整的table数据
function roleV2_adj.AdjustResPlayerExpChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResPlayerExpChange)
end

--region metatable roleV2.ResPlayerLevelChange
---@type roleV2.ResPlayerLevelChange
roleV2_adj.metatable_ResPlayerLevelChange = {
    _ClassName = "roleV2.ResPlayerLevelChange",
}
roleV2_adj.metatable_ResPlayerLevelChange.__index = roleV2_adj.metatable_ResPlayerLevelChange
--endregion

---@param tbl roleV2.ResPlayerLevelChange 待调整的table数据
function roleV2_adj.AdjustResPlayerLevelChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResPlayerLevelChange)
    if tbl.levelPower == nil then
        tbl.levelPowerSpecified = false
        tbl.levelPower = 0
    else
        tbl.levelPowerSpecified = true
    end
end

--region metatable roleV2.ResSendRoleReinInfo
---@type roleV2.ResSendRoleReinInfo
roleV2_adj.metatable_ResSendRoleReinInfo = {
    _ClassName = "roleV2.ResSendRoleReinInfo",
}
roleV2_adj.metatable_ResSendRoleReinInfo.__index = roleV2_adj.metatable_ResSendRoleReinInfo
--endregion

---@param tbl roleV2.ResSendRoleReinInfo 待调整的table数据
function roleV2_adj.AdjustResSendRoleReinInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResSendRoleReinInfo)
    if tbl.reinNum == nil then
        tbl.reinNumSpecified = false
        tbl.reinNum = 0
    else
        tbl.reinNumSpecified = true
    end
    if tbl.fightValue == nil then
        tbl.fightValueSpecified = false
        tbl.fightValue = 0
    else
        tbl.fightValueSpecified = true
    end
    if tbl.exchangeNum == nil then
        tbl.exchangeNumSpecified = false
        tbl.exchangeNum = 0
    else
        tbl.exchangeNumSpecified = true
    end
    if tbl.useNum == nil then
        tbl.useNum = {}
    else
        if roleV2_adj.AdjustReinItemBean ~= nil then
            for i = 1, #tbl.useNum do
                roleV2_adj.AdjustReinItemBean(tbl.useNum[i])
            end
        end
    end
    if tbl.reinLevel == nil then
        tbl.reinLevelSpecified = false
        tbl.reinLevel = 0
    else
        tbl.reinLevelSpecified = true
    end
    if tbl.info == nil then
        tbl.info = {}
    else
        if roleV2_adj.AdjustKillBossInfo ~= nil then
            for i = 1, #tbl.info do
                roleV2_adj.AdjustKillBossInfo(tbl.info[i])
            end
        end
    end
end

--region metatable roleV2.KillBossInfo
---@type roleV2.KillBossInfo
roleV2_adj.metatable_KillBossInfo = {
    _ClassName = "roleV2.KillBossInfo",
}
roleV2_adj.metatable_KillBossInfo.__index = roleV2_adj.metatable_KillBossInfo
--endregion

---@param tbl roleV2.KillBossInfo 待调整的table数据
function roleV2_adj.AdjustKillBossInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_KillBossInfo)
    if tbl.conditionId == nil then
        tbl.conditionIdSpecified = false
        tbl.conditionId = 0
    else
        tbl.conditionIdSpecified = true
    end
    if tbl.killMonsterCount == nil then
        tbl.killMonsterCountSpecified = false
        tbl.killMonsterCount = 0
    else
        tbl.killMonsterCountSpecified = true
    end
end

--region metatable roleV2.ResRoleReinSuccess
---@type roleV2.ResRoleReinSuccess
roleV2_adj.metatable_ResRoleReinSuccess = {
    _ClassName = "roleV2.ResRoleReinSuccess",
}
roleV2_adj.metatable_ResRoleReinSuccess.__index = roleV2_adj.metatable_ResRoleReinSuccess
--endregion

---@param tbl roleV2.ResRoleReinSuccess 待调整的table数据
function roleV2_adj.AdjustResRoleReinSuccess(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResRoleReinSuccess)
end

--region metatable roleV2.ResRoleExchangeReinResult
---@type roleV2.ResRoleExchangeReinResult
roleV2_adj.metatable_ResRoleExchangeReinResult = {
    _ClassName = "roleV2.ResRoleExchangeReinResult",
}
roleV2_adj.metatable_ResRoleExchangeReinResult.__index = roleV2_adj.metatable_ResRoleExchangeReinResult
--endregion

---@param tbl roleV2.ResRoleExchangeReinResult 待调整的table数据
function roleV2_adj.AdjustResRoleExchangeReinResult(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResRoleExchangeReinResult)
end

--region metatable roleV2.ResTotalFightValueChange
---@type roleV2.ResTotalFightValueChange
roleV2_adj.metatable_ResTotalFightValueChange = {
    _ClassName = "roleV2.ResTotalFightValueChange",
}
roleV2_adj.metatable_ResTotalFightValueChange.__index = roleV2_adj.metatable_ResTotalFightValueChange
--endregion

---@param tbl roleV2.ResTotalFightValueChange 待调整的table数据
function roleV2_adj.AdjustResTotalFightValueChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResTotalFightValueChange)
end

--region metatable roleV2.ResPetList
---@type roleV2.ResPetList
roleV2_adj.metatable_ResPetList = {
    _ClassName = "roleV2.ResPetList",
}
roleV2_adj.metatable_ResPetList.__index = roleV2_adj.metatable_ResPetList
--endregion

---@param tbl roleV2.ResPetList 待调整的table数据
function roleV2_adj.AdjustResPetList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResPetList)
    if tbl.petBean == nil then
        tbl.petBean = {}
    else
        if roleV2_adj.AdjustPetBean ~= nil then
            for i = 1, #tbl.petBean do
                roleV2_adj.AdjustPetBean(tbl.petBean[i])
            end
        end
    end
end

--region metatable roleV2.ResCreatePet
---@type roleV2.ResCreatePet
roleV2_adj.metatable_ResCreatePet = {
    _ClassName = "roleV2.ResCreatePet",
}
roleV2_adj.metatable_ResCreatePet.__index = roleV2_adj.metatable_ResCreatePet
--endregion

---@param tbl roleV2.ResCreatePet 待调整的table数据
function roleV2_adj.AdjustResCreatePet(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResCreatePet)
end

--region metatable roleV2.ChangeRoleDieStateRequest
---@type roleV2.ChangeRoleDieStateRequest
roleV2_adj.metatable_ChangeRoleDieStateRequest = {
    _ClassName = "roleV2.ChangeRoleDieStateRequest",
}
roleV2_adj.metatable_ChangeRoleDieStateRequest.__index = roleV2_adj.metatable_ChangeRoleDieStateRequest
--endregion

---@param tbl roleV2.ChangeRoleDieStateRequest 待调整的table数据
function roleV2_adj.AdjustChangeRoleDieStateRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ChangeRoleDieStateRequest)
end

--region metatable roleV2.RoleSettingRequest
---@type roleV2.RoleSettingRequest
roleV2_adj.metatable_RoleSettingRequest = {
    _ClassName = "roleV2.RoleSettingRequest",
}
roleV2_adj.metatable_RoleSettingRequest.__index = roleV2_adj.metatable_RoleSettingRequest
--endregion

---@param tbl roleV2.RoleSettingRequest 待调整的table数据
function roleV2_adj.AdjustRoleSettingRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_RoleSettingRequest)
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = false
    else
        tbl.stateSpecified = true
    end
    if tbl.roleSettingValue == nil then
        tbl.roleSettingValueSpecified = false
        tbl.roleSettingValue = 0
    else
        tbl.roleSettingValueSpecified = true
    end
end

--region metatable roleV2.ResRoleSettingChange
---@type roleV2.ResRoleSettingChange
roleV2_adj.metatable_ResRoleSettingChange = {
    _ClassName = "roleV2.ResRoleSettingChange",
}
roleV2_adj.metatable_ResRoleSettingChange.__index = roleV2_adj.metatable_ResRoleSettingChange
--endregion

---@param tbl roleV2.ResRoleSettingChange 待调整的table数据
function roleV2_adj.AdjustResRoleSettingChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResRoleSettingChange)
end

--region metatable roleV2.ResRoleSettingInfo
---@type roleV2.ResRoleSettingInfo
roleV2_adj.metatable_ResRoleSettingInfo = {
    _ClassName = "roleV2.ResRoleSettingInfo",
}
roleV2_adj.metatable_ResRoleSettingInfo.__index = roleV2_adj.metatable_ResRoleSettingInfo
--endregion

---@param tbl roleV2.ResRoleSettingInfo 待调整的table数据
function roleV2_adj.AdjustResRoleSettingInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResRoleSettingInfo)
    if tbl.roleSettingBean == nil then
        tbl.roleSettingBean = {}
    else
        if roleV2_adj.AdjustRoleSettingBean ~= nil then
            for i = 1, #tbl.roleSettingBean do
                roleV2_adj.AdjustRoleSettingBean(tbl.roleSettingBean[i])
            end
        end
    end
end

--region metatable roleV2.ResSendRoleVeinInfo
---@type roleV2.ResSendRoleVeinInfo
roleV2_adj.metatable_ResSendRoleVeinInfo = {
    _ClassName = "roleV2.ResSendRoleVeinInfo",
}
roleV2_adj.metatable_ResSendRoleVeinInfo.__index = roleV2_adj.metatable_ResSendRoleVeinInfo
--endregion

---@param tbl roleV2.ResSendRoleVeinInfo 待调整的table数据
function roleV2_adj.AdjustResSendRoleVeinInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResSendRoleVeinInfo)
end

--region metatable roleV2.ResSendInnerPowerInfo
---@type roleV2.ResSendInnerPowerInfo
roleV2_adj.metatable_ResSendInnerPowerInfo = {
    _ClassName = "roleV2.ResSendInnerPowerInfo",
}
roleV2_adj.metatable_ResSendInnerPowerInfo.__index = roleV2_adj.metatable_ResSendInnerPowerInfo
--endregion

---@param tbl roleV2.ResSendInnerPowerInfo 待调整的table数据
function roleV2_adj.AdjustResSendInnerPowerInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResSendInnerPowerInfo)
end

--region metatable roleV2.ResInnerPowerInfoChange
---@type roleV2.ResInnerPowerInfoChange
roleV2_adj.metatable_ResInnerPowerInfoChange = {
    _ClassName = "roleV2.ResInnerPowerInfoChange",
}
roleV2_adj.metatable_ResInnerPowerInfoChange.__index = roleV2_adj.metatable_ResInnerPowerInfoChange
--endregion

---@param tbl roleV2.ResInnerPowerInfoChange 待调整的table数据
function roleV2_adj.AdjustResInnerPowerInfoChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResInnerPowerInfoChange)
end

--region metatable roleV2.HandyKeySettingRequest
---@type roleV2.HandyKeySettingRequest
roleV2_adj.metatable_HandyKeySettingRequest = {
    _ClassName = "roleV2.HandyKeySettingRequest",
}
roleV2_adj.metatable_HandyKeySettingRequest.__index = roleV2_adj.metatable_HandyKeySettingRequest
--endregion

---@param tbl roleV2.HandyKeySettingRequest 待调整的table数据
function roleV2_adj.AdjustHandyKeySettingRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_HandyKeySettingRequest)
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
    if tbl.num == nil then
        tbl.numSpecified = false
        tbl.num = 0
    else
        tbl.numSpecified = true
    end
end

--region metatable roleV2.ExchangeHandyKeyRequest
---@type roleV2.ExchangeHandyKeyRequest
roleV2_adj.metatable_ExchangeHandyKeyRequest = {
    _ClassName = "roleV2.ExchangeHandyKeyRequest",
}
roleV2_adj.metatable_ExchangeHandyKeyRequest.__index = roleV2_adj.metatable_ExchangeHandyKeyRequest
--endregion

---@param tbl roleV2.ExchangeHandyKeyRequest 待调整的table数据
function roleV2_adj.AdjustExchangeHandyKeyRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ExchangeHandyKeyRequest)
end

--region metatable roleV2.ResHandyKeySettingInfos
---@type roleV2.ResHandyKeySettingInfos
roleV2_adj.metatable_ResHandyKeySettingInfos = {
    _ClassName = "roleV2.ResHandyKeySettingInfos",
}
roleV2_adj.metatable_ResHandyKeySettingInfos.__index = roleV2_adj.metatable_ResHandyKeySettingInfos
--endregion

---@param tbl roleV2.ResHandyKeySettingInfos 待调整的table数据
function roleV2_adj.AdjustResHandyKeySettingInfos(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResHandyKeySettingInfos)
    if tbl.list == nil then
        tbl.list = {}
    else
        if roleV2_adj.AdjustHandyKeyBean ~= nil then
            for i = 1, #tbl.list do
                roleV2_adj.AdjustHandyKeyBean(tbl.list[i])
            end
        end
    end
end

--region metatable roleV2.GetRoleInfo
---@type roleV2.GetRoleInfo
roleV2_adj.metatable_GetRoleInfo = {
    _ClassName = "roleV2.GetRoleInfo",
}
roleV2_adj.metatable_GetRoleInfo.__index = roleV2_adj.metatable_GetRoleInfo
--endregion

---@param tbl roleV2.GetRoleInfo 待调整的table数据
function roleV2_adj.AdjustGetRoleInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_GetRoleInfo)
end

--region metatable roleV2.SaveRoleSettingsMsg
---@type roleV2.SaveRoleSettingsMsg
roleV2_adj.metatable_SaveRoleSettingsMsg = {
    _ClassName = "roleV2.SaveRoleSettingsMsg",
}
roleV2_adj.metatable_SaveRoleSettingsMsg.__index = roleV2_adj.metatable_SaveRoleSettingsMsg
--endregion

---@param tbl roleV2.SaveRoleSettingsMsg 待调整的table数据
function roleV2_adj.AdjustSaveRoleSettingsMsg(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_SaveRoleSettingsMsg)
    if tbl.roleSettings == nil then
        tbl.roleSettings = {}
    end
end

--region metatable roleV2.SaveRoleSkillSettingsMsg
---@type roleV2.SaveRoleSkillSettingsMsg
roleV2_adj.metatable_SaveRoleSkillSettingsMsg = {
    _ClassName = "roleV2.SaveRoleSkillSettingsMsg",
}
roleV2_adj.metatable_SaveRoleSkillSettingsMsg.__index = roleV2_adj.metatable_SaveRoleSkillSettingsMsg
--endregion

---@param tbl roleV2.SaveRoleSkillSettingsMsg 待调整的table数据
function roleV2_adj.AdjustSaveRoleSkillSettingsMsg(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_SaveRoleSkillSettingsMsg)
    if tbl.skillId == nil then
        tbl.skillId = {}
    end
end

--region metatable roleV2.CDBean
---@type roleV2.CDBean
roleV2_adj.metatable_CDBean = {
    _ClassName = "roleV2.CDBean",
}
roleV2_adj.metatable_CDBean.__index = roleV2_adj.metatable_CDBean
--endregion

---@param tbl roleV2.CDBean 待调整的table数据
function roleV2_adj.AdjustCDBean(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_CDBean)
end

--region metatable roleV2.EditName
---@type roleV2.EditName
roleV2_adj.metatable_EditName = {
    _ClassName = "roleV2.EditName",
}
roleV2_adj.metatable_EditName.__index = roleV2_adj.metatable_EditName
--endregion

---@param tbl roleV2.EditName 待调整的table数据
function roleV2_adj.AdjustEditName(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_EditName)
end

--region metatable roleV2.ResEditName
---@type roleV2.ResEditName
roleV2_adj.metatable_ResEditName = {
    _ClassName = "roleV2.ResEditName",
}
roleV2_adj.metatable_ResEditName.__index = roleV2_adj.metatable_ResEditName
--endregion

---@param tbl roleV2.ResEditName 待调整的table数据
function roleV2_adj.AdjustResEditName(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResEditName)
    if tbl.isSuccess == nil then
        tbl.isSuccessSpecified = false
        tbl.isSuccess = 0
    else
        tbl.isSuccessSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.reason == nil then
        tbl.reasonSpecified = false
        tbl.reason = ""
    else
        tbl.reasonSpecified = true
    end
end

--region metatable roleV2.SystemOpenReminder
---@type roleV2.SystemOpenReminder
roleV2_adj.metatable_SystemOpenReminder = {
    _ClassName = "roleV2.SystemOpenReminder",
}
roleV2_adj.metatable_SystemOpenReminder.__index = roleV2_adj.metatable_SystemOpenReminder
--endregion

---@param tbl roleV2.SystemOpenReminder 待调整的table数据
function roleV2_adj.AdjustSystemOpenReminder(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_SystemOpenReminder)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.configId == nil then
        tbl.configIdSpecified = false
        tbl.configId = 0
    else
        tbl.configIdSpecified = true
    end
    if tbl.levelDiffer == nil then
        tbl.levelDifferSpecified = false
        tbl.levelDiffer = 0
    else
        tbl.levelDifferSpecified = true
    end
    if tbl.yiKaiQi == nil then
        tbl.yiKaiQi = {}
    end
end

--region metatable roleV2.ResBubbleOnlineExp
---@type roleV2.ResBubbleOnlineExp
roleV2_adj.metatable_ResBubbleOnlineExp = {
    _ClassName = "roleV2.ResBubbleOnlineExp",
}
roleV2_adj.metatable_ResBubbleOnlineExp.__index = roleV2_adj.metatable_ResBubbleOnlineExp
--endregion

---@param tbl roleV2.ResBubbleOnlineExp 待调整的table数据
function roleV2_adj.AdjustResBubbleOnlineExp(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResBubbleOnlineExp)
    if tbl.exp == nil then
        tbl.expSpecified = false
        tbl.exp = 0
    else
        tbl.expSpecified = true
    end
    if tbl.bubbleTime == nil then
        tbl.bubbleTimeSpecified = false
        tbl.bubbleTime = 0
    else
        tbl.bubbleTimeSpecified = true
    end
    if tbl.totalTime == nil then
        tbl.totalTimeSpecified = false
        tbl.totalTime = 0
    else
        tbl.totalTimeSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
    if tbl.servantExp == nil then
        tbl.servantExpSpecified = false
        tbl.servantExp = 0
    else
        tbl.servantExpSpecified = true
    end
end

--region metatable roleV2.BubbleOfflineExp
---@type roleV2.BubbleOfflineExp
roleV2_adj.metatable_BubbleOfflineExp = {
    _ClassName = "roleV2.BubbleOfflineExp",
}
roleV2_adj.metatable_BubbleOfflineExp.__index = roleV2_adj.metatable_BubbleOfflineExp
--endregion

---@param tbl roleV2.BubbleOfflineExp 待调整的table数据
function roleV2_adj.AdjustBubbleOfflineExp(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_BubbleOfflineExp)
    if tbl.exp == nil then
        tbl.expSpecified = false
        tbl.exp = 0
    else
        tbl.expSpecified = true
    end
    if tbl.vipExp == nil then
        tbl.vipExpSpecified = false
        tbl.vipExp = 0
    else
        tbl.vipExpSpecified = true
    end
    if tbl.developExp == nil then
        tbl.developExpSpecified = false
        tbl.developExp = 0
    else
        tbl.developExpSpecified = true
    end
    if tbl.offlineTime == nil then
        tbl.offlineTimeSpecified = false
        tbl.offlineTime = 0
    else
        tbl.offlineTimeSpecified = true
    end
    if tbl.vipPercent == nil then
        tbl.vipPercentSpecified = false
        tbl.vipPercent = 0
    else
        tbl.vipPercentSpecified = true
    end
end

--region metatable roleV2.AutoOperate
---@type roleV2.AutoOperate
roleV2_adj.metatable_AutoOperate = {
    _ClassName = "roleV2.AutoOperate",
}
roleV2_adj.metatable_AutoOperate.__index = roleV2_adj.metatable_AutoOperate
--endregion

---@param tbl roleV2.AutoOperate 待调整的table数据
function roleV2_adj.AdjustAutoOperate(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_AutoOperate)
    if tbl.autoFind == nil then
        tbl.autoFindSpecified = false
        tbl.autoFind = false
    else
        tbl.autoFindSpecified = true
    end
    if tbl.autoFight == nil then
        tbl.autoFightSpecified = false
        tbl.autoFight = false
    else
        tbl.autoFightSpecified = true
    end
end

--region metatable roleV2.ResRefreshInfo
---@type roleV2.ResRefreshInfo
roleV2_adj.metatable_ResRefreshInfo = {
    _ClassName = "roleV2.ResRefreshInfo",
}
roleV2_adj.metatable_ResRefreshInfo.__index = roleV2_adj.metatable_ResRefreshInfo
--endregion

---@param tbl roleV2.ResRefreshInfo 待调整的table数据
function roleV2_adj.AdjustResRefreshInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResRefreshInfo)
    if tbl.activeInfo == nil then
        tbl.activeInfoSpecified = false
        tbl.activeInfo = nil
    else
        if tbl.activeInfoSpecified == nil then 
            tbl.activeInfoSpecified = true
            if adjustTable.active_adj ~= nil and adjustTable.active_adj.AdjustActiveInfo ~= nil then
                adjustTable.active_adj.AdjustActiveInfo(tbl.activeInfo)
            end
        end
    end
end

--region metatable roleV2.ResGetMinerInfo
---@type roleV2.ResGetMinerInfo
roleV2_adj.metatable_ResGetMinerInfo = {
    _ClassName = "roleV2.ResGetMinerInfo",
}
roleV2_adj.metatable_ResGetMinerInfo.__index = roleV2_adj.metatable_ResGetMinerInfo
--endregion

---@param tbl roleV2.ResGetMinerInfo 待调整的table数据
function roleV2_adj.AdjustResGetMinerInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResGetMinerInfo)
    if tbl.miner == nil then
        tbl.miner = {}
    else
        if roleV2_adj.AdjustMinerInfo ~= nil then
            for i = 1, #tbl.miner do
                roleV2_adj.AdjustMinerInfo(tbl.miner[i])
            end
        end
    end
    if tbl.mine == nil then
        tbl.mine = {}
    else
        if roleV2_adj.AdjustMineInfo ~= nil then
            for i = 1, #tbl.mine do
                roleV2_adj.AdjustMineInfo(tbl.mine[i])
            end
        end
    end
end

--region metatable roleV2.MinerInfo
---@type roleV2.MinerInfo
roleV2_adj.metatable_MinerInfo = {
    _ClassName = "roleV2.MinerInfo",
}
roleV2_adj.metatable_MinerInfo.__index = roleV2_adj.metatable_MinerInfo
--endregion

---@param tbl roleV2.MinerInfo 待调整的table数据
function roleV2_adj.AdjustMinerInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_MinerInfo)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.activityType == nil then
        tbl.activityTypeSpecified = false
        tbl.activityType = 0
    else
        tbl.activityTypeSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.point == nil then
        tbl.pointSpecified = false
        tbl.point = ""
    else
        tbl.pointSpecified = true
    end
end

--region metatable roleV2.MineInfo
---@type roleV2.MineInfo
roleV2_adj.metatable_MineInfo = {
    _ClassName = "roleV2.MineInfo",
}
roleV2_adj.metatable_MineInfo.__index = roleV2_adj.metatable_MineInfo
--endregion

---@param tbl roleV2.MineInfo 待调整的table数据
function roleV2_adj.AdjustMineInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_MineInfo)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable roleV2.ResUpdateMineInfo
---@type roleV2.ResUpdateMineInfo
roleV2_adj.metatable_ResUpdateMineInfo = {
    _ClassName = "roleV2.ResUpdateMineInfo",
}
roleV2_adj.metatable_ResUpdateMineInfo.__index = roleV2_adj.metatable_ResUpdateMineInfo
--endregion

---@param tbl roleV2.ResUpdateMineInfo 待调整的table数据
function roleV2_adj.AdjustResUpdateMineInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResUpdateMineInfo)
    if tbl.mine == nil then
        tbl.mine = {}
    else
        if roleV2_adj.AdjustMineInfo ~= nil then
            for i = 1, #tbl.mine do
                roleV2_adj.AdjustMineInfo(tbl.mine[i])
            end
        end
    end
end

--region metatable roleV2.ReqHireMiner
---@type roleV2.ReqHireMiner
roleV2_adj.metatable_ReqHireMiner = {
    _ClassName = "roleV2.ReqHireMiner",
}
roleV2_adj.metatable_ReqHireMiner.__index = roleV2_adj.metatable_ReqHireMiner
--endregion

---@param tbl roleV2.ReqHireMiner 待调整的table数据
function roleV2_adj.AdjustReqHireMiner(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ReqHireMiner)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
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
end

--region metatable roleV2.ResPlayerSpyInfo
---@type roleV2.ResPlayerSpyInfo
roleV2_adj.metatable_ResPlayerSpyInfo = {
    _ClassName = "roleV2.ResPlayerSpyInfo",
}
roleV2_adj.metatable_ResPlayerSpyInfo.__index = roleV2_adj.metatable_ResPlayerSpyInfo
--endregion

---@param tbl roleV2.ResPlayerSpyInfo 待调整的table数据
function roleV2_adj.AdjustResPlayerSpyInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResPlayerSpyInfo)
    if tbl.isSpy == nil then
        tbl.isSpySpecified = false
        tbl.isSpy = 0
    else
        tbl.isSpySpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.wing == nil then
        tbl.wingSpecified = false
        tbl.wing = 0
    else
        tbl.wingSpecified = true
    end
    if tbl.titleId == nil then
        tbl.titleIdSpecified = false
        tbl.titleId = 0
    else
        tbl.titleIdSpecified = true
    end
    if tbl.thisJunXianId == nil then
        tbl.thisJunXianIdSpecified = false
        tbl.thisJunXianId = 0
    else
        tbl.thisJunXianIdSpecified = true
    end
    if tbl.appellation == nil then
        tbl.appellationSpecified = false
        tbl.appellation = nil
    else
        if tbl.appellationSpecified == nil then 
            tbl.appellationSpecified = true
            if adjustTable.appearance_adj ~= nil and adjustTable.appearance_adj.AdjustTitleInfo ~= nil then
                adjustTable.appearance_adj.AdjustTitleInfo(tbl.appellation)
            end
        end
    end
    if tbl.wearInfo == nil then
        tbl.wearInfo = {}
    else
        if adjustTable.appearance_adj ~= nil and adjustTable.appearance_adj.AdjustwearPosition ~= nil then
            for i = 1, #tbl.wearInfo do
                adjustTable.appearance_adj.AdjustwearPosition(tbl.wearInfo[i])
            end
        end
    end
    if tbl.extraValues == nil then
        tbl.extraValuesSpecified = false
        tbl.extraValues = nil
    else
        if tbl.extraValuesSpecified == nil then 
            tbl.extraValuesSpecified = true
            if roleV2_adj.AdjustRoleExtraValues ~= nil then
                roleV2_adj.AdjustRoleExtraValues(tbl.extraValues)
            end
        end
    end
    if tbl.remainTime == nil then
        tbl.remainTimeSpecified = false
        tbl.remainTime = 0
    else
        tbl.remainTimeSpecified = true
    end
end

--region metatable roleV2.ReqSaveSecretaryInfo
---@type roleV2.ReqSaveSecretaryInfo
roleV2_adj.metatable_ReqSaveSecretaryInfo = {
    _ClassName = "roleV2.ReqSaveSecretaryInfo",
}
roleV2_adj.metatable_ReqSaveSecretaryInfo.__index = roleV2_adj.metatable_ReqSaveSecretaryInfo
--endregion

---@param tbl roleV2.ReqSaveSecretaryInfo 待调整的table数据
function roleV2_adj.AdjustReqSaveSecretaryInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ReqSaveSecretaryInfo)
    if tbl.secretaryType == nil then
        tbl.secretaryTypeSpecified = false
        tbl.secretaryType = 0
    else
        tbl.secretaryTypeSpecified = true
    end
    if tbl.problem == nil then
        tbl.problemSpecified = false
        tbl.problem = ""
    else
        tbl.problemSpecified = true
    end
    if tbl.answerType == nil then
        tbl.answerTypeSpecified = false
        tbl.answerType = 0
    else
        tbl.answerTypeSpecified = true
    end
    if tbl.solution == nil then
        tbl.solutionSpecified = false
        tbl.solution = ""
    else
        tbl.solutionSpecified = true
    end
    if tbl.answerId == nil then
        tbl.answerIdSpecified = false
        tbl.answerId = 0
    else
        tbl.answerIdSpecified = true
    end
    if tbl.submissionProblem == nil then
        tbl.submissionProblemSpecified = false
        tbl.submissionProblem = 0
    else
        tbl.submissionProblemSpecified = true
    end
    if tbl.compulsoryProblem == nil then
        tbl.compulsoryProblemSpecified = false
        tbl.compulsoryProblem = ""
    else
        tbl.compulsoryProblemSpecified = true
    end
    if tbl.wrongCompulsoryProblem == nil then
        tbl.wrongCompulsoryProblemSpecified = false
        tbl.wrongCompulsoryProblem = ""
    else
        tbl.wrongCompulsoryProblemSpecified = true
    end
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.saveOrUpdate == nil then
        tbl.saveOrUpdateSpecified = false
        tbl.saveOrUpdate = 0
    else
        tbl.saveOrUpdateSpecified = true
    end
end

--region metatable roleV2.ResSeeSecretaryInfo
---@type roleV2.ResSeeSecretaryInfo
roleV2_adj.metatable_ResSeeSecretaryInfo = {
    _ClassName = "roleV2.ResSeeSecretaryInfo",
}
roleV2_adj.metatable_ResSeeSecretaryInfo.__index = roleV2_adj.metatable_ResSeeSecretaryInfo
--endregion

---@param tbl roleV2.ResSeeSecretaryInfo 待调整的table数据
function roleV2_adj.AdjustResSeeSecretaryInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResSeeSecretaryInfo)
    if tbl.secretaryInfo == nil then
        tbl.secretaryInfo = {}
    else
        if roleV2_adj.AdjustSecretary ~= nil then
            for i = 1, #tbl.secretaryInfo do
                roleV2_adj.AdjustSecretary(tbl.secretaryInfo[i])
            end
        end
    end
end

--region metatable roleV2.ResBackSecretaryInfo
---@type roleV2.ResBackSecretaryInfo
roleV2_adj.metatable_ResBackSecretaryInfo = {
    _ClassName = "roleV2.ResBackSecretaryInfo",
}
roleV2_adj.metatable_ResBackSecretaryInfo.__index = roleV2_adj.metatable_ResBackSecretaryInfo
--endregion

---@param tbl roleV2.ResBackSecretaryInfo 待调整的table数据
function roleV2_adj.AdjustResBackSecretaryInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResBackSecretaryInfo)
    if tbl.secretaryInfo == nil then
        tbl.secretaryInfoSpecified = false
        tbl.secretaryInfo = nil
    else
        if tbl.secretaryInfoSpecified == nil then 
            tbl.secretaryInfoSpecified = true
            if roleV2_adj.AdjustSecretary ~= nil then
                roleV2_adj.AdjustSecretary(tbl.secretaryInfo)
            end
        end
    end
end

--region metatable roleV2.Secretary
---@type roleV2.Secretary
roleV2_adj.metatable_Secretary = {
    _ClassName = "roleV2.Secretary",
}
roleV2_adj.metatable_Secretary.__index = roleV2_adj.metatable_Secretary
--endregion

---@param tbl roleV2.Secretary 待调整的table数据
function roleV2_adj.AdjustSecretary(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_Secretary)
    if tbl.secretaryType == nil then
        tbl.secretaryTypeSpecified = false
        tbl.secretaryType = 0
    else
        tbl.secretaryTypeSpecified = true
    end
    if tbl.problem == nil then
        tbl.problemSpecified = false
        tbl.problem = ""
    else
        tbl.problemSpecified = true
    end
    if tbl.answerType == nil then
        tbl.answerTypeSpecified = false
        tbl.answerType = 0
    else
        tbl.answerTypeSpecified = true
    end
    if tbl.solution == nil then
        tbl.solutionSpecified = false
        tbl.solution = ""
    else
        tbl.solutionSpecified = true
    end
    if tbl.answerId == nil then
        tbl.answerIdSpecified = false
        tbl.answerId = 0
    else
        tbl.answerIdSpecified = true
    end
    if tbl.submissionProblem == nil then
        tbl.submissionProblemSpecified = false
        tbl.submissionProblem = 0
    else
        tbl.submissionProblemSpecified = true
    end
    if tbl.compulsoryProblem == nil then
        tbl.compulsoryProblemSpecified = false
        tbl.compulsoryProblem = ""
    else
        tbl.compulsoryProblemSpecified = true
    end
    if tbl.wrongCompulsoryProblem == nil then
        tbl.wrongCompulsoryProblemSpecified = false
        tbl.wrongCompulsoryProblem = ""
    else
        tbl.wrongCompulsoryProblemSpecified = true
    end
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.createTime == nil then
        tbl.createTimeSpecified = false
        tbl.createTime = 0
    else
        tbl.createTimeSpecified = true
    end
end

--region metatable roleV2.ReqDeleteSecretaryInfo
---@type roleV2.ReqDeleteSecretaryInfo
roleV2_adj.metatable_ReqDeleteSecretaryInfo = {
    _ClassName = "roleV2.ReqDeleteSecretaryInfo",
}
roleV2_adj.metatable_ReqDeleteSecretaryInfo.__index = roleV2_adj.metatable_ReqDeleteSecretaryInfo
--endregion

---@param tbl roleV2.ReqDeleteSecretaryInfo 待调整的table数据
function roleV2_adj.AdjustReqDeleteSecretaryInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ReqDeleteSecretaryInfo)
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
end

--region metatable roleV2.ResSecretaryPush
---@type roleV2.ResSecretaryPush
roleV2_adj.metatable_ResSecretaryPush = {
    _ClassName = "roleV2.ResSecretaryPush",
}
roleV2_adj.metatable_ResSecretaryPush.__index = roleV2_adj.metatable_ResSecretaryPush
--endregion

---@param tbl roleV2.ResSecretaryPush 待调整的table数据
function roleV2_adj.AdjustResSecretaryPush(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResSecretaryPush)
    if tbl.pushId == nil then
        tbl.pushIdSpecified = false
        tbl.pushId = 0
    else
        tbl.pushIdSpecified = true
    end
end

--region metatable roleV2.ResRoleFirstRechargeChange
---@type roleV2.ResRoleFirstRechargeChange
roleV2_adj.metatable_ResRoleFirstRechargeChange = {
    _ClassName = "roleV2.ResRoleFirstRechargeChange",
}
roleV2_adj.metatable_ResRoleFirstRechargeChange.__index = roleV2_adj.metatable_ResRoleFirstRechargeChange
--endregion

---@param tbl roleV2.ResRoleFirstRechargeChange 待调整的table数据
function roleV2_adj.AdjustResRoleFirstRechargeChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResRoleFirstRechargeChange)
    if tbl.firstRecharge == nil then
        tbl.firstRechargeSpecified = false
        tbl.firstRecharge = 0
    else
        tbl.firstRechargeSpecified = true
    end
end

--region metatable roleV2.ReqCheckPreTaskIsComplete
---@type roleV2.ReqCheckPreTaskIsComplete
roleV2_adj.metatable_ReqCheckPreTaskIsComplete = {
    _ClassName = "roleV2.ReqCheckPreTaskIsComplete",
}
roleV2_adj.metatable_ReqCheckPreTaskIsComplete.__index = roleV2_adj.metatable_ReqCheckPreTaskIsComplete
--endregion

---@param tbl roleV2.ReqCheckPreTaskIsComplete 待调整的table数据
function roleV2_adj.AdjustReqCheckPreTaskIsComplete(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ReqCheckPreTaskIsComplete)
    if tbl.taskId == nil then
        tbl.taskIdSpecified = false
        tbl.taskId = 0
    else
        tbl.taskIdSpecified = true
    end
    if tbl.tableId == nil then
        tbl.tableIdSpecified = false
        tbl.tableId = 0
    else
        tbl.tableIdSpecified = true
    end
end

--region metatable roleV2.ResCheckPreTaskIsComplete
---@type roleV2.ResCheckPreTaskIsComplete
roleV2_adj.metatable_ResCheckPreTaskIsComplete = {
    _ClassName = "roleV2.ResCheckPreTaskIsComplete",
}
roleV2_adj.metatable_ResCheckPreTaskIsComplete.__index = roleV2_adj.metatable_ResCheckPreTaskIsComplete
--endregion

---@param tbl roleV2.ResCheckPreTaskIsComplete 待调整的table数据
function roleV2_adj.AdjustResCheckPreTaskIsComplete(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResCheckPreTaskIsComplete)
    if tbl.isComplete == nil then
        tbl.isCompleteSpecified = false
        tbl.isComplete = 0
    else
        tbl.isCompleteSpecified = true
    end
    if tbl.tableId == nil then
        tbl.tableIdSpecified = false
        tbl.tableId = 0
    else
        tbl.tableIdSpecified = true
    end
end

--region metatable roleV2.ReqMainTaskPush
---@type roleV2.ReqMainTaskPush
roleV2_adj.metatable_ReqMainTaskPush = {
    _ClassName = "roleV2.ReqMainTaskPush",
}
roleV2_adj.metatable_ReqMainTaskPush.__index = roleV2_adj.metatable_ReqMainTaskPush
--endregion

---@param tbl roleV2.ReqMainTaskPush 待调整的table数据
function roleV2_adj.AdjustReqMainTaskPush(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ReqMainTaskPush)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.taskId == nil then
        tbl.taskIdSpecified = false
        tbl.taskId = 0
    else
        tbl.taskIdSpecified = true
    end
end

--region metatable roleV2.ResMainTaskPush
---@type roleV2.ResMainTaskPush
roleV2_adj.metatable_ResMainTaskPush = {
    _ClassName = "roleV2.ResMainTaskPush",
}
roleV2_adj.metatable_ResMainTaskPush.__index = roleV2_adj.metatable_ResMainTaskPush
--endregion

---@param tbl roleV2.ResMainTaskPush 待调整的table数据
function roleV2_adj.AdjustResMainTaskPush(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResMainTaskPush)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.taskId == nil then
        tbl.taskIdSpecified = false
        tbl.taskId = 0
    else
        tbl.taskIdSpecified = true
    end
    if tbl.send == nil then
        tbl.sendSpecified = false
        tbl.send = 0
    else
        tbl.sendSpecified = true
    end
end

--region metatable roleV2.ReqRefineMasterPanel
---@type roleV2.ReqRefineMasterPanel
roleV2_adj.metatable_ReqRefineMasterPanel = {
    _ClassName = "roleV2.ReqRefineMasterPanel",
}
roleV2_adj.metatable_ReqRefineMasterPanel.__index = roleV2_adj.metatable_ReqRefineMasterPanel
--endregion

---@param tbl roleV2.ReqRefineMasterPanel 待调整的table数据
function roleV2_adj.AdjustReqRefineMasterPanel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ReqRefineMasterPanel)
end

--region metatable roleV2.ResRefineMasterPanel
---@type roleV2.ResRefineMasterPanel
roleV2_adj.metatable_ResRefineMasterPanel = {
    _ClassName = "roleV2.ResRefineMasterPanel",
}
roleV2_adj.metatable_ResRefineMasterPanel.__index = roleV2_adj.metatable_ResRefineMasterPanel
--endregion

---@param tbl roleV2.ResRefineMasterPanel 待调整的table数据
function roleV2_adj.AdjustResRefineMasterPanel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResRefineMasterPanel)
    if tbl.cfgId == nil then
        tbl.cfgIdSpecified = false
        tbl.cfgId = 0
    else
        tbl.cfgIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable roleV2.ReqRefine
---@type roleV2.ReqRefine
roleV2_adj.metatable_ReqRefine = {
    _ClassName = "roleV2.ReqRefine",
}
roleV2_adj.metatable_ReqRefine.__index = roleV2_adj.metatable_ReqRefine
--endregion

---@param tbl roleV2.ReqRefine 待调整的table数据
function roleV2_adj.AdjustReqRefine(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ReqRefine)
    if tbl.servantType == nil then
        tbl.servantTypeSpecified = false
        tbl.servantType = 0
    else
        tbl.servantTypeSpecified = true
    end
    if tbl.times == nil then
        tbl.timesSpecified = false
        tbl.times = 0
    else
        tbl.timesSpecified = true
    end
end

--region metatable roleV2.ResRefineMasterRedDot
---@type roleV2.ResRefineMasterRedDot
roleV2_adj.metatable_ResRefineMasterRedDot = {
    _ClassName = "roleV2.ResRefineMasterRedDot",
}
roleV2_adj.metatable_ResRefineMasterRedDot.__index = roleV2_adj.metatable_ResRefineMasterRedDot
--endregion

---@param tbl roleV2.ResRefineMasterRedDot 待调整的table数据
function roleV2_adj.AdjustResRefineMasterRedDot(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResRefineMasterRedDot)
    if tbl.reinExp == nil then
        tbl.reinExpSpecified = false
        tbl.reinExp = 0
    else
        tbl.reinExpSpecified = true
    end
    if tbl.feats == nil then
        tbl.featsSpecified = false
        tbl.feats = 0
    else
        tbl.featsSpecified = true
    end
    if tbl.servantReinExp == nil then
        tbl.servantReinExpSpecified = false
        tbl.servantReinExp = 0
    else
        tbl.servantReinExpSpecified = true
    end
end

--region metatable roleV2.ResRefineResult
---@type roleV2.ResRefineResult
roleV2_adj.metatable_ResRefineResult = {
    _ClassName = "roleV2.ResRefineResult",
}
roleV2_adj.metatable_ResRefineResult.__index = roleV2_adj.metatable_ResRefineResult
--endregion

---@param tbl roleV2.ResRefineResult 待调整的table数据
function roleV2_adj.AdjustResRefineResult(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResRefineResult)
    if tbl.isSuccess == nil then
        tbl.isSuccessSpecified = false
        tbl.isSuccess = 0
    else
        tbl.isSuccessSpecified = true
    end
    if tbl.reason == nil then
        tbl.reasonSpecified = false
        tbl.reason = 0
    else
        tbl.reasonSpecified = true
    end
    if tbl.gain == nil then
        tbl.gainSpecified = false
        tbl.gain = 0
    else
        tbl.gainSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable roleV2.UpdateAuctionDiamond
---@type roleV2.UpdateAuctionDiamond
roleV2_adj.metatable_UpdateAuctionDiamond = {
    _ClassName = "roleV2.UpdateAuctionDiamond",
}
roleV2_adj.metatable_UpdateAuctionDiamond.__index = roleV2_adj.metatable_UpdateAuctionDiamond
--endregion

---@param tbl roleV2.UpdateAuctionDiamond 待调整的table数据
function roleV2_adj.AdjustUpdateAuctionDiamond(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_UpdateAuctionDiamond)
    if tbl.auctionDiamond == nil then
        tbl.auctionDiamondSpecified = false
        tbl.auctionDiamond = 0
    else
        tbl.auctionDiamondSpecified = true
    end
end

--region metatable roleV2.ReqSendQuestionInfo
---@type roleV2.ReqSendQuestionInfo
roleV2_adj.metatable_ReqSendQuestionInfo = {
    _ClassName = "roleV2.ReqSendQuestionInfo",
}
roleV2_adj.metatable_ReqSendQuestionInfo.__index = roleV2_adj.metatable_ReqSendQuestionInfo
--endregion

---@param tbl roleV2.ReqSendQuestionInfo 待调整的table数据
function roleV2_adj.AdjustReqSendQuestionInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ReqSendQuestionInfo)
    if tbl.content == nil then
        tbl.contentSpecified = false
        tbl.content = ""
    else
        tbl.contentSpecified = true
    end
end

--region metatable roleV2.ResPlayerDieDropEquipByWear
---@type roleV2.ResPlayerDieDropEquipByWear
roleV2_adj.metatable_ResPlayerDieDropEquipByWear = {
    _ClassName = "roleV2.ResPlayerDieDropEquipByWear",
}
roleV2_adj.metatable_ResPlayerDieDropEquipByWear.__index = roleV2_adj.metatable_ResPlayerDieDropEquipByWear
--endregion

---@param tbl roleV2.ResPlayerDieDropEquipByWear 待调整的table数据
function roleV2_adj.AdjustResPlayerDieDropEquipByWear(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResPlayerDieDropEquipByWear)
    if tbl.dropType == nil then
        tbl.dropTypeSpecified = false
        tbl.dropType = 0
    else
        tbl.dropTypeSpecified = true
    end
    if tbl.itemLid == nil then
        tbl.itemLidSpecified = false
        tbl.itemLid = 0
    else
        tbl.itemLidSpecified = true
    end
end

--region metatable roleV2.ReqPaperCraneDelivery
---@type roleV2.ReqPaperCraneDelivery
roleV2_adj.metatable_ReqPaperCraneDelivery = {
    _ClassName = "roleV2.ReqPaperCraneDelivery",
}
roleV2_adj.metatable_ReqPaperCraneDelivery.__index = roleV2_adj.metatable_ReqPaperCraneDelivery
--endregion

---@param tbl roleV2.ReqPaperCraneDelivery 待调整的table数据
function roleV2_adj.AdjustReqPaperCraneDelivery(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ReqPaperCraneDelivery)
    if tbl.mapId == nil then
        tbl.mapIdSpecified = false
        tbl.mapId = 0
    else
        tbl.mapIdSpecified = true
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
    if tbl.line == nil then
        tbl.lineSpecified = false
        tbl.line = 0
    else
        tbl.lineSpecified = true
    end
end

--region metatable roleV2.ResPaperCraneDelivery
---@type roleV2.ResPaperCraneDelivery
roleV2_adj.metatable_ResPaperCraneDelivery = {
    _ClassName = "roleV2.ResPaperCraneDelivery",
}
roleV2_adj.metatable_ResPaperCraneDelivery.__index = roleV2_adj.metatable_ResPaperCraneDelivery
--endregion

---@param tbl roleV2.ResPaperCraneDelivery 待调整的table数据
function roleV2_adj.AdjustResPaperCraneDelivery(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResPaperCraneDelivery)
    if tbl.isSuccess == nil then
        tbl.isSuccessSpecified = false
        tbl.isSuccess = 0
    else
        tbl.isSuccessSpecified = true
    end
end

--region metatable roleV2.ResNewFirstChargePush
---@type roleV2.ResNewFirstChargePush
roleV2_adj.metatable_ResNewFirstChargePush = {
    _ClassName = "roleV2.ResNewFirstChargePush",
}
roleV2_adj.metatable_ResNewFirstChargePush.__index = roleV2_adj.metatable_ResNewFirstChargePush
--endregion

---@param tbl roleV2.ResNewFirstChargePush 待调整的table数据
function roleV2_adj.AdjustResNewFirstChargePush(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResNewFirstChargePush)
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
end

--region metatable roleV2.ResNeedPrompt
---@type roleV2.ResNeedPrompt
roleV2_adj.metatable_ResNeedPrompt = {
    _ClassName = "roleV2.ResNeedPrompt",
}
roleV2_adj.metatable_ResNeedPrompt.__index = roleV2_adj.metatable_ResNeedPrompt
--endregion

---@param tbl roleV2.ResNeedPrompt 待调整的table数据
function roleV2_adj.AdjustResNeedPrompt(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResNeedPrompt)
    if tbl.needPromptList == nil then
        tbl.needPromptList = {}
    end
end

--region metatable roleV2.ResRoleRefreshWanLi
---@type roleV2.ResRoleRefreshWanLi
roleV2_adj.metatable_ResRoleRefreshWanLi = {
    _ClassName = "roleV2.ResRoleRefreshWanLi",
}
roleV2_adj.metatable_ResRoleRefreshWanLi.__index = roleV2_adj.metatable_ResRoleRefreshWanLi
--endregion

---@param tbl roleV2.ResRoleRefreshWanLi 待调整的table数据
function roleV2_adj.AdjustResRoleRefreshWanLi(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResRoleRefreshWanLi)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.wanLi == nil then
        tbl.wanLiSpecified = false
        tbl.wanLi = 0
    else
        tbl.wanLiSpecified = true
    end
end

--region metatable roleV2.RoleAddFakeBuff
---@type roleV2.RoleAddFakeBuff
roleV2_adj.metatable_RoleAddFakeBuff = {
    _ClassName = "roleV2.RoleAddFakeBuff",
}
roleV2_adj.metatable_RoleAddFakeBuff.__index = roleV2_adj.metatable_RoleAddFakeBuff
--endregion

---@param tbl roleV2.RoleAddFakeBuff 待调整的table数据
function roleV2_adj.AdjustRoleAddFakeBuff(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_RoleAddFakeBuff)
    if tbl.buffers == nil then
        tbl.buffersSpecified = false
        tbl.buffers = nil
    else
        if tbl.buffersSpecified == nil then 
            tbl.buffersSpecified = true
            if adjustTable.fight_adj ~= nil and adjustTable.fight_adj.AdjustBufferInfo ~= nil then
                adjustTable.fight_adj.AdjustBufferInfo(tbl.buffers)
            end
        end
    end
    if tbl.addOrRemove == nil then
        tbl.addOrRemoveSpecified = false
        tbl.addOrRemove = 0
    else
        tbl.addOrRemoveSpecified = true
    end
end

--region metatable roleV2.ResRoleTame
---@type roleV2.ResRoleTame
roleV2_adj.metatable_ResRoleTame = {
    _ClassName = "roleV2.ResRoleTame",
}
roleV2_adj.metatable_ResRoleTame.__index = roleV2_adj.metatable_ResRoleTame
--endregion

---@param tbl roleV2.ResRoleTame 待调整的table数据
function roleV2_adj.AdjustResRoleTame(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResRoleTame)
    if tbl.goldTameCount == nil then
        tbl.goldTameCountSpecified = false
        tbl.goldTameCount = 0
    else
        tbl.goldTameCountSpecified = true
    end
    if tbl.diamondTameCount == nil then
        tbl.diamondTameCountSpecified = false
        tbl.diamondTameCount = 0
    else
        tbl.diamondTameCountSpecified = true
    end
end

--region metatable roleV2.ResTitleTianfu
---@type roleV2.ResTitleTianfu
roleV2_adj.metatable_ResTitleTianfu = {
    _ClassName = "roleV2.ResTitleTianfu",
}
roleV2_adj.metatable_ResTitleTianfu.__index = roleV2_adj.metatable_ResTitleTianfu
--endregion

---@param tbl roleV2.ResTitleTianfu 待调整的table数据
function roleV2_adj.AdjustResTitleTianfu(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResTitleTianfu)
    if tbl.zhanAddPoint == nil then
        tbl.zhanAddPointSpecified = false
        tbl.zhanAddPoint = 0
    else
        tbl.zhanAddPointSpecified = true
    end
    if tbl.zhanReducePoint == nil then
        tbl.zhanReducePointSpecified = false
        tbl.zhanReducePoint = 0
    else
        tbl.zhanReducePointSpecified = true
    end
    if tbl.faAddPoint == nil then
        tbl.faAddPointSpecified = false
        tbl.faAddPoint = 0
    else
        tbl.faAddPointSpecified = true
    end
    if tbl.faReducePoint == nil then
        tbl.faReducePointSpecified = false
        tbl.faReducePoint = 0
    else
        tbl.faReducePointSpecified = true
    end
    if tbl.daoAddPoint == nil then
        tbl.daoAddPointSpecified = false
        tbl.daoAddPoint = 0
    else
        tbl.daoAddPointSpecified = true
    end
    if tbl.daoReducePoint == nil then
        tbl.daoReducePointSpecified = false
        tbl.daoReducePoint = 0
    else
        tbl.daoReducePointSpecified = true
    end
    if tbl.available == nil then
        tbl.availableSpecified = false
        tbl.available = 0
    else
        tbl.availableSpecified = true
    end
end

--region metatable roleV2.ReqSaveTitleTianfu
---@type roleV2.ReqSaveTitleTianfu
roleV2_adj.metatable_ReqSaveTitleTianfu = {
    _ClassName = "roleV2.ReqSaveTitleTianfu",
}
roleV2_adj.metatable_ReqSaveTitleTianfu.__index = roleV2_adj.metatable_ReqSaveTitleTianfu
--endregion

---@param tbl roleV2.ReqSaveTitleTianfu 待调整的table数据
function roleV2_adj.AdjustReqSaveTitleTianfu(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ReqSaveTitleTianfu)
    if tbl.zhanAddPoint == nil then
        tbl.zhanAddPointSpecified = false
        tbl.zhanAddPoint = 0
    else
        tbl.zhanAddPointSpecified = true
    end
    if tbl.zhanReducePoint == nil then
        tbl.zhanReducePointSpecified = false
        tbl.zhanReducePoint = 0
    else
        tbl.zhanReducePointSpecified = true
    end
    if tbl.faAddPoint == nil then
        tbl.faAddPointSpecified = false
        tbl.faAddPoint = 0
    else
        tbl.faAddPointSpecified = true
    end
    if tbl.faReducePoint == nil then
        tbl.faReducePointSpecified = false
        tbl.faReducePoint = 0
    else
        tbl.faReducePointSpecified = true
    end
    if tbl.daoAddPoint == nil then
        tbl.daoAddPointSpecified = false
        tbl.daoAddPoint = 0
    else
        tbl.daoAddPointSpecified = true
    end
    if tbl.daoReducePoint == nil then
        tbl.daoReducePointSpecified = false
        tbl.daoReducePoint = 0
    else
        tbl.daoReducePointSpecified = true
    end
end

--region metatable roleV2.ResKongFuHouseTimeLimit
---@type roleV2.ResKongFuHouseTimeLimit
roleV2_adj.metatable_ResKongFuHouseTimeLimit = {
    _ClassName = "roleV2.ResKongFuHouseTimeLimit",
}
roleV2_adj.metatable_ResKongFuHouseTimeLimit.__index = roleV2_adj.metatable_ResKongFuHouseTimeLimit
--endregion

---@param tbl roleV2.ResKongFuHouseTimeLimit 待调整的table数据
function roleV2_adj.AdjustResKongFuHouseTimeLimit(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResKongFuHouseTimeLimit)
    if tbl.times == nil then
        tbl.times = {}
    end
end

--region metatable roleV2.potentialInfo
---@type roleV2.potentialInfo
roleV2_adj.metatable_potentialInfo = {
    _ClassName = "roleV2.potentialInfo",
}
roleV2_adj.metatable_potentialInfo.__index = roleV2_adj.metatable_potentialInfo
--endregion

---@param tbl roleV2.potentialInfo 待调整的table数据
function roleV2_adj.AdjustpotentialInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_potentialInfo)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.star == nil then
        tbl.starSpecified = false
        tbl.star = 0
    else
        tbl.starSpecified = true
    end
    if tbl.isOpen == nil then
        tbl.isOpenSpecified = false
        tbl.isOpen = 0
    else
        tbl.isOpenSpecified = true
    end
end

--region metatable roleV2.RespotentialInfo
---@type roleV2.RespotentialInfo
roleV2_adj.metatable_RespotentialInfo = {
    _ClassName = "roleV2.RespotentialInfo",
}
roleV2_adj.metatable_RespotentialInfo.__index = roleV2_adj.metatable_RespotentialInfo
--endregion

---@param tbl roleV2.RespotentialInfo 待调整的table数据
function roleV2_adj.AdjustRespotentialInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_RespotentialInfo)
    if tbl.info == nil then
        tbl.info = {}
    else
        if roleV2_adj.AdjustpotentialInfo ~= nil then
            for i = 1, #tbl.info do
                roleV2_adj.AdjustpotentialInfo(tbl.info[i])
            end
        end
    end
end

--region metatable roleV2.ResPotentialRedPoint
---@type roleV2.ResPotentialRedPoint
roleV2_adj.metatable_ResPotentialRedPoint = {
    _ClassName = "roleV2.ResPotentialRedPoint",
}
roleV2_adj.metatable_ResPotentialRedPoint.__index = roleV2_adj.metatable_ResPotentialRedPoint
--endregion

---@param tbl roleV2.ResPotentialRedPoint 待调整的table数据
function roleV2_adj.AdjustResPotentialRedPoint(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResPotentialRedPoint)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable roleV2.ReqActivePotential
---@type roleV2.ReqActivePotential
roleV2_adj.metatable_ReqActivePotential = {
    _ClassName = "roleV2.ReqActivePotential",
}
roleV2_adj.metatable_ReqActivePotential.__index = roleV2_adj.metatable_ReqActivePotential
--endregion

---@param tbl roleV2.ReqActivePotential 待调整的table数据
function roleV2_adj.AdjustReqActivePotential(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ReqActivePotential)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable roleV2.ReqUpgradePotential
---@type roleV2.ReqUpgradePotential
roleV2_adj.metatable_ReqUpgradePotential = {
    _ClassName = "roleV2.ReqUpgradePotential",
}
roleV2_adj.metatable_ReqUpgradePotential.__index = roleV2_adj.metatable_ReqUpgradePotential
--endregion

---@param tbl roleV2.ReqUpgradePotential 待调整的table数据
function roleV2_adj.AdjustReqUpgradePotential(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ReqUpgradePotential)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable roleV2.SettingBean
---@type roleV2.SettingBean
roleV2_adj.metatable_SettingBean = {
    _ClassName = "roleV2.SettingBean",
}
roleV2_adj.metatable_SettingBean.__index = roleV2_adj.metatable_SettingBean
--endregion

---@param tbl roleV2.SettingBean 待调整的table数据
function roleV2_adj.AdjustSettingBean(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_SettingBean)
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable roleV2.CollectionSetting
---@type roleV2.CollectionSetting
roleV2_adj.metatable_CollectionSetting = {
    _ClassName = "roleV2.CollectionSetting",
}
roleV2_adj.metatable_CollectionSetting.__index = roleV2_adj.metatable_CollectionSetting
--endregion

---@param tbl roleV2.CollectionSetting 待调整的table数据
function roleV2_adj.AdjustCollectionSetting(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_CollectionSetting)
    if tbl.setting == nil then
        tbl.setting = {}
    else
        if roleV2_adj.AdjustSettingBean ~= nil then
            for i = 1, #tbl.setting do
                roleV2_adj.AdjustSettingBean(tbl.setting[i])
            end
        end
    end
end

--region metatable roleV2.PickUpSettingBean
---@type roleV2.PickUpSettingBean
roleV2_adj.metatable_PickUpSettingBean = {
    _ClassName = "roleV2.PickUpSettingBean",
}
roleV2_adj.metatable_PickUpSettingBean.__index = roleV2_adj.metatable_PickUpSettingBean
--endregion

---@param tbl roleV2.PickUpSettingBean 待调整的table数据
function roleV2_adj.AdjustPickUpSettingBean(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_PickUpSettingBean)
    if tbl.parentId == nil then
        tbl.parentIdSpecified = false
        tbl.parentId = 0
    else
        tbl.parentIdSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable roleV2.PickUpSetting
---@type roleV2.PickUpSetting
roleV2_adj.metatable_PickUpSetting = {
    _ClassName = "roleV2.PickUpSetting",
}
roleV2_adj.metatable_PickUpSetting.__index = roleV2_adj.metatable_PickUpSetting
--endregion

---@param tbl roleV2.PickUpSetting 待调整的table数据
function roleV2_adj.AdjustPickUpSetting(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_PickUpSetting)
    if tbl.setting == nil then
        tbl.setting = {}
    else
        if roleV2_adj.AdjustPickUpSettingBean ~= nil then
            for i = 1, #tbl.setting do
                roleV2_adj.AdjustPickUpSettingBean(tbl.setting[i])
            end
        end
    end
end

--region metatable roleV2.ReqRoleModelInfo
---@type roleV2.ReqRoleModelInfo
roleV2_adj.metatable_ReqRoleModelInfo = {
    _ClassName = "roleV2.ReqRoleModelInfo",
}
roleV2_adj.metatable_ReqRoleModelInfo.__index = roleV2_adj.metatable_ReqRoleModelInfo
--endregion

---@param tbl roleV2.ReqRoleModelInfo 待调整的table数据
function roleV2_adj.AdjustReqRoleModelInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ReqRoleModelInfo)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
end

--region metatable roleV2.RoleModelInfo
---@type roleV2.RoleModelInfo
roleV2_adj.metatable_RoleModelInfo = {
    _ClassName = "roleV2.RoleModelInfo",
}
roleV2_adj.metatable_RoleModelInfo.__index = roleV2_adj.metatable_RoleModelInfo
--endregion

---@param tbl roleV2.RoleModelInfo 待调整的table数据
function roleV2_adj.AdjustRoleModelInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_RoleModelInfo)
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.armor == nil then
        tbl.armorSpecified = false
        tbl.armor = 0
    else
        tbl.armorSpecified = true
    end
    if tbl.weapon == nil then
        tbl.weaponSpecified = false
        tbl.weapon = 0
    else
        tbl.weaponSpecified = true
    end
    if tbl.helmet == nil then
        tbl.helmetSpecified = false
        tbl.helmet = 0
    else
        tbl.helmetSpecified = true
    end
    if tbl.face == nil then
        tbl.faceSpecified = false
        tbl.face = 0
    else
        tbl.faceSpecified = true
    end
    if tbl.wearPosition == nil then
        tbl.wearPosition = {}
    else
        if adjustTable.appearance_adj ~= nil and adjustTable.appearance_adj.AdjustwearPosition ~= nil then
            for i = 1, #tbl.wearPosition do
                adjustTable.appearance_adj.AdjustwearPosition(tbl.wearPosition[i])
            end
        end
    end
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
    if tbl.shield == nil then
        tbl.shieldSpecified = false
        tbl.shield = 0
    else
        tbl.shieldSpecified = true
    end
    if tbl.bambooHat == nil then
        tbl.bambooHatSpecified = false
        tbl.bambooHat = 0
    else
        tbl.bambooHatSpecified = true
    end
end

--region metatable roleV2.ReqMysteriousExchange
---@type roleV2.ReqMysteriousExchange
roleV2_adj.metatable_ReqMysteriousExchange = {
    _ClassName = "roleV2.ReqMysteriousExchange",
}
roleV2_adj.metatable_ReqMysteriousExchange.__index = roleV2_adj.metatable_ReqMysteriousExchange
--endregion

---@param tbl roleV2.ReqMysteriousExchange 待调整的table数据
function roleV2_adj.AdjustReqMysteriousExchange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ReqMysteriousExchange)
    if tbl.changId == nil then
        tbl.changIdSpecified = false
        tbl.changId = 0
    else
        tbl.changIdSpecified = true
    end
end

--region metatable roleV2.ResMysteriousExchange
---@type roleV2.ResMysteriousExchange
roleV2_adj.metatable_ResMysteriousExchange = {
    _ClassName = "roleV2.ResMysteriousExchange",
}
roleV2_adj.metatable_ResMysteriousExchange.__index = roleV2_adj.metatable_ResMysteriousExchange
--endregion

---@param tbl roleV2.ResMysteriousExchange 待调整的table数据
function roleV2_adj.AdjustResMysteriousExchange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResMysteriousExchange)
    if tbl.info == nil then
        tbl.info = {}
    else
        if roleV2_adj.AdjustMysteriousExchangInfo ~= nil then
            for i = 1, #tbl.info do
                roleV2_adj.AdjustMysteriousExchangInfo(tbl.info[i])
            end
        end
    end
end

--region metatable roleV2.MysteriousExchangInfo
---@type roleV2.MysteriousExchangInfo
roleV2_adj.metatable_MysteriousExchangInfo = {
    _ClassName = "roleV2.MysteriousExchangInfo",
}
roleV2_adj.metatable_MysteriousExchangInfo.__index = roleV2_adj.metatable_MysteriousExchangInfo
--endregion

---@param tbl roleV2.MysteriousExchangInfo 待调整的table数据
function roleV2_adj.AdjustMysteriousExchangInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_MysteriousExchangInfo)
    if tbl.changId == nil then
        tbl.changIdSpecified = false
        tbl.changId = 0
    else
        tbl.changIdSpecified = true
    end
    if tbl.changeNum == nil then
        tbl.changeNumSpecified = false
        tbl.changeNum = 0
    else
        tbl.changeNumSpecified = true
    end
end

--region metatable roleV2.BossKillData
---@type roleV2.BossKillData
roleV2_adj.metatable_BossKillData = {
    _ClassName = "roleV2.BossKillData",
}
roleV2_adj.metatable_BossKillData.__index = roleV2_adj.metatable_BossKillData
--endregion

---@param tbl roleV2.BossKillData 待调整的table数据
function roleV2_adj.AdjustBossKillData(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_BossKillData)
    if tbl.killDatas == nil then
        tbl.killDatas = {}
    else
        if roleV2_adj.AdjustBossTypeKillData ~= nil then
            for i = 1, #tbl.killDatas do
                roleV2_adj.AdjustBossTypeKillData(tbl.killDatas[i])
            end
        end
    end
end

--region metatable roleV2.BossTypeKillData
---@type roleV2.BossTypeKillData
roleV2_adj.metatable_BossTypeKillData = {
    _ClassName = "roleV2.BossTypeKillData",
}
roleV2_adj.metatable_BossTypeKillData.__index = roleV2_adj.metatable_BossTypeKillData
--endregion

---@param tbl roleV2.BossTypeKillData 待调整的table数据
function roleV2_adj.AdjustBossTypeKillData(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_BossTypeKillData)
end

--region metatable roleV2.ReqAddBossKillTimes
---@type roleV2.ReqAddBossKillTimes
roleV2_adj.metatable_ReqAddBossKillTimes = {
    _ClassName = "roleV2.ReqAddBossKillTimes",
}
roleV2_adj.metatable_ReqAddBossKillTimes.__index = roleV2_adj.metatable_ReqAddBossKillTimes
--endregion

---@param tbl roleV2.ReqAddBossKillTimes 待调整的table数据
function roleV2_adj.AdjustReqAddBossKillTimes(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ReqAddBossKillTimes)
end

--region metatable roleV2.ResRoleSystemPreview
---@type roleV2.ResRoleSystemPreview
roleV2_adj.metatable_ResRoleSystemPreview = {
    _ClassName = "roleV2.ResRoleSystemPreview",
}
roleV2_adj.metatable_ResRoleSystemPreview.__index = roleV2_adj.metatable_ResRoleSystemPreview
--endregion

---@param tbl roleV2.ResRoleSystemPreview 待调整的table数据
function roleV2_adj.AdjustResRoleSystemPreview(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResRoleSystemPreview)
    if tbl.info == nil then
        tbl.info = {}
    else
        if roleV2_adj.AdjustSystemPreview ~= nil then
            for i = 1, #tbl.info do
                roleV2_adj.AdjustSystemPreview(tbl.info[i])
            end
        end
    end
end

--region metatable roleV2.SystemPreview
---@type roleV2.SystemPreview
roleV2_adj.metatable_SystemPreview = {
    _ClassName = "roleV2.SystemPreview",
}
roleV2_adj.metatable_SystemPreview.__index = roleV2_adj.metatable_SystemPreview
--endregion

---@param tbl roleV2.SystemPreview 待调整的table数据
function roleV2_adj.AdjustSystemPreview(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_SystemPreview)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.rewardType == nil then
        tbl.rewardTypeSpecified = false
        tbl.rewardType = 0
    else
        tbl.rewardTypeSpecified = true
    end
end

--region metatable roleV2.ReqRewardSystemPreview
---@type roleV2.ReqRewardSystemPreview
roleV2_adj.metatable_ReqRewardSystemPreview = {
    _ClassName = "roleV2.ReqRewardSystemPreview",
}
roleV2_adj.metatable_ReqRewardSystemPreview.__index = roleV2_adj.metatable_ReqRewardSystemPreview
--endregion

---@param tbl roleV2.ReqRewardSystemPreview 待调整的table数据
function roleV2_adj.AdjustReqRewardSystemPreview(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ReqRewardSystemPreview)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable roleV2.ReqAddRoleExpByResources
---@type roleV2.ReqAddRoleExpByResources
roleV2_adj.metatable_ReqAddRoleExpByResources = {
    _ClassName = "roleV2.ReqAddRoleExpByResources",
}
roleV2_adj.metatable_ReqAddRoleExpByResources.__index = roleV2_adj.metatable_ReqAddRoleExpByResources
--endregion

---@param tbl roleV2.ReqAddRoleExpByResources 待调整的table数据
function roleV2_adj.AdjustReqAddRoleExpByResources(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ReqAddRoleExpByResources)
    if tbl.gear == nil then
        tbl.gearSpecified = false
        tbl.gear = 0
    else
        tbl.gearSpecified = true
    end
end

--region metatable roleV2.ResRoleExpAccumulate
---@type roleV2.ResRoleExpAccumulate
roleV2_adj.metatable_ResRoleExpAccumulate = {
    _ClassName = "roleV2.ResRoleExpAccumulate",
}
roleV2_adj.metatable_ResRoleExpAccumulate.__index = roleV2_adj.metatable_ResRoleExpAccumulate
--endregion

---@param tbl roleV2.ResRoleExpAccumulate 待调整的table数据
function roleV2_adj.AdjustResRoleExpAccumulate(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResRoleExpAccumulate)
    if tbl.hasCount == nil then
        tbl.hasCountSpecified = false
        tbl.hasCount = 0
    else
        tbl.hasCountSpecified = true
    end
    if tbl.hasExp == nil then
        tbl.hasExpSpecified = false
        tbl.hasExp = 0
    else
        tbl.hasExpSpecified = true
    end
end

--region metatable roleV2.ResRoleInviteCode
---@type roleV2.ResRoleInviteCode
roleV2_adj.metatable_ResRoleInviteCode = {
    _ClassName = "roleV2.ResRoleInviteCode",
}
roleV2_adj.metatable_ResRoleInviteCode.__index = roleV2_adj.metatable_ResRoleInviteCode
--endregion

---@param tbl roleV2.ResRoleInviteCode 待调整的table数据
function roleV2_adj.AdjustResRoleInviteCode(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResRoleInviteCode)
    if tbl.inviteCode == nil then
        tbl.inviteCodeSpecified = false
        tbl.inviteCode = ""
    else
        tbl.inviteCodeSpecified = true
    end
end

--region metatable roleV2.ResTransferSex
---@type roleV2.ResTransferSex
roleV2_adj.metatable_ResTransferSex = {
    _ClassName = "roleV2.ResTransferSex",
}
roleV2_adj.metatable_ResTransferSex.__index = roleV2_adj.metatable_ResTransferSex
--endregion

---@param tbl roleV2.ResTransferSex 待调整的table数据
function roleV2_adj.AdjustResTransferSex(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResTransferSex)
end

--region metatable roleV2.ReqTransferCareer
---@type roleV2.ReqTransferCareer
roleV2_adj.metatable_ReqTransferCareer = {
    _ClassName = "roleV2.ReqTransferCareer",
}
roleV2_adj.metatable_ReqTransferCareer.__index = roleV2_adj.metatable_ReqTransferCareer
--endregion

---@param tbl roleV2.ReqTransferCareer 待调整的table数据
function roleV2_adj.AdjustReqTransferCareer(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ReqTransferCareer)
end

--region metatable roleV2.ResTransferCareer
---@type roleV2.ResTransferCareer
roleV2_adj.metatable_ResTransferCareer = {
    _ClassName = "roleV2.ResTransferCareer",
}
roleV2_adj.metatable_ResTransferCareer.__index = roleV2_adj.metatable_ResTransferCareer
--endregion

---@param tbl roleV2.ResTransferCareer 待调整的table数据
function roleV2_adj.AdjustResTransferCareer(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResTransferCareer)
end

--region metatable roleV2.ResCanInsuredEquip
---@type roleV2.ResCanInsuredEquip
roleV2_adj.metatable_ResCanInsuredEquip = {
    _ClassName = "roleV2.ResCanInsuredEquip",
}
roleV2_adj.metatable_ResCanInsuredEquip.__index = roleV2_adj.metatable_ResCanInsuredEquip
--endregion

---@param tbl roleV2.ResCanInsuredEquip 待调整的table数据
function roleV2_adj.AdjustResCanInsuredEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResCanInsuredEquip)
    if tbl.insuredList == nil then
        tbl.insuredList = {}
    else
        if roleV2_adj.AdjustInsuredEquip ~= nil then
            for i = 1, #tbl.insuredList do
                roleV2_adj.AdjustInsuredEquip(tbl.insuredList[i])
            end
        end
    end
end

--region metatable roleV2.InsuredEquip
---@type roleV2.InsuredEquip
roleV2_adj.metatable_InsuredEquip = {
    _ClassName = "roleV2.InsuredEquip",
}
roleV2_adj.metatable_InsuredEquip.__index = roleV2_adj.metatable_InsuredEquip
--endregion

---@param tbl roleV2.InsuredEquip 待调整的table数据
function roleV2_adj.AdjustInsuredEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_InsuredEquip)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.theEquip == nil then
        tbl.theEquipSpecified = false
        tbl.theEquip = nil
    else
        if tbl.theEquipSpecified == nil then 
            tbl.theEquipSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.theEquip)
            end
        end
    end
end

--region metatable roleV2.ReqInsuredEquip
---@type roleV2.ReqInsuredEquip
roleV2_adj.metatable_ReqInsuredEquip = {
    _ClassName = "roleV2.ReqInsuredEquip",
}
roleV2_adj.metatable_ReqInsuredEquip.__index = roleV2_adj.metatable_ReqInsuredEquip
--endregion

---@param tbl roleV2.ReqInsuredEquip 待调整的table数据
function roleV2_adj.AdjustReqInsuredEquip(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ReqInsuredEquip)
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
    if tbl.abandonInsured == nil then
        tbl.abandonInsuredSpecified = false
        tbl.abandonInsured = 0
    else
        tbl.abandonInsuredSpecified = true
    end
end

--region metatable roleV2.ResInsuredSucces
---@type roleV2.ResInsuredSucces
roleV2_adj.metatable_ResInsuredSucces = {
    _ClassName = "roleV2.ResInsuredSucces",
}
roleV2_adj.metatable_ResInsuredSucces.__index = roleV2_adj.metatable_ResInsuredSucces
--endregion

---@param tbl roleV2.ResInsuredSucces 待调整的table数据
function roleV2_adj.AdjustResInsuredSucces(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, roleV2_adj.metatable_ResInsuredSucces)
    if tbl.isSuccess == nil then
        tbl.isSuccessSpecified = false
        tbl.isSuccess = 0
    else
        tbl.isSuccessSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.theEquip == nil then
        tbl.theEquipSpecified = false
        tbl.theEquip = nil
    else
        if tbl.theEquipSpecified == nil then 
            tbl.theEquipSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.theEquip)
            end
        end
    end
    if tbl.abandonInsured == nil then
        tbl.abandonInsuredSpecified = false
        tbl.abandonInsured = 0
    else
        tbl.abandonInsuredSpecified = true
    end
end

return roleV2_adj