--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_sbk_reward_point
local cfg_sbk_reward_point = {}

cfg_sbk_reward_point.__index = cfg_sbk_reward_point

function cfg_sbk_reward_point:UUID()
    return self.id
end

---@return number 编号#客户端  编号
function cfg_sbk_reward_point:GetId()
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

---@return number 所需个人积分#客户端  个人总积分
function cfg_sbk_reward_point:GetPoint()
    if self.point ~= nil then
        return self.point
    else
        if self:CsTABLE() ~= nil then
            self.point = self:CsTABLE().point
            return self.point
        else
            return nil
        end
    end
end

---@return string 奖励#客户端  奖励
function cfg_sbk_reward_point:GetReward()
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

--@return  TABLE.CFG_SBK_REWARD_POINT C#中的数据结构
function cfg_sbk_reward_point:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_sbk_reward_point lua中的数据结构
function cfg_sbk_reward_point:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.point = decodedData.point
    
    ---@private
    self.reward = decodedData.reward
end

return cfg_sbk_reward_point