--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_extra_mon_effect
local cfg_extra_mon_effect = {}

cfg_extra_mon_effect.__index = cfg_extra_mon_effect

function cfg_extra_mon_effect:UUID()
    return self.id
end

---@return number id#客户端  id
function cfg_extra_mon_effect:GetId()
    if self.id ~= nil then
        return self.id
    else
        if self:CsTABLE() ~= nil then
            self.id = self:CsTABLE().id
            return self.id
        else
            return nil
        end
    end
end

---@return number boss类型#客户端  boss类型，monster表中的怪物类型
function cfg_extra_mon_effect:GetBossType()
    if self.bossType ~= nil then
        return self.bossType
    else
        if self:CsTABLE() ~= nil then
            self.bossType = self:CsTABLE().bossType
            return self.bossType
        else
            return nil
        end
    end
end

---@return number 额外伤害#客户端  额外伤害结果
function cfg_extra_mon_effect:GetExtraDps()
    if self.extraDps ~= nil then
        return self.extraDps
    else
        if self:CsTABLE() ~= nil then
            self.extraDps = self:CsTABLE().extraDps
            return self.extraDps
        else
            return nil
        end
    end
end

---@return string 额外伤害显示#客户端  额外伤害结果显示
function cfg_extra_mon_effect:GetExtraDpsDes()
    if self.extraDpsDes ~= nil then
        return self.extraDpsDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().extraDpsDes
        else
            return nil
        end
    end
end

---@return number 额外比例伤害#客户端  额外比例伤害，万分数
function cfg_extra_mon_effect:GetExtraDpsPer()
    if self.extraDpsPer ~= nil then
        return self.extraDpsPer
    else
        if self:CsTABLE() ~= nil then
            self.extraDpsPer = self:CsTABLE().extraDpsPer
            return self.extraDpsPer
        else
            return nil
        end
    end
end

---@return string 额外比例伤害描述#客户端  额外比例伤害描述
function cfg_extra_mon_effect:GetExtraDpsPerDes()
    if self.extraDpsPerDes ~= nil then
        return self.extraDpsPerDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().extraDpsPerDes
        else
            return nil
        end
    end
end

---@return number 暴击率#客户端  暴击率，万分数
function cfg_extra_mon_effect:GetCritical()
    if self.critical ~= nil then
        return self.critical
    else
        if self:CsTABLE() ~= nil then
            self.critical = self:CsTABLE().critical
            return self.critical
        else
            return nil
        end
    end
end

---@return string 暴击显示#客户端  暴击显示
function cfg_extra_mon_effect:GetCriticalDes()
    if self.criticalDes ~= nil then
        return self.criticalDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().criticalDes
        else
            return nil
        end
    end
end

---@return number 暴击伤害#客户端  暴击伤害
function cfg_extra_mon_effect:GetCriticalDamage()
    if self.criticalDamage ~= nil then
        return self.criticalDamage
    else
        if self:CsTABLE() ~= nil then
            self.criticalDamage = self:CsTABLE().criticalDamage
            return self.criticalDamage
        else
            return nil
        end
    end
end

---@return string 暴击伤害显示#客户端  暴击伤害显示
function cfg_extra_mon_effect:GetCriticalDamageDes()
    if self.criticalDamageDes ~= nil then
        return self.criticalDamageDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().criticalDamageDes
        else
            return nil
        end
    end
end

---@return number 伤害减免#客户端  伤害减免
function cfg_extra_mon_effect:GetHurtReduce()
    if self.hurtReduce ~= nil then
        return self.hurtReduce
    else
        if self:CsTABLE() ~= nil then
            self.hurtReduce = self:CsTABLE().hurtReduce
            return self.hurtReduce
        else
            return nil
        end
    end
end

---@return string 伤害减免显示#客户端  伤害减免显示
function cfg_extra_mon_effect:GetHurtReduceDes()
    if self.hurtReduceDes ~= nil then
        return self.hurtReduceDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().hurtReduceDes
        else
            return nil
        end
    end
end

---@return number 吸血#客户端   额外吸血量  在概率触发时增加此吸血量
function cfg_extra_mon_effect:GetBloodSuck()
    if self.bloodSuck ~= nil then
        return self.bloodSuck
    else
        if self:CsTABLE() ~= nil then
            self.bloodSuck = self:CsTABLE().bloodSuck
            return self.bloodSuck
        else
            return nil
        end
    end
end

---@return string 吸血显示#客户端  吸血显示
function cfg_extra_mon_effect:GetBloodSuckDes()
    if self.bloodSuckDes ~= nil then
        return self.bloodSuckDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().bloodSuckDes
        else
            return nil
        end
    end
end

---@return number 吸血概率#客户端  攻击吸血概率  万分数
function cfg_extra_mon_effect:GetBloodSuckPro()
    if self.bloodSuckPro ~= nil then
        return self.bloodSuckPro
    else
        if self:CsTABLE() ~= nil then
            self.bloodSuckPro = self:CsTABLE().bloodSuckPro
            return self.bloodSuckPro
        else
            return nil
        end
    end
end

---@return string 吸血概率显示#客户端  吸血概率显示
function cfg_extra_mon_effect:GetBloodSuckProDes()
    if self.bloodSuckProDes ~= nil then
        return self.bloodSuckProDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().bloodSuckProDes
        else
            return nil
        end
    end
end

---@return number 攻击吸血量#客户端  吸血，攻击即回血
function cfg_extra_mon_effect:GetBloodSuckExtra()
    if self.bloodSuckExtra ~= nil then
        return self.bloodSuckExtra
    else
        if self:CsTABLE() ~= nil then
            self.bloodSuckExtra = self:CsTABLE().bloodSuckExtra
            return self.bloodSuckExtra
        else
            return nil
        end
    end
end

---@return string 额外吸血量显示#客户端
function cfg_extra_mon_effect:GetBloodSuckExtraDes()
    if self.bloodSuckExtraDes ~= nil then
        return self.bloodSuckExtraDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().bloodSuckExtraDes
        else
            return nil
        end
    end
end

---@return number 灵兽额外伤害#客户端  灵兽额外伤害
function cfg_extra_mon_effect:GetPetExtraDps()
    if self.petExtraDps ~= nil then
        return self.petExtraDps
    else
        if self:CsTABLE() ~= nil then
            self.petExtraDps = self:CsTABLE().petExtraDps
            return self.petExtraDps
        else
            return nil
        end
    end
end

---@return string 灵兽额外伤害显示#客户端  灵兽额外伤害显示
function cfg_extra_mon_effect:GetPetExtraDpsDes()
    if self.petExtraDpsDes ~= nil then
        return self.petExtraDpsDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().petExtraDpsDes
        else
            return nil
        end
    end
end

---@return number 灵兽额外比例伤害#客户端  灵兽额外比例伤害，万分数
function cfg_extra_mon_effect:GetPetExtraDpsPer()
    if self.petExtraDpsPer ~= nil then
        return self.petExtraDpsPer
    else
        if self:CsTABLE() ~= nil then
            self.petExtraDpsPer = self:CsTABLE().petExtraDpsPer
            return self.petExtraDpsPer
        else
            return nil
        end
    end
end

---@return string 灵兽额外比例伤害描述#客户端  灵兽额外比例伤害描述
function cfg_extra_mon_effect:GetPetExtraDpsPerDes()
    if self.petExtraDpsPerDes ~= nil then
        return self.petExtraDpsPerDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().petExtraDpsPerDes
        else
            return nil
        end
    end
end

---@return number 掉率#客户端  掉率，十万分数
function cfg_extra_mon_effect:GetDropPro()
    if self.dropPro ~= nil then
        return self.dropPro
    else
        if self:CsTABLE() ~= nil then
            self.dropPro = self:CsTABLE().dropPro
            return self.dropPro
        else
            return nil
        end
    end
end

---@return string 掉率显示#客户端  掉率显示
function cfg_extra_mon_effect:GetDropProDes()
    if self.dropProDes ~= nil then
        return self.dropProDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().dropProDes
        else
            return nil
        end
    end
end

---@return number 额外伤害上限#客户端  额外伤害上限
function cfg_extra_mon_effect:GetExtraDpsMax()
    if self.extraDpsMax ~= nil then
        return self.extraDpsMax
    else
        if self:CsTABLE() ~= nil then
            self.extraDpsMax = self:CsTABLE().extraDpsMax
            return self.extraDpsMax
        else
            return nil
        end
    end
end

---@return number 额外伤害下限#客户端  额外伤害下限
function cfg_extra_mon_effect:GetExtraDpsMin()
    if self.extraDpsMin ~= nil then
        return self.extraDpsMin
    else
        if self:CsTABLE() ~= nil then
            self.extraDpsMin = self:CsTABLE().extraDpsMin
            return self.extraDpsMin
        else
            return nil
        end
    end
end

---@return string 额外伤害上下限描述#客户端  额外伤害上下限描述
function cfg_extra_mon_effect:GetExtraDpsMaxDes()
    if self.extraDpsMaxDes ~= nil then
        return self.extraDpsMaxDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().extraDpsMaxDes
        else
            return nil
        end
    end
end

---@return number 额外减伤上限#客户端  额外减伤上限
function cfg_extra_mon_effect:GetHurtReduceMax()
    if self.hurtReduceMax ~= nil then
        return self.hurtReduceMax
    else
        if self:CsTABLE() ~= nil then
            self.hurtReduceMax = self:CsTABLE().hurtReduceMax
            return self.hurtReduceMax
        else
            return nil
        end
    end
end

---@return number 额外减伤下限#客户端  额外减伤下限
function cfg_extra_mon_effect:GetHurtReduceMin()
    if self.hurtReduceMin ~= nil then
        return self.hurtReduceMin
    else
        if self:CsTABLE() ~= nil then
            self.hurtReduceMin = self:CsTABLE().hurtReduceMin
            return self.hurtReduceMin
        else
            return nil
        end
    end
end

---@return string 额外减伤上下限描述#客户端
function cfg_extra_mon_effect:GetHurtReduceMinDes()
    if self.hurtReduceMinDes ~= nil then
        return self.hurtReduceMinDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().hurtReduceMinDes
        else
            return nil
        end
    end
end

---@return number 最大物攻#客户端  最大物理攻击
function cfg_extra_mon_effect:GetPhyAttackMax()
    if self.phyAttackMax ~= nil then
        return self.phyAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.phyAttackMax = self:CsTABLE().phyAttackMax
            return self.phyAttackMax
        else
            return nil
        end
    end
end

---@return string 最大物攻显示#客户端  最大物理攻击描述
function cfg_extra_mon_effect:GetPhyAttackMaxDes()
    if self.phyAttackMaxDes ~= nil then
        return self.phyAttackMaxDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().phyAttackMaxDes
        else
            return nil
        end
    end
end

---@return number 最小物攻#客户端  最小物理攻击
function cfg_extra_mon_effect:GetPhyAttackMin()
    if self.phyAttackMin ~= nil then
        return self.phyAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.phyAttackMin = self:CsTABLE().phyAttackMin
            return self.phyAttackMin
        else
            return nil
        end
    end
end

---@return string 最小物攻显示#客户端  最小物理攻击描述
function cfg_extra_mon_effect:GetPhyAttackMinDes()
    if self.phyAttackMinDes ~= nil then
        return self.phyAttackMinDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().phyAttackMinDes
        else
            return nil
        end
    end
end

---@return number 最大法攻#客户端  最大魔法攻击
function cfg_extra_mon_effect:GetMagicAttackMax()
    if self.magicAttackMax ~= nil then
        return self.magicAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.magicAttackMax = self:CsTABLE().magicAttackMax
            return self.magicAttackMax
        else
            return nil
        end
    end
end

---@return string 最大魔法攻击显示#客户端  最大魔法攻击描述
function cfg_extra_mon_effect:GetMagicAttackMaxDes()
    if self.magicAttackMaxDes ~= nil then
        return self.magicAttackMaxDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().magicAttackMaxDes
        else
            return nil
        end
    end
end

---@return number 最小法攻#客户端  最小魔法攻击
function cfg_extra_mon_effect:GetMagicAttackMin()
    if self.magicAttackMin ~= nil then
        return self.magicAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.magicAttackMin = self:CsTABLE().magicAttackMin
            return self.magicAttackMin
        else
            return nil
        end
    end
end

---@return string 最小法攻显示#客户端  最小魔法攻击描述
function cfg_extra_mon_effect:GetMagicAttackMinDes()
    if self.magicAttackMinDes ~= nil then
        return self.magicAttackMinDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().magicAttackMinDes
        else
            return nil
        end
    end
end

---@return number 最大道术攻#客户端  最大道术攻击
function cfg_extra_mon_effect:GetTaoAttackMax()
    if self.taoAttackMax ~= nil then
        return self.taoAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.taoAttackMax = self:CsTABLE().taoAttackMax
            return self.taoAttackMax
        else
            return nil
        end
    end
end

---@return string 最大道攻显示#客户端  最大道术攻击描述
function cfg_extra_mon_effect:GetTaoAttackMaxDes()
    if self.taoAttackMaxDes ~= nil then
        return self.taoAttackMaxDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().taoAttackMaxDes
        else
            return nil
        end
    end
end

---@return number 最小道攻#客户端  最小道术攻击
function cfg_extra_mon_effect:GetTaoAttackMin()
    if self.taoAttackMin ~= nil then
        return self.taoAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.taoAttackMin = self:CsTABLE().taoAttackMin
            return self.taoAttackMin
        else
            return nil
        end
    end
end

---@return string 最小道攻#客户端  最小道术攻击描述
function cfg_extra_mon_effect:GetTaoAttackMinDes()
    if self.taoAttackMinDes ~= nil then
        return self.taoAttackMinDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().taoAttackMinDes
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 最大物防#客户端  最大物防  战#法#道
function cfg_extra_mon_effect:GetPhyDefenceMaxByCareer()
    if self.phyDefenceMaxByCareer ~= nil then
        return self.phyDefenceMaxByCareer
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().phyDefenceMaxByCareer
        else
            return nil
        end
    end
end

---@return string 最大物防显示#客户端  最大物防描述
function cfg_extra_mon_effect:GetPhyDefenceMaxDes()
    if self.phyDefenceMaxDes ~= nil then
        return self.phyDefenceMaxDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().phyDefenceMaxDes
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 最小物防#客户端  最小物防
function cfg_extra_mon_effect:GetPhyDefenceMinByCareer()
    if self.phyDefenceMinByCareer ~= nil then
        return self.phyDefenceMinByCareer
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().phyDefenceMinByCareer
        else
            return nil
        end
    end
end

---@return string 最小物防显示#客户端  最小物防描述
function cfg_extra_mon_effect:GetPhyDefenceMinDes()
    if self.phyDefenceMinDes ~= nil then
        return self.phyDefenceMinDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().phyDefenceMinDes
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 最大魔防#客户端  最大魔防
function cfg_extra_mon_effect:GetMagicDefenceMaxByCareer()
    if self.magicDefenceMaxByCareer ~= nil then
        return self.magicDefenceMaxByCareer
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().magicDefenceMaxByCareer
        else
            return nil
        end
    end
end

---@return string 最大魔防显示#客户端  最大魔防描述
function cfg_extra_mon_effect:GetMagicDefenceMaxDes()
    if self.magicDefenceMaxDes ~= nil then
        return self.magicDefenceMaxDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().magicDefenceMaxDes
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 最小魔防#客户端  最小魔防
function cfg_extra_mon_effect:GetMagicDefenceMinByCareer()
    if self.magicDefenceMinByCareer ~= nil then
        return self.magicDefenceMinByCareer
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().magicDefenceMinByCareer
        else
            return nil
        end
    end
end

---@return string 最小魔防显示#客户端  最小魔防描述
function cfg_extra_mon_effect:GetMagicDefenceMinDes()
    if self.magicDefenceMinDes ~= nil then
        return self.magicDefenceMinDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().magicDefenceMinDes
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 生命值#客户端  生命值  战#法#道
function cfg_extra_mon_effect:GetMaxHp()
    if self.maxHp ~= nil then
        return self.maxHp
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().maxHp
        else
            return nil
        end
    end
end

---@return string 生命值#客户端  生命值描述
function cfg_extra_mon_effect:GetMaxHpDes()
    if self.maxHpDes ~= nil then
        return self.maxHpDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().maxHpDes
        else
            return nil
        end
    end
end

---@return number 百分比最大物防#客户端  百分比最大物防，万分数
function cfg_extra_mon_effect:GetPhyDefMaxPercent()
    if self.phyDefMaxPercent ~= nil then
        return self.phyDefMaxPercent
    else
        if self:CsTABLE() ~= nil then
            self.phyDefMaxPercent = self:CsTABLE().phyDefMaxPercent
            return self.phyDefMaxPercent
        else
            return nil
        end
    end
end

---@return number 百分比最小物防#客户端  百分比最小物防，万分数
function cfg_extra_mon_effect:GetPhyDefMinPercent()
    if self.phyDefMinPercent ~= nil then
        return self.phyDefMinPercent
    else
        if self:CsTABLE() ~= nil then
            self.phyDefMinPercent = self:CsTABLE().phyDefMinPercent
            return self.phyDefMinPercent
        else
            return nil
        end
    end
end

---@return string 百分比物防#客户端  百分比物防显示，取最大物防百分比显示即可  显示为百分数
function cfg_extra_mon_effect:GetPhyDefPercentDes()
    if self.phyDefPercentDes ~= nil then
        return self.phyDefPercentDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().phyDefPercentDes
        else
            return nil
        end
    end
end

---@return number 百分比最大魔防#客户端  百分比最大魔防，万分数
function cfg_extra_mon_effect:GetMagicDefMaxPercent()
    if self.magicDefMaxPercent ~= nil then
        return self.magicDefMaxPercent
    else
        if self:CsTABLE() ~= nil then
            self.magicDefMaxPercent = self:CsTABLE().magicDefMaxPercent
            return self.magicDefMaxPercent
        else
            return nil
        end
    end
end

---@return number 百分比最小魔防#客户端  百分比最小魔防，万分数
function cfg_extra_mon_effect:GetMagicDefMinPercent()
    if self.magicDefMinPercent ~= nil then
        return self.magicDefMinPercent
    else
        if self:CsTABLE() ~= nil then
            self.magicDefMinPercent = self:CsTABLE().magicDefMinPercent
            return self.magicDefMinPercent
        else
            return nil
        end
    end
end

---@return string 百分比魔防#客户端  百分比魔防显示，取最大魔防百分比显示即可  显示为百分数
function cfg_extra_mon_effect:GetMagicDefPercentDes()
    if self.magicDefPercentDes ~= nil then
        return self.magicDefPercentDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().magicDefPercentDes
        else
            return nil
        end
    end
end

---@return number 百分比血量#客户端  百分比血量 万分数
function cfg_extra_mon_effect:GetHpPercent()
    if self.hpPercent ~= nil then
        return self.hpPercent
    else
        if self:CsTABLE() ~= nil then
            self.hpPercent = self:CsTABLE().hpPercent
            return self.hpPercent
        else
            return nil
        end
    end
end

---@return string 百分比血量#客户端  百分比血量，显示为百分数
function cfg_extra_mon_effect:GetHpPercentDes()
    if self.hpPercentDes ~= nil then
        return self.hpPercentDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().hpPercentDes
        else
            return nil
        end
    end
end

---@return number 穿透#客户端  穿透，万分数
function cfg_extra_mon_effect:GetPenetrationAttributes()
    if self.penetrationAttributes ~= nil then
        return self.penetrationAttributes
    else
        if self:CsTABLE() ~= nil then
            self.penetrationAttributes = self:CsTABLE().penetrationAttributes
            return self.penetrationAttributes
        else
            return nil
        end
    end
end

---@return string 穿透#客户端  穿透，显示为百分数
function cfg_extra_mon_effect:GetPenetrationAttributesDes()
    if self.penetrationAttributesDes ~= nil then
        return self.penetrationAttributesDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().penetrationAttributesDes
        else
            return nil
        end
    end
end

---@return number 百分比伤害#客户端  百分比伤害，万分数
function cfg_extra_mon_effect:GetDivineEquipHurtAdd()
    if self.divineEquipHurtAdd ~= nil then
        return self.divineEquipHurtAdd
    else
        if self:CsTABLE() ~= nil then
            self.divineEquipHurtAdd = self:CsTABLE().divineEquipHurtAdd
            return self.divineEquipHurtAdd
        else
            return nil
        end
    end
end

---@return string 百分比伤害#客户端  百分比伤害，显示为百分数
function cfg_extra_mon_effect:GetDivineEquipHurtAddDes()
    if self.divineEquipHurtAddDes ~= nil then
        return self.divineEquipHurtAddDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().divineEquipHurtAddDes
        else
            return nil
        end
    end
end

---@return number 暴击抵抗#客户端  暴击抵抗，万分数
function cfg_extra_mon_effect:GetResistanceCritical()
    if self.resistanceCritical ~= nil then
        return self.resistanceCritical
    else
        if self:CsTABLE() ~= nil then
            self.resistanceCritical = self:CsTABLE().resistanceCritical
            return self.resistanceCritical
        else
            return nil
        end
    end
end

---@return string 暴击抵抗#客户端  暴击抵抗，显示为百分数
function cfg_extra_mon_effect:GetResistanceCriticalDes()
    if self.resistanceCriticalDes ~= nil then
        return self.resistanceCriticalDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().resistanceCriticalDes
        else
            return nil
        end
    end
end

---@return number 技能伤害百分比#客户端  技能伤害百分比 万分数
function cfg_extra_mon_effect:GetDivineEquipSkillAdd()
    if self.divineEquipSkillAdd ~= nil then
        return self.divineEquipSkillAdd
    else
        if self:CsTABLE() ~= nil then
            self.divineEquipSkillAdd = self:CsTABLE().divineEquipSkillAdd
            return self.divineEquipSkillAdd
        else
            return nil
        end
    end
end

---@return string 技能伤害百分比#客户端  技能伤害百分比，显示为百分数
function cfg_extra_mon_effect:GetDivineEquipSkillAddDes()
    if self.divineEquipSkillAddDes ~= nil then
        return self.divineEquipSkillAddDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().divineEquipSkillAddDes
        else
            return nil
        end
    end
end

---@return number 暴击率#客户端  暴击，万分数 显示为百分比
function cfg_extra_mon_effect:GetCommonCritical()
    if self.commonCritical ~= nil then
        return self.commonCritical
    else
        if self:CsTABLE() ~= nil then
            self.commonCritical = self:CsTABLE().commonCritical
            return self.commonCritical
        else
            return nil
        end
    end
end

---@return string 暴击率#客户端  暴击，万分数 显示为百分比
function cfg_extra_mon_effect:GetCommonCriticalDes()
    if self.commonCriticalDes ~= nil then
        return self.commonCriticalDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().commonCriticalDes
        else
            return nil
        end
    end
end

---@return number 幸运#客户端  属性
function cfg_extra_mon_effect:GetLuck()
    if self.luck ~= nil then
        return self.luck
    else
        if self:CsTABLE() ~= nil then
            self.luck = self:CsTABLE().luck
            return self.luck
        else
            return nil
        end
    end
end

---@return string 幸运#客户端  显示
function cfg_extra_mon_effect:GetLuckDes()
    if self.luckDes ~= nil then
        return self.luckDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().luckDes
        else
            return nil
        end
    end
end

---@return number 暴击伤害抵抗#客户端  暴击伤害抵抗 属性值
function cfg_extra_mon_effect:GetResistCriticalDamage()
    if self.resistCriticalDamage ~= nil then
        return self.resistCriticalDamage
    else
        if self:CsTABLE() ~= nil then
            self.resistCriticalDamage = self:CsTABLE().resistCriticalDamage
            return self.resistCriticalDamage
        else
            return nil
        end
    end
end

---@return string 暴击伤害抵抗#客户端  暴击伤害抵抗
function cfg_extra_mon_effect:GetResistCriticalDamageDes()
    if self.resistCriticalDamageDes ~= nil then
        return self.resistCriticalDamageDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().resistCriticalDamageDes
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_EXTRA_MON_EFFECT C#中的数据结构
function cfg_extra_mon_effect:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_extra_mon_effect lua中的数据结构
function cfg_extra_mon_effect:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.bossType = decodedData.bossType
    
    ---@private
    self.extraDps = decodedData.extraDps
    
    ---@private
    self.extraDpsDes = decodedData.extraDpsDes
    
    ---@private
    self.extraDpsPer = decodedData.extraDpsPer
    
    ---@private
    self.extraDpsPerDes = decodedData.extraDpsPerDes
    
    ---@private
    self.critical = decodedData.critical
    
    ---@private
    self.criticalDes = decodedData.criticalDes
    
    ---@private
    self.criticalDamage = decodedData.criticalDamage
    
    ---@private
    self.criticalDamageDes = decodedData.criticalDamageDes
    
    ---@private
    self.hurtReduce = decodedData.hurtReduce
    
    ---@private
    self.hurtReduceDes = decodedData.hurtReduceDes
    
    ---@private
    self.bloodSuck = decodedData.bloodSuck
    
    ---@private
    self.bloodSuckDes = decodedData.bloodSuckDes
    
    ---@private
    self.bloodSuckPro = decodedData.bloodSuckPro
    
    ---@private
    self.bloodSuckProDes = decodedData.bloodSuckProDes
    
    ---@private
    self.bloodSuckExtra = decodedData.bloodSuckExtra
    
    ---@private
    self.bloodSuckExtraDes = decodedData.bloodSuckExtraDes
    
    ---@private
    self.petExtraDps = decodedData.petExtraDps
    
    ---@private
    self.petExtraDpsDes = decodedData.petExtraDpsDes
    
    ---@private
    self.petExtraDpsPer = decodedData.petExtraDpsPer
    
    ---@private
    self.petExtraDpsPerDes = decodedData.petExtraDpsPerDes
    
    ---@private
    self.dropPro = decodedData.dropPro
    
    ---@private
    self.dropProDes = decodedData.dropProDes
    
    ---@private
    self.extraDpsMax = decodedData.extraDpsMax
    
    ---@private
    self.extraDpsMin = decodedData.extraDpsMin
    
    ---@private
    self.extraDpsMaxDes = decodedData.extraDpsMaxDes
    
    ---@private
    self.hurtReduceMax = decodedData.hurtReduceMax
    
    ---@private
    self.hurtReduceMin = decodedData.hurtReduceMin
    
    ---@private
    self.hurtReduceMinDes = decodedData.hurtReduceMinDes
    
    ---@private
    self.phyAttackMax = decodedData.phyAttackMax
    
    ---@private
    self.phyAttackMaxDes = decodedData.phyAttackMaxDes
    
    ---@private
    self.phyAttackMin = decodedData.phyAttackMin
    
    ---@private
    self.phyAttackMinDes = decodedData.phyAttackMinDes
    
    ---@private
    self.magicAttackMax = decodedData.magicAttackMax
    
    ---@private
    self.magicAttackMaxDes = decodedData.magicAttackMaxDes
    
    ---@private
    self.magicAttackMin = decodedData.magicAttackMin
    
    ---@private
    self.magicAttackMinDes = decodedData.magicAttackMinDes
    
    ---@private
    self.taoAttackMax = decodedData.taoAttackMax
    
    ---@private
    self.taoAttackMaxDes = decodedData.taoAttackMaxDes
    
    ---@private
    self.taoAttackMin = decodedData.taoAttackMin
    
    ---@private
    self.taoAttackMinDes = decodedData.taoAttackMinDes
    
    ---@private
    self.phyDefenceMaxByCareer = decodedData.phyDefenceMaxByCareer
    
    ---@private
    self.phyDefenceMaxDes = decodedData.phyDefenceMaxDes
    
    ---@private
    self.phyDefenceMinByCareer = decodedData.phyDefenceMinByCareer
    
    ---@private
    self.phyDefenceMinDes = decodedData.phyDefenceMinDes
    
    ---@private
    self.magicDefenceMaxByCareer = decodedData.magicDefenceMaxByCareer
    
    ---@private
    self.magicDefenceMaxDes = decodedData.magicDefenceMaxDes
    
    ---@private
    self.magicDefenceMinByCareer = decodedData.magicDefenceMinByCareer
    
    ---@private
    self.magicDefenceMinDes = decodedData.magicDefenceMinDes
    
    ---@private
    self.maxHp = decodedData.maxHp
    
    ---@private
    self.maxHpDes = decodedData.maxHpDes
    
    ---@private
    self.phyDefMaxPercent = decodedData.phyDefMaxPercent
    
    ---@private
    self.phyDefMinPercent = decodedData.phyDefMinPercent
    
    ---@private
    self.phyDefPercentDes = decodedData.phyDefPercentDes
    
    ---@private
    self.magicDefMaxPercent = decodedData.magicDefMaxPercent
    
    ---@private
    self.magicDefMinPercent = decodedData.magicDefMinPercent
    
    ---@private
    self.magicDefPercentDes = decodedData.magicDefPercentDes
    
    ---@private
    self.hpPercent = decodedData.hpPercent
    
    ---@private
    self.hpPercentDes = decodedData.hpPercentDes
    
    ---@private
    self.penetrationAttributes = decodedData.penetrationAttributes
    
    ---@private
    self.penetrationAttributesDes = decodedData.penetrationAttributesDes
    
    ---@private
    self.divineEquipHurtAdd = decodedData.divineEquipHurtAdd
    
    ---@private
    self.divineEquipHurtAddDes = decodedData.divineEquipHurtAddDes
    
    ---@private
    self.resistanceCritical = decodedData.resistanceCritical
    
    ---@private
    self.resistanceCriticalDes = decodedData.resistanceCriticalDes
    
    ---@private
    self.divineEquipSkillAdd = decodedData.divineEquipSkillAdd
    
    ---@private
    self.divineEquipSkillAddDes = decodedData.divineEquipSkillAddDes
    
    ---@private
    self.commonCritical = decodedData.commonCritical
    
    ---@private
    self.commonCriticalDes = decodedData.commonCriticalDes
    
    ---@private
    self.luck = decodedData.luck
    
    ---@private
    self.luckDes = decodedData.luckDes
    
    ---@private
    self.resistCriticalDamage = decodedData.resistCriticalDamage
    
    ---@private
    self.resistCriticalDamageDes = decodedData.resistCriticalDamageDes
end

return cfg_extra_mon_effect