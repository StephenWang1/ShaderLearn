--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_potential
local cfg_potential = {}

cfg_potential.__index = cfg_potential

function cfg_potential:UUID()
    return self.id
end

---@return number id#客户端#C#不存在共同参与合并的字段  编号
function cfg_potential:GetId()
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

---@return string 潜能名称#客户端  对应的潜能名称
function cfg_potential:GetName()
    if self.name ~= nil then
        return self.name
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().name
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 关联道具id#客户端  和潜能关联的道具id，格式：道具id#道具id 关联cfg_items
function cfg_potential:GetLinkItemId()
    if self.linkItemId ~= nil then
        return self.linkItemId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().linkItemId
        else
            return nil
        end
    end
end

---@return number buffid#客户端  关联的潜能buffid，关联配表cfg_buff
function cfg_potential:GetLinkBuffId()
    if self.linkBuffId ~= nil then
        return self.linkBuffId
    else
        if self:CsTABLE() ~= nil then
            self.linkBuffId = self:CsTABLE().linkBuffId
            return self.linkBuffId
        else
            return nil
        end
    end
end

---@return string 潜能类型#客户端  潜能类型1石化 2诅咒 3疾速
function cfg_potential:GetPotentialType()
    if self.potentialType ~= nil then
        return self.potentialType
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().potentialType
        else
            return nil
        end
    end
end

---@return number 潜能星级#客户端  潜能星级 0-10星
function cfg_potential:GetStage()
    if self.stage ~= nil then
        return self.stage
    else
        if self:CsTABLE() ~= nil then
            self.stage = self:CsTABLE().stage
            return self.stage
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 可升级条件#客户端  可升级条件，关联cfg_conditions表
function cfg_potential:GetConditions()
    if self.conditions ~= nil then
        return self.conditions
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().conditions
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 升级消耗#客户端  升级所需消耗，道具items#数量
function cfg_potential:GetCost()
    if self.cost ~= nil then
        return self.cost
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().cost
        else
            return nil
        end
    end
end

---@return number 最小攻击#客户端  最小攻击
function cfg_potential:GetAtt()
    if self.att ~= nil then
        return self.att
    else
        if self:CsTABLE() ~= nil then
            self.att = self:CsTABLE().att
            return self.att
        else
            return nil
        end
    end
end

---@return number 最大攻击#客户端  最大攻击
function cfg_potential:GetAttMax()
    if self.attMax ~= nil then
        return self.attMax
    else
        if self:CsTABLE() ~= nil then
            self.attMax = self:CsTABLE().attMax
            return self.attMax
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 血量#客户端  属性（1表示战士2表示法师3表示道士）1#100&2#200&3#300  &表示隔开 #代表对应职业血量
function cfg_potential:GetMaxHp()
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

---@return number 最小物理防御#客户端#不存在共同参与合并的字段  属性
function cfg_potential:GetPhyDefenceMin()
    if self.phyDefenceMin ~= nil then
        return self.phyDefenceMin
    else
        if self:CsTABLE() ~= nil then
            self.phyDefenceMin = self:CsTABLE().phyDefenceMin
            return self.phyDefenceMin
        else
            return nil
        end
    end
end

---@return number 最大物理防御#客户端#不存在共同参与合并的字段  属性
function cfg_potential:GetPhyDefenceMax()
    if self.phyDefenceMax ~= nil then
        return self.phyDefenceMax
    else
        if self:CsTABLE() ~= nil then
            self.phyDefenceMax = self:CsTABLE().phyDefenceMax
            return self.phyDefenceMax
        else
            return nil
        end
    end
end

---@return number 最小魔法防御#客户端#不存在共同参与合并的字段  属性
function cfg_potential:GetMagicDefenceMin()
    if self.magicDefenceMin ~= nil then
        return self.magicDefenceMin
    else
        if self:CsTABLE() ~= nil then
            self.magicDefenceMin = self:CsTABLE().magicDefenceMin
            return self.magicDefenceMin
        else
            return nil
        end
    end
end

---@return number 最大魔法防御#客户端#不存在共同参与合并的字段  属性
function cfg_potential:GetMagicDefenceMax()
    if self.magicDefenceMax ~= nil then
        return self.magicDefenceMax
    else
        if self:CsTABLE() ~= nil then
            self.magicDefenceMax = self:CsTABLE().magicDefenceMax
            return self.magicDefenceMax
        else
            return nil
        end
    end
end

---@return number 攻击速度#客户端  (仅客户端显示用)
function cfg_potential:GetSpeed()
    if self.speed ~= nil then
        return self.speed
    else
        if self:CsTABLE() ~= nil then
            self.speed = self:CsTABLE().speed
            return self.speed
        else
            return nil
        end
    end
end

---@return number 石化概率#客户端  (仅客户端显示用)
function cfg_potential:GetParalysisRate()
    if self.paralysisRate ~= nil then
        return self.paralysisRate
    else
        if self:CsTABLE() ~= nil then
            self.paralysisRate = self:CsTABLE().paralysisRate
            return self.paralysisRate
        else
            return nil
        end
    end
end

---@return number 石化怪物等级上限#客户端  (仅客户端显示用)
function cfg_potential:GetParalysisLevel()
    if self.paralysisLevel ~= nil then
        return self.paralysisLevel
    else
        if self:CsTABLE() ~= nil then
            self.paralysisLevel = self:CsTABLE().paralysisLevel
            return self.paralysisLevel
        else
            return nil
        end
    end
end

---@return number 降低回血效果#客户端  (仅客户端显示用)
function cfg_potential:GetDamnationRate()
    if self.DamnationRate ~= nil then
        return self.DamnationRate
    else
        if self:CsTABLE() ~= nil then
            self.DamnationRate = self:CsTABLE().DamnationRate
            return self.DamnationRate
        else
            return nil
        end
    end
end

---@return number 诅咒怪物等级上限#客户端  (仅客户端显示用)
function cfg_potential:GetDamnationLevel()
    if self.DamnationLevel ~= nil then
        return self.DamnationLevel
    else
        if self:CsTABLE() ~= nil then
            self.DamnationLevel = self:CsTABLE().DamnationLevel
            return self.DamnationLevel
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_POTENTIAL C#中的数据结构
function cfg_potential:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_potential lua中的数据结构
function cfg_potential:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.name = decodedData.name
    
    ---@private
    self.linkItemId = decodedData.linkItemId
    
    ---@private
    self.linkBuffId = decodedData.linkBuffId
    
    ---@private
    self.potentialType = decodedData.potentialType
    
    ---@private
    self.stage = decodedData.stage
    
    ---@private
    self.conditions = decodedData.conditions
    
    ---@private
    self.cost = decodedData.cost
    
    ---@private
    self.att = decodedData.att
    
    ---@private
    self.attMax = decodedData.attMax
    
    ---@private
    self.maxHp = decodedData.maxHp
    
    ---@private
    self.phyDefenceMin = decodedData.phyDefenceMin
    
    ---@private
    self.phyDefenceMax = decodedData.phyDefenceMax
    
    ---@private
    self.magicDefenceMin = decodedData.magicDefenceMin
    
    ---@private
    self.magicDefenceMax = decodedData.magicDefenceMax
    
    ---@private
    self.speed = decodedData.speed
    
    ---@private
    self.paralysisRate = decodedData.paralysisRate
    
    ---@private
    self.paralysisLevel = decodedData.paralysisLevel
    
    ---@private
    self.DamnationRate = decodedData.DamnationRate
    
    ---@private
    self.DamnationLevel = decodedData.DamnationLevel
end

return cfg_potential