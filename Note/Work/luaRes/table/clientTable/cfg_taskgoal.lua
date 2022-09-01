--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_taskgoal
local cfg_taskgoal = {}

cfg_taskgoal.__index = cfg_taskgoal

function cfg_taskgoal:UUID()
    return self.id
end

---@return number 任务目标id#客户端#C  本表唯一id后三位为序号，前1-2位位任务目标类型
function cfg_taskgoal:GetId()
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

---@return string 任务目标名称#客户端#C
function cfg_taskgoal:GetName()
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

---@return TABLE.IntListJingHao 任务目标数量参数#客户端#C  最少数量#最多数量
function cfg_taskgoal:GetTaskGoalCountParam()
    if self.taskGoalCountParam ~= nil then
        return self.taskGoalCountParam
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().taskGoalCountParam
        else
            return nil
        end
    end
end

---@return string 杂项参数#客户端#C  不同类型  配置参数不同  96  jumpid 104 jumpid
function cfg_taskgoal:GetGlobal()
    if self.global ~= nil then
        return self.global
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().global
        else
            return nil
        end
    end
end

---@return number 是否为采集目标#客户端#C#不存在共同参与合并的字段  0否，1是
function cfg_taskgoal:GetGatherTarget()
    if self.GatherTarget ~= nil then
        return self.GatherTarget
    else
        if self:CsTABLE() ~= nil then
            self.GatherTarget = self:CsTABLE().GatherTarget
            return self.GatherTarget
        else
            return nil
        end
    end
end

---@return string 任务目标描述#客户端#C
function cfg_taskgoal:GetDescription()
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

---@return number 任务目标类型_C
function cfg_taskgoal:GetTaskGoalType()
    if self.taskGoalType ~= nil then
        return self.taskGoalType
    else
        if self:CsTABLE() ~= nil then
            self.taskGoalType = self:CsTABLE().taskGoalType
            return self.taskGoalType
        else
            return nil
        end
    end
end
---@return number 任务目标参数_C
function cfg_taskgoal:GetTaskGoalParam()
    if self.taskGoalParam ~= nil then
        return self.taskGoalParam
    else
        if self:CsTABLE() ~= nil then
            self.taskGoalParam = self:CsTABLE().taskGoalParam
            return self.taskGoalParam
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_TASKGOAL C#中的数据结构
function cfg_taskgoal:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_TaskGoalTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_taskgoal lua中的数据结构
function cfg_taskgoal:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
end

return cfg_taskgoal