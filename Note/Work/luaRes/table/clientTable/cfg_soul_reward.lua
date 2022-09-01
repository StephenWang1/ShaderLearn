--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_soul_reward
local cfg_soul_reward = {}

cfg_soul_reward.__index = cfg_soul_reward

function cfg_soul_reward:UUID()
    return self.id
end

---@return number id#客户端#C  编号
function cfg_soul_reward:GetId()
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

---@return TABLE.IntListList 奖励道具ID#客户端  道具ID
function cfg_soul_reward:GetItemId()
    if self.itemId ~= nil then
        return self.itemId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().itemId
        else
            return nil
        end
    end
end

---@return number 概率角标判定#客户端  需要道具显示角标的判定（默认0不显示 1显示）
function cfg_soul_reward:GetRewardIcon()
    if self.rewardIcon ~= nil then
        return self.rewardIcon
    else
        if self:CsTABLE() ~= nil then
            self.rewardIcon = self:CsTABLE().rewardIcon
            return self.rewardIcon
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_SOUL_REWARD C#中的数据结构
function cfg_soul_reward:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_soul_reward lua中的数据结构
function cfg_soul_reward:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.itemId = decodedData.itemId
    
    ---@private
    self.rewardIcon = decodedData.rewardIcon
end

return cfg_soul_reward