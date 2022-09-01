--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_skills_condition
local cfg_skills_condition = {}

cfg_skills_condition.__index = cfg_skills_condition

function cfg_skills_condition:UUID()
    return self.id
end

---@return number 唯一id#客户端#C  唯一id#客户端
function cfg_skills_condition:GetId()
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

---@return number 唯一ID#客户端#C#不存在共同参与合并的字段  定位用
function cfg_skills_condition:GetSid()
    if self.sid ~= nil then
        return self.sid
    else
        if self:CsTABLE() ~= nil then
            self.sid = self:CsTABLE().sid
            return self.sid
        else
            return nil
        end
    end
end

---@return string 技能升级消耗#客户端#C  道具id#道具数量(多个道具用&分隔)(升到下级所需)
function cfg_skills_condition:GetCost()
    if self.cost ~= nil then
        return self.cost
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().cost
        else
            return nil
        end
    end
end

---@return number 升级限制#客户端#C#不存在共同参与合并的字段  关联sfg_conditions表中ID ；&与 |或
function cfg_skills_condition:GetCondition()
    if self.condition ~= nil then
        return self.condition
    else
        if self:CsTABLE() ~= nil then
            self.condition = self:CsTABLE().condition
            return self.condition
        else
            return nil
        end
    end
end

---@return number 攻击倍率#客户端#C#不存在共同参与合并的字段  万分比
function cfg_skills_condition:GetRate()
    if self.rate ~= nil then
        return self.rate
    else
        if self:CsTABLE() ~= nil then
            self.rate = self:CsTABLE().rate
            return self.rate
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 技能BUFF状态#客户端#C  buffid#buffid#buffid
function cfg_skills_condition:GetBuffers()
    if self.buffers ~= nil then
        return self.buffers
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().buffers
        else
            return nil
        end
    end
end

---@return string 描述#客户端#C  技能学习条件描述1、&&代表固定颜色，当前等级黄色下一等级绿色2、正常颜色配置则按配置显示颜色
function cfg_skills_condition:GetShow()
    if self.show ~= nil then
        return self.show
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().show
        else
            return nil
        end
    end
end

---@return number 切割伤害#客户端#C#不存在共同参与合并的字段  数值
function cfg_skills_condition:GetHolyAttack()
    if self.holyAttack ~= nil then
        return self.holyAttack
    else
        if self:CsTABLE() ~= nil then
            self.holyAttack = self:CsTABLE().holyAttack
            return self.holyAttack
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 秘籍抵御技能的伤害万分比#客户端#C  万分比
function cfg_skills_condition:GetPassiveDamagePercent()
    if self.passiveDamagePercent ~= nil then
        return self.passiveDamagePercent
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().passiveDamagePercent
        else
            return nil
        end
    end
end

---@return number 冷却时间#客户端#C#不存在共同参与合并的字段  单位：毫秒
function cfg_skills_condition:GetCdTime()
    if self.cdTime ~= nil then
        return self.cdTime
    else
        if self:CsTABLE() ~= nil then
            self.cdTime = self:CsTABLE().cdTime
            return self.cdTime
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 抵御战士职业（计算伤害时增加防御）#客户端#C  具体防御值（先算随机防御值，在计算该数值）
function cfg_skills_condition:GetZsResist()
    if self.zsResist ~= nil then
        return self.zsResist
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().zsResist
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 抵御法师职业（计算伤害时增加防御）#客户端#C  具体防御值（先算随机防御值，在计算该数值）
function cfg_skills_condition:GetFsResist()
    if self.fsResist ~= nil then
        return self.fsResist
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().fsResist
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 抵御道士职业（计算伤害时增加防御）#客户端#C  具体防御值（先算随机防御值，在计算该数值）
function cfg_skills_condition:GetDsResist()
    if self.dsResist ~= nil then
        return self.dsResist
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().dsResist
        else
            return nil
        end
    end
end

---@return number 技能耗魔#客户端#C  技能耗魔
function cfg_skills_condition:GetCostMp()
    if self.costMp ~= nil then
        return self.costMp
    else
        if self:CsTABLE() ~= nil then
            self.costMp = self:CsTABLE().costMp
            return self.costMp
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 升级消耗对应的技能书id#客户端#C  升级消耗对应的技能书id
function cfg_skills_condition:GetCostBook()
    if self.costBook ~= nil then
        return self.costBook
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().costBook
        else
            return nil
        end
    end
end

---@return number skillId_C
function cfg_skills_condition:GetSkillId()
    if self.skillId ~= nil then
        return self.skillId
    else
        if self:CsTABLE() ~= nil then
            self.skillId = self:CsTABLE().skillId
            return self.skillId
        else
            return nil
        end
    end
end
---@return number 技能等级_C
function cfg_skills_condition:GetLevel()
    if self.level ~= nil then
        return self.level
    else
        if self:CsTABLE() ~= nil then
            self.level = self:CsTABLE().level
            return self.level
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 额外参数#客户端  1、召唤神兽骷髅：强化技能id#monsterid&强化技能id#monsterid
function cfg_skills_condition:GetAddedParam()
    if self.addedParam ~= nil then
        return self.addedParam
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().addedParam
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 元宝驯服次数和消耗#客户端  货币id#花费数量#总共次数
function cfg_skills_condition:GetTameTime()
    if self.tameTime ~= nil then
        return self.tameTime
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().tameTime
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_SKILLS_CONDITION C#中的数据结构
function cfg_skills_condition:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_SkillsConditionManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_skills_condition lua中的数据结构
function cfg_skills_condition:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.addedParam = decodedData.addedParam
    
    ---@private
    self.tameTime = decodedData.tameTime
end

return cfg_skills_condition