--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_cum_recharge
local cfg_cum_recharge = {}

cfg_cum_recharge.__index = cfg_cum_recharge

function cfg_cum_recharge:UUID()
    return self.id
end

---@return number id#客户端#C  12位组数+345位id
function cfg_cum_recharge:GetId()
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

---@return number 本轮周期#客户端#C  这一轮的最长持续周期（天）
function cfg_cum_recharge:GetPeriod()
    if self.period ~= nil then
        return self.period
    else
        if self:CsTABLE() ~= nil then
            self.period = self:CsTABLE().period
            return self.period
        else
            return nil
        end
    end
end

---@return number 下一轮间隔时间#客户端#C  这一轮结束后下一轮开启的间隔天数
function cfg_cum_recharge:GetInterval()
    if self.interval ~= nil then
        return self.interval
    else
        if self:CsTABLE() ~= nil then
            self.interval = self:CsTABLE().interval
            return self.interval
        else
            return nil
        end
    end
end

---@return number 组id#客户端  从第1组开始，到最后一组结束
function cfg_cum_recharge:GetGroup()
    if self.group ~= nil then
        return self.group
    else
        if self:CsTABLE() ~= nil then
            self.group = self:CsTABLE().group
            return self.group
        else
            return nil
        end
    end
end

---@return number 子id#客户端  每组内单独的排序id
function cfg_cum_recharge:GetSmallId()
    if self.smallId ~= nil then
        return self.smallId
    else
        if self:CsTABLE() ~= nil then
            self.smallId = self:CsTABLE().smallId
            return self.smallId
        else
            return nil
        end
    end
end

---@return number 充值金额#客户端  活动期间累充多少钻石可领取奖励
function cfg_cum_recharge:GetRechargePoint()
    if self.rechargePoint ~= nil then
        return self.rechargePoint
    else
        if self:CsTABLE() ~= nil then
            self.rechargePoint = self:CsTABLE().rechargePoint
            return self.rechargePoint
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 奖励#客户端  达成后可领的奖励,itemId#num&itemId#num....
function cfg_cum_recharge:GetReward()
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

---@return TABLE.IntListJingHao 宝箱类型#客户端  是否展示宝箱内容
function cfg_cum_recharge:GetBoxId()
    if self.boxId ~= nil then
        return self.boxId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().boxId
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_CUM_RECHARGE C#中的数据结构
function cfg_cum_recharge:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_cum_recharge lua中的数据结构
function cfg_cum_recharge:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.group = decodedData.group
    
    ---@private
    self.smallId = decodedData.smallId
    
    ---@private
    self.rechargePoint = decodedData.rechargePoint
    
    ---@private
    self.reward = decodedData.reward
    
    ---@private
    self.boxId = decodedData.boxId
end

return cfg_cum_recharge