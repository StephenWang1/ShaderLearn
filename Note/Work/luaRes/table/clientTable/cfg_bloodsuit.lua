--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_bloodsuit
local cfg_bloodsuit = {}

cfg_bloodsuit.__index = cfg_bloodsuit

function cfg_bloodsuit:UUID()
    return self.itemid
end

---@return number 道具id#客户端  道具id
function cfg_bloodsuit:GetItemid()
    if self.itemid ~= nil then
        return self.itemid
    else
        if self:CsTABLE() ~= nil then
            self.itemid = self:CsTABLE().itemid
            return self.itemid
        else
            return nil
        end
    end
end

---@return number 品级#客户端  品级
function cfg_bloodsuit:GetQualityLevel()
    if self.qualityLevel ~= nil then
        return self.qualityLevel
    else
        if self:CsTABLE() ~= nil then
            self.qualityLevel = self:CsTABLE().qualityLevel
            return self.qualityLevel
        else
            return nil
        end
    end
end

---@return string 品级名称#客户端  品级名称
function cfg_bloodsuit:GetQualityName()
    if self.qualityName ~= nil then
        return self.qualityName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().qualityName
        else
            return nil
        end
    end
end

---@return number 同品级优先级#客户端  同品级优先级
function cfg_bloodsuit:GetPriority()
    if self.priority ~= nil then
        return self.priority
    else
        if self:CsTABLE() ~= nil then
            self.priority = self:CsTABLE().priority
            return self.priority
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 血量#客户端  战士#法师#道士
function cfg_bloodsuit:GetMaxHp()
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

---@return number 最大物理攻击#客户端  最大物理攻击
function cfg_bloodsuit:GetPhyAttackMax()
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

---@return number 最小物理攻击#客户端  最小物理攻击
function cfg_bloodsuit:GetPhyAttackMin()
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

---@return number 最大魔法#客户端  最大魔法
function cfg_bloodsuit:GetMagicAttackMax()
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

---@return number 最小魔法#客户端  最小魔法
function cfg_bloodsuit:GetMagicAttackMin()
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

---@return number 最大道术#客户端  最大道术
function cfg_bloodsuit:GetTaoAttackMax()
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

---@return number 最小道术#客户端  最小道术
function cfg_bloodsuit:GetTaoAttackMin()
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

---@return TABLE.IntListJingHao 最大物理防御#客户端  战士#法师#道士
function cfg_bloodsuit:GetPhyDefenceMaxByCareer()
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

---@return TABLE.IntListJingHao 最小物理防御#客户端  战士#法师#道士
function cfg_bloodsuit:GetPhyDefenceMinByCareer()
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

---@return TABLE.IntListJingHao 最大魔法防御#客户端  战士#法师#道士
function cfg_bloodsuit:GetMagicDefenceMaxByCareer()
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

---@return TABLE.IntListJingHao 最小魔法防御#客户端  战士#法师#道士
function cfg_bloodsuit:GetMagicDefenceMinByCareer()
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

---@return number 最大神圣攻击#客户端  最大神圣攻击
function cfg_bloodsuit:GetHolyAttackMax()
    if self.holyAttackMax ~= nil then
        return self.holyAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.holyAttackMax = self:CsTABLE().holyAttackMax
            return self.holyAttackMax
        else
            return nil
        end
    end
end

---@return number 最小神圣攻击#客户端  最小神圣攻击
function cfg_bloodsuit:GetHolyAttackMin()
    if self.holyAttackMin ~= nil then
        return self.holyAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.holyAttackMin = self:CsTABLE().holyAttackMin
            return self.holyAttackMin
        else
            return nil
        end
    end
end

---@return number 最大神圣防御#客户端#不存在共同参与合并的字段  属性
function cfg_bloodsuit:GetHolyDefenceMax()
    if self.holyDefenceMax ~= nil then
        return self.holyDefenceMax
    else
        if self:CsTABLE() ~= nil then
            self.holyDefenceMax = self:CsTABLE().holyDefenceMax
            return self.holyDefenceMax
        else
            return nil
        end
    end
end

---@return number 最小神圣防御#客户端#不存在共同参与合并的字段  属性
function cfg_bloodsuit:GetHolyDefenceMin()
    if self.holyDefenceMin ~= nil then
        return self.holyDefenceMin
    else
        if self:CsTABLE() ~= nil then
            self.holyDefenceMin = self:CsTABLE().holyDefenceMin
            return self.holyDefenceMin
        else
            return nil
        end
    end
end

---@return number 暴击伤害#客户端  暴击伤害
function cfg_bloodsuit:GetCriticalDamage()
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

---@return number 熔炼经验#客户端  熔炼经验
function cfg_bloodsuit:GetSmeltExp()
    if self.smeltExp ~= nil then
        return self.smeltExp
    else
        if self:CsTABLE() ~= nil then
            self.smeltExp = self:CsTABLE().smeltExp
            return self.smeltExp
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 可熔炼道具#客户端  可熔炼道具
function cfg_bloodsuit:GetSmeltItem()
    if self.smeltItem ~= nil then
        return self.smeltItem
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().smeltItem
        else
            return nil
        end
    end
end

---@return number 是否可穿戴#客户端  0可穿1不可穿
function cfg_bloodsuit:GetIsUse()
    if self.isUse ~= nil then
        return self.isUse
    else
        if self:CsTABLE() ~= nil then
            self.isUse = self:CsTABLE().isUse
            return self.isUse
        else
            return nil
        end
    end
end

---@return number 血继类型#客户端  1灵兽2肉身
function cfg_bloodsuit:GetType()
    if self.type ~= nil then
        return self.type
    else
        if self:CsTABLE() ~= nil then
            self.type = self:CsTABLE().type
            return self.type
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_BLOODSUIT C#中的数据结构
function cfg_bloodsuit:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_bloodsuit lua中的数据结构
function cfg_bloodsuit:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.itemid = decodedData.itemid
    
    ---@private
    self.qualityLevel = decodedData.qualityLevel
    
    ---@private
    self.qualityName = decodedData.qualityName
    
    ---@private
    self.priority = decodedData.priority
    
    ---@private
    self.maxHp = decodedData.maxHp
    
    ---@private
    self.phyAttackMax = decodedData.phyAttackMax
    
    ---@private
    self.phyAttackMin = decodedData.phyAttackMin
    
    ---@private
    self.magicAttackMax = decodedData.magicAttackMax
    
    ---@private
    self.magicAttackMin = decodedData.magicAttackMin
    
    ---@private
    self.taoAttackMax = decodedData.taoAttackMax
    
    ---@private
    self.taoAttackMin = decodedData.taoAttackMin
    
    ---@private
    self.phyDefenceMaxByCareer = decodedData.phyDefenceMaxByCareer
    
    ---@private
    self.phyDefenceMinByCareer = decodedData.phyDefenceMinByCareer
    
    ---@private
    self.magicDefenceMaxByCareer = decodedData.magicDefenceMaxByCareer
    
    ---@private
    self.magicDefenceMinByCareer = decodedData.magicDefenceMinByCareer
    
    ---@private
    self.holyAttackMax = decodedData.holyAttackMax
    
    ---@private
    self.holyAttackMin = decodedData.holyAttackMin
    
    ---@private
    self.holyDefenceMax = decodedData.holyDefenceMax
    
    ---@private
    self.holyDefenceMin = decodedData.holyDefenceMin
    
    ---@private
    self.criticalDamage = decodedData.criticalDamage
    
    ---@private
    self.smeltExp = decodedData.smeltExp
    
    ---@private
    self.smeltItem = decodedData.smeltItem
    
    ---@private
    self.isUse = decodedData.isUse
    
    ---@private
    self.type = decodedData.type
end

return cfg_bloodsuit