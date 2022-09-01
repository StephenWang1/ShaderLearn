--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_growth_weapon_class
local cfg_growth_weapon_class = {}

cfg_growth_weapon_class.__index = cfg_growth_weapon_class

function cfg_growth_weapon_class:UUID()
    return self.id
end

---@return number id#客户端
function cfg_growth_weapon_class:GetId()
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
function cfg_growth_weapon_class:GetType()
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

---@return number 突破后的道具id#客户端
function cfg_growth_weapon_class:GetItemid()
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

---@return number 装备等级#客户端
function cfg_growth_weapon_class:GetWeaponClass()
    if self.weaponClass ~= nil then
        return self.weaponClass
    else
        if self:CsTABLE() ~= nil then
            self.weaponClass = self:CsTABLE().weaponClass
            return self.weaponClass
        else
            return nil
        end
    end
end

---@return string 突破消耗#客户端
function cfg_growth_weapon_class:GetCost()
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

---@return string 突破消耗-元宝/钻石#客户端
function cfg_growth_weapon_class:GetCost2()
    if self.cost2 ~= nil then
        return self.cost2
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().cost2
        else
            return nil
        end
    end
end

---@return string 突破等级#客户端
function cfg_growth_weapon_class:GetNeedLevel()
    if self.needLevel ~= nil then
        return self.needLevel
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().needLevel
        else
            return nil
        end
    end
end

---@return string 策划备注#客户端
function cfg_growth_weapon_class:GetRemark()
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

---@return string 突破属性文本#客户端
function cfg_growth_weapon_class:GetAttributeTip()
    if self.attributeTip ~= nil then
        return self.attributeTip
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().attributeTip
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 升级表id#客户端
function cfg_growth_weapon_class:GetWeaponLevel()
    if self.weaponLevel ~= nil then
        return self.weaponLevel
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().weaponLevel
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_GROWTH_WEAPON_CLASS C#中的数据结构
function cfg_growth_weapon_class:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_growth_weapon_class lua中的数据结构
function cfg_growth_weapon_class:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.type = decodedData.type
    
    ---@private
    self.itemid = decodedData.itemid
    
    ---@private
    self.weaponClass = decodedData.weaponClass
    
    ---@private
    self.cost = decodedData.cost
    
    ---@private
    self.cost2 = decodedData.cost2
    
    ---@private
    self.needLevel = decodedData.needLevel
    
    ---@private
    self.remark = decodedData.remark
    
    ---@private
    self.attributeTip = decodedData.attributeTip
    
    ---@private
    self.weaponLevel = decodedData.weaponLevel
end

return cfg_growth_weapon_class