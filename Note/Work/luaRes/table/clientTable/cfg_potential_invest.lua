--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_potential_invest
local cfg_potential_invest = {}

cfg_potential_invest.__index = cfg_potential_invest

function cfg_potential_invest:UUID()
    return self.id
end

---@return number id#客户端  递增
function cfg_potential_invest:GetId()
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

---@return number 投资类型#客户端  1=石化，2=诅咒，3=极速
function cfg_potential_invest:GetType()
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

---@return number 奖励条件#客户端  索引condition
function cfg_potential_invest:GetCondition()
    if self.condition ~= nil then
        return self.condition
    else
        if self:CsTABLE() ~= nil then
            self.condition = self:CsTABLE().condition
            return self.condition
        else
            return nil
        end
    end
end

---@return string 奖励内容#客户端  itemId#数量#职业#性别&
function cfg_potential_invest:GetReward()
    if self.reward ~= nil then
        return self.reward
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().reward
        else
            return nil
        end
    end
end

---@return string 奖励说明#客户端
function cfg_potential_invest:GetDescription()
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

--@return  TABLE.CFG_POTENTIAL_INVEST C#中的数据结构
function cfg_potential_invest:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_potential_invest lua中的数据结构
function cfg_potential_invest:Init(decodedData)
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
    self.reward = decodedData.reward
    
    ---@private
    self.description = decodedData.description
end

return cfg_potential_invest