--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_boss_task
local cfg_boss_task = {}

cfg_boss_task.__index = cfg_boss_task

function cfg_boss_task:UUID()
    return self.id
end

---@return number id#客户端#C
function cfg_boss_task:GetId()
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

---@return number 转生等级限制#客户端  根据对应转生等级进行配置关联cfg_conditions
function cfg_boss_task:GetLevelCondition()
    if self.levelCondition ~= nil then
        return self.levelCondition
    else
        if self:CsTABLE() ~= nil then
            self.levelCondition = self:CsTABLE().levelCondition
            return self.levelCondition
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 怪物地图库ID#客户端  对应怪物地图库ID关联cfg_boss_map
function cfg_boss_task:GetBossMap()
    if self.bossMap ~= nil then
        return self.bossMap
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().bossMap
        else
            return nil
        end
    end
end

---@return number 任务目标次数#客户端  完成击杀目标的任务次数
function cfg_boss_task:GetTime()
    if self.time ~= nil then
        return self.time
    else
        if self:CsTABLE() ~= nil then
            self.time = self:CsTABLE().time
            return self.time
        else
            return nil
        end
    end
end

---@return string 任务目标奖励#客户端  任务完成后的奖励 conditionid_物品id#数量&下一个condition
function cfg_boss_task:GetRewards()
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

---@return string 策划备注#客户端
function cfg_boss_task:GetRemark()
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

---@return number 是否可进行扫荡#客户端  p判断是否可进行扫荡默认为0 可扫荡为1
function cfg_boss_task:GetCompletion()
    if self.completion ~= nil then
        return self.completion
    else
        if self:CsTABLE() ~= nil then
            self.completion = self:CsTABLE().completion
            return self.completion
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 扫荡消耗道具#客户端  道具id#数量
function cfg_boss_task:GetCompletionItem()
    if self.completionItem ~= nil then
        return self.completionItem
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().completionItem
        else
            return nil
        end
    end
end

---@return string 双倍奖励钻石消耗#客户端  双倍奖励消耗天数以及数量conditionid_物品id#数量&下一个condition
function cfg_boss_task:GetConsume()
    if self.consume ~= nil then
        return self.consume
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().consume
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_BOSS_TASK C#中的数据结构
function cfg_boss_task:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_boss_task lua中的数据结构
function cfg_boss_task:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.levelCondition = decodedData.levelCondition
    
    ---@private
    self.bossMap = decodedData.bossMap
    
    ---@private
    self.time = decodedData.time
    
    ---@private
    self.rewards = decodedData.rewards
    
    ---@private
    self.remark = decodedData.remark
    
    ---@private
    self.completion = decodedData.completion
    
    ---@private
    self.completionItem = decodedData.completionItem
    
    ---@private
    self.consume = decodedData.consume
end

return cfg_boss_task