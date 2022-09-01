--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_bloodsuit_lattice
local cfg_bloodsuit_lattice = {}

cfg_bloodsuit_lattice.__index = cfg_bloodsuit_lattice

function cfg_bloodsuit_lattice:UUID()
    return self.id
end

---@return number 格子id#客户端  格子的id=300000+血继套装Type*100+pos（pos：1~8 是灵兽，9~12 是肉身装备）
function cfg_bloodsuit_lattice:GetId()
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

---@return number 类型#客户端  与cfg_bloodsuit_combination表对应
function cfg_bloodsuit_lattice:GetType()
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

---@return TABLE.IntListJingHao 开启条件#客户端  开启条件
function cfg_bloodsuit_lattice:GetCondition()
    if self.condition ~= nil then
        return self.condition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().condition
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 开启消耗#客户端  itemid#数量&itemid#数量&
function cfg_bloodsuit_lattice:GetCost()
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

--@return  TABLE.CFG_BLOODSUIT_LATTICE C#中的数据结构
function cfg_bloodsuit_lattice:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_bloodsuit_lattice lua中的数据结构
function cfg_bloodsuit_lattice:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.type = decodedData.type
    
    ---@private
    self.condition = decodedData.condition
    
    ---@private
    self.cost = decodedData.cost
end

return cfg_bloodsuit_lattice