--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_linkeffect
local cfg_linkeffect = {}

cfg_linkeffect.__index = cfg_linkeffect

function cfg_linkeffect:UUID()
    return self.id
end

---@return number id#客户端#C
function cfg_linkeffect:GetId()
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

---@return number 子类型#客户端  1.青铜器 2.陶器 3.瓷器 4.玉器 5.金银器 6.法器
function cfg_linkeffect:GetSubType()
    if self.subType ~= nil then
        return self.subType
    else
        if self:CsTABLE() ~= nil then
            self.subType = self:CsTABLE().subType
            return self.subType
        else
            return nil
        end
    end
end

---@return string 小图标#客户端  在藏品阁里显示的图标名称
function cfg_linkeffect:GetIcon()
    if self.icon ~= nil then
        return self.icon
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().icon
        else
            return nil
        end
    end
end

---@return string 大图标#客户端  用于tips里显示的图标名称
function cfg_linkeffect:GetTipIcon()
    if self.tipIcon ~= nil then
        return self.tipIcon
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().tipIcon
        else
            return nil
        end
    end
end

---@return string 类型名称#客户端
function cfg_linkeffect:GetTipName()
    if self.tipName ~= nil then
        return self.tipName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().tipName
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 连锁道具#客户端  连锁属性的道具ID，道具id#道具id#道具id
function cfg_linkeffect:GetLinkItem()
    if self.linkItem ~= nil then
        return self.linkItem
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().linkItem
        else
            return nil
        end
    end
end

---@return string 连锁名称#客户端  连锁属性的名字
function cfg_linkeffect:GetDescription()
    if self.description ~= nil then
        return self.description
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().description
        else
            return nil
        end
    end
end

---@return number 最小物攻#客户端  属性
function cfg_linkeffect:GetPhyAttMin()
    if self.phyAttMin ~= nil then
        return self.phyAttMin
    else
        if self:CsTABLE() ~= nil then
            self.phyAttMin = self:CsTABLE().phyAttMin
            return self.phyAttMin
        else
            return nil
        end
    end
end

---@return number 最大物攻#客户端  属性
function cfg_linkeffect:GetPhyAttMax()
    if self.phyAttMax ~= nil then
        return self.phyAttMax
    else
        if self:CsTABLE() ~= nil then
            self.phyAttMax = self:CsTABLE().phyAttMax
            return self.phyAttMax
        else
            return nil
        end
    end
end

---@return number 最小魔攻#客户端  属性
function cfg_linkeffect:GetMagicAttMin()
    if self.magicAttMin ~= nil then
        return self.magicAttMin
    else
        if self:CsTABLE() ~= nil then
            self.magicAttMin = self:CsTABLE().magicAttMin
            return self.magicAttMin
        else
            return nil
        end
    end
end

---@return number 最大魔攻#客户端  属性
function cfg_linkeffect:GetMagicAttMax()
    if self.magicAttMax ~= nil then
        return self.magicAttMax
    else
        if self:CsTABLE() ~= nil then
            self.magicAttMax = self:CsTABLE().magicAttMax
            return self.magicAttMax
        else
            return nil
        end
    end
end

---@return number 最小道攻#客户端  属性
function cfg_linkeffect:GetTaoAttMin()
    if self.taoAttMin ~= nil then
        return self.taoAttMin
    else
        if self:CsTABLE() ~= nil then
            self.taoAttMin = self:CsTABLE().taoAttMin
            return self.taoAttMin
        else
            return nil
        end
    end
end

---@return number 最大道攻#客户端  属性
function cfg_linkeffect:GetTaoAttMax()
    if self.taoAttMax ~= nil then
        return self.taoAttMax
    else
        if self:CsTABLE() ~= nil then
            self.taoAttMax = self:CsTABLE().taoAttMax
            return self.taoAttMax
        else
            return nil
        end
    end
end

---@return number 最小物防#客户端  属性
function cfg_linkeffect:GetPhyDefMin()
    if self.phyDefMin ~= nil then
        return self.phyDefMin
    else
        if self:CsTABLE() ~= nil then
            self.phyDefMin = self:CsTABLE().phyDefMin
            return self.phyDefMin
        else
            return nil
        end
    end
end

---@return number 最大物防#客户端  属性
function cfg_linkeffect:GetPhyDefMax()
    if self.phyDefMax ~= nil then
        return self.phyDefMax
    else
        if self:CsTABLE() ~= nil then
            self.phyDefMax = self:CsTABLE().phyDefMax
            return self.phyDefMax
        else
            return nil
        end
    end
end

---@return number 最小魔防#客户端  属性
function cfg_linkeffect:GetMagicDefMin()
    if self.magicDefMin ~= nil then
        return self.magicDefMin
    else
        if self:CsTABLE() ~= nil then
            self.magicDefMin = self:CsTABLE().magicDefMin
            return self.magicDefMin
        else
            return nil
        end
    end
end

---@return number 最大魔法防御#客户端  属性
function cfg_linkeffect:GetMagicDefMax()
    if self.magicDefMax ~= nil then
        return self.magicDefMax
    else
        if self:CsTABLE() ~= nil then
            self.magicDefMax = self:CsTABLE().magicDefMax
            return self.magicDefMax
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 生命值#客户端  属性，1战士&2法师&3道士
function cfg_linkeffect:GetHp()
    if self.hp ~= nil then
        return self.hp
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().hp
        else
            return nil
        end
    end
end

---@return number 魔法值#客户端  属性
function cfg_linkeffect:GetMp()
    if self.mp ~= nil then
        return self.mp
    else
        if self:CsTABLE() ~= nil then
            self.mp = self:CsTABLE().mp
            return self.mp
        else
            return nil
        end
    end
end

---@return number 闪避#客户端  属性
function cfg_linkeffect:GetDodge()
    if self.dodge ~= nil then
        return self.dodge
    else
        if self:CsTABLE() ~= nil then
            self.dodge = self:CsTABLE().dodge
            return self.dodge
        else
            return nil
        end
    end
end

---@return number 精准#客户端  属性
function cfg_linkeffect:GetAccurate()
    if self.accurate ~= nil then
        return self.accurate
    else
        if self:CsTABLE() ~= nil then
            self.accurate = self:CsTABLE().accurate
            return self.accurate
        else
            return nil
        end
    end
end

---@return number 暴击率#客户端  属性（万分比）
function cfg_linkeffect:GetCritical()
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

---@return number 抗暴#客户端  属性（万分比）
function cfg_linkeffect:GetResistanceCrit()
    if self.resistanceCrit ~= nil then
        return self.resistanceCrit
    else
        if self:CsTABLE() ~= nil then
            self.resistanceCrit = self:CsTABLE().resistanceCrit
            return self.resistanceCrit
        else
            return nil
        end
    end
end

---@return number 最小切割伤害#客户端  属性
function cfg_linkeffect:GetHolyAttackMin()
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

---@return number 最大切割伤害#客户端  属性
function cfg_linkeffect:GetHolyAttackMax()
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

---@return number 展示暴击#客户端  显示暴击数值（假数值万分比）
function cfg_linkeffect:GetShowCritical()
    if self.showCritical ~= nil then
        return self.showCritical
    else
        if self:CsTABLE() ~= nil then
            self.showCritical = self:CsTABLE().showCritical
            return self.showCritical
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_LINKEFFECT C#中的数据结构
function cfg_linkeffect:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_linkeffect lua中的数据结构
function cfg_linkeffect:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.subType = decodedData.subType
    
    ---@private
    self.icon = decodedData.icon
    
    ---@private
    self.tipIcon = decodedData.tipIcon
    
    ---@private
    self.tipName = decodedData.tipName
    
    ---@private
    self.linkItem = decodedData.linkItem
    
    ---@private
    self.description = decodedData.description
    
    ---@private
    self.phyAttMin = decodedData.phyAttMin
    
    ---@private
    self.phyAttMax = decodedData.phyAttMax
    
    ---@private
    self.magicAttMin = decodedData.magicAttMin
    
    ---@private
    self.magicAttMax = decodedData.magicAttMax
    
    ---@private
    self.taoAttMin = decodedData.taoAttMin
    
    ---@private
    self.taoAttMax = decodedData.taoAttMax
    
    ---@private
    self.phyDefMin = decodedData.phyDefMin
    
    ---@private
    self.phyDefMax = decodedData.phyDefMax
    
    ---@private
    self.magicDefMin = decodedData.magicDefMin
    
    ---@private
    self.magicDefMax = decodedData.magicDefMax
    
    ---@private
    self.hp = decodedData.hp
    
    ---@private
    self.mp = decodedData.mp
    
    ---@private
    self.dodge = decodedData.dodge
    
    ---@private
    self.accurate = decodedData.accurate
    
    ---@private
    self.critical = decodedData.critical
    
    ---@private
    self.resistanceCrit = decodedData.resistanceCrit
    
    ---@private
    self.holyAttackMin = decodedData.holyAttackMin
    
    ---@private
    self.holyAttackMax = decodedData.holyAttackMax
    
    ---@private
    self.showCritical = decodedData.showCritical
end

return cfg_linkeffect