--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_bloodsuit_combination
local cfg_bloodsuit_combination = {}

cfg_bloodsuit_combination.__index = cfg_bloodsuit_combination

function cfg_bloodsuit_combination:UUID()
    return self.id
end

---@return number 编号#客户端  编号
function cfg_bloodsuit_combination:GetId()
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

---@return number 页签类型#客户端  页签类型
function cfg_bloodsuit_combination:GetType()
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

---@return string 页签名称#客户端  页签名称
function cfg_bloodsuit_combination:GetName()
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

---@return TABLE.IntListJingHao 页签开启条件#客户端  页签开启条件
function cfg_bloodsuit_combination:GetConditions()
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

---@return number 品级#客户端  0无品级要求(与bloodsuit表qualityLevel对应)
function cfg_bloodsuit_combination:GetQualityLevel()
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

---@return TABLE.IntListJingHao 套装技能#客户端  skill表id
function cfg_bloodsuit_combination:GetGroupSkill()
    if self.groupSkill ~= nil then
        return self.groupSkill
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().groupSkill
        else
            return nil
        end
    end
end

---@return string 套装名称#客户端  套装名称
function cfg_bloodsuit_combination:GetGroupName()
    if self.groupName ~= nil then
        return self.groupName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().groupName
        else
            return nil
        end
    end
end

---@return string 页签开启提示#客户端  页签开启提示
function cfg_bloodsuit_combination:GetTips()
    if self.tips ~= nil then
        return self.tips
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().tips
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_BLOODSUIT_COMBINATION C#中的数据结构
function cfg_bloodsuit_combination:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_bloodsuit_combination lua中的数据结构
function cfg_bloodsuit_combination:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.type = decodedData.type
    
    ---@private
    self.name = decodedData.name
    
    ---@private
    self.conditions = decodedData.conditions
    
    ---@private
    self.qualityLevel = decodedData.qualityLevel
    
    ---@private
    self.groupSkill = decodedData.groupSkill
    
    ---@private
    self.groupName = decodedData.groupName
    
    ---@private
    self.tips = decodedData.tips
end

return cfg_bloodsuit_combination