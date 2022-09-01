--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_expprop
local cfg_expprop = {}

cfg_expprop.__index = cfg_expprop

function cfg_expprop:UUID()
    return self.id
end

---@return number 唯一id#客户端  唯一标识id
function cfg_expprop:GetId()
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

---@return number 使用道具id#客户端
function cfg_expprop:GetItemId()
    if self.itemId ~= nil then
        return self.itemId
    else
        if self:CsTABLE() ~= nil then
            self.itemId = self:CsTABLE().itemId
            return self.itemId
        else
            return nil
        end
    end
end

---@return number 倍数#客户端
function cfg_expprop:GetMultiple()
    if self.multiple ~= nil then
        return self.multiple
    else
        if self:CsTABLE() ~= nil then
            self.multiple = self:CsTABLE().multiple
            return self.multiple
        else
            return nil
        end
    end
end

---@return string 消耗道具id#客户端  道具id#数量，不填或为0时需显示为免费兑换
function cfg_expprop:GetGoal()
    if self.goal ~= nil then
        return self.goal
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().goal
        else
            return nil
        end
    end
end

---@return string 限制条件#客户端  不填或为0时一直显示
function cfg_expprop:GetCondition()
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

--@return  TABLE.CFG_EXPPROP C#中的数据结构
function cfg_expprop:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_expprop lua中的数据结构
function cfg_expprop:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.itemId = decodedData.itemId
    
    ---@private
    self.multiple = decodedData.multiple
    
    ---@private
    self.goal = decodedData.goal
    
    ---@private
    self.condition = decodedData.condition
end

return cfg_expprop