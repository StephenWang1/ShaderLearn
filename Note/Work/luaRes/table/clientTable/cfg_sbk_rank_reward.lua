--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_sbk_rank_reward
local cfg_sbk_rank_reward = {}

cfg_sbk_rank_reward.__index = cfg_sbk_rank_reward

function cfg_sbk_rank_reward:UUID()
    return self.id
end

---@return number 编号#客户端  编号
function cfg_sbk_rank_reward:GetId()
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

---@return TABLE.IntListJingHao 所需个人积分#客户端  个人总积分
function cfg_sbk_rank_reward:GetRank()
    if self.rank ~= nil then
        return self.rank
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().rank
        else
            return nil
        end
    end
end

---@return string 奖励#客户端  奖励
function cfg_sbk_rank_reward:GetReward()
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

--@return  TABLE.CFG_SBK_RANK_REWARD C#中的数据结构
function cfg_sbk_rank_reward:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_sbk_rank_reward lua中的数据结构
function cfg_sbk_rank_reward:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.rank = decodedData.rank
    
    ---@private
    self.reward = decodedData.reward
end

return cfg_sbk_rank_reward