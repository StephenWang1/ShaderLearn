---@class cfg_extra_mon_effectManager:TableManager
local cfg_extra_mon_effectManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_extra_mon_effect
function cfg_extra_mon_effectManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_extra_mon_effect> 遍历方法
function cfg_extra_mon_effectManager:ForPair(action)
    if action == nil then
        return
    end
    if self.dic then
        for i, v in pairs(self.dic) do
            action(i, v)
        end
    end
end

---表格解析完毕后调用此方法
function cfg_extra_mon_effectManager:PostProcess()
end

--region 获取
---@param id number 表id
---@param extraAttributeType LuaEnumExtraAttributeType 额外属性类型
---@param career LuaEnumCareer 职业
---@return string,number/nil
function cfg_extra_mon_effectManager:GetAttributeNameAndValue(id, extraAttributeType, career)
    return self:GetExtraAttributeName(id, extraAttributeType), self:GetExtraAttributeValue(id, extraAttributeType, career)
end

---获取属性名字
---@param id number 表id
---@param extraAttributeType LuaEnumExtraAttributeType
---@return string 属性名
function cfg_extra_mon_effectManager:GetExtraAttributeName(id, extraAttributeType)
    if type(id) ~= 'number' or type(extraAttributeType) ~= 'number' then
        return
    end
    local tbl = self:TryGetValue(id)
    if tbl == nil then
        return
    end
    if extraAttributeType == LuaEnumExtraAttributeType.ExtraDps then
        return tbl:GetExtraDpsDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.ExtraDpsPer then
        return tbl:GetExtraDpsPerDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.Critical then
        return tbl:GetCriticalDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.CriticalDamage then
        return tbl:GetCriticalDamageDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.HurtReduce then
        return tbl:GetHurtReduceDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.BloodSuck then
        return tbl:GetBloodSuckDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.BloodSuckPer then
        return tbl:GetBloodSuckProDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.BloodSuckExtra then
        return tbl:GetBloodSuckExtraDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.PetExtraDps then
        return tbl:GetPetExtraDpsDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.PetExtraDpsPer then
        return tbl:GetPetExtraDpsPerDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.DropPre then
        return tbl:GetDropProDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.ExtraDpsMax or extraAttributeType == LuaEnumExtraAttributeType.ExtraDpsMin then
        return tbl:GetExtraDpsMaxDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.HurtReduceMax or extraAttributeType == LuaEnumExtraAttributeType.HurtReduceMin then
        return tbl:GetHurtReduceMinDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.DropPre then
        return tbl:GetDropProDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyAttackMax then
        return tbl:GetPhyAttackMaxDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyAttackMin then
        return tbl:GetPhyAttackMaxDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicAttackMax then
        return tbl:GetMagicAttackMaxDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicAttackMin then
        return tbl:GetMagicAttackMaxDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.TaoAttackMax then
        return tbl:GetTaoAttackMaxDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.TaoAttackMin then
        return tbl:GetTaoAttackMaxDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyDefenceMax then
        return tbl:GetPhyDefenceMaxDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyDefenceMin then
        return tbl:GetPhyDefenceMaxDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicDefenceMax then
        return tbl:GetMagicDefenceMaxDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicDefenceMin then
        return tbl:GetMagicDefenceMaxDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.Hp then
        return tbl:GetMaxHpDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyDefMaxPercent then
        return tbl:GetPhyDefPercentDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyDefMinPercent then
        return tbl:GetPhyDefPercentDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicDefMaxPercent then
        return tbl:GetMagicDefPercentDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicDefMinPercent then
        return tbl:GetMagicDefPercentDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.HpPercent then
        return tbl:GetHpPercentDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.PenetrationAttributes then
        return tbl:GetPenetrationAttributesDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.DivineEquipHurtAdd then
        return tbl:GetDivineEquipHurtAddDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.ResistanceCritical then
        return tbl:GetResistanceCriticalDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.DivineEquipSkillAdd then
        return tbl:GetDivineEquipSkillAddDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.CommonCritical then
        return tbl:GetCommonCriticalDes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.Luck then
        return tbl:GetLuckDes()
    end
end

---获取额外属性值
---@param id number 表id
---@param extraAttributeType LuaEnumExtraAttributeType 额外属性类型
---@param career LuaEnumCareer 职业
---@return number/nil
function cfg_extra_mon_effectManager:GetExtraAttributeValue(id, extraAttributeType, career)
    if type(id) ~= 'number' or type(extraAttributeType) ~= 'number' then
        return
    end
    local tbl = self:TryGetValue(id)
    if tbl == nil then
        return
    end
    if extraAttributeType == LuaEnumExtraAttributeType.ExtraDps then
        return tbl:GetExtraDps()
    elseif extraAttributeType == LuaEnumExtraAttributeType.ExtraDpsPer then
        return tbl:GetExtraDpsPer()
    elseif extraAttributeType == LuaEnumExtraAttributeType.Critical then
        return tbl:GetCritical()
    elseif extraAttributeType == LuaEnumExtraAttributeType.CriticalDamage then
        return tbl:GetCriticalDamage()
    elseif extraAttributeType == LuaEnumExtraAttributeType.HurtReduce then
        return tbl:GetHurtReduce()
    elseif extraAttributeType == LuaEnumExtraAttributeType.BloodSuck then
        return tbl:GetBloodSuck()
    elseif extraAttributeType == LuaEnumExtraAttributeType.BloodSuckPer then
        return tbl:GetBloodSuckPro()
    elseif extraAttributeType == LuaEnumExtraAttributeType.BloodSuckExtra then
        return tbl:GetBloodSuckExtra()
    elseif extraAttributeType == LuaEnumExtraAttributeType.PetExtraDps then
        return tbl:GetPetExtraDps()
    elseif extraAttributeType == LuaEnumExtraAttributeType.PetExtraDpsPer then
        return tbl:GetPetExtraDpsPer()
    elseif extraAttributeType == LuaEnumExtraAttributeType.DropPre then
        return tbl:GetDropPro()
    elseif extraAttributeType == LuaEnumExtraAttributeType.ExtraDpsMax then
        return tbl:GetExtraDpsMax()
    elseif extraAttributeType == LuaEnumExtraAttributeType.ExtraDpsMin then
        return tbl:GetExtraDpsMin()
    elseif extraAttributeType == LuaEnumExtraAttributeType.HurtReduceMax then
        return tbl:GetHurtReduceMax()
    elseif extraAttributeType == LuaEnumExtraAttributeType.HurtReduceMin then
        return tbl:GetHurtReduceMin()
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyAttackMax then
        return tbl:GetPhyAttackMax()
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyAttackMin then
        return tbl:GetPhyAttackMin()
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicAttackMax then
        return tbl:GetMagicAttackMax()
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicAttackMin then
        return tbl:GetMagicAttackMin()
    elseif extraAttributeType == LuaEnumExtraAttributeType.TaoAttackMax then
        return tbl:GetTaoAttackMax()
    elseif extraAttributeType == LuaEnumExtraAttributeType.TaoAttackMin then
        return tbl:GetTaoAttackMin()
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyDefenceMax then
        return self:GetExtraAttributeValueByCareer(tbl:GetPhyDefenceMaxByCareer(), career)
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyDefenceMin then
        return self:GetExtraAttributeValueByCareer(tbl:GetPhyDefenceMinByCareer(), career)
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicDefenceMax then
        return self:GetExtraAttributeValueByCareer(tbl:GetMagicDefenceMaxByCareer(), career)
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicDefenceMin then
        return self:GetExtraAttributeValueByCareer(tbl:GetMagicDefenceMinByCareer(), career)
    elseif extraAttributeType == LuaEnumExtraAttributeType.Hp then
        return self:GetExtraAttributeValueByCareer(tbl:GetMaxHp(), career)
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyDefMaxPercent then
        return tbl:GetPhyDefMaxPercent()
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyDefMinPercent then
        return tbl:GetPhyDefMinPercent()
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicDefMaxPercent then
        return tbl:GetMagicDefMaxPercent()
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicDefMinPercent then
        return tbl:GetMagicDefMinPercent()
    elseif extraAttributeType == LuaEnumExtraAttributeType.HpPercent then
        return tbl:GetHpPercent()
    elseif extraAttributeType == LuaEnumExtraAttributeType.PenetrationAttributes then
        return tbl:GetPenetrationAttributes()
    elseif extraAttributeType == LuaEnumExtraAttributeType.DivineEquipHurtAdd then
        return tbl:GetDivineEquipHurtAdd()
    elseif extraAttributeType == LuaEnumExtraAttributeType.ResistanceCritical then
        return tbl:GetResistanceCritical()
    elseif extraAttributeType == LuaEnumExtraAttributeType.DivineEquipSkillAdd then
        return tbl:GetDivineEquipSkillAdd()
    elseif extraAttributeType == LuaEnumExtraAttributeType.CommonCritical then
        return tbl:GetCommonCritical()
    elseif extraAttributeType == LuaEnumExtraAttributeType.Luck then
        return tbl:GetLuck()
    end
end

---获取额外职业属性值
---@param configAttribute table<table<number,number>>
---@param career LuaEnumCareer 职业
---@return number/nil
function cfg_extra_mon_effectManager:GetExtraAttributeValueByCareer(configAttribute, career)
    if type(configAttribute) ~= 'table' or type(configAttribute.list) ~= 'table' or Utility.GetLuaTableCount(configAttribute.list) < 3 or type(career) ~= 'number' then
        return
    end
    local attributeList = configAttribute.list
    for k, v in pairs(attributeList) do
        local configParams = v.list
        if type(configParams) == 'table' and Utility.GetLuaTableCount(configParams) >= 2 then
            local configCareer = configParams[1]
            local configValue = configParams[2]
            if configCareer == career then
                return configValue
            end
        end
    end
end

---获取所有属性内容
---@return table<LuaEnumExtraAttributeType,AttributeDes>
function cfg_extra_mon_effectManager:GetAllAttributeDesList(id, career,sortAttribute)
    local attributeDesList = {}
    for k, v in pairs(LuaEnumExtraAttributeType) do
        ---@type AttributeDes
        local attributeDes = {}
        ---@type LuaEnumExtraAttributeType
        local extraAttributeType = v
        local addStr = self:GetExtraAttributeValueStr(id, extraAttributeType, career)
        if CS.StaticUtility.IsNullOrEmpty(addStr) == false then
            local name = self:GetExtraAttributeName(id, extraAttributeType)
            attributeDes.attributeType = extraAttributeType
            attributeDes.attributeName = name
            attributeDes.attributeValueDes = addStr
            attributeDesList[extraAttributeType] = attributeDes
        end
    end
    if sortAttribute == true and type(attributeDesList) == 'table' then
        attributeDesList = self:SortAttributeDesList(attributeDesList)
    end
    return attributeDesList
end

---@param attributeDesList table<LuaEnumExtraAttributeType,AttributeDes>
---@return table<LuaEnumExtraAttributeType,AttributeDes>
function cfg_extra_mon_effectManager:SortAttributeDesList(attributeDesList)
    table.sort(attributeDesList,function(attributeDes1,attributeDes2)
        return attributeDes1.attributeType < attributeDes2.attributeType
    end)
    return attributeDesList
end

---获取所有属性显示
---@return string
function cfg_extra_mon_effectManager:GetAllAttributeShow(id, career)
    local str = ""
    local num = 0
    for k, v in pairs(LuaEnumExtraAttributeType) do
        local extraAttributeType = v
        local addStr = self:GetExtraAttributeValueStr(id, extraAttributeType, career)
        if CS.StaticUtility.IsNullOrEmpty(addStr) == false then
            if num ~= 0 then
                str = Utility.CombineStringQuickly(str, "\n")
            end
            local name = self:GetExtraAttributeName(id, extraAttributeType)
            str = Utility.CombineStringQuickly(str, name, " ", addStr)
            num = num + 1
        end
    end
    return str
end

---获取处理后的额外属性值,
---@param id number 表id
---@param extraAttributeType LuaEnumExtraAttributeType 额外属性类型
---@param career LuaEnumCareer 职业
---@return string 百分比为X% 字符串,正常值为X number，空为nil
function cfg_extra_mon_effectManager:GetExtraAttributeValueStr(id, extraAttributeType, career)
    if type(id) ~= 'number' or type(extraAttributeType) ~= 'number' then
        return
    end
    local tbl = self:TryGetValue(id)
    if tbl == nil then
        return
    end
    if extraAttributeType == LuaEnumExtraAttributeType.ExtraDps then
        if tbl:GetExtraDps() and tbl:GetExtraDps() > 0 then
            if tbl:GetExtraDps() > 0 then
                return tbl:GetExtraDps()
            end
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.ExtraDpsPer then
        if tbl:GetExtraDpsPer() and tbl:GetExtraDpsPer() > 0 then
            local rate = Utility.RemoveEndZero(tbl:GetExtraDpsPer() / 100)
            return Utility.CombineStringQuickly(rate, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.Critical then
        if tbl:GetCritical() and tbl:GetCritical() > 0 then
            local rate = Utility.RemoveEndZero(tbl:GetCritical() / 100)
            return Utility.CombineStringQuickly(rate, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.CriticalDamage then
        if tbl:GetCriticalDamage() > 0 then
            return tbl:GetCriticalDamage()
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.HurtReduce then
        if tbl:GetHurtReduce() > 0 then
            return tbl:GetHurtReduce()
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.BloodSuck then
        if tbl:GetBloodSuck() > 0 then
            return tbl:GetBloodSuck()
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.BloodSuckPer then
        if tbl:GetBloodSuckPro() and tbl:GetBloodSuckPro() > 0 then
            local rate = Utility.RemoveEndZero(tbl:GetBloodSuckPro() / 100)
            return Utility.CombineStringQuickly(rate, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.BloodSuckExtra then
        if tbl:GetBloodSuckExtra() > 0 then
            return tbl:GetBloodSuckExtra()
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.PetExtraDps then
        if tbl:GetPetExtraDps() > 0 then
            return tbl:GetPetExtraDps()
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.PetExtraDpsPer then
        if tbl:GetPetExtraDpsPer() and tbl:GetPetExtraDpsPer() > 0 then
            local rate = Utility.RemoveEndZero(tbl:GetPetExtraDpsPer() / 100)
            return Utility.CombineStringQuickly(rate, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.DropPre then
        if tbl:GetDropPro() and tbl:GetDropPro() > 0 then
            local rate = Utility.RemoveEndZero(tbl:GetDropPro() / 1000)
            return Utility.CombineStringQuickly(rate, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.ExtraDpsMax then
        if tbl:GetExtraDpsMax() <= 0 and tbl:GetExtraDpsMax() <= 0 then
            return ""
        end
        if tbl:GetExtraDpsMax() then
            local min = tbl:GetExtraDpsMin()
            local max = tbl:GetExtraDpsMax()
            if min and max then
                return Utility.CombineStringQuickly(min, " - ", max)
            elseif min then
                return min
            elseif max then
                return max
            end
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.ExtraDpsMin then
    elseif extraAttributeType == LuaEnumExtraAttributeType.HurtReduceMax then
        if tbl:GetHurtReduceMax() <= 0 and tbl:GetExtraDps() <= 0 then
            return ""
        end
        if tbl:GetHurtReduceMax() and tbl:GetHurtReduceMax() > 0 then
            local min = tbl:GetHurtReduceMin()
            local max = tbl:GetHurtReduceMax()
            if min and max then
                return Utility.CombineStringQuickly(min, " - ", max)
            elseif min then
                return min
            elseif max then
                return max
            end
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.HurtReduceMin then
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyAttackMax then
        if tbl:GetPhyAttackMin() <= 0 and tbl:GetPhyAttackMax() <= 0 then
            return ""
        end
        if career == LuaEnumCareer.Warrior then
            local min = tbl:GetPhyAttackMin()
            local max = tbl:GetPhyAttackMax()
            if min and max then
                return Utility.CombineStringQuickly(min, " - ", max)
            elseif min then
                return min
            elseif max then
                return max
            end
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyAttackMin then
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicAttackMax then
        if tbl:GetMagicAttackMin() <= 0 and tbl:GetMagicAttackMax() <= 0 then
            return ""
        end
        if career == LuaEnumCareer.Master then
            local min = tbl:GetMagicAttackMin()
            local max = tbl:GetMagicAttackMax()
            if min and max then
                return Utility.CombineStringQuickly(min, " - ", max)
            elseif min then
                return min
            elseif max then
                return max
            end
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicAttackMin then
    elseif extraAttributeType == LuaEnumExtraAttributeType.TaoAttackMax then
        if tbl:GetTaoAttackMin() <= 0 and tbl:GetTaoAttackMax() <= 0 then
            return ""
        end
        if career == LuaEnumCareer.Taoist then
            local min = tbl:GetTaoAttackMin()
            local max = tbl:GetTaoAttackMax()
            if min and max then
                return Utility.CombineStringQuickly(min, " - ", max)
            elseif min then
                return min
            elseif max then
                return max
            end
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.TaoAttackMin then
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyDefenceMax then
        local min = self:GetExtraAttributeValueByCareer(tbl:GetPhyDefenceMinByCareer(), career)
        local max = self:GetExtraAttributeValueByCareer(tbl:GetPhyDefenceMaxByCareer(), career)
        if (min == nil or min <= 0) and (max == nil or max <= 0) then
            return ""
        end
        if min and max then
            return Utility.CombineStringQuickly(min, " - ", max)
        elseif min then
            return min
        elseif max then
            return max
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyDefenceMin then
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicDefenceMax then
        local min = self:GetExtraAttributeValueByCareer(tbl:GetMagicDefenceMinByCareer(), career)
        local max = self:GetExtraAttributeValueByCareer(tbl:GetMagicDefenceMaxByCareer(), career)
        if (min == nil or min <= 0) and (max == nil or max <= 0) then
            return ""
        end
        if min and max then
            return Utility.CombineStringQuickly(min, " - ", max)
        elseif min then
            return min
        elseif max then
            return max
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicDefenceMin then
    elseif extraAttributeType == LuaEnumExtraAttributeType.Hp then
        local value = self:GetExtraAttributeValueByCareer(tbl:GetMaxHp(), career)
        if value == nil or value <= 0 then
            return ""
        end
        return value
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyDefMaxPercent then
        if tbl:GetPhyDefMaxPercent() > 0 then
            local max = Utility.RemoveEndZero(tbl:GetPhyDefMaxPercent() / 100)
            return Utility.CombineStringQuickly(max, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicDefMaxPercent then
        if tbl:GetMagicDefMaxPercent() > 0 then
            local max = Utility.RemoveEndZero(tbl:GetMagicDefMaxPercent() / 100)
            return Utility.CombineStringQuickly(max, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.HpPercent then
        if tbl:GetHpPercent() > 0 then
            local val = Utility.RemoveEndZero(tbl:GetHpPercent() / 100)
            return Utility.CombineStringQuickly(val, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.PenetrationAttributes then
        if tbl:GetPenetrationAttributes() > 0 then
            local val = Utility.RemoveEndZero(tbl:GetPenetrationAttributes() / 100)
            return Utility.CombineStringQuickly(val, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.DivineEquipHurtAdd then
        if tbl:GetDivineEquipHurtAdd() > 0 then
            local val = Utility.RemoveEndZero(tbl:GetDivineEquipHurtAdd() / 100)
            return Utility.CombineStringQuickly(val, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.ResistanceCritical then
        if tbl:GetResistanceCritical() > 0 then
            local val = Utility.RemoveEndZero(tbl:GetResistanceCritical() / 100)
            return Utility.CombineStringQuickly(val, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.DivineEquipSkillAdd then
        if tbl:GetDivineEquipSkillAdd() > 0 then
            local val = Utility.RemoveEndZero(tbl:GetDivineEquipSkillAdd() / 100)
            return Utility.CombineStringQuickly(val, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.CommonCritical then
        if tbl:GetCommonCritical() > 0 then
            local val = Utility.RemoveEndZero(tbl:GetCommonCritical() / 100)
            return Utility.CombineStringQuickly(val, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.Luck then
        if tbl.GetLuck  ~= nil and tbl:GetLuck() > 0 then
            local val = Utility.RemoveEndZero(tbl:GetLuck())
            return tostring(val)
        end
    end
    return ""
end

---获取处理后的额外属性值加基础属性值, 有一些可能不全 如果需要用的话自己再往里加一下 因为会加上items里面的属性 所以这里面数据会很多 在遍历之前先设置好需要哪些数据之后再去取
---取消了攻击魔法和道术的职业判断（别改）
---@param id number 表id
---@param extraAttributeType LuaEnumExtraAttributeType 额外属性类型
---@param career LuaEnumCareer 职业
---@param itemId TABLE.cfg_items
---@return string 百分比为X% 字符串,正常值为X number，空为nil
function cfg_extra_mon_effectManager:GetExtraAttributeValueStrWithItemsTableAttr(id, extraAttributeType, career, itemId)
    if type(id) ~= 'number' or type(extraAttributeType) ~= 'number' or type(itemId) ~= 'number' then
        return
    end
    local tbl = self:TryGetValue(id)
    if tbl == nil then
        return
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil then
        return
    end
    if extraAttributeType == LuaEnumExtraAttributeType.ExtraDps then
        if tbl:GetExtraDps() and tbl:GetExtraDps() > 0 then
            if tbl:GetExtraDps() > 0 then
                return tbl:GetExtraDps()
            end
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.ExtraDpsPer then
        if tbl:GetExtraDpsPer() and tbl:GetExtraDpsPer() > 0 then
            local rate = Utility.RemoveEndZero(tbl:GetExtraDpsPer() / 100)
            return Utility.CombineStringQuickly(rate, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.Critical then
        if tbl:GetCritical() and tbl:GetCritical() > 0 then
            local rate = Utility.RemoveEndZero(tbl:GetCritical() / 100)
            return Utility.CombineStringQuickly(rate, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.CriticalDamage then
        if tbl:GetCriticalDamage() > 0 then
            if itemTbl:GetCriticalDamage() ~= nil then
                return tbl:GetCriticalDamage() + itemTbl:GetCriticalDamage()
            end
            return tbl:GetCriticalDamage()
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.HurtReduce then
        if tbl:GetHurtReduce() > 0 then
            return tbl:GetHurtReduce()
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.BloodSuck then
        if tbl:GetBloodSuck() > 0 then
            return tbl:GetBloodSuck()
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.BloodSuckPer then
        if tbl:GetBloodSuckPro() and tbl:GetBloodSuckPro() > 0 then
            local rate = Utility.RemoveEndZero(tbl:GetBloodSuckPro() / 100)
            return Utility.CombineStringQuickly(rate, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.BloodSuckExtra then
        if tbl:GetBloodSuckExtra() > 0 then
            return tbl:GetBloodSuckExtra()
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.PetExtraDps then
        if tbl:GetPetExtraDps() > 0 then
            return tbl:GetPetExtraDps()
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.PetExtraDpsPer then
        if tbl:GetPetExtraDpsPer() and tbl:GetPetExtraDpsPer() > 0 then
            local rate = Utility.RemoveEndZero(tbl:GetPetExtraDpsPer() / 100)
            return Utility.CombineStringQuickly(rate, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.DropPre then
        if tbl:GetDropPro() and tbl:GetDropPro() > 0 then
            local rate = Utility.RemoveEndZero(tbl:GetDropPro() / 1000)
            return Utility.CombineStringQuickly(rate, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.ExtraDpsMax then
        if tbl:GetExtraDpsMax() <= 0 and tbl:GetExtraDpsMax() <= 0 then
            return ""
        end
        if tbl:GetExtraDpsMax() then
            local min = tbl:GetExtraDpsMin()
            local max = tbl:GetExtraDpsMax()
            if min and max then
                return Utility.CombineStringQuickly(min, " - ", max)
            elseif min then
                return min
            elseif max then
                return max
            end
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.ExtraDpsMin then
    elseif extraAttributeType == LuaEnumExtraAttributeType.HurtReduceMax then
        if tbl:GetHurtReduceMax() <= 0 and tbl:GetExtraDps() <= 0 then
            return ""
        end
        if tbl:GetHurtReduceMax() and tbl:GetHurtReduceMax() > 0 then
            local min = tbl:GetHurtReduceMin()
            local max = tbl:GetHurtReduceMax()
            if min and max then
                return Utility.CombineStringQuickly(min, " - ", max)
            elseif min then
                return min
            elseif max then
                return max
            end
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.HurtReduceMin then
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyAttackMax then
        if tbl:GetPhyAttackMin() <= 0 and tbl:GetPhyAttackMax() <= 0 then
            return ""
        end
        --if career == LuaEnumCareer.Warrior then
            local min = tbl:GetPhyAttackMin() + itemTbl:GetPhyAttackMin()
            local max = tbl:GetPhyAttackMax() + itemTbl:GetPhyAttackMax()
            if min and max then
                return Utility.CombineStringQuickly(min, " - ", max)
            elseif min then
                return min
            elseif max then
                return max
            end
        --end
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyAttackMin then
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicAttackMax then
        if tbl:GetMagicAttackMin() <= 0 and tbl:GetMagicAttackMax() <= 0 then
            return ""
        end
        --if career == LuaEnumCareer.Master then
            local min = tbl:GetMagicAttackMin() + itemTbl:GetMagicAttackMin()
            local max = tbl:GetMagicAttackMax() + itemTbl:GetMagicAttackMax()
            if min and max then
                return Utility.CombineStringQuickly(min, " - ", max)
            elseif min then
                return min
            elseif max then
                return max
            end
        --end
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicAttackMin then
    elseif extraAttributeType == LuaEnumExtraAttributeType.TaoAttackMax then
        if tbl:GetTaoAttackMin() <= 0 and tbl:GetTaoAttackMax() <= 0 then
            return ""
        end
        --if career == LuaEnumCareer.Taoist then
            local min = tbl:GetTaoAttackMin() + itemTbl:GetTaoAttackMin()
            local max = tbl:GetTaoAttackMax() + itemTbl:GetTaoAttackMax()
            if min and max then
                return Utility.CombineStringQuickly(min, " - ", max)
            elseif min then
                return min
            elseif max then
                return max
            end
        --end
    elseif extraAttributeType == LuaEnumExtraAttributeType.TaoAttackMin then
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyDefenceMax then
        local min = self:GetExtraAttributeValueByCareer(tbl:GetPhyDefenceMinByCareer(), career)
        local max = self:GetExtraAttributeValueByCareer(tbl:GetPhyDefenceMaxByCareer(), career)
        if (min == nil or min <= 0) and (max == nil or max <= 0) then
            return ""
        end
        if itemTbl:GetPhyDefenceMin() ~= nil and itemTbl:GetPhyDefenceMax() ~= nil then
            min = min + itemTbl:GetPhyDefenceMin()
            max = max + itemTbl:GetPhyDefenceMax()
        end
        if min and max then
            return Utility.CombineStringQuickly(min, " - ", max)
        elseif min then
            return min
        elseif max then
            return max
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyDefenceMin then
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicDefenceMax then
        local min = self:GetExtraAttributeValueByCareer(tbl:GetMagicDefenceMinByCareer(), career)
        local max = self:GetExtraAttributeValueByCareer(tbl:GetMagicDefenceMaxByCareer(), career)
        if (min == nil or min <= 0) and (max == nil or max <= 0) then
            return ""
        end
        if itemTbl:GetMagicDefenceMin() ~= nil and itemTbl:GetMagicDefenceMax() ~= nil then
            min = min + itemTbl:GetMagicDefenceMin()
            max = max + itemTbl:GetMagicDefenceMax()
        end
        if min and max then
            return Utility.CombineStringQuickly(min, " - ", max)
        elseif min then
            return min
        elseif max then
            return max
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicDefenceMin then
    elseif extraAttributeType == LuaEnumExtraAttributeType.Hp then
        local itemHp =  self:GetExtraAttributeValueByCareer(itemTbl:GetMaxHp(), career)
        local value = self:GetExtraAttributeValueByCareer(tbl:GetMaxHp(), career)
        if value == nil or value <= 0 then
            return ""
        end
        if itemHp ~= nil then
            value = value + itemHp
        end
        return value
    elseif extraAttributeType == LuaEnumExtraAttributeType.PhyDefMaxPercent then
        if tbl:GetPhyDefMaxPercent() > 0 then
            local max = Utility.RemoveEndZero(tbl:GetPhyDefMaxPercent() / 100)
            return Utility.CombineStringQuickly(max, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.MagicDefMaxPercent then
        if tbl:GetMagicDefMaxPercent() > 0 then
            local max = Utility.RemoveEndZero(tbl:GetMagicDefMaxPercent() / 100)
            return Utility.CombineStringQuickly(max, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.HpPercent then
        if tbl:GetHpPercent() > 0 then
            local val = Utility.RemoveEndZero(tbl:GetHpPercent() / 100)
            return Utility.CombineStringQuickly(val, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.PenetrationAttributes then
        if tbl:GetPenetrationAttributes() > 0 then
            local val = Utility.RemoveEndZero(tbl:GetPenetrationAttributes() / 100)
            return Utility.CombineStringQuickly(val, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.DivineEquipHurtAdd then
        if tbl:GetDivineEquipHurtAdd() > 0 then
            local val = Utility.RemoveEndZero(tbl:GetDivineEquipHurtAdd() / 100)
            return Utility.CombineStringQuickly(val, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.ResistanceCritical then
        if tbl:GetResistanceCritical() > 0 then
            local val = Utility.RemoveEndZero(tbl:GetResistanceCritical() / 100)
            return Utility.CombineStringQuickly(val, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.DivineEquipSkillAdd then
        if tbl:GetDivineEquipSkillAdd() > 0 then
            local val = Utility.RemoveEndZero(tbl:GetDivineEquipSkillAdd() / 100)
            return Utility.CombineStringQuickly(val, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.CommonCritical then
        if tbl:GetCommonCritical() > 0 then
            local val = Utility.RemoveEndZero(tbl:GetCommonCritical() / 100)
            return Utility.CombineStringQuickly(val, "%")
        end
    elseif extraAttributeType == LuaEnumExtraAttributeType.Luck then
        if tbl.GetLuck  ~= nil and tbl:GetLuck() > 0 then
            local val = Utility.RemoveEndZero(tbl:GetLuck())
            return tostring(val)
        end
    end
    return ""
end

--endregion

return cfg_extra_mon_effectManager