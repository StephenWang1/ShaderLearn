--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_invest
local cfg_invest = {}

cfg_invest.__index = cfg_invest

function cfg_invest:UUID()
    return self.id
end

---@return number id#客户端  递增
function cfg_invest:GetId()
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

---@return number 投资期数#客户端
function cfg_invest:GetTurn()
    if self.turn ~= nil then
        return self.turn
    else
        if self:CsTABLE() ~= nil then
            self.turn = self:CsTABLE().turn
            return self.turn
        else
            return nil
        end
    end
end

---@return string 按钮名称#客户端  1期投资
function cfg_invest:GetName()
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

---@return number 奖励排序#客户端  奖励排序
function cfg_invest:GetOrder()
    if self.order ~= nil then
        return self.order
    else
        if self:CsTABLE() ~= nil then
            self.order = self:CsTABLE().order
            return self.order
        else
            return nil
        end
    end
end

---@return number 奖励类型#客户端  1=开服天数；2=开服天数#等级
function cfg_invest:GetRewardType()
    if self.rewardType ~= nil then
        return self.rewardType
    else
        if self:CsTABLE() ~= nil then
            self.rewardType = self:CsTABLE().rewardType
            return self.rewardType
        else
            return nil
        end
    end
end

---@return string 奖励领取条件#客户端  数值，具体含义根据类型判断
function cfg_invest:GetRewardCondition()
    if self.rewardCondition ~= nil then
        return self.rewardCondition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().rewardCondition
        else
            return nil
        end
    end
end

---@return string 奖励内容#客户端  itemId#数量#职业#性别
function cfg_invest:GetReward()
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
function cfg_invest:GetDescription()
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

---@return number 关联id#客户端  关联id
function cfg_invest:GetLink()
    if self.link ~= nil then
        return self.link
    else
        if self:CsTABLE() ~= nil then
            self.link = self:CsTABLE().link
            return self.link
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_INVEST C#中的数据结构
function cfg_invest:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_invest lua中的数据结构
function cfg_invest:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.turn = decodedData.turn
    
    ---@private
    self.name = decodedData.name
    
    ---@private
    self.order = decodedData.order
    
    ---@private
    self.rewardType = decodedData.rewardType
    
    ---@private
    self.rewardCondition = decodedData.rewardCondition
    
    ---@private
    self.reward = decodedData.reward
    
    ---@private
    self.description = decodedData.description
    
    ---@private
    self.link = decodedData.link
end

return cfg_invest