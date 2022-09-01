--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_bloodsuit_level
local cfg_bloodsuit_level = {}

cfg_bloodsuit_level.__index = cfg_bloodsuit_level

function cfg_bloodsuit_level:UUID()
    return self.level
end

---@return number 等级#客户端  等级
function cfg_bloodsuit_level:GetLevel()
    if self.level ~= nil then
        return self.level
    else
        if self:CsTABLE() ~= nil then
            self.level = self:CsTABLE().level
            return self.level
        else
            return nil
        end
    end
end

---@return number 升到该级需求经验#客户端  升到该级需求经验
function cfg_bloodsuit_level:GetCost()
    if self.cost ~= nil then
        return self.cost
    else
        if self:CsTABLE() ~= nil then
            self.cost = self:CsTABLE().cost
            return self.cost
        else
            return nil
        end
    end
end

---@return number 熔炼可获得经验#客户端  熔炼可获得经验
function cfg_bloodsuit_level:GetSmeltExp()
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

---@return number 属性加成比例#客户端  万分比
function cfg_bloodsuit_level:GetParams()
    if self.params ~= nil then
        return self.params
    else
        if self:CsTABLE() ~= nil then
            self.params = self:CsTABLE().params
            return self.params
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_BLOODSUIT_LEVEL C#中的数据结构
function cfg_bloodsuit_level:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_bloodsuit_level lua中的数据结构
function cfg_bloodsuit_level:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.level = decodedData.level
    
    ---@private
    self.cost = decodedData.cost
    
    ---@private
    self.smeltExp = decodedData.smeltExp
    
    ---@private
    self.params = decodedData.params
end

return cfg_bloodsuit_level