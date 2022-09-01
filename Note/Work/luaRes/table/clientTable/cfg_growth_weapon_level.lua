--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_growth_weapon_level
local cfg_growth_weapon_level = {}

cfg_growth_weapon_level.__index = cfg_growth_weapon_level

function cfg_growth_weapon_level:UUID()
    return self.id
end

---@return number id#客户端
function cfg_growth_weapon_level:GetId()
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

---@return number 类型#客户端
function cfg_growth_weapon_level:GetType()
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

---@return number 装备等级#客户端
function cfg_growth_weapon_level:GetLevel()
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

---@return string 升级消耗#客户端
function cfg_growth_weapon_level:GetCost()
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

---@return string 升级条件#客户端
function cfg_growth_weapon_level:GetTaskgoal()
    if self.taskgoal ~= nil then
        return self.taskgoal
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().taskgoal
        else
            return nil
        end
    end
end

---@return string 策划备注#客户端
function cfg_growth_weapon_level:GetRemark()
    if self.remark ~= nil then
        return self.remark
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().remark
        else
            return nil
        end
    end
end

---@return number 套装属性#客户端
function cfg_growth_weapon_level:GetDivineSuit()
    if self.divineSuit ~= nil then
        return self.divineSuit
    else
        if self:CsTABLE() ~= nil then
            self.divineSuit = self:CsTABLE().divineSuit
            return self.divineSuit
        else
            return nil
        end
    end
end

---@return number 升级属性#客户端
function cfg_growth_weapon_level:GetExtra()
    if self.extra ~= nil then
        return self.extra
    else
        if self:CsTABLE() ~= nil then
            self.extra = self:CsTABLE().extra
            return self.extra
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_GROWTH_WEAPON_LEVEL C#中的数据结构
function cfg_growth_weapon_level:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_growth_weapon_level lua中的数据结构
function cfg_growth_weapon_level:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.type = decodedData.type
    
    ---@private
    self.level = decodedData.level
    
    ---@private
    self.cost = decodedData.cost
    
    ---@private
    self.taskgoal = decodedData.taskgoal
    
    ---@private
    self.remark = decodedData.remark
    
    ---@private
    self.divineSuit = decodedData.divineSuit
    
    ---@private
    self.extra = decodedData.extra
end

return cfg_growth_weapon_level