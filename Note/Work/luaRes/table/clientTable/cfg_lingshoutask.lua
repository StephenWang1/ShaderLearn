--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_lingshoutask
local cfg_lingshoutask = {}

cfg_lingshoutask.__index = cfg_lingshoutask

function cfg_lingshoutask:UUID()
    return self.ID
end

---@return number 类型#客户端#C#不存在共同参与合并的字段  奖励ID
function cfg_lingshoutask:GetID()
    if self.ID ~= nil then
        return self.ID
    else
        if self:CsTABLE() ~= nil then
            self.ID = self:CsTABLE().ID
            return self.ID
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 任务目标#客户端#C  对应cfg_taskGoal
function cfg_lingshoutask:GetTaskGoalId()
    if self.taskGoalId ~= nil then
        return self.taskGoalId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().taskGoalId
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 奖励#客户端#C  任务奖励
function cfg_lingshoutask:GetRewards()
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

---@return number 任务类型#客户端#C  1挖掘boss 2回收装备次数 3交易行买卖次数 4装备行兑换次数 5装备升星次数 6合成物品次数
function cfg_lingshoutask:GetTaskType()
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

---@return string 任务描述#客户端#C  描述
function cfg_lingshoutask:GetTaskInfo()
    if self.taskInfo ~= nil then
        return self.taskInfo
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().taskInfo
        else
            return nil
        end
    end
end

---@return string 跳转界面#客户端#C  cfg_jump
function cfg_lingshoutask:GetUipanel()
    if self.uipanel ~= nil then
        return self.uipanel
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().uipanel
        else
            return nil
        end
    end
end

---@return number 跳转条件#客户端#C  cfg_conditions
function cfg_lingshoutask:GetConditions()
    if self.conditions ~= nil then
        return self.conditions
    else
        if self:CsTABLE() ~= nil then
            self.conditions = self:CsTABLE().conditions
            return self.conditions
        else
            return nil
        end
    end
end

---@return string 气泡ID#客户端#C  cfg_promptframe
function cfg_lingshoutask:GetBubbleID()
    if self.bubbleID ~= nil then
        return self.bubbleID
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().bubbleID
        else
            return nil
        end
    end
end

---@return number 秘籍#客户端#C#不存在共同参与合并的字段  跳转秘籍表
function cfg_lingshoutask:GetSecret()
    if self.secret ~= nil then
        return self.secret
    else
        if self:CsTABLE() ~= nil then
            self.secret = self:CsTABLE().secret
            return self.secret
        else
            return nil
        end
    end
end

---@return string 进度tips#客户端#C  进度描述
function cfg_lingshoutask:GetTips()
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

---@return number 章节_C
function cfg_lingshoutask:GetSection()
    if self.section ~= nil then
        return self.section
    else
        if self:CsTABLE() ~= nil then
            self.section = self:CsTABLE().section
            return self.section
        else
            return nil
        end
    end
end
---@return number 跳转类型_C
function cfg_lingshoutask:GetJumptype()
    if self.jumptype ~= nil then
        return self.jumptype
    else
        if self:CsTABLE() ~= nil then
            self.jumptype = self:CsTABLE().jumptype
            return self.jumptype
        else
            return nil
        end
    end
end

---@return string 左侧描述#客户端  左侧描述
function cfg_lingshoutask:GetRemark()
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

---@return string 任务框位置#客户端  底图bg#x#y#底图翻转#底图偏移
function cfg_lingshoutask:GetUnitParam()
    if self.unitParam ~= nil then
        return self.unitParam
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().unitParam
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 怪物头像#客户端  资源id
function cfg_lingshoutask:GetHead()
    if self.head ~= nil then
        return self.head
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().head
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_LINGSHOUTASK C#中的数据结构
function cfg_lingshoutask:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_LingShouTaskTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_lingshoutask lua中的数据结构
function cfg_lingshoutask:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.ID = decodedData.ID
    
    ---@private
    self.remark = decodedData.remark
    
    ---@private
    self.unitParam = decodedData.unitParam
    
    ---@private
    self.head = decodedData.head
end

return cfg_lingshoutask