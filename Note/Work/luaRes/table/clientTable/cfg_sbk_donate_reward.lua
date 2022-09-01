--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_sbk_donate_reward
local cfg_sbk_donate_reward = {}

cfg_sbk_donate_reward.__index = cfg_sbk_donate_reward

function cfg_sbk_donate_reward:UUID()
    return self.id
end

---@return number 排名#客户端  排名：0代表保底奖励
function cfg_sbk_donate_reward:GetId()
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

---@return TABLE.IntListJingHao 加成效果#客户端  加成效果
function cfg_sbk_donate_reward:GetBuffer()
    if self.buffer ~= nil then
        return self.buffer
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().buffer
        else
            return nil
        end
    end
end

---@return string 排名效果描述#客户端  排名效果描述
function cfg_sbk_donate_reward:GetTips()
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

--@return  TABLE.CFG_SBK_DONATE_REWARD C#中的数据结构
function cfg_sbk_donate_reward:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_sbk_donate_reward lua中的数据结构
function cfg_sbk_donate_reward:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.buffer = decodedData.buffer
    
    ---@private
    self.tips = decodedData.tips
end

return cfg_sbk_donate_reward