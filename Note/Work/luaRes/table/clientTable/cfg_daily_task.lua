--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_daily_task
local cfg_daily_task = {}

cfg_daily_task.__index = cfg_daily_task

function cfg_daily_task:UUID()
    return self.id
end

---@return number id#客户端#C
function cfg_daily_task:GetId()
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

---@return number 类型#客户端#C  日常任务子类型
function cfg_daily_task:GetTaskType()
    if self.taskType ~= nil then
        return self.taskType
    else
        if self:CsTABLE() ~= nil then
            self.taskType = self:CsTABLE().taskType
            return self.taskType
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 等级#客户端#C  下限#上限
function cfg_daily_task:GetLevel()
    if self.level ~= nil then
        return self.level
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().level
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 天数#客户端#C  开服天数（同一类型不可重复，需要连续）
function cfg_daily_task:GetTime()
    if self.time ~= nil then
        return self.time
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().time
        else
            return nil
        end
    end
end

---@return string 策划备注#客户端#C
function cfg_daily_task:GetRemark()
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

---@return TABLE.IntListList 目标道具#客户端#C  目标道具四选几&目标道具id&0
function cfg_daily_task:GetItems()
    if self.items ~= nil then
        return self.items
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().items
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 道具数量1#客户端#C  与目标道具一一对应（#隔开）&隔开不同道具数量）
function cfg_daily_task:GetCount1()
    if self.count1 ~= nil then
        return self.count1
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().count1
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 权重#客户端#C  一天目标道具随机的权重
function cfg_daily_task:GetWeight()
    if self.weight ~= nil then
        return self.weight
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().weight
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 道具数量3#客户端#C  目标总数固定时需要填
function cfg_daily_task:GetCount3()
    if self.count3 ~= nil then
        return self.count3
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().count3
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 奖励#客户端#C  道具id#数量&
function cfg_daily_task:GetRewards()
    if self.rewards ~= nil then
        return self.rewards
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().rewards
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 双倍领取#客户端#C  货币id#数量
function cfg_daily_task:GetTwice()
    if self.twice ~= nil then
        return self.twice
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().twice
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 购买任务#客户端#C  货币id#数量
function cfg_daily_task:GetBuy()
    if self.buy ~= nil then
        return self.buy
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().buy
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 三倍领取#客户端  货币id#数量
function cfg_daily_task:GetTreble()
    if self.treble ~= nil then
        return self.treble
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().treble
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_DAILY_TASK C#中的数据结构
function cfg_daily_task:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_Daily_TaskTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_daily_task lua中的数据结构
function cfg_daily_task:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.treble = decodedData.treble
end

return cfg_daily_task